Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4497C4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 18:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E4D61405
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 18:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E4D61405
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD5B6F89F;
	Fri,  4 Jun 2021 18:47:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256A56F89F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 18:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMdRiahrDGBmbbFXsPp6GiYlAT6ebF/V/7NIhdAHbv8gIAEJdyxy5mWnTkyICId1wRmF8w1QIqLaENm67LOo4rFFkEweWkCRYzmPmdxTL1PXt/LF0co7Yw74I6cV0NJ69C6LlnovguKiM+VlzlBqCfkz0y4mAj3+o9gxZRbCI85PDz6fuHswh4MiP0oLgUMLmbLVaCKdXumZNFAHViglQcSQRuOoFhsjM4WVz9AlBSyqY4QElo1BmWCg658U3IFP3apf7GLY883fOwLK4E6O16Vcm/7qbyt9SsjIDS4sP7LBij1sM4T+CbRu0lNDAv86MVV/IB3IyGhyCAzV1oIcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoHuNGxcd90YDH8v8Tv/0cuUqZcuR39eQCal3efgMKQ=;
 b=I1elXGFA7cf5CHe6+1WMuykl+7xz2oLFbu9K67Ejq2309g82LqnJHPDfI5ZiQKJIyfbx6hyF9RjCRGsb8ScURB6G9kyBaOO76wFKzIlqC5fVPSFGZYFTvFO5bxZ65ALs4v6kuCEYHfjfbcy6TeMEodyoaF+H0u8KLMvacgEKJGdXUYW3F757k7hdM3IwmLLhk6AniWwOuqmjXktBGndh4GjEJm7JmIvWqFxdFws7TBkgIn9iVVc8BZeiOpGFJqtpszSjFM4ZpAipgwHElz8I27gSoGHXd/zh2vajYuO3ZvipdYzxwMZYRVzyRuUrJ7hdVf+W75bPOD/20eqw8qqB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoHuNGxcd90YDH8v8Tv/0cuUqZcuR39eQCal3efgMKQ=;
 b=vRNgq+aFCu8ls8tt1pO643J299EjmPGyUTghElNiWonY3ixpUQO+5GtlUzfvnNSgZNVD2EUT06E8sE3tUzKEHznooFDDO4vc25xTaROP4CAagSoDzjIPAXgzd99v1phGC7uRY8kzgS90oVOfCc3xPf/+TWETHrRx8m0frcw8Ag0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 18:47:42 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565%3]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 18:47:42 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/dc: fix DCN3.1 FP handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210604181630.1205152-1-alexander.deucher@amd.com>
 <20210604181630.1205152-2-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <e60bb5e0-b7b8-e37a-5efb-c03807af29db@amd.com>
Date: Fri, 4 Jun 2021 14:47:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210604181630.1205152-2-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.16.155] (165.204.54.211) by
 YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27 via Frontend Transport; Fri, 4 Jun 2021 18:47:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dbee8e0-6f3c-499e-1488-08d927893c63
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53575B17C2BD3B36EE274B9DEC3B9@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgxBclJYX9N/Sxt/fNuysufywu5iWiXcScwztp9ctjj35rrFzXUBQtQJHy35fJyTQ0lwLhAVLMGao/Yq7uSP4PgLB2qBWWwEDkA7kWv/KzSC7iUQ6eJ1nM9+Mf61cakiAmo0HEwykfyE+Y5If7Mn5nIf2njzEn+hpnm18RdAnbkwXVkfYPSsJOH5/z5Foh/laUeEsFT0yBHb0GlDXImQSALkiuSMJmeKtJ8qrhRpj8nwF3ZWPyw4izB69WbYabwUi5IPWheszUAQ8kfGwl9LJ4K8fVhpYRdmi91kCPLcVNVkL6umRF20nmZdyxW3UKG9gYHcIq+wQHYvj6sJuzPoFxh+o7ZuFmZLyYDXfwhdSnTKqWxAc7Wa+cNc/u4Je9q3qeq5pFNJr1dLvP/JPLwSSER+zpkyf1hXQT2hAJ2N5+PML98XYt059SLQU8TmLeR/Ag0XX+8dpx4fjcIbb+USSWK9d1RqH2zj/IfLAplYEvW5UNTwXg55rOzhKS9O93365J6S8cbgSGgX3FxhCYHW2XW9YQVx86lQQoT09AdBeRaAFgwYy3E8pzsPmsoSJ5rPaXrCa8qikV4ZU0+w2Bv0gGTfdqm/2nxV9dtTjGgiFHQ16pqQUDUMjaYFb5xKwPoJevzvJUYCrS7TQ5ceZJGJxQFgjegVKlCeIts1wnQLDbxFnY6TLU87CRvmpo4yXw/u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(39850400004)(346002)(66476007)(316002)(8936002)(6666004)(16576012)(31686004)(83380400001)(5660300002)(36756003)(66556008)(478600001)(2906002)(38100700002)(66946007)(8676002)(186003)(16526019)(26005)(53546011)(86362001)(956004)(31696002)(6486002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TzQyZ3hvdGFGaDF5MXU1T0NkNm1Gd0lOTlN6SDdyaHVsd2tkYVlHa2ZSaENR?=
 =?utf-8?B?clVKMExxbHY0T0lxTGVPTnplM1RlNEpQUlZpcklDQ3Zna2pqZDZDUkczdzVH?=
 =?utf-8?B?TEJvT2FuOWlPREY4aExIZ01ZbnlmdlZsSkRNOHVmMENVVjBqdFFqVXhMb21t?=
 =?utf-8?B?bm5MdjM1b2VOTnh4NlNRV3M3QjNreUZnOTZEb05Gc01JN3RhcFVmdWdCRnF2?=
 =?utf-8?B?Nk1wVldFN1B4Q0tXdXI5YXZlMFprRkMrZ1Rzb1dQcU9OYWcwc3N2a0htMWpn?=
 =?utf-8?B?U0YvbUsxdDVGNHhkcDRYWiszRUJ5WTdTemlSU0xxVDQzQmkvZGpqSXZDbndk?=
 =?utf-8?B?Q2x3aEdxMmkrVURYckhWdDl1bFp6TUh0KzNXdkNIVzJqc0dWbS9pUkcyRG0w?=
 =?utf-8?B?c0srbm9mNDRPUy9XY3JRODdxS0dONitYNlp3dDFJb3ErN01VYUZyMHl4aTh3?=
 =?utf-8?B?OHo4MmdDak16UGk5SEtFK0NzcElmeUl0NTNnUXNXZzJzQ0hQc2I4NFNIRXRh?=
 =?utf-8?B?VDdQakdSK01OZEQ4TlNmZmNxYjIvZXVUK0E4N2FVRkdXOCtjd2JSbXZ6bEMw?=
 =?utf-8?B?R29TYXVTODZhYThTcnlQbFVCY25BcDdmMkxYcTYwczlWQkFheHFDWm5EcFYw?=
 =?utf-8?B?ZEpQaXd4bCtMUU0wMnhWQ3JiTDd4ZmJRR3E5UElCR0h1Nzl4Zkhjd0NBQWFU?=
 =?utf-8?B?ODJGbXc4akxaT2ZhdjFERDBUQ2dsMTYveXZESVdjYkZ3a0xMV1o0eWllb1BO?=
 =?utf-8?B?ZmtOTUl3MGE0VWNnREsxQld0WWpIOHI3aWl4cktWMU5pUHUrVzI5eWh0Z2th?=
 =?utf-8?B?QVR3RFdEY2pjanVoRWRaaFpRaXY5OHJKOTVGcTBNWlhpU3c5NkZSNmF0T3Fy?=
 =?utf-8?B?WDF2TG1XcGpZWm1DdVRNM28rbzN2R0Z1N1pEdVpjeGV6TmhtYXFOR2pLU1pK?=
 =?utf-8?B?Zi9vY1VucnpTRm1FTGNUVVNrTnZUWEpJN01ERDNqWm5ubUcxdXI1YnQ5K0Iz?=
 =?utf-8?B?bFdjTXpPYW9EOW5tV3AxZ2cyUEhXL3RJaUtyZVp6NWh4ODl3eGV3eE5sS3VF?=
 =?utf-8?B?Z2REMXFlcmI1Y0xlNTlYQllrOFZpSGQ4Ynp6ZXNzTWpQbFRrMXFCTmJiSEUz?=
 =?utf-8?B?aHlDZktvSklOa1paMVM4UXNkbDF5b2JiR01vckhGRkxnTkRibGErOWdGK3lP?=
 =?utf-8?B?NzUvUmJBOWx3cGtNMUVBd0dwZGlyWm1Ib0ErRXQ3V2RKN2N6QXk3cG5vWTZZ?=
 =?utf-8?B?a1E4NTRKZkRVRnlJai84K2pkNnduZ05iQkRGV2p2TGJUR2krc0dKZXFtd05v?=
 =?utf-8?B?aU1NOXN4N1hZWTEyenVDMEovT2djRDhTSFoxOXkxOXR6YVRub3EzeGxvOXZW?=
 =?utf-8?B?QnhpczNMZkRqSXdHREk1djB1ZVQrVjFnbFNWODBRMy9kbkh0bXBLaUcxRHVu?=
 =?utf-8?B?a3pXN0VWRFluRUFZUEgzTEJoRTB4cXErWnVwU0sxbFI2cUlWVStIWnpsazc0?=
 =?utf-8?B?c0dHWjJqQU9ISFlZYXVpYVJtNlhlVktIdTFNUDBrRWVWcytOMFAweEJWUUx3?=
 =?utf-8?B?TSswendac3hkY2dlbXVLT1FJWjQ2UHhoTWZRbXVnN1BnbUlPQnlYWHhxeVpx?=
 =?utf-8?B?dW5od2J1R0dySDJsYlcyVVo1emxRSlpPbkd2eFY4dStGcGpPK3c4NldNVUhY?=
 =?utf-8?B?L3Nab0RrUkxlaUNXclZDeGxIMGhYZ0FQQ3IvYVl0RVJZeXRCY3VpdE5USW1u?=
 =?utf-8?Q?RRw0PqMwBCWgGWiF9yDHsxQFNsk2AElhXzt4upx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbee8e0-6f3c-499e-1488-08d927893c63
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 18:47:42.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgS2Pr4L0V+7ckr8Zq1QhPjdWDD/tiKayWZmTxTeIx9dJ6uezyEBy7iZS9HlHwA2JvyKkZlxKTIQYfwKZNpqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-04 2:16 p.m., Alex Deucher wrote:
> Missing proper DC_FP_START/DC_FP_END.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thanks for catching these.

Series is Reviewed-by: Nicholas Kazlauskas

Regards,
Nicholas Kazlauskas

> ---
>   .../drm/amd/display/dc/dcn31/dcn31_resource.c  | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index af978d2cb25f..0d6cb6caad81 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -1633,7 +1633,7 @@ static void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
>   	}
>   }
>   
> -static void dcn31_calculate_wm_and_dlg(
> +static void dcn31_calculate_wm_and_dlg_fp(
>   		struct dc *dc, struct dc_state *context,
>   		display_e2e_pipe_params_st *pipes,
>   		int pipe_cnt,
> @@ -1759,6 +1759,17 @@ static void dcn31_calculate_wm_and_dlg(
>   	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
>   }
>   
> +static void dcn31_calculate_wm_and_dlg(
> +		struct dc *dc, struct dc_state *context,
> +		display_e2e_pipe_params_st *pipes,
> +		int pipe_cnt,
> +		int vlevel)
> +{
> +	DC_FP_START();
> +	dcn31_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
> +	DC_FP_END();
> +}
> +
>   static struct dc_cap_funcs cap_funcs = {
>   	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
>   };
> @@ -1890,6 +1901,8 @@ static bool dcn31_resource_construct(
>   	struct dc_context *ctx = dc->ctx;
>   	struct irq_service_init_data init_data;
>   
> +	DC_FP_START();
> +
>   	ctx->dc_bios->regs = &bios_regs;
>   
>   	pool->base.res_cap = &res_cap_dcn31;
> @@ -2152,10 +2165,13 @@ static bool dcn31_resource_construct(
>   
>   	dc->cap_funcs = cap_funcs;
>   
> +	DC_FP_END();
> +
>   	return true;
>   
>   create_fail:
>   
> +	DC_FP_END();
>   	dcn31_resource_destruct(pool);
>   
>   	return false;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
