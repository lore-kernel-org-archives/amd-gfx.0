Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4C5C001DF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 22:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BB210E38B;
	Mon,  7 Aug 2023 22:06:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4FA10E38A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 22:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjxbAXGCmVXKoJhoJpR0FjwTmAlraSu0kQCPrswDYRQFQEhQeVmtcfFmBGeNYXGFDo2EQDDZWbPNl9bLgLMVyXVzUUvk2+9KlXyvXXHdZUpncH6XWn3eAtsf6BZYaD2kBEKhFItDPdafAmN8sodVqJOqTRputTVH2+R+2mpyfE3Oh624aFt/5HPhN5BpN6zo44vPGyeLCFHADEAAZszxFjQ4QQqmOtqH6zv9WCTKqHs8Bh77IWLrINQ8i4rB/kS/kZmUqbKXMXWctVsu1NkYXX/0mLW0Q6fGbPMGnmc078zOV2dm9LPGlrjAemlWgloUARfkk1ma2h2hr1e7cEoAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXBQKzrqSyi3fZI/TzaOdRuVBx/9oyi6crM+WiazmPs=;
 b=W0L+IXIioZSsplc+f9QmJguIwj9UZElwbM1/u2J2pRFIx2hkn1Br0MVi/PyxzQt5uZj79QBT53woB1LJdjohoUxmcphCaoFcWOssySjFb2DgAvQXrtrKOVGpjb6PZh+Bq0e5PWaKquQDvSDJrzuUgeg2TACE9uVKBS+zQCtqN1vf2INeqO+/hn/Y4rUsS8zWTflwKEhORaBPXxrL+RT2kpOz0Qp+G/6BUKjqVy674BD1oz/px62LDs2wEs5ACkq7W7hlGuiIhTkTRZoKsDwTNuy7sRFMn+ZsXBJcX7C7UUuRRfBmZ/iOmde5T/fuk2UeL4vYiE/AiDsbHfa0qskNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXBQKzrqSyi3fZI/TzaOdRuVBx/9oyi6crM+WiazmPs=;
 b=uqmYX5NEs0xRLBvSLV5WxvTKl48ntpsJWO/7FsRgX+FkGzBMqfeg+zbW9BEFaF2GjMh5F8yJaUb5pFFh9iLBiR8rjfIAlgC687+3nsnnD2c2f+9aaxfLKtOvtPsGA43BcuGhzroWlI6UxLh5kuTjV7VEncuk+V6JZeF6tClG6Og=
Received: from CY5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:930:10::17)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 22:05:57 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::c5) by CY5PR16CA0025.outlook.office365.com
 (2603:10b6:930:10::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Mon, 7 Aug 2023 22:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Mon, 7 Aug 2023 22:05:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 17:05:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/5] drm/amdkfd: ignore crat by default
Date: Mon, 7 Aug 2023 18:05:41 -0400
Message-ID: <20230807220545.1320198-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 2790e52a-c164-4cba-ba1b-08db97927a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mla9y0mM0sdVBPXga79sYW3LnsNHdtRLO9cvhu8pyNedyNM5LneacIQ2X9YzOyoy+gX+Wfd1y1PRue1t8HaRrIrZNT4mHluqt5JYzGPvBL1w0MrA42qVr9Kac1168OmgdvZol3KFFx27XastQ6HDNBG8tWZMG1JLhGLS7gHBdIRTpy3Lq1kHW4Aw+WfmSlrRPiVHQ1g2bvmyhf13W3j+bRrq7kI5Uf1OnlklI9vlt6Svl5yIHvLKiRdgYxFzkVoStM/brxx3zrLm+yJcYD4b5ZQDPpZUUh2CNxvx1G+1heDGQNJ3r94nSiACM2ueBAnKQnHKtBKmNcChX37kVWKJHTMXvnTpUYQbM8awfLesWZrXP8tEeQYOJb56QBbK8+DCGi3GfLniqWVWWYGGgtwOa4R15PF+yYTzZrosCECu9om6zo8h/YF4pZfBz88xHtxDxqya/K3bI8uHFsevzVQbs7XOBfvYjKxq/j7h+yRzBJlqz4DrIr4AXItoXCSGoqEyg9khCrtmnXVOF0G9EVBu0lb7N3+xZAirbXxSyeX0vtakIgWBeI6PJ32oR7fyQfnfaW9ZjmwwKsHzovjvXDxVmf+2JOQP0yqJFAV4SDvAwhFwPj2/O+una2/SU+ZXIruooNM8a9qAseGoubsWn3odtg4pR1RqaaKgAM8Hkh23aIJOPwKbGE4LsmQHeavhqf8AzYwVsfn9A/6YAjmgKH0YtDLFHQIhPykS2vKMWs9PZ+aqBiO0l8NnuizX9UUdCT5o+EQoFzyTVYQR7MWph4eNvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(186006)(1800799003)(82310400008)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(2906002)(36756003)(4744005)(5660300002)(426003)(2616005)(36860700001)(6666004)(7696005)(70206006)(6916009)(70586007)(356005)(4326008)(82740400003)(81166007)(316002)(40480700001)(41300700001)(86362001)(40460700003)(8936002)(8676002)(26005)(1076003)(16526019)(336012)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:05:57.2431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2790e52a-c164-4cba-ba1b-08db97927a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are dropping the IOMMUv2 path, so no need to enable this.
It's often buggy on consumer platforms anyway.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 49f40d9f16e86..f5a6f562e2a80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1543,11 +1543,7 @@ static bool kfd_ignore_crat(void)
 	if (ignore_crat)
 		return true;
 
-#ifndef KFD_SUPPORT_IOMMU_V2
 	ret = true;
-#else
-	ret = false;
-#endif
 
 	return ret;
 }
-- 
2.41.0

