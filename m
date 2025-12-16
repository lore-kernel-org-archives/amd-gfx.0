Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84780D5E374
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A7010E194;
	Tue, 16 Dec 2025 21:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uLp8rtS/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4632C10E194
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmGj6ffylIbzh8dqUvlW23MTcMLHmJWVxTMPsD026ZZlQZXYQ5avIDu2XUp9BED+/j3BAjT65DGzIrM6sRLi84Q1TfjQpA8MqbhWdCHRapdGlwzCpxCMpC/uwnbaH5hAnKYDkgTF/KYxHnj7kSjewjU+n9GN22iB7GxojV+ZqW0FSqyKmD/AJLe8WCqy5vj1IayQZZLq1muDm6Fe1wnDlX1VImf+ctu46z2UJCH1G37NhFmlmaA8wMY4sbBGK8Pde+SuNE/ptp4qjuYXDbq9wAn5wHx930X5ORVHTCf1IkxdvULS1ZWSCRGlWlQuV5KjKUXwGIBK91q4+a8cqZi3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpqDVq8ooYimnMETDLWtcymZPpxA0Y5DbjBjNCzKFKM=;
 b=fi00emKpPN00uPqLVO0bSmKiXWVDb1wGtR90SheFQ2hyk5gGsZSezy7VWFhR+UmW5bU8KG0XDJ3TsAF5YQHf9v96T7bsGXQNOAFu7ttVskQNXonyhjE7m1BPBcVzQybvoYaKHOjW0eBeoTV6Da1B8HmVNRJbmn7PEF06Q1DJanTMZUq4n17tX7ctj1FzDVAnh5PMeABrUV4nwER8CAWFnJY0Td7/cToITy4q2CVIxz932FckxIhi+bExudr/e/RcljJMKMweoDgoGwWs07mDw/onZdmzWrxnUAHQg0WX6ik0fJSY6SLq5jBTtfn+pfyLq5xCarDbnnM0MqIF3efspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpqDVq8ooYimnMETDLWtcymZPpxA0Y5DbjBjNCzKFKM=;
 b=uLp8rtS/jD64q+Ny2MthbUTlMpMV+HVjaNx1HlAuNbuNOR5gm130oP6xTPgEZFYFaeMlvf7X21mmO/pHsXyej+yafjyVmZsX9uTXvLqXA6fCznOd2Ys53vqN6DF4Kj/ZpHi7AQ6wksSVx4CMBcJbC2i7X+OimX89mFRf/L3/nEE=
Received: from BL1P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::23)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:03 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d9) by BL1P223CA0018.outlook.office365.com
 (2603:10b6:208:2c4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:03 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Always set PTE.B for device memory on GFX 12.1
Date: Tue, 16 Dec 2025 16:03:28 -0500
Message-ID: <20251216210349.1963466-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: aef91594-4184-4ba1-ebf9-08de3ce6a491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yQH/uA6X4wGa3+5LBKAaJ1FXsus+BQ4+fAqIB85cda/+Jp3ctnwtVmRjPkkA?=
 =?us-ascii?Q?8x3GlncMLnXVD8urwyD0xlpaT7tlOad2UH4djENZLiYMJQweC/YKiP9U8Jfa?=
 =?us-ascii?Q?aXYUu8Iz6PWERu5nd0TcTW5DlYCk/lln9aarlix2xJzD91ACA8aYRoWigcJf?=
 =?us-ascii?Q?ssf9gk1g500eh3gTg/myYuD99kwrggEF6lK4HXwvc8u6IswsKq3K+IzF8xKG?=
 =?us-ascii?Q?U19tWWTVP1GoV4zze72pNw+SidCuwzmkzD7WfmNQnGyWiN9BCVAY+pJkoB67?=
 =?us-ascii?Q?iFmDQGys17FOZ3LXcMw8XDmCXR8hLvENiemtE9Zw8jw4eKl8th9dM6M5l7f9?=
 =?us-ascii?Q?LjmwTW6TsHP+omwST41FMeQ82vuCRCkMCJPNJAZA6cRReXTh5zDvIXjre1Ui?=
 =?us-ascii?Q?KqJXGsOV8obypEvtm517lmiLFBQFKBTPkUYw8sH2N710FFJWgSq/bqeTBN/+?=
 =?us-ascii?Q?uSXADivPrm7XA6w/ee7RYrI8K35Skdbp97GO4Up9vtOCaDqlNcGhnUJm9/45?=
 =?us-ascii?Q?U9FB+hSkBh4ZymK73wM8M8VhFJE256wnCJTaomtAv5Dltvl/Q8QH7G0E8lVk?=
 =?us-ascii?Q?sKs6hndY85ri3UgnhY3FUwyJ+QhShyPvBHuy0Bpr+9lNah9HRuymuO0T8Orm?=
 =?us-ascii?Q?6lCy0bD2Toq+cZgYS+923Qu5jwCtEJGDqFrQK79eNsll/ZaZ2M4j2UtsNFas?=
 =?us-ascii?Q?C065PBFFMgxwmoY/MVgKTW8BBn3pfBfhTuLEqShs+Fb0TUBkvcsmv3lE4ANM?=
 =?us-ascii?Q?aBF67x9Cp6CDFLOx8h4sAlkUXLL7puhtdg1QJA3oL0MxmnQjIA4TA70Xf4Dl?=
 =?us-ascii?Q?rIPH/dgQg4jPHH59HYU78KfLTzD+gzRoKrrD4vNxReTPrsqNQxWcMGsVx8NY?=
 =?us-ascii?Q?YaBm1ox6i3uXyZ5HVOVf45a2Kt6tbvcDYr1nefZLaoGDP3JJpC16yV/XJWb/?=
 =?us-ascii?Q?p2SkYMkVXaYR4yFixPH7GhRCDEU/YVM1+a2OwG7ALz8N4kcw9mlwMDpwX4aJ?=
 =?us-ascii?Q?efHghbVXawdUOGPEPdEm0WxGOmpbtuvkL//tfbAH0FSkf2GA/H3af3jGRCQf?=
 =?us-ascii?Q?NUys6PkTtS7sVn8HncQVNG7if1mkg+ZRt97CjM+8qkN2OqHwcetXNL7Edcyh?=
 =?us-ascii?Q?lZ4aUoT2b36DQ53mXiE60AHAlxfZQ+CSodR+bgdTvgolAgBycO5RNL7OnMeN?=
 =?us-ascii?Q?imEkbPF8ay36K1C0I48D0woyxb7lStlmXCbDhmG+hR73JLyMuHcEter8U9d+?=
 =?us-ascii?Q?Dn21xZsWMQhX0PVY1kIStoJETbgGH+fjZCspAl1cyzeZWhF2+OPfwgBNgEs0?=
 =?us-ascii?Q?HPaP7K+IySYmu5QdwQ6ZOU1o8LV/O1k1ysJWc6bb36OAWvAb7uw2n+2nUnIJ?=
 =?us-ascii?Q?Z1s+wyVyHvt9afa1RaNLTCbbF7O+P3Ud2KTDChnH7VJkLFTtXOoHrjtnk7gh?=
 =?us-ascii?Q?mGuSwHnW8VHgiFpenpZ1Fu7tQNdkqAVYd47q8JeGkXm0fMkZMme0PQruP7lL?=
 =?us-ascii?Q?br+MMOIH2rGIdNkV9Lmkl+XeXViF/JkUcn1FgROaeZE02H2aR2WLLfjkub0V?=
 =?us-ascii?Q?uh1uR7ugixaJwKGDU2I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:03.3917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef91594-4184-4ba1-ebf9-08de3ce6a491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX 12.1, we need to set the atomics bit (PTE.B) always for
device memory.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 695f3cf05b6f6..bef28aedfb93b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -496,7 +496,7 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	unsigned int mtype, mtype_local;
 	bool snoop = false;
-	bool is_local;
+	bool is_local = false;
 
 	switch (gc_ip_version) {
 	case IP_VERSION(12, 1, 0):
@@ -533,6 +533,9 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 	if (mtype != MTYPE_NC)
 		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, mtype);
 
+	if (is_local || adev->have_atomics_support)
+		*flags |= AMDGPU_PTE_BUS_ATOMICS;
+
 	*flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 }
 
@@ -577,9 +580,6 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
 
-	if (adev->have_atomics_support)
-		*flags |= AMDGPU_PTE_BUS_ATOMICS;
-
 	if ((*flags & AMDGPU_PTE_VALID) && bo)
 		gmc_v12_1_get_coherence_flags(adev, bo, flags);
 }
-- 
2.52.0

