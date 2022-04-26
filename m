Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4471F10EF97;
	Tue, 26 Apr 2022 18:27:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28F7E10F064
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tcju/ZXlyQ0S6GY7XWbScSEYFOl0YalgOJFqGtULCM21PHBjYkNHRG37KRfWKxdeqOBZ0K87QsjbhjZXjG85yRQZTf8cYCZFVNuDbT75duBWdWAhWD4VV4a5veDsli9rk1bDvff04VE2yDKQIn62ygzMgI1W05gHhh06cOMaZIGRvh1GWqSnLOOUWA78PFsjYcrk5DBTo5NX6NOV2Vg1RoKcJH/zzC/v3cmEdJuz1hIc1gOfqIRc5K3Ue5Je5MAtQ4ls26IwdCumCoZ9z5HHMlSnp8K/iVnwcVPJnM7VUw+cSY8U27yfD2wuRxFl0fzUTYg4vylLK2MCwLIzBil4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz6BsONIF9sOPwxXnjW4U3av4vpjz3dIkCWakfnZbbw=;
 b=fK89fWihEK1qaHysPxvSE0KWmpavKAsBctqxeHtEiSyu+fpzxo0TQnOlfAcrN72uNDZ1hhefJbapwKp/rcDtQ7gl//MsMwz6hqQZx4wduqT53kz2+YK+vC+nVuNQwsWgDDySmFgtyP3w8hP+7uiuRx+YMDsEv+1maaCzEJj/7XSyy3xlsdHbwiiITCKfdaNO1IpFyPE/pzaG7w+GqZ0CVtQiQpMhbELPgoaQdBqKxMlpREofVnOD6ncG0YiOx4q8MMgP8fWv7gDTJO7wNTD1jyNulF9rfquKM4DX8ucDdrgSo/Pt/e3a4AGE7rUKSvXqucQq/GuVY9UMKmS0Gs13CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz6BsONIF9sOPwxXnjW4U3av4vpjz3dIkCWakfnZbbw=;
 b=2P4yVSASHiSZuaactlFrsRHTThIPogfvIFygteL9DfuzNuvYM4ayNxgOiFAE7tIpIHZVCTR/iaKSAuxCbqpdgmnWT7fT+VwoTohwd2sV8SkO8u+N/1tA6RybOAAJwSC/sPYUiU8HQkpmkLIMHmwRcUjs98cwPVJBBNKQ+JY/xJE=
Received: from BN9PR03CA0744.namprd03.prod.outlook.com (2603:10b6:408:110::29)
 by MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:27:43 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::22) by BN9PR03CA0744.outlook.office365.com
 (2603:10b6:408:110::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/11] drm/amdgpu/discovery: store the number of UMC IPs on
 the asic
Date: Tue, 26 Apr 2022 14:27:22 -0400
Message-ID: <20220426182728.3006737-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18627f69-89be-452a-fadd-08da27b27483
X-MS-TrafficTypeDiagnostic: MN2PR12MB3198:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3198E189F8E2A5C7EA619449F7FB9@MN2PR12MB3198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2uqLyUo3+PmSJ4dJvxT5ERzorB1MKykPVhvvIDJUAM7G9+RswFV39VOr2w/3djk+YjHoH5csRymhMrW6DNw+NUyFW4kE6HZT8sqLCZQCs2YNrT5OzocuTo5X828HBcUlOsC8NYcOx8H5TCnnxA0A4Mgj5ZtNVwNFe3onzTA/BVFUVwPsEPaZOAo2oDS5f3AYp+Xf7rIwouJqMeCrR5Sifn+kgs9n8J5eYVKWF3xQxqnIRBgZaI0qzrGiG2qLCi8xxpO+DW7uUPo3z+kGd3jw0riRLzRq1/cptNiAy1qXGAUTyygFe6E05zlL3JDLzyJ4jK7Xjht9Dv5/AbUwhy5vwuozQm/c+Le3T1YhIZ0XMoGSXlDsIWz8x4gg56YAvdLzYkFMLXmGiKlhsJiXuMI+ca/ZbbNCwxi+9j5bjXtMHGsCAqGpwDPL95UBmu4jJ7UQXs70XbZRMYPMdW+U1uYHvk5tyyyoxbth5c/us6imfjZyvPrr4do1Kigl3KfwKv5zDjqZvZUc/XfaGw1/tX6gyLxdyieWOCYh0ao8EWzXkjDeA9cQiwWCvtueSHNMpX3NlxfNp0MRBlRhkaQ20HjmTFrpxGQeMUKY/oIEoYn3wyB8dqFG0pXJno5q+uBPlVxLKkhdp66zubhee2/p4ZsXzL2rcPWAKRsfxPmOrq6etrMKz4knOmrwW/d7nyBdE1RyKOyBHH3Mqryoaf7F9l+MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(47076005)(4326008)(6666004)(508600001)(8676002)(70586007)(40460700003)(81166007)(86362001)(356005)(70206006)(6916009)(336012)(7696005)(5660300002)(2906002)(426003)(36860700001)(36756003)(83380400001)(26005)(82310400005)(1076003)(186003)(2616005)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:43.8033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18627f69-89be-452a-fadd-08da27b27483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For chips with IP discovery get this from the table,
hardcode it for older asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4a793309c019..233e03f5f072 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1033,6 +1033,9 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
 				adev->sdma.num_instances++;
 
+			if (le16_to_cpu(ip->hw_id) == UMC_HWID)
+				adev->gmc.num_umc++;
+
 			for (k = 0; k < num_base_address; k++) {
 				/*
 				 * convert the endianness of base addresses in place,
@@ -1667,6 +1670,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->gmc.num_umc = 4;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 0);
@@ -1688,6 +1692,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_VEGA12:
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->gmc.num_umc = 4;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 1);
@@ -1710,6 +1715,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 1;
 		adev->vcn.num_vcn_inst = 1;
+		adev->gmc.num_umc = 2;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
 			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 2, 0);
 			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 2, 0);
@@ -1747,6 +1753,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_VEGA20:
 		vega20_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->gmc.num_umc = 8;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 0);
@@ -1770,6 +1777,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		arct_reg_base_init(adev);
 		adev->sdma.num_instances = 8;
 		adev->vcn.num_vcn_inst = 2;
+		adev->gmc.num_umc = 8;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 1);
@@ -1797,6 +1805,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		aldebaran_reg_base_init(adev);
 		adev->sdma.num_instances = 5;
 		adev->vcn.num_vcn_inst = 2;
+		adev->gmc.num_umc = 4;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 4, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 67e488cdc816..e7dc069c4512 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -260,6 +260,8 @@ struct amdgpu_gmc {
 
 	/* MALL size */
 	u64 mall_size;
+	/* number of UMC instances */
+	int num_umc;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
-- 
2.35.1

