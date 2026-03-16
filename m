Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F38F013CA
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 08:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A7A10E319;
	Mon, 16 Mar 2026 08:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yzDgdouP";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C4410E319
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 08:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuZHlf46AppYULzpLRE2xpYNcMs33roReFfGOetFzaUXowP1HhDZ9o+/BcBg1PjwJA+o90zJGNRTVpH65eBXtphyOYCeWxRhACFlMDjCDOXN5ITb1sLQDRZTrbTDmxelhdIOQA6EqBaVJcQRf7YUbbBPIBsRHNDTL+8ra8kyFAbesquv6v10bj1DvRQ99T5J3T4PFTAS+ml5ksn6kEiWV3Z5X2GCCofy/yxHLG442cOVYpFrSXEwJoPnk4OASdq4C9PXVX0spAGPoO2jiaGU9QGq3cRsyRChlilE1YsYLMc8DNHJXNxs5Znxzd0mGmui/S4b1612ZlCSiOUnew9SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30pbxWklKHgUhg+Niq+xnS5K72MbJ7Q2fUR6i4tk46Y=;
 b=Y1snFKaaq+e8ssbM9k2G8xsV1IVvQm6Smxc5RfcoL9dVQSZCZyVHX+An4FKmirobHUP3HKfpUrlPwRe5Rz5COSNTz/pRLWcTbddR8GPL9CZhxqKin+YstsG+WOW9PN8ZLm7cV4x27M7Buv0DZgnmkJrCvX7SlQusj+ASO5/3OxekOYzpOPA1xciKdJ+7j/sebHoZsC28J0c44ZiHNksheiJmJogB5v6dnknC1Z9ja69kedcGPSEdwUSPKw1hDmdr5eURhia2LPQNUhy5QoQ1trUMpnzyPjIyXhhapJR7oB5EPegMic2gI557XhFw2UefPMJFFT10i2j10Y5v8Nhh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30pbxWklKHgUhg+Niq+xnS5K72MbJ7Q2fUR6i4tk46Y=;
 b=yzDgdouPQ3HiZcLz5+A1OaDQ92/UcY1+MT9So1188T8Ln3VqRPdWed4w2x86LGFzrqqJhekKMucMyBIzn9pPVH8PEvkxh8tvyAvXsCP0h+GQ2inuf71VkoWdzS15aUjc5gfqxZa7aeeJnFjAIV+/yGtSygdEdz2Lh0gc1oQlm+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:26:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 08:26:49 +0000
Message-ID: <397ee8b6-13ee-403d-b664-f86143f7c622@amd.com>
Date: Mon, 16 Mar 2026 09:26:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Make emit_vm_flush() check explicit in
 amdgpu_vm_flush()
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20260315065528.1932950-1-srinivasan.shanmugam@amd.com>
 <bb50bb58-4101-4908-aec4-be7003321f79@amd.com>
 <IA0PR12MB8208E15658F04F7E3A6A345B9040A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB8208E15658F04F7E3A6A345B9040A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:408:ec::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2037ee-4e03-4868-959e-08de8335c4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: HlKDqc+hpXqnv64jXCLjLDoVs8zthVyfBybKTB4O4HeWjRvahdaNdDXLNCpO30Yo8VteI80lXtwVz/c4IInI3ZbDbUATa9mPUUxB0+Zjkw585phYqaazKcSwYDSb2LPdcrYByq0vei1whmtErcOcx5kvO9yIJpp2AFw0AWrodjtnQn7LISsWNPe4VUIKOcLwMuonkhlve40DH7NfVDVSWjV0AVfWodyBkshlpk9nByz8x5RwIECPr9hb6ENNfwWYCSrrg3X1obwhqtH/LiJotk2oAPjhQCL6/rikv5QTPHTQdvojB0xlcTV4eVuAwKxZraeL9N7FQsecbOvy+o+L/TKat0O8lW2HcXBWz6Ws68JJ9LRbmSoova/eyEodU8LsF4uu5tCIo7FubczQa37BFnkAAQJ+eOichDHn7XL1vOIOGsf7phtBAN7cs5/1Q/w+rvKxXlUTtlIOwdR+5ObMPv3B5bBqY9CgyMFx6LfI2G8gyCutTKkqcdHDPIgpoKMaFcuxBBQHDADgzV2hm67ln+hEUlE1k1ocUdPnmNeaKpmmu6kEA5YVKrPR3vOasQALk66A0cJ7AaoRhLEZm87kDJIKp0gX4EJs+M6+TvPjcrLg7uN0vGIuxQ2vZnJPAHEnyRmKtOsGyQ/acyHLJnKEN36sfB7mOjjTSAHlYfASUqZL+au441u4YMsS3bzmUaJUC18YdnlLxcrg9jN2EZEVdsjw06oJaXQ22opi+VnHAwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJuZmpiZjk4T0lVTU1BeUhSN2p2disvcllDRWpRS01EQjZ1TlZOT1hDUkpF?=
 =?utf-8?B?VU1sVUdpVk5DRUthalF3aFAycHN6cS9GTzR4cTFaQ3JuaW9JWnRaSjFmT3d5?=
 =?utf-8?B?UEhmV0pHQ2ZYTytwQ2dVYk5Cc3FmY1lTOUdYS0pVTmYrQ29NUXBObitMNy9r?=
 =?utf-8?B?dTZDMUh0cDNnbW0vNTI5V21IaWhTZllLb3FSYlRZYmVlOXlSeXVOdlFoODN3?=
 =?utf-8?B?UjBZNSszTTkxZTluWVRJTVhkNFVOa3ZvWVBJa1ArMWZURWF3c256RldKMWE2?=
 =?utf-8?B?ZEVlYTYrKzlHYlhsTldybUxBY1R0WUIzbDZyL1dYby9jSTFzTE9WZHBZT1pm?=
 =?utf-8?B?M29vQ0RkbTR2ZFdXSmphejBwQzhvUkMrL25rSnhMSmdzYlZOWUV2M0laVXlm?=
 =?utf-8?B?dlQ3VGUvRTZmK2x4NHpVWjFtY2FMenMvNDRRUnRqejB2VmpzMWI1ZDZoTnRo?=
 =?utf-8?B?bWIvbTQ4VHNkNGRnM0RnTDZsZDU0L2ljdXFSU0dacmhSaUFhL2NQQWRtRVRp?=
 =?utf-8?B?WWU4K3d6OVZkZ01lUjdmVVQycWR3aFNONnArRVlsRDBjajNEbmJNTnFCbWMw?=
 =?utf-8?B?S2NaM3huQm5IMGhCRmY5YTJXNjZpVTUwbVZpVXdDOTFWaGtYdzlmWEw1eUpT?=
 =?utf-8?B?Y2QrZ0kzN2p1LzNCbTZCQ3grdG5HV1pVRkIwRHBNdjg5bWM1VkxPdkV2UUdG?=
 =?utf-8?B?cGpHUnhmcENkK0pka0lwOUFzK0pEbTZTWlo2QmhtUWp1OEJjL1d5SzBvYS9u?=
 =?utf-8?B?Rm5aNnovRE1jcWhyTExpN2ZveHNjWlhUWlR0RlZWZnlGM0N2MEhYcVA3VXM4?=
 =?utf-8?B?S3liaG5oQmRoRVVRSncyTzhDRmJPdHNWNTI0SEhxMG5CYzliRG5iSDM0Tjk0?=
 =?utf-8?B?TGt4VU8wUUtBMjdoeDc0anRveXZvU1dGelBDQlkwMStkSVQ2b1lQeU1NUXNS?=
 =?utf-8?B?U0R0a2lscERvTFR5MkM4VDhXRmI3NENhSTd6UkZKN1pLRHVmUUsvM3IwNGFH?=
 =?utf-8?B?ZU5MVG9RbnZ2UjNKTUd1SnJZOUJrbGhHV3kvRTQ1M05rVDFJUUZlZUVnaWJP?=
 =?utf-8?B?cVBCQXhUb2VtN2FST002bjhUaWl3S2RLNGZLSm80Q2wvMSttNE9KbDltM1hV?=
 =?utf-8?B?K3JtK212aWw5ZlhFU05keUJCZkh6azlYZVJDMVVVV1NBOFFVR0NqNlNKYlJS?=
 =?utf-8?B?ZGc0WU5qSCttWkR0YzduL2JFOEpRZlJoaG96dzQ0VE1RbU9SUzB5Y2N4ODFu?=
 =?utf-8?B?UGJEcWl4R1pxMG9lZG1jcTdzYWlNQWlOMnB0Y1ZEa2hvalpBRnVrWnBmTHdI?=
 =?utf-8?B?TkZOTDhxNVFpSW9yWHQ2YkNWZXExYStxTzRRUENMclNzdHdxYXpjai9qWDk1?=
 =?utf-8?B?V212REZrVkN5WWJOZlpyMDU2YTVUUzBFMzhBTkl5QjkwRVRPdmdVaGVGUlpD?=
 =?utf-8?B?TFRyOTU5eERFK2Zsbm9IL0NHVy9aOU1IQ0syYkFYRlRobjcxRGx1WGFlamY0?=
 =?utf-8?B?eGdUWWc4enFrZ2Z6VXk2b3dyWkRpcmhkZnpRVlFoU1ROMzN3LzRZUXc3Tzg1?=
 =?utf-8?B?TTJyV1FoVVAxcHhMaHJvbHNBR1RzbE82QW90YjJ3ckM2dS9xMktEM1hCKzZl?=
 =?utf-8?B?Rkd6MFB0ZUpreDZsNDFkVFVGWllHNjVUbThoZTZyckR1SjA1b25qc0xaVUNo?=
 =?utf-8?B?bW1yejBtdU9hSFhMMzFLMytzTERmL1Vadi9GTWtPb3JZSzZEeXU3ZHpCdzI0?=
 =?utf-8?B?d3Qrdjd2ek1XZ1VKTEhCV21Rcy9VMlJSTmcrSXJXYTRXbFIvN2JNdWN0ZWdS?=
 =?utf-8?B?NXZTMkpUQ1BSSUc3SEtvei9iNjFMd3daOGN1WlBiN0JwY3lEcjFrYW0vak5L?=
 =?utf-8?B?ZXpLK2F0VVpEb3E2NjNyTUdhOHFYTjBwVkhZYm9iRkgzcWVhNUdPSWlpMlF3?=
 =?utf-8?B?YlB4aU5oRWFzUXR2TDJRUkdzNGFWN1JhZEd2NzY3K1NpR3kyY3pWVktZclBR?=
 =?utf-8?B?TE9WSUVUUGRBQllpL1ZmSzZNWVhHN1hFb1RHWkhBS1VIWEIyWDgvUE16eEV0?=
 =?utf-8?B?SXFVUGxoQzdmRHFWa0xTRVdLL3RET0NHREZvbGM3OVAxelR6THNHOGxDYS9h?=
 =?utf-8?B?M0JJNGlLa2R3QVZKRzJKM05TelBDeDRycHhyNEhkWlVFWHRoV2ZGOENmS2RF?=
 =?utf-8?B?aE90WVlrYmI4ZDJRTVVvNFMweXhlTzIxWThQQ2E3amRFc2o3Q2tzb0QreE1q?=
 =?utf-8?B?T2t1MTJ0cCtEU3hkVzd6VERHZXBsYi8ycGZiVFdTcmE5dVMzc3ZhdGowSUlB?=
 =?utf-8?Q?8tX30WNM/M0VG8YGXP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2037ee-4e03-4868-959e-08de8335c4d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:26:49.3418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8VzVT6pU8WNch+WGMHmtfmL51NMb222GKwQ5VHyqpYkMSHYuPOSG2dzhpJ2c1gk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

On 3/16/26 08:04, SHANMUGAM, SRINIVASAN wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, March 16, 2026 12:19 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Dan Carpenter <dan.carpenter@linaro.org>;
>> Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Make emit_vm_flush() check explicit in
>> amdgpu_vm_flush()
>>
>>
>>
>> On 15-Mar-26 12:25 PM, Srinivasan Shanmugam wrote:
>>> amdgpu_vm_flush() sends commands to the GPU to update the VM page
>>> tables for a job.
>>>
>>> When a job uses a GPU virtual address space, the GPU needs to refresh
>>> its address translations after the driver updates the page tables.
>>> A VM flush tells the GPU to forget old address translations and use
>>> the updated page table mappings.
>>>
>>> This flush command is not supported on all rings. Only rings that
>>> implement the emit_vm_flush() callback know how to emit the correct
>>> hardware command for this operation.
>>>
>>> The function already gates vm_flush_needed on the presence of
>>> ring->funcs->emit_vm_flush earlier in the logic. However, static
>>> analysis tools such as Smatch may not track this relationship through
>>> the vm_flush_needed boolean and warn that emit_vm_flush() could be
>>> NULL when the VM flush command is emitted later.
>>>
>>> Fixes the below:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:826 amdgpu_vm_flush() error: we
>>> previously assumed 'ring->funcs->emit_vm_flush' could be null (see
>>> line 788)
>>>
>>
>> I think the code logic is correct and the check is implicit in vm_flush_needed. We
>> don't need to write code to eliminate 'false warnings'. Moreover, it is inappropriate to
>> use a Fixes tag for this.
> 
> 
> My initial thought was that the earlier gating of vm_flush_needed on
> ring->funcs->emit_vm_flush would make the later call safe, but Smatch
> still reports the following warning:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:826 amdgpu_vm_flush()
> error: we previously assumed 'ring->funcs->emit_vm_flush' could be null

Yeah that looks like smatch is either not analyzing the code correctly or we are missing something.

Regards,
Christian.

> 
> Dan, could you please confirm whether this is expected to be a false
> positive from Smatch due to the vm_flush_needed boolean, or if there
> is a recommended pattern to help Smatch track this relationship?
> 
> Best regards,
> Srini
> 
>>
>> Thanks,
>> Lijo

