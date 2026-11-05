Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C87606A337
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wJlDi6EP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763CC112290;
	Thu,  5 Nov 2026 09:21:17 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010070.outbound.protection.outlook.com
 [52.101.193.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C0F112290
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 09:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzeLIFsOUx9Nv9do+QzoDaak7D3AcDqKdunN/GuewyZFo9WJOEDKRdENbO6R67EA2c5xSfq1HPaqRzQCSGqhy1p7/vFnnmjjqVOMAyhqs1Sv5O31EKlCqYtImyRnTr2wfZEQSHZnf0MB9mNN6+jL/FLZc1OE6gyUtzk4hyaW2HIPErNDETjduZdEETX29ZkbsPNQzMCfccWY89paTsC8SKcsMVXOrzo0TI+G3KJ5qb0q58E0vuNtaBCIUHdzJF2wtru677yeqOiFK/Dy2gZFd6XD+RkswywzI3xnjuhwt5Av11kYU5BZ6sRnjFuNVizyIjs2ZMwLYfMzA/NtsTf3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAT9oAFdE5/C3qJIqMZV+hezdp1zH+OGlR0hYn5Y3wA=;
 b=AMHMB14bMqBuSyQ3WvTnnuY4rtkSq4szgvxGN0wN5cuCrwIlkxhknSJiSUfX6NGtJ+cYZ6yFuAdxIcXZPvCrRmzwypMSxSbIFbBNljypkBr7O/jsC4/fd1VWjb6ms0ZUxjjp2e/Di5Nb2v/ICRLUcEPEvvavtIJxveMxqvTYnBBGvV9BFF+nzYIko6mq9u8E+/QNJv9meWtgjn2DZoZvNRP+grCDPp+7wQ5SakhB664PbWOhLhnBfPHFxln8MkK701cCRbEFAaI0r6Q1pAGD0M/gDuD1PGXVkhbG9sA+O9WrbgX/merwNg5Ft1pZ0i2lFzHuS4GTUcq1Gp8xjcTh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAT9oAFdE5/C3qJIqMZV+hezdp1zH+OGlR0hYn5Y3wA=;
 b=wJlDi6EPj5LeEknnQFaAgk4KuLFPR6OGS1calE9xvaMt8HrYHbRa9y9z3wbJ2fIvkmvPLKWkrcrOpb81dKqjqogwjrEFNVBm/DxCSFvL4yvN1JagS/zm7YpPyeQcYxdONcOsAY/Ctjo5vHg5PCtaJX9FzdiLbmXsz8EOSpvP+yY=
Received: from CYZPR17CA0013.namprd17.prod.outlook.com (2603:10b6:930:8c::14)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 09:21:06 +0000
Received: from PH3PEPF0005961C.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::47) by CYZPR17CA0013.outlook.office365.com
 (2603:10b6:930:8c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 09:21:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961C.mail.protection.outlook.com (10.167.243.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 09:21:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 03:21:03 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 03:21:03 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 03:21:01 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: skip GPUs without a VM when checkpointing the BO
 mappings
Date: Thu, 5 Nov 2026 17:20:50 +0800
Message-ID: <20261105092101.958212-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961C:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e93e54-5872-4ee8-2ff1-08df3b1e1e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|18002099003|56012099006|10067099003|261102123227099003|261009223027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 6q3CPVteNoebEB4CvGBN8W0feUye5aG3x/3dSLlpiW2egbr7/IQNfuPqzd52IMFRc9dNcpWpzWW9RBgiBYNeXyyiNVHw/bAfXPIt4YIXARcTqd9SMjW40x4i2g3BQEah2/mQi4wudUA74jJbuCj/thKjlEavuOdcLO4u1uOA2O9lpn6GudGFFoti8A/bBOIS6Oov7R5/puoZOsQjYpCV/3V/J6UCoIRYSX3pyc3fvuZ271PNdOF8yIKqlRrN1KE319QBnzjyIhuf5hB95ZVVtIxUCpMEz+uw9bBvjjMGKl4STr/m0oyNHRJCVbtZZDaRQe5rMifWKYmNGn1NxXhk8loW2VZRVpi3xYk1dKwsJxIBhg39KCP6VaarchYnLVitvMAWqI1fHVu4iBpwiY2PZylpGtOI/5xvk8uBk1sJj66SBg0Pt6NLjmLMH+v7jxFqwLxFklc+oepDZBWMafBPUzzuUlalbloUlUN5mn/5BBgJI5J+IBl2TE8QYsirWg14RkbGogcCYl2c30DlvZ9t/qDW4nDi3da3Ml9WLGBjN5zm7TW/wvL41KzXezNqh88jqZ1nQuMSmRvKuZEGB2A+Jt9vmoLs0LTChRSEAtc5NibqoUvfpVGNVXFFTZ6CGaTNV4zzwS7vkvt2V6ikBk9O/rPYjsMQuYs7HU4OOhZFkeQQnoH/9VDHgh7xg2fcsgTdnQiEBhXKSZdQ6jPiuShViA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(18002099003)(56012099006)(10067099003)(261102123227099003)(261009223027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QmqQm22xbSsc9wn3DCBUa1fwwroKbt19y4PUM2kcCJZkzICSm7YmxsQv/1rRVoBSZkwgYbscpN5LMNNiTYkmS0+9Tf8yjbSugWzGQB1Cai9BwAtjZTEuOd3QXkx0RlaXAr68ZfXuxnx+CmWOhcn7pYOF/Phj5hSmCCJ0SOtv761b1xV6GQb8Umg/rudVx4fzny+Wt6I7BcHK27ZXKwMDU36f+ViYGo6bPymeAk1/fD58TJJQXAGRPOXhnQOfCxtZ/jUyA2jJ0GkWWADsSoAMpzKWJI25iBIN+/ELhqtUKqV4q9c7wLbTcAMOCPAL5wa+m2b9YOAVNgb5aoXT0SDzSGVuNJQHLnXrK9+uotuYBSbUQadCGy+xoweXiB6Q6yjzEt/jGKzb2ekeQRewtmAl4P/+a0HD5aBPKwVziHkrAq8go42b59dtyLOdWe/KbB+R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:21:04.8709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e93e54-5872-4ee8-2ff1-08df3b1e1e18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
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

criu_checkpoint_bos() asks every device of the process whether a BO is
mapped there, passing its drm_priv, which is NULL for the devices the
process never acquired a VM on. On navi48 with its iGPU, checkpointing a
process which acquired the VM of the dGPU only:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000002f: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
  RIP: 0010:amdgpu_amdkfd_bo_mapped_to_dev+0x35/0x160 [amdgpu]
   kfd_ioctl_criu+0x30d1/0x4aa0 [amdgpu]
   kfd_ioctl+0x767/0xb10 [amdgpu]

Nothing can be mapped on such a device, skip it.

Fixes: f9e292cbba21 ("drm/amdkfd: kfd_bo_mapped_dev support partition")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6c710e4a5220..56f9ed14a2d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2175,7 +2175,9 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 				bo_bucket->offset = amdgpu_bo_mmap_offset(dumper_bo);
 
 			for (i = 0; i < p->n_pdds; i++) {
-				if (amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->drm_priv, kgd_mem))
+				/* nothing is mapped on a GPU without a VM */
+				if (p->pdds[i]->drm_priv &&
+				    amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->drm_priv, kgd_mem))
 					bo_priv->mapped_gpuids[dev_idx++] = p->pdds[i]->user_gpu_id;
 			}
 
-- 
2.50.1

