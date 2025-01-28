Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B037C0218A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF8210E5FD;
	Tue, 28 Jan 2025 09:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kRp2yXBu";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0DB610E5FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j085nUUUGG5lnfzQUeQmEIeHoeW3Qok8p8AV3sZ2T9dn4xAqDvS5Hx+sTN6GgPKCoatoIbc99pRPA38cg1gV9fG0RIbkIyzpZzcFAtmOSpvSk7+RWBmsnYalCpur00Kkib3STUkSQzO72V6GlD8OEAMxEQXQyJnLwEFnQghy86KBpVyv6YZKf1EGmdFaJQLu1INfXnFKW48avoEo1em+nSdFCzcs5MAhLSJR6tQExqF5DAmkxkzOhvAG6DcIcp2NsUEQNHWfgr8ZT1DvxosDlRQ0OeDEGcBImFs3p6Hr2jFOZCWsw5XykJfRopVr6mESCu9fOFpxNkUnPqwT6YFIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9xPnWSETrwWJF/sQWftZdjvuF6q/ZSBnM+81+DuAxA=;
 b=ANAuVsl0Ip0cThYe4s/M72D+GjLX1SkQ9xFLa1cEtOsM1Fkr2h2dm7UmndkbS5anBWKXxv2hSFH2sOGZGYfMQ1n6ru3CuCpXbPR3uwE+PpTgGlJhlmvtaSP+AB/1ATXCYvoHf0zrCSvYeeOt/tTsXHyz3x1WhefX+atr40mxnYkMK8AVe2utWqG3judlaUMEMWNB7n5rtjIfMBe5pnmnT6/YmQq1wUwolIBORMnbuxutxSaSIgKCZ1ccI9ERc/DGqlB4alcvSwm1JdaBW+BAnbclBknQGc9cticSC4hQu6iSnOd6R8cIelnkaDCjRne/XvsWAWGddbQ8rFNIBZ149g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9xPnWSETrwWJF/sQWftZdjvuF6q/ZSBnM+81+DuAxA=;
 b=kRp2yXBuiwHEQndw2uNvhOpuqUEMW3bWybQElcNYOsF9QtdMgzvFuWc8b0phKxwKvFabBswTJXXsfp29u7MGalu5yUZBaSmT7qfOj/SUBMurNU6BdNdgpOtTsKeQO558KbOPS3KEqy5zgaZi+Kd1X+x4dTy/jyfkPJFw/kAqkes=
Received: from DS7PR03CA0139.namprd03.prod.outlook.com (2603:10b6:5:3b4::24)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 09:11:11 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::f6) by DS7PR03CA0139.outlook.office365.com
 (2603:10b6:5:3b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 09:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:11:10 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:11:08 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: Enable devcoredump for JPEG4_0_3
Date: Tue, 28 Jan 2025 14:39:44 +0530
Message-ID: <20250128090950.461291-4-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f8065f-11b8-4f28-1c84-08dd3f7bb52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L29WNmR6VlBxUlc4RlFBZ296Q2tPa0QxQStRUGNkTy9ieXZGSklzMERsS21p?=
 =?utf-8?B?V0dIN1NYa2Q0aEpWbTBuZURUZ1BLazdROTQ0RXRiV1pvcUNLNXRFMjFiZks4?=
 =?utf-8?B?eE8vVXRkRG9kN2VRcDdMdVpzYjdRT3VuUmJvcUk2TGpUOEY1eTdsd0s1dzBv?=
 =?utf-8?B?a0RKNjVFUlU2NnZXUHg1aEZac3VIb3ByM3p4UFNHOGlmUkhxNHNMUlFOdHhi?=
 =?utf-8?B?anhhKzdkMVBERXo4TXREbWJvQXVjaFhzZWN6RGhZNTVKL0lKMkh2RHQ2VU9Z?=
 =?utf-8?B?MkJlRUxyRmNMaThFT29OUzNwcG11bm9pYk5mTlJEUWZ5SU82RFplVjZkSkl6?=
 =?utf-8?B?QSsvU0hjNHg3TytiYWkraStVL1RheXJTQ0VsamRyVGNXaitUZEhuS1hhakVy?=
 =?utf-8?B?c0hCTldNY1hyL1pTTUhSeWZqOGdBSk9iZVFKQThpOHpWZHVZaEJVZHZ5dThX?=
 =?utf-8?B?Wjd2M2s2MHBGSTRyNnBVUUVsektJTFBoNE1NbEtkZkJLRnlzNVFuMnduSUtF?=
 =?utf-8?B?SCtyMHRnRzZmd3IzOWRiTjI3V05rZGQyWmJzUUZEVjF6ZkVkZUJDTkpqaWhR?=
 =?utf-8?B?Um1naGZQc1FBcnNjMUVDaENtV29KTHVzMWFpNEU0QmNlSjZiTkRqTU5oNlRM?=
 =?utf-8?B?TXFBdlN4S3U0SWtTc1RqVmFqRWFhUmxWdCttUHVGeFhwUytubzIvUnZ5dk9y?=
 =?utf-8?B?ME56WG5FcnIvdHpRTjFUNTh0U0Zldmk2bmkxQlUzcFlPZ1VNVDV4K1NOOXhm?=
 =?utf-8?B?aDJPZEhjYjNXQUNtSG91aXBiRDlQY3p6a1BRWk5zcFl4bll1T2Z6Z3dUYUdF?=
 =?utf-8?B?c2lpcUZRZmN0NEg0aFpqOGg0M1RSNFJYTWl1d0dwVmxNYThObzEyNEl5clRF?=
 =?utf-8?B?ZFlhQy9KTUI3YVRNV1BMRFBCcGxGTElpR0VWdFRwQkQwNW9LdjgzaWV1YVJj?=
 =?utf-8?B?VFlPZEloZU9CZTZMcFVvVXpMRTByUmxIVTNvZFl4ZG1oTU1XU0lka2dQT1Bt?=
 =?utf-8?B?Y05SdndWS2RjNDUvd0ZJL2FDZmFwVHZ1MnFpRVRzbmxrbFVXZFEwTUhTWmtI?=
 =?utf-8?B?dVBoTXJ6b1Q1cFRJbEFnR2U1emNOTHJrTno1cTBXRG5GQXpzbE5tVmtrNDZk?=
 =?utf-8?B?WVJkSng3WUswWlBmV2RJRkFJSTVCSEdnVCtLMDdvZ1JIYXlBbDBaN1lrSFRr?=
 =?utf-8?B?cVE0MFU5SzlHdnlOWjMrNktnd1NmbnRTWkFxZEpTbEpVS0QrVjFPYmlIbCtt?=
 =?utf-8?B?QWxOZ0M5V0FMdUZjeTljaGZ2dld1bktLb2Z0blFpNTVaMm9iK0pKVjhkelZx?=
 =?utf-8?B?U2VIcTVISnZBeVNxQjJzSCtjeUJpY1hLMkU2QlRsLy9yRVM0ajdPaUxtcTZD?=
 =?utf-8?B?ZUlyK0xoTVZyYWVLUWxiWDZXUTE0VGI3ZitzZEU2V2pMWGFqbUxETHRYMmoy?=
 =?utf-8?B?U2o0eTNZU3Y3SGFOVGljeldDeVZ0VnpVOVNlQXkrcEpydUl6ZThYT0poM3po?=
 =?utf-8?B?OFlZaUJUdjVySnRjU2JLOEZRSjQyWnhuQmNXeS9OaUx5cU1WM1pTRHNQa3gv?=
 =?utf-8?B?cUQ1Q0o2TmU5TGkxRWxad3pWbC9TNUdqTE00VVkxWkFJWkJ1OWZaRVZhMWMv?=
 =?utf-8?B?Z211NzR2SkMvTUxUbTFSb3cxSmxxdmdqNEc4QjdNbTdTY05OZ1B3ZU9mT1RR?=
 =?utf-8?B?UDc2Y004ZXNyNkJJTzdBSEFEbHpJMEpaOVN2RW84eXpLMmtjWVYwMU9FYUZp?=
 =?utf-8?B?TklYR3JSaDRLcVlCbUxUV0JrVk13ZGxkUm5lSG9yY25wOEdScytvVkRQdnda?=
 =?utf-8?B?ZURoNGk5VHgwVWt4dXltZ1JjelNpcEhSZVh5NEUyeERoR3o3ZWt6dkl5UHR5?=
 =?utf-8?B?SGNaNnlHZmZPQXhQaEUwcjU0QXRibmp2eHU2SE96NXQ2bDU0dTRxMmo1ZGlK?=
 =?utf-8?B?NmhtUzFOay9RTjMrNVdwRzBkcHFaQkNjZkpSVlV6OUlnSEttemZ1RWJmU0NM?=
 =?utf-8?Q?2CHDb4aZvsE60zOdr8JX6F5shqVjYs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:11:10.8413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f8065f-11b8-4f28-1c84-08dd3f7bb52b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
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

Add register list and enable devcoredump for JPEG4_0_3

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index bc21f12daea8..39fd678dd874 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -47,6 +47,8 @@ static int jpeg_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring);
+static void jpeg_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block);
+static void jpeg_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 
 static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_4_0__SRCID__JPEG_DECODE,
@@ -59,6 +61,42 @@ static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_4_0__SRCID__JPEG7_DECODE
 };
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0_3[] = {
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_SYS_INT_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_UV_PITCH),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
+};
+
 static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 {
 	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
@@ -164,6 +202,11 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_4_0_3),
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump)
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -193,6 +236,8 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	kfree(adev->jpeg.ip_dump);
+
 	return r;
 }
 
@@ -1053,6 +1098,17 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v4_0_3_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_4_0_3, ARRAY_SIZE(jpeg_reg_list_4_0_3));
+}
+
+static void jpeg_v4_0_3_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_4_0_3,
+				   ARRAY_SIZE(jpeg_reg_list_4_0_3));
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.name = "jpeg_v4_0_3",
 	.early_init = jpeg_v4_0_3_early_init,
@@ -1066,6 +1122,8 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_3_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_3_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_3_set_powergating_state,
+	.dump_ip_state = jpeg_v4_0_3_dump_ip_state,
+	.print_ip_state = jpeg_v4_0_3_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
-- 
2.25.1

