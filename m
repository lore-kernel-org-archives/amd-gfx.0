Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68586C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3659661A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3659661A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A244A6F4A8;
	Fri, 26 Mar 2021 22:05:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB616F4A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIcJugxZAyTFabYy/k1p2cLXSrMT1WTCelpolgms0DN8k6ygeZ8ygGNedz4EgH12OVDOXlA8+c3QQGodWASkb27aLalzPgY8VZflSIsAHW4M5tJiV53d6/r+6Ll4AEu4TYKwsICE/Q+NzL3LswHiriUGvfqCWaIYBFQRALiglipSbSQ1stqkDV+u7CMfP2MJfKAr6C6hSGJFrryoxgTsBJ33Vx1viXT43HcFnlPERZwofeTmz4dyWMWIoqiriLWnLbmdZycOheM6n0EYOOpf38o09IxdoSaKSgRoQYYD8ip8PAtjaBjvkGuYQnOWDAvaU6KXRVdw01WnYwa0xrZK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvGy01cQ4ZYYsbSZS9txINji+A3OriwsP//QVIS+ELU=;
 b=TEzK7y26wukwG09kXz5wRTd0Bb/hzakX8dqshs2QH4xg+H0a3xqF+FpmqMaY3XzEEDDpcR4gHToroTF5abl+0EEurkbIpEVX/ueqyhI9vYsdkf8edF3vMwosTTZSAeJ8O8uNMxVFLRxdoiHQjZY/7tmXaEANm639OxBMyH6Y8JEK1RgY3FQKLe7xPmx6sJMNEmgc42mbWWraCM0Yr68rTrdJhnMRRFkrewrde/WuEiswemwN8rba4BP2smssjKhl3i+vnyapgMhUkQsPa07I333gKJx4rjY7yZeUFkXF/Wk/238eCS2USNHR0KhSOd4jrxhBmNj0xEwMvOwJvprUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvGy01cQ4ZYYsbSZS9txINji+A3OriwsP//QVIS+ELU=;
 b=TZuCsjHDyFlI4VhRKrKXdBw/fJVOKE/nRSOL0/E0+NVd1+nZKiFP9HSqnqRBTvBpByOEksJ0Rfq18onyc/B58NzSgPNPHlvMkXk83Vb9V6m7eslupcf5W+c+6ZrHnV8Qi1xlf3OUktiXldgbVWOmtrfheo4kABvhOH5i6vDnRwA=
Received: from DM5PR15CA0033.namprd15.prod.outlook.com (2603:10b6:4:4b::19) by
 CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 26 Mar
 2021 22:05:53 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::14) by DM5PR15CA0033.outlook.office365.com
 (2603:10b6:4:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Fri, 26 Mar 2021 22:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:05:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:05:52 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:05:51 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/21] drm/amd/display: define mod_hdcp_display_disable_option
 struct
Date: Fri, 26 Mar 2021 18:05:19 -0400
Message-ID: <20210326220534.918023-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c5d7aea-608b-40db-8563-08d8f0a352d3
X-MS-TrafficTypeDiagnostic: CO6PR12MB5459:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5459FCBC46E4926371AAD325EB619@CO6PR12MB5459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uatNpD7Boa+e3tWax5Da3gRWXILrrm6HueOtCzkrubVxUwcuBrjqiCBXkxl6j3WEyXOmQXADhkZ9ldL5AJRGmfYW27hrsRC0+1hzqjwGA2V3TO6ZIvNxaeTRpvWqiO9uDhuMekcR9Lor2EZ2W0C4UKYjiiepVgl3NrlBhE9aH2mCqjUhmkw5WsEm+hk1wz/WC5CEc2orD5Dlx0gbsCoFTuVOxElAeAlj0AgJ3n9TnQZv5okjPzRNUuyR1yG/qOOo0FmRZ8UK4nNbLlQ/3XRR/E7sU98JuD2k8ZWNhQ2ohGp1c0qd8fDK1je6j5vaTQV5+7pwn2P2463y+MOocibGvPClPPTZ/kRgfpWFeOifQg/2rc1PFLnsuYjwejBgDHhLJQHiGvXW+E80UzqtjbOFHibvOriHH2vRTodKxZq2a3KX1++P7xqgsvNfPdEDGfknjzWmCyoMTpUVIg7PKkWRiBjN56z/0OCIHlDb4KnLGb25b20fQ3Mf7hNF8kfbm+JYtYbECf+tFrSl6F3fhCWRqBnQ/VfkKU2rZUJR3ytgRxAo/CU5Bef8XQPdbn9WG+f4HdSFhqEgbPyhbfsOJWWWi29oThMPt4oy424OIHi+vExi804BEhcU7+LIgoYrR+/vaJqQ5ffNNe0x9S55CsWJxab0USQYo57rs3IA+O3dv9qCUoIXjPgMySeo1FeLg9Ka
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(478600001)(7696005)(54906003)(26005)(36860700001)(86362001)(2906002)(8676002)(5660300002)(70586007)(4326008)(186003)(426003)(8936002)(1076003)(316002)(82310400003)(83380400001)(36756003)(6916009)(82740400003)(336012)(70206006)(2616005)(356005)(47076005)(6666004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:05:53.1865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5d7aea-608b-40db-8563-08d8f0a352d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, George Shen <George.Shen@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  6 +++---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c        |  4 ++--
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h     | 10 ++++++++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 0cdbfcd475ec..60f91853bd82 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -191,7 +191,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 				psp_set_srm(hdcp_work->hdcp.config.psp.handle, hdcp_work->srm, hdcp_work->srm_size,
 					    &hdcp_work->srm_version);
 
-			display->adjust.disable = 0;
+			display->adjust.disable = MOD_HDCP_DISPLAY_NOT_DISABLE;
 			if (content_type == DRM_MODE_HDCP_CONTENT_TYPE0) {
 				hdcp_w->link.adjust.hdcp1.disable = 0;
 				hdcp_w->link.adjust.hdcp2.force_type = MOD_HDCP_FORCE_TYPE_0;
@@ -203,7 +203,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 			schedule_delayed_work(&hdcp_w->property_validate_dwork,
 					      msecs_to_jiffies(DRM_HDCP_CHECK_PERIOD_MS));
 		} else {
-			display->adjust.disable = 1;
+			display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 			hdcp_w->encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
 			cancel_delayed_work(&hdcp_w->property_validate_dwork);
 		}
@@ -456,7 +456,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
 	link->dp.assr_enabled = config->assr_enabled;
 	link->dp.mst_enabled = config->mst_enabled;
-	display->adjust.disable = 1;
+	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
 	link->adjust.auth_delay = 3;
 	link->adjust.hdcp1.disable = 0;
 
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index 20e554e771d1..e7b841d960e7 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -53,7 +53,7 @@ static uint8_t is_cp_desired_hdcp1(struct mod_hdcp *hdcp)
 	 */
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_INACTIVE &&
-				!hdcp->displays[i].adjust.disable) {
+				hdcp->displays[i].adjust.disable != MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION) {
 			is_auth_needed = 1;
 			break;
 		}
@@ -74,7 +74,7 @@ static uint8_t is_cp_desired_hdcp2(struct mod_hdcp *hdcp)
 	 */
 	for (i = 0; i < MAX_NUM_OF_DISPLAYS; i++) {
 		if (hdcp->displays[i].state != MOD_HDCP_DISPLAY_INACTIVE &&
-				!hdcp->displays[i].adjust.disable) {
+				hdcp->displays[i].adjust.disable != MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION) {
 			is_auth_needed = 1;
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index d223ed3be5d3..5fbc4c1376e4 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -120,6 +120,12 @@ enum mod_hdcp_display_state {
 	MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED
 };
 
+enum mod_hdcp_display_disable_option {
+	MOD_HDCP_DISPLAY_NOT_DISABLE = 0,
+	MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION,
+	MOD_HDCP_DISPLAY_DISABLE_ENCRYPTION,
+};
+
 struct mod_hdcp_ddc {
 	void *handle;
 	struct {
@@ -149,8 +155,8 @@ struct mod_hdcp_psp {
 };
 
 struct mod_hdcp_display_adjustment {
-	uint8_t disable			: 1;
-	uint8_t reserved		: 7;
+	uint8_t disable			: 2;
+	uint8_t reserved		: 6;
 };
 
 struct mod_hdcp_link_adjustment_hdcp1 {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
