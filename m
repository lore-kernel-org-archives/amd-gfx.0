Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C354C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB5E10E228;
	Fri,  8 Jul 2022 16:36:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4627610E228
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT2KY78IpBupU/VZK8NN+fXPPQ/KLg1h21yRA0IDQtBkI37f33Uq/diScedJFZFf1sCFO+x/7l6A/Iw5JFXIznHKLziNL2MbJHWKR5kFvVIEw0FefbLPIpB21VwPhVBe4tVfQj41AfkrsMrpDvl/G4KBlRnW0E7HFDCNZpUEylskaus6NQKYL5BkQAU1QU1nPE8n8hE2DARai62xgNYemyA0asgXwuOplV9kbROK6Ahc8X5avUWikgZzfpmPJ0jdWqiH/09LzJEaEkcrs8UmcIdRRo6MZIPA93AdFmxSytxd1m7sqJFhRMDKQMqV1K2BXBOG5R0jF/79zACIg/oKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i05TPqfREFazLhdaDrZE8a5Ulq5ST7Mk8ynFq72wBQ=;
 b=ElI2wEaCdxcYG1WLC/Uc1wwc6nl46bbSLWm1udTRivH1WNafj9eIgLIeZt5rKPtK/1GXdZoDL2in3HCgg1d5ePoIbGhooXdOX8Aj5LtNmPofba4cvMVv5l3uNelNZvTEEOuOpDVGwwwhsjO/Kgq9NNEFpjacOXlCyy9jiQy0o2bau8kQpHIVfpHHK9gvSGaT+zj8D3RyPiov+yVyk5p2UoC/UzfsFta1qlW/+C9G6aJJ6xBtbGDEBu1FKvyM1tE+Vj7v7B9JXaDeSIb5WTQbYgX5xcXulKgdP2+/Tf262vQfmMRUQBLgckSv/pSgW4LgSjkPlStkeppKHtcFqJpyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i05TPqfREFazLhdaDrZE8a5Ulq5ST7Mk8ynFq72wBQ=;
 b=Rl2pDmX8N5ycQv0dBOJ4QEB7im3zVAq4rfZXHC/3AAE/QCB6l32J+eOeYowP0fmZT+CC+xI051J76WQq/0yjybcCqIc5k7Diaf/NMMmpCibsRay9jRRSGpud4c5Mhe07b3eJ6/CzjcBsLao0WDxN1vwikDnxp2dpK7mCzRCkYvM=
Received: from BN9P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::29)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 16:36:40 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::5e) by BN9P221CA0030.outlook.office365.com
 (2603:10b6:408:10a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:40 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:27 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/21] drm/amd/display: Clear edid when unplug mst connector
Date: Sat, 9 Jul 2022 00:35:14 +0800
Message-ID: <20220708163529.3534276-7-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75fb5c07-908a-4400-1760-08da610008e5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5778:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4qBaenFHZAE6ltAeZY1VFfSnH3s9fkL3EMIwlWHbf+uMtEt8AxhA4i+NsbkwIj42XX02WQkbY25D1n/7gZpM+PnMrbxSgX0GHb4tGWwu+niWGSjlBSe5C875yV5On0045z2FiFCL4QQTuU9hRCd17oINa0+TdaHTzBPi6BB6Q6k980y4YQ1Q0E7oKsbCvV0eK3A59jkHDWwZCbFxG0qLj8ukc3prpPBy/+YN4HiLvXqwNFOZkjTheZEQOuWBeqUmTASXlcz2PVyY2THzpW+7cpJko8vHWdZEf50YkLRLqw+8VfGIa9/EUJolBAOGhj08+bWB3cmXyMKwhc6ha2lxI9TbuiwuWBXmy8nDLLzMVK8EotoqGxYhSM8S3CiPQScG0Nk2P6Tel9q6EmdrPht/rpyGZ6UnatfQFXd9xk2O8aU6BEsKIws4JLSfkm/16ycfpILe6Q4jDQ1LJ5ehzIlL5191O6GTH3AKuBM+NhUOEeck6+Cm7UsYzvrj7ZHFxXBZkd+FsJCNvCS89IOM1flxB3OHi5gRJ/RQVkZN1eb8oiEI1Qvm4XgmygV16yqAocfPIBeO+e+OYIhtLNSzbdkAhIruM21jMEZ1chLnIL+7dRdV/AnhqaY4Jw5zvtnoEy5yZpDYGrfio54nviovbueiYJ1TRaxQvfvBIsjC+/nvHvMEhC2BJmOHfJn+M74Qss+RgSGmETG0GVY5ir1mQg/AiJ9Pi1sa7gVNhIws0LwobGJkspzE0iIeRbjp6EK/YSC7Xz8r4s5aVGSSkLpBqMgdO+LohQRVesaRAr5n8Yc8NgsxM8UzCqMUHpdLoItRdHOr5V/4cIkbjxiT35VpF/1dJqZB06ldu6C6ILOTH0urQYno7MACtoc3fjfNmvyrKDY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(40470700004)(46966006)(426003)(82740400003)(336012)(82310400005)(356005)(316002)(6916009)(54906003)(8936002)(81166007)(83380400001)(4326008)(70206006)(36860700001)(47076005)(8676002)(40460700003)(26005)(44832011)(86362001)(70586007)(34020700004)(1076003)(7696005)(5660300002)(478600001)(40480700001)(6666004)(2616005)(2906002)(41300700001)(36756003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:40.2691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fb5c07-908a-4400-1760-08da610008e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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
Cc: stylon.wang@amd.com, Hersen Wu <hersen.wu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
When unplug one sst monitor from a mst hub and plug in the same
port with another sst monitor, we don't read the corresponding
edid. That's because we detect there is already an edid stored in
aconnector->edid which is a stale one.

[How]
Clean up aconnector->edid when unplug mst connector.

Reviewed-by: Hersen Wu <hersen.wu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index ee5d6fa34a6b..8237029cedf5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -160,6 +160,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 
 		dc_sink_release(dc_sink);
 		aconnector->dc_sink = NULL;
+		aconnector->edid = NULL;
 	}
 	drm_modeset_unlock(&root->mst_mgr.base.lock);
 }
@@ -411,6 +412,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
 
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
+		aconnector->edid = NULL;
 	}
 
 	return connection_status;
-- 
2.25.1

