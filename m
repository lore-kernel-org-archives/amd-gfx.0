Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D7FC624D3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB00410EA64;
	Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cKYlDtdj";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F3510E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ds6Tb3X/bRCNVRPfktQipG61YIVNOuZG/lmjwpl4dhCXWaylOjEuD/u21s/Hkp0yYcOniIFeyDPzH+rZ0AWXcggQW6B1QqqoKE7VfiB20MfxvVbpn3xe1LtjIw3JPok79u7RTYmOkU+F5qwyQgAE0XTHpkN4D2QHqjkGOKLo4BrgOXqyJrB49DmH+ZBLR0xiWvxgvaX/DU1YwdckDL3t78TxzjpdzP0fezx6XdE9utE3LJXzUn/hYjSmgd2Q/OOs+FfCxH4dar3OGPvn5N5zs7MyOOP9JxHcNBJgNgQZ1hwFlbtXr/YMt6hdBM77ZoDUA8L7RHS4X/cdE490Q3Ah2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJsjS+GF7E/rgGRHOL1umTYAIkHC4zJCiwTpvoTT5oI=;
 b=dgdLsjEP77CmWJuqwYi1fXNOTTmrn3rQfk7mk02PVTBLN5PON+N1FQEQ2LpwnJn7VGs8tgNelorj0JCQ0B0bBPWIrc9j+kP14mZuKZDCXa6k52mmortNFK9yR6cBk+WZRobKsofsDR86TKB//AF0Xzozx2Kr9GT7dpjQQczYgaf8tNnTbq6oyIUDb2Ls7QlMje661u3YXa9S124Dyv3i+in+j1rHSZ2nEUm7lTpolohtk+xCfEeScS/M5d+w+5AFPq/e/Inti01gq0BAmv4z/smXDthOz8fXb9lc78uU1VltK0h/xmIf70oVQZf20khvyxHCKjr5rmPEAGTCQwh/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJsjS+GF7E/rgGRHOL1umTYAIkHC4zJCiwTpvoTT5oI=;
 b=cKYlDtdjNVYtGj9I2NyWRhxOKLHMuyGy+ldgDKQeTDLsq6onwjxULaM53sbe1zR4fi+/XV4LgHL1keKJnWuAz3FOnfHsd+OTHHUbnI0/83ko0/jzbrMFTTAuWA22oG83lGV6h2eGPotGWJuagDCv4NfnkQvz+yVfDNOQKlW0Yak=
Received: from BN9PR03CA0129.namprd03.prod.outlook.com (2603:10b6:408:fe::14)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 18:28:48 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::7e) by BN9PR03CA0129.outlook.office365.com
 (2603:10b6:408:fe::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 32/95] drm/amdgpu: Add UALink NPA address layout helpers
Date: Mon, 31 Aug 2026 14:26:51 -0400
Message-ID: <20260831182754.1089811-33-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f96e58-452b-4cf2-5e7e-08df078db2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xMxfIdUX5QEXT4td0k2BR1+ZM8PJxhY7C7P4DJjZscaGaRAvZGIiClRBIaSHPCcW5vRIRSvTvsJtd5FmAL2uBw7SLptD3Dsb+GOg0N9U8cTMdBDUofJBE2TmFRUwlq5Y6y54qMANsNLWSYLoMjydzjYag/piwmM9B6JPfzjz0mdoFr2urztotabkRAeOccOHPR4PQZqzpGQ6a+NxN+wMdloO2UZGR5Spd3B/gYDtWecs9378tC2x/5NwVfz6OrwJ2rYjzjvyfPCicnOGT8Gjf0LbDye9xyTu8UMzgiyFeDoV8Z1JjZcGgTvrhyP7/GWocGXSw48Yv6G/LdcML3hSZNjnTMD0qS+MXWXXotpsJqPHiXXHIhWXaJzcH6kQGyOv+InTUruuT0JyjE4il98WB08Ckukd+/JU8u1oEetuI7UChUqL3QKGrOH88TgA5uO/YpOJsRNfGdzScNTa9wYsOrvncVH01mWr46R8uiwstSoRBgMzYesaPt14HDSX9tKJBd0mggNTMP4v9mDlpxxlEmzUhAXiN5SX/FTNEUEVZZ3LbV02NLfqEEh5y/FDp8tAzCqMEgTCmkAfCZ2+aUFNCmwWleYBdf1wSU8R299TPZpGDhr8Otq7fZ3ngAS65f2qgkzjsyNFvZfnLbFofvaAHZ83z01WVvpEge911zMgmWR64OOcS/Skn05cCkkzhG3BB/yf8sqwFFHCDnfOy0mnUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jCzTIAcMs6iwy5uynAc48iftuC/T2t0hwt+pqzpFnfqrqsRWUuEhrqgJs6XJYX0WeIEUydgzMCmyC8okLpCYObFZ/Agyei7lhCigqmaMzdqEuP/FWCjqyuARkOYEVTBukbyhiquWxRIDb65n7mWfI6iijsOIYXcI3fcKFYbuJRPEL0fB1JzChOOcfshGDByC6b2VY1k5pPh/Me0m8AbauN3VmPTMIOfhEbwsWJboqqP+K2scbEUmJInELsUQjMl2koFtshTnMWlD8adF0GA4ili8pXN5WIuihY6xGWVfLB9NZ1xyFCJEdDlksWMd2kOBPiCBjIdW9S2T3fuSKpBOVCw4VIXQmNyp6ziRhifYnJWUSyHFZbOK2un8xSW9AYSswGNzBfre65VAdNpPsSYdwLxd9/jyjRNbQeXsuCZT4s2gFTzZFFo/VQcPLCMk+NcE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:47.9622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f96e58-452b-4cf2-5e7e-08df078db2b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
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

From: Philip Yang <Philip.Yang@amd.com>

Add accessors for the local accelerator ID, addressing mode, and active
peer bitmap, plus a TLB flush helper for the NPA VM. Provide per-ring
size and byte offset helpers for both source-identification and
source-alias addressing modes.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d08f45d07fae9..ae3ae41c8f360 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1380,3 +1380,104 @@ struct amdgpu_ualink_remote {
 	struct amdgpu_ualink_peer	peer[AMDGPU_UALINK_ACCEL_MAX];
 };
 
+static inline struct amdgpu_ualink_remote *to_remote(struct amdgpu_device *adev)
+{
+	return adev->ualink.remote;
+}
+
+static inline u32 ualink_accel_id(struct amdgpu_device *adev)
+{
+	return adev->ualink.info->ppod.accel_id;
+}
+
+static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
+{
+	return adev->ualink.info->vpod.addr_mode;
+}
+
+/*
+ * address mode and NPA address for ring wptr, rptr, wb status, wb data
+ *
+ * source identification address mode
+ *
+ * we need to export different tail pointers for different remote GPU accel_id,
+ * hence we need to allocate a whole page for each remote GPU separately.
+ *
+ * rptr, wb data, status share the whole page with wptr.
+ *
+ *     1 page reserved NPA address for 1 active remote GPU, max 255 pages
+ *     starting address: wptr NPA address + accel_id * 4K
+ *     offset:
+ *         remote interrupt ring wptr 0
+ *         remote shootdown ring wptr 8
+ *         remote interrupt wb status 16
+ *         remote interrupt wb data   20
+ *         remote interrupt ring rptr 24
+ *         remote shootdown wb status 32
+ *         remote shootdown wb data   36
+ *         remote shootdown ring rptr 40
+ *
+ * source aliasing address mode
+ *
+ * wptr for different remote GPU can share same reserved 1 page NPA address page.
+ *
+ * to save reserved NPA address space, rptr, wb data, status for different
+ * remote GPU share same allocated 2 pages NPA address.
+ *
+ *     1 page reserved NPA address for wptr of all active remote GPUs
+ *     offset:
+ *         remote interrupt ring wptr accel_id * 16
+ *         remote shootdown ring wptr accel_id * 16 + 8
+ *
+ *     2 page allocated NPA address for rptr, writeback of all active remote GPUs
+ *     starting address: at accel_id * 32 for each remote GPU
+ *     offset:
+ *         remote interrupt wb status 0
+ *         remote interrupt wb data   4
+ *         remote interrupt ring rptr 8
+ *         remote shootdown wb status 16
+ *         remote shootdown wb data   20
+ *         remote shootdown ring rptr 24
+ */
+static inline u32 ualink_wptr_size(struct amdgpu_device *adev)
+{
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT)
+		return AMDGPU_GPU_PAGE_SIZE;
+	else
+		return 0;	/* wptr uses the ring buffer for itself */
+}
+
+static inline u32 ualink_wb_size(struct amdgpu_device *adev)
+{
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT)
+		return 0;	/* share same page with wptr */
+	else
+		return 2 * sizeof(struct amdgpu_ualink_wb);
+}
+
+static inline u32 ualink_wptr_offset(struct amdgpu_device *adev, u32 accel_id)
+{
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT)
+		return 0;	/* one separate page per GPU */
+	else
+		return accel_id * 2 * sizeof(u64);	/* two pointers per GPU */
+}
+
+static inline u32 ualink_tlb_wptr_offset(struct amdgpu_device *adev, u32 accel_id)
+{
+	return ualink_wptr_offset(adev, accel_id) + sizeof(u64);
+}
+
+static inline u32 ualink_wb_offset(struct amdgpu_device *adev, u32 accel_id)
+{
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT)
+		return 2 * sizeof(u64);	/* after two wptr pointers */
+	else
+		return accel_id * ualink_wb_size(adev);
+}
+
+static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
+{
+	return ualink_wb_offset(adev, accel_id) + sizeof(struct amdgpu_ualink_wb);
+}
+
-- 
2.55.0

