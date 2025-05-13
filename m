Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9050C3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 18:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C06F10E5DA;
	Tue, 13 May 2025 18:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JFiD/CGa";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3657710E5DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 18:41:00 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2300e7a3b71so2693495ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747161660; x=1747766460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBmxBuQPyu10AuCPSzxYuR1E9+5wDoKuc+Ts+VERk8E=;
 b=JFiD/CGa97yC6p7fTBKOY78gfcRW4MZkUg5ZOPYAtl4R8AIoax6xT+02y+RV4hmzsD
 MpwNEhJzbXhBOrE0ij9J7B1YGu6kZ/X+2pdw/oENSLIOZIglqzGr1UCkkQmc8LqKrx/8
 4GkbdekUC3o8a4WxSR1cC+yoaANctbCFrWTpAT43gwEyMRx2E57Hw1E6SZJ7qvjSp3mL
 Uw4VrVurPf1SbKRZvkotW6lviW1dtxXZgQB9xRNJGEhfbh6wcmjbLbUe3nRKwdCqZIjS
 iIfwgF9BpspHDChrFp0DXgRe3rr+xSJ+G374OsuyIjrcvD/77hPR9TwyNIRq3qCsO/CT
 B34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747161660; x=1747766460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBmxBuQPyu10AuCPSzxYuR1E9+5wDoKuc+Ts+VERk8E=;
 b=DCuaC1bGxtZTfNOrRnEkdnDm5pmhWOnN+t0xFlUcKQxw8j41XzlwvSRCxpkfL9z+p8
 6ugD0wSnwWxpRPjU4vU+XOPc5w3Fjguq30rNVRz75j9WnUWhrufU0NhVv/kKjco33rvZ
 TFbXrEYuJLFVogQr1UaVrzsbhsEq6uNdlmUgf8glObIU4RT3ihiPtCGx/I5UT2oMrkbv
 zdGYJT2UlPIwsr6wj6yEhBX2xkLgs13aoPq7VAVYaOSSWJosKzvtMDtnRXUsxJvPwcJv
 yN9cbju9O+7qQMIdFuyb7enDV1SsGPZOnPq1HwvBE0hn53MtqReT0zUD0/yOuxgbjM4a
 9WOg==
X-Gm-Message-State: AOJu0Yyb9ibz3DLZLAWhcTj6GesWojVm8G/J9iX8j9e0Z2mKZ1DcF0J4
 Jlojulp7GktP6oHUeP7GnYOfeXK33IwnZrDUkrC52uIE+H/N+6ag9KGGEtwVXw/01k8vh34bSYW
 r8/h5Iygphn6Lzbwrbq7eRXfRqM8=
X-Gm-Gg: ASbGnct4/houTi7LU0/1I0GyxmbSkbGTb6ifewheR4Ps8VxmYPdj8nlixBx5XZF/9PK
 SSO2mFjVccMDIqUrr0JZTzbZhk+oQFzu6dVZVT9GS7Eyqt+BHb8R6yBwI0/ri/QXYf8WTAKyGpb
 b2kXSta+b+QifxyM3pmSxWS1/LXUYw8efmI+oQ1+GRzbQ=
X-Google-Smtp-Source: AGHT+IH57Ic70OcDZo5OCQGowGkp8wvKTWlJneKmUoly7M45UiraQ6csejRQ05IfdI72EZTfy6NbBe3ES/a4OkImaLU=
X-Received: by 2002:a17:902:ef06:b0:21b:b115:1dd9 with SMTP id
 d9443c01a7336-231980d7403mr3225845ad.5.1747161659649; Tue, 13 May 2025
 11:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250513182307.642953-1-David.Wu3@amd.com>
 <20250513182307.642953-2-David.Wu3@amd.com>
In-Reply-To: <20250513182307.642953-2-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 14:40:48 -0400
X-Gm-Features: AX0GCFt4YkS1-E1OsCIhfJgsOArPQStyRLt7Vc6usPdjWdpJktOEyz6Ws-xiIZs
Message-ID: <CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] drm/amdgpu: read back register after written for
 VCN v4.0.0 and v5.0.0
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
 ruijing.dong@amd.com, Mario Limonciello <mario.limonciello@amd.com>
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
> V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start as
>     there are read-back calls already. New comments for better understand=
ing.
>
> Similar to the previous changes made for VCN v4.0.5, the addition of
> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
> prevent potential race conditions, even though such issues have not
> been observed yet. This change ensures consistency across different
> VCN variants and helps avoid similar issues on newer or closely
> related GPUs. The overhead introduced by this read-back is negligible.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Maybe split this into two patches, one for vcn 4 and one for vcn 5.
That will make it easier to backport to stable.  What about other
VCNs?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 8fff470bce873..070a2a8cdf6f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_v=
cn_inst *vinst, bool indirect)
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 27dcc6f37a730..77c27a317e4c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_v=
cn_inst *vinst,
>                 ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>                 VCN_RB1_DB_CTRL__EN_MASK);
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
