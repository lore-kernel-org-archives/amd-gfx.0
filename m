Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E6FCA0ED3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E74210E21A;
	Mon,  2 Sep 2024 07:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cql6keoX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D989910E21A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIIrm6mgqpMZ580WyGxSeo4Irr/lrml4o4reh57mwYYxAJcbUKv3QVOnnnKSTvFuNuMOtF7CwlwvDc/gXCqlU+MtcTdQi7zYR/WeDToSdPsWzgZiRQ/yVffrhr0973xX89hsgOicrtfdurmCjVj8bVqcAFvQAuh9eprQbY3fDBdMAIhPlXkk3GV45sR48aYLtlUX8VhH9/Gq/2LzTNF8MnmV9tpSk6hugFdbLAbmSRn68UCk1Dk7KFTw9KoQlYonEzoxINWtMU3f63UF1fyEJdPX6JHTDKSypZC0hEh+Dm0ggAIwcMopgKE/ic8fobVImUIQ26u+eEXhvJ++178zVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXof4CnxTLAI8fZWQ9RSXUbWaVW1ugZtnXzTq9ivXVc=;
 b=vOA7xq4ZgegLaFITb6oLcXtSGUX8rWHWq7RoNvc2j3MuouCX0ts6zQO9VbvrWcWwGsmr1MyWqG2S1hUDMTN/iropI4vS/IQZ/Z08+xiMo5tULvqKU7CNpeVohUatn7ms2LPr/Xg4TowvvXrJR0dY4wvNTRj+zuEDw1ggZmZo1mtaDaVkMbotA6Pbhss4e8ppi+OIhvCrebH9nmuiwxHU+hOwS3uZZrnlsRPijyVSSZM9JFLAV8lP35o2miUqEM2/mPCzP6Epex353V7f8H0q7A+g7ug6XlF24wJkjdJG28UvnMj0eZtMGyQjbl9nnqNStPWexnFduqBYGGoWYL+SwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXof4CnxTLAI8fZWQ9RSXUbWaVW1ugZtnXzTq9ivXVc=;
 b=cql6keoXv9jaibesK2SRZxMTncDbpknzFqCs5TJ7JQWgjJYRUQ2Hb1vqNsW0LULcXS2kn7NpbuSDOdILM46yPgMl+qQ/D3YxeLXHrVGMOlw/PoAfAYAw67bBmkFQWZ/dILFk/a/gV7sv7QsgNNR/jSxkKwVhquvzY9a9K6IYs0s=
Received: from BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 07:34:41 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::30) by BN8PR07CA0033.outlook.office365.com
 (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:38 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: Separate reinitialization after reset
Date: Mon, 2 Sep 2024 13:04:10 +0530
Message-ID: <20240902073417.2025971-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902073417.2025971-1-lijo.lazar@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: c00551c2-db6b-4481-28a3-08dccb21b4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p7qJVPZ/Mvn2Qq3NJRuc9mXeaxDpA3pqDDBj7vqSSz99wHtAwNXvDwsdZXtN?=
 =?us-ascii?Q?nAj7zeR1Bi0BWwoSsDfMjEVy+LN0QftLdBZHP5Q3xumXM8C65bq/xPLa87uX?=
 =?us-ascii?Q?MhE629l3h/mTvZWRcYM8To4eSAaWIOwc5IJd0hoofQeJ8TFZy7Mvur9jYFG9?=
 =?us-ascii?Q?S187LEvEKVasIpH2E9TlIUI/79e8N16DPkDtHIa6pA9OsxBS8jJfwOsixQz4?=
 =?us-ascii?Q?GZskuAyzQP7/YsugQf5ToC3x+YBDHU62yqPH4ybNi3GIGYzAlXvc7GiX7NGn?=
 =?us-ascii?Q?lUm9I6XGfePDXTnGeAsIs4ds9rQ7q0aF8x40JYOtIZ4jEfmc28KJt+gbNOqQ?=
 =?us-ascii?Q?2/+HmHnn2c7soOiShMAGspzYSQ+A+6kRsAiWDGxfh+qtkiY2dCRgauAGzkLl?=
 =?us-ascii?Q?4qfTRVzM9yfuYRfFq8v9ZrHujtj9N1icnb95X4D/4nBdWeOFVPwAMnrG0WcF?=
 =?us-ascii?Q?jcK5iJ8GVexOYH+3CZCwwPtENmm15fTSvFnZD4tuUqc27tS5nQRYaBV0GF2B?=
 =?us-ascii?Q?KuFInv/CeLop7OwhZTiyRNSyqwU3w3z6OxpFS6WlLfbOZLvSnp+JsYUJG4i4?=
 =?us-ascii?Q?snB2+vlrHXzdiWz8SrvyW3hp0sKVXDrhibhU2e/TOCP7b6i+l/0vYI9HSPgh?=
 =?us-ascii?Q?r5INmcPws6WYiHBSRjgQ1Wr+JubDLimJCpq5RtXOxL56BY05oTe0HqeRYGMS?=
 =?us-ascii?Q?y+OPWXCB2X3B5QUnrTwJJTHqNJN+AJriTDt1RwVTvn/2gku0G2cg7JvteWTX?=
 =?us-ascii?Q?kcHMo0QdUdDAtMXppmV4dDLh9R8JspCV6OIlSocnt6ohV7yTUtZ3s3z0Labe?=
 =?us-ascii?Q?57UAXGN2KuVr6Ej/5xxOWhUTP/O4K+cx02TloP20b1vBMRfZfPkIFhI/eGij?=
 =?us-ascii?Q?qK59JiCelfthoa+XdfphspPwfVgeV8oWT1YIuCSazDVrxDTPzicCn/VuxDqt?=
 =?us-ascii?Q?SldBzPxh0XfmGsiH2dHZ3tkaa2Qq2eIGLcwJiApdt9/u23RGKcq3f3/dsIXG?=
 =?us-ascii?Q?HGhxRey+FrludyPCnUOSgnzbCsrRRpJM6f0zB6PYlEm7xEC1mWR8JzR1DG3Q?=
 =?us-ascii?Q?3kgOrlfP6YOMJQqeaaYDeQoPzv636CxLTvZkshZ6DMPkQWGd8Om18FsiJvDY?=
 =?us-ascii?Q?okKsqBrfXG3QSJaUH5kDIICTSgN2UsThRd3ss3sppr6cdv4aKDJrULU9cr2g?=
 =?us-ascii?Q?CBj3Dm7+Baw8r+533IuG/Sjn6E2TX7WELR9urCRGYOw9jg83PwJnj42QoEM8?=
 =?us-ascii?Q?ws1Fl5XRyBQaEdjLiD+Uo2I20uXgBDzu+z9DFSeZpyy032ZNZvPBIBtOZafe?=
 =?us-ascii?Q?fgEJjw94L92I74M5kUv4dyQLRv5PFq33yVdJcUFGv9hia2KYcfuRvgdheEKZ?=
 =?us-ascii?Q?bKtgnMFa0j5IGXQn7uO/FjsgMY1dbKe8QINYrnib7XOfCX7Lz/Tjtlb/zaoc?=
 =?us-ascii?Q?g0j0gxjdn/Jwc1WccZMWlxzdRgn1Ap7M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:40.4421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c00551c2-db6b-4481-28a3-08dccb21b4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
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

Move the reinitialization part after a reset to another function. No
functional changes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 150 ++++++++++++---------
 2 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fefdace22894..e1ae898b42eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1276,6 +1276,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context);
 
+int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context);
+
 int emu_soc_asic_init(struct amdgpu_device *adev);
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index db5046e8b10d..e28227869307 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5440,75 +5440,25 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
-int amdgpu_do_asic_reset(struct list_head *device_list_handle,
-			 struct amdgpu_reset_context *reset_context)
+int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 {
-	struct amdgpu_device *tmp_adev = NULL;
-	bool need_full_reset, skip_hw_reset, vram_lost = false;
-	int r = 0;
-
-	/* Try reset handler method first */
-	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
-				    reset_list);
-
-	reset_context->reset_device_list = device_list_handle;
-	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
-	/* If reset handler not implemented, continue; otherwise return */
-	if (r == -EOPNOTSUPP)
-		r = 0;
-	else
-		return r;
-
-	/* Reset handler not implemented, use the default method */
-	need_full_reset =
-		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
-	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
-
-	/*
-	 * ASIC reset has to be done on all XGMI hive nodes ASAP
-	 * to allow proper links negotiation in FW (within 1 sec)
-	 */
-	if (!skip_hw_reset && need_full_reset) {
-		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			/* For XGMI run all resets in parallel to speed up the process */
-			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
-					r = -EALREADY;
-			} else
-				r = amdgpu_asic_reset(tmp_adev);
-
-			if (r) {
-				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
-					 r, adev_to_drm(tmp_adev)->unique);
-				goto out;
-			}
-		}
+	struct list_head *device_list_handle;
+	bool full_reset, vram_lost = false;
+	struct amdgpu_device *tmp_adev;
+	int r;
 
-		/* For XGMI wait for all resets to complete before proceed */
-		if (!r) {
-			list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-					flush_work(&tmp_adev->xgmi_reset_work);
-					r = tmp_adev->asic_reset_res;
-					if (r)
-						break;
-				}
-			}
-		}
-	}
+	device_list_handle = reset_context->reset_device_list;
 
-	if (!r && amdgpu_ras_intr_triggered()) {
-		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			amdgpu_ras_reset_error_count(tmp_adev, AMDGPU_RAS_BLOCK__MMHUB);
-		}
+	if (!device_list_handle)
+		return -EINVAL;
 
-		amdgpu_ras_intr_cleared();
-	}
+	full_reset = test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
+	r = 0;
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		/* After reset, it's default init level */
 		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
-		if (need_full_reset) {
+		if (full_reset) {
 			/* post card */
 			amdgpu_ras_set_fed(tmp_adev, false);
 			r = amdgpu_device_asic_init(tmp_adev);
@@ -5598,7 +5548,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			r = amdgpu_ib_ring_tests(tmp_adev);
 			if (r) {
 				dev_err(tmp_adev->dev, "ib ring test failed (%d).\n", r);
-				need_full_reset = true;
 				r = -EAGAIN;
 				goto end;
 			}
@@ -5611,10 +5560,85 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	}
 
 end:
-	if (need_full_reset)
+	return r;
+}
+
+int amdgpu_do_asic_reset(struct list_head *device_list_handle,
+			 struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *tmp_adev = NULL;
+	bool need_full_reset, skip_hw_reset;
+	int r = 0;
+
+	/* Try reset handler method first */
+	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
+				    reset_list);
+
+	reset_context->reset_device_list = device_list_handle;
+	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
+	/* If reset handler not implemented, continue; otherwise return */
+	if (r == -EOPNOTSUPP)
+		r = 0;
+	else
+		return r;
+
+	/* Reset handler not implemented, use the default method */
+	need_full_reset =
+		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
+	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
+
+	/*
+	 * ASIC reset has to be done on all XGMI hive nodes ASAP
+	 * to allow proper links negotiation in FW (within 1 sec)
+	 */
+	if (!skip_hw_reset && need_full_reset) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+			/* For XGMI run all resets in parallel to speed up the process */
+			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				if (!queue_work(system_unbound_wq,
+						&tmp_adev->xgmi_reset_work))
+					r = -EALREADY;
+			} else
+				r = amdgpu_asic_reset(tmp_adev);
+
+			if (r) {
+				dev_err(tmp_adev->dev,
+					"ASIC reset failed with error, %d for drm dev, %s",
+					r, adev_to_drm(tmp_adev)->unique);
+				goto out;
+			}
+		}
+
+		/* For XGMI wait for all resets to complete before proceed */
+		if (!r) {
+			list_for_each_entry(tmp_adev, device_list_handle,
+					    reset_list) {
+				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+					flush_work(&tmp_adev->xgmi_reset_work);
+					r = tmp_adev->asic_reset_res;
+					if (r)
+						break;
+				}
+			}
+		}
+	}
+
+	if (!r && amdgpu_ras_intr_triggered()) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+			amdgpu_ras_reset_error_count(tmp_adev,
+						     AMDGPU_RAS_BLOCK__MMHUB);
+		}
+
+		amdgpu_ras_intr_cleared();
+	}
+
+	r = amdgpu_device_reinit_after_reset(reset_context);
+	if (r == -EAGAIN)
 		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 	else
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
+
+out:
 	return r;
 }
 
-- 
2.25.1

