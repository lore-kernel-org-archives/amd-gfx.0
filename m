Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C08C001DE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jul 2023 12:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D471510E151;
	Sun, 23 Jul 2023 12:53:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E63210E151
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jul 2023 12:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjNbrrPDukkiVkNtuIyfxqtmENrii/cJSvYTNbbhpoBU3zVrNIYvE3AfvkVKGZ6J/0uSEuFJJJFESWjcGUmwhTvrDCEH7EIR5ffLk0zzaOcu0WLAmGZgmmuWo4OLBBFwd/l06L5+s0VAHhpCNdxN1ZAN8ZZ4ZG4YWok4iZMm6qRCJoG0C2qFTob15ZYEWMnKd4v+mpR4WeAKQv3OY5bUEyBVI+9+8b8kY4vYFxHD2E8+xfAM355jXSpGhOZtmw9nQoSqY2iRHsVOjRXpuH4jXIBCQxOGdjikXGGN+38woVc0MlBVmvLw2X6Kj3Dw8hQkdxIyxffD8Ub+Xxfyoi1SYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xloXYAJ5ghABDcIxO4YFFZZYzZRVzrwuHOko0qQyVGA=;
 b=bVxnLv8uNzDKKbzMCIzBmtf7PzPXWSYPNWeUxfgGbW9je5CS9TYoQI3+IDqUmrcipaaCGV4MckAdoUpGRBXcjJ7RmWEUDtABwn8fx2z9Cueiny9ANsxCoTaCUTbrsDOUGvpvqsgkmb2RD5mGvaglhsA0SGWozzTqEHjo3eg+8tQ3mp0SxUBmGyyYL+20oYBgjVHGGW4rZ7OJnXDGfs16Vg2+RWkiec6BrQh9G75RPmvG3TFimTEqImk+fx4nYNcuFlB4DXaAFZb0Bb4NNwcNRcf9ifOWkhYzYsM/Fn7zwyMAQNC3Iu5HGAKEA6SzV6qbO6Bj4JcDt0sv7bi+wNZVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xloXYAJ5ghABDcIxO4YFFZZYzZRVzrwuHOko0qQyVGA=;
 b=rH2qEut3BrANRf1B1KBGvsJUsjwvJACzGjPkpRFwSZz0ofgiOViuHL7QptSgw5G71EyO0gSihOzEnnay0LunD7WoInuARZfmvVYp9ejreQZNyMMLwtUud/dQB7RVNCxxgJUlW9CSzqRjryDEKNNYxLMFa4S4NbNm87eJEsFqddo=
Received: from BN0PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:143::34)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sun, 23 Jul
 2023 12:53:39 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::64) by BN0PR10CA0028.outlook.office365.com
 (2603:10b6:408:143::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Sun, 23 Jul 2023 12:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.24 via Frontend Transport; Sun, 23 Jul 2023 12:53:38 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 07:53:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add -ENOMEM error handling when there is no
 memory
Date: Sun, 23 Jul 2023 18:23:20 +0530
Message-ID: <20230723125320.2059977-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723094921.2054552-1-srinivasan.shanmugam@amd.com>
References: <20230723094921.2054552-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: f665bcc9-8c7d-40a3-3ce0-08db8b7bd5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZja1DCpC2R+XUH+8gpl8H3SkhJCZLC21rjE1vEaNuYFhPAhD0st585s4md5zBSquZbzQ7PcDfdWjChBz3fInXJk9/UjuzK+IPc9esCxnshOQiI6bSJIhB30k6iiChG4vSqrS6+v/SgyzHA+at4RKCSyNnnCP/9qgu698PrDEDHQgsJlmGjNxIsLtsWxof4t/l0YzZWyWZNWg6/6WMsnI5I3TvU8odb+NVNSPj+NfXFioAdRxZmoC5EakqfgL0olL32HtVRXvxqnqAuMqiuhRJRF/PYeyHrpcA48ccgdonxx3d2xUVsynJyP7ewVlJGiwI4cWs/DXgB0fwbbHJ3OamPv+iQIUFtomI9i56ODS/okz5p/gbvDBcpc/aKTP92E2bHNRvGT8O8icBlxqfI5I46oPZgvZ75bvd81UviuTswXhBuzpLCMROBCUFcxqbCiPG6KufvrwbmfxqT7zgmU4HNjYSFd0XuWGylLMOpJYiMNtm0AMEp5XsTgN1HdejrkXuLIxkBlTjbNKeGMfEUI2h7guuMls5jtN09jD/cRQCMy4Om95VIBPMsvzVZ4BulBHS5aQqdZ1pzva3UpwqVr9B6DvMrKpy4TaiL8osZOTWyXcpsNVWA3KJQWCehrNvjHEg8lpCGMh8Dm8N9M4eoQiGsg/MlHBfkoH0Gh/aIDKJ2kjuQiJu4A7rtvQwCHeuBhSw5egVMCvMPVD/KBpb12WBQgrh1DwlZThDRj4tMWm+8ImIEmZNT/exDJQCzFsgsjKO+Ml5WLlfV6wlpY/05//A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40480700001)(2906002)(6666004)(7696005)(36756003)(44832011)(8676002)(316002)(4326008)(6636002)(41300700001)(70206006)(70586007)(110136005)(54906003)(478600001)(83380400001)(66574015)(81166007)(356005)(82740400003)(47076005)(16526019)(426003)(40460700003)(5660300002)(8936002)(86362001)(2616005)(186003)(26005)(336012)(36860700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 12:53:38.9249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f665bcc9-8c7d-40a3-3ce0-08db8b7bd5f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return -ENOMEM, when there is no sufficient dynamically allocated memory

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Added -ENOMEM - when it failed to create MQD backup,
   while creating MQD for each KCQ 

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 17 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  4 +++-
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6639fde5dd5c..c76b6bfc4dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -110,9 +110,9 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
  * The bitmask of CUs to be disabled in the shader array determined by se and
  * sh is stored in mask[se * max_sh + sh].
  */
-void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se, unsigned max_sh)
+void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se, unsigned int max_sh)
 {
-	unsigned se, sh, cu;
+	unsigned int se, sh, cu;
 	const char *p;
 
 	memset(mask, 0, sizeof(*mask) * max_se * max_sh);
@@ -124,6 +124,7 @@ void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se, unsigned max_s
 	for (;;) {
 		char *next;
 		int ret = sscanf(p, "%u.%u.%u", &se, &sh, &cu);
+
 		if (ret < 3) {
 			DRM_ERROR("amdgpu: could not parse disable_cu\n");
 			return;
@@ -349,7 +350,7 @@ void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev, int xcc_id)
 }
 
 int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
-			unsigned hpd_size, int xcc_id)
+			unsigned int hpd_size, int xcc_id)
 {
 	int r;
 	u32 *hpd;
@@ -376,7 +377,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 
 /* create MQD for each compute/gfx queue */
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
-			   unsigned mqd_size, int xcc_id)
+			   unsigned int mqd_size, int xcc_id)
 {
 	int r, i, j;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
@@ -454,8 +455,10 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
 			adev->gfx.mec.mqd_backup[j] = kmalloc(mqd_size, GFP_KERNEL);
-			if (!adev->gfx.mec.mqd_backup[j])
+			if (!adev->gfx.mec.mqd_backup[j]) {
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
+				return -ENOMEM;
+			}
 		}
 	}
 
@@ -1286,11 +1289,11 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
 	return sysfs_emit(buf, "%s\n", supported_partition);
 }
 
-static DEVICE_ATTR(current_compute_partition, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(current_compute_partition, 0644,
 		   amdgpu_gfx_get_current_compute_partition,
 		   amdgpu_gfx_set_compute_partition);
 
-static DEVICE_ATTR(available_compute_partition, S_IRUGO,
+static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 03dc59cbe8aa..7e91b24784e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -500,6 +500,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 	hive = kzalloc(sizeof(*hive), GFP_KERNEL);
 	if (!hive) {
 		dev_err(adev->dev, "XGMI: allocation failed\n");
+		ret = -ENOMEM;
 		hive = NULL;
 		goto pro_end;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 36a123e6c8ee..eb06d749876f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -909,10 +909,12 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
-	if (!adev->mes.mqd_backup[pipe])
+	if (!adev->mes.mqd_backup[pipe]) {
 		dev_warn(adev->dev,
 			 "no memory to create MQD backup for ring %s\n",
 			 ring->name);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8e67e965f7ea..c8be534cc60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1021,10 +1021,12 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
-	if (!adev->mes.mqd_backup[pipe])
+	if (!adev->mes.mqd_backup[pipe]) {
 		dev_warn(adev->dev,
 			 "no memory to create MQD backup for ring %s\n",
 			 ring->name);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.25.1

