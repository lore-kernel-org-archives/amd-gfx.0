Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769D3CA0EFA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 03:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B98810E053;
	Wed, 20 Aug 2025 03:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4KtpZUry";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1674010E053
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 03:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOCL9i51mxr+iUbuiZKe1jotLZs7Jqmr1OmAQznrETVDXXl0mfE7WUmflOMdGBZBX38vuOM1QRcWJWRD3s2cf47DThHVuGDg1o212l1TTG7F80MXGFNL+ZTQNcIqqIY4aXgwspmkEDlJ3/CMBNjSQY8VRYw9tmHgWEihDeGtmfGqa8l0SqeJxZyHG+HKrW5tZuxJ7Q/R1N3Z9nKDWudf2KRU4CvwNNZq/8KPaKcA8dSzE0+Tn4yhTx5bNsHZuzUUKN8ojTXnqQQaMhGo0SWBXfkFhQ1qKNb01HPIG/7aWQjZVo8nBa3Hr8Q/PTKUplBIAQYbhCPEL1jj2xRP192Gjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0M4RewELulDdmg5hAzvOKssYBSud4IAXH0razN8fiq8=;
 b=b9/nyRcNOJc6wSUKaTkK/ljrzXqTGKQ8aFJbsqpQxuIQFI4U/vynfJ9/7xON2EAe1szcFZ8i5ewY/tjQVNwxZENGdZ5uEAGeE3loN1lGNBw1z8QF/SFqpfA4+AK6MhqzvCdXpZUs4oFLMQNlYeGv3BBAz9AiOEkByIzoRoCNdtV3gAL4LWLqnzKqDTdPKH/zMv+pEXG9XCb6AC2+KVDnwLhYcfxAzbrCGxNg4RepcblqDsuoxvyDwMpls+KscImBfOgclEwjmSg9yI3VlBz4qa35Jm1A3J1QZUfdvMeL+VedL94dzBESV87zuXCBeQadloaGq5xmvwuMmXnlxuKtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M4RewELulDdmg5hAzvOKssYBSud4IAXH0razN8fiq8=;
 b=4KtpZUryGfq5gzm1rq8NmN07cK9c/o6cqPvNcdKDuqb5ioFsnbz3Z6wlP2cW7bMBzUF3f17AtvRvSkrXITcRFVSvMQL6rHZdbdUzd5Qj9fsF0JURqd6A+41cNtcuW+t+iOBne1RO+CYeiIJSodJcupPfCHpOcFDZRly1qYSlxK4=
Received: from CH0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:610:32::11)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 03:04:10 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::bc) by CH0PR07CA0006.outlook.office365.com
 (2603:10b6:610:32::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 03:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 03:04:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 22:04:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 19 Aug
 2025 20:04:08 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 22:04:06 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v3 3/5] drm/amdgpu: Move VCN reset mask setup to late_init for VCN
 5.0.1
Date: Wed, 20 Aug 2025 11:03:26 +0800
Message-ID: <20250820030400.514460-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250820030400.514460-1-Jesse.Zhang@amd.com>
References: <20250820030400.514460-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bab817-2c0f-4383-3a8a-08dddf963be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qGiKAliKG8Jrup8lNYnDNmB1KAtAV/k+KfIX7zxEH/IV379FCRUa7uqIKVxu?=
 =?us-ascii?Q?TikwH9EgYq+DB8Ve/BS49c/in7ZNV7qiJSvD0/bcCjN8M3ukktZSj9qyIf4Q?=
 =?us-ascii?Q?ZZvAWo+9IcXqbzlsa0zZ7BjgTcmM2Rdg+3e40QSBkFLdGi9L4j5VTq8C90tN?=
 =?us-ascii?Q?R0zRw8Yh8UCwKARdzfQ2sQaHzHGKUvbHjrsBgddVSeQCQO2oAb2Ow0p6AiOK?=
 =?us-ascii?Q?GSqqROv08WjD1FLdlb0ksEw9WPnlY/oYQvbU3z6WiKTEpTKBTqgWXHk3xDtq?=
 =?us-ascii?Q?x11UqUIqIrZdqe13EETp99hbg22XYxy8ha7rxZ60DKnUn/BFL3yNhB7TD0TH?=
 =?us-ascii?Q?PwMxCSQ0LmkGgOQDct38tNaM331fwaNBsS5AtqWpxjOsuRsEAPcrwVvaUqMO?=
 =?us-ascii?Q?tYyY4AjwGcTH/AOBoGebMOo4BwajhUd75DQP+drq5ysvFT7Dx0eQcMVZbKN0?=
 =?us-ascii?Q?5/7fekErbsJgXIo+iDgEFXSH5q+dFdW06sHrSdrzCwnNtaSDA3dwHcIt6AzS?=
 =?us-ascii?Q?o+aQ1bRhhgXmvBMRnRlSgw1FcGEdmIuMHVx69y+mHL8hcTY/vRQfuEW8wuG8?=
 =?us-ascii?Q?HqQ7f0/jmWOVN2WxcKxrPvxESwMo4PaRhl5WSB84vzLBj41NZzAHGM0eKszU?=
 =?us-ascii?Q?gI61atJzYFrMzwp+enPu5AwTGKr771NwAVKCnASUaD22hFNkEzumdOyY6umW?=
 =?us-ascii?Q?Hc26XoVXdYtq+iTpnfSqjs9sFpzZmLYTuI0zwHxS6MKatCw7847EcSUvYFAC?=
 =?us-ascii?Q?th2kkc984uWU6edzjXkiJk4G5s2/XfNwEftBg/Exka5JGsNaDYBP2yZDGZi9?=
 =?us-ascii?Q?cebRPXmh/XQELoFf9bm7gcs9SLchKOI045avPKRsFnNhcgFctUlQyVOS7qBK?=
 =?us-ascii?Q?K4uuZMCQIVSv8O4E+fkI0sNTmcH6rpnEBZ1dUpgtlihIXh+4meaO1ZjASbf8?=
 =?us-ascii?Q?KOLv9TnJQxgECgtv3ylWM7ZOq7Gjr1upKM7QBQNhnArZ6QFPOFDNo84oYvc6?=
 =?us-ascii?Q?q3poQ8Pzf3fa4nYw/3Lzp00LVi4vQu7JKtLNuZZe8o06Y2v8ASmPnpD2RZlR?=
 =?us-ascii?Q?TKSaQS+YcKWtBIiO9N6avQgaxbZVG5kycHCKJj7tn7XJ9YfLzPwDJeYaVdhY?=
 =?us-ascii?Q?lhniLVKIRX23B5oTt5bnWAy7Py591YypGkT0yQ9EZ3UMiBWcQ6uFsYQ2SQbt?=
 =?us-ascii?Q?yMBebOg3wztz5NQupeidzLrChVbthPDYPCMdumre4uLZMH+gTxmq1oFrB3nw?=
 =?us-ascii?Q?wWh0N6J0bJ9m7sMeESujezjv+6as3nL/ZTrYuyxfEgqlKxv51Luzt2MPZs/S?=
 =?us-ascii?Q?8uU1KRST5pCCmDXCmk2dPXd5jC2Q9pYQs7dQ9he500/KHPnKgjsOwbW+3ChC?=
 =?us-ascii?Q?JJQT9YQpmr/cEiy1+bPEiHIvOEAIHA84Jc2iSjnU3R2pchz1c/pDVkzrpPc7?=
 =?us-ascii?Q?GEBjAaDdd5O8qrA64FAPu61pytuV8ncq6VG7vlG5VAjNtUr9e4rA8CmcS5S/?=
 =?us-ascii?Q?FGTVL1UT93YnCAuYkrM1AV1Us/sC9y0YIR4u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:04:09.9100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bab817-2c0f-4383-3a8a-08dddf963be8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
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

This patch moves the initialization of the VCN supported_reset mask from
sw_init to a new late_init function for VCN 5.0.1. The change ensures
that all necessary hardware and firmware initialization is complete
before determining the supported reset types.

Key changes:
- Added vcn_v5_0_1_late_init() function to handle late initialization
- Moved supported_reset mask setup from sw_init to late_init
- Added check for per-queue reset support via amdgpu_dpm_reset_vcn_is_supported()
- Updated ip_funcs to use the new late_init function

This change helps ensure proper reset behavior by waiting until all
dependencies are initialized before determining available reset types.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 779043eac827..0c3f9c87960a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -113,6 +113,19 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v5_0_1_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
+	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	return 0;
+}
+
 static void vcn_v5_0_1_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
 	struct amdgpu_vcn5_fw_shared *fw_shared;
@@ -187,10 +200,6 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_v5_0_1_fw_shared_init(adev, i);
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->vcn.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1544,7 +1553,7 @@ static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.name = "vcn_v5_0_1",
 	.early_init = vcn_v5_0_1_early_init,
-	.late_init = NULL,
+	.late_init = vcn_v5_0_1_late_init,
 	.sw_init = vcn_v5_0_1_sw_init,
 	.sw_fini = vcn_v5_0_1_sw_fini,
 	.hw_init = vcn_v5_0_1_hw_init,
-- 
2.49.0

