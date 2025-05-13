Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEB6C3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 18:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472C310E5D9;
	Tue, 13 May 2025 18:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zbsxu8fd";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F116210E5DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 18:39:29 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22e4d483627so7613275ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747161569; x=1747766369; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeSFDgZBgYjm3mhWQLfA97pjPHc8r1eeA74RDgLjocA=;
 b=Zbsxu8fdeiY2WsWSvs43Sc5FBOy9y3lcu22aTVVNzj3zdOMWZhxbINejtBVWRaSzaY
 YiEeGQRIoNcJOHKntOucHxqagn6NbiWL1TCVL8cIBqQZa4oCJDt4uPwykeoltaVgVLZg
 VgRGsTM7ulG7RB6r4Xayv5XW7AtkHveIRsGK2ODvCtTS8SNBu9m9fWTls82Oo0VZxwnG
 vrvqFAb3xh5mDJYsbvaPHzDI1UmlXFo5ZBkPghT/PqqtStGp6Teq6mJpkq0CWcp4m7C2
 lnod4GGoGQ9NaTs4GzNN3n7Rw7q7DtwhPkjXeEHtrE5aAiY62M5hQO/UagS+8LGgM3Ng
 n39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747161569; x=1747766369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeSFDgZBgYjm3mhWQLfA97pjPHc8r1eeA74RDgLjocA=;
 b=MWU6KBu9i8H/lK/NDxLF5whlKRp9UTfmKG9r/n76y93zbzhfAebkL2RR76GjTXXMpS
 EyLS8Yj2g1s2xvKLLuN3pjCyMDbNgC7tRpOPGimH0vSk9/zVQr3FV3lzq16/M9BDyHmV
 pSQ2qzPj60nE+uVQDxrlJDDgNLAacKgomf2KF7h8lMoBIeOCm9H5uglGlCu3JcSICn5+
 bn5lgzKISH9LnJOWC/Z/CdrNO5mS8IdY7CxKpswZ2MVKxoiWjoUblbp+5DzDOhv7PMv5
 zo17XmgGyeIgArsBud4cBTcrAOZ36UCdQm02WYe/ry3n7Zpu1VkZqsMEq151trWav9Cl
 cDIg==
X-Gm-Message-State: AOJu0YwXwfR6ANu+NzpapmbJLZKvFS7toUWbCQf7VPqr5GwTu3yWZLSu
 lZw63iwvM3/cWc172v69Y3DnigPFAKGhnAPz2+vd+OU90qP1KFmRG6ID/qAQvWdeCMUkYQK8yxs
 xvLmEfBjZbUrmOGHgHdwxBA8OPU8=
X-Gm-Gg: ASbGnctFvcFNTSPmaph0xD/sa5aVf/gpSjTbKX2UBLwvXRXModUwypbMzyjoMwtMeJi
 yGL/02rLi43Ep8p0XXSWwMWRQhZIYXa48/bijPJhfwkNEh/nyw0Mp50DdJoC5c5E4g1dGTWsgyr
 1TDaqenc/+1FuQOmz735Gp+yBYsjdEhe9r
X-Google-Smtp-Source: AGHT+IEJVCK9KIRtAfD8UaJbTZhHDynI0APK1xZ+d876UDrwNh149XBJidFcMewCnee5Sc3YLXDrLw/I5Ox03yA5BVk=
X-Received: by 2002:a17:903:248:b0:215:435d:b41a with SMTP id
 d9443c01a7336-231980ce4d3mr2681605ad.1.1747161569573; Tue, 13 May 2025
 11:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250513182307.642953-1-David.Wu3@amd.com>
In-Reply-To: <20250513182307.642953-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 14:39:18 -0400
X-Gm-Features: AX0GCFtd89wE4tDE9Sg1rgrjihi7OvYXBuB8EcJ1TER_zc8KtbZrJNJYjDryxpY
Message-ID: <CADnq5_PGOb9msPRH=-YzRTQp_wCyONqKnXUJRwfAZOW-Y3O=uw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] drm/amdgpu: read back register after written for
 VCN v4.0.5
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
 ruijing.dong@amd.com, stable@vger.kernel.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Tue, May 13, 2025 at 2:23=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> V2: not to add extra read-back in vcn_v4_0_5_start as there is a
>     read-back already. New comment for better understanding.
>
> On VCN v4.0.5 there is a race condition where the WPTR is not
> updated after starting from idle when doorbell is used. The read-back
> of regVCN_RB1_DB_CTRL register after written is to ensure the
> doorbell_index is updated before it can work properly.
>
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> Cc: stable@vger.kernel.org
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index ed00d35039c13..e55b76d71367d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1034,6 +1034,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu=
_vcn_inst *vinst,
>                         ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
>                         VCN_RB1_DB_CTRL__EN_MASK);
>
> +       /* Keeping one read-back to ensure all register writes are done, =
otherwise
> +        * it may introduce race conditions */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
> +
>         return 0;
>  }
>
> --
> 2.34.1
>
