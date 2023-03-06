Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F558C678DB
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 02:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB75010E076;
	Mon,  6 Mar 2023 02:33:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9183210E076
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 02:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EljVSSYGbq/mOMXGfRAODLSHFgzCttPt3dCjb4ScpWigJpKxydyzWtfPzP0j5b1xfooPD2Yj8NtAOFTufONtFb+xkqhpQ0u/P7tKUp7dFLfETMWKT9PKYTYjmudNfY8dR7ipLEmB9Y/3tBbPIKaefVIiWR5UpvKs4v8vHCoNAi2iSE7LM3gtX3WtrcFoCPiSNkhY21ZAS+AyquAgI/3twwxWeTU03DzhMF2tJvM+27kUbmY8ByNL55V758Vd/W5g6DXNx83udluPtVueRc9qAmKIZZ2D+xBQWUs5K74a2v4lJw/lf6A04iTMwGFzTq0zItXQpwpsswXgFcs1vT7bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+/AoiGr3JeTZqymNWckenhMMTYD3aQidRjiL3AHLpk=;
 b=RWPCXqmZrYn5C0uIVknZLDIiDviJk8tQQlYC2KQ/V8WqwZV5W/Fdb/qdl64RaM8XIUJ1s1HvvfSMqOcv53WDoRWexszoesLTp83MbxwmKBKo5QgDdIkTz24T8k206AMv25LmKQ8SMi6vNiOB7Bz7CKD3Ni8WuFs3UE8fhWjAFHP+hYwfg6EWMgYrk2ijFlxs7O8QQ3N+vSM1bWPo7Qa03CvPBXP2kp68kwNoRa+cB6JdLtNgooxzg689XlI0Ier3J7i1ZyWWzVB310xmaUxvnVOKA8drP4hiSj2/yXut5Q6sALFf3DJxChCvqoZjlHT1jSgWVfxe65Ci17wRxk5XCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+/AoiGr3JeTZqymNWckenhMMTYD3aQidRjiL3AHLpk=;
 b=YsAKtmCUsf0lRGXp/ITZmDdhJq2cHR1Hd5CYwFN66DF2FCkyFZjdhHFVyI0oJHR1x5+hpzn7qXlP/da6i98UyxW3383BUYp+TnHgl9QhqiqU982i7EklxU7WzvjRaKyy9SDSk4LR4zPlXbzvYbPVwFx+U0nzM6FP4jdQP6BnRys=
Received: from BN9PR03CA0434.namprd03.prod.outlook.com (2603:10b6:408:113::19)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 02:33:20 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::bd) by BN9PR03CA0434.outlook.office365.com
 (2603:10b6:408:113::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 02:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 02:33:20 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 20:33:17 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Candice Li <Candice.Li@amd.com>, Thomas Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 10/11] drm/amdgpu: Rework pcie_bif ras sw_init
Date: Mon, 6 Mar 2023 10:31:59 +0800
Message-ID: <20230306023200.29158-11-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306023200.29158-1-Hawking.Zhang@amd.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 2684a718-27bd-43b1-a58e-08db1deb2664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQmqvde8X9ojYBzvF4IwJSptF1jbgbuYmbsUOxnS6bjhBGJ0A4sUTIeuCHBFElB9kVpdwoGx1kDjBcCWXPa9LxSK75sxmxQ4GNl9hYwX9mxk6ibFBCknVTcjGlwE7247aCPnjaWgmwIvZpss/Au7VP4cknYcs4cE/4UIj9tnVHGjH+d7DXcBDnorOcYRFg4Nxcg0HJMf+HaqNzl3ckc9xhCM674dW5HXSBdMxQOu33zPFuhK3SEw51S9QTCojOwQ0CqnkV1d70VK+Ot/voN0TmqdrhCowS0YiPinTEeS+R5Zwacan5GTmQF4yv868lGRaEbdIUVGt59QydvyPWeMtT9SGZ/12xzBoYwWLDYLMgsmvybRRmFjao2lXDErKmShwuSCOnLR+l9F+I3ZLZWvbhiGsMX2+4U6AubmguwbHxy4/sRS6X0Tf+KiVjeThYMRdgV/OBjs0YwVDjHvrSNW4H7F8uk7JVs81bg06dyORsqA9QsaIC1TLcjlJsdbPmamR00w0O6pe5fU7xDfs4FSB2VnqNimR2A4UNbM8zWm0CKAtLlkv5k189PP9ALAOH+1I7Ir2aN3CXcrtK45iCuxLQA57GOqPBFNSPcW2R1ZH4xzV3QlLTs7d4UFn4J0LZ7Lj7tgRleOGm5EVC7ysxQTPHijdyb9yB+Bw6olLY1QJaXKyDESQCbMGCCJdKc4DZdJh2YOC7rJZ0vp47JmoxR2XN7TZMb+vKEWrsvBB4QmeOU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(1076003)(6666004)(36756003)(36860700001)(47076005)(426003)(82310400005)(83380400001)(356005)(40460700003)(86362001)(40480700001)(81166007)(82740400003)(336012)(16526019)(186003)(26005)(2616005)(41300700001)(70206006)(70586007)(8676002)(4326008)(2906002)(8936002)(5660300002)(7696005)(316002)(6636002)(110136005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 02:33:20.1394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2684a718-27bd-43b1-a58e-08db1deb2664
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pcie_bif ras blocks needs to be initialized as early
as possible to handle fatal error detected in hw_init
phase. also align the pcie_bif ras sw_init with other
ras blocks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 16 ++++++++++++----
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 37d779b8e4a6..a3bc00577a7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -22,6 +22,29 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
+int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err;
+	struct amdgpu_nbio_ras *ras;
+
+	if (!adev->nbio.ras)
+		return 0;
+
+	ras = adev->nbio.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register pcie_bif ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "pcie_bif");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__PCIE_BIF;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->nbio.ras_if = &ras->ras_block.ras_comm;
+
+	return 0;
+}
+
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index a240336bbc6b..c686ff4bcc39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -106,5 +106,6 @@ struct amdgpu_nbio {
 	struct amdgpu_nbio_ras  *ras;
 };
 
+int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 63dfcc98152d..f42480b8a8d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2558,17 +2558,25 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 	case CHIP_ARCTURUS:
 	case CHIP_ALDEBARAN:
-		if (!adev->gmc.xgmi.connected_to_cpu) {
+		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->nbio.ras = &nbio_v7_4_ras;
-			amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
-			adev->nbio.ras_if = &adev->nbio.ras->ras_block.ras_comm;
-		}
 		break;
 	default:
 		/* nbio ras is not available */
 		break;
 	}
 
+	/* nbio ras block needs to be enabled ahead of other ras blocks
+	 * to handle fatal error */
+	if (!adev->gmc.xgmi.connected_to_cpu &&
+	    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF)) {
+		r = amdgpu_nbio_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize pcie_bif ras block!\n");
+			return r;
+		}
+	}
+
 	if (adev->nbio.ras &&
 	    adev->nbio.ras->init_ras_controller_interrupt) {
 		r = adev->nbio.ras->init_ras_controller_interrupt(adev);
-- 
2.17.1

