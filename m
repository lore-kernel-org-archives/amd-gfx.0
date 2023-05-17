Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD4AC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAAE10E3F6;
	Wed, 17 May 2023 11:39:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EBC110E3F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIFsIYTNqHf4IgqfeS+64QU7JQ0sD6Vc1m6SUNtWEBSF0vswef6IaOkdivDaUZ1N6G4BhujTnclO94P75b/zibfNHfYm5c6L7yjmf33/HuYtn6AHxO55Do4FeGs6xl8CduzjCQqW3YeAO1krHhUBPCugnXgPc6oBbDzZ8HPfSWoV1uH3z7re5q5JuZ8OiGw0GY0y0gmP5Ea7CLAApaZByEMF3s5MycLHopsYZsavbOvfHKeGYCPiuwUryXbt5PQUmSCiizfCPEcoNbgHDuQznh0u1IpWdunY2HaHjKFMF4YVy1ttyH6HiRN9eRwRqOez5D8WepnZl1SG87Y3WVQUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtWI5TFZn+Rd8yow5mfRNVqpaZdmtIIN1DKvM3IoZaM=;
 b=mZEqpK4ENtf+HldBzbKxXY9PkiW7o5/I30qQpMLQtRN2rtvT7Kn1eGe2Bl477/BB/DL8bzh6yGdBDJukz5hMNEdJPzZKEG8tFvvciEWIAkH/BUNb99tT8epIDJ8YDA2J7SUriW0MVPMyeR+7n7jGb/0LoZXuzjRMdTiIZNh5sRhG3FZIoVIwtRe7JgGluwEupDQCqr8V86DTJ5/651YWkLhTGhpW9JGaXZbnJnxzZ75nGg+D5Ea5pZMynNCQV7xhahgGq0lAyPRF3azFwPxQSKE3SqlLJPVhDnqllE7m/jSJtuQG3XHAd0nsz9jmDaZ7OH95wBMxCkjw/OAEg2gG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtWI5TFZn+Rd8yow5mfRNVqpaZdmtIIN1DKvM3IoZaM=;
 b=HdSn2Q0rcsCsGquFTz86jm0+CuBb0htS3lJpjz/zC4Hx+84SLx3P66oRR4IqbeaudPwzIL514D6ywN0ePX+1zpENwEB3W4KggnxyjakFr2llhrzs9yVDr0d45+1JbiEn/i6VelLLRIEslTkwgsBEhLcImo4AqV2dAKG9IjxsIf4=
Received: from MW2PR16CA0060.namprd16.prod.outlook.com (2603:10b6:907:1::37)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 11:39:26 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::33) by MW2PR16CA0060.outlook.office365.com
 (2603:10b6:907:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 11:39:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:39:25 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:39:20 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/18] drm/amd/display: Have Payload Properly Created After
 Resume
Date: Wed, 17 May 2023 19:37:13 +0800
Message-ID: <20230517113723.1757259-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DM6PR12MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: 137d8204-2498-4161-ba84-08db56cb5e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kX7o2RBlaB/lnE48lwkDyQeNArDfAckbMhgJl0CtfK34ZKr96ZTSNfQSJex11t27SmABRlOWZnP//XFAr8a4HNLflIRzrpOg3h2wvriooiTp/o5eyTjzPHEdStdmyon1uHo3EXtJ2DDN7+CWavgDU1sNSUEvZYTPcUJwDvK8JpWjTqoraJjCeg+VbXdmiZEBa4iMddVqBPoHj+KtxgJ1Fy8fhrZqTyI/htFC26ck0bKGgPRQQ7jWswdyL/NiYEZUqQuG1UJGg2kO405Y6KfB7+IX52BdDAj/oQGHVVsgHQRu9J7V4cOIHmfvNbR43tuKf7osU6RjK7gcW7Wt/w3LuIeMGWNw/rVy+mh4fnsMuB+hw6x9MiwNuam/0VM+12zenD9CpcZebarMlx/1WzVC1RdrviTLkPByoTr6jw3Mg5XGLhQKi31Z2YPP7PSq0d5oygpnwfKw/ta/sxhuxdXlvaWNynXhkERJWx/agGMP03tmI35Wg44Z85dnLYwgSFz6G0SZGYkDZG8UR9NoDnmQPR9Sg7uk+oTCuE55EJix8X3pfyj3uhIoVEvMyIIb4KZ92RdSmYJ1Y44LGMgvZt95M7gbUcbbnfwAOAtZ5ypnVOUP4bTivxlBZ4tX5vqTWKshouIV9mDi5GGJft+vQo1b7dBL85HDdpr4vTlq6xx/mA3CR5XUIdfCeaS1e0FDxcHRhzwQtZLr40yBuKg8Mfk+LQGBGI23YJmFVGRk3g+wOH4Vpnurcfg1mTTQUI3wMxKUkVfF1ZT7kCrmwCqD+IxjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(6916009)(4326008)(70206006)(316002)(478600001)(54906003)(36756003)(86362001)(47076005)(83380400001)(1076003)(426003)(2616005)(36860700001)(26005)(186003)(70586007)(7696005)(336012)(41300700001)(8936002)(8676002)(5660300002)(2906002)(6666004)(40480700001)(82310400005)(356005)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:39:26.1694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137d8204-2498-4161-ba84-08db56cb5e46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Fangzhi Zuo <jerry.zuo@amd.com>, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <jerry.zuo@amd.com>

At drm suspend sequence, MST dc_sink is removed. When commit cached
MST stream back in drm resume sequence, the MST stream payload is not
properly created and added into the payload table. After resume, topology
change is reprobed by removing existing streams first. That leads to
no payload is found in the existing payload table as below error
"[drm] ERROR No payload for [MST PORT:] found in mst state"

1. In encoder .atomic_check routine, remove check existance of dc_sink
2. Bypass MST by checking existence of MST root port. dc_link_type cannot
differentiate MST port before topology is rediscovered.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b8e0fc189002..5d34fd0ca777 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2852,7 +2852,7 @@ static int dm_resume(void *handle)
 		 * this is the case when traversing through already created
 		 * MST connectors, should be skipped
 		 */
-		if (aconnector->dc_link->type == dc_connection_mst_branch)
+		if (aconnector && aconnector->mst_root)
 			continue;
 
 		mutex_lock(&aconnector->hpd_lock);
@@ -6776,7 +6776,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	int clock, bpp = 0;
 	bool is_y420 = false;
 
-	if (!aconnector->mst_output_port || !aconnector->dc_sink)
+	if (!aconnector->mst_output_port)
 		return 0;
 
 	mst_port = aconnector->mst_output_port;
-- 
2.25.1

