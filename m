Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C7CC88CB8
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 11:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B20810E370;
	Tue, 13 Jun 2023 11:03:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964E010E36D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 11:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhmjEEpJcRRPtyY/so399AIluV02RbxZN/QwPfsGAkJw6fhwJ3o5Ia9PPurSf5/hLevMD5aUPkawEPdfEmrytrA3y3pGdJ8lY+vQyUanDXnnRo33rCa9lGcYLdm7mv7dLICytEzKCX3b+BrIug6hO+aTycnjaaK+MA7OodFi8sIaXUHXcFuxtwtMtHhmZHmnn4aBMjHLHJja5tvUgVVsvfJEiTkXZ3MB12ivKC2HotBBais0lVz+RYJj4XoxtKT7NbBizVBKOgenY+FKCWg7aSbUZ/0HFJG2bTCXzulwv06XgzDtmazFN41ziFTff1LW+4DDRKX3dZo7QxNrLO7EBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFv34uoZl0Vy31+czX2GV4bP8Z2Y6OgQoiiYnITGvqg=;
 b=bEufkfLub+fljK6jvv125KBis4v/wtwgw0TUM61ZCZFobsSPII24asHJ4a65vzr9HqcUAU4O5azXAxVV0ev1HhtT4jp6+f+VaJboGabWm7aGPgKH1/cXG9bkz939DzSI9JJHhA0dkoR646mMXo6S+aSKcguVTjMVN/2S9zG88BHnt/ZC1SaLC5dksH8QEaIKNHhHwcV8Qm58DHJYDd5Xf5acGx/D0d1F0IcTTVn0ody0JpcyQaO/l36MAnkUHks3ZTjZA3jKXDn3iCmrTc7NIApXi0TDipmguCfr5ODQFS/ql6Z/WVuWsyivLAELijuTtqeZnS8ZnrZiTOEZ9EHMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFv34uoZl0Vy31+czX2GV4bP8Z2Y6OgQoiiYnITGvqg=;
 b=5ZlobfH18ph4PfKLAV9kiUTEjbUzqpSp//Z40VYlGcNop89igUP9FBmFejSC4PuRN/kgQ6UWLII9D8yRBuXjShB37j8J7j9KMgrGgiy2cpdWTLmFXNRy3eWpULa798kngO7k9dvF4cok6jCTVU0ET25E1CahPz/FBD8wA2s9bgs=
Received: from BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 11:03:17 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1e0:cafe::31) by BY5PR03CA0006.outlook.office365.com
 (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 11:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 11:03:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 06:03:14 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdgpu: Remove unused NBIO interface
Date: Tue, 13 Jun 2023 16:32:56 +0530
Message-ID: <20230613110256.1562271-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613110256.1562271-1-lijo.lazar@amd.com>
References: <20230613110256.1562271-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 22553cd6-67bb-4096-077a-08db6bfdca4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjHxqUOsYvpt1KjzzIwkmWaF9s8RxXpIbw02CC1NRoa4G7T9An9jRX/wbO6sXLPUH39LgJAwwJs68OfRHzH9YLSF2hRZ634nO3uXkNEfaD3m410VTtaYyOhb8XJfm4JBi41WOWONXckyv9vlwLldZgmLBY8b5E4J6IvK67jkLz+ymtsIdQi0oabuUTRuHYBiBP4ZjWkqtfmWjIwGYaoTkzTx8r23obR1w6OMxrcUka/1eIaGgHx7F92g052vqmGDAzo2Od+vFdMhLVkNJTpCXPiHAOl93Dop2vCJW4unejnn8TtoCFXMSl5o9u7qmF/xbLOC0ywKRS9+e+bme2VjcR9txst7Yw+zLl4gzja39KNF0VOOwxZmz3SeHIrzRCFtiVMrvV2O/WdSNxLOAtb+UCao77MSWRaDzMWKLx01F0xL7xxkHU+HEwicCTaikZanTT/hHRqsnPl5i86EXcR+4Pvmk1y4IgYbs6K8dA5HX9vyDxJ6hTibpJerZlrNbHKaSaM6ox+ntyDtmXScyIf6w4hSt09kCr+DO7Uxg9c1ga7ORz3ScOZFmmo0LqPmRjlIKyjKePsd0+THAIHW0TlwOUm2EXPJzhWkt7IkN5yEsyxkGrVSV7xg97/eZ0tb9z5AnYknyoQkzr0N0ogL3mzqjkBiENkmhaYrGr8HjV6UGOVtV291KSMuLaf8HusBnbgKoQln6+vRy/eEHHi09Xrm00EBbdZJy5UZAmciuks5ItwE9VqyWtedyijo8NyagsPDE/R9SbxF9usGFE2R1HXNcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(70586007)(70206006)(6916009)(8936002)(8676002)(5660300002)(36756003)(478600001)(4326008)(54906003)(6666004)(7696005)(40460700003)(316002)(41300700001)(81166007)(356005)(82740400003)(40480700001)(426003)(83380400001)(336012)(1076003)(26005)(186003)(16526019)(36860700001)(47076005)(86362001)(82310400005)(44832011)(2616005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:03:16.6725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22553cd6-67bb-4096-077a-08db6bfdca4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set compute partition mode interface in NBIO is no longer used. Remove
the only implementation from NBIO v7.9

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 095aecfb201e..8ab8ae01f87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -99,8 +99,6 @@ struct amdgpu_nbio_funcs {
 	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
-	void (*set_compute_partition_mode)(struct amdgpu_device *adev,
-					   enum amdgpu_gfx_partition mode);
 };
 
 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index b033935d6749..cd1a02d30420 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -393,19 +393,6 @@ static int nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
 	return px;
 }
 
-static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
-					enum amdgpu_gfx_partition mode)
-{
-	u32 tmp;
-
-	/* SPX=0, DPX=1, TPX=2, QPX=3, CPX=4 */
-	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS);
-	tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
-			    PARTITION_MODE, mode);
-
-	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
-}
-
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
 					       u32 *supp_modes)
 {
@@ -461,7 +448,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.ih_control = nbio_v7_9_ih_control,
 	.remap_hdp_registers = nbio_v7_9_remap_hdp_registers,
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
-	.set_compute_partition_mode = nbio_v7_9_set_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 	.init_registers = nbio_v7_9_init_registers,
 };
-- 
2.25.1

