Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B026C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 03:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472D764E45
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 03:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472D764E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09ECF89CDB;
	Mon, 15 Mar 2021 03:49:33 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700043.outbound.protection.outlook.com [40.107.70.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C9FC89CE1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 03:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCC2vJVdYxZiX68UHQFdHfJMDNKEsio90dQCks1hc4aWY6S51wfVFs5hTDrsjPrEIXCYJ1tEjnxVJa3fGrXhS0B4/uDoUPxClsBXA8LWT1BLWf6XQkcNn996yySaxWanVtSDeuF0H0hJ+RH13p6N62B9jCw+BxWckp8370I+Rx0ka0kp3vPqWEctQj3Ea9xpAGjc5yhjtu4LaqlzpQQgsV3dtVJLDpnRdCqHBAyz0RgSfDFwnum7Yp0KlYOLCEhhBplW/fVSNzhUyVsb/RBUupL28brIACNXbfuTO9hAY+8BjVBdhJ4lj33xaGXk2igxhnCuy5xAhiaS04UkF4oaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh7lxcEN8LJTK9dPfI7Y2PQGskoFYTde9RWoVOjeaa8=;
 b=hNTpVU6pzm0JOi0ANuSKAMhOkYynI/ju1KEnvLJW7kbL1+agAeIuSn2kLcK0WBIctlY9PRq6fMvuoRzME7nJ0JNX3AXApFX0pGVCRZ7n4qBB08F2noIK6m6TaAz4zAaMYS5ZFI3U8ReDPUWVrb4sezQ1MtlEBbog9FRWYwJKSAl74wb9VM9syeD4wc+IjPUBb193n3p7T33YNbUzbSjp6BhpysXbjpSi0Rue8fIlunNgq37gq1vdAnEZjKXO6lW6FPA1xhd/hkh+0/3hkdpff/qqndcpEvVRvayDyZjZtjaRm6TP97fQbSuTJQRLJOGa8sqXshUSV4fSmF7Bb7Z90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh7lxcEN8LJTK9dPfI7Y2PQGskoFYTde9RWoVOjeaa8=;
 b=nQkUzyhzytAoBFlQewz1pvdnto5OCTPKHyCN9pPX5b8507S/zMZcbCTtkEXYclA93ugjYIdtAAucWoesuRzF4wCLax5mr3J/C+sg9fY4z4y31t2+9XKaKzRmWMbXlkMDbrZqD2yRunT6KjQ4tEEyW/pYZGdL4bxjqUA5J4ELENs=
Received: from DM5PR2001CA0005.namprd20.prod.outlook.com (2603:10b6:4:16::15)
 by CY4PR12MB1813.namprd12.prod.outlook.com (2603:10b6:903:124::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 03:49:29 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::cb) by DM5PR2001CA0005.outlook.office365.com
 (2603:10b6:4:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Mon, 15 Mar 2021 03:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 03:49:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 14 Mar
 2021 22:49:27 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 14 Mar
 2021 22:49:27 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 14 Mar 2021 22:49:26 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review v3 1/1] drm/amdgpu: fix send ras disable cmd when asic
 not support ras
Date: Mon, 15 Mar 2021 11:49:24 +0800
Message-ID: <20210315034924.25083-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90ef933b-1aea-4966-f9b8-08d8e76555ca
X-MS-TrafficTypeDiagnostic: CY4PR12MB1813:
X-Microsoft-Antispam-PRVS: <CY4PR12MB181370B0E21FD5B0C3E6B89E9A6C9@CY4PR12MB1813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dr01IUqA0n3iWGhHK6/v0/6vmzhL5aS11q9RgVbOgc16QltdDOayC/awzebu9/jcU9E2T4nLSVzoB+zD85AR+w2mC3PVWmeF0dwTpESNyRQzEOzvmQuhzapRx2eM+kE3BIYNUSzY3FPzIso1Dw4b67XgWEawqHM2gYtDj5Z72trDS1DOKDIigCtx5+JU6N7+zy0Zhwqfe/NOUsFG/Qxx7E2SSE1uWbBELVaOk24hxTrlt2t2eSaYeB235hOzGUksKpa3V2dTbisg1e1mh59CEXZj0t6P0WEQTeTL4o9cHN0VBT0r7BgLt8jBYgdxAuvV2KJPXd4hcdi66w/tGlUuMQPTeC96Y0w5c5bdmLTFuUBh8MS4P6Pht2QKC+UmA2fcpR1KUw2or7y7R9B0ODnHvT9X+/OZoyV/WCu53rU0QUIQ3Fy3onSpqdCJ9OKnF2bLfaOkfsiMYu9IzISeBDBPmtIJdrxq3Sw+ofPI/UZGVfWOH6MhD96moTw2o/aG+oMsNXH73HTNnE7HpJ3/YgypfW30VN0r2GfCA2Y5xUzj5n8yg7QMkxAE22RKuvOuZOP02mif/15J+V2sJola3k/oRiLZ04FlJSgFMBfoly1u8RXH78toighRMWn5vrXXNtllQWz7ubcpf41rf1ZN/5U1pqJi9GB6IplHgWMD9Kmluq/Fpaj49BkzewmRz0V/z2qO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(5660300002)(6916009)(8936002)(36860700001)(2616005)(336012)(26005)(7696005)(86362001)(70206006)(2906002)(83380400001)(356005)(36756003)(316002)(54906003)(478600001)(81166007)(1076003)(47076005)(4326008)(186003)(82740400003)(426003)(70586007)(82310400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 03:49:28.8944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ef933b-1aea-4966-f9b8-08d8e76555ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1813
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    cause:
	It is necessary to send ras disable command to ras-ta during gfx
	block ras later init, because the ras capability is disable read
	from vbios for vega20 gaming, but the ras context is released
	during ras init process, this will cause send ras disable command
	to ras-to failed.
    how:
	Delay releasing ras context, the ras context
	will be released after gfx block later init done.

Changed from V1:
    move release_ras_context into ras_resume

Changed from V2:
    check BIT(UMC) is more reasonable before access eeprom table

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 57 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  7 +++
 4 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f7238283d26..88e3f8cdd7cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3499,11 +3499,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 			adev->virt.ops = NULL;
 			r = -EAGAIN;
-			goto failed;
+			goto release_ras_con;
 		}
 		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
-		goto failed;
+		goto release_ras_con;
 	}
 
 	dev_info(adev->dev,
@@ -3568,7 +3568,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r) {
 		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
-		goto failed;
+		goto release_ras_con;
 	}
 
 	/* must succeed. */
@@ -3595,6 +3595,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	return 0;
 
+release_ras_con:
+	amdgpu_release_ras_context(adev);
+
 failed:
 	amdgpu_vf_error_trans_all(adev);
 	if (atpx)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ed83a32f6f30..3a416eccf96c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -463,7 +463,7 @@ static struct ras_manager *amdgpu_ras_create_obj(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return NULL;
 
 	if (head->block >= AMDGPU_RAS_BLOCK_COUNT)
@@ -490,7 +490,7 @@ struct ras_manager *amdgpu_ras_find_obj(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	int i;
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return NULL;
 
 	if (head) {
@@ -590,7 +590,11 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 		con->features |= BIT(head->block);
 	} else {
 		if (obj && amdgpu_ras_is_feature_enabled(adev, head)) {
-			con->features &= ~BIT(head->block);
+			/* skip clean gfx ras context feature for VEGA20 Gaming.
+			 * will clean later
+			 */
+			if (!(!adev->ras_features && con->features & BIT(AMDGPU_RAS_BLOCK__GFX)))
+				con->features &= ~BIT(head->block);
 			put_obj(obj);
 		}
 	}
@@ -693,6 +697,10 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 			if (ret)
 				return ret;
 
+			/* gfx block ras dsiable cmd must send to ras-ta */
+			if (head->block == AMDGPU_RAS_BLOCK__GFX)
+				con->features |= BIT(head->block);
+
 			ret = amdgpu_ras_feature_enable(adev, head, 0);
 		}
 	} else
@@ -948,7 +956,7 @@ unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 	struct ras_manager *obj;
 	struct ras_err_data data = {0, 0};
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return 0;
 
 	list_for_each_entry(obj, &con->head, node) {
@@ -1469,7 +1477,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return;
 
 	list_for_each_entry(obj, &con->head, node) {
@@ -1517,7 +1525,7 @@ static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return;
 
 	list_for_each_entry(obj, &con->head, node) {
@@ -1830,7 +1838,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	bool exc_err_limit = false;
 	int ret;
 
-	if (con)
+	if (adev->ras_features && con)
 		data = &con->eh_data;
 	else
 		return 0;
@@ -1999,6 +2007,15 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	amdgpu_ras_check_supported(adev, &con->hw_supported,
 			&con->supported);
 	if (!con->hw_supported || (adev->asic_type == CHIP_VEGA10)) {
+		/* set gfx block ras context feature for VEGA20 Gaming
+		 * send ras disable cmd to ras ta during ras late init.
+		 */
+		if (!adev->ras_features && adev->asic_type == CHIP_VEGA20) {
+			con->features |= BIT(AMDGPU_RAS_BLOCK__GFX);
+
+			return 0;
+		}
+
 		r = 0;
 		goto release_con;
 	}
@@ -2112,8 +2129,12 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj, *tmp;
 
-	if (!con)
+	if (!adev->ras_features || !con) {
+		/* clean ras context for VEGA20 Gaming after send ras disable cmd */
+		amdgpu_release_ras_context(adev);
+
 		return;
+	}
 
 	if (con->flags & AMDGPU_RAS_FLAG_INIT_BY_VBIOS) {
 		/* Set up all other IPs which are not implemented. There is a
@@ -2154,7 +2175,7 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return;
 
 	amdgpu_ras_disable_all_features(adev, 0);
@@ -2168,7 +2189,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return 0;
 
 	/* Need disable ras on all IPs here before ip [hw/sw]fini */
@@ -2181,7 +2202,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
-	if (!con)
+	if (!adev->ras_features || !con)
 		return 0;
 
 	amdgpu_ras_fs_fini(adev);
@@ -2224,3 +2245,17 @@ bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
 
 	return false;
 }
+
+void amdgpu_release_ras_context(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!con)
+		return;
+
+	if (!adev->ras_features && con->features & BIT(AMDGPU_RAS_BLOCK__GFX)) {
+		con->features &= ~BIT(AMDGPU_RAS_BLOCK__GFX);
+		amdgpu_ras_set_context(adev, NULL);
+		kfree(con);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index a64bbb6dcfa4..60df268a0c66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -626,4 +626,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
 bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
+
+void amdgpu_release_ras_context(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 7f527f8bbdb1..a05dbbbd9803 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -441,6 +441,13 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 	if (!__is_ras_eeprom_supported(adev))
 		return false;
 
+	/* skip check eeprom table for VEGA20 Gaming */
+	if (!con)
+		return false;
+	else
+		if (!(con->features & BIT(AMDGPU_RAS_BLOCK__UMC)))
+			return false;
+
 	if (con->eeprom_control.tbl_hdr.header == EEPROM_TABLE_HDR_BAD) {
 		dev_warn(adev->dev, "This GPU is in BAD status.");
 		dev_warn(adev->dev, "Please retire it or setting one bigger "
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
