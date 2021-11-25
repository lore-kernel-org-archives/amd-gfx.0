Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F9CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 07:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FAD56EABA;
	Thu, 25 Nov 2021 07:11:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A876EABA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 07:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnPkHQbC5tkPTqFztgmsLphQnyUENJ7c21Ppu6XoRohCUlr8cSpFjgrGtDOQkNEJtZHYeLOS1FcGm93eho4rVlW3X4/4haI0//R/5FED/7PqDye9kYlYlDUSNkOV+ZJMVJ3LZQ2geAxymyZF5jislJfBD67zhEDUgmJJLKsANoG1at5hbx71VrPkAlG4dqjRvLb1aEcjR5IsJ/aQB0j+LRVWrVOq00ykhpLzBCgPzSePEkvke5WCx+KOM23olLYRC12lY6o3jegDWH5EilHITGPuqkecWFYTBR9N5WkwZ8d/6/izUYNlfNkp67Ma5ivMAvNlPinDVNn/3ANYJRHdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJp7nXc1QY1hRpxc8bN4cb0jPHPn8JVgndcnc3QkZz4=;
 b=K+4atAp0kNe0GH2tKEvuZdcbTlUdUQviUIAQC15by4HXEnCgV283mlVK9sMaPdWEX6gmyQS8/Va+AebvFGRbo5wR8bynGUXLm/eQTgTVMY/6ka66ahVCWGHkk3KYJJJ2ARw6f79aO5vTZzYwcnmNmUOSxxF/9ZdQv/GD+ol7m7zf4uRMryCoWzFw598QtVxuhhiPFYoKcef/q9XPNOXX3TZv78GM13MNCFsIMgXcsxQgefRolGZWNYqZwtD5x258xHvfoQnA1lZnugXaCLJqfoeSO1/BcnXHvmKiSxHyGicejDiyxvd+CzshebY8f/ikyRBdRl+OiR3uDz/ra2bDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJp7nXc1QY1hRpxc8bN4cb0jPHPn8JVgndcnc3QkZz4=;
 b=UHvGojajvkeuydQHtz+ZbYFqBoA3hj1y+s5hFKMmKWpgEj/hQn2vLVOo70jEh2BgQS8ctB9SHHx39Ivk5VStnSw2xXdsvxts++mop+oZeDep2xlJx6iCf41SBEgNsgUDu3Ef2OrdIiV0f1J2vd7M63JZ7D+bZvjK3Zo0r1+jhWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0109.namprd12.prod.outlook.com
 (2603:10b6:301:52::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 07:11:31 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 07:11:30 +0000
Subject: Re: [PATCH v6] drm/amdgpu: handle IH ring1 overflow
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211124225827.26232-1-Philip.Yang@amd.com>
 <dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <845473a5-7c90-06ec-fb24-5e8c640aab0f@amd.com>
Date: Thu, 25 Nov 2021 08:11:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM9P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::8) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (87.176.183.123) by
 AM9P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24 via Frontend Transport; Thu, 25 Nov 2021 07:11:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6bcc71f-b854-46b6-d079-08d9afe2ce0c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0109F11E073CA182974AC24883629@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTdAkvVRk0zaU36gqGiiRYGmjmkiNJ+bOv02o5siCwmRFf0u/monswlkkBPqsWeSFpfuwp+q2U0ZOfZngZC/r8ekdD2WHEuSUcRPBZVzng9z9jbcOUu83iGtua0Ddqw2k///iplVxQ2gYK1ml0Bfm5YLaystf/YBIW65Nd+r7bQWZUZB5G2kr0VyuEt9kXPgIjes6pPhyD72y0pyLpHwxlZd3Lo+FqJAoa9HmFnV8s4IePmLpw3izfNC85uNZoJyx3YyU+VhVhr11AzXiLS0195FAKpzwnlyBzkxprbSvAjzxdVHDN/9BWvb20bWODasvrGpHpE7xoxA6ErIWy9Wqz0I6DI4I6KxCEZJhRPi0TZbkta6yKhZW7tmGcYf2/E2uVjgz8CbcLymzmD71ksj9FVdCkotQbUSAurkdEc1FcdbvLKhapD74I9NHO/uAq90zyZ+Ye2hVxTy+u4vuVPbaAl9H5wqoVvqGyta6L7NZn7NM+SuOylbfS7xiQtFHEBIXu2vSsYEgiACBS/l8G5r7VVJ08D7wyhcatvw2XIfMod3vX9jVTg5ZeBq0vSrJ+cOaQ0lriyupwa5+i5SlEs/tGv/P1dRieOsoUvvlT4VD5c9w9h7rviFXpH56c+tw4CH5RMkRtvft0Wzi5HCjpuoM/ADUp9JF8Rn3tukJFACh0x8fGDri3k/tyEVraqaACxa6b5o9ivwNj3WjVVThCqirFMT2iZC7dfaqKDxe5Uyb/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6666004)(6486002)(2616005)(956004)(66946007)(8936002)(508600001)(66556008)(8676002)(66476007)(38100700002)(316002)(16576012)(110136005)(2906002)(36756003)(31696002)(31686004)(4001150100001)(86362001)(186003)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNTZndVcGh5bFFXb0pxblB3REpQNml2NWtJaGU2azlaYU5nR3ZnNWVJMmgr?=
 =?utf-8?B?d05mcDFLcGR2WGIzQlZ0UmF5ZzdaajVoQUFqL3lTVWJuMy9ZZWdPdkp5ZFZS?=
 =?utf-8?B?VmkvdllxSy9jQ1FMMFRMR3gvUytOV3lmcXcvYzJkNzhScFljRjhVWUVSK3lv?=
 =?utf-8?B?YmowQzFUR1N4akZPNER4ejAzMUxhZXdxYmZvU2wwMXNJNWZ5NHNWR0E5Q0dQ?=
 =?utf-8?B?TkxmSXlnUnNTVDIvTE8wZU82dEc1cEhlYUxqZHcrNmt3QjBNQWYxbEE1YTJi?=
 =?utf-8?B?dis4WXgzVlB6a2M3T20xM1FzWHpHVERPWGdQV0VxQk9KWGVLd0Q4ZXVTd1NR?=
 =?utf-8?B?ZWpvZll6eHR4ZmhDY2wydVZ3R2kySC9qN2VuVnlrQ3c3SVp0cDlPZStzVlIz?=
 =?utf-8?B?YjUybVZUYm9lcWZTR1ZrbENhT3poWXNrWmUxdlZsQjB6S1ptYnNZbDM1NXVk?=
 =?utf-8?B?elF2MHA4QlpmVHJXR2lGaTVVKzR3NjdNQ2lWQUlUY3U5UXJwSS9XRDdSTW1S?=
 =?utf-8?B?Z2ZQZ21UbHZPRnloc3kwU0htUDJPb0VVblFob2l5TGlOaXVWdVNrVmdDT0Z6?=
 =?utf-8?B?bDNyemVlTFQwaFVUcE4yNllmdDFlWGtYbmRCT0p4eFA1UHhrUWNwYktmcEpr?=
 =?utf-8?B?ckx2TkFuWkhLRUNLcFZidXFUQU82RFNGdWJLVk9TNHJ5ZnZjaEkydTNiOG5i?=
 =?utf-8?B?ZHNqUXNYNnJXNlBWK2pHZ3ArQ2dVL1F5SE5CMi9hRVpEbUNGQUdiWXJ5WXFV?=
 =?utf-8?B?UU1FaVJ0SkJXNjdjUHdyYjdlczFGOEFNOUw2UkxEVEdVTUNIaUl5SUJxeWcv?=
 =?utf-8?B?RWVRSFdLM0taRENxODJYWVUzRkZvNmx0OGlXRGlkdk9OdVQyT0FNQW04cVZz?=
 =?utf-8?B?UzcxNHR5WEtPN3lEaDJkd2hVRElDVkR6c1kyWGRYYzRwVVRhOWpUcDRDUjRk?=
 =?utf-8?B?N3UvUlIrbjBrdGpIaTRtODMvdHFrWUoxTHlZcml0SWxIQ3ZhZW9QUTVybm55?=
 =?utf-8?B?RDhrVDcvRGtrMFFGbkNkaU9kM0dIQ2pCbEpYOGlJelg2MlRqOXd3RDBaaUJG?=
 =?utf-8?B?UUVDV2JESDliL0ZOSjNySG14UDl4UmQ1QXZ3VEIvNjNIdmMwTTVUY0RaWFpi?=
 =?utf-8?B?NmVyQ09DZ1FWMzl4VG4xK2FIVUNKb1ZXbWlGVFNhd0JNV2ZUOTYyQTBBWEIy?=
 =?utf-8?B?MFI5cWFnSmlFNHlSUm50a0pOdFJxVFI3SXBGRjNjQzhhM0dlOVc2aGVSa2ZV?=
 =?utf-8?B?VHBUTGkyZG45MVo0ZXN0RVRGb1JFTzhhUGNOc3JjcU5tZTh2SUxMUjBXL2xM?=
 =?utf-8?B?a3RFZVJGM21xODFSVkdldWtudmxkd2hOdVg0S3BpbzNHYzQ5ek45ZHhUZU1O?=
 =?utf-8?B?WjJVcTI4citCVUxwSmF0OG1GaFpsV1ZwMm1jZ045aXltcS9hMTkwTE4vNU9D?=
 =?utf-8?B?bHNFbUcrT2RBMDV4c2QydHRjb2dhd2ZjN2hLTkkrU1ZXS2FsMy8xaENhYzha?=
 =?utf-8?B?UU5Mdm5mMmphSzlHQ3hQZDljWnRqciswTkI0K21XNk5nU01vMklKOE1Yd243?=
 =?utf-8?B?YTVJSmxIOUxwTFQ5UmVnZ2pKZFZzTnM0VStVbkE1UHNBYmVJUHdyK05ub213?=
 =?utf-8?B?a0oyclNKU3RlRUpNR3QvRUowN3pSYTZCZ211WXF2em82Ums4RFN0ZzVUMW1N?=
 =?utf-8?B?cGdIYUlSUWNPb2UyaU9pT0F5dDhPOW5KZDgwR1VndnBPUkh4bGdIelpnTTRC?=
 =?utf-8?B?QnMvdm1lZUhxelFiUVlwK2hnZ25WVmMwRS96UDVyR3VjVFlPOFZFZDdHN1Nq?=
 =?utf-8?B?UklnNVNFb2U5bXNrUWVvcmlYTGx3MnlQZENtMVZnc1JNSG04blNHYVpNNXRG?=
 =?utf-8?B?elBpeXZhRk5oRUtPTm95ZVZYTm9ERmdPOWpVTFpMSFRMOVI4NmdoN01iZU5L?=
 =?utf-8?B?VEhhN0xFMnNuUWl0c1JLaFhKSVZybU5BTHFBcUEzRHduaDJHK1V0WGtGYm5R?=
 =?utf-8?B?MVRTU3dvSXQ3MDd2THRaVFgrSHU1aXdMSFo4Visrb002NzZqTlVia29qMCtS?=
 =?utf-8?B?aGlQS25WbW8zOWlkRUJjYWFUMFFab2IyVVg0cC82c1RRL3JVeVpPOGJwTHJu?=
 =?utf-8?Q?1akY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bcc71f-b854-46b6-d079-08d9afe2ce0c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 07:11:30.6700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aRDokbgaQcq9njoSgUkEtzoD5hXraMdLedXsA+b4tW38QXRagEoab5CiE51NiFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
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

Am 25.11.21 um 02:56 schrieb Felix Kuehling:
> Am 2021-11-24 um 5:58 p.m. schrieb Philip Yang:
> [SNIP]
>>   #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
>>   #define amdgpu_ih_decode_iv(adev, iv) \
>>   	(adev)->irq.ih_funcs->decode_iv((adev), (ih), (iv))
>> +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
>> +	(WARN_ON_ONCE(!(adev)->irq.ih_funcs->decode_iv_ts) ? 0 : \
>> +	(adev)->irq.ih_funcs->decode_iv_ts((ih), (rptr), (offset)))
>>   #define amdgpu_ih_set_rptr(adev, ih) (adev)->irq.ih_funcs->set_rptr((adev), (ih))
>>   
>>   int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>> @@ -89,10 +99,12 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
>>   void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>>   void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
>>   			  unsigned int num_dw);
>> -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
>> -					struct amdgpu_ih_ring *ih);
>> +int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>> +					    struct amdgpu_ih_ring *ih);
>>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
>>   void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
>>   				struct amdgpu_ih_ring *ih,
>>   				struct amdgpu_iv_entry *entry);
>> +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring *ih, u32 rptr,
>> +				       signed int offset);
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index 3ec5ff5a6dbe..b129898db433 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -119,6 +119,11 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>>   			return 1;
>>   		}
>>   
>> +		/* Stale retry fault if timestamp goes backward */
>> +		if (entry->ih == &adev->irq.ih1 &&
>> +		    amdgpu_ih_ts_after(entry->timestamp, entry->ih->processed_timestamp))
>> +			return 1;
>> +
> This check should go before amdgpu_gmc_filter_faults. Otherwise
> amdgpu_gmc_filter_faults may later drop a real fault because it added a
> stale fault in its hash table.

I was already wondering if we shouldn't move all of this completely into 
amdgpu_gmc_filter_faults().

I mean essentially we are filtering faults here once more, just based on 
a different criteria.

Regards,
Christian.

