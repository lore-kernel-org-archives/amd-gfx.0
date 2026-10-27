Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9DE606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Xmq2zURI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F239C10F463;
	Tue, 27 Oct 2026 12:56:53 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AFD10E308
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7s1qaqolGg5OmS3eU7huA2gxY3hpQiZu9EUl+ic8ogla2h0dwSMBb8v9HIbCEVyfH/fIDK8wmYVeoPs5NKgg/isWhoXzuj5VnppAG9xyFO+3qScHz0aK09oGXH1lZ2smR0vSf8QweD2jsYk3r6AJ902QssegfC6e+qGAcYs2Tf7BsDb8DxhLR/vBiTP4A+vOrzh1EOA8QHY4rnw4bt6jN4Tbb54n4+ipUkpKxWUwnt/asJUtb8DPWfJXk+398yplO5V3YIPLb2VhvErSJ2Ludtr9bb+pf7EiK8xQimFQic29T6FYJVy8iCmToyoH5jxdzotrkgbIpb4X9U1ywJL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cyGCQmXyzj77nJhj3yDn9EyoQk63AlkrZI/qLinKqA=;
 b=MwvXHHOgQlli0oIyDRAqk6aWsDsKYrWZZNnYitRnhJnx319XZi3kCDUMkztG2rEl6H6DjIm3VUIrRnouawQUdqBUF3t1BIYALXfHqae6YysfWDpA3L/rYnVUINScC6rWrj8lL1iVB3kP66ImErsS15KLZJL9SZp8elicEALwJnhRbAiElaX2HhsdOxX8tpnnVDl0HIO3uVrmibr3LFVLQG/+dyB50YOrA/kQ+2ioPnAIJF72A0Ny8jFzm4CO0hPxsmFtSonBQesyvNx5yVL+R21fwJdZDAG33jmZjvy8UPp6S1QVT4w9H1Aauy7TDxKSGhDJ+f5ina8vOstyEYBFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cyGCQmXyzj77nJhj3yDn9EyoQk63AlkrZI/qLinKqA=;
 b=Xmq2zURIM51AAI3siGmnvpp3+SjrH2IMMGWCzaMMW+b9rMHNdg0MEqiR5dnFkvPdii3cBbPM9J9ohu7vUPR5q0KCNe1wlyjTbgWQ7ctXH6Zmz+YqnD+NG5lZgtIjkxYmq1WOcCWH8Jo2tPZqO0LpWTxx4//1Z2iQjJqeS2fidMY=
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by DS6PR12MB308124.namprd12.prod.outlook.com (2603:10b6:8:49b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:56:41 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::aa) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 12:56:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 12:56:40 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 07:56:39 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: Refactor virt_xchg structures
Date: Tue, 27 Oct 2026 08:56:07 -0400
Message-ID: <20261027125613.6549-2-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027125613.6549-1-victor.skvortsov@amd.com>
References: <20261027125613.6549-1-victor.skvortsov@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|DS6PR12MB308124:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e3dce4-9fea-421d-613b-08df3429bee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|261026140227099003|11063799006|56012099006|261026121527099003|261022105027099003|261022115727099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: kYup2LAePJGZqPFV2pZUtJtb8HRISMbR9mtB2e2ARM6foVC9m7As53C27FhLxfkRvXYxZPHVuDSMbURwftEAV0AkZF4Tyv6fWKhVBu039vnzg9utaNZpGzJtJto4okopOV3EooRwa8KVn6OiRfdpRPtFzViQefsXM4royShplCz6R6Lo1ghKe4z83IuwIlplAUiK1P5WHvAmCFAONzvsvkjblQcrxLra3kjfmtsipfivGwpZEixWRcPdS4MLJAT8nlYwRzWHZqFidOu36u3eu4jLctj1DUd9Kr0ip0WmsWCsgrw1Z67nN6mC+1HPCqbOaBHH6Zf0OvCjxmHlzO6i0/pGcaLXz+yOLwUybxrx8rJq8ckqxVCNBov/q44Gkt61v7ILHOFAarWyUYYdXKMOaL+Oidy8vps1KKqQX6U9cgpBQqub9tJWzNx+9ugcccWCOV6wjBgRov0zP+ndn1eWS1KR5Mo9JfQN5GwBcKjhdviep4YPrkpvhx3FnkGFbECPntwkUM29eT5NQt3RlivTCvj6gdAqC2ynp+wYtDc84n32RIw2uLLJBB/y+f+KoXgvhux3QxRrI6Z5WAlsYVxc2OZ3GQboM8GyyH06C1sv54macaDMGooRuZHkzA8fGWFA1a4cT6qhLiONeHIdSz72zV2ddH7uFOzu4b8VwuGx+BYoiCflxOGXSH0jEfPA1+MZQz5ejDGptpSEukMUp9+dPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261022105027099003)(261022115727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ufPDH2YFbNiZz5aHYQoJWaClvztHgNOF9O703YbnGLJcPe3A2HGyUwwq8tiARoFIzGpv5Q0I205LHfrVUBlZLWbqQaWfkEvDlM+HHrvxGODiNADMuuH9ulwbYao9cxVdMtD7eLmevLjdLMXEQ8VMlC92iyJgRcGf7xkh0QXvUadAKY2YzRaj8gBAsIAcPx9MCnzeUty6nLnfZwNiayCvy6oNH3O7ONzAlnWksITtHcwOTJstViCAAvYcwEKpCnP+PR5tAfTNUe1z/bm/0W9BsqCrtW2RPQog3PT0SGFMiavCwqoL/otgNqI0KuIyJSLwh6MahoHaQmZzvIN/6g966zaLCjJYCCpj0pjWCS6L8kBoZckqfHer1yn838GUtnV+OgHN8dLzgkmdg6wN9K/ldhvObxdP6+Yq2iH0sLZ+LxTg9SgOhoNebmi18vCfJd+w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:56:40.9756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e3dce4-9fea-421d-613b-08df3429bee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB308124
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Consolidate all scattered PF-VF exchange fields into a single structure.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  52 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c | 135 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  18 ++-
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |  12 +-
 10 files changed, 123 insertions(+), 138 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index c283087bb560..6d97cf355de7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -182,7 +182,7 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
 	int usage_bytes = 0;
 
 	/* Skip atomfirmware allocation for SRIOV VFs when dynamic crit regn is enabled */
-	if (!(amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled)) {
+	if (!(amdgpu_sriov_vf(adev) && adev->virt.xchg.dynamic)) {
 		if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
 			if (frev == 2 && crev == 1) {
 				fw_usage_v2_1 =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f9315e0472fe..e42ddd310392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -125,7 +125,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	 * the vbios image is put at a dynamic offset of VRAM in the VF.
 	 * If dynamic critical region is disabled, follow the existing logic as on baremetal.
 	 */
-	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+	if (amdgpu_sriov_vf(adev) && adev->virt.xchg.dynamic) {
 		if (amdgpu_virt_get_dynamic_data_info(adev,
 				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &size)) {
 			amdgpu_bios_release(adev);
@@ -174,7 +174,7 @@ static bool amdgpu_read_bios_from_spm(struct amdgpu_device *adev)
 	 * the vbios image is put at a dynamic offset of VRAM in the VF.
 	 * If dynamic critical region is disabled, read it from SPM.
 	 */
-	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+	if (amdgpu_sriov_vf(adev) && adev->virt.xchg.dynamic) {
 		if (amdgpu_virt_get_dynamic_data_info(adev,
 						      AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
 						      adev->bios, &size)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e0014611f039..dcc029bccd74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1992,7 +1992,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		 * hosts publish the init data through VF FB, which lets us defer
 		 * full GPU access until after non-GPU early init work is done.
 		 */
-		early_full_gpu_access = (adev->virt.req_init_data_ver == 0);
+		early_full_gpu_access = (adev->virt.xchg.req_init_data_ver == 0);
 		if (early_full_gpu_access) {
 			r = amdgpu_virt_request_full_gpu(adev, true);
 			if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 16e3129db6a1..407972a43a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -343,16 +343,12 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 		adev->discovery.offset = (vram_size << 20) - DISCOVERY_TMR_OFFSET;
 
 	if (amdgpu_sriov_vf(adev)) {
-		if (adev->virt.is_dynamic_crit_regn_enabled) {
-			adev->discovery.offset =
-				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
-			adev->discovery.size =
-				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
-			if (!adev->discovery.size)
-				return -EINVAL;
-		} else {
+		if (!adev->virt.xchg.dynamic)
 			goto out;
-		}
+		adev->discovery.offset = adev->virt.xchg.tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
+		adev->discovery.size = adev->virt.xchg.tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
+		if (!adev->discovery.size)
+			return -EINVAL;
 	} else {
 		if (adev->discovery.offset) {
 			u32 signature;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d8b7d02b4205..b053aa883592 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -145,12 +145,6 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 
 	if (virt->ops && virt->ops->req_init_data)
 		virt->ops->req_init_data(adev);
-
-	if (adev->virt.req_init_data_ver > 0)
-		dev_info(adev->dev, "host supports REQ_INIT_DATA handshake of critical_region_version %d\n",
-				 adev->virt.req_init_data_ver);
-	else
-		dev_warn(adev->dev, "host doesn't support REQ_INIT_DATA handshake\n");
 }
 
 /**
@@ -484,7 +478,6 @@ bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev,
 	return false;
 }
 
-
 static u32 amdgpu_virt_init_detect_asic(struct amdgpu_device *adev)
 {
 	uint32_t reg;
@@ -556,7 +549,6 @@ static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
 		case CHIP_SIENNA_CICHLID:
 		case CHIP_IP_DISCOVERY:
 			nv_set_virt_ops(adev);
-			/* try send GPU_INIT_DATA request to host */
 			amdgpu_virt_request_init_data(adev);
 			break;
 		default: /* other chip doesn't support SRIOV */
@@ -1242,7 +1234,7 @@ static int amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device *adev, bo
 		mutex_lock(&virt->ras.ras_telemetry_mutex);
 		if (!virt->ops->req_ras_err_count(adev))
 			amdgpu_virt_cache_host_error_counts(adev,
-				virt->fw_reserve.ras_telemetry);
+				virt->xchg.ras_telemetry);
 		mutex_unlock(&virt->ras.ras_telemetry_mutex);
 	}
 
@@ -1354,7 +1346,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device *adev)
 	do {
 		if (!virt->ops->req_ras_cper_dump(adev, virt->ras.cper_rptr))
 			ret = amdgpu_virt_write_cpers_to_ring(
-				adev, virt->fw_reserve.ras_telemetry, &more);
+				adev, virt->xchg.ras_telemetry, &more);
 		else
 			ret = 0;
 	} while (more && !ret);
@@ -1465,7 +1457,7 @@ int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev, u64 addr, b
 		mutex_lock(&virt->ras.ras_telemetry_mutex);
 		if (!virt->ops->req_ras_chk_criti(adev, addr))
 			r = amdgpu_virt_cache_chk_criti_hit(
-				adev, virt->fw_reserve.ras_telemetry, hit);
+				adev, virt->xchg.ras_telemetry, hit);
 		mutex_unlock(&virt->ras.ras_telemetry_mutex);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 8bd471e541fc..e1cf6fe71e96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -121,15 +121,6 @@ struct amdgpu_virt_ops {
 			u32 req_code, u32 ptl_state, u32 fmt1, u32 fmt2);
 };
 
-/*
- * Firmware Reserve Frame buffer
- */
-struct amdgpu_virt_fw_reserve {
-	struct amd_sriov_msg_pf2vf_info_header *p_pf2vf;
-	struct amd_sriov_msg_vf2pf_info_header *p_vf2pf;
-	void *ras_telemetry;
-	unsigned int checksum_key;
-};
 
 /*
  * Legacy GIM header
@@ -288,11 +279,31 @@ struct amdgpu_virt_ras {
 
 DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
 
-struct amdgpu_virt_region {
+struct amdgpu_virt_xchg_region {
 	uint32_t offset;
 	uint32_t size_kb;
 };
 
+struct amdgpu_virt_xchg {
+	struct amdgpu_bo *bo;
+	uint32_t offset;
+	uint32_t size;
+	void *va;
+	u64 pa;
+	unsigned int checksum_key;
+
+
+	int req_init_data_ver;
+	struct amdgpu_virt_xchg_region header;
+	struct amdgpu_virt_xchg_region tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
+	bool dynamic;
+
+
+	struct amd_sriov_msg_pf2vf_info_header *p_pf2vf;
+	struct amd_sriov_msg_vf2pf_info_header *p_vf2pf;
+	void *ras_telemetry;
+};
+
 /* GPU virtualization */
 struct amdgpu_virt {
 	uint32_t			caps;
@@ -310,21 +321,15 @@ struct amdgpu_virt {
 	struct amdgpu_mm_table		mm_table;
 	const struct amdgpu_virt_ops	*ops;
 	struct amdgpu_vf_error_buffer	vf_errors;
-	struct amdgpu_virt_fw_reserve	fw_reserve;
+	struct amdgpu_virt_xchg		xchg;
 	struct amdgpu_virt_caps virt_caps;
 	uint32_t gim_feature;
 	uint32_t reg_access_mode;
-	int req_init_data_ver;
 	bool tdr_debug;
 	struct amdgpu_virt_ras_err_handler_data *virt_eh_data;
 	bool ras_init_done;
 	uint32_t reg_access;
 
-	/* dynamic(v2) critical regions */
-	struct amdgpu_virt_region init_data_header;
-	struct amdgpu_virt_region crit_regn;
-	struct amdgpu_virt_region crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
-	bool is_dynamic_crit_regn_enabled;
 
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
@@ -417,7 +422,7 @@ struct amdgpu_video_codec_info;
 ((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_CAPS)
 
 #define amdgpu_sriov_ras_telemetry_en(adev) \
-(((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_TELEMETRY) && (adev)->virt.fw_reserve.ras_telemetry)
+(((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_TELEMETRY) && (adev)->virt.xchg.ras_telemetry)
 
 #define amdgpu_sriov_ras_telemetry_block_en(adev, sriov_blk) \
 (amdgpu_sriov_ras_telemetry_en((adev)) && (adev)->virt.ras_telemetry_en_caps.all & BIT(sriov_blk))
@@ -478,14 +483,9 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
 bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev);
 void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
-void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
-void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
-void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
-
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
-int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
-	int data_id, uint8_t *binary, u32 *size);
+void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
@@ -527,4 +527,8 @@ bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev, uint64_t retired
 void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev);
 bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev, const struct eeprom_table_record *bps, int pages);
 int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev);
+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev, int data_id,
+				      uint8_t *binary, u32 *size);
+void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
+void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
index 7461ab07f6eb..e6e651efd0e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
@@ -34,7 +34,7 @@
 #define mmRCC_CONFIG_MEMSIZE    0xde3
 #define mmRCC_HW_DEBUG          0x10c01
 
-const char *amdgpu_virt_dynamic_crit_table_name[] = {
+const char *amdgpu_virt_table_name[] = {
 	"IP DISCOVERY",
 	"VBIOS IMG",
 	"RAS TELEMETRY",
@@ -44,7 +44,7 @@ const char *amdgpu_virt_dynamic_crit_table_name[] = {
 	"LAST",
 };
 
-static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
+static uint8_t amdgpu_virt_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
 {
 	uint32_t sum = 0;
 
@@ -59,7 +59,7 @@ static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t
 
 static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 {
-	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
+	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.xchg.p_pf2vf;
 	struct amdgim_pf2vf_info_v1 *pf2vf_v1;
 	struct amd_sriov_msg_pf2vf_info *pf2vf;
 
@@ -69,7 +69,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 	uint32_t i;
 	uint32_t tmp;
 
-	if (adev->virt.fw_reserve.p_pf2vf == NULL)
+	if (!adev->virt.xchg.p_pf2vf)
 		return -EINVAL;
 
 	if (pf2vf_info->size > 1024) {
@@ -82,8 +82,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		pf2vf_v1 = (struct amdgim_pf2vf_info_v1 *)pf2vf_info;
 		checksum = pf2vf_v1->checksum;
 		checkval = amd_sriov_msg_checksum(
-			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
-			adev->virt.fw_reserve.checksum_key, checksum);
+			adev->virt.xchg.p_pf2vf, pf2vf_info->size,
+			adev->virt.xchg.checksum_key, checksum);
 		if (checksum != checkval) {
 			dev_err(adev->dev,
 				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
@@ -98,7 +98,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		pf2vf = (struct amd_sriov_msg_pf2vf_info *)pf2vf_info;
 		checksum = pf2vf->checksum;
 		checkval = amd_sriov_msg_checksum(
-			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
+			adev->virt.xchg.p_pf2vf, pf2vf_info->size,
 			0, checksum);
 		if (checksum != checkval) {
 			dev_err(adev->dev,
@@ -161,9 +161,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
-	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
+	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.xchg.p_vf2pf;
 
-	if (adev->virt.fw_reserve.p_vf2pf == NULL)
+	if (!adev->virt.xchg.p_vf2pf)
 		return;
 
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_VCE,      adev->vce.fw_version);
@@ -196,9 +196,9 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
 
-	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
+	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.xchg.p_vf2pf;
 
-	if (adev->virt.fw_reserve.p_vf2pf == NULL)
+	if (!adev->virt.xchg.p_vf2pf)
 		return -EINVAL;
 
 	memset(vf2pf_info, 0, sizeof(struct amd_sriov_msg_vf2pf_info));
@@ -280,9 +280,9 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
 {
 	uint32_t dataexchange_offset =
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
 	uint32_t dataexchange_size =
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
 	uint64_t pos = 0;
 
 	dev_info(adev->dev,
@@ -316,8 +316,8 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	void *fw_va = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].cpu_ptr;
 	void *drv_va = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].cpu_ptr;
 
-	adev->virt.fw_reserve.p_pf2vf = NULL;
-	adev->virt.fw_reserve.p_vf2pf = NULL;
+	adev->virt.xchg.p_pf2vf = NULL;
+	adev->virt.xchg.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 	adev->virt.vf2pf_update_retry_cnt = 0;
 
@@ -331,9 +331,9 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 	} else if (adev->bios != NULL) {
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
-		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+		if (adev->virt.xchg.req_init_data_ver == GPU_CRIT_REGION_V2) {
 			pfvf_data =
-				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
+				kzalloc(adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
 					GFP_KERNEL);
 			if (!pfvf_data) {
 				dev_err(adev->dev, "Failed to allocate memory for pfvf_data\n");
@@ -343,7 +343,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 			if (amdgpu_virt_read_exchange_data_from_mem(adev, pfvf_data))
 				goto free_pfvf_data;
 
-			adev->virt.fw_reserve.p_pf2vf =
+			adev->virt.xchg.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
 
 			amdgpu_virt_read_pf2vf_data(adev);
@@ -351,9 +351,9 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 free_pfvf_data:
 			kfree(pfvf_data);
 			pfvf_data = NULL;
-			adev->virt.fw_reserve.p_pf2vf = NULL;
+			adev->virt.xchg.p_pf2vf = NULL;
 		} else {
-			adev->virt.fw_reserve.p_pf2vf =
+			adev->virt.xchg.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
 				(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
 
@@ -403,37 +403,37 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 
 	if (fw_va || drv_va) {
 		if (fw_va) {
-			if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
-				adev->virt.fw_reserve.p_pf2vf =
+			if (adev->virt.xchg.req_init_data_ver == GPU_CRIT_REGION_V2) {
+				adev->virt.xchg.p_pf2vf =
 					(struct amd_sriov_msg_pf2vf_info_header *)
 					(fw_va +
-					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
-				adev->virt.fw_reserve.p_vf2pf =
+					adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset);
+				adev->virt.xchg.p_vf2pf =
 					(struct amd_sriov_msg_vf2pf_info_header *)
 					(fw_va +
-					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
+					adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset +
 					(AMD_SRIOV_MSG_SIZE_KB << 10));
-				adev->virt.fw_reserve.ras_telemetry =
+				adev->virt.xchg.ras_telemetry =
 					(fw_va +
-					adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
+					adev->virt.xchg.tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset);
 			} else {
-				adev->virt.fw_reserve.p_pf2vf =
+				adev->virt.xchg.p_pf2vf =
 					(struct amd_sriov_msg_pf2vf_info_header *)
 					(fw_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-				adev->virt.fw_reserve.p_vf2pf =
+				adev->virt.xchg.p_vf2pf =
 					(struct amd_sriov_msg_vf2pf_info_header *)
 					(fw_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
-				adev->virt.fw_reserve.ras_telemetry =
+				adev->virt.xchg.ras_telemetry =
 					(fw_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 			}
 		} else if (drv_va) {
-			adev->virt.fw_reserve.p_pf2vf =
+			adev->virt.xchg.p_pf2vf =
 				(struct amd_sriov_msg_pf2vf_info_header *)
 				(drv_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
-			adev->virt.fw_reserve.p_vf2pf =
+			adev->virt.xchg.p_vf2pf =
 				(struct amd_sriov_msg_vf2pf_info_header *)
 				(drv_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
-			adev->virt.fw_reserve.ras_telemetry =
+			adev->virt.xchg.ras_telemetry =
 				(drv_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
 		}
 
@@ -441,8 +441,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 		amdgpu_virt_write_vf2pf_data(adev);
 
 		/* bad page handling for version 2 */
-		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
-			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
+		if (adev->virt.xchg.p_pf2vf->version == 2) {
+			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.xchg.p_pf2vf;
 
 			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
 				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
@@ -460,15 +460,15 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
-	u64 init_hdr_offset = adev->virt.init_data_header.offset;
-	u64 init_hdr_size = (u64)adev->virt.init_data_header.size_kb << 10; /* KB → bytes */
+	u64 init_hdr_offset = adev->virt.xchg.header.offset;
+	u64 init_hdr_size = (u64)adev->virt.xchg.header.size_kb << 10; /* KB → bytes */
 	u64 vram_size;
 	u64 end;
 	int r = 0;
 	uint8_t checksum = 0;
 
 	/* Skip below init if critical region version != v2 */
-	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
+	if (adev->virt.xchg.req_init_data_ver != GPU_CRIT_REGION_V2)
 		return 0;
 
 	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
@@ -502,7 +502,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	checksum = amdgpu_virt_crit_region_calc_checksum(
+	checksum = amdgpu_virt_calc_checksum(
 			(uint8_t *)&init_data_hdr->initdata_offset,
 			(uint8_t *)init_data_hdr +
 			sizeof(struct amd_sriov_msg_init_data_header));
@@ -513,11 +513,7 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	memset(&adev->virt.crit_regn, 0, sizeof(adev->virt.crit_regn));
-	memset(adev->virt.crit_regn_tbl, 0, sizeof(adev->virt.crit_regn_tbl));
-
-	adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
-	adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
+	memset(adev->virt.xchg.tbl, 0, sizeof(adev->virt.xchg.tbl));
 
 	/* Validation and initialization for each table entry */
 	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_IPD_TABLE_ID)) {
@@ -525,89 +521,92 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 				init_data_hdr->ip_discovery_size_in_kb >
 					(DISCOVERY_TMR_SIZE_SRIOV >> 10)) {
 			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID],
+				amdgpu_virt_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID],
 				init_data_hdr->ip_discovery_size_in_kb);
 			r = -EINVAL;
 			goto out;
 		}
 
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
 			init_data_hdr->ip_discovery_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
 			init_data_hdr->ip_discovery_size_in_kb;
 	}
 
 	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID)) {
 		if (!init_data_hdr->vbios_img_size_in_kb) {
 			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID],
+				amdgpu_virt_table_name[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID],
 				init_data_hdr->vbios_img_size_in_kb);
 			r = -EINVAL;
 			goto out;
 		}
 
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
 			init_data_hdr->vbios_img_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
 			init_data_hdr->vbios_img_size_in_kb;
 	}
 
 	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID)) {
 		if (!init_data_hdr->ras_tele_info_size_in_kb) {
 			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID],
+				amdgpu_virt_table_name[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID],
 				init_data_hdr->ras_tele_info_size_in_kb);
 			r = -EINVAL;
 			goto out;
 		}
 
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
 			init_data_hdr->ras_tele_info_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
 			init_data_hdr->ras_tele_info_size_in_kb;
 	}
 
 	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID)) {
 		if (!init_data_hdr->dataexchange_size_in_kb) {
 			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID],
+				amdgpu_virt_table_name[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID],
 				init_data_hdr->dataexchange_size_in_kb);
 			r = -EINVAL;
 			goto out;
 		}
 
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
 			init_data_hdr->dataexchange_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
 			init_data_hdr->dataexchange_size_in_kb;
 	}
 
 	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID)) {
 		if (!init_data_hdr->bad_page_size_in_kb) {
 			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
-				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID],
+				amdgpu_virt_table_name[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID],
 				init_data_hdr->bad_page_size_in_kb);
 			r = -EINVAL;
 			goto out;
 		}
 
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
 			init_data_hdr->bad_page_info_offset;
-		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
+		adev->virt.xchg.tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
 			init_data_hdr->bad_page_size_in_kb;
 	}
 
+	adev->virt.xchg.offset = init_data_hdr->initdata_offset;
+	adev->virt.xchg.size = init_data_hdr->initdata_size_in_kb << 10;
+
 	/* reserved memory starts from crit region base offset with the size of 5MB */
 	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
-				  adev->virt.crit_regn.offset,
-				  adev->virt.crit_regn.size_kb << 10, true);
+				  adev->virt.xchg.offset,
+				  adev->virt.xchg.size, true);
 	dev_info(adev->dev,
 		"critical region v%d requested to reserve memory start at %08llx with %llu KB.\n",
 			init_data_hdr->version,
 			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset,
 			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >> 10);
 
-	adev->virt.is_dynamic_crit_regn_enabled = true;
+	adev->virt.xchg.dynamic = true;
 
 out:
 	kfree(init_data_hdr);
@@ -626,8 +625,8 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
 		return -EINVAL;
 
-	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
-	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
+	data_offset = adev->virt.xchg.tbl[data_table_id].offset;
+	data_size = adev->virt.xchg.tbl[data_table_id].size_kb << 10;
 
 	/* Validate on input params */
 	if (!binary || !size || *size < (uint64_t)data_size)
@@ -640,7 +639,7 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 
 	dev_dbg(adev->dev,
 		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
-		amdgpu_virt_dynamic_crit_table_name[data_id], data_offset, data_size);
+		amdgpu_virt_table_name[data_id], data_offset, data_size);
 
 	return 0;
 }
@@ -653,13 +652,13 @@ int amdgpu_virt_get_uniras_ras_caps(struct amdgpu_device *adev,
 	if (!adev || !caps)
 		return -EINVAL;
 
-	if (!adev->virt.fw_reserve.p_pf2vf)
+	if (!adev->virt.xchg.p_pf2vf)
 		return -EINVAL;
 
-	if (adev->virt.fw_reserve.p_pf2vf->version != AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER)
+	if (adev->virt.xchg.p_pf2vf->version != AMD_SRIOV_MSG_FW_VRAM_PF2VF_VER)
 		return -EINVAL;
 
-	pf2vf_msg = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
+	pf2vf_msg = (struct amd_sriov_msg_pf2vf_info *)adev->virt.xchg.p_pf2vf;
 
 	if (pf2vf_msg->header.size > (AMD_SRIOV_MSG_SIZE_KB << 10) ||
 	    pf2vf_msg->header.size <
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index fec08f235b92..45cba3bde580 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -178,18 +178,14 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 		}
 		/* Retrieve checksum from mailbox2 */
 		if (req == IDH_REQ_GPU_INIT_ACCESS || req == IDH_REQ_GPU_RESET_ACCESS) {
-			adev->virt.fw_reserve.checksum_key =
+			adev->virt.xchg.checksum_key =
 				RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
 					mmBIF_BX_PF0_MAILBOX_MSGBUF_RCV_DW2));
 		}
 	} else if (req == IDH_REQ_GPU_INIT_DATA){
 		/* Dummy REQ_GPU_INIT_DATA handling */
 		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
-		/*
-		 * AI uses the GPU_CRIT_REGION_V1 layout in practice, so fix the
-		 * dummy version value to match the actual init-data format.
-		 */
-		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
+		adev->virt.xchg.req_init_data_ver = GPU_CRIT_REGION_V1;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index eb537b2ae685..89ee81238d22 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -231,21 +231,19 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 				dev_err(adev->dev, "Doesn't get msg:%d from pf, error=%d\n", event, r);
 				goto out;
 			} else /* host doesn't support REQ_GPU_INIT_DATA handshake */
-				adev->virt.req_init_data_ver = 0;
+				adev->virt.xchg.req_init_data_ver = 0;
 		} else {
 			if (req == IDH_REQ_GPU_INIT_DATA) {
 				switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1)) {
 				case GPU_CRIT_REGION_V2:
-					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V2;
-					adev->virt.init_data_header.offset =
-						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
-					adev->virt.init_data_header.size_kb =
-						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
+					adev->virt.xchg.req_init_data_ver = GPU_CRIT_REGION_V2;
+					adev->virt.xchg.header.offset = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
+					adev->virt.xchg.header.size_kb = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
 					break;
 				default:
-					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
-					adev->virt.init_data_header.offset = -1;
-					adev->virt.init_data_header.size_kb = 0;
+					adev->virt.xchg.req_init_data_ver = GPU_CRIT_REGION_V1;
+					adev->virt.xchg.header.offset = -1;
+					adev->virt.xchg.header.size_kb = 0;
 					break;
 				}
 			}
@@ -253,7 +251,7 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 
 		/* Retrieve checksum from mailbox2 */
 		if (req == IDH_REQ_GPU_INIT_ACCESS || req == IDH_REQ_GPU_RESET_ACCESS) {
-			adev->virt.fw_reserve.checksum_key =
+			adev->virt.xchg.checksum_key =
 				RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
 		}
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 1e83cb5064ff..3e37740aedb4 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -41,23 +41,23 @@ static int amdgpu_virt_ras_get_cmd_shared_mem(struct ras_core_context *ras_core,
 	uint64_t fw_vram_usage_start_offset = 0;
 	uint64_t ras_telemetry_offset = 0;
 
-	if (!adev->virt.fw_reserve.ras_telemetry)
+	if (!adev->virt.xchg.ras_telemetry)
 		return -EINVAL;
 
-	if (fw_va && fw_va <= adev->virt.fw_reserve.ras_telemetry) {
+	if (fw_va && fw_va <= adev->virt.xchg.ras_telemetry) {
 		fw_vram_usage_start_offset = adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset;
-		ras_telemetry_offset = (uintptr_t)adev->virt.fw_reserve.ras_telemetry -
+		ras_telemetry_offset = (uintptr_t)adev->virt.xchg.ras_telemetry -
 				(uintptr_t)fw_va;
-	} else if (drv_va && drv_va <= adev->virt.fw_reserve.ras_telemetry) {
+	} else if (drv_va && drv_va <= adev->virt.xchg.ras_telemetry) {
 		fw_vram_usage_start_offset = adev->mman.resv_region[AMDGPU_RESV_DRV_VRAM_USAGE].offset;
-		ras_telemetry_offset = (uintptr_t)adev->virt.fw_reserve.ras_telemetry -
+		ras_telemetry_offset = (uintptr_t)adev->virt.xchg.ras_telemetry -
 				(uintptr_t)drv_va;
 	} else {
 		return -EINVAL;
 	}
 
 	ras_telemetry_cpu =
-		(struct amdsriov_ras_telemetry *)adev->virt.fw_reserve.ras_telemetry;
+		(struct amdsriov_ras_telemetry *)adev->virt.xchg.ras_telemetry;
 	ras_telemetry_gpu =
 		(struct amdsriov_ras_telemetry *)(uintptr_t)(fw_vram_usage_start_offset +
 				ras_telemetry_offset);
-- 
2.34.1

