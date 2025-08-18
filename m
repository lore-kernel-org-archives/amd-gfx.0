Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB606CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 19:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49BD410E4BE;
	Mon, 18 Aug 2025 19:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C5HmhvsF";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591C110E4BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 19:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwEi3mlNjXb8lApu8Woe/Xh88khG25kG1eMcOs2yRiZ6Vcl+GhoG/E3fHm20peQt7V7AEAs9ztm7dv27BBT5ku/X2hBStyZ5KYZPnhVMN62Pz8jAkv9EnX/bCVdSmDYkuXaPGwGj/MG2TFntSQnxd132r/GiHtmG8n2Fd0kxNN2/7Edoe1hwVXcU6uEWS7m86qwcBzsqofT6ZaxHTqt5xTNWFZkfxUpby1PK96GsN+G1bjdeW5KOr051c/uO5yIsp3fuh3h3OE+jI8DdCYiCHq9WD/AZvkNYtNvplgL2MvIKIVUDKIyk9XXaV2H/l9lt/gxfojurutqMTIcPdYsWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnUw86y8OT0oKdw/eq5s4zQ6T6K01I9JA5/ul6k87eQ=;
 b=XeQcXDhgpdl5FZYNHq5TEhoz3jch5+MCOlOwh5muaBrWwEv6u6lHAJ2dT4opVHFDVe2OXBFHa3GHP16JgAVlnLtyPHovC3p93UdkiPCLHoAJftJGmveUm6+8wqSf9GXRfaNXJaPoyV6u3XGL3dw8c9iAy4ysWaQN0i0wKU4J6tylE22HGxEmEYxAqjocWPXi5+Fe3JQORcDeESBV3z4V+7//7qqaZIa44KumE2qFM3fcJXAq/PpXC7YAgI5/Nh6sqS+tFoE8jQPZ3m3R0ctbGflyZm86ZkkYMyfKFZVZau0qNuz2GGGCD+mAxyfO0jdZnpiJQHEY42tw8yvkJjsneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnUw86y8OT0oKdw/eq5s4zQ6T6K01I9JA5/ul6k87eQ=;
 b=C5HmhvsFoKbmajunVaYfqwGGZ3jeA/E9BDRpG74pqPW2zLIbQKw3gEOEzS3PYVtxbDl3dc6JHQ/q7pDqbjRWbjLADqSlxdlXD6Y/Synp0XnBFQRyTUldXcjRvNlxkS5fvQB1I0jN+P3uR0cqe23yhdYYf2yzAdIdLgk7UOop6aI=
Received: from BYAPR07CA0010.namprd07.prod.outlook.com (2603:10b6:a02:bc::23)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 19:33:18 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a02:bc:cafe::33) by BYAPR07CA0010.outlook.office365.com
 (2603:10b6:a02:bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Mon,
 18 Aug 2025 19:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 19:33:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 14:33:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vpe: add ring reset support
Date: Mon, 18 Aug 2025 15:33:01 -0400
Message-ID: <20250818193301.436626-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: c11f6273-9292-4174-d349-08ddde8e1502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aTb2R+Bbst7zFaL6DQJy8C/3OtdUOy6jlCDcswyv/wn9UUFJ3nhfZH8X5Gs7?=
 =?us-ascii?Q?5LUBzn1PuYb+IISn0aeahRa7YQIHyPQ9XYF8R/XfMyCWpbK8d4mHy6kZ0hMk?=
 =?us-ascii?Q?G4BEs+Z037w6HbarL9z2jWyX0h5PZKUMTBVrsDwHG/7y+VF9JBQATJzn42Kx?=
 =?us-ascii?Q?1/Zpe+hwEXhnsZavPxsjZc33zd18W+U/8nHjxP9yLDf1DUCfGuQuJCrDRJGn?=
 =?us-ascii?Q?iEHo2EeBJ20FDLVyZTuBTW/wimiXXE58DAWs1wVjrrUTyaf2ryTYcdibNd30?=
 =?us-ascii?Q?dFfNUi8QtuU86vxTGKRp6IUPN1O9L1u2VTE1k2a4VEqcrweD/aEsccNLXu2l?=
 =?us-ascii?Q?oDuuXXNvsOxuaJROS8oLO4V6qdyicCsJlRMcxzZVGTi3acFu+T+xpQe7Yn3p?=
 =?us-ascii?Q?zBGgecIhloPsWbAkgvGa8vOnaJkPFNYz773M4zU6co24ROzznixnDZoSENRX?=
 =?us-ascii?Q?2GQFuYe/MVeg9jyTFieeTZyyE/Ko62VI6Xx6fQ2BSg9lyZgC+jHhCEnv+XPR?=
 =?us-ascii?Q?tiIdcE0OrmJad9xQtbEA9bU6MWB2t0reRzeXQjpUdBq9O4vW2B4Jk6KnyO1B?=
 =?us-ascii?Q?i5MUC0PzkRFQrZKA8jdC7R/CuxEyBDprSe2zFvnsVFDzRk+lmBcapo32pr+m?=
 =?us-ascii?Q?GSpddyCRg3Gvo68FuUHdNyf9t5Ob6q7A+H0Bx1OHrRl9Q6zlp7HEBHMKKQ8g?=
 =?us-ascii?Q?m7QBVI0SY4hQP7SXzEObGoHcV1pr0ZLbAtKA3OLcsGNPyT0Wr7TNS0R1q6nW?=
 =?us-ascii?Q?LjtsZ7nFJcdYj8evW12GDQVGDmN+GuVq5ZwGrbXxQuzdDN29z332UylliKsK?=
 =?us-ascii?Q?6gT1LTh6hkLqwd2aPl9cabdla3gNEKFuyIlOcUSozgSSsF6fnj8oiRok2t/N?=
 =?us-ascii?Q?/yjpBNwVZFYlf2z28CBmdRCUILmEW/ONJQdDTCZlbBLJGD0m/GkXGnfMbwqx?=
 =?us-ascii?Q?FerU1EA0RBCIGtEaEyNLCyKoWXmqgnrnGTZsRqBwM9Wxs5NPoFyU6lYz8zKV?=
 =?us-ascii?Q?u+8F+yREJUw78r4r1dfUNC7oCVN4VH3ZmzsXTEme1t8II/oH0Q6d+n6dqyXx?=
 =?us-ascii?Q?ep4kWJ7FfOPxzjJCFbvPvBJ8gKa8d0EN2Ilw7OhhtyGVQeae0jH0SDz8e7ep?=
 =?us-ascii?Q?2kvfGgnKr8wNLV+LUlQsmfWqzn8gOCTXXQMP1l2IU/T1nBRLu1CMiKYZq7AQ?=
 =?us-ascii?Q?pAhexfFvXOa2dc6kc8QEAOF3lxTvPMf9cAw599zEA9Tc8fPq0oZQJ3kMZZ6S?=
 =?us-ascii?Q?c1cmbtb6YAs+oTJQqpLOjrXgHdNUkx09b4yUF0FnsgEXlX/42SueM0wft8OG?=
 =?us-ascii?Q?JgBdpTVWaOf7USx3s7fQK/Vfwq50QWWMJGNujb3FQ11vXu1nY9kf42WZxmBn?=
 =?us-ascii?Q?WxzrFcpL8to6Vlzox58fkjLLiqPILs4yXqcVygurAK1hjfm5+LPIApN8QyKc?=
 =?us-ascii?Q?zt/gDY2BEhAEMVBheR/+46XG1ROeaQXuWaTm93zvfjnAkkYM3vv+JpkgcRUE?=
 =?us-ascii?Q?AJQNLue/aAYNK6dPmH1ajQ4Yw6JqHsl82/ik?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 19:33:17.4353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11f6273-9292-4174-d349-08ddde8e1502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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

Implement ring reset for VPE.  Similar to VCN and JPEG,
just powergate the the IP to reset it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 121ee17b522bd..27171b5b47bd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -874,6 +874,27 @@ static void vpe_ring_end_use(struct amdgpu_ring *ring)
 	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
 
+static int vpe_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	r = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
+						   AMD_PG_STATE_GATE);
+	if (r)
+		return r;
+	r = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
+						   AMD_PG_STATE_UNGATE);
+	if (r)
+		return r;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static ssize_t amdgpu_get_vpe_reset_mask(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
@@ -942,6 +963,7 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.preempt_ib = vpe_ring_preempt_ib,
 	.begin_use = vpe_ring_begin_use,
 	.end_use = vpe_ring_end_use,
+	.reset = vpe_ring_reset,
 };
 
 static void vpe_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.50.1

