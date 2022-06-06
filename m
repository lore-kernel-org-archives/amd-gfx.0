Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71F6C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 03:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B45910F228;
	Mon,  6 Jun 2022 03:12:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B84FA10F4A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 03:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J83jfdeaaEs9DNqlHnGl646AEhYoSqnmodBInVjYU5jnHB/Ft2e/GGKsTpABGqO4nz7SaVaVBrHnD6rmY8go/Ct3E31YzTkJ27dhlJfTcUMUTOSPS0ra9Oo/HuqKpLRMPMunDwq1mAyzjX8PJOgPvfH31lG0V+OkRH/VProJEGhEJ6roLqo6LUZ/iVXr5+iXoYTByakSW1GHG93nnEzLBE01gc8tXjPFiPH46Q0pngmI+TJDETr6mRjGwQfiCkfwg4EU1K5FLMKKi0me6uGA7JlZRTqJRIUlDuJiePXPHJMmBpnmwoYLbTvL3Aq/4vkkeq4nz79e4LtMlAu4Om94zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3Y/VITmRwmweZrxI3ifb1ddJGOCWpBhFDg1GKOFJ7M=;
 b=j0lSuwIrs97tfJAgWa0Wq6NHFSA2rNsGltVNfYuXOg8GEPxzmfW3V8A5rZyjiA251p+PDgdNABVaJzFbXrrY2alyc22EDNEHh7uTlMcnVAtDxMQQnlpNArtYmtVZSbuzXQtjpEGIp8FDFP1btta53t3Bmh/pmEK3zVTwW2y21P7BPzIAs2WlhSRIa1tMP/TME1UGw5snYWvY0wqMXUA/yvIf+70uBeqbwflHBK23HNVCNuz9U16cYPX9TRHagW8L484ObyTxlTbgPb/jN8nJj32DDDlFZDWDR4kAIMpJDPc42tgznyUIZdnUFL9fUM8VOcdq0bghZw6kPuhNK5AiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3Y/VITmRwmweZrxI3ifb1ddJGOCWpBhFDg1GKOFJ7M=;
 b=MCTr5+tG65DS4Ky/nbve+hRnhm3z4mtucKpIyCRvVezTcCBV2DHT2kSxf3rsRTJHie14DgBE3RUqvctz5g/zVP7U6A8D5S0qMW+CBCFQT6VxjkdlUk0XXP9m2Gv9OOg8nj2MgowgYNjM8dAmMb6gfUwzDM/cE0Cgw62S6BGyrAc=
Received: from MW4PR04CA0055.namprd04.prod.outlook.com (2603:10b6:303:6a::30)
 by CH2PR12MB5546.namprd12.prod.outlook.com (2603:10b6:610:63::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 03:12:34 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::88) by MW4PR04CA0055.outlook.office365.com
 (2603:10b6:303:6a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Mon, 6 Jun 2022 03:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 03:12:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 5 Jun
 2022 22:11:57 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/6] drm/amd/pm: fix compile warnings about redefined
 MAX_PCIE_CONF
Date: Mon, 6 Jun 2022 11:11:23 +0800
Message-ID: <20220606031124.1818265-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220606031124.1818265-1-evan.quan@amd.com>
References: <20220606031124.1818265-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fcb9dae-865e-4aae-e962-08da476a668d
X-MS-TrafficTypeDiagnostic: CH2PR12MB5546:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB554624F40270BF19225E9E4FE4A29@CH2PR12MB5546.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TA80vAnoa14C4+NQPMpeN3VUXMdINYCj4Nvuknzh2k4/HD2tg540+c6RDPjVy8iywRyN2ZqcpP+GG34gXdk9tN4yEI27UCtoYOIX/Ryc+QbBorbd+7ReqbdkyY0lhzmhsJ+ar4HOoaBKmcv9IjzMi3rHJ6TQ/1R4Z7CUA4t78L63/7fSzs7osB6xHzfnDeqDbmJzhXmNQWtQXyzZ36SV4jJAuoZAihdC29Z9KJIsOpgeU8RezlB+Zd6L/8V6sIZoBcNfYd9aFE5CZGvhnK/NGOPXWGXyZNt6btkLpz8TTsx8NoLE83LfwD0WAAdFGvZdrXrky2ZGaodcTYngO3nLTgKb91p803LmCbt7mRWpmPm1/xhuPkj2JsyoRYfcNxuF/3SMywJBA24shcnYPsEG/y9M8GcMRoC38uc9U2ZDWrqxugAe1REIdGdXxiCytvVJBoAuzjt88lau52Y1wOwTk2x/eDtODYDPaBBHzoe5v91gxYDp73V2FcQT3S8DsW5U4mJT5TsHk02tmGY8sOlD++WfyXgTqYfW05bSz6QaJKzIv++6HpsIBkV/0w4Hs7NzcXpYLAuolz2SCaGryEq3hkVR24Du2X0pwszroERoTG5nfobPrpDqxK4+6ldlWNMW4HCoHDDPFqeoTgl0UtCCpfW/Wdf+S2IEikVtx5oZI30Q9bJ18yr+ttUAIQTRztrDg6iHzt531xj1w5QCTMc3/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(70586007)(6666004)(4326008)(70206006)(8936002)(8676002)(7696005)(81166007)(83380400001)(26005)(36860700001)(40460700003)(508600001)(54906003)(6916009)(5660300002)(336012)(47076005)(426003)(82310400005)(316002)(44832011)(16526019)(186003)(1076003)(2906002)(356005)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 03:12:33.7153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcb9dae-865e-4aae-e962-08da476a668d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5546
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suppress the compile warnings below:
In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c:37:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.h:31: warning: "MAX_PCIE_CONF" redefined
   31 | #define MAX_PCIE_CONF 2
      |
In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c:33:
drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h:55: note: this is the location of the previous definition
   55 | #define MAX_PCIE_CONF 3

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iacc4ff4007b74d5db54c1e66cb237e55b70975b0
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.h
index 33a85d57cf15..31e991bde3e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.h
@@ -28,7 +28,7 @@
 #define ALDEBARAN_UMD_PSTATE_MCLK_LEVEL           0x2
 
 #define MAX_DPM_NUMBER 16
-#define MAX_PCIE_CONF 2
+#define ALDEBARAN_MAX_PCIE_CONF 2
 
 struct aldebaran_dpm_level {
 	bool            enabled;
@@ -51,9 +51,9 @@ struct aldebaran_single_dpm_table {
 
 struct aldebaran_pcie_table {
 	uint16_t count;
-	uint8_t  pcie_gen[MAX_PCIE_CONF];
-	uint8_t  pcie_lane[MAX_PCIE_CONF];
-	uint32_t lclk[MAX_PCIE_CONF];
+	uint8_t  pcie_gen[ALDEBARAN_MAX_PCIE_CONF];
+	uint8_t  pcie_lane[ALDEBARAN_MAX_PCIE_CONF];
+	uint32_t lclk[ALDEBARAN_MAX_PCIE_CONF];
 };
 
 struct aldebaran_dpm_table {
-- 
2.29.0

