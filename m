Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1290C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 17:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C816103D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 17:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78C816103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0E26E1B1;
	Tue, 19 Oct 2021 17:51:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56F3A6E1B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 17:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIzu72zfDpgExtpkv2seU4Dp0fQaADeulX2p473nKdFJccq5hB7MazjxL6JlSdx7EeM6qVdjDIkfC6NV8ozs0CQKAv2qQWQk3lLNEkM2x1xCDSAv6rU2BKbGW+++UtoZ0+LIcFoeArB5reORsY8xcGWY0cZyPls/Xd8Y4kaY6lcxSEGSbfZm7/HL2EQpRaOgAzHfbcm6yQosE9IoffawFhwgUSN4PeLV2QRpYh6KoAVYQxAxuM/M2BECQNTxMWdgRUI5tE6JtoNN96B1gnO8j9Yrhe1LxtSl4yCEkVKeEyLM7No95I5Un8Qo0xFC7aCxFVNu7rdcQSIeymV++qldYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3AtrOwdQxZggcJLlZ7j9L6ETt7FVolWOavDEX/lKsQ=;
 b=FBruCIjqONs1CF68/d4Nr9KigdNBz+CTsQMN2iSvfjrqxzxLOexIcOOVNtcc29ub+riSc8DpMr3Zxe8v0O9zIML/X3DDYj2oQta5JEoPEJ2Wii5sZO0ZuO6vLAWMEnOn601Y1Pls/F9f8nbvwbKbP8/qot2Hbg/CqkQAeRTUSQXYc8BurwHgkuJrzV4xWQnln3UYsoXgnVsueGcjcj1KHN54bQq5UnTM7/00RL8JjaLmh0akuxFASA4SuzWzP9hIoq4wGBi890sDcZHkgdPW7sICpiFagERP5Kc2Fwa5gm+Q3XdyGczGqWNNdTjjRiGUY119PuOcnM7USAWWDHlcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3AtrOwdQxZggcJLlZ7j9L6ETt7FVolWOavDEX/lKsQ=;
 b=CNjCO/gza9fyrOi3CvVwg84jc5QIezBse/pKngZzHcX7TXdM14xUPTYluHKQjDTuj7CnWDX+h5RtCwfnGu9/nt/QuBShiIYUHUUAwlgxDWM5fMPWUamq7XdQXnkPT0tW7NaK/5Mes1EY2Z1jXMe6aOdxqnnb1pK8l2g2GTTKLkg=
Received: from DM3PR08CA0012.namprd08.prod.outlook.com (2603:10b6:0:52::22) by
 DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15; Tue, 19 Oct 2021 17:51:08 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::a) by DM3PR08CA0012.outlook.office365.com
 (2603:10b6:0:52::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 17:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 17:51:08 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 12:51:07 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad page
 threshold
Date: Tue, 19 Oct 2021 13:50:49 -0400
Message-ID: <20211019175050.934527-3-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019175050.934527-1-kent.russell@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25e24842-f9bf-4369-cb87-08d99329081d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4482:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44821AC481408E773D831FAE85BD9@DM6PR12MB4482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anpKX4/PYt0324nRUZod+PsT7kL16FBNZw0ezb3ACRO29sBZjQB6Y/jApxO/7dFU/4qff3HvISrAFWYqVcHxEWsvf++Iptig6qjT+H/ZGLvo56QN05qecmuF1r0zGRyOmNipUdbNVf80bFANEObeuT1PKDuT3uR1UXl9nNxO7e+3vVbtJLNOtdMtV6ikthJ/VniNY7wEyIpQphTDieXkGSFfW3Ig3FaQ7ITm7/JuXIXedoOd/kOpR+HVXS73T2euyB0k85jRTD3mdE+9V9j/LSaU+hcMQegNDaqJpx2LqsC2WV/xv9pmDAW3UWurWnfG+mGLiMNhf//SdgNWSjrLbCgn/jq9WHhNfdf/yg3ZZY1OXFH7X2gfhdFqLk25lBBeeHskPXyhPBOYS8SOfsf+macxWQbpcwh8bQ9+xYuK6TVcR/ooGAJ/HNSXGRBQVt8M1P36hfJja6mq1fiefpD6JBGILrKXpEPiSiMKopOMKcS04iol1ChZp0vpM3/24Pk6j9Oyb6vX0EePxCNA5inPdAvmgEUs2hKYTvarbptbWMcsl7EEM5zNuklkuHhiJEXrlCSBSjSXtiRIrXDAD3002GE5HSLNntZVgEDfFT6oURDKUmBsMezQVZlEQXOeViRJ5t6UuUTBhGzutk3TCq4/daV272rSnLf5UEIGpudD2pMh1Y3yVhnmVjZaphhAeqdaNWPHRvBRCWpVIA8xGNFabQdbJUGYX16D3d2VvNa3QJo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(186003)(16526019)(8936002)(336012)(4326008)(26005)(70586007)(2616005)(70206006)(5660300002)(44832011)(426003)(508600001)(316002)(2906002)(7696005)(54906003)(6916009)(36860700001)(356005)(82310400003)(81166007)(83380400001)(36756003)(86362001)(1076003)(6666004)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 17:51:08.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e24842-f9bf-4369-cb87-08d99329081d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
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

When a GPU hits the bad_page_threshold, it will not be initialized by
the amdgpu driver. This means that the table cannot be cleared, nor can
information gathering be performed (getting serial number, BDF, etc).
Add an override called ignore_bad_page_threshold that can be set to true
to still initialize the GPU, even when the bad page threshold has been
reached.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d58e37fd01f4..b85b67a88a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern bool amdgpu_ignore_bad_page_threshold;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 96bd63aeeddd..3e9a7b072888 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -189,6 +189,7 @@ struct amdgpu_mgpu_info mgpu_info = {
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
 int amdgpu_bad_page_threshold = -1;
+bool amdgpu_ignore_bad_page_threshold;
 struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
 	.period = 0x0, /* default to 0x0 (timeout disable) */
@@ -880,6 +881,18 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
+/**
+ * DOC: ignore_bad_page_threshold (bool) Bad page threshold specifies
+ * the threshold value of faulty pages detected by RAS ECC. Once the
+ * threshold is hit, the GPU will not be initialized. Use this parameter
+ * to ignore the bad page threshold so that information gathering can
+ * still be performed. This also allows for booting the GPU to clear
+ * the RAS EEPROM table.
+ */
+
+MODULE_PARM_DESC(ignore_bad_page_threshold, "Ignore bad page threshold (false = respect bad page threshold (default value)");
+module_param_named(ignore_bad_page_threshold, amdgpu_ignore_bad_page_threshold, bool, 0644);
+
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
 module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 
-- 
2.25.1

