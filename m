Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC685C54756
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 04:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A322512AB64;
	Thu, 22 May 2025 03:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w5qd0qjF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0E693848
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 03:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkpB+zJU7zXUCJ5Cj7iL+jTktU376KazYfJbq1aMZtBWtxzVguOWmcH5qv0qIqPZeLB2Bw+08+9FbJKuTkPAWsgkHTe7L3yBRpX9vyG0PM0LUHv3FuquWldBjjwGsrROkQGzXRVlIdXAx79BLYJsmgu9YWxB8LOjTNNrvDyurHTv4OXGPsy0OrVoz0BYDi7Q5oC0Lrr/IxjcWRF5ZANro9dULfiMPHMWIGKVogxT9Xr+PDXyYdPR7pnRVGYOJTSAQhWin6eSLZ17W6DQMwFTSWX1h2qq549lBxs1K8n7K8wAPoXx1QkGNe2ViGApnakY1XvShp75ZR3GAFp1V2/SKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBldj38hTdG04pzVbgqekO0mDznTTtGUcY/jqvPLpUk=;
 b=oHo554GcD7XtGPPINLdqJ4+p/MnODgwrzbOLnv2jYlc7yGAXPA5W1ueFOJxP5lHqGjBcBFfA1+klL2SR3mDayceMUM3I+0tzuy/sXfqdlmORdChk1OI6Fkvn+dfhDmglTuBTmCQNEbFnURNFiE4mXKCPQEuBq2Y+eDtP919FZrn3MhjdW0UL++1fQzulP809/DrSz7FrsCXLRkZQbsus8oX6SNJEp3NDm2W6L5kxDejRi8B/3ggeAQtazapSAm/hZKAY6jdjnPBNSFm6SXMtLT+Yhc17xURacKMa10y/Y6aTpx7+6QKDlDwKV+1yTk4Wq9AqaXcOIywrnSvohEPXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBldj38hTdG04pzVbgqekO0mDznTTtGUcY/jqvPLpUk=;
 b=w5qd0qjFPssZWG7d51eQzEImfBWy480mo0uU2vJiRorxtsY+DtEkx0CxwdBmVj+qFyDik0bBFF/WqstIYk15xNxKGblNvuEW9LDDdgCUBe7ybu1NE5aaWxC0MFqq4puiI8CJta68xcTwgcAXGlc3CmIQfpNW0sA2VTVN9nsltN4=
Received: from BN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:ee::18)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 03:45:10 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::3b) by BN0PR04CA0013.outlook.office365.com
 (2603:10b6:408:ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 22 May 2025 03:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 03:45:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 22:45:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 22:45:09 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 May 2025 22:45:07 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v7 4/4] drm/amdgpu: fix fence fallback timer expired error
Date: Thu, 22 May 2025 11:43:50 +0800
Message-ID: <20250522034350.433219-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250522034350.433219-1-guoqing.zhang@amd.com>
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d93fd11-6dc9-4f8a-0d1b-08dd98e30d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PTlPZ//KqMOlUEg1FbB2KAJjSTPFSDUBIBT9/DLNzKxUOfq5OhJu/c4eWE4N?=
 =?us-ascii?Q?+bU9uNicYuGxmiQmzz2z0uKfanzloA0NlQj9DjOHA6rmRV6P87W1FiBre5A7?=
 =?us-ascii?Q?B/3BnDbGpCbv/i52Y8+mq/r5gSuOBplpJcEAgXs9QF2pMfzMVDiF6AEF+WIO?=
 =?us-ascii?Q?iy/YEz3GaTJ+cB+EgJ3z00/YEicklvwiHMNqPNCAwdxuYvyzokGb0hm1LdDg?=
 =?us-ascii?Q?+SodJHKxGtOqyKssaOjEVD5tyljTWmJV3aQll3fGeQSViW68n4alavJP4Nq3?=
 =?us-ascii?Q?D11/NEn5GFRfzWq63aG479698Wu291e4ORYQNLseqXKnzK362IH/5C7nyvfq?=
 =?us-ascii?Q?FeBKw39M+unwkvdqAwhLEp8D9xUTIO5M3CCzJW2gZeynpmLHwtR6wDQFVHKj?=
 =?us-ascii?Q?O909uiIRKB5chtDVVKOCiPjJla1P+AuyWiqi7lZ8eCMntmlp08y3j7snJaMN?=
 =?us-ascii?Q?cmtn7L8yUirmyL4CoWKmhUcLsN9DlKQ83Dcxr4CGJCK0mR6YFxZ0ntus4Tey?=
 =?us-ascii?Q?HMBRFEw3Idksdk5j7fXtgNL/l5ky6EDxGCc1ohrT6xvmkBMvPE7pfQAvQiMm?=
 =?us-ascii?Q?EDfxvfREKPD/nDYie+5d4AqGMeYMt1nzcY1RPVtDWSaw+Hxl4XqugyVPyucs?=
 =?us-ascii?Q?gZkQJd/QiSsp6HI6sAeCCRWJ9In6wdQ/2Gz/sVVBang0CwC9gAKwFz1q/R7N?=
 =?us-ascii?Q?OFKvhQJgofbZ+YQ2LOOvdXSnM7/wkdRfsFVhaIFctf2pb3fY1b5sTl6aGsgT?=
 =?us-ascii?Q?bFeAPqxhCEN72E0K0fR5DdqHtEIC6ufEqlFKqPNEzt1WCvT1ppzg0CKjgDSP?=
 =?us-ascii?Q?LP0d07J6YqZ+WqVJ8MHEHTflOjAk5aqLkMZVWHHdamK1+x6Bll6N8wG7+yRU?=
 =?us-ascii?Q?ljIXh43CD7/dPezN6vEtFFF7PPT8KqIKowGtVmg756/l8vzJ3BrvVblQtVlU?=
 =?us-ascii?Q?HVpt5kOBJYU2DlLfe/zASCnVNQFA1empg1pT+wo5EVFCk8M7znCOprcWuu4N?=
 =?us-ascii?Q?qkqYz764zjMigvNKsvoy9mOjT/Ra5KTa3/vDqMhQTxhQ3QYWgqmZybiTDLZ4?=
 =?us-ascii?Q?V2wpXe69st4iOrtj4b84ygNsHB8mo06GJEHplS9D1c80MR7ghsvegwDVeC+R?=
 =?us-ascii?Q?Lmmt4jgYN1mlZIfYVyHN09hPcV3qxRxkGddJ2/OrMQJDaL/U291CyqxEA4XG?=
 =?us-ascii?Q?wAwvW/d9q27oTBl01ZZ0/JNVuEwnJabng8RLagtlprgN5MnH8LwP/yyKXNVc?=
 =?us-ascii?Q?GHnMB4rfqYulH3T88TpavZ1AxDprVVSnht4s/TE5+2iQy5fObYyl8+JcwQUJ?=
 =?us-ascii?Q?pa445XBYLxZavnCjHOorew6fj9AjuL1FBSnrU4OT9mi+nMZ5OxF62pIgXBzF?=
 =?us-ascii?Q?F3pHijsXomNrPR/JyswOkgUBHfpND2Rt36R2TsRhq64GAvOLOzrg1MrDaTWf?=
 =?us-ascii?Q?B8wko90RNNURMUl1ZZlvChywNy0/bG0FkReNl+OQyzhyV7mksZh0OL/PFrYQ?=
 =?us-ascii?Q?iz2j8/BE1XywEyEkv/4Xjmbp0vLCoKd+k/+m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 03:45:10.1028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d93fd11-6dc9-4f8a-0d1b-08dd98e30d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
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

IH is not working after switching a new gpu index for the first time.

The msix table in virtual machine is faked. The real msix table will be
programmed by QEMU when guest enable/disable msix interrupt. But QEMU
accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
by nBIF protection if the VF isn't in exclusive access at that time.

call amdgpu_restore_msix on resume to restore msix table.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 97389168c90f..1f38ff1e42d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5051,6 +5051,9 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
 	int r;
 	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_restore_msix(adev);
+
 	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0e890f2785b1..f080354efec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
-static void amdgpu_restore_msix(struct amdgpu_device *adev)
+void amdgpu_restore_msix(struct amdgpu_device *adev)
 {
 	u16 ctrl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index aef5c216b191..f52bd7e6d988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
 int amdgpu_irq_add_domain(struct amdgpu_device *adev);
 void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
 unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
+void amdgpu_restore_msix(struct amdgpu_device *adev);
 
 #endif
-- 
2.43.5

