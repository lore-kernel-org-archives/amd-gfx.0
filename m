Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C722AC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 07:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3988D10E02F;
	Thu,  2 Feb 2023 07:51:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E540110E02F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 07:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjQ6OrRbiRd5zIpnB5wAJrq2eRl5FprQn2DiuXUPofjRzRmusb/fWAB9ecGRxhvNg7HZ3BU6k86k/XrG5fJjPKUI2jVFHWzLMPWEOcqvLOOYS61kvivt/Th7bnwQ2su+278rrOcahSc/F66oDqqQtfvdoEJ4v5xKrtWTRYninr/Pv3jQ1ZzL9ErMK7t3pINwEGLFWlKslNV690zpU6WPsNW3mMhlZ+y811TcA7xVH+S8oCT7tz2a3XawbxbI7mWbyVWwMcMRiW4G9P5hEYMjyYh8j3G1vjQdrmsL0XFTkMdMjIXft4UDiKuOxzuxPWiJGw4dTkK6HRCDPLNiCaZYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7gSIoR0nMuuMbnKQcw2pfpv6lWPyIj12OveNPtgbu0=;
 b=H2l5nIYjRijKGBt4siGHdZ3BQFl38wKQuEQg0Rh2VWpbp0RbhVkZG6QlMQBg2vq6gcYRW4Ww8TKqBJr40j8oWvNohhqgUSIHvm1u5WuEcY63LTa1ng1CymkuqzBHxycjD0vZBD4MUhBwBHWXhU9yzIAgIx0uPvNYlqr1qlay8nga5hkWhzF/n/PnBoQflM4DjvO9Jgrv7Xv8a0UU2xKS34ORP2lQb4SEsQqAj43o/I5aIYxkzkpg9ftRtdK2cxFLypqsnXTei/snlpz5Cd1V7Qlefk7Okqu2MHRyxxcdlbr7bjyQfv/O4TdNa2noAUpH8gCbGJA7U8rTkHEFpdJnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7gSIoR0nMuuMbnKQcw2pfpv6lWPyIj12OveNPtgbu0=;
 b=FmI5ViOSN2dQxgEBIUSV9D8MtRfjZ9zSTG20e6cYRzNwb38iM/oj7kQCuIjBQbI9FFaSxdkcTUGlCn/7MGeAXHQbLz5y3AWtxaD9oeXrjr3xpJwEdFMrOgp5G1gP95Hw7RWYIn/NRTV5zIV+zDYz/sHvhl1qlLyphlRAzozsOxs=
Received: from CY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:930:1e::9)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:51:35 +0000
Received: from CY4PEPF0000C985.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::62) by CY5PR04CA0015.outlook.office365.com
 (2603:10b6:930:1e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28 via Frontend
 Transport; Thu, 2 Feb 2023 07:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C985.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 07:51:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 01:51:34 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 01:51:13 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Thu, 2 Feb 2023 01:51:13 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: enable athub cg on gc 11.0.3
Date: Thu, 2 Feb 2023 15:51:06 +0800
Message-ID: <20230202075106.2274628-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C985:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df5aba0-da61-4815-74e4-08db04f24ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGcku7QJgOjPrFj22z2wyvxw8ZtrEaxGGGGIjKy4sypFrryinxDiY20wC2v4sMQQtT4tuqyerT72BVeAly9j6+FdsS42zqRpCEmRpD/BB5wkJ6QrOXjp7eKscXFtJ3f6tQjl9XgV85YHfObUYZe0C39Ulra4rGJNGssVIDBpPEpqjZPMHPk3kvyAn8dPNHcRkcj6lrbWqlGiw1XWbKljh44bK2c3EaO2xNEv2qQj4dCSFH+ZOC1vWkmG3AvETK2G7NTe9uD5nh+W7xgwo0ZQmC30JuC/3/wvyVefp6AecpFhWPACforNCvSFZ54N5NEUeycWZtMyQX2PuKkRYg/NdfBKwICTSLKZdl3QUdgVbzI65t/ksHa4jVX0h2Gva9sy1r7MUPzt2MEwPSScXPSZYyRxNGn97wGeSAGAOiimiIQF/FJiRH58RH9pCQ8KAe4ir5gKR5TfAb6PERFMdt3eZU1Q3o5kcZdJ0zL7rTwGh037wI5MOEtyNly36P5efgdiY3AZHLecXIZiZa4zJDReKoORCxxBkqef4vwZybAKC4aIYA6E8IAJ1sKIj2t37LgflABv9v7vG287H59AEyEFI/7Q5964SvUjs2Yb8EZazUziYbUIk2rqVlBHHSpdb+q5UD4MgpwnOxdTzKfREjeEE7vW3iGKS1ssnjRLbyhyHR3hkZTpd88ARSW38R2s0eQfClsC+/9M+O6c+j9BcKaoCnHg6XCGyTMCMYUohADaQpE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(356005)(81166007)(40480700001)(47076005)(426003)(83380400001)(336012)(2616005)(82740400003)(36860700001)(40460700003)(6916009)(70586007)(70206006)(44832011)(4326008)(8676002)(4744005)(86362001)(5660300002)(2906002)(41300700001)(8936002)(7696005)(478600001)(6666004)(82310400005)(1076003)(316002)(186003)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:51:35.2647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df5aba0-da61-4815-74e4-08db04f24ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C985.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable athub cg on gc 11.0.3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 2ea0b9142868..0615fdbf0a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -677,7 +677,9 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
-			AMD_CG_SUPPORT_GFX_MGCG;
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-- 
2.25.1

