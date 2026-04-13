Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B19F34C49
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 12:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0FB10E412;
	Mon, 13 Apr 2026 12:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JO2u7mZU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D8510E412
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 12:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHUW4PT3lw2Fo9jy1Coxp6nh38+t4biRZ2YIHDTeReGRkWycD0uVMpuPbp/8s4kpSj+9rAa3TTCvD077OillBd3cEk+MYv6pDmKj4sUG8Dl2ajzPe405HR5ieCsDgdGKDpN5OfpD9HUSpN6zHrKLNhjO0tZPb4MaDu3HjUXDQShVjck3hplbetylNjobq7/oFJJ6csXquinyN3NWoUYscPQVrNyrHKdZIs7eHTJ4lSxXwpClxfneQA+O0iWcx7O2+g+0dSZLByLxC2CZF0/HsAj4k5F/EPp67dZkHsR8c3awjISgqK/lqveWwTS+XL+exraRmFQ8vUBx3KFwka1Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL5+XZqaqkYiGkKLm9sBgwYLzotA2tIb4Y06EN93ORM=;
 b=x5T7lUjEs7L87o7RcutClcHWwbBAUFpPJAWh1qlN8Y2mPqj6YbaupkKrZ5oFcTHBnc2DmPXFiH+4uZxku4vRX7dL9x8zCRGQBTMUOnHxf6twGFCJ3kL8UsJpzKdgnd4GLnNMwH7yqjr2fG6HjX4XGogrElY3iyIw0g2JPICIX0LTglvyT9vEMeFf0c6yokIlNp6PW10osB+vpt1NN/Ya2P3BVH9/JeJ4jeuVZ26ljKqr86Amp1bwN1NsiuvfP/ObY9Ea7OwKRXGHr4Hgaee8l2SRN9p9jzvcIeIwT0y1uGK5xFmeXVZaro5ktg0v/O6uq5mbrmBk/B82JaqA+6dHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL5+XZqaqkYiGkKLm9sBgwYLzotA2tIb4Y06EN93ORM=;
 b=JO2u7mZUybadPTVaTDP4gvKJh0JBZFA0cRTxg8wQBszKi+64N1Jyp/UYpeyNQKEZAJeA7S6XK4T7/OMENGrIZjr5chbZ/HvpoLva8QfxOugassVhYh1+d9lAu7l5knhL3RiAr5CpusmCSgXnVMAjmtplMINX5QAkQF6srqFKCQ8=
Received: from PH8PR02CA0017.namprd02.prod.outlook.com (2603:10b6:510:2d0::20)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Mon, 13 Apr
 2026 12:03:34 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::3b) by PH8PR02CA0017.outlook.office365.com
 (2603:10b6:510:2d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 12:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Mon, 13 Apr 2026 12:03:33 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 07:03:31 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH] drm/amd/ras: remove update ECC status during hw_fini
Date: Mon, 13 Apr 2026 20:03:22 +0800
Message-ID: <20260413120322.2233542-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a74d2b-26db-4d9c-300c-08de9954af89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qReAmgLuyvy+HHVhwE0TN8D7GIpn0pdJ+AxzwuXzz2XSS4GgdYhWnyaePznyTUlzGuMwcR4OYH8LFJgn2iFsEV5D5C6ynxVxuqZ2wyx3vjMOeh1eOWfqgHwvNrQdQj+m5vQlNrEUe8ffznOhk16wp8+K+9bgfDc3/DHEPQDFfb9QhEqJRThciude/zlw9GYQIV7R6xeFgEULbXnBLxy5uShhT+yH/cs9b9I1Z9K0wjPfwpA/xY+kY61a/yFGBb/Y3teFLqOaWYDwcNO/sJ1Le+ySQNl9zMd1jyRxUwvX1KRagcrc5MLHxyrJbs4DOwDDezUOldR/pdYNgmO/fCrhQKvhd6+q3usE+ZHMVXTy8kH7QsrF3Ia4Sp8NbizsO7GLi3f3ym0Y90I6hW13ce9YCa70p0y2cbtzf3W7rU/6xc6a7pmQUXdRuuxnARPpQghhl656kwgkNAojxL2ulgkIRYx3V0LByVKlUaMOvKECAFT5kyu6U9iOg22XpLtLxfUBo2eyQC7q/wNCrc1iL15CpyGLVIo8ISciOx12PcmhcV1JelrBkrrk2QF1M8AL8DTEa29ukqbdO6hDz+I09SUWB1q/XsP9928TSdrjz0lEW2+oJohAv97Hv0vhYQS+JPpLk1gA0vlrY3Il093TvLzDvI1wb5rEItMH4BDbajh367g82rgJd+rQ2UvK215j+3h01jJpYYLbvbBPavcNEVWL5oqGNhcFpjIVFNn7jX8qVuKOcOJKAfoQHD/EeadVorin5HAKkq2RvxnWNAZCTlWyZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zksW7Tr247VmSVx1VNllLMb+nCTgb4m/TfvWsc6L3b3xY9Wwq2VHJuZp3PScJaSYrr/0/iKAJYePFXkCK866yBvJobtOWlhN+JDjv+zyQ9Ku9w+rYI6y3MxOCHY3Rrr1uIYfJV485QXyYos4DXg8y8dGH4BSdjgrehRM+uR6jXFcJ7lAoCiiJUP9wLjYg2XLHUTVbzHQimnn7547k9+mbWzvbz/lMkNhjn+LhtRTqoVuELyFHQ3e3qNZFG9YV6Em4yvTRCA/kuIwpPW+KmSyHkoQkAtVhaH4EPyXWd/l551iF1V3hf+n63DULKKSOKxcwIzGjaMSM518H5KdY8bcqMQyiQH2PxDARivBF2MJHdCT7KpeW3WmLsPPLg9fbYJTFh1l6C7CM04WDmimE38BAEiZwZry4ii0yDE/pBAM2ZFzvklq4a93CYGXBIUyLnL1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 12:03:33.3756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a74d2b-26db-4d9c-300c-08de9954af89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

VF has sent IDH_REQ_GPU_FINI_ACCESS to PF before hw_fini, PF stops
handling requests. Remove ECC status update to prevent mailbox
timeout and VF error.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 28f94b92716a..838eb91aef39 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -517,14 +517,9 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev)
 			(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
 	struct vram_blocks_ecc *blks_ecc = &virt_ras->blocks_ecc;
 
-	if (blks_ecc->shared_mem.cpu_addr) {
-		__set_cmd_auto_update(adev,
-			RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
-			blks_ecc->shared_mem.gpa,
-			blks_ecc->shared_mem.size, false);
-
+	if (blks_ecc->shared_mem.cpu_addr)
 		memset(blks_ecc->shared_mem.cpu_addr, 0, blks_ecc->shared_mem.size);
-	}
+
 	memset(blks_ecc, 0, sizeof(*blks_ecc));
 
 	return 0;
-- 
2.34.1

