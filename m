Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA398C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FE810EA99;
	Mon,  2 May 2022 19:08:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E574810F18C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxOO/j1/b09xodDdcKIVPK8KXYiFxAH7kC+uk0XKHU15o3DSyoK3iAB1qdpMOblQo3fNCeOcnGXhE4WsDR1OjNf4HOToMoTRYXFMhfjixVVMKfh8GeivzoPvSpqs7VfTD74PyePDECDbzwvI0JfOQ5sV81JmoNPXHnJCXSizJg8OWFNTfgePcTZuRwVyWw83MzoUegvwu3evflrB2ojnzLgFeajCJn0qKkOsJ8ow2047/OzeXmU7H7km04KMEParmMRMwefmWSPvCNC+YZeOKFHH5qxPk/IQikqCcFqtDNV2oK4ZmQdX8S5yi+0QeXlngM6+MtrG27bBeDxBmzHOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnfxB0C0wuWPUnW+jEYsyTunOdDxNngq/I2zm/NTzHw=;
 b=DGqRvP8iLiwgPkrr6x7KrIerrc+uLsxomwpsfSb5CEpJtp1hKO9pptPMT++zB8dQaXO8cMez+SPsvHRcym4fei1uVJA4zAmPnIryCRz6dFZgInbWRmMnDLzXIHzUh2fGoL1hC2LA4HD0ZvSJhXMBUXlphvkfzhH07TJBK8gSJwu0R1SAvoKOrZY/uDaMZrVyO4Z6AKtQDSa7DGiV87w8aDUUey/VOLsx4sP8VxCpHvrYkTz6MSLnFGKWfkfFsO0VQcZB9+G/URVWtPz+2clGzrKIuF+r1vnlByPizlGwP1r7alBvx22i7f5M22U7+WCZ/U2eO3GIAOZmPX7Rcy0A5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnfxB0C0wuWPUnW+jEYsyTunOdDxNngq/I2zm/NTzHw=;
 b=FT7fBN7G2+V06u7Pz2RlConHlS0B4UVUtSi46VAJuWkR74OGCw+NZRuZTKqJw/bspTzR26VfDfUyS8hzfKU8vGZ2VaaaQeYtWRjt2butwpPQwLYq1VT5/AbpsD4HYjneDpFEkURS5BaR38XXO9ZOF/kC8Jy1x2eo94smUehCALA=
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 2 May
 2022 19:08:22 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::93) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Mon, 2 May 2022 19:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amdgpu: enable VCN4 PG and CG for VCN4_0_0
Date: Mon, 2 May 2022 15:08:00 -0400
Message-ID: <20220502190804.784271-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190804.784271-1-alexander.deucher@amd.com>
References: <20220502190804.784271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c10b519a-92a1-42a1-f8d0-08da2c6f2081
X-MS-TrafficTypeDiagnostic: MN2PR12MB4343:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43432C1EEA5CCE0B931E227DF7C19@MN2PR12MB4343.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Si9wbgsl9Szt4v8jiKsgCvncg73fOn7ynI3OWGtQ+pX1Dmwe6Sz1T6mJ/DLoR3ApuahDca8Y4sPjCo1ZTpYI+nUX9ryVGQ8GMeKJZ1gu+wlboQ50yK49j4Z70GQxUUH2k2LNH6weIdO7VUdPJBUg6zWNE+iXq1vsgggG1A2p+zFo+KBZ6Fyg0tmgWuIBIsyhuwTVIksHKTTni6q/m9xTv3RlazXJ90x5odgGm6GO653CHEcYFKl0Bh42DUXO36+uWqnZzZJ1eiZOinxIeUoJjVT0qPB1MMXEnPsiyecM5ObOZI0HPBBxDrtxIpreppXOt1hKaEID70+jPVTPjq2obzhtw1kO4S20kAzrvpnuBmTmmtBIBpAW1MbDXZfoWTdEStk+MJGBK6L7xWbrYOcfPDLgVIn5mthtVAqXbrz4vIpBbvHYdxHLMUjIOCz3YYtRqhIMrAE8OC8rEkiZvV11FMrH4Kx/Gm5qVp2QedFeb8ZtYxRIe5ZWeuQs3oRImY2nRXycAT2QS0U2aUAOt0CNtFqD3nAogGZLEbcfKMKvk/oqS29TQvmrNdgZ+XWVKHYFW0YCC6e+aiSXnikR5V0l9Dl0Z8Gz81Ef3qsoDAIwnfEOVsEfjb24GBxdwHP0OegskUxVkjDOdMiaa9mnJnyACoEBMHv1xDECFG+6+zAeqj9szGZbqXzJL26EVyNFPiLudim+IPAcrPj+jpUDjBETw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(26005)(1076003)(40460700003)(186003)(336012)(7696005)(426003)(36860700001)(16526019)(2616005)(47076005)(83380400001)(2906002)(8936002)(4744005)(5660300002)(82310400005)(316002)(6916009)(54906003)(508600001)(4326008)(70206006)(70586007)(8676002)(356005)(36756003)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:22.2852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10b519a-92a1-42a1-f8d0-08da2c6f2081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonny.jiang@amd.com>

Most of the tiles can be power/clock gated.

Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d738635ecf1d..c95dcbb1d5a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -482,8 +482,10 @@ static int soc21_common_early_init(void *handle)
 	case IP_VERSION(11, 0, 0):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_REPEATER_FGCG;
-		adev->pg_flags = AMD_PG_SUPPORT_ATHUB |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_VCN_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_ATHUB |
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
 		break;
-- 
2.35.1

