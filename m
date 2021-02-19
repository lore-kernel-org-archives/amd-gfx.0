Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AE3C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 17:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1556864E67
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 17:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1556864E67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35B16EB7C;
	Fri, 19 Feb 2021 17:22:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 841FF6EB7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 17:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzAkd4Yn2ooAyp3I4NgbsTLZ/xmLzLVBMYh3Y8AmS0IpnqbFCbDHkdS5TeJxPMPXI6lS7vCXXNRc1rXEZ/xwv1c++PMw1pPeQHkk6WzctjSRNfWcvXJXm5igUhjmYg64Wa+vOl4q5LCUZ/hZGavY42hkjDebjv2w9wJeEmWAC7QJm2nRImCV52iHiMejgLdsnDElR3xZUcATor3fPvoGdD5g0Fy6OcXrUgw4zoMdI91+6p3m1/oyst+8wK1NRrCmBeNuvPn0/zdNafnsIflNfNEKWrdGUG6ljLVRFrULK2Q9DAxj64Ctbc0PGEXhZu7oYXyjkN/DzdCIZayTOv4UIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeLPr3VmgFit2GD8DijkkrfQPZMYzvcaWtP5aqqZgfc=;
 b=MGjQVF+mJ2f5zRu4QCoRQK+FDRoGO9jypRI90nTPDFlcNCgocSbja4usZtGf9xpJG2sgsVXygx51Ysb7f4IFi0+zroTFSv825eRvmRgDneC4piAtkZZTn/vigS8K/69FKMkFJHpBtat+ivj6Rlp6LOa5bbwFY+7X8TKTUh3HF/YnBtlejzk2VQoCGUDgfIkT/jJ3sU4u0iF1SMOpdBlj1IerO49SNRmZV7xZinOieQmBc7hnBDfXNtasV4jd3UbYGlDwn/GL4f8ILkGnCOXB+aJPv4ic1JGNuAUoCfdsJrqCfC4/13ui/ufVSrGaWoN9luDCWnXM2ZjH3HJhtATj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeLPr3VmgFit2GD8DijkkrfQPZMYzvcaWtP5aqqZgfc=;
 b=Bad2PIyBvC9rq9JOTXiArtmO+CiqswEgCdOaZbnX1oaMfvdCuCzhT1fyIDr0BJcv813/UNRsMBZHc560QXHrLSVcRqjS8vOij/JfJExTbGX5f+WX+Bom2xESzVnLX2mUIbpC1c6ZgURCUynnpQFiJgpxvMk01zBSJXidMKuTIUU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4002.namprd12.prod.outlook.com (2603:10b6:a03:1ad::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 17:22:39 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956%4]) with mapi id 15.20.3825.040; Fri, 19 Feb 2021
 17:22:39 +0000
Subject: Re: [PATCH 2/2] amd/display: add cursor check for YUV primary plane
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
References: <GKIJ9isuno0PKWRz4qj5CSIfRao35EWMYjtLGdiDIk@cp3-web-020.plabs.ch>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <2feadc71-19b0-d1af-6302-1ad20e81aa79@amd.com>
Date: Fri, 19 Feb 2021 12:22:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <GKIJ9isuno0PKWRz4qj5CSIfRao35EWMYjtLGdiDIk@cp3-web-020.plabs.ch>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38 via Frontend Transport; Fri, 19 Feb 2021 17:22:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef96d371-0868-483f-bd87-08d8d4faf54f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4002504F806ABF7603D7FA12EC849@BY5PR12MB4002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEivaRtdGKt/Vm9JsOWw0HyBAzfWSXqFXRHC6PKsyF7ciDivCBL2Cj3B6aYe9v8J2kL5ZSygpuAx3F4T05QJabfaIQ2wJ1WP3lL0+sGadcqUgQjiX0k9TNhQboWDHN9bt5xppdbXHE6DVZqBKrKMDYzFDf6bHtRDtbdgWBjYMpT0PrjR43iGy6qBkHl9F1IA8wvOaRFBOpVD02p/LpScyNLGTQg4f+4z85+6T15/ZdAdBhuP4H4tPdpCPfczVFkYUzvszmsThSGY1hWxB0fOcYr47IAlPmzU7GJownU27q5/YAVO0iDox16Ut4G+2mWuDfO9/cDbu0T4mDoiHLW9aryL05zGJjNCuM4trgO/NumjjTNGBBrIXdstp4W+UWmkr7PGV5eNnUhtuhcatqd+xUCKLaLze6rSCy8ZjeiZn33F3e5cSLjBn2cgNlavcfWasy2f2fDJyEI08Ilbn8a/1yZV31VDAAo+fRJQFPeVAXlStoIJScmBsfEGGtFxwG5LfknGeU+SW1fL9uDskvebqVU8xYpRThsHoTTy8Fs4UkZSzhxJRmxwE3+rDonXRKy/tWRCePQEIYmCESc+RdOX11diIJUNxAIyqSXcU76GAw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(31696002)(8676002)(66946007)(478600001)(66556008)(86362001)(956004)(2616005)(8936002)(16526019)(5660300002)(66476007)(6486002)(186003)(52116002)(31686004)(26005)(6666004)(4326008)(2906002)(316002)(53546011)(54906003)(16576012)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WXk0UGhlaUloUHkxZ1daSlUxYnZUVTJGZDF0cU96ZHJMR3lzVlE1VFNOMkhr?=
 =?utf-8?B?Ry9qZHhYV1pqUWxTOEg0a1p4dlkxNC9sMnpGWU1rZU9pQk5FMm43TXBJT2ZP?=
 =?utf-8?B?VkNUWXQ3NDFZSDdQUzRkdWVQRm5XeE1qQ3NuRlFQbU9LRTk3cDhHTmFvS1ls?=
 =?utf-8?B?S1Jvei90R1ovd0xsWTAzdk9KQWFaVlpLc2pxUHBTanFic0dIelB2OGVXQlJR?=
 =?utf-8?B?eXp5eG82VURXdVpHUE1oQ0RyemllbTJadnZJSW4yRk4wNXhQRHd2RGNhNVJC?=
 =?utf-8?B?ckFZUDVpcXVvNHNTd09yemdjdlFoZVNBZFJhUStSamMrWEU4UVhhS21zUit4?=
 =?utf-8?B?R2w5cm4reGFBZlR0R0xKNWp4YmNscjNZRnNnTGVhbU9DS0EzcUpaVUw4Umov?=
 =?utf-8?B?NHE3cXF1MmpXdXNzQUhrQ1gra1czYWIyZDhLWkNMT2tTT2pTM2xPR1hvMTJY?=
 =?utf-8?B?K0Y1TFNJRU10QUFqVjZ4c2RIaEJKNFliYzdKclRyVllGUHg5OUlKd1g2aTF2?=
 =?utf-8?B?S2JoekJXYzl6a0hGVDhMZlNnZHZwNCtSb2hFUk1EUFlNT3F1RlpKeFNrdEhJ?=
 =?utf-8?B?MG92VEczQ2tvdVM2ZlZXSS8yQjVRT1d5Q0lUZ0tsZy8yY3NNZERGQWpxSnh3?=
 =?utf-8?B?WUV3SS9EQi9xUDFkKzNWa2lFTk1BTXJ4YUpCQXBIZGovRkNzMGxwN3h0MnJN?=
 =?utf-8?B?NkNFaG95OE1NYk1OUUgrNG9PL3VIQytKYldERHhOd2JweHQzdCtiN1hqa3lh?=
 =?utf-8?B?eHF0Ukxsc3RTT0wvUjh2RzgrL2ltMWJ6TWttTmdwVzluZmNQLzBrZ1BSUThS?=
 =?utf-8?B?TmVqTWptRnNZZTlxZ0UyNGNubUJZMkxiR0Z0MkU4Qm10YWV6TU0vZm1PNm5o?=
 =?utf-8?B?UllxcVFmaFJ6Q09uM3lIMWhCbFJYcWJWTk8rY1dvcjlDN2cvbmdlN0VLQXF5?=
 =?utf-8?B?STVvbHp6RlJzd3NnUUx0cVhHdXlXL0ExNnVOcU12dk5lbEs2MUVOd2VwcDNh?=
 =?utf-8?B?b0xaRTZuWXV4QjNiTXFXM25XOEpUdzBFWlUzZm9PNHdlTDNPeFVkVmFQYUsw?=
 =?utf-8?B?QnhrRGc0TXY1NGZYRWZjWXdEYVh1dU5sdjNlclN0a2xML1drSnJSeENBblps?=
 =?utf-8?B?dlVwS2dyQW9LNVNwU3g0SXh0dmlrZDQ1c0Z5aDF0RWtiRGtKaWtiUG9idUJ3?=
 =?utf-8?B?U2Y0U0pTTmF4OEJtOTJvdWQzUGdBNmNOdVB5Tlh5RUpmalRNUnM4bG1EVm5Q?=
 =?utf-8?B?YXNSd083a2VCN0R1MEplNmlyTld5VWVlcG5BN3lNVDNWRGVXU3V2TG82YUxw?=
 =?utf-8?B?dnVTSE5ZWkNCL1VvKzFiWE5SK2FlNGpwT0xtNG5qTVQwUENQNmp3QTVpTnEx?=
 =?utf-8?B?TEF5VjlHMkJ5VUdZOVBPQW1LRzVnVEtmc2JjNTNIK3pNL01qV2x5UHp3b1Jz?=
 =?utf-8?B?U0Z1aDY3MWxLdmc0K2oxcTA2cmI4cTg5cHltRGJtb3ZiNFhMVjFPMS92MklJ?=
 =?utf-8?B?cGszTFBla0IwRDg5OFMyQ05tbk9HYWF6KzRsUU90VEpaRmtYNFFJSG96ZXFo?=
 =?utf-8?B?RStiOTdHVU5MSnVTNzNIeG53cDZFNEpjNVlOMnE4WUJ2ZTYwQ3JvaTBsMVFX?=
 =?utf-8?B?V29QZkRPVlpGTGliLzdrQ09KcThmOWtNaTFOQTBSYkc3ZDl6a0Nmc0lRNVNr?=
 =?utf-8?B?QVRZdHFVRUg3ZkJhdVgvM1RaWHN0VkZ3dWNRT2tncHBLN2JsT1ZXMEJaMjdR?=
 =?utf-8?Q?szdsjPTdDjuuYGGYWA56nBWwJL9O6/UE2316tHe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef96d371-0868-483f-bd87-08d8d4faf54f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 17:22:39.7940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNSm8qnGqIi2MPkGYZzLlPsUJqlNVU4ZdPRdKooUyGgleeRsKmMQ5MTPFwzYzj5r9BI+yb3JcW1QHGofFYINsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4002
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-02-19 11:19 a.m., Simon Ser wrote:
> The cursor plane can't be displayed if the primary plane isn't
> using an RGB format. Reject such atomic commits so that user-space
> can have a fallback instead of an invisible cursor.
> 
> In theory we could support YUV if the cursor is also YUV, but at the
> moment only ARGB8888 cursors are supported.

Patch 1 looks good, but this patch needs to be adjusted.

We can support cursor plane, but only if we have an overlay plane 
enabled that's using XRGB/ARGB.

This is what we do on Chrome OS for video playback:

Cursor Plane - ARGB8888
Overlay Plane - ARGB8888 Desktop/UI with cutout for video
Primary Plane - NV12 video

So this new check would break this usecase. It needs to check that there 
isn't an XRGB/ARGB plane at the top of the blending chain instead.

Regards,
Nicholas Kazlauskas

> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4548b779bbce..f659e6cfdfcf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9239,6 +9239,13 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
>   		return -EINVAL;
>   	}
>   
> +	/* In theory we could probably support YUV cursors when the primary
> +	 * plane uses a YUV format, but there's no use-case for it yet. */
> +	if (new_primary_state->fb && new_primary_state->fb->format->is_yuv) {
> +		drm_dbg_atomic(crtc->dev, "Cursor plane can't be used with YUV primary plane\n");
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
