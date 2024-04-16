Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC5AC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 04:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85D510E889;
	Tue, 16 Apr 2024 04:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/IlWvj5";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E39810E889
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 04:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7knQDBJ2CQyGyXJ3W4g+HDtx0fh8SyPZfw+pco9KoOXbiK6MwcmvboI5IzwdBHuU9i0CNfm1wwjszOHXn8y8/BtOyHYtxHNM7uuVtV05UOg3ALnW2pME5+qkjfv+WPCB3dNFZLsk+bXidnHzU5g4p51mZKBgEPoCUm7qgal35xZjnrPnpovGdudJomZa0k0LabKbpgk3AABa5168qGap/ATB+PH9X68PBuJKv1p7qCYQNGr3FLFHlrCY7IDJ7TbNUB/p5sJzHZJcW3nsyeBEotS6vEXBz/PBQzeZ5vU/1hg8WaBEEcPnYLufRCYBHevWObNEYR0f61wa4uBm//ETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyOgoyY9QoXjk3RUfmIKSDjbi4CuE7e3gzIhnNebCIc=;
 b=YkKTLVqYgGII/oq1XNFzPSOgidJzTtT159cR3Ct3Vv8pnnPgmP1u3GOPaWw6fmSXPrw0J+skIP5tXPSLClWpowwGW+yNtfr8s93iwS/c2kmcu4Vgis5fV3UqU5IRYLmgsuu9bA1xBMmpDD8lOnzVLz4yZKGNteavg86EvSsa7y4py7kd0p/5efCSIpsxDsE0IlJ60cx8dwWbxxJg+r3YcbqT16B0Xx7Ox9k34yec4+0saemnxsHP1gfQeGEZ7H/DIoue+wleGa2Zkh0RAithJjkVVXcRiCyq98Oo0r6VSSN7LCOErvsz2/j1ZPuCdizjYC0sUz5NPw4ypitrS5OLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyOgoyY9QoXjk3RUfmIKSDjbi4CuE7e3gzIhnNebCIc=;
 b=k/IlWvj5b8449ks16Ac6V0urgcrUi/z1w/IifGxTAD3Zd6h9f56mS+7DAs6cGElmGuhSluDnc5eLrp4eDxLr7YXBUJaG2Mk9FBqpNHc2DCVRzb8LD+6S6Cf1zUXkaj+7P7A1HUi6GG0014K0cXj0bTuQeM0uG1c1e5wKi+TDh00=
Received: from DS0PR17CA0018.namprd17.prod.outlook.com (2603:10b6:8:191::18)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 16 Apr
 2024 04:34:12 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::23) by DS0PR17CA0018.outlook.office365.com
 (2603:10b6:8:191::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 04:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 04:34:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 23:34:11 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:34:10
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison handling
Date: Tue, 16 Apr 2024 12:34:02 +0800
Message-ID: <20240416043402.987-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 321c6713-8eb1-45ac-5053-08dc5dce7714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjdCA246cOSrbZTBcEllL8yVOCpTfw0XNZHAnOX/rx4oAfBwjGhE5y9T/XKrorMioDTvAwuGCh0o3waZzSyb/cryJ3VZMW4h15ymYXAas3PRkLMVSDf+HvlS0WUPMp3/vpdDhTnu/sRIIXyJaJp4uQAMkEccJ+Ii5c2B+WS7uQtEo54V9/91g3D91koBgjoLNpHZFZlDt1dQOl5r58MAPIT2L4BiAv1CBv0y6++TJDUvWH0kCGFiVtSrMxNInYJEXdO4SNOv/dfspxvmbZQhEbxkGhRzBrzutQrakllsKIokvkXqE6GqMQ+ePNLtQyJtaX/eakCGLfyX+qOwh5C/QJUTS01oCtcipxHiakmP4t8WcB/DAZVlTj5a5TEnM74pbGzelwlVkbkI4z5LuACQW+sqpD7T+zRtQ7NSRr5JxnaKineJCojzbtahadOjRvZtvr9e8PpE9ZRyoxqIq1DE8CGtPJAFiChcdp5z5OCNXFy+D7XPzCHNvzoxFXLtf8O/aDfatkrWVU6udf/AZBWA7tYY3MFBduDiXU5KaAGvrTAEBJhAlUXBcTdVaI1RLnNB7XTKfGRD/8sdwU7BfA2ZwNO09lDvpp3ekaMA/Md5JSAeN89SuWEYH4GWcicLWeIBhllISchKhE/ZcH6eLbXAd6cvsEFyyH1I4XGU8rkWqQvbObM/IUJfykn5/ZWCeAV+JUjz58n6vGzK7bBjpZSUMNzW7fmYpNwqow7P0PKwfW+jrgX5D6jmWCZMxZu6oUP2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 04:34:12.1296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321c6713-8eb1-45ac-5053-08dc5dce7714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
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

mode-2 reset is the only reliable method that can get
GC/SDMA back when poison is consumed. mmhub requires
mode-1 reset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index c368c70df3f4a..b6caf6eda8a0c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -163,17 +163,13 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE2SH:
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
-		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__GFX;
-		if (ret)
-			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	case SOC15_IH_CLIENTID_VMC:
 	case SOC15_IH_CLIENTID_VMC1:
-		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__MMHUB;
-		if (ret)
-			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
-- 
2.17.1

