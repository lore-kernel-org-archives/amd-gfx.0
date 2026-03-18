Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93784103E187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBB110E827;
	Wed, 18 Mar 2026 14:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rU/J+Tlh";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469A010E04B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJbI5Ww3kxd1tf+SQ6gAX6MV03q0ZhuQtaGCFxgCH21Afblb8Go5Wac+7E9lt8NVmR0E3Dffgo8y8jyYt4fO209YVDiqkN3izyPIGzxWTI47GJ4goTOwfi6bgEIFRI8G1J/cfrrXAQklrgjA9OVDqIAk0QXzLRaafOcDk7RQOF5fmvpkNdMx2dU1dD2AwpTVKLAEv5d8mYfBRHakEEmTXkY4M7Y7gp3lFJ0cPP1w0C0fTBgc6wK+ugmnmRAMWMs5cINhZ7Bbfo5Q6ISO9Bt9ugeG2nokCZvXB55w+SxDKUg+WVfn73olGCJmbHVYtTnbuu1FcZOItsd7e5OLk2JI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IkDzc8dLBiF2eWJ7bffvYPraTveo2Q5oSS3fGvq+Ns=;
 b=k8RfNF/k2aGIWOeoDXaw81dQ+z2zHLYzLnDGXIYJkbi4fLsvPcAJorTu6iQdS+MyLa+miaeRTMkVcLkZLGTzqG5yDtoJ5yODEPpr0ViCiVO8lCTL77poN/8wGgrdvlSRIpqZuyXEQbgilAd94xpJ/4ZSq5wbR2w171U5mMp4d7zmP3qZ+T8qFTpsDpqg2pyVfq+Ajm/VEtPK4q1c8N2Tmzfx80pSuB5ihBWyEMl71mwrT3a/Ah4ZyCEyf1d0ZV2NWKhNCmpu0N+5mHyY4ffOGhucnG+ScrsBG3Q0QCI7dmhPJhoSK2MsaxkbHFPtG/rnc1OSryYO7KuqieLdJ9m8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IkDzc8dLBiF2eWJ7bffvYPraTveo2Q5oSS3fGvq+Ns=;
 b=rU/J+Tlh2GOPaO1mKNw0arIujpw87deVj3AF8I8KVtF63qWzO0/DkhFDe70dur8e68RHftee1F58DIuWa9PDrdPLuXzgiCejpbx/G8DSCjPDnbMuMDamxKy1MxKeCRvtQnGNL4vwjmaaz+YgARale2uF3mje8LchFfpJrM7HI/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:03:36 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 14:03:35 +0000
Message-ID: <1aea95fb-2258-4736-b2d9-7bd2d4eab10b@amd.com>
Date: Wed, 18 Mar 2026 10:03:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prevent immediate PASID reuse case
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20260317185801.149610-1-jinhuieric.huang@amd.com>
 <8b4d0a73-159f-4434-b78b-6c086637ac5e@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <8b4d0a73-159f-4434-b78b-6c086637ac5e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 5317510a-3dd9-4106-a20d-08de84f72582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Ta3wOf5qpJ+QgAqnevY71ICL6KGvlySRFyp8pindT7K4KjfsWBRYFsfSPkbS8FoaO9ono3lM66TNB8dXmFz/UNh6iaDVdT8xRV8NsMdvnHyj6dXZHPPXcbHVSxL9aBej4eUeCMN6aw6RejJlrH718VkVky2Fi0cH86X4VfFsalr5vd/vT+98qCLIYiPBMrRdA+8AjLQW51Cs++mnjoW7vAdKjU83S+grjElQOD3g9SjWiwKzlMizD5v+NJcDuNB8s+X8n+PQTCVGMwDJ8Bul5fjMRniIBasvFte0CWnuf/O/ZG7YR16R96U7LiQE+3y1NsBRwyDcHphW2ogY9KzI0BiOWd3Yv1cmRGwURA4zL3ANXSJ/lpXuC52rFFpYWMyjndONeUzWnwgyUgouP02H8eC5lKl/C0gflKBtAtP/j20cjX11j3TlKnXmvnUfkASH7kV/LSb4ap0VnqcSpogdNe8yU43SmyfO/qeKR1X8kSkeZPaYpdikf+qP2AIlPUR6OOt1F9/BR4JM972QLN8FncvNBA8ihaL6c09pfTG1Jkh9bmDDgacq7y8jze2uuJpYS2sats7etPpIr4Uzo6x2vxlR57L0twOCPvboU+m4oTSE0c4DMxw7Zl9ejcNG+Fjf9UGFS/c1oAiihBtMuOmmNiw/V7CMxtiG26vzDP1dFms7OcqWezM5/rc6jy1je6hZdNKEeF1eTzrvRyVZU75IW7Rd+y0/NPwLxpGBvwjHCeIuVrYx9u5IKwNeSNkAxZDj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JZQ2tIeklPTjJJTlFiMEFZcjQ1RWNpMzNjdDl5VVgrUmt1R0ZyU0IxNDdo?=
 =?utf-8?B?RjZRNlJ5ZnQ4NFNtcFpybDhZV05SZENLdmxCdUxwa0QwVVlxUTVaRnM1dHZY?=
 =?utf-8?B?Z2g0aXlHN0tiNnF0eXdMR1VZQnRIaVgyUzViOUphQW5wMndhMVkyZXl4YlpV?=
 =?utf-8?B?ZytQLzNWc042U01UaU5JTmd6ZTJrdlpTSGZjdVAzVDJsRTZnSnBKTVJxVzd3?=
 =?utf-8?B?LzNnTmE5WHJ2SGtVR2o3cmVQV01hdEl1d2ZaZGFjY2dKRzFvb1lBZ3I3emZD?=
 =?utf-8?B?QVZSVldvT0ZpNFFEbG1UV1RVZVlrZGcxL3BLWnVwOXgvOGQ3NEFjc2VnUFdm?=
 =?utf-8?B?YUZzdTdzZFh2WGhxYWh4cDJmZ1BJREtBK1ViU1RqMHBTekxxbUFIZm5qOTAx?=
 =?utf-8?B?RTFVOXg1ZXlUSnBQVERST1RRTGlUZ0JzMHg2MSt5a0s3OWZTYlBTaFQ2SXYv?=
 =?utf-8?B?SHRFZ0JnamVIQ296akMzSDVybE43WDNaNmpBQm1aRzkweTBHOHRQeEM5SExF?=
 =?utf-8?B?bS9oeUh2WTFpdUY1N2ZpVHJKVVM0cVR0TFVuQWx3VU9jSWI2K3hxWUlFOWN0?=
 =?utf-8?B?bG5tZ1B4NDk5eFNGYVJURTA3Y1pRZ0tJelhwWlF3RkFLcWVtU3N4UTRiNlkv?=
 =?utf-8?B?TE1rL3hXT2w2eTdSS3FyNHVURWt1VzFlNmJYSkhDOFgyZC9FVGM0M0pxc0sz?=
 =?utf-8?B?dHJXb2FuN3R0citMSWtHbUYrT3RpNm04YU53ZHJFMkJjVXlncFFCZktqalRs?=
 =?utf-8?B?R0Y3U2QrSEpaZXRJcDNWVjNhemFWcE5DNVNEVEptbmtURmhuZ1k5MjdLNVA4?=
 =?utf-8?B?RzJ5MTB6aUh3V2kxbjliYzJGbFpzQzZ6OXB3Vy9KU3FNZ3IxcFVPbVp0dUFv?=
 =?utf-8?B?a25qZW5PbEp6QzE5b3pkUzkzU1VaUWFHYzc2L1hjdU9FZGhMaFZ3VDJlMHJS?=
 =?utf-8?B?QzBNYlRCVFRkMzJ6SS91aC9wazJ0eklUbisvNUc2ODNLV25mWkJBUjVDYzFB?=
 =?utf-8?B?QWNWMG45MDNqSFhLNHQwMFhwb2VKTnNxNXpmc3dnU2wxdndGKzlWbFJvOXlH?=
 =?utf-8?B?TENqUnBZWmZrb3JFVjNzNTJ0SU9CV2JaQ2JHMi84NmRLaStUUE1RSnBPYnd5?=
 =?utf-8?B?N1hnMW5IQ1VrVXFlaWg3RFNNSDgrRTVlVUhUaStjY2ZUUU42Q25ZQ2pDc2U0?=
 =?utf-8?B?Qzlmdm1KcEZxSXppbys2aGEvZytPL0M3R1dNSUhpbmlUSWczYndsVStMM0RB?=
 =?utf-8?B?cWZJQy8rVFFZZkdlek83dXYreVhrb2FyVmowRGd2NDY2QXJkVnBhRml1K1JF?=
 =?utf-8?B?dDFsTzdRL01Ob3EvVDg1YXBpMC9vdGI2ZWRFTmgvK2Qrdy85ODlmSkdRYUhD?=
 =?utf-8?B?UzBLZWVwYVNRbEx4T21qTkpwZWs5c1N2ZTd2a3lZL1oxQ2pkczhMU0VvS2x3?=
 =?utf-8?B?OXVqTXBnR0htSmFWVUJTZEZHNEVRbDlHUzBZTWtqa015VkxHSFpETmJ5bExZ?=
 =?utf-8?B?MjNPelZSaG5IeFJUNG1RNW1RcWFtYWxkOExRcXh5VFRxUkpNbmpqdGoxN003?=
 =?utf-8?B?Rkw5c0J1UTRobFpOOUMvSGRHdDZjYVVWcWt3TG0vRytjemlNdUpKQ2pqTTZ0?=
 =?utf-8?B?eU84WVhaaFBaOUJkUHhONlBkTUlBK3IvcVJHZnRndTkzS05yeEh1TVpxRjk4?=
 =?utf-8?B?eFFRM3dCUWovNGVHSVNmdXl5cnRpOWthejJQWis5RC9VazIyY1ZuRlhhQ2tD?=
 =?utf-8?B?QlB1TzI0eHRQV0VnQTJpSW5MZWNTMk9Td28vOXpONllIWCthMmJQeGtBTkNG?=
 =?utf-8?B?VXE3Z1NEMXJnbmpZeE1Ka09NSFdtRzc2elRmUzlmRXJEVkFIQ3dvUXhaUDUv?=
 =?utf-8?B?UlVrT3dKVi9XVDR3QkhVY1RJYmZQVzhhbmFtZjhnS1dFcjNlcll3Q3p6eGRQ?=
 =?utf-8?B?alk3SS9yK2hJWlg1K1N5R05MSjE3NlZRTkRlb0NzSDlRYjAxTVFKeHhiQ3FX?=
 =?utf-8?B?a1QxODBZOEVKL1B3NTFsbTFNSTRTQWtJdURRajhadldjYnRTNXFYdEVCSkVK?=
 =?utf-8?B?d0luRGg0ZFF5cXZJaEx4S3B6VDBLSG5GeTBqTkFCN3p2eWYrbFBBVE0xT21P?=
 =?utf-8?B?RWVrSTJzb0VsQ3BiYkMramtyUm1oQzR6WUdvV2ZDMDRXQTMvOVc2R0FRcnd4?=
 =?utf-8?B?MG1hMXQ2ZktpbngvbHFRazNZN3djVURVNTJGV2UxUWdGSFdLTzM3cFRZd3Rp?=
 =?utf-8?B?WVZBbHdDdlVGejdPME1GdDFpY0tTUkdWaUdFa2dZQUNuWUZHWkV5dWFGenVT?=
 =?utf-8?B?V0RnMlJwVXhjRDgwdGkrVytmWVU3VEhWSjMwQmJPQ2ZEL09IS2RFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5317510a-3dd9-4106-a20d-08de84f72582
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:03:35.6983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7G8p9yhOBKghA1JMkBr2wfZNIRWU2ixHfq0vYwnXErYLY4tYAg2TitykkPCd833EV1Jv5VVvguX6cbdDdaLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
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

On 2026-03-18 03:37, Christian König wrote:
> On 3/17/26 19:58, Eric Huang wrote:
>> PASID resue could cause cache, TLBs and interrupt issues
>> when process immediately runs into hw states left by previous
>> process exited with the same PASID, to prevent the case, it
>> uses the same allocator as kernel pid's.
> The implementation looks good now, but that is still not a good justification for the change.
>
> What potential HW state do we have which could cause problems here?
We do have an issue reported by customer 
https://ontrack-internal.amd.com/browse/SWDEV-578010, on which there are 
two apps, first app intentionally overflows a buffer, that causes bunch 
of GPU page faults, and then second app runs immediately and get 
unexpected page faults with the same pasid, so we have internal 
discussion and Felix think a proper solution would be in ID manager to 
make sure pasids don't get reused when there could still be outstanding 
interrupts in the IH ring with that pasid. That is the motivation for 
this change.

Regards,
Eric
>
> Regards,
> Christian.
>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 45 ++++++++++++++++++-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  1 +
>>   3 files changed, 34 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 9cab36322c16..0801c023f5a5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -35,10 +35,13 @@
>>    * PASIDs are global address space identifiers that can be shared
>>    * between the GPU, an IOMMU and the driver. VMs on different devices
>>    * may use the same PASID if they share the same address
>> - * space. Therefore PASIDs are allocated using a global IDA. VMs are
>> - * looked up from the PASID per amdgpu_device.
>> + * space. Therefore PASIDs are allocated using IDR cyclic allocator
>> + * (similar to kernel PID allocation) which naturally delays reuse.
>> + * VMs are looked up from the PASID per amdgpu_device.
>>    */
>> -static DEFINE_IDA(amdgpu_pasid_ida);
>> +
>> +static DEFINE_IDR(amdgpu_pasid_idr);
>> +static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
>>   
>>   /* Helper to free pasid from a fence callback */
>>   struct amdgpu_pasid_cb {
>> @@ -50,8 +53,8 @@ struct amdgpu_pasid_cb {
>>    * amdgpu_pasid_alloc - Allocate a PASID
>>    * @bits: Maximum width of the PASID in bits, must be at least 1
>>    *
>> - * Allocates a PASID of the given width while keeping smaller PASIDs
>> - * available if possible.
>> + * Uses kernel's IDR cyclic allocator (same as PID allocation).
>> + * Allocates sequentially with automatic wrap-around.
>>    *
>>    * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>>    * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
>> @@ -59,14 +62,15 @@ struct amdgpu_pasid_cb {
>>    */
>>   int amdgpu_pasid_alloc(unsigned int bits)
>>   {
>> -	int pasid = -EINVAL;
>> +	int pasid;
>>   
>> -	for (bits = min(bits, 31U); bits > 0; bits--) {
>> -		pasid = ida_alloc_range(&amdgpu_pasid_ida, 1U << (bits - 1),
>> -					(1U << bits) - 1, GFP_KERNEL);
>> -		if (pasid != -ENOSPC)
>> -			break;
>> -	}
>> +	if (bits == 0)
>> +		return -EINVAL;
>> +
>> +	spin_lock(&amdgpu_pasid_idr_lock);
>> +	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
>> +			         1U << bits, GFP_KERNEL);
>> +	spin_unlock(&amdgpu_pasid_idr_lock);
>>   
>>   	if (pasid >= 0)
>>   		trace_amdgpu_pasid_allocated(pasid);
>> @@ -81,7 +85,10 @@ int amdgpu_pasid_alloc(unsigned int bits)
>>   void amdgpu_pasid_free(u32 pasid)
>>   {
>>   	trace_amdgpu_pasid_freed(pasid);
>> -	ida_free(&amdgpu_pasid_ida, pasid);
>> +
>> +	spin_lock(&amdgpu_pasid_idr_lock);
>> +	idr_remove(&amdgpu_pasid_idr, pasid);
>> +	spin_unlock(&amdgpu_pasid_idr_lock);
>>   }
>>   
>>   static void amdgpu_pasid_free_cb(struct dma_fence *fence,
>> @@ -616,3 +623,15 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>>   		}
>>   	}
>>   }
>> +
>> +/**
>> + * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
>> + *
>> + * Cleanup the IDR allocator.
>> + */
>> +void amdgpu_pasid_mgr_cleanup(void)
>> +{
>> +	spin_lock(&amdgpu_pasid_idr_lock);
>> +	idr_destroy(&amdgpu_pasid_idr);
>> +	spin_unlock(&amdgpu_pasid_idr_lock);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> index b3649cd3af56..a57919478d3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
>> @@ -74,6 +74,7 @@ int amdgpu_pasid_alloc(unsigned int bits);
>>   void amdgpu_pasid_free(u32 pasid);
>>   void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>>   			       u32 pasid);
>> +void amdgpu_pasid_mgr_cleanup(void);
>>   
>>   bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>>   			       struct amdgpu_vmid *id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index b89013a6aa0b..5b9bdb79efcf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2864,6 +2864,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>>   	xa_destroy(&adev->vm_manager.pasids);
>>   
>>   	amdgpu_vmid_mgr_fini(adev);
>> +	amdgpu_pasid_mgr_cleanup();
>>   }
>>   
>>   /**

