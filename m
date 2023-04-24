Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EC7C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 20:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D884210E1E8;
	Mon, 24 Apr 2023 20:20:14 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F95210E1E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 20:20:12 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-541f2112f82so1684415eaf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682367611; x=1684959611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBE3Erry9qGGsGPuSJe4KNpXBT4UjFYQuQ2x4jqHqn8=;
 b=fNbEHne1/bs7Qc6ycJQMQFyhJI7RHzy//cvnrkCOcQh7gWv+C43x1YBHRSHohBVbf/
 nRLeQWn+Tn6p9IbLyoVCmtRsxlEVh6jRZijQd8OGVPv921t103JG5vOlSLzP/YRC8pd/
 vmdRzay5zCWeELuyDW7Rpq7Ql/6ThNyVjzD1tVAW3BMl6vMNE4w5VaSITspnYORoRoLm
 2whrFZSFVyou5wNcOCeltaxo40703c5bXYjzAivH8OltAoDj9UcLU4vW4vaWce1K5lmS
 UJuKB02cHpagMRD8l8nCAw77s+TjImMLCuQZ9YpBn/dzDO4ueAPVOEaJ560sokIJohrG
 x9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682367611; x=1684959611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBE3Erry9qGGsGPuSJe4KNpXBT4UjFYQuQ2x4jqHqn8=;
 b=BMD4P1rYgevul975ToxKZpbc4dAgoa2uB0Oyf8gOAnQ8EnmqofJVtBJxNoLWExKrzF
 +IpbEqnf+E5gEjRAmU3h9xTug2sBWvgB3tXsRtjhfOIbQteAnH9zPVdugfy2IdaAGNyt
 YNS4ugOCgBbk8QZRarZXrYyomaxzdPfJFQpPNBa+3ML8tEkjRL+xOf4scbWi+kuIxlNP
 u1ehr5XG0i8aDvKork5UZzeVq1yRF2D+0wIZw2DxmcTuf3IfBVr3+MJw9yoRVii52GUU
 wPtY801BS5ZME0XHJqQPNOOnTDfj8Wgu6PN90llazvGupMFw56wJ9rEPQW4IzeZgDJ2c
 TYEQ==
X-Gm-Message-State: AAQBX9fUhpU0K4SvCQtJW92V+3Tqc1dIu9OfWU1k/3hEeSah9YjvYd7w
 5LKXsfwiB9PiLj2AX/93bVOKsXmY61+ngyQWtaU=
X-Google-Smtp-Source: AKy350Z3PBbMi/dxQlsFZ5zZxyzpY0Sj1J08w04PxVqRMn7fAtl8MkXUTA0Q0lXByYbTE3Gq9lRLSqgXPAGPq8dlx3w=
X-Received: by 2002:a4a:e911:0:b0:546:d032:a267 with SMTP id
 bx17-20020a4ae911000000b00546d032a267mr5719544oob.2.1682367611334; Mon, 24
 Apr 2023 13:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065443.878721-1-shane.xiao@amd.com>
 <9885713a-b424-dddc-f891-ed7d622c5b91@gmail.com>
 <DM4PR12MB5261E710B9A6F7BA6BF52F009D679@DM4PR12MB5261.namprd12.prod.outlook.com>
 <DM4PR12MB52615C85D3EA998E157686AD9D679@DM4PR12MB5261.namprd12.prod.outlook.com>
 <ac04f565-8336-fff6-e93b-a3021613558e@amd.com>
In-Reply-To: <ac04f565-8336-fff6-e93b-a3021613558e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Apr 2023 16:19:59 -0400
Message-ID: <CADnq5_MFCad6wRFV=tQ6w+QFDsjbQB614dE=-6Hx+9qf++aSUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Xiao, Shane" <shane.xiao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Hou, Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 24, 2023 at 3:11=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 24.04.23 um 16:06 schrieb Xiao, Shane:
> > [AMD Official Use Only - General]
> >> -----Original Message-----
> >> From: Xiao, Shane
> >> Sent: Monday, April 24, 2023 6:31 PM
> >> To: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>; amd-
> >> gfx@lists.freedesktop.org; Deucher, Alexander
> >> <Alexander.Deucher@amd.com>; Zhang, Hawking
> >> <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> >> Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron
> >> <Aaron.Liu@amd.com>
> >> Subject: RE: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BA=
R
> >> successfully
> >>
> >> [AMD Official Use Only - General]
> >>> -----Original Message-----
> >>> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> >>> Sent: Monday, April 24, 2023 5:07 PM
> >>> To: Xiao, Shane <shane.xiao@amd.com>; amd-gfx@lists.freedesktop.org;
> >>> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> >>> <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> >>> Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron
> >>> <Aaron.Liu@amd.com>
> >>> Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring if resize
> >>> BAR successfully
> >>>
> >>> Am 18.04.23 um 08:54 schrieb Shane Xiao:
> >>>> [Why]
> >>>> The selfring doorbell aperture will change when we resize FB BAR
> >>>> successfully during gmc sw init, we should reorder the sequence of
> >>>> enabling doorbell selfring aperture.
> >>> That's a good catch.
> >>>
> >>>> [How]
> >>>> Move enable_doorbell_selfring_aperture from *_common_hw_init to
> >>>> *_common_late_init.
> >>> But that sounds like a bad idea. Instead the full call to
> >>> nv_enable_doorbell_aperture() should be moved around.
> >> Hi Christian,
> >>
> >> Yes,  I get your idea. But as far as I can understand that, the gfx hw=
 init will use
> >> doorbell.
> >> If so, we cannot enable doorbell after gfx hw init.
> > We have come up with two ways to resolve the issue.
> >
> > 1) Separate enable_doorbell_aperture and enable_doorbell_selfring_apert=
ure. However,  the enable_doorbell_selfring_aperture
> > should be moved in *_common_ip_funcs->late_init.
>
> I'm not an expert for this part of the driver, but of hand that sounds
> like the right way of doing it.
>
> Alex any objections?

Yeah, seems reasonable.

Alex

>
> Regards,
> Christian.
>
> > 2) The full call can be moved to gmc hw init.  But it seems strange to =
move nbio configuration into gmc hw init.
> >
> > If neither of the above methods is suitable, could you please give us s=
ome advice on this issue?
> >
> > Best Regards,
> > Shane
> >
> >> Best Regards,
> >> Shane
> >>
> >>> Regards,
> >>> Christian.
> >>>
> >>>> This fixes the potential issue that GPU ring its own doorbell when
> >>>> this device is in translated mode with iommu is on.
> >>>>
> >>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> >>>> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> >>>> Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/nv.c    | 4 +++-
> >>>>    drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-
> >>>>    drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
> >>>>    3 files changed, 9 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/nv.c index 47420b403871..f4c85634a4c8
> >>>> 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >>>> @@ -535,7 +535,8 @@ static void nv_enable_doorbell_aperture(struct
> >>> amdgpu_device *adev,
> >>>>                                            bool enable)
> >>>>    {
> >>>>            adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> >>>> -  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable)=
;
> >>>> +  if (!enable)
> >>>> +          adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
> >>> false);
> >>>>    }
> >>>>
> >>>>    const struct amdgpu_ip_block_version nv_common_ip_block =3D @@
> >>>> -999,6
> >>>> +1000,7 @@ static int nv_common_late_init(void *handle)
> >>>>                    }
> >>>>            }
> >>>>
> >>>> +  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> >>>>            return 0;
> >>>>    }
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>> index bc5dd80f10c1..0202de79a389 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>> @@ -623,7 +623,8 @@ static void
> >>>> soc15_enable_doorbell_aperture(struct
> >>> amdgpu_device *adev,
> >>>>                                               bool enable)
> >>>>    {
> >>>>            adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> >>>> -  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable)=
;
> >>>> +  if (!enable)
> >>>> +          adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
> >>> false);
> >>>>    }
> >>>>
> >>>>    const struct amdgpu_ip_block_version vega10_common_ip_block =3D @=
@
> >>>> -1125,6 +1126,7 @@ static int soc15_common_late_init(void *handle)
> >>>>            if (amdgpu_sriov_vf(adev))
> >>>>                    xgpu_ai_mailbox_get_irq(adev);
> >>>>
> >>>> +  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> >>>>            return 0;
> >>>>    }
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
> >>>> index 514bfc705d5a..cd4619085d67 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> >>>> @@ -454,7 +454,8 @@ static void
> >>>> soc21_enable_doorbell_aperture(struct
> >>> amdgpu_device *adev,
> >>>>                                            bool enable)
> >>>>    {
> >>>>            adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> >>>> -  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable)=
;
> >>>> +  if (!enable)
> >>>> +          adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
> >>> false);
> >>>>    }
> >>>>
> >>>>    const struct amdgpu_ip_block_version soc21_common_ip_block =3D @@
> >>>> -764,6 +765,7 @@ static int soc21_common_late_init(void *handle)
> >>>>                            amdgpu_irq_get(adev, &adev-
> >>>> nbio.ras_err_event_athub_irq, 0);
> >>>>            }
> >>>>
> >>>> +  adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> >>>>            return 0;
> >>>>    }
> >>>>
>
