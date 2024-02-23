Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4C4C54E49
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 08:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EE7610EB30;
	Fri, 23 Feb 2024 08:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wy5UHjgW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6383E10EB2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 08:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvSG6xFdhN3X3imc05Sdu/ZmluAlwgEQ/NrUdiyfzbs0Tcx9ZFWWR6aVG2oa8UmQSJMV6Cg3KJjKEwxil0+N+waaXnt11XzNmEOVMnvvFJZeQx+2JTD2qdGHSw0QHAxSaUzLgofRNsV8HHHHAQtwyozsiftSd70U6o5b7R2XEKhxVdAC/BArmM7DIwWuZcxDT0TvHIxQNJcLjUiQrYIuerjS31BOHheORpeL/wrvQT/uexVtHa7AUA0hzipMBcwzNNj5x0o4wrytbgEd49y+NCsy1mraRYWbHukyuNSzuLqoNDbJbT+trN1aB56i479sm+7sjUiCFKW2++oiMFMHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YtGzvEqahWFg1rSfjyiGLtdxORiUbpO5/KNNwv0PRo=;
 b=aqFV1H9tZgoEFENoQRWkwGhPBg1nB7uD91NSWjva1wa1NWRIExlnkW8F6D1kjlJtFfpfYh+UXhSyp0T7DjkCLX6fbk13Gfa4/mptZ2EdUDYwQL/pzSW4+tReDsx3eulDzWljI+w0V1Nj2VIcJP672dUuHmA2psAFl521jYXjgwPl3bQJl79cPbdDGnCxBxcI8U8li8PC1RVjMsO0fi+0HFwyrenozQRl+ck8IZcN90RbUQDsVydtKH17LK8Q7AYaawovzuQMPaoewP+boOqytQkS1swe0nZQFuBYOlGiPnQMuiwfKnPCQjkRbBSb8qC2pNftS/mw+Pe1an2TkFR3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YtGzvEqahWFg1rSfjyiGLtdxORiUbpO5/KNNwv0PRo=;
 b=Wy5UHjgWjYdq7K+4AY3fYzIPuZ2uLbOzzJuLdhH5rwZTzIt4mMk+fIFzWI3+mdSFFcn/FxdDIKsQmFW03zVDzFTvFKtkm9cJAKZRXLVKqdtTvxSDLfv4mmmXWXn3eeRuz7y8JtKiAvVscl4IbXRM67Dvn5/wCKfjmrVMG9MhGVM=
Received: from SA9PR13CA0166.namprd13.prod.outlook.com (2603:10b6:806:28::21)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 08:24:06 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::d6) by SA9PR13CA0166.outlook.office365.com
 (2603:10b6:806:28::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25 via Frontend
 Transport; Fri, 23 Feb 2024 08:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 08:24:05 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 02:24:04 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/5] amd/amdkfd: get node id for query_utcl2_poison_status
Date: Fri, 23 Feb 2024 16:23:51 +0800
Message-ID: <20240223082352.323583-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223082352.323583-1-tao.zhou1@amd.com>
References: <20240223082352.323583-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9dd74d-96d9-4cef-7e70-08dc3448cced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3QwySFv/7I+PfC1tH9ThIKW3y0qFWtRhudIOTVJ+SHlYz4lqWkmQtUWIkHlY4+gdmtoRXM26gq8XJLvjq1+UZ7omBKlzzDaybUjIO9yc+rosoMflyo0mlPbzaK2gfGUMfuhRfb35vscl4GGcg3PunxUWRLi7xtIrssQalHN/p16gE1jajQ0LAZTE4aONrHRTrGcggdDfVRjOHtdC7P3v5XnhBUgcgHtzb5+L/n1etaVOxF+O75HdAq4/6NRgbmaJsaeed5BVGCDCnv1XI3AL8sw1BTktru599Xn3b2/eeRmnXEvjgLhDE6tFVcO/CoN8+NGIGtEHpq+Sv/idxS0lJ/Qp5kLDV+QM59/8PaDoKKpLHQRR8dQDT/ZrKXPWxvc0XPcirffV1atpOrsK/Qb8GLLo1terokwDsSsb7T3EYNZEGX/+pv8cazftPWUEyZNl5SF4IZ/EJwBJ+YQ0Vp/n8M8No2PCrTxdLDi1e+fvNFqu0SsczOCtr+EHQMEHitNagrQ3iJ5lUkJ7nYN1r68dQErXUBuJWEvTflfP51wAUehz+QmwOzzx9vrG0sFvXroYA7BjLGEPzJPPlH77LvESq8ST6HOXQOIzoDeZO8X1LpPbyt2XzLBDx/rxExIwnPZgFdL7BzE/DvrE67hDprRP3NDLHqaeo79rd/jeB7hqBo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 08:24:05.9392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9dd74d-96d9-4cef-7e70-08dc3448cced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
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

Obtain it from ring entry.

v2: replace node id with logical xcc id.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 14 ++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c  | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 9a06c6fb6605..a8e76287dde0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -367,10 +367,20 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
+		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
+		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
+		int xcc_id = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
-		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
-				amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
+		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
+			xcc_id = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
+				node_id);
+			if (xcc_id < 0)
+				xcc_id = 0;
+		}
+
+		if (client_id == SOC15_IH_CLIENTID_UTCL2 && !vmid_type &&
+		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev, xcc_id)) {
 			event_interrupt_poison_consumption(dev, pasid, client_id);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 91dd5e045b51..ff7392336795 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -413,10 +413,20 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
+		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
+		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
+		int xcc_id = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
-		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
-		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
+		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
+			xcc_id = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
+				node_id);
+			if (xcc_id < 0)
+				xcc_id = 0;
+		}
+
+		if (client_id == SOC15_IH_CLIENTID_UTCL2 && !vmid_type &&
+		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev, xcc_id)) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
 		}
-- 
2.34.1

