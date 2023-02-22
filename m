Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8DBC61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 04:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E14210E1AC;
	Wed, 22 Feb 2023 04:35:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D332410E1A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 04:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9XIIrjADaOAlQWUbFYQPFEuh2ESPPiRLEGTFTK/Bb+syt/OtvNt3aVEWrGkELmZ+h6Bz0+41vY4rXsXlAAsOKmlIE2amDk0vlnM3E8oelMm/AEoSUlL5X9sDOXDyUBkLecvOaK8/1ps4WAHLZPPzMkMYy/vf0SOQp2YpRAr/gAirKxDEufyNP/iYIDFJKNALHFqi+6168n47aeml+7UTQ98Mm/w8INMLyqloriFycy1uDLu0n4FiVojY/nd+Yga37bYcmDdEpmRBK1F2X0gtnFLgOA6o/R9L2Q7yUqy/CMmsa1q0cA81kky0NcIl1fEoXnkkUM4AFLUDh3M7QKqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE5FUbqKtT7td9gHFmBDFggWJ40+UPScoS7yf0Wmjeo=;
 b=Ez3Sa1ks/qXRQQsgtqgzHFG2UMziGn3ZbSRzNmNavrC3+BYqQ6k6CJ8Ceucy1qcVSoVlYrSH/O92pGo4/uZIXbkXh9CP1qLYiHgaiEbs6nyMEh8Z1r+9aDHI5XNw0c8QyEFD9UDpirmT4SKinAdShEZLE6pNhAFnGsJSr9dkCxrbDr196hxwVU2aQr40+tMqdmk6RpZtWc8UmLYMCFXWEgCeHgs3276WavyRxqCDX8jqElrAinjGSiiAaiOia+kMt9XKCviKPjb1wBUOdOvlmQ1Tk9En50vVQPAmRE19yIKWxram7rbfZJN9dLz+iA4kMgXKth8fKqANS+/gSpIQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE5FUbqKtT7td9gHFmBDFggWJ40+UPScoS7yf0Wmjeo=;
 b=UWIiS/6aUmFu5bcuT25wQdWDgpT1dDbw4o8f44O6UwiWOdUuRrqaOUr/qaHKGg8nkPGc7j/kvKSzz+atx9kjka2DXwk5hQA6SSMkL+rFOOttDuIQhE9R+3755gkvav8KsDAuECBcBI/yYCoJjliS/GvF+Ik8RYvWZKObilFyRD4=
Received: from DS7PR03CA0311.namprd03.prod.outlook.com (2603:10b6:8:2b::23) by
 PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 04:35:14 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::fb) by DS7PR03CA0311.outlook.office365.com
 (2603:10b6:8:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 04:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Wed, 22 Feb 2023 04:35:14 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 22:35:02 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add ecc info query interface for umc v8_10
Date: Wed, 22 Feb 2023 12:34:51 +0800
Message-ID: <20230222043451.25463-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 20467a2d-3f29-4ab3-4ada-08db148e30de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFuNkAf++HrsfoWcd7eLHqiutdQ58fRdinqgQXY79f+i890UkeXEa/GHI3m9YiUEayoBphxlDJO/nzJotBYQ0VVReII/a7KlyPurE2r31+ugscwCifAp8VrpwzAVKGfb7lcO+CvNGHsfMhIQGT8IEUZKvy6rmIzfrP02S6zQRlE1qD2LagHf40uSanzh7ratlKj2oh0KkMLgL6qMB98iBgXjz0B4zbiWXj/NtMMYigqFz279KhSn8DTpMsjADXzGCFBpT7H255IpHRnpqCX0SHYfM4ud+jrfF8pS3Ktqu2BBTZN6/BOG3R08HNKFlONHGLTofICZ4T8dVV8HS59JYUSDOcqN5wxzR3jA9stR1f/LxvQBj5ZjddoPhdWQcbSvyEArB3NXrRKpFTPYg/jejtdg7gmnQYmwUCj+MKQY3XiuL9DqIdsui1viAxQHY6hXVccHu7J/cKml5HD5Ytzor3cWyFdX9RrtDP4IAQWw2RX8ShEVOf4kSnBRhNagRHjOnRf951QheslHDcO/tg3hRcGZq1EuSzNO/y3S9p6C+a9rSKZWY3QOCFH4kbPC63iQD5lXNOdr3aAbtvmQJ4lHvWfIMxPSlb6TQybxBHZeZNPtvjvI6h2I32VCm5Cgw0R49M12U6SzOq8NrI5I/apQ0iIPmVPkzDn9hq8cbm5YVNXe2WW76fTo0p7obgkE23UUZ3o6p6NUc/qnsm74JjkGJX8n7L7zR/Bol3eFfWsb8Zo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(8936002)(7696005)(5660300002)(83380400001)(47076005)(41300700001)(426003)(44832011)(86362001)(8676002)(16526019)(26005)(186003)(1076003)(6666004)(70206006)(336012)(4326008)(70586007)(6916009)(2906002)(316002)(2616005)(478600001)(356005)(36860700001)(36756003)(82740400003)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 04:35:14.0061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20467a2d-3f29-4ab3-4ada-08db148e30de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support ecc info query for umc v8_10.

v2: Simplied by convert_error_address.
v3: Remove unused variable and invalid checking.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 134 +++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index 293ba39c8a2fda..66158219f791cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -360,6 +360,138 @@ static bool umc_v8_10_query_ras_poison_mode(struct amdgpu_device *adev)
 	return true;
 }
 
+static void umc_v8_10_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
+				      uint32_t node_inst, uint32_t umc_inst, uint32_t ch_inst,
+				      unsigned long *error_count)
+{
+	uint64_t mc_umc_status;
+	uint32_t eccinfo_table_idx;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	eccinfo_table_idx = node_inst * adev->umc.umc_inst_num *
+				  adev->umc.channel_inst_num +
+				  umc_inst * adev->umc.channel_inst_num +
+				  ch_inst;
+
+	/* check the MCUMC_STATUS */
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
+		*error_count += 1;
+	}
+}
+
+static void umc_v8_10_ecc_info_query_uncorrectable_error_count(struct amdgpu_device *adev,
+				      uint32_t node_inst, uint32_t umc_inst, uint32_t ch_inst,
+				      unsigned long *error_count)
+{
+	uint64_t mc_umc_status;
+	uint32_t eccinfo_table_idx;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	eccinfo_table_idx = node_inst * adev->umc.umc_inst_num *
+				  adev->umc.channel_inst_num +
+				  umc_inst * adev->umc.channel_inst_num +
+				  ch_inst;
+
+	/* check the MCUMC_STATUS */
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
+	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1)) {
+		*error_count += 1;
+	}
+}
+
+static void umc_v8_10_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
+					void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	uint32_t node_inst       = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+
+	/* TODO: driver needs to toggle DF Cstate to ensure
+	 * safe access of UMC registers. Will add the protection
+	 */
+	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
+		umc_v8_10_ecc_info_query_correctable_error_count(adev,
+							node_inst, umc_inst, ch_inst,
+							&(err_data->ce_count));
+		umc_v8_10_ecc_info_query_uncorrectable_error_count(adev,
+							node_inst, umc_inst, ch_inst,
+							&(err_data->ue_count));
+	}
+}
+
+static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
+					struct ras_err_data *err_data,
+					uint32_t ch_inst,
+					uint32_t umc_inst,
+					uint32_t node_inst)
+{
+	uint32_t eccinfo_table_idx, channel_index;
+	uint64_t mc_umc_status, err_addr;
+
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	eccinfo_table_idx = node_inst * adev->umc.umc_inst_num *
+				  adev->umc.channel_inst_num +
+				  umc_inst * adev->umc.channel_inst_num +
+				  ch_inst;
+	channel_index =
+		adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_num *
+						  adev->umc.channel_inst_num +
+						  umc_inst * adev->umc.channel_inst_num +
+						  ch_inst];
+
+	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
+
+	if (mc_umc_status == 0)
+		return;
+
+	if (!err_data->err_addr)
+		return;
+
+	/* calculate error address if ue error is detected */
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) == 1 &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1)) {
+
+		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
+		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+		umc_v8_10_convert_error_address(adev, err_data, err_addr,
+					ch_inst, umc_inst, node_inst, mc_umc_status);
+	}
+}
+
+static void umc_v8_10_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
+					void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	uint32_t node_inst       = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+
+	/* TODO: driver needs to toggle DF Cstate to ensure
+	 * safe access of UMC resgisters. Will add the protection
+	 * when firmware interface is ready
+	 */
+	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
+		umc_v8_10_ecc_info_query_error_address(adev,
+						err_data,
+						ch_inst,
+						umc_inst,
+						node_inst);
+	}
+}
+
 const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops = {
 	.query_ras_error_count = umc_v8_10_query_ras_error_count,
 	.query_ras_error_address = umc_v8_10_query_ras_error_address,
@@ -371,4 +503,6 @@ struct amdgpu_umc_ras umc_v8_10_ras = {
 	},
 	.err_cnt_init = umc_v8_10_err_cnt_init,
 	.query_ras_poison_mode = umc_v8_10_query_ras_poison_mode,
+	.ecc_info_query_ras_error_count = umc_v8_10_ecc_info_query_ras_error_count,
+	.ecc_info_query_ras_error_address = umc_v8_10_ecc_info_query_ras_error_address,
 };
-- 
2.17.1

