Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F06CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 14:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2DC10E82C;
	Wed,  8 Oct 2025 14:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QH/Au9x5";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7091A10E82C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 14:13:08 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2699ef1b4e3so10135585ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Oct 2025 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759932788; x=1760537588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttPTpfCXy8sLPoVgxPsQRF1tu31m+OSwaJl5YYnT1HI=;
 b=QH/Au9x5omMylHJW27qI0FgJ3hHjtf8JhPL/kWlfZYauukoyxq9YV7NouWoteh1vpC
 iS1YgTeFhPqE+1QPZ4hrNwpnlPgnlDVHqf3O383AN8Go+g7N3NaltRSPvawoEcOqJ9C/
 VTHMOMUgO2sgiu3C0zd6JZY3QYaOQatV3jVireIgEv59fVWjq6sIvN6RSGH083y+Vg5p
 DPI2oZjhbV2tA8RZfs97xQfteuXMvKFaHToxx5GlmRpitsbzZT0tPZBlaeNCmMTBy5zY
 pVe+tfN9FPtjRtvf9pbf/tEcx8ccpn8ZO5t0K2OJCEnWS+NJ9jgqE9IJY7XuFRsVsiws
 YYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932788; x=1760537588;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttPTpfCXy8sLPoVgxPsQRF1tu31m+OSwaJl5YYnT1HI=;
 b=gQgFSYuRHL2pvUnOua34s+/4Vqgbt4ycJTN9CHEGGmnwB0Z5JMro6wD9SuSetSqBKZ
 cD09hn1FqBU5yxOmxmW4xWke99Ja/wfTkckkiCLNTk3Y72So3yr3dzILCwYiVg4WvUpZ
 QFZEzxpbMTRV2cEeiB2sa4scM27N+SBkYlRRnF5PIWDG2RvHRX7ITxUZ5V2BgE1/6jmT
 j3Im99U8xdr5sVLL1LrLHSe5kZBPjpZRuJDUwwVStmpsuTYgu0kZtx8wyzm5ilLl9nYQ
 jRMddydt+PT6RCIfjTBCH+TBth2WdgNfb7MbH0Zfus9/5QQIO6r6Ipy43TDfGTb8kd0c
 47YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8LzD4qWFbJGZLjn43oawlyd72LofoQDLsejFD/Ks7Moh7bgIMd4BjzNGg2L5vkceGesLHF/Ty@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrlCzlCT8aha3A2M0rrCovrFaXbayIr96WdrmlQ3u8HICpRt27
 YixO2MdDewAlvnDewundNMZHaXUlpkiDRT5pTckoKfHOWRGcKAmiwz5z0Flv5AVOjHgyKXXQR54
 BR14sQM1eEpFvipNRV9DxuBhbJbHoI/M=
X-Gm-Gg: ASbGncucQz1UcqmPQiB7HdxcBRPmxG8XqvJxodKEZ8uXxn6bWFBpt3zGaZjxdiTC+/k
 8si9c1i+DK6NiqrJfvmGezBBS3RMKequOEjSWBKq0ir18tmtoMU36HSfxF6pCPIOANnnZQJFg7s
 YvHIKv0hepVOeNBlxJWU3FgdJBxbVOnHIsZKkWY62Tk4q4AdYd4hnlnbgt4S8D1f7s4zCqfHvVE
 PS9tYrbSDzi8U0xqgvAqSaYQitMkIdoYyGOZdpfgA==
X-Google-Smtp-Source: AGHT+IHFSit4qLZ4FvOtTkbgjGo8CJYFZ8A0ldXrckWnc6609NobtbBsDLNdiC/DXDXsJrS9gQyAvJPFGOfG/myE6Qc=
X-Received: by 2002:a17:902:d4c1:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-290272e3d33mr29431345ad.6.1759932787721; Wed, 08 Oct 2025
 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250926230535.5632-1-alexander.deucher@amd.com>
 <CADnq5_Pp5JRtW_4TiJXULB_kptF_hCdeaBbLQq_N1N2Me3Gc1Q@mail.gmail.com>
 <DS0PR12MB7993CB03D5826E8FF8DA74D4F7E1A@DS0PR12MB7993.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7993CB03D5826E8FF8DA74D4F7E1A@DS0PR12MB7993.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Oct 2025 10:12:55 -0400
X-Gm-Features: AS18NWB7OEwySA4QOpvAHCSNmcMZ_HONZYUS5ZlRMWlQg-bpPlrbSoj81BYJdgM
Message-ID: <CADnq5_N_+H0H1PE+ptWwgXaBO78=nF76es3BEUgXapWOY8j-rQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discovery
 firmware
To: "StDenis, Tom" <Tom.StDenis@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Oct 8, 2025 at 9:23=E2=80=AFAM StDenis, Tom <Tom.StDenis@amd.com> w=
rote:
>
> I can't test the patch myself as I got rid of all my older gear recently.

It fixed things on my vega boards.  Care to review or ack the patch?

Alex

>
> Tom
>
>
> ________________________________________
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, October 8, 2025 09:16
> To: Deucher, Alexander
> Cc: amd-gfx@lists.freedesktop.org; StDenis, Tom
> Subject: Re: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discov=
ery firmware
>
> Ping?
>
> On Fri, Sep 26, 2025 at 7:44=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Chips which use the IP discovery firmware loaded by the driver
> > reported incorrect harvesting information in the ip discovery
> > table in sysfs because the driver only uses the ip discovery
> > firmware for populating sysfs and not for direct parsing for the
> > driver itself as such, the fields that are used to print the
> > harvesting info in sysfs report incorrect data for some IPs.  Populate
> > the relevant fields for this case as well.
> >
> > Fixes: 514678da56da ("drm/amdgpu/discovery: fix fw based ip discovery")
> > Cc: Tom St Denis <tom.stdenis@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index 73401f0aeb346..dd7b2b796427c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -1033,7 +1033,9 @@ static uint8_t amdgpu_discovery_get_harvest_info(=
struct amdgpu_device *adev,
> >         /* Until a uniform way is figured, get mask based on hwid */
> >         switch (hw_id) {
> >         case VCN_HWID:
> > -               harvest =3D ((1 << inst) & adev->vcn.inst_mask) =3D=3D =
0;
> > +               /* VCN vs UVD+VCE */
> > +               if (!amdgpu_ip_version(adev, VCE_HWIP, 0))
> > +                       harvest =3D ((1 << inst) & adev->vcn.inst_mask)=
 =3D=3D 0;
> >                 break;
> >         case DMU_HWID:
> >                 if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
> > @@ -2565,7 +2567,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
> >                 amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> > +               adev->sdma.sdma_mask =3D 3;
> >                 adev->gmc.num_umc =3D 4;
> > +               adev->gfx.xcc_mask =3D 1;
> >                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 0, 0=
);
> >                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 0, 0=
);
> >                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 0, =
0);
> > @@ -2592,7 +2596,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
> >                 amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> > +               adev->sdma.sdma_mask =3D 3;
> >                 adev->gmc.num_umc =3D 4;
> > +               adev->gfx.xcc_mask =3D 1;
> >                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 3, 0=
);
> >                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 3, 0=
);
> >                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 0, =
1);
> > @@ -2619,8 +2625,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 amdgpu_discovery_init(adev);
> >                 vega10_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 1;
> > +               adev->sdma.sdma_mask =3D 1;
> >                 adev->vcn.num_vcn_inst =3D 1;
> >                 adev->gmc.num_umc =3D 2;
> > +               adev->gfx.xcc_mask =3D 1;
> >                 if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
> >                         adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION=
(9, 2, 0);
> >                         adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION=
(9, 2, 0);
> > @@ -2665,7 +2673,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
> >                 amdgpu_discovery_init(adev);
> >                 vega20_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 2;
> > +               adev->sdma.sdma_mask =3D 3;
> >                 adev->gmc.num_umc =3D 8;
> > +               adev->gfx.xcc_mask =3D 1;
> >                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 0=
);
> >                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 0=
);
> >                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 2, =
0);
> > @@ -2693,8 +2703,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 amdgpu_discovery_init(adev);
> >                 arct_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 8;
> > +               adev->sdma.sdma_mask =3D 0xff;
> >                 adev->vcn.num_vcn_inst =3D 2;
> >                 adev->gmc.num_umc =3D 8;
> > +               adev->gfx.xcc_mask =3D 1;
> >                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 1=
);
> >                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 1=
);
> >                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 2, =
1);
> > @@ -2726,8 +2738,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu=
_device *adev)
> >                 amdgpu_discovery_init(adev);
> >                 aldebaran_reg_base_init(adev);
> >                 adev->sdma.num_instances =3D 5;
> > +               adev->sdma.sdma_mask =3D 0x1f;
> >                 adev->vcn.num_vcn_inst =3D 2;
> >                 adev->gmc.num_umc =3D 4;
> > +               adev->gfx.xcc_mask =3D 1;
> >                 adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 2=
);
> >                 adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 2=
);
> >                 adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 4, =
0);
> > @@ -2762,6 +2776,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
> >                 } else {
> >                         cyan_skillfish_reg_base_init(adev);
> >                         adev->sdma.num_instances =3D 2;
> > +                       adev->sdma.sdma_mask =3D 3;
> > +                       adev->gfx.xcc_mask =3D 1;
> >                         adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION=
(2, 0, 3);
> >                         adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION=
(2, 0, 3);
> >                         adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSIO=
N(5, 0, 1);
> > --
> > 2.51.0
> >
