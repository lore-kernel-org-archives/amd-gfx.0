Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F1CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED915610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED915610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914886EB82;
	Fri, 16 Apr 2021 14:34:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916D76EB82
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdgYxNQza5ixKviRwususQRnxzkjOMW7uJFSrkjnoibqZjDwqq49MtF5GFA2/Sey2nSACHBBjFbnZtUl4E1LMzv8O1KXuryh1vFuRMeK+cLoMfJN+TYjBLIQFHhfcGuwPxxgw4cL6UMOzKLm7rUNPFQ3rUyDDbqNqc+RvH1Cuz0qLQQjOJjdm5WMlZ2/2JXS/V+Fr+z+jun9CUEQ2TxDkTYzd+IIDEbctGS8pjHTcqJQR5ZQeswfCK82R1amupvmW6jH6qeOdgpB25OPme3rsocGj35xApYNFxjBCvDXmfebSWStj0TtxG0J7+oUHiv7YzZOQ6t4xbsIATa71t87oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZKAJSIvc498bLPQhIH2grcEvyB1HvOP6ugONvVV/L4=;
 b=jahtkSNwYry2gRX7bqHqSHZcuqB2nq+aR3PTwSXDf75BbHabl2Ks2EO6MLCG6+37zkKb/cE/VSpuCDF18ItlEN5DkG8ufaEUd8XpuT15RuayBYAiXZFr0GYPYXbdYY+uHI8wn/zEgwMznBV8oTZn6oHsnen4j8oSbqSdlUQzCqqk7Og9L1xPtNqGar8EjT+DIBbX5trfvdBzloxb5jc93KpZyMMc6knQAdjvBjP8DLSAWTdrNyPxJ4WwdTAh9cnPdvbi71ScZsB3Z1fuFUZKB90Ie83NfW86f+4rxJJXMo2TAymZuOfLlXQoV0+INSZJ1OQ1dKBqxJSevAMr5ZV7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZKAJSIvc498bLPQhIH2grcEvyB1HvOP6ugONvVV/L4=;
 b=LSGMSx4nthy1h14M2/QBDsbffMe3xdKwGk64c95nUPYmjZ5ppSY9LpfQlCEQ2tVTBzMX8Aq2lrPooeH4iZJZPKXBd4s/zT5qHJeHU1A6jOQmUuh2JgqYQTuB7zyIku7lv3kqnajJXGJpTN0ieLiX/Z9UNVqDZBbxdKdIwwDJzFs=
Received: from BN9PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:fb::19)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 14:34:26 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::b1) by BN9PR03CA0044.outlook.office365.com
 (2603:10b6:408:fb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.17 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:26 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amd/display: update hdcp display using correct CP
 type.
Date: Fri, 16 Apr 2021 10:34:01 -0400
Message-ID: <20210416143417.611019-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c5c2255-325d-4670-cbb6-08d900e4bc90
X-MS-TrafficTypeDiagnostic: CH2PR12MB4293:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4293CF1019BC60FF3AFF2AA88B4C9@CH2PR12MB4293.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzWs6ck+krLjY9ummSwfrnLUVuYvIx49nJbBQrhAlE8PHPvJWcVlppkpZqOrs0rw1uvFFVpjf4VlcDHM5oGniaGaJyLZJrBOUNmKkzRzvCxP3P45x3wFJmR1JQ96SEwrdFM3HERC5HyFHIXE8JZcAvtHwFm0AsKJurjaYa+ZNIfOk6Z9VbA4SoLsgKlGT+3A/XQYCB7paxjW/akaD0vFBYNHac08AUixCyBzAt6aPEPhcs4qhkQCrdEmkXhMoKWlognCIhSgqWgvZDmm/OP8o7ny+35O2LEPLEAgq9UISEiee3IC/3IEbrWLHj1/XR5zN6YNKh5JBvV5sJy/z7bc9XhRuoHlh7tJisfdnSqxXJBKE/QNMJGoTJJcBmg8Ralee6BKmyfzjrI153aHafE7y9Pu2kvZ+ZLtQ3EQQME1U9sN2ng5CEOZ379N3hRHGtXpFZt8eOe2RHzE8PH+hp31eoIiclt4i5BIgyDZ2R64azUa8R8OBDlzrawAUAriMSEuL38/9J9jF5A+2uvGbPirmXuQ8JNZscsH4aUFdS08bW5CCv2aQoIBdESVKWYshlGZD3vp4x21GfpV57Azw0tYk3a8US7o+EdPUCLjUpqJJGYmcQfKUzEwgYSp0+MeL08LRDBfNvW/u3bifSLZw/JykMuWP+QzMGb/AZ43OQhv1w1SvbM6zwKSVa5DBKWGRwGK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(1076003)(356005)(186003)(54906003)(26005)(6916009)(6666004)(70586007)(86362001)(82740400003)(44832011)(316002)(2616005)(82310400003)(83380400001)(478600001)(4326008)(5660300002)(8936002)(336012)(426003)(8676002)(36756003)(36860700001)(81166007)(7696005)(47076005)(70206006)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:26.5345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5c2255-325d-4670-cbb6-08d900e4bc90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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
Cc: "Dingchen \(David\) Zhang" <dingchen.zhang@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Dingchen (David) Zhang" <dingchen.zhang@amd.com>

[why]
currently we enforce to update hdcp display using TYPE0, but there
is case that connector CP type prop be TYPE1 instead of type0.

[how]
using the drm prop of CP type of the connector as input argument.

Signed-off-by: Dingchen (David) Zhang <dingchen.zhang@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 60f91853bd82..616f5b1ea3a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -434,6 +434,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	int link_index = aconnector->dc_link->link_index;
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
+	struct drm_connector_state *conn_state;
 
 	if (config->dpms_off) {
 		hdcp_remove_display(hdcp_work, link_index, aconnector);
@@ -459,8 +460,13 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 3;
 	link->adjust.hdcp1.disable = 0;
+	conn_state = aconnector->base.state;
 
-	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
+	pr_debug("[HDCP_DM] display %d, CP %d, type %d\n", aconnector->base.index,
+			(!!aconnector->base.state) ? aconnector->base.state->content_protection : -1,
+			(!!aconnector->base.state) ? aconnector->base.state->hdcp_content_type : -1);
+
+	hdcp_update_display(hdcp_work, link_index, aconnector, conn_state->hdcp_content_type, false);
 }
 
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
