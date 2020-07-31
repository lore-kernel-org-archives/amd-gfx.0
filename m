Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A89EC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 21:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27A420663
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 21:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dasUwbMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27A420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DDAA6E064;
	Fri, 31 Jul 2020 21:25:24 +0000 (UTC)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A43C6E064
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 21:25:23 +0000 (UTC)
Received: by mail-oi1-x243.google.com with SMTP id v13so11313146oiv.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=5kxnoSxhGEGrQrH6Qy/qu7GYy/ef7qNcNuJE6VF0o3I=;
 b=dasUwbMjCHLTFgt1RsqIDnYtdXXWgpjw84r1xTxLAfsF7PlxmqGUb2StGBQR9RihxK
 41rSO05cJwMgh3C0rx5DYX0yTih1vMol/l4IaLk++ohbGh7rxuNS9DaZcgLKn7kfMkEi
 MBTZi1a/ZK+B7kVAM4YUB3gEqb/YRUCL6vX/zNbXoy6j6ltPU+FvbqcLlIlTGWLmtvZz
 A1YtCmuh9fju4qhLB7F2LZwKBnIAl0hjqqyC6AJlxhM9iUWHNq+DJ+9NlQDjFwX7Elxy
 /fDrfDRuukC/HX8Vnm5iCov0JqBJZ3rv+0G+/SheTIWU8MrNppPMzogR5OrYZPHwHhcI
 Rixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=5kxnoSxhGEGrQrH6Qy/qu7GYy/ef7qNcNuJE6VF0o3I=;
 b=bbjcMw2uWhA9TMr5L6TIADn1PJqTDeWlssJHrPQtx1XTpFSywOe4uRRib5aXqRPvhW
 nP4sWPxcvklKCKO0sQnfWL+Rv+ZqqMnNLaxcQ7HDHt3vPr3MgGoKaVyLfzttepar++wl
 kCSqQ5thyyJCgs553LtQVv8Mj0VD0ruB7L/5CiL84Ff+XMWR5oe2fLx/XrYzhCjiUVkf
 z0Y6ArA6a+4KHokD5yQZB8CogLzE9tQy7slkp9ccG377QeRt+pP0djeiUsY/qwszFjc/
 RWE7832x45DlsjYo5X/01Z5QgNL+U3Zd1q9qZnkH8gXaC5EY5iyvIoB/Sp5Ygshx1y75
 aXaQ==
X-Gm-Message-State: AOAM530XZWj373uXRC3GUYoDTyqYyMqsV/wmnb+OBIv7gw779wk6IkEN
 dP//qfRlK4105WSrCxDmcOIWmnA6
X-Google-Smtp-Source: ABdhPJzRHQGQCCaiV3H05zGxWMPMdYO5+s5fYkEz1DPXEKm7mI18P5ktjubZ+ftH3bHPaitmjDEPTg==
X-Received: by 2002:a54:4e84:: with SMTP id c4mr4612509oiy.129.1596230722121; 
 Fri, 31 Jul 2020 14:25:22 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b?
 ([2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id n6sm1575601otl.53.2020.07.31.14.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 14:25:20 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix regression in adjusting power
 table/profile
To: =?UTF-8?Q?Pawe=c5=82_Gronowski?= <me@woland.xyz>
References: <20200729231106.GA6598@tower>
 <CADnq5_NQ9Oo85cV49+3pcQZTrBBc5HvoV_MQ_-wAmPhuzhq6uA@mail.gmail.com>
 <91bb8e22-9a8d-6b17-f40c-ab7a09a60fa8@gmail.com>
 <20200731003117.GA20523@tower>
 <c18325ea-3fda-74d3-47fc-eb057739b889@gmail.com>
 <20200731133437.GA4878@tower> <20200731202014.GA3750@tower>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <7cbe7df5-7798-148d-9b43-f99965704407@gmail.com>
Date: Fri, 31 Jul 2020 15:25:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731202014.GA3750@tower>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0419403479=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0419403479==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="peuBcJ8kFQlKS5P5B51qeSzuqn9IHUYRh"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--peuBcJ8kFQlKS5P5B51qeSzuqn9IHUYRh
Content-Type: multipart/mixed; boundary="ibzTUyPsrIpOnDsd7b7KSZlUPu1byVV9F"

--ibzTUyPsrIpOnDsd7b7KSZlUPu1byVV9F
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I actually *just* finished my bisect, and arrived at the same
conclusion. The hang appears to be introduced in
edad8312cbbf9a33c86873fc4093664f150dd5c1.

There are some conflicts with an automatic `git revert`, so I'm picking
through the changes now to fully understand what happened and come up
with a fix.

Thanks again for the help,
Matt

On 7/31/20 2:20 PM, Pawe=C5=82 Gronowski wrote:
> Hello again,
>=20
> I just finished a bisect of amd-staging-drm-next and it looks like
> the hang is first introduced in edad8312cbbf9a33c86873fc4093664f150dd5c=
1
> ("drm/amdgpu: fix system hang issue during GPU reset").
>=20
> It is a bit tricky, because it is commited on top of my first faulty pa=
tch
> 7173949df45482 ("drm/amdgpu: Fix NULL dereference in dpm sysfs handlers=
") so
> it needs to be reverted fix the premature -INVAL.
>=20
> Test case:
>   sudo sh -c 'echo "s 0 305 750" > /sys/class/drm/card0/device/pp_od_cl=
k_voltage'
> Results:
>   edad8312cbbf9a3 + revert 7173949df45482 =3D hang
>   edad8312cbbf9a3~1 + revert 7173949df45482 =3D no hang
>=20
> Could you confirm that you get the same results?
>=20
> Thanks,
> Pawe=C5=82 Gronowski
>=20
>=20
> On Fri, Jul 31, 2020 at 03:34:40PM +0200, Pawe=C5=82 Gronowski wrote:
>> Hey Matt,
>>
>> I have just tested the amd-staging-drm-next branch=20
>> (dd654c76d6e854afad716ded899e4404734aaa10) with my patches reverted
>> and I can reproduce your issue with:
>>
>>   sudo sh -c 'echo "s 0 305 750" > /sys/class/drm/card0/device/pp_od_c=
lk_voltage'
>>
>> Which makes the sh hang with 100% usage.
>>
>> The issue does not happen on the mainline (d8b9faec54ae4bc2fff68bcd0be=
fa93ace8256ce)
>> both without and with my patches reapplied.
>> So the problem must be related to some commit that is present in the
>> amd-staging-drm-next but not in the mainline.
>>
>>
>> Pawe=C5=82 Gronowski
>>
>> On Thu, Jul 30, 2020 at 06:34:14PM -0600, Matt Coffin wrote:
>>> Hey Pawel,
>>>
>>> I did confirm that this patch *introduced* the issue both with the
>>> bisect, and by testing reverting it.
>>>
>>> Now, there's a lot of fragile pieces in the dpm handling, so it could=
 be
>>> this patch's interaction with something else that's causing it and it=

>>> may well not be the fault of this code, but this is the patch that
>>> introduced the issue.
>>>
>>> I'll have some more time tomorrow to try to get down to root cause he=
re,
>>> so maybe I'll have more to offer then.
>>>
>>> Thanks for taking a look,
>>> Matt
>>>
>>> On 7/30/20 6:31 PM, Pawe=C5=82 Gronowski wrote:
>>>> Hello Matt,
>>>>
>>>> Thank you for your testing. It seems that my gpu (RX 570) does not s=
upport the
>>>> vc setting so I can not exactly reproduce the issue. However I did t=
race the
>>>> code path the test case takes and it seems to correctly pass through=
 the while
>>>> loop that parses the input and fails only in amdgpu_dpm_odn_edit_dpm=
_table.
>>>> The 'parameter' array is populated the same way as the original code=
 did. Since
>>>> the amdgpu_dpm_odn_edit_dpm_table is reached, I think that your prob=
lem is
>>>> unfortunately caused by something else.
>>>>
>>>>
>>>> Pawe=C5=82 Gronowski
>>>>
>>>> On Thu, Jul 30, 2020 at 08:49:41AM -0600, Matt Coffin wrote:
>>>>> Hello all, I just did some testing with this applied, and while it =
no
>>>>> longer returns -EINVAL, running `sudo sh -c 'echo "vc 2 2150 1195" =
>
>>>>> /sys/class/drm/card1/device/pp_od_clk_voltage'` results in `sh` spi=
king
>>>>> to, and staying at 100% CPU usage, with no indicating information i=
n
>>>>> `dmesg` from the kernel.
>>>>>
>>>>> It appeared to work at least ONCE, but potentially not after.
>>>>>
>>>>> This is not unique to Navi, and caused the problem on a POLARIS10 c=
ard
>>>>> as well.
>>>>>
>>>>> Sorry for the bad news, and thanks for any insight you may have,
>>>>> Matt Coffin
>>>>>
>>>>> On 7/29/20 8:53 PM, Alex Deucher wrote:
>>>>>> On Wed, Jul 29, 2020 at 10:20 PM Pawe=C5=82 Gronowski <me@woland.x=
yz> wrote:
>>>>>>>
>>>>>>> Regression was introduced in commit 38e0c89a19fd
>>>>>>> ("drm/amdgpu: Fix NULL dereference in dpm sysfs handlers") which
>>>>>>> made the set_pp_od_clk_voltage and set_pp_power_profile_mode retu=
rn
>>>>>>> -EINVAL for previously valid input. This was caused by an empty
>>>>>>> string (starting at the \0 character) being passed to the kstrtol=
=2E
>>>>>>>
>>>>>>> Signed-off-by: Pawe=C5=82 Gronowski <me@woland.xyz>
>>>>>>
>>>>>> Applied.  Thanks!
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 9 +++++++--
>>>>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_pm.c
>>>>>>> index ebb8a28ff002..cbf623ff03bd 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>>>>> @@ -778,12 +778,14 @@ static ssize_t amdgpu_set_pp_od_clk_voltage=
(struct device *dev,
>>>>>>>                 tmp_str++;
>>>>>>>         while (isspace(*++tmp_str));
>>>>>>>
>>>>>>> -       while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NUL=
L) {
>>>>>>> +       while ((sub_str =3D strsep(&tmp_str, delimiter)) && *sub_=
str) {
>>>>>>>                 ret =3D kstrtol(sub_str, 0, &parameter[parameter_=
size]);
>>>>>>>                 if (ret)
>>>>>>>                         return -EINVAL;
>>>>>>>                 parameter_size++;
>>>>>>>
>>>>>>> +               if (!tmp_str)
>>>>>>> +                       break;
>>>>>>>                 while (isspace(*tmp_str))
>>>>>>>                         tmp_str++;
>>>>>>>         }
>>>>>>> @@ -1635,11 +1637,14 @@ static ssize_t amdgpu_set_pp_power_profil=
e_mode(struct device *dev,
>>>>>>>                         i++;
>>>>>>>                 memcpy(buf_cpy, buf, count-i);
>>>>>>>                 tmp_str =3D buf_cpy;
>>>>>>> -               while ((sub_str =3D strsep(&tmp_str, delimiter)) =
!=3D NULL) {
>>>>>>> +               while ((sub_str =3D strsep(&tmp_str, delimiter)) =
&& *sub_str) {
>>>>>>>                         ret =3D kstrtol(sub_str, 0, &parameter[pa=
rameter_size]);
>>>>>>>                         if (ret)
>>>>>>>                                 return -EINVAL;
>>>>>>>                         parameter_size++;
>>>>>>> +
>>>>>>> +                       if (!tmp_str)
>>>>>>> +                               break;
>>>>>>>                         while (isspace(*tmp_str))
>>>>>>>                                 tmp_str++;
>>>>>>>                 }
>>>>>>> --
>>>>>>> 2.25.1
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> amd-gfx mailing list
>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>> _______________________________________________
>>>>>> amd-gfx mailing list
>>>>>> amd-gfx@lists.freedesktop.org
>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>
>>>>>
>>>>
>>>>
>>>>
>>>
>>
>>
>>


--ibzTUyPsrIpOnDsd7b7KSZlUPu1byVV9F--

--peuBcJ8kFQlKS5P5B51qeSzuqn9IHUYRh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl8kjD8ACgkQ4mzKau7F
yAeyWxAAwYuRQFEgHuVgmP9o4BXUCH0btmeCWoQRXEH/jlHOXeHY9obZJiRt4ymp
EIwA0X19/Toi2E3Ka5V5SNGl+9XFb7g9rakd2UthAvBErOZg3gNEhqJyzsBEjlDL
5Ce0b/j0ka646b4VYYgN0sJrZ/r+iP1npFZgTwZ0LpIFBM2NYBumL2pK8HMmHrKP
q0AwCPWiaQABDHy2dBPnzUTQIWL7w59c1kbsE49tOGjtMPmlNSL7WvvTdgFNcadk
rzWz0PaRLh6DNfqh02rvyjvmVkUwXcvNJztg4IIwRzgbN8u7926mRxUhnSR9A5BB
ysNT80NlQo66MYINAODgoKgYUJ+2Hr6kEWtuzOD3Z6bw/t52I9FN5JOO1D7KyEQT
La/eUWdVIv+rvjH8ZzgwX+JKWScRUhpzzQZwZfGOD4p1XVzp8SieOAHhpNzS9JIa
6vdH+DdJyXq8IdbIqjcXDnP7pvrdFv2+HlLsg2VnPNjyp5t3IQU/0TUEgINm4D2l
HyP46OoLjxLCVm3sU7K4iUNU4I/j0QkFLdJjb4GewNTDHJanXBkyrIwC718NT74d
AopLLETm5ub7Q4lbz41v0o/kjiuVk+QWIGOWe0MPpkXt90QNpJp42qmtqKv5yTmR
MU7A0n7/9Yml54Ep+SgDpAym10Z84iFMWPsjjDrLJsS9tCiO5YQ=
=/ppY
-----END PGP SIGNATURE-----

--peuBcJ8kFQlKS5P5B51qeSzuqn9IHUYRh--

--===============0419403479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0419403479==--
