Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7998FC982D5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A87E10ECE4;
	Wed, 16 Sep 2026 17:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ucs3qnPr";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A7510ECED
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTSStsKJCIVmkCtwpKlf4HXFff6ZU9XwofwXMBzd0zkgmteNJcsaY4DRxaXA3OiqE+UUEoX4SmVQRyHTsXek+NHsLkU1jVYfQp2QDNDcjlRVUi3bb89uK3z6vdX5ZDQuuyS5rXSpuuWn+E/4cJij6Ibed2XoGIHen16z1Onyv3mliy6tKWQ8vi2tt02khxDce1xacJPyFfNZlCNiA14XAgaYG8pkZblu76qPKCc+xYzLXZbcpKvtdTjMyPXsdfeY3wdbphOogfEx0lKEO+jowGI1XoJ+AEmkh8zEUGFjIq3PArTt6Mi/+IS5eLWMz036Za72UsGDSPZ8pf++87wf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r1Vb3WoIMEdjW39uD+RbaVseI5iBB3TVohdo8aBxZU=;
 b=uwfZbZBq6iJ3QbmUGI951la38mUlJMW3K4kQcC6ABH1G/Hk811I96maVSVUImVbaoyx6leuiGsMf9fLGh4pQSqgWE3z2hGmA6DzcLGmbJaLtmJtjXYzZr17apPrs727l0OU0rhAeeD2mPIUmDoda52glF96Of1ExHyFNyGEdclYZmwqQlT1Kg+kUCSaKC+KGMGUDh/uNJ2Ixk6FiCZk5f7TtQj+K019cyIdZe0vcsPXEKjpe9HUFTtlxxHvf7LEfkvz6CNnCrO5NvocRU28qv8AVG4YAtlFhnbkaqMO4SA+8mQ7I/JtM+ENsjb/1iCZQEQuqI5NoioSuLmfSdkcWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r1Vb3WoIMEdjW39uD+RbaVseI5iBB3TVohdo8aBxZU=;
 b=Ucs3qnPrR20yIy73FPAFNHmYPX2Z9UEv2z08popEMW7BMQWJfg9EUX+wd94uDzJHe70jBbA1dBIV4f0ktSW8nsLZZ26UtqLIPr2h2g5qeFujUHdIyNMmkyaim/xc0HvUp1LDrZvgcJjElWA7EOoa9QzlW1RJeZbcTZNpOefuoqw=
Received: from CH0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:610:e4::21)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:53:19 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::46) by CH0PR03CA0196.outlook.office365.com
 (2603:10b6:610:e4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:17 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:53:03 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 64/64] drm/amd/display: Promote DC to 3.2.399
Date: Wed, 16 Sep 2026 13:52:19 -0400
Message-ID: <20260916175301.368306-65-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f626dbe-06aa-40d5-71c4-08df141b6330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 17FEzgko2OzA+yqh0MZSBx+APJ9l18rAWjdLFLdE8bH9A26YU63lQ7dIHWkL8tdbYSJf18ZJIAoNB6RbfvCROxL3OiVyyO47Bqn+EKW+JpTB2ycFRkXLxRcpRsysOnMT+dg6DKWBJltw/xWe1zjwdMidTBf5hHYaD5OGzOWGY2Z31XNLRb8DeUqnlMg1xpBB31//Sc7V9ZwVpCnnsTWEX7HQgo9gPmKbxU8JO2dUGLL8fxs87M8f7BTx5HUCv9uQF1Nytd1M4dqRbfIhenvcof1NdKdot+N1G++5b7/eXyBgMAPhV947qtsZ5p3JWRbQFRQkLm3uNw35yMZ0J/v+U2QTT0wb6vO13xL0KvIiLQm5bC7qJWyKeqg6PcDypbCITF9Ug1Pw1f7to6XnrhhJ//HG7/noiQnT8QegmsUEpyj6WXX+fC7vG06acrEhzI22mbrJa8MGEm8RgCD4N49cM2MF3pa4pItoxbxaBTa/OzYFjySbrA36RZzmh2P6WxxXBUCV5ahL2ZIi97ufvQYL88jB4M3YR50v3GhiMXkvA1qYY0tLLCis7VnahZ6fRPHlKTmF+hk5Bz2wik7i554xBV7qp7cSF4lURaD6/Mxm81XqmE/+Sh+PvXsqVTDKWasmiQDbDw4TVi+fMmaLio/C/4S/SR+mlF2KkeCwYUSVDebwhZNQU30mFWhLNxnviD/PiXlSa80jJ6U/T1Ir7r27gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nV1ssd1iLeabTzxZyt1KbqMgPhfYZ9WHeZ30ppkP6d/s5yGoM6nlBz9pJB3npi1nZoz4lFh3tOWy/Lv+YOwW5si6A+QLBkTbxHZQ9OX87IBZxg8eSNe5dgKmv6wuCsyXyOHJZGpsiPDL0YqPvro1gCaKBdTyRWzP4uChqMqK8EW/q7ppQiOVhmtIkw4NOCv7hSHHDLxd8T0/zBccvoTltiFoiLHk3HNjIboOCLbRlSxSCI8thylpSLtLuRlOHdDrx/PpiRLTE7n9DNhHDbB/qWd533usC+XWXjHQSfLo0hCOC8GkPqrhpx+1am00tQ2czeCQxgfyd2imm9tNOMEiD/z6n8NooFLcg1s7KXZpRyXlh9+CQPKdE6e5Px9YAHxWyWjsulZd4LWCD+ZHgop58H6EEOtuOFM1inoRwwAE0WjOiBegzDjF8IaIm4oQlDwX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:17.0144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f626dbe-06aa-40d5-71c4-08df141b6330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we have:
- Increased KUnit coverage
- Reverts a patch causing regression on DCN42
- Fixes for cursor
- Imporvements for ABM

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5174a0098e75..c8e6e949ce79 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -67,7 +67,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.398"
+#define DC_VER "3.2.399"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.55.0

