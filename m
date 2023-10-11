Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB17BCD6E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 15:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040C110E51A;
	Wed, 11 Oct 2023 15:33:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FD110E513
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 15:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApADJTmvccJUCdZdbxQ3fuI5Rf1NWJ2rQbaF2x3w7L29yZ4De24hXdws3POt++xNdz1xLzcnJdDL0Yzgsm0O81dnPx4uh64p4GWtexkeVVX8SrqC1xZ4tBEtG5iTn4aiad9btCbpSrehoMM2EbdHwVgFrsBRy8E0P4zkwfWjc4xbEd5woC+Tn/uGSJVbNeiE04W+V61IcNfibBMazi/K8tLQ/3RtDCjC2b905e3Luj+Fhk0QWkwroHiJsY3iew8kV/7Xtq4Vv6o3gb15iJEaGPPGoClU5ELgO7NphTp1WDm0ZJf0AqB7XZJC18/6aOROhXgjaL4W2lBJhN0NPVOwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omEv9BWnzslmdHXK5IvSBMpnlbZzSieUFBnvUMhTu4w=;
 b=JdXnYPG1m9v6AXa0Z4wqCRBmEPtqgXuwJsWpI+bK942H8JGz7RXerkZZa9Fy9lCHZaa/M+A1dCIlcuSymIR9Im51ghOXpeyb4uYmtvv5hBTU1UWzIIHGwi5xGAfzcj2ariACoBl3xE+KIa3jj9nMbCKPeWMl6+8wUrvRCtVxCHXClgVAUVStg0FPBvPDag3FKgPqizVM9YTHl66nwYedEDjXDhUpf75CpXb+hk7jWGTYMcsPcH4+H5z+weG1XE6bzORg5obsb92nTCPOBz2JSkqvE88Xv/eNCnJr6y4y2FCIKxZS3Y2dV9inFr1IExMfsEbgzmHvLn38RzJwSkQA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omEv9BWnzslmdHXK5IvSBMpnlbZzSieUFBnvUMhTu4w=;
 b=HNHwcOH0EsBq2lQ6AtwX/0R91l7BDpFzcppuECLBVC6K+tt7RAEkSMcJXPr6qjJv1nwXBWMhqta6qnOCubWoB2brPgZa0pENH5DF0xo1jN/CnyiXGrV7RMBGe49kTnExqgt72BO6dY4jVN9tmIj7elyvaz3v0w0zD4EgReW+C4A=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Wed, 11 Oct
 2023 15:33:50 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::5d) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Wed, 11 Oct 2023 15:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 15:33:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 10:33:06 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6
Date: Wed, 11 Oct 2023 21:02:27 +0530
Message-ID: <20231011153227.97424-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011153227.97424-1-lijo.lazar@amd.com>
References: <20231011153227.97424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cea61e-4770-4d5a-af95-08dbca6f77e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fN1gnd9+N8d3jVHepc6nhUjwiH37tq/sbtUFFdIRen23LyuKiYgXQKSK/dGWlbdH8XfyI0KCqU8J67h4zjJFcGxEuKjc81Q5v71LONA1swEONdl1eITpi24+6mtK5Ka8mbiNTy7Fjwbrtybn/2oHiOjh1X8elUtyDoCboh8XB14JOb+aS4wFF6/xfvjQT+6ypg922QPjpcrkXDZ2AtymgCH7jX+I1vVBgpakR7tbxoKEjDy/b+txgPTOArWo+BjTJR3IJexnOD0qp+6TV5Grt7ZmzbfkjWC8gEt4fHCbwsZeZFDxguWAuiOlHb8CL43uRrT4yasotBV5Vk8LLFFLPu9BlUo/5n29dMnK127z3kltF57YT6cclAmLLme7Zw7C4FENEW7VCxgSWG02ZAOrcZ2Rf9AwNLgsMyOIQjDDMOLf5i+vb2p908gBK0NrvExFeIj0itnEefX7yOy1MnmiuZDbesAMAWN71dmsaKgBdsfiLcqRZ4r6g1bp5V8uwaBURBAIyoAgGqQxRaEd9BB5DjocFoqOBDsa9IlLRpmN3KUutTODlzhVSfmnyQSVLJuTEJV/IaIX/noS9WFyLDAwQGccdDJEOa9I4MHLphI6Xf4iEq79hCAW5teAsjMIhNPciORXs6v6mfxhHkm1jgm40a9y0GkcZsGAdVsEuYZgKAV7ohO3aY2f0obqlQeX6YlHlArpCQY7rPSDMV7eivSWcBeZ31BLPBHGjf3SkQecgE15geD5235uU4OOZdTPK4iI4Tx9yAcdS6GCGbD+MxY7fQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(426003)(2616005)(83380400001)(336012)(40460700003)(40480700001)(1076003)(7696005)(478600001)(6666004)(86362001)(47076005)(36860700001)(81166007)(82740400003)(356005)(26005)(16526019)(2906002)(8936002)(316002)(36756003)(6916009)(54906003)(44832011)(70586007)(8676002)(4326008)(70206006)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:33:50.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cea61e-4770-4d5a-af95-08dbca6f77e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add P2S table load support on SMU v13.0.6 ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  7 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 71 +++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c41bd07f3f98..49e914ee6efe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2516,6 +2516,13 @@ static int psp_load_p2s_table(struct psp_context *psp)
 	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
 		return 0;
 
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(11, 0, 6)) {
+		uint32_t supp_vers = adev->flags & AMD_IS_APU ? 0x0036013D :
+								0x0036003C;
+		if (psp->sos.fw_version < supp_vers)
+			return 0;
+	}
+
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..a295403e2a09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -65,6 +65,8 @@
 #undef pr_info
 #undef pr_debug
 
+MODULE_FIRMWARE("amdgpu/smu_13_0_6.bin");
+
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
 #define SMU_13_0_6_FEA_MAP(smu_feature, smu_13_0_6_feature)                    \
@@ -123,6 +125,9 @@ struct mca_ras_info {
 			     enum amdgpu_mca_error_type type, int idx, uint32_t *count);
 };
 
+#define P2S_TABLE_ID_A 0x50325341
+#define P2S_TABLE_ID_X 0x50325358
+
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -256,6 +261,70 @@ struct smu_v13_0_6_dpm_map {
 	uint32_t *freq_table;
 };
 
+static int smu_v13_0_6_init_microcode(struct smu_context *smu)
+{
+	const struct smc_firmware_header_v2_1 *v2_1;
+	const struct smc_firmware_header_v1_0 *hdr;
+	struct amdgpu_firmware_info *ucode = NULL;
+	struct smc_soft_pptable_entry *entries;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t p2s_table_id = P2S_TABLE_ID_A;
+	int ret = 0, i, p2stable_count;
+	char ucode_prefix[30];
+	char fw_name[30];
+
+	/* No need to load P2S tables in IOV mode */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	if (!(adev->flags & AMD_IS_APU))
+		p2s_table_id = P2S_TABLE_ID_X;
+
+	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
+				       sizeof(ucode_prefix));
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
+
+	ret = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	if (ret)
+		goto out;
+
+	hdr = (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
+	amdgpu_ucode_print_smc_hdr(&hdr->header);
+
+	/* SMU v13.0.6 binary file doesn't carry pptables, instead the entries
+	 * are used to carry p2s tables.
+	 */
+	v2_1 = (const struct smc_firmware_header_v2_1 *)adev->pm.fw->data;
+	entries = (struct smc_soft_pptable_entry
+			   *)((uint8_t *)v2_1 +
+			      le32_to_cpu(v2_1->pptable_entry_offset));
+	p2stable_count = le32_to_cpu(v2_1->pptable_count);
+	for (i = 0; i < p2stable_count; i++) {
+		if (le32_to_cpu(entries[i].id) == p2s_table_id) {
+			smu->pptable_firmware.data =
+				((uint8_t *)v2_1 +
+				 le32_to_cpu(entries[i].ppt_offset_bytes));
+			smu->pptable_firmware.size =
+				le32_to_cpu(entries[i].ppt_size_bytes);
+			break;
+		}
+	}
+
+	if (smu->pptable_firmware.data && smu->pptable_firmware.size) {
+		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
+		ucode->ucode_id = AMDGPU_UCODE_ID_P2S_TABLE;
+		ucode->fw = &smu->pptable_firmware;
+		adev->firmware.fw_size += ALIGN(ucode->fw->size, PAGE_SIZE);
+	}
+
+	return 0;
+out:
+	amdgpu_ucode_release(&adev->pm.fw);
+
+	return ret;
+}
+
 static int smu_v13_0_6_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -2787,6 +2856,8 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_power_limit = smu_v13_0_6_get_power_limit,
 	.is_dpm_running = smu_v13_0_6_is_dpm_running,
 	.get_unique_id = smu_v13_0_6_get_unique_id,
+	.init_microcode = smu_v13_0_6_init_microcode,
+	.fini_microcode = smu_v13_0_fini_microcode,
 	.init_smc_tables = smu_v13_0_6_init_smc_tables,
 	.fini_smc_tables = smu_v13_0_fini_smc_tables,
 	.init_power = smu_v13_0_init_power,
-- 
2.25.1

