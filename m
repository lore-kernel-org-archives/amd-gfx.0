Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E7606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nW8nKjS8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C733110E300;
	Thu, 19 Nov 2026 19:36:46 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0D910E4CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 19:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saHoSF2c5k5cIUq8DmMpQBgidMsBINJRAcpC+iGGw3/Vu64kwd6JQIzO8NjTCt+ywITJN/M68f300hAtwErPi+DykqvtWFxpijBfc/ycyNreInnIxVEmnp5AZ7XKYgNTBPo2swfZkDJWNXzMMBTwANnbgw2IyoUtfcYe+gS9eJ9v365Np4MIwCThQIe52Dm9NYjbiJrohDGO4kCwN6FG1r77hkoULbEs3wK8oEIK4h5I/zIgM0j1VVBBdBDr/MWFIoaFwCwMCWiSMQgx48qUREZrcLUgolvK626Juk6wRhejbQ3LSDJy4DqSQo8w9oWCGwKfJupz3R7vQSeOUZPP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+SX+ZTx6ycYiELENNMFnSVs2z67TJdhyI+b+yLYEfY=;
 b=a0/MZThZ/ExJtaQk1Px/ZqbjUrUy2T5Qc/9AzVLxeswxpG6UlTKPtOxS4JfRjzchTnhUF/L6GgLxfyEroGsYVhRxFHXJLZXlESLozgnL0Oor0EoV0ow18b1qBQZ/gb+K8ejQ6ZGU/KfoUB/3MX8H/JilL3DnQb1AGnJre4SJBnfp8nkUje1lk7Smg04S/ph9WVmvCq3aMUzYroGtgmfzkY8s+MtCGWBqHB6SO7na81ZLnp/Jk2+2EVbaJQxlGJieft5UQLSKNBvuNfCGP+JFEReiX295Wn5hH6yPltBEa2m50mCeUZpmLybrI7qs3Mc2jK0VQ+yVQKRDijbRE5Tx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+SX+ZTx6ycYiELENNMFnSVs2z67TJdhyI+b+yLYEfY=;
 b=nW8nKjS8t3N97NpM0wwGvJu8FfgZkPkQ4ZLT4tj2IFreI27gLsJWisder6TSB2QFaMkfdnLgZMX3QLUQ4CG4PaYfGHU+mSQ0Yw4LE/IOeOuHjWhGTv4Wp06hMi7MJAoy6b+N4tesl7FJG8iUIbNOG+1FdATNmnHaXl+cMVPmWqA=
Received: from DS1P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::8) by
 DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Thu, 19 Nov 2026 19:36:32 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:8:451:cafe::a3) by DS1P221CA0002.outlook.office365.com
 (2603:10b6:8:451::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Thu,
 19 Nov 2026 19:36:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 19:36:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:36:27 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:36:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 13:36:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: move tmz init into early_init()
Date: Thu, 19 Nov 2026 14:36:19 -0500
Message-ID: <20261119193620.217718-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: e486a7d4-9387-4d61-4680-08df46746928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|11063799006|261009223027099003|261021123027099003|10067099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|56012099006|261022105027099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZILhJVCpMpTRxcSxLlW90XK5mh7XcS44mCAtNI02RnAR8Qu4GAYArc8CB7Xq8S5DqH5jmpM5qf0+KIYvJDUnpRvBa98PFqRJ3ZFhSHueTcP0RcJr68D20p+wHy3vYeTq0E4BuJ3SanO/nAbRvv19ojja9Sheuu9wwFmR0zbdrw/1+fuHtmZ+xjQOsXS1IXRWabtyqreigB94kl7v7evbHazbDLKrbA9pRA7wrD4ZQgz9N9P63/sWPsT39YKu9aDe7fKbphfQkEOHt/N+DGsfo3GxHWwO76XeGrA4EI23zVSsMX4WMqc8wqgBBHau9GBkCbb+PwZUAjWfID5WUA7IgWfbgKqdsolJqeXupLz5g+vpKYOk9uFRFjmuRFZvQcca06GJxtAyAntc2/y4FkGCP+R/3SxNDTiDoIced3tAIGrlXVwAtom0pMXyRYDOIqPmfDZEQaxp28q8NOQKlysyETHP1DIPTE4NBuqrVnbxJDbhYnwXsvUCJOrG1RMimfeCtsSc0+KChidk7yVZZL17Q86rqmgb24QRZLR8ISA5ft9yCZsPNBMF//63nHaEHGYGl3eMF2760KHL5r84JTW8+ktZwLI38ZtiExcPRpjrh6fHfNtGxiqbkK9q/ZLKCHRrWTdISvdMJSeoyf7yOc+57h0nZrqTS0MxjmiC//kO4Hfu1D5sqH+4O7CkvDmbFX1x1DL09qaPVS4EBwXEFAnJpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(56012099006)(261022105027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sAGmH6CU27eS2ERPnB59xZZuZBEH3FOHiHhAPNEji4fGp81dC0SP6Md/d3rRVk21Z12GdI3gP8pgSPJqDWEpl6zB6jlaOlu2Mysc4Z9dX0bJOy0sexhhiQWCSe4rS4LObNZjRWliFq5kfTglMUQWUSSut9psuMb7MDZJQeEo04B4BGG1jmBq1Cu3zH149XS7HrsoAYozeYPhAbOzUJAnHYdvHmJ+APPowCTwUlWM9wJn9DQBmiWDc8a85rnYvyjjIjWuuILSqlOqm2zaBvMiXOIobwM0rnOQ06id460H1H3nVuYfw/CKKjd5wKqIdK34uYIPj+XvDa3A+wSTx9MmsBNo42jQqcHPAVAsLnwip+V82l8AuMA/MY66WG9dlwPDlP+JsNZWo1iB0Cr6ibppRiUAlRDt3JfBl3mc/N3P396R548DqjArMcwm7S0HVqqu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:36:30.3713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e486a7d4-9387-4d61-4680-08df46746928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We will need the tmz status in early init for gfx11 in
the next patch.

Fixes: fec62b5e1425 ("drm/amdgpu/gfx11: enable gfx pipe1 hardware support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 09a54b8ebe8c2..b892ae1ee54d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2116,6 +2116,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 		amdgpu_psp_init_fw_variant(adev);
 
+	/* Enable TMZ based on IP_VERSION */
+	amdgpu_gmc_tmz_set(adev);
+
 	total = true;
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		ip_block = &adev->ip_blocks[i];
@@ -4058,9 +4061,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			return r;
 	}
 
-	/* Enable TMZ based on IP_VERSION */
-	amdgpu_gmc_tmz_set(adev);
-
 	if (amdgpu_sriov_vf(adev) &&
 	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0))
 		/* VF MMIO access (except mailbox range) from CPU
-- 
2.56.1

