Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A1CCD18A
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC4A10E2E1;
	Sat, 11 Oct 2025 07:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUaKR6G/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD8D10E2E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6m6akyggJD8WkrCdYg0RHWAftKYlfmoUbGM06XQ55x1b4x5L5YMNqh0cKDjMRlJzbAz2d7a54Sxpx9VACie8JClj7+13jZlsX3HaOAFIZtqcjhwm6TH+Bb0rT8hIifu1Y5GyQZkJ7VPeEIHLgIQVjvPHQjqf2JzmXbSc4eQ41dbOEauF1l2/SiO7UFSMXPUgvZBc5rSO/sgSp86zT6kCxO59LYaNa05K5xZNESQ7MZ7Xin/8v4XfK6CzhK8oxZm1mpsSLZjgY3duz7eKIdqi7B1LBhFmed4De+pv6QnHPj99j34GuxUdD01Vou1cYwLjt+3VZDeG3pShsFld6s8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC1PNUowvFMH2QRC1ZfCOIynBjrmYPC9bK5eGdNfkso=;
 b=WanIPQFMq3Bt5GI6dLsnxsopUyqgpPtIbF+4ikuWvvNvTN1K/lbHO8LtrtuWDfx1HV+IkZSUkRwZUiGEGHWG9toOSeA27HQ5Lk9R2vNRjUQNp+miF3jklhbDG/vc7cW52SK044oeAO6KLam3AFTmg9FiD7VN41W2qmsS/Enu/6Ezl1YCShcXcn6PwdRGj2qGMGWo98LTWKZQ76MyOv9GRC08A2h9U5Z5YT5vjQ1wWs8Jp6oeOFg+bteuxYKW+Ebm8VDTpPPZYqpUMS+E8OunYm9ZyYnIp8u3s3xROV/t6Dq5cGGTqFAxXfu1B4hF74KS6aDLn3uE9VDXHzpKbKpREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC1PNUowvFMH2QRC1ZfCOIynBjrmYPC9bK5eGdNfkso=;
 b=YUaKR6G/ecJ93iX72Sl6aBCApkR9uh0xFwsYY1AjyN/Ue7YkPUVB5ytc8T9rqJ1djQlNG1kv3V41KyJGiMS8x47zicf8y70Zhy9F+54I3lSA7BLr1XK9JUEZnEd3W2wBONWbRCO9jVRxMNXDjuOxOA7QDzuIx8wpvVbv+YxehBc=
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 07:50:16 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::9f) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Sat,
 11 Oct 2025 07:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:50:16 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:50:07 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 7/9] drm/amdgpu: Add poison consumption sequence numbers for
 gfx and sdma
Date: Sat, 11 Oct 2025 15:48:09 +0800
Message-ID: <20251011074811.533871-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011074811.533871-1-YiPeng.Chai@amd.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 07956b8a-766c-4b43-1951-08de089ad150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u/MB3OwClXim8n3BiuEdVaOSHj66Yaz8ez3GCzNrqf/a3wqGNVmJ1LCRQzv5?=
 =?us-ascii?Q?sl+rDlX7RzDPo5TPBCCHhK8Z3C+tcwhLkT98CS4Bn6CyiCCUKXP+W4KkIKLz?=
 =?us-ascii?Q?z1jSIwgEOBmo70GqfeoWr0Ahjp3Pswgj5XY8cBprpYF2qEeOWu35dLgVsnII?=
 =?us-ascii?Q?L4Q+PPssm/FEtJThw9y0IHdxGeqxvTAD9LYZ9AAom56zf8mXjlbnDhpyN7K6?=
 =?us-ascii?Q?qD1HwYO+f1al79w9hSKHMBx9g8rdF0qjzJTzzqdp5i+sgHrxRe+wJUHDu27h?=
 =?us-ascii?Q?uUhoBGOZFCPWyyoVujSv8gUBwYywCuQB9ZXIKym3l1499gK7doVL38SqcIED?=
 =?us-ascii?Q?89mRdac/r30hvkLOOKawQcOjpVKyeoG5D6SIarqUWXr7zUqEefiMW5go3yXM?=
 =?us-ascii?Q?cZ+mE8oyQ/uiYevY1Vt23C/cEvRFSdUUtws2IsuMBR9Q8qCAjb3UlxBadR24?=
 =?us-ascii?Q?wA6THn93DlQsXO0/TNbD27UFTuANi+405cFsJ5c1AUCEYrJ5WRyr8DIDnXoD?=
 =?us-ascii?Q?aK/zc+7pQ9imZsI4s7IPMoDikw6JGEr0hTJkG94DLl5+7/f9uJNiygVkO6P8?=
 =?us-ascii?Q?20vzdl7EtsJ073xaQs3wYRi56vCqd9EhRm97s+BCqbZrO1r1t0i9zm2jzEKc?=
 =?us-ascii?Q?eSvS7sN5ylC4Nv84UmS4Q/vkW7GX5VZFatIUzjcEYcjHKeCTXXwU5xaWwq54?=
 =?us-ascii?Q?8tP69fV3JxPuoH6OH6JpQyAsoxMPGLgPw8LxsCiWh19gkwJpIuOiv50oKe77?=
 =?us-ascii?Q?tyfksX+firVwrTYd3A2wIZl1k3CcFTLmY5thqjWPQCPsFYjUvRpudFhLFags?=
 =?us-ascii?Q?dpMzewO+Qt+FJQqnaiEbdhRLzCxVSEHM6HgEblAZTFFMK4TjZPF9KnPJPo9c?=
 =?us-ascii?Q?R/m2gaL7J/9HAKw8CBxPIQHQ2zwgvQgNlHsxmNNDDFfCFHebPfb5XDFfXbIw?=
 =?us-ascii?Q?isbWl5aoQTVkkihYBIReqNyTlMeoF/gpEKkQLGSVIWgJaPJgkL9yKgherVo/?=
 =?us-ascii?Q?qk9cXVudqgZHgvrzcjMJeTt8+V/CFju+tTFub+TQCDYaGRfkSN8K1AbPetTF?=
 =?us-ascii?Q?G/Q5fSldNPdPOQiIz4caLT/YrhjziNl5mfdJGwoIvXxS/a2AmVitaAtza0oe?=
 =?us-ascii?Q?wpjZBMDx7zVj4950Hs3QehwiuuX82uuVY/D4RgOdF9oEKuqcT2kdpRCHL0/S?=
 =?us-ascii?Q?z1vor/TKYO38e+ky+kBiEHXg3B9VWmG0alBIRAI7aoyk5P9/knSeTHlXWEik?=
 =?us-ascii?Q?1kLJ3AyPzebu9BMV6/S1RgA4tA4MaWWvo1ajhLal9e0MI5DlHx4niV+YTgCN?=
 =?us-ascii?Q?vh4L/+zHqdm75nqZOddP8rc4cbhs04Wri0YYoSn5P98o3tXtT5LokQig34Tk?=
 =?us-ascii?Q?rhnFdUiULRL4osHTNFChXiTfCFh7jCSg/XTZMMr5wSoMjAUyQoJOOZ7VRqsw?=
 =?us-ascii?Q?GLV2S0o2qWC35vbv7L6pB8P98NaYqg4xFScC9v4hqhEBxy7SiU000cslQZ/Y?=
 =?us-ascii?Q?BJwxYTEfnRULdiQjtrCMqxoUkR/zfUZB406Vt0oMF5sFNI7g7IneKwfBiaod?=
 =?us-ascii?Q?HGnuNzliUodUx7MUzRc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:50:16.2323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07956b8a-766c-4b43-1951-08de089ad150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134
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

Add poison consumption sequence numbers for
gfx and sdma.

V3:
  Use RAS_EVENT_LOG to print ras log info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 4ceb251312a6..d76fb61869c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -28,6 +28,7 @@
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_ras_mgr.h"
 
 /*
  * GFX9 SQ Interrupts
@@ -228,7 +229,11 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 
 	kfd_signal_poison_consumed_event(dev, pasid);
 
-	event_id = amdgpu_ras_acquire_event_id(dev->adev, type);
+	if (amdgpu_uniras_enabled(dev->adev))
+		event_id = amdgpu_ras_mgr_gen_ras_event_seqno(dev->adev,
+					RAS_SEQNO_TYPE_POISON_CONSUMPTION);
+	else
+		event_id = amdgpu_ras_acquire_event_id(dev->adev, type);
 
 	RAS_EVENT_LOG(dev->adev, event_id,
 		      "poison is consumed by client %d, kick off gpu reset flow\n", client_id);
-- 
2.34.1

