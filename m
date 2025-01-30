Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D89C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 07:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B7E10E29E;
	Thu, 30 Jan 2025 07:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oxCLUL/o";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A9810E29E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 07:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewlozke1NCZMI/AeBqRQKbTsAo3jrbl3XdMKAPq9+BGGbG52HJt5PtoMUdB2GuBU/HW703RdqluTglfeK4kSVdOlJJXtjb5FT9B2o2+AVeBWXAZXp+darXz80LmCTTVPVgOrOidxjPBGQkvK6HlqaHwKn3KDomJeixSOM/J+TufQIOcAqgrK8DvjNHazynFjM4+7dFFAQyYefK4STx5/8DGEIQ1ZlGKw9kUVCrf37KKNeqZbcm+VlCfc8hym7bZ5qj+E72Vd3/ogcDeGQ8jXh6zJuD6cq7yXED2SKaS1RlvTL66Z8DPOxoIESaV3NhLiDh3uDE35EjL23IkoFrCmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/miMTa2eqJXOOJjXY7ul87RrOU9PSzAZa9UntukwuI=;
 b=g5X3Z75A9aiErgs3BB+dmdtJcUT612XJDAZ5xGBhpQTBZzU1qrrqj59BUUKmNDSQEFj+N3RTFwIgPCP+8gSuc2Nais2K1q8l3350tzufh/PP8ByozBcQcGrFkaEDGk5ImMTClp3UEvL7ctWMtcOM0gSMa7N7uaXHYRv2eIbczXCDsER075sV3itLkXJ6cmwFBMzKH7pJ+U8S8iHIF1Vj21R2sGF76H2InQeFmLfySpkexP17bicAgRep4LpWTw5B5SPnNVMButwjWCX+eO2hNLwYAQa1b+uaeDhDxFmkbbDR5dsG241xCyYX4ciML3LyTq1Fmc7iVAXdzwhyPX0w2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/miMTa2eqJXOOJjXY7ul87RrOU9PSzAZa9UntukwuI=;
 b=oxCLUL/oRcMx/TtD/mn+j7XwRC7+GxdLfnKHbKAlRn5cbA2thAK8/ybvJFYrEwprp1JN9R6aF3vO94gFVwPaREELRt4oX4MXzfYY/E5sacIWdZpYOC+g9gfU6DUvCb2NrSkps69OJ0LTuPK2dTsfc+wSDrvQ/xBy2gncbcPxU4w=
Received: from BN0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:e8::32)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Thu, 30 Jan
 2025 07:28:10 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::be) by BN0PR04CA0057.outlook.office365.com
 (2603:10b6:408:e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 07:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 07:28:09 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 01:28:07 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Hawking.Zhang@amd.com>
CC: <Mangesh.Gadre@amd.com>, Asad Kamal <asad.kamal@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: Skip P2S load for SMU v13.0.12
Date: Thu, 30 Jan 2025 15:27:34 +0800
Message-ID: <20250130072734.2219023-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d7c382-0b68-4cc9-dd7e-08dd40ffa590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CVSqrgRkhaPKlvT0SiCpIfRgGPfPrwFDs2Su7YyIt/2eR7qS8eKXMwnymJ56?=
 =?us-ascii?Q?+7VN9+RXYAdwJnrdgn/GMD7mSewRVvK/uJy9aonoHI+q4D4mCZBJa/WNgZox?=
 =?us-ascii?Q?RrnpwMP1JyGZgYV3J/n3DABJG4daYDxApp5G2ZgQh5n+cxvWxwU3Vz68isdE?=
 =?us-ascii?Q?voSJnX+Oq0WPB73m09Yewhx0AFPh5AhbO/PF+Ffif3LhwhZPN83niy7KMbrO?=
 =?us-ascii?Q?me8t2U1Yirz+nNX7MjRvRSqt69owipRHRBwB29i9kU9p8oeYmpRl6TMSPgWx?=
 =?us-ascii?Q?R5oWhduU7qoR2CvYQqa7CjcxPZWnrZCbQ/ET+AloopZQB5igWHA1tbRwNGLZ?=
 =?us-ascii?Q?ztqUQ+LGR0pItiPBqg34s/aqzYp21K5prXNQnpdNAsA4TTtXHOqjlc1CVw/e?=
 =?us-ascii?Q?4tU086kUntSiN9J0qqKnr5OrjVYwLfqsi+C2t3uI2NNNpk5DmKoqZE7GF8lm?=
 =?us-ascii?Q?qsU4nw5gRv/aqwedBu06TiqEMZtsQHX4MRAxMNQr5yg9Dh3siP8hMN791Zxf?=
 =?us-ascii?Q?yt7XVL9Zjnqu4Cdx8A7TLieSiaG3o2qwZIS7FjojJzgekFbSQR9SX0405r8o?=
 =?us-ascii?Q?NXXfNpw70h97WIIintU8AoR7+QoVWwcsZtG6pcPHtvffX8bbKKIqGxs3KQND?=
 =?us-ascii?Q?y7OPbeQBXjuzZP9PuxwDDTxnnEu4ohXIcSeb+Ln+AMM+HqpZ5NFieEptT0WT?=
 =?us-ascii?Q?eZY9lAFXswjb1n7AOd9PgoEkNUOs2SCbTlEarMC1AgaINcCHzr2/aIZpsr3i?=
 =?us-ascii?Q?XIktiCjesYU/H1BMtfaF9ewZYLU3VeK+YTKOHsJpLQSoQCkfMzNLwZhmvZbW?=
 =?us-ascii?Q?K4oEu2MBxd/hV7ZNoLUnxXteZpBkP/Vd5H6yyZnQw8FhCfJHzpK1PNemN+c9?=
 =?us-ascii?Q?Jd4s8mLMBVMX4BIg+F41pBncT0hEc0GGZdSe/jEEa3BKRaczH+pYOziuxoke?=
 =?us-ascii?Q?UpzfXWnX4++W+Fft6jxgoXqUG7pAVR9OZ0AAuF28XCOxGIhwzHU4UVJR8AYr?=
 =?us-ascii?Q?6/UPgQGqHvm9SKS86Fq23rZ9rZ7MW1ZxyMDU1brPc6Ysw7IKUoslrnCZXVQp?=
 =?us-ascii?Q?6sqp4IboeGcMaDLl8cSg/tm3nTHhiCnALMP42kJKNTLbB1mZsw1XP0vL3Pwn?=
 =?us-ascii?Q?/yb5o3A4FO9ljqin04XmHLeZpMTf/R3QXhR9hNWYnr83SQfWuCjlkb7H8WaB?=
 =?us-ascii?Q?7iOTRlKCHDCkb8iGVuyUwA8xmJLaU+l1gPTW0GqXvpfArxTWyecK0oPjQci2?=
 =?us-ascii?Q?zWr8K7K78XVD4/72JqhoN/FDJotwaPDrRhOar0dwkIxYJt0z6U7tAzVG3MHM?=
 =?us-ascii?Q?h6k4hZD+M5JabyqWIO5EGOltRBC+r+xrgHWFTi18sUDuirEtWXADvjqZawCL?=
 =?us-ascii?Q?fG3dBtqgWza4Yli5ZNSNmk8GSx0KGr1xNVoYqD97ADRBSNs1OUjwliQVA0ce?=
 =?us-ascii?Q?Orb/P4aVJIXOJlz6lMzRQz6O9PbRnzQPRRDbyiLBi6U0AiJwmXMH3jcE+iMo?=
 =?us-ascii?Q?K04VF2EtqdpjVrE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 07:28:09.4269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d7c382-0b68-4cc9-dd7e-08dd40ffa590
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
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

From: Asad Kamal <asad.kamal@amd.com>

Skip P2S table load for SMU v13.0.12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cf313da88607..dc839f9a2295 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -464,8 +464,9 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 	int var = (adev->pdev->device & 0xF);
 	char ucode_prefix[15];
 
-	/* No need to load P2S tables in IOV mode */
-	if (amdgpu_sriov_vf(adev))
+	/* No need to load P2S tables in IOV mode or for smu v13.0.12 */
+	if (amdgpu_sriov_vf(adev) ||
+	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)))
 		return 0;
 
 	if (!(adev->flags & AMD_IS_APU)) {
-- 
2.34.1

