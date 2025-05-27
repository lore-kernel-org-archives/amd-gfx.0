Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE17C54ED1
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 15:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 812DD10E4ED;
	Tue, 27 May 2025 15:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AtEqFvM6";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D7710E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 15:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stXBhO3P2NCKZGQb0S2vNXkZKsjfDDBwhCgHeNWy9gyGyLVV5PbD8T0rufRQQ+yvdEpCZ1LdS5fTQVTnQaXyOYOIqDuCE10qBn61nHXyCEDRx+E8u82Qp3Xlqfvbor5eZCDspfJG7327nNsa14LoSpCySRidH8XC22Jx8AjVb/646+gRTDRweFDqKkx5hAthcNjJH9m0QRzzLxYlP3/MYojutj+/oIvaOR9MoOmSyHVMxnPgqaZ+UTaltCHCunKvVNcsXWp92kqnX+ZKaa7pVMYm1qWlXrypnxOkcCV/D+xU8LRWm0PKEkx9BHpN8qQiDWE/4b6MMuiGIEMpIbL52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNf2ZW/BIRMvMVqc7tREr1yJ7VWWixe6UeBU7+Ld1Pw=;
 b=atOhBDHdQfoWRH7OUy/OVsD7KfLtlxLZJZHLsmOyonFpbKcxuhiJEnus4TjnzmGb7IAGRQx+S/4dok4+Mb0Fh0RWWvv64bQ3nGGYFdmQ/iufnUWaWQfcAYFk0nPPChqvC6FH1DinjG/M2NW6kvjhswEuDq76xxXia6kc3WwanbU0QBfLDxbt2vZtxxE330jmiCCSiZI+npFrbQuy1D1wJrwm56cVV7ETz+4rkjuUXltyeer/6VCgPZjHv6VuSprAugtX/1355psqtscaPlzxDcMxkOn7n1Ry9XnSIlWWxaTgujXP9aG/zks6IKKwMAqU7A+jqG7d/Cb/16EITBFJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNf2ZW/BIRMvMVqc7tREr1yJ7VWWixe6UeBU7+Ld1Pw=;
 b=AtEqFvM6x0etu7VMFDWY15zDpBF9PChLkEXXhbD2UpModQd78QUuG7jPoTg3DmggnMfkOIlxFjYi9l92E/IiT/zymqMea5TfULPODtooJ65PPIqFydZffs32ANy44SYOtI4BuKZOXBux6rFrH1Vx/YKl2SzhazFDIr349dKceh4=
Received: from CH2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:610:58::32)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 15:35:57 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::c1) by CH2PR20CA0022.outlook.office365.com
 (2603:10b6:610:58::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.40 via Frontend Transport; Tue,
 27 May 2025 15:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 15:35:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 10:35:55 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix kfd process ref leaking when userptr unmapping
Date: Tue, 27 May 2025 11:35:16 -0400
Message-ID: <20250527153517.14533-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e69cdf4-b174-48b8-d17e-08dd9d342c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ebWm+1dfiHwzvK0N/AYjsziYmi/v+GimPXMgwD3rcxK+aU99hGnmpmjcZw+r?=
 =?us-ascii?Q?7hmOxda6hJwGPDhYAuc4/7mL8ItJiX9sGMLFUg6mMct+kJ7GDiJbfUmj8XI5?=
 =?us-ascii?Q?I1hwKOjDEoXj4JLs9NbXq4PKr7mhBVgyVfoe53zCm0wlP/Fli35XS9BG6+LQ?=
 =?us-ascii?Q?rWM6aZ+QgC55nxZvEeOhpZBcqZNAuIfx9kejH+lTOxz2ATn+MZjD9rv13fIx?=
 =?us-ascii?Q?4XzE9QcJ3mhBIMb6KGOr7vbw0+8FFKmldv0PLBor7VSq5ZwcBm6FUKU3BkKh?=
 =?us-ascii?Q?nM8lrPPmR/R/JlmW3AogUcu1QK9tABssnk4Yn3U+ZDa5bnmSq5JDbrZvhyXi?=
 =?us-ascii?Q?wTBoap6e9vxD1LRUQEWzG3QFFxKK7KdJJ28Mgg8bXH+80VPbpVvZ7uM5Q3Vs?=
 =?us-ascii?Q?OOkem0MLz/AekoMmrLS37PWm/O1mY/mWmuTqUqE4IrOziNMX13MsE0upDlY1?=
 =?us-ascii?Q?rVRDYbixKHHbDsd+cMnhd1N1EpTXICtC7a5AUhaimpDr7UC2u/uxpo1V9IlX?=
 =?us-ascii?Q?z0hJcd5jwSGB7tcx6HW5QkokcbXNjE9i34sMFmZYppps1mcpVj8Wgvc2ZYG9?=
 =?us-ascii?Q?0Ih3KNaYfvxfFvfDvBZ7Wtv9lFDDwlC1xrPDTqJIxxiwJjpOo23j+ypAM6J5?=
 =?us-ascii?Q?/QPXrs5tKapqaIoQhkvOgiy+duoyYxEuTk7ghuJtHTmXFq/Bq4WCr0//fkFt?=
 =?us-ascii?Q?tv6ipK60hD5glVPbUatzAfOfaY3ii8N4EyNWdk2q5W763E3MwjGmkDGST3J7?=
 =?us-ascii?Q?SBIeXhr0MCOuT9yBCJF8TKlnUIdZtZKTkUyh+5CgYKZa0/ditE78Eq0ppNFm?=
 =?us-ascii?Q?dSuHe7jtc+8i4KiRaMyUE2tKp601k7h8o36VIp7iGC/rWGZeGOPL2gYKFCNM?=
 =?us-ascii?Q?MB9bGgQ0LQJKvgK3VsrN6uw3WPr3BaCihenZq/Pzhhc7CFjecsldFQlLzE1O?=
 =?us-ascii?Q?TZaz/Bjjztf75Ty/2PHJPUaRGIbrwCqAAq1GysFKMvUmIOdteboXjsa413Lj?=
 =?us-ascii?Q?uf+l/oHjk2y0dNT5Byrx8PiaB37ufgXX1P7puf47F9y7fCUTKtyjt90o1FU+?=
 =?us-ascii?Q?z0pCKY41F7GVhk35xREU1LyTaTZ/D5VwX8Seix+mRyHujOcU6WjoZ8j2GuJg?=
 =?us-ascii?Q?lRmm+I9pb4FwoCRYPf1MhJH8Cj5zqFlk+fME6UDMEhMtn4mNF6vL4sT4WP7g?=
 =?us-ascii?Q?g82l9cQBaWxUmidbPy2FPcD5PFqYnjuno5uXtMFPQB3W9FqZKFd1htf+46E4?=
 =?us-ascii?Q?RZOUJ5/X9iUxrJ4k/uhds1fzSdMsVmJDZljmhbF/bEVGSxc7qpvTPAUF2qPN?=
 =?us-ascii?Q?t4ZZHfnozQivOOa8hnP86XD+w7sPY6Et2QiCeDH/+i86AbbMJ3Pn+bTk5C8g?=
 =?us-ascii?Q?4S3l5HEOyKfVc1/oGnp07LeRLyp3yQk5nIJfC1D1Z4AkBMSUaV5zyraUgH9d?=
 =?us-ascii?Q?pluxfmGFJqmm8VP9fXiVas3Ozo+h0lYLOP1IgM2EGCcR+3GIupPK7ewLWPs8?=
 =?us-ascii?Q?qaO6cvxAsoNjHKX6DkG2p8YoWDFca6vSxBD7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 15:35:56.2643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69cdf4-b174-48b8-d17e-08dd9d342c4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
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

kfd_lookup_process_by_pid increases process ref, the refcount is
leaking.

Fixes: 7a566d7f56f4 ("amd/amdkfd: Trigger segfault for early userptr unmmapping")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 260165bbe373..99a32bc9bb89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2563,12 +2563,17 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			 * from the KFD, trigger a segmentation fault in VM debug mode.
 			 */
 			if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm_userptr) {
+				struct kfd_process *p;
+
 				pr_err("Pid %d unmapped memory before destroying userptr at GPU addr 0x%llx\n",
 								pid_nr(process_info->pid), mem->va);
 
 				// Send GPU VM fault to user space
-				kfd_signal_vm_fault_event_with_userptr(kfd_lookup_process_by_pid(process_info->pid),
-								mem->va);
+				p = kfd_lookup_process_by_pid(process_info->pid);
+				if (p) {
+					kfd_signal_vm_fault_event_with_userptr(p, mem->va);
+					kfd_unref_process(p);
+				}
 			}
 
 			ret = 0;
-- 
2.49.0

