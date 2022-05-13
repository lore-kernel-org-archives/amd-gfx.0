Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1096C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F8610EA1F;
	Fri, 13 May 2022 20:51:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B2810E8AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn7Qx7IfaH0cUeHyLaqCaCpc92EOti2PSs1c+iK+APyK9dZx3c3CyT8aXHdCvz8c7QpXsKpoE8yterLzz0beXKuZw6ymE4Q/fbRO71zNxo1/9DLVXtqGou5L8WzvxFAGoJl2uDOErJSlx0ehE9EMKWpUMkUYBK+gtsu6QduHG5yWgpioylN9ILtfD+BrniuDTjOXQr4eX4Hs1edIooCJjBx7xO+TTp3VT0A0ZkQPRu9JL+MRmJNBJIdJeqBmgiPoWtB/RMndyJKtBVjPSwavHQnJaB3//DkKJu3s5H5m2bHyt7tScLPuUTaRrPZvMDfZ9r0NSg7mJB4zTsJ+VjpkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjV6X2MhY9iKjCmISt90Pk2eNO/FwdpALIgBsg2l/nY=;
 b=BBP/uY3Y2VVSZbQA50I0KR5In+CW/e1ClQ5xNrtUwBGe/XEZXNBKBnRraXdd07ty+eYTRuGeG6djmXccTwhHBCXvtE11IuK6PdoLVSqQFjuvEgy/ev4IiE76rcqrh+6yXvyQcOxbINfuZcqPbDIISUO9OeirKFaoEiuTejNSBl4jdVx0DBxgOs5zOxKOVRrmIunZgkb0Q3zpOMHNquotvlUI9nVlLAT8R1x7Xl4C479cZw7NNKCafcHatA2SeMhEamt5/x+TuPNpNWqV2IREDnDlUWW7+6bM+Pt1ujNXwAyU8KECKnKB9svO3NS1jcrrQ8wzglreqhk8sTciHiF8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjV6X2MhY9iKjCmISt90Pk2eNO/FwdpALIgBsg2l/nY=;
 b=H43Z/B2MaIDNyZ2P9V7KU3qNaWmlGFGSxXZNNmivg+dIJVhEFxOYARdTJvKKIV+sNSU/qRALY2/5Br0vWNAidNJ0RRjLF62peFsV3TglhWnMFvoBAlyZuC1Gyoz5yiViYpXoxMHEJiKKCz1GiXI01dTD2qLLBRE4fuVcDEBra80=
Received: from MWH0EPF00056D02.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:f) by BY5PR12MB4935.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 20:51:35 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by MWH0EPF00056D02.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.8 via Frontend
 Transport; Fri, 13 May 2022 20:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:35 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:33 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amd/display: 3.2.186
Date: Fri, 13 May 2022 16:50:41 -0400
Message-ID: <20220513205041.1311639-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c45a28e-720d-4eb1-fc50-08da35225e56
X-MS-TrafficTypeDiagnostic: BY5PR12MB4935:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4935221D76673E326CD1C113FBCA9@BY5PR12MB4935.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Quu17r3xNaGGrpy4wMDLGmiDA/d/roQbAuTJ03F2iZx2jTnQcsWC0WAP5czPuEQTYD2eBEu+a4+d8a9deD72vJA3mXelnQaw9Ke5TnfZw38xVDq6WofQFGFlQMIU0BMBKmCsDHzd01wGsboz30vUsb/PnW7lY3bNubhpTLuS9z61lJoAaD14I3+6riIN1tDu9wfrxhLvWqUSJabHB97tr83408lnlXeRaxbMWRLGMCBIKaOC3FkUdxW5H6LJQUUbfAOvk9eWhusIcefoDa9/cwRIW1X5C5JC9jISX+D6jCrzOpaGXcgZ/1oMrt77RitKbFwTuCHt0DxkVvCUC8+cy35tFYSwS/s40YEMsri1QV44KRvGHW7eR5Vr1msC8nJJ7eJTnlnPX0Se+yLOcmWXtGDjKQvK/cYR1cUqpudDM/HhZ1WpjVPiWJMtb/TYFJ7ijKh7Mg+lokx/Leb9j5kpotORkoNQ/xpfNreMXROSug3uCRFufjkW+7aLimPxlAH4e7SdN1KX9cAunsTQCc8+jf2+/GnZREMDsgvLFFUzkW9CoVyQecpg0qLIBqVXWaNQEx9HIE5C0+hyfUUZIP2Mp3NxU6rnsAzQEg7gkEhAfqKRm509YN2oebQpMn5EO/govC5EZZuI103fe9e4+STEuzQhfPrzYb0B/KqtXXZb+F62vH7xE76PEGpeY3LTvAWwNdQ+jUSmQcX1IcJ2jueAmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(44832011)(83380400001)(82310400005)(26005)(426003)(47076005)(186003)(36860700001)(336012)(4744005)(5660300002)(2906002)(36756003)(1076003)(16526019)(6666004)(356005)(40460700003)(54906003)(2616005)(6916009)(316002)(4326008)(70586007)(8676002)(70206006)(81166007)(86362001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:35.2390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c45a28e-720d-4eb1-fc50-08da35225e56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4935
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- Improvements in link training fallback
- Adding individual edp hotplug support
- Fixes in DPIA HPD status, display clock change hang, etc.
- FPU isolation work for DCN30

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7cfc04a8ef15..a31ea3644ec2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.185"
+#define DC_VER "3.2.186"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

