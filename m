Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343D3C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 12:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C4523B87
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 12:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C4523B87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5249889271;
	Thu, 10 Dec 2020 12:37:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC3089271
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 12:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PipwStyV4ciGEcHBHNojQ4ATnr2g0LudcrROd/4+KQP/6en15jq2eDttJaG4XkO3+lJX9cXtAvgiMgkFYUVcFTDX2sZyrja8bXvNRBnQYWqk2CDPO/OUXDnaKARv6RhvzuFnUmypcWqQwpplR4DAGBz7rcrCvwGCT+6ztSwUIxg+AdNaDBTp6Igy82dcpM0nrZ46cZ4B8bXBrym/Nf+rDwbnbQRO+v2MtapzUrZIVyEEfZFcnKlcrboDULcDzCJUmRZLi3QThe0vDyWYEWTX/6cnlkZPldEn3Vo9/w2n0nr3U7DjOQWuNEyr1FO3oVwpbwn6lO9ARzIN9jD1I1dcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUYDf4b0hWvnZVM8Dwc/zXfAG3ZZt/jPJTYrE88MS04=;
 b=cDueDAaMOqGsZUSRxy4kvFGW0U219QCmAEj0JTls74H3jpCYe59ZlTTDh4Ikg6tEdMUcDk6ufaBzO7QsG0FosIfGiwmFzCr0PA6TQVFx7ZQBhnZL4WPYOQlcFEfD/LE+RE7FgdGv4goRGXdRo5Ynv9mFpD5/5Mic9vvPMBGoTgQlsapiZ9U+nvM00i/9ulyoZQroWAgxEW6EhyaMKZMQfaOP0iqFqyWNDqtmgu2fSONM6/KLm+ZJWBd5a5VUk7d1S6d2h48psro3iGWKl0Z0Aw+l/czzP5T9r56MCrqjgYPF1nr6r3mRnNKmM1qyTbTrDOTsR1gtuY+t6IAaAuS7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUYDf4b0hWvnZVM8Dwc/zXfAG3ZZt/jPJTYrE88MS04=;
 b=g/rdusCwEupxPT19Oytp6ECQfBTapPyMSE70J4+mUtIJKA4gJeSd0z2M4EWHRR2/GrHobbriTR7Zzs9g83H+NLW8jC34uYng75SQyuv5CyllT2XMIvERhkMt82eJaF9l4Cezbla/RuL33qmRhgKz41BRaexDoHoUI251Aaz60Kw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3891.namprd12.prod.outlook.com (2603:10b6:a03:1a3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 12:37:20 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 12:37:19 +0000
Subject: Re: [PATCH 2/3] drm/amd/display: Add freesync video modes based on
 preferred modes
To: amd-gfx@lists.freedesktop.org
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
 <20201210024526.1151447-3-aurabindo.pillai@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <cb537244-e286-4cce-9269-2ead18f3ec3f@amd.com>
Date: Thu, 10 Dec 2020 18:07:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201210024526.1151447-3-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [106.51.105.40]
X-ClientProxiedBy: MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::18) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.105.40) by
 MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 12:37:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c87a3f8-28f8-4fc1-09d1-08d89d0855ca
X-MS-TrafficTypeDiagnostic: BY5PR12MB3891:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38914741184E3EEB408A2CB3F2CB0@BY5PR12MB3891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6W3jPtq4tKcPyfnxYCAWdFaaC1+dQvomeqTbnVz+SLYoJ/AyYxP89PTKWLGh2qi/wTAK445AQ0YKvDfybkNwVlweRZVbJNpTjeUio6VrToblUq34annGLnYG7mX4iZqUQEuorbLZn7qBS9OzQ+NMlLOluynYkX2l6ak86r7U2NjE6Nl3wXankA6DWLF+uEkv1rodlCuFtUVOTk37yqGyE7kZEIl4oPfV1UE5g8FtjKaJL0rWpva7V/Y4xtNUJBmEc1ZDh5tun/Hv4JX+LhZ6El0zdO8JOPhBKksPN0z4j8MhicLt4aWIrFGU1Nixaa3DYh0geZjwhWZK1jhWKZlaUgklwnvdJOIAuLu7wlgQ5QCOUqNDFRiWvR83XkdEGj7kKnryI8xyP/bx09dUJK5YPD4DkwqV34IlgGmmYvAEh4VMswMUK59bWpiWVW9Fo9N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(16576012)(53546011)(36756003)(6486002)(30864003)(33964004)(5660300002)(508600001)(6666004)(31686004)(86362001)(52116002)(55236004)(66946007)(83380400001)(44832011)(8936002)(34490700003)(6916009)(8676002)(26005)(66476007)(186003)(16526019)(1006002)(2906002)(2616005)(31696002)(66556008)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eVBoYUtjMHBDTjlrRGVMS0ZHZ3I1V2FTR2d1bEk1VVZjQWhIVGwyM0JCRlkw?=
 =?utf-8?B?alh6YmExWnpQWjE4c2s5c25zWk1Cck1YM2Z5bEJSYThQUVc2TmhJYUZibGNK?=
 =?utf-8?B?UW1mS3NqNWNFVm1zOExleDk4V1h2UUJ3Qnlsd2dCb1NHaEl1Q3Evc2VaV3l0?=
 =?utf-8?B?ZjMxdEVFdTh0SWdjVFk2U2NHZTJYbUJkYnNQUW9CdVdHL0NwMUxGVy9FczRI?=
 =?utf-8?B?WGVTbXJuSHhtWjZkSWJzR0NFTFB4L1RvUHUxQjV2bTJWRkwxT2FZWkZPRUNa?=
 =?utf-8?B?cHJIb1JvWEJLaEdTaER3MThwMklMdXhsdWE2SWdNbE5tVTE2cnpCcXFLSU05?=
 =?utf-8?B?Z1g1SlBYQXVuZmZxdmJoUEtrRUh0MmpZWmx6MUY4SlBqVUN0aWJ3T2hkbnFW?=
 =?utf-8?B?WGg3T25EL1loNFRnSWNib1RZSVpwZTh3blArOVhwRVREOUVkRWh3TVE5WU93?=
 =?utf-8?B?MDFST3dBdmJBRS9QVnphZXNXWDlOb0RzcGlNTGRhb21pcGRGeTJ0ZzRNUjUr?=
 =?utf-8?B?K1FhQ0gzVmNuSUtibGZLWExVVzdrbHdXZ1RFQ0hBL1IxdWVvWlRBcncvNVh5?=
 =?utf-8?B?QlFZNnE4ZjBBbWlDYm9iUCtKVmNpV3ZnaEJ1VjVabHl5aENzR1NUVS9uZmdI?=
 =?utf-8?B?SkpZTFZUM2dvVWpRbTNDaUpldytIZFNHajJGcXZ5VUNoMTFDREUyN3JJbFJv?=
 =?utf-8?B?SFRUSStvUmtnTDc4eVo3VXNkaGZtNklqblpuOEF4Zis4VDNTU21qM2xBbDVC?=
 =?utf-8?B?anZEQUxWcHZBVFdTY1VJQlJLUUIyaC91ME1Jc2xVTUpFUllnN0pNSnk0dFNS?=
 =?utf-8?B?S3ZYOUVDS2pDVVVnOVkrVW1CSE51UjJjQUFVMDFhRFg5bWJQMG9VeHF5WVpB?=
 =?utf-8?B?c3VHS1FSRVlmTnM3ZWNDbGxicW5aemhaNG5HaHBPemNnNDZucnp4dVdRdW02?=
 =?utf-8?B?RWFMSC8ya0hrR0pxckFVMkpsdks3UVRJRHVMY04rckN0R3I3RHY5U0huWHJD?=
 =?utf-8?B?bkp0eGdVdDVIUEhxbGV2TmRTekQzOEJKeDNNVHlSWTkvdlRTNGM1SFJmR2Vt?=
 =?utf-8?B?bVg5QWNWejhyT1BESWQ1Z0M2QzFuRko4blJKM2kzMkQyS0tJc0tNMDkvYnJq?=
 =?utf-8?B?R2ZoOEN5RzVNajZJeGs0NHd3M3JaQVJaQzU4RW5Gd3Nwc1BlQVVQNjVZeGFD?=
 =?utf-8?B?VUkzZ0F5WVo1VVBPMU9JTUVLc1NJaE5PSWJLLzBueGdyeUVBcXBNcUVwUjky?=
 =?utf-8?B?Y0dTcllYTzNOai81S0krUVNmcmI0OUxvcVM1dXhBaVdnejlJVlJrSklQdFdz?=
 =?utf-8?Q?Ieg1UJkQt+55CVuM1+CKxm/SHfCb3ELRdd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 12:37:19.5979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c87a3f8-28f8-4fc1-09d1-08d89d0855ca
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ws8f2KiRO1tgJeUJrBTRWQAu0O4TyoO/OaduuJzPzFOYnEMBTa/OqsxszJ9H/zCNm5c3j5spsyhVp0Dp5zmPJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
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
Content-Type: multipart/mixed; boundary="===============0754043737=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0754043737==
Content-Type: multipart/alternative;
 boundary="------------F0B07C08AD1A1DC01D585B69"
Content-Language: en-US

--------------F0B07C08AD1A1DC01D585B69
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello Aurabindo,

On 10/12/20 8:15 am, Aurabindo Pillai wrote:
> [Why&How]
> If experimental freesync video mode module parameter is enabled, add
> few extra display modes into the driver's mode list corresponding to common
> video frame rates. When userspace sets these modes, no modeset will be
> performed (if current mode was one of freesync modes or the base freesync mode
> based off which timings have been generated for the rest of the freesync modes)
> since these modes only differ from the base mode with front porch timing.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 197 ++++++++++++++++++
>  1 file changed, 197 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index fbff8d693e03..f699a3d41cad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5178,6 +5178,69 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
>  	set_master_stream(context->streams, context->stream_count);
>  }
>  
> +static struct drm_display_mode *
> +get_highest_freesync_mode(struct amdgpu_dm_connector *aconnector,
> +			  bool use_probed_modes)
the function name is confusing, this function has nothing to do with freesync. Probably drop the 'freesync' from the name, get_highest_refresh_rate_mode or similar ?
> +{
> +	struct drm_display_mode *m, *m_high = NULL;
> +	u16 current_refresh, highest_refresh, preferred_mode_h, preferred_mode_w;
> +	struct list_head *list_head = use_probed_modes ?
> +						    &aconnector->base.probed_modes :
> +						    &aconnector->base.modes;
> +
> +	/*
> +	 * Find the preferred mode
> +	 */
Single line comment should be in /* */
> +
> +	list_for_each_entry (m, list_head, head) {
> +		if (!(m->type & DRM_MODE_TYPE_PREFERRED))
> +			continue;
> +
> +		m_high = m;
> +		preferred_mode_h = m_high->hdisplay;
> +		preferred_mode_w = m_high->vdisplay;
> +		highest_refresh = drm_mode_vrefresh(m_high);
> +		break;
> +	}
> +
> +	if (!m_high) {
> +
> +		/*
> +		 * Probably an EDID with no preferred mode.
> +		 * Fallback to first entry;
> +		 */
> +		m_high = list_first_entry_or_null(&aconnector->base.modes,
> +						  struct drm_display_mode, head);
> +		if (!m_high)
> +			return NULL;
> +		else {
> +			preferred_mode_h = m_high->hdisplay;
> +			preferred_mode_w = m_high->vdisplay;
> +			highest_refresh = drm_mode_vrefresh(m_high);
> +		}
> +	}
> +
> +	/*
> +	 * Find the mode with highest refresh rate with same resolution.
> +	 * For some monitors, preferred mode is not the mode with highest
> +	 * supported refresh rate.
> +	 */
> +	list_for_each_entry (m, list_head, head) {
> +		current_refresh  = drm_mode_vrefresh(m);
> +
> +		if (m->hdisplay == preferred_mode_h &&
> +		    m->vdisplay == preferred_mode_w &&
> +		    highest_refresh < current_refresh) {
> +			highest_refresh = current_refresh;
> +			preferred_mode_h = m->hdisplay;
> +			preferred_mode_w = m->vdisplay;
why do we need to save preferred_mode_h and w variables at all ? I thought the idea here was to get the mode with highest refresh rate, but same resolution, which is indicated in the if (cond) above also. I think we just need highest refresh rate isn't ?
> +			m_high = m;
> +		}
> +	}
> +
> +	return m_high;
> +}
> +
>  static struct dc_stream_state *
>  create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>  		       const struct drm_display_mode *drm_mode,
> @@ -7006,6 +7069,139 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
>  	}
>  }
>  
> +static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
> +			      struct drm_display_mode *mode)
> +{
> +	struct drm_display_mode *m;
> +
> +	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
> +		if (m->clock == mode->clock &&
> +		    m->htotal == mode->htotal &&
> +		    m->vtotal == mode->vtotal &&
> +		    m->hdisplay == mode->hdisplay &&
> +		    m->vdisplay == mode->vdisplay &&
> +		    m->hsync_start == mode->hsync_start &&
> +		    m->vsync_start == mode->vsync_start &&
> +		    m->vsync_end == mode->vsync_end &&
> +		    m->hsync_end == mode->hsync_end)
> +			return true;
> +	}
> +
> +	return false;
Why not usedrm_mode_equal() instead ?
> +}
> +
> +static uint add_fs_modes(struct amdgpu_dm_connector *aconnector,
> +			 struct detailed_data_monitor_range *range)
> +{
> +	const struct drm_display_mode *m, *m_save;
> +	struct drm_display_mode *new_mode;
> +	uint i;
> +	uint64_t target_vtotal, target_vtotal_diff;
> +	uint32_t new_modes_count = 0;
> +	uint64_t num, den;
> +
> +	/* Standard FPS values
> +	 *
> +	 * 23.976 - TV/NTSC
> +	 * 24	  - Cinema
> +	 * 25     - TV/PAL
> +	 * 29.97  - TV/NTSC
> +	 * 30     - TV/NTSC
> +	 * 48	  - Cinema HFR
> +	 * 50	  - TV/PAL
> +	 */
> +	const uint32_t neededrates[] = { 23976, 24000, 25000, 29970,
> +					 30000, 48000, 50000, 72000, 96000 };
> +
> +	/*
> +	 * Find mode with highest refresh rate with the same resolution
> +	 * as the preferred mode. Some monitors report a preferred mode
> +	 * with lower resolution than the highest refresh rate supported.
> +	 */
> +
> +	m_save = get_highest_freesync_mode(aconnector, true);
A NULL return check here to bypass the whole routine below ?
> +
> +	list_for_each_entry (m, &aconnector->base.probed_modes, head) {
> +		if (m != m_save)
> +			continue;
> +
> +		for (i = 0; i < sizeof(neededrates) / sizeof(uint32_t); i++) {
> +			if (drm_mode_vrefresh(m) * 1000 < neededrates[i])
> +				continue;
> +
> +			if (neededrates[i] < range->min_vfreq * 1000)
> +				continue;
> +
> +			num = (unsigned long long)m->clock * 1000 * 1000;
> +			den = neededrates[i] * (unsigned long long)m->htotal;
> +			target_vtotal = div_u64(num, den);
> +			target_vtotal_diff = target_vtotal - m->vtotal;
> +
> +			/*
> +			 * Check for illegal modes
> +			 */
Same here for single line comment
> +			if (m->vsync_start + target_vtotal_diff < m->vdisplay ||
> +			    m->vsync_end + target_vtotal_diff < m->vsync_start ||
> +			    m->vtotal + target_vtotal_diff < m->vsync_end)
> +				continue;
> +
> +			new_mode = drm_mode_duplicate(aconnector->base.dev, m);
> +			if (!new_mode)
> +				goto out;
> +
> +			new_mode->vtotal += (u16)target_vtotal_diff;
> +			new_mode->vsync_start += (u16)target_vtotal_diff;
> +			new_mode->vsync_end += (u16)target_vtotal_diff;
> +			new_mode->type &= ~DRM_MODE_TYPE_PREFERRED;
> +			new_mode->type |= DRM_MODE_TYPE_DRIVER;
> +			strcat(new_mode->name, "_FSV\0");
> +
> +			if (!is_duplicate_mode(aconnector, new_mode)) {
or drm_mode_equal here ?
> +				drm_mode_probed_add(&aconnector->base, new_mode);
> +				new_modes_count += 1;
> +			} else
> +				drm_mode_destroy(aconnector->base.dev, new_mode);
> +		}
> +	}
> + out:
> +	return new_modes_count;
> +}
> +
> +static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
> +						   struct edid *edid)
> +{
> +	uint8_t i;
> +	struct detailed_timing *timing;
> +	struct detailed_non_pixel *data;
> +	struct detailed_data_monitor_range *range;
> +	struct amdgpu_dm_connector *amdgpu_dm_connector =
> +		to_amdgpu_dm_connector(connector);
> +
> +	if (!(amdgpu_exp_freesync_vid_mode && edid))
> +		return;
> +
> +	if (!(amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP ||

do we want the freesync infra to be available for eDP also ?

- Shashank

> +	      amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
> +	      amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A))
> +		return;
> +
> +	if (edid->version == 1 && edid->revision > 1) {
> +		for (i = 0; i < 4; i++) {
> +			timing = &edid->detailed_timings[i];
> +			data = &timing->data.other_data;
> +			range = &data->data.range;
> +			/*
> +			 * Check if monitor has continuous frequency mode
> +			 */
> +			if (data->type == EDID_DETAIL_MONITOR_RANGE &&
> +			    range->max_vfreq - range->min_vfreq > 10) {
> +				amdgpu_dm_connector->num_modes += add_fs_modes(amdgpu_dm_connector, range);
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>  static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>  {
>  	struct amdgpu_dm_connector *amdgpu_dm_connector =
> @@ -7021,6 +7217,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>  	} else {
>  		amdgpu_dm_connector_ddc_get_modes(connector, edid);
>  		amdgpu_dm_connector_add_common_modes(encoder, connector);
> +		amdgpu_dm_connector_add_freesync_modes(connector, edid);
>  	}
>  	amdgpu_dm_fbc_init(connector);
>  

--------------F0B07C08AD1A1DC01D585B69
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hello Aurabindo,<br>
    </p>
    <div class="moz-cite-prefix">On 10/12/20 8:15 am, Aurabindo Pillai
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">[Why&amp;How]
If experimental freesync video mode module parameter is enabled, add
few extra display modes into the driver's mode list corresponding to common
video frame rates. When userspace sets these modes, no modeset will be
performed (if current mode was one of freesync modes or the base freesync mode
based off which timings have been generated for the rest of the freesync modes)
since these modes only differ from the base mode with front porch timing.

Signed-off-by: Aurabindo Pillai <a class="moz-txt-link-rfc2396E" href="mailto:aurabindo.pillai@amd.com">&lt;aurabindo.pillai@amd.com&gt;</a>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fbff8d693e03..f699a3d41cad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5178,6 +5178,69 @@ static void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 	set_master_stream(context-&gt;streams, context-&gt;stream_count);
 }
 
+static struct drm_display_mode *
+get_highest_freesync_mode(struct amdgpu_dm_connector *aconnector,
+			  bool use_probed_modes)</pre>
    </blockquote>
    the function name is confusing, this function has nothing to do with
    freesync. Probably drop the 'freesync' from the name,
    get_highest_refresh_rate_mode or similar ? <br>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+{
+	struct drm_display_mode *m, *m_high = NULL;
+	u16 current_refresh, highest_refresh, preferred_mode_h, preferred_mode_w;
+	struct list_head *list_head = use_probed_modes ?
+						    &amp;aconnector-&gt;base.probed_modes :
+						    &amp;aconnector-&gt;base.modes;
+
+	/*
+	 * Find the preferred mode
+	 */</pre>
    </blockquote>
    Single line comment should be in /* */<br>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+	list_for_each_entry (m, list_head, head) {
+		if (!(m-&gt;type &amp; DRM_MODE_TYPE_PREFERRED))
+			continue;
+
+		m_high = m;
+		preferred_mode_h = m_high-&gt;hdisplay;
+		preferred_mode_w = m_high-&gt;vdisplay;
+		highest_refresh = drm_mode_vrefresh(m_high);
+		break;
+	}
+
+	if (!m_high) {
+
+		/*
+		 * Probably an EDID with no preferred mode.
+		 * Fallback to first entry;
+		 */
+		m_high = list_first_entry_or_null(&amp;aconnector-&gt;base.modes,
+						  struct drm_display_mode, head);
+		if (!m_high)
+			return NULL;
+		else {
+			preferred_mode_h = m_high-&gt;hdisplay;
+			preferred_mode_w = m_high-&gt;vdisplay;
+			highest_refresh = drm_mode_vrefresh(m_high);
+		}
+	}
+
+	/*
+	 * Find the mode with highest refresh rate with same resolution.
+	 * For some monitors, preferred mode is not the mode with highest
+	 * supported refresh rate.
+	 */
+	list_for_each_entry (m, list_head, head) {
+		current_refresh  = drm_mode_vrefresh(m);
+
+		if (m-&gt;hdisplay == preferred_mode_h &amp;&amp;
+		    m-&gt;vdisplay == preferred_mode_w &amp;&amp;
+		    highest_refresh &lt; current_refresh) {
+			highest_refresh = current_refresh;
+			preferred_mode_h = m-&gt;hdisplay;
+			preferred_mode_w = m-&gt;vdisplay;</pre>
    </blockquote>
    why do we need to save preferred_mode_h and w variables at all ? I
    thought the idea here was to get the mode with highest refresh rate,
    but same resolution, which is indicated in the if (cond) above also.
    I think we just need highest refresh rate isn't ? <br>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			m_high = m;
+		}
+	}
+
+	return m_high;
+}
+
 static struct dc_stream_state *
 create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		       const struct drm_display_mode *drm_mode,
@@ -7006,6 +7069,139 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 	}
 }
 
+static bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
+			      struct drm_display_mode *mode)
+{
+	struct drm_display_mode *m;
+
+	list_for_each_entry (m, &amp;aconnector-&gt;base.probed_modes, head) {
+		if (m-&gt;clock == mode-&gt;clock &amp;&amp;
+		    m-&gt;htotal == mode-&gt;htotal &amp;&amp;
+		    m-&gt;vtotal == mode-&gt;vtotal &amp;&amp;
+		    m-&gt;hdisplay == mode-&gt;hdisplay &amp;&amp;
+		    m-&gt;vdisplay == mode-&gt;vdisplay &amp;&amp;
+		    m-&gt;hsync_start == mode-&gt;hsync_start &amp;&amp;
+		    m-&gt;vsync_start == mode-&gt;vsync_start &amp;&amp;
+		    m-&gt;vsync_end == mode-&gt;vsync_end &amp;&amp;
+		    m-&gt;hsync_end == mode-&gt;hsync_end)
+			return true;
+	}
+
+	return false;</pre>
    </blockquote>
    Why not use<span style="color: #dcdcaa;"> drm_mode_equal() instead ?<br>
    </span>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+}
+
+static uint add_fs_modes(struct amdgpu_dm_connector *aconnector,
+			 struct detailed_data_monitor_range *range)
+{
+	const struct drm_display_mode *m, *m_save;
+	struct drm_display_mode *new_mode;
+	uint i;
+	uint64_t target_vtotal, target_vtotal_diff;
+	uint32_t new_modes_count = 0;
+	uint64_t num, den;
+
+	/* Standard FPS values
+	 *
+	 * 23.976 - TV/NTSC
+	 * 24	  - Cinema
+	 * 25     - TV/PAL
+	 * 29.97  - TV/NTSC
+	 * 30     - TV/NTSC
+	 * 48	  - Cinema HFR
+	 * 50	  - TV/PAL
+	 */
+	const uint32_t neededrates[] = { 23976, 24000, 25000, 29970,
+					 30000, 48000, 50000, 72000, 96000 };
+
+	/*
+	 * Find mode with highest refresh rate with the same resolution
+	 * as the preferred mode. Some monitors report a preferred mode
+	 * with lower resolution than the highest refresh rate supported.
+	 */
+
+	m_save = get_highest_freesync_mode(aconnector, true);</pre>
    </blockquote>
    A NULL return check here to bypass the whole routine below ? <br>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+	list_for_each_entry (m, &amp;aconnector-&gt;base.probed_modes, head) {
+		if (m != m_save)
+			continue;
+
+		for (i = 0; i &lt; sizeof(neededrates) / sizeof(uint32_t); i++) {
+			if (drm_mode_vrefresh(m) * 1000 &lt; neededrates[i])
+				continue;
+
+			if (neededrates[i] &lt; range-&gt;min_vfreq * 1000)
+				continue;
+
+			num = (unsigned long long)m-&gt;clock * 1000 * 1000;</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			den = neededrates[i] * (unsigned long long)m-&gt;htotal;
+			target_vtotal = div_u64(num, den);
+			target_vtotal_diff = target_vtotal - m-&gt;vtotal;
+
+			/*
+			 * Check for illegal modes
+			 */</pre>
    </blockquote>
    Same here for single line comment<br>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			if (m-&gt;vsync_start + target_vtotal_diff &lt; m-&gt;vdisplay ||
+			    m-&gt;vsync_end + target_vtotal_diff &lt; m-&gt;vsync_start ||
+			    m-&gt;vtotal + target_vtotal_diff &lt; m-&gt;vsync_end)
+				continue;
+
+			new_mode = drm_mode_duplicate(aconnector-&gt;base.dev, m);
+			if (!new_mode)
+				goto out;
+
+			new_mode-&gt;vtotal += (u16)target_vtotal_diff;
+			new_mode-&gt;vsync_start += (u16)target_vtotal_diff;
+			new_mode-&gt;vsync_end += (u16)target_vtotal_diff;
+			new_mode-&gt;type &amp;= ~DRM_MODE_TYPE_PREFERRED;
+			new_mode-&gt;type |= DRM_MODE_TYPE_DRIVER;
+			strcat(new_mode-&gt;name, &quot;_FSV\0&quot;);
+
+			if (!is_duplicate_mode(aconnector, new_mode)) {</pre>
    </blockquote>
    or drm_mode_equal here ?<br>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+				drm_mode_probed_add(&amp;aconnector-&gt;base, new_mode);
+				new_modes_count += 1;
+			} else
+				drm_mode_destroy(aconnector-&gt;base.dev, new_mode);
+		}
+	}
+ out:
+	return new_modes_count;
+}
+
+static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
+						   struct edid *edid)
+{
+	uint8_t i;
+	struct detailed_timing *timing;
+	struct detailed_non_pixel *data;
+	struct detailed_data_monitor_range *range;
+	struct amdgpu_dm_connector *amdgpu_dm_connector =
+		to_amdgpu_dm_connector(connector);
+
+	if (!(amdgpu_exp_freesync_vid_mode &amp;&amp; edid))
+		return;</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+	if (!(amdgpu_dm_connector-&gt;dc_sink-&gt;sink_signal == SIGNAL_TYPE_EDP ||</pre>
    </blockquote>
    <p>do we want the freesync infra to be available for eDP also ? <br>
    </p>
    <p>- Shashank<br>
    </p>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	      amdgpu_dm_connector-&gt;dc_sink-&gt;sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	      amdgpu_dm_connector-&gt;dc_sink-&gt;sink_signal == SIGNAL_TYPE_HDMI_TYPE_A))
+		return;
+
+	if (edid-&gt;version == 1 &amp;&amp; edid-&gt;revision &gt; 1) {
+		for (i = 0; i &lt; 4; i++) {
+			timing = &amp;edid-&gt;detailed_timings[i];
+			data = &amp;timing-&gt;data.other_data;
+			range = &amp;data-&gt;data.range;
+			/*
+			 * Check if monitor has continuous frequency mode
+			 */
+			if (data-&gt;type == EDID_DETAIL_MONITOR_RANGE &amp;&amp;
+			    range-&gt;max_vfreq - range-&gt;min_vfreq &gt; 10) {
+				amdgpu_dm_connector-&gt;num_modes += add_fs_modes(amdgpu_dm_connector, range);
+				break;
+			}
+		}
+	}
+}
+
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -7021,6 +7217,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
 		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
 
</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20201210024526.1151447-3-aurabindo.pillai@amd.com">
    </blockquote>
  </body>
</html>

--------------F0B07C08AD1A1DC01D585B69--

--===============0754043737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0754043737==--
