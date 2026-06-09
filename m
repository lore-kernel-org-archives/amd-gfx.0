Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D444CD8CB2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 18:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC05B10E5A5;
	Tue,  9 Jun 2026 18:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ANX7O/M4";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915AB10E5A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 18:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxMNWhEI9n0zzpUFr8ntFHumDEEChQJkqsYrBDI2JkMQ+CmlB25vmi37YzqWKcr4pnUIs0uAWKpD6it0OzsPD9iXo93bNRfVgJ71+cuGmHKlgH4Kd0URDY4CETmytCAgZ9WGttyFIe25o2L1EcvoJuYgvDX3qpYCFRJKa8M6rzEB9xtdbzvOUSQVhZjj8kcGBgYCtw8dmR/CkoouA8mXE+zhJsWDCmW6alCMIT4lPh91HCpVjn7RQxEd481IkFpWSw1sMzHA881pAaYqJTpLQJrnaD91J7AUQkhdadZT4opNL7Gv7+TcSBtJTdTMuZlT0eZ1W8t0jYntxsrQh0JT9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtCWgr2bFq4AndXYA1wq83aenxTTYt0moOC4PMt4bU0=;
 b=H4hm7zUIgFL3H7a2Ewm7UANxCqryA9HVsDcHSB1CaQ4GC+uWOqaSVHM6q/UK07wPfHj5ACCw6Gn/65Da9arf/djGB0DnivT1ZkmY9thfIkwjurvoMKdNPhs3LkVBhW7MdkRhkICRW/z22efoV7uyNiZaaujoQLYAu8vZ90JzZBuDpRbxyZ9/3JgX1DWngvInhGmCHgiF4LWH1rb6XzHYRanu7Ib+Sowcw0BNtN5Kgc4XcEH1ffrab7Zr9cbk5dkIwRsbwxyopIyBMpyGQITiXWDAxRcGUw+sWS6ov/uaDGV1VupnnQ/EuqKKyEsR0ZbhsflNJwx5AFy+OJRgr8hSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtCWgr2bFq4AndXYA1wq83aenxTTYt0moOC4PMt4bU0=;
 b=ANX7O/M4g4cRPnBV3XheO1ho9HzgLsITsXVpDHUhk/7S77lFFKNl7yNA6DIL2vsOf8klhwf++ddaY0hbpC7JLOLyI5R1/wf6yYr/UnaQQLdGOLPufAqs2JQWpM0WpFRRzzFzup7q3NyxrUoVaKYA3EiUZypnaB97ox2t/RILz3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 18:14:51 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 18:14:50 +0000
Message-ID: <0228d789-95e3-4a60-85fb-4f7eefb2be24@amd.com>
Date: Tue, 9 Jun 2026 14:14:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: add sdma queue counter for gfxv9.4.3
To: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260604174526.131849-1-jinhuieric.huang@amd.com>
 <b0ec2b8a-478d-4f15-afed-39a288a40cea@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <b0ec2b8a-478d-4f15-afed-39a288a40cea@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::19) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 939ff3c7-fcfb-4469-a237-08dec652ff4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|18002099003|22082099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 7cG9AYDhltvKKOZ7wg4bcQuPjsTu/63u3QlYVjAMSAyHnwP2AxxwOIVvxt2CxgvF+MZwk6SrAmAd/16aXNYfv3Bm8ELrqg8BmxeyCmVNqtvqL9jYm0JRB67DdeIEKLELXPkwsf5W6wF5sFuJkVe0YFBVDPfv9uAh3rcX3BTOErTDLK5Y24xojN1dWYUCMqNthN8I3k2sqktG7foRsyRawr3LqeHVdbGv0TyzHq8MCTPlIPEdaGeZ2rvNY9wLSl7aSfArKN/u71qLGxZl/kzDC66naaKmntzVR+Aa0VxTJdKD+rHxd6sZsR4wGVQFkPilvMVKDZ9HTr8jC061Ax7pISfxhgm3IlhTbEs6J8U/1Wwl93OnsKDBE9cm4Kkn9ocVvFv2VKnPnfl1YXicTWh/GGoy8RFj9B0qqRT5NRhlAoy44MfRroTQOIxwYvHPxZKuS4nngWW4TJv7A5ehd9LD6F13pdiys+lpY7606HOHzVn4e7d0/LGqkz3DNO6J2s9kdFPdfIc1KTJXS+3FcIww89s7uXWTPo00j72MqNW4oCmeckYqbRaiDuNzqyBIcDrcV2fanyjmaUbD4dhBADwRYfbrFq07xOLwpmbdTgI7Rsv+nL4F2mdQxTftpNCMe02CJ8fZx5lNa9ZIWlin1mRAweWnBOsN2sZq37eAdtAbk51PFrtuBBWZKx7cmv1J4aUn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(18002099003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBSTmJFYnIvWGsyb0xDeThWaXQ4V2daZTg1L3ZhQS9aS0hpYmxsRzFhOU9H?=
 =?utf-8?B?a0xJdERZNGErelBWbmh1SFE5NG9BejRsVVZhNjQ1TUJtS25YVjdHdGVyYVFi?=
 =?utf-8?B?UjBVQnpwMWVMN1dGNStDWWVxK3BmSnc4NzNaN1JBR1hOZ0Y3SUhKeTVac0lr?=
 =?utf-8?B?QlVJT1huRWJVSXdYVEl0L0FzZXFZbkdMRTJxSDJFSThGNmVqYkVXR3hMcEtO?=
 =?utf-8?B?WFdDMVlnR29lcTlYMnJOZndwZnBERll4NDRPM2FKZnFlWmFkcXFZN0paWGNv?=
 =?utf-8?B?c0tRb09iUlROTjI4MnBqVmFndlptMTZUOUtmYndWWWxzeFFiSDBoV0J3OWd5?=
 =?utf-8?B?alVRSldCcGJqL3h4dTdqVFFiYUUrTlFHR3lqaGlPTHdXT29lL0hnNFUySWlH?=
 =?utf-8?B?K3JITXhGSXdBKzBSdjhhVTM0Ky9vdlVzbjZiV1hWYjlPWW96VnZ1ckVLU2pO?=
 =?utf-8?B?T0kwaFg5UWJ4eHlJZys3bnlLT0ZPUWhJU2dWdjRWeG9KejArSW81V2hsUC8v?=
 =?utf-8?B?VU1IYVlNVktjWWdpK0l0enYvaXBWVjhxdXFEdExpbmxsK0huWmNISTNvdWs3?=
 =?utf-8?B?VElobHhxVXFMMDhTUGxNMHdIYlYwaWlKUWEyK05vM0lDN21QVzIrZTZCQUFG?=
 =?utf-8?B?QnRJaHg5MVNWNCtGUDY0V3lqOUVxZitrZG9jdHJtZ2pjWjNXanpxaVVvMHdR?=
 =?utf-8?B?bW9MSVRXdEVBeFA3MEJ0TnVkKzB2K3BkeEpPajNwckhYVFZzRFdaM05QS20x?=
 =?utf-8?B?R0ZDOTNMV01qOFhEN0pteXdpeS9lZUV1TDF5bGxmR0ZITWpDZ25Icmp2TTRL?=
 =?utf-8?B?NjVCbFlsVHVwa1hRMklPUEdhTzBycDZOWTMwUmxxbW9qTVVvMkdlSXFKZk5C?=
 =?utf-8?B?WDVOc1RheFpMZXdFT1BYdnN1bjU4NitPNWdURmR3YnBZN2UrNjZsNlUvQmx2?=
 =?utf-8?B?S0NWSndCU1N4S3M4Rm1uTlkrakNXaUdqVUczRlVLSVFiSkpJdXJLQ0hBM2xH?=
 =?utf-8?B?VmdNaGU3WmdvalM0QXlrQm16emtjY0U3OEZHdXVsNHRVcDc1aUtkVUtHRTFy?=
 =?utf-8?B?SGQ2cXNkVWcyVzVTTzlZVzF2NUhha1ZmVmVsTjFKSTkzWTJlRHhpeVhiZHUy?=
 =?utf-8?B?cDdXblRhZDk4eWlWN1ovVFVPUU8rSlpxK2hDMktMbDhtRFlwM29QdDZEUmg5?=
 =?utf-8?B?MHZ5R2czV1BxVmlEVUZ0cGRONmpKODl0THhDTFJsdzREN21GRHpyOThJWWtq?=
 =?utf-8?B?eUlTcWVsRXcrSG1hQTBpclJrS010cGZ4YWR1TjZtTGpTWm5EV1NsRm1yNFZS?=
 =?utf-8?B?eWlkNXpOYmVaYkRtbGd3ZFNVYzZIRnBCVUR1TUpkeFJZS0htUmNiWEQwYUFw?=
 =?utf-8?B?R1dDbGdIRlgyKy93VktaS3pEZTNLRjJpTjFQUzNlUktJeUkrVFZnYnBQN0JU?=
 =?utf-8?B?Rjh4RG14a2JBRUQ0bFRQalpHdDNxbXNOZnZKS1JaYlY5Rkx0RGxoQ2lsR0xs?=
 =?utf-8?B?b2hQU3Zuc3dGZVdmRmkyUml6K3V0MUF5RStXZEJVNWsxM2wrK3NTcGxHUVh5?=
 =?utf-8?B?RlpJNUZ6ZEMycG1nb2RGNkJzVnRoN2JqVGFoWWRTYlNKQktBOUpjbTZ4em9F?=
 =?utf-8?B?NW02RGZVSm1kbHh3Rlo1T3I0MjdISFhtcUFJSGwzSC9tYVBnTVBDT3pwY1Mz?=
 =?utf-8?B?S3I3clVHdm5DYTFPYVRUK1p5YzVWMlRLUHEvNE1ud3U1NmZ2R3dBUmI0TzRk?=
 =?utf-8?B?NndVOWpvemh1QUFuOGw0UlJNc3YvcHdHZ2RacUsrV3FrbnYyYlByZ3JEMVQw?=
 =?utf-8?B?YnFhVnNYWVQyU1M2VlJLZjRWSHJ0TWVrb0pnZEpHNXJCT0d1QU1mZFo4Y3Uv?=
 =?utf-8?B?R01Wc0VKSmVYd2ttUmtLczlZeGlxSkg2TDRiYTdxQWhwMTh1aVR0NzE5Sng4?=
 =?utf-8?B?RUppbm0vRTM5cXh5OVFFbGh1d0ZWWjlQSlU0VFM4MzFkVlVlQVFmK0pQYnJ5?=
 =?utf-8?B?dnlnUlNCZmpUUjB0K2VyRm5XbkFIT1VWSTVlN1pUQ2lPZGUrVDRzVW1yYkN1?=
 =?utf-8?B?K1BtV0lTVDBiblFFVzNOVmxyYmhqRHRhYlN6NnFJTERDSDJ3VlhTeGx0N3cz?=
 =?utf-8?B?dnlIdnJ6MEFZdG1ZTjhaeFNHYlpBdnNUb3l5ZDVYRWNzUkx6Yy9XYjZlNjhx?=
 =?utf-8?B?Z21YTjRTdDhEbHdtR3hCV2s3dlR5Ny81YzlqemZUbUV0enQwRWgvQU9Gajl1?=
 =?utf-8?B?REdhLzB2NHpVemtGSisyUWQ3U0FkN29mWStJNVZMOTNzNkF5S0ZBalZLVWcz?=
 =?utf-8?Q?1xHC5xJYR1M0EZgZVF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939ff3c7-fcfb-4469-a237-08dec652ff4f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:14:50.8658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zK8Uz2Z0Sg4CjWgv3Rw1sQiYUyo82uGVwo/2fz5j2FbhN+ohJQKZ+Xa8SXhrN7UhSsZf2ji+ZMa0If1xxwOOTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
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


On 2026-06-09 12:43, Harish Kasiviswanathan wrote:
> There should be a CP FW version check that supports these registers.
The only difference for CPFW supporting save/restore the registers is no 
accumulated value per-queue after unmap/remap queue, the utilization 
register  always updates current value+activity counter by HW, so it is 
not fully necessary in my point of view. If the check is needed, it 
won't return anything wrong, and just leaves a warning like "No 
accumulated counter supported!", what do you think?
> Some comments inline.
>
>
> On 2026-06-04 13:45, Eric Huang wrote:
>> since gfx 9.4.3 HW is calculating accumulated activity counter
>> per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
>> sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
>> will still keep the way to read from memory at rptr+8.
>>
>> v2: read dynamic counter directly from utilization register
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>> ---
>>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 51 ++++++++++++++++++-
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 23 +++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 13 ++++-
>>   .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++
>>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 +
>>   drivers/gpu/drm/amd/include/v9_structs.h      |  4 +-
>>   6 files changed, 89 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
>> index f46c59118304..16bad244c091 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
>> @@ -35,6 +35,8 @@
>>   #include "sdma/sdma_4_4_2_sh_mask.h"
>>   #include <uapi/linux/kfd_ioctl.h>
>>   
>> +#define SDMA_QUEUES_NUM_PER_ENG	8
>> +
>>   static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
>>   {
>>   	return (struct v9_sdma_mqd *)mqd;
>> @@ -584,6 +586,52 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
>>   			ptl_state, fmt1, fmt2);
>>   }
>>   
>> +static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,
>> +					void *mqd, uint64_t *val)
>> +{
>> +	struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
>> +	uint32_t sdma_rlc_reg_offset;
>> +	uint32_t sdma_rlc_rb_cntl;
>> +	uint32_t engine_id, queue_id;
>> +	uint32_t engines = adev->sdma.num_instances;
>> +	uint32_t sdma_rlcx_rb_base, sdma_rlcx_rb_base_hi;
>> +	bool found = false;
>> +
>> +	if (!m)
>> +		return -EINVAL;
>> +
>> +	for (engine_id = 0; engine_id < engines && !found; engine_id++) {
>> +		for (queue_id = 0; queue_id < SDMA_QUEUES_NUM_PER_ENG; queue_id++) {
>> +			sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
>> +						engine_id, queue_id);
> [HK]: sdma_rlc_reg_offset read could be move inside the if condition. Saves unncessary register read here.
It won't work, sdma_rlc_reg_offset is needed in the next line for 
reading sdm_rlcx_rb_base from register.
>
>> +			sdma_rlcx_rb_base = RREG32(sdma_rlc_reg_offset +
>> +						regSDMA_RLC0_RB_BASE);
>> +			sdma_rlcx_rb_base_hi = RREG32(sdma_rlc_reg_offset +
>> +						regSDMA_RLC0_RB_BASE_HI);
>> +
>> +			if (m->sdmax_rlcx_rb_base == sdma_rlcx_rb_base &&
>> +			    m->sdmax_rlcx_rb_base_hi == sdma_rlcx_rb_base_hi) {
>> +				found = true;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
> [HK]: Needs a if(!found) error handling.
Because SDMA doesn't support oversubscription, there must be a HQD 
associated with a MQD, found must be true here. I probably need to add 
the comment in finding loop for that.
>
>
>> +	sdma_rlc_rb_cntl = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL);
>> +
>> +	/* Read sdma activity counter from utilization register
>> +	 * if hw queue is enabled, otherwise read from MQD.
>> +	 */
>> +	if (sdma_rlc_rb_cntl & SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK)
>> +		*val = (uint64_t)RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_HI) << 32 |
>> +			RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_LO);
>> +	else
>> +		*val = (uint64_t)m->sdmax_rlcx_utilization_hi << 32 |
>> +			m->sdmax_rlcx_utilization_lo;
>> +
>> +	return 0;
>> +}
>> +
>>   const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>>   	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
>> @@ -623,5 +671,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>>   	.trigger_pc_sample_trap = kgd_v9_4_3_trigger_pc_sample_trap,
>>   	.override_core_cg = kgd_gfx_v9_4_3_override_core_cg,
>>   	.setup_stoch_sampling = kgd_v9_4_3_setup_stoch_sampling,
>> -	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl
>> +	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl,
>> +	.hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index b934863312d0..a65161659f74 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -1067,8 +1067,15 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>>   	/* Get the SDMA queue stats */
>>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
>> -							&sdma_val);
>> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
>> +			retval = read_sdma_queue_counter(
>> +					(uint64_t __user *)q->properties.read_ptr,
>> +					&sdma_val);
>> +		else
>> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
>> +				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
>> +					dqm->dev->adev, q->mqd, &sdma_val) :
>> +				 0;
> [HK]: What ahout 9.4.4 and 9.5? Do we we support those now? Otherwise, it will silently report 0 and not error.
gc_9_4_3_kfd2kgd funcs are shared with gfx 9.4.4 and 9.5. The only thing 
I think is return -ENOTSUP instead of 0, if no function is found here. 
what do you think?
>
>>   		if (retval)
>>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>>   				q->properties.queue_id);
>> @@ -2728,8 +2735,16 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>>   	/* Get the SDMA queue stats */
>>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
>> -							&sdma_val);
>> +		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
>> +			retval = read_sdma_queue_counter(
>> +					(uint64_t __user *)q->properties.read_ptr,
>> +					&sdma_val);
>> +		else
>> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
>> +				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
>> +					dqm->dev->adev, q->mqd, &sdma_val) :
>> +				 0;
>> +
>>   		if (retval)
>>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>>   				q->properties.queue_id);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 0be2fd04e6d0..911f974e6bf5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -95,6 +95,7 @@ struct kfd_sdma_activity_handler_workarea {
>>   
>>   struct temp_sdma_queue_list {
>>   	uint64_t __user *rptr;
>> +	void *mqd;
>>   	uint64_t sdma_val;
>>   	unsigned int queue_id;
>>   	struct list_head list;
>> @@ -165,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>>   
>>   		INIT_LIST_HEAD(&sdma_q->list);
>>   		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
>> +		sdma_q->mqd = q->mqd;
>>   		sdma_q->queue_id = q->properties.queue_id;
>>   		list_add_tail(&sdma_q->list, &sdma_q_list.list);
>>   	}
>> @@ -193,7 +195,16 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>>   
>>   	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
>>   		val = 0;
>> -		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
>> +
>> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
>> +			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
>> +		else
>> +			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
>> +			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
>> +					dqm->dev->adev,
>> +					sdma_q->mqd, &val) :
>> +			      0;
>> +
>>   		if (ret) {
>>   			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
>>   				 sdma_q->queue_id);
>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
>> index ead81aeffd67..8700f8190c7c 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
>> @@ -493,6 +493,10 @@
>>   #define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX                                                             0
>>   #define regSDMA_RLC0_MIDCMD_CNTL                                                                        0x017b
>>   #define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX                                                               0
>> +#define regSDMA_RLC0_UTILIZATION_LO									0x017c
>> +#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX								0
>> +#define regSDMA_RLC0_UTILIZATION_HI									0x017d
>> +#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX								0
>>   #define regSDMA_RLC1_RB_CNTL                                                                            0x018
> [HK]: Formatting error. You need to use space instead of tabs, I guess.
Sure.
>
>
> 8
>>   #define regSDMA_RLC1_RB_CNTL_BASE_IDX                                                                   0
>>   #define regSDMA_RLC1_RB_BASE                                                                            0x0189
>> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>> index d34c869b182f..f3220794c108 100644
>> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
>> @@ -361,6 +361,8 @@ struct kfd2kgd_calls {
>>   			     uint32_t *ptl_state,
>>   			     enum amdgpu_ptl_fmt *fmt1,
>>   			     enum amdgpu_ptl_fmt *fmt2);
>> +	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
>> +				    void *mqd, uint64_t *val);
> [HK]: #define SDMA_QUEUES_NUM_PER_ENG	8 <-- We already hard code this value in KFD. I think #define could be avoided if you pass in number_of_sdma_queues_per_engine as a parameter.
OK.

Regards,
Eric
>
>
>>   };
>>   
>>   #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
>> diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
>> index a2f81b9c38af..e0d387f08576 100644
>> --- a/drivers/gpu/drm/amd/include/v9_structs.h
>> +++ b/drivers/gpu/drm/amd/include/v9_structs.h
>> @@ -69,8 +69,8 @@ struct v9_sdma_mqd {
>>   	uint32_t sdmax_rlcx_midcmd_cntl;
>>   	uint32_t reserved_42;
>>   	uint32_t reserved_43;
>> -	uint32_t reserved_44;
>> -	uint32_t reserved_45;
>> +	uint32_t sdmax_rlcx_utilization_lo;
>> +	uint32_t sdmax_rlcx_utilization_hi;
>>   	uint32_t reserved_46;
>>   	uint32_t reserved_47;
>>   	uint32_t reserved_48;

