Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EB1C25B5C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD14A112CA9;
	Mon, 29 Apr 2024 14:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kzinaUSH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAD0112C9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsKP1o1mrgPpqaaH6MLvHDt9yics9OVPXvwKbYHSOAyEMcVq5dTY5gDXUVusXvWJKWifI5TKFSJD299n8lYcBlIkeYw3bpXu8HaquxEkbX4dEY2FuVrVj4tLQuw0iAcHp6/FIR+DId4rbCWC+LGglqgU8CE5++L8HTfRz692MufclcKt4Yx60Lb6YbESTNX0g8fPZl8bck5FtfWRPRSPq9/MhF54WbtdeMFjkg9pDiYGJWcV1Xt/sC8zBrWhkRnaBida0i50GGIuQPhEYsGZb50XMgr2TMajPIgSzAKa60Kg65bFKuxfST9wtqB6SgC4dx7mTvD9Cdyk8qI4RfsGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN6Lt47mVGrebEi4Xtn71+4vhJjN5wWC7WG2yhLjyLY=;
 b=e3RNZIOG2SmgxMEn55gKprJ3ni/LZwol5aTCdKoEtRDCaAZqeAh5O1xO+QZDsimbCbRKoAS0/YiScsKt9Bb16Boc/ogPFO6whmvnVJ3O5SAVQnrYTrigzWNgSnCZRFn9TFp/na0t4EWcA+JhZycQLIsApcqBmHyohrIdETNKi6XQoRiFGrVLRZDWXXacIPN1GARAtFWHTB0JAwz/bcjRpGu0PnkpJ9BkES3rA52LxIX/RZfw2uYg2OXmV2OGWq/kYX2y6kXoskYMYnZvnpzZKs3ZFOBvRjMiucQAKCohWlganxH81S+xYJTdKhNzaO5xM9q8Am5WZ/etUXtK3iu2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN6Lt47mVGrebEi4Xtn71+4vhJjN5wWC7WG2yhLjyLY=;
 b=kzinaUSHXCa4wHDU2kHv3zHKnu7gs9cRiztNICSOfmewxFcxJ+3sqzsXauafFKCathrBUjugX2H5shCwwrravxv1AsLlUmkiY5hiY2SZUk1eGvvLoXeYfZcMZg0nkWf58kd8SxYbU/azMguyzhYoOX63N07vVRRkJ/0XWc+8oBg=
Received: from BYAPR06CA0003.namprd06.prod.outlook.com (2603:10b6:a03:d4::16)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:22 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::b2) by BYAPR06CA0003.outlook.office365.com
 (2603:10b6:a03:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 24/31] drm/amd/amdgpu: add cgcg&cgls interface for gfx 12.0
Date: Mon, 29 Apr 2024 10:33:32 -0400
Message-ID: <20240429143339.3450256-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: f920c03b-5be3-4914-2ac3-08dc6859761b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/9WIQg9UGIAlXB496WLp/fSCqi86q3BSq5G5VppFC27l89l0fgi7ZMb3LTkN?=
 =?us-ascii?Q?N064L5nuRWzq5wCXvWcKx5cVLyz10U9qfjy4Z6hTZbjsmnkuaCcoNxOCO1rA?=
 =?us-ascii?Q?eQeiZnq+s/DHmMQWzf9rqy9V8z6dmUh8+x+I/jY3lm9ns4Q7L9kLa5Seqr1d?=
 =?us-ascii?Q?uZJNziuXlvikqQO5/m9X7WWemPR82/qpH1itqHp008ywZMK+R4P3zAAaM7EI?=
 =?us-ascii?Q?NuL07KhS3zzHzoe7Y7Fgb7wlIT77CkHITe8XYBj8vsWMMT+Nj4KgnAPF3RU0?=
 =?us-ascii?Q?IOMT//O6sEGOAGLm5rt/VfBgcaw738fk+/62Cw7bFZYXZUp0rdPcKyn3ugcQ?=
 =?us-ascii?Q?JCXJRGSyg9P/8g5rg1jIRf/fRpTupcWUVTYmVfTcpJ4OVGyVXt5EzLRBkmi1?=
 =?us-ascii?Q?fr2Yv61XmuR/KBAwPATqPUQVW7ozh6zOsEBof+uHWsUuhTBv2f9YjIZXpcFD?=
 =?us-ascii?Q?lExF3x20Z60eb7SQwAgefKzwSpxllqjnB59pFiGWr+SKqhifB2GxPVFgOeSG?=
 =?us-ascii?Q?ZxS08lkIxkYym0fFbdXdkArVq9CVqRt0BJp9gQ99etZq7kMdM9yxKk8OO7oY?=
 =?us-ascii?Q?2Axww+jYRhEkYnIrmVgU2h8gwz/z0q773ZPx7DPepgRHWxAuFAv3EvQzjDkO?=
 =?us-ascii?Q?wQwnwhaW+OCIErc6XnzGtsLWF5kuIK2+srfCRSCXnuC2qLjCruPqW0bMgBuk?=
 =?us-ascii?Q?htGLjd876nWSjGfMQLE9ZcHMUs1Y5ovkb+MwrxE+0XK8p3gKJHEyItcwMj8b?=
 =?us-ascii?Q?sXLU7+3aL7l4kwLVyH16/O/4AGVz5oghKFdEkgZRJAdeyvEW86cGI2mH54/G?=
 =?us-ascii?Q?rij04GU+OrSWr3U680d06GNecndk9YwxnOkd1FUNfeVDcjEzhkZK2uEWO0r8?=
 =?us-ascii?Q?J63/KrirpKC50gDB3eCUxwnd/9Jq0uZsGE1F/E04nmXyHr1uVCo4r0Pn4YwP?=
 =?us-ascii?Q?VY/2mouostRsE63b/DSQJeYYhpXwUmA9h5ingbFw/YH2ZfGrMUCuc50zGskw?=
 =?us-ascii?Q?z+FzA6JwJ9AvmO0QX37CNC4RbsS7N+dkJzB4NuC9DHNjkswN5WDWCYDc6vhh?=
 =?us-ascii?Q?E7TG/No9++bv2hBP2OYMdobE8OJPWHpikKeWnptLQEL5SG6xuTJRNTH3xNoR?=
 =?us-ascii?Q?KVuau8nr3p87vWLEl7TCpE50Qyyu4DBT6H+/+8Bd5PJamzzGDZNRXsq878Lm?=
 =?us-ascii?Q?MEm+8Yiuq/LMdtkWb1z/t7xC1XGktRKyPwi1YPRlFBtMFJWtMnItwXiQTMCm?=
 =?us-ascii?Q?B78wVAey18jamWjQogamdzJmf5LpAou8Mve3TJInhrV7VAkxRQL8CgLjZTu+?=
 =?us-ascii?Q?iUHdB+M6r4IQgu+v5gLhN+pabcVnTOmVw6Jrxf23ZXwsUfD3q1iwerlWeobD?=
 =?us-ascii?Q?CWwXx10=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:22.0762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f920c03b-5be3-4914-2ac3-08dc6859761b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
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

From: Kenneth Feng <kenneth.feng@amd.com>

add cgcg&cgls interface for gfx 12.0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 190 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc24.c     |   3 +
 2 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 730d57a10077f..882e00234e33a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1472,7 +1472,7 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 }
 
 static void gfx_v12_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
-					       bool enable)
+						bool enable)
 {
 	u32 tmp;
 
@@ -3594,10 +3594,196 @@ static int gfx_v12_0_set_powergating_state(void *handle,
 	return 0;
 }
 
+static void gfx_v12_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags &
+	      (AMD_CG_SUPPORT_GFX_CGCG |
+	      AMD_CG_SUPPORT_GFX_CGLS |
+	      AMD_CG_SUPPORT_GFX_3D_CGCG |
+	      AMD_CG_SUPPORT_GFX_3D_CGLS)))
+		return;
+
+	if (enable) {
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+		/* unset CGCG override */
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG ||
+		    adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
+
+		/* update CGCG override bits */
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+		/* enable cgcg FSM(0x0000363F) */
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL);
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG) {
+			data &= ~RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD_MASK;
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				 RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+		}
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS) {
+			data &= ~RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY_MASK;
+			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
+				 RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
+		}
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL, data);
+
+		/* Program RLC_CGCG_CGLS_CTRL_3D */
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D);
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG) {
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD_MASK;
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				 RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		}
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS) {
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY_MASK;
+			data |= (0xf << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
+				 RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
+		}
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D, data);
+
+		/* set IDLE_POLL_COUNT(0x00900100) */
+		def = data = RREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_CNTL);
+
+		data &= ~(CP_RB_WPTR_POLL_CNTL__POLL_FREQUENCY_MASK | CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT_MASK);
+		data |= (0x0100 << CP_RB_WPTR_POLL_CNTL__POLL_FREQUENCY__SHIFT) |
+			(0x0090 << CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_CNTL, data);
+
+		data = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
+		data = REG_SET_FIELD(data, CP_INT_CNTL, CNTX_BUSY_INT_ENABLE, 1);
+		data = REG_SET_FIELD(data, CP_INT_CNTL, CNTX_EMPTY_INT_ENABLE, 1);
+		data = REG_SET_FIELD(data, CP_INT_CNTL, CMP_BUSY_INT_ENABLE, 1);
+		data = REG_SET_FIELD(data, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 1);
+		WREG32_SOC15(GC, 0, regCP_INT_CNTL, data);
+
+		data = RREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL);
+		data = REG_SET_FIELD(data, SDMA0_RLC_CGCG_CTRL, CGCG_INT_ENABLE, 1);
+		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
+
+		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
+		if (adev->sdma.num_instances > 1) {
+			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
+			data = REG_SET_FIELD(data, SDMA1_RLC_CGCG_CTRL, CGCG_INT_ENABLE, 1);
+			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
+		}
+	} else {
+		/* Program RLC_CGCG_CGLS_CTRL */
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL);
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
+			data &= ~RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL, data);
+
+		/* Program RLC_CGCG_CGLS_CTRL_3D */
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D);
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D, data);
+
+		data = RREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL);
+		data &= ~SDMA0_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
+		WREG32_SOC15(GC, 0, regSDMA0_RLC_CGCG_CTRL, data);
+
+		/* Some ASICs only have one SDMA instance, not need to configure SDMA1 */
+		if (adev->sdma.num_instances > 1) {
+			data = RREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL);
+			data &= ~SDMA1_RLC_CGCG_CTRL__CGCG_INT_ENABLE_MASK;
+			WREG32_SOC15(GC, 0, regSDMA1_RLC_CGCG_CTRL, data);
+		}
+	}
+}
+
+static void gfx_v12_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+	/* TODO */
+}
+
+static void gfx_v12_0_update_repeater_fgcg(struct amdgpu_device *adev,
+					   bool enable)
+{
+	/* TODO */
+}
+
+static void gfx_v12_0_update_sram_fgcg(struct amdgpu_device *adev,
+				       bool enable)
+{
+	/* TODO */
+}
+
+static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
+					    bool enable)
+{
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	gfx_v12_0_update_coarse_grain_clock_gating(adev, enable);
+
+	gfx_v12_0_update_medium_grain_clock_gating(adev, enable);
+
+	gfx_v12_0_update_repeater_fgcg(adev, enable);
+
+	gfx_v12_0_update_sram_fgcg(adev, enable);
+
+	gfx_v12_0_update_perf_clk(adev, enable);
+
+	if (adev->cg_flags &
+	    (AMD_CG_SUPPORT_GFX_MGCG |
+	     AMD_CG_SUPPORT_GFX_CGLS |
+	     AMD_CG_SUPPORT_GFX_CGCG |
+	     AMD_CG_SUPPORT_GFX_3D_CGCG |
+	     AMD_CG_SUPPORT_GFX_3D_CGLS))
+		gfx_v12_0_enable_gui_idle_interrupt(adev, enable);
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	return 0;
+}
+
 static int gfx_v12_0_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)
 {
-	/* TODO */
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(12, 0, 1):
+		gfx_v12_0_update_gfx_clock_gating(adev,
+						  state == AMD_CG_STATE_GATE);
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 34b83a6ad26f8..6b438f0cc86e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -361,6 +361,9 @@ static int soc24_common_early_init(void *handle)
 		adev->cg_flags = 0;
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x50;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
+				AMD_CG_SUPPORT_GFX_CGLS;
+
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.44.0

