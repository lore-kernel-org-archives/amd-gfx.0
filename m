Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37161C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C39610ED4F;
	Thu, 20 Apr 2023 23:50:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C379810ED4B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnVpmuPiUL8W9XN0IDFXFJnOEsYYmZNNkgvdTBn0mLHDKxqFBojtmccpqI19dyK22qAVfQeRw+mQE3HjiyYQX/acu4GRcYy+pWLhY3LJogyJi4Ygfq2RH+vPMYOQN4hRKIpoBSrd3IGIlGUHwAnzqmBdvr2ngvZ3CC90pbeuw8e1i/k5w70vtLxJ65Ak2OE+Wa4bbVJhNaovNwEihECTGdAiAWVNJ8I0dusTep5zEWGVx2LCO6+EFd9fu6mudoFRxTnxxnTVpEVZdKK/csHbqi3fcQE/dxMwxk8EO2rJgsXprRVViCF3JgZxJlBwmgAhqak9CveoYwzHjfPP7NJjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNfbirybaq4SNBa8QOZo0T7pHA4rOLGKndq26TzceSs=;
 b=oBqXlr+x8kTNtngVxv9ocqjOIdp01ySbBGhqzjtDxcmsze3ynjor2CfzM1c0Qzz0ArV2k+0gCu3GJL5JPJC+K4cIThCN8LT72NL+v3Gs6a6xQLpsifl5l/Fmnf5hS0tndIj3wwzmiP5X2+iVP0WpKTb7ckxWEMZHAnw+rUukPtfW8tps/5Mex2UmeUccjZPALWvsid3gvyVFAsxadRYLXZChOCdNuIpgEHJVh7ssN/xEFCrlfI+rn5BpZHfnTkExcQWLhdgKMG1/efIwIz+YQFxUttVwlDUxCSlz0YxRZB4iOBlnUv5qxQZI2hFEjpDhHSSz4vkxtxbCJNApJl4t/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNfbirybaq4SNBa8QOZo0T7pHA4rOLGKndq26TzceSs=;
 b=m/V459lySO0djO6R9/3+sk1cRRYKUiJrtZz7U47UsPw/jspTfNp5GGbQ2bKZewHJoMtD23fk9M5izfB7/Ehsq0nuG5yb8RwAaeTlUeDYDnxqsLWfeiq42qpaN2uxdUK9TT0VkDMkFXRPxCPMwerCyqKq9pXliT/LcYoW+VM9aws=
Received: from DS7PR06CA0013.namprd06.prod.outlook.com (2603:10b6:8:2a::13) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:17 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::6e) by DS7PR06CA0013.outlook.office365.com
 (2603:10b6:8:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.25 via Frontend Transport; Thu, 20 Apr 2023 23:50:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:14 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/21] drm/amd/display: implement force function in
 amdgpu_dm_connector_funcs
Date: Thu, 20 Apr 2023 17:49:35 -0600
Message-ID: <20230420234951.1772270-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c6e3ea-c1c5-45ea-bbad-08db41f9fe11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPdqW0yMvS0RTa0EC4ROsv8dhwY35mcrUNOcBxrt90sSJJbgPrsF4DKf2Y4D7THb8Hx3C3T3wO1ah23yomZUm6vjlsukLja8AqFFju9RueIssiViBydM4T+eImfIBSVttcnYMa1m2dsZNqFU8q8/0kJfJRzuUGCbBy1FAZook9DEEKW73B/aDht/u5/rqoTMZUBba1EpGdHS2ITbkSYpZAmysum9GC4cM1lc0MaWqUUIrcm1jsoTFTIhOGj3x+PhDzdlyplzXsVspK0CX18+Qorr1dmufS1qK4zApeQhhXBGEWKlkbOL2/NrlwkLtOMEL8UJSJibXUparM4R877/AFFXc5O4i4MMg2j20n1R2FV3QJiFA3JVuwHwicW15xVxT7gYRkKNwk2QDzi94SUDKyJP/YaGuPLpHpdHLE92Plp7C/8Xl0PmPuWQSdaeoqgv2ePYD+kDeol6rRqrJ8cIMwfIBWdNMkuArVhFxzY42n72rBGgB4SfmLV8xgdfo4EV/IHcuBGPmj1obgy8zp+5XskmuR47EsAvpw2RpDi0ielA4/9SE2kyw/RgkU/Je16mf2u2Qh7WCrtddrKcufrf1rpZNwgANc6r/N2eLVztd5FW9+8LvTMgtfZRnXF/xBZD0g1Zap/oJ7bBG+ayvKiSXamlz5+DuJG/htVGe8Px73pjsj005OapBPQlGUIgZCKvvsk8nlNN/E3galtihfcTQhO6VjWk07p3ZGvrP0fmX/Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(82740400003)(356005)(81166007)(40460700003)(86362001)(82310400005)(40480700001)(478600001)(54906003)(316002)(41300700001)(70586007)(70206006)(6916009)(4326008)(26005)(1076003)(16526019)(36860700001)(186003)(36756003)(6666004)(47076005)(8936002)(8676002)(426003)(336012)(83380400001)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:16.7513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c6e3ea-c1c5-45ea-bbad-08db41f9fe11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
 qingqing.zhuo@amd.com, Wenchieh Chien <wenchieh.chien@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why]
When userspace (IGT) inserts EDID with audio data (ELD), EDID
is not updated.

[How]
Implements force function (amdgpu_dm_connector_funcs_force) in
amdgpu_dm_connector_funcs to create emulated sink and to handle
EDID.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenchieh Chien <wenchieh.chien@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1565126ad2a..4db4f5a371a5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6345,6 +6345,31 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 	return 0;
 }
 
+void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+	struct dc_link *dc_link = aconnector->dc_link;
+	struct dc_sink *dc_em_sink = aconnector->dc_em_sink;
+	struct edid *edid;
+
+	if (!connector->edid_override)
+		return;
+
+	drm_edid_override_connector_update(&aconnector->base);
+	edid = aconnector->base.edid_blob_ptr->data;
+	aconnector->edid = edid;
+
+	/* Update emulated (virtual) sink's EDID */
+	if (dc_em_sink && dc_link) {
+		memset(&dc_em_sink->edid_caps, 0, sizeof(struct dc_edid_caps));
+		memmove(dc_em_sink->dc_edid.raw_edid, edid, (edid->extensions + 1) * EDID_LENGTH);
+		dm_helpers_parse_edid_caps(
+			dc_link,
+			&dc_em_sink->dc_edid,
+			&dc_em_sink->edid_caps);
+	}
+}
+
 static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.detect = amdgpu_dm_connector_detect,
@@ -6355,7 +6380,8 @@ static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
 	.atomic_set_property = amdgpu_dm_connector_atomic_set_property,
 	.atomic_get_property = amdgpu_dm_connector_atomic_get_property,
 	.late_register = amdgpu_dm_connector_late_register,
-	.early_unregister = amdgpu_dm_connector_unregister
+	.early_unregister = amdgpu_dm_connector_unregister,
+	.force = amdgpu_dm_connector_funcs_force
 };
 
 static int get_modes(struct drm_connector *connector)
-- 
2.39.2

