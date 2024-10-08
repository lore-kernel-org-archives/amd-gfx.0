Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF828CEF175
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ACAA10E52A;
	Tue,  8 Oct 2024 13:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="kcCnfr79";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="3WxekWpu";
	dkim-atps=neutral
X-Greylist: delayed 327 seconds by postgrey-1.36 at gabe;
 Tue, 08 Oct 2024 09:06:09 UTC
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B5D10E4AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 09:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1728378006; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=DztBwYW8a6CY2YUeU5iZBbCNrZkrOU5Ay2Pa3JkoFHnMYddoRsCHT66KFMJeePINj0
 Fow5WV2HIATrNK8jNihJFQRUqPB3dfLIQoefPePDOYGD4IEB5u2tBCg3CIETpEExre77
 dfz97Zt8Fg+ORTsDvSHNzaxqCU8yCs43po4681JUSh2UTki/KmQgs1o3hUVS/XEqu7j/
 llp69mx/nOvdsQFtrAiulGILF1+pJWCbsQvtew1hCmiS3bglx2BTFes+yvTcZcEb/8pk
 sAy62YnuUzLIeRLdRII2nXzDgH7uZFZjt+9i1Uf38Z9a6+Qh87A2vckhv0PlGq4VBtUR
 aMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728378006;
 s=strato-dkim-0002; d=strato.com;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=9wqqzG2RPEsTE9k2iBNsULm+Lq+OmgIU10227/NZhvE=;
 b=Hm4ZukY/ui5E3MVd4l0ehUHY7gTEihE76RFfodRzDvoYFigHFT5HaeV7zRq73K2aMO
 RdcKOENbr+i2rc7D342NVKLZCDhWP7EL965RhqHN9ZFcGy04V0H4Ywmy057i26ICErkx
 pUFoGNEMQRf6zcpWjPiuujy5efo2vaFeKXEYNx1uhDZxJewrLUVJz5WUE1ElwqSqShix
 ZHp+V4R7MYHjU4Ur2ttOWKZhJqOk53DGOn5gwewuyydcPct2KjsKKjvajDAA9rgS9x6Q
 6yDBQJs8AbSnTHSycZMMbjmvP4u5uU/KhwUnR++9C6r6rk9FC7guDBWZ9dyTwgVloNlR
 ovZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728378006;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=9wqqzG2RPEsTE9k2iBNsULm+Lq+OmgIU10227/NZhvE=;
 b=kcCnfr79yvlq7CbuZmcA5pVmElW+4h6m2hD6dKbYJ5VuR3bwWqPqUo3vuByRBz4EEl
 EnJSOUQkXjeUpWWu+957TS4H/TsM5uNK7X+CVlhvyLRmPcGRjzdakm0/tOiSumQp4QLV
 zGd1lGprgF4Jjs1FVmPyKO9dZXzjCh8mLPyyXqWiCy8nzAHHjWJeneYd+zA3U/52i0YA
 Oju87G3Vlg6co0ddbpPa+j1pHY6AawlGj7S758UGxKIQmthfvkdmvsk0bBK48ItvMPjz
 LbpeNWgHt0zDEOnVwbBwuiU4KJgc8siYJRP1qxD7D0XoLPX1csnSSj7EsJbTIc9pAoh3
 htOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728378006;
 s=strato-dkim-0003; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=9wqqzG2RPEsTE9k2iBNsULm+Lq+OmgIU10227/NZhvE=;
 b=3WxekWpuLpyFa82daATALqrWNjbgavwg9K4gglfOyZP2sRDvJgOqzvUgCZsWYhD2o7
 nude6aKphr93fa9QPvAw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5qws3iRDHzG8p2xUg3XBlGjveN8KnjzWlgpUn4="
Received: from smtpclient.apple by smtp.strato.de (RZmta 51.2.8 AUTH)
 with ESMTPSA id e0da1a098905mrX
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 8 Oct 2024 11:00:05 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: [PATCH] drm/radeon: always set GEM function pointer
Date: Tue, 8 Oct 2024 10:59:54 +0200
Message-Id: <EE14413A-3528-4646-A353-DB5131E56BA2@xenosoft.de>
References: <CADnq5_PpmkbYppJWR6QLzm7J_iR4GpSOYYQbTR2Ni21t++R34w@mail.gmail.com>
Cc: =?utf-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>,
 alexander.deucher@amd.com
In-Reply-To: <CADnq5_PpmkbYppJWR6QLzm7J_iR4GpSOYYQbTR2Ni21t++R34w@mail.gmail.com>
To: "R.T.Dickinson" <rtd@a-eon.com>, mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>, hypexed@yahoo.com.au,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>
X-Mailer: iPhone Mail (22A3354)
X-Mailman-Approved-At: Tue, 08 Oct 2024 13:25:13 +0000
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

I have released the RC2 of kernel 6.12 with Christian Koenig=E2=80=99s patch=
 for the X1000 and X5000.

Download and further information: https://github.com/chzigotzky/kernels/rele=
ases/tag/v6.12.0-rc2

Please test the kernels because of the second Radeon DRM driver issue.

Thanks,
Christian

> Am 07.10.2024 um 20:36 schrieb Alex Deucher <alexdeucher@gmail.com>:
>=20
> =EF=BB=BFAdd a few people.
>=20
> This should fix the radeon ttm gem conversion.
>=20
> Alex
>=20
>=20
>=20
>> On Mon, Oct 7, 2024 at 2:33=E2=80=AFPM Christian K=C3=B6nig
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>=20
>> Make sure to always set the GEM function pointer even for in kernel
>> allocations. This fixes a NULL pointer deref caused by switching to GEM
>> references.
>>=20
>> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>> Fixes: fd69ef05029f ("drm/radeon: use GEM references instead of TTMs")
>> ---
>> drivers/gpu/drm/radeon/radeon_gem.c    | 3 ---
>> drivers/gpu/drm/radeon/radeon_object.c | 1 +
>> 2 files changed, 1 insertion(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
>> index 9735f4968b86..bf2d4b16dc2a 100644
>> --- a/drivers/gpu/drm/radeon/radeon_gem.c
>> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
>> @@ -44,8 +44,6 @@ struct sg_table *radeon_gem_prime_get_sg_table(struct d=
rm_gem_object *obj);
>> int radeon_gem_prime_pin(struct drm_gem_object *obj);
>> void radeon_gem_prime_unpin(struct drm_gem_object *obj);
>>=20
>> -const struct drm_gem_object_funcs radeon_gem_object_funcs;
>> -
>> static vm_fault_t radeon_gem_fault(struct vm_fault *vmf)
>> {
>>        struct ttm_buffer_object *bo =3D vmf->vma->vm_private_data;
>> @@ -132,7 +130,6 @@ int radeon_gem_object_create(struct radeon_device *rd=
ev, unsigned long size,
>>                return r;
>>        }
>>        *obj =3D &robj->tbo.base;
>> -       (*obj)->funcs =3D &radeon_gem_object_funcs;
>>        robj->pid =3D task_pid_nr(current);
>>=20
>>        mutex_lock(&rdev->gem.mutex);
>> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/rad=
eon/radeon_object.c
>> index d0e4b43d155c..7672404fdb29 100644
>> --- a/drivers/gpu/drm/radeon/radeon_object.c
>> +++ b/drivers/gpu/drm/radeon/radeon_object.c
>> @@ -151,6 +151,7 @@ int radeon_bo_create(struct radeon_device *rdev,
>>        if (bo =3D=3D NULL)
>>                return -ENOMEM;
>>        drm_gem_private_object_init(rdev_to_drm(rdev), &bo->tbo.base, size=
);
>> +       bo->tbo.base.funcs =3D &radeon_gem_object_funcs;
>>        bo->rdev =3D rdev;
>>        bo->surface_reg =3D -1;
>>        INIT_LIST_HEAD(&bo->list);
>> --
>> 2.34.1
>>=20

