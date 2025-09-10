Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B86CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ECAB10E89D;
	Wed, 10 Sep 2025 08:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qSM+4/dj";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B731C10E89D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 08:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOJDbcfKv7X+wDH5vkJkjJsdWeQw1FY5+EE/df5phW1mUS9ZHI2QRYOvUdNna474Ek/e4wd0+/004rfPNJY6dfMcI2feNZEGFBYY3T+gf2rXm0Czwa1ijSpY4NCJmfmWf5zGCnDoSRobW2Ioe3mZ1RzOak2WPlSkDH6b+WGBaHiQoR/toW7KFyXj4RZdLkCPZvZS+5kbK9gEmxkCFQl7deG+bpZtW4CFbac9pstjctOwCTgih0ejk1drvzfxvybzOb/EaNgpnH5D7AvnlIITtpfdRqOoBWuc4JcKJI+CFC90HPSmUTjG75gEUR4Rey3XFKeV+Cp5VeMiSZ2ZsFhOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bC6HlyfrqAGhLCCG2XDKmt6+nZgd1MO70beahhqWk0=;
 b=WzbCJa+L2K8PfXGeTNwF5kF5HwTUum3zO9+nUht2hnNei5VWBaKyfX9eaqEfc2jFF69nEuM8KqiZsh+bZIje4oHsb1ILgBs9+wyho083kgDCkGncrPdAYbW/w+DjB5Jrj1D+0jXuwR4rLIyuCCgL+8yudIjcgrPbcUI6p/Vqd7ABGBG1TlHa4RYWeeoD/kNZPxc0t46lREjV3wcQIXWjvSdPghi8FLdCY8aDN43URx4uyOIvTts2rsylHAc/BKWFrvFdpTEGGb6eY5vPgCl8dm3w82XnWrwKsi3ulyffgddUSPG0iMU8Vg3OsYLQF4waU+WY7AOJLxLkD6cwSenYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bC6HlyfrqAGhLCCG2XDKmt6+nZgd1MO70beahhqWk0=;
 b=qSM+4/dj/uRh3DXrw/czK1bifUCHWIDo0UCVyyM8YSSgNlzHoPEIayl+VEetiy0RzoJRWpTf34nZCTzEd8eQ/aQbFFTTe6gyVA0yxIA4EVGYjRxWnwDgfgqnADGBMBUq+NMlaVV2051vB6y5wu73eUCCNP021DKYo5lRa/9RoY8=
Received: from CH0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:610:b2::9)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:16:55 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::bf) by CH0PR13CA0034.outlook.office365.com
 (2603:10b6:610:b2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Wed,
 10 Sep 2025 08:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 08:16:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 01:16:52 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Read memory vendor information
Date: Wed, 10 Sep 2025 13:46:33 +0530
Message-ID: <20250910081633.2940220-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d61a6fc-5de9-4287-2e74-08ddf0426708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ExFhGAbJ8v4x2CgjwHHp7VY9RDSEscaxSD5RR6sfaAAGcxDZfklo0rAS+vM?=
 =?us-ascii?Q?fxcAsrtD3GFrvmKcCDeqJbB2oxBXyO1cwqE7deIyXC9Y+5q94VEaD7ItUBF+?=
 =?us-ascii?Q?Zg7Mhe7ugPdOodkEx1xyKbFDx1uLCno4BasGCX+5slR5wbE9GWA/AO8Hlbth?=
 =?us-ascii?Q?hcKx6YZ8j9BhF6Gqid/xmbA35fKi1lfyQp4WaTKW+bcMlKEAGqWK0uv5YXmA?=
 =?us-ascii?Q?bT8bXQ+K86X/B04Xh7hKwVA97VMNW5M/FWfosRdePEOMc7+uwaKHHBYjpiTD?=
 =?us-ascii?Q?97nlMXJZN3v1/vWcpM7770uI73ctxiJCdLKatRL8ykK396/NKGQXkTQNGjj6?=
 =?us-ascii?Q?KcHZaEut8zK4om+j/8bCgLGKeqkftBWs9MUq5BseIMlPCut11cog330hVtrm?=
 =?us-ascii?Q?sETv+egeGWGBtE35lsG8dWcpFTSQKMk2xZiJGz6Jb1DJzgLU5UI5HpDg54Gd?=
 =?us-ascii?Q?lWwguoHD4lg3fCdLj/UxpkjjK5eJqBMBU0kAxhUqJ+ctu4lIq/f1yYE1P7U9?=
 =?us-ascii?Q?8Pi5rQ1UjSuAfzz69Sau00XqIcDcygiwLVS/6Rj6/EEgNT+45QWXrkw8Qk6J?=
 =?us-ascii?Q?5OhgxOfikqC7rFouoh7paJ4+Ue8qIwLzx8K7Zo+8wa5eFr3YUgJbVNdTKC0B?=
 =?us-ascii?Q?RLA+Q0twHawbtECbG04twmPAiuWxYhN00d7OVXq1jbL172b6iGL2uU0LO2oc?=
 =?us-ascii?Q?8IDoHFFJX6jxqVLfBW8qcKOcM38F5GgUUC4TIxMOGhv9Fj+2yaqDJoWe7907?=
 =?us-ascii?Q?uXW7Lot/R9qfEGJdcgt1PUYkXNspCuVQ6/kfK7sZUQSYQltvTjgEAOlzEhs5?=
 =?us-ascii?Q?smr8NeZ30iqeId/A7vpQLzZ2B3qe0W/LxmItPjZMH07n0n6bNQCrtlpTSjuY?=
 =?us-ascii?Q?e6FraAlCKIdsQt/RInHsvlpd3chGiW/B6M3hWPqcGe8ZZrSowFPCm+nqhj1g?=
 =?us-ascii?Q?0VlkRFY4jPDb6WEHncBawMFSWN1vElsqqHMnHETwcopLyTK24UYAyM63FjkO?=
 =?us-ascii?Q?2C6KLAw0Wu9Y6MKp3FyOUtHGBX5Pe2bsU91AlPPfLizfaOEwwzDAIPOWXl0G?=
 =?us-ascii?Q?snVNDe+lS7cxGhRmXQh1poAKDyZaAi6ZfoTgC7aAu7F/Vyuw743sTW4nQPfW?=
 =?us-ascii?Q?BPuoNEH1Dav4ydlGBKkNGJoYXrHuSK5GA8mfLyeBI90Ggo4yH9heb/ETtOx0?=
 =?us-ascii?Q?4Vyteg35JaeYX8SgRy5n3GeKlUEWCOOlPB6RR88plDbMdEsciXW16SGcfdRN?=
 =?us-ascii?Q?VyW1gmHZZcdKsmJS+AmDdSV5uBcFWh/eH0vPasaESLkY2St2fITRWW0hhFHA?=
 =?us-ascii?Q?HImQO5U3Nn2V3IDxDSyFTwRn8eD76FxcV/T/2KBO6N3uytb4CN7Xgouz4ZiH?=
 =?us-ascii?Q?eiIuunz1QoNMlZlT3TLi1934re9lkekiQ44ejkpJ9R3Tr3UplqocVv4jNrnZ?=
 =?us-ascii?Q?MkI2/NBwdX/HQaUnC260udNKu3bYWJfoWgK3kxhGokL6QXHdWncGVSP2TwGz?=
 =?us-ascii?Q?fNTDxD/uuZu1PzByDUuODnT3JZ8RUkVUNSt3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:16:54.3023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d61a6fc-5de9-4287-2e74-08ddf0426708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

Read VRAM vendor information from scratch register for GC v9.4.3 and
GC v9.5.0 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8404695eb13f..0d1dd587db5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1834,11 +1834,19 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 
 static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 {
+	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
+	u32 vram_info;
+
 	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
 	adev->gmc.vram_width = 128 * 64;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
+		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
+		adev->gmc.vram_vendor = vram_info & 0xF;
+	}
 }
 
 static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
-- 
2.49.0

