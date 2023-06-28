Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA31EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 04:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6B310E34C;
	Wed, 28 Jun 2023 04:45:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FF610E34C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 04:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PylNaEM4kYgYEQWlZjjrKkgoCJkm7WA0rP83/xNE8gHtFPQ3CfHi93c6btI3iFkMV0MLgYZQUpX8/YMeoqqig4IR3WL15fw9I5lkeKZV4L1Nq4c9YN6H585VluTblSxeuHO0H0Up7XK5SGGd1SCrl6B7HFra7Q58Ia8x6rdBoHn8BBLpji4t7kuOyTi8RPy8yX7qJWxhXcaZ4tVdu48Bh5n50Q5z//NImU/KfMrQ0lP0m4qs+pNheJORhINFxzwI3YMo597Dc0pNk3wTtXPtJKdO8B98YQ1S7XxfHJUblx7dh7Hvy/7IECX4TmYWUZ3RyDJ5+gT2TqXY9OstB2/sfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU+WwdxuwxZZc1axQ7XHk/IF3KpAhiDVYEqklFmHd1E=;
 b=L/08l7LiIzMnDflewLZ1FZnq+KUrjX1/Vf93h8M3uugysRmDrrQwjAqDWHsUgZ4aj1qmDQw2hERzPNZo3LgXiFeNg9LoUTf2beRLVvUJueWJ1m2Aija+iex1LM85j2pUBe8iYE3PLFEQFI4WLaoxGfsohNL7SaNBL7DU+pHnU7m2dI1jOU0rvTEHN4fKZmtjmsrWzjdj7yvEc13fVKqejLa++AvyEF3v/bjqbAn8jkPw2L0N/HXRTuK1oUkVwWK08mJGf6atea48hkM+37MSbOQpeAZuhZgCSx0R+Joa5ByMGkqVthLgR4rXBC6SWTlB1o4x4G1RDhG98JtXCBErNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU+WwdxuwxZZc1axQ7XHk/IF3KpAhiDVYEqklFmHd1E=;
 b=C5Zt9kGwZnRnuN3verwqJz18C6X+rVl5sx4jWx9j/B8hFoOlsJvvNj5I1NL8qZ2QnQb9f5fKLBeLRF4y7jbkNduaVioC6dNbFpE8yx5O6fv1ejBQ+kS33fm8pE/o6RGUB4qE5vdRLVgDP8o1fb/+UoAABD/5FGfpdDk+wRCtVZE=
Received: from DM6PR13CA0035.namprd13.prod.outlook.com (2603:10b6:5:bc::48) by
 PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 04:45:34 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ba) by DM6PR13CA0035.outlook.office365.com
 (2603:10b6:5:bc::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19 via Frontend
 Transport; Wed, 28 Jun 2023 04:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 04:45:33 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 27 Jun
 2023 23:45:33 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd: Detect IFWI or PD upgrade support in
 psp_early_init()
Date: Tue, 27 Jun 2023 23:45:21 -0500
Message-ID: <20230628044522.600-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|PH7PR12MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: a6cadb83-3307-4b36-00d2-08db77928271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHCFCesaFtrdmNNDmTF8rjHRL1CY1eeJscICdqBbvOpUbgywYnqOOuODoIlYptfCf9n3cPwI1Rt7Y/Tl1GOpsMASYAD/7301OJaV5m65ITKFCJ/8V5ByVTDssc53++CeKBZS5l/lYhsH3iuuroYnl/lG5schHjAfr2EIjp3fF4qGPkEpXjQCksox5+ZyzQv/Qxblo0Wa5G9IqPBj7zGigOhYQvxguwuxU+0YjwTAQ1DH/gUV6QIanWt3AR1au3LY/kvb/zdnsFt/wkqnAgrpM8gkjW/nV5SUZE60tKbcjQArGpHTriMdI8Z6aOlaRrj67Bbmfwpkr0v/rF8Rax1Zdv0PYg4h84IJpDd5L3/rYfiD6ecUIFneRuDLyQ/eoxT5rcoZ9mLwc/DQUSz5821SKVLboo5zsLKUqifzFKRG8qHeqiXxIYBKq3lm2paW6Wtecjy8oYQxbDl3+eca9EOBnKAolQnqGRJShQ58dJ8p7CXSjGcu5QtXX976Y1aZOsPJ81mgQAqWQ/ZORyvPBF/6CNhWjY1d19PKBAnNe6PNAM2BwkX49xs9DL26vXwMAUbRfF1R4hrb7OiF0Zj4MOcyGaWDLmvf8qFq+eaJN078MqcoAzcSOAx+C5wa+Ty16fV05qa313sNShKAG+8Mclwgoypz2AiyxDpmOFCUf31g/t/CDss0DndXAG3WL5McQAnsy9N2eRqWW2gO7KRmaiLn8UBZSj8kD05IBEMoAVy8HcDcCfpfgM5VgNduOCTP/TvJU0W0k+b7kfNQ35BDYBxOgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(316002)(478600001)(6916009)(36756003)(70586007)(4326008)(70206006)(8936002)(8676002)(2906002)(40460700003)(36860700001)(54906003)(86362001)(82310400005)(40480700001)(41300700001)(7696005)(1076003)(26005)(16526019)(186003)(47076005)(426003)(336012)(81166007)(356005)(83380400001)(82740400003)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 04:45:33.9025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cadb83-3307-4b36-00d2-08db77928271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than evaluating the IP version for visibility, evaluate it
at the same time as the IP is initialized.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Move to psp_context
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 45 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 +++
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6929fefb26cfb..270b5b5a3a6d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -177,9 +177,11 @@ static int psp_early_init(void *handle)
 		psp->autoload_supported = false;
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 7):
+		adev->psp.sup_pd_fw_up = !amdgpu_sriov_vf(adev);
+		fallthrough;
 	case IP_VERSION(11, 0, 5):
 	case IP_VERSION(11, 0, 9):
-	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 0, 12):
@@ -214,6 +216,7 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(13, 0, 7):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
+		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
 		break;
 	case IP_VERSION(13, 0, 4):
 		psp_v13_0_4_set_psp_funcs(psp);
@@ -3704,9 +3707,13 @@ static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
 }
 static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
 
+static struct bin_attribute *bin_flash_attrs[] = {
+	&psp_vbflash_bin_attr,
+	NULL
+};
+
 static struct attribute *flash_attrs[] = {
 	&dev_attr_psp_vbflash_status.attr,
-	&psp_vbflash_bin_attr.attr,
 	&dev_attr_usbc_pd_fw.attr,
 	NULL
 };
@@ -3717,29 +3724,27 @@ static umode_t amdgpu_flash_attr_is_visible(struct kobject *kobj, struct attribu
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
+	if (attr == &dev_attr_usbc_pd_fw.attr)
+		return adev->psp.sup_pd_fw_up ? 0660 : 0;
 
-	switch (adev->ip_versions[MP0_HWIP][0]) {
-	case IP_VERSION(11, 0, 0):
-	case IP_VERSION(11, 0, 7):
-		if (attr == &dev_attr_usbc_pd_fw.attr)
-			return 0660;
-		return 0;
-	case IP_VERSION(13, 0, 0):
-	case IP_VERSION(13, 0, 7):
-		if (attr == &dev_attr_usbc_pd_fw.attr)
-			return 0;
-		else if (attr == &psp_vbflash_bin_attr.attr)
-			return 0660;
-		return 0440;
-	default:
-		return 0;
-	}
+	return adev->psp.sup_ifwi_up ? 0440 : 0;
+}
+
+static umode_t amdgpu_bin_flash_attr_is_visible(struct kobject *kobj,
+						struct bin_attribute *attr,
+						int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return adev->psp.sup_ifwi_up ? 0660 : 0;
 }
 
 const struct attribute_group amdgpu_flash_attr_group = {
 	.attrs = flash_attrs,
+	.bin_attrs = bin_flash_attrs,
+	.is_bin_visible = amdgpu_bin_flash_attr_is_visible,
 	.is_visible = amdgpu_flash_attr_is_visible,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 4847aacdf9dca..e176cf204202f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -384,6 +384,10 @@ struct psp_context
 
 	uint32_t			boot_cfg_bitmask;
 
+	/* firmware upgrades supported */
+	bool				sup_pd_fw_up;
+	bool				sup_ifwi_up;
+
 	char *vbflash_tmp_buf;
 	size_t vbflash_image_size;
 	bool vbflash_done;
-- 
2.34.1

