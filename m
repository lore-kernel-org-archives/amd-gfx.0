Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7EDC0032E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 08:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484C88928D;
	Wed, 25 Oct 2023 08:37:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81EB88928D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 08:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgQDzMvaEVG+w868NlkCg2iEForsGb25o2u90xmZTFHT3pcxT5whZkqAXPr2pLQdaoFKOeTUwsye44d2J8ORGv7VuaRxldSSFjwtQttCtFcYiFedrZJkY8+vl0okyEHnuOcU5nkvkmlouUKHrB9MnMioNLoWGI00C3N+is2lY80BvY+pSESFeQLiX5ePkN5MHoOr88yPvvg4ysnGgF+cNzneF/dChA67QMIn7UaTB/LrlG5FYitRDy98mJPABWzjvJFJEjZEFEh+SXlypWByS12fVKZ3xuT/efyu604Yy1SVLW55sqaH3pc7OeRSIKdiDnfuw4yk4BkNAhSC4gpD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4Y5okbdEJUPyoX2hKb9aypi+AJ2iaaksuXCkWId6SA=;
 b=hFrPGGXWER0E9xw1HeuBgbzEOzojOeV1LCwcnFw+ENww4VikRAySVGR/Sgt+7vHpcDksIZkq/bjZrvm+4yorP8HiHAWQfu9PCCwXYohVWkdBepswDPejeUFCMZTUeK8DW5D8pIXyPA87zzUlYM7s9N4uSYcB+Ibde6JyXlu0Z5TurO46XJM3Ob2f6kjWjildgBdlPPMI+TM0yDW3QP+qCZ6qYEh8yJqyudCnUMn5OoLa9i1DJexNhtQEXC7U3kTCLU8OdPLVHCwiVEIriz7Dt6pmE5gdj25VaqVFLJoiFQ/SHsyvuFXmCuFasg3HJ0jMNXzIpnsSfdVQ6f7RizF3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4Y5okbdEJUPyoX2hKb9aypi+AJ2iaaksuXCkWId6SA=;
 b=nP5JoxM0orv2ioxVcB/jVkMXs9P1hpzVOs0sVTWR+tOwrWMpNNhs6twRlkn/kVknNBaCEeVgRGqJto38EtgH8aBKkkRAagXIVeuq6RQ7PhAYwfW0nEqwMm72ovQG76fjgbeFFtggy/fmnZJ9UTaBXYDR1K4gF9r5bPYAeAjzQhs=
Received: from CYZPR12CA0023.namprd12.prod.outlook.com (2603:10b6:930:8b::19)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:37:42 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::eb) by CYZPR12CA0023.outlook.office365.com
 (2603:10b6:930:8b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 08:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 08:37:41 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 03:37:34 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: extend amdgpu_ucode_request() api to support
 formatting name
Date: Wed, 25 Oct 2023 16:37:17 +0800
Message-ID: <20231025083717.3355877-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: aba2dbba-2d6b-453a-7f2b-08dbd535a750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 48xeXFp0T1XR8ox5SRw7+XcTft0p1rdOB/uyCysLCUQ08PWiLApdddIiosAZgcN0ZgZunW9x0+OdOC0xaKYjnpBGtuDcjqy95iSJufsz9finTZq92vNHFwonBTGCDeE2qfJFt53NFZVL+vmeEBzFSlr5t/RY7aJp7QvkYR+ensnHt6yMiWprogMt6iMhGkPLhcKV5aBcyfaQMwztLV7DQezAP4ZtTxqzdwsQ65wVOxgdX8c/BTfzR8y3cxAPViq3v5Ckx2KaEPin5dO9E51Rooe84s4IdNobE048tqScEyWejEPqEj6Dca6l0Xt9HYsOoVGGIqrEwI+EYyz88xAPwBZqEhi0ExF7UW07ldA7fC7xBQ1N62FjUmOCsTbLjPueY5YhLy6IhTP+cRKubyKSg4QWDG6N5+iTDn59SvzabUkxSH7rzSbpru6ssR1bACfueuYVBZyZX5FzZGf/+TRgIUBflpI9JygjXcWznp2dIlHMwmslhIP0MwjtjbpA+IS7cfogz+zl2H/C4IWEVZmYZVSXjEJ+qbssCMWXNdZTC3+EsfvVswez0NGFwHb+GPw/wx2Mn0otsCI8KoWOT/a2lNJU1PW+QQ2xPUtJZyxrcfU33s0kt1gqlkgkywTlY/WPpPBfuE/EVx6+6vyq5hFPT1nTMjaTT55bjRjXiVcTlZqtmboHt0fZRZvAboxTTvmG1/aqOtusAjV2mss+9YKXQGD7FYRvcdLvqPr3NjsFpRbwzijvhOLInFLns6a7Mg0eXyONdRIp7mcKhKdSK2yRkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(30864003)(86362001)(40460700003)(1076003)(2906002)(54906003)(41300700001)(36860700001)(81166007)(316002)(70586007)(6916009)(82740400003)(16526019)(7696005)(478600001)(356005)(2616005)(47076005)(40480700001)(336012)(426003)(83380400001)(4326008)(36756003)(5660300002)(6666004)(8676002)(8936002)(70206006)(26005)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:37:41.9173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aba2dbba-2d6b-453a-7f2b-08dbd535a750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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
Cc: alexander.deucher@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

refine the amdgpu_ucode_request() api to support formatting type name as
input.

NOTE:
The new refined API is compatible with previous usage case and has no functional impact.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 12 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  8 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 23 +++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 17 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 15 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 21 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 58 ++++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 31 ++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 11 +---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 10 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  7 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  8 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  8 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  8 +--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  8 +--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  5 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  5 +-
 26 files changed, 110 insertions(+), 209 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cc047fe0b7ee..6e2edc382cd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2101,7 +2101,6 @@ void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev)
 static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[40];
 	int err;
 	const struct gpu_info_firmware_header_v1_0 *hdr;
 
@@ -2142,12 +2141,11 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		break;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw, "amdgpu/%s_gpu_info.bin", chip_name);
 	if (err) {
 		dev_err(adev->dev,
-			"Failed to get gpu_info firmware \"%s\"\n",
-			fw_name);
+			"Failed to get \"%s\" gpu_info firmware \n",
+			chip_name);
 		goto out;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7eede4747fe2..5a30e43f0145 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3075,12 +3075,10 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 int psp_init_asd_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *asd_hdr;
 	int err = 0;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, "amdgpu/%s_asd.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3099,12 +3097,10 @@ int psp_init_asd_microcode(struct psp_context *psp, const char *chip_name)
 int psp_init_toc_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, "amdgpu/%s_toc.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3250,7 +3246,6 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *sos_hdr;
 	const struct psp_firmware_header_v1_1 *sos_hdr_v1_1;
 	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
@@ -3260,8 +3255,7 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 	uint8_t *ucode_array_start_addr;
 	int fw_index = 0;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3486,11 +3480,9 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 {
 	const struct common_firmware_header *hdr;
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	int err;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_ta.bin", chip_name);
 	if (err)
 		return err;
 
@@ -3516,7 +3508,6 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 {
 	struct amdgpu_device *adev = psp->adev;
-	char fw_name[PSP_FW_NAME_LEN];
 	const struct psp_firmware_header_v1_0 *cap_hdr_v1_0;
 	struct amdgpu_firmware_info *info = NULL;
 	int err = 0;
@@ -3526,8 +3517,7 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 		return -EINVAL;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_cap.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, "amdgpu/%s_cap.bin", chip_name);
 	if (err) {
 		if (err == -ENODEV) {
 			dev_warn(adev->dev, "cap microcode does not exist, skip\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index e8cbc4142d80..9c9bd8310597 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -208,14 +208,12 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	const struct sdma_firmware_header_v2_0 *sdma_hdr;
 	uint16_t version_major;
 	char ucode_prefix[30];
-	char fw_name[52];
 
 	amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	if (instance == 0)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
+		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw, "amdgpu/%s.bin", ucode_prefix);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s%d.bin", ucode_prefix, instance);
-	err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw, "amdgpu/%s%d.bin", ucode_prefix, instance);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index b14127429f30..3ad9f1ffa176 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1391,12 +1391,20 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
  * the error code to -ENODEV, so that early_init functions will fail to load.
  */
 int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
-			 const char *fw_name)
+			 const char *fmt, ...)
 {
-	int err = request_firmware(fw, fw_name, adev->dev);
+	char fw_name[128];
+	int err;
+	va_list ap;
 
+	va_start(ap, fmt);
+	vsnprintf(fw_name, sizeof(fw_name), fmt, ap);
+	va_end(ap);
+
+	err = request_firmware(fw, fw_name, adev->dev);
 	if (err)
 		return -ENODEV;
+
 	err = amdgpu_ucode_validate(*fw);
 	if (err)
 		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4244a13f9f22..7ba0153961f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -581,8 +581,10 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
+
+__printf(3, 4)
 int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
-			 const char *fw_name);
+			 const char *fmt, ...);
 void amdgpu_ucode_release(const struct firmware **fw);
 bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
 				uint16_t hdr_major, uint16_t hdr_minor);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f4963330c772..7bf330a31cf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -88,12 +88,10 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 {
 	char ucode_prefix[30];
-	char fw_name[40];
 	int r;
 
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-	r = amdgpu_ucode_request(adev, &adev->vcn.fw, fw_name);
+	r = amdgpu_ucode_request(adev, &adev->vcn.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (r)
 		amdgpu_ucode_release(&adev->vcn.fw);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index e81579708e96..ae456a95937c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -50,13 +50,11 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
 {
 	struct amdgpu_device *adev = vpe->ring.adev;
 	const struct vpe_firmware_header_v1_0 *vpe_hdr;
-	char fw_prefix[32], fw_name[64];
+	char fw_prefix[32];
 	int ret;
 
 	amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", fw_prefix);
-
-	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, fw_name);
+	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, "amdgpu/%s.bin", fw_prefix);
 	if (ret)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index ee5dce6f6043..892ce40a285e 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -107,7 +107,6 @@ static void cik_sdma_free_microcode(struct amdgpu_device *adev)
 static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 
 	DRM_DEBUG("\n");
@@ -133,16 +132,15 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 	}
 out:
 	if (err) {
-		pr_err("cik_sdma: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("cik_sdma: Failed to load \"%s\" sdma firmware\n", chip_name);
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d9ccacd06fba..277543462d4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3959,7 +3959,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 
 static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
 	char ucode_prefix[30];
 	const char *wks = "";
 	int err;
@@ -3974,27 +3973,23 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		wks = "_wks";
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, "amdgpu/%s_me%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
 
 	if (!amdgpu_sriov_vf(adev)) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_rlc.bin", ucode_prefix);
 		/* don't check this.  There are apparently firmwares in the wild with
 		 * incorrect size in the header
 		 */
@@ -4002,8 +3997,8 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 		if (err)
 			dev_dbg(adev->dev,
-				"gfx10: amdgpu_ucode_request() failed \"%s\"\n",
-				fw_name);
+				"gfx10: amdgpu_ucode_request() \"%s\" rlc failed\n",
+				ucode_prefix);
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 		version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 		version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
@@ -4012,15 +4007,13 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
 	if (!err) {
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fd22943685f7..bb5edefd75e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -472,10 +472,8 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 {
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
-	char fw_name[40];
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, "amdgpu/%s_toc.bin", ucode_prefix);
 	if (err)
 		goto out;
 
@@ -514,7 +512,6 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
 	char ucode_prefix[30];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
@@ -525,8 +522,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
 	/* check pfp fw hdr version to decide if enable rs64 for gfx11.*/
@@ -542,8 +538,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, "amdgpu/%s_me.bin", ucode_prefix);
 	if (err)
 		goto out;
 	if (adev->gfx.rs64_enable) {
@@ -555,8 +550,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	if (!amdgpu_sriov_vf(adev)) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -567,8 +561,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, "amdgpu/%s_mec.bin", ucode_prefix);
 	if (err)
 		goto out;
 	if (adev->gfx.rs64_enable) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 34f9211b2679..724925734be7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -311,7 +311,6 @@ static const u32 verde_rlc_save_restore_register_list[] =
 static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 	const struct rlc_firmware_header_v1_0 *rlc_hdr;
@@ -337,32 +336,28 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	default: BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.pfp_fw->data;
 	adev->gfx.pfp_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.me_fw->data;
 	adev->gfx.me_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.ce_fw->data;
 	adev->gfx.ce_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v1_0 *)adev->gfx.rlc_fw->data;
@@ -371,7 +366,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		pr_err("gfx6: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("gfx6: Failed to load cp firmware\n");
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
 		amdgpu_ucode_release(&adev->gfx.me_fw);
 		amdgpu_ucode_release(&adev->gfx.ce_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index c2faf6b4c2fc..1a1f865cebb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -909,7 +909,6 @@ static void gfx_v7_0_free_microcode(struct amdgpu_device *adev)
 static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -934,40 +933,34 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 		BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
 
 	if (adev->asic_type == CHIP_KAVERI) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, "amdgpu/%s_mec2.bin", chip_name);
 		if (err)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 out:
 	if (err) {
-		pr_err("gfx7: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("gfx7: Failed to load cp firmware\n");
 		gfx_v7_0_free_microcode(adev);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 885ebd703260..dbc851eff222 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -939,7 +939,6 @@ static void gfx_v8_0_free_microcode(struct amdgpu_device *adev)
 static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -982,15 +981,12 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, "amdgpu/%s_pfp_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, "amdgpu/%s_pfp.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, "amdgpu/%s_pfp.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -999,15 +995,12 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, "amdgpu/%s_me_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, "amdgpu/%s_me.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, "amdgpu/%s_me.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1017,15 +1010,12 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, "amdgpu/%s_ce_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, "amdgpu/%s_ce.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, "amdgpu/%s_ce.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1044,8 +1034,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	} else
 		adev->virt.chained_ib_support = false;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -1093,15 +1082,11 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 		adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
-		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
-		}
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, "amdgpu/%s_mec_2.bin", chip_name);
+		if (err == -ENODEV)
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, "amdgpu/%s_mec.bin", chip_name);
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,"amdgpu/%s_mec.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1112,15 +1097,11 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	if ((adev->asic_type != CHIP_STONEY) &&
 	    (adev->asic_type != CHIP_TOPAZ)) {
 		if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2_2.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
-			if (err == -ENODEV) {
-				snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-				err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
-			}
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, "amdgpu/%s_mec2_2.bin", chip_name);
+			if (err == -ENODEV)
+				err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, "amdgpu/%s_mec2.bin", chip_name);
 		} else {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, "amdgpu/%s_mec2.bin", chip_name);
 		}
 		if (!err) {
 			cp_hdr = (const struct gfx_firmware_header_v1_0 *)
@@ -1195,8 +1176,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 out:
 	if (err) {
 		dev_err(adev->dev,
-			"gfx8: Failed to load firmware \"%s\"\n",
-			fw_name);
+			"gfx8: Failed to load cp firmware\n");
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
 		amdgpu_ucode_release(&adev->gfx.me_fw);
 		amdgpu_ucode_release(&adev->gfx.ce_fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e3ff6e46f3f7..6535e35b1164 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1249,23 +1249,19 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 					  char *chip_name)
 {
-	char fw_name[30];
 	int err;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
@@ -1282,7 +1278,6 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 				       char *chip_name)
 {
-	char fw_name[30];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
@@ -1300,16 +1295,15 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 	if (!strcmp(chip_name, "picasso") &&
 		(((adev->pdev->revision >= 0xC8) && (adev->pdev->revision <= 0xCF)) ||
 		((adev->pdev->revision >= 0xD8) && (adev->pdev->revision <= 0xDF))))
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc_am4.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_rlc_am4.bin", chip_name);
 	else if (!strcmp(chip_name, "raven") && (amdgpu_pm_load_smu_firmware(adev, &smu_version) == 0) &&
 		(smu_version >= 0x41e2b))
 		/**
 		*SMC is loaded by SBIOS on APU and it's able to get the SMU version directly.
 		*/
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_kicker_rlc.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_kicker_rlc.bin", chip_name);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -1337,28 +1331,25 @@ static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 					      char *chip_name)
 {
-	char fw_name[30];
 	int err;
 
 	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, "amdgpu/%s_sjt_mec.bin", chip_name);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
+
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
 	if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
 		if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, "amdgpu/%s_sjt_mec2.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, "amdgpu/%s_mec2.bin", chip_name);
 
 		/* ignore failures to load */
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
 		if (!err) {
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 362bf51ab1d2..6258a18663f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -364,15 +364,12 @@ static void gfx_v9_4_3_free_microcode(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
 	uint16_t version_minor;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -401,14 +398,12 @@ static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
 	int err;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
+
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 7f66954fd302..838a4da64910 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -98,7 +98,6 @@ static void gmc_v6_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 	bool is_58_fw = false;
 
@@ -129,14 +128,13 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 		is_58_fw = true;
 
 	if (is_58_fw)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/si58_mc.bin");
+		err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/si58_mc.bin");
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
 		dev_err(adev->dev,
-		       "si_mc: Failed to load firmware \"%s\"\n",
-		       fw_name);
+		       "si_mc: Failed to load %s mc firmware\n",
+		       is_58_fw ? "si58" : chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 61ca1a82b651..d74f3867001a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -130,7 +130,6 @@ static void gmc_v7_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -153,11 +152,9 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
-		pr_err("cik_mc: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("cik_mc: Failed to load %s_mc.bin firmware\n", chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index fa59749c2aef..574b3b0350ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -212,7 +212,6 @@ static void gmc_v8_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -255,10 +254,9 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
-		pr_err("mc: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("mc: Failed to load \"%s\" mc firmware\n", chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index c0bdab3bf0e4..cea12671cbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -40,7 +40,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[45];
 	char ucode_prefix[30];
 	int err;
 	const struct imu_firmware_header_v1_0 *imu_hdr;
@@ -49,9 +48,7 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
 	if (err)
 		goto out;
 	imu_hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
@@ -74,8 +71,7 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 out:
 	if (err) {
 		dev_err(adev->dev,
-			"gfx11: Failed to load firmware \"%s\"\n",
-			fw_name);
+			"gfx11: Failed to load imu firmware\n");
 		amdgpu_ucode_release(&adev->gfx.imu_fw);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index b58a13bd75db..3505803b1277 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -130,7 +130,6 @@ static void sdma_v2_4_free_microcode(struct amdgpu_device *adev)
 static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -147,10 +146,9 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
@@ -171,7 +169,7 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		pr_err("sdma_v2_4: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("sdma_v2_4: Failed to load %s firmware \n", i == 0 ? "sdma" : "sdma1");
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index c5ea32687eb5..661a6af43665 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -267,7 +267,6 @@ static void sdma_v3_0_free_microcode(struct amdgpu_device *adev)
 static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -305,10 +304,9 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
@@ -327,7 +325,7 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 	}
 out:
 	if (err) {
-		pr_err("sdma_v3_0: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("sdma_v3_0: Failed to load %s firmware \n", i == 0 ? "sdma" : "sdma1");
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index fc8e4ac6c8e7..8c8e0457d246 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7624,7 +7624,6 @@ static int si_dpm_late_init(void *handle)
 static int si_dpm_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -7684,11 +7683,10 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
 	default: BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_smc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s_smc.bin", chip_name);
 	if (err) {
-		DRM_ERROR("si_smc: Failed to load firmware. err = %d\"%s\"\n",
-			  err, fw_name);
+		DRM_ERROR("si_smc: Failed to load %s_smc firmware. err = %d\n",
+			  chip_name, err);
 		amdgpu_ucode_release(&adev->pm.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5a314d0316c1..27f85a0fc1d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -94,7 +94,6 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	char ucode_prefix[30];
-	char fw_name[SMU_FW_NAME_LEN];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
 	const struct common_firmware_header *header;
@@ -107,9 +106,7 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bcb7ab9d2221..18b62cd75fea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -92,7 +92,6 @@ const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
 int smu_v13_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char fw_name[30];
 	char ucode_prefix[30];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
@@ -105,9 +104,7 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9eb7c464662f..87e1c7f336dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -273,7 +273,6 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 	uint32_t p2s_table_id = P2S_TABLE_ID_A;
 	int ret = 0, i, p2stable_count;
 	char ucode_prefix[30];
-	char fw_name[30];
 
 	/* No need to load P2S tables in IOV mode */
 	if (amdgpu_sriov_vf(adev))
@@ -285,9 +284,7 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-
-	ret = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	ret = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (ret)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 4ac22f44d160..24df44a1f622 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -56,7 +56,6 @@ MODULE_FIRMWARE("amdgpu/smu_14_0_2.bin");
 int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char fw_name[30];
 	char ucode_prefix[30];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
@@ -69,9 +68,7 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
-- 
2.34.1

