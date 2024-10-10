Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F59ECF11FA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 14:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DA610E945;
	Thu, 10 Oct 2024 14:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="VGAqGt9y";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="MEv8I47T";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D8210E911
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 13:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1728568640; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=UHykHgXBqzJ8Eua0HGkvi0oTgVsZB91QlXNy05j2zkjTuQvDST5mnOIRaUHr7/dfto
 itWkks27uu/7ickJNHd1p9f4TThRfwPoMefXol/zF/YuSrYobMT6yDc62ZXRS5ll8NyU
 siBR9CtowyOrFluVntFWAi6HhxmmwSJCu1a/jMxyAKfBHnR/YXJb3pJ0FG9DTP05RTyi
 agxUATX2nRuizqg/EghIEvePpt5mZZEBJYUPB77Q4k6dZGdzMxQm4C/LE+lA1PEaQs8v
 fvHgZaZUTV/Sijhj1Gn3B2oX4s1vN4oT25nD4VX1Ct1OLg964v5VagAH09Zk7uS+NeBc
 LXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728568640;
 s=strato-dkim-0002; d=strato.com;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=nTmyN/S6mYtoNSRaOImOVWIvqfwSir4wwvzhSOMIxxk=;
 b=VM/fm8IYN8mLGPgrX9gO7zBcq9OCEb3u/shhlEE1KGfnd9L6qjHfQa/kGqFRjnFkAi
 Mm8D1kisCuI5S3MOo+GiNHEwV5C2fXlIOO/XgCBBs+eAD93WDdrlsXPbCO7raQMK5qAX
 L2AfgLdAA/atqgaQoyZZh9IxMMUuieJch5ee+BPUlDzy9Eet3CB0+ucFr3odK2rQ0FHx
 CNR3lUHlr7r05QfhrprPIoeRwl4W6fqsCdiGupgF7IRjo5gV075DRMFwUmh6MTr66tfB
 xYrqUssDAhLMndVmr/jGAmAqcp4dB+nPwCUVaQrxoKB4uBkoZAl2Pt5Ruk6cAyhQU1V4
 /wiA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728568640;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=nTmyN/S6mYtoNSRaOImOVWIvqfwSir4wwvzhSOMIxxk=;
 b=VGAqGt9yR2gG1vwBP5+rRa8GlTT34q0k8wabEgwe2kFovh3eZp/vnATpmIafYIf2St
 aAQskyv/T1Gcg2ccyboF7TtzidWK/1+AvoLDtktrs+OmKwS/MhyeEBIcMky11BSqaXBa
 foP16odqvzvDxmuMn1v3ePLv2HNaI1iTRY8ecIBXYpvw3GNPA/vYyAje4sOzcyq4GAO6
 xZawY4cBZs7zNxScUWbLEOrrYwCg3TeH6u+5UW0KZJYRe+MQVfBWp9vhhthPkwcARYIA
 TniIqkAzFOZF8KmIl4EzJnuBmnqPSUlzl0P4UhYAqkqZQc6Nw4tYX7czBnKH9wMehZFo
 GzOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728568640;
 s=strato-dkim-0003; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=nTmyN/S6mYtoNSRaOImOVWIvqfwSir4wwvzhSOMIxxk=;
 b=MEv8I47TJyLa3v3C5pQjaNAahPf+Yj8yc+cWeFDyvgO3reII+pZoxqgbcXcDio8Hs1
 c3wBsyMoIddaUtk8gkBg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5i1s3PFXXvQIhef8w/WHZGY1bRFY7PZniOs3Ug="
Received: from smtpclient.apple by smtp.strato.de (RZmta 51.2.8 AUTH)
 with ESMTPSA id e0da1a09ADvJvcw
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 10 Oct 2024 15:57:19 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: [PATCHES] drm/radeon issues
Date: Thu, 10 Oct 2024 15:57:08 +0200
Message-Id: <6C389917-EF59-444B-9C33-C3F9A9AD3921@xenosoft.de>
References: <EE14413A-3528-4646-A353-DB5131E56BA2@xenosoft.de>
Cc: =?utf-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>,
 alexander.deucher@amd.com
In-Reply-To: <EE14413A-3528-4646-A353-DB5131E56BA2@xenosoft.de>
To: "R.T.Dickinson" <rtd@a-eon.com>, mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>, hypexed@yahoo.com.au,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>
X-Mailer: iPhone Mail (22A3354)
X-Mailman-Approved-At: Thu, 10 Oct 2024 14:41:05 +0000
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

Hi All,

There is another issue with the Radeon DRM driver but there is already a pat=
ch available for this issue.

Link: https://lists.freedesktop.org/archives/dri-devel/2024-October/473314.h=
tml

I compiled a new RC2 of kernel 6.12 with this patch for the X1000 and X5000 t=
oday.

Download: https://github.com/chzigotzky/kernels/releases/tag/v6.12.0-rc2-2

We need 3 patches for the Radeon DRM driver currently.

Please test it.

Thanks,
Christian


> On 08 October 2024 at 11:00am, Christian Zigotzky <chzigotzky@xenosoft.de>=
 wrote:
>=20
> =EF=BB=BFHi All,
>=20
> I have released the RC2 of kernel 6.12 with Christian Koenig=E2=80=99s pat=
ch for the X1000 and X5000.
>=20
> Download and further information: https://github.com/chzigotzky/kernels/re=
leases/tag/v6.12.0-rc2
>=20
> Please test the kernels because of the second Radeon DRM driver issue.
>=20
> Thanks,
> Christian
>=20
>> Am 07.10.2024 um 20:36 schrieb Alex Deucher <alexdeucher@gmail.com>:
>>=20
>> =EF=BB=BFAdd a few people.
>>=20
>> This should fix the radeon ttm gem conversion.
>>=20
>> Alex
>>=20
>>=20
>>=20
>>> On Mon, Oct 7, 2024 at 2:33=E2=80=AFPM Christian K=C3=B6nig
>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>=20
>>> Make sure to always set the GEM function pointer even for in kernel
>>> allocations. This fixes a NULL pointer deref caused by switching to GEM
>>> references.
>>>=20
>>> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>>> Fixes: fd69ef05029f ("drm/radeon: use GEM references instead of TTMs")
>>> ---
>>> drivers/gpu/drm/radeon/radeon_gem.c    | 3 ---
>>> drivers/gpu/drm/radeon/radeon_object.c | 1 +
>>> 2 files changed, 1 insertion(+), 3 deletions(-)
>>>=20
>>> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeo=
n/radeon_gem.c
>>> index 9735f4968b86..bf2d4b16dc2a 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_gem.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
>>> @@ -44,8 +44,6 @@ struct sg_table *radeon_gem_prime_get_sg_table(struct d=
rm_gem_object *obj);
>>> int radeon_gem_prime_pin(struct drm_gem_object *obj);
>>> void radeon_gem_prime_unpin(struct drm_gem_object *obj);
>>>=20
>>> -const struct drm_gem_object_funcs radeon_gem_object_funcs;
>>> -
>>> static vm_fault_t radeon_gem_fault(struct vm_fault *vmf)
>>> {
>>>       struct ttm_buffer_object *bo =3D vmf->vma->vm_private_data;
>>> @@ -132,7 +130,6 @@ int radeon_gem_object_create(struct radeon_device *r=
dev, unsigned long size,
>>>               return r;
>>>       }
>>>       *obj =3D &robj->tbo.base;
>>> -       (*obj)->funcs =3D &radeon_gem_object_funcs;
>>>       robj->pid =3D task_pid_nr(current);
>>>=20
>>>       mutex_lock(&rdev->gem.mutex);
>>> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/ra=
deon/radeon_object.c
>>> index d0e4b43d155c..7672404fdb29 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_object.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_object.c
>>> @@ -151,6 +151,7 @@ int radeon_bo_create(struct radeon_device *rdev,
>>>       if (bo =3D=3D NULL)
>>>               return -ENOMEM;
>>>       drm_gem_private_object_init(rdev_to_drm(rdev), &bo->tbo.base, size=
);
>>> +       bo->tbo.base.funcs =3D &radeon_gem_object_funcs;
>>>       bo->rdev =3D rdev;
>>>       bo->surface_reg =3D -1;
>>>       INIT_LIST_HEAD(&bo->list);
>>> --
>>> 2.34.1
>>>=20

