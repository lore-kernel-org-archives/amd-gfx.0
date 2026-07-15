Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098AFC4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9915910F0B8;
	Wed, 15 Jul 2026 13:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H/izhMbr";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EEC10F0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWmpOBwBqcWrtYsYGAg/XXYAxpjG6ScAjMiGPjZGfvUIFFNShtsxdvboerQLrxIeCy5Y/ICzyo1+Xm32CIxGJZwSuVjCpUov4b5NvBwgOYQCy7YXkDoeWct9Q3XlblCq2hHYYhIt2jbHpuRjfS+WoN0jWVGNL4KCzSZp9PuBFnPvQmc6s3i7anUvzt/J72xy6DIcg3hKJVzNgsNeAAJeesZLwjyT0xmECMyTIfqCEJOKRh7VfXOv29FSaikZgyBKk91ybUZJHqS7i0u3EFijWPHyQDPBNemZYiakNaW/QvyipLwSyIFs6tROTKwVVfbS0U0XZ6OrhEM8ZUQZD3tkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nls9xqG58reuQqL/ww3FzyFYBZeaDDLz9CwwDRsvx20=;
 b=ZWr8qfd127jJAETUli65tlkixC1N3StdfSJD9KlVrSdWTXlzorHAPNY8GyTH2Wz+z9oLZLEbUhWkSSXbXnfrb/Nj+s48TDoJ7OFtGnP0IHQ0YIaXIxK31ebJq+Nr/r/lLkyx6XneFqp08+ErHuSMJMD/HyOJZ0N3dYwibJXTndlsIrV0+JrGCFzYlKHjdIMzQG7iB2SKX7z44d6CtrpegfRtAgkmYvywnluIIkJf6eaqOpkFob2+c+WbasVSCzgBkiPE12U8R6a7ImQLsuJmgACEM8sWSc6a9T+4dNpTspQCWNhifw9Dp4IyUvQ7Epft3lTwsGYFoUvTnD06givPuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nls9xqG58reuQqL/ww3FzyFYBZeaDDLz9CwwDRsvx20=;
 b=H/izhMbrN5s5ZBQYqykCFP1TiE0X9JFr4NYRRqnytUlID7iB2kEQBd+pg3xYEfhvXeXekb5fQ/QBCrVh4E3RvF5A+SHhg74lepfn2jH49wAYl2tAvHkIYJU3Ti85Npy3l00F+/FxmZhr6E4kbsp6h/vgREVkcLBV6nZE932sq3U=
Received: from SJ0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:a03:3a0::18)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:49:26 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::b) by SJ0PR03CA0253.outlook.office365.com
 (2603:10b6:a03:3a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:49:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:49:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 70/70] drm/amd/display: Promote DC to 3.2.390
Date: Wed, 15 Jul 2026 21:38:20 +0800
Message-ID: <20260715134432.1975118-71-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: f3377415-e106-4c87-38a3-08dee277e231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: H8uyqqLJ/oSp0d8C4kAKPwHoZX5A7wuotJlqEFmhZx4h7Xr7Xa3w6WpmkIMA8fR5kuneMl6V4Ala9nTLC2gcaNfeRNzMAeCDUTegRlqlh+iJEZmzAXff8uFoSvdv3XiFdmdf/+e/xrwijTHKW3MoK+xETwfOM3mRhgAXoo3N17J3WNvjO7jR3Q9vp9uKQe91ZOJwuKyPkAPFAPcrsmqhX8K0pi075LtNLlqiq5bA+UlyFf+oKV0CxQzaqPKRlLywcmxz+KpG9HIDXob+AL/yQdfrTUbAN3SncvScMNhXM9SjcZ/YsAoBlEzWiVJ+ZqHtcSavzLr6+mKAuaA+l5mxI0DD0+WXwwd4Wcrf8ezPSAZrVGgALpIeG/g86ahO7byzBhiUtp0eL67hodaRRJ7dK55bvX4PW6i0oRuw4CR1uDcutIQCk3vfW11M045yFQrJNvVXEllr2pqgrO34oVFOTf1kvcjyFKKV8hMZNaS6G+BI2d4ZVwVfbZIWPOSHxOEoN0c3EdyxR9o2daMzjzKMH/GEBiySoKkhcRKupPSyfX2nFcd+s2K5jubA92Pv4GhAz0zsJS6OUeydnOHTlDUYmThuh2FKjndj6mB9SmyAqCumOVSKn4RAOmRdKr/u5YYMFvlbGOamOO7eqIouQJT6mIklkpHWY2lC5SSO7DL3UysD8rETDn0+UYeESIXX8S7zOS02ST6YHRGX8S7P5NMHiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3UYZ8NfFGVUnGi1XNdxYPtyT29qG7tyZOWnTJkn7Bn8E8juqXOh9z6+PYCiivKE++Y4midigQkiwgxvRushwXk+S5P7PzjxSBDqBewU4CQglURCZ/Q5ZZ2ZV8w8c2KDpR1mAOLcMDETm5uzydlolVbl5DdSaNe2uaOAeJ2rAss8B3Xsj+fSwehbM6WacLW3sjX5Qvvc5YRZJeGYsBIqUMl85AmxLVQeEfVSRf/6o2oTVKI5KfX0orw42x+WCqHA/sQyczpKgYcn313t2WJ3+owZ1VIdIRMBHC/r2iOoX0YBHJ0h3iSxIFxgHteZ94sR5uIaCoUoWA85d5cMEJR5WMH+KQFrxcLdnSDq9Ke2vCg0gEPMT46m3an0TNjU3BbT3o430XLM015UlZQIipwh9BXF+5TwtfNwUjhFtAIXe8ka6Zbksgdnq9iFOnJnCy0hG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:25.6409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3377415-e106-4c87-38a3-08dee277e231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Unified dc_update_state commit interface with dc_probe model,
  dc_state_get_status, and perfmon BLS sequence
* DCN42 enhancements including mcache programming, PMFW DF C-state client,
  and DCCG clocking fix
* DML2.1 writeback validation plus MCIF ARB and watermark/latency updates
* Color management refactor to dc_plane_cm with plane/CRTC colorop test coverage
* Greatly enhanced KUnit coverage across amdgpu_dm, connector, CRC, DMUB, and
  color management
* HDMI AV mute timing, DP link training logging, and Apple Studio Display fixes
* Code cleanup including DCE trim from DCN-only builds and HWSS refactors
* SPL UPSP upsampling and YUV422/YUV444 scaling support
* Fix missing dc_3dlut forward declaration in color management KUnit headers
* Fix DM IRQ schedule-work KUnit tests after cancel_work_sync teardown change

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fcaa17b9ab1a..75c06a1752b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -66,7 +66,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.389"
+#define DC_VER "3.2.390"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

