Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250A1C021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 08:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF0A10E8DF;
	Thu, 20 Feb 2025 08:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nMG75sA";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32ECB10E8DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 08:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWWlplUWftBHaWOMT4wgaYjEF1dKgmLuKdEw4TXxOV7HZE3m9wfj+4jN//q4u4iawflqkDhf7NLcv48MvCN+1Dco8F6IRE0nRonIR8/qybpIczcAkE4mUVL7nxBvfPXvSC0QGbnbW5GbUe/HzfeSOhoVbetSqRXcz+4JHQ5BbpXvqTt62X0DR7C5IELTGrkM2ky9NuuhHSxJaS6Qf+K6VbmMb036/XrMi73VwDg94lNUXZr4aM/CwJFylvPc2ply9g2F7UB/P2SZgQEmH2+ugt8IUZ2XLk//2+VflDrH3Wm49yUN9+T0A80EFKbcouW1C84XzyrDv2KwQHYP8PDEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzATw5XEPEAXOSl6IjMGuLoi64yoDhbsI9onAtZaI9o=;
 b=QhiQyBs0Ysv4FOueYKF2fiO5zKBhJ58LtHtYdYxMxO49rh+tsN6a/Q1NbT5/pzzLrrMWsoQQuN80UdV2NzgXYo/VV1olHliplHdd48ZmaR2AKvKhQ4qDTep4TIuJfYncdic3j3p7Lavg78ERhzXELyIG+9kZhsiX+56xxuDsUALXUjBU3XqwIaNsi/qhG4bjM4FQVUKyRqRZVBhoANwrNE1NnMnllJiv3HGkDcIjvRFZKsfeDi6hTIH1V7QbSiVbM0d9sN+nku/yfGPhodsQjI3pZXxhnC1380OsuMIcPjkUhmCvNgWNGm5E/16rzNlIZ7HbaSWEk2E0t563Xa264Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzATw5XEPEAXOSl6IjMGuLoi64yoDhbsI9onAtZaI9o=;
 b=3nMG75sA6Uf+Fp2CsjIZTIh0SvwdRy3ykY6eyohP+vqkp0xvyDYKp3iW0Qpx/Drag8wEjISv4TAbZpBhO5UlgzCHdESHayS5z0hNOZiUj9A8gqLWLVdqIWBmcZN5uLpuPcj3uKEbGvwU7pyuZ/wCaxzMyx9qjidaIm9vvbIfi0c=
Received: from CH2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:610::48) by
 BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:31:09 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::70) by CH2PR05CA0035.outlook.office365.com
 (2603:10b6:610::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 08:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:31:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:31:08 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 02:31:08 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Feb 2025 02:31:01 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jonathan
 Kim" <Jonathan.Kim@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu: Enable per-queue reset support
Date: Thu, 20 Feb 2025 16:30:53 +0800
Message-ID: <20250220083053.3834177-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220083053.3834177-1-jesse.zhang@amd.com>
References: <20250220083053.3834177-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: f408f353-233a-4dc7-12ae-08dd5188ecf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mtP8ZuCauoGLwrIfeYt/fuLue0k7N7o1Rn3gZlGIhdLvpMWWLcWg2xHfJt8Y?=
 =?us-ascii?Q?4lPCmCSkm0ZoyM1pa2UyoLVZ6KrPsmSHwohjpAXOeGXMrl9h7WmbVdDGLGPt?=
 =?us-ascii?Q?O5bjwCCfnhdd+uI6IYYaauH0149MUqUutQ9RP7UOueJclYBXwRH9/qmXjKnj?=
 =?us-ascii?Q?I44L8vsLzVbTP//ytQkrpP23SklBimIwI6YwZ/CzllxeylFMB4gl1Hye9VDB?=
 =?us-ascii?Q?k1Lff8M3vfj4yVRRpeQkbLPeJFuGGO020Z68NwJnAtSj5gXakQdsr4Fa8jBI?=
 =?us-ascii?Q?bx+PivSkIERYj3szB86+yZyL4jncASf3BKvDjvKeJTxPkNhTMwuk5bDrymnV?=
 =?us-ascii?Q?r6mS6KMl3aWRira6+0LcuukzF/4385DKGvRGoFlAUB+KMSQs/PTqXbnIpgKG?=
 =?us-ascii?Q?G+p6c++ax0KucPxsIFTC7ly3cNilspfLupvDPSxE7MqRbG/TFporQcCXQyGK?=
 =?us-ascii?Q?TAGiK1yieczZBwUZwwROOLmP4WGDUrot4EFLS7WWLSD/UkhVDLwd5K6Xo95C?=
 =?us-ascii?Q?vxfC0HPJFcGrv9OyqXWpHQzdz4tnxXsAE3ccBt1KQT8zpmvbq5tF6ICDjMZs?=
 =?us-ascii?Q?5tUv2cpc931VZCrjsWqH5Z51GXoO3X/4OG+y3oByjhr1by8MkmX9TDkIt3d6?=
 =?us-ascii?Q?IWbUbmh7KOzplgC97diZUO5v6L+iSjWqbcP+1N3oLcslCtRlKz4U8Se8xW12?=
 =?us-ascii?Q?f7d98aDnPv0UA00sWIShlhj7V29bp9OCCxtTTKdCjKWrimqzHWBRrRoMV2Vr?=
 =?us-ascii?Q?Lx9Y7m0vaKAXrBDoSG1NhrCUnAnhLjiyU8dkkZKg4HG8wbQJfPUx3J5aUPBS?=
 =?us-ascii?Q?soTsplaaOzH3TWKi5H1SovnjW4FdkDcaSX3+vAOdjJzBNVoNrbcsmjIW6gAu?=
 =?us-ascii?Q?a/4y+3+Jk9NUogpzpHw0inDI76Wl3EviwWqvzT1z1+sRJg9Cc5uYRWM7SPIH?=
 =?us-ascii?Q?Epu9AgH2lhBD+gl6PTqquQd5OKGnO4wBi0mzgxUnIfrGq8VzaAgRxnm/O4gc?=
 =?us-ascii?Q?GB8UwnWu29cbc5zP7Hc6Y+gPUlCFQChIZQo0oUob9uwjvG/NO0e8/qrixcl6?=
 =?us-ascii?Q?Cr5eusXfw87SfbrZkw0xRGwBK+KsMNljrsidbQKMQ3uTZrpbc3ZrvyULhdae?=
 =?us-ascii?Q?KKSxHKpdwMixsyRXkn8dg20ZaZbzmduqOsOgNWTJun+gqEhFy1A3I+mJ/gN6?=
 =?us-ascii?Q?gLLMf7st600XIIGOWceQn6kqcMbPhT2bFcwPddc6rEjAaIKWNV6vdzXw6cGp?=
 =?us-ascii?Q?VAqyvKFfIDArMJv8caCNhKZDr9Cxv63pir5FTrxhkHyXc8Kv5+ThHno/fhSX?=
 =?us-ascii?Q?tVWpwY8x9ZhzRRSSrFX5XetNKPciZGjbBS9eoi+2Fu6873OzY0Rv+Y0WI+LP?=
 =?us-ascii?Q?VyR4vgDouuA7BckeFfIB12FAs/uGRR7G00XIbiqs29hER9UIt7M1ND5Z6dZx?=
 =?us-ascii?Q?zfXN1HxW0mc8eP7/H2/mcAssPyA1MrxR0i3icz62ap+rES2qlc+burmtf+rl?=
 =?us-ascii?Q?w4B+A+D1b+ZbENY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:31:08.8296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f408f353-233a-4dc7-12ae-08dd5188ecf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

- Modify the `sdma_v4_4_2_sw_init` function to conditionally enable per-queue reset support.
- For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC firmware version is at least 0xb0 and PMFW supports queue reset.
- Add a TODO comment for future support of per-queue reset for IP version 9.4.5.

This change ensures that per-queue reset is only enabled when the MEC and PMFW support it.

Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9925b183c07f..0e004b156e95 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1458,9 +1458,23 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	/*
+	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.
+	 * it needs to check both of them at here to skip old mec and pmfw.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	case IP_VERSION(9, 4, 5):
+		/*TODO: enable the queue reset flag until fw supported */
+	default:
+		break;
+	}
 
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "fail to initialize sdma ras block\n");
-- 
2.25.1

