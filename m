Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AFACF34CB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF9B10E651;
	Wed, 19 Nov 2025 15:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gC0CUZdV";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8D210E64F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=og/l5tdnDZTz9R1SlRd2+7b6pV1RcVh4wKQQ659MjJ9jnGVgbDbkmpEUTY143i7AfzTlPY8BQm2lO24L0cv6/B4O+Z/n4hcaR6RB80K+a0aC2aO7/P4xKIYzeffMfE51ZEVpUGlxb0ZXgMU9z0ZlFp3lLXFgJngwD9+66cujm1ewJQxuqwdGy500GLQi6hnug1P3R96Tiz0dIsLojYjK8cGpz7oar0pvfK1VKs5LxrWt2X/LoeZ0VengCfDSbCUxbQFsws1iH/JXJMYi21JLsaIjkymi9yohajav2GK1DtmsjLfAz1TuBe6Lq05fizzYs0j1KrrnU/QVevjwhb/MFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwKfGSV6K/7MMR5zaBy4ugk22GW+ndVegOqAsV4zwZs=;
 b=kqVpD1Ex2B8Fu0aMUWovYd0DhtXTdc5dBuP9utiNG0hU5p7Auhp8xh2Orxon1hS+mobitZ1lTynPecd3oR9qR9CC7N+xSXMKoZQYfUb/dMCLarOrEWzoH9GRIyqc+uv+J8JG+n4oGX8vH1kOjp3A+nX1ijLT8JhT+3w4CEA5qgynb4WIEihN0nWhc39ip6yR31Gb7PdkXMKHYrnexX8hmv72aC+OE2TuX02ewmRU9SrCrCaGVGydET+Oigtq65CKaGbYgM9ag1dxcWx01tAo2Iu2Yq8NX8JjMqjuOZdpvqKNUZyml7okZ5mmAKl2OljfHF5szirNANPk9E/rJ5MWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwKfGSV6K/7MMR5zaBy4ugk22GW+ndVegOqAsV4zwZs=;
 b=gC0CUZdV2AqkQtgZmBrwDTC//pX4avmeiS+/rlHqAIT2wQZIc1PQeTjr1wqzDspVaBz0RtfzXxpuzwjUc/+ZOXp9zaRshC7MubDNkV1/qMiIjp3Cg9T8efTLFz29QQHLv7TZN3tvASiZ4Nn8a/ORYvJ0am6+i566k2NNjyHzyOA=
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:06:17 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::26) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Wed,
 19 Nov 2025 15:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:06:17 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:06:15 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: Always set snoop bit in PDE on GFX 12.1
Date: Wed, 19 Nov 2025 10:05:57 -0500
Message-ID: <20251119150600.3663611-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119150600.3663611-1-alexander.deucher@amd.com>
References: <20251119150600.3663611-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 98698067-d5c3-4144-3b4b-08de277d30e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xqb46fxrVRU2hIoOLQaK3KoNR0T3PIMcZSyZXwZFHQ8gJqsN6tAUT8gPNDdl?=
 =?us-ascii?Q?g2do466bz/eb1yfPmsWWlh9obVns+JlcUaQNj2ng9FKYT2cJWynL5OKbl2y+?=
 =?us-ascii?Q?ea/Fy7QYWWWoA37e+WgTXhr63VuNOHfpi1byU/8CM/teFnCMTOYuMA8NXALi?=
 =?us-ascii?Q?xMhpQ3aGxgofEk5s5Q6vicf1C9NZwIuFH0jAwY2aEf4u7RlECot5x50ukkhE?=
 =?us-ascii?Q?3C+9Rr7JP7JmIaSvbMOI6fbddWZ8dKVJFgZ5a6+vFwXj5aL+kTGzHn3csa0Q?=
 =?us-ascii?Q?r6qBK7GZBmrG3y+K2G6z1AE+Kn+pdNdzj9hUsOl888FgjJes2ZVnPMHvMsbq?=
 =?us-ascii?Q?LRmjKwWpePXWQl3SgCYWLX6gTG40C8nxJWjkMcY5qdAAGs+nFbWUa54E5aUI?=
 =?us-ascii?Q?h0TYX6gUieRnHsbdj0Lkvvm+zx/61xfcUroJw3M27bnfzHmo/40sNiCXTrG6?=
 =?us-ascii?Q?bpXwfEeosKoF83eKq6Gusg9DNzMHfFFNI3bQgxQN6bIUY5fyLiOmR1PL4Mud?=
 =?us-ascii?Q?MDc3VzwEBmE3GGk6Q0pO2j8urU5cpJaWZPXJaPjl+Z2IjgT5CrOfRdeDbrmP?=
 =?us-ascii?Q?wClyCC3zj7FoUTjNHjmMoYrY2/k9YX0PR3d60ZFcHOBTKXPKB7irHaEQ/Cx/?=
 =?us-ascii?Q?ybCVcrtwHLXyAGsVneh2QT45YpTS9stUmevrgNK4PTJeqNMYGZtszPn/kygh?=
 =?us-ascii?Q?mSrh1WbD+IsYc72z4O9f1PfCZqY7q6P0k3nFPhCoi1GuzOo6JkmIrmOSWpM9?=
 =?us-ascii?Q?e6hq0e0B4OuZ2BKjeBNK5gCX6ao4OpSlg0zfx7GITWk/OHnf3d6Dkz5H0xfa?=
 =?us-ascii?Q?wJtbeeYu5RqhMndn6mCdKQQVj113CPUVusPKLRoy4+r2eRQWSX14tzbf7kyC?=
 =?us-ascii?Q?w/fl9UdMptxgou0Ld21jo9Hh/C4pV+WCFKYD3bRB1+KVphXu9I8hQCfxJ1Uk?=
 =?us-ascii?Q?QfPjYgk0HIZW2XAinLV75/vetw/b8GHxJO5/QQ1Rv6ZqsMVrkaRcfiFJs8wb?=
 =?us-ascii?Q?VP4KdAKtEHTsOdoLbXERI9jHacmLmg5i1WfjsZmvx1je2SdUzcLDM9Map5FG?=
 =?us-ascii?Q?r8AcS/No6vo+DEzdYq11UrOd8vNZifH5O/9tFuzfvmXzc75bDiYixXXaJCii?=
 =?us-ascii?Q?U7Dth+OP4xfYhDxIuZRJ4zxi4RCKv84JmZmt3ibGn6cJpSSxyafebWps4q47?=
 =?us-ascii?Q?cg29olKdJr+ixZ+C/0LypBekyUUnkZrsnsutIzW/yut94zvgQWBj7hTbm1Kr?=
 =?us-ascii?Q?VEy8Jjkvvt3QB05oCSU7+9ifWeNoJWE+l/lzpdOFbpdFW1SR/Y8y3lq1sAbg?=
 =?us-ascii?Q?Pt0wMV6Kk17sywR2n2+DDTu3iRh5hhqvemlzYvZQrCWeC/nrii3ztqvEmelh?=
 =?us-ascii?Q?CHkjQh3tiDla/W692RwshTV5CA99pUIWE8P5qyMaZ8oqolrXZbTH0YI5yXSi?=
 =?us-ascii?Q?eAE5YB2q/x2jiYZkNFx52UlcHtIxeXWbc4WRj/bGZBvmrYBO1NCaL4Q/9Rci?=
 =?us-ascii?Q?DNYyET0EmEihmdTYuJwNWz1BqR8AbXGFEFfq9cfW00fxPbUs22ROECZRpZQ5?=
 =?us-ascii?Q?jAYnlBTpPljix43zAEk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:06:17.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98698067-d5c3-4144-3b4b-08de277d30e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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

From: Mukul Joshi <mukul.joshi@amd.com>

GFX 12.1 has the requirement to always set snoop bit in PDE
to maintain coherency.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 347be0ef07ec8..ae08f8b3bfbc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -249,6 +249,8 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 			adev->gmc.vram_start;
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
+	*flags |= AMDGPU_PTE_SNOOPED;
+
 	if (!adev->gmc.translate_further)
 		return;
 
-- 
2.51.1

