Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E90EE20A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9160C10E733;
	Fri,  6 Feb 2026 13:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B5ffge9D";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D40D10E733
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8EmuGd6P6U4NfYCw3tiuGfOvvqFd9TymxA1CrsxepoYZIqmoar4+SYJcI9hn+xngzedNM1A3JXsbAw7fSmu7cXMslGSUipHaPSxWd9C7DT0fpuv7rP4NjecTKWFmUsAYQljVRNQKdPO6dNPpBW+tAoYfljjLwPfdx9PQC0Jda9WAhV1GT1/8zE5y72U6c3gqHNjMCp3nCNEqVn3o9PQJ/H5ZVG1KMX8+k7gMdkut3CrLi9amLoITfYrSzld5jvjmN6nUrhCEFvBmkgmGWcvquyxQW+8X/qfH1RZkNxPjTmeR5xEmiuQh7iJaxTjzlCLS43TbR7uD4TuOjiQXwklVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHQ6BpA4g1lfxuM3kPz6Rmyg134irESbTijduXbgTLg=;
 b=g+EIJ4Y8WqvNWpTtd+mmiGLZ6Pv/ExLKzuKMm/T2YG4TWvmZH3rJ2rL+HEO84YulpVXffSPEE7O8KLwTERW0sY6cSlGgrKVXClZ8HA5qY5DsXv5M4/mo9dX8UVnzUesa7im2zEprUKPMHC5E5jr+P472DfuNBE2QfdsbjZjmth7MCcQVvQ8IQdF2PGWoAwlXGvv5qiJ0XlVqk2mTC6CoxAkL6lTbHP8UFY9SuirLcUEa98tRon7x0hH9kCHgJl+4kkycRLFx++xcyflUtvNrFqgpWzfe4WBi0uSqrgH2YvBZtU2fPwTF3P4nPcy1r2cZmWQcOJv60z2cqJeu2A/hxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHQ6BpA4g1lfxuM3kPz6Rmyg134irESbTijduXbgTLg=;
 b=B5ffge9DB05apDPRBl2cayQ2166FMjrCIAk9GJbchMoBUHAx5jYz9Y/mQ1GUAFDoCFuY0oMFAOJTXksoOFIQBekDcY9F/RknV7TqtiGnbzc9gk3dGw9NqkZVweR2uiipFAZwsvCjdafDSsaq/CNs90rC++4cyLbrmQvTnpavRN8=
Received: from SN7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::12)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 13:36:42 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::94) by SN7P222CA0008.outlook.office365.com
 (2603:10b6:806:124::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 13:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 13:36:42 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 07:36:40 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 11/11] drm/amd/smu: Fix User mode stable P-states SMU15
Date: Fri, 6 Feb 2026 13:36:07 +0000
Message-ID: <20260206133607.91047-11-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
References: <20260206133607.91047-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e04bc3-eb46-4dec-d03f-08de6584c39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ehg+nCd7uLNkQcxt7JmSA+juUHZJUl6Xg91zey/l6bJCbKcp1nrcc3YxNG2y?=
 =?us-ascii?Q?C+deXPPOvyh6lnpWWzWKqrPMVxktLnLlqeqfuQVlmI2F5T1zJYX9Fb1nGKfX?=
 =?us-ascii?Q?rBVRojqaadAiYhuEcr7Ijb3kvgvjv7xGBPTHtTrpmiY7kTGfqXQgu+07w6Kq?=
 =?us-ascii?Q?t4kbs5qCQInQoN/qleGQh7Vp7UIFmq53uOzRUjpqLTuwqWAEznoiWJLf9uK/?=
 =?us-ascii?Q?xu7UsN77kNGfLASOwOhw2/wVfapGi0Zy88/D3Bb2Yq8eAUvb9DV70IzQleeD?=
 =?us-ascii?Q?XAadqr29vQ/fE+e0DLHWLaPnYvMlFkTzi3RSRXJcYS7eZCwk5qmfZF67aN4w?=
 =?us-ascii?Q?2wfVwGINefIe0HP/7UvK4YAvhL5r9JsTIw1GkrYEZuI/4y0gormloJl2sxDL?=
 =?us-ascii?Q?hg/I7nWWy5u1SgMIiGt4hPuMGBWMf6K8bpRgl0Y3spGVbejpBeagEH/LYyW8?=
 =?us-ascii?Q?xg4DmWczlQeR508ukmWzfYMskCHOTcVl0vhblCHw2OR/tIjxbpo47DYxsGJm?=
 =?us-ascii?Q?Sb4Tt8PUSPQ5Q+hPdN3PCMaZMfsGc0h8A3zBu/0vs+wv2rydZOxsk/PUuF3e?=
 =?us-ascii?Q?LsvKQelySEGlFjwx1ZxiWexxo/rz5aEw6UWPfwdfVAZT9WkBoT7vMUqBE1f1?=
 =?us-ascii?Q?RyKbVnn8D6/1kdpc2JbTdMojn77I2FMFOiwF8Dr1ckrkJG6jUZ2RtZEPTwHI?=
 =?us-ascii?Q?U4XDOw4R3cFnB8dF22BOyGV4KtEB6H7/l26t23xFhauJ8IcSDeDM3ooZ9jbm?=
 =?us-ascii?Q?Zup4ynD4LiRexa9Fh3nB4Z2lrok2VyHGLZoEluf1+kjGYrcwBu7K7E1H+uIS?=
 =?us-ascii?Q?ocl0szQaMICOO7KfJGRvxdBYFt8OLWZ1DNSRCc6AydPXLVyFnsKfMFTB/TXv?=
 =?us-ascii?Q?Xw/16KrvOqBovhgd2LDmToZ/gVyH08jXT0CEi8G8K4a/ZvZu5AlmSHNDEz9i?=
 =?us-ascii?Q?cpDy1WWOrJIXD/pj0G5ia8n4RMAZNa2yfnkFE1pVn8lclcr/YPwKTA9WI8un?=
 =?us-ascii?Q?D1BQ5GJx/Jx/WAPj3RINiZFrhYauWgRa8nCByllGJ8UHLmEWqD7DFuVUNbob?=
 =?us-ascii?Q?uQBA8HP7laZOVGi3uyeMWAJmhSSZtDmVnR5Osu2jWnKARDvaDfyvG9YnUPfs?=
 =?us-ascii?Q?KPwRbpYhRTu0i5EvLAJIxLSF5SThZ1h9Zo4KXKu3SReu6DNaxW0acc0ZfHx4?=
 =?us-ascii?Q?dZEvX0SeoAwNxh6nJffjt0UdB/GYau7hF3jIznKbpZYF18htn/yyp3I7BJE4?=
 =?us-ascii?Q?AO0r3xw7Wv9fds7NtKu0oZZh5+3wBuQCNQ1ZXMtCpnoELCXEeyYqtb1Y3qdL?=
 =?us-ascii?Q?fOmvcJFniCZKoUn26KGae+iqdgLzPt+W0GHRBr5gPKMa3xMjDt8oqY2IjLuP?=
 =?us-ascii?Q?korTxo6+PRzAO+x5DqqBx6RwYOyAhek9nMzm3o4kDoTIQ7qSwQEiOBHzn9Qy?=
 =?us-ascii?Q?bmyoy27qY8+TgVK2K+WhMWZdcBIB6m90SsjrAPH0iJQ5cnZ148HMbSNlPcau?=
 =?us-ascii?Q?5tdVwWTw69wMSGd0WzZuT/zvHZ5VQMB6aMtcZ1yMJPT+YowFaaVqgxCM5HSE?=
 =?us-ascii?Q?ndm+ZK7lotmyEAvhQNe/qRbv4/mWQJkr7LLnikUiPFtkNKJr82tAO3gIs87f?=
 =?us-ascii?Q?3G7s0KvtgBQgyKwrrKrp7npXd7swiUqhsbNfh/GDiWQaJOsOk7yqvN+d508d?=
 =?us-ascii?Q?DoqTXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5HRiS/xxujka9A8l8U/cZgfV7duo9eAiGD+/nyFkmDdtLy9d+dHauhX31w+UaeWxXC6A0TwFp8SlcfcesMaH7gxPNV52XZPC8N2qmV/kbfeDPBEGisIU9I8LMR6Y9cm22dtWx3mxfKkLSzsiBWsaA8OXCfjbzC+TotkB5sKm99+PCLWrcLNhIGISuGL8V6/TgClZQuRF6R3fEnWk41gbovTTpEeVKnmfl2JChyJzO4fxgzz4VUDAF+cE9cbq4htMtjQRDjrjrqnoPM4ISjsUzzGSE24NPqlIVqrbubr8sKCCMu7LWY5+wB8Kw0HAujBp/7bfK1O+mHB58TzGt08aCZeFSUa4K5GZr4oVmS5AYQxTmXobLQyadyYIggGQWU38ii0+AtfuJk2ufDDO2aRzefWJXLGfXmQfsIB06u1Cy2wRzsjm5/Qu0ZowxUGHHS2W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:36:42.4340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e04bc3-eb46-4dec-d03f-08de6584c39a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275
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

SMU 15_0_0 exports only soft limits for CLKs
Use correct messages

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 0a5f25c8e4bb..c3d1be9dc0db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1071,26 +1071,21 @@ static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_min = SMU_MSG_SetSoftMinGfxclk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinFclk;
 		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
 		break;
 	case SMU_SOCCLK:
-		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinSocclkByFreq;
 		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
-		msg_set_min = SMU_MSG_SetHardMinVcn0;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
-		break;
-	case SMU_VCLK1:
-	case SMU_DCLK1:
-		msg_set_min = SMU_MSG_SetHardMinVcn1;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
+		msg_set_min = SMU_MSG_SetSoftMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0

