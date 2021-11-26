Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F320C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C35326E950;
	Fri, 26 Nov 2021 19:49:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B056E950
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWRYy0r5nK+oumqUlS5me93Y0IO/aDs5IIthaXNsJVeFhdevzYH77o6bF3RMt4O4yFPTrB2L6buKGzx1qLy3l+/W5vNmbhoFMjWnfPDzxmF/13pwHtp/nWoC9Wj3c8fpg+w67ffA5XrkCD0wuHhhh5sdhN8oNcHD4/zrivs7iPyOdDeZwzpeZikPSZjqKX9J7jFLfGTx6/FnwZTx8QXCtk+qFgvhk8pVnuX1/WhnCxdPQjdDlKqDni3318KFst8F4XeF1M+BSBPrw67LYWtvFR3joocCL6a21nLykHKWrywfH3mfVDo+xiCqMHmgcwAOTzoTUbhQVteHag/CzzACiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWxf6KvLC/NFqWh1DE+oM1Xx9lCjBQLENKpZxmM8+mU=;
 b=S7wrNS9Ey5jQCEwW2rpfNx5sazgUF2+eYU4q996s7+05j/7/Ie1ePUBinLURqaQjlkwZRJNa16E7F9zK3IoJNmdXhbauHog6YRqdc+bl4yexwl6YPR5IrBVDRKRQPfJE4cscDBahzBmb+2n3NrB4d3qIDfE624953I1UTMHwNmiLPJst1taHfkQXVguAuH/ATzLY1k+IFN2MqiT6RnTGaIBxJwu4Q1NcSRO4+/AlGwAvHeQh0GObxPAfyHjS/ioCAyDlJxRotOXW1JHrrbbun5K47NuZDTT3rPVIS4bf3aBj5YjX+UtTLFw/FZXQTnV8ZVbtZUAFIvGQ9UVvnyc71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWxf6KvLC/NFqWh1DE+oM1Xx9lCjBQLENKpZxmM8+mU=;
 b=dAWICS42eA7qk7pjUCrNzVb3eX5HTCRlmDfdEDQ5oC0fE3to1NWP5ZWfau9M9ZdijboVkDyNhGsAbrRrbH+R/3S4mc7olO08Cu44lpM/5jHPSg6mfwQNAFd1jZXo/Jc/Xlqcw3rGJ96Tbp8aRuFjHTr2Z0WlQ26XWnVl8XfEvWQ=
Received: from MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) by MW3PR12MB4377.namprd12.prod.outlook.com
 (2603:10b6:303:55::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 26 Nov
 2021 19:49:45 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::d2) by MWHPR1701CA0018.outlook.office365.com
 (2603:10b6:301:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:44 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:43 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/16] drm/amd/display: 3.2.164
Date: Fri, 26 Nov 2021 14:49:22 -0500
Message-ID: <20211126194922.816835-17-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df9a7947-8cc9-40f9-0522-08d9b115e58a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4377:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4377F753345E0736A7553279F9639@MW3PR12MB4377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvIU00ygSxPxiLQ01KiKR1wjsCGGZwvmtpQr+lBbE2if3IRTR1OXYhm53zumtz2Emb5dxz+9wexqOw92dK1q2PGrZv/VnGPJ+OwpvoMk2mZVnjWjyzEk5q82lkJtlyjqk1zu04M4qGTvYEVKE2Ni8OrQbA3o3lFTwV4mWezvOaHz7uhEtePpV1RsGVBMUYDwuttvQ9P/FnSC7Twt1rFiWD9UhWoQ9fWdLk6KYtdz7InoOYqfFU3BrZuE5cdozeJZOCzj43nx/9joOxFPPJT4LRNnusmR2gHjnz57GgnyWhoJZk9ChUG5n6/zCN931cYSYulOaP/cCRBU4VB8qy3Y12SzRldY/npqrKlLT2KDyCv17d3s8uGJj/whktuA8/mVaVH6BTEB+QDpLtxQ58RvbO15RKY+BU9MYAP7TbM+qe72SG6fuz3aEHeIiE+1aXWrg8qT6U6oM4ISPzhVxeAOopVb4fnTSMAzmf+7iI1B6IJYN86dytVuvAWLOfAGckeH3Lu0OSNIZPRzdphDkEWPl4GbQJGG5AUMpaClosZ14bOks7g5ePPkiO2Pr24DN+VS6Q6TX7ke9D3aWoHGQgFImwZ0qaiQN+9ppmTboTOQ2r1LuJTYxgyLzaKSWu4qZSu7L8kRko00JhcgOs9XjnSPatprJCXZNT2CDiUrlAgm7RqEHaPC8jtoOc5y2AVKHO3d2o2ADcQkkuibiQKfhD0fGfHlGx9u4clixStCFrnPBs8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(83380400001)(70206006)(336012)(6666004)(6916009)(186003)(86362001)(54906003)(4744005)(356005)(26005)(8936002)(36860700001)(508600001)(36756003)(2906002)(47076005)(8676002)(4326008)(5660300002)(1076003)(426003)(316002)(82310400004)(81166007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:45.1474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9a7947-8cc9-40f9-0522-08d9b115e58a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- FW promotion to 0.0.95
- DSC fixes for supported Docks
- Fixes eDP display issue
- Vendor LTTR workarounds
- Fixes Tiled display audio issue

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bhawanpreet.Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a6607d4e3985..dded8c3aaa3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.163"
+#define DC_VER "3.2.164"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

