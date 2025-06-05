Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22627C5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B060710E9E4;
	Thu,  5 Jun 2025 01:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TVqiTHvZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5CE910E9E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO+o39KOYYAmWAeZJ/nik3omglAjsqR1nW5WSqCpAh+AqyfHOMhI00Z7zMeIfn/CJ34RsfTIMG+zdX4yYU0MQk/F+06J4ucoukf3q118LIapD6Oq8UUji7HsSXunmSGshJ4v9UhlDc19RTpYhX06OPaAw2ks8AjcyU1qNOPEFWsrYveW+MJJdboMwyXC3H5GRNZ+lgc76eH3xby4xV8evh+3LYhJVjE95Zejxh8vz06+Ch5CyjiI818r8Y6EFVwmoCoabVtZ7Er8TpfvxcCruM8YFKU3IkNIQRwGH7tBBhAIJm/+YNsNBXQjGIpO5WX7A+NzIp/2+Qiy4FP03dobhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwFuRGUuerHllFMQ5dKC5GvcYft+OrhtyijQtMSjD5c=;
 b=Q3+bzzjzvFJaxAiSfPjkNdfo7h1a7lyCKfwl7NuAgmUyjYyfXLV5gtgnXbx6n4Gu5fJEBO6Hxn8eNgyaPyjd1Ot5r5uMTzzEve9nZdagmrc85W5bWPGbP/SP57KlKp0ak9ydZb80B0Za8G0UyW30VJMJ+LgEpwRY/72FBVYm47bORQQxPQ4d0HmTwqKF7BQOL08bASpGyvjc/vi0rzl+J6Zjm8vEuIFe6utqx5vaM10FfVmepaFdjfU1EKGwEkYcjX89/tWSHHw4Avm1Nq2dYlBtBqMeoboAjkBPKrpdgbkiURHz05V3m6RVX22CrKJ8jTe7Hqkrjn1VQoQ901S/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwFuRGUuerHllFMQ5dKC5GvcYft+OrhtyijQtMSjD5c=;
 b=TVqiTHvZZuJpaHkDkiLAaUKpkSf6HBrUcIQgHmgyJJqDHdFIRlzaQlVvO1qtUivYkXWi66rpsn2ZcQGiCwGoauQCbLcG4/qrh+3zNzNkR/Fjfch1QANcTQZ/f2Op4oBln+dc3EWLmGEoSo2f7AwuVpPdT2OJyxKy2vtZBVGp+rs=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Thu, 5 Jun
 2025 01:46:41 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::6d) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Thu,
 5 Jun 2025 01:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/31] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Wed, 4 Jun 2025 21:46:01 -0400
Message-ID: <20250605014602.5915-32-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: d09123cc-2ccb-44e6-6440-08dda3d2d167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XOs53pAxFWLC8KOHKUha0ceQrPYbq3C9vcIw3506YlbacDbWBZ5TmkSK9hUe?=
 =?us-ascii?Q?ZIH0j6d3r7cykGUzcoeWU0yiC45pLliLxzSWoy49vjh0dSfY5W4xp+8s9qgf?=
 =?us-ascii?Q?BhxC7XAIwowQOTxFV7GK+XywsyK84zrp6WgEI5nTgdjdbu9I8pssZ12hhGpw?=
 =?us-ascii?Q?1ZB00/iyCcmZRny0AX9XX3ttzN6+E7OqFnxnaO+o3pqAbbgTfTjbqD5Arlfb?=
 =?us-ascii?Q?CIdS/wxkanPokgfU4mBvaYz44nQ1Nhtj1Co1mVGdB3IrtTmM3DkMjelUzELs?=
 =?us-ascii?Q?A/zzaMlba0w3o2m1cCw8or/gqbJx9uu75NfsqG42r4tKvNfrHmYp9wAdwD3X?=
 =?us-ascii?Q?5ULp6T9KOrJ6zce/71lawHuamjLJq5IExT8hUq5dL30mQaOA74aPX19K51vu?=
 =?us-ascii?Q?wD+UTmdM51RFgk4kudFEQqCW4AQb+ec8yxciZFvi3t4y4Z/VLsBxfYWm5yOi?=
 =?us-ascii?Q?hN+nsjMtCmh7wLYMEioOEVzafJ12jRKE4plP2+MREwlWpzDD/YzFwJsrVmid?=
 =?us-ascii?Q?P1UnETm1RMogSEflvULHaR7qtNagLDJzOiFUs2f34k7XasuCU4yKZITtDE73?=
 =?us-ascii?Q?TZhsGoZ5Y93bIqRQ0xjxPj4nfhuwM7AKgJ+5s+oJyUCc16dLXyNcWsSfxxpj?=
 =?us-ascii?Q?gLDvRHu+T3RAaBks/WEqY7wHZv2tQ0AINt6NW3BHxV2K/l/3DVY2SJOOvoaY?=
 =?us-ascii?Q?TA3jtpa9CmqfGF/Thsgt7wa+J+5q12DURwjtgDniktxB+/OIpzeICyUGK0Vl?=
 =?us-ascii?Q?mx7glYIo0h6Dn9n4UUQIOL0gfPbt3+pMmtNPLGuUtlO+yVFGcH9ifPfqyzC1?=
 =?us-ascii?Q?/lD7z3z1hfrg9p7NexVG69E96RF/dJDQrYzLb1WeUcw2lwZrYzwZSOY2OGYH?=
 =?us-ascii?Q?Ys0CioHavja1c8N8kRzPRS6tgUtuy4VEA83KW9iA3rNItYeuArLCVuKzPgEp?=
 =?us-ascii?Q?tgtscH4TVPBay2+KykAXFFmC+yKjakBCEdnMYPQ341H//AyiFk9eiP6SG922?=
 =?us-ascii?Q?ivpL1M0eWXM6a+huHgWswyXANGDraAW6T+JsQpmBNlciK+AtHObwVV4b3W5N?=
 =?us-ascii?Q?qyCxvG8q7MCtBHDTliMgAG/R4BiOA+E3NOGfb99L5wxlfLRQZoDkI2tAHFL/?=
 =?us-ascii?Q?cIR6Rfz1T3uU1Z5ZuPgM7elJP/g2RAZTzTqiRVLQ7xsIJFEXX7ZWJLmEPnYb?=
 =?us-ascii?Q?Q04ktcnB7cABsSoxh4dvwpMLdaLRVrM7erzRvTE4W5EW5vGjzyeDEEP4LGKF?=
 =?us-ascii?Q?0rnIJLu9CCXBMjfPouN5k+lnG+7EPGJpWI5zPzwbk8eetQAOn7Jj/btot0Bh?=
 =?us-ascii?Q?eF2SCyDoNPjNnj0eL7nGt3QiEiadmhcwJMFf9IBrkHlGWkU+qpPlNSR6vKKN?=
 =?us-ascii?Q?a179m1mpEwqk4k4Us+SktaVd3ktIJQ/wIrFG3DLyDRv+Fh9S+gWrQQqDXKGv?=
 =?us-ascii?Q?Bmg4PVrJkfU0Vrkr4f7MafjYAX+tRC/O/AXdRtArxrYw8FtRx3Hn23roqT3r?=
 =?us-ascii?Q?I4hkHcgFW/YUcDJWLtCrzK5t9GceiGc9b9Va?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:40.7423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09123cc-2ccb-44e6-6440-08dda3d2d167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a998708bc0745..3cc49c82e324a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1202,9 +1202,8 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-	amdgpu_fence_driver_force_completion(ring);
 
-	return amdgpu_ring_test_helper(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.49.0

