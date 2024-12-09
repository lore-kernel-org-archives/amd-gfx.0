Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E094AE7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 15:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A39F10E4B3;
	Mon,  9 Dec 2024 15:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X67oDKBL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D65D10E4B3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 15:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csKlcxJuCF2z0tyAGjEpHhH2oieei/LgLJgzfkkCaGkuAGla75ROhcf7S5DYoC8rsigUsDg/Wc8A8CDB+j7sZ3LINIQJI23qewYCutNoETwNdVQLu/lTY8qIp4CzLoBdwBfH5QRzm3ecDaqwwRs8eGoPlfzhKRnl75iWU26s9D0DiiNC4aH4qKKXpFAMGJ7zocY4/NLMvi4ki8Sf0fVby2nM+W+6+zeKo4lCSiD1NwnavQfA5RQW9fUBaHEO/gxvaaU/nHgo+W8F05dFU8D3LdnvjbvbkTxvMVaBDKUzeItrrAtgadvW2f5bKUeRIkyxcIlN4akiaY8cR2obMXFoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=161IP0xPhkVJjoI/2rnVtmc6A9ERu+bIktH4g/3YZuA=;
 b=jXHJG6QbmIqx2Kfr8qjMIip+pHMmqHYDd+TW9MPMzgrly3RNp/e9lptNrV65d0wvOZWD+dHt/ca6drsdN3fCMVKLJCnBG0Qs1SX1gob3mWyVkSkF1W9SrJU7iLqHhO/0AS1+G0ntpkJBR+AeYsMaywTM8K75aYQ3KCySe1Q0NK94lkBFqVghFM+osFvRHYfmhmDeGMRWKItBLhvPJGtecRHKRa6xO0P0KeJgWewNz/SQVpObE1jkmdJknatzzC4IOdPBxCecVC9B2Jt8qMmoJP0IJEUp2DB/hzNI4EU7WrdkAmH7uuCz377lrERTmegTA1+EREKNDc76fABEDn9MSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=161IP0xPhkVJjoI/2rnVtmc6A9ERu+bIktH4g/3YZuA=;
 b=X67oDKBLTE4qzstlFfBRW8PzE1lISKNu92qS0RrnSiuCZWiuZjoeuM1GYuavWWkCEF+0N7zHPK7u+J4i9hUJxRMafrxx87oJSLwzb/4+jxD4HNkfbbd+ttG10784iJ3Q2AFocMWAzTYjZZtO8apbJCiBq6CY2IU+52cyRljrr6o=
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:53:17 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::c2) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 15:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 15:53:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 09:53:13 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Tao.Zhou1@amd.com>, 
 <victor.skvortsov@amd.com>, <victor.zhao@amd.com>, Vojislav Tomasevic
 <vojislav.tomasevic@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid VF for RAS recovery source check
Date: Mon, 9 Dec 2024 21:22:57 +0530
Message-ID: <20241209155257.3642960-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 130f0b17-b77a-40e3-f5b0-08dd18699814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4lvSDTsh34WKASH63IY50kfrFnV0+OWEfqSAeLDeiuVBW7JkoDF8MNF8hjfu?=
 =?us-ascii?Q?42KOncn1upw+wEbMOQH993HCS9enG8WxfruEMOg5rRcO0jvyHZ82FUANV0d0?=
 =?us-ascii?Q?ssqVIOtH9BvlRWSYp0Vx92gvdyuCkFMvel2XWhLcaTnzcDWGntA2xx1Ckfqg?=
 =?us-ascii?Q?At9HVZcMXSwxb92kPogATmTMPAYGXOTizTJMxtg73t4rgJ8H9XAjDQXk5QGZ?=
 =?us-ascii?Q?4aJ7daAP6uXSBna7ky97uxpDxUsOYoMwtdIxRV3lQrKtKr0ia3lv3WpTJavz?=
 =?us-ascii?Q?PfnvchZ2zpX5Kq6hJuuiBFoDwnz1kQwOn6w1OFhHLDFnqTWmn/KcUkEnN2Xx?=
 =?us-ascii?Q?vXSW6MelLAivq+9mZeni/qV2LYKIvX9k/nWBGBc7TLHOcrHz+uK99OsgkdJl?=
 =?us-ascii?Q?ppLoH6aPOsP9ef42KPz1+sfNQaidb3CXi3BzNDf0KWaj910x71qArPu2iGY/?=
 =?us-ascii?Q?u9WANZM95hm54vu3+7qnXltx7dBof6dgeyK96O6DBBM4D4XUbtO/JoOytijp?=
 =?us-ascii?Q?xNIyQQFP4bBaDu6shbHeAWoPeZk3WLiBkc+YLvphbY9jQXt5TjQgdpQmWpIv?=
 =?us-ascii?Q?jlUfZ4LVxOaQz/Ve6UA1ymWx2+LwZfdXueJR2xa/UyZ7HRuCgWBY4mdB/P3/?=
 =?us-ascii?Q?6oqbziUB+3Fdiw0h4Xy1KeYpDevBg+l6xJ8msKCIuqWafrsKqiYssgR+SZPi?=
 =?us-ascii?Q?xlcgKdeJapzFTLfA5g+JupDjT2G/mGJ/rlcFv/8DsuC1+eAtgK7p6ROwsUZA?=
 =?us-ascii?Q?FGbEZuYzo8aKxJw3/eCz0+AQUWJozyqmHMuLFzSTEfE/pTbpHkjEmiSyCBTD?=
 =?us-ascii?Q?gUERSN5TzE169NUm5hDGfsw964PmC1nyfTJx3AwlnDaTi1VfoAtJQjh9uCrT?=
 =?us-ascii?Q?eXykmCpV6Olkur0SrKj1dYmsnnW0gJFebr1Ix90UYbAUfVNs/FMkJa1ZM9zO?=
 =?us-ascii?Q?qMgs47roLI5/jLXhU+q4k1Cg2zn+ZbGnTxe584BCsf3otEuDV/ikq8m74lN7?=
 =?us-ascii?Q?p4Ea2oeQEBRH5vvrgS+hdtjFZFERB/1najvtAKe2BQ5c0QrGUuGYjpkpNpVD?=
 =?us-ascii?Q?KeBqP25N1cXz4Kk9d2vVHLMcAa429NcGHwUt6MOiVNBe3SQcyXYJ1Fti9kwX?=
 =?us-ascii?Q?cxZd9V8AwLhsi3WLHZIVyhfCnDHC1o9J/5WI0U3tB8rCXfXS8Zjw+XSNSQjU?=
 =?us-ascii?Q?7ixMYqYzU7a+277zirTD0X/mWnKyf7QtK4S+p+lTMsxJCgHFdai3kUVpKkjp?=
 =?us-ascii?Q?EHqm89CYQoxsHNijx76EipccOC/X2eH9N9sd8IJsXUH9kX1UZkECn4WDqogs?=
 =?us-ascii?Q?p9bxm5m0EBrrY2XMHYKsrxKXFek4ESlGFmshvMJDWDCjOhY52zECGh9MGN22?=
 =?us-ascii?Q?+jwYP4LXdzxbmqxmR/IMVvOlNRd6j1mdUnoO4NGVPpPfpHd3PzfgjsHm1jHJ?=
 =?us-ascii?Q?gc15ei9J1YmnQProrn4E0sIg/6MsUw+N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:53:15.7840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 130f0b17-b77a-40e3-f5b0-08dd18699814
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

VF device sets the RAS flag when mailbox data can't be read properly.
There is no conclusive way to tell if the real source is RAS error.
Therefore VF schedules a KFD based reset which doesn't set RAS source.
SKip checking RAS source for any VF scheduled recovery.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Vojislav Tomasevic <vojislav.tomasevic@amd.com>

Fixes: 2211660c20a0 ("drm/amdgpu: Prefer RAS recovery for scheduler hang")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 735a01c58cd7..eb3fd55a3702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5864,6 +5864,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 * detected at the same time, let RAS recovery take care of it.
 	 */
 	if (amdgpu_ras_is_err_state(adev, AMDGPU_RAS_BLOCK__ANY) &&
+	    !amdgpu_sriov_vf(adev) &&
 	    reset_context->src != AMDGPU_RESET_SRC_RAS) {
 		dev_dbg(adev->dev,
 			"Gpu recovery from source: %d yielding to RAS error recovery handling",
-- 
2.25.1

