Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A81C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 13:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2EC10FFA3;
	Thu, 16 Dec 2021 13:53:27 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAFB10FF9E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 13:53:26 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 v15-20020a9d604f000000b0056cdb373b82so29047468otj.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=57mKQeHwGVvowvieepu15cKRSseUflbAZmf2SimMFXY=;
 b=OLE9FE4BXrmLnQxnxy+56lz88vKngkeK7rthOZNuwwX9OdTLXgZcbGzxhbLOGsnHRE
 RSKvCMXzn6TMeBzfbmyc51EK27mRp2VATN+d/HCTCBcl+/4n0mHIW0lfoU9RtzSVNhL0
 BnfVY/mQQGRI56QefE3x9S33o9197Qlsm5iSxZIIMDV2tYVXrJ+oy4eNnq7PlzJsRPw4
 5BU54rBu2JcJXO01fPBsXadlVz6TjcQV2S8AijUCpjVSfUBUH7xL2TsCYXkg7g+9bXYc
 GkUm1b9kJ6kxLka6A3C44MZeLqaKQsuJFOZh5HYXOhZX8crCSn7VNc+dkd0G/kUhZkV2
 R4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=57mKQeHwGVvowvieepu15cKRSseUflbAZmf2SimMFXY=;
 b=6f0RfVOUcM5q9IbdaPUmc22YPzw0tC/+lvu8+12lREB9vXJI6ez22Vvf8ll7kqHNPh
 F1t011Ya4aHEfuOHo53NfaNTQZQ1tr+ulccBB28//Tbnz8zuBM7wgcJXpoFOPKngaC/2
 Q8wAXYlpYa10CKh7PEEJ+QXbOrAuHY/fm/RO5/BPKHzvCtyZFAq8NhgwW44Gw75/SHDL
 CE0F38PJDv4QfDR0dd/kP/UdMwNmsSTi6AoAMTU61GkOA7FksgBK4LnjTLKO/6QmboYQ
 4PI+i4qFotEikU3voPZkmh/FbvO9ep8RcJ7WKvnct4qZ51XV3PDzpTKx/YERlPa0LwK8
 o8GA==
X-Gm-Message-State: AOAM530fMniied+0phYqkUhgNq8HfcgrxSFO/tqDdc2C7PcmJP1lbuT7
 v6NnknMGi9HS9vYvaZkRu2klZmf3sTQtVJt7xSi0/vhc
X-Google-Smtp-Source: ABdhPJyKOJkttoESyGE7L8LabHr5zXpARyNMPMfdPROpGicWsbecMVSVVF3AV0Faxk7FiUcpkxIEkxIUv5NRdlB0Eng=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr13085306ota.200.1639662805380; 
 Thu, 16 Dec 2021 05:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-5-victor.skvortsov@amd.com>
 <CADnq5_OP0=TCPcMprrqFo4HxkXWsZamXkLHa25ZWPEMezM1c_Q@mail.gmail.com>
 <BN9PR12MB5324A5B0B87F3E80B2BCA2728B769@BN9PR12MB5324.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5324A5B0B87F3E80B2BCA2728B769@BN9PR12MB5324.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Dec 2021 08:53:14 -0500
Message-ID: <CADnq5_NHvR5p-7X8VRQKqT_fmpUQeEyVEQLw25a39S0k3b1oCw@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Nieto, David M" <David.Nieto@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 15, 2021 at 6:58 PM Skvortsov, Victor
<Victor.Skvortsov@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hey Alex,
>
> This change was based on the fact that amd-mainline-dkms-5.13 calls get_x=
gmi_info() in gmc_v9_0_early_init(). But I can see that drm-next it's inste=
ad called in gmc_v9_0_sw_init(). So, I'm not sure whats the correct behavio=
r. But I do agree that the change is kind of ugly. I don't know where else =
to put it if we do need to call get_xgmi_info() in early_init.
>

We could skip this patch for drm-next and just apply it to the dkms
branch.  There's already a lot of ugly stuff in there to deal with
multiple kernel versions.

Alex


> Thanks,
> Victor
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, December 15, 2021 4:38 PM
> To: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deng, Emily <Emily.Deng=
@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Ming, Davis <Davis.Ming@amd.com>; =
Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Ch=
en, JingWen <JingWen.Chen2@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Ni=
eto, David M <David.Nieto@amd.com>
> Subject: Re: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function po=
inters
>
> [CAUTION: External Email]
>
> On Wed, Dec 15, 2021 at 1:56 PM Victor Skvortsov <victor.skvortsov@amd.co=
m> wrote:
> >
> > In SRIOV, RLC function pointers must be initialized early as we rely
> > on the RLCG interface for all GC register access.
> >
> > Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 3 +--
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h         | 2 ++
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index 65e1f6cc59dd..1bc92a38d124 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -844,6 +844,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct=
 amdgpu_device *adev)
> >         case IP_VERSION(9, 4, 1):
> >         case IP_VERSION(9, 4, 2):
> >                 amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
> > +               if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP]=
[0] =3D=3D IP_VERSION(9, 4, 2))
> > +                       gfx_v9_0_set_rlc_funcs(adev);
>
> amdgpu_discovery.c is IP independent.  I'd rather not add random IP speci=
fic function calls.  gfx_v9_0_set_rlc_funcs() already gets called in gfx_v9=
_0_early_init().  Is that not early enough?  In general we shouldn't be tou=
ching the hardware much if at all in early_init.
>
> Alex
>
> >                 break;
> >         case IP_VERSION(10, 1, 10):
> >         case IP_VERSION(10, 1, 2):
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index edb3e3b08eed..d252b06efa43 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -816,7 +816,6 @@ static void gfx_v9_0_sriov_wreg(struct
> > amdgpu_device *adev, u32 offset,  static void
> > gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev);  static void
> > gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);  static void
> > gfx_v9_0_set_gds_init(struct amdgpu_device *adev); -static void
> > gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);  static int gfx_v9_=
0_get_cu_info(struct amdgpu_device *adev,
> >                                 struct amdgpu_cu_info *cu_info);
> > static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device
> > *adev); @@ -7066,7 +7065,7 @@ static void gfx_v9_0_set_irq_funcs(struct=
 amdgpu_device *adev)
> >         adev->gfx.cp_ecc_error_irq.funcs =3D
> > &gfx_v9_0_cp_ecc_error_irq_funcs;  }
> >
> > -static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
> > +void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
> >  {
> >         switch (adev->ip_versions[GC_HWIP][0]) {
> >         case IP_VERSION(9, 0, 1):
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> > index dfe8d4841f58..1817e252354f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
> > @@ -29,4 +29,6 @@ extern const struct amdgpu_ip_block_version
> > gfx_v9_0_ip_block;  void gfx_v9_0_select_se_sh(struct amdgpu_device *ad=
ev, u32 se_num, u32 sh_num,
> >                            u32 instance);
> >
> > +void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
> > +
> >  #endif
> > --
> > 2.25.1
> >
