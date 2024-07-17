Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F63C3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76FFA10E41E;
	Wed, 17 Jul 2024 20:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eghGx5Jq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66B610E41C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBeGYcPqpiQy2dE+pUD5qyfE/egSJ9gTrNhLC6e7WWe8JzLDo/g+oWN1uyiu+hvgK1t0oOB+xHMuILk4fmm5rDwwCRnvT+fNEd++dgG4oj0nEkt3hTfvVmLfkfKQO6bVuaSdRuOhvFZwAJ/AQ2sIHU0CBluleFNv1hgn0NMTIk2CFF11WM53MuyVffkz97uMdBkKPZcObyy35RM+vLPRAPQVqhwIZNAbCPG2g2QV98oQrcEnQj0VynF0S/prCjq4kVNNnsCwf0nY01Cr+PJhbHvpZXs0wWJw09aLhiD8VhcRbYl83Kee1pUbEUdCcnmQPkHNIFQdQL6HUX6JA1IzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=052t40xtLSG+THlnVEkz+bngkNLpKPwOLn6ILYs4kME=;
 b=uv9pQJ4AY/3z9SjSjJLrg+L1d+twX6QPmNyhi1YUk6o2lc473cpLWubyBYzt6yE071zC1LzSQljpvjhIcZ2tVUKg6OI/3YRznPWEVcQrBY1AKh/nasnYQmwUKSIPUNiKx5uT39Q0Z4Bd2t0238TIYSif2XCAi6VhMXXarS9jlcUEDbkSM7Ht4jJacXQSVtCZnRKf3wHwVFUbqnF7Ofou8NMTmK5N0a7oA7H7cgjZhTDXIV9SelnPNVP5ZiutMtbUvMuC6IZV5W3qGApkJqVGs0E9iTLwWA1A+mp8UXAWtICF5YDsqbuHlw+nuikbdrj/S89llWyZA9pOyO09GK6oDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=052t40xtLSG+THlnVEkz+bngkNLpKPwOLn6ILYs4kME=;
 b=eghGx5JqI/8SHe+Ors2Ry3QJx9UhapGGfliWlc0tnkR1pwYiq3Q8a0vKDuRCZreJ8i5e9ciuRov/qlht2bLUpCyDlvQza2Nz9jPIGPI5L3Zqw8R3SIbOTvVfnfCUWh2fTRDbkW/zgF5qy3wYgtOV6uYvoxQLP5KeYdE8VXuZKo4=
Received: from MN2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:208:23c::7)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:38:04 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::47) by MN2PR18CA0002.outlook.office365.com
 (2603:10b6:208:23c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 20:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:38:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:37:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/gfx12: enable wave kill for compute queues
Date: Wed, 17 Jul 2024 16:37:40 -0400
Message-ID: <20240717203740.14059-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203740.14059-1-alexander.deucher@amd.com>
References: <20240717203740.14059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 065cf4f3-fe2d-4ebe-6b97-08dca6a05b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U/LadNbVwFtNUq3nQSZyAnrree3YKkzk/C/1/omi4dWSkyGiKA72FA1u2Qfw?=
 =?us-ascii?Q?dMCN+Ccmgk0GuVwADWaN3LsTj/nxlZfagUhAJdDl+bQ55WhTOI8pv2UbRK/Z?=
 =?us-ascii?Q?jBhuDUnFRJ/pR0kDl8AqEzhXWmiHFYd7YYnKzojF5ccxhRX1Wv5rEieEWQ7F?=
 =?us-ascii?Q?ZRD4U2CXj0PSO045mBb6LoqfPRMJV27edZkkzCHD+YWD3Pa+kJUfu/4OOyME?=
 =?us-ascii?Q?wgaiVBxrN3PJ6Puj+YGxcZuWE5wWiwxdYM0XMDECBFehgilCrE6tjMooPd24?=
 =?us-ascii?Q?zJ0o7ltEadgiGd6qeg5/wmTkTTzwNV9y1rI7GmM0B6VDxoQAmOGMqbzGFPDi?=
 =?us-ascii?Q?92nhgILXhX11MQ4xfccbFkfxeBisEjbqtIb1wQicO8NTMkf5QF5fP0E0iZcY?=
 =?us-ascii?Q?VxBCUYMPyjacnLhOQnHneOAi0E/Pc13bELXZsmXSa0PXeJPR4fpMfvN3NM0M?=
 =?us-ascii?Q?2sqfD5Qr3EUcbO2vOyVvKBfgQ8Q6pt/3yG+/hhfYVosZUdZ1aL3sllQDFnsw?=
 =?us-ascii?Q?Ams2BpBGEIw5NeVhtthFmb/B6Vz/B5RRA3UPj/oGOHowWhiiJhmd5OoW36kO?=
 =?us-ascii?Q?2S+Lp7rvwQ3KNOgsIdUYzd8ttEsXUEd+fRlaUiMH2BGPQgz8qe/0ovsWOjGl?=
 =?us-ascii?Q?0zJM1FkC46b/ri4H2V/5x0iLIskQiWUIHSxS0hd4ExNAsL2zn2d2T6BwjZgf?=
 =?us-ascii?Q?eC0Zf8WIZuD9SPzz0aGPQH36bB6i4nxtiNRqHuhhUFRAnPprnNPQzxeBoCFd?=
 =?us-ascii?Q?SliY7h8PzBaFPAyoNHinj4kXOOv/5EkHpUUIZlrxeGU0joZtageHiSpewSln?=
 =?us-ascii?Q?3TyaJdHYCm8/GMDJhteWJf0loxQfrtt9Tw056cUxYv06i4Tu20J3Ha9HEdys?=
 =?us-ascii?Q?NbnEVx9idyK+Ztssbicv/hAH2Wty0G1Oiw5vOyLwaAGnSf/JYYq4Pvue9OwF?=
 =?us-ascii?Q?LuvYhD/u0CPoLVTkQF89dq54NoaSROYT5SXsYSWTlGHB+eA6QKaNSeH8H1fg?=
 =?us-ascii?Q?pOO7t4aosKKsygUk3ka9tYyps8s88ksWIoLwzPcujGaP704qQnBlvmBEJcd8?=
 =?us-ascii?Q?RGVNIk3BPsGshrzppxnA2+wUnyi1pC8fXqq+wZLjmcGnoTbuxA1D9pBvwjul?=
 =?us-ascii?Q?4J4XtMpJDfy1L7liQ05zEoPa4qSK6CPAxYaa8W1UDQwFoYwAJ+p3dn53nZ0f?=
 =?us-ascii?Q?B9YL3eWUwQGpFRLvoDdrCBH+EAucg48pwbEYekBX6Nm/uXroR5U1+3CRw15R?=
 =?us-ascii?Q?gR4cksjWX1ohBj5pP0r+ccf12NyHAdl4eJCdVIaFmGW9U0c5t06iXfYj11mc?=
 =?us-ascii?Q?Y+99WGZswurNQm4Oc+aw5My7un5QVIxVNQxf4bAmEQE4cZKiTTA5kgfiQknA?=
 =?us-ascii?Q?2ZQ5UZpJsJ7UjXcg1Ahla9zI0s921SIVVXkUsrEGDDfIr+tOyUxEiKI9CFW+?=
 =?us-ascii?Q?xMARXyAXezBxMvhuJbOlX1WkJBrh24Fg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:38:03.5266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 065cf4f3-fe2d-4ebe-6b97-08dca6a05b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f384be0d1800..567f9196d6a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5081,6 +5081,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
+	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 };
 
-- 
2.45.2

