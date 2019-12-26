Return-Path: <SRS0=shUv=2Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB47AC2D0DA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 08:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77EA2071E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 08:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ntGvXYkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77EA2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFB989A83;
	Thu, 26 Dec 2019 08:11:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E5089A83
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2019 08:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2eQexLI3ZhE24q7GAAbxwwhYR3nwbSE99c+5x+AxtzWn0Gc/hEcMucUei0bIKqJRVOIS2wT+NpKjSFKLzR2FGYb52TmP9Nc2El8FP/Z549aE5/obLud0MDs7BbxrkOfJuR87ScSvpGKBHN9FohKfKViPLR/cNKuHNjHsWZaGbriAG20gFV0XLjeoAzozlJiNuEfueaNjsgzEc+6Fk1E/FOLXvpioVs+wPG5AqNjNC5DC4ytf7syvfBXl22KBlOm5sOTmMLy3F1iKlGcnToJQGqBi82qNQFARa4vHW682t5HnaOBKnU1JIYzQ9rWWTbwg14jxGC0ZRiQH0y/gJm4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2ahXyHPuDLdDrLlAPC0NzIH5JDWc8b6F3k2JJdYLAY=;
 b=AGCG0dzoTV6SJjyHw3xd9zmCqpDwnnD/iFQq2ZQ2ID9nelisv9K/fqchJoibg+QDk8boQ9MiPczGCQ+2xYP5Qab18QDjLcm390q5XWbN1Y62SWKj5q50dD2GjGL7kWpyfYnx2Ogf00+u+pzq/calPoACZtyGXGe0JZpUr+MOXWJ/HPsqxGPbERDSl/GL8jGtDk5SAyCCHGIKEBMfo3+hEWmP306lVa8e8WaLZVG6rJ2bPHIPQn2tvFqQaQgH4qQ27fNtaGJuuYcPfy2OaE/x6l1WCMttkWK7+dUKPLYkS6jpcMSQL+IhZ3g6JFafy1+To005P5poVULMcD0VDopfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2ahXyHPuDLdDrLlAPC0NzIH5JDWc8b6F3k2JJdYLAY=;
 b=ntGvXYkTartQvIdGGDQh1/cyYVLw2bAEGqwkMm+y8/KPyBJTJiGmwjkknqXoCh2oA6rQUKLtvBKPZ7jwX6h1/AAH8nyqKsC16vnkZkinEpdKh1LOrubyF3KeTVbkdLiqWtwl+igdw3+7iAJA3JZ60cIa16baGCMuLyiVTDZ/nBY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3200.namprd12.prod.outlook.com (20.179.82.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 08:11:10 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 08:11:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: handle mp1 state properly on suspend or
 device removal
Date: Thu, 26 Dec 2019 16:10:40 +0800
Message-Id: <20191226081041.8747-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Thu, 26 Dec 2019 08:11:08 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c59b4006-5163-410b-acbc-08d789db2aa1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3200:|MN2PR12MB3200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3200A4F0BEF159897F1B3C43E42B0@MN2PR12MB3200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-Forefront-PRVS: 02638D901B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(81166006)(86362001)(186003)(36756003)(6916009)(26005)(1076003)(4326008)(7696005)(52116002)(6486002)(6666004)(16526019)(66946007)(66556008)(478600001)(8676002)(66476007)(8936002)(81156014)(956004)(2616005)(44832011)(5660300002)(2906002)(316002)(15650500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3200;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tf55F2BOo4oHLEe0AhOvpF/S2KrHv92q1PwrQU9aW8nPyA+ySF+sxx8aA5Gls+SqaB+iGrd2XyKV8SZG5kshYVnPJCCu8mjYtXX/4KMZdLFCzLmLWmgEOFsVCEkZU1wDYzy8KuUUTbNYwIwpaxBkSj5o7cCz0gf1zkTzfrsF6YlQXHwVgOrzDekn56SSIX53OVlRKIWq3+PMgH5qIKQYuIbjLawM62OCOGiZ82MwSw+o6peAzLp2rAc5H+VVjry2Qoa+cOsPlUR7vqXdG3j144NozNTEBq59ECrhAzPLR5c04+yIpvfJNlsoAR7eFyU8cH66u01ITk35bE21qROWEJVNqDzyFp+kqP/CVBJw0FBCWsgkOEyRHzX4xIVNznN0fCur10sSn1iLdyR9KJIGd11uxJzmRBBmPY6XAYSmmangT6NVNBSAG0gceguU7i2K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59b4006-5163-410b-acbc-08d789db2aa1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2019 08:11:10.6034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmq7W0uvz1cLTevcnSwUpVIyGM37nXdumMkHzbFWBnIp/uMv5bH3Pq8TsTIp4vNv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3200
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set mp1 state properly for non gpu reset cases.

Change-Id: I2a007910da6b5e2d1f8915d17827621ebd2e8c59
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 16 ++++++++++++++--
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 13 +++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d36245321cb0..739ff4e4e845 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1089,6 +1089,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 static void amdgpu_switcheroo_set_state(struct pci_dev *pdev, enum vga_switcheroo_state state)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = dev->dev_private;
 	int r;
 
 	if (amdgpu_device_supports_boco(dev) && state == VGA_SWITCHEROO_OFF)
@@ -1112,7 +1113,9 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev, enum vga_switchero
 		pr_info("amdgpu: switched off\n");
 		drm_kms_helper_poll_disable(dev);
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
+		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
 		amdgpu_device_suspend(dev, true);
+		adev->mp1_state = PP_MP1_STATE_NONE;
 		pci_save_state(dev->pdev);
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 61dc26515c7e..13278f1c1b14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1157,8 +1157,14 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 static int amdgpu_pmops_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_dev->dev_private;
+	int r;
+
+	adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
+	r = amdgpu_device_suspend(drm_dev, true);
+	adev->mp1_state = PP_MP1_STATE_NONE;
 
-	return amdgpu_device_suspend(drm_dev, true);
+	return r;
 }
 
 static int amdgpu_pmops_resume(struct device *dev)
@@ -1198,8 +1204,14 @@ static int amdgpu_pmops_thaw(struct device *dev)
 static int amdgpu_pmops_poweroff(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_dev->dev_private;
+	int r;
+
+	adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
+	r = amdgpu_device_suspend(drm_dev, true);
+	adev->mp1_state = PP_MP1_STATE_NONE;
 
-	return amdgpu_device_suspend(drm_dev, true);
+	return r;
 }
 
 static int amdgpu_pmops_restore(struct device *dev)
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d07c4f2ccee7..4a7fb6b15635 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1370,6 +1370,18 @@ int smu_reset(struct smu_context *smu)
 	return ret;
 }
 
+void smu_late_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct smu_context *smu = &adev->smu;
+
+	/*
+	 * Put the mp1 in the right state.
+	 * This gets called on driver unloading.
+	 */
+	smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForShutdown);
+}
+
 static int smu_suspend(void *handle)
 {
 	int ret;
@@ -1931,6 +1943,7 @@ const struct amd_ip_funcs smu_ip_funcs = {
 	.sw_fini = smu_sw_fini,
 	.hw_init = smu_hw_init,
 	.hw_fini = smu_hw_fini,
+	.late_fini = smu_late_fini,
 	.suspend = smu_suspend,
 	.resume = smu_resume,
 	.is_idle = NULL,
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
