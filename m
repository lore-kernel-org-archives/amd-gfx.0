Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E62ACA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B253410FFD4;
	Fri,  9 Oct 2026 09:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RdycRIoN";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D412810FFD4
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6HZvu4kZWGKReS5JCWdRKTVoTl10Pd1dp810hgfuKflAMN2mKpgNonxhO/OFWSaZ0eLec6njQD7ZtIBbakSaNA8rsfQbkJ78ZyOcdP1vWobvF+Y+C1Qbr2DslKi9ezHr7ZCuOe5rDjzcLLuntMi9HKczHaFjqy7fC0q9aWdcJsOSj6bMT9F8vYA6CIhoLMwr+eGA/MXR0m5OyDxkx3ufn5yqKAtPpYizXV/MJ57Ru+NsuSDk2NQE2NSlQhVEVLVjXnRjY7EnwtF3d7SuyirC+2132WDh1qgncc1Nl1+2Oehc+jtF5CGLA3NtpFPyuHwslH4pnNS7LmNPjkMDuf54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9vWnL75pnYREnmedezZs4PH7I6DRBhHQyF9POXzUho=;
 b=E6t5kmesovrmj6suS2jJUSCmVGtmvcLdKQD35poIMeNO7hSG3rGC3hZzQXID5TtXHRa1Ky6IIrHG3R1dNM6gQHPTndwCX6UOOhuZhx88BxDqNZJSg8zbcDvg42pRJM1iGfzpvo9xAYf4e9nVzm9x3MempmFi2tm6efefe1XP5cEc6EoPMkWIWZa8Z0WG4xvoXjyLsI2OdsgBzntsK2hxP4q6n92NZk0gjnL8Iea/YfrLiQsQ6+BUuxiwSVgwQcRzSMEoL6E36AlXTG4DFXeo6J+nmY97BvudIMFNCVJrk3h+n1X3AnaVkCZnhUw+EvwT3ObiXFlGY9Tv5peqBPkqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9vWnL75pnYREnmedezZs4PH7I6DRBhHQyF9POXzUho=;
 b=RdycRIoNPrXQx0n2iTEpdIFM3Y4qBCI5CWPtrgYHIZ7yW4LBLyKC1Qy6DxghMM6fKbA3JOfdeysNo73lcZy0EbsW+3errSTdz6suoEUn4AY+90cQJz8YC24/Tceijdteh0op0H2shMB+F8qdtAXv7p3WG/y+kX+pmRZZ9O2nkWg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:15:12 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0472.015; Fri, 9 Oct 2026
 09:15:12 +0000
Content-Type: multipart/alternative;
 boundary="------------XuGfjKgufZAy7H5mE3W9kYds"
Message-ID: <78d2ad01-0b3c-40c6-86c0-ff1bb28517e7@amd.com>
Date: Fri, 9 Oct 2026 14:45:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: store the user-queue VMID mask instead
 of first_kfd_vmid
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261009081732.3505820-1-sunil.khatri@amd.com>
 <dfc79fa7-a3bc-43a2-b060-e06410491768@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <dfc79fa7-a3bc-43a2-b060-e06410491768@amd.com>
X-ClientProxiedBy: MA5P287CA0028.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::12) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 673517ee-4271-420a-1c56-08df25e5d285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|8096899003|3023799007;
X-Microsoft-Antispam-Message-Info: A0P6z58T2vuxpjJ2xcVmoQ5KMqKKUbiy8TOdhvVbYrywraLJCfWXt2Bq8Syzp1T0zFWGu8HnW/zgb8HUQAogDu0KOueWiFAPyucOpCKBgcvIwt2ucimyH1yG6neJgYH4/US6C4pIgwcDANITZs4Kr0MK9NiAjfjSZYuQnSaG73XSvQtJlp+kOcnKlGNv7MKesFweSnMo5n3ChTPp4nsYmPylHEyAB8VenIht85o+GvsddAtZ48U5OLTYK0OLsz7h+n69wfauIRHkqZSYy1zOGOH1JMdBL7vcBcRHjegsrI3byshL7RUlwmLVkMkwWu99Z52w8+Tt5d/ostE4xwZJkqo0NDY9hiKdy3fq1VuaUJErlbVD+wSoNsJQUPur8FR02hkIo/MGcrpq2O821JaODTNNv4DhzAfq7v6ng4q90S6BPov6IBNASIjyeybY64jGAcOuh20Yi03CQbCPx6+ucbavSq37gtPUnF+LxKSrTrr9l5YcjLPjh85qc7Rt0xYUhgbtqnco8I4EUWr9fkZDpjOSk9Fz5uA6pNqSAR3D5qZturH0276XFpbr3148jZOCVZfWwXFJzVp9F59cOBpwhzj4OsnOdDEBi3YxEc5Md8uTv4TOIs9b8IA3gnRh+3p7NOx6B0iyiQw6xDfPXSBANGOCUuvWmyXWkhqFIujYVk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(8096899003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRhV1dmUXJuL1pOS3RtZHhBRVJ6aGN4VWYrWFRlTkJrSFRCL2pvUFNkNXZy?=
 =?utf-8?B?WVVpWExqRHNLZEl5TUNjOVhsTld0bithd052OStqNEh3WGNWQTdQSVFlRGNa?=
 =?utf-8?B?WHJkRTE0czRLaE9vU1o1WVM2dEFlNXl3ZXhiSU5YdEFlbUpzZTRLT3FKNWNn?=
 =?utf-8?B?Z0hpcDlKQVRuN2FROTc1U1FhWkdKV0tJakUzRHJIL2w0cXhzbGlSYzh4Zmho?=
 =?utf-8?B?SDE1M045dU12V2cwdmU1cWJHZCs4dmxuKytRQUhIZ1YvaUtUa1Z2aTB6SkhR?=
 =?utf-8?B?Mmw3Z1c3UU9peWxMdGxSVnluZmdod2xadWo2djdyTnlPNjBhbkR6SU1XRG9s?=
 =?utf-8?B?ZFkxeHJWcE9UWmRNTlhvNTNRZWdFblMyRElEVHhncUh1RCtnK2NGS04zWkU3?=
 =?utf-8?B?ZlRxYXZRYW1seHlWbEJORG9SbDZrZExETTlsQTF6RjJGM2RXdjI4Q3dCQnJI?=
 =?utf-8?B?T09VWElCSStwM3F2R2FMaWJLdFlQczlOOG15Mkd6d1dvV3FJMnZ1RzFxSFRO?=
 =?utf-8?B?aENDVmlEbVNsZGZ6Q1Q4eHhldUpSNTA1eVNYWmsyQzhIY3pyQk45OFBOeW90?=
 =?utf-8?B?RWZMNjZRd3FXTlJnTFlpK1ZkQklNOVh2QklCRzFiVlplclc3L21GQkpob2ky?=
 =?utf-8?B?bExGSG1RRkl2b3U5TDV6VzRaRVVWMkFHd3Jva2hHUEl3KzdLcWZmcjhVcTFQ?=
 =?utf-8?B?OFRQaEgxZEhlbGlseThrQ3ZwRnhKc1QzbENJdTJGUEZCUU9VYTFCZEhWSkxT?=
 =?utf-8?B?akYrVGltM0lpUTg0SWJjblo5Tk1jbHpsTHcvRHIzd29MYXNFWmdPOUkzK0NP?=
 =?utf-8?B?TzN1RGFFVVFPTHpPL3ZPeFgvZWt5YmcwVkZUdGcvVXNhcElWRTQyaTF1bnZa?=
 =?utf-8?B?MnU5WjdlL1I5eTdvOG8zN2x3YWpuYmdIQnVDelhXclJMRWlodWJXcWRVTE9P?=
 =?utf-8?B?Nm5aM1VQVVBJTkhtcjRYN0xTWGczNHBnQkRHL0Q1Z0xrYlZnZ2dnaWJOR1pD?=
 =?utf-8?B?ZWl2NzlRUHdlbDZpZ3o1c1FDWDB0NlBKRVpmdHdCMktHaVRPcGhFWXFoVFNm?=
 =?utf-8?B?WTQ3bVF4THBoSjVYK2F6NzdmYjhOOS9PekRmeTRVRi9rTlNudEFhOHRPU0xn?=
 =?utf-8?B?amlicVJ2M09kUHVuWXF2VE9tL2drYWVUU0tsRWZ6Skh6RmpGSWFIczZ5QllT?=
 =?utf-8?B?Rmc4Qm11MXRsYmFwVVlkeEg2TkFicGpCbWxTVzl2aVgxL0V3QTQzY3ZzSjdw?=
 =?utf-8?B?dFpSK2pCbzBCOUxiZFRKRTBGSzRheGNPekN2bmdZbHRNUHBaQjlHR1VRendW?=
 =?utf-8?B?WHlaMGJEZTRCdXBHcFhtT0p0REd4UU9YK2YwR3E1bzUxenBxRUxYT3ZoUTg1?=
 =?utf-8?B?ZEtqK3FDdXFCSnU5RTMxUjloeGFVa210RzA3S3B4VXhHWVpyTTl3ZVlacUk3?=
 =?utf-8?B?RGEzTitRU1hCUy9NNUNhWlBHVkp3RU9MVG9aRjZUY2xPQk5Uc3VldnUrdWRT?=
 =?utf-8?B?RmZIMjNGQXYydDR5cnQ1enNxdStrcjVpMHR4SEt4b3hKYXJBanpjbzh1bTNC?=
 =?utf-8?B?N0RvWlZYTWdGNGdHdHV2MFQwcVJxL2xzMWpiUHVsQXl6R3l4aEJIbXhnUkda?=
 =?utf-8?B?SVZxY0FFQVpFMVMrUlh1eVVhUmdWaFhqTW5NanlQMWhmcWIwN3FQVXBOL1Vt?=
 =?utf-8?B?bkh0WlBtU0ppYzY1eEkyUVhWenAwQWoraGVaKzFITzhla1pUZFdwOHZYWjRV?=
 =?utf-8?B?dUxITU94aDc4ZmNxNm5pRklLUnlwY0Q3aE9BbzJPL1F0VnV5QzVQZEhPUzda?=
 =?utf-8?B?SHNxengzSVVXYUlMa2R1Um1HMjBwaEFPN3FhRk9TN1ZvWG1wVW5aNXRYSFlj?=
 =?utf-8?B?RzRGTUpIak1EajNjc0pOejFCNEE5amRhV0NJUW5SRVhvTDd3NjE3NFlSOGxB?=
 =?utf-8?B?N3pBNFpsVGZNbzlSWEdMY2VXSkhvdWF0bnljT0F6eHE1MmNMYlkwQnZRUkMv?=
 =?utf-8?B?d2lCRnpUL2ZNYnFoelR1RFVab3A3UUw2TDN4TVI2aEFWeTdYMGg2cmdIWi9s?=
 =?utf-8?B?akVzYi9wcUNuTDRydVo0NWY4Z2VYVUdzalJQY3BJYWx4R21JRFJNOWNuVjdR?=
 =?utf-8?B?a2xtSkcwV2dJdlVqYWk1ckI0dUN3bWI3VnBlUHlraTRSdEIyWmdTN0N1Q1dO?=
 =?utf-8?B?WFEzRi9ib2dYclkvM0RtQS9jLzFZMjJnN0J3dW56U2kyT25GeVdNSmVFZHM1?=
 =?utf-8?B?cW9VeW9XcGFyZ05rSkk0a1VacU42N2hRTmVIRWxvcnpibHBjMWxuZk1XQWRN?=
 =?utf-8?B?dHNNVElnb3hnZlh5alZWeWU5ZzdNUnJjVHluSVpmYVZRckN4NVZEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673517ee-4271-420a-1c56-08df25e5d285
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:15:12.1790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFO4dhFnFhPV05FPBvX9lJjin+dvLqevSQGEY6Boi0xnQ4eJ3+4PcOxIj6Q2FHp5WMLJDfNkUmrSpdR08ysjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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

--------------XuGfjKgufZAy7H5mE3W9kYds
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09-10-2026 02:14 pm, Christian König wrote:
> On 10/9/26 10:17, Sunil Khatri wrote:
>> first_kfd_vmid only ever existed to be turned back into a mask
>> (directly, or via range loops over VMIDs). Drop it and have each
>> generation set vmid_uq_mask_gfxhub directly instead, add
>> for_each_uq_vmid() to replace the range loops, and mask-test it in
>> amdgpu_amdkfd_is_kfd_vmid().
>>
>> Assisted-by:Claude:claude-sonnet-5
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 41 +++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    | 16 +++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 -
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++-------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 20 ++++-------
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    |  6 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h    |  3 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 10 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 11 +++---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 20 +++++------
>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 14 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 14 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 14 ++++----
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 18 +++++-----
>>   21 files changed, 119 insertions(+), 109 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 3391e8c77f13b..e023cc734ebc4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
>>   {
>>   	if (adev->kfd.dev)
>> -		return vmid >= adev->vm_manager.first_kfd_vmid;
>> +		return !!(adev->vm_manager.vmid_uq_mask_gfxhub & BIT(vmid));
>>   
>>   	return false;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 9cdd8870960a6..55d6b2107d8f9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -630,6 +630,21 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>>   	}
>>   }
>>   
>> +/**
>> + * amdgpu_vmid_mgr_set_vmid_mask - set the kernel-queue VMID pool for a
>> + * hub, and the matching user-queue mask on MMHUB
>> + *
>> + * @adev: amdgpu device structure
>> + * @vmid_mask: kernel-queue round-robin VMID mask for this hub
>> + * @for_mmhub: true to target MMHUB instances, false for GFXHUB
>> + *
>> + * On MMHUB, also sets vmid_uq_mask_mmhub to the fixed pool of VMIDs
>> + * MES/KFD use there, excluding npa_vmid (a VMID dedicated to a single
>> + * fixed purpose) from both the kernel- and user-queue masks; the
>> + * caller must already have set npa_vmid. vmid_uq_mask_gfxhub is set
>> + * directly by each generation's sw_init(), since unlike MMHUB's it
>> + * varies per generation.
>> + */
>>   void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>>   				   unsigned long vmid_mask, bool for_mmhub)
>>   {
>> @@ -637,6 +652,9 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>>   
>>   	BUILD_BUG_ON(AMDGPU_NUM_VMID > BITS_PER_LONG);
>>   
>> +	if (for_mmhub && adev->vm_manager.npa_vmid)
>> +		vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
>> +
>>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
>>   		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
>>   
>> @@ -644,22 +662,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
>>   			bitmap_copy(adev->vm_manager.id_mgr[i].vmid_mask,
>>   				    &vmid_mask, AMDGPU_NUM_VMID);
>>   	}
>> -}
>>   
>> -/**
>> - * amdgpu_vmid_uq_mask_init - init the user queue VMID masks
>> - *
>> - * @adev: amdgpu_device pointer
>> - *
>> - * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
>> - * first_kfd_vmid, shared by KFD and MES user queues.
>> - */
>> -static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
>> -{
>> -	adev->vm_manager.vmid_uq_mask_gfxhub =
>> -		((1U << AMDGPU_NUM_VMID) - 1) &
>> -		~((1U << adev->vm_manager.first_kfd_vmid) - 1);
>> -	adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
>> +	if (for_mmhub) {
>> +		adev->vm_manager.vmid_uq_mask_mmhub = 0xFF00;
>> +		if (adev->vm_manager.npa_vmid)
>> +			adev->vm_manager.vmid_uq_mask_mmhub &=
>> +				~BIT(adev->vm_manager.npa_vmid);
>> +	}
>>   }
>>   
>>   /**
>> @@ -673,8 +682,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>>   {
>>   	unsigned i, j;
>>   
>> -	amdgpu_vmid_uq_mask_init(adev);
>> -
>>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; ++i) {
>>   		struct amdgpu_kq_vmid_mgr *id_mgr =
>>   			&adev->vm_manager.id_mgr[i];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> index 21d6a41d1738a..9bfc7a950ca31 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> @@ -56,6 +56,22 @@
>>   	     __vmid_mask; __vmid_mask = 0)				\
>>   		for_each_set_bit((vmid), &__vmid_mask, AMDGPU_NUM_VMID)
>>   
>> +/**
>> + * for_each_uq_vmid - iterate over every VMID set in vmid_uq_mask_gfxhub
>> + * @vmid:	loop cursor (int / unsigned int)
>> + * @adev:	struct amdgpu_device *
>> + *
>> + * Equivalent to walking adev->vm_manager.vmid_uq_mask_gfxhub with
>> + * for_each_set_bit().
>> + *
>> + * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long.
>> + */
>> +#define for_each_uq_vmid(vmid, adev)					\
> Maybe name that for_each_uq_gfx_vmid().
Sure Christian.
>
>> +	for (unsigned long __uq_vmid_mask =				\
>> +		(adev)->vm_manager.vmid_uq_mask_gfxhub;		\
>> +	     __uq_vmid_mask; __uq_vmid_mask = 0)			\
>> +		for_each_set_bit((vmid), &__uq_vmid_mask, AMDGPU_NUM_VMID)
>> +
>>   struct amdgpu_device;
>>   struct amdgpu_fpriv;
>>   struct amdgpu_vm;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8e478d3bda1ac..d99e42ca308ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -383,7 +383,6 @@ struct amdgpu_vm {
>>   struct amdgpu_vm_manager {
>>   	/* Handling of VMIDs */
>>   	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
>> -	unsigned int				first_kfd_vmid;
>>   	bool					concurrent_flush;
>>   
>>   	uint64_t				max_pfn;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 33403e16df5ca..cf7d0dd3c12d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -5178,19 +5178,12 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
>>   #define DEFAULT_SH_MEM_BASES	(0x6000)
>>   
>>   static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device *adev,
>> -				uint32_t first_vmid,
>> -				uint32_t last_vmid)
>> +				uint32_t vmid_mask)
>>   {
>>   	uint32_t data;
>> -	uint32_t trap_config_vmid_mask = 0;
>> -	int i;
>> -
>> -	/* Calculate trap config vmid mask */
>> -	for (i = first_vmid; i < last_vmid; i++)
>> -		trap_config_vmid_mask |= (1 << i);
>>   
>>   	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
>> -			VMID_SEL, trap_config_vmid_mask);
>> +			VMID_SEL, vmid_mask);
>>   	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
>>   			TRAP_EN, 1);
>>   	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
>> @@ -5214,7 +5207,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>>   	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		nv_grbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>> @@ -5227,15 +5220,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	 * access. These should be enabled by FW for target VMIDs.
>>   	 */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>>   	}
>>   
>> -	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
>> -					AMDGPU_NUM_VMID);
>> +	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.vmid_uq_mask_gfxhub);
>>   }
>>   
>>   static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index d5f428ac19bf3..42bc2ab1b9032 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SCRATCH_APP_BASE;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		soc21_grbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>> @@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	 * access. These should be enabled by FW for target VMIDs.
>>   	 */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 420ce997bebc7..435bceba7a834 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SCRATCH_APP_BASE;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		soc24_grbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> index 4498e253846f1..d4fa4c7c16acf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> @@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>   	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>>   		/* CP and shaders */
>>   		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 549d1239e326b..61983c7141e11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>   	sh_mem_config |= MTYPE_NONCACHED << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		cik_srbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
>> @@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
>>   
>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	   access. These should be enabled by FW for target VMIDs. */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>>   		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>>   		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index ab4123ddbb942..16e634e0d2c1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		vi_srbm_select(adev, 0, 0, 0, i);
>>   		/* CP and shaders */
>>   		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
>> @@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
>>   
>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	   access. These should be enabled by FW for target VMIDs. */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>>   		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>>   		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1678015ce5a97..6c44bfc93d1a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -2568,19 +2568,12 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>>   }
>>   
>>   static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
>> -				uint32_t first_vmid,
>> -				uint32_t last_vmid)
>> +				uint32_t vmid_mask)
>>   {
>>   	uint32_t data;
>> -	uint32_t trap_config_vmid_mask = 0;
>> -	int i;
>> -
>> -	/* Calculate trap config vmid mask */
>> -	for (i = first_vmid; i < last_vmid; i++)
>> -		trap_config_vmid_mask |= (1 << i);
>>   
>>   	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
>> -			VMID_SEL, trap_config_vmid_mask);
>> +			VMID_SEL, vmid_mask);
>>   	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
>>   			TRAP_EN, 1);
>>   	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
>> @@ -2610,7 +2603,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		soc15_grbm_select(adev, 0, 0, 0, i, 0);
>>   		/* CP and shaders */
>>   		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
>> @@ -2621,7 +2614,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>>   
>>   	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	   access. These should be enabled by FW for target VMIDs. */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>> @@ -4932,11 +4925,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>>   		return r;
>>   
>>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
>> -		gfx_v9_4_2_debug_trap_config_init(adev,
>> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
>> +		gfx_v9_4_2_debug_trap_config_init(adev);
>>   	else
>>   		gfx_v9_0_debug_trap_config_init(adev,
>> -			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
>> +			adev->vm_manager.vmid_uq_mask_gfxhub);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
>> index 54bcb5fdca242..e84426b6a1a8e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
>> @@ -836,16 +836,14 @@ void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
>>   	}
>>   }
>>   
>> -void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
>> -				uint32_t first_vmid,
>> -				uint32_t last_vmid)
>> +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev)
>>   {
>>   	uint32_t data;
>>   	int i;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>>   
>> -	for (i = first_vmid; i < last_vmid; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		data = 0;
>>   		soc15_grbm_select(adev, 0, 0, 0, i, 0);
>>   		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
>> index c8757de669eaa..ca240f4298da6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
>> @@ -24,8 +24,7 @@
>>   #ifndef __GFX_V9_4_2_H__
>>   #define __GFX_V9_4_2_H__
>>   
>> -void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
>> -				uint32_t first_vmid, uint32_t last_vmid);
>> +void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev);
>>   void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
>>   				      uint32_t die_id);
>>   void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 01ed1701c781a..8555e64977348 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>   			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
>>   
>>   	mutex_lock(&adev->srbm_mutex);
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
>>   		/* CP and shaders */
>>   		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
>> @@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
>>   	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
>>   	 * access. These should be enabled by FW for target VMIDs.
>>   	 */
>> -	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
>> +	for_each_uq_vmid(i, adev) {
>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
>>   		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 490b4c4eb662a..a95bfe22c640e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -746,6 +746,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>   	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>>   	struct amdgpu_device *adev = ip_block->adev;
>> +	unsigned long gfx_vmid_mask;
>>   
>>   	adev->gfxhub.funcs->init(adev);
>>   
>> @@ -869,10 +870,11 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = 8;
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      false);
>> +	gfx_vmid_mask = GENMASK(7, 1);
>> +
>> +	adev->vm_manager.vmid_uq_mask_gfxhub =
>> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>>   
>>   	amdgpu_vm_manager_init(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 3cdc7893587a1..7b19c59a2f743 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -745,6 +745,8 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>   	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
>>   	struct amdgpu_device *adev = ip_block->adev;
>> +	unsigned int first_userq_vmid;
>> +	unsigned long gfx_vmid_mask;
>>   
>>   	adev->mmhub.funcs->init(adev);
>>   
>> @@ -854,11 +856,12 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
>> +	first_userq_vmid = adev->gfx.disable_kq ? 1 : 8;
>> +	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
>>   
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      false);
>> +	adev->vm_manager.vmid_uq_mask_gfxhub =
>> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
>>   
>>   	amdgpu_vm_manager_init(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> index fcc1d580fa946..9194130c25f29 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -849,6 +849,8 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	struct amdgpu_device *adev = ip_block->adev;
>>   	uint64_t pte_addr_mask = 0;
>>   	u32 mmhub_vmid_mask;
>> +	unsigned int first_userq_vmid;
>> +	unsigned long gfx_vmid_mask;
>>   	int i;
>>   
>>   	adev->mmhub.funcs->init(adev);
>> @@ -997,26 +999,24 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 */
>>   	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
>>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
>> -		adev->vm_manager.first_kfd_vmid = 3;
>> +		first_userq_vmid = 3;
>>   		adev->vm_manager.npa_vmid = 15;
>> -		mmhub_vmid_mask &= ~BIT(adev->vm_manager.npa_vmid);
>>   	} else {
>> -		adev->vm_manager.first_kfd_vmid = 8;
>> +		first_userq_vmid = 8;
>>   	}
>>   
>>   	if (adev->gfx.disable_kq)
>> -		adev->vm_manager.first_kfd_vmid = 1;
>> +		first_userq_vmid = 1;
>>   
>> +	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
>> +
>> +	adev->vm_manager.vmid_uq_mask_gfxhub =
>> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
>>   	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      false);
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>>   
>>   	amdgpu_vm_manager_init(adev);
>>   
>> -	if (adev->vm_manager.npa_vmid)
>> -		adev->vm_manager.vmid_uq_mask_mmhub &= ~BIT(adev->vm_manager.npa_vmid);
>> -
>>   	r = amdgpu_gmc_ras_sw_init(adev);
>>   	if (r)
>>   		return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> index 71409eb718d39..4e593e67221ff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -768,6 +768,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>   	int r;
>>   	struct amdgpu_device *adev = ip_block->adev;
>> +	unsigned long gfx_vmid_mask;
>>   
>>   	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>>   
>> @@ -824,13 +825,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = 8;
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      false);
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      true);
>> +	gfx_vmid_mask = GENMASK(7, 1);
> BTW I don't think we have KFD support for GFX/GMC v6-v8 any more. Not for this patch but we can probably drop that at some point.
>
> Apart from the nit pick above patch looks good to me.
>
Can you have a look at patch 2 also. If thats fine i will push v3 with suggested macro name change above...
Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> +
>> +	adev->vm_manager.vmid_uq_mask_gfxhub =
>> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
>>   	amdgpu_vm_manager_init(adev);
>>   
>>   	/* base offset of vram pages */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> index c95e097241bf8..bbb5c42b9d4ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> @@ -941,6 +941,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>   	int r;
>>   	struct amdgpu_device *adev = ip_block->adev;
>> +	unsigned long gfx_vmid_mask;
>>   
>>   	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>>   
>> @@ -1006,13 +1007,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = 8;
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      false);
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      true);
>> +	gfx_vmid_mask = GENMASK(7, 1);
>> +
>> +	adev->vm_manager.vmid_uq_mask_gfxhub =
>> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
>>   	amdgpu_vm_manager_init(adev);
>>   
>>   	/* base offset of vram pages */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 8d8a0775878ff..25d47d2c288dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -1051,6 +1051,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   {
>>   	int r;
>>   	struct amdgpu_device *adev = ip_block->adev;
>> +	unsigned long gfx_vmid_mask;
>>   
>>   	set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
>>   
>> @@ -1121,13 +1122,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	 * amdgpu graphics/compute will use VMIDs 1-7
>>   	 * amdkfd will use VMIDs 8-15
>>   	 */
>> -	adev->vm_manager.first_kfd_vmid = 8;
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      false);
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      true);
>> +	gfx_vmid_mask = GENMASK(7, 1);
>> +
>> +	adev->vm_manager.vmid_uq_mask_gfxhub =
>> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
>>   	amdgpu_vm_manager_init(adev);
>>   
>>   	/* base offset of vram pages */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 85ba228f002d0..7ebf7b1299ff6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1849,6 +1849,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
>>   	struct amdgpu_device *adev = ip_block->adev;
>>   	unsigned long inst_mask = adev->aid_mask;
>> +	unsigned int first_userq_vmid;
>> +	unsigned long gfx_vmid_mask;
>>   
>>   	adev->gfxhub.funcs->init(adev);
>>   
>> @@ -2030,21 +2032,21 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>   	    adev->jpeg.disable_kq &&
>>   	    adev->vcn.disable_kq &&
>>   	    adev->sdma.no_user_submission)
>> -		adev->vm_manager.first_kfd_vmid = 1;
>> +		first_userq_vmid = 1;
>>   	else
>> -		adev->vm_manager.first_kfd_vmid =
>> +		first_userq_vmid =
>>   			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
>>   			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
>>   			 amdgpu_is_multi_aid(adev)) ?
>>   			3 :
>>   			8;
>>   
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      false);
>> -	amdgpu_vmid_mgr_set_vmid_mask(adev,
>> -				      GENMASK(adev->vm_manager.first_kfd_vmid - 1, 1),
>> -				      true);
>> +	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
>> +
>> +	adev->vm_manager.vmid_uq_mask_gfxhub =
>> +		GENMASK(AMDGPU_NUM_VMID - 1, 1) & ~gfx_vmid_mask;
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
>> +	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
>>   	amdgpu_vm_manager_init(adev);
>>   
>>   	gmc_v9_0_save_registers(adev);
--------------XuGfjKgufZAy7H5mE3W9kYds
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 09-10-2026 02:14 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:dfc79fa7-a3bc-43a2-b060-e06410491768@amd.com">
      <pre wrap="" class="moz-quote-pre">On 10/9/26 10:17, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">first_kfd_vmid only ever existed to be turned back into a mask
(directly, or via range loops over VMIDs). Drop it and have each
generation set vmid_uq_mask_gfxhub directly instead, add
for_each_uq_vmid() to replace the range loops, and mask-test it in
amdgpu_amdkfd_is_kfd_vmid().

Assisted-by: <a class="moz-txt-link-freetext" href="Claude:claude-sonnet-5">Claude:claude-sonnet-5</a>
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 41 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h    | 16 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 20 ++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h    |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 10 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 11 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     | 20 +++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 18 +++++-----
 21 files changed, 119 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3391e8c77f13b..e023cc734ebc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -789,7 +789,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 {
 	if (adev-&gt;kfd.dev)
-		return vmid &gt;= adev-&gt;vm_manager.first_kfd_vmid;
+		return !!(adev-&gt;vm_manager.vmid_uq_mask_gfxhub &amp; BIT(vmid));
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9cdd8870960a6..55d6b2107d8f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -630,6 +630,21 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * amdgpu_vmid_mgr_set_vmid_mask - set the kernel-queue VMID pool for a
+ * hub, and the matching user-queue mask on MMHUB
+ *
+ * @adev: amdgpu device structure
+ * @vmid_mask: kernel-queue round-robin VMID mask for this hub
+ * @for_mmhub: true to target MMHUB instances, false for GFXHUB
+ *
+ * On MMHUB, also sets vmid_uq_mask_mmhub to the fixed pool of VMIDs
+ * MES/KFD use there, excluding npa_vmid (a VMID dedicated to a single
+ * fixed purpose) from both the kernel- and user-queue masks; the
+ * caller must already have set npa_vmid. vmid_uq_mask_gfxhub is set
+ * directly by each generation's sw_init(), since unlike MMHUB's it
+ * varies per generation.
+ */
 void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 				   unsigned long vmid_mask, bool for_mmhub)
 {
@@ -637,6 +652,9 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 
 	BUILD_BUG_ON(AMDGPU_NUM_VMID &gt; BITS_PER_LONG);
 
+	if (for_mmhub &amp;&amp; adev-&gt;vm_manager.npa_vmid)
+		vmid_mask &amp;= ~BIT(adev-&gt;vm_manager.npa_vmid);
+
 	for (i = 0; i &lt; AMDGPU_MAX_VMHUBS; i++) {
 		bool is_mmhub = AMDGPU_IS_MMHUB0(i) || AMDGPU_IS_MMHUB1(i);
 
@@ -644,22 +662,13 @@ void amdgpu_vmid_mgr_set_vmid_mask(struct amdgpu_device *adev,
 			bitmap_copy(adev-&gt;vm_manager.id_mgr[i].vmid_mask,
 				    &amp;vmid_mask, AMDGPU_NUM_VMID);
 	}
-}
 
-/**
- * amdgpu_vmid_uq_mask_init - init the user queue VMID masks
- *
- * @adev: amdgpu_device pointer
- *
- * Sets vmid_uq_mask_gfxhub/mmhub to the pool of VMIDs at or above
- * first_kfd_vmid, shared by KFD and MES user queues.
- */
-static void amdgpu_vmid_uq_mask_init(struct amdgpu_device *adev)
-{
-	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
-		((1U &lt;&lt; AMDGPU_NUM_VMID) - 1) &amp;
-		~((1U &lt;&lt; adev-&gt;vm_manager.first_kfd_vmid) - 1);
-	adev-&gt;vm_manager.vmid_uq_mask_mmhub = 0xFF00;
+	if (for_mmhub) {
+		adev-&gt;vm_manager.vmid_uq_mask_mmhub = 0xFF00;
+		if (adev-&gt;vm_manager.npa_vmid)
+			adev-&gt;vm_manager.vmid_uq_mask_mmhub &amp;=
+				~BIT(adev-&gt;vm_manager.npa_vmid);
+	}
 }
 
 /**
@@ -673,8 +682,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 {
 	unsigned i, j;
 
-	amdgpu_vmid_uq_mask_init(adev);
-
 	for (i = 0; i &lt; AMDGPU_MAX_VMHUBS; ++i) {
 		struct amdgpu_kq_vmid_mgr *id_mgr =
 			&amp;adev-&gt;vm_manager.id_mgr[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index 21d6a41d1738a..9bfc7a950ca31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -56,6 +56,22 @@
 	     __vmid_mask; __vmid_mask = 0)				\
 		for_each_set_bit((vmid), &amp;__vmid_mask, AMDGPU_NUM_VMID)
 
+/**
+ * for_each_uq_vmid - iterate over every VMID set in vmid_uq_mask_gfxhub
+ * @vmid:	loop cursor (int / unsigned int)
+ * @adev:	struct amdgpu_device *
+ *
+ * Equivalent to walking adev-&gt;vm_manager.vmid_uq_mask_gfxhub with
+ * for_each_set_bit().
+ *
+ * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long.
+ */
+#define for_each_uq_vmid(vmid, adev)					\
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Maybe name that for_each_uq_gfx_vmid().</pre>
    </blockquote>
    Sure Christian.
    <blockquote type="cite" cite="mid:dfc79fa7-a3bc-43a2-b060-e06410491768@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	for (unsigned long __uq_vmid_mask =				\
+		(adev)-&gt;vm_manager.vmid_uq_mask_gfxhub;		\
+	     __uq_vmid_mask; __uq_vmid_mask = 0)			\
+		for_each_set_bit((vmid), &amp;__uq_vmid_mask, AMDGPU_NUM_VMID)
+
 struct amdgpu_device;
 struct amdgpu_fpriv;
 struct amdgpu_vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1ac..d99e42ca308ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -383,7 +383,6 @@ struct amdgpu_vm {
 struct amdgpu_vm_manager {
 	/* Handling of VMIDs */
 	struct amdgpu_kq_vmid_mgr		id_mgr[AMDGPU_MAX_VMHUBS];
-	unsigned int				first_kfd_vmid;
 	bool					concurrent_flush;
 
 	uint64_t				max_pfn;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 33403e16df5ca..cf7d0dd3c12d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5178,19 +5178,12 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 #define DEFAULT_SH_MEM_BASES	(0x6000)
 
 static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid,
-				uint32_t last_vmid)
+				uint32_t vmid_mask)
 {
 	uint32_t data;
-	uint32_t trap_config_vmid_mask = 0;
-	int i;
-
-	/* Calculate trap config vmid mask */
-	for (i = first_vmid; i &lt; last_vmid; i++)
-		trap_config_vmid_mask |= (1 &lt;&lt; i);
 
 	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
-			VMID_SEL, trap_config_vmid_mask);
+			VMID_SEL, vmid_mask);
 	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
 			TRAP_EN, 1);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
@@ -5214,7 +5207,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES &lt;&lt; 16);
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -5227,15 +5220,14 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
 	}
 
-	gfx_v10_0_debug_trap_config_init(adev, adev-&gt;vm_manager.first_kfd_vmid,
-					AMDGPU_NUM_VMID);
+	gfx_v10_0_debug_trap_config_init(adev, adev-&gt;vm_manager.vmid_uq_mask_gfxhub);
 }
 
 static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d5f428ac19bf3..42bc2ab1b9032 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2167,7 +2167,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		soc21_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -2185,7 +2185,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 420ce997bebc7..435bceba7a834 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1808,7 +1808,7 @@ static void gfx_v12_0_init_compute_vmid(struct amdgpu_device *adev)
 			SCRATCH_APP_BASE;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		soc24_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4498e253846f1..d4fa4c7c16acf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1540,7 +1540,7 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	sh_mem_config = gfx_v12_1_get_sh_mem_config(adev);
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		soc_v1_0_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 549d1239e326b..61983c7141e11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1837,7 +1837,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 	sh_mem_config |= MTYPE_NONCACHED &lt;&lt; SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		cik_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -1850,7 +1850,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ab4123ddbb942..16e634e0d2c1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3682,7 +3682,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -3695,7 +3695,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1678015ce5a97..6c44bfc93d1a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2568,19 +2568,12 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid,
-				uint32_t last_vmid)
+				uint32_t vmid_mask)
 {
 	uint32_t data;
-	uint32_t trap_config_vmid_mask = 0;
-	int i;
-
-	/* Calculate trap config vmid mask */
-	for (i = first_vmid; i &lt; last_vmid; i++)
-		trap_config_vmid_mask |= (1 &lt;&lt; i);
 
 	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
-			VMID_SEL, trap_config_vmid_mask);
+			VMID_SEL, vmid_mask);
 	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
 			TRAP_EN, 1);
 	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
@@ -2610,7 +2603,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
@@ -2621,7 +2614,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   access. These should be enabled by FW for target VMIDs. */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
@@ -4932,11 +4925,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
-		gfx_v9_4_2_debug_trap_config_init(adev,
-			adev-&gt;vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+		gfx_v9_4_2_debug_trap_config_init(adev);
 	else
 		gfx_v9_0_debug_trap_config_init(adev,
-			adev-&gt;vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
+			adev-&gt;vm_manager.vmid_uq_mask_gfxhub);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 54bcb5fdca242..e84426b6a1a8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -836,16 +836,14 @@ void gfx_v9_4_2_init_sq(struct amdgpu_device *adev)
 	}
 }
 
-void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid,
-				uint32_t last_vmid)
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev)
 {
 	uint32_t data;
 	int i;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
 
-	for (i = first_vmid; i &lt; last_vmid; i++) {
+	for_each_uq_vmid(i, adev) {
 		data = 0;
 		soc15_grbm_select(adev, 0, 0, 0, i, 0);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index c8757de669eaa..ca240f4298da6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -24,8 +24,7 @@
 #ifndef __GFX_V9_4_2_H__
 #define __GFX_V9_4_2_H__
 
-void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
-				uint32_t first_vmid, uint32_t last_vmid);
+void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev);
 void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 01ed1701c781a..8555e64977348 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1173,7 +1173,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&amp;adev-&gt;srbm_mutex);
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		soc15_grbm_select(adev, 0, 0, 0, i, GET_INST(GC, xcc_id));
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regSH_MEM_CONFIG, sh_mem_config);
@@ -1191,7 +1191,7 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
 	 * access. These should be enabled by FW for target VMIDs.
 	 */
-	for (i = adev-&gt;vm_manager.first_kfd_vmid; i &lt; AMDGPU_NUM_VMID; i++) {
+	for_each_uq_vmid(i, adev) {
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 490b4c4eb662a..a95bfe22c640e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -746,6 +746,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	unsigned long gfx_vmid_mask;
 
 	adev-&gt;gfxhub.funcs-&gt;init(adev);
 
@@ -869,10 +870,11 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      false);
+	gfx_vmid_mask = GENMASK(7, 1);
+
+	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) &amp; ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3cdc7893587a1..7b19c59a2f743 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -745,6 +745,8 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	unsigned int first_userq_vmid;
+	unsigned long gfx_vmid_mask;
 
 	adev-&gt;mmhub.funcs-&gt;init(adev);
 
@@ -854,11 +856,12 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = adev-&gt;gfx.disable_kq ? 1 : 8;
+	first_userq_vmid = adev-&gt;gfx.disable_kq ? 1 : 8;
+	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
 
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      false);
+	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) &amp; ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
 	amdgpu_vmid_mgr_set_vmid_mask(adev, GENMASK(AMDGPU_NUM_VMID - 1, 1), true);
 
 	amdgpu_vm_manager_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index fcc1d580fa946..9194130c25f29 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -849,6 +849,8 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	uint64_t pte_addr_mask = 0;
 	u32 mmhub_vmid_mask;
+	unsigned int first_userq_vmid;
+	unsigned long gfx_vmid_mask;
 	int i;
 
 	adev-&gt;mmhub.funcs-&gt;init(adev);
@@ -997,26 +999,24 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	mmhub_vmid_mask = GENMASK(AMDGPU_NUM_VMID - 1, 1);
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		adev-&gt;vm_manager.first_kfd_vmid = 3;
+		first_userq_vmid = 3;
 		adev-&gt;vm_manager.npa_vmid = 15;
-		mmhub_vmid_mask &amp;= ~BIT(adev-&gt;vm_manager.npa_vmid);
 	} else {
-		adev-&gt;vm_manager.first_kfd_vmid = 8;
+		first_userq_vmid = 8;
 	}
 
 	if (adev-&gt;gfx.disable_kq)
-		adev-&gt;vm_manager.first_kfd_vmid = 1;
+		first_userq_vmid = 1;
 
+	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
+
+	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) &amp; ~gfx_vmid_mask;
 	amdgpu_vmid_mgr_set_vmid_mask(adev, mmhub_vmid_mask, true);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
 
 	amdgpu_vm_manager_init(adev);
 
-	if (adev-&gt;vm_manager.npa_vmid)
-		adev-&gt;vm_manager.vmid_uq_mask_mmhub &amp;= ~BIT(adev-&gt;vm_manager.npa_vmid);
-
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 71409eb718d39..4e593e67221ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -768,6 +768,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	unsigned long gfx_vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev-&gt;vmhubs_mask);
 
@@ -824,13 +825,12 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      true);
+	gfx_vmid_mask = GENMASK(7, 1);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
BTW I don't think we have KFD support for GFX/GMC v6-v8 any more. Not for this patch but we can probably drop that at some point.

Apart from the nit pick above patch looks good to me.

</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre" style="white-space: pre-wrap;">Can you have a look at patch 2 also. If thats fine i will push v3 with suggested macro name change above...
Regards
Sunil Khatri</pre>
    <blockquote type="cite" cite="mid:dfc79fa7-a3bc-43a2-b060-e06410491768@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) &amp; ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c95e097241bf8..bbb5c42b9d4ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -941,6 +941,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	unsigned long gfx_vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev-&gt;vmhubs_mask);
 
@@ -1006,13 +1007,12 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      true);
+	gfx_vmid_mask = GENMASK(7, 1);
+
+	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) &amp; ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 8d8a0775878ff..25d47d2c288dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1051,6 +1051,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	unsigned long gfx_vmid_mask;
 
 	set_bit(AMDGPU_GFXHUB(0), adev-&gt;vmhubs_mask);
 
@@ -1121,13 +1122,12 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev-&gt;vm_manager.first_kfd_vmid = 8;
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      true);
+	gfx_vmid_mask = GENMASK(7, 1);
+
+	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) &amp; ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 85ba228f002d0..7ebf7b1299ff6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1849,6 +1849,8 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_addr_bits;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	unsigned long inst_mask = adev-&gt;aid_mask;
+	unsigned int first_userq_vmid;
+	unsigned long gfx_vmid_mask;
 
 	adev-&gt;gfxhub.funcs-&gt;init(adev);
 
@@ -2030,21 +2032,21 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	    adev-&gt;jpeg.disable_kq &amp;&amp;
 	    adev-&gt;vcn.disable_kq &amp;&amp;
 	    adev-&gt;sdma.no_user_submission)
-		adev-&gt;vm_manager.first_kfd_vmid = 1;
+		first_userq_vmid = 1;
 	else
-		adev-&gt;vm_manager.first_kfd_vmid =
+		first_userq_vmid =
 			(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 			 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 			 amdgpu_is_multi_aid(adev)) ?
 			3 :
 			8;
 
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      false);
-	amdgpu_vmid_mgr_set_vmid_mask(adev,
-				      GENMASK(adev-&gt;vm_manager.first_kfd_vmid - 1, 1),
-				      true);
+	gfx_vmid_mask = GENMASK(first_userq_vmid - 1, 1);
+
+	adev-&gt;vm_manager.vmid_uq_mask_gfxhub =
+		GENMASK(AMDGPU_NUM_VMID - 1, 1) &amp; ~gfx_vmid_mask;
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, false);
+	amdgpu_vmid_mgr_set_vmid_mask(adev, gfx_vmid_mask, true);
 	amdgpu_vm_manager_init(adev);
 
 	gmc_v9_0_save_registers(adev);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------XuGfjKgufZAy7H5mE3W9kYds--
