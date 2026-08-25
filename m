Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70712C61DBD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 21:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E172510EB4A;
	Tue, 25 Aug 2026 21:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vz1IK1LP";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C55A10EB4A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 21:28:20 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so20547466b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787693298; x=1788298098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B7kSIlJJ84PkNx03WFsQm+QKg/9aYj9/q0trDx0cIE8=;
 b=Vz1IK1LPur78f2GeV3F+j5OBnFUnyN5Fh9QFWadhKK654B9tqPMlfIdDuWmz0eFBLG
 gg+N++Ove3YzEIaRjO7+nHSBPD1FVLx0eyRuYL1ZBhU9rPtTM0oLQJeapQLMbdSMjP/j
 SRtkNAHElYJPfuJHxr3IWCA9BuGDvgGsRioB8QQ224tv+UA+lWz29X3be2/NzYuF7cIh
 HvBtXwpDg6nI1zj7A4pRqCGW/TK6kHDUKGp9iQJuIOtry89cQbH4FteXyUZyBYZOPA2i
 3XF9L+3LRpv9j/jDuBaUL3UTnHy4eXJpvTfOCSc6SKGMqDLtgz6uEb1qVP+OHOajw8AG
 tbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693298; x=1788298098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B7kSIlJJ84PkNx03WFsQm+QKg/9aYj9/q0trDx0cIE8=;
 b=lOkxTgcijAIKbx7AadrZb4zN0RBZoLaauF5IK2x/INRE5Y9bXDijDp8p7Aca/rnHqY
 QguW6CK4iOKab7PS+XHkcMYoUq2HOfUwSYr7OM1G9NO2+BuEURiwta9I7mjB7FgRKwrY
 deS4aoclzbGMnFhWLGFLBQ8d3nPt/HQIfhmjcUsDG44IfGVOMI5HnTYqyrGPronQgZhD
 zlxohSg36H+erKzpSKxyqoxflueDrtbTWmpvwh30Th9z6aA4CeZuelSD5rc/vpi6c444
 RqMG2ySpjlbB5U+dt2NchZqn0+H2mbxijStJf2GTUZ105fS3+CinO17HoxUdIVzLWIp7
 nkHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkpxEkZdqDlsCRIg4T1bb8mgActKd4nqICD4obY1OJxc2dzyK39P70k3l3J+ifLoh8A0dj2rhJ@lists.freedesktop.org
X-Gm-Message-State: AFuF++may2gCouE4+3UgJhHHtYR3Z2tIy7sHRS9J7lAA1yO7a0lH7Ufm
 ldnDOpWiVyB2icqswcHAe+isx81XPRllyf9WjVwbIjtsq8VUm23ypfek
X-Gm-Gg: AR+sD12LNul54g6GpR78B5ge3oRrpfFhnCxJg+hwVsE3y+UGOj1B92ow7lW6mxuPeMV
 tjMkZ5NKtlBh4Er6nD95HcPU1AHFVEBMgfeRPMi3sMoar4qNpiLOhMwNLA8eGCk+a1xekuJdOlg
 7N0YIzVmeL7HPTd7tvdt5LvUBL24bizo5lgDafJVhsLitEw75T/L3B4xAIkCHVMWZ0PE2bws3hR
 /Gxfd+P5eICooXACMqkpYUAB4MW8LH8AKJZJdyF/VjdMYOTVla4ez25PID9F7S+rnQQp0JAIR1z
 /OKTeMiRQ+rVX4Q8EkDQBrEepUmsj4RLK1iB/MDhR2njH0mINw0bo/Sa6yjFK0hKTS1AoBhGLx7
 zgFjQzIZWoVFG9sbd1cRT2eqL50fcaAoDN6WN+5rZ/9PPXLBf4nT0+M7ckfmzQbrCZcjkV7bei7
 SZulH0doLaGmbsjHkPx2CinHLkALvuQg4WTMVLO+MKWKFl7Eq1DY9dt8Z+wLeq6rGNwG0moKaIe
 YVwXTS8fmAsUe8zUu8QJlSQxHzVg4/hZwU2KlWZxkuEZSYJ4gGCYM9PhvOa
X-Received: by 2002:a17:907:e1d3:20b0:c25:d03:6794 with SMTP id
 a640c23a62f3a-c250d036dcdmr100923466b.16.1787693298421; 
 Tue, 25 Aug 2026 14:28:18 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ef4d2sm101774366b.59.2026.08.25.14.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:28:17 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: spasswolf@web.de,
	alexander.deucher@amd.com
Cc: regressions@lists.linux.dev, leandro.ribeiro@collabora.com,
 mwen@igalia.com, alex.hung@amd.com, mario.limonciello@amd.com,
 jesse.zhang@amd.com, Amber.Lin@amd.com, amd-gfx@lists.freedesktop.org,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: warnings from validate_blend_mode_for_alpha_formats() in
 next-20260715
Date: Wed, 26 Aug 2026 02:28:15 +0500
Message-ID: <20260825212815.48959-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716152933.6744-1-spasswolf@web.de>
References: <20260716152933.6744-1-spasswolf@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

this is not a linux-next-only issue any more: 860e748bddcc came in with the
drm-next pull of the 7.3 merge window, so it now warns on plain mainline. Here
it fires 16 times on every boot - 8 per GPU, on the 4 primary and 4 cursor
planes of each of the two cards in this machine:

  [PLANE:44:plane-0] pixel format with alpha exposed but blend mode not setup
  WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate+0xa16/0x13b0

I ran into it on 7.2.0-2709dd5ae32f, bisected it to 860e748bddcc and confirmed
by reverting that commit, before I found this thread. Hardware:
0000:03:00.0 Navi 31 (DCN 3.2) and 0000:0f:00.0 Raphael iGPU (DCN 3.1.5).

Nobody has put this on regzbot yet, so:

#regzbot introduced: 860e748bddcc
#regzbot title: drm: WARNING at drm_mode_config_validate() for planes exposing alpha without a blend mode property
#regzbot monitor: https://lore.kernel.org/all/20260813143605.106104-1-mwen@igalia.com/

Status as far as I can see it: Melissa Wen's v3 series (monitored above) fixes
amdgpu for both DCN and DCE, has Reviewed-by from Alex Hung and Tested-by from
Daniel Wheeler, and I tested it here too - the warnings are gone on both GPUs.
It is in neither linux-next nor amd-staging-drm-next so far. 271e90eb5f9f
("drm: use drm_warn() in validate_blend_mode_for_alpha_formats()") turns the
splat into a plain warning and went to drm-next on 2026-08-20 as part of
drm-misc-next-fixes-2026-08-20, but has not reached mainline either. Other
drivers are being fixed in separate threads (imx dcss, rockchip, vkms).

Since this was introduced during the 7.3 merge window, the fixes should land
in 7.3 rather than wait for the next one.

-- 
Thanks,
Mikhail
