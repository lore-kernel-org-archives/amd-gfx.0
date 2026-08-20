Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBDEC5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 12:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A16A10F014;
	Thu, 20 Aug 2026 12:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OoV3L+J+";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD0F10E5E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 08:28:42 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so19972905e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787214520; x=1787819320; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+mjgOzzqf8byV+W3iweABc5rncGdOTMPP+xlCqzu8Cg=;
 b=OoV3L+J+2zmVmlv7G4bowgKl1r4W7zDIb5F79NHNJLPPNeWtyInmLaVfIq6U0HUy0+
 Dy7imuYGJyURlzfYw/nOCK3GQffVV/2k8QjHKIEVJfxvDyBJ2HrLhuiqfrAQvUOqJJ+y
 X2R6YEIO7OCTSJvXkTHEQ4InLCryS1v5Vt0wW1uDCVn6HtU1daU6FZG7nnSyrxLTnGUC
 tVjJb4ppo6f8Va+NgmHmyG4RW22qKiFKiHZV1ZqXZfqVhQH9rfFctwS4qWBg86OIYckE
 uBszTe8dNX3n6sNcMiKFujVKR+YzYsikcu6mcd7LmzwFiIZg7JgaNROfpenNZoqugITC
 xXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787214520; x=1787819320;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+mjgOzzqf8byV+W3iweABc5rncGdOTMPP+xlCqzu8Cg=;
 b=gidKtGE0/u8E57Vi6XsxMSBP4y3K1hAqeoktZF7IDKaMjdUN6gymNK+MS5/fxOa7Fj
 7SPvnvCGSOL7eeVpZAB3XrYxeubjTilBK5TYtB9tZwvh7f3Nk/Ix77pWv3aAMQ5PJuqY
 dRGimLGSKDhZZkbY5RdzY9GPy7mMPcpLEulcogDVhiFZDLmD+pjrp1Qutf3bCxtRxMVh
 F22i/pGzlOKegg8sbvzDPem0KZ7Ee7HxB40Fgf0jxZV0GOlwne0kfFHj18vCPhAW0hhv
 /cDVJnhNXzqqecp8VC6RRdbsYS+4MguQLbrz8f1aDuOrqJfc0Q+sG7tyyFzmQtDb/0LZ
 yCzg==
X-Gm-Message-State: AOJu0YxKn+ikRCXq6CoWagk2zr7vD/tsbwwY/B9ej+WXdqVabpR1EtIH
 Oeh5ahlR02obwXQNiijw63NDx34r/eXcxX327tC2iBMV60YK4sQFD/Y2xTaYjydS696iAdYY
X-Gm-Gg: AR+sD125FkP+y5auZQX6ZBnKBXIe/h7pUKwnnqykkRgwRuhQF5W6GnHKKwtXTJGWAPg
 0mjZWwo7SiBmlyF56XFAt48idYVS1uHa2SiVVexzNyDXSO15XgJCriYOcSvSldLEX26Q037Ggdt
 IQmj2R4NWN8bqm6PRG58+i86zF1Up8uOx8rcmgkR/GgEpO8mu/L1f0Bnf7cpSS+JFuMwDT9b0HP
 L4E4OOoAQhwj/oeRcdiIpyn9I31lUWLqzZ7I1dN6wCWMVV5LC2HkROM4vzqfJMQJKbsTyHsiiYJ
 Gz8FWmeFQZ+6ItoPmuh10YU34KP3HBgdpjccoSo6EYkmNlA6ilhbkSTs0NCRJx35JasqBAntdah
 7AcLjVdS2y76GotCDOarhqR1SsERkuR6wYHcZllWOdFM2DZDsU48BdHaSg8btrMt0CgIu7U+Ntd
 eQu74vAyVAbJakndbm+Kbh+HHYAB03n3lKKlyRND0PmJzX3Cy7g8ZeUCI/LJ72Qn1IIBM=
X-Received: by 2002:a05:600c:5253:b0:499:79b9:e226 with SMTP id
 5b1f17b1804b1-499aa109edbmr169184435e9.0.1787214520340; 
 Thu, 20 Aug 2026 01:28:40 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b3c556a3sm15587685e9.3.2026.08.20.01.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:28:39 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:28:35 +0300
From: Dan Carpenter <error27@gmail.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Add new sources for DCN6
Message-ID: <aoa6s4zFvNsiClPD@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:33:59 +0000
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

Hello Aurabindo Pillai,

Commit 7f7d7ea1fa51 ("drm/amd/display: Add new sources for DCN6")
from Jul 22, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c:572 dcn6_calculate_flip_schedule()
	warn: duplicate check 'GPUVMEnable' (previous on line 570)

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
    566         DML_LOG_VERBOSE("DML::%s: VRatio = %f\n", __func__, VRatio);
    567 
    568         bool flip_enable = iflip_enable || (GPUVMEnable && (ihostvm_enable || iffbmm_enable));
    569 
    570         if (GPUVMEnable) {
                    ^^^^^^^^^^^

    571                 if (l->dual_plane) {
--> 572                         if (GPUVMEnable) {
                                    ^^^^^^^^^^^

    573                                 l->min_row_height = dpte_row_height;
    574                                 l->min_row_height_chroma = dpte_row_height_chroma;
    575                         } else {
    576                                 l->min_row_height = meta_row_height;
    577                                 l->min_row_height_chroma = meta_row_height_chroma;

Dead code.

    578                         }
    579                         l->min_row_time = math_min2(l->min_row_height * LineTime / VRatio, l->min_row_height_chroma * LineTime / VRatioChroma);
    580                 } else {
    581                         if (GPUVMEnable)
                                    ^^^^^^^^^^^

    582                                 l->min_row_height = dpte_row_height;
    583                         else
    584                                 l->min_row_height = meta_row_height;

More dead code.

    585 
    586                         l->min_row_time = l->min_row_height * LineTime / VRatio;
    587                 }
    588                 DML_LOG_VERBOSE("DML::%s: min_row_time = %f\n", __func__, l->min_row_time);
    589                 DML_ASSERT(l->min_row_time > 0);

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
