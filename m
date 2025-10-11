Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E151CCD184
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 10:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15A110E06F;
	Sat, 11 Oct 2025 10:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q0C8h7Pk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7174F10E06F
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 10:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oU5rLixrajsfFe0xqEJooipGzht2c/W+1W9SqiK2jOAY5U4SS335YsoWKJwsZReOTdMdW2Nw7ISbxAJTmoOKWp8DMuS5B2GTGrzZ2BAUIZuBvadSJzJB/8OBcBimY2cQEKlcCwPVJcU2ErRapvN6JvNDPiXUZ25h2vlta9bjJ6Mn7tvCEcxm9mRXOOQ6+KEcI2nR0fq7Xad3kMMtoOSK7Y0w5M+ksrPB+D0s4NqfqmQvHJg2RaQg1AN4XnhGUj7A1LzQElChlS7k6voLZlM8zQOgEo4qzp/ZIzo1FwCSX1IoMd+fIAPHaf7/21vP5lZEeeFLJI1YqhtZwWGF6GQvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yrcDptrpjZO7JCQ56nlcVjFKiV8bu8sMFDHvbLT7Dc=;
 b=lJU5hAMDTMOBFTLPG6uUStU56d9hyLW6w1JmFRRxU3UGq13sWaKEoL/Pb2u52CDcfGRcluHRdR+ynrD+Ayit6Dm4hboqyNJKz3eYGokjurpeEB5/lWYMTxNds24Zfkmf+pj5EKxuqz7GX2wxyqmlfd+Sh8RJLtYHWl4Z0kzdyS73ygKR0/tj+BNxgEzgv3NFVPPmejMZn5TID5qtiq6EwANTPV7wghHhCjAkrffrJ5pFaj3fQohrsa63sEHFBgSp43J50ovaNG7Lm/g+2+Pihxf1y5pYDuCyKoTqqVmn2bAXEsha4L4ZvJ2ITeQAaz7+pB1yel8EqW+/W88I1+dGQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yrcDptrpjZO7JCQ56nlcVjFKiV8bu8sMFDHvbLT7Dc=;
 b=q0C8h7Pkov9RQV6sYxBpTcR/yhxvvPubfbLRTMPx94qPJ0wBWhR0oqrj4gEboHXKgGL4rCRU1jeC57a/otvRwvKJ1aETRft1Mb5rO8pJ40q3LRMnYxLttqUMrrxO6ad9rCpT/FZVKard2U6VnnXG5tQuxXmLDWenVEFCysniyI4=
Received: from SJ0PR05CA0161.namprd05.prod.outlook.com (2603:10b6:a03:339::16)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Sat, 11 Oct
 2025 10:31:38 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::14) by SJ0PR05CA0161.outlook.office365.com
 (2603:10b6:a03:339::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via Frontend Transport; Sat,
 11 Oct 2025 10:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 10:31:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sat, 11 Oct
 2025 03:31:37 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 11 Oct
 2025 05:31:32 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sat, 11 Oct 2025 03:31:26 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix NULL pointer dereference in APU threshold
 calculation
Date: Sat, 11 Oct 2025 18:30:16 +0800
Message-ID: <20251011103120.1262736-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f50e2b-2514-44a8-e835-08de08b15c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IZvLkUueID9gi7D0gkv9kLe6bItQ/+stVmLe6sL1srXMKe0sorqrD6+Hr+jA?=
 =?us-ascii?Q?0yc+GacdJj8rd8sBNvgKTeciNjB2SSkNC6EuItCHGzCKa28NQtdwWhG1SNtd?=
 =?us-ascii?Q?GDusgAaMaxnzjHYVIq9pbLTNIcvuQTrKmJdVUuosbZv2hW2ThlfTA+jOIlDD?=
 =?us-ascii?Q?dZwd3oXgLEGls4j1VFsdV20RAAy5jwPjo6AeDWxS3DaYuJDJswsr39mqh5JD?=
 =?us-ascii?Q?UE7dktV72472/IKWzxv0f5DQHRiXAWoGscCV0BavlCGn4qXgHsYoRo/LaWee?=
 =?us-ascii?Q?iMG/08D/1g75Nc9z9pV40oAfVtru51IFANRC4VCoAWmm8vOuUYcZGI0jSlub?=
 =?us-ascii?Q?m+YWvh8LSM/pKEIcvUsm7oDJrT373W1tyAK/Cxxe/9HVbrfpOaSj2+GE8kld?=
 =?us-ascii?Q?6Y0jIBry4REs+3XVjwBb+HUxmssXENLtqTZYxIFweaTGWQqrs8GlOHodypkI?=
 =?us-ascii?Q?6bhxBDJyRsQbO295BnrBhXvnKnU4+hOXODsfYVQlQrexWqqBvknvxZp1o6qr?=
 =?us-ascii?Q?FZNBXY+jVGplbf7FRehVIMjAd27++HFqjcjoGV8JhT0jTLyKtEWIVLHJhnq+?=
 =?us-ascii?Q?Qn0M/lhktCFcqXP5ejUyQBup71Ig860mbu3tlAScV5riNmR0C57ROVUROyol?=
 =?us-ascii?Q?tzOLh5dFkCHz0TGro1S3EuRwibvgQWzwNp0Sx1Zurcklnf0URHVcsXuMDBfj?=
 =?us-ascii?Q?HCJ4SY+253PctuGWbsbsP+BFCwD9I0GSxbIA2f/zYHOIMmok/F00+vyD6wTP?=
 =?us-ascii?Q?LKtoUhZnsTBT8jGPVBbsSU7P/jN4ZGZdasF2hVA+IO4Xm5gq2YNRaQlMClUr?=
 =?us-ascii?Q?obsdMk/z5Gz9/BvI82OSl3f+m4pR5ZrvRVFjUCQHCcQ6LIAgAOHq89cH5ikk?=
 =?us-ascii?Q?SZ0LDUNcs7DefUcB/7wrQjGjTf+HMLBDx5rLyPt0bAZEZkzWEJJ3Vah5fSSZ?=
 =?us-ascii?Q?/RaseemJdVOl/3CooF7st2I+XvnXzJKWcEMXJSp4Geb4l5XysYPRIpJHKErX?=
 =?us-ascii?Q?HIffCUWoD1h3HPEDLp7igN7O9tzpfvpM9XKB/dAv9qNu/GTki7Js5Imo6N25?=
 =?us-ascii?Q?7qQIqIBI+Qb2u8P3nKVhnXLAahr9PUVtFVEBhuHBPz1hmoAkfmMPpq2yMLl9?=
 =?us-ascii?Q?8iXyZMngngcHonm7PFK26zFxhc0GnWI9HEZVWUfkka2pe51II6nfvqo+PaQj?=
 =?us-ascii?Q?JbxuyWrPnjCT4hVJu82Eph7Mjg3DxB3WIhChnkBr4lALRIOVTInM8xuXnbzB?=
 =?us-ascii?Q?wz7XsaxYYkEFDKOwAPruUeGh/dCj7jk0zDlDL34dXHNLy/eb2WnvAWAgaYxZ?=
 =?us-ascii?Q?Vx3K6G4CNgzs5+16O2NA/WCcoxHZmriOVez02oy5jwkoVA+M2hq5NPDFMTy8?=
 =?us-ascii?Q?f7LNwv5ScS04Z5ekcuqucy9fqWN4j6Hn+0bitsxiAN00NYJcawomYxL54Ukm?=
 =?us-ascii?Q?ABkuZvYod40eTolteH4BYobGjcUiuTo6QoBhB0T9gPem9GGanafEe4mKIqte?=
 =?us-ascii?Q?x7jEjl4zSrbYHL6qcF4dUIa18tj/srJ4513iDaYsnkOVYzX2oMbs7AZdSwQH?=
 =?us-ascii?Q?a6cyZuvRwIBC19cxQsg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 10:31:38.1968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f50e2b-2514-44a8-e835-08de08b15c42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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

The kernel OOPS occurs due to a NULL pointer dereference in
amdttm_resource_manager_usage() when accessing the ttm_resource_manager lock,
specifically on APU devices:

[  911.954646] BUG: kernel NULL pointer dereference, address: 00000000000008f8
[  911.962437] #PF: supervisor write access in kernel mode
[  912.007045] RIP: 0010:_raw_spin_lock+0x1e/0x40
[  912.105151]  amdttm_resource_manager_usage+0x1f/0x40 [amdttm]
[  912.111579]  amdgpu_cs_parser_bos.isra.0+0x543/0x800 [amdgpu]

This happens because APU devices (adev->gmc.is_app_apu) don't initialize
vram_mgr.manager (no dedicated VRAM), but the code still attempted to calculate
memory migration thresholds using VRAM-specific logic.

Fix this by:
1. Merging APU check with the existing bandwidth control support check in
   amdgpu_cs_get_threshold_for_moves()
2. Returning 0 thresholds immediately for APU devices to skip VRAM-related logic

This prevents accessing uninitialized vram_mgr.manager on APUs and avoids the
NULL pointer dereference in _raw_spin_lock().

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5f515fdcc775..d80414b32015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -709,7 +709,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	 */
 	const s64 us_upper_bound = 200000;
 
-	if (!adev->mm_stats.log2_max_MBps) {
+	if ((!adev->mm_stats.log2_max_MBps) || adev->gmc.is_app_apu) {
 		*max_bytes = 0;
 		*max_vis_bytes = 0;
 		return;
-- 
2.49.0

