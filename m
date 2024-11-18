Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD533D10F57
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 05:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4898D10E317;
	Mon, 18 Nov 2024 05:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s9Bwljdo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEB310E317
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 05:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXm5XzymdNEpHpH20/ymnzGJQfEkoN0ySJaPmgQP0HGDDlkNhO830AS2+qu4u3C5odTGuP1dAqmEbO2bfP9yIlPnVhL4Ou/Ae1dv9m71fnXagp7spidB7ewPE8YuVbYidIHATN2SFL33B4653OV1SOGPETpXPXWphotXzyFelD9PUAWvtg3y4XLBn4wslaW3s1mBeV6BwMQ2+0+n2YMELc7yxR8VQVhVWyD/SnE8GlZJ+gv4H8IfbOf45FX+7WSMpH+MR5g/IFIMt7BJE/9sbaf3xfoozdXpomyFrN0+im+fA2fMsaqgjntGSeYNNYWKvt5pdmm3u7Ps2F0Z0wuDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJUyFNtZQ5Lbi/QeX4Bvgr5uEK96jGCcD7IIVdKunkQ=;
 b=TFIN1BLlQw4hl9W6i/1KpJeztmYjaLUAtS+8UrFZcIA+c0PIc3YFdPlry0VzMNTVnJvFIyxaD0S1t1lpOyZQ+2ATOoiV0Ii3RXf3D8hESMHG4PIJWvHVYaRg7HS0wx5Qpi4vYFZngYW0sjspe3FJ2sA3CbFjPa3WMRFuXMN3Ca+992uktNgIXPABTSbv0rkLRvTwJsAyWxhkextv4mt4+0C98+aq+hBt+yMWtnewmxjIWYh9p1q5Wqj9GRgWDqyswrTrK8/DaYwOXrN8wCoXcYctiJa+6R4tg//CNjY9FibUeDmDG2yqDJ8KpySFjtcDefTaT+TbyMFJSSxDCr6XOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJUyFNtZQ5Lbi/QeX4Bvgr5uEK96jGCcD7IIVdKunkQ=;
 b=s9BwljdoF78WG+UB5RoBUF7eEfctJJ1lEKdmIvEOkepO6Lz/jdAoYcaD/GBN7P5qu86bYSH0BkFkdIZVGe5+HrbPP9pkG4ZSxugDPZMjyifNAYlFRVnUmwmKFdN0RpNDe27InylH7bo8MGfa/4M9nS2quj9lTNNYYYUaC5fU4lA=
Received: from CH0PR03CA0348.namprd03.prod.outlook.com (2603:10b6:610:11a::23)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 05:44:43 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::7e) by CH0PR03CA0348.outlook.office365.com
 (2603:10b6:610:11a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 05:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 05:44:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 23:44:37 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Tao.Zhou1@amd.com>, 
 <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: Prefer RAS recovery for scheduler hang
Date: Mon, 18 Nov 2024 11:14:22 +0530
Message-ID: <20241118054422.3382434-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c5c8d6-739c-4833-1882-08dd079419c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lUpiJUZ3ZC+hhw1r6m/FcKt/tT0UytXQ+vdYfl4JpblaFGd+XkiQXKZqlZ7N?=
 =?us-ascii?Q?EiE0gmxl2vP/p44sPO8H9ET80hNnBF8yOFrwlGxR4TIRKItFS/NWiHLF7Co4?=
 =?us-ascii?Q?ebztpKuo+59j6JqDiYUIL+l9L1kIazzA0reHj9YggxrzPiLjJb6Celox8RyS?=
 =?us-ascii?Q?Akhv40Hrotxxg1MIKGCwu1ulnRQxSz7UNk+tSPhM/NLeOfUyCl/WtbdrDHry?=
 =?us-ascii?Q?HF7co1UkzJINj+D9qRfLhxS2aQmL5phIV2AHfPAauvMqFH4iNYIjNVNsXxD3?=
 =?us-ascii?Q?qw20F7chKJ6Dc7Uqo+FGwXurdav5osZMpZgkF1Qen3gxTWZjOuWlqchacdyF?=
 =?us-ascii?Q?AWRYn8No2RvvraLAvrYy5giMTB3gUKZ5znc0YWY5XFdkXRQasf1KH5kqfcyb?=
 =?us-ascii?Q?QugYjqdoCnM7Rf27WKL03wAipmPgRAjnq2rwGcbxOY/sTRIaQTYoVjTkWMrd?=
 =?us-ascii?Q?Ug/rWylF+Vc35klnd3y437BZNEuJMU3R+VHzfFpr5vJt0Dc+P7Pul525PpCd?=
 =?us-ascii?Q?DEli5KfzOOmn2PVUVjWbe68eHOZJPhE3khTRM36iD2GQwBv0diCfyI0Q/8zT?=
 =?us-ascii?Q?SQ1nmheJVRJmeEhhYA3mBkewg0cQECbDQjNHV/JcY/yeb7Amgz95R8tz9UmL?=
 =?us-ascii?Q?8//I2OzwY0AkTIW2F3ljy97CJ+ZnziYNK1prn0agNpwdr63oIOS0WyOMqAEk?=
 =?us-ascii?Q?d4prkpcz0njjuIM6KFi87xQrYrsJQWI0Xhhr/Qv0P/1qMk5eHUVMIDTkdlUt?=
 =?us-ascii?Q?1DQFjvWEi7t2Inr2hIOj0S9IOeWDBgI/D1qQpjkPPsEh4R1NKKxRYg2p2383?=
 =?us-ascii?Q?3YjlMCaPaYTsPrrFtPbudM3vs4ellGM6vk8L54rS4Dus2oC+OutOc0SZCdgj?=
 =?us-ascii?Q?e2ZdDLNb+F1a3Ex/qXRybSYkLJpYANyiKMnIHgl2UF2BxdETPEVP7pgigBrK?=
 =?us-ascii?Q?M2sJ6AxesT4x3dtG0dA072DyQv8u6TTy/iY6JC9zumkQlT1sMEQwVGRadgJw?=
 =?us-ascii?Q?SqSvGuF1kBcpM5EhDnqX8XOR78Ad6j2/qDw/69lPccelGb+zglrd9DJwEWMM?=
 =?us-ascii?Q?v0gWwh1re+UYjVgKug/iDKTF7FWYU5JanAhTGkkfJ5j5Ahp7+El2Dkv4Lt2M?=
 =?us-ascii?Q?mpZpSpEO3+iEIG+f0IftUodnpZg71pXlvM2l2nMQznxzTT8ylSHieeo2zNJQ?=
 =?us-ascii?Q?jS+AOlLtXNnqlFJrqaZZ7X7JuLgcTckZj+DJ3Qvwg1H19wjPh1abYhqiHKnq?=
 =?us-ascii?Q?9otM05Q5Zfrt7vUUwV6i8Rq1Fea6/APoe2XmH4I9BATQ5t9C5z+dHWfmaDsN?=
 =?us-ascii?Q?Hi3Dc1BcK86J+C9Cy97DNFfBaINbEpXn284aMzYNSwlaquKc9uG+UNFm4KbJ?=
 =?us-ascii?Q?6KpAsM1bqW/a0ZNls1vhQvKrZ0d4sokeYaABTX5RLbWOc5HsKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:44:42.4507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c5c8d6-739c-4833-1882-08dd079419c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

Before scheduling a recovery due to scheduler/job hang, check if a RAS
error is detected. If so, choose RAS recovery to handle the situation. A
scheduler/job hang could be the side effect of a RAS error. In such
cases, it is required to go through the RAS error recovery process. A
RAS error recovery process in certains cases also could avoid a full
device device reset.

An error state is maintained in RAS context to detect the block
affected. Fatal Error state uses unused block id. Set the block id when
error is detected. If the interrupt handler detected a poison error,
it's not required to look for a fatal error. Skip fatal error checking
in such cases.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 15 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 55 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       | 11 +++-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  2 +
 5 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 3a588fecb0c5..6a2fd9e4f470 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -332,6 +332,8 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
 		dev_info(tmp_adev->dev,
 			 "GPU reset succeeded, trying to resume\n");
+		/*TBD: Ideally should clear only GFX, SDMA blocks*/
+		amdgpu_ras_clear_err_state(tmp_adev);
 		r = aldebaran_mode2_restore_ip(tmp_adev);
 		if (r)
 			goto end;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3ca911e55d6..b4464f42d72a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5165,7 +5165,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	amdgpu_ras_set_fed(adev, false);
+	amdgpu_ras_clear_err_state(adev);
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 
 	/* some sw clean up VF needs to do before recover */
@@ -5460,7 +5460,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
 		if (full_reset) {
 			/* post card */
-			amdgpu_ras_set_fed(tmp_adev, false);
+			amdgpu_ras_clear_err_state(tmp_adev);
 			r = amdgpu_device_asic_init(tmp_adev);
 			if (r) {
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
@@ -5786,6 +5786,17 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	bool audio_suspended = false;
 	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
 
+	/*
+	 * If it reaches here because of hang/timeout and a RAS error is
+	 * detected at the same time, let RAS recovery take care of it.
+	 */
+	if (amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY) &&
+	    reset_context->src != AMDGPU_RESET_SRC_RAS) {
+		dev_dbg(adev->dev,
+			"Gpu recovery from source: %d yielding to RAS error recovery handling",
+			reset_context->src);
+		return 0;
+	}
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
 	 */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1bc95b0cdbb8..e31b12144577 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2156,6 +2156,16 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
 	/* Fatal error events are handled on host side */
 	if (amdgpu_sriov_vf(adev))
 		return;
+	/**
+	 * If the current interrupt is caused by a non-fatal RAS error, skip
+	 * check for fatal error. For fatal errors, FED status of all devices
+	 * in XGMI hive gets set when the first device gets fatal error
+	 * interrupt. The error gets propagated to other devices as well, so
+	 * make sure to ack the interrupt regardless of FED status.
+	 */
+	if (!amdgpu_ras_get_fed_status(adev) &&
+	    amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY))
+		return;
 
 	if (adev->nbio.ras &&
 	    adev->nbio.ras->handle_ras_controller_intr_no_bifring)
@@ -2185,6 +2195,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	if (ret)
 		return;
 
+	amdgpu_ras_set_err_poison(adev, block_obj->ras_comm.block);
 	/* both query_poison_status and handle_poison_consumption are optional,
 	 * but at least one of them should be implemented if we need poison
 	 * consumption handler
@@ -4083,16 +4094,56 @@ bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev)
 	if (!ras)
 		return false;
 
-	return atomic_read(&ras->fed);
+	return test_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_state);
 }
 
 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status)
 {
 	struct amdgpu_ras *ras;
 
+	ras = amdgpu_ras_get_context(adev);
+	if (ras) {
+		if (status)
+			set_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_state);
+		else
+			clear_bit(AMDGPU_RAS_BLOCK__LAST, &ras->ras_err_state);
+	}
+}
+
+void amdgpu_ras_clear_err_state(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras;
+
 	ras = amdgpu_ras_get_context(adev);
 	if (ras)
-		atomic_set(&ras->fed, !!status);
+		ras->ras_err_state = 0;
+}
+
+void amdgpu_ras_set_err_poison(struct amdgpu_device *adev,
+			       enum amdgpu_ras_block block)
+{
+	struct amdgpu_ras *ras;
+
+	ras = amdgpu_ras_get_context(adev);
+	if (ras)
+		set_bit(block, &ras->ras_err_state);
+}
+
+bool amdgpu_ras_is_err_state(struct amdgpu_device *adev, int block)
+{
+	struct amdgpu_ras *ras;
+
+	ras = amdgpu_ras_get_context(adev);
+	if (ras) {
+		if (block == AMDGPU_RAS_BLOCK__ANY)
+			return (ras->ras_err_state != 0);
+		else
+			return test_bit(block, &ras->ras_err_state) ||
+			       test_bit(AMDGPU_RAS_BLOCK__LAST,
+					&ras->ras_err_state);
+	}
+
+	return false;
 }
 
 static struct ras_event_manager *__get_ras_event_mgr(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6db772ecfee4..b13debcf48ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -99,7 +99,8 @@ enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__IH,
 	AMDGPU_RAS_BLOCK__MPIO,
 
-	AMDGPU_RAS_BLOCK__LAST
+	AMDGPU_RAS_BLOCK__LAST,
+	AMDGPU_RAS_BLOCK__ANY = -1
 };
 
 enum amdgpu_ras_mca_block {
@@ -558,8 +559,8 @@ struct amdgpu_ras {
 	struct ras_ecc_log_info  umc_ecc_log;
 	struct delayed_work page_retirement_dwork;
 
-	/* Fatal error detected flag */
-	atomic_t fed;
+	/* ras errors detected */
+	unsigned long ras_err_state;
 
 	/* RAS event manager */
 	struct ras_event_manager __event_mgr;
@@ -952,6 +953,10 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *a
 
 void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status);
 bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
+void amdgpu_ras_set_err_poison(struct amdgpu_device *adev,
+			       enum amdgpu_ras_block block);
+void amdgpu_ras_clear_err_state(struct amdgpu_device *adev);
+bool amdgpu_ras_is_err_state(struct amdgpu_device *adev, int block);
 
 u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum ras_event_type type);
 int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_type type,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index d46a13156ee9..0cb5c582ce7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -184,6 +184,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 		} else {
 			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		}
+		amdgpu_ras_set_err_poison(dev->adev, AMDGPU_RAS_BLOCK__GFX);
 		break;
 	case SOC15_IH_CLIENTID_VMC:
 	case SOC15_IH_CLIENTID_VMC1:
@@ -213,6 +214,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 		} else {
 			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		}
+		amdgpu_ras_set_err_poison(dev->adev, AMDGPU_RAS_BLOCK__SDMA);
 		break;
 	default:
 		dev_warn(dev->adev->dev,
-- 
2.25.1

