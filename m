Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDB7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BDF910F516;
	Tue,  3 May 2022 20:51:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AE910F4C9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c975mbiXa+etvKWpv0G8WvyhH51mFrYRq2yPw3BN+WH+dbz4FjGRcYxSUp5BwDKU4rDM5+/yxpF5JuwYSsnxZr+oVhbMLxK4G2rHqh4MuJ7uEh87vYEOQnpNyDq8WXedC3YaFStRIw1jSupbMQzZoqB3o+yWY5iey1lsD6pBv7++PdD/Y5y402azlLngQ4F9GZlVg4/sye98LqIIm7PqsMyapVvHDjjO66f5LdqXoy4wDIGgTcAEj13JaVzOUz2sWdl9idLO9PlRn0kLbfkp7Zs7hN1gur6SY25SBQBZGRzMu2f6JAbfA+w8MhkU4KvTvcYo7Z3jEZp5hBCOaxt1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdO1VzoJt/fxzyFq79X5nd0R5zHCa49fH7lCujffkao=;
 b=Q2XtzSgw1Omy8+GM/8+TsLFa0ySmJKvNLyc95uUvj+UdfDZ//mSmcOZc4VWJA/wbFQL4qs3fv7loRT3bKOtao/ivL+jARyIi84Nx92VXlU7/0jbnJQfggiXRbMt9xH5grQ8XMu19RG+F4sGT+EOMpdV234pULkQTw5o7hg2u2bK1LRW/Lxmfgii92+3KI2bvHh6CWth8v/RYN0g/SPvPmazCfrhZG6ts/PLSiSc43Sr7sGOib10htcwgZPjFhLiil8/D5htkE9s5D1sVapeg8mu0MkOuNLnredKeKlQkLMSRZuAGyqUGeex/sU0zr4WIuyoHZzBKveW+oGsqeAb+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdO1VzoJt/fxzyFq79X5nd0R5zHCa49fH7lCujffkao=;
 b=posQ1iqVI4LR3UTRPta20jUz6ebwDZsBnZrSIYn4/aAoLfnMNZyJp1NZ3nrvKUrXKw5VRbqs7mgL1Z/RVrYyPs3Gr2DxS/yu21FU5a+YDsZ2AvQ9bfPAkZFHXYs8lUX2eoajnmt96l6UYIYhU7SKuEbMjaxStn4fSbcYcJj44qE=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 3 May
 2022 20:51:27 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::7a) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: enable gmc v11 for GC 11.0.1
Date: Tue, 3 May 2022 16:50:59 -0400
Message-ID: <20220503205112.1285958-5-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a9e193b-916f-4da6-6775-08da2d46b147
X-MS-TrafficTypeDiagnostic: DM6PR12MB3516:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB351686A61C1D2FD886E6C62EF7C09@DM6PR12MB3516.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iw3UxdH6agCnR7f2TGZ/lonYNwxfoVpVh0/I5zPjTJfrN7C6NxghpDZOLMcq/6rISUDA4JcYuTS6yFQmr9hilHr/cdCXuEfuTXJbvdnp7ykCIitjtHYIfjwRDw8QNqrOShprKaSNYYVVTnTlG7Ej3XuZlPvV7IY6lWQ4jyq5cLosr3Cpk48IC79OiWNS3IJbJ+PEQIT5nJ/H12ymfcwIC8bQB0MdX35QNp13wHRGwNzgJc9G+cfYeFXvsIlTjv1ZqyObS4nq4WTu7uh7Dkf3AoGLQ3mIbCH5/YWrOk4iEey3t3QHV3wanhK+SSfc169go7SvLhEKhd+I3J4X27Xoy97lQqimQyL+FupW3jzerEXjIebDTyTmZORBU5CF4ZKJk0J+YfHEaMqkg1FJntIklmG8zNq6/HyARM0FZ/4Mpjwi9ZVjFCgrk47rPQlSlaVyGR4tcVf2xTHaOGQvFf2DQoInSF63pHl23CCJ1feA7iiQH5GG9pIlShhRrlgJNtMxJm87QbEikVNqAirQqawvqs887Xy6p0WcD93HOsfhd03Vy9Ji/IJ90DmKy9NIyHGZg6hKtVjPjcfdrr8S+iXjminbaAeO2Cam7GLPlaVggflYiXRyA6w4dvfA4RbAKwVftBwUk25XZ1tixC32khkSWuwpgQlPWuWGV68w22go6twwelvnnS/3Mmi6ys769dgCiMfXLL2Hcg/qJnxYaH5ZFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(356005)(4326008)(81166007)(70206006)(70586007)(8676002)(6916009)(54906003)(36860700001)(316002)(82310400005)(7696005)(26005)(6666004)(40460700003)(5660300002)(336012)(508600001)(47076005)(1076003)(86362001)(186003)(426003)(83380400001)(16526019)(4744005)(2906002)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:27.0460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9e193b-916f-4da6-6775-08da2d46b147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
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
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Enable gmc (graphic memory controller) v11 for GC 11.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8f5c203c3c87..90895b1af5c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1524,6 +1524,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
-- 
2.35.1

