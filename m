Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18364C5B567
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 18:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CD2710E03D;
	Mon, 10 Aug 2026 18:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NBIVkl1c";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1B810E03D
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 18:40:58 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-392af6bda98so199578a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 11:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786387257; cv=none;
 d=google.com; s=arc-20260327;
 b=U8i/aYtuf9HBDLUnLzvCMaf3mrXMzXTfwAdBoW1HN0avG1taJ/Joiqi5IjkRIlAk8M
 Gl55NOVyjT2j1K44e8Cgz5lsbTxn+BZYNsmX4s5xdbC88TAsO1tK0KahEtZh32fyuGsE
 AFDkH1fCJ+cNjfSmQxO5B+EDaH8X9J3m01TR5ksZfrSI3CO9iJyOOftp22Sa1pmSN9UK
 KV1W1U4MAdMxnzAB2AK9MeW3Nfxww20vlmEkqIbfMbqEYoIidmJ3EhMhSP+V6ur4HX5I
 N9yxZ4fsxoLmVORwXqqANI1dBA7ToQuMat7k4oRav5/r4koYdsrs1XZow4ibuORKlthr
 eybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IDnbD2UO3WyOuDehW2mkqgikhPKgQCT+Ce5Oy6rQhqo=;
 fh=x8wVZEYxIjamc6fs33NvCM28Uk9SpeviSpmlRQ+OxZw=;
 b=MGfOSvBGLZ3P9PU1kjDuphiR3ZZ3dmNG1R9ye3hXxHo0drywluWG8QRcL3B/2Fznus
 7tNbBVRz9s81eVKlaJYdXM5uQEvFxwuXibc2TMY4By7J5msus2mcEApNFNYWaNXeVR7l
 YIHh1GhWJ5XVRQN1C5EuiDxF+HyclxmEbqRA4Ut8LulwXskeRL64+BQafe4NHv5Xff2h
 KTSO8jP7qbO1h+cI7ace8V0MNxIey+8ipQNWG+x2mlGXhkwFffaarrVhOT5dEOWIiQIJ
 RFsjRWdH5mLsvEhqpA3GxArZ26ffLNOSpk8hxXU7FVBOsxiSCMSXW0+efZZbM54KEA9E
 AOhQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786387257; x=1786992057; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IDnbD2UO3WyOuDehW2mkqgikhPKgQCT+Ce5Oy6rQhqo=;
 b=NBIVkl1c/QBHnIZEU8itbiFhMz9VFLtBTf0FknW6CGg5UeA5YXPaiHiuJ65nnStdu9
 dAKj8GPv9zzPNTcHoIMI4G7Yy+juIvhlIKLiv2Yft01llMyScFru76e38AcqlmEroVUG
 cYyT94zbKn+LUciX7KJf1KpxmtKiRpXKkJoTnFd9Wwo5zGG9iA69D1zoXaag39ATvu0q
 3cMg2zWkjbnnWCri7Dm61AuucLgG0nllcXjJszKKo3ytUnGNw4R0DapoWZ7ijHKov49n
 nVKRQbQPt4DnsGohL1t+T8e0soeu5QxnkE08WB8JxZKpUnVV0fVAJuJ0/TBCeazcwP59
 ygsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786387257; x=1786992057;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IDnbD2UO3WyOuDehW2mkqgikhPKgQCT+Ce5Oy6rQhqo=;
 b=FUOGxcq5Fkde6uuLHcTX3wam8ezGqyA25nZUiNgyLv1ECG9Lx0XMtRLA3bi5AXacdn
 zSjaMMhTXWWlJArHXJLsc82/AC+tvX6AfjHHN9hgTLrYyDmbIsDyWdXW0HqRGAGBz14s
 0/FHj6qmPDzdV+0Cr3h3QVn1q9ya3T0mN+bHdm0yDYJEitWgh1ZrpP//Bs7WHZpbQHLg
 ED9vju+iIrdmiBs6s86kR0d9HFCPEXcgxtlcm4yXNm0jpvNQZ+vMOQmm4fzdpjpMBN0c
 ILSJJB0Lv6E1E8P3NJ8NEWgQdXQTXA91+TSYLTAM1UWjXDtfNYe8EzgNswMp6wnMGYW1
 jf/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/qaD9PvkaZKaMgEcW5rlhPKB9XspehdiuK0wNvjN1jtkmJf22vWjdBjiNgg2+3xQzVtuOeab5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1bJrQ2WstYaAYEl6VSIKVyTTrQyEyO6EGahSY6a7x8ntWY8F7
 RHkzBePQU4ysREK/5wAbCoWd42o+Zkxea+CegTAvhEA20v8XCcYgyiRBINFHYEjX+ac20TTiSqD
 4EaPGUAROHpsM5X/HnOsu2w38XE29eig=
X-Gm-Gg: AR+sD12mC5CdI2Qy55FHtOZUtM9zDlvq/fi5yCB6BsJkNkbsnqaYd1TVBOHLy4/ZWea
 8RtsbYsreEe+TznCS/QRmoF8fXw7qH0AJN2WEJIrHDa7jNgz/INMyutDnCBsJm7BIMB87fc5CIW
 Jik8S9Zp6S1OKFbiHujeIdlmtM27ylvr9dhA/DFrXpkrQrW0kW6kaklVF3XmquGioFYYpuOr7W3
 Y0I+ZkGAURqxX+LNxm8UN76tK7BIfmbGrfNvVDi66TjfTFmTyw80x2Tfns1tMUxnlEzVZikjK0+
 OKFZx1Raz/esHYFxgZYqMddKnmsFTwYpPwl92m6cCL3Q9NVnW778h9HYLCEhy0evYPpsyjnqTN4
 +h3Y7vu/cR/Wiv1YvQugvcZh3GVdUxPg=
X-Received: by 2002:a17:90b:5807:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-3903c5fa99emr31653029a91.2.1786387257375; Mon, 10 Aug 2026
 11:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260807115712.22423-1-mwen@igalia.com>
In-Reply-To: <20260807115712.22423-1-mwen@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 14:40:46 -0400
X-Gm-Features: AUfX_mxudn7S1bY6Go3YBiGO4RqcIMi4pOzDB7fnjayynPlWt6hEpFSuLHctVIU
Message-ID: <CADnq5_OxnaEdNUpC1VQsCgensRYAgFCMeGy3uL5n6mYXqOHV-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use plane color_mgmt_changed to track
 colorop changes
To: Melissa Wen <mwen@igalia.com>
Cc: Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
 siqueira@igalia.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Fri, Aug 7, 2026 at 8:08=E2=80=AFAM Melissa Wen <mwen@igalia.com> wrote:
>
> This is a resubmission of d79716401a95 ("drm/amd/display: use plane
> color_mgmt_changed to track colorop changes") whose change was reverted
> by 0461ba9a7994 ("Merge tag 'amd-drm-next-7.3-2026-07-02' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next") during a
> merge conflict resolution.
>
> Original commit message:
>
> ```
> Ensure the driver tracks changes in any colorop property of a plane
> color pipeline by using the same mechanism of CRTC color management and
> update plane color blocks when any colorop property changes. It fixes an
> issue observed on gamescope settings for night mode which is done via
> shaper/3D-LUT updates.
> ```
>
> Fixes: 0461ba9a7994 ("Merge tag 'amd-drm-next-7.3-2026-07-02' of https://=
gitlab.freedesktop.org/agd5f/linux into drm-next")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>
> Hey,
>
> I noticed this problem in the resolution of a merge conflict after
> testing drm-misc-next on SteamDeck with KMS colorop API support and
> verifying the issue of missing updates in nightlight-mode was back.
>
> Let me know what are the right steps to address it.
>
> Thanks,
>
> Melissa
>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 67b825cbb88f..d0e612371c8f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4202,7 +4202,7 @@ static void amdgpu_dm_commit_planes(struct drm_atom=
ic_commit *state,
>                         continue;
>
>                 bundle->surface_updates[planes_count].surface =3D dc_plan=
e;
> -               if (new_pcrtc_state->color_mgmt_changed) {
> +               if (new_pcrtc_state->color_mgmt_changed || new_plane_stat=
e->color_mgmt_changed) {
>                         bundle->surface_updates[planes_count].gamma =3D &=
dc_plane->gamma_correction;
>                         bundle->surface_updates[planes_count].in_transfer=
_func =3D &dc_plane->in_transfer_func;
>                         bundle->surface_updates[planes_count].gamut_remap=
_matrix =3D &dc_plane->gamut_remap_matrix;
> @@ -6012,6 +6012,10 @@ static bool should_reset_plane(struct drm_atomic_c=
ommit *state,
>         if (new_crtc_state->color_mgmt_changed)
>                 return true;
>
> +       /* Plane color pipeline or its colorop changes. */
> +       if (new_plane_state->color_mgmt_changed)
> +               return true;
> +
>         /*
>          * On zpos change, planes need to be reordered by removing and re=
-adding
>          * them one by one to the dc state, in order of descending zpos.
> --
> 2.53.0
>
