Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B41CAC598
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 05:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A9D10E274;
	Tue, 16 Sep 2025 05:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0ITIZJU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010058.outbound.protection.outlook.com
 [52.101.193.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAFE310E274
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 05:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R58FiI3bfsv8gg1S3EduDbdIJhlTJq1iceMQMiwMETfy+sQ9wwKAsSwL1BK94shuYPWO4dRN8cBrmzwWXDn/tGmy+9VGoJn5rXieJW9SVQl6tOo0ZqTE7O2Amf8uq/0+XKeUKLhGI7IshBwbzI/vXC8d1nOw/ZGG+GTRx7WG2ZsdgW9N/oJWbcTjptQcnoqhj6ys4kKQYYWSeHWgQj5PxQzds7jAvLEvGw2U0qEKYri3+ktJjYXuTxYVeV1qx1LMt6tkXQ5aopaO2qfLs11Lk4IvVyCtkZ3MyeA2icYBkV4mKP8H4CgQQMLaiP+8DV+SH5lZCY5To8uxlXJKLB1CRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcwqMo6aAGZRgZ76lEIPEtlre4FZY16Rur5rjUDRuAo=;
 b=j2g10CEZnkUeg6cNwv8eHmtMpklrWDBCuvHzAmBb+XcaqceBujSLRnkmRnDh/84aAj5htRdheJvymw2bVQBxApOQnjvyHnN6IYjX+yNje7Eyco+o2gqZCwTLP9nTufoLHJ1jryP8XvQ7bSrr1w8VCxbaolQFx/Dcx/4T/ntcWaB8L4FY1PIGrviJ3bSk62ahngGLoiJcBLqnMyTu4eNS4cfi3FrvgAMcLbzO+9JrqvQJj2OdUkd89LLYp2Umbd995NloVS5+EFFxOFX3+dqdQyeUAI/teZh5uOBz7sceHHGr4eq1AAxXIHwvnVaABLdZojRTWWvkmbC0zzjxXUi2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcwqMo6aAGZRgZ76lEIPEtlre4FZY16Rur5rjUDRuAo=;
 b=V0ITIZJU+dWFDcMeDIazQYQJTrKOZWrm+fkUyTcYzBB1RHp1VyGsK5ojn6FRsmywV7wgK+qdAkA086rv2eNykTngyp0l7TTbAy6D76uUdw534DhZTqS0CJLttDLZGKQYtIgvCU9SazVqeItHU6jeGUHrApWDtjEoJoV0IoAbDvI=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 05:52:22 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::f7) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Tue,
 16 Sep 2025 05:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 05:52:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 15 Sep
 2025 22:52:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 00:52:14 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 15 Sep 2025 22:52:13 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add fallback to pipe reset if KCQ ring reset fails
Date: Tue, 16 Sep 2025 13:51:56 +0800
Message-ID: <20250916055212.911425-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6c7b46-7763-4409-4c76-08ddf4e5344c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pdL6wIBepBAGKTfiheqFuJ71A2xvuvmWLzdeJveRCEuaYKJ5m/7c8XgG1/Ye?=
 =?us-ascii?Q?A7UQ2sj8IdWNMwEzHGagVi98uNnUQ+M6PA2P/L92X3k5Q/wDQOow4EwNPhqa?=
 =?us-ascii?Q?jWpW7m8SW/dx2UOpTfUbBOSzn4pAP/zAHq/VnLET8W6TNjhYRqn2wk+pFVE0?=
 =?us-ascii?Q?ctPy+tW7NMTVeXvg+X1MwV0aVns7rT8JCzeuq6RHfVscE7tZWAzXgIStDkUU?=
 =?us-ascii?Q?sQUX4g9Fb5aA4swWmvxCGd3/S6yeArY4gH3QG89upFwcBUYAi9dR6jOS4SST?=
 =?us-ascii?Q?JwIJM+HF7j+imacSQmEYMEzNZMpXNoDI2FBY6nrNBCZQRhxqxjfHhwrpWnBy?=
 =?us-ascii?Q?gfXJihGzKy/Is7+yvQLNtWudK5/iUVhlPIsWw+0fAmM3Sqj9Vf/K6KOLZJ15?=
 =?us-ascii?Q?rCiOBd8YeQtwFa8F8Icl3rA0LXET8k/0FRUhD+f445KxiMEsBeBMfQvNUKDx?=
 =?us-ascii?Q?WxGbnYeyxzV0domh83ThG9Nbd9ZjNW0n2BlYPhM7mht8L08rzgR/i3NbaBDY?=
 =?us-ascii?Q?PQjdIiYpLDXU9sELrMotI4pLbWd9dngcKJAzNfX307YG3Dclc3kxKUj9n3sB?=
 =?us-ascii?Q?e2GTmapftjtWyikgyuNTHkj9VWY22JnShPkDOHVtiLkWlRi2zRdyNpbo1ttf?=
 =?us-ascii?Q?bI2CTtwusKw13MNNahL1d+LJG2IzdBgw5k93RHlYmWcxdSw/k0CsXFwxtsYL?=
 =?us-ascii?Q?LEmk4UZrB+Ke5YSZhkqmAwxcd8pWXLvz6mdIYV1mAc92TB++hrptVECK8uHx?=
 =?us-ascii?Q?BSWPk9RAVJgStRCbpP63msy6l4+aLvY7hgQKmwlO51RMKeKKAcFFa/B/Mdnh?=
 =?us-ascii?Q?eV6kkjU+3XZ4XNu9VsBY4cmKFFoPccpAKTg8UnMhqk0qq8xTXrrelw8C2woz?=
 =?us-ascii?Q?RoyKt5le7LM87e9ItBH0Ptkv1U7MO2tjM8PvhISb1fDm1pczmoFl1gkMyfMz?=
 =?us-ascii?Q?5vysW7tW4AsIzLdbZF+n0vDDm6K2H/GscxVXMIN1TtNVkO0AZwQIWZ/ADn/2?=
 =?us-ascii?Q?VUUnOWXw/qNDoERW/94rfPe324GtKfZlmBewRdsHdDfweS0YbU6B1aPsHdgn?=
 =?us-ascii?Q?fUD17jPZ8DP7sXg5EkYXNu1TuQtKrMjoflDTWHCgiBZZwtB0dljZynEIL9oO?=
 =?us-ascii?Q?J2GK7D4hWi5UKL/a4omT51JmlgUhbLyVHXyu3Nc1r0w/4rUNhEnkRtQas1X6?=
 =?us-ascii?Q?9N3newCzj8MeejekPyImWgD5/Onh7+46Gibyj0YkvFaNTRoRTn+nop2dz0dR?=
 =?us-ascii?Q?ZQRqIOQQYXRoVHJVzM5KQSjbTa8YvOO53hawm39L3v5GrHWcKZ3A6xROLtc4?=
 =?us-ascii?Q?4nruupmIjTY7z6kpMJi0DXi6JDtfzq2w3MqrYfjoShpRRwN5RnfcHL7w4z7D?=
 =?us-ascii?Q?YSZip+RBl9RB1cie7jaYYfsILrsELAouXyPKWY36YpeJNWfie0JMdgMu3dqF?=
 =?us-ascii?Q?lDCqD5uHVgxYmfFeTy4GRXmUsCnQmsI+P6jr+1fropB+eofCAgnOgRFfvdGs?=
 =?us-ascii?Q?w/6d6yfiz96JqpTaihntszBqJCo9qzy1T5Yh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 05:52:21.7239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6c7b46-7763-4409-4c76-08ddf4e5344c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add a fallback mechanism to attempt pipe reset when KCQ reset
fails to recover the ring. After performing the KCQ reset and
queue remapping, test the ring functionality. If the ring test
fails, initiate a pipe reset as an additional recovery step.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8ba66d4dfe86..981324c55701 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3560,6 +3560,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	int reset_mode = AMDGPU_RESET_TYPE_PER_QUEUE;
 	unsigned long flags;
 	int r;
 
@@ -3597,6 +3598,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE))
 			return -EOPNOTSUPP;
 		r = gfx_v9_4_3_reset_hw_pipe(ring);
+		reset_mdoe = AMDGPU_RESET_TYPE_PER_PIPE;
 		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
 				r ? "failed" : "successfully");
 		if (r)
@@ -3623,6 +3625,13 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
+	if (reset_mode == AMDGPU_RESET_TYPE_PER_QUEUE) {
+		r = amdgpu_ring_test_ring(ring))
+		if (r)
+			goto pipe_reset;
+	}
+
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.49.0

