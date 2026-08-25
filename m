Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54559C61DB6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 07:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CCE10E8D9;
	Tue, 25 Aug 2026 07:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yOTLSKFw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010019.outbound.protection.outlook.com
 [52.101.193.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66DC410E8D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 07:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7COoyfgu46Np8SIQ72FT22kicbPnQfxNUZpG1faUJBpGsLnYiVpymscUfbAXkkII15d5mPb8PdTrUH7tD7s0zVnK1QQioKmp3yrD/l8IIqsOkhUbSWUY9P7m+aajIcLS1uxD6odwAx2CJCV/dY4GoRbVAerKLiBoeGu65mgXkPecWENCPJnThIpyWWp/wf9KzZC79MXPJ/6skhKulaei0lfxAqpADdXp97bqjr1eb3OJXwtjCak2MUPXTy+XZ8fRYIut5yo6lhpDrHpxU0b4J4PkODN4ZmEGAacNOC2D55fyzcsJoCIuMBtyAbir6FUG0+oqdIEl3sSQIUv7QmLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiRjQ/I9JNxT2CPhszMeF+ex8Jy2YO+d/xLK5Tju84A=;
 b=fg++AInO1u1bIUdULbpHHybJUXUtnP3hrXieaUAqJtw6rl+UcX0cTwPmH3+mpXbBbVTr7vuqcm9wGWfqY6MnovmiIP90mNlMHpnC0QLvHc3LR9vMp+M+HlwYg/BbehEWjqUhlDVpF5zgRwbfviPRh53YZkMs/rUk0noopiHIlQjx0oj5UePV8Asosr55i9IOmEnOuMsenK76D4rbtkDahYIUbOw0rweVpFMDngeQhkgPRjW2/k4u606lgQDVcFOVc7Bu30XZkfcreHAFxA/U0zKfUDAPynbpWyjPQJ0wLW7dZJKlEEKVkzRxvAXwI+l4/cni0sMj+DGMIa/tCQpRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiRjQ/I9JNxT2CPhszMeF+ex8Jy2YO+d/xLK5Tju84A=;
 b=yOTLSKFwyewwznC9jKMJhATt57WR2ZAHfIFToYNg0bpr6IOt7XuHRIYKPUUctnZw5qkQX6n2enfY+8v5JTHZJjbeevUVkPgl4buhaPElpU2JjaBAaneMvY4hCpYAAgZQMmQayylaPIlbGuXPCuMPNaWVCQPlje+MbuH9XxX/tio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Tue, 25 Aug
 2026 07:22:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 07:22:15 +0000
Message-ID: <39611ad5-1ac8-4b4d-8153-1ae875ee3a80@amd.com>
Date: Tue, 25 Aug 2026 09:22:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep the userq manager alive as long as its
 queues
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com
Cc: Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260818115753.127358-1-lingshan.zhu@amd.com>
 <d186f7b7-11c1-46ae-bbf7-d439ac1c4971@amd.com>
 <dd4bd2d2-095a-4b7a-881f-27ae79485b02@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <dd4bd2d2-095a-4b7a-881f-27ae79485b02@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: afc6004e-00ff-44d2-c284-08df027996d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: O/bDY5AU+dOk9rM0AuWUVH5YUU1TX7SbJa/qWpwnt/87yOQB0DqWTGQzj8X2LTdlYJWrWA9PdQYvgPWqLBGBb3bKixTO4CbDBpB90onUXcynGM9eSqhyDd/GL9+ZdLHO3q7XYRibKWXffVv1/FxIxOYr9la9sEs/LcepsUTYfaak8ZWBqIM5DhY61bcUuPzbmXVA39ogD02qdbRLpSRQ9opj0BLTDMJbXjFcJW7n4ZTYQ2p6ZYrkDP8y6PhhP42fLLk+zI0E7hmLmpW68Wr3bU13V3fmIp2TwO8ZYqqM+8jRRpb9k7cnP5JMJEJm+lHtWOTj4+Yhvfu3J2oYpAkygqPCp8RjJe6nMRmpXkDbn6ktMlv22Tx/pLFOZuZDc+AFkzPvDe/iIffx4g7DD4DVVH5QFW3Jonbce+0MpE7oCmaBmap26YkoyP7fvIEENN/mg/s5a4sSJPsVedtBhZ5Swds8EnUYxbzUUQOKv5ylsA341LwePQVZWZdoKfIitgQ8ApHw24VBp9bkHoYh1e1GE8vemRwOL2uOZcLWzdqpM0//i2+KUHEzN9PWbeQnNiAleCBnTOMCVzoeReJVGob6zhcC9painNB7MNx4xSRtVABP4CmFM8ha/310zlSYZedPmURl15pfLA0ykWYaLAYGtErHuYPI3herXnK2D5ndedE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlpLWUxVbi8wdEdRMXFQMFBIc0JJb0t5Tm1wTmtqOW1wcjNudy92L3NhNnlj?=
 =?utf-8?B?WW5iaTBsaHNaSTV6RC9iam5mVXF4UDdUZ1ZBZEZlb1ZLQ1JjMnlaWUVBZy9G?=
 =?utf-8?B?dzFPZ0NSVVl0Ui85cTVaeXE5cDJhZ0ZrNnpXOUpCeHBWQThqMG5PTENwbnph?=
 =?utf-8?B?ajVTOXJrYkJtZHIyU1dJWmsxZU94TDMyckhKNWl1SGxUTXpwNWY2Vm9xbkxL?=
 =?utf-8?B?d1dBUTJ1UEltQnBScTRwWXpZNDZUN3ZxTjBSUkorZDRIU1hEQ3F5eXZsbHox?=
 =?utf-8?B?TEdDWmQ5aXMyQURvdUdZd1UwOVduUlFTbjJLcUlhUDdNZzJvVEl3aEJ2aEtj?=
 =?utf-8?B?UHR3TUhlWG02a3BQT3hFczVDU3lISUo5V1B6enFFL0xiaDdZZmNZU2hGeGN5?=
 =?utf-8?B?aENKQ1E1QUxRaGpYbWZPNEZYVzdiWWgweml2TU4zSDd0RkU4TDdXVkZLWERl?=
 =?utf-8?B?a3VSNlhucVlTUzgxSjdZRWM0MEY2ZjN2cGFremdGTW5oS2pIK3V3SXFDZUJF?=
 =?utf-8?B?NHdUZE1IcXBQekM4cW8ycDBpdHRiSXU5ak0yVytudEFJMTRrMDg0QTJBR05T?=
 =?utf-8?B?WkhLOEdrT2JtU0tHc3ZudDhvWkdVRENrL29EeEl3cURWVTkwSXNPTEpCUEtW?=
 =?utf-8?B?dmF1VXh0aUJFdGtzdlFLRmRzK3JwdDVEVlpUbHd5S2JDb3pmRWE4Q3d5ZUhh?=
 =?utf-8?B?Y0hJMUZyNDdqL2t5b1dPSHpnUnF5dUtIWGRvdHBxYm1yeE0zMzdGblpFZUpu?=
 =?utf-8?B?VU9FNGF1bDlJSXhHSWFBamwzSi9lc1pOZ1RPaFMzeEt5VzBEN000eng2a1NL?=
 =?utf-8?B?cnFQczRGV1IvaFlCUlp0SnpVSGptSVVWVVJGUkZhV0xhMHl5WjNCbTVma3ds?=
 =?utf-8?B?cWZqTDFxZ2ZRSUdsUHNYYzBUMER6QWpjUEx3VCtiUXpuSWdQSlBuY0U4SXMw?=
 =?utf-8?B?S2c3RHE5NFBIMkc5MGJYOWcwZ0JwRVNIa0JzZVZvRnJkbmJHUTlISG9YeUVQ?=
 =?utf-8?B?eWtoUGc5bUxRd204K1NKN0krMmJsWHZvSnZkZ0s5eC94MWtjYStOa0htZGF1?=
 =?utf-8?B?M3lXWmFPSkxKY0JHVjhMbm5ncVFMZWt6eUk2dWZWbU5OZ0tNYlZ5THppSkN0?=
 =?utf-8?B?TlAyajBYMWNmTXptTDYzZmRnUWJVbDZNRUlzTjRHY3hlS2ZkVlBybWJ2bDdn?=
 =?utf-8?B?MUxDaUE0dnBGbnQ3YXBBV2h2cVlGZHJiSS9naCt2anVwZHdqeEt1aW80djVB?=
 =?utf-8?B?T3Jyc0s5S0Y4b05wdGE3VW5kRVN4TEZ2TFc5c3VkemNWbzdOcmhQUHN0UmFD?=
 =?utf-8?B?dS9mN2Jtc3pCQUFJSmhBMXZjLzQ2MzlaVmtpTlNhZXFiRVFKeUFBb0JOalo4?=
 =?utf-8?B?UGtiSmZBNEp5VTY2c281ekxYakRVZnk1VlpuMi9TYmhMRkZwUnJOeWNoUURR?=
 =?utf-8?B?WXZYRnFkUkFTL3BkdDNBdGJJbW1lU3hPOVJQcjhCMVFpY2pHVXYzdWU0aXBa?=
 =?utf-8?B?Y2VpRmh5WktUZEFPd3lkSUE5cUpYQmZHNjRzQ1hIcmJPakh2dllHc1NMNzA5?=
 =?utf-8?B?NUJQRElkUlZYc1VxS2ViREZLNmZWd05md0I2OHVodXBVM1ZKUUVlTHdJeXho?=
 =?utf-8?B?Z1ZIZnJWZk5SalFGb2RveVhMV25aQkRGVXQreC9QR0I0aXNUeE96R1g1aEk1?=
 =?utf-8?B?NjBRQ0hEU2NFbXByNlRZM3VDZ0RDb3YxQUZHS1Jya2pEM3M3VjhiVGd6dW5z?=
 =?utf-8?B?bUg2a2JLVUNWMm9KTk5XRkNqbmJ3QklRRU9FangrZkh5RkhGb0NwRmxicDd0?=
 =?utf-8?B?SGlHMkF5ais2eG1uNjlTRWRNK1NzVm5PazhPT1pmcHJDdm1YTG1rb0tiTnN4?=
 =?utf-8?B?QURXcVk0blRpbGZtcm9XbFhyNmJ0UjkvMThvVDBkdm1XYlE3SUg3RStPQ3g4?=
 =?utf-8?B?bW9Ca3R6dlR6WjBCbTZvK01sTkZHWWh0WHNKbFBPRnpscHdldmxIZ09sN1d2?=
 =?utf-8?B?K1IxRHdiTnFKS1RVWkh6eTBENTVrbmp2eWdHeXdmWkRNdXNnQ3dJVHN2bStn?=
 =?utf-8?B?RzV6WjlqMlVTc1pGR3NpcmhOWjFSaVBzWjlQVXdad3ZSUUhDVEQ3MFNCUndi?=
 =?utf-8?B?MTU1ZlVpYzYxSlVmSTY0ODhobFZEZmpKWUxOWnVacWVLV1pUc0JucEtlVlJk?=
 =?utf-8?B?cjF6WFZYU1ZSc0VCMGl3a2hNbDdON3JUMFkwQWJ5dk8xNW0xaHpXRnFaM0xB?=
 =?utf-8?B?QTZlV1llTHEvUWRYQXFsTU9KMnlzb0x5dUY3VjZQcEJzTzRyd3Y2SmZnZWZ6?=
 =?utf-8?Q?xyMDUxnjahuwdCVGM5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc6004e-00ff-44d2-c284-08df027996d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:22:15.7450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59qbqJugQxXzdfZD943zLNPk5XABS07E7qA5cYDcV/2QHDCd2IqE3QHhKmOpPoi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

On 8/25/26 07:58, Zhu, Lingshan wrote:
> On 8/24/2026 10:38 PM, Christian König wrote:
> 
>> On 8/18/26 13:57, Zhu Lingshan wrote:
>>> The userq manager is embedded in fpriv, so any code
>>> paths trigger kfree(fpriv) would destroy the userq_mgr,
>>> even some of its queues are still alive,
>>> resuting in userq->userq_mgr use-after-free issues.
>>>
>>> This commit fixes this problem by introduce a new
>>> counter refs representing for the number of its queues,
>>> and only free the userq_manager when refs == 0
>> Well the userqueues are kept alive as long as there are IOCTLs using it.
>>
>> And and IOCTL in turn keeps a reference on the file and so the fpriv which contains the userq manager.
>>
>> So that here doesn't make any sense at all.
>>
>> If there is still an userq alive when the userq manager is destroyed we should probably call BUG(), cause that mean a major reference count issue in a core kernel component.
> 
> This can be more complex, what if the amdgpu_userq_put in amdgpu_userq_mgr_fini is not the last put of a queue, that means the queue is still alive even when
> the userq manager has been destroyed. I will put this patch in my next series where the problem is better demonstrated and more reachable.

That is not a problem at all. The reference count is there to keep the userq alive during IOCTLs.

The problem you describe here simply shouldn't happen and if it does happen we clearly shouldn't it be solving it like this.

Regards,
Christian.

> 
> Thanks
> Lingshan
> 
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 27 +++++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 19 ++++++++++++++++
>>>  2 files changed, 46 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 24adad7be251..434384b53b85 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -533,6 +533,17 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>>  	return r;
>>>  }
>>>  
>>> +static void amdgpu_userq_mgr_inc_refs(struct amdgpu_userq_mgr *uq_mgr)
>>> +{
>>> +	atomic_inc(&uq_mgr->refs);
>>> +}
>>> +
>>> +static void amdgpu_userq_mgr_dec_refs(struct amdgpu_userq_mgr *uq_mgr)
>>> +{
>>> +	if (atomic_dec_and_test(&uq_mgr->refs))
>>> +		wake_up(&uq_mgr->refs_wq);
>>> +}
>>> +
>>>  static int
>>>  amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>>  {
>>> @@ -594,6 +605,8 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
>>>  	r = amdgpu_userq_destroy(uq_mgr, queue);
>>>  	if (r)
>>>  		drm_file_err(uq_mgr->file, "Failed to destroy usermode queue %d\n", r);
>>> +
>>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>>  }
>>>  
>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
>>> @@ -677,6 +690,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
>>>  				fpriv->xcp_id : 0;
>>>  	queue->userq_mgr = uq_mgr;
>>> +	amdgpu_userq_mgr_inc_refs(uq_mgr);
>>>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>>>  			  amdgpu_userq_hang_detect_work);
>>>  
>>> @@ -789,6 +803,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>  free_queue:
>>>  	trace_amdgpu_userq_create_end(queue, r);
>>>  	kfree(queue);
>>> +	amdgpu_userq_mgr_dec_refs(uq_mgr);
>>>  err_pm_runtime:
>>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>  	return r;
>>> @@ -1277,6 +1292,8 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>>  {
>>>  	mutex_init(&userq_mgr->userq_mutex);
>>>  	xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
>>> +	atomic_set(&userq_mgr->refs, 0);
>>> +	init_waitqueue_head(&userq_mgr->refs_wq);
>>>  	userq_mgr->adev = adev;
>>>  	userq_mgr->file = file_priv;
>>>  	userq_mgr->proc_ctx_allocated = false;
>>> @@ -1326,6 +1343,16 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>  		amdgpu_userq_put(queue);
>>>  	}
>>>  
>>> +	/*
>>> +	 * userq_mgr is embedded in struct amdgpu_fpriv and get
>>> +	 * freed when kfree(fpriv). This wait_evet() blocks
>>> +	 * amdgpu_userq_mgr_fini() which is drm_release path,
>>> +	 * so keep userq_mgr alive while any queues holding it.
>>> +	 *
>>> +	 * This prevents queue->userq_mgr use-after-free issues.
>>> +	 */
>>> +	wait_event(userq_mgr->refs_wq, !atomic_read(&userq_mgr->refs));
>>> +
>>>  	xa_destroy(&userq_mgr->userq_xa);
>>>  
>>>  	/*
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index 6412a7f7b6ef..7141383ea2ae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -24,6 +24,8 @@
>>>  
>>>  #ifndef AMDGPU_USERQ_H_
>>>  #define AMDGPU_USERQ_H_
>>> +#include <linux/wait.h>
>>> +
>>>  #include "amdgpu_eviction_fence.h"
>>>  
>>>  #define AMDGPU_MAX_USERQ_COUNT 512
>>> @@ -126,6 +128,23 @@ struct amdgpu_userq_mgr {
>>>  	 */
>>>  	struct xarray			userq_xa;
>>>  	struct mutex			userq_mutex;
>>> +
>>> +	/**
>>> +	 * @refs:
>>> +	 *
>>> +	 * Each queue increase this counter when join this manager,
>>> +	 * and decreash this counter when leave this manager.
>>> +	 */
>>> +	atomic_t			refs;
>>> +
>>> +	/**
>>> +	 * @refs_wq:
>>> +	 *
>>> +	 * Waited on by amdgpu_userq_mgr_fini() until @refs drops to zero.
>>> +	 * This wait prevents userq->userq_mgr UAF
>>> +	 */
>>> +	wait_queue_head_t		refs_wq;
>>> +
>>>  	struct amdgpu_device		*adev;
>>>  	struct delayed_work		resume_work;
>>>  	struct drm_file			*file;

