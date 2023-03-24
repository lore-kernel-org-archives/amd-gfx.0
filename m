Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0E8C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 22:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35AE10ECA8;
	Fri, 24 Mar 2023 22:00:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF1710E295
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 22:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kocr5yh06DLuU1iglI/OY+I0Gl/LP+//2PONFaNVmgtBi8BfUxy1k8hVl54IiM+Hlg26hQ3wxjUJmv7edufjziSR0XBiDj9DNKFLpUZyB2r5sE2Eem7Q8ZFBf299hZ3Q1iDLQCssQuWwD4wXbiRhrMEP9jLJwr9k7HyU9eGl6r5YoDs7P5O0P3m/jVPpoSCJe+inKBFW73/jCFcgFEIQbeanlBr33AmTR+fOPiO2qztcO3jk6B5Y87hmwerybpzHx2C9yfM21kp/9YSnACRaSvybElaF3ecMxvaNBacdmUs78KeOn4zTVqbxORjAdGIcyQ4oiEFftj/usVW+PUrzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az3Zgaa6vTlNBa4pLSdo51Uwjs63Mn6eOhoOPOtBje4=;
 b=MD4qKhXg4R7KdpZI+toDaN4s8UKInTWIAUIWzVpiuVMuDi/EUaghK7HqSNCOHMmuC8lYl6nDtClkZFcRvgllK8WysiBTChRttBtyD/9soNr8nzNo3KBW+WTYRKpF1EToVV6zHMpWLW4EoeBc3aaC+r3BucivoeENhBB1NrZ8g1umBafuINaLvOybnfxO+96Ej8cakX1LGwByVXqUfhrPepSd510+GznHgPAiZQ/lMGhk6Aig14wmvCFedMEAU84QOA6Ohrf85yThaiXe4D4x98SKOtloSaFlb3PLPgRSl/9kRdiW2gLnTau8mIwK6gcPVqf8MtKQEqq6xYDrQNkFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az3Zgaa6vTlNBa4pLSdo51Uwjs63Mn6eOhoOPOtBje4=;
 b=jXqwmVpkcq5+ngeQRxdDUWHr3c4sqKNLC1ttQ1SXkLCwGUTUgfpYdr478ZAUGKQT16q4oRTXtA2su6rZ/tgflYeSOdlDRnsATQJaUF8O7BLjHGAdiv9ZMFw5IJClIl1cyhu2VZAvGAJTumw7QB+dY81IYCQyHlzxSSht5SCLXjc=
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 22:00:10 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::78) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 22:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Fri, 24 Mar 2023 22:00:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 17:00:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amdgpu: add GMC ip block for GC 9.4.3
Date: Fri, 24 Mar 2023 17:59:49 -0400
Message-ID: <20230324215949.2560463-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324215949.2560463-1-alexander.deucher@amd.com>
References: <20230324215949.2560463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c724e3f-928c-43e8-ffe8-08db2cb32353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvaqeKQr0tTVwwwrqicY/oMXVA8qfWyuALMm82FhEOdCNknT3+tDjz2nXNlEzVIUAjBsX33Emi9DdB6rRtxjucNi4I0P6V4slkuSWwvusJe1O80tArmVSaw87hKpt8+4qs1hF2i5l/UwhdGWNRPfmN1ePHYQw45NL0B0cGO3sNzhNngsW26pP7Is7aSsgTGOuTVQqwhyFlZL8fXxLTByqz2TLe240lgt9NiccB4Bs3mulF0xNWEaoZGZ6cy4HYX6ROsqM0IvXxdjLcG4iYUtabwrau72YH0TVKQqiO2zWlVJe0t0hUSx4N29GdNX8W0n9uslDmUwnpdxE8F9vJxlOPvVssLVierHrJNujJyAfGOKBYentXxo/XcgXV0AHRTI1dxD/TOs5TT2dWefYXgToRnKjKta1ELu8t8FS/volEXH8/2P5DB2fuzUvW7yWp5rci9648cCQFMROy3rBWzz1tvNC9KoWuVE3ScHtt/3MsDOrBYs490vL5gfR+kulI0vcbvxIaytgHbg4X6nW6sNrxBWBy1nlf3zGIc5JfzKaHQ7iJdyGWwgR0+k8qB52grIrvu9f8wljjp0k1R2G9KE83lYMbjQ8FO9RFPCOe1H3sS78kU27UeYm9M1CkigtZ+ZqH+cX1PleBWa0tTDk5M9VHaJF5q4yXAoZ3rhiyZ/N3AWtquhIRrdYX4rF4jUOFAwNo1nh1eXMa9slaRWXdXHMm59Wao+mRICBR+gVBIUc9Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(2906002)(83380400001)(8936002)(26005)(426003)(47076005)(316002)(6666004)(7696005)(16526019)(186003)(86362001)(336012)(40460700003)(82310400005)(36756003)(2616005)(8676002)(5660300002)(6916009)(4326008)(36860700001)(356005)(40480700001)(70586007)(81166007)(82740400003)(41300700001)(1076003)(4744005)(70206006)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:00:10.5126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c724e3f-928c-43e8-ffe8-08db2cb32353
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add GMC IP handling for GC 9.4.3

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eeb8636af3c7..5139334925ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1547,6 +1547,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(9, 4, 3):
 		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
-- 
2.39.2

