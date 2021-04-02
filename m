Return-Path: <SRS0=/zhQ=I7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17873C43460
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5AE610CB
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Apr 2021 06:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5AE610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D9F6EE0C;
	Fri,  2 Apr 2021 06:44:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537496EE0E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Apr 2021 06:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db85Ouh1Xy0nFEUkbqUqoXFOIlZfGgfiI81rhmkW3yehjxcY1mUnANee2aYs3rMobzS3UGYtHtLGSnWgH9NL9HPdRS2l4EoXmx9UOwX7nf22AzBcqlGbG5lBr3Eo/GFUpqbX2qhHYdaKOGzcJO1YqR3S+yaWmrGxwfjT86+839hylpmep3QFrnReQT/Wkphu6VHAM1Y6RCjGYDow37RAaoL+J/dUz0w9bfSaYelUykGDmIpMvo59CHHTNpbf/B4IlUI0mQnxoe5F/8EiwLAGDt7JvW/pJofwx2PUJXzw5MtpvEU/sJz8F1Nbd/aiVZ/WAySR6sjCmGuQvqvLRHjQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1CiV+scP0hCv51hsZaKpi68kEelqZWDIWz6eY75xv0=;
 b=b/MGKaSRo+wApB/Mqt5qtg/f62M2dNdRVJakzjNqZ+KhUnNdsqiEIbteImHX+v+bgpgPuYB2INWXelIGW90HgShlGlpWKaEuk0gBju/7AcuJyoBnFso5psKQRfxv+RYG1hXLSJE87oebg0Neb4f99fjnaSpkCCqLD6L5mXb7VGRzcqfxBNfLO/4hVFUU3YAMwZVi/trIcSZjCIJDGpXGVDV7oOE4TxNQz45APa7wRrSxMG5gwtvPbLrjeyl0FCcPPZSBieGYSe7anFG6ddF3DVDMAmr9+FXbLLfZEuSvUb2pTkeJikSvXAV3eBoRlkOazNFVedWbPwxBLPP8PkvnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1CiV+scP0hCv51hsZaKpi68kEelqZWDIWz6eY75xv0=;
 b=LFnNzHhDNdzW2sW3AJmDs7OleDUrqYwstdpIy/XxyMj7SKNuN8SNRC2ywJPi75DfuqgBzvAcC1bhUWM3pe2Vme60c2f2FWBkTyy2XfOE/10kuiKEqipQST2DEUmY+UM7GP9GnCfZAN8db5KWiuSF8QDeJq/k8AqWfpJVtqdoYUc=
Received: from DM5PR19CA0021.namprd19.prod.outlook.com (2603:10b6:3:151::31)
 by MN2PR12MB3854.namprd12.prod.outlook.com (2603:10b6:208:16a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Fri, 2 Apr
 2021 06:44:08 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::27) by DM5PR19CA0021.outlook.office365.com
 (2603:10b6:3:151::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Fri, 2 Apr 2021 06:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 06:44:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 2 Apr 2021
 01:44:07 -0500
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 01:44:06 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdgpu: move xgmi ras functions to xgmi_ras_funcs
Date: Fri, 2 Apr 2021 14:43:41 +0800
Message-ID: <20210402064345.14093-7-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210402064345.14093-1-Hawking.Zhang@amd.com>
References: <20210402064345.14093-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5a2f7a-632d-4496-7846-08d8f5a2b76c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3854:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3854605EBD4A74D9DFE7E2D5FC7A9@MN2PR12MB3854.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1uiQ9nrSsq5G+PShYaKiAIPB+wMiNjE1s9N93kwxPayXHR5BJhujeXxw5ThKKJn0sAJXo3edKOCPHeswd8JJywHzNK6JQACUaBSaQjbwIV+Lopns6XWFqjY5FxSF+7BckrvxvtkxlBld7zPRP1OleEUQaE4GHhQi5sT1P5tfa4hZkxvFt/RGZKcO1PyOnv6vlRSL/J0OysE18GxpJiZ/UnS7zWOOnwfbc0BbdHI1NaLIltoKyR4yAZo4P9UzNeKha6PBuF1WCydul36G08YOQ7yVMjFTjO6gD9Pq9WusQim4+37iZ5+zhnRvhzd5j38XJ0uYm5YskcpsNxzcFZhzuqLDECeiwq59fmfNxp+4czVedNxvFFNBihlez+P6Yk/vsJPjkTXUOIRiaAt+kSNOa7vbFz+msipknmD9hD0+X24BSsyTd6C0fU3fbYL2lhSkpJmKjuQGk5DMIrx7oEWWwEmv3L7l8i1ADOIW+5yawbgTL1Sw5Y1IjYr6WFK3UAjDrEZt3+KFw0bK0Aaz28JE5cJZMvPd5Mer9TpuUh03f68KxKT4E23pCLMQPj9bXEbJX02LZf0TqxMsgCqV+XBJw5xiO0JXyomPKwDKtE2k4MXwwj6tkOyiJFLJ0bBb2edP+4ItgUev/p0CeM0BTv4pegbgJT/3TlfZSPxr4zQcP1oOq5dr5WzPkHh7OYXzCjh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(81166007)(426003)(86362001)(356005)(8676002)(186003)(1076003)(70586007)(70206006)(8936002)(6666004)(4326008)(336012)(2616005)(82740400003)(5660300002)(36756003)(316002)(83380400001)(82310400003)(7696005)(47076005)(110136005)(26005)(36860700001)(2906002)(6636002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 06:44:08.2762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5a2f7a-632d-4496-7846-08d8f5a2b76c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3854
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

xgmi ras is not managed by gpu driver when gpu is
connected to cpu through xgmi. move all xgmi ras
functions to xgmi_ras_funcs so gpu driver only
initializes xgmi ras functions when it manages
xgmi ras.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reivewed-by: Dennis Li <Dennis.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 21 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  7 +------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  2 +-
 6 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index b9d68fd2610c..082f9d03a94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -403,14 +403,26 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	return amdgpu_xgmi_ras_late_init(adev);
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		adev->gmc.xgmi.ras_funcs = &xgmi_ras_funcs;
+
+	if (adev->gmc.xgmi.ras_funcs &&
+	    adev->gmc.xgmi.ras_funcs->ras_late_init) {
+		r = adev->gmc.xgmi.ras_funcs->ras_late_init(adev);
+		if (r)
+			return r;
+	}
+
+	return 0;
 }
 
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 {
 	amdgpu_umc_ras_fini(adev);
 	amdgpu_mmhub_ras_fini(adev);
-	amdgpu_xgmi_ras_fini(adev);
+	if (adev->gmc.xgmi.ras_funcs &&
+	    adev->gmc.xgmi.ras_funcs->ras_fini)
+		adev->gmc.xgmi.ras_funcs->ras_fini(adev);
 }
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 7e248a4e2fa3..cbb7735c6988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -135,6 +135,14 @@ struct amdgpu_gmc_funcs {
 	unsigned int (*get_vbios_fb_size)(struct amdgpu_device *adev);
 };
 
+struct amdgpu_xgmi_ras_funcs {
+	int (*ras_late_init)(struct amdgpu_device *adev);
+	void (*ras_fini)(struct amdgpu_device *adev);
+	int (*query_ras_error_count)(struct amdgpu_device *adev,
+				     void *ras_error_status);
+	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+};
+
 struct amdgpu_xgmi {
 	/* from psp */
 	u64 node_id;
@@ -151,6 +159,7 @@ struct amdgpu_xgmi {
 	struct ras_common_if *ras_if;
 	bool connected_to_cpu;
 	bool pending_reset;
+	const struct amdgpu_xgmi_ras_funcs *ras_funcs;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac3f4c3266bc..172738cc99db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -809,7 +809,9 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
-		amdgpu_xgmi_query_ras_error_count(adev, &err_data);
+		if (adev->gmc.xgmi.ras_funcs &&
+		    adev->gmc.xgmi.ras_funcs->query_ras_error_count)
+			adev->gmc.xgmi.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 5a1b598f4d30..8567d5d77346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -628,7 +628,7 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	return psp_xgmi_terminate(&adev->psp);
 }
 
-int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
+static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
 	struct ras_ih_if ih_info = {
@@ -642,7 +642,7 @@ int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
-	amdgpu_xgmi_reset_ras_error_count(adev);
+	adev->gmc.xgmi.ras_funcs->reset_ras_error_count(adev);
 
 	if (!adev->gmc.xgmi.ras_if) {
 		adev->gmc.xgmi.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
@@ -664,7 +664,7 @@ int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
 	return r;
 }
 
-void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
+static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL) &&
 			adev->gmc.xgmi.ras_if) {
@@ -691,7 +691,7 @@ static void pcs_clear_status(struct amdgpu_device *adev, uint32_t pcs_status_reg
 	WREG32_PCIE(pcs_status_reg, 0);
 }
 
-void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
+static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	uint32_t i;
 
@@ -751,8 +751,8 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
-				      void *ras_error_status)
+static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
+					     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	int i;
@@ -801,10 +801,17 @@ int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		break;
 	}
 
-	amdgpu_xgmi_reset_ras_error_count(adev);
+	adev->gmc.xgmi.ras_funcs->reset_ras_error_count(adev);
 
 	err_data->ue_count += ue_cnt;
 	err_data->ce_count += ce_cnt;
 
 	return 0;
 }
+
+const struct amdgpu_xgmi_ras_funcs xgmi_ras_funcs = {
+	.ras_late_init = amdgpu_xgmi_ras_late_init,
+	.ras_fini = amdgpu_xgmi_ras_fini,
+	.query_ras_error_count = amdgpu_xgmi_query_ras_error_count,
+	.reset_ras_error_count = amdgpu_xgmi_reset_ras_error_count,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 148560d63554..12969c0830d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -50,6 +50,7 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
+extern const struct amdgpu_xgmi_ras_funcs xgmi_ras_funcs;
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
 void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
@@ -58,14 +59,8 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
 int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev);
-int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev);
-void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr);
-int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
-				      void *ras_error_status);
-void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev);
-
 static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 		struct amdgpu_device *bo_adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1567dd227f51..ce2b1a9125ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1208,7 +1208,7 @@ static int gmc_v9_0_early_init(void *handle)
 		adev->gmc.xgmi.supported = true;
 		adev->gmc.xgmi.connected_to_cpu =
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
-        }
+	}
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
