Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F57EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 11:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5FD10E1EB;
	Mon, 26 Jun 2023 11:54:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2106010E1EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 11:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6nP9XvVMKjf4zfniLGBdS0yk6usGrXk+Em8Bjh+V7m3NoTPd+gKaLU57QL8dwB/MqCZRu//xwDk31QKi+7ltMSqFxyT3Uglt31/AhQ+z8oClZYWabZrvUAWoPivUjaKckK+oy4ytPGl/LCYhRo1MehhO1aTDCJe5ED/gpEFc1A91/UwfCUYoDzl10mEZ0256u+7Zr1oDlyIrrwIYcPp1ooTfZFx4dQzZCJNM3SxpqzrQICpOjBNunhxVuPXLf835dRzJ5E2RNao0glHxfq3GAfS4NwjJuYV4sGb+wyY51ttrcPb0IqsyJcdllJfBWmjssAGt8Bck77jp8/wxhkgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkhiODWviTzOYtuNJpFx069BqHl5b2GoNJsHRSi7mVA=;
 b=QEI/k7rQ/Gmx7MrWbOGl0G+GliOpyGD6Z68ctEfXjnI2Tfy23lgZN3GSJebd9MgMmOf2Z6uUqh7ErgXkmcGKw/HXWATuiCNACpNDhESoabBX9FxYzzQPxCipG2mcNgM1doFQR5HLK0XGoaBBFvVQ3WN5D3Nva1Zjrvv4zd83rNOZgMZwaztr8pwMofqKbU2BHq4clSIKkyhB3W13+3qFwXSPi33DUocb/v77D1HU/h/9UbyfOrK7CupaylpLrlFGZK/TJPFb2/1IXwzn41y3q5J0iv0H9A/hiiATwYHZXU5RA4kON6OXPlhk8raUvT/V/7ArR4629n3NwlJhCl8dvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkhiODWviTzOYtuNJpFx069BqHl5b2GoNJsHRSi7mVA=;
 b=TBnqNQGlJR/MCUS7sn8eGaHHweo1W5mQq1NXWuwj8HEuHEb2aRjJp2s3ibRUXs7VWkCqp0BC+RftlnS6LLGUl7ffcrfsnU3QLCUPiu9xqiM+J5aGhLG4lLsoe0npmxRh5E4CMQViNmfAto5nxz6JzrhRPhK1TpLXaPp9UQmnIQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 11:54:36 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 11:54:36 +0000
Message-ID: <f96f519d-cf85-d0ae-761c-060561782207@amd.com>
Date: Mon, 26 Jun 2023 17:24:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] drm/amd/pm: avoid unintentional shutdown due to
 temperature momentary fluctuation
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230626074713.27397-1-evan.quan@amd.com>
 <20230626074713.27397-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230626074713.27397-2-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::27) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eadb486-45bb-4b07-8539-08db763c1cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9HnmzmRffQvVqYUN6d1NxvHRH4fkJ/9aOjHOx4YmlNWsIexXQDfRWbDgPszK2FuL75beJcLQAaaabDUV2jFlfeWTmXJowHHH2YrDHgZpPwwCnpBUGFHXoK/lKswHb7DUpQ9UtPGCe7+Z+HFSZyzMaaArRqzXP7TEAHifxZAc4Fno0w7JtYzK9Kxd9YlVyZOXyZg/6V7+1KJnqODhpXCOeUfLZVWRZe7nisPOXpNGVZxwAiduMVXyTVOmU6zo+LpAI6GWnu4P4SqDCye87aoOSL5VpVXztm5Jxp88KVKvl+hCBowaVfSbwKcrqezXPxooGgwDPYO7CE0VsJEW7Wx3MIMOU6cRpATGBL0OxV2FmnaJgcB+6bBFAzecPEMr5SisPzV/CB7LRFn/d/MkqODa7DArCAwX6CJHrp8P77234NTh3wEH/Zmohy7/A8E9UEv2fSEfoZfa2QQl5tqbH0t6MXRBXe0owTXq43jEHWR8Gf4wL8BsuX6O5s7f9geu7tL7eBPazU27lY3VJrLPT+OTtaGEGY43cV3DpND3h1mx993t7kgG3/aWouHtdBRdtCtKNP8SnygIWQUi8Slv5JdX3GfP770y2ArGulQiwDhqp+EvvG/9ApkFjZMyGMRB3np5C6FppO2IT5JDRma10HZpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(30864003)(6486002)(6666004)(38100700002)(2616005)(83380400001)(6512007)(6506007)(26005)(53546011)(186003)(41300700001)(31696002)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(66476007)(31686004)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDhBanhMMTJDa2plZFlEMGRpaHd6MkN5QU4yZFRGbmZCWVhLTTlzN2Z6aWE5?=
 =?utf-8?B?dkNSUnFROWRHS3JZSXl6cXh0RkwrN1JramZ1KzRvdmdWWHNKSVdnL2hyd2Zo?=
 =?utf-8?B?Y2M5N0VKekhscFVXY29ZTVBNVHNSdlg3bkpaeGdOUXdwTDhEK2RlK1FZK2VW?=
 =?utf-8?B?UVZYSWtpN3dUWG82czlJS1F5cWhwL1REOGpjbENMVGFzLzkrS3NTMzBEYmlq?=
 =?utf-8?B?bFMyYkN4UVY4ZjcwRTkxWVZvMHU0cVB3YUprMHJqTGFTZjZHTHJYUU1wbHQ0?=
 =?utf-8?B?UHZxTFl4OHYzWE1OVVZZaUFZREtTTEIwLzlCNGR2QlA4cWdSS1owSmFTbzc2?=
 =?utf-8?B?K09FMlJVUHMyK3UyMzJnWU9aRHpycVVaTTFtV3JwT24wTGxqWlErN2lnZVVM?=
 =?utf-8?B?QmJjemt5YzYvNVR5WWZWd0Z1b1d0c1lzV2YwSkhORFRndUdjM2VYRyt0VURx?=
 =?utf-8?B?bFFSZVkrYTB2L3FsekY2RitQb0doaW4xZWt0M0lKZXVDZmFhdXk4RFZMTFo0?=
 =?utf-8?B?bXQ4d2NWMUdyRjdtOENhbjUxL2QyK1E4WDlybnMzbjdiMEZ6ME5Lb2ZidEEr?=
 =?utf-8?B?ZHUraTNZNWtha3RVb0FJODRGcG02OWUxdVQxQmVmOFNyOEs0TEVFM2dUb25h?=
 =?utf-8?B?OFQ1NE15ZnRmRE5HN2RJenFTM0hIeHA2dDhoSnJRVHlUL0VrVHU0OStPa21B?=
 =?utf-8?B?bkwwZVVwTVJOOEFSU0wyTzJYQzBZNXF4Z2YxL1FHbjNTNC9aUVVFOGVnNVk5?=
 =?utf-8?B?RGhtZVA0czk4MmZEY0U2MzVtZDgydWs4cFhrTFB5S29xRVhURzNkNGwzN0V0?=
 =?utf-8?B?NWsvS2VRdEhic3A5ZjI5bUd1VzR1S2hLUkovYzFKemZENlpmOUk5Q29NajNY?=
 =?utf-8?B?OFFaZW1uL21OK2lPZ0VZWGx5OVJlMWFGQVBpMFVSUmJHRGt1Q21uT3VNaWNi?=
 =?utf-8?B?a0JzWE1DZm5yUWhlandsOGxoS2FzcDk2Z2hmN1Y3Z2J1d09CTzdYYXVWZmJC?=
 =?utf-8?B?THBCaHc0akswSmwzVnB4bmFGUzNFK0xSdS9SNlpSbGlaWm9GamRwNDRyZ3Bt?=
 =?utf-8?B?NHZDZGZZZE1SamRwV0lMTmcxalQwV2dhRzB5Zm4rTjlYcGdueitYaVpkWEJp?=
 =?utf-8?B?cnlPU1VoOWMxcmc2TzdyMmFyNWVYUlZuUGtpdExhaHF0cEFSQlQwck9QSTZI?=
 =?utf-8?B?QlFpVWtHbzlMaGIxZ29saUd6Um1FUGhzbmdTWm9RNHlobHg4Skx1SncvWVpm?=
 =?utf-8?B?RlQxYW1reUFNSkRIZFFaNmdsQzhqaUxiTmk0Z0ZRV1dCMWJzOEw3UXRtMDJP?=
 =?utf-8?B?Zytlem9jZ09MMjJ6ckRJcDdnY3c2VkNnK2I5VWdScW8ybWh0VlYyckxmNVcv?=
 =?utf-8?B?TFNyakZwcE5lVFd1V3FJQTVGMEUwMjhxa1lCUEV3aldUL3ZidmU1cVE4Q2hT?=
 =?utf-8?B?bjZtL0lIM3pZb09yUksvbG81YjZMN2x2RjlSbUVRdzBWS0x0bndFU1I5RjIw?=
 =?utf-8?B?RDA4NERhYjNHLzlHWlNpK3ZsUUdJNm9sbEZXcDJkSVhoRmxzbXVURysyQTJZ?=
 =?utf-8?B?MFRITTg2YU1SOW5EL1c5OUM3N2V4T2tUWERQNDRIYS9uMHFqdmVDdGRBT0Zr?=
 =?utf-8?B?Z25peXduS2diaE9pOEdEUWJwRmY3Z3NiM09KK2ZEWmJKSzFDUU9YUGhkNDRx?=
 =?utf-8?B?cEVXcnhRaURaV0NhV3dRNFg2cVU3NUpyNXM4VGlPM1JIK2Z1b0tLWVRoaFFh?=
 =?utf-8?B?SGI0dHBjUVJuanVIay9qL1FUZEJ3bW00TXJYNlJiOEVHY2JQQW90ZWxIbkJr?=
 =?utf-8?B?cnZHZkEva3dESVZWWHVwemo2ZnpjSEZlcEtzSHpabXlFcHdZdjRkMjFCVDdN?=
 =?utf-8?B?Tzg3V1pRQUEzN0NLRjBpVUxuaE96T3FUMktPa3VWckZ5QjRNRzdSN2t1Qnhv?=
 =?utf-8?B?Y1R3djdjNFpUelcwVVozc0w3Zlk0WE9kYVVZNno2QkZEd204cENSSzhtcklJ?=
 =?utf-8?B?SUxUNEdwckx1K3F1L1F4MDgvMXkxbHI3ZGduQkQ5bWlCdzU0bUpiMkROWmNK?=
 =?utf-8?B?REcvdGJoR2huWGU2TGMzNlZ4amk1NWt3NDNRVHc1S0dhQ1ZCcUtBR1Fyc2Zz?=
 =?utf-8?Q?jA47pIA/jwT94xBx/VAgMBpef?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eadb486-45bb-4b07-8539-08db763c1cc7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 11:54:35.9350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRcC2OPAqdhwN0HLjUWeBrnDcXu/lJWtU0cFfHzD/CNM3aESRQpFj/NBPE8V63Q8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/26/2023 1:17 PM, Evan Quan wrote:
> An intentional delay is added on soft ctf triggered. Then there will
> be a double check for the GPU temperature before taking further
> action. This can avoid unintended shutdown due to temperature
> momentary fluctuation.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 ++
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 48 +++++++++++++++++++
>   .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   | 27 ++++-------
>   drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 +
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 +---
>   8 files changed, 102 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e459381dc759..5ef1f31e703c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -287,6 +287,9 @@ extern int amdgpu_user_partt_mode;
>   #define AMDGPU_SMARTSHIFT_MAX_BIAS (100)
>   #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
>   
> +/* Extra time delay(in ms) to eliminate the influence of temperature momentary fluctuation */
> +#define AMDGPU_SWCTF_EXTRA_DELAY		50

I think a delay of 10-15ms is good enough to filter out any spike.

With that change, the series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +
>   struct amdgpu_xcp_mgr;
>   struct amdgpu_device;
>   struct amdgpu_irq_src;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 11b7b4cffaae..ff360c699171 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -26,6 +26,7 @@
>   #include <linux/gfp.h>
>   #include <linux/slab.h>
>   #include <linux/firmware.h>
> +#include <linux/reboot.h>
>   #include "amd_shared.h"
>   #include "amd_powerplay.h"
>   #include "power_state.h"
> @@ -91,6 +92,45 @@ static int pp_early_init(void *handle)
>   	return 0;
>   }
>   
> +static void pp_swctf_delayed_work_handler(struct work_struct *work)
> +{
> +	struct pp_hwmgr *hwmgr =
> +		container_of(work, struct pp_hwmgr, swctf_delayed_work.work);
> +	struct amdgpu_device *adev = hwmgr->adev;
> +	struct amdgpu_dpm_thermal *range =
> +				&adev->pm.dpm.thermal;
> +	uint32_t gpu_temperature, size;
> +	int ret;
> +
> +	/*
> +	 * If the hotspot/edge temperature is confirmed as below SW CTF setting point
> +	 * after the delay enforced, nothing will be done.
> +	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
> +	 */
> +	if (range->sw_ctf_threshold &&
> +	    hwmgr->hwmgr_func->read_sensor) {
> +		ret = hwmgr->hwmgr_func->read_sensor(hwmgr,
> +						     AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
> +						     &gpu_temperature,
> +						     &size);
> +		/*
> +		 * For some legacy ASICs, hotspot temperature retrieving might be not
> +		 * supported. Check the edge temperature instead then.
> +		 */
> +		if (ret == -EOPNOTSUPP)
> +			ret = hwmgr->hwmgr_func->read_sensor(hwmgr,
> +							     AMDGPU_PP_SENSOR_EDGE_TEMP,
> +							     &gpu_temperature,
> +							     &size);
> +		if (!ret && gpu_temperature / 1000 < range->sw_ctf_threshold)
> +			return;
> +	}
> +
> +	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
> +	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
> +	orderly_poweroff(true);
> +}
> +
>   static int pp_sw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = handle;
> @@ -101,6 +141,10 @@ static int pp_sw_init(void *handle)
>   
>   	pr_debug("powerplay sw init %s\n", ret ? "failed" : "successfully");
>   
> +	if (!ret)
> +		INIT_DELAYED_WORK(&hwmgr->swctf_delayed_work,
> +				  pp_swctf_delayed_work_handler);
> +
>   	return ret;
>   }
>   
> @@ -135,6 +179,8 @@ static int pp_hw_fini(void *handle)
>   	struct amdgpu_device *adev = handle;
>   	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>   
> +	cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
> +
>   	hwmgr_hw_fini(hwmgr);
>   
>   	return 0;
> @@ -221,6 +267,8 @@ static int pp_suspend(void *handle)
>   	struct amdgpu_device *adev = handle;
>   	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>   
> +	cancel_delayed_work_sync(&hwmgr->swctf_delayed_work);
> +
>   	return hwmgr_suspend(hwmgr);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> index bfe80ac0ad8c..d0b1ab6c4523 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c
> @@ -603,21 +603,17 @@ int phm_irq_process(struct amdgpu_device *adev,
>   			   struct amdgpu_irq_src *source,
>   			   struct amdgpu_iv_entry *entry)
>   {
> +	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>   	uint32_t client_id = entry->client_id;
>   	uint32_t src_id = entry->src_id;
>   
>   	if (client_id == AMDGPU_IRQ_CLIENTID_LEGACY) {
>   		if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_LOW_TO_HIGH) {
> -			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
> -			/*
> -			 * SW CTF just occurred.
> -			 * Try to do a graceful shutdown to prevent further damage.
> -			 */
> -			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
> -			orderly_poweroff(true);
> -		} else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW)
> +			schedule_delayed_work(&hwmgr->swctf_delayed_work,
> +					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
> +		} else if (src_id == VISLANDS30_IV_SRCID_CG_TSS_THERMAL_HIGH_TO_LOW) {
>   			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
> -		else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
> +		} else if (src_id == VISLANDS30_IV_SRCID_GPIO_19) {
>   			dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
>   			/*
>   			 * HW CTF just occurred. Shutdown to prevent further damage.
> @@ -626,15 +622,10 @@ int phm_irq_process(struct amdgpu_device *adev,
>   			orderly_poweroff(true);
>   		}
>   	} else if (client_id == SOC15_IH_CLIENTID_THM) {
> -		if (src_id == 0) {
> -			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
> -			/*
> -			 * SW CTF just occurred.
> -			 * Try to do a graceful shutdown to prevent further damage.
> -			 */
> -			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
> -			orderly_poweroff(true);
> -		} else
> +		if (src_id == 0)
> +			schedule_delayed_work(&hwmgr->swctf_delayed_work,
> +					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
> +		else
>   			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected!\n");
>   	} else if (client_id == SOC15_IH_CLIENTID_ROM_SMUIO) {
>   		dev_emerg(adev->dev, "ERROR: GPU HW Critical Temperature Fault(aka CTF) detected!\n");
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> index f1580a26a850..612d66aeaab9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -811,6 +811,8 @@ struct pp_hwmgr {
>   	bool gfxoff_state_changed_by_workload;
>   	uint32_t pstate_sclk_peak;
>   	uint32_t pstate_mclk_peak;
> +
> +	struct delayed_work swctf_delayed_work;
>   };
>   
>   int hwmgr_early_init(struct pp_hwmgr *hwmgr);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 2aecb8faf407..4062b9b46986 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -24,6 +24,7 @@
>   
>   #include <linux/firmware.h>
>   #include <linux/pci.h>
> +#include <linux/reboot.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_smu.h"
> @@ -1078,6 +1079,34 @@ static void smu_interrupt_work_fn(struct work_struct *work)
>   		smu->ppt_funcs->interrupt_work(smu);
>   }
>   
> +static void smu_swctf_delayed_work_handler(struct work_struct *work)
> +{
> +	struct smu_context *smu =
> +		container_of(work, struct smu_context, swctf_delayed_work.work);
> +	struct smu_temperature_range *range =
> +				&smu->thermal_range;
> +	struct amdgpu_device *adev = smu->adev;
> +	uint32_t hotspot_tmp, size;
> +
> +	/*
> +	 * If the hotspot temperature is confirmed as below SW CTF setting point
> +	 * after the delay enforced, nothing will be done.
> +	 * Otherwise, a graceful shutdown will be performed to prevent further damage.
> +	 */
> +	if (range->software_shutdown_temp &&
> +	    smu->ppt_funcs->read_sensor &&
> +	    !smu->ppt_funcs->read_sensor(smu,
> +					 AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
> +					 &hotspot_tmp,
> +					 &size) &&
> +	    hotspot_tmp / 1000 < range->software_shutdown_temp)
> +		return;
> +
> +	dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
> +	dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
> +	orderly_poweroff(true);
> +}
> +
>   static int smu_sw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1120,6 +1149,9 @@ static int smu_sw_init(void *handle)
>   	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
>   	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
>   
> +	INIT_DELAYED_WORK(&smu->swctf_delayed_work,
> +			  smu_swctf_delayed_work_handler);
> +
>   	ret = smu_smc_table_sw_init(smu);
>   	if (ret) {
>   		dev_err(adev->dev, "Failed to sw init smc table!\n");
> @@ -1600,6 +1632,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>   		return ret;
>   	}
>   
> +	cancel_delayed_work_sync(&smu->swctf_delayed_work);
> +
>   	ret = smu_disable_dpms(smu);
>   	if (ret) {
>   		dev_err(adev->dev, "Fail to disable dpm features!\n");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 4ce394903c07..18101ec0ae6e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -573,6 +573,8 @@ struct smu_context
>   	u32 debug_param_reg;
>   	u32 debug_msg_reg;
>   	u32 debug_resp_reg;
> +
> +	struct delayed_work		swctf_delayed_work;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index e1ef88ee1ed3..aa4a5498a12f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1412,13 +1412,8 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>   	if (client_id == SOC15_IH_CLIENTID_THM) {
>   		switch (src_id) {
>   		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
> -			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
> -			/*
> -			 * SW CTF just occurred.
> -			 * Try to do a graceful shutdown to prevent further damage.
> -			 */
> -			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
> -			orderly_poweroff(true);
> +			schedule_delayed_work(&smu->swctf_delayed_work,
> +					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
>   		break;
>   		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
>   			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 9e8414037638..4071bfa38727 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1353,13 +1353,8 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>   	if (client_id == SOC15_IH_CLIENTID_THM) {
>   		switch (src_id) {
>   		case THM_11_0__SRCID__THM_DIG_THERM_L2H:
> -			dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) detected!\n");
> -			/*
> -			 * SW CTF just occurred.
> -			 * Try to do a graceful shutdown to prevent further damage.
> -			 */
> -			dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU SW CTF!\n");
> -			orderly_poweroff(true);
> +			schedule_delayed_work(&smu->swctf_delayed_work,
> +					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
>   			break;
>   		case THM_11_0__SRCID__THM_DIG_THERM_H2L:
>   			dev_emerg(adev->dev, "ERROR: GPU under temperature range detected\n");
