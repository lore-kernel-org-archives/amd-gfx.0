Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F7FC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EBC10EB78;
	Tue,  8 Sep 2026 11:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bzdbmr86";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0DD10EB64
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi0VomChIroSGe4YulagQYJGtIEGGNoSUm/B7TC3YZ+vCCoV0+6EJoLB8bsbJ8cGEWd5Dg5bb7IcwybLaZX0IEpSgvN6p0wgWsRU6YgjoexG/rGVpU3jXi5zobqrgMlKC9EdupwZk6xyatcV7dn6/FVopqDZoJPVDZLY/LBclPVxcRmGOocaV01r9yl/pOtaG1WqQlhlgu8SvYkq5u1rh5UVMwJLb2GkRDpudiy8UioZdZYdTsTH+k2ixP8Z5vMhdZp4RW5c2sMwSgjdmAAsNxSjCM+1JkPaqG7fdlgxmQISuNOPvEcwRovvXkLDmPGJkx6e5cXJ3SDdqlyuJI/siQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xduLiyw0NvrmReMEndNtzb6xoX+KY4MJOlQTec7kbLI=;
 b=sZztzl6y8oqktHTBG0mS2+PIPRyzVT6qO9m3V1WjKk0yxQBhu615jpiwdYVxzcEAIvyNaYdeK0YWW6FJn08b9MAeZI3DwKrjKBt7aHfntxlgr2c38e/PGmXhmSfjvDHH2P16DN2Y9rdwh6pz1J1foQor9iBwyK4W06RXk46If6IhMZeQT/ojA+3MLWTJulzgz9LwCVfHnGveeraaavJ0wDeQOCCCUOBP7H3meBkIFznUaP49+dU5BbP4OFDHkeOhA1K+rko5SmyfBuz5nwJ79cvrm+LylICnMzlVBWPUTou/t+3Xdkb9aQtvgzQ2+2lLgKTCVRk26DtKIjafIuwcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xduLiyw0NvrmReMEndNtzb6xoX+KY4MJOlQTec7kbLI=;
 b=bzdbmr86VvL4WEEJfR8vNacQAknLqLVF1hNlaQbizo8kKfRVCAVmdnI1sVrYLoGX4Mj1It+XLDZqnHw1/xFJ0UtMckts2KZvlkVUILifH/AhDz0rOOV+v4JxaDn2cIP4O8v7mgNCg9M3vIDgf4kA4KkGAb44OJfCXTmUXGGwU40=
Received: from BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::610) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:39:07 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::ae) by BN9PR03CA0945.outlook.office365.com
 (2603:10b6:408:108::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:39:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:39:06 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:38:58 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 36/66] drm/amd/display: Force DSC to 8bpp for SST DP tunneling
 over USB4
Date: Tue, 8 Sep 2026 19:31:29 +0800
Message-ID: <20260908113338.2433445-37-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcb8bd8-9e3a-4da2-9710-08df0d9dcae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|11063799006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QmbbJo4GpLPRZm6Tv3N15+axc6xftP2mN11mpgaP1aG4kxnKP10fJLTHDfWZvEAQYpb8SA4VcRdM9/NLXzZXlKRY3v9AUIe9/Q8+1DyliQleXN9NDiuniwXjGHWnRuu9tylLpkXPExttt1W9jynwwT8aVpYBEKu/EACLds6cVn6hnThZKh21T7VYAyxU5EdAnmBUbDcWfw4Drkw/spCvZ0IMzurlsVkz9sbe6X4jW2iXd/aiVa6cXY6iqh8xFAo/SniASGYkhZbKeLghUznUo75NGREwkdknPIpCK9gYs47LoEnCuoBE8eHv6oWFHi7LJ3UYeu6w68LLmbZ0+ixICcsOe7zXPdLL8FptWeBIXdMVqSbnGfbP8p3gaItMmqz/Jo0ot1NyZNAgHPByEnHi99z+XEovaeqjsD6yYAaxMnxNblAQpi4W6xjzQwq1irmlLr/XFrz3oi3U0f2OXE49wR+M+B40AyyblmRy0KhxDizzg6dWy4ot3DDPL0bk28V3o0cbfp/v1mbde4DG0pkS9tN2LKXv0ajBLIK0uYoLC5+6KMNoeGp0uyDhoA5/Rz4wOoZuMoue0+vasMsTJBxrD2OL8Fa3CRssj7kKmdFp1BNA3ddGVyrLloOyxmFXwCYzZaDGtWYL07ky63Ln1ilxIgg6OgcjP0LVOn7/yiKRyn9LdWxv+Z/CWbXb8LqM8gz50YPVXcWQgllGZ5Z7tVYDhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sBCIOASCA4cH0JPMAGSG2YSSmnnkGnyEJTMFEovZTQr3F+YelJI8v2jgKLUkEFGwe7ZBli3hW4/0kPd+WEySBHybEcfIWvmDT4SBZbRMRcoEYvQygucikEswzpdCdHTgiO8tScRDKfkrHwcPbgFSeVEnSNhaNfKp85QUMrdMBC4VG7QrVAYM8ULs/l6C5lQX7N6KOL0RWrZSqzLeUBu+CAVUe9YwIeEI+w9gQtC63KW9gCq2W6IWC493hPi/DLDIPsrfpr6EUn7DpZrlnt91P2l88AsWXjmXq9X1S8G8n8GMWt4KSWTKXVOVlQef2rMfNWrN3J3X86imXm2OYWMJzPwQr3j999YaZPx50gMl1q9zV2LU8t2hH3C4Piv4vaLdtLSf3os6XPBNjf4KWHVlqazrBktsHVpdcAopsECrQMy7Hd9XNwKdolsJ+jd/83Am
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:39:07.4478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcb8bd8-9e3a-4da2-9710-08df0d9dcae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

A 4K144 display attached through a USB4 (Thunderbolt) dock does not light
up on DCN4.2.  The native DP link bandwidth reported for the sink is far
larger than the USB4 tunnel can carry, so DSC is sized to the link and the
resulting stream overflows the tunnel's granted bandwidth.  The bandwidth
allocation request fails and the display stays dark.

When the endpoint is a USB4 DPIA with BW allocation enabled, force DSC and
cap the target to 8 bpp in SST mode. This keeps the compressed stream within
the tunnel budget and reserves headroom for other DP tunnels
sharing the same host router.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index c9c8db972922..9dfaaac2828d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1264,6 +1264,12 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
 							dc_link_get_link_cap(aconnector->dc_link));
 
+	if (aconnector->dc_link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+	    aconnector->dc_link->dpia_bw_alloc_config.bw_alloc_enabled) {
+		dsc_options.max_target_bpp_limit_override_x16 = 8 * 16;
+		dsc_options.force_dsc_when_not_needed = true;
+	}
+
 	/* Set DSC policy according to dsc_clock_en */
 	dc_dsc_policy_set_enable_dsc_when_not_needed(
 		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
-- 
2.43.0

