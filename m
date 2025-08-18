Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59435CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 14:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE04710E461;
	Mon, 18 Aug 2025 14:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CgbCoGYV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA8910E461
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 14:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPzbobptcgz4jgxjL8brsMtGc0d5pJ2SoHqW8xAvXPJktzd9Hw1i2UO30FbDTwaLqnMZv6/N6Ogt5v3Tb63ejhXSFaykJt3DmkWTd8BFOSlMPlkOCBRHDT4Oy1zrwZnui+YjLhTITPx24TTCRLEcfhK5x4DpVWkk+dEgVf30rMt9vDi/NfZ5RnlSxrsE1sY/w1YQqvsO9ZujlpisgDxxXASlNQ1pT2/4d15jqLv7Foel9fbS59xSIwHDNfBPiphmZFsH3Jqas+enS0PT3sAPaCS/vRtnlT5Fto+3rmAyEVPmAkZE9XUnvQlkUtHr87p7Vk4nXxrWfPxwti6Evmo+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3ZPQtzVszQL0D1M3sdFdKzzkVhCnHhGkJgZ8VVIXks=;
 b=mLtwMjI6aeo8ywFmpwUUMwbhPbsNztlSO1bf0pzKw4E4VDu1DLxOoU2mv8e7JcRLb/71VkNZ2RWeKXAFJfpvXV8p5T+5Yau+FNmyeZzQet0meb8HfTGH+pAXi4WjZG3342nG9ch3NPjTzltIQokXll7bwUJ+OXdBxRtdnBfllceWypOsvG78Zo6hxLgQSatRZmlRd49AD2rK6TAwVwIgo0VdwRFsaiBSI2PwQYTjqfskyagdPVbQ1/RAiobl2qpPFRUsTq9Kw21mpIFF9oGaGuxSTcL/xvJsxjQqw3eZ+u5w23wNIJ9Q8iE6FfHl6UqO84b26IWfGJfbM1O2x4z28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3ZPQtzVszQL0D1M3sdFdKzzkVhCnHhGkJgZ8VVIXks=;
 b=CgbCoGYVPyx6aRAGJQ/Gd0PdSbuNpCX9LviZuAoCBrfNIjWk2OxIPwl/DMevNqZbHyOglelnjAgJMQZf+pjKC2VpMb21AY3nMGA6jX/6CJeJ0Taw1awRoVQoFGX9PmaCtLCXg4WjxDz8G1YRpEuCQuTyxuxaiQt4f6RZHFCLUyo=
Received: from MN2PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:c0::27)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:57:33 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::a2) by MN2PR05CA0014.outlook.office365.com
 (2603:10b6:208:c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 14:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 14:57:33 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 09:57:30 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>,
 Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/4 v5] drm/amdgpu: Add functions to get bank count
Date: Mon, 18 Aug 2025 22:57:16 +0800
Message-ID: <20250818145716.318606-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 85313177-83b9-4817-1efe-08ddde678fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JuzWLTnpUWynYmcN5g9G4MXaHJjR4W9Ie7urtamFZdnGYTKcJkGqGH0J8Pth?=
 =?us-ascii?Q?Hot7omBuIkCCJ/TVOEaUyR45tAyTZV+DbVFt2uS1jlHEwekqulPTdp6OQKk6?=
 =?us-ascii?Q?7iTima9AZug+4MfFRirVQzWbZe72Mh13qZCUGUSCk51ibtn8IJreHWnu5PE7?=
 =?us-ascii?Q?DxmbqXQt3B/nXV59Ot2WYXXRMnR9Mb/35w9Adb/ufwodNVAAlhi+q4uQeVxV?=
 =?us-ascii?Q?kdNiwAonbHMJF/G/EXGJnIGlO5j5fyH02JvwZhFFzeEbJzfofbeTpKo9Qj14?=
 =?us-ascii?Q?AysPdIO17wNuwmeRDAtr9Qr8Hhmrut02BEnjKcLDE0YxYleTv6l7/BBLy0T2?=
 =?us-ascii?Q?YJL8PMf1EjtAwSif+lnqfX8ntajeyuLgC+0ghVBmdiU1b22RqrCR+znwSMdq?=
 =?us-ascii?Q?letKZ+6616N/ifksGsaHam1SmfxHf81fu8yMZf6/eGWZWhXXLsl1UxBoQtHe?=
 =?us-ascii?Q?yaXSyRXTqyXSLY9IUWyFoso4/yDM4RfztQibOKh/TzkIxRMxsh7BxBqLt8Zz?=
 =?us-ascii?Q?IRG017cpZtIyiPI3af7xTIg4gefIj+4fRsAiAiRxpp8PrLaKPgzYSi1tu0jz?=
 =?us-ascii?Q?3jqwi0cXj6iLgJ84OG5m3dQ8Fa/uv6RoIg0xH3swzQYnyUsqmuMyoQX6XwUR?=
 =?us-ascii?Q?lTxlCBnCgHylbh/nOwHDsvJh1rjuHD9//hakfMiaEmXIsdKsiGH5cZndCrYf?=
 =?us-ascii?Q?LfzHp4hR+kjKCIfibmX1yDyQot/mEzJULwNMqdf02tiO8J7IkbcWIMOIZjup?=
 =?us-ascii?Q?3tnu5oA0DRU1vOh1rE3kL7RtSz+apkKn+jixDKfnVfO81P+IPCBin8fz1Qew?=
 =?us-ascii?Q?HFDwpTtgcsVtPjGTuat0nGRW03Q7mJMxpS7BtFu/qBE/Rko9lgLf9lQfH5yb?=
 =?us-ascii?Q?Mzum+jGIh1+qi+lNZ44R93fx4mq9DX8TvG6YXQi1FxQWzU7M5IpvuWw1lQYA?=
 =?us-ascii?Q?/FBB+AcOSx7+dohzoCcBKPPqJpHaF6cOtlTCHHDfT0swOKMDTa4K3ggPTY81?=
 =?us-ascii?Q?w3wVtck1wrgw8FSnz0rG3g9Vz6u6VPeDCPwvtTP92ebriS9jbWqHynHNuCRQ?=
 =?us-ascii?Q?MkLaUwBQS7V+fI3wSClBC3UCZ356mG1tJICM+DkKuXf/N69l7Ewb+WS+sO2X?=
 =?us-ascii?Q?xby7pyepgZsg8m/Rk3Sv4UaHhgz2g4tNNVIIE2znc+wEeJ4ZmLuMJFUtOerX?=
 =?us-ascii?Q?x5UvAbWFdgYXPMxExD7uuq2MhGbxUUZePI0+0XsiJUdsYvGheVHfxQ5WNW36?=
 =?us-ascii?Q?hUh8bwxuRGQYxryPwLpGzamB9KUvhra4FG7BFgQ/ivxpll7g18Tvh4lNjtJB?=
 =?us-ascii?Q?9SbwpYISf0w1C7jeiZMVNUST+nSYxA0M3l98sBY3RlfGD5mlIcRBXjPqY9Lv?=
 =?us-ascii?Q?6VDI3V6C++f0zq+absaxPFRvfc+4qgGDfV6cKd34vKtYnJZX8Lo/JkGZwfbb?=
 =?us-ascii?Q?mLFyQyDufHaxYmDE3qRi/SffALeGh0hWxCfsz71jR19BAZ7vZHpv3weIJxki?=
 =?us-ascii?Q?Bg+fNE49Uc+jSiY2sqcOUnNIrI5pxd3FVI+5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:57:33.2068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85313177-83b9-4817-1efe-08ddde678fd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
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

Add the amdgpu_aca_get_bank_count

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 090bf6cf1b91..6a17d1656e68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -480,6 +480,8 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 		goto err_release_banks;
 	}
 
+	atomic64_add(banks.nr_banks, &aca->bank_count);
+
 	ret = aca_dispatch_banks(&aca->mgr, &banks, type,
 				 handler, data);
 	if (ret)
@@ -766,6 +768,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
 	int ret;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	ret = aca_manager_init(&aca->mgr);
 	if (ret)
@@ -781,6 +784,7 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
 	aca_manager_fini(&aca->mgr);
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 }
 
 int amdgpu_aca_reset(struct amdgpu_device *adev)
@@ -788,6 +792,7 @@ int amdgpu_aca_reset(struct amdgpu_device *adev)
 	struct amdgpu_aca *aca = &adev->aca;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	return 0;
 }
@@ -865,6 +870,11 @@ int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en)
 	return smu_funcs->set_debug_mode(adev, en);
 }
 
+u64 amdgpu_aca_get_bank_count(struct amdgpu_device *adev)
+{
+	return atomic64_read(&adev->aca.bank_count);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 38c88897e1ec..9567fff286d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,6 +202,7 @@ struct amdgpu_aca {
 	const struct aca_smu_funcs *smu_funcs;
 	atomic_t ue_update_flag;
 	bool is_enabled;
+	atomic64_t bank_count;
 };
 
 struct aca_info {
@@ -225,6 +226,7 @@ void amdgpu_aca_remove_handle(struct aca_handle *handle);
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
 			      enum aca_error_type type, struct ras_err_data *err_data,
 			      struct ras_query_context *qctx);
+u64 amdgpu_aca_get_bank_count(struct amdgpu_device *adev);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
-- 
2.34.1

