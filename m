Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89039CF885A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 20:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B98110E9C5;
	Fri,  4 Oct 2024 20:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aGhSt/9i";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A4310E9C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 20:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrcVVIWuMcmdE6NBp20Wc8IHcG8Wd4k//74J87+BrqGvo9wqSHNyFN6X994xbQfn9gIY9eHmfX0ZbYKSpKA0m/1ojeb9yRk1f6hIGxr7vJDXbvd/bnTG/3k9iB0I6+n0M9jwnLYCPaZejzHRxOICg7c63mHXwSXqQRQ97muunzwP/cGL0GBopmfcY6ipU7DRtg//+JRWHvv+7suryYwzLPtr7l8K5/qxYij67PdXCrs90NpaEqkBxfcc5Bvcx1Q4LixE6YZ4KRVwaxQguwvUYn3c2PNnUiZYACtiG/DNnD/Jd6vOjB/X+xIpdyWbITpxnzLXh/x9uWDvXNUa7AW03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzB+TVfRX2F4WXjJYUO65ZRQQlbQCidXxw/aLJWBSAA=;
 b=NpD9MmvTukyZLW5qvfVapMLx6bCS32vr7JKuV6zjJrb9MTuhB3w589rTEQJuly0+PWPQ7qbPHSScNNHtSBySQwF8Nj05iFRb3PAkuP8TUaYQjiYAJCebSm39e+Fj3lWgWu5F7ONCg21hGI3FN6uW/DKsonWzyB/gSXdFlZF+wOtV65qiXFCUg028ZKy/xQocGyCOSPDMBliT3czyutI5+RC8+sxUglxokkuMfqjD/oYEFAr8T32zzxx2vfiF4EIjutS5QbvMHCR2JVNZ8KXEBAyjDiiipJIHgALEdlOvNU2zcYwINBT+mq/iQvjtQ4mgBWz59hp5sQqELyoOygY3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzB+TVfRX2F4WXjJYUO65ZRQQlbQCidXxw/aLJWBSAA=;
 b=aGhSt/9iFi4z1yJ1ouUXvWgkL2lkF1PImAuEWKwJ1ldcrg1R/iPUeeyuYcQkvuMnhN5cqbaXugjJ3Oq7TCVaa6ZP9S3446W7vBpbk4jeDw6ivwIt0iiI25GmcrfTiDVgU7UeLCH69OEIWx8wAjv9uML1Y0Pk0Hk/SiEzjocNVO4=
Received: from CH2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610::37) by
 CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.15; Fri, 4 Oct 2024 20:34:07 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::25) by CH2PR05CA0024.outlook.office365.com
 (2603:10b6:610::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.10 via Frontend
 Transport; Fri, 4 Oct 2024 20:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 20:34:06 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 15:34:05 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <roman.li@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 <stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: fix hibernate entry for DCN35+
Date: Fri, 4 Oct 2024 16:33:50 -0400
Message-ID: <20241004203350.201294-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d38c775-c9c3-4b4c-ec9d-08dce4b3e4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rkXfMxsp2M7a4T/82+3XZwU/5GVNsCARZYgvVsPFiN/XXihYWvBm/jrCKlgH?=
 =?us-ascii?Q?09m1oi2t3qHYxt5575dMVBhewbfHdGmewYCYY2tlXgphkya9x22gxH5DiABu?=
 =?us-ascii?Q?4B0NS/GElH4S4cSkk4nViTvK6OaFmfRgfFNmIAiyblOWz5RNp8AQMaIuDtlq?=
 =?us-ascii?Q?4cKL2fGXUsvgBg54rwMbVvsiPgMC7TKkc9ILmKpWVGQKLpJapu/uAhE5u0fP?=
 =?us-ascii?Q?NFe+EH+Znmn+p99bHqE0MjkvyZH41/MQ/tu0BJzTn/eXtYQyZ7kWST6MZBxF?=
 =?us-ascii?Q?Uer0SagNdXEwUYdwT+4eqPvTsRFPYlhUd890lp1QcpVEj6Cn8vsSYsRxmVn0?=
 =?us-ascii?Q?7+duqaCC1Vb9T7U8uinuNRftnadn9+k/AdI8EfHDExHOnmaLOfW5pE+UN50S?=
 =?us-ascii?Q?IKx+MbG+P6vGTpRQUSex6omwgWw7AZ7k1uWAi6h7Nk39E6I7dbKiAHEIU/bK?=
 =?us-ascii?Q?0qQ27KqcePHxmm+6M2gvHJ/uSCa6MMIjFK1g88Qx+HnO1dIY+1TsyK/PV2io?=
 =?us-ascii?Q?njlDrduKmZJaP3rNakCifFQSBHwau1iVA4uOGdC6OLkeihJwPn95qw8ZMXwd?=
 =?us-ascii?Q?U0C9zEZ+4XvHZ2GI+dgxhOg6UiOoEmKxkvwEs7eAyScBE+lfO9m018QiqHux?=
 =?us-ascii?Q?WhMfQDmB0qzGUGj1ZUsFQbITQvBx6ZuIGRs+k6uzK428u3hliGq56O0sEcFr?=
 =?us-ascii?Q?MAe/cmyn8Dpt2fsx0qtfujvBR8vUnVcqPzB/1M7rcMqwjHEawGPeyrtfU4Uw?=
 =?us-ascii?Q?6HftEr1i3RvHzHj87eCiaTVxSveVnKXb8LS7T7xLOwuyKOxk2EiifBvYho4e?=
 =?us-ascii?Q?91CFjJDBK51ciyNlqETmlBhtJSwOzOkZf3igKsPcM7+gZouWYzeEhpVJ80//?=
 =?us-ascii?Q?eGN6Ul6lHrfLhyjDDM5n/vBg4l5Cn0qnln45Zm9JwXeO2mwfPzTj5K8Iy1Cc?=
 =?us-ascii?Q?TYKLqrFTaYnOwejwyo9ipX2wLmRWY3XrhDDT1Sb3SlHGQW1LjLEi0kSH4b6z?=
 =?us-ascii?Q?ZYSGGQgKbDClZ+Nhui5W7Y9777DxO+fD9JvdLd6bcMY/omtX6j1zW5Rybwvq?=
 =?us-ascii?Q?uFuSG5biN8V9/Puf/2kx7cfHisr1IA+y7IOp4oVpoVvLTqBqDmy/WZzUL0DH?=
 =?us-ascii?Q?GfIl/8XVOSl8iZdrs3cae1NlxE5KeZWO+2m4RgS77TwQO+z0P4tY1WNBCVpM?=
 =?us-ascii?Q?DRZ+gQRHjxah2qyQPX5A9Gpg686p19nJJy+NPjsDmXlLNtqQevZdd+W1QOMB?=
 =?us-ascii?Q?gOobU2X+KVFYq22tM1EqLVzGenDs958NPGh9pIV+ENeq2021v9T2D0bO45FS?=
 =?us-ascii?Q?ddBxa4eNsLGPtnr9glCxDgyF1QkUWlnot8pO3ESNkFFkwN4UbWf7JAGLItoe?=
 =?us-ascii?Q?P4oXRG77ho9Tq0PWX1CyafpNSjSg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 20:34:06.9579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d38c775-c9c3-4b4c-ec9d-08dce4b3e4e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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

Since, two suspend-resume cycles are required to enter hibernate and,
since we only need to enable idle optimizations in the first cycle
(which is pretty much equivalent to s2idle). We can check in_s0ix, to
prevent the system from entering idle optimizations before it actually
enters hibernate (from display's perspective).

Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4651b884d8d9..546a168a2fbf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2996,10 +2996,11 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 	hpd_rx_irq_work_suspend(dm);
 
-	if (adev->dm.dc->caps.ips_support)
-		dc_allow_idle_optimizations(adev->dm.dc, true);
-
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
+
+	if (dm->dc->caps.ips_support && adev->in_s0ix)
+		dc_allow_idle_optimizations(dm->dc, true);
+
 	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
 
 	return 0;
-- 
2.46.0

