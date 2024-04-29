Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5BAC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC60A112CAB;
	Mon, 29 Apr 2024 14:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dOCrHqth";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB3A112C90
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGrIe9hj7+GMNLKjnZ5bLLYWIe8JZwczhFAlxDp9giPBjRO1QdVWLxbMDeAaxlSx8DEN/Pi58bapbjXpdDLWOOAOahEPI0roGm58lRiFfkcE2EwYhrCjV09hNYY2y4K+5RQzOuOjF0QiwwwjpUZdwjmeDyXm0ue7jQS7NlszDwZtDvUXY2eTlxA9LGqXeqiilIXdlCkofKe23ZkmIBMtH2URz0PkDskIq6zxy2WaHd8xSbTLWSsgRqljvJFeIOG3HpjEazs5lY7X6XUI8FPyTkIxjkQnGRxjSxfJrkJUI7GoH/m8KpI9Mo1aDLHTnc9LiscT9zGTKd/pENanzwNuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvPhDyUcsHjuYPom9vQxg3/IZMDkgKlIdAFtA6oJjEA=;
 b=ad2nd3zvjCtiGBlK5qrcPRhy5kP9nX05rvsb5ImQvNrJGju6GTsbwwrd+kDRuYIrJXTUjQ0rmx8JkcdU+8LzMhodbr7DBgcbYThAQhJA+AVpfaFQmcjBLkNu9hEt8Tkl5q3A/SBUoRIbXmcM5fAP/2DgqRKfhVrg3llXEriJjN0MArR2O7tv9dJxG4OmsVyUUOUmJsb/HmoiOmeb81wOEDoFZYFVYpoQQ/MmQPZ3sZAt9WGn5fjwGWi7gRDxX8zNAsyDVGtO5/qFzhru/ve/jsMu87leA4JazvX0ip9qZQ8iSPJAHve8KYBGF0tTKZjV8btEB0JQpV0xcdunsGs6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvPhDyUcsHjuYPom9vQxg3/IZMDkgKlIdAFtA6oJjEA=;
 b=dOCrHqthmv+da25dRE0ESHvtMTglHo/4JsKduvGFpm2q73ouf1xPaVRcn/HK9zZVSNfMLIQoUaSaGRrlaHkRfwIoehfe/NmOSTkri4hg4i8ozleDSI88HuPD6TvrgC/5mGAicylZsuoXXNtwB4a41GTOXC7vx2lPGaLuwACS3rQ=
Received: from BYAPR06CA0031.namprd06.prod.outlook.com (2603:10b6:a03:d4::44)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:18 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ee) by BYAPR06CA0031.outlook.office365.com
 (2603:10b6:a03:d4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 15/31] drm/amdgpu: set cp fw address set for gfx v12
Date: Mon, 29 Apr 2024 10:33:23 -0400
Message-ID: <20240429143339.3450256-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 7136ee30-625a-40e0-442e-08dc68597266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PgEFqqn52aRCwFnSPTQ/qNZ66P3EhE5O5UiVGEbJgUjnqsEAyFofaR1YKclb?=
 =?us-ascii?Q?sPniD6BKCdUlKk5WTuCcTxHHrKIVigWsmWbKMa+RHbCAZl06AwZ5EwFRLQ7P?=
 =?us-ascii?Q?3YSUZomj4YNELYckLIIl6hR50VezhqVseypXon11EYZ22HVqTTyT9GLqaJ76?=
 =?us-ascii?Q?Ma/x7CIwIMVuv0BCGqcPdGHSo5jqJW1hSeoB+LNoSGELBMsf4Guizepdt4GA?=
 =?us-ascii?Q?AncaagNabxXOQRgiVALHmCIf446Q2DjFOqM/1YUh2GHQgannHzkY/cSEajjm?=
 =?us-ascii?Q?gXcFhQFSf8DVbtCFWsheDQpfZfagtv7BROoPnKyprLtGAzftBBtGXBPtmtjf?=
 =?us-ascii?Q?ytNe9CKU0AmbVbRmeG5yhUg8deqwH9xHZunLOBoGqSUg1LdXawCUt2mxXbhY?=
 =?us-ascii?Q?I9D2ZvTPjg6n3PYWdbrG6HxppaT6gd7+eIih45gikrTcMTUffVX+UgfuZSWB?=
 =?us-ascii?Q?/q3/vRCZt6f5TrPS+A51tFsjO1ngwOolxxNNKS7ZKJ3tCoNZgky6qQgYcY5g?=
 =?us-ascii?Q?hcuvtBRiYGRVFKUbBGepN5xHjyGMkvVoCBhpL8EJO6owYHr7Cj2pMszPGrlS?=
 =?us-ascii?Q?O9BiiDMiW1dDQF66UbZL4I4UfdaRixl5YGYzugx2xMLDMHQI1unps7mo+DqS?=
 =?us-ascii?Q?06iIDqb1kdJAiakXc/jYinZalPygTQJsGK4QBb7fjTfoiUhJpyNpAaIRJQKf?=
 =?us-ascii?Q?gDQaUFcZ2BAOB8UO8hXYXseNWZlJNJdfTiF7PofvdRCnYfaACix+1KmJ3rXq?=
 =?us-ascii?Q?wJbjnCOmOrVk+xk3y1U9DPRgzqRRyUMJ5dF+d6dJu8GIgw0qdPNrRhR7cQ6r?=
 =?us-ascii?Q?QY9+GCDwmZDsIUy+PetlLwjis3RxvTEQ2uBPdTQeVl6hj31L0YpnnSdnVMLz?=
 =?us-ascii?Q?azDks61b81rWnSDtvnMDVBzZ9sv6KFpRH17ZJEYD5oK/O1LxY8bl8bQ1CeCY?=
 =?us-ascii?Q?1A8AY+NPN4iKZ8WGdjUS45isIK76qGJgwP2BNVkUSpUiX3SAEiMnMpRsQC6j?=
 =?us-ascii?Q?GricDNc/4FjdUhGaj3L3mye1lfU6KxCWhdJtMHBxM52z+iW4Sj6b/YV1DCKZ?=
 =?us-ascii?Q?8ftbOyCXuV6ci6lpNSUMQUsft6r0TWK8OQMfL8cfgF/avvo1v7JNUVx9luK+?=
 =?us-ascii?Q?6Jn/PICiPJXs4qtBg3SjRoncsPbAzSLDjkiIlj0fUGins3PVfyz+fkWQ5nhU?=
 =?us-ascii?Q?q4ffc9AbkbnNb3DiICtGmFY06wEh4ccOKjncrvOnOlx/wCSVy+ZkBBHc/HH+?=
 =?us-ascii?Q?VljAJmjhY7u60a81MS23ZoqJ11QgqBpbMJgx+/RNfiTFQbq7vzlm20yDRxPg?=
 =?us-ascii?Q?DmJ85ynGHc6Ng2HcKEMqJm6MG2S9u4I2oqvwLWzDLxACy0hI8VV9LHJPlznn?=
 =?us-ascii?Q?+gzGG+hOmutNNRHRAZ0/FeuHvv6U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:15.7950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7136ee30-625a-40e0-442e-08dc68597266
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Split PFF/ME/MEC firmware address setting function
from related load microcode funtion, as it's also
needed for rlc autolad.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 186 ++++++++++++++++---------
 1 file changed, 122 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 2075797b8b762..afb977e1dfc81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1749,6 +1749,110 @@ static void gfx_v12_0_config_gfx_rs64(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
 }
 
+static void gfx_v12_0_set_pfp_ucode_start_addr(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *cp_hdr;
+	unsigned pipe_id, tmp;
+
+	cp_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.pfp_fw->data;
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		soc24_grbm_select(adev, 0, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START,
+			     (cp_hdr->ucode_start_addr_hi << 30) |
+			     (cp_hdr->ucode_start_addr_lo >> 2));
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_HI,
+			     cp_hdr->ucode_start_addr_hi>>2);
+
+		/*
+		 * Program CP_ME_CNTL to reset given PIPE to take
+		 * effect of CP_PFP_PRGRM_CNTR_START.
+		 */
+		tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
+					PFP_PIPE0_RESET, 1);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
+					PFP_PIPE1_RESET, 1);
+		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+
+		/* Clear pfp pipe0 reset bit. */
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
+					PFP_PIPE0_RESET, 0);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
+					PFP_PIPE1_RESET, 0);
+		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	}
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static void gfx_v12_0_set_me_ucode_start_addr(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *cp_hdr;
+	unsigned pipe_id, tmp;
+
+	cp_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.me_fw->data;
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		soc24_grbm_select(adev, 0, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START,
+			     (cp_hdr->ucode_start_addr_hi << 30) |
+			     (cp_hdr->ucode_start_addr_lo >> 2) );
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_HI,
+			     cp_hdr->ucode_start_addr_hi>>2);
+
+		/*
+		 * Program CP_ME_CNTL to reset given PIPE to take
+		 * effect of CP_ME_PRGRM_CNTR_START.
+		 */
+		tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
+					ME_PIPE0_RESET, 1);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
+					ME_PIPE1_RESET, 1);
+		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+
+		/* Clear pfp pipe0 reset bit. */
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
+					ME_PIPE0_RESET, 0);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
+					ME_PIPE1_RESET, 0);
+		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
+	}
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static void gfx_v12_0_set_mec_ucode_start_addr(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *cp_hdr;
+	unsigned pipe_id;
+
+	cp_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.mec_fw->data;
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.mec.num_pipe_per_mec; pipe_id++) {
+		soc24_grbm_select(adev, 1, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START,
+			     cp_hdr->ucode_start_addr_lo >> 2 |
+			     cp_hdr->ucode_start_addr_hi << 30);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START_HI,
+			     cp_hdr->ucode_start_addr_hi >> 2);
+	}
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static int gfx_v12_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 {
 	uint32_t cp_status;
@@ -1774,6 +1878,12 @@ static int gfx_v12_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 		return -ETIMEDOUT;
 	}
 
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
+		gfx_v12_0_set_pfp_ucode_start_addr(adev);
+		gfx_v12_0_set_me_ucode_start_addr(adev);
+		gfx_v12_0_set_mec_ucode_start_addr(adev);
+	}
+
 	return 0;
 }
 
@@ -1905,33 +2015,6 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	mutex_lock(&adev->srbm_mutex);
 	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
 		soc24_grbm_select(adev, 0, pipe_id, 0, 0);
-		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START,
-			(pfp_hdr->ucode_start_addr_hi << 30) |
-			(pfp_hdr->ucode_start_addr_lo >> 2));
-		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_HI,
-			pfp_hdr->ucode_start_addr_hi>>2);
-
-		/*
-		 * Program CP_ME_CNTL to reset given PIPE to take
-		 * effect of CP_PFP_PRGRM_CNTR_START.
-		 */
-		tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
-		if (pipe_id == 0)
-			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
-					PFP_PIPE0_RESET, 1);
-		else
-			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
-					PFP_PIPE1_RESET, 1);
-		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
-
-		/* Clear pfp pipe0 reset bit. */
-		if (pipe_id == 0)
-			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
-					PFP_PIPE0_RESET, 0);
-		else
-			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
-					PFP_PIPE1_RESET, 0);
-		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
 
 		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE0_LO,
 			lower_32_bits(adev->gfx.pfp.pfp_fw_data_gpu_addr));
@@ -1964,6 +2047,8 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	gfx_v12_0_set_pfp_ucode_start_addr(adev);
+
 	return 0;
 }
 
@@ -2075,33 +2160,6 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	mutex_lock(&adev->srbm_mutex);
 	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
 		soc24_grbm_select(adev, 0, pipe_id, 0, 0);
-		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START,
-			(me_hdr->ucode_start_addr_hi << 30) |
-			(me_hdr->ucode_start_addr_lo >> 2));
-		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_HI,
-			me_hdr->ucode_start_addr_hi>>2);
-
-		/*
-		 * Program CP_ME_CNTL to reset given PIPE to take
-		 * effect of CP_PFP_PRGRM_CNTR_START.
-		 */
-		tmp = RREG32_SOC15(GC, 0, regCP_ME_CNTL);
-		if (pipe_id == 0)
-			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
-					ME_PIPE0_RESET, 1);
-		else
-			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
-					ME_PIPE1_RESET, 1);
-		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
-
-		/* Clear pfp pipe0 reset bit. */
-		if (pipe_id == 0)
-			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
-					ME_PIPE0_RESET, 0);
-		else
-			tmp = REG_SET_FIELD(tmp, CP_ME_CNTL,
-					ME_PIPE1_RESET, 0);
-		WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
 
 		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE1_LO,
 			lower_32_bits(adev->gfx.me.me_fw_data_gpu_addr));
@@ -2134,6 +2192,8 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	gfx_v12_0_set_me_ucode_start_addr(adev);
+
 	return 0;
 }
 
@@ -2382,19 +2442,15 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.mec.num_pipe_per_mec; i++) {
 		soc24_grbm_select(adev, 1, i, 0, 0);
 
-		WREG32_SOC15(GC, 0, regCP_MEC_MDBASE_LO, adev->gfx.mec.mec_fw_data_gpu_addr);
+		WREG32_SOC15(GC, 0, regCP_MEC_MDBASE_LO,
+			     lower_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr));
 		WREG32_SOC15(GC, 0, regCP_MEC_MDBASE_HI,
-		     upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr));
+			     upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr));
 
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START,
-					mec_hdr->ucode_start_addr_lo >> 2 |
-					mec_hdr->ucode_start_addr_hi << 30);
-		WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START_HI,
-					mec_hdr->ucode_start_addr_hi >> 2);
-
-		WREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_LO, adev->gfx.mec.mec_fw_gpu_addr);
+		WREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_LO,
+			     lower_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
 		WREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_HI,
-		     upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
+			     upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
 	}
 	mutex_unlock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, 0, 0, 0, 0);
@@ -2437,6 +2493,8 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	gfx_v12_0_set_mec_ucode_start_addr(adev);
+
 	return 0;
 }
 
-- 
2.44.0

