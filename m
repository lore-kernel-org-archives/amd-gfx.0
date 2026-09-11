Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7910C79FA1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 05:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606E110F2E6;
	Fri, 11 Sep 2026 05:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MxSdmQ2e";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD62410F2E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 05:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTAa3bF1VVkRc5ga4S33OI0e+TyqovTBlemov1kiYBNhcd4/Ewbu41w8ISj9VdCPcxx4aOYRo0eeXSMQ75Vzadt9Ii7c8e+rCEgj7S1uiqpVWnGZRviHQM3PeVyPAyb8cMFFDv6PsJRBo4gMEqGGbqr2ptBQQqjm9BhcmcKlhjG9plqYnN4zfUX9ef13gh7eRXl4Nq+ZQFVzOWzt+GB4qvGsO0SN136iX9PjR8bb6GmhhjqdhJ2Z9yuwivbB13ZKiXyR5bcrWJ/2W/SgjfRgSmBEdqleF2ALF+YDsNOZ1+qgTLErXOFQBvfFI8k292xd5cQlc7beHZrpelSYAJ/zIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN2ixniH7Hp9GtqqxFQH+nHEPctomKCBGdqolWesWPg=;
 b=qbJ2Kbw+1QTKvAGgmXJPY6dHEkH+FmqnIdClnBDwbEurvZmC6DUPbhXbODfdakKTKR/vhebgOhY8373pTkQd6Yiv3gnvaS5RJu+GWxoLSov3VrSHQAI71xkXQ8ksdcQMyeIKnEP+DpEs98paSGEuMEJHJSmSILgdcMAGCnQ8zT63TDSPZJthPF6wkCQEB4lQW9D7fBMN8Cm8TEgN54yYrNNvPAbFu9U7tAVRpwjEecb/75VEVljHFX0pp6BXNZlL4SrA18xlovhwlFnh5IDyS297BNFrvnNO6iiWo0IrQ7yMIqFGjpjwFz5I50Z4+B3biF75P4HnMMIIMZunO3GHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN2ixniH7Hp9GtqqxFQH+nHEPctomKCBGdqolWesWPg=;
 b=MxSdmQ2ecvr0+Fa19y287ugpnV86N4BTBwzsVt4WWteARiIm3d44iWPc8rSY0lxELxGr+vwAkzizmvBsViEfsxobsk2MFTeZDuecYnWHmoaoRTt0NqHKZ2mP5xV8KKeX5bCwulaOM1cVkeTeHJBzcaO8Y/30+7H0B+pdl9OtfiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 11 Sep
 2026 05:29:28 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:29:28 +0000
Message-ID: <5ce305ce-08a3-4e3a-821f-bcde50ac1624@amd.com>
Date: Fri, 11 Sep 2026 10:59:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
References: <20260909075121.598208-1-lijo.lazar@amd.com>
 <PHXPR12MB999256240CD7E1B296F833E70AEEB02@PHXPR12MB999256.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PHXPR12MB999256240CD7E1B296F833E70AEEB02@PHXPR12MB999256.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0189.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb6b87e-f92f-4670-5edb-08df0fc5a60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: of50SR5iHb98g6QWymg7MGvEAoopGZJQo6MDsPSgAG45UGKGxbgw/znNkl/6j3vsMpSAy337LQBVc0SA1FmN+Px943euEoYToVSKCIhZ63YS57hyDCR0AYU7Cma1+i/BCkouhUP7atcTh1p1ZVBvaIsrfI9b9ulQhRDLKV51V4c5SYdQV/6sgs+2QIB0PWT0JyKLyxgZq1JR4hG0fqD4nYpHOwLu7utSuFslgn/3mfq0np/s3Q2mXmj2lkwYYm829LW9xXcYxZAWRJ6HOVTI/baMXzJwMXOzgbCf3sVyU8hNsh1ahxS5/bg1W+F4wJoBubbzKteHVo7IWJDpOpEOQqdx5m/M+WJTRWXNxq3/IYVG1saaGIKBbPi1Bs+twPkrrgDWV99GmdxN8mxrYJwErO3zBJp2+gsBZMap/tY1nf+C37Mgrl8Zy3zZD+2ZDh7euvs6jvt+vuDwgIoaeAmgMOGLlxaA0fQ1fqhFDb5hwxUIDT3YqjDREZ8rWG+LawX75LlIVIa0ca7TGMBiMIyp894ZQyoUd2ul97QVqk0U3oJzeLeobHFRMEXQlKRN067nb1cgDHmZdXZ1m4HxgFQ5632mEiSgaunRbnbeO+EmvGFcuseOBJSTHkuBvlTH2UcyTRikZRVZASA81BkUy9vM/zAOwW7Ily+7RDD2PZTd3fM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnQyZ1Axam84bW5Ea0JZV282WUNCRHo0eGFQSEswbkFQbHlwY0pOYWR4VEJV?=
 =?utf-8?B?TGR6WGdjOTJabTl3bkxhTlFETUl3dkNyd3JuVGs1SGt3TnkzeTBLQ1RGeEFZ?=
 =?utf-8?B?eXcwOTRUVk9zMXN2Vy9jK1VJcXdvMjlpb2ZYeEM0d0I5QXdhTCs3RGpSM3J6?=
 =?utf-8?B?djRxSUp3bGVLcXRBVDEwaUl2cE1Mai9rcm1jd2p3eHBHSmdDUW5rK2YrRlov?=
 =?utf-8?B?Wlh5enVhb1pvZE9MMTQwdDVkMkVaelU5SXhKS1NmWTdsbFB2SVM3c1VjTFRO?=
 =?utf-8?B?WTcwalhKSWNPMktkb0E3T3V1SlVCRG5sV29wcWpGc016VllEcVZFeWZQdEtS?=
 =?utf-8?B?eVY0Y0ZCc1NxM0hDL2J4dk9aUmY2UjFlNmovSFJGVlZZT0xvNVRUMWI4T240?=
 =?utf-8?B?UUtPdXhyN1JjUjJqcS9kOWVwWjdlVzQ1dHJzKzB6azl4bTA5VEhydkREV3ZJ?=
 =?utf-8?B?SCtkYThtanVtY1NtQ1ZFRENIaktRTzcwTTU3WlM2a3F0bnFjQTRPUEJGSUk5?=
 =?utf-8?B?bWgyTitaaDVDQ1BrMXB3cDZXSFlMRFpySWNLVGUwWVJhcXJXekcrdXVxc2ww?=
 =?utf-8?B?N2RaZmdMbGlRZEVKR2lXeDVtUFNocGdCbENJVWQvRWQxNGNDR0lJNm1tVzdK?=
 =?utf-8?B?Q3p2ekZPdm9nYVBEbFkwY0JEakU0NFdZREJKZG5qVWhqWHdaZmF3ZENyRnUw?=
 =?utf-8?B?VkdnRTdWNUFIaEszb3dwa3FXRHVVaCtPRFlzNmNkTTlza1JjK3paMTIwdXli?=
 =?utf-8?B?SDhzMzRhM1pJN3ZXTmQxRCs0enlJb2hVd0pPNGM4eFlPVTlUT0o5a09seUQx?=
 =?utf-8?B?bW1EeUVjekZQTk1DZ0N3V2ZJYU95TDNUMnNNa0E5dmVVaHBkeXJmaERKT0VD?=
 =?utf-8?B?OFZqNlNJaGNZeGl6bGVqc3B2eFRMTnNpZ2IzSWxrTERndVJlWXpkdEFLUE5K?=
 =?utf-8?B?RDNsS1ZGQUR1M0RIMG0waStvRXV0OVNrb3gvT1lxWmxscHUrNmVyNDBqNkt3?=
 =?utf-8?B?SEdFeXgwR0FIeld4RUJGWnAwQ1Q0S3hvN0J0Z0p2cEJXNDZ5U2hhZjFtckRv?=
 =?utf-8?B?RmVURlQ3NFJTYk5ENXkxMjR4K1BQcGJaNUZFeWxHeUlGSVFhdDdJTkQ1alFq?=
 =?utf-8?B?bktrRDZZZTVzYkdZMGF5bmxHZzMrZDkrc1BTck1LYkxFTjE1dWlhVnBiMG9N?=
 =?utf-8?B?a3hJYmRVMFVrRjRqNVV6NWdxTlZkSVYrbnVma1VMVnQvNXhrQjh4YktyN3BB?=
 =?utf-8?B?L25zOW8zS1ZNaW1id2R6enVacUdnNGtaOExqTXZnNDVxTE9VWWFSMXhMMVY3?=
 =?utf-8?B?VzAyUUFCaUVBRzNBNUliVlBZY0VMb054cjUyR1pIMXJLWCtUUW9pS1A1eUZJ?=
 =?utf-8?B?NDdFT1ZDZ3NnWG85TzVHYlV3Z0V0Rm5KVlY0ZjhsN0ZqcUE4N3hGL3JDTXJk?=
 =?utf-8?B?K1RlcGxtT3p3VGxCK3NuUkdocE5hWlBoR0dTWUkwWS94bWpzNnpjZitwV2Jh?=
 =?utf-8?B?eXhzb21oSVIvL0VSb3pGUk5WYm9OVzBFbUFPZHR5UnFFc1hXT2JrckNHbTJV?=
 =?utf-8?B?azRReUowWWhkUEpHL3JlQzF5Z0pBQlpvaTJCN0QvMFQwakNKOVM1bzhhSkUw?=
 =?utf-8?B?SnZPZWw1azk3czJzS0JOR0UvTjltaW5CYWszMFNVczdkd1lKckdQKzFPckI4?=
 =?utf-8?B?aWNmdW5VMjVCTjFNcDhubUZZckpDbjJyY0RxWVAxQ1Uxa3lnS0c2NStWRkpF?=
 =?utf-8?B?Z2RTemRuV0dCQmZXbkJUNEtjVkxFdnErOUw3SGhyRWlXcFJpWVJXMCt4TlFi?=
 =?utf-8?B?WUVGMXJpZnpXUjFpMzV3VXFLcEdGalNJbzdva0JUQkY0a1lwRktEN2kxSmtR?=
 =?utf-8?B?bkxXTkNZTUtnb0VuWFgyWEUrRDhoQ0FZSVVKUi9IM3VhaHVReHQ2S21tWmJX?=
 =?utf-8?B?Tzlmc0RUSE40aWI3eWdSb0xWUzZhVmFPTUlOMSs2S0xWMzBqdDJiSEFkMHd6?=
 =?utf-8?B?b2E2V3A4MDFzOTQydHlkbWtLaHNNRVdrYXJybmU0RzhUOVFQdWQvUFB0Mm9U?=
 =?utf-8?B?Q24xcVpyYVJRNkdLWHlKR2VkS0g2V3dJaUxUcnV6M2JKT3hkWmVROTVQTFVM?=
 =?utf-8?B?K1M5dCtZTFBZZkRSOFllV014VXcyeTFZUXNjcm1rVXhnVmxDUGtrc2FwS3Nv?=
 =?utf-8?B?TFowNXBJOG13VExmSEZrSC8waU1PRE1nQmRsbWlCT05ucnFvSlhlZCs2Szh0?=
 =?utf-8?B?Z2d4bmREOGRTaEhjUGtxR3RmK1lrZXB4SEgrZmVuV1M4RFNseDJ0a0RlMkZV?=
 =?utf-8?B?VEJhRmpuUVNEeGcycnhRNksrWWtOTGhpdkxsSkgxMkJ1QUJoMEpHdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb6b87e-f92f-4670-5edb-08df0fc5a60b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:29:28.0332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBRDFbmqghmD+teoPNlGe0cumZr6kxDy6ntL5UG1g5SBMyU68W+5tTzrB2MyrUEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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



On 09-Sep-26 10:43 PM, Joshi, Mukul wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, September 9, 2026 3:51 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>> Joshi, Mukul <Mukul.Joshi@amd.com>; Liu, Xiang(Dean)
>> <Xiang.Liu@amd.com>
>> Subject: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
>>
>> The compute partition switch locked the kfd device, freed it during the pre-
>> switch teardown, and then unlocked at the end - by which point
>> adev->kfd.dev referenced the newly reinitialized device, so the unlock
>> landed on the wrong object and the per-device lock was never balanced.
>>
>> Add a dedicated prepare function to unwind and clean up kfd device.
>> Don't use the global lock during teardown. A new device is created after
>> partition switch; hence there is no need to do 'unlock' on a different object
>> after the switch.
>>
>> User is not supposed to run any process on the device during partition
>> switch. Keep acquire/release semantics for init_complete so that the device
>> remains unavailable for a process till its reinitialization is complete.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   | 19
>> +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h   |  6 ++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c      |  6 ++++--
>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c   | 11 +----------
>>   drivers/gpu/drm/amd/amdgpu/soc_v1_0.c        | 11 +----------
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c      | 10 ++++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c |  6 ++++++
>>   7 files changed, 45 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 09feb45584ba..a2a368f1e290 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -245,6 +245,25 @@ void amdgpu_amdkfd_device_fini_sw(struct
>> amdgpu_device *adev)
>>        }
>>   }
>>
>> +int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device
>> *adev)
>> +{
>> +     struct kfd_dev *kfd = adev->kfd.dev;
>> +     int r;
>> +
>> +     if (!kfd)
>> +             return 0;
>> +     r = kgd2kfd_check_and_lock_kfd(kfd);
>> +     if (r)
>> +             return r;
>> +
>> +     adev->kfd.init_complete = false;
>> +     kgd2kfd_device_fini(kfd);
>> +     adev->kfd.dev = NULL;
>> +     amdgpu_amdkfd_total_mem_size -= adev->gmc.real_vram_size;
>> +
>> +     return 0;
>> +}
>> +
>>   void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>                const void *ih_ring_entry)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 1b7dc0d3963b..36e222f3ac5b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -170,6 +170,7 @@ void amdgpu_amdkfd_interrupt(struct
>> amdgpu_device *adev,  void amdgpu_amdkfd_device_probe(struct
>> amdgpu_device *adev);  void amdgpu_amdkfd_device_init(struct
>> amdgpu_device *adev);  void amdgpu_amdkfd_device_fini_sw(struct
>> amdgpu_device *adev);
>> +int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device
>> *adev);
>>   int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
>> void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);  int
>> amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev, @@ -431,6 +432,7
>> @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
>> bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>                         const struct kgd2kfd_shared_resources
>> *gpu_resources);  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>> +void kgd2kfd_device_fini(struct kfd_dev *kfd);
>>   void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc);  int
>> kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc);  void
>> kgd2kfd_suspend_process(struct kfd_dev *kfd); @@ -485,6 +487,10 @@
>> static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)  {  }
>>
>> +static inline void kgd2kfd_device_fini(struct kfd_dev *kfd) { }
>> +
> 
> Maybe follow the pattern of having open and close branch on new lines as done for
> the other functions.
> 
>>   static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc)  {
>> } diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> index a8c79a66df1d..92fa15ace438 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>> @@ -694,14 +694,16 @@ void
>> amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
>>
>>   int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr,
>> u32 flags)  {
>> +     int ret = 0;
>> +
>>        /* TODO:
>>         * Stop user queues and threads, and make sure GPU is empty of
>> work.
>>         */
>>
>>        if (flags & AMDGPU_XCP_OPS_KFD)
>> -             amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
>> +             ret = amdgpu_amdkfd_prepare_partition_switch(xcp_mgr-
>>> adev);
>>
>> -     return 0;
>> +     return ret;
>>   }
>>
>>   int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr,
>> u32 flags) diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> index cddfe4015f53..699e797679ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> @@ -391,15 +391,9 @@ static int
>> aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>>                !adev->in_suspend)
>>                flags |= AMDGPU_XCP_OPS_KFD;
>>
>> -     if (flags & AMDGPU_XCP_OPS_KFD) {
>> -             ret = amdgpu_amdkfd_check_and_lock_kfd(adev);
>> -             if (ret)
>> -                     goto out;
>> -     }
>> -
>>        ret = amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
>>        if (ret)
>> -             goto unlock;
>> +             goto out;
>>
>>        num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr,
>> mode);
>>        if (adev->gfx.funcs->switch_partition_mode)
>> @@ -413,9 +407,6 @@ static int
>> aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>>        ret = amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
>>        if (!ret)
>>
>>        __aqua_vanjaram_update_available_partition_mode(xcp_mgr);
>> -unlock:
>> -     if (flags & AMDGPU_XCP_OPS_KFD)
>> -             amdgpu_amdkfd_unlock_kfd(adev);
>>   out:
>>        return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>> b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>> index 757da0a30fdc..28eca48c6596 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
>> @@ -1097,15 +1097,9 @@ static int soc_v1_0_switch_partition_mode(struct
>> amdgpu_xcp_mgr *xcp_mgr,
>>        if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
>>                flags |= AMDGPU_XCP_OPS_KFD;
>>
>> -     if (flags & AMDGPU_XCP_OPS_KFD) {
>> -             ret = amdgpu_amdkfd_check_and_lock_kfd(adev);
>> -             if (ret)
>> -                     goto out;
>> -     }
>> -
>>        ret = amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
>>        if (ret)
>> -             goto unlock;
>> +             goto out;
>>
>>        num_xcc_per_xcp = __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
>>        if (adev->gfx.imu.funcs &&
>> @@ -1126,9 +1120,6 @@ static int soc_v1_0_switch_partition_mode(struct
>> amdgpu_xcp_mgr *xcp_mgr,
>>        ret = amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
>>        if (!ret)
>>                __soc_v1_0_update_available_partition_mode(xcp_mgr);
>> -unlock:
>> -     if (flags & AMDGPU_XCP_OPS_KFD)
>> -             amdgpu_amdkfd_unlock_kfd(adev);
>>   out:
>>        return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 1c1e7878a2a7..76b308286095 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -952,7 +952,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>
>>        svm_range_set_max_pages(kfd->adev);
>>
>> -     kfd->init_complete = true;
>> +     /* Release pairs with the acquire in kfd_init_apertures(). */
>> +     smp_store_release(&kfd->init_complete, true);
>>        dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev-
>>> vendor,
>>                 kfd->adev->pdev->device);
>>
>> @@ -977,7 +978,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>        return kfd->init_complete;
>>   }
>>
>> -void kgd2kfd_device_exit(struct kfd_dev *kfd)
>> +void kgd2kfd_device_fini(struct kfd_dev *kfd)
>>   {
>>        if (kfd->init_complete) {
>>                /* Cleanup KFD nodes */
>> @@ -991,6 +992,11 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>        }
>>
>>        kfree(kfd);
>> +}
>> +
>> +void kgd2kfd_device_exit(struct kfd_dev *kfd) {
> 
> Open brace should be on the next line.
> Maybe run it through checkpatch once if not already done.
> 
>> +     kgd2kfd_device_fini(kfd);
>>
>>        /* after remove a kfd device unlock kfd driver */
>>        kgd2kfd_unlock_kfd(NULL);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> index 04c5e26f01ed..da61d939b35c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> @@ -396,6 +396,12 @@ int kfd_init_apertures(struct kfd_process *process)
>>                        continue;
>>                }
>>
>> +             /* acquire pairs with the release in kgd2kfd_device_init() */
>> +             if (!smp_load_acquire(&dev->kfd->init_complete)) {
> 
> Do we need similar smp_load_acquire() at other call sites of this kfd->init_complete?
> 

Presently, it's done only at this place so that no process is bound to 
the device till reinit is complete. The other places are opertions after 
a process is bound, so they are not checked.

BTW, looks like Outlook mail client is the culprit behind style issues 
seen. Checkpatch didn't show any issues, and Thunderbird shows the patch 
properly.

Thanks,
Lijo

> With the minor nit-picks above fixed, this series is:
> Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
> 
>> +                     id++;
>> +                     continue;
>> +             }
>> +
>>                pdd = kfd_create_process_device_data(dev, process);
>>                if (!pdd) {
>>                        dev_err(dev->adev->dev,
>> --
>> 2.49.0
> 

