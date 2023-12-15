Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C8DC41535
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 22:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2A210EA95;
	Fri, 15 Dec 2023 22:01:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198D010E036
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 22:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx4+hpL3OsLXCs7Ba7qU0sULBhbG1wsfHmSaOvWcxivGimStG3EFPEq5zdVXv4Y4gbPpfIB7aA7VaalAJS51XZui70ujOeqwZkZmmEAC6c9YZ8+6pbO6dr7F8weLWtbB5gYOolrlNulYl/LI86Y3gdOZAwXu5LodoqrSPUYuRhr1mQK8Jj09vthTpCT+6IjpO+1nWSmvC854iDj1Afs1oO8xMjjN9mw6Oysikr5pbiLvp9n1+mn6BuKOGbyATpr+Sgywm9k4myAWzTCYArWPCO7x0fd42QRERJ6ckrjLARXfukTRpTYQfywS2Vfp6Rd+yUV8fpqZunvLLt0UZEfayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYgYtcw+RAVB5xqkXfv9YuhzJgb6zfqZvK1Eq8toPO0=;
 b=RN/4NDISghGqD8h59uYXSfWJJv1FY9ENGEBd/d31Gdq8wveXPKJCFuVbRKARpYluOkYYfACm3Ln4oHVdctQ2yU7H9P5XVW0M3cpm3tKYCMcqBMX313HUGFkuaUdvjgSPiEqU44soYILxsstE6ikyK9LxRCboRUR6ZSXsJJcChnX6qndJfAOmvSrAkvA/HrmELWP9VDDOuhjlrT0g4oXbJ2FHEYAbmbe0vhL1bNl7FS6OruTthn+6SVjGoQuzhh7rTLAMfgb9IsL60QsfYSJEYobkjT+VAt2y3cfWyrH49xnpjBdwWID8y/mTGTUsyjn4EHLkikUX78CX9XCKeCbxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYgYtcw+RAVB5xqkXfv9YuhzJgb6zfqZvK1Eq8toPO0=;
 b=d5tyYFGcwGq36/8qWgWeK49X64WIuQyJKYdTyahOI5OsmR2my9sUStglr7nSsPKs/YDQLMsBfrJCkvYJRosWBt1GB0mLmRiKbs5ZOgfHsex0oIkeJ+VKUaq9QR0txd9qFHprOFZnYbHq0BEjCXR7Bsycjf7XB0OS402Z6JVyW+M=
Received: from DM6PR14CA0046.namprd14.prod.outlook.com (2603:10b6:5:18f::23)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 22:01:30 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::e6) by DM6PR14CA0046.outlook.office365.com
 (2603:10b6:5:18f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 22:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 22:01:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 16:01:27 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] Documentation/amdgpu: Remove a spurious character
Date: Fri, 15 Dec 2023 15:46:00 -0600
Message-ID: <20231215214600.22479-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215214600.22479-1-mario.limonciello@amd.com>
References: <20231215214600.22479-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: e7948205-a8c1-4693-80e8-08dbfdb9649e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12re2enzCLcQ2qEwLVqaIOHjBHiEZv6dpDcod1Ga8nQnzTkWhyE+urdCWllGcrcQUjEP9cDtxBbactUco6l7sX8zbYIdiNPVIX/GGCOtEekInVgerz0rI/qGtrLuV3QAb0dOIc2pyHE1g1YH1S5eQBEpHviMUEFVFf73cRwZgXrGad9aptlWA0Cdfe7SIlf5JYoKiaO0JEuHjIBv1L3AryINkDNlAO1KnzYWqJQ1c07HdkF91a6WoXXzJwNZyWZq+Y5KDXZuimdlq68xJamR+mFhf59uCvlc010uJQDv4xxpIEIS0iPnLVs70YsrDqDvT47SxwZQ+4X5yWvADMjQUXH953xPkJgs1q68Ihto7NfdqLBHiDP25aOETk06Oi5Q4GPMovb8S2aWBHNzHmld2jOz9ixeBL2+Z9izCjgz0HpH4B+d1JXbB6PkLk9TirRMCGlwWoTH3OoTTXG3oxxKQGPXtv/xEMpnBh3IZrcQyoxSi3AGSecMUGTBB/6LVLZY/uKuwc+xEvAFLAtfcWyTnyJDrrb6DT0WCLWkgj9HjsJ8LP4zS9j6YJCvyIuB+emozq6h6p8xEya8XGm5WY51MaGB5UOwbM+uXytUxMHPB6RFFVuPF3oLumogkTGJ0fgGCKlF69M9zR8oNFgSdqbogoJl6WNY5f5iw2/L2ON2CEGArXMo/FvuuTl/mwyI7BP75hYxjgsTOl1g8e75s6UHcJGRR+2nY2kgJfRZkuFfmSFJoLWCXbrC6WrtQRHWJgLbttcLKXqs7ycDtSMUyWgh7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(47076005)(82740400003)(356005)(36860700001)(70206006)(41300700001)(8676002)(6666004)(40480700001)(426003)(83380400001)(2906002)(336012)(8936002)(44832011)(6916009)(4326008)(40460700003)(5660300002)(70586007)(81166007)(316002)(86362001)(16526019)(7696005)(478600001)(1076003)(2616005)(36756003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 22:01:30.1162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7948205-a8c1-4693-80e8-08dbfdb9649e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

`/` wasn't meant to be in the Dragon Range line

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index b8ada69919f3..18868abe2a91 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -7,7 +7,7 @@ SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
 Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
 Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP / Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
 Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
-Ryzen 7x45 series (FL1), / Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
+Ryzen 7x45 series (FL1), Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
 Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
 Ryzen 7x40 series, Phoenix, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
 Ryzen 8x40 series, Hawk Point, 3.1.4, 11.0.1 / 11.0.4, 4.0.2, 6.0.1, 13.0.4 / 13.0.11
-- 
2.34.1

