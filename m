Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819BDCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 12:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4926D113309;
	Mon,  1 Jun 2026 12:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JOSGRlBZ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F46113308
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 12:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Im+0s55j3/+fib55uGQpiynOox7VK1emwmKT7eyrx6EKFcyvmNReu6KEzjFwEdTsAq9QUKab6tt4QCE5j60hAOHUuHICmk/A0Fyi+k16maZGLWwCav40VC1HhswyVenm3TRl9r9BpzipNkBVKBqyyxkW2q13+uaUfVLN6lzpfhemUqXbmc2m7FxuCr8Iga707aaZ7ky59UtRtjP5SvU6yvzim938eI9+UAFhEicaiubbEOR09oGLbmQ7ngblY068XbIgqSXQO2f5ijpBxKwMviQOfuo0nVURgM6f/KJGuaiN0/IiZj9XSbwHNVFyNfxEBv8WJYaZul8Y7A5eQZKNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChDtDTKqHBA6ZnRJ6rC8yUBaiNsq9KWS0CLntg79rZE=;
 b=ntTkFfLdnIs+mvEKJgGjbsaknuoY4Dvafb3cMs0tjcNo/H4AllgZ2H8/Lwx+O6pU3D6opEK4RQs8pgxdpKyPY2tNgJG9LrEwuh7WevAwh2m4WxTWo5hDKJ7oxKHdZ1nx/M6AE48q7IrP+2YqyE/VynbkphVq/NPCMW/m81UGiJgCsc4OYi2IcQMj9QmeV7Btbjb7f8EaruPPl/ufqOp2QbAULSQj4gWLiDXHri/N6ShtoxW8CYcNbFHeCAa4bCCNXtwvCzkqdRlVMyF9IjptlAp/pNclSznllfCHt5wImaj4UoM/fH7I4GlRZtBQqL0JiflYAUhzLJApXFqur1gDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChDtDTKqHBA6ZnRJ6rC8yUBaiNsq9KWS0CLntg79rZE=;
 b=JOSGRlBZMu8WKszed/SKMyZqceGjPUQt60GpoYCfBFAPLX7tE4SevUCbjJ2hNP/nicQPzn/JbYgN4MWHtv7+4zVfraeNLuxVHLfT/wxrdEO4+hDWAGH86Qk+G10oHfbumBsvkIKKzzf0bksoCq49kPkfbzFY6aRGBlVJlUCnT9w=
Received: from MN2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:208:239::29)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 12:58:52 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::4a) by MN2PR08CA0024.outlook.office365.com
 (2603:10b6:208:239::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 12:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 12:58:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 07:58:52 -0500
Received: from drvdevbldsrv2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 07:58:50 -0500
From: <vikneshvelavan.v@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <leo.liu@amd.com>, <pavan.ramayanam@amd.com>, Viknesh Velavan
 <vikneshvelavan.v@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: enable secure submission on VCN 4.0.6
Date: Mon, 1 Jun 2026 18:28:41 +0530
Message-ID: <20260601125841.4001289-1-vikneshvelavan.v@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a49938-240a-42a0-a98a-08debfdd8826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: nS7vLI0oqFAZUquW3itvytuoZ6XUWaoRU3T2PDjhdNf6Lri9rvdGoRWy1P4J3XeGjxyLbW3vtQr+OV71cB7ukl2o7uy16az4Jop9MmCWyTSg3XaRtk8HT+lpVCvaPGr7YLfebXWosBdQK1XaLBumeUQxE3uraOITRT/JhThdxDxPlJiz/UYbmxMk3ToEfhMNSggp7wp/0xzco0ocMzRMuIRYysIFCMp88V4JldEDjuZxWRDBR+uAECams7v2VyRjoIBemXPrwtaMZM5pWYeRzdjGM4ISDEv9VtfJeUI3O1ahrd+gb0cLqEbZZn275Q8TxYvNa710Yz66OQhf88/7v4Yp+6UQfP5yj9ofdAdxiONNFOjH5iZEGZOlREEz08aGgozx1wOHCPJ+W6RLxxlSpYLZBlWxH4hDej9wizYGQi0VXm+z8I7xyjhszdmXyXK5vmJVHAwzFpj9rvQZAcBEIyOXzENyuuL6dQ0MIzt8Mf/sQFPdK8zW+kF2B5kCtK8qkV0MwuZOnyOT9WqRW9i26mVJjJQaNnGCzh15ou137M/fB5pUypkEjeGiiLSeRF6NYrG2ZGTFCaDh3d/USilJTjkOz1HMi2IahKiuFztcnV+g0eKsYmibj82ZR6sFdO7WGn3W0QEy84ZhlcnTym5PMiwVQGclVW+IwXMWdxUrr6mgPoylN6A3dTQ1k3dQSZ0BdxvBynea64goUGT77vx+5dnbJZEtuWIXwmksMbHhY7A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 04gEZwzhxFItwhieet7jEbRPzowXmI75PeUSHPethB215cwoPAzPl8D1UfuAIpHAkQ/aT40E8DBQcna+fS+5E348+tdt8dMAUbOoyBz62N2IBioE7+qYANRV3sus96uupVAtanYjTNydibufx9X7ONVl2IEyD/RoAmDxjaDziaqR1qPnNjFJFLIKLPecyAHfFxTPqPXdnKg29xpqFT8bCWeHUZy145ShAoIaAcr/d5jKij+BAjtUQULtJysI+y1uYMK0bGWNYmppY7//UHDjcRATdp2ad2VqnjIPl54L8I1peyjchY5G1vMkFwd0CJ4IBwfY1kSxU/xb3iVBCmLQJenp+/ltCMt6KvU7dvZbyAFsb3kDfmFCFMTSXm0Zvnoajk2nGpLVoHAI87//T/l5/MEHOgyCeHysBgtr+SUjb4lxXcksCjk5naO35sefSH/9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:58:52.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a49938-240a-42a0-a98a-08debfdd8826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
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

From: Viknesh Velavan <vikneshvelavan.v@amd.com>

VCN 4.0.6 uses the same driver as VCN 4.0.5 but was missing the
secure_submission_supported flag, this prevents secure (TMZ) decode
playback.

Add IP_VERSION(4, 0, 6) to the existing check.

Signed-off-by: Viknesh Velavan <vikneshvelavan.v@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 621f21445626..e44486a2d081 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1491,7 +1491,8 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 5))
+		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 5) ||
+		    amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 6))
 			vcn_v4_0_5_unified_ring_vm_funcs.secure_submission_supported = true;
 
 		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
-- 
2.17.1

