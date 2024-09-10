Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC644EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 03:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC2F10E6E2;
	Tue, 10 Sep 2024 03:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5CUrEdck";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527F510E6E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 03:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pB5ERpVR+LgIOD2/JjMyFdm2QxkP+LDpPPvc/msZLOsR1JoW4SZLm17HCq8HTWW+cu7GpLUBLQS6InhcuIxewLc59z0VIkzOMIGentOSWHyPOo34CHn1DpZgLcGUBbNoyrsu6KbSoJcs4VX/QefTpkO4nW4ehPT1uTPbfdyBs9DBzVbCbzEweGx26Ez9EBLEOS8qyJFALWmFZg1v2VP0OuxWrRhbMvyDYUd9RaT2EZAdMo63RjtQlH/mbbuK0itGV3SDfm5mGCRG41+qFhUsKmePD9+q4bglPh+KU1kaQMsdseBmMiEhQy3EmRZWcbK/wlsyrPRHx/EDwFub0ym8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anvfYm7y8KbnaoNOgNlpvJ3plu+zoT0J83wnS+TAk0Q=;
 b=Hyo3wDx2eiUHly0ARHIX+clXIyNqvqDaZ/0/CFEkgVdE6nLge9/9ZbWwLDkEz+eHQdy0U9bph2WChL14jTZP3vnoqObdhVVH3sau4C7IGaT217cOeAxtPCANNRJYvqFQTgNTgXEN+YHMGhfRIVN4dA10GiMFlOteBt7xpUyl+rtC6Y3VcjMpmXP8Df4schUxVWlsQNkCIhtSkQRLSzdCoepgnP76z62i3aKq19G6BpvG4IIopUXieeSCapOFp1I+Oc8NfDmmj+ByqMTdff9Njnrqg0DXl7P3QUbF+xR81eY0Qy34XeFUCDoTwVbXNrAn8Jw4H8WPB3KLKm3aUPd96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anvfYm7y8KbnaoNOgNlpvJ3plu+zoT0J83wnS+TAk0Q=;
 b=5CUrEdckFCix3XN1ufWd8M8VfiQYMwMUhJSqaBSTJKdoB4sS+8vtfzd9QXFhsfpMic+AStDLBVm9s7N2U/SJJ2ztxdq67foinEQlPUKFBSr3axoIRVTKZO7k+nrC57gjjdBf5F8NHKrrcI8dEi+SBu7PoNIO3GxNqHNs6Z+g/BI=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.31; Tue, 10 Sep
 2024 03:39:39 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::63) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 03:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 03:39:38 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 22:39:36 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu/sdma6: implement ring reset callback for
 sdma6
Date: Tue, 10 Sep 2024 11:39:18 +0800
Message-ID: <20240910033918.6035-3-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910033918.6035-1-jiadong.zhu@amd.com>
References: <20240910033918.6035-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3181bb-a4f3-4c69-4d75-08dcd14a32e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rnv9ONv3zuRSS3EslLTo0rU9Nc2+5Ah2XRk2bbh7egglXco0xrB1T2an6wGU?=
 =?us-ascii?Q?pa+q87A3BgvEHhw2KKz2z6S7apDjrXJgvS72ao+sLJBsuqj687o9947IZZCS?=
 =?us-ascii?Q?SnOt6gA2Zn9Iww6BDh6VEcz5Zbhsvd30X6MBugaOeu7O7KoCaRflQCVjOM2B?=
 =?us-ascii?Q?KeD7oAVccHy9wKgqEkuY+jBmgcVbmV+qxqjkdSPst3exkRNEhK5I3VB7EMx6?=
 =?us-ascii?Q?RMlLpfpk//2PLRjwq4rUlJkZp86MzWouOBTsPuvQLPYXtJbmDuBMo/ViwcVa?=
 =?us-ascii?Q?JySyI0bPTpNxSUZh7Lu/HbQAI35iQXPO0f4c9GTm4f0Ib43fqkj2xwI2ve1o?=
 =?us-ascii?Q?FcCnxoZxpbMSIXPdVjnGaMbF3THAEvcg4xyY3blKmrN4JdQAEMzx1aOpbPLj?=
 =?us-ascii?Q?CWJZR4zNH/A8Z/+WBaOPC/Z34lOxpCrUaWa85Qr9TnVePHZl3d2caKBpDT9U?=
 =?us-ascii?Q?VWNek7nGHBLYGZCI8w8+Nc3nEXKygo131CZTn6YByLGakXVffbKeu0H9Gr6t?=
 =?us-ascii?Q?fN6jSj8fYzlVv4FlhEjdm4ZG5eUck069zZSTUVazu5qrkPexNgzVGbYkJF3Z?=
 =?us-ascii?Q?8vFNZFXTsJeLgOWkrspqWvp99qQAR5Pl/EJdDHblBo/h2y8Q067KW/M+gL6/?=
 =?us-ascii?Q?+tczwtojk1qYa6hqy+U2QHc6SBvF39e9EkBtxZ5NK02UGBGqmaZ2wC9en8LU?=
 =?us-ascii?Q?A0+sAR6gSi0njMWdujWDHFsmjxZ6fctcNyQmPTP9xW3Odutck0EtmSBbsdyH?=
 =?us-ascii?Q?a3QCcq+xTOsye2WUFPKpA6x1szqWB3q503H76A7yp4TuViKs/XYIzsfWo95o?=
 =?us-ascii?Q?URxA61hfZCR8577oB5sfnR91G/TD3OnqFKIF8uUFE33u00DxKUsuc13d3+xm?=
 =?us-ascii?Q?rbiR8LcPytGOtoMSswLGWuRm+I5v9sT/GNDo9NbBWfJO1RxOaGmWFJ+DVNr3?=
 =?us-ascii?Q?1pQRS9fIg6PXWr2XdbhQcwzHNRmPH7otOiLELwGf4WqZF9lVpWf2d0b3d4A+?=
 =?us-ascii?Q?R17eRs+d+lMIlSj2eEQSCj46BzY+PH1go13347WMVsAaMBz4TjQ3G224aGIG?=
 =?us-ascii?Q?pBeFivZDdZTgfb+aG0/QW88XVDExjlYj5olHuRsvxF+EEA9XmoyIDTEhe+Nn?=
 =?us-ascii?Q?L5D9BM/5GzbmUKZ+B52khfBOhw5hqiTJ3cJ6BUR6VsqhL3bUHjPBH//4vtRO?=
 =?us-ascii?Q?HZXl2hmB7Bsgd21fDQuCYQyzKYX2gfUPQOiQ9h2hqTb4T8K7cDvcSF9CzJo5?=
 =?us-ascii?Q?Mk82ERQXxO0/d8NaXseozNqccD0mr05PcnSLNGus1iLwKSogvmBkNb87hS9C?=
 =?us-ascii?Q?i2QekgwD25l+trRE+dHNY8iQdvN3V3qe72/02yPU6npgb+KvLsW8r3Wh3OWR?=
 =?us-ascii?Q?rHwIMFp7Qu1aKXs3xhuuXflexeengaZvm/NCq9KMiS3n1pnloQ+WnAVYReli?=
 =?us-ascii?Q?5ydlhlZmXrYz5Hb7UgQHMh1fgJvHcT8W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:39:38.9747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3181bb-a4f3-4c69-4d75-08dcd14a32e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma queue reset callback using mes_reset_queue_mmio.

v2: check instance id before reset queue.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b2efc678b7e9..581fa550ef29 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1491,6 +1491,31 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
+static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (ring == &adev->sdma.instance[i].ring)
+			break;
+	}
+
+	if (i == adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
+	if (r)
+		return r;
+
+	return sdma_v6_0_gfx_resume_instance(adev, i, true);
+}
+
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -1674,6 +1699,7 @@ static const struct amdgpu_ring_funcs sdma_v6_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v6_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v6_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v6_0_ring_preempt_ib,
+	.reset = sdma_v6_0_reset_queue,
 };
 
 static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

