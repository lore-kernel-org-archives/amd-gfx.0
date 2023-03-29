Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7478C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F9810EC44;
	Wed, 29 Mar 2023 20:14:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46C510EC39
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POsIUlsgOQaf4U96v/ajInGNRQNjQdKOauGg9P5m5lAcjJhrdSHqufBboApG6Iu41RN8qaUdvpPdbySZImdVRne22C3Iw4JDbZWOyk86Vvt3jv1CaaPknG+K+cES+wqysdlQkp6eNpIbUJOKjdH7mImjlo2EcNkH+660XXlRyOD/dZN3y0J4M9ar8Fno2MxlENsAOQ/JxgZv1hsUw8Ph2W92PHCrgWyp7SwEZZLfBeZlkNdM99RY6DFME4OBwo9zxwh5H8YRRSa88GE7ju3fVzX5CAFpJ7FhizApuOoPkBh6g+F5kf+cCafydXkH8zC49oi9g1nIebYL01cE1v3O1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRV/Jm2rCoklxnjPmL2VHZ+XX0N01ADZwEH7GVvMEYY=;
 b=iCJJZqBo9ckknnuTO5air6cffcgkDYHFkw7Chdh9NMzkYfNKnpKHNbCkIW/BkH8xXDBmFcK3rA7Y5eH7Q6IjGm/nC+w+5JYEqB9iofjnLD6V+MzgGo8klbaFPMEH9wZYdE1kfao+0R14JOtVk6GGnbHrr+3ekO+IpcG981B/g9jctqOTVshlnGGK84zolNCVQS9lDuBcvhPRA+2eb1b7V7YcNZZu0amONX/F5rrWlc8Sh5kZHt2AqHYmR8clXQxDVAitt9YdTER4lQ0twUVsO++b4ruqzzVOgdpC1KsiX9zK195xJ50qFTOYYnK2KcqRBWFReltzLg0GkPfXueccAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRV/Jm2rCoklxnjPmL2VHZ+XX0N01ADZwEH7GVvMEYY=;
 b=P5eiq4aYH6PuhhLsennjQFBco5lxQs2IBsV4clnHtDDdo7cYP1rtvP8Dv/Sia3qPC56hmhN9trJemHC25ZW9YjTrcDfw0haAkAjQo6ApXkc+6lxgT+zLrRhwdhjB16srw0NFo0aLp6beol9lfABTJMWlO7zWq/k2P1ERiZcvzeM=
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 20:14:47 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::11) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amdkfd: Fix XGMI SDMA user-mode queue allocation
Date: Wed, 29 Mar 2023 16:14:17 -0400
Message-ID: <20230329201426.1982669-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c95f39-ce60-48d0-0748-08db30923e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nMJj0USY9saYjinEnI0ssOROQ0p5UNdsiN7IxmN+/YdWVi4QqjEg3KWZPfXh+nK0EH7FSirGR1PuvwTNNYylXpQ1FMJ+v2qMisv17GIXoS3ngqZ1ahhu7a7JZ1cEASs+oQzT/4ihFIJIyNx/p4qTu+uR9nhxvRi/Mmao22CgJlVgj091MAkNsU3hTuOOxsD35NnhVuIvCE6sgOAEQXy+Dwl3SU4K0piOYRrVd9/WzUPFIB3Ie5/EO+UYOvTFVQK+awUWZtE0k94O4Xbbd5kBFMfvF0TYAXqes2aACJ+NbUigOVizx6PZpHBrYaJ7xA+zgeTV7io9OLa8LTfTYKt0XNdq7VzEaOQB1r7wNiFOGwu4k7/GDOCtOXFxB5nvU0G+d58MUR0YsPhjnKEPwcIrsJkY5k0e9qlJXmpMaJkjpgaEPAPQtkokBx/1wGXA8td0XsjGBI/7HC0amIXiROHLwGC60DgKqKmhb0XiywKSOURiwIFS/Ekj2uBMMExdsZF6xmB+/2Y1Qffk+2fhD/G1c1i9kjHP5EUsbrSVhdv+Jj7NqD/3DyxTYYmbD4cMPPcjRnMXl9VsemOc5TVBBc0ujmF8TmNNpyGL3arsmSPZOUtNlCWon1LtCS+X7GD+vRwYJbUHUkt9fQdzrinrnL7CHejD17brKQXxLJS7eyVTKS1IKTSrAUlX6RWzO6evke4CgOgFRbjJ012cqwyDgsx22XF/BbENJSM1BcMcUCf/FU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2906002)(336012)(83380400001)(426003)(2616005)(41300700001)(86362001)(36860700001)(36756003)(40460700003)(82740400003)(5660300002)(81166007)(356005)(40480700001)(478600001)(7696005)(8676002)(54906003)(6916009)(70206006)(70586007)(4326008)(16526019)(6666004)(186003)(82310400005)(1076003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:47.3849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c95f39-ce60-48d0-0748-08db30923e84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

The recent overhauling of SDMA queue management introduced a
bug where XGMI SDMA user-mode queue allocation would mark bits
in the SDMA queue bitmap as set, representing a queue from
non-XGMI SDMA engines was allocated. This patch
addresses this issue and fixes the xGMI SDMA queue allocation.

Fixes: df7f2df1a466 ("drm/amdkfd: Update SDMA queue management for GFX9.4.3")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 527a2e0eef81..ab91a0e211c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1416,7 +1416,7 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		} else {
 			bit = find_first_bit(dqm->xgmi_sdma_bitmap,
 					     get_num_xgmi_sdma_queues(dqm));
-			clear_bit(bit, dqm->sdma_bitmap);
+			clear_bit(bit, dqm->xgmi_sdma_bitmap);
 			q->sdma_id = bit;
 		}
 		/* sdma_engine_id is sdma id including
-- 
2.39.2

