Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE460C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 20:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780E960FF3
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 20:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780E960FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED446E53C;
	Tue, 20 Jul 2021 20:52:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157E56E53C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 20:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXYedA1C86UJt3rFCH5Di/X83tZ47OOx9Z0hdM1ou91GuVF7aJ0/gY/I6g2aclwGt5lWwu6IHGN0hXs/skr3Hpk9ckojRrB1Elu7XOFsMgWTV3MmTu8AeFRpByvP+sr8Wf91uUGVRj3k2z39tv+YVFej0Y3xFaOZIMaL1+awrDJBJ+lnA1eMsqBuYTQ2hCK2DeH6GEiYoIEKWWKNDkwEJOjKZuO/iV/ftPETZEYrM6Py6OU6z122Fy6MGfNZZqnfqzLrD7GpMJvVQUmOf8RhlXeqGnFCqfwMGPKgtNjOG9vN/bauGBBsWScmNvHM6BXdwEb8PimjYSVESeH6LuZ9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSbng+myg3A7/7urIGWDrMhPQ539J41m+0IpW+A8tvU=;
 b=R03XeVGlwkC3/QtbyK1r9lB52zswp+ZdGXgNl3xSW/kImYNiUjXWPKfpwWeFS1z/y6KAc0TnSXG3p5HXUUMLfq6Hkmn5/Q8TvIhAcBIy68H4HCe4fIpo1OdC0SfwwvRaurZSXpxfn0uesY+DFOj1LlSfpWcwxSGGXQeaU3kQuFjXtO9F7jIBlTY5pLwYm2EAXfPDa42S3rivgv5jqzzgkiugWnLxUEp6uTqP13LrN3qV06dE+2JN1bruODPeFclfNWjt6sERd43dWUxPTRJ4gWeofebzg/t+zIW2wIgrBTwQrYwLhzAswiDmoLdrXUvx6dBySVkSVqqX5L8IeH2RmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSbng+myg3A7/7urIGWDrMhPQ539J41m+0IpW+A8tvU=;
 b=HzDtjQTbxi9ImD56UR1bcmwDVreMaif1cXoHZlldHFGI1MUZdRAQRrO46zizm4dW7olIOOgwFrTnCLVK+UsuuDPxgGsk88zbD+4Cselb9eODR5LMzQTcPglh1oJeCKUoPXK1AzJprpE+DkylqYw8iXcGzac00drorgEbAqskv7g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 20:52:22 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19%5]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 20:52:22 +0000
Subject: Re: [V2] drm/amdgpu: Fix documentaion for dm_dmub_outbox1_low_irq
To: Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210720143017.613974-1-Anson.Jacob@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <b04e9b65-29de-39d1-5615-3b5163b02d2c@amd.com>
Date: Tue, 20 Jul 2021 16:52:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210720143017.613974-1-Anson.Jacob@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0102.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Tue, 20 Jul 2021 20:52:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44a629ac-e93f-4f8d-31cd-08d94bc04549
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54263A6F288D0170014DC8A78CE29@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vkA82xkWNaCx+aAtTd7BT6LhRdc/5HjSsjtWw5s6kiVHjELIKT/pzbSl40pvo2xeXdnFqW0s5KBWLzpB0IAntcfGLJm43pBPy7W+Nn9nZXyUZMuGYnXazyYb8/PHDvUlYGtKgH0BFGyUJdtat1d+UVXXAC28/kGOIc7rPMVBn0rzp48SJknStQfub+qroEf5EpJyHYiG8ePK1tWHUu+nZ5GN06aQ/3bF484tPq19YVj9du5IxqkFf8cMlNzz+PRlA7GON0O5LCtUbPgH2gxTPhoBTHo5XIqRdKr42qfCbPFKyUBrIsT+rhgpK5DbeNoUE2szQxYE+Vx0xtPpWLeN3qeFZpob3w+AHTpWkkINYknkyDpKUH4qCpWnpSh5cgqEb9JK9dpnwYr1JB8lwOEejDgib2lqwL4C2eAFkzNMiSx1nbVXCtgnZaS9BUYpnz1HNdsjtNZXJnO3WPnzrQx1pRVYuFbp3dBpeFp1eD7YdV8QGTe8mA0hMk8ZQUUrbF52FgYKxT2WTgv9y9Uz1MQQLaENJEvufx+f9X6K8sF9N/iiHPFSUHj3F/9XkDL+quswFyujpZF6g9JzWwvS8R0vUyMmtb0pvqTf+s6cEdD5Rthp4PJix/u8m+1yGtaDk8vdxoA4QFwOoLMbaDDv9ZfPYc1NmRUfMNCCPMEK3FtMykm5n9ulsy6Tr9T32/Hz6yr+Rq37JXymMDQa3TblcFwltPd2JmNEx4TybGjV2EiR5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(2906002)(86362001)(6486002)(44832011)(53546011)(5660300002)(26005)(8936002)(8676002)(31696002)(36756003)(38100700002)(316002)(16576012)(31686004)(956004)(83380400001)(478600001)(66946007)(66476007)(186003)(2616005)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzVuU3FFUTRxQjMvVnBDY3o0RHhCUDh1emVQUHhxTi9CTXBBT3RiOVRZQ0NC?=
 =?utf-8?B?amhuRUZQQ1MvWmZOSm16Z1kxSWgwUjdSZWtGVE5LamFzd21aR09RQWljS0hs?=
 =?utf-8?B?MmFXN1k1RXJSZEJHWXVkcUhydkFYcHZoOE9zQVVIV0JIWjJWNHUxZDliRUJC?=
 =?utf-8?B?ZUxURFdGR3JGbVQ0OHdCenNRSWZxVGJtVnRySXN3SEovR1NCd2lERW5zUk1F?=
 =?utf-8?B?MEhUSmFVVERJRDgybUEwWloxWTVUUmthWDZsQW53cmFSc2czWTlLSEgrS0Fo?=
 =?utf-8?B?dFZtMThIRSt5QVpVRmtMR1FVMWxDcGFBd3E4aXQyQzBNQ0IzRkEvYlB1ZjI2?=
 =?utf-8?B?TUU1V3RrcmRjL3lkKzBQMXB1aFpyMjcrT3RIVXdOL21KenRTKzRlS2VpN0JO?=
 =?utf-8?B?WXhmS3hRYUtnRGp2dk8ySlJBd1FzUllzeGxJWWZ3bjcrbzUyMkxPRmxVSHF2?=
 =?utf-8?B?UG9Ycmc1aGUrZFlyU3NGamFZL3VMR2Vic3hxRjZZSFdEZHhtRkgramYvNUo0?=
 =?utf-8?B?KzBWMEI0YzlRVUtMME5MeGxIU1dEY3d3djJzS09QOXRqM2gvSnB6R0N4NlVR?=
 =?utf-8?B?MmtrZ1RSUGhvMVhJRFprcWkvVTEvWEFPY2FuZjZnT2lZbXYwakpFaHpOQU5B?=
 =?utf-8?B?bTl0aERRODJ0dGdjQW15SUU2TUpPTmNVZmxhaXNqTExxNGJEeDAvVjFLTVhq?=
 =?utf-8?B?L3FOQjNyUm4zYzZkcEZ0aFBLdm5uSlhoWDZkQ0NQYmF1OG1HU3JMcStqbDF0?=
 =?utf-8?B?NkpMNkMvbnBBZEFHSzNnSHl5N05nb290czBWQ2pvTkg5TVZzUWp3bWhZWENn?=
 =?utf-8?B?WVZyaHQ4NzcrSmlIVlNRQTl6SW9ySFk3N0M3QlRCTGIzcm1NdmhtTXYya0Ju?=
 =?utf-8?B?WUFHNld6cHVBKzJWQjJHSlhUcFBaaFJaalRCelNEQ2lsU1RFOXNCcDJzSGhq?=
 =?utf-8?B?WFdvQTN4RzhYTDdLL3NPdmZzVUVmL2gxdlh2SWRmWGNjb2djYzVEcTNKaXNl?=
 =?utf-8?B?c2ZRNnJxSVZGWW1TVGVralFpY2hSaFJVeVdveDlSRWdKRFlFRnNncDRkOVg5?=
 =?utf-8?B?V01kNGFrOG1jOElQYWVWRVZZWEJQcE10QXUxdWNTcHNDNE1xQ3VvUzVGMlhE?=
 =?utf-8?B?eVhydk5aejJUMkdYcWROM1FvTHYwMTQ5ZlpnaHV3K2RTdjI1TDZySEZWTUp3?=
 =?utf-8?B?SjBvWDRXV1NrUlpnSXNpdFhrajg4Ry9xVXBhemt2aHJldWF4U1JLUHZ6ZTdm?=
 =?utf-8?B?OW1TWVFzVC9zL21jNCtWalJJcEZZT20rM0NyU0Yyalg3SGFQTDdnVDdOUEl0?=
 =?utf-8?B?Y2pRRDk4eWR3R0JHZWxyTjE3emRjdTlkNlVMakhRUnZqOUhkQ1k0TWRQcjMy?=
 =?utf-8?B?U29FMXF1VkMrcnlhWlFVQnlONWo4YlYxM0lDVElRQUh5OTlTMithMktMSis1?=
 =?utf-8?B?QVRvSXRFMVBxWng0em5FaHFXdHBFVUZsbXl2ZC9uSk1Ebk4ySUF5ZFdVdlhL?=
 =?utf-8?B?WEt1MXRBaHF2Rzd1RWtxeElsRnZxaEFkQys2SFliSGF3TTcrU0RaUGlWN21T?=
 =?utf-8?B?MHFJbUVWK1VJVTVUd0NNcUUrTlR2MEx4LzRRTWE2ZFZxYmVSYk5ZM3ptN1NC?=
 =?utf-8?B?MVAxdk9uMWVNQXJ5N2VGMWdvWXlScGpocjJUZUlVb0J1NWE3cXM3d2JTcDdB?=
 =?utf-8?B?ZnU3OXc0WUtzZDVuTlVocGdLVERNaWlJanVZVDM1QTJBR1FpckMrU25uR1p5?=
 =?utf-8?Q?Q26U12EFQXOb/PngDY/su4XGRGjsvSbongllaeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a629ac-e93f-4f8d-31cd-08d94bc04549
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 20:52:21.9129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+NDjGHF+asA9mK4G/GARBExd9l/G/X8/6QjDuUQGPWKAEdjpAdr0O+5bTeShpBxmQIkGJCueCiVVZDZft9/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-07-20 10:30 a.m., Anson Jacob wrote:
> Fix make htmldocs complaint:
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:628: warning: Excess function parameter 'interrupt_params' description in 'DMUB_TRACE_MAX_READ'
> 
> v2:
> Moved DMUB_TRACE_MAX_READ macro above function documentation
> 
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
> CC: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7ed104e3756b..829d31e04f09 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -618,6 +618,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
>  }
>  #endif
>  
> +#define DMUB_TRACE_MAX_READ 64
>  /**
>   * dm_dmub_outbox1_low_irq() - Handles Outbox interrupt
>   * @interrupt_params: used for determining the Outbox instance
> @@ -625,7 +626,6 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
>   * Handles the Outbox Interrupt
>   * event handler.
>   */
> -#define DMUB_TRACE_MAX_READ 64
>  static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>  {
>  	struct dmub_notification notify;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
