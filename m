Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3EFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 15:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2093B10ED34;
	Thu, 17 Feb 2022 15:24:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4633E10ED34
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 15:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtS21w6qn9urQqvNYxJuyR0TMkH0CSUBV6Ncz8nan3J5RReCG/bwrKiA8XnQ/PVOJXPSzm90E20bYaEqL+g8JpAB60MPL/C3Qz0vS6TJHgGE4hmIEsTv1+4HbbVLP57TdFbWtnJIdTPJ7w5+YavlCVFYItc4GeE6DhffG7SeoL9lZ1hwj0QK+ykILcmdjhctjuxUBbYXSVIQaPzqCHi7SDhDnDh+Ylz+mFuwLmPy3lNRs6f2YZvkfC7IclIjPmRa2oTaBV9W2wCk8VP15IGDIAdHdgt/kreZGgte4jEgQV8mCzn0EiTvhdaCmFfrnViNz6AhiyPic/2BzVdFxfKPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBExIXuc5YFP1bWVbQN1QgawG0qwT7tKwM7SjUrzsok=;
 b=Z9r3uI58PtQXK7ryB0iN1Q+/UG1vGU7ojLxXLnR6pB2gU4LujdX4cwF7krXcPJ3dfx6RdG3anw9WRKZUzeR/mnelaNLG+F/KM5grfVfhTh3hsfLMEM0f0u8ugHkh+nmRBJZfVCHYw1Gr1DD5VNJlMxTKl0R/CKMKOjiSMHsaRc1DFPHJXWssor1FAVM4KOSEg4uwWQGCkcsaHlbMDrJeWYl9iAc11tPMmxG5u5jdRyR00K1AcAYnpGDJHXmje1svr2O6BIMdTCMdT9Ebmdpme890WqwHHZIiOrdzRrg0hDw0vQbqm4PgevNvMHU1t9O5HMOh7ud30ZoMjIvzpxIYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBExIXuc5YFP1bWVbQN1QgawG0qwT7tKwM7SjUrzsok=;
 b=AUbINTulpUloFahemKbvaKP9ItGSVjvrL+FBfNEfsjVlxl9v0O9e9HkFgElHnovmlQUd+gsixbhFw70G0bcNAues7PTUfj8PHsTdtNmPZ3hpr57FDSUhfefd7ORs9BpvFKNjeQ6y06J21CnMO9qZO+G5rD7WGzuhVHK9MfvjY8c=
Received: from BN9PR03CA0309.namprd03.prod.outlook.com (2603:10b6:408:112::14)
 by MWHPR1201MB2477.namprd12.prod.outlook.com (2603:10b6:300:e6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 15:24:33 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::2a) by BN9PR03CA0309.outlook.office365.com
 (2603:10b6:408:112::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 15:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 15:24:33 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 09:24:31 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] Revert "drm/amd/display: extend dcn201 support"
Date: Thu, 17 Feb 2022 10:24:12 -0500
Message-ID: <20220217152412.825286-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217152412.825286-1-jdhillon@amd.com>
References: <20220217152412.825286-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 866c53d8-aa85-4a8c-43f1-08d9f22999be
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2477:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB247778BF7B57DE13A76F90AAFB369@MWHPR1201MB2477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:24;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYeecxRIOvenXAswTUVHbxeRBdRS+RXmY+iZSTnMqjAXtSJmcOtQwIF8ItbXkOfl53MbDdfZu60EmofRfFhP/7uENbBArdgqhxMBtdW5UMvTz49hloY1UTA81KwWj5Qfx09OjE5cQ1cM9Tl+wwJZbEFvt/dVYRK1hm8xkkjpNYflyvQ5gOTp9Ub4hXUpWPv/qJU1W/Oi+jvDDxL0MfXxfbFX7nj77W+dq963XrbOBVSDnNFwO6uS9JXzcYYrBz2PKUXCmXLxFojEEGNDsNW8qqJ41cFE19brJuAxu5WBhUI30yKToY5UoSNIWOJtx2aL36JDTKD8yAXdCqJo7NFl5k1MmBOJWxKjIovA0dRaiA2zmYvx4FgndazZJA7lK5LfSY/uGxGeKYOTDDYaI7lcLT+7XyC5GKB2Ny8fZi0aBvwokreTvjrsL6i0aq5s8XHnen2QfFwZkuU74izn0EErR59mYWKe8WoufO0hqW39ByEPZHAwlAmypHjUqrTj/TXLeEgBW1pBeVMDeZa89YIrhi1QyDnU2EogHWektwCZwT7aDwx+/G31mJuDCQEFlIJvQI6+VCraofIpCOMq30EqgHiIc/f98zs6ytaGe1B05Kwrb/fyzcNA3swvM41Gm9u5ENmtwAOyxgJfxG92jLu69BrixTMoS4X+SNCYZcvY/BmRMc4oHUnKZo/p5p+thoWej27x5avNrm3sC8/3KvdvYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(26005)(82310400004)(16526019)(2906002)(356005)(6916009)(5660300002)(81166007)(2616005)(47076005)(336012)(36860700001)(426003)(36756003)(83380400001)(70206006)(6666004)(316002)(70586007)(8676002)(4326008)(8936002)(1076003)(40460700003)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 15:24:33.5818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866c53d8-aa85-4a8c-43f1-08d9f22999be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit e4a10691948030fc92b11b563cf62144d8d7cb8b.

Signed-off-by: Jasdeep Dhillon <jdhillon@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a2a25d444574..0d0df7271732 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 
 	case FAMILY_NV:
 		dc_version = DCN_VERSION_2_0;
-		if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_1400) {
+		if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_143F) {
 			dc_version = DCN_VERSION_2_01;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index a8dcd6d439c6..e672be6327cb 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -212,7 +212,7 @@ enum {
 #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
 #endif
 #define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
-#define DEVICE_ID_NV_1400 0x1400
+#define DEVICE_ID_NV_143F 0x143F
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
 #define VANGOGH_A0 0x01
-- 
2.25.1

