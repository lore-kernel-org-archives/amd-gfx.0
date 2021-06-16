Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB656C48BE6
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 14:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBE061057
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 14:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBE061057
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543A96E5A2;
	Wed, 16 Jun 2021 14:47:06 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D72B6E5A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 14:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8osNbBu6LYBYBIW1kvXQ8CSk/gWfOzHEuwTvHUn/9mtxWZPouNGBf5LZ8q6GxOZAZ8cSvjP0+bu3Z+DgNKVMiDxO0fHD5rGUJdpyLBKOfhgNB8dY/c+u++OGeTEH4sb4CyeDLKq3sUUj7OUw0rwvNljadiUDpLaLAdp4nS+By+3xDTOHcxtBW1egOecvx9qFGfN4yXWY3rKk3HokopORsrMAGc2v1hediIT8JnUPkV4Phl57wvedxSSNx8eY4nOkec6chfICSRwtFATuEXokxwi4lbIQofsT6LNi8RTkvyyI/4Ay1Y8rXujWs0H/raQUBOvi4o/lQxKUezdssm38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4e7PguGOCAZkUEIFh0ILoB2Yv3AbICm3+7O1RVHMTA=;
 b=Z881iLrScJKHf31XcILUsQLY4bEjvUwybC6OcdSDYpVhpbl+enSAk5Y05kt6yvBFsvM54IOMk6/Aab4+JEDKN8vcCBpiGcrLF6tVxEcNo5ji3/SN9B4a5wYtlqU4/MA/WqypV00wwpnWk2m4izfl6XAHZZP5iFwIWlrhPaButUjkfItsvFInvP9c3eRWWYkY2z9U1nb+e+NnRz9OV/JibQEVArQzDWmNShhbXQ+KzsZ4hEKg5DyzO7w5FDpFdeUZK0k76kmuuJYZmacC/A7G4riffj6+lTgUUglWN0mK2JuKU9vvF1Fybj8H95a3e2xKU4EECBaENKVCEi/7HGjN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4e7PguGOCAZkUEIFh0ILoB2Yv3AbICm3+7O1RVHMTA=;
 b=KQ6/2KpbX10v7QibUzoLDhrFbSuqv0hOHOd2NU9TirDSfVQyFkFnOcY9WxLVKtapETnEa2hYz7HspwnQT3vT7lZNB7/UZl+0hpmL8w9IrI3/yHKwYfq8HVsKGmWZ7yRl+FISuGutHBJVJ62n/DtQCl6syTkRsDtunf354OxHNb0=
Received: from BN6PR14CA0019.namprd14.prod.outlook.com (2603:10b6:404:79::29)
 by CH2PR12MB3719.namprd12.prod.outlook.com (2603:10b6:610:2c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 16 Jun
 2021 14:47:03 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::cf) by BN6PR14CA0019.outlook.office365.com
 (2603:10b6:404:79::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 14:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 14:47:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 09:47:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 09:47:02 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Wed, 16 Jun 2021 09:47:02 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Increase stutter watermark for dcn302 and
 dcn303
Date: Wed, 16 Jun 2021 10:47:02 -0400
Message-ID: <20210616144702.56505-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 525f6ff1-5d76-432f-0737-08d930d59ae5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3719:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3719FDCF3083E7192601D9B98B0F9@CH2PR12MB3719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aidUtdNCn7LqVOex2XXBUq66H4DrrpN2KyPpu3BV/bKgNLDT8VZyeW9g6UWGpGKpICKtsUfwK+PYHvw5OgkMfCw3slsu+RD/rzcgwIpm0Ryv8dRnJuZn094lkUCtEV/mx8eaUcOM2v5qNkdTTjHA37AHZ2RvYz1AnbJbGNppD/6wK5nF4qH4wt6/totuZjVK9hD4oHsSTJqp1DvIJxdqVQX/fkOLSnX39x8Se82Ib+z0pQYLmdC44ZOliO+FEPXr1M9yUOtNRuBVaEW0oIC4dxFm1ls9w6XeMgbB9qZqxtlDyy6+5x/1snCloxGZtbs/2IYC7VFfGuqgYAH+uFlWu/X/q+cC49D8IxfiUUms+mXtzboGtjxNl1AgMTAC/5MSnXZlbz4eOMmCF4/pRBVYP0TRoU+orcqOIGbj0tjQjLBq25Mdi3NvwcNse4BvVEz5R9HpfcTQWUvY7g+seKHiBvki/XWIjGq5kFraVi13MQYOS3tvORxLyLVd3KNPBidySdfBHNj7y71LBppkq0cf8euvUKHlDhWxNezZvY5HpImvwg23mz4QTYQM0tIVWaQ9PtUvgQn0uGI0PVaQWAQK2DfE5FNkRdGLfwigyghf3lzY8CU/EnF6+CboENjpkXYcNtKSo1/fEcT41w7K87YGOdgxOQripAqQAzIOsYLH6OawSe756/sx+6NGCbfHecz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(36840700001)(44832011)(36860700001)(186003)(82310400003)(47076005)(6916009)(70206006)(426003)(36756003)(82740400003)(478600001)(26005)(7696005)(86362001)(356005)(336012)(4326008)(2616005)(81166007)(83380400001)(70586007)(8676002)(5660300002)(2906002)(1076003)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 14:47:03.4084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525f6ff1-5d76-432f-0737-08d930d59ae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3719
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
Cc: aurabindo.pillai@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Current watermarks end up programming lowers watermarks which
results in screen flickering and underflow for certain modes like 1440p.

[How]
Add 11us to stutter exit & stutter enter plus exit watermark.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index b16d19a25d88..628b227f0a13 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -164,8 +164,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
 
 		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 		.num_states = 1,
-		.sr_exit_time_us = 15.5,
-		.sr_enter_plus_exit_time_us = 20,
+		.sr_exit_time_us = 26.5,
+		.sr_enter_plus_exit_time_us = 31,
 		.urgent_latency_us = 4.0,
 		.urgent_latency_pixel_data_only_us = 4.0,
 		.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 758f89ba0192..88b609c32b0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -146,8 +146,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_03_soc = {
 
 		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 		.num_states = 1,
-		.sr_exit_time_us = 15.5,
-		.sr_enter_plus_exit_time_us = 20,
+		.sr_exit_time_us = 26.5,
+		.sr_enter_plus_exit_time_us = 31,
 		.urgent_latency_us = 4.0,
 		.urgent_latency_pixel_data_only_us = 4.0,
 		.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
