Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A670C2D0C8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 02:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDBA206B7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 02:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e79jc7wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDBA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931676E139;
	Mon, 23 Dec 2019 02:11:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805FA6E139
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 02:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htMbe8+jHhzPts0pF3NCS1mUYdh8Vw1Zf7Mja6h9+34OXuulck7BwLChPQTOMInMU7Tz0cMbEctTKP8dargHhMNdHJ9ZH2UAXMwNBtU62Qpywh9XSIUmcxQPV1ooPqnssSY/tGtKuJ5ofokkPHanDIu/LLvOsG6ddaf64nY0gn5E4BlbY4L198aWv2GqPk8X/iRc2ElcfihpfB8x8ctO/GDzKpiNbeMFvKsDTjohUxOWkM3EtHt2il6RGxH7YU1hzGZQx2fxUjCWd1BYXoyVAlLvQHOWey29idoHkzWHBbHyFULZocXvE93ruRkSqeLCSZjAXPe0wNLZGcu1ME4Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siDQipI++cdv5QKO0LcaSNZomz/uQF+HsVNqiamU0NM=;
 b=F8cSY0mkNx4+BHe83H2QavnF/9kraH2/zjJwVjbBWdNvsNK2qoTK8YeHx2pfbgpck74VBuVgyhZIzVypmkufmd6FcNUaS1sR/7V9r4FFzITvU5t8o+zn6YW1Ga4sKoPqR4gC9gYQBlKGp4JTKlNa0JdiJt3QT7+tN0cfFmS00v4eGKZENZYSWp3K+Uf/RPZQukUeXp/CVHSYvinI1ygfLvskdl/KUyayyoC9/PYIy2bYFUVb3mNNbA/8T8LpHt7Q+tQyWTzCTj7oUl1r9b2XH0sDLs1mPfkHA4YCjSnDg4pi9xX0kc1sKDcmBESetLaLuQKUycxsbBnfyF+7G47ogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siDQipI++cdv5QKO0LcaSNZomz/uQF+HsVNqiamU0NM=;
 b=e79jc7wn2MjA2AFJrQXtiwebukF3k2pmB6kAUX5gDWe6b2NSXpIoNXrAEs6LE8rtQJmrWV9mYf7fXHiwGU1yCjxky18LRNcYbJd3fI5zARPgD/rbykOkECXdXRfoGAmRR4hGWuYhWWDIwlCK9G5+wF4sUaZPmC6LZajCtOicTvU=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3232.namprd12.prod.outlook.com (20.179.80.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 02:10:57 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 02:10:57 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V4)
Thread-Topic: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of
 memory training(V4)
Thread-Index: AQHVtkz/lk8oqNdj102bJ1o7G4fLGqfB3ciAgABny1SAAOHsgIAAa42AgANsCB4=
Date: Mon, 23 Dec 2019 02:10:56 +0000
Message-ID: <MN2PR12MB2957B84C221FE02D4A7E2B69952E0@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191219091623.3922-1-tianci.yin@amd.com>
 <ae29000d-fb99-4846-6d66-3ce5f67013c5@amd.com>
 <MN2PR12MB29574DEB22704EAD912B00A8952D0@MN2PR12MB2957.namprd12.prod.outlook.com>
 <CADnq5_N0QbrFs3pvyd7gT0_5=+KXk1COj5K8-Dw=N6K-AW+P=A@mail.gmail.com>,
 <0e623827-46eb-2742-61f4-7a75ffc30de0@amd.com>
In-Reply-To: <0e623827-46eb-2742-61f4-7a75ffc30de0@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-23T02:10:56.189Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1452777d-c226-4255-f51e-08d7874d58f5
x-ms-traffictypediagnostic: MN2PR12MB3232:|MN2PR12MB3232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32325B8705F60C4B71F304AD952E0@MN2PR12MB3232.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(396003)(39850400004)(189003)(199004)(966005)(26005)(55016002)(8936002)(478600001)(110136005)(19627405001)(45080400002)(8676002)(7696005)(316002)(30864003)(4001150100001)(53546011)(81166006)(81156014)(6506007)(33656002)(4326008)(15650500001)(186003)(71200400001)(66556008)(66476007)(91956017)(76116006)(86362001)(66446008)(64756008)(66946007)(9686003)(54906003)(52536014)(5660300002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3232;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMa9Y+xqWK4tbYdq2MY1ZEA30QQ4qcG9XvnMiTKCtRJ+O0iuGyr/RulDLv/OXEX6b2Ys3klwASBrcmucq424v4nW0sH09/y5Zoe282dMZ8bH+pXNG5pCHWRa/LFEdMna6BVwX8E1Xvb/6FOd6KSsqImN1aZWf0imi034FUpZLHnVAvuf7mnqrpfG3NtkSq0z7Oih5I+dvdUU0FGctYUhib9dqMzYoUflei2Je7hLXw0VK4ZoZ3xZs1aNsIdRB0u/YYxBK8bVBGgsQJjOFT8UDxjcxPy1y/NhxECxw8z92gnUBJ4f5Y/SUcL1FFqyKLg0Zos/CwONTQbvEv/IF1qY3fZneqc7CNpVDj8PMHC9D9Zlg/SubIeTY9JdOnpr1ODcLTRqUjaKi6VQ5KOOqWYzsVYjrfj5N7xYxBYRUhelm/NRn9rfWi1NEWnRfC3WQVyUSiYvhi4SBKO12ZLYu+2uZpHkUGtvLG0JmduXmBRjYFs=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1452777d-c226-4255-f51e-08d7874d58f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 02:10:56.8991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhRV8zq6S56jegAZJMv5o7/Ajef4R+UJkeC7g1TtzvWWQT2KP4Zm+OhH3MWHlgnEvvAdsPHbGOyF8jxJMjgNsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3232
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0620901366=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0620901366==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957B84C221FE02D4A7E2B69952E0MN2PR12MB2957namp_"

--_000_MN2PR12MB2957B84C221FE02D4A7E2B69952E0MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thank you very much for your review!
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Saturday, December 21, 2019 5:52
To: Alex Deucher <alexdeucher@gmail.com>; Yin, Tianci (Rico) <Tianci.Yin@am=
d.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Long, Ga=
ng <Gang.Long@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <=
Kevin1.Wang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang=
, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of mem=
ory training(V4)

On 2019-12-20 10:27 a.m., Alex Deucher wrote:
> On Thu, Dec 19, 2019 at 9:00 PM Yin, Tianci (Rico) <Tianci.Yin@amd.com> w=
rote:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Hi Luben,
>>
>> May I have your Review-by?
>>

If you'd like--it's completely up to you. If you choose to, like Alex's bel=
ow.

Regards,
Luben

>
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>> Thanks a lot!
>> Rico
>> ________________________________
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Friday, December 20, 2019 3:47
>> To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Al=
exander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feife=
i <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>; Long, Gang <Ga=
ng.Long@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of =
memory training(V4)
>>
>> Yep! That's perfect--good job!
>>
>> Regards,
>> Luben
>>
>> On 2019-12-19 04:16, Tianci Yin wrote:
>>> From: "Tianci.Yin" <tianci.yin@amd.com>
>>>
>>> The method of getting fb_loc changed from parsing VBIOS to
>>> taking certain offset from top of VRAM
>>>
>>> Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539
>>> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  2 +-
>>>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 38 ++-----------------
>>>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 ++++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++++
>>>  drivers/gpu/drm/amd/include/atomfirmware.h    | 14 -------
>>>  7 files changed, 23 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
>>> index a78a363b1d71..fa2cf8e7bc07 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -642,9 +642,8 @@ struct amdgpu_fw_vram_usage {
>>>        struct amdgpu_bo *reserved_bo;
>>>        void *va;
>>>
>>> -     /* Offset on the top of VRAM, used as c2p write buffer.
>>> +     /* GDDR6 training support flag.
>>>        */
>>> -     u64 mem_train_fb_loc;
>>>        bool mem_train_support;
>>>  };
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atombios.c
>>> index 9ba80d828876..fdd52d86a4d7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
>>> @@ -2022,7 +2022,7 @@ int amdgpu_atombios_init(struct amdgpu_device *ad=
ev)
>>>        if (adev->is_atom_fw) {
>>>                amdgpu_atomfirmware_scratch_regs_init(adev);
>>>                amdgpu_atomfirmware_allocate_fb_scratch(adev);
>>> -             ret =3D amdgpu_atomfirmware_get_mem_train_fb_loc(adev);
>>> +             ret =3D amdgpu_atomfirmware_get_mem_train_info(adev);
>>>                if (ret) {
>>>                        DRM_ERROR("Failed to get mem train fb location.\=
n");
>>>                        return ret;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> index ff4eb96bdfb5..58f9d8c3a17a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> @@ -525,16 +525,12 @@ static int gddr6_mem_train_support(struct amdgpu_=
device *adev)
>>>        return ret;
>>>  }
>>>
>>> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *ade=
v)
>>> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)
>>>  {
>>>        struct atom_context *ctx =3D adev->mode_info.atom_context;
>>> -     unsigned char *bios =3D ctx->bios;
>>> -     struct vram_reserve_block *reserved_block;
>>> -     int index, block_number;
>>> +     int index;
>>>        uint8_t frev, crev;
>>>        uint16_t data_offset, size;
>>> -     uint32_t start_address_in_kb;
>>> -     uint64_t offset;
>>>        int ret;
>>>
>>>        adev->fw_vram_usage.mem_train_support =3D false;
>>> @@ -569,32 +565,6 @@ int amdgpu_atomfirmware_get_mem_train_fb_loc(struc=
t amdgpu_device *adev)
>>>                return -EINVAL;
>>>        }
>>>
>>> -     reserved_block =3D (struct vram_reserve_block *)
>>> -             (bios + data_offset + sizeof(struct atom_common_table_hea=
der));
>>> -     block_number =3D ((unsigned int)size - sizeof(struct atom_common_=
table_header))
>>> -             / sizeof(struct vram_reserve_block);
>>> -     reserved_block +=3D (block_number > 0) ? block_number-1 : 0;
>>> -     DRM_DEBUG("block_number:0x%04x, last block: 0x%08xkb sz, %dkb fw,=
 %dkb drv.\n",
>>> -               block_number,
>>> -               le32_to_cpu(reserved_block->start_address_in_kb),
>>> -               le16_to_cpu(reserved_block->used_by_firmware_in_kb),
>>> -               le16_to_cpu(reserved_block->used_by_driver_in_kb));
>>> -     if (reserved_block->used_by_firmware_in_kb > 0) {
>>> -             start_address_in_kb =3D le32_to_cpu(reserved_block->start=
_address_in_kb);
>>> -             offset =3D (uint64_t)start_address_in_kb * ONE_KiB;
>>> -             if ((offset & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) ) {
>>> -                     offset -=3D ONE_MiB;
>>> -             }
>>> -
>>> -             offset &=3D ~(ONE_MiB - 1);
>>> -             adev->fw_vram_usage.mem_train_fb_loc =3D offset;
>>> -             adev->fw_vram_usage.mem_train_support =3D true;
>>> -             DRM_DEBUG("mem_train_fb_loc:0x%09llx.\n", offset);
>>> -             ret =3D 0;
>>> -     } else {
>>> -             DRM_ERROR("used_by_firmware_in_kb is 0!\n");
>>> -             ret =3D -EINVAL;
>>> -     }
>>> -
>>> -     return ret;
>>> +     adev->fw_vram_usage.mem_train_support =3D true;
>>> +     return 0;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> index f871af5ea6f3..434fe2fa0089 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> @@ -31,7 +31,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amd=
gpu_device *adev);
>>>  int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev=
);
>>>  int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>>>        int *vram_width, int *vram_type, int *vram_vendor);
>>> -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_device *ade=
v);
>>> +int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_device *adev)=
;
>>>  int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
>>>  int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
>>>  bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev)=
;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
>>> index 2ff63d0414c9..1515413fd356 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1687,6 +1687,14 @@ static int amdgpu_ttm_training_reserve_vram_fini=
(struct amdgpu_device *adev)
>>>        return 0;
>>>  }
>>>
>>> +static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_size)
>>> +{
>>> +       if ((vram_size & (ONE_MiB - 1)) < (4 * ONE_KiB + 1) )
>>> +               vram_size -=3D ONE_MiB;
>>> +
>>> +       return ALIGN(vram_size, ONE_MiB);
>>> +}
>>> +
>>>  /**
>>>   * amdgpu_ttm_training_reserve_vram_init - create bo vram reservation =
from memory training
>>>   *
>>> @@ -1705,7 +1713,7 @@ static int amdgpu_ttm_training_reserve_vram_init(=
struct amdgpu_device *adev)
>>>                return 0;
>>>        }
>>>
>>> -     ctx->c2p_train_data_offset =3D adev->fw_vram_usage.mem_train_fb_l=
oc;
>>> +     ctx->c2p_train_data_offset =3D amdgpu_ttm_training_get_c2p_offset=
(adev->gmc.mc_vram_size);
>>>        ctx->p2c_train_data_offset =3D (adev->gmc.mc_vram_size - GDDR6_M=
EM_TRAINING_OFFSET);
>>>        ctx->train_data_size =3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.h
>>> index f1ebd424510c..19eb3e8456c7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -66,6 +66,13 @@ struct amdgpu_copy_mem {
>>>        unsigned long                   offset;
>>>  };
>>>
>>> +/* Definitions for constance */
>>> +enum amdgpu_internal_constants
>>> +{
>>> +     ONE_KiB =3D 0x400,
>>> +     ONE_MiB =3D 0x100000,
>>> +};
>>> +
>>>  extern const struct ttm_mem_type_manager_func amdgpu_gtt_mgr_func;
>>>  extern const struct ttm_mem_type_manager_func amdgpu_vram_mgr_func;
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/d=
rm/amd/include/atomfirmware.h
>>> index dd7cbc00a0aa..70146518174c 100644
>>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>>> @@ -672,20 +672,6 @@ struct vram_usagebyfirmware_v2_1
>>>    uint16_t  used_by_driver_in_kb;
>>>  };
>>>
>>> -/* This is part of vram_usagebyfirmware_v2_1 */
>>> -struct vram_reserve_block
>>> -{
>>> -     uint32_t start_address_in_kb;
>>> -     uint16_t used_by_firmware_in_kb;
>>> -     uint16_t used_by_driver_in_kb;
>>> -};
>>> -
>>> -/* Definitions for constance */
>>> -enum atomfirmware_internal_constants
>>> -{
>>> -     ONE_KiB =3D 0x400,
>>> -     ONE_MiB =3D 0x100000,
>>> -};
>>>
>>>  /*
>>>    ********************************************************************=
*******
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CLuben=
.Tuikov%40amd.com%7C3297c2cd4a9347a202ff08d7856137ad%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637124524929052366&amp;sdata=3D0z7AeiekGUW1PsvttFCi%=
2FcxV1tmLlnRZU%2FkvTRUPm70%3D&amp;reserved=3D0


--_000_MN2PR12MB2957B84C221FE02D4A7E2B69952E0MN2PR12MB2957namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you very much for your review!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Saturday, December 21, 2019 5:52<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Yin, Tianci (Rico) &=
lt;Tianci.Yin@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com=
&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt=
;;
 Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Yuan, Xiaojie &lt;Xiao=
jie.Yuan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc=
 of memory training(V4)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-12-20 10:27 a.m., Alex Deucher wrote:<br>
&gt; On Thu, Dec 19, 2019 at 9:00 PM Yin, Tianci (Rico) &lt;Tianci.Yin@amd.=
com&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi Luben,<br>
&gt;&gt;<br>
&gt;&gt; May I have your Review-by?<br>
&gt;&gt;<br>
<br>
If you'd like--it's completely up to you. If you choose to, like Alex's bel=
ow.<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt; <br>
&gt; Series is:<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; <br>
&gt;&gt; Thanks a lot!<br>
&gt;&gt; Rico<br>
&gt;&gt; ________________________________<br>
&gt;&gt; From: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;<br>
&gt;&gt; Sent: Friday, December 20, 2019 3:47<br>
&gt;&gt; To: Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.f=
reedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt;&gt; Cc: Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, A=
lexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhan=
g@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiao=
jie.Yuan@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yan=
g)
 &lt;Kevin1.Wang@amd.com&gt;<br>
&gt;&gt; Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_l=
oc of memory training(V4)<br>
&gt;&gt;<br>
&gt;&gt; Yep! That's perfect--good job!<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Luben<br>
&gt;&gt;<br>
&gt;&gt; On 2019-12-19 04:16, Tianci Yin wrote:<br>
&gt;&gt;&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The method of getting fb_loc changed from parsing VBIOS to<br>
&gt;&gt;&gt; taking certain offset from top of VRAM<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Change-Id: I053b42fdb1d822722fa7980b2cd9f86b3fdce539<br>
&gt;&gt;&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;-<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c&nbsp; |&nbs=
p; 2 &#43;-<br>
&gt;&gt;&gt;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c&nbsp; | 38 =
&#43;&#43;-----------------<br>
&gt;&gt;&gt;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h&nbsp; |&nbs=
p; 2 &#43;-<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | 10 &#43;&#43;&#43;&#43;-<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 7 &#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/include/atomfirmware.h&nbsp;&nbsp;&n=
bsp; | 14 -------<br>
&gt;&gt;&gt;&nbsp; 7 files changed, 23 insertions(&#43;), 53 deletions(-)<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt; index a78a363b1d71..fa2cf8e7bc07 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt; @@ -642,9 &#43;642,8 @@ struct amdgpu_fw_vram_usage {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *re=
served_bo;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *va;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Offset on the top of VRAM, used a=
s c2p write buffer.<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* GDDR6 training support flag.<=
br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 mem_train_fb_loc;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mem_train_suppo=
rt;<br>
&gt;&gt;&gt;&nbsp; };<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c<br>
&gt;&gt;&gt; index 9ba80d828876..fdd52d86a4d7 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c=
<br>
&gt;&gt;&gt; @@ -2022,7 &#43;2022,7 @@ int amdgpu_atombios_init(struct amdg=
pu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;is_atom=
_fw) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atomfirmware_scratch_regs_init(adev);<br=
>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atomfirmware_allocate_fb_scratch(adev);<=
br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ret =3D amdgpu_atomfirmware_get_mem_train_fb_loc(adev);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D amdgpu_atomfirmware_get_mem_train_info(adev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 DRM_ERROR(&quot;Failed to get mem train fb location.\n&quot;);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return ret;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt;&gt;&gt; index ff4eb96bdfb5..58f9d8c3a17a 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmwa=
re.c<br>
&gt;&gt;&gt; @@ -525,16 &#43;525,12 @@ static int gddr6_mem_train_support(s=
truct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_de=
vice *adev)<br>
&gt;&gt;&gt; &#43;int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_=
device *adev)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context =
*ctx =3D adev-&gt;mode_info.atom_context;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned char *bios =3D ctx-&gt;bios=
;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct vram_reserve_block *reserved_=
block;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int index, block_number;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int index;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t frev, crev;<=
br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t data_offset=
, size;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start_address_in_kb;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usa=
ge.mem_train_support =3D false;<br>
&gt;&gt;&gt; @@ -569,32 &#43;565,6 @@ int amdgpu_atomfirmware_get_mem_train=
_fb_loc(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; reserved_block =3D (struct vram_rese=
rve_block *)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (bios &#43; data_offset &#43; sizeof(struct atom_common_table_h=
eader));<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; block_number =3D ((unsigned int)size=
 - sizeof(struct atom_common_table_header))<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; / sizeof(struct vram_reserve_block);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; reserved_block &#43;=3D (block_numbe=
r &gt; 0) ? block_number-1 : 0;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;block_number:0x%04x,=
 last block: 0x%08xkb sz, %dkb fw, %dkb drv.\n&quot;,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; block_number,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(reserved_block-&gt;start_address_in_kb)=
,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(reserved_block-&gt;used_by_firmware_in_=
kb),<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; le16_to_cpu(reserved_block-&gt;used_by_driver_in_kb=
));<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (reserved_block-&gt;used_by_firmw=
are_in_kb &gt; 0) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; start_address_in_kb =3D le32_to_cpu(reserved_block-&gt;start_ad=
dress_in_kb);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; offset =3D (uint64_t)start_address_in_kb * ONE_KiB;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if ((offset &amp; (ONE_MiB - 1)) &lt; (4 * ONE_KiB &#43; 1) ) {=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset -=3D ONE=
_MiB;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; offset &amp;=3D ~(ONE_MiB - 1);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; adev-&gt;fw_vram_usage.mem_train_fb_loc =3D offset;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; adev-&gt;fw_vram_usage.mem_train_support =3D true;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; DRM_DEBUG(&quot;mem_train_fb_loc:0x%09llx.\n&quot;, offset);<br=
>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ret =3D 0;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; DRM_ERROR(&quot;used_by_firmware_in_kb is 0!\n&quot;);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ret =3D -EINVAL;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.mem_train=
_support =3D true;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h<br>
&gt;&gt;&gt; index f871af5ea6f3..434fe2fa0089 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmwa=
re.h<br>
&gt;&gt;&gt; @@ -31,7 &#43;31,7 @@ void amdgpu_atomfirmware_scratch_regs_in=
it(struct amdgpu_device *adev);<br>
&gt;&gt;&gt;&nbsp; int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgp=
u_device *adev);<br>
&gt;&gt;&gt;&nbsp; int amdgpu_atomfirmware_get_vram_info(struct amdgpu_devi=
ce *adev,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *vram_width, int=
 *vram_type, int *vram_vendor);<br>
&gt;&gt;&gt; -int amdgpu_atomfirmware_get_mem_train_fb_loc(struct amdgpu_de=
vice *adev);<br>
&gt;&gt;&gt; &#43;int amdgpu_atomfirmware_get_mem_train_info(struct amdgpu_=
device *adev);<br>
&gt;&gt;&gt;&nbsp; int amdgpu_atomfirmware_get_clock_info(struct amdgpu_dev=
ice *adev);<br>
&gt;&gt;&gt;&nbsp; int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_devic=
e *adev);<br>
&gt;&gt;&gt;&nbsp; bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu=
_device *adev);<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt; index 2ff63d0414c9..1515413fd356 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt; @@ -1687,6 &#43;1687,14 @@ static int amdgpu_ttm_training_rese=
rve_vram_fini(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;static u64 amdgpu_ttm_training_get_c2p_offset(u64 vram_si=
ze)<br>
&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((vram_size &amp;=
 (ONE_MiB - 1)) &lt; (4 * ONE_KiB &#43; 1) )<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; vram_size -=3D ONE_MiB;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ALIGN(vram_si=
ze, ONE_MiB);<br>
&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp; /**<br>
&gt;&gt;&gt;&nbsp;&nbsp; * amdgpu_ttm_training_reserve_vram_init - create b=
o vram reservation from memory training<br>
&gt;&gt;&gt;&nbsp;&nbsp; *<br>
&gt;&gt;&gt; @@ -1705,7 &#43;1713,7 @@ static int amdgpu_ttm_training_reser=
ve_vram_init(struct amdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =3D ad=
ev-&gt;fw_vram_usage.mem_train_fb_loc;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset =
=3D amdgpu_ttm_training_get_c2p_offset(adev-&gt;gmc.mc_vram_size);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_da=
ta_offset =3D (adev-&gt;gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_s=
ize =3D GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt;&gt; index f1ebd424510c..19eb3e8456c7 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt;&gt; @@ -66,6 &#43;66,13 @@ struct amdgpu_copy_mem {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; offset;<br>
&gt;&gt;&gt;&nbsp; };<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;/* Definitions for constance */<br>
&gt;&gt;&gt; &#43;enum amdgpu_internal_constants<br>
&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ONE_KiB =3D 0x400,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ONE_MiB =3D 0x100000,<br>
&gt;&gt;&gt; &#43;};<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp; extern const struct ttm_mem_type_manager_func amdgpu_gtt=
_mgr_func;<br>
&gt;&gt;&gt;&nbsp; extern const struct ttm_mem_type_manager_func amdgpu_vra=
m_mgr_func;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/driv=
ers/gpu/drm/amd/include/atomfirmware.h<br>
&gt;&gt;&gt; index dd7cbc00a0aa..70146518174c 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/atomfirmware.h<b=
r>
&gt;&gt;&gt; @@ -672,20 &#43;672,6 @@ struct vram_usagebyfirmware_v2_1<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; uint16_t&nbsp; used_by_driver_in_kb;<br>
&gt;&gt;&gt;&nbsp; };<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -/* This is part of vram_usagebyfirmware_v2_1 */<br>
&gt;&gt;&gt; -struct vram_reserve_block<br>
&gt;&gt;&gt; -{<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t start_address_in_kb;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint16_t used_by_firmware_in_kb;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint16_t used_by_driver_in_kb;<br>
&gt;&gt;&gt; -};<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -/* Definitions for constance */<br>
&gt;&gt;&gt; -enum atomfirmware_internal_constants<br>
&gt;&gt;&gt; -{<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ONE_KiB =3D 0x400,<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ONE_MiB =3D 0x100000,<br>
&gt;&gt;&gt; -};<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; /*<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; ********************************************=
*******************************<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;d=
ata=3D02%7C01%7CLuben.Tuikov%40amd.com%7C3297c2cd4a9347a202ff08d7856137ad%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637124524929052366&amp;amp;sdat=
a=3D0z7AeiekGUW1PsvttFCi%2FcxV1tmLlnRZU%2FkvTRUPm70%3D&amp;amp;reserved=3D0=
">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CLube=
n.Tuikov%40amd.com%7C3297c2cd4a9347a202ff08d7856137ad%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637124524929052366&amp;amp;sdata=3D0z7AeiekGUW1Psvt=
tFCi%2FcxV1tmLlnRZU%2FkvTRUPm70%3D&amp;amp;reserved=3D0</a><br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB2957B84C221FE02D4A7E2B69952E0MN2PR12MB2957namp_--

--===============0620901366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0620901366==--
