Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF67CF0423
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E1D10E5D1;
	Tue,  8 Oct 2024 21:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z4MNAlKf";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB2810E5ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dcy/tQYnrfRfarfEs0tVIBCTlCNr5JRmwwY9XQ9gFC2HihBv8L7L8l05eLhDlW1p2FkCqIlpp/eUJqKTMIXOnPjsqzkioo4niopXPVUvMhBx1gMCms1tpTkKP4ML1QK4w8y+shur4HoUn3/0Sn5m9rJQcTWOdwsVRirG2srh8+dk+/vutsGHXY0slEVWg1KEjq6OuNfEoe1Jm3H9aTPfMSZ6KpPk5O9wTPwViFs6ix7kXXHZKD8BFvgkvLs8J9+/GkNzlgQsly0G5lQ1PQGlYoIV1wSsG4KdlDAjpd+HHtGvaashOQYdgnJKZeGw3BAvdck63TLls2N45vOo0xqEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX8rBasc7xE614WkjpEruid/OOn6rMnUS2yDiYR39vk=;
 b=apTn5pfD4q/7fDBImVUftKdxn8mdZdLfo7suaXU1/WHnKRH++E+SbfYHZRdGpaKMJ/mUSQSTObu20U5ashVryKEG4xgRfZwVuWbbdw2NkXVvpkqBMzqPnTX20pDPp8pqquMbeoxlCffoqS+OMQ0CQDEJjYua0tUvZ7As6YmU9NaVs+msJ8VN5nhla44kUrMsYyebo6KZECduAJN/rTxHT5IBYSozf/f4ebW62n0v6UHqosjWQtNnFeLUWHcEpG44GUgPCG/WD5Ostb5YNrVt+w/fXrIQpzJFDWSiAjAPOMyXOFfM6P2qOFmeO4kK1BVPGORqu7p8aLhGtDvPf561OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX8rBasc7xE614WkjpEruid/OOn6rMnUS2yDiYR39vk=;
 b=Z4MNAlKfan/Rs/PzJCJiuhsFICZvYoDvQYkKaojoi9RTwnUQsFhp+W6jD8Ehn3qwdGrlM66MkUHgocpgn6srsHAlAPN8kdf97gYIC9rb13yB5I3+/x3G7YFtgDr3ZGQwxHQ30qOadqf4rBMDu2LU1p7lPz0zabCY7ItY7IQJw3k=
Received: from CH2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:610::48) by
 DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 21:16:37 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::4a) by CH2PR05CA0035.outlook.office365.com
 (2603:10b6:610::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:36 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:31 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 32/32] drm/amdgpu: set_powergating for each vcn instance
Date: Tue, 8 Oct 2024 17:15:53 -0400
Message-ID: <20241008211553.36264-33-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 353a103f-a027-4f6f-8361-08dce7de7e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PaGMjLPjw2f5QankHTun0BwZbyY5kc/LaCmvIIcPB3LFVtlkGBFJWG9+Jm8f?=
 =?us-ascii?Q?UbkluVpviRZLnggmN/kz1w2TUs9YFY2/Yfe5NflZdWkwk0QJ+yXeK5HC443e?=
 =?us-ascii?Q?yqLz+9faMhqVz6UtNxmijh+3cW1htmntS1n2qyM5SuQTPCi3Cfp7GA1Fx15W?=
 =?us-ascii?Q?TprwcS/6lQb9zt4R++mCsN+a3PVezoAHQsrzbgvZl5jcdyRG6DxA08wOE1Cf?=
 =?us-ascii?Q?1oA66XMOJgqMYJMFqt3xzIxPbOHnz4uVTlJWH103EW1e6pNEhmOkg/aNxpBZ?=
 =?us-ascii?Q?Bh7uPiJjnjylTioqCY3aeOVMpphxJ+jsoDnlu9VGCWj8IxUh1oXU4vyj+kEy?=
 =?us-ascii?Q?D3fJMXT37imMUQ6pbSXpmsvt7p7PhliQ8gD8QrOsfKqkKACKBVbKC5lm+vO2?=
 =?us-ascii?Q?1zwmWHiL+65dsaa0X+Gq3yGccsDarKDx2SPMXM2yJxTGBzp2vL7P0ZSPEwHz?=
 =?us-ascii?Q?4eXI6kNOJBT6e9wWFhyFc/mno/mv0wP/bDgWyCvE5G5GjDiSZ7tXCzHGuq0G?=
 =?us-ascii?Q?5uqFTLxoyZxAq2WIkgFcUt0nK9jIdcWHotonrdbpKlZyschM3ztD396Q4mUs?=
 =?us-ascii?Q?17orHcINSy0MSF9f9j4s047BqZNQVpDQfvEzmgFbrpYsX1+3an+FeNWXOQDg?=
 =?us-ascii?Q?b69DhO4Xs44jwmPJjP9FbmrYtHhpq0lvI5olGqf8NqJhSOkV6+9SuNhD+kjz?=
 =?us-ascii?Q?W0lpWMbvHwlyWAjII+DHf1aS2JMv9vl6ERI2D3pcrSShQ4a7DIaqp9+FI3nM?=
 =?us-ascii?Q?4VXsoH1pJxN5+pw4xpbeAG+Y450zxf+u9wftl00DIW4hxpmeCV1zwnPjmCBk?=
 =?us-ascii?Q?sS50Td8FSQ5lA6UlUBY259DM4mooUd9b71jUy3FZeGZX+KmCg7PiRC76gMSl?=
 =?us-ascii?Q?+1CHno0tWO/ojjLDODN8zmToBKQekWv9+DY7QMapR5nTRVbRiuirSv2aIXqt?=
 =?us-ascii?Q?Pdc8TRrOewTsaPfsabF9jFjMgAJoN+K1ZQ7hK4W2yxqOw5bJULEVa/UPXG+w?=
 =?us-ascii?Q?I9InOm4UR1DWjEiyf5fQ04HQ7yoM1qUUb2aZEu34TnVqEaQifzs6QKSxwfRw?=
 =?us-ascii?Q?8Ls08aO0eC5nM8Tg/12bjCFw9etMSowj40j9/QK1SkyMrioe9d62mTibQsDK?=
 =?us-ascii?Q?eP9+K/EODe1WRw5Nv73OOOOCYGli2t3apJLLN9ImyQDqrAslkDuDLoLA9W6z?=
 =?us-ascii?Q?CHrdaT+EG0ABrrfFYxvnuxHxmzBrV9U24QZB/BDC+u1T+SQwgzTMuTacrIg4?=
 =?us-ascii?Q?AKgsPkljftb+1WlZzQkcoc8OXM0uQ1W8CtzTD4aQnJFxuOLNSgKKp8fA6RsR?=
 =?us-ascii?Q?rGxiND7KBCyvZ8UOl6OQvJLGTZMmPgubL5B6HOYsBsOh4/3lLNyHd3sCPDaN?=
 =?us-ascii?Q?n73DeK0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:36.7639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353a103f-a027-4f6f-8361-08dce7de7e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Perform set_powergating_state only for the instance of the current vcn
IP block, instead of perform it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 313 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  20 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  20 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  19 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  20 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  20 +-
 6 files changed, 199 insertions(+), 213 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0b62729fca89..d41211d35013 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -612,114 +612,111 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data;
-	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* UVD disable CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
-		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
-		data &= ~(UVD_CGC_GATE__SYS_MASK
-			| UVD_CGC_GATE__UDEC_MASK
-			| UVD_CGC_GATE__MPEG2_MASK
-			| UVD_CGC_GATE__REGS_MASK
-			| UVD_CGC_GATE__RBC_MASK
-			| UVD_CGC_GATE__LMI_MC_MASK
-			| UVD_CGC_GATE__LMI_UMC_MASK
-			| UVD_CGC_GATE__IDCT_MASK
-			| UVD_CGC_GATE__MPRD_MASK
-			| UVD_CGC_GATE__MPC_MASK
-			| UVD_CGC_GATE__LBSI_MASK
-			| UVD_CGC_GATE__LRBBM_MASK
-			| UVD_CGC_GATE__UDEC_RE_MASK
-			| UVD_CGC_GATE__UDEC_CM_MASK
-			| UVD_CGC_GATE__UDEC_IT_MASK
-			| UVD_CGC_GATE__UDEC_DB_MASK
-			| UVD_CGC_GATE__UDEC_MP_MASK
-			| UVD_CGC_GATE__WCB_MASK
-			| UVD_CGC_GATE__VCPU_MASK
-			| UVD_CGC_GATE__MMSCH_MASK);
-
-		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
-
-		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK
-			| UVD_CGC_CTRL__MMSCH_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		/* turn on */
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
-		data |= (UVD_SUVD_CGC_GATE__SRE_MASK
-			| UVD_SUVD_CGC_GATE__SIT_MASK
-			| UVD_SUVD_CGC_GATE__SMP_MASK
-			| UVD_SUVD_CGC_GATE__SCM_MASK
-			| UVD_SUVD_CGC_GATE__SDB_MASK
-			| UVD_SUVD_CGC_GATE__SRE_H264_MASK
-			| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_H264_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCM_H264_MASK
-			| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_H264_MASK
-			| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
-			| UVD_SUVD_CGC_GATE__SCLR_MASK
-			| UVD_SUVD_CGC_GATE__UVD_SC_MASK
-			| UVD_SUVD_CGC_GATE__ENT_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
-			| UVD_SUVD_CGC_GATE__SITE_MASK
-			| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
-			| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
-			| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
-			| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+	/* UVD disable CGC */
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_GATE);
+	data &= ~(UVD_CGC_GATE__SYS_MASK
+		| UVD_CGC_GATE__UDEC_MASK
+		| UVD_CGC_GATE__MPEG2_MASK
+		| UVD_CGC_GATE__REGS_MASK
+		| UVD_CGC_GATE__RBC_MASK
+		| UVD_CGC_GATE__LMI_MC_MASK
+		| UVD_CGC_GATE__LMI_UMC_MASK
+		| UVD_CGC_GATE__IDCT_MASK
+		| UVD_CGC_GATE__MPRD_MASK
+		| UVD_CGC_GATE__MPC_MASK
+		| UVD_CGC_GATE__LBSI_MASK
+		| UVD_CGC_GATE__LRBBM_MASK
+		| UVD_CGC_GATE__UDEC_RE_MASK
+		| UVD_CGC_GATE__UDEC_CM_MASK
+		| UVD_CGC_GATE__UDEC_IT_MASK
+		| UVD_CGC_GATE__UDEC_DB_MASK
+		| UVD_CGC_GATE__UDEC_MP_MASK
+		| UVD_CGC_GATE__WCB_MASK
+		| UVD_CGC_GATE__VCPU_MASK
+		| UVD_CGC_GATE__MMSCH_MASK);
+
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_GATE, data);
+
+	SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		| UVD_CGC_CTRL__SYS_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MODE_MASK
+		| UVD_CGC_CTRL__MPEG2_MODE_MASK
+		| UVD_CGC_CTRL__REGS_MODE_MASK
+		| UVD_CGC_CTRL__RBC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		| UVD_CGC_CTRL__IDCT_MODE_MASK
+		| UVD_CGC_CTRL__MPRD_MODE_MASK
+		| UVD_CGC_CTRL__MPC_MODE_MASK
+		| UVD_CGC_CTRL__LBSI_MODE_MASK
+		| UVD_CGC_CTRL__LRBBM_MODE_MASK
+		| UVD_CGC_CTRL__WCB_MODE_MASK
+		| UVD_CGC_CTRL__VCPU_MODE_MASK
+		| UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	/* turn on */
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE);
+	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
+		| UVD_SUVD_CGC_GATE__SIT_MASK
+		| UVD_SUVD_CGC_GATE__SMP_MASK
+		| UVD_SUVD_CGC_GATE__SCM_MASK
+		| UVD_SUVD_CGC_GATE__SDB_MASK
+		| UVD_SUVD_CGC_GATE__SRE_H264_MASK
+		| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SIT_H264_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SCM_H264_MASK
+		| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SDB_H264_MASK
+		| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SCLR_MASK
+		| UVD_SUVD_CGC_GATE__UVD_SC_MASK
+		| UVD_SUVD_CGC_GATE__ENT_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
+		| UVD_SUVD_CGC_GATE__SITE_MASK
+		| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
+		| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
+		| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
+		| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
+		| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
+	data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
@@ -777,59 +774,56 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data = 0;
-	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* enable UVD CGC */
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
-			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		else
-			data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
-		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
-		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
-		data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
-			| UVD_CGC_CTRL__SYS_MODE_MASK
-			| UVD_CGC_CTRL__UDEC_MODE_MASK
-			| UVD_CGC_CTRL__MPEG2_MODE_MASK
-			| UVD_CGC_CTRL__REGS_MODE_MASK
-			| UVD_CGC_CTRL__RBC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
-			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
-			| UVD_CGC_CTRL__IDCT_MODE_MASK
-			| UVD_CGC_CTRL__MPRD_MODE_MASK
-			| UVD_CGC_CTRL__MPC_MODE_MASK
-			| UVD_CGC_CTRL__LBSI_MODE_MASK
-			| UVD_CGC_CTRL__LRBBM_MODE_MASK
-			| UVD_CGC_CTRL__WCB_MODE_MASK
-			| UVD_CGC_CTRL__VCPU_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
-
-		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
-		data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
-			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
-		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
-	}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return;
+	/* enable UVD CGC */
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		| UVD_CGC_CTRL__SYS_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MODE_MASK
+		| UVD_CGC_CTRL__MPEG2_MODE_MASK
+		| UVD_CGC_CTRL__REGS_MODE_MASK
+		| UVD_CGC_CTRL__RBC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		| UVD_CGC_CTRL__IDCT_MODE_MASK
+		| UVD_CGC_CTRL__MPRD_MODE_MASK
+		| UVD_CGC_CTRL__MPC_MODE_MASK
+		| UVD_CGC_CTRL__LBSI_MODE_MASK
+		| UVD_CGC_CTRL__LRBBM_MODE_MASK
+		| UVD_CGC_CTRL__WCB_MODE_MASK
+		| UVD_CGC_CTRL__VCPU_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
+	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
 static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
@@ -1032,7 +1026,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int inst)
 		return 0;
 
 	/*SW clock gating */
-	vcn_v2_5_disable_clock_gating(adev);
+	vcn_v2_5_disable_clock_gating(adev, inst);
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		return 0;
@@ -1471,7 +1465,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
 	/* clear status */
 	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
 
-	vcn_v2_5_enable_clock_gating(adev);
+	vcn_v2_5_enable_clock_gating(adev, inst);
 
 	/* enable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
@@ -1795,6 +1789,7 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
+	int inst = ip_block->instance;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
@@ -1802,9 +1797,9 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	if (enable) {
 		if (!vcn_v2_5_is_idle(ip_block))
 			return -EBUSY;
-		vcn_v2_5_enable_clock_gating(adev);
+		vcn_v2_5_enable_clock_gating(adev, inst);
 	} else {
-		vcn_v2_5_disable_clock_gating(adev);
+		vcn_v2_5_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 5b11062b873d..e89600e6f86c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2123,19 +2123,17 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (enable) {
-			if (RREG32_SOC15(VCN, i, mmUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v3_0_enable_clock_gating(adev, i);
-		} else {
-			vcn_v3_0_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, inst, mmUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v3_0_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v3_0_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 69fff5df1c68..e1b2ada8d69a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1994,19 +1994,17 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (enable) {
-			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v4_0_enable_clock_gating(adev, i);
-		} else {
-			vcn_v4_0_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v4_0_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v4_0_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index cb30d5e5bc70..d1db91d8de79 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1588,18 +1588,17 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = state == AMD_CG_STATE_GATE;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (enable) {
-			if (RREG32_SOC15(VCN, GET_INST(VCN, i),
-					 regUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v4_0_3_enable_clock_gating(adev, i);
-		} else {
-			vcn_v4_0_3_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, GET_INST(VCN, inst),
+				 regUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v4_0_3_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v4_0_3_disable_clock_gating(adev, inst);
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 68397bea5a18..0f178dcf23fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1491,19 +1491,17 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (enable) {
-			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v4_0_5_enable_clock_gating(adev, i);
-		} else {
-			vcn_v4_0_5_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v4_0_5_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v4_0_5_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index fd78472b906a..c651de11e095 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1218,19 +1218,17 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
-	int i;
+	int inst = ip_block->instance;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (enable) {
-			if (RREG32_SOC15(VCN, i, regUVD_STATUS) != UVD_STATUS__IDLE)
-				return -EBUSY;
-			vcn_v5_0_0_enable_clock_gating(adev, i);
-		} else {
-			vcn_v5_0_0_disable_clock_gating(adev, i);
-		}
+	if (enable) {
+		if (RREG32_SOC15(VCN, inst, regUVD_STATUS) != UVD_STATUS__IDLE)
+			return -EBUSY;
+		vcn_v5_0_0_enable_clock_gating(adev, inst);
+	} else {
+		vcn_v5_0_0_disable_clock_gating(adev, inst);
 	}
 
 	return 0;
-- 
2.34.1

