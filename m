Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477BC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 13:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7E72086A
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 13:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4D9HtT5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7E72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5823E8991E;
	Tue,  4 Aug 2020 13:55:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22E389483
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 13:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC6RpSxUoOrD5NFkRxPe7lqNZVpyQycXSN50EUmEKQ2iE7jXQYe5277ZJJBRcDi7O3Vwaz4jvG1okjKrOhlhPOiGby1UyJ+INViZJIQTlY6HAIZ7yS4JL+SFMZ5zznpzwfLr+IADG+JCxporhCvGvgYG6keQ9Y0OtYo5np61MWQMuWgleu+wu9S624hF9fibUZHzGmdiO3UbgfK07lqPSwoxnge65Ikd7RohvaALVWYf2P45qMAh5385NR5+HdpylgFEMdSL6QxotKhaMYZXPC4WCmKs5vP5RyHr4r38GCvm+uRAQ0mzXRN3ooBxA6J983b/9knCqhgPGhAdTLtUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXQH9fln4y6F8mkynEwvQqPdUQtb+FMcmzhZS93tMbc=;
 b=FUCw5hnvRAEqDeFM0jD17qz2gPgJmQTldUDAsq7N4XB8HhvzPvDCohzvvfkOm9tlgAdv9uyvDzhUF/y0kmOyvVBPuOrFhK/0PtTp88m+EcU04VOEYD/G3cR8jLNzN/fIMoX/jDdfpCMGBpkwoTPDWb+ERujOI5Ug0J7krUazbLkf+AgFFgauGcRiR/EZqFekYkfLKXPalTj9ljF3WTN6C6TWIHq3G1ZtMGJotjvYjaCixEDhXS5A9HvJKYXBzed9wQFcBJh8+4GvRashKRNf1Mt06RWzL6ZX2FINywjL15eu27U+gpSPoSVzVwOOETaXQvdc8zS5fuXSJPqDMhXOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXQH9fln4y6F8mkynEwvQqPdUQtb+FMcmzhZS93tMbc=;
 b=4D9HtT5ml21KQ2oD+HRLHpJ1RCbUIlC1V/jXhoANFE4QatsVLQBYkS1DBOqH9i6pvDZSFOVro7yxQ4lscmIGxMBrrS9X56YK6B0mXcG7xagQiYuLCke4zXDMGaBJLYox6qyHtTqABRJEZOBxOJRNyTLiweZUWX96nb6isyI9NJY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 by BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 13:55:37 +0000
Received: from BY5PR12MB4082.namprd12.prod.outlook.com
 ([fe80::3c92:b772:9dc8:4c35]) by BY5PR12MB4082.namprd12.prod.outlook.com
 ([fe80::3c92:b772:9dc8:4c35%8]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 13:55:37 +0000
Message-ID: <a7b841e16e781f433f8f68a5e957232357bd71fb.camel@amd.com>
Subject: Re: [PATCH] drm/amd/dc: Read from DP_SINK_COUNT_ESI for DPDC r1.2
 or higher
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Date: Tue, 04 Aug 2020 09:55:33 -0400
In-Reply-To: <20200804034218.612-1-Wayne.Lin@amd.com>
References: <20200804034218.612-1-Wayne.Lin@amd.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
X-ClientProxiedBy: BN6PR1701CA0022.namprd17.prod.outlook.com
 (2603:10b6:405:15::32) To BY5PR12MB4082.namprd12.prod.outlook.com
 (2603:10b6:a03:212::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.1.140] (165.204.84.11) by
 BN6PR1701CA0022.namprd17.prod.outlook.com (2603:10b6:405:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Tue, 4 Aug 2020 13:55:35 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b00c4831-c3cf-46cc-425a-08d8387e1099
X-MS-TrafficTypeDiagnostic: BYAPR12MB3014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB301470EB7E932C933D519B528B4A0@BYAPR12MB3014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CutJL7QIRwfPK+8bYO+Dlw/Hn3W1sAxYSyYo2wKlrmsNucjrZmUfdThFaUPxMExc8TOSDijlh9uzB9IZTXcPfWcXERf7YGB7QR/oBP4wA9+ckPjNxDPb6KwFN1KWpWT5GvVhOCJVc0G+dmB5VKMV5R3gtcbjkgQeTn+wiXXKHOER+t4Hk8vjLZmq3W5dqAryzmPBurJCSnSOVgv4JtRS30fpg+eWhDEKLHNSCFDUaWlCEn8FvHr3xv8Yc8y2bjOR0ALe8CjiW0mEGTS+CKVm77/W0yMMBTuxfcvPzQR6y7GoAvwm6W1w6DTUM4DgQ14Xm5gtSDrzlYpq6FMBWeqCtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(4326008)(66476007)(2616005)(956004)(8676002)(44832011)(66556008)(66946007)(8936002)(478600001)(36756003)(316002)(2906002)(52116002)(5660300002)(83380400001)(16576012)(26005)(6486002)(186003)(86362001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qaqBwQjxziRISL7Dh3iNsVbF3K8N1kRu0cpbQccSXsvUJ6b0jnxEsgGC92ifBhpNoPfuQrYq/ay7+xVqPh+31WOzMhRNth0TxZorkKn0SUyDoq+8qAMd/M5zaMIpfTpU+w2NuzQYq8Wpoj+FSJAFSGsc5oZItfNoHNQ0iyMoUXCWhOVl/YBCBUNcPArDXghKGt4Pcc2bEKKzKnNyu64VZhFkPapCgNwantuY9Dzb0Bl3iLVoA6Wa+rkRR3CBA30xSwOpz8g0EHay3JGBd3j03pWAwFPmtuXGQ469SLVjyGJ+qNpTq33i8Y4BRIQ3XOkUmLMHgxYCqfemlX1LgpWzpj5nM96i6NfIui6/61wUEeKm6PVM4MrL7FWcr8FTMIeVI9h3P7BI8c0c3z/9++EFLees5K0Sg562/6l6eYFxlzo5mXDvT763n3UBsCcYlqlx0SDrNi7M/1RvV0oZeDtfN7W3S/Ww1pzfO4LugA2k+DkQYUIIJ5sb/wUMN9Fu/37PTJw5vVuhs5GcXFSWpiF3ZkwRz3NHZ7JaO4yWl2Qx7Xmnedt+NBr4v8OugXKIcL5oZddjbHV7W9U/i+u4DpC4Tw20w/Dap0FYT+XcmzUupOZcKzXCmwmB/u9QFRaYsAUYXoiXK/lx/vFmtSUkjhIOtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00c4831-c3cf-46cc-425a-08d8387e1099
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 13:55:37.0729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TdFLOm6nFhbrsUk0iv3Onfrkvv/MAn6QKYM27UqQiHjvSL7F1APTpXfqWGHhWJavmVPQClcKnRx6TU6m7t0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3014
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
Cc: Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, hersenxs.wu@amd.com,
 Nicholas.Kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 2020-08-04 at 11:42 +0800, Wayne Lin wrote:
> [Why]
> According to DP spec, DPRX with DPCD r1.2 or higher shall have the
> same Link/Sink Device Status field registers at DPCD Addresses 00200h
> through 00205h to the corresponding DPRX Event Status Indicator
> registers at DPCD Addresses 02002h through 0200Fh. We now only read
> from
> 02002h when DPCD revision number is r1.4 or higher while handling
> short
> HPD. Need to correct that.
> 
> [How]
> Set to read from 02002h when DPCD is r1.2 or higher
> 
> Signed-off-by: Wayne Lin <
> Wayne.Lin@amd.com
> >
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 2bfa4e35c2cf..9fb1543b4c73 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1834,9 +1834,9 @@ static enum dc_status read_hpd_rx_irq_data(
>  	 * fail, so we now explicitly read 6 bytes which is
>  	 * the req from the above mentioned test cases.
>  	 *
> -	 * For DP 1.4 we need to read those from 2002h range.
> +	 * For DPCD r1.2 or higher, we need to read those from 2002h
> range.
>  	 */
> -	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_14)
> +	if (link->dpcd_caps.dpcd_rev.raw < DPCD_REV_12)
>  		retval = core_link_read_dpcd(
>  			link,
>  			DP_SINK_COUNT,

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
