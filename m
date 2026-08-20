Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86725C5DF87
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210A310E1DE;
	Thu, 20 Aug 2026 14:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KW5fz22a";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600CE10E1DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 14:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+cwHTLDoBQo6aFxlRiaAiKt9QNNvPu3WHU0fpBlacze58PgRx54jktce5J44BkvfV4763AWb91VbU7lN2TE4HioqQ/076RQxfs5S0JlyraiQlj1I85VyRpphSWtNVpRwx8RUtmqbQCjU+8sAXBX80TiqyRkPdxvOEZGx2C+uM0b8KZY3AYScvKgM5Kb4fPbdohfKDMthdDjgeSK30Lea6thfze8/psgAQmY1A/FyDp9bjY1Muh/mbWy3vx6VDvgz28fDBSvOn9NnSayP7CH4TOEY/kRYPzwPfWnPhvA02iZcAPij3i2L+y5388W0LAie+0RNstzcd6cxwNK4kmffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWj7bHCoXI/iLCSaeS393yxJdxKvvvWK0kvMRt4UxsQ=;
 b=iVuVTQUSACwN0QnjR49/i/yQs57tDAljfT7YWrz7lI7VsKIMnqMzKhfDBVXmwyPWdapnZGVtZM77DXP54n82vuswGJsM709vvb2oPsisOBwpUHZaAHdDZnY/UZA0D2YPJu36Z0Fj0z6tbfmY2EdqjxmJHfGSFMngylGi1hKSt1Kj59TyHnEVtECFgn4jPZZHGmxMpiIi12cXTaJ34UFz2vqiIKqHx5+hNwrYF2lFss2GZDlSdzGNXf7WEWkxWpYUViGedsQNIJ5yWkmFOrB0nqltrsebxb3HD5iVpJm5Qz9hYZjzl+nhvgAMf74/C5diogH6Ucmp/QUPCT2GU39SEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWj7bHCoXI/iLCSaeS393yxJdxKvvvWK0kvMRt4UxsQ=;
 b=KW5fz22a7jz+pn3630eddaQlXbvgbabawsXyPAdInSoKB19yeE+T55HHLGj63+tLYOoOuUErbBjztb/kK+0jKZ27QUlTTq3jVth1rtksJc9Xx5JGT87rHWCBgWfK2tm8vymH5Z3x8MYq3Y+npdZOHEdf8acyCun+dErlXxWdiag=
Received: from PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::16)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 14:04:51 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::a5) by PH5P222CA0005.outlook.office365.com
 (2603:10b6:510:34b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 14:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 14:04:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 09:04:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 09:04:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx8: only apply compute quantums to KCQs
Date: Thu, 20 Aug 2026 10:04:33 -0400
Message-ID: <20260820140433.2875442-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: d55c652a-604a-480e-4ae0-08defec3ffa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|10067099003|56012099006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: BAKLrZs1W7q6df6lec9nw06jogEjvwzHleVWgKfBQeAJuKhASZgq1JMAfRkrgLzZmjpGfSgPFIS6lM6gnA46JAwW3RIeDlLBngke5eM9yd1obD6L42xHJkWIki/MY4LaDVXrtpqR5m62B7WzwGkgHD0LmipKek+Hvj7B91dkfsRdZzag+zgmECFtqF6QV/qEJ8hCt+4Vp7zRl5SXjxB0IC0daHxvf9cqS5b7/FNZ8vQrYdplUwaUPonEzlE4XTNi8eCt07YlLLhPxBVj5QeQYqFBLRU7Y6Ibqcf5PKY6dv+PoyN8Jxd37/66iYREV+QBGIImBbImnkIBpcldsvWdV51V+QyToDW3TqRlsFUf4PRk8e7mdH/QBz7i6gq4iGhwPd/I03kHsc6pl1Opt12vIp/LVYfNDbOJQr0oV1/mvAqQDLZnnglYpBADOIx381klW3Bem6imtP4NyqvPFnYxxZgL1AxLqQ7sVeQ6tze0JJOz35lSlZGS7TUltwMaKRQM1rn6x0i+UX9SloEENblL2a7RJ2NHAgIq9T9vUHlPh9oIsRidA/UfT4+s4s6mmYNH4sflK7YSOMDIjsrqIT5ltEbpmdG+Ad2Vf7El2LqM7K3XQVH7PZo8LyS7Eq4LYQa9FpLuunE86XzYXRbWAiFDuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eOjQtfXB6p2PWpO3hYkrNORxPjSxu/G5TKGmL0oNlasH3X83XPiufK0EWlUzW+g8p+MlMBe9rsxHtmDSYQzEU1+yoYDqE5c8KPXSO0TYdr9/KKc1+9VcFN+Yu3CYkuSdDn7CoIlsF55SWbrTtCxQSxOasOyjEPM+WvGGq5xj38/JsDHRLpn/TJqsF5J0bbVrzwr4Z1uG9qjHPIwY288SMvDGrGq2xlaUFIi6AisbHPtpDstYKxIEeL/szkSZN/qjyBpkyt1pmaFMnisyxRfdY1PCQE9CG+ngmKpYudSCAxQg9lLf37SAU2Ls2UxL96OUdcMZxwwApiZyigtQt33UIOOlxiqlVKJI2jCtH839aqUqwt9tmU36I5fp4OzaPVMQmJb/vt4h5Gqb6HXgFLNqu08k1tclRdx1WVd8YRAanx+pQllaR3AuqLKeQZ7zPooD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:04:49.3882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55c652a-604a-480e-4ae0-08defec3ffa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140
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

Don't apply to KIQ.  Seems to cause problems on KIQ
on some ARM platforms.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5658
Fixes: 91cf34bc5a55 ("drm/amdgpu/gfx8: align mqd settings with KFD")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index f7c2b149acd0a..4241453e0ec8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4546,9 +4546,11 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
 	/* set static priority for a queue/ring */
 	gfx_v8_0_mqd_set_priority(ring, mqd);
 	tmp = RREG32(mmCP_HQD_QUANTUM);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
+	if (ring != &adev->gfx.kiq[0].ring) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
+	}
 	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
-- 
2.55.0

