Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DD8C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 16:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8304C1134A3;
	Tue, 23 Apr 2024 16:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5Zu+UF8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B941134A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 16:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kd3N5KfrP8rByhJfQA174y3yf0t3QQhzmocabOB0KvGJlmLdbJkwDOP5F3G5x0R/ucEZKcWXAvWE0mDMTZFdkii0vFzUS3wBmWMvC1QDLzYT+/nNWVR3zsEmMUx0QbA6BKiMmyCBaPKrYEaYW64k+wA/ZNQT6uvKYP6OZcUOa6navWvJmNKvPY2FlHDHHSuTgzQlWUH87J/jkddyi3SMH0C5A2f2j50zYnpagdiLZaKOV2vk4dXEEyyTyz0Yavoj954VZgE60aBxm4mupoZgb9UYTIS0vPPEQvKW8ScHAWhKHogDTfvkAVANghFxSmhSmu+V2pqlLMEC02deqJQM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwg+Pqsio8cUOSS28PmUs+lbSSJoryfTTXRZNtNwVz4=;
 b=oN/fe8g+nWMZ2slJg3UiDs3xcV+IJbw8ul3iYYWbOJZbs6G+ccv98kwuLdAY9POcn/bAuGV9Jnd5TjaYNbyvVT9er/oAm1KcL+2b37BwjmrLVCr7QGo0A3XpdNFIn3fYAuReyzc3oh7FVLK/4TeImecR3X36aT/YTfZIAvYpUIfkJrYXQEmwlmPvYlN0KsP98XfOEKQfZCNr1i0/5FRfpRM5kfz4sxFak3tTLSyd4NmmJN9MQN0uttIxctqxxdZV6W3vPgzYMVSHWifUKXz9WEAhrnEtiJyGMyApLM4fVgEPdCTRatRom6SgKJBk8uIIVW7UtJiwNp515mAqONNcbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwg+Pqsio8cUOSS28PmUs+lbSSJoryfTTXRZNtNwVz4=;
 b=X5Zu+UF8NwAjqV8jCQ458/qF+v+mQY69/pBiKvZSvrtf67yzlYFzVfSGpZoYwSl7+QRkD6BhtVT2nBARPqJ1OggJde4qZOdnPP3vRLNXVA/mn0oj3reUBykGowhy7SHUrtIaz38p++h4PsPi5R3nSYiFHHj+2vRp4YRJtwRSxh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 16:35:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 16:35:46 +0000
Message-ID: <76b2cd35-8804-49f2-ab40-0dce898f57d0@amd.com>
Date: Tue, 23 Apr 2024 18:35:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix two reset triggered in a row
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <20240423144456.45941-1-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240423144456.45941-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b17b595-4f26-4e94-3b67-08dc63b36d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW01YmovejcxK3NCUTlHdUJ4SWVOeU5VejJ4YTUxaUlnNkczNXhwL3hZYXdB?=
 =?utf-8?B?bTdFNUx0bWlDazU4STdZQ21SOWN2a2dGS3VTMVdXSEtsTWF1VnNkOEpCdXBy?=
 =?utf-8?B?THRHSFZ6UHk2UjFrM1FIVG9IaGp5VkFWYUxyamJBbkpReXhGSU05RXJuNTVy?=
 =?utf-8?B?RU5MWVRzenc5Y3JLbisrTWcwdGk0VUNOMW5jeUZyWmJQUEhoeEVxQzlkRldK?=
 =?utf-8?B?b0FEcDJFditIT0RBSCtSeHAzaS9wSlMzOWZYeGZDaFhtSGY4Nysrbi9TL3dE?=
 =?utf-8?B?VWxwOS9KMzFRQnE0MVlIeFZ0WEhlMVVHUFQvay8xT05ubTFXcHR5L3pRSEUw?=
 =?utf-8?B?eUxyZmVCZjdpRGkwam13WkNQeE1sb3YvcGxmNjdZdEt5THp5dXA0bjZ2RE5n?=
 =?utf-8?B?SHdEeGgrOWtTdEw5N0krSVc4L2pZQ3c2NGNEQ1pNREtEMFcwUDltNGtwWUVz?=
 =?utf-8?B?Z01Fdm51bW9sQWRHK3RHOThhb0JFYWpoamlJeU9sbDk4ZFpFUTFaL3NIeWtU?=
 =?utf-8?B?bWhkY2kxRko1ODVUaGFQMDJCaWs1OWdpWjVwc2Zhbzc0dnV4Vm50dDNCL0N6?=
 =?utf-8?B?YVJZTS8vUTh5aU8vYU03cmZOYmZvSEtjb0k0aTdnRGRlTXpJN1VBbHRRcGto?=
 =?utf-8?B?anUxVkNvK3NQRDlDbHkxNkVjMmFSL0RiVmhBaTdIeXdqc3JIWEtTWWo3K1Qr?=
 =?utf-8?B?TWZzOGtoMENZR0krOFdUd0gxbVo2TFRoa0Z6b3hmN3VORnM1eG8rS0NhSU53?=
 =?utf-8?B?MkdMWTJ2VWo0MXhFK3JlM0hIejlNYUtvVEs4UGtvQnZlOUk4VEVnS1NtMTJV?=
 =?utf-8?B?eDlmOWw3dnVLSjJtSnZxcm9jSEx6NUpCS0FGaVRBS2cva0dhN3N4Tm1idlpS?=
 =?utf-8?B?V1dLL2Y0YnM2bFIzKzdRRzl2RHVUa0IvUEZ0RVlvZVdsenZzVVo3ay9vNUh0?=
 =?utf-8?B?UnpEdHByQWl1cnZMWFQ4N1RWL0dnbk1XcjhHa1p1bzU1aTJpUHFXOUhodjha?=
 =?utf-8?B?dTlMTVBROE0xRk94b3hxQ1hnR0I4WHhRQ3N2Y2J4NnhtTk9OQkNBaG96UHNP?=
 =?utf-8?B?Ukpaa2RIYzhJOE9aT3NqbEdPb1hSY0VjQkx5cy8yYmY2eFBhM1U3cHJ0UzFn?=
 =?utf-8?B?NzVSWmZXdnp5ZWNEU2I2cTlTL0tVc1lueGZPSTBBcGtsSlBYbjRMV2pweVJv?=
 =?utf-8?B?V2cyVWR3SW11WjRnMW5kck5IZzl3V29tVnR4K29ldHZVV0FaK3pTQXRHeU9k?=
 =?utf-8?B?UUVIUXdoRG41b2FWRTNmYXJMMkxYN2I2NDNLcFFaTnFoSmN4blBGU3pEN1FF?=
 =?utf-8?B?SzhjRTk3VTl0YmlJbW5iQXJEL3ZET0tERnc3eHF4enJJcUlyOTI4bkpycTRH?=
 =?utf-8?B?SUxJdUN6MWFMVzdUbnFZZzZmTGx1Wm0vZ0NWN0lJbVFwd3NSOXlUWXNoUkw0?=
 =?utf-8?B?U3I2emtwY0NlUTl5WWp4MmVBdDEyM1dUWG01blBWU255cVY3RUx5cUg4bFBT?=
 =?utf-8?B?cktSaFhZN0VXNDNtYmpCcHp3VkhGMjNJcUVHeGFoRHB2V1hYUnNKNGtxemRD?=
 =?utf-8?B?anBSeURrdVNSaTNkeWtyUHo2VUs2SGdJS3IzdnZLTjI2SG0vWEt4d2ppbExI?=
 =?utf-8?B?ekxBS3gyZlFOLzRVTytLcWRQbndRVi9ubkxNcTZncWJCTFNXRVZybS9KZGFJ?=
 =?utf-8?B?L0FlaTVLZjdDaTBqV1BoM0xibEYzTW5ma25MWTRIRUl2R09MdWlVMXBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkFQZkg1Wm9qa292MzZxN2FCRHJXajRyWmFqYXduN2dmNVVjUElqcXlpcVFa?=
 =?utf-8?B?VmFMQTJqUmZ4OE9oN1ZlNTlRRFQvTjdyV1dZai93UGlsWFFDL210bWxKa1BR?=
 =?utf-8?B?Zk9ZNHJ0RkIxdmY5Q3diL3pyMno1WlRTYVJnTEwyNXdmRS9TcmM2UC9rTFFP?=
 =?utf-8?B?T3VkWS9CL2xnYm5LTE9aSkJ1bjdtaUhzM1hjekFXbjU2Q3B4YTRoWHpQU3pt?=
 =?utf-8?B?UEFIaGxXMVJEV2tpOXgySlZjanMwbkxRT1dWOTczWUZsVTVoVy9PZWMwUEc4?=
 =?utf-8?B?ZTdkdTJ2WnZ4bU1wOHZUWjZXbHhsTDYrWTJERVNVU2NqdG51VVVqZzJTbUFC?=
 =?utf-8?B?S3pvZmtnVUY3aGxIL3VJMnZESGYwaXhHL2pOVmk5dGZJR3pFZ0pReFFGejBr?=
 =?utf-8?B?ZzlHbXd4c2haOHJQTlZHNWpoRnZJWUU0bHB2d3JRaXdwNVRxWUl2ejNLZWFE?=
 =?utf-8?B?TFNpbUI1Z2xVaVZLcXRtYUpaK2M3OGl0ZlpTMGlZV2JJMDY3OERrTUh6Y0VT?=
 =?utf-8?B?RWxibEVOdnZma255Wk16ejh3NlZsNHdNZlRJRkUxdGNRRUs2QXo3aDZjaC9G?=
 =?utf-8?B?K1ovSlF4ZmV0ditvdlJvKzZLUlBRSnpjY3lSakU3MTJ4TWZSbmFiemVKY1ha?=
 =?utf-8?B?ZEdlZWhsOTE3bVA4cnVFOTkwazlUZkVKLy9kQWVYRlBPUjQxc1ZwQ1ZKRUJW?=
 =?utf-8?B?bk5iZHgyQ2NhUXNTRlVxTHFuTmZtckduclVxQUhmSSt6SnFwck5OWkg0cVdi?=
 =?utf-8?B?QTg4M21CTHdBWFdVcVFBdDVyLzlwbVhWZXp3dGhuMDZtVW4veVYwK0gvUGtJ?=
 =?utf-8?B?VHBVRGNmckZ2OHk4b2U1enhqUC82S2xpSjhJQkJIdm5IcElhRkpDaDVYYktJ?=
 =?utf-8?B?SDNMT2hCd2VZYUl5Q1dSNmhGQWxzeWo1S3hmdU5oMGFZOVhnUWNyanRTRG9J?=
 =?utf-8?B?ZW0zK1l0SGtsVlNtSFlRdFhVbkJ1SHFQbG5HUkxmZVRsME9zNHIyVE5TRG8r?=
 =?utf-8?B?Z3hwWTFkR1F6ZWNIb3ZHSjJFVDU3cm9DS1dCd2hDSmhXVXRnS053NTlERlJl?=
 =?utf-8?B?aGlBODZmQjNuSzgrNW9HbnBwcXNGUUhHSWY1dmxzTDF6RjJqTmxTckpvbC8w?=
 =?utf-8?B?VHN1NVR1SURaYzRMb0FKZlJRTWUrV2lscXNzYkZuV2ZSbU9mNkR3TWI5Z3cr?=
 =?utf-8?B?ZEQ4VnAvTnB4aXZZQTk1UzUvVTBaM2VqZXNtcnpiS1J4VGluSnFlS3NYWkFQ?=
 =?utf-8?B?UGQrdUdqY1RkNmM4SnA2c2ppQjhvNk1PSDRtV21CNWhHNnFXcHVGZlhOVitT?=
 =?utf-8?B?emErbk9OaHNCSHFYNlE5clJLNktpU0JHY0huaWFOTlBWN1lhVDFxMzVITHBX?=
 =?utf-8?B?NGRIbVFIamI5UHhYMFh1WFJSeDMzNjE5Q1paSlVIS2Z0VzZKU1IzUldBQTl4?=
 =?utf-8?B?SjNSbnJIRlF5MkxOK0xFazZIV2tQZHhRNTdxZVMxSFdUbUVJdHZJMjFLU3BF?=
 =?utf-8?B?aEZqNjZIcDVyTjB3cmNaTXF4OXhvMnpoa2FMQXR5dU1tb01FZHhKempnL2Mr?=
 =?utf-8?B?eDBxb2JHaVN1WENQSUZkR1VtL1pNb0EyS1cxbUN1UnZldlNkdFF1ZUpRc0tr?=
 =?utf-8?B?ejdLQVZoQ1ZBSFIwU1pVQ0NmckVhZFNNZVE1S2J5MFBpZlBWeG1QalNDK21Y?=
 =?utf-8?B?NXptbnkwcDQ3SlNFQWxsbkd4MHAvK2VZcVBkMkJNaU40ZXMrNjF2bnkyZXUx?=
 =?utf-8?B?TXMwQmJ4N1FmVGVxU1ZDU2Zobko4YmNwN2RaYXZNWmxHVnQ4clZ4SklFOHll?=
 =?utf-8?B?VXdKd2RCcFBwL1Z6dXhKK0F4QWlKNGdaQ0drU3Z5dGhTa2pGUTIybVJGaWxz?=
 =?utf-8?B?djZ1R3B4TUt5OXFuRUo3cXVhdUVIU3JRa0crR1lKVCswVHBSQkZjcGhTVlVB?=
 =?utf-8?B?SUhnZnlhSko5dXV6OTJUSUZEcCtHSnRDR3Q2M3hDc1FIVk55Qmt2cHVZcFZM?=
 =?utf-8?B?Tyt1YmNmMzVpbml0b3VjZ2V3VnZvNVpPWS9zZTd3VXJoUWdEeEl2M2NNSU9i?=
 =?utf-8?B?WTVvanR5ckpKb1RTSjZPQjZUYlp0cDVNMkJBNkZhU3lGbDBqYlJsTStOeStj?=
 =?utf-8?Q?IttrjiT3v1TqId4OhRbjix1Oo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b17b595-4f26-4e94-3b67-08dc63b36d49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 16:35:46.4696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af9Ko9FLdlJ1VAbXo3OxRxuJ9VW2hAPtAWc1xB1xW9kvGgyJTuG0LTqLpy340Wdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
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

Am 23.04.24 um 16:44 schrieb Yunxiang Li:
> Some times a hang GPU causes multiple reset source to schedule resets,
> if the second source schedule after we call
> amdgpu_device_stop_pending_resets they will be able to trigger an
> unnecessary reset.
>
> Move amdgpu_device_stop_pending_resets to after the reset is already
> done, since any reset scheduled after that point would be legitimate.
> Remove unnecessary and incorrect checks for amdgpu_in_reset that was
> kinda serving this purpose.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Looks really good to me of hand, especially that so many cases of using 
amdgpu_in_reset() are removed.

But I'm just not deeply into each component to fully judge everything here.

So only Acked-by: Christian König <christian.koenig@amd.com> for now, if 
you need a more in deep review please ping me.

Regards,
Christian.

> ---
> v2: instead of adding amdgpu_in_reset check, move when we cancel pending
> resets
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  2 +-
>   5 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f8a34db5d9e3..28f6a1c38b17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5061,8 +5061,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   retry:
>   	amdgpu_amdkfd_pre_reset(adev);
>   
> -	amdgpu_device_stop_pending_resets(adev);
> -
>   	if (from_hypervisor)
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   	else
> @@ -5813,13 +5811,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   				  r, adev_to_drm(tmp_adev)->unique);
>   			tmp_adev->asic_reset_res = r;
>   		}
> -
> -		if (!amdgpu_sriov_vf(tmp_adev))
> -			/*
> -			* Drop all pending non scheduler resets. Scheduler resets
> -			* were already dropped during drm_sched_stop
> -			*/
> -			amdgpu_device_stop_pending_resets(tmp_adev);
>   	}
>   
>   	/* Actual ASIC resets if needed.*/
> @@ -5841,6 +5832,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			goto retry;
>   	}
>   
> +	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> +		/*
> +		 * Drop all pending non scheduler resets. Scheduler resets
> +		 * were already dropped during drm_sched_stop
> +		 */
> +		amdgpu_device_stop_pending_resets(tmp_adev);
> +	}
> +
>   skip_hw_reset:
>   
>   	/* Post ASIC reset for all devs .*/
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 54ab51a4ada7..c2385178d6b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -597,7 +597,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
>   	if (ret) {
>   		adev->virt.vf2pf_update_retry_cnt++;
>   		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
> -		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
> +		    amdgpu_sriov_runtime(adev)) {
>   			amdgpu_ras_set_fed(adev, true);
>   			if (amdgpu_reset_domain_schedule(adev->reset_domain,
>   							  &adev->virt.flr_work))
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 0c7275bca8f7..c5ba9c4757a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -319,7 +319,7 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
>   
>   	switch (event) {
>   		case IDH_FLR_NOTIFICATION:
> -		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
> +		if (amdgpu_sriov_runtime(adev))
>   			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
>   								&adev->virt.flr_work),
>   				  "Failed to queue work! at %s",
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index aba00d961627..fa9d1b02f391 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -358,7 +358,7 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
>   
>   	switch (event) {
>   	case IDH_FLR_NOTIFICATION:
> -		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
> +		if (amdgpu_sriov_runtime(adev))
>   			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
>   				   &adev->virt.flr_work),
>   				  "Failed to queue work! at %s",
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 59f53c743362..14a065516ae4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -560,7 +560,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
>   		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
>   
>   		/* only handle FLR_NOTIFY now */
> -		if (!r && !amdgpu_in_reset(adev))
> +		if (!r)
>   			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
>   								&adev->virt.flr_work),
>   				  "Failed to queue work! at %s",

