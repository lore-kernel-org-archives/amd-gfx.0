Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C02BC38145
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 21:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABBE10EB19;
	Tue,  6 Sep 2022 21:56:06 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D32810E2AC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 21:42:39 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id 65so2457753pfx.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Sep 2022 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=qqaQNOdpehqVq2XrweTVHqYoJcLxU4LOqgxU+UY60WQ=;
 b=Qs7dLb2pL3V3HdrG3Pv00KmIHSZrRFEQqdYflAlJUmtdciWsItEQ8Htkv6YneSBYwY
 Hs5g69MtDio3wFYWyiMv+3vQXaoDbTS74stSTnR7vUz9O65mWgC5c5hVw9AM8sXQ2wRx
 VTRNK5albonxpliONnuWIYHNI/t4MHcs1gF/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=qqaQNOdpehqVq2XrweTVHqYoJcLxU4LOqgxU+UY60WQ=;
 b=zlBvIGbg0YK2/iff5s4kBYC7bt6NHmDCRASQDvdPJOIrIPN88S3Vi39E4a21dn144t
 nl5T5Pi6ELQUURHihQcr19IK+QxcHcr2bJk59fFRh/4gn4hMLv658AerOCUkFmOiJ4dF
 w30wsr4GeR/kTHL5/B8BhZ+QhJBpAA3CQZXyM/9RteUUFujCEx+awCsBcx0mqckIrfvq
 FPk5ApqQTjI9HqgcXRGae7M9QDTugesA8MuvvGSwahpENeIK+p/5jf9Dcjvc93H+cahl
 1rrfnxL7CAJmH3bkC8EClcVc8wCQbvndI6b0nLgYiOPmWsea1flTUI5UuR9Pog4UXt2Y
 9myg==
X-Gm-Message-State: ACgBeo1XTQt3CWW8XgxmkgG4eCxKpl59FEGbfiibVJuXIZS8vg1EgMNp
 uGIlgxqfkSTXiZE2TQQRzUH0hw==
X-Google-Smtp-Source: AA6agR6IVbl9vhYt8tQVvWX6Bhb8qmGSNxPpRhfN16MoqKCPZoC5QRPOOz4Jr5nirm//GtXy6ukk6w==
X-Received: by 2002:a63:2208:0:b0:429:9444:85be with SMTP id
 i8-20020a632208000000b00429944485bemr597770pgi.236.1662500558614; 
 Tue, 06 Sep 2022 14:42:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a170902da8300b001752216ca51sm10545234plx.39.2022.09.06.14.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Sep 2022 14:42:37 -0700 (PDT)
Date: Tue, 6 Sep 2022 14:42:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v6.0-rc4
Message-ID: <202209061432.FFF96789B@keescook>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905071915.2312316-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
X-Mailman-Approved-At: Tue, 06 Sep 2022 21:56:05 +0000
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
Cc: linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-sh@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 05, 2022 at 09:46:01AM +0200, Geert Uytterhoeven wrote:
> On Mon, 5 Sep 2022, Geert Uytterhoeven wrote:
> > JFYI, when comparing v6.0-rc4[1] to v6.0-rc3[3], the summaries are:
> >  - build errors: +3/-16
> 
>   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
> 
> sh4-gcc11/sh-allyesconfig (-Werror)

Interesting -- I wonder why this suddenly appeared. I think the fix is
the common "linker addresses need to be char arrays" fix:

diff --git a/arch/sh/include/asm/sections.h b/arch/sh/include/asm/sections.h
index 8edb824049b9..0cb0ca149ac3 100644
--- a/arch/sh/include/asm/sections.h
+++ b/arch/sh/include/asm/sections.h
@@ -4,7 +4,7 @@
 
 #include <asm-generic/sections.h>
 
-extern long __machvec_start, __machvec_end;
+extern char __machvec_start[], __machvec_end[];
 extern char __uncached_start, __uncached_end;
 extern char __start_eh_frame[], __stop_eh_frame[];
 
diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
index d606679a211e..57efaf5b82ae 100644
--- a/arch/sh/kernel/machvec.c
+++ b/arch/sh/kernel/machvec.c
@@ -20,8 +20,8 @@
 #define MV_NAME_SIZE 32
 
 #define for_each_mv(mv) \
-	for ((mv) = (struct sh_machine_vector *)&__machvec_start; \
-	     (mv) && (unsigned long)(mv) < (unsigned long)&__machvec_end; \
+	for ((mv) = (struct sh_machine_vector *)__machvec_start; \
+	     (mv) && (unsigned long)(mv) < (unsigned long)__machvec_end; \
 	     (mv)++)
 
 static struct sh_machine_vector * __init get_mv_byname(const char *name)
@@ -87,8 +87,8 @@ void __init sh_mv_setup(void)
 	if (!machvec_selected) {
 		unsigned long machvec_size;
 
-		machvec_size = ((unsigned long)&__machvec_end -
-				(unsigned long)&__machvec_start);
+		machvec_size = ((unsigned long)__machvec_end -
+				(unsigned long)__machvec_start);
 
 		/*
 		 * Sanity check for machvec section alignment. Ensure
@@ -102,7 +102,7 @@ void __init sh_mv_setup(void)
 		 * vector (usually the only one) from .machvec.init.
 		 */
 		if (machvec_size >= sizeof(struct sh_machine_vector))
-			sh_mv = *(struct sh_machine_vector *)&__machvec_start;
+			sh_mv = *(struct sh_machine_vector *)__machvec_start;
 	}
 
 	pr_notice("Booting machvec: %s\n", get_system_type());

> 
>   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 3768:1
> 
> x86_64-gcc8/x86-allmodconfig (in function dml32_ModeSupportAndSystemConfigurationFull())

This I don't know about it, but looks like a recent commit: dda4fb85e433f
Given it's a 2000 line function, I assume it could be improved! :)

>   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 258:25
> 
> s390x-gcc11/s390-allyesconfig (inlined from 'copy_process' at /kisskb/src/kernel/fork.c:2200:2)

This is:

        memset(&p->irqtrace, 0, sizeof(p->irqtrace));

p->irqtrace is:

        struct irqtrace_events          irqtrace;

But that's a whole object destination... why would only s390 warn?

-Kees

-- 
Kees Cook
