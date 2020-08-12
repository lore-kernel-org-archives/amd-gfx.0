Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0CEC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F14020768
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dMIIzp6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F14020768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3D36E8A3;
	Wed, 12 Aug 2020 04:57:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E826E8A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 04:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UG+mqs7Y5MzKrjw+uhPsTX0gmk/d95d2mfz0t7ZGGP8I0Ltb7kUR5eJDoDQfh5d/K3O2nOsiDcRJr6GNgnjj9H0SrTGSgUYZFe2e5WHZI4BF25+Jtm1s8Nn5nqrR3IhWAQLR2X4TeG+83qOB3dSdq/cYedXl5w+IgPWrpczRqDHxUYtp2qozXlJ4vVqXYbGiWFwe/qLzk9Igwynycl6eOrRlkubHFpdwXQO2SsdKmeHbsx0oqpaGFrwoahhQo8NwrdfxW+xjBBTRcWr/WGFU8xntxfHFBiKODUtRsUOpEoU28ZzdkOZhCuqmDKbHBTMdwKkk82oqZIOBC1RD4U2q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt+jcosQbEz6UHR2wusepF83EWMUP6jC86QnKVVuPRw=;
 b=kjmK5S6nSNLMYTzBTPkr+YY/mxLOG03XMFRN9nhTz98TdkBn0diRYJMBNPYpJTbyCwoIb89bQGlnzbQjh2m13aAl3e7embJlvsepynKx8E09P5hucO5NhO9WMQnhXsFe13kQd2KdWv7+bexsGczko66XdhsTYOK+Gq5WDtUWUMpVADMIRL9gXlOAwKSd7p2qgr5ouevVGVw8QLUvVVQRlxwwzs8KmxEtKXgXWwEbyA+JMdwJv/javpxO+2RvUsYN22wwm+uZaLtcCqnaCYBtn+xd7sgMuwBDmSCyYqMHsZ7t1/23hZuBgMhk9YcMt+/5NawTPUwdkY/EU+fUlLmGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt+jcosQbEz6UHR2wusepF83EWMUP6jC86QnKVVuPRw=;
 b=dMIIzp6vC3NBIVhBQZL5KL4MNva33U+1QYmnrb/U6H/J3Q5ymue+BElRwMG+up4N2penP34CjVnDBbxMeRRaAUN1jsFINtXdBqcIgYizNKiFaKwkR0P11WrAQkKSu++4pI52LeG0SW6CSUjX3cV85vXg6pxB0QPOfmgTciYJMzU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.22; Wed, 12 Aug 2020 04:57:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 04:57:18 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amd/powerplay: enable swSMU mgpu fan boost support
Date: Wed, 12 Aug 2020 12:56:45 +0800
Message-Id: <20200812045647.20541-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812045647.20541-1-evan.quan@amd.com>
References: <20200812045647.20541-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.2 via Frontend Transport; Wed, 12 Aug 2020 04:57:17 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f80f86fc-8d16-4806-df18-08d83e7c3083
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2502169C1803EAE6A3729817E4420@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6qGguN2UY+NHDDmgfmmfQYg2aDM7PXySUZxlkRQCq2HQqnibabNOPaITRgH3BU0QaT1BigK2RvthEHQhxZs3DWGGPW0ChZhvJFIUag4tqlZQHIHpCrf3Nspz3VNyUMGtpBTYuGgQgXN58Vlz1WkvOFUoVY/+LCWiMvq9UZVMwexpxJmzSh9xWPOsqh3x7u2tyzvmwOtt868XYWIJ5S5P1KV4L7BL6TS64a2laJrq0vtf0rmGGK83tE526XbXLPobN3Ck3tmveyS5JIdm16T/dO5Og49G7dN0X50KkG+ua8+UgIpf4c8fU6TigDqEJXVJ0DHk58+ovJbilimVqOaKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(86362001)(66556008)(316002)(4326008)(1076003)(2906002)(66946007)(66476007)(5660300002)(6666004)(6486002)(8936002)(16526019)(478600001)(956004)(2616005)(8676002)(186003)(36756003)(83380400001)(6916009)(44832011)(52116002)(26005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PvTPNLbcpkxp53xByu+2FrkgtJe8kmmce6j2L8Z6qIcreRVh+jmDZeGyJMa5Sf0HI+O32/dZqYEfEeU5tYd46CNNS7pAl5Ju+uZ8pbOJ2D8sXjhl3k5/hBPKxtrlVRR8FxUr/s/VHs2xAXNKfgpJGhTKuJoNlArsj66TFkMsSL3z7nzwZdn8X4p9423Db/o1MzjpJbdJZfUotPWs9SUVNGrVGLxyPlDoZ5/IyjCwlfCXYA6s20M0Yp5nOSO9cklyyD38xN6mQ6SqHA7Hscvlr2uA/LVnK4hlSHUOglDL/giPolspUSCB63e1e+cySI9ak8qQ6M/5zYYtkfLi4ceULlSHd4ZY26UrVBhUFTtXmypAdQTTlZbnoCtnhrHYUn9rCqHOWz9vz8S8UV9jGQPxCixBVgv96Uegh2IwQwKaTDwE3ZszMB6i/MgorqvtcVIbnRk3sW+BSxoCzf2Zk3Qld2H0QnsB1poEpT18wY8kHrD4gYFk1TIFYera8TJ4WAlH9qLRZvrD+wM5zuulzb7wdVRC1BMcKcqcz/UjVXND/2lgPBX2AFUijQj+TdKCVdLb7W6WyvY88dxhsl4Bxrh0WgCutPJHVng8lEV2pc8nSFOi0g8z8aixwxMvpQGDd0cA7AL/xw8jq96oLLyqkdgDSA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80f86fc-8d16-4806-df18-08d83e7c3083
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 04:57:18.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfl7yOGYrPlZlvOcjdJ2p4wZKLQWwQE2hlxXVhXY+lvmwQMFFvmN5NCHBWEamAIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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

Enable mgpu fan boost feature on swSMU routines.

Change-Id: I2a48af3ed8b63cc1e601c8d6981e4d6bb3a0b7b8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c        |  5 ++++-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 17 +++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  3 +++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index 9d80cdaf83f1..d9ebb567c0df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1222,9 +1222,12 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 	void *pp_handle = adev->powerplay.pp_handle;
 	const struct amd_pm_funcs *pp_funcs =
 			adev->powerplay.pp_funcs;
+	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost)
+	if (is_support_sw_smu(adev))
+		ret = smu_enable_mgpu_fan_boost(smu);
+	else if (pp_funcs && pp_funcs->enable_mgpu_fan_boost)
 		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index c70f94377644..6c596aeb0b2a 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2632,3 +2632,20 @@ ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu,
 
 	return size;
 }
+
+int smu_enable_mgpu_fan_boost(struct smu_context *smu)
+{
+	int ret = 0;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&smu->mutex);
+
+	if (smu->ppt_funcs->enable_mgpu_fan_boost)
+		ret = smu->ppt_funcs->enable_mgpu_fan_boost(smu);
+
+	mutex_unlock(&smu->mutex);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 8de39b31e7c2..c0098965f460 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -595,6 +595,7 @@ struct pptable_funcs {
 	size_t (*get_pp_feature_mask)(struct smu_context *smu, char *buf);
 	int (*set_pp_feature_mask)(struct smu_context *smu, uint64_t new_mask);
 	ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);
+	int (*enable_mgpu_fan_boost)(struct smu_context *smu);
 };
 
 typedef enum {
@@ -798,5 +799,7 @@ int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
 ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
 
+int smu_enable_mgpu_fan_boost(struct smu_context *smu);
+
 #endif
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
