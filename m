Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7159CD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 08:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA49F10E6BA;
	Wed,  4 Sep 2024 08:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xPvweQNu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B8D10E6BA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 08:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb68SPhAsKjNLNSRaWSQABfmfJDva7cPXKmLK7q5zy3Z5pLhBg3xWk/+6r0J304ABo3JPLny9PR2Nzv2dB0Kt6W14y7xvYWuMYEiI8Uy8nogT923xmkBOee1iKtPQk1liOT3Ze84eqdcrGwErqw58vQGdM87t7jIkgFqBY5alsCRwIHbMImvkpvfqqETreQbyHioF+t5DoPIk605zH3ImboZraVqhvOgsuQ8yp1R/HRr3abpz3kktRi7p+Dp1DOp4bW0iQT0QwgB7hGfiqjrsAdvvIPSI9L5Cuj0YBRlXhpbLOc1jfj4GXaf6LkOAGBYt9M+ZYAbM+JgMGUZaowF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4H84r/E46ImpRVRTwRD9/Zg4zjmTnFjNpadgIAPjMc=;
 b=nqUFUXOuEqdIIfkZ3j9gPvSWyFFe1wmvqoua1OTLHLGzy+6aahUYmcEutEBUt4oIJ+XzMdrBjgc4t1aumIqlLFehI1cGnvwkH+LKxaBCG1V8uTnKomoiAlOWtyFncBiddI+WPE/oB+3Ts/tcc2zfBxmOwK5lh4XmH03QvMXQPFn5HnKFcAdC+Q7X/bw8E/33pCK4DmEqHfO4+VBaHgfQfzgALsKdt5J7xnOz7928DGrdICrDsRsOc6FcF2rbnoPwbpSRH4mLdJUAvFUo4nCirX2ANu6VmksDI6CK+5J/HbTgb5xxs4/BLeXuiK4NuHqossFw8+I5dK/Upqcq9dpQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4H84r/E46ImpRVRTwRD9/Zg4zjmTnFjNpadgIAPjMc=;
 b=xPvweQNuEWBehFWBUk5p+sWO9H32D9Xr0xykBooe4NFYvmL13JKiOzk26hD08pr1PKDm9wn7ncLMDq2hPVqpR88FRlQuffw3RI3JXbPuF05isRepgBSSk74CbHNGkhDW0Qc4izFkVGuUsz7b9uH6Bfn0wi39JHQH/WCQlheUW08=
Received: from CH2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:52::25)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Wed, 4 Sep
 2024 08:04:38 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::5d) by CH2PR04CA0015.outlook.office365.com
 (2603:10b6:610:52::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 08:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 08:04:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 03:04:35 -0500
From: Asher Song <Asher.Song@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <felix.kuehling@amd.com>, <lijo.lazar@amd.com>
CC: Asher Song <Asher.Song@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix a call trace when unload amdgpu driver
Date: Wed, 4 Sep 2024 16:04:20 +0800
Message-ID: <20240904080420.559277-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: a41c847b-c9ae-4a9a-8066-08dcccb838fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejZHSlltS2IvSmtNbG5Rd3B2elhKMjlHT1FXY21yZ2xEZ1NZUDlvbjNRRi9x?=
 =?utf-8?B?elFWNllENHNmK2lrbGVnWndNUWFuV1gwdVJIVVh6aDVjbzJYd1MwSXhPaXR5?=
 =?utf-8?B?QzZBL2JFKzV3UUJVL1JObXpZV3I0ck9HOHc2ZDVnenBqUnB2UmhzWll3VVRI?=
 =?utf-8?B?WUtCVUFpTEorWmYwNlJmY24wcjBOQU1IdGV3ZU10N2RBOUtNMjJyUFhwbHRy?=
 =?utf-8?B?bVF1RmdISEt3ckc5RmxLVWxiZjcrdTUvMnhBZm45SlkwUEhJVkg3SzEwZnhQ?=
 =?utf-8?B?aHo1TzlXK29GbzQ4SEUrdXZiNGF6bmZjNnVjTVJqeEEzbG1hWHZLaVM1aVhZ?=
 =?utf-8?B?L0poUXZqbXY5akpxSUFHbWhnN2FrRmFLZm4zTDJGRTdncHJ3Y1JNQTRzSHpM?=
 =?utf-8?B?UTRyYTVNd1l4ZUhpbklnNVNlRDdFVXRMbkc1OXo1SEltUnZJZDZ1dzBPdEta?=
 =?utf-8?B?QVo3WkJNanRxbWNPQ1lscUZoUWhtYTVtM2FnNCsvUmdUM3ZGODJLS28vbFdO?=
 =?utf-8?B?T1l4dUlrbm5ob09uM2NQdmNuSFoxa0UxWmgvMnJMK1dRN1B6MWF5T2EwWlho?=
 =?utf-8?B?SXprT2l5WG5XL29TaVdXRHRob0plU2IyUmc2QXFiU1ZmcVh1cHFDOXJKVE1i?=
 =?utf-8?B?anVYRDY2eSs5cVNUcldiU3lBWGd2citIY2JDRXBtcXF2c3BsMU10QThRb2hx?=
 =?utf-8?B?QXUwU1diRHBQcEgvQ3VmUThDVVo1cGROK3dNbzlSQkt2UGZkZi9wR24rOVVF?=
 =?utf-8?B?VkUxcGpmdTkxTzNCREZkVWdBSG1kNFBrbWlTK1dRNGxqTnlGdW9Ca2J2Y3Qz?=
 =?utf-8?B?Sm04dDNyL1hIdUovOGdDZXA1UmZZVGJWWXFHMStuMDNTZXdWZHVHV0dUb0xv?=
 =?utf-8?B?UFprZlVBeDVwQWJBTThFQXpEcERDL0l3RU42VUVkeTJpTUU5MHJaa1BKM0Nw?=
 =?utf-8?B?K0xNUTcvV3BaelBJNnpnTlRlQWdCa0p2dlEyWlpGUkM1T0FkMzc3Z0ZzZXVZ?=
 =?utf-8?B?VEI2T2w4SGl3S3dZTUNNQ0xWZFgzcDBDUVZTT3hKNSt2VmhYbGppLzNLUm43?=
 =?utf-8?B?SXpqa1c5QnVHYTlUbmV5Nk1aeVV0MERBN2Z5ZzlSOFFpYjlIbTJncGQ4TDRJ?=
 =?utf-8?B?NXh6RlpDdUNBSUtxMnU3bC9scDRjUENVallYdk1xcXZ0elBYL0t0VjFSc3Vp?=
 =?utf-8?B?eUxkRVdIK2ZsSFBjeXFLWEg3akwwcCtyMkxPVmxxNmhKNjJ2M2hFNkVDL29H?=
 =?utf-8?B?Z2JLNllhMDhXNTh5dVpmZ2tUYkVWNU01MVhIMkRmL0VZcUJha1RoSEpZdmxt?=
 =?utf-8?B?ZkdNVk1lVTJkOWxuMjhmNnF3ckkwanlMVTVORHRDQmxhRDkvK0o2Y1JvYjN3?=
 =?utf-8?B?N1Y2UVFuT1pnNE9lSXgxMHhqR2E4T3FiTkxtQllRUUszZTloQ2RiRnRJSXJE?=
 =?utf-8?B?ZHE4SDNydlU2SC94aHJUeVpXY1duNTBMMWdLTExia3NodjRwaDNxaXB3NnYx?=
 =?utf-8?B?Z3FWOGk0eERVZ2dZYittcm95ZmkwcFg4amxNN3k2QWd4UFdMeGgxVXZKbzJD?=
 =?utf-8?B?ellMNTYvRzYwNVpsNWZkbUVYeVdBV3RjQ1ZIM0tkUHBzNnNEekVKWWduakdB?=
 =?utf-8?B?enk0Smw3b2FiTXdxY1AzUWhycjlOOS9RQ2RsVm83S3VMWDlsTmFkOVY1NXEy?=
 =?utf-8?B?OEMrK2dlSytqT2g3d1NMNnNyY0h2anVRVkpwMmZmdmM0L3JZdkFlYW4rYTFx?=
 =?utf-8?B?ekRHaWQ4d2Q4Y1hZUFlBRkxVS2dQUzFIWnA3aHBDNWtUdVBNVlU4Wml4WkE5?=
 =?utf-8?B?Y1BJNmd3ckMzZ2xSYzR3UWZpbHY1aE16WjZ5Y0t1Q1Y1VlNGMHdyc2N4bmhi?=
 =?utf-8?B?aGJwWmI2eW5zOTJkU2RGdHFHNE91TXF1dytwSytHZEZDZyttNTVSYTlKTHlQ?=
 =?utf-8?Q?0dNvJs/ygdkBU/bd6Ea6orZFAgbRJKhg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:04:38.1107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41c847b-c9ae-4a9a-8066-08dcccb838fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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

In some APUs, the bo type of GART page table is ttm_bo_type_sg.
Those type BOs is released by bo->delayed_delete which is added in ttm_device->wq, not released immediately.

To make sure all the ttm_resource is released before ttm_resource_manager is finilized, drain the workqueue in ttm_device.

v2: move drain_workqueue to amdgpu_ttm.c

Fixes:d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5c938ff0bf48..cbac21df5c47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2461,6 +2461,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		drm_dev_exit(idx);
 	}
 
+	drain_workqueue(adev->mman.bdev.wq);
 	amdgpu_direct_gma_fini(adev);
 	amdgpu_vram_mgr_fini(adev);
 	amdgpu_gtt_mgr_fini(adev);
-- 
2.25.1

