Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE795C0218C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 09:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8098210E50D;
	Wed, 22 Jan 2025 09:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EPjhxHLB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE1910E38B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 09:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ9ju8W94eqNOig79FD4JWQ/hgp3uaohDEjHZSCBqMY2mktTp2GM3HFYu44Buldl4DU07kU2TD/g4pyEKUoTl4xedDylNxP987C+/xXj3EYbxRGSjwdhokR39Szk4jq+VExebk6/Z0IDVHDjhEdWeLdHwyDZ2ffP/n3RN1qpaE7VlVTS3mP/T5yjnefkToWMJ7rngXkhRVZ4A2f1X4Ep66fDxYv7CZnyoFk7vHAo+QSneoiQ4CIE2k7qgNHSlZKHG3JMzB+0dV9MHqDGi2d6VZzGZAcVyPT/KQmKglsvSbyCx56jBf2W9PW/VM0Ce9SXmt8fev9VTO8X/7EOuRQR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gqtjqP4+G2Xvg/apE+tLtj0TalX5UM1L8T56BB+EGM=;
 b=uW2IyK3y2nfBCHperatAf5GaVuCpt+iu77XenOw3wXHP7DQkWK42w560X8BOex///hADdU8raoNwb1IoB5QMAnZetISZolfMrfWauoXiqa7ULFbvwrtFPaesNOrlfCgzfAwnPDDZy5tyA5cttUemtSs1YkJ+Soryjt4WH5Vp4CBWgC10HcpV61dYL6mGa229Mx+jlFtkb2mZfQVFryEMcsh7vdZPYZCT32Zzd86WDolBqnw7lHYsgDGmosSAxJkRqc79BFAjXLk0KigWnive0fOs/M3AHVcB3gUTjdbWnH0gOYjcBL/T1o+qCH2AOpFmr0/wJvgfjLzqwwDHtCPwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gqtjqP4+G2Xvg/apE+tLtj0TalX5UM1L8T56BB+EGM=;
 b=EPjhxHLBlDnupAP3U29bamsB0aGgVmVP+EOHdPy93mIuocUdNrcymSu6sKcnwti3CgRA4r/C6Ex3SDx7yT/kcncKxeVa2ykpNV12rOLBIhjfTy87xZbhpgdcAA8y5nXQqrxNUllXrFAQ3ilFZAIJ5OVor1o3tpm7w8n2GMqsBO4=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Wed, 22 Jan 2025 09:56:24 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::c0) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 09:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 09:56:24 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 03:56:21 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 5/6] drm/amd/pm: Skip showing MCLK_OD level
Date: Wed, 22 Jan 2025 17:55:42 +0800
Message-ID: <20250122095543.148993-5-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250122095543.148993-1-asad.kamal@amd.com>
References: <20250122095543.148993-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: eb90b325-c328-48e2-851a-08dd3acb07ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rKIr4MGCFMyL8hXKQ6o43n78fOU+04YIkOyXOTpbv0lbz+E7CTcP1F/fXSmq?=
 =?us-ascii?Q?gjWRrJJzrsx4RC98p5B0Fnxs5i6wd97xfoZhMmBsyNnLJ+/Jrq34OGTTOGt8?=
 =?us-ascii?Q?XHbr7aHxCTn/xmAn0AX4E7k41L8VTdexP3kZnpK8PpCiUzzmJnRzcVBAIeOO?=
 =?us-ascii?Q?Rs2bJTTkvJw6irEvXuuluErvSynQAcAWrBcqTGzLnmWcJcx7agqHeGErsG34?=
 =?us-ascii?Q?tdLvLSVhGHJOZX3DTQO3Vkl6J6GEu9xfLNGpnrcITtPGLJ4EAta2vCJTG8/X?=
 =?us-ascii?Q?UX+L8ZYCnmGzEKwRm8jSnjxPclGGpd3Bod9ROZpXVnqltNZHqc2ZHsYALvV5?=
 =?us-ascii?Q?gyssi4pGhCrp/nH72hfGj7mSFPn/E1/OvNL+KKgLrPLxKsW8FNOsQuEJSFED?=
 =?us-ascii?Q?eaOPudeNxeQMFcEcw97m77QP2FfmISoWk//C4HJbfiN13rNy02pDmTO9o2EZ?=
 =?us-ascii?Q?vbjovQV+z1OBzTLoeQxZkEYQAoMlk8g6gXc+dpRu6fERxOA6Fh1Ttq4FtsP6?=
 =?us-ascii?Q?ILCkOk5OlHXxNYeCJP4ltezs4W+N3xz9aL0iZZjI2syWWyz8saymxNsvqp6l?=
 =?us-ascii?Q?tjPrvat7Ez9suycipAhdy46x1vmbAPbdpO/9adKUY+hjduQ7X6KvHkxAjrC6?=
 =?us-ascii?Q?JC8jPxYlGNZyIKILuHVHGyQzI4tF6K66jUKJgOoPJZGgdvUYGhvOygi3DEYk?=
 =?us-ascii?Q?e27cGunqeKn5FqXzs+QUTUk8Am/k70Qryn7Y7UmxV1kFotUJBxCxJQWCNuO8?=
 =?us-ascii?Q?6k2lxhQd9JZ0QveYAXz4vj4pfzzjm9dwlLHJUF7trn8FXkYmzj18hhrmUTw6?=
 =?us-ascii?Q?ZNxJyNOcOx1Xb1L5iK5+idEEzzIIoaRzfB/o8ktHOZeO1TIoZuSV8Ly3houE?=
 =?us-ascii?Q?ABmv1elKpiP4TsYYW84CWmOE3EY8DLzXPT9RaSLP6m7X/ETll177Xwqwa0UB?=
 =?us-ascii?Q?ZVinvobN+kb6OQb9EHTaCb32sk+rKJ7WfN19QuZvlXdbVCKTfujiofOmdqdQ?=
 =?us-ascii?Q?HQGU62tdl92Z3NhyRI9NAK/wysJGqlpbOFy0YGMyVTXllKBBKjCsAyfOq5C5?=
 =?us-ascii?Q?E9RLgwzJFHvkVEPsWfQYsQVc+PbPZE2j3kCVyU/xOaULVP6GeHiSpC+VFIVu?=
 =?us-ascii?Q?fhT7tfjs0qcEsdT2GG6JB2zrIHYxwaeeLR4wNmutUwrBJrywgl4E1EuDkf0j?=
 =?us-ascii?Q?Bc11nlg7lIYIVIymQyLFFqWTQUj9E0+zgOTWoezkFgJC+BjVEnAZIQi4yjwt?=
 =?us-ascii?Q?7Q1t4tWdw2altswsTMCDzk/v7iRPeNcPgOlY3kktACYv8PxsiJ0LLyXcBCG3?=
 =?us-ascii?Q?mYAi3X3rL2s7Vk2Qrw1LxVibGkKGFpdi09emKXqkaJx4IG8W12VtXOKQXgRL?=
 =?us-ascii?Q?FhLF5qboLv6hrR9CxvuS/F4nsm0ON5YeViiUfR6IkuMsDA+tcKzBIIZsFRV7?=
 =?us-ascii?Q?LZoA2uNY1hdZCZSmIx4rdpDd+flqiGziOtuEhPqQB/WOUst3mwsjEzoFQGkK?=
 =?us-ascii?Q?4bmdTagRCWfeuK0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:56:24.0966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb90b325-c328-48e2-851a-08dd3acb07ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

Skip showing MCLK_OD level if setting UCLK MAX is not supported

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 72c18b1635c0..cf313da88607 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1368,6 +1368,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_OD_MCLK:
+		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SET_UCLK_MAX)))
+			return 0;
+
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
 		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
 				      pstate_table->uclk_pstate.curr.min,
-- 
2.46.0

