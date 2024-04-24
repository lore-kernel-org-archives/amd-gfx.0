Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85536C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A76113933;
	Wed, 24 Apr 2024 08:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CTsUAbC2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D146113933
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvTO5xr4SPQJAOf24H04EA66suCD3s5BJ/C9lDCFlKEhO0Gqc1DGSO2IVNifkXqT1nuJd7afM+shDO8iFw2Dld4XCe75TjEZYwJOVNVsSx9I+DHnaXDa6Pv7V+uRGpAKlu6FXPDN218mvegAfoV50KNse6ghLRQmyCoWRRe6OzSZeerJfzWb+Gcqzhd9jrgFFaHuHIQe9mjbEywERsAmQ8ULH0PjlF240lRLGyiZe/2Si8R683y9q3gX6qV6lCOcVHcyitrCYWS+qCCTyvHtPslfOQ2wX3Yb9Wf1z8nKHjsDjC/TjlLEwIxtdwM6W4joiFq/vH5eajeVTP+upzKCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5i6akH0clPFNuT2PLZnLInF81pMLMDO3lIrRdTqmm4=;
 b=LJV9w2clPIX/AfejOGGt0qkGfdm4cFzEL6EfRCLe0sQ4IKBwSiRFE8OvI+fQkxHRQXnzrgJ5JSVApq4W1Oa75/8h/EAyIUBa9ROCO0zMvmKUTi91fKlrN3MlREz9t2nY65F4Py9rHrh4dGnMM+di9OlR4tRp2DWXU67RNPSuDwrV6HZsFAu5t0qxK1HMYYBDxyWhegd21NHBiVzPXnCNRF4Z3fBD5ldnL+WTGN5HFipnsVt6IgdUxC6m7uaAUXmmW3EsQxH0oKtcx+e4QadnFQ9AdyTPTFLKT8yAqkTcp0iQ9E85mbUgWk2SAYhFIunPk/4YO5ffcqYrVKjNMs1ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5i6akH0clPFNuT2PLZnLInF81pMLMDO3lIrRdTqmm4=;
 b=CTsUAbC2dddPBLNLgbmzBY0MRqFyJhZrYOTvWUL8asSS098XHAiCa0ao1FrCum8A/n60s+ZwhOQvpKY8WP/3kmbLoMu/Pr4HQkawAaE+mDYs3B3c914Uuliv0LaOQfMvezrFfXTsH9QcTA3XF0gPhdmadpORz+zsmqBspq6g2tE=
Received: from DM6PR06CA0060.namprd06.prod.outlook.com (2603:10b6:5:54::37) by
 CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:42:08 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::20) by DM6PR06CA0060.outlook.office365.com
 (2603:10b6:5:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 08:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:42:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:42:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:42:04 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:41:58 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <leo.liu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 4/4 V2] drm/amdgpu: Using uninitialized value *size when
 calling amdgpu_vce_cs_reloc
Date: Wed, 24 Apr 2024 16:41:52 +0800
Message-ID: <20240424084152.740597-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c0a04d-2c36-435c-0d3d-08dc643a6d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qz5ci5TEbZiCpk2IZ7qjGqamHua1blKjt4Sv9gvcMlIDb5aMnB5zP7KgnqB/?=
 =?us-ascii?Q?V+GKL8cNiFw/klgSHb1HMKjMu6tUv7wMRJThDwtw2oRyhwWZ2xb0T4D5uI1y?=
 =?us-ascii?Q?4xqdn5j+Wqqmf/SK3QpgwEAdXmbVP5e0LNW9e9xL/18AcYKIo6CXgONGC6RS?=
 =?us-ascii?Q?G0BpEYj3ap4325F3C7NwqTCcE9KI+BcNppiJ/Oizsu5xR3YaSvMgmJkbkdY8?=
 =?us-ascii?Q?y+pyjjNa9hBj4nbIXaflShLitfvaz7CwAbPW2BGXX5JKCE50QnsmXw8YTNMa?=
 =?us-ascii?Q?Z6Z7VFlrqgTPZEX6cHFT8UQtFBrLo1feKQ94OToEi+yvjIy9WSCyGm9Q2qBo?=
 =?us-ascii?Q?N+WloEFfomUe2V5fKhH5CSvKXgu2XZH968Ep9QpqwEPX5nhUBuHQ0K+1cGMa?=
 =?us-ascii?Q?AzAaUvPr9931df1OWkspxfUDAepzP8q/v4YqeXjHdC+0hzpS3GanZ9sMPexK?=
 =?us-ascii?Q?NNV5bU6ZhFbYkE2slKV3J8zzOVAD24ybvlXD/Tg95WWXoCx6zc9Ic9R2XIFo?=
 =?us-ascii?Q?g0RhZVb5I1VnSWBnltE9eugnz6uJTjJdHXKTiF3ydhsiQeBgCZcx6Ic7zh6e?=
 =?us-ascii?Q?Nk72r+5BNGCYkbuV9+KzX7NV8TESUPgkLCh9Kgwh5rJuc05iQpw/Ag8pxOB9?=
 =?us-ascii?Q?ylLO0LoWhKuPNUUf1uRdGRlWL5tWVHyObATjIwRvdOsDt/iLkbDef8F9H5AE?=
 =?us-ascii?Q?NSgpMTBL4Gqw3QMH/qzqL46V4mRcaUUI8B/0dSMBkFoVAY5Sb6JDbyivKbmp?=
 =?us-ascii?Q?vXC7f+YPagGu84l4g+eqtcOcDEn5f0xvHbLBd5Uh4awXvV1KF88nNKEgrVVS?=
 =?us-ascii?Q?JB5c8OcUDr81KqJox3Wys2ubp5DkuOVpi2aXo2IDYFJNKHVvlMI/vY+DmADJ?=
 =?us-ascii?Q?PV2aL2ReLHWE6VoPfr4LouquHkoF9lpQy24pF+T5/34mQYWLtXbr0t0VKvHx?=
 =?us-ascii?Q?S5jiNzXHInSgDD2eew5x/fgdVfuAzyooBei3xtMZ2QyJSkWaIK9Ym+4DXrRM?=
 =?us-ascii?Q?HlBwkVEEJ7mZ8t2Wp8N9RnkTUZXneatppVDyVn1XQr1km6iV6yxlpYSafHn0?=
 =?us-ascii?Q?BfJOkIPMFBlJdgr++fTf8j5zm/eE/ZcTBzsE2PAdO9yjzxp8CftoSrNlyzHC?=
 =?us-ascii?Q?1PeRlVwLBrLzX12rPXwnYkOR6SA5s2k/+m3kLi2IVbhGUj7a8TBUNeds5AW3?=
 =?us-ascii?Q?fBHDJyuFhz1+W3l1TEyhkO73q7m5vFeKqie77oGCz6+ubSYfVrXJdx8WezdB?=
 =?us-ascii?Q?Tk/XmcSdw1WJ3EGvuNcR32mxvZmSyKnTqyUpjwq2d80wS77+6MZr8f9R29To?=
 =?us-ascii?Q?/lz3g6S+58fk5WfKHluW3BPWNbhiwt/8+QFd7iYF1ngIG1uZU7SHgjS0XZkW?=
 =?us-ascii?Q?yRP7NnI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:42:08.0306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c0a04d-2c36-435c-0d3d-08dc643a6d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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

Initialize the size before calling amdgpu_vce_cs_reloc, such as case 0x03000001.
V2: To really improve the handling we would actually
    need to have a separate value of 0xffffffff.(Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 59acf424a078..1929de0db3a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -742,7 +742,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 	uint32_t destroyed = 0;
 	uint32_t created = 0;
 	uint32_t allocated = 0;
-	uint32_t tmp, handle = 0;
+	uint32_t tmp = 0xffffffff, handle = 0;
 	uint32_t *size = &tmp;
 	unsigned int idx;
 	int i, r = 0;
-- 
2.25.1

