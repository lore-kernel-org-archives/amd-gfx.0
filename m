Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D250C282D6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C002E10E396;
	Tue,  4 Mar 2025 16:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eG9ZY6WQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE37D10E05E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 16:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLrV+p8h5c6QNnv0BzuiSQw+BvttIpPbTaEae/4SEeyyxFt8S5mNC0X5WWRbvelSKZwmkEbiK772NgdP0jkLTpbv0VIOEufsDZKMTR7uR6Mx7ACuK7Js/k2gC6ToXi5tm3PEimOtCDdZXDw4qrs7sTbw5z0h9BG8Kgg15811fDQDXvWWMjgE+jjiVy0qDqijZQ6GqY4awk/Hs7ldww/u4QDW/yASVBJPybJi/PvRr98UeEQGntFORgY+mTQYTUmxG4v0LjhFm8CF7NPF+OjE92UjIUMqmsvuRw6lj7C7t8KT9ISqWXk/57nPv/MOYsRAs9jNPL0R8w2Oo3A5N11CTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlGXid+lmMFWzEsdw2eF75sbORwpcjzYQwREUpgpD4w=;
 b=RwbcD7GG/3uBrS0mwKIOeQHy0WG32IvAcTs1W943r0V9vksquL26oCfEn2TMgZ9eI0HvyO1UGlJLxaY21Hh9c02bhi0u1/92ri7UiERmqKxaHFOnzgXYbEhewH+ZBjhj/fDryYFYW29SPCNPcrNH2rT0ef6ReHEtuxZ77j48QvwYO1dvhIQ6H6Zyg89KHh6nRlkwx+L2DSjqhiJvGBViaN8bfJCFcPjz2LB/tUsRxRo4qmVlQypXlethsWWrfReoN9Q8PhHS7laAShOW5pOeZ3cmLFiuAipVd8QpxqtgPdgkgazxQPElhsmcEebct4+b5lAM+lH1Bzstrs57Fi6/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlGXid+lmMFWzEsdw2eF75sbORwpcjzYQwREUpgpD4w=;
 b=eG9ZY6WQ5TCEMhqfWiAZ5aoZTKHsCAc8lDwhVGNNRnF+4fwsdNpymuYQgXP2VukXJb2BxbXL2CmjgVzGCVP+lLnS/b1zvaYHlyYuBGKjg9aCj5K8q79yH0Xl+gMvSAs4fgdnnKb71GAqBisr2L4ovwyGrbHvS3CT5F2exrsLAbY=
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:19:45 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::53) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 16:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:19:44 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 10:19:43 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <horace.chen@amd.com>, Victor Lu <victorchengchi.lu@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: Do not write to GRBM_CNTL if Aldebaran
 SRIOV
Date: Tue, 4 Mar 2025 11:19:29 -0500
Message-ID: <20250304161930.6268-2-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304161930.6268-1-victorchengchi.lu@amd.com>
References: <20250304161930.6268-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaa3807-753b-44c7-377b-08dd5b386061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fpmCnkE1y5nak2aZ+26r9ge6fhQgdP2mF68n3LGPedF4nbSu2jioJ5vnh0uo?=
 =?us-ascii?Q?98JOlQk2s3OLEuXcZNneiIh3L0DkUlBZ/VzU0UZ7n9/uzWtHchLipkL7MWao?=
 =?us-ascii?Q?cv0b4VaC6SFocCaojCflJRQn+oImCBYX0GlHcwvMNhX56RGdVImjSljB16H6?=
 =?us-ascii?Q?Dvy/LmogCzNKgRhKkqX88nByZZIJqDooNTbfZaEw3RCUObHNphgjNa4do4PO?=
 =?us-ascii?Q?UV/F2rd30o8Q3ZyoWwa9ysOoHXMmMQVj9S8roqYdHAGJEl2E+TDag5hEcMdz?=
 =?us-ascii?Q?Ja2mOJXhLXrlu2hB4mQhcMMqfqBlmV9m3ObLE3/ajimY3FW+JyzftQs3au2H?=
 =?us-ascii?Q?8kjuqu4xua9o4otrfl2P1Qc1yfx8/OElOgPh+YDRKr3aFj+zpBbf4bEQYshK?=
 =?us-ascii?Q?21KmletbyHdcslkFOJv+HD4goKc4BL16GS+mGInPdAW4xvlXxD+8toe37+ko?=
 =?us-ascii?Q?hoX677S4Iil38xGF2eVcVsHnVZSemfYoYtCE2NezyATK4X7xGZ9Wo7arc9se?=
 =?us-ascii?Q?s7S2CiDAyK4SVMOVs85ZyFFQO+6B5he8qjJgYbTw+uweTrmAesoprP04V6A+?=
 =?us-ascii?Q?DqiBFzktdFWiwDdYzMvoq2F4kj/pwyhcAF9DSk5VbniGP8+A6/JpIN9zGbVa?=
 =?us-ascii?Q?OXXV+zmfDEYfbyMSGPX/bIbp+X4T6dQXd0TPfneOufDTUW2TpeJuCGq/Y8P6?=
 =?us-ascii?Q?mfX8o3CKRuGTjGXCUmORPxTHE8zPaIB4ANoUdKKkIF6MitcOg4T/dMWuyxmP?=
 =?us-ascii?Q?EIhjuoyDI/n/ntjpD2X3gN4dG1aiG8jzEI4oXcIUkMZxMk8Yo/6xe4XRExLH?=
 =?us-ascii?Q?HxE4bk5zoH7hunmYs+yWx8py8sKTUdQ/uZ287Jt6Ms1D7EzRv66WgRidzKq+?=
 =?us-ascii?Q?0fAaxTWPHH5GisCyyXONTOX3fbBHCRmDeB7Q8YUuC9/zLwtoIqn9IHvq8V5U?=
 =?us-ascii?Q?vT6XNrIosjxONw4XVB0x7y4QxP9+dAlQ3SWnJ9GhV2YzzXfyvrAHTZkXB+oE?=
 =?us-ascii?Q?USQtMaVoPxUXOx5y7MkGwkQZWNOTgkKlganJ/lfBZ4n3ruU40ipdAM4zReSl?=
 =?us-ascii?Q?rV4KXqKaO3kgcLLM3jwJ8d+ofHoZbw/c1f83U90hVLJ68zFh6PWaZozHSY3b?=
 =?us-ascii?Q?GCGdmRNEFX1kL6jhLtsuzGNjIlBh2VB3/pXzzLFv/ojJ4ndEc/cN1tuBm66V?=
 =?us-ascii?Q?HDiSPG2zPoNzjtd9EQjUBfqCkL8uZ3iCDSRlfynLPZHHSVm9yGneZLcQDlsO?=
 =?us-ascii?Q?hLh4yq7k4eO5VnXfeuSche/l8JVdTkbEKPSh707k5wde9NUtiO5GEKVhNPfH?=
 =?us-ascii?Q?bQFSl/rMH5Ca3nFJQA/dStpiH4WLuh9ENp+kTgAY9KUmU5pnz+JRaS3qGIaW?=
 =?us-ascii?Q?qraATzVxjplxEkL/RxIkmhawlUMiLougUv6hm4XlyPAOeswC9ATh3hDKVQ4g?=
 =?us-ascii?Q?PW3ewD9vwXIh33vcVbWZJ/Aho1DDO594wStQqjnwFoEcj60ej4Wg9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:19:44.8196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaa3807-753b-44c7-377b-08dd5b386061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

Aldebaran SRIOV VF does not have write permissions to GRBM_CTNL.
This access can be skipped to avoid a dmesg warning.

v2: Use GC IP version check instead of asic check

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f7938d318f26..1f0f03108a82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2637,7 +2637,10 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 	u32 tmp;
 	int i;
 
-	WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	if (!amdgpu_sriov_vf(adev) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 2)) {
+		WREG32_FIELD15_RLC(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	}
 
 	gfx_v9_0_tiling_mode_table_init(adev);
 
-- 
2.34.1

