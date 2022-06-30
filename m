Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FEEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 18:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBD512A7C9;
	Thu, 30 Jun 2022 18:46:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B26E11B62F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 18:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0Iqx1I4Qkto03JdMCGX7/D/oU2QIhOo1oHVPXeET5UXdGJlXRDY/rGQKo7lL0zKDGwAMSwDwb6ocQHQRTwByQjfNo8TMFaD4h5o4z4gkpUqJob7z70C82xU4eXtVH+7oGyoR76hr0uYhWHXlAsBRbDsiWFbYtcEJ7hQAcUhhw8pJjsw/ou6cRC6QZM2JyhtoZRaLi4jObkqWeQlQn4xvFMUKFETv6iwwyCY2NhsHNXbmtTirIA9yZAzb6npsmP9+x8SzDwU0ndvOpomqUi+HiwgGRt+9HH0FFFwALJ3DpZSY2xC93jhMqJpshGgflJCcYUqV4WA6t4FXI7dgCb5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGRsGDc3vHKEeriSQK+od+Xx4VHQ3om0zkCHXYO6rgo=;
 b=ML6xG1k1gVzlljyF/9PBkdR+fkrz8sEshgtQh+MVR56S8sQTD+SEoUxa1/u2A4RlgA3BzzmvMpDyKqgsxT4BPndXPpYa8DIwUi/2QTXFg4+HA/D3x/RTaBPjxYYg7GDvxZhr5sZ4c2gZX6XkbLT7hDXoNypUun7W/2iZdAYy7tjSHrXXXDNDgyHik3DtxylTgD2IFVab8EMcDjD1jhkKzW2h+HOKaIdsA5rsviCg+7z+POC4/jlnM9J97xdAP7rViUViy3yLmXWuZv+gq59112h8GS2Bi0zAjYA/HRkILoBCekumdsXcpNFNFUw/IX7Z+pNA+ggZlTzY0/8CSNZ7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGRsGDc3vHKEeriSQK+od+Xx4VHQ3om0zkCHXYO6rgo=;
 b=b997RqF+G7+CCPVzSo4jmSEi41B5x1mmgRWQBDBGXlp4AVu/zZ+nwrbezo++lx3QXQjXfYBqwd9bI9v5Dg6pYfO4Dt7mZb8vYKBRO1GRNNdM7BgpbWE9uASODQHiM6p6WYscWVYsdSd82UASaepsdY9JO6StwHoJzoMvsNPkmUs=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 18:46:38 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::b6) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 18:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 18:46:37 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 13:46:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Randy Dunlap <rdunlap@infradead.org>, Leo Li <sunpeng.li@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amd/display: Fix __floatunsidf undefined for 32 bit
 compilation
Date: Thu, 30 Jun 2022 14:46:19 -0400
Message-ID: <20220630184621.874253-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
References: <20220630184621.874253-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 093e448c-da97-49e8-bbb6-08da5ac8dd53
X-MS-TrafficTypeDiagnostic: MN2PR12MB4272:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGe+lrJlUZp422Yz+9s/w/UscHStmuIpE7DcaAaI4Rs/A0RQVVx/vNIPI+DCylqsjaSHc5i0QuZ7XLnIqYHBp1x5q/iDdeXVSJGQRwqSU+xsFsEcQMCiBvgL4wYaEJJxmI98nje8jq78paKFWF7QY5Wonfmo9GySYbLbu/WYzWdk0HYWp5e4qvxoI32jJJT6fAc+mR5wUR2OINVLA/r86ubzLGe9glaWt7xz9IQrl8YboNW2LCbbMXluSYduO9NUGvN2S6cMixsDrOEAWPtpICMa+7x7VII2CuHXevO4WTNzL2CvsdfHg3jcazvRUMazIn8MiINiAb1RfvMQDAddmFTo3KLJlPWS+WSQxSMs/BD0T2v4JzmNn0qXG0DK1N4f/Zp15sOkU43Qwq8CdKQx68UaiISYxFtQxuzJhWBj1v4Bn4SW02zDn3YYZKC1EDqa0vc+wgOmDe+RbSfv/qsUbHZdrvXQL/NmJkSDKNEhLH459ZpdugBWx/OmfbQYSnHhQ8WyaoF6M5qaAPMrZJ8hXeOR47/GjYbn4WEuSTJpwBa6GRy7FaEAJ0Tb4oOVt21++FOWJnbG6PMLfd9h6fc3dQPWf6QAF7VpNn4Vptq8XuDy7h0BlRW8Wo3WsxAVFUSYqKjq/kqcDZgNKZsTdcs/l38ecnimcFV1GqIBeEhsj/FtiTGS8CQTN/n36cskiBojfegMz+lVHQhhUdUn9A4pMw6A7ZepNQKLiNZl3hBGcFNBJKItIveR6HT0iEg5msYu2glDSxXF9es9MlTUPHCVpsdt4ohShps34O89p2rHZ2WDZr7YFqtm2LMw3+Qeyy8J+GopqI++pl+vZ5XAqDS9LAXNgrC/0kaGb6mboNdGKLg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(40470700004)(8936002)(110136005)(316002)(54906003)(36756003)(6666004)(36860700001)(186003)(7696005)(82310400005)(426003)(1076003)(336012)(47076005)(16526019)(6636002)(2616005)(40460700003)(4326008)(8676002)(82740400003)(356005)(5660300002)(81166007)(40480700001)(26005)(83380400001)(2906002)(41300700001)(86362001)(478600001)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:46:37.8932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093e448c-da97-49e8-bbb6-08da5ac8dd53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: Stephen
 Rothwell <sfr@canb.auug.org.au>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When we tried to compile DCN32/321 for 32-bit architecture, we got this
error message:

ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

This was caused because we were trying to assign an unsigned int to a
double value which causes issues for 32-bit architecture. This issue can
be fixed by changing the value type.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Fixes: 9b79abf79c414 ("drm/amd/display: add CLKMGR changes for DCN32/321")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 9ae9439c8f7b..5d2b028e5dad 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -208,7 +208,7 @@ struct wm_table {
 
 struct dummy_pstate_entry {
 	unsigned int dram_speed_mts;
-	unsigned int dummy_pstate_latency_us;
+	double dummy_pstate_latency_us;
 };
 
 struct clk_bw_params {
-- 
2.25.1

