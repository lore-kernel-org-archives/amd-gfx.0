Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E3AC7619A
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Apr 2023 15:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644F110E093;
	Sat, 15 Apr 2023 15:44:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A41610E093
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Apr 2023 15:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXmblWkDHn1t8cEKwwNMSFYqIFwPlbjXh8JmoeH/UUwqYNJes/TermqfcbW7A6iN7ceveXFdprGsKIwSlP4cVyP1CeMxQ2L7zipU7L1PK1GezWhK3B8uvCxVpGLF13FEbQYVqnYAUUZEoveM/s38cNnxOBPN4jnKEv/nFnIQnS15uBsaCJrv8S5a0jrtiraluzESC8Ha2EOesYWSKXvFwp6PQIYXtSOXInhIXwN9Mt+KIZiDnN99lNYbGWrb+z5tHNfzstX5Xa4Fe8jPUcVqpX+2DgiGKpFcM1azfyGpdc/zDuCC+cbja4052ID0qotwVry2Mfc35Ag+oYwgOItQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8W9p54val8WDE/iaaPjYnOYfIrrtDENjO6DtWNZPnI=;
 b=cWMqeSEAj6QgNr7soF2W0shvLe4C9FszIriwP58Hf8Tlk/TJV361p1KByYkHGrzCT29Wdi9S0u7hQfnaU1K04KF7SNlpU8zyyl5POP4Ui4l694HlXSAodO02gotCo6WLGloWbp+dm5P3htG6qqDvpsTnvnygE29q6n5/sGTT8pRLsZiprcnLE1qEwaxU9Ytfst74JMYiMcJi8G+Ri2/oQ7isRzekipTqq/zSLH596EPtxFyCd1i8e1soIywdCJwQA4VpsZ7vtMkaCUbuayX4CgdPS414WV7hYVPF6JvQiFkds/m8AHP329NmcnD9M0i0JJQhAvXmLTG1TxlES9FJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8W9p54val8WDE/iaaPjYnOYfIrrtDENjO6DtWNZPnI=;
 b=oXE3fTQzp87oYGc/Vp1oh+k+6q7ziSFfzj/kIbtDhcAVuL9iZQUbEjZMOPTqG+9gkxOx4fTp0RXcjKNoq8b4XVqE4c2egAGXsii/kgaqiAJ0QZ6+N/zYD+jE5o2HKhaRDyjROqZjdINlXFUnjORW0rEpXvGAMqE/uPfMwvTmn40=
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Sat, 15 Apr 2023 15:44:00 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::8f) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.17 via Frontend
 Transport; Sat, 15 Apr 2023 15:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.17 via Frontend Transport; Sat, 15 Apr 2023 15:43:59 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 15 Apr
 2023 10:43:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Check & log if receiver supports MST,
 DSC & FEC.
Date: Sat, 15 Apr 2023 21:12:03 +0530
Message-ID: <20230415154203.3299642-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 54562a75-1e80-4855-68fc-08db3dc83b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TC+XMzVPsMYSrIjqKliDEVsIgdqn+Ip6NedJ6eVDGaJt7TMCc6y6MVYVjdwLp36Y3chI2yNAOBknYPZ5WcD1BwopAF2DT0brb1fGi/mDDQJeaZJ/yfU/uRV6O1p5sDkpKvjTWj1BPhckQEhTkovW16RU7Tfz+YeqVr5uit97loCsPQiLdgxOGGPzDvcUuo3tvrB1qoI4wKQpuNR8aC1RGyVsKRmJh6pmWSLSTOHhPY6pDNkZ4KMs9lKPpQv0nw5SueR60yTIBTMNGUmkrcxQXHGebafvn5zho2HS1KT0OvdWwRvZtuZVaSS4BLEyWMKubUIjbYuWyrFela5AUw4yIA3Ak2UgY1Rpu20qAJbhGAcg6wFbkHYx97yAw71OyB9RC9bPcpmfbhy/lF4y0eje63sxfb27+EEpPbEKX+TB4lAaU5N3+ETt54C3w1xzTX43RgnhBaclI6/kQH0WyGjmaswS3bflX5b6TPkcMRtvk9sDVNlEfFKiA0FjRJ4a3pYbeL4XoVe1oBzzY67O37AD1yhxWwtQ8pIK3doiswaJfjiewjZCJrzWjDr+4E6QNcCb/hXLOyab4JyQzf52SAj+X8xoO5Dpk6/V2f8J1cyUiI2RIsdi/IccNmD7TKJqVZ6Zwwyoky+m1vW/MSVgnC+Zpou5LYI7gHjwS2dbIbrDIqMnEVpTi/dE36PQLkewYyceuQEf7Q+3DY2XA48Y4UrioLCgIVL3mGOIlinHiP7l80=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39850400004)(451199021)(36840700001)(46966006)(40470700004)(2906002)(8936002)(478600001)(8676002)(70206006)(5660300002)(44832011)(70586007)(41300700001)(40460700003)(316002)(40480700001)(82740400003)(426003)(36756003)(6636002)(336012)(54906003)(4326008)(110136005)(82310400005)(86362001)(186003)(7696005)(26005)(1076003)(81166007)(6666004)(16526019)(2616005)(36860700001)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 15:43:59.9171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54562a75-1e80-4855-68fc-08db3dc83b41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After reading from receiver via DPCD, check & log if it supports MST,
DSC & FEC

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_capability.c   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ba98013fecd0..922c2802765c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1554,6 +1554,8 @@ static bool retrieve_link_cap(struct dc_link *link)
 	int i;
 	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
 	const uint32_t post_oui_delay = 30; // 30ms
+	bool is_fec_supported = false;
+	bool is_dsc_supported = false;
 
 	memset(dpcd_data, '\0', sizeof(dpcd_data));
 	memset(&down_strm_port_count,
@@ -1696,6 +1698,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 
 	/* TODO - decouple raw mst capability from policy decision */
 	link->dpcd_caps.is_mst_capable = read_is_mst_supported(link);
+	DC_LOG_DC("MST_Support: %s\n", str_yes_no(link->dpcd_caps.is_mst_capable));
 
 	get_active_converter_info(ds_port.byte, link);
 
@@ -1803,6 +1806,12 @@ static bool retrieve_link_cap(struct dc_link *link)
 				DP_DSC_SUPPORT,
 				link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
 				sizeof(link->dpcd_caps.dsc_caps.dsc_basic_caps.raw));
+		if (status == DC_OK) {
+			is_fec_supported = link->dpcd_caps.fec_cap.raw & 0x1;
+			is_dsc_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.raw[0] & 0x1;
+			DC_LOG_DC("FEC_Sink_Support: %s\n", str_yes_no(is_fec_supported));
+			DC_LOG_DC("DSC_Sink_Support: %s\n", str_yes_no(is_dsc_supported));
+		}
 		if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
 			status = core_link_read_dpcd(
 					link,
-- 
2.25.1

