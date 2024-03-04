Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2779C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 05:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C38610F1E2;
	Mon,  4 Mar 2024 05:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DGiwRy0G";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28BB710E879
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 05:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRp0j+6HaQUQlGpB2AfZDxNLF3wbaBXLPGcDGe8CH9+YD7DUmM7tTkNM59TPGMD+V9HRDvH74uieNPcff6xPf5EXjqYQjayE50sPxZlIPNRkmfHcx5OyODpaWhcdEAnxssgbwsRV8CeivWlvTWLh25uWOLfRIY42dbsTXXVv2Pfh+Kjo9dTGzI/M89qacnXRdAPrB8Se4NZ0nDXGmFHDr1VJGoD5v7afh37UGYuW0yIrEFBdgDJiXnkfFUWbaQ8s/8yhX6x+7KOawK1m50Bt0IzK4qCXuEHbsCSWt+E6R9XMozqdwEVR/0TKyKBs0cBB6X/WKe8N/cPzvZCR4Jp1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2wC6Exwij+n4GCmy7FNnbqPZMaUPHw9pX/q5V/JHX0=;
 b=PdIGgv5aF9992ndrU5p0K4q/gauYbGIr2vzcAZo/95nRnkZFI+cZh3lhNL4xKeY7U2svVdJ2Rg5HebGViEk+uGmODxp2ZI7ctdWdP0zYkEOH97AJ5WplFjTyQ3STOSlfJpqUyww2cwOeJU+l8dSutP3HAjsIS21cQFGWWSBrK09DvT4s+CuNI0pUYrMY9RajxmemKAtqWudz27JoVdIVW/JcIjDYpF9iJFsg1GsCC7PIuAZ+L29DyJNz+LuNAFAcTQhCD3iqJ0H2AaOLhf5fzvNbXesUMvzgiGy/u9CNUkHVQcYme9kHYD2yBv24xC3aqFGVQ1c51yiSVzDBHYkh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2wC6Exwij+n4GCmy7FNnbqPZMaUPHw9pX/q5V/JHX0=;
 b=DGiwRy0GWwGfwFChfV3SMqp8vFCkEY/BHEyM5RgPcejopMp75+4x2FalsLlmoP/1n18GYgJn7/lnWE2H9NK01euy//T15CgPR9SZiaIcNnJU97GmD+5G+V5BrFS381cJJ0z4OXVzIfBa1LDZMXzL/3oxPQLq4MvPqJltuo5p+TA=
Received: from DM6PR07CA0126.namprd07.prod.outlook.com (2603:10b6:5:330::9) by
 MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Mon, 4 Mar 2024 05:14:18 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::e3) by DM6PR07CA0126.outlook.office365.com
 (2603:10b6:5:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 05:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 05:14:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 3 Mar
 2024 23:14:17 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 3 Mar 2024 23:14:10 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <jay.cornwall@amd.com>, <jonathan.kim@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdkfd: fix shift out of bounds about gpu debug
Date: Mon, 4 Mar 2024 13:14:04 +0800
Message-ID: <20240304051404.305852-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f974dd-428d-4f26-315c-08dc3c09f146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plVenbLB6f9VsSu9CtRpUuWGCCuOM42wrhd3QFIZ7IxuKLp43jkAK1OL+XNDNXHZkwka+p58/wd+1lXikX+/aOrtUIqYBy0PXtMJTEe6X3uhhJktOcjyHBHM1Q+VOLsfRfzluyaIxdJs+stCWy0cqeZGQZVKViBRc4r/9Hie6cOnUL3UNJjXP0iMN3PYIblA33aMlowqZrq5mznnQZYr5BLMxLeOpFMdNkW41poRMpTO1Fvi6rzZFnwa6onDF3DrFVCOlbIO0QPFTpBqODiHV4e6u4lw/svCXLaL8xR+xp2K7mrjwIsHRDjXnjeSndhE9D+L+4sD0HFbUBxnYIv8uUFeOJrm14kfXGJEzwfb21B31U48U0H8jo81u8bFyLi1JzEBvKP0UySrxHrJX51GJe74iy7+K9mBsW1ClKnyQQPWBuVzk2zTbUBdEOnH5YAPBxaYp1tCFVxzX3aG1mqJRhbGubgslwg60gEtSkU6xwhG/Ce4zdrZsH+zO2XTcu29JpUX64jlnK3WuwUvtvSgnbK514ux30lSon1Vucy8FfjCh2FNPiBCvUHm0jnUvVoblhErjlZGv6Ad9G7tr7rCt8Xh7UFKJVx0V5OdkK8Ue4PSAmcwlnV2ISykpn/hVv+47lWx/CxFNvchFNXUUo2nC1TG4yuNQVFZIxvWlK8BUDd/lMhX5nSqoNuEWRsP4J62b/47MMmdYq7wgal/FmTp+wDMe2M+p1wGn3attw0l5SRgxmVJ0+ArqgqcHd/Pwyd5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 05:14:17.8955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f974dd-428d-4f26-315c-08dc3c09f146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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

From: Jesse Zhang <jesse.zhang@amd.com>

[ 3810.410040] UBSAN: shift-out-of-bounds in drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v10.c:345:5
[ 3810.410044] shift exponent 4294967295 is too large for 64-bit type 'long long unsigned int'
[ 3810.410047] CPU: 6 PID: 331 Comm: kworker/6:1H Not tainted 6.5.0+ #508
[ 3810.410050] Hardware name: AMD Splinter/Splinter-GNR, BIOS WS54117N_140 01/16/2024
[ 3810.410052] Workqueue: KFD IH interrupt_wq [amdgpu]
[ 3810.410273] Call Trace:
[ 3810.410274]  <TASK>
[ 3810.410277]  dump_stack_lvl+0x4c/0x70
[ 3810.410283]  dump_stack+0x14/0x20
[ 3810.410285]  ubsan_epilogue+0x9/0x40
[ 3810.410290]  __ubsan_handle_shift_out_of_bounds+0x113/0x170
[ 3810.410292]  ? ZSTD_decompressSequencesSplitLitBuffer_default.isra.0+0x1389/0x1b50
[ 3810.410296]  event_interrupt_wq_v10.cold+0x16/0x1e [amdgpu]
[ 3810.410523]  ? raw_spin_rq_unlock+0x14/0x40
[ 3810.410526]  ? finish_task_switch+0x85/0x2b0
[ 3810.410528]  interrupt_wq+0xb2/0x120 [amdgpu]
[ 3810.410692]  ? interrupt_wq+0xb2/0x120 [amdgpu]
[ 3810.410806]  process_one_work+0x229/0x430
[ 3810.410810]  worker_thread+0x4e/0x3c0
[ 3810.410811]  ? __pfx_worker_thread+0x10/0x10
[ 3810.410813]  kthread+0xfb/0x130
[ 3810.410815]  ? __pfx_kthread+0x10/0x10
[ 3810.410816]  ret_from_fork+0x3d/0x60
[ 3810.410819]  ? __pfx_kthread+0x10/0x10
[ 3810.410820]  ret_from_fork_asm+0x1b/0x30
[ 3810.410823]  </TASK>

 -v2: define a macro. KFD process interrupts v9, v10, v11 can use that check prior to mask conversion
      and user space may find it useful as well.(Jon)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  | 3 +++
 include/uapi/linux/kfd_ioctl.h                   | 6 ++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 9a06c6fb6605..110ec5f71056 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -340,6 +340,9 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 			}
 			kfd_signal_event_interrupt(pasid, context_id0 & 0x7fffff, 23);
 		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
+			/* filter out the invalidate context_id0 */
+			if (KFD_DBG_EC_RANGE_CHECK(context_id0))
+				return;
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
 				KFD_DEBUG_DOORBELL_ID(context_id0),
 				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 7e2859736a55..c28cafa4b902 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -328,11 +328,15 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 		/* CP */
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
 			kfd_signal_event_interrupt(pasid, context_id0, 32);
-		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
+		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
+			/* filter out the invalidate context_id0 */
+			if (KFD_DBG_EC_RANGE_CHECK(context_id0))
+				return;
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
 				KFD_CTXID0_DOORBELL_ID(context_id0),
 				KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
 				NULL, 0);
+		}
 
 		/* SDMA */
 		else if (source_id == SOC21_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 91dd5e045b51..89dbefbd3081 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -389,6 +389,9 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 			}
 			kfd_signal_event_interrupt(pasid, sq_int_data, 24);
 		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
+			 /* filter out the invalidate context_id0 */
+			if (KFD_DBG_EC_RANGE_CHECK(context_id0))
+				return;
 			kfd_set_dbg_ev_from_interrupt(dev, pasid,
 				KFD_DEBUG_DOORBELL_ID(context_id0),
 				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 9ce46edc62a5..9cd3aa83aac3 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -922,6 +922,12 @@ enum kfd_dbg_trap_exception_code {
 #define KFD_DBG_EC_TYPE_IS_PROCESS(ecode)				\
 			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
 
+/* Check for exception code range for KFD search  */
+#define KFD_DEBUG_ECODE_SHIFT         10
+#define KFD_DBG_EC_RANGE_CHECK(ecode)				\
+			(!(ecode >> KFD_DEBUG_ECODE_SHIFT) ||	\
+			((ecode >> KFD_DEBUG_ECODE_SHIFT)	\
+			> EC_MAX))
 
 /* Runtime enable states */
 enum kfd_dbg_runtime_state {
-- 
2.25.1

