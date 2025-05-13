Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E182C3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 17:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D158310E5B6;
	Tue, 13 May 2025 17:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DcfYR3oD";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A993F10E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 17:55:31 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2317f90a931so1256785ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747158931; x=1747763731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wzkZCXyXd9rqf1l3QUizvgGLyX2iFgmixpDBZODhVY=;
 b=DcfYR3oDQqf1Wt1z8GEhxWPV+7t+UPxheHzleWzAb1EKJhH8rGszebxtuKAVrBgzVN
 tH/rseH6Lq0a8bqBmLzkY2c/6GA9p8guboFr1XCtnlizC5oAdWZRkKQmMhDROLneP64l
 4LF0HDpxy5jtHsbamkial9R48EbgYjtsPR9DTXBAGbMDmja8z0aHAsvvyV/teYvWVdam
 lxs+9qcIwDhxLercq5kUZRXQ98uent1E510FI8UnYOPc9ejJlStEmyZ60IsTerY41s9f
 OYqGn80YJ8PuLVmndWoe6K4BhK8jmSd+qUneiRLiIoHFjx7V536JtrRMQcLnO9yT+Lxk
 ZplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158931; x=1747763731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wzkZCXyXd9rqf1l3QUizvgGLyX2iFgmixpDBZODhVY=;
 b=TPoIKnpGpiCrVHwCazSaTyJQqMoEepglgvknSr+/cKc1mZbJ+/ogNYgYvtmmRBWEr9
 Ow4qGBRP/8P14nY+aCxkDeX/rub942Ru+80bODJ6aeqHvdHU3XtZaFmwdfph7L5TdLo1
 NNohpq7z6VYsVJfbObYQUJG4SUhJLcmpdHSwFYUqF3pO4eqdXVSptsYBfgOrYelrSpZD
 GMFOVGm0DF9kjcbV+UBiklezIqkypoR5YmXJhrcUQM6CA0jjsKGg1QN54/gPpfYSqO+x
 bqutiWNVsmgALonSv/fAzMiJT3haj+l6Vr+/dW5RM3hFSp/ngxD2ehQyu4RAFz70epqg
 9jzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkDRZoGwzIXyZYhYOU7GyhFarCv2BjySQsPjzq7y8gTrknX2tOzD5lXZzxKoZXe/AjqtWb0yVC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsigUZ7Duep7a8Ao9kdjkGSiWFs+ARJIna0LuRaedb4V6UZsn2
 INC+wPhb3LCp5ytL+toOec3mNHv6BCnqBQkj5Bv7X6cDNbnxduPj9KUAVPXtGFgo22fiszgZIf1
 dlC8Bq52j8jAeO6uUWe1gtSWgKjq3zA==
X-Gm-Gg: ASbGnctch8cyMrxvMFk8MCUfwYvkYMijDtRK5eXRyCYAUeULLph7uf/WXaj1npxGYpY
 d5iX8No928FXs60DRFtUiillpFRASae+gYgELLTqwmh5G9pcqUVnD9f48A7zIKdJRrz7v0M/kzw
 MQTodFPBh45ey0Z7gfQawgeWVRbtYIBqx/KeiEpuiFxGs=
X-Google-Smtp-Source: AGHT+IEFKNCctKQt9AOmcZ2kDPxtQlOzjyUROCylpXH1Xo4N103v3vfaXrk7GNnvBNOazLrZo8uCvchY+6QZl5vqpU4=
X-Received: by 2002:a17:902:d482:b0:220:e1e6:446e with SMTP id
 d9443c01a7336-231980befe4mr2035585ad.1.1747158931128; Tue, 13 May 2025
 10:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250513162912.634716-1-David.Wu3@amd.com>
 <CADnq5_P5QrYhLEzkwPUMvgYSmk8NkTOusa1dmBFD=veNfshBAA@mail.gmail.com>
 <23d465ec-a15c-43ae-ba1e-052cf342ba43@amd.com>
 <SJ1PR12MB6194CA9BCEAB6A35205822449596A@SJ1PR12MB6194.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB6194CA9BCEAB6A35205822449596A@SJ1PR12MB6194.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 13:55:17 -0400
X-Gm-Features: AX0GCFsMXBqDJPw6Qjep7DZXwNB3U-a660PrQidhpwFu18lR68gBGzFYdoFDb4k
Message-ID: <CADnq5_OZqv_2NAEPqX9RB3OSY0S6F7zny6hhVErw2j-vSR9TBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after written
 for VCN v4.0.5
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>
Cc: "Wu, David" <David.Wu3@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
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

On Tue, May 13, 2025 at 1:54=E2=80=AFPM Dong, Ruijing <Ruijing.Dong@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Then dummy read should not be limited to this register regVCN_RB1_DB_CTRL=
, it can be any valid readable register just for posting the previous write=
 operations.

Right.  Any register will do.

Alex

>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Tuesday, May 13, 2025 12:48 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Wu, David <David.Wu3@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@a=
md.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@am=
d.com>; stable@vger.kernel.org
> Subject: Re: [PATCH 1/2] drm/amdgpu: read back DB_CTRL register after wri=
tten for VCN v4.0.5
>
> sounds great! will adjust accordingly.
>
> David
>
> On 2025-05-13 12:44, Alex Deucher wrote:
> > On Tue, May 13, 2025 at 12:38=E2=80=AFPM David (Ming Qiang) Wu
> > <David.Wu3@amd.com> wrote:
> >> On VCN v4.0.5 there is a race condition where the WPTR is not updated
> >> after starting from idle when doorbell is used. The read-back of
> >> regVCN_RB1_DB_CTRL register after written is to ensure the
> >> doorbell_index is updated before it can work properly.
> >>
> >> Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> >> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >> index ed00d35039c1..d6be8b05d7a2 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >> @@ -1033,6 +1033,8 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdg=
pu_vcn_inst *vinst,
> >>          WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
> >>                          ring->doorbell_index << VCN_RB1_DB_CTRL__OFFS=
ET__SHIFT |
> >>                          VCN_RB1_DB_CTRL__EN_MASK);
> >> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> >> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
> >>
> >>          return 0;
> >>   }
> >> @@ -1195,6 +1197,8 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_in=
st *vinst)
> >>          WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> >>                       ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET_=
_SHIFT |
> >>                       VCN_RB1_DB_CTRL__EN_MASK);
> >> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> >> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
> > You might want to move this one down to the end of the function to
> > post the other subsequent writes.  Arguably all of the VCNs should do
> > something similar.  If you want to make sure a PCIe write goes
> > through, you need to issue a subsequent read.  Doing this at the end
> > of each function should post all previous writes.
> >
> > Alex
> >
> >>          WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> >>          WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI,
> >> upper_32_bits(ring->gpu_addr));
> >> --
> >> 2.49.0
> >>
