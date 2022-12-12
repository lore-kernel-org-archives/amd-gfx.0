Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9171CC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 08:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FF110E16C;
	Mon, 12 Dec 2022 08:44:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2932710E164
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 08:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG/bMCRQsJfRFjveBCXPymNI4wo90tWUIPcMmNXg0KGn+Uj+VEb3V/9YfdE9PNtWgJ0OYq2hLonsk6PebXkqv9tDxSfkC63HMBYmwRLGbwrKMnohZeLJ8MIQzL4bbitsS++P41EyVDGOl0JiSPweUuCaH5iDTTVMbGAE4EeRlFeizN3JskuSpg8vHlqBNiS+sZcX+lRSon/SXnzZUQcyrcmsGV3Qy2t9v+TFg2liSwXhqGPF0WlF+MtylCL0hKDPHlSoRT5v4sVjoJjXe3QOGIVlzvr95VLP5qlFCiSzZHZBqQkqT12YCyjRg+8l4Jj+GWDxYz5/fw5EqaPdOnUa8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgbrfc0r2evRb48rB2OYbaBaSCJhA1Aow5IbaukgVTs=;
 b=SlG/O12dFknG28QKxQZKKutl4eu4pVg8lDFblqRNZOVJmmFv9rBIqY5VIIKBhIxwH8p7MT34sXbteC+sreLXPREJ5JgAaLqPx6ApNq+hp7o68P3K8JzVDhnGxj+zM6hyq9LmeVdAsHx+b2TyQ7ds6YwAV4rH0AJ8aq0PiCTCzf7slXyZI4JWoJWsc2g2yr9kvGj1m3eMF2gRum3blG7SScIG5c9bcZuWK54LlGKOeuEI1jiz4WV6ul5x0yZzRBv85GrH0Fqo7meAKgsPNYb/fqzIA6PsWzVcZIozXu8u8FcFQi5UBZ2K6l7ntRKz12fj46yzd0WO1SHmF8GnBdUQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgbrfc0r2evRb48rB2OYbaBaSCJhA1Aow5IbaukgVTs=;
 b=lYwAItg+of0TqEpp3jA/6G0MjFRZtqaX6DdpuPUn6wfD2lipQsL7MMwyBsnNH8ypb8bWWwDNGvFSa46W92o5qbE/f0YaCU+eonYbGC6hzdVXpnF8URdRi5hwJJmh/4JcZJIbyYBMvaPii3n6mhfboTP8Ur3yq0XI3NcIFbuZvMA=
Received: from DS7PR03CA0232.namprd03.prod.outlook.com (2603:10b6:5:3ba::27)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 08:44:47 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:5:3ba:cafe::8e) by DS7PR03CA0232.outlook.office365.com
 (2603:10b6:5:3ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 08:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.8 via Frontend Transport; Mon, 12 Dec 2022 08:44:47 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 02:44:46 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: add missing SMU13.0.7 mm_dpm feature mapping
Date: Mon, 12 Dec 2022 16:44:22 +0800
Message-ID: <20221212084422.3850479-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212084422.3850479-1-evan.quan@amd.com>
References: <20221212084422.3850479-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bc158c-d30d-4610-5374-08dadc1d202c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w35nO/7UCcrcEdTeiGciNrTwuyfV41me2jP5vguYuHDQKBNRejNi3fWOMHW8SKHpPGgMS4nXvfZl0EdwarWv8o15Q2DUP1h+W0n4u8KmZbaUSrOwR83jPL7fhrAodBNv2aayep5sbDbbRdOgtzzqWZjir6X+BBZ1Y/eMonfIRhOmTGQhdfEwF5spHalE9B6F2EeOHuWJkd/8qXCbusTpAtvjJ4D4DbmvRfaxhNZU8OSm2o0rR4bBok0JldXDZzJwQo6o4bHHvt9EuetEsrJgZaIV4QOsCvybT799Xb1YPrXPlQ64pp7b09wzfch7sviNU2N5fymJbx5vIJEK+NeOphMXBgjx2IJ7fTBfMsJfDU4DDgNK/37Ih1FjGYSh7V+DDN8hWCFnJRXmB91CPpLADHm76Yo/jwJ9BOJoepAQJcW29NEhJGIRURINX1Tq3qdAUNU/kCqW27XVDHO8uOJxvUs02NajBqb42jyLsFuOW7fp97epiRCI6MiMZfU1ULyqrfZ6UzmqMcZNzYLSBc6TbBjbn0/cExyxcEq1Ssx0s9624+VUxaW2DMyRdOIdmJ/RVL2GZKsxxJ9RrH4qPdzFX1PPizKd/RhjMf0X1K4LyA4wNzZr1zTyaTqRYb6MdiVogrkkxphakmFDeJ+3jFdo6JZB06V2oN0Yf6m3hffr/zUTgPyjnb/IXEjjSSW0WNGJFwh64rfj9JM9rqkx6YaQnna+uZ5Fr+E0WbOWjeDVepg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(86362001)(81166007)(356005)(16526019)(36860700001)(2616005)(1076003)(478600001)(47076005)(7696005)(6666004)(26005)(186003)(426003)(336012)(41300700001)(54906003)(70586007)(70206006)(4326008)(316002)(6916009)(4744005)(44832011)(8936002)(8676002)(82740400003)(2906002)(5660300002)(40480700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 08:44:47.7503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bc158c-d30d-4610-5374-08dadc1d202c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without this, the pp_dpm_vclk and pp_dpm_dclk outputs are not with
correct data.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Idef7d0b1778fc4b900945c9f221787b4fa5b730a
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 81036d57b598..5e937e4efb51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -190,6 +190,8 @@ static struct cmn2asic_mapping smu_v13_0_7_feature_mask_map[SMU_FEATURE_COUNT] =
 	FEA_MAP(MEM_TEMP_READ),
 	FEA_MAP(ATHUB_MMHUB_PG),
 	FEA_MAP(SOC_PCC),
+	[SMU_FEATURE_DPM_VCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
+	[SMU_FEATURE_DPM_DCLK_BIT] = {1, FEATURE_MM_DPM_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_table_map[SMU_TABLE_COUNT] = {
-- 
2.34.1

