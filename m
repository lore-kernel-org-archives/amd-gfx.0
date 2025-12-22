Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0A3E677EC
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA56A10E6BE;
	Mon, 22 Dec 2025 15:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZv/BtyJ";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087B710E5CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:25:42 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so31658295ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391941; x=1766996741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrG1isq17Lyb0bJFCu5jKcbVF320nGGDAVNnMWnzxZY=;
 b=OZv/BtyJ0GVWZseJiMw4O7OhWSe6mxtr3Kug+drjvNSgqvoFSXOnolwz5ajpS7WtKV
 KCsPDKpp/irVC6ymItIG2OtW9mEa05gsQlXJDWq/J+0Z8fnusQ7k2ORif4+sNGkPRi7S
 ivevLBo5R+oCUVSdneQwlWWz1ZThZoDiT5y02sz7qrXjLasEJ5/0Xhq6/3D+iqS1MqH/
 hPQSA5mMPh9Kk5S92m8ycbk8PdLN2cY/JC061ZAmuioALJF3Gc8hRZSx4ZMpA24WE64r
 53dGmlFFfsVoywXZ6DQqd4QL2xH9cOLUYDMhhrOPtxT5Jm25tp7ElBt2sh73LhNkwTEG
 O7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391941; x=1766996741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FrG1isq17Lyb0bJFCu5jKcbVF320nGGDAVNnMWnzxZY=;
 b=QSNy6QUzEzDdnAWd2aLGj4zi9T1HnCuN5bkG7uCSA2LWYJwtUFbu0nCIxr0fdFfssT
 6qXnh0nizmzfnWspzB9jfaMRJbhxFwue5JOZkzL/X8vnl97WFdJKE0lhD9iTDHMh9QsL
 HFkV9CK3VCdwsoQwtnFEaWLZabQkPgD3hS7IU2UU0dE9PRs9yeJzuzJzzGejqqp5ts7p
 QxChL8wmhnycXMI1GzfdyzjPjjyqGhheJ0tGrqonUewBwuSywX8R/Q9ACf/Gtfvz13fz
 BJCMhCkOvBBZlPR7L6i4SWJVTe96eSxjXfIgORLvftDErQ/Nfh4aILtwgbcdkoaMNZXI
 Vwnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIVscRr06Vv+iDYRgkF54kOTtxuuTx/5FnDkFU+00h1Wyrald5G0+fu/VDlK/TIVL08pcTHQD/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw97leUDAgTfhDYXD0bfmgoeCGUlNpaX0uiiFs7Ca3B8xbnOaV8
 NA9p+KT+uVruQ69z7EZIliF7hwaFnFEI3diQBp93rZBQx+kD2espSdKP
X-Gm-Gg: AY/fxX5PzOuMwLBG57Ro8lcpJlBgZBw4J3etXqfQT6buhnvkBpiZM0S7D7d4Q4dbd4s
 iuAACkF+l6cnmUpMQsF2MKxfZh2TqGwYor2k5jgJ585o6I2ASvrp4USq5I8tXF6kATMOIJMhQS5
 QjTIUC0dTjXb0aXC6w8+bXBoTbRe/HNWRDZodWFc/XIY0VCNLQcymphrom/w+SyA4RLleeRcDPy
 xJUp3PEaTrNs+4iUcu6+R0njVCmLTkc3OkqU/OlTXwWXpB25a6MLVRIQmHuMa0U+ggS+LLWPO+s
 tV4UOOkfpt/sjSaO633ex7xN9w0qoBftrfw80XGti6LQdJ2C3A8idniz6+vW7tdXIx6IdDNRPOj
 NVKthnana19inRwbgQh4ePCJZD+6TgSr6sL+aiC+M33+Wi8sW8w9kP45JO/hjzocWjC2g9h3vOE
 vYpEeWMl1x
X-Google-Smtp-Source: AGHT+IFewFiHLSSMkteVB5+mJ427GMrWESNV1s0gzG1qZwVux0iZoGglO5KJ+zZHGWbOk0GOGu+BPQ==
X-Received: by 2002:a17:902:ea11:b0:290:91d2:9304 with SMTP id
 d9443c01a7336-2a2f22052f9mr107996865ad.4.1766391941481; 
 Mon, 22 Dec 2025 00:25:41 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:25:40 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, jbaron@akamai.com,
 gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 seanpaul@chromium.org, robdclark@gmail.com, groeck@google.com,
 yanivt@google.com, bleung@google.com, quic_saipraka@quicinc.com,
 will@kernel.org, catalin.marinas@arm.com, quic_psodagud@quicinc.com,
 maz@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, mingo@redhat.com, jim.cromie@gmail.com
Subject: [PATCH v7 24/31] dyndbg-test: change do_prints testpoint to accept a
 loopct
Date: Mon, 22 Dec 2025 21:20:41 +1300
Message-ID: <20251222082049.1782440-25-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082049.1782440-3-jim.cromie@gmail.com>
References: <20251222082049.1782440-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 15:34:03 +0000
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

echo 1000 > /sys/module/test_dynamic_debug/parameters/do_prints

This allows its use as a scriptable load generator, to generate
dynamic-prefix-emits for flag combinations vs undecorated messages.
This will make it easy to assess the cost of the prefixing.

Reading the ./do_prints node also prints messages (once) to the-log.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index b2bdfdfb6ba1..fa81177e8089 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -29,18 +29,25 @@
 
 #include <linux/module.h>
 
-/* re-gen output by reading or writing sysfs node: do_prints */
-
-static void do_prints(void); /* device under test */
+/* re-trigger debug output by reading or writing sysfs node: do_prints */
+static void do_prints(unsigned int); /* device under test */
 static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
 {
-	do_prints();
+	int rc;
+	unsigned int ct;
+
+	rc = kstrtouint(instr, 0, &ct);
+	if (rc) {
+		pr_err("expecting numeric input, using 1 instead\n");
+		ct = 1;
+	}
+	do_prints(ct);
 	return 0;
 }
 static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
 {
-	do_prints();
-	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+	do_prints(1);
+	return scnprintf(buffer, PAGE_SIZE, "did 1 do_prints\n");
 }
 static const struct kernel_param_ops param_ops_do_prints = {
 	.set = param_set_do_prints,
@@ -191,17 +198,20 @@ static void do_levels(void)
 	prdbg(V7);
 }
 
-static void do_prints(void)
+static void do_prints(unsigned int ct)
 {
-	pr_debug("do_prints:\n");
-	do_cats();
-	do_levels();
+	/* maybe clamp this */
+	pr_debug("do-prints %d times:\n", ct);
+	for (; ct; ct--) {
+		do_cats();
+		do_levels();
+	}
 }
 
 static int __init test_dynamic_debug_init(void)
 {
 	pr_debug("init start\n");
-	do_prints();
+	do_prints(1);
 	pr_debug("init done\n");
 	return 0;
 }
-- 
2.52.0

