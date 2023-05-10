Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8795C7EE24
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2473510E549;
	Wed, 10 May 2023 21:24:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E1E10E53E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STVH1jGrwZRmxDwZPrt3m+ntVH1Hz/troJOob2tNiBTO+SdUSTegvQnUpctCH5oiJZSqFJAQNKbo4yOYHtoa2S5+G8TqQhcGjcWrhkxhwUKNixJ2ij46JZlnTySxxT8K4iY4vWDDRidSWfIzDX5YdMxY6gUqCY8z6huQ2+ikQUOpLyxaqu6U8i5jrTZSlxVAGL4HGaDG2OVRC81sjCL5pvPguhfm+0CKMOduuS0vdXsShM79uitnSy9tqGU2ElOWbDMz/kf23/adB4FP2/VT09ur4hfquHIcNLCp/yYmVMaymIGXVmdKafa+bnZHwUsMkunPaBOCTpy32HUO0ZnKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7pKquVUdEWs2w8xFbjGGtFt6JOpiRt5niOG8rvTTio=;
 b=f2Qns4uAkJUkFsRqAU1q4h4pyhIljC05u8e49S3RZoenJtjhoGjwjnacA1kLoZ2Y5Q4HLf90WViXTS1Dhc6bJc1sj5R0BOpEZGhA9iAYjZGigg8zGnFvT16XJCP1hYHdMUJA6pL/3wvrX3fPk6JDyqeQ9rNeScYVVsgIyv6kcSslTmBIPTFm4y9xh6tekBUFCUmiQ/KVnxj24YIIBj2Qyu19psmREg3XgNXF7ih5jw1HkV6QJXI5PT5XKsjo9siDGqIlkijc/7uwTetpWEQBBQKdZorVdIt3+2W1pFm+kmC/mHc8uD2lg5xoToWKGhnNqN/Z+J+cqTwoAAXduZWSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7pKquVUdEWs2w8xFbjGGtFt6JOpiRt5niOG8rvTTio=;
 b=YymVlEQtUEzhPVPsgCGov80JcCEvPTxmcbgkUIhXIQBxgqhh8I+g9J6oXj9N6nwcPDBVhynnWDbA5kzn88cuIP9yhQusMIWEDxkkY6JZRf/+ZX/Hftw8MEuXJdVatC5V0Y9sRQkfexw75FsgOsuM+JF2oVsK/lgaSFBr0+qDSy4=
Received: from MW4PR03CA0201.namprd03.prod.outlook.com (2603:10b6:303:b8::26)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 21:24:02 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::36) by MW4PR03CA0201.outlook.office365.com
 (2603:10b6:303:b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 21:24:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:24:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:24:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/29] drm/amdgpu: use xcp partition ID for amdgpu_gem
Date: Wed, 10 May 2023 17:23:27 -0400
Message-ID: <20230510212333.2071373-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a3dd0c-659f-4cdc-0c51-08db519ce04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzPdAQb9fcG68HCWXfV5/b8Lb+04POaTX/N/6ZRgQckk15aRtK+JjaW2u3j86RGdMYqacGCp3522ZJ5s5gaSZpQmhRvn84ynNj724jqYjIc0PNkZh8PQnF+ijPERXK6+bN3oQDbN/9EkCEwoEviiqFDXd9mPInVI+PGc1ZSn75m4jRcDOQSH9JbxUEMqrcahM1oEoSYMVFIy2WFxHRJJm8hAF9UnIvlA+EpZW82DJN1iFYXz6Iv2NsqlT3RAGJP9W+W07Mt6tZOfyWn7asuva/IL9W2fVulboFDNVb7w0lk4p1SSYDKwA4JF8KW2cc5nm44uZX9UolWIZfFwbFH2yEQQRuE1Nb0/jBs4/pwkvRRXFY05I8eMKuAD3kkKh7d5Ehvo2TC3ne3Z1GeOvoHrZ+U6D1g4sM4RvEA3/OZS5+haLUUeIMpAi+j2hJKwVtVhETHeypNd3THg1gPVxEYH24aGyN8/rn+cZ0eZZDetAC//J9FLXU4ESLJ8tMUq6izCCGNgHfZTyScC61b8y42QcogAku6oGrfuHKKsBWE6BQLpvVDEewSOo9KIg+ZvJ1t8BI8Py1ZrrVx1U06ZxnZA11lS3eu7kg9to7vEn3dl3B2LdHbRTVEqMraShI7Znn/fF9FtIJMa9Kb+vVVRoeIE81wVSDta5akuF7ACacXgobd8mhqDeyxYB5lU1+pAHALF1VZHT+slCtcyyVWhUHt21QnfMs7NjeH5//uO2+wDKHI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(1076003)(26005)(40480700001)(7696005)(336012)(36860700001)(426003)(2616005)(81166007)(86362001)(356005)(36756003)(82310400005)(186003)(82740400003)(40460700003)(47076005)(83380400001)(54906003)(5660300002)(16526019)(8676002)(6916009)(70206006)(2906002)(478600001)(8936002)(4326008)(6666004)(41300700001)(70586007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:02.1323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a3dd0c-659f-4cdc-0c51-08db519ce04c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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
 Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Find xcp_id from amdgpu_fpriv, use it for amdgpu_gem_object_create.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b02d106d5a0c..aad860667ab5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -336,7 +336,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 retry:
 	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
 				     initial_domain,
-				     flags, ttm_bo_type_device, resv, &gobj, 0);
+				     flags, ttm_bo_type_device, resv, &gobj, fpriv->xcp_id + 1);
 	if (r && r != -ERESTARTSYS) {
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
 			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
@@ -379,6 +379,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	struct ttm_operation_ctx ctx = { true, false };
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_amdgpu_gem_userptr *args = data;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct drm_gem_object *gobj;
 	struct hmm_range *range;
 	struct amdgpu_bo *bo;
@@ -405,7 +406,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 
 	/* create a gem object to contain this object in */
 	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
-				     0, ttm_bo_type_device, NULL, &gobj, 0);
+				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
 	if (r)
 		return r;
 
@@ -908,6 +909,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 			    struct drm_mode_create_dumb *args)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	struct drm_gem_object *gobj;
 	uint32_t handle;
 	u64 flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
@@ -931,7 +933,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 	domain = amdgpu_bo_get_preferred_domain(adev,
 				amdgpu_display_supported_domains(adev, flags));
 	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
-				     ttm_bo_type_device, NULL, &gobj, 0);
+				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
 	if (r)
 		return -ENOMEM;
 
-- 
2.40.1

