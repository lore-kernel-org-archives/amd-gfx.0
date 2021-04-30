Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F56DC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 14:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D454B61040
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 14:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D454B61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B53A6F53B;
	Fri, 30 Apr 2021 14:23:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7B76F53B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 14:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9gzrRhL7g81eJrih3geXJFhZTdmreI+90RhuVYrnyrY+VayFINt6tIgNuTXuHZF1byxerzfNOj8Ob0NR7YeKbPvjbZ/zVqZIXeS1sGaPTUP/lvaP/i3xeyBIR6Und/jx3OhCWQ+B1lLKra5G6dY1aOYwk7foLi29CaOlSh0gao1g4exKQzqUIgoBNbrpRrn02qY3VZdu1pVPFuGhZnc7yDoqDGHEh6RSn3OCHydyUCH6mn7zHHMwH/hMtcJhCKA2H++eJCPLy1kxOkhFZNztDLXGPgm8nn98fK5NfhZ19ici+Oy/GRyx2jJu4x7EGY4eHQJicbHsZiLdq0vpWHSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbws0za2oMWeyCPCUrHM0Ne437ADLbgTXyZJdtw2Flo=;
 b=OgDUH8lLdDS0sY/dwXM0anOT0H4ouvn+Knc3HMzMXALzjhXc9N5uHkGA2pjP355k9doDonsxtCCw1IR1m1V1xuuXxyv09HsfEdbhBB8fjNEU/4sFg0Ngf9+A2s8WU628EWkQmTW13zNaksqssuV2KKhd3Szt7sxpkC/odTPnp9g2F1AI2uwrU6+MplSlWwk4/Q4OkGaiX6yvvzC1e+0smR7QcNZGAJQYEiD7fkFRTFIXliqDXOZTkCNAZ0DI/Y0/Dvy1Dbxp1jCVD5IcSTLuvw4Oapn3MEK7pBhuqoQQerMeV7CbwtebVzPapceHzW5R3ngOx1VxwqR2aWFUP/B2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbws0za2oMWeyCPCUrHM0Ne437ADLbgTXyZJdtw2Flo=;
 b=ksr7t/Pas+3j5ltRldpvIVVwOaHs9/pxPyKj6NnIaabUl5u4sm2MAnir2JXy0nxsl2HlF+jv+HdPezgatFHES+af/nGgH6euT8c0cL7hyjPpiwIf63bZfh9uiJ0Bmg5EwDwUD1fFGRTMPexZG/u1QOEbRSun/FWtp5B5hnLU3n8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3795.namprd12.prod.outlook.com (2603:10b6:a03:1a9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Fri, 30 Apr
 2021 14:23:45 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1855:9722:849:a7e0]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1855:9722:849:a7e0%7]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 14:23:45 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: DP MST hot-unplug cleanup
Date: Fri, 30 Apr 2021 19:53:22 +0530
Message-Id: <20210430142322.147627-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.20.251]
X-ClientProxiedBy: MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::6) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (106.51.20.251) by
 MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 14:23:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6976248e-49ae-42b6-c9d4-08d90be39034
X-MS-TrafficTypeDiagnostic: BY5PR12MB3795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB379529D10E9837B059704C79F25E9@BY5PR12MB3795.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UV2wXzICc93p+x/cL+oH5E5X+le/zBlSTXCvRiWgUg2bKiWXolw4oaVkpFaGk5VXAAwoEHvfZqCSz46C829YWUB2cze9w0pwN+9YE2L52e/L9peYofO6aDCGjWI2EEyG8qRAuawteHib3yxIsLKJ8cXTR/U5ts0tjcVHMTkKnJBv8k86AV42+zYw5yb2foCdTFv1dplPIDh5KvDXTVmGAGfYaHhLI4QIPZBLJ9cfDCS1E4fxGxYJC14oWjG3EsbfdaaWMWHSegNJtq9Nx7MBEmvUSGiKuHYCGM/J9Y7hVpDjR+cMURDKViavRg8/ed9GI4S4N2cjGlnMJXn8c9fYD0CywUT9bDM+j+yxIgIM/QP2fSaN344KsTkecgIy4dGmFngv/HF0cV7RVh3Muz7R1nLE9iJczmoV8H9VnQTzDIyaF5gLcKzo9eRsJDHchYDNy4pRw3koAMec5+c4xG/PshywERBha9Jjp6rI3C6nt/xR7FWFpf8CCWYtkQx/Ykssud/hTBwDBtPrA/KUM+wBA8qXVfqzGAv6mwCYq4RaFyyPUVRGNK0NYg4X+wDicnDPtt8l/c717NWo4anb3NWvz5LJd0fVwBvMvjKOAIsyIx+3S6/l773UE1ER4WGlue1pPM26H7JeRljASkkL829yTca0P0dalsSMJ1YhsMcr4MJFSNdvLT8wwcPdTduD+jp8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(2616005)(54906003)(8676002)(86362001)(38100700002)(4326008)(44832011)(5660300002)(956004)(8936002)(6512007)(26005)(316002)(186003)(16526019)(6916009)(478600001)(66476007)(66556008)(1076003)(66946007)(38350700002)(36756003)(6666004)(6506007)(55236004)(83380400001)(6486002)(1006002)(52116002)(2906002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BMF4Wlgwn3BxUE6+OjRnKT0b+EE9Lt+YOMhykoMOpYSIyCvBuqqknsA7SUgH?=
 =?us-ascii?Q?Q4ip15REuLj82sxjDPFBt1z8ulcDCR6DFWJQRWKm4nbk9cxM9rOu5W3dDn0U?=
 =?us-ascii?Q?GnAz75T9MaNM11BndZoCrKVFGfHxJ2S87yx/AjGPT+KFARyP2Dc5ELU0ns34?=
 =?us-ascii?Q?zO7Pmlyi0X5ddESgZgPcT3agh3fwB6vzJZAoKWaybsEBljKaY81EQWC/4lgz?=
 =?us-ascii?Q?aSGEu2OqJJhO+SSbitfqOAE9QWKDGqVRKPbrXA6bRblWMddBazWKH2nZTvYM?=
 =?us-ascii?Q?G5j+b2gA8mVb1i7vnc2JBKdcH582HnD9WpVvNYXQvfz3rIIokumJdHXcrHSR?=
 =?us-ascii?Q?Y9UpJqrR5ahaO/2vaHAabPPoYZAFtqJm4TnCA7b7V3rqKPELtgbigMFMZumK?=
 =?us-ascii?Q?zCjyVMOnsU+kDYWNgPMuXwBbDKtTGj1YEU8iFkmGNeQ1diJXOzrLtbpvr6sy?=
 =?us-ascii?Q?QQANCmv34QlKED6KyOIciYVPL1/UiLpQpGwUnN1OSFgeZZV4uHzycYYtEypM?=
 =?us-ascii?Q?+jBiPG9Ps7okuKHGxSGdjK+fpb3r+WR9nE1WyPvImWZrDNPu/VuedA0Up0wC?=
 =?us-ascii?Q?gLJ1afoczBj51Q4z0UhR/4UwxDzBjdwV10Q+8d4SpVHm82aTSUSYdzKdPjHX?=
 =?us-ascii?Q?smFGRBE/dkuyN/JrIRcAbgrgZ8qhgmKQbgq4WdqaH2JE8AdE3M2MHfHOmPo6?=
 =?us-ascii?Q?+ZuSJKHz8q9qB+nIPqALLrqA1M2P/xARhI9xp+qAUWJF6lgV6Rv/FS/UdIsG?=
 =?us-ascii?Q?GRnLjr8t+x5rKLniSH3yuyxJfPPdeMqh4R3HJx7WZesOAgtdW+24g4uzaGZa?=
 =?us-ascii?Q?TfNvbQJoOFC08UN9OHMuXfR9t4+5Tb4bDHatn7ybdn6z0gPqs08oH4akcz2J?=
 =?us-ascii?Q?Og3A3/bHQ0X4qz2qRU2FGGH/XVpcnkMZjTNxZmai+YA2Y8fKB4tnKQ+SJ2zY?=
 =?us-ascii?Q?BNsLJhPckkd4t3n6Q+Obl298/rzF3M8pv1g1sxjglRNqZ6nx9Eb0qtTKdyeP?=
 =?us-ascii?Q?5RV61BhA68Ju7heg275rhhyFyxSYqieOv7ptz67aG5GQuwFXkK0LM9lynD4c?=
 =?us-ascii?Q?0RuIr7xqh6nZjS6UCUz1ikkaKD99qK5h8etTKz0L1HdPa+THihkJbNffCkeH?=
 =?us-ascii?Q?HbpYM8PYjd5Az9AivLH+QpWbDsfowNiAMU5ZhXcPL6KOFLtVbuOY5titYq7Y?=
 =?us-ascii?Q?p1pWX1LKsIlOgtqTlVE2BTB4P7ZvIgipCWWTiPYAXbqGZl2qw6W+TkV/sAx6?=
 =?us-ascii?Q?HVpD8wXbSjDVZXkMb/+BoNbcrRwJEgmRMvAIJyzVnZfhJTGoxrQI4GaLMLW+?=
 =?us-ascii?Q?zckebLhu8fHDrFTy/Ea2J0JD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6976248e-49ae-42b6-c9d4-08d90be39034
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 14:23:45.6175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ/S0Pdsjs6GwlL+rocv4GU+4AwLWevVnc38aJLAI02nmI/bZOml4ZFOT2UPwgBPyGhTsEpZgqLbHjFFVF8RuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3795
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The current DP MST hotplug handling sequence adds new remote
sinks during the MST plug-in, but it doesn't removes it during
the unplug, which results into saturation of sink count after
2 contineous hotplugs (dual monitor scenario).

This patch adds a clean-up sequence during the hot-unplug situation.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8dc5005bec0a..8b87dd0a3d50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -220,6 +220,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		struct dc_sink_init_data init_params = {
 				.link = aconnector->dc_link,
 				.sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST };
+
 		dc_sink = dc_link_add_remote_sink(
 			aconnector->dc_link,
 			(uint8_t *)aconnector->edid,
@@ -266,15 +267,42 @@ dm_mst_atomic_best_encoder(struct drm_connector *connector,
 	return &adev->dm.mst_encoders[acrtc->crtc_id].base;
 }
 
+static void
+dm_dp_mst_sink_cleanup(struct drm_connector *connector)
+{
+	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
+
+	if (aconnector->dc_sink)
+		dc_link_remove_remote_sink(aconnector->dc_link,
+					   aconnector->dc_sink);
+
+	if (aconnector->edid) {
+		kfree(aconnector->edid);
+		aconnector->edid = NULL;
+	}
+}
+
 static int
 dm_dp_mst_detect(struct drm_connector *connector,
 		 struct drm_modeset_acquire_ctx *ctx, bool force)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_dm_connector *master = aconnector->mst_port;
+	enum drm_connector_status status;
 
-	return drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
+	status = drm_dp_mst_detect_port(connector, ctx, &master->mst_mgr,
 				      aconnector->port);
+
+	if ((status == connector_status_disconnected) &&
+	    (connector->status == connector_status_connected)) {
+
+		/* Fresh hot-unplug scenario, sink cleaup required */
+		DRM_DEBUG_DRIVER("[CONNECTOR:%d:%s] MST hot-unplug, doing sink cleanup\n",
+		connector->base.id, connector->name);
+		dm_dp_mst_sink_cleanup(connector);
+	}
+
+	return status;
 }
 
 static int dm_dp_mst_atomic_check(struct drm_connector *connector,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
