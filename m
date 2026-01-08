Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA40D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268AF10E685;
	Thu,  8 Jan 2026 04:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XHIYiLy0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D0710E685
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOToAPjR8VDDnhz7JNb+Tc1BvEPEZLYRwwhEmREwpMJFMclgisQrqZFW7Gp35aJgcwlap9nTkIiw2ArESAR4GKLorDE2QbrgDcJyBdIB8lUXgpCsnKBhE0/F5Py6Pe8RZNp4bRQllYYX0TGs7jnAc3j1dKF1MFX2p4LWPmM0tayKRctEdWDLVWNyjNT+KCQsr2oFXJQfb0XRRTexwnNcnEJxrmPJX3dM8I1u9WIKadnkTaee70PlBCspCqwddIpIInCem2Bb4r1uLPV2jsfNYmhxhkPAv+I6NRPpGplnDY0boCDDB5ZTmKQIoEfejaHGDYGLlYUifcF7Bajg+roUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m00K00SnA/9wJQGteJU3aBOVtSiee+eTkSPyRKjddqg=;
 b=ofQGx93J4S4R+plP75S9M7ljX55UpXrydi+0aVFnVoiwiWe7xOECdHB9LXdDHVxf5T4n4Klur8qV16VBpF2F3mW0ZcJGEWeZXe3W4T1NUyhWZJzBE+anMFDYaPXU6x8DuOpYfJ2BgFfN3jHm3OhiO/+FrN1+PEdaPtxJWRqwRdSxUpIsRh1wrLIqs5SD2P9UXanqc0UJ2EIaWvnaU0fgcIWhP6MurC5f/RvV4w6B5iuuBqlUsvTozGq4h+XHusvocMELAfWahr0dxU3ycdUSOkIQbcJoqKgjhfsnoiuWDU5FjbbgSmA+Hftozwnnkm466bpiD5vEJnpqJdV3HqN/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m00K00SnA/9wJQGteJU3aBOVtSiee+eTkSPyRKjddqg=;
 b=XHIYiLy0CJXcVMcAzu9cimJyPqDr23VKXpDiN3TF7DEd/SJ0g8ObFJDNZ53nKGEy8YAj+CdBWmrtLjftKe9j5fSmRYY3Uwq/m6Wg0WfE4oL2LpTixq0KjMVSnzI5Mwmv/35iCcPg632rZSQyoWcnQEEkpCgOGfY8PvFMl8wlJRU=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 BL4PR12MB9535.namprd12.prod.outlook.com (2603:10b6:208:591::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:56 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::a6) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:52 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 18/24] drm/amd/pm: Drop unused ppt callback from SMUv12
Date: Thu, 8 Jan 2026 10:17:34 +0530
Message-ID: <20260108044839.4084279-19-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BL4PR12MB9535:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f18fd5-c85b-419c-4c8f-08de4e715ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CWIDcKjy/FgvkrFV53P9avVvJ8KjLbIBBgDFneQyaJdv4YqoP8J+uRDlX91x?=
 =?us-ascii?Q?Yy4E1KLbeAJfnxRNWg2U5Fp9ZScpYEWHaVkW8DUKNRfuN9ovURzRlTjpwuex?=
 =?us-ascii?Q?3Fi+UhOakGQ9d5sJb8adrS/QHvYviGDPRdKorD6j2V2g8AN/g0Fzss+DE0I/?=
 =?us-ascii?Q?FqkPlBV6nX7qdwyrvlpeugFgjRLJgTZqpd+21Ueh0NjMMukaGVS4yPuNdSoC?=
 =?us-ascii?Q?gH0VdKscYgZdC6UmG6JiQDMY1446PWf0YSVCf2npU9aW/QmFGQdXy7E8UJSZ?=
 =?us-ascii?Q?8cHPO3PIN1g7xePQWg+zZ46l4FmZYom1ocRfpoCOw0CbsHFqrAnLmw3LMDNa?=
 =?us-ascii?Q?YRnqbocuxRgqAoOvcBj76Ry26CckvNqSUOw3RDIBb3oVUL3EYegylnhVxdMS?=
 =?us-ascii?Q?WToKKKqjFlJm4UCqZriXrfC7ncQ4uEAKh7XRF2zStPgJ31fHG8bkxvdGJSLL?=
 =?us-ascii?Q?9cO2tllAVPVnFFmcgMtP7WFv9llygdigLIBbpHC2cK49Z6GtFh77rxW62YTM?=
 =?us-ascii?Q?lYV6MjwYhh0WIhV3VaIrwPkDYRYu7y0dAeLYtRRpQ8Yuznz27Hb/wIvZ54xJ?=
 =?us-ascii?Q?FKM7l+f5uGfppnf57e4ptt/st/TIzc1Do0xjMT9sc6XI8N0aZi0oKegEoGv2?=
 =?us-ascii?Q?nz/OvWVOuDi17VBnICRkV1KMmgoywRL41kV6q8zchod4Boc/P1Xcjg+gUq8A?=
 =?us-ascii?Q?KGaif/zrlvTkrToe1xYeeiHXC2F/FRoaBBH4kuchvDq0A08f7v7TQpHwDmW4?=
 =?us-ascii?Q?68vQAo0Hawhfww7a6JSxDCzTcnBLaDb+mWzusDLRL4Be8gNaN0wnXkqVHcbJ?=
 =?us-ascii?Q?WSLjG4/EjyTdtxVLTUtT/5iE63I6uRRmpxxFncbqH5anEXcIC3ayg+NqyUWD?=
 =?us-ascii?Q?rTy/fh8o7ad9fs1NCQo4a+Fd6iCmdzBhe7TwdKsw9qvPPDs7KKVn8AN9fqpT?=
 =?us-ascii?Q?/XZwzUDAajvk2ifs4yFtx7j2zG7o+JBa+iINW8Rsc1ePq3qDl5J51CMDlstI?=
 =?us-ascii?Q?i/AuQdWcz1hMMJkBxOXxM42JyHIoBiz0EmijKnM6A5/flO4HBkeCH6LubScU?=
 =?us-ascii?Q?/aw8eG4Duxy9JzSDuc+kdmiTLVZ2f3ohsE7GPgMPxWZ3YQQ/mdN2phkF0XcU?=
 =?us-ascii?Q?U7eNY+QSAajfYh7HtvIvCjgqnfKE/xuqXgOxW4HP3dOcJTQKRoUW2y+emqrS?=
 =?us-ascii?Q?xz7eplTSkEPLErBSCT6LnKtigSHel0m+1A20B3g8sQsm5HkammilwNd0WRL6?=
 =?us-ascii?Q?ZRQfCczF+/WKwu9WM8sKoLbtfyhpDjPXmoFijA9MyQie4kYDpcBf+kT1PeV0?=
 =?us-ascii?Q?s7qSdroCxuormvR9qrH3WoS5WqGoKRUHDiKcJeo5uPppIRR0YTLN0CsfvV2y?=
 =?us-ascii?Q?KoJRllKmLe6udfNETaWcVwFKrXjuwQgQSbnTNmVjzgw/yLUJD+eR7BVnoUIa?=
 =?us-ascii?Q?mj8tRl7D7XDXU76nnLeTn/UHrTahdIBOEKmC3+erxQHHyL360mHj/t/rb8Mw?=
 =?us-ascii?Q?YOPJrrADHrsVv9+FDbzIt1F0clbw1iW5JN0GpkdG1R1BiJfXaqaSxmYBRUQH?=
 =?us-ascii?Q?xK/aIDq7M0nYwI/YFl0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:55.8610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f18fd5-c85b-419c-4c8f-08de4e715ea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9535
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

SMU message related ppt callbacks are not used. Drop from SMUv12.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index a81360abc2f0..5346b60b09b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1459,8 +1459,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.check_fw_status = smu_v12_0_check_fw_status,
 	.check_fw_version = smu_v12_0_check_fw_version,
 	.powergate_sdma = smu_v12_0_powergate_sdma,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.set_gfx_cgpg = smu_v12_0_set_gfx_cgpg,
 	.gfx_off_control = smu_v12_0_gfx_off_control,
 	.get_gfx_off_status = smu_v12_0_get_gfxoff_status,
-- 
2.49.0

