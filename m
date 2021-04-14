Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A6C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 07:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5071861166
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 07:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5071861166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989926E47B;
	Wed, 14 Apr 2021 07:44:30 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449F06E47B;
 Wed, 14 Apr 2021 07:44:29 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B873DABF6;
 Wed, 14 Apr 2021 07:44:26 +0000 (UTC)
Subject: Re: [PATCH 3/8] drm/amdgpu: Implement mmap as GEM object function
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 bskeggs@redhat.com, ray.huang@amd.com, linux-graphics-maintainer@vmware.com,
 sroland@vmware.com, zackr@vmware.com, shashank.sharma@amd.com,
 sam@ravnborg.org, emil.velikov@collabora.com, nirmoy.das@amd.com
References: <20210406090903.7019-1-tzimmermann@suse.de>
 <20210406090903.7019-4-tzimmermann@suse.de>
 <6b261dab-4a4d-f0c6-95c0-f720c7df12c1@amd.com>
 <b76d1922-c9a5-8533-657a-2c1149832347@suse.de>
 <9db18654-770f-459b-a89a-c57dc8a21bac@amd.com>
 <573dca0f-d017-3614-5e4f-d8d0b6bc413f@amd.com>
 <780bb477-77c3-2f3c-2417-edeffccd63b9@amd.com>
 <a152c174-c0fe-fc6f-9fa0-9054ffe415a9@amd.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <63c90815-c9d8-68df-daa1-c165215a6b7c@suse.de>
Date: Wed, 14 Apr 2021 09:44:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <a152c174-c0fe-fc6f-9fa0-9054ffe415a9@amd.com>
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
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1960805503=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1960805503==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Jzk40XCw0oHnpIZqrmxs3V1v04lxedhKe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jzk40XCw0oHnpIZqrmxs3V1v04lxedhKe
Content-Type: multipart/mixed; boundary="otObQxGaOSMPhIOvTCAlNX8ckBPTJka99";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, airlied@linux.ie, daniel@ffwll.ch,
 bskeggs@redhat.com, ray.huang@amd.com, linux-graphics-maintainer@vmware.com,
 sroland@vmware.com, zackr@vmware.com, shashank.sharma@amd.com,
 sam@ravnborg.org, emil.velikov@collabora.com, nirmoy.das@amd.com
Cc: nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Message-ID: <63c90815-c9d8-68df-daa1-c165215a6b7c@suse.de>
Subject: Re: [PATCH 3/8] drm/amdgpu: Implement mmap as GEM object function
References: <20210406090903.7019-1-tzimmermann@suse.de>
 <20210406090903.7019-4-tzimmermann@suse.de>
 <6b261dab-4a4d-f0c6-95c0-f720c7df12c1@amd.com>
 <b76d1922-c9a5-8533-657a-2c1149832347@suse.de>
 <9db18654-770f-459b-a89a-c57dc8a21bac@amd.com>
 <573dca0f-d017-3614-5e4f-d8d0b6bc413f@amd.com>
 <780bb477-77c3-2f3c-2417-edeffccd63b9@amd.com>
 <a152c174-c0fe-fc6f-9fa0-9054ffe415a9@amd.com>
In-Reply-To: <a152c174-c0fe-fc6f-9fa0-9054ffe415a9@amd.com>

--otObQxGaOSMPhIOvTCAlNX8ckBPTJka99
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.04.21 um 21:49 schrieb Felix Kuehling:
> On 2021-04-07 3:34 p.m., Felix Kuehling wrote:
>> On 2021-04-07 7:25 a.m., Christian K=C3=B6nig wrote:
>>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Don't verify access for KFD BOs. They=20
don't have a GEM
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * object associated with them.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (bo->kfd_bo)
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>>> Who does the access verification now?
>>>>> This is somewhat confusing.
>>>>>
>>>>> I took this check as-is, including the comment, from amdgpu's
>>>>> verify_access function. The verify_access function was called by
>>>>> ttm_bo_mmap. It returned 0 and ttm_bo_mmap did the mapping.
>>>> This is probably a left-over from when we mapped BOs using /dev/kfd.=20
We
>>>> changed this to use /dev/dri/renderD* a long time ago to fix CPU=20
>>>> mapping
>>>> invalidations on memory evictions. I think we can let GEM do the acc=
ess
>>>> check.
>>>
>>> Ok, good to know.
>>>
>>> Thomas can you remove the extra handling in a separate prerequisite=20
>>> patch?
>>>
>>> If anybody then bisects to this patch we at least know what to do to =

>>> get it working again.
>>
>> FWIW, I ran KFDTest test with this shortcut removed on current=20
>> amd-staging-drm-next + my HMM patch series, and it didn't seem to=20
>> cause any issues.
>=20
> Wait, I celebrated too soon. I was running the wrong kernel. I do see=20
> some failures where access is being denied. I need to do more debugging=20

> to figure out what's causing that.

Any news here? I saw the patch at [1], which removes the kfd_bo test.=20
Can I assume that the series addresses the issue?

Best regards
Thomas

[1] https://patchwork.freedesktop.org/patch/427516/?series=3D88822&rev=3D=
1

>=20
> Regards,
>  =C2=A0 Felix
>=20
>=20
>>
>> Regards,
>> =C2=A0 Felix
>>
>>
>>>
>>> Regards,
>>> Christian.=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--otObQxGaOSMPhIOvTCAlNX8ckBPTJka99--

--Jzk40XCw0oHnpIZqrmxs3V1v04lxedhKe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmB2nVkFAwAAAAAACgkQlh/E3EQov+DS
nw/9E/yHXw5W+6+v6OVFtoP5+DJbb2QzdRHvxKJky6y9PkdHRSi9zwJJQcuPgeJEttn6/5+XEN2w
YMTb3qqH+Dzye0ahAEAZVHT0z4XWUbh7e4WaJ84dW6WqHnqOl2BkPitWGH7Mjn/CrBy/OF6J8Jcr
LO6mkCWvpCxPblvDz/4Dc1rESBLgqmdVouyD6nJDYJW9gRADVTpf4cfod5zaP2Y2na5L4O9Z5wgp
OSw3D/KCHLceD5pKvthyxWwmRAhwOKtOHqxRz7wbM1z4LuW8ZNXvBc2H57q8Cv8CwyvK04MCpcpI
JQh9omsxLXZUXQA8E3kSVbzj1HZ/e6L9OesllYTg6iCx4WveKDTVtOyG/QcNuCaxke6CGhNqzbdh
2tq90uDbZSDvHd0k2zcd1UMb8oYcqVM8F/YhqczNwAeDqhCFxgSskgxKRA8d29oSJ7ka18jxuBSe
847NZBeiYbAk7y21X3ejQoJ4koKe8y3q5SLStif4s+YX/gy0CJaoA2ZPqYUnvLUsrsHfcNXlKJXa
k3Mo/M0aFdyRfzbTdSTWpXeMJL1lwFvBeMhrRcRGYScZxCM4ZchHLobVqtdrDTXIICQNqpCBO3PO
1GJWPAorjioN4D18HJkxIVF2u5AwIMYKHiPFdidM/2to4CPbeKnjPXGhNedlaTxqFkuFj1ifkWpX
2ag=
=MCWY
-----END PGP SIGNATURE-----

--Jzk40XCw0oHnpIZqrmxs3V1v04lxedhKe--

--===============1960805503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1960805503==--
