Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040F8D1CDA1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 07:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979A710E0E5;
	Tue, 22 Oct 2024 07:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dAZ6/PBm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B3910E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Azo464tLwWnWeG+N64IUUTGdptBWhBbSO5kPSOeDK2JELf/mzg2kPDpKtbWUaFK6qOfccx2M7+jcit94hKzdQUiOmIzNHweiwCJXeCNfLeVDj7HUFHuRyA+FbHx+2FWtJWhFrrEyffuogBPokfxz74XHEzYuFN5Yl2l+uFL2srwsOIe3m95GOYoPfvuJA/XnrwjbQpJu/71WkbaADnuwdjg+lQ+9vzREbTfbLF0yPntVUkHsXOYeLsKgsTvmp2zpyP8SqEKWtBCDa3CXbCW+9HooTpLuPHAw0uyKjW2yHldDH+WrRCc+tGRIzJUqZnNrtwLvHsXrTr2ZvF/fJ0WtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZsH3qCPoqrWmMFmPnTE5GilQau8YCuOPjYolCZpio8=;
 b=CWnN1JjWqCbTSphL77O6GRTZm9CipzEX/dxQNckaGkl50zXpqUQLAcKSDP6+NhaJTOWMcgN9UKFPuAtIFQx2UaWCvDGa8B0kKftE3kqTYTcXsMV7HvkxNJOuZ9Wz7d/omgKZZ2hTquz1zRcW9QfFf9pos7urObgYGHLoNa69sgSpLnjY3Sjl/3w6KqcoMnVHV11GVdE5JZT+AtjIw/IJg2Htz4cx6mNtUm9+lqRDqVfXFhAsG4nrMSPEKjj9mgSayDkpfQbtj83I0cWHKMj4egl6+W71bn4dlPf5MOLDiVZyLHiUlYCWwAiGd5WJNpai+gAmewopJ5UpQHF+80CfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZsH3qCPoqrWmMFmPnTE5GilQau8YCuOPjYolCZpio8=;
 b=dAZ6/PBmXppQIUHAH88ZgWcihlJOI04IBnEQNflYvZdRANHRLejrQ8V9MERD4L3XJDluDgwc3cKz6GwF9pt7fVXYwjqOXKeQYmCsU35ngFe4QjFn2Q9ks61IItFNv0V11o9gTCyFU93vC7i8xMuBd8zzgHp3kHNYgqps/LwZp3g=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 07:18:57 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::ac) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 07:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.2 via Frontend Transport; Tue, 22 Oct 2024 07:18:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:18:54 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: avoid dummy_read_page overlapping mappings
Date: Tue, 22 Oct 2024 15:18:44 +0800
Message-ID: <20241022071844.1960835-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 923b02ed-fbcf-4789-780e-08dcf269caa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lc5y6BhRaG1jbE4gpNMtBwo2HKxEmLJUuBpkMOeEMDpSbIFsKaXsXkiV2XMQ?=
 =?us-ascii?Q?ghEV1CbktHX0j555kZzo22F9j/Y9Ugysiz8EvInAzlcc0tVoE0RC2/OmlK/s?=
 =?us-ascii?Q?Gq/FYiOX48awsZg2JNmgq7iMlv4SFokukbzbDOglaKCnqlzEMlo306wCuZsD?=
 =?us-ascii?Q?G5HuTcBRFux8bxUeUVm6W9/MRv78M0fDch9UhKJlsPt+qDZtGn8zJqkqvfsZ?=
 =?us-ascii?Q?sxiJ/igXq5XZhv8CYdzAqDq/gKFTMM0QHF6qi1SMoEaU3WfCrkPKBO78d92x?=
 =?us-ascii?Q?1HX090gx+jgSMHNdjFpr3hpQLXEDZAqlylU44UYCHIgN94yn3tIpYzH9NkEe?=
 =?us-ascii?Q?aWv6vDwSCX9lxv94CYW5BS54j09Bo37Wf4YRqHLGEQsvdrlhGoK4Iykj+/YB?=
 =?us-ascii?Q?90imEobWZdDSDdJGon8MQyE5WhNRyGRkzagUF5p/ymi7WWilurYl+EZzwXzs?=
 =?us-ascii?Q?7cc0kWXl+0fQDRdwoPCf8UN9KGfmJNz8wEsp9p+cI8zrl9TjWgbwjcPAoU1w?=
 =?us-ascii?Q?blDqrCtd29Un3dPzAFGpCO2MbMuTHXlbWSKt3tFOiDNHeHQFCyP96JRoazCS?=
 =?us-ascii?Q?c1jblvDO3ESwQQ+ixAC4QRe03i2rITmgZ0Fpikusr6IkSHyPf+WMP4dN6e3O?=
 =?us-ascii?Q?eRF3/PQb+PSrYgQQes/gOCgY3ksEzXsUZIiMYLPpK0ZYj8WrsrgptvB9BuIg?=
 =?us-ascii?Q?ngm9ftPPpxuVP5g5GCwJym+Da69XI/SzL5RHOLrYlt5d1TJAK2DQlFkY7/jj?=
 =?us-ascii?Q?Kf80QaObSM4DddBZgFZP0ZEm8FJujUXw+InJNtBNg1HnZ2NrU/NhPqNPWezc?=
 =?us-ascii?Q?Qgezqnh/lfltg3h/O10ptPGFjfWt/gi+jPei8dVIuUknmeA+yVs/6D/QQYU9?=
 =?us-ascii?Q?07k3Fq14grQcpjOURKw8SYS9vaWfqmRbmKlTqVfnIf6UeyqL+VTLFRhV2uma?=
 =?us-ascii?Q?IaxQ0y6W01ZtBFXt2U4+bCJG7wkQCVg1DkpHllVZmrdmlNBYcsK7PkV28LgG?=
 =?us-ascii?Q?mMKvhmZdvDqkG3bU8Isu7i0TaAYQxiXFTew3/vsG3m9m8X+n3K2bBW46d5b3?=
 =?us-ascii?Q?Qa3lMBbRiEA56gmmsP1RRBDXJlp+lzS+6ZTG6P1igQStzUZ1wOVOPTOxeT+K?=
 =?us-ascii?Q?9X9EMy7X6FvAh1KHPa4kjeKCnPDhgR4M7+y+KScNtIwGTQiilsUMacP00Zjn?=
 =?us-ascii?Q?27Qnw+KZLTSOg08YF6z8mUPPTRVKuzB/D9wAf0PxR9N6Qdo+Y+pHu5OlfAF6?=
 =?us-ascii?Q?q094ult31dbJeFQPslA5KkDn3zdMOx9vdrhwbBm0fy+NTpOZzQUBdBia36n5?=
 =?us-ascii?Q?q3I5h/P/Z9VpO6lVTSMZ7UTnk75LN9mg60i6j6pW71bYmo2rSZW/hbY0OUwf?=
 =?us-ascii?Q?bzPcmcGBCwI969vbeVTo5eKkSdFGUsWm1fOwqkwsbyBv2bg9Iw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:18:56.3756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923b02ed-fbcf-4789-780e-08dcf269caa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
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

In the A+A system, the dummy_read_page is mapped twice
during the device graphics memory software initialization.

To avoid page remapping, export the ttm_glob_use_count
to the driver for checking whether the same page has already
been mapped.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 3 ++-
 drivers/gpu/drm/ttm/ttm_device.c         | 7 +++----
 include/drm/ttm/ttm_device.h             | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 256b95232de5..81e567f63967 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -76,7 +76,8 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
 {
 	struct page *dummy_page = ttm_glob.dummy_read_page;
 
-	if (adev->dummy_page_addr)
+	if (adev->dummy_page_addr ||
+				ttm_glob.ttm_glob_use_count > 1)
 		return 0;
 	adev->dummy_page_addr = dma_map_page(&adev->pdev->dev, dummy_page, 0,
 					     PAGE_SIZE, DMA_BIDIRECTIONAL);
diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 434cf0258000..d99ccfa94c67 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -41,7 +41,6 @@
  * ttm_global_mutex - protecting the global state
  */
 static DEFINE_MUTEX(ttm_global_mutex);
-static unsigned ttm_glob_use_count;
 struct ttm_global ttm_glob;
 EXPORT_SYMBOL(ttm_glob);
 
@@ -52,7 +51,7 @@ static void ttm_global_release(void)
 	struct ttm_global *glob = &ttm_glob;
 
 	mutex_lock(&ttm_global_mutex);
-	if (--ttm_glob_use_count > 0)
+	if (--glob->ttm_glob_use_count > 0)
 		goto out;
 
 	ttm_pool_mgr_fini();
@@ -72,7 +71,7 @@ static int ttm_global_init(void)
 	int ret = 0;
 
 	mutex_lock(&ttm_global_mutex);
-	if (++ttm_glob_use_count > 1)
+	if (++glob->ttm_glob_use_count > 1)
 		goto out;
 
 	si_meminfo(&si);
@@ -118,7 +117,7 @@ static int ttm_global_init(void)
 	if (ret && ttm_debugfs_root)
 		debugfs_remove(ttm_debugfs_root);
 	if (ret)
-		--ttm_glob_use_count;
+		--glob->ttm_glob_use_count;
 	mutex_unlock(&ttm_global_mutex);
 	return ret;
 }
diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
index c22f30535c84..8afb380989e1 100644
--- a/include/drm/ttm/ttm_device.h
+++ b/include/drm/ttm/ttm_device.h
@@ -56,6 +56,11 @@ extern struct ttm_global {
 	 * @bo_count: Number of buffer objects allocated by devices.
 	 */
 	atomic_t bo_count;
+
+	/**
+	 * @ttm_glob_use_count: Number of ttm glob object referenced by devices.
+	 */
+	unsigned ttm_glob_use_count;
 } ttm_glob;
 
 struct ttm_device_funcs {
-- 
2.34.1

