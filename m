Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB78ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 15:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5468089208;
	Tue,  6 Sep 2022 15:25:40 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B61B10E6B3
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 15:25:35 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-127a3a39131so8200393fac.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Sep 2022 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=o+euuUXRZhA0i5zZ4+MOS/8hza0ertE6B+X1T6A3EmA=;
 b=n6oYuTJMGIGPBDdbdCsyOWBqUIB1Y6Rl/yZLDB2QNfry5dhAIjl1ZBYqgtEqRHR55C
 ZzmxhODB8ZFSDB0h/BMLczO3CdJvJeK+ylteGbVWsNENk3BPOsjfBnyLTMrL3KFrerQV
 0U45GGg8fZzI5Jtvy8apzFix1QVMvVFqz++pzLEtNfwB/uAU6zpAo/q2oOf91smJ49sC
 RlC97J0OHEO21yqzztl5H6bMOnARxFM4Aue36w7ItiSI39s5EQOBd/xdMkDPNrHNXOr0
 TUIHAZeI5SKrxzKTpYHXzFpD7dlnSBwfTdRAOZVQgx/v8Z2EAsiH6ghqgQpYyzTnyLlx
 1aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=o+euuUXRZhA0i5zZ4+MOS/8hza0ertE6B+X1T6A3EmA=;
 b=ZMXiGBJHlkXk2+3ppk/XMQjyara1N3qX7vudvFzntuVnGOk9bQdQ6BEHDf3e6X4sVa
 II9zfaWUUczHLugSt7uU8oUu5OQIp3zds0q4IcK9HYjw4EqUl+GCx8X2oYl/3+DNZlFz
 3HlYFqRV/A7Cgv1V7xfgKTs7ZqZZZk/Z0eyntxVFiwFbFXntlNCav8gbazsc0kl7ZJSP
 GmsAXLozKd7LxzjFtt+jQTOYtuftCdjM5jVe2yq/Nc1K08CojeKsTHNuUCtrZRZUdaQF
 kKPhGh/8fR20iaVxunyJaLNWre/6fmeoUAPM11tKsS6EJibGe9YfAq/KAP+UYS8XmEkE
 Rb3Q==
X-Gm-Message-State: ACgBeo3gdCzU9NaEmA6KK8p1lv3fCDs/rh1fz2HH+NPueu4I/I1OsB3k
 ffkKgCwOxgjZ1FQ0EtAeQf8MdXWVwafBp/dC3F0WM8KjMso=
X-Google-Smtp-Source: AA6agR5czXGXtvhVwCJYuyMXJpBEScNtlyIWHMPgAK3jBnqOUVGg0RbE7XWHXUF/WRCznHiOBB4BtX1fC5xFWTNRiaY=
X-Received: by 2002:a05:6870:3484:b0:11e:4465:3d9b with SMTP id
 n4-20020a056870348400b0011e44653d9bmr12518028oah.46.1662477934657; Tue, 06
 Sep 2022 08:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220829081752.1258274-1-lijo.lazar@amd.com>
 <CADnq5_O=3u1Z4kH_5A+UsynQ31Grh-=j=3+hPWo398kfMi411w@mail.gmail.com>
 <3b2a9a8f-dedf-2781-0023-d6bd64f16d65@amd.com>
 <CADnq5_P0=+NNk2v_VOxyjOVSnY55SY=OX40xD5Bx6etspREnfA@mail.gmail.com>
 <1890aec6-a92d-e9b7-a782-fd6b0e8f8595@amd.com>
 <CADnq5_Pkpe_-SH8Wh=_s6FXDFEWvO8rr5Ls2=Q4HRXy9+eSOBQ@mail.gmail.com>
 <9ef0287a-e463-d440-58fe-0323a6eca94a@amd.com>
 <CADnq5_P1VV2zWpjtsedPCoJH_CKv+d-MuVJwxOBbdpo1fLFCjA@mail.gmail.com>
 <CADnq5_O1Z0FK99cKDmRuCoxg-hbD3LtcW1q3n4zvrB9xFo0XHw@mail.gmail.com>
 <e90fe5d6-2b19-f253-f2d9-e538c152ec75@amd.com>
In-Reply-To: <e90fe5d6-2b19-f253-f2d9-e538c152ec75@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Sep 2022 11:25:23 -0400
Message-ID: <CADnq5_NmgfsXcXdRpi3NkJKgKGGCZrY-NPmrJtuPmuarCD11OQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Move HDP remapping earlier during init
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Felix.Kuehling@amd.com, stable@vger.kernel.org, tseewald@gmail.com,
 helgaas@kernel.org, amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 sr@denx.de, Christian.Koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 5, 2022 at 1:27 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 9/2/2022 1:09 AM, Alex Deucher wrote:
> > How about this?  We should just move HDP remap to gmc hw_init since
> > that is mainly what uses it anyway.
> >
>
> Sorry, I missed to R-B the previous version. Did you find any problem
> when common block is initialized first?
>

One of the users on the bug report reported an issue with that patch,
that said, that user seems to be seeing a slightly different issue
since he is on a gfx9 card and the original reporter was on gfx10.
https://bugzilla.kernel.org/show_bug.cgi?id=3D216373

Alex


> I think that patch provides a consistent IP init sequence during cold
> init and resume.
>
> Thanks,
> Lijo
>
> > Alex
> >
> > On Tue, Aug 30, 2022 at 2:05 PM Alex Deucher <alexdeucher@gmail.com> wr=
ote:
> >>
> >> On Tue, Aug 30, 2022 at 12:06 PM Lazar, Lijo <lijo.lazar@amd.com> wrot=
e:
> >>>
> >>>
> >>>
> >>> On 8/30/2022 8:39 PM, Alex Deucher wrote:
> >>>> On Tue, Aug 30, 2022 at 10:45 AM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 8/30/2022 7:18 PM, Alex Deucher wrote:
> >>>>>> On Tue, Aug 30, 2022 at 12:05 AM Lazar, Lijo <lijo.lazar@amd.com> =
wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 8/29/2022 10:20 PM, Alex Deucher wrote:
> >>>>>>>> On Mon, Aug 29, 2022 at 4:18 AM Lijo Lazar <lijo.lazar@amd.com> =
wrote:
> >>>>>>>>>
> >>>>>>>>> HDP flush is used early in the init sequence as part of memory =
controller
> >>>>>>>>> block initialization. Hence remapping of HDP registers needed f=
or flush
> >>>>>>>>> needs to happen earlier.
> >>>>>>>>>
> >>>>>>>>> This also fixes the Unsupported Request error reported through =
AER during
> >>>>>>>>> driver load. The error happens as a write happens to the remap =
offset
> >>>>>>>>> before real remapping is done.
> >>>>>>>>>
> >>>>>>>>> Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216373&amp;data=3D05%7=
C01%7Clijo.lazar%40amd.com%7C4e59ae0f8ed54aa7c5a208da8c51aa29%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637976579623485975%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7=
C%7C%7C&amp;sdata=3DWTcd9ImY7Oba0MT6oQ7%2B7UEBkdS6azvqgYoK%2B%2F4mJPg%3D&am=
p;reserved=3D0
> >>>>>>>>>
> >>>>>>>>> The error was unnoticed before and got visible because of the c=
ommit
> >>>>>>>>> referenced below. This doesn't fix anything in the commit below=
, rather
> >>>>>>>>> fixes the issue in amdgpu exposed by the commit. The reference =
is only
> >>>>>>>>> to associate this commit with below one so that both go togethe=
r.
> >>>>>>>>>
> >>>>>>>>> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting =
in get_port_device_capability()")
> >>>>>>>>>
> >>>>>>>>> Reported-by: Tom Seewald <tseewald@gmail.com>
> >>>>>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> >>>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>>
> >>>>>>>> How about something like the attached patch rather than these tw=
o
> >>>>>>>> patches?  It's a bit bigger but seems cleaner and more defensive=
 in my
> >>>>>>>> opinion.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Whenever device goes to suspend/reset and then comes back, remap =
offset
> >>>>>>> has to be set back to 0 to make sure it doesn't use the wrong off=
set
> >>>>>>> when the register assumes default values again.
> >>>>>>>
> >>>>>>> To avoid the if-check in hdp_flush (which is more frequent), anot=
her way
> >>>>>>> is to initialize the remap offset to default offset during early =
init
> >>>>>>> and hw fini/suspend sequences. It won't be obvious (even with thi=
s
> >>>>>>> patch) as to when remap offset vs default offset is used though.
> >>>>>>
> >>>>>> On resume, the common IP is resumed first so it will always be set=
.
> >>>>>> The only case that is a problem is init because we init GMC out of
> >>>>>> order.  We could init common before GMC in amdgpu_device_ip_init()=
.  I
> >>>>>> think that should be fine, but I wasn't sure if there might be som=
e
> >>>>>> fallout from that on certain cards.
> >>>>>>
> >>>>>
> >>>>> There are other places where an IP order is forced like in
> >>>>> amdgpu_device_ip_reinit_early_sriov(). This also may not affect thi=
s
> >>>>> case as remapping is not done for VF.
> >>>>>
> >>>>> Agree that a better way is to have the common IP to be inited first=
.
> >>>>
> >>>> How about these patches?
> >>>>
> >>>
> >>> Looks good to me. BTW, is nbio 7.7 for an APU (in which case hdp flus=
h
> >>> is not expected to be used)?
> >>
> >> It would be used in some cases, e.g., GPU VM passthrough where we use
> >> the BAR rather than the carve out.
> >>
> >> Alex
> >>
> >>
> >>>
> >>> Thanks,
> >>> Lijo
> >>>
> >>>> Alex
> >>>>
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Lijo
> >>>>>
> >>>>>> Alex
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Lijo
> >>>>>>>
> >>>>>>>> Alex
> >>>>>>>>
> >>>>>>>>> ---
> >>>>>>>>> v2:
> >>>>>>>>>             Take care of IP resume cases (Alex Deucher)
> >>>>>>>>>             Add NULL check to nbio.funcs to cover older (GFXv8)=
 ASICs (Felix Kuehling)
> >>>>>>>>>             Add more details in commit message and associate wi=
th AER patch (Bjorn
> >>>>>>>>> Helgaas)
> >>>>>>>>>
> >>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++=
++++++++++++
> >>>>>>>>>      drivers/gpu/drm/amd/amdgpu/nv.c            |  6 ------
> >>>>>>>>>      drivers/gpu/drm/amd/amdgpu/soc15.c         |  6 ------
> >>>>>>>>>      drivers/gpu/drm/amd/amdgpu/soc21.c         |  6 ------
> >>>>>>>>>      4 files changed, 24 insertions(+), 18 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>>>>> index ce7d117efdb5..e420118769a5 100644
> >>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>>>>> @@ -2334,6 +2334,26 @@ static int amdgpu_device_init_schedulers=
(struct amdgpu_device *adev)
> >>>>>>>>>             return 0;
> >>>>>>>>>      }
> >>>>>>>>>
> >>>>>>>>> +/**
> >>>>>>>>> + * amdgpu_device_prepare_ip - prepare IPs for hardware initial=
ization
> >>>>>>>>> + *
> >>>>>>>>> + * @adev: amdgpu_device pointer
> >>>>>>>>> + *
> >>>>>>>>> + * Any common hardware initialization sequence that needs to b=
e done before
> >>>>>>>>> + * hw init of individual IPs is performed here. This is differ=
ent from the
> >>>>>>>>> + * 'common block' which initializes a set of IPs.
> >>>>>>>>> + */
> >>>>>>>>> +static void amdgpu_device_prepare_ip(struct amdgpu_device *ade=
v)
> >>>>>>>>> +{
> >>>>>>>>> +       /* Remap HDP registers to a hole in mmio space, for the=
 purpose
> >>>>>>>>> +        * of exposing those registers to process space. This n=
eeds to be
> >>>>>>>>> +        * done before hw init of ip blocks to take care of HDP=
 flush
> >>>>>>>>> +        * operations through registers during hw_init.
> >>>>>>>>> +        */
> >>>>>>>>> +       if (adev->nbio.funcs && adev->nbio.funcs->remap_hdp_reg=
isters &&
> >>>>>>>>> +           !amdgpu_sriov_vf(adev))
> >>>>>>>>> +               adev->nbio.funcs->remap_hdp_registers(adev);
> >>>>>>>>> +}
> >>>>>>>>>
> >>>>>>>>>      /**
> >>>>>>>>>       * amdgpu_device_ip_init - run init for hardware IPs
> >>>>>>>>> @@ -2376,6 +2396,8 @@ static int amdgpu_device_ip_init(struct a=
mdgpu_device *adev)
> >>>>>>>>>                                     DRM_ERROR("amdgpu_vram_scra=
tch_init failed %d\n", r);
> >>>>>>>>>                                     goto init_failed;
> >>>>>>>>>                             }
> >>>>>>>>> +
> >>>>>>>>> +                       amdgpu_device_prepare_ip(adev);
> >>>>>>>>>                             r =3D adev->ip_blocks[i].version->f=
uncs->hw_init((void *)adev);
> >>>>>>>>>                             if (r) {
> >>>>>>>>>                                     DRM_ERROR("hw_init %d faile=
d %d\n", i, r);
> >>>>>>>>> @@ -3058,6 +3080,7 @@ static int amdgpu_device_ip_reinit_early_=
sriov(struct amdgpu_device *adev)
> >>>>>>>>>                     AMD_IP_BLOCK_TYPE_IH,
> >>>>>>>>>             };
> >>>>>>>>>
> >>>>>>>>> +       amdgpu_device_prepare_ip(adev);
> >>>>>>>>>             for (i =3D 0; i < adev->num_ip_blocks; i++) {
> >>>>>>>>>                     int j;
> >>>>>>>>>                     struct amdgpu_ip_block *block;
> >>>>>>>>> @@ -3139,6 +3162,7 @@ static int amdgpu_device_ip_resume_phase1=
(struct amdgpu_device *adev)
> >>>>>>>>>      {
> >>>>>>>>>             int i, r;
> >>>>>>>>>
> >>>>>>>>> +       amdgpu_device_prepare_ip(adev);
> >>>>>>>>>             for (i =3D 0; i < adev->num_ip_blocks; i++) {
> >>>>>>>>>                     if (!adev->ip_blocks[i].status.valid || ade=
v->ip_blocks[i].status.hw)
> >>>>>>>>>                             continue;
> >>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/=
amd/amdgpu/nv.c
> >>>>>>>>> index b3fba8dea63c..3ac7fef74277 100644
> >>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> >>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> >>>>>>>>> @@ -1032,12 +1032,6 @@ static int nv_common_hw_init(void *handl=
e)
> >>>>>>>>>             nv_program_aspm(adev);
> >>>>>>>>>             /* setup nbio registers */
> >>>>>>>>>             adev->nbio.funcs->init_registers(adev);
> >>>>>>>>> -       /* remap HDP registers to a hole in mmio space,
> >>>>>>>>> -        * for the purpose of expose those registers
> >>>>>>>>> -        * to process space
> >>>>>>>>> -        */
> >>>>>>>>> -       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sr=
iov_vf(adev))
> >>>>>>>>> -               adev->nbio.funcs->remap_hdp_registers(adev);
> >>>>>>>>>             /* enable the doorbell aperture */
> >>>>>>>>>             nv_enable_doorbell_aperture(adev, true);
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/d=
rm/amd/amdgpu/soc15.c
> >>>>>>>>> index fde6154f2009..a0481e37d7cf 100644
> >>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> >>>>>>>>> @@ -1240,12 +1240,6 @@ static int soc15_common_hw_init(void *ha=
ndle)
> >>>>>>>>>             soc15_program_aspm(adev);
> >>>>>>>>>             /* setup nbio registers */
> >>>>>>>>>             adev->nbio.funcs->init_registers(adev);
> >>>>>>>>> -       /* remap HDP registers to a hole in mmio space,
> >>>>>>>>> -        * for the purpose of expose those registers
> >>>>>>>>> -        * to process space
> >>>>>>>>> -        */
> >>>>>>>>> -       if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sr=
iov_vf(adev))
> >>>>>>>>> -               adev->nbio.funcs->remap_hdp_registers(adev);
> >>>>>>>>>
> >>>>>>>>>             /* enable the doorbell aperture */
> >>>>>>>>>             soc15_enable_doorbell_aperture(adev, true);
> >>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/d=
rm/amd/amdgpu/soc21.c
> >>>>>>>>> index 55284b24f113..16b447055102 100644
> >>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> >>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> >>>>>>>>> @@ -660,12 +660,6 @@ static int soc21_common_hw_init(void *hand=
le)
> >>>>>>>>>             soc21_program_aspm(adev);
> >>>>>>>>>             /* setup nbio registers */
> >>>>>>>>>             adev->nbio.funcs->init_registers(adev);
> >>>>>>>>> -       /* remap HDP registers to a hole in mmio space,
> >>>>>>>>> -        * for the purpose of expose those registers
> >>>>>>>>> -        * to process space
> >>>>>>>>> -        */
> >>>>>>>>> -       if (adev->nbio.funcs->remap_hdp_registers)
> >>>>>>>>> -               adev->nbio.funcs->remap_hdp_registers(adev);
> >>>>>>>>>             /* enable the doorbell aperture */
> >>>>>>>>>             soc21_enable_doorbell_aperture(adev, true);
> >>>>>>>>>
> >>>>>>>>> --
> >>>>>>>>> 2.25.1
> >>>>>>>>>
