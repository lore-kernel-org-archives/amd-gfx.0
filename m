Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53632CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 04:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7336C10E408;
	Thu, 12 Oct 2023 04:58:31 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E23910E405
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 04:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZPCNK+bq+hzV4Ececdl/I4pMo5wCGd/gH877+CUVtyXZD7xvsbffh/B1StBBxuV/Sh0w3drI6drjsFs6IaHFXdYE2qPTut6nkdKcqumrcRyDC7WsDieJxHkdjGPG9/Ou/idH5GivsW8gTllgSpiALqu8x0mg+Nud7aGzljT8On0AwexCe9rGCfXjmpxL6lNy6v8ij7Mg+Oi/ZlbP7s9KmOY1OQwh5v6zi0MwTg0+mv9jrhSGV2x3PZSTY8OzEh3YgGauuT+fJfxTVn8yEOeRDoY3zunyxB54CtmU2VGIGevSvqKGa+LCS6pKJ6CsfYYjWRPLE0PZU/s1V9r4BykCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/maVKdJ4AtLLP+jzotR9YjzG5yzlunQ9gtWMJYp29M=;
 b=FoTaG0VlJJH60lCP9zzahDZmHhKtT3qQxP5xhN6jNuB2y4v15PonKSI3052QQnoidrvMmNWg2JfkmTjolre2xH01AvF8j1cQ1QSv6wSSsdkMgSOu5Cl6GRb2TLIPaYSRtFeHGfst46RmbHK7/3zuUHchamZI+WX5z6c/O5iTka5opKSOqEOCjPNcoeJH3ViE1XOfp3vovoR/hxJnNSOgewnqkH6JlmmNS8qHoyF7xQpCm5xE6fPpw8y2ssevXK+IvxL9NGmqQghKxxtQPDR6ZMhGXcSR/HqzpS/frS2x2cnwyvEqqLcQQ27rd5EDgB71ySOTRswpOSrOpUOLSWQehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/maVKdJ4AtLLP+jzotR9YjzG5yzlunQ9gtWMJYp29M=;
 b=MB/gHGE5jprrhL7A7BDSfPTdsFgzxxRrkTTsxzGOYZzfECl5RRvz6knjqOjefv4d0YAToQ4wNus3VeB2iTeJ8FOLNzllewkC6WK71sLaC4JDUdR9fEhS7i4IxA7DbFnooMyKoEewFmLleas/PGIo09RQ3SsvJMRZjXJwpSY7qNg=
Received: from MN2PR01CA0029.prod.exchangelabs.com (2603:10b6:208:10c::42) by
 CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 04:58:27 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::a4) by MN2PR01CA0029.outlook.office365.com
 (2603:10b6:208:10c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 04:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 04:58:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 23:58:24 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6
Date: Thu, 12 Oct 2023 10:27:55 +0530
Message-ID: <20231012045755.111418-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012045755.111418-1-lijo.lazar@amd.com>
References: <20231012045755.111418-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH0PR12MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: dda80954-01ca-46dd-bb01-08dbcadfdf28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7uiWb/FHjikwmQzTfBfs9Q61KsYBAaRy4XEzmNMTsxSOLMdoq2qycTbvJawL+RO5GZqLITKHMUFO9OAPG2GF3DMr/C3aFWMLNihk5uChZCXm/5+ztMMdhjp1xINtRSt49SqBN/pu16xzHD958noJucjHIUjsB3uGjiygzXDL+/8qvCWMbaWvzI4flQNf8Gk6SiTnCi3uZvKDTncO5Q/YAuThhQ+2uBgHW1wsE1TLk3YLS4jkXuqmgwaQEPpEIWfz69LhWh46ovMlSzbi1OXtnuENhm7BH6UVqu13r2vf2XamxnxcHndmtsKZ7Qxny5oD6WMTolrhwIrbSFhzykSTHs9D+m0A1QLFEVevxsGFY41n7UlC23qqeEFGEy1Ei951F/hf3z4zEXlRZkkDW62q5CvXC4gq8qnjN0aQ790FjUt/1bfWlY6tDoagE6BNjDQd9KkI3x1ACSfzwEar6QrJlocWXS/ZCW+iLnh5uF0Hrqjig7vPHdu7Hfari9SiMVkxIKQSQfemmFkZkP2gjF1G8SK0pb7l3pMTIKU1Aj1hjvA4gilD6w6ylewwqquu1r0QWbYMoH55ORz0zE9x1UIKHx8bVTkkhbAMlWEDZpQgjluyUosCR9jXj44IyYHBJGS70C64vvJI1Xf4opr7gSVJdCuQDs6/M00TPY2FF8dvGtVTg0Tkj6O9tNBe/gPfEwxT9O8gmShAaYE+E8CAArqz0I1aLjx7NodYNzIoz2YbNphd8739VVklakDqnHKlLSi5XDB8Wuv+ElVHMsRydMDOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(2616005)(6666004)(7696005)(26005)(81166007)(356005)(82740400003)(36756003)(86362001)(36860700001)(47076005)(16526019)(426003)(336012)(40480700001)(1076003)(83380400001)(41300700001)(316002)(70586007)(70206006)(6916009)(54906003)(2906002)(8936002)(5660300002)(8676002)(4326008)(44832011)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 04:58:27.3094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda80954-01ca-46dd-bb01-08dbcadfdf28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
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
v2: Fixed MP0 IP version check (Hawking)

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  7 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 71 +++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c41bd07f3f98..7158d478eeea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2516,6 +2516,13 @@ static int psp_load_p2s_table(struct psp_context *psp)
 	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
 		return 0;
 
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
+		uint32_t supp_vers = adev->flags & AMD_IS_APU ? 0x0036013D :
+								0x0036003C;
+		if (psp->sos.fw_version < supp_vers)
+			return 0;
+	}
+
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8220bdcbd927..d29740bcdc8f 100644
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
+	const struct common_firmware_header *hdr;
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
+	hdr = (const struct common_firmware_header *)adev->pm.fw->data;
+	amdgpu_ucode_print_smc_hdr(hdr);
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

