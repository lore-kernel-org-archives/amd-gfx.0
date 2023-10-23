Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91209C25B41
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 09:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E09110E00E;
	Mon, 23 Oct 2023 09:25:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC36010E00E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 09:25:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQXRHdziwTtv0Po0SCpnacYNv/asU5dUFQ11D800M3fstbiJpjBND97RD6At+dYw0zKGB0zotVF6CX22eIxwnr4xt1SeAymsCfT8wjQVdV3L3x7SNRV3zTLf80P0Aesr3xsXgAykseAfjSBC93dFY+3DeSz2cshu6cXOmxfmFBzqfQzVGnNY2D8BGWjMriD8OQwHdn+WA/hWpDRVnWoSdBccyaN2e53/EvZry/xAf05Nnc6aEtXygKnJV3ho/KE9UBJhn/icEk38NplhVbMFgvzj75qD+7hR5jdz3fgjmw3APwXkP5T4psRBQKxL/a2qVZ941C8cyVQN5bIpRxQk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbN+VIZU7si6W3mnkaY6QNq4JGus5b8VYXe7H9tHk3w=;
 b=LxedNe2S8+Yy5+n3DIOxtar+9+dcow98pHzz2cURPLx0oBvmm+MixBXgXNVC2zQJRQK2QlYOMhlWGfgf1j6zIxouqCt5YWR4LQLr6+0eOo/noPJRP352duix3bDXGMWDpDBclttGGRKmftTcJTX/nOQpAXf8hjCyolDkfqcpliWQfSwFAQsUzNrgA6PfJYZWaSLDexJ8LSr43HqpD4SGjnUXm+E4SS1fLFLj0PlqjxHmnAXsTtV7KOCtvhQ1cquezVgq7e8pIdwZc/GXkVsbetWOUrybqyOTOWNT+NKUcz54wzx/G50dQFfwGPFYcutuJbPyPO07Sm1uVVTQr9Wh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbN+VIZU7si6W3mnkaY6QNq4JGus5b8VYXe7H9tHk3w=;
 b=Y5zm0OPCj/L61GluKCu6Jl3l+lqMuGwvx/KyGCMLxbnDLlPuDOvpjifcpDNUpXLfbqyJAtD+cd7ANCSa/1pWrUTF9nUgeOkCuMNXkvjaunoFeefCDUaQS8WzW2WFVAu6Auc67o98eMePi/JlNBtvD2xL7A66Zpu8nnBlXxmCyRA=
Received: from MN2PR20CA0009.namprd20.prod.outlook.com (2603:10b6:208:e8::22)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 09:25:08 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::6c) by MN2PR20CA0009.outlook.office365.com
 (2603:10b6:208:e8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 09:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 09:25:07 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 23 Oct
 2023 04:25:05 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vpe: correct queue stop programing
Date: Mon, 23 Oct 2023 17:24:52 +0800
Message-ID: <20231023092452.616747-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 98972a24-e98e-4e5f-a6e9-08dbd3a9f2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6WOr07OD2onfaaSGOe4eh2CtkzhHiSo/kLtMOpOkXWMko1+r5tvyo639uWFv8kNsJEyI69MXWF2HuR08sD7qINPXgLTjSSiWnV+JZManpWsz1uZJtJBJaNOl8SDDgUXiD12ZyoMdDJHkPLpLPi/j28isJ8bRw11RvwtbAnkTBG32oXCWIAdtdXIrn/BOzYajlDSyimFo32eqeqXz6XWRZsA0XTSzJX5HZp1NfoKCYrrMt4DuXwK4H4vQayv+kMDUqzecQFNDnzW82d615A0x4eIjfkcQNWWHhOqhuOn/+qyh0azGvna3xzK2tCp6ia1LileSE2R+QOqMo/q98c1Ew8nl8mMMoDdHhdJ9UtqOjY0DLA60BHKD+ipRRE6SJUN3H5uzhjloTalmyZBp/i0dmlHjAwtA0ScWYuA5T6vTlKt+t5FZtilrTHc44EZ2QFWLbn6ih4QT7bW9yPhhPC/dZr49YrVsXRyoLAElZSdIQzt3mdxhfBvEPJYFPMChhzkuxcpPtrmuSVzEh5hNK9Dx4gfrYK9YJwNTvOPhyEFQJ9x6G9dGZai4uFFqttH6YubuZrlIsDPRYN4JdJIk/9JHfvmrnTNbfntafjzdFflfDqYtqSc9a8aXwjmBXi5IqbBQqA9JZLuCbozt0qep8Oa6hZiJggy0jgSIT/vSnJMQaJ6Clo4xeQ8BRUzlXW5U2zSITo4ZGSPWu6h3r6C4He/RAZ3vh0vVuvJ/N3SBnumIk3MunjsclCvfjoGydStLYah69XFvrZ3VBuDEyS2Hmk1FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(40460700003)(6916009)(70586007)(70206006)(316002)(54906003)(86362001)(1076003)(356005)(36860700001)(81166007)(82740400003)(16526019)(83380400001)(336012)(6666004)(2616005)(26005)(426003)(7696005)(478600001)(8936002)(2906002)(41300700001)(5660300002)(4326008)(47076005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:25:07.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98972a24-e98e-4e5f-a6e9-08dbd3a9f2b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IB test would fail if not stop queue correctly.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index 756f39348dd9..174f13eff575 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -205,19 +205,21 @@ static int vpe_v6_1_ring_start(struct amdgpu_vpe *vpe)
 static int vpe_v_6_1_ring_stop(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
-	uint32_t rb_cntl, ib_cntl;
+	uint32_t queue_reset;
+	int ret;
 
-	rb_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL));
-	rb_cntl = REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_ENABLE, 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL), rb_cntl);
+	queue_reset = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE_RESET_REQ));
+	queue_reset = REG_SET_FIELD(queue_reset, VPEC_QUEUE_RESET_REQ, QUEUE0_RESET, 1);
+	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE_RESET_REQ), queue_reset);
 
-	ib_cntl = RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL));
-	ib_cntl = REG_SET_FIELD(ib_cntl, VPEC_QUEUE0_IB_CNTL, IB_ENABLE, 0);
-	WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL), ib_cntl);
+	ret = SOC15_WAIT_ON_RREG(VPE, 0, regVPEC_QUEUE_RESET_REQ, 0,
+				 VPEC_QUEUE_RESET_REQ__QUEUE0_RESET_MASK);
+	if (ret)
+		dev_err(adev->dev, "VPE queue reset failed\n");
 
 	vpe->ring.sched.ready = false;
 
-	return 0;
+	return ret;
 }
 
 static int vpe_v6_1_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.25.1

