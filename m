Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087661123D9;
	Fri,  3 Jun 2022 20:12:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CBEB1123DC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQGNHLJHD17KEsy80nVNFM3BLNn+tXcCuQwcdOuwNpFIfbnxLVcpzWFMPSfigaRxNy0UtL7dRUsA4EonnHAbDVr1y+IrnAn91cNKQwzFhuQfW16Bu7YKg2nLCACNSHYxdxPBCTtAT3jE1VvuwNLWxr3l0hbLdo+6KPF5lbLEp5NvcoaQ+RVH2gBD84t5pmTZwvtUscUX6eKpa9ArcZi3EHvY+FBO/pxfcuhAsD24Lxg591LbUkBEpP2FIpgb/t79hm4gy2nYTxr37XPe0tTeDiC7hcBbpuFB2jNe6fXiTLLzHE9eQrEjR78OD+LM2H8ZTFHRjj0BfBslZizoXujk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41sMvF2rBkiXEwspAwGSHLeQSZUJ9j8dJKlSg02iUOY=;
 b=WE5mJM+aDHA0CE5ykCG7KdUOpjZ642WvqPrsV422BwfAHLmaaKu9S59LnKgh0A9Ht5wJDk/Epx/0b+Md0K5zZItjg3TUnIa75jXeqb8KTakaZE77+r93MqquQl1QVlMpTYdIl0T2Bts+c5G5wU53Cm2uWZ+2lPxZUW5F0Y09/tfAJ8ZYFEUhpCTbXx7NAjZHG68qQyHDawCnuTNvHkrgWZAMYtOHZ/Uoj9WMIen9uKTBlsQwu/ulhtzXBkl3f8AZpTNWnj6QCJU/vSmM0uhYY6rfLzpgEvSAt8yXXKoK9N1kxKJp/umn0zGK1eCR72ajOKdrc7vvUvjmqPthJgl+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41sMvF2rBkiXEwspAwGSHLeQSZUJ9j8dJKlSg02iUOY=;
 b=3XM0TEV9dWFHy6T9QPAxuTXyccs/yg/4g/xIL7eu08lEiScOuzFUdfZ5p5dlZuM81GRXoaInTZXhVhUbmnU/bx9RAQYC+nLWYjR2uRcLg7VW3Mr968u15srmVvhqPzviNULAxbxTHn46463CqBpWWYeVJ0lwgF06BCblxNnw5Yc=
Received: from DS7PR03CA0144.namprd03.prod.outlook.com (2603:10b6:5:3b4::29)
 by MWHPR12MB1133.namprd12.prod.outlook.com (2603:10b6:300:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 20:12:29 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::e9) by DS7PR03CA0144.outlook.office365.com
 (2603:10b6:5:3b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:29 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:28 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: Detect dpcd_rev when hotplug mst
 monitor
Date: Fri, 3 Jun 2022 16:11:33 -0400
Message-ID: <20220603201147.121817-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60de22a6-6655-4a39-eb74-08da459d62da
X-MS-TrafficTypeDiagnostic: MWHPR12MB1133:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB11330E3564BC50EB84588681F4A19@MWHPR12MB1133.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LICcijyilxgS9Nzg/DmCfyJEDGCtAN8gYxu/NTwiYKmSRepA0x6/2CPZaBActlg09z77BM6KclKK3RR04X7H9fw9gq8cC2pyG0CwqAlMABUviUeo+UcBD158FWRnmq58zo4Gx/DN1LeWSZgqjw2AiqADTlSfMGOv/BwacbPYeExUOZuiirO85IWcJM+fb/IFoeQbpiYk2/PZdywzQqlH9nXMg7Xiawo2FLFN1hxAz1p65C/kpbaW6u81SZZYIzas/3mdRZLRAkW6MfXFDNimDpNKqsNYo0BA4xt+6YqlYUQ25rHN/Vt4HL/FhjjCj49s3ZJ2VpqrPZmOaEhmqN0yvQ4hQe/BE7D1lb98V1yBEHDd+0WFvvp5wytmNZ+XN3QG2xxQixVdHaTHqmi2e2d87cmzGpk0Gmo/MvXdxICdXX25y5mT6HzsC5Zxysk7zdyZtNBlMkWG+PbBQk9s+FhSM6BUa4e7Pnv2IEnC53/qki3jqi9e8Xj5xiLwUYgoTUueDQXmWR84UFaJTVuk5tjQ6gRwzwoyKALZHgzBsmO/O4wCBRia53Ig6fkgw5zR9JM4Eod+xU25fqDQcLU3hHuRj59JFV3D87H/ufkepYCXWihFE9mixGwWS+TYzRYtCYa6nOfikJpnQVxzhNiRQb0sirRn3yo3mpdbqXLAkcG5NvE0Hdd4c9wXlD4ByWXJVQyxO5A/DsGi3LkdNgveHWMJ0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(6916009)(54906003)(16526019)(26005)(1076003)(86362001)(2616005)(508600001)(316002)(47076005)(426003)(336012)(356005)(36860700001)(82310400005)(40460700003)(186003)(83380400001)(81166007)(70586007)(70206006)(4326008)(8676002)(36756003)(2906002)(44832011)(6666004)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:29.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60de22a6-6655-4a39-eb74-08da459d62da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1133
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
 Hersen Wu <hersenwu@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Once mst topology is constructed, later on new connected monitors
are reported to source by CSN message. Within CSN, there is no
carried info of DPCD_REV comparing to LINK_ADDRESS reply. As the
result, we might leave some ports connected to DP but without DPCD
revision number which will affect us determining the capability of
the DP Rx.

[How]
Send out remote DPCD read when the port's dpcd_rev is 0x0 in
detect_ctx(). Firstly, read out the value from DPCD 0x2200. If the
return value is 0x0, it's likely the DP1.2 DP Rx then we reques
revision from DPCD 0x0 again.

Reviewed-by: Hersen Wu <hersenwu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 23e82b839c20..78df51b8693e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -344,12 +344,48 @@ dm_dp_mst_detect(struct drm_connector *connector,
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_dm_connector *master = aconnector->mst_port;
+	struct drm_dp_mst_port *port = aconnector->port;
+	int connection_status;
 
 	if (drm_connector_is_unregistered(connector))
 		return connector_status_disconnected;
 
-	return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
+	connection_status = drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
 				      aconnector->port);
+
+	if (port->pdt != DP_PEER_DEVICE_NONE && !port->dpcd_rev) {
+		uint8_t dpcd_rev;
+		int ret;
+
+		ret = drm_dp_dpcd_readb(&port->aux, DP_DP13_DPCD_REV, &dpcd_rev);
+
+		if (ret == 1) {
+			port->dpcd_rev = dpcd_rev;
+
+			/* Could be DP1.2 DP Rx case*/
+			if (!dpcd_rev) {
+				ret = drm_dp_dpcd_readb(&port->aux, DP_DPCD_REV, &dpcd_rev);
+
+				if (ret == 1)
+					port->dpcd_rev = dpcd_rev;
+			}
+
+			if (!dpcd_rev)
+				DRM_DEBUG_KMS("Can't decide DPCD revision number!");
+		}
+
+		/*
+		 * Could be legacy sink, logical port etc on DP1.2.
+		 * Will get Nack under these cases when issue remote
+		 * DPCD read.
+		 */
+		if (ret != 1)
+			DRM_DEBUG_KMS("Can't access DPCD");
+	} else if (port->pdt == DP_PEER_DEVICE_NONE) {
+		port->dpcd_rev = 0;
+	}
+
+	return connection_status;
 }
 
 static int dm_dp_mst_atomic_check(struct drm_connector *connector,
-- 
2.36.1

