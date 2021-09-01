Return-Path: <SRS0=BBbY=NX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A52C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 16:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBF661057
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Sep 2021 16:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BBF661057
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD31889862;
	Wed,  1 Sep 2021 16:30:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E5389862
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Sep 2021 16:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmhl5nTnwpXwSg4Vqr/C4sy+wiDqEmEo6CP8fF+obidmrpR7RkwplF3Gd86ES1e/dXIhw1Ee5JleFqnQK6/CzL6N/AiVyLk9jItJlw824NZiFK61mg64nlJiWQBBVUfHoA0EONLuPdYHcvCw6sxKGoZt/jwGXrIe9WZfS89S6z6kyorl63QumP++rxpoo+Vc+Bfj7eYMpYmKXnPE9N9PkWaai5zwK04ttLJ3J05U/O9u9si/sdNq5RopG8G43d6NzoQn45BAdoS0sPRY7zEy8ELMEiIQ3ohjmUNmmxYZOTh+av6DI6r/4YKiaC06jSax/G+J1VDtMZJM4Aa+AC5VBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo7uhvwaR4HLE0R0R4S0kPuzU1HfLAiCtYMSuB0qwnQ=;
 b=UwPr3rgmxM3MpHMednMxjZyr5zkjFMcrZeG+yvqDJocwjovm4khcIw2AVb8DTyxGuiFcPzscqyxK7iEVkZZObvhxF+i5iEHgDczGvpu0HTzKQRqantgUHACGxoRqFrWORr8QbmXsd0ln8Tcue9fUrf/dc2hZSvkQlXiO4ncqus6VGZR1B/ByeKY9OXMhO13gLhVqPi/ZNTRfcWJfh/qNZNpJ5hyKXv78S7UDM2AHCtdMtJc6t6F6fOon2mo48jN7P2e8gHeh/XbjWbiEBvYzqwNl00KD8zGKvbJiriBzmiizg+FubCvZrbUNmBWCz15om1UwHPk6ZaIj6yd/wHL6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo7uhvwaR4HLE0R0R4S0kPuzU1HfLAiCtYMSuB0qwnQ=;
 b=dbSfs0dm2IDPqY5y+volvX7qzB9WGjS7hRXR4IWHNdpfDHvXq666OHSgST93EorXebq2T+BVm8BR4ABHm0t8vhTY9iTzmdfoqeAKrbdbOh55TlkZbTVLa9nBE1fPryBP1NDizKSa4GuvB924+yV8EVS+d+1UJySEVGWNYqObtbs=
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Wed, 1 Sep
 2021 16:30:39 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Wed, 1 Sep 2021
 16:30:39 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
Thread-Topic: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
Thread-Index: AQHXnrMlmbfje09yFUujWuXGdAZ8MquPBO0AgABAVACAABj/Tg==
Date: Wed, 1 Sep 2021 16:30:39 +0000
Message-ID: <BL1PR12MB5349845ADA6A373FBA45609197CD9@BL1PR12MB5349.namprd12.prod.outlook.com>
References: <20210831215632.195506-1-Felix.Kuehling@amd.com>
 <239a99fd-835f-cbbc-152f-afae6861bf60@amd.com>
 <2c63bf17-2404-8c68-fa63-b14d94de3e90@amd.com>
In-Reply-To: <2c63bf17-2404-8c68-fa63-b14d94de3e90@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-01T16:29:33.4259196Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bbbcf97-32fb-4f3f-3ac0-08d96d65d5b3
x-ms-traffictypediagnostic: BL1PR12MB5157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB515791A7BC29C4DFC42DCB2E97CD9@BL1PR12MB5157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dA5HQYUy/rqiiwjCuQIC1r9vK0gJUcXD77a4jKYpZst5cWcWpcQnOZYWrWSqa8QW71XfTEL1Othf8okfOqzDiySwSI3ZSgE3YdHBwmDjYxlL+Py4e4dm+F8+zEcxW6j7LKjAmksuIVvow6UAaM4J1GlDDjkdJ9mi/kKXO2fAv4/1dH5hZbA25n/TJu5t8q7M8SdU//z/0+47YKY67EkgLXolsG5IMSVWXNX6WKiFqAxqWITrf10c9Znk/+j0tNQ9I0l01s1kYDzqXIXOAMtvQAKSwpZZLjx/UwV3rryZGwDiGe0u+1Bf6pAepOaHtYRUvMPfKGnc83C+O5k6IPGdCRxrHIKvTlHnSk1guemapDoFpEixLH97M1Ppiq5carQ3E8ql6fQMP4ZYPOH6/3MzLrtmwFBRs8JPgZ+2eg9SKZPFcv6ZREWQqNmweewOdgopbgEVXJGgUSEHxTpOWgKxZeGN8J5sIEj8dz9XDEgcoN8zOkNJRedm3ow5TZgcEUeNxmAYs1mCTXM5jCPvJYtnY3BSEQw/AUfjrV0QPEvGuIVF4/qrIQj3Re543JgTSlXi6vkoEwXoHF/pXylyF9MnkxIcKV0WK5R+ra+ZblVwiJKcuV1ikw1EZfw+IbvNH80KwcndoBBD2dCRriD0iWH/p2tcp9mpvIaDGktwwTrj7DC9D3OGami9XbEVrXCtczKqUx9kEBjEGEkTXuWQBhtAPg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(38100700002)(186003)(53546011)(8676002)(26005)(316002)(6506007)(122000001)(38070700005)(478600001)(7696005)(66946007)(66446008)(5660300002)(64756008)(9686003)(66476007)(33656002)(110136005)(86362001)(71200400001)(83380400001)(66556008)(52536014)(55016002)(2906002)(76116006)(91956017)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SiFzkNce1zZoHGLQhGJLdRp3wR/3f6ULGfO4peC5sEyXxxqVFtwLPu3g2NOw?=
 =?us-ascii?Q?SqzqvGgG20k7/VToQTna6S2odH5iuXS7Od9R39+DD1kPmeAppsKsdFV/I5gU?=
 =?us-ascii?Q?gAQeGfdCRSWj1I0zoUBWBtBQk2Vv3snDZ1f7ACD9F7A1kZ3sc10qiJL7tbhS?=
 =?us-ascii?Q?g3tAwnXWy4dHCvT7k6GhjzbKwjZg8RGfWVRCP5c4umbVaTCv4+vuLsBNQVli?=
 =?us-ascii?Q?jB2WS5f7rz1fgBqVrjp3m8U9NSmNPziQOMVLq6VhIN09rBScFgW9OqcV6izg?=
 =?us-ascii?Q?2AyyuMo4LSpH781eAiwOEIfLz+bCoGUGDvdht84/k2ch+nnnI0eHztHgNi/u?=
 =?us-ascii?Q?+NFF5/SmPxHqqi34ZB2Ps493jhZ2e/EkIS1hYWL+2nq19i8CtMmVs45dICLE?=
 =?us-ascii?Q?IF0LdNOb7zPHwL42Dq9goc05JaUJHx88xWrYIr9MNz/AR8EguKNtsptxBeB6?=
 =?us-ascii?Q?qAuGEo/sZcnr59GXAf6seXeYlW5hmuTMWOPCrb72b5IqJ3KwQgzQNd393WUp?=
 =?us-ascii?Q?XPCosjbDuEpJAMZ36fnUtJegCj75hAFcpmOdXF5gWOXorVZ7B010X0JATkde?=
 =?us-ascii?Q?CEZh+/LbJgDX+gU6iC/To+KuGFMvcroAqnV4zLVOYr7o1US+/kWJDrh5Q9aW?=
 =?us-ascii?Q?bPGBLfhxoQRjCqzk6TobWG8Ho0s61ZCT0H0+bFvG+QTSJqoPyMYRX1VKfHFj?=
 =?us-ascii?Q?mURCeL0UvNHUmVlfverBecjWne6RLHDB3ddE2+CdfAbAhLscc3qmMKtsZpSg?=
 =?us-ascii?Q?G6VoOVaVR9W4Z8g/Fw7Mm4L5R60yjs6LsQNPbn2vKckJ5pafarJHXEStRgYA?=
 =?us-ascii?Q?/P6pJT/CgUeYw69iV9SKTh7CN0+GccouRB+woJQ6vhaCu+iVJX4UD2hKFf1p?=
 =?us-ascii?Q?FfFOgKuflako9LvTvgZWo2G11u1nXwIUNCgMRQp8kbxrOXbU3sJreM9+s4As?=
 =?us-ascii?Q?PHH+ofVTKUYB/1r7AzHcmcqRKAmx/r+vJUHHPaWTsjkWs0UfkYi+7nmhFEVB?=
 =?us-ascii?Q?IiO6UwZZzjmswyupz8W9Pg/lo0SYcyKgATNFY6VZevQ2Sx0g3Z7uJH1bMiev?=
 =?us-ascii?Q?NRf1aunIjaYxZHgTVtnteYEGb33EQRExMaie6bBm2Xol5UsPO8LDB2vetGwQ?=
 =?us-ascii?Q?JmR9ZLeZXYPhNgsLFJJ6FVU+PqRMt8dtVjnw0zz9bI+OfLjr8T07L14R2g2a?=
 =?us-ascii?Q?YMHke0U8zbcjoTEF1HpSB7hU9ldoS/e9gfe5JZHCKXY0mNsFW2l0a42WQDx1?=
 =?us-ascii?Q?obrvi92FFr7QfcPrB2w+ss6yqVz/aZxGSXMDc3+iekdCcWZNGNDNEC8kGSyV?=
 =?us-ascii?Q?Tu+Yjz0DZWI+4zcg1dLyz0nem0vWVorIbu6Ni/Evi5EXWg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5349845ADA6A373FBA45609197CD9BL1PR12MB5349namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbbcf97-32fb-4f3f-3ac0-08d96d65d5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 16:30:39.2520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oglGGD3ldLWwtOK8q03fDsoyUsUjJWN958zS9o/Nu8zj1lFUUKncJBoor38Og3d6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
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

--_000_BL1PR12MB5349845ADA6A373FBA45609197CD9BL1PR12MB5349namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

What I wanted to ask was -

Whether user mode application relies only on link properties alone to assum=
e atomic ops are supported? If they check only link properties and if the f=
irmware doesn't work fine, should it be still marked as supported?

Basically, what is the purpose of exposing atomic capability in link proper=
ties and whether that can be utilised by upper mode applications just based=
 on PCIe atomics support?

Thanks,
Lijo
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, September 1, 2021 8:24:56 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version dep=
endent

Am 2021-09-01 um 7:04 a.m. schrieb Lazar, Lijo:
>
>
> On 9/1/2021 3:26 AM, Felix Kuehling wrote:
>> On some GPUs the PCIe atomic requirement for KFD depends on the MEC
>> firmware version. Add a firmware version check for this. The minimum
>> firmware version that works without atomics can be updated in the
>> device_info structure for each GPU type.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 16a57b70cc1a..655ee5733229 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>>       struct kfd_dev *kfd;
>>       const struct kfd_device_info *device_info;
>>       const struct kfd2kgd_calls *f2g;
>> +    uint32_t fw_version;
>>         if (asic_type >=3D sizeof(kfd_supported_devices) / (sizeof(void
>> *) * 2)
>>           || asic_type >=3D sizeof(kfd2kgd_funcs) / sizeof(void *)) {
>> @@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>>        * supported.
>>        */
>>       kfd->pci_atomic_requested =3D
>> amdgpu_amdkfd_have_atomics_support(kgd);
>
> Should the check be grouped inside amdgpu_amdkfd_have_atomics_support?
>
> This flag is used for setting some link properties. If there is HW
> support but comes with incompatible firmware, should the link be still
> marked as atomic?

Our GPU HW always supports PCIe atomics (it's part of the PCIe 3 spec).
But some mainboards with older PCIe chipsets do not. Sometimes even
different ports on the same mainboard differ in their PCIe version and
atomic support.

amdgpu_device_init always tries to enable atomics on the root port an
all the bridges leading to the GPU by calling
pci_enable_atomic_ops_to_root. The result is saved in
adev->have_atomics_support, which is returned to KFD by
amdgpu_amdkfd_have_atomics_support.

The firmware change here does not affect whether atomics are
_supported_. It changes whether atomics are _required_ for the basic
operation of AQL user mode queues. The coming firmware update will
remove that requirement, which allows us to enable KFD for these GPUs+FW
on systems without PCIe atomics.

Enabling PCIe atomics with the updated FW is still beneficial because
shader programs can use a subset of atomic instructions for accessing
system memory atomically on supported systems.

Regards,
  Felix


>
> Thanks,
> Lijo
>
>> -    if (device_info->needs_pci_atomics &&
>> -        !kfd->pci_atomic_requested) {
>> +    fw_version =3D amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1);
>> +    if (!kfd->pci_atomic_requested &&
>> +        device_info->needs_pci_atomics &&
>> +        (!device_info->no_atomic_fw_version ||
>> +          amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1) <
>> +            device_info->no_atomic_fw_version)) {
>>           dev_info(kfd_device,
>>                "skipped device %x:%x, PCI rejects atomics\n",
>>                pdev->vendor, pdev->device);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index ab83b0de6b22..6d8f9bb2d905 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -207,6 +207,7 @@ struct kfd_device_info {
>>       bool supports_cwsr;
>>       bool needs_iommu_device;
>>       bool needs_pci_atomics;
>> +    uint32_t no_atomic_fw_version;
>>       unsigned int num_sdma_engines;
>>       unsigned int num_xgmi_sdma_engines;
>>       unsigned int num_sdma_queues_per_engine;
>>

--_000_BL1PR12MB5349845ADA6A373FBA45609197CD9BL1PR12MB5349namp_
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
What I wanted to ask was -</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;"><br>
</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;">Whether user mode application relies only =
on link properties alone to assume atomic ops are supported? If they check =
only link properties and if the firmware doesn't work fine, should it be st=
ill marked as supported?</span><br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;"><br>
</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;">Basically, what is the purpose of exposing=
 atomic capability in link properties and whether that can be utilised by u=
pper mode applications just based on PCIe atomics support?</span></div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 1, 2021 8:24:56 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-vers=
ion dependent</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 2021-09-01 um 7:04 a.m. schrieb Lazar, Lijo:<br=
>
&gt;<br>
&gt;<br>
&gt; On 9/1/2021 3:26 AM, Felix Kuehling wrote:<br>
&gt;&gt; On some GPUs the PCIe atomic requirement for KFD depends on the ME=
C<br>
&gt;&gt; firmware version. Add a firmware version check for this. The minim=
um<br>
&gt;&gt; firmware version that works without atomics can be updated in the<=
br>
&gt;&gt; device_info structure for each GPU type.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp; | 1 +<br>
&gt;&gt; &nbsp; 2 files changed, 8 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt;&gt; index 16a57b70cc1a..655ee5733229 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt;&gt; @@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *=
kgd,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd_device_info *devic=
e_info;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd2kgd_calls *f2g;<br=
>
&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t fw_version;<br>
&gt;&gt; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type &gt;=3D sizeof=
(kfd_supported_devices) / (sizeof(void<br>
&gt;&gt; *) * 2)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || asic_typ=
e &gt;=3D sizeof(kfd2kgd_funcs) / sizeof(void *)) {<br>
&gt;&gt; @@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev =
*kgd,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * supported.<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;pci_atomic_requested =3D<br=
>
&gt;&gt; amdgpu_amdkfd_have_atomics_support(kgd);<br>
&gt;<br>
&gt; Should the check be grouped inside amdgpu_amdkfd_have_atomics_support?=
<br>
&gt;<br>
&gt; This flag is used for setting some link properties. If there is HW<br>
&gt; support but comes with incompatible firmware, should the link be still=
<br>
&gt; marked as atomic?<br>
<br>
Our GPU HW always supports PCIe atomics (it's part of the PCIe 3 spec).<br>
But some mainboards with older PCIe chipsets do not. Sometimes even<br>
different ports on the same mainboard differ in their PCIe version and<br>
atomic support.<br>
<br>
amdgpu_device_init always tries to enable atomics on the root port an<br>
all the bridges leading to the GPU by calling<br>
pci_enable_atomic_ops_to_root. The result is saved in<br>
adev-&gt;have_atomics_support, which is returned to KFD by<br>
amdgpu_amdkfd_have_atomics_support.<br>
<br>
The firmware change here does not affect whether atomics are<br>
_supported_. It changes whether atomics are _required_ for the basic<br>
operation of AQL user mode queues. The coming firmware update will<br>
remove that requirement, which allows us to enable KFD for these GPUs+FW<br=
>
on systems without PCIe atomics.<br>
<br>
Enabling PCIe atomics with the updated FW is still beneficial because<br>
shader programs can use a subset of atomic instructions for accessing<br>
system memory atomically on supported systems.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; if (device_info-&gt;needs_pci_atomics &amp;&am=
p;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !kfd-&gt;pci_atomic_re=
quested) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; fw_version =3D amdgpu_amdkfd_get_fw_version(kg=
d, KGD_ENGINE_MEC1);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!kfd-&gt;pci_atomic_requested &amp;&amp;<b=
r>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_info-&gt;needs_=
pci_atomics &amp;&amp;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!device_info-&gt;no_a=
tomic_fw_version ||<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amd=
kfd_get_fw_version(kgd, KGD_ENGINE_MEC1) &lt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; device_info-&gt;no_atomic_fw_version)) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(kf=
d_device,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &quot;skipped device %x:%x, PCI rejects atomics\n&quot;,=
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; pdev-&gt;vendor, pdev-&gt;device);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt;&gt; index ab83b0de6b22..6d8f9bb2d905 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt;&gt; @@ -207,6 +207,7 @@ struct kfd_device_info {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool supports_cwsr;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool needs_iommu_device;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool needs_pci_atomics;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; uint32_t no_atomic_fw_version;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_sdma_engines;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_xgmi_sdma_engines;=
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_sdma_queues_per_en=
gine;<br>
&gt;&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5349845ADA6A373FBA45609197CD9BL1PR12MB5349namp_--
