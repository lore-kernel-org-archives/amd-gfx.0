Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D752C6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A3710EB4A;
	Thu, 23 Mar 2023 21:40:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C338892E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV2DuPQwv4aNnlB852kH+zadmY5RwOnjWfhO9TxWXqQgnXUpLTCJ+V17ZCrjv5+F2YYza4BsDKiSOeKty1izXxVVIP+QhRNpdZh2EdepOPJI6sYitMawgDgDxwH/ifz6EhMm2W6HJxrHsY1RNYqqF9eg2BYjvGeEtHnthy83DiAe1Z5jCeZasfdkgMiOlfYHKF4sU9LxqbgFL6e9NYKzKJeddsUY42RshHvnQxalB74bbmDVR+u1iLXEsIwuJgt23ZmGdoY5XCySk+2e+3+QiZcGpYGqsHMqUWrzEaEkmYLLZKAPyKnhKn64csOrNpfC0o5dtRgpTOED+Wqb/zzAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwLCOUlqnN4l3TF49gr8QeNqZDXCnaa2974sGYRrxbI=;
 b=Oww291Tb8pWI8h9MkWPOrKYVTCj5JOpH25UACAYbRjLFlL3eMlmlKKRe/A962tpfoJjFt6xBTpOPn032JZH4RjP4oCdu7LYWFXiGd5p9sTk4iG2a5OZZHv5iR7jJBDqqUdYoLDimuENEvycK6+pd4klFze/34LY3r1DMXZCRhEZtrf0jMOGa3jf5OVC685GoVi8/x1psAQaq9loyFB4Nrxruz9RsU5nEHUTPHLbpaynrRmiha2Kq+SgajcyDaXFQm7Yfc+SdhhAAKRzUE3UE1UI/xVXQiX+OOT9fdl4qbYiPN8vAOg4KavmpzgiH/eLG/7pXh6T6uW1VW1oFcl0xFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwLCOUlqnN4l3TF49gr8QeNqZDXCnaa2974sGYRrxbI=;
 b=ZWQ8mjbfBkbzdCVfmxwFM2Hql3dBjD+cy9BUvjW+suZAupBn4cilK6X9guRudlsWjTEqS3qfzzsI2Wp0Y3sf8L1bK5cMHQDf81XnplJVLIyEqA4CFrmx38qHJExUPdLlPGs2FDX+RRIU/qP0t6rnKKoKAaLuXBUgobsMnIsRMG4=
Received: from DM6PR06CA0077.namprd06.prod.outlook.com (2603:10b6:5:336::10)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:40:51 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::35) by DM6PR06CA0077.outlook.office365.com
 (2603:10b6:5:336::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amdgpu: add gfx11 emit shadow callback
Date: Thu, 23 Mar 2023 17:40:26 -0400
Message-ID: <20230323214034.1169310-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|BL0PR12MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bd3fdb-f15a-4102-3bee-08db2be745ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9QBoWCudpD2B4VHm0MySQKfHjzvdLns3Yjz3JDIoAD1E7FJyaclMsWUcdx33iFh2o2p1m1XaV7JLB7IOtfKqvcfcEakVJjp1Rq8Y/5LSvjog51Izutug4FQR4ptIEpUyDwzkRCLjUptGHTvXnYMx5LARHRavF1Qho7SCX+Gl201QRRboCxaamQXZD5KBhb2Kr/NTin1ChSuvX1j+FVGpMSJBR9LfmjMiR4fnb1L6PcBfohSaVJ6OIcCS6kJsd/FA2Ii2CMK1zUxTs5ZzLtHkbtSm8oz+eeSaqB5iln8n61eGNGSa2dALYfE77y8+l+NBS0c9TNBS0tbjj5SdwP5zd95ZVmlByeGLvzuT2lnxmhldNU9ybjIbw4WS+OwIN3ILvDidMLUS5yc2qm07caD216I/ync/rGeAmXBAOZXpbGsM83LHKBz0P3aGPjVi2AlBpNvHkZF3YsKhWwOqgWiPgBgwc811SQY02Nn52jWDCfXCuLxVr3YFrU8gujGv5edQD3cPguRYrCYF83RcMp0hQCRCxLhfykQyiqSIFGgMsjuT1AVfeWXEE1V8H4KiX+oV0cBG/K+V1dRKEv3vVekzG0nHzqPjq5xBmOVn8tNbQrc/J/TtT9aVBWzgGs5kq7RnZNp0GfhBdNrqX+/P/+AqY3qz97AjT47pU5kziiYKThD2rCV2rWf4lnlaSF78Xy39msOrpucOr8gFFHvpL0fb/4sWI02QGGQW7uCTSsJhng=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(81166007)(186003)(2906002)(16526019)(356005)(478600001)(82740400003)(8676002)(316002)(6916009)(4326008)(36756003)(5660300002)(336012)(83380400001)(2616005)(8936002)(70206006)(26005)(1076003)(36860700001)(7696005)(6666004)(41300700001)(54906003)(86362001)(40460700003)(66574015)(47076005)(70586007)(426003)(40480700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:51.4070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bd3fdb-f15a-4102-3bee-08db2be745ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

Add ring callback for gfx to update the CP firmware
with the new shadow information before we process the
IB.

v2: add implementation for new packet (Alex)
v3: add current FW version checks (Alex)
v4: only initialize shadow on first use
    Only set IB_VMID when a valid shadow buffer is present
    (Alex)
v5: Pass parameters rather than job to new ring callback (Alex)

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nvd.h       |  5 ++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4a50d0fbcdcf..1fc1e941f7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5598,6 +5598,29 @@ static void gfx_v11_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, 0);
 }
 
+static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
+					   u64 shadow_va, u64 csa_va,
+					   u64 gds_va, bool init_shadow,
+					   int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (!adev->gfx.cp_gfx_shadow)
+		return;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
+	amdgpu_ring_write(ring, lower_32_bits(shadow_va));
+	amdgpu_ring_write(ring, upper_32_bits(shadow_va));
+	amdgpu_ring_write(ring, lower_32_bits(gds_va));
+	amdgpu_ring_write(ring, upper_32_bits(gds_va));
+	amdgpu_ring_write(ring, lower_32_bits(csa_va));
+	amdgpu_ring_write(ring, upper_32_bits(csa_va));
+	amdgpu_ring_write(ring, shadow_va ?
+			  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid): 0);
+	amdgpu_ring_write(ring, init_shadow ?
+			  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
+}
+
 static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
 {
 	unsigned ret;
@@ -6219,6 +6242,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.set_wptr = gfx_v11_0_ring_set_wptr_gfx,
 	.emit_frame_size = /* totally 242 maximum if 16 IBs */
 		5 + /* COND_EXEC */
+		9 + /* SET_Q_PREEMPTION_MODE */
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
@@ -6245,6 +6269,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
+	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
 	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v11_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v11_0_ring_preempt_ib,
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index fd6b58243b03..631dafb92299 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -462,6 +462,9 @@
 #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
 #define	PACKET3_RUN_LIST				0xA5
 #define	PACKET3_MAP_PROCESS_VM				0xA6
-
+/* GFX11 */
+#define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
+#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
+#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM    (1 << 0)
 
 #endif
-- 
2.39.2

