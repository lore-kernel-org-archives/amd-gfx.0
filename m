Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31390E7C4E2
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 17:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D7410E3AB;
	Wed,  4 Oct 2023 17:19:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE9410E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 17:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8ASVwB9vjJj1avzwmui3Mh/cAoPirmcRwklemOp3SUjWD5qTtgFk8eOwhzw4cUSuuevjgnbrQlBlzGCGoub3NvKSXIVHyeNt8noeSTV1m+M1QPpAB2gxysoVaxWBT+AhnMP/gWJurnhFdNcQMtOBQpA6hc6X56BjtoTGkkghgu4PLOTjdXvCYJVViFdDJlsDKN5LY3iGj5L694dlu1o3V9YPe7BcyBWOctW6s+rhIKyY8euJjyCN9/Pg7UQdJpgHlEP6SDpcFOLPH1l9IM7NLmto4xI3EKvwPtWSCBOR73l460XQlwDcKQi0zHArUHaHryiLBbp7epEcABioTSTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nAFhk72oEtTy4bKJteMJdKUQYJx7CtUHxGArpB3xEY=;
 b=SsG7UrAr91dL4A7UQbwn2z3vYku1ee4VMtILe5b1u53FLmc5h/N5pO1b/t/1Rt5WWxSknWHQm/kPncWnlDU8TYMURH0jKm6X3WTFBT05dAVkAev5/vA1wePrgvPEb520UFDtAeVAGtH5jupV+mpty6AGycS36shJGgetDc/quLMklC+feDLzpXok5SFPozIBNbmRsElHgmch03Aa4Y8TbOfItDjsGTegmR5U4Lbbu+UYveTFvs+YZ8f20P5ylExy5DsPIkBxS51Bq3OO5CDbzlUVaSweovIywUHUNKLtdM+mgYKsN6jgtPG62tZjfoY8B3PRrOfkoU4wMEllS31i8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nAFhk72oEtTy4bKJteMJdKUQYJx7CtUHxGArpB3xEY=;
 b=I08tMesQcuWEe7GBr+Fzjp2akn3w4yFH+EMZS4liCWVqXdGLeAUX+ltuX7B7HAOLkollqKwpQHZ3UEeTYR6dLSHdPaqKsu2Wk0hEQl7kHqQCbLK//6NiY72mFOXHlYcRJ80TsnKJG/q00y2T/jeFvgaaQezqGaKDM+JORoi8xeE=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 4 Oct
 2023 17:19:00 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::5c) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Wed, 4 Oct 2023 17:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 17:18:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 12:18:58 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/3] drm/amd: Evict resources during PM ops prepare()
 callback
Date: Wed, 4 Oct 2023 12:18:36 -0500
Message-ID: <20231004171838.168215-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004171838.168215-1-mario.limonciello@amd.com>
References: <20231004171838.168215-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: b41b1014-4556-4dff-b1fd-08dbc4fdffd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zM2K8kK8UJlfFS5ogTJ0+Iss5RcipLec/U1LJVpzlueacvIjCT/dBKM4IzYp6iDRr07t8y/D57QY706bRqdsYlosunJhzur4zZtaxbBPWA/UK1+8i+mDxe1Df+/hwOZrPflJy5fSp/7MxkZehS4cP0E6rYqiQoaoO4vxcADEHBW49346/Fckitn2ZplnNzY+TdKmZdDOPyuMOvYexfONUnZ2rB8+3GV5q57YQMkv7CXt4QrEOEJas6x68R0DtBcvCD3m0nF73tN/Ps0ty71dJtzsHzNfo4dr0Ryw8ha9KDsA8zK4ktZ+6/R8i2uW5CU0+2Ho8FoPZKFVH33LCKzhEL9UYUe/GjHuXVMOXMjaFJhwGQg+ieXnF8oAfd+iLBB3KN0koCEj/WuJhVV2/v7z+t7PgdUaLZMgJFCDA13yOXEByIOlla0TyDBHNe3brmaqVmy/gjrisyuW5YaGW/np3uCtaySZj+1BT2WEkUbkexAiiFcYPtoLriKiMsMb+WEqwjz0Kk+3QOWSoK3q49/V4SyDQnUtMsWxXPf8m+astZsL7KQooQ3VheXnkRtiZfKEMVTAtydUHkqd7D4heYJtLmIurHPmVw5lvZ7SiXZ+nAsCT4cUCFpVc7xJ4W5qAgNS1L0E8O2LScVc8x4S8/tr8+XSY9cWoQzGVPdflIlr/ag0WyqX+V+uEPqY8JA5d/pUb9I37V2Agafb9fxXwt6/DOPgEbu5jWrLbYXCA3w3ek4mQyWNnIznO443xpdrvra
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(7696005)(966005)(6666004)(478600001)(336012)(426003)(83380400001)(16526019)(2616005)(26005)(1076003)(2906002)(316002)(44832011)(70586007)(6916009)(41300700001)(70206006)(4326008)(8936002)(8676002)(36756003)(5660300002)(54906003)(36860700001)(47076005)(86362001)(356005)(82740400003)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:18:59.9565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b41b1014-4556-4dff-b1fd-08dbc4fdffd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Linux PM core has a prepare() callback run before suspend.

If the system is under high memory pressure, the resources may need
to be evicted into swap instead.  If the storage backing for swap
is offlined during the suspend() step then such a call may fail.

So duplicate this step into prepare() to move evict majority of
resources while leaving all existing steps that put the GPU into a
low power state in suspend().

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 +++---
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d23fb4b5ad95..6643d0ed6b1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1413,6 +1413,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 void amdgpu_driver_release_kms(struct drm_device *dev);
 
 int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
+int amdgpu_device_prepare(struct drm_device *dev);
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bad2b5577e96..67acee569c08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4259,6 +4259,31 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 /*
  * Suspend & resume.
  */
+/**
+ * amdgpu_device_prepare - prepare for device suspend
+ *
+ * @dev: drm dev pointer
+ *
+ * Prepare to put the hw in the suspend state (all asics).
+ * Returns 0 for success or an error on failure.
+ * Called at driver suspend.
+ */
+int amdgpu_device_prepare(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+
+	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
+		return 0;
+
+	/* Evict the majority of BOs before starting suspend sequence */
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 /**
  * amdgpu_device_suspend - initiate device suspend
  *
@@ -4279,7 +4304,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	adev->in_suspend = true;
 
-	/* Evict the majority of BOs before grabbing the full access */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e3471293846f..175167582db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(drm_dev))
-		return pm_runtime_suspended(dev);
+	if (amdgpu_device_supports_boco(drm_dev) &&
+	    pm_runtime_suspended(dev))
+		return 1;
 
 	/* if we will not support s3 or s2i for the device
 	 *  then skip suspend
@@ -2435,7 +2436,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    !amdgpu_acpi_is_s3_active(adev))
 		return 1;
 
-	return 0;
+	return amdgpu_device_prepare(drm_dev);
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
-- 
2.34.1

