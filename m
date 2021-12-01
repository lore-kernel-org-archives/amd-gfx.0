Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8627BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB4C6F5EF;
	Wed,  1 Dec 2021 10:53:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD5A6F5EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv2P8CnAmeI7FbZiIlh+sbV3hiDPc7tY6eyBmcY2yR8W1hAz8P+W65jn7XJlWRBdxp/53/JfqY3d22+2D69G86kq06Iawl0QWMrl/Ks3+D6dslzkyVQ/rUvWsrDa7hiyvHN8SfTGFAZIA2TtTQZ/bMtKA1bmZ4y8uTkK9C6FAo8knZpNwk/B6sJeIokfnzazKJptPb9Yu/4nhr6PiBBV2O7KuybsMVKbP6hUffQGbrY7v3Hq9zgRHnnLpfHuTKEFCS7A3LSzO0PmUba6eQlQ2mXwWhXuAQ3QfShfcGcrXuAioMguaJY3J2WKEw+d1Tj3lEcc4HiFbgaKUp/9tUss+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ODaaj79ysnR1xHztjb+dKRmmk3I+lvh/rKsEa+azc4=;
 b=WoWjQdMLc4n3puPW7PEoNB74nEAl5vwgsgjYDFA2sS5BsuXJl6uE94Wg9i+zQcyXAEo2xf/8T3IxFLcWjYYqcpNipfDwTxpX5Q78ga5mV1zO1mKSFH/COkwxjRx0x+zaQG6VGHa51ixbNfQQvNXEWXPeXGgtcdmnugLgAz3e06+oQqayxSGP8YTe7Zo/BtMxgeNdWMuuHWQrAu0iujsuWZt6BrYuRx3RMgCjgNRxa4zecA4YGjz2MlofD4w3ijYFV5s/zMXPl0gSWBz+tfRQXlnkq9YQbDivj+Su+LG3/ovsRv3ivMX2hZuWbvoIJbaSmCDetARozsr8yMejmbgmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ODaaj79ysnR1xHztjb+dKRmmk3I+lvh/rKsEa+azc4=;
 b=5bldgO5OrhhvRtox8+9W0n5ZKV0Nv2A6RRCT1rtG1j36iJ1fi3RD+CZm7ocXz9zgTIVITJdhFc0G+G5nW0eWKtE7cuvpWyJ2o/ZaSUkHJToBL0YzUlSkdapvuRnTnsA5G+Rs2bvo7k6GbFq8gUZriGUq76ptMIpSsdthxLioxQo=
Received: from BN1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:408:e2::10)
 by BN8PR12MB3316.namprd12.prod.outlook.com (2603:10b6:408:42::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 10:53:44 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::9c) by BN1PR13CA0005.outlook.office365.com
 (2603:10b6:408:e2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.6 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:43 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:41 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 06/11] drm/amdgpu: Modify mmhub block to fit for the
 unified ras block data and ops
Date: Wed, 1 Dec 2021 18:52:45 +0800
Message-ID: <20211201105250.298525-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201105250.298525-1-YiPeng.Chai@amd.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2ab94b3-f135-424f-4151-08d9b4b8d7eb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3316:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33162E9D735B8EC99143CF86FC689@BN8PR12MB3316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrwQEglBKoZdtm3InqjDrn5sctr1iN1UDuhzO+ouTUe2cAiSdFlUbeYd65f8I2/wiAUnc6UrSgzYd/R4kKbH64q3as1LHr0hR13/TSxOnd3batFxk56Zz0VLdJ9bQ9wGQNRMSpg0AiO65WX9Hx1ZYIDeQt7Z8V8TnewG7VRWno4nht8HG6rH6klT6vJ8W/RZcq77h8L2DRILg/P3z6aaPaeRfm7UYlpOQtPgHLiXzH+So1h77ON+eIzzVvTTsMxl91UGLClzgOk+kcz/P6T0GrdG6D80Z5QMtXrjrYJlpuX1uqE+7re168MhQ2QXZNjnsz1nCdQKaDHasSqEn9wavDU5fto8pz9Cjy8zUxmERbV2ffLi+IurXJy2jO2E8LHOsHq2PFlKM4kyYB5PYqGo94K1PdLzSPjAgRfHiqG49BZg9dEhuNFq9Gnze8VdARF9SGMd5KxcqXFjJlY4DTC7KBtjELrFYJgqrIgO2YwSfqgykCGOi7uimclU6GphZoJv/lV7mviNCsH472b4D1cq4Eufd24uo6VIcatSBt/hNWulH9I2KtOjDrhHKjgDepJbN/tpNPs5fJF9Y2wc+ig4N9SnKd6CcTshid8GRiBzTQietk97AIEHx1iwmq2aoPcIchKHrQbdNRXOdF0jVj4N7n0vjj3tvnD+87VhluFnb0wlzJWLEqpFZ3GCRtSzDEe+jCGvkT5Imk5sd0+rn7orLfMqh0KWLUatj5avJgGTm3jA9Snwg2BHewNrXRGUpcqnJFRMTj/gHdUsp6yYgC8A1h1+v1/aaDo7mtWaHT+WAsI5BFZXOccb2inGICcXJVZ471AVLCeTCuBx6ps0Zleidg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(508600001)(36860700001)(86362001)(81166007)(8936002)(426003)(54906003)(186003)(26005)(30864003)(2616005)(7696005)(40460700001)(82310400004)(5660300002)(336012)(83380400001)(2906002)(356005)(6916009)(70206006)(70586007)(36756003)(47076005)(8676002)(16526019)(1076003)(4326008)(316002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:43.8824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ab94b3-f135-424f-4151-08d9b4b8d7eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3316
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, yipechai <YiPeng.Chai@amd.com>,
 yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify mmhub block to fit for the unified ras block data and ops.
2.Implement .ras_block_match function pointer for mmhub block to identify itself.
3.Change amdgpu_mmhub_ras_funcs to amdgpu_mmhub_ras, and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of mmhub ras variable so that mmhub ras block can be able to be insertted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register mmhub ras block into amdgpu device ras block link list. 5.Remove the redundant code about mmhub in amdgpu_ras.c after using the unified ras block.
6.Remove the redundant code about mmhub in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 12 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h  | 12 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 49 +++++++---------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    | 23 +++++++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    | 23 +++++++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 23 +++++++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h    |  2 +-
 11 files changed, 108 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0980396ee709..c7d5592f0cf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3377,9 +3377,9 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 		if (adev->asic_reset_res)
 			goto fail;
 
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+		if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ops &&
+		    adev->mmhub.ras->ras_block.ops->reset_ras_error_count)
+			adev->mmhub.ras->ras_block.ops->reset_ras_error_count(adev);
 	} else {
 
 		task_barrier_full(&hive->tb);
@@ -4705,9 +4705,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 	if (!r && amdgpu_ras_intr_triggered()) {
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-			if (tmp_adev->mmhub.ras_funcs &&
-			    tmp_adev->mmhub.ras_funcs->reset_ras_error_count)
-				tmp_adev->mmhub.ras_funcs->reset_ras_error_count(tmp_adev);
+			if (tmp_adev->mmhub.ras && tmp_adev->mmhub.ras->ras_block.ops &&
+			    tmp_adev->mmhub.ras->ras_block.ops->reset_ras_error_count)
+				tmp_adev->mmhub.ras->ras_block.ops->reset_ras_error_count(tmp_adev);
 		}
 
 		amdgpu_ras_intr_cleared();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 0d06e7a2b951..317b5e93a1f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -441,9 +441,9 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (adev->mmhub.ras_funcs &&
-	    adev->mmhub.ras_funcs->ras_late_init) {
-		r = adev->mmhub.ras_funcs->ras_late_init(adev);
+	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ops &&
+	    adev->mmhub.ras->ras_block.ops->ras_late_init) {
+		r = adev->mmhub.ras->ras_block.ops->ras_late_init(adev);
 		if (r)
 			return r;
 	}
@@ -497,9 +497,9 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	    adev->umc.ras_funcs->ras_fini)
 		adev->umc.ras_funcs->ras_fini(adev);
 
-	if (adev->mmhub.ras_funcs &&
-	    adev->mmhub.ras_funcs->ras_fini)
-		adev->mmhub.ras_funcs->ras_fini(adev);
+	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ops &&
+	    adev->mmhub.ras->ras_block.ops->ras_fini)
+		adev->mmhub.ras->ras_block.ops->ras_fini(adev);
 
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ops &&
 	    adev->gmc.xgmi.ras->ras_block.ops->ras_fini)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index b27fcbccce2b..6d10b3f248db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -21,14 +21,8 @@
 #ifndef __AMDGPU_MMHUB_H__
 #define __AMDGPU_MMHUB_H__
 
-struct amdgpu_mmhub_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	void (*query_ras_error_count)(struct amdgpu_device *adev,
-				      void *ras_error_status);
-	void (*query_ras_error_status)(struct amdgpu_device *adev);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
-	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+struct amdgpu_mmhub_ras {
+	struct amdgpu_ras_block_object ras_block;
 };
 
 struct amdgpu_mmhub_funcs {
@@ -50,7 +44,7 @@ struct amdgpu_mmhub_funcs {
 struct amdgpu_mmhub {
 	struct ras_common_if *ras_if;
 	const struct amdgpu_mmhub_funcs *funcs;
-	const struct amdgpu_mmhub_ras_funcs *ras_funcs;
+	struct amdgpu_mmhub_ras  *ras;
 };
 
 int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bed414404c6f..d705d8b1daf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -943,6 +943,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 		break;
 	case AMDGPU_RAS_BLOCK__GFX:
+	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (!block_obj || !block_obj->ops)	{
 			dev_info(adev->dev, "%s don't config ras function \n",
 				get_ras_block_str(&info->head));
@@ -955,15 +956,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		if (block_obj->ops->query_ras_error_status)
 			block_obj->ops->query_ras_error_status(adev);
 		break;
-	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_count)
-			adev->mmhub.ras_funcs->query_ras_error_count(adev, &err_data);
-
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_status)
-			adev->mmhub.ras_funcs->query_ras_error_status(adev);
-		break;
 	case AMDGPU_RAS_BLOCK__PCIE_BIF:
 		if (adev->nbio.ras_funcs &&
 		    adev->nbio.ras_funcs->query_ras_error_count)
@@ -1046,6 +1038,7 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 
 	switch (block) {
 	case AMDGPU_RAS_BLOCK__GFX:
+	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (!block_obj || !block_obj->ops)	{
 			dev_info(adev->dev, "%s don't config ras function \n", ras_block_str(block));
 			return -EINVAL;
@@ -1056,15 +1049,6 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		if (block_obj->ops->reset_ras_error_status)
 			block_obj->ops->reset_ras_error_status(adev);
 		break;
-	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
-
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_status)
-			adev->mmhub.ras_funcs->reset_ras_error_status(adev);
-		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->reset_ras_error_count)
 			adev->sdma.funcs->reset_ras_error_count(adev);
@@ -1764,29 +1748,24 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 					  struct ras_query_if *info)
 {
-	struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
+	struct amdgpu_ras_block_object* block_obj = NULL;
 	/*
 	 * Only two block need to query read/write
 	 * RspStatus at current state
 	 */
-	switch (info->head.block) {
-	case AMDGPU_RAS_BLOCK__GFX:
-		if (!block_obj || !block_obj->ops)	{
-			dev_info(adev->dev, "%s don't config ras function \n", get_ras_block_str(&info->head));
-			return ;
-		}
+	if ( (info->head.block != AMDGPU_RAS_BLOCK__GFX) &&
+		 (info->head.block != AMDGPU_RAS_BLOCK__MMHUB))
+		 return ;
 
-		if (block_obj->ops->query_ras_error_status)
-			block_obj->ops->query_ras_error_status(adev);
-		break;
-	case AMDGPU_RAS_BLOCK__MMHUB:
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->query_ras_error_status)
-			adev->mmhub.ras_funcs->query_ras_error_status(adev);
-		break;
-	default:
-		break;
+	block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
+	if (!block_obj || !block_obj->ops)	{
+		dev_info(adev->dev, "%s don't config ras function \n", get_ras_block_str(&info->head));
+		return ;
 	}
+
+	if (block_obj->ops->query_ras_error_status)
+		block_obj->ops->query_ras_error_status(adev);
+
 }
 
 static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c66dc13e256f..53ec18c595e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1202,18 +1202,22 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
-		adev->mmhub.ras_funcs = &mmhub_v1_0_ras_funcs;
+		adev->mmhub.ras = &mmhub_v1_0_ras;
 		break;
 	case CHIP_ARCTURUS:
-		adev->mmhub.ras_funcs = &mmhub_v9_4_ras_funcs;
+		adev->mmhub.ras = &mmhub_v9_4_ras;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->mmhub.ras_funcs = &mmhub_v1_7_ras_funcs;
+		adev->mmhub.ras = &mmhub_v1_7_ras;
 		break;
 	default:
 		/* mmhub ras is not available */
 		break;
 	}
+
+	if(adev->mmhub.ras)
+		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block);
+
 }
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
@@ -1297,9 +1301,9 @@ static int gmc_v9_0_late_init(void *handle)
 	}
 
 	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
-		if (adev->mmhub.ras_funcs &&
-		    adev->mmhub.ras_funcs->reset_ras_error_count)
-			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+		if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ops &&
+		    adev->mmhub.ras->ras_block.ops->reset_ras_error_count)
+			adev->mmhub.ras->ras_block.ops->reset_ras_error_count(adev);
 
 		if (adev->hdp.ras && adev->hdp.ras->ras_block.ops &&
 		    adev->hdp.ras->ras_block.ops->reset_ras_error_count)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index b3bede1dc41d..da505314802a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -774,13 +774,34 @@ static void mmhub_v1_0_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_ras_funcs mmhub_v1_0_ras_funcs = {
+static int mmhub_v1_0_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+struct amdgpu_ras_block_ops mmhub_v1_0_ras_ops = {
+	.ras_block_match = mmhub_v1_0_ras_block_match,
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v1_0_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_0_reset_ras_error_count,
 };
 
+struct amdgpu_mmhub_ras mmhub_v1_0_ras = {
+	.ras_block = {
+		.name = "mmhub",
+		.block = AMDGPU_RAS_BLOCK__MMHUB,
+		.ops = &mmhub_v1_0_ras_ops,
+	},
+};
+
 const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs = {
 	.get_fb_location = mmhub_v1_0_get_fb_location,
 	.init = mmhub_v1_0_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
index 4661b094e007..dae7ca48bd8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h
@@ -24,6 +24,6 @@
 #define __MMHUB_V1_0_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v1_0_funcs;
-extern const struct amdgpu_mmhub_ras_funcs mmhub_v1_0_ras_funcs;
+extern struct amdgpu_mmhub_ras mmhub_v1_0_ras;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index f5f7181f9af5..829d14ee87d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1321,7 +1321,20 @@ static void mmhub_v1_7_reset_ras_error_status(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs = {
+static int mmhub_v1_7_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+struct amdgpu_ras_block_ops mmhub_v1_7_ras_ops = {
+	.ras_block_match = mmhub_v1_7_ras_block_match,
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
@@ -1330,6 +1343,14 @@ const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs = {
 	.reset_ras_error_status = mmhub_v1_7_reset_ras_error_status,
 };
 
+struct amdgpu_mmhub_ras mmhub_v1_7_ras = {
+	.ras_block = {
+		.name = "mmhub",
+		.block = AMDGPU_RAS_BLOCK__MMHUB,
+		.ops = &mmhub_v1_7_ras_ops,
+	},
+};
+
 const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
 	.get_fb_location = mmhub_v1_7_get_fb_location,
 	.init = mmhub_v1_7_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
index a7f9dfc24697..629f49052137 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
@@ -24,6 +24,6 @@
 #define __MMHUB_V1_7_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs;
-extern const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs;
+extern struct amdgpu_mmhub_ras mmhub_v1_7_ras;
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ff49eeaf7882..1edc98e5bcbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1655,7 +1655,20 @@ static void mmhub_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_mmhub_ras_funcs mmhub_v9_4_ras_funcs = {
+static int mmhub_v9_4_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops mmhub_v9_4_ras_ops = {
+	.ras_block_match = mmhub_v9_4_ras_block_match,
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v9_4_query_ras_error_count,
@@ -1663,6 +1676,14 @@ const struct amdgpu_mmhub_ras_funcs mmhub_v9_4_ras_funcs = {
 	.query_ras_error_status = mmhub_v9_4_query_ras_error_status,
 };
 
+struct amdgpu_mmhub_ras mmhub_v9_4_ras = {
+	.ras_block = {
+		.name = "mmhub",
+		.block = AMDGPU_RAS_BLOCK__MMHUB,
+		.ops = &mmhub_v9_4_ras_ops,
+	},
+};
+
 const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs = {
 	.get_fb_location = mmhub_v9_4_get_fb_location,
 	.init = mmhub_v9_4_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
index 90436efa92ef..a48329d95f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h
@@ -24,6 +24,6 @@
 #define __MMHUB_V9_4_H__
 
 extern const struct amdgpu_mmhub_funcs mmhub_v9_4_funcs;
-extern const struct amdgpu_mmhub_ras_funcs mmhub_v9_4_ras_funcs;
+extern struct amdgpu_mmhub_ras mmhub_v9_4_ras;
 
 #endif
-- 
2.25.1

