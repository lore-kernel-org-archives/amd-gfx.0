Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE3DC3DA7A
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Dec 2022 19:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB2610E0EA;
	Sun, 25 Dec 2022 19:40:14 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A322F10E0EA
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Dec 2022 19:40:12 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id ay40so6665925wmb.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Dec 2022 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=81Qzt56uqUTTYiN7XGZEL0FZZ5igsYkPCbcExt0OB1M=;
 b=bFzu1W/Eo380jsp6DX9iPIaM6ZcNbLRdVuIe2xAJfxyuA2yKvLjdDHjq2j7ji5nP2G
 eOx3DDR2SHRAm8S41BtnwOrQmY1sxK0U25Ecd89HRMtvH9su6zGzDVTLFszle8xDdwJ2
 khmR3CRfBTUdMvm8jjVXZ8NAhxgZNEwRokoJZnotdfJgM3IUged1abMAWlWX2rynn8x4
 j5+SGaFRymoDVElgGhworGdvjru15iSomHL10vWCDKfhaOk38/SgSBEjrTtotCjn4VHH
 PBEOFcsFRC9s+WCUMC0bXZRs3KY9+pbgDKUKN21QgariCGVhWi9yCXzbqfMEjaENoo0x
 4T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=81Qzt56uqUTTYiN7XGZEL0FZZ5igsYkPCbcExt0OB1M=;
 b=kpe/B807+tCNUp8ICrF/sIf6HVS4jxtzhC2WA6mRRShQIYoSm5gXtqRfavVpRQ9nUE
 WGvIGYN0KE70durb6XSMnJfQ2zvrNjVGTAyQ00IKDJP5HZSySEFow3vsGnmIxSACLqYk
 0ygLsgWUZThIvMm/isGAm73qyRkK6HGvlRsvGkEvxUeAHFsSV9W/ov+y9ZRKoEeLGfGf
 O3pFEdBGy1vmg76Twk/ga5NHSN+2ZJH3eG6/bfByCX+27f5Ku2EIGeYVpjDsdog2LVvd
 leFKyhZPzgtpEIweR1n8HVLQnHx8OJXHYm7+hCmCWopedEFYtgLNhRafq0rujrR1j3w7
 4kWA==
X-Gm-Message-State: AFqh2krBHwtSdUZ6dNUgGQtw8WYR2fFhFqBIl3Aa4JGAQ+XTvMhuhPtK
 V3oypyh5G5QY02reF4GXO2yqYXaBb2f/8zoaIN4=
X-Google-Smtp-Source: AMrXdXtmvvKmNhGE7TQbRUiVmpwy7tyz+Ow0BlgMnKvBJZibTmnUQOgJsTiuIkMmaITnTNYhkGeM3HfQZlsMdOw5duM=
X-Received: by 2002:a05:600c:1c27:b0:3d1:eea7:e13d with SMTP id
 j39-20020a05600c1c2700b003d1eea7e13dmr985448wms.74.1671997210952; Sun, 25 Dec
 2022 11:40:10 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Sun, 25 Dec 2022 19:39:59 +0000
Message-ID: <CAEzXK1oghXAB_KpKpm=-CviDQbNaH0qfgYTSSjZgvvyj4U78AA@mail.gmail.com>
Subject: [PATCH] [RFC] drm/drm_buddy fails to initialize on 32-bit
 architectures
To: akpm@linux-foundation.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Re-sending with the correct  linux-kernel mailing list email address.
Sorry for the inconvenience.

The proposed patch fixes the issue and allows amdgpu to work again on
armhf with a AMD RX 550 card, however it may not be the best solution
for the issue, as detailed below.

include/log2.h defined macros rounddown_pow_of_two(...) and
roundup_pow_of_two(...) do not handle 64-bit values on 32-bit
architectures (tested on armv9 armhf machine) causing
drm_buddy_init(...) to fail on BUG_ON with an underflow on the order
value, thus impeding amdgpu to load properly (no GUI).

One option is to modify rounddown_pow_of_two(...) to detect if the
variable takes 32 bits or less and call __rounddown_pow_of_two_u32(u32
n) or if the variable takes more space than 32 bits, then call
__rounddown_pow_of_two_u64(u64 n). This would imply renaming
__rounddown_pow_of_two(unsigne
d long n) to
__rounddown_pow_of_two_u32(u32 n) and add a new function
__rounddown_pow_of_two_u64(u64 n). This would be the most transparent
solution, however there a few complications, and they are:
- that the mm subsystem will fail to link on armhf with an undefined
reference on __aeabi_uldivmod
- there a few drivers that directly call __rounddown_pow_of_two(...)
- that other drivers and subsystems generate warnings

So this alternate solution was devised which avoids touching existing
code paths, and just updates drm_buddy which seems to be the only
driver that is failing, however I am not sure if this is the proper
way to go. So I would like to get a second opinion on this, by those
who know.

/include/linux/log2.h
/drivers/gpu/drm/drm_buddy.c

Signed-off-by: Lu=C3=ADs Mendes <luis.p.mendes@gmail.com>
>8------------------------------------------------------8<
diff -uprN linux-next/drivers/gpu/drm/drm_buddy.c
linux-nextLM/drivers/gpu/drm/drm_buddy.c
--- linux-next/drivers/gpu/drm/drm_buddy.c    2022-12-25
16:29:26.000000000 +0000
+++ linux-nextLM/drivers/gpu/drm/drm_buddy.c    2022-12-25
17:04:32.136007116 +0000
@@ -128,7 +128,7 @@ int drm_buddy_init(struct drm_buddy *mm,
         unsigned int order;
         u64 root_size;

-        root_size =3D rounddown_pow_of_two(size);
+        root_size =3D rounddown_pow_of_two_u64(size);
         order =3D ilog2(root_size) - ilog2(chunk_size);

         root =3D drm_block_alloc(mm, NULL, order, offset);
diff -uprN linux-next/include/linux/log2.h linux-nextLM/include/linux/log2.=
h
--- linux-next/include/linux/log2.h    2022-12-25 16:29:29.000000000 +0000
+++ linux-nextLM/include/linux/log2.h    2022-12-25 17:00:34.319901492 +000=
0
@@ -58,6 +58,18 @@ unsigned long __roundup_pow_of_two(unsig
 }

 /**
+ * __roundup_pow_of_two_u64() - round up to nearest power of two
+ * (unsgined 64-bits precision version)
+ * @n: value to round up
+ */
+static inline __attribute__((const))
+u64 __roundup_pow_of_two_u64(u64 n)
+{
+    return 1ULL << fls64(n - 1);
+}
+
+
+/**
  * __rounddown_pow_of_two() - round down to nearest power of two
  * @n: value to round down
  */
@@ -68,6 +80,17 @@ unsigned long __rounddown_pow_of_two(uns
 }

 /**
+ * __rounddown_pow_of_two_u64() - round down to nearest power of two
+ * (unsgined 64-bits precision version)
+ * @n: value to round down
+ */
+static inline __attribute__((const))
+u64 __rounddown_pow_of_two_u64(u64 n)
+{
+    return 1ULL << (fls64(n) - 1);
+}
+
+/**
  * const_ilog2 - log base 2 of 32-bit or a 64-bit constant unsigned value
  * @n: parameter
  *
@@ -163,6 +186,7 @@ unsigned long __rounddown_pow_of_two(uns
     __ilog2_u64(n)            \
  )

+
 /**
  * roundup_pow_of_two - round the given value up to nearest power of two
  * @n: parameter
@@ -181,6 +205,25 @@ unsigned long __rounddown_pow_of_two(uns
  )

 /**
+ * roundup_pow_of_two_u64 - round the given value up to nearest power of t=
wo
+ * (unsgined 64-bits precision version)
+ * @n: parameter
+ *
+ * round the given value up to the nearest power of two
+ * - the result is undefined when n =3D=3D 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define roundup_pow_of_two_u64(n)            \
+(                        \
+    __builtin_constant_p(n) ? (        \
+        ((n) =3D=3D 1) ? 1 :        \
+        (1ULL << (ilog2((n) - 1) + 1))    \
+                   ) :        \
+    __roundup_pow_of_two_u64(n)            \
+ )
+
+
+/**
  * rounddown_pow_of_two - round the given value down to nearest power of t=
wo
  * @n: parameter
  *
@@ -195,6 +238,22 @@ unsigned long __rounddown_pow_of_two(uns
     __rounddown_pow_of_two(n)        \
  )

+/**
+ * rounddown_pow_of_two_u64 - round the given value down to nearest
power of two
+ * (unsgined 64-bits precision version)
+ * @n: parameter
+ *
+ * round the given value down to the nearest power of two
+ * - the result is undefined when n =3D=3D 0
+ * - this can be used to initialise global variables from constant data
+ */
+#define rounddown_pow_of_two_u64(n)            \
+(                        \
+    __builtin_constant_p(n) ? (        \
+        (1ULL << ilog2(n))) :        \
+    __rounddown_pow_of_two_u64(n)        \
+ )
+
 static inline __attribute_const__
 int __order_base_2(unsigned long n)
 {
