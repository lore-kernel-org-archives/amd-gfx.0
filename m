Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B623EC4321E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C6110E27B;
	Thu, 24 Nov 2022 21:14:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F8E10E278
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3YC/LS4b8GavFm3WoKRSYgXghXH2T/L/2hiLPfM1pX0YesXjYGPoZXnjF/qS3VGDlutRhMjorP1QGmOp/Y9yqBP5sGbA2g0NsCgQlRgxHgtlXpOAxlF5fzMDT6OdN+2kiFZeOD3/N5oe1gY6Lih8mlLznRyTaXoudXr1H8tPB4tt/+MtE2hs4wJXubuFL9BGvDiKXJPRTDCB1SwIn9GPZqEaDWWUBHfGlEYPJzZEGndA8ttNenUWpWH+tpQiN/dh8gdDCwQyHH1dzSWKPlqOVu5jPYPLqUPKtFaxxvhcf2q4EL3xJWpvIkCnv5AJoliewxmxsGS1kGUoPfR2WEcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M78TyRAaP6wQqph2BpqZkf3Vt04mgS047YGvJcH+BuQ=;
 b=DOTDA3/CanQHxQyiVZAt01O26kDhB9SNIpFcaIoSDRZqBFKTE9DklESIE/xNCEvsemRODNd9bBdBuegEFfEWR6MH6FPYYYjPMVbDf4NOZ4KAoLE8USIZQr9Mct3nyV6EbjnCHnOGpAVo1oVkj6envFLWwx2SCpWELyxgg5ax3BW48ALx26limvf+O70uHv4s7OvjdxeHSpkN/gN7YP4oWX9ps/EO8t6xWwMvC+obw0FV3IijlkHAoFKTLrZpZZngoVKmF1iAh/WncNsXrg9sh2Luc3uBnMEIajmQz5Oa8TFrr+atNdh9cGn9srunUC3JoDy+CdlVuY/hGcta0KJq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M78TyRAaP6wQqph2BpqZkf3Vt04mgS047YGvJcH+BuQ=;
 b=mBXMXw2V+nF5tGEVo6X7YiCQf+hmJkUIg6+QPJwy2DpydL6srCoHglS1N/K3yzwhW0MDBxSP4fFV2TsDeGnkapPvROicQ/uGQMwRZdB1GukONp/30oQiWaybQt0MlddrvWj0Cf2baJ31gCWhta0kgyQm3LBYiAi+bdckgM0UKcw=
Received: from BN1PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:e0::23)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 21:14:16 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::71) by BN1PR10CA0018.outlook.office365.com
 (2603:10b6:408:e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Thu, 24 Nov 2022 21:14:15 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:14:12 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: 3.2.214
Date: Thu, 24 Nov 2022 16:13:48 -0500
Message-ID: <20221124211348.214136-13-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124211348.214136-1-jdhillon@amd.com>
References: <20221124211348.214136-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af6b833-68d9-4ef9-de59-08dace60d798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIPlbnfcVTf3v/wPV+Y71wEa91ueOC7eWYVOW0D2E+xNlpos+9BjpeaiHLvhsLbWiADbe9RCIHzn2sFDgQ5gUs+9ubJb3CsZ6a6eiHOfUG7efYTc9ixkFDA1CS2DVDv2cgpsFdXdFJdRj7BlE3iO62fn8Jac6CY4SWxtO4fiXmheW7agaAmk1bz7wfqOuI9a0MzRrX6jFFOtZi9LeyHVUQDcyPGZCUA1bfGBGeJucpG6LW8gx0kQWwAN/pbmwGvpYw/iIpO8vqQfigAXANeD6Apm+XEIbMQlIalHpuSn9ciPB/73XbcyhXdZG3C6BRWNSXv7C8BmvisgGkGfPxdLxP9ZjOy2ySkPqcEysnO1KyoNfAQ6hvDIP2rQrTaaBNtbXmGcKLaYoVhqPEWYBCEvZ5KGwzuaC5pFbVqS2nW5LRRiCNdkym32JX3nEStE5VDAMJlyzzc/dnUhA2R4l+JQegfJwsy7L0+tcxx0cKicXcsC/eiU1xfI9uF/6uH3isGuOQFJrxTXe5wurG7g/olIHFgnfHLtNRqdPs0MRDurxsu4RDwXZtAqfzqu4wUR+qOx2yKTf90cP97cp7IJFKxU/PmDe1jjGpilXUkpum2+NO7zkX03PotAjzg+WzcWmcnj+AbG3UaGOnZigDoGerxyu6fiFTMG44vXOWPbTy7+oOZsRYfPR5u1/k+ajoW7LwBfEUTS68qSp0G8EztNY0uDiRhgQKVrDkMTYEvnQXLZLk8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(356005)(82740400003)(40480700001)(1076003)(81166007)(36756003)(54906003)(40460700003)(6916009)(6666004)(478600001)(8936002)(41300700001)(2906002)(70586007)(316002)(5660300002)(8676002)(4326008)(70206006)(26005)(82310400005)(36860700001)(16526019)(186003)(2616005)(336012)(47076005)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:15.5179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af6b833-68d9-4ef9-de59-08dace60d798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <Aric.Cyr@amd.com>

This version brings along following fixes:
-Program output transfer function when required
-Fix arthmetic errror in MALL size caluclations for subvp
-DCC Meta pitch used for MALL allocation
-Debugfs entry to tell if connector is DPIA link
-Use largest vready_offset in pipe group
-Fixes race condition in DPIA Aux transfer

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a19a890f1d76..4a7c0356d9c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.213"
+#define DC_VER "3.2.214"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

