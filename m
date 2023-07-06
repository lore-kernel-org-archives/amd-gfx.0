Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8E7EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE15310E090;
	Thu,  6 Jul 2023 13:56:57 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6E410E090
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:56:56 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b7279544edso656200a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688651815; x=1691243815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfNFK0FWM4NzNfbsnCvUo+0/JCsWxZG8EYqImtxCibs=;
 b=om6xn75mop+HzIm4fzWBIHDs/b9yWeEdwTFOqNoXJKq8Y+NoYIhyoaaPDQpmuRurdZ
 oZNginnLsGkgM/XZVKMcWj9R5ln/32w93D83bGentwWMYtdSuPxh1KKBZbd9Hbnh/JAM
 zqEOdHyLNjPS0D9AekaF9t4Q0NB9bwdpP1AmC2tOlqXGuEoT1Y+HrWBgBIg+1QjaZSE/
 5wdPGRbeH2XglyXegXMMsO8lsmIlacXj7mBf5XQlYxD4FzeiWLdcL7UxJsz3gOc6zeJf
 ie1O8iC8Fgdrx6jdjL/++Gw46WWwwQSFBnPXwUdFfblAv+Pmaso9DueuzaGexZnkOJf0
 DZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688651815; x=1691243815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfNFK0FWM4NzNfbsnCvUo+0/JCsWxZG8EYqImtxCibs=;
 b=Vqg4xaQfjdg4J1FoPSopsvfGfzHgAoIf9piNUeoAoCbU58FCR8oJkEmH+OawGamnPi
 AO5vb18L8XsZZl6XBOsumUb1FXAe1zWkZT/x/DvB5cA2Jbvyvr1D72fT4f0FGz1IPiHh
 YYzO8+KLowiwqYGLbDGtz6dLHCxaAJOd5zWZhjpAE+suaRUEWpKZOvovdTYG8YAdtjDR
 aVNPHDrX84+u2saiWqZZwAS4pqlSu7pmyq04Ib8nobkhFiMZY8i5SglrhSvK2H1FsyZt
 Vw+CwPaS/6wEAEwONaKXXoOh891heB7WzMi8ZKtm/coyD+Doyt5vVSndG8bryVaKV7Nv
 DTUw==
X-Gm-Message-State: ABy/qLbkHKCGqzJ1Zwv2XZlJPpifBcMK4omTln/JCbPlwqnpUw6CB9lH
 e895KlWelcuR4CI6q6PbAqRiGK9je3TtdoIsbbY=
X-Google-Smtp-Source: APBJJlGgTMrIqr2rRAaE3vBtZbEOdcxGIHKu0+Y7Cqz/iMrKyWWrgIVac9StasUzL/DHRccO/2HMTTlJjIkDPE9PTpg=
X-Received: by 2002:a05:6870:1491:b0:1a6:a583:863e with SMTP id
 k17-20020a056870149100b001a6a583863emr2373488oab.24.1688651815171; Thu, 06
 Jul 2023 06:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230620132950.1121406-1-horace.chen@amd.com>
 <9c19a828-15ed-c37a-2c07-acf29f489541@amd.com>
 <1fb0cf4f-3ea4-cd0a-64e9-9d6f22e968f3@amd.com>
 <723872f2-b6cc-2ef6-2168-fc855f3dd7b8@amd.com>
 <DM4PR12MB50728D2B5807050C843AB6FEE12CA@DM4PR12MB5072.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB50728D2B5807050C843AB6FEE12CA@DM4PR12MB5072.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 09:56:44 -0400
Message-ID: <CADnq5_P-doSwi-nJS+=Sq6QExmgUa++Dv3O8HKOrWnq0dz_f_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
To: "Chen, Horace" <Horace.Chen@amd.com>
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 6, 2023 at 4:56=E2=80=AFAM Chen, Horace <Horace.Chen@amd.com> w=
rote:
>
> [AMD Official Use Only - General]
>
> Hi Christian & Leo,
>
> Sorry, missed Leo's email.
>
> Currently SR-IOV VF doesn't have suspend/resume use case and this code is=
 in vcn_v4_0_start_sriov() which will only called by SR-IOV code path. So c=
urrently we will not hit the suspend/resume issue even with this patch.
>
> About why this patch is necessary:
>     Because SR-IOV uses FLR instead of mode 1 reset as the default reset =
method, and FLR will not reset VRAM during the common reset. So if there is=
 some bad data in the cache, it will cause VF continues to fail after reset=
.  We have some test case(such as data poison) which may hit this issue.
>
> If want to be safer in case we may add suspend/resume case in the future:
>     how about add a "if (amdgpu_in_reset(adev))" check to make sure we on=
ly clear cache in the reset domain?

Yes, that seems like a better bet as that will keep suspend and resume work=
ing.

Alex

>
> Thanks & Regards,
> Horace.
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, July 6, 2023 3:24 PM
> To: Liu, Leo <Leo.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; amd-g=
fx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@am=
d.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Chang=
, HaiJun <HaiJun.Chang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Clear VCN cache when hw_init
>
> Since this patch was already pushed please revert it until we have a tech=
nical consent on why this should be necessary.
>
> Regards,
> Christian.
>
> Am 05.07.23 um 21:57 schrieb Leo Liu:
> > What Christian says is correct, esp. during the playback or encode,
> > when suspend/resume happens, it will save the FW context, and after
> > resume, it will continue the job to where it left during the suspend.
> > Will this apply to SRIOV case? Since the changes only within the SRIOV
> > code, please make sure that also please specify the SRIOV from your
> > patch subject and commit message.
> >
> > Regards,
> >
> > Leo
> >
> >
> > On 2023-06-30 07:38, Christian K=C3=B6nig wrote:
> >> Am 20.06.23 um 15:29 schrieb Horace Chen:
> >>> [Why]
> >>> VCN will use some framebuffer space as its cache. It needs to be
> >>> reset when reset happens, such as FLR. Otherwise some error may be
> >>> kept after the reset.
> >>
> >> Well this doesn't make sense at all.
> >>
> >> The full content of adev->vcn.inst[i].cpu_addr is saved and restored
> >> during suspend/resume and IIRC GPU resets as well.
> >>
> >> See functions amdgpu_vcn_suspend() and amdgpu_vcn_resume().
> >>
> >> Please let Leo's team take a look at this and review the change
> >> before it is committed.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Horace Chen <horace.chen@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +++
> >>>   1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> >>> index b48bb5212488..2db73a964031 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> >>> @@ -1292,6 +1292,7 @@ static int vcn_v4_0_start_sriov(struct
> >>> amdgpu_device *adev)
> >>>               cache_size);
> >>>             cache_addr =3D adev->vcn.inst[i].gpu_addr + offset;
> >>> +        memset(adev->vcn.inst[i].cpu_addr + offset, 0,
> >>> AMDGPU_VCN_STACK_SIZE);
> >>>           MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> >>>               regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
> >>>               lower_32_bits(cache_addr)); @@ -1307,6 +1308,8 @@
> >>> static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
> >>>             cache_addr =3D adev->vcn.inst[i].gpu_addr + offset +
> >>>               AMDGPU_VCN_STACK_SIZE;
> >>> +        memset(adev->vcn.inst[i].cpu_addr + offset +
> >>> AMDGPU_VCN_STACK_SIZE, 0,
> >>> +            AMDGPU_VCN_STACK_SIZE);
> >>>           MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
> >>>               regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
> >>>               lower_32_bits(cache_addr));
> >>
>
