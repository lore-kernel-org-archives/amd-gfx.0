Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32620CD98F6
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B94F610E490;
	Mon, 22 Jun 2026 04:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nZleC5xV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 045B910E490
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liUeZKk8Q0MOTg4rUAzzajWp3KYLK01AuOGXcuf3F7FyhcAbESrmAOGBxMFSKrFAvFvL+nKCSXy4jsM7E/1GTjel/V+Sk0FsRqUjxYdpmmK4m93zXWjILF3pYFEBWnwOtR1wc47OVVr3czoAi5jgJp0Ko/fULNszyX/NErKFu/Wl2i9PLfJE4T0JPPaxamd3Hz8rhg7EE5lwJkNlHJ+5mlGC1Ce5pjvTfFlb6QXg1CAs+UlEMXtPLgurwS/PLfcHo8tCqxpXHCjLh7YCIDBjYZc4M9UjgWEl5TI1TcKzR7eZGOKAxSQOwwizH1+qChd33UqZ5hdRzN3eEmyVYkAIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm7jDeaQ2hh3hhYck+6ipLrH/VyL+r6zqT3HLDdc/dw=;
 b=j7Yv92KiUeX1x19zBzCZQh1PF5RT2EBlpUnn6UKqxsHHvOJ9QY3H5dyXqWIixGayO+nq1HTr4+yDNzL5pvs1wcsX2uV/t2YD1dzx5L6R4QWHMw9h5FB9c0rKBExKza+jvkwsbui3oTqMbqMdQ6UulwrDa6yD/cAE/D/1vfrCzjK+O/iQO5TJqJOkio1jqrCTI3t9HvDRuJ6ZW9cGgl6c2TD2hu5k2UWPidaZhmdRBqP2s9M/bYyn/LzAfr7qkt0Fimws1mnUpEtSrtn4glHWccBQWTnsHSGX5wl6383XtDWqEuR09W7NTUCaOn7+8orZG6tRvCmiFetVFOpVUzgLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm7jDeaQ2hh3hhYck+6ipLrH/VyL+r6zqT3HLDdc/dw=;
 b=nZleC5xVs/JVJV5qo1I8k4ANjJf/JpCbJF1qAhYA759US3u7vDp+VGnsh2Sjjk97SJTsVJGHW6Lx+eKEgwCQaqwB/W9tCiyd4YmqtHdcDSKY3EO2nUH+EOK+1IxlI3lKgHMPUDDvNYMU/X4ncYO/B6Qqc45YQ392nzFJJU8Nlx8=
Received: from MN2PR06CA0020.namprd06.prod.outlook.com (2603:10b6:208:23d::25)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:43:24 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::67) by MN2PR06CA0020.outlook.office365.com
 (2603:10b6:208:23d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 04:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:24 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:22 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 45/48] drm/amdgpu: retire legacy get_retire_flip_bits
 interface for UMC
Date: Mon, 22 Jun 2026 12:40:34 +0800
Message-ID: <d145693829aa4edaa63fca38e11d894550f81c8e.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 399394cb-1eb4-4c68-5a67-08ded018cb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: voqVTQJUFeyFsa+l9f+CK8EbeXJBZBkTVZVRdG4He3McBl2povkl4HuXMLot6VMobEOop/RrBy1FZR7Ir9Fo0JFJlPzOukrurfBL3VY2HRcuv1BaR2Yq5fhpL6avFQtLNTB5MeNeXHRMlY5RLbejjEQdG2WkezQgq2aS+6hUx4Sj4pwveEQSJV0UWDvs0FTpeLtaOAOyWMNOfGfK84bSlYnXBpoxTZONRgcoLpKnXVBznEgkbeDZBYBei6NMQGZfpt0P1TEqwKCbIurpsKf6sDMaWVuqNVNtYQgSYUBLpGdenEreiZzvEfVVVvnsKTa5xMB+3+r/SQffHKF20fcI4B/Hva8/DEtXsfi/9H/cqP0Oi4N4nA1GRwUsBho+YEhXnTUdCQeC7onRdyExgf5v84+M730SvIde/WWTPooBUK8aAUTleoofsrdeMvf9mFix8E0cCGpAcdVc8vWKMLuSKQSfhP++sqqhXQr2nTzVkTnSwwj5fmF85h9wFFDh2p7Sb6MsUIVDNXqvVLGxA3aFuqK/MTGa7Is4sYqGwg4Dr851+VtgjXgB5/JuYmUx3EwPAXhD+YLuAyFWFDXtgcyo/qUycMHMTn429GIzFppLiqqO8bsbgIbX71YRv5xKF2mnUApGoyF9zlDS+VE3dzQEayu+itrhiRDDG3j9FUk8Zng0O0ZaPeey8MKsbhUpJRzTfiMtKuqpQYhZwZND5zpB8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6tUATePY8IkpqjFGgmUYm1GT+lcebQDe3TAw1rsvcC0P/VndoPjC9GjtexImkdPde/wfAZHAvToP2PufHqD5TSeuWEQWFRWhwaYzO7ttgKZaS/EHbkgvjz/rbJbdvo3WozncHsAcb/jC9BuA5UMYfioTneafh+O2zc3yggmJOOXwks6iQKGcqVAs3UsYCOySTp///I2mfmlzSFMNWasiQJ8H0oOOYzXgnYI/41eFX5WvqsowrLCkFNcr01zkwB2YWFqWrnk/ZJAR66/Comr7hYMkCPY1bKH8lglQ/uuyv2CwfYmlP+Z6fcc9zIuLcrCl7kPyQtCMpJwXSGPnrG8vR02ZZrodW/fDYOLD74BCwlrcmaXuNDkDm9K52O3exfCbcDdj08GCPUDX2e6WltzaKsFauf91fzf6RsDXAiy22YjY1V4xyga9h06A2VIv0PJ8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:24.6632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 399394cb-1eb4-4c68-5a67-08ded018cb9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082
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

Remove the legacy general get_retire_flip_bits interface for UMC

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 15 ---------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e9583e8f0863..90f746ee90f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3202,10 +3202,6 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
 
-	if (adev->umc.ras &&
-	    adev->umc.ras->get_retire_flip_bits)
-		adev->umc.ras->get_retire_flip_bits(adev);
-
 	if (control->ras_num_recs && control->is_eeprom_valid) {
 		ret = amdgpu_ras_load_bad_pages(adev);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 46c42997d314..b2a3db60d231 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -77,18 +77,6 @@
 #define UMC_NPS_SHIFT 40
 #define UMC_NPS_MASK 0xffULL
 
-/* three column bits and one row bit in MCA address flip
- * in bad page retirement
- */
-#define RETIRE_FLIP_BITS_NUM 4
-
-struct amdgpu_umc_flip_bits {
-	uint32_t flip_bits_in_pa[RETIRE_FLIP_BITS_NUM];
-	uint32_t flip_row_bit;
-	uint32_t r13_in_pa;
-	uint32_t bit_num;
-};
-
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
 
@@ -100,7 +88,6 @@ struct amdgpu_umc_ras {
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
 					void *ras_error_status);
-	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_umc_funcs {
@@ -132,8 +119,6 @@ struct amdgpu_umc {
 	/* active mask for umc node instance */
 	unsigned long active_mask;
 
-	struct amdgpu_umc_flip_bits flip_bits;
-
 	unsigned long err_addr_cnt;
 };
 
-- 
2.34.1

