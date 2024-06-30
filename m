Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2468C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7587610E19D;
	Sun, 30 Jun 2024 14:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yuZBxe5C";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FAA10E1D2
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmQSVV5+652KFYZHKZXm7A4/PLm2MnhZn5l7Y30/EgfsENzHK/1GSzKlou752+NcNzbF6IgjF0uNwb5VM+MwxOgf5bJC3X7qOcTPEznutZJLQw6mfAYN76k9fsYeBzGbP9kGPgv2krQS3x1pNDoE4DkxTUEvPTEDaTkBq0sCvH0K2/n4UdcRzBydgy+b5kYsndCA+qiTWuaBxqzKtXVbvGldBA0j+dDCf/rOrkeGJ3xIbOr1aLw+F4wPn5aun/+WBj4Cn1WIrZgg58iQRqTYcIGuOihrpJ24TyAzMpB+6WU2ZlxeHT7XIQmfJmYGJMr6YHBWLFva7PTXmTacTWPIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmLRSvAKE6Fj7KQb5+OmL3DdwVD93BoBkmgt/Z87ZVI=;
 b=aMj+w//t1UeloH1aoltqr0bjQ38gRMR7KOfxP/Je6IDxplX/wsPTl0QQleCLH7bYcMgDSo3DwRLvgrAjDVTlXdg0gashDR9Y9t3+3tXWLAMG4ci46RAq32vj+EQi+gP7onJxIR+rxZfZalERur96Le5gOhm5orm4U098XUbV4h9GHWushT6GnzMKrBwN8sWtTXnnQgSsPZkZpquCOfNNFyP8blJm5a8mFd5F6C0f7Oa6oUwhtuQoPWBWJTxZiBaRda50fva0HkP2S7MHsF8TiwJQk2WfpBnTyEPse0FUt1T1wHMo5f/43Gr4uiOsaQME1LzZUYiCSRejyWHYnUScXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmLRSvAKE6Fj7KQb5+OmL3DdwVD93BoBkmgt/Z87ZVI=;
 b=yuZBxe5Cw/KMAKCnMqy/sSka8znmDyvgBXyZ9sjpQ+DlB9Aj6Dm9M2qwmg1twxq86Ak48sxq0xboPJZxUjrkBdbboMASvMrfkucNhITcc7SPAu4GX2SKZBxwIs0CyYVvIVKgUsHXe7/3XoaD8/cWNOeOAg8hM17ktT8qWf7mDhA=
Received: from SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:54:16 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::c0) by SN7PR04CA0014.outlook.office365.com
 (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:54:15 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:54:13 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add VPE IP v6.1.3 support
Date: Sun, 30 Jun 2024 22:50:44 +0800
Message-ID: <20240630145046.2021348-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SN7PR12MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: 51edf7b0-750c-4940-47c7-08dc99148335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NPWZ3szOPmaRNHLjbqSs8zXg3L1AsOioTj0yl9s5B5kxLfM7NTmlcMqLvU44?=
 =?us-ascii?Q?NleECnxH83I3EEqa6OhplFnaNk0BWdGs78VOUhopOxcAf0tkhQi/5V0IjC/v?=
 =?us-ascii?Q?8WpJugBe+PrlLuvy8EukFHWTow4M/sp53aKghl/bC0dvF1ZbhQRMQ36TzA8l?=
 =?us-ascii?Q?L0QEyuj3Y969EUcjDqWaJuER8ppy2d4rub4cnIoha2udAltwK27QXYeUVsO9?=
 =?us-ascii?Q?qTwk8eV4SJMY3YwGKGsnWONLy8VJpJGrilX8MV3GQ0RzaQvtVYaK4XeurhSq?=
 =?us-ascii?Q?QAeLYbBUkkqL8j8ogkIG5U4SkpmO2IyGg5I83nuPFEP/9Ikp8L32+uy6jn9/?=
 =?us-ascii?Q?g1hAE9Us9wATVoOKWAkTT59eIkiFrx7VMTZPG0047gCjv2TOgthRfiFd0J2F?=
 =?us-ascii?Q?fva+iLQV6uQh4LhHjWO4xPk4h0DF5iSTX4iFcj+Htdj1LHZ37Z66WDuXLUif?=
 =?us-ascii?Q?6D4v5OgBWIisuhBxLP6bfsouIrJNUSI7AvgzNquBzF+mKyTnUzLi040T3lLW?=
 =?us-ascii?Q?/epJwca/nTKvG7kAhxqC/8XD2VECiE8GgSBK43EmuDWccIvqjbFj2dwMq5ic?=
 =?us-ascii?Q?R92j2eY+xgSxY56Qu5fysO07QEdmb2/HAmcweROynxDWRg3GjlDQvZ+PVsLF?=
 =?us-ascii?Q?O/lURSkxqvTWNKTejw8sKUT8O5ZsQ1MglVdTl4xAoltA8DXXrxZjNfh+eyEp?=
 =?us-ascii?Q?9tycuzwzfZy3g2N4yNKleUMP9IuSb/Grpr0zVA0Jjev+8QF5rGIr/34rFlyM?=
 =?us-ascii?Q?L2Y2q5O8CViA7jEj/7XnbwpuDjwxwSSV8jpXyLMuI4siW9VsxDhOn4j1289A?=
 =?us-ascii?Q?TL2SUhw6ZzRDX4uKSprfYKNrgbzuax5G/S5WthBj1pvZiqew2wIydu0Wu+Sk?=
 =?us-ascii?Q?IcNkR/QBTaCHKQXnOh6YRYiDUEsUNOnJYlm3eyRnupDWoSBjt4JKuqdOc9+T?=
 =?us-ascii?Q?oPOxfuXSdz53x2E6qIHJ7cOjXfTveUfeyW+T7BrQdgLXgFsPnG77nNADAEyd?=
 =?us-ascii?Q?zMXoBNI9zfhvhX49Y0sFunUeiKCIuEikekR0IRrWhMTHiT/SCbZySUujoB0S?=
 =?us-ascii?Q?sO29baqFKlVYHG7eNtkXim4LL2kAp42FuwnEZ3uB+eB517yYp6r9pF9ELQtt?=
 =?us-ascii?Q?fW2qtFTUtY6t2nz93mTQf2DfrvkiqlSRl/h50KhgRKHcCerPl3fuiz1IUAG6?=
 =?us-ascii?Q?gkqKJw6eUWfO4YyXW/RGLup4vAW5iCx+JwKMDgqUcCmhx9gDigK3K4VhY48B?=
 =?us-ascii?Q?y/oun4zX1NId82IiyK0yEdryoDExbWRpS8+lepYbrLnbZ+lPXOT+0Esx8Lo/?=
 =?us-ascii?Q?m4RZ6ouywxA9P56rEDWWu5z1Gbz7VGrI4G39oMf4eBVYtojl5u97I2xnFNCJ?=
 =?us-ascii?Q?SSuxfQZ+IZZ07Jpt5RaquoxCv62hGbb3b2yUQ8tumZ0ccvX91PDRqXID+9qo?=
 =?us-ascii?Q?wznDf/CpN/Tdejs3q12/GQOoQSWOjSei?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:54:15.8689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51edf7b0-750c-4940-47c7-08dc99148335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765
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

This patch is to add VPE 6.1.3 support.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index bad232859972..5acd20ff5979 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -302,6 +302,7 @@ static int vpe_early_init(void *handle)
 
 	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
 	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 1, 3):
 		vpe_v6_1_set_funcs(vpe);
 		break;
 	case IP_VERSION(6, 1, 1):
-- 
2.43.0

