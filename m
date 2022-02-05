Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A108BC433FE
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5A510EA8B;
	Sat,  5 Feb 2022 04:33:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E5610EA75
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noc8XJXzp9i+eejJ5G+Vf8rgpNeXuhy7YWDsjxyaIa2qnK/Wezm1EwdXe7PES7VGDT+fyzdyidFPNbsz5vvVt/FzQjlmsDyPXsbgmQr8F6/cft0wnTijF0+OapC+kBgKKffZp8Jul9Y2t2HvW5lZbtOwIjBP99I8NCtNEd+bYwClLwzKJvN8PmHAnSkxBXzyHpRO9v3ev+e5wqoshGzgJZtPhbclmWHiKjlBEMDdPk0rDE1sQlZR1DMGibHNr4Xdpxg0ieyEXI89LlcC/iVfeoTVwcA/ev7PpZmqEsRNyvFEzhZSjDw3yJjnNNPDqgQ+pOo8jvnYD9AZQ+U8dTkHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmGuRFFrXq1D81Qky/IkdkDWKHBJ4+Q1Xql9ZzZCwLE=;
 b=l6zio3HmWHnDt7pLuJvRBplptlr1q/TudbTQd3UhZt3dCC8kMuLtAFETBqz6SQ74ba1WaRWAJkkc4m3HST5qTL9d5uE89gR91A5r/s4Ma6M8/vB4rkoeP9s1H/Deha047tiLX5K1obCLqYrqVUhuv5z4AhgTizuvP4dboaRKiCRmT3eNHH5JkoFxs4V2fC0UWyQ1u0u90TuMss8AfYwPydiowkO4Ye70n/zD7OqIBIIOAdr+P/zDEfzBys2Xe+Ai7+8Y1DpHnYoze197Hv5UZTgo6zcWeCfKfqPf14XQvhMQZrTNd0UgU9iozlK+8GnovKqh3FVLkbHw0fXvB+6VYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmGuRFFrXq1D81Qky/IkdkDWKHBJ4+Q1Xql9ZzZCwLE=;
 b=b4fLa83UHpIjgMJfpy6JaHpym67cGSkXT5Om6brAuZGVkpXzl4JcltPHDVc7/eD0cMP3Pct5NZ19xQba6kI2Jej/zt2zoAfpwp2WZQUDj4uKSD5BcBeQjm/61KI5mkRcIcUdv8RzeKsV/xeBepd7FYbfepoycPAm/MHPUA+AcLs=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 04:33:27 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::6e) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.9 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:27 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:25 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amd/display: remove static from optc31_set_drr
Date: Fri, 4 Feb 2022 23:33:01 -0500
Message-ID: <20220205043310.165991-5-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed37ee0d-f8bc-4572-61d6-08d9e860a774
X-MS-TrafficTypeDiagnostic: DM6PR12MB4450:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4450963CE3330E040B3A0407FB2A9@DM6PR12MB4450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3m02HrsD2lg9syd/iQt6vXgfx2rjxZRfJLXRnrqRvBpel/z8xQukybKN6luUSJSmY+byjEjnkfPRO5ho9nGUyhdu4zY8V3RMMUSFBO4VYfJL9y0mFCUdDrOskYXPp+AeavY9aS+TKEK/Jy+rhC2UEbEOXZYgFRviMG2UTmnRvCuOAiqxfSPgHQZ5Da4KZJHmzgPh+w9Kzme+mKfgAKAJUf37nstNPoDrBn154fQvj34zxV0XEm3B+KYQ1QhrakEf+pk1OCvwWZ97XuleO0aVKAUSF9WqPc0TkslR6k8eHq4qUb4e/ysJ3eWdI1EVTRTC7PGz0VwdB4auoodgLXA5dAPHho8AocNRVHPUZFOhaG9qz9JZK9uqJGDSJ+d+YQIOpqUAKFwXyNR2DryHERSomZOcqDZ4KP/DwIpu4fPgCyEd3qCaj2rj4U6Sjr6pkPYZb+XvpNhfO1cdjJSbKPmfs9JPdphx1ucU1ThVaBF2RBFbQFCLRWVN8sIyfeMdwV1RXG7KdT7CNLAtIBg+RjeeGHinUe2XC2n1THeGbx2dKZsTmKNsr9YjrKyuYVbtVO0rlzlhffSYwyFMfrf6pEhu3qHb74QO6Y2s0pQh/K/iNy9ZyCVvTRldIo0kMdnK2sak0oC1VyBTxuFEV0AqwByamVhxnSuUmP4mdLMqK4dxiV1G/hKshdgeRdyB3aOv3ArV9Mm7ZVk9CeZWpCopsjY4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(356005)(2906002)(81166007)(40460700003)(83380400001)(8676002)(8936002)(36860700001)(47076005)(4326008)(5660300002)(36756003)(82310400004)(426003)(26005)(70206006)(2616005)(1076003)(16526019)(316002)(186003)(336012)(70586007)(6916009)(54906003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:27.1531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed37ee0d-f8bc-4572-61d6-08d9e860a774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

remove static from optc31_set_drr

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index e8562fa11366..8afe2130d7c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -161,7 +161,7 @@ static bool optc31_immediate_disable_crtc(struct timing_generator *optc)
 	return true;
 }
 
-static void optc31_set_drr(
+void optc31_set_drr(
 	struct timing_generator *optc,
 	const struct drr_params *params)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
index d8ef2f0d0c95..a37b16040c1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
@@ -256,4 +256,6 @@
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
+void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
+
 #endif /* __DC_OPTC_DCN31_H__ */
-- 
2.25.1

