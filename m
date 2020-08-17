Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DADC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F5020758
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aS8CUbS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F5020758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8806E513;
	Mon, 17 Aug 2020 08:30:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A25F6E513
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQY4bHqfHOQSCJ06ESsMjJ8N5347a1d1RzoSytoEex88vaBjueU1NePTSAkLD9T0wZbe11sm/vF9KdrbHgolemZVzUYw15jVqnrpw1pNHbj4n3CTlnO6AeKjOo2rMaZ9235tnM2/DAsTAYD7ZQzlByzUe2WvDQb9HP3BDD3aJovRegJ7lMoVMMv0o39ud2DNqjmn9g1Op8gyT0eU84Cv85N48WczQAvvfYc5Wt66isOjFVksaybRyw7BNZlCMOvstPkEh5ELKeuTKrVrGY/lW73OtlphIyPcYRc7/Uq4BxukDDuY1mEfEBUoBhQWvFgoiYF/K0ydIlKaNBTgjB4oMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNWTSg0i1xVOQDnFgtQ3OVcRfVmfmLZegAd+je7wWZY=;
 b=jZ8BDEIe0Sq/DmSKfvaGb1+7+yFKIUmI5YLVK6LY+FiTgsOD3Kv/xsR+N/9h32M/+22gg4gHv4Fo5Tli6hKq2DLKbBcVt9a+EpVYbOj9Xw7GMrKVpzgUWP1QEFbmMxJgkaTN1CVFi6O8+X8ZO403DiisiNfeXS66ZxUESKp21vXv4tom1JChLPa5fBit+vDGCcThPafXU9lvDyCaJQ3xwhetLV53Xkpn22Sv5GN/6L8VCw9BRitlF2XfAulkfAwcnk0FdtWRwQKxI3ZP0p74IW+E43983JqCyjxh7n2uTibcPQxqbUgzdOxfk9177RXIOsiETfzRB4HMvS0La4pjTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNWTSg0i1xVOQDnFgtQ3OVcRfVmfmLZegAd+je7wWZY=;
 b=aS8CUbS6Esk9dKEquefXQBXfasp98kJ/ba30nMWudcXnkLNVTCP1ai8djJz1FLhMJXzwLxX6mYcvA6fxIqXIXgijGfefDVjCurGNvfW2GLf59Nzb/wyPhnqo3c560mZX/QqwzAfxVeB3YuQ2kdPaq16CC+7iNIsrWzP4KBrRkkY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 08:30:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Mon, 17 Aug 2020
 08:30:18 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amd/pm: widely share the logic for deep sleep control
Date: Mon, 17 Aug 2020 16:29:42 +0800
Message-Id: <20200817082942.25733-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817082942.25733-1-evan.quan@amd.com>
References: <20200817082942.25733-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 08:30:16 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f56a530e-1e10-45e9-113b-08d84287c5f7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3177B5CE99435E58ABED538AE45F0@DM6PR12MB3177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUfgjslFaIPk2B0Y/dSrDwtTvTyxciUArx/xyAt9kplwSrVlecznBtSRMdI7X8ryRIdIRL/rtSseuDTMhka//DOT76P/rMgz3aDPhIY0tyZThFtrcyh8qpIS4Oqt1RNAP5oxktIqpssTI4zRQydp2ee7GD7yoOjdyF6Y8Tfi5Jc/gO/gY6VBWvCD5+Yhteew81AAyeRvMzvppj8g/geLv/tdSWorWYfgpb4Zz35LKOMUyJCUfwL1jnUvk3crUo4E2JNMfnCKlEVTG+aYw4QEqmWIxe9LBXEjPn7XYQXhmgHnNrkVw5IyAvWEy0wPNsK7iqcAY8rqstd7WCo0oMzvlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(66476007)(86362001)(66556008)(316002)(5660300002)(44832011)(83380400001)(4326008)(2906002)(36756003)(6666004)(8936002)(6486002)(8676002)(26005)(956004)(2616005)(6916009)(7696005)(52116002)(478600001)(186003)(16526019)(66946007)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LpZjuvtv/KE7rmkT0UwiUkZL2ztW+krTL76qPIBJBQuNP7xJJIOa1dfGbMooDR3ytcZpsRR7VtMlV16ymYhgzceeR9yA2ED3Me0Lal3uGOR9dZniWL3zMifytCdiDHn/boY6sdlY5cEOmGH2NVbEB3Fbe0VfgVyUyQk7RO9lA60k6Zlk2AaYMb+IOi7a5aK/53iLlXWnE7hdq0pW1PK5mLGQeLlRmnHNOUMuX84RrwlMvjogFLid40Kj031p4mngMqfMg5VmTgOx1JVaJ9ljRaTJzOkaRO3S3ASWFxT1TAelsL/JWEh875BLlOZ02uRYPy9n0bAAvnlnRtyD4pShqDsNXhLjEfVIqvlvFXO1+QQq2SoUW6a6+uFG3qTqpmmntEgKB1f/Qua6ql8MP4zRf7yufNvUdl8pmWX/mxjMdJY1xyFPghyVwhNIp5qrZrV1VoWdbuOufbx3gMdRBt6VJyFSXHj+K4z2wYQRbCUAXQmY2oP6DXRE3zvs8AcSX0rDBm96EHir3RglgzTL7Ul8+FI4Sd+Gah8JuyW3PjxZCv4UIN8zutjjO+jUqFpesWXQhjtEw+5ID1MBuimdkdNqQ/Z1AaZOwkiCsUCE/BVrEBkU4/1GlD7Kf+lF8Z42bDESN4RW9kQ9K3KYxcAxNaGJ8Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56a530e-1e10-45e9-113b-08d84287c5f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 08:30:18.4985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wFP2l185iwZZhl7BAdK2fRP2hTYfMc5rfEgN1/0tGjAj0oC/Acj1V6fZPt3AGEM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Considering the same logic can be applied to Arcturus, Navi1X
and Sienna Cichlid.

Change-Id: I9b80956fee5b094ea0e102601add6c02e3429719
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 35 +------------------
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 35 +------------------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 35 +------------------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 33 +++++++++++++++++
 5 files changed, 39 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 89d70165ac44..1c9464826ff7 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -277,5 +277,8 @@ void smu_v11_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics);
 int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
 
+int smu_v11_0_deep_sleep_control(struct smu_context *smu,
+				 bool enablement);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 81b584abeea2..8347b1f2509f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2313,39 +2313,6 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_0);
 }
 
-static int arcturus_deep_sleep_control(struct smu_context *smu,
-				       bool enablement)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = arcturus_get_allowed_feature_mask,
@@ -2425,7 +2392,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = arcturus_get_gpu_metrics,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
-	.deep_sleep_control = arcturus_deep_sleep_control,
+	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ddb693888d64..72f3d68691d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2578,39 +2578,6 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
-static int navi10_deep_sleep_control(struct smu_context *smu,
-				     bool enablement)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
@@ -2694,7 +2661,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_gpu_metrics = navi10_get_gpu_metrics,
 	.enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
-	.deep_sleep_control = navi10_deep_sleep_control,
+	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b2ad6a5f6728..8ffa8b71b75f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2718,39 +2718,6 @@ static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
-static int sienna_cichlid_deep_sleep_control(struct smu_context *smu,
-					     bool enablement)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
-		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
-		if (ret) {
-			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -2830,7 +2797,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_gpu_metrics = sienna_cichlid_get_gpu_metrics,
 	.enable_mgpu_fan_boost = sienna_cichlid_enable_mgpu_fan_boost,
 	.gfx_ulv_control = smu_v11_0_gfx_ulv_control,
-	.deep_sleep_control = sienna_cichlid_deep_sleep_control,
+	.deep_sleep_control = smu_v11_0_deep_sleep_control,
 };
 
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index f1130a288f1d..548db1edd352 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1996,3 +1996,36 @@ int smu_v11_0_gfx_ulv_control(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_v11_0_deep_sleep_control(struct smu_context *smu,
+				 bool enablement)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
+		if (ret) {
+			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
+			return ret;
+		}
+	}
+
+	return ret;
+}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
