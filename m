Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F55C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B207F10E884;
	Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XE1vQxrc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9267010E86E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsoZq0k1QbhhNWybJcVuqBk5cPw2QVVnodukOhKhKlZ/DlbQi0xp4BVXkkBTf5lPkRhpHlYTQ+st50bBstzxcHeUgeTRt79tWxdpXLxZ969LljxZu74QBYTgpev/Z60XlAPGOaPCj7/mGJF10zXE8TbsmZ/GAwQ2Aw775hr3TPnUYlTKo1TVILntsdzzJoGSnNuMv4YYuif9eoxj1Tg0UTUs/GjLxfxEY6I1lZhR19f3N7XNeUBd6UExUUuTDwICbRJ1rqVC8qow6+kNLV5LmmsAg9s0hrF5Bf2MzgZXigU+0gxxeFdv6JRrdJNPxjCCBhOuYEyN2oIqVukCBe1nNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlEQYGSOJwaseoNzZluebcLOmvde8B+nv6PinTOAk8Q=;
 b=pzqO6UN3BBLtsvP69FdwDhbV4HbxNGRsF7d0AVr4Yqh4Jpqp/89QrybnywAQPy6zLDyPhD8MuGxYxOb8TJzVf7q0TVP0I8RF8FxdDQn2FM0SC1aUhkGkD2nooByO6RZKD/IT5Dc7+6X21hoAzm2teasF2d2ubEpk3tnWe316cLY1tYtTZXbja3fYqG8fAqetmIgbVDbm9ZvAglQ+RioSMhC/bEWHscNlMSiiCUIt/X5cbrRKV3ciRj7UqZ+2CvMpJhm+6TIIpVqi9BZST7bwaYDHp3lr49n61cAvBbUOVHOgmG7eXtZvzw6MVfoUpiTOVhjiJojHWkB8Xs6oOYZN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlEQYGSOJwaseoNzZluebcLOmvde8B+nv6PinTOAk8Q=;
 b=XE1vQxrct7kJKYVgx/0jb2oP5b5wI2YZWiPqAwRnHcUx2zeLYknR8EFmcp8g2lTFQC3VK1Bpa7XmsYq/LzJgMeA5F3rN+v28ex0IPT4RhVQqx1eJt4sj4L0mAeiKDeFVmOvFMwQUX5fDGfAkns1nyDpiks4uGPQSMVegFq8h5d4=
Received: from DS7P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::8) by
 DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Mon, 24 Aug 2026 22:14:24 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::a) by DS7P220CA0016.outlook.office365.com
 (2603:10b6:8:223::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/30] drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
Date: Mon, 24 Aug 2026 18:13:46 -0400
Message-ID: <20260824221352.1793542-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 98354641-e46f-4e9d-66ef-08df022d0e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3/ED7Q+NcweveyzNZp81TKdXWIQyorDzvWrRj61CMs/1A5KlrREZaZm3gMwW1v3tMX7egKyMHrgum/3PQ+xIVvk0md0zTqhvz5kjmk5pZFeYsn34i25zazKZRR/bgH1zKnRQxTmwPC6XCsY2P9UPSag+d2Yn6WEEtpledKNZivpMDOkAFQVak27KNR45ANekjdCp9sQAj6M9kT5kmg5Eno948Y7tJgyqnFZbuxb5kIN7B0jLkODS47F41m3zGYH434aI3k36TvkqxwY7iQ53PpvqRAskAD/3WT0ZlKWfipwCn1ZM+lHe5xkOFBYF/pnz3vPv3GsPR2tKvaG0ah8QJKE6tJia6W4iAdl71Uisz2Qtf+8dzE82R62drpVD5qiw23LGPAB3kQleQi1iwgrJ8YXgPTt3WYY4wt+HkFI4HAxHEyC54K7pPX6rdpVfhDhOjlxml6l83r62SzwIZs4zcfqJVboSpgOgydpoemrwSsWDpgF5Gk/l3m8BjVDrF3AeycR/POQqExJJXToGYwLEW5auEStF3WwTQsBNwsxJ9WRr4pKp60FCeC3nsrqYadEEpiogeag2sjYGeup9K4CsKZ4SS8dUS4b+yNqVFd7A0g1JbiTZ6uMUSqScccDiTATQyTygQ0TF7p2lrnSc0kaFv0kHZ8BDIO4L6ht1fk21AiyllvRKQjNScXZsyK2SuHeGo47puOZsHe7oYwpPCklbqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ABNdq9O6/aHYzB4nEU0lB+kbNeUpkQj+N/fevZp4c3WWPy/anE1Z02jLffHZg4csQv7h5+xvWfU6ncJFkMvojG2OJ1/brWED4qPFxTXVsYJLGDwmNGoUYV3zwSTbM1mZS+g2WKTJe67Oi+y9536kYlvomUuwsby5ducFxojrJKONUpvTwU3vXcz+nZA3SigtVVNPUfdrCZFoqjLoCk6fbpHhl5YCRP29yka0yhdG0LqA8W7R7MFXgbTL8XMRZBbc9tszN2op5M4GGGo/+Ew/8HQNvx5j5ar3l59lJvg0+2+wB9CjjkO4yGdUe6MwM+uN6tyoki8fVtRaTUGXqXGN/FN61B0x168/8Hb4Hz1WjLcJusc6WeAcSHj5rBWKckuA8ZEH9fG1xWKSVR1lkJIr6S9x+VEjl83SeIhTLRP0ZG27P3uBcbNzGRMpY1cB7tQx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:24.7327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98354641-e46f-4e9d-66ef-08df022d0e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a35c84cc7385f..46e98fe66dd3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -952,6 +952,7 @@ static int gmc_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
 	if (adev->gmc.flush_pasid_uses_kiq)
 		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v11_0_init_golden_registers(adev);
-- 
2.55.0

