Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B44C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E0810E742;
	Tue,  3 May 2022 20:29:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F71710E742
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln/Pe8bkatgtobA8FA+5UclTBfCuPbD4sq0CItFKkBAuqsbQHGd4dfafGMZ0rA5ThQOuSZ2vuJqaQhY1MDzIYpgSJhp64/KiUjeRa4OGFoj4QB1iaDb25+NPXfOvkCa5mA9fD8JJB4IFtI6CMT2xHG9GHFbPfL4trN2QFHgVasZ7q8/3QucrROAHKrWJTNqE1uGWxJgBNZCqr5TJ9Rd/ubxYdyMa+auDIgI17q85wNbubYZ/Bc662d5OtsryN6YqilSS/lGFaw4sd5Wk3uwNzvoUQ7adnJMNed65YO0n3yo4s745SXSKF3zXEBq5UcjnZGqYwz26RTqG6vUf98oyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9C9v5GVhCBwAsf9S3Bu2d/LUELG1rklH4ippZN7azo=;
 b=mOe/YTndoVA2KFpw+iU5aO1T6dnWKuSlWOl8WSitdFQZ3paVZRemk1xZoHKHdyTbanSPZBrQeOt8A0FGt0502D9u4WWGeczohlrBcEUaFHPDTBvX2GWGalZ07yaD7uR2aNE8X7QQjW1TZ5QYMjvtzGnRcZsYAb5MvfjGpNpsRbykBNwoA1lmffHsHXulLW1i/61sMRpzAtJIQpzHvzqgV/TFQSHrkZyIEtvU02rjAEMtuQvVrFVwUikAoFvgvMZ1yiDsCUCNZXUxzPJGz4dHDKUGsU4JMzdytpQ6W4v9/c7BRZ2eaygWNx6hof0/LvkW3UiRx72JoJcJ9/ibwE3/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9C9v5GVhCBwAsf9S3Bu2d/LUELG1rklH4ippZN7azo=;
 b=eGheNtE4I2WsKonZYMLS57131Cr5ynCLeJEfBmhEM9NkKyx4JuZ6nwaAJWudMg8yUrfv1j2O8xsYjEtih8AXpZYFFqmRWZlDgewOs88C2Je8sMV8gi+MqgQUp0BfQOSRFZf5pNi1jsJJKyTQ/VhWHf5fSoIXd3N1/S1CwsOFYYo=
Received: from DM6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:5:bc::44) by
 BN6PR1201MB0225.namprd12.prod.outlook.com (2603:10b6:405:5a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:29:25 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::92) by DM6PR13CA0031.outlook.office365.com
 (2603:10b6:5:bc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.7 via Frontend
 Transport; Tue, 3 May 2022 20:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add UMC 8.11.0 support
Date: Tue, 3 May 2022 16:28:48 -0400
Message-ID: <20220503202912.1211009-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f2521a7-66c0-4f74-d38e-08da2d439d96
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0225:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0225E9C803D2770978C76868F7C09@BN6PR1201MB0225.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5IaabRFTC816V1DcvinHgrQwrig/wU/YiSA4GDmOOES8u+3yjNpm05izqBxlBBcJn2unC4rFBkRwjO9xwHlmWJ2VuZT2hw9KHdeisAWm62H/TbzCnvGwhqwjznQe+Ccrv571GyxYA2A3Rh3rUuJ4QXvC6AJrafEnrDQdkwMbVi4wdTjMMnIk+Cfy65zidmaeKdyNN2a/7tfYLo/ecdSX1j6L+61ABQWww8EMTm+sGbEeDwPgg37JPtRUqO6Jc3ZXeVqf6PJUHdYD9+m3M0d0U7qYBx2zw/wl6aV+ZG3ueXPgJD46RuGaYlWeW0vbkMZXaFaXyvsy/knldcP20B83Me1O2vFZhuGVobwggtT+3GQo6qDI5p73dH/sOQhVX+/RZTzkfwMkO/UXm9wcef7b0BExChgv+SqS+pJob2I5+zlhFpwqDeLP2Ph9HzQhpSUNX7r0cg24+Zr1/rbWnz2F+x/Cd0Lh+NGYevpHFjvcNjRbMum2aUmNZYyQXJI3tPxvP8YQ69234qCuB+1CW89Hn6SZKKbl/D7tS7hIDVouOvo8tSLmG1nXRhGmMXQoGinMM3g1sGDvDICh9eOIymm+BLH0G5sx3sO0HDbHD/6kbjASg1ONdSYBWBAz/lAylhE0aR7VWYwM7fj+vFsrNQM0JP6Phf7wOa/Y3CulUN+e7thGrhoIAaQw34S5mZWA8BCZNdyNCUGcgegDmRwLxmLjXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(36860700001)(4326008)(8936002)(5660300002)(36756003)(2616005)(70586007)(6666004)(6916009)(8676002)(70206006)(2906002)(508600001)(54906003)(82310400005)(47076005)(40460700003)(26005)(356005)(7696005)(81166007)(336012)(426003)(186003)(4744005)(16526019)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:25.5375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2521a7-66c0-4f74-d38e-08da2d439d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0225
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Add initial support for UMC 8.11.0.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index ab9f8b7e0aa8..2b4241aaf6cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -591,6 +591,7 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[UMC_HWIP][0]) {
 	case IP_VERSION(8, 10, 0):
+	case IP_VERSION(8, 11, 0):
 		break;
 	default:
 		break;
-- 
2.35.1

