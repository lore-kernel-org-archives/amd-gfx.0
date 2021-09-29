Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1164DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 21:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B660261462
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 21:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B660261462
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0DE89BBE;
	Wed, 29 Sep 2021 21:02:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37CA89BBE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 21:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6RVVKbgsIeagXqD41yYjqzzjYUqxzZw48ZwkQ27MapxHEB+eNzuKHBWC/BFuIrd9jyebniWOaDdChSfPEKQNiP9mlHw5UqzTlEPUhFIkX6Yla7YN3tEdFeaufGb90pvT9lVlY7FLAv2IAOyYmAd/E4fUG9l8rWi0TuZRbO8QOIi/902MtMwsQCziCBCdSDcNb40Lpx/hFTu0GT3yKTtMIxa1qPUIhjIhmX+3T1DViJpWCnKdvqh9yXKtw2M9UHszHid3nZVtjQqoU2CXnmjBWtS1MhbnS5a7FSBFkJliIlPADmXs8bCc0ArFU94F5qFxF3Vjqr6KkGbnZGqyEjrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ipRYePFmWm+M4pNLKOGsHBMqMsUvX/Z0yX/ryTfCV84=;
 b=ABWxZTmug5Jsx4wC3xSF8vQt/Me0+zreeUS+F3J20SZvZLKhrCbZX2o94NSLj/jhka6MpvE3UDTgC++xTh4BUf9tu6GHPDXzWt1yVs+pnaK9qz/Js5fcQgjiXf7B06X2eSDxXuD9wVTbJ9zSTkB1/kGYhCdVORZvX6gSjVd1ZFiXdF5l9noyIXC/52w23hhr5CcqrKAUrn/VO6VPgB04gyCVbbOBnmr2sBsF2gvLmD9zs3y1ngl+e9WXBORJIkVK/Kgth+nkA1BhSLh876LYCAJYo1PhLJ96YdUoM08yS59ZLS1bm+OzKKhm9+tN2Gcs7zuoIV3CiiSN7tZZtdLlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipRYePFmWm+M4pNLKOGsHBMqMsUvX/Z0yX/ryTfCV84=;
 b=ZeK4a5oICzCxPFoK914gaRODAI7GBgo14WsoCVR4eLx+vKWaZZKZnM3yrs6VZu7LZrkeA+zGiVqITz2bN1cqb1+5bHNaUoiOQae+YZVFYk3VQFpBg+la3XTuZJ2v3n+0v0qNNRjFDEYS+n00NmEV44h5nTilwS+5z79ydReKJ3Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 21:02:45 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 21:02:45 +0000
Message-ID: <8ebb5de7-f168-4f5d-3d7b-9f9c4431504b@amd.com>
Date: Wed, 29 Sep 2021 17:02:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] drm/amdgpu/display: protect DCN specific stuff in
 process_deferred_updates
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Michael Strauss <michael.strauss@amd.com>, Eric Yang
 <Eric.Yang2@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210929203607.1946811-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210929203607.1946811-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0250.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0250.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 21:02:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae46af6e-e982-4c8a-c506-08d9838c7bf6
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB544409561F1DD0AE7C8F853E8CA99@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Va1a9SFt2/NTtwVIPm953HyCoAXeQRnEvkmmWKODWW3V7lZX+iV+oG17C29KKcR9xqtXPGDSmDMdNYHt3svOQ1x7KbnaL4bPUB/I4zCZRaCSYiS+52gq1yivEWP7IEcy3oczlTIf3Hd9Zusa9zmf1T9xn1VNkNLrw5f/ZvRF2L+Hz4vKc4yL5PV435V8UzO9RfQDJBlEI5QKibsHk+NLaIaX0v+fr6AeYIatOtThOXpqYsR6l0GCoDWK/aZGu4G9kWkpApPJSKYVDS4U0PXiyESMtSF827urAJJNRzMhBfAOYBZoatOEwD004xg/lY3iUxkhCxTGBj+mRvm8rDxlqmEYH1XqNRrC+DdSu56oaeG4UzqrOJL3mfJq6eDnK0UszK2hUXxfp5WL9/RZMT27/uWyfNN6wE120kga+E+F/T6cbG9pS4pNiKTQmOjpVROWcgCGiQrGX1GOUkmIM0J/BJpazMzWP9wPDN1YsCgi3VF8QeNCJADW1Jm8jmDosaBUggIjc7n0xsqva/1xPm6pvZrT9OoaYseXtsqBNwU0pxV0PcUI5BAM6a22TVNZ8mbj5TfMcP662rnDfgje5Oi3v0my9AfRLdpkmiw36Nr6Z6cvKZBweN/P9ptFYcGWMWjega2eW+2Uy5nq5Tys3CBTwiLggikCQyRO2ORUskRPxqwGNsufgluCYbb5a/u7V1tVUneVUvSzAz4KSU4F4KE80PANH/J0Vjy4g7oesRN4Eze42nhuDY0/ZYITJ3PsBFd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(54906003)(4326008)(6486002)(16576012)(38100700002)(8936002)(2906002)(66556008)(66476007)(66946007)(5660300002)(44832011)(53546011)(956004)(8676002)(316002)(86362001)(83380400001)(2616005)(31686004)(186003)(508600001)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU55QjgwbGJNd3d1SldydDhtd2UyU0lkajlwbkh3RjJBMkQ3QmQ4bDQxbVRR?=
 =?utf-8?B?ZTcvckNmR084c016bXY3azdDZWpRNWVZNG1Odm9mQlFEY21NbTJOWUE1WkR2?=
 =?utf-8?B?VGp6aG1qZnFDUEdIMTA3ZXF3L2Y4QmJpd2hpVWVNa1RKSTJWeTF1TVZtTU9j?=
 =?utf-8?B?RmdRSFpWN2YrSktNWG0vTVpRbmdHWTRjTjJSMmp3WEZBN2F4LytLRzJ1eXNu?=
 =?utf-8?B?QVZvK01EOGZiLzdUQlRCeCtDRk80WTY5azNZNTF1d1BLb1V2L3p3ZXRCS05J?=
 =?utf-8?B?UjVLalFhODhuZkNJTnpxY2ttN0ZBTVVJaFpDWDNuSFZVMEtlZkxjWmhXUjQy?=
 =?utf-8?B?Rkl6WitidUIvQVFKWDU1TTRrSnI3OE5jaERGVmJzR2h5Ry93MDM1dFFWTW5U?=
 =?utf-8?B?ZXU5NkxUa1luc04rc1JQRi9MQkRNQ24rOTJSeTZpTkpCc3JpSm1QTWt2bXpI?=
 =?utf-8?B?eFFRY3NiUUhCMVNyb0lLTG4xdis0NFUyRjZZOXg3QjczbGZ6ZUFiNGZpc2wx?=
 =?utf-8?B?UzBKQ3owamRMZVNiZnQrRkkzTHFzV0lXODB4YjlOM3NRTkFib0lFQTdOeFF4?=
 =?utf-8?B?Y0tWTTNISlArVWE0OS9xUXo1YkV5Uk90OGVUcE5YSFl6OVhyNlZpZWNzblJD?=
 =?utf-8?B?ay9EKy9DMjMycmhTMWxtSnI4eThERSsrRlRpYnZvT081azhUNzVaR3FQSEdh?=
 =?utf-8?B?WTFoeDYrZDVsOTFxM0kzOFAzN3g1UmpENGpoWVI3WlUyQ3JUM3lRWFpwOHlG?=
 =?utf-8?B?cWZXOHdSNGVHcTNmcmE2Z0VpVTVoMHVnYlVGQXp1V0lrQlJFdEZ2aXhrQnhM?=
 =?utf-8?B?VW1TTTZpUFRVdTZYL2tTcmp6bjJ0OG1HRFBzSG8rcXEya0VjaEtkaytYL3pt?=
 =?utf-8?B?RnpmcjRMRk8vSjZwOVBHa2hxRXhHa0E3aGgrL2NCMDJnbTBhRjl5MXExZ253?=
 =?utf-8?B?azk5U0hWYWlpc2ZwRUpWQ2ZlVnoveUxSZXltakJhR3dmWW5aY3NRUDRrR2lz?=
 =?utf-8?B?d3gxdkdpUGNWeVZBaDFWekxLU3BiRnlVT0lPVHVSS2FaVUhseU1vaHl3VWQ3?=
 =?utf-8?B?dmdxRzNrRStFTGRFSFM0QzFoMU5QUkVjRjNhdXBNbE8yU0t1TDVQNncyU2J2?=
 =?utf-8?B?V3UyOGY0OC9NSW1oUmNFeUdLMUpzaUtKdnIyU1dVSzVhUE9iT1VzNG9mKzJG?=
 =?utf-8?B?dGw2clFyNnJtTHozZUFmam1RWGRmUVBtdFB4bTY2QTBTSElRbGlaRmlBbnVU?=
 =?utf-8?B?WURTU3hoNU93MWxGSUU4YlB3S0x5MmlIemF2Nm9LWFFyekxBWjdsbjB1amFN?=
 =?utf-8?B?VWl3ZjJidjZXSG1sQkZnazF5eGtNYlpzblEvWFN4bUlYRHgrcHQ5OW93OU1i?=
 =?utf-8?B?UzFKM2xqM2poRXpXVVBtM0wxUytOUGx1VEFYdU5YTVdobnhlaXQxSnFpN2tq?=
 =?utf-8?B?cTN2MkpkTUdTVDVHQkNrcWN2MllPNzRFYXp0U2JsZXQ2Ny9uRUtvc045SDUv?=
 =?utf-8?B?STI2OW1qNUJoK2NTSzE5cDZNcEJCbU12d1d0eE1ScGhIdkZ1Z0hjOFArZWM0?=
 =?utf-8?B?R0FjRmdYeHhxYWFUVVdZMnVUa3BJNmNqZGcwaGROWVlXMjMrbk9lZFJHSWZp?=
 =?utf-8?B?dGRid0lJUmpNdUpBZVpuZ1hqdzJJd3VCelI2ZTNqVjJDNFJ4dHp2QitiWnlU?=
 =?utf-8?B?aFA1YWwzOFZwbDhGbnJYZ1EyNk8wclBKTlUrY0FpcU1KQzdQNExCOVFvYVRy?=
 =?utf-8?Q?ulCCacOzBdg++nhl+msX0b6rnkQB8xFSKeWXcnl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae46af6e-e982-4c8a-c506-08d9838c7bf6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 21:02:45.0654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AittpE6TtuLOSJBJs96jSWfwSPFSqZcahAlmzPrpdmkeR1S8sJxS3p5i7whuFymDnyO9MeEnnoIliBQndTN6BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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

On 2021-09-29 16:36, Alex Deucher wrote:
> Need to protect this function with CONFIG_DRM_AMD_DC_DCN.
> 
> Fixes: bfd34644dedb ("drm/amd/display: Defer LUT memory powerdown until LUT bypass latches")
> Cc: Michael Strauss <michael.strauss@amd.com>
> Cc: Eric Yang <Eric.Yang2@amd.com>
> Cc: Anson Jacob <Anson.Jacob@amd.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 0f0440408a16..b113e7e74ded 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1802,12 +1802,14 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
>   */
>  static void process_deferred_updates(struct dc *dc)
>  {
> +#ifdef CONFIG_DRM_AMD_DC_DCN
>  	int i;
>  
>  	if (dc->debug.enable_mem_low_power.bits.cm)
>  		for (i = 0; i < dc->dcn_ip->max_num_dpp; i++)
>  			if (dc->res_pool->dpps[i]->funcs->dpp_deferred_update)
>  				dc->res_pool->dpps[i]->funcs->dpp_deferred_update(dc->res_pool->dpps[i]);
> +#endif
>  }
>  
>  void dc_post_update_surfaces_to_stream(struct dc *dc)
> 

