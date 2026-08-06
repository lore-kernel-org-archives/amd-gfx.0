Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C79C55ABF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 08:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE1810EE30;
	Thu,  6 Aug 2026 08:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="13+/zwr/";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013032.outbound.protection.outlook.com
 [40.93.196.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7513610EE30
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 08:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSSWw3lDUo2LRo7p+Kw/ZzcAkNkjJNY24hbdKphIUUD8lbSrxa4jkK7hwzs7SdUU8EocRLIvts77eROqKO/yEJQmZZRSGSc2rGS5iXRQ6WCTtB7VxEg5ICuf1+26LDP3pZt/ny/ajRncz0cPDiXFLxdIjEpGplLcLECZpAbJmI+s/j3vO9uVjBEbj/pLJPOt+xeooLcMXrxIrRylDHEmaKQ11GiW64J7EkRJLXUlc2H9ptuBUmTEDihGllCyQq2uCIljnuOYZYTzDv0Nbyybvk/DPs1aJze2yYzZyshYtegVmzFQxBqI50dOv7hXWQq6ks6PXh1EuYclHpAhX5oVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avnO08pCMo6rxWCHtzqwSp1Tck0dI+NRAljkF2/di5w=;
 b=IZWJ/e6c71WUtD8Ex6vvnNoaJN2wcHwMEkA6xzbcnTmSgD0XppoGqhSGPdCdz6iI0beN0R5JFeXINH/K14XiDeTEacfo96DPmPS7U4RYytF5Cnv9T5JrBdq9I8xWpGXggZFdW2z37OexIjyG9rIaSJ60ZNjpFfH49sWxTkpTNlUAqIJkKWcwSUmT9NHzF1XhScNL3joktLB4qsyy3Unw/3iIGuOenGMIT6ztvIEigT4hV14FAvRJtrJIhBS7uJpbNVOTveWiFkr8o+D7phE3lRdvPQC+UYmh1YDKedPJTJ97Wq9GLnUOpMM1HnaEXoosC5o1pcs1PnTcGs9zygoOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avnO08pCMo6rxWCHtzqwSp1Tck0dI+NRAljkF2/di5w=;
 b=13+/zwr/exVuZ45BTBD5aZ9fr4/dtMnOLGGLW44htJLM7AJXHYB0/t1jWOSaYfJC9oAaD4E2cYHxys8qjcQ3PAqsypoLT/ffjRvVyX4PaZq+ygYKi90Zlp0RugezMMqAgohgYBYuw92VKcGdVtbySEhayziI5S/3zOL2TbS9aS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 08:02:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 08:02:36 +0000
Message-ID: <bb56d0f5-52bb-4757-856f-c22b4bbe363b@amd.com>
Date: Thu, 6 Aug 2026 13:32:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Track current PPT limit for restore
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20260806061413.3720389-1-lijo.lazar@amd.com>
 <BN9PR12MB52110CD725737790A39A3E8682D22@BN9PR12MB5211.namprd12.prod.outlook.com>
 <024580be-2d0c-4ceb-8155-c276c63e0d4c@amd.com>
 <BN9PR12MB5211B0562AA983BC39E5A66282D22@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB5211B0562AA983BC39E5A66282D22@BN9PR12MB5211.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::20) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: b3631d9f-3d7f-48b0-952f-08def39113c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bn/aoxz6N48eVTvzma1Fuvt6VyD64dWNbULUqsbWO+hfueBAfNjCS5PfWyB2wiIbVxhYnzch7kFC3tGFuEkjvwkLK4UfyqtA4Frx7T8/2U/FEoa3M7b5wUzqK5kBlyACXHqix676+QWU3LcCKRznAQzxAWiCwD5C9g6GRf165KJ+/5CBaRrxJqWhVL1YT3LHe8ANSBIZ833EUoYTkez/HfHDhibBTTxttOKaywGdOQHSjJ/ZOSNQrGIiD5bJNS+4RJxc08F7irnn2yfr3hBftr1EqQlyvKjqCiQdmIjjDBDrrdPMCqt6FYiob2+zyfmlvXa8+0ug547lNawz9i/qqn/bk/8rbByPVfyPjIPec07U2HyAKzNcFucfF7whpUTwOi/T3V7H2UQol9hyMA1DWUo5ALNZsss26/UcDrRNhEdrEhLrCccrHnFV0tNWCrDTqB3Mn1oO98o4djWJ/jWStFUp3syfUr8Fw7IWh6Q1WpUWVvZ1ygUBYaoF5Lg6G77z6l58jFSdSUrcOi1kvGSt2KfIX/ot8DmwVPwlC3ik3JZ9Qo+KJMB6k5nPCl9fJ4nEw/JiyHAeXwDbu+5Ot7l0uLI9F8k0aYhzg4ltiqCp+2ouYulwATTttx5n1kMxYqnGG6CusR2GUzIgfu3XGN3cIqojf701JNI8Qu1aT2POPG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?andPa29oTkVKamIwaE0xak9hL1dVSlQ2bmxTVGUwWEp0bkVwVTBoRCs5L1RX?=
 =?utf-8?B?K25kVG5PNEJtV0tIdThETDV5a0NlSXR4MC80OFVzVytIUjFoZmZXRlJGeFVW?=
 =?utf-8?B?S1FtTkFqcVE5TGM4VWV3VWhqVVo5TklKLzBrenNjWlQ1RXpQNFgxb0hhck43?=
 =?utf-8?B?d29rcGNkeGt3QVh6ZFNPaDlKWnVCVTREellYemxmZEVBVnVXSkkreHN6akJI?=
 =?utf-8?B?ZlYwT1V4MDFYKzNPODdVb0VuK290d0s2bHJ4bmJ2Z0JlVGxjU1J5YWVybVBr?=
 =?utf-8?B?RXg3eFlTZzlweFR4UGdnUVdLblR5UXBTRnF6enBrWm5Dd1hHZ2hYUVd2Tmhk?=
 =?utf-8?B?SFU1MVZ6UW5sSHI2MWFicExvNHpqZ1ArOGRFTmVNMHB1bGUySmVONlpuc3lp?=
 =?utf-8?B?SzNocWlHZmJSMEY4L2lrVmdCMU9XelFnUjJpTVI5Nm82OG5wN3U5dFpiUGM5?=
 =?utf-8?B?SENqallBRmd0Tm9nd3U4S21IdStaYkNqbEp4MHl0bStyRjI3VDN1SzlPb3Nz?=
 =?utf-8?B?MVFOelJnWXZHaEZkQ2x0Uk43QzJicFdkZWxIdThRZi9aSmxIZmpwdFJ3cllu?=
 =?utf-8?B?QUJNU1FiQmE4YTVuR0pWdzVVZjNTQW1CVXo5bENsN0IxRlhuYXZQYU9oOGYz?=
 =?utf-8?B?NUVpeUNUSi9CSm1sM2sxSjlaVTRFZDROb3VJM1hvUEE5YlpZRDEybGV3SldO?=
 =?utf-8?B?ZkdEUHVKYTFLalRtVGtBdWRaSVlqMWFqMGk4ZGxrVmpYY2VCWTgyWmFWRjNF?=
 =?utf-8?B?UEdUT0NLSFAxMTl4NGF1RVVCMXM5SVBmRDViRFFiczZOMGtUY3g2OG5XblVl?=
 =?utf-8?B?czVhQkw2QlVpd2t0OGMxaHFWRlh1MW1ldkkwd3VVd2tneUJTWWpJVjYzVTgr?=
 =?utf-8?B?K3FwWDdWWWVsQUNDNXNnNGwrL3FDMHhLajJtKzQ0N0tjMzhTM2twL0h2d1V3?=
 =?utf-8?B?R01mT1hBdjlOeXhpUzZRQVN0ME5JT0dVWnhyYlhsZDVxSFBHcGNCWTBJSE5W?=
 =?utf-8?B?b2s5dTJqQWF0TjYxQ0V3OXRXT2IydGRKVm5ZSENXUVZPSjlrUXc1OExNdHFP?=
 =?utf-8?B?aG5JUC8rVjNRRHpnZWRuT2x0d0k3YWdUcHc4UHNCUWtBSVlFNzFmbmU2TVVR?=
 =?utf-8?B?NlVrci9Fdm5jWk40dGJKVzBDZ05tbHFOclF2d1BTSVpwU1pTQTZVVVhxRkFi?=
 =?utf-8?B?emM4YjA2Z1lvRGI2RFpGZXBhSjU4cGFBZWozc3ZJejlLaXpuUWZScmluSmt3?=
 =?utf-8?B?d0JFaFltYW9EYUltRlZjOXQ5QkJGc3VOS1BsRXRqdEFra1JqR3V6M3lvdHh2?=
 =?utf-8?B?V2pndjVpL204WUIySGlPY2JCRGpLcXdFNkRsV2w0RFozQzNhdWlzV2VaVWdj?=
 =?utf-8?B?VDc2ZUtLOUt1aFJsalE4WjJTa0E4NFh6NlBhdDFlTVFyc2VHZnJzdDV4czUv?=
 =?utf-8?B?S1ZGMitQVndDR2dER0VSaHlwa25OSEF0QzZidDdub3JmMHgvdUpEeWJlMWlr?=
 =?utf-8?B?Z0xpRUUxU1IvTGZtTm5RZ1ZMM3pDZGU2UGk3RmhuZVdkOURFY3IwRzVTSXlK?=
 =?utf-8?B?VUUxRkM5QlV2KzFpTENUWThXQW9RN29pNzlvMFN6NHd0QkdOQVJ6Y1RXa0VQ?=
 =?utf-8?B?cERkTXJZYjBweFZiMk1FMmV3N3UvWG1OYW9ISUhoTmZyWnZKenZRTmFjeGVv?=
 =?utf-8?B?MHBVTW1HTTdMVUhOTTZUYnNDalVjVnF3R01kcS9KcS93dU1wbTZhR0ZYbm9Z?=
 =?utf-8?B?QnA5cURaSlQzZkNLZlZlekt2VFV1d1Q2Ui9STWZZeG9EVzZhdlBHUjF6c0g5?=
 =?utf-8?B?Z0hhOGFwb085cStSQ2pBS3o1OEtscnRqa1VheGlMbUIweVJHRko3NnRJNWxv?=
 =?utf-8?B?YXpGanI2Y3pXbmkwWERSRmlBWCt4d2NveUpPTkN2RGxyZ1FHdFZ3a0pnVDNB?=
 =?utf-8?B?U2k1RldiMk5SQzRrMUJ5d0JFaVY4Ylpma3g0ZzRvZ0t4YlhVMlMzR3VSWXdW?=
 =?utf-8?B?ZnNsbnZXaSswdHhQMVJvT3ZIQzJyenhmdXJHclpGaHZvWlpjL2VWUWFxd1l6?=
 =?utf-8?B?ZGJuZ2hvQ2VGYlR3Q2tJMmE2SVJ2bm13UzlCS2d3bFk1MWdQVDJxdG9LQUUw?=
 =?utf-8?B?TXlGRXU2bFdSaUNGV1JPbDBSQTdCV3kxcTA4aXlPNmd6TEMxcm9vVmdkSEcy?=
 =?utf-8?B?bnM4aU9TNUVuWWhDZVBXaHM4T2VGRE5vd2Vua0YrdTY5ZlFmQTd0N2hmKzkw?=
 =?utf-8?B?bFh4RWhSd1FJZytWcjVGUU51QWZ3ckZRQndONWhhYlQ3cUtlZ0dPTDE4aytG?=
 =?utf-8?Q?nTciLuajtJK4FeeXwv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3631d9f-3d7f-48b0-952f-08def39113c2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:02:36.2306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdrqv96Bg2IvQLjuT/CK2j/pB6Y6I+aGReV0BautJt94Jgwcwx4WvPMBAfi+ks6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
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



On 06-Aug-26 1:26 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
>> Driver triggers resets which could relaod the whole FW. In such cases driver
>> remains responsible for restoring the last known power limit. The current
>> method doesn't do that.
> 
> No, the original code already contains this restore logic, include suspend/resume + gpu recovery, and save/restore logic has been verified on Navi21 and Navi48 ASICs.
> 
> And the if no user edit power limit from user side, the driver will skip restore power limit, in this case, the driver will use default value after firmware reloading.
> 
> btw, your change will break gpu od + power limit logic in navi3x/navi4x.

This patch doesn't break that. Whatever user has set as the last limit 
will be the current limit in Navi3x/Navi4x case. That will be restored. 
If user hasn't edited limit, current limit will be equivalent to default 
limit and then it's not set again.

> 
> So What issue you have facing now ?
> 

Driver remains responsible for restoring the state triggered by inband 
actions like suspend/resume or reset as OOB doesn't monitor everything. 
In such cases, driver being the inband owner needs to restore the proper 
state after the event.

Thanks,
Lijo
> Best Regards,
> Kevin
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 6, 2026 3:48 PM
>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: Track current PPT limit for restore
>>
>>
>>
>> On 06-Aug-26 1:03 PM, Wang, Yang(Kevin) wrote:
>>> AMD General
>>>
>>> I do not agree with adding a read-to-cache path for the current PPT limit.
>>>
>>> The current limit is PMFW runtime state. A read of that state must remain an
>> observation; it must not implicitly create or update driver-owned persistent
>> policy.
>>> This separation is intentional: the driver keeps immutable capabilities from
>> the PPTable and restores only limits that it successfully programmed itself.
>>>
>>> Caching a value returned by GetPptLimit would turn a potentially transient
>> or out-of-band PMFW state into a value that the driver replays after suspend
>> or reset.
>>>
>>> There is no ownership, notification, or synchronization mechanism that
>> makes such a cache authoritative, so it can only become stale.
>>> and the existing user_dpm_profile policy *CACHE ALREADY* handles the
>> supported driver-owned update path.
>>>
>>
>> The existing path also doesn't have any synchronization with out-of-band, so
>> the same argument holds. i.e., it overwrites whatever set by external source.
>>> If no bug fix or feature improve, please drop this patch.
>>
>> Driver triggers resets which could relaod the whole FW. In such cases driver
>> remains responsible for restoring the last known power limit. The current
>> method doesn't do that.
>>
>> I will add a bug fix tag as the previous patch doesn't restore the current limit
>> properly.
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Best Regards,
>>> Kevin
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, August 6, 2026 2:14 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>;
>> Wang,
>>>> Yang(Kevin) <KevinYang.Wang@amd.com>
>>>> Subject: [PATCH] drm/amd/pm: Track current PPT limit for restore
>>>>
>>>> Cache the applied PPT limit in the ppt limit range and refresh it on
>>>> every get and set. Initialize with the default value on fresh load; a
>>>> value equal to default is treated as unset.
>>>>
>>>> On suspend or reset recovery, restore the cached current limit when
>>>> it differs from the default, falling back to the default otherwise.
>>>> This replaces the user- mask based restore, covering limits changed
>>>> outside the user profile path as well.
>>>>
>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39
>> +++++++++++++----
>>>> --
>>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>>>>    2 files changed, 29 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> index f45cd4e31415..7edd919a7832 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> @@ -495,16 +495,11 @@ static void smu_restore_ppt_limits(struct
>>>> smu_context *smu,  {
>>>>         enum smu_power_src_type power_source;
>>>>         struct smu_ppt_limit_range *range;
>>>> -     uint32_t restore_mask;
>>>>         uint32_t limit;
>>>>         int i, ret;
>>>>
>>>>         power_source = smu->adev->pm.ac_power ?
>>>>                 SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
>>>> -     restore_mask = smu-
>>>>> user_dpm_profile.ppt_limit_user_mask[power_source] &
>>>> -             smu->ppt_limits.supported_mask;
>>>> -     if (!restore_mask && !restore_defaults)
>>>> -             return;
>>>>
>>>>         smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
>>>>
>>>> @@ -512,14 +507,14 @@ static void smu_restore_ppt_limits(struct
>>>> smu_context *smu,
>>>>                 if (!(smu->ppt_limits.supported_mask & BIT(i)))
>>>>                         continue;
>>>>
>>>> -             if (restore_mask & BIT(i)) {
>>>> -                     limit = smu-
>>>>> user_dpm_profile.ppt_limits[power_source][i];
>>>> -             } else if (restore_defaults) {
>>>> -                     range = &smu->ppt_limits.range[power_source][i];
>>>> +             range = &smu->ppt_limits.range[power_source][i];
>>>> +             if (range->current_value &&
>>>> +                 range->current_value != range->default_value)
>>>> +                     limit = range->current_value;
>>>> +             else if (restore_defaults)
>>>>                         limit = range->default_value;
>>>> -             } else {
>>>> +             else
>>>>                         continue;
>>>> -             }
>>>>
>>>>                 ret = smu_set_ppt_limit(smu, i, limit);
>>>>                 if (ret)
>>>> @@ -875,6 +870,21 @@ static int smu_early_init(struct amdgpu_ip_block
>>>> *ip_block)
>>>>         return smu_init_microcode(smu);
>>>>    }
>>>>
>>>> +static void smu_init_ppt_limits_current(struct smu_context *smu) {
>>>> +     struct smu_ppt_limit_range *range;
>>>> +     int i, j;
>>>> +
>>>> +     for (i = SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT;
>>>> i++) {
>>>> +             for (j = SMU_PPT_LIMIT_PPT0; j < SMU_LIMIT_TYPE_COUNT;
>>>> j++) {
>>>> +                     if (!(smu->ppt_limits.supported_mask & BIT(j)))
>>>> +                             continue;
>>>> +                     range = &smu->ppt_limits.range[i][j];
>>>> +                     range->current_value = range->default_value;
>>>> +             }
>>>> +     }
>>>> +}
>>>> +
>>>>    static int smu_set_default_dpm_table(struct smu_context *smu)  {
>>>>         struct amdgpu_device *adev = smu->adev; @@ -1911,6 +1921,9 @@
>>>> static int smu_smc_hw_setup(struct smu_context *smu)
>>>>         if (ret)
>>>>                 dev_err(adev->dev, "Error during wbrf init call\n");
>>>>
>>>> +     if (!adev->in_suspend && !amdgpu_reset_in_recovery(adev))
>>>> +             smu_init_ppt_limits_current(smu);
>>>> +
>>>>         return ret;
>>>>    }
>>>>
>>>> @@ -2999,6 +3012,9 @@ int smu_get_ppt_limit(void *handle,
>>>>         switch (limit_level) {
>>>>         case SMU_PPT_LIMIT_CURRENT:
>>>>                 ret = smu_get_asic_ppt_limit(smu, limit_type, limit);
>>>> +             if (!ret)
>>>> +                     smu-
>>>>> ppt_limits.range[power_source][limit_type].current_value =
>>>> +                             *limit;
>>>>                 break;
>>>>         case SMU_PPT_LIMIT_DEFAULT:
>>>>                 *limit = smu-
>>>>> ppt_limits.range[power_source][limit_type].default_value;
>>>> @@ -3061,6 +3077,7 @@ static int smu_set_ppt_limit(void *handle,
>>>> uint32_t limit_type, uint32_t limit)
>>>>         ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
>>>>         if (ret)
>>>>                 return ret;
>>>> +     range->current_value = limit;
>>>>         if (!(smu->user_dpm_profile.flags &
>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>                 smu-
>>>>> user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
>>>>
>>>> smu->user_dpm_profile.ppt_limit_user_mask[power_source]
>>>> |= diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>> index 92658eb3886d..5222b48eba25 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>> @@ -229,6 +229,7 @@ enum smu_ppt_limit_level {
>>>>
>>>>    struct smu_ppt_limit_range {
>>>>         uint32_t default_value;
>>>> +     uint32_t current_value;
>>>>         uint32_t min;
>>>>         uint32_t max;
>>>>         uint32_t od_min;
>>>> --
>>>> 2.49.0
>>>
> 

