Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44061CD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F16310EFF7;
	Wed, 17 Jun 2026 14:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WMhqYj72";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE09010EFF3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 14:33:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqLW34rC61Oke65Gaf1WQRmpPBji/E+o1Kwj1jxpiiXY5HIIQfSaHwMCe2yNGJHvwDivsazsZizm2vA5VNEGqaGq3tOmvQMzyEmIZXOYjR33M8agLgOJJtow1AUZMp+Z20F7+QOvSaOpZMbh5BrBNhOWzj+7Kj0e//ZjrLVXs2D78+BpJ0ivsoE+I63zKqKAofxjrn4zbsFIecocB5+ZTWgBv4JsDy4qTQLmxsvtZtkfC4ZB/ZMyWN95mMbMQFMqKe4JMdwR0sermcQ1zvsy+Ur+JSyAyjuAwIpH4XDQvLfwCoe1Y+MtF7KRGgVhhIsZIYOXov3M+EEGjQBXfBnlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae1lU8zxBa7qc074AanXBu10Nf7Erx+VioWicCch78I=;
 b=oo9eBjArdnkOI8W7NeSW2VV7g4I56Vq8k/Rfjs59NmS4YMv2957I6QHJbXbFLdWkZ4M+o6bcO14ESuViapyeSgj09hNUSN/EQ3TR3QECjIYiJhk4lqvtTEWDP8Q5IHB/ZKUfu/HHD++qoAxBD9oXR/WlvIL7VY0YG9ZZ72G+AES/882hpYP39SDnmYJIE5tEARtczJJlnNVYMI/CZfRCsuMKHKo0tazp3zQxk07LGkEn6XmbjulMAJii/vfnTMiXfnDO/P0qGyxeHDvwbLAY3Q+stQDm/fcQux+J3ZrmHokoZnlCGzMf8H2B44NZkYKZN3neZVnGNvlZXs/FOolMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae1lU8zxBa7qc074AanXBu10Nf7Erx+VioWicCch78I=;
 b=WMhqYj72ItnmhizlVZPfGn8kpGIIQLpoJdTVIsFQCJF+NXkCFulXcbOaeTwQAqS0D5/osZDUh3lwPdXvtXp2GIoV0Tq6bPAwKxWJBCW77j+3CoJObb595HFw3q8FOFUHdgFMUOuI+OK5z5AEjXO7dBzGd57Yda5ygVBkkctAUtM=
Received: from SA9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::25)
 by SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 14:32:53 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::7) by SA9P223CA0020.outlook.office365.com
 (2603:10b6:806:26::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 14:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 14:32:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 09:32:52 -0500
Received: from [10.254.92.203] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 09:32:52 -0500
Message-ID: <cbeaa22b-530b-4fb7-bfe1-813d127d3595@amd.com>
Date: Wed, 17 Jun 2026 10:32:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/display: consolidate DCN vblank/flip handling
 onto vupdate_no_lock
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-2-sunpeng.li@amd.com>
 <3ad7d4a1-093b-45ac-b3b2-5df5bbb0fde8@linux.dev>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <3ad7d4a1-093b-45ac-b3b2-5df5bbb0fde8@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SA1PR12MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: dde088db-59c5-49c3-96d2-08decc7d5100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|42112799006|32650700020|82310400026|1800799024|36860700016|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PxNwNq9prTQkYIQpmaPnKoCVXyKgwYXHoxBdQeLEDALMB5YnKSmJCrWSO38AkHkDt0eI/LxC2t/bFOUfJvywj8YTeh6UVIyYaIHH7Bza/qIp7ivAMeaHyumfSY8OJO7F/p1nztnKD3SRJxYIoQT6skrPwEH/yZoYHdsR4wFr3jjL921VvlreFOYJrijAoyXI3ZwDY/KpN+QbmSjuPPmt8TDal4K0K972uInCDH3T+BIu6VCfAmLdQudu35Kgs2+cAr7RHFsmCRSLdjrlB28n81pViy+7zt34b/8fZClh88ZMP8AWJnvZMgI5YlQjen7E3SaAmhCcpyzGZvAWjn9XW4ASSYflX+GKYH4GXJyPG2mI3d7CnU/H4NKtvZ112NZuT4OeN+GAGfaHekInmlZnRA3bmkEAzjCuPeNu4PCvIs3Bvws+pTNwo0jtZnB4XLfZgIEb56mL10KKxepNKoM6+gM3vF3Nx/8oQUf9fcCBTTqPqe5lP/bRVEdnd2miIlSDvSpZQkvTQtOiSyDeAgikq6XnBwMIv7JNPtb+0AVjVmJnALRLtju1pVuZgvYx4UyTM2HkLjt8xMSEki0ObkebGU6gUFrAdF4HcKNT8UZUqrWSWZNaMdUX9wNrJwF07Z/5A3qgAvH4SLSi4ZKsARdIpuQ5hRDgNWyyLxAuFUzwTVeIHbXEzqnZkMbh/3Gf3kl36Koo96yoQaagwmoR2FsyJcw02qIi9jKFCIDSY8WPkp8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(42112799006)(32650700020)(82310400026)(1800799024)(36860700016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zIIhQURFGeQmeos1tLGLf/TLMvFCKOoo1Wg3oYl98GOshPlKTzP9FBgsCKaLuKI49hey92+u8rxYPw90gTBTbZhCqz5h9OVfZOvkrcnIerU5ZuJbWZqsCwoOUfPEw1ayRiwm+1N/G/48KsBYwPz1pxjDWtKFSa/F5gBZ/cfRLrnhAwuVFQDjD37hhNZ3VlYWWGHGFU+e3eybQ6ladV/Y03SJ7OcOZo+9w8ZS4q+SXwWyu2BwoUH1WJJ8j6fD8+/VyPgpT3cEdSMSn0omW2odgXTdNKMPjvHGTysK7q0QkT07EJCC5yoKt6DQ+LiuGLwB2diLaiL0fIUre677GDRDKrx/mawyigil1UPfBOUIdrJ+OsDAWw/oQNqlT2SwX+rwtIVKHh+M+6cQ+0GEdqYIE5KJtpoQIgeg+72uuA3AxCKpj1CGtZzi/SvsUJPMpTLJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:32:53.4757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde088db-59c5-49c3-96d2-08decc7d5100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8722
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



On 2026-06-17 00:35, Matthew Schwartz wrote:
> On 6/16/26 1:18 PM, sunpeng.li@amd.com wrote:
> 
> [...]
> 
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index c9916ed0ddc14..8a6b732cf80c8 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -281,7 +281,14 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>>  			drm_crtc_vblank_restore(crtc);
>>  	}
>>  
>> -	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
>> +	/*
>> +	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to deliver
>> +	 * vblank and pageflip completion events, so enable it whenever vblank
>> +	 * is enabled. On DCE, vupdate is only needed in VRR mode.
>> +	 */
>> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
>> +		rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
>> +	} else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> 
> Hi Leo (dropping Stable),
> 
> This arms VUPDATE_NO_LOCK on all of DCN, but amdgpu_dm_handle_vrr_transition() still disables it when switching from VRR active -> inactive. This causes a new flip_done timed out event when a compositor like gamescope disables VRR while it's already active.

Good catch, I wonder why the kms_vrr IGT tests did not catch this...
I'll roll your fix into v2 with your signed-off-by and co-authored-by.

Thanks,
Leo

> 
> I had to fix it up with something like:
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e09c0eb9f865..ee337ca816cf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10085,8 +10085,16 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
>  					    struct dm_crtc_state *old_state,
>  					    struct dm_crtc_state *new_state)
>  {
> +	struct amdgpu_device *adev = dm->adev;
>  	bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
>  	bool new_vrr_active = amdgpu_dm_crtc_vrr_active(new_state);
> +	/*
> +	 * On DCN, VUPDATE_NO_LOCK is the sole vblank and pageflip completion
> +	 * source and amdgpu_dm_crtc_set_vblank() keeps it armed whenever
> +	 * vblank is enabled, so it must not be toggled with the VRR state.
> +	 * Only DCE gates vupdate on VRR.
> +	 */
> +	bool vrr_gates_vupdate = amdgpu_ip_version(adev, DCE_HWIP, 0) == 0;
>  
>  	if (!old_vrr_active && new_vrr_active) {
>  		/* Transition VRR inactive -> active:
> @@ -10097,7 +10105,8 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
>  		 * We also need vupdate irq for the actual core vblank handling
>  		 * at end of vblank.
>  		 */
> -		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
> +		if (vrr_gates_vupdate)
> +			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
>  		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
>  		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR off->on: Get vblank ref\n",
>  				 __func__, new_state->base.crtc->base.id);
> @@ -10113,7 +10122,8 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
>  		/* Transition VRR active -> inactive:
>  		 * Allow vblank irq disable again for fixed refresh rate.
>  		 */
> -		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
> +		if (vrr_gates_vupdate)
> +			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
>  		drm_crtc_vblank_put(new_state->base.crtc);
>  		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
>  				 __func__, new_state->base.crtc->base.id);
> 
> Feel free to fold some version of this into the next version if it makes sense, or pick it up with my s-o-b.
> 
> Thanks,
> Matthew
> 

