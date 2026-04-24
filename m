Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C0DFED3CF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 14:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152E310F5AB;
	Fri, 24 Apr 2026 14:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bHSmEo89";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE86510F5AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 14:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6o9THTAgN5LWRkRYgfaP2B2g/SIwZJgVEs6srvVnZ19fSGDKuS9sRxBdG4k0GEQoBYjXEGKnPb28V+pkiBK4CW2JlylKTJ7mOohlS8t/aLtf9uiIuteBIJKaqiFTQYd0LXnmPcixxbHHkYFVsj57UZu9IGgd5tfePY1n3RQUdHU4igtUsYOcYQjhpdigfZ7pdhMAtpNH0v+eCFpvib8/mbMPoonZPw1kxDfzvBEJqf0IQVoGfz5He25gLqze4dW3tKEc55vTbaf7+HR+AkL6GEyqY+dGLpPyLCZziv+paHAMLJNJkSomra+Gydvtyg5RgqII5sWREyBwQbLpJUnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh2KmHrJ5KxYqszZS37eUSeQG1ayJmSsNNExbgonRo8=;
 b=wHLVRSuR4mhIrDk1rUkgkCYo4wegAlqtoYMz1T75tLnNMROn8VTKFutrQ4nLv9QQqnGKZcBhOYDqtMJcGT3pRIKn/S80MMwy+xUEHI5ZapgIqpDHJbmX2v8fARavS0eoq1aRQLFHBGdLkM4dzvl5ctcse1NVPWaEePuQPxhJFnMJZznEguYUt8xkH9iuNNNwnb6cFuARV53UiTQagJDweKgyCq5LRGl/vjQdYDYyR44UcJzoZSWZvcZnONphlwQdXvP7cy9gkZklzEd6dcen9X1iPaJ5RpPxNkW6n3X9x6aqzy0kyyFtaRx7tDVHJoP6e7TQEkElAXwUwZuz213PrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh2KmHrJ5KxYqszZS37eUSeQG1ayJmSsNNExbgonRo8=;
 b=bHSmEo89SyA9/+v9wOojJqQybdTPBwTLATWCWA3ulsBsUyyE7YJZzciB0+i6MayG4MkLhbzz4p4CuAtRxeem4WE/2Y65EUOCb6l8dhxcbZfDU84Icj+KYUE2Al+keoNYc+vRq+hWdHG+QGipBLJxMzm1YT/4s+jMVgqIFIzftHI=
Received: from SJ0PR13CA0177.namprd13.prod.outlook.com (2603:10b6:a03:2c7::32)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 14:08:59 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::48) by SJ0PR13CA0177.outlook.office365.com
 (2603:10b6:a03:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 14:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 14:08:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 09:08:58 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 09:08:58 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Shiwu Zhang
 <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH] drm/amdgpu: Remove dead init_mcm_addr_lut call in soc_v1_0
Date: Fri, 24 Apr 2026 10:07:33 -0400
Message-ID: <20260424140755.2500419-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a17c7e4-21e4-4f10-ba3c-08dea20b077f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BCF91v4ZbHLWlZ9OPMb3Bt08nbxOHWFLI5SPjPvQMhCRbABg5vQjF/01Wy7aWFo48vLTV5kUtM3mj1j0O03uct3URoRl8qVIMgzhyhk/ufd+1ZCLIogCfiL4dtl2WdSGok/JFy7xZwsBDWlGP7lTpH09oHEOshbkymhtiP+sdlF2X/3D41l1aLW+G6HZLyjD7KxIoQhKx/7NUzDi22xT9iGBLIrJ52qK3gysQ4vkYaysZispceYVx9dfHyABvNmoleEcsi4DEkDbQ80PU35qZnslqOJ368IYGXG1VE8H/7hkYag5IsQ9brP9IFG2YxitnP+J4131Gzk8CRUb+stBQnHXmM/ORHn7+zXAu3ISwE4eHha00F2Hc0p56+IpAcGN4mNwNAA5IHId+n2lfb/qrgboiEgiJJOhEduq/D48/UvbtlVwSsYTB1Jb0Fb8BH3/ldLAhrX54ew670dan5fvGljnNZn2nWtZTai9TVlbVFx5syxu5IN+jvEfR1SPIVX121uSLNqk+RRHm6uyc38zGtk/UpMxvZeklKY5tCncGxW2omgidombKAQm+cm7SEXD78ZlOtRKzxqtAuxjephXaUcvVi2L/xxiCCPgyjZ45BixxHKh9oZdP34TvE6dnO71jcLcFfZrbyKiihsKfuF/yBfJMkalZmDW4Sk4O/r+kAtvPgTyGLySQH1v2TmOgcLam8QY5dsqyfXMMQvR3ECpnGyfhUTXXs/tBooVqe4rOrjlwBtRZgXGyKoCMOCLggPFO+7QvSd9xSrikKRwZFXGiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cmc3Eg8ZMoCoAb8GafS9DWgm9M0w/g7BuZArk+WlIZUKKjWv0Rm0Xa8gPTBlK5ctpoT5Fi1oCytTvhcpOjoOZO8IMByooc9xyWtXnqEnRxDgpHI3Fl4kEK14pRvaj5zWKPfIwLom1REOQJnsjxQkFuE6PNmISF/jiM2m0JRQxsl8TdNo1UQs7K4HLuhSbCCahrU/iwxESfy4VLn6DOBwAoCaJATlMup35LkW10matBeJajtBNKP6dt1EralcsyPS+R8aizJNPy4G/XqmFVz77TP0ixg9Y9uhcL0mUIHVIKlb/0fFAzQVMa3S4kmYAQPw3OybA41rqYwARR0yFs5Z9p8bCNjCBWY8nkTR0DkDrPhza3n5RgYNlDKB7Uivdhe2V0GuduiJBmVpXbGmzJktPfodsm87+ipAzXPK/gjgWpyACAEgFLqW0lBazB3EDlmb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 14:08:58.6477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a17c7e4-21e4-4f10-ba3c-08dea20b077f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
init_mcm_addr_lut() definition was reverted from amdgpu_imu_funcs , so this
function call causes build failure.

Thus, remove it.

Fixes: 21bd78c821c9 ("Revert "drm/amdgpu: Init mcm_addr look up table"")

Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index d06953c237ed..f09d21738400 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -744,10 +744,6 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		if (ret)
 			goto out;
 	}
-	if (adev->gfx.imu.funcs &&
-	    adev->gfx.imu.funcs->init_mcm_addr_lut &&
-	    amdgpu_emu_mode)
-		adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
 
 	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
-- 
2.43.0

