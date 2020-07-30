Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D4C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA48206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nzJ62d79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA48206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779BB6E959;
	Thu, 30 Jul 2020 19:12:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0FF6E958
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx6WFG6ud/aOo2jyDnWkaLGwXJHjnTb2YWIiYLB8PLBIJyUDqFhPxQnhMaeglE8dpXopYMtDRDA2yIhqQ1zvtix3seCJrTUBbW/CDzfDBbhgXC3PKLznzSaHvEPJaTYoBAVbvsLVZ6RKERmbsGdBzNvkmauNITpFt8uSmkU04c2xpQIvqQ0J8Wh289tYbRuKEsYToZNrZ6e+DWmuwM3Lf3YIrS8IR0VbDlSRTlgBC6eHdNfr1Fop2PUeAh9Ee6gJ4wWsKS9erVprPKYmFUIfXs7Bk9x2cyYy0U7hbvyjOJnXmy16M7sHPi0prB7HZAzIU3skAf8Dmu2vIzli0EHGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26DCNCEcCda7EGrJ+ExQ2bCB8CW40qbBe2iDwU3iYag=;
 b=oeNq3pWsuvQST38PFuiRM80Wpw/2kimRBZGC95IHw0LN6pL5PamZB15/65WORG7bSTffj5nAmXrCZaDDQVM9qjlFQNCL/fIFWNz2hZmFB0NhikuTb4gKjyABiaR2qZsVyqbdD+6cEiQLjqdRoVkS77tMEzTczaTU7NGH6q83+347pw4PocDDG5Bqh3IpCt1kzyaLzeftuhq4qKDj+QndIv8eShtPF6ptA904F4Q7TsodnfNBnCWrqR3/dFHf9Tfufycy6k15EsWAcc5VZDFJYWP50hEUGI55Ixt17xD+F5Cv7iHV6sMkSIdg6iO0epiPkZuzyVF/eXzdQJK7ZHxv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26DCNCEcCda7EGrJ+ExQ2bCB8CW40qbBe2iDwU3iYag=;
 b=nzJ62d79khKVg685A0lhrd6Ub9yvKxmt3Rxq1M/3gYFD71BLhU7ctmacyYCrBWaua5CEtDnzbhQvMWbgRByvFKOmjdbxTcx6P0XuqlrrfjKXv0ZLWUnGs8NoqWCTTBB4fvKONTJgnFavbnJw+fWBn2NhkTosurCXes1oNpjWT/0=
Received: from DM6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:5:80::33) by
 BN6PR1201MB0243.namprd12.prod.outlook.com (2603:10b6:405:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 30 Jul
 2020 19:12:20 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::6e) by DM6PR08CA0020.outlook.office365.com
 (2603:10b6:5:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:12:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:19 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:19 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:13 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Fix logger context
Date: Thu, 30 Jul 2020 15:11:37 -0400
Message-ID: <20200730191146.33112-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28601c7a-52e0-476c-93ae-08d834bc7bb3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0243:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0243286EAC2B6DFDD3E282398B710@BN6PR1201MB0243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25V7EatgX9MXW28A6bffUT7PU/fvNblaa8j+OL6Vr/21HzrOwnnS63FAXhA6Z//r11/HOrIuLtbXo1WPfQmD9osGQIS3WlTY7P7U1Ne9Hj7ktT0N19s57CpGi9GlueJhiwxCbkAW7jh6Zo+lazcztqXa1U/LSy6XRaEpesElNAEt6vfwGV3rjIP4ExWukvPbNyjnsjcNGwBBn5Bklw2UJY4+r3AxsH2SJMWIrhWUe7AFuHS9UMMQ2B4+c+hgtvvNPnw8fsC34s3mv1GQ33vKCSZRmdZcZIKhAlN9vLvrZ9I+NHMypaCcrYYke785G5lws6916b0807O2WDQckgcnvpnNcu4XEHItE1HEUakh8DWGcBv1Yn1NyXFEPTwN3YUfCaYR6emAjVquViP3xprQDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966005)(356005)(81166007)(82310400002)(47076004)(82740400003)(4744005)(36756003)(8676002)(83380400001)(5660300002)(186003)(86362001)(1076003)(54906003)(6916009)(316002)(6666004)(336012)(26005)(478600001)(44832011)(2616005)(70586007)(4326008)(426003)(8936002)(70206006)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:20.5948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28601c7a-52e0-476c-93ae-08d834bc7bb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0243
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why&How]
use correct logger context

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index ca9eedb643f2..949b61351ede 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -71,8 +71,9 @@ enum dentist_divider_range {
 
 #define CTX \
 	clk_mgr->base.ctx
+
 #define DC_LOGGER \
-	clk_mgr->ctx->logger
+	clk_mgr->base.ctx->logger
 
 
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
