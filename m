Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91FBC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 22 May 2022 23:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC9010EAF8;
	Sun, 22 May 2022 23:36:43 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E789E10EAF8
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 May 2022 23:36:41 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id q8so16029476oif.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 May 2022 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fkf3jXtaMt8JO7pgImzxIyR+gpzhCYc94PRAJ+ZWdzo=;
 b=q2dXoCAm2DImscDyhNiuggipEP4O1+DuFn2E8VyI7R1UNY89P7VsGVLzbrE3mmWCrV
 QM0BVPTHNz2RWspsWrQCO/b2skGQrQOPczGmmvw7SwHuOIVMkiSu/FPOB2+1Ic2XZvHE
 HCXXobt9h+14Hewv2oW4VyJ0KypTAS66UqTEp9su/QUbZMoC25Xp818xNmhmnmVX2MgV
 ChYDYEdO7kffSzMgC0+lgsLdv8GQTSFlgNaMm0Tr1k2Lce1dQRZ0hfLAc3WtEHdM3nAM
 iB7QO9j7Ec1ihuORoXOEKzdORDBQ7RhOpV2jT8MajUHYIBVsc7GkwmaQZ2Q7Ovspmr75
 6iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fkf3jXtaMt8JO7pgImzxIyR+gpzhCYc94PRAJ+ZWdzo=;
 b=4eguWPKrm7W9D4M40NDWnmRXaQbvYpcFa63j7j0605kAIkHVYSl48fZ1crG43RT9rz
 /dn3GESaBp8VMGa2BwFMFbA7CF6x7VA/FcTMa2SUL/0tc1P9cmivwHB+jOjl8nL9HKoi
 6UKnZbf/PUx8eqaVsnW9vAdXF/fWy4rmGQacAJvxXu9iHUFBfUcI9eChbQcJ2EuRUFjk
 UL9hh9myHRIe5td1lch4IqnD4FJ1rzxCizOl67/ugjdpNbsrJA+YtM1Zw6Gpqfjn/t9Y
 6RHVoSCiOXTnRBFS8fEfVrwGjam8KaQsuYO2YMFS6kYYZ0oMsDeBRx7rUcYmz49Z04x+
 3BLQ==
X-Gm-Message-State: AOAM5311ed+f04MW2Q6zoNS8DVpXEL9PztejVrmJdc2qIszfuUqW61r+
 STJsOGENWvscDXRinwCG1qKunswnT7mkiXEamJU=
X-Google-Smtp-Source: ABdhPJyAkwrjtr06NLZn4pai89SC50xP7QxryfHyRrnU6qGm8kGlCXttmVAaXMqWMw8k0HkW6LRrYr/tVSCr/WSMVsk=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr10643177oiw.253.1653262601097; Sun, 22
 May 2022 16:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
 <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
 <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
 <CAP+8YyHE79regLR47v29G_qmitR-WOfjOQR-R1nNf5aMVVqFbA@mail.gmail.com>
 <67d39c05-d798-9515-5dec-7a2c4eb534d0@gmail.com>
 <CAAxE2A7opvBLs-VgfyNSSRRctmomZjM7y0C5s8FNuhR2V2Mt5w@mail.gmail.com>
 <7de98c6b-0934-25f4-955f-3362d1cbe954@gmail.com>
In-Reply-To: <7de98c6b-0934-25f4-955f-3362d1cbe954@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 22 May 2022 19:36:30 -0400
Message-ID: <CADnq5_P23BQJtPfx97fm2qqauDKmbNxShUNN9Y9_+6Z49GK79Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, May 22, 2022 at 4:03 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Well, it's not arguing. I'm just pointing out the problems.
>
> Those issues were discovered because I'm trying to raise the limit for a =
couple of years now.

I think simply retesting the problematic tests on a modern system
should be enough.  The old limit was put in place in the Carrizo
timeframe.  Back then boards generally only had 2-4G of system memory.

Alex


>
> I've also already hacked together the necessary functionality, but upstre=
aming them has caused other issues which I don't have time to solve.
>
> If you have time to tackle those, I'm happy to push the necessary patches=
 upstream.
>
> Regards,
> Christian.
>
> Am 20.05.22 um 23:36 schrieb Marek Ol=C5=A1=C3=A1k:
>
> We don't have to care about case 2 here. Broken apps will be handled by a=
pp profiles. The problem is that some games don't work with the current lim=
it on the most powerful consumer APU we've ever made (Rembrandt) with preci=
sely the games that the APU was made for, and instead of increasing the lim=
it, we continue arguing about some TTM stuff that doesn't help anything rig=
ht now.
>
> Marek
>
> On Fri., May 20, 2022, 14:25 Christian K=C3=B6nig, <ckoenig.leichtzumerke=
n@gmail.com> wrote:
>>
>> Am 20.05.22 um 19:41 schrieb Bas Nieuwenhuizen:
>> > On Fri, May 20, 2022 at 11:42 AM Christian K=C3=B6nig
>> > <ckoenig.leichtzumerken@gmail.com> wrote:
>> >> In theory we should allow much more than that. The problem is just th=
at we can't.
>> >>
>> >> We have the following issues:
>> >> 1. For swapping out stuff we need to make sure that we can allocate t=
emporary pages.
>> >>      Because of this TTM has a fixed 50% limit where it starts to unm=
ap memory from GPUs.
>> >>      So currently even with a higher GTT limit you can't actually use=
 this.
>> >>
>> >> 2. Apart from the test case of allocating textures with increasing po=
wer of two until it fails we also have a bunch of extremely stupid applicat=
ions.
>> >>      E.g. stuff like looking at the amount of memory available and tr=
ying preallocate everything.
>> > I hear you but we also have an increasing number of games that don't
>> > even start with 3 GiB. At some point (which I'd speculate has already
>> > been reached, I've seen a number of complaints of games that ran on
>> > deck but not on desktop linux because on deck we set amdgpu.gttsize)
>> > we have more games broken due to the low limit than there would be
>> > apps broken due to a high limit.
>>
>> That's a really good argument, but the issue is that it is fixable. It's
>> just that nobody had time to look into all the issues.
>>
>> If started efforts to fix this years ago, but there was always something
>> more important going on.
>>
>> So we are left with the choice of breaking old applications or new
>> applications or getting somebody working on fixing this.
>>
>> Christian.
>>
>> >
>> >> I'm working on this for years, but there aren't easy solutions to tho=
se issues. Felix has opted out for adding a separate domain for KFD allocat=
ions, but sooner or later we need to find a solution which works for everyb=
ody.
>> >>
>> >> Christian.
>> >>
>> >> Am 20.05.22 um 11:14 schrieb Marek Ol=C5=A1=C3=A1k:
>> >>
>> >> Ignore the silly tests. We only need to make sure games work. The cur=
rent minimum requirement for running modern games is 8GB of GPU memory. Soo=
n it will be 12GB. APUs will need to support that.
>> >>
>> >> Marek
>> >>
>> >> On Fri., May 20, 2022, 03:52 Christian K=C3=B6nig, <ckoenig.leichtzum=
erken@gmail.com> wrote:
>> >>> Am 19.05.22 um 16:34 schrieb Alex Deucher:
>> >>>> The current somewhat strange logic is in place because certain
>> >>>> GL unit tests for large textures can cause problems with the
>> >>>> OOM killer since there is no way to link this memory to a
>> >>>> process.  The problem is this limit is often too low for many
>> >>>> modern games on systems with more memory so limit the logic to
>> >>>> systems with less than 8GB of main memory.  For systems with 8
>> >>>> or more GB of system memory, set the GTT size to 3/4 of system
>> >>>> memory.
>> >>> It's unfortunately not only the unit tests, but some games as well.
>> >>>
>> >>> 3/4 of total system memory sounds reasonable to be, but I'm 100% sur=
e
>> >>> that this will break some tests.
>> >>>
>> >>> Christian.
>> >>>
>> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> >>>> ---
>> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 +++++++++++++++++++=
+-----
>> >>>>    1 file changed, 20 insertions(+), 5 deletions(-)
>> >>>>
>> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ttm.c
>> >>>> index 4b9ee6e27f74..daa0babcf869 100644
>> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> >>>> @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *a=
dev)
>> >>>>        /* Compute GTT size, either bsaed on 3/4th the size of RAM s=
ize
>> >>>>         * or whatever the user passed on module init */
>> >>>>        if (amdgpu_gtt_size =3D=3D -1) {
>> >>>> +             const u64 eight_GB =3D 8192ULL * 1024 * 1024;
>> >>>>                struct sysinfo si;
>> >>>> +             u64 total_memory, default_gtt_size;
>> >>>>
>> >>>>                si_meminfo(&si);
>> >>>> -             gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 2=
0),
>> >>>> -                            adev->gmc.mc_vram_size),
>> >>>> -                            ((uint64_t)si.totalram * si.mem_unit *=
 3/4));
>> >>>> -     }
>> >>>> -     else
>> >>>> +             total_memory =3D (u64)si.totalram * si.mem_unit;
>> >>>> +             default_gtt_size =3D total_memory * 3 / 4;
>> >>>> +             /* This somewhat strange logic is in place because ce=
rtain GL unit
>> >>>> +              * tests for large textures can cause problems with t=
he OOM killer
>> >>>> +              * since there is no way to link this memory to a pro=
cess.
>> >>>> +              * The problem is this limit is often too low for man=
y modern games
>> >>>> +              * on systems with more memory so limit the logic to =
systems with
>> >>>> +              * less than 8GB of main memory.
>> >>>> +              */
>> >>>> +             if (total_memory < eight_GB) {
>> >>>> +                     gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE=
_MB << 20),
>> >>>> +                                        adev->gmc.mc_vram_size),
>> >>>> +                                    default_gtt_size);
>> >>>> +             } else {
>> >>>> +                     gtt_size =3D default_gtt_size;
>> >>>> +             }
>> >>>> +     } else {
>> >>>>                gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
>> >>>> +     }
>> >>>>
>> >>>>        /* Initialize GTT memory pool */
>> >>>>        r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
>>
>
