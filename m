Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F78F34C47
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 12:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9DD810E419;
	Mon, 13 Apr 2026 12:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lq8pWG1W";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6657910E419
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 12:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/p8sIi6zL0e38DLK0Db2sD4ViStS/SIiHtJFuF5m9rOiPdCrklaD7Txwr+lL4rDrE7vSRmuBc+gA69g1RX7hF9AOutsckLhPp88FgYlpn4mqqifPRkJ2tN1LINhTFmYA0TZ4n52ORTNTvFCfqVmxltHXz1t0jDZE5wPqIiMdg+J9UlAFeFMUecCflHq/0klZi5urPJjrSa1MKGGAJJI5xTUrDgv/TC20Frgi4IKojC50eWAjRYdaupCSld8O5QXdxSTrw6AYsR+XKg7yq0WW8fnUF9OPTSwIkgADhdpJ9KovSB/8wAW/o/60BWLwnqGPCdUugurbWup6rjKvYj3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIi/W2snlepkkB3tVYSnehfy6PG0HJ5j8yRzwqhegXQ=;
 b=ZZK9v33/k+S8mMA1bnIg67rMRD5rcIjQvPVsVHIgjjBVybE9XiN/f6GBjyfTfiRYP9N8EWiUi2X2wZH0vovPtm44uOA6dQfug0k8O23wi93dZ2QbkEUm7sQN0QZ54ylfKzuFZLqa+nYM+gkjmwws0KLsDALgjJNew7U3vA2CGt1l400xnNSCNvmGSl4GW5aDEg6/0E9mMixReQlRgZ3F3HbGTx0rM2MBb++mgkUwE3cNgnmrqzw31WWgZuZMvd13Wo0Ffj0kpCBo+uhfD3R5pfTlLZ/mYWG8NXS15T8+ngvOqqXioOlBuzeKRL7+xnPG2NX/eyv6JUS+/Wq3UJerOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIi/W2snlepkkB3tVYSnehfy6PG0HJ5j8yRzwqhegXQ=;
 b=lq8pWG1W/QQ1sMtnagLSyZ2LWrEQ5H+oWX39usjYNezOtv5lsVPCNYEA+HeVfq+dt8KI7HleXfwEjJgvvJlvuPpHZL4Oljfoz12ojMIuXHzhjXn/PncJRJS4Hs+eSC2tJHA1xycnsFVe1EMDK7NRXDDM4vq7MXQN7RTA9vh9XhY=
Received: from BYAPR08CA0005.namprd08.prod.outlook.com (2603:10b6:a03:100::18)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 12:11:45 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::18) by BYAPR08CA0005.outlook.office365.com
 (2603:10b6:a03:100::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 12:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 12:11:45 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 07:11:42 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH] drm/amd/ras: Avoid ECC status update in hw_fini for VF unload
Date: Mon, 13 Apr 2026 20:11:34 +0800
Message-ID: <20260413121134.2233632-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cd096b-e1d8-4f7b-cc93-08de9955d4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Bi7gzS5Zl1yMkdxbgowuTWHuLUdB4jAd6NTInmbBzTZULpsyXU8DdVWTQ7aAIyfiB3oBQbwn7TLMoCFqphzmJNevZ2JgHCKW6n34axKoHjPU5UnoNz+GVDs7LNB6uUwBMXUMncATbnsATKyQiwGh+Nh0LR7WjQUJc5fTN3QFT4wuocPM2dBFkGX/mJsilA1N2/FZ9sfpJQvp4GS8qMzd1SiDRGbGZ6R1BWY4y8NwCxVoXYJKLAkEjqOx6X3TPjk4A0D5tgJTMtaOXV8rpL4ENEWILQnInkXBX4Hliw1lsP9scpqFdMEcFaVzCQtWUuUd5xYTqkEuSA/iqnucFXEv4u19WCwRoVMOb/iorFYbu4jTtfUEskV7kKdqHNyS5/BC33Nhp/UfXBJx9esdhhSzNPTyIWzOOKjW0N4shgh4EmdYnelgxoDL6nWAwmuKYl+qUh9WJP9TjYLWvMK8aE2BHxtm4uWyASibsTGAtxjXtBAfPeAZR6HQnIlm+/etIhoOperkfsZzXKviAx2jK3d8BWiahjbvrVDAIobFM3cd1x2/zYS6WeeA+5jSxfhO1wVVyagXA/vASlG3UalxuFJAegLKUpT4dPFoahny/w2giN4S4DByoU1q7CIiXQWMeBLTzSfTXlW4+5UPxG3fZw/uXFM8VA/mKwaZ7i4xZVcH5RbjuiB3IinBtnW6BdqvjgVWVXudODuz2QUIO9RK87RbJXcNMqHMw7CPoi8soxQXyXHjE2eY4NltJojASLJNfLSTA56AhF7KhyPuEnu4XAXKgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jcl5ihZiQBTVtSIegwCuWS/6CAaeqk5k1aQ2j0GT6dwsgtTr4zLRoeOXyqusmFEy399/+M2MDb5Qg8c578f76rw6WlF5uA8NWDC/hS/NVJpW27sN2AeR2Umqx53H4OAhRg2QZf7/o+wqcUEeWjqa2swAnVQIzZzDYvn+DgyUW9yqwSz+r9YmE0C1YZCTrGRxJxozY99y3QgeWimNYSlrajZwn3Gv3nGStZ5Oyi1m+sWPAxl3j3fuApLgk96mPsyTN7poU0FmEldAxHr5HDqPzbltxudY2QUAoteAS4rCwTHS2c4UptJVX65CYvqZeLHjY0caslSwXqiej5tJiLyEPWZEcBpGWh656j9uO7QaYRGActbnXM/Mo8zahON+NmqzkzEfHhOtiofDfpnqtyByjgPKGF3qZP5NxBSubHeUm8D2U57UeeT3Vrk/UqK9fG04
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 12:11:45.1624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cd096b-e1d8-4f7b-cc93-08de9955d4aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

VF sends IDH_REQ_GPU_FINI_ACCESS before hw_fini during unload.
PF no longer accepts requests, so skip ECC status update to prevent
mailbox timeout.

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

