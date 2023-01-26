Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423C2C27C76
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8F510E8CE;
	Thu, 26 Jan 2023 00:36:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F72010E8CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:36:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWgKc0JDUO+1czi/CT1fyk+l6q8mcqbWAzwU4MxQJLmeRrmz40dW14MzeKdY8VsoZRL3usPJljvZAYMt2d5HLY0vE1fAMFW90OTCzorgpGgOccIpSyGRN1J4fJsa360F8aIJnQSq+1GjDWyT3jXTeU9wSnx1W3QZsFFiw8LBfwwo5Gxeet5adnbZJzwtFU62/7/UI/TQfJxwQmqOATudYR5opHIOUrgYeVxqhusXiu8Jc47Xkp4iv9JpEj879v9yA3RQ8N71qb4LvBN7F/9OdtrQf2UdTg29sDTjEIzBRFb3OEOJDcXifYr7SHzK42i/y9vgpPW1+VatwXXXaKlxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRDbKA4PzZlH6TfP/18oRaEq9N1JmbWj1nhO9MzqSu4=;
 b=GAIk363Ei/9zNrCSxtUM1YLmecikBx4xG9w82BWO4YSo+/i3FvD/Qct9P6RII+dP10urrwwMKLxbqrp7W5/V4SOQVy9zUZmxxXz0bL355IZ/KO57kJ8KtIl+kk+8fvh32xakVWgBaTnSFZ1R1uTXqDpxe7xDIn7Hm7RzergIXyQC9D8YiwX6mbdyeoh7NqIDwb2i3MCc9rXmn5MYZCYdxmUTKsa6hKOCndCTMnBWzC1Zomavy6JYDp3sdUQz0EltJ/OXS3u2YzQcaqTz0WAY5JYCzXWTeyuAQDiHxxzSgdLwe2yiPdSi8xDc6OKX7h33lVz7yKhwNe1kCYqQluklhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRDbKA4PzZlH6TfP/18oRaEq9N1JmbWj1nhO9MzqSu4=;
 b=yy19BEZp2bXgM7R4XDilz9HwtOl33/BMGSOA8IQRERBOHyLjCGZiMrveaDukDU2MNLrZ5dGnpyeBix2164BEG2sp9cXVcq/aShxOyKS6YKYWOHWnFuNdwS9Nyctxill1fBrMTTr1f4YoHMHJeuRpSwQGe/t5sDSJMZ77dOdWC7o=
Received: from BN0PR04CA0170.namprd04.prod.outlook.com (2603:10b6:408:eb::25)
 by SA0PR12MB4543.namprd12.prod.outlook.com (2603:10b6:806:9d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:36:52 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::31) by BN0PR04CA0170.outlook.office365.com
 (2603:10b6:408:eb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Thu, 26 Jan 2023 00:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Thu, 26 Jan 2023 00:36:52 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:36:50 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: fix linux dp link lost handled only
 one time
Date: Wed, 25 Jan 2023 17:32:29 -0700
Message-ID: <20230126003230.4178466-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|SA0PR12MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a43902e-51f7-4b87-a04e-08daff356b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMjkt+ca5v6o246Vlc0Dcq7leUxFIAAFAxjlDzKxhH1Q32jN7ULisa1TALq3NM+qlI0KeUYJ70iE10fkT83LrJnMYVXkAo6QZ+v7yx3IUFvq9vNEo8r+ymoX+69iRZpWvsfI/oRVzmNKRmYMOYKVeuSjJaUCpEr170IoljMPGhoHN/JC74pzAUPWSZIAqcW8qFUUMcykhjU91SVAl7ThOYJKN+xtDcMcw2YliV0/CPM08D47K+lV9UO1J8CTgqdwAqIoAC6yr34uaz2XI/Vxy/JuNCLty0szbQKnECWiiSI78z2JFEQVxk7esItUJtK1spsjrqt7QT5YQjqwhm3Z1UziRmb/2MPt3FtBDoiH+TkRfxjhfVnSQjFRwSqX+qgCA604NqjTGZIAL7B34HU0HYeyUuCfC2HQW1eTM1G82YYwN8rb4kfv5q30wcLgWUk7zOInll8rZgPal/SKhMiGuIlioIZLkqF8u6zo9DxTx6H+JbWA5odTlKN72REK7jwmrlPaOUxZqaqw8tPBbz2Mg8saIWyh8Wzq/459/vH6QR70IKOIc6wS8h5sLpA4gEO2I+fUl2CIq/6DYBl3jXyGLwPxpIiVcMJ8tqrIfSLS1OHxXeQgOENbzLUT9eozvBgMBl2ZmOcv+iMlgkLK3AWZ/VDquIUyF9bKyM4ktHl0+PXZa2Y76UmJTJx6BCVVx96h1DffobWLFNv733idlSGwQ8841ubtgqDOGM9mBoSkaNs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(356005)(40460700003)(40480700001)(36756003)(47076005)(86362001)(478600001)(336012)(54906003)(7696005)(82310400005)(4326008)(70586007)(70206006)(6916009)(426003)(2616005)(8676002)(316002)(2906002)(6666004)(1076003)(186003)(16526019)(41300700001)(44832011)(83380400001)(5660300002)(8936002)(36860700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:36:52.2248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a43902e-51f7-4b87-a04e-08daff356b2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4543
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
linux amdgpu defer handle link lost irq. dm add handle
request to irq work queue for the first irq of link lost.
if link training fails for link lost handle, link will not
be enabled anymore.

[How]
allow adding handle request of link lost to work queue
before running dp link training for link lost.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ceeab2cd8569..9e138d48cd5d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1301,10 +1301,28 @@ static void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 	else if ((dc_link->connector_signal != SIGNAL_TYPE_EDP) &&
 			dc_link_check_link_loss_status(dc_link, &offload_work->data) &&
 			dc_link_dp_allow_hpd_rx_irq(dc_link)) {
-		dc_link_dp_handle_link_loss(dc_link);
+		/* offload_work->data is from handle_hpd_rx_irq->
+		 * schedule_hpd_rx_offload_work.this is defer handle
+		 * for hpd short pulse. upon here, link status may be
+		 * changed, need get latest link status from dpcd
+		 * registers. if link status is good, skip run link
+		 * training again.
+		 */
+		union hpd_irq_data irq_data;
+
+		memset(&irq_data, 0, sizeof(irq_data));
+
+		/* before dc_link_dp_handle_link_loss, allow new link lost handle
+		 * request be added to work queue if link lost at end of dc_link_
+		 * dp_handle_link_loss
+		 */
 		spin_lock_irqsave(&offload_work->offload_wq->offload_lock, flags);
 		offload_work->offload_wq->is_handling_link_loss = false;
 		spin_unlock_irqrestore(&offload_work->offload_wq->offload_lock, flags);
+
+		if ((dp_read_hpd_rx_irq_data(dc_link, &irq_data) == DC_OK) &&
+			dc_link_check_link_loss_status(dc_link, &irq_data))
+			dc_link_dp_handle_link_loss(dc_link);
 	}
 	mutex_unlock(&adev->dm.dc_lock);
 
@@ -3238,7 +3256,7 @@ static void handle_hpd_rx_irq(void *param)
 	union hpd_irq_data hpd_irq_data;
 	bool link_loss = false;
 	bool has_left_work = false;
-	int idx = aconnector->base.index;
+	int idx = dc_link->link_index;
 	struct hpd_rx_irq_offload_work_queue *offload_wq = &adev->dm.hpd_rx_offload_wq[idx];
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
@@ -3380,7 +3398,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 					(void *) aconnector);
 
 			if (adev->dm.hpd_rx_offload_wq)
-				adev->dm.hpd_rx_offload_wq[connector->index].aconnector =
+				adev->dm.hpd_rx_offload_wq[dc_link->link_index].aconnector =
 					aconnector;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 85b57848f5cb..64d5d9b28ca6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -433,6 +433,9 @@ void dc_link_dp_handle_link_loss(struct dc_link *link);
 bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link);
 bool dc_link_check_link_loss_status(struct dc_link *link,
 				       union hpd_irq_data *hpd_irq_dpcd_data);
+enum dc_status dp_read_hpd_rx_irq_data(
+	struct dc_link *link,
+	union hpd_irq_data *irq_data);
 struct dc_sink_init_data;
 
 struct dc_sink *dc_link_add_remote_sink(
-- 
2.39.1

