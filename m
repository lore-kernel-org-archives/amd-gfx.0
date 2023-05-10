Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210B4C7EE24
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEE910E551;
	Wed, 10 May 2023 21:26:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1AFA10E54E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZrTyxpAugK3OhegDqdJQvMnOzY+CmHIzDE1R/dgHggGQ9xB+jyCSA0Uq30SQq071g2eMC2KBriQCHs3F0T71vgEjZctVOcoDdFLdo5j7UqOkG5PkBNkrLPNyJwzzJch1BjlBaa1Xhu/31GIIq2Psw9FXElLhiHqDqy4D6BXA+94vja+2H5rMjj9rj5WBXPLDlnMaRV7+XmCwhdBsli3C/YArZs+pxW5Q7kVY1Ag7n8s6iEYhDjqQ7H6e1jjb/KXbGHx2bijwk59IyrJTIKaJot9+y2JA9mEo+36r5bcbw3RZ4e0Gif51j+f9V9QGb7qAqwwROdEh2gQ7yR6iXBlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3WWcFg933fiLqwtReFFmB6MCSExPoJbA3NM09mg8fI=;
 b=Ymm+jcW8I7A2nP2KwgwwL2jSd3JdOuiXr/+cMeuadQn4BPyR+l44SFEzvlFDS1fB/hp4WZyG3R8TLZI/Plsg1ecpvnkj7FeJN+40ZTyD+Aqpm39nRoCTxOd8ifO5kHhwjG3ilIF4uLp3HZR3xu+nzX/M097JPxUsKx9/LCkkiryWMYMMQ+xdrf8yiE7FwIxCzgOT+Y6wRD2nh02Cwg+CZ1X/4/DwapMa3/sfgLNsFI8rK4t+BS7ErbmU+CDXkeI87CCF2EAhpzGA8x2EAJAciyewco+0vDSy8xHaXpuNRs/N24QSaex5g4Hnxf0eV6uJ4GqWne2M0gvL3I0O4tf15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3WWcFg933fiLqwtReFFmB6MCSExPoJbA3NM09mg8fI=;
 b=oYDmT0aERfH5dNjnbw3qoSFBoXKvnIsgHvQ2ET5XVw+lFEFUHZZRjzdvtBqa80hJBZwTRdAG720fd5VV18hWWd7z0+hLaMYfwPLcgffck8vf/qy8n6WTnWBUCqKdpSBP9Yp1edPhpe+uTduhcv52ySWBEARLAUhnEvk6k6PD5Cc=
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by MW3PR12MB4505.namprd12.prod.outlook.com (2603:10b6:303:5a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 21:26:39 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:338:cafe::7f) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:26:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:26:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: add instance mask for RAS inject
Date: Wed, 10 May 2023 17:26:21 -0400
Message-ID: <20230510212624.2071771-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212624.2071771-1-alexander.deucher@amd.com>
References: <20230510212624.2071771-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|MW3PR12MB4505:EE_
X-MS-Office365-Filtering-Correlation-Id: 845c79a5-3621-4385-58d9-08db519d3d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgMkJHu16iMP+D81sbGFAoekRZvX8AohkVHJU4Gz8J7WNmxBGyKjOJNfo/b/dkzpX5z3Eg/0FsCrwhuExkgQZRs+/mE+jwXbl7IGzCnMnLGcrbB7f8Z1f+JmsO4tSauen/YDfYFk9NKFcMRxmt4SoBe80RYKNEYuGpTtgUMniFkTsTWS4i/lSFItopNV1vVWupVsHJO4ehNQGFjr6JlSAG1AftSrAbCjoAu7mRPek2ftg9k9GzW0BBI7wTlrKrzCF0m92+PpgJsttbHaoKExKsZrda8LjQ1Owx49VKsvAQ5JKJ6MHapKkeSA5kFkE8afcJ444icGeZS6/w1Q7LZiwqjXlRnDHF3hwnTUxx1AGNT+GpRT/v62gOy5/dplTLBeMss3vswp1EsSeJPDugxUPHvaOx9OUQQKVTQZcFVypdXgoz0pdSqYH7t7QOoCTfW3Tfz66oCdBaHiAHAUZ0T51bkefDw1eqLXi+eUfGKuJUhdE+F3jN8m2YgynAUUmvBE0fJgBtcUJv9yX2xWPShnwOCfCUgIjvMjx0nbDV81Su9TvuKtRZLhZf9mllKLMMl0YsPeBTW5PQyg8IkravazsH4zH+O7ZmZW7n7syk7f1exJBR9So0P9/N1dlan6crpT683I30IO4nh6SY5chA4pn30tLaX+NZK4x2IVAaANIOGOrFwzZPax29gZhCwKIaR5JP7LosPqArka6xYeT3iWw5jo/F3QErzKhfxYS7Va8zh3D0flVIv1jLYPtx68bRjBoldLKzMLRGvl7AA6vC+lxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(7696005)(5660300002)(83380400001)(36756003)(47076005)(2616005)(426003)(336012)(82740400003)(41300700001)(36860700001)(2906002)(30864003)(8676002)(8936002)(86362001)(26005)(16526019)(1076003)(40480700001)(4326008)(6916009)(316002)(186003)(478600001)(356005)(40460700003)(70206006)(70586007)(54906003)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:26:38.5621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845c79a5-3621-4385-58d9-08db519d3d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 "Stanley . Yang" <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

User can specify injected instances by the mask. For backward
compatibility, the mask value is incorporated into sub block index
without interface change of RAS TA.
User uses logical mask and driver should convert it to physical value
before sending it to RAS TA.

v2: update parameter name.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 21 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 23 ++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c  |  5 +++--
 8 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index ec79a5c2f500..59b8b26e2caf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1672,14 +1672,33 @@ int psp_ras_initialize(struct psp_context *psp)
 }
 
 int psp_ras_trigger_error(struct psp_context *psp,
-			  struct ta_ras_trigger_error_input *info)
+			  struct ta_ras_trigger_error_input *info, uint32_t instance_mask)
 {
 	struct ta_ras_shared_memory *ras_cmd;
+	struct amdgpu_device *adev = psp->adev;
 	int ret;
+	uint32_t dev_mask;
 
 	if (!psp->ras_context.context.initialized)
 		return -EINVAL;
 
+	switch (info->block_id) {
+	case TA_RAS_BLOCK__GFX:
+		dev_mask = GET_MASK(GC, instance_mask);
+		break;
+	case TA_RAS_BLOCK__SDMA:
+		dev_mask = GET_MASK(SDMA0, instance_mask);
+		break;
+	default:
+		dev_mask = instance_mask;
+		break;
+	}
+
+	/* reuse sub_block_index for backward compatibility */
+	dev_mask <<= AMDGPU_RAS_INST_SHIFT;
+	dev_mask &= AMDGPU_RAS_INST_MASK;
+	info->sub_block_index |= dev_mask;
+
 	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
 	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 0a409da749d1..d84323923a3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -486,7 +486,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable);
 int psp_ras_trigger_error(struct psp_context *psp,
-			  struct ta_ras_trigger_error_input *info);
+			  struct ta_ras_trigger_error_input *info, uint32_t instance_mask);
 int psp_ras_terminate(struct psp_context *psp);
 
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 64f80e8cbd63..7ae08f168f99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -256,6 +256,8 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 	int block_id;
 	uint32_t sub_block;
 	u64 address, value;
+	/* default value is 0 if the mask is not set by user */
+	u32 instance_mask = 0;
 
 	if (*pos)
 		return -EINVAL;
@@ -306,7 +308,11 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		data->op = op;
 
 		if (op == 2) {
-			if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx",
+			if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx 0x%x",
+				   &sub_block, &address, &value, &instance_mask) != 4 &&
+			    sscanf(str, "%*s %*s %*s %u %llu %llu %u",
+				   &sub_block, &address, &value, &instance_mask) != 4 &&
+				sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx",
 				   &sub_block, &address, &value) != 3 &&
 			    sscanf(str, "%*s %*s %*s %u %llu %llu",
 				   &sub_block, &address, &value) != 3)
@@ -314,6 +320,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 			data->head.sub_block_index = sub_block;
 			data->inject.address = address;
 			data->inject.value = value;
+			data->inject.instance_mask = instance_mask;
 		}
 	} else {
 		if (size < sizeof(*data))
@@ -341,7 +348,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  * sub_block_index: some IPs have subcomponets. say, GFX, sDMA.
  * name: the name of IP.
  *
- * inject has two more members than head, they are address, value.
+ * inject has three more members than head, they are address, value and mask.
  * As their names indicate, inject operation will write the
  * value to the address.
  *
@@ -365,7 +372,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *
  *	echo "disable <block>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
  *	echo "enable  <block> <error>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
- *	echo "inject  <block> <error> <sub-block> <address> <value> > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
+ *	echo "inject  <block> <error> <sub-block> <address> <value> <mask>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
  *
  * Where N, is the card which you want to affect.
  *
@@ -382,13 +389,14 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *
  * The sub-block is a the sub-block index, pass 0 if there is no sub-block.
  * The address and value are hexadecimal numbers, leading 0x is optional.
+ * The mask means instance mask, is optional, default value is 0x1.
  *
  * For instance,
  *
  * .. code-block:: bash
  *
  *	echo inject umc ue 0x0 0x0 0x0 > /sys/kernel/debug/dri/0/ras/ras_ctrl
- *	echo inject umc ce 0 0 0 > /sys/kernel/debug/dri/0/ras/ras_ctrl
+ *	echo inject umc ce 0 0 0 3 > /sys/kernel/debug/dri/0/ras/ras_ctrl
  *	echo disable umc > /sys/kernel/debug/dri/0/ras/ras_ctrl
  *
  * How to check the result of the operation?
@@ -1117,13 +1125,14 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 
 	if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
 		if (block_obj->hw_ops->ras_error_inject)
-			ret = block_obj->hw_ops->ras_error_inject(adev, info);
+			ret = block_obj->hw_ops->ras_error_inject(adev, info, info->instance_mask);
 	} else {
 		/* If defined special ras_error_inject(e.g: xgmi), implement special ras_error_inject */
 		if (block_obj->hw_ops->ras_error_inject)
-			ret = block_obj->hw_ops->ras_error_inject(adev, &block_info);
+			ret = block_obj->hw_ops->ras_error_inject(adev, &block_info,
+						info->instance_mask);
 		else  /*If not defined .ras_error_inject, use default ras_error_inject*/
-			ret = psp_ras_trigger_error(&adev->psp, &block_info);
+			ret = psp_ras_trigger_error(&adev->psp, &block_info, info->instance_mask);
 	}
 
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e96333d0c269..bc43f7db17cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -32,6 +32,11 @@
 struct amdgpu_iv_entry;
 
 #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS		(0x1 << 0)
+/* position of instance value in sub_block_index of
+ * ta_ras_trigger_error_input, the sub block uses lower 12 bits
+ */
+#define AMDGPU_RAS_INST_MASK 0xfffff000
+#define AMDGPU_RAS_INST_SHIFT 0xc
 
 enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__UMC = 0,
@@ -508,6 +513,7 @@ struct ras_inject_if {
 	struct ras_common_if head;
 	uint64_t address;
 	uint64_t value;
+	uint32_t instance_mask;
 };
 
 struct ras_cure_if {
@@ -545,7 +551,8 @@ struct amdgpu_ras_block_object {
 };
 
 struct amdgpu_ras_block_hw_ops {
-	int  (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
+	int  (*ras_error_inject)(struct amdgpu_device *adev,
+			void *inject_if, uint32_t instance_mask);
 	void (*query_ras_error_count)(struct amdgpu_device *adev, void *ras_error_status);
 	void (*query_ras_error_status)(struct amdgpu_device *adev);
 	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_error_status);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 439925477fb8..85ee1af963dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1014,7 +1014,8 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 }
 
 /* Trigger XGMI/WAFL error */
-static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  void *inject_if)
+static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
+			void *inject_if, uint32_t instance_mask)
 {
 	int ret = 0;
 	struct ta_ras_trigger_error_input *block_info =
@@ -1026,7 +1027,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  void *injec
 	if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
 		dev_warn(adev->dev, "Failed to disallow XGMI power down");
 
-	ret = psp_ras_trigger_error(&adev->psp, block_info);
+	ret = psp_ras_trigger_error(&adev->psp, block_info, instance_mask);
 
 	if (amdgpu_ras_intr_triggered())
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 38ff5a4970b5..5e70e423a8d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -770,7 +770,7 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
 static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 					  void *ras_error_status);
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
-				     void *inject_if);
+				     void *inject_if, uint32_t instance_mask);
 static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev);
 
 static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
@@ -6339,7 +6339,7 @@ static const struct soc15_ras_field_entry gfx_v9_0_ras_fields[] = {
 };
 
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
-				     void *inject_if)
+				     void *inject_if, uint32_t instance_mask)
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
@@ -6378,7 +6378,7 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 	block_info.value = info->value;
 
 	mutex_lock(&adev->grbm_idx_mutex);
-	ret = psp_ras_trigger_error(&adev->psp, &block_info);
+	ret = psp_ras_trigger_error(&adev->psp, &block_info, instance_mask);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index c67e387a97f5..59abe162bbaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -971,7 +971,7 @@ static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 }
 
 static int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
-				     void *inject_if)
+				     void *inject_if, uint32_t instance_mask)
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
@@ -987,7 +987,7 @@ static int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
 	block_info.value = info->value;
 
 	mutex_lock(&adev->grbm_idx_mutex);
-	ret = psp_ras_trigger_error(&adev->psp, &block_info);
+	ret = psp_ras_trigger_error(&adev->psp, &block_info, instance_mask);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index ec7c049c5952..4906affa6f8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1699,7 +1699,8 @@ static void gfx_v9_4_2_reset_ras_error_count(struct amdgpu_device *adev)
 	gfx_v9_4_2_query_utc_edc_count(adev, NULL, NULL);
 }
 
-static int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
+static int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev,
+			void *inject_if, uint32_t instance_mask)
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
@@ -1715,7 +1716,7 @@ static int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_
 	block_info.value = info->value;
 
 	mutex_lock(&adev->grbm_idx_mutex);
-	ret = psp_ras_trigger_error(&adev->psp, &block_info);
+	ret = psp_ras_trigger_error(&adev->psp, &block_info, instance_mask);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	return ret;
-- 
2.40.1

