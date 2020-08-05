Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF59C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62012067C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LX4vVCDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62012067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7D489FC0;
	Wed,  5 Aug 2020 09:38:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD2F89FC0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 09:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9c3Pp7YClGHwI+a028NepFfmfyxjZUR98FAa5cTSINTKwICycbnHioSiAgYf0pUrGrMt90K/mzhvfH/od7/k3e1uHrR/+fdcwphfjDEZcYINGINsrwQZjNL5nWg8d52jsDZ9Fb3Vkwj+qxKWdo6TdZgnrR8cEijf2NGBJvMuGODQ4ZQ+lQQiujeBzkQLKYt2gbgpLvzzbrOX6k7Q1oBnSeavildHUjDRHIFzE+DohsLeW4YOvtZTwUAr5XarosHGtDbnhAExNJ0qAR521xo9JSI+b/q+CQnmRcvPFVTFyVw3sCEVTX7Tyaq/B9r6OU56mg1lFPpm3c9AGWiNC0Hgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVXo5S8vXbzRN/SmxNSuu5d2wKr6o3eoAjGBAutGP9E=;
 b=nPnk8PxJmwG3Zlqn5k9XHzLdrUKu6OO/taKxdCpgt7vz1LtxatLnQlmaHqltEFeczWT3lS+rT3s6r49QsD1Uf6++/BRJPmMloeT1CsDiwcCrFm6wCmnD0gSyhV9NMZwlbZtgforz54IVO7vypSiKXJ62/kk0Sg+RyRL0WAZ0mOfZqEtxoVVygC+L3gtjpcWUYlYAf6cvKMMqNzelLKwggnlgCBJd4zoZQ9yNkGLniYwWeDw7jegbWKCucDJsLkDdinW7gwmQfwnS+gHwdcqUq/7NCpvTf3FSq0dCrOFf5pUJEIfJR1/MCTj18lbvQ5itWN6JUHYYOYJIHWDwN5gLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVXo5S8vXbzRN/SmxNSuu5d2wKr6o3eoAjGBAutGP9E=;
 b=LX4vVCDXIJl215g7wRLhN1wId4PYZfmnxs4hxFBr8TTVdoHm4mSoFhJwsmhU/+jiCFILIb9lBAKqEnu8zdZy6YRvSTmYxvo6Z3cvrphSxk/2LVIO/s41r/2doYZTB95q8SyhgC0fVhUld6+96O4adZkqtwPkuVBz3xSzxLtT7jM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Wed, 5 Aug 2020 09:38:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 09:38:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/powerplay: put VCN/JPEG into PG ungate state
 before dpm table setup(V3)
Date: Wed,  5 Aug 2020 17:37:21 +0800
Message-Id: <20200805093721.2955-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805093721.2955-1-evan.quan@amd.com>
References: <20200805093721.2955-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR03CA0108.apcprd03.prod.outlook.com (2603:1096:203:b0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15 via Frontend Transport; Wed, 5 Aug 2020 09:38:03 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cf14c36-c12a-488b-32f5-08d839234108
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13535675C702F32C93BC173FE44B0@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8LJrIK3iS8DPM/7QKMtvusc/WVTnCjwKWu9dMLJbWQ0IJdS5sF46V/DEyk4nZU5wZg6Ms2cFqY5/4vMH13CaoOtvfq+wkWkKG64QxHUH45NfvtHdK6FDc6woq6jV0X9Ax2aNaBs1gOsyLniMDueCEJdiq+cSRIcGFMjP9amTd0jjzc3htRXuWh+FE4AvR8ZXpVzmA0uGJN+8wJRBoME88mB6r5V0iaN2CbhOfPOj+Q9mbVVF2p+jLZVcYwEGlFSB9h1TyQvwR9xm1YKGoC8dbc49IPcTmwQb0LZPGlnOxgWALhU1A1nSb5cEMzKgfNhSC35gVYOfW6yO/zeu2mg5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(478600001)(956004)(5660300002)(2906002)(26005)(54906003)(4326008)(44832011)(86362001)(8936002)(36756003)(6486002)(8676002)(2616005)(52116002)(66476007)(16526019)(6916009)(66946007)(66556008)(7696005)(186003)(83380400001)(6666004)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4D8F+MpcV06OCypIgcfE7k9p3OoQ9H2HiepVqlwnAWs88fIueExWVHcJwJEQL0hIQvIZbu1qKix3toT/i2wNEU5XJLj8YlkOjphih2Oi/vaVUq5ZaiFIlN7Q2PJCWsB0RHviNZPPTTwC0HXZCapr9JVGUUFiysTWBC9KHgdD3lRAquGy+7JrdLTHPf9lmzEexyAMHYHsbWYXenbV7t+dgNwlqOSWgejcPspKhAGF2ibNIa+wI6VOQ+c4+jtLO8+iXMWWVKCF4e1UnCi5lyESqi2LmXhVe1LWiyxyiPWxoMk8czoxi3EFeTlJA9GW5NHfnFoSYwNgyswsoYt0MJM2eM6Ug0gq/rXbzUL86ttDfZgo9UM4106lmvdGaP4dfebClKGik1y0662mulOjrpR/IfjXQGGN9qf+8nJQIcql+7bTSE+oCI5BjbA1dVctW+ucGn7oFTcZNbFQ1+jcFdER/1mYoOJESFlm8EABqTrshWF3w4MlEtZ/llfUjbcA5KvwYRiYqLcnqfsH6oRGfD5rKKwAE2DjsvFDuzjy8OEosFqhqMzBKo+td4jtRSOaTRicUCb6vncbqPQPAgtY/N/3+JQAYfsRIMblTLLdV4FRvdIF5THpRAZG0sb55rA/Rtw1AuHH2oePRXOpGBmk3Y38nQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf14c36-c12a-488b-32f5-08d839234108
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 09:38:05.3448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6Z6Lr5nyyyF/Y23yptYh/LwUnVIdBeYp875dVJjfJcUdPvmbrPlcMpvMeVjRuRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
Cc: alexander.deucher@amd.com, Matt Coffin <mcoffin13@gmail.com>,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As VCN related dpm table setup needs VCN be in PG ungate state. Same logics
applies to JPEG.

V2: fix paste typo
V3: code cosmetic

Change-Id: I0e4d97ebedc132b7d793dc3f36275066ff999eac
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Matt Coffin <mcoffin13@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 89 +++++++++++++++++---
 drivers/gpu/drm/amd/powerplay/smu_internal.h |  1 -
 2 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 1b64ca9ecccb..1ced80238f8a 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -133,6 +133,23 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
+					 bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (atomic_read(&power_gate->vcn_gated) ^ enable)
+		return 0;
+
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->vcn_gated, !enable);
+
+	return ret;
+}
+
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 				  bool enable)
 {
@@ -145,19 +162,30 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 
 	mutex_lock(&power_gate->vcn_gate_lock);
 
-	if (atomic_read(&power_gate->vcn_gated) ^ enable)
-		goto out;
-
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
-	if (!ret)
-		atomic_set(&power_gate->vcn_gated, !enable);
+	ret = smu_dpm_set_vcn_enable_locked(smu, enable);
 
-out:
 	mutex_unlock(&power_gate->vcn_gate_lock);
 
 	return ret;
 }
 
+static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
+					  bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (atomic_read(&power_gate->jpeg_gated) ^ enable)
+		return 0;
+
+	ret = smu->ppt_funcs->dpm_set_jpeg_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->jpeg_gated, !enable);
+
+	return ret;
+}
+
 static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
 				   bool enable)
 {
@@ -170,14 +198,8 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
 
 	mutex_lock(&power_gate->jpeg_gate_lock);
 
-	if (atomic_read(&power_gate->jpeg_gated) ^ enable)
-		goto out;
-
-	ret = smu->ppt_funcs->dpm_set_jpeg_enable(smu, enable);
-	if (!ret)
-		atomic_set(&power_gate->jpeg_gated, !enable);
+	ret = smu_dpm_set_jpeg_enable_locked(smu, enable);
 
-out:
 	mutex_unlock(&power_gate->jpeg_gate_lock);
 
 	return ret;
@@ -403,6 +425,45 @@ static int smu_early_init(void *handle)
 	return smu_set_funcs(adev);
 }
 
+static int smu_set_default_dpm_table(struct smu_context *smu)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int vcn_gate, jpeg_gate;
+	int ret = 0;
+
+	if (!smu->ppt_funcs->set_default_dpm_table)
+		return 0;
+
+	mutex_lock(&power_gate->vcn_gate_lock);
+	mutex_lock(&power_gate->jpeg_gate_lock);
+
+	vcn_gate = atomic_read(&power_gate->vcn_gated);
+	jpeg_gate = atomic_read(&power_gate->jpeg_gated);
+
+	ret = smu_dpm_set_vcn_enable_locked(smu, true);
+	if (ret)
+		goto err0_out;
+
+	ret = smu_dpm_set_jpeg_enable_locked(smu, true);
+	if (ret)
+		goto err1_out;
+
+	ret = smu->ppt_funcs->set_default_dpm_table(smu);
+	if (ret)
+		dev_err(smu->adev->dev,
+			"Failed to setup default dpm clock tables!\n");
+
+	smu_dpm_set_jpeg_enable_locked(smu, !jpeg_gate);
+err1_out:
+	smu_dpm_set_vcn_enable_locked(smu, !vcn_gate);
+err0_out:
+	mutex_unlock(&power_gate->jpeg_gate_lock);
+	mutex_unlock(&power_gate->vcn_gate_lock);
+
+	return ret;
+}
+
 static int smu_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index f1d8f247e589..264073d4e263 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -60,7 +60,6 @@
 #define smu_disable_all_features_with_exception(smu, mask)		smu_ppt_funcs(disable_all_features_with_exception, 0, smu, mask)
 #define smu_is_dpm_running(smu)						smu_ppt_funcs(is_dpm_running, 0 , smu)
 #define smu_notify_display_change(smu)					smu_ppt_funcs(notify_display_change, 0, smu)
-#define smu_set_default_dpm_table(smu)					smu_ppt_funcs(set_default_dpm_table, 0, smu)
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
 #define smu_set_default_od8_settings(smu)				smu_ppt_funcs(set_default_od8_settings, 0, smu)
 #define smu_enable_thermal_alert(smu)					smu_ppt_funcs(enable_thermal_alert, 0, smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
