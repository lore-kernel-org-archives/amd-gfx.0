Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E0C001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635A110E0E4;
	Fri, 28 Jul 2023 16:39:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC5A10E211
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3O0+ZDZl+RVm+ou+0SpRDf/s4TSl3n4X76g44dXS9DDWHSdwScU5xlSP0bswCNyiUiREokXPpRz57giwJkD9uXruw9LbdYg28MSR7zI/sEpajiQYmCMMXYw1ByjLt7YyZwVUdFuj0hnFncy1Nv2U0Yo+1saWeEKK/C1kZtOm/la7oAYrIokOT+h0x0wGwIzoC3xpFTsWNKLR2kuj+AxmpiKH2LmMCgQ0roaDTZbjzQOUQHxO99Xy9glk1fhIGHMmBMyLoU34R8JgMsDHfPLU1DHKeZ+Ohe5XVOw0v99GdAdx6OHHfcS06S4XWR0SieJA+0lWGqkbTe6D5Ah+PBgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk92Oy0j7W4eWqTfgRE3g23KrGCSWNGZvRQ7MlV0NDE=;
 b=Qz25MSGEsBzjgfNizTfqOxyUKBAAgJfHCkgqo9X2qeixNsJbAolMZMFtw9/3ZbNfra8TrJVsliQm4zKDeV/Tx2iiZbLWqtl5jUMny/DqB65ju7I1wiSHgiftjIiMoOjSzWQkYtzZWQ7kwl1sRxEznL26edtCJwqU1S612GpZd/CmR38yY4B8iS/xgZMIRGxhSyuuRpePPTYlxmWDubMn0JflmapcvXrOSmrc/a1iDWi6I7/UH2jRBGE8Pltem4fI1YSICNjf/ig2xLU/ebh8o48wGXCJo6ReL8p5igxg1cpNe7DjwVEyeqwvHLFo9ZLaW26evA5a+NFFdeZhTB2X3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk92Oy0j7W4eWqTfgRE3g23KrGCSWNGZvRQ7MlV0NDE=;
 b=fCZVuoCcmShJqMzKn6mqv7WhsgIaiQQdj/kJYfo66t0qE2s1yULHbvqEqbqOESXdvMnfHA7C1wHfyQbhudmWyJDAUNnPHcYspY0XmnuzfOnQvjVb67luZ7n2ueqGA3kVQdzpkcYDScT47DsmWLFphYge9meW1IkaxN1XAV+3wY4=
Received: from DM6PR11CA0043.namprd11.prod.outlook.com (2603:10b6:5:14c::20)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:39:52 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::56) by DM6PR11CA0043.outlook.office365.com
 (2603:10b6:5:14c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 16:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 16:39:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:39:51 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 28 Jul 2023 11:39:49 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <KevinYang.Wang@amd.com>,
 <Lijo.Lazar@amd.com>
Subject: [PATCH v4] drm/amd/pm: check whether smu is idle in sriov case
Date: Fri, 28 Jul 2023 18:39:39 +0200
Message-ID: <20230728163939.652850-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: f81fbaab-c05b-4ab7-2ac6-08db8f894427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oa5IVnMOOefR0UsmcDZXMjRLqsxQOpIHBZfpHsP6CkfKzx4JVBVQrBNvpEqCMluplXA7TrZeQ+cHRnG5IVeL7IO460xADi9LyF6w/Gygk0mHQYp7SaRFLbBppWED8Oh0zcMTXKjDNBYAeaDeQ1AlUIUOpaPQrpiV7D7yPV2H2ltkUS6YMVX1Z+NrrBRR4tYXFT9mFsjFr3fmMEGnRxhhWUZA9QuQVvOA+lH6hJSrUR3qaAHcLRCQePYRtiQAXfuYbM7agpEe25NBfUBDcdWfOaTce+y5rpCd8cVN41FW1M7nC30JZyXlxb3rw2BKooNAq+1LjYATQxRWBy4jL1tG/79UjLOr8NkVtaC0sB3NR5lZRA7rP4oC2pBx5iUv6zNDmxw7EHgTHTkqUfaVp1yprV0Oe6YSFh3vbxs5n9fOpPorEUCiED9uMAfQEaA0BS+iXbvldCn7yNVGLAGZeyH5FXGbHHWxTRdKgqrnZm/BVykdhmXOy8lG1CTy52NjmUP9gyT2Mckmi+5TYdkcsGiqEiRno1cef/+MSNLuon4azuScQI5U1wUNkYgTOj9Y2L5lYE++7Zi+DjX6VZdaPtzEIMaow0EOODhI5h0gW/+o4LXbIkiTN9a1miasTBuVdjpLH0loS/xNO+AHWuM82i3+yHMCrRpSgVxMEAXDiQwVwvybV67ZDJ8QA+rKEjkKjtK1Qkn2Yn7OlhL2Dnv9C5EHp77NnZbnWhU4Jw2ody59SfUwgIvhPL7CzHa3cbMjl1gKAv7Cw8AnNeF1PxKXkd6B1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(36756003)(86362001)(2906002)(44832011)(40460700003)(40480700001)(47076005)(186003)(83380400001)(426003)(36860700001)(336012)(2616005)(1076003)(26005)(81166007)(356005)(7696005)(478600001)(54906003)(6666004)(110136005)(70206006)(4326008)(8936002)(5660300002)(70586007)(316002)(8676002)(6636002)(41300700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:39:51.8985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f81fbaab-c05b-4ab7-2ac6-08db8f894427
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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
Cc: Danijel Slivka <danijel.slivka@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Nikola Prica <nikola.prica@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Why:
If the reg mmMP1_SMN_C2PMSG_90 is being programed to 0x0 before
guest initialization, then modprobe amdgpu will fail at smu hw_init.
(the default mmMP1_SMN_C2PMSG_90 at a clean guest environment is 0x1).

How to fix:
this patch is to check whether smu is idle by sending a test
message to smu. If smu is idle, it will respond.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
Signed-off-by: Nikola Prica <nikola.prica@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: pengzhou <PengJu.Zhou@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 18 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 43 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index aa4a5498a12f..a9e1bc55f15f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -184,15 +184,25 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t mp1_fw_flags;
+	int ret = 0;
 
 	mp1_fw_flags = RREG32_PCIE(MP1_Public |
 				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
 
-	if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
-	    MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
-		return 0;
+	if (!((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
+	    MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT))
+		return -EIO;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = smu_cmn_wait_smu_idle(smu);
+		if (ret) {
+			dev_err(adev->dev, "SMU is not idle\n");
+			return ret;
+		}
+	}
+
+	return 0;
 
-	return -EIO;
 }
 
 int smu_v11_0_check_fw_version(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3ecb900e6ecd..a58b6e3c0a52 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -313,6 +313,49 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
 	return res;
 }
 
+/**
+ * smu_cmn_wait_smu_idle -- wait for smu to become idle
+ * @smu: pointer to an SMU context
+ *
+ * Send SMU_MSG_TestMessage to check whether SMU is idle.
+ * If SMU is idle, it will respond.
+ * The returned parameter will be the param you pass + 1.
+ *
+ * Return 0 on success, -errno on error, indicating the execution
+ * status and result of the message being waited for. See
+ * __smu_cmn_reg2errno() for details of the -errno.
+ */
+int smu_cmn_wait_smu_idle(struct smu_context *smu)
+{
+	u32 reg;
+	u32 param = 0xff00011;
+	uint32_t read_arg;
+	int res, index;
+
+	index = smu_cmn_to_asic_specific_index(smu,
+					       CMN2ASIC_MAPPING_MSG,
+					       SMU_MSG_TestMessage);
+
+	if (index < 0)
+		return index == -EACCES ? 0 : index;
+
+	__smu_cmn_send_msg(smu, index, param);
+	reg = __smu_cmn_poll_stat(smu);
+	res = __smu_cmn_reg2errno(smu, reg);
+
+	if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	    res && (res != -ETIME)) {
+		amdgpu_device_halt(smu->adev);
+		WARN_ON(1);
+	}
+
+	smu_cmn_read_arg(smu, &read_arg);
+	if (read_arg == param + 1)
+		return 0;
+	return res;
+}
+
+
 /**
  * smu_cmn_send_smc_msg_with_param -- send a message with parameter
  * @smu: pointer to an SMU context
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index d7cd358a53bd..65da886d6a8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -50,6 +50,8 @@ int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
 
 int smu_cmn_wait_for_response(struct smu_context *smu);
 
+int smu_cmn_wait_smu_idle(struct smu_context *smu);
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index);
-- 
2.25.1

