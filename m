Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAF4E7D0A6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 19:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526CA10E604;
	Thu, 21 Sep 2023 19:40:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65FE910E604
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 19:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUDbVaLoKpcQgPTH5xxJJl8HQdhfExdnV9JpJjOtTiTNCz5CDOS96rYdanL5hD0Ur03BdoMj9CwHp9WedvoF32ru5wKBQZTeXzrwRU2nss1VkfPh0+bmPmacizFBtnNLyikGoAiyQRNeSnVBF72zil1iu9E9Fovl6+0mWjyxMLJ/J6ICUufU8kqNOFBl3BcicslFsktujRQ8/FhI6cn3EcI7MowvdUKDCZnt8yZVkfEdsX8c/HM9lok8L0a49dWM7F4JgqxD4exfdjJj0t31tTL6yQxgqDGr1f840p61m5j79jEuNx/OTWUS4HZ0iMk6/mn0WtSbB2/Ikgh6GYka+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chUZFyMDliJ+mDtR0yJb2kye1t8kb5O6SfSf/OI9CYc=;
 b=ZWMeNFh6cq4aXJmiRFmw9Nm9wEEV/ozo0WOU+DWN5SMbAJ6Uw5xeeA6Og82f1PibYSmZfwMSVcKJ8DY7+InUDQGt0KioCj7cXpNxhyxnLzBsDColUFEB3KpzIRnHzq2+8xshInmCUQJuLerE05YY8ujDneLreCeQUtzYYKP9X/dXkjCutbtTrO8YfiDrSdViJiCdzH8VbasYWkNO6HL+EVZpZ0F1sMw0auSfJQkeAkQZzIxfjQQ1HVcyav/lZjTWlPI8Vqccu5A9cmcqw/P86SnSoJ1C8R5cyD+TgME2evLPjGLpZwubSHVHjzk5HuTrDgrFwVqT5YXflLoVv23SKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chUZFyMDliJ+mDtR0yJb2kye1t8kb5O6SfSf/OI9CYc=;
 b=ygynBAC9yPAlcBK8QaN0kMjYjcZIK08pUnycyyp4gtrA3P0E3sBT9Jl2H0b3kySWAzhGh97QTa0EmrJlyMi/GBHSg+i1eqEFPfmazR7huIGOX00O4fMRaoFIlI/eX0Reo6AANu8FY9s/wNKKA4bf7fThBdDbWCJ17lOk9JbbJtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 19:40:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 19:40:00 +0000
Message-ID: <b2371408-5a85-be5b-169b-d275ff141af8@amd.com>
Date: Thu, 21 Sep 2023 15:39:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdgpu: Move kfd suspend before evict resource
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230921033242.22593-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230921033242.22593-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 7816b0aa-4d21-4b28-fdb7-08dbbada8b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VHHKgnOKNjxE61axYhs6Cam8OFZiujGK6PI/fk5kxYc3QqcCebhB0CfKecYJs/jWv0+s9RmdQLrQn4lqglOkigLL/DDdaHCBbru5NMBoWIZJ6BAxDdArwr5ZeD6gSEY7EUQnkj5NgiuDRUAxno/JUsHNv4xiwyLvDb6d5LWjD+KxzQq1aGZQlIoEJ06w6Q2RLkAW6LGsMpMVMzbf0kZ1LJvHFV5DlCZ5X2J+ZOy0iqU+s2ISlY2Q2k5FyGcV065CKwX+iL8BoyeW+bxgd7hBx0YR6WZSLGB7CXH0iKwDjAb8ni2GubX3RytqpCUEiCeavGshs7rsKi/fQC+Rdr/S8M1fKm6ZrEzbrWXeiqMD698WlFd5FnVsZxn02gAo6dmT17Lw90S42g+FCqXmKxuE2GwnciY3MrQFxEPWLV/dthbus3IBbXEkCMpSyxLa8xGpdiceO6A0HpePOOXi5J8kUmf1lxbQt0VRRd752lEZmdhcXG8kC3mm2FBWdEUdEf3vuwk/WKqmBxIXHP0X0vAZKnT6H+DijxCXmyoUaxihAqYaWqprHMOUtVOHqzTSVZQEWdqGKBkgQTf/iisJXL9Gm4UFlwNDZMyE+3JzspzgQs5sqgxkQO9RD+F13pHa4GCyilHsGXbk+qteXE70vnaSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(6486002)(53546011)(6506007)(6512007)(83380400001)(478600001)(5660300002)(26005)(2906002)(2616005)(8936002)(66556008)(44832011)(66476007)(6916009)(41300700001)(8676002)(66946007)(86362001)(15650500001)(31696002)(316002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWowb1I5RlhkYTJXWnY5UFduSnkwMDd3MjYvb0MyUHJaNkpWa3U5bWk3Q1d1?=
 =?utf-8?B?WlR6VjdVSFBPeDRBQzlQZ1VQcE1JUlYvRi81NzlrT1VjdStZQ2hNMTBGU2Vm?=
 =?utf-8?B?Y1RhbVpwTm5PT1RvYTJZQmRGL093dSt5YXJqMUduMzhRYm9qMEhHZ2FMK3Z1?=
 =?utf-8?B?dUtCYzZ6OGFBcVNsdFo1UEdBZFVWSWZXTU1aT0xZc3dRZzVXalJDaHR2b3hl?=
 =?utf-8?B?VzdJRFJVMFRQSzFoMmdJN0hPV1ZBWW8ya295ZThFNndTUDFYUzdsMU9IMUNR?=
 =?utf-8?B?TGl0RXAzeUJCMjZueWpKcmlqZXdDSXJTY1JnUE1wcllrYjU0ZUVYSDU1MVBo?=
 =?utf-8?B?bnIvL21MckVnSEdFaldVZFpwd0ZxeDlNT2Z4c25lQnBGajhLVWNzOUlrR2hC?=
 =?utf-8?B?MDVETEtVdlV1bm1OQXJSd3pKRGhVR1ZRYy93NnduM3BJbitqOWxpRU1KY3BF?=
 =?utf-8?B?cGxlcXZ0WUlFTWczRGd0THFjeGRnWmFVcmZEeEZ0M2w3ZTA5M3d4Y3FSRzU0?=
 =?utf-8?B?R214bGpjQmgyZmRIRnp2cjc5UXNQdjRkMEJIUllwTXJmN0RuVUdROE5GT1Y5?=
 =?utf-8?B?c3pETndxVmNXOUFYYTNFSGd2d2VxaEZhem1mZ09HSDNNWERCb2VMLzhMWmlm?=
 =?utf-8?B?dHJiMGNlalpOZlJrb3RQOVo1YVhFYjkxLzNZZ2dwRllnc1VldWJKR1h1cHpQ?=
 =?utf-8?B?VWZBbVZjOXNscktKUEJKSzlIR1YzNklOamJGYXhnNXkrRWkxWi84RGxzY1Fp?=
 =?utf-8?B?U3JsSjVzdmRFb3E2bmt1ZG1vRURlQ3ppd1JOeWMzNEZiYVN5SUxucHhSbnNn?=
 =?utf-8?B?NjhXZ2syV09DZEJtcnVJV2Y5VVlsT09kVzBvTHFXQjZiSlJYQWxQckxTaFRl?=
 =?utf-8?B?R0doYlByTUpKdnMrV2ZLM1JoM0dTd1ZsV2IvbGtjY3F4cUFWZk1RTWs0Szla?=
 =?utf-8?B?Y3RuM0FDWnRuRW5OTWc1NUhYenc4RXNZVUs5Q0h4dnBVWG1BNTBadzhrVUt1?=
 =?utf-8?B?andraXRGWEc1T213M0F0L2FXVWVlZmFRb2U2SW5DUTZVL0N3MzRiOTBqQ0Rj?=
 =?utf-8?B?UWRsRFBtcjJDRlJ4VDJja0FNTEh4Nm13bVBYUFdlK0xSZE9pb3ZaTUJpamlE?=
 =?utf-8?B?T1NyZGFJdHBuZDNWdHdURWtGVDhHVzBlbndkamRab2hIRFY3N3FiRE9JUDl2?=
 =?utf-8?B?dXZOUFlNNldXMnlUQUVTVE5jMlVFZHV1RW53aG5tNUlvTE5WRnJrc3JlSTl2?=
 =?utf-8?B?L1Rxb05nN3hTT3BuRjIwUTdUYTdsUlozSWtaWkZFWVByVHhRNG1IL0dEK2J0?=
 =?utf-8?B?NmVHRDB2T2M4UUUwQlBobDYvYWE3cTlyVG1OVzdKVXZNRWZMQ1VtdENnT1RP?=
 =?utf-8?B?R0VSdzhXdXpuZThhQ0R5UkEvWXNhNHZEMTNIbmdrUDJTSkJ1aFowMVJ0cXZ5?=
 =?utf-8?B?cnZiSlVrWm1PdDRnTEJVOHBUZUNOM1ZPb2E2bE5DRTlLVnU5YW00T285Rllj?=
 =?utf-8?B?ZGo1cUxhTTVrNk4vR2tDTC84S3JlRkdvQ3FiZENkUmRMUHhsVVRoUVpxK0Zz?=
 =?utf-8?B?Wjl6dk9IdXV4dW93UnRNTHlIUFBhNjN0OVdaR3dhN3RMc1UxazFrU2tUeTN1?=
 =?utf-8?B?SXA3K2VQVlo0REl4RTJ1eFE2Mll2dG9jYVN2aStDa0ZZbGhhMGdxci9xRXMr?=
 =?utf-8?B?ZmNRcldUMWdLamUxYWlHejZzckFSN1NXbCtDbWVsdlhLNWl4Znp1aE1Rblhz?=
 =?utf-8?B?OXFYcXB2bUcrZ2NRejc1aXJHa0hzaW1sV09PZGRiZTFkZkdFQlJERVUyOFVI?=
 =?utf-8?B?b1UvL0k1Mm0vYVpVRDJYSWhRaElreG5BKzdxWnE5a2VuSUlIbGt5aHY1TGtP?=
 =?utf-8?B?TmNKNXEyZVhWaWdnWFo3Z2dkNEs1Z2w1bWIxMWRxcU4wNjVkRWdOZFE1Tksr?=
 =?utf-8?B?dDdYODJ3a1pkenA2U0VVaFhycnhmTno0c2d6RWZuMG52SGJLS2pLNDZibG9y?=
 =?utf-8?B?cC9nYVhsR2FLMjZlMWlGZ2FIcG1UTDA2c2ZmRG15a2s3VHRyTEdpVDFhaE9r?=
 =?utf-8?B?bGVjRHgvZGZJb1NOQUc0VHpxNkwyc1hqQUdsUlhiTmgveWZMSThuNnJOMUpo?=
 =?utf-8?Q?4OPlKAYOLpFz6BEqqItsbAGfC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7816b0aa-4d21-4b28-fdb7-08dbbada8b51
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 19:40:00.7286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLnFedD6Qllsmh87pkvEM48m2Z1xpj5FCygcZhUGtolbGV/RnQjlJabktNQjbzhwWAIGqyBJBlUZkkpRA7/3DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
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

On 2023-09-20 23:32, xinhui pan wrote:
> Like amdgpu_device_reset_sriov does, kfd suspend should be called at the
> beginning to make sure kfd BO is idle. Otherwise the extra
> amdgpu_device_evict_resources fails or amdgpu_virt_request_full_gpu
> timeout.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a084c3c58a32..ef7c7f2b3260 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4148,6 +4148,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   
>   	adev->in_suspend = true;
>   
> +	if (!adev->in_s0ix)
> +		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> +
>   	/* Evict the majority of BOs before grabbing the full access */
>   	r = amdgpu_device_evict_resources(adev);
>   	if (r)
> @@ -4174,9 +4177,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   
>   	amdgpu_device_ip_suspend_phase1(adev);
>   
> -	if (!adev->in_s0ix)
> -		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> -
>   	r = amdgpu_device_evict_resources(adev);
>   	if (r)
>   		return r;
