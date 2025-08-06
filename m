Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A1AC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8794810E70A;
	Wed,  6 Aug 2025 02:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XoH19rue";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2459110E70A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhM4cFNrCNJRqQPq+wO2IZrPLVJeYVS6ADt6Bi5OEkmWGoa/TlFZxTHilhmUEDW5AJLFcTYGEp2nEPRb9ZRsJT/z38SomBCGot4/x2a9tGOCqxdHxP5C5OQUENC1nuAtL7sVPKQde1C/Xw8ENSS1bGxZffPi4Xfngw3MGl4Oav9JaRsapA2XQvJnfIc23rZFOTOEgfROHAls+jBz5pbw5yCa0cOS3UX1n7Kipr5p/1J4altuJOZc4E78UIsN0NJShaP8UlXzm1eq0qXOYZZlAzIaJnA4Cw2+0EJGrzyo0h3flrB/5f3btx5Te6NuFKEZZ5bHVCidOQ6SDe2tWfYGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sH/ANUyXtBZFgKsJVjYnQsbfhhHR3hHPsFieDCEFyU=;
 b=dYUmAfgw1VWS9NpwWFR9xN1nHUht8CFO12URFjTBpnRMAU5buQNxaIWWaVGJM0ZMDeCYLTOsH7b0DLu7OAlTIXpl4zAI77MY+BOLidD/Qu0sbEa3NFydJrrAxyUsTg/acgXSCB68DcNUo0y93nTpFAowDcxPQikedLRwJ5j6M3hAisgjp0DeKkIFDdY7URwR8ftCqvILMTZ/GEUD58Sw1IwwWBSpu/pH3jMSn7bRZRIKLCW82h/gQ20U9I5qRZhuoLzrcDzK1EehfBKUFkLjxPlGnPt6Dja164wAmFcFrcAuW8aoPE2ziQik0IDJCAILvSlTTlZ9EnHpkp1/8sCW4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sH/ANUyXtBZFgKsJVjYnQsbfhhHR3hHPsFieDCEFyU=;
 b=XoH19rueRcdxCs+A8sz0Bg1hdFAHyQuFnnwBQumVMLgSPCkXe/6XgQoQw+cA+R6NQZ18CeVU9s+fInDF2+Yr1T1DwpVV4ZJVbbie4YgDZ0oYnLpZUkMDFAh8eascdNG7PnEFG+8S64J8ZoJGshS9+n4815yGb0VSwRTRe6EEQyw=
Received: from MW3PR06CA0003.namprd06.prod.outlook.com (2603:10b6:303:2a::8)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Wed, 6 Aug
 2025 02:29:15 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:2a:cafe::3e) by MW3PR06CA0003.outlook.office365.com
 (2603:10b6:303:2a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 02:29:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:29:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:29:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:29:11 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:29:04 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v7 08/11] drm/amdgpu/userq: add a detect and reset callback
Date: Wed, 6 Aug 2025 10:24:53 +0800
Message-ID: <20250806022816.1050823-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c382dd-ba48-4617-246b-08ddd491092d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?seBkLEVo3b+p3EtqRYwDCS5u4SLSJljA1gP+/si8IwJO5YdZlzzMdznUf0LW?=
 =?us-ascii?Q?+sp6wxcGj6YCAyqBTup2hOH8+cRNuaOjjl1PfkAOyYLsv7PRsPHkA3N2tndG?=
 =?us-ascii?Q?b0a4DmBULa9glrUanzxkWFsNLH3vPP1kD/d8gE1rUhkWhsRnvmm9KWeAjffF?=
 =?us-ascii?Q?A9rO0wwOg/VWopPFSPU7djVuUoEmIlC7HTtFnem91WIRgplCzjmGLeG+Nxym?=
 =?us-ascii?Q?QsShnCW188kyvdCLTGGE8fMznWD9GV8gxteEpPgRLT6nGcPZiCtoeoaydzAC?=
 =?us-ascii?Q?RWCzIywcp2IK9cFLgZiL1x3uY6Q84uMYCpTv9y5XDpv5Drbix0RHs+CVGtrN?=
 =?us-ascii?Q?DhZlhVz1N8VxuSFBDNHj8roGnue+sU+nK2wiD83JJ+SFDyANpfrPDMPw6C+m?=
 =?us-ascii?Q?D0MmhNKpdFjVE20l+kqen1nAjz/1ipgvc2AruUoNPrrLG1Xvbx0HnorxypP6?=
 =?us-ascii?Q?Qp0k6hMIQKdurrUl/dp7bnP/UTfiAglf2O42LXC5QNGqHqpwHacYHaR7+iPV?=
 =?us-ascii?Q?FAWSwSx2p7kjkzTS0bCjSeUPKUlTc8KLWp7WIh7ZzRTzz/So2EPRnI8VQ4Gd?=
 =?us-ascii?Q?zwHWMgcS2ORhegCGbtOubzWLFJCK4cbIhrkp90incO+Egyx9J41KiDN+hkNN?=
 =?us-ascii?Q?T/AIC9wHvrd3lUbCMRCkhycImRjQjLNUN8y++wpqiR0UaaL6ApHaK6R/b/id?=
 =?us-ascii?Q?F88RvhpgkkWmxssSZj/o8vs4vW5EUrbQDys8FK7djrYZm+bkkdTTDkbZcwf2?=
 =?us-ascii?Q?fBIeLpbQTyli0w4dx6EU16n0kui+mC27Sphx7uJ3Qlf52Q2NtFJZIqOorGx4?=
 =?us-ascii?Q?Rh1RNdG0R18AMslsGiDg59+Av3LNBcZYaiZNdJH8mM8igJI1ZQAdgKAWZWeg?=
 =?us-ascii?Q?kzD5zFH90aIC3VzfsrT5oF7kDWEKPuW139P+pOjOQmarMaG/qt3vm/usGucQ?=
 =?us-ascii?Q?1j25GYhTcWtB5rEtJpwbkooODUBJMqLgqRa8WfeJANukhliRmV2MncYwYefk?=
 =?us-ascii?Q?7s8ZpFiTGnEyXzZl2s0gMHmudjc2txHwX6fznyJbkbHaU5eW6jZvW5Lf//ZV?=
 =?us-ascii?Q?s+jau8tUQ02MmwID84gZsIKL0ao70EoVM/Op4Xz6TfJZMXJ2fGXCAMKoWZ+e?=
 =?us-ascii?Q?TIy4FtL+gNfaIhfE5uBSmyrcqJlflrPUZ48P5iDmSqvxx8gihTbG6zEerOc1?=
 =?us-ascii?Q?8PtpSuPOCd52nLDwfunkSjNEoHAa4jqcfyOYrHW4mZR31WThQjO0L1IRb79o?=
 =?us-ascii?Q?q+n1YpkguVX90qdv2oKqlM3ytSrIVrQqqDOcgQUB42Z6/5pfYGvpaJ9RgMzr?=
 =?us-ascii?Q?Y51GLdxAiOKN51hOvnOFnK8oxo7WZpBaQHIoKO1l06ucT481ntoNH5VCsDwL?=
 =?us-ascii?Q?e8sMdxlHuvmeRBhiXeXrs1ZmHJ8IiypVE3heMmbCySye52pKc1kt+Zb55PRG?=
 =?us-ascii?Q?F54nMseEPBhAGJQB40na2vHY2CEUYQGAWU/9MZyvV30LxrcmGd2wwY/IkfA8?=
 =?us-ascii?Q?LaU6/xK6s/TObLWzT5155qO8LBiNQ3NuO/IK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:29:14.4441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c382dd-ba48-4617-246b-08ddd491092d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141
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

From: Alex Deucher <alexander.deucher@amd.com>

Add a detect and reset callback and add the implementation
for mes.  The callback will detect all hung queues of a
particular ip type (e.g., GFX or compute or SDMA) and
reset them.

v2: increase reset counter and set fence force completion
v3: Removed userq_mutex in mes_userq_detect_and_reset since the driver holds it when calling

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 49 ++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 5111d7dce86f..9fa0d1a88d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -81,6 +81,8 @@ struct amdgpu_userq_funcs {
 		   struct amdgpu_usermode_queue *queue);
 	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*detect_and_reset)(struct amdgpu_device *adev,
+		  int queue_type);
 };
 
 /* Usermode queues for gfx */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 46b24035e14c..180bd4347bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -21,6 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
@@ -198,6 +199,53 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
+static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
+				      int queue_type)
+{
+	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
+	struct mes_detect_and_reset_queue_input input;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	unsigned int hung_db_num = 0;
+	int queue_id, r, i;
+	u32 db_array[4];
+
+	if (db_array_size > 4) {
+		dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
+			db_array_size);
+		return -EINVAL;
+	}
+
+	memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_input));
+
+	input.queue_type = queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
+						    &hung_db_num, db_array);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
+	} else if (hung_db_num) {
+		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+				if (queue->queue_type == queue_type) {
+					for (i = 0; i < hung_db_num; i++) {
+						if (queue->doorbell_index == db_array[i]) {
+							queue->state = AMDGPU_USERQ_STATE_HUNG;
+							atomic_inc(&adev->gpu_reset_counter);
+							amdgpu_userq_fence_driver_force_completion(queue);
+							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+						}
+					}
+				}
+			}
+		}
+	}
+
+	return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				struct drm_amdgpu_userq_in *args_in,
 				struct amdgpu_usermode_queue *queue)
@@ -403,4 +451,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.map = mes_userq_map,
 	.preempt = mes_userq_preempt,
 	.restore = mes_userq_restore,
+	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

