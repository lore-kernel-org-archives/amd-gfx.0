Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D587BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 10:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4C210E4C6;
	Tue, 11 Jan 2022 10:15:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB08910E4C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 10:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQv9RsW2ZR/OaO9O4X28/aPR4hGq6EOHXWljW3EiQNUXRp78q1avQJQ2h0uacUuEYtvmJ41XI+lbooDNz1rUo7/crdjZOpMj/MLl+ycuaP3AXU/FRImzJZ0Uqr3+l3RDh55Uz3yXMBgs+YtAOGATbOpYI3nTrbOHP3FG3Mcj4cz4OrYmM33HbSjVUmWIjoalu7kXuO6ciAY94hIHLmmorG4H0dz8hsKhVbIi2iE6LjGMckf+YF3iM0JwMsBwA5B450BNDQf93iYaeVgX1okkM2qPsZVTbX0bVziafDEXSffvtCsow5n/MwAAzQksE9QsV7yPBNC+6ewKrkYjcnwKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYS/SaDXhjlnB1BihgKFRZSaZq4gAulUYVvzbzr7IvU=;
 b=JkfM9qgwL2icyr4XLwEWzPPwyfyhcLVZkZ0A1QACW19tpkedHdKZsbrTSiN6LQRxZlxCw981/h+gDAoVFNdfl0NaywE9sJSBy/2MzItjFiZkpG3fKDxmhBIQv66eDaFI+wXXiEfuXeyU2/5v98W2VuS4qQWBwAqdDm6j5udV7iFa/L90mU1peFgWjDf5+oeX1H35b52QJBfn6ylUOxgUGi6F3Zhx5fEEVBdfZKsx9q91WNzzXx+dh9Hiki92Xw95uVqIu5+OMmnyrxqiYpT9o3UQ26lnQBfoBVDrRm958EmA/4Hxgs7J1OTqMvtilOmkg2KB3H0hkcEA55BPo51OJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYS/SaDXhjlnB1BihgKFRZSaZq4gAulUYVvzbzr7IvU=;
 b=ENXr9KWv7WW6vwswukrZhzVOhU01Q/hXoNzXtRvr9SeyNMcmHD2TjMEIo5MIGA0VVkf+9ythUow7A9rvQk6zbZCjMknwptLKY3kO7xpH2AV+Qtw9vIjNJRLp4Qy91F+huIT05yyFnUycDp68o6rDLDw87PeWE1gKUjGpTLt5kEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 10:15:01 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 10:15:01 +0000
Message-ID: <4ccb0507-cb69-cc15-7610-801837df8589@amd.com>
Date: Tue, 11 Jan 2022 15:44:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220111074729.40906-1-evan.quan@amd.com>
 <529cd021-7342-8efb-b1bc-266bbf0fee88@amd.com>
 <DM6PR12MB2619BAB036BE8B2825D89C8AE4519@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619BAB036BE8B2825D89C8AE4519@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::33) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab90c161-d28d-4eab-ebde-08d9d4eb3a4d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4193:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4193F3E98D6E96B68FA5CEC597519@BY5PR12MB4193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HEy/NqseNYFP443Bfl/995BB59awU1B/dff912IMaxrG6se7w+/0yVbYUnTUZybviM7hPF3H9sHoyY/ukRMznOxaMfnXVhfbCJbuk0tF8ofttOp8vvGgsW6b9R2HTXUmcZc8FFrNdSDsfHzuwr/QVoiiBLcTnmafqFhoD5yfbBhULPj7/hW0kwEAYefaE2vq54H3ngGXm6hE/B906MF4WO4Yhgcl+b0nBCiH99benv1KeO0ef+siXldpRXoUe82eJBOW1XVSxicOpZeBrHV6vyhJTSLi+dmq7yxHS9AK/d6W83M7BjMHWHZswIwol1+AU4Q41BeM+KKgMG0zau4JRxv7nHIIGPKL1U2FVXjtJqHXF8ntqTY1pVXlQPA9rd69i275WNRSPjiAkXp1fGMBNVpJd4rEioOpEJuXHSpb3GoDTL2RSLtA+zOnUew966c8efzIuKwpbxBsJq/GATS+8aMEeLtuMOTFNFtr8PmZe8Fr8yBUzB24Qrx4wuPVhY0uv6eS7lfAWTflX4TVbHMxmPRbTUGPNKjLy20p1TyFdaPZt6/JraktWtafDdD8ixQzQEMtMQ+mveoEmbqZbnAoTtPzVTM1bDfuf+HUy9xJAZt6CF6IfCyCYyK0avGWeyFd58OxxdBF5ez+UKjPzYueN84C5BhHQH8EunwOv3r3R0z2uUr+RXgfJ6VVm9t50W0kcZVSKIwgGfUudz7DIwj8hfxbEZaKSKF4wiPmrexSvGtQt3QxgVt7Go131g8cGgB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(86362001)(26005)(4326008)(53546011)(36756003)(2616005)(508600001)(2906002)(54906003)(186003)(66476007)(6506007)(31696002)(6666004)(8936002)(66556008)(6486002)(316002)(110136005)(66946007)(8676002)(38100700002)(6512007)(30864003)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXR1a1pNcSt5dXMwSFZibUZXZ0JJaDVUWU9UcjRCeUx1a0gzRno2RnZLUFRa?=
 =?utf-8?B?SG1sSkxNSnA5U3orN1R2MS95VVRFTmg0VTJEK3k0ZER1Qi9PMEJnOXVTVk41?=
 =?utf-8?B?TFQrdVB1TEZWenBmK2EyaGZlUllVUTJtMWxpRWNKSk15MEd3UWxGOFZnVzBa?=
 =?utf-8?B?bFFoZ0JOZXpjaSt5NzFpUUtKQVo0cGw4UTkyUTA4eWpnSFBGaStjSFlvOHl4?=
 =?utf-8?B?MXJuU3hvMWxySjlvZFFGaU9hZGlRZXJOd1p1MEtab2ttLzVFU1Evcm9JMFN5?=
 =?utf-8?B?STRGcG15OVoyR3B2K0pIeWp2bW1LNlVydDMwUjFFR3lGbGJyY0VXQXRCdmNW?=
 =?utf-8?B?Zzh6aCtycklxaEk3VkFYV2NpUW9mbjhZSWJtbSt1b1llOS9TYkh1WWFzWlRL?=
 =?utf-8?B?UU5DZFcrOU5DUnlTS0RTK3NKcVlIanhUSlhsSnhwN2svbWIwK21VazVQREli?=
 =?utf-8?B?YTNoS0tTcU1ucHpldTY4bjdXeStiaXdZa1d2SGJlVjZ0Mi9iTTVvVUg0ME1w?=
 =?utf-8?B?bUVLWkNCNnpuWVg5TVd0ZjdxSG1jTkIrNW9scVhZMGhHWGpnWVBlWWdJZU8y?=
 =?utf-8?B?SEhkbFZZU3NINnhsNWlHRG5oMkw1UXBDRUlkMlo1aVFXTjVqVUE5RmlyQXpv?=
 =?utf-8?B?WWgydDVya2JQcHRoYUYvcGFNOVI5dVZJVUc2c2dxVTlGN21sSFYxMTRyKzkw?=
 =?utf-8?B?bWROSHp2dnJKbVFmUlpBOFVmNjRRNFh0WjdHVDcySnNqSXZLMWxHU0sySWZY?=
 =?utf-8?B?NzBySnZ3dDk2dmpFeDlQblpLZ054WWUwTzZOU1pKVmNDelBvTzc3OU9GS3hp?=
 =?utf-8?B?Y2g4TFVRd09qRkpvNk91ZFJFcWVSQXVESFR5cDlnM3oxRGgyWEIwU3VjbkxS?=
 =?utf-8?B?VTgwSUZvdVdDQlNXWW04OGYyTWFEMTdmcUdOOFhjMnROV0RIUHROb0d6a0RE?=
 =?utf-8?B?djJXUHZJMzBvbWsyTzZtY1k2TWF0UlpPNHZEWDlEa09HL0lTcXF2dXdkM0M5?=
 =?utf-8?B?azBjTGZaN0M2UFZkSUNLVm02TThBbXhyb1pJc2RmT0laMXZudVJFSHRzSGx2?=
 =?utf-8?B?b3NJTkdqM00yNjZuWnoycXhscnVsWDNMMEtXU2dQZGdMQTM5MHgrNFI0dkRN?=
 =?utf-8?B?czYrQlV1SFIvUXc4dzhEd3Y4SmJqUllVTkV6TGJnRXNid2E5OFB1T1ZsY04y?=
 =?utf-8?B?Sk5FL0lPVXdsZVFMQlp5ZGpndEZDNnJ6Q0RmMDBSYm9zejg3NWd0dnVrTXdv?=
 =?utf-8?B?TzBYNmZoRDQvSS9YWW9uemkxdzJHd3R6TFNORWJid0xJVEZLVkdWMXExMTRW?=
 =?utf-8?B?L082SVNNNXl5VkQ5QjJZRlJFZXpQMmFCNVBSSHoyZVpLYTF0blBLK0NHdmJI?=
 =?utf-8?B?bUczVDl3TFEycjN6dTZNWFV6c0cvSWN5R210aE9DeGprb3EvT0NzNHlGbmxr?=
 =?utf-8?B?S1d2aUFvMkYwSG1ZZGJ3R0ZkZkhKM2dCRXhpODhlOFV0YW9LV1A4RHFZTWly?=
 =?utf-8?B?Zk9VMjgyRVhVM2xlMWV4anFvLzdCUTl2Y1R3UkFKbXhLbWJFbTlsUFVWcFFY?=
 =?utf-8?B?b3lZNkNSTHVNVXBWQUtlT3FkZ0s0N21VS1cydXdKQkNSUlF0VE5TQUxvVFdG?=
 =?utf-8?B?azcwNWVNZXBZdG1pSGhPUzB1Z2RTTWdiZlFJUE94WVdkN3lSVGNuREdtMGVU?=
 =?utf-8?B?TEh1WVo1VU5kTm80dzluZGhJVi8wU1pqWWRGS3ltamZnSUhKUzU3RnVIUVd1?=
 =?utf-8?B?NXZpNzB4OUhubEdGTUtoQ2lMMTBMOFJzOE5Mb2xwSE1jOWNwZWkxOHlCL28v?=
 =?utf-8?B?SEhxdUJYQ1kzRUVPZEMrNG5pcnYrUVVjRVRINFIvVzJNMGFEMlllRFlSdnVw?=
 =?utf-8?B?U3pIQ2hlWFI3NnkyYWEzbDlndW9DNHdLclJWWXJTYVluWERsV1U4M0xiNVda?=
 =?utf-8?B?YytDUW0zSWJPM1JPTG1wUWNRYS9Ga1MrRktmN3FrV0Z6UkhLN2N3ZzZxRkNO?=
 =?utf-8?B?OERPM2RPTDF4QXRwUncyQTROR0k0TFBVWTJYam9ackZWUHVJTGhwbU4wS1A4?=
 =?utf-8?B?OHd0WUZES1Yvb1h6TVFqUm9BRGtWRVZjdUtuSXpNcGZORjRKQ2NJUU1MRklM?=
 =?utf-8?Q?C560=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab90c161-d28d-4eab-ebde-08d9d4eb3a4d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 10:15:01.4598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDCPjK2q8t0aCQ6ZvD/5TJfrPzbpzfKnW8q/ONeXbBcgz+XESba2thvWqDZETWKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/11/2022 3:36 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, January 11, 2022 4:14 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>> <Guchun.Chen@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: correct the checks for fan attributes
>> support
>>
>>
>>
>> On 1/11/2022 1:17 PM, Evan Quan wrote:
>>> On functionality unsupported, -EOPNOTSUPP will be returned. And we
>>> rely on that to determine the fan attributes support.
>>>
>>> Fixes: 801771de0331 ("drm/amd/pm: do not expose power
>> implementation
>>> details to
>>> amdgpu_pm.c")
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I95e7e0beebd678a446221a72234cd356e14f0fcd
>>> ---
>>>    .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  31 ++++-
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  21 ++--
>>>    drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  10 +-
>>>    .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  59 ++++-----
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 115 +++++++++----
>> -----
>>>    6 files changed, 132 insertions(+), 108 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> index a8eec91c0995..387120099493 100644
>>> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> @@ -315,8 +315,8 @@ struct amd_pm_funcs {
>>>    				void  *rps,
>>>    				bool  *equal);
>>>    /* export for sysfs */
>>> -	void (*set_fan_control_mode)(void *handle, u32 mode);
>>> -	u32 (*get_fan_control_mode)(void *handle);
>>> +	int (*set_fan_control_mode)(void *handle, u32 mode);
>>> +	int (*get_fan_control_mode)(void *handle, u32 *fan_mode);
>>>    	int (*set_fan_speed_pwm)(void *handle, u32 speed);
>>>    	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
>>>    	int (*force_clock_level)(void *handle, enum pp_clock_type type,
>>> uint32_t mask); diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index 68d2e80a673b..fe69785df403 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -1030,15 +1030,20 @@ int
>> amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
>>>    				    uint32_t *fan_mode)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +	int ret = 0;
>>>
>>>    	if (!pp_funcs->get_fan_control_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>> +	if (!fan_mode)
>>> +		return -EINVAL;
>>> +
>>
>> pp_funcs most likely will be there for smu/powerplay subsystem. I think the
>> checks should be at one layer down - smu_get_fan_control_mode() and
>> pp_dpm_get_fan_control_mode()
>>
>> First one will check if ppt func is implemented and second one will check if
>> hwmgr func is implemented for the specific ASIC.
> [Quan, Evan] Yes, I agree. And if you go through the changes below, you will see the checks (for the layers down) there.
> This patch checks not only those amdgpu_dpm_xxxx APIs, but also those downstream interfaces(smu_xxxx and pp_dpm_xxxx).
>   

Say you call amdgpu_dpm_get_fan_control_mode(adev, NULL) from amdgpu_pm

pp_funcs->get_fan_control_mode => this will point to 
smu_get_fan_control_mode for all swsmu ASICs. So  "if 
(!pp_funcs->get_fan_control_mode)" will be false.

The next statement is NULL check and it will return -EINVAL.

What we want to know is ppt_func is implemented or not for the 
particualr swsmu ASIC. Isn't that the case or am I reading it differently?

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>    	mutex_lock(&adev->pm.mutex);
>>> -	*fan_mode = pp_funcs->get_fan_control_mode(adev-
>>> powerplay.pp_handle);
>>> +	ret = pp_funcs->get_fan_control_mode(adev-
>>> powerplay.pp_handle,
>>> +					     fan_mode);
>>>    	mutex_unlock(&adev->pm.mutex);
>>>
>>> -	return 0;
>>> +	return ret;
>>>    }
>>>
>>>    int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
>> @@
>>> -1048,6 +1053,9 @@ int amdgpu_dpm_set_fan_speed_pwm(struct
>> amdgpu_device *adev,
>>>    	int ret = 0;
>>>
>>>    	if (!pp_funcs->set_fan_speed_pwm)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (speed == U32_MAX)
>>>    		return -EINVAL;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>> @@ -1065,6 +1073,9 @@ int amdgpu_dpm_get_fan_speed_pwm(struct
>> amdgpu_device *adev,
>>>    	int ret = 0;
>>>
>>>    	if (!pp_funcs->get_fan_speed_pwm)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (!speed)
>>>    		return -EINVAL;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>> @@ -1082,6 +1093,9 @@ int amdgpu_dpm_get_fan_speed_rpm(struct
>> amdgpu_device *adev,
>>>    	int ret = 0;
>>>
>>>    	if (!pp_funcs->get_fan_speed_rpm)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (!speed)
>>>    		return -EINVAL;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>> @@ -1099,6 +1113,9 @@ int amdgpu_dpm_set_fan_speed_rpm(struct
>> amdgpu_device *adev,
>>>    	int ret = 0;
>>>
>>>    	if (!pp_funcs->set_fan_speed_rpm)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (speed == U32_MAX)
>>>    		return -EINVAL;
>>>
>>>    	mutex_lock(&adev->pm.mutex);
>>> @@ -1113,16 +1130,20 @@ int
>> amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
>>>    				    uint32_t mode)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +	int ret = 0;
>>>
>>>    	if (!pp_funcs->set_fan_control_mode)
>>>    		return -EOPNOTSUPP;
>>>
>>> +	if (mode == U32_MAX)
>>> +		return -EINVAL;
>>> +
>>>    	mutex_lock(&adev->pm.mutex);
>>> -	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
>>> -				       mode);
>>> +	ret = pp_funcs->set_fan_control_mode(adev-
>>> powerplay.pp_handle,
>>> +					     mode);
>>>    	mutex_unlock(&adev->pm.mutex);
>>>
>>> -	return 0;
>>> +	return ret;
>>>    }
>>>
>>>    int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev, diff
>>> --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index d3eab245e0fe..940cbe751163 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -3197,7 +3197,6 @@ static umode_t hwmon_attributes_visible(struct
>> kobject *kobj,
>>>    	struct device *dev = kobj_to_dev(kobj);
>>>    	struct amdgpu_device *adev = dev_get_drvdata(dev);
>>>    	umode_t effective_mode = attr->mode;
>>> -	uint32_t speed = 0;
>>>
>>>    	/* under multi-vf mode, the hwmon attributes are all not supported
>> */
>>>    	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>> @@
>>> -3263,15 +3262,15 @@ static umode_t hwmon_attributes_visible(struct
>> kobject *kobj,
>>>    		return 0;
>>>
>>>    	/* mask fan attributes if we have no bindings for this asic to expose
>> */
>>> -	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>> &&
>>> +	if (((amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -
>> EOPNOTSUPP) &&
>>>    	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query
>> fan */
>>> -	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -
>> EOPNOTSUPP) &&
>>> +	    ((amdgpu_dpm_get_fan_control_mode(adev, NULL) == -
>> EOPNOTSUPP) &&
>>>    	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
>> query state */
>>>    		effective_mode &= ~S_IRUGO;
>>>
>>> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>> &&
>>> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -
>> EOPNOTSUPP) &&
>>>    	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't
>> manage fan */
>>> -	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -
>> EOPNOTSUPP) &&
>>> +	      ((amdgpu_dpm_set_fan_control_mode(adev, U32_MAX) ==
>>> +-EOPNOTSUPP) &&
>>>    	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't
>> manage state */
>>>    		effective_mode &= ~S_IWUSR;
>>>
>>> @@ -3291,16 +3290,16 @@ static umode_t
>> hwmon_attributes_visible(struct kobject *kobj,
>>>    		return 0;
>>>
>>>    	/* hide max/min values if we can't both query and manage the fan */
>>> -	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL)
>> &&
>>> -	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL)
>> &&
>>> -	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>> &&
>>> -	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL))
>> &&
>>> +	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -
>> EOPNOTSUPP) &&
>>> +	      (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -
>> EOPNOTSUPP) &&
>>> +	      (amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -
>> EOPNOTSUPP) &&
>>> +	      (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -
>> EOPNOTSUPP)) &&
>>>    	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
>>>    	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
>>>    		return 0;
>>>
>>> -	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL)
>> &&
>>> -	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)
>> &&
>>> +	if ((amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -
>> EOPNOTSUPP) &&
>>> +	     (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -
>> EOPNOTSUPP) &&
>>>    	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
>>>    	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
>>>    		return 0;
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> index 92b987fb31d4..7677d3a21f8c 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> @@ -6669,7 +6669,7 @@ static int si_dpm_set_fan_speed_pwm(void
>> *handle,
>>>    	return 0;
>>>    }
>>>
>>> -static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
>>> +static int si_dpm_set_fan_control_mode(void *handle, u32 mode)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>
>>> @@ -6685,9 +6685,11 @@ static void si_dpm_set_fan_control_mode(void
>> *handle, u32 mode)
>>>    		else
>>>    			si_fan_ctrl_set_default_mode(adev);
>>>    	}
>>> +
>>> +	return 0;
>>>    }
>>>
>>> -static u32 si_dpm_get_fan_control_mode(void *handle)
>>> +static int si_dpm_get_fan_control_mode(void *handle, u32 *fan_mode)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>    	struct si_power_info *si_pi = si_get_pi(adev); @@ -6697,7 +6699,9
>>> @@ static u32 si_dpm_get_fan_control_mode(void *handle)
>>>    		return 0;
>>>
>>>    	tmp = RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK;
>>> -	return (tmp >> FDO_PWM_MODE_SHIFT);
>>> +	*fan_mode = (tmp >> FDO_PWM_MODE_SHIFT);
>>> +
>>> +	return 0;
>>>    }
>>>
>>>    #if 0
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index 89341729744d..57bc9405d6a9 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -488,38 +488,37 @@ static enum amd_pm_state_type
>> pp_dpm_get_current_power_state(void *handle)
>>>    	return pm_type;
>>>    }
>>>
>>> -static void pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
>>> +static int pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>
>>>    	if (!hwmgr || !hwmgr->pm_en)
>>> -		return;
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL)
>>> +		return -EOPNOTSUPP;
>>>
>>> -	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL) {
>>> -		pr_info_ratelimited("%s was not implemented.\n",
>> __func__);
>>> -		return;
>>> -	}
>>>    	mutex_lock(&hwmgr->smu_lock);
>>>    	hwmgr->hwmgr_func->set_fan_control_mode(hwmgr, mode);
>>>    	mutex_unlock(&hwmgr->smu_lock);
>>> +
>>> +	return 0;
>>>    }
>>>
>>> -static uint32_t pp_dpm_get_fan_control_mode(void *handle)
>>> +static int pp_dpm_get_fan_control_mode(void *handle, uint32_t
>>> +*fan_mode)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>> -	uint32_t mode = 0;
>>>
>>>    	if (!hwmgr || !hwmgr->pm_en)
>>> -		return 0;
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL)
>>> +		return -EOPNOTSUPP;
>>>
>>> -	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL) {
>>> -		pr_info_ratelimited("%s was not implemented.\n",
>> __func__);
>>> -		return 0;
>>> -	}
>>>    	mutex_lock(&hwmgr->smu_lock);
>>> -	mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
>>> +	*fan_mode = hwmgr->hwmgr_func-
>>> get_fan_control_mode(hwmgr);
>>>    	mutex_unlock(&hwmgr->smu_lock);
>>> -	return mode;
>>> +	return 0;
>>>    }
>>>
>>>    static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
>> @@
>>> -528,12 +527,11 @@ static int pp_dpm_set_fan_speed_pwm(void *handle,
>> uint32_t speed)
>>>    	int ret = 0;
>>>
>>>    	if (!hwmgr || !hwmgr->pm_en)
>>> -		return -EINVAL;
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
>>> +		return -EOPNOTSUPP;
>>>
>>> -	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL) {
>>> -		pr_info_ratelimited("%s was not implemented.\n",
>> __func__);
>>> -		return 0;
>>> -	}
>>>    	mutex_lock(&hwmgr->smu_lock);
>>>    	ret = hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
>>>    	mutex_unlock(&hwmgr->smu_lock);
>>> @@ -546,12 +544,10 @@ static int pp_dpm_get_fan_speed_pwm(void
>> *handle, uint32_t *speed)
>>>    	int ret = 0;
>>>
>>>    	if (!hwmgr || !hwmgr->pm_en)
>>> -		return -EINVAL;
>>> +		return -EOPNOTSUPP;
>>>
>>> -	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL) {
>>> -		pr_info_ratelimited("%s was not implemented.\n",
>> __func__);
>>> -		return 0;
>>> -	}
>>> +	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL)
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&hwmgr->smu_lock);
>>>    	ret = hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
>> @@
>>> -565,10 +561,10 @@ static int pp_dpm_get_fan_speed_rpm(void *handle,
>> uint32_t *rpm)
>>>    	int ret = 0;
>>>
>>>    	if (!hwmgr || !hwmgr->pm_en)
>>> -		return -EINVAL;
>>> +		return -EOPNOTSUPP;
>>>
>>>    	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
>>> -		return -EINVAL;
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&hwmgr->smu_lock);
>>>    	ret = hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
>> @@ -582,12
>>> +578,11 @@ static int pp_dpm_set_fan_speed_rpm(void *handle,
>> uint32_t rpm)
>>>    	int ret = 0;
>>>
>>>    	if (!hwmgr || !hwmgr->pm_en)
>>> -		return -EINVAL;
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
>>> +		return -EOPNOTSUPP;
>>>
>>> -	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL) {
>>> -		pr_info_ratelimited("%s was not implemented.\n",
>> __func__);
>>> -		return 0;
>>> -	}
>>>    	mutex_lock(&hwmgr->smu_lock);
>>>    	ret = hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
>>>    	mutex_unlock(&hwmgr->smu_lock);
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index c374c3067496..474f1f04cc96 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -59,7 +59,7 @@ static int smu_handle_task(struct smu_context *smu,
>>>    			   bool lock_needed);
>>>    static int smu_reset(struct smu_context *smu);
>>>    static int smu_set_fan_speed_pwm(void *handle, u32 speed); -static
>>> int smu_set_fan_control_mode(struct smu_context *smu, int value);
>>> +static int smu_set_fan_control_mode(void *handle, u32 value);
>>>    static int smu_set_power_limit(void *handle, uint32_t limit);
>>>    static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>>>    static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>>> @@ -407,7 +407,7 @@ static void smu_restore_dpm_user_profile(struct
>> smu_context *smu)
>>>    	if (smu->user_dpm_profile.fan_mode ==
>> AMD_FAN_CTRL_MANUAL ||
>>>    	    smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_NONE) {
>>>    		ret = smu_set_fan_control_mode(smu, smu-
>>> user_dpm_profile.fan_mode);
>>> -		if (ret) {
>>> +		if (ret != -EOPNOTSUPP) {
>>>    			smu->user_dpm_profile.fan_speed_pwm = 0;
>>>    			smu->user_dpm_profile.fan_speed_rpm = 0;
>>>    			smu->user_dpm_profile.fan_mode =
>> AMD_FAN_CTRL_AUTO; @@ -416,13
>>> +416,13 @@ static void smu_restore_dpm_user_profile(struct
>> smu_context
>>> *smu)
>>>
>>>    		if (smu->user_dpm_profile.fan_speed_pwm) {
>>>    			ret = smu_set_fan_speed_pwm(smu, smu-
>>> user_dpm_profile.fan_speed_pwm);
>>> -			if (ret)
>>> +			if (ret != -EOPNOTSUPP)
>>>    				dev_err(smu->adev->dev, "Failed to set
>> manual fan speed in pwm\n");
>>>    		}
>>>
>>>    		if (smu->user_dpm_profile.fan_speed_rpm) {
>>>    			ret = smu_set_fan_speed_rpm(smu, smu-
>>> user_dpm_profile.fan_speed_rpm);
>>> -			if (ret)
>>> +			if (ret != -EOPNOTSUPP)
>>>    				dev_err(smu->adev->dev, "Failed to set
>> manual fan speed in rpm\n");
>>>    		}
>>>    	}
>>> @@ -2218,18 +2218,19 @@ static int smu_set_fan_speed_rpm(void
>> *handle, uint32_t speed)
>>>    	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>    		return -EOPNOTSUPP;
>>>
>>> +	if (!smu->ppt_funcs->set_fan_speed_rpm)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	mutex_lock(&smu->mutex);
>>>
>>> -	if (smu->ppt_funcs->set_fan_speed_rpm) {
>>> -		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>>> -		if (!ret && !(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>> -			smu->user_dpm_profile.flags |=
>> SMU_CUSTOM_FAN_SPEED_RPM;
>>> -			smu->user_dpm_profile.fan_speed_rpm = speed;
>>> +	ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
>>> +	if (!ret && !(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>> +		smu->user_dpm_profile.flags |=
>> SMU_CUSTOM_FAN_SPEED_RPM;
>>> +		smu->user_dpm_profile.fan_speed_rpm = speed;
>>>
>>> -			/* Override custom PWM setting as they cannot co-
>> exist */
>>> -			smu->user_dpm_profile.flags &=
>> ~SMU_CUSTOM_FAN_SPEED_PWM;
>>> -			smu->user_dpm_profile.fan_speed_pwm = 0;
>>> -		}
>>> +		/* Override custom PWM setting as they cannot co-exist */
>>> +		smu->user_dpm_profile.flags &=
>> ~SMU_CUSTOM_FAN_SPEED_PWM;
>>> +		smu->user_dpm_profile.fan_speed_pwm = 0;
>>>    	}
>>>
>>>    	mutex_unlock(&smu->mutex);
>>> @@ -2562,60 +2563,59 @@ static int smu_set_power_profile_mode(void
>> *handle,
>>>    }
>>>
>>>
>>> -static u32 smu_get_fan_control_mode(void *handle)
>>> +static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
>>>    {
>>>    	struct smu_context *smu = handle;
>>> -	u32 ret = 0;
>>>
>>>    	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>> -		return AMD_FAN_CTRL_NONE;
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (!smu->ppt_funcs->get_fan_control_mode)
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&smu->mutex);
>>>
>>> -	if (smu->ppt_funcs->get_fan_control_mode)
>>> -		ret = smu->ppt_funcs->get_fan_control_mode(smu);
>>> +	*fan_mode = smu->ppt_funcs->get_fan_control_mode(smu);
>>>
>>>    	mutex_unlock(&smu->mutex);
>>>
>>> -	return ret;
>>> +	return 0;
>>>    }
>>>
>>> -static int smu_set_fan_control_mode(struct smu_context *smu, int
>>> value)
>>> +static int smu_set_fan_control_mode(void *handle, u32 value)
>>>    {
>>> +	struct smu_context *smu = handle;
>>>    	int ret = 0;
>>>
>>>    	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>> -		return  -EOPNOTSUPP;
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	if (!smu->ppt_funcs->set_fan_control_mode)
>>> +		return -EOPNOTSUPP;
>>>
>>>    	mutex_lock(&smu->mutex);
>>>
>>> -	if (smu->ppt_funcs->set_fan_control_mode) {
>>> -		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
>>> -		if (!ret && !(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE))
>>> -			smu->user_dpm_profile.fan_mode = value;
>>> -	}
>>> +	ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
>>> +	if (ret)
>>> +		goto out;
>>>
>>> -	mutex_unlock(&smu->mutex);
>>> +	if (!(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>> +		smu->user_dpm_profile.fan_mode = value;
>>>
>>> -	/* reset user dpm fan speed */
>>> -	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
>>> -			!(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>> -		smu->user_dpm_profile.fan_speed_pwm = 0;
>>> -		smu->user_dpm_profile.fan_speed_rpm = 0;
>>> -		smu->user_dpm_profile.flags &=
>> ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
>>> +		/* reset user dpm fan speed */
>>> +		if (value != AMD_FAN_CTRL_MANUAL) {
>>> +			smu->user_dpm_profile.fan_speed_pwm = 0;
>>> +			smu->user_dpm_profile.fan_speed_rpm = 0;
>>> +			smu->user_dpm_profile.flags &=
>> ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
>>> +		}
>>>    	}
>>>
>>> -	return ret;
>>> -}
>>> -
>>> -static void smu_pp_set_fan_control_mode(void *handle, u32 value) -{
>>> -	struct smu_context *smu = handle;
>>> +out:
>>> +	mutex_unlock(&smu->mutex);
>>>
>>> -	smu_set_fan_control_mode(smu, value);
>>> +	return ret;
>>>    }
>>>
>>> -
>>>    static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
>>>    {
>>>    	struct smu_context *smu = handle;
>>> @@ -2624,10 +2624,12 @@ static int smu_get_fan_speed_pwm(void
>> *handle, u32 *speed)
>>>    	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>    		return -EOPNOTSUPP;
>>>
>>> +	if (!smu->ppt_funcs->get_fan_speed_pwm)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	mutex_lock(&smu->mutex);
>>>
>>> -	if (smu->ppt_funcs->get_fan_speed_pwm)
>>> -		ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
>>> +	ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
>>>
>>>    	mutex_unlock(&smu->mutex);
>>>
>>> @@ -2642,18 +2644,19 @@ static int smu_set_fan_speed_pwm(void
>> *handle, u32 speed)
>>>    	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>    		return -EOPNOTSUPP;
>>>
>>> +	if (!smu->ppt_funcs->set_fan_speed_pwm)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	mutex_lock(&smu->mutex);
>>>
>>> -	if (smu->ppt_funcs->set_fan_speed_pwm) {
>>> -		ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
>>> -		if (!ret && !(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>> -			smu->user_dpm_profile.flags |=
>> SMU_CUSTOM_FAN_SPEED_PWM;
>>> -			smu->user_dpm_profile.fan_speed_pwm = speed;
>>> +	ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
>>> +	if (!ret && !(smu->user_dpm_profile.flags &
>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>> +		smu->user_dpm_profile.flags |=
>> SMU_CUSTOM_FAN_SPEED_PWM;
>>> +		smu->user_dpm_profile.fan_speed_pwm = speed;
>>>
>>> -			/* Override custom RPM setting as they cannot co-
>> exist */
>>> -			smu->user_dpm_profile.flags &=
>> ~SMU_CUSTOM_FAN_SPEED_RPM;
>>> -			smu->user_dpm_profile.fan_speed_rpm = 0;
>>> -		}
>>> +		/* Override custom RPM setting as they cannot co-exist */
>>> +		smu->user_dpm_profile.flags &=
>> ~SMU_CUSTOM_FAN_SPEED_RPM;
>>> +		smu->user_dpm_profile.fan_speed_rpm = 0;
>>>    	}
>>>
>>>    	mutex_unlock(&smu->mutex);
>>> @@ -2669,10 +2672,12 @@ static int smu_get_fan_speed_rpm(void
>> *handle, uint32_t *speed)
>>>    	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>>    		return -EOPNOTSUPP;
>>>
>>> +	if (!smu->ppt_funcs->get_fan_speed_rpm)
>>> +		return -EOPNOTSUPP;
>>> +
>>>    	mutex_lock(&smu->mutex);
>>>
>>> -	if (smu->ppt_funcs->get_fan_speed_rpm)
>>> -		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
>>> +	ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
>>>
>>>    	mutex_unlock(&smu->mutex);
>>>
>>> @@ -3101,7 +3106,7 @@ static int smu_get_prv_buffer_details(void
>>> *handle, void **addr, size_t *size)
>>>
>>>    static const struct amd_pm_funcs swsmu_pm_funcs = {
>>>    	/* export for sysfs */
>>> -	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
>>> +	.set_fan_control_mode    = smu_set_fan_control_mode,
>>>    	.get_fan_control_mode    = smu_get_fan_control_mode,
>>>    	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
>>>    	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
>>>
