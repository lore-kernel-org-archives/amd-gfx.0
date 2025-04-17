Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A618C369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 08:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB4C10E192;
	Thu, 17 Apr 2025 08:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kopv/jrx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1945A10E192
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 08:58:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwSW5tSp06wAgWwPguJLkFiZ/LTnTmGHXr7sEz0SJBX/+3n0SwJmxzdTZcOx1GXAX+ztHrj5N3ac1BgAWCFbdIYWf3Iat8mZuzu2WtCMPUy66ddbI2iGcIV6ZoxRIu42S+7O7XZsVenwcuRbbSQC3lVxNa81+WCOiRa2eycMGkbSpIWGPlBuYx4KwTGGwrdbSAmHLioYLJ/pqaPdkkDPh+409YcfgpLuI9FVgBiktG7/MzGCancVkXf2Dxf3qtuUA/2qJoFgz+oH2eB3s8ZkVV4R98zSzraJJD232wVaKoLrcntlMdrHm/wFD1mwclCE097PwtkC+KiDEkeFU1ryLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPpzCfOniH0q63XV1kLx8rn5jteUpXftw5TjxicmQho=;
 b=XU8nEG7M+TsGWvkdV8YGcmccsWHKIDoaE6GohWRA0WmVUl5JVkZGzW8p45hsuMgAWa/7enSuUpeXauLpMNT3a+wHpNHwddfVvcrWTmVSSRH3Lnw6X8PSvJcxErO6KVlH+vCZTeqp5j1hpAPI/Lnt/zYscKkUjnyLVtlIF/8ErkqJKhJs0X4PuKhfLIWb0bk/MYkgDIFz7637MStHKtX34LgdfKRSi1+n4vYEKVGr+acaS0ft7JONSDS0ztfrAuzAljlqBdhFVofFGk0OOiabHOBqIP+jboxThmrdXRdriBVe7RIcHLfbUhzBZFOtiBpJttyeuFzJPH+Q+RhchxfXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPpzCfOniH0q63XV1kLx8rn5jteUpXftw5TjxicmQho=;
 b=kopv/jrxuavb2koFBVLo/TyHRtNjJuXWGXffUJfA5JfojAUGyqCDgtVknU0ZXqKEFhtR5EDxM83KQtsd230o6uRGNx3vPs2dpz5Db1BqYVMhhLlIR2v4hKaZTGkcHkVsSMSBpYcrpxwLcH/F2QUL4exKK2CeOoxneNLzQ1GTU2g=
Received: from DM6PR10CA0024.namprd10.prod.outlook.com (2603:10b6:5:60::37) by
 DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 08:58:47 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::56) by DM6PR10CA0024.outlook.office365.com
 (2603:10b6:5:60::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 08:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 08:58:46 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 03:58:45 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: add get_retire_flip_bits for UMC
Date: Thu, 17 Apr 2025 16:58:29 +0800
Message-ID: <20250417085832.36455-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417085832.36455-1-tao.zhou1@amd.com>
References: <20250417085832.36455-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e52124e-5d1b-415f-6291-08dd7d8e1064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Brw3cA2ql8j3FqMF6LJYraAyT7bWxYAT6XGbo76wLWRiL7TT1d/6vDEZHoCn?=
 =?us-ascii?Q?c+xxeR6tbvtxjasSHd6rAFSRo1MpLx2qAJAIBnEX42tOusy+kF6rv5xpwU8D?=
 =?us-ascii?Q?8AhO5McsrzPVnrcAru4WJ/XOUtSYFtW9ls8LfYT63IessbLkQxTKukL8VntQ?=
 =?us-ascii?Q?Ipyc9LUA724RrsVHXISLojpmDsR/M5OKQS4VD5i3jlbP3CsHCDcUHmv6k7zG?=
 =?us-ascii?Q?rFUTUtvnPK2kk//ro7tpPdEju9CjuJWbvVx8o6XHw2AlBcCBOIlLlkBpuztU?=
 =?us-ascii?Q?68kiNCXv7D/Z8u9PMesYBt//8t5LFnSGG1MOnD8Nmkhg0BbakkwZtgmDaTVh?=
 =?us-ascii?Q?DIE69kFXtmbD33x2/qnanCcB6qRHRh/3zDH0hPFf9XQDLtwnYL8F2tloKJmO?=
 =?us-ascii?Q?aw/q1pYy5z2P2gvLxTAhEf2nSF1JfntKPVIeowjQ7ZM2PCFgsXwtSkxFbbuU?=
 =?us-ascii?Q?oEJq3HAuZKTyE4kpcEVgfm2EeVCWBEXWo7xXKYaTetqm10zANzl+azgqkqpD?=
 =?us-ascii?Q?jh0u1BbqTxP0uujZCgvlcEW7STDtRoTeXj2SqVTxF79LBnVCSqn7DWOq2Usy?=
 =?us-ascii?Q?ZbOzaNoYE1UwxKltGEXqZVkp1GDYA+FMyGD3K/R0NgtN6gkISMppneAXchWS?=
 =?us-ascii?Q?jEdY9B8nCfIliciZ0Xp5fZU97mJpZuCNsJH03bzUUFBXkTW7r3G+st29HFzM?=
 =?us-ascii?Q?3aH6zdVsrVJselFENC9StekPc5Dxx24go0qjhayBAk5gpzhzCLOvxbXRArdq?=
 =?us-ascii?Q?7q8KbUI37GLz6A/i2orv0P8r9g4JIBZ3sIgpKNR87vI0Verx3wHo7zufm+R7?=
 =?us-ascii?Q?nDMANSAXkfB5lzgxrB+db2FaffpzGvCgahW6pg/ocLJqK8yeUImLlmpTcWiJ?=
 =?us-ascii?Q?3aeMG+WyBy/1k/bIIRxB9pBmapNsbbYPx7LcIDWmMgc6NQxGzeKr65IvZHfW?=
 =?us-ascii?Q?yARHd06Jj0SHQhFbHt/oXxLKVpXqC23IHL7wLgx2xfZN4KQhSS+nCxq1jWzR?=
 =?us-ascii?Q?nokXjXOp4yyJ4i2AGi84pEjZ5OEMVV4QQOeFfSkVjYm8efix2uC8NRog8K01?=
 =?us-ascii?Q?xoZZmZ3WuaLNFqy5Y/j2tpkupjp5XBPoEsR2DGqELaVcdipkKMjDqc3NjUn5?=
 =?us-ascii?Q?35HnccCXwOC75JESvUdB0bwgRrgyw+ZqcJ4XCznWnY6l4XLVauBkwdbQcJes?=
 =?us-ascii?Q?l1nDzljtjtlR+J1SSkCCsDgxNK9/Lk9kmXLt4ZhoDVcKMr7HssoROXDC11Fz?=
 =?us-ascii?Q?UPMGy96DOK84jBBjsjlHXgw9OzWZl2ZXAfL0mobhBRwWWoALniAuFFPs8u7f?=
 =?us-ascii?Q?RnY6hkVf61nvcYxLOtCz4b6lk1rttZhDUc5I6GpvrC/jrY3fQ9uJuJG6Ryac?=
 =?us-ascii?Q?O5/OPKDUkgAw8franyzOuCfhUy8HSeoHtBbg1T4fTTCTBIhuNlbv4gSu7AOz?=
 =?us-ascii?Q?0p7gT+9GgX01zt2VtaF4jp8FseLcmZ1yisr1LTAXaRy25didUFS19J5cYQYW?=
 =?us-ascii?Q?CqM36Po0jduh/HgO2GurpHQCKwJx9dQlXoBy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:58:46.9539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e52124e-5d1b-415f-6291-08dd7d8e1064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
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

Add the general interface to get flip bits for RAS bad page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 32a8cd64d29a..a5a853894ab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3474,6 +3474,10 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
 		control->ras_num_pa_recs = control->ras_num_recs;
 
+	if (adev->umc.ras &&
+	    adev->umc.ras->get_retire_flip_bits)
+		adev->umc.ras->get_retire_flip_bits(adev);
+
 	if (control->ras_num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 857693bcd8d4..78a8b8654573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -78,6 +78,18 @@
 #define UMC_NPS_SHIFT 40
 #define UMC_NPS_MASK 0xffULL
 
+/* three column bits and one row bit in MCA address flip
+ * in bad page retirement
+ */
+#define RETIRE_FLIP_BITS_NUM 4
+
+struct amdgpu_umc_flip_bits {
+	uint32_t flip_bits_in_pa[RETIRE_FLIP_BITS_NUM];
+	uint32_t flip_row_bit;
+	uint32_t r13_in_pa;
+	uint32_t bit_num;
+};
+
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
 
@@ -100,6 +112,7 @@ struct amdgpu_umc_ras {
 			bool dump_addr);
 	uint32_t (*get_die_id_from_pa)(struct amdgpu_device *adev,
 			uint64_t mca_addr, uint64_t retired_page);
+	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
@@ -130,6 +143,8 @@ struct amdgpu_umc {
 
 	/* active mask for umc node instance */
 	unsigned long active_mask;
+
+	struct amdgpu_umc_flip_bits flip_bits;
 };
 
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);
-- 
2.34.1

