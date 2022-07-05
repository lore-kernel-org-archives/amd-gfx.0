Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7C5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 21:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AB9113A6E;
	Tue,  5 Jul 2022 21:22:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938EB113A6E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 21:22:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duVIhx/vmxcsPV7Ru6eMSH3j3Sy05wBupk+WS/8mnhRb2HgfSKJop5z1BNZyCwevNm6B36T32HmTrIDTBbGnYCAsz6hySNStFIJ2VgLVgQ2Ww1EX/lzmsBF0WBIwsuLXNTjJ5idXIWqYKnOVU2NbOU5HCCIVvYyq4tL05k3HAf0Mt/uOELx+Zz88u3NzPCn92z9ArPEdTkIkm5SQ9MbusGW3Q6IeEiFNqJVcdgSwuRcXfhw12alDYIYd24V41d3G4dAYbN8SjKc29gyepgfXwsHECUKrRB4j4Ef6bkNqndbhQHdLJiXiB1V3zxRC/xXMkxIOJ4xW7c8TJZeYt4KN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pnIKOIt2DfyXAg6ayCLxJPUhI41yPZBz5SOyDoZpkg=;
 b=MXsQ2mmvSVfHFf2KnbLL9/eE0F/4XZ6+jbkGUQGLlrHY1vcesxzSfxZwQ8TbXlSD02OqAL0nGQIcssmzd1aOkBqSkcf3PImzWrWRfwb9OtiqedBCyQuJm+zpvb9EWEMu1BXVQQcRjztBnLTef5cwUu1iNSginluNt1aFIbowS0WPZIfF5PgvEx+R6SbXnWHKuQKzA8+wU2u3TPPO4R8JAwMgUkbwO2DdJAKbqBl1yNRLACtoHVtGZE7UiDL4+Id/d19rPGc//A3duGLZ2xxgRWbYcrhi4N2Ams36+q+O1OcdPz26bequk6tIuMRdDS2V9tmHmuj/gadqOn+xmg/2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pnIKOIt2DfyXAg6ayCLxJPUhI41yPZBz5SOyDoZpkg=;
 b=HAhCuC3hUmkhejHOp5+1736/TKdXM2I3ULxcRyaKll2mkOpfC7RxSHHe3ObI+RPOeEyyp2Szvp/jttj3dJgiCY/1AgZIT+V59Gc79xvQMrH0htg0iS28aLUAKwKIJ9db3XYjyy4W9nSJ5TmMzwmtW8ptHS61rCbUMlhnlVjVzD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 21:22:47 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc%3]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 21:22:47 +0000
Message-ID: <65a927d1-545a-eeb8-c9ba-ed83a6722705@amd.com>
Date: Tue, 5 Jul 2022 17:22:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/amd: Add debug mask for subviewport mclk switch
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, alexdeucher@gmail.com,
 amd-gfx@lists.freedesktop.org
References: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
 <3c8f371e-bd5c-3df3-cf25-96b2c81868ee@amd.com>
 <f5f443cc-86bf-5d42-09e3-e33f09284b22@amd.com>
From: Harry Wentland <hwentlan@amd.com>
In-Reply-To: <f5f443cc-86bf-5d42-09e3-e33f09284b22@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93628f60-b9ff-41e4-2027-08da5ecc81e7
X-MS-TrafficTypeDiagnostic: PH0PR12MB5465:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbMY9EeLodc7FiPUC8K0bvAnuwRQCIQ0zTJCQ9XLH0zxjFkRKM/yByj4ExFPVBPpPULgCSxYqI65N/EZbXGFXJ9FBmWXxasgHhHXNXYb2qtJqxBfmOTPNRmSRQCf2XqpSq2SO1gg6kyy1WR8lOPVgiopr+0oqJk8v9y9ZJ6sz5jRyGd57jKFVmM8FFJHvEaNUT/u81Mq+aALe4nq5ggdkDMKzuaMAKtc/Kq5EeIn7HjyzThKarsfffsU/FbMNUHQAlgkuMg3bF46aAHQnj+TjnacXVXkHioAGokDZNVwI8PIQDvVGk72ziObbzAn0ZQtpEpJLeIQWks0BFXvYxW/BJLNteqmGIz/1yQLCBSzCYqez4a2A1HHSq7RpzJnKwFm3It+NU49xYn538RoIP6iIaI9nPUXPykXYwRDsYdIwHzJYeEbNHtXgjG6ygm9XL8bRJh+k/MGJzFGlh730x4Yxy3dLT+waQyvuxDp5mrLDzw9kLHqMta/hKUrXUEvbWQI3PiwYMeYvQmtV5IyJqxMr9ZlDTs5BUN9MCenkP9QOCo8Df8sjKFj3kWtZIgx+NZ5tMiyVSpYY+P3qHDDV7hDVldN+ltjvuOcOLxS2kkkPo7MA28Kqsyrf92KlqA3BbiiIY4qNGwV7R58o6IaGASssBJqvJ0e8kok/9XfTEWHEcAuEZcYJ2Zx/9/MxGsSAq3vjt8KVGRb9w4aGjmuL32+mdhdswkQ9gd24bHohzK2tu947QHGWVRk+u1swXmJA2GcJwC3wLwMjp7QUJV84RgdTMXxlJljwBTo41fN6tTBaZsYj/xyWZUGeH70l9/OFdFnHpYJILGv2YRiW3Rn3m4nBfe2zRLlLdX1LRM1RPFhZRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(36756003)(2616005)(6506007)(6512007)(186003)(6486002)(83380400001)(31686004)(478600001)(53546011)(38100700002)(2906002)(8676002)(66476007)(66556008)(66946007)(41300700001)(8936002)(5660300002)(31696002)(6666004)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDB6WkFydWtTQWZwY1dKR1NvS1k2eTF3YmRmQjdPVExRM3J3Q0NjZzBTVy91?=
 =?utf-8?B?NTVNbnZoYlhvOGFLMzNaZkdBaVp4OGpQUm84andlaS9LNEdDRTBYS3FJMmVq?=
 =?utf-8?B?ZlorMURBVWdwR21ITG11RldvM0FNVjRkTGpuSGZTTFptZXFyVVlqSzhsWXg2?=
 =?utf-8?B?ZzJFNkYvK0wzSUk5N2hBdDdGcmthOTNwRmdXY1R3Umw2UWlyQkFqR2R3ZERm?=
 =?utf-8?B?aFlDaVI5dU84ZURSV2pSazZ5VHdja3dTTnlrRDVlRTJBT1RuSlp5YTZOQU1R?=
 =?utf-8?B?bVZCK3VFY3NnN3UxUFBlSUNmZFVFbktwSy9NU09yTGYyN2NSWDFjZGtWYmFH?=
 =?utf-8?B?VDVMV01Dek5YWFpybnNrMlJPTkorMnFFelZrV0xDN3huRk1PR09JYkYyM0ox?=
 =?utf-8?B?RituNWZRNCt1c084cmlJZ29TZll1MXpXZng3dklsMThxdTIxV2kxTVR5UWF0?=
 =?utf-8?B?dGgzYU9JWCs2Y2laMWIrbzh1ejJCc3ljdTR0S21Ga1gxdUxjOWhGazhXOEJz?=
 =?utf-8?B?d0xPM3ZWb05vR3dQM1RpdEFJY2N5VHp3bExqMWJyOVVUSzNVcUFnaVR5UUM4?=
 =?utf-8?B?bmFMRWtFMFZhNUNDQWxWQlExTUI1Um10WVpuM3dRcXlzMHk3NG9aUTI1bEgw?=
 =?utf-8?B?WjVSbC9MVWQ5OEdpZGFiRlFxQjhxSkl5NXI5bGNINUdXdUw4WUdWYXV4R1dk?=
 =?utf-8?B?YUZ4Ri9oa3JaMkZXMFl0YWMzdnZxYWFCY0YyelhYcnJreGExU2pLNnVYT2NZ?=
 =?utf-8?B?SDRkcUcrMDhYUjFvb1BTUityeVZnK1ljOEU5Yy9vVGM5N09XQVRXUnVacmU4?=
 =?utf-8?B?T2pTWG9ycGY4OHM4T0dXME5OUWhjWTN3QTFjMXNUTVByVXdZek5hZk0rUzh1?=
 =?utf-8?B?YmhtNURUaTdjWUQ4UVdYRDVZZVFOMU1GZm5kdytkRHBTV29KQmZKT3pUdXBN?=
 =?utf-8?B?Z1JuOVVBWTUrb0oxa29TcHJZbEJ5RzZlR0lyUFRBR0FmWVg0azVMY0JRVDJI?=
 =?utf-8?B?NFBROWV6dW90d0tQWUQ5VWMvNmtxbUJla1p6L3FBU2ppUVRlQXd2UDd1V1Zz?=
 =?utf-8?B?dnQwN1dnRERkYU1MK0V0Vm44djA4TUpaS3lIZGdvd0p2MUFpQm9mM2d5L0VL?=
 =?utf-8?B?cGlRQiszcVFBWFhIMXdkVVFvemlvdjh6WFAzcUEyTDAyeGlURngyemNKTFF6?=
 =?utf-8?B?NEdlc1M5UUFnc0I5ejZhQjBsYVlTb2VtbkJDV0pzenYzSC9xR2FKc3JnK1hI?=
 =?utf-8?B?RlJrdUlWZTVVMU1SczJWejhlWWpmRVc5OWsrNVlZSUE3YjB1ZEZzdmc4SklF?=
 =?utf-8?B?MXNIV0lOK21jMWZ3RE5IcXRNUks2SVk1OTRiSnFCa2JKUGswdExDYmtzNWth?=
 =?utf-8?B?R0JZUjYwb1dTd1BCcGZqakw2d3Q1cDdTbjJsQy8yck9NMWlGWExtM1kyR29z?=
 =?utf-8?B?c3R6WUlxSW1uSnJHN3N5MjVZQy9MYUQvY01qMFVsL0xCUmk3ZmY5bXI2VWpS?=
 =?utf-8?B?akF0ZEVxdHZYV09pcENLYUw1QklDZFM2R2xhOWM0dGt1WVBqZDhKLzROSHhF?=
 =?utf-8?B?WFB3eDZNcHl6YlFzU0pPT0szVElwZ3Jrd0c3czRLRzNqT2wxd0VISDZKSkVE?=
 =?utf-8?B?M1ZUbGVjbHJPRFJTOUI5M1dqNDJXQU9KaG1Ec0RTaWIveHdXS21ybTVXSm1h?=
 =?utf-8?B?NWtxeEMzc1Fjd1Q1STJJK0I2ZVR6YU1XUDhSaFhkM1JnV0xNN2c2MWR3di9C?=
 =?utf-8?B?Nk12Zmd6UU9oRWVQNjFiWGY2UXhPZWZxV1lzVG1lNjZWMUpkRzhqQVdWdUdB?=
 =?utf-8?B?QjE3dWw5K1JvNWVHcTIzVjN5NjRsSTJXeWxPNi9CK05JWHFnYldUZEtjalk5?=
 =?utf-8?B?L1BsRU5RTDFRbXRhb2xGSDBMYmFIUHFhM1hlNHVsb1JJNFcyNDlUMDgzSmFt?=
 =?utf-8?B?akZsL0g3cGNDVWVEWWFwWnNlTnV4T1phTFJCTVYxNEMvRjk3K3R1c3FXNjJ1?=
 =?utf-8?B?UG52Mkpvb3VkTEhaekVEd1JxUUNXbnpMU0xVL0ZROGNvWmZZUEdWenpuaXBo?=
 =?utf-8?B?cVVYKzhseWVuZWpjL3E0dzBRdVNzcHUzN3R3NjZMK1NLNkZiT1p4VW55dEhV?=
 =?utf-8?B?ajJNaTlrUWZwTWdQaDA0bE1HcnJ6MnlLMEFxWk1wVGc4TFlHbWxYVmZHTmY2?=
 =?utf-8?Q?iLh2Zbf0ZRXuJZSCAv3U19wRlTPF9qLKtdya6BfO+cRW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93628f60-b9ff-41e4-2027-08da5ecc81e7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 21:22:47.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3fM/bLE8t21FKIcaB+tvavaeYEyM4twhcMkYsjqiuU+UzTdU6qGA+C8KXp2S0oXStbbcfIQk2ilrbRztf1EpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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



On 7/5/22 16:24, Aurabindo Pillai wrote:
> 
> 
> On 2022-07-05 15:53, Harry Wentland wrote:
>>
>>
>> On 2022-06-28 17:26, Aurabindo Pillai wrote:
>>> [Why&How]
>>> Expose a new debugfs enum to force a subviewport memory clock switch
>>> to facilitate easy testing.
>>>
>>
>> Does this force a single switch? Or at regular intervals?
> 
> If this debug option is set, each time a MCLK switch happens, a SubVP sequences shall be initiated. That is, during the MCLK switch the scanout shall be from the Subviewport memory. Setting this option doesnt trigger an MCLK switch though.
> 
>>
>> It would be useful to describe a bit better what it does.
> 
> Will keep that in mind, thanks! Unfortunately I merged it already since I got the ack last week.
> No worries :)

Harry

>>
>>> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>
>> Either way, since this is for debug purposes only this is
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>
>> Harry
>>
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>>>   drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
>>>   2 files changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index c9145864ed2b..7a034ca95be2 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -1559,6 +1559,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>>       if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
>>>           adev->dm.dc->debug.disable_clock_gate = true;
>>>   +    if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
>>> +        adev->dm.dc->debug.force_subvp_mclk_switch = true;
>>> +
>>>       r = dm_dmub_hw_init(adev);
>>>       if (r) {
>>>           DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
>>> index bcdf7453a403..b1c55dd7b498 100644
>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>> @@ -247,6 +247,7 @@ enum DC_DEBUG_MASK {
>>>       DC_DISABLE_DSC = 0x4,
>>>       DC_DISABLE_CLOCK_GATING = 0x8,
>>>       DC_DISABLE_PSR = 0x10,
>>> +    DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>>>   };
>>>     enum amd_dpm_forced_level;
>>
