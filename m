Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22DEC56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 14:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BECF204FD
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 14:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BsRzGwXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BECF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F986E965;
	Thu, 26 Nov 2020 14:31:15 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690078.outbound.protection.outlook.com [40.107.69.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 755276E965
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 14:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KePu3//xfPEpjOxtroxiYoOejHM4GMWgdFHlbXqSKKkJNCRPgpiEs0QWqZcQTivnlLlO7q65fGzk3SQZZsPZ1+5rgsbuyyCV0pOU1OAoDAcigZIbeQv0oCRCcZbgOFAU+6mHUqhvyoIP786cJToipJugYl2y8DBtxzVQCPR9XVYluu8Cy0hIe6+5CLemryD4WuxaGMpp2O3RbY5i9VFn+kRwSTUHcTWQl7HJDys4Z2UjMTFWKRHKPWJBKCpn5BKAZjxMcmxd9f/2gyhXdHHVMf6AAlrkPzU8RKl7+B3hJK1YjzeM5QnvPG1oyYo0LgAsLeVnYzHdzV4KF4cfHXZZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgaMyNbvQrcAa2IqKB0OyTFYZNxb7mfgQcHup/vrFoo=;
 b=lPvmXnMazXEL9dugtHc7AnW0PrCD7XLZWWLK+WwGj8KXeYTKnZNGazJV9hdBi0E3oU0wRnTXsKSK59bwpqWpRakJScbNidxyc2C8RTHCJwfKyLp0sDf0ovWpEdajLyEV4BPn3pnFIW5gVGtN1gXp5/BFnv1V61nAHNTw+2whUQGMIgWWwgg1rdYLBHbysc8Q7sk4P84QcerpaXwCmp4NdwqliggX777/zqJ855AXNQK0noAUhSbqxhpiHcgn263l/i10F6H4HGrypIjdUUA7F7rrHT6tXaWRomJsWQQwDB8HNBxGPEdkKsEYAybm1ihSV8qZ58kswFmOkPN4yGeR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgaMyNbvQrcAa2IqKB0OyTFYZNxb7mfgQcHup/vrFoo=;
 b=BsRzGwXHHGRTjVOss+BZE5pNLedA8N/rduninpPcNIVbl39Ed5t9nmUZEHP1onYM24Djyoa3TpVWAaExQGLscuVwkRpWhJD0D2sWSoCpar4OPxm2E4jOPy5ormURa2wLvM9xid22B64lP6aPqIwmQeePbrfAlNiP3dUT9zotBKI=
Received: from CO1PR15CA0091.namprd15.prod.outlook.com (2603:10b6:101:21::11)
 by CY4PR12MB1799.namprd12.prod.outlook.com (2603:10b6:903:11c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Thu, 26 Nov
 2020 14:31:12 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::f5) by CO1PR15CA0091.outlook.office365.com
 (2603:10b6:101:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Thu, 26 Nov 2020 14:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Thu, 26 Nov 2020 14:31:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 26 Nov
 2020 08:31:10 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 26 Nov 2020 08:31:05 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Clear dc remote sinks on MST disconnect
Date: Thu, 26 Nov 2020 09:31:05 -0500
Message-ID: <20201126143105.32016-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 824d8f69-3a10-45ff-6fa1-08d89217ec61
X-MS-TrafficTypeDiagnostic: CY4PR12MB1799:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17999AC869879B29E0748BC58BF90@CY4PR12MB1799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+kRISfZ5zMgq5gfwg0r7eNHBHHqKLlo50P1iug+hvvEAjhua+jr3Icd9AwrFRsHWNnbrKvrbyOb8qDtJM+e7DEiJ9EU3SLldaWqK98xemr8k1cUaq5YZjY7fUUjZZtbrloj+CA0hf6WTkm5AbcNBGG1YRDvohOzIsgzElwkYdEX88H0kYeUVxOiYDZbTu9Mkt8VYDSGKyTWbhveUFoX8oSHyi9gw4yJ4BeSFEJg5BmDMKzwFcNiRalhuNpIR/AmiNJCWJTBU/QQEfwpI5jtThLnJABaG2h2t7gd0DxajmolRujkwYlP8wkBLh99g22SEjyMWvro2MuzuIUXYaI/mtjH+1dMQfyVr0t3/cW0bcs7yOj5EOeefpgf2MfC7MNE6XloJVvXzwCLB6asC7UBig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966005)(26005)(478600001)(1076003)(6916009)(4326008)(316002)(47076004)(54906003)(70206006)(5660300002)(70586007)(336012)(82310400003)(83380400001)(8676002)(36756003)(86362001)(82740400003)(186003)(2616005)(81166007)(44832011)(7696005)(426003)(2906002)(356005)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 14:31:11.8797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 824d8f69-3a10-45ff-6fa1-08d89217ec61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1799
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
Cc: aurabindo.pilai@amd.com, Bhawanpreet.Lakha@amd.com,
 nicholas.kazlauskas@amd.com, Eryk Brol <eryk.brol@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Recent changes to upstream mst code remove the callback which
cleared the internal state for mst. Move the missing functionality
that was previously called through the destroy call back for mst connector
destroy

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Eryk Brol <eryk.brol@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 22 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b7d7ec3ba00d..d8b0f07deaf2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -418,9 +418,10 @@ bool dm_helpers_dp_mst_start_top_mgr(
 
 void dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_context *ctx,
-		const struct dc_link *link)
+		struct dc_link *link)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
+	uint8_t i;
 
 	if (!aconnector) {
 		DRM_ERROR("Failed to find connector for link!");
@@ -430,8 +431,25 @@ void dm_helpers_dp_mst_stop_top_mgr(
 	DRM_INFO("DM_MST: stopping TM on aconnector: %p [id: %d]\n",
 			aconnector, aconnector->base.base.id);
 
-	if (aconnector->mst_mgr.mst_state == true)
+	if (aconnector->mst_mgr.mst_state == true) {
 		drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, false);
+
+		for (i = 0; i < MAX_SINKS_PER_LINK; i++) {
+			if (link->remote_sinks[i] == NULL)
+				continue;
+
+			if (link->remote_sinks[i]->sink_signal ==
+			    SIGNAL_TYPE_DISPLAY_PORT_MST) {
+				dc_link_remove_remote_sink(link, link->remote_sinks[i]);
+
+				if (aconnector->dc_sink) {
+					dc_sink_release(aconnector->dc_sink);
+					aconnector->dc_sink = NULL;
+					aconnector->dc_link->cur_link_settings.lane_count = 0;
+				}
+			}
+		}
+	}
 }
 
 bool dm_helpers_dp_read_dpcd(
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index b2cd8491c707..07e349b1067b 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -113,7 +113,7 @@ bool dm_helpers_dp_mst_start_top_mgr(
 
 void dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_context *ctx,
-		const struct dc_link *link);
+		struct dc_link *link);
 /**
  * OS specific aux read callback.
  */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
