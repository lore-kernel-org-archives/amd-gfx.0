Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80109C47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2405410E4C7;
	Tue,  6 Jan 2026 10:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TX3s/GCH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D903010E4C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTsnjRsRfY6/RyXAk+f0sQYtGMe6xcJCh+hzrGseyh5488Hpkmg3/jQYbnXuFQJjFIT/Vjc3hg8JC64xbRkfLbck5u6guE5zJKqzIbWObMxpQNTEw0qRkwll3RB8X3IJajxc4O1qEuj4M+gwCoQ4Pvk4VOw/Fqm3HyD2JPPyv7F7UUnd126usM+tl6iSWJEdBUROOiQz9s5vdWS7LIFBeHN6lw1uJbxviRimqmwgnmmakdax4JOEKOlKcnXIlEPeIy1SR3yQUeOBtBvnvWOv4FqS/UEoDo3jxsCiR4OW+opHibYOHrh696/X9pAcySvzMljLJOsBTvcB9Imr9+zMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ml8p9hWiw1IzCQcV75LYXfBF1DRbQrs+LZijOa2Sfc=;
 b=jZ4dZ10ER7qCKp1r7PhY2PO4w4YJBndsdU6HXKJqCvulo6HYeANDawQ+TXDKs49TGflghrs7BxGk5yW/hCGpjp5Gdtb7g6CeQrW8f9CVFo5fwkRtfjrebeYDOck20Czbdxpo4RK6K2c1aLvaxbsFoMkD0Gf6+aYJyHmdKFi8PyjfWGNikS6GzW+smd3LwVJXiWpxuZGt+R+fWTZeK37Nhz0vfNadeE6M9rC7dBZug8N8D3gLT3RQohCd4e0TbKvUAmkjMTJ8W/qZBm+GvkwDJ5UJGDlGW37hwqOKp3CPNdEqg2JzzWAFmH5CD32Av6oEnT1k4EPEyGgE6xb/HC28bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ml8p9hWiw1IzCQcV75LYXfBF1DRbQrs+LZijOa2Sfc=;
 b=TX3s/GCHliLUrCRK9ToPZGaxIEGfd4OKkyCI8H/isd3dhwi1/sJJXKWP/vLczOAh9LGIrXJvZCj02ds8VZFkPp1adcwOzbejU7sCyHMS4RlFtyGrsBZgaK2xp8dAgci4dTWd1+Y9sQS0g90CpItuFmOvTxpPLW0QojtuWmcZBfo=
Received: from SA0PR11CA0132.namprd11.prod.outlook.com (2603:10b6:806:131::17)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:00 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::f3) by SA0PR11CA0132.outlook.office365.com
 (2603:10b6:806:131::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 10:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:57 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 11/21] drm/amd/pm: Drop legacy message fields from SMUv12
Date: Tue, 6 Jan 2026 15:42:31 +0530
Message-ID: <20260106101317.3856153-12-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d5b7bc-29b9-43c9-d98b-08de4d0c4f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kKYqiBesvJ30dd7X5SZ6MRM7qs6mZE/Elh9KL8c3BM8EY1utNpksiCPtjaav?=
 =?us-ascii?Q?UsR8OUPxs0/y3MbpSVWqNvTms33lWQFdO5WyTIqP9fAabqc5/y+eyplQEby7?=
 =?us-ascii?Q?+FJrOV3wvsqnWEB5PV1ufI+mDRdZfH3vr8/zA7t/CnrVpsIwkbJKkFdW99x8?=
 =?us-ascii?Q?Ox+ACW7J9w+m9t+zXkygn6TaRR2vWLewU52Ht2t7vy8f5lqPfsnMO+XrAFlj?=
 =?us-ascii?Q?iyBK4vqLjRv9bKn5YX0bWICpn22QNrE6Vus9l2uXW6h+TMFrZk0xTuUoOGYi?=
 =?us-ascii?Q?6VdCZ5U3O/MJpF+aZjYRXEpp7pOVxtEnAD77p/V7/e/YBiZsrh/uBHTR3FEE?=
 =?us-ascii?Q?cCa4OEoZT3q7BGb/iKm/UJYbRX+vJ2dRBi7JfJB2pjs73E8zJQ3keYnDu1Ui?=
 =?us-ascii?Q?RT+OjzeMmpiwG1rO+kJHGBuxF5dXqKdhZNC1RwC89Hq6EbePgls2WD+LqRip?=
 =?us-ascii?Q?IUoemAQfjA9aQ/7z+EvxdwYk7lBrTeq3A4MY4Crb+lrJg0KIB3vJzNkmk6p5?=
 =?us-ascii?Q?cSDGEIAGQHYZ2Y0Gkf15ejuQM6N+57U+F4eyap47FuyU/UNe7WtSAggUrwtz?=
 =?us-ascii?Q?CvGLP1TZrL1tkQYzmo6Bbqp6iwIiS7yZZsestWRSyhWfNqUqew4u6vaCFAkt?=
 =?us-ascii?Q?/Kq7n/W0638LCJQyCqewRyIji0PHG0clWR/vY1/858/GCs2EdgKX3pE4cxZm?=
 =?us-ascii?Q?EMcPVm8vgrKjZj3y16wi7eAXYrmMK4+JQc3cGrOee1W8wlqaab0oj/knhrlQ?=
 =?us-ascii?Q?x5Nax+JMvl7SkDMe5NAOeQ06Oj56bTsYtiOBBurdyYSKkifDld4SzCFvNeNT?=
 =?us-ascii?Q?Sa8qvp01VUPcyszFgnaT/0b4mIAKFj4IjTi2ihc1pzz5+7EX6bpGgv/zp1Nt?=
 =?us-ascii?Q?urGYRzQY+O27DAAKglqZfv9kwZ3s7buvfaRZjd9x02M2zllZ0KSTJbcEKuJR?=
 =?us-ascii?Q?IzbtfxboWHAEMDuma6Fv625PNVoWKKo9R+tp+2rHQtNRQbquY8CkhitxbNYc?=
 =?us-ascii?Q?5kJGbMpBqZoLDsXjFsVwkSJsHKD+6HiI5T9z16Bej7rdUEKSXFmBiFUprtPr?=
 =?us-ascii?Q?UAWqK9EvPk1GhNS7D6gb74FBNAORIva5A3GD67TUuWjKYigxDP0F9Tj30i8m?=
 =?us-ascii?Q?ohqpniY6p+XBzzsvJUZnt5tiBTbGgiiyD7HaXsNEUG/iRGTWr3X2UN0l454a?=
 =?us-ascii?Q?osTtwroB9vOhQNeLFGwLunWachtmmoM/LP+0hKN4fXQYPlunnHh5ancDyW1j?=
 =?us-ascii?Q?H77+hfKpZxPSbXnkaqB4iI5xDnTCNE65k/m7GMLadvzt5dG0nrDsEB8pyndt?=
 =?us-ascii?Q?SiIS1UV6ncxENn7RlIL71DKSlLbUJWD1hH/oJm8zGxLvvC8g35yBG9w/GW1Y?=
 =?us-ascii?Q?rRSDeoY72uJEi/GnuBx9OK3jOu2UaFqYxUjLt4Y+uIjzosE8VKnG6QU46Dqm?=
 =?us-ascii?Q?eOAD7B8TmBtcX6ONp8INI81+8dAe+wiMpT4Ss18aYX53ZbN1gY3zF4ATrHYZ?=
 =?us-ascii?Q?VUZudbu1GWIhjEMwgXVpFgMCGD4Lvy9Ny8ymnJOyxJCJrjRPj5V5Zp4Jko2g?=
 =?us-ascii?Q?bel0b/PWV5jBX4zV73M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:59.4963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d5b7bc-29b9-43c9-d98b-08de4d0c4f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
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

Remove usage of legacy message related fields from SMUv12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 7e41991f140e..a81360abc2f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -41,15 +41,6 @@
 #undef pr_info
 #undef pr_debug
 
-#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
-#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
-#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
-#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
-
 static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
@@ -1495,17 +1486,11 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
-
 	smu->ppt_funcs = &renoir_ppt_funcs;
-	smu->message_map = renoir_message_map;
 	smu->clock_map = renoir_clk_map;
 	smu->table_map = renoir_table_map;
 	smu->workload_map = renoir_workload_map;
 	smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
 	smu->is_apu = true;
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 	smu_v12_0_init_msg_ctl(smu, renoir_message_map);
 }
-- 
2.49.0

