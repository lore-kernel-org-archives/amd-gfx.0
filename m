Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC4CC001B0
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 10:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A8410E012;
	Sat, 12 Aug 2023 10:34:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0679510E012
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 10:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfFFnQUTbi9Ix2Ue3ssjtWX0wod+KU2Qg0VbAyaIS9hEqvM6EXDGCZgCioiw3ZJHGafyeisIE9GQO4dcBZuQkZXtNt9AhCaEMwwBZqPwPvNbyp9jqTLYucs7deM6AiXkz2VqO+2bvpodKJXfJFT9AVmsHJa8oixTfmzIxi22eC6xagK/6nC/NSqI3g/XkXuzGyB0+Q8MBFQ0k4pzmDzencCcLsnljiyFxH1uH9BPG+YCPww+UbMwe/4o2rZaRYl0KZII4eCv2MfweE48OZnIwekaZsKQXAC4/Twl3gmxOaqqAcW/KBLWJW3UqEd5oEL6AuQRK/0GGUrZXcP0Hk9t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmqCijQfvF5/g5tSTnZlIeKKYkG0Qv7L8FyZdX6XsOU=;
 b=V5Yo0ff9b3LdMVtnLSWo9XBNzANiMqN4jAecOB8Myn8tQekPqC+mDNew9mghTtIS6sqSoQKHN0LGeRUmGjdfpOUqMgT6X6um0HpAjf8CPI8IsI89lNp4iFCymT6uX4qNsXZpyRhL4JSvp/tfqyXnSyLWe+/y41+3IsHkckfsqbkIF/YpFtdwRIj/yKOxYmI86YADqUVCDONNkkr5Awmvbx51THJ5/830QWPFGorl6+p2yD0vpLwi9YjmO6iJ1SHvGdyOliccjHJPw1nClqy8T4GwFSsJtn24TCbh8hIBaw8UiupJRB8Ft0WJ5k/e4SdJ3kdtx9VmbAbg1NeTpcyFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmqCijQfvF5/g5tSTnZlIeKKYkG0Qv7L8FyZdX6XsOU=;
 b=cBjJajJHMwbQUUEgXHV/C+fg4NOj0lPl+ewKV7smoxcQXHt+rsOCys6+vwZ+4Qh6SmD1kqsUhjLYMZ2wzPXahExbQRWlWRrFPNfZ/T7DflKxIspJJ6qnPq9/eFNPyJbjNmGJn7cXcPHNAIANdll/zgFhobIChhttwKQ1SKFvgTU=
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Sat, 12 Aug
 2023 10:33:59 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::c1) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Sat, 12 Aug 2023 10:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Sat, 12 Aug 2023 10:33:59 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 12 Aug
 2023 05:33:56 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/pm: Update pci link width format & correct
 address for pcie registers
Date: Sat, 12 Aug 2023 18:33:41 +0800
Message-ID: <20230812103342.1091608-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a732dc-0f37-4f4a-76cb-08db9b1fa3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzFs9s4vvABPAUpXctUYOj8jqoSGRPfO5ZPH4Sd2zeA1avt7W0LhYmj3CuPsgkaseQVWUA4OUphZ5wWzCLneT5dLIp10+Bsl9xWqQtH7sPMDfjy6xS/+Q5Inl3t6QQLaQnw75ELz+Dyx9DgRthfr1sqftPr0oE0PMBDPab3OM6r/YPq1J/zz4dqJ36R4fOnmXpHxRvOGuVx/eKnWHqLb0ONnEi0wxVaFId1+5mCnOBr0wMNO5t7c+KWQbDVNHwp+Qa9n2p17LDTqssYdoa7CPNJ3hSRaR5LB9DcXiTVyUILD53iRRYnOAe7sY+8h0ZYEw2+KdFgq5ROlf1XPquriX+9ItxvU37YxEBd84svWBCqMSlvBUKXlzoUd2+niymTmyy0aS/r8lfTSMK16oH9aGlFizjA8MrA2jT7IQZbKx/jsDaCHKmt3OI8DtcbWCYRxdZvVunj/QrXRBBmaJHA6dpq1WRaRCfpIxvUByj2LgRUJYCmcOgIck4cpFlMT2488ORX5XYm0i9nKkeTpDPdCeursnme8zBZdnJdJTMSslhqvV4qZxYVwZ4CaiicUJtseTYtHASwU2SpPYpojkm7rymErpdAT+fe70Ly3umps7DM0qpfsJko3T+m75JJ66puobfw5psG07IJUDlWECIRLsju9H9UE4a2tWDFACMWLoI6g3kb13n3wvpoSONrHpQkprjA+Qn1m9KC3mH7c3ivrIkzHFWcmsnx1ifjJjeOScTIBjsIdo5TBjLZZgzU1Pzivbfi8KYoz3V2ae4WsoPV3Vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(186006)(82310400008)(1800799006)(36840700001)(46966006)(40470700004)(40460700003)(6666004)(478600001)(70206006)(70586007)(7696005)(83380400001)(47076005)(36860700001)(36756003)(86362001)(16526019)(2906002)(15650500001)(40480700001)(426003)(336012)(1076003)(26005)(2616005)(82740400003)(81166007)(356005)(4326008)(6916009)(8936002)(8676002)(54906003)(316002)(5660300002)(41300700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 10:33:59.5993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a732dc-0f37-4f4a-76cb-08db9b1fa3d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
Cc: Lijo.Lazar@amd.com, asad.kamal@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 maisam.arif@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1)Update addresses of PCIE link width registers
for smu v13.0.6

2)Update PCIE link width format used to populate gpu metrics table
for smu v13.0.6

v2:
Removed ESM register update

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 244e6d31560d..2572dc210739 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -81,9 +81,10 @@
 #define EPSILON 1
 
 #define smnPCIE_ESM_CTRL 0x193D0
-#define smnPCIE_LC_LINK_WIDTH_CNTL 0x1ab40288
+#define smnPCIE_LC_LINK_WIDTH_CNTL 0x1a340288
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
+#define MAX_LINK_WIDTH 6
 
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
@@ -1940,6 +1941,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, inst0, xcc0;
 	MetricsTable_t *metrics;
+	u16 link_width_level;
 
 	inst0 = adev->sdma.instance[0].aid_id;
 	xcc0 = GET_INST(GC, 0);
@@ -1990,8 +1992,12 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->throttle_status = 0;
 
 	if (!(adev->flags & AMD_IS_APU)) {
+		link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
+		if (link_width_level > MAX_LINK_WIDTH)
+			link_width_level = 0;
+
 		gpu_metrics->pcie_link_width =
-			smu_v13_0_6_get_current_pcie_link_width_level(smu);
+			DECODE_LANE_WIDTH(link_width_level);
 		gpu_metrics->pcie_link_speed =
 			smu_v13_0_6_get_current_pcie_link_speed(smu);
 	}
-- 
2.34.1

