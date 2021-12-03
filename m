Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20ADC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 05:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007C272C55;
	Fri,  3 Dec 2021 05:29:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28EB372C53
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 05:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYrXDHq5yrGxcfp+VzBI4DnDwSGOUW+VpuhhbprnqEN3Tr3zefbmoqrF1TSmKHcLORUr4Xi9FvZ+YXEhBAaUcH8ctlJtQgoGoS056sW9aCjytB0U9Txu8zGnX8rax19e1f4WRwLESM9gYVBlqBVGy6EcodctvTOQpXy6tt5LlNRVexAuJyk7MJa3IJNl22RUfxZ/i8WmTzmmQ4GavbVizUCFjtaXAYH1jQ7vhYTj9bSL0Swmi4PPUEHhtl1p8oruGIQMkBsqnuC0LsioVBmv3xPb2PNdTM01HTfH1fTZQdHQ7Cayh+mFyKn61xEgvsIhOMWknRg+vrBH9i3AKFU1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2M9o06YGbqQdtKZW7brZ+CHDNlG74XDG144tR8AhAE=;
 b=j4Y7Blv0xbUQBSH2pKyYmWgRTTgAbePyATefWqbd7tj6bYOVhb+sFXTBrZxc3i2mGUFlfzXGh6F2xTo+goFaXscOW5dQAV3wrYtB40T5LfmysPMtzVVsfWMmfPQgLI3kftg+kRM6Yvq3kyb0S4Tr5TPD6cE0cE1D5QSBtX4wYkjmRjPamcLHV3X3Vw3u8UG56S745tRlCV1ztzJxvdBg3OzNmy6ZD2dn8E14zhlAOdbnYbh7kv1/ZrvD6X9GXhbvzlTOYp5Fgm3lx13wWKHW8myMjRsxk66ipqJOoVXWA80yO0zCLyr0UKoroN4Kz62IoyVhDQplCQouUNq8kjaiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2M9o06YGbqQdtKZW7brZ+CHDNlG74XDG144tR8AhAE=;
 b=zShKz57ga0ASdpKt9eBbphOhkKXP4b5emSxQjGqDdlg53xiqKqpVzASfYLHGGhqa0E93FINO8Enm6+cMBlIJghSPFAwPu/0GcY12gkRXHRxdTZPMaHywCpJb/WUeHojeCyYaxVAnAvfjhzV3Dy57hsKvRophBYtxO9Q/bBU0zVY=
Received: from DM5PR04CA0035.namprd04.prod.outlook.com (2603:10b6:3:12b::21)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 05:29:42 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::34) by DM5PR04CA0035.outlook.office365.com
 (2603:10b6:3:12b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 05:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 05:29:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 23:29:41 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 2 Dec 2021 23:29:40 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <tao.zhou1@amd.com>, <candice.li@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: only skip get ecc info for aldebaran
Date: Fri, 3 Dec 2021 13:29:38 +0800
Message-ID: <20211203052938.7448-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef735a6e-3124-4c75-4766-08d9b61de8c4
X-MS-TrafficTypeDiagnostic: SA0PR12MB4496:
X-Microsoft-Antispam-PRVS: <SA0PR12MB449660F8809783DB61723F0E9A6A9@SA0PR12MB4496.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ud2ZuCbfXH9wyMIi+rAAnrQp0djvIn5Usbtr5y8BasP53rOxW6b7JjW1qyLPZM2iu9x+6sig9uzYT60AWRjig7M/zzq8Dda/r1Dd2wyABdJhOjefmkBZje/0qv1dR1r5saOcdVc2KzxKG5z31cUgPVZcPivwa2zBLZsG/4jruNYMnY0+2akcXshzjsWVSdylfIPAv17APYsS0dA6LbJkYob9RdOwiHShIla9LGP8U4wimKaadDrIQM4xUk+RCap8xMPQ80jwOkkCT1zGZwVP2eZu9IhBeyScHqnSaZiICXkYy7YSYvtaePopPF36GHNXDRJ1RDUIDmSrTO1FGR9IOvkzeC7+/a+XJZJXaEpS7QJTOZfqrPo9pYIb6NyIVFVuAZdoUJjxj2Dd+E/3SRELG4/81LfTFN407q/MWTSs9w7Lj97MP+9ch5exOSDVYeB5E0T5IiiQN5LsrHdR2JdkncI1lJASNOZkIy7krnFRLzUm1zuF8KgybV1+e9Umfp7GO9PDc9Na46gx23CR9xbslU1x0JnKE34X2V96OWwHbMKDXm5ymLOveKj9tgx57bYX8bCYwy2MBt8DZ0WCh+HzQutD1wu3PbS9pPIgBXC/NCVlgmU23wUHfximcX5tFtpmxQpeYSUKCBTX38yHcyAIfdZWwqluCmFYHDjHkNlbvA8uFHW3tfmiDlaJ1YC1svc/eyV0K3LnMJ1zruFmD9ecBE1st7DHXeXNVqbPqXkH6MWNlwG4G0q/DJSEbxZn5hLSpDIGxguCVA/AZrxDUGobqJ2QrBm+Y2b1YwZ7mOGFdbA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(81166007)(7696005)(6636002)(508600001)(36860700001)(26005)(2906002)(47076005)(40460700001)(4744005)(83380400001)(2616005)(86362001)(356005)(186003)(82310400004)(8936002)(336012)(8676002)(1076003)(4326008)(70586007)(36756003)(110136005)(316002)(70206006)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 05:29:42.4182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef735a6e-3124-4c75-4766-08d9b61de8c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip get ecc info for aldebarn through check ip version
do not affect other asic type

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 641f9b447997..7c18732f68a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -896,7 +896,8 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
 	int ret = 0;
 
 	/* skip get ecc info during gpu recovery */
-	if (atomic_read(&ras->in_recovery) == 1)
+	if (atomic_read(&ras->in_recovery) == 1 &&
+		adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2))
 		return;
 
 	/*
-- 
2.17.1

