Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ED7C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 14:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF24120829
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 14:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXhthsL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF24120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971526E91D;
	Thu, 30 Jul 2020 14:49:50 +0000 (UTC)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A346E91C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 14:49:49 +0000 (UTC)
Received: by mail-oo1-xc42.google.com with SMTP id a9so5270478oof.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=4aLfsM0iYr0gDnYZz5t1bck1Wu/caSlp7b3k+Id8F9U=;
 b=HXhthsL0NRMyEAPklJ9ZIiQAO3o3GVBE/hZh6fBTOxuwVc/ABzQlHuSPkTv95Kf/hL
 lXoQ5hDrX0HEr3Tyjbyqczep5q4P+RbJFHUYPUKoBlP3VsMurkLnmeuj+NoTV0jA0Fpt
 t6VNY1D5FonBEevTJfkCgNJ/MlSQm1JSyznL1jkxnfy6jH6RJyzksQKbf6LeKv8CdXqU
 6PjpdymOfwmN6JA0G/PKQ6E3o1j+7NtQRoYoFQV9jniyJloyAfcUpSY24/qwMkUvZdT/
 o8MfFKFBFwGkkIGZPgwxGis3GP34uu/DW032o2zHTIsWaJudt7/NyIRDZbVJNl4NjuCy
 xHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=4aLfsM0iYr0gDnYZz5t1bck1Wu/caSlp7b3k+Id8F9U=;
 b=BuSR3nnyhOuUUVKNzPkWDf/Mtux8jIFqTdBXMWf36Yzu3Wy01sAVqE/FOww899xE/s
 4SrpPVFLDGrGDayvh2eLwY9gj04S+J2IyqGoopyWAxQBEsyHcZx6XgY+e6QVjvBF2Kvm
 zx1q+nE1grr2QCeaPuU09igQkg6Zk5blJJoZgvLdppVR0Lex3YP7KiPOxttPpva29Nmw
 5WIRCk2s+LC/vm95eIClvE8/jeTn8u9G1ybzXy1k0YOLY3KO7NQbe5hiMsyQNqgn3t+f
 Efjflgaey5s7xapHFdUSB39GeuHRI+S1xIipANlGffxEeeJqoAHdznU3hY2h5gA7PylD
 qSSQ==
X-Gm-Message-State: AOAM533JjxWt663l02x2/uKGCV2nWmmEE6QYBfV1DQuCjJJEQ1KTWEEe
 iNB6uNNJX4YYtRy7eRPMoxcdjbNyInU=
X-Google-Smtp-Source: ABdhPJz+w5sRK1VwQKsrehMWX3Dbt26k63Kw4HyG9XOAMcrQVGnDu+rcdWxxdPyz3xmkR7UMOyUeAA==
X-Received: by 2002:a4a:9622:: with SMTP id q31mr2739849ooi.78.1596120588664; 
 Thu, 30 Jul 2020 07:49:48 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b?
 ([2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id y26sm994249ooq.3.2020.07.30.07.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 07:49:47 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix regression in adjusting power
 table/profile
To: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?Q?Pawe=c5=82_Gronowski?=
 <me@woland.xyz>
References: <20200729231106.GA6598@tower>
 <CADnq5_NQ9Oo85cV49+3pcQZTrBBc5HvoV_MQ_-wAmPhuzhq6uA@mail.gmail.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <91bb8e22-9a8d-6b17-f40c-ab7a09a60fa8@gmail.com>
Date: Thu, 30 Jul 2020 08:49:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_NQ9Oo85cV49+3pcQZTrBBc5HvoV_MQ_-wAmPhuzhq6uA@mail.gmail.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0705184040=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0705184040==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yfkNuY739VaJTx8hpfvWAE7ZM8fVStDnO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yfkNuY739VaJTx8hpfvWAE7ZM8fVStDnO
Content-Type: multipart/mixed; boundary="jPWW8Q1IvVkc2R7nYotymNUwN3OaH03PP"

--jPWW8Q1IvVkc2R7nYotymNUwN3OaH03PP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello all, I just did some testing with this applied, and while it no
longer returns -EINVAL, running `sudo sh -c 'echo "vc 2 2150 1195" >
/sys/class/drm/card1/device/pp_od_clk_voltage'` results in `sh` spiking
to, and staying at 100% CPU usage, with no indicating information in
`dmesg` from the kernel.

It appeared to work at least ONCE, but potentially not after.

This is not unique to Navi, and caused the problem on a POLARIS10 card
as well.

Sorry for the bad news, and thanks for any insight you may have,
Matt Coffin

On 7/29/20 8:53 PM, Alex Deucher wrote:
> On Wed, Jul 29, 2020 at 10:20 PM Pawe=C5=82 Gronowski <me@woland.xyz> w=
rote:
>>
>> Regression was introduced in commit 38e0c89a19fd
>> ("drm/amdgpu: Fix NULL dereference in dpm sysfs handlers") which
>> made the set_pp_od_clk_voltage and set_pp_power_profile_mode return
>> -EINVAL for previously valid input. This was caused by an empty
>> string (starting at the \0 character) being passed to the kstrtol.
>>
>> Signed-off-by: Pawe=C5=82 Gronowski <me@woland.xyz>
>=20
> Applied.  Thanks!
>=20
> Alex
>=20
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c
>> index ebb8a28ff002..cbf623ff03bd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>> @@ -778,12 +778,14 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(stru=
ct device *dev,
>>                 tmp_str++;
>>         while (isspace(*++tmp_str));
>>
>> -       while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NULL) {
>> +       while ((sub_str =3D strsep(&tmp_str, delimiter)) && *sub_str) =
{
>>                 ret =3D kstrtol(sub_str, 0, &parameter[parameter_size]=
);
>>                 if (ret)
>>                         return -EINVAL;
>>                 parameter_size++;
>>
>> +               if (!tmp_str)
>> +                       break;
>>                 while (isspace(*tmp_str))
>>                         tmp_str++;
>>         }
>> @@ -1635,11 +1637,14 @@ static ssize_t amdgpu_set_pp_power_profile_mod=
e(struct device *dev,
>>                         i++;
>>                 memcpy(buf_cpy, buf, count-i);
>>                 tmp_str =3D buf_cpy;
>> -               while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D =
NULL) {
>> +               while ((sub_str =3D strsep(&tmp_str, delimiter)) && *s=
ub_str) {
>>                         ret =3D kstrtol(sub_str, 0, &parameter[paramet=
er_size]);
>>                         if (ret)
>>                                 return -EINVAL;
>>                         parameter_size++;
>> +
>> +                       if (!tmp_str)
>> +                               break;
>>                         while (isspace(*tmp_str))
>>                                 tmp_str++;
>>                 }
>> --
>> 2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--jPWW8Q1IvVkc2R7nYotymNUwN3OaH03PP--

--yfkNuY739VaJTx8hpfvWAE7ZM8fVStDnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl8i3goACgkQ4mzKau7F
yAfdABAArZbauXrcv8K7UureP6oxUytSuGy2jcxz8jU//LQBoTmziqeStyJuqT3i
OQQQS7WDd3KJUiEpRVyJHNyWjN5yF5GvRzZL8V3UHKBp/YDMsjyublji1qS2Rvw6
f0gCydodbMlyWXYRGt5LDqyQF2k7+HqcOK4Nmbq0ETwRca/IE0gN23D3RfdIDhF+
Tt22yrgYXDQav8vQEWdCI4OPmJXm9eKOqV1vbaSQ60x1gDBmXXPTUZokRwd+6na2
DQHGRk1LAqTAcnWbAk9Le3eQYPwue7vAG1Aw1fsXXOMKpo2BUW7zH88yIOIvkt7c
iC7KRbcseZtqRjNRubxcqb4rdbcf8TecSft7EstTKm1RfYwTcsMKcsCEgy46RAFV
j41m4geA9+VLoN4TT9q78aBnNBDD7iLCx3WG3tTN9aQSCLKReFeVvpXyysejNqo9
to799aV8pTXAoKGnncn/QTG4pyAxfdDGafMwAp9OZ41PjQukrrwZ/21rsGc0r2yj
fUltommo2pHvAimbR3BP+/sXOwXrWZ5yvOwr68Jyrl9n75IhaDzxbr3RCN+UnbM1
HmdyDYno/vMD0N8N1c5+mKnCuCKO5LTWQ9iTrBlv0g9cP2vPgro5SvmNsslfWUUS
Xton3e91vghXk554/+Igja7C7CJQ80hXXZy/iETs0402j1qtQac=
=S3jU
-----END PGP SIGNATURE-----

--yfkNuY739VaJTx8hpfvWAE7ZM8fVStDnO--

--===============0705184040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0705184040==--
