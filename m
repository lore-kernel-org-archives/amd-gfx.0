Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9464AC04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092C410F660;
	Thu,  2 May 2024 15:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h/tnpYvE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C8910E376
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc1C9iXSwuGBSxCVWkObfYlRPdN/jPsZhxSCFVCo4CVN4NXXbmEUyVRUXM9ClwP7ykjd1uEBFbY+dRsQYTyYxUrNvPYcg8nguM9BvkQIC0UXwLnJRSSBFVlMLYE0igYNA19WKUJlQ278uz1XMyJ//VSaDThyHGlsP6XapJGad16XXAdcPTr1n4SQf1eF8tp3PYdGp8NqOXO1oFG8m0ZRqwd3AdN6dGkAfVIYwzlEq4EyNOo4ovGCUp1UJtm/UR78yXGpZxvBQgxDCGKsReHsUPYwZs9LNivC000gewM+/Zw9f4E9C52yiHDoGJ5kuRduUZe4ZPSnUL/DVYaXEJnJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WXfchWilLgIVGSsEH7HrdLH4aIBA9W0X0vNO0ckoQ0=;
 b=bdW2qeEqWWyEKzvhJi160kI9fYoptWuhjLZJRgjMRfiQ+ZnVN3v7lEIOpX3ZEMqenF8uFrwkpBxydWJvgNy24x5GClbxlTNniXodXK45LLWM7P5LV+5Rwb9mltRWdCBso9blzgVPttTLEEsX3tiGChg2PnA/bCu9c2c6+SN9NM9I+nNuskj2dgOV3YzwERLlRdhz9wSgN45g4oyeW8z2cGiu+yeDrHZXGicuJ2SsURNdYt9dRHEW3JB2APDYQhVv9DjUAH3VcEprJY34AeWyLNSj+gsRRdqENEtBbwV55sZyplgrdVEDOzKs/Zv586KPbBRvDzuvefZ+vbVyLsaGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WXfchWilLgIVGSsEH7HrdLH4aIBA9W0X0vNO0ckoQ0=;
 b=h/tnpYvEmzxzzdkLeN6j+WQRAKuE6TMhsk+Znd7gA29wegHAEp9s9+WE7cLhETVL7MGWsTSZu8JySFWfN/0MQLg+FCjMC6yi3Kl6107RQAQPWOR86NGpq3hXc38WHE68xK0DlCba0vqADKpqTS9ksivUT/jvP+E/7vZ2bM1R2ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 15:42:28 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 15:42:28 +0000
Message-ID: <83f96ced-a47b-82a4-6a01-ef1d5cf8b452@amd.com>
Date: Thu, 2 May 2024 17:42:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 11/14] drm/amdgpu: fix MES GFX mask
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-12-shashank.sharma@amd.com>
 <9ac9bff9-35eb-4726-a89f-0f72b5989117@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <9ac9bff9-35eb-4726-a89f-0f72b5989117@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::10) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f0a8c1-2f58-4c44-356f-08dc6abe78d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3hsQ2ViMGEvQ0w2VXZ2ZnZYUUQ3UnozNHBYSVpRNndpUUVlVzFrcTJ4QVho?=
 =?utf-8?B?Y2s0YU1jV0lleVo4b3NIWkNRTmxCQ2lSZFBLeklod3BCaHcxbUdoQjgraFJm?=
 =?utf-8?B?NEN0dno5UStiNjZicnRKaHRSVEwwNFJlQkR2UVg1MXhuY3R0S00rWHlicXpO?=
 =?utf-8?B?ajBFS0laalBubExFL3kwMUVFOXJpTmlvM2M1WVUvSVFWOVBnaEJQRGxVdVFz?=
 =?utf-8?B?WDFRQlQ0TzJGU2RIWUh6TDQ5QUhxajA5cm5uS0J3Y0ZNQ0ovZ2JCUXdoNUFj?=
 =?utf-8?B?cURPbWlaY1VQeXBMSWdtWS83QnQ3SklOSys2d1oxc3FTVFBXcWpvVXNISnZZ?=
 =?utf-8?B?TVV3bFN5VlFyeWtmRCtXUURpTlBNN0Z6TGxTS0pvd3dQTDlZbXB6Mzk3N0FC?=
 =?utf-8?B?L0NrNWZKRFQ3N0FoNkNLaFQ2bEt2TlpXK01OZzlsU3Y5WTRrNVJLT0NUSjAw?=
 =?utf-8?B?MFlTVFZWOGtWdWlRZit4ak53WDB5YzUyREFLcTR1Uy91NlFtZE0xaXNNMXVv?=
 =?utf-8?B?S0h5U0d2eUdwK2kxN2lBdUFnUG5kOTBuWE5KRXBEOWFxSWVFT2dFeFFPejJ6?=
 =?utf-8?B?M1c1djRvYVExTW9yakNzZENYV0hqN1R2Q2VZL0wxcTZaYmF6Z09IOWxCQ2Q3?=
 =?utf-8?B?WUpQVUxSeXVmWUNiQWErU3drVlVHUytxVmJlSVRaMTRGWDVlcHFhTXpwLzhL?=
 =?utf-8?B?TERPNTBIa2FjN3BzNmxaa0EyOFdJeW91YjBjQjZ2ZWEzV1R4blZ5ZWFXRU1r?=
 =?utf-8?B?U2N1UE9UUE9WTTRJNWlWWnJjSks4U053OFowVXREZnBlQWZJUjlEZkQ0QmNu?=
 =?utf-8?B?TThaa2gycWpsOTFBeDF6a01tczVsTUpxVUFoVHZmMWpxaXBZWWVyVnZlYlFk?=
 =?utf-8?B?R0tLcm4yTFVXKyt1NjN1c3UyQ2RlSHdsYzA4YWxqVnR6Tmd3aFFLNzFnWmg1?=
 =?utf-8?B?ZWRrV2dyNWc3THZkZHpUNHJLb0srREFxa09qQnc1bk5lQXpvUDZraGUySzVP?=
 =?utf-8?B?cTJ6bkxERjFTM1ZyNzdua3dZNklRRUR5V0ZuTDdVdWY5RTVjZnlzRnVKOUpI?=
 =?utf-8?B?eDd6ZFlUSis4RTM1b2djbjNFTW1CcHFTSkk2TmJpTGRQY3ByOWpVUWpUdXZS?=
 =?utf-8?B?UUdxeldqWU1Iem00Ri9UaGZFdzIzRVEwc0d6TEk4L2NjTUE1d3VVYlFGWUhB?=
 =?utf-8?B?UERybElHbTVOQUF4cDBrdmRDd0lSMC93NWhWejBad0VWTEpJSHZXTWtiU200?=
 =?utf-8?B?a0F0bVNRemdreHY3bDFod1paUGNxMlFqbDVVbEdvRmMyRFZMR1BramxOaEcy?=
 =?utf-8?B?V01UWE42dTdMSUUwV045emN4anRvTm1iYUdmV0ZDcDcvTWxPNDhxeVdmNEJY?=
 =?utf-8?B?TEZBSWh5U0ZGc0hnRE5Va0ExVXgrR3ZJQW1oRy9OMTBwYm5LL3NCR2xpanJP?=
 =?utf-8?B?STVFSm5pN3NIdFUyaHB6Qm53bUROWlJZdllqM0c2NlJxNGw1NTFNd2IxU1M1?=
 =?utf-8?B?Y3Q4eXN1cHljQWp2WVFjWDBKcmRERmlVWm9XcW00N2pwQ1Y5Y2ltUW9DSDNh?=
 =?utf-8?B?SXphWTZmRzFOTXZaSURTblIvTU9JMTY3a0I4STh1OFNxeHdGTGRjcUhYdXV6?=
 =?utf-8?B?OGlDM09JbnR3MGV4UVNUdzJRU2dmODZFd25aTHYvaHJPeFFLTVF5aWNma2Q2?=
 =?utf-8?B?b1g1NE5oWjFMTkdCczR0SVVtUGRSZkJReHFXc053b0VCc0M0SEI5dkJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVENUVPQ2Z1eXkrc1FGYklnQUJjYU9wdVJpY2NSQXJVUkM0UnQxc0lTUXBn?=
 =?utf-8?B?VjB3M0pPVC9ESFhNeEh4cTc4VkVIOTVOOEE1Y05RVGVRdFZPZGY0SkIwdWdT?=
 =?utf-8?B?ZjlKVU1HRHFaM2VUQjhBSGJJYUdRMjJ3S3QxRE1SN0pUMlliNUNCQy9FdWo1?=
 =?utf-8?B?RGNKd05xMUhYZVlQMEJoWHNFWU45SWZUdElmbEJ6RWdZbGs5d1dFMmw5aEZu?=
 =?utf-8?B?TTRDbGZEbURzZXZ3M2FYWDg2R3N6T2toLzRDQjRncC96THMyUi9FNnp2bi9w?=
 =?utf-8?B?MitwVFpXbXcrT3pWcTFUYUwrWHpJaDluYiszRlplYW11WUY0U0h5SmI2Vi90?=
 =?utf-8?B?ZkRCVFRsTlAwM2tuSU9vempUdXRJR1d5aWN0WmVxQWQvQjJ2UlZ1MkZrbVdG?=
 =?utf-8?B?QVhsZVdqcEZ6YlJ1alV4dCtvS1dqRmx6SmJhREFUZ0U3Zm1LdzROUlM5bXhN?=
 =?utf-8?B?bDBrWUdzTmFscDJ0T1RTYTJCRXMvUWNLWDlTR3hYMStXeUN0RXpSTjR5cVEv?=
 =?utf-8?B?cU5IbkdYYWFmKzJCdi9QbER6VlNVS05lTlNzUDBDcWttWlkxWlRJSFphcUVQ?=
 =?utf-8?B?NVB5empmUVdwbEJidVd3Q2tkRSs0TFlORUVDVHhXTlVBZ3AyZUpUeE9UNEQ0?=
 =?utf-8?B?dkZ5L3IzZkNyTDNvTG1mRHhoenBGMDJRSHlFSEl6UExJZGxKU1phZ1dMWjJ0?=
 =?utf-8?B?bGZUMHdmbzU4Nm1BbENYYXRaamxXU2hlYUF6YVhNNTRSNElOUnNLbHdWd0N3?=
 =?utf-8?B?b1N0VE82aFJobVd0eVBsRGdKTWJYNnB6OXVkTHdmeUJ2WUw4MWtyU0pweUNm?=
 =?utf-8?B?a1QxQWdVRWdJSWowZWU2R1ByZEt0eTdqcG9jdW13dlBvRmd6MXVnN1lEa2RE?=
 =?utf-8?B?WFdQY3p0RDYralk3cy85QUVrL2tGbEpTSDBYN01WWmRWK1JwSDIxRkE5eCtu?=
 =?utf-8?B?eGg0cGNFZUV3RVhMNktHbmZpcHBUUytnMmxCdTFXNUVsQTdFckFzeDdDR1dX?=
 =?utf-8?B?NWdvTlUzTWxXTUtoV2pyZUZXQzhWM2RiREgrZkhsOTZZRUoraGZUQU1qeXR4?=
 =?utf-8?B?cW1nYU9ra0hrMkxzeEZYVEFPamVFSjJKQmRsck5zMG44M0QrZTlkRERJYnY3?=
 =?utf-8?B?V1hseXloc0dtKzAwak5pWHRGMDVUVUl3K2NaUnVLVTU4OS96NUZRZEl3ZDlD?=
 =?utf-8?B?ejMwNisyVHNVUGxweUoxUDJHNkhNVUloMVhkL25ZenRrTWNaUkpsU3ZNYlJi?=
 =?utf-8?B?U2EzZHNtTGlQVnZCRzBiYWVnRkh3OHlRa0hFTEtLY2QyZE5QRFpHWWs2VXlE?=
 =?utf-8?B?Q1FEVTZEOU5aYUNIekE3dUQxU1hUVC9qaFRiNHJpNnFJbFh0aHhjaVYzeWgx?=
 =?utf-8?B?a1g0Q0cxZTdhQUZrVnhyQzhXdytJaWJaeTNhTVBVejd2V3p5TUFVTVloQWRa?=
 =?utf-8?B?ZUdxc0IrYk9ZWWJJRzNGNEZRYXRsRXJFVjFhVmxNaUp5ck0xZWdrUTRsTi9G?=
 =?utf-8?B?Z3BleHJNQ0NXWDkvdTNFVlJvbnFYTUJlRE9jTC9FYnpCYUNLNkVYVlhIdEhB?=
 =?utf-8?B?MjJvV09GUTJxNHRDMTU2RG5Id3hyUHRaT0RtTWQ4aFYrbHFDZE8vNUlzUzc0?=
 =?utf-8?B?ejlBOExwSU1FOU1rOEFvVzBhalArc1N1ZFRMaDZnU3ZCY1pJYndVRkJwY01Z?=
 =?utf-8?B?dUVDbDVjcWRqQWp4ODJoMXJCUDBqSFZwYUJKNlZnTGhkVk8wWE43SXZUTlc5?=
 =?utf-8?B?Qmd5enkrV3BHbElneDJFNTN4VEFzWjhMZFBId3BxTUVTZkxmOEk5akRuMzZR?=
 =?utf-8?B?R1daNFNLazE3eUlhREwzNjBVNGdyN2dLNlltWDJjdFhPWHNkbE5xS2l6Q3pD?=
 =?utf-8?B?eHZ1V1RQVUVYMjlwZFpuclp5Rk8vTFNGUC9ybHArSVVTNzVhSS9qeExEck5m?=
 =?utf-8?B?aUh1cnpma3hTV3pBZUZqUUVKREljUURacHV2NEQzYzFFbVpQZFNnUVU4dVJP?=
 =?utf-8?B?TGFlSGEyYmgwNUVkZEdvbVZMSWFkSUNvbU1hNktQMGVvZlNRWEZHcmVvKzlq?=
 =?utf-8?B?TVpvWUtGNW8vc2VMN0VsUjNDSk01U3BqL1l5VHZCYXpPQmdoVGMzdVJVRk0r?=
 =?utf-8?Q?OhovGA1asGh5/OsfnMNojrnWS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f0a8c1-2f58-4c44-356f-08dc6abe78d1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 15:42:28.5585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U60KkZ4EDhqhDMJW+6lFKFW/tcPzBCoUlhKgFtaaLvuW0bXaMy3YIcHFUpYBIIibDi+iR1Tm4yAOp5b3/ipk1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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


On 02/05/2024 17:19, Christian König wrote:
> Am 26.04.24 um 15:48 schrieb Shashank Sharma:
>> Current MES GFX mask prevents FW to enable oversubscription. This patch
>> does the following:
>> - Fixes the mask values and adds a description for the same.
>> - Removes the central mask setup and makes it IP specific, as it would
>>    be different when the number of pipes and queues are different.
>>
>> V9: introduce this patch in the series
>
> As far as I can see this is a bug fix for existing code and should be 
> pushed completely independent of the other work to amd-staging-drm-next.
>
Agreed, I added it here for completion of series. I had pushed this as 
single patch as well last week, I will push it accordingly.

- Shashank

> Regards,
> Christian.
>
>>
>> Cc: Christian König <Christian.Koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 -
>>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 9 +++++++--
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 9 +++++++--
>>   4 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index a00cf4756ad0..b405fafc0b71 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -151,9 +151,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>           adev->mes.compute_hqd_mask[i] = 0xc;
>>       }
>>   -    for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
>> -        adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
>> -
>>       for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
>>           if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
>>               IP_VERSION(6, 0, 0))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 4c8fc3117ef8..598556619337 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -110,7 +110,6 @@ struct amdgpu_mes {
>>       uint32_t                        vmid_mask_gfxhub;
>>       uint32_t                        vmid_mask_mmhub;
>>       uint32_t compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>> -    uint32_t gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
>>       uint32_t sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
>>       uint32_t aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
>>       uint32_t                        sch_ctx_offs;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> index 1e5ad1e08d2a..4d1121d1a1e7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> @@ -290,8 +290,13 @@ static int mes_v10_1_set_hw_resources(struct 
>> amdgpu_mes *mes)
>>           mes_set_hw_res_pkt.compute_hqd_mask[i] =
>>               mes->compute_hqd_mask[i];
>>   -    for (i = 0; i < MAX_GFX_PIPES; i++)
>> -        mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
>> +    /*
>> +     * GFX pipe 0 queue 0 is being used by kernel
>> +     * Set GFX pipe 0 queue 1 for MES scheduling
>> +     * GFX pipe 1 can't be used for MES due to HW limitation.
>> +     */
>> +    mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
>> +    mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
>>         for (i = 0; i < MAX_SDMA_PIPES; i++)
>>           mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 63f281a9984d..feb7fa2c304c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -387,8 +387,13 @@ static int mes_v11_0_set_hw_resources(struct 
>> amdgpu_mes *mes)
>>           mes_set_hw_res_pkt.compute_hqd_mask[i] =
>>               mes->compute_hqd_mask[i];
>>   -    for (i = 0; i < MAX_GFX_PIPES; i++)
>> -        mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
>> +    /*
>> +     * GFX pipe 0 queue 0 is being used by kernel
>> +     * Set GFX pipe 0 queue 1 for MES scheduling
>> +     * GFX pipe 1 can't be used for MES due to HW limitation.
>> +     */
>> +    mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
>> +    mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
>>         for (i = 0; i < MAX_SDMA_PIPES; i++)
>>           mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
>
