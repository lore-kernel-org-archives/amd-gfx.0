Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17467CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730FF10E96F;
	Tue, 16 Jun 2026 09:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMLBYaoB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6B310E975
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI1rzftVB4tIxt6qNLaH+H/WatsR1Jw+1iZCaGeuz6Q+2xbtv0ktPhOplY+PrblyIcrrwY/py7behMeX+nKNcBm7N+ov2W0BVG4u9aQVjUNOsMoWgWhfbq91ukKFQqpcfFIvchyfMnF2v9QejbPtIRcbSzC3/8sk5NgEY6weDEIKz3uHz29WV2EA0JyZxQIXlZOjvqyg3FmlIAY3wTGcWBr53ARiBJZtn36zOqY/jLFIDy3loCGizTA3w4x1Bp0tEfVvvE4K5ldmfjCWzqDS7UGJ6Roo6JWRgG40ONOu+L+Y3nd3XKVW6ICMnnZX9X09cRxEnXWyicsWOW2j/FgTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owLF2fj7v7YYw5geXfrUUK4oD09JZeTVi/pPk3rsP0M=;
 b=tz5p6oiVt61huhYEehfjavCUE/Oi9jzyAqAOI8wAKjgQ1HDIg6zqBQrYegnNvIr+y6uneJ8adqCw62L/nqjxUkaTvDcIt6vsjGPO4iXwa41MhV8lq83k30Sf/zkpMQHmhALasZDHSopNe+ydmVg8HLBaNWwHunp3j/X32QHjYfBCaac9Bi9sDZ0Er45uXI4OC7uxCLnhyVKzfEK6DuDVoBI2fXAr5xChwL7u/z84PyJCW7iumKwdIBbQ0DaaOvLdUsDmrNApnJ4PamVaAUPUiwpFqB5pbnPN1svZywu1IiHZ48pGXfiALgvaGX9GMgdjQmkO1LP4rT0GRA7tCGb6uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owLF2fj7v7YYw5geXfrUUK4oD09JZeTVi/pPk3rsP0M=;
 b=KMLBYaoBgOWTsw2rm/EJJUO9wwBQvr4j2JWkLHFvh31J8Gg6EpzToLslaDmtrMk3hk4m0AePjSlVVaKxzYmUo2HMp7A+/+981zlUBEy4T07LhFhq2ybEyKNBktm9t8QDSEQ5fdH2IWOcRwRtjjORy/8QR+syuDT1S5NFmTY13+s=
Received: from SJ0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:33a::11)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 09:17:41 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::9f) by SJ0PR03CA0006.outlook.office365.com
 (2603:10b6:a03:33a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:17:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:17:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:17:39 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 04:17:37 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 0/4] drm/amd/pm: smu_v14_0_0: DPM clock fixes for Strix Halo
Date: Tue, 16 Jun 2026 14:47:27 +0530
Message-ID: <20260616091731.3722-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 8416e5f0-b40f-4613-cd62-08decb881da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 4qVVJYizATd/FcQQLg/7nnoxaGjhmaY5FnHoXwqyV+97z37k9dY6QGM5qhouarXipU6ypb4Ku/noOC02lAhdMd3iKcDoXnzGtLi2R21ekVjvStJcek1LxtIuU+zDSjexQTeXdgN+C4hFku5SKyluOpX4ssEW5CV7KCysMuFgCDwoHzqpAHF/gyxoS9FcSHE9YTLIb4oMok6QhyQ9NUjdmi1AWaKlzzJs3bvoU26M42Fb9B12Ft10GVSFXRmaem941mpFo7mr5pmR1yeF+60BpD6pqjRHAaNinkB7RIwtPC6YynTjXU3smqbJslyfXybJrPlqMuk3NRLoNet2K1Yx7S6GVW4mahh6ztmXpOEdPgNaX87FYumP5sJFRD/rO35kczYrE4qGruNiZnlffvYF1uwaa0cd2ebAf47AVIhN+Rg2EAGrc5ZuxgfbdzXhaI8QlNS9mzWzwyyqSTTwKD/kB6gYGEodE4BNfYLT+5dXYXhovy/WrCKYm/vaqqldRw3EpbsYJHR/KfGSknp3aaN6B4b+eebHeTrMP0I4XIilkBrueQPYNIZZyxdunuBYQsuskoPunXgGUcySOtWf6ZWrHhoM+exd9h81Z3IR8qzE3XfAqtWjTNoqkxWFvFl+3oPeVNL/1aM95YyzuZCCwHwTglZRorSs1buYZ/bcwYDRMRRmorplWywRRgkUIu7DWhOGw5vX9l0Ij5t3ywCcl/txerqaCCPoNMhqpuOnapQN9pg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nSicIMg+hesA4PZJx8nHzP25LrltWHrufF/IW8MHZr2PaLTd2PPfy6NFe/c/BkDxRZ/oK/lhbo98t5VqY/Fby5dJCv9aRpbcjzL7KXQVeUvBRm0AF5sIJHpfjhPuUKvnu3i5ugEgbNq6yRCWyGBUY1Cluj18+SIlaSQxR1NxqUN2FK8KDIu8w3zaerQ5GCCDqzwPlX/uOankX0qOWf0pyGCpIdrZbh8nDyOcMwSvPaU3fVjCuhdSBtGyh35CZFScKDXXIF89tNLYstZI5ogEJoofIb2Hp0DlFbYa7umN9g/FISXqCLT4L0N7gdakAzjHUwC8U4raR4jEanVqpSxX2+1XJrUG9rsGJN8kV56tSReOMUe375Dp4iiivdaB0FYSB/jGU8S9De0ug3B28gC5UYr/MNEIzXmcRYhE0yhOju0geohMy7MlmA+aYjSXXu6s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:17:40.4356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8416e5f0-b40f-4613-cd62-08decb881da3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
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

This series fixes DPM clock reporting issues on SMU v14.0.x APUs
(Strix Halo / GC 11.5.x / SMU 14.0.1):

1. Introduce smu_v14_0_0_find_clk_level() helper and fix DCLK metric
   reporting by looking up the VCLK DPM level index
2. Expose vclk/dclk DPM sysfs entries for IP_VERSION(11,5,1)
3. Add SMU_DCEFCLK support in DPM frequency queries
4. Use the shared helper in emit_clk_levels for closest-match DPM
   level marking

v5:
- Extract smu_v14_0_0_find_clk_level() helper used by both DCLK
  metric lookup (patch 1) and emit_clk_levels (patch 4) per Lijo's
  review feedback on v4

v4:
- Drop early-break optimisation (Lijo)
- Drop explicit count guard; rely on for-loop (Lijo)
- Add Reviewed-by: Lijo Lazar on patch 4

v3:
- Add closest-match DPM fallback (patch 4) for MCLK/FCLK marker
- Reverse DPM index for SMU_MCLK
- Add SMU_DCEFCLK support (patch 3)

v2:
- Split IP_VERSION(11,5,1) whitelists to a separate patch

Priya Hosur (4):
  drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting via VCLK level
    index
  drm/amd/pm: add IP_VERSION(11,5,1) to vclk/dclk DPM sysfs whitelists
  drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in DPM frequency
    queries
  drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM level marking

 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   8 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 105 +++++++++++++++++-
 2 files changed, 106 insertions(+), 7 deletions(-)

-- 
2.43.0

