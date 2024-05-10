Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9115C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FBA310E095;
	Fri, 10 May 2024 02:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yf/VBEwE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D6C10E06B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEfLf81E6MG6bdGpwnPMDNggIFv1U9Kr1v441lKWuW5hBimGkweQxAqXot/91LNA6cc2aYQcz/3dtd96rQguutr0Xs5itxT0c7G/OO4OsfcLi3R/NjuQ2IKsSCiCSZn/TwTM0LcZQ2N237Vg7mpSOQsC4m4Z0BtuPOYdnrCu9DSPNXOy15L13+aceJY5UkSahdiEZxKaqEC7vh0kIzpWSwRe96YsEoJal6uApXW9aqpoPM5+04LIyvSMFYAkC41iBEpamVlT3G02jJB2mZTt89rQXjFRiBSRFXv3bXlURpds8D3XWRx1BvshNxQOKJtMUMAl0upwEpsbfc11GuPhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcdbrEaB2dlqCjjgEecgr+LX+Fv8wApejtC1lGQc3IQ=;
 b=E3ss6iSFahWRJnqrsWrHq9nQq/R+waUAzAwiATUGrAuaeWIdu3JRU0ReW3kZR/kGJ0611mRUDX1MuCRhgpoalSSxDoeCT5ZSE6RKM15Nf6BJi4FoSyuzMTFjq6UYjuPD5DwiRftTsi0oH+3bKdSV7+GngnToFWHgsONZ2c7rUJ+9ow3bICZjCogz3lS01bpFT+GwQEjNlct79t3nnW+ZtnJuJhinxoE371mp0zJ/sG/ExBmoyDVtUeT1ek62DtFbeaQLO6ch/Ka8REB2ffyPfbHag4zd0Z78wEfTauvqG6DcaUublSDNh8BtCwixMgVgizZECr1M4HN8ZEu67C+fpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcdbrEaB2dlqCjjgEecgr+LX+Fv8wApejtC1lGQc3IQ=;
 b=yf/VBEwEtGFCZqTHr6EWv4cDhCx66ArUyXVBwZw1BiRIgxrXqlikbA1ut1/RkYIPj5mhysvBMXFgT1/8K+BR7E4bJvl/cFkAv2r1+Ngvgjty+DPcipsyYdNE5wMSLgKcijn/VPsb/BqTYXvjd1TVKNQxkE2NI22JE4y7w5o5fLE=
Received: from PH8PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:2cf::12)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Fri, 10 May
 2024 02:52:16 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::65) by PH8PR07CA0044.outlook.office365.com
 (2603:10b6:510:2cf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 02:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:52:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:52:14 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:52:07 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 05/22] drm/amd/pm: check specific index for aldebaran
Date: Fri, 10 May 2024 10:50:21 +0800
Message-ID: <20240510025038.3488381-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e5dea2-a475-47e9-7e9b-08dc709c3340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZPdx0d3RncF9f5c/mxih9nvlQJaJYKL1NRWrZiklRPQ3RgdezQTrZLAEwl9+?=
 =?us-ascii?Q?7sF8nt1pgZ6mdqTAhlU/B8Bgah1UZaAWTLdUHjYV1erwHladbSljJoUhmdLB?=
 =?us-ascii?Q?X/VeEa98yfkCK60x3qi9oc60SASgkn9ipqDS1+oLr8nqNZY7/kDme1ccDYec?=
 =?us-ascii?Q?dUxHsBpplxi/XhVhOPm/1Zg/FG7XnUPEyDf660H9YnA18bATyhdkoFO6H9ad?=
 =?us-ascii?Q?wtjeaDc5nJFiumUhoS1gQB7TcsdUeW81aPN0pvDlOlW2T6zNsYqutkJAy6B4?=
 =?us-ascii?Q?md7KHmiYSSvfekwbXXf9wDz3ZRYWYSmnVEI8M6xCPWQJbECswUalUWr4ZQcE?=
 =?us-ascii?Q?CbFxVC6xhuoUC9vHxM2kiOjpZ6bjJ/eCrHpz0TNOrJCvmDerki2tG2mq+7s/?=
 =?us-ascii?Q?FBgg2PEuRs2HAuJhuYxgl6/yfByGxI1UTEbo1xEoLXBewMB3JWOP72NBDp5T?=
 =?us-ascii?Q?qjqW9XbzDUi6EyCRqkdJt9fLsQzTYP4C/EpDW2oJiZ0L4y+Ac7IViOSzzEIO?=
 =?us-ascii?Q?ViT+RGYk1ECuY27I0QIrzOl9Bwu4apyJv68LNWmAphQCbWMe8q1y3fwi9pyf?=
 =?us-ascii?Q?Jp9tLpHCn0gqLqwURZqr39WJ6FIPpzgFmEeiw7w34+mUFWMQAlRC98v6B+O2?=
 =?us-ascii?Q?XXM9NVQ8LJGeDuKLfehFvFVDqsdjbp4Ryk9oDVE5evlVrcBfcGNiygTSIJzf?=
 =?us-ascii?Q?EB8MU+R7qkIntAad/X68L26HA2IH5xqjh+j2Qo1Q7D8olM4mdXbbongc9LiI?=
 =?us-ascii?Q?xFxPLhuENBdUHqtkoGsLD92pOxoUe7BqGFIM/ESWrbeRnhprJd0eL8CXYLZW?=
 =?us-ascii?Q?pVaDY6B+D9W7x1yKfZWdylPCDrDo+5VwdwGLANxFCpw97izM7fMGURSY8NZ5?=
 =?us-ascii?Q?Tg/Xtbv4+qxiHfyLqoz00cYkjcrl/uS92lVY2Yw9lkKWv43oLd2hDgJr7BDq?=
 =?us-ascii?Q?k3tsOLB2Flj2Mut+2doVvzWnbFhyLD5PE+dIejzKe3uojVoHVWvpWTh3j7Sc?=
 =?us-ascii?Q?0Xhg1M7k/GS6XD3XNaExyWnDg0Gq0lWKYMai0g43kOxNl+U/D/LIrV0+ZFM3?=
 =?us-ascii?Q?q/pIKRvSzLSDCNdsgD2R5iB3C2wqNCM+qI1z8PH6F5Q4ecy5iBssNhXzCnjQ?=
 =?us-ascii?Q?jpGJkxcyTzG+BEJ2pUNTchyv0T+/95w7QjxIvGZqD0SQOQknFY1LnqTxHhQW?=
 =?us-ascii?Q?oFtzxMUzkVV0Pq1jYGTjqMBKZ/WlOBZmZ9Yu8KR2xb3xSbVBtQnIcigfQ/xv?=
 =?us-ascii?Q?/6Z4N8KcfBpxcDEp7AEkJeck4gG012CwttfPxiXJtd4wviDEJyqey2uSawEN?=
 =?us-ascii?Q?CtwNPh8Za+8BrM3sJ+vZhOD7KQL0xy9cddP91+S1V7eNXE4UYdADYSQe3IQs?=
 =?us-ascii?Q?vq8lORU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:52:15.5435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e5dea2-a475-47e9-7e9b-08dc709c3340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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

Check for specific indexes that may be invalid values.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ce941fbb9cfb..a22eb6bbb05e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1886,7 +1886,8 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 						SMU_MSG_GfxDeviceDriverReset);
-
+	if (index < 0 )
+		return -EINVAL;
 	mutex_lock(&smu->message_lock);
 	if (smu->smc_fw_version >= 0x00441400) {
 		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
-- 
2.25.1

