Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C961C2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE8710EA70;
	Wed, 21 May 2025 15:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QHBnUwcC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A2510E8B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvhDQR9UIRZdHhetExsvCkalMdEt0QITmocrd/91YmcV3F67Lq3MXqeUDABeAh5jKaFih08O7jq4KJEVMu+vNb/zpscOihd4M236of8ZljEm8AuiBld0kJ/ykH5m/zRc+zI8l/csgX67c2SQbZt4hlEAc/0EtaeJKFophcpsOVWG18TEX1LYeis3+gzf3G82j8Bn0Yw0tKgOpAr50sukNdvNcGFWeAjTlZiDhjy53lA1/Uqf2RDSkFd/W7UiCHux690PkUBueue/7ucL9J0DsErkt7B7qCjaAnE4cXDRAqP8qSrC14tWfD8bmI/VXyYG8vQNdqwv5+a8SuG8R1pngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh4uN7AnFjp2BiFEPpymSIai4XnULb+wy6FgVs+qvtM=;
 b=eZwrsxAdrf7jF+aMDuedTJffgXQ5+YwK77kKxkv8Bg6P/CBA5CGvhCrsajPuOll274mTZWpbmpbr3TioDrzUTh7tCZldjHAK5xMCi/u62m6zLGXdVa8j4AuiTr4JE/AfZCcC3vfmVqjWzzXo52L3dKEg50BD9j2x32t18Ne4yHjMIAxQ6UAzYJJ6WQsy5ggSI1Oke1SJy8QpztvUk5FvaBJfYHXyH9VmcQIKUievgmMjmSspA1dhkqw6xDOgB9xZKU+llCy4HvZ5PiqcPITrIRnc0f6lKxWySNbe4brTMOHNXgFIvgVeHcjBLMmEjyBKvQTod95BfmEeUfmtaNOZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh4uN7AnFjp2BiFEPpymSIai4XnULb+wy6FgVs+qvtM=;
 b=QHBnUwcC9fRpSFGY9WmAn3ekYOxe6mYjjpGjis8C8WI13CwVnM8+98Aksmi3UzNa2ywHeqPgPz1mXh3gjdINFiIoHAaRM7yVDOVmmBTYioDQbrhHt3fBf3DDk7/gwTsnvljIAEOLRafigoeQqiySQArm6QpkcGKAT+qOe24iJmI=
Received: from PH8PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:2cf::29)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 21 May
 2025 15:29:49 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::68) by PH8PR07CA0041.outlook.office365.com
 (2603:10b6:510:2cf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 15:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/10] drm/amdgpu/gfx10: enable legacy enforce isolation
Date: Wed, 21 May 2025 11:29:22 -0400
Message-ID: <20250521152923.401945-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 9568b2be-29dc-47f5-cb41-08dd987c530d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ulsoGaj/zF23PgAnKrO/VJ7N6wYf0VBwl2gnW0zBT+c6o/oRtSbAtVZWqOBW?=
 =?us-ascii?Q?kOq3K5DRykbPU4khKUWY0BAgctpE87dURbSkXkFUjemLUPvOVMy0KTSyE0ev?=
 =?us-ascii?Q?SE5TR7FfOJ2ZCfo/BNAL5iUHwp7hRiBDfR1GrCkNlT54eb01NEg6n22Ipsvg?=
 =?us-ascii?Q?ZuPXzFnsLGM5ZZKESlyh6/GUXcm5uroSbHagJ+Xmv5U/9RqRnCcSK+V83qXf?=
 =?us-ascii?Q?tKan5P9pxVXI/BiNAmoqt6fhGjZ5I09QQOteLXGXV9aAXmQJYdIhOn6BzHc8?=
 =?us-ascii?Q?stao7IiHlnX9TZeDO9ROr5QWjpKInA82iNOd0prYqTRpTmcTSu86hKzUTazF?=
 =?us-ascii?Q?vule8CQfk0sJ+LSzAwRc3YkkK0O2tgH1DrmfqFso7xieTMJg3NeKCUPZWkEi?=
 =?us-ascii?Q?hu0wy4+XOyiAdebn9lwMWfVGR71aXyAsK+9dHFg5O5cEIbDPezq9Yt++bM04?=
 =?us-ascii?Q?BGSKcJ0fQcl7BHDsWcx7Gzn5FzvgY3O2StNG6sD/wId24P2v9ikT00K8y70w?=
 =?us-ascii?Q?LTCL9c/O3se/2j5U8aegJn4UEMqL39nqeVVZNKx7pc8OTocYm+/VwMZZ9KFB?=
 =?us-ascii?Q?SulCfOLud4mmng5EFderzuEunG4qyBFYbhDZDbdlx94gTCRv0QDyQ+HZcLZA?=
 =?us-ascii?Q?3SHtlPFY0uiFTfdRs3ToWGh530N2rGd9NLKFtZxhmM+NPNwbWL9OVP6X8Yi2?=
 =?us-ascii?Q?alcpKs/ckkYJyRH5nykSwIhaXRK2jOa4bfYGc4IKrtttiNHJGs/K+dpWXgt2?=
 =?us-ascii?Q?dxxEBWFDIEyQt0VtnkiXfKHG4AQu6V3gi0rgenjbqiUA8AGVSxE0azFf/unN?=
 =?us-ascii?Q?9SU46pMAdfVrzuZwKO03sORPW4et7sQpFHW62mtpiVHQEbqOrP0BKYQlEHhL?=
 =?us-ascii?Q?6I4/B5I+6m/DUhQOeHopBWjBjgnuXT4qs6N6XK5+wJsqCI/JNI/61jh5Symr?=
 =?us-ascii?Q?sKyWyDFzUeZn9gIUDAcdqNYonWohhoWAtdE5TNk4lXiYVFfLqVCPa1JokAV5?=
 =?us-ascii?Q?OLvmygehLproFamW6UUtcIAiwvnSaWi3POgScRN5ZVR3QqDs2r/BgigBPVfu?=
 =?us-ascii?Q?Q3hau2qHm1VdAS/HGH/1AKaXzaMBnwVqdyINTbwoWokDytgQ3NW7bLG6N002?=
 =?us-ascii?Q?CnO2ZWIZQtrNKcoBlIaISQSzqjXPUlsCw7Fx2uy+C8LtoF467Rr2I+3gPdjj?=
 =?us-ascii?Q?uAM/Xrgwmo2yT+VKHi/TluWPrY9M8hCx1Se8JNzcRtnH3cL80XP8xtOiguFV?=
 =?us-ascii?Q?H4YDmeDTSefJzLeulKmOhSNRiu6bz6Ig+8plwflWIVLW4qZoLtrlHFUsRJ0y?=
 =?us-ascii?Q?4ebotkjZW93j6NnNpKfEelkLcfEH2iVfDQYebzgFI8g08b5mbbC4D9zINz2F?=
 =?us-ascii?Q?a4M+qZHeMMr6NK5/yzhwZL69RW+lZDDFNMumM1rM+lye5huCzTsII6psL3/D?=
 =?us-ascii?Q?4gREkhzyVguipUCYzu2XOgfowoflpXTrdKGeuIXJnEq7m20OfVNCQ+lRjFSL?=
 =?us-ascii?Q?jfr4Cyaa8PLK3Tu08W0UFYccDQjghZHLUhK3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:49.2253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9568b2be-29dc-47f5-cb41-08dd987c530d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 14cbd1f08eb5c..eb838cd946bee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7788,6 +7788,15 @@ static void gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	if (amdgpu_enforce_isolation == -1) {
+		for (i = 0; i < MAX_XCP; i++) {
+			/* enable legacy mode by default */
+                        adev->enforce_isolation[i] =
+                                AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+		}
+	}
 
 	adev->gfx.funcs = &gfx_v10_0_gfx_funcs;
 
-- 
2.49.0

