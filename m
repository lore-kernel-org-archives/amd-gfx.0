Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36492CD3442
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 08:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF82C10F054;
	Thu,  7 May 2026 08:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v2bAwK7/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350CB10F054
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 08:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDony5HkuIt/CIW03tGqypDQ7M2o0NH905Nty2SiG6Tdc10B5xJKNRlKzHGuHeRm8+QGFBMXipTcvXdxxnK9unYRInO9+lA9632KiPfWcDcykXzqh03jtwzIArX9SOJLxTjYOI2lVXk7ng8MbDCRqXtogoyvN8g44QX6rZTuaSwir3CQ+fGJzqvvS0Y9xAWGSqL8wg4kGgzdDM+K89U6zblzzdr9oOeHVVnhSwzYjVcTCOaNLw1MmJiOBLiAjfm43oReMHC2OZ88cWr/eu/1r6MKoaFDj+x182a1avsto4QqCXxUHwv1ObfZ4vM9FcktDchh66/IgXPI5bMvJ7QiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sc16hSsQOi8GhJGrUSUdVWo0eBMNpPfHgvrlKvyUu8=;
 b=PxvzZx4LIlIqz0uKFIV4qvY34pi+0YJY7hLZpc65X0zWyHc2qhSPkHpzf0x1J4u0MEEMEh8h0tECup+yxkiFAT3wYSOKZX8VZeXuDlYA3zUANm22n0c5GhKE/ln9N46kXlZucUH4B4xuzvfrj2JFaDFC+7bEME+YaZ2mZI5YMwmfnBF/q8nPCiaV1k8mzRI40Ljj5zWauBJFv6W9uyscZNe1MK+cP7EUFSAuo+6UJgenJH9RMlZDrZ+tD+Q+bku4iRxqbs22JgnlP9c+5odpl4cwISU4021HiRMS2WmipM2cEVejA13xzyhlrM1LIZv1e25F+Z7Rh7aoFopUI08O/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sc16hSsQOi8GhJGrUSUdVWo0eBMNpPfHgvrlKvyUu8=;
 b=v2bAwK7/z2OKDSDiAX4qNUaGIcaAUaCQ/xZq6bTJd3j+NQrstQFFD9e6eVANxH9VqUN0LN8od/10lrVjkm8pT3FW2M2t2eSy0rPY7/3k0T2m1bxYheiEfnsvC9kAnOk7bgr2QcUGSRHvfRjsOxBxl72GsYCGbtexF2sluyR+XQk=
Received: from MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 08:12:46 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::33) by MN2PR11CA0022.outlook.office365.com
 (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 08:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 08:12:46 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 03:12:43 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>, <jack.xiao@amd.com>
Subject: [PATCH] drm/amdgpu: fix error return code in mes_v12_1_map_test_bo
Date: Thu, 7 May 2026 16:12:32 +0800
Message-ID: <20260507081232.1133522-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 1851554c-fb22-4e50-b26b-08deac106bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: zePQ4ZMy8V1aPmBqz2J3eWF/lEoxAT6CWxEFkgJ3Rw73vjpciqOPTfxSMX1xexK32UWvckZy3LLQqsLdo26XHBCKr6cI32I3qMaZReKTNYvmGnzaAHjPLG6SiSS8jjBlnMP0l9pLglVQNQTY58QSxTfd8rk4NSMPKkEppmn+NUYeXclleC995WuYhT54ZAM4wGndxGrqyNoKErYavFwXHFEsao2E9gBeDlOgCMMLmkJbIImERI00T6th5L33MkXgWqfBxcY5lfBxa4Rd2yqlq8ncWKR0nLbIo5aK+5GUhjXx/t7o/QC3giuqpq4wZgQVG9HfsaMfFnoJRf21CAvztOPCuoITufUODNUy8+A+/KgUqx3gUcycjiaC4ZselnW/FEdNaFre2djn8KUrpqGIyVTZTnxj2pdhrgVum3JCPEDiZ1MWtnM++bMabte3A+CiD8k+6mKG6zhmCIhhgeDzSgC49Xj4G2XzlMu6ywpj/ODts0wllpGiRpoiMJdnLn/kmn9/DpJMZhDhB4iFkzRZPsDDl6U5o2VsAko5hz8OWPHvfqkmrlfkxZ+8GjAJxEj+TYyHByJzuQ2LOL/YERiU1tvJTX5oY4IK6o6NXPz+w/DqEJle1pZOA1sqeypCoSlRSpPZ8RdSiJt6U34goCKPn+DQNGh9s+DRE0si6TRM5jC5GIZsAgxHCmcUhVlizJMZ0IDlq1WYFIaMwK05wL1jgqIhZYUm3u05aXdXfMKTL/E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rD4Fch0UNs6wWEMxkG3ZH/2lUnTCZVz/mPIaPv1yu+0xT/lApireHr6MgrhkDMa4i65/Rlm2mjvo0OiOkFxXv0ZL3UpJSxfa3x72IB3iu/rdidlmmyEqPk6Oon9sEA4SnQ2CzRIVjz1suX5IKWC9oLnMdb8k41nQQcKL0jB/KTFAWza82ourYn2u3QEzGKisAIZh8MMIOtOWTsi/Zla3l5fduguWS+wD3cQgBxUqA4em6Phguj1QE/1URCcH2nq+x+B6eUcIrwbDHzdH8o7LXb78RO8KH+hRIkieVHg5Mr0mbxJBYIIuoXzbSkUIGx1AOOwzyeNTLW2QV8LK6+OUs1K3qhy73nDlOqg+fhkdAcdrN2IjDmipOpOOyVmKOOu9YZ7KGkydVOQdwzxzJ2l9ztU39ItthhTdpen0F1g5mMOVpPZQuAYBVhh+V1pZtY8B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:12:46.0729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1851554c-fb22-4e50-b26b-08deac106bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

The function mes_v12_1_map_test_bo incorrectly returned 0 unconditionallyon error path,
which would hide the real error code and mislead upperlayers about the failure status.
Fix it by returning the correct error code 'r' instead of 0.

Fixes: 5ba87c3e9e4b ("drm/amdgpu/mes_v12_1: add mes self test");

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 1931562ea6b3..4217b3fea0f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -2063,7 +2063,7 @@ static int mes_v12_1_map_test_bo(struct amdgpu_device *adev,
 
 error:
 	amdgpu_sync_free(&sync);
-	return 0;
+	return r;
 }
 
 static int mes_v12_1_test_ring(struct amdgpu_device *adev, int xcc_id,
-- 
2.47.3

