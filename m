Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79647C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CA88DB58;
	Fri, 22 Jul 2022 20:42:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B158D759
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdTIq8l2XNr/P2LioqQGY9aPP/5psxDR0cFzYxSGc/2sqDdxxjnOnSJxV2U+0p2XNATxl4YBLjvaeRHubGmVgVFqNIJNBwW+LYc3WKbtIPrIVCviqEw6sTR3dOeBtm//GWbbO8PPxgJDxHDL11i82cXM3mbHeWqK99UyxwUhgCOEetd29QG3Y0McsfJzbvrAYY8eAisjAghVmetn1sKBXX/CMFo92XD/8WUF1PTpZfDNoeLcyIpirO8gPfmL7X4N6Pj3dujtkzdq7qlwzX1fDdogtqNW8PuCpMSyfREMTCFTML7xLOvxGrHLQRkDPZaNAY6xd0YK3zcYDr6znkDoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cCLtg1Ji18wWrekvgei/L3iopSUBXSgBDra2X7Lr48=;
 b=XjrchRkZEnrMGJC/zC3VsXxzckkYAXTAlB7oL1k7NNmaCZ+Wk2C9uePygWioMo6OdmPfuBiSAJDaxiTslJZjuP4CCjcxL8+ay4cA7j92Vu2GW4/DN+wOfH9KyGF8D9aie3zuM75ESw6qnCS0rwGrS2hVxkcBPWxM7QQaznZ0ZhJMRG3jo7ZK6tjAI+4Yb/pQvYdqIKp6Cm9bh6Ymjnw4qQEaIpKQHywwZz3nTz8nib5pKFkPp7K11L5gr0ySbaZ2ZtweOEzKdhMjVBR2/0esveUoEXAJxRrf53K2laaKYEn1vYhKCqH0F8wQvsi2JmV8mPyg4vxHEaxK0sAd1XkMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cCLtg1Ji18wWrekvgei/L3iopSUBXSgBDra2X7Lr48=;
 b=N/N7RTfkCVAjsEB79jADiLM4qfc5D5zW6cbP8niqNLs4O6H3EQ+Uw6+mz1cZLj/C1OBi/W2367dfi/DlRrwxAHP/eixEakmydmiOyiqlgOxI6VQgT//kXgDsg18my3iZz47RA3+nb47HTTCPhiuUJPl2d6U4EvDZ1USXh/DZMzU=
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 20:42:26 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::b) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Fri, 22 Jul 2022 20:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:42:26 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:41:53 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/31] drm/amd/display: Add missing AUDIO_DTO_SEL reg field
Date: Fri, 22 Jul 2022 14:31:26 -0600
Message-ID: <20220722203137.4043516-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc253ce-f874-4630-7cc1-08da6c22afdf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3964:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUFT2zw1ppi8q5Ni1Y2Pa27TIIAYrhJJEImmZds2SsPKSY2jYjRIVlq1JHIR/LN48rZJnCtDb1lNOSfkxEitIXKLOJok9Fa2bWv97r7hHqOkjIhcekeXLkGLHH57QZFz5FDi3CExIXguMtuDVY77jsnt5uG015APaaPm6lT2EiWINiKf+uJ50/LRlKSe1nQh6xMbpnJnqrVcIjBcBB9fLRN3UejgfzNZeJTEKRSAqaqtfwus5yTClQ4CrfFv/7buTHwUD+rV/xppOfaQ2kAZ26ctTfmuUigS1zaUEHjQoMJsRQ7wpHoT8deB4LK65XivuELhtUwX1PvmmUhqcfXXKptCPOoKaP8hoJArpaYmVWViI0D3KU+8tZmx7weZCsXPjzwWYosyb3C1RBh3c5+ecqRsf6PbHH5j40Zaq7Ayop4ZV4K8fbnWuv22nnXs/1k0QTIyzrK9ct238VYSk5xmYtc7ZspxVCCy/oQVkoE5fm5DMxnNRWaqEbFyoutltCkHAYpkFLB4T6DUHQsNgD1fvAunSLuOGoksAjzfdJU8CWCaEw5jXSPlFVDsGbOl1qEgPd72wyfh9g0GG69kLJf+0GeQ4NQTaUmy78N0JgGjZ2WYkoFCVVWoqByWN4q9PPJyhN36H0AobYv3ReOFzDxU0H/VNHzlk6Pvgeh2meCRQhB6aIgc6wgHEuVdmZkVP5RX1ZecEp6nAy1izyyJyQCaQWiZZjm5JBe7e9p3XxPb696F5nPpHNA/Z/+nvbQA6gmfS+NTzwTm0gL4kym8j8N3Ct7nRWTk7HXwJNQoU9piyMSVLyDHJbbvHOllffkn2Mz/x3fyne6ppgoOBTFw702WMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(40470700004)(36840700001)(46966006)(26005)(86362001)(2906002)(41300700001)(44832011)(40480700001)(83380400001)(4326008)(70206006)(36756003)(7696005)(5660300002)(426003)(6916009)(54906003)(316002)(6666004)(40460700003)(8936002)(36860700001)(47076005)(16526019)(81166007)(8676002)(356005)(478600001)(2616005)(186003)(82740400003)(70586007)(1076003)(336012)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:42:26.0599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc253ce-f874-4630-7cc1-08da6c22afdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Needed to program audio dto

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
index 99ba597bf9b7..9a4a9efc0203 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.h
@@ -147,7 +147,8 @@
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P2_EN, mask_sh),\
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_SRC_SEL, mask_sh),\
 	DCCG_SF(DTBCLK_P_CNTL, DTBCLK_P3_EN, mask_sh),\
-	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh)
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO0_SOURCE_SEL, mask_sh),\
+	DCCG_SF(DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, mask_sh)
 
 struct dccg *dccg314_create(
 	struct dc_context *ctx,
-- 
2.37.1

