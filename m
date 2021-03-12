Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90664C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 08:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9AD64FC3
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 08:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9AD64FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027C26F4DD;
	Fri, 12 Mar 2021 08:56:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B8E6F4DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 08:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISAI9d35FPr+TDCiYBWEl2DyWZtmf/ruHoiQbhW1N81v8Fk7wsziug/zGMxGayz3HUB0RCW6WmpsybW7nerp1B/R4Gd3o2t5X1QNClxDGzH1WuuLwKcBsxIQkz/jL1ytAEsZwnwjCMjCYMRFIJ+Q/aCocj2Ls2s/LLRic9dUiKRQwILBdUzT3w72LgusKtNzAES8r15Leh6rkrylkAVpJR9JeZLrzKP5Vc9M2xmx3M2JjSgXq/CueuJUA2UHaiHkuqJPkPCFlog9+vQ/4rusDUxpdYv4KaG7roijhj7LGknm/IZeO/9ajDU7/a9Fz/jRP9uYd5J88HVBDqSP9h3fwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+XPZUVndZi37ID+04GOvC9xhf1c6UBHd7d/iqjNVJg=;
 b=E6PdjyuTFHoWmxXU1XIIkid8nslokAKgmfscUkjqtoHU/lG5fymFJWQATKlSnHmSNlyxzbWzK3Bo/KDYX+rzkId3ooCHKqTODVpwL1NOaTt879SCeweH0jXK7tKc5Tz/zpIhRlGbxh09adKp7CWUjHqrp2Rc0Ppc0EoiQhFTEi1ydwQfeS+hbHdR2mzVmVRyUHNmZPlj/6kX3gJapMbhbTrCEhPXCKMEsibttzX/tudymHg0tvL9gsPsXg6ebQM8mszpPt2zi7XyjCdMAvCWLXitkmx8HIXBgmLAyZhSDYWi9KlGzyUNpCfihQUtg3psfEZeJxiwxxSAp1J3jckGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+XPZUVndZi37ID+04GOvC9xhf1c6UBHd7d/iqjNVJg=;
 b=YfyNXGH7wcPj9aZK2G9heaKtz4+a52FMoQ5iDGffkPbOYvp3WqH3LhHYr00TEfjfusBP04SYxQm3W2//4fJRlSYhBKlvz4ZkGkXhv5T1Y++0Bnz0FtsKuBFWtV5gvELzGs65gIFKlRdWloT5q/yHZEEts3u6Q2E8NG4FvLhGW/g=
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by BYAPR12MB2696.namprd12.prod.outlook.com (2603:10b6:a03:68::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Fri, 12 Mar
 2021 08:56:15 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::e6) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 08:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Fri, 12 Mar 2021 08:56:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Mar
 2021 02:56:14 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Mar
 2021 02:56:14 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 12 Mar 2021 02:56:13 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: fix send ras disable cmd when asic not
 support ras
Date: Fri, 12 Mar 2021 16:56:11 +0800
Message-ID: <20210312085611.7743-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75362430-414a-4460-a6b3-08d8e534b1a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2696:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26967C9385E6EFA0D2C2326B9A6F9@BYAPR12MB2696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zymEFkfdWyDryd0GsvLG1BQ+aZY4AEMCBlfBRDHixsa22KpEcqFPNZU/30SnYwNrUi73/aLXZQTCJ0lSkZhwpGVabmO5gDHsWquG53D0mtmownLjrmoIrxmWmea2wbaJ2Q+sKF1PG71bmoZlSXJIbxuCvKopZ/SUMMDu6kkurOCN4nPqBsp9JaR7r/tmDrV40aJDqRg06J7e31imB8KHdPuE42DbqzNcZKS8iC/8Ymz9+IR+nltwi8W6va65E96gB2ovPp4kRPvRwaHejrIYufaCvDW2JO588dKskZeoiNAMa2JPbQO6ptKZbzotOkb692EOfZn+1DJO5pc1EsRUiblzeMesnPrvZQQLdUTmNNPqp3PjD7vHlX9ulz6BsfkqWACSzrq80MP6BW6ViGFQjj3wTuy7y10l72OC4FGnSQrmVWPPcOVJWRIr3fwusLm+83F7AuMF3qdSq6LSaRKrbmaaC7BfOCaREppH/55E59oRXfoJ7NYUcmINgobZwUSl4QH3zVIfMfqk2blWIevE3xOPT5ur4Wahd2nWmsALQuu6KmEd22CNQQi6APOBpw2dZ5zpOg9VuDk1cDzU/gdm1Y4BuX5ApEYOrki5NxN1Iq8IeRxr8RrSMycbBhlUhIPHoQVx0Hj0x7jPB/L6jr7oc21IcSmFLTYekQ3CVnZBFyaF99jGb6F45QPzet2O40fz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(36840700001)(2616005)(426003)(4326008)(5660300002)(36860700001)(8676002)(336012)(47076005)(1076003)(86362001)(70206006)(36756003)(70586007)(81166007)(478600001)(356005)(82310400003)(6916009)(26005)(316002)(7696005)(186003)(54906003)(8936002)(82740400003)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:56:15.3651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75362430-414a-4460-a6b3-08d8e534b1a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2696
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
	It is necessary to send ras disable command to ras-ta to program
	GB_EDC_MODE to "BYPASS" mode during gfx block ras later init,
	because the ras capability is disable read from vbios for vega20
	gaming, but the ras context is released during ras init process,
	this will cause	send ras disable command to ras-to failed.
    how:
	Delay releasing ras context, the ras context
	will be released after gfx block later init done.

Changed from V1:
    move release_ras_context into ras_resume

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 57 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  4 ++
 4 files changed, 58 insertions(+), 14 deletions(-)

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
index d9d46ee75a2a..169725c9831d 100644
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
index 7f527f8bbdb1..6008152f1363 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -441,6 +441,10 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 	if (!__is_ras_eeprom_supported(adev))
 		return false;
 
+	/* skip check VEGA20 Gaming */
+	if (!adev->ras_features)
+		return false;
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
