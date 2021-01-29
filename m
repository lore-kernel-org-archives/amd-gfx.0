Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B20C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BD164E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BD164E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C196EC36;
	Fri, 29 Jan 2021 21:28:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0F96EC32
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3X8SfmWeIHTwYR4IAVwS70GBPRLLif33Ey56ntnA9DP/cfGgmkLYrKe8YKmFdcuNrpRed+VHVPTd2212mWqt9EZbDQM7QaIgVjpsxRdJh+k6Zlfx20+08kJhJ0Bgyz4TK6ZlWK2Ir8Ef73EdzGeK+NKG8/VfTcpeP8wxUmKxvn+qYf4G79/ffDEcxv14nSMarsRnOSoYxhxr4DZpeEwuIEuaEkTA3sQNA8YjW99CKhfoCqeiE1FPeyISTUUDcWHFtQPPp2BNldMYEogs1g/1PGeH3pEElPe8tAMqD25Lo/KKF5vkgb8nQqcyNlkCWUdvNHsu3I3NDGYKFroxnnJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbsaYCiPLq1pLd70815Xvn1tobJz0EIObkoVAkrnDwI=;
 b=BAGocDdcK8iz2L6bQZRBfzLkls5XpfNd+4YjdUTs+FHmaaxj9PgnH3p68NHyTtRZs9VR5UR59tkW1Y7rCd0lUlmRMe+3gbQG0Ew1uXJ4oTOwivllHqH/vUVI9Y/qpGcW+QrY34u9bro0ErarF6Jku9Jr7BGfYNwfCiyJ7/g4XU3KjxViGe6+XWvHL2dvEFZST1BSTGHONS3DBH2G9y+D6pM3debNcxeg/q8L/W27B7XUMpiXR32Xjs7BYDd6CxewDtHit+lJG6L+1hM97iN6J9YNEZek/Hgvh+CvSxvBbP96F7x3+FJA6FItPTv0qUar3VMQ+n5MYyedkB+ULAOQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbsaYCiPLq1pLd70815Xvn1tobJz0EIObkoVAkrnDwI=;
 b=s+PsO8C+ta6WYHbtgaLj9xLcL6r6PeTNinnPQk3QkBNAnjbptiNr3wjd4GX2nl5FyOoOWEqbdZ00rhoyG7Zyznny2Vgb28HSK1Myl/9y5ZekgwwC7cNLup4UbkB3PXzYS+168u66cp04mY2JU2hLGtPN9qpwqh1lB78Tr1lUAkQ=
Received: from BN6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:405:6f::18)
 by BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 29 Jan
 2021 21:28:39 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::cd) by BN6PR03CA0080.outlook.office365.com
 (2603:10b6:405:6f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:23 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:23 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:22 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/27] drm/amd/display: remove unused
 force_ignore_link_settings debug option
Date: Fri, 29 Jan 2021 16:27:45 -0500
Message-ID: <20210129212752.38865-21-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6537b2b2-9f0c-4645-60f6-08d8c49cd731
X-MS-TrafficTypeDiagnostic: BL0PR12MB4868:
X-Microsoft-Antispam-PRVS: <BL0PR12MB48689F07452D6D187E184288EBB99@BL0PR12MB4868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRjOh1mdX4PojdVFDNpgHBm2FBwJWG3udQqdXLebn6qYcm0GpUnUAxqRzq1j5dYFHZshxX25i4wk1O81aUcpT7n6kfH4j5ep3H1AdfedrWjfTZa+3xs5mKArCgYcsS8HtTuOcoQZW7n7lJC2aiS9PMLzNBf071zDkHpUEHiKTA26Fe9n1kTCWTb26/H+fkqGUzELq86109qR+vTPWYKM1W9EGrpcMkvGSdnxYR1XN5Z+5dGM0pyAygexDXjwSDZRaB3I+SS1jlvF16A2YTegXhHn9SX2bkHKJjqTqWx8fgaVBrmyF5uakybdmyAsXU1p+Wt4v/kLxHn7IiBs9DyqpTPuB05rIw9DCUH6hc9Eh+zHpNCbD4krSqVyANsae6454UTKAMOs2USQrb1n5XsRmG1ztqsB3aQcnNBEsFGMGiHJ4SIiO08rWjpJRvlA0XSanGYpYr3L+Vr80x8VkjaX+HPVIDQQ+VpiI93cZUe+8/wRMB5v8o+JdB+/CABiX+VuMLYeEzlnkJdTcWYHuwrDbvj3OcrFZBXhGHiszsdGPS9ok4bdgtfj7O3vpplMXTpoa9xMrgP2j7bSNTWA2ipEFeuJdQ6kX9Z7TZ+GOvgaUNw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(54906003)(36756003)(6916009)(316002)(1076003)(4326008)(47076005)(70586007)(70206006)(6666004)(5660300002)(7696005)(86362001)(478600001)(2616005)(2906002)(82310400003)(81166007)(8936002)(186003)(26005)(426003)(83380400001)(82740400003)(356005)(8676002)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:37.6765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6537b2b2-9f0c-4645-60f6-08d8c49cd731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Eric Bernstein <Eric.Bernstein@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Remove force_ignore_link_settings debug option as it is no longer used.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 --
 drivers/gpu/drm/amd/display/dc/dc.h      | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e3a65d1714ca..8d5378f53243 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -772,8 +772,6 @@ static bool dc_construct(struct dc *dc,
 	dc->clk_mgr->force_smu_not_present = init_params->force_smu_not_present;
 #endif
 
-	dc->debug.force_ignore_link_settings = init_params->force_ignore_link_settings;
-
 	if (dc->res_pool->funcs->update_bw_bounding_box)
 		dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ecd354bfac52..d5105924c9e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -526,7 +526,6 @@ struct dc_debug_options {
 	bool usbc_combo_phy_reset_wa;
 	bool disable_dsc;
 	bool enable_dram_clock_change_one_display_vactive;
-	bool force_ignore_link_settings;
 	union mem_low_power_enable_options enable_mem_low_power;
 };
 
@@ -679,7 +678,6 @@ struct dc_init_data {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool force_smu_not_present;
 #endif
-	bool force_ignore_link_settings;
 };
 
 struct dc_callback_init {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
