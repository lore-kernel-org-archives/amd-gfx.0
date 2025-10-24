Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3547ACCD1AB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 07:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1AF10E9E0;
	Fri, 24 Oct 2025 07:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e5Mx0SsU";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010035.outbound.protection.outlook.com
 [40.93.198.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6AB210E9E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 07:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxYIfyTloYx8aEGEDZKSj1yXA/0l6ofMbjMLuz0rgOTipb/vksAjArGRRlO6Lu8fnfc3hO2Lfo/RHtiJxD880H5TSrLAVErETv5PGZeal7DokhT409W6LrZ750L1phkVLaIdJiHWAx/A8vgTvozxkIe+lIm+fHiMKujY4vczBQIEjo9UIi6rRbcc6hCb/fb4dnADGRWILtVE3byCEWqhp2xZB7BC4st6anYd/743dLUGyxA9GCeqclhaWPVVJlwBQK4DJCosdzfk4Bn/xaecoOR/MrgxkUe9XW5g8mceuvsOuGKHAawIDXmZmo84g4OC7c7l6lSuTiedZMjxe3XsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9wRsfbaB39T3kNhVxhW0tR+X1E2VRFQ/Ka2mmieJmM=;
 b=SfjEZ1+RjGbRvQCxVDdqjUPe3eBgYthj8mxprDxJNcrPL9I6l8/yEGrZe3kWlS3h7z8GpqEvz8fO/0nR0ICZxyXjphSIrUU/t5PXw73Uwi902Yx2hFOgTIxbIh6kV6sLkoBYiGo8gwChW8LCcMqyOuElP0AdRtkzvSXtJuX3U2ATcq9NtNy19TDYPuJKgaCDn6AXPEeicCZ7tlDzInd1puBzJL03CxjFOcWwmvIj5Raqeo5XqcjSdLwNfq+CDR128AFwF/0nuv6mhK0AloYhunfMaNm73W16q4ffjJ/PAalFqMnLNxDSd/lC5yPx5QH1QtO/mMf1Vin9t+ktKgxlpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9wRsfbaB39T3kNhVxhW0tR+X1E2VRFQ/Ka2mmieJmM=;
 b=e5Mx0SsUuIPuZcCAqHuAPuE+LTOQto8KWSOk/8F6elGFxyMxywOhA1Ph3naH0T93KL3hrjNkmdG/YkuVQnjazEl/66IVFJlbPSvoKe7t+vko/1r/rdSQTskhIxPXgtPiWc6dg5AWwweMAf5JRxw1ZdQ1m2alQYAu5QprrjsELcE=
Received: from SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::28)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:02:19 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::bb) by SA1P222CA0072.outlook.office365.com
 (2603:10b6:806:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 07:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 07:02:19 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Oct
 2025 00:02:16 -0700
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>, <Lijo.Lazar@amd.com>, "Xiang
 Liu" <xiang.liu@amd.com>, Tao Zhou <tao.zhou1@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH v4] drm/amd/ras: Add CPER ring read for uniras
Date: Fri, 24 Oct 2025 15:01:56 +0800
Message-ID: <20251024070156.1501326-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b1c732-7e89-4516-9f3b-08de12cb45bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j0KpNXZVvwPryS9099iLwkdJUlxDLFocfgwVOlDezsyuggon0GInPSfmiB9J?=
 =?us-ascii?Q?F4gC8a03iBrCzp13JWLRLLZSwIfyCC/Le1tWtEqgMuok2moQE9yUh1XDeqBQ?=
 =?us-ascii?Q?K7PCJ8kTSs5GbsUgsJT85L8Wq9TComTz2+AfZy0jFak9bI7IZ8FaWJD6R2sU?=
 =?us-ascii?Q?VIJaxM5vjigZu9YKnYAtSJuyCyHCDrt4VOQWED7VwkiFZf88oW4Gz4rECFHY?=
 =?us-ascii?Q?5MdNU/82RK8Y/NnQAhDZ8HOAmKbO4b3ZaiFEiHZBAO0HbrR4UGQVNHt9UV9I?=
 =?us-ascii?Q?wymgvw5nUgNrbB7h7+ufe2I7RF4eE0LMaUxfzkwHGSbTvjc4BL1++5I071Dq?=
 =?us-ascii?Q?/NDy67I6IPjxMdQc5uVtaf79Vh/A/HN7ytDJx8+HMpmhoq7zANSzPXUja02b?=
 =?us-ascii?Q?Dz/Gf/DZWztAgouOPXFih7L8ULwcA12aSYdKKeBZ6FfGhwaqZiAZ1oTH44BL?=
 =?us-ascii?Q?wadMRemfgwnsppVaod36Hd91PYT/pxEzmaun8W6qhH6r6HT8jRuQWv63kQ73?=
 =?us-ascii?Q?EyhQ8yOIxyGMXcb29kTW9v6Kp3BsOCZLXCy/Gdi6J683YuarYVMVT5M9+C+L?=
 =?us-ascii?Q?EtPaaZuzwb3/5T8dLfYMysrJkr872qwveVEoS/FF7Iu3xHavxE+h5kcGaxHQ?=
 =?us-ascii?Q?aw2HunRi1xG3Ua/LOOnX/G0qu6Yc122Nlx1HyOO1MdhEaTmQU+F+PCOZpXD2?=
 =?us-ascii?Q?yXpQ7OIex2bF6wSXIa6korxrfaCSEJcUTVgYamT/AfYJTHbktypQ2hGSbhQx?=
 =?us-ascii?Q?nDJUxmTn1lPwmmMqBzlCxuuIeo7xZXGrYHRIhOgRY9H/CTlbeUNkwnPp1MoM?=
 =?us-ascii?Q?KFWlMuvNUWy2CmwfxjGS2qdBK3fwzF22KD9K2+SsZWRoMCJsNRPs3Kyg+JzB?=
 =?us-ascii?Q?Am2hfAExpwvhMDLErNQGn9D/lMc8HWS7E6d88MZTSIdDxJc0vAt4AbPwpq8R?=
 =?us-ascii?Q?Myo06Oa3TlQOgqYFwk2f4+Fh+IfnS/+kfnHUPVtrK/W+gGsoMgmacShzolDN?=
 =?us-ascii?Q?0TKxK3jF3zXg8syOrBYJsaNmyT24SSyuoktUp2fksJF9CLh0hInA8HZuWc14?=
 =?us-ascii?Q?2s9q43yeZaodK25SfnAfcHc1V4nL1EwdU+0BEPxnrPT9ri2cm4ERjZfbfyR1?=
 =?us-ascii?Q?520QNx+Ub33iH9dNFMQ1Ybspl8nxHGkxqnxwdqsri6MbBoBWcCHSt8sMXrWI?=
 =?us-ascii?Q?2UIdUUgDBpMwPTq36f8dTFnwGkq90xER4Ai5dhhgqi5t2SzR086XaaA0oOP1?=
 =?us-ascii?Q?+Y72MJ+Gk/FM3mEfRq/gkle+HDqYkR+TSujkRElJ2fCglk7flRuOP6TAIkmc?=
 =?us-ascii?Q?ozl369eFDR5xwqB5RuB1sw5j1/uoDDFGgIDumskQrLsuFVlf3GTgqjv9Zw4C?=
 =?us-ascii?Q?qlJw9UotzGVBjGKzeLL5U2rLb8rvRiFw+W3EeUJUK9iIwoCc+UMzwiElAdVP?=
 =?us-ascii?Q?l/DN/GIMQCCjMur/M3md45bw+TKrIFizcrESK2KNZaKuxTjGbcbeQAR/tuv1?=
 =?us-ascii?Q?udoYQtNJNqXSR8XUH1esBL6s4kbqHHFJzahAt1GGrBlFPNI/ttXndIXECAvs?=
 =?us-ascii?Q?rBwC5H+i+YLRn7idJpY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:02:19.0190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b1c732-7e89-4516-9f3b-08de12cb45bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
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

Read CPER raw data from debugfs node "/sys/kernel/debug/dri/*/
amdgpu_ring_cper".

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      | 58 +++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 603cc155fd9b..66ccd31f1e8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -110,6 +110,7 @@
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_ras_mgr.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 5a7bf0661dbf..011fa4748084 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -770,7 +770,8 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
 
-		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
+		if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
+		    amdgpu_cper_generate_bp_threshold_record(adev))
 			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
 
 		if ((amdgpu_bad_page_threshold != -1) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index f26002b25de4..47488ea22c49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -491,6 +491,61 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
  */
 #if defined(CONFIG_DEBUG_FS)
 
+static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
+					    size_t size, loff_t *offset)
+{
+	const uint8_t ring_header_size = 12;
+	struct amdgpu_ring *ring = file_inode(f)->i_private;
+	struct ras_cmd_cper_snapshot_req *snapshot_req __free(kfree) =
+		kzalloc(sizeof(struct ras_cmd_cper_snapshot_req), GFP_KERNEL);
+	struct ras_cmd_cper_snapshot_rsp *snapshot_rsp __free(kfree) =
+		kzalloc(sizeof(struct ras_cmd_cper_snapshot_rsp), GFP_KERNEL);
+	struct ras_cmd_cper_record_req *record_req __free(kfree) =
+		kzalloc(sizeof(struct ras_cmd_cper_record_req), GFP_KERNEL);
+	struct ras_cmd_cper_record_rsp *record_rsp __free(kfree) =
+		kzalloc(sizeof(struct ras_cmd_cper_record_rsp), GFP_KERNEL);
+	uint8_t *ring_header __free(kfree) =
+		kzalloc(ring_header_size, GFP_KERNEL);
+	uint32_t total_cper_num;
+	uint64_t start_cper_id;
+	int r;
+
+	if (!snapshot_req || !snapshot_rsp || !record_req || !record_rsp ||
+	    !ring_header)
+		return -ENOMEM;
+
+	if (!(*offset)) {
+		if (copy_to_user(buf, ring_header, ring_header_size))
+			return -EFAULT;
+		buf += ring_header_size;
+	}
+
+	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
+					  RAS_CMD__GET_CPER_SNAPSHOT,
+					  snapshot_req, sizeof(struct ras_cmd_cper_snapshot_req),
+					  snapshot_rsp, sizeof(struct ras_cmd_cper_snapshot_rsp));
+	if (r || !snapshot_rsp->total_cper_num)
+		return r;
+
+	start_cper_id = snapshot_rsp->start_cper_id;
+	total_cper_num = snapshot_rsp->total_cper_num;
+
+	record_req->buf_ptr = (uint64_t)(uintptr_t)buf;
+	record_req->buf_size = size;
+	record_req->cper_start_id = start_cper_id + *offset;
+	record_req->cper_num = total_cper_num;
+	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev, RAS_CMD__GET_CPER_RECORD,
+					  record_req, sizeof(struct ras_cmd_cper_record_req),
+					  record_rsp, sizeof(struct ras_cmd_cper_record_rsp));
+	if (r)
+		return r;
+
+	r = *offset ? record_rsp->real_data_size : record_rsp->real_data_size + ring_header_size;
+	(*offset) += record_rsp->real_cper_num;
+
+	return r;
+}
+
 /* Layout of file is 12 bytes consisting of
  * - rptr
  * - wptr
@@ -507,6 +562,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 	loff_t i;
 	int r;
 
+	if (ring->funcs->type == AMDGPU_RING_TYPE_CPER && amdgpu_uniras_enabled(ring->adev))
+		return amdgpu_ras_cper_debugfs_read(f, buf, size, pos);
+
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
 
-- 
2.34.1

