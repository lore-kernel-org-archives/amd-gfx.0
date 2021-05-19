Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD7EC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED60761040
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED60761040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155B66EE98;
	Wed, 19 May 2021 20:55:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916746EE99
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8k29jgS5bA2IJOPexolR7uLPKKK6fB1X+TGr7FWQnn363cCxCT6ogcf8y1t01VofoF1vsEf3Xebbv1f/Z4qXFqS+2SVEfRYVsoMt1udpukxaEN2PjrRbjzNaInhF1CI7Q+Di4nrG//fLDgg3M87sQ147AN6FzLzs5a1HHDOFqwNw3D+3SPC7zG4zXK1EUGo68uJoOb/qne/+QmIoLvYRvtNt1+R1DjeQGhLNlBBuHRThPHgJ17Cch8umRZ7XaXHtPWUsWPFmLAwB6kmFWcDGNn05Ac2qzh3nOj3ANydDvAnNArOCjpIu5ICwJGD3KOC/Q5q+9shuiq+MXIHeZPA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYRxdKypNsjN6I4ALwqYrkwJN6rOUTljhDRTRdxv6cc=;
 b=d5f5IDogV7F/Vjo+ieXj7ZRW45WEQ9fK9kVP3mGfOpRolO+C7/wvytN71b8nP3lcIqX/Cq2zntSAcNdQjX+J91um2tgUc9G5j/PoaUFi0IhTBhE7wgg2Pdas6L3EjjcKo6d+paG8ag4ZjxCmEzfN8pjuT1QhpYWXMD8w5Vt6qCer3GxqXSlD1h7jdEgiyjlLkPPiNyrYALscu0bUNsXhv22uzvGUN/18AGY26utb3nVMcCV15vkrVBGIMd+XNHylP2NMdDL/lChGqhl4Tx2ZdW8yHvoW808QQW+kDt3A5FaZqo2X32tGWxuCLfTfnwYdB7fv+t6lFqxJsV6c6jscQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYRxdKypNsjN6I4ALwqYrkwJN6rOUTljhDRTRdxv6cc=;
 b=V9d/mfbwwZMjGuVL+eOvmkO1OXcSRDKkh7tLZlVd2LDfiwmVaDqCtVPaQKizf8VfybXb7GK8jyDpnqmXDaFvxzsRJnmyDRdoaar0GIgDuwKknPw/zvYuTS4Dqj9fpq1eI46yhjIwL6yx/oxQlNfQHR8wAM0YOGWiqFLHAX35Ngw=
Received: from DM6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:5:174::20)
 by BN8PR12MB4980.namprd12.prod.outlook.com (2603:10b6:408:a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 20:55:07 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::b0) by DM6PR21CA0010.outlook.office365.com
 (2603:10b6:5:174::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.7 via Frontend
 Transport; Wed, 19 May 2021 20:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 19 May 2021 20:55:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 15:55:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 19 May
 2021 15:55:06 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Wed, 19 May 2021 15:55:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: take dc_lock in short pulse handler only
Date: Wed, 19 May 2021 16:55:05 -0400
Message-ID: <20210519205505.622626-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1778e586-9422-4be1-d54a-08d91b086288
X-MS-TrafficTypeDiagnostic: BN8PR12MB4980:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4980055C084DC1B3C45240F98B2B9@BN8PR12MB4980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKbgi0B3dy8/F9x/aNWDFE9uS7um7PcKwJAZfkLDRBtTDT9bQLk/O47MicJN0yLsCcgZoELNq1s1UOQvGyiOLnJVskK7MftAPgDY/gTmnlVSssHuvxntPsbqRyjjOYwjVH1P1BNLpPmre3jJF6SjbtPjqnmczRvx0TJFwN5NdeAVdFen/WgcByUkzq4Z4QHmiSvMDmGCvhiUs0yjECcR6a/MfxRsF9BehoGsvhoHzKWUoiqo0SLOeU/JgAss7UG++eNsbzQYotcIxyeXb+R9OIDw8lRLgE+VH+kA+PqKG9oA8Pev0BQB5He+/lUb7qqdwu6QdtnjDWhPKoVEgPXWAt+DuLD1qwzw9ky3spxcE4XsPC+9fARPHK9B8PhX2FJh75xI3VXgDQ2fzLA5QsebnzgM3e3PxMDSbev56QLBKWh2XkzWKVb0l8FgpXAON8x6IXrgGtqCw2as89Dqqbqxq5uK0Lwzc26lGbPWtfJYyrUusEq2gYNEX9f1HLdAOEoTtfgngIC36TaoXzVS3jcNc6lFPKPkcC7Tdlq/Vop/ERTm+CWa34Nqa7HX0tqF86CoVedxwz7BPdRMbVTbn6+FKURCAzx+ylSWeyyrVMrIUPahR7sfhz5lvGgJIQpPHe7ZaQheD+b1QxCyZJeUvL7amFSU0ppmTTxkrQMGQfN+CDtSR5JLHEdfbEFVdp+/GUW6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(70206006)(2616005)(83380400001)(70586007)(82310400003)(86362001)(5660300002)(54906003)(36756003)(4326008)(336012)(8676002)(316002)(36860700001)(426003)(2906002)(478600001)(47076005)(81166007)(356005)(8936002)(1076003)(44832011)(6916009)(186003)(82740400003)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:55:07.5469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1778e586-9422-4be1-d54a-08d91b086288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4980
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
Cc: aurabindo.pillai@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Conditions that end up modifying the global dc state must be locked.
However, during mst allocate payload sequence, lock is already taken.
With StarTech 1.2 DP hub, we get an HPD RX interrupt for a reason other
than to indicate down reply availability right after sending payload
allocation. The handler again takes dc lock before calling the
dc's HPD RX handler. Due to this contention, the DRM thread which waits
for MST down reply never gets a chance to finish its waiting
successfully and ends up timing out. Once the lock is released, the hpd
rx handler fires and goes ahead to read from the MST HUB, but now its
too late and the HUB doesnt lightup all displays since DRM lacks error
handling when payload allocation fails.

[How]
Take lock only if there is a change in link status or if automated test
pattern bit is set. The latter fixes the null pointer dereference when
running certain DP Link Layer Compliance test.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  2 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  4 ++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e79910cc179c..2c9d099adfc2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -28,6 +28,7 @@
 
 #include "dm_services_types.h"
 #include "dc.h"
+#include "dc_link_dp.h"
 #include "dc/inc/core_types.h"
 #include "dal_asic_id.h"
 #include "dmub/dmub_srv.h"
@@ -2740,6 +2741,7 @@ static void handle_hpd_rx_irq(void *param)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	union hpd_irq_data hpd_irq_data;
+	bool lock_flag = 0;
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 
@@ -2769,15 +2771,28 @@ static void handle_hpd_rx_irq(void *param)
 		}
 	}
 
-	if (!amdgpu_in_reset(adev)) {
+	/*
+	 * TODO: We need the lock to avoid touching DC state while it's being
+	 * modified during automated compliance testing, or when link loss
+	 * happens. While this should be split into subhandlers and proper
+	 * interfaces to avoid having to conditionally lock like this in the
+	 * outer layer, we need this workaround temporarily to allow MST
+	 * lightup in some scenarios to avoid timeout.
+	 */
+	if (!amdgpu_in_reset(adev) &&
+	    (hpd_rx_irq_check_link_loss_status(dc_link, &hpd_irq_data) ||
+	     hpd_irq_data.bytes.device_service_irq.bits.AUTOMATED_TEST)) {
 		mutex_lock(&adev->dm.dc_lock);
+		lock_flag = 1;
+	}
+
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
 #else
 	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
 #endif
+	if (!amdgpu_in_reset(adev) && lock_flag)
 		mutex_unlock(&adev->dm.dc_lock);
-	}
 
 out:
 	if (result && !is_mst_root_connector) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9e08410bfdfd..32fb9cdbd980 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2070,7 +2070,7 @@ enum dc_status read_hpd_rx_irq_data(
 	return retval;
 }
 
-static bool hpd_rx_irq_check_link_loss_status(
+bool hpd_rx_irq_check_link_loss_status(
 	struct dc_link *link,
 	union hpd_irq_data *hpd_irq_dpcd_data)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
index ffc3f2c63db8..7dd8bca542b9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
@@ -68,6 +68,10 @@ bool perform_link_training_with_retries(
 	enum signal_type signal,
 	bool do_fallback);
 
+bool hpd_rx_irq_check_link_loss_status(
+	struct dc_link *link,
+	union hpd_irq_data *hpd_irq_dpcd_data);
+
 bool is_mst_supported(struct dc_link *link);
 
 bool detect_dp_sink_caps(struct dc_link *link);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
