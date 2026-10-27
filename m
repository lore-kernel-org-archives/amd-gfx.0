Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B01606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C+5N71rA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1153610F466;
	Tue, 27 Oct 2026 12:56:59 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8D310F474
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0NPTAMEUjHiuROqTaJhSirfWSf+aMjT3Y5lWdMIdi/BmWhNCcPLvnq+yFhHci/8usp+dIqL2LE/XoDB/+AKPSmRH+Jk0QHNONgQQ1enr87LVhKL2KpY50TuPBZ+cHidc0k72YtiUMHpDMl6dPEwMr+GWdSwkIWXILQ3cdt5VmRe2PI7KNVnI6xYfStjtbi86gUicnialmP4Ytu03QE/xLtIXEYC4urIkiWc9ixAeCXgl2FMrEK+swTvnT7KlAnZV9SwLP5Wl5IxydppwBaabS22mXoL2nkM3jZhfpixJKXRuV1MbRnFMY7s6+/Pd7au9+JxeSC0r+zBy43NfMEp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nbp6f6RcyDkBfk82MHnxAqQ8DMy6EqpgAnwCDDmymBw=;
 b=Ur5thyvuK43o8GXJk9lrrzYwfOvSSSXK5CZMIeaHmuq1QeLaEjXLivOzpdR92RehKb+zbWZhFEDh39Ex6Ag7QgpuoaBjthqVxvkGho96N8GczGdiUrhFwLWlxSV0ujPCQT0eHE+MxRdH1yEURysXaEprAwZo6bR8mHptunkWwU98wfdQ32JJHUNUW+axm3OuJ84hhGl1QVGcsrY+FMkp2talPAgF+yzz4D9HARSnILXJySbZwNm5vxZcXwkQcQNwjWjcpkPxRkEq26vQok2SEIjv2cU2AXyYKT/0moNch8GJLTPZQfL8aD3+NA0uuo1P53TxnYy2usScNBGl3V83og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbp6f6RcyDkBfk82MHnxAqQ8DMy6EqpgAnwCDDmymBw=;
 b=C+5N71rAdXKLu7nc1NQHVDt7xII7xgSOM9wwKCivhN7LmWt7lYk0gchRxgCOfmwIQWTKfSSL3ysFzGA5hRx3nWqu8DjeklBqqlS0Td+wvdAanLEynKOY4VU/RQLHaI7ekM2GwvybNNrAXbaLr2Tvu12ydp/YGUcCTie8Xt8COcU=
Received: from PH8P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::9)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:56:44 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::d) by PH8P220CA0025.outlook.office365.com
 (2603:10b6:510:348::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 12:56:44 +0000
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
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 12:56:43 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 07:56:40 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: Store and apply PF/VF exchange region base
 offset
Date: Tue, 27 Oct 2026 08:56:09 -0400
Message-ID: <20261027125613.6549-4-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027125613.6549-1-victor.skvortsov@amd.com>
References: <20261027125613.6549-1-victor.skvortsov@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1998fd-93e3-4995-f17c-08df3429c09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: Af7aOeD2jjjWBWqtv+zjB7f5zFanlX8D95JoPQpjJFXUiMzAIvZyfmsPhfz/nctW2fAU9zvd8DFI/ZaPCKJqgShrSxjjd833h9eJuDzkkSkB+JpeutlzDbpfAlE9hSq8r4xURk1/RnyFp2IoyLPcmEscvmu6TOT1nkpEEhnZh+X3f8k+2m1ZtqR9oF/Zjy3E6p906sHX3ePuO4M5jq1UpczI1lTt2jCm/gl25KnRu/2f45pCw7qtjW4s4rn12wDwT9CczWrL1lVCQ4Mb2tThfmajEck8Z0IAkVVVg2GwSHwCBWS+glUsDZs4qOFO8++BGQxQk9LmdBTVWDfAOWT81pHk1G6F7tKOZNJLFn1gEA5y8Oc12+tfU+whEIkHibo82nMbF0N2zft+dG2cRgi3YrjSxIReqiewCzQdgeMYSVTW6jTlhIKDRl66XXziyUhTDqpU8pwxbdHbjZMUC+Bxfs8BvEYXMEZn7K4MtIQtZmIpDz7jTmL3zJZdsZc1tEAMnYPGa8bnnCBLeh4uE0KgefDlbAoG6GrAY3sIWTa5MriZYV+7pHcSDdW/BRvtLKKLn23vGnmJYiBVs3rSG4LpJQ+yQt/HmthlIJdwLQU5pApafnHsHLHxXwyHX9pLXj+nIk9axKbsUQCt8sumP3N57yCzILGc9kLIhwtlf43ukfAlzlctwRrmdxahOGJKKo5H7FzCdfzjtAkw9uMIYJLOjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XaVrX+BsNrMSVVnAVHFKPzoyyiZcYYneomQKuRbCeND9ut7XuMZRyaZIE+D5FFdePN1Cr6zAd5hYXgbL0iAstmg/yyuezu5O/3/lE8cWrJKaECU8McZXnUAFsqrfXCVIiRh0tCz+01qx6Uav6shLcWxoRgx7jZ4ijz+WFbAo7v4h3TrlrqxB4D4NiS0j9g80PtCVZ/kqV0xxWeouCgXye9+P3q3CPXYVKUQ7sGGpoOgJ/Fqzu9+VTcHPT9h0TTML+CuSbpsHhHGyBQV3Pgi7eg7R3TNx1eOazzsNEmczZRtQrlhJnnV0wJZyO0NdwFIWf6EIb+VDcc+QzgjNX8Xfbu+4psEvFIe3Ovgd6IxIVb84aJfZLym2QXqrmt5uBYWS+pMGrzHr17VDk3QI5XK3RTrc5O13SHwvFECPwfTI56HzfwFxLJA7Hyata9XU4pux
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:56:43.8956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1998fd-93e3-4995-f17c-08df3429c09e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

initdata_offset represents the base offset for the entire
exchange region. Typically this value is 0x0, however
in the case it is not, it must be taken into account when
calling amdgpu_device_vram_access

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c | 28 ++++++++++++++++---
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 407972a43a7f..9fb4bea31a2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -345,9 +345,9 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev)) {
 		if (!adev->virt.xchg.dynamic)
 			goto out;
-		adev->discovery.offset = adev->virt.xchg.tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
-		adev->discovery.size = adev->virt.xchg.tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
-		if (!adev->discovery.size)
+		if (amdgpu_virt_xchg_tbl_info(adev, AMD_SRIOV_MSG_IPD_TABLE_ID,
+					      &adev->discovery.offset,
+					      &adev->discovery.size))
 			return -EINVAL;
 	} else {
 		if (adev->discovery.offset) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 1d5b74be5e08..15d63b53285c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -525,6 +525,9 @@ bool amdgpu_virt_ras_check_bad_page(struct amdgpu_device *adev, uint64_t retired
 void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev);
 bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev, const struct eeprom_table_record *bps, int pages);
 int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev);
+int amdgpu_virt_xchg_tbl_info(struct amdgpu_device *adev,
+			       enum amd_sriov_msg_table_id_enum tbl_id,
+			       uint64_t *offset, uint32_t *size);
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev, int data_id,
 				      uint8_t *binary, u32 *size);
 void amdgpu_virt_read_pf2vf_data_early(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
index 55f20d99feea..12d901e5c0ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt_xchg.c
@@ -616,15 +616,15 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	int data_id, uint8_t *binary, u32 *size)
 {
-	uint32_t data_offset = 0;
+	uint64_t data_offset = 0;
 	uint32_t data_size = 0;
 	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
 
 	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
 		return -EINVAL;
 
-	data_offset = adev->virt.xchg.tbl[data_table_id].offset;
-	data_size = adev->virt.xchg.tbl[data_table_id].size_kb << 10;
+	if (amdgpu_virt_xchg_tbl_info(adev, data_table_id, &data_offset, &data_size))
+		return -EINVAL;
 
 	if (!binary || !size || *size < (uint64_t)data_size)
 		return -EINVAL;
@@ -638,7 +638,7 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	*size = (uint64_t)data_size;
 
 	dev_dbg(adev->dev,
-		"Got %s info from exchange table at offset 0x%x with size of 0x%x bytes.\n",
+		"Got %s info from exchange table at offset 0x%llx with size of 0x%x bytes.\n",
 		amdgpu_virt_table_name[data_id], data_offset, data_size);
 
 	return 0;
@@ -679,3 +679,23 @@ int amdgpu_virt_get_uniras_ras_caps(struct amdgpu_device *adev,
 	return 0;
 }
 
+
+int amdgpu_virt_xchg_tbl_info(struct amdgpu_device *adev,
+			       enum amd_sriov_msg_table_id_enum tbl_id,
+			       uint64_t *offset, uint32_t *size)
+{
+	uint32_t sz;
+
+	if (tbl_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
+		return -EINVAL;
+
+	sz = adev->virt.xchg.tbl[tbl_id].size_kb << 10;
+
+	if (!sz)
+		return -EINVAL;
+
+	*offset = adev->virt.xchg.offset + adev->virt.xchg.tbl[tbl_id].offset;
+	*size = sz;
+
+	return 0;
+}
-- 
2.34.1

