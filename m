Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679B3C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 05:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A569112D9F;
	Tue, 30 Jan 2024 05:20:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3632A112D9F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 05:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5Cd3gCN4FnLszOXMqSlV63dTdRUfPLzCgvC+P8bjyQfkD0XU1MPREp/hpgbfsn9s8kv8TWbglq3u+eJGxbTZbrEvqubMR1RayCgOriaImsqb2EXLOuqf63yd1btaZ3VYRoCzkckbAVUjFaA77DBlpEpvbfkp7IDIniTUv5K3mwDP226KwqQiX7XYxhonfACEo8V+Ooo4KL3NHWyV6vxAllJpsxbwEx8nwSmlJxuPjUogTrV+QHvo6JDgM0CERdlYFoYAVFl7qt//PcgLNJwpmEIm5Fjxc9MfFAbM5p9+8QLUo/D8BTv5e6uammF4DWavtN3B18NALwpA8T02yhnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIaBk5xaXK8ylGb8Awuw1KlRbzXI3WX67iZ13u1BwBo=;
 b=S3rx2eAXBIvZbZ5Gw9OXRk6HXZ2MO0fCi7+ngopQfRK0ISehuKfb5TuPy88FCddMRCMTRXklSug/Jy+eXxZ6QP0Eb60hxrhPTkTcwZvugA8r/B5Q8um0tqIXSRXxW87YgNC4a7CnbGUgOuYynWTR3RhkZayjH+wrd7jaV0CkbqB0xnnGjbPAFIp0uYHJODdZVrqRwUY+VL4ZNdPtvn34fYJOUCLb+3Zt/fPXS8tiHjLxaJ5wKRvijJ33kHnvmcx36rSptHKzDySOrlBf6sO7fqiiO8pKjk5Hd2KC1hJ2jNAXJVeJ8TIP6fys9nJJdPXpjAD+2k/XLbc0hDOFVs3qcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIaBk5xaXK8ylGb8Awuw1KlRbzXI3WX67iZ13u1BwBo=;
 b=MoiBbSV4+zjoLe+t32dmAZtscok5ggCpHEWu9WparzDET4aCifLy6e40rDcJa6SzbLbhbeto0y4npkqkgjLylJNpeJ1oSp+Y0GLrpOqqzX0mIbzWFq78TehBLG0qxObZTLTFbaGPvpyRr+1YKNHrmx1I6XwrnpAy7h+KsVS/+gM=
Received: from MW4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:303:16d::18)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 30 Jan
 2024 05:20:05 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::2e) by MW4PR02CA0030.outlook.office365.com
 (2603:10b6:303:16d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:20:05 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 23:19:48 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: drm/amdgpu: remove golden setting for gfx
 11.5.0
Date: Tue, 30 Jan 2024 13:19:30 +0800
Message-ID: <20240130051930.3418642-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 325b3e9a-69f9-4dd6-ad9e-08dc21531e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKfighsIaQ5aa1vgiJfVtg2esCga+EjGZNNsHTxwobz9HORD3haepsJaKASiNB2j6MkNQ7HinqXH1cPjDGCCcxsmPlJwOuEB0BUhWXNIHhxzSx+Y3QU/j4fXeKcJAZQwgBVJ6kgCeK2R/VWYfIxe/fgL8xoGp1TmPma1gve80stFxjzy0UEdoVCjkrL6N4siZJuDOljuzOpm0UyMIr6QVZu2gUquzFgPFk6NG3Q1bTsyLxR3+4ZA3+W7q8oPj/H20nErOXQwi7hUC/53c1KUsqKBroG1Y1Wbuh2MS7TCcRzkUuEPB80TtN71C4laCxIUVS4M4WMMVg340GYtttE4jWQqqQ0e4KmGXPO5tIl5LThBhzgAbrjT6Ai7wNVagcpd7umasGO98tIMgQVTBEnVpA1jNfrEPZWikY5u66itta70lmikDyne809vJaC3Gy3+JYzUKzlHo+jBlQ/j0nX3ryhQ12tco0tMd1VpXBO4jpCQKKkFEiFjKDLaOIKWy9pCfyXsXk/PLddJRKr2g3Z1VdMG99Ci7FM7G2tZkbamGNalRgv/Ms7t4yyT4b3pVKssTxWffPV5uKDMt8ff/kVCZi3fuD6qzQIkzEsVYPc/WZT5dEdnTLcrhlWuEja2vuYQE/nHc1KtyL1ddeL22nCAAoIXERCf2LUwjcaTz4/NmhnQ5P5msCaqr5t4YohVafMHLMbm81QFsoRoTMbEbdud8nTIPqEhcyuXxd7rL3/3CmRVfo42qgpcBp9T4Fu+sxtFShmdTHcCfj5x1DjtBv3Iug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(1076003)(2616005)(426003)(336012)(26005)(36860700001)(16526019)(82740400003)(7696005)(81166007)(4326008)(5660300002)(8936002)(6916009)(8676002)(478600001)(6666004)(2906002)(70586007)(54906003)(41300700001)(316002)(70206006)(356005)(86362001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:20:05.0255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325b3e9a-69f9-4dd6-ad9e-08dc21531e29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Lang.Yu@amd.com,
 christian.koenig@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to set GC golden settings in driver from gfx 11.5.0 onwards.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c1e000010760..2fb1342d5bd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -107,23 +107,6 @@ static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff, 0x0000000a)
 };
 
-static const struct soc15_reg_golden golden_settings_gc_11_5_0[] = {
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_DEBUG5, 0xffffffff, 0x00000800),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x0c1807ff, 0x00000242),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xfffffff3),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb, 0x00f40188),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff, 0x80009007),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff, 0x00880007),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff, 0x00010000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL2, 0x007f0000, 0x00000000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xffcfffff, 0x0000200a),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, regUTCL1_CTRL_2, 0xffffffff, 0x0000048f)
-};
-
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -304,11 +287,6 @@ static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_11_0_1,
 						(const u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
 		break;
-	case IP_VERSION(11, 5, 0):
-		soc15_program_register_sequence(adev,
-						golden_settings_gc_11_5_0,
-						(const u32)ARRAY_SIZE(golden_settings_gc_11_5_0));
-		break;
 	default:
 		break;
 	}
-- 
2.37.3

