Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB917C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82CF10F611;
	Tue,  3 May 2022 20:51:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B9210F532
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdTfcpGcqHloHkOMU9M3aawvyBPNiYheuTIesxK3hsVpKFZlPC42YF71UXtQHN/EnRn9v1lE1+OGpRlZ63x/XA+ehhp3Z5t4zEszpZewi+u9P3fpu9awe4rAv/v6Oh/o6N5poaGm9KLumeC9o8nmD3Ymgdyb1VaNqXLRiN8eNo61E4iIZIvTLHZy/oolSRTaw1HKxQof4dKlh/NWSfjpBpO4Ubaz0G9BEjXd2beHM+uxFvtv9P7nUBIoKUrb8hgJ6Li5MHNlEqlOkW9O6qxbdzGwACihj2QgBt4nFTlDb61hsqcJ7fR9rbHf5qZFIV8UWT1N+eeurNp7/gEroMghAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2TM7pT4/QDoUp5cVfTOBdpCtIZQqVKdT65CCb8zozY=;
 b=VMYpAt45/IRB1B22eXIslumfZW06z+UtY6ajkVXZgOmSiO7UBmcQXY7vTEOQi1VEGmpyw53HgoDW7erru8NZ1hPPKFwSCe/RE8wG6NJnq+09qzxexn6nDbOFcTwq7pSg/4+fBQNdSVzu98v/jMWqqhvvfKWORMBW8pKYkd95b5+1VLYUZ9u85Eguv5JsQsPPPEaZNVKxI9QB1BU0LZ02sd73yVet6m6GEHs8CrR3a81c5etL4wPtxsaH8noxleKvFRKjeKpssCOd86i38UmG8EGB35nd4dY7aGXEK6Y/5p3E48JCUVPmferG+SBypz3WIHQRUIlohAsGfwKPuhncLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2TM7pT4/QDoUp5cVfTOBdpCtIZQqVKdT65CCb8zozY=;
 b=QBcNt7UKIVNuckK3eBcWjP+/N0KKBj9id96nMMlBIpv7wKz4VFMi1uzr670jwhBoiM0Y9EC9QGYk98EWiAp9Ui/Byw44b//udMbTRE0g84u27b/lX9SxlnxU6oPBnIrr1Tf9hkzyBRT5Gca4Og7MKFFTRrLqPEGXTZSuh5puBeo=
Received: from DM6PR08CA0048.namprd08.prod.outlook.com (2603:10b6:5:1e0::22)
 by BY5PR12MB4802.namprd12.prod.outlook.com (2603:10b6:a03:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:51:32 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::c0) by DM6PR08CA0048.outlook.office365.com
 (2603:10b6:5:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add GC v11.0.1 into mes v11
Date: Tue, 3 May 2022 16:51:08 -0400
Message-ID: <20220503205112.1285958-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af2c4c1-bd3d-4c17-11d3-08da2d46b428
X-MS-TrafficTypeDiagnostic: BY5PR12MB4802:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB480201446372692DB9408882F7C09@BY5PR12MB4802.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIAL44DFQgyizTqdA08ydMpHsDN8HoVRlfPkWubyd0+cY7TPjwFMQEOS4CsXiCsU5gxCM5E/sh4DgtWkeL55Utwzokrqwo4+9Q2Qy9VWJ9exMr5bkA5xok5kJ9XUp5Iub9+K6NnEpnmH4ub2QLGQln9Hx3cB6FT9/VthNUMr8gknPo1RqA4JKwAr+5pIAg6YozTGAHjj3vK0rW7oujXkhx501u15N06mxsm6sa1fo7WNqEFNX/kh0+YuS8VGxyqvN6S9rmTBs5tEMcndXDc7diKFKmCSddWeiV1PnJeYIaVvhHPp1B0y7YuWU9e2+jl9Zii3y8Yqsgcvj6AuWX77tr3SQIMA2kZaAwc+TMIRQEqxV10J3LPd2rgQCK6uT5ycJeY8pUoWFhqQUenkxf8bfm4BpWM9SvzJGEmr7NPEGfrC881IL4pZ0zd0j/Mv1/5tkLRLtjIOv6ANTYHyChEmpxR7bdh2DxZ8zRzLqlPFsWJrQOoxyax7KyO/IG/Se7JDx8ZV1IBe3ivq4tKMMQrFEe85+ruO/B5wcvv4g5QhPA1hvPgpZwm8HepZQOAHjXoQMlOlGDABZavD4Q4qra8/+QBuKvGg+GElzgOFIxlU4AEHfXtzKyW5TfN6KvWH+N4e8ZaC19VxyAgnPBTi7UU/QAuf1iWpRlJsGnN08JSFDq1k0dcxcH2yDpGu7SHpbAlnvt51eeaRkrA6KUAnoXbKwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(4326008)(6916009)(356005)(316002)(7696005)(86362001)(6666004)(2616005)(508600001)(36860700001)(26005)(81166007)(47076005)(40460700003)(426003)(336012)(186003)(54906003)(1076003)(70206006)(16526019)(36756003)(8936002)(5660300002)(4744005)(2906002)(70586007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:31.8738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af2c4c1-bd3d-4c17-11d3-08da2d46b428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4802
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add GC v11.0.1 support into mes v11.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8af935930f89..840f66457ffe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -34,6 +34,8 @@
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
 
-- 
2.35.1

