Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB03C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B3C10E577;
	Wed,  9 Nov 2022 06:15:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A8010E575
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:15:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4LsAzz9WY3pIRL95mi7oybl2c7WjtWXc9QNtxfC0Mz8PC8F0c1tlACfVFR6Wjs2AT/VWvBj+DO1ewe9Ix7470sfpGfQ0egrXesMwCx2yg6KPupKY3oSNAI/Z7fho2j2UaeHa+uqYhhRK3A/wUai2XkGWzevtUOCWrlx9EBTs3ish2MBY6PPOT7UpQIiI9PwwgGDrs/ekVPj4H8sfIq8CNYhVuzBQEaR2baKmp3rMnxqCCrIJhozv2l/vXHHNl9zkLQ18k7Vb3F6K/sfyOHYH1KPC5pldZOHaxEXDIyR1APy4f/YufvI29/yel64HCcKf29QPGxBdWjXK497155Gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok7073w5qsy2/h27tvLWBSJ/9eujt5Fv5niVl7PguUk=;
 b=eU7hWyBTlfTdOWkGPZXYM4Fd64EVgddJoKJ4b2qhtujgLI2ihmxJuJzKNMAxBtXqGzdUZV+xsNToI6rNPk31vXpmCx/fVfExi5b6RAe/73iUQXQxofloEILy9nXkgFQI2WsYY2dhFEsK6P+dEkQSHHFmqBmeBIivXBSdk6Ov/PMfksCf/OO//jKMhbMF6ZXsmR6/Qz/99NBVCv7zymImIchjxv1XI0gxjnZc3bVqVGOqGHxhK3sHDv8yq7/HQFeSYbPl0yCscqRdjFg7oKrsetjFdo9FSIOb2og8Ggjs0IyMxRbOj5rokP02JjQU2T4VxZRV7f+4+o5BDuKiCV7vOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok7073w5qsy2/h27tvLWBSJ/9eujt5Fv5niVl7PguUk=;
 b=lG0LgdxErUuvBE8IZ1tdg8BtYhS4NA2i/lGaENq6GztfXQLrYat2uc4QhOg/aLoYf4Q9a9h/90RoHtEv8TUs/bcB4gU3KVsATn4RiMaPSCiWnyF4ZO5NwJJYEdz8cQtGfXuLKD2JkHX20ltW0iFhZ5cOgs6tjxKKioLYvQO21Nw=
Received: from BN8PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:ac::38)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 06:15:32 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::b5) by BN8PR07CA0025.outlook.office365.com
 (2603:10b6:408:ac::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:15:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:14:58 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:14:53 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/29] drm/amd/display: fix dpms_off issue when disabling bios
 mode
Date: Wed, 9 Nov 2022 14:12:54 +0800
Message-ID: <20221109061319.2870943-5-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 138ee45b-2527-4e83-355c-08dac219ce1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0VvDGspH8IcwtKFY1Z8Sp/vV4IAjEfe0DztqKiDVOyGn2uOntRwM9ijBoN3cCALn2REzOl0sMtqyTR/rCogE33g8DGvt4cpEAT1Li7wZ9x5cZg9+nFHyW26x5RdhWegpewk4YjHPS5j7LEYDKVGQLk3qz8dIsGEc4zCPXHEv7+1t2jigAgr4IYGWlIEpKYXoO7DFnrara0QmTDRLZ3X721Sjzy59goVschUXKPKogiuT7bjIblP6x9cGH6WQSj8VrZiZUpk3Del5lie91c52aQ2hyETmzuSpcKNPwXkqdITAvQZek8+R5DRDjVEathTYxYxZ2cWvtSxJhCo+b72tFy0e+V8lI4PEk3stkPSXMFNyVFFKNx6QjFbjyOxeBDvqCe41wftenjHV+4RAEyP3ywOor7XPXEmtsdxtI1UT/5K5aQtkJLPEnMdVC17msQwV6h1RiknDzFleMKjwbG4la0k2ZRYA4dHsP9/r7x7MuwjJxuPXALBdMBF2/B/pFCQSCaakAWQpFTnLJNWs70nIBhVg18wHG2Fl8jM4f8h9+lVkN2Y5QYiqG4XlEp9oPXWdX95G7402TorfSAcNlFnxD6Fllzbfcjub3BvsbdkTXS+umV3NnryiGFvoxphKQ0yci0OhMU/LJ0vumbq2Re2m+bPVW+DfI5oynetRnTWAZinnx4bxSSP5ap5/GF3e0pu14nnHzTNUSDAtlFScG/GcbVqmIpxWRn3KL5n4HgAjrbhR+Ev4/o8BUzEw/V5jrrIdEavEpBSkxEfA0p/YPlasRfjYU+D2sB91yzGGwBRX7VlWSolPU5E8CdPUT6BjZaS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(70206006)(4326008)(40480700001)(70586007)(316002)(54906003)(36756003)(82740400003)(5660300002)(6916009)(8676002)(36860700001)(2906002)(7696005)(47076005)(40460700003)(186003)(26005)(1076003)(83380400001)(336012)(8936002)(426003)(478600001)(2616005)(86362001)(81166007)(356005)(41300700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:31.3960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138ee45b-2527-4e83-355c-08dac219ce1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Zhongwei Zhang <Zhongwei.Zhang@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhongwei Zhang <Zhongwei.Zhang@amd.com>

[Why]
disable_vbios_mode_if_required() will set dpms_off to false
during boot when pixel clk dismatches with driver requires.
This will cause extra backlight on and off if OS call 2
times setmode.

[How]
Set dpms_off to true to keep power_off and
let OS control BL by display's powerState.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Zhongwei Zhang <Zhongwei.Zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9c3704c4d7e4..9f42adc234e3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1192,7 +1192,7 @@ static void disable_vbios_mode_if_required(
 
 					if (pix_clk_100hz != requested_pix_clk_100hz) {
 						core_link_disable_stream(pipe);
-						pipe->stream->dpms_off = false;
+						pipe->stream->dpms_off = true;
 					}
 				}
 			}
-- 
2.25.1

