Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DC8CD98F2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 16:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD7710EA77;
	Wed, 17 Jun 2026 16:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fleHCSrz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07EA10F00A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 16:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onitypSKlNO15G5Ed9tcPmRnTZEgbKtZSQC4BZNkb6uJ/TkjruD563ywFshvnxY94kiYuAL7lLdgE6hPQDLqWfknqKF9xT4ockHR1TcvOEocTnDUhWe2ut47r5NbW/7RqsdxhFts8JAdOPrABx7sfKnPxZ3OBA7vmhTWmzYHliAdzhw+IRcl8F5zXBdkqXcvYnNRi3tkZwHQulAXghIs2rm/00jKN7/I62WdNznT+P2CbBzhZEUOJpyw/IT7i2YnArx/dmKA4my/ymr4xyEZnnaQZKXPdW1Sx0HCrXSLC+EYLs2DIn2wEFCO44TI9mRQXFa2Kb04mozE5STYezd5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HVxvrIfphTE1v1uHh/Xze/7dYkQuw3Tes804MF2cQ8=;
 b=R+y2eQC/l7v8/YyIvNMYgDrYtHnSWvfJUv0dHnrnkwyc37cRCeTPGlCbQZACNE79BJXAjK9gUsoC7/5DCFJZuHPEPM/8gZtTzU0aiQeDK9gFmM7jZxeHzenstKElfHZ5SrDkWOPiy/rkPaeehCS/DfhQat4aWp40Rnpx9HiLMxvnIjSdb3skHbs6YZIiLRvl42AdPvJ6EnWovLytNRbnbeIHFjGT2deHiDZ1N+KM+OYU0cvv/TaqO0DhAZr/+AiYooH3q7E8bvm/y5dzAspmLFGbCTMqAZGbxm0IV5MRWHjItAwfNgnQ5zuhzK5POsyTL/Ok9qahhFqlDIiC6sF8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HVxvrIfphTE1v1uHh/Xze/7dYkQuw3Tes804MF2cQ8=;
 b=fleHCSrzDNw5G1+I1nooRrD55RC2P+Ru9TBw3y++G9qMDtOmvbpEke8kGCGGkrGaG18nUjXwEMqukUWGsbdmhvuyrZnG/bnM15HTqkEtf5EcrFVMy1KYYObPjNQRWl03V9b/MxTsMBPaafvBf+rKEOwFZ0efNyrDb9OcunjQZXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SAWPR12MB999166.namprd12.prod.outlook.com
 (2603:10b6:806:4e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Wed, 17 Jun
 2026 16:24:19 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:24:16 +0000
Content-Type: multipart/alternative;
 boundary="------------reEONlNOGNexJT0R2QPJhLUN"
Message-ID: <37555d80-f60b-4b59-b083-e3e47c55a063@amd.com>
Date: Wed, 17 Jun 2026 12:24:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: Unmap svm range when all GPUs set to
 no-access
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260616211652.1962285-1-Philip.Yang@amd.com>
 <20260616211652.1962285-2-Philip.Yang@amd.com>
 <a0e9c13f-aea7-437a-8134-0bdf52b57aac@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <a0e9c13f-aea7-437a-8134-0bdf52b57aac@amd.com>
X-ClientProxiedBy: YT4P288CA0053.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::10) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SAWPR12MB999166:EE_
X-MS-Office365-Filtering-Correlation-Id: f677587d-2b46-45ad-7b18-08decc8ce014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|5023799004|8096899003|6133799003;
X-Microsoft-Antispam-Message-Info: 2or7OXcSwSoAcsQq04k0QIrPBx+qjqWKiFWsMU0bY09xwOGRcjVbKc/ialfdLBaDIHvOVuUG8IDhBsbaPoxqpc663aaB1lBdovh0jtPNZ+f9KdluDmGZDQJ3cmGPqOCxIfMhKlEDCHfrinja6B5xf9G6u+RJUB3xLVJwBCQcM7jJtJ7y82RzOU8DPdiPbQlYOEKXHBmk3mvcMFqPc+qqdl+tNCHhMRdPmsrT2gxuEdyu42yZ2hCAxFfZCWxM0Qxh5HRrniV0JvoF7+ttyLgcqiTKWvDsLCPuCKnw27Sb/lazHdMb66j/aMeZ7CIw8EItk/qWD4i7copAWnV1P69a1z6E2hTH2G2VEwHsjstK4cuSHWScyRZRkhJWNVy4MkWVUj1C3QebHLo9J7WkUKx6Oja6DV9z1DQldBV0YJtkPw3bfIvHR/jZEXyxh6r+wRcsBzQ657kEjuQUayDVye9GMX4Yd57G6/IUKvoQWovV5v/CP1uafrzATrlh7q8HzLDA7ZWanFlmr6QsPtRo8G3xYQjC7Tip+lkef/ocpsn4O1MwE7oU+SyWvYeyi0qNixQNc3o+fxemnzExEt6okZYha/qsVLVlNMCGLjFgBTG10HZIJIUEXTG51kA7ow4cJMs4lkTCGlphkq+26GlojYmT/rTOSaj+NzIJmhVGd6jxUEIGFsYdNny3HjhzZhpitRWv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(5023799004)(8096899003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDNzUXhwWVArUGJLMCt4b1hxNWk4TzhaZjl2VVFlRzVVQkFCZVkwRU5Eck4z?=
 =?utf-8?B?anhiNnp0RG1xQ2ZsbUVDbTJvNkNEMitrczZXcFhQcitwdkdBRDFJOU1RR2da?=
 =?utf-8?B?MHNpRDJBUDlCWkdaU0ZHNGlGcUpFdWRRS1JzS2FGc21NbnFLUTkyRDJGWkhx?=
 =?utf-8?B?U2x6QUxxTm55ODFVRjQybHlMWVFCQ0FWSVVldWgrUVJkWmpBSWFqNVZlY2RV?=
 =?utf-8?B?WGJkUHM2WE1mK0tkZ2VPRkVseG9uWjlVV20xWjNtWnN1R2trTGhVRmNod3Jk?=
 =?utf-8?B?a0VNL3k1MWl1VE9Da0FoK1NwaWxzSmRiVEdNM2x1eGVTYXZjaEdJQXhmanVL?=
 =?utf-8?B?UzhnZVhyclRzcHZVQ21wcWsrZEladFRqQ0hUVS9PYWx6ekg0TG0yRSs3THFr?=
 =?utf-8?B?Nmc5NG1WOVR2N216Zm1LZmZXY2UwVS85Q2g1NWl3dm1TRWdvRUw5QnF1TFlT?=
 =?utf-8?B?aUJ1S2pUMUZmeU5zditiUTcxMmZyRis1KzNYcU84bmEzTFhFZFA3RkxTTWpQ?=
 =?utf-8?B?azFoa3B4ajZFZVZBZ0tRRXM0ZFZkZ0F0dFdCN1dURitTcG5vcEgzT3VhSTVR?=
 =?utf-8?B?UjJIaXBoQTRCdkNHNUtTWllhTVdLV01pQ01JcFFRbzFGeitWSFNYMWx4c2x4?=
 =?utf-8?B?aG5ic2xvRTZlS0lWQ2RiZDhHWWVGcUZvQTFma21yRkRrRTZsZ0JaaytSZnNr?=
 =?utf-8?B?bFJNbVNRaUg5TnhqbVJ3WG1nT0J5NzFVaVhvRFFzcVh3TlBVb2h2c1dScEhk?=
 =?utf-8?B?dHUyZFZFamZIUlFBNkRLaU9lU0lrOE42VzkvYlBEdDRsTkNUR04reGZHb3Zy?=
 =?utf-8?B?THMxZCswVHpoTWlXc1BnbjlmMFI1OVh4dnA0NW1oR09Dc3pQSmNJSExsRlFx?=
 =?utf-8?B?N0pTNzB2UUtJd0UyejlTTXFnZWUzcFQxYUVieWlUSFRCVGoxQkkrcHYrSHlu?=
 =?utf-8?B?UHlZN0N3U2p1anBhekYvbTliK2htZUtIQnVZeDd0QmpiRk9kTXdnQ2gwdnNo?=
 =?utf-8?B?OU4vVnY1T0Y1NHMzSVQva202VDVUS1lVNVpFVlJhaVYwU1BaZXhmcmpReWxl?=
 =?utf-8?B?THZtQzlqT0I1S0IwWThLaEg0VXZwanNocDVORWgwTU5wNEdRZzVLeWl3a3FP?=
 =?utf-8?B?RWN5VThJdm4zeWFZY05NSml1eEV2R1BHVDEzR1V0MENQZDdNUHczZGxNeFB6?=
 =?utf-8?B?NEdjUVJZSjNRS3dOcS9jTXN0dEl0bHc5NkpINng4S2xEVklZeHl5KzVrR1dY?=
 =?utf-8?B?Zzhsc2Z0MUFHbC93Q1VwcTZpMGJtZEdWbmNKdmo4b2w5VGtFb0VPTUxqOHZ6?=
 =?utf-8?B?RnlzYWJTdEx0MGFEQTNuQmsrbWpiR3NRNU1aRkJ4THErL0pJUXUxNCsweVMw?=
 =?utf-8?B?UzdHNGlFQ0VtSVNmZDc0QUMzUjRMU0h6RkdMYzhpWmljRU9wVmg2SXZicHN2?=
 =?utf-8?B?QllJZkQydjR6aDBsUUh2L2R4WktUdHM0VUF4RHNDandqZXZNdWdWZ2RGYThH?=
 =?utf-8?B?RUsrd21Tc0FONVl1VU9sV05INGhDM0JvZ05XcFVraVpaaUJqSW9QVTc4NHdr?=
 =?utf-8?B?VFJXQTdkeExwcUd2N01kSUk4M3ErUlFxUStIczBUVjZWTUc4RW82dHdiclNE?=
 =?utf-8?B?OEY0RTNPeWV0RjU5MG9oSENPMVZDWkJJTlZrcytMMlpBcHRqTDFiL0traExh?=
 =?utf-8?B?bUNQNVJzUEhYVTZZYzlYcTRrLzZLUG95M2FiUU56K1JDaFJTdjdwSzlmTFpO?=
 =?utf-8?B?R2VoNjVYRXR5aTN3QklJZnFMc1ZjZXZsc2hCemM4MEhTTThuSHdzdGxDeUNS?=
 =?utf-8?B?MGkveVFyWFpKRlN6TW9NVXlRckVwVkExOEdGMFFSSWU0Y2tRbnVONkw3VDNG?=
 =?utf-8?B?cStPOGZxbFJaM3BpaTVqczZ6SmtGWEtOVFcwWXZEa2MyVEwwQmdvTEkrZFlq?=
 =?utf-8?B?T09pMG5tUmwyb0pIRVlxRThrbFlYU2s1LzJYR0ZabTFmZWQwclBvMEZkT1ZD?=
 =?utf-8?B?TGlybkg5NXMzaWh3Y1BIUFVHcmV1M0hlazJRYlBjT2Z2M0IxRkN2eVFLQkRy?=
 =?utf-8?B?K1JZQnFaN2NlRHFpNzhrcm1PZS8zbDNmWmZ6czZhQUJpeUdLTXpyWHo2S3pR?=
 =?utf-8?B?V0tUd3BPcy9ZamlETFRmSHM5aUxpMUdBak1xaEw4eThTdmdoRFVTMVlwM1Va?=
 =?utf-8?B?Zzhoc2VGODVUQlJuN3lvVGVoQjlaRlBYZjN4N3lTYXl6TG53anZqbS90bVIr?=
 =?utf-8?B?d2V2NGcxNlVaN21SZG82KzFlenpGQmFteGRKYzRWZGRnZUZkL1JIcXdHNjhl?=
 =?utf-8?B?K1ZOaGVBWFc1YXJ6bkxRUEcrREVXOVp2enArSXNzdnF6RnYrd2NyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f677587d-2b46-45ad-7b18-08decc8ce014
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:24:16.3339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSMoa1+54UGEZMmhm/y36FgHqZqYmnpW8XdnF2SrZZkMUjNkYB/0IWrX8zzzGukugG38aUAYHSdlE9rY1YPfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999166
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

--------------reEONlNOGNexJT0R2QPJhLUN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-06-17 12:15, Chen, Xiaogang wrote:
>
>
> On 6/16/2026 4:16 PM, Philip Yang wrote:
>> When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to all GPUs that have an
>> SVM range mapped, unmap the range so the MMU notifier can skip queue
>> eviction — safe because no GPU will access it.
>
> KFD_IOCTL_SVM_ATTR_NO_ACCESS means shadder will not access this prange 
> on a gpu. It does not mean driver needs unmap this prange.
>
> At MMU notifier stop queue or not should be decided by affected 
> prange's access attributions:
>
> KFD_IOCTL_SVM_ATTR_ACCESS,
> KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE,
> KFD_IOCTL_SVM_ATTR_NO_ACCESS,
>
> or
>
> bitmap_access/bitmap_aip.
>
> Current kfd uses mapping info to decide evict queue at MMU notifier. I 
> think it is not right. Should use prange access attributions that are 
> from user to decide whether stop queue on this gpu. If user has 
> specified KFD_IOCTL_SVM_ATTR_NO_ACCESS on this prange and this gpu 
> driver does not need stop queue on this gpu at  MMU notifier.
>
I strongly disagree with this. The kernel mode driver cannot trust user 
mode. User mode could say "no access, I'm not accessing this any more" 
and then access it anyway. In the MMU notifier, the kernel mode driver 
must guarantee that the memory will no longer be accessed. It either has 
to unmap it from the page table or stop the user mode queue. There is no 
way around it.

Stopping user mode queues has a large performance overhead if done 
frequently. So we are trying to minimize that by unmapping memory that's 
no longer accessed. That's what this patch is about.

Regards,
   Felix


> This patch seems introducing unnecessary complications if the goal is 
> to not stop queue at MMU notifier when KFD_IOCTL_SVM_ATTR_NO_ACCESS 
> has been specified by user. Driver should use prange access 
> attributions to decide queue eviction at MMU notifier.
>
> And access attributions can be dynamically changed. User component can 
> change a prange from no_access to access(or access to no_access) at 
> runtime, then driver has to remap the prange if it had been unmapped 
> during no_access. In other words mapping is not exact equivalent to 
> accessing.
>
> Regards
>
> Xiaogang
>
>
>> Replace the mapped_to_gpu boolean with bitmap_mapped to track which
>> GPUs currently have the range mapped. Set bits in svm_range_map_to_gpus()
>> and clear them in svm_range_unmap_from_gpus(). This is separate from
>> bitmap_access/bitmap_aip which track user-requested attributes and must
>> not be used to determine mapping state.
>>
>> Add bitmap_needs_unmap to svm_range, set when a GPU is given no-access.
>> Add svm_range_needs_unmap() to trigger the unmap once bitmap_needs_unmap
>> equals bitmap_mapped, i.e. all mapped GPUs are set to no-access.
>>
>> v4:
>>   - Rename and set prange->mapping_done to false if validate and map not
>>     complete successfully (Felix)
>> v3:
>>   - Correct error handling, support app retry update mapping (Felix)
>> v2:
>>   - Add bitmap_mapped to not break get_attr (Felix)
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 103 ++++++++++++++++---------
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
>>   3 files changed, 73 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> index 9d4838461168..5d55407069a4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> @@ -111,12 +111,11 @@ static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u6
>>   		if (!prange)
>>   			break;
>>   
>> -		if (!prange->mapped_to_gpu)
>> -			break;
>> -
>>   		r = kfd_process_gpuid_from_node(p, pdd->dev, &gpuid, &gpuidx);
>>   		if (r < 0)
>>   			break;
>> +		if (!test_bit(gpuidx, prange->bitmap_mapped))
>> +			break;
>>   		if (!test_bit(gpuidx, prange->bitmap_access) &&
>>   		    !test_bit(gpuidx, prange->bitmap_aip))
>>   			break;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index df7fca65e9a2..e039b6f2942f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -786,6 +786,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>>   			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
>>   				bitmap_clear(prange->bitmap_access, gpuidx, 1);
>>   				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
>> +				bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
>>   			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
>>   				bitmap_set(prange->bitmap_access, gpuidx, 1);
>>   				bitmap_clear(prange->bitmap_aip, gpuidx, 1);
>> @@ -1076,9 +1077,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>>   	new->prefetch_loc = old->prefetch_loc;
>>   	new->actual_loc = old->actual_loc;
>>   	new->granularity = old->granularity;
>> -	new->mapped_to_gpu = old->mapped_to_gpu;
>> +	new->mapping_done = old->mapping_done;
>>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>> +	bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, MAX_GPU_INSTANCE);
>>   	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
>>   
>>   	return 0;
>> @@ -1379,7 +1381,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   
>>   static int
>>   svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>> -			  unsigned long last, uint32_t trigger)
>> +			  unsigned long last, unsigned long *bitmap_unmap,
>> +			  uint32_t trigger)
>>   {
>>   	struct kfd_process_device *pdd;
>>   	struct dma_fence *fence = NULL;
>> @@ -1387,21 +1390,15 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>>   	uint32_t gpuidx;
>>   	int r = 0;
>>   
>> -	if (!prange->mapped_to_gpu) {
>> -		pr_debug("prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n",
>> -			 prange, prange->start, prange->last);
>> -		return 0;
>> -	}
>> -
>> -	if (prange->start == start && prange->last == last) {
>> -		pr_debug("unmap svms 0x%p prange 0x%p\n", prange->svms, prange);
>> -		prange->mapped_to_gpu = false;
>> -	}
>> -
>>   	p = container_of(prange->svms, struct kfd_process, svms);
>>   
>> -	for_each_or_bit(gpuidx, prange->bitmap_access, prange->bitmap_aip, MAX_GPU_INSTANCE) {
>> -		pr_debug("unmap from gpu idx 0x%x\n", gpuidx);
>> +	for_each_set_bit(gpuidx, bitmap_unmap, MAX_GPU_INSTANCE) {
>> +		if (prange->start == start && prange->last == last) {
>> +			pr_debug("unmap svms 0x%p prange 0x%p from gpu_idx 0x%x\n",
>> +				 prange->svms, prange, gpuidx);
>> +			clear_bit(gpuidx, prange->bitmap_mapped);
>> +		}
>> +
>>   		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
>>   		if (!pdd) {
>>   			pr_debug("failed to find device idx %d\n", gpuidx);
>> @@ -1554,6 +1551,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>>   			continue;
>>   		}
>>   
>> +		set_bit(gpuidx, prange->bitmap_mapped);
>> +
>>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
>>   					 prange->dma_addr[gpuidx],
>>   					 bo_adev, wait ? &fence : NULL,
>> @@ -1699,7 +1698,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
>>   		bitmap_set(ctx->bitmap, gpuidx, 1);
>>   	} else if (ctx->process->xnack_enabled) {
>> -		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
>> +		/* Update mapping on already mapped or access in place GPU */
>> +		bitmap_or(ctx->bitmap, prange->bitmap_mapped, prange->bitmap_aip,
>> +			  MAX_GPU_INSTANCE);
>>   
>>   		/* If prefetch range to GPU, or GPU retry fault migrate range to
>>   		 * GPU, which has ACCESS attribute to the range, create mapping
>> @@ -1719,14 +1720,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		}
>>   
>>   		/*
>> -		 * If prange is already mapped or with always mapped flag,
>> -		 * update mapping on GPUs with ACCESS attribute
>> +		 * If prange with always mapped flag, update mapping on GPUs with
>> +		 * ACCESS attribute
>>   		 */
>> -		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
>> -			if (prange->mapped_to_gpu ||
>> -			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>> -				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
>> -		}
>> +		if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
>> +			bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
>> +				  MAX_GPU_INSTANCE);
>>   	} else {
>>   		bitmap_or(ctx->bitmap, prange->bitmap_access,
>>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);
>> @@ -1792,6 +1791,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   				e = min(end, prange->last);
>>   				if (e >= s)
>>   					r = svm_range_unmap_from_gpus(prange, s, e,
>> +						       prange->bitmap_mapped,
>>   						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>   				svm_range_unlock(prange);
>>   				/* If unmap returns non-zero, we'll bail on the next for loop
>> @@ -1854,7 +1854,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>   		}
>>   
>>   		if (!r && next == end)
>> -			prange->mapped_to_gpu = true;
>> +			prange->mapping_done = true;
>> +		else
>> +			prange->mapping_done = false;
>>   
>>   		svm_range_unlock(prange);
>>   
>> @@ -2024,10 +2026,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>>   	if (!p->xnack_enabled ||
>>   	    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
>>   		int evicted_ranges;
>> -		bool mapped = prange->mapped_to_gpu;
>> +		bool mapped = !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>>   
>>   		list_for_each_entry(pchild, &prange->child_list, child_list) {
>> -			if (!pchild->mapped_to_gpu)
>> +			if (bitmap_empty(pchild->bitmap_mapped, MAX_GPU_INSTANCE))
>>   				continue;
>>   			mapped = true;
>>   			mutex_lock_nested(&pchild->lock, 1);
>> @@ -2076,13 +2078,14 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>>   			s = max(start, pchild->start);
>>   			l = min(last, pchild->last);
>>   			if (l >= s)
>> -				svm_range_unmap_from_gpus(pchild, s, l, trigger);
>> +				svm_range_unmap_from_gpus(pchild, s, l, prange->bitmap_mapped,
>> +							  trigger);
>>   			mutex_unlock(&pchild->lock);
>>   		}
>>   		s = max(start, prange->start);
>>   		l = min(last, prange->last);
>>   		if (l >= s)
>> -			svm_range_unmap_from_gpus(prange, s, l, trigger);
>> +			svm_range_unmap_from_gpus(prange, s, l, prange->bitmap_mapped, trigger);
>>   	}
>>   
>>   	return r;
>> @@ -2112,10 +2115,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>>   	new->prefetch_loc = old->prefetch_loc;
>>   	new->actual_loc = old->actual_loc;
>>   	new->granularity = old->granularity;
>> -	new->mapped_to_gpu = old->mapped_to_gpu;
>> +	new->mapping_done = old->mapping_done;
>>   	new->vram_pages = old->vram_pages;
>>   	bitmap_copy(new->bitmap_access, old->bitmap_access, MAX_GPU_INSTANCE);
>>   	bitmap_copy(new->bitmap_aip, old->bitmap_aip, MAX_GPU_INSTANCE);
>> +	bitmap_copy(new->bitmap_mapped, old->bitmap_mapped, MAX_GPU_INSTANCE);
>>   	atomic_set(&new->queue_refcount, atomic_read(&old->queue_refcount));
>>   
>>   	return new;
>> @@ -2235,7 +2239,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>   		next_start = min(node->last, last) + 1;
>>   
>>   		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &&
>> -		    prange->mapped_to_gpu) {
>> +		    prange->mapping_done) {
>>   			/* nothing to do */
>>   		} else if (node->start < start || node->last > last) {
>>   			/* node intersects the update range and its attributes
>> @@ -2616,14 +2620,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>>   		s = max(start, pchild->start);
>>   		l = min(last, pchild->last);
>>   		if (l >= s)
>> -			svm_range_unmap_from_gpus(pchild, s, l, trigger);
>> +			svm_range_unmap_from_gpus(pchild, s, l, prange->bitmap_mapped, trigger);
>>   		svm_range_unmap_split(prange, pchild, start, last);
>>   		mutex_unlock(&pchild->lock);
>>   	}
>>   	s = max(start, prange->start);
>>   	l = min(last, prange->last);
>>   	if (l >= s)
>> -		svm_range_unmap_from_gpus(prange, s, l, trigger);
>> +		svm_range_unmap_from_gpus(prange, s, l, prange->bitmap_mapped, trigger);
>>   	svm_range_unmap_split(prange, prange, start, last);
>>   
>>   	if (unmap_parent)
>> @@ -3706,6 +3710,23 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>>   	svm_range_bo_unref(svm_bo);
>>   }
>>   
>> +static bool svm_range_needs_unmap(struct kfd_process *p, struct svm_range *prange)
>> +{
>> +	if (bitmap_empty(prange->bitmap_needs_unmap, MAX_GPU_INSTANCE))
>> +		return false;
>> +
>> +	pr_debug("prange 0x%p no access set for [0x%lx 0x%lx]\n",
>> +		 prange, prange->start, prange->last);
>> +
>> +	svm_range_unmap_from_gpus(prange, prange->start,
>> +				  prange->last, prange->bitmap_needs_unmap,
>> +				  KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>> +
>> +	bitmap_clear(prange->bitmap_needs_unmap, 0, MAX_GPU_INSTANCE);
>> +
>> +	return bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>> +}
>> +
>>   static int
>>   svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   		   uint64_t start, uint64_t size, uint32_t nattr,
>> @@ -3761,10 +3782,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   		svm_range_add_to_svms(prange);
>>   		svm_range_add_notifier_locked(mm, prange);
>>   	}
>> -	list_for_each_entry(prange, &update_list, update_list) {
>> +
>> +	list_for_each_entry(prange, &update_list, update_list)
>>   		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
>> -		/* TODO: unmap ranges from GPU that lost access */
>> -	}
>> +
>>   	update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
>>   
>>   	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
>> @@ -3785,6 +3806,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   	list_for_each_entry(prange, &update_list, update_list) {
>>   		bool migrated;
>>   
>> +		if (svm_range_needs_unmap(p, prange))
>> +			continue;
>> +
>>   		mutex_lock(&prange->migrate_mutex);
>>   
>>   		r = svm_range_trigger_migration(mm, prange, &migrated);
>> @@ -3793,7 +3817,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   
>>   		if (migrated && (!p->xnack_enabled ||
>>   		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>> -		    prange->mapped_to_gpu) {
>> +		    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE)) {
>>   			pr_debug("restore_work will update mappings of GPUs\n");
>>   			mutex_unlock(&prange->migrate_mutex);
>>   			continue;
>> @@ -3804,7 +3828,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   			continue;
>>   		}
>>   
>> -		flush_tlb = !migrated && update_mapping && prange->mapped_to_gpu;
>> +		flush_tlb = !migrated && update_mapping &&
>> +			    !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>>   
>>   		r = svm_range_validate_and_map(mm, prange->start, prange->last, prange,
>>   					       MAX_GPU_INSTANCE, true, true, flush_tlb);
>> @@ -3818,11 +3843,13 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   	}
>>   
>>   	list_for_each_entry(prange, &remap_list, update_list) {
>> +		flush_tlb = !bitmap_empty(prange->bitmap_mapped, MAX_GPU_INSTANCE);
>> +
>>   		pr_debug("Remapping prange 0x%p [0x%lx 0x%lx]\n",
>>   			 prange, prange->start, prange->last);
>>   		mutex_lock(&prange->migrate_mutex);
>>   		r = svm_range_validate_and_map(mm,  prange->start, prange->last, prange,
>> -					       MAX_GPU_INSTANCE, true, true, prange->mapped_to_gpu);
>> +					       MAX_GPU_INSTANCE, true, true, flush_tlb);
>>   		if (r)
>>   			pr_debug("failed %d on remap svm range\n", r);
>>   		mutex_unlock(&prange->migrate_mutex);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index a63dfc95b602..0da635532aff 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -100,6 +100,9 @@ struct svm_work_list_item {
>>    * @child_list: list header for split ranges which are not added to svms yet
>>    * @bitmap_access: index bitmap of GPUs which can access the range
>>    * @bitmap_aip: index bitmap of GPUs which can access the range in place
>> + * @bitmap_needs_unmap: index bitmap of GPUs which currently set NO_ACCESS
>> + * @bitmap_mapped: index bitmap of GPUs which currently have the range mapped
>> + * @mapping_done: true if range_validate_and_map complete successfully
>>    *
>>    * Data structure for virtual memory range shared by CPU and GPUs, it can be
>>    * allocated from system memory ram or device vram, and migrate from ram to vram
>> @@ -135,7 +138,9 @@ struct svm_range {
>>   	struct list_head		child_list;
>>   	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
>>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>> -	bool				mapped_to_gpu;
>> +	DECLARE_BITMAP(bitmap_needs_unmap, MAX_GPU_INSTANCE);
>> +	DECLARE_BITMAP(bitmap_mapped, MAX_GPU_INSTANCE);
>> +	bool				mapping_done;
>>   	atomic_t			queue_refcount;
>>   };
>>   
--------------reEONlNOGNexJT0R2QPJhLUN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-06-17 12:15, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a0e9c13f-aea7-437a-8134-0bdf52b57aac@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 6/16/2026 4:16 PM, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20260616211652.1962285-2-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">When KFD_IOCTL_SVM_ATTR_NO_ACCESS is applied to all GPUs that have an
SVM range mapped, unmap the range so the MMU notifier can skip queue
eviction — safe because no GPU will access it.</pre>
      </blockquote>
      <p><span style="white-space: pre-wrap">KFD_IOCTL_SVM_ATTR_NO_ACCESS </span>means
        shadder will not access this prange on a gpu. It does not mean
        driver needs unmap this prange.</p>
      <p>At MMU notifier stop queue or not should be decided by affected
        prange's access attributions:&nbsp;</p>
      <p>KFD_IOCTL_SVM_ATTR_ACCESS,<br>
        KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE,<br>
        KFD_IOCTL_SVM_ATTR_NO_ACCESS,</p>
      <p>or&nbsp;</p>
      <p>bitmap_access/bitmap_aip.</p>
      <p>Current kfd uses mapping info to decide evict queue at MMU
        notifier. I think it is not right. Should use prange access
        attributions that are from user to decide whether stop queue on
        this gpu. If user has specified&nbsp;KFD_IOCTL_SVM_ATTR_NO_ACCESS on
        this prange and this gpu driver does not need stop queue on this
        gpu at&nbsp; MMU notifier.</p>
    </blockquote>
    <p>I strongly disagree with this. The kernel mode driver cannot
      trust user mode. User mode could say &quot;no access, I'm not accessing
      this any more&quot; and then access it anyway. In the MMU notifier, the
      kernel mode driver must guarantee that the memory will no longer
      be accessed. It either has to unmap it from the page table or stop
      the user mode queue. There is no way around it.</p>
    <p>Stopping user mode queues has a large performance overhead if
      done frequently. So we are trying to minimize that by unmapping
      memory that's no longer accessed. That's what this patch is about.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:a0e9c13f-aea7-437a-8134-0bdf52b57aac@amd.com">
      <p>This patch seems introducing unnecessary complications if the
        goal is to not stop queue at MMU notifier when&nbsp;<span style="white-space: pre-wrap">KFD_IOCTL_SVM_ATTR_NO_ACCESS has been specified by user. Driver should use prange access attributions to decide queue eviction at MMU notifier. </span></p>
      <p><span style="white-space: pre-wrap">And access attributions can be dynamically changed. User component can change a prange from no_access to access(or access to no_access) at runtime, then driver has to remap the prange if it had been unmapped during no_access. In other words mapping is not exact equivalent to accessing. </span></p>
      <p>Regards</p>
      <p>Xiaogang</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20260616211652.1962285-2-Philip.Yang@amd.com">
        <pre wrap="" class="moz-quote-pre">Replace the mapped_to_gpu boolean with bitmap_mapped to track which
GPUs currently have the range mapped. Set bits in svm_range_map_to_gpus()
and clear them in svm_range_unmap_from_gpus(). This is separate from
bitmap_access/bitmap_aip which track user-requested attributes and must
not be used to determine mapping state.

Add bitmap_needs_unmap to svm_range, set when a GPU is given no-access.
Add svm_range_needs_unmap() to trigger the unmap once bitmap_needs_unmap
equals bitmap_mapped, i.e. all mapped GPUs are set to no-access.

v4:
 - Rename and set prange-&gt;mapping_done to false if validate and map not
   complete successfully (Felix)
v3:
 - Correct error handling, support app retry update mapping (Felix)
v2:
 - Add bitmap_mapped to not break get_attr (Felix)

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com" moz-do-not-send="true">&lt;felix.kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 103 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
 3 files changed, 73 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461168..5d55407069a4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -111,12 +111,11 @@ static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u6
 		if (!prange)
 			break;
 
-		if (!prange-&gt;mapped_to_gpu)
-			break;
-
 		r = kfd_process_gpuid_from_node(p, pdd-&gt;dev, &amp;gpuid, &amp;gpuidx);
 		if (r &lt; 0)
 			break;
+		if (!test_bit(gpuidx, prange-&gt;bitmap_mapped))
+			break;
 		if (!test_bit(gpuidx, prange-&gt;bitmap_access) &amp;&amp;
 		    !test_bit(gpuidx, prange-&gt;bitmap_aip))
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index df7fca65e9a2..e039b6f2942f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -786,6 +786,7 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
 				bitmap_clear(prange-&gt;bitmap_access, gpuidx, 1);
 				bitmap_clear(prange-&gt;bitmap_aip, gpuidx, 1);
+				bitmap_set(prange-&gt;bitmap_needs_unmap, gpuidx, 1);
 			} else if (attrs[i].type == KFD_IOCTL_SVM_ATTR_ACCESS) {
 				bitmap_set(prange-&gt;bitmap_access, gpuidx, 1);
 				bitmap_clear(prange-&gt;bitmap_aip, gpuidx, 1);
@@ -1076,9 +1077,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
+	new-&gt;mapping_done = old-&gt;mapping_done;
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
+	bitmap_copy(new-&gt;bitmap_mapped, old-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
 	atomic_set(&amp;new-&gt;queue_refcount, atomic_read(&amp;old-&gt;queue_refcount));
 
 	return 0;
@@ -1379,7 +1381,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
-			  unsigned long last, uint32_t trigger)
+			  unsigned long last, unsigned long *bitmap_unmap,
+			  uint32_t trigger)
 {
 	struct kfd_process_device *pdd;
 	struct dma_fence *fence = NULL;
@@ -1387,21 +1390,15 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	uint32_t gpuidx;
 	int r = 0;
 
-	if (!prange-&gt;mapped_to_gpu) {
-		pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n&quot;,
-			 prange, prange-&gt;start, prange-&gt;last);
-		return 0;
-	}
-
-	if (prange-&gt;start == start &amp;&amp; prange-&gt;last == last) {
-		pr_debug(&quot;unmap svms 0x%p prange 0x%p\n&quot;, prange-&gt;svms, prange);
-		prange-&gt;mapped_to_gpu = false;
-	}
-
 	p = container_of(prange-&gt;svms, struct kfd_process, svms);
 
-	for_each_or_bit(gpuidx, prange-&gt;bitmap_access, prange-&gt;bitmap_aip, MAX_GPU_INSTANCE) {
-		pr_debug(&quot;unmap from gpu idx 0x%x\n&quot;, gpuidx);
+	for_each_set_bit(gpuidx, bitmap_unmap, MAX_GPU_INSTANCE) {
+		if (prange-&gt;start == start &amp;&amp; prange-&gt;last == last) {
+			pr_debug(&quot;unmap svms 0x%p prange 0x%p from gpu_idx 0x%x\n&quot;,
+				 prange-&gt;svms, prange, gpuidx);
+			clear_bit(gpuidx, prange-&gt;bitmap_mapped);
+		}
+
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
 		if (!pdd) {
 			pr_debug(&quot;failed to find device idx %d\n&quot;, gpuidx);
@@ -1554,6 +1551,8 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
+		set_bit(gpuidx, prange-&gt;bitmap_mapped);
+
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
 					 prange-&gt;dma_addr[gpuidx],
 					 bo_adev, wait ? &amp;fence : NULL,
@@ -1699,7 +1698,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		bitmap_zero(ctx-&gt;bitmap, MAX_GPU_INSTANCE);
 		bitmap_set(ctx-&gt;bitmap, gpuidx, 1);
 	} else if (ctx-&gt;process-&gt;xnack_enabled) {
-		bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_aip, MAX_GPU_INSTANCE);
+		/* Update mapping on already mapped or access in place GPU */
+		bitmap_or(ctx-&gt;bitmap, prange-&gt;bitmap_mapped, prange-&gt;bitmap_aip,
+			  MAX_GPU_INSTANCE);
 
 		/* If prefetch range to GPU, or GPU retry fault migrate range to
 		 * GPU, which has ACCESS attribute to the range, create mapping
@@ -1719,14 +1720,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		/*
-		 * If prange is already mapped or with always mapped flag,
-		 * update mapping on GPUs with ACCESS attribute
+		 * If prange with always mapped flag, update mapping on GPUs with
+		 * ACCESS attribute
 		 */
-		if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)) {
-			if (prange-&gt;mapped_to_gpu ||
-			    prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
-				bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_access, MAX_GPU_INSTANCE);
-		}
+		if (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+			bitmap_or(ctx-&gt;bitmap, ctx-&gt;bitmap, prange-&gt;bitmap_access,
+				  MAX_GPU_INSTANCE);
 	} else {
 		bitmap_or(ctx-&gt;bitmap, prange-&gt;bitmap_access,
 			  prange-&gt;bitmap_aip, MAX_GPU_INSTANCE);
@@ -1792,6 +1791,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 				e = min(end, prange-&gt;last);
 				if (e &gt;= s)
 					r = svm_range_unmap_from_gpus(prange, s, e,
+						       prange-&gt;bitmap_mapped,
 						       KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
 				svm_range_unlock(prange);
 				/* If unmap returns non-zero, we'll bail on the next for loop
@@ -1854,7 +1854,9 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r &amp;&amp; next == end)
-			prange-&gt;mapped_to_gpu = true;
+			prange-&gt;mapping_done = true;
+		else
+			prange-&gt;mapping_done = false;
 
 		svm_range_unlock(prange);
 
@@ -2024,10 +2026,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p-&gt;xnack_enabled ||
 	    (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
-		bool mapped = prange-&gt;mapped_to_gpu;
+		bool mapped = !bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
 
 		list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
-			if (!pchild-&gt;mapped_to_gpu)
+			if (bitmap_empty(pchild-&gt;bitmap_mapped, MAX_GPU_INSTANCE))
 				continue;
 			mapped = true;
 			mutex_lock_nested(&amp;pchild-&gt;lock, 1);
@@ -2076,13 +2078,14 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			s = max(start, pchild-&gt;start);
 			l = min(last, pchild-&gt;last);
 			if (l &gt;= s)
-				svm_range_unmap_from_gpus(pchild, s, l, trigger);
+				svm_range_unmap_from_gpus(pchild, s, l, prange-&gt;bitmap_mapped,
+							  trigger);
 			mutex_unlock(&amp;pchild-&gt;lock);
 		}
 		s = max(start, prange-&gt;start);
 		l = min(last, prange-&gt;last);
 		if (l &gt;= s)
-			svm_range_unmap_from_gpus(prange, s, l, trigger);
+			svm_range_unmap_from_gpus(prange, s, l, prange-&gt;bitmap_mapped, trigger);
 	}
 
 	return r;
@@ -2112,10 +2115,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
+	new-&gt;mapping_done = old-&gt;mapping_done;
 	new-&gt;vram_pages = old-&gt;vram_pages;
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
+	bitmap_copy(new-&gt;bitmap_mapped, old-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
 	atomic_set(&amp;new-&gt;queue_refcount, atomic_read(&amp;old-&gt;queue_refcount));
 
 	return new;
@@ -2235,7 +2239,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node-&gt;last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+		    prange-&gt;mapping_done) {
 			/* nothing to do */
 		} else if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
 			/* node intersects the update range and its attributes
@@ -2616,14 +2620,14 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 		s = max(start, pchild-&gt;start);
 		l = min(last, pchild-&gt;last);
 		if (l &gt;= s)
-			svm_range_unmap_from_gpus(pchild, s, l, trigger);
+			svm_range_unmap_from_gpus(pchild, s, l, prange-&gt;bitmap_mapped, trigger);
 		svm_range_unmap_split(prange, pchild, start, last);
 		mutex_unlock(&amp;pchild-&gt;lock);
 	}
 	s = max(start, prange-&gt;start);
 	l = min(last, prange-&gt;last);
 	if (l &gt;= s)
-		svm_range_unmap_from_gpus(prange, s, l, trigger);
+		svm_range_unmap_from_gpus(prange, s, l, prange-&gt;bitmap_mapped, trigger);
 	svm_range_unmap_split(prange, prange, start, last);
 
 	if (unmap_parent)
@@ -3706,6 +3710,23 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	svm_range_bo_unref(svm_bo);
 }
 
+static bool svm_range_needs_unmap(struct kfd_process *p, struct svm_range *prange)
+{
+	if (bitmap_empty(prange-&gt;bitmap_needs_unmap, MAX_GPU_INSTANCE))
+		return false;
+
+	pr_debug(&quot;prange 0x%p no access set for [0x%lx 0x%lx]\n&quot;,
+		 prange, prange-&gt;start, prange-&gt;last);
+
+	svm_range_unmap_from_gpus(prange, prange-&gt;start,
+				  prange-&gt;last, prange-&gt;bitmap_needs_unmap,
+				  KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
+
+	bitmap_clear(prange-&gt;bitmap_needs_unmap, 0, MAX_GPU_INSTANCE);
+
+	return bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
+}
+
 static int
 svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		   uint64_t start, uint64_t size, uint32_t nattr,
@@ -3761,10 +3782,10 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		svm_range_add_to_svms(prange);
 		svm_range_add_notifier_locked(mm, prange);
 	}
-	list_for_each_entry(prange, &amp;update_list, update_list) {
+
+	list_for_each_entry(prange, &amp;update_list, update_list)
 		svm_range_apply_attrs(p, prange, nattr, attrs, &amp;update_mapping);
-		/* TODO: unmap ranges from GPU that lost access */
-	}
+
 	update_mapping |= !p-&gt;xnack_enabled &amp;&amp; !list_empty(&amp;remap_list);
 
 	list_for_each_entry_safe(prange, next, &amp;remove_list, update_list) {
@@ -3785,6 +3806,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	list_for_each_entry(prange, &amp;update_list, update_list) {
 		bool migrated;
 
+		if (svm_range_needs_unmap(p, prange))
+			continue;
+
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 
 		r = svm_range_trigger_migration(mm, prange, &amp;migrated);
@@ -3793,7 +3817,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated &amp;&amp; (!p-&gt;xnack_enabled ||
 		    (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+		    !bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE)) {
 			pr_debug(&quot;restore_work will update mappings of GPUs\n&quot;);
 			mutex_unlock(&amp;prange-&gt;migrate_mutex);
 			continue;
@@ -3804,7 +3828,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; prange-&gt;mapped_to_gpu;
+		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp;
+			    !bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
 
 		r = svm_range_validate_and_map(mm, prange-&gt;start, prange-&gt;last, prange,
 					       MAX_GPU_INSTANCE, true, true, flush_tlb);
@@ -3818,11 +3843,13 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 
 	list_for_each_entry(prange, &amp;remap_list, update_list) {
+		flush_tlb = !bitmap_empty(prange-&gt;bitmap_mapped, MAX_GPU_INSTANCE);
+
 		pr_debug(&quot;Remapping prange 0x%p [0x%lx 0x%lx]\n&quot;,
 			 prange, prange-&gt;start, prange-&gt;last);
 		mutex_lock(&amp;prange-&gt;migrate_mutex);
 		r = svm_range_validate_and_map(mm,  prange-&gt;start, prange-&gt;last, prange,
-					       MAX_GPU_INSTANCE, true, true, prange-&gt;mapped_to_gpu);
+					       MAX_GPU_INSTANCE, true, true, flush_tlb);
 		if (r)
 			pr_debug(&quot;failed %d on remap svm range\n&quot;, r);
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index a63dfc95b602..0da635532aff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -100,6 +100,9 @@ struct svm_work_list_item {
  * @child_list: list header for split ranges which are not added to svms yet
  * @bitmap_access: index bitmap of GPUs which can access the range
  * @bitmap_aip: index bitmap of GPUs which can access the range in place
+ * @bitmap_needs_unmap: index bitmap of GPUs which currently set NO_ACCESS
+ * @bitmap_mapped: index bitmap of GPUs which currently have the range mapped
+ * @mapping_done: true if range_validate_and_map complete successfully
  *
  * Data structure for virtual memory range shared by CPU and GPUs, it can be
  * allocated from system memory ram or device vram, and migrate from ram to vram
@@ -135,7 +138,9 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				mapped_to_gpu;
+	DECLARE_BITMAP(bitmap_needs_unmap, MAX_GPU_INSTANCE);
+	DECLARE_BITMAP(bitmap_mapped, MAX_GPU_INSTANCE);
+	bool				mapping_done;
 	atomic_t			queue_refcount;
 };
 
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------reEONlNOGNexJT0R2QPJhLUN--
