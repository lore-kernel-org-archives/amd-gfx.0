Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FACCE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 14:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED2C10E25E;
	Mon, 25 Sep 2023 14:22:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B55E210E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 14:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5XnmH220zDgXnbuZQy/hXNUZvZGCQNgbuP7GXRRdOO00qU3lukK1yEan3/BoDnvw4TpyAX9kYPBetgXJo+a2kWDgz80cxRR+QIb36ENoDQMgAk5a/YA/l7H4RhEPwbgFn6ilKUMnu9YtESPlSEKSFijygMi3ajXo0TDs3vBmcrS8y8gg6jIDWLhmVs2PCRnyHgFRSQ0Lk2fkUtNNhAVM4hCwEoSmfzy4QAx8s3eFrMjbLcOGWEMsMhbwrWugP2hFesaVkmh6MOczDLBYcKiz4GSUuz57yx8P4VrQ99Uw/kzOkAqqHRoPV/64yLNVDRQJElnDABIa+BgGquixggYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFcR22LHmsLco63IxeZSzMH4I4ugJVYTBR0qCdPapFw=;
 b=aN1Ma/dEK8Hmoo/bTbTUSd72hewIsnQXMjbU5iAtRmctdaaT8qlVALzYgI5tpmjq10RoXcYuCnT03GkJXxYriSgfUAACCIiGAmlhqh3SPb1Q5/mlG10npatj/sUTXDSFKpQjZEcqHb6bkqeEHaIDIfTHSF8kQB2g4ErWSElCuxON558B25olG6yE2kyMLQhUTFzU9CZemBuNc3s0gkOjDUfJQg3v0rIbYWMvGj/rkIilnO2afVe9VSafYpCE9f36clz4LcwMnjrRdVbKrm2GcIKn6rma6OmVDE8vWz9d+7T5UcW9t1jnUfwNeV/h6M2F0JrK+wA+jjLNit4pdaQ5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFcR22LHmsLco63IxeZSzMH4I4ugJVYTBR0qCdPapFw=;
 b=4mws5WaSeELJlZNy6dHf+2OikDb3WEci0rN0X9dpgDUfYKOZeIWHlSREhaHS2IXS48mCe9xI0xNUZgQZlpBZ5ahYziqbZ919zuS4BxSaoZR+dwIbEyu61+UTT2Bk78woaVqMzHINtL8Za9LHUz6RFMH3y6zLrjulVcZwZ+bCdNU=
Received: from CH2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:4e::29)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31; Mon, 25 Sep
 2023 14:22:45 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::5e) by CH2PR02CA0019.outlook.office365.com
 (2603:10b6:610:4e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 14:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 14:22:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 09:22:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Move evict resources suspend step to prepare()
Date: Mon, 25 Sep 2023 09:33:59 -0500
Message-ID: <20230925143359.14932-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca9dcae-0774-45a2-7b2d-08dbbdd2e308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adv4I+5C05SXZrr8Iu1YcIeUc/0oG/2/0OMfIvWK4G6O4BBxQ7FvG5aI1qfx28SpqH/DmgNNJdsxTZr+Zed7Gs7xHsuJLatKZljxKCSqhxGyYFBju33j2+Ymq7yhMJRo6GlOwFfeVSD5wLjthPDxxj9iIQACQnQgI/xg6yLNUvO5aD3NHHr8wYCtkKfeTA0ymZWbvOkiHOcfLCuDSOyy6BMOHhDJgE2fka3T8HIeYgCISo8Kd4+cyFHnyB5LrNGVUGzKQl5LcncgTq8S+RUZw7TiZe0CCOuNeb+6XGqHgy6H9HOKtm6r4fzpQmW8ecg7qxTy1+PxsDn2WqZAAZeS7fWTCWaXIWYOZlHucIorS8HrCRJhaTnle0/fn5EDfjrI+oL93+iX5VmNX0L2Oqb/Vh2R/C3VP5XB8hDa2BxuCe0wh90FbMMJlRnKVf963vpo3eM47eYxFXGeyLZoIMpofkFss1i7df/OBjEGfpQENxZ/CAq5moTMBheQgLUmXYpSS09MDF/YjeDKAMj/CEgsa6bfCQNlH5BbS2+Z1Ve/9OyGwAJr3wltbHV0PKBnfwA6zisiv00RETt7oOw+XdBwgJrPd+zRZK9IOiwpGS0cHYU2Ho2ohRUj4fy4U8kDA4PFnM8XrvVic7kAUtRb71beuXCuGnz2qknVJaVqsGhAtDLVJmznqphatiECzh+fgThMy/3l387NFpuiJ3KHZEcZNwdZxNYWkPY3QOJWbzPyAlArZBFlK43M8ho3bFyd5ld0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(15650500001)(41300700001)(8676002)(8936002)(4326008)(5660300002)(44832011)(36860700001)(316002)(36756003)(70586007)(356005)(478600001)(83380400001)(81166007)(26005)(70206006)(336012)(966005)(47076005)(426003)(16526019)(82740400003)(1076003)(6916009)(2906002)(6666004)(2616005)(86362001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:22:45.2041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca9dcae-0774-45a2-7b2d-08dbbdd2e308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the system is under high memory pressure, the resources may need
to be evicted into swap instead.  If the storage backing for swap
is offlined during the suspend() step then such a call may fail.

So instead move this step into prepare(), while leaving all other
steps that put the GPU into a low power state in suspend().

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++++++++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a79d53bdbe13..54859e810844 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1285,6 +1285,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 
 /* Common functions */
+int amdgpu_device_evict_resources(struct amdgpu_device *adev);
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
 bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 30c4f5cca02c..4df27d200848 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4085,7 +4085,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
  * at suspend time.
  *
  */
-static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
+int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 {
 	int ret;
 
@@ -4122,11 +4122,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	adev->in_suspend = true;
 
-	/* Evict the majority of BOs before grabbing the full access */
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		return r;
-
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81edf66dbea8..8ec1c1c79bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2380,12 +2380,14 @@ static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
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
@@ -2394,6 +2396,11 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    !amdgpu_acpi_is_s3_active(adev))
 		return 1;
 
+	/* Evict the majority of BOs before grabbing the full access */
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
-- 
2.34.1

