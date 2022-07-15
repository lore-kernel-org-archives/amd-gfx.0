Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3364AC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A329410F9B3;
	Sat, 16 Jul 2022 14:37:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B72C10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJC7n84EKB2hhGvtX3mAg9Et85A0VJmZLuZ56HdnohZRMI6TS+uTgaXRjWH/cSrleX9HAmFRDS3jSQrN9MkyKxZ4BI40ELQ9OcvRqdyveUE0I4IovHxjCXvN9MmWn4vjPMU2HvpyDraNooiSLVaSq8BiQKM5dLzEEEKaUGW2fIu4BvEgTCr5R6hyRUVgIEoNuV2y8eNNbCvV560l4V97C1cKzEAQ/xIXtuJM9b1pf2798WeQ/qvVDv+mOoXDoO+aClaDikQCXprDeBDbVAT4IjY2y9RVbmeSJpdvDC998+loTaGhzMuhFPVIDQHPmzt533ozB+FLdN4w4ZWayvPBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veuGJLis3M3cTbnOIsi/ghaLx5Dh+wZgtBbo6QPYv04=;
 b=HliZy3cWlcFGwLoCHGPYqPvuchu/CVVos6+sPDY5Mni4Js9gZVbCGuyg5f53AQYZVe0TaCCP9eS3tkV5mW543Zi0WYspBz6M+t4lihaLvf370MmmCzR/BnpzqWVUZaYGozRWNvC1olJoY/MHPsgEX07Adj2mGqtP3eRnbv1E57cZWN685IUIrAejQ+qrLbzNtAqQGyu0RM5vXRzR6q1zSG4SuBufTz+E09Lvzz3q5z+Ylm4631/EwKfQgmY4klzuKJoPJ38m7lfsARTuWRTHb5AHQx3PlvDzZcw2DWLeb+VFKtSB1oJ8Wj1mT6Hu3Kay0h1HfeOojcjQlZFx/hWeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veuGJLis3M3cTbnOIsi/ghaLx5Dh+wZgtBbo6QPYv04=;
 b=FvMkCP5irvLYiY0ENqxD6UQ8V7fmGShPj4zRNkPjMcjWyJd13EVx0/PClBphn0VtjU6PR9BOE2RZvAch3O34Q6rJNAmfRx/5Nxoxcjq9MFsl/u/phr+ztt2KC9dTg9aetkVv4dPYA2m0EEgqwUdsUJ0peRdjH99QaTBKWgux654=
Received: from MWH0EPF00056D19.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1a) by BN9PR12MB5130.namprd12.prod.outlook.com
 (2603:10b6:408:137::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:17:24 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by MWH0EPF00056D19.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.5 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:22 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:16 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/31] drm/amd/display: fix trigger_hotplug to support mst case
Date: Fri, 15 Jul 2022 14:16:39 -0400
Message-ID: <20220715181705.1030401-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e73f878e-10e4-480c-8886-08da668e441d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLO1QSPDf8W3j0+TRhfKhOHR9yWcQlKHA2cXbL0lKwmo4XpShZqIkGAgWvTj4jlg/J1xc8enhXtNk0ScoFC+Y+kGnhOe0wwXLlHczSg+RD4bgvHOQbu0hIpKOfCfO9PnQ8rppFrBV56kUGD7A7+MZzY7Sj1eM+kuO7MFSU92J2pHU3QGu06PMGeg+WSN2p2CFySgihZVgI6WCMtC27ZDLpLvC7Ps2jACrPVuS1G0jL5JLdVuWAif2SRRXzTi0YzWRiSTah5rtWLQxJVAyuIcdR24bDeuqkuuy+xQkADt7v9G/t4pJ68e/tUa0HR/pdtLNg2+/T3tEDrMs8f3jpNtXEqXHVqsIdJYE4ZJTQXDhr87mFcWHgXkCn/8Vf516TXlDvQoX6Pz974WpX1ZX+/YzYIu4cXg/bukjBbeMCEk2Hm7ReJSwKzVh/IB0R09xnXBi1yxD73jn8zYlDUMbXL/e4h2CuNryul50Y9K49EbBgTSqWVAQZHfidv/q5mG7SLLqHiLrjGLIcEQEefPGqwZ1jGEXYwrki5Km8oaRjQkjui7vQ7POZi+VDwAdoURCyQ/ivohbxo3HFcbYeTzOoDZpV14rxqH+S7Tt2YaHwV+9BVDoBbSzU5pPtSlrrb0W0xdTDendv4IgePJd08R3hAiel1sr+/PpFft/ya1w5ga3I6qmMXMqj0jcqwFmb5+zBc8WELxE+YSOkbWWlWULEOKXuNaaN2K6XKdHLSurgdECKA9Lfq4r05ELG9GUEYKYdxQ4Zw0c0R28O83Fxgdixi4cYCIxBBGbg9Qjn1VxG6l//PamWib+vQmcatWvqsJz8bKB2QrRxSrZQig3nukEuJdHbLa4IR7ueXZPHaxYXVMB6c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(40470700004)(2616005)(8936002)(40480700001)(2906002)(5660300002)(336012)(6916009)(6666004)(26005)(1076003)(41300700001)(426003)(47076005)(186003)(316002)(54906003)(36756003)(478600001)(8676002)(36860700001)(82740400003)(356005)(86362001)(4326008)(70206006)(82310400005)(70586007)(40460700003)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:23.8646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e73f878e-10e4-480c-8886-08da668e441d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Correct few problems below to have debugfs trigger_hotplug entry
supports mst case

* Adjust the place for acquiring the hpd_lock. We'll also access
  dc_link when simulate unplug
* When detect the connector is a mst root, call
  reset_cur_dp_mst_topology() to simulate unplug
* Don't support hotplug caused by CSN message since we can't change
  mst topology info directly. We can't simulate that
* Clean up redundant code

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c   | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index e0646db6fdbf..b764198eca5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1273,14 +1273,22 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 		return -EINVAL;
 	}
 
+	kfree(wr_buf);
+
 	if (param_nums <= 0) {
 		DRM_DEBUG_DRIVER("user data not be read\n");
-		kfree(wr_buf);
+		return -EINVAL;
+	}
+
+	mutex_lock(&aconnector->hpd_lock);
+
+	/* Don't support for mst end device*/
+	if (aconnector->mst_port) {
+		mutex_unlock(&aconnector->hpd_lock);
 		return -EINVAL;
 	}
 
 	if (param[0] == 1) {
-		mutex_lock(&aconnector->hpd_lock);
 
 		if (!dc_link_detect_sink(aconnector->dc_link, &new_connection_type) &&
 			new_connection_type != dc_connection_none)
@@ -1317,6 +1325,10 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 
 		amdgpu_dm_update_connector_after_detect(aconnector);
 
+		/* If the aconnector is the root node in mst topology */
+		if (aconnector->mst_mgr.mst_state == true)
+			reset_cur_dp_mst_topology(link);
+
 		drm_modeset_lock_all(dev);
 		dm_restore_drm_connector_state(dev, connector);
 		drm_modeset_unlock_all(dev);
@@ -1327,7 +1339,6 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
 unlock:
 	mutex_unlock(&aconnector->hpd_lock);
 
-	kfree(wr_buf);
 	return size;
 }
 
-- 
2.37.0

