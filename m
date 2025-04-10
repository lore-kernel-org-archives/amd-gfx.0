Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEBDC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 15:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8597610E9F9;
	Thu, 10 Apr 2025 15:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aiWKExOA";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B026F10E9F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 15:59:30 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b03bc41695eso151242a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744300770; x=1744905570; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbUFUezX3PRAMUT8jmk6teCNVblncion5Z/4OyZlr3I=;
 b=aiWKExOAY4AsxfUahqxH1Yh8cL9fdQ7RGPhVo/bzu4vs/7b+kWVUrOJ/4oUVFCptlr
 Epd8fHpdnDRNsSL/1Z8wb1uh92kMfdeExrnViFAet8+IwXTqvpTmmsBttZLTOlnVbUCf
 DK9mEitDFnbrDyvGbXtLCoTIXcs9fSHBxHNLVocIyQvTtREyfbDBq53uM2VNY+IE/v81
 OsnR4VNBtcFCOD02w5nHPYEeHaLW61p0RX3ghXUG8SkTXyH/XYaFBG9L5Dzlryk2Y7Cw
 rb8b9JYMZ4c6vPcQfljaXfnpErg2shfCHpNNSIYlg33e2hMrtV+3Keb6sNDECS9qGQfM
 Q9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744300770; x=1744905570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbUFUezX3PRAMUT8jmk6teCNVblncion5Z/4OyZlr3I=;
 b=Fsd2YblssgUeBMsf5tGH7AlU+sbL1e20dzKKbU89akX8qL5Z5SRlS8NWmUvfTkvJ9x
 9a03wpB7TROLLrpcAAHAuga81vHAHSmn/TCfTpQTeP0kK4lC7F+vPW1OMdXKMNf9s2WB
 urFRPlSEzTFa7ARI88OWclAQfGqkWDT4a1/kdWPt40TSU3mq/TdUdOx5RCC8jWuXs7Dk
 iHT0AV01QRjntCZWuKGQFTK36HlRd3io+IknGFL4ro5lDYoxNW7d9RPuvUYw5VMv4MU4
 12+oTFRUST7+mMdSY6eSOPCyPtcl673CojEmZJ+s7cnMe9g2p8hgPbhZR+c7r98v2lxe
 sCtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWacIZxUIEh+EjiCSFIjKy8U4EOJBqsOD6kxXeked0P/sT3YJ0X6FKu+fd0VT5IIdmAXMWsH9Il@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfBmSlh2DuKlZZP6bev5h4lyvnAzdBE9fe2EfvAnKxZQmtc+KZ
 gKvJG2Nz57DFRjjBsslbSQ+R7Epz9Pzobukk5P0RE/kSItFE6XFDnE/QLuSpRXl7dr5hiEdj99U
 F1vrMWsCg9j0BlEL7uAWMfNaNlj0=
X-Gm-Gg: ASbGnctbfejmZkhrtH7XfdpOgCALTvkbYtC+PpKbCq1E+WUleCZ8pZw5SMX4c5Z6SiL
 yT8B6grln9IPXoBxkxxVzXbIa45rceJap7eIgr2OSP3Z2Xgi4WfPTIqCJ2dm3SIFMF+Ty++w0y1
 RBufdMFPM1v9KhEIomQgqMKg==
X-Google-Smtp-Source: AGHT+IFtQKk4tAhXF/zgY6RCbcW8Y+lIV4g3ZFgLyubKCQZGcjdrtEa4S0w67iwG4+HKNOneT9fjc1ZjeikKd/PnMTY=
X-Received: by 2002:a17:90b:1a84:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-306dbc3f834mr3958466a91.8.1744300769874; Thu, 10 Apr 2025
 08:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250410145646.51008-1-Arvind.Yadav@amd.com>
 <CADnq5_MeKHVv8YLsxvnBKpUD74Te2K6E1aYtAHJZ+b7+_ZRj8A@mail.gmail.com>
 <a82f9e20-a731-f857-6e09-373251524c44@amd.com>
In-Reply-To: <a82f9e20-a731-f857-6e09-373251524c44@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Apr 2025 11:59:17 -0400
X-Gm-Features: ATxdqUHqt7-WPbNupu2NdBt40zX2S5JqfBjCs5Y2b3vVmlCPzooyDImtsr-RcoE
Message-ID: <CADnq5_NUJdV015SNdCtaxi5nQ19mcHW43b1SCyaXk9qWFRbs=g@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] drm/amdgpu: Add fw minimum version check for
 usermode queue
To: "Yadav, Arvind" <arvyadav@amd.com>
Cc: Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com, shashank.sharma@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Apr 10, 2025 at 11:56=E2=80=AFAM Yadav, Arvind <arvyadav@amd.com> w=
rote:
>
>
> On 4/10/2025 8:50 PM, Alex Deucher wrote:
> > On Thu, Apr 10, 2025 at 10:57=E2=80=AFAM Arvind Yadav <Arvind.Yadav@amd=
.com> wrote:
> >> This patch is load usermode queue based on FW support for gfx11.
> >> CP Ucode FW version: [PFP =3D 2530, ME =3D 2390, MEC =3D 2600, MES =3D=
 120]
> >>
> >> v2: Addressed review comments from Alex.
> >>      - Just check the firmware versions directly.
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Cc: Shashank Sharma <shashank.sharma@amd.com>
> >> Cc: Sunil Khatri <sunil.khatri@amd.com>
> >> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v11_0.c
> >> index 91d29f482c3c..62dcdba589cb 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> @@ -1632,7 +1632,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_b=
lock *ip_block)
> >>          case IP_VERSION(11, 0, 3):
> >>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >>                  /* add firmware version checks here */
> >> -               if (0) {
> >> +               if (adev->gfx.me_fw_version  >=3D 2390 &&
> >> +                   adev->gfx.pfp_fw_version >=3D 2530 &&
> >> +                   adev->gfx.mec_fw_version >=3D 2600 &&
> >> +                   adev->mes.fw_version[0] >=3D 120) {
> >>                          adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &user=
q_mes_funcs;
> >>                          adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &=
userq_mes_funcs;
> >>                  }
> >> @@ -1646,7 +1649,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_b=
lock *ip_block)
> >>          case IP_VERSION(11, 5, 3):
> >>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >>                  /* add firmware version checks here */
> >> -               if (0) {
> >> +               if (adev->gfx.me_fw_version  >=3D 2390 &&
> >> +                   adev->gfx.pfp_fw_version >=3D 2530 &&
> >> +                   adev->gfx.mec_fw_version >=3D 2600 &&
> >> +                   adev->mes.fw_version[0] >=3D 120) {
> > Are you sure this is correct?  I didn't think the firmware is ready
> > yet for these families.
> These version is shared by Mario. I have also added you in that mail.
> Firmware Type    navi4x    Navi3x
> PFP                        2840    2530
> ME                         2780    2390
> MEC                       3050    2600

Those are the dGPUs.  The support for APUs is not ready yet.

Alex

>
> ~arvind
> > Alex
> >
> >>                          adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &user=
q_mes_funcs;
> >>                          adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &=
userq_mes_funcs;
> >>                  }
> >> --
> >> 2.34.1
> >>
