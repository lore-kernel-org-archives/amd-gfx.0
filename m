Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36624C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 18:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E8660F6B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 18:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5E8660F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6321A6E02F;
	Wed, 22 Sep 2021 18:38:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160B36E02F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 18:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQRcF/T6FXLgCBWxYE7byhjyGwfdIfapswWwEZtFySEIzXHZ2QYXjNS/xXT2SRYxBeaPhdl2bxQ1bL1dfQn5Cr2P/C7GYiy/uGSg6eSrZBV7IE3eyk2VpXvvoujXagj3H4MLLXJt8nXNChQ9TOxmftdGdA+8rv1sHPi07/W0RhsJ3WmTZasKLUUzbZ7CWLGYscSQjO5lAge0XjEf54omaL1Pr2BJdJ6o50OrvkF9iKf3NJvMGEl//llK+Mg3La7dDMPBb65eRD4vDVGFdUIM2j0Z3R8zoSM4OZ44GRIlMpnew+rmeqncCmkDWADnw3wlBo6xytKRjThq5K88w43CJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=nOktyNZCSlJQ22OwZyZF+5WYII9PVTGdBKY1IWr7c6k=;
 b=Rvpl399YJ1NW78ORVHYIk+P5rfNAUAPoQLmUnUfE6GjZeCHWyGkDYTKQj13zh5CSzNKYrRXP/uw+bMehLS9oyHQGfFPVBJ8XJzg/yR2wT6y4GfFGyqCT1rOQ+TnqluSgi3SHf9kfj9AEuhVwghTrBBKyu9QOtU05IuuZL81dmOxi+WSfjgPUVsOTcTpYkYW61X1YPEUFas7NbNjwMuCnPr98pkVfw7kC1R/wtc/G7mMW6zxfeSSvwngFhg671n7Fkmcop/y8sm+qzjExjpKQHLBCTkjkUv7J6E0Uci7D4WfkznvA5BMeo2DJAUG6cN1y1yHr3idT36Ta5SktBQFuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOktyNZCSlJQ22OwZyZF+5WYII9PVTGdBKY1IWr7c6k=;
 b=BzUCikJFvu1Fcm1XbwQqQ830CnRlWuxfawHksBTBmFwOc7Y+WSTQF5pkl7iXbrtGgEOjCjMjrXm5MZkXiOLwi2XDUyUa6HU18zhn1f7WHM6Dd7sYfBjRzgJlTUCGgjgmoiOT1WnXQ3DGpcmoQdQ1rWt0hWZP77LhEojTxM/Kc4w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 18:38:03 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 18:38:03 +0000
Message-ID: <3e5bd0d6-c8b4-a962-a2d2-a6bdfbad5e9a@amd.com>
Date: Wed, 22 Sep 2021 14:37:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] drm/amd/display: Fix Display Flicker on embedded panels
Content-Language: en-US
To: Praful.Swarnakar@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, hersenxs.wu@amd.com, sunpeng.li@amd.com
References: <20210922175823.2160290-1-Praful.Swarnakar@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210922175823.2160290-1-Praful.Swarnakar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:408:ed::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.40.247] (165.204.84.11) by
 BN0PR04CA0131.namprd04.prod.outlook.com (2603:10b6:408:ed::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15 via Frontend Transport; Wed, 22 Sep 2021 18:38:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0ea7243-1c23-4e35-f401-08d97df81c43
X-MS-TrafficTypeDiagnostic: CO6PR12MB5428:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5428D0078C74220C3A4AD94A8CA29@CO6PR12MB5428.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ytcujlq9wvC+9qc5c5U83OZ6EUKmY+vuTI0WjlpbQBCm4aJBoOoyQdGGgBfAtcDT43fUGYnhDCgPX+78nSZLuRYFu7O/1jik4OOBCrHTzzMUoTz0dwjHuIVc2sh1fY+nVmCXtCbHgtA7+GmUlUU9l+Jplo3kN/HSxeWSLB9NAtY6r1xghQJ8sx8Y8eBN63Ji2cFBzTvORRhIKeQDTdEzWBQ0sDDyGUqRoih0wpmee49bIOUXY66huTfrFiiMzquD9g+ih1DJ59INvqHSt8PrP/nhWveFPlzxIKEOkPA7+daakmdCQ5Nx7UhPMSlXBYsFd6UJsNutyDVC2RPZTvZ2krnocYoDY7Zr4JWMYX6RaivJcqBx3mx6U/b1tlWkWsRwDDGIRks2KZGKxeBazWBSMa8FkcmThgTuZOHZflYcygDJuD8Hfo6pIR6iwQwwpT4ZZW8c8W2EWdHK4Ks/i/y5bDim1okKiEGZGE73AddlnaBeMg1k9W8gW+Nk6bnrbz9zZUYDz5aMRCuMYTCTkbORueDb0GS/strwg6Lm562y9sSSbjZfwOXX4YAj9w4ULpWylWSjvVkZGCMZ5z0T88IcLI2wh8yugOwYhdJossNb1XX6Bp3XikoiWoXc+hmUX4+lWVg7AIGqKyUxXVzaMwVwvOPjeafWKxDuBy1mlGYwqJ8JJ21x978n+UhDbRj7h2LgDCnSq+oFmlFOSmTN9G0Ybjwz5H9JR/L+c7jFNWjImc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(16576012)(8936002)(2906002)(186003)(316002)(53546011)(36756003)(26005)(4326008)(31686004)(508600001)(66476007)(66556008)(44832011)(83380400001)(86362001)(31696002)(38100700002)(956004)(2616005)(8676002)(6486002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNJYXlkMUJLQTQreWpDckF3blZtNFFlUVlFeU9KZDZ1MU52eUtNclhMS3V0?=
 =?utf-8?B?L2JXaytYN2orOHlneWphdkNoU1prNWs4VTFvT25scWM2ejJ0a21IeExseGRo?=
 =?utf-8?B?OVBKMjdnbUJBVjlGb3UrMlpyakh6ZERiNGhYZEJWNURTSWx3NThaR2pHSW1s?=
 =?utf-8?B?aHFHUXBERm5oS0RFTjAvM3dtNW5ac2x0ajhQeU00R2ZxdFVhWXFvRmIxdkR2?=
 =?utf-8?B?MTlUYStUSyt0UmZKRDk4UEUwdUZ6M25uZDE1RDRHQ3N6OFkzSE0yd09adE43?=
 =?utf-8?B?Y3MwSm1FM2hNb0lqVlIvN0ltR0I5T0RwUHlPRm0zanVSTHJZV1dnRW4va2w0?=
 =?utf-8?B?NFY4eXM1QXY4NGFmLzNoMDRjZnpud0ZNVXMzY3Mvc3JkeUN3QXI4dXpCY1Fh?=
 =?utf-8?B?S09jbStwVkY0RC9nNTA5WE43UmwrU1I4MUIyVDJsRjZFdlF5SDdMTjBHY2pm?=
 =?utf-8?B?NkxCRGE5TXNoVlQ4bk1XY1o1OXVzbENwOXF5b09FcitiYzlsTUVnc2NicHhK?=
 =?utf-8?B?dXBCeEtxYnMrZG84STY5cDZ4NGg4UHV5UWV4cDYvY0FnNTBTeDVhMFVuUXpE?=
 =?utf-8?B?RmVwbks4dzRwejR0dmZJTnprdlh1b3lVdWlVaHM0bGdlbFNpTUtmYkJ5eHpU?=
 =?utf-8?B?YitDTHdmcXRkRWt1ejVqVTQ1ZlV3UkM1eUxFWmVEN012YkJUYzE3a2FndXFM?=
 =?utf-8?B?TUJJZDk1Y2ozQ0hLUGZyNFVUNHl5djFUU3IvRklzUnZKUmNzNmplZWZaUXFh?=
 =?utf-8?B?enozYThkOEtScjRKam5jY2ZaRVhyZm9wZFlCSWd4VHdnT0N6T096MExZWVR3?=
 =?utf-8?B?VERwYlRpZk1uQ213d0IyeEdRWEMwODNnYUZ0aWt4WWliWjB6c0FHbXduakJJ?=
 =?utf-8?B?NVhtMklKVFRGU3kzQXlKS1hSL04vc3NEbUx4Smw5UllMZURZUmp0UmdtOHVN?=
 =?utf-8?B?M3pCbE5NRytIQzdiUWcxNEw2NHpSNUI4c3V3bDFTNlBxTjRtenFCd0Y3dWdz?=
 =?utf-8?B?bEhlaE1LWUpxR1VjVUdPSDA2TlplQnAxSG5EeWFMT0l0bHFjYjllTzVuNThZ?=
 =?utf-8?B?ZHZ3aHR3cmRORks5bSswUXVzUDZmdlFuMzBoZitTV3VoQmtVaHZPRXhiSmwy?=
 =?utf-8?B?ZzByQmpiRkt5dG0wOWxXR0dGcUFwTVNCTU12M3pMWURSdUwweGFDeG1KcGo5?=
 =?utf-8?B?dElDWVhzTU5YMy9wUHUwbFJmMkRJdXdTanVTUVZoZE0xVGxmV25xeE5ONXJl?=
 =?utf-8?B?VjRDM1BlWmMwM2J1aHZyQTMxbXFFNmZHNUxOc2V4OXRYOVpXeklZbjlTK3pw?=
 =?utf-8?B?M0VYQ3F5dExURnVQeElHMXRoKzRxWXdKS21TeTU2OHkrMnAyZjdVWXU2N3Vt?=
 =?utf-8?B?N0lVNkFBN2JMc2ZzV3RmQ1JjWU1EMWRwc2dTUEFLSWNjbmt3My9ENXRZQ2g0?=
 =?utf-8?B?ZWVuMVlFd2J5VHdUTldWTVdtSm44TFdrdG9LMi9DTVBLNElxbU44aEgvd1gy?=
 =?utf-8?B?Y1RFK1liMkFIU0d5Rk5IaHllekpid2pRNnNFb1I5dWlmdDBxU29MYmdSSmxS?=
 =?utf-8?B?eXB3dUs2Z3d4MXJBY0dWZG9wcllKaE5WWmdxU3ZzVmlUK084d1RxZTFXL3lY?=
 =?utf-8?B?ZGlXUVR5aXVtVWxCWi94TkE3cE5leXFJOVIwek01NW1vV1hZUzQ5Yk5wTi96?=
 =?utf-8?B?dkIxUXk5dXVMV2c1R0ZMT3BZamJzVDJ0R0F3UEV4T1hUMzFNVjJQQWtrZ3lL?=
 =?utf-8?Q?r1B7FuzVHJi0Hck7QI9XXOHdQzKrBPzKBsGFfLr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ea7243-1c23-4e35-f401-08d97df81c43
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 18:38:03.0915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74AmZHMDqzHU6EFDJYpRn37XqgrBmrjQAl2uJbcaabz8smC6eP30s0K0Bds4uBce+iPjFyTUVkOp94oAgUAL6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
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

On 2021-09-22 13:58, Praful.Swarnakar@amd.com wrote:
> From: Praful Swarnakar <Praful.Swarnakar@amd.com>
> 
> [Why]
> ASSR is dependent on Signed PSP Verstage to enable Content
> Protection for eDP panels. Unsigned PSP verstage is used
> during development phase causing ASSR to FAIL.
> As a result, link training is performed with
> DP_PANEL_MODE_DEFAULT instead of DP_PANEL_MODE_EDP for
> eDP panels that causes display flicker on some panels.
> 
> [How]
> - Do not change panel mode, if ASSR is disabled
> - Just report and continue to perform eDP link training
> with right settings further.
> 
> Signed-off-by: Praful Swarnakar <Praful.Swarnakar@amd.com>

Good catch. ASSR for content protection purposes requires
signed PSP but there are eDP panels that require ASSR in
order to light up correctly.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 6421c896f2a1..120c9955cafb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2419,14 +2419,13 @@ bool perform_link_training_with_retries(
>  		if (panel_mode == DP_PANEL_MODE_EDP) {
>  			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
>  
> -			if (cp_psp && cp_psp->funcs.enable_assr) {
> -				if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
> -					/* since eDP implies ASSR on, change panel
> -					 * mode to disable ASSR
> -					 */
> -					panel_mode = DP_PANEL_MODE_DEFAULT;
> -				}
> -			}
> +			if (cp_psp && cp_psp->funcs.enable_assr)
> +				/* ASSR is bound to fail with unsigned PSP
> +				 * verstage used during devlopment phase.
> +				 * Report and continue with eDP panel mode to
> +				 * perform eDP link training with right settings
> +				 */
> +				cp_psp->funcs.enable_assr(cp_psp->handle, link);
>  		}
>  #endif
>  
> 

