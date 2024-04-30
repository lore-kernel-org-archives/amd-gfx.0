Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7541EC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDE6112F2B;
	Tue, 30 Apr 2024 20:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6B13HjA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99C0112F2A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ4iIJ07i7B58it8kuLmfkFP7N0t3qgImxSd29M/HHvjnL+RwrA9fZY2q6q5vWvkRMoFkaPmCkx6mnn300IxAbP/NK7DsFPQFX7joFPi9WOBqtIt5/a8VpwY5iD1EgzykRmRGnYTNbDnng44q93FwzRYUkKHeTRR7bT/UwgWWhQQt1Tnrej/9NZUx/3AZizBUsSUSvhDjd67TfGJjjLC4PVoMtNw6I1C4VHX1kX3hidUtck5l+wRqTZDRqVPw2+886UU68OGPzOcHKMebDhIUUKLYRnFKdREk3a2HTym4hXTX4yPNVhIECieM7A4BhjUD+U6x5FpWTCZCqMvNN57+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juS2me7QdfNtjFfcgrEbTtX8Kzl/2tuZnXOnoAnWQFI=;
 b=kWmXAsXL4JeMiUfiWrOiJocXSmbvMWolLS5pTpQOe+FUdRaxeVEtXmSYt+hRQ1s9Q1sVB/XPf/Gy/337jJ5qwnumfgW7HjWjTxxSpazbZQy3dHABRrxUH5YG5kENh9soXEVyNLeH9PFiH/Q9FnT02rGuIorERyGqsiA0Bb8ZpZErhSEDlsdHbmGjl6RJS058YrAZQRRnTXFDzaL+SS+KWub39htnWfC25UfnQVbTAmH7fL0ygvKO/EBm1cPhpE7ptjt0npesFDMbRPeadkj3CHOvJ7iK6bZgaEjSMZwPv3rIKNeBUcH+40XEDqHZtuGiTpGAUyIrXV+CVRN6cSPuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juS2me7QdfNtjFfcgrEbTtX8Kzl/2tuZnXOnoAnWQFI=;
 b=y6B13HjAaPxrHcdCeP+GhDNkP/P/bxrIVm4SkyWK8fxXk3mHjetdZoFhYgMPhDLTB5+tLxIgAjzkLD2eN+baqGXgu2CYri8AAQqs+cdYllVWFdcaI+giZ+JJM0qS5q0JK+I5nCHkEJAZBVYFd3yywNDwbFHBMCOxxw3LKRRk2m0=
Received: from BN9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::31)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 20:34:27 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::2) by BN9P221CA0011.outlook.office365.com
 (2603:10b6:408:10a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 20:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:34:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:34:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: support cg state get for gfx v12
Date: Tue, 30 Apr 2024 16:34:04 -0400
Message-ID: <20240430203405.798798-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203405.798798-1-alexander.deucher@amd.com>
References: <20240430203405.798798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a790854-d9ea-499f-3490-08dc6954ee41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400014|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j0AX1rfmZeu6aQm02QmLAxu0hqi2Q/Cs2z7cjhJLRvZEqDT3khInV0TmYKl0?=
 =?us-ascii?Q?5iTmy5GdSJ/hplcS7v2CYEclpy4Dw7icNHYrLJPXBgACT1ZMWSxfrWwC3d31?=
 =?us-ascii?Q?m7tSiTz+FCxdRkY0Gt5ac/wbrEzlqDyvT7whablVfgD9GjnK2k0Pp7RwMVo4?=
 =?us-ascii?Q?+FMXG2z2lZX3/9O22wZ1UWPC98xXckthlNoU0/yp4P2mfVoBxbxRUNAPh+uy?=
 =?us-ascii?Q?ks8Z+FDaeaL+c0coLifqETeYoU1bvnAj57lb/KQagfCU2BPJksUkNKFIYUc4?=
 =?us-ascii?Q?r2W/sXRGsNA0ZacmrvPZOIdebyWi9/TUoftel6IDdS/ysynbA3zuN0E/Pjv7?=
 =?us-ascii?Q?910F9ybiEPbDIPwa54BsPlwQMZ9lSBlXztkJsmntOVfOeFUg9rFfcYdhbfVG?=
 =?us-ascii?Q?d4iEGCy1zZs9504VwDcyP8iI+w/hPzs8e4pZ83Pgj+AhaQDi6K0vpQmJR63G?=
 =?us-ascii?Q?h7m3rcI6fmjnjH1Ki8xq9HASePpnK/vK6kUoN3eXUk762wWC/dhCB3LQ7kE9?=
 =?us-ascii?Q?N6UMwoCulpSFHqUe8u/BmhbRj0RbsxrYCD+FQmInEMkp0GMoKyezF0UK5PHa?=
 =?us-ascii?Q?AfZsBs7ED8mbcDNjUo0X2p1xwKFq0gZuHXjHVDnPRCONO7B4Nwk/Ix/zgngc?=
 =?us-ascii?Q?fetqbcwKUq6YE6GegysT6CoTrjpk3WBGua9tmA3Vr1E61dDJ8bGpKsho5Dcy?=
 =?us-ascii?Q?ktAqxFLDf8rtQrgAuvsWLJ8W/TkpRAqlFfcUgfyo3yj+0Hx1+H3DCvgQzj9A?=
 =?us-ascii?Q?zSvxkGaGvKtRKvaFUfT4TxrpiYulzUZbq+i15/Ofb6HRaFsx9RssQC2pn6n1?=
 =?us-ascii?Q?EsLIgsHsmZZbJSfNFc5TJXosDnbdgAwKMPthjxJNK5g6vQIH698LHJ7VQYea?=
 =?us-ascii?Q?95fdMqmIbnfg17CrVr8+eheaW0IULd8Y+qzAiQKye74M7PgCZcgbSOUs5stJ?=
 =?us-ascii?Q?MfZQ1omjcbaWYagRife8rHIKiZnSihU4XjeGlJiuQCl/8y6zl6QSJcQxZDSr?=
 =?us-ascii?Q?IrydhwuVYWj5nh7ir9PVnWut15dKl1WFWcS/vLrwuvpawiWPYkT0BNWzmT9a?=
 =?us-ascii?Q?NkNkx70adeUlkgjwvdrA3cG3c9cDTnu9XangNeW2zOb8V5tLgegbJirLxDXP?=
 =?us-ascii?Q?vonMBwE+mlMpelyFwJsuOi3U8s17KT+VLeGKDd3X5/41PWqZ1PuneJKWIYnd?=
 =?us-ascii?Q?p9q/XmpaWQHR8zldxSYQyI8m2XNKH88RrcHw26NbW6f0mU18In/OCSSNp4/Z?=
 =?us-ascii?Q?w9pUarzr+pqrdQnPXYARc4wC5gMI707J+3dUZk9lex19QHYq3iR3q2PcL95t?=
 =?us-ascii?Q?KnwOQp6261OMN0H8vm5J2sDUTQGybrP9sB7ixQ7oL4zntu3T3ctc5ge21zil?=
 =?us-ascii?Q?bt4wvbxPntJMk8C/En77CIlrUEgD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:34:27.4719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a790854-d9ea-499f-3490-08dc6954ee41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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

From: Likun Gao <Likun.Gao@amd.com>

Support to get clockgating state for gfx v12.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 38 +++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 8d4b234bd287e..08f866c5ff432 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3863,7 +3863,43 @@ static int gfx_v12_0_set_clockgating_state(void *handle,
 
 static void gfx_v12_0_get_clockgating_state(void *handle, u64 *flags)
 {
-	/* TODO */
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int data;
+
+	/* AMD_CG_SUPPORT_GFX_MGCG */
+	data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
+
+	/* AMD_CG_SUPPORT_REPEATER_FGCG */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_REPEATER_FGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_REPEATER_FGCG;
+
+	/* AMD_CG_SUPPORT_GFX_FGCG */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_FGCG;
+
+	/* AMD_CG_SUPPORT_GFX_PERF_CLK */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_PERF_CLK;
+
+	/* AMD_CG_SUPPORT_GFX_CGCG */
+	data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL);
+	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_GFX_CGCG;
+
+	/* AMD_CG_SUPPORT_GFX_CGLS */
+	if (data & RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_GFX_CGLS;
+
+	/* AMD_CG_SUPPORT_GFX_3D_CGCG */
+	data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D);
+	if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
+
+	/* AMD_CG_SUPPORT_GFX_3D_CGLS */
+	if (data & RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_GFX_3D_CGLS;
 }
 
 static u64 gfx_v12_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
-- 
2.44.0

