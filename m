Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED80C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070BD10EB4B;
	Fri, 11 Feb 2022 21:52:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C59DE10EB4B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L38SlRoarBso/rAyJWq6NPYqUyQhML6DtnW7mLDmAlTb7DvX/qh4ItjWVIVCS11tSiOYu0m+bNmoPf8M3Uv70Pa2Vhp36Lf8Ns/T7yqIuUE98nrgL+Atn/a8jsTq4JKjfUCLFpD4V7g88+xY48BuEucuh3rpL5AWlxkmNkcmV8Kgrka2eq4rwRuyOhdkHR6IFaJx/yVFgU/lxpJwMnyCtnya8f2SboU5xQIl6+IC+K0BdF3vP/FXm3+l74QAea3Objrm7LUmDYlSnLUp6GwXEUMKNjun2+Skq17J7pp5qY3GPuEiA5jGfq21kirtLhQXNI5Vgq2yO9RoObN7T6tUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMY2jYNIF/uRdtD5DdnilT8jUoJhM5Ix9M/jr1krSgE=;
 b=gP/tewH42iWRif7d4zu+4AZq4IqQQtYjEb1nvy9Ws4BrsO2cY6OeOH8hiX8VYC0+7opKkX8MxeAR8lT4gehiZznGuR+mPXGhrfJBKGOkic8OUzdoP3Vw4K14xVw/4WubUHyP1sYYT06/aBf9sn9I6QykZsaA2DdDph1f8BbRm+RkM5EhFBTPjSb9htEBM5/rpYNavuoRWsOHT2gpNaii5oXBef5hjXc4jUsIDdD9d4KoiOe8GgXcC/XnhfMZmoAodof0JVajwPXr669KIp7yef9qyZz46iH+gWPIbc5/f/Vpq8+nbnE7Oo2forLVGLZsMfeu7DOasUGU5t6LAn24Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMY2jYNIF/uRdtD5DdnilT8jUoJhM5Ix9M/jr1krSgE=;
 b=i32bcdgSDdxMY2zdUsIlGNLqgchM1id5ZyEc34OmMvAQm92Z1rYNAOZo22Bw3BKbvBTUQjkWdey4Abe5qgGfaFEvir8sK/Vlcg6MTjQPnganvCq3n3huIYrd/JQ4FHxxQiiwZr57ENHIfuULO0guHCW/2xG54TCxX7tMER6dD9g=
Received: from MWHPR1701CA0014.namprd17.prod.outlook.com
 (2603:10b6:301:14::24) by DM6PR12MB3803.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 21:52:20 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::2b) by MWHPR1701CA0014.outlook.office365.com
 (2603:10b6:301:14::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 21:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:52:19 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:52:17 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amd/display: extend dcn201 support
Date: Fri, 11 Feb 2022 16:51:42 -0500
Message-ID: <20220211215142.94169-12-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e8a61ea-66d9-4bde-bf7b-08d9eda8c6f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803987FD2ECFD29892A3349FB309@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0e0q4vvZj0ilTm6lKNV+hRe1AATrB29PdLKvujp+mtlV/uu6PHP0ZQbqm0Oza8oThdJZBcbDhVyQTDQQBuVF7tOSWEiPY8sGch+t7WhnJi/WrFnzEfzApEhwq9SN7UQV59AfwuRzq0VG81ptcNH2fRTkEoeM8fZs4cv98vpLBiMadkE9UNVP/bBMYjHZUtURx/H/vhLBDmKbhHZE7BKmdcKgDcAOBW8iYoZ+oXMsQ9F6yS8sMuNfGXqf0ucl310TkwqeyRftk/rLrios9Z9UmIP2laDjR59OP9wXpIHEN55iuna8uS8MiR1ftA+vO0dM20CKR3WhyL8/P5agD+p4dK0/LesjMA6GrzDlII7hze/tuWjvMEpuXICKZJxFyOZXf4H67XqB/bCjCkR0c9drxgIGyoBlKIBTcAD0pQPRaMwd2/W4FT0141x+pTt5dKhjTQyza5OPJzVSGdOP1cYhU0dRVOEFw/IAhtAdLHA9VX2DPm3omeynZT5y1DPqiobQ2At2rgqSbija9EPcppWvBpt1045w2Cog4hHyW3B5YinBASkYe366x3091oKjVnR5nmXYRlleBVqkB9gV+5XtEIjiLE3utQCLnIOnO9jsG05hy1YmD4ZkhbfQCGwYn/ZKFia+uNf4EFh8VJy0EPe5klFeraZamCjaDe1DvnGMneLN27E7ZZVxbZBh6hX4vIXYQgudMQglGDHQWv/MY0cVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(70206006)(2616005)(508600001)(6666004)(82310400004)(54906003)(6916009)(70586007)(316002)(8676002)(5660300002)(8936002)(2906002)(426003)(1076003)(356005)(36860700001)(26005)(16526019)(186003)(36756003)(81166007)(336012)(83380400001)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:52:19.5559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8a61ea-66d9-4bde-bf7b-08d9eda8c6f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: stylon.wang@amd.com, Oliver Logush <ollogush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <ollogush@amd.com>

Signed-off-by: Oliver Logush <ollogush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 23e113dc0790..e363859f34d3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 
 	case FAMILY_NV:
 		dc_version = DCN_VERSION_2_0;
-		if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
+		if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_1400) {
 			dc_version = DCN_VERSION_2_01;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e4a2dfacab4c..a8dcd6d439c6 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -212,6 +212,7 @@ enum {
 #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
 #endif
 #define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
+#define DEVICE_ID_NV_1400 0x1400
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
 #define VANGOGH_A0 0x01
-- 
2.25.1

