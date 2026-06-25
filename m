Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBFFCDE00E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 20:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2EB10E29C;
	Thu, 25 Jun 2026 20:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aalaXe77";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FD310E29C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 20:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5Yy9pZlItGheCvVHZUi4jUT2w5fze1VORJvUltm8+IGKJDhTE4r2m3dAAt17poxZE73P85ZtyHmr+kATCm0U/7nAoFKZb2PdH1cIvrAQTfwx7dHNB6zeY52bNIJ5cVUG7YFvsvfk65LBQdCrZgHo6CNdK/d3WhWvjz8twh3r9ywSHbE0JOfCfTiz4iwLVu6I2JWpCvxWcI2ruNj07f2mBkMGlygLThbxLCGDg95GxpUFZmoNdDqe7pYF643gzdyYc3ZxX5NcXuPgT8QwQBwhPdjJJEPH4Vw23TdXbb6uIuGLG+gy95TpQNzQh7BB1F8Vd5aon/2mEJsdud7Eb6jwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZhXCiT8FocV5+sYJF59Kt1u+gbqqsRRPYTKOG7uhGQ=;
 b=DOkmywkwN9Kv4UYS/zUx8heHNJCswcPJYQsgmjAZ/SdQJQrqKSaf9ECTZoS2EPrIaU0zOnhuvyvVZWogDASG4NYKIjjNViEKH8IR9RlyCzJgTjU9WRvHMB5xa0DoIP86gVWP1LvuP34qdrHblNFPrNHDcOGmQ7A33RBsrrcftJrfft+JTvp4jtBECknNjK2LQdT3wui0O7vbNrvDTeagpcRQDJqMTg0G+uVuyTgW49jUqU/nfUIAgj1KswFnP1vWKrHXZjyOizXW0vdjS+ldxtUMSvlKXYXYAAfMDUCowXR36m9+qfnFZV+fysAtD9kvsUGMmXBCdiv+tDIIxenuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZhXCiT8FocV5+sYJF59Kt1u+gbqqsRRPYTKOG7uhGQ=;
 b=aalaXe77Fyuis8DadWMaLcRYVdrEyzTA0Esw7dJ4C4hp0c5GSANhLauDiKJmlGuHH5S8QDp+mGG5WLgPZaigm5Ot/UzJAWK6N96tOhWoy/gszBih51KqQYOTDleyOnMkYcdQBLLyl/P5qWBrvoPhe5cQoQUvqmN+jcXc8Hypl/U=
Received: from BN9PR03CA0773.namprd03.prod.outlook.com (2603:10b6:408:13a::28)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 25 Jun
 2026 20:57:29 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::15) by BN9PR03CA0773.outlook.office365.com
 (2603:10b6:408:13a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 20:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 20:57:29 +0000
Received: from bokun-linux (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 15:57:28 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Bokun Zhang <Bokun.Zhang@amd.com>
Subject: [PATCH 1/4] drm/amd/amdgpu: prevent PF overflow VF-guest kernel heap
Date: Thu, 25 Jun 2026 20:57:15 +0000
Message-ID: <20260625205715.125021-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 88069baa-01c7-4f6f-f290-08ded2fc5e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|3023799007|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: sagwaZ4KOfBJzS6sXeRpuVrUD2nKcvZaq2JrXHmeoSi65+BPlbqfSdiK7UXDUp9TIBukw28Bkr6gNDUzeVgEAYHySFla6jredLp4umsTDAV1zTR/GsIz25a62M+8c+3k/0XKxcnptAuJ2mxkXfoBE+V53YiQgwB3C7iDQ/ABxqSb8J7RHcX1eb5i+xgDhFBl4sQwQEXLDviXjdn5nSp4FdUdRQa8P3G83pN5B+Svu6qHBLcg/uhTQbsGU0WhKJqydB8Q7NUy9ZgmkDtWUTbFKmnIFrcmgBjLN3gqiGQY/U2qHBoEtLSuF1gjYiozxF1Dap4Tthgrgr3tP68VY0poE6TfNq8TYilawwrl47KQlcubRJEbBixSZ1jL5t5uRF/DbENMPEOOqk3mSJyY+H8DN/bTlanRmmqU0cFan6kUYqjLawC3w1uz0XjumyYDDeEpnn6K03My9JMDlvL5x+KcQ1F8mcNT+FmCIWtZHUXUuvZpg69Ql+OikKDy8FUCKeiYaPDbLKk6tHMt7xPjg1IEmNUnaetmIwVb4/rTtwPQoryXprW6VBVZCOvFWNitkPZWFr667g5zm+OE5YAVzCkdWSMzEBoWOL3ysPbLE1f+ywRnAJ1ePN9FRbjxir4HRaTpMoikNcEJms341FvqGlAQtluhvslDtDsXRAdjjEgvrUdy52osFpgq6ujxlsS+7pAXYSxGc3O9dcuMUbfRtslJbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(3023799007)(6133799003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0WvaswnejEoCHAqKxBpnUvJ+kO79JLM7yaCyCX1MRfP/6uqC1vNfaoJqmdzxMLrFsQbG1S2cskJ596udp+a6XJAJd8YTzBhC0piKh65XlPlLJpouRJMrTmo6d5YWRV57Yu5Tp2SHBILqKxIwBimn+/bCE/hh8ePKWTvCCPuKynqFm26mFL4c8OkMuAIp43WouA3wti7PtY23d7HGrdpj9CTuRRzKKovIMXEY02ChGDMbHF01h7GWB/4dHtnZly5B026YSO5t2b/e2VmfKrIKoMXQLsoi0850izLIZB8o03AK7gxel0JF+wjhloVInQ6UEC/H2rOhbvGoGu7DyxG/yWsSNYIW+1R6qZEyvE5jCVX4a4VlU2tIbLS7oCDVtWsSLvTGMEF0y6msoQj7mDqO9o1UkhkXhbNIfXEXbiwUn6ZgobwFEpOLh04oONYuO4pT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 20:57:29.0065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88069baa-01c7-4f6f-f290-08ded2fc5e66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
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

- The RAS rcmd->output_size handling has latent bug
  where it may trigger a racing condition and overflow
  the VF kernel heap.

- Must use a dedicated variable to store the buffer size value
  and add a uppler boundary check

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 9 ++++++---
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h             | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 838eb91aef39..e73443b933dc 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -92,6 +92,7 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 	struct amdgpu_virt_ras_cmd *virt_ras = ras_mgr->virt_ras_cmd;
 	uint32_t mem_len = ALIGN(sizeof(*cmd) + output_size, AMDGPU_GPU_PAGE_SIZE);
 	struct ras_cmd_ctx *rcmd;
+	uint32_t rcmd_output_size;
 	struct amdgpu_virt_shared_mem shared_mem = {0};
 	int ret = 0;
 
@@ -113,10 +114,12 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 			goto out;
 		}
 
+		rcmd_output_size = rcmd->output_size;
+
 		cmd->cmd_res = rcmd->cmd_res;
-		cmd->output_size = rcmd->output_size;
-		if (rcmd->output_size && (rcmd->output_size <= output_size) && output_data)
-			memcpy(output_data, rcmd->output_buff_raw, rcmd->output_size);
+		cmd->output_size = rcmd_output_size;
+		if (output_data && rcmd_output_size && (rcmd_output_size <= output_size) && (rcmd_output_size < RAS_CMD_MAX_BUF_SIZE))
+			memcpy(output_data, rcmd->output_buff_raw, rcmd_output_size);
 	}
 
 out:
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index 7ea35a028987..c7e8e84e2201 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -35,6 +35,9 @@
 #define RAS_CMD_MAX_GPU_NUM 32
 #define RAS_CMD_MAX_BAD_PAGES_PER_GROUP 32
 
+/* Size of cmd_buf in struct amd_sriov_uniras_shared_mem (AMD_SRIOV_UNIRAS_CMD_MAX_SIZE). */
+#define RAS_CMD_MAX_BUF_SIZE (4096 * 13)
+
 /* position of instance value in sub_block_index of
  * ta_ras_trigger_error_input, the sub block uses lower 12 bits
  */
-- 
2.51.0

