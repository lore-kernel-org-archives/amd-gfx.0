Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605B210A62C1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4C010E922;
	Thu, 26 Mar 2026 12:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkpLmO1A";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BF410E165
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnk0DInOCD8gJ/ws30UJehBSaO82i2IypMSl5AazM5oZYpfQvY29ZTl/n0ywmzdh/m/uxcOemxuhezbGhDvzZdlw6E1snlxVr5yp8r7VX92RjOT7KQLePbbqOGoMB9d2rwQG6a9dyeH0LNWmPlNEllyOOobRF9xLfI5UvMjL1LuBp5LRFY/xgZ1IzjVkI9BkfDFyqFMt4ub5uLTZs1YoxVIrDZkaN4iEJZMvSQSUn6VQAbDNDhfbU1a44SXsopycDYNAMX3msmSKrFGZMXO8MdjEk3thXR37cyoUMKEk2f0CpR8xpu4rqMAOc5bMkhGWAVor+ePLkYCpEtnv7BP/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6qIPPjkzKaL4/iGr3XQ5CtDLVUp3DAr/ESU48D+r4U=;
 b=IYITmkts1CQ3uvW5bpWd/WBwk19TB641hoaEdUbGqJmAC4PyRcNfoC/ZfTl0tGgbY09l/Q83JEvGjmrUMKIYaKn4qHJrdjxqvSb9U14xbg6LMv5O4RZjPVFu0SSoc+zYQnJNbKDaCjZGWD3Ysn1ouKYy/c22CxlhtTEzVLXswLKMGr4/+je3EEdHss9nBMFEmIVnx846kbHOuVqUPLteYDXIVzdSkNYLugHHd7FseT3sN1AaX4R0dieFHHs91q4hXafEUAiozyOWdatco/N5xqolOciBRmUoQM2Gw2C/SQCeAzgdwI8CkE2qR+6WirHg1TbZI9mx4sMwDsMrCvYZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6qIPPjkzKaL4/iGr3XQ5CtDLVUp3DAr/ESU48D+r4U=;
 b=bkpLmO1AWTqUiuDELoZsQRASUkSmH741aoy9LGegLv6KYbkGhsCW2tERYx6jHcXFWoWjyi/97IKh0bLD0T0mhDcv+OjYdQSka21M4Aukp311WKeBrNWWuJVCtToO7Bsic/xcWl9bjKx6fQonSZsxd8ngZ43h6OIVAUaXdUfd/ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 12:52:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:52:17 +0000
Message-ID: <e6d580ff-0ca3-4043-8e60-454254633998@amd.com>
Date: Thu, 26 Mar 2026 13:52:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1 1/4] drm/amdgpu/userq: no need to use local variable ret
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
 <20260326085601.2665215-2-sunil.khatri@amd.com>
 <6bc42907-3370-4c92-94f9-9a873f50ede6@amd.com>
 <e477110b-f1c2-4a5b-980c-be2d7e8cd6ae@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e477110b-f1c2-4a5b-980c-be2d7e8cd6ae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: b73d65c8-d693-4509-033c-08de8b3682d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ZGU07eRmYWmwQqutvz1t0PD2lu/I6DhwdJci9CFqMwm6eQB5oW9Capp+Mgy9+7bHLBs0CSLav8QwOSZ38PRHJkL29bBM0z3WxTKjhGBKQh2zp7l5/nL81WafJMeWKlAVu2SjLU+/x23hL+jFDYqgjzFVVNluZCR6p+UBNYmcwg6fxhuuMrAJ3OgsJQ4rLMkFTXJ6kyWVDqB7RnLL9z7dAeJsUFCaZTOMsR3K8lX0ZORZEm8M/JaIqbHNZXhtZMRGXDGUrw0kcWcfYvjHcurFvcKz/6v+04RuRS1D1QCMmEanBj07lolv6b3D9eokzvv/VgSwL2RZaTnRRaa7T6joLTd7Kz1rF4cWuGwtgRcxnu1bKkuq+VSdv3f8YoX4K0V6g52w4J7OHmSUwsl/Sj0+ahIvFnsZ7022+z62hLA2iJEiQb+U101WjC1K4BHl1mncsrQUi5/h3XVX2RJKb2qDNkAyCR0uB0+ujpRG8OLPvUcoT4n1ROBlY57JTDtLT8YdX/cug2JY3e0TBxduZMLcXYN+yV7xA+dA3I2JjKvnsynaAiDH9WzJjqD5Lvn7TObI9EER0LwxwK/MuniwTrvBA7eZN5uVsSSekXU1vYVwJtERZEqJ2zOqVxPI2TwXO/gfssVUHBVD5KHPr7/xYDvwp2N5xexv3BzBTv84X40slRTfwHmD/9S4guSE5R53gQjFYFGVQe0EnUnYXyAPdxXQ7l2Df15YGVrhRTocXtcPzcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUNtSEVkYURVZ2ZkWWo3N2t3OTc1b1d1YStvMEdjeEVHNHJLR0FWYnExQkNl?=
 =?utf-8?B?UjJETnUwUGFoaU5CdW5mbVkySlI5bC9uVXdaU2t6NUZmMFlnWjZ2UDludEt4?=
 =?utf-8?B?UGszRHJGWnQ0NnFVOXNTUHUyQXlPejFMRTNGUy9ueEZTRTdqZlZEd05yeVMx?=
 =?utf-8?B?Wm9XeEdaZFFhUVdpRGdocDFWWE83cGJ5TDFBNC9NTGt2bTJoSWtDeTBXc3dU?=
 =?utf-8?B?b3J5MDh5b0owdzVHSHdYSmh2WEpHeTRwTk85enAyTm1weGNwRDZ4bzhoL21u?=
 =?utf-8?B?d2hUSng0NWw0Uk1FcWoyYXY0WTA1cWh2NHl4TWFncHY4V1JhTTcxUVAveldL?=
 =?utf-8?B?LzM3eE1WZnhlbG5Va0M4dlg1N29zOXBmQ20yRng5d0NlRUJ6bGd0UDBreFdV?=
 =?utf-8?B?bU4vazNFMjZ0ME5uVzVzQ2t0ZHBDV0FwOFBENUpSd3A3QSs0M0I1THFEdmxI?=
 =?utf-8?B?a29mOW94MzNYbjZyMXFNbXI4SXpSSFV5ZmI0TGpRUnFBakk0Z2UvN0RPMmRQ?=
 =?utf-8?B?TllweHFXbXdNS1ZoU2Q3MnpGVkVZMUNpYktVMEUrNGpCODUrM0RoVm1nU3c1?=
 =?utf-8?B?MkxHaWtBZ25pc2hEVVpCRlRzMUkxVVZjeVIzR2NvVXZ3cnpzK3VxWHVoeU91?=
 =?utf-8?B?TkpyaTVXYldBK3dtLzllbytOcTQ3S0VPbnVJYlVHemN0dCtTVVFtaW1ZWElh?=
 =?utf-8?B?TERqVE9JZzF5dUVwS0thUjhlNTRHZG5EKzE1YzN1RjBiQVRwSGJDTG9qcXFL?=
 =?utf-8?B?WUJ6L3FidEFDWUJ4dndTaUYwUEpzVnI2SmZ2b0NsWTRuRHdMS3VOclNnRW1v?=
 =?utf-8?B?MkpLWjVYK3RMTEw5dndFcDhWQ1ZJNitzT0tyTkhTemlHWWQ0V2RZM1RZTzNh?=
 =?utf-8?B?VDV1dUQvbmw2cEpTd2xvTHRjVTAzbWZ5QThMZTNSK3B2QW1ZNk1zQmxCTWpm?=
 =?utf-8?B?VUNJQWdNc3hRWWFRclJzd05KQWR2djRrWjRzZGJCZC81WE43Yy9ubU5jZlgw?=
 =?utf-8?B?b3R2THJSbHB3VHJ5YW9nYlNya3UrY1pBSytYN3FkUERRQVBXZ3IxaU1xelJW?=
 =?utf-8?B?ZHFnTG1WS2dnVnBmRm51ZGdOU2ZYVmpJMXc1MmRDV3VzTkVmMU9mQTNEQk80?=
 =?utf-8?B?VFFmb2R6TU9sT1dzell1OElxakZYb0lzSnJTRk5jQytHNUV1ODczM3E0clJR?=
 =?utf-8?B?Z0dTWndGYytpcWhTUmFvazFUd1p0ZjloYUduQU9EbTZxSGtadHpUR1dDL3Rv?=
 =?utf-8?B?enVmUE12QnRuUWROQ0FqK3hWcVFrQ2pIVWp0L21LOFFHeFVYL2pMU2pxaGt3?=
 =?utf-8?B?bjIyS21oVERlcCtYNFpCVkgweFBBOTFTR3lvQWxicG9TbEFNUjFiK2U5VXd1?=
 =?utf-8?B?M25IcVNOWktQbHdCNjRORXAxb2NnekYrS29ZeE1PSVJsSXR5MGdtUzNKaHRZ?=
 =?utf-8?B?ZDBmdmlJQk0vT3gyMWVyQ1ErODJ2UUQxZjZuaGMwQU5wamtDM2lsOGVwU3B1?=
 =?utf-8?B?UitUZlRkajVvbFhCVGRsbjRrUU54MGtTTkxLbzNhU0lMQzdWZGNmUU4xK20x?=
 =?utf-8?B?N2RHeFNhSXlhZHkvOXc1bi9vMzhkTmIvU09uOGN3UkVlanlDM0FqamYyVVF0?=
 =?utf-8?B?M3lncVlJM295ZmMwRWdOMWIzMEVuaVNjWmpRK1ZOY1EzdW9RK3Q3Zm5ZSm00?=
 =?utf-8?B?Sm50R3EvNXBLd2JwZDcrS0RHVG54VDluRUc5c0N1ZDk1dlBKZUU4bS94UlNa?=
 =?utf-8?B?c3A1MGZidjhBWTVhTks4dGNOT2drT3p6SDlHUDVnbUlVcllUNk01VjNoYmI2?=
 =?utf-8?B?RWFXaUlsbFNRQjlhQnFIQ2IzZXJkUGlhd09JNG4vR1JtMDJURDBERUVFM3Uv?=
 =?utf-8?B?eUhjSllqaGRyVjZrVzlXOC9qZnJQWkxYcXMxMVBORENBVlJya0lXd0d6bGVI?=
 =?utf-8?B?UFkzb0RzNU5XUXdTNC9OZ2d6TlkydXVRTW00ZGwrY2R2N0dya0xQUHNxZGNj?=
 =?utf-8?B?V2ZhTWtpYWlKS1lLMzZJby9RVHgya3hvenlYaDhPRXVhdnRsWTNhdTBMMHgr?=
 =?utf-8?B?aHErNXhqR0ZNaVRVbTZxNWZRdDVFc3JYeCtvSGVxMndGVXdEejdhWTNDLy9P?=
 =?utf-8?B?NkNnNkl3L0Q5Yk5yUFNmeUlTRFF3RGVlUE50eWFCaXY0em93dW9FVTMrTVV2?=
 =?utf-8?B?YzZaQ3g5QTBvOEJtNVQyV3dzQXBVL1V3Y3JSU0NhclVqNnp0ODRiaTF1L1k1?=
 =?utf-8?B?V21tOGNJbTBtTHhCdkRLL25QSlNBYlVjV1VCWHNpZEtvN3RnTHppK3J3Vk5Q?=
 =?utf-8?Q?OsHEeu0e14kqcmI94O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73d65c8-d693-4509-033c-08de8b3682d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:52:17.4755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT6PPI1NMrIs1OJDXZvEbUjCb43e5qDqRS5NbsjREVOyWOL9/Jyah54ovGDUS9Pr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207
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



On 3/26/26 13:26, Khatri, Sunil wrote:
> 
> On 26-03-2026 05:38 pm, Christian König wrote:
>> On 3/26/26 09:55, Sunil Khatri wrote:
>>> In function amdgpu_userq_evict use the function return
>>> value in the if condition instead.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++------
>>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index aa0e6eea9436..2a1832fce6d2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -1308,17 +1308,13 @@ void
>>>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>>>  {
>>>  	struct amdgpu_device *adev = uq_mgr->adev;
>>> -	int ret;
>>>  
>>>  	/* Wait for any pending userqueue fence work to finish */
>>> -	ret = amdgpu_userq_wait_for_signal(uq_mgr);
>>> -	if (ret)
>>> +	if (amdgpu_userq_wait_for_signal(uq_mgr))
>>>  		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
>> That actually looks like a pretty bad idea. Instead we should start printing the error code.
> Sure could add an error code in the logging.
>> But before we do that I would rather like to know why amdgpu_userq_wait_for_signal() can fail?
> dma_fence_wait_timeout is what could fail and we are returning -ETIMEDOUT. We could totally avoid checking for the error here completely as we are already printing the error in
> the called function below.
> ret=dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));

*sigh* I explicitly NAKed that timeout before. Please change that to the maximum.

Additional to that please drop the extra call to dma_fence_is_signaled() before the wait, such stuff is completely superfluous.

Then the second parameter to dma_fence_wait_timeout should be false, this way we can't be interrupted any more and don't need to check the return value for errors.

Thanks for take a look at that,
Christian.

>                 if(ret<=0) {
>                         drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>                                      f->context, f->seqno);
>         return-ETIMEDOUT;
>                 }
>> That should never happen in the first place.
>>
>> Regards,
>> Christian.
>>
>>>  
>>> -	ret = amdgpu_userq_evict_all(uq_mgr);
>>> -	if (ret)
>>> +	if (amdgpu_userq_evict_all(uq_mgr))
>>>  		dev_err(adev->dev, "Failed to evict userqueue\n");
> Here also the below function returns error and printing error too. We could avoid the return value here too as we are already printing the error.
> amdgpu_userq_preempt_helper(queue);
>                 if(r)
>                         ret=r;
> 
> 
> Regards
> Sunil Khatri
> 
>>> -
>>>  }
>>>  
>>>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,

