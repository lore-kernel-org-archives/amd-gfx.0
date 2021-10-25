Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4C3C4321E
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 15:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898106103C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 15:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 898106103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B466E0CA;
	Mon, 25 Oct 2021 15:16:03 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66D486E0CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 15:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9q4C5dBxGBuubWxDgt64H/dS96nRNBIijz8eXEyWcnz7AtlnHbw254umlBDnV8I0g3OqBRJkef20LCSFZYS1E3XlZfXl+ot2uVdYrwsvEGW3K27+GZ580N3bRZeCqXAqLuW0ng/1RpF0T8dUBVAOuRfZH9rbHWKt/MeSIIL7AQ0RuOJCuUS2mw5VI91VNT/EuW2JhWAigit+uK1LHu+qkLCDNjmYtyEg8SQwePSdIGF4rMr7C4xjpUEXoVrx9WIUB+MyXVr2t2m2JB+tC2KsZlM9k0gZMinbtv4+kXXvOlugaEVvZo6YsmfKpLOEiESmgXMHMk6xfxhHFYNXGusAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAj140dOqTyn1WdB5V1d2Wy564D2ESHuE9wzUnVjVts=;
 b=b+/ZjW2QSqpmpNPkY5o1WtoZJQpHiuHT0KbZZkMWk9g824RZPoIhS7wwLXX3qE03RBBicJUhvfkLl5vxEPKU4e89Xmye6jfZiPyYr2PS5EUVjO5bec48OXeHT37Ji7HeIPHacsk2Re9znWglx5RFfi0e5cS8vHLTCQcDeIEEOac+bhZMKyLj1VMEO+MhSNHPLgFtu5NMhRnKmwGPy31aKt0nyKq5TkbxDRGjEcRqmrH8jC0YmiXbf6gwBYsERIqbkoOal5Ei7s5oKhzA2ESDvLiSonyTGJ9Vh4WFtzBJjDwUgwwuJCmuvlCH9PFyPaexjmc0pCOfkGAaPkOob2/0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAj140dOqTyn1WdB5V1d2Wy564D2ESHuE9wzUnVjVts=;
 b=mCRcApevgxcYrXH1IPVLH7KxRQ7VKFSaLjgWZEWlRsWJyWkZhIfZouGjGz9DCuoJxN0lywJY/XBzoiKaNmQSbCRlWNRVq9IbMwfnOQ/HAP+MOywScA75/2pDQsOobDCYgR58ZaTE6yDYNyx63rMSsbjZEJp/sfDCNi9BHhXf4Eg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 15:15:58 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 15:15:58 +0000
Message-ID: <27b8936d-ba79-cc13-7768-692565bedc2f@amd.com>
Date: Mon, 25 Oct 2021 20:45:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: amdgpu "Fatal error during GPU init"; Ryzen 5600G integrated GPU
 + kernel 5.14.13
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, PGNet Dev <pgnet.dev@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <b4adea1b-9a21-75d2-7ee7-25d4f28ef6f8@gmail.com>
 <2303555f-42cd-180c-7a67-1d104bceea7d@gmail.com>
 <CADnq5_PsKDreYH0aNNzfR_TbfMMsfVK=-hCCB0ThZ0PzcLPCpw@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_PsKDreYH0aNNzfR_TbfMMsfVK=-hCCB0ThZ0PzcLPCpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::14) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 15:15:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16e3caa9-5496-4e81-45b9-08d997ca58e4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38333BA9AE269F65C427EDE497839@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4btWcc4yHhIEDWrU9LbR5t3CPPZjcWVHQcnFH5wFvlfw0pIJwQzKuDNQf+PfHWxG50TLw78XxsR1+8NIl8q0Vxiv2sqPgCGWkr/Ww3/gGe1C0tEfW1NHD0/d6hYScCffXcSdLba3sdpb6R/sxa/ZnuTVnB2U1I65tW1rwGAYkBvTbPBB3Q/1tsMTVZAke78oUEZut0x0yd4whsoR7PYdij1f3twBCzEMC1XtzHgg0EJWCpHwI55x6K6TyrqXC86y/EliU/7Zw1FUwjmePHcClYDkD73dLAQYEHvWV0qu7tHJyR/fwWWh+f00BPvmNPATOg6BiyMMqB4PgruG9fk3bEPXOkuZ8CCINekxeGeT5CXhw2bVSKr1Zv50tKXTai3QT+jmrGl/MWUBoSuvD8lKLf6negyDFyJDDIthLqslyOEHZjyWReoRh1D/tog/lCOBT8ByNsSDWTebn3kWXkdMsxgHbxhDSgkytVjhUZDiawwu19MLOU2acFhrAdpgQiYI9/o1rUUsURP4VVoNUzgIKiIauxSil96/cE3Tb+CHK25g//yTHdM3HIaTK43VYw4e3u2ctM+UYUuecifaOL8PNRfxIsPDbn9CyAzwWL4Ut6giPass5XBAhOyGgSSSliXIHlQeVN9d70butdL2qhUS898NtICBIFIeZ9+eFYPKHKKGfz/x8RX8vlKTDZ6R0UlHB8EnyQupvNZ1Nh/3GyoMFoO3Dy2ZaQ7stukjUzF/wtP+mZzlllXFN0VMKQLSsAc6TnDRlDXlElwSJaxo9WOyFGvYqJsFjx/RY21GL9DrBxF4LU5KeZSKUhPeiNf2t/Ug
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(4326008)(38100700002)(31686004)(66476007)(6486002)(8676002)(83380400001)(66556008)(2906002)(8936002)(5660300002)(86362001)(31696002)(316002)(53546011)(36756003)(16576012)(508600001)(45080400002)(966005)(26005)(186003)(956004)(2616005)(110136005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUhaWlpBUG4rNUlkZW9lNkc0SVJ2MW5aa1NIbGtqTnBvYW5IOWxoc3dUVXdX?=
 =?utf-8?B?S1BGcndKQUdpQWJIaTRyek44eHFRbHg5L3VGWVRDNW5CbVBEb1VHcElDb3pO?=
 =?utf-8?B?enpCb2JWYjZhc3c3UnZDcnlvQzEzZFdOOHJxVmRPblA3TC93eUt0RTRLcFhO?=
 =?utf-8?B?NUUyK1BucFFTVWZmbHM2T1FHd1c3WVJpSHFVb0h0UVBTUDV6WXFQbVQ1b3ZV?=
 =?utf-8?B?dDMzVDc0VW53VWRDQUcvanJTcTJPYjRCZUZBR1BBWXRrUW1ISi9hYWpQTEND?=
 =?utf-8?B?UG9LTTZ2cm5mWEhsQ3Y1QnNuNkU0dFk5eVhjWDNDbWR2R01Dc05EMUYrOUNX?=
 =?utf-8?B?enpVbStDejNpbEFPVHkxajdBLzNaUXZvM1V0b1UybG1XRS9rbkg0RDBaeEJi?=
 =?utf-8?B?UmU4dU5aeW8wazF5aGc4d0lDdS9nUnJwdFVLdVRXT2h3NFVJZzVjZXZVUE1l?=
 =?utf-8?B?eTMxL0xUd2dUbTczZ0U0WmxKZEpPaXFOOUc2NnhDdk9jOGFEQlBLUHVZWXhR?=
 =?utf-8?B?cXZsd2ZoamwwT2o1bHE3N0w4WU9uRmxrVWJuM1JNV0p6dG9wYWFJaHpYTTFl?=
 =?utf-8?B?UDVRd1hvQlpiR0F0MWhobnZKb3g4V0FpNUJvakpZQ1ozZUk0NzJ2d0JIL3Zo?=
 =?utf-8?B?Zy9abkxhWG95ZkhBOGdtQy9XcU12Zld1OW1HdzNpY1JwbDVwa2JFVlVFdk8x?=
 =?utf-8?B?dWIwNUxXWGhwTGd5YU9BTzJBOFBqZVZqR2txM01yT2hzaDE5QlRPMnpFcHBT?=
 =?utf-8?B?WTF2ZlJCNFVIY3ZCakxMMWlCaWhRei9ablgzTUxlT29ONHc3Q1lXYk9hOTRs?=
 =?utf-8?B?UmJKTEwrVklwSlpYTkY4cjdTdTVzZ1pVQmRweDhTZDdIejF5YmdlalUxVk40?=
 =?utf-8?B?b3kxYlU1dlhtaENmMWJZRTFEQjBvTGNndk4xUnREbnhxK1MvcWFqbmRTaFZy?=
 =?utf-8?B?amZxckhSM1ZxS01kQnA0eVBoTEJaTUFEcHBUNWtlVXZFaVcxeG5IbWEyWWpO?=
 =?utf-8?B?WFV6RFFKYTQ5ZjhJSlhJWXg1WTBEZkZzcFN2MUFXMHp3eEd0ejBiSUlmNDIv?=
 =?utf-8?B?TG5oa0FPdjlBSnJwQXZvQVQvTHd3OEpEUDZ2V0k3SDRtdytvdUYyRGdXS2l5?=
 =?utf-8?B?NW5kVFc4R2dlRmNuL3NvcEg2bFVXV0sybmdDaWp5OG1yalFGdDFBVmtkS29P?=
 =?utf-8?B?cmtLelBRUW9BVG1BYXpjS3gxWktvdktnNjdkNHA2YTVOa1VDR0Z6ZlMxOC9Z?=
 =?utf-8?B?Z2FMQk4vTFc0ZE5EREpFaVJvM0JDTnFlOVlDVUN3VTdNWWxwSVA4TFpQQTM1?=
 =?utf-8?B?bkZkekZsWEZOQzNmWXpxbUs3UXMzY2xoY3pCa28xOTBlM1pIUWY3S3g3cVZO?=
 =?utf-8?B?YXlDYmFoeHBOYUVPVHRyMnU5T01xZENZd0RHU2trR2MrTmQ5LzNBUVYreUI2?=
 =?utf-8?B?eGNnVzZtTlJqbDJEb2EzL2hRMmd5NjRzNUN3QzVNbDd4WHZDU1Vobkd3ZzAy?=
 =?utf-8?B?dDlxRzRZNkNXV3NJQTYzU2hxNTBQQTBjVE1LMnRreVV1cFlCUFFnQ1R0eWFG?=
 =?utf-8?B?QjVlbml1OTh2MjdJb055b1Y2OG1MeTV3MWZ3VkgrQVIyRml3MWI4cTNaS1g4?=
 =?utf-8?B?YjJoL0tlTW1hODR5TzNrUVpvZDB5RlpYK2xmRGJ4Y2UyeUVkL1F6M1JNUDBJ?=
 =?utf-8?B?RnNDRkFHRWQvZkdoQnhhVko1UWptdnFoWlNDMmcyRTEweWtVT2NjdFVWSUM0?=
 =?utf-8?B?cmtEby9vTEpnR0lJSXVBMUZNL3lqTEE4NXRUM0dNMVlUTDZpUklpcFNINk94?=
 =?utf-8?B?MkVHa01mQitHeVlWSCtkZFpIV09TWVR0U09KeDBDaE1sVlZQNTZHeTdhZ2Fx?=
 =?utf-8?B?SXpiM1JpODd2UG94SUNQZ2FDTUhFbUxGUE9OSjFwRjliaHd2SnVKMXpPalcy?=
 =?utf-8?B?WS9hM3U5Z2xXR2tReTN3OENkMVR0WkhyNGNZRk5jRGZpcGgzSkwvMW53dXFR?=
 =?utf-8?B?VmcxK2lVRUFXQWJsQVBDWHNSMk1UNXRUUjdwa0JlRkhaQm1QaS9EVjRRclQ0?=
 =?utf-8?B?TWxzbWtXeFZPcFRPOG1lZnFwSXFGOWNwWGFUcFBhNUxsZENrUWh5NktVMmhm?=
 =?utf-8?Q?9DfE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e3caa9-5496-4e81-45b9-08d997ca58e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 15:15:58.5625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lM+tQt5Wtqpfd3+6d1M4pH4vExK+yG3Ez2EJ/B2TBHN87jgA55CRoE7li3lHOS5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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



On 10/25/2021 7:45 PM, Alex Deucher wrote:
> On Mon, Oct 25, 2021 at 9:48 AM PGNet Dev <pgnet.dev@gmail.com> wrote:
>>
>> ( cc'ing this here, OP -> dri-devel@ )
>>
>> i've a dual gpu system
>>
>>          inxi -GS
>>                  System:    Host: ws05 Kernel: 5.14.13-200.fc34.x86_64 x86_64 bits: 64 Console: tty pts/0
>>                             Distro: Fedora release 34 (Thirty Four)
>> (1)             Graphics:  Device-1: NVIDIA GK208B [GeForce GT 710] driver: nvidia v: 470.74
>> (2)                        Device-2: Advanced Micro Devices [AMD/ATI] Cezanne driver: N/A
>>                             Display: server: X.org 1.20.11 driver: loaded: nvidia unloaded: fbdev,modesetting,vesa
>>                             Message: Advanced graphics data unavailable for root.
>>
>> running on
>>
>>          cpu:    Ryzen 5 5600G
>>          mobo:   ASRockRack X470D4U
>>          bios:   vP4.20, 04/14/2021
>>          kernel: 5.14.13-200.fc34.x86_64 x86_64
>>
>> where,
>>
>>          the nvidia is a PCIe card
>>          the amdgpu is the Ryzen-integrated gpu
>>
>> the nvidia PCI is currently my primary
>> it's screen-attached, and boots/functions correctly
>>
>>          lsmod | grep nvidia
>>                  nvidia_drm             69632  0
>>                  nvidia_modeset       1200128  1 nvidia_drm
>>                  nvidia              35332096  1 nvidia_modeset
>>                  drm_kms_helper        303104  2 amdgpu,nvidia_drm
>>                  drm                   630784  8 gpu_sched,drm_kms_helper,nvidia,amdgpu,drm_ttm_helper,nvidia_drm,ttm
>>
>>          dmesg | grep -i nvidia
>>                  [    5.755494] nvidia: loading out-of-tree module taints kernel.
>>                  [    5.755503] nvidia: module license 'NVIDIA' taints kernel.
>>                  [    5.759769] nvidia: module verification failed: signature and/or required key missing - tainting kernel
>>                  [    5.774894] nvidia-nvlink: Nvlink Core is being initialized, major device number 234
>>                  [    5.775299] nvidia 0000:10:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
>>                  [    5.975449] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  470.74  Mon Sep 13 23:09:15 UTC 2021
>>                  [    6.013181] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  470.74  Mon Sep 13 22:59:50 UTC 2021
>>                  [    6.016444] [drm] [nvidia-drm] [GPU ID 0x00001000] Loading driver
>>                  [    6.227295] caller _nv000723rm+0x1ad/0x200 [nvidia] mapping multiple BARs
>>                  [    6.954906] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:10:00.0 on minor 0
>>                  [   16.820758] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input13
>>                  [   16.820776] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input14
>>                  [   16.820808] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input15
>>                  [   16.820826] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input16
>>                  [   16.820841] input: HDA NVidia HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input17
>>
>> the amdgpu is not (currently/yet) in use; no attached screen
>>
>> in BIOS, currently,
>>
>>          'PCI Express' (nvidia gpu) is selected as primary
>>          'HybridGraphics' is enabled
>>          'OnBoard VGA' is enabled
>>
>>
>> on boot, mods are loaded
>>
>>          lsmod | grep gpu
>>                  amdgpu               7802880  0
>>                  drm_ttm_helper         16384  1 amdgpu
>>                  ttm                    81920  2 amdgpu,drm_ttm_helper
>>                  iommu_v2               24576  1 amdgpu
>>                  gpu_sched              45056  1 amdgpu
>>                  drm_kms_helper        303104  2 amdgpu,nvidia_drm
>>                  drm                   630784  8 gpu_sched,drm_kms_helper,nvidia,amdgpu,drm_ttm_helper,nvidia_drm,ttm
>>                  i2c_algo_bit           16384  2 igb,amdgpu
>>
>> but i see a 'fatal error' and 'failed' probe,
>>
>>          dmesg | grep -i amdgpu
>>                  [    5.161923] [drm] amdgpu kernel modesetting enabled.
>>                  [    5.162097] amdgpu: Virtual CRAT table created for CPU
>>                  [    5.162104] amdgpu: Topology: Add CPU node
>>                  [    5.162197] amdgpu 0000:30:00.0: enabling device (0000 -> 0003)
>>                  [    5.162232] amdgpu 0000:30:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
>>                  [    5.169105] amdgpu 0000:30:00.0: BAR 6: can't assign [??? 0x00000000 flags 0x20000000] (bogus alignment)
>>                  [    5.174413] amdgpu 0000:30:00.0: amdgpu: Unable to locate a BIOS ROM
>>                  [    5.174415] amdgpu 0000:30:00.0: amdgpu: Fatal error during GPU init
>>                  [    5.174416] amdgpu 0000:30:00.0: amdgpu: amdgpu: finishing device.
>>                  [    5.174425] Modules linked in: amdgpu(+) uas usb_storage fjes(-) raid1 drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul crc32_pclmul igb crc32c_intel cec ghash_clmulni_intel drm sp5100_tco dca ccp i2c_algo_bit wmi video sunrpc tcp_bbr nct6775 hwmon_vid k10temp
>>                  [    5.174463]  amdgpu_device_fini_hw+0x33/0x2c5 [amdgpu]
>>                  [    5.174594]  amdgpu_driver_load_kms.cold+0x72/0x94 [amdgpu]
>>                  [    5.174706]  amdgpu_pci_probe+0x110/0x1a0 [amdgpu]
>>                  [    5.174907] amdgpu: probe of 0000:30:00.0 failed with error -22
>>
>>
>> are specific configs from
>>
>>          https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fgpu%2Famdgpu.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C508775dd6cc24018696208d997c1f667%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637707681607159780%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=LivHv37A0%2FxKYxSqt1HUzNiIqFznX2N3OEb5gcR4k8U%3D&amp;reserved=0
>>
>> required to avoid/workaround the init error?  or known bug?
> 
> The driver is not able to find the vbios image which is required for
> the driver to properly enumerate the hardware.  I would guess it's a
> platform issue.  Is there a newer sbios image available for your
> platform?  You might try that or check if there are any options in the
> sbios regarding the behavior of the integrated graphics when an
> external GPU is present.  I suspect the one of the following is the
> problem:
> 1. The sbios should disable the integrated graphics when a dGPU is
> present, but due to a bug in the sbios or a particular sbios settings
> it has failed to.
> 2. The sbios should be providing a vbios image for the integrated
> graphics, but due to a bug in the sbios or a particular sbios settings
> it has failed to.
> 3. The platform uses some alternative method to provide access to the
> vbios image for the integrated graphics that Linux does not yet
> handle.
> 
To add to the list - check if ACPI support is broken or skipped.

Thanks,
Lijo

> I would start with an sbios update is possible.
> 
> Alex
> 
