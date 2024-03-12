Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F4CC54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 14:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF99C10E619;
	Tue, 12 Mar 2024 14:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SDe78iNa";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD0910E619
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 14:58:34 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-29baaf3c018so3043885a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710255513; x=1710860313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CsX8d4GM9DcuEdj9PwhgWmZxoAxXkabqDZbIQgK7N4=;
 b=SDe78iNaKYnlTOXXO/dlGjp7IX6ApgTZBah7yNzg4sm1jDMjr3+a7HIpR1hmP5xARl
 wLq71aS5621/eudCkxLV03S0K6iaDdseL9DlJG8pyfC/v1IKppNvWyfHXpli27BhoyxQ
 xVIGK5XgeNRTQEFPkIpRYtwgT+Ud3GXoNvO47sZteqfUjiArBUIL5cg9P1UnctkQcpdh
 vjlYquw314RZR/4TPmFwvZ5hXMCdtzca3G/GdEBhUZ8RHyw0dOLfz39tOMTRJ+IJLCui
 d5+QZpmrm3ZDxX7VJLbvmnYVWO3ITcRwVeXUrOMFc3E5gVHtcUQBUaGUirxuRQF1TJEe
 DZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710255513; x=1710860313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CsX8d4GM9DcuEdj9PwhgWmZxoAxXkabqDZbIQgK7N4=;
 b=fS8l8MUBuf9Ol04nq7kaP3rcmE23PC4C5yv5IGcClrSDZf95h/GPeHCOjlBJUm+OhC
 ESeujZm23H63Og5+mgvsMr4m6jRfWbn9fdCjm8djBidc0ZDiVSIZW1rjFpsVUiYDBkw+
 rihJOwdDyv+QuoTTvBd1g/hOTykOJW4Ym6l7KK6ajMPQZ5XFZopTgyRJSIZNS0bg1pCQ
 ptQKnz/Ed2X6bhdPKDHB6AlrAsolMW6GW3q5YcTtFOJKtysIkJpJ4Pb4E9mQ351sJgiG
 r6jjMRMu9PicDZ59jErPLyljph5p2I4shE5wMYqYFRN24toWnYyaDQ1NiSu4ZoByUzS6
 6beA==
X-Gm-Message-State: AOJu0YzuRm6IQIZlATXaLmnyCUa0KgQUMGnuN76m2RmV2hvyiCgPcx0r
 jeDmngO6XiDzh83zs2cvEqZbWti0imR+3bep+xrBSKtKkXXt2W+GU11kHiPAOiZqQXfZzZvHIWQ
 Zq/3B97TXuMc5kPMKlgIRFecUHrTumuCPxj8=
X-Google-Smtp-Source: AGHT+IHODkXJDWO7xdVu7Nea2XlYYuQLEZxRVPd6hHRK5TKST/rCSu6kGnHkISk0GqAewDcUwpqQGMo7/bV/j1zD4Z0=
X-Received: by 2002:a17:90a:ab02:b0:29b:6da4:277e with SMTP id
 m2-20020a17090aab0200b0029b6da4277emr599073pjq.1.1710255513447; Tue, 12 Mar
 2024 07:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240312134728.14046-1-harry.wentland@amd.com>
In-Reply-To: <20240312134728.14046-1-harry.wentland@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Mar 2024 10:58:21 -0400
Message-ID: <CADnq5_OsR1VpobKpDLhr+uKSBT05MUs42B1_PbazRT=P7AyASw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Get min/max vfreq from display_info
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Mar 12, 2024 at 9:57=E2=80=AFAM Harry Wentland <harry.wentland@amd.=
com> wrote:
>
> We need the min/max vfreq on the amdgpu_dm_connector in order to
> program VRR.
>
> Fixes: db3e4f1cbb84 ("drm/amd/display: Use freesync when `DRM_EDID_FEATUR=
E_CONTINUOUS_FREQ` found")
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b1ca0aee0b30..cffb2655177c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11278,12 +11278,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_=
connector *connector,
>
>                 if (is_dp_capable_without_timing_msa(adev->dm.dc,
>                                                      amdgpu_dm_connector)=
) {
> -                       if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_=
FREQ)
> +                       if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_=
FREQ) {
>                                 freesync_capable =3D true;
> -                       else
> +                               amdgpu_dm_connector->min_vfreq =3D connec=
tor->display_info.monitor_range.min_vfreq;
> +                               amdgpu_dm_connector->max_vfreq =3D connec=
tor->display_info.monitor_range.max_vfreq;

Does this need special handling for DRM_EDID_RANGE_OFFSET_MIN_VFREQ
and DRM_EDID_RANGE_OFFSET_MAX_VFREQ as well (similar to the code below
it)?

Alex

> +                       } else {
>                                 edid_check_required =3D edid->version > 1=
 ||
>                                                       (edid->version =3D=
=3D 1 &&
>                                                        edid->revision > 1=
);
> +                       }
>                 }
>
>                 if (edid_check_required) {
> --
> 2.44.0
>
