Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995E0CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 09:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3BD10EA11;
	Wed, 30 Sep 2026 09:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tC1+qXBY";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260B710EA11
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 09:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIGDvjX1yox4oc1bSMgjwEg3JUlPtbxEZzZxfUjppMEWHtj+bOJ9tjM+2V9fWPUctm+6WyZ9PNTT3qr2Y1NFQRQ1UolbEcwL2AUnW2WZ9SHGq5EWFBrVfbiCp6fewmZDsFt54C0qCGL89d0g7yrjYjMf+zrRZ0Ovw/giA6ctxGVUOp5/bUvy35fb8SZyQloiCDDyQms1vDeglVlHoChmZZoRN+RhSNmEooibj9UikuMoF8zk5IkU4oKufInaNLoo6XmyS41grU/r03CdofqVAQixx8zak1bA1+zRMwFL1UgRT5WxQJ/VGkRDgBHhsN+JtdMDUU2Gqb3VKFlAonKqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STWY8le5hSUwEtnqeQMZlzlHzhY+e5hJTWzo/k5lkeg=;
 b=cO9P3f9aefe3yOfA8nj9ZAUhKHihFFU3aS0J8a5YDONWhzWvaD7C4SHCDu0CyyrumG7fatT1HldmW+wEmE4q8xYx7jvQ9q0VGJBSZGq9CXn6HFcoCbbyRQEFFBlJ0irpCKwzKZ8aH6z0LwDqWM6JrAClDKegYGzYjeSrhN7W1i1acnY7pJrC/ac/ptMi7ctD+qNm+IctZTi6GsJAH5yDmQvb0tqIR4+MfEPQxdSkX0ezE/PqXm6g5ES/0gUY72ev6BkpYJ5rnD32XAQ6lFw7RcpTEPkSEX5TNNsoH/t0MzMm3VktVWR1CmxmeRRQWyRo+pCl7JfNjnb/61YJz0QBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STWY8le5hSUwEtnqeQMZlzlHzhY+e5hJTWzo/k5lkeg=;
 b=tC1+qXBY7y4/lPlDsPz7EWykHq+lFuvD3HJmWWi2efsO+Wfrjpsk8EfHn7Ean9+cOC7FiIstLUHyzBAAD29NfdB4lHl33drp4hWf8veTdyL5IIOcRS7BpMIA9Ej1nOMnFZaXckglX+YWrWhirMmR6LeTipRabFIWxBTnK6i8RII=
Received: from SJ2P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::11)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 09:12:12 +0000
Received: from BY1PEPF0002696A.namprd05.prod.outlook.com
 (2603:10b6:a03:5da:cafe::59) by SJ2P220CA0004.outlook.office365.com
 (2603:10b6:a03:5da::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:12:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002696A.mail.protection.outlook.com (10.167.244.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:12:11 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 04:12:06 -0500
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <Felix.Kuehling@amd.com>, <phasta@kernel.org>,
 <Qing.Ma@amd.com>, <HaiJun.Chang@amd.com>, <Heng.Zhou@amd.com>,
 <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: clear IH ring overflow on SR-IOV VF via PSP relay
Date: Wed, 30 Sep 2026 17:10:55 +0800
Message-ID: <20260930091055.395542-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002696A:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 7614e028-c37a-4c51-c52a-08df1ed2e965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wYKc9rDId8FJK2jIogwZpKND/kPE3BhW+dI7QD2qIeEbLqWQC6cMiAyphgrvYtB/AvAKB471psa6CDYfBV9Ua/YvF6i6ATBDaxSyTT+5DE4F3R3C1W8/jw+rwU0mpZq2U1TdEPeFZT9t7msFCebrbGKQIQ9bHwQHqxBwh+sfML8JEPQC09qV7CR+7+WmNSXJmCrxr6dXrc5bxDExyb5NYB2m7cxXbOquEohgXvzjlQ8xPHZVP5CIhVJ5duVX57kwmDSKIpU5NPAMkMD7XV20XrN/7uPM9AE8P8K+/XQwItBo6XjPMQUz/DzuI30BUnY3aByCF8/wODb9Wp3ZkoDoJatHb86lGMTsAEWfOjgbX0NJvJLJdIkoVltBL5bCFJOv+eUetyn62oa6tCNxbwNf3ph+5JLp/c6hoFGGNq6ERd19C3iIkv0FwOWOi8LHMV5GPKgwXQ3J4jXW77wAlCISxYjR6FVUhqG74j9daZDeeX1FuOrDznowGSqrVs7lhECaorAHJ7EQ3n28WJiepaOa7ONjgsiKmVan9dNsKD/6lpmfNLo7lcZJ7PraSKoP+71awIAZXK7OWCiowc7X0MkMCaCxkjMDys+K52qXvVn83Yo9SYYfSC+BkxANN4OP9KVqZMBO+gVhLHVT4QdsevPPda4ZJyof3HE4codwr8i3M7YuCQuoRXAU//VjEpgn112JQmgkJvnj3lGa2buHgMuOgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GniYZXADN39HzcOUF7xJ/u5A6fSxbjX3CIa506w5FbEawv6rY9U4f5WfDiF++1sWfH9/1htDDNxpyvHC2n9HGCDoqvq2V/keSbMEWAl4fjvezQZREKa3ztfZCus3GJjpJRM9tH3MP7ybRZMKWAskCNmJ4kJdPY3riRN4IMVPZIk+/Vxm0m+yJVR4IvImpvLRkOFAqVtvfZY6anirCD4LiZu3iKpBZV8S9KIrXptBCe7dylfsshe2JHWc/Bhtz0J99vi1tUjNk2TpoX0z0dXWvx1RAUma15YHvx+9W+/PRGuWFnPjRHM8nxAJj7tGOJ6HPh9SLHrCJ0ZUc/SCjtY6EKeMTu7zQnaakuyEWJeFMSVT5cfHz1KSevuIl4N8Lh8TccQ01ezYx9MTv7yHKdxKvJ1mJtNUlCp4HjQiyHMmuNor236qOJdve6Oqy2/8AkDn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:12:11.6367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7614e028-c37a-4c51-c52a-08df1ed2e965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002696A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

On an SR-IOV VF the IH_RB_CNTL register is protected, so the VF cannot
set WPTR_OVERFLOW_CLEAR itself once an IH ring overflows. Today the VF
marks the ring as overflowed and schedules an FLR from
amdgpu_ih_process(). With rocgdb on MI300X a breakpoint at kernel entry
makes every wave raise a debug trap interrupt at once, which overflows
the IH ring almost immediately, so every such debug session ends up in
an FLR.

Let the VF ask the host to relay the IH_RB_CNTL program command to PSP
instead:

- Add a vf_cmd_relay virt op, implemented for the nv mailbox with the
  new IDH_PSP_VF_CMD_RELAY request, which passes the updated PSP KM ring
  wptr to the host. The mailbox ack result is now propagated to the
  caller.
- Add psp_reg_program_vf_relay(), which submits the reg program command
  on the VF KM ring, notifies the host through the relay op and fails
  on a non-zero PSP response status. Once the frame is on the ring, a
  relay failure no longer rolls back the fence value.
- In vega20_ih_get_wptr(), when running as a VF at runtime with relay
  support, move rptr past the overwritten entries once, mark the ring
  as overflow_clearing and queue clear_overflow_work. Further calls
  return the real wptr without jumping rptr again until the work has
  cleared the overflow bit.
- clear_overflow_work sets and clears WPTR_OVERFLOW_CLEAR through PSP
  relay for every ring whose RB_OVERFLOW is set. It skips the work
  during shutdown or when a reset is in progress, and falls back to
  FLR if the relay fails.

VFs without relay support keep the existing behaviour of flagging the
overflow and letting amdgpu_ih_process() schedule an FLR. This
requires a host driver that handles IDH_PSP_VF_CMD_RELAY.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 56 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 15 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  4 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 18 +++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     | 73 ++++++++++++++++++++--
 9 files changed, 164 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b690a07e31ab..17066ec1891b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5427,8 +5427,10 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		cancel_work(&adev->virt.flr_work);
+		cancel_work(&adev->virt.clear_overflow_work);
+	}
 
 	if (con && adev->ras_enabled)
 		cancel_work(&con->recovery_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 8d74a89b40cf..c68b3d609acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -75,6 +75,7 @@ struct amdgpu_ih_ring {
 	wait_queue_head_t wait_process;
 	uint64_t		processed_timestamp;
 	bool overflow;
+	bool overflow_clearing;
 };
 
 /* return true if time stamp t2 is after t1 with 48bit wrap around */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 82a2684dbd2e..b78f7b065c17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -890,15 +890,19 @@ static bool psp_err_warn(struct psp_context *psp)
 }
 
 static int
-psp_cmd_submit_buf(struct psp_context *psp,
-		   struct amdgpu_firmware_info *ucode,
-		   struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)
+__psp_cmd_submit_buf(struct psp_context *psp,
+		     struct amdgpu_firmware_info *ucode,
+		     struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr,
+		     bool vf_relay)
 {
 	int ret;
 	int index;
 	int timeout = psp->adev->psp_timeout;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
+	u32 rb_frame_size_dw = sizeof(struct psp_gfx_rb_frame) / 4;
+	u32 ring_size_dw = psp->km_ring.ring_size / 4;
+	u32 wptr = 0;
 
 	if (psp->adev->no_hw_access)
 		return 0;
@@ -907,6 +911,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 
 	memcpy(psp->cmd_resp_buf_mem, cmd, sizeof(struct psp_gfx_cmd_resp));
 
+	if (vf_relay)
+		wptr = psp_ring_get_wptr(psp);
 	index = atomic_inc_return(&psp->fence_value);
 	ret = psp_ring_cmd_submit(psp, psp->cmd_resp_buf_mc_addr, fence_mc_addr, index);
 	if (ret) {
@@ -914,6 +920,12 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		goto exit;
 	}
 
+	if (vf_relay) {
+		ret = amdgpu_virt_vf_cmd_relay(psp->adev, (wptr + rb_frame_size_dw) % ring_size_dw);
+		if (ret)
+			goto exit;
+	}
+
 	amdgpu_device_invalidate_hdp(psp->adev, NULL);
 	while (*((unsigned int *)psp->fence_buf) != index) {
 		if (--timeout == 0)
@@ -975,6 +987,14 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	return ret;
 }
 
+static int
+psp_cmd_submit_buf(struct psp_context *psp,
+		   struct amdgpu_firmware_info *ucode,
+		   struct psp_gfx_cmd_resp *cmd, uint64_t fence_mc_addr)
+{
+	return __psp_cmd_submit_buf(psp, ucode, cmd, fence_mc_addr, false);
+}
+
 static struct psp_gfx_cmd_resp *acquire_psp_cmd_buf(struct psp_context *psp)
 {
 	struct psp_gfx_cmd_resp *cmd = psp->cmd;
@@ -2201,6 +2221,36 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 	return ret;
 }
 
+int psp_reg_program_vf_relay(struct psp_context *psp, enum psp_reg_prog_id reg,
+			     uint32_t value)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	if (reg >= PSP_REG_LAST)
+		return -EINVAL;
+
+	if (!amdgpu_virt_vf_cmd_relay_supported(psp->adev))
+		return -EOPNOTSUPP;
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	psp_prep_reg_prog_cmd_buf(cmd, reg, value);
+	ret = __psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr, true);
+	if (ret) {
+		dev_err(psp->adev->dev, "PSP failed to relay reg id %d program, ret %d\n",
+			reg, ret);
+	} else if (cmd->resp.status) {
+		ret = -EIO;
+		dev_err(psp->adev->dev, "PSP failed to program reg id %d, status 0x%x\n",
+			reg, cmd->resp.status);
+	}
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 				     uint64_t ta_bin_mc,
 				     struct ta_context *context)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index a4ec60f6c317..6cdb44d2160a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -662,6 +662,8 @@ int psp_rlc_autoload_start(struct psp_context *psp);
 
 int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 		uint32_t value);
+int psp_reg_program_vf_relay(struct psp_context *psp, enum psp_reg_prog_id reg,
+			     uint32_t value);
 int psp_ring_cmd_submit(struct psp_context *psp,
 			uint64_t cmd_buf_mc_addr,
 			uint64_t fence_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3ba254411642..96c8477e1a6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -113,6 +113,21 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
 	return 0;
 }
 
+bool amdgpu_virt_vf_cmd_relay_supported(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	return virt->ops && virt->ops->vf_cmd_relay;
+}
+
+int amdgpu_virt_vf_cmd_relay(struct amdgpu_device *adev, u32 wptr)
+{
+	if (!amdgpu_virt_vf_cmd_relay_supported(adev))
+		return -EOPNOTSUPP;
+
+	return adev->virt.ops->vf_cmd_relay(adev, wptr);
+}
+
 /**
  * amdgpu_virt_release_full_gpu() - release full gpu access
  * @adev:	amdgpu device.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 9957241bdf59..63cd65e1d864 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -118,6 +118,7 @@ struct amdgpu_virt_ops {
 			u32 param1, u32 param2, u32 param3);
 	int (*req_ptl_update)(struct amdgpu_device *adev,
 			u32 req_code, u32 ptl_state, u32 fmt1, u32 fmt2);
+	int (*vf_cmd_relay)(struct amdgpu_device *adev, u32 wptr);
 };
 
 /*
@@ -303,6 +304,7 @@ struct amdgpu_virt {
 	struct amdgpu_irq_src		rcv_irq;
 
 	struct work_struct		flr_work;
+	struct work_struct		clear_overflow_work;
 	struct work_struct		req_bad_pages_work;
 	struct work_struct		handle_bad_pages_work;
 
@@ -470,6 +472,8 @@ int amdgpu_virt_ptl_request(struct amdgpu_device *adev, u32 req_code,
 			    uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2);
 void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
 int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
+bool amdgpu_virt_vf_cmd_relay_supported(struct amdgpu_device *adev);
+int amdgpu_virt_vf_cmd_relay(struct amdgpu_device *adev, u32 wptr);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
 bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index eb537b2ae685..29018a598c3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -136,8 +136,8 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 	return -ETIME;
 }
 
-static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
-	      enum idh_request req, u32 data1, u32 data2, u32 data3)
+static int __xgpu_nv_mailbox_trans_msg(struct amdgpu_device *adev,
+				       enum idh_request req, u32 data1, u32 data2, u32 data3)
 {
 	int r;
 	uint8_t trn;
@@ -170,6 +170,14 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
 
 	xgpu_nv_mailbox_set_valid(adev, false);
+
+	return r;
+}
+
+static void xgpu_nv_mailbox_trans_msg(struct amdgpu_device *adev,
+				      enum idh_request req, u32 data1, u32 data2, u32 data3)
+{
+	__xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
 }
 
 static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
@@ -624,6 +632,11 @@ static int xgpu_nv_req_ptl_update(struct amdgpu_device *adev,
 			req_code, ptl_state, AMD_SRIOV_PTL_PACK_FORMATS(fmt1, fmt2));
 }
 
+static int xgpu_nv_vf_cmd_relay(struct amdgpu_device *adev, u32 wptr)
+{
+	return __xgpu_nv_mailbox_trans_msg(adev, IDH_PSP_VF_CMD_RELAY, wptr, 0, 0);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -640,4 +653,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_ras_chk_criti = xgpu_nv_check_vf_critical_region,
 	.req_remote_ras_cmd = xgpu_nv_req_remote_ras_cmd,
 	.req_ptl_update = xgpu_nv_req_ptl_update,
+	.vf_cmd_relay = xgpu_nv_vf_cmd_relay,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 5023113e7600..5e51c805c666 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -36,6 +36,7 @@ enum idh_request {
 	IDH_REL_GPU_FINI_ACCESS,
 	IDH_REQ_GPU_RESET_ACCESS,
 	IDH_REQ_GPU_INIT_DATA,
+	IDH_PSP_VF_CMD_RELAY,
 
 	IDH_LOG_VF_ERROR	= 200,
 	IDH_READY_TO_RESET 	= 201,
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 0bda48558d4d..dbaab8633f05 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -351,6 +351,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 				return ret;
 		}
 		ih[i]->overflow = false;
+		ih[i]->overflow_clearing = false;
 	}
 
 	if (!amdgpu_sriov_vf(adev))
@@ -402,6 +403,56 @@ static void vega20_ih_irq_disable(struct amdgpu_device *adev)
 	mdelay(1);
 }
 
+static void vega20_ih_clear_overflow_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, clear_overflow_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+	struct amdgpu_ih_ring *ih[] = {&adev->irq.ih, &adev->irq.ih1, &adev->irq.ih2};
+	struct amdgpu_ih_regs *ih_regs;
+	u32 wptr, tmp;
+	int i;
+
+	if (adev->shutdown)
+		return;
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ih); i++) {
+		if (!ih[i]->ring_size)
+			continue;
+
+		ih_regs = &ih[i]->ih_regs;
+		wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
+		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
+			WRITE_ONCE(ih[i]->overflow_clearing, false);
+			continue;
+		}
+
+		tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+		if (psp_reg_program_vf_relay(&adev->psp, ih_regs->psp_reg_id, tmp))
+			goto fail;
+
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		if (psp_reg_program_vf_relay(&adev->psp, ih_regs->psp_reg_id, tmp))
+			goto fail;
+
+		WRITE_ONCE(ih[i]->overflow_clearing, false);
+		dev_dbg(adev->dev, "%s overflow cleared\n",
+			amdgpu_ih_ring_name(adev, ih[i]));
+	}
+	goto out;
+
+fail:
+	dev_warn(adev->dev, "failed to clear %s overflow, schedule FLR\n",
+		 amdgpu_ih_ring_name(adev, ih[i]));
+	ih[i]->overflow = true;
+	amdgpu_reset_domain_schedule(adev->reset_domain, &adev->virt.flr_work);
+out:
+	up_read(&adev->reset_domain->sem);
+}
+
 /**
  * vega20_ih_get_wptr - get the IH ring buffer wptr
  *
@@ -438,10 +489,10 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
-	if (!amdgpu_sriov_vf(adev))
-		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
-	else
-		ih->overflow = true;
+	if (amdgpu_sriov_runtime(adev) && READ_ONCE(ih->overflow_clearing))
+		goto out;
+
+	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
 
 	/* When a ring buffer overflow happen start parsing interrupt
 	 * from the last not overwritten vector (wptr + 32). Hopefully
@@ -452,6 +503,17 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 			     amdgpu_ih_ring_name(adev, ih), wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
 
+	if (amdgpu_sriov_runtime(adev)) {
+		if (!amdgpu_virt_vf_cmd_relay_supported(adev)) {
+			ih->overflow = true;
+			goto out;
+		}
+		WRITE_ONCE(ih->overflow_clearing, true);
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+					     &adev->virt.clear_overflow_work);
+		goto out;
+	}
+
 	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
@@ -608,6 +670,9 @@ static int vega20_ih_sw_init(struct amdgpu_ip_block *ip_block)
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
 
+	if (amdgpu_sriov_vf(adev))
+		INIT_WORK(&adev->virt.clear_overflow_work, vega20_ih_clear_overflow_work);
+
 	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
-- 
2.43.0

