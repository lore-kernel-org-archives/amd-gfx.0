Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A43CCF2F2
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 12:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC1E10E42A;
	Mon, 19 Jan 2026 12:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WFPJjPMI";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C5210E42A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhDwhqr+oRrIYkEtNEyDVB6RN8UfQmW0LBbiZhklfaE5/gOI+2JY/IXZftz9aQ+ZH5n9adwApNn+gJWRTWVDv57k8ibIc6XGJ5rihkpK6XJaFwEm5GC10rNVH/AT3zrVmG7jrlbbBxrUm+K5IWp5br30SXQoDkfBTnValuXMVX+D7gqNCCl3wAKHL+Tdv5U/w5rCLy86GW7mwTmcKR1aKenY6RgiTQyUYfsQVs/CWAOLA+8i657Ai2xy3GuNkHytPwmPAZj0Vs/FaA6I3n3tkk/tYmsfUuJxm569vn9z9Bj2r0qiSMxEDe8+MU7DwoikKfFFb4IXa2gmBkLkBG4SRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lxzOulkgZ4iVO1j8PQpH3gRIQwe3GiDvDmT595gAIA=;
 b=RrT6IMDyAZ9gaHkLwEG/Dk54OcjkwSDagFgN8kwt5MgAyDEgnEB11Mn8HQoM5wXtJnJ8+/keu4T5CAO88hhZK0Nli9qowxYalPlVqGwwGXYf/VwBGqBlvTgHjaZHcLzVnMwJZH+/n6dG6w8h6GsD/59VFcl+XkbSMOni+mIsPJv/Rm3xOfNLhdp3kknU34U4oj38/+8YqnCRLB8nmYuFYGKUxrmV485MB3DAs8F+0wzyf7ZX9ZNfBrkuhWlY79tvWI6pJbYa1rZBmIMIrNgNI6VqLvDEUwos26kxPla5ca0kcc5F2Dy2quuFbwFyxqJLBQJINZPUuAQuA/BXQq07Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lxzOulkgZ4iVO1j8PQpH3gRIQwe3GiDvDmT595gAIA=;
 b=WFPJjPMIGi19otN2+7y1ZbSLh/WAQVyHfsUlDTzXzuI7DaAkb361vtEOuEE46YEPVSvgTRwnyPxEw16w5MAqNz2T+jRKHaCLzeO3jsSETdX83IHD/+x1/oyZP+CJuTW+OwbIOVjXUw5O3hWCH/cgs0riACQB/6qoJFRzhIdzSLs=
Received: from BN9PR03CA0541.namprd03.prod.outlook.com (2603:10b6:408:138::6)
 by CH1PPFF9270C127.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:07:25 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::f0) by BN9PR03CA0541.outlook.office365.com
 (2603:10b6:408:138::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 12:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Mon, 19 Jan 2026 12:07:24 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 06:07:21 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>, kernel test robot
 <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Date: Mon, 19 Jan 2026 20:07:13 +0800
Message-ID: <20260119120713.1131740-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb57909-2bb2-45ae-0b9b-08de57534e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SW45T1RWTE94NXdpbDRrUnk3cXZac1kxR1dBNXpyTDB6ZmZ3b3A0MjJHR0JZ?=
 =?utf-8?B?bTNxalMzU2xVMkoyeU9kV0IzRDNQMldtOTQvT2psd3ZkWjdTTGFTZm5uLzJI?=
 =?utf-8?B?eDZlYWc4cjFVRCtRRFM2a2ZTdSt2WmFETnZjSXZzQ29tNG5tV2VXY1ExQ1Y4?=
 =?utf-8?B?Z3Foak1PUWpHYW9vNk1ZczJXVnZmZkVBd0VZVDVwQTlySWJPY0hpVnlKMEVi?=
 =?utf-8?B?WElCdWppb0NISUFnYkZzT2wrcUdyK0xhVWU5SmxKT1JVYnJUeG1zYzh6S0ZK?=
 =?utf-8?B?VzllSFcvcGoyNEtiR1pMUDJoSjlVT2tIRm5jOUtYZk5FUTVFYmhZcmV2OUF3?=
 =?utf-8?B?Y0FiL3h0NVN0R1FHZzU2S0prdWU1bzdsNW1JZTBncDNJYTdzQVJvWC9yZE5h?=
 =?utf-8?B?eEdnTUdhSnl2V1dRN21LYkVFOUpHNkQ4a3Y3dlJMRkdtL2dISGRNOTVTV0Nz?=
 =?utf-8?B?UmF2dGdYZHYrbXVxbHFCem4wMzYyYWJQRzJ2REhxWVN0MDAvTCtxZkVYMEFo?=
 =?utf-8?B?QkNhUElFd3JZUUFhOTRuaHQxbXoyOHR0dXdDdForc0V4TUUycnVQRC9tOE1R?=
 =?utf-8?B?THE4aFpGeU5VUWlEaDliUVVUUzRVSzUxQUhYTnRnajM1TTd6OFkvdC9uU0Q2?=
 =?utf-8?B?VFdCdVVxalpsa1VZM0NGN0lHMTVYZnc3MGNCNGd2eFNyWmhGUFVOVzlyZ1JO?=
 =?utf-8?B?VjFoNndkVGlzYlZvTStYMU5mdjFIQmNYaFRUWTFSM1M3S2hJTi9mb1Q2SEpC?=
 =?utf-8?B?VVJ0RFJzdVNHbWhyZXFKbmdTT1piOWY0QmNpSDY3dFh4YjlrZ3pESTRVa2Rh?=
 =?utf-8?B?aVNLbGU0TUFJZzk3QXFqZC9FK0dWdkIyVjFsU0JvRHNBY1BBSzJhY3d1ZEUw?=
 =?utf-8?B?bGt0M0w2dW00MHcxYUJsNmQwWitkU3dWWWUybDMzVHQ0dXhvY256OWR3Qlkw?=
 =?utf-8?B?MHFMeHJPQXdERnFSMjlYbFVvdGdFeUpIdERxTlJWczZqWFprWE5DUTViYUpJ?=
 =?utf-8?B?RXlQaW5kTlczVzM4RnpQU0dtdlJ6MGhPbldwaElITFlScDBoS3hZdi9VakhV?=
 =?utf-8?B?OVg1dGJMc2tYMGJ0YlVYWVdpM0lrN3doUVRBRm1lZS9jbmFjUzBJVi8rR2cz?=
 =?utf-8?B?R0xzNXo5U3hoR2FlSDhKM3FzZjFiVTRGNCsrOWliemt5dTN2azQ0bXNLQlVs?=
 =?utf-8?B?V3lQaVJrV3JMaktuUEFNMDhOanE1MHgyTzhIMndFeTJzc2MxbG9iczdmOVV6?=
 =?utf-8?B?QnQ5Z3ZSTEw4d0xxU1dZT0FzQXBuNDVGRXNmRXU4M3N0Qy81c0U2Ukt3TVd1?=
 =?utf-8?B?d2VoR0RmV2l1NnVFMnVmMGNUVG5uUm1zVVlyK3Jpa2QwMGl5Q3huY3V5cnhD?=
 =?utf-8?B?cmF2TXhZOVczVEk3aFRqN3FUa2d0QUZ0YmtyQU94Wi9wNXIzV3prNmlsRUVm?=
 =?utf-8?B?NlpmajZ4NnZVc1Rab0tVczB1YWppVnRVaWN6QTBuRlZaQmVLWlRFYkI3dkhO?=
 =?utf-8?B?OFBrc2ZwK2FMQ0FoWXJ3MXN5VmZ3K2NTYWxYUm1CUjNhbE5qa0d2N25sOXhU?=
 =?utf-8?B?QzEzalVydGtkaHpkQndyamZySGNrbndteGwyb2JiTkZhYUV0Y1N1UDI0aWR4?=
 =?utf-8?B?azBZOG0zaFMvN1pCWDcxOGY2REwwVDFaV0ZpVERiNG82NW5xc20xdlR4YVFR?=
 =?utf-8?B?RThxSEtGdXZza3FIKzAyTGZ0MXcvRHFvbWVlV0xCcnBDL3RsVHlCR1pHZ3lZ?=
 =?utf-8?B?amVHQy8wTVFGMDV4T3FGWlh1aUo4Mi83dldOWDdhaDRjbTdOZzl1K2NaZDdH?=
 =?utf-8?B?NHBWYnVmQzBDenZZZXRWOWlUYmVCdGMzRk02MkpEcWxBekZCbzdHWjZ3VXMy?=
 =?utf-8?B?V1NvUGh3QzhQOXFGdEdBeWJWTnVIdWNXMEZySmVsajMvYkRnRjRDSXRkeW9i?=
 =?utf-8?B?M3BlYWo1SGV2RjRkNEdkbG9ZVjA5NHIxZERacjh4YnRMazFuOUUwQ1VpcDNp?=
 =?utf-8?B?SnJXQXFaR3lURkhUK2poeXp0RndrS3NIQmc2NWR4M3IrU21BamI2RTNORHpS?=
 =?utf-8?B?ci8xUFlxOEt5RTI4Rmxxb1B4blZoY2xhMGZEWm5vM2MyTytWemNLd2N5S213?=
 =?utf-8?B?clFWTVEzMTdSLzdUVEhlTTFaWlBOcjVXU2JySHNzZUZORzNLQnJ2QnFDc0Rj?=
 =?utf-8?B?dGRWbjdsLzZKK3ZuYXpyYVMzV2paRGFTdjlibkVQNG9HbGI5NFZDV2J3RHRt?=
 =?utf-8?Q?KeX6F9+3nGhJSBcyLyk4M/jkhMKe/pSGaHRtEzE7o4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:07:24.3596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb57909-2bb2-45ae-0b9b-08de57534e7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127
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

From: Timur Kristóf <timur.kristof@gmail.com>

When a function holds a lock and we return without unlocking it,
it deadlocks the kernel. We should always unlock before returning.

This commit fixes suspend/resume on SI.
Tested on two Tahiti GPUs: FirePro W9000 and R9 280X.

Fixes: bc2dea30038a ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202601190121.z9C0uml5-lkp@intel.com/

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 0e67fa4338ff..d9ff68a43178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -781,8 +781,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
 
-		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
-			return 0;
+		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid) {
+			r = 0;
+			goto error_unlock_reset;
+		}
 
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
-- 
2.34.1

