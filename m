Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50604C61CE7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28DC10E886;
	Thu,  5 Jun 2025 01:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="prQoN5dQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E0410E9E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7icGRLDJ1zQSARk6WdhjLUjC7F3Yl6FjJRMbsLnDfgFwZsHTiuUS1jasXlUHUosqg1FdTj6cDcBHnNCSRoUgERLR6cZzGnj+zw8xmn6UFsNln8Lssl4B4wuJ4OuShowif7UqpNaYxZLbqBKPBtNWIc8xxeSigc2rwVeRHVPOKF90e93Zlbs5MpSkCuQmfA8YSC1+9+dt4RF0NjrrDnKLc3PdgH6TaoJpD7vW2Us6rfe27EeDQLO8/RcFqXuOBUS90tz/xM1B2hJjUqEQLSxwYIvcsItBg7LT4Oa4KN5MySdFoZAjTywLPAIofscOXqXp/Eyv4xyvqU1Kp7/RePYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8wn/HIkZlOtvooYnqC4T27eIz2B1fa6zbY5zWyM6wY=;
 b=JiQgqU5mZkUE8o8tJ9tgU+jlGex+qjY+nu5qdEKV4qJacBcePtlKr8nO94LjvD1ryMsQwc3PSchxO5ITE8RKPfrxS0y7GhEVMz+iZBDo8tjePyhYsnJlehdJ/mAzSs5TiyKlSLwnDqqgmgP09TpjHnHnuL3fVYze58zfopSsKlRZ6zCQBwS8nM7qS7U44c3kDa5tNLCf51PqTy2HawknJTE5419TpvGNWCmZwHS/INfmZzmoS1hWcf3uE8bIHitrlLLghSco3QazvVbUi2uF94Ec8rRas51Gp/81H2W/6ByIGeg3UT4uFQZ7DkxqhsdAzJ4iVo4IePWZInT8oXwcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8wn/HIkZlOtvooYnqC4T27eIz2B1fa6zbY5zWyM6wY=;
 b=prQoN5dQjwvkxSZqA0Fu20meAS1PHIC4wisZONh1GlI/jFAZTFQoaDIgMMVDQwx5fsOPqnOkEW+S5ECGgTFwVmfiy5nN3qpRmUO9BXgq3/nUiCkhA3FjvBTPw7I2aavP6EFFtV/2PpU2/62SfY1GQ5GDA20M+vpMsmSHBpPN6xI=
Received: from SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 01:46:37 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::ec) by SJ0PR03CA0300.outlook.office365.com
 (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Thu,
 5 Jun 2025 01:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/31] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Wed, 4 Jun 2025 21:45:58 -0400
Message-ID: <20250605014602.5915-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a209f1f-55f8-4118-dc91-08dda3d2cf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XFiosvqXHXfth8j6kwEjGM+UiY513qZy8VkYVEuYYyt1PAQu3eZjnFTHSkec?=
 =?us-ascii?Q?yMlijzJGiJo5ocFlh0pQLvcr8Wp0btwyhmGLK9qd4PkXp8fv2qXasnfv1ap8?=
 =?us-ascii?Q?lomnx3SysDGYTtBw80vMMj48n5B4/3CI32FdnntZvdKogwDgxHChpdRwJx31?=
 =?us-ascii?Q?WEQKJMWUeIEeCyBcQZuXI5Fpmirtmi0/f3o9HeAOXBg67YX/lCEtnkCRAoZn?=
 =?us-ascii?Q?45SiLjuC0oDizMUV0sn94159YBnLGYnYy+/PhgT+T6cnC1XChpsEDI6L4IyN?=
 =?us-ascii?Q?Kz9Oo0BCr73wboRJKSp5gFdxxp6Gn7UigvljqQo+b0XdeLYnb9T70yVQZJrh?=
 =?us-ascii?Q?Yb6yfP2aTQsGVIU8X5Vr9TgafCLaIjbXxBVihUYQ9k60gKzElNto+9gWCdKY?=
 =?us-ascii?Q?bpgWB53oONHZ2gPIALBrI9Z43as3oBXkuq7l9mikXgNl8PPIZWAJDKxZzw66?=
 =?us-ascii?Q?5umdH3JFi/Mx8h7hKgiz82ZJBt9pSF9eKgg7U+T/3pS06aQD7uF+c3LGQo1h?=
 =?us-ascii?Q?WQo7edOGLUjYvTO6vjQI2lZsI46wC11bfluYUB1Whj3IjcQjZZHhW7K2waP2?=
 =?us-ascii?Q?ZVH1DCZfXI1Rn1h3JKKq64fXQf/Wk4V+tz8T7gxar8JmYZZIWbJNy2NhJqsn?=
 =?us-ascii?Q?ooDBo+J/kYCGFnLDZhZf12fLfB/asrE4oghmtIJGwbfIpVUStT9llEdOUjy8?=
 =?us-ascii?Q?bnZwjg0Qd/ARP7eRshT9ib8SRWuXBW0RIMpXd6ScaklFwrKfyPTbmM0mqbjT?=
 =?us-ascii?Q?MRSXYv/2TwqWmRN7zJFAAtezA1nnCc07YmanB/0CPCkW3HnOQ8rSoloPFobr?=
 =?us-ascii?Q?7gir83t5fKAV7P5PDxHQvMW810cpUWMjkvxKeQp4nxnZk0y4WFW60IZ7GGVL?=
 =?us-ascii?Q?baR/gy9UqeOkvBlSrBVRrVm7q2BDPS+4p+JU9dSnl88Tmf3D0B4iVA3Oitfr?=
 =?us-ascii?Q?PMi39v4EoZU7bHBhjXeyR4bLZ+giD/+ES7EMc8ThLzM+otwSMo8CR5u35H7g?=
 =?us-ascii?Q?ORow4Q38GYpPV/iIqAQuWusNMRAdms6u13D1OOPyKL9Sb97Q8s/eqho0IJND?=
 =?us-ascii?Q?RhB1o4PMZuZqrxsSxnOx1xyPuU2UZH2ERH58vC6I5THJVt7rLEc2iILdFfTL?=
 =?us-ascii?Q?NrK2oBCckcOfGKCOdXAs8Bl5bZu6CUnFefAupb5gPXbQ1hMeyFws2TX0SUeu?=
 =?us-ascii?Q?cZYnoFTdE6kVj+yL8Fki7261FfVACMfauFNbG6S4+LJiOn+WnYJO8irTm19W?=
 =?us-ascii?Q?sgdh62R+C9qULL40yvlmgjZX+IT28Bpbb5MD1zGl+v5KUEgq5sPCH/DZop7a?=
 =?us-ascii?Q?AtNxBfRxdmvTxsFusOlRApOkOIFKgmgGOgi3Ysj556El7pY22pqXHU2wBL6Y?=
 =?us-ascii?Q?3XcHWrDxHAz5cjFM1rKXNyouMfax9P5bOy7DEaU/5GnLSc8tDerIbNqhP6Z5?=
 =?us-ascii?Q?YLXDhRKHbE5UUvVC+muWhyiIRfJ1AsaI3jG+W5TH12apqaObyJuPuvTqVlbI?=
 =?us-ascii?Q?WYgkpBmEH96dTGLwWNCv2mFsLYYoByBhGVVx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:36.8453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a209f1f-55f8-4118-dc91-08dda3d2cf14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index f1ccc6c7be390..04b4712a8f2e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1977,9 +1977,8 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	vcn_v4_0_stop(vinst);
 	vcn_v4_0_start(vinst);
-	amdgpu_fence_driver_force_completion(ring);
 
-	return amdgpu_ring_test_helper(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.49.0

