Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C49C18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E889C2051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tSnKO9Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E889C2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00DA6E450;
	Mon, 16 Mar 2020 13:49:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937856E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+NGIWcTKLqhQj8x9WpXJEAG4uysFbX5UTJss5LfHUzKPS6VLEoSBuiugEzPS0Rl8M3cqNRzI/SUs4AlKzJmcv3J4CCZcTSJSbXdcKtjPg2L+ECQZVRs5YLKI2Xv5hVzRGQUCtwawt1XQ0Y0IC9voDMwunSxl/WHCMDbhsgt2DfgH+OlB4qxh4eTnwBEusL5RkCs2X6+LmTxhB4i2uz8cfbl1Vg4q6rF7ecFTp8DYyMEtUJgggPEbj+xMuGujpdcdagsF9gagqeCKF9K01WckbsmF102SBIYZ4EsyjD5qNHItI9MxULuSXNtb22dVQbMquUarGTyQ7oPD6DqikIKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEiQfwsmnBOpJZfQF7wXaTj2sv2Q14QlyNmLiHvJNUs=;
 b=T8BmaMBINnP27z6AHxFABIS13xf//lb1+uljmQAqD6wCkB13mCGjlPBt7z/doDbRzkE/3I642Zi7OAPJIOYWfoVMB2M/oT89ynJ3Qa0CHWXhw1z+2TtlWlGo+dnRqfrJsVc6WnjRTlkEU3idSnIjdYpdpKtPbh3H/3fPADMs/ebX3EAy3RvaouHP2fWOamuLKfWbB3KbXq39qRFN/fBuhKiG4baQjx/FZiGi7/5cr6Kb+lFHBq1FC+oKyUlBis2moTpB4xNYDVpsmBggGgMuC/dGODixKZUX4wRUMKg/7k4SjSioccZXkwCZNgFGPHHXq9Kj4IQfWFCM7xzXoCvzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEiQfwsmnBOpJZfQF7wXaTj2sv2Q14QlyNmLiHvJNUs=;
 b=tSnKO9Ez2g9Il6zGWxsU/1LSfk0aZJ4ytKPCH/CtVp+tXImglpxSIzgZetDFZeXxoYPxOaKF1bmLA5n1uCSMDg9yNUTduEAhdvI4YRxQiSlqS0Z5ugehFe6bY4j97Avb/74XTsSOXLveP6Ofzx12bccz5tHQEm8PI5w4mowtd+g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:49:53 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:49:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/19] drm/amd/display: update connector->display_info after
 read edid
Date: Mon, 16 Mar 2020 09:49:02 -0400
Message-Id: <20200316134920.2526155-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:52 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62f7a8ed-6b88-445d-b4e4-08d7c9b0e743
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2396BFA48F4A46EAADC1FA9898F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(15650500001)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ma5NSTw1Byo2gle60NccBkGoDkSurgjEfov/LNuerzmqMipCvEys54Xj8KsK78o93kcFKa1ziNYK23hQSrcVGHDdIUVFxVqVmZNpabkvWBVpAy7xZAvB0ideeRm2hsD++DEXOrV/RPM7Yf1g2xknaCoB8rqlEnb/haU9ZpCESxFSgbaORC7FIAs1xn5aNhPTp1+2qWqWnWDbqoiGPbmB9ZPegwMB+Kebu7eGNm2LdG9gx+Y0yG0F8tAiqLFTDj4YoDJJzNB3O8nBUOLz9GLBHyARthsM6w0gaPkFAeop2w9Y/OZptEJP630GJsuoDagG5jvgf/8wwpasn5UabkdLaRT6rS5TlrRvV3y96wNZzM7m0WpuKvkTvCvUG9c/Qg+g09PaRDRapByQshaR2AQjkzYECeLtqxdQixC1MPN2+w2LkhK7H0Qf4KJHwf0ZbwtL
X-MS-Exchange-AntiSpam-MessageData: qVfuAJaxK+3EbqrIswG8W7vgc5Q4NyXuKX71abdktGLSHui9OXZUwDBKbfnkffSU6PVBchIKTK6aAHcn+7yiSLIKP+WtsL+hpDUZ/p57TjY5ti5V3dsW8gjuCyx9Uap+iddr/cnd2faSeE3PvL9c8A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f7a8ed-6b88-445d-b4e4-08d7c9b0e743
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:49:52.9934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9CvRWePE35aX8AXDPPPDCteL1PexLLY2pLVO9UhYELVYDvPBAEoniCe/9PIsk4eTPxEF6MWa/y2Je7M086Z1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Hersen Wu <hersenxs.wu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why]
drm_connector->display_info is not passed to amdgpu_dm right way after
read edid.

[How]
display_info is parsed from edid and saved into drm_connector by
drm_connector_update_edid_proerty which is called within
amdgpu_dm_update_connector_after_detect. call this function after read
edid to update drm_connector->display_info

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  7 ++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  3 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53e64d1a923d..914ab411955a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -132,9 +132,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev);
 /* removes and deallocates the drm structures, created by the above function */
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
-static void
-amdgpu_dm_update_connector_after_detect(struct amdgpu_dm_connector *aconnector);
-
 static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 				struct drm_plane *plane,
 				unsigned long possible_crtcs,
@@ -1896,8 +1893,8 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	caps->aux_min_input_signal = min;
 }
 
-static void
-amdgpu_dm_update_connector_after_detect(struct amdgpu_dm_connector *aconnector)
+void amdgpu_dm_update_connector_after_detect(
+		struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ae25c4c2e18e..3f0c6298b588 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -484,6 +484,9 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
 int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 				      struct dc_plane_state *dc_plane_state);
 
+void amdgpu_dm_update_connector_after_detect(
+		struct amdgpu_dm_connector *aconnector);
+
 extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 2f2b0eb4ebcd..c20fb08c450b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -580,6 +580,20 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		/* We don't need the original edid anymore */
 		kfree(edid);
 
+		/* connector->display_info will be parsed from EDID and saved
+		 * into drm_connector->display_info from edid by call stack
+		 * below:
+		 * drm_parse_ycbcr420_deep_color_info
+		 * drm_parse_hdmi_forum_vsdb
+		 * drm_parse_cea_ext
+		 * drm_add_display_info
+		 * drm_connector_update_edid_property
+		 *
+		 * drm_connector->display_info will be used by amdgpu_dm funcs,
+		 * like fill_stream_properties_from_drm_display_mode
+		 */
+		amdgpu_dm_update_connector_after_detect(aconnector);
+
 		edid_status = dm_helpers_parse_edid_caps(
 						ctx,
 						&sink->dc_edid,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
