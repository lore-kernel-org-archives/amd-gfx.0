Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451BEC5B55A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D43810E77B;
	Thu, 29 May 2025 20:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xUNikx+h";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078C010E76F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYTRQj1tpsHVcgIH7wRCixoefHU/B8bODmbv8uWgipagwHFNezs0so3XCTHeenBiDjaoKk2GcEQx6AFYfQY4ZudiyEeANQ6I9PP7cm8OEa5l/DJ/kM2NEC4+EbzlzjO2bY+sQDpYdv/Niuu4mnyPlBSQxr3yJRI1pVk3FWXouusdXLrtIplqBK4gQ1OGjp9MsDMoXP7Rj3YriDGKQbI0PWiMQL7dsWBRgKgGh2OT+rZ6el45sprfEPJV+QH7x/uSkVWhb/IjyZ+O3lejac8S5yT0d+oO/sTKq9ExiiE+kyUorYgFmE3HAOSJ5HXXR+6foE9iGxhQIT/ZA+sQvrGuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwFuRGUuerHllFMQ5dKC5GvcYft+OrhtyijQtMSjD5c=;
 b=aFbWQY8v1P/zXItV4V2bEehv/neVdKcENiQcYVZSU3A84l1c7AyzKE4XUA1hwEy1/WJC9ieZVqsKM21UHrQlurTbWph8KSCseS9BTvAmvwW/TJPGyMT9KOhenCCbN9xaCn2CqiGswu8/mfPL7yuO0qPm+bD5JFs4WF7PxldlnUJvnEoNkeoJyc68+yR5lmbZXml9CSeMD/48awtws/RLgd/dVMOB6zeeEkq6FIS8s5/tmt2eGo7z6j9ZE9pdUijPV4ZnkQgbF7gkvhYHhV+d8nFQeXh89uw2UFtPwwW9XkDIxhgea7TY9GVqS1eeHh5jOOiDTIab6xN6aR2SGJ999g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwFuRGUuerHllFMQ5dKC5GvcYft+OrhtyijQtMSjD5c=;
 b=xUNikx+htcKft7mz3wA96UtQ+ba/1S8Qb1ohsqiEf/+3hLEa4my1Q7XAYE4kymY7WBAWX8WUjJq5v1Cfp+igNruXjh91Qw29nyCAp2srDv2k8Dqg4tWHh5f+VYe2YXEuQzuF18Ho3z1UEQAehc316QKwnSnmAA34gxVZ5fME3F0=
Received: from MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::9)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 20:08:36 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::be) by MW4P220CA0004.outlook.office365.com
 (2603:10b6:303:115::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Thu,
 29 May 2025 20:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/28] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Thu, 29 May 2025 16:07:58 -0400
Message-ID: <20250529200758.6326-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3e3c9d-8e26-4fe3-9257-08dd9eec9874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Q4hbQiuGZNmmCSpi8aAkpyeyumTicTjVrs7OpkFM7IRfJ3N3+ToxcHKtHnu?=
 =?us-ascii?Q?iuixzFXFq1HR3odDQUMwZhxsKlAmF2ETSevjag9QXzz/Uzxnc8WDYwbCcgrY?=
 =?us-ascii?Q?YVtXSqGeBwZo24gPn3wwj/DWNRIJSGqYpYmUnaH9GEMyqamOZ/sMSRbWhR99?=
 =?us-ascii?Q?YPCqNsxsyMp0E8pMGPc7eGP6MF2wqeJUkgsIJVNpmzsrCNTVVZamgH2asfuZ?=
 =?us-ascii?Q?jlGp25CFlmC/FIbtHoIg/MSYBwPAWBXbPZm2gQzg+iR85Fgn3XdIz9Ys/zKt?=
 =?us-ascii?Q?z/wiBrQ8IOt4cSIT9a27w1pb+aWtu4yBYsfe6mE9u5GOQmMwAebJDqSuaC6v?=
 =?us-ascii?Q?mSHkxl2bXbN6ZOIBYthjhSm16znQqXCIjrI3sbx13fsxYkTUTqbqtsD1G3Dn?=
 =?us-ascii?Q?RTEJjjZ8fzIx9v1dhSiEyWtkoThxosbPvfOQ3RaECxTYZbE4W55UaEJc3EHy?=
 =?us-ascii?Q?MWLZavFGUBWejBB0fssJVDl1Oq6xn9Q2fgA4Ftjbz6A6sKZ3aViI+yXQ9smg?=
 =?us-ascii?Q?lk5bCx17bJrbeDBLah/cvQxy+gkO6toj0WzzoDhSr/Ws33wgH5Gv5jdbH+MB?=
 =?us-ascii?Q?8bv61nP6+OIKTdQcWfHSkFcI6m258ryyngvCGFtfOwLeuqSQHbnfJXHVf8wL?=
 =?us-ascii?Q?jFkQ8KYQE8663oklbZtybl39NiU1rrYTRa2waszYTQ8L6AUTz9SUqG58HROq?=
 =?us-ascii?Q?5NVUMaZesrTKguEIqBJ6JwBKWNIIJRef90UNVKktSn6KjRJXWHhyc96V8FDO?=
 =?us-ascii?Q?YRthi2XkBdoLwdiu1oKZwOuWIJxudQRmEboN3kEhlUZ8zNpiebrcAWcoQB1Z?=
 =?us-ascii?Q?DF/u4rMtPALh7+bxxqSI//mppGlfg/srZMw2UPrW/TbqOtX25iOHucEBQa6x?=
 =?us-ascii?Q?SU2OjN2JkrdXlbix/cWXuJNAUKRc5jZm5/ZdtU/I9vlcfK13MIuJmtq3dyqc?=
 =?us-ascii?Q?o2Kcj+8tnx0nEALfJuBhIdMIeMbkOXFCNjP/pm3/UFTRL2Fi469A/UJ4xEFz?=
 =?us-ascii?Q?7ydZArOjSQ0WwcCTUEjuvIC69k9mwvoTpHx27zy+AhZBqKeCBhNZs5xmRBbX?=
 =?us-ascii?Q?gucQEA1wWb/w+xGMfFcSd58Yt24PTMxuSHd3L5da13TiKLU1V+e17m3Qh45P?=
 =?us-ascii?Q?ES7GXpiRI29//t4Y0uiV5MB2DbH6La6DUA7fMoDAMVVa0otoQ1LvYQBb6oTt?=
 =?us-ascii?Q?FQ4q696oHikXXV9Rztxok0oc68pSjOCU1fqxkXspJzP9eV0mjvlFgvrHHOY6?=
 =?us-ascii?Q?5ijL02nU3wNsfjdo/kAcc2eThswHaFgPdHXi1ReikIQ0gMx29tRXCNFcIhKa?=
 =?us-ascii?Q?cdFYFuxxjJ7mp0Yvlqzpl0W8t3TMoAN06RczFp/HgbqOVravhZkidDThwXNl?=
 =?us-ascii?Q?BBq4jMccG/9u47CC465d9nXZFncik5tDZWYAFjPZiHFoMtMX+T2HbwUqJleE?=
 =?us-ascii?Q?fDIYpkTD5q776yzdpBnhAdjcOADcsiZ1JSmDUd2K15qFtwzUjW95kQ8YaF5k?=
 =?us-ascii?Q?0+XYRmpPXJIiAhqCZN/x4LsAm983T1ssUT9K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:36.2452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3e3c9d-8e26-4fe3-9257-08dd9eec9874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a998708bc0745..3cc49c82e324a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1202,9 +1202,8 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-	amdgpu_fence_driver_force_completion(ring);
 
-	return amdgpu_ring_test_helper(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.49.0

