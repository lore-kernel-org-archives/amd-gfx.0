Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7C6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C25210E2D6;
	Fri, 25 Mar 2022 22:57:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9777610E2D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra3JsrBvYgoKLp3oio3eWJlXKP4ktjnH5uJreCxGhM7EQxJ2fxexBNODvYiWkpbKJbtFU4skMBUY6I1sFh/RctfG/MqSX9O9PLMggRg3RnWB8RDU5QCsxOPecVKJa+7EiWZeSEVt5/YhdhC5k9d2HSfwXb7HTV2QeRRo1eePpjpml83YC9Oz41C7mJbk1sOpFtE9UMyzvnxl7TBKU88+EUaKchtmjApexPBUG5I6xvWWJ/niPG8/cnmZxonPd+76pWQ6xr5iiS9aFtTRZ5Q+CskQAB+V1SmWfDVYaDvKBn6xoIWlK1uEItNv3Qoh8meuI8RJjXzg9PVijQt+eV/0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qegf3oABnPh76SkGw3Flii+tfbwUjzcHJQM0PBPR4qA=;
 b=iitp91AgYr2IXd7AuT50zc146bAGp0rWH7wUEH9uiDz0WEi4ZNbhXJMVgqce/8Sy4DNBcxYKWMDHTS2n2N3C4pRf5sTUj5rugiTjHttWM7OOoddDX1my+j/jnIGpL7kW05ND9wYDCB5lh7ZG7lBhHIfP6CVCfp8CS7zmKfUHVn9awBqJadli4IRHRjukKbbZZfxrBni3E0ZOocu60Mtga16vGt/SizIcuHDLZS4S7hKOyxkEG+3wapMbcV7E5h7R5tv5nFqqrfgtSfnezFXLhuBMyVsrN6cxq65Hh8TaJOvNH0K/Y757fNH6hxUREeB1VB6Ghwtgbm1egmgcshTAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qegf3oABnPh76SkGw3Flii+tfbwUjzcHJQM0PBPR4qA=;
 b=2ElyfxvzTXKt+1wTsdJ0SwqVHxHs22xkJADvIb+6G8xWDjpkU4j0P1OG/AlzzO4P4JYOJPhc1XR2apKCpAtD2quZuJ8sbsHw588e9Ch0Wg/au4uOeaHgwZUOjCR/mzPTMmtU11EE8SWGSt2XF6sdWCXrgKInXLnAhwaq5yUh5m8=
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by DM5PR12MB1690.namprd12.prod.outlook.com (2603:10b6:4:11::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 22:57:43 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::58) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 22:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:57:41 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:57:39 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Revert FEC check in validation
Date: Fri, 25 Mar 2022 16:53:59 -0600
Message-ID: <20220325225402.469841-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1069fb9-85d0-4607-53ab-08da0eb2de27
X-MS-TrafficTypeDiagnostic: DM5PR12MB1690:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB16903CB95366946976433EC1F71A9@DM5PR12MB1690.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqSohrIgOJ9Ti+lAUnYhRy39MfX6xgQ97RZP1I3TJ+lGkp2IF68Volbj7OX3jqNoqhlddykR5VkA1T0wdXcwmHGjcERZnavOT11aSGkZB6DTj9BC3AsEBjEcWuvf1paThHy6XrnFH+We4GN3ulE4iKOExg9W5Ly16nzTOsfmSbJhD61f1zYQ8dCi0nmoHq2SEZFpWLpKB8eNlK842O+kJAa7YhO/UkciDbwieqhqXB7lkUa7qLkOCaO8lqeLE2dE4oE2Gl5PqNxbj8LZaJaut57ipWCuS5XI/TAD+c1zEaE8RQxuthI5bZtxvYaeqno9tuiyOE2POWpf4RvT4cukX++cX01oCapzOHVszV5zq+HzcSokz4eg119kIDbyOsFXVCo1/ouOmjDHs0N7qGcEcw3tOm3NKVR96v/5vruDbRrqhC/0618BxfuoDDDXWtEvuNbJnCKz+je8GmlU3Z13Qspc6BVAP2KsduGfpadgOTkV9zUFoGn93zHBMMsB3l0/HVyj0d9XXN4tC+IFur+/1VjglA+lzY3+OSJuNuiOIYAn5/glho5vOeHkBQZynS3WJSTINSIMy7L+KvyQF0WFoY2Vst5WCT3n58U2XKUVKcERefgiGBJ7/7xGcS4IsBYDci1IpkKL8iO8gByH1ULI2WtYYKyWeC68RqTXz1W/Mov5VDHlcIYqSAplFMWYlRcZRGm6ICjBYZrb9cLj3CeNqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(4744005)(6666004)(36756003)(1076003)(426003)(7696005)(186003)(2906002)(44832011)(6916009)(54906003)(356005)(316002)(4326008)(81166007)(336012)(70206006)(82310400004)(70586007)(26005)(36860700001)(47076005)(86362001)(16526019)(8936002)(40460700003)(8676002)(83380400001)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:57:41.8558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1069fb9-85d0-4607-53ab-08da0eb2de27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1690
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
Cc: stylon.wang@amd.com, George Shen <George.Shen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

why and how:
causes failure on install on certain machines

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f2ad8f58e69c..c436db416708 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1496,10 +1496,6 @@ bool dc_validate_boot_timing(const struct dc *dc,
 	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
 		return false;
 
-	/* Check for FEC status*/
-	if (link->link_enc->funcs->fec_is_active(link->link_enc))
-		return false;
-
 	enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
 
 	if (enc_inst == ENGINE_ID_UNKNOWN)
-- 
2.35.1

