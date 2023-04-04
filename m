Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31E9C761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 09:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F8210E638;
	Tue,  4 Apr 2023 09:57:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B0010E636
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 09:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks1ENNmKCEiDqaa7mmYjoSqGcLW8OhHbHdkhU5P/IIeVLTxMPH6tK6G1xQIunhtLeOs1GfzVhQjFNaSI+UYf1q7S4EItiWnaIdKrPuop1LQw0fgAbKOKdq5a7CvsTHmkKMHa5MOPQzJ5pzCaVZBd7YfCxIpfqX7POgeYAenWByy1Zs1PZfSnuiHnYwWmdjl809lr0RK93Ond1c41N74mmCafUFhbxv1n1UQMEcnhUJocE7Tl1almrodmtgPmgK2r9TilSN7p+F+XKBrraK8M3xQ/oyvgcnPP8h/3usdZu98XvtVIRYkI+VV0SZcevM/dSoZgs+aZVnCrxUEkoBAJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uyX/hc10YMA20V1UBaFAD04T0OsoKE/rkN+LxqqxEs=;
 b=lS8CC0UNqYmcM8G1Df6Qdza07cpc0j25icEClqjGg6lnDkCkbaH6CWBV1Fh3yKGJGDYe/U6TmAWvYjYXEF9VPxkrYREOc2SOqwu/IziYyW7XBuzhmrgMYVGL23YSUodSbdmnyYy1kh88B9Xrp4A/YiyrsnQn6hYVyB620OIYdmBe4IRyBk6dEls7LZqAZfFqGD+15dpc2GjCcMFPQrm0kgfkmp7ky8CsSK8eM8EMn4LOecM6Sk0urghW/2O4KcWcrw3QM0b2vvtTozDj3KnVJDmMluuB8kt0ytjc/bwYps25dDrOxENVxzZ3efvEtsec5r84e+w1ROCFvfCGj9117w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uyX/hc10YMA20V1UBaFAD04T0OsoKE/rkN+LxqqxEs=;
 b=5eM4cuQCN9Y8G49R4P1OSJPbHmeSn/slILJz2RTDplnhSZE2BsVNNH7PsbZBoEcSspsTREDLDvfZCh083zHQGpqeb1z2teOAgHHwqb4IgKqaOpprNeZd+YWibM2ys/8P/NZ1kP+fg9i441rmMgD1G/m0nJImScMZayEtKWokUfw=
Received: from BN9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::32)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 09:57:08 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::61) by BN9P223CA0027.outlook.office365.com
 (2603:10b6:408:10b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 09:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Tue, 4 Apr 2023 09:57:08 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 4 Apr
 2023 04:57:06 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <felix.kuehling@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when iommu
 is on
Date: Tue, 4 Apr 2023 17:56:38 +0800
Message-ID: <20230404095640.3277840-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 880b25a8-0526-481f-2005-08db34f2f418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKGMWixtVEO4La9xC/7t98R4PmCtkZNMd5409oXlEj2PYWycdzD9h7OU3YP/8ZfoVnFKofMPMz4MO2+IuooQRYu3HCknomcYf8EntmHEN9G36M4mkeAG/IYnEhBV0PGngI43CdL3NwuR3PBCa1aVTws6EEYEt7R5FLc0GGs4oQEz+KoX4at95/5Wag/v5scwET/Tmg5WclGmtNslhqtm/jWmAREStanDRzOvZb5yQC4WiBNhWqElZfH8MMF4215DEMZOpmq8p5x7koamv1Oew4tv4mNspRbyUEPitlnUVQxugH37FJFnrooiUISEM9QGsUCoI6lGCL96VAhO3N74Ica3UYKe2WvrQtkBKrlR1kczERUOLV2bC0l6AntVVxFKQL5YacTBOA4bMN4nIWgpamRu34GZZEKbSjv0F7kGryV9t3M1u5cmt5e1maxhAPwUEFdoNET48te4QK0gz4zXpGrQF6w7GTJQAxkGJnymT41MmeS8zRbbEVGAI1xQDpnCsyNNs1Gg9xT1tQ5BJekkNNqCGhXePcuJImkEU+W1EMTiHZAqXNH/zK4tX3/QevSFICmGoIIUQo8viPAGvv1s4OaSntYGXBDAlcyj0lWm9PR+dYJzXrm/3pB2Ck8TiRWMs7K+avAfbe6ZCEv92ku6l1dd9J4fA8JcwGAS8S+jpbXH7XCBGzFmky3DcevLPDTbX8U7hlwSdKTRGookYddRAtVAwSa/2qMu+RjjTrkI7tQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(82740400003)(82310400005)(356005)(478600001)(40480700001)(81166007)(36756003)(36860700001)(70586007)(8676002)(4326008)(86362001)(70206006)(41300700001)(110136005)(316002)(54906003)(7696005)(40460700003)(8936002)(6636002)(44832011)(2616005)(336012)(426003)(186003)(16526019)(1076003)(26005)(2906002)(6666004)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 09:57:08.4540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880b25a8-0526-481f-2005-08db34f2f418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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
Cc: Shane Xiao <shane.xiao@amd.com>, aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For userptr bo with iommu on, multiple GPUs use same system
memory dma mapping address when both bo_adev and adev in identity
mode or in the same iommu group.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e7403f8e4eba..33cda358cb9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -804,11 +804,11 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			 va + bo_size, vm);
 
 		if ((adev == bo_adev && !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
-		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && adev->ram_is_direct_mapped) ||
-		    same_hive) {
+		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) && ((adev->ram_is_direct_mapped && bo_adev->ram_is_direct_mapped) ||
+			adev->dev->iommu_group == bo_adev->dev->iommu_group)) || same_hive){
 			/* Mappings on the local GPU, or VRAM mappings in the
-			 * local hive, or userptr mapping IOMMU direct map mode
-			 * share the original BO
+			 * local hive, or userptr mapping in the same dma
+			 * address space share the original BO
 			 */
 			attachment[i]->type = KFD_MEM_ATT_SHARED;
 			bo[i] = mem->bo;
-- 
2.25.1

