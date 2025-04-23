Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9A5C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 09:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D790D10E1A4;
	Wed, 23 Apr 2025 09:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vgYM1fxu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E63310E1A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 09:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdhCmzyBkD/GUsyeq7RYxTZbiXhVrPBu0F7OAepedXdYwwJ4VLk2asOwpXM2yi/Sl9Kgy0HqtEAyQ47jZa/Z1yPUPX2weXlE+V4FoAwHpyJXv3eQ0kGqjctcz2c+Vy5+DDFDDqFnRJQNCJXkBZ+FDiu2cuHt83jqVvApFYcxF0lepQYu7TP8W5kTGGrKOqSMou0PlIuYraa//lNoICp/7Y1IymcQc/E+sCy1tsa50hAp6sczxYU/Re6deGnkJM6UM/lT694Vd1OF+LhF1NVdvtszJ8K5YoxuLeYT0bWWk+C/cE/lGReJ9hUuckg8HFcStVgNSx3HNGOGtl0Tb/LCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcwZLMRI+EVqF9l7rkCdcIGchH1IYxe13wmnlnssPcM=;
 b=cAkujGuCudPuQYCHhJ28BSQUpzqRNhJ2kxYxhPyrFx3A++MDSyrKLtE5bPJAdc/bWnh9hABlE6EEzZuEcfWlTNOyGnJ95nvan6qvSV2k5dgphcvd0gGSidMTKhgDh7EEfTNnfUPF/3p4wwe6z4L5rGFgyd8sUSm4SR0U7yBCQ1JfahL04TNzZmx7SXujwYsSO02n2ueBxYs4Bd1VMSHeiMS9/EiR4mjDZHJABrzJxGCPGXwaXAuKeJyOM+3zNWygTypCARSdFCS2PYq+XgeMFGG56mbTNvzrXPFx6QEDPuKYuaz7J+S8HXWdiS0K77Ol6FB0H/YpwT5dLvAV2hk1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcwZLMRI+EVqF9l7rkCdcIGchH1IYxe13wmnlnssPcM=;
 b=vgYM1fxuVOzrpmOLoNJ4GvabuPAdYH/IhxRwTjQhCfsQSYYJ5jAc9uSFo2A+lczKAv6SrlcaxZa0m/eD00Oa7WdW9qpMWJLKbjk0aAJPGoDh59TbQglq/DSxj17hnuWWdjcSlx+qEMTF33BmULk/Nl/FwKNJsu4gAo0Z4uTgH18=
Received: from DM6PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:100::38)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 09:51:02 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::92) by DM6PR03CA0061.outlook.office365.com
 (2603:10b6:5:100::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 09:51:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 09:51:01 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 04:50:59 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>
CC: Shane Xiao <shane.xiao@amd.com>
Subject: [PATCH] amd/amdkfd: Trigger segfault for early userptr unmmapping
Date: Wed, 23 Apr 2025 17:50:36 +0800
Message-ID: <20250423095036.1413882-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: a58f5c9b-6767-4ccf-874a-08dd824c5b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RjjC4Sq/3LIptrdwRKkw0XuttXfh4DnHmuYatXNmJ7SOawDZIglhwaRsGdZM?=
 =?us-ascii?Q?vGsnxEOqoalAnqchgtKDZSLQuccKfn6QBEBDYeJIyyMd8+sEDTiGK1gKZzT7?=
 =?us-ascii?Q?Y5+Fxlzo370zsVz5nakq6uNZIQHZWalSTVEwlRFE/ao1D/F5fyw/oOpnJuwC?=
 =?us-ascii?Q?auHxQNVMy4TiQkmFOE63qWWv/Ob0Uxft+EVPgsRHyQ90cmFoCkD3C0o5MyYp?=
 =?us-ascii?Q?o9sVpRA+eajfhHsoaPpbU2yFcn+uyWFdgUzeXkH5dh6brRRcnMCKBFS2Obtr?=
 =?us-ascii?Q?VLzoMVNMxmD7T1Z0LGr+lk8d/CP9KXcBHDe3orGl6aN0+qs+d54ELOcO6CR+?=
 =?us-ascii?Q?Rm7L/b4Me/YSr30ymgHNRuLW/ji/OdEhbRiwBqhUSzEDaH+4ZuR2dXBnyltr?=
 =?us-ascii?Q?iygwZYDYKgbyQD5VxCHfkREv4+Dsx0l+4gqZLirgYgaqUIYgaB24zNBgXSpv?=
 =?us-ascii?Q?6MTDGbo2ZbQQC1uzs5Fv9bNTMfFjOP8MAF56t8zH3OooHppHQBNk/O4pXLQ9?=
 =?us-ascii?Q?u/XaIjgoIQdv/PWlle7X3Q+C3fRG/b08gqoLpVHi9r7oP1Rr5xLbKN5V/nDq?=
 =?us-ascii?Q?pmwJTeat7FPoK51ciDDUd1yeDIeZM1SBTO6VMr9axCuoLmR4iz0IQ0AxVkSK?=
 =?us-ascii?Q?3bqvlajMMYE+HdLRl6dpAHyFkfijx1/9vdBy10PWMM5Nn8X8/TuY4zpoNA6S?=
 =?us-ascii?Q?SF9QuaM+Z4dECqRh1QK1kI9x0WPeK7vb9MWzoEhvQrOdlZg6eVQKBPBdaskp?=
 =?us-ascii?Q?De65fNk7l/aRfAIDhL+95dV8H9fmaCWtXQ3ZB+xqT3jnj4ErRFUpAu072Yei?=
 =?us-ascii?Q?qIyPIr2gNDDsFeloaPlRsBb7gi3K75JR0xhKn2j6UpEbV8KYwCdgAiKoujNn?=
 =?us-ascii?Q?aV1VOwf3BxvNFhTHOxj7TuwH4rZJTrENJ4zMx2Mws7v5ZCHeyEcaCGJt8Yij?=
 =?us-ascii?Q?enVTR9QGHlfgHKXwJnkaokwloRKsmNp3ACGPvC+lvnGY2CRJQlemidk0TFvC?=
 =?us-ascii?Q?oorsNFxaBnzIluOHwhnGwUyuVvDRkrUgv7REhdMtw1jxtazgsDuZ7sEWbyh+?=
 =?us-ascii?Q?MpSU2cOtiNYVuzXTy6tearqbna9G+JZ1j5hW9t4wXfOKVx9yM87723pFUHAj?=
 =?us-ascii?Q?2xu5yvKZVI5L/HjY2e3b9pwyNkuC8rw7MaKmfcLGXNlb0S92ZuRfJfagVBuJ?=
 =?us-ascii?Q?nh29EKziLuCrtnpiRdF9mtIRudM08i6zuSNg2QdpQ/EvQNJyxeRDcaYRoJpX?=
 =?us-ascii?Q?NrxvnFlT+2F73bpTBeInCmPRZY7Am4uO0XAN3q6jhGtnyuhxdXsnCkReDthT?=
 =?us-ascii?Q?4SZrbb/Auf7NODtfdwNEuqdr6fVb7Ba4d9UvfcdL2nWGDQuKfYEOFeTSNJb4?=
 =?us-ascii?Q?+fbsXUa0rLwmyes54R95StUs8RlfHq7iNAcUC0blJwV3kpTXp8hKYUymO0go?=
 =?us-ascii?Q?+3Ye3wEAqEK62RKekNnI78J/XbdcJds+TPAW7VNGBB8bQXUf4LaZLC+msUut?=
 =?us-ascii?Q?/IdgO7gy3b2nmdLcw/PTEt1gCZWM9CvNMg3h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 09:51:01.2763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58f5c9b-6767-4ccf-874a-08dd824c5b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

If applications unmap the memory before destroying the userptr, it needs
trigger a segfault to notify user space to correct the free sequence in
VM debug mode.

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d2ec4130a316..259b38424b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2559,6 +2559,16 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			if (ret != -EFAULT)
 				return ret;
 
+			/* If applications unmaps memory before destroying the userptr
+			 * from the KFD, trigger a segmentation fault in VM debug mode.
+			 */
+			if (amdgpu_ttm_adev(bo->tbo.bdev)->debug_vm) {
+				amdgpu_ttm_tt_get_userptr(&bo->tbo, userptr);
+				pr_err("User space unmap memory before destroying a userptr that refers to it\n");
+				pr_err("The unmap userptr address is 0x%llx\n", userptr);
+				send_sig(SIGSEGV, get_pid_task(process_info->pid, PIDTYPE_PID), 0);
+			}
+
 			ret = 0;
 		}
 
-- 
2.25.1

