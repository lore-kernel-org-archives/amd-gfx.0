Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64716C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DED6710E990;
	Thu, 28 Apr 2022 18:45:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2678B10E990
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/4ryBYxafgFvQz0xAaPe0SLvvK2TYm7+hf5mD6ou3aGgJfB0z5qMxNTYLEKZYnbx3M9QlcUZv7DE5A2pgt232fxjIkqVMQexwixsLsHBlosVuSKJmYBg9uwS0EQocDdFwhBPcBw08mAVM4iUdxm3LW9smvI8oqBdGJOdvFx3u5fkdlIB3ZAtCBDYbyKvgcrlbKx1BoGVp5UQqXZgL5juz8yZL7jusDyHChySfryXxDesnMOLw2w3M3a+CKqLHWWt6OQmV7dTdKDs9DYTVNykdyaYjJHvvKnpWjzyp9Y5Y5IyfFs+yXuHLMUmA6jMz3BZ6WN2lKEIdIqYivwNv3SvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IihEBtHykthnjBpUeic/cx5OSaUOClsMrsmDn1i+kQM=;
 b=LuXvGYqEauFjB8R17AEvfrDzLkvQ5aybJIsSOxPnGTx3xhclQf87b5CpYP4JehxQXnYH2GMElg9yp2u1ISinTlGsKQ4VCORSfFTtYllIIwwGlh6+4AwXNpvXeQ0m5ke08Z2d2iJLe112FCF73WhmfIo351YSROpkbC7UmcGVb5NO0HqhDSpD1DW73NmnXJpW0Kn6UUCdd8+lqs6uRM9j9MOsRKTFOUGLhREbKFDXK5qHLhzm+YSWKisV8rEEE6l1/wpV0m2ECfN/25kARrw28ILg2rPIRD9q9Unp/5VfDOiLW6gmhPZHdysbSzjcU1ZJJHPlec4IYKWmrj0inTHQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IihEBtHykthnjBpUeic/cx5OSaUOClsMrsmDn1i+kQM=;
 b=1a5Y1J9B0SSBR5a811jebqA+uMpY9cQY0tzL8nE6xxjPCWd3j0vA0m7wMgDODAccQPy/QbgQ0U9Rf4bedflhxpJdv4EcVlO607FnaU/jisaHheAEwnap7XzhMcFjXrChOzkkBEqEXmn0Eky5Gx0ZUd71u6rggvHhoTC+UoBmEbk=
Received: from DS7PR03CA0203.namprd03.prod.outlook.com (2603:10b6:5:3b6::28)
 by BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 18:45:35 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::42) by DS7PR03CA0203.outlook.office365.com
 (2603:10b6:5:3b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 18:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:45:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:45:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: support psp v13_0_0 microcode init
Date: Thu, 28 Apr 2022 14:45:17 -0400
Message-ID: <20220428184520.651971-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428184520.651971-1-alexander.deucher@amd.com>
References: <20220428184520.651971-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d405140-2f56-49b7-4f81-08da294747ca
X-MS-TrafficTypeDiagnostic: BL0PR12MB2547:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25479CC2673460C01EDF0BF0F7FD9@BL0PR12MB2547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ojh6oYZgFpN/5xDJkJdAc1vD/586Tf1Avuqat+Lb+J6/lC0+T99hmfBAM9oFSTGOC8iJCYpUMLA7Ic2BzJR9pvCeLDZwWdnkx7Ie+Qc7H6rh0VPsPPBnGKzRH7HtzZnGMoUHWWUfVfVQ0byyGUODU488GWPG8WNBu8nh0TdVIQn9L4oD9nToshN5zLpaLxU3cN4cc6Mu/du5BT+5y/Z5gzT/0X1TKT6ooQ/h0WB886cbjB2Y5an70K/JWCnGrlOC97m9H3nCsKxKDvLq2whQ6Ec9jt7ixuXFb/gZv2kw4sY4rf/FxnOEJhcVn62H9QBsG8IDTnkkqv4SGrl6Cq31DeaZRlJA/tuEVuDmF4qRp6V6HH4ONZXsiYIrZocx5Y2Ijn8+MnpnVbmpdiLj4Yet11X9rt7ypEAT7qeoTJEzXJT/XpE+uJzQt+/MC7JT2lyNafOTXs+7NLigQ86aJ+N2l2trYJKCUsgF3kkku0WbYPeZNK3Cwxtb05/BOoJ/y7SFs/SL0TmLtDcDZQhnAJdu4t595U1SaxJizKbY64dV5BpVTuFInjHfF58OWr4CC0LDLBCTSFucluvodZa5ny2X+IimsrnFrQBELaW6mEXS42T98UEv0z+SIu6vg//L38Y/nin+ZX1zXHtzgUrukkzod/WBpKJ84CyBgu5FlHw0OwKBDZAlpF36iJeVndYXxUy80YmE99/AQDS36SLYZ2TuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(2906002)(36860700001)(6916009)(316002)(508600001)(82310400005)(47076005)(2616005)(186003)(336012)(1076003)(426003)(26005)(16526019)(7696005)(6666004)(4326008)(8936002)(8676002)(86362001)(83380400001)(70586007)(70206006)(5660300002)(356005)(40460700003)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:45:34.9110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d405140-2f56-49b7-4f81-08da294747ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support psp v13_0_0 microcode init.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0bd22ebcc3d1..867ca5be27aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -82,6 +82,7 @@ static void psp_check_pmfw_centralized_cstate_management(struct psp_context *psp
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
+	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 2):
 		psp->pmfw_centralized_cstate_management = true;
 		break;
@@ -142,6 +143,10 @@ static int psp_early_init(void *handle)
 			psp->autoload_supported = false;
 		}
 		break;
+	case IP_VERSION(13, 0, 0):
+		psp_v13_0_set_psp_funcs(psp);
+		psp->autoload_supported = true;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index f951dbf21af6..024853eb1cd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -41,6 +41,7 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_asd.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -68,6 +69,9 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 8):
 		chip_name = "psp_13_0_8";
 		break;
+	case IP_VERSION(13, 0, 0):
+		chip_name = "psp_13_0_0";
+		break;
 	default:
 		BUG();
 	}
@@ -94,6 +98,11 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		break;
+	case IP_VERSION(13, 0, 0):
+		err = psp_init_sos_microcode(psp, chip_name);
+		if (err)
+			return err;
+		break;
 	default:
 		BUG();
 	}
-- 
2.35.1

