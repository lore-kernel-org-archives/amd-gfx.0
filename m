Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4ABC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B376109D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0B376109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DF089FCA;
	Mon,  8 Nov 2021 14:52:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2B389FCA
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il16MT3me4NpZmzLFl9J/sEOTLLV5nHTCEYilIAIVlD0Vp9y1alecR0dCkn+K9v3P5QZxF6q5Tk8rjX3TZdsRqQPppZL4sl5cx77r1ak0B/EZAoMm8qSjSgSRg0N+Rvp/blYLQR6afDFLaY8TSrh8KrtX+vgPBGxVlqFw7iujl0hndfAPpXNCNETvL81S9Zd4wnHOBYQLIkY4+ME02tcGla29QTHqXuTjXV8j+nViH8nX6OpoRv79kU0sBai0l5K8F6SkyS69xKEyqbWZhKajchxcev/R0FavbgK4QyNZsGJOYOPwSbLrtaatuLceZlfHfh9GnnOhQgSTs8HDFrKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrAjJksoW25Dq1Hz8Gu3aXPMlCK4bxcaas7wV6fyANc=;
 b=VQOZnS/hW4BQtHHc5F+AgNgnmcKHHHAfzUn5Dh6yd9sKzd23YPx2f3e7/jZnZhoxLBHMywLl993gnSmNPt5VPWKoYexBQG2GzKO7RgOWIthfvzzO5jFjnWyeWJ0UfhivnVqQEBwna7/YenIFqmCA0Lv/qwxXqGxFOPpWfzpY/gP6fLuimoVwu4qjdAhcgOlXYnMd8OgaJE2fh07E5mkI9dSrb54ifEb0FnG9iZUrc5KDnPD+M3PW/up6WNuXEWUI/b1g5PADakHnIbkHLoD+0ucCSunCcxq2BMzhqZbR3f8lXl+FB86MC25BconzVDPqpMaeXyDynpAypE9di18lUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrAjJksoW25Dq1Hz8Gu3aXPMlCK4bxcaas7wV6fyANc=;
 b=ivBH3rnMBT9LncKA04ppNgX0ZI6nXhyGhJ4C67iGlzGsXc4ObArbbVumgDInYQ3VELBrcOSLqkr6W1Upu9kyTInD1MTJCvpOcECaYo9d1O68HYZTZIedB0o9GnXCI0KHYiTOy2knXZ5ozXjtUv6YHNnVbV2kNNDAwPjf3S+hCJE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 8 Nov
 2021 14:52:21 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975%3]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 14:52:21 +0000
Message-ID: <1914b043-0ae6-af37-5b1d-0b3696ba86da@amd.com>
Date: Mon, 8 Nov 2021 09:52:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: fix exit from amdgpu_dm_atomic_check()
 abruptly
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20211108135645.20317-1-shirish.s@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211108135645.20317-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:6d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Mon, 8 Nov 2021 14:52:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cedbc36-9bd1-496f-2f75-08d9a2c75e2e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5395:
X-Microsoft-Antispam-PRVS: <CO6PR12MB53956EA64564359A9098AD778C919@CO6PR12MB5395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/hw92YWQTlxYJu5sLXVBFT/SY7moIUBOjhSAd4SoD0u5fXIGVM147HPLA0jR44rwkitEEgwiqITv2u8KElOVMZwbTu8smiNL5Abda0yEQ0JISIyrtpd9p+aNKUZDlGeK7/X8HbejHA2zUT0IrPJw6K2IaHfgJ3hSd2YJHrUcv4tlN6VZUNDXT/7ssFKqPVIEs3yABFEJ3RLOII99PEHjjYRGBq8eny7V21XyRtQCbOcdHd1pzbsnrybld4gufHXLjNIf9/lbhaYIfabS2malJO9dRLCDwXjTYCsMXeWOwpvOhhT1YN5THhTHqoGlfs0kjAxzd9yWwrWi6CyVHpOQgO7Mw35Sv4t3Bo6FeyLYRcZvIqylLxzuYtJEarBZ5dBQ09aoIBqrfZyzvupWyy9TvxzLujbBj3IGgejoKGTOjW9JRscblZPy3nVTyy8VkVpcaNqUwqYFXxcxl6EbIkWRrzstdaLCpTq26B6jDLq6bPPxWXgKnogrKeXnJ3EgIB85bNcQdlG13WcKr+9eHRn6qrNOqLJXytZK5auf60jpGJQFr9O5dhfgcVj/Y05uR/27uvM75zFyvjekjDNM6p+kcPs+ikAsHPjBPa3UwsF/C3vwPRA2JHILU8HPcavwSm43ONzR9IFK673UfMUcYK5x94JI513KIKKXjlBiPMXaEO2FnzL3q+7ewHdmLXobfPE4/e8P6iustBl1giHPUZSDLAUZZlh2gg1ZX+Krn8rT+zydB7aFIFbohN+/puq2HvH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(8936002)(66556008)(31696002)(66946007)(86362001)(38100700002)(508600001)(83380400001)(6486002)(53546011)(8676002)(6636002)(316002)(36756003)(44832011)(16576012)(956004)(110136005)(186003)(26005)(4744005)(31686004)(4326008)(2616005)(2906002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdGeC9DbjY2N0plbHl3dFhSbEFFSVB4Q0xxVzdiVFFHZUpjaUl0eFN5OW1B?=
 =?utf-8?B?T09nVUZuTnhIRjVNcDhzRStKTTAyaldzM3hSRkdKRjRWTWZxMFRRQkhIRTRt?=
 =?utf-8?B?YUQydXpIelhpR3NzQmQ3WENoS0g1eVRIdXFZYSs2RXFiM1paSWFQd242Q2p0?=
 =?utf-8?B?a1AzUGsvU1hIa1d3TitNZXJ2cUg4WGhqbVJ3OE9iUmFBTFBQRFpwSXpTc2M4?=
 =?utf-8?B?eE5zQXBjMFJNR1JRRTI2TDVQbFh4NS9EdmFFNVBCT0ZYbStrWGtrcy9HaVhJ?=
 =?utf-8?B?OEF1N2dZWGRrYTkwMG1DRnFrVzNNTmY3ZDdHOHg3dGdhTHhtNDJUQktPd01S?=
 =?utf-8?B?NkMrN2JMSmlzRHkvNzJ2WjZQNnR2MUgrSUJFOXdFM0VVTFZYdmZHS0Y0Ynl6?=
 =?utf-8?B?enZOdmVYbUdxbjlyR0ZwZzcxaU05dDVwV1RYREh0dk5ERXl0MHlrNEpCcmdm?=
 =?utf-8?B?ZW1jeURLL1gvdjF0Sk9sWUludGNJL0hOSEpBMTNmcFlBSlU5T0JiSDJlUWZj?=
 =?utf-8?B?WHpack9PUE5EcU8rTzlUdGNMVS9rVG5VQmc1SFRHdzZ2WDh6b0czU1ptWEJH?=
 =?utf-8?B?Z2l3SjJrL1VmYWFGd2hxRXk3VVpyZys4cTRremxOYVIzdWs5UzdzTkpTajNv?=
 =?utf-8?B?djJGRWRudm9mTUYzeW9XNDlRZ3piaU9IT2ZiVGt4YmZUT2ovVjVRMGRuTjBO?=
 =?utf-8?B?TnBIcHFWOEh5a2o1c1kzZHVFOVFkcFNJTURQYUpWclBHWWYvaTd4ZnR1ZjV1?=
 =?utf-8?B?ZDV1eklqUnF2YXJVVG1UcGEvbDU3R01UMGNsUzFZSE1kSFQ0REJFOEM2ZWxG?=
 =?utf-8?B?VjJKU0dVTDUwd25NbnNtMEdCcU5uSEgrOE5pZFR5TWNLUmZOc29kV1IzdzJI?=
 =?utf-8?B?OVpHbjVjSGNZY0Zzb3lVOWlrTWxTb0FCUjU2eTB3MUdJOVRyN0c1UDBkc1V4?=
 =?utf-8?B?Y3B6M1ViQ2hHV1RYTG1tbXc4QStTMlMwMDl4QUhKcnpxdVFWOEVVM2pjRFd4?=
 =?utf-8?B?dFhKWklaVldsbURVaHhRSHZHQng3T2NqNHBIek1kS29adFlYZzRwY0tFL1gz?=
 =?utf-8?B?RTZUVVNFcXF1VFV4ZlRicG5BNWNIOVRjcll5QzJ5OERYWThLWkYvN1M4dFUz?=
 =?utf-8?B?S0gzNCtwUFpqa1UvaFZJVjRqSzljNmN6WlVmeXhRYTdRNy9PZm5VL1kvbk14?=
 =?utf-8?B?V0JnR3EzUVBpTjFzRCs1VTBmNjRyQTJTa0JKMUJ4NlNNNDlqdm14T0xLdXlX?=
 =?utf-8?B?T1hwK3pKZU1MV0Vic2JWVkZyMm43citUMmRxeWpIcGdMNWpIL0cwT0JzQW9o?=
 =?utf-8?B?dm4rWXlhVjN3Zmo5L3dpTlVWbCtJVyttNmZWcmhZcHBJam1ybThkbTlDeTlP?=
 =?utf-8?B?S1Q2Rk40aTQ4VFNNT283VUVmRjNvRzF0OVZOVlNJT3BqZFZrQXJpYzRhTlRo?=
 =?utf-8?B?b0dKNklPVzZlZkhKOEVBdkIvTnVHY1V0WERNV1EybktVTERwNDRVMEQxY1gw?=
 =?utf-8?B?eGorcHZxOHF3SWhyYmpRYWc2TzN4b3BGQVp1VjJKQ1ROQ2g3MTk3eUlJRjNS?=
 =?utf-8?B?T2lsbitaMW96aXNZOW5YUXdnSjFrOTFydlRoWkFLRVhTbThuTWc0dEJEdjhO?=
 =?utf-8?B?MUo3RWttRjJEditpbXhvYktUVE5CaGRsbWF5TThtTXNQZmJtWWZRTGdoV1ZL?=
 =?utf-8?B?eTRuVVk3UnJZdkdtVm5NZklZRGpmMEJhb1B6S1pUZmlROHVaWGJNODlMTUxm?=
 =?utf-8?B?cVdBNHk5S01peG1ZSVVVNFZRVGNLZkVseXZMTStXbmErWHYyWjBMcEszZ3JV?=
 =?utf-8?B?d0N1c2pCU25BVWFLSkw5UVpsU1BubkF2UkZoYk1lQmZEaE1xOEtac3FlSTR2?=
 =?utf-8?B?M2Q1RnpQRm5KRW8zSnpaZjBFU0lKcENGbGxzdlppb2QrNGRzYkVVcUJxbnNC?=
 =?utf-8?B?cnJ6Zmt1UEt1dVd5VGs1RHNwTER5M3ZFcFl5eVJrc2l5VklIcncyVlVNV0tT?=
 =?utf-8?B?NDRLZGNla3cyVDRnTVozY1NyZDBhWnlsdU9vaG81bzlTWStOdWFRQTdOUUQ1?=
 =?utf-8?B?ZmdPcS8xeGNwSmIyRWhsZHVLMFpEOVFMWnNoSCtHOEcxYk9tOElWdlRRUjR2?=
 =?utf-8?B?YXM0Ym1ONEd3Vnk5cDZ1cFY2T0ZTcVdwZmZmMzdpaEZZQU9Ma2xmVGw1Ulln?=
 =?utf-8?Q?//1ApCtEhuyNZ8rztndB5l4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cedbc36-9bd1-496f-2f75-08d9a2c75e2e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:52:21.4640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YFRnjYQuGShSC6ZV8GuDR3inGG7051jWCOIgeQxBpxWlTLRe+B9rSsq7dISqCBzXWG10Cak8fSFH12iT//qCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-08 08:56, Shirish S wrote:
> make action upon failure in "drm_atomic_add_affected_connectors()"
> consistent with the rest of failures in amdgpu_dm_atomic_check().
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1e26d9be8993..a27c246143ac 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10801,7 +10801,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  
>  		ret = drm_atomic_add_affected_connectors(state, crtc);
>  		if (ret)
> -			return ret;
> +			goto fail;
>  
>  		ret = drm_atomic_add_affected_planes(state, crtc);
>  		if (ret)
> 

