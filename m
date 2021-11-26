Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3D9C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE3B6E9A4;
	Fri, 26 Nov 2021 19:49:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A5CB6E950
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7OEFUstlNEo38nKX0ftqNfYXyhoD3Nk6B+UJzXrha4bZJiG4MAF2w/kXf8ulAqkShX9WR5iYYJzSbjK85E88RfkruzgnqLJATT866One2fgD7ykhuHnQvBCdLKSg//i8JJZ7OP0hDxIJtHDbeiLU/K2IZm6IruiMS6dpTtv9M12Pwd43BTwnel5MUjI9VsbmDqPz7TEg3zi8zUNnUb/8qy/5/AztJjb91dnBl/9z0Rhev4QV0lt2KXUdHGoEWzKE/GREGStPbV84mOuFeuLSp68oeEAsabB8LWe7qKJkEjfX1VczoBwvRSwWntphZYEKWWayW1v6R9dbzNyRdNYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5uVqvOQo43CxuyD1LtJaPdlhL1wqM10drz2ixZYHpE=;
 b=KuLTSsdI17xaPfjuUuH2smZNPNhAdtdzafXnAGBlAD4K8VP6voilJeDwpn/K/TbMr630xBMhqNdgQU2tXvZhEUoeX2eWDdPNF3BnDSLJHRc/zlhbP9foaTiBvGR1WPyWeRSi/reWGOOFbW0u2V2fyHS840hWx121xNEzV+z2Q09WSgKPCTyi6HV94bCp7r/m/COYbPp35ioKnwyoS3uQHkAglaZxGuoSE5o6k3n9XVVYRamYHhQxz/KtlI2rwGpzkF13C0MMQf4qWAffVwI8vsSN8fYbX0+bGyO1ClbBahPRkKgnWn/2Z8kZUiBS+JdH65zipb9BNcm1CCHffXq7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5uVqvOQo43CxuyD1LtJaPdlhL1wqM10drz2ixZYHpE=;
 b=RrR5nxjPAQoMal0scLg7BSQ0eo/qMe7Z2X4MFV7DBFkyB9ksK/FL0gfe/51CTke0f3NZBL/lxD+7mkv8MspBMO2pcgbgjGMDZglIizwg2PzRHFQE4W4QwAhZJf7CuqLjrSsrk1LY0wzfD4FMQLnnh7OktoLxd8R4kvKZglGXHNM=
Received: from MWHPR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:301:14::21) by MN2PR12MB4335.namprd12.prod.outlook.com
 (2603:10b6:208:1d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 26 Nov
 2021 19:49:44 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::7c) by MWHPR1701CA0011.outlook.office365.com
 (2603:10b6:301:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:44 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:42 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:41 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: [FW Promotion] Release 0.0.95
Date: Fri, 26 Nov 2021 14:49:21 -0500
Message-ID: <20211126194922.816835-16-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f982da-ae35-49d6-3bd9-08d9b115e523
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-Microsoft-Antispam-PRVS: <MN2PR12MB433585E89E374776521A24A3F9639@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIww8RQPN3VgYvqQ4iT/nBTq1UQtp7/DTJRhAUMUUhbBjwGgt7mYbZHPdhgaKb72BjFJDkrvAWpOWTrPHiKpcTvAgHcnaaw8pS93aeCieJJiaE1jZOjQ2AluKytyNuMey+VEpM5RHTd5SOKAdRD7oBKXai07oDgTy2M0gw3kCzKcdCeUqMXewiRW1xqjLtdPzCyRR5hW11l4vaRN0MDyiIttz41C+/X43YhD0L0Epj9tkt1y8yJapjWjvvuGsDNflcQ1dQDDpXKMcCOKGSoul3O3+ft+JOol85KCWTlhhVrLjbCSvNKDWfI5akN5HkgFrpbVdDv9uE81M1rg86Sy9ereZxESdl8czjLYla1XCDZMX3eH8zZw9WyEfX453fpsYLORYRY0u48L3mJ/MrxkWKcoAMhNs2L0KTjZvZ5/1j2IJxavY4cmAPjOgdlT2RZMaSZK6ekmYPhUW2xY+eNcKuLAorPu//1O/ijBCaG0TSmt9MjbPwcB5KIrCnMikVDqTumv8bVeQpZeMy5cJ4WvTBHsVWYhaESeCjU3aR2NHonw4M84O9Kyf1sg6vR0sNg3B1cPzAleB0fPLzZIaK8Z5epMv/U29j6pCfvF1gpc6yNNP6XvZkISRG6nK41RdKoM5P2DgEJyP0cO4FhzN6iB+/qRXCHm2anSFRrYUdtgshLZhdKbFs1ANC1VulpLqcKWvS8ckm7ZFcC0i+94vSVpToOpt75w3Md/mcmnXHTuXak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(26005)(6666004)(36860700001)(82310400004)(508600001)(2616005)(54906003)(2906002)(8676002)(70586007)(83380400001)(36756003)(1076003)(4326008)(86362001)(70206006)(356005)(4744005)(5660300002)(186003)(81166007)(47076005)(8936002)(6916009)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:44.4747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f982da-ae35-49d6-3bd9-08d9b115e523
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 6499e5c790bc..4efced63995e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x465e619a
+#define DMUB_FW_VERSION_GIT_HASH 0xb3a083a5
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 94
+#define DMUB_FW_VERSION_REVISION 95
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

