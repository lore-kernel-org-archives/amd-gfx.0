Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5D2EA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 12:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49AB210E7E6;
	Thu,  9 Apr 2026 12:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oDKrs753";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A370D10E7E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 12:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdnm8f3Swzf+mjb6GwpfM3tRi8lSsL9yFH1WK4PW+g6ibu/EOCv/na+B1KzoEw7kTYRYfTXkufnhtkd4LAc/UOatyk2WjnmuNWzjZJrVaV1JZIc3tRO6RwzNMYo40UpAHc3W53gFaYz28AfDOysO/mjUgGTDq9jdkMnmhj/I9xcq/kI6QIdrU2TMLp1YvbUtwygS9BpFeUkYtFnWwEzRQMJQQLcLsv2lQoIMACdxUMxrRVfdvIbTKj+djkjTSTtVb6wnxjLeZC9a8FLy950loD5jTTmDCMayaThZ8WTRPK9Orx+xXr7q5AhelMiLu42Lm9tll+MoanwJM4EHKYyYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh/AV2VY3yulQ02p2A2jOseQEVvo8VRRu46SroE3z0c=;
 b=jY0IiPUaa8m9e7Ij4RxojOlA1bVLxoAuzWMU21lkXMT6aHx9Wbv56tY+HrV0CReeZPVrhpzJX4LFUHKbzDWy6U7+KQKV4betmGKqsW+8h75tymb1AeUpO3AF1g/Pyk+Je/i5LT04QDE3hayE0rpFcH2Wti+f4i952cFyMLYBetOojrOC4xDllsDOkliiVjWkVkydK2afLmj3yxpylgnQ10vH7TIfYV66U7jIRGpb2Qhq4K3iPP4iUNGHPgyJuLlZ8P9jzOHXv9ytbeCvLGopm9lH/+LgRUn1rvKqIfvIvCqG82MVZ1aG8MyzyLy+B6mqsGayctBCGLTrSh8s2b9WRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh/AV2VY3yulQ02p2A2jOseQEVvo8VRRu46SroE3z0c=;
 b=oDKrs753M791j5ghjH/OZilTZwpqHRBQ0tlxtcaKi5+0fSLdZfT3PCfz9Fc9fnyUHxrsLW1Gm5VgstdL86kZ24OtoppvbGoK3cqM6hITquI/Qq8K2CSE54GkKJ8UTfHoQmWOGRoBTucLcpboGfaSmEvOML+P6LYK+5h5Pv8U8Yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:42:02 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 12:42:02 +0000
Content-Type: multipart/alternative;
 boundary="------------pxZkJHMINuRgPLLDfjHazoj9"
Message-ID: <ec94e8db-712f-4409-a7f9-f800ed1f093d@amd.com>
Date: Thu, 9 Apr 2026 18:11:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/amdgpu/userq: caller to take reserv lock for
 amdgpu_userq_buffer_vas_list_cleanup
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260409083355.1326089-1-sunil.khatri@amd.com>
 <20260409083355.1326089-4-sunil.khatri@amd.com>
 <25488a11-dee0-4397-949f-d166edaf674c@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <25488a11-dee0-4397-949f-d166edaf674c@amd.com>
X-ClientProxiedBy: MA5P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::19) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 8172ff75-a5d3-44a6-c86b-08de9635662f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: yzPJYWXc23fVSIeXzFaL3Vos11PQnyMvcHQCq6IfSfrzsTjlo9ywNmSXbHNk50KCPa5zqu534vtG97My2zj/LPxwcVYXShUenqjkv4MSEtwkSPHweRSrsmmXc0hTGVVfdLIcPjAbQBlFagvCVEKNH094fiFzMy4D+czhbF9oS6M0MVRDC4n/6M9bh9+qurkEcxAUEAoWuGjfYEyozyk6ZhLVVsck7mOlbs/wx9sGCdRsVzL53HqQnrt584+TzGTqp0MmJO7VbXeXSyrsPB+aGS8+ASyCyfhiwKmpGyzPtZN8Y//z3Lci+67kskjlSJtP57CPaMO+krsTUdUJDDrUlFFNSfTjRDU/aho/VNUk+qs3lMj81tRdFYKCbLi79Ij1/QnP0ooRlZGn7clig+E0Xy03cij9yhrNUaqVjNjlfL11YqAVp75vISkbKqwoCBnzy2ycXaH92fA6Ua1r9FZehApa86ScLl9rUn1jpxJhvhqeWPQTP1PcgeqZNf7sMs7/nmtsrPcjvnc9pN4fpi0H5WSMq7yzsz8rFY2HebGKy3hJqJkjkx6baFa1+rg0ikXnhTDhW7uH1V7rdfdY/qRmLOp9E0B3I8q9A1AfxbBpTWfGm5kg6Rnq4McGGia6X2P0LeziEG1fUJ3euRlu1cWVtXEqde6jxL9nxSri7WO3VhnTtb/LhOxKWJlRCOb9Qs1RXEgvB3xcMc1hnvrl/PKDFW8TX6j2422MfqWbp9fvZPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWNjS2hma29lTW45eFlaRm1ncEx0dk15cmhKQmNrN3NFNkFnL2tmajlYTGdj?=
 =?utf-8?B?bCtLdGw4T3llR1dFdUw1U0pyS3hHWHAzM2hGZndOTzhZVkkyZzIxU1NaMW1n?=
 =?utf-8?B?azFjSzI0Wjh5eEJTSFFVczZkSlk1RlJ4WGFmZUV1QmRIOHh5Z3VsQ2grTlFR?=
 =?utf-8?B?MWh3V1ovTzVKNE1mbHNMdE1DZ2g2RzBBb3hEWC9QbWJGWmE4TzNuL0dTdU4w?=
 =?utf-8?B?QWlRbXpxanV4eVR4TlNwUEZKd2JuVHgxai9nanI3YUc1UzI4NTdMYVVGQ0VB?=
 =?utf-8?B?NU1FMjJkeUVubnh4c2ErZThXTC8zMmNyRTZhQngyRi8xZWVuVjlkc2duN0xY?=
 =?utf-8?B?Y2ZySU03enpjZjg4ZEcxbEttOUpNblZSaTVYVU04UlhNZ0FvUEtVa0JvTzRZ?=
 =?utf-8?B?akZSbEdyR3RQeEFIZmhMakM2dXVtaXlyRHZjRWRvVndReHV4Z2JRSEZmN0RL?=
 =?utf-8?B?d1hTc3QyenNnV2RDd1Frc0VZRE56T1UzT2k3T09YOGJlUElRZVloaFhIbUdO?=
 =?utf-8?B?QlA5OWJqb3NicU9QbkRHakZwcGcraG1Kdlg0N2IzZ2lxOXZobnozMTdoY012?=
 =?utf-8?B?NTJMNWFyeEhza1RhNjRsdWFFRVg5bGM4YnlsQWtoUXZpdHBwLzR2NWZQeGpK?=
 =?utf-8?B?R0R2VXkrZkJaZWFzOFdVOVl2YXE2LzZET2Y5cW9ydGxwVGlnVFJmNlRYWC9P?=
 =?utf-8?B?ZlMyNWVwRkdramthOXpNVk12eGZ4MWJCVjlxLzBSeXhwdkM5L1VLOWtjZm5Y?=
 =?utf-8?B?WldDK25EZGJiSWpWSlUyNHlSRW1QTzY2d2dUSVFzYWovOVlQNmFheFI0emxR?=
 =?utf-8?B?SGJRK0ZNVjRZUzBsUHU3Y3FEZlpWdmxUSkZoOHpQM0hVZS9mUGtScGF6N0Z5?=
 =?utf-8?B?NlZqbXFHaWVFSVRTQlpKbzlSbXFzQXlXTkh6RWsyS0hzenBCZzFoU2ZOOExY?=
 =?utf-8?B?K0wwSlBrZlVQVkRYTkFLc2k0TTFocDYvYlNPVExScmowTis5ZWFDN2RSSnpo?=
 =?utf-8?B?NjdhRnRKMzQ2MDZLT013YlVrUVRuL05EZytkWkQzaUJuS2xid2tNQ2JxYWEx?=
 =?utf-8?B?cmZTem1zVEZKWEZPWmJEVnBJQituRE91VmllNFFmUXpIak9TUnNnV1FjNE0x?=
 =?utf-8?B?Y2MzR3hxZHpzQUY5b2RoVmg5bExReWRBR3F0Q0RIdWE0TnVsdVh6S1lpd1hX?=
 =?utf-8?B?cWpsZDlSRExEWk1CK3praUxPMzI5cGlON0xaNmpOQXVUVVVMVDAxMEhWNll6?=
 =?utf-8?B?d1FCSmNybDM4NjhqV0pvMGV2dmhGV0czNlRPL3hGU1Z0eUwxSEs4K1lBOVhy?=
 =?utf-8?B?MkhaNVNicHBDVW52bWdORDNybzBjaEs1ZHYvUG9HTjBmSkpqWWFJSjNoYWsw?=
 =?utf-8?B?V3FKd0J6a0dSQisvT1lEN2t5ZmJMWTNhR1VMYTNFTXNUb1M3QURmOXhieEpi?=
 =?utf-8?B?NTBxc29Mdmo4a1lmbjJMS0VoekRLSnhqZlVaNUhtb1Rxc0NTUEF4NGFJR29M?=
 =?utf-8?B?aWpDR0RKb3lVZ2xyWFBjeW04alltY2ZFeUppNzdyaTdVQTRKdHB1ek9SaCs5?=
 =?utf-8?B?MEFzWHp6TXpVTlJ5UHJpelVWRVJtdHFWYXdTVEFmVUh0WWordWVTV0t2dkxY?=
 =?utf-8?B?Lys2UWNwTllOcVJjSlhYb2hBMzZEcmt3b2JPcVlNMm10M3dXanRwV2F1Uy9o?=
 =?utf-8?B?K1AzNEdETDIzU1U5bEFodWk4b1NLMjBnMSs3cnhiUmpReXlpK04xdGZXb2Yz?=
 =?utf-8?B?am1sU3hZdnJpbjVQQnZ1NFV3QU5zNG5RNWpVWHlCQUVINWdDcitUVmk0WFY0?=
 =?utf-8?B?QWJnMUNweUVwblFwekFWeVFqMXUxdG9GVncvRHVoazVaQ0dlakR1MkNJU2No?=
 =?utf-8?B?aHZPRHV0dGl6WHBiOUVsb0RlVDZnY1VndUlPcmlmVzMrVlMzWUE4M1BlZnE1?=
 =?utf-8?B?RGJsWHZKNkFXelZ5WWFIcnQ1SkdyZ3h0eVdQK2RqSlFLaTFTNDRtcnVqdVZS?=
 =?utf-8?B?cTZ2UVlhYk5wVWh6UnpVbERUc2lkU1lwaVo1VENRU01xYXFQazhqTm1ad2tI?=
 =?utf-8?B?aW5OQ0wvWUxPcGYwa2FaY0wrN0RkTk1aVjNxcXhaOHFmeEk5bVA3RlFuMFR6?=
 =?utf-8?B?bWVTbG9RVkVaa0hTR2pTTGJaMnhUL1JzODQ3VVY2blRRNU1pRlIxOHNUYjVT?=
 =?utf-8?B?eUw0MlNEVktoeThyWkthd0FEclpuNnhqc3NUOS9LVzNvblNvb3dRUHlBN3h4?=
 =?utf-8?B?d1h2UXRDNDJzLytXQVRWMjF5Q3VIdUlnOUQ3NFhwOXY5UWJlc0xmYkhkWEZl?=
 =?utf-8?B?a01pTVl1UkFPRzhkSmZ2REt4WmFzeEhvOXFjMEpuV05pbkMybWR1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8172ff75-a5d3-44a6-c86b-08de9635662f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:42:02.6412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl7Uvqb916IHnoo0g80ckBiuvno48GNCtUoKzEI3SeTe/OhAtcSLt3Nho6GkZWPz8s2wjWLYTVP50SabRP8sBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
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

--------------pxZkJHMINuRgPLLDfjHazoj9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09-04-2026 05:28 pm, Christian König wrote:
>
> On 4/9/26 10:33, Sunil Khatri wrote:
>> Remove the reservation lock for vm from amdgpu_userq_buffer_vas_list_cleanup
>> and caller should make sure it's taken before locking userq_mutex.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 34 ++++++++++++++---------
>>   1 file changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 2408f888c4d9..1b81ce49d408 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -312,25 +312,21 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>>   {
>>   	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>>   	struct amdgpu_bo_va_mapping *mapping;
>> -	int r;
>>   
>> -	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
>> -	if (r)
>> -		return r;
>> +	/* Caller must hold vm->root.bo reservation */
>> +	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>>   
>>   	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
>>   		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
>>   		if (!mapping) {
>> -			r = -EINVAL;
>> -			goto err;
>> +			return -EINVAL;
>>   		}
>>   		dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
>>   			queue, va_cursor->gpu_addr);
>>   		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
>>   	}
>> -err:
>> -	amdgpu_bo_unreserve(queue->vm->root.bo);
>> -	return r;
>> +
>> +	return 0;
>>   }
>>   
>>   static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>> @@ -444,8 +440,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>>   	/* Wait for mode-1 reset to complete */
>>   	down_read(&adev->reset_domain->sem);
>>   
>> -	/* Drop the userq reference. */
>> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>>   	uq_funcs->mqd_destroy(queue);
>>   	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
>>   	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>> @@ -626,6 +620,9 @@ static int
>>   amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>   {
>>   	struct amdgpu_device *adev = uq_mgr->adev;
>> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> +	struct amdgpu_vm *vm = &fpriv->vm;
>> +
>>   	int r = 0;
>>   
>>   	cancel_delayed_work_sync(&uq_mgr->resume_work);
>> @@ -633,6 +630,14 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>   	/* Cancel any pending hang detection work and cleanup */
>>   	cancel_delayed_work_sync(&queue->hang_detect_work);
>>   
>> +	r = amdgpu_bo_reserve(vm->root.bo, false);
>> +	if (r) {
>> +		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
>> +		return r;
>> +	}
>> +	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>> +	amdgpu_bo_unreserve(vm->root.bo);
>> +
>>   	mutex_lock(&uq_mgr->userq_mutex);
>>   	queue->hang_detect_fence = NULL;
>>   	amdgpu_userq_wait_for_last_fence(queue);
>> @@ -664,7 +669,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>   	}
>>   	amdgpu_userq_cleanup(queue);
>>   	mutex_unlock(&uq_mgr->userq_mutex);
>> -
>>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>   
>>   	return r;
>> @@ -856,7 +860,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   clean_fence_driver:
>>   	amdgpu_userq_fence_driver_free(queue);
>>   clean_mapping:
>> -	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>> +	if (!amdgpu_bo_reserve(fpriv->vm.root.bo, false)) {
The second parameter should be true here, and then you actually don't 
need to check the return value.

Sure Noted. Should i do that in other patches too in this series where i do amdgpu_bo_reserve -> validate -> unreserve. so change this false to true and go without checking return values.

Regards
Sunil Khatri
>
> Regards,
> Christian.
>
>> +		amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>> +		amdgpu_bo_unreserve(fpriv->vm.root.bo);
>> +	}
>> +
>>   	kfree(queue);
>>   	return r;
>>   }
--------------pxZkJHMINuRgPLLDfjHazoj9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 09-04-2026 05:28 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:25488a11-dee0-4397-949f-d166edaf674c@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 4/9/26 10:33, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Remove the reservation lock for vm from amdgpu_userq_buffer_vas_list_cleanup
and caller should make sure it's taken before locking userq_mutex.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 34 ++++++++++++++---------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2408f888c4d9..1b81ce49d408 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -312,25 +312,21 @@ static int amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
 {
 	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
 	struct amdgpu_bo_va_mapping *mapping;
-	int r;
 
-	r = amdgpu_bo_reserve(queue-&gt;vm-&gt;root.bo, false);
-	if (r)
-		return r;
+	/* Caller must hold vm-&gt;root.bo reservation */
+	dma_resv_assert_held(queue-&gt;vm-&gt;root.bo-&gt;tbo.base.resv);
 
 	list_for_each_entry_safe(va_cursor, tmp, &amp;queue-&gt;userq_va_list, list) {
 		mapping = amdgpu_vm_bo_lookup_mapping(queue-&gt;vm, va_cursor-&gt;gpu_addr);
 		if (!mapping) {
-			r = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 		dev_dbg(adev-&gt;dev, &quot;delete the userq:%p va:%llx\n&quot;,
 			queue, va_cursor-&gt;gpu_addr);
 		amdgpu_userq_buffer_va_list_del(mapping, va_cursor);
 	}
-err:
-	amdgpu_bo_unreserve(queue-&gt;vm-&gt;root.bo);
-	return r;
+
+	return 0;
 }
 
 static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
@@ -444,8 +440,6 @@ static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
 	/* Wait for mode-1 reset to complete */
 	down_read(&amp;adev-&gt;reset_domain-&gt;sem);
 
-	/* Drop the userq reference. */
-	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
 	uq_funcs-&gt;mqd_destroy(queue);
 	/* Use interrupt-safe locking since IRQ handlers may access these XArrays */
 	xa_erase_irq(&amp;adev-&gt;userq_doorbell_xa, queue-&gt;doorbell_index);
@@ -626,6 +620,9 @@ static int
 amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr-&gt;adev;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
+
 	int r = 0;
 
 	cancel_delayed_work_sync(&amp;uq_mgr-&gt;resume_work);
@@ -633,6 +630,14 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	/* Cancel any pending hang detection work and cleanup */
 	cancel_delayed_work_sync(&amp;queue-&gt;hang_detect_work);
 
+	r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
+	if (r) {
+		drm_file_err(uq_mgr-&gt;file, &quot;Failed to reserve root bo during userqueue destroy\n&quot;);
+		return r;
+	}
+	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
+	amdgpu_bo_unreserve(vm-&gt;root.bo);
+
 	mutex_lock(&amp;uq_mgr-&gt;userq_mutex);
 	queue-&gt;hang_detect_fence = NULL;
 	amdgpu_userq_wait_for_last_fence(queue);
@@ -664,7 +669,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	}
 	amdgpu_userq_cleanup(queue);
 	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
-
 	pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);
 
 	return r;
@@ -856,7 +860,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 clean_fence_driver:
 	amdgpu_userq_fence_driver_free(queue);
 clean_mapping:
-	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
+	if (!amdgpu_bo_reserve(fpriv-&gt;vm.root.bo, false)) {
</pre>
      </blockquote>
    </blockquote>
    <span style="white-space: pre-wrap">The second parameter should be true here, and then you actually don't need to check the return value.</span>
    <pre wrap="" class="moz-quote-pre" style="white-space: pre-wrap;">Sure Noted. Should i do that in other patches too in this series where i do amdgpu_bo_reserve -&gt; validate -&gt; unreserve. so change this false to true and go without checking return values.</pre>
    Regards<br>
    Sunil Khatri
    <blockquote type="cite" cite="mid:25488a11-dee0-4397-949f-d166edaf674c@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
+		amdgpu_bo_unreserve(fpriv-&gt;vm.root.bo);
+	}
+
 	kfree(queue);
 	return r;
 }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------pxZkJHMINuRgPLLDfjHazoj9--
