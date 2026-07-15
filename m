Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E309FC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81DC310F06E;
	Wed, 15 Jul 2026 13:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yoTLhbul";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4C3810F06E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNRc7y7fDn1DzTyvIVdDNc979MGN1WD55cAiseUlt6HzXncItl8N2rTbQsIFIoIN2k0henFFMqAxEMqy/hIXkYaeEH8cIamOCaI+/sijRd0SItoelBukYlso5yCcXwWcJVdTyJox1lRAbPm+4cqwu2y6wK1e1NkntYi3286PNeWG7g0UiQEk5dLBhPMRRkZTKWlLeFX0OWcpVBSUJ+n0oariCqidr9SRvixALgk7QqBwTYyeHnblLIYjnCHym5yvaKDyoDfad/z7nLw0oH+5zw8v4T1/d/hQGbYnTguNlmWWjtdtRCCUslHG5419Apcu5DcHyfEDJSeMS+fKqGBOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUNrME5GYRsuJgAg8dkYErGon1mAhcnw5UM7PvOSOkI=;
 b=PZjdxk1bLlJMITppK4Lb4omq++I/wbvJPHJYrSAIO4TZcOSuEBrSLL/YA0oF+U8jIKnlfZOEaBkNFHSnkvMMDm9RwTdRFnH7BgQRZ00MRdKxrHSWtGcA51QtO+gYMkNt64tBw6K0wcSTbzbbkZSyytCSl8EiJqZUu/LPy6sAHFx0+B7Hx+eeVyDzKs/Nb/HQIfEqbxRBi2CbMRB6jUv2UDDDlwp9cRKkhMEKP0NxjGvyqrQeplLHxYXwhBZEQfebyKyiXQWmwtLoN2L0fQDB115WF0Gzig5e3IW4NPzCTNMjsigVlI9VDPDMsEUq4fS2AEiIzVlsJjnXYY7lzPCI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUNrME5GYRsuJgAg8dkYErGon1mAhcnw5UM7PvOSOkI=;
 b=yoTLhbulQqj3l8pFxpzxxFuX8D0k43lOwdlZQwqGKksB/J8EkDy8K/0+PAGt/BhVd3RiGLSjk6avPpIN5gIHw1KjTf4XnfmIIJ2HIJTUqfA+0/rCL5/0/NNtB8rXi67E8DTT45XtOfGHK5UnkiOoxAekPBd8OsFe9e0fSRF4FXA=
Received: from PH1PEPF00013317.namprd07.prod.outlook.com (2603:10b6:518:1::7)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8db) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:45:39 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF00013317.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:23 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:19 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 08/70] drm/amd/display: add DMUB command sync KUnit coverage
Date: Wed, 15 Jul 2026 21:37:18 +0800
Message-ID: <20260715134432.1975118-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: 853a9633-bb7a-466c-778c-08dee2775aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|10067099003|6133799003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: pu5/kp26ycEX7oEvQaSmy8VAsS1Fa0XeHk15MtHI7O+ncCG1heNfgB6sMGTlnhKjbgh7kVbZWf/3PAic0QGggqgm+hzvzev4G+cbB23Fvr6pl/X2JDUc2M+5nVhwCgDzPWXoUoFkX1V6X6e7hijFrG5l4CnRP/dqc3ja2CGKqLNfX4V0u1sQfda3aIFECAIAduYf9Xze99yBAiFqLcD5Jm5REx2uwK6w7OrzcAdpreZFqP3+Cecg3furlTef1WkNzU++kwiO/MJOUoSu0SLEKBTQAz/1qLZV7PomHwGOqo4shohzVz1cz1YXTCbcInBJVoQmQPICqoL8q4ZXJPtoiCRnTJbjSw/ThWa+q/xqYT0TDflIONW5YnDptVDSJW5MAP+GfNryD55lQ7r1Ex5DqiLaQtZ0bFGH6BzjxpSVmWijn7+YuB7fqPSL0xPiM8zUVfhctW4udbn+lS93huCAOB/Ju3K6WFiyY6CMcQGtZ5L+uncf1Dvla7eNKE5nllvltXM3ca4zx/yeOP2KRusxqgPIkXkZfJa4cFrxSrYcZ0O+1M1Pq22JD5s6t7MzGS9xg4g1IAp1G0hWdLl1h8UJmYRht6t7zc91brq6y+dsApv9uCCv2IdW5XiN4+uIxGZZD+mAfjan4utNSvDNedZW6sk6HvyYWR4XmFeil15Y05A1LDSRC86vnc4qm2TNE1Y4orOG2LN+sAFTERZsVqacrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(6133799003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SRiYhr7MiGiydPmrEa9G+wgXjdrUpFsmQldJJEukbod9+LU6rKQ3WpPTc9DNhpMttagj1SB4hLSpSdBNObC5k8nWA3Auvtx5NZIpiAzbLc5plav52f3ITSBmwTOCR1uIIcRJwT5RKVGdjf+9yPDSFPRcWmVCL+akho4caYO0OiLTC7FIwl7J82Qu+hMsxP4LqfKN14uEq3smzOKgiBboWTiGrfMc5rCS1dJW3HA8+EBKHTh4IjgatGW2q8j7Q9bd5rQQdozugCoBKPDlJG9Cw1DKMimqE21uaw80V0LieEat7/rQU9sT4olnqpUrtghFdRMYeXCN8BWqy1rRtCXqkbLUgLQcC0WjqqsMOvHVrL8o0CEhs8R3fZyanvDUjEDZMje8fB5bOBI+Gv0yMHpyheJMYG6k6EsrmtZAk5+UKQpXeimAf8PsnZkBYEHbWpLa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:38.2274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853a9633-bb7a-466c-778c-08dee2775aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit coverage for the synchronous DMUB command helpers:
dm_execute_dmub_cmd(), amdgpu_dm_process_dmub_aux_transfer_sync(), and
amdgpu_dm_process_dmub_set_config_sync(). Cover command submission
without a DC DMUB service, AUX engine-acquire failure, protocol-error
propagation, the bounded reply-data copy, the zero-length reply branch,
and the SET_CONFIG completed-with-unknown-error path.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   3 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 369 ++++++++++++++++++
 2 files changed, 372 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index b6f09a687969..992d9f525ffc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -830,6 +830,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 	mutex_unlock(&adev->dm.dpia_aux_lock);
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_process_dmub_aux_transfer_sync);
 
 STATIC_IFN_KUNIT void abort_fused_io(
 		struct dc_context *ctx,
@@ -933,6 +934,7 @@ int amdgpu_dm_process_dmub_set_config_sync(
 	mutex_unlock(&adev->dm.dpia_aux_lock);
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_process_dmub_set_config_sync);
 
 bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
 {
@@ -941,6 +943,7 @@ bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd, e
 	guard(spinlock_irqsave)(&adev->dm.dmub_lock);
 	return dc_dmub_srv_cmd_run(ctx->dmub_srv, cmd, wait_type);
 }
+EXPORT_IF_KUNIT(dm_execute_dmub_cmd);
 
 bool dm_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned int count, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index c3bd93b15d0a..d75ee1c930ee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -932,6 +932,366 @@ static void dm_test_init_microcode_unsupported_asic(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_init_microcode(adev), 0);
 }
 
+/* Tests for dm_execute_dmub_cmd() */
+
+/**
+ * dm_test_execute_dmub_cmd_null_dmub_srv - Test command execution fails without DMUB service
+ * @test: The KUnit test context
+ *
+ * With no DC DMUB service on the context, dc_dmub_srv_cmd_run() returns false
+ * and dm_execute_dmub_cmd() propagates that failure.
+ */
+static void dm_test_execute_dmub_cmd_null_dmub_srv(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	union dmub_rb_cmd *cmd;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	cmd = kunit_kzalloc(test, sizeof(*cmd), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cmd);
+
+	spin_lock_init(&adev->dm.dmub_lock);
+	ctx->driver_context = adev;
+	ctx->dmub_srv = NULL;
+
+	KUNIT_EXPECT_FALSE(test,
+			   dm_execute_dmub_cmd(ctx, cmd, DM_DMUB_WAIT_TYPE_NO_WAIT));
+}
+
+/* Tests for amdgpu_dm_process_dmub_aux_transfer_sync() */
+
+/**
+ * dm_test_process_dmub_aux_transfer_sync_engine_acquire - Test AUX transfer engine-acquire failure
+ * @test: The KUnit test context
+ *
+ * With dc->link_count == 0, dc_process_dmub_aux_transfer_async() rejects the
+ * link index and amdgpu_dm_process_dmub_aux_transfer_sync() reports an
+ * engine-acquire error and returns -1.
+ */
+static void dm_test_process_dmub_aux_transfer_sync_engine_acquire(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc *dc;
+	struct aux_payload *payload;
+	struct dmub_notification *notify;
+	enum aux_return_code_type result = AUX_RET_SUCCESS;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+
+	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+
+	dc->link_count = 0;
+	ctx->dc = dc;
+	ctx->driver_context = adev;
+	adev->dm.dmub_notify = notify;
+	mutex_init(&adev->dm.dpia_aux_lock);
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+
+	ret = amdgpu_dm_process_dmub_aux_transfer_sync(ctx, 0, payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, -1);
+	KUNIT_EXPECT_EQ(test, result, AUX_RET_ERROR_ENGINE_ACQUIRE);
+}
+
+/**
+ * dm_test_process_dmub_aux_transfer_sync_protocol_error - Test AUX protocol error result
+ * @test: The KUnit test context
+ *
+ * With the completion pre-signaled and a fake DC DMUB service that rejects the
+ * command after construction, the sync helper should propagate the notification
+ * result without waiting for real firmware.
+ */
+static void dm_test_process_dmub_aux_transfer_sync_protocol_error(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_context *dc_ctx;
+	struct dc *dc;
+	struct dc_link *link;
+	struct ddc_service *ddc;
+	struct aux_payload *payload;
+	struct dmub_notification *notify;
+	enum aux_return_code_type result = AUX_RET_SUCCESS;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_ctx);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ddc);
+
+	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+
+	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+
+	link->ddc = ddc;
+	dc->ctx = dc_ctx;
+	dc->link_count = 1;
+	dc->links[0] = link;
+	dc_ctx->dc = dc;
+	dc_ctx->driver_context = adev;
+	dc_ctx->dmub_srv = NULL;
+	ctx->dc = dc;
+	ctx->driver_context = adev;
+	spin_lock_init(&adev->dm.dmub_lock);
+	adev->dm.dmub_notify = notify;
+	mutex_init(&adev->dm.dpia_aux_lock);
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+	complete(&adev->dm.dmub_aux_transfer_done);
+	notify->result = AUX_RET_ERROR_PROTOCOL_ERROR;
+
+	ret = amdgpu_dm_process_dmub_aux_transfer_sync(ctx, 0, payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, -1);
+	KUNIT_EXPECT_EQ(test, result, AUX_RET_ERROR_PROTOCOL_ERROR);
+}
+
+/**
+ * dm_test_process_dmub_aux_transfer_sync_copies_data - Test AUX reply data copy
+ * @test: The KUnit test context
+ *
+ * On a successful notification, the sync helper should copy the bounded reply
+ * data and report the high-nibble command reply when present.
+ */
+static void dm_test_process_dmub_aux_transfer_sync_copies_data(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_context *dc_ctx;
+	struct dc *dc;
+	struct dc_link *link;
+	struct ddc_service *ddc;
+	struct aux_payload *payload;
+	struct dmub_notification *notify;
+	enum aux_return_code_type result = AUX_RET_ERROR_UNKNOWN;
+	u8 data[4] = { 0 };
+	u8 reply = 0;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_ctx);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ddc);
+
+	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+
+	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+
+	link->ddc = ddc;
+	dc->ctx = dc_ctx;
+	dc->link_count = 1;
+	dc->links[0] = link;
+	dc_ctx->dc = dc;
+	dc_ctx->driver_context = adev;
+	dc_ctx->dmub_srv = NULL;
+	ctx->dc = dc;
+	ctx->driver_context = adev;
+	spin_lock_init(&adev->dm.dmub_lock);
+	adev->dm.dmub_notify = notify;
+	mutex_init(&adev->dm.dpia_aux_lock);
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+	complete(&adev->dm.dmub_aux_transfer_done);
+	payload->data = data;
+	payload->reply = &reply;
+	payload->length = sizeof(data);
+	notify->result = AUX_RET_SUCCESS;
+	notify->aux_reply.command = 0xA4;
+	notify->aux_reply.length = 3;
+	notify->aux_reply.data[0] = 0x11;
+	notify->aux_reply.data[1] = 0x22;
+	notify->aux_reply.data[2] = 0x33;
+
+	ret = amdgpu_dm_process_dmub_aux_transfer_sync(ctx, 0, payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, 3);
+	KUNIT_EXPECT_EQ(test, result, AUX_RET_SUCCESS);
+	KUNIT_EXPECT_EQ(test, reply, 0xA);
+	KUNIT_EXPECT_EQ(test, data[0], 0x11);
+	KUNIT_EXPECT_EQ(test, data[1], 0x22);
+	KUNIT_EXPECT_EQ(test, data[2], 0x33);
+}
+
+/**
+ * dm_test_process_dmub_aux_transfer_sync_zero_length - Test AUX reply with no data
+ * @test: The KUnit test context
+ *
+ * On a successful notification whose reply carries no data, the sync helper
+ * takes the zero-length branch and returns the reply length (0) without
+ * copying any payload data.
+ */
+static void dm_test_process_dmub_aux_transfer_sync_zero_length(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_context *dc_ctx;
+	struct dc *dc;
+	struct dc_link *link;
+	struct ddc_service *ddc;
+	struct aux_payload *payload;
+	struct dmub_notification *notify;
+	enum aux_return_code_type result = AUX_RET_ERROR_UNKNOWN;
+	u8 data[4] = { 0 };
+	u8 reply = 0;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_ctx);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ddc);
+
+	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+
+	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+
+	link->ddc = ddc;
+	dc->ctx = dc_ctx;
+	dc->link_count = 1;
+	dc->links[0] = link;
+	dc_ctx->dc = dc;
+	dc_ctx->driver_context = adev;
+	dc_ctx->dmub_srv = NULL;
+	ctx->dc = dc;
+	ctx->driver_context = adev;
+	spin_lock_init(&adev->dm.dmub_lock);
+	adev->dm.dmub_notify = notify;
+	mutex_init(&adev->dm.dpia_aux_lock);
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+	complete(&adev->dm.dmub_aux_transfer_done);
+	payload->data = data;
+	payload->reply = &reply;
+	payload->length = sizeof(data);
+	notify->result = AUX_RET_SUCCESS;
+	notify->aux_reply.command = 0x03;
+	notify->aux_reply.length = 0;
+
+	ret = amdgpu_dm_process_dmub_aux_transfer_sync(ctx, 0, payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, result, AUX_RET_SUCCESS);
+	KUNIT_EXPECT_EQ(test, reply, 0x3);
+}
+
+/* Tests for amdgpu_dm_process_dmub_set_config_sync() */
+
+/**
+ * dm_test_process_dmub_set_config_sync_unknown_error - Test SET_CONFIG completes with unknown error
+ * @test: The KUnit test context
+ *
+ * With no DC DMUB service, dc_process_dmub_set_config_async() cannot reach the
+ * firmware and reports the command as completed with SET_CONFIG_UNKNOWN_ERROR,
+ * so amdgpu_dm_process_dmub_set_config_sync() returns 0 with that status.
+ */
+static void dm_test_process_dmub_set_config_sync_unknown_error(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_context *dc_ctx;
+	struct dc *dc;
+	struct dc_link *link;
+	struct set_config_cmd_payload *payload;
+	struct dmub_notification *notify;
+	enum set_config_status result = SET_CONFIG_PENDING;
+	int ret;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc_ctx);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+
+	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, payload);
+
+	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, notify);
+
+	dc->ctx = dc_ctx;
+	dc_ctx->dmub_srv = NULL;
+	dc->links[0] = link;
+	ctx->dc = dc;
+	ctx->driver_context = adev;
+	adev->dm.dmub_notify = notify;
+	mutex_init(&adev->dm.dpia_aux_lock);
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+
+	ret = amdgpu_dm_process_dmub_set_config_sync(ctx, 0, payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, result, SET_CONFIG_UNKNOWN_ERROR);
+}
+
 /* Tests for abort_fused_io() */
 
 /**
@@ -1009,6 +1369,15 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_dmub_sw_init_unsupported_asic),
 	/* dm_init_microcode() */
 	KUNIT_CASE(dm_test_init_microcode_unsupported_asic),
+	/* dm_execute_dmub_cmd() */
+	KUNIT_CASE(dm_test_execute_dmub_cmd_null_dmub_srv),
+	/* amdgpu_dm_process_dmub_aux_transfer_sync() */
+	KUNIT_CASE(dm_test_process_dmub_aux_transfer_sync_engine_acquire),
+	KUNIT_CASE(dm_test_process_dmub_aux_transfer_sync_protocol_error),
+	KUNIT_CASE(dm_test_process_dmub_aux_transfer_sync_copies_data),
+	KUNIT_CASE(dm_test_process_dmub_aux_transfer_sync_zero_length),
+	/* amdgpu_dm_process_dmub_set_config_sync() */
+	KUNIT_CASE(dm_test_process_dmub_set_config_sync_unknown_error),
 	/* abort_fused_io() */
 	KUNIT_CASE(dm_test_abort_fused_io_no_dmub_srv),
 	{}
-- 
2.43.0

