Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94255C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB0B61401
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 16:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DB0B61401
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E586E0AB;
	Fri, 19 Nov 2021 16:28:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286E06E0EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 16:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSYCLXv7+0fQUMwnur3fCBZj5S+rvX8DYd3/K7l+a2pAC+YIoohN1BW409JeoZcariLSESoWh4cbTPQvfwksuXocuJtk4g0lPH/9vNtml/R2Q1/2eaDzTYQ6AM/B/Ybau4txHrMn1xaAnQPJD1wNYs8k34poN/MEOwhWhX67tDv7nllvm69nYXj6uWRmndoEqHvyrdnqeX/4ej0USmuiM4Cp7ysQaAt6SmLJ3IDPP4RqoMbMD7vkc+QE8fVH+oym6NXYFB2TmAIgVxHsRzhNwJzMJ/8P7DdUyMIs8roOJfs6z+hgmM+R91kxKgqJledvs7NM22+YU8BPSXJl5qo6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3DuyTLGGGA5EvmEFifzEUIGWYyjHOGKSfr0iWEGU3M=;
 b=InKk9D0aLvqPMVjweN2B3QE2ALWLd9tu+vE7DGrM+LDbFspDqG3V/bs4fKkXHMxxS+CiLrRePiNEV1+B6fGvto/Kz1SHm6x1ARFVbAbNxtCj0L3JN3VMl1xg9ESXGlld5rnjYDkfeFuzm1HY8bHOGIGZSQHbgTTwayjlyQFIfxN1W72BbUPFFacZ8MAYS3qd4l7VSwjniHeAkxZ7cORDsdAjrzpHWC7/A4lbgjj5Mj9+Xzi+SpH84WqL0UIYFLG2ExH9wl83B+PGkq2quMrFxV3K8OhKGdIcTofCz7a1NuhCjDOPie1Ch/8AbO/GJiPaIPvx8gFWaNyWGHnF8sEstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3DuyTLGGGA5EvmEFifzEUIGWYyjHOGKSfr0iWEGU3M=;
 b=vqLjL6EzEdkBCNbBaJrxNwdYA8wXC9d4n508F5ZQK75hfPxmCb5Cbt+gysd9h8rtA7YNF0oRLpHw39wVqEHtwKx92jCBqMolVu1h+MxaO5/va1NIOmCMB7NmwGC1O4c2gTwktjEwhEyRCJbCp2Rnbbhqo+WRyoc8M/877yDQBjQ=
Received: from DS7PR03CA0354.namprd03.prod.outlook.com (2603:10b6:8:55::12) by
 BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Fri, 19 Nov 2021 16:28:35 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::d2) by DS7PR03CA0354.outlook.office365.com
 (2603:10b6:8:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 16:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 16:28:35 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 10:28:32 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdkfd: move to dynamic device_info creation
Date: Fri, 19 Nov 2021 11:27:59 -0500
Message-ID: <20211119162800.2111819-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119162800.2111819-1-Graham.Sider@amd.com>
References: <20211119162800.2111819-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb391619-e861-4ee6-443d-08d9ab79a296
X-MS-TrafficTypeDiagnostic: BYAPR12MB2693:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2693C52ADB23F737D1D533258A9C9@BYAPR12MB2693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwmTQMvx+yoGsZ5NiTFKnCFuozhHUPL12SRQeDQ4P8kkoEnrAX9u+SIdxhAXnTC8RfpYhNAdqwO3/Mkh1wT3OX4lQB1STrvO8wlXb4sZRXjUEEljDUJk0G8OXEMQA8E1m/0LQjgasL1v2yKfsD5afrYeuLAifVYJG3pcNBR33JBlmkhVKGMoYSwVAP5q/wQQCwyurjmoQ1uK0KugBRSYxWjtGjwgiXcapfY4fL8MRts+yUedwuwy7KN75lEsII2GYzuA/mZbu4Htyi7qYU6Lfeierl5DT47A/Ug+hMFF6SXOF+eoVj74uxA3kmZFTQ3qwSn9PJ3uuF3VPkWLY9DhD44bqIWFVpVImPVo+0I7v8scE37TYVYYe3Er9znG5wwe1WMQLgXkKTF/9ubFV1QfBlRQicqyM6KUrvE0MW8chimQFRMfM+mTBqLjSksr1AInDJ4yUc+5JCBUWk+vv8l8m45oZvWlgRqb78AM2sAZrLt6l5/tcFHCVqNefTvV2xY/Ebilb36YfanGFXIS4oFtjqXSjSUpmenr8DI0qQR3QAbslzxfmD17EVS/e/uhvsPvZZQKonbnIL/w50FfA+Go93kF5IZ00XYKF2pw7BQyiSPQLYhK/lN+U9JFO/DE9+m9fUErEe0WTbmYh5P183WCFnYcBGH9e3mVbRg0VbpgfSugl520Oh1aZyJXouaXYsgF0fU4r2DBmoQmb5CXRC2xjgdJda1BJb9wFrD3WHXEwAA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(26005)(336012)(1076003)(8676002)(2616005)(83380400001)(36860700001)(7696005)(8936002)(36756003)(6666004)(2906002)(316002)(81166007)(70206006)(4326008)(6916009)(86362001)(70586007)(47076005)(186003)(356005)(54906003)(508600001)(5660300002)(426003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 16:28:35.5735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb391619-e861-4ee6-443d-08d9ab79a296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2693
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change unsupported asic condition to only probe f2g, move device_info
initialization post-switch and map to heap.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 190 ++++++++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |   2 +-
 2 files changed, 83 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 23e35a466cf0..65e0eb5e2926 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -571,200 +571,170 @@ static void kfd_device_info_init(struct kfd_device_info *device_info,
 
 struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 {
-	struct kfd_dev *kfd;
-	const struct kfd_device_info *device_info;
-	const struct kfd2kgd_calls *f2g;
+	struct kfd_dev *kfd = NULL;
+	struct kfd_device_info *device_info = NULL;
+	const struct kfd2kgd_calls *f2g = NULL;
 	struct pci_dev *pdev = adev->pdev;
 
+	uint32_t gc_version = adev->ip_versions[GC_HWIP][0];
+	uint32_t is_soc15 = gc_version >= IP_VERSION(9, 0, 1);
+	uint32_t gfx_target_version = 0;
+
 	switch (adev->asic_type) {
 #ifdef KFD_SUPPORT_IOMMU_V2
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_KAVERI:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &kaveri_device_info;
-		f2g = &gfx_v7_kfd2kgd;
+		gfx_target_version = 70000;
+		if (!vf)
+			f2g = &gfx_v7_kfd2kgd;
 		break;
 #endif
 	case CHIP_CARRIZO:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &carrizo_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80001;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 #endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_HAWAII:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &hawaii_device_info;
-		f2g = &gfx_v7_kfd2kgd;
+		gfx_target_version = 70001;
+		if (!vf)
+			f2g = &gfx_v7_kfd2kgd;
 		break;
 #endif
 	case CHIP_TONGA:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &tonga_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80002;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_FIJI:
-		if (vf)
-			device_info = &fiji_vf_device_info;
-		else
-			device_info = &fiji_device_info;
+		gfx_target_version = 80003;
 		f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_POLARIS10:
-		if (vf)
-			device_info = &polaris10_vf_device_info;
-		else
-			device_info = &polaris10_device_info;
+		gfx_target_version = 80003;
 		f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_POLARIS11:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &polaris11_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80003;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_POLARIS12:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &polaris12_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80003;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 	case CHIP_VEGAM:
-		if (vf)
-			device_info = NULL;
-		else
-			device_info = &vegam_device_info;
-		f2g = &gfx_v8_kfd2kgd;
+		gfx_target_version = 80003;
+		if (!vf)
+			f2g = &gfx_v8_kfd2kgd;
 		break;
 	default:
-		switch (adev->ip_versions[GC_HWIP][0]) {
+		switch (gc_version) {
 		case IP_VERSION(9, 0, 1):
-			if (vf)
-				device_info = &vega10_vf_device_info;
-			else
-				device_info = &vega10_device_info;
+			gfx_target_version = 90000;
 			f2g = &gfx_v9_kfd2kgd;
 			break;
 #ifdef KFD_SUPPORT_IOMMU_V2
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &raven_device_info;
-			f2g = &gfx_v9_kfd2kgd;
+			gfx_target_version = 90002;
+			if (!vf)
+				f2g = &gfx_v9_kfd2kgd;
 			break;
 #endif
 		case IP_VERSION(9, 2, 1):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &vega12_device_info;
-			f2g = &gfx_v9_kfd2kgd;
+			gfx_target_version = 90004;
+			if (!vf)
+				f2g = &gfx_v9_kfd2kgd;
 			break;
 		case IP_VERSION(9, 3, 0):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &renoir_device_info;
-			f2g = &gfx_v9_kfd2kgd;
+			gfx_target_version = 90012;
+			if (!vf)
+				f2g = &gfx_v9_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 0):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &vega20_device_info;
-			f2g = &gfx_v9_kfd2kgd;
+			gfx_target_version = 90006;
+			if (!vf)
+				f2g = &gfx_v9_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 1):
-			device_info = &arcturus_device_info;
+			gfx_target_version = 90008;
 			f2g = &arcturus_kfd2kgd;
 			break;
 		case IP_VERSION(9, 4, 2):
-			device_info = &aldebaran_device_info;
+			gfx_target_version = 90010;
 			f2g = &aldebaran_kfd2kgd;
 			break;
 		case IP_VERSION(10, 1, 10):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &navi10_device_info;
-			f2g = &gfx_v10_kfd2kgd;
+			gfx_target_version = 100100;
+			if (!vf)
+				f2g = &gfx_v10_kfd2kgd;
 			break;
 		case IP_VERSION(10, 1, 2):
-			device_info = &navi12_device_info;
+			gfx_target_version = 100101;
 			f2g = &gfx_v10_kfd2kgd;
 			break;
 		case IP_VERSION(10, 1, 1):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &navi14_device_info;
-			f2g = &gfx_v10_kfd2kgd;
+			gfx_target_version = 100102;
+			if (!vf)
+				f2g = &gfx_v10_kfd2kgd;
 			break;
 		case IP_VERSION(10, 1, 3):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &cyan_skillfish_device_info;
-			f2g = &gfx_v10_kfd2kgd;
+			gfx_target_version = 100103;
+			if (!vf)
+				f2g = &gfx_v10_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 0):
-			device_info = &sienna_cichlid_device_info;
+			gfx_target_version = 100300;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 2):
-			device_info = &navy_flounder_device_info;
+			gfx_target_version = 100301;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 1):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &vangogh_device_info;
-			f2g = &gfx_v10_3_kfd2kgd;
+			gfx_target_version = 100303;
+			if (!vf)
+				f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 4):
-			device_info = &dimgrey_cavefish_device_info;
+			gfx_target_version = 100302;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 5):
-			device_info = &beige_goby_device_info;
+			gfx_target_version = 100304;
 			f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		case IP_VERSION(10, 3, 3):
-			if (vf)
-				device_info = NULL;
-			else
-				device_info = &yellow_carp_device_info;
-			f2g = &gfx_v10_3_kfd2kgd;
+			gfx_target_version = 100305;
+			if (!vf)
+				f2g = &gfx_v10_3_kfd2kgd;
 			break;
 		default:
-			return NULL;
+			break;
 		}
 		break;
 	}
 
-	if (!device_info || !f2g) {
-		if (adev->ip_versions[GC_HWIP][0])
+	if (!f2g) {
+		if (is_soc15)
 			dev_err(kfd_device, "GC IP %06x %s not supported in kfd\n",
-				adev->ip_versions[GC_HWIP][0], vf ? "VF" : "");
+				gc_version, vf ? "VF" : "");
 		else
 			dev_err(kfd_device, "%s %s not supported in kfd\n",
 				amdgpu_asic_name[adev->asic_type], vf ? "VF" : "");
 		return NULL;
 	}
 
+	device_info = kzalloc(sizeof(*device_info), GFP_KERNEL);
+	if (!device_info)
+		return NULL;
+
+	kfd_device_info_init(device_info, is_soc15 ? gc_version : adev->asic_type,
+			is_soc15, vf, gfx_target_version);
+
 	kfd = kzalloc(sizeof(*kfd), GFP_KERNEL);
 	if (!kfd)
 		return NULL;
@@ -1036,7 +1006,11 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 			amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
 	}
 
-	kfree(kfd);
+	if (kfd->device_info)
+		kfree(kfd->device_info);
+
+	if (kfd)
+		kfree(kfd);
 }
 
 int kgd2kfd_pre_reset(struct kfd_dev *kfd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3e11febee7c6..1f11e8271f2e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -232,7 +232,7 @@ struct kfd_vmid_info {
 struct kfd_dev {
 	struct amdgpu_device *adev;
 
-	const struct kfd_device_info *device_info;
+	struct kfd_device_info *device_info;
 	struct pci_dev *pdev;
 	struct drm_device *ddev;
 
-- 
2.25.1

