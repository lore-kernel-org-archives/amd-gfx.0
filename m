Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BAFC5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F208D10E76C;
	Thu, 29 May 2025 20:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DYih11pD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B432510E76C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf9KsZtiI2kG13R/GiaEyMSDGGKYZc7r2SrAAPNrHk+febC/nN8JusO1kaXpbZFTePq69XQ2gRFu8KL416V0aYV5jBfjEiEXrB9U/qk1sibOiqFAOoZEiHyjd9qf5LgJo+SJo1gZAWE33K9Srwi6FcfFR+CLCc/+VB6YFgiGCvQwCTBqCQp2T38M2Vb7VoGlppdLWtMS3OPBBST00nvclMNMnjVBlwO/CoRbFyMFvgw9LcrZlZLUL6W3TqWpL2GC/UlF/p2QkkqO4qJcXQDl21ZPqZePiH4gokDcvChAEa4ULKs2m33HrWBePEmVipyQZdBET9KNDpyFoPwGL1fvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8wn/HIkZlOtvooYnqC4T27eIz2B1fa6zbY5zWyM6wY=;
 b=vMSBOils+FWWgqADxk6O1ctYLoNmI1LTc3a5NRdj09zl/NptYk9HPVXy4CI2WNZ5KgrgabD3umRaxmZLf8dYESIh/dGOFpG7D8US6mDZAOj2ZpAWSSMCRyPdQ5+I5m1EPQO/s5ZTNvB9RXWdd2zQRwcGslg/+aJDuZy+59g5jv23lDaUJEE2ib3JDw6iXaraU751KI3LzjNLZlp+9+uvgRdM3hn1BW2L97/GUTz6hfQOv4uZKwJ8R/Fs8M4YzIwgdzPZg6akKZ2Vy1yC+LW9dCFlKDOgToq7Ht6iuP2Bt6IIaLETXUV7zmXsCtxNntRVdn+DgijLZkAYl7H2JNCr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8wn/HIkZlOtvooYnqC4T27eIz2B1fa6zbY5zWyM6wY=;
 b=DYih11pDZCDUrigrjPhIL1Hdu1Ye6Zg2xW745wXgy9Ii56UCkM5TNc5nKmGXOBOIvIoXGKG/w7dk3Wh/t9uZWQsAvW7LDVO+HPBYO3icSHqg248uquPI5Y3S/KHJa/x4Ht6STHqZudSc1U6za8kZc12nXG8a3mclWu2efzqfks8=
Received: from MW4PR03CA0040.namprd03.prod.outlook.com (2603:10b6:303:8e::15)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 20:08:35 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::2b) by MW4PR03CA0040.outlook.office365.com
 (2603:10b6:303:8e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 20:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/28] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Thu, 29 May 2025 16:07:55 -0400
Message-ID: <20250529200758.6326-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc9e932-3d83-483b-5015-08dd9eec973b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hc8rQtTJyWKfgDovf1T8Mv2nUjz4Pd70WGqPaOAr5t6r7B5YZ2lpoDc228LU?=
 =?us-ascii?Q?6gcY8+eBRc8UUV+1FYlhGSyibIDQWINy1QWtVzZEaVTOGpcPGVUJ/OF0y0kR?=
 =?us-ascii?Q?laJApTqn8kqjs3YmokQ48cYVTD9We+YGQc9NV3dQc0A/RK5EPNxI+SsNNOan?=
 =?us-ascii?Q?a/eazhD2zTqkAM3Q1cmJsqFypNxBn/wuxMS82i9sbkh+1eIsUtcN6Qhki6Vw?=
 =?us-ascii?Q?vEZ05sZKIrgxdpoCbed9b0K5UKF53tNTVEwWmbiD/Mq7bZ8oRyhMHvQOzSaU?=
 =?us-ascii?Q?sOshE42OfMXiOkWRMpeZ//sUQDz5tiUtmukqdJjhXSSzJ/fx/5hDq9BstKaK?=
 =?us-ascii?Q?mFTnrMHD5fIzSjxnX3HY7j4I9OVVeqOLlDWtvQS5fQjJvcl+flayBwmYA5w/?=
 =?us-ascii?Q?+Dr4+sYeVp6Ak3BUxcyHixGApaEHTidWYuUT5LfbW+w6akzdVzL3c3CYUgYg?=
 =?us-ascii?Q?pKjMsLYpuM/jin4WhrpD2qZhRPjvw+Z44trif2CSqWcgi8ApjwojnG2lg2lo?=
 =?us-ascii?Q?jw46l920Iaea112eE2CVpimwk/osUobN8xEc2JFJ1wAAolAXBFBfnXNLbTUn?=
 =?us-ascii?Q?lxJg64ExX9JhERYVHsUgS/Hh6x67sjY+rvU1C5VmTCnkFhSWpi+7YObyQR6g?=
 =?us-ascii?Q?Pj1A+E45N8lvKShYpUGxpmQ4cNfYNFGiywnRS8yEwgwb3SwDp+mvjAMN+XpH?=
 =?us-ascii?Q?9ySBLK1LtZWqE8DDDaelrCA1GEdmYzb1AmwgdITXLdKBNbpM89bzYSOyIC6N?=
 =?us-ascii?Q?mC5sN/7uOvfs9XOqoSbXAB9JB+9gst3S1b+SVsKt/krUhTctvC31WUT+l+Uo?=
 =?us-ascii?Q?4Dm70Q+MraFEsXV6NtJrstucnOPgnbAEMao705KgPoYKQit6auczMA/7wDoS?=
 =?us-ascii?Q?BjhP4rmMgrDV5Zmqx3LqvO5Gbdqgd+A91C09rzoTCps/l7h9xymf0e8lbJJq?=
 =?us-ascii?Q?ADjyXVIWz7urH0JMmRWaQ0WnrzCxO6l/stUFcXgtskqCuc/1ORGwQBKACCsX?=
 =?us-ascii?Q?xQIEJl/rXTWo+OS3lhyA6uimqAqIe6zo6G0Ya+Y25exa+Jekak7MKk4KZaYz?=
 =?us-ascii?Q?g8rwzr3FendhShtQE3cjM8JifcNLcxVxQLwbyhPNn06CJVzSg8oCIZh+hm+e?=
 =?us-ascii?Q?UeZvoB05zFOAAAmhgyHXuG5E4k7xwD4HW+iKmOGdfA6HU+MlBFov8MmYzBvr?=
 =?us-ascii?Q?9h1AxXvckQmovhCXDJ4tPFazbtunAQJ254hd0OdSKy/ZtRnW0OzJvjyDvHN3?=
 =?us-ascii?Q?cFyDoCNj94vjC5nPkOGoEzX6l9I05mp+eQ24oT2+5+HehlDf3fj1kW3dWMy/?=
 =?us-ascii?Q?CcQ6bOuuZf1zhC7nJ0HdS8yDaHJ01FzdFP14v7yyF1kNs7D/QJ63S/KH2R1g?=
 =?us-ascii?Q?r1X1fFvn+Q0OUq7mZCoD3b5bCF2G8PmB77CJQWyrznWTQzaS4aCrHVs4udHu?=
 =?us-ascii?Q?78WdNzV0Sysec1WAk66W3sVOYXjbbPXCKdj51jSBLIop/Wx2ZdxgB/OnE1BS?=
 =?us-ascii?Q?CbUF4RZCaIK2AnUv2oDRXD9lWDjtPmDd+BP5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:34.1942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc9e932-3d83-483b-5015-08dd9eec973b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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

