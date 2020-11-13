Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3425AC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 16:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CC72076E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HnFCAgPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CC72076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041A96E50B;
	Fri, 13 Nov 2020 16:15:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FA46E50B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 16:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ8BuTky1IIJRHiz9w7uStlHvZ1Uk1FMCsIfKZaVu9QjTjUetsHwmdeg5g9+KfWXyyBJxQ/8775sIAbNa2hpppmeHGt1H7DqFBI4UL1c3BEA4Kcjjngkh1VdWd7chA8GqAUfbla5s3zKFXd4OnF0fMKHU2VSXU2YoMGgEwSy+VxebmCJ03JDvnwpUNz2NyAMjEGrGk7f+ecr5slJ/UjQ+kKJESvRFWn3WRTNwX5FhAcrBfMyhuvbZ2GV9VMIbrVsyaevahwtr/27ugg924MyG+NK3/EYF87hW00kuPM93FAqbHxnE4aGgpYNRKOMeshNOgkSSF/dA/k4wr8ZcCI5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEX62aW3vaMcS/7VhIjv0DJgePOE0Mb63l9lYqU8uAE=;
 b=DJE6yrrfyFLXKMo6c2lDbuomgTrGEX921HFltpnJ9epHdHYu6Sn53osAwaH2pDusBADKCLn64urXq6FpRMG3rc9bsbKSrZDgSL2zk+0+rtm1zVrJ9x/Kec7lwhibFoN08j9PIYHFSUa9ir6f3YCxMqm/8AGouWaODYBiJJg4TEa+dQhngR8QrM2sACf5LUA5lgWtpl6HBlcOqjJAY/Lpco+BrpHl4wVQVVDG/OkGVjZ+7UnDbzK7ZS3lI7D6gmxXgWhHyaL+1IV5FsNR5J0YJdFy3pRs5G9XOspYrZV3qicQu7KZi119GJvDtAXpgFMBVqeGg3I6iQL9dhqkim620A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEX62aW3vaMcS/7VhIjv0DJgePOE0Mb63l9lYqU8uAE=;
 b=HnFCAgPRenzWX1jNoJn4GUKy72tyKN6chgvNCc2EHyRglb9q7pDSVrTpDPH1y06+6zcL+CYYq62XYjMPCx7R/x8PpmB3MmIK0xd3pmIYBCE/WpMLiJTjggPZd2cwEGCJ30ictAIekg3IreBjEY+I9o72LIE8MDXPmxoFyNyun4E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 16:15:04 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.037; Fri, 13 Nov 2020
 16:15:04 +0000
Subject: Re: [PATCH] drm/amd/display: Add missing pflip irq for dcn2.0
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201113072338.223290-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <4f17cbf8-1b0b-c2f7-a05e-670bad8da726@amd.com>
Date: Fri, 13 Nov 2020 11:15:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201113072338.223290-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::29) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0150.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 16:15:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9b53937-e176-4178-6b12-08d887ef47ba
X-MS-TrafficTypeDiagnostic: BY5PR12MB4305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB43057CF7454858438A9ABAD5ECE60@BY5PR12MB4305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkoEtOOpJAiqRpU7ayQywzgNJ8V1rqBufcukC7jovoN5qnbNUYzsgspbWHBf0zSATMVK02Tu6mIsTEjOY1zcEfd8X/Pkow2DuFAB59u2jlXEhafaeQ7hG3a7Lk9YntVu07QSgxAe9F7ml/LlMtXhTDyRH7n7rJnnnw427X8X0NkE+kWVZqD6D5sZPgKoHm0ZZ/riysdlumlL6ACpcDRWlhSVkIEy5ZHfIuDOGtpOx1tq/tW3QgRKp0n77f7szrbAEJDlM+3V3LlEFE/kjmNEJ4UJSBZgFaJPVclLIDoo+tDjrhab8pT4XqcdeUlptvvqgK/XaBI3FmuZS+3aqDZ4g7HFy7vgvO5vkF/YiHzI47PO0roNJ5CgearroT7VbBs6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(66476007)(316002)(31696002)(2906002)(16576012)(83380400001)(53546011)(186003)(4326008)(31686004)(26005)(86362001)(16526019)(66556008)(6486002)(478600001)(66946007)(4001150100001)(8676002)(36756003)(5660300002)(8936002)(52116002)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZKuKk7u3ycfb3e6wGAGoYvK2Kz2h0Gx4BeA3sFWMGE8Guto/9oexfJI0qNBAhDAFQzZkFJRDN1x4ehA/+CF0EuY8IIUqsYX2Y7L6J+7cMmYZHDXI50X3VeMQDkw4/vPx6p+x1GzFwemVkz9ZFLlTuV5XKB+PC7i3tFLTjCCgnarFIoJ8RhvCSXAjcako8AOXs7LJVWsKP0FUIvMKQSJ/tQmjUzVQbJqcp/wv/7OfvAbVluslpbtqrgrHpUKIs6HEczlHVqcpDuOSk0HVIkS4LKSmTSgJJznBxYThkP8JfdffGaAsxm5Zsj0B5R6gfgub4s2PxeRH6F6kYfc9QWsozG3SlFWWHVunwErtxfRubycA9A36LO4DD5CbcQv1Y5TYKKs/P8YJrMVnu9TaCNGc5k3lkPDgjvw0b8/w10Bi9KiDBrRZla3IwmHj6BoLAifiiY5PVKYlIs0F9KmhpnnKhHApI3r9xpGJXLPJP+WLIo3gKw0YqeGITfgvtWUzHoSyEYJYF0CYbp1zhcI+FGPv5C5/vl5nFIBaJVAH/cam4F4Wq18BtpCGmjKvB72u+YM9GS01b6AUQfsaMtpwyW5LP+jRP5GzdpTdWg9GXuP0R1SNqgXfzvfN1GtjnsbPXJlj/5hkQ8hdgp6GtRlsYZZGVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b53937-e176-4178-6b12-08d887ef47ba
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 16:15:04.7235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orp7sdZVjnjL4NMEI+x6innT/xW/gjexy4YxL9Dq8e13uCscMY3z4inB+aBDI7GysbQ9INGymZz7iwLwu1Tn/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-13 2:23 a.m., Alex Deucher wrote:
> If we have more than 4 displays we will run
> into dummy irq calls or flip timout issues.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> index 2a1fea501f8c..3f1e7a196a23 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> @@ -299,8 +299,8 @@ irq_source_info_dcn20[DAL_IRQ_SOURCES_NUMBER] = {
>   	pflip_int_entry(1),
>   	pflip_int_entry(2),
>   	pflip_int_entry(3),
> -	[DC_IRQ_SOURCE_PFLIP5] = dummy_irq_entry(),
> -	[DC_IRQ_SOURCE_PFLIP6] = dummy_irq_entry(),
> +	pflip_int_entry(4),
> +	pflip_int_entry(5),
>   	[DC_IRQ_SOURCE_PFLIP_UNDERLAY0] = dummy_irq_entry(),
>   	gpio_pad_int_entry(0),
>   	gpio_pad_int_entry(1),
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
