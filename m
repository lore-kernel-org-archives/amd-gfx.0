Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA58C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 05:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C93B23E25
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 05:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C93B23E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F0A6E558;
	Fri, 11 Dec 2020 05:08:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529776E558
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 05:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeyTSSowfM2SQAF0ac/uZDd9Y5EgezS9c0su9+6s5oK6ym4tv0iWBkP/NfWmzOtJ7Tl7QeWixrnf843LSbkjZ3SDtw8UAY+CrMIleUqxIO+XyMf+srVJHAJJmcc5+I1yGOU8dMjaMwgfiDS3vxfMSS8uFXFWozI2+3Fi7HCYLlhyURGhzhnMa5QQEcpoSZkolucWf+/j6Hp2JID+Q+BEwPICoLt/5Xj0IJaU6duEPGfXxN8CB5Hn0+OQvAkiL1bzIGM9Pc7S1x7xp1johJnWtq7aYMLl2Tb9FJOpyDKdGQNddHRw7VioyoEjX68iL03/92M0HI8G1r6Tp/QQ6zuWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fqf3MUkEHSpXNZjZvCfvBZFZbo/nUaV8aQ+IAYdGBA=;
 b=VCC+HSbeOzzXAPcOD2Wav2ZnnE2d+O9UgNtl5YoGRGe+tqr2/hPc8J+5K6SS/d/THii7IWbh5igFNkCCF2SiP9CbQjY+OCmIxbmKUcYTU0p4YnjmATYeglwwZTsb3FEPsEpxDwU5hngZrTetZqRHteXoPIo1vrtIzCUr/lVVFfVvPzDQb8GqJths/AYmHOeYysksUPuLE+bRPiZWj4Z1vRH8iNgCnaozo33pvX9/6LMAEyD74r/or5g11Gu829zZApYuD+07IVVekghAja7YqdJ+iVfabkcwntcSR7z/WHzdHWg4OLwEnZZdp3+RIIgJ4PuS9n3skcauuwNsNw+iHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fqf3MUkEHSpXNZjZvCfvBZFZbo/nUaV8aQ+IAYdGBA=;
 b=r1ftcqqygdInnPNr+6szvpRNCGgzTQLSYO6YS2DNxYElaJLdNLQwViHrl2WZkpNLdb5nNlVqbd8agR3kQXPfjZ5xQzqcoCMfrixEOwv1Ana0w8O2IwjZGevWcwIYuem+bRi2zdzWqE1mU7ANvGo/Nl2bB537zXSMWjhNo31Hwyg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB2839.namprd12.prod.outlook.com (2603:10b6:a03:72::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Fri, 11 Dec
 2020 05:08:52 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68%7]) with mapi id 15.20.3654.017; Fri, 11 Dec 2020
 05:08:52 +0000
Subject: Re: [PATCH 3/3] drm/amd/display: Skip modeset for front porch change
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
 <20201210024526.1151447-4-aurabindo.pillai@amd.com>
 <9cc10157-d533-95fd-0f20-8bbc2db75a79@amd.com>
 <f102763220b62e64e377e84a2e8d354bb8d89173.camel@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <af16a352-6bd5-0836-50b0-a05194fb1764@amd.com>
Date: Fri, 11 Dec 2020 10:38:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <f102763220b62e64e377e84a2e8d354bb8d89173.camel@amd.com>
Content-Language: en-US
X-Originating-IP: [106.51.105.40]
X-ClientProxiedBy: MAXPR0101CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::25) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.105.40) by
 MAXPR0101CA0063.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Fri, 11 Dec 2020 05:08:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 479c7165-d1c0-44ac-af28-08d89d92da3f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB283973A7262A4BB896A150B6F2CA0@BYAPR12MB2839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+aQmqG7a7QSpwNuY1kGhbwaGbcOPcaqAhN7JEa34N0r8KLQJ8kht8xZpuYx4/njMtUSn9zRNDrt1RQBlWrrw0KhDy0hmneXOVzIG/qLZTmQCvqDrh8eSDOs1Wd2bAK2yaEv1tm+DsB6jy4Ouxz8cw3JF9KL3ZAAVFySZzRRF4LgDmlk+PxLEutNvTKI4ZRMTQ5hwxFzdNgE6W5KB5SmQHrHLN6FL+O7Z6x7ZTcrtZmtYCjTbBBdjaCHFjSrVztlkFTCUX63FjuW7/nEga8TjaGlNzsWy8X65/7adybFmttWKgKTzuwNyDPxcpCE6JRHdOlRtIdri73kZXvYWm8wGMPgYO3C0BdUBA14oowbmsyDZ7VRHVM6eqfHxRAmQSr8SXWrBqG1KT2O6qFCOiPdyw+RLTNsh6xWV5HiQtpUGG/f5R4EhCzB2ybX12gZWu9J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(8676002)(55236004)(2616005)(956004)(44832011)(83380400001)(31696002)(16576012)(66556008)(66476007)(31686004)(36756003)(86362001)(66946007)(4326008)(2906002)(1006002)(6666004)(5660300002)(508600001)(53546011)(34490700003)(186003)(8936002)(16526019)(4001150100001)(26005)(6486002)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eTF3eERTUCtWN3FIRTQ3cHVCVkFYVDdZSmtoZ1F0Tjdkb3ZMNXNPSXVxajNY?=
 =?utf-8?B?OHFlTnFsbWZLVWxsOTg2WGRtYS81bGxXaCtVZzZ2QlZaQURzOXBZd2hQTGdF?=
 =?utf-8?B?eTY4dlVncW1NWFlDMnltb29RVUlXRmVORnlEbWlhbG1qeXlvdEhDV2JDSDJo?=
 =?utf-8?B?Z0Fab2JPaHlkYlpESWVGRTNaeCtjMVkzVDRUa1JCdWtSYkhwdTcvdzYyY21S?=
 =?utf-8?B?WE9ueGErbVAzOWRxbXo2OVk4OEVWdHdDMVlyUnRXZzQ2Uk1pVXNQOWZIVE1M?=
 =?utf-8?B?ZXdJL0gvbXRMUUxhZ0R4VUpwOFJZTERxRm45TDR1aXZqUGxXRUY5M2NSMVhz?=
 =?utf-8?B?MVJ1SHNKeWZHMmdpWUlDYmNXeVV5UThsemxsQ2RrRElhSnFUbFY0SXp5VjdG?=
 =?utf-8?B?K0d1ZnNOcCtYTFFPeFRjTm5HNmVraU1TY004Mkx0ZnhXV1ZEUXUwejU3VmxZ?=
 =?utf-8?B?Y1FsUlhTdjFBd1RYOHRVelRMditqRnhhS1pOTU5kU1lpMVhHUEZXYVd6RlhJ?=
 =?utf-8?B?aDZvQU1VaWFzWWcvbFFtRkFYeVhtb3d2K29Dc01TNFUwa09ScS9rVmc4SU5W?=
 =?utf-8?B?dUFxRDRCYk1JVkhybFZ6c2ZkeTEyZW9yN0xXVjhsdm9jTUJ1WVZ5RVB4NTdh?=
 =?utf-8?B?eXZ4M29JMXVMRHpSVWVBdEdlNVlER0Z3RFhuY1hYQ2pFWEVqRWFBZXBkcnhs?=
 =?utf-8?B?S3pvT0JTRHBKSWdFcklHNi8rQ0RSZkFaa3JJS0VCYVpXSzduM1ZNRk5nL3Vq?=
 =?utf-8?B?eW1hc1ZFUDc1SlNiYXErVEl0dENyNUkxVzh5NC9wa3h6WHBpK3lpZm5PRmxR?=
 =?utf-8?B?dDloMFZzTDQ1clh1VE1NWXJRWGo0WUF5b3dCQUI5Z2lPNzkrakkrS0JxeGt1?=
 =?utf-8?B?MVlJNHpwaHRtbHhZT0pFalpLYitjU2NMNkJ5bG9Jb0NCbTFrT3N2NHE3VTM5?=
 =?utf-8?B?U05tSWM1V21NUGVWL2hnWEN5TFZqNHFKVEZ0RTROR2h0RlBYZFAydmlqVVVq?=
 =?utf-8?B?eUNRSjR0MTBEaTNuVFAwOVpOM2IwbXBoVFo0eTRIU3l1TCttOGt4bmcwSzVp?=
 =?utf-8?B?SjI3bkYzWVFnV3Y2ZGR5NFExeEY1UVVxeFVvZGxsUUN3Q3FDb09HVHJiRDk0?=
 =?utf-8?B?cEtnMEpzdmRTMmJ4eDFhYm1mSS8xV2FUbGdPQmRVc3RMRjc5QUQ0dk5pdVdx?=
 =?utf-8?B?b1VBMWh2YmpPSUhBMjByR0g5Q004a3JsbW5EMzR0RXNySm53NTI1aXpPWWNm?=
 =?utf-8?B?RDRVeVZSc3FxbmJzQjA3WUVkaUdKTWw5OTVuQkoyMERiNUdIbXRUTU9DTnBF?=
 =?utf-8?Q?A5uTVPulGEh4zds3V3um++qCDDQx20ekGw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2020 05:08:52.4088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 479c7165-d1c0-44ac-af28-08d89d92da3f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0jy55LiC34E7b+erPMWgEINlKmGEPMrNaAO6nUapXZBIPYxwmr6Doh0rEeKWPQQgpEFSHQVUIri9Y3VTZ7NZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
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
Cc: stylon.wang@amd.com, thong.thai@amd.com, wayne.lin@amd.com,
 alexander.deucher@amd.com, Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/12/20 11:20 pm, Aurabindo Pillai wrote:
> On Thu, 2020-12-10 at 18:29 +0530, Shashank Sharma wrote:
>> On 10/12/20 8:15 am, Aurabindo Pillai wrote:
>>> [Why&How]
>>> Inorder to enable freesync video mode, driver adds extra
>>> modes based on preferred modes for common freesync frame rates.
>>> When commiting these mode changes, a full modeset is not needed.
>>> If the change in only in the front porch timing value, skip full
>>> modeset and continue using the same stream.
>>>
>>> Signed-off-by: Aurabindo Pillai <
>>> aurabindo.pillai@amd.com
>>> ---
>>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 169
>>> ++++++++++++++++--
>>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>>>  2 files changed, 153 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index f699a3d41cad..c8c72887906a 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -217,6 +217,9 @@ static bool amdgpu_dm_psr_disable_all(struct
>>> amdgpu_display_manager *dm);
>>>  static const struct drm_format_info *
>>>  amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd);
>>>  
>>> +static bool
>>> +is_timing_unchanged_for_freesync(struct drm_crtc_state
>>> *old_crtc_state,
>>> +				 struct drm_crtc_state
>>> *new_crtc_state);
>>>  /*
>>>   * dm_vblank_get_counter
>>>   *
>>> @@ -5096,8 +5099,11 @@ copy_crtc_timing_for_drm_display_mode(const
>>> struct drm_display_mode *src_mode,
>>>  static void
>>>  decide_crtc_timing_for_drm_display_mode(struct drm_display_mode
>>> *drm_mode,
>>>  					const struct drm_display_mode
>>> *native_mode,
>>> -					bool scale_enabled)
>>> +					bool scale_enabled, bool
>>> fs_mode)
>>>  {
>>> +	if (fs_mode)
>>> +		return;
>> so we are adding an input flag just so that we can return from the
>> function at top ? How about adding this check at the caller without
>> changing the function parameters ?
> Will fix this.
>
>>> +
>>>  	if (scale_enabled) {
>>>  		copy_crtc_timing_for_drm_display_mode(native_mode,
>>> drm_mode);
>>>  	} else if (native_mode->clock == drm_mode->clock &&
>>> @@ -5241,6 +5247,24 @@ get_highest_freesync_mode(struct
>>> amdgpu_dm_connector *aconnector,
>>>  	return m_high;
>>>  }
>>>  
>>> +static bool is_freesync_video_mode(struct drm_display_mode *mode,
>>> +				   struct amdgpu_dm_connector
>>> *aconnector)
>>> +{
>>> +	struct drm_display_mode *high_mode;
>>> +
>> I thought we were adding a string "_FSV" in the end for the mode-
>>> name, why can't we check that instead of going through the whole
>> list of modes again ?
> Actually I only added _FSV to distinguish the newly added modes easily.
> On second thoughts, I'm not sure if there are any userspace
> applications that might depend on parsing the mode name, for maybe to
> print the resolution. I think its better not to break any such
> assumptions if they do exist by any chance. I think I'll just remove
> _FSV from the mode name. We already set DRM_MODE_TYPE_DRIVER for
> userspace to recognize these additional modes, so it shouldnt be a
> problem.

Actually, I am rather happy with this, as in when we want to test out this feature with a IGT type stuff, or if a userspace wants to utilize this option in any way, this method of differentiation would be useful. DRM_MODE_DRIVER is being used by some other places apart from freesync, so it might not be a unique identifier. So my recommendation would be to keep this.

My comment was, if we have already parsed the whole connector list once, and added the mode, there should be a better way of doing it instead of checking it again by calling "get_highest_freesync_mod"

Some things I can think on top of my mind would be:

- Add a read-only amdgpu driver private flag (not DRM flag), while adding a new freesync mode, which will uniquely identify if a mode is FS mode. On modeset, you have to just check that flag.

- As we are not handling a lot of modes, cache the FS modes locally and check only from that DB (instead of the whole modelist)

- Cache the VIC of the mode (if available) and then look into the VIC table (not sure if detailed modes provide VIC, like CEA-861 modes)

or something better than this.

- Shashank

>>> +	high_mode = get_highest_freesync_mode(aconnector, false);
>>> +	if (!high_mode)
>>> +		return false;
>>> +
>>> +	if (high_mode->clock == 0 ||
>>> +	    high_mode->hdisplay != mode->hdisplay ||
>>> +	    high_mode->clock != mode->clock ||
>>> +	    !mode)
>>> +		return false;
>>> +	else
>>> +		return true;
>>> +}
>>> +
>>>  static struct dc_stream_state *
>>>  create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>>>  		       const struct drm_display_mode *drm_mode,
>>> @@ -5253,17 +5277,21 @@ create_stream_for_sink(struct
>>> amdgpu_dm_connector *aconnector,
>>>  	const struct drm_connector_state *con_state =
>>>  		dm_state ? &dm_state->base : NULL;
>>>  	struct dc_stream_state *stream = NULL;
>>> -	struct drm_display_mode mode = *drm_mode;
>>> +	struct drm_display_mode saved_mode, mode = *drm_mode;
>> How about shifting this definition to new line to follow the existing
>> convention ?
> Sure.
>
>>> +	struct drm_display_mode *freesync_mode = NULL;
>>>  	bool native_mode_found = false;
>>>  	bool scale = dm_state ? (dm_state->scaling != RMX_OFF) : false;
>>>  	int mode_refresh;
>>>  	int preferred_refresh = 0;
>>> +	bool is_fs_vid_mode = 0;
>>>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>>>  	struct dsc_dec_dpcd_caps dsc_caps;
>>>  #endif
>>>  	uint32_t link_bandwidth_kbps;
>>> -
>>>  	struct dc_sink *sink = NULL;
>>> +
>>> +	memset(&saved_mode, 0, sizeof(struct drm_display_mode));
>>> +
>>>  	if (aconnector == NULL) {
>>>  		DRM_ERROR("aconnector is NULL!\n");
>>>  		return stream;
>>> @@ -5316,20 +5344,33 @@ create_stream_for_sink(struct
>>> amdgpu_dm_connector *aconnector,
>>>  		 */
>>>  		DRM_DEBUG_DRIVER("No preferred mode found\n");
>>>  	} else {
>>> +		is_fs_vid_mode = is_freesync_video_mode(&mode,
>>> aconnector);
>>> +		if (is_fs_vid_mode) {
>>> +			freesync_mode =
>>> get_highest_freesync_mode(aconnector, false);
>>> +			if (freesync_mode) {
>> As the freesync modes are being added by the driver, and we have
>> passed one check which says is_fs_vid_mode, will it ever be the case
>> where freesync_mode == NULL ? Ideally we should get atleast one mode
>> equal to this isn't it ? in that case we can drop one if () check.
> Yes, thanks for catching this. Will fix.
>
>
> --
>
> Regards,
> Aurabindo Pillai
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
