Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F11C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 07:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0825010E46B;
	Thu,  8 Dec 2022 07:51:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058C610E465
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 07:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odSQfOz3N9FcEr2kg3RO/o0dYO+b+wWYJSCp+w0Gzapt4Gw67FxGl49U9NkMF7CoQzahMPlhtwSaW15M8zjbZPPffCC5TWqdLQwacaW1L7BimS+lpJZlCjqdkdPaAgqkQzbhQylTRpey9wnBvI/tWpXtiB50g7ZmiKptdcCOon6Yl0ArguXCz0tOEQN+iRC77ZoHAeRgzmICqKVNdH1837Om3yh41IAto83o+maZipQfXrJ5hgsbxsAyUVWKs4w3FarjkuobAec8zqO0wBJl8itN7PRWsAWpCsnxMcK7ibSpol/VzjyWd3mGAxOOUyAvvpbknOopbc9vIVJ1wGLrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmRSTy+BVD1rXs5mK9m7S+rNqHL9FDGjz7da6fDp21k=;
 b=KWpxbnrmqfL3VpvN1P9RAw3a0M/ivr6PlGMjdXBvN0HKj9aTbQtaLkTp6dDtw6NOV2hkmkD1e1GsLi7D9iyRzM4B1HgRJ9eCKpAVGhmUCUE+YTTZgk+jctb/z4i9SaVecWWSm6LpbLfA698Ske4D5YXjeUs5Lz606+UAD/fwJSo/YT3axo2kjglYKqVpYsqNoSb5/BQoJVuuUC1mUhN8BgGtnFZ15YJ1VgnLXShTwjx0FTk9Aq0aP1knIBoQWRjhS81yYLlq18MbMeLE3FyNRMhk+OxZC1G0oF0OZbP2dMKaxJNQNypRJBYYwKmhZY2JN/LufrImqehG2SxCI/NpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmRSTy+BVD1rXs5mK9m7S+rNqHL9FDGjz7da6fDp21k=;
 b=IuiM/QfjtSiZYJg8knV5EBNuFPaoc+88m8uw+heEuRoI/9iLc2fUu8n2+mu22caJGWowapWw10u73sh8gbvAdk+YNX7wS8eOoGnngKvY6CrxaFbnjVcQgPznWIa4zA/z7jARRIXwHnW3C4WyUZarnLd9ozYJoTVxmzkbTNYXRhc=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 07:51:39 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::71) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 07:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 07:51:38 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 01:51:35 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Gavin.Wan@amd.com>, <Vignesh.Chander@amd.com>,
 <david.yu@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: add RAS poison consumption handler for SRIOV
Date: Thu, 8 Dec 2022 15:51:18 +0800
Message-ID: <20221208075122.28702-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221208075122.28702-1-tao.zhou1@amd.com>
References: <20221208075122.28702-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdb0409-5cc5-4ff3-c024-08dad8f109c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mQkFkVA2MFHeiY4kALmGbaLJy4y36uLSR+Mnrni1+3sRPnpBUYnpByIExW1xcYh1LB+XS1isIcik/sHE2GS8i4GdX2PwrHbDBmn684wGsiSkVV8hrGdTsFGriJF/oWSnIDrFLQbA37DDUQ/Fy7JobDdCKSIxdZip0o7eqfjW7khltH9Eg3uTNe5WYl3aa318dr5s7VagTokaQFKJJveY7BWNXq27aSd3DuYhTYmeimzxumLI6phpxSm39rRoKJVGvkyD5Lu+pp9ciUOX1bKrmgDFWwOPUrUfUeGxO5FnF1jnFIfdaoeMORPdDyuBs+r3rHdSoIRjzpFBXPtYPCU6fs3xJ5gjtR3nIt7QS5ozWnJudrpTH7U+YqzG78tZRPjc2rL2pwPazj3+TLTny4kF4oiv24n1nbCjw8lh795iT14wVAuWZSwerQDoFW8QrPa+IK7XDPtJJGeg/oOS7aW3sc/uSqVFurKqiIeTSrOtnhDVRAIJwow2mzJ96rdWhaDUQDlcw38pysEfYxWozIiQ46sdXuqTyXDfTfvEMHmrbJ8bijWq9quPIvRtzKwlOjdO2Am29SixUZEm/e+OTiL89Z9YIyIwf2yyqoyK0rAFqkQKRD1jBbP/4t9VVSiTlsPb5/H82GPfmlFSRv8wta7+sNE16N9YM8QI7pr3oGYsJnlXy/P2pWqq8chL63CGKgEMfIy2cwl49QncJ+sY/prfXl/d45H2zE3kYy/4yp6oDw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(426003)(47076005)(83380400001)(41300700001)(186003)(336012)(82310400005)(36860700001)(26005)(16526019)(8936002)(1076003)(2616005)(5660300002)(82740400003)(2906002)(110136005)(81166007)(8676002)(4326008)(7696005)(6666004)(40460700003)(70206006)(70586007)(478600001)(356005)(86362001)(6636002)(36756003)(316002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 07:51:38.7744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb0409-5cc5-4ff3-c024-08dad8f109c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Send message to PF if VF receives RAS poison consumption interrupt.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 44 +++++++++++++++----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index f76c19fc0392..1c7fcb4f2380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -169,25 +169,33 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
 
-	if (!adev->gmc.xgmi.connected_to_cpu) {
-		struct ras_err_data err_data = {0, 0, 0, NULL};
-		struct ras_common_if head = {
-			.block = AMDGPU_RAS_BLOCK__UMC,
-		};
-		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
-
-		ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
-
-		if (ret == AMDGPU_RAS_SUCCESS && obj) {
-			obj->err_data.ue_count += err_data.ue_count;
-			obj->err_data.ce_count += err_data.ce_count;
+	if (!amdgpu_sriov_vf(adev)) {
+		if (!adev->gmc.xgmi.connected_to_cpu) {
+			struct ras_err_data err_data = {0, 0, 0, NULL};
+			struct ras_common_if head = {
+				.block = AMDGPU_RAS_BLOCK__UMC,
+			};
+			struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+
+			ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
+
+			if (ret == AMDGPU_RAS_SUCCESS && obj) {
+				obj->err_data.ue_count += err_data.ue_count;
+				obj->err_data.ce_count += err_data.ce_count;
+			}
+		} else if (reset) {
+			/* MCA poison handler is only responsible for GPU reset,
+			 * let MCA notifier do page retirement.
+			 */
+			kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+			amdgpu_ras_reset_gpu(adev);
 		}
-	} else if (reset) {
-		/* MCA poison handler is only responsible for GPU reset,
-		 * let MCA notifier do page retirement.
-		 */
-		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-		amdgpu_ras_reset_gpu(adev);
+	} else {
+		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+			adev->virt.ops->ras_poison_handler(adev);
+		else
+			dev_warn(adev->dev,
+				"No ras_poison_handler interface in SRIOV!\n");
 	}
 
 	return ret;
-- 
2.35.1

