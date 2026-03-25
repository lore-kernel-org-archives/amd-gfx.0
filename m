Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515981093168
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CCA10E7F8;
	Wed, 25 Mar 2026 14:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VzqoM187";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6596B10E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWeVhC/1Hv9Fg7nAqUycVfUteh5/JJKZT6zMknGmmxSB7Tcf9TrPPFEt3TwrJTD3o4WC2RiggwmsqGgGnqqWUqZXOyQQwArNUFCMb1U/9QKYFLPKHhC2boCebsh+j47t9jyJLKgkKC0f2+vff7tx5Fo5uKLcguOSlP6KBsnmM9e9Q4TmdsGHXM3CZeRRkReW9MLz0skUDDLsyzqrbuh+xbW1feTWoHSD92QihADukynqk+aQODzGAMWQaBBlTd+dVst4/3KlokbCQLdTb13lpkERfrGCglOd2Ycn2Q0MVYzW6jYsJbc5Jxo1K+bUn/jFPh5lMMCpXvCX8yHV79Ha/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3iOdLcznUA2PFP63I20rxN0Cmjd1dHOqaV6qpodMUA=;
 b=A4bzzRWWzKj6HbgBnf1olqVBhK9Pyf6lMN/+WZYx8qizBtXwXjsPtZS1KUjQyVpZGEg06ZUxEhZIeQjF+Lji1YATRLSlt8OTMqJBfvsLhuN/myKqZ5Yn9BM8Qt6obzDj7AdoXZdAf8J8OSJksFDvqQWJv4Nmu3FnwX7sxN/x9AB6QsHJWuUzHu3bIY7DWm2T0I1aSJ0OS2Hyyo1Z5VyY/9WYXRPnDi7BMWy94VJc5hbUKoH2cSKHwcn3j9BhqRpSD2LAxjZg/xsA4YostlizIo3/uooWV4HScTc9nW+qOKEuXPQ0lAQQAZFg1EMBOdygrSglaR83DvN9whL+hndRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3iOdLcznUA2PFP63I20rxN0Cmjd1dHOqaV6qpodMUA=;
 b=VzqoM187Mh+7z8gS8vlWbUD+vQKOBT3K43l9PSPuvL/2dbleqjp4kb70/Y4Vs7sG8Qsl+ZzTnOpiQLmkDVvFZNJnRHLPRVGZnfFDIZnBzjSR6HC1AbFAtsvM+VzkNk9c5lF6kunqH3J2znNvuGqpVpJkodd7z85uMe0r/lyfUlY=
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 14:12:57 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:12:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:12:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 4/9] drm/amdgpu: Add stolen_reserved reserve-region
Date: Wed, 25 Mar 2026 19:42:21 +0530
Message-ID: <20260325141226.1173216-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325141226.1173216-1-lijo.lazar@amd.com>
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c49d57f-a931-4b40-ed72-08de8a789d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BmBRVUGIdKSSLdcRtxR4DCs5NCMRfaxm19DjxTwuJSmQq0mDuVfemodjAhjpYJkX5MGTb6/uvLXY9CkXpqfYR5Uz1krsArGT+exarRds2vGBKQq5Fk4VsEFafaDTrODLzS1xiO9go9o+xjqjJuiynjiqhkO+Xgbc0rNowzrDmG5sc9wAbnfSlioEmF8+tlWoFmsUX+T5Cy6XfhSsBhv/dUAP0AoaLly/qyH1uPDdXGgAkaaLxchYF42bDmpH5AwwqRmEPfP2HtYJoP1Y85Zi37bkioVvxsErTKt96IzpMYjmgK7xUA5Kce+Yzpl10/U97HSAtWFT7PHXSf2hzmRIULqNC2msAS8iOyqFRH33cxK94SR36fC7a3SJ1hn3FNxziOOdBzmcHuf53Y34IBH5krsipDA2mY3Xb3QxiQFXq3VJ3Vbh/qLSpIt1dCfZ0HUVFcamxP2IMICZ+CYApag2oxprHMevz4+1vNVH23beUkw9AhoMdSolK0BJA1rtSY43wZPpvCwk+j/cdjrA4+Lyc42L7iYCyyEujV4eUMzdZ47Fw/067G4M5qesIlw/0m5mhkg8Ouk4jtmc7IEzvMXMwv4UJmWlK3mox5wbzVu5EZICmaJ1sIl3OYQ+qbSQiK4Ss135FWol+OxZF3B5llvkOOk6c09bk8au7eORsnKwjTw9ZH/sjxZWk7peoYcm05c3XWxmY/2doUI6yWzhQeYkmQ45edg72LuciKRbqoUIi0GrdJfxfT7zSxI4VxVIKn0AXtdMS291DB9X/7QPjdl4oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WHH2uHj1Y66NevRjOWGtJ+BcePXcXo/D0mWk5hersqVVxXgH5FqZNQ+0TQYv3gZ/vVce5rt8pLkTZiK1AJ4tava0Yp2MovXcv+y+Snrai/enHktSwTVFlbzzpxAMtJMLFlvXWT4ke+Hc7T4p9/wa4Vi78QM10Omw26LPAP0c5A+QRwRUIcFKOVxPwTWv9pDAQxYIb/Fn/t7t8FMxYDBilrwUtwcXgQZWR6nXhTDaJ2HjgOmsVb70vz+l+/F/u/Ff/BySNuaKEEGP5MxyzyBdPCYUxxohAmbziFPoGVye3/V1f8uZP4uADKZUIteTR1y9H+uqp37T07ph98s9GhWU0+XmiefVRrc8thGoBNobCYPflFSj6a7IyFwhD2kwylIU2Q+pvwziLp9xTQlepAwKlLrC6MPfyquwUPcUPLkHTwbQ19IvLlHKFcZZeGEYF6ox
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:12:56.8903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c49d57f-a931-4b40-ed72-08de8a789d26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

Use reserve region helpers for initializing/reserving stolen_reserved region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  4 ----
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 61e8d71dfed5..2bbed5fe5121 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1040,9 +1040,6 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	 * Some ASICs need to reserve a region of video memory to avoid access
 	 * from driver
 	 */
-	adev->mman.stolen_reserved_offset = 0;
-	adev->mman.stolen_reserved_size = 0;
-
 	/*
 	 * TODO:
 	 * Currently there is a bug where some memory client outside
@@ -1059,8 +1056,8 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		 */
 #ifdef CONFIG_X86
 		if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
-			adev->mman.stolen_reserved_offset = 0x500000;
-			adev->mman.stolen_reserved_size = 0x200000;
+			amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_RESERVED,
+						  0x500000, 0x200000, false);
 		}
 #endif
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3c1c4548d280..835f140bfed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2221,11 +2221,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		r = amdgpu_bo_create_kernel_at(adev,
-					       adev->mman.stolen_reserved_offset,
-					       adev->mman.stolen_reserved_size,
-					       &adev->mman.stolen_reserved_memory,
-					       NULL);
+		r = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_STOLEN_RESERVED);
 		if (r)
 			return r;
 	} else {
@@ -2349,9 +2345,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 				      NULL);
 		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory_extend, NULL,
 				      NULL);
-		if (adev->mman.stolen_reserved_size)
-			amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
-					      NULL, NULL);
+		amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_STOLEN_RESERVED);
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 08c0bf0893d4..206267e95b9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -101,10 +101,6 @@ struct amdgpu_mman {
 
 	bool			keep_stolen_vga_memory;
 
-	struct amdgpu_bo	*stolen_reserved_memory;
-	uint64_t		stolen_reserved_offset;
-	uint64_t		stolen_reserved_size;
-
 	/* fw reserved memory */
 	struct amdgpu_bo		*fw_reserved_memory;
 	struct amdgpu_bo		*fw_reserved_memory_extend;
-- 
2.49.0

