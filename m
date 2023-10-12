Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2D8CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 04:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B400710E405;
	Thu, 12 Oct 2023 04:58:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE01010E405
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 04:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eultIG5r5Okvwg4I6sRSPkpqKnarFUiGjA5nRHJ85WM5e407XAsxLqFk8l3rf+Iu1YT1NSox8OTLE6eZ5IjRbYVFo4tjlbcq6FnAWpa1X53dO5K0evaDLH5ce8ABp1qNC/RWp6e6r++Osr8TDcC4egzCfMpjTNFsaxsDF2tc88HKL/tgkJsI3qAaiEmEGXGglTcu7+VVPCjYBKWET+ZmVa7MVEaFg3Jd+kV8nGiJUkPNYaPEkg3A02IDHvgQ6RCkCztNAqizkRxGAlLrxux+CebsysPXRViF6tCLn7GalAW9Sl9c6fZ8Te310vtxpgq9/PaGuev1R0jwjCSosEnlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EKQno59BVGyq/3uWjJOB/u7B4jbt/d6+KCjdhXJ2B4=;
 b=DKMUWbRhdpW3kgoTCrCsdKXMesD+KyDso4Ge6Gqmlt05LhN/Y373eIgAA9DHCEk0wplg678Ucr8augo6hqFyVjZZuIOKMOHRtFX3jg4/p3C9KrlWjgK4osvimPSERgiRHAtJpphflZjKY6BEZ540KReIea9x4NzE77jKFM/0Ps0LcuPfSrYlxRGWMnMzU2rbHo2EG0tU56NHHpFIOzPaUIBUvKTDMxowZpK51F8M+IzkCA5AXejimkxhV87HhcEmTT7BdlHHTS5gVw8ejLWX0vGV9gqmn6IyI0XPb4F8v40U7JweRNdV0CHGXdhiucalD4kTXvcs+jSagxne99iUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EKQno59BVGyq/3uWjJOB/u7B4jbt/d6+KCjdhXJ2B4=;
 b=HbthVS1qFo9OFsiYozXDLcez2eEMws04wv+WcyCVBBFRM7+u4Mn3iU0mIUCdFymD9HEdf0Bt1J95TM4PU1k5xSQRpuue8CSTNYsVzHZLLZD5oaBOB3E8EgXcJjIaDBcIOrScWKdGT88zBKoEOjDYqa+4tOhE4cx3YE4Mh+LcMLs=
Received: from MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) by
 CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Thu, 12 Oct 2023 04:58:26 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::a5) by MN2PR01CA0020.outlook.office365.com
 (2603:10b6:208:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Thu, 12 Oct 2023 04:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 04:58:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 23:58:12 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdgpu: Add support to load P2S tables
Date: Thu, 12 Oct 2023 10:27:54 +0530
Message-ID: <20231012045755.111418-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 411415a0-2e7f-4caf-eb60-08dbcadfde56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGVGhx6xT7gnIy80Wuk4V74F8SLbz2DDjHTSr/PwGouOdywmG5qbCzNFCqMo2h4vxHhqLsDNKoPcggKoDyJmyn2VfsFdg80T3ZS1Ps9tpMIqQ4jo4PdaR9KiBo88QtjhpWxZ9A2WDG/1MJn0qN5rGMjjGySav2v0D8tdR7eG1koU0YLCUwPhB0CyE3wq6BLdvzoYZl9LLYO3Eya5d38WOeNMxmP9KNKLry75IekSAPbCgXYdcFwqdGK0nqLwBkqLknz0o4l1kbLgd/kZKnAbOyhOSkHh17oZAHZh6xycAWfN5ScbanTeLOxVo5MKis5XVP3nH7+bZSXW8AYgHhTOK8l3Lt/jropdizOYOeXrZI4UjbUT/g+WAH+gySWAZaDbtWHm3hmgY+93P2URmYSZNbnTToO0YaHy6eU7Kz/4al33ETJZtQQMVrGojMurGYxEDMGvELrXPocHFIdHyI5zJbEel90/WiB00x7Hb8btIEI7ekPotJqkpeL8rWJILe6kiFcAnDVJQKBhPAzRrmKwTn7VbvyUUR5Hv0LA/c+/hlGYeSxbengHehhBnNHpmrxvoSUtzHNs3BzA41z0+E3zpXWuCJSg4C0dtxeREWZvumwnFlxNtLdN/dhyM7ZMM4yJRVQMS8td9V8/HDausQgcKjcQHCc9ZV6dIFKSMI9mXhN5+u6tjh0zZ0blx3B4dOTn6cgR8a3DqH0yAiVgzzZ0Hi7f91bKWzv4SbpWFuBKBwnIOu4dRryFN3eRMq2XbhsXndoPFZ4cBwgBgEoEVbccxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(82310400011)(451199024)(64100799003)(186009)(40470700004)(46966006)(36840700001)(1076003)(40460700003)(356005)(36756003)(86362001)(40480700001)(478600001)(81166007)(82740400003)(336012)(36860700001)(426003)(26005)(47076005)(6666004)(2906002)(7696005)(16526019)(2616005)(44832011)(8936002)(8676002)(316002)(41300700001)(70206006)(6916009)(4326008)(5660300002)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 04:58:25.9344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411415a0-2e7f-4caf-eb60-08dbcadfde56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
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

Add support to load P2S tables through PSP.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 27 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 72ee66db182c..c41bd07f3f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2412,6 +2412,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER:
 		*type = GFX_FW_TYPE_UMSCH_CMD_BUFFER;
 		break;
+	case AMDGPU_UCODE_ID_P2S_TABLE:
+		*type = GFX_FW_TYPE_P2S_TABLE;
+		break;
 	case AMDGPU_UCODE_ID_MAXIMUM:
 	default:
 		return -EINVAL;
@@ -2503,6 +2506,24 @@ int psp_execute_ip_fw_load(struct psp_context *psp,
 	return ret;
 }
 
+static int psp_load_p2s_table(struct psp_context *psp)
+{
+	int ret;
+	struct amdgpu_device *adev = psp->adev;
+	struct amdgpu_firmware_info *ucode =
+		&adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
+
+	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
+		return 0;
+
+	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+	ret = psp_execute_ip_fw_load(psp, ucode);
+
+	return ret;
+}
+
 static int psp_load_smu_fw(struct psp_context *psp)
 {
 	int ret;
@@ -2543,6 +2564,9 @@ static bool fw_load_skip_check(struct psp_context *psp,
 	if (!ucode->fw || !ucode->ucode_size)
 		return true;
 
+	if (ucode->ucode_id == AMDGPU_UCODE_ID_P2S_TABLE)
+		return true;
+
 	if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
 	    (psp_smu_reload_quirk(psp) ||
 	     psp->autoload_supported ||
@@ -2591,6 +2615,9 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 			return ret;
 	}
 
+	/* Load P2S table first if it's available */
+	psp_load_p2s_table(psp);
+
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 771ef8017a98..606406c88677 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -642,6 +642,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "SMC";
 	case AMDGPU_UCODE_ID_PPTABLE:
 		return "PPTABLE";
+	case AMDGPU_UCODE_ID_P2S_TABLE:
+		return "P2STABLE";
 	case AMDGPU_UCODE_ID_UVD:
 		return "UVD";
 	case AMDGPU_UCODE_ID_UVD1:
@@ -922,6 +924,10 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode->ucode_size = ucode->fw->size;
 			ucode_addr = (u8 *)ucode->fw->data;
 			break;
+		case AMDGPU_UCODE_ID_P2S_TABLE:
+			ucode->ucode_size = ucode->fw->size;
+			ucode_addr = (u8 *)ucode->fw->data;
+			break;
 		case AMDGPU_UCODE_ID_IMU_I:
 			ucode->ucode_size = le32_to_cpu(imu_hdr->imu_iram_ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index ae5fa61d2890..4244a13f9f22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -510,6 +510,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_UMSCH_MM_UCODE,
 	AMDGPU_UCODE_ID_UMSCH_MM_DATA,
 	AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
+	AMDGPU_UCODE_ID_P2S_TABLE,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
 
-- 
2.25.1

