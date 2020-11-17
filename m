Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20573C5519F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 17:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE784238E6
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 17:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TDuezl9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE784238E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCC089483;
	Tue, 17 Nov 2020 17:14:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D388945A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 17:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/dfvy4wZvfYX+Kf99G+Ab/eIOYVkPalYIDkIpmrnxwB3N65TJbYEW+AQtQind5nYdvnSFagoe/3BGxzHXxJGfotD3jsnLc8RAbtwTMs+k9u9CqJ5yPs447tH6hyFxBK/lTFvGNKvQNhhSiJPED1pRklwhTPLqgevcMF22otW9+nJLMLgep/DgX+nEJQDA6I08D+FVNwkl12OVqgee52scA0lWxKnR5/ScEJdqlUiDfz83N2yKnyK79eJxK5Wz1H0ThklSRT1XErVJ0zCGDkRIdtu+Ybi7ozoh0peojuCHh8HicVfGXbUKHg04RME/l3bqI3MQFKMKdwnUO+bw/NTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWe+swAlB1UGfo7uDznaIGYc3JRVRV1Zyu6dE/Ix3zA=;
 b=LU8ns0H4sqqa4rsDVtt/7GgBvmg2PIX9cK4VY1iUnyqsGm0Ngm7TvcBcNK4TCEF/Qs+nbYkzuzWZLPGMBI7qldkcLT/VZnm6XSlJpwFvwb3IvfzR0fGEzuup0MawN0FB5QX/ax491ipUrtUXkexB1pfvsTpz8dGDQHLz+IZgoJoj/PIr/aoXdtG3csNUX39CgG01qw69AkcC1qNKEShudd2OJJKem2B78cqMTUqY2+58WWCp1EgcI/PdTLbHTdR4VzCE+ciK800lMgRRZFTT9OHericmIVWPZuIxS3XTxRQrQ9R+Le4l26eITZmYDOUhHWRursa7vQokNobKfwsb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWe+swAlB1UGfo7uDznaIGYc3JRVRV1Zyu6dE/Ix3zA=;
 b=TDuezl9Lu2oQp0hbVgCuskSNlljg8QjxxSl/HAL+5xE/6M3aue4pPXxckntmpJnbvEW5U4WV8fmHXPUpSnjngYv178vTaV5U/8DhxrSeao0+EEyWClMLAe8Jq02B256gHaeBC5QYSDrfWjpBmv3k4t1Iqi4ErhGdrF9msbGGBZ0=
Received: from DM5PR11CA0010.namprd11.prod.outlook.com (2603:10b6:3:115::20)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 17:14:22 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::7d) by DM5PR11CA0010.outlook.office365.com
 (2603:10b6:3:115::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Tue, 17 Nov 2020 17:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 17:14:22 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 17 Nov
 2020 11:14:21 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 17 Nov 2020 11:14:20 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Add display only once.
Date: Tue, 17 Nov 2020 12:14:09 -0500
Message-ID: <20201117171410.330150-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8290cd9f-1c8a-476c-df67-08d88b1c3a05
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42894657DD111F31A7B7B619F9E20@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6se+5VvV7kMrtJFGWPRlYbqW7EyIRnvtVCNhm61E571rUtB/cxFZlaSJhYNLWpASilGVJ4bJ5XSkqTScst1G6pJ1sKapbNfsRZYrnplFgKB67bHvWX2gU+3k/le+cqvCOEi9n4ZuOpt4s4d9Cw1H6ILf0lmyXDSKZ5po7JU1ZHm8BB9oLjVddp73OhHga23OKfTeoMC8O7dT//lmoyeEgClF8s1OfM3LSez+g5Wce/znXAYB7L/ZtzPrsplnKu85Zok5mDi2RIxp8EmEHHgT9Rm+4jkAL0eaBB1H+yrF93Ty8kM9nSwi66jTIhW0E40PBfTefEiXaqM+iU1lEbFe28l51E1p/y3rGd96iaTlLstJKaT9kb/6GDm2Lh7dgFUE4e6h6eBQ6NnbKjqdzTdd0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(54906003)(316002)(26005)(37006003)(7696005)(6666004)(426003)(5660300002)(186003)(8936002)(8676002)(70206006)(4326008)(2616005)(1076003)(86362001)(70586007)(336012)(81166007)(6862004)(83380400001)(36756003)(478600001)(2906002)(6636002)(82310400003)(82740400003)(356005)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 17:14:22.0744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8290cd9f-1c8a-476c-df67-08d88b1c3a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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
Cc: Zhan Liu <zhan.liu@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
We call add display multiple times because DESIRED->ENABLED cannot
happen instantaneously. We can't compare the new_state/old_state to
avoid this because on unplug we set the state to DESIRED and on hotplug
the state will still be DESIRED.

[How]
Add a flag to dm_connector_state to keep track of when to enable or
disable HDCP

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1772adcf9f98..8df290388d8e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2401,6 +2401,7 @@ static void handle_hpd_irq(void *param)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 #endif
 
 	/*
@@ -2410,8 +2411,10 @@ static void handle_hpd_irq(void *param)
 	mutex_lock(&aconnector->hpd_lock);
 
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-	if (adev->dm.hdcp_workqueue)
+	if (adev->dm.hdcp_workqueue) {
 		hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
++		dm_con_state->update_hdcp = true;
+	}
 #endif
 	if (aconnector->fake_enable)
 		aconnector->fake_enable = false;
@@ -7321,6 +7324,7 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 					    const struct drm_connector *connector, struct hdcp_workqueue *hdcp_w)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 
 	if (old_state->hdcp_content_type != state->hdcp_content_type &&
 	    state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
@@ -7343,14 +7347,16 @@ static bool is_content_protection_different(struct drm_connector_state *state,
 	/* Check if something is connected/enabled, otherwise we start hdcp but nothing is connected/enabled
 	 * hot-plug, headless s3, dpms
 	 */
-	if (state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED && connector->dpms == DRM_MODE_DPMS_ON &&
-	    aconnector->dc_sink != NULL)
+	if (dm_con_state->update_hdcp && state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
+	    connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
+		dm_con_state->update_hdcp = false;
 		return true;
+	}
 
 	if (old_state->content_protection == state->content_protection)
 		return false;
 
-	if (state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED)
+	if (state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED)
 		return true;
 
 	return false;
@@ -8276,6 +8282,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		    connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED) {
 			hdcp_reset_display(adev->dm.hdcp_workqueue, aconnector->dc_link->link_index);
 			new_con_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+			dm_new_con_state->update_hdcp = true;
 			continue;
 		}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f2aebbe4d140..251af783f6b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -484,6 +484,9 @@ struct dm_connector_state {
 	bool underscan_enable;
 	bool freesync_enable;
 	bool freesync_capable;
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+	bool update_hdcp;
+#endif
 	uint8_t abm_level;
 	int vcpi_slots;
 	uint64_t pbn;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
