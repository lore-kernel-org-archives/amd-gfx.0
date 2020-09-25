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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AECC4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 21:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849DE239D1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 21:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd4v39IL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849DE239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23FD6ED4A;
	Fri, 25 Sep 2020 21:05:40 +0000 (UTC)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB6A6ED4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 21:05:40 +0000 (UTC)
Received: by mail-io1-xd42.google.com with SMTP id g128so4430147iof.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=jJHn3YJAhdeysxfBfGGPm1twoRH6U0d7W/xtvLx3AYg=;
 b=Fd4v39ILKLNqReLuMocPv/jxOFhFgaNNT9OhCr0h495a53UnhZfsJkTXKJZPZ2qhyw
 ty5Vug609AWWM1lKQt8SKRzEmHMQWDF29GlC5HAY4azDti6uJssinaBstTpPV4JYn9Y4
 +NrM6uTKBXB707wkxxAa/Q4o/3fMWccXd7bRABxR2/HdKTViHh6YQ+M7avFjW04lZwAZ
 2U++BX4FkmpDv2RtzAlvEW8Xp2+1U6kQjLY/8fz0l7cB+oeG5zSAeDfz+ZobtAwgOJt9
 tJsJLwAdJOPHxV2NmqvdU5nmlv5dW4iKnt0ikCIUZ7EKhWdpMc425PKeCDVjVNH2OObV
 pGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=jJHn3YJAhdeysxfBfGGPm1twoRH6U0d7W/xtvLx3AYg=;
 b=EGt0SADwdtuIzMghCRgDMEgBJ1q+G75eaM4dEqLu557+svCu5M+JIAHfmYVW3BWbZ4
 saV1GBWEoECZ0Dxl9U9ExBRBQjEkMgaQ7Dk/7XkrNwcBQO1HC9gp95cYSBlVAGnGFykC
 qZI/m+wPV24MVqyoScXkIp8H9jWa3GMTaecoSRsOfNK/rP6F1O4Z4oLce4tvZL+Sh2TL
 +F4ih1sYclnB32Q+YDXp84uDQi5BxfR5NObr453qqyyD+zD642JUwB1XHOmspmYLtWDp
 d/SdyOUqurg+7yX26LeCdV3gGiOHJdKjbZdBs1paVLLHJm28RuDExusnpQUvvWFE7LCJ
 +j7g==
X-Gm-Message-State: AOAM5314MHrmkWhytavDpj1rOsV36tGzqQgj/t2+Lb1ivx1NqeXaBVrQ
 WnVfPRPpSEiiaM+S1fKi6LXV0ybQisI=
X-Google-Smtp-Source: ABdhPJxxaHncE8lGImaXBZ8Ro3JGOk+rWkzQaYNST74ZnWkGVb7K6i6VemJdotYKydzvEgmqZFOZiw==
X-Received: by 2002:a6b:680f:: with SMTP id d15mr354843ioc.198.1601067939032; 
 Fri, 25 Sep 2020 14:05:39 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:aa5e:45ff:fed0:7395?
 ([2602:4b:a6ae:c000:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id c7sm2052044iln.43.2020.09.25.14.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 14:05:37 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20200924101012.22845-1-evan.quan@amd.com>
 <CADnq5_Nw6mdj38FVqg2Y67_eN04YSm1mSsS04RC09v7BHWNiWA@mail.gmail.com>
 <DM6PR12MB2619DA9B85A535D12D63E915E4360@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <d2c11c62-be7b-fe46-e51b-664bb39e210e@gmail.com>
Date: Fri, 25 Sep 2020 15:05:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB2619DA9B85A535D12D63E915E4360@DM6PR12MB2619.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============2070886682=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2070886682==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5dVAibYHSEJNYNSznYvluZDNqqc0ZPIDo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5dVAibYHSEJNYNSznYvluZDNqqc0ZPIDo
Content-Type: multipart/mixed; boundary="6ffNtEkw1qDOkRrQmoFyxjfmhjeODBe5Y"

--6ffNtEkw1qDOkRrQmoFyxjfmhjeODBe5Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Sorry to bother you guys, but trying to learn about some of these
things, and I'm tracking the issue this relates to pretty closely on GitL=
ab.

What does DAL stand for in this context?

Thanks in advance for the help,
Matt

On 9/24/20 9:38 PM, Quan, Evan wrote:
> [AMD Official Use Only - Internal Distribution Only]
>=20
> That(postpone SOCCLK/UCLK enablement) will be revised and added back af=
ter confirmed with DAL team.
> For now, we just revert it to get around the screen flicker issue intro=
duced.
>=20
> BR
> Evan
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, September 24, 2020 9:01 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <A=
lexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with=
 2*4K monitors
>=20
> On Thu, Sep 24, 2020 at 6:10 AM Evan Quan <evan.quan@amd.com> wrote:
>>
>> Revert the guilty change introduced by the commit below:
>> drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL
>> initialization(V2)
>>
>> Change-Id: I0cab619ffdf0f83b14ba5d2907e1b9c02a984e2f
>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>=20
> Won't this effectively disable the potential fix for multiple monitors =
at boot time?
>=20
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>=20
>> ---
>>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 ++++++------------=
-
>>  1 file changed, 12 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index 1695b36dc23c..be44cb941e73 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -316,6 +316,18 @@ navi10_get_allowed_feature_mask(struct smu_contex=
t *smu,
>>         if (smu->dc_controlled_by_gpio)
>>                 *(uint64_t *)feature_mask |=3D
>> FEATURE_MASK(FEATURE_ACDC_BIT);
>>
>> +       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
>> +               *(uint64_t *)feature_mask |=3D
>> + FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
>> +
>> +       /* DPM UCLK enablement should be skipped for navi10 A0 secure =
board */
>> +       if (!(is_asic_secure(smu) &&
>> +            (adev->asic_type =3D=3D CHIP_NAVI10) &&
>> +            (adev->rev_id =3D=3D 0)) &&
>> +           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
>> +               *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DP=
M_UCLK_BIT)
>> +                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALI=
NG_BIT)
>> +                               |
>> + FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
>> +
>>         /* DS SOCCLK enablement should be skipped for navi10 A0 secure=
 board */
>>         if (is_asic_secure(smu) &&
>>             (adev->asic_type =3D=3D CHIP_NAVI10) && @@ -2629,43 +2641,=
12
>> @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
>>
>>  static int navi10_post_smu_init(struct smu_context *smu)  {
>> -       struct smu_feature *feature =3D &smu->smu_feature;
>>         struct amdgpu_device *adev =3D smu->adev;
>> -       uint64_t feature_mask =3D 0;
>>         int ret =3D 0;
>>
>>         if (amdgpu_sriov_vf(adev))
>>                 return 0;
>>
>> -       /* For Naiv1x, enable these features only after DAL initializa=
tion */
>> -       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
>> -               feature_mask |=3D FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)=
;
>> -
>> -       /* DPM UCLK enablement should be skipped for navi10 A0 secure =
board */
>> -       if (!(is_asic_secure(smu) &&
>> -            (adev->asic_type =3D=3D CHIP_NAVI10) &&
>> -            (adev->rev_id =3D=3D 0)) &&
>> -           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
>> -               feature_mask |=3D FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
>> -                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALI=
NG_BIT)
>> -                               | FEATURE_MASK(FEATURE_MEM_MVDD_SCALIN=
G_BIT);
>> -
>> -       if (!feature_mask)
>> -               return 0;
>> -
>> -       bitmap_or(feature->allowed,
>> -                 feature->allowed,
>> -                 (unsigned long *)(&feature_mask),
>> -                 SMU_FEATURE_MAX);
>> -
>> -       ret =3D smu_cmn_feature_update_enable_state(smu,
>> -                                                 feature_mask,
>> -                                                 true);
>> -       if (ret) {
>> -               dev_err(adev->dev, "Failed to post uclk/socclk dpm ena=
blement!\n");
>> -               return ret;
>> -       }
>> -
>>         ret =3D navi10_run_umc_cdr_workaround(smu);
>>         if (ret) {
>>                 dev_err(adev->dev, "Failed to apply umc cdr
>> workaround!\n");
>> --
>> 2.28.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
st
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7C=
ev
>> an.quan%40amd.com%7C3899143b7990458f882c08d86089df67%7C3dd8961fe4884e6=

>> 08e11a82d994e183d%7C0%7C0%7C637365492561293539&amp;sdata=3DJ%2FM6YSLX6=
d%
>> 2BMO%2B%2FWzdKAW7JlVZM%2FMFRDpTfi6UHkozk%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--6ffNtEkw1qDOkRrQmoFyxjfmhjeODBe5Y--

--5dVAibYHSEJNYNSznYvluZDNqqc0ZPIDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl9uW6EACgkQ4mzKau7F
yAdjwxAA1Q9R8ctl/rPcIVQMNzjEatrzNOKd/wGs//BcEX1q9MEZjlai8/bx6Had
KVjTRQ54WXM6LQXFui8dS5tuRJNWlofW2MgZO5DAd9G85qPXF/uJA1vSSAP2qvGL
Hz0xp4k2XX8e8y5gGQOAqLVOYvc4KYyDwdUV7kSNDH0brwlsmm2wI0ShhXv9omMZ
3LF5JqcFLlFHBW/mSbQbzba33ZlReBIGKd9z+WGLK6J3jOWlOoMQzjrW+v75Ovk4
Ude8UUhUD2mKEPk1qM8W93tXYL84mXaqSWA+vHjIX87k7X/xcHxf1uwwm/cnnuso
lpctR9Zflqb5LvfiIZql5GH9nZd4uBeDZVUlEjQRWaGDkYf1W3I3AFz8J8eHYWXu
tGewrynK9VCq1GHPNDsQsh8xoIXVrYQTKmNFGShsP8a1rTFF6lSiYMQ2XdF7tTDi
tBg7Dj6E22Lj4vf0z+8Ydc7sl+W9kMJKhP1TkRVnTp2BTetXgjGBj+8FctChBvPR
FYZF5ekiSaTVjxMXEFfEuILn6QWsGsjpHuYffjq/5zxtYeq3tvh3Y/bInuAQvp6F
UwVFUbHeOC9r/mcWerKLZdJmMV1eIuHBMFv47aNeCNtnLCr38TgfMjgtr+YUHs5b
shm38ggZPJp8wIZf2d919NXOnx1Fx0H9TDOOYA5gUH9SzR7AUhw=
=YOUc
-----END PGP SIGNATURE-----

--5dVAibYHSEJNYNSznYvluZDNqqc0ZPIDo--

--===============2070886682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2070886682==--
