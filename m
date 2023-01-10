Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6130AC61DB3
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26A610E629;
	Tue, 10 Jan 2023 16:59:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F02A10E628
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVKtycYCtpcan9uBLFD6I0WvwMC9aUVyLP1DLi1TRN8UyLjr6RNjBG54MUks9RsV6OX5/S0oNGYFfgeOShEkQjFdE0HVLS+WXujaOhpjx5qwjkGKpE6T67pN9dsiMwelRaM/S3SenBAeyTQiFZxaz4xoUFP7uAFrxrn+wjtbJ06OgsUpXOWa2GdTt2y6uqOJ99e2YUZspkZe/nX0iwebDVGYIDZz0iCKzE+ACVlfyCf2TURsJ9Al7tIqeKps7Zr/UxTR6Ecc3l1O6PHxPPlfX4d22MtcTqNnrT+M+weqVZPN0HPSCSIwgD5jOpfC2lfI2vFIMmoGz4RrM+H0dGQ/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV9DIs70n34Vew3f7Htap2OlXe/RijfIsqVyLKSnmxQ=;
 b=XygMFEETU/HFG14WcUgijJM9npmU4c0hhGnFtEISJaJUwg6CyD4RZg0B9lRCKkHegwH07AZvay/xaTCMD85o55JankZnuAsWKFkVWed5bZusctTlyMTarXg+2j+eqD2Uzlp129OwipCeFkL2yEYvuPl+rISWp4yGze4c7qoeKBfanRzEcl2Wx1FDgu2vz+yW6fAtZ7YUa/lJmsSZ/xLFwOAcRKfzMDmK3Lk8S/l4CZJIRMk/uF/csdfoDZuVCrFGv3/Mf3YDAh8HcwY8hE4eCJUr001Io5+DrsSVsUk53sQwGuO/KXkjpTy8208ahJl2IFXH933VdAToU81B5PieiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV9DIs70n34Vew3f7Htap2OlXe/RijfIsqVyLKSnmxQ=;
 b=B/nqjbiro0Bug6CHE3K19ogXz47vMWVMQ3alVS/88MNmNJ3bOSfflHfBC+S09K1jbhkpqaB0nmUjcKdXJt6qOd1l+EaivB8wyJs72yv60L9Njx3Q0LYG6Q/1JFVC7BtSyA8lp/hkn1sgrw13sHDUjBCFSKqB1G4fppBqFJI1zxk=
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:59:03 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::2c) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:59:03 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:59 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 36/37] drm/amd/display: hdcp not enabled on connector 0
Date: Tue, 10 Jan 2023 11:55:34 -0500
Message-ID: <20230110165535.3358492-37-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1edf5c-ff67-45e3-c971-08daf32bfa22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAxjdTrWjO/zccSj+YZbCuToxJJAgu0kMzcpERpd3IsRwBHcx1If+Ie56KETkNDNuuNfENjgFA+Il8LmMGF78+1wEqt/TXkWG9j6OOIvBj9K7N1Qec6dkvdFZPFE9sJbKlt+pK82h57zaBmVvVjL2ic/11L4vd8yZ9V01YFabqbwK2/pkadngHeVaMToj7NgU/77Uw1VnRVFVlywvWM/7QXMfeN29BT41cQNIANIGBsknPmsGKmfOU0SrNzv+tpQpNvloPxI7WUkRkaAAtghye1eaewCxHz7iu2h3n/ie55ziTOsuuGRVxNLAUEz41HF+HS9w2dZrJwIfBeaYQGDclVV9PwzOknsLz+8Kf7xvt2j4648A3OlRZ4SmvlE+zqn3sAePL4mksz78Lg84od6BB17rEJed5UqkIy4Lug+9i720ErWz2fbNhQ90NpkLm9MUs49NuevicwiJIu4vQnmt2mZb9tRkW40k/N2mEAVsd3BFfoRskDn06qbq0sVsURvaOu4VfBSXMb8eHBoMrGG11zOm6MGOz1REMWpKxDQ0O+JFayRleWSkJHyvuxCfST4gULhd1dCBpYDbcyJn81s/5iU66O7UDphMzP90xoiN4Rgt+yrBuNw3mFt56kD2we33ijYc3Et5DwT90V9WdB7hTOOuIBKdODLwio3vYYvJxDoLInooDJkiPIJe79s//zjlopZ5Sun9JedYK2tDQjZUDBo5TP2hhzPH4MsK551hEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(4326008)(70206006)(70586007)(8676002)(5660300002)(6666004)(36756003)(41300700001)(8936002)(16526019)(26005)(186003)(40480700001)(356005)(6916009)(1076003)(2616005)(54906003)(336012)(81166007)(7696005)(478600001)(40460700003)(36860700001)(316002)(426003)(86362001)(82740400003)(47076005)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:59:03.0667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1edf5c-ff67-45e3-c971-08daf32bfa22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
incorrect skip when drm_connector.index = 0 within
event_property_validate and update

[How] handle hdcp validate and update for connector 0

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 0301faaf5d48..8e572f07ec47 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -314,9 +314,6 @@ static void event_property_update(struct work_struct *work)
 		if (!aconnector)
 			continue;
 
-		if (!aconnector->base.index)
-			continue;
-
 		connector = &aconnector->base;
 
 		/* check if display connected */
@@ -390,13 +387,9 @@ static void event_property_validate(struct work_struct *work)
 	     conn_index++) {
 		aconnector = hdcp_work->aconnector[conn_index];
 
-
 		if (!aconnector)
 			continue;
 
-		if (!aconnector->base.index)
-			continue;
-
 		/* check if display connected */
 		if (aconnector->base.status != connector_status_connected)
 			continue;
-- 
2.39.0

