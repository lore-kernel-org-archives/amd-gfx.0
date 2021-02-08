Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0793EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 19:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8438264E66
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 19:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8438264E66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80D96E9DE;
	Mon,  8 Feb 2021 19:57:26 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760048.outbound.protection.outlook.com [40.107.76.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BE66E9DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 19:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYgEPClkYcOxr5PhI2Dl6EONlBelPcxB5xjYBrYhfAgiwWP417NEtD2pABW7mWkOjwdIRNcsGIvSWTIpM2uWM4GpvoQf/1t18BBl4K36hBe3Y6atHx2VEqAJ4Z/mYl2WwJDU8AzrPUumkwwo7B69twV6+L2jaGnXEBFVtkRzwMjPhaZF4Yp/XLaq1XfMKVFQpBZhJLlBWfHlrH7xuxzp33Pl7g6SlwBK1+D9CUwCT03zZ9rYpXTN3tBHa/RrvTntRZj7j1T+dfNTGN7hyxV6k8GkaR9/axpdU9btkaoWmt5vZr8aFiOzRN0+Qg1QfVLRjz3Z4gzVABTM/T0T6PJCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ij/e4Z+KJMWpA8pwZ5cjt0jtSyGGD3rCWM1G12ZdXc=;
 b=EGZAp8qXnl4FtzqXUM+6htl6ca2bgS//vorpmIKPfGTTx6rIzicSEC7CU0MgPQnpsVpras2XdjdVLCa463GaZEqudiKj26a+tJTbTs5GEfz1KeDdmMQPRKwDNrk/3WYywPJUcfjE/BYarN7llL8JdLxaDNRmXT4Hk1rIQ3JupRo07VVterjET8j2fjB6krU9GV/1aLi09XiHhD4eQF7wiwR+9SUUOcL9B1M8G51RXpB1BjZ4ARFasCCV/NboomNyM2wKP49NW0WndyuTVivFzSX8Gjn/t3wXYqVF6OJ9LnXn6/N/P6Wiq0bVa64CSbhG8hNf87Nw6eFPQ/w0JGo9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ij/e4Z+KJMWpA8pwZ5cjt0jtSyGGD3rCWM1G12ZdXc=;
 b=Fk9L/X3lOaLL7rOIs8s1eCbFKa1r+MRwB6cbiwAUEwoZT5NdsfxaW+RenSftEZHSR0exLM+JO83HzokruxtbPiAIe5wHcVxzYCFy8xHbwulgjujp0Ck7gyjF0snP7GZVhI0SGjasFnyoZnSY9ocCx7HxcfA8KD+vAI3DGdCG+WE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3413.namprd12.prod.outlook.com (2603:10b6:a03:ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 19:57:24 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956%4]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 19:57:23 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: move edp sink present detection
 to hw init"
To: Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210208192531.2924743-1-Anson.Jacob@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <692a0289-1af6-7cf4-a11d-9e103838869e@amd.com>
Date: Mon, 8 Feb 2021 14:57:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210208192531.2924743-1-Anson.Jacob@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Mon, 8 Feb 2021 19:57:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28cc8d21-d25f-48dc-b1e5-08d8cc6bc057
X-MS-TrafficTypeDiagnostic: BYAPR12MB3413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3413E14CECEE2FA25AE03DA3EC8F9@BYAPR12MB3413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9OXbnjoajMu84aQI0WCCfGUZrFxyWJLMtfyEWxVTPJYqwPKBHPuFnS/H+Ow5h57LMGWV/fEnILnHkgs3mEbSrMECOWj5QFeVQfyXv4IzNv/JU7RaDh3IJfg0UTl/zVSXxUyexUi0wgJUFRC5gVihpiKxXjChZRoL6OtCxS7nzfhpDFy6k4+te87NDGcj/fN1MiZuT/yA5hK781v7M6AVdBvcsttIpa13lOS/pwqj5iVM3do3+KgOwUjTklRmwDZZZIcwyfNzLiE9bBTouByyoFtqb7siynF4pNZy6E86vI64He5CFhcxHvrXJjXBZLbZFwAd8aBYhOVb80XVQeO/GQu5i1XtuBuMNT3zB2tNr9CYpHig/hfaTPTTMMU54XROmDZgyuY1VRk8tzBoUQLF48fb9kiiyuSVlMb8N9OS4zlHbdlD3umVQ1j73enwtE1eoN8VFo9D2mtvaP8ib22/0VIWd/Npx/1QwWolL5oLuaySMWbzh+9cgLI3BnZ+9dlJeOmjizcNfAkxv5/C1VhDEyidLC5sQF9iLMepAxukyWLHFBUpPLa9cIKD9qrmzhYHtbe6LKMPeykOkB6ZTGQVSSi22tR/vIShBBXimSOcaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(16526019)(2906002)(186003)(6486002)(316002)(26005)(53546011)(36756003)(8676002)(956004)(478600001)(31686004)(16576012)(86362001)(6666004)(66556008)(8936002)(5660300002)(66476007)(83380400001)(31696002)(4326008)(66946007)(52116002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N1FQaGhRb2JPN2tSWVdFYXR2UzArbFhTclZUMVNQRU5NNHB4aVFSUFFYNGJX?=
 =?utf-8?B?QUhDWjEyZ0Z3dXFJMUxtZ0JUSm16d1B0TzltWW5mcUswTHR6YlZpTnhYc0tm?=
 =?utf-8?B?RzlKOXUwckhXSVhwa0ZpTTVpTnlkbjJYN240MTNsdFpLeFV5WXJKc1hMaWdw?=
 =?utf-8?B?ZXJlaFVJQWg5amlxdlNjNklnYzlQWlFNZWRJRlkxY1R5Y2tnSkJ2KzNMMGNR?=
 =?utf-8?B?SXhCaE02ZllHMnhVc1V2em9uWEtXZW1rTHFIckN3cmI3SFVYM0FPRm9PSnBz?=
 =?utf-8?B?WE0zc21RckpaOU5NZGhOYUptU0JPRVIzUE01UW9pUC9JVGVHVC9NYTB3RUJL?=
 =?utf-8?B?Q2huZXBidS9GdklmOEJKZTZ4WnZFdzhhdDJvL0NTTjF4enRhcWRpWGxkR3oz?=
 =?utf-8?B?OEJaRTJ0WlhER2h1QlZ5eDFGODhtdGtvbEo5b0I4RmZraUpPZTA5dWFIRXBr?=
 =?utf-8?B?SU96Q1ZVUk5QWTgwMWROaDJmTzFTV2pHV3RUbHQ1T1dIZGxweC82YnBRQ0pM?=
 =?utf-8?B?Z01OUFZsOSt4TmozdEN6RmNZTW9zTC84UGFBamJ6N2cvbU1UL1hTaDdnVVBG?=
 =?utf-8?B?RGFIbnE1Z1dzSjZVR2ZTT0hxMDBWT0o4QldrdWV0MFcrbG5sb2JocFg4WThS?=
 =?utf-8?B?UytVWFRhMkxCYTJySWIxRXZpVVllc3RtWnpRQUVVekhCNXFwS1pXRkI0YTZl?=
 =?utf-8?B?NWs1RVpXRkU1YzYvQmpnQzVzY0dxK0Z2S3VmL3R0NFhqS2x0Qk5kRVBiTklC?=
 =?utf-8?B?UHV6NVM2TVJCRmp6UmtzanFWYkZKQ1JvRWp2UXRJNXZLT3kwUHExNFNscnhK?=
 =?utf-8?B?ZFRMNkFuUTEvMTJXcnYwUW8wNDg3U3k4VmhBd1NWWk9GWVRqSDIxd1ZON3RH?=
 =?utf-8?B?bUw1V0YzYzdSUmhKUEdaRGJmQldIT1ZzeEJNR04wVlRhenV2b2VTVUFyQ2ZQ?=
 =?utf-8?B?QktKVjFHaVJkKy8rcENEWDIyc085aFFjVjJleW5POTZNUFhTZndpems5VFMv?=
 =?utf-8?B?VDBCbGIzK3E1dTB3YTNlNVFDTVpvazFXemhDbHZmTFowaHVBS3Npd2ZYUi83?=
 =?utf-8?B?QnBYRGxhVXBEV2k4Y0VWbi9UN3hGbFZNVWFybEdMaFBwTUVSZEpzVlU3ZjQx?=
 =?utf-8?B?c0U2NTU0SEtiZmoxUlY4RWxqTzN6QnA4ZHV4MG5OMVNHZ1lrNTZxZGZiV29o?=
 =?utf-8?B?MFlyaW1CRHZzVmV3U2lUdXZoZFRwUE5BVkM1eVdkSlNvYmZUZytFOEMyYVlN?=
 =?utf-8?B?UEFQWFg5TjZSUTRhUGljSWw1TTQ2SEQ1MkpaRlVoeXZEMm1TcGdXRXRsdlVp?=
 =?utf-8?B?ZjRWbDl6QTNFMkFxakw1L3BXTVFFU05qZ2RQTnEwQnZvTDRMUzVGWWI3eXhS?=
 =?utf-8?B?VE8wcG5wRWw4NDdUNm9mQlJNcVlOSVJMNmJLT3dZbFVZU0pEb2NGSmtOdUlZ?=
 =?utf-8?B?U2c0OWoya3dhb1lyVzhTWUdMZkF2SzZHVkgxVEVUaVAxR3ZTVGwzMFFRblBL?=
 =?utf-8?B?ZkxnM3ZYcllRdElCZXhZU2tVK3RCcjhnNU9IcnpCRVRscEJKRENnVVM0cXpp?=
 =?utf-8?B?K29yWXJMMW0wUEFUWDVvcHQ4a1ZyQUMwanpFTG01Y3RZKzc2OUY0U2d5TFU5?=
 =?utf-8?B?enVITDRXbjdmZStCeVc2Z0JoSi91ZjlIeGxsWUpLYWRsdUVQeU9NTGZaMnRy?=
 =?utf-8?B?aG9jb0E2ZjVGZHMwb0xONmJ5bWV2SE5QRmR6RVBDTG4zeU5NYzFQM3dYeXB4?=
 =?utf-8?Q?eMD0BN+SpITBh0lMe039bliTaLs5920SStgTxdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cc8d21-d25f-48dc-b1e5-08d8cc6bc057
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 19:57:23.6662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3SOKyFgJ9FSDGesiL/NPBHzFZRKsR646Y8jEhfvqR0v29FZpQlkfhNUc5L4CPuj9PWc4cS4AMDdrD7iqYh6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3413
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Harry.Wentland@amd.com, bindu.r@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-02-08 2:25 p.m., Anson Jacob wrote:
> This reverts commit de6571ecbb88643fa4bb4172e65c12795a2f3124.
> 
> Patch causes regression in resume time.

Shouldn't affect any system that has an eDP connector on the board since 
it's expected to be present in end user configuration.

If we want to replicate the same behavior we had before for eDP 
connector + eDP disconnected then we'd want to make sure we're skipping 
the registration for the connector in DM.

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 40 +++++++++++-------------
>   drivers/gpu/drm/amd/display/dc/dc_link.h |  2 --
>   2 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index c9aede2f783d..8d5378f53243 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -205,9 +205,27 @@ static bool create_links(
>   		link = link_create(&link_init_params);
>   
>   		if (link) {
> +			bool should_destory_link = false;
> +
> +			if (link->connector_signal == SIGNAL_TYPE_EDP) {
> +				if (dc->config.edp_not_connected) {
> +					if (!IS_DIAG_DC(dc->ctx->dce_environment))
> +						should_destory_link = true;
> +				} else {
> +					enum dc_connection_type type;
> +					dc_link_detect_sink(link, &type);
> +					if (type == dc_connection_none)
> +						should_destory_link = true;
> +				}
> +			}
> +
> +			if (dc->config.force_enum_edp || !should_destory_link) {
>   				dc->links[dc->link_count] = link;
>   				link->dc = dc;
>   				++dc->link_count;
> +			} else {
> +				link_destroy(&link);
> +			}
>   		}
>   	}
>   
> @@ -998,30 +1016,8 @@ struct dc *dc_create(const struct dc_init_data *init_params)
>   	return NULL;
>   }
>   
> -static void detect_edp_presence(struct dc *dc)
> -{
> -	struct dc_link *edp_link = get_edp_link(dc);
> -	bool edp_sink_present = true;
> -
> -	if (!edp_link)
> -		return;
> -
> -	if (dc->config.edp_not_connected) {
> -			edp_sink_present = false;
> -	} else {
> -		enum dc_connection_type type;
> -		dc_link_detect_sink(edp_link, &type);
> -		if (type == dc_connection_none)
> -			edp_sink_present = false;
> -	}
> -
> -	edp_link->edp_sink_present = edp_sink_present;
> -}
> -
>   void dc_hardware_init(struct dc *dc)
>   {
> -
> -	detect_edp_presence(dc);
>   	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW)
>   		dc->hwss.init_hw(dc);
>   }
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index e189f16bc026..d5d8f0ad9233 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -103,8 +103,6 @@ struct dc_link {
>   	bool lttpr_non_transparent_mode;
>   	bool is_internal_display;
>   
> -	bool edp_sink_present;
> -
>   	/* caps is the same as reported_link_cap. link_traing use
>   	 * reported_link_cap. Will clean up.  TODO
>   	 */
> 


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
