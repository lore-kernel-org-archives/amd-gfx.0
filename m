Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D348BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Oct 2022 23:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5883A10E7B4;
	Wed,  5 Oct 2022 23:04:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AF010E7B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Oct 2022 23:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWpTsVoCjmPnpSBKcP/WSgsDf/Cddug4+qjxmJyfMrljbG0F7Mbo3LEncsj8ANCVvdc98eb7Uj4uqkJtv4zi9pVeVgZvex7ZIvb8bAhyvKjSb7o7jObM3VCYv2vweFU00OsBBSmkncHjvrn/03oEGMcWsDn0lKi8tVJtrREGU4sWlcEuxDKmIaIteT4cXQ62YLvy8DrCvZB5iOOVsJIG3ajqqqWwxHqhLihIwD/rJpfru/b92Zn2CcthYePCRM2gyRDZ1R/CJYNq+fT2KFVejFh0j/WOuRlm+PB2oXl0Je5HCx+7ndFtY2v4pJqRYEySRoKrybaD7baO4LDtltTLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/zAxpdtE/YB2WzwUza1yVXfeYZF7nukEV7ZYByYbxg=;
 b=WwTxvYqpkNzx/aqbpHR8uwNYvMPGiePt9SoxZBbCt3vf7nNtacnhybP5Nubs3GZn1BvJ+SFk31hN+ObFrimluRd5cLRfN6umbmw0Wmp/XA8Xm/j3YHdAyv9Ci02U3w6NnwCCh+uXGQ/b6KbBZiqiRiy8ny+QErs4zqP9iEVj4ofMXLT8E1P6G8jdQaB57ZaDmBen97k+aJHnnsM9Z3LV5LUoaq7mHfole6rjJX28qPM7zl93fa0M2IZAqegJEF8qf1gtlKvFwvB1FbdZlCpb31zKJD7dfgld4DF8D+j5IyoMNs+4L/PuQ1Nxg+vhIh3xWyIakp1US4LN7yT0I6VFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/zAxpdtE/YB2WzwUza1yVXfeYZF7nukEV7ZYByYbxg=;
 b=YpgXYh0keswtLHGeBnPmAhVgDdfh3EWOSS0Yb/20ZuPjftbSMj67bAdr1P5RbGVpF57JkR5Ktg4LPiwn/QUJ+ZRIXJVp9WZuPhtZySfmmXZ8TJ42JFxvMp48QI844t+gGHNrTDl6Tv0Y4jPuXcFwS9vebzqyisTit7HkLz79nAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.15; Wed, 5 Oct 2022 23:03:57 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243%3]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 23:03:57 +0000
Message-ID: <38b74412-dc3a-37da-55dd-e2327fe59769@amd.com>
Date: Wed, 5 Oct 2022 19:03:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] drm/amd/display: disable psr whenever applicable
Content-Language: en-US
To: "S, Shirish" <sshankar@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Shirish S <shirish.s@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20220930102705.43367-1-shirish.s@amd.com>
 <184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com>
 <39ecdc96-7fd5-d433-09f2-2af01a36315d@amd.com>
 <8ac24a07-6255-3092-95af-40d3a0d3124f@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <8ac24a07-6255-3092-95af-40d3a0d3124f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:5:74::19) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c022e1-c664-4717-1014-08daa725e1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09itLPSHQwI9j5zsrff9eBnm/w/VCuXxDp3i0kvLb6yS5gjKg/zOAxfHoy8fTt8wdjDylybAZFWrCgcNMXH81oiQf1oDUjQ6bZz3jDwxHrR7cdHElhuELiiMKDXnNgu+vnMKy+avWDBXZniekxk4i5ELQbCNtygMTZtOXihjGOeZyHMWabVIkfX3i66hvA3GReTUhp6FNL/TQA5msSG24MSvrd6Ei6TObPebQgDs1FfZsBGPIlrSy+ONX8QSrtNivy5lPJ4SybxgqykDELT7tvIx8JKsVJ0ioBV1h4NzF49Sg0xpfDHMlFSgsB3t1eGMfKLvuklbS9S3fAAy2/1YDuc67/LWP37fF1JAvrnP+Tz5DNXdsqATBgvPWv7VMK1R29V6HG9d6YD/Fj3ipmfirolfMf/QfiiIlYmLvLvYVqqg3nTrQB1ZuKyqfYeEEMm3HIXzR/TGKdo1bQ+dDPFwYHM1WZGDfPNpQI055I/ET80oJNqT+IQM+YzPjPu6Pv8qDfWW+NZD5mi2sbjUAeJ7TmW3Rh5n/6VtKUfO0vh3Sq/mS4j2wYnJxBDkwGSEPwnWzSQD0LTo3Eowy82VraToBUe2SN8rfth+0tvM3US+dYmCRz/VlIaPJHbJlGUKwjJY2AU+AW5YMyO4558O1rH15Q7c4sFesfoHsSbYK9vzM1aFUnhfJEDySlRpGgTxTyTnkjPuMGMZUNEA3LL+8CRzIu6c5mni5JSXiVaBVbjZ8KhVY8/+KZv7XC16Hy/q1Q8qQGxDWikiRKKPM7N5o7oLuZG5I23T1lWepliFKvtSErY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(83380400001)(186003)(31696002)(110136005)(8936002)(4326008)(66556008)(316002)(6512007)(41300700001)(36756003)(66946007)(53546011)(86362001)(66476007)(8676002)(6636002)(2906002)(26005)(2616005)(6486002)(31686004)(478600001)(38100700002)(5660300002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0pWZmtab2ErendpREhlV1hhNzQ2VUNwSkFnY3JkeDZsVWJGdmhyTG96MGpj?=
 =?utf-8?B?dUw4cHg4RFRaSGpSdS9WNXJRQjZvQnNmM0prYUtPNEEybHZxS3FpcjlZWHVK?=
 =?utf-8?B?aVVFenFFTVFyVUVJZkpjZHlrSlM1MVpDMVNWMCs3UStKTjl3UHBvbEZrQSsr?=
 =?utf-8?B?cFRGRlRVTEdGY1RGTnZoc0N4Z2hZb0RuNEZvTDhSWVlGMTJIMnRETzJmMVFE?=
 =?utf-8?B?Y3FhalY4bnVZVmhyelNCcmZKaDdCQUM1UVh1V2UvQ3FjYklKWTFBNE5IdWJw?=
 =?utf-8?B?M2wzc2NvLy83cmhqdEU0UlEwTGoxbzRvVkd2T1hBZ3BkV2dWMmhSRlc0YURC?=
 =?utf-8?B?SldmWU9VUEExblVJbnZMM1IzNm9LVmNNam52Lzc4Y3BwWG9Nak9MSkJ0akhU?=
 =?utf-8?B?TVNwKzBONjB3MWhPejUzbVRGNHlxSHJwb0p5QzFGeFBvUU5nbnZta1lJR1Jp?=
 =?utf-8?B?ckIrazhPb294ZTRtWmhvcCt2MEt1NlhQWG9QUWFZS1hhb2R6QkdOVjRzWUhE?=
 =?utf-8?B?c1dHUUIzM1JaUkJzRGZRSWtlaTNDZmgvSGNocFhZR1JFYnBoZXdQZ2RrTXA4?=
 =?utf-8?B?aHRKcllDKzFIOG1JMDNCQldBdVREWURpMmRWd0Z0VUt3MjFlSmdOMUM4SXVK?=
 =?utf-8?B?b1d3eE9IRnpLQWR2djg0N2VzV1NpQ25mZXhmSHNOcUNBaVA4cjhTZlZoTEJC?=
 =?utf-8?B?b2ZvZGU2NDBuc0lGdFQ3U0pMN05DcEp1cjh4Q0VLY1Jlb3RacFpZYVQ0Tko3?=
 =?utf-8?B?MjhiOHpGNFRuc21SY0NVaUZaVUwwZmZpTTFLOUROZlBtMS82bERTQ2k3SG0v?=
 =?utf-8?B?ZDFvUElkRHFBc0RjT2JGRkQ5S2RjMHFRZEtpcHBsZWhINGN6ZGFXbUFyQU1C?=
 =?utf-8?B?d3V2RkRpMy9LOUtjZUc0dmdBRXhOZ3pSRWE3c1dPcS9ucy96LzcrYmdTU2tG?=
 =?utf-8?B?UEJpOFc2aG9zRW15VU1LQnBvUmdkenJKNFJSZXZGTG1kSzd6a0tKYVdGcXY4?=
 =?utf-8?B?L2pSZjJaeXllUGd1R3NmTmRFbW4rNzArL3o0V1RnWkdseUVKelFReWJyVXBs?=
 =?utf-8?B?UUN1Q2phc2NhUDFidEpnY2tQNXZpY0kyMmVqdFFEZnBrRlJYSWErcmJJMGJG?=
 =?utf-8?B?c2VkdXpsTEN5RUpCbXg0TzdWSEh5U0JQZWRja1VTb05wTXAzb1Z6aFpIdkVm?=
 =?utf-8?B?Z1hQRUtycXVXSGlXVWJtd05kNElsMjdnSysrWlNybkhkSTdKQnRCNVMvUjJK?=
 =?utf-8?B?aFNaRTRaZkYzTDdZT2x0c1FZQ3Mwb3dZd0hVbWdlZnhDOEN0VENCT1FYTVFG?=
 =?utf-8?B?eXZjN1FvaUNYcUZTcHFMb0FWeGxhUzRSZ3N6dzVVUGZZbGFkblpkZFFvVWhs?=
 =?utf-8?B?UGtTcXlIR3IycjlLazd3Z3FaSnZMdEcvVzhVWXQzNWJtbDRER0lqMVJJMmRM?=
 =?utf-8?B?SWExcHIyUEFxMkhEZ2ErQUE0ejFMQWZWU1RmNFpQZUhic0RNQjd6NkZsdU9q?=
 =?utf-8?B?M3BYSzhnNVdyby82UUxjeFQzWlpQMWtOeXk4aFR5dGxFcDhaTEJQOS9xKzVv?=
 =?utf-8?B?KzBIQTVCY3g1MVpZYVhvVENXZkc0SHRpVnpiRXAxdUdWRk9kck5rVU5uSTlr?=
 =?utf-8?B?N0t2dzFzNHRtdi9VNWRsekkwaUNPb1JoMEZaSFVIVHhEeThOTXVjMHcreHo3?=
 =?utf-8?B?NXpMdXdTMzRxa3ZRdTJJdWJRNldwcmxCVUVMdTU2NzcrTGpUVnU5aVRxYm9E?=
 =?utf-8?B?YUsxem4yWXBTTVRCalFEUHRUZzczTVNueFpUbGFVWjFSMWQxd08xSW9iSDNZ?=
 =?utf-8?B?QXNHNm1RUjArdlVFcDg2ZFpsN05ZZWpWcVd1QkRJNkFTMDB1UjN1VDZEdUdH?=
 =?utf-8?B?c3JNQkpNWFhORFNLa2tEQUp0bmcwWXg4dlY0amlRTU9ETVNkMi8rZk5VWXF5?=
 =?utf-8?B?VkUyc2VJNmVhQXFid3QxTzR0MVEwSDQrNmRhTXJPNTlsSU1LVTNWREE4UHYr?=
 =?utf-8?B?Z3NBV1BOTVY1cXZJL0hOUEd6MlBRVzdUaFBueEx3anhqL0plZmZGU3ZNK3Zt?=
 =?utf-8?B?TGwrR3o1Z25nVWVMdzNLZjJUR3d1R3ZqQmVtRnVDN0hUL3BENklqK0pOUGJz?=
 =?utf-8?Q?xcS9QEMHnlPYRU4Kr73p+1Qm5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c022e1-c664-4717-1014-08daa725e1e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 23:03:57.2838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GX5d16dYYFOSWeHg9HKozLoeDT8fLa5oL6FIkQzfBcsfm20IWffU8t65GNU9vUhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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



On 2022-10-03 11:26, S, Shirish wrote:
> Ping!
> 
> Regards,
> 
> Shirish S
> 
> On 9/30/2022 7:17 PM, S, Shirish wrote:
>>
>>
>> On 9/30/2022 6:59 PM, Harry Wentland wrote:
>>> +Leo
>>>
>>> On 9/30/22 06:27, Shirish S wrote:
>>>> [Why]
>>>> psr feature continues to be enabled for non capable links.
>>>>
>>> Do you have more info on what issues you're seeing with this?
>>
>> Code wise without this change we end up setting 
>> "vblank_disable_immediate" parameter to false for the failing links also.
>>
>> Issue wise there is a remote chance of this leading to eDP/connected 
>> monitor not lighting up.

I'm surprised psr_settings.psr_feature_enabled can be 'true' before
amdgpu_dm_set_psr_caps() runs. it should default to 'false', and it's
set early on during amdgpu_dm_initialize_drm_device() before any other
psr-related code runs.

In other words, I don't expect psr_settings.psr_feature_enabled to be
'true' on early return of dm_set_psr_caps().

What are the sequence of events that causes an issue for you?


>>
>>>> [How]
>>>> disable the feature on links that are not capable of the same.
>>>>
>>>> Signed-off-by: Shirish S<shirish.s@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 ++++++++--
>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>> index 8ca10ab3dfc1..f73af028f312 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>>> @@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct dc_link *link)
>>>>    */
>>>>   void amdgpu_dm_set_psr_caps(struct dc_link *link)
>>>>   {
>>>> -	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
>>>> +	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
>>>> +		DRM_ERROR("Disabling PSR as connector is not eDP\n")
>>> I don't think we should log an error here.
>>
>> My objective of logging an error was to inform user/developer that 
>> this boot PSR enablement had issues.

It's not really an issue, PSR simply cannot be enabled on non-eDP or
disconnected links. However, it is concerning if we enter this function
with psr_feature_enabled == true.

Thanks,
Leo

>>
>> Am fine with moving it to INFO or remove it, if you insist.
>>
>> Thanks for your comments.
>>
>> Regards,
>>
>> Shirish S
>>
>>>> +		link->psr_settings.psr_feature_enabled = false;
>>>>   		return;
>>>> +	}
>>>>   
>>>> -	if (link->type == dc_connection_none)
>>>> +	if (link->type == dc_connection_none) {
>>>> +		DRM_ERROR("Disabling PSR as eDP connection type is invalid\n")
>>> Same here, this doesn't warrant an error log.
>>>
>>> Harry
>>>
>>>> +		link->psr_settings.psr_feature_enabled = false;
>>>>   		return;
>>>> +	}
>>>>   
>>>>   	if (link->dpcd_caps.psr_info.psr_version == 0) {
>>>>   		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
