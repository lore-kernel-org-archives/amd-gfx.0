Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8594CD6E7E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 15:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0260D10E513;
	Wed, 11 Oct 2023 15:33:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D2810E513
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 15:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrI8wV52MWmL8vX5yd2Hs+KH2si86msmYZlSVyaKfOOxTTa1hehvJ4dF6KrJ8e+H60KnVibXtaibNZGQyJu/IrljvKx4aycNzetF5AsBz6uW9LvqKGQUn7zrwbPrASpbElgtwMdVVT5372klKeNDtNkaEvz+K0KevwTdntOHHNV2TqT7x6oNFrxPCmk/EuyrtZ3kMfNDQm+fvMm/T8cNu+wbfNeWVvEq1t4hrKRPQ7+2feBaDDhUavMEX0qZS1pt1et3ov/WcbZfut3+AEfdg6BhhR3LOhwGtdacfttMkL6WaBFZtO5sUzXjFhcxF0tnZYqxN/GpTTmR3AdiYX97ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EKQno59BVGyq/3uWjJOB/u7B4jbt/d6+KCjdhXJ2B4=;
 b=L9pq2c3rmp0sazMwh4Cy1W1THTIw2qJIDVT+CAvarL+00fs1OTYdZW6bPoB1QasGW6kXAPJTnfaw/Ke3LvO+5Ljv/4f//uePH97kVFCa9Ae3S0h3xdpANrTTF4AfdkoN9ifsBIK0yEr/TzpvsSFKIuId/yzcTxuxqSPUKUtMdNQNJIQuC47kWmOHw3BssPRbWoD/tFp6R5j9E//wF0qoHsTDP16qTCVckVKfbFsgBZC9syGA46oK5QrKOLxahhk5y/ezdVdIjfzN8D6uHkpEzocViYMV/li1tkiac2Y6LrrWT0DDDL0Wx0vZPS5MzWPVIYrbusI+ViUKNExPlfrj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EKQno59BVGyq/3uWjJOB/u7B4jbt/d6+KCjdhXJ2B4=;
 b=XKrLjZUzqTdxQQ1w2CkpiLhL44FhRTG083fv0unIV6t0x1j7BKhzCyjDwvFEGm++BkJ+lowPNtJgaJjK3gt894a+3W9SkxD211KF4WtSFwOwRc+rDh8j5wnTCg6PP3l0nbVVKFe5lNWI+5YD0W+SfDobwnh+s+cOWmusoebs9SI=
Received: from MW4PR04CA0151.namprd04.prod.outlook.com (2603:10b6:303:85::6)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 15:33:50 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::87) by MW4PR04CA0151.outlook.office365.com
 (2603:10b6:303:85::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Wed, 11 Oct 2023 15:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 15:33:49 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 10:33:04 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Add support to load P2S tables
Date: Wed, 11 Oct 2023 21:02:26 +0530
Message-ID: <20231011153227.97424-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f8490f-1604-4ff0-21ba-08dbca6f7774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQrA9haBeRUcxvJL/ZjJOPG6q4ewz2lNPFPFhXqs7M6gfJns+tjCJPYPpTBwFBS98wLPocn/doY3ybKD6LdJbFSxd6DNWBpO8ycOqASox1CBR78I0nZnh3Y5ZZyP8lj5TL4w7LcJYxN71NQHb+In++5qHE4Ri0og/+OsaennKuwp9WiIrwGOy/elGzmyYrv8VIzBRVj+ov7Q56ZznA1w6Zc3SYS7GlTz6OZ2A/bmTXnIpw4uKC3qijw8xPd1bnvfNBZg5/Ou6SBLW2UxEd2XkiiyewmimFEJGlmiR4tuJKSXqyDuhLt0Uk6mNqXbw9XqxsEIJcY//JJ9wjvv3NJh6QbPLLIOokxuv6iWrU0FFRROvhT29ZM4twrFFWoWuyFNGrAowEo858tJTN9LQbgufkTaVLdDuhxHzXGxHnRTqaHCVP0eA3MGbye+AnBLn9Mwds1MZcU10vLNzkRKFT0Sc0opzZmWR1Q1wDEny6PkEghOwRhIctjsnkYOSRWNKYe8sOWdmdSaGjMN66PybDO4T1ASRJycMF9eZwFCZ7Lw9mICg3fJfZ/lIfhySrvQX2m+VoHGVlEZeZTDqqPRzhJE73fqnETTFOWvB5gKOPPylMVNKVrW1+0tb1OmqaVNxYn6W2vnvO9a/z5bHbBjl3WjAdfjHuqlMmYdn43gjWObV35pEJiViC/P5eK6QZ0lfDeumK3LmuXR/VqBLVFmwvTkMIhRGRZT29toa5Wim/ayRBkyWp//9mfYOEwMQRiNDTLB+cVJy1AV5Q9nPPrfYEBpLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(36756003)(86362001)(1076003)(316002)(40480700001)(2906002)(70586007)(5660300002)(70206006)(2616005)(40460700003)(44832011)(41300700001)(6916009)(6666004)(7696005)(478600001)(54906003)(47076005)(336012)(426003)(26005)(16526019)(8676002)(36860700001)(4326008)(8936002)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:33:49.5931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f8490f-1604-4ff0-21ba-08dbca6f7774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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

