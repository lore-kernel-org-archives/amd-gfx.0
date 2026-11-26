Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CE606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=suR69dQ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45861112225;
	Thu, 26 Nov 2026 09:34:50 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A91112212
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIvLFPpgrUBxebZGn8jxmL5fwCqK6pp/mLl4kNoYATy5w04mhnxyUaeUfcl4/S4N+XWB/tQzI54tv5R+/tyRsosJS+0ein9oDMt5Z/vXxYwnP3I7lXfaYCIIVFMNK3hb5Z9CDu5IBC2Q/BpL8njvU/LxHcY2llJsFgI28Z5foH8qBe+ujb0kR7uGxQHclEc4ApxpCFycte0fgSUbp06ZneJ69lEhdnKyMolo2GT+2vH9Grd/A6RYayWDQ4MTBgeKAS2Jav4K8ulnjAN/AAPbAA5ix2BWcVXtJ4Qls7co573dz44BXDWNaHOo23QZ0dgEMV3k1HVM/CGIzBV7RKqqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSb+v8/kzCnIAi5aMiwpz1DnTMDNKqIyRaBFAU+wql0=;
 b=ZZwvGGm078I1L3B9vkNowP/mrnxWMwXvKVGfqUNjVWSWZ9r1rj1L91XFwmad5vRZ1q9UcpPaXvjghOaO01S3vAIE4/49yo/+w8rrePUN0qz7p5ao22irorgnnkF/18CkEJktyH15YSzvTBQ81YC7mjLrLrs1TLtKV4mKgZjoUIl2sX+KnNAxjvegFmvvbLjCmKOzD9dWFE/R6fEHCk2ApnbcwFoAehyJDzxrxvSHGOH+K/PLR6i7VLfK/6RRxr7kLbj6bZiNRclUGQ5BwEndr+wyxVNKkU9CNYnLIcOJIoiOxUN5nrdv5oWQELoCugavGpyeLtmSc9p0qemfEvhN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSb+v8/kzCnIAi5aMiwpz1DnTMDNKqIyRaBFAU+wql0=;
 b=suR69dQ/nsoNC+oAw++RbA5n3Ut8jqSQXymLvcwZymR0/k1193IK+tVv8s4Eh6wFD8cC6Smsn4fhoJxbDAR6+K6SvMAm7B8WDyzo+uM/Et+L1mWrz65IMzVDpsyBLA+84RTonmrrcE6rulKcE0NTYB3nIBEOZI5ISy3mZSiKou0=
Received: from DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) by
 PH9PR12MB174847.namprd12.prod.outlook.com (2603:10b6:510:415::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:36 +0000
Received: from CH7PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:3b6:cafe::78) by DS7PR03CA0182.outlook.office365.com
 (2603:10b6:5:3b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH7PEPF00000017.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Thu, 26 Nov 2026 09:34:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:35 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:33 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 05/15] drm/amdgpu/gfx12: save and restore a gfx HQD
Date: Thu, 26 Nov 2026 17:33:41 +0800
Message-ID: <20261126093417.192538-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000017:EE_|PH9PR12MB174847:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e6873b-14d4-4b42-a38d-08df4ba07c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|6133799003|261009223027099003|22082099003|18002099003|3023799007|11063799006|10067099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: sbxZpYnEcjcr/f7EZoQTCvV807Owkk5KI39hnAh2c97MKfSfGW8+5wz+kchVEcX/tt5f8CCdHopxvWHTAJQtfPJUF8kZFwb761bkSasSQWbglVuygc3Rcft9ufY+KpmjChMEZp4xtoJzC8mIFM9M2cW4A3bzYfOC8t35KQwEa9CDPYtt8lHZa5DTSxsscKHIGOAQMdf/rW9eBwUTYl5D8XC7yCgqHDTeL/UIWYQmsoxf417CpZ0B9oOWrC9WJNhYVEvBLDc4trbFdD0s5onP7qaoFwbel0PAwHgLxAQrxBSqu6F+Q65StyDBA6kxxbo1aCCY4SrK1CLS7FgTXnCB9/Ov41/8rn8OCx/npGpM+we64SD0Otun8fJoD3A1LnJjZGS1qgZOQIWFVa/PVKvUP8Cuy9m6gAY2Y5lEoQS36bBdHHCUzOqCvUBWD9tQPuQHumaaJadc6hpqitVn0ynuEvboAkvT70asaFOqHPy/nbXcKsgdzpQi8a9tyFiNGY3SVGtbj20/JUs6Lske76NF6/3ot7/QXIqQdHr3VBaeKnrFKGv1+9E0KKJLB6RJuYsXxfaNaYS6QvW4BG8xywpulXILqtyWWbg3qT8Dmor0yPZDHxlw/CB7sMPlEKa9gKcjODZ+9Au77R7yO7Sz3IDYTe2kLeM8k92M/9sifhEYWT1MThMftGJrg8ZYIF9XU2iCexq1W3n5/+qvS0XOWI3wVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(261009223027099003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3De2duF6JmWHONZer9DZLmI/QGdr3oVn3aO7UAMmJ67PV4Rn0V0FbAaH0RFsQzECQxJ+uyTPRl7rKu70h/3FiXy+P4NJ5/vuPhL93Z4tE3MnXvSukDwVJLawS/vHWVrD0fUxEugd/0I6BxbG+g3JKlfV/LRCue1P3E6DFqgI/KVbFy5rx5Zu0ZWgtkunxj4Yf8bUkqU07VU20PS6XAB3V+34EG/Y39OxtctL1jzjNlCFnPd/rxzhzAH5cAabtVtaL3qW5G1ZNxe152AdZGWLqJPXrjX7RTuQfAOBhQWil0t6tUhXVTBoQ6488VoQxP1VftU6sqLh4L/cSvN1DJYnzpX7cxDeIHtxKgz57zhQ3fXk/9X88Am3Nhu2oJxFxZUQtsonmVZ95ElhdC+L1X+0W3X2LMgnvzE3WJ9+t3MYLnIeCj30rQy1W0K9fALaA0ve
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:36.0749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e6873b-14d4-4b42-a38d-08df4ba07c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB174847
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the gfx callbacks to save and restore a gfx HQD for gfx12:
- save_hqd() saves the HQD offset, CSMD read pointer and write pointer
  of the gfx HQD of a doorbell, and whether the queue is the one
  connected to its pipe;
- restore_hqd() writes them into the MQD after a reset, for MES to map
  the queue again where it was. A queue switched out of the pipe resumes
  from the preemption status the PFP saved in its MQD, also in the
  middle of an IB. The queue the pipe was executing has its state in the
  PFP, which the reset cleared: it restarts after the work submitted so
  far instead, and that work is dropped.

v4: Rename to save_hqd()/restore_hqd() (Timur).

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 83 ++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 09a27c3f6921..8ca8e3f8392d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -274,6 +274,11 @@ static void gfx_v12_0_set_imu_funcs(struct amdgpu_device *adev);
 static int gfx_v12_0_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev);
+static bool gfx_v12_0_save_hqd(struct amdgpu_device *adev, u32 doorbell_index,
+			       struct amdgpu_gfx_saved_hqd *hqd);
+static bool gfx_v12_0_restore_hqd(struct amdgpu_device *adev, void *m,
+				  u32 ring_size,
+				  const struct amdgpu_gfx_saved_hqd *hqd);
 static void gfx_v12_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance, int xcc_id);
 static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
@@ -967,6 +972,8 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.set_perfmon_clk_override = &gfx_v12_0_set_perfmon_clk_override,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
+	.save_hqd = &gfx_v12_0_save_hqd,
+	.restore_hqd = &gfx_v12_0_restore_hqd,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -3861,6 +3868,82 @@ static int gfx_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+#define GFX12_HPD_QUEUE_STATE_CONNECTED_MIN	3
+#define GFX12_HPD_QUEUE_STATE_CONNECTED_MAX	15
+
+static bool gfx_v12_0_save_hqd(struct amdgpu_device *adev, u32 doorbell_index,
+			       struct amdgpu_gfx_saved_hqd *hqd)
+{
+	u32 me, pipe, queue, status, state;
+
+	memset(hqd, 0, sizeof(*hqd));
+	hqd->doorbell_index = doorbell_index;
+	if (!gfx_v12_0_detect_hung_queue(adev, doorbell_index, &me, &pipe, &queue))
+		return true;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, me, pipe, queue, 0);
+	hqd->on_hqd = RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) &
+		      CP_GFX_HQD_ACTIVE__ACTIVE_MASK;
+	if (!hqd->on_hqd)
+		goto out;
+	hqd->mqd_addr = RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR) |
+			(u64)RREG32_SOC15(GC, 0, regCP_GFX_MQD_BASE_ADDR_HI) << 32;
+	hqd->offset = RREG32_SOC15(GC, 0, regCP_GFX_HQD_OFFSET);
+	hqd->csmd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CSMD_RPTR);
+	hqd->wptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR) |
+		    (u64)RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR_HI) << 32;
+	status = RREG32_SOC15(GC, 0, regCP_GFX_HPD_STATUS0);
+	state = REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, QUEUE_STATE);
+	hqd->connected =
+		state >= GFX12_HPD_QUEUE_STATE_CONNECTED_MIN &&
+		state <= GFX12_HPD_QUEUE_STATE_CONNECTED_MAX &&
+		REG_GET_FIELD(status, CP_GFX_HPD_STATUS0, MAPPED_QUEUE) == queue;
+out:
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	return true;
+}
+
+static bool gfx_v12_0_restore_hqd(struct amdgpu_device *adev, void *m,
+				  u32 ring_size,
+				  const struct amdgpu_gfx_saved_hqd *hqd)
+{
+	struct v12_gfx_mqd *mqd = m;
+	u32 wptr = lower_32_bits(hqd->wptr) & ((ring_size >> 2) - 1);
+	u32 *status;
+
+	/*
+	 * MQD dwords 32-41 (reserved_32..41) are the PFP preemption status,
+	 * mcbp_status_pfp: the offset and chained IB size and address of IB1
+	 * (32-35) and IB2 (36-39), rb_preempt (40: preempted in the ring) and
+	 * completion_status (41: 0 IB not started, 1 preempted inside an IB,
+	 * 2 IB completed, 3 IB resumed). The PFP saves it when the queue is
+	 * switched out of the pipe and resumes from it when the queue runs
+	 * again, at the HQD offset. That survives the reset for a queue that
+	 * was switched out. The queue the pipe executed has its state in the
+	 * PFP, which the reset cleared: restart it at the write pointer with
+	 * no IB to resume, and drop its work in flight.
+	 */
+	if (hqd->connected) {
+		mqd->cp_gfx_hqd_offset = wptr;
+		mqd->cp_gfx_hqd_csmd_rptr = wptr;
+		for (status = &mqd->reserved_32; status <= &mqd->reserved_41; status++)
+			*status = 0;
+	} else {
+		mqd->cp_gfx_hqd_offset = hqd->offset;
+		mqd->cp_gfx_hqd_csmd_rptr = hqd->csmd_rptr;
+	}
+	mqd->cp_gfx_hqd_wptr = lower_32_bits(hqd->wptr);
+	mqd->cp_gfx_hqd_wptr_hi = upper_32_bits(hqd->wptr);
+	mqd->cp_gfx_hqd_active = 0;
+
+	return hqd->connected;
+}
+
 static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock = 0;
-- 
2.50.1

