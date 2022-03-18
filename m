Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B13C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4421610E243;
	Fri, 18 Mar 2022 21:50:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F3610E240
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCHtQjbCb20Xnq7rrYtmmAYCwWSPAy7tnC8KKpXWOY1QMBDfuOhY9MBXXUbCDrubNLbTmBPEqzEtmUv4pc/HVqc4GqeXIBJzWTmycvR9AXR/biNt5d1l7iH1Ee0gdpWg1bHg3uSDjWdnKXwltYXTnKzUXxjtThAoNB6m92gUAdOUtvM3vg1bbKnqx/GPzs7L254aQi1sDbJU76zAPYMw2UN2Kc9vuMO/SuFyEeRpIBXopte6JMEhWE8Lj+PGSmQ8ptTuaGCyWtwJnZ62bnhp760oaWfUMCTt4AweQBNCu2PfXz/bjbDdbpyETeeyAkQfjRsDAK4FkJyei6xNSLJGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KTRseBeX1A/lFBFWRKhvGo9wVBUcKUReOKHh0GeIc0=;
 b=KFLZAXUkDTV8xHCtr6XIQc0YxQPbj5YYqRLjV2AO044rqHReEmhNRvEhqoWRSgNBp45AFiMFl4Zxc4dx8HMuciwwN+ithIM/XKSKy4/Y16fFGffE1umE2OUqEADJGWKlvsOpyLjTVzc1yYa0oM0ZPZUTl50SKT86U5bfu0zrKs3o6k9r26wf3G5KJW85Ac7goVOt/YTt2iMlUoHxP7fBKxPCtK+IulrQv5l3InmE/f4v9d+c1kfLByJLzO1/S2wOXykcdh9oyUFp8pKuTYHcqb5DEPnbjHn4PzIVM8iO0OPnG9ozX0DKCP8WzKp3nKig+EgK17KrVe5JhpY5h/qPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KTRseBeX1A/lFBFWRKhvGo9wVBUcKUReOKHh0GeIc0=;
 b=x2f0hpxK1XtvaZhlvhOZ358bigh2OlsockHGBvuLO5FG/sDOSXMRmtk72m7cXE+hzR+5hV7XivpBQBHVw7+Lrm8B90RejobHk6PlLtJv+s3cs/1AnnOg3J3gj+nvuNPgyikDFsAr5K3UpW5/RZ+eQJMFxU4nugPiPTu0h9pcKL4=
Received: from BN9PR03CA0504.namprd03.prod.outlook.com (2603:10b6:408:130::29)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 21:50:30 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::6c) by BN9PR03CA0504.outlook.office365.com
 (2603:10b6:408:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Fri, 18 Mar 2022 21:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:50:29 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:50:27 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amd/display: remove destructive verify link for TMDS
Date: Fri, 18 Mar 2022 15:47:57 -0600
Message-ID: <20220318214800.3565679-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fb7cf02-274f-41f2-e90a-08da092951cf
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB237979AF0D7A52EA3ECBD5DEF7139@MW2PR12MB2379.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1P1Wrqe66hqr2P/GnCqkuAFkGBJzUTbKeSCkoptXxVvu4qxEbnUTtYctWjwhnXQvg00+Ar2bshKnZ4eN5c+O5sWTEM0ZgCaxVDVsJCKSH11ADWNcSkMqjhBL0AZaCThi5dj01FWOHbzub4Yxm/X1B1FqfF1w6FdeEnLvsNcTroXb032nU2xggDNOpifZpCWJ51Wh4HVXe6Hh6qVJ10xbAUVG55nHtrRK7gj+dO1TmCWQpYSLdUIy+9cF8b9zWTiSWxhliEyjAE5tgwtsqw1XTw0DaVBGIRjX0YHoOBcgR+OouYT72LFTSX2an6INRHJx6c4MJdUt5DiC9wKao8exdtxCO+HCcwWN2NdzBFZIzPJvyD2c5T7SPNcStVJLXlMF/8eNNQsHVE3WWPjKeFdk/BIymxEMX7CaOInx1IPBYuTOdVHyySEAWnupeMY1RemNfENB+nrIEJbt6OIKgogD3ckckwIH50CGDIpve40BZsd/RIzSuJ4cWeKr2c90rYqlytoRZfC/yylwqcnSTr/KJJCNZlZDHTKc69/bjv+hmrfDtGWP2IrX0dV3JJyRlq6ol/PmDB2e1d9574QpYjcVqHkZCw2H3OUhmVrdVh3qIqJV3fESnSZc3t8ULZSiAoPsTl+nelWIGBhNx+5S0Zn33LXVOs1SbMkhoWz87IgzOKHNBYiX8RCJ8hzzpa9D8MRIecD7jkKoI+DWyJiJkS4Wjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(70586007)(26005)(186003)(47076005)(1076003)(15650500001)(40460700003)(8936002)(82310400004)(86362001)(6666004)(4326008)(16526019)(8676002)(356005)(508600001)(81166007)(2906002)(83380400001)(6916009)(54906003)(7696005)(44832011)(4744005)(2616005)(36860700001)(316002)(36756003)(5660300002)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:50:29.6454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb7cf02-274f-41f2-e90a-08da092951cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
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
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why and how]
TMDS not need destructive verify link

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cb87dd643180..bbaa5abdf888 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -983,8 +983,7 @@ static bool should_verify_link_capability_destructively(struct dc_link *link,
 				destrictive = false;
 			}
 		}
-	} else if (dc_is_hdmi_signal(link->local_sink->sink_signal))
-		destrictive = true;
+	}
 
 	return destrictive;
 }
-- 
2.35.1

