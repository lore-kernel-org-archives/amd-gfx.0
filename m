Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE10EF30928
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 09:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6061D10EBE1;
	Thu,  5 Mar 2026 09:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKPLRqFo";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6DB10EBE1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 09:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt0UW5BC1yePueaq0qP5rma9jKpxkbBuy100WNUWVoyHF9trzpRy47AiWPNlm9UBWGPb3wpY0g0vCCpTsqmyYEO/oZGPquyK/MO4jfDUlbntt8otLq3jgAPl5LnEmfs8MlBBn4bTZv4QPtpzLIbEVjK0khD/SyURNS/1NYEQLYkVwFi+nAgvpTHDOTu6vyT3bjp55UN4XZTa4DJryNnw2y+WXdTnEtnn/C4JEWZIcTD7gtmF2LRM2eRhohuVxhgaPwB9b1DbzNNlh29QwL3qHGl4AmBlRm7XulXVkv0BXEK9uqXLTxkFzqKSW+bSQ8tFYZgbgBWUTevGnU4NayB8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyLvH112mTc/f9ROPxGlb73zdexeqVGse+Hn4gZSxwk=;
 b=vRSVofty0M9LE9nfyEOdAbtmKJuuwmc9mNASDWPRfVbo0QUaAVCV8mVBZhBO6qTYGPPBO5kbmUfKRsUUBd3RHoz2Kje55yjdLtu9STjAwPuF5RWsicCQzMh77jmzMNPGIk7y/Le0L4blMKGtfT6tkvG0qLuFP8Shpghyi1a8wq42cfD5SAbVNj8FjQjBXafX+Ie424AVpSS6KhxSusfjBTJYES3dOT4FkTWy25qwOYYCL+pDN0pU13gcLwDA6UzZGM+5Pvr11RvDumIhkYT5DjScyWwdTIZlmIITrefhPWajRQ/FcbolZjCfRqbSVBjeTW4UUFH1Vh56KpyTxPgtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyLvH112mTc/f9ROPxGlb73zdexeqVGse+Hn4gZSxwk=;
 b=FKPLRqFo7pDlOX/cBCjjhC783rbceArXt3TgnQ/05En86CvTeUA8qMLe2/9mFXcGAQUHAllfpmSir5T3YQn3q4spQhSQnUggzhOcAgZ6VTnwiE03pbNzhRwgM7D7cXghf2veTh1t3wzJcmWLDqH0dXqVQfQIFjdBDPbPxkx3Q6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 5 Mar
 2026 09:43:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 09:43:30 +0000
Message-ID: <541ae425-cd9b-4088-addf-0a212df9dd8e@amd.com>
Date: Thu, 5 Mar 2026 10:43:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260304135425.18729-1-alexander.deucher@amd.com>
 <bae8f0a1-2dba-4286-ae28-78f0a3c63faa@amd.com>
 <MN0PR12MB6004C9B59FDA8BDC2F45AD32FB7DA@MN0PR12MB6004.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MN0PR12MB6004C9B59FDA8BDC2F45AD32FB7DA@MN0PR12MB6004.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: e30c4621-110a-4c88-ec1d-08de7a9ba8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: dGRwgbsvSopqLny/r09lj+08BnyDaYgSmrftkPPH/xYYB0FGY6qkZJ9Vlu7C5H4gKglzhhJX/ZNam03PjYZAk0z0vZzzn7hP+7dAOJ61gdedYRQZ6oAZcWEjKQ/gBujcQkCvD5kxztHdlikW0phzOxIpl5SkeQuoZIcjYd0swpBlMaKtFStn5vQCAahoTZj4vENbilPo+gGCuh5JhTQBYLg2xErNN2okFXf0TEuuAgfDhFjZ0q+YVFbtBnY5D8GlDBIFYSm1WhhbMSyj3YgMIrGpQaPXYc10bwm1FDwuW9YJ7rSPH0Pd11iPYH/fQQ2P6XTcv4BziNATksspEWSOcjM5dx/QXt6j2zkWTyZfO/ANQj9awM5M5mvBqfm9SgAuR1oFsZB+1wlLr0s4hAlqxVDTjnewqWHeh5HO6mxH8HO7xdjJxREre760QdhmdYxUVgjQAdC7lDcNjJCuq3J4MKa5jlNlo8lgPlvrNLwslqRqnNV3+BuA5bP/+z28r4mwj+ovod8NL5bVgxad4uvb37WxEyBhApXq3Oy4QYFLnfoiv1zPojD9IKLAIrW6ytHAytRfYCnBmCVf37wSb1ascexxIV8p5qDDDFxmc2MXqWhdePrQn1Ay8dh/W10Qi9XRR+jGnO4BVYsWg+7q1DJlNVOfzWgZxaj2HZ5uGsbECSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNacmxnM0ZyWEo0K1I4V3h5bGJUclFoM1Rvc1dXcVhRcUxCelNCSXBmTnBs?=
 =?utf-8?B?R1BHcDlkNUhVUXlzdkVoNlE0RXl3S2gzQVpPMFZjc3M4dHgwTmxuT3ZqWmYr?=
 =?utf-8?B?cm5BcGJBM0JCMW41M050VW5VaG9MQTRRaFc5emE2RW1rWFFSRUUvMXkvNlJC?=
 =?utf-8?B?bldwVXI3Q2lVM0VkVW9IYllWenFteFZHdjBtS3ZqOHllRjhhSEZoWmc0MGp3?=
 =?utf-8?B?dTE3emRGcFJtcTdXNVA1djlLRVZ0RVFSYWFtK1pnNTRxQ3dKWnozUEtOUVBn?=
 =?utf-8?B?QlFFMTBvRHVaQU84Vnp5eDl1L2Jmb1NpWVJHWmlManRJalFnQUhmZWVCWk8v?=
 =?utf-8?B?Y0J6NEI4MExxTDlsVExzczlPZWd2VmxFRWZaZVVtRVkvRVRUMExBeUVGQTBB?=
 =?utf-8?B?RU1tQnRkZW9VZW51bFhpT1ZaUms0ZEs1YzFJRC80bHBLRmM3VWtTdkgxOTBF?=
 =?utf-8?B?M2dKb1QrWTlJNnpMR1g3VkdVRlpZbkxTTFArNFNPTEpVZXNoTW4wTFRvWFBm?=
 =?utf-8?B?WHVSSE1Ed0ljN1N2dmpzNGhFZkNoWWZ5R1h0eUJBKzNXWU5YMmY0SkZMSEpt?=
 =?utf-8?B?NkJ1UEJWMnZqWkVpcmxlUlVKN0F5bmlvdXpBWGltZGIwRzd5QTJpRlQyWEM2?=
 =?utf-8?B?OVR1eGFrWWhIUHlCMExDYTFJNDk4Wit2V2hBSWNrZnFsNVFpSUFucThjVzZh?=
 =?utf-8?B?VTVqVFBCN0tTQ1ErancxS0tmSDhtQ25FU3dWUDc5WTVsdzBCUFhta2Vwa25x?=
 =?utf-8?B?aWNHRXp0RzFGVFpWcDdabVRMbzBBcG54eHJVSFliMTgzMGJsTk1KRVF2QXkr?=
 =?utf-8?B?MjFwaHhrcExJVUxZZUs5b215S011d3plbEtpWTlIV3Nhd2JhYXdSV0kxRmd3?=
 =?utf-8?B?ZnZIUGNndSt5LzJ5OFpWZ2lvWG5SU0NPSzhkeXJya3pGazduSjhqWUR4cm9J?=
 =?utf-8?B?emdYSzlRMFlBVitNamsrY3dLVkM3TjRSS2hjNWpTQ2FqaGhObndsZHI0R3c3?=
 =?utf-8?B?cjhSQkd6alQ1QzE4N055akpsVmowcmsvZXozY0sySVJoT3FOajZNdUJmS1E4?=
 =?utf-8?B?cWpseFJmNE41N20xbU5ZOVhLVTJ3Y0s5UG9RbnNkamJJTnRieTBNYkwyWlkv?=
 =?utf-8?B?cHQwRWN3enhkYkxvU1J6M2VDNUxDTkpwMC9FMEY5WncxZDJzRkVEYnZuZWI3?=
 =?utf-8?B?NXZkVzUveVhsK2hwK05hZFo3Zzd3YjZtSExFTkgyaitseHRCejdDUllmYUZq?=
 =?utf-8?B?dEQ0d3NvNzh0TTQvR1Vmb3MzSnJyRGRrR29iK24zNSt1aHVMaVBpbFFoOUZj?=
 =?utf-8?B?RmRaZEJHZFp4TFZZRWxEMnpzZ1VhUTBEV1ZxUHlvOVVsbVc3VDJESkIvaDZH?=
 =?utf-8?B?VWVUZnFxdDV2VXZncitCbjhHS0R3bGVuYjJFaGhQRnA1TSthRm8vNjlrNk1W?=
 =?utf-8?B?TGpGYlZKR1Z5bWFrRVdYL2pZVHRYQlA3WDJ3QzFjZThaUU5WMWJYOGdXZFNv?=
 =?utf-8?B?RFpSanVCSXFUVXdoY24yUlZocHgwR1BkeEFTNEtQSzFXNFJUZVFCWk12UGJy?=
 =?utf-8?B?SlE2SE1tUUVEWnB3VVBTaTZJVDhNSWQ0Rm05eDlGa2pBTTAzRU9VTVptNmtL?=
 =?utf-8?B?RWRUMGZMelZoYzZJb1hwZnZqZG94dHV3Z3RHSmlkcWcxbTBuV1RjUGs0VmZL?=
 =?utf-8?B?R00yZ3JOaXdXelNQUjhVSUNjUnRncTBhdkZZYWRxWlRBT2kyT2VuNlJtTkRL?=
 =?utf-8?B?WU5BdVkzMDFnQ2Z6RkxSb3EyMmU4dnFTSzh3ZE41WGZ6a0lhVVRkSE4rR2JK?=
 =?utf-8?B?VGNDaHorUGJ2OFlYYlBycWVRdUhIc2VsWUVRTkJpSHNhQ2JUcVZmZ1QrNG1Q?=
 =?utf-8?B?YmFWdXBjM0xQU0RTYVNuOWk2SHlOZXhORUhkY2dDWGc1ajluM0Noa2NESXc1?=
 =?utf-8?B?OUxVMmlXRlBCK3NHUEE1U0JXWUJubGd1VS9GMzJwZmErTm9NM081RHZjYmZW?=
 =?utf-8?B?Y0EraFdvSDYwaU9nYkhnWEZwT01mcmxWcXJUUzFMbWFwYlNvblJUY2Jlakd4?=
 =?utf-8?B?RUVnd01IaFBoNGU1YjI4Nk94U3VnczFBVGw1KzdXaDllK1RnTGllNThRdmNo?=
 =?utf-8?B?Y2laaHgrRGxNb01INmNTaVZPVStZK3JuSzgxQm1aNFk0UWZuMTRzcmpQM0pW?=
 =?utf-8?B?U3pPSnJIbGR5T2RGcDUwTEU2SzZjVEpmT01ZSW95OUw2S3l6Z0VRM1Zaa0ZH?=
 =?utf-8?B?L1c0a2k1TUxWc2dab1JrcFdwL3hrVlFMTHh4NG90YkRqTzBlRVlUc0xVSC8r?=
 =?utf-8?Q?ecP0SBbXBYqliDJx3X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30c4621-110a-4c88-ec1d-08de7a9ba8cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 09:43:30.5278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XMotWJJjIIMiulfopSWm9MWAN8edmN7EmtT+RUbRi5o152/0VfOX6YRzO/lCHtgp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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

The original reporter already mentioned on the ticket that this patch is not the actual cause of the issues.

It basically just changes timing to create and eventually wait for the TLB fence to signal.

Let's see what the reporter finds with his extended bisect.

Regards,
Christian.

On 3/5/26 07:48, Liang, Prike wrote:
> [Public]
> 
> It’s possible that we failed to save and invalidate some active pages during suspend, which then prevents those pages from being restored correctly on resume.
> 
> For now, we still rely on this patch to keep the userq page tables updated and synchronized. Until the full solution is ready, how about we fall back to the initial approach and restrict this TLB flush to only the userq path?
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, March 4, 2026 9:57 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Liang, Prike <Prike.Liang@amd.com>
>> Subject: Re: [PATCH] Revert "drm/amdgpu: attach tlb fence to the PTs update"
>>
>> On 3/4/26 14:54, Alex Deucher wrote:
>>> This reverts commit f3854e04b708d73276c4488231a8bd66d30b4671.
>>>
>>> This causes framebuffer corruption after suspend.
>>
>> But prevents massive memory corruption with userqueues.
>>
>> I have strong doubts that this is related to the FB corruption in any way, it will just
>> change the timing.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4798
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Prike Liang <Prike.Liang@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 01fef0e4f4085..25b1d679ba262 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1073,7 +1073,7 @@ amdgpu_vm_tlb_flush(struct
>> amdgpu_vm_update_params *params,
>>>     }
>>>
>>>     /* Prepare a TLB flush fence to be attached to PTs */
>>> -   if (!params->unlocked) {
>>> +   if (!params->unlocked && vm->is_compute_context) {
>>>             amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>>>
>>>             /* Makes sure no PD/PT is freed before the flush */
> 

