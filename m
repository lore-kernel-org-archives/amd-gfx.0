Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1D4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 09:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49EB10E84A;
	Thu, 20 Jan 2022 09:11:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAB610E8FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3N1P+H7fRwkRsH2jGX7FONrMA2sSP9NHsZbGrC2GHO+riMd//FPb30DJ/KsmTcTQ9aizP8UdPyYxWeAcmj3VwbV7PGshJv9KKGWMAJXxbGXqaQx9DoYeUpuZYIM4rcAyS01Q0yyI7EqO5dWyOB4MR9hZB/T/9CQa2tkVmOQgkOGJxue/I5T8YKzt07H+HryH9rBDsLkCOqQ3Q1hfkn+j40dcZbbPJpgSoHUbzFNVWV2PHCzKV1lKjJO6SfJtp+C9QmWBigVEvdZLuK/RaKCq2MAM6CGITHVrRQ/qHjm7I38Vr1cab63IWPTR+3CHMecWMBR2eWccBhvLfM2w/ze2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ld/bQ/pQdfde8DP0DguKpFWlQNzLfAwhsFZ7xpxDF0=;
 b=fjlisAQzdgXK32Dwm8OF/QaMjhUWphJLDoFdac3Vdceoz+pTGS5HOktu+Oz62CmjAP9uQqqMKqjRXZxM0NQzrfRnv2KPSh31zIXiv4PIQZtCbA0rk/UabWWMy0SwADOFHN9md+N+twk0JaDspERwRWFcafmPystjdNa9nwXe8UWu2XvxbIk0d6vTyivI9sCYTTsDTKsoQw3tlNYe3ChgCRpSW8aS562HNLIhacy/X/SpANlOgry65UigjAVnRPkbAX+8C8K9hOaIb9n6T3uWGBq77+kVAdDEEu7p2jHA8flTZm9GZttJVsuTWXyR9aUwAmf2Vc1Ih/MV5Z9hOiUt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ld/bQ/pQdfde8DP0DguKpFWlQNzLfAwhsFZ7xpxDF0=;
 b=HjaqoT1NidvI7ySxb0SUiHDeS+iU7+jl3FGD9aoNWciZSgQC+kNEQf0qtsA3YgSqH8Fb+2JU341Qq1mXjrcxRgOJIInwQ5ubnkH0GPcsTMH436dIchcWzw5xwJZJW7i221zUm8RmGk9ipEPp5+HIgMvJryEqaPlPRUyH0olJWEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB3316.namprd12.prod.outlook.com (2603:10b6:408:42::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 09:11:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 09:11:47 +0000
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table when
 mmio is blocked
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>
References: <20220119031610.832211-1-KevinYang.Wang@amd.com>
 <CO6PR12MB54731E9FBF54A2E86A320419825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
 <95be3a20-ac92-9acd-9600-3caf9223c67a@amd.com>
 <CO6PR12MB54735F709AACC151C3B66900825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0a753643-dffe-8560-8923-4e4cfcbfd7e1@amd.com>
Date: Thu, 20 Jan 2022 10:11:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CO6PR12MB54735F709AACC151C3B66900825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------B0A67B40810F92A961D95DBE"
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0207.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13fe933f-419d-4230-8275-08d9dbf4e2a4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3316:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3316EAF27A406F2E8015059A835A9@BN8PR12MB3316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /88o0qliWx2IrN/1oM8P5XQ/F80Qns3LZYrjnN+nDdWlQDqCs6bGo4hJY6XzNsw5U8inhya5A0ZZPanu/u0TuxGJZ+qhmqkLMIlkX5CWDPh6vCISXJ3pe7swu1mS71lrRm9Yt8Kn3gLUD6idBDLjneuvhXc6mIilrX0+wC3GV3WsuHXsmAzxam15R5sHmdVZ8zPj7G4WsS+t8sZdCxIfTvu9rA3k82y0qQDEAI/KZFidXIwsM/NurbaVbevc3Y/m6odAIbL/R6NeaHXdnOybU6TjuJ/TLqPKnDDqORNmGTEH0fsVi+e/BKDAQ9iDB4zqcNLSVFYblJnVGD0W8siEcbALVgL737Pb/BsDrU11o29bVjaWbX4UwbQAl+kUMw57NsIXPPbA8LyaCnQBiz/ZPuCxb27GDwTwTSrbpL5v9pdCEdIS8WlZTSrsUJblUvTFBc07USq5ADVAEp120hrQuqtNTI0qufFJbVfDIT1YNc0jhXBnR30rkpTbSFkRVR+ghnZCpjbqoH6KUais632KypGnxhmt8A1bcFN9bI1C8kcqoFzKVdjSpd1qSXwHJyHmC7F4oqtUhPoubLxqgxl+tvKRsJv3mHLtlA6RLiTQRBzLl7sJt7XOuKkTn3yP2Q1BWZZFcYd4ymdUv3Mhwts664b6vegR0xI8Yw95Bwe3Cs++qlvLh4I+GvLap6qpCa1OgoSHbwqniRR2N5JGH2MHizu4oFD3RP6Tu65AqcbSORGOR2fTByL0rOhyu6t+tnIa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(33964004)(6486002)(2616005)(36756003)(15650500001)(19627405001)(4326008)(38100700002)(508600001)(186003)(6636002)(6506007)(83380400001)(316002)(8676002)(6666004)(5660300002)(53546011)(31696002)(66946007)(110136005)(54906003)(66556008)(66476007)(86362001)(6512007)(26005)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hDeVgxWWEvOHJpVkJ1dFFsSHFEVDRiOUlmUXZyQ3R5dmZCaDRoZTFiZm5z?=
 =?utf-8?B?T3ZzSU1LOGZtck5OUVpWZ09GanUwUXFub1ZtU2hMWjhiNWZWRE15cVYyMFhR?=
 =?utf-8?B?dDB3TGZGUmdTUVpLUGR4S1lxZGY2YmRhZmNWNTdGcXNYMVdtMFdXUHdNOXg0?=
 =?utf-8?B?Zng5SmNnRmQrRjU4NkY0OFBBNTJDeEk1cUZpdXdTWEJYQ3kvSW51QnVNV002?=
 =?utf-8?B?L0ZxZ3R0QlB4ZEZjbkkxZUZWR1F6ciswanptdVdCK0JNbXVQM0dNdjl3S3VK?=
 =?utf-8?B?YnFvWGhEc1FUYWZtbm5YTUxTRHhmMmFYbjIvRWtseTU1NUtXUC9DK3FsblV0?=
 =?utf-8?B?amhRazBxZnZxZmhNWjVMRHNZeVF1OTM3TlV2R2wyVTVnU2E3c0QydnhlU0dy?=
 =?utf-8?B?bmtTaDgwVmQwRUtxaEtVZHF6YlRCZEkyc1ZvVHdjeDE1U1N2Q2F3MkxQVytQ?=
 =?utf-8?B?Znl5dFVOdEtISExLUkRkUmlkdVRNVXJtdDVUMlR4UGdiRVBidThCN3FBZTN6?=
 =?utf-8?B?YlpuNCtHUGxrT0x6UVluOHFZOUxiSHczU3hUNmlMWXVydjRpTW9QK3EvTHEx?=
 =?utf-8?B?UzJWYklPeXVGK0ZFUjlydFRneS9tcDZ2QW9Ud3FJZlRueUZ1T05Da0I4VHBP?=
 =?utf-8?B?RzFuMktQS2tlNWZ4NmpoakpmMFRQVTFCYnY3QmJEWll2Mm8rWHJVZnhkSnhx?=
 =?utf-8?B?eU1MeTY1RUEzbEVRQnZnNEZLczZzNFVVZ2p1NHB5VENsRGVjYXBWYUJqNVI3?=
 =?utf-8?B?aCtTWFZONEV5akJFQjJFVjY1OHJQVGdzZ09Fc2dpNjh5c3R3VjQyenZtNTNo?=
 =?utf-8?B?UGpnT3lzVTdaMW9JUnQ5bUlDbUJzb01YMnJkMUl0TGxyZG1rRkRvNDNKbXZj?=
 =?utf-8?B?eTFlbnQ0bGhNMkMwMlYzTVpNSlZvL0xzU2RIelJ2S3lYNUxDNm5HUTc0WG9t?=
 =?utf-8?B?TEJnSnl0eVFod0lyWUxtNklWWWRNNXowVVpHWlk4aitUckt4K3I5TTZhSnlm?=
 =?utf-8?B?YTZCcGNIMDBNd21PU09LTmZRd1pZdWJGWEVIRGY2SFIrY2Vma1k1RnROUTRI?=
 =?utf-8?B?QzBBb3BESVZqS2d3c2s5N01RdEZBbUxZN3RBTDZkUUtnaGZ4NGRBZHRZbUVE?=
 =?utf-8?B?SnRFclhnM3hTWkpjc0VpSGlPMzNDcDlaa016YkdTTWU3Wm0wR3l3SHpKcnE0?=
 =?utf-8?B?YnhscVpMZzFVekpENHVMZWVZWmZybUhpTGlkVTRiQ1lNbVc2Q21Wc0puamNp?=
 =?utf-8?B?MVFTK0N5NXQxSC9aQ0NUcExwT0ZLWXJGcWJ4bUtUTWoxSHJmb0xlZFJTb1pM?=
 =?utf-8?B?eXY2SGMxaWhFdTBudm90OEU5dkdRVzAwU09FR0Z3RTdlTSt1cW5zVmk4WEhl?=
 =?utf-8?B?VjgzRldycGF2RTY3dXhJNGRJNjMyMkowQmkyWm12a3h3ZkJYYmZpL0dWUFlB?=
 =?utf-8?B?ZStibVBQOFBEbGNWQWxCdUpuajBSU0dZQlVuVWtJL3BYa002YXh3YnJncnhW?=
 =?utf-8?B?Tm4zMEpIOGZTMDBKditLbllnZS93VjY2YzhNclZEN3hDQXRFSGxoaUQrR3Vt?=
 =?utf-8?B?bTEvTUdKc1pQdHN3Y05Gdy9maU83MkUxdWtvdFhndHVMN1gvYnVhVjhzejBu?=
 =?utf-8?B?Zlhzc3NHUEhIb1Y0WXkyNlEvcGVZdXBQQVN3S0pzTVZPcUk0cVVVaTl2UnRq?=
 =?utf-8?B?YTIxa3ZkODNPZWVSbTV1QktkNTBqOVZsY2svNytyWUlYNkIyK2h3UGpJcG1P?=
 =?utf-8?B?UUxBS1dWT1hDbEg2RVRreGMyemhZUjZwa3JUVWxIRWE5TWNJRVgxNWFoVEJ3?=
 =?utf-8?B?Z3QvYkU1RkE3Vk9vRkJWakExZ09vT2hJUFZqemRCOXJscldSdzFFZUM4QlFl?=
 =?utf-8?B?VkF0UExQRXY0SWRaZ011K0NLeVF4c05LWllqY1E2K0dKNVRZQjlmUFF4aVdY?=
 =?utf-8?B?NVY1Und6bmEyTXFGQ3AvVXlTSS9GRWdWNExZOTQwZzFRbnZBV3VxaE1IY0lD?=
 =?utf-8?B?SnpnOGQ2L1ZVNDVzd0JWQmZSK0VLcFV2MnVUaVQ0ck1hcTlxcTR3ZWlvVkE1?=
 =?utf-8?B?aE82Ujh3OWhUTlE3dG9rQXk5ZnZkR3lhL2RDSU1JdVo1L2ZJeFgxZjBlenA3?=
 =?utf-8?Q?UXPI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fe933f-419d-4230-8275-08d9dbf4e2a4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 09:11:47.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKYD07jxUD6xXrIP5+GjsHwua8aKgbWpyrtuXqrVt80WwIw6SXIDPISnuJiNKzkP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3316
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Min, Frank" <Frank.Min@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------B0A67B40810F92A961D95DBE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kevin,

well at least the HDP flush function has to work correctly or otherwise 
the driver won't work correctly.

If the registers are not accessible any more we need to find a proper 
workaround for this.

One possibility would be to use the KIQ, another is a dummy write/read 
to make sure the HDP is flushed (check the hardware docs).

The third option would be to question if blocking the HDP registers is 
really a good idea.

The solution is up to you, but a workaround like proposed below doesn't 
really help in any way.

Regards,
Christian.

Am 20.01.22 um 10:07 schrieb Wang, Yang(Kevin):
>
> [AMD Official Use Only]
>
>
> Hi Chris,
>
> yes, I agree with your point.
> and another way is that we can use KIQ to write HDP register to 
> resolve HDP can't R/W issue.
> but it will cause some performance drop if use KIQ to programing register.
>
> what is your ideas?
>
> Best Regards,
> Kevin
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Thursday, January 20, 2022 4:58 PM
> *To:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk 
> <Monk.Liu@amd.com>
> *Cc:* Min, Frank <Frank.Min@amd.com>; Chen, Horace <Horace.Chen@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: force using sdma to update vm page 
> table when mmio is blocked
> Well NAK.
>
> Even when we can't R/W HDP registers we need a way to invalidate the 
> HDP or quite a bunch of functions won't work correctly.
>
> Blocking CPU base page table updates only works around the symptoms, 
> but doesn't really solve anything.
>
> Regards,
> Christian.
>
> Am 20.01.22 um 09:46 schrieb Wang, Yang(Kevin):
>>
>> [AMD Official Use Only]
>>
>>
>> ping...
>>
>> add @Liu, Monk <mailto:Monk.Liu@amd.com> @Koenig, Christian 
>> <mailto:Christian.Koenig@amd.com> @Deucher, Alexander 
>> <mailto:Alexander.Deucher@amd.com>
>>
>> Best Regards,
>> Kevin
>> ------------------------------------------------------------------------
>> *From:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com> 
>> <mailto:KevinYang.Wang@amd.com>
>> *Sent:* Wednesday, January 19, 2022 11:16 AM
>> *To:* amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *Cc:* Min, Frank <Frank.Min@amd.com> <mailto:Frank.Min@amd.com>; 
>> Chen, Horace <Horace.Chen@amd.com> <mailto:Horace.Chen@amd.com>; 
>> Wang, Yang(Kevin) <KevinYang.Wang@amd.com> 
>> <mailto:KevinYang.Wang@amd.com>
>> *Subject:* [PATCH] drm/amdgpu: force using sdma to update vm page 
>> table when mmio is blocked
>> when mmio protection feature is enabled in hypervisor,
>> it will cause guest OS can't R/W HDP regiters,
>> and using cpu to update page table is not working well.
>>
>> force using sdma to update page table when mmio is blocked.
>>
>> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com> 
>> <mailto:KevinYang.Wang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index b23cb463b106..0f86f0b2e183 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>          vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>> AMDGPU_VM_USE_CPU_FOR_GFX);
>>
>> +       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && 
>> amdgpu_virt_mmio_blocked(adev))
>> +               vm->use_cpu_for_update = false;
>> +
>>          DRM_DEBUG_DRIVER("VM update mode is %s\n",
>> vm->use_cpu_for_update ? "CPU" : "SDMA");
>>          WARN_ONCE((vm->use_cpu_for_update &&
>> @@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct 
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>          /* Update VM state */
>>          vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>> AMDGPU_VM_USE_CPU_FOR_COMPUTE);
>> +
>> +       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && 
>> amdgpu_virt_mmio_blocked(adev))
>> +               vm->use_cpu_for_update = false;
>> +
>>          DRM_DEBUG_DRIVER("VM update mode is %s\n",
>> vm->use_cpu_for_update ? "CPU" : "SDMA");
>>          WARN_ONCE((vm->use_cpu_for_update &&
>> -- 
>> 2.25.1
>>
>


--------------B0A67B40810F92A961D95DBE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Kevin,<br>
    <br>
    well at least the HDP flush function has to work correctly or
    otherwise the driver won't work correctly.<br>
    <br>
    If the registers are not accessible any more we need to find a
    proper workaround for this.<br>
    <br>
    One possibility would be to use the KIQ, another is a dummy
    write/read to make sure the HDP is flushed (check the hardware
    docs).<br>
    <br>
    The third option would be to question if blocking the HDP registers
    is really a good idea.<br>
    <br>
    The solution is up to you, but a workaround like proposed below
    doesn't really help in any way.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 20.01.22 um 10:07 schrieb Wang,
      Yang(Kevin):<br>
    </div>
    <blockquote type="cite" cite="mid:CO6PR12MB54735F709AACC151C3B66900825A9@CO6PR12MB5473.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Hi Chris,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
          yes, I agree with your point.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="color: rgb(0, 0, 0); font-family: Calibri, Arial,
            Helvetica, sans-serif; font-size: 12pt;">and another way is
            that we can use KIQ to write HDP register to resolve HDP
            can't R/W issue.</span><br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="color: rgb(0, 0, 0); font-family: Calibri, Arial,
            Helvetica, sans-serif; font-size: 12pt;">but it will cause
            some performance drop if use KIQ to programing register.</span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          what is your ideas?</div>
        <span></span>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Best Regards,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Kevin</div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, January 20, 2022 4:58 PM<br>
            <b>To:</b> Wang, Yang(Kevin) <a class="moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com">&lt;KevinYang.Wang@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Liu, Monk
            <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a><br>
            <b>Cc:</b> Min, Frank <a class="moz-txt-link-rfc2396E" href="mailto:Frank.Min@amd.com">&lt;Frank.Min@amd.com&gt;</a>; Chen,
            Horace <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: force using sdma to
            update vm page table when mmio is blocked</font>
          <div>&nbsp;</div>
        </div>
        <div>Well NAK.<br>
          <br>
          Even when we can't R/W HDP registers we need a way to
          invalidate the HDP or quite a bunch of functions won't work
          correctly.<br>
          <br>
          Blocking CPU base page table updates only works around the
          symptoms, but doesn't really solve anything.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <div class="x_moz-cite-prefix">Am 20.01.22 um 09:46 schrieb
            Wang, Yang(Kevin):<br>
          </div>
          <blockquote type="cite">
            <p style="margin-top: 0px; margin-bottom:
              0px;font-family:Arial; font-size:10pt; color:#0000FF;
              margin:5pt" align="Left">
              [AMD Official Use Only]<br>
            </p>
            <br>
            <div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                ping...</div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                add <a id="OWAAM160069" class="x_P8b7u5KH31KY6Eljcf5yw
                  x_mention x_ms-bgc-nlr x_ms-fcl-b" href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">
                  @Liu, Monk</a>&nbsp;<a id="OWAAM254265" class="x_P8b7u5KH31KY6Eljcf5yw x_mention x_ms-bgc-nlr
                  x_ms-fcl-b" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">@Koenig, Christian</a>&nbsp;<a id="OWAAM277931" class="x_P8b7u5KH31KY6Eljcf5yw
                  x_mention x_ms-bgc-nlr x_ms-fcl-b" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">@Deucher, Alexander</a></div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                Best Regards,</div>
              <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                Kevin</div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Wang, Yang(Kevin)
                  <a class="x_moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com" moz-do-not-send="true">&lt;KevinYang.Wang@amd.com&gt;</a><br>
                  <b>Sent:</b> Wednesday, January 19, 2022 11:16 AM<br>
                  <b>To:</b> <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a> <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Cc:</b> Min, Frank <a class="x_moz-txt-link-rfc2396E" href="mailto:Frank.Min@amd.com" moz-do-not-send="true">
                    &lt;Frank.Min@amd.com&gt;</a>; Chen, Horace <a class="x_moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com" moz-do-not-send="true">
                    &lt;Horace.Chen@amd.com&gt;</a>; Wang, Yang(Kevin) <a class="x_moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com" moz-do-not-send="true">
                    &lt;KevinYang.Wang@amd.com&gt;</a><br>
                  <b>Subject:</b> [PATCH] drm/amdgpu: force using sdma
                  to update vm page table when mmio is blocked</font>
                <div>&nbsp;</div>
              </div>
              <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
                    <div class="x_PlainText">when mmio protection
                      feature is enabled in hypervisor,<br>
                      it will cause guest OS can't R/W HDP regiters,<br>
                      and using cpu to update page table is not working
                      well.<br>
                      <br>
                      force using sdma to update page table when mmio is
                      blocked.<br>
                      <br>
                      Signed-off-by: Yang Wang <a class="x_moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com" moz-do-not-send="true">
                        &lt;KevinYang.Wang@amd.com&gt;</a><br>
                      ---<br>
                      &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7
                      +++++++<br>
                      &nbsp;1 file changed, 7 insertions(+)<br>
                      <br>
                      diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      index b23cb463b106..0f86f0b2e183 100644<br>
                      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      @@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct
                      amdgpu_device *adev, struct amdgpu_vm *vm)<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
                      !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      AMDGPU_VM_USE_CPU_FOR_GFX);<br>
                      &nbsp;<br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&amp;
                      amdgpu_sriov_vf(adev) &amp;&amp;
                      amdgpu_virt_mmio_blocked(adev))<br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update = false;<br>
                      +<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM update mode is
                      %s\n&quot;,<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      vm-&gt;use_cpu_for_update ? &quot;CPU&quot; : &quot;SDMA&quot;);<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_for_update
                      &amp;&amp;<br>
                      @@ -3094,6 +3097,10 @@ int
                      amdgpu_vm_make_compute(struct amdgpu_device *adev,
                      struct amdgpu_vm *vm)<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update VM state */<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
                      !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      AMDGPU_VM_USE_CPU_FOR_COMPUTE);<br>
                      +<br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&amp;
                      amdgpu_sriov_vf(adev) &amp;&amp;
                      amdgpu_virt_mmio_blocked(adev))<br>
                      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update = false;<br>
                      +<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM update mode is
                      %s\n&quot;,<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      vm-&gt;use_cpu_for_update ? &quot;CPU&quot; : &quot;SDMA&quot;);<br>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_for_update
                      &amp;&amp;<br>
                      -- <br>
                      2.25.1<br>
                      <br>
                    </div>
                  </span></font></div>
            </div>
          </blockquote>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------B0A67B40810F92A961D95DBE--
