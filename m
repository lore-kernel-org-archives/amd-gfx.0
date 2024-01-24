Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA0BC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 05:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AC110F614;
	Wed, 24 Jan 2024 05:59:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6298910EDE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 05:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngKrpAaaqFTe1ZaCjVuwoq87EkubC8738lO7FZ7vPSfol9TkNPunFVhRFNN2+k/b9b6BAErOxhATYLI94Ua7JJYd4E9wHX7F1aY+F4ubge5eA2f9VGNNzwzC4d//bI2Hj+J6BzAYwhOyN1yH3azbsUml41Ar64TvYedA6W5Vv839+cPBVr9YmEDY0a0W6hkAyeByJiJJQNWq/AGs4uG/jokz2u91wwHMnPxxLqhFDFI9yv8JrDaJy2oBdZrGtGt6eSMr+3jkcDx7SFxmgV1U3/eEta+gF2rkGH8h2yMO8p/04yVUsg+afzg4oaLW0D+wzMRAb5pERf0+zQt2Vr7NXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWlUry+bdf5fjb/Z1A+oY2qwBPMdztovM3JU+ro3HXY=;
 b=GHepvsdLdXBQr96427HUrGo6lqE0CMF9HFWrKl9Y6s4q5jpHKPrLN5p9vYCpzttqwJYSXuv7RXH5AF1poki1vqCv3RMeXhjrLZaOKCihUQpe7Tuf9IygLyC02i78cwrf3YeALfTc39eTIJeumnAeBTVyW9mOueChw4lJsFYynctZJF6ybr4BCWD5PLtAYxzllwcrSWgaeK+2k64xltmLXjwyQ8lEbFyKQ+U/MdMLNTDDlkzeUslWTQMNylvMeNE+oZeVWqHM+HeEhDyJzjaiTSl+8rMjlGarl4N2F0UggSZz195EpVekLfORnJBuq8zL9/UOyZJ4F2GwKiQrxwAZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWlUry+bdf5fjb/Z1A+oY2qwBPMdztovM3JU+ro3HXY=;
 b=EIlr99cJn8zrXQ8r25XWxKvNqTEqjPaRzdQ3qh7qgxcRIJBp8+gfiWFW7cXr2Iu9yX0RPnmKG9aaivTnrDHnZ4nerX7B6P6J71QLSB3fBTxpLSBiZb/Le4YGsaKJ17WEdPHiCVton0jJGZSrJ0bhqxZFRw/vtU+CgkNvtjhcoXU=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 05:59:43 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::e5) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Wed, 24 Jan 2024 05:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 05:59:43 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 23:59:27 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: adjust aca init/fini sequence to match gpu
 reset
Date: Wed, 24 Jan 2024 13:59:15 +0800
Message-ID: <20240124055915.3886458-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124055915.3886458-1-kevinyang.wang@amd.com>
References: <20240124055915.3886458-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: ec479d16-e621-4ece-8244-08dc1ca1a943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Thh7xRtUuv48ELFuFrMIdyX5+dee4lkzuy79dLLwExgyfjJiAWobOPX8HJP5c7bKAvMHBrQzJZ5LlzHyiTDWepONdMgCLxIPAIfznHjrPV8pr09VSyNgRtOeTWHkELZYqSgj2/nzK6reyTDnrlmkAVrkgQtWyyHxgeTtgk/fPFeFdCzUWIGpt4Vz/MvVL6uXb4bfKYlagIH62yvlUW5lsCrxu/iYQlWwo09U6JGL+1SEHuyaEbQy6R+ou0XguXkoI4CgZQjJk4OLVKnSJGDmp31qAfwkBix4wKqcYszW22FukUHiVV/i8ByN4mR5zNemq+CvWer0m/ClRW3BNgS6zE0LiUtoYxfg2XaMrbd9vBMqenrGj1pxOBTc109wv1HPYAMHalKdpa6j0KXkHDTV4EkJSQ2nhOcgGq1Q35ry5scLMPmtUroNl0BHSgMi/56T3QbPguX2FS46OwyxIFb01yMVQHNtvnMG7kuU5box3hGEWFP0hd3mvw9eFhkRN5lEV9PTWbons2DscBAgoGvC5Ztv93ZFfeSB512ho9cQSpMldkdPCfNoAHVfKSNjx4kwRrzmAJcsGoLUkyPFZkqfvNLmeUzEsee1xXXNLhnObOhIKWTGrMyscFJ96IXd13xvcVlhQ3YerK6QGTkmPSMl6RdjrTr3XxYEJiXOIjDz/+611x47Nm0ho0Aqeteo3o642JFFQazo4ZG+Q/X2/GBJ5FdLgRu/o10+03FKBwsY0i4ka1FDR6bEywqOc8PYeMcRuhcTvAhRbyY9MoRVGm/5Eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(316002)(5660300002)(86362001)(478600001)(36756003)(26005)(82740400003)(356005)(6666004)(83380400001)(7696005)(426003)(81166007)(336012)(1076003)(41300700001)(47076005)(16526019)(36860700001)(2616005)(54906003)(6916009)(8936002)(4326008)(70586007)(70206006)(8676002)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 05:59:43.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec479d16-e621-4ece-8244-08dc1ca1a943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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
Cc: tao.zhou1@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- move aca init/fini function into ras init/fini to adapt gpu reset
  sequence.
- add new function amdgpu_aca_reset()

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c    |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 15 +++++++++++++--
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 52a0ea2f0ebf..40c1d5c4a9d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -688,6 +688,13 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
 	aca_manager_fini(&aca->mgr);
 }
 
+int amdgpu_aca_reset(struct amdgpu_device *adev)
+{
+	amdgpu_aca_fini(adev);
+
+	return amdgpu_aca_init(adev);
+}
+
 void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs)
 {
 	struct amdgpu_aca *aca = &adev->aca;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 6e9a35eda683..2da50e095883 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -185,6 +185,7 @@ struct aca_info {
 
 int amdgpu_aca_init(struct amdgpu_device *adev);
 void amdgpu_aca_fini(struct amdgpu_device *adev);
+int amdgpu_aca_reset(struct amdgpu_device *adev);
 void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct aca_smu_funcs *smu_funcs);
 bool amdgpu_aca_is_enabled(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 56d9dfa61290..dac73f8fbda4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4039,10 +4039,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_get_pcie_info(adev);
 
-	r = amdgpu_aca_init(adev);
-	if (r)
-		return r;
-
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
@@ -4437,8 +4433,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	amdgpu_reset_fini(adev);
 
-	amdgpu_aca_fini(adev);
-
 	/* free i2c buses */
 	if (!amdgpu_device_has_dc_support(adev))
 		amdgpu_i2c_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5b519dc4df01..f7c6ea60316d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3348,10 +3348,18 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (amdgpu_aca_is_enabled(adev))
+	if (amdgpu_aca_is_enabled(adev)) {
+		if (amdgpu_in_reset(adev))
+			r = amdgpu_aca_reset(adev);
+		 else
+			r = amdgpu_aca_init(adev);
+		if (r)
+			return r;
+
 		amdgpu_ras_set_aca_debug_mode(adev, false);
-	else
+	} else {
 		amdgpu_ras_set_mca_debug_mode(adev, false);
+	}
 
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		obj = node->ras_obj;
@@ -3420,6 +3428,9 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	amdgpu_ras_fs_fini(adev);
 	amdgpu_ras_interrupt_remove_all(adev);
 
+	if (amdgpu_aca_is_enabled(adev))
+		amdgpu_aca_fini(adev);
+
 	WARN(AMDGPU_RAS_GET_FEATURES(con->features), "Feature mask is not cleared");
 
 	if (AMDGPU_RAS_GET_FEATURES(con->features))
-- 
2.34.1

