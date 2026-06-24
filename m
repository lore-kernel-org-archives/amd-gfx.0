Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B71CDE002
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 12:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0453A10EF19;
	Wed, 24 Jun 2026 12:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGvLo/xD";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448CA10E0AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 12:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPT2Dr0NLGzSqjBjcEr/py8RPHU16lBSnSP0J7njE49jkT3MH/31Jsqkz+FYrbRfVWBRa88QbYpf41nFFD0vtf0XHGW8uOT5SPFx9GpvzY4tpZpuM5kVwfMm8dM92pleV3LRtoyMqHI0hSYeqnpgsYydv/7tkPmLQaoiEy1Sa8LYklAR3CqDFR0hfm6201MNGK4WmglP61ZBu5gyP5lnt5GzNsFioMbpQe+3bHN7ACSi5I82mRZNoaev6F0fzHEGB92m1Z5cdiIdVAkdYqM9UXP/LcV3lRM7gsxoLJLI4F1O7K4h/1JD0tc81+oxrq+7us7CsUDmRZUl1mNAX11XGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ydvjHxdww9exAWw2zR4/PPQUjapiYscAnUvNQhWwPM=;
 b=IUJZU3jkatUr07dPf7RguSk/syxJeiKp+owIliWsJ1iMAu7LxmmklPnGGyI8D2zhAXQ01reySrdQwo8l5+2gYQLGHFS+y8kGJfJc4T8YVX3SgyXfc9WpP19mPz/AyVXVW/ap4lYD9pfMwjkQN3x4nm3/ejJuTl88Hc9a4sFs22hH2nzBoUoxuyHdUChi2iewvFDCZKpYYvqXwB/AO0n8jgNlocVpfJDDrbzBlon17AzKk8a0BtP/zUDGbxj0Wc/DAOQEtyWDVsEg0U7vbkRquKdgMflZK8DW5yfun7xVDGbAsr+GrsRWeVkcS0qQMr4sQGaO/f+IPeFLiMoqJWKDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ydvjHxdww9exAWw2zR4/PPQUjapiYscAnUvNQhWwPM=;
 b=eGvLo/xDgQqCl0XSkTX1u4zr+soIH8oCO4Sc2YehBjMS87su/PxiH1y5f028TJbEzhTtJXDN4zp1L/83gCw3q/qgxTuVmpcSrhhoUqq58sNorhKLRxshhNch0lgtlfMdQpXS3MFPst5x07mE/IfymPbHsTHrTIbRfwusaN6o21c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 12:59:33 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0113.015; Wed, 24 Jun 2026
 12:59:33 +0000
Message-ID: <aa6d3b80-fff5-4cb3-a613-c67804edcc5f@amd.com>
Date: Wed, 24 Jun 2026 18:29:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] drm/amdgpu: move struct amdgpu_mqd and helpers
 into header file
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: alexander.deucher@amd.com
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
 <20260622195729.181216-5-shahyan.soltani@amd.com>
 <8f135ee0-7d1d-4af2-aa89-36fb2265a66d@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <8f135ee0-7d1d-4af2-aa89-36fb2265a66d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::16) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: e50373e1-b490-428d-dde2-08ded1f06fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: E7qjuRn5sbQDoKhD55AD049RHBQ/VvClhsET00tSEgr14u289vMXwpR5jWXcm5wTEs0VFlOLCXnjssD2f4kXSknxmc1LF7D/7evIi/6x86AYGnlK83VSIj/Fg5uYVDmg0XT+DJ1Ssmb4f5Gam8F7ONwA86EHZO2esgaerWLqzFpWub4KjykvXSCoV+GJVdensZuvoRCWqZhPFHNtMOK+7/B9tsY2KoM4/flBKEDNMDzDLmHx6DTG82jBT1NiUx5yenXhs+yGIZIRw5vfwowvGknkMdUMgGH0rhWNb4SGetdPp2PU/gMyYzq51ot3K8c0ccVTUYFhl4lbYLhKW4I6gXLtY1Mf/3HV55o/Xcq4PzYBaV125GAoNTR1enk6nDK9eto36oV13S6LG+b9H8AJCFzMoHow7c3E/A9CAWe7Cd4kBZ2sgodQEXFsXwPoPJfsiPY2Qh5rXDqP7lChJwVotU7/+oLVDvPl1hGO5QQRGg1zLTiBWdzEbs5EEgB+cTdcr6hi0mAQ95CflG8T8kpvsgFktKCR37XisMAMNc/tCTpFCViH+HTkUN/hwWbm/DvcHwJfB72CtFMknNq6ENyrch0TkfeBp1F0B/e1KAL4GVuL60L8PRrXdhBucgLUdeTe+8nH1qkgW5Apxc+50fcafYyuFZGH2cPalcninYsFjXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFCektMMU9ZSlFHNnBJZEp5bVhlRHNQNFlsc0tVaXlvVllrMkhKcWxnZmNn?=
 =?utf-8?B?Q3NmOTB2L0xZUlJDRW1SaTJxclNEd3FBMFZWVCtOSVB5Z3FlRVBxckxiM2VZ?=
 =?utf-8?B?eHdaNDFGZ3lyL1pVT3JyUEhDUW05TW1RZnBDTWhGNEZaeVV2dVRJWEEyZVpm?=
 =?utf-8?B?WFF1RVRpQ05NZUhucERuQms2MDNkaGJBWW1TN092cjBTY3pxdkxqcWlEL2tK?=
 =?utf-8?B?Yk5KbWt6Q2ZJSVZyR3FQTjExUUFzUUIxWXRXRzRIOGN0N0U1c0FhamNaTHRE?=
 =?utf-8?B?eW10RmFvZjNBZ2tsVVBzaitTM1BQU1RUZnZwcVFGSTd5K011bGQxVGdreWhB?=
 =?utf-8?B?UjR1eTM0eW02U2ROM0kyN0tjZDBEbVliN2hCWVpLYzV2SkhFaWE3L2pEek56?=
 =?utf-8?B?N05yc2dxeTg3d0JIWXlnUWZTNW5MMUtFdCtpb2huR0c5Vmd0by90UXFqSUs2?=
 =?utf-8?B?RE4vSGZ4NHBVSDZMVzlCUFZpdyt2WkJqYzBhY0R3Zko5T1NOdjhBVGdObG1m?=
 =?utf-8?B?N1N1alVxc1U3bnJWcHlkU3V4SVdlMXJFeGRYU1VRUjBPYUliUEFiNXkrMGFL?=
 =?utf-8?B?MC9wVEhjTEZlbTZHbFp5WW5VanhlRjUrbUVRNnZnZ05uK21QRnlWeWd2NllH?=
 =?utf-8?B?RVNxS0svVnZESlhoYUQ0dHIraThrWW84V1IybjhYZDdONUtvbC9YWjNUaGZT?=
 =?utf-8?B?aUhhYVFTanFvM0U1QWJuaDc3ckVMVkZGVldzMllENklRSUYvWVRrY2dQYUhS?=
 =?utf-8?B?NXJqSU5vNTNDaXNzSXJDU1hOV0QvVjFCY2h3TXRnQXY2NFJKVUFma2h3bjFH?=
 =?utf-8?B?UVUxajl4U2pweEp4TnJ6bkJCVWdPNGYxa3BSR1Myb3BveUlXVzlTaVRTNUVk?=
 =?utf-8?B?Z212eXFPa3Yycjh4SHdMZHRUVkNmOW8yR2I5MFNvclN4cmVPcTRVZC9aQnMv?=
 =?utf-8?B?Mk9PNldPWk1wYWU0VDRqanZqS2o2RlFDd2IzcVlKVm5VaFlQZ3pMcW5UeklN?=
 =?utf-8?B?cndFTHNwRXQwS21wRGV6aW40aC9QeXNxMFNyZDFoelBZMm1wL21GeC9zdXVI?=
 =?utf-8?B?emJDWEdPbDNwRU50ZTZOeEY1a3JSb3BPY2t5U2ZOU1lHTzc0Q055UWhBK0hp?=
 =?utf-8?B?SUdyU0hpdkJYcmJrb0dXU1hra3ZtNFhUaW1Wd1lNdlRyOE5jRWVEMHBMeGZz?=
 =?utf-8?B?NlFUd2k0MVFCNTZYZW14SkhjZi8wYUVjSXo0bnFwRm5XK0pFNEI4Tk40L2Nz?=
 =?utf-8?B?c0ZIVkZxN2hWbHhrVWFST1JOMlhCa3d0OWppVkF3UUtVK2x6UFNReHk4dC9S?=
 =?utf-8?B?cUhXWnZRc3A3Y1BIcUFESWxKWTNsU09Sb0RaY1hRRnRxR1hrYzRickNVZy8w?=
 =?utf-8?B?MlhsRkVsVHdDa1N2dzFudGJGK2dtb0VUS3UzaUNMR0p6eDNPQjc5ZXFBUFp4?=
 =?utf-8?B?ZW9KUk5UMlA2SnpHTXBrU0htMFV5WUQ1Uml4endjTUU3VmxiVDFvL2hQN1NI?=
 =?utf-8?B?R1RHNDFXdWE2WUhGamFQY3ExaDQrOUJiVjB6THBZVHNEMXplcDRUKzBFb0ww?=
 =?utf-8?B?NlNMbmpUVzM1a25ySm1oYStaaGJnVTJ4aFRLVUt0MkM4Nkp6TzhXWHhVekhZ?=
 =?utf-8?B?Sk5ES1Yvdmp3K00ybGI1dGlFeDNpd1gvSUdia3dtRmJFZG1vbWVXQnh1Mnp6?=
 =?utf-8?B?QmZiQ0xQREljMWljdmE3ZHBKYkNpTjBoWE00aUlOTTEzZXhJYTVHOExmOXdC?=
 =?utf-8?B?Z3dENUk2aGVPTFJKZFo0M1NYb2tlcVAzWEdBell2V0FmR05CakR5SEFtZFFp?=
 =?utf-8?B?N1Q5aFFyY1JZeGtiQ1NxVERNMEJsNjJWZEo1Y05DcGNqdExHTVN3Nld1REta?=
 =?utf-8?B?eHlQUG9kanY5aFhtZWxoY3BvUWJXZktLbHhBVHhBUEZuR0NhSS9BTWhqMWxI?=
 =?utf-8?B?dmxtWHM1dnpVS2lXY0Z0ZjIvc250NFJJM0FvZXRtWFNoMHM5eGpVai80bU1n?=
 =?utf-8?B?cXZlSGFGNUlvdE5YQnpmeDludGVxVitQL1hKVHNUV3VQOFhDSW8wakFKZ293?=
 =?utf-8?B?blkxTWJQVXl4eXFSdWxjd1pQbG9DYnVHNzgrY1Nac0I2ZmNwYWZMQ1Q2SXI0?=
 =?utf-8?B?eFlkUTlYSHZIRU1mTFFlbjVZNTJ1ejV0R0JQeWdmeVloNXo3bHdzT01TajFI?=
 =?utf-8?B?dlpETGppeXhCQURQSnNMZzBRNnZEbjIzdUt0MkdJTzFPb2RWTCs3NnlZZUZk?=
 =?utf-8?B?YnVGUXJKOVg4WS9uTlJ5TEw2WDNOQWQvRzFyR3c4SEhuWWdKVDI5TWNKekpC?=
 =?utf-8?B?Zk1ielROeGUzb2hML21XRW1OVTk4L0xCSXNwMnliUkRIWnpuaWlhUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50373e1-b490-428d-dde2-08ded1f06fc3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 12:59:33.5293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVakVHEQbY7k9YKYQk1G/vaW4kCOoOsnaMlIGhBbSvH+bktj6BgtThBPM7sIhHzBVVKb0IMFmtlM5m8rwpUvew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
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


On 23-06-2026 02:34 pm, Christian König wrote:
> On 6/22/26 21:57, Shahyan Soltani wrote:
>> Move struct amdgpu_mqd_prop, struct amdgpu_mqd, and helpers from the monolithic amdgpu.h
>> into existing amdgpu_mes.h file.
>>
>> This is part of the ongoing effort to reduce the size of amdgpu.h into their own respective
>> separate headers.
>>
>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> @Sunil can you take a look at that as well? Just to keep you updated on all userqueue stuff.
LGTM,
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil Khatri
>
> Thanks,
> Christian.
>
>> ---
>> Following v2's feedback struct amdgpu_mqd and helpers were moved into
>> the existing amdgpu_mes.h instead of creating a new amdgpu_mqh.h file
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 48 +------------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 ++++++++++++++++++++++++
>>   2 files changed, 47 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 61608acc0393..ca86cef62f44 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -96,7 +96,6 @@
>>   #include "amdgpu_doorbell.h"
>>   #include "amdgpu_amdkfd.h"
>>   #include "amdgpu_discovery.h"
>> -#include "amdgpu_mes.h"
>>   #include "amdgpu_umc.h"
>>   #include "amdgpu_mmhub.h"
>>   #include "amdgpu_gfxhub.h"
>> @@ -115,6 +114,7 @@
>>   #include "amdgpu_eviction_fence.h"
>>   #include "amdgpu_wb.h"
>>   #include "amdgpu_ip.h"
>> +#include "amdgpu_mes.h"
>>   #include "amdgpu_sa.h"
>>   #include "amdgpu_uid.h"
>>   #include "amdgpu_video_codecs.h"
>> @@ -609,44 +609,6 @@ struct amd_powerplay {
>>   					  (rid == 0x01) || \
>>   					  (rid == 0x10))))
>>   
>> -enum amdgpu_mqd_update_flag {
>> -       AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
>> -       AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
>> -       AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
>> -};
>> -
>> -struct amdgpu_mqd_prop {
>> -	uint64_t mqd_gpu_addr;
>> -	uint64_t hqd_base_gpu_addr;
>> -	uint64_t rptr_gpu_addr;
>> -	uint64_t wptr_gpu_addr;
>> -	uint32_t queue_size;
>> -	bool use_doorbell;
>> -	uint32_t doorbell_index;
>> -	uint64_t eop_gpu_addr;
>> -	uint32_t hqd_pipe_priority;
>> -	uint32_t hqd_queue_priority;
>> -	uint32_t mqd_stride_size;
>> -	bool allow_tunneling;
>> -	bool hqd_active;
>> -	uint64_t shadow_addr;
>> -	uint64_t gds_bkup_addr;
>> -	uint64_t csa_addr;
>> -	uint64_t fence_address;
>> -	bool tmz_queue;
>> -	bool kernel_queue;
>> -	uint32_t *cu_mask;
>> -	uint32_t cu_mask_count;
>> -	uint32_t cu_flags;
>> -	bool is_user_cu_masked;
>> -};
>> -
>> -struct amdgpu_mqd {
>> -	unsigned mqd_size;
>> -	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>> -			struct amdgpu_mqd_prop *p);
>> -};
>> -
>>   struct amdgpu_pcie_reset_ctx {
>>   	bool in_link_reset;
>>   	bool occurs_dpc;
>> @@ -1034,14 +996,6 @@ struct amdgpu_device {
>>   	struct amdgpu_kfd_dev		kfd;
>>   };
>>   
>> -/*
>> - * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
>> - * as fence address and writes a 32 bit fence value to this address.
>> - * Driver needs to allocate at least 4 DWs extra memory in addition to
>> - * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
>> - */
>> -#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
>> -
>>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
>>   					 uint8_t ip, uint8_t inst)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 5255360353f4..7b4cfb5c8f83 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -438,6 +438,52 @@ struct amdgpu_mes_funcs {
>>   			      struct mes_inv_tlbs_pasid_input *input);
>>   };
>>   
>> +enum amdgpu_mqd_update_flag {
>> +	AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE = 1,
>> +	AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE = 2,
>> +	AMDGPU_UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
>> +};
>> +
>> +struct amdgpu_mqd_prop {
>> +	uint64_t mqd_gpu_addr;
>> +	uint64_t hqd_base_gpu_addr;
>> +	uint64_t rptr_gpu_addr;
>> +	uint64_t wptr_gpu_addr;
>> +	uint32_t queue_size;
>> +	bool use_doorbell;
>> +	uint32_t doorbell_index;
>> +	uint64_t eop_gpu_addr;
>> +	uint32_t hqd_pipe_priority;
>> +	uint32_t hqd_queue_priority;
>> +	uint32_t mqd_stride_size;
>> +	bool allow_tunneling;
>> +	bool hqd_active;
>> +	uint64_t shadow_addr;
>> +	uint64_t gds_bkup_addr;
>> +	uint64_t csa_addr;
>> +	uint64_t fence_address;
>> +	bool tmz_queue;
>> +	bool kernel_queue;
>> +	uint32_t *cu_mask;
>> +	uint32_t cu_mask_count;
>> +	uint32_t cu_flags;
>> +	bool is_user_cu_masked;
>> +};
>> +
>> +struct amdgpu_mqd {
>> +	unsigned mqd_size;
>> +	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>> +			struct amdgpu_mqd_prop *p);
>> +};
>> +
>> +/*
>> + * MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t))
>> + * as fence address and writes a 32 bit fence value to this address.
>> + * Driver needs to allocate at least 4 DWs extra memory in addition to
>> + * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for safety.
>> + */
>> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size) AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
>> +
>>   #define amdgpu_mes_kiq_hw_init(adev, xcc_id) \
>>   	(adev)->mes.kiq_hw_init((adev), (xcc_id))
>>   #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
