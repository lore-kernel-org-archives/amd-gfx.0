Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2EAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245C160FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 16:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 245C160FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EA86EA35;
	Wed, 10 Nov 2021 16:11:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098266EA35
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 16:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk0LdpAplhn44T+1TyKX9F+n1FUyu9TN7msGAdqOzT1eObGChvC4wdztZXnKPX2ZkMBtZCN37lQIa0jkQVt4ULp5nl5kBFby5dRFWN01WaZHq4PRjU4GGlW34GhB5KzLkaxCrKowK4bwzEtXxgGbH3HlaZ7BaSyW8uzHZ42ZVwBOLUrzHnqjNsg9rhZY+YNnOVXh1lR+fnj0AyR1E7tL6QSiD/29aDRzN9ivuaXYMUnfDUAel3peSZjmzfll1G+mu4c7UM6nne1L12OutaSHzts5coGkkfDi7zd/Ll8H2Ypc3SLvFDpFG7pYdOLGRFvNZLi0JgkF4rue1jRq5b4Tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBXgrMW3x84x0Tzms6uqsh+pbshfbmP7oP5WHRipmvU=;
 b=NYZO9IYipEm9AAgn2KAlk9pv8rPk///QR2+c2CapvzyNW0qVGPYsnvfKgfQEFzw2nDOhKNWZd3SexgAE5yVT3NUBo+yHZQQfwArQCZYt5OPjT4C7iIhWAcQ7wTaoqGifnVjxQ3MAGVg3P52OjXGLhWPBvFzoQTFkQko5G3KPIvn2vnTR5wu1KnbVkM3SpDglUzK9xA/5lQ00Zca16PgAyn10DYDytDdvJei8sTNqovm30vzqnXgf8yzE/ppn7r8RLcNWigFLCuDniMip5/3CztWJ1FfxKoSFziHWyqV0J9RGUn4+C537chePzhm677vhc/O6I8lgxoYKjErVdA7BlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBXgrMW3x84x0Tzms6uqsh+pbshfbmP7oP5WHRipmvU=;
 b=aJC0Wv0J4NdexvOlKD6nGNJEFBRpNAOMujITr4UEHeNtpEvWQreg8dojZh7wuPqy9QnHk2dOPTn4gp0wzU/FzmB0Ex1+HYJxaXQHNtDFED9ltOGmEe6+c7wJScOopm0Iv/x0Hx6/FTfHYLggCU0pUHDU2Os2ZLRJ0FvkfWJtR8w=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 16:11:29 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 16:11:29 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
Thread-Topic: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV
Thread-Index: AQHX1dsRYJXg7f3ZtEKPUGJTgg52+Kv8euyAgABwqQCAAAKkqw==
Date: Wed, 10 Nov 2021 16:11:29 +0000
Message-ID: <DM6PR12MB39307C2E18445AA344F9930F97939@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211110023052.1872623-1-Felix.Kuehling@amd.com>
 <48473282-292c-508a-1a4e-42359c421f01@amd.com>
 <dd7f5e89-338b-c331-829e-5fba0594a0cb@amd.com>
In-Reply-To: <dd7f5e89-338b-c331-829e-5fba0594a0cb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-10T16:07:19.6772085Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 781d5785-125f-4b8e-7e2c-08d9a464c160
x-ms-traffictypediagnostic: DM6PR12MB4041:
x-microsoft-antispam-prvs: <DM6PR12MB4041B488F2E471F660BD6B7B97939@DM6PR12MB4041.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+q/DNk2TuLDOPaL4atgdklzL11b1NXqCJuD5vhdTFqwibXSPHHEu2Jgq/Zt3mHG5ocAwcXxs72cc9MWAUWuDA2Nf+pBZ6Zt+WUiRx/1UO5U6zpD42T6Lm+bxnARfgCERAK+M68+wA7b7K99v7o3OBVu5AD4UqcGdoyzLsBpZq7uZxDy8SAC0BwGnEIjZAaARp/t3l6PXFL2cREWGosI/ui2f6eIiHEKaEXEVrXM2eJ0IAJW3MOOIYPiW9saZwq7deK+xhapxmmhn7KpYjfqQsGmqcMA7jQokxAsDJAPcjhqJx6oylJd5oI9jnQGGvOSQFVtHhWB3aUsNDCIyqpCiZ19tI/TdPk37AUIZO5ckODYsSpeNo2rkFWbv+8yXAWfzlwMSHgHoP8ixM/Dbo2JVsCu4txOo0IzGgJSDj8wdj101B5BnPGVO7nNSHbRFGHRAoz0zsxpH+c7f+jkBsaiNZkci+BcoAflkPc5zjGs+rhPPfAHxFJ3w5WQzFuwTXcobg7CXQqNNy9GU4AO3rXM9iSstlffkeKVqP38PIeq2XrVkzoL9BeURPgoA+2RItbF7rXhrTo6quTSItiu4d7RFXOmahau8kSBwmFhue6+rvLI4OB9mOOClD/N59lFqeQyQdgUdNSVjOxl/6pYt4rguAZYtW4nQOkEes+FPP1/eTN2vsDQfjicRhHcx0jzYfYUIFYC7RibIo8xDtMtDl6sSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(55016002)(38070700005)(2906002)(7696005)(53546011)(8936002)(5660300002)(52536014)(9686003)(4326008)(33656002)(508600001)(110136005)(316002)(186003)(26005)(86362001)(38100700002)(66476007)(83380400001)(64756008)(122000001)(66946007)(66556008)(91956017)(66446008)(76116006)(6506007)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+sXdf8UNupjceI0Wgv3szTK5qWeMM6T0xwT+NccxWru9/SWau9V90M6MKMTc?=
 =?us-ascii?Q?+hs3wXeJgp4Na3t4H3tZrcUGuwDcZA/KrcF6CHIMUAn/aY4bKF1jxppXpWOS?=
 =?us-ascii?Q?Tb2tgllhkA2dOucZNU8txd++yVYfsBlNHi87O2aD9RadTwyju1tafV58cono?=
 =?us-ascii?Q?3txkakkx9eJCJEL+ytBCemHVf7LgNrE1+pfSozfofdF5aNWYVuvfUi4n2Oak?=
 =?us-ascii?Q?W62HCYCJYsQeP3ZLpiKgV20uJywA4Y6UmlxtRht6s5hG6se1OV49KVzHPu6+?=
 =?us-ascii?Q?lsJihcrly77Zjs5kVGEbJ3xwjFokVVNtSHz9LqLJcjmkanoX+xs8wwjO1L/u?=
 =?us-ascii?Q?sc2iPFjYHcNonZSiI6bp0dNYC+215aSmMbQOAIEpZlGRnDIv9IU++iiz4LTL?=
 =?us-ascii?Q?SKlnSa6HInjGZa50P6ILhZOUbsVECXtb3y+gXGC4uOdX1CDNxPKvqN9OOKvU?=
 =?us-ascii?Q?HUIGUi5Cp4LyTvCWEiRtbZspch08zhOEzPCUneMSjvee+1KFi/BIOD4qxTdJ?=
 =?us-ascii?Q?h/BORNg6DeqJNrkLFPZOMnxTmPIVtJGjpTB9Zr1VVCLR28oC85RNlCqiVmBq?=
 =?us-ascii?Q?xP2xMeR2a0deLjzjPh5R5UPU0d/BWBGfY/lNCXNBKXFB0Yzueb4R4cJX/mDD?=
 =?us-ascii?Q?3jpuZke2ywO85OxQfkRKHfWUzsF8BzfRdSVm37gX2bYKYVz9lTprRA93aFbz?=
 =?us-ascii?Q?n6ZuSEhWmvSewTD/WeFa5+tSxLx/3/VUjK0GnYuoIJOlgS8hnwztU5dsLgOL?=
 =?us-ascii?Q?J4d2Dc2YBkDZtCnxRUpY4H2bQ3/c/zgKnYaAlR0rIkvxjuacUWDSB7JwH3sO?=
 =?us-ascii?Q?MiiPHQ4Slpuugvdr8mEhDQIun5VdCEcgatj4chxIwpNbnTdqEV1V8tVjS3OX?=
 =?us-ascii?Q?m0XroLNaKtwPYj/S/ER6EzThaUs5k+pB5t/aIpRshKS4ClYDWrW5UwecsJAk?=
 =?us-ascii?Q?IrDTsj+aFllwri6kzc//mA4c4o6cTcwVyCxRUWYUOszoMKhZlkZwFMeDa/EN?=
 =?us-ascii?Q?9uodDZFRhkgj/ijaF5aQDI7aY4bfblVBCg+aR1vxahq824mpeI2Gfq5zSmI7?=
 =?us-ascii?Q?ZiRSENrUCy8NWWZBN4b9xBHMlcfPwcoBvPJhdUOMszDjeqZaV9xb1AvL1lCj?=
 =?us-ascii?Q?hU0NBBZnGgdBGPy7qBiMz7uq9kgPj3/dZqZhA83NGdb15VBn/gD9Xkxi10tK?=
 =?us-ascii?Q?JygxBbkP4FxSS75vXvxDZrk3EC0E2PAUG79FmX/6bOwQ9/yexNrulb8Ikr+Q?=
 =?us-ascii?Q?pH0kJkNi7mxdVvBX26cMO9eD1QHNRO1Ue4IxqctiK7Nsof/xmGX3CjKABH50?=
 =?us-ascii?Q?nVJ/gPrxerk+f5QMPgajsFxT3e6u4fnnb6CGQFSqIvm4xhD4fq4R54UB1B7D?=
 =?us-ascii?Q?JpQnZXLXTmzr/GyEKni/3RYQaLz4uVUJh+3hgRjjVzXV34B2bqWkvtfSnaR/?=
 =?us-ascii?Q?jbcmsxQx/lyrGcwfNi4wRa6PHHDYcB1j7Q9/sg8rhf921QPURi3K2x0DbW5L?=
 =?us-ascii?Q?khXrquB171Vq+/olcw8/4Hh48Q9pVvrTDi1tGXQB2p12RlwLnk+D8V4FnOjk?=
 =?us-ascii?Q?BpzoqROIPfYekrR7/AJKafLhjnQoOpXLica5ruyY?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB39307C2E18445AA344F9930F97939DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781d5785-125f-4b8e-7e2c-08d9a464c160
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 16:11:29.5998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t72zkcrRPsBDYzUDLPYrhSv35MLVBOUbQ6J7TZFl8WcD70GkjYHnkmHZDz4mcdzD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB39307C2E18445AA344F9930F97939DM6PR12MB3930namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

>(... && !amdgpu_sriov_vf(adev))

This kind of closes the door for all versions. My thought was - having it i=
n the same function provides a logical grouping for how it's handled for di=
fferent cases - VF vs non-VF - for a particular IP version.

Thanks,
Lijo
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, November 10, 2021 9:27:22 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV

Am 2021-11-10 um 4:14 a.m. schrieb Lazar, Lijo:
>
>
> On 11/10/2021 8:00 AM, Felix Kuehling wrote:
>> Disable HDP register remapping on SRIOV and set rmmio_remap.reg_offset
>> to the fixed address of the VF register for hdp_v*_flush_hdp.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 4 +++-
>>   drivers/gpu/drm/amd/amdgpu/nv.c        | 8 +++++---
>>   drivers/gpu/drm/amd/amdgpu/soc15.c     | 8 +++++---
>>   7 files changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> index 4ecd2b5808ce..ee7cab37dfd5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> @@ -359,6 +359,10 @@ static void nbio_v2_3_init_registers(struct
>> amdgpu_device *adev)
>>         if (def !=3D data)
>>           WREG32_PCIE(smnPCIE_CONFIG_CNTL, data);
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0,
>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>
> Wouldn't it be better to do this assignment inside
> remap_hdp_registers()? Return with a comment saying no remap is done
> for VFs. That looks easier to manage per IP version.

I was considering that. I felt it was clearer not to have that hidden
side effect in remap_hdp_registers and to have the explicit condition
(... &&  !amdgpu_sriov_vf(adev)) around the remap_hdp_registers call in
soc15/nv_common_hw_init.

Regards,
  Felix


>
> Thanks,
> Lijo
>
>>   }
>>     #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT        0x00000000
>> // off by default, no gains over L1
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> index 0d2d629e2d6a..4bbacf1be25a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> @@ -276,6 +276,10 @@ static void nbio_v6_1_init_registers(struct
>> amdgpu_device *adev)
>>         if (def !=3D data)
>>           WREG32_PCIE(smnPCIE_CI_CNTL, data);
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0,
>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>   }
>>     static void nbio_v6_1_program_ltr(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>> index 3c00666a13e1..37a4039fdfc5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
>> @@ -273,7 +273,9 @@ const struct nbio_hdp_flush_reg
>> nbio_v7_0_hdp_flush_reg =3D {
>>     static void nbio_v7_0_init_registers(struct amdgpu_device *adev)
>>   {
>> -
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset =3D
>> +            SOC15_REG_OFFSET(NBIO, 0,
>> mmHDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>   }
>>     const struct amdgpu_nbio_funcs nbio_v7_0_funcs =3D {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> index 8f2a315e7c73..3444332ea110 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> @@ -371,6 +371,10 @@ static void nbio_v7_2_init_registers(struct
>> amdgpu_device *adev)
>>           if (def !=3D data)
>>               WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0,
>> regPCIE_CONFIG_CNTL), data);
>>       }
>> +
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0,
>> +            regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>   }
>>     const struct amdgpu_nbio_funcs nbio_v7_2_funcs =3D {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> index b8bd03d16dba..e96516d3fd45 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> @@ -362,7 +362,9 @@ const struct nbio_hdp_flush_reg
>> nbio_v7_4_hdp_flush_reg_ald =3D {
>>     static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
>>   {
>> -
>> +    if (amdgpu_sriov_vf(adev))
>> +        adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0,
>> +            mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
>>   }
>>     static void
>> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>> *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index febc903adf58..7088528079c6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -730,8 +730,10 @@ static int nv_common_early_init(void *handle)
>>   #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>   -    adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
>> -    adev->rmmio_remap.bus_addr =3D adev->rmmio_base +
>> MMIO_REG_HOLE_OFFSET;
>> +    if (!amdgpu_sriov_vf(adev)) {
>> +        adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
>> +        adev->rmmio_remap.bus_addr =3D adev->rmmio_base +
>> MMIO_REG_HOLE_OFFSET;
>> +    }
>>       adev->smc_rreg =3D NULL;
>>       adev->smc_wreg =3D NULL;
>>       adev->pcie_rreg =3D &nv_pcie_rreg;
>> @@ -1031,7 +1033,7 @@ static int nv_common_hw_init(void *handle)
>>        * for the purpose of expose those registers
>>        * to process space
>>        */
>> -    if (adev->nbio.funcs->remap_hdp_registers)
>> +    if (adev->nbio.funcs->remap_hdp_registers &&
>> !amdgpu_sriov_vf(adev))
>>           adev->nbio.funcs->remap_hdp_registers(adev);
>>       /* enable the doorbell aperture */
>>       nv_enable_doorbell_aperture(adev, true);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 0c316a2d42ed..de9b55383e9f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -971,8 +971,10 @@ static int soc15_common_early_init(void *handle)
>>   #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
>>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>>   -    adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
>> -    adev->rmmio_remap.bus_addr =3D adev->rmmio_base +
>> MMIO_REG_HOLE_OFFSET;
>> +    if (!amdgpu_sriov_vf(adev)) {
>> +        adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
>> +        adev->rmmio_remap.bus_addr =3D adev->rmmio_base +
>> MMIO_REG_HOLE_OFFSET;
>> +    }
>>       adev->smc_rreg =3D NULL;
>>       adev->smc_wreg =3D NULL;
>>       adev->pcie_rreg =3D &soc15_pcie_rreg;
>> @@ -1285,7 +1287,7 @@ static int soc15_common_hw_init(void *handle)
>>        * for the purpose of expose those registers
>>        * to process space
>>        */
>> -    if (adev->nbio.funcs->remap_hdp_registers)
>> +    if (adev->nbio.funcs->remap_hdp_registers &&
>> !amdgpu_sriov_vf(adev))
>>           adev->nbio.funcs->remap_hdp_registers(adev);
>>         /* enable the doorbell aperture */
>>

--_000_DM6PR12MB39307C2E18445AA344F9930F97939DM6PR12MB3930namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
&gt;<span style=3D"font-family: -apple-system, HelveticaNeue; font-size: 14=
.6667px; display: inline !important;">(... &amp;&amp; !amdgpu_sriov_vf(adev=
))</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-family: -apple-system, HelveticaNeue; font-size: 14.666=
7px; display: inline !important;"><br>
</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-family: -apple-system, HelveticaNeue; font-size: 14.666=
7px; display: inline !important;">This kind of closes the door for all vers=
ions. My thought was - having it in the same function provides a logical gr=
ouping for how it's handled for different
 cases - VF vs non-VF - for a particular IP version.</span></div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 10, 2021 9:27:22 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2 1/1] drm/amdgpu: Fix MMIO HDP flush on SRIOV<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 2021-11-10 um 4:14 a.m. schrieb Lazar, Lijo:<br=
>
&gt;<br>
&gt;<br>
&gt; On 11/10/2021 8:00 AM, Felix Kuehling wrote:<br>
&gt;&gt; Disable HDP register remapping on SRIOV and set rmmio_remap.reg_of=
fset<br>
&gt;&gt; to the fixed address of the VF register for hdp_v*_flush_hdp.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 4 ++++<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 4 ++++<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c | 4 +++-<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 4 ++++<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 4 +++-<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; | 8 +++++---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp; =
| 8 +++++---<br>
&gt;&gt; &nbsp; 7 files changed, 28 insertions(+), 8 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
&gt;&gt; index 4ecd2b5808ce..ee7cab37dfd5 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
&gt;&gt; @@ -359,6 +359,10 @@ static void nbio_v2_3_init_registers(struct<b=
r>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_PCIE=
(smnPCIE_CONFIG_CNTL, data);<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.r=
eg_offset =3D SOC15_REG_OFFSET(NBIO, 0,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) &lt;&lt; 2;<br>
&gt;<br>
&gt; Wouldn't it be better to do this assignment inside<br>
&gt; remap_hdp_registers()? Return with a comment saying no remap is done<b=
r>
&gt; for VFs. That looks easier to manage per IP version.<br>
<br>
I was considering that. I felt it was clearer not to have that hidden<br>
side effect in remap_hdp_registers and to have the explicit condition<br>
(... &amp;&amp;&nbsp; !amdgpu_sriov_vf(adev)) around the remap_hdp_register=
s call in<br>
soc15/nv_common_hw_init.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000<br>
&gt;&gt; // off by default, no gains over L1<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
&gt;&gt; index 0d2d629e2d6a..4bbacf1be25a 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
&gt;&gt; @@ -276,6 +276,10 @@ static void nbio_v6_1_init_registers(struct<b=
r>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_PCIE=
(smnPCIE_CI_CNTL, data);<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.r=
eg_offset =3D SOC15_REG_OFFSET(NBIO, 0,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) &lt;&lt; 2;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; static void nbio_v6_1_program_ltr(struct amdgpu_devi=
ce *adev)<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
&gt;&gt; index 3c00666a13e1..37a4039fdfc5 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
&gt;&gt; @@ -273,7 +273,9 @@ const struct nbio_hdp_flush_reg<br>
&gt;&gt; nbio_v7_0_hdp_flush_reg =3D {<br>
&gt;&gt; &nbsp; &nbsp; static void nbio_v7_0_init_registers(struct amdgpu_d=
evice *adev)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.r=
eg_offset =3D<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; SOC15_REG_OFFSET(NBIO, 0,<br>
&gt;&gt; mmHDP_MEM_COHERENCY_FLUSH_CNTL) &lt;&lt; 2;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; const struct amdgpu_nbio_funcs nbio_v7_0_funcs =3D {=
<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
&gt;&gt; index 8f2a315e7c73..3444332ea110 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
&gt;&gt; @@ -371,6 +371,10 @@ static void nbio_v7_2_init_registers(struct<b=
r>
&gt;&gt; amdgpu_device *adev)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=
=3D data)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0,<br>
&gt;&gt; regPCIE_CONFIG_CNTL), data);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.r=
eg_offset =3D SOC15_REG_OFFSET(NBIO, 0,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) &lt;&lt; 2;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; const struct amdgpu_nbio_funcs nbio_v7_2_funcs =3D {=
<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&gt;&gt; index b8bd03d16dba..e96516d3fd45 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&gt;&gt; @@ -362,7 +362,9 @@ const struct nbio_hdp_flush_reg<br>
&gt;&gt; nbio_v7_4_hdp_flush_reg_ald =3D {<br>
&gt;&gt; &nbsp; &nbsp; static void nbio_v7_4_init_registers(struct amdgpu_d=
evice *adev)<br>
&gt;&gt; &nbsp; {<br>
&gt;&gt; -<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.r=
eg_offset =3D SOC15_REG_OFFSET(NBIO, 0,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) &lt;&lt; 2;<br>
&gt;&gt; &nbsp; }<br>
&gt;&gt; &nbsp; &nbsp; static void<br>
&gt;&gt; nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_devi=
ce<br>
&gt;&gt; *adev)<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt;&gt; index febc903adf58..7088528079c6 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt;&gt; @@ -730,8 +730,10 @@ static int nv_common_early_init(void *handle)=
<br>
&gt;&gt; &nbsp; #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.reg_offset =3D MMI=
O_REG_HOLE_OFFSET;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.bus_addr =3D adev-&gt;rmm=
io_base +<br>
&gt;&gt; MMIO_REG_HOLE_OFFSET;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.r=
eg_offset =3D MMIO_REG_HOLE_OFFSET;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.b=
us_addr =3D adev-&gt;rmmio_base +<br>
&gt;&gt; MMIO_REG_HOLE_OFFSET;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;smc_rreg =3D NULL;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;smc_wreg =3D NULL;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_rreg =3D &amp;nv_pcie=
_rreg;<br>
&gt;&gt; @@ -1031,7 +1033,7 @@ static int nv_common_hw_init(void *handle)<b=
r>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for the purpose of expose t=
hose registers<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to process space<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs-&gt;remap_hdp_register=
s)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs-&gt;remap_hdp_register=
s &amp;&amp;<br>
&gt;&gt; !amdgpu_sriov_vf(adev))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nb=
io.funcs-&gt;remap_hdp_registers(adev);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the doorbell aperture */<=
br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nv_enable_doorbell_aperture(adev, t=
rue);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt;&gt; index 0c316a2d42ed..de9b55383e9f 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt;&gt; @@ -971,8 +971,10 @@ static int soc15_common_early_init(void *hand=
le)<br>
&gt;&gt; &nbsp; #define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (str=
uct amdgpu_device *)handle;<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.reg_offset =3D MMI=
O_REG_HOLE_OFFSET;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.bus_addr =3D adev-&gt;rmm=
io_base +<br>
&gt;&gt; MMIO_REG_HOLE_OFFSET;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.r=
eg_offset =3D MMIO_REG_HOLE_OFFSET;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.b=
us_addr =3D adev-&gt;rmmio_base +<br>
&gt;&gt; MMIO_REG_HOLE_OFFSET;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;smc_rreg =3D NULL;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;smc_wreg =3D NULL;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pcie_rreg =3D &amp;soc15_p=
cie_rreg;<br>
&gt;&gt; @@ -1285,7 +1287,7 @@ static int soc15_common_hw_init(void *handle=
)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for the purpose of expose t=
hose registers<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to process space<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs-&gt;remap_hdp_register=
s)<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs-&gt;remap_hdp_register=
s &amp;&amp;<br>
&gt;&gt; !amdgpu_sriov_vf(adev))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nb=
io.funcs-&gt;remap_hdp_registers(adev);<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the doorbell apert=
ure */<br>
&gt;&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB39307C2E18445AA344F9930F97939DM6PR12MB3930namp_--
