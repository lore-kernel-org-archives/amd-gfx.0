Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54289C02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 08:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB27910E318;
	Fri,  7 Feb 2025 08:46:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B/reEtKI";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6B210E318
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738917722; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 bh=v+yC+iosFfOu1lhF4cwzFhbh/5ZDWWVZ4xQOqUlsKlw=;
 b=B/reEtKIUeHiW98oU46VH0DQTrm4GqihoM7Obxp/n1wvDdsbu8gzUCjZC9zD0ADXyEAZhsx/QP/Ze9c4xKnnAQvOmXfSgrFmXREIJbvnQcyQOcwA3cozvaS+MoYD3ToS0nLo1bdqlVq3muESFr748ehxvnLwKfieLRa9BFzPibI=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyveHS_1738917720 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 16:42:01 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [v1 2/4] drm/amdgpu: accumulate gfx_off_entrycount in
 smu_suspend()
From: Gerry Liu <gerry@linux.alibaba.com>
In-Reply-To: <251b979c-2f22-4da6-af64-1bdbb8e35054@amd.com>
Date: Fri, 7 Feb 2025 16:42:00 +0800
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 "Koenig, Christian" <christian.koenig@amd.com>, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DCA701B-F4D3-43E5-A097-18C25A679AB8@linux.alibaba.com>
References: <cover.1738910203.git.gerry@linux.alibaba.com>
 <9253f9f4144fd2e126e6b7307c63eb75764dce21.1738910203.git.gerry@linux.alibaba.com>
 <f751810b-a238-406c-a03c-9ee290692ed0@amd.com>
 <AE910E1D-A1AC-42D7-B865-97B272036EC3@linux.alibaba.com>
 <251b979c-2f22-4da6-af64-1bdbb8e35054@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> 2025=E5=B9=B42=E6=9C=887=E6=97=A5 16:34=EF=BC=8CLazar, Lijo =
<lijo.lazar@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 2/7/2025 2:00 PM, Gerry Liu wrote:
>>=20
>>=20
>>> 2025=E5=B9=B42=E6=9C=887=E6=97=A5 16:04=EF=BC=8CLazar, Lijo =
<lijo.lazar@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>=20
>>>=20
>>> On 2/7/2025 12:14 PM, Jiang Liu wrote:
>>>> As pwfw resets entrycount when device is suspended, so we should
>>>> accmulate the gfx_off_entrycount value instead of save the last =
value
>>>> of it.
>>>>=20
>>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>>>> ---
>>>> drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++---
>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c =
b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> index ed9dac00ebfb..70a5ab649e5f 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> @@ -2134,12 +2134,12 @@ static int smu_suspend(struct =
amdgpu_ip_block *ip_block)
>>>> 	smu_set_gfx_cgpg(smu, false);
>>>>=20
>>>> 	/*
>>>> -	 * pwfw resets entrycount when device is suspended, so we save =
the
>>>> -	 * last value to be used when we resume to keep it consistent
>>>> +	 * pwfw resets entrycount when device is suspended, so we =
accumulate
>>>> +	 * the `gfx_off_entrycount` value.
>>>> 	 */
>>>> 	ret =3D smu_get_entrycount_gfxoff(smu, &count);
>>>> 	if (!ret)
>>>> -		adev->gfx.gfx_off_entrycount =3D count;
>>>> +		adev->gfx.gfx_off_entrycount +=3D count;
>>>=20
>>> This is slightly misleading - only Vangogh implements
>>> get_gfx_off_entrycount and its implementation,
>>> vangogh_get_gfxoff_entrycount, is already doing something like this =
-
>>>=20
>>> *entrycount =3D value + adev->gfx.gfx_off_entrycount;
>>=20
>> Because we have not restored the hardware counter by writing back the =
value on resume, adev->gfx.gfx_off_entrycount only remembers the latest =
value of latest suspend/resume cycle. And history information is lost, =
so changed it to accumulate all values.
>=20
> What I meant is that accumulation is already done in the =
implementation
> side - check implementation of vangogh_get_gfxoff_entrycount.
Aha, you are right, smu_suspend() calls smu_get_entrycount_gfxoff(), it =
already accumulates along the way.
Will drop it.

>=20
> Thanks,
> Lijo
>=20
>>=20
>>>=20
>>> Thanks,
>>> Lijo
>>>=20
>>>>=20
>>>> 	/* clear this on suspend so it will get reprogrammed on resume =
*/
>>>> 	smu->workload_mask =3D 0;

