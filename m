Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89355C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9AA61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B9AA61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD046EABA;
	Tue, 21 Sep 2021 18:08:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6662C6EAC1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8a6I4pwW22Wu/OqkwsVZdcVqSineb3aT0ycUV3WqLUz49TStUtB9JLbFxx6qj2U048KWaFqCmFQ1LwQEUh1JsCu2W0wsGeQSUd3FALAWj1l4ES0sT6rGNN5FUnv+3gFT9PQGcYih271rbphYBfxqYh6YzW5+lycwA0mX/XS997sd1+BLjhLSXHA38h0QdTtTanWl9gy4d9rA6qwcGISFet+wRIZTywfBcK5ms3SQiiVCtzL23GRLby1exbUn0E7FHSZB/smbXvFK/FYwV9yL7gptagr62le9HZUiZUdSFCbX1pzpZyxwrJu8maeqI9V74TRkXZC+Zh/tRraO7iDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SHH/mKDN40wfMFzhx5VlfvY2VX/9uKPfIr0D4LFoPiU=;
 b=Bx2pndHXfSv6ApJ4Wn37lMcv7Izrke0HfpNpmtgwK9MDnzShPFc6XNPKFdnJxZCZF+suPt7BYP8Q0uNvFeisA2SV9fCKKn0g6STGYYqpf1vc2jQ1aBLy5ltw5u4G79BKuby2DKDR7opXGzQg5jJMoRT1cddVqLaxbnhGXa71GrNdcBbvG74VXqeC5KAFfidLB9RXGvqFiVsP5AO72ZA1s5u59XNAarA+an/P1v5nL/5OsA5DIHiWSMdpNBTf0HVrfmHxP0nNbXD2Y94dMxs6sx5E0JM0XzDTTZk6FM6MWosmMbAgjkAvbB4F5MghwRV76mdfoCVF3LQndzFHmtSylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHH/mKDN40wfMFzhx5VlfvY2VX/9uKPfIr0D4LFoPiU=;
 b=qDwdXhU9rZknOt8ohdV0iOyQsTzcsUAmPVtj3raNCV6cKhGs55CdICypUALLXZpSHe+iVTAzXZlfODi9RAEkLmoTRzJO6LDL4dFNWZfNE6oWFPNWDQ45d8EIJTIpwQZrrrJLYyyw3cdSC8EeWQV40LqogQneIs3GPar+03XMz8c=
Received: from DM3PR14CA0150.namprd14.prod.outlook.com (2603:10b6:0:53::34) by
 BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:11 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::2a) by DM3PR14CA0150.outlook.office365.com
 (2603:10b6:0:53::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 65/66] drm/amdkfd: convert kfd_device.c to use GC IP version
Date: Tue, 21 Sep 2021 14:07:24 -0400
Message-ID: <20210921180725.1985552-66-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84743d1e-2d4c-4f62-641b-08d97d2ac5b2
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27433582743437A35AF31FFFF7A19@BYAPR12MB2743.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kc6Q6HS0nbGxSCz0rNuCaADC5iFEYV8m51CBZKgjkVkqTrzXxzVgFTJerc7JasliXAwSyIKGGuTIm5/1bZjl/jAm5FbRklXDwZha04vCMXFOBRh/e82qfHi+23xgMNNR6jZ/GHeRZTfoWH4g0Q/AKnRjn8j7XQAmZ6zJuuqtWIEsnApSRVNtYzRfwUkQsz36xHnJbdCJPbspu12T9gr/H30VZdiIFUhNv4N9b7cKTpLZI2diWN0H1B/5g9H1CAxeubSLjIL0a1G74ELI2h+nHIDO1FY9+o8P+4FoQmt1gI93zECAlUB8w6oYTD7VcPq6ciYERuOC5Ltuigfrmk4E5Kh/PnOC7njMXuzSKuKMdNawim8TENpxIj1cC1WD2lWiorbIQqJexFtWQ6t90jh0djhF4WK6QJTfHvdHeypAIMUIwLU2Y3gYDQLMJvSLKKlQrTBntRkw+akL2bkkCWoiEdR5GuzLkDMR4TXn73B5ZTIusWatY3zkcfJZ00qbzLgkMcq5bVt0wPDZFiWZi6y6jdgcHYB8qVgwa2a0hjNcKe7Q94u2LX3G6EBq5TC6ROXNNayIi0bx0I6YmV36yJtFtaS1zm4zMLxScsUfP+Jk9IztJqT1o+G7tlLvT4eDCxHWWspildR1ahxtwCchbBQUth23iwXKszJwAQJee7HvasdoQUYtzdTrYZk49nJvp71irK2eO5Wz+xQHKMxiBioH+d3W/Se7iujjDhuz8Decc5I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(8936002)(36756003)(356005)(7696005)(5660300002)(36860700001)(81166007)(8676002)(6916009)(336012)(70206006)(426003)(316002)(86362001)(1076003)(83380400001)(4326008)(82310400003)(70586007)(6666004)(508600001)(2906002)(47076005)(16526019)(26005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:10.7707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84743d1e-2d4c-4f62-641b-08d97d2ac5b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2743
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 254 +++++++++++++++++-------
 1 file changed, 178 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9269b5e3aed1..25614a86b2c9 100644
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
+			device_info = &kaveri_device_info;
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

