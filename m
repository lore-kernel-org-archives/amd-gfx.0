Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DFBEE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F057910E440;
	Wed, 23 Aug 2023 15:51:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9ADE10E43A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC/M37jigDXGh8Fc48SuKwfpc1xJdN9gF+NtbYnEmoU/SlJqtN/gXnUyp9RXVEHrsFSUWmr6J/2sbL9FknJNKgCLCJk6bVZUbNvt5ksTBR4VqeahQbqw8zDi+XvE+AhymX/Bn65UMBbJb863OCoo9FOwSUk8vFuWPzfdQIQ2zgaD6a4D0bckI3t4LA3AHaKUda6hiYqKUK4HQLTxRCkmNikhgNwLT1ORqqs9iuP1HIDXC1LoK0+mRritI2dyYU2tsxlcaIXfOBQi29bVhC+Tz2T228egZUfVnqlO9cBLgbwH4FlCylyXoM7QUA3y/l/3G4by/HlOfnzbyAaW29wsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaoxEfCHhYsr1qe97jTF3C8a2UKQ/JWVmNDFgdA+Iyc=;
 b=RPE8y7LFSaMX65pIoPSE0v5GkdSWJ31cewLpPaC2kXOzKHGVX5aiTOskW2FixTeBIONXdXdWYnxNlL0gtNAgdbo27SSAvKFf/hN1n+wzDl/a4NZv1MvpZzoUWRb8JbWEwKkj0pNpd1RwHKmrFFevDuF5s8ui5gawuIdSZvwZ0iMW6bsD8XyG/LYlZ2l9a2lZDMEvgwogLRqA7J0uHL459/yC8xWOhTPqzJmfKEpnNuVbPIubX6lzBn6/F8XsJXtsjzHyLPZnrpeZgSU2PTRasSL4kGpJkv0/auw4GzsVTqHkB4WwPvTu7MSGnzjB8ZfzrIb6Tzu3rAFDGI1Nrz/2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaoxEfCHhYsr1qe97jTF3C8a2UKQ/JWVmNDFgdA+Iyc=;
 b=AhNTHobNUIS8YOl3dtfKwcMQ4pOETz73elOIqfBqxeTwCYWkKsmDKQ5LRZG7NRynsT8mQxcgqmYhXm1Yo/Q7Z/P3HPvwaX2oDg4lCdd1egMCte0cwuj1LdB6TZNwAKJorJnpOtCziHr7jIBfviZ/+n4mSkA8SXQ51mxDoZi4ARw=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 15:51:10 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::df) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/35] drm/amd/display: Update DCN30 for DCN35 support
Date: Wed, 23 Aug 2023 11:50:20 -0400
Message-ID: <20230823155048.2526343-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6c5735-56b9-4f72-8389-08dba3f0c5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQsUsK9SFxJc5ZJdItpW6qipjOicJ400QcD/H260N76jN7eGdByeO0jcixbW5SEnVY5SXW4jYfiTDPesaI1hxeshKShXdS8EA/37NtmhJ3OIqSoyQ6rC66KIbC/5r9tA5JrR0KcHTPjOnG/uiRCXhUuINCsSa9a25Tuc3BkM5QaQ0yveT6ADpKUBU1FAuKK8mJii22/ZMdi6kHuY2vzN21owu7wrYA/ZMIFAKJPt7urHvKNrKnLMBaMRmtVEbsZCW7+bRyiKWRD6hJRgdLm3yGfYMw5KzltooQB7M7/pD8D1SjYHSmyVUATF45BK0SY/26LW08y3YlQ23p5L7ux7LzcBtQCBLqfMdm96L/FTkiH85/6kdJUbfGuyA4AgAuz/A38c71D0zrZWlOwEyfEFPHjx2KUuDM7ZFU5HW0N79i5UMQMEI3evPZe5nJDJGy5fA6CsgF+LOs3Lr5FwXWlWXvYZkVl8ipyBMeXGyOLo8DHsspTACfNmCfFxFg4iuRyt6QcsEb+eOINMa1HpxtYXxwjKzak1v3pMHeqik6riOu7WNiZudYTovfahPRBw0dQa0I9r83hHW4JaA7uKFHyAPU8AU8Je4l1m3THUvGfKsZ4nxcCkJHYtnCQc9mKP3K9FF9wnKJrbsJikbwK5Wwox+3k5B0ivP1bMvPDDi24ZH3nQWm+lZ3LH8svPMN5bOszkhlCO+L/ynG083HJ9GCFfxbUAaFWAQtk5Ca/9Q2DNnT6UDsHVWuntCCrepamb3Ezb6k9rDDRpO51VkZ25d0K26g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2906002)(83380400001)(40480700001)(15650500001)(5660300002)(426003)(336012)(26005)(86362001)(47076005)(36860700001)(7696005)(16526019)(8676002)(2616005)(4326008)(8936002)(6916009)(70586007)(70206006)(316002)(54906003)(478600001)(81166007)(356005)(82740400003)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:10.5622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6c5735-56b9-4f72-8389-08dba3f0c5a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Update DCN30 files for DCN35 usage.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h | 2 --
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
index 2082372d69ee..cea3208e4ab1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h
@@ -195,7 +195,6 @@
 	TF_SF(CM0_CM_GAMCOR_LUT_DATA, CM_GAMCOR_LUT_DATA, mask_sh),\
 	TF_SF(CM0_CM_GAMCOR_LUT_CONTROL, CM_GAMCOR_LUT_WRITE_COLOR_MASK, mask_sh),\
 	TF_SF(CM0_CM_GAMCOR_LUT_CONTROL, CM_GAMCOR_LUT_READ_COLOR_SEL, mask_sh),\
-	TF_SF(CM0_CM_GAMCOR_LUT_CONTROL, CM_GAMCOR_LUT_READ_DBG, mask_sh),\
 	TF_SF(CM0_CM_GAMCOR_LUT_CONTROL, CM_GAMCOR_LUT_HOST_SEL, mask_sh),\
 	TF_SF(CM0_CM_GAMCOR_LUT_CONTROL, CM_GAMCOR_LUT_CONFIG_MODE, mask_sh),\
 	TF_SF(CM0_CM_GAMCOR_RAMA_START_CNTL_B, CM_GAMCOR_RAMA_EXP_REGION_START_B, mask_sh),\
@@ -427,7 +426,6 @@
 	type CM_GAMCOR_LUT_DATA; \
 	type CM_GAMCOR_LUT_WRITE_COLOR_MASK; \
 	type CM_GAMCOR_LUT_READ_COLOR_SEL; \
-	type CM_GAMCOR_LUT_READ_DBG; \
 	type CM_GAMCOR_LUT_HOST_SEL; \
 	type CM_GAMCOR_LUT_CONFIG_MODE; \
 	type CM_GAMCOR_LUT_STATUS; \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
index fc00ec0a0881..a5d1b81e768d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
@@ -217,7 +217,6 @@
 	SF_DWB2(DWB_OGAM_LUT_DATA, DWBCP, 0, DWB_OGAM_LUT_DATA, mask_sh),\
 	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_WRITE_COLOR_MASK, mask_sh),\
 	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_READ_COLOR_SEL, mask_sh),\
-	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_READ_DBG, mask_sh),\
 	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_HOST_SEL, mask_sh),\
 	SF_DWB2(DWB_OGAM_LUT_CONTROL, DWBCP, 0, DWB_OGAM_LUT_CONFIG_MODE, mask_sh),\
 	SF_DWB2(DWB_OGAM_RAMA_START_CNTL_B, DWBCP, 0, DWB_OGAM_RAMA_EXP_REGION_START_B, mask_sh),\
@@ -525,7 +524,6 @@
 	type DWB_OGAM_LUT_DATA;\
 	type DWB_OGAM_LUT_WRITE_COLOR_MASK;\
 	type DWB_OGAM_LUT_READ_COLOR_SEL;\
-	type DWB_OGAM_LUT_READ_DBG;\
 	type DWB_OGAM_LUT_HOST_SEL;\
 	type DWB_OGAM_LUT_CONFIG_MODE;\
 	type DWB_OGAM_LUT_STATUS;\
-- 
2.41.0

