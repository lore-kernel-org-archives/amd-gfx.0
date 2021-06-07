Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C92C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5916D60FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5916D60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0531C6E946;
	Mon,  7 Jun 2021 16:49:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605C46E940
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj7sd2FoSlkI07eigh+23gsDjfqp6TQu/ZuhLVWKZ69tQnU+rhuP9Ntd35E3aGbE2Ks4HRSvO+woCtMkqYzlnZg2b08nlvZ4w0MII5N6TLZA4sbR4kMkR2ITyLU1A7YtubXNc8ISdej7Qp+3eQrrGrh4vBl5hQMGEjjlewcwcsqDbX8JA4FuwDba2Nmp91q0W0NIgQp+jiPmcHk/GQrg7ZdJQj2XScD3h7D1Xpe67biYzJbHz7uMueNHtLU+MKE8NM9DcONsEfEVb/PTrMxpW0H1Lx8R8eiTnV4dBIed60X3T1zfJPo55PGsabCz8T+MKX68DggHspFU8bxcrRG54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQgEIDi4j2imAldzJmpU8gsZGzEm+QBa1brvEGWgslg=;
 b=A/dk4WUINRZebOAi48d6xNdjQXl8VSwvCMHFYDrz0kGVEl15mOSFK5JPjmiPbJF+sLqFiUba5PE2LzSNYKXmjtqEYGCwmv9YsJ/Gs3Px+5l7p/bd0jK3SpUVhdXi177G05y3byTNOECaZwQIs6sqWMpSTk+3hee7Gz18DLn4JVotXRUP7kB6NyBmCSEpdApBAhYQemaGZueev7RQ06uh8d7GVDXqzSGSHuHZLyzO06n2JHvpOdxdJjvhtDkbBQGxkmHDgTaBORlKHT6Mh9nKLTE9f22JzDx0+poTq+0yaD2VyXlciZMtfp55oR4oqybpyGsugFei/TFMLVWx5GwATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQgEIDi4j2imAldzJmpU8gsZGzEm+QBa1brvEGWgslg=;
 b=FVc72gZ1S2p7UKdtajbwPapgx1a3XXKFtyJjpD8v16C9BHFbG0KD4YS+xx1k+39oxzzVN6f3XA7JFmFnvmg3RmL3lHZixPwqKryPRN+KkWqRpa1SMksuqdiZkIZA6ZIqOYttliGtwgTZKWxLnw0hcuyaitBe031ByTSRMlrvHrU=
Received: from BN9PR03CA0613.namprd03.prod.outlook.com (2603:10b6:408:106::18)
 by BN8PR12MB2996.namprd12.prod.outlook.com (2603:10b6:408:48::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 16:49:18 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::63) by BN9PR03CA0613.outlook.office365.com
 (2603:10b6:408:106::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Mon, 7 Jun 2021 16:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:49:17 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:49:13 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/30] drm/amd/display: force CP to DESIRED when removing
 display
Date: Tue, 8 Jun 2021 00:47:11 +0800
Message-ID: <20210607164714.311325-28-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88159606-d6dd-4478-59c9-08d929d4305b
X-MS-TrafficTypeDiagnostic: BN8PR12MB2996:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2996DC6DFD67C1EC6422D514FF389@BN8PR12MB2996.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YA8pV1xthJhUIIvCe9VIYnVw0H2CkmbaftqLYYjWrRYC8a2mMrHkwIi/VgrbH6Wfu7MfVHyizHepX6/XZhSpzQXyFhgRuV9k4dRnt9vMv8it8y5aPXhXj4xSmG+85kmB84wXcWlHEtGVA7VVv/UP91V/exW8ooH5nwwL8lsDCBb+Vk97D8TD/jdJ9inXGIzfian2Gdm+1BlXc7ZWVUFOqjhPk5U16QZOaa1jUi8BWDajRQ4j/Wsi1wOZuGJf4tsVi8bE6X71vU40A7cbJP33/y0tdl1yRjShbEZWOzWwrUW43yuYrGtie/WufFjD4g6L/TbvmnPA9D1ELHav6Ad5EY4JXGbjcnyREBscQdmmM1+aAqh+LwyhdrK9qxGyAVXqke+Z9JMMw3MDYGdP5b42PvfhdQd0vfi/42g3gK5NO80iLVfq5QaFaYkG4XdidaNHZOvUr+W1NzLxjNZWDrZGxzXiAHRhOJIAK+LVnBgAPxnI32hEBC7J/zHx39ynFDTfTHnQCIzbvnRdlMp4uGqptC4ZlyDFkBIimALqHGVgsxIaEjg5uCRe66Ln9OhgNwZZEVlhczO+A1I7jMNQ/o3l3ZsSl5O+BjZMUlrPuDCupw3dqo3Jog5ZGY94frfas/NdJGf+ut26S+8BY5k/1BUbMbGySOwMR6uspmSJQNB67UaAlTntS8TNwjSThiz8KVmA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(426003)(2616005)(2906002)(44832011)(5660300002)(478600001)(26005)(7696005)(8676002)(86362001)(47076005)(82740400003)(6916009)(356005)(186003)(316002)(36756003)(83380400001)(8936002)(81166007)(70586007)(36860700001)(54906003)(1076003)(4326008)(16526019)(70206006)(336012)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:49:17.0304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88159606-d6dd-4478-59c9-08d929d4305b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2996
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
Cc: Stylon Wang <stylon.wang@amd.com>,
 "Dingchen \(David\) Zhang" <dingchen.zhang@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Dingchen (David) Zhang" <dingchen.zhang@amd.com>

[WHY]
- Commit from userspace could cause link stream to disable and hdcp
auth to reset when the HDCP has already been enabled at the moment.
CP should fall back to DESIRED from ENABLED in such cases.
- This change was previously reverted due to a regression caused, which
has now been cleared.

[HOW]
In hdcp display removal, change CP to DESIRED if at the moment CP
is ENABLED before the auth reset and removal of linked list element.

Signed-off-by: Dingchen (David) Zhang <dingchen.zhang@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 666796a0067c..a589fcc71369 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -222,10 +222,23 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 			 struct amdgpu_dm_connector *aconnector)
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
+	struct drm_connector_state *conn_state = aconnector->base.state;
 
 	mutex_lock(&hdcp_w->mutex);
 	hdcp_w->aconnector = aconnector;
 
+	/* the removal of display will invoke auth reset -> hdcp destroy and
+	 * we'd expect the Content Protection (CP) property changed back to
+	 * DESIRED if at the time ENABLED. CP property change should occur
+	 * before the element removed from linked list.
+	 */
+	if (conn_state && conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
+		conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+
+		DRM_DEBUG_DRIVER("[HDCP_DM] display %d, CP 2 -> 1, type %u, DPMS %u\n",
+			 aconnector->base.index, conn_state->hdcp_content_type, aconnector->base.dpms);
+	}
+
 	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
 
 	process_output(hdcp_w);
@@ -462,7 +475,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->adjust.hdcp1.disable = 0;
 	conn_state = aconnector->base.state;
 
-	pr_debug("[HDCP_DM] display %d, CP %d, type %d\n", aconnector->base.index,
+	DRM_DEBUG_DRIVER("[HDCP_DM] display %d, CP %d, type %d\n", aconnector->base.index,
 			(!!aconnector->base.state) ? aconnector->base.state->content_protection : -1,
 			(!!aconnector->base.state) ? aconnector->base.state->hdcp_content_type : -1);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
