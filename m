Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75735C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 22:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB01410E301;
	Thu,  3 Feb 2022 22:54:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA7410E301
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 22:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVQXa6jpjS4wTRBthVFcp3FvSEt7ug+A4kacjgRqRRWl1Sg4UjiCNoa7ecUq0HOAUkjIREnDMecDmwD+qFUHxkern/rodcIq/IWhX1+rxIOv+T+jtP84b2FOByw0VDhlrbePJ6n5HtJE+7YmShEeKZL3iQIxd6wk286drI8RnLhcMvL1DomlH0Dn7PvjfYPe3tRIwoPHQOnR4IwwqKedJQiVnA4GqlzNpL1U+K9BUiDSpECN1Oj9lbatC+1ew0YnHm9wug3yJ0IjIsjk0VJ7nxL9B586gRyxxu0ii4yVrGABlUQHYSCVZw6JC+3CD4JAPLHtp2qFHBM+SkE7nv9SKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27+gJ53GgkvhRgpjeRCBDAxywlH7H/Rm6glvdn1PYVs=;
 b=EsY7TF+8ZsaBdDeAq0GiuY1eRM62oNPey+83NlMqwDJoFxloZdSvUc6Qh4/iTsBl43Yt1bwYYXbB2dm4WYvYlCEiLxfLQQSJHyZFbt1kh0GSHyQnh93BKZX101tSB5s5NPrEVDoVc0dfZJNEJIoDw5lz72S3/dTNME5E5RZNGfcy8ZeVM8JtQFH1Z08x6/fjxfUmnaL0LgbfVslReMvJ+2BUInCNDyNo8YdsndbrBSxXwl+JtyqP2ZQOQHu8NLFhuf8LB0PVl7ookkCnz7heYo/B8xQqQNTtReoJzzg4x/D2magbzLIYgFj8kw/XbYO+vkqxghswlqZMZWvrDupi8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27+gJ53GgkvhRgpjeRCBDAxywlH7H/Rm6glvdn1PYVs=;
 b=tiprLZY0HbnzSkCs2lw6/N2QZSbsYKh6GhYlK7FehEq5OUpn1b1p2eiOqLlPOb8jX0QNtEbAlMR7Z4Yv2NTB8xEqJkod5M8k7Rjh+GvEBLv/L9QaCDb0r9yMjHFGXodc70kv3eP8CT1BxMjJuNJIFcUWetP+NDCdgja2l3c5mvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM6PR12MB5697.namprd12.prod.outlook.com (2603:10b6:5:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 22:54:07 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::447c:dc61:6f9:a602]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::447c:dc61:6f9:a602%7]) with mapi id 15.20.4951.013; Thu, 3 Feb 2022
 22:54:07 +0000
Message-ID: <16a2f9fa-475a-17ea-49dd-0108d68e9b45@amd.com>
Date: Thu, 3 Feb 2022 17:54:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amd/display: Cap pflip irqs per max otg number
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, hersenxs.wu@amd.com, shirish.s@amd.com,
 Jordan.Lazare@amd.com
References: <1643926482-17226-1-git-send-email-Roman.Li@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <1643926482-17226-1-git-send-email-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0395.namprd03.prod.outlook.com
 (2603:10b6:610:11b::12) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be302862-ccc6-4144-fd8d-08d9e7681549
X-MS-TrafficTypeDiagnostic: DM6PR12MB5697:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5697E9DFDE2605EAE548372CEC289@DM6PR12MB5697.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Vd+eFevJxMgRm/8B1pxaGSfxU+18t5erqVURK4T43yCojsw3ZyWKp9HhMrZ3s2b1MBdDJUKd7TfkxOSXTrXuEYE4bQt6lZSuWDUdTk7zvPT3r6ME5MzDNpWFw7pLrV1U0yTggrqikyD8qJBer3E8RbUCaljnfUKt/5VKG8AAWiWMuJVRwXMYKgJc9TE75I5uy1O4ImOo92bvC0+Y+pNygMFcsAPQbXooRc5p2aNHYlULswtDqWTQ38+HSWnqjVYzmFoRPep50fRi7UtUkF8EbdBW49t/JzqGFgl2mH6gStHTmuh4DlywdHNhsbISn8iqqCH/jpkNuGNo7ue3IRKGfVG3DnxHSfMOlgl5jQVT0bNNQd3byJWss+15WoLnZ0MY+ga7dG4BPwHGmUjtKOD+ZY0emHBzumxDxxX2SggvPmgneV5dB5d3SCa+jv1zFnhEBGbIoBXGz0hXV7/ZTiB/fMQYpLXGdybE8Q5L2wTrSAvc34U7g4v4qQ6GxqEJKXfz+vq134v7+H8SJsgXXA4XW//jvfmjb0j74YBbH/hYkzvnFtnnGO5Mw5B6zqo6TjnylxouEDNSqId9nLsc7/6nhE5MBf+rNE/EFF7choMYiWrWl4GUaxgt/OxHiNEeALIGHzUppSfOjQhU2x1eRi6VEQqR83CBPRyGwApTD3sP2aabEsjB5oAJgWw8HZoptuPDWx0S/XVceAJ5kXvWtZdrdXSEX5588SFY3480MDZ/bbNGSGmw6WbxfWjiFqEsubY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(6636002)(38100700002)(83380400001)(508600001)(2616005)(316002)(31686004)(36756003)(6486002)(186003)(26005)(8676002)(2906002)(8936002)(66946007)(66556008)(86362001)(53546011)(66476007)(5660300002)(6512007)(6666004)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWYra0JsU2hnNUNWZ0w3T0tYdGMyMjhDOTZzSGYvVGxQejVycDZGQ2gyMFVF?=
 =?utf-8?B?eGd1T3VTUjdSQWNzU1B1QWswUmNKMUw3VWJzVTZzTHcxWTRHcUIrWHRRWHhM?=
 =?utf-8?B?ZlgzSUN1RXYrSXo2NWc4WTB5MmJrSy9tQXd4VUh6WFcxc1VwU0Y0RFpYZzN4?=
 =?utf-8?B?SHBNL2RUdnc5cUw3cEU5N1dEOTdydEVsWDdxSXl0ZG5kTVpMKy9oMnAzREhx?=
 =?utf-8?B?QWhyaEdnOWxxODhySXNPTzVQaktHWW1zbUNXYm54dGZYMDI5NllSUnlYM052?=
 =?utf-8?B?RXZMR08zUldzNm94ZFB6NExlUE85Uk1jYmNnbmdkSzdCekh4TTZNOUIzSGYx?=
 =?utf-8?B?VDhsSnprVGxJb2txM0tjdnVOSzJlWGZUTlJWVEVBZ1BtWklTbXhlTzVNb25s?=
 =?utf-8?B?MWRuSUxGdHY3dFkyTUhKczZuK1lyOGkzSnFBeUdsTEZUY0hRZCtraTE2RVF0?=
 =?utf-8?B?RDl4aEY3K0F1R1l0NjZSa2Njb2FDU2lyYzBlZ1F3UWZGbFZaRjZtMkFoRytZ?=
 =?utf-8?B?T0Y5MHljNXhubzgxUUxXQVpJRDg5Z2ZTMDFwUlp2bjk3Y3hIU1czZ2FzYkVp?=
 =?utf-8?B?THhETUtOb0F4TEFnL01JL3dkcUNwQ3VBd3dwWjM4c2lrUnl0dDJIWXNabVR1?=
 =?utf-8?B?WXEwQkdYQUdWVHNvT2FvK0JZREVKOWxTd0pZUTlNMitld1cxczg0bGltWnE2?=
 =?utf-8?B?c1NrTHkxU1lzZUc1ZmtkeUxRMExqb2VRN1JvVjViSkxLcWd0cHI3MCtlRkYr?=
 =?utf-8?B?UmNUUjdDOEpldis5Z1FZeFVOMHM5cDdKVlllYW50Q1FrZGhoZ2RYOFRON3B2?=
 =?utf-8?B?TmUxdktMdzQ0OHRQYVZ4VXdvQzIrczRxK2FCNU5NTEpuelVqWkNtSDk2Nity?=
 =?utf-8?B?YTdMK0lTNHdoa0tmWFNmUVlxVTU4VUFuQ1hpWSt1Z24wL0k3NXkrNGxGYVEx?=
 =?utf-8?B?cytsTjI3U1BiT0pWNkt2WWJmZnpUbnVOT2JSVlJjMmliVGtsQU96QzlNWnZu?=
 =?utf-8?B?WDMvY2JJcGxIMENQcTUyRDR5M1ZqWS90L2RKYWtsRXVESEw4dmYwT1BKcEFn?=
 =?utf-8?B?Q2ZHNng0bnM0ODhnckw5MURBRzROZlFoYzR0MVYyQklmcXNXR3FlbS9yTVVa?=
 =?utf-8?B?QXlJQW1BQ2swc0NMd3JOcHpYYU9JMmNvRkM1QTBkZFI2NE1nU3phUE1zd1lZ?=
 =?utf-8?B?MHRYeEdwNVR5UXFEV2JwMElDTTI4QWJ0RGNqU21odHVVU1NlME82ZFgzcWgy?=
 =?utf-8?B?SnpzazBlKzNLUklEL0I5STFnc2R5SERNaEJpZGVuS2pGV2h6dWJQZEsyMnB2?=
 =?utf-8?B?RjZQRGxWcUxDbDdzQ0NxWHYvNERlTGVoc1lCODZ3SzZ5UDZBK1hzMFlCS1JD?=
 =?utf-8?B?dXM1L0VyMEhINjNVbWVLWVYxQjR1QWViMFg0ZGx0WHkySjFWRnd0aUZCc3Ft?=
 =?utf-8?B?aWpDRWlsdGVKUU1Hcnk1YzVzaXV4aC9mWS9OWU54ZENINk5xd3JneGpOVTB6?=
 =?utf-8?B?elA3bnFrc21xQTRac2d3NFpsTHFabm01Q1JKNzB0d3VNQlhlTnhFVVp3RmFl?=
 =?utf-8?B?TE5XMm80UktKT3dsUmM1ZEwwR215TXkvU3NyY25HK1plSHhwcWNjNkNzMDNR?=
 =?utf-8?B?OVk2MFJJd2YwOUpyM1pVbG9UOVAreFRuRXpsL2M5M0Z2K1cxa25TUzkxMUN1?=
 =?utf-8?B?NXhFRjg1MmJ6M2xUd1FoUHNGWU1zOGIwMFBldzRGbmNaR1RhZ1JzdkVhcGtq?=
 =?utf-8?B?N2ZTSFlUbllNNnJuSzRvbzVWaGQ4UjBBdG1HWUNQcEcyTmNpRVJxVjJEa1Fs?=
 =?utf-8?B?cG1BWFhjOUNWR2dmdEhjKzBtcjJTdEVTNk1jUWpHNi9SRTBVN1psKzhFRG5h?=
 =?utf-8?B?N1Z3OVpLeXU1N2h4MU1zN2Y0NThjLzFxUStOekx2elc3QXQvOUJCREVDS0xG?=
 =?utf-8?B?M3FBb0tXOHc3aDZnaTBEYmFYYW9Ga1pQRVFReTVDMlpWcVRBZVNXOWJyZjJ6?=
 =?utf-8?B?eE04c3E2WEJDNWpPMmJlb3R5aVFMMGUrdDJUNDdKZldKaFpTR3lONVNVZ0JC?=
 =?utf-8?B?bDE0UEhqdEl3cEVpNHVFZE44NTQyeVNTMEFKL2NMT2ZSWG43aE4xTG5ScHZE?=
 =?utf-8?B?UVM1L212RWppcURmZkhQTVgwSkxHZ3VsNXZYVVpCNzFEcUtGNjlWVHFJSFJJ?=
 =?utf-8?Q?/zen5gzDoUZsBLAc7FPqRA8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be302862-ccc6-4144-fd8d-08d9e7681549
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 22:54:07.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPQVcSjLtNlfn9LWKvUnzEpB8Qq+wDaR8EvSq1dRgWLV47JEAQwB8KQD2K3LFIkxD74oHDZH4NgTr+kyqDwDcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5697
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

On 2/3/2022 5:14 PM, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> pflip interrupt order are mapped 1 to 1 to otg id.
> e.g. if irq_src=26 corresponds to otg0 then 27->otg1, 28->otg2...
> 
> Linux DM registers pflip interrupts per number of crtcs.
> In fused pipe case crtc numbers can be less than otg id.
> 
> e.g. if one pipe out of 3(otg#0-2) is fused adev->mode_info.num_crtc=2
> so DM only registers irq_src 26,27.
> This is a bug since if pipe#2 remains unfused DM never gets
> otg2 pflip interrupt (irq_src=28)
> That may results in gfx failure due to pflip timeout.
> 
> [How]
> Register pflip interrupts per max num of otg instead of num_crtc
> 
> Signed-off-by: Roman Li <Roman.Li@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/core/dc.c          | 2 ++
>   drivers/gpu/drm/amd/display/dc/dc.h               | 1 +
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8f53c9f..10ca3fc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3646,7 +3646,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
>   
>   	/* Use GRPH_PFLIP interrupt */
>   	for (i = DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT;
> -			i <= DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT + adev->mode_info.num_crtc - 1;
> +			i <= DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT + dc->caps.max_otg_num - 1;
>   			i++) {
>   		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->pageflip_irq);
>   		if (r) {
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 1d9404f..70a0b89 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1220,6 +1220,8 @@ struct dc *dc_create(const struct dc_init_data *init_params)
>   
>   		dc->caps.max_dp_protocol_version = DP_VERSION_1_4;
>   
> +		dc->caps.max_otg_num = dc->res_pool->res_cap->num_timing_generator;
> +
>   		if (dc->res_pool->dmcu != NULL)
>   			dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
>   	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 69d264d..af05877 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -200,6 +200,7 @@ struct dc_caps {
>   	bool edp_dsc_support;
>   	bool vbios_lttpr_aware;
>   	bool vbios_lttpr_enable;
> +	uint32_t max_otg_num;
>   };
>   
>   struct dc_bug_wa {

