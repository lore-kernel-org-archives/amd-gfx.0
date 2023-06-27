Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EC2EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 21:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174C510E33A;
	Tue, 27 Jun 2023 21:22:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0156910E334
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 21:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeN/3n98NSxSFekfRH1/8afF8MgJQNWbF5XvRUt3C7aTfsQLK37cCOIoeDbhrRt/S9ywY+5BdgmaVHDxss6okASV5GXEknn9GhhdoZ71zbl/XpDzVYKDLepJ20CNSDcbehrsQAnKcdNHKXRDhxQGkSSnuMrI2XdaQVJioyO0Bk7Dn8u6k6+AfJVdt1HssqaxZoh+KTGPmFYZr32nqn5XJ6zQ2Nacu4wcKvdUxt0EtP4DpCJXlNZogrExU2zqJ+sp7am0y70INp/pVZESGt6v8F77BArI8TSfTlRvvvFyh1K0/Xz7MEpwCk6s/XFLNx4XFaE0me9OS8AKLcceeYgnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFw9Vjnt/hpLaA2ACN4ZNo3kbpGQjSx+DbONCbJUo+8=;
 b=RPr8hfLk81HGcuy3IT4Jkl5fNm4nLxPjpmbkfLoGFQlhS4rcd9qhkkMjv+L1W53JsE5dL4cKnA1rSxJ8/GZVJw3QqsMaG3EpslW3QbD+JSt3kBMqbUiPgBGwcFxCyq9MbkZTyEvDx4BtzVHKdNFhfpFvBC79G9j3q5yP+cwUCmRefoTUBoLIEo2XLc8kh4wvHuUDv/YAI/ODYCMLcbTIlLArwenGxKIoH2f6ljXAVgn+f/PmWrrPf7E5otiv2CXvDQTCkjx8/ceFmJ/kjkdUT1Y4HgQq04Xjr/dbnmjzVzd7PUFQBus68d7fhya/gy/9J3iE75ZyuIrISe5Jip5JrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFw9Vjnt/hpLaA2ACN4ZNo3kbpGQjSx+DbONCbJUo+8=;
 b=D9hqDErYboqSGgYwDH+v6jgHAdvwYiBuRpacduvcJvnZj0ZRdIebS0D2uPqzMpgpUGzvONTleHzx/Tk79WvzFZ20XYdlwTEKs46bDuL0QUcm0uaBupu5DdCKl8BzDHBdcnQlRYRLBnpzh5n2c/eg9+hlRhIwpz6liZ3CylOKIXc=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 21:22:40 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::66) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 21:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 21:22:39 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 27 Jun
 2023 16:22:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Detect IFWI or PD upgrade support in psp_early_init()
Date: Tue, 27 Jun 2023 16:22:26 -0500
Message-ID: <20230627212226.27638-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7f1c41-febe-4ed0-7900-08db7754a30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtmUsJOPAkIkTsfxcQXcIg2eLrjDl4NL1+iFhFZVRQcZx4UTVzBVRsTrggcZz9tF9gsnoPMuIHiLi7zinv0c7guQpBOJB0FiwePLjEL0Fhxayt1TYszU7YS4Maw5YL8G+t8muIto/p13c6qhz2VtTEtKCbzqAoGesN7tb1+p/1flUqWIUyxm7lBCi7ZbWPGZ3B0uXKsTlrfbdvRhf+Thm7J3qDWw/7Mq54wFyeBS3ZEeqXXtd5+UOfSm+6x9gEwO9XtuuD/WLXY4pFUcVvr0K7povWErIswyx5ewsXUCNJRzQnttZes6+aj0CQTEvnnBH7iAxQhlNCtIzlZGURJFW0MNlKQYZgG449e3Yw8HCZ38Y2uKhHMgfY8dru3bdbHa2AK4xjXcBRnLxgVlT+rX6YTbeQNypuxDEIsFdwWcduHGQDt+cO+pg3ICEYAeCAdRT3uXFuy5CQKUQW20tBxYftFqM3+kOYTPjfzw9PQ1CdCi5MOs0iXB/0BjFOQ4GtnUgkTUOiDo/Nv5KHyPDT/MhT1nJKIvZyxYuVxjeaO3cx/BQTJF3C++QRB6tlRSwU7Fhzv+/J9M/h3XnuviuL4RHivl00FTAq7THsrxG1I/O+tKK47O2VPQzYTtwRsyUsDfU0PSpFlcnFa2le39ulgQSJzkdowgRi8faGAlLnCemtRacClocRDCL4ssSC9twcQYApcQQ19gCSibEHonzZGpwT+S/40vdvTTcpNPjbcsP9utiKoy76QVYIaNIyx3Y2nUCW3Mjg4XBIJLsBooN9138g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(7696005)(54906003)(478600001)(6666004)(1076003)(81166007)(2906002)(26005)(186003)(82310400005)(16526019)(356005)(316002)(44832011)(70206006)(41300700001)(70586007)(8676002)(5660300002)(36756003)(4326008)(6916009)(8936002)(86362001)(82740400003)(36860700001)(47076005)(2616005)(336012)(426003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:22:39.9206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7f1c41-febe-4ed0-7900-08db7754a30c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 45 ++++++++++++++-----------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 630e4f73de30..0d7b4035bdf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1099,6 +1099,10 @@ struct amdgpu_device {
 	bool                            dc_enabled;
 	/* Mask of active clusters */
 	uint32_t			aid_mask;
+
+	/* firmware upgrades supported */
+	bool				sup_pd_fw_up;
+	bool				sup_ifwi_up;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6929fefb26cf..9904c9c18b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -177,9 +177,11 @@ static int psp_early_init(void *handle)
 		psp->autoload_supported = false;
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 7):
+		adev->sup_pd_fw_up = !amdgpu_sriov_vf(adev);
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
+		adev->sup_ifwi_up = !amdgpu_sriov_vf(adev);
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
+		return adev->sup_pd_fw_up ? 0660 : 0;
 
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
+	return adev->sup_ifwi_up ? 0440 : 0;
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
+	return adev->sup_ifwi_up ? 0660 : 0;
 }
 
 const struct attribute_group amdgpu_flash_attr_group = {
 	.attrs = flash_attrs,
+	.bin_attrs = bin_flash_attrs,
+	.is_bin_visible = amdgpu_bin_flash_attr_is_visible,
 	.is_visible = amdgpu_flash_attr_is_visible,
 };
 
-- 
2.34.1

