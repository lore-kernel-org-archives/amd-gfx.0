Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5ABCD98F6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A3110F5F9;
	Fri, 19 Jun 2026 13:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v7otBp2S";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D205C10F5F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev5pjkoH0cUYFfvGKTwLDGIaVhv0g8/SaxbnbjLptOMY9KUTGrSB5lYvtJEUl7X/73zv8xXJuN/43umoCmeTwS5y3QKCRQVL0nbbJy02YZRT9JBJSRGj6CkERU5zZLFX1NZiQZ4CKqrxpj89pr8X+eXklXe4NE8NZRJthgPOD/mIXXJJHjBv5EGydazfjTaGyGmX0pahPuiq4fgF5qgePkeu79VuXIhrXL3gQ8GrLyNhXw/7/jaK+pXU6OG9jq483uHJw4/Yyxs0231RHlWLvl5AEGDGJRaiwNhzHiUSlPaPzgRZp3j4QFi6I7po1Fs2GEEDLWcGu15r/0m3XVfNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yihFa/ZtF7kIfsHqALjsDAF+922DTeZi0lx3Syk2pU=;
 b=qRG931JykqyIRHjYIk7/XdchdF4LwNEicoShFD9PvPjxjWtHYp9HbVN5slWltwUQk9FwEpGMHfL0HDe018kf5TUo9uojjHyZquzaHSBkGm289ducJwT+X4PFUH9zFuVWShz1NME8A0ENn8MedZs8gQtWX+aPtPoJF9Z/9hAJ9UJ03+suk8uY6uLeFg6oKWpgl2fH55+3zyhxE1p8rVc1F3DaLX4gEdsFsQtg58l40hk4EpK38BPb/OpjwT9SAnXtbq5nJPoP8ZC+odeqIZkbQtFpfrSxFjRADx31T+mf7EDPC6xF/7F6Big0iSWZYuZnK/sdqjNa5dXK2GFW+zpC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yihFa/ZtF7kIfsHqALjsDAF+922DTeZi0lx3Syk2pU=;
 b=v7otBp2SzpcMIEUzN23LsaMwYF6xKaVjRr5zdnbqINP2tuaKLGo+koIfyk7XUtW7TvYCC5z6k9P3ueGXOU+hLPSS5/u93JoSVtTbtxvqpcybsRxNKfeYLOWMEjrnBPRsy+qvxiCwhRGZUSWABkb9/ygBVOrvi7vVj6sWHse+WgY=
Received: from BN9PR03CA0845.namprd03.prod.outlook.com (2603:10b6:408:13d::10)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 13:32:39 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::ad) by BN9PR03CA0845.outlook.office365.com
 (2603:10b6:408:13d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:39 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:35 -0500
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
Subject: [PATCH 23/24] drm/amd/display: Promote DC to 3.2.387
Date: Fri, 19 Jun 2026 09:21:38 -0400
Message-ID: <20260619133154.116746-24-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dc9994-a6be-4ec6-49fe-08dece073b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3yAn7yTsMjihIOLKrkUJ8I9E14DL770Ry0mzlAjjl8E+sHdZ/n4ZCGA+Zp4P0t0cBO63cTMHc+7uKu0NutsQRADtTkWFmNUf/JUEaRhUChbm78hpcFU4yHnVZzXnMdtF33l1fNITAzAu9CcGSpMkFRlHhHA0/b1f6c/hECbV0yPReG/mtFO0GJqWNu2wGZkuRnTdcVF9yVIFJX6pzA/DZg/FkcDIGrhLMJnjLMfx8Uyd/qd4xS8qH7CgDfGOPFyt2bVOJOeV6hRBmO01ZwhzQF5qb6XQoF4S7w4zuk0qZkQ/hdn4EnmXMtXVdBTcfRbhYMmVu9RyRZTrZ6OX/j10oJBAXtvqg50WpVB3VtJBygcMc2jiPPXBkblQ/BGwUltNprIyRFkssyIsj+Y6OSnXwtGzJ+OY2yjJqGdbotB7JOrVFbUdIoL4HIyZH+ggEo1/huBblCEvcXVtTMRJntk114Wnmvin/okArDeSU+9WObt0L8HT+7O9zXy+aFhlCbPQw/Sd8/+Pa8J62lrzOLVlYjRggmZs/dCZCXo2et+Kce00R4uaLiHtUSIhapqCy4ldWX9ZCk/yI4KJ0wrNTz2b1VrNu9Sh8I8AA1k2CnVx1HRu5n5N6Z/z/k0H8BvMgYBOoy1tIct0LNgOAvR3Kc3LsthoTkGIQJ+FPHXOsh10oGAVDmXFSwpikXh5I69USNVLaRiN0PsF+cHvnn2wxSBWtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: umUhD3jANeVkUtCzTylnsgx6VruAPQdbDBTn+A+hH4ogVktj0bcdBGgh75jArjXUzkYa4/IkDAugj2kiOONu8j+V3i/LfnrPBIE4C2huz0oLKUFcOVoVDDZtgbBYG8wGCcz7pm4z8zZdc+uQk1felMXUBfg1x+e2z/fkuJOhibUlDCpKhe6Oeclio3zoco+xc6Zkm2bNhFlsgaaHNdolUmti4i6GRz77CyHFZM/R5cchoAoEULYqNzdlF7LPvF3F83Y9haMx/hloOYsgDSf+X6B+VchM6SBmrLjko+9w9iODV4PvyA4pw6Xkm5Mw6gooLauQi5Hvsejag93edQ0YgFTqEmWtyHTA9arWUvgemSlskF3bdJm2KzYSgTLLFeOmUR/PDgEZeHhzrgVTos6QkmBbKWpHsKZs8ngZqADoR8BOwRvFmH7Er4bxXxdzGtju
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:39.1329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dc9994-a6be-4ec6-49fe-08dece073b83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
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

* Fixes on DCN42, cursor, and others;
* Improvements on DPM, DCN4, DCC, and others;
* Code cleanup.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c628bf8778c9..0e115b1aac5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -65,7 +65,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;

-#define DC_VER "3.2.386"
+#define DC_VER "3.2.387"

 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
--
2.54.0

