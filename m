Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C07207ED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PnUDCCkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C07207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184496E03C;
	Tue,  9 Jun 2020 10:21:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDC26E03C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 10:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9lWOj8O3jnwJZYGq8mNcjx85xxVuYt8qRhjCjZckMdwNHgHQACud77DOuingh6cT8miJvaoY3+cTcUmmhhN5HlXyXmdU0xB431/lIXjeTny4WFE9T7ciRyqHYB2H3jwvPkyFPEKGKgMbg1uphARgGxLXASL8Cy39En9aHfqS3GWyk8hSapQrXB9VwJR4KLP6JhuTExYhYRRSjoxvYe0hgl1epEvUTgFNBodWvati2SsGNQI894abp1894aBFW8Oa2jcc7aSZY0APVLVoqxcKgTn04S+Rp9qvlFyv/GaW4Z8v2V4h4i8o+lXsh9OLCZpcAktjL0ojUfzXMDy3p4zeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S5caheyEGMxF1VGQYpPv8Y7Nj2/I/XKeevaIAkPLXo=;
 b=QVm6fHtAiI/7VsveTRVzZF19uVos8+5AXQHK8c5g7w/yT+8dJRTvq+HNwjwVLyiLseJyecldrI/rYSUWpxAWrL4jDoAoYRz4nl8ncnLLol7wwMjze9EQYzVMrdys3JK9+rjiv8I0gUqhAQL7umxjT5+098GnjOhTZ772VCQ9Nd6jmnPWOrK+HDW5ipKo/Okp/XAzB0szs8Tqzc1PWNdJvAn+b4VLiTIIWkxyjx4ucggJJD8ACxNIGq7vyJ/05QybXWDB9A5k9iKVYh7W6ryMn3Mfd8BTxDzgCDN1L0CCFuSQgroV8GQt1CGLVIjOlU2e9plWP11SWmaaQUO3e3fKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S5caheyEGMxF1VGQYpPv8Y7Nj2/I/XKeevaIAkPLXo=;
 b=PnUDCCkp4dqRaYGJUc81JCrapGpRfZCeXkBzL0IXlaZazd0qOZAbDQ89sQRxjjw+837jbM0vEI16heAfo+JtWDBqxOFcUHZXG0CY2/oRsC3L7Pi9ZJVChIwIWFcGTdzQ2xvN6HGvkPWRzQ0pZQh9uDwr6bsFG1LdvgkKJ69zd/8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3084.namprd12.prod.outlook.com (2603:10b6:5:117::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Tue, 9 Jun 2020 10:21:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 10:21:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/powerplay: revise the calling chain on sensor
 reading
Date: Tue,  9 Jun 2020 18:20:16 +0800
Message-Id: <20200609102017.12478-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609102017.12478-1-evan.quan@amd.com>
References: <20200609102017.12478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0071.apcprd04.prod.outlook.com (2603:1096:202:15::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:21:03 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 863a309a-7247-449e-ad4a-08d80c5ed0ed
X-MS-TrafficTypeDiagnostic: DM6PR12MB3084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB308439A229474487D26172A5E4820@DM6PR12MB3084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkhXU5AkpMK1MAl1F48mg+vrcPeoPkoTJG7XG1B/isC2+EqXH35hO6B10U06yYBl4ETlMgaFGI1NNLHOQK8viDL9cRji5ZuTtzzGFPMPZRhJlKxRnN1KL/0vpWGe1jHhSznujwR9y13mp10omY8x+foJOlSynXOxgsWgvV5/g61W4vgK2S0Xy1iTFEJM8uBSkDRCjniigP6cEtDR6juBYFHqRc95IsYNgA4PZBECzGhGxrLOUZIo7iKGabsKNT0YjbknGmpxU/hDYEhrRlpK88WRr06231itb9CxKycFWSfbtn6GevHZzysNGUP6oBRD8tWQao763OaOCz4Yp8L/Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8936002)(478600001)(8676002)(316002)(52116002)(6666004)(4326008)(86362001)(6916009)(7696005)(1076003)(83380400001)(66476007)(5660300002)(2616005)(66556008)(6486002)(66946007)(44832011)(26005)(186003)(2906002)(36756003)(16526019)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cWAGcRVzJrI5ALow5gGH6Lwxb3us36B0ybDWxtVWrPtMImX2wEPheCIQM3XAxbAjZQqg2z5S2MuqTOZi22R3StmGroWAQTZ8RZB2wWmzKAiEkys1k8daETMbuaLR571Sm15pSDQ16D0p5vAq5tCN/kHSz/4MAYGsT+M+VyUcS1KD3j/8cEO90PAXyO/FBEs5vhRNCX+Rldzh8cOrJgzoYIJCRB1BRcXwsGefCG/PtSAzqTI1/YJbCFEHB3rLw4F3/LQ0uUFqAKW6Etd6JnjAna5NUD4LSjt5ifhBfoSqAujt1nAAyEHgk1BnFZYFEOt5V6SBo4wT8ev3eiFgAkp7/uLI8t+ksz3r0zkFhPEEbrGahqwp22qEeB69G9Hz/4IxU9hvLBxxo9qjFMPyxp3eFUXKJKlXPgxl1Rf1iEHmCD3XVbqz937B8Q1AAiXB9yJaiQsAUlP+67atioTU+NkssA6ScTdYYjyccufXOkcUX3noSXUwo2b+o4mGCJcpUAHd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863a309a-7247-449e-ad4a-08d80c5ed0ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:21:04.8239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLk3BGxgV2nDru3VcIrBsi3KhbTTtuhJuLADV9FfxK+S2JcDiY1hqPMOFW9PQrmQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
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

Update the calling chain from "amdgpu_smu.c -> ${asic}_ppt.c ->
smu_v11/12_0.c -> amdgpu_smu.c (smu_common_read_sensor())" to "
"amdgpu_smu.c -> ${asic}_ppt.c -> smu_v11/12_0.c". This can help
to maintain clear code layers. More similar changes will be coming.

Change-Id: I95beba6c117b0cd3b0acea6158bf62240c6eac5a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 81 ++++++++-----------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     |  2 +-
 4 files changed, 35 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 78263de02678..c032680c52b0 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -506,52 +506,6 @@ int smu_get_power_num_states(struct smu_context *smu,
 	return 0;
 }
 
-int smu_common_read_sensor(struct smu_context *smu, enum amd_pp_sensors sensor,
-			   void *data, uint32_t *size)
-{
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int ret = 0;
-
-	if(!data || !size)
-		return -EINVAL;
-
-	switch (sensor) {
-	case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
-		*((uint32_t *)data) = smu->pstate_sclk;
-		*size = 4;
-		break;
-	case AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK:
-		*((uint32_t *)data) = smu->pstate_mclk;
-		*size = 4;
-		break;
-	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
-		ret = smu_feature_get_enabled_mask(smu, (uint32_t *)data, 2);
-		*size = 8;
-		break;
-	case AMDGPU_PP_SENSOR_UVD_POWER:
-		*(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UVD_BIT) ? 1 : 0;
-		*size = 4;
-		break;
-	case AMDGPU_PP_SENSOR_VCE_POWER:
-		*(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_VCE_BIT) ? 1 : 0;
-		*size = 4;
-		break;
-	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
-		*(uint32_t *)data = power_gate->vcn_gated ? 0 : 1;
-		*size = 4;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	if (ret)
-		*size = 0;
-
-	return ret;
-}
-
 int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int argument,
 		     void *table_data, bool drv2smu)
 {
@@ -2338,10 +2292,41 @@ int smu_read_sensor(struct smu_context *smu,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!data || !size)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->read_sensor)
-		ret = smu->ppt_funcs->read_sensor(smu, sensor, data, size);
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
+		*((uint32_t *)data) = smu->pstate_sclk;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK:
+		*((uint32_t *)data) = smu->pstate_mclk;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK:
+		ret = smu_feature_get_enabled_mask(smu, (uint32_t *)data, 2);
+		*size = 8;
+		break;
+	case AMDGPU_PP_SENSOR_UVD_POWER:
+		*(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UVD_BIT) ? 1 : 0;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VCE_POWER:
+		*(uint32_t *)data = smu_feature_is_enabled(smu, SMU_FEATURE_DPM_VCE_BIT) ? 1 : 0;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
+		*(uint32_t *)data = smu->smu_power.power_gate.vcn_gated ? 0 : 1;
+		*size = 4;
+		break;
+	default:
+		if (smu->ppt_funcs->read_sensor)
+			ret = smu->ppt_funcs->read_sensor(smu, sensor, data, size);
+		break;
+	}
 
 	mutex_unlock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 0d1429fc791b..41164a8fbe8a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -695,8 +695,6 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
-int smu_common_read_sensor(struct smu_context *smu, enum amd_pp_sensors sensor,
-			   void *data, uint32_t *size);
 int smu_sys_get_pp_table(struct smu_context *smu, void **table);
 int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
 int smu_get_power_num_states(struct smu_context *smu, struct pp_states_info *state_info);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index d10d15fc7492..1a17d853afbd 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1198,7 +1198,7 @@ int smu_v11_0_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	default:
-		ret = smu_common_read_sensor(smu, sensor, data, size);
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 5b56e7579ff4..ae1035575808 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -226,7 +226,7 @@ int smu_v12_0_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	default:
-		ret = smu_common_read_sensor(smu, sensor, data, size);
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
