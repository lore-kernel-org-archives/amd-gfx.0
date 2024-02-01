Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2CEC4828D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 18:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8516E10E124;
	Thu,  1 Feb 2024 18:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="foV0b9qO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58C010E124
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 18:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TElSpJg+roy/0KGTuVwJpCSqJ2JvhugIS0X32nmVOwSR17R0wAxguXX9fi+P9XzX83pyvxnNSUFyzyklojnQRo3mrjtLG59pSAJXyfRsOTP9/SxWlFCkp6FkXO0bxq+adlHVUZgUYUa6BaIT0rjirlgZOpEVPW8lwCMK/F9kkUMSUjI7mhrqaQxVZV8oR+GLZoxMLqcO4MzL+7W5Nmzpg/AtUF9Lcp6svIqLs4GpIMppqwJ6ysvmwrb6r1G6ljdtwVCgS9EfkguTGqjjf0uJ/rA5q2UcaQBQ8VwB20XsyvgIK4TG4QOCvzwGNkXnjh4qTbCKcYvfDIJZIth9NNZ7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV2iYxgpYB5SVWRlZVcPDaZzcYqMKzL5GXXhRA6JEWY=;
 b=dwnROyq/Kknjla6nCdGVuoQbfZqJu4AvyLg1ORPYUkkRJFmWwJNIzSRi4u6XmcwG37CHJk33gbfRUcOJh3EFsZPOfL8EsdzS9TrDXijMWQl0tXgIDSvYIYqgpYsrZ5O93sodEm2zhf+gCcPtSuxg8d0ysvqJWnFGlgxeocvWOG80bFwOKV/D48QhlIPjU8mjUu8kLgRI/HAvbwQxf+fm9Yi0K6WcZxCbhh855EuszaOkGscUGzQV9mXDP8yzx5bBFryvfkmz6IKisjf7nttFryda4YFActFiNMyJ3+fdb1uc2PLua/xfGXarDhJ4ltCH0TLaH+sKs4NWtZEEgsGyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV2iYxgpYB5SVWRlZVcPDaZzcYqMKzL5GXXhRA6JEWY=;
 b=foV0b9qOWDj8IocVtzAmF3Plld+DhGwzqqnsqYgvtAhq4iY5kKCCELgLNi4VbunngLxPhO+7E9BhWhxjXH8crxyRLNSTMk9YpQa+5nCU/tDHA03jThP+imrRLPcXKf4JhAG7aBftIl2MBl08v2ERSSqbbmnWwX0DjoqmrkFCIJE=
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Thu, 1 Feb
 2024 18:55:02 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::c2) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 18:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 18:55:01 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 12:55:00 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Joseph.Greathouse@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
Subject: [PATCH] drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2
 onwards
Date: Thu, 1 Feb 2024 13:54:45 -0500
Message-ID: <20240201185445.1461461-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 22385382-b637-4880-1015-08dc23574ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MaVhwnvUJ+umRWRAVbBu7MvKR0PBLjiLo2cjJ5y6Cky95sExDgZLBczfQKKecYRhk2dxfQUT5p5lQYHiJgaQyiT3MrEyUQ/ux6nELMJwV/GZJhMVftBDOvpEdXoOtK054P0hCArvQd1sicoFclGv1m4Nqwp0cZPx1sQbyZkYuhbR5mMcpcu2gubzZoEL+eilDz9b0Gr46OHBuCzYwXyfCVGQqDho+r+Hjx4oqO6rQkjqQNqIxOC8wnLA9Osdg3oF+CH//CPAGdSq+Cr8HMrDgHMf6B7I+WcI4DKH9bNpmD9XeMVCGT1LSFK+8+d5wJJYnzjwa8kuCFY8NE5mgDheBx5E28BGxNMqu2Fo04xrvzksunTMSOgY79hJ8nSQVb02ctoV+akoYU9iCznN+YQEFvvkZYZ0n86baLnFpD+3vq50trqm03Uic8sI4KZo44dl8UpejNixqtbVC5RYSj9YrB1QHS8soBUaBmn8xLyC6MJTEA3Zlxx0yNG+Z6TwtRSPhFEACUAtiotu55MP0SCwDfKEkR27kX6PCO3LgL7ioB9XSzWIq3gcW7UdLbF9qpTFKggoEeJfhe3htmaCAtSzLyLH/P+IAdJSvfOIY4yd8yNxj9emsZQWitiXjOXF4o0Zo/CioyuwLxjQE9M+/WnUahC5aCE5pCBYeEVpn6nolRw69NFI3F81SRaD/4B9i5oL3zhlSV8SFsOoTJJ2fXkOMehF/bZtMwigzjHt1/e5fW/qDEPbpK5olIKHcRKiAGIPEqR9JOAIBhTjFM2tqGCKIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(41300700001)(47076005)(2616005)(1076003)(44832011)(8676002)(426003)(16526019)(336012)(26005)(356005)(81166007)(8936002)(6916009)(5660300002)(2906002)(478600001)(70586007)(15650500001)(4326008)(6666004)(7696005)(70206006)(54906003)(316002)(82740400003)(36860700001)(36756003)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 18:55:01.6178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22385382-b637-4880-1015-08dc23574ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
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

In certain cooperative group dispatch scenarios the default SPI resource
allocation may cause reduced per-CU workgroup occupancy. Set
COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
scenarions.

Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 42d881809dc7..4b28e7dcb62f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -303,6 +303,10 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		update_cu_mask(mm, mqd, minfo, 0);
 	set_priority(m, q);
 
+	if (KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2))
+		m->compute_resource_limits = q->is_gws ?
+			COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
-- 
2.34.1

