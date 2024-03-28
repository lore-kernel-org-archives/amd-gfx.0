Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1CBC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 02:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D8C1122B7;
	Thu, 28 Mar 2024 02:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SH3q4e5v";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D611122B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 02:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJD1zKEj6G8xVFErI4dg7Tr27/AZMNwE4p90itACw96Q4VfcRmgWsUnnatFPsPQbiFgfm2cNItH83qPZSKQw4w8aS5B8RmA0xLXqEZjAZ277tdM2aa3UCTh8VZa/p95FhjkTxApgZY3NEhzxNT228ejWhXCDgi81WCTlK7f4XxNrhcxRaFKrC5P3b4C/3hADUkw0unqXy5wN/ugiI/rWT4LQ4wnYj7chXqI+ylnpyIYB+e5AaZZWdaZQh0NQgLCvCaNySMAThy4lfLhRknMTt6QGe7fDpS1Kn/UtyyvQhrv/2QL2OXyKd7P7QlAW4fspuVpAQTnhAqKM3cqJr8KR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfyAdnNI/dwhPMeMI51mv3x3am5kZFh6CS6WjMj3QGk=;
 b=gM57iL+SgrK/iqn1RwrIuER9IKf/4gIwZUJUcn8pazsQPyaqB3TUESXTQZPQTpFPqEfj2U0aGYXaHD9M5mGZoeOSbKVygHzH+4/8NjAhY7SitEgBOD0EzCyLPSqeeI8h80JIkaxKiGkBiwFKrQoLB4U7NVNeUvMPX4kNHsRe3jfRgJacWlff7HDfoPzxQ88hatO9I/0vRPKP1crLACZTB42wrsgU2bqwc39/awK21VZVcgIj47jeAdcO19e0TPHT6kGVXLsizT+C3EF5OjjORbWOyRrrd4cH6DFDkVGIJlYOutupABhu5KGLwwo+w94hgN4948nomn0A3LBWlwDZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfyAdnNI/dwhPMeMI51mv3x3am5kZFh6CS6WjMj3QGk=;
 b=SH3q4e5vHLP7/M/pbNOqrdapPFwiX7fn6/Aj/f3ddPP7B+Zl47SgxLvgPXXFpeSjUHa/5Qhyntg8wRoI8vdrSeC5aag1xWShdf/e275K/znNn0vRz8tAt1AcaSTHWWschDCSghzWKE3TWIpKnaqsVjIfyGlZ2nqrFm0AaGykKHs=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 02:36:08 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::7) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 02:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 02:36:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 21:36:02 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Set fatal errror detected flag earlier
Date: Thu, 28 Mar 2024 08:05:41 +0530
Message-ID: <20240328023544.820248-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ec908e-a0d3-4e8a-d149-08dc4ecfd28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpZ0iw3N2ZcxCnmFEikLL9QclgfMb7ITU1+bpYlyjQoyddhMrBwMJdFHzUSLAuz3hNKCt9Kn6kDExEDvK8uIeGqWAhtv/AbFGn2WDUauwGulU5PUYRMfJuqOhEuQACVLSA7hT4P3dTFdpYPeQ5BdZGZ28qx3jtBC7AkNH1RlJWHpQiATCx84ZNt4cnJXkY0i0fyRmjIFquffscbzKNBdKyebBIz93UBxDXih40o+LVvm1e49+PGmhK1jq8Wjip6ITM6dq+gIAeRU05qVDQib6JQVnEanGzFcXSpkIXOlqe04vcKD7QBpIbhfbFbkHvtyXZ0s7zCaphUvABwcPSqhG4HJeVC20Oo76eOtae5pRUvRV7ytFBycreG9NsFcoXMYdpENmjX/cDcWZtF+K5uyDtp6SmYimmB0qs6feXzZezjS66lE743H6o5it7dc1Sr8DXTFw549fL65pzKc33RN4TMzG8UprUxDXscN4OCizdp3CsAAUAA2Yl7vVuepcuS39meecad0fiJAxoo8lcUAUbx4nxKCvD4xP3RPxJmgJzp26j1zXK5MSGx3+boccgGWQUl2nPopV5lDFuwSR0+fpaSTe/vQJC3zE2javCJyw4uslyuhQz2Ti85oRDFYLLkZn9piiFf5SPgwqRkLE7Ov0B2aCppxE6xbE/rBVfpfv2/2jHNHBWHniS1N7UGSnRsv/iNXhmWH/reHU1jR4Q7oeA1Rj9qjIyutiFAevenRUt7tBYrKf83W0HOFK3w3eXBO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 02:36:07.7005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ec908e-a0d3-4e8a-d149-08dc4ecfd28d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

In case of fatal errors, set FED status when interrupt is received. Set
the flag on other devices in the hive before RAS recovery work.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Avoid accessing hive in interrupt handler as it may take mutex path (Kevin)

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 +++++++++++++++++--------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b8c7d0bf8fb1..352ce16a0963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2399,6 +2399,19 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 	return ret;
 }
 
+static void amdgpu_ras_set_fed_all(struct amdgpu_device *adev,
+				   struct amdgpu_hive_info *hive, bool status)
+{
+	struct amdgpu_device *tmp_adev;
+
+	if (hive) {
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+			amdgpu_ras_set_fed(tmp_adev, status);
+	} else {
+		amdgpu_ras_set_fed(adev, status);
+	}
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)
 {
 	struct amdgpu_ras *ras =
@@ -2408,8 +2421,21 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct list_head device_list, *device_list_handle =  NULL;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
-	if (hive)
+	if (hive) {
 		atomic_set(&hive->ras_recovery, 1);
+
+		/* If any device which is part of the hive received RAS fatal
+		 * error interrupt, set fatal error status on all. This
+		 * condition will need a recovery, and flag will be cleared
+		 * as part of recovery.
+		 */
+		list_for_each_entry(remote_adev, &hive->device_list,
+				    gmc.xgmi.head)
+			if (amdgpu_ras_get_fed_status(remote_adev)) {
+				amdgpu_ras_set_fed_all(adev, hive, true);
+				break;
+			}
+	}
 	if (!ras->disable_ras_err_cnt_harvest) {
 
 		/* Build list of devices to query RAS related errors */
@@ -2454,18 +2480,6 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 				set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
-				/* For any RAS error that needs a full reset to
-				 * recover, set the fatal error status
-				 */
-				if (hive) {
-					list_for_each_entry(remote_adev,
-							    &hive->device_list,
-							    gmc.xgmi.head)
-						amdgpu_ras_set_fed(remote_adev,
-								   true);
-				} else {
-					amdgpu_ras_set_fed(adev, true);
-				}
 				psp_fatal_error_recovery_quirk(&adev->psp);
 			}
 		}
@@ -3550,6 +3564,7 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 		RAS_EVENT_LOG(adev, event_id, "uncorrectable hardware error"
 			      "(ERREVENT_ATHUB_INTERRUPT) detected!\n");
 
+		amdgpu_ras_set_fed(adev, true);
 		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		amdgpu_ras_reset_gpu(adev);
 	}
-- 
2.25.1

