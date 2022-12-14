Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28182C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A20C10E485;
	Wed, 14 Dec 2022 20:22:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7889710E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZSxBElLadnNpMhfC3S1KCUx2BG2vUjx7EkTWAMcEW0h5duNAscjZ/3g7fK5JwztJr7BfFjfXk38f9wwMBQH8tyWnndMi9ItfI+8H4DNeBM2ApDhMs+sv6qkYZdA4vJgZMCB+8WJ7RX5zQJwvPwSUGXggQmTEOF5YNP3S+8U3Zj2YLDaqdwhEhozVar2rSAkA6NWVSqKYdSmsjDOOG0xQQVPidc76yr1Dordy4mTA+MVa5/kBLq7V66WACVnPwP8h0nxRQ6fBgPLtQ6g+cM9lhe1G3oFJtnCGrGsPZN0pOYa8ZpF/sIw95Z2TT9rp21ne7bo2GSTYj88G4IturJ2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifMDohgIyk0jqnkpcPEdTpQAj85n84WmJy2jxfYua3c=;
 b=TAnB128gNxa4MKfvfdmE2RuSNBL6/Bu1rVHLFefimf+Mz+vu8JXDIfVLavhUcWWJxhErAAgtSsHljl6wLfl9hQWNm1J/6MC7ill1egC2Da/05ffdkQ+z4zt45eQpBQ0QoUVBRyP3O9iwkB9phyjAWVFp8P+baaw0Baid9O4UzB0RWNRzihV3bhj5MiGsUFseNX6RaaxUyUXzJO5Jj80P9XA6Au2cfkBMdkPRjiHzpDdHIWKv4t+1GXR21WWok3YBHu0jf5NiMt5mcmlPqJ9z6hHrIOQdvshghg0XsZfLzDo02G6JoOrUyuL/JNKmFM8NAmUpUqfEsbHPt62AZIXG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifMDohgIyk0jqnkpcPEdTpQAj85n84WmJy2jxfYua3c=;
 b=b7u24aNUWYePWOzqQ+/XdN7yoxrdXOnSTn+ZOCb0AP7tkJKwyryhox5nunxEIezUZVmZzWXLrbQTbm3Kp6PYZgRT82W/RPHSsdfYDLItumuuXKbzCcOeaXozDG0jUrILfwlepCtQrD39WJ3ds5rr71AaUjafIMpOUauX/qbvhB0=
Received: from MW4PR04CA0033.namprd04.prod.outlook.com (2603:10b6:303:6a::8)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:22:20 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::9b) by MW4PR04CA0033.outlook.office365.com
 (2603:10b6:303:6a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:17 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:22:16 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/18] drm/amd/display: Adding braces to prepare for future
 changes to behavior of if block
Date: Wed, 14 Dec 2022 15:21:39 -0500
Message-ID: <20221214202141.1721178-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|BL0PR12MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e72196c-94a9-424c-1fed-08dade10e6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5veppNCeCN0yjbrLJDzPzXxIE+eKYu7mh0xJvIgzcE85soasjO90vFhvXjG2VbUsGaDpnKqbkOMUxFHnOZCz2/9uBIAAUsmKefeHSUomqQD/kSPqsXiB5HhXSLWCOA8r/jOgfR/UoPYH8bPS7vQWRebwD+5uHxUkXCHqC7oGT9CH+kkx6PfBa0PRxmC5OAKyxIPdKG64+iNrayzpSVsKKGB/ovx4myif/wmyr2IcJ+er5hg2+fN4hswLxQ/xRLxX3Cbz3ejLH3pC7ujkK6LtMjhtloG9VtzatbWklLIrH0Jw8PRcSOLRSLBe4sDAgrYqyA+T8/o6WQ78uIzKh6V6AdKZa+I08npma5x5vBIcfA6QrgYMcht84FUDqs3bAateI3oMJYuImQ/qWy5IlXEnbye3P51jp7WIFx94y5VYGOAlXXXL/ul0cYqN397l3HqxR0wfcG7wiOkEWdY98wSsrPEp52/RSsbhSPi9OddgBWJmvyVZ9dJbKBuGzn416pFRmimIsOhd/cmn/vWkRAnLMdzoj1G+3QaLjocg6CVvefVqSKwiiKj3ZFqCXVgNEf6LNmBimEMdR6hrLOVw7w6lpHOBwsakzj3O2moaX+V0ou7mkDzIhnvuCcG92a0miVG/AzNpdOFnQOE1VCpss5YG9W28QzMVrlEPuLIV27VWZ0hzf0r/qZQZGi/rOAPko2DASwhsZshYPvOetOeVpJTMo96p8RTZZVnoPRGkwaVMX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(1076003)(82310400005)(47076005)(426003)(2906002)(7696005)(86362001)(6666004)(70586007)(5660300002)(36860700001)(41300700001)(54906003)(8936002)(83380400001)(4326008)(316002)(6916009)(4744005)(70206006)(8676002)(186003)(40480700001)(44832011)(336012)(81166007)(2616005)(82740400003)(26005)(356005)(40460700003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:19.5601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e72196c-94a9-424c-1fed-08dade10e6ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
For certain features, there will be more implementations needed in the if-block.
Braces are added as part of the preparation.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f41933845d2a..dbf90ca0cf98 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2008,8 +2008,9 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
 		return result == DC_OK;
 	}
 
-	if (!streams_changed(dc, context->streams, context->stream_count))
+	if (!streams_changed(dc, context->streams, context->stream_count)) {
 		return DC_OK;
+	}
 
 	DC_LOG_DC("%s: %d streams\n",
 				__func__, context->stream_count);
-- 
2.39.0

