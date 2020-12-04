Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AFDC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99D122AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99D122AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750926EC7B;
	Fri,  4 Dec 2020 21:31:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B286EC7B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9oTZ4oaeF5fSAYFMuCeZSImxSVcGTbG94KsUKvutvjJvHyEk/NTqGxNwR6+MxY+Ew/3Y1fUzjywmT5fa81MoN7dCE3DqXQkBpFz9iwNHbu0CKTBPb+dCaTNcQff/2Cs8ZPaseCqjG+OzhH2jAHuq89d1v9bHnLSC26zedo6PK7bEqJRj1tJyg8Wu9dqaXTBNyC5NwEDwIYayptLQSQtyLkyOJm4+QdcTel8ZZblVuqR2JaCx11di0ncnLGxLTv5mGlx/fo5DY9n8s27fiWWpzEYNkMtZqEclGLx0Ug5WggBCvQoEvA0WeAXodOkESKWNfnyfqIiGRCMm8E0RLGlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53jtj/095ha94SWPrx1aPZVWbDShhTBfr17gDEgc7Qc=;
 b=iCxrD405DRQ9GJjvikdVT2NPYbPYSIjNhYunyVsCFX1fBdIcHgQX9yKIGmN5+keWuEmRIsRMdSClI27kQl8tXAiU8/1NhtdtEazthMZdR0JlvXETnvInaPQJeinz2mLJPH5wAFEGbcAhOc01Jt+TTAXMtp1ZtzcYnVmG/bQaVoCcZv76KOX0XazeDywly1wkj9+SeOd+6wJFzhxXCqL6h+BGKeRNaEqUq8ACWbg3+lSpeKVf+D5fc9gAsyGLdY9pGuc+K7j/Yu6xQTaU8JjhDY/CxMez7GUeuj5aSxyKiPJmrz9K2X5UwJIfgrzwkvziOOh5ne9el5Ht+DGxpH+O+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53jtj/095ha94SWPrx1aPZVWbDShhTBfr17gDEgc7Qc=;
 b=FGa+syon9u8a6w6zSjYbxBS+FfewXAyZPEIwpyW5DX8MuA9v+rhhdZrJvpUWuqg6/V5nkB9oTW74LyEj5Fl5nZOcc4gEVwvFL7i+2BVtpFAF9bUxPKZerc6qicxJZma7omootv1tkhiN2cx2m1/F2/dfH4+G/DYoBTz6agvwMNM=
Received: from BN6PR10CA0033.namprd10.prod.outlook.com (2603:10b6:404:109::19)
 by DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Fri, 4 Dec
 2020 21:30:57 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::42) by BN6PR10CA0033.outlook.office365.com
 (2603:10b6:404:109::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:57 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:46 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:36 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/17] drm/amd/display: Only one display lights up while using
 MST hub
Date: Fri, 4 Dec 2020 16:28:43 -0500
Message-ID: <20201204212850.224596-11-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fd0d4b3-f455-4d7e-96fd-08d8989be341
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34685F291B728BE1E75175D5E5F10@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pq5lArcZHV7VhwJVsKRwC8wWv5fCuRZdTJVHLlYYE7OK8gAwxhq4rSwSvg6ooY05VpFi0sqBFd9LBeyXQGum2JPrs5hDYD6eLsC2AlWHOwiDJ4DZTdkX4dfxMuPnQSc6E9Ru+ALCU8iveGU43cP2Gm16rnfK3g0HfqmDJuPCs4IVr++ui28b5wIkyKQe1yKe0WIv0Coo7Uda3xdaXW0TibE7ux3mDgwkbtjFY69D5g1WZsXx3dK9qNot6rWwYJLwtIkIF6PV/YaBNQlo7wK0CxUQJ94qrWnxUeDUunsn7BRIfzuvPkAOIWSFGh0bokyat0KlXOWuOo3gcbwkNRI688ECKpyH3RbBA1NBA7oK+sgndMyt7jFd29jeC9/okxLS/pcRWQM7pAmtsEYvKsoG9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966005)(47076004)(54906003)(26005)(316002)(8936002)(82310400003)(86362001)(478600001)(1076003)(356005)(82740400003)(4326008)(8676002)(70206006)(70586007)(5660300002)(2616005)(81166007)(44832011)(6666004)(6916009)(83380400001)(2906002)(336012)(186003)(36756003)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:57.2344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd0d4b3-f455-4d7e-96fd-08d8989be341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
With the addition of dc_lock acquire before dc_link_handle_hpd_rx_irq,
there will be a deadlock situation where commit state sends a request
for payload allocation on MST and wait for HPD to process DOWN_REP.

[How]
Move forward the MST message handling in handle_hpd_rx_irq so that
it will not rely on call to dc_link_handle_hpd_rx_irq.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  4 ++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2d2c8a3c809d..59f738008734 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2566,11 +2566,9 @@ static void handle_hpd_rx_irq(void *param)
 	bool result = false;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	union hpd_irq_data hpd_irq_data;
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
-#endif
 
 	/*
 	 * TODO:Temporary add mutex to protect hpd interrupt not have a gpio
@@ -2580,6 +2578,21 @@ static void handle_hpd_rx_irq(void *param)
 	if (dc_link->type != dc_connection_mst_branch)
 		mutex_lock(&aconnector->hpd_lock);
 
+	read_hpd_rx_irq_data(dc_link, &hpd_irq_data);
+
+	if ((dc_link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
+		(dc_link->type == dc_connection_mst_branch)) {
+		if (hpd_irq_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY) {
+			result = true;
+			dm_handle_hpd_rx_irq(aconnector);
+			goto out;
+		} else if (hpd_irq_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
+			result = false;
+			dm_handle_hpd_rx_irq(aconnector);
+			goto out;
+		}
+	}
+
 	mutex_lock(&adev->dm.dc_lock);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
@@ -2588,6 +2601,7 @@ static void handle_hpd_rx_irq(void *param)
 #endif
 	mutex_unlock(&adev->dm.dc_lock);
 
+out:
 	if (result && !is_mst_root_connector) {
 		/* Downstream Port status changed. */
 		if (!dc_link_detect_sink(dc_link, &new_connection_type))
@@ -2628,9 +2642,6 @@ static void handle_hpd_rx_irq(void *param)
 			hdcp_handle_cpirq(adev->dm.hdcp_workqueue,  aconnector->base.index);
 	}
 #endif
-	if ((dc_link->cur_link_settings.lane_count != LANE_COUNT_UNKNOWN) ||
-	    (dc_link->type == dc_connection_mst_branch))
-		dm_handle_hpd_rx_irq(aconnector);
 
 	if (dc_link->type != dc_connection_mst_branch) {
 		drm_dp_cec_irq(&aconnector->dm_dp_aux.aux);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index dbbc0ec0b699..6b11d4af54af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1874,7 +1874,7 @@ static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 	return max_link_cap;
 }
 
-static enum dc_status read_hpd_rx_irq_data(
+enum dc_status read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 66445e34fd37..6d9a60c9dcc0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -259,6 +259,10 @@ enum dc_status dc_link_reallocate_mst_payload(struct dc_link *link);
 bool dc_link_handle_hpd_rx_irq(struct dc_link *dc_link,
 		union hpd_irq_data *hpd_irq_dpcd_data, bool *out_link_loss);
 
+enum dc_status read_hpd_rx_irq_data(
+	struct dc_link *link,
+	union hpd_irq_data *irq_data);
+
 struct dc_sink_init_data;
 
 struct dc_sink *dc_link_add_remote_sink(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
