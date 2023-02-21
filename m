Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEFBC677F1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 07:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D7510E0D4;
	Tue, 21 Feb 2023 07:51:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10E1810E0D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 07:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBidFG3ghKO++HUVX0nllZIox9ghsr82+cJaJBfZ69rR7T+n9ykbllu3VQhBsnPxqcED0+AOGDkO2SC7qPuXWadObQsg4svdFm4CYNFLcdmqCZ4gMPScrMhQaZd2sUcAkCbQ5ejAAkC+ZIyc9sq0fvGzd3jPGxVSPVsNw0j7zJvoEn1q3AjIu/lM47eV1LjZqGjT0cJopQiJfMyuQhWbcsLBiC3AWHzxq3g3SQDJGwgtKdLsqgyUJGxwiCWdbuoIZ5kuOIGOUzOJhiFTVF763KvqW8A8VtmZxzKScn5vvNgZ47PTtsAYShfGckDv2v65+K1lJO57AN4zr4FMeDm6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7KE2p1B5JQJ44MKvLVDvAIBdLoJ3JmeUi/2MKW7i/U=;
 b=KjxA2irJf668wIs2azQmi1J4+kS1vIpUtzoSdP/bF13Cx3U1c39ejdni+lfOkHUSckAM3HwGsIKsym/QYHR0m+XXY9tNhpXFgyJitneNAnSV0fnDZ977e3cS6YmpKhuUxhIbtgdOXEZd72YmgLswSXZJEJaNNT+C3e8CmVkzxxyD8m+FlOxnHEz4sPET1xq3yXkXRxAV9Dv9xMqc4hJnwBXY5s/Ko1fyFjCMrpMnP3d8AT0eqFq0rA9hWTjM0MQrb9KbIRmJeDf25KJ2DCSu5fHDmm7H057qvc+/X5+XCnWJmzr3BUS9YGaH7nT/cymxqMEayTkERd43O8nA2wgQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7KE2p1B5JQJ44MKvLVDvAIBdLoJ3JmeUi/2MKW7i/U=;
 b=uXXB2iEHNrYkWIOHblMkh/YU9qlKpTIViDCUTsue569YVTEqhNiY3/Y8qjEY8+04Y72UiG/w9iJi5EvwY+wKckU2UaY24PCVWwlJ8+icRtVXb+i3lj2NASZBKRvoQiZr1AiuxaxEPPiJ56abozL2eFvT9+tN7qNvb9peeGOnKhs=
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 07:51:44 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::24) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 07:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.20 via Frontend Transport; Tue, 21 Feb 2023 07:51:43 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 01:51:42 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: correct the baco state setting for ArmD3
 scenario
Date: Tue, 21 Feb 2023 15:51:22 +0800
Message-ID: <20230221075123.1831895-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: bfeeb7d7-21f3-4d19-5ddc-08db13e079c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRgLmdj6XExWQHQZZ8xS4PNbU00gWcHixT8wfrOiouT3zKvAP49auy9ecODLoc8hLM2CTKA1dxluJtuoCIt3hBWaiOIcHqJsWcSdqpPzBgf1W8WljGT4RZZmauqGJHMbuuIRVIG5k6jEp8gniZ+lDKC6VI8LO2GKSqf6tKej8oiluKK1kvkQ2GMLVSGisjQqa09yThQqMi5LARte8IB+a51w/ZUEgZLgpAtYvncyZYvw7YE+PGfOKLLnznKx2neQOInMR0J+DCwz+T2O71fNFnWvgOzeNgdEzWaqI1HacamJccGzuqJFJaW7PHKaRYkzdfNCjg+mUtbonK5cG5DWwWOcxMKf1i2iiolM7ahdHY1Zxl4lDJTsC619z08yLVLqpqi1BJ2MZrrWu5Z3qjdn/Crb5Q9gpjNZgGHZck/uMf3or9TqvD2maQHX+RDv48cpw0jFyukvolW8KFcbdtP6nLzZTntYfH7noKNq4epVRq1PO/NDRlX8n5X3q7uHN8u+ItL/hDDpeBPOlY1gN/3WTXeQzXQwGz/DrIAotzpA6xaR5OdffIQJK6ZH3IYrcNnDBUgBmEo26dUI2gGGTvv2EebRDnTrVzQgqDOXNwsRaooXbBzXN8jl2YuOiPjKTRWMxZTLO5YnoMHHEu/b4dUZZrRMegAc4vGE6vwFd0dz9aRFapf1pIo84p43baSJoRQO0+552atGG6W8GeVJpT3H7vibHu+ogP8+OiEz2HA7QWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(5660300002)(44832011)(86362001)(82740400003)(82310400005)(2906002)(36860700001)(81166007)(40460700003)(356005)(336012)(7696005)(16526019)(47076005)(478600001)(426003)(26005)(40480700001)(186003)(36756003)(2616005)(316002)(54906003)(70586007)(70206006)(6916009)(1076003)(41300700001)(6666004)(4326008)(83380400001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 07:51:43.8906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeeb7d7-21f3-4d19-5ddc-08db13e079c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The check for baco support relies on the correct baco state.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9dd15958c213eb83abdb8b7d858eff0d2d364b4e
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index f4927ada5c07..1984b01514bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2217,10 +2217,23 @@ int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
 int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_ArmD3,
-					       baco_seq,
-					       NULL);
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					      SMU_MSG_ArmD3,
+					      baco_seq,
+					      NULL);
+	if (ret)
+		return ret;
+
+	if ((baco_seq == BACO_SEQ_BAMACO) ||
+	    (baco_seq == BACO_SEQ_BACO))
+		smu_baco->state = SMU_BACO_STATE_ENTER;
+	else
+		smu_baco->state = SMU_BACO_STATE_EXIT;
+
+	return 0;
 }
 
 bool smu_v13_0_baco_is_support(struct smu_context *smu)
-- 
2.34.1

