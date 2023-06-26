Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CBAEB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 17:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0788E10E117;
	Mon, 26 Jun 2023 17:41:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B00E310E117
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 17:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4XEDa9GJBb6tauIrY2HkhBuK2D2OpR8Cf+R9gOrSvfCyUEnP03/R6zCadMjukBK7zUG+wFthxIgEfPtUW6IvT7qBTdGebP2W+6VJFueAxu6PxPKT0UkVgsxjiHtW/9YqHEDL4tJCHKu3vAl4kt/dRMZst/ifciaO/5R7mXQTpKBMnwH65hne5J01TbHzgcRglj0y2eQP6fOOvmL8RhrqXN2iv04Ingj+zodpW+nJLJ5ssrCnZRfRCmw8c6Ja7MvNY3ilO6CFCwv28pDlfgdQu6IZvKxaK5WMHEKjQE/WxMpO70LjVpqtUOCwUVdGYlJ2QpMcpH9Ng2DUEmbFsX6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwcWVSYBefsdaN+pmAsez0jWFt4L9BVdSrJtOrNwiT4=;
 b=oEKqJyFsTFcjUZRNYaaVitu2Y1VrFjM0NMCrwWnmvLJQH+dZppWlSGH0OAubyys3SR+Rxgwx0b1lav1vLB7fj7XEzK8vXFSZlPO+NwVMFTLdx4TNFy9ZTsX/Lr4QFs/mKTGRSdDDBt9Ks32SmpMUIvoqX5ec7xyaKZ6IwpNwAdn4aHgAHKVP3+UFWn4EtFQ5JEJnx2hHVS3gAlYolb9pP2DcwM71Xf0U/3Zv/gyXMxjBiML7VesX97Lw4S8dTlzZ0IldnSIikFOfdHIR39pgSF/uPKNZnArC2bRx0zNRRiK1+O69AqWXNgN5YdtOrLmygGA5xkScsAMpeMreruWtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwcWVSYBefsdaN+pmAsez0jWFt4L9BVdSrJtOrNwiT4=;
 b=BbODjciWt/lcGj5qNWdm6R6fnrA8Ul2A/SQQ0SV3HohMb9w00eJY4njDRUzWM/Iapbcb+AZBCXJH5feoB4n88sebhAVui/vyfdYix8xeB9U0A2y+v48Ik6SdvpmLGVXj6hw9m/wn2DJgj1EsvCxLUm10lmrf1GbUFg2y2beVlFU=
Received: from SJ0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:33b::34)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 17:41:01 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33b:cafe::a6) by SJ0PR05CA0029.outlook.office365.com
 (2603:10b6:a03:33b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15 via Frontend
 Transport; Mon, 26 Jun 2023 17:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 17:41:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 12:41:01 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 26 Jun 2023 12:41:00 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH] Revert "drm/amd/display: edp do not add non-edid timings"
Date: Mon, 26 Jun 2023 13:40:58 -0400
Message-ID: <20230626174058.1344311-1-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0d10c3-9193-44d1-5920-08db766c8215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m40wvn6sH26uC/npIbVgLA7+NA4JjxmPLIyLQfOqCwWASXJVoYi/yBxRD82X//EeK8U8NBqsx4jMXO2uyoK0xEwsemntPdh2ySq1OHV6oeHIn36SdZ+aE5i6ROVjkXoVlnGtrIeUjpGQrGkSopkrvogD9bO2b1qkmFiqMhFWXdDZIaxIT3N0NP7Auydkrf1mPP9pJRUruN7bOTHEblLRoN5h1OSXf1CgPhDgNLK9FM7I1QqS1oyF/a7VEKN6NnZJFPCFw730uyR/QFbPsn5SUu12jX8KFD9JuhmKPemosHmqS5RpdYh1uHKtrJhpkcEr6RIWTXMLWEzoBElxSJuwT+ambTnhA77gb3KsC0DMs5XXv2JjcC1Z19hSjT4h5fAnQHYvTCgb/pPMdjd+A51V+7tSqfxEe2R+gAWFvctTEdmVumfyMaGTQz4hmuTSaj8a98l7pstOjcf/Q/kryoUHG94krsp/qnJN8cxGEwDym0Wts3u+ukAPRQhrrGpcPtLwSMMU9fQBM4nQlXFpQW8zUDl9YfgnAgBtO6hF+yANWwIxKVpHYX4q6XiLJUguZECiK/9ONWep9JKJ22Tpw7jeWbsSJM19qVBSLRE8WEE/ABuhNIpb0HbDbpnpX+7RP7yjShxvpRq2o/ik+/NxWecqdBZok93YUeQIUfi6iJBvajHs7xkIMBx3jd32mC/EdMBQ8w+gapjSqajL7PbHOetOE+QTFaaGKBX08943rKLZxY7o3Kvm1AOA5feUfNRtJa4w1z3wJY5xMoBkRfyikEN76w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(47076005)(336012)(83380400001)(110136005)(426003)(1076003)(26005)(2616005)(478600001)(2906002)(186003)(5660300002)(356005)(40460700003)(36756003)(70206006)(4326008)(81166007)(316002)(6636002)(82740400003)(40480700001)(70586007)(8936002)(8676002)(41300700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 17:41:01.3258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0d10c3-9193-44d1-5920-08db766c8215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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
Cc: Hersen Wu <hersenxs.wu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This change causes regression when eDP and external display in mirror
mode. When external display supports low resolution than eDP, use eDP
timing to driver external display may cause corruption on external
display.

This reverts commit aa9704d5127f06c9ffedb0480d2788b87fecedfb.

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a46b8b47b756..073bf00c6fdc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7258,13 +7258,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 1920, 1080);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		/* most eDP supports only timings from its edid,
-		 * usually only detailed timings are available
-		 * from eDP edid. timings which are not from edid
-		 * may damage eDP
-		 */
-		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
-			amdgpu_dm_connector_add_common_modes(encoder, connector);
+		amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
-- 
2.25.1

