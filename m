Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FBEC982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 15:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A15D10E919;
	Mon, 21 Sep 2026 15:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6Xn/Etp";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013066.outbound.protection.outlook.com
 [40.107.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE5210E914
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 15:43:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK4dAvHo1pZ2o4rwhHiXapTLSHnYS/N9wHYIRTo9hZJC9fxegno/GEkDXvifzY7RF9r3/2YhCQ8h0FQjY/0yYnUTzqWnsqNx0EbpNQuOLWyO5+sk8CFs7+G/Fu10ty1A11EMr3Tov/KbtYcL7ZaicVq5lypaUE1acxvSefTr25YIvRA/laF3P1UCdKXX2KVMZlohqyfXCAiFc9WabwBFuTqrciUq4RmkvhA+nyEJqdYzYwddMiEBuhIiVwiKYja4wWi9e0QlxVEqExfzrU6BYi6zd7KLHotOIpICLBpV4M8BPe0qDV12kN6ViYuN/3EiQJEBhgH9Q+S7x8qi+DrRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kyl2fZGKufcwlhqe/6zpzrTNjqLZxajvUApUtrUVnGM=;
 b=XFZud1qaDSuEl0/X69Nol3DTP/JtQ85+RH4Pia5FhTYtoNOY5PYGJ5XjXSOucGZdLKHGQ3jxC/HsTTIll2huFC3cDy6ZpOT6KBqUel45zgVpHSThKuKzwg8II38afQntaqOlJJmgO5z5cOSMyqxRTdC3sqzK5KVaZ5GwETsl0jgmWL1KlcBwFg3q58CoGaifc305WTFR4zHQUXkn/b25DjYAvU7sWz1XOUjgWoNLvsK2GSOV+BrsDFZ5MwtirP9L4b+XvlhNzSxSh/G48tBpX7gS8o179Sv2lm0gT5H+ZY/UJe6Vdd0E600pVizNSuoOv6mI5i9ISCYSmI1mutXRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kyl2fZGKufcwlhqe/6zpzrTNjqLZxajvUApUtrUVnGM=;
 b=A6Xn/Etpzu2vt88lbNwqj1x5bvZIJTyS6dvHZJrdvZKYDBwnFVA2SMV9uKlN0cHVISxIPTeKpLpUpmpX3dGiRAc7bRcTv991CxYdLMUr3H9Lb2/iPs/LF9DZBAnSs0BOlq0vr4Yjm3z5znKx0mDPfx5ANg4E04lsgtyfdU7qekU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 15:43:34 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 15:43:34 +0000
Message-ID: <a6811dd1-d8aa-4009-b571-f4ab1327e5ed@amd.com>
Date: Mon, 21 Sep 2026 10:43:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix fast updates on DCE6
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Leo Li <sunpeng.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>
References: <20260921104136.23990-1-timur.kristof@gmail.com>
 <bf98fdda-fc0b-45d5-830a-df65bef804e6@amd.com>
In-Reply-To: <bf98fdda-fc0b-45d5-830a-df65bef804e6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0PR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:510:4::21) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 104c5623-b514-4e23-5768-08df17f71831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: zCFbReRxlD4MWr1nzTtu67OJdHxmSxNflcMOPYiKMFUukyErAsIgRUfraKo18TJ2ZHWx+RLh8Vi0ywJc05hBlM9/2vRjD86S4vIACoFEWe2giudGAH8FPLsRVWlmwJmc7GENz+XHZwG0G1TvQDNCci3yLh9JBNzSQ02yVD2jz11YLawi9pInElvMcCkiDYyfYOalJkJeI8tRwZdYPwtdJe+E+f1txKwpcPWIgbRweXEfTeIZqE87dNP/CsclKH/DVOKlLbPy0qQhzVyMGZ238SYPG6MYzNwQVkuvWV/7AqzHRqrNSgF8Vnz+2B3tDp52v4KKtU2leyZHl26yoD4OJLYtFfJjo1qNtTtFXkRBQUvnOffmf4RBg5Ip9/ZfV/6tWFnsiM9Vru253nAvSws4Syq/zx3Z7vHyoASyOtAdslYRdEuzleQ4QgpKfUOEydFVxDz1/b6ckfejRVtRxvRpvNTBuJzBuvwwmq2FB5mQNKEOibH/b1zWKI1OHCvjPbjDdhocuBWJsQnYqk+oPINhJ0W+Cvc1eXh5rZ3ZOYHxr2Ss2mRDTvk6b360jCLetdXkA9z48q+zaZeylhB3DOGyE08wCcez7MegyuYghp5IRmddztxCXL6qI74pe7baxsfjkScsxN9y6hkC/pvUzq+YGM13mEzG4ZH9LO0tarxW89yXQNNY1ola3EyZMvKvBAH+Y8c4LWbNMkJoc+ADd0raig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0RTRm5KOXpNQ2JOR04rbkx5c0w5UU5yN3hjbXVvdjhDRWJZc1ZrckxBTC9h?=
 =?utf-8?B?UGJMQmZnaUZtOCt4cWJWcDVxL3BFeWdNdjJqcUhYN1FNNTVMNEdVRjd6YTdz?=
 =?utf-8?B?MW93elB5RXYvSlN5TmJEbWhTZkNEcGxQbGw1R0svUHFFZi9MSm1PVEVZNTBa?=
 =?utf-8?B?L3NkakJTenAxZ205bUpVMWVoZkw0SDlRVkI1NjR6SXJhWnFpLzRXWUdRZXEy?=
 =?utf-8?B?M1hrcHY0NkNvS2EyTTZPREloYitSNEdvNmN6WUZWWExaTEtGZXdIOEd0Qncv?=
 =?utf-8?B?cnBWSFI2eVBNaGlIQ0h5MCtDT2hnY0hlWklVQzQvR0IvWGM3QW43QnpLVWZO?=
 =?utf-8?B?TDBsVWQ5RFJkb0c0UlZBVmlLT3Z4cXdzbXNYWEgyOHM1MHBMZndWYWRzUlBa?=
 =?utf-8?B?dzd6aHVuY2ZmOXkwYTdtMkFsamppMWYvNVZzSGZjekdZTXBwdkVORDN3S2hU?=
 =?utf-8?B?WUVpOUJrUmExS2V6S1JBUHlFUkZBWDA5VUhrc2ZWYmFYT1l3VmpTMEwxQjVs?=
 =?utf-8?B?UjN5amVVUlVTUzd4aUVCY1pST250Ulo2dVBBN0RkZzF1MktsR0JCbnl0UU5X?=
 =?utf-8?B?YVFkSU4vMFVNaWFTbzNzVTM2UFY5WmVpcDdVa0lKQWtGaW9uQ2pUcVA4SUpv?=
 =?utf-8?B?ZHFJa2kwdmNmMzVKSG84RjFaNXBUaXlVYlBNamNxZ3B2d0RQVy9xS29Scm41?=
 =?utf-8?B?NVVpdDhKL29zNmU4RnRSYmwyMlQ1clpGY1U5T2pYQWJJUTlMTkxqRk1xOVFs?=
 =?utf-8?B?bmI3KzlyamtHV0k5ZldrNlNYdEZWdGE4RFdNeHdvN1dvMTE5WVR1R0hLZFpF?=
 =?utf-8?B?YU10NEdTQWpoWFVvOGtrOGdEN2JSTUJFOG5Wbk1leUkzZGZKcGFrL2tBVDlz?=
 =?utf-8?B?WU84V1Vza2xrVHgrWCtQaXNtaU9JcUdFTkczdnlMUFRVaTBUV0VDRTlXR2xQ?=
 =?utf-8?B?THh1aVQ0cmNTSGRlQ2RNWm4raWNWSVdpcmVsNU0zMmhheTVtWk1VVnU1b1c3?=
 =?utf-8?B?dkJVeUdLNWdRWEFya3dtSVF2ajJMZEFiUGFsWXVBK0VZTFFzU3ErY2Y2MkNW?=
 =?utf-8?B?RWZrNmJkZ3hpVFRXalp6Tjl2dXl5VDF0TTNWYmFlZWpxOTBxNnAxUXI5dWZI?=
 =?utf-8?B?RktEYWJSLzFDME1LRWdDM3ByQVkxK0RUa3F0dGRhbzNZdFU0bFVFT2lPSjJC?=
 =?utf-8?B?SU9xMGNab1h4VXFPQy9wY0k0aUFzZ2tzYS8wUk1pbUt6aXZNTy9SaVpobG9u?=
 =?utf-8?B?eG4wWWRHVlpnanhIYWFkcWVka0JobWhPZ1JiK01WbDhsMFFiZE9LcXBxMSs3?=
 =?utf-8?B?bk9aYm9XMEtvWU5LWHYzL0VOS0JSckZpWFJsWkt0dmE0TjYyQkFTdmh1MHVn?=
 =?utf-8?B?QUlmeW0xRFpvbnRPdnBwdXZqRkVQVmszSkdCYlE4QzJrcklWcElncjFabG5o?=
 =?utf-8?B?M0ZNdzY0enMraldNcU5PVzYyTlhhQ0JSUnJYMGxUZC95bkgyV3BlaUhrQ3dn?=
 =?utf-8?B?UjA3eE5nZ2g2TS9yNXBrUnRmN3RUL0tIM3VwMndQZXZhT1pxRmgxdk41ZUo1?=
 =?utf-8?B?OCtQWld6M0kwNTB6K21PZWZVVkt6RVNBQkVGU3M0VS9LWXJPRFYrVDNobkht?=
 =?utf-8?B?TTlhc21pTHk3Tm9La1h0VEM4SnNaaW15T1R3M2x6c3lkQUhuV3d4eEJ2dEo3?=
 =?utf-8?B?WXowSk1JY2JXdXBtVGhhbjlVOExpeitZMzJ6TjZvdHpybUhkV3VaaUwwOFh2?=
 =?utf-8?B?Tk50WWg4WEN1SktGMEtXVVNoOE9UQnZxbFk2Tk84eXFoUWlDZmZ1b2lhYnds?=
 =?utf-8?B?RGRYTDlNb21udk91TFgyM2VHSE1SazVrWVBTK2NVd1NMWlRLbGFVc3NqS2Rw?=
 =?utf-8?B?RmRqa1ZMWjlQOXErZ3FRU01CbzlkV0dtY2xLd2MzVW5XSVZIQ09INE9mb0Ft?=
 =?utf-8?B?UW1pS09PWEpSTlBBSytvNXVTZnhGSllibW9JNlY2c3RacjYxTDUzRnVYZU9E?=
 =?utf-8?B?ZHhZaUREZkM5TjVscmtiTExKYjdhajQrSkl1eXRTUzZNUXBNN3JwSHQ4TjJB?=
 =?utf-8?B?VjAwRU11Vm9GTlF3NXk0TjRwY1BpNGdncDc5Q2VpNjhJcENodllhQXNuZ204?=
 =?utf-8?B?OW5XZ2R5NU1uZU8xdU1yamVjZURjdGQwa3BCWUh4c05ybVUxVzBUZmttamVu?=
 =?utf-8?B?QmZPMTZobWMzV0tibG5xMVFvTVhTZGJtb1NlcmU2RlVuMUpPaytCalhjZU5I?=
 =?utf-8?B?WG5OREhZK05FV1hITFlmUzhka0tMWjVobTUwdnBQRUtoeEYxazZLSDNaSElU?=
 =?utf-8?B?NmZDdU4rSm1rOGgzTmdYQ2cxY3hmMzByN2FWME1WNENtd3pCQVpjdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104c5623-b514-4e23-5768-08df17f71831
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 15:43:34.1898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVUbk52VIAH22W3ZOiEbL/y3FJDVtvczDUdTvTjlzP3neIG5ItpoiO3NERhlWf2i+A1tkmkZXDYiFFEk0jMPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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



On 9/21/26 10:33, Mario Limonciello wrote:
> 
> 
> On 9/21/26 05:41, Timur Kristóf wrote:
>> DCE6 should use legacy fast updates, just like all DCE8 - DCN2.
>>
>> Technically DCE6 should have been included when the fast update
>> code was refactored, but it just happened to work until now.
>>
>> A recent commit "Attach only plane updates that actually changed"
>> has exposed this issue because with that commit, DC accidentally
>> took the new fast update code path for DCE6 as well, which caused
>> it to boot into a black screen with a flip done timeout.
>>
>> This fix should be backported to all kernel versions that
>> have "Refactor fast update to use new HWSS build sequence",
>> but this patch won't apply cleanly to older kernels due to
>> another refactor in "Remove dc param from check_update".
>>
>> Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new 
>> HWSS build sequence")
>> Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from 
>> check_update")
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>> ---
>>   .../drm/amd/display/dc/resource/dce60/dce60_resource.c    | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/ 
>> dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/ 
>> dce60_resource.c
>> index d2d56a1c4b8b..f4efa55952f3 100644
>> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
>> @@ -448,6 +448,12 @@ static const struct dce_abm_mask abm_mask = {
>>           ABM_MASK_SH_LIST_DCE110(_MASK)
>>   };
>> +static const struct dc_debug_options debug_defaults = { 0 };
>> +
>> +static const struct dc_check_config config_defaults = {
>> +    .enable_legacy_fast_update = true,
>> +};
>> +
>>   #define CTX  ctx
>>   #define REG(reg) mm ## reg
>> @@ -937,6 +943,8 @@ static bool dce60_construct(
>>       dc->caps.max_cursor_size = 64;
>>       dc->caps.dual_link_dvi = true;
>>       dc->caps.extended_aux_timeout_support = false;
>> +    dc->debug = debug_defaults;
>> +    dc->check_config = config_defaults;
>>       /*************************************************
>>        *  Create resources                             *
> 

I would be remiss not to share something the code-review agent flagged 
when testing this for merge.

---
Incomplete fix: this is only dce60_construct(), which 
dc_create_resource_pool() uses for DCE_VERSION_6_0 (Tahiti / Pitcairn / 
Cape Verde) only.

dce60_resource.c has two more constructors that are reached for the 
other SI parts (see resource_parse_asic_id() in core/dc_resource.c:150-158):

dce61_construct() (line 1120) -> DCE_VERSION_6_1 (Hainan)
dce64_construct() (line 1318) -> DCE_VERSION_6_4 (Oland)
Neither gets dc->check_config assigned, so enable_legacy_fast_update 
stays false there (dc is kvzalloc'd in dc_create()), and both keep 
taking the new fast-update path that ac8349780c5d exposes. They should 
hit exactly the same black screen / flip-done timeout this patch is 
fixing, since all three share dce60_hw_sequencer_construct() and 
dce60_res_pool_funcs.

Suggest adding the same two lines to both, e.g. after dc->caps.is_apu = 
true; at line 1144 (dce61) and line 1342 (dce64):

dc->debug = debug_defaults;
dc->check_config = config_defaults;
---

I'll hold up the merge to decide what to do (we can just have a v2 if 
you want).
