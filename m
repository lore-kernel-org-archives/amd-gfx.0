Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6AEC3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F82A10E6C3;
	Wed, 14 May 2025 17:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="imPlgHMu";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3357210E6C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meUuVT87/k8JoDK8iLb5tZNve4Xcv4n/iiHB5+ZbUsPpn+IvCEJFB3TOerfzFStsL2Oq4TXjtXVQV1jPtz0FndcIaX3xGpA/RCVQbIe/QUCai9Qyupyr30VP3v1JjzkWOBiqYZmRnaGsY5sVGJ5oEHXx0PnMWcxLAqwqGQVIjIRLDKxypcS4R6vze/KYxujVjGWDwnrkJoJyEUEFHD3Kai/Mv8XaR4TTxqytR64sLQgoo4uvXbw2sBUcUlGjazky6S+MxRUp93+XSj2bTB3mk8ql8prLNy7fDocBRVz5vAgaaaRapxDmyztVVR17TULMyodRuJqlfV1xHKqUA/1YCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDytOF9NZ0/c4ThC7FhGYb57L5IZ0gpt6q6xdveR4Q4=;
 b=Z3ACvdxd3ygny/41IFbr3HqRxTVDpoY3Xr3+BOcc1ul5f5SKmgyXYTzmlJT+Jy2uICP4oQtalKwLDTlBUUD7Ym9YwSkK0S3yq0hhG43Bcj1jBMBIKb5I2MjFThUm1cD0w6gNkBCMhZ13DxGgv8TuAcJoWzPZCPqONqrAEZnVz+GYQEP4fAwqH4gRpoXMBsR6C2vaGKcqOIKCy4Dd6HvARntgdlRAE/gsd1ivHhNnA0jftwA2V/S/zLwPWSCOSl3Qqf5mJ+ES4UaQ3TmF4SO0EhRtbmxatOzVRmXWVOrYJkfzvVaTsuuBcT6VQNl8qp0Wk+HzI/BKP4UFt+zQI38APg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDytOF9NZ0/c4ThC7FhGYb57L5IZ0gpt6q6xdveR4Q4=;
 b=imPlgHMu/MOUBaTJCkIxx1W/8WAp44wBSr451O6MvgF7Wg7HihcpXjtLzZ4458/T+SJn56oW+E2xGjG2yps35YfBdUhUhHmFR3nkLNL/U8v6aG/F5uETJoXatPjPm4tRsdp6VpjlgkbayHItul1PU3f91K1NIkz0A/mF5R/5zPM=
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 14 May
 2025 17:23:12 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::8b) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.29 via Frontend Transport; Wed,
 14 May 2025 17:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:23:12 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 12:23:06 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v1 8/8] drm/amdgpu: read back register after written
Date: Wed, 14 May 2025 13:22:51 -0400
Message-ID: <20250514172251.726484-9-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 137e18c9-b073-4c5e-f1c7-08dd930c0131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oXcF2lgxUhr+cHANPwVXyHlPy1ep1opy57K2UWoiMjHbDpj9a5sgdp/HIHGd?=
 =?us-ascii?Q?YINJfi0PjuIARkrBaQCBJ4cJiQnOg4tdqEOO/PZFZruf5TihVKszCVjq9u8N?=
 =?us-ascii?Q?wHtKkq4E9u2o7pRW5CN9OwAMU0U2ugaiHXWvQAPqFH122CBaKjfYiGUyrt6D?=
 =?us-ascii?Q?fHF5kvLAlcL5bgCtxhOwtaSh822o1r0j4ozl6ny055MkLErxY6XuSWfqbHuZ?=
 =?us-ascii?Q?Ygus7mlbvCeRmh+0gfcdQm/FBPDxbj5S5PTGbVWYyoQTBc0kQw8lAJCBqKOO?=
 =?us-ascii?Q?sB9O1OpbX1AVgYiuLBll5B4mPOUDZ65gFeapzn0ulBtj5ORS0PmCK64KLQZ/?=
 =?us-ascii?Q?lHIVa4Ca/c9rftL4f4pMT7eIRsh3qP+D0+M8rPzK08+U4oxoGwFscBRl5E6C?=
 =?us-ascii?Q?PNL2UdgxLrxgiCEvAjB6QToCN6a4cTj8GyB46f4FaqCgltyn8rrMBRcbo1uv?=
 =?us-ascii?Q?pnLB3A0NvN7iV6OogxXEXxi1CGqjOzkFXfXVtgee2hzoIuuNFfZcAx3LHcnc?=
 =?us-ascii?Q?/A0cXWCQhAFbMpbyherCsRjXmp0Db30G16Vi9chqDDSaqGkw3F6Ogv5KFvbv?=
 =?us-ascii?Q?18pNbeix5ld81L6iSHoEwRz1J5qwbbzsHRTKBED+rjn2ReElsZ5KixrMIpFN?=
 =?us-ascii?Q?CinvleoqGHFawxV0YWybjJJ4154OWycA+08HkhxoUhDcXpJu1JsKxqCdQUaQ?=
 =?us-ascii?Q?VSsyHISdIuLLwNXbbHaVj1fLJG2n5eLlsVlyI8CNuNUGjEEtVoXUBXDIqQjr?=
 =?us-ascii?Q?Zir8UASajbsSxgrWQvNBS/QzRa5R+pTLgGKypLc9vECAgrhomikUBOn+dcb6?=
 =?us-ascii?Q?ygXTJI8UhcLyihernj2yaBIK3/I5pZF6FaAzxFsKBJxLoO6z+Tv8r9PdoBSU?=
 =?us-ascii?Q?7Gp+h9Bb5sgFz3p1764nTS3sQDuI1NanUlYL66GUGpEh/kMUMdJ1eXVhwRH9?=
 =?us-ascii?Q?c6MRbsNq+RTvDY6oUoM7hjleW3vNQjsUloIqtLG0ydx+bHeLyzecIGRLHiwM?=
 =?us-ascii?Q?LhpmE342HXH9R6UDd+II8Ak54kjuWoTDQG33yx5zhVAD9a6svDEi44gNXi7O?=
 =?us-ascii?Q?Hs1wMyvpL2KijrlqCSItzZFxG9Jzka/+2r/N/icJVIeg4rjBaCHgF2Ap2pd3?=
 =?us-ascii?Q?kqzHS1XC3BcjGuOIGxCOaEMp/oMjSqdikTEYHrAqYKZ5Av06ev74DDduQqJ9?=
 =?us-ascii?Q?3hF8MEgd8NiU6ltPF1PGax2QYkwcQ1yoa/HVbc8pnn3DNCD4MnpVchTDI+Uw?=
 =?us-ascii?Q?y5YeG6A5fm0KhxTBi/HcPv9nc2NHHs+PzdiT6dN/yC/OFjtAAxtMszx3M6t9?=
 =?us-ascii?Q?PcxrqwGtGr1yLqWVLmUXV/C9fiPJkg9D9Dw7vU7pXaHn05WGWRfoS645v+mI?=
 =?us-ascii?Q?LesVbeeCOkD4JODg909nxS+Zsna0QLp04loyXFaKBesP4hvOiSda5bx5Zcnr?=
 =?us-ascii?Q?ezr6JN2F9eeLByD+MuUmVQL635ZoQYl6gZuxab4YTUhBfYNHVpVrRBkfSaah?=
 =?us-ascii?Q?uQW3Hz6Nw3k5q8WOKSOh17eRgWwK/PjP5Mfz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:23:12.4157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137e18c9-b073-4c5e-f1c7-08dd930c0131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

The addition of register read-back in VCN v5.0.1 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 60ee6e02e6ac..edf6d29dccb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -809,6 +809,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+
 	return 0;
 }
 
-- 
2.49.0

