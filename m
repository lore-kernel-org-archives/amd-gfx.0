Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BC7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0EF10E615;
	Thu, 20 Jan 2022 11:19:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8042910E5F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAD1F3wOXpHNqMzVJclvmC5NRr5tWIEh+Nc6+LEIM67zyVPQHxpA3sG3OrDWBV1dkvsbL2ymovRKJ1Mu3+Hg+WnrroZIA2fKWbs7k3Zdq1YLnECEjeW1GrD8n5m+xwuIcpWKQu78sf+rmjmrFmTYLNk/RnzucIURoqkMxw0m4rRkOYCnNy0qM5qROBKzzHFk7W4sQ5g/bg4BcTKmiTBbBViHqt84Z1mFBcpu2nVds08wt0N7HaWFktsATBJsu4Ny8Z67IaTh1q925SQ7OOabE0/sFsA/10JDgLNg8d1ZHy8OW9MKW+WccJEkMPjeSLPSB/wrqi43NGU445w+0hWNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KITUj5GRyaFm1j1husIu7/HDcUGfPqUX99/4FqlSFes=;
 b=JLMsyTnuKg6a+1XvWrZ0YgaJ7zaxegpjujPPP+PiHfYvVA6tS3DBPSqneg/Wt1WV7LI1NyIYBaurfoqjNGj0KDvWYdssalu8/hzJW5j15+pYV6Oci9hU/Os8Wb5hEhxHVLK0KbCAyyhvs0I/cD79SidNKBvVo0BVohyuZFgioaFCHic/XT7udKBpVF5fLZToyfmqmNO378LcUBrCUlpQDvYcvuyp5Rh2GxIa+fPPrvy3gQFEKBjZpyxbQnjM1+0f1BbkPGmFgol6nsDPN151bGd/xZadH2DQaSxnIt2qunpTrjNTgnGtCcO3UuJTmnIQcVfO6Qr5GCHh3rfT45MUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KITUj5GRyaFm1j1husIu7/HDcUGfPqUX99/4FqlSFes=;
 b=4HZYHq6ObWWtsugr/v9HKOD4KenPJMM6pKAjEIDV6lmFlykL9k4bxQD/9RvFm2SCs8rk/Zh5C8s6sOvhHaJpiNf0qMalWRl74pBRUSQq9h09t5TI/oqPXbM+etb137mFr1JeSSEfuyo8do0cYOr0Z5Ie5Vq/UcuEskH4Mxuq/hY=
Received: from MWHPR04CA0061.namprd04.prod.outlook.com (2603:10b6:300:6c::23)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Thu, 20 Jan 2022 11:19:12 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::72) by MWHPR04CA0061.outlook.office365.com
 (2603:10b6:300:6c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Thu, 20 Jan 2022 11:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:19:11 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 03:19:10 -0800
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:19:09
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: init rlcg_reg_access_ctrl for gfx10
Date: Thu, 20 Jan 2022 19:18:50 +0800
Message-ID: <20220120111853.11674-6-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47a4f7b7-1e44-413f-0d37-08d9dc06af16
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1548707482F7093F76D39521FC5A9@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhYd7fBMbZKjLOR5oPhMHr31GhLzrVqy5ljsdWhRrWqSTKF52+4clHs0Kli1TJQmsw3ZSvFzopCfphmTdbX1lVJor/lYN2cDYm/zYaV36u2/R2d2+LFr/hnHsDcpbvJ5d2t/3J/F6bhSTOq/I1M5vz6psXS1R8+t/wofCfOJhmZWjhQiY0zM7AT7fsoA2m9CDM8lhFwVNvSTOVXnEQ5pQ5j47+l4NplD46ufcHKmhIzyiFZg0wLBU6m/N6pOH+kkM8P28Lcppyj0NvC6iPclYxs7AF0tKzUzRGASGSwGJjJT99ElzCpoxmE0opnABixdg4tM+6PH2CFuznnzf+l8r1ulBxl8I3c2B59AYAwFT9M0W1V62ofPy+NbkB3VA4K62IOWQKv1Nii2VZQYojPXtXrWEb876HjKBTsbkf8Vo/0JUi1pgEJxBD2Uv6QK93Zs2LNTT+Ksj/K1BYB6U4HlQcAYiEZqznNCFbbFtIcra8kU8Jso5KHjvaUJtY9Bk2909EAiChcakZNhpfOW+C6Dl+X5D5IPLkJHF8U4X1RsvKxh30DztflGqYSrfZ3DGLcDlCyrtt/FR7j7tVtC312hXBqHLXQqjFZNeFSrmp4bWbB8pWg/ITnayEkE7sLvX0QZNY8QBxppaTwu7H048s8gplB3PdTSCR66JrSi3Mk0aywvK/w7mjtr+Kh78ARLW6FvpWZ+Zt0byAP8q3lXZXlxmZY+lkuVvBHtxMlb7917cyzjJznoexQD+Vx+0MWQOw42qKvB74MaqRN8JV83320K3Vrno1eIUQ7BTITIMN1M+PE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(70206006)(70586007)(336012)(508600001)(36756003)(356005)(426003)(6666004)(2616005)(83380400001)(6636002)(86362001)(110136005)(82310400004)(40460700001)(7696005)(316002)(2906002)(66574015)(186003)(8676002)(1076003)(36860700001)(26005)(47076005)(4326008)(81166007)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:19:11.3445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a4f7b7-1e44-413f-0d37-08d9dc06af16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
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

Initialize all the register offsets that will be
used in rlcg indirect reg access path for gfx10
in sw_init phase

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 38 +++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 588c922573e9..3fb484214d3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4411,6 +4411,30 @@ static void gfx_v10_0_rlc_fini(struct amdgpu_device *adev)
 			(void **)&adev->gfx.rlc.cp_table_ptr);
 }
 
+static void gfx_v10_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
+{
+	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
+
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl;
+	reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
+	reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG1);
+	reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG2);
+	reg_access_ctrl->scratch_reg3 = SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG3);
+	reg_access_ctrl->grbm_cntl = SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL);
+	reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX);
+	switch (adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(10, 3, 0):
+			reg_access_ctrl->spare_int =
+				SOC15_REG_OFFSET(GC, 0, mmRLC_SPARE_INT_0_Sienna_Cichlid);
+			break;
+		default:
+			reg_access_ctrl->spare_int =
+				SOC15_REG_OFFSET(GC, 0, mmRLC_SPARE_INT);
+			break;
+	}
+	adev->gfx.rlc.rlcg_reg_access_supported = true;
+}
+
 static int gfx_v10_0_rlc_init(struct amdgpu_device *adev)
 {
 	const struct cs_section_def *cs_data;
@@ -4431,6 +4455,8 @@ static int gfx_v10_0_rlc_init(struct amdgpu_device *adev)
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
 
+	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
+
 	return 0;
 }
 
@@ -4828,10 +4854,14 @@ static int gfx_v10_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = gfx_v10_0_rlc_init(adev);
-	if (r) {
-		DRM_ERROR("Failed to init rlc BOs!\n");
-		return r;
+	if (adev->gfx.rlc.funcs) {
+		if (adev->gfx.rlc.funcs->init) {
+			r = adev->gfx.rlc.funcs->init(adev);
+			if (r) {
+				dev_err(adev->dev, "Failed to init rlc BOs!\n");
+				return r;
+			}
+		}
 	}
 
 	r = gfx_v10_0_mec_init(adev);
-- 
2.17.1

