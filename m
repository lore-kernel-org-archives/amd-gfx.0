Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D5FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93A610E614;
	Thu, 20 Jan 2022 11:19:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165AC10E5F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK2qBRatV5E9j3hR2LqsJ7Wf7M0Hbs9rVRLXSMFPzCSpTW6w9IZCSjbvrO0eZTp0KkuFw6vpwywQTuLzO6oG9+QqTIYrpyk9kbZD7vLxq5vW9sGwBzfFqPJ4zWLg5PyQb8Yq1zok7v49TBvwUYunKKfp628/UQuSMACrgeiBVLnZ609oJ+V6sVbsV3zjOkZ8UAcenkeLhunoKA9Du/NQe1fO0ZOMKFfpSGAMbF+PSksRR9nOfplb+DMmAJUVlrbJhKgy8G+hFRhlr6Qx/0l3N8S6D8v+J/ust3LDsKcsqRSbygFv7EzUCVbCd3q61FqyRShOGSj783wbpSPqeP3Gzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eIfAYHXOq/gQO+C2DW47IFkdB9LMZJL2WJXqkfvbDw=;
 b=OIVDi3k+3JDE8+LsJlf0bzrh3uzH+vQXzmhjxBQ9mO3AyFMNY/SlItoRn1ot0dXchQsT6mKh/EDYaDtKDwEFuuqIEqtQambuWxA8AQLnjk48g2gbmm+KUFoYt7BmjConM1cqsB8OpE/VXYrH4R1lXEXCv3jXFiw7oDLpl/NMCH0VD0idEonQ3n57LVMzSXKIQNgIxpRsGBRbvP5ge6ETqxfg04qJUVsHXoPVwSBVSshFFVhQKL3y1Eh+tgYGHRXB1TRVZ2GGBd8WqrsmM3PQWL3OoLtmG/eTILPtoahy7jBeIXeqQnYg4thogHFD6/YgOdE8ms6bXzTvytYY0Uf5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eIfAYHXOq/gQO+C2DW47IFkdB9LMZJL2WJXqkfvbDw=;
 b=zTDIzmuRu4ke4Z2wvcc9lQNoCh+SLpGTUD7Tm0jwaC5YuFCxxzuxacb73JavahrASH8d68LxkqAEFbs5XftH07QtgA0gaIe7IVJyq8Vcq56vU+OXao5BVh+O8Wh0ge4Am13lvptnsOissFvIDF9tPls7TMNnu5ACr88m8mBJdrY=
Received: from CO2PR04CA0080.namprd04.prod.outlook.com (2603:10b6:102:1::48)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 11:19:09 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::5a) by CO2PR04CA0080.outlook.office365.com
 (2603:10b6:102:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 11:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:19:09 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:19:08 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 03:19:08 -0800
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:19:06
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: init rlcg_reg_access_ctrl for gfx9
Date: Thu, 20 Jan 2022 19:18:49 +0800
Message-ID: <20220120111853.11674-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120111853.11674-1-Hawking.Zhang@amd.com>
References: <20220120111853.11674-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1226539e-69d7-4459-1cd2-08d9dc06add9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3384:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33848CD0C347BBEF37FFC56AFC5A9@BYAPR12MB3384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+Gx7g/2oXCcUKUgb8zdM0Pv4UWqBHArohQSkYjjAmIhuWyeW10mhKi97o93dYeCKLBZLLz1ep6Pyr+w9BLDelzC07v9BbAVlBQObKY8icmqlSrupDUmByoMmDNxlV1BvvGNDjPyeKatW6XTKRReZ8X720EvpaGKQPk/1VxMgJZg/jW2H4vwWd4YLaKNo26M2DHCExUsQxZoWWRCP+gtM4RyZ5d0WYE66gEwe6nmCOME4ylB4GqIq1D2aKI+/46X8yPpYw9w42bgjwnLzEX3i5FYJjsbFWhCsaBKAchzUQegaFVuqUhE1ieO9wIUxr0eM3XvP+1pD8nGdQTMzkxfQcKt1KHqH8m+OblGKGUU/k89sOKVsHQsGhHKGA0Mq92wBIvYyUMZF7QBdbMWti7YoHV4llLczUFJKAjD/PKZp0VcCE+cprwXh9YHDT+GhsbqKpQGB9KzYT1MXIx+/fsAfyats41dQWOvKsIXO5NID0/tXCqmD/G7ghYvnr5iVxhxca1TZV5qQvVj/Yo4LGmI3hq1PaDIfZNL5aC5zQKlO7D0QOzRrMmJeeLNgTYhlgN+4Ugwirf7ccuJfPFVcvM58Tq671s1vOEDfdifAVZL9C6463QuuzazJVNoyOCXeyf3K85zSgMkf6AiiMzsMDxNmvRy/z2waXOER3jT2ii4I49u3BwYwNw5Abr0WPNCDccnAGTdRRwNkLUNMNQ8ozU62yHkmLVEWkuqMqyZC1p2ZGPhLwGEkhtql9rnwvauLYPtO2h35s8nW1+bG+iUTtkLF5ZGtoUELx8UDjjfju/Lvos=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(83380400001)(4326008)(2906002)(336012)(8936002)(110136005)(40460700001)(316002)(356005)(82310400004)(66574015)(47076005)(86362001)(7696005)(8676002)(426003)(81166007)(70206006)(2616005)(6666004)(36860700001)(36756003)(508600001)(26005)(70586007)(6636002)(5660300002)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:19:09.2362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1226539e-69d7-4459-1cd2-08d9dc06add9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
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
used in rlcg indirect reg access path for gfx9 in
sw_init phase

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Zhou, Peng Ju <PengJu.Zhou@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 30 +++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 17704cd99aaf..c7bccf1a28b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1983,6 +1983,21 @@ static int gfx_v9_0_cp_jump_table_num(struct amdgpu_device *adev)
 		return 4;
 }
 
+static void gfx_v9_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
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
+	reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, 0, mmRLC_SPARE_INT);
+	adev->gfx.rlc.rlcg_reg_access_supported = true;
+}
+
 static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
 {
 	const struct cs_section_def *cs_data;
@@ -2023,6 +2038,9 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
 
+	/* init rlcg reg access ctrl */
+	gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
+
 	return 0;
 }
 
@@ -2432,10 +2450,14 @@ static int gfx_v9_0_sw_init(void *handle)
 		return r;
 	}
 
-	r = adev->gfx.rlc.funcs->init(adev);
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
 
 	r = gfx_v9_0_mec_init(adev);
-- 
2.17.1

