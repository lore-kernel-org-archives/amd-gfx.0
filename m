Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA6C4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 21:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4708D10E2A9;
	Mon,  5 Dec 2022 21:09:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73DD10E2BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 21:09:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByshhyKp5sUXFc5NEZpFpbNnktcWQfoVG7cbTqTzvzcdX0V4/qVEXSPgUCJIOLf80+jTPpx7RHf+RJeKgZNF2y7ztDqNma9d0FMnlBbjXzaTrYNdAUTRSDYcJS3czbnDtc/1oUCuzLmdNyHg5QrMurPxie0F+sTXR4LXrRcF/cHA8FVTU32p/2oz7P1o2v37/Yy46T0qRN1Q34DVYr3qVtrI+U+mdH/c1IUBBot6/vxtllgtj3aWNOWqN7zYcOsYGqswDnkA52IFPLthfYt+/YzdLENIlcpI3OGmQv1jrzPROAxNM00UmTX39HBeSDj5+4pSPmAM1I1LtPM1CncMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzpXI8/jTvZN0yMHYPkRk60NFsXlt9b/+FfzgmVW3l8=;
 b=TnVg5nAdrJpM0FcIxRK8kVVx+KLJe6Dud21/HRQzjJT8TdgKXPpGqaSBBDNEB/nm+Zyz02tsq2y6sTcpJbyqOxQr3Yfl5EtlCCrsikwb3pEm23Xo1OvRcWZNWUP6QyPzItexw5PsUGuYM/HTE7tPCPVNExrTvXnLgWfcQbue+hldrzw+4h+2aoHEFeCaGCPq5SpoUFk4n7O5q7AsVIlydtJZN/2AZ5c/dYAsqJ0IkA/kAcBDRbAz09AyZ8h6qqnVi2k89vsbSnQ6/l284Rp8djp4YVd3G4xK0dEy7regVi3XMaBVluTi5IN1Gq/Ikqr7mMHPH2M7X5LABSqmG9Y8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzpXI8/jTvZN0yMHYPkRk60NFsXlt9b/+FfzgmVW3l8=;
 b=BXBHUFrlpSh6imk1KmCZmaaAFN8O2ZrMwoQeIH92HP0NRSuBqJ06Y7wk0pfngSc0ic5hNRjDR+XpjMztvn26wWKcj475VGHXovYV1KMRvDwMJejK/0xvM8WZqCn5yWBnGGYdJvrcvfDzb80m6IF0TGFCxbfxXXbW66gFoAcM+5c=
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 21:09:02 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::fc) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 21:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 21:09:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 15:09:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 15:09:00 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 5 Dec 2022 15:08:59 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix array index out of bound error in DCN32
 DML
Date: Mon, 5 Dec 2022 16:08:58 -0500
Message-ID: <20221205210858.3666753-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 919939cf-a65a-47a3-50f8-08dad704ef78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QvkIET8CvuxZydYEBP3A0I2xZ2luFnw2cYpUsTqokuCCdskgAB6upY8ONELR+btOm9vmvOKk5DLL63ZqjqbfUEeOLVozzg3Pr8/9Pp+ctduHUS3qHfIrSHguY4OQkZ4nK0wDihhjXDHihVawesDpx4r4e9WCPAF4vKtMbHxECo8Nsmi7LsKBa5LalfdwS0EuC8CZHd92dfd8TuszbjY7QI4ltG9E8oI+VjFM7JXwcS2dKiQa91R5Sq/wD3oOx7S6Ih7rEs5SzWNCHtospZtmENm1sQ8GCDPqLgplbywZmylp8JvCEweqedfGAuH2g9WRmC4AbVt87H1oVfDQGlqtR+hWuJx7AZGD1Vhe4hKC+7Y9tFAO+GhSpzT4xOxRBYmDWEwoeVbIoRQCYD40ehhbg3KHhimXh9cdcwoJ5oVgMU2i3jzygfEFzIOAkWQSG+QbOb4jEvd6RYV0lVXrs5DbG5WvYydW0Hywpmc9XJKQqtGFUbNATbLfy5u1QNk8u5OaMoPqTEKCe/ZhNjxgaqMTYxpe6AY18IBjvqtahHzw1hmldgtSuKjJqUmnmRsVLXNA2ZlwPhFlPGlbMYubryMUS3hHBosr5DxrM9hj0f5wgv05jVLYy/aXn6N01cGPf1ajzSstOkjtUOfqTBVDQxL/Ocz28boh1GRRMNu00zg7puBEGByi1KF2DYL//SuIIb9CdwRIf59EorQlOwZYgMe7vxfNzboyiqOhopjOTvrTHo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(186003)(336012)(356005)(81166007)(2616005)(82740400003)(1076003)(2906002)(83380400001)(82310400005)(40460700003)(5660300002)(47076005)(426003)(8936002)(36756003)(36860700001)(44832011)(478600001)(40480700001)(86362001)(8676002)(7696005)(70586007)(70206006)(4326008)(26005)(316002)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 21:09:01.7109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 919939cf-a65a-47a3-50f8-08dad704ef78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140
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
Cc: alexdeucher@gmail.com, harry.wentland@amd.com, aurabindo.pillai@amd.com,
 rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
LinkCapacitySupport array is indexed with the number of voltage states and
not the number of max DPPs. Fix the error by changing the array
declaration to use the correct (larger) array size of total number of
voltage states.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index d46aa4817e70..8a67f4d65d82 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -1162,7 +1162,7 @@ struct vba_vars_st {
 	double UrgBurstFactorLumaPre[DC__NUM_DPP__MAX];
 	double UrgBurstFactorChromaPre[DC__NUM_DPP__MAX];
 	bool NotUrgentLatencyHidingPre[DC__NUM_DPP__MAX];
-	bool LinkCapacitySupport[DC__NUM_DPP__MAX];
+	bool LinkCapacitySupport[DC__VOLTAGE_STATES];
 	bool VREADY_AT_OR_AFTER_VSYNC[DC__NUM_DPP__MAX];
 	unsigned int MIN_DST_Y_NEXT_START[DC__NUM_DPP__MAX];
 	unsigned int VFrontPorch[DC__NUM_DPP__MAX];
-- 
2.38.1

