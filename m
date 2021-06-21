Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B791EC48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC146109E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC146109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3667689C9A;
	Mon, 21 Jun 2021 07:01:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B15589C9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7pCQLzISBT+zHJdAhMDIiPS93e2tP672yFWD184I1lz3gHDbBXvfJgLXB3N04RbFE2EfWbpyGntSGHZdr9celDUMgZjQqooj/BObrx9VC6OhlUw9mA3vLniK6LI7dP3WamL3z4rQR6yj4qzty9ZtPtyDuinbdZOiSDEj8xBIswZQVHvwW+zKJTS0uStd03MsUPYgM3NEZ+xxLTWoTASRUToZt9AKDaCu/mWySK5dkaSJL8FRqaEwBvXsfIxRyQ6g6jML2UQjlx2saS2A576yi6jD37ZpyUg4vFb99DNNusKaZUebIAfIeJVh9KfHJKG16siu2Rofkap/21mz/QR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXcASLdmwE5XSdD88B4NvZ4T+T+xaJEJ03M9liZDamw=;
 b=EGVNh2761B5ABZV0Sprcb7jqI5nR0zHLjk9ADBeSFd+mcceMe2I+UuTpMEQK7Nmf2kCsIhOU+r8IKkNxlEn2ZNWYoE+BG9vSHo+fHtHWwB0FL1SbWVJS/fqgXy4vv84j4mM1/6K31UX8TbI75EY/Bjmk0dW4GbDrenjXkd+Zo3ObnFecoaBhyoOo7WP3x81c/lBAsbXO/NQ0i81L2tZB1lgTc+ZpaasDdLx8yxAHCLQbMmtgZhQ6QhJXIlmHv/M3psjh+68SzskUl09Frw0FGMFBDOYCUqUzg9DT/EnSPbTar4Tq5aAF9KQaWfk98MO/6/4rCdLBNRJE7V3jqfQUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXcASLdmwE5XSdD88B4NvZ4T+T+xaJEJ03M9liZDamw=;
 b=TnPwlOkheMIFyawhoXp3Ax/9MzEvpDlZyLw/VOWoMminrgTv6es8YDSfoOvhfLunn0FfsKy1mxxzEnY2x3r7RRMUwxdEKLuSfzDAg47v+Dh412ZwiLsAzfQxz+pahDWch9G1vmEtPAUpjfQnJ2hefiUt056zU7n0RyQykJtJhvQ=
Received: from DS7PR03CA0265.namprd03.prod.outlook.com (2603:10b6:5:3b3::30)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Mon, 21 Jun
 2021 07:01:05 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::4a) by DS7PR03CA0265.outlook.office365.com
 (2603:10b6:5:3b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Mon, 21 Jun 2021 07:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 07:01:04 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 21 Jun
 2021 02:01:02 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 2/7] drm/amdgpu: fix Navi1x tcp power gating hang when
 issuing lightweight invalidaiton
Date: Mon, 21 Jun 2021 15:00:35 +0800
Message-ID: <20210621070040.494336-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210621070040.494336-1-evan.quan@amd.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3c053b-0757-4cba-ea95-08d93482566f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5066:
X-Microsoft-Antispam-PRVS: <BN9PR12MB506633E956C2109DE30B882BE40A9@BN9PR12MB5066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZN9IROiDkb5ZrrUVxczLsyP2sVQDS41gEgPGJRMmeXbIl1kJaYdC+EOz9POnpvdlr0u3YtY4UP4/Hy5STMUH0uzTk7AuiQrcflok9xQBgxCGpowMl4g/NO4jR05a6QiVmUDGID1J+9KWsWMF4DxGG9Q0JTOLitLMcIeEgW8jHtkobccZGrGWfveffZ7yxXBrAH9E/qFqMVF4hp92cnyhq5VlpTfJG5Md299pmQA4dsjSJxPR4+n4oL+2FmbvFto/vW3BjUXY+AqTb/Qzg5Z4ntycuxCk/b2EaRDULIq28nTpMGZBJ+ad4+irWr/0FUAob5rN6H8jm1gvctL6MYCwkOhkGgOFAe0hZ1OMv+TIhEvb6Hw3auT1lzrlfB8+dVZ+ocVY2IYd9++44YyLx37ouf3BQBOeah5XIXmGZbJ6jnd6RNcYJQ2uFADX0QK4tNiojxnjufQGuO286h2VmfrEW0FOPr2OGzdlMBvuWhAPwItdd/RrcgEGA8+ckXHthxlW/ABcjFgieViLuNILr0NHNR3Kebf25xJ2H60po0oOMo0ReRKNAwJwSYjLWS4hxGQ7VsDHvRDjQDTdlb4Ud4nSLMjf0Fn4z54Y/Y83ro8F69m4dWpa6Y1FcYiSgrSKQ+3jcb7SmbFzNSbb9L2q7+gwWeYEwjviblug0vNkIy5Y28qlVgnZ7Vkeh9ZqtYvQmvaRyjnWcco5UgNreXF7I+uzg3UovNdKJaZRmQPQMbUvow0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(2616005)(316002)(7696005)(186003)(426003)(86362001)(26005)(16526019)(47076005)(336012)(4326008)(6666004)(44832011)(82740400003)(36860700001)(5660300002)(36756003)(356005)(82310400003)(83380400001)(478600001)(81166007)(70206006)(54906003)(70586007)(8936002)(1076003)(8676002)(6916009)(2906002)(16393002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 07:01:04.9114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3c053b-0757-4cba-ea95-08d93482566f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix TCP hang when a lightweight invalidation happens on Navi1x.

Change-Id: I5000fefa9ec48a5e863372d298354bed1562b332
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - Alex: use ARRAY_SIZE instead of hard code
  - limit the changes for Navi1x only
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 384b95fbad8b..b170d5fb8993 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7971,6 +7971,97 @@ static void gfx_v10_0_update_fine_grain_clock_gating(struct amdgpu_device *adev,
 	}
 }
 
+static void gfx_v10_0_apply_medium_grain_clock_gating_workaround(struct amdgpu_device *adev)
+{
+	uint32_t reg_data = 0;
+	uint32_t reg_idx = 0;
+	uint32_t i;
+
+	const uint32_t tcp_ctrl_regs[] = {
+		mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP12_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP12_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP12_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP12_CU1_TCP_CTRL_REG
+	};
+
+	const uint32_t tcp_ctrl_regs_nv12[] = {
+		mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU1_TCP_CTRL_REG,
+	};
+
+	const uint32_t sm_ctlr_regs[] = {
+		mmCGTS_SA0_QUAD0_SM_CTRL_REG,
+		mmCGTS_SA0_QUAD1_SM_CTRL_REG,
+		mmCGTS_SA1_QUAD0_SM_CTRL_REG,
+		mmCGTS_SA1_QUAD1_SM_CTRL_REG
+	};
+
+	if (adev->asic_type == CHIP_NAVI12) {
+		for (i = 0; i < ARRAY_SIZE(tcp_ctrl_regs_nv12); i++) {
+			reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG_BASE_IDX] +
+				  tcp_ctrl_regs_nv12[i];
+			reg_data = RREG32(reg_idx);
+			reg_data |= CGTS_SA0_WGP00_CU0_TCP_CTRL_REG__TCPI_LS_OVERRIDE_MASK;
+			WREG32(reg_idx, reg_data);
+		}
+	} else {
+		for (i = 0; i < ARRAY_SIZE(tcp_ctrl_regs); i++) {
+			reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG_BASE_IDX] +
+				  tcp_ctrl_regs[i];
+			reg_data = RREG32(reg_idx);
+			reg_data |= CGTS_SA0_WGP00_CU0_TCP_CTRL_REG__TCPI_LS_OVERRIDE_MASK;
+			WREG32(reg_idx, reg_data);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sm_ctlr_regs); i++) {
+		reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_QUAD0_SM_CTRL_REG_BASE_IDX] +
+			  sm_ctlr_regs[i];
+		reg_data = RREG32(reg_idx);
+		reg_data &= ~CGTS_SA0_QUAD0_SM_CTRL_REG__SM_MODE_MASK;
+		reg_data |= 2 << CGTS_SA0_QUAD0_SM_CTRL_REG__SM_MODE__SHIFT;
+		WREG32(reg_idx, reg_data);
+	}
+}
+
 static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
@@ -7987,6 +8078,10 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v10_0_update_3d_clock_gating(adev, enable);
 		/* ===  CGCG + CGLS === */
 		gfx_v10_0_update_coarse_grain_clock_gating(adev, enable);
+
+		if ((adev->asic_type >= CHIP_NAVI10) &&
+		     (adev->asic_type <= CHIP_NAVI12))
+			gfx_v10_0_apply_medium_grain_clock_gating_workaround(adev);
 	} else {
 		/* CGCG/CGLS should be disabled before MGCG/MGLS
 		 * ===  CGCG + CGLS ===
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
