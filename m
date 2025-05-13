Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0690C3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 12:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C2F10E38D;
	Tue, 13 May 2025 12:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZH5a9KJb";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76FD10E38D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 12:37:46 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-23179999d4aso1317815ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747139864; x=1747744664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgXUZnJrqELb6WJv8slnNwPAEoBp1ybmjH13rA8LCYY=;
 b=ZH5a9KJbpVZMet0TGQv8hwmnJ5DBc8OzeAvBwkSB1XcPrQlncR6rPYuNU+ocpgRF44
 Q56tKjlBmqQR9mo5wWlF64kpC+aCHZ/8cUwobYMHDrpjJgLRmMxk7z49LR7yhEpyIQbS
 bIIb3K5QL8T64UmPiXHPh+omuF9c38yJStAHSOFsfwqIP/zmfWR0/kU9K5gXdsgQmVyR
 haCK6JBe86Zg3IYrXpsbGgmEL4oxQZABxbYL/jjjNsDpsZLBsbtmuR67+ASlxV2nBU1+
 cis7cQ6VnSREQF6yDcyaWA8xc9QCK8xvQAyRYTJViqrD8FriWclqhuaMqiN2MmEs86Xi
 zpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747139864; x=1747744664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgXUZnJrqELb6WJv8slnNwPAEoBp1ybmjH13rA8LCYY=;
 b=WC7qr+RHlXPk2Gu6IObMr98vvGYvkEUW2/foIFkva6zMOXU9hdTbxJnQOtEPeMFji7
 sOtHcklmx+5ME6BllDdzwebvsTGSrKNhfI24UAkL6DEdSPV7z32gUKRYMV40qp2xQnXh
 VrOAqq159iA1h3Uwjk4deVletylstUk3La5XNuOfuDJ4hajawiTdgqvxWW6ZQBYuqJCu
 f+46hNHYXwfbOEqYVc9mRCuogmwFIY8aSi/hQ1JtS7tHYakkg9XFpt2Ah1Wj0n7EF+99
 A/1jan6atE7hc80ggKSKVV2SrNtxzsOZsS5sVrV2ojWDrxIFja5vu48hAOgqXiAIqZa3
 Y9RA==
X-Gm-Message-State: AOJu0Ywbj1O87ksJz8BpkXELLFvC5aIjo9dXiD4GA7k73BtQZJAOJKiX
 HuukQfslWrROJcNP6MHmSMWKgIUY2OIhblM1K7XFo3VUvKDcNT6mlFBqjyVSUtD9fb8NuVBTfnu
 om3x6lwlVmycXMpD6rjAq86LNyEx58A==
X-Gm-Gg: ASbGncvtOYPotUl4S4G3deRJaAcZlwiFU8xLam282XLn5RYfQRumcYbYjuQCZj+w/C7
 2TXcSQ2rGXj/d6J7md+4ReAooUDpR5SaqBe0Rvo3tJ+HfdYy4Sfkph10OWGkh5VVwfEL5VbaQKo
 xdsGB34H1YJvGL9//ODI3jWYAaNzGHlfG+
X-Google-Smtp-Source: AGHT+IGXqPrVWRTuQse/tWr97RYjVGYHVy49EKbzFZn8J+XGj6eryspfICEPDRcE8n8HD7EavK4l8XRs+17SEyinqhY=
X-Received: by 2002:a17:903:41c7:b0:224:1936:698a with SMTP id
 d9443c01a7336-22fc8b59833mr95879785ad.5.1747139863710; Tue, 13 May 2025
 05:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250513032026.838036-1-Wayne.Lin@amd.com>
In-Reply-To: <20250513032026.838036-1-Wayne.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 08:37:32 -0400
X-Gm-Features: AX0GCFu3j0lM1p8BuPuDkqkhIaFJ4v4zeXAHbwYXKHGN98V6GQH5-a8l3nDRe-8
Message-ID: <CADnq5_MrUPvFVTkMixCuhFqpEuk+cKQpXJPBBBpaVwqrTashMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
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

On Mon, May 12, 2025 at 11:28=E2=80=AFPM Wayne Lin <Wayne.Lin@amd.com> wrot=
e:
>
> It's expected that we'll encounter temporary exceptions
> during aux transactions. Adjust logging from drm_info to
> drm_dbg_dp to prevent flooding with unnecessary log messages.
>
> Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER c=
ase")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 0d7b72c75802..25e8befbcc47 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *=
aux,
>         if (payload.write && result >=3D 0) {
>                 if (result) {
>                         /*one byte indicating partially written bytes*/
> -                       drm_info(adev_to_drm(adev), "amdgpu: AUX partiall=
y written\n");
> +                       drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partia=
lly written\n");
>                         result =3D payload.data[0];
>                 } else if (!payload.reply[0])
>                         /*I2C_ACK|AUX_ACK*/
> @@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux=
 *aux,
>                         break;
>                 }
>
> -               drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail=
:%d\n", operation_result);
> +               drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fa=
il:%d\n", operation_result);
>         }
>
>         if (payload.reply[0])
> -               drm_info(adev_to_drm(adev), "amdgpu: AUX reply command no=
t ACK: 0x%02x.",
> +               drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command =
not ACK: 0x%02x.",
>                         payload.reply[0]);
>
>         return result;
> --
> 2.43.0
>
