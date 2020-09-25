Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4024C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 21:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A8621D42
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 21:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpkG/+R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A8621D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8536ED58;
	Fri, 25 Sep 2020 21:13:36 +0000 (UTC)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEDE6ED58
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 21:13:35 +0000 (UTC)
Received: by mail-il1-x143.google.com with SMTP id h2so3655287ilo.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=jqf7Q6vFAggG1bWCBMWd8eYeHmm94tYyDC/Gw7NKK7U=;
 b=XpkG/+R60OvVG77IlApcPIUOM50M4GXDmtol75LGVzxLjaONkB0LB7oJ76OiCCrTiy
 5c9xiQJLdyKjvMq+r/78FJin1T4c0NMZd1i36mJqJyvOfN+ZG7Z2TVzHGMU8AQHiuXHB
 n33RVNXLd4+PxIpqbjGAgw5kxViimK/GXsmmtJTp1Q3WLWnOx7P4LWLVms79gt1aQ+Bs
 KJUScMLPtR5vMAqWwnZdzwFX3B3QjEE4lO6sy+0gsmTjaVjXtsJuZakTgkKIaA1kNItT
 es/ogXYZ08FUvaGJf0gcQZNlXjP9tb4GM2Uh9GCanmHHir/K3o7XHeIiVdSuGnW1euTA
 nj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=jqf7Q6vFAggG1bWCBMWd8eYeHmm94tYyDC/Gw7NKK7U=;
 b=WULjS1WcJRQLVgddjF5LXGjTsn5xFiKa2dNChEMyl7Eu42+nUmMYmqPe7B2CIOL/qz
 uaWvFdVTubqpO7kInvA1PTg6jaGJUq04zsUAhH8wgOF3qt/6ASRIFDNlZ5KL9OJdUrRh
 9IvHG/tECU0Uu4/cNdDIgj+swiTI65BgZ8d5idkPP1lqfyioJZwF/1AUSmUrXrFgJflB
 bBokroGM2Nd15irng5MBhGY3rC0eZ32ZJ+gG8eCXM4l1y/sLo6ZxW7ivoEGWY35Okk78
 BflplaA0KGoYXrdfXrbGwOOyV6YeSJWdJHvY+88T6S9gh7G+iVZISYwRVu/aT19LUrQ4
 3IvA==
X-Gm-Message-State: AOAM531RLb9tmn87eP93hd6UESHzvjbD8OEtr6EGI6Lh/w10I97JOUXT
 k/+lJFwFkEw3q8tVQOeFO0QChJjSDjg=
X-Google-Smtp-Source: ABdhPJySlLPLrmCz5OuHcqcqaQq4p4i3HGu8pYV47mGVRUXTJjoQX9N4Ul4zMbbKRizlVGRsaVEOmw==
X-Received: by 2002:a92:cc0f:: with SMTP id s15mr1825643ilp.254.1601068413994; 
 Fri, 25 Sep 2020 14:13:33 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:aa5e:45ff:fed0:7395?
 ([2602:4b:a6ae:c000:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id e4sm1663509iom.14.2020.09.25.14.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 14:13:33 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
To: Alex Deucher <alexdeucher@gmail.com>
References: <20200924101012.22845-1-evan.quan@amd.com>
 <CADnq5_Nw6mdj38FVqg2Y67_eN04YSm1mSsS04RC09v7BHWNiWA@mail.gmail.com>
 <DM6PR12MB2619DA9B85A535D12D63E915E4360@DM6PR12MB2619.namprd12.prod.outlook.com>
 <d2c11c62-be7b-fe46-e51b-664bb39e210e@gmail.com>
 <CADnq5_MtWWUTPSYHFjQ+yT_Zg0dX9_ad7ggrDCfaMfjLzqbdug@mail.gmail.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <f0e81f87-9c6f-67eb-3f03-d6bde460165f@gmail.com>
Date: Fri, 25 Sep 2020 15:13:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_MtWWUTPSYHFjQ+yT_Zg0dX9_ad7ggrDCfaMfjLzqbdug@mail.gmail.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1972147920=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1972147920==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9gxq5mPMvFoAID9vD1JeshZYnL65c4JjG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9gxq5mPMvFoAID9vD1JeshZYnL65c4JjG
Content-Type: multipart/mixed; boundary="B5ez2Pl4FvInIqgBEQbki4e3bwBz5bdbP"

--B5ez2Pl4FvInIqgBEQbki4e3bwBz5bdbP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Thanks for the quick reply,

Would it make sense, since there seem to be issues with both
before/after initialization, to (temporarily?) add a module parameter
for users so that they can switch between these two behaviors easily
based on what works for them?

If so, if you can toss me a hint at what name for the param would make
sense, I can take a crack at a patch for it, for debugging by the people
in the issue on GitLab.

Cheers, and thanks for the time,
Matt

GL issue for reference:
https://gitlab.freedesktop.org/drm/amd/-/issues/1260

On 9/25/20 3:09 PM, Alex Deucher wrote:
> On Fri, Sep 25, 2020 at 5:05 PM Matt Coffin <mcoffin13@gmail.com> wrote=
:
>>
>> Sorry to bother you guys, but trying to learn about some of these
>> things, and I'm tracking the issue this relates to pretty closely on G=
itLab.
>>
>> What does DAL stand for in this context?
>=20
> DAL is the name of the display team within AMD.
>=20
> Alex
>=20
>>
>> Thanks in advance for the help,
>> Matt
>>
>> On 9/24/20 9:38 PM, Quan, Evan wrote:
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>> That(postpone SOCCLK/UCLK enablement) will be revised and added back =
after confirmed with DAL team.
>>> For now, we just revert it to get around the screen flicker issue int=
roduced.
>>>
>>> BR
>>> Evan
>>> -----Original Message-----
>>> From: Alex Deucher <alexdeucher@gmail.com>
>>> Sent: Thursday, September 24, 2020 9:01 PM
>>> To: Quan, Evan <Evan.Quan@amd.com>
>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander =
<Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 wi=
th 2*4K monitors
>>>
>>> On Thu, Sep 24, 2020 at 6:10 AM Evan Quan <evan.quan@amd.com> wrote:
>>>>
>>>> Revert the guilty change introduced by the commit below:
>>>> drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL
>>>> initialization(V2)
>>>>
>>>> Change-Id: I0cab619ffdf0f83b14ba5d2907e1b9c02a984e2f
>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>
>>> Won't this effectively disable the potential fix for multiple monitor=
s at boot time?
>>>
>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>>> ---
>>>>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 ++++++----------=
---
>>>>  1 file changed, 12 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>> index 1695b36dc23c..be44cb941e73 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>> @@ -316,6 +316,18 @@ navi10_get_allowed_feature_mask(struct smu_cont=
ext *smu,
>>>>         if (smu->dc_controlled_by_gpio)
>>>>                 *(uint64_t *)feature_mask |=3D
>>>> FEATURE_MASK(FEATURE_ACDC_BIT);
>>>>
>>>> +       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
>>>> +               *(uint64_t *)feature_mask |=3D
>>>> + FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
>>>> +
>>>> +       /* DPM UCLK enablement should be skipped for navi10 A0 secur=
e board */
>>>> +       if (!(is_asic_secure(smu) &&
>>>> +            (adev->asic_type =3D=3D CHIP_NAVI10) &&
>>>> +            (adev->rev_id =3D=3D 0)) &&
>>>> +           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
>>>> +               *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_=
DPM_UCLK_BIT)
>>>> +                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCA=
LING_BIT)
>>>> +                               |
>>>> + FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
>>>> +
>>>>         /* DS SOCCLK enablement should be skipped for navi10 A0 secu=
re board */
>>>>         if (is_asic_secure(smu) &&
>>>>             (adev->asic_type =3D=3D CHIP_NAVI10) && @@ -2629,43 +264=
1,12
>>>> @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
>>>>
>>>>  static int navi10_post_smu_init(struct smu_context *smu)  {
>>>> -       struct smu_feature *feature =3D &smu->smu_feature;
>>>>         struct amdgpu_device *adev =3D smu->adev;
>>>> -       uint64_t feature_mask =3D 0;
>>>>         int ret =3D 0;
>>>>
>>>>         if (amdgpu_sriov_vf(adev))
>>>>                 return 0;
>>>>
>>>> -       /* For Naiv1x, enable these features only after DAL initiali=
zation */
>>>> -       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
>>>> -               feature_mask |=3D FEATURE_MASK(FEATURE_DPM_SOCCLK_BI=
T);
>>>> -
>>>> -       /* DPM UCLK enablement should be skipped for navi10 A0 secur=
e board */
>>>> -       if (!(is_asic_secure(smu) &&
>>>> -            (adev->asic_type =3D=3D CHIP_NAVI10) &&
>>>> -            (adev->rev_id =3D=3D 0)) &&
>>>> -           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
>>>> -               feature_mask |=3D FEATURE_MASK(FEATURE_DPM_UCLK_BIT)=

>>>> -                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCA=
LING_BIT)
>>>> -                               | FEATURE_MASK(FEATURE_MEM_MVDD_SCAL=
ING_BIT);
>>>> -
>>>> -       if (!feature_mask)
>>>> -               return 0;
>>>> -
>>>> -       bitmap_or(feature->allowed,
>>>> -                 feature->allowed,
>>>> -                 (unsigned long *)(&feature_mask),
>>>> -                 SMU_FEATURE_MAX);
>>>> -
>>>> -       ret =3D smu_cmn_feature_update_enable_state(smu,
>>>> -                                                 feature_mask,
>>>> -                                                 true);
>>>> -       if (ret) {
>>>> -               dev_err(adev->dev, "Failed to post uclk/socclk dpm e=
nablement!\n");
>>>> -               return ret;
>>>> -       }
>>>> -
>>>>         ret =3D navi10_run_umc_cdr_workaround(smu);
>>>>         if (ret) {
>>>>                 dev_err(adev->dev, "Failed to apply umc cdr
>>>> workaround!\n");
>>>> --
>>>> 2.28.0
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
list
>>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%=
7Cev
>>>> an.quan%40amd.com%7C3899143b7990458f882c08d86089df67%7C3dd8961fe4884=
e6
>>>> 08e11a82d994e183d%7C0%7C0%7C637365492561293539&amp;sdata=3DJ%2FM6YSL=
X6d%
>>>> 2BMO%2B%2FWzdKAW7JlVZM%2FMFRDpTfi6UHkozk%3D&amp;reserved=3D0
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>


--B5ez2Pl4FvInIqgBEQbki4e3bwBz5bdbP--

--9gxq5mPMvFoAID9vD1JeshZYnL65c4JjG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl9uXXkACgkQ4mzKau7F
yAcQKw/+NMBaISqAV+MkbH9f+FSGXtOSwvwg1o8b078GzcMjkSV7YVGLV2XuG+Yf
WC1oVelJZD8Sxl7eD/yQEWrLRSMWkKmQA0gFoj8iDU3zs/fIZBfu2UFRk1YlYEnu
wV4DF6kltr90ngf7hPj2dx9dwEqNcXNe5znAJ4DLvW6QRGTgyQ0qPP+0w/BjI/mA
izNhvAMo/DW8V4vrIjTGEe/zVV64jP6skmeYzYTPaK9LGzkJ8PDJMsMmZJC4VhSK
B1xntLAQoHH1enhrZiwt/EZagJf3nZkgkOlv8G6X4Jdv4Ra8bEGXNq3hESil8zMu
08gU081y1De4MbS9JOEk7OL1dW4Yw3GLyS8yBndai00SiBU1bvUcW5SGYCh5NAzF
fGSudbWPHdw9EbK4/bR54XrvOG7+12CeCTC3Vy8yBSd78WJgXGImKcgGZizJI6+H
IM+ETQo35DIYW6fh1zgryk5lunlUA+Q8kvhoiDTt0wUEazGQcSr8CCRYwO+P6Xta
9OepQ26qJsruGLwlyHjj9hwnU6oHgET+nDfFWupI/VrBgjAlegslw1UwgDTG1pXN
MNWCLBpEio4SFdbB2FbBd/+iS6DMUcffBHToSwU+4R77H9NzpBOMUhLxz220Jawr
e91rPwak5d8PQ8Eis3IcO82UAnHIzr27CzdcoHZckofs9dVBi78=
=JWei
-----END PGP SIGNATURE-----

--9gxq5mPMvFoAID9vD1JeshZYnL65c4JjG--

--===============1972147920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1972147920==--
