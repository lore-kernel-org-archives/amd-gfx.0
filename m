Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5EDC4321E
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 07:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F028110F039;
	Mon, 11 Apr 2022 07:49:38 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE8110E169
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Apr 2022 01:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZftBmfguduv1XxHOTG+5BTsyULVG861LPfkaRUxlstBsi21wIoHQuSuHMKL5arGv/COow9Hcv+iMwGTLhLjl/IhaOdrajT4tco3rGgyVq9VTxYib7mxCd/LtgG5zLvXtqDA0E3t7TCMV6jRNjR9npHpAkl7RM5myH1MQMMV/M0KN6eHCBNShHlYZLEzox/fgmCgVxzjphvZYnONLZA6ME0owZvit2SnS+j4Z+qSyZ9iXheM/gHGTJoAYAIBLRgz972C2wplg5Cd9AlZpw3QeWQOv4n5WT3rUPtmvoKHkhials0QjsKSl0057IbkCRB7yHj4rrY89p8Vr71fubQrzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApiMM8G7eJ4AteNvvdwraEQtZde9DGXvwwpnLoVNGL8=;
 b=JcZVzKIZJgqJAaMhTw6hGuXhW8UwBd8P2zIUOnox7UAf1+UQeDhHyMWy0+SkHxNkpenU7JyO4Pgzlls+CC6iguGNg/jXolxbe46HYrOvlWAZh1+x77iQUWWjxT4YYuFEAD6gAtzBI8Ri7G/SCJcIzos+/FuH7wzrO3MLN9zV6LCmE1LX9WUtepWb6wrvg2tK9UrOeyzdSQYp51NVbjLEEksGff7z7uQv5T2ocAPfxDYaeN0jjp5L0p9Qx8DziXYu70TvnzmqpIjr9tosQw0sLp2/gj4dADWt5a0Ymi01fpQApVg+Afe2HeCQBwP8ccaEDPlnVtyuZJzp0/iNnYbyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApiMM8G7eJ4AteNvvdwraEQtZde9DGXvwwpnLoVNGL8=;
 b=jzxXFDQSLLCj32IRNlspvpi187s4rxLMviwV2WRJu1hNiAMrZ8pVRneMELki09ucrbQ1UZieBT2U3qPk8mpSBm6rFAZfLtcplLjbsYzsxcyEZx+jpt8F3uW4jC7cIEDKVPRs9eraHsIuQuxu64kcwYP44xOV2IYvOFPsK49MoEw=
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM (2603:1096:301:67::8) by
 HK0P153MB0337.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b6::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.12; Sat, 9 Apr 2022 01:28:52 +0000
Received: from PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::1882:5419:b04e:ca1e]) by PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
 ([fe80::1882:5419:b04e:ca1e%7]) with mapi id 15.20.5186.000; Sat, 9 Apr 2022
 01:28:52 +0000
From: Shuotao Xu <shuotaoxu@microsoft.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Thread-Topic: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Thread-Index: AQHYS7ErrtnDoLaaKk2DvTm7AvLutA==
Date: Sat, 9 Apr 2022 01:28:51 +0000
Message-ID: <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <20220408084544.9313-2-shuotaoxu@microsoft.com>
 <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
In-Reply-To: <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce8a20db-2c92-45c8-07c6-08da19c84dfb
x-ms-traffictypediagnostic: HK0P153MB0337:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <HK0P153MB0337B50A8BCAB7978C708496B7E89@HK0P153MB0337.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDB/FLfP446SpjYVTS0hkW/7LhvGeJk52wFmAxiqtKC7lxdlHa6hZH7HuUyse/LKAEo4rGEwFx6TqeEkkA0Uz9pejNF8ZhztmfiLcajrIyyBDdwW2FmqB68SHZ9drWv6r6B1FY4Ayk4VQRKF0m69HGn2QjUWRPbmqDhNhZEAQWnlHLF8hXwwfTj/M86UoBpyXSt6mz9EA33YHE1dIfh2e3e9gOPap4/K42vglLtcH+leJ99akQrWaU2TnDf9wKWm82mrC8i2fKZPS78iTCPsIEWTFWnavrRcOBYdlXGbwGn8KeVZCrE4YF2cBg9rlhaMrJix6CMkUBw+bMqz6PFddrwsbsN6CSVRaLndm8Skux9VQOETW5zHhven3WdtoKZV4xSrIrYVdC6B0Gzj5yRa5XOrJO2bGkAjZTvqwzBookHRZ+Zj98d5uTqnUy5j/tOEBT+xsWSeuzGBvLLp2ZG4PBiYxLvNdYzMn+wS/gKeQkPAnGnMDhM41hL22KFqd2dqu7OrduquOVF5Nb1NQ90yvdLKhPFjPNLOGyrch8jFQJ/q6m/BfTgGUe5MUfBg01dSFEvXqXWEJm80R9eqTdO43jfYsELVxHgPxwOtefsdiHlkvTvCf+6Azv2niiDGYRx5GJY1nWkgmqd73HmGfknb4alQ25FpBOsk+Qdt8hfuVtfTyQiOQVbOPtJ7GtXf/CCmMXYQ1NqndfqDqPmRgnQJpdtoj3+W7mlqUTYjkiLK2DGivQXCH/M78T57o1d669tgdZk53pkCDY3uEQjRuKasoB2degK6j3L94xIh8HyyJJKhkqo+CZW++rggN+8rhBgV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAP153MB0517.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(66946007)(66556008)(83380400001)(53546011)(54906003)(6916009)(316002)(122000001)(82950400001)(82960400001)(33656002)(186003)(2616005)(508600001)(38100700002)(76116006)(10290500003)(66446008)(6506007)(6512007)(966005)(6486002)(36756003)(5660300002)(2906002)(8676002)(64756008)(66476007)(91956017)(8936002)(107886003)(4326008)(86362001)(38070700005)(71200400001)(45980500001)(10090945011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hnNSUIB4Grxv7ZAcrpgMhqpwG9U5vSb76Qo0jqWs4qXudZTX8fw5gvMiLbnU?=
 =?us-ascii?Q?6P1H21UfXOzRuajt8zAtWB+6yPJTf+hkAqGaz7SsMFrWM45xbPRNSABxTNKj?=
 =?us-ascii?Q?cvrviUgPw5S0RUKTgLESYn4og84MtmHhDO2gzqXG+o9kUUojFgM1ixlJaLv0?=
 =?us-ascii?Q?GuMGwI6wJvv9mxjgY8+RLjhuj1ffmC879Ft/8KAweInZAJ+2fXAmwlH98DmA?=
 =?us-ascii?Q?DmR1NxGgPmWYfwvzs8HCx0yftE4xr3N/2lvYYWnWHtRYFdgLN6Ed/XQqaSJU?=
 =?us-ascii?Q?xJAOHi05/lpa5u1CfhBFSTHZh24a+VXiXJaxhtlAKfmYm10G4OPkxSUP3OP+?=
 =?us-ascii?Q?Cyj1a4Qp20QHo5m5uU0m8JPfyW9a/mZLaiS0nfpcWTDH9avgbNJxpIb/obSY?=
 =?us-ascii?Q?pva8oH8duHd+wsZrMv0Hs0w53E89gaTBsm8LcSuXZr7zsGVeMeKHyWvi+VmW?=
 =?us-ascii?Q?D4hShvJRaJp2br6B+UdAz+FbLE2Bs+0iKRFyqrILZFKENhmLJmbbFQPbve0+?=
 =?us-ascii?Q?Pl9ghU64mpzamadnYLcprX6Q9B0K+rDmSNOfqlg05bE0IcDSuKZoTOHgxlT9?=
 =?us-ascii?Q?aHhZ8kMpu1JQiVy5xQ6qHkBKZ1Sjx8HCf1QgMyBc9sSn4CYYQIKDMQCb9Szd?=
 =?us-ascii?Q?fs/zcYIofdng/wTBEZ7L978gLMA6d3pIfFxYA8qsmQC+UbZXiDQn21SAQLL4?=
 =?us-ascii?Q?uqtzmk/7+QKxVhIIrlb3qvEKhUymoD8NOfE23w9oIgqQdLlTWHERfLcFTKQJ?=
 =?us-ascii?Q?5U5byUpNfglsQ7PzC/ZNJlFiwJgtwwkk4zuPFsOq4kaDL9AVittZJJOFfddp?=
 =?us-ascii?Q?4yWhg2VaN3Ot/tu0xIC6rr1NgP1c4LB+NZSV/jZALF4dKudj96o0YYk/f87/?=
 =?us-ascii?Q?KjSMbD0Bk+nsnXxAv/HkDcE9ihopsqzwo7aoO1vjr1axwuLU71JyF33XNcCo?=
 =?us-ascii?Q?kfKwlPC6mi20LXwgP2wOWlxiVdV/rXvKHJbhGXuKtPbunoclXlpnxxhMiUuR?=
 =?us-ascii?Q?qfh8VwSGjxLHmFsNuO1AG1cm8MDAtVH1DTMOumWwLptzzptEtLSuea13Xk0a?=
 =?us-ascii?Q?WawvXF14sJXRDiaCg0fb00c6sOiTMF6hqN9vNVXNbldx7qfqdrVbQSyN4I8h?=
 =?us-ascii?Q?H0NAtstX8015cSdOXPj5vtiGP0z9kntswaYadBM1gSHRj30GDkYZ52oqCWBQ?=
 =?us-ascii?Q?EjHkJrkKvNvWeEbz3pHenNBIqjptHmRjihjdzq/UFhOz26Q++vtvZJxBT3/c?=
 =?us-ascii?Q?2NwfddapS9FIUj5gOwIKcEB2y6Obf4yDU31JiOjkuoAfZG0uHZBaGW6UcpAg?=
 =?us-ascii?Q?I9qGviGrl3oifTZHAPEJj0f1JSPE9MluSfc5Jab6EVh52jGPmbTfCeH1b7Vd?=
 =?us-ascii?Q?qVCv7mycHch/WvNGmJGxb1n4DLZrUbrQeoTvljnK3qN0LZ+wjy4giaJhoUAG?=
 =?us-ascii?Q?917paSvgiWRD69P95zLA4+hOk1mfmaPey0aoSfc2SU3hmdeA+Jofd0H1+oL5?=
 =?us-ascii?Q?fxThAlbYPQl2YAr+lgLsUJsmaTUK7LdTqU+Z4WaOQe9bHJpoCuYRhNRAl3q9?=
 =?us-ascii?Q?siPTrDMMVL1tn8GgHRIOOvKUnFnRCJ+aRDelD5D8u9TtFzuQ/yZMdxnvD23X?=
 =?us-ascii?Q?qXmIN592iSBuz1v6GeEfb5aYqGOv3N7dsddpHVyEhHIK50U04c94lw1ESd7G?=
 =?us-ascii?Q?lWm/NSIuvwlmdSR+TgZQ+omJ7debNF/P84ry68o/IfHBOIsGEVCNSEZzS6Mf?=
 =?us-ascii?Q?bx1g12N2JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7D4D6212605C14187F9951D25278787@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0517.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8a20db-2c92-45c8-07c6-08da19c84dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2022 01:28:51.7847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjWKb+Izm/z5ttvECTXxBxq9UOkgJ08i5Si/pBUheE0+/ot2+qJv+tqbCNq7gXpfN88IzJ2glLseb6rBara3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0337
X-Mailman-Approved-At: Mon, 11 Apr 2022 07:49:38 +0000
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> On Apr 8, 2022, at 11:28 PM, Andrey Grodzovsky <andrey.grodzovsky@amd.com=
> wrote:
>=20
> [Some people who received this message don't often get email from andrey.=
grodzovsky@amd.com. Learn why this is important at http://aka.ms/LearnAbout=
SenderIdentification.]
>=20
> On 2022-04-08 04:45, Shuotao Xu wrote:
>> Adding PCIe Hotplug Support for AMDKFD: the support of hot-plug of GPU
>> devices can open doors for many advanced applications in data center
>> in the next few years, such as for GPU resource
>> disaggregation. Current AMDKFD does not support hotplug out b/o the
>> following reasons:
>>=20
>> 1. During PCIe removal, decrement KFD lock which was incremented at
>>    the beginning of hw fini; otherwise kfd_open later is going to
>>    fail.
>=20
> I assumed you read my comment last time, still you do same approach.
> More in details bellow

Aha, I like your fix:) I was not familiar with drm APIs so just only half u=
nderstood your comment last time.=20

BTW, I tried hot-plugging out a GPU when rocm application is still running.
From dmesg, application is still trying to access the removed kfd device, a=
nd are met with some errors.
Application would hang and not exiting in this case.

Do you have any good suggestions on how to fix it down the line? (HIP runti=
me/libhsakmt or driver)

[64036.631333] amdgpu: amdgpu_vm_bo_update failed
[64036.631702] amdgpu: validate_invalid_user_pages: update PTE failed
[64036.640754] amdgpu: amdgpu_vm_bo_update failed
[64036.641120] amdgpu: validate_invalid_user_pages: update PTE failed
[64036.650394] amdgpu: amdgpu_vm_bo_update failed
[64036.650765] amdgpu: validate_invalid_user_pages: update PTE failed

Really appreciate your help!

Best,
Shuotao
=20
>=20
>>=20
>> 2. Remove redudant p2p/io links in sysfs when device is hotplugged
>>    out.
>>=20
>> 3. New kfd node_id is not properly assigned after a new device is
>>    added after a gpu is hotplugged out in a system. libhsakmt will
>>    find this anomaly, (i.e. node_from !=3D <dev node id> in iolinks),
>>    when taking a topology_snapshot, thus returns fault to the rocm
>>    stack.
>>=20
>> -- This patch fixes issue 1; another patch by Mukul fixes issues 2&3.
>> -- Tested on a 4-GPU MI100 gpu nodes with kernel 5.13.0-kfd; kernel
>>    5.16.0-kfd is unstable out of box for MI100.
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 +++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  7 +++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
>>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 13 +++++++++++++
>>  4 files changed, 26 insertions(+)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_amdkfd.c
>> index c18c4be1e4ac..d50011bdb5c4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev=
, bool run_pm)
>>      return r;
>>  }
>>=20
>> +int amdgpu_amdkfd_resume_processes(void)
>> +{
>> +     return kgd2kfd_resume_processes();
>> +}
>> +
>>  int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>>  {
>>      int r =3D 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_amdkfd.h
>> index f8b9f27adcf5..803306e011c3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
>>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>  int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>> +int amdgpu_amdkfd_resume_processes(void);
>>  void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>                      const void *ih_ring_entry);
>>  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>> @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>>  int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>> +int kgd2kfd_resume_processes(void);
>>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
>>  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
>> @@ -393,6 +395,11 @@ static inline int kgd2kfd_resume(struct kfd_dev *kf=
d, bool run_pm)
>>      return 0;
>>  }
>>=20
>> +static inline int kgd2kfd_resume_processes(void)
>> +{
>> +     return 0;
>> +}
>> +
>>  static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>>  {
>>      return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
>> index fa4a9f13c922..5827b65b7489 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *a=
dev)
>>      if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>              amdgpu_device_unmap_mmio(adev);
>>=20
>> +     amdgpu_amdkfd_resume_processes();
>>  }
>>=20
>>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_device.c
>> index 62aa6c9d5123..ef05aae9255e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm=
)
>>      return ret;
>>  }
>>=20
>> +/* for non-runtime resume only */
>> +int kgd2kfd_resume_processes(void)
>> +{
>> +     int count;
>> +
>> +     count =3D atomic_dec_return(&kfd_locked);
>> +     WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>> +     if (count =3D=3D 0)
>> +             return kfd_resume_all_processes();
>> +
>> +     return 0;
>> +}
>=20
>=20
> It doesn't make sense to me to just increment kfd_locked in
> kgd2kfd_suspend to only decrement it again a few functions down the
> road.
>=20
> I suggest this instead - you only incrmemnt if not during PCI remove
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 1c2cf3a33c1f..7754f77248a4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -952,11 +952,12 @@ bool kfd_is_locked(void)
>=20
> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> {
> +
>        if (!kfd->init_complete)
>                return;
>=20
>        /* for runtime suspend, skip locking kfd */
> -       if (!run_pm) {
> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>                /* For first KFD device suspend all the KFD processes */
>                if (atomic_inc_return(&kfd_locked) =3D=3D 1)
>                        kfd_suspend_all_processes();
>=20
>=20
> Andrey
>=20
>=20
>=20
>> +
>>  int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>  {
>>      int err =3D 0;

