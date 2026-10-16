Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E84CC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 14:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5778F112884;
	Fri, 16 Oct 2026 14:29:26 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5872B10E259
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 14:29:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRyiKTL4GftJRJfxnOF9lY0EfkzALHY5ddErVGDOtjpQS3bMfG0uq+63aTijqbC5uh++SxFvXhjE3pVnG7X3aoOjab5wDe6vU35JesZJx8hgi689p5FxiUYmrIgJptHkdS511yMvwQKZ/mCr/6pQus7yJ98t4DRGEDVXqaSNMXV9m6k31duFyFP6BRzwmu31jr4hYqTzet2DCEVoxa+yagZ2VN2a+2thMAVj125bZpDsI/UYRc0lB8lCxfbojr51grTEpyw7epPVvJmsEdRN4/qnOsfPDVoxqM8A2H9aoJtZRexjKMJ519ot7rl1fzW8Ol19Wtp6IeL6b9Moo1bEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs3jVfy0gZNL4MqrSAVklCpm44/cWSKS2LPSxR2wKOI=;
 b=DiQTdU2qon7kiGGJQ8GkAjJLIGh+HaaLW5/XHWMDvkCSaG1OSV48C7nnGp4DSlhSVq+CB8KVian0yNnYiCwxbKUi646bvUxLgnOswFWuYVhT0hhr3MaMyry63Qx7fA3bVd8Lt/AcoVBqIcTNTaGjMb9TMOB9xET+083wgdOZ794qixpVXeigdiOVmBNaXuKWMCXG75jovgjcgwdc4ZZ+Jnm3Vq8sFuPQCTo0IT09so2uHjUZnUVV5INjgnzkm5/GYv2jl+ld8lQqpVcpQZhhcPh3HdufgSk2Hi2DqWmwShGqxbDPnwxwfzd7ByGZELW8xlvZIZjzsAWNsRGsFCVXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hs3jVfy0gZNL4MqrSAVklCpm44/cWSKS2LPSxR2wKOI=;
 b=ZnvQWRfF2uoPZJEvCgJUmOV8GSQGQsm/PRucNJweecy8zgIc65ZNzF3plEDWK4M6hmbppCKkF0FSIRhWjp2u6eg2FzVdkMbjfHVx5lHOJKjfjqoSAzg1b6y9oVCY2GxET3eCl7vpe4btT0zMhKl44i6yGWZJjQw3YBHJr4Grylg=
Received: from SA0PR11CA0152.namprd11.prod.outlook.com (2603:10b6:806:1bb::7)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:29:12 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::f) by SA0PR11CA0152.outlook.office365.com
 (2603:10b6:806:1bb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 14:29:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 14:29:11 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 16 Oct 2026 09:29:03 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shaoyun.liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: disable mes_dbgext by default on mes 12.1
Date: Fri, 16 Oct 2026 10:28:57 -0400
Message-ID: <20261016142857.361881-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c536bf4-76fd-4019-7068-08df2b91d8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|18002099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tstBq9ZuAZXRxMUoW2PcKnpmYPG/oNTppc8fw5XPkU7zWYjuciDdbu6iYbbn+Tg+pKdGvZMIrh4hInQvyVPnRmds5GcRJOom+IEQ5bAz2jysge5UQu87b51YizQaz38bb1uZ3ui6Pbtpoi0vik0/yAsv2rYde5fAhoYtd3jxzCGmkdAmmwRmnC17eCpCANDqS5OjfY3JSCSblNF/X40d7VyP68RtVQrn/otoH0KVvPSG4x7rbKPFVVFM0KrNlOYOPIP+J5mAvToAQASPYmEKMuwEdFWflkbuUqF2jfgXfEDhdy9XyslFW6Jc6sG+5zCIk+CUpK5tRlNrD+zUWKVJdGgLxU/96UmhVQ8ii6S3r3Dub5cbisLLhoLjYYOKhPaaMTE1uiWGKdA5LgGTeL9yE2SBONIFSEvxQGvawPq99JJMTnv43K5E4BbVFfHQfUxnphbQXx1wg3UiJ8sYT4t5iVb5/Xha96xly/H4Ss0qEGggpBVHF4zDGfgRFKFYmfeeO9tga3B7MRk50OtVOHqZu1lz4Vitwq2xab2fDJSskvZpIrhQt4lchaFPT8/WBuVeY1p6fvc2d0agezQszbjMQHd14Q7G357yEf3MDTa/a33yOcTdcghCYPnOOSDRLj0caY45BQKjUTBSqGH4MXsq/JC1I3nBehHwodVvu5xUB431cVOdBQ4x6cudh+t2TupgRsQqw6a03wcIeISo1McOMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(18002099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a/O1zNEtUCm9fE97oMHpbTdVTxxE8OGtEc3YzvcpRXTnwacK3MGWZz3ZCj30rzvTLmu9jL+bKIgw/1ylB1f2ci91jYeL6Nj+QvTIQhMu1cnQB5N51/1Xl3FRC/y/7i89TFqUFnvEIEEaw1wXj7yehOz5E7ZUGtorkCqTpw9lba2WQF2+rqB8LKv4a/AteRUrzSCDEy1BOmm53LQifHHcy2NPAGvF5ayLbh6ZMKX9dVwi32b0wXe5AbgrEYmjM9yL+fzrKwbkaCxjjkvMP/UBzDZm/ROCdWeQWcGtZbe9URX04x15FY6jYy7dnrD4la1of8UOgdc+QMcShnik2GEcEsDCJB27PcBR7P+n9fFyxdMEpB3/rhXKPp9eoJHdWF4sLisry2CgoAZHYXE+ABT1du/7PVNko5rzo/zjXtrchp/CKhcY0xLD6Qt06xUnNEZC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:29:11.8569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c536bf4-76fd-4019-7068-08df2b91d8e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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

mes_v12_1_sw_init() seeded an 8 KB dbgext buffer,
so the log came up at boot with no module parameter.
Leave dbgext_runtime_kb at 0 to disable it by default.
hw_init() still starts the log when mes_dbgext_buffer_size is set,
and debugfs can still enable it at runtime.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 65adbf5541e4..a31da8d12fb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1583,15 +1583,6 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->mes.kiq_hw_fini = &mes_v12_1_kiq_hw_fini;
 	adev->mes.enable_legacy_queue_map = true;
 
-	/*
-	 * Enable mes_dbgext by default on mes12.1: seed an 8 KB runtime
-	 * request so hw_init() -> amdgpu_mes_dbgext_start() brings the log up at
-	 * boot with no mes_dbgext_buffer_size module param needed.  The
-	 * collection mode still follows mes_dbgext_options (default bit0 = 1,
-	 * interrupt-driven).  Both module params continue to override this.
-	 */
-	adev->mes.dbgext_runtime_kb = 8;
-
 	adev->mes.event_log_size = AMDGPU_MAX_MES_PIPES *
 				   AMDGPU_MES_LOG_BUFFER_SIZE * num_xcc;
 
-- 
2.43.0

