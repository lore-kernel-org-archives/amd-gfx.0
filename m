Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A917BF36BAA
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 06:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547AF10E117;
	Fri, 10 Apr 2026 06:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SGDFy3P7";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F6710E117
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 06:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXDk1p7WsOPaKchRkOycozbWJnAiDe32m4y7Zsp2Svo8XFXe9T4Dxc2vXxaYz5Bc1EXC9p2FA2+8QuQpmCTSE1G502QeMvI6HHDvViSMgfPAMmf97r0ZeWHvuxz2PpnWvNNUTaZmCDpOhXVRetvELP7+mkutcRQNMxD54A/t9SA3Eo9AISdTaltue4N/PN5zaIVdc5z6oQQBKaQFtwlAq+SV5H2k9glfbTQNwV8g1LE2kBIro4PloTlz1pJR6Fj6lraavuPD8knIEsbYnCC+cnK9f4+cOCsHh33VoHifDPRFH61YirPpHmeaiRjI4bBg75FTTXZ6P5qLvTBA4Jw6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Etu75GcvLkIHUhlwE9uGTKfUpXZ/Vw3cEi7Al/6UIFY=;
 b=a2B0sgzQjI411wrpotru0VBTVgG8bIt13QnXCDYVT2M5u6Z4xSada8JgGZdMLBFybmFY/hf/nBKVEueWOimfvMmjBCZadDAE6+sV9ZsMIClD3ZaN172ynIlhaOeLjqVPMa1G0UBEEC5o5zLrN8Op81jwkSxk+1ikJz9VTxJ+xlMgJQmgGZyNt/ZKjWNJrHerfVzSJhTxa7F6i1sO1Ufya7iug9/oTXWzuxA9diMlrdx7CvISIBSdmexSglLcb+YLG1+YlG/XHFL3jbWAxea0IoZrWGe2xqmoCWSFsdFG3vL9KN/6+D6Gqlrii63H7s9COWxYItOR0PqW1Rxuqkl7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etu75GcvLkIHUhlwE9uGTKfUpXZ/Vw3cEi7Al/6UIFY=;
 b=SGDFy3P71SpfzEd6Hg4d0G4r90C3jYVs1TLTmXjbesFaQ/3OjUQG9Cu0vPFJ6OpJXVoVxzo3f/9O+71vXnHvjI4K5T2oDoTGGrBRsN5NGFmePDW8UeIyERNjbl1FIU8iUfUGTSz4sZXnQqNthMpJ/N/r+dVhN5bm7zanhXk5TwY=
Received: from BL0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:207:3c::46)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 06:00:11 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::85) by BL0PR02CA0033.outlook.office365.com
 (2603:10b6:207:3c::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Fri,
 10 Apr 2026 06:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Fri, 10 Apr 2026 06:00:11 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 01:00:07 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH] drm/amdgpu: Use NBIF offset for register
 RCC_STRAP0_RCC_DEV0_EPF0_STRAP0 .
Date: Fri, 10 Apr 2026 11:29:45 +0530
Message-ID: <20260410055945.3917125-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: 769ccd5c-66be-4d85-638a-08de96c66d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9tIxk88GuEY3NuAeBoDN9sv5DthFKh7ltf4BaCoTvOp+S6Xvr1VbOBsqluqIsQNKTiZcBBavnheA6Rrun0nzFKlucSkL1e7QysrnCokzQEcJYzaQVKnqOleSwFHz+ul1Lx7OYMqWRySyGWZnbBsgPIOfX6lVkatVxtQJxjKcA29HKxLWqwrWEFMlTU8/B+nbsIYfUE17UpPd5b+kV3+vUOt6qv/TgzK2gRK8glDDoc998i4URvOuWmHRZw4g2GRND5+q6zAgr1MERAJCek0cOi9q7zfiXqDTk+btfJHfnstNZAOc0GYmC5UXfsDXd+9o//Kw+eT7GtAFY3QSE8VC1SmfLLTrbpvHWMMfiDFX5M1PFEZyVayrGURkKzp1sLKMA1vNI7me/B9b3XhJhF1+OgCnh6S+sQegNOFAYrrgVMZu3zl+Ym9rdeg4yaUt0R83U2eqTH6808WZcMtcemzuyaXE2nxRnEhjckp0xS/e0SAOwJYFiDOpSfzyPi1SbmEY6lLeGNJc1/gkS5GocP8eS4l1IIo8zcHpaTeYLW0v1J75YJYeDJDEPi25fBwuXEF4pJmdMhsRMA31MnckuHPcpzibeLrJL7/YVVozMEOkIXe4evUWyyRVlVhGBYZ+U7kzWca+QvkFYVTfeFhgk2nxQKusYe6h1b/S/vsGFQbIgieBFDDS3jkNwYylCv3O5r0f5wQwQHIH0/lWYWm6IxiJzmtjXdPxL8iH13g2a0dqV9pQ4W5Cf0mnIMfvbOxhGTst48SSUk914LVrApxOGnAF0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GDDVzaZyz0g0/Za+OLCnfj/CmPUgNd4mEnQVDpYiiQOw9tdBFzTCIGKxBxo7BRPeugKtOXQBKkeUcLdG+Jzvorqv3cYCYw6oLMJcsv/dtq19U9YaYK31+YI2Uxba7hyDKapCwz3PZNbyWNMWeb0/96A/n5dLLy01WO0IeIYrpXOz5VVb/JDCoihAErekBMiCQF62sk28Cq3rPpDXa4hZSUZCd4SfwIrYnXWFAlk/L+O4o/SSmQGvId9Mr7/KcRmxltOqAiqLoswjr/kES2pwfNimXf1+eweDGeqVgCkiLfigi2ETCspuAq3odG0IRhdqtzLtJg4jCyv4UUGLUCG3eVUMyhG1AixkVflQ4l/44nyBeWfpld5BBabvdVJyy9iHvegaistp88o84srN8pAFPZStBqrbM/GUwau2pJoPh6uB8kQMw2UJUnq2HMpqRfic
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 06:00:11.1254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 769ccd5c-66be-4d85-638a-08de96c66d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
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

Define and use regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10,
to get correct rev_id in nbif_v6_3_1_get_rev_id().

Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index db14a1a326d2..fbf51b13eaa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -54,6 +54,8 @@
 #define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10_BASE_IDX                                                  3
 #define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10                                                          0x4f0af6
 #define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10_BASE_IDX                                                 3
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                         0x0021
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                                2
 
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
@@ -65,7 +67,12 @@ static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
+
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10);
+	else
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 
 	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
-- 
2.53.0

