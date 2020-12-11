Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA6C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 14:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CE620637
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 14:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CE620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D116E187;
	Fri, 11 Dec 2020 14:49:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E092F6E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 14:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpV+WhBkhhtmY02EVDY18M3jWH7f8A+CX8YjA0T1SZavfvBoFC7DRrntYjxm7YxYmjDwTaYGF5fFMg8xFGEO95vVNEAffANfptYWswQIdbNueYplvfjsxudwchi/J9pvZD0lHgoTj58FgnH1Hiq8d1Wcxo3rJ1VNlSQPEYPOd0zmvPd8eQYnL8w5eEF0nWm6F7FR+UXVWhE7AsIIcULHZDob6gj8fW/G4blw7vObOXm5HDSlj3BR2xibOCtUXlZ7IMSN5KGUqiaWDEZdKIThP+SkLjrvsNAtLKgtNyMAFIh1fti+Wtr44spYZSW9pXPp0qCIU35gqRbZDToBvXHUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdMBN/xfY9J1lI7sX05Hsf+oRfNXNVghuEVIpE5oG9Q=;
 b=E8M2/NmSU4NEVN/oJpn+Y2y/PuZzVok/P5q/hdqQQEPwwpWguZuTnyZG4NwgB64+jGaDZ/SSCKllQlRCrNHLTpbDz/c+Yn84jspbKfPkMVP8nq21I7r3Y4XaxwT5jG7kDowaaai1rgjqRPyBqguerUq8JwQ+ODM10mR7Rvk9G3yaS+5yY7YYibZv9tiAxmn0OuMYRfwaTvlb0xtA2l8H/a+kIxinD+srlxZb6+G19aN0a3b/KF7x2h0YP6e1Vxm0zffcNh5xNYShUzqWeC752UkriYk9mSfGmPbSnso25TrSDWRxMYPbw8QNh09mHKJv+rlt5zjHjZddc7Uq7v6RzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdMBN/xfY9J1lI7sX05Hsf+oRfNXNVghuEVIpE5oG9Q=;
 b=gKkkz7SY0TUPkZ0x52GZU7h7i2S3Dq2GFkJF2CpOdc2DS6qQOnmTLN9WdVg0wYxFBmNC2/IfEy2k+fZjSWP7PDpd62I63kl4NYg0XAcc33wfNDZLFdQ+QWtt5ZiR+azkwbe9EnR5Yl2jP6bYoaRSjmq9NuxFJwJB6c7XEX/JveY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 14:49:17 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.038; Fri, 11 Dec 2020
 14:49:17 +0000
Subject: Re: [PATCH 3/3] drm/amd/display: Skip modeset for front porch change
To: Shashank Sharma <shashank.sharma@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
 <20201210024526.1151447-4-aurabindo.pillai@amd.com>
 <9cc10157-d533-95fd-0f20-8bbc2db75a79@amd.com>
 <f102763220b62e64e377e84a2e8d354bb8d89173.camel@amd.com>
 <af16a352-6bd5-0836-50b0-a05194fb1764@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <41c0996b-4bbf-902d-2039-7c7015804dfa@amd.com>
Date: Fri, 11 Dec 2020 09:49:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <af16a352-6bd5-0836-50b0-a05194fb1764@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Fri, 11 Dec 2020 14:49:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efde5dfc-4d6f-4ab1-c8c2-08d89de3efc3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB34629F9AD94E4FADCFCF9C0AECCA0@BYAPR12MB3462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ozlbdELj9EZj485u4MoNPjmWfgBYVojHj4akpt0P7+vASPK6Egm15LSFfpM0JfmO8fQMjCxYdqPkkAIyOn8QHd5J56ymYfZJ4RYbfnIeXz7qkeStkj4cE91O1zHbqnk+MEYJV7Kpr1p00VoemnyGwQWzOYo3NPIcz9C67yR+Zf2jkGe7/VdYRhFJlwt3NpMd22gZRj2OVdSetN6xS9SdFW9iyOnV7uH35WLJXWxPo0unIOaOv6ZCFx2Gh6Swri3FMGkvbfrsCqtQSchqSusup/0bz5W+7pVELjJpCitcNgKGbIzWThkl0vFXbjuAA0/RBJl2wqeG1xv2JzKsth2PZ1zTd2sJ6TPktrLQ1JXDZFR9YlgN2lNkLbe58c0MoniYavYeYovCRBpxP6U8qWApZgk1uMybZZyfdsbrtA00+R+bKt4J6UtlxNvkYoL0LcP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(53546011)(8936002)(83380400001)(86362001)(66476007)(16526019)(66946007)(956004)(6666004)(66556008)(6486002)(508600001)(110136005)(5660300002)(2616005)(26005)(34490700003)(186003)(16576012)(31686004)(52116002)(36756003)(4326008)(8676002)(2906002)(31696002)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzN0Q1U4V2tvZlViRDRtUFA4VWdRM1dIN0dGcFErNC80cUVRK0Jubk1TNDhT?=
 =?utf-8?B?cFhYeTU0UWpYc0l2L2pRWGt3YjB0Y2toS1dYbldsMzlzUXB0MW80aC9FOGo1?=
 =?utf-8?B?RzlyOEY4ZkpXeXdpR085c3RwSDZ4eEJWU3pMUjdNYzVqdmplejBzbDl5cEVl?=
 =?utf-8?B?cTRSdlo1RDRlNUY2T0pQNnQ3bmRDOXF1VW5nZHloejBjNTMwUTVURDFZRVp3?=
 =?utf-8?B?R2lZWEhSalZyOW05Q05kd0xqNktVN1N2S2lYNFFHeGVNMkRMUzk1bFFiSlpZ?=
 =?utf-8?B?QkJlV0xPU3RQR0cwbURMZHRNYWRqRzJiSlNyS2NzbVdRQmZUWG5Qc2Y0Ujcz?=
 =?utf-8?B?ZE54RHJSVkdsbE9yVVJhTkNYYUFkYnlLemwvUXlYTVNGTFIwTlBYY29QR29v?=
 =?utf-8?B?d245aXBxY084VHByMVhROGsyd2t1SU5KT1NPSXFUckJ2Yk9NUktlVDJYb2Nx?=
 =?utf-8?B?Nk9tck5xSk9lbUMwSWVtTjFqc2QxUUhKYkhIYm5LS1hqNEtrc1FjYWxPcnZZ?=
 =?utf-8?B?UGtMdzNmWllQTUMvNnlrR3FEVHg3b1A5Y2dqL0k4eHRmNHN6a0VZOEM5Vmxs?=
 =?utf-8?B?MngwVmt4R1Jlc2F6UnhGYkJCZ3hpY2U1c0tUK0ExcVhUeVhlKzE2NlphOVNV?=
 =?utf-8?B?Z0dUTGlUdURVeGxoUUc2bld4WGJRRlExdko2MUt6cU1IYldyYVI3MkMvR1k1?=
 =?utf-8?B?TEZBbFFWckllWWpQWkUxR1IvejNtcWFRTGpCWXdGTXNQazlJcWRvNzkyOEww?=
 =?utf-8?B?ME1UbTc5Y2sxMDhZeG5KeGM5MHpTRWZwZGJHUHV6RnVOK1J1djRES3lSNk83?=
 =?utf-8?B?bjZ1Wm1wRzZuOFgzZXNiQWdTdW05L0RBczFLSHRQUklhVFhqZFAzcW1JdnFC?=
 =?utf-8?B?QVJHdFo2WXplNGUvMlR6L1EzdDdpSVZObFo4Ri9wcldPUkIrUDdLNW4yUzhs?=
 =?utf-8?B?eU1QL2xrdWVXcDBhL0N4WmhzdkRyZ2h4R0Fsa3JnSXZodGRwdWhibGNRTEo3?=
 =?utf-8?B?dDlrTldzL0VCY2RoUjdNVyt1TmFtbldqMGpVeEdFSE12eGZ0MGVzaEQ2aHVJ?=
 =?utf-8?B?T3FndU1RREswU0pnM1B6YkprL3djTk41YU44QUp1ZUozVW5xQjFZSHZWT2wx?=
 =?utf-8?B?ZnFtSjFRK3kyUml2anBwdUJFSGF3Wmd0dGc3clY4a2hPN3cvaG1wYmk5SEps?=
 =?utf-8?B?d3NVWUN2M1AwWVlUYTdVbC83cEg0eFF0TUJGZE5ZZTdVajZ0bWxZcWZXNks3?=
 =?utf-8?B?MnN3OS9LUUtOWE40aEhFdndzeFdXenZRN1IyNGY4QzdmM3RsL01JWVFWY3cy?=
 =?utf-8?Q?CTfd4SBxfjp3hS1mrBHpK95ZFfYwjqxoPa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 14:49:17.6588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: efde5dfc-4d6f-4ab1-c8c2-08d89de3efc3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMMITxLfx9UT8q7NNlD01ZtvqgLFgPa5dRvcJNoeF+GptCwLzeUk91O02U4c45cI0eibYf8TIiqxc9cnpn4tvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
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
Cc: alexander.deucher@amd.com, stylon.wang@amd.com, thong.thai@amd.com,
 Harry.Wentland@amd.com, wayne.lin@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-12-11 12:08 a.m., Shashank Sharma wrote:
> 
> On 10/12/20 11:20 pm, Aurabindo Pillai wrote:
>> On Thu, 2020-12-10 at 18:29 +0530, Shashank Sharma wrote:
>>> On 10/12/20 8:15 am, Aurabindo Pillai wrote:
>>>> [Why&How]
>>>> Inorder to enable freesync video mode, driver adds extra
>>>> modes based on preferred modes for common freesync frame rates.
>>>> When commiting these mode changes, a full modeset is not needed.
>>>> If the change in only in the front porch timing value, skip full
>>>> modeset and continue using the same stream.
>>>>
>>>> Signed-off-by: Aurabindo Pillai <
>>>> aurabindo.pillai@amd.com
>>>> ---
>>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 169
>>>> ++++++++++++++++--
>>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>>>>   2 files changed, 153 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index f699a3d41cad..c8c72887906a 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -217,6 +217,9 @@ static bool amdgpu_dm_psr_disable_all(struct
>>>> amdgpu_display_manager *dm);
>>>>   static const struct drm_format_info *
>>>>   amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
>>>>   
>>>> +static bool
>>>> +is_timing_unchanged_for_freesync(struct drm_crtc_state
>>>> *old_crtc_state,
>>>> +				 struct drm_crtc_state
>>>> *new_crtc_state);
>>>>   /*
>>>>    * dm_vblank_get_counter
>>>>    *
>>>> @@ -5096,8 +5099,11 @@ copy_crtc_timing_for_drm_display_mode(const
>>>> struct drm_display_mode *src_mode,
>>>>   static void
>>>>   decide_crtc_timing_for_drm_display_mode(struct drm_display_mode
>>>> *drm_mode,
>>>>   					const struct drm_display_mode
>>>> *native_mode,
>>>> -					bool scale_enabled)
>>>> +					bool scale_enabled, bool
>>>> fs_mode)
>>>>   {
>>>> +	if (fs_mode)
>>>> +		return;
>>> so we are adding an input flag just so that we can return from the
>>> function at top ? How about adding this check at the caller without
>>> changing the function parameters ?
>> Will fix this.
>>
>>>> +
>>>>   	if (scale_enabled) {
>>>>   		copy_crtc_timing_for_drm_display_mode(native_mode,
>>>> drm_mode);
>>>>   	} else if (native_mode->clock == drm_mode->clock &&
>>>> @@ -5241,6 +5247,24 @@ get_highest_freesync_mode(struct
>>>> amdgpu_dm_connector *aconnector,
>>>>   	return m_high;
>>>>   }
>>>>   
>>>> +static bool is_freesync_video_mode(struct drm_display_mode *mode,
>>>> +				   struct amdgpu_dm_connector
>>>> *aconnector)
>>>> +{
>>>> +	struct drm_display_mode *high_mode;
>>>> +
>>> I thought we were adding a string "_FSV" in the end for the mode-
>>>> name, why can't we check that instead of going through the whole
>>> list of modes again ?
>> Actually I only added _FSV to distinguish the newly added modes easily.
>> On second thoughts, I'm not sure if there are any userspace
>> applications that might depend on parsing the mode name, for maybe to
>> print the resolution. I think its better not to break any such
>> assumptions if they do exist by any chance. I think I'll just remove
>> _FSV from the mode name. We already set DRM_MODE_TYPE_DRIVER for
>> userspace to recognize these additional modes, so it shouldnt be a
>> problem.
> 
> Actually, I am rather happy with this, as in when we want to test out this feature with a IGT type stuff, or if a userspace wants to utilize this option in any way, this method of differentiation would be useful. DRM_MODE_DRIVER is being used by some other places apart from freesync, so it might not be a unique identifier. So my recommendation would be to keep this.
> 
> My comment was, if we have already parsed the whole connector list once, and added the mode, there should be a better way of doing it instead of checking it again by calling "get_highest_freesync_mod"
> 
> Some things I can think on top of my mind would be:
> 
> - Add a read-only amdgpu driver private flag (not DRM flag), while adding a new freesync mode, which will uniquely identify if a mode is FS mode. On modeset, you have to just check that flag.
> 
> - As we are not handling a lot of modes, cache the FS modes locally and check only from that DB (instead of the whole modelist)
> 
> - Cache the VIC of the mode (if available) and then look into the VIC table (not sure if detailed modes provide VIC, like CEA-861 modes)
> 
> or something better than this.
> 
> - Shashank

I'd rather we not make mode name part of a UAPI or to identify a 
"FreeSync mode". This is already behind a module option and from the 
driver's perspective we only need the timing to understand whether or 
not we can do an optimized modeset using FreeSync into it. Driver 
private flags can optimize the check away but it's only a few 
comparisons so I don't see much benefit.

We will always need to reference the original preferred mode regardless 
of how the FreeSync mode is identified since there could be a case where 
we're enabling the CRTC from disabled -> enabled. The display was 
previously blank and we need to reprogram the OTG timing to the mode 
that doesn't have an extended front porch.

Regards,
Nicholas Kazlauskas

> 
>>>> +	high_mode = get_highest_freesync_mode(aconnector, false);
>>>> +	if (!high_mode)
>>>> +		return false;
>>>> +
>>>> +	if (high_mode->clock == 0 ||
>>>> +	    high_mode->hdisplay != mode->hdisplay ||
>>>> +	    high_mode->clock != mode->clock ||
>>>> +	    !mode)
>>>> +		return false;
>>>> +	else
>>>> +		return true;
>>>> +}
>>>> +
>>>>   static struct dc_stream_state *
>>>>   create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>>>>   		       const struct drm_display_mode *drm_mode,
>>>> @@ -5253,17 +5277,21 @@ create_stream_for_sink(struct
>>>> amdgpu_dm_connector *aconnector,
>>>>   	const struct drm_connector_state *con_state =
>>>>   		dm_state ? &dm_state->base : NULL;
>>>>   	struct dc_stream_state *stream = NULL;
>>>> -	struct drm_display_mode mode = *drm_mode;
>>>> +	struct drm_display_mode saved_mode, mode = *drm_mode;
>>> How about shifting this definition to new line to follow the existing
>>> convention ?
>> Sure.
>>
>>>> +	struct drm_display_mode *freesync_mode = NULL;
>>>>   	bool native_mode_found = false;
>>>>   	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
>>>>   	int mode_refresh;
>>>>   	int preferred_refresh = 0;
>>>> +	bool is_fs_vid_mode = 0;
>>>>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>>>>   	struct dsc_dec_dpcd_caps dsc_caps;
>>>>   #endif
>>>>   	uint32_t link_bandwidth_kbps;
>>>> -
>>>>   	struct dc_sink *sink = NULL;
>>>> +
>>>> +	memset(&saved_mode, 0, sizeof(struct drm_display_mode));
>>>> +
>>>>   	if (aconnector == NULL) {
>>>>   		DRM_ERROR("aconnector is NULL!\n");
>>>>   		return stream;
>>>> @@ -5316,20 +5344,33 @@ create_stream_for_sink(struct
>>>> amdgpu_dm_connector *aconnector,
>>>>   		 */
>>>>   		DRM_DEBUG_DRIVER("No preferred mode found\n");
>>>>   	} else {
>>>> +		is_fs_vid_mode = is_freesync_video_mode(&mode,
>>>> aconnector);
>>>> +		if (is_fs_vid_mode) {
>>>> +			freesync_mode =
>>>> get_highest_freesync_mode(aconnector, false);
>>>> +			if (freesync_mode) {
>>> As the freesync modes are being added by the driver, and we have
>>> passed one check which says is_fs_vid_mode, will it ever be the case
>>> where freesync_mode == NULL ? Ideally we should get atleast one mode
>>> equal to this isn't it ? in that case we can drop one if () check.
>> Yes, thanks for catching this. Will fix.
>>
>>
>> --
>>
>> Regards,
>> Aurabindo Pillai

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
