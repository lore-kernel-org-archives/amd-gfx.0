Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E14FF54AA0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09CB10E668;
	Tue, 24 Mar 2026 13:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L4+bo43M";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A5910E668
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:18:12 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2c151551a6eso21855eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358291; cv=none;
 d=google.com; s=arc-20240605;
 b=kBMM5/jsYs04wPrMjaTIjbmUnYP2y81XrJlff5Z1TUx3R0lNLgjUsAiCbyfEuFPJcg
 3/OrwNWwWi4Y04sWyKNDFMmbd8H1z9lW5gy6c9UHLOSHi8wXIaP+zfEUu/6ntq5ac8eS
 YDZ1xRsB+ZDdUj9n+j6N+kt3H7d6uelkSxk30Z2zH5BIcxsQANuiN3jiMrz4PfpZZWkj
 wHLsH/3OudEiC71zq9H2sp/Dpz4Q2EGfpGB62JZpiqvB+OSmAJUKRu5wr7EcyyPKjWj4
 8OgoI5NSd6fEnamKfMsQ3199bnV/Zl/4s1AG0sow+giLI+AHh5zAx4u3Lh3arVS3x54J
 vrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AD5VHBPGim6PdL8ZwGxtS6PvF4rAsfXKUPAGUcXH+Co=;
 fh=NhDn2E6vgWC2RmAK/byQiDMniOJS95wckYH+xJKt0+k=;
 b=MzN5bCgS+SOBUgXVsdRfwA6Hvky4Umiw+piIpPPxTCO+Cha3FzJKG6GCyRNgVDJU39
 pHqYVd7ULXEfaFAxDrINfdMhBVUD+bAM38Wjz1O9oFvtFlugX6SEVMCVRub/6bQWEoXB
 jG+iN3DJhN7LsA9Qb2xA3DNtIazcpg2mdSu3dftU3F9ICqkeSLxmMCGlQ865hezD9+QO
 W/xIpOkf98smm1VLGbn8rXMrFMwr8zuocw2re6oQghd2wmSUEfxjgLpUxxQGNdvSys3f
 AEt8972WSeQAKPXw/0A1/yNmPoXbkyncaeTrOfhgryxBRehbMB40iwowlruy1xMGqvRa
 31Mw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358291; x=1774963091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AD5VHBPGim6PdL8ZwGxtS6PvF4rAsfXKUPAGUcXH+Co=;
 b=L4+bo43Mq2ZAc3gVesc4ULuc1B5ndhZWhoPFARm8BARVFTvDuz7KPF6+4U2qa1kHAN
 L1EoTwDgUvb6MjitKE/chLjWMVkzkgPwM0IL2xKQktkoOMY+3CJ8/8uRWLXKZ4OwEpl5
 2lvrdnxWBaGgvLPLVq77qXDqjJ81wPq4NYdvhi8K7wdk9MWURYTnnfUGlmTOnhJwedK1
 U4/DY4C0CA5FEgSdFsU+Yth5s0Bxuk8CUZWBSCrc6bO4wFdBYbfCP7fv82QpEbP5z2GQ
 0qwXeZl7bRpAYAmY2xVBjhy2eofVsGG4JKKMj1gd457hn3dFvuJ/y0PdK17XObFK+I6t
 vmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358291; x=1774963091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AD5VHBPGim6PdL8ZwGxtS6PvF4rAsfXKUPAGUcXH+Co=;
 b=qi2iX2GC/BXSCL3XIp1GMAhgvIm8EZHWUBwlkUVv5aYaP5O6QzGegLcxj7YC8yj9DD
 ZIgw746pCRPTghVkqYHZKBoSSzy4J67R+5ML3v1KeZC9crzf/FrxSUU+zpw/228tMNfm
 yn4Zr96zQm01Nu25FNiYnq/zxLVQSFC0AXfR8UUIAnKMDQdZZcuMKHZ8/UW9Cg43+gm5
 7Crfy/FVIKvxYW72QMZb0Pgtf+0cJ6FM/1TWpQM4K+1SAdpHqdLtRyJFc3cnrq3JRY/a
 gjeOlKHT2iBqe25fP3XfOLX02t/AcbOIHaDo8V9z9p8/Z0cxGjMse88Tg8Skha2uM2Xh
 Mvtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoSEyj6YNf7or4RHMDAXKnr3GY7OR5HXCshsHWrxibpDNPclpPRwjCg2bs+Sx8cPXdY302Vpky@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1gzPYiDBSGMAoGI3mO3XRcS+fet/TZuTesH7TxIAQlEiwzRtx
 PfZWx9RYjAeVZyi9tcQQQwuJHMoyc2uA+gEG+IO3yOtOxXP6yG3EIF7so/hRa40zbqOdEfUUk83
 NXRjYfsBJqdljj1TbFGNr3P2yz399oaI=
X-Gm-Gg: ATEYQzx44Ynx3syKk+xJeYlqJuzpWJk5QFmRhGmcu7eGlLpMk00K979CM6LjUnBCsav
 dAPts4izPHQoROZ6JLC8YKCZ5EjBBEcqU95XMkPxcYXrfGioL/xWs0mvwr3v8FrTFYahgwAEAyH
 rhqF+cQOyu/dW5wdBm2WTS8cG4kGkLt/4uhzKRdvQT6ax+eK4P7Jf4FvGYic4G+FcFITLHesueS
 wdzUWw8LLktkrC3r7xJsPTEtVnw0xz3VVdmXHWCuVHFYDFJee7IT1XiJ9rnfbzOoqW2nkrGIT42
 f3UQD+zowEHtUZBf2J0JMIk38R/v9xSD/BQyvMEGW3SJpB8pzF3GgX5FfwvniP5Ke+p6Y+3h5bb
 HmN34
X-Received: by 2002:a05:7301:4442:b0:2be:7eb2:2ed3 with SMTP id
 5a478bee46e88-2c1095f6454mr3344144eec.1.1774358291324; Tue, 24 Mar 2026
 06:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260321105717.6212-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105717.6212-1-kexinsun@smail.nju.edu.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:17:59 -0400
X-Gm-Features: AaiRm51BvxeAEOmeZZxEHJw085Bt5qt60MIORwpxuCeiZLkyyl9_4EF2NqW-WTs
Message-ID: <CADnq5_PATAoqfG9NMTB-dGxs0V+t6PA=jVvo=OkUDyNbqca3SQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: update outdated comments for renamed
 vblank_control_worker()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, mario.limonciello@amd.com, alex.hung@amd.com, 
 aurabindo.pillai@amd.com, ray.wu@amd.com, Wayne.Lin@amd.com, 
 timur.kristof@gmail.com, superm1@kernel.org, ivan.lipski@amd.com, 
 dominik.kaszewski@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg, 
 ratnadiraw@smu.edu.sg
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

Applied.  Thanks!

On Sat, Mar 21, 2026 at 7:14=E2=80=AFAM Kexin Sun <kexinsun@smail.nju.edu.c=
n> wrote:
>
> The function vblank_control_worker() was renamed
> to amdgpu_dm_crtc_vblank_control_worker() by commit
> 6ce4f9ee25ff ("drm/amd/display: Add prefix to amdgpu crtc
> functions").  Update the two stale references in
> amdgpu_dm.c.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b3d6f2cd8ab6..c2b7b31b0d29 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9894,7 +9894,8 @@ static void amdgpu_dm_enable_self_refresh(struct am=
dgpu_crtc *acrtc_attach,
>                  * a vblank event disable request to enable PSR/RP. PSR S=
U/RP
>                  * can be enabled immediately once OS demonstrates an
>                  * adequate number of fast atomic commits to notify KMD
> -                * of update events. See `vblank_control_worker()`.
> +                * of update events.
> +                * See `amdgpu_dm_crtc_vblank_control_worker()`.
>                  */
>                 if (!vrr_active &&
>                     acrtc_attach->dm_irq_params.allow_sr_entry &&
> @@ -10062,8 +10063,9 @@ static void amdgpu_dm_commit_planes(struct drm_at=
omic_state *state,
>                         /*
>                          * If the dirty regions changed, PSR-SU need to b=
e disabled temporarily
>                          * and enabled it again after dirty regions are s=
table to avoid video glitch.
> -                        * PSR-SU will be enabled in vblank_control_worke=
r() if user pause the video
> -                        * during the PSR-SU was disabled.
> +                        * PSR-SU will be enabled in
> +                        * amdgpu_dm_crtc_vblank_control_worker() if user
> +                        * pause the video during the PSR-SU was disabled=
.
>                          */
>                         if (acrtc_state->stream->link->psr_settings.psr_v=
ersion >=3D DC_PSR_VERSION_SU_1 &&
>                             acrtc_attach->dm_irq_params.allow_sr_entry &&
> --
> 2.25.1
>
