Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1F0C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 09:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A40C510E208;
	Tue, 18 Mar 2025 09:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDR3ovbJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDB310E208
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 09:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSztDaMrjOwuk4AwEziQsIwmsCAEJGSCUMTglNSmniF5zXckULMlGhl9UBwbvDRxoasOzpDd/YDK1OEAOilzWQ3qx+LNp/ZCirn9wJtj0MA45XdMSjWW9VgrdaUOV2lfVjti5WF/NVJqj89m9k+9iZtgQkJCmvQbj4MhYAI+WDp1zLA0+cvjHLF1aeARDZ4DQTBguLbhwxYNgTXbBmNTsCC40iNYZhSRA8Fh+OJr12D9Cd0bD+gOodIfWc7SNqcNItZWiA0Kg8GDCD3vKle5dwRA6ySnmM9HEX2hOpOC/Siw77cWMXoW2Nv2MQt2eJXdIOo1j+c308CJS1G28rsWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckjx982WhpX75Cy67w8mLKV/xvhbzHteLDbQPRAEB3M=;
 b=hSNbazUe5z2rMN4GABc+M+k6jzNnlZLj5++ymN726NhApg6uWrh3KN7Dake6EXO08O8Rg1U2OeYcsXD3q1aqfQRCvhytNx1de0yHNY4RZo9CgkBXxsV3PMadUL4BVsJG7vhCQJC1L6qt2yHsALu1m7FGExiqGHJhakSa+jvc7hDTK005qNUAnxqKs5owwdgXaxOJbRUC5kFtuJMHb1ogP5hosgc7LX6AtHcpewsMhLuVveVz0CEZf++mMDFlKIK7VYnpw+ZRfWDLbE2lnH239DHjdD0EOYShur9JreXNWvR9ct3ErUKcLPv496941k/TWYQYhBmOH3rdv4PeB0/NUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckjx982WhpX75Cy67w8mLKV/xvhbzHteLDbQPRAEB3M=;
 b=KDR3ovbJBAjnH2/ck6d9uRJKhMzCGpPVsl4HejJM+MeUoCiNyTHg3xc7+KyiKed3Czznmc+rcJkFr5ni4ZO4y9db2NnkInmxUBOxMNvvfyCpMayhYzq2ITvupKS401G7keINK2WiZfi6WXdx7hmmV4+6xSewRlffLoUtMgo+e3U=
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 09:15:35 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::c7) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 18 Mar 2025 09:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 09:15:34 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 04:15:33 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Use correct aca handle to validate aca bank
Date: Tue, 18 Mar 2025 17:15:13 +0800
Message-ID: <20250318091513.544679-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: b01a4ac9-66a4-40c9-616d-08dd65fd7097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lbnhn89xpS4cqplne2HNIcstswxRjiEaNgfjhuLYXLkUiLrQyG5xWNtT0MTb?=
 =?us-ascii?Q?l+WmqBhyMvBrmRxPl2wZww2ETXvleuP7gkytNrdyR160rhI051f8qyDh2KQO?=
 =?us-ascii?Q?Qke3ie1AKyTeFSr7GQ1l63F7Fqcrm97vtBYqFd51sWcrkXAIAC6df/Yxd0Zl?=
 =?us-ascii?Q?1DFNr/2+QpRMTwXv8/JGAcQjop7x166E1rZTnJmxcWKwJqWWpJVV/VsZN76a?=
 =?us-ascii?Q?VsnoLPUyLYFR7W5TanjDKcdai0HUJiZ4aSEBKaM42TYOlUS0EbrOd+JFBxtE?=
 =?us-ascii?Q?uKBowv6ez27/7D65G5dYzoAv+fjVF8TTFH/dANKcPeEH+ChKsWUVJmOqc2pE?=
 =?us-ascii?Q?AnxyCNedb1bR7lWZLE+LRKkHnr4hVwS3a9CRPmU1H1e1x/rXkcaoPLALSN05?=
 =?us-ascii?Q?mqm9vGQBPAp4rYlFh6iNJZc7GNCOd3tpAkQr6iw4CavVm7GZtWGJoerdf9yZ?=
 =?us-ascii?Q?6byOxDyhXIHGHtcWUxIq2orerE4oiJfhL/wmpITsGvYv3BjBeJQ1DdlTMR5W?=
 =?us-ascii?Q?/VYIhwpuK2LYZnjaNCwItv84esSB1e0oGXZWpTeOIjLN+yXQKmRTz8n5vRw2?=
 =?us-ascii?Q?OBkXr+28hY4TiBfdrLyEzcg96Xn/GO3NzoY+R91I1tOrvWEK39U9Rz82mRF6?=
 =?us-ascii?Q?s5wO8s0rKQ4XEYN1JT5a0pZ1YmE97OUl4cf62Ur2mivNBbogPbtRpapk1U9P?=
 =?us-ascii?Q?rPGtMJUFzlaaxvzruWW4mvMRWSNt3Die6K7M2Y8MSP1I0CtcSUobikhbgta4?=
 =?us-ascii?Q?91GnMmewLXs/gQMN3xSEC43g8LZCxHSAFlU343PNlwXSjS/o607c9sxLQE5Y?=
 =?us-ascii?Q?jXkT2LHftIadztf9ZqfuX34YBiGsuFF/WG/tQ0m1y7atWj2Tk7s1o1WKhMYl?=
 =?us-ascii?Q?REMRcMUcoVbBVnjRYEcj+iAMulky/oYo8i1wmOuhM0+dgVMBiy6j/taDMYtE?=
 =?us-ascii?Q?XzE/q7j5dRg2qLiafORCbphiOSRLtWDsWByH26gcbaW31orKyokaY57BswVo?=
 =?us-ascii?Q?6g/s1r+Qan1zJECdljyhsxiov4pSbqbZV34LpBOGYQUPeXprWyFHopk8NB8m?=
 =?us-ascii?Q?FOOzONxbKYNCe0/XBPfIt4YWnkRPkjVi51rET5TmCRdMIbLNTpzr5NRsjOGQ?=
 =?us-ascii?Q?TI+m4fhOvpGXbwn94IFM4Ux2M62LOMybGPpjxXhikIFgNPXcbjJhbJJYMHHU?=
 =?us-ascii?Q?m/VaD048wVvvOJqVhrW1l3SLEil0/U3a5bEg4ZUi/pkCdCEkhNC+Pj5yHBo9?=
 =?us-ascii?Q?w/NV0GaCHZP7COB+ADF0xzW1TJuhvEdST07tbPr+3iYKClzp1Gba550CxEgy?=
 =?us-ascii?Q?dNyjgkXYgN7lcYaeKOGxqJTZwKfcRw9pGsdaaR7SNaX4gDHV6wskuOc2lTtI?=
 =?us-ascii?Q?wN3qBqZxn0QFtsolSoJFG++lN6HrkiwewdbuphSTv1mKmbCruK0fDA78u4di?=
 =?us-ascii?Q?MInZnoo/XQ15nmhMMY1YrcA33vmrOK1alP1+zlOfwbV8V1zVc3t4MCheknvE?=
 =?us-ascii?Q?Jjm5C9QomRwgZpE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:15:34.6110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01a4ac9-66a4-40c9-616d-08dd65fd7097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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

The aca handle is introduced by upper caller, it's inappropriate to
poll aca handle to match and validate aca bank, which will cause
unexcepted ras error report.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 122 ++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  10 +-
 3 files changed, 58 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index ffd4c64e123c..b07e101c545d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -122,6 +122,25 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, st
 			      idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
 }
 
+static bool aca_bank_should_dump(struct amdgpu_device *adev, enum aca_smu_type type)
+{
+	struct amdgpu_aca *aca = &adev->aca;
+	bool ret = true;
+
+	/*
+	 * Because the UE Valid MCA count will only be cleared after reset,
+	 * the aca bank is only dumped once during the gpu recovery stage.
+	 */
+	if (type == ACA_SMU_TYPE_UE) {
+		if (amdgpu_ras_intr_triggered())
+			ret = atomic_cmpxchg(&aca->ue_dump_flag, 0, 1) == 0;
+		else
+			atomic_set(&aca->ue_dump_flag, 0);
+	}
+
+	return ret;
+}
+
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_type type,
 				       int start, int count,
 				       struct aca_banks *banks, struct ras_query_context *qctx)
@@ -130,6 +149,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 	const struct aca_smu_funcs *smu_funcs = aca->smu_funcs;
 	struct aca_bank bank;
 	int i, max_count, ret;
+	struct aca_bank_node *node;
 
 	if (!count)
 		return 0;
@@ -159,14 +179,16 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_
 			return ret;
 
 		bank.smu_err_type = type;
-
-		aca_smu_bank_dump(adev, i, count, &bank, qctx);
-
 		ret = aca_banks_add_bank(banks, &bank);
 		if (ret)
 			return ret;
 	}
 
+	i = 0;
+	if (aca_bank_should_dump(adev, type))
+		list_for_each_entry(node, &banks->list, node)
+			aca_smu_bank_dump(adev, i++, count, &bank, qctx);
+
 	return 0;
 }
 
@@ -318,72 +340,29 @@ static int handler_aca_log_bank_error(struct aca_handle *handle, struct aca_bank
 	return 0;
 }
 
-static int aca_dispatch_bank(struct aca_handle_manager *mgr, struct aca_bank *bank,
-			     enum aca_smu_type type, bank_handler_t handler, void *data)
-{
-	struct aca_handle *handle;
-	int ret;
-
-	if (list_empty(&mgr->list))
-		return 0;
-
-	list_for_each_entry(handle, &mgr->list, node) {
-		if (!aca_bank_is_valid(handle, bank, type))
-			continue;
-
-		ret = handler(handle, bank, type, data);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int aca_dispatch_banks(struct aca_handle_manager *mgr, struct aca_banks *banks,
+static int aca_dispatch_banks(struct aca_handle *handle, struct aca_banks *banks,
 			      enum aca_smu_type type, bank_handler_t handler, void *data)
 {
 	struct aca_bank_node *node;
 	struct aca_bank *bank;
-	int ret;
 
-	if (!mgr || !banks)
+	if (!handle || !banks)
 		return -EINVAL;
 
 	/* pre check to avoid unnecessary operations */
-	if (list_empty(&mgr->list) || list_empty(&banks->list))
+	if (list_empty(&banks->list))
 		return 0;
 
 	list_for_each_entry(node, &banks->list, node) {
 		bank = &node->bank;
 
-		ret = aca_dispatch_bank(mgr, bank, type, handler, data);
-		if (ret)
-			return ret;
+		if (aca_bank_is_valid(handle, bank, type))
+			handler(handle, bank, type, data);
 	}
 
 	return 0;
 }
 
-static bool aca_bank_should_update(struct amdgpu_device *adev, enum aca_smu_type type)
-{
-	struct amdgpu_aca *aca = &adev->aca;
-	bool ret = true;
-
-	/*
-	 * Because the UE Valid MCA count will only be cleared after reset,
-	 * in order to avoid repeated counting of the error count,
-	 * the aca bank is only updated once during the gpu recovery stage.
-	 */
-	if (type == ACA_SMU_TYPE_UE) {
-		if (amdgpu_ras_intr_triggered())
-			ret = atomic_cmpxchg(&aca->ue_update_flag, 0, 1) == 0;
-		else
-			atomic_set(&aca->ue_update_flag, 0);
-	}
-
-	return ret;
-}
-
 static void aca_banks_generate_cper(struct amdgpu_device *adev,
 				    enum aca_smu_type type,
 				    struct aca_banks *banks,
@@ -417,20 +396,14 @@ static void aca_banks_generate_cper(struct amdgpu_device *adev,
 	}
 }
 
-static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
-			    bank_handler_t handler, struct ras_query_context *qctx, void *data)
+static int aca_banks_update(struct amdgpu_device *adev, struct aca_handle *handle,
+			    enum aca_smu_type type, bank_handler_t handler,
+			    struct ras_query_context *qctx, void *data)
 {
-	struct amdgpu_aca *aca = &adev->aca;
 	struct aca_banks banks;
 	u32 count = 0;
 	int ret;
 
-	if (list_empty(&aca->mgr.list))
-		return 0;
-
-	if (!aca_bank_should_update(adev, type))
-		return 0;
-
 	ret = aca_smu_get_valid_aca_count(adev, type, &count);
 	if (ret)
 		return ret;
@@ -442,15 +415,12 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 
 	ret = aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks, qctx);
 	if (ret)
-		goto err_release_banks;
+		return ret;
 
-	if (list_empty(&banks.list)) {
-		ret = 0;
-		goto err_release_banks;
-	}
+	if (list_empty(&banks.list))
+		return 0;
 
-	ret = aca_dispatch_banks(&aca->mgr, &banks, type,
-				 handler, data);
+	ret = aca_dispatch_banks(handle, &banks, type, handler, data);
 	if (ret)
 		goto err_release_banks;
 
@@ -537,7 +507,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 	}
 
 	/* update aca bank to aca source error_cache first */
-	ret = aca_banks_update(adev, smu_type, handler_aca_log_bank_error, qctx, NULL);
+	ret = aca_banks_update(adev, handle, smu_type, handler_aca_log_bank_error, qctx, NULL);
 	if (ret)
 		return ret;
 
@@ -730,7 +700,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
 	struct amdgpu_aca *aca = &adev->aca;
 	int ret;
 
-	atomic_set(&aca->ue_update_flag, 0);
+	atomic_set(&aca->ue_dump_flag, 0);
 
 	ret = aca_manager_init(&aca->mgr);
 	if (ret)
@@ -745,14 +715,14 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
 
 	aca_manager_fini(&aca->mgr);
 
-	atomic_set(&aca->ue_update_flag, 0);
+	atomic_set(&aca->ue_dump_flag, 0);
 }
 
 int amdgpu_aca_reset(struct amdgpu_device *adev)
 {
 	struct amdgpu_aca *aca = &adev->aca;
 
-	atomic_set(&aca->ue_update_flag, 0);
+	atomic_set(&aca->ue_dump_flag, 0);
 
 	return 0;
 }
@@ -880,12 +850,20 @@ static int handler_aca_bank_dump(struct aca_handle *handle, struct aca_bank *ban
 static int aca_dump_show(struct seq_file *m, enum aca_smu_type type)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct aca_handle_manager *mgr = &adev->aca.mgr;
+	struct aca_handle *handle;
 	struct aca_dump_context context = {
 		.m = m,
 		.idx = 0,
 	};
 
-	return aca_banks_update(adev, type, handler_aca_bank_dump, NULL, (void *)&context);
+	if (list_empty(&mgr->list))
+		return 0;
+
+	list_for_each_entry(handle, &mgr->list, node)
+		aca_banks_update(adev, handle, type, handler_aca_bank_dump, NULL, (void *)&context);
+
+	return 0;
 }
 
 static int aca_dump_ce_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 6f62e5d80ed6..e71d6f5afaec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,7 +202,7 @@ struct aca_smu_funcs {
 struct amdgpu_aca {
 	struct aca_handle_manager mgr;
 	const struct aca_smu_funcs *smu_funcs;
-	atomic_t ue_update_flag;
+	atomic_t ue_dump_flag;
 	bool is_enabled;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c0de682b7774..a4038e92c59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,10 +876,14 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 				      void *data)
 {
 	struct aca_bank_info info;
-	u64 misc0;
+	u64 misc0, status;
 	u32 instlo;
 	int ret;
 
+	status = bank->regs[ACA_REG_IDX_STATUS];
+	if (!ACA_REG__STATUS__VAL(status))
+		return 0;
+
 	ret = aca_bank_info_decode(bank, &info);
 	if (ret)
 		return ret;
@@ -894,8 +898,8 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
 		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info,
-						     ACA_ERROR_TYPE_UE, 1ULL);
+		if (ACA_REG__STATUS__UC(status) && ACA_REG__STATUS__PCC(status))
+			ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE, 1);
 		break;
 	case ACA_SMU_TYPE_CE:
 		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
-- 
2.34.1

