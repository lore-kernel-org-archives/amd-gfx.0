Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABD9C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 21:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F108F10E6DD;
	Fri, 12 May 2023 21:44:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0211610E2F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 21:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0UpvAUh2VCq/qiATH0ejRzKgSyQD+Y9lNhjUY7coOf5n3SO87yk0MdkrWJLPlju2xxWeH3UvkMlCv/dW1jgKE7UYihgwMBDOe3Rz2K7cal2SLVlWpnq96IdB4Cm4/PPK7F5B8/CVq85/0Nbr582GE7/LCcYy4PjySLrXHbY7kMT/KPjwLBBukApKLERDWFF6N28ULzh3f9WUSCP9yzlPlraDJi+RXDYqDKmFtwWehn8FSNFwBqk+yJZKY2UVUdZn7BxI+XkRf2tk5E/o6ZWU6UeEjmvA7FIpR9v3Q5wG3Z1zqG6A82bMezrt/nAstEMWELVQHLyOVob0avVmBZ+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRtoPwhcK/vUGPAPSstzJGa1dQQwk+WykG2xEqw6LNY=;
 b=YNzZzHTdJGLo6zceUpO3R3XGioWBgJD1TFecABAbxLhbjOpERor1fCFIcyjvHpLgYOwrQHF2c5nqjqGmfY65ZY5sBRDApF1TwIkM9oni/oVOKp25bAG5N7nqLPCxc5ikZdnlHQwL23ntzHnar8kQSsLojRyfuTSDryv2yvoN0q5qAogDvKz9nEaGvW7+fU5aSEcHpB2BcG9O4myUrhQdELDGS5y5A1A8KAOZdMCA+GAGIwfDtJMC4ZS9pel2CXMJrvMkKKmsxHRIcplOpmSwgHJqmrB3X6K4lb1OJJNxthLVcPbR46ua0GL5g0f7HD4nyWJ+LRvg6cQj4hHWhxG2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRtoPwhcK/vUGPAPSstzJGa1dQQwk+WykG2xEqw6LNY=;
 b=C/j5cv5YDIfp8sLU2Xs2gl9ua6bbwQi8sAFmPAhLsRZhNctNxF0GOyHF9tSG4GgcSH+3tnMjeqDzuM1tHxuf+C71er+NqfFryF3JP3Cve0OJOipUhb4YFIXsceC+czoc8hCJ85vENihThfy5NT044v+spJkD26KkVb5vv6SjcQA=
Received: from MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 21:44:16 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::d1) by MW4PR03CA0290.outlook.office365.com
 (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 21:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.26 via Frontend Transport; Fri, 12 May 2023 21:44:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 16:44:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amdgpu: add RAS status query for gfx_v9_4_3
Date: Fri, 12 May 2023 17:43:43 -0400
Message-ID: <20230512214351.1356254-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512214351.1356254-1-alexander.deucher@amd.com>
References: <20230512214351.1356254-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 245ecd06-7cd5-4636-7052-08db533208a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yKeyJjQqF/bjobDeHPSHU7yP84rg+NERg9DWQxJtyrelc3emtGY9DEAk0O5Igf8rI1AHTFIVNIKI/71N2kMESioryYdSF/JGq+0wxn6L+R7TqrNb7jCRvPVynINIOKBJxYGlWlGqxfYNHK+vieqS2VP3BiD7P9MwstDmGKOC5fBook+NU50GaWdzzc9tJz5EOrfGg+eToNqXmBwiBrCwCx+fAHySuxbSPq8brhOVk9j8TYZ1/+WAVJQgJcpoKgo7Ny7nqkHK1e2JZ04A1K18ydu9Ve8wnMhH26IaGI6tb7xegr52VkIi/R6d0tCH6QCPncXO32RFgb8NwqdQHvsPRPxzcZCGA8QlcG99VF1dBFnScjDY5M8ed4egjDsNgPhJaUYYcWhGT95cOYIfqtRMxKaKj+fs2KFwly2YLD7KYjeHmibVdTgTnn5f2/FU1Pm1W4CysNfGKOhpO/RLYxEpaKPkir0lJadSVenM/iZwv5HT7tprWELCiu0Lxos591fU7PjiZKjX6ekYrnB8/ltx7KzJVGWYrLMMa73VfjoWuJPd3f9JWv9qtIr9x/dreVsNWFtiNQRLRiAPFZWejec3xR6Q6TJ/he0Lhh5yfi735Vy8ai10j3Qo8FeCjNFWT1rF1+YdBzhQ/cfeke0+qs3cpG1V4n/JGOeIbZcQWMIrq298FhnGJVlEtDc8+c/J9kdNK/mxBnVFjFenvG2ckiuxS/wuogaZY4fc11O9szv2NJWi5BYSzr/MllJtYYMRkOhjJ+Fpb8qJD5A47/FtgEZZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(54906003)(478600001)(7696005)(316002)(8676002)(6666004)(41300700001)(8936002)(1076003)(26005)(4326008)(70206006)(6916009)(70586007)(2906002)(47076005)(336012)(426003)(40460700003)(86362001)(2616005)(16526019)(83380400001)(186003)(356005)(81166007)(36860700001)(82740400003)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:44:16.0312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 245ecd06-7cd5-4636-7052-08db533208a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Query GFX RAS status.

v2: remove xcp operation.
v3: change instance from 0 to xcc_id for register access.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 75 +++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 6cde05421a10..f178e3f565e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2980,6 +2980,81 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static const struct soc15_reg_entry gfx_v9_4_3_ea_err_status_regs = {
+	SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16
+};
+
+static void gfx_v9_4_3_inst_query_ea_err_status(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	uint32_t i, j;
+	uint32_t reg_value;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	for (i = 0; i < gfx_v9_4_3_ea_err_status_regs.se_num; i++) {
+		for (j = 0; j < gfx_v9_4_3_ea_err_status_regs.instance; j++) {
+			gfx_v9_4_3_xcc_select_se_sh(adev, i, 0, j, xcc_id);
+			reg_value = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+					regGCEA_ERR_STATUS);
+			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_STATUS) ||
+			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_WRRSP_STATUS) ||
+			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
+				dev_warn(adev->dev,
+					"GCEA err detected at instance: %d, status: 0x%x!\n",
+					j, reg_value);
+			}
+			/* clear after read */
+			reg_value = REG_SET_FIELD(reg_value, GCEA_ERR_STATUS,
+						  CLEAR_ERROR_STATUS, 0x1);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGCEA_ERR_STATUS,
+					reg_value);
+		}
+	}
+
+	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+			xcc_id);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
+
+static void gfx_v9_4_3_inst_query_utc_err_status(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regUTCL2_MEM_ECC_STATUS);
+	if (data) {
+		dev_warn(adev->dev, "GFX UTCL2 Mem Ecc Status: 0x%x!\n", data);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regUTCL2_MEM_ECC_STATUS, 0x3);
+	}
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_MEM_ECC_STATUS);
+	if (data) {
+		dev_warn(adev->dev, "GFX VML2 Mem Ecc Status: 0x%x!\n", data);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_MEM_ECC_STATUS, 0x3);
+	}
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+				regVML2_WALKER_MEM_ECC_STATUS);
+	if (data) {
+		dev_warn(adev->dev, "GFX VML2 Walker Mem Ecc Status: 0x%x!\n", data);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regVML2_WALKER_MEM_ECC_STATUS,
+				0x3);
+	}
+}
+
+static void gfx_v9_4_3_inst_query_ras_err_status(struct amdgpu_device *adev,
+					void *ras_error_status, int xcc_id)
+{
+	gfx_v9_4_3_inst_query_ea_err_status(adev, xcc_id);
+	gfx_v9_4_3_inst_query_utc_err_status(adev, xcc_id);
+}
+
+static void gfx_v9_4_3_query_ras_error_status(struct amdgpu_device *adev)
+{
+	amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_query_ras_err_status);
+}
+
 static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs = {
 	.name = "gfx_v9_4_3",
 	.early_init = gfx_v9_4_3_early_init,
-- 
2.40.1

