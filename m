Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96713C87FCC
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 08:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D78510E25C;
	Thu, 31 Jul 2025 08:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BfrfL38Z";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49ABB10E25C
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 08:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8jBB80wJZzK769SZn67hZL6kpjkeyZtICKxlVWDI30InT7TA7nrMKBzc+ek0eZ1/4BUArExsEyFkZqEavCj4w0D0dPud25AXkRKqeJtkkbPTfxRVmeD42yHDxdR2GOfBIq57+RDEfBC49JLqNqS2aiWVH+egrKXHlGIAs5vNLWEI8AUyxyIlE1j6uYPZ5xPdHmDDxvrfwFM41obrajktiFjA5EIiyFuFFFEePexX6crNFgCwxLQdZabnLcZUM/1ks1sqNjPAVgOrHoVI+pZtWF/N27yaRtyIpu4J5a5fnOMj4wJ55t19svV6FJGlEjOVi9/KpVjqrjuDnf7MADtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3aqlXpIu09viDaoEshhzaCgM/+aW0YlVmMnyez/TWc=;
 b=pSVDAg8hLDFBKXOibPGYMUyfzuTn6mEr8lxCtVJrZD1LISIYfNWw/T2Fim1V32NPhJS/kUV8q1UJYTTbacGV/WeaerOb+n1wYj6FhRDnvcVJ9o/j83bQYLhhkes/JHkAapiDoWDDgw0Ub5csnAmerOK6D+4BV5UakzKrxFdeRIpeteU4dHwZHMql7GSf4dmKq8oIMtcNwyzjb+y6IQlpgrYef04n8xrYKBBX9cgxU2O9n2FJzDlBJldfMaG0LMU58TIqcLKgZ1CmiMpIhUcBHrXJeDhSRn0uPAYIIryE4WZwYGSqMoz/8GRO3mN40fTIKkfeVlQvsINHUxQQlNmvXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3aqlXpIu09viDaoEshhzaCgM/+aW0YlVmMnyez/TWc=;
 b=BfrfL38Z1DFG3pQ+ZXGEwiwUms7sUZ5WZR4cdxWndZwVgtEG/qL97OfscxDcZx3FBO8YMNmRo5EoaIFFE2T7m6Tt41mHg1RqWZajouPNt0fh08H74DvUiweIjpY7Qg+oKziR83zA+nFRLMGIIh35mjw5f4xi5zXNlcMsCsy4OYI=
Received: from MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Thu, 31 Jul
 2025 08:22:17 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::a6) by MN2PR08CA0004.outlook.office365.com
 (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Thu,
 31 Jul 2025 08:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 08:22:16 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Jul 2025 03:22:15 -0500
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Heng Zhou <Heng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
Date: Thu, 31 Jul 2025 16:21:56 +0800
Message-ID: <20250731082157.25816-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: baa32dd7-c51b-4355-3ba2-08ddd00b5c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?juaP/GJjD9unBkF4VtoPNgKkNAuVaIIIqXPQFD080kI6RIl5QjhfkVVkdFp9?=
 =?us-ascii?Q?d0+7BoGr3iGbjWafFgbD41zfWvw1haGFwGKnilzriGi9ivXnPI4kYVCqE3FI?=
 =?us-ascii?Q?8HwludijWi2hIShgwp21HkG1bSZpqMPLkQgqxYxpt/ccZBt9FxkmvRRxgRWy?=
 =?us-ascii?Q?lmxk6OMUoQYEpu7mE/sMxhnjN8NAL3Z8fsjWxSmxFAYzYg0uEuCi3UAkQyHU?=
 =?us-ascii?Q?xWooBHvcqpImdqifEUgDJysUcqcajd+tO9XOj6s6U0sAKkz8vDIvZd+chLdQ?=
 =?us-ascii?Q?MPhVdz4G6Ww5R2G6oDZXe97necZrfgF6XmngtBByWcM7pwqiG9HnmXaR6x7Q?=
 =?us-ascii?Q?w+Q0CCtysBO+BKbdL4r3+1vvKbZ0STTnAKSvHwJ8PxL4V5iHguY9s3fEawbV?=
 =?us-ascii?Q?mJUnvwBMYEvMKFnUQs0eEIDmaR0TbHlrjwUF7BFPepe+sbAOztcAGZbIvdO3?=
 =?us-ascii?Q?GEFIc1uhQxlG/crn+85E7F2RW65BymTFQzBkJyRc8RW2RzQAC6hmhsQ7Q1ii?=
 =?us-ascii?Q?E+xhcfN+HMzQdeO+uckrTesWjXAi/iw1M6QW76LlSJpAizW95heEFwtjA5Av?=
 =?us-ascii?Q?2zarXrg4yYsz3+k/aFojlbj1rs4O8OI7rTQcf1ep9PUVEHZKAWmL/acgcm2A?=
 =?us-ascii?Q?hreWzyZxGdfKexz2tDLKwpoBJSbcq6o2iD9CsZtJofqLKlkN72JR4luiTfe8?=
 =?us-ascii?Q?fnlkuWnV8IBWU7u3ft5yz6rKBEoeIHOCD3AQvjvMOewpdFfSLm8lDLEoQuY9?=
 =?us-ascii?Q?Pbj03EnMCKJN8QAB8x635Ihptzoki8gnVBsbA9dUtdzFRTObWH546lS4okR6?=
 =?us-ascii?Q?r0c1vBsGgSQXtRJrqCNFqatqyCfOq/k06kHDJtkIYlb/hugAhIcS0hF2o80Z?=
 =?us-ascii?Q?74ci8fFTWe4va6Zpy540DwuGp+0bj1lQUpMSm2IO4/z+upJAZb088/17awPP?=
 =?us-ascii?Q?DCm8lqoPxHWEdFU72WLqJKrG6bYPZ+l9DDaBSeqMuNG2+WjX71UFNE1ZWh31?=
 =?us-ascii?Q?un8A9CxtZpeZEGckAqiw/1uzjWSk3s5C+jU70ywO6A5QnoHdKr3jm+D9x2MN?=
 =?us-ascii?Q?gETmcU6n+AzBT8JT1JlD63TJwOtSxq+EFEo2uyRRY1UEqgKsSPSo/lzhkiG9?=
 =?us-ascii?Q?eKDAqQ2WdPc3YbYp/8IKZWFjSVq1iIyn5fHmSbpUfEM+abZPLNxxLUdKWKBw?=
 =?us-ascii?Q?2DHyFBtYVIKsGL5mDeYzDTi/GxXLWLoN2Da+D59iUIyq4+Q8wPZqZASN6D5b?=
 =?us-ascii?Q?/8Mn1yc3i5QuDUi9cmqwEZUJM3bOIcIJihDUjO95xnYSo7ddkgDMZy7yGaQx?=
 =?us-ascii?Q?gq1mhcfkoOD0kvInnKLPw+T7Awfm5Oq8lLLfLh52DQ/dlFvt9i4UqZKzvbVv?=
 =?us-ascii?Q?xWN76LQPUsJsTrTlI2mTrggj8GZzVH7V8BuFOPRUPt76yJNJmcU/DDKDzhGp?=
 =?us-ascii?Q?z9wgC46OBefZLGdQgc62ixirXqRsjrBEMCy5rsHr20HCOE6uNDGhGjRtxZ+g?=
 =?us-ascii?Q?R+R65wnN9g8dgdA37jXmKP9uAg0rtfWauTWh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 08:22:16.4222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa32dd7-c51b-4355-3ba2-08ddd00b5c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
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

If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
So, such kind of amdgpu_bo_va should be updated separately within
amdgpu_vm_handle_moved.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 283dd44f04b0..f88b3e3448f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -578,7 +578,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *bo;
 	int r;
-
+	
 	if (vm->generation != new_vm_generation) {
 		vm->generation = new_vm_generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
@@ -1608,6 +1608,17 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
+
+		/* bo_va->base.bo is NULL only when bo_va is a prt_va */
+		if (!bo_va->base.bo) {
+			spin_unlock(&vm->status_lock);
+			r = amdgpu_vm_bo_update(adev, bo_va, false);
+			if (r)
+				return r;
+			spin_lock(&vm->status_lock);
+			continue;
+		}
+
 		resv = bo_va->base.bo->tbo.base.resv;
 		spin_unlock(&vm->status_lock);
 
-- 
2.43.0

