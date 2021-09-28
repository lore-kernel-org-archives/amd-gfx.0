Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDB9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFB56101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9AFB56101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9A56E8EC;
	Tue, 28 Sep 2021 16:46:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033E86E8F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acYO5pH8/Uy+XrFCuuvNHLEunndeSo1mk3BnB0QD0JHZXX2T09NYdeio/A8nWLUItefRj5OIqzGu4JCT95yzbw/Y27XpVotuFBP8kQTQHkmslSQNezGhnvN8G/BYQpqo6GFMr2sGf+9pm3HScbeMYyqzN8Z4QL0n4zxLyit6b7aTAo6DKC5B5VvEtlfL87j7qjPqqECqvlLUra7SyGmVqJ6XNW35ofWlipXUHs6WNrCtjrVGKO8Hj5h0iKx9WotVQgjWgaP6hYIZ39gKW7fystJgxtyT1Jhc4/sfmUftFQ0JKfnSrc43nv2t0+qozFH/h4DY36hZBk6rBvQnmYrLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=WXZqRV6Do69lY45f/+O0Wd600YX7+9YcPfGX67w0nUo=;
 b=E81WmnqKcWNjb9Pi/FNPS8usTOX8gPNgZWYtjvCeNjIQWGnT6qpastflusVd7kVh9PLJ6d7nNPaSBMNC/UwdZG6s1tC62yzOQ6BEYZI3j2aW5/RZD5xqLvQvPStUXSqPgnN0Un5hu1op+7YhbDxofhanLtsftHvHkbbrMxmzZU9fICQrL44wfGmQ4wl01It+jq1qq/mFVrBa4co9W1veokSpylNOWyn7S+CNsSnFvVJFAE+8yuLlAQX0V0i84V60USZdZvr1/bZOSYyWBneeImgNwx+6Pnp76dRdxZj61izgXlIcn6XkOpIG9jSsSHD7ae/AXUgTKY6ikX15mi5sMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXZqRV6Do69lY45f/+O0Wd600YX7+9YcPfGX67w0nUo=;
 b=GvMuP27gSDxFoNR1mznNoTChqMiwqLI7kXurgwD5GuTbtZBkXXEJRKVLO0iwe7gnnKMwkb7XkarNKxD9GOSdBo0U/gzREPYP23wybQdgck2xW0XKoiFARfCjbO0mEIpoXbbzk6HXC4JcCsMrtJiDhJkJQISGhPj9PmjhQ6uCjjs=
Received: from DM6PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:333::21)
 by CY4PR12MB1704.namprd12.prod.outlook.com (2603:10b6:903:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 16:46:48 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::74) by DM6PR03CA0088.outlook.office365.com
 (2603:10b6:5:333::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 63/64] drm/amdkfd: convert kfd_device.c to use GC IP version
Date: Tue, 28 Sep 2021 12:42:36 -0400
Message-ID: <20210928164237.833132-64-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1ecd938-dcee-4618-7b90-08d9829f8fe3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1704:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17049FBFDBAD7E35F24009A6F7A89@CY4PR12MB1704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+foZLkxsS/svsYehS8/x6MpDGnMGuayU9Ga1/BES60Au5KZCP8O6gz4jsYTBp7/A64P9kWNCAdlYMjHN5i+diqwVUHJg8sNdej5EbCcJBq1oNiVv8Fq9wwBDn/mI+UnUE+kfN+t2MnuJo4J/HhZltoHI++pYm/6lssILdIf464orwgCrjuPw8Ti3aWANo1BXX1Ldhc2g7uc23npiJlbiCbPIrF32AlNeBPqHOPy0y2CPgplTGnzc4hHPZLNfV3CHMyEUF4IL2iwZbVkRZ6wcL4MbbrMX0n7dtaZHDwmVBkZzXM1gR501aqkrkMw4MSDZ7kFfuCagbqKFY5is1eiM4QjcBtqc8UYFSSmfJzmCSytB1CBc0bFLK+t/GJDYd5MYl3Oj4AzpGyg/syP6vZgLuRh3mQl9OOALLMvoCzuS4ebESoSaqCLlGqoNaOVU0AJBWnqiE67hrJbgo4JfHybLIXTlg9QHQZ7Dx59qjVMD4RP2Bh5FICJJnsoH1U1w8hOgMHW81cibCy9Umz2tMo/9WoVREpwzSvj/7QPyv5Wt4xxtQnpOh/vG1FWJkNeBhDLUEVtvgHpw9tPXVLk5wraRlj/xcIUWVEN165ufvJPVqy6E3z7fydnEGoewOviX27kD4KnJAz/6J357oo1WKMnC0gDz/LmqMPWeGQfKyHLIdUwkBivVLFrYHyLBXxnWlYu7pPu0dXC3WRzfPw8mv/UbAJsB7nJoICq3Hw8uwTiQk8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(86362001)(336012)(6916009)(7696005)(4326008)(186003)(16526019)(8676002)(356005)(316002)(2906002)(81166007)(6666004)(83380400001)(70206006)(36756003)(2616005)(36860700001)(26005)(47076005)(1076003)(82310400003)(508600001)(54906003)(70586007)(8936002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:47.4307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ecd938-dcee-4618-7b90-08d9829f8fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1704
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

rather than asic type.

v2: fix up CZ case

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 254 +++++++++++++++++-------
 1 file changed, 178 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 82af344cbf10..76ab22755ca3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -53,41 +53,6 @@ extern const struct kfd2kgd_calls aldebaran_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 
-static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
-#ifdef KFD_SUPPORT_IOMMU_V2
-#ifdef CONFIG_DRM_AMDGPU_CIK
-	[CHIP_KAVERI] = &gfx_v7_kfd2kgd,
-#endif
-	[CHIP_CARRIZO] = &gfx_v8_kfd2kgd,
-	[CHIP_RAVEN] = &gfx_v9_kfd2kgd,
-#endif
-#ifdef CONFIG_DRM_AMDGPU_CIK
-	[CHIP_HAWAII] = &gfx_v7_kfd2kgd,
-#endif
-	[CHIP_TONGA] = &gfx_v8_kfd2kgd,
-	[CHIP_FIJI] = &gfx_v8_kfd2kgd,
-	[CHIP_POLARIS10] = &gfx_v8_kfd2kgd,
-	[CHIP_POLARIS11] = &gfx_v8_kfd2kgd,
-	[CHIP_POLARIS12] = &gfx_v8_kfd2kgd,
-	[CHIP_VEGAM] = &gfx_v8_kfd2kgd,
-	[CHIP_VEGA10] = &gfx_v9_kfd2kgd,
-	[CHIP_VEGA12] = &gfx_v9_kfd2kgd,
-	[CHIP_VEGA20] = &gfx_v9_kfd2kgd,
-	[CHIP_RENOIR] = &gfx_v9_kfd2kgd,
-	[CHIP_ARCTURUS] = &arcturus_kfd2kgd,
-	[CHIP_ALDEBARAN] = &aldebaran_kfd2kgd,
-	[CHIP_NAVI10] = &gfx_v10_kfd2kgd,
-	[CHIP_NAVI12] = &gfx_v10_kfd2kgd,
-	[CHIP_NAVI14] = &gfx_v10_kfd2kgd,
-	[CHIP_SIENNA_CICHLID] = &gfx_v10_3_kfd2kgd,
-	[CHIP_NAVY_FLOUNDER] = &gfx_v10_3_kfd2kgd,
-	[CHIP_VANGOGH] = &gfx_v10_3_kfd2kgd,
-	[CHIP_DIMGREY_CAVEFISH] = &gfx_v10_3_kfd2kgd,
-	[CHIP_BEIGE_GOBY] = &gfx_v10_3_kfd2kgd,
-	[CHIP_YELLOW_CARP] = &gfx_v10_3_kfd2kgd,
-	[CHIP_CYAN_SKILLFISH] = &gfx_v10_kfd2kgd,
-};
-
 #ifdef KFD_SUPPORT_IOMMU_V2
 static const struct kfd_device_info kaveri_device_info = {
 	.asic_family = CHIP_KAVERI,
@@ -654,38 +619,6 @@ static const struct kfd_device_info cyan_skillfish_device_info = {
 	.num_sdma_queues_per_engine = 8,
 };
 
-/* For each entry, [0] is regular and [1] is virtualisation device. */
-static const struct kfd_device_info *kfd_supported_devices[][2] = {
-#ifdef KFD_SUPPORT_IOMMU_V2
-	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
-	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
-#endif
-	[CHIP_RAVEN] = {&raven_device_info, NULL},
-	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
-	[CHIP_TONGA] = {&tonga_device_info, NULL},
-	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
-	[CHIP_POLARIS10] = {&polaris10_device_info, &polaris10_vf_device_info},
-	[CHIP_POLARIS11] = {&polaris11_device_info, NULL},
-	[CHIP_POLARIS12] = {&polaris12_device_info, NULL},
-	[CHIP_VEGAM] = {&vegam_device_info, NULL},
-	[CHIP_VEGA10] = {&vega10_device_info, &vega10_vf_device_info},
-	[CHIP_VEGA12] = {&vega12_device_info, NULL},
-	[CHIP_VEGA20] = {&vega20_device_info, NULL},
-	[CHIP_RENOIR] = {&renoir_device_info, NULL},
-	[CHIP_ARCTURUS] = {&arcturus_device_info, &arcturus_device_info},
-	[CHIP_ALDEBARAN] = {&aldebaran_device_info, &aldebaran_device_info},
-	[CHIP_NAVI10] = {&navi10_device_info, NULL},
-	[CHIP_NAVI12] = {&navi12_device_info, &navi12_device_info},
-	[CHIP_NAVI14] = {&navi14_device_info, NULL},
-	[CHIP_SIENNA_CICHLID] = {&sienna_cichlid_device_info, &sienna_cichlid_device_info},
-	[CHIP_NAVY_FLOUNDER] = {&navy_flounder_device_info, &navy_flounder_device_info},
-	[CHIP_VANGOGH] = {&vangogh_device_info, NULL},
-	[CHIP_DIMGREY_CAVEFISH] = {&dimgrey_cavefish_device_info, &dimgrey_cavefish_device_info},
-	[CHIP_BEIGE_GOBY] = {&beige_goby_device_info, &beige_goby_device_info},
-	[CHIP_YELLOW_CARP] = {&yellow_carp_device_info, NULL},
-	[CHIP_CYAN_SKILLFISH] = {&cyan_skillfish_device_info, NULL},
-};
-
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
 static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
@@ -698,21 +631,190 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
 	const struct kfd_device_info *device_info;
 	const struct kfd2kgd_calls *f2g;
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	unsigned int asic_type = adev->asic_type;
 	struct pci_dev *pdev = adev->pdev;
 
-	if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void *) * 2)
-		|| asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
-		dev_err(kfd_device, "asic_type %d out of range\n", asic_type);
-		return NULL; /* asic_type out of range */
+	switch (adev->asic_type) {
+#ifdef KFD_SUPPORT_IOMMU_V2
+#ifdef CONFIG_DRM_AMDGPU_CIK
+	case CHIP_KAVERI:
+		if (vf)
+			device_info = NULL;
+		else
+			device_info = &kaveri_device_info;
+		f2g = &gfx_v7_kfd2kgd;
+		break;
+#endif
+	case CHIP_CARRIZO:
+		if (vf)
+			device_info = NULL;
+		else
+			device_info = &carrizo_device_info;
+		f2g = &gfx_v8_kfd2kgd;
+		break;
+#endif
+#ifdef CONFIG_DRM_AMDGPU_CIK
+	case CHIP_HAWAII:
+		if (vf)
+			device_info = NULL;
+		else
+			device_info = &hawaii_device_info;
+		f2g = &gfx_v7_kfd2kgd;
+		break;
+#endif
+	case CHIP_TONGA:
+		if (vf)
+			device_info = NULL;
+		else
+			device_info = &tonga_device_info;
+		f2g = &gfx_v8_kfd2kgd;
+		break;
+	case CHIP_FIJI:
+		if (vf)
+			device_info = &fiji_vf_device_info;
+		else
+			device_info = &fiji_device_info;
+		f2g = &gfx_v8_kfd2kgd;
+		break;
+	case CHIP_POLARIS10:
+		if (vf)
+			device_info = &polaris10_vf_device_info;
+		else
+			device_info = &polaris10_device_info;
+		f2g = &gfx_v8_kfd2kgd;
+		break;
+	case CHIP_POLARIS11:
+		if (vf)
+			device_info = NULL;
+		else
+			device_info = &polaris11_device_info;
+		f2g = &gfx_v8_kfd2kgd;
+		break;
+	case CHIP_POLARIS12:
+		if (vf)
+			device_info = NULL;
+		else
+			device_info = &polaris12_device_info;
+		f2g = &gfx_v8_kfd2kgd;
+		break;
+	case CHIP_VEGAM:
+		if (vf)
+			device_info = NULL;
+		else
+			device_info = &vegam_device_info;
+		f2g = &gfx_v8_kfd2kgd;
+		break;
+	default:
+		switch (adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(9, 0, 1):
+			if (vf)
+				device_info = &vega10_vf_device_info;
+			else
+				device_info = &vega10_device_info;
+			f2g = &gfx_v9_kfd2kgd;
+			break;
+#ifdef KFD_SUPPORT_IOMMU_V2
+		case IP_VERSION(9, 1, 0):
+		case IP_VERSION(9, 2, 2):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &raven_device_info;
+			f2g = &gfx_v9_kfd2kgd;
+			break;
+#endif
+		case IP_VERSION(9, 2, 1):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &vega12_device_info;
+			f2g = &gfx_v9_kfd2kgd;
+			break;
+		case IP_VERSION(9, 3, 0):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &renoir_device_info;
+			f2g = &gfx_v9_kfd2kgd;
+			break;
+		case IP_VERSION(9, 4, 0):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &vega20_device_info;
+			f2g = &gfx_v9_kfd2kgd;
+			break;
+		case IP_VERSION(9, 4, 1):
+			device_info = &arcturus_device_info;
+			f2g = &arcturus_kfd2kgd;
+			break;
+		case IP_VERSION(9, 4, 2):
+			device_info = &aldebaran_device_info;
+			f2g = &aldebaran_kfd2kgd;
+			break;
+		case IP_VERSION(10, 1, 10):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &navi10_device_info;
+			f2g = &gfx_v10_kfd2kgd;
+			break;
+		case IP_VERSION(10, 1, 2):
+			device_info = &navi12_device_info;
+			f2g = &gfx_v10_kfd2kgd;
+			break;
+		case IP_VERSION(10, 1, 1):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &navi14_device_info;
+			f2g = &gfx_v10_kfd2kgd;
+			break;
+		case IP_VERSION(10, 1, 3):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &cyan_skillfish_device_info;
+			f2g = &gfx_v10_kfd2kgd;
+			break;
+		case IP_VERSION(10, 3, 0):
+			device_info = &sienna_cichlid_device_info;
+			f2g = &gfx_v10_3_kfd2kgd;
+			break;
+		case IP_VERSION(10, 3, 2):
+			device_info = &navy_flounder_device_info;
+			f2g = &gfx_v10_3_kfd2kgd;
+			break;
+		case IP_VERSION(10, 3, 1):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &vangogh_device_info;
+			f2g = &gfx_v10_3_kfd2kgd;
+			break;
+		case IP_VERSION(10, 3, 4):
+			device_info = &dimgrey_cavefish_device_info;
+			f2g = &gfx_v10_3_kfd2kgd;
+			break;
+		case IP_VERSION(10, 3, 5):
+			device_info = &beige_goby_device_info;
+			f2g = &gfx_v10_3_kfd2kgd;
+			break;
+		case IP_VERSION(10, 3, 3):
+			if (vf)
+				device_info = NULL;
+			else
+				device_info = &yellow_carp_device_info;
+			f2g = &gfx_v10_3_kfd2kgd;
+			break;
+		default:
+			return NULL;
+		}
+		break;
 	}
 
-	device_info = kfd_supported_devices[asic_type][vf];
-	f2g = kfd2kgd_funcs[asic_type];
-
 	if (!device_info || !f2g) {
 		dev_err(kfd_device, "%s %s not supported in kfd\n",
-			amdgpu_asic_name[asic_type], vf ? "VF" : "");
+			amdgpu_asic_name[adev->asic_type], vf ? "VF" : "");
 		return NULL;
 	}
 
-- 
2.31.1

