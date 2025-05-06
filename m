Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F46C3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 17:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA06710E714;
	Tue,  6 May 2025 17:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mgRTp8zr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7A6A10E0DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 17:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZS+NwVDMRXuKznXtqG58VuOYVaNPVwe4KK24T4fETC2GBpHXm83sJrCLZMZeUwX6yEgd4Lb4jJFTFne1WuGCMjDBQ+LCsOf29CuRrfYnaDfSLvm5sRnjjde2e/4RUGkgx4IY6Fae/TQJmD/SN++uRk4ccA+VhVyV5DS5JVILT9sfahOvxkp9GO/bjiPv/vmVtI/jKAw9IhGUv1Jqls42TaCl6+IU3DA8YkNJyEg2YN+9k2WznxwZRaBBn+6Qqg/Go7XIQtOuT9T92wpBx+kXVn3b3kLZU/02hWvZiJGAKJcKDKKWqh5ylkDFaWtf0GroZ5BCLOVOn/viaFF4c+VOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaBQOCV1KFdptcD7yiCnWvDRhClSrlRLLs1x53OTkgk=;
 b=R47KdvwMnGObzfbQeNOrFq4LsuIX5mkrXBpdVFBmsX70B61dvbyVHXPSMyEV7AN88JBncTE5wbUnLQw39gMhMBFi9Nonbhbp7njfkpGGhUZhOk2bB0jV/46zP4Ck8cmcWap8xMMf2GgPgtiTDv0sfE38v+5zgQ/teU+7W4oA6+8J2msXmBjx57OATQvCfL31fGhj3axkbH0eohzvgJS01d8IE6oIPakvMq/OHBV0GIRO3PpastVYvi72W16qhApUGH81PCOjNO0FQI6O5YuxaLeRkSpSttb0sGIG11nAcuWRm8PyTRw2Gkxaid9DuZLyxqLOmtLNGwnIiNFzu6Vuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaBQOCV1KFdptcD7yiCnWvDRhClSrlRLLs1x53OTkgk=;
 b=mgRTp8zrGmX3P0XxrwFEbx1s6OKO3eFUyOeskA9UAvFE/ci45YIVkRYX1AnjsChY3sXv4po9OKi8xlT26sQa65qvDiP9aIcWDWBYWcZu4o8GPle6ohkJXe+nuKDANQ/hJQxn+JIk9o4hF97+Giv+bHPNJZDegEZKEBTUQBKoafM=
Received: from CH5PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:1ed::10)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 17:54:44 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::c7) by CH5PR02CA0009.outlook.office365.com
 (2603:10b6:610:1ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 6 May 2025 17:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 17:54:44 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 12:54:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
CC: <David.Wu3@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/1] drm/amd: Add per-ring reset for vcn v4.0.5 use
Date: Tue, 6 May 2025 12:54:19 -0500
Message-ID: <20250506175419.3518-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506175419.3518-1-mario.limonciello@amd.com>
References: <20250506175419.3518-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8c7d6f-24ab-4cb2-01e7-08dd8cc7158f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e4huU87QVq/T7gjC1klf8fdg+zslhUcmZBOqLfk7cwKrfCACScDj6K4XMNki?=
 =?us-ascii?Q?xDWxUMtXS+rkaIPC7r/siZU4KfUMMp2gdu8NS3gPul0oCBMCUKalJL0FFeJe?=
 =?us-ascii?Q?yADcCEexrUv4hyzYE0Q+wGQBuhes6OOrFn+Q4cjt6XC5FDB7DnV+fKV3TWsa?=
 =?us-ascii?Q?nvyz+BrgLQLVa+rx7AvH21LVNYzaE7kub/HtKit/+4I/HM76qrhaAnEJdFDB?=
 =?us-ascii?Q?CdiKD2/kK6TX1QnDGKNzUOTz2IUXaMNZjTqexAhDDJnfyp0vi4PSghHPjkK5?=
 =?us-ascii?Q?14Wt9ZT6+het0zPgh8yfomgxFgao1VHlxzarm7FeWBwUOR6FRpDn81Y8DSg3?=
 =?us-ascii?Q?p2/u550neKSgi3xeseJMpjt7nWVGFgxsxOjG72xTX/vtEo74q7JNFtHJVdjh?=
 =?us-ascii?Q?DbJdhW0WabZ/MwxFCN9W8yzy+i4khBE+JL74GSJ6ZU3UEfuV1QITTAEC/rmw?=
 =?us-ascii?Q?RBfRg0Jbugy1hdZxyZCVHcT52YlJYoK6zyNV1ENnKEKaYmaYiPn25lIoVLgl?=
 =?us-ascii?Q?+C8/Ke3gjy9atJHb3mIOuiWEPHADpYrA+Q9RGUr1d7vnw/+PJlmiMNxJTmW6?=
 =?us-ascii?Q?qjHN8fKNK/VTfdapM/Mt9QSznxPxxYckr22PgcjfTMkfeaYToOA9xzGfky18?=
 =?us-ascii?Q?AUoXxjBkLQrkInQkRu6RGT8qjl/DbdaEOqaoMgtN1NAZAVyWSIiVgHSKAMEz?=
 =?us-ascii?Q?66OCC6EP1WP+JiJSwonwSGHT3/ohaAayvm9xFHRVAws0wzdrOCIYsFxoYSMF?=
 =?us-ascii?Q?9jJ6Vycx6J+Svh7cT9tz2N0n46xDJ/j9lXdCnxVm/bNuKEn8HnEEkgM5XjaJ?=
 =?us-ascii?Q?pt0fBuuuMvQIT0olCqgqzdct5ccIhPv2QdLROfyWqD7MWYJHUML6MGJgQv+I?=
 =?us-ascii?Q?Bne44kbUE6asThHqXybKQ3Df1IDlQXndIwjD122/wpAWHs1OW5HbSMIbkP7i?=
 =?us-ascii?Q?neqqx5sskR874AUJmcfSFc2dOND2eOIBAlG3cGpq5Nlwra8OZ3bEQfMgNMMo?=
 =?us-ascii?Q?XMqgiX0O2u479mMiUytp4Bv97Rv+3NCatEEu32Yl7/Oqs7vdWlvkvxLkSdR0?=
 =?us-ascii?Q?7q3dkaFYeYAvG5phUxa3qSfZXq3w608isQJ/YoPGiNVSSU6z9oHm7lTUjQrU?=
 =?us-ascii?Q?ICfRtsIort6tTPSRJeHfkqkrA2SYA4KYd8susz5/5tF21QzQDDF7FbFYtbIV?=
 =?us-ascii?Q?yChsBQmTpmHnLrKflYaGyE4AexZD+1TnWZ1QTLcBbQllk2KH66kHXMudYTrt?=
 =?us-ascii?Q?8o4oGYcVJN4G/YnbYTP9p2Rph3XCIup3XXkx4acVwK7yAkp7U3edU/AjsKOA?=
 =?us-ascii?Q?hQrxneswuYcOW5YcmO3LcsViGn8X0ByzQWnyd/Zxj1TBHi+g5sdOfI2KBLUG?=
 =?us-ascii?Q?iA6yTq7++0edjGLnpaLqlxM76JjAm8Rp9enNlKTC+UBmgFY9mTyJDKRSo+7L?=
 =?us-ascii?Q?ofTnS3T1anCFTsJQFFLM0D5aFqn+jVUqCHgPabf1DlVs9WFaiVXl0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 17:54:44.3889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8c7d6f-24ab-4cb2-01e7-08dd8cc7158f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
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

There is a problem occurring on VCN 4.0.5 where in some situations a job
is timing out.  This triggers a job timeout which then causes a GPU
reset for recovery.  That has exposed a number of issues with GPU reset
that have since been fixed. But also a GPU reset isn't actually needed
for this circumstance. Just restarting the ring is enough.

Add a reset callback for the ring which will stop and start VCN if the
issue happens.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3909
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 558469744f3a..3e6e8127143b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1440,6 +1440,24 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		if (ring != &vinst->ring_enc[0])
+			continue;
+		vcn_v4_0_5_stop(vinst);
+		vcn_v4_0_5_start(vinst);
+		break;
+	}
+
+	return amdgpu_ring_test_helper(ring);
+}
+
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1467,6 +1485,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = vcn_v4_0_5_ring_reset,
 };
 
 /**
-- 
2.49.0

