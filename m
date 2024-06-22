Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669E1C2BD05
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Jun 2024 15:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8F710E274;
	Sat, 22 Jun 2024 15:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MoHQKIdQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE4010E274
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jun 2024 15:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr56xlqfdnWZjVqeOW6iRCKhChCYX4sS14GKBsUx2Wa5pv7jndVRuk/mmharJujSJ5vEGMRtCWziX4TTKw25FjBXUSYeLmKX3enkTboWEGcGww3MiDEmvGkFALHRku9qiRUVrPQXrkS/ypjRjHY3D0lJ600x9bGPvV9rTlC266JOhN2gGa57NF1NDiuiPUG6NxvMKSn9gNfcxOZD1F7maMkT//UWS8KZ1iK8A2z393E+sWdzjuz5mHugmLjxeBE1If5F8W0C/aHI50dEPd3+6EfJVruF/JlVWE5uiz0nPPctUc+L4+lafHLB9jKNSRUIblhwyTBV86+4rOX8QX08SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB8hEH+X5pFUPPEZlJqfYL4XgTV1ENE+ufc+TaD6C3M=;
 b=iIrdPNSy0VaYE4jFnT8WtCPCAwUnEBF9FRFUOklm9Xzxi/f3Tq/X7b8v+GFS41YN9OmTJEt+WLZvIJ+Z5lTNId93YqO7kdYpCODrFxVkuxnkDHUr+XcmaovHin05COhvtCqAJ+c2oBmL8/M46DDvU5mThLc6VAbwY7Ph9k21Vrmy+rVTJC8vFXchUa7wxu6tZoqRgx1UsbOKvwYqZLWxyrX89RPgkcAVzQOzJ1DI/yomZCurSXIaZYyJC3SZub7VLW59QJ5h40u2B/5xsJ2/eZBCzXF8Q9MTBdS6OpOcq2VcZXuoOgc7vEdqz8rJw40lNJGYl7q9SZhKCDBS6v5YdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB8hEH+X5pFUPPEZlJqfYL4XgTV1ENE+ufc+TaD6C3M=;
 b=MoHQKIdQ94e+OI1jVEE8mbcmEk9Ouuhk3TkWxFFzcvOIYAMJiA+6QkB3S47JPnEvp8lup8mDbTcUQdSLasboh9ryhSRW3uVQzH7z/fLNABFuhZl6Upfu57y5qf250fRRqYWPxGK7+9BbuZ2+SMDlw9ZQqMGGdAlXe7tiJzlxkXU=
Received: from PH7PR03CA0019.namprd03.prod.outlook.com (2603:10b6:510:339::22)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Sat, 22 Jun 2024 15:48:06 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:339:cafe::7a) by PH7PR03CA0019.outlook.office365.com
 (2603:10b6:510:339::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Sat, 22 Jun 2024 15:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Sat, 22 Jun 2024 15:48:05 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 22 Jun
 2024 10:48:03 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <lijo.lazar@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [Patch v2 2/2] drm/amdgpu: Don't warn for compute mode switch under
 SRIOV
Date: Sat, 22 Jun 2024 11:47:51 -0400
Message-ID: <20240622154751.632271-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622154751.632271-1-rajneesh.bhardwaj@amd.com>
References: <20240622154751.632271-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bcd01f-00ea-4ab5-272e-08dc92d2b4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|82310400023|36860700010|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sVOKxCwe7zYANtd2RltU3BvUee4j0Ae7Z1p4QXnMDXEPIw//pWARqw3YPqGn?=
 =?us-ascii?Q?5c56IcJAW9/yxGAVndluUhYWynduvOW20tU3wiscchfkP9aJBwynM4Q91LW6?=
 =?us-ascii?Q?iMPCeAJ5QtX/R3ViYwD1uUszHAA2bL9nG4Mg3Ma4iqjd2TPUq4heH67dtwM4?=
 =?us-ascii?Q?5RZVdscwtt6Jy/Rj+drwGgi/RUXfo5YRrajNuYUQqYN2xu/OplfB5Ks/RVO9?=
 =?us-ascii?Q?Wo9/N+QqYfcrvQvlUWGWOC3ovYr4NGNztG2yCXhGOuCD1woSxVQ9da2eVID3?=
 =?us-ascii?Q?XhKVVwtCdKI4asua/XxLo/YTuq6AxBfqGwuDo5obIX1bW4IC+W2ql+58o98J?=
 =?us-ascii?Q?1klEk3w4sNwQx6MlU09daGTKoPlFCOSEjkoHiEV8UUg9vIcp5lyP/HlIPiUg?=
 =?us-ascii?Q?D9uCqbYj1XnXIrC5w6IgV3zraNP+efV2CsbvfcDsOY+Ropv4LDYNCu0+oKGJ?=
 =?us-ascii?Q?3kw7BY+Ay4OcN9keqKRci7aa172CDG9g1FA+B1seqrznTgOnY89etqunpbZC?=
 =?us-ascii?Q?68isMRjRS3HGKqJdj6edBFKc0CuWzrOsDDTwsMEh4x0idNWrNYLi7COM6nVX?=
 =?us-ascii?Q?1mVv53H1TgpWpSc9EqkI4pvj3kp4FciLrVzg6nqGR2xESAQ3/POmfPLcx6dM?=
 =?us-ascii?Q?CjvtiK9BRMQk5YNJoS214oDbpEbHA6t25gkFxlOycD+eI2ejE7x1vLwUdgn8?=
 =?us-ascii?Q?5IeHa4gryHH9r5mAu9c0uPrWjkdyFx/eF/BhNCd0IKRqxmgh/AA15l648oiV?=
 =?us-ascii?Q?QwzWW1G0TlDpVQSk2QwUGnpIif9ODEXAlcH1sTu7zIY9LTTe+Uqku2I2JyA5?=
 =?us-ascii?Q?y/qbzWLJ1wbd3hmqFFWLHcYknRcD/vtOkHB4iJEdXSqZrrbWDTVVSUF0HaNY?=
 =?us-ascii?Q?S0n/JDqjiY+j6LIeO73uBifb9Z6X8E/J64MrB4dQSpeFWCYM29Cs7+WkZxpG?=
 =?us-ascii?Q?UM2i98M4CzNo+LPqmNerx3pLPaRtL96+NpzouGmE687mQmvkGBUPU2a8iZs4?=
 =?us-ascii?Q?ZOL/9f7CPkY0wF7tJfnjurFgoNPdOVcWGVO4vBYv5PEKQvFNIv0tPvsIJJii?=
 =?us-ascii?Q?z5ZZ8SmDjWeNerOolkk0nuyesm4LCbsnaFUv2Fh+tZm/SsEvSi2FWnnoDxdm?=
 =?us-ascii?Q?npFXyM4tutRbnzLiOYXluWUd/8Rrix1SviOXDco2lIX870V4p3NWwRypmWSN?=
 =?us-ascii?Q?KTJUdi0BcD0Rdn9btn49kv/pj5MKGCysFvsWv2JtjQ4zFxFeb56cqwhT2VCb?=
 =?us-ascii?Q?r6p/kA7cniUp8V43obHQE1QqxTgMOyAjsR71JTQf+ZPLvMqPkbFSiuGTMwBE?=
 =?us-ascii?Q?HQAzDL5DN0sFDxW4Yv8Kqw/eRRW50v/Vcb/A7l/ekYD/ycHsoWiP2illeb5d?=
 =?us-ascii?Q?3sBkN5jpDNrDZ5yWog/iyPGcAb7aQP2q2BasItDnqgdNt2Q1TQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 15:48:05.3042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bcd01f-00ea-4ab5-272e-08dc92d2b4d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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

Under SRIOV environment, the compute partition mode is setup by the
host driver so state machine cached copy might be different when doing
the transition for the first time.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 2b99eed5ba19..c4a9669bceb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -228,7 +228,8 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 	if (!(flags & AMDGPU_XCP_FL_LOCKED))
 		mutex_lock(&xcp_mgr->xcp_lock);
 	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
-	if (xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS && mode != xcp_mgr->mode)
+	if (xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS && mode != xcp_mgr->mode
+	    && !amdgpu_sriov_vf(xcp_mgr->adev))
 		dev_WARN(
 			xcp_mgr->adev->dev,
 			"Cached partition mode %d not matching with device mode %d",
-- 
2.34.1

