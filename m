Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B4CC04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07C210E4FC;
	Wed, 28 Sep 2022 17:25:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297CC10E50C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQJsG0d8MhGsE0DIcG/0WVUiEnpuda0Dy2g7O8H17Zrv1jWFJu1wTA6HSedHvvPeid9/7d9A9IHyMBUzOE8vrTbZST1ovIi601PyZYvJ8wVXKmYJ/kRx/yFuYJJkr6rdxjXZ/fxXw8iGDR2bwAi1CKpdM5l4XrjZnbMpYa7arjW6oAJj2lPc4/uPaTTgCxVHp9Zc/LqIju/deLNljSMhmgnOTqbvevRuVGOML3RhcooVgS0kCfrwj3JBCSGU+7I4iOVtpsJDoYyDC4RrLZk/787SGGlxFLAbtJfqEABZEOoG8AmuDSyUKw12ahEpmbj4KulqKoTe0u3j3VN7C6JyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM+aIc2QEfUGiTWNOEjaReCgXXYYJ4c6tFfg44qNk1A=;
 b=L/AF0LvST92SFwnUmYL6mEaHn30O8Dfe8jGZ5tVCCCN/J+5+NfWe1wCeBm9O0gPlqg0qk2CDYTlzBoHv+Z+vFgEbZlOw6AaZmLv9Sqg5g6LdIq6+ZWTk6uHCBhpJarBZlGRoUVAmyzK+e7if0M16iPdBJuAZFncY2hBGtNFWhQi6RPc0FOc/tyuFiJf0Qozp68X9NK8CoGbbfJRKwu/Zq1TRekagYLMz5xbFiB+BLT+R0+Kzw4ulisDR3yMlnH0Zibt+eyPHW8WDymSxHSGy/0PT1iDBL9iIaBNnzPOrZPc8qC4ktxpu/aQNBc/WHaIsPUyaY34d40EXRfCWVqI4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM+aIc2QEfUGiTWNOEjaReCgXXYYJ4c6tFfg44qNk1A=;
 b=S3K5AonAvsGWzmHA7MEX+SuphXQbVFm/uBek9dwOk1Cgy8138FjuEOEo5/3fthWfEPkpcDExUWM0+FrRKJhR+Pm951hYRFyxvT4s95zRJd0sgtcc3u4imJkmPKb/Z/wKcjJM+Sfy/zvr4oDeFJoyN44BEEi7uyWFy1aQbrJekzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Wed, 28 Sep 2022 17:25:12 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 17:25:12 +0000
Message-ID: <13a71356-a8c4-683b-ab28-e239d838338e@amd.com>
Date: Wed, 28 Sep 2022 13:25:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] drm/amd/display: Prevent OTG shutdown during PSR SU
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220927231339.187788-1-sunpeng.li@amd.com>
 <fc7a63b3-9a45-d19f-3689-44ebc41aeb76@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <fc7a63b3-9a45-d19f-3689-44ebc41aeb76@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:208:15e::42) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae229b3-19ad-4438-1454-08daa1766614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWVHED9l4/9rRgrzmNnYC8fwnJvMpfLESlotrxGXNsSXywUXZW2qJ9gI6IMXEKGQGlv48Z2QnVgUQzS1SD23LSMjqg6n1ysbcYyle1CYHAzMJs2GB5QpnTJhetgZsKfUhQYlyq1/2VEd6oEDjOchD6vTs2AZMpjUt5SnINFEVEfHqqnPup/88Lb+cSn/OPTrx1tHt4vGEEymUBKxOhvUKGlxG8vo2z8IWP15EvIPjM9qdwAhukkWWMCSRRz1nusuNzwPv4VnHDm5z7+VZZmOlo/GL6hhRtr4SPl/Gg4A81vowjFPLk3jN8OJf1ayvp2CfIIpveri5Be42pB91iM3e8YtezYGKCaZLxUcWh+stu/A2foZYS+y4gHlavJObfMqISp9RMmHpttO/ImGRHG+yrQVaJjO5ZNoFlVXq8pCCoKzDjaNKcnC4U40zJ+bGFXdIDtzhDflwKeAvWrwnJFpaAK8Neq+XvX4wCzd8Knx9e5+JFw4tdnpAkPH8PBYFkNhXj3Ff8kzS4rp+3UdAyk8A1YS2r15HkURXxVE3R2/1oJ2aqYds26OVDZCGvSHKa6TkOQneIaXVyl1n/FOkg72YBoAy26ysEYr8gvIRUYSHCIDx6Dt0OFgYX3xKUo54cmxZUsRJKkj4N3VbkrWvFF8ZPPGSUSOAyjogmraAnFntP6PbiFf1HBNEHi90U3hmPbypTfMzxvN39I76mT/iDeOR1QdYtZRn93+hQSDHnzjKvGa4E7gUYH6wImwN7/HqHzJZW05wlGKyjVPxiCZ1HRadTJm/qqyQdGT2RI7dYIl2lo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(478600001)(6486002)(31686004)(6506007)(53546011)(6666004)(186003)(316002)(2906002)(2616005)(38100700002)(8676002)(83380400001)(26005)(6512007)(36756003)(41300700001)(4326008)(66946007)(31696002)(66556008)(5660300002)(66476007)(8936002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW96bkhDRS81UnJHUnZ2YWpJYUpZc3VObVI5QnI2dVZBS3VBYk1Xa05SYVV2?=
 =?utf-8?B?VHp2dkFETi8yKzdXUHpmc0NJbnNtbzFOSUh1ZUVtQkZtYXlhdkFHSTJXNFdE?=
 =?utf-8?B?M3p0YzNubDhqT2xwSHBVQVRQaDQ5ZHd4cUpBYjVkMkJtMzlBbjFpOTI5R2pi?=
 =?utf-8?B?NUtNRlpmWUZUMEgrRXAreUFBSU43Tk1lbCtmS3VFL09nK2RkNmlBLzRTNVhZ?=
 =?utf-8?B?dG5mQTV3OVdGWGJtTHlwMk42K3hhTlBtYWJZMjNocFBqRDYrU2UyUTVqNUMv?=
 =?utf-8?B?cVZDSFpJRTlOK044SXV0ampOWWNmUi93QmkrQTNHWktvNTBWYll3OUdhYlZq?=
 =?utf-8?B?ZUFPdTgrMFJVaEgrVjNLVmNXZHg2NGVtRWhtaWs3czl1T0ZBUTZLa2dOWjN1?=
 =?utf-8?B?VDJMeENmTnNpVjY5bGg0bGdUd0pHZW0rK0puM3kxMEk4V3NnTHNlOFhXNE1s?=
 =?utf-8?B?TVA4ZjZQSE9lMHNCNkFMa0FYZ05VNjZmVlhkWkpRWDkzM013ZG52a0x3eVVZ?=
 =?utf-8?B?MEJndFM0L3FlR001clFVRk1wYlRHUlF6QW0yZHV4cWN4YWZtSnFzZ2x6M25j?=
 =?utf-8?B?eEZpVGI4RzFNVkEweXVZT3RBVDZYY1hUdldrWlU2QWlZdU5TN0F3aFJPU3Z3?=
 =?utf-8?B?Y1ZNWnRUQS85NnF3eW5FZm9jc3lUbDA3djZEbTNPZkQxTTFqUWc1RXpSd0w4?=
 =?utf-8?B?WTlDU1ErVTA2UVkvR1NzSVdHWElLOEc3eTZTdEd1ZzZGSWE1VzdkNXh2SEMy?=
 =?utf-8?B?N09PUFJaVk5lTHlOZEZmb3JhNlFjRUo1VXYyQWlVa2t6NldKUDVhb0ZZQmUy?=
 =?utf-8?B?UFIxUkhseFRWT3hWQ0NJUVpkckxUWWRuQ3ZOdk94MGRSb0NtdTFQRFNTR2J3?=
 =?utf-8?B?TUxGa3hvN29raDJlS0hBcjZ1Y3JFeGlEQmJlQnRXcXZBbkNCQUU3Z0syQ1Vl?=
 =?utf-8?B?STE2ZHczZUFYZldBM3RBd2VkK3dLSjNrVUp3SlptZ0tPa3FaajBFT0sxR2NI?=
 =?utf-8?B?c1VHRzU2ZHV0ZmxQZHpWQ2FmcEx0MldkTk5ieUlLbEhoOGp5WVVhQ1Z0NTU5?=
 =?utf-8?B?TVVyZFVFUkpnNW9FSTcyWEdSTWloRlFvcWxFT1BsakZ4ZGU1OHNmeDJ2TnZn?=
 =?utf-8?B?SGZqby9TZVZUQjladG43ay9TZXRLeUpDcjNYUHRhZTVkaGRPWkc0SFliR3h0?=
 =?utf-8?B?QUFtYWhXTzJURkVoYTR3VStEeURQRngwck9WbzZveXJjc0dyRm9SbFBCQURo?=
 =?utf-8?B?bi9xajhRK1BoOHZQTFFydWVPY0ttOFlZT0dxMWZvL1AxK2ozMVh6R3pxUUVp?=
 =?utf-8?B?YThMVXFjNnBXN3FIV2xqL3FWV2RYZlNVVmV5V1VWRkFRZjdIZWgyKzhSOU5R?=
 =?utf-8?B?eWpRd2o5bmUvQ0x0ZGJndXJlTjlNYTNJR20vSG1heENjcmZwTUl6QmUzZVZq?=
 =?utf-8?B?Q3NCVUdjWE9jUlAyY2tHYVl6bGFsMHhCM0FYZVNOK0VKL1Y2S2MzQ1EyMDVS?=
 =?utf-8?B?RkxCNk9WS0RPeFNwTW9xcEMrODJhKzNEYXFrajNFUXU5WWliNllYQno4bjd5?=
 =?utf-8?B?OGNXekVqT2V0Wmh2MWFOZDUzTTFKcVEwb2JiaHN4cW1jbS9iSjMzejJvLzVz?=
 =?utf-8?B?MTVIRTRGdEdFZ3VSUGViRVpnUU1tZ00rWXNOdmhZMS9LZzEzNG1yZWN1cmlV?=
 =?utf-8?B?SnYvOVRuelhBS01PR2lGYVloRnNoWmdxY0lmNFJVK0lscnpvRm9DRnFVYUxN?=
 =?utf-8?B?TXRDbGw0OE1wZ0pEWkVVQW5ERzhwU2FDeTFoN1VkOUlaVTBLbzBzaWkvdWxl?=
 =?utf-8?B?TzNiWm5DNnJDc25UTXcvaVQ2aXduTDVMZjVTT0RwMFJMSiszRlp2NEptSTlo?=
 =?utf-8?B?VFpHUjZTbmFQRHFMeGovbmdyeExlSGxCQVVoWk54SVpqMmlXeG94L3pjQ25H?=
 =?utf-8?B?bkluS2lQU0FGRTJBUndQQUY5em8zSW5TeWl3TmdwaTVoSHJud29rOGUzMStn?=
 =?utf-8?B?MGJFVy9iZVowMms1Y29zSm95cm05bnUvZmRPNGNoTTRDSXlYQmZHckxqUHFX?=
 =?utf-8?B?Z3dBWm5qV3lzQ08wNFZqVUxmQlZrQWRLWEcyWVNqNkR5amwzMXAwd3hPTjdp?=
 =?utf-8?Q?rLK4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae229b3-19ad-4438-1454-08daa1766614
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 17:25:11.9494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw1209YMGm1XePDG4ZfpJI8QT2+DwqXNz3IEVbhKIJBUVi0w5BPmeqWqMCQ+EB91
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 regressions@lists.linux.dev, git@augustwikerfors.se
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-09-28 09:52, Harry Wentland wrote:
> 
> 
> On 2022-09-27 19:13, sunpeng.li@amd.com wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> [Why]
>>
>> Enabling Z10 optimizations allows DMUB to disable the OTG during PSR
>> link-off. This theoretically saves power by putting more of the display
>> hardware to sleep. However, we observe that with PSR SU, it causes
>> visual artifacts, higher power usage, and potential system hang.
>>
>> This is partly due to an odd behavior with the VStartup interrupt used
>> to signal DRM vblank events. If the OTG is toggled on/off during a PSR
>> link on/off cycle, the vstartup interrupt fires twice in quick
>> succession. This generates incorrectly timed vblank events.
>> Additionally, it can cause cursor updates to generate visual artifacts.
>>
>> Note that this is not observed with PSR1 since PSR is fully disabled
>> when there are vblank event requestors. Cursor updates are also
>> artifact-free, likely because there are no selectively-updated (SU)
>> frames that can generate artifacts.
>>
>> [How]
>>
>> A potential solution is to disable z10 idle optimizations only when fast
>> updates (flips & cursor updates) are committed. A mechanism to do so
>> would require some thoughtful design. Let's just disable idle
>> optimizations for PSR2 for now.
>>
> 
> Great writeup. Wish every bugfix came with details like this.
> 
>> Fixes: 7cc191ee7621 ("drm/amd/display: Implement MPO PSR SU")
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> 
> With Thorsten's comments addressed this is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry
> 

Thanks all for the bug report, comments, and review. Will send out v2 
and merge shortly.

Leo

>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>> index c8da18e45b0e..8ca10ab3dfc1 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>> @@ -170,7 +170,13 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
>>   					   &stream, 1,
>>   					   &params);
>>   
>> -	power_opt |= psr_power_opt_z10_static_screen;
>> +	/*
>> +	 * Only enable static-screen optimizations for PSR1. For PSR SU, this
>> +	 * causes vstartup interrupt issues, used by amdgpu_dm to send vblank
>> +	 * events.
>> +	 */
>> +	if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
>> +		power_opt |= psr_power_opt_z10_static_screen;
>>   
>>   	return dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
>>   }
> 
