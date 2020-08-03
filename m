Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B3C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 16:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28309206DA
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay/MFa5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28309206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC23D6E2CA;
	Mon,  3 Aug 2020 16:38:02 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157BB6E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 16:38:01 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id o72so22775167ota.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2020 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=i3ujLWpCu2fgHeP+0nyjKyg4nLHPUsm+jFPB87aKbPo=;
 b=Ay/MFa5sDnTCBSjs0cZnCOe3XSNsY4XVD+0gATzERdynFx5BUJN4dXTDF/8fbyb+oE
 s5Hz1EBBAdlsS49tz8dWDlgHr76KSvPz1a/bV7AowmuYyPoDf1EQipmULrB9dOsyH/iW
 zmFiVwVly/4U+92RqLeQAez4ECKglbsehlvhtl0PZmxSaOgPCYtJjsnO2Dwn7R8k8Zbp
 4HEuKxdlBJFL5QQXRk4/b204OM3YEaZ9bToewyEsILzbWxtInkTldpl7HSFqy1kGHuIY
 Y+QfKb4CDsZoS2/p/BTl+JSyJ3CJpQ7dwY3Q0cXJrVU9DkmLS/kjIaj8mwDXfbatnNCD
 F7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=i3ujLWpCu2fgHeP+0nyjKyg4nLHPUsm+jFPB87aKbPo=;
 b=A94OFFrsyGV4lXhPrU5fQqCAEvINe0PcYz2jhIhD3zjAo7MyA7vf6jDdcpla0ESSqW
 z5jiH+JG9hYc1Xc4zaCI5ptzn2Xk0jRUdkj3jKR596imRDdL9XLs8Ol55A//vhRJ2FKj
 dU2X2VE+I0T20Idfx9o/FuhPjuaXpE7speaXqJVVt/13iynDacI2YnFLknhj7Ptvux0B
 mIGiOCH3iUJ1WJqMpyOlPG7J9YbpsGulPhrtYKMCDXRkstRAbWo4tG24pgjhTHsNx/w3
 7NZ/78jwFaaqvZ9Ca0FMEcfF9Hkxvzil/9XXhFKWbUf+zK6zUGgoFRd5AsLop5H/kXZw
 Kl9g==
X-Gm-Message-State: AOAM532wzuTI03RAuhzSxr8CjdN+ZQRPy9xBRn7uoAsJ0yA8FdM3RDt7
 2AcUG5zrA6T2M20qYY1IPG4=
X-Google-Smtp-Source: ABdhPJwHRjVRew/2CfzYoUSAc7aeuqkuGnRT68khLB1OufAy/GnkwjfbuZDzejV8HFhMAtHjIr+yRw==
X-Received: by 2002:a9d:2c29:: with SMTP id f38mr13757280otb.234.1596472680404; 
 Mon, 03 Aug 2020 09:38:00 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b?
 ([2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id i11sm1755585otk.68.2020.08.03.09.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 09:37:59 -0700 (PDT)
Subject: Re: [Bug][Regression][Bisected] pp_table writes began to fail for
 Navi10 on amd-staging-drm-next
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <c9711af0-12c8-9da8-8a3f-859cdc26129f@gmail.com>
 <DM6PR12MB2619B3A4D4FF0BD91C594E09E44E0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB2619432DCDA1624DE36D7C97E44D0@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <5c3c9f16-b636-dcb5-a90c-77b58ac2d7bb@gmail.com>
Date: Mon, 3 Aug 2020 10:37:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB2619432DCDA1624DE36D7C97E44D0@DM6PR12MB2619.namprd12.prod.outlook.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>
Content-Type: multipart/mixed; boundary="===============0816481208=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0816481208==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3ovN1oAmoHSH17ezkXrgtLI7q3X5PXAYZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ovN1oAmoHSH17ezkXrgtLI7q3X5PXAYZ
Content-Type: multipart/mixed; boundary="JmEk4xqcbztWCHOgyODbHCsKmP8FRf1fi"

--JmEk4xqcbztWCHOgyODbHCsKmP8FRf1fi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Evan,

Thanks for the work. It would have taken me probably forever to find that=
=2E

I replied to your series with a Tested-by, and I tested locally. With
edad8312cbbf9a33c86873fc4093664f150dd5c1 reverted to fix the sysfs
interfaces, and your series, I once again have a 100% working OD system!

Thanks for the snappy work,
Matt

On 8/2/20 10:50 PM, Quan, Evan wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Matt,
>
> I just sent out two patches to fix the issue reported here. It worked
on my local env.
> Please confirm on your platform.
> https://lists.freedesktop.org/archives/amd-gfx/2020-August/052245.html
> https://lists.freedesktop.org/archives/amd-gfx/2020-August/052246.html
>
> BR,
> Evan
> -----Original Message-----
> From: Quan, Evan
> Sent: Friday, July 31, 2020 9:20 AM
> To: Matt Coffin <mcoffin13@gmail.com>; amd-gfx@lists.freedesktop.org
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Subject: RE: [Bug][Regression][Bisected] pp_table writes began to fail
for Navi10 on amd-staging-drm-next
>
> Thanks for reporting this. I will check it.
>
> BR
> Evan
> -----Original Message-----
> From: Matt Coffin <mcoffin13@gmail.com>
> Sent: Thursday, July 30, 2020 10:25 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Subject: [Bug][Regression][Bisected] pp_table writes began to fail for
Navi10 on amd-staging-drm-next
>
> Hey Evan,
>=20
> I've been having an issue with uploading `pp_table`s on recent `amd-sta=
ging-drm-next` kernels. I bisected the issue, and it came back to a commi=
t of yours - ec8ee23f610578c71885a36ddfcf58d35cccab67.
>=20
> I didn't have your gitlab handle to CC you on the issue, so I thought I=
'd at least alert you to it.
>=20
> Here's a link to the issue on GitLab:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1243
>=20
> I'd appreciate any help or insight you could offer here as I work on a =
fix.
>=20
> First bad commit header:
>=20
> commit ec8ee23f610578c71885a36ddfcf58d35cccab67 (refs/bisect/bad)
> Author: Evan Quan <evan.quan@amd.com>
> Date:   Wed Jun 10 16:52:32 2020 +0800
>=20
>     drm/amd/powerplay: update Navi10 default dpm table setup
>=20
>     Cache all clocks levels for every dpm table. They are needed
>     by other APIs.
>=20
>     Change-Id: I8114cf31e6ec8c9af4578d51749eb213befdcc71
>     Signed-off-by: Evan Quan <evan.quan@amd.com>
>     Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>=20
> Thanks everyone, and cheers,
> Matt Coffin
>


--JmEk4xqcbztWCHOgyODbHCsKmP8FRf1fi--

--3ovN1oAmoHSH17ezkXrgtLI7q3X5PXAYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl8oPWYACgkQ4mzKau7F
yAcgEQ/9HvDUIhaZmvUC/jGF01OzJR0DhIXs52o2smSYtmOuXuS61bdY0/Pqss+F
o3hdsN9FSDEJ8xJNr11iT7duLLAOoFL9ddcramO3FlW6UigmOxm4J2XMiGsswWBq
GBBPovT/zNbkl8U/FwTF58ePSlIFp88JYKHshdxzVrLcRE66FbdD+7Rh9pwPuSnM
7reAMpuuO2jxhEWuzDCyeMHvQClf4iBMYobRkN2lpfESUC1aAbtRWNAZqbIFn27p
BfQ+ylpDuxDLW5iiYEd4J0vsffCZlaRomnsOHOb3lqmut/jBLW4b7GCQ+SfFsfhP
aNUo2ku5I+FnxnoecwpXYxvHcfZWhTy/0zZZG4yJnpzcajjlXInXg1F1XF/D8KuK
NuGlR0+KwnoZ5jEHLRZonk8+HqXnapGToucrfiFM4GjAK1/W1lzAmTKufE5YIH3l
JBiBcG7fD9TFLWeuDdduRVsRjzOx/Zzi2mxWRiatjl+A5MLJn1XrLAkl7LeQyX6c
pitx3sD9kI+jDguxxy9bP92LD4LQ2P1IonCp/0dVnKIcC+bx7kiPqFg9mdwXgb1o
FBaUiYViaIfhhiOZJXcVW4MOUadF8hqHoIefxAUPvmD2+Yi290Seu4ZEJzqsfnjr
Cb04Nqgcq7W3U68YaptXs6WfEW43gd6jj1hiEmov6GXepr0ZAIM=
=gu2Y
-----END PGP SIGNATURE-----

--3ovN1oAmoHSH17ezkXrgtLI7q3X5PXAYZ--

--===============0816481208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0816481208==--
