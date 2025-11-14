Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F1FCE7AA8
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 10:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8322010EA24;
	Fri, 14 Nov 2025 10:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S1NAOfcl";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012059.outbound.protection.outlook.com
 [40.107.200.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6C210EA24
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 10:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4N3Aq3dlXkp5rM6UuDmbCJY14IheRWdKnKnEIdKE9oy9Owi8meDNkTwIQDYQWeM6aFmuE1DYbEY/m1E/jfkACbRvsDcqXgJgwbI2NVhUiAiI/ieuBwSguWAGP7UN49DNNtGkzi8rqUR2/KFetI/dXMb76ZcYJr/wu2g5U0SXr4i0puRuY+7ygoiMAnya9BnZF6ocjX8xkNl7sRJpRmI0Rdma0uxx58IRPNPcgHJTuk8SxAO0qEomETdPhhBhdbkP+LUs/jvvjgLDJYKyc5InxhZntY6sG74ZFHMSC7jnNU70FYG83CyOoBOX7HO2wXuPwzspmdvI7RFGlMXiS0NRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Xl59gKh/k7nGHb1PXXgaKw7pIt+PmM6GeHWhSXimA=;
 b=qQ956xUuWxqV+acg5/wYdN20/bV/Hx9F3cUKzOPECyBoWPv56juF3qZQtXTcYIyuUf1Of6JiWA2Fh7SLOxkWvV703GAG0wByopMy0XLzQAg0L5LiLrHQrwjVO0D5k/rfLrAoUAlNFvfqLhaxoQ0VNXIHNRLONvfQ5ePBq9MUf8lX6rzCzeUyBjhDVJoPOsGZ+ELUtldcglZ+xyQR6+EMdUtHjRpGmIejO1P35halQP8Ct1rFKgENblPwW5aKDYbw4WD9kf+KI0EkllyG/ne59Ihnel0fMztTk1gePOmIZcDkKxFv/JQxYssBEuA3H7qLVdPqLTj2vFIVNVpWp5/+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Xl59gKh/k7nGHb1PXXgaKw7pIt+PmM6GeHWhSXimA=;
 b=S1NAOfclML3DVkBUcyfUSBYz1BIZwFjelZ3tJF75OADjR6Mau/1x1AUVfCJZZMW7yvuX/QN5qOu/jiOvPvksvHIy3o5etY6XWCgqnpDmEa+mghYbB6iZDQoCqzWjMZ0sEhliiBJD2xWVkhGpfotZOsdhe8CjIa9So+XeYaoo7Sc=
Received: from SN7PR04CA0172.namprd04.prod.outlook.com (2603:10b6:806:125::27)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 10:09:10 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::b5) by SN7PR04CA0172.outlook.office365.com
 (2603:10b6:806:125::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 10:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 10:09:10 +0000
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 14 Nov 2025 02:09:07 -0800
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>
CC: <Horace.Chen@amd.com>, <haijun.chang@amd.com>, <Monk.Liu@amd.com>, "Yifan
 Zha" <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Skip emit de meta data on gfx11 with rs64 enabled
Date: Fri, 14 Nov 2025 18:07:21 +0800
Message-ID: <20251114100719.4036094-3-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b5a630-1d0c-4227-4eba-08de2365dac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZADBGjNUvx0IpckWtyAPMZz1pwylr8Eux0WyP6lzXgXCLyIM9yMLI+oqoW4s?=
 =?us-ascii?Q?2CyQqidegRmEf0/5qTSO4hGtXcuLQlfnT0Wfubv2UdWnIDHZlaLdqzXt9Djw?=
 =?us-ascii?Q?F2tLc2Kf7Lmufp8ufSBFA+0FD2ywGxpke9OqUg7A6b0TATuX9ixN8VSKYWOw?=
 =?us-ascii?Q?Ta6ivN7EwwLKvPJ1qixb0Aebi4EmjLyW1/+353DaUp/o75jVQW1esnSz9tAy?=
 =?us-ascii?Q?lsrZcU2TSsX6M5I7lkuVsmC5mMX3dNnUiYipGLwShVsDOhvbMCl6o2rqCFwY?=
 =?us-ascii?Q?tOtSRtHKw/S512OzMI2+5Zc3BlCYB1dTEFrbRM/EthRY3XgKGDypDnhm0j3k?=
 =?us-ascii?Q?WaCMayP33RKMUrPMsnK+fZ8FU28GbMayBqlyO4Lv3TalpgprbzM+2pGN85um?=
 =?us-ascii?Q?F2p6eREp+2a9bbMfJij/AaQojXNjv1ACwEUrf1mexpPbsq0tUHPPbm6nl+km?=
 =?us-ascii?Q?Oodt2TKk0bIK67F51S82Z1Zfr8U9yBZa4Xg4tkZNe0RLeObjwHKV3GNwE5NH?=
 =?us-ascii?Q?oYitYUMll6DtBjFWFNOrJiPbzZi2l6rZuUGWPQc60T/coQEVbsJCTdhI0HPw?=
 =?us-ascii?Q?uJdLgiuHX038D92rWr+zRVysOE5fBaai4xslNMHq1botdi8alcZ5NMgIxRCr?=
 =?us-ascii?Q?iQafs6TmQ6TyAlBOBLN1E/3u9ApVfayqHjmwvZNuN+UUcDvFWy2C3iY4dJaN?=
 =?us-ascii?Q?+eAJaGdHRxd/h9qBqG+bWCOtzpNAiPtG0xbPC9wHCiBUaFg4bkN8AF5e3xr7?=
 =?us-ascii?Q?B/RO4CsBd0BnkV+OcmHqZA1KJdjE1eK4ZdExpSR4+kzVjaJ+dbKajiOjNgF7?=
 =?us-ascii?Q?10l9JvtHNsQb3J7HuuUTG5B8uYSHH01ATamdtOG4VxtyecduXsD6dsZke/Lf?=
 =?us-ascii?Q?Qp/3ra6/9eBJ6EcKGIPzDpp9c7sbFJMyLJKmgF3DdQl6ZJx3+tBwTGSHGYwa?=
 =?us-ascii?Q?vLZpdJegpvBxyZM2wJUehOqWoKS/tEYGYcR0YSfbFVywv/17gckTZTfbstDt?=
 =?us-ascii?Q?1UCQjcRTTjg68nxRFjMrUBFB5MdabS6imoXXV4j1zwcTT2kYMUYhf9VCDmmu?=
 =?us-ascii?Q?PSsZwYPnPYBSCNlLK0/XpMxxnhjtlNuoKLVvJlLmq8yOZae81fpPvHDBsR3f?=
 =?us-ascii?Q?3AXCH+e4eL9KhyaOqvDBBqPG84Cf8KVaxGP+Hkyyy1ItCi13JjQFLTmhP0qv?=
 =?us-ascii?Q?sl+WRuQxRxJJaddWfLcLLA0fh15J3IkP9Nzi8cOYYpxuldH/WWB2qJHQkVjg?=
 =?us-ascii?Q?TWi7YKxl6F9ifqmNxJ4ASOfObxH4EjJp9o0A1eW6LusyBuulRXe/6Ny1vZRm?=
 =?us-ascii?Q?AupSrXxyK5RCn4Vm0i78c+jMXed/DmUc17prREpYvIrqoXxFynj62mNLKQDu?=
 =?us-ascii?Q?ClxA2ZobKytTpCpDKjFgHLyi/4wICChIeUFbk6yVAL0jrsqRRppL0mVdEqFV?=
 =?us-ascii?Q?mrpur3TF66G1BjisqDG31MArabznryNs8DjZzHGczx0EdoJGYnZDKg0r365J?=
 =?us-ascii?Q?SCX8ODFwiX1zaqofEptFRXfLebM6/k2YY4sMevc0REIJJX1QXgcBeyzFvseT?=
 =?us-ascii?Q?BLd3tXVFEWmMj5CSKKM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:09:10.1334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b5a630-1d0c-4227-4eba-08de2365dac1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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

[Why]
Accoreding to CP updated to RS64 on gfx11,
WRITE_DATA with PREEMPTION_META_MEMORY(dst_sel=8) is illegal for CP FW.
That packet is used for MCBP on F32 based system.
So it would lead to incorrect GRBM write and FW is not handling that
extra case correctly.

[How]
With gfx11 rs64 enabled, skip emit da meta data.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 02d7cfae22bd..e4d525bf9d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5874,7 +5874,7 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 		if (flags & AMDGPU_IB_PREEMPTED)
 			control |= INDIRECT_BUFFER_PRE_RESUME(1);
 
-		if (vmid)
+		if (vmid && !ring->adev->gfx.rs64_enable)
 			gfx_v11_0_ring_emit_de_meta(ring,
 				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 	}
-- 
2.43.0

