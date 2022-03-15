Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B00AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0230210E340;
	Tue, 15 Mar 2022 07:51:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61B110E340
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lph4+dw21kX/+uuq46SoNpSsCij40lLAv36XQSv5kODD6CDypWm/fkpAigRnYMPQK7628+2nKb+WRIqiNiF0S7dlrhnvs5Z/Br1jgRzAT83Jb5528pg3IZszsgs3jZVJKC7n1x7aamodOF8WuH9eeGP45lWzaVZdxsCkA6VQuwhJ4WFiZZFSZIzSlQw3purop3fdguQpCoUWNH69SFjF2jI0fXJCGqrnlPa8s+5vdTq+C1gOLsw3NMji7vLJe9MzPUZ/ggb+Le/eqXjChnnWtbcNeq3hS+1WgRvhrfxefEkPDATRnJCTp9GhHJ2cV/8XjmrnPx/3M6+Evyx8caT2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OD6knnxI4hj0TGuBUJSkx0ilf3MaYFbMIrWUKIn4Ns=;
 b=XZ1Kxex/QUbXhVCxSiLk9xjHxd8b0ioe1WIsxVuJ7U1sZt0RbMAK0yB9R+hFeXeecGejk12sPhhNdGfKzX9AZdRMEwGTUbQL+kgiwVe2Q6DcNTMkbTO2srMV3C5dT3X2EsVnkY1Su0t16ghGiSA8kFCHHYecogUswaDd5T01rwLvmFBnSt21pyDT6gJPXwb4sGIB5GFLlkB7b9W+gR1+AOLUBclvlzDyY1bIxW1SNCCXqVua6mTHCKwacQfbQw3SzYN3EgndliHAvb7+8R0vKMyMCHRx9tiUyOVnvMd/Ys3IiILg9khqYOcmCMerb9s9WXCfdcQwcIeTuYUIkpw/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OD6knnxI4hj0TGuBUJSkx0ilf3MaYFbMIrWUKIn4Ns=;
 b=xM4NxrtT07Ch8tXGfkMHxmK2GUCv7VZEdxbe+yZL2Gh2/dEqQILLvglGf2TiUKT5AmPMAzwDd1X0ILYILy7pyoxGILjIVbnIMV6/se3QOwwQbs6gGBs7XDkeD9qo8o7Z3GTyqyfWpzF5rjBs+VNbu00QCiWUU1Zk6yZeiDDDBL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3584.namprd12.prod.outlook.com (2603:10b6:208:c9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 07:51:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 07:51:22 +0000
Message-ID: <c1e92fb5-a3c0-e0eb-cc7d-2a0ea03b9f1f@amd.com>
Date: Tue, 15 Mar 2022 08:51:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: prevent memory wipe in suspend/shutdown
 stage
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20220315070913.9046-1-guchun.chen@amd.com>
 <5931e547-fa64-854d-a212-1ce214f4e8e5@amd.com>
 <DM5PR12MB2469B5FF271B5553D419AA46F1109@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM5PR12MB2469B5FF271B5553D419AA46F1109@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0601CA0064.eurprd06.prod.outlook.com
 (2603:10a6:206::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8262e7d-142f-4ecb-fc6e-08da065898fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3584:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB358470F9BF48F15E0630457E83109@MN2PR12MB3584.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHvM+Zodzf1m1Xd7uAj2fjkJibYqbuqw6jM3ej4dpyQUqWhaGuzISeKn8ea8EzpJePTg5kZk9nQZILnrpolCZkkTXqm544bTR75J6trYKvD5Olt0+1x4jE9CP2soeLwFcueZFcYALOtxpTengXdnACEjdhQn30y4UxvOqDtcHoJQ0tIjfNO/Adn0AQ5QuRiSLLSQXUNqGhIthct0Pz6pgR24QsQcEreAqPBDhXwj4eNhcoWSTWRqwroH8+QmBM+WBvlvwDfnTPzl6mdJjgwWXS+ayYAthRCZQB53F1MaN3fS4JppvVZDaQdrOphn0s3+lEXYpJ6uzZHSbrIXIVQu9kFYhIWEvXoxrtW4zI3Frpiv/7fE6Zma+uWuEN0wuP4YwHCzFgypx6atI307vsv2zm3wUUxiLLq2tEJslxW4+CvVebEBX+6py6361ihz4CSrZCvG6qkTFYNopdPmxjjjLIKXiXF88ksiRJpqsNn8RbXXnYdp8cbFAPdf0PfDH0WxsQBsqCTFpLRCYLyooJpcgAgKOQ2rSgBiMwe+DnjHQobmRpM1LR3twUhNDyqv1VkJEwYy4PEBIfKNfhnk57MXnDuv3C/6m56q7D27YZJuQxN30kRIwnnGLpnRGuubAKBDhavZB2sLb+Q4HaMm+9MvalD0AQPO+7bl1XAV3u769n+79StZYaa+1cuNaWFMIn4GwLo/4wVtoIb4P0y8zQa5eGnDWDKFprxLq0sJ8Ak2fD5QIvkkkVqFjyIFmqUjMFLH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(316002)(6486002)(31696002)(15650500001)(38100700002)(6666004)(2906002)(508600001)(66556008)(66476007)(66946007)(186003)(26005)(8676002)(83380400001)(6636002)(66574015)(6512007)(6506007)(53546011)(2616005)(36756003)(31686004)(8936002)(5660300002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NEVWlmZWxLWUZuRjBXZ3RDZ3N3WDVGRFhlekw2bm9Fbmh4cGhIUlRLaHF5?=
 =?utf-8?B?cVkwZlA3Z2t1Z3FXa1Z0bGdaTjNyMzNUbWRRak51a01aMXRYZ1h6VEZ2NTRU?=
 =?utf-8?B?YnQwc0FuMzA4RlFldURVbmZCUFVWU2doczVmWUh1anhpK1NKZmpEZlNiY1Zl?=
 =?utf-8?B?RmxYZytJcDhuYmtDOTdqVkZETWJMbjJ1d1pVc0c3WHZiNEpvS1Z5YVYxbDgw?=
 =?utf-8?B?aUFNNDhOU3hkYjFPWFFkd2RiUkMzVXdlZEtyK1YybGFFWnJtRGRpQnkrTkFG?=
 =?utf-8?B?RFFHYmxtTGNJK0VVSC83a0VEN2kwOXhHM1hGRWxqNTRmSFZxMGQxNjEwYXJv?=
 =?utf-8?B?Z2dJM2F2b0xvOFVKWUhkdTRMaERTR3BCUUZDVlJjTUZjTngrWE9BR0c2NnI3?=
 =?utf-8?B?ZWhvN0ZKRk8rUWJLOXJZVFhSRGlzV1pYdUVJR2o4TDF3ZVVEL21JU2JzeGtJ?=
 =?utf-8?B?aHFGNDArRjZuM3hmb1VuaHBvTUFOaFIydXdobTZRdDBZM0YxMmt3OTkyZnQr?=
 =?utf-8?B?S2hJUEdtS3o4amgrd1ZhVVFPemtVWWVUYTJYbzBNL0ltZGVzeThqR3M3VkZR?=
 =?utf-8?B?c1N6T0ZibWVUdnlYY1hwcWtrZldGd3hpeGloTTFOK0ZhZUR2MDZxS3ZNaDcx?=
 =?utf-8?B?UWIzY1o3TE93ME9mOGdtZStzOExTaXlWNTBubXgrOHlrN05OaVE4SFRkV2dS?=
 =?utf-8?B?K2tSZXRRb2NldFR1dkZWU2NWVmhnUVpZSXZpWk9BY0NSVHBlbTNzY01GU2VB?=
 =?utf-8?B?TkFXYUEyRlZlSmJQZkk2MTRUS3A0a1FralFLQjNYOCt2OFRXcWtnVnVQVTJK?=
 =?utf-8?B?ZUpKTkdDOEFBS3MyK0NHb2oyd2p1R2grYU52ZUpGRkxOZDlFMkh2dVZSd2JT?=
 =?utf-8?B?QU9LUHRGaHgrUm5LVTQxb0lMMmZTUGxyTDV1WVZVTStEZHpHZytJS0FUWWg5?=
 =?utf-8?B?OEl6bksxa0hGeDh3V3F1bXJPM3FOVFM3U09ielZNNWdRYXZDTVlGWktLRkU3?=
 =?utf-8?B?TXIzZS9xaUwxMGpoT0Q5RUs5cUoybzl1L0dyWE5aSEZPbUw3VlcxaGIvZkl1?=
 =?utf-8?B?WC96bFQxZlBaUVkrQU9VK2lFOWttejQwMnZUd1poM0hYcVU4dHArcXJDVk91?=
 =?utf-8?B?bk5nVG9CcE9HRUxCYlduSmhTdkR6Syt5cHVWTUFaSENvcjh2c0FqWFk5alBB?=
 =?utf-8?B?VklEVjlNTXpkd0ZoRDZmblN1d1NHZUtYN1JWMHFPc3YrZDd6MlBROEZ2N3FQ?=
 =?utf-8?B?U0FvcU5KZUNmOVdubDFobS8vZjFHTUJjQXkzUERWNUNkTHBuWFFaa1BUR3pS?=
 =?utf-8?B?aFh6c3VSUlBrOCtLSXpoYVZoNVQwOHIzSFZzVTRCT29uVHZiNnFWQ0RkSWpL?=
 =?utf-8?B?UTdvNHF1Qjhxak5EVVBZaGcrMWpoSlFzNXZ1SkQ3Wll4TmxSM3VVcnZVdGl3?=
 =?utf-8?B?eWpLc3ZDcmdjSXpBaTJoWlNKWTZjK2Fpd2hDUWhmUGk5dTdhUlBHYlJXNnhQ?=
 =?utf-8?B?bDkwTkRKSVhnZkdZanJqYnVyODNNYXNkc0JPa3FpTldrNmFlOWE5TDU5VjlF?=
 =?utf-8?B?Y3FlRThEc3lmcG5aNVlhb01QQ3BLMjAyREwzQldBWkRlUGowRjhvakxFR1B5?=
 =?utf-8?B?NSsvQkx1a0RUMUp6am9RK3ZDS2gxYlNCYXZXTkdWYWlGOG5ZcS9KSFBzUjE1?=
 =?utf-8?B?YlpZclBwenlYV2pOVGhQdUNvV1JoVmlQdW1Pa2hXUVRwM1laaldRQUtLS3du?=
 =?utf-8?B?S0xBSEJmRStsaEYwREdMazIwdHQ3MUZCNDRIbWtZYk1Od1FEazhvcEt1aHYr?=
 =?utf-8?B?eTlGdEI4QmFFalpJRUV5ZE9HT2dtU3NkMG5DUUJQY1Q1MEUrRkhQYjl0ZUFq?=
 =?utf-8?B?a3dxZDAvU25uWXVydUdBRDNpS3JnUTNlRGMySzJ5RnZGZVAzMi84azZROGhP?=
 =?utf-8?Q?LldXDxIgNRnAFZ6tZ9eZLP7rKRY1btYM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8262e7d-142f-4ecb-fc6e-08da065898fd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:51:22.2360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLUROz+cPfhTQi2qYUML1Ha3p4399CS1k3dK4jn0wUPHIW8EU7W6irFXsLnmtAFP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3584
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

Try installing the linuxsty vim pluging. It should give you the correct 
coding style setting for vim.

I'm using it for years and can only recommend it.

Regards,
Christian.

Am 15.03.22 um 08:49 schrieb Chen, Guchun:
> I used two tabs in VIM. Let me update this later.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, March 15, 2022 3:35 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: prevent memory wipe in suspend/shutdown stage
>
>
>
> Am 15.03.22 um 08:09 schrieb Guchun Chen:
>> On GPUs with RAS enabled, below call trace is observed when suspending
>> or shutting down device. The cause is we have enabled memory wipe flag
>> for BOs on such GPUs by default, and such BOs will go to memory wipe
>> by amdgpu_fill_buffer, however, because ring is off already, it fails
>> to clean up the memory and throw this error message. So add a
>> suspend/shutdown check before wipping memory.
>>
>> [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
>>
>> Fixes: e7e7c87a205d("drm/amdgpu: Wipe all VRAM on free when RAS is
>> enabled")
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Just one nit below, but the patch is anyway Reviewed-by: Christian König <christian.koenig@amd.com>.
>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 +++-
>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 23c9a60693ee..ed1a19be4a54 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1284,6 +1284,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
>>     */
>>    void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>    {
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>    	struct dma_fence *fence = NULL;
>>    	struct amdgpu_bo *abo;
>>    	int r;
>> @@ -1303,7 +1304,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>>    		amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
>>    
>>    	if (bo->resource->mem_type != TTM_PL_VRAM ||
>> -	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
>> +		!(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
>> +		adev->in_suspend || adev->shutdown)
> What editor and settings are you using?
>
> When you have a multi-line condition to an if the next line should start after the ( of the previous line, but this here is using two tabs instead.
>
> Regards,
> Christian.
>
>>    		return;
>>    
>>    	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))

