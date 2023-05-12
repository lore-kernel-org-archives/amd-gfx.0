Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A856C7EE24
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 21:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6009C10E2DD;
	Fri, 12 May 2023 21:44:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C4D10E2DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 21:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSa1aexwmFaoumOINFbOP/SUDPmtOVxH1+YFpE3vN76DLalo2S4OJArQBQL5JYrB1D+uoXluQzoCqm+sv1qhpVVM12VvFMgXun3NZCsfK9tx0pBb3qb0bDKbAJqDzsENBLXm6htOV6FW/9g+yq5HybB3fpo9BHSoVVo5ZVrodHewq9plVezmmYCg4ux9LXVL0I7Ek/dLNMAJoRexlf+nvV/3wRHAMPYLslwIVZijuRCVyldBpTP7JOVqGAdKgcMx8mqD+7yC/bKdzWEX4MAuxFR7UOz5BsiNVc2T0BnrXPsXA0Im9qPYMupL6lmyfKxUrK5WpOJ3Oos2RFgKZf7Fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVAumZ1unZ+4ZDYv0rEQQAKualsUuqcAes5kl5tGuiU=;
 b=foZte2VTMvCNBAUnfhw5SRVTy6s5VztLBSctuZfmf7TCSNb1GysToLgstSdghuaS8DthLaf1FgopRVUOo3ER/V+rD4jhwAKQTuUuwYdAy9vcZ3k7ohceY38GFR4UrzMYZk+M6rLQZ/6A25D7YMnpatu40e6D5vZvWFmroQWDNOQsYA5pNxaMmdzWcTzsOIeCNCQZlxcaEFd4pxmUOaAoQx6GU17HHx+olZ6Bbc2EaKVLNdUX9Ppj+XemzG7JbMNmcbKWzmpg7+0DPthI6LLAkGjds2vMFvggowEgdkDsJPsChQn8aDFQutIzkjb3GNHctrNqMME72lqhi/FF/R8vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVAumZ1unZ+4ZDYv0rEQQAKualsUuqcAes5kl5tGuiU=;
 b=ldxdoccVtDGz1tpCfbDNla+T415Uo38dN2N/5iYn6Z7J9gz7Be5ANRBj8tH2OYonK+v8pZpcDF9lGB9SlyFkohji5slbvC3+xvQBpopI6cb6ckvXaGexxLDKJc8x+H3FRE0DXDzqYFLV5oi2S/yL40pyAr/VWe/61QdRroCnfFI=
Received: from MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 21:44:22 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f9) by MW4PR03CA0274.outlook.office365.com
 (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 21:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.26 via Frontend Transport; Fri, 12 May 2023 21:44:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 16:44:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amdgpu: initialize RAS for gfx_v9_4_3
Date: Fri, 12 May 2023 17:43:51 -0400
Message-ID: <20230512214351.1356254-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512214351.1356254-1-alexander.deucher@amd.com>
References: <20230512214351.1356254-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: e18b6711-fbc9-46e5-9402-08db53320c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqtNwH3S2MuNIsXcJ0IyFH8+Zg/dBRxXwBR2gY27j5USZCIxe9ETO6bdicZ7HYrsBYPhkMdO/1JmRia+g4J7Bc2b8DH5UwLG5NRP04h6XymlH+QoAlfwMvgjLPkdTjdmGvtaD1B/6cAUPO15i1TRWTy0hyiM3Pdh6ttPjKHaVWoQglde7zUDZ8pZJvzFBsuwdKxQ44b2KCpEMKIn5HBstjmtDC84IabJ/hm/0kRMvcLDHwgHDFCLdqLDO66gPccFKATOcalL+XEIm8/V87w0epS9vlsTaPqsmey/a9tBZXPIyUc3sM8OkWZKuKx2u2JiHhydKoZqolBNVKPtBZlltmxhP2ac0NhGv2i+7oj0yI7spB/UFgmcxIoe9RQcn2XjhaSNiOP0VANj1ik188UAH+kN6FWCgSjgyr59v0D3C9LPPeFtCxWVD09uADGhXiaoFYSBrrxyQ0hXcu+n//+zUYDAmu23VdiQUEnFyqkZdMGe7CqRUD9vLPH+mvX/fRebhkajkTecU6RdChJmvX0mHKkhSe0QWM9XnqaxMyo5OEolQZIQz4kXUrSSuo05V/OUgcLIktdTDN73lU54zqw4OY5PKRk8xc1nuQ/eOe6m1O66dqDxESlRuUlS1Lpn9cwRZvwJB3yoh7sOD01v56YWGo3da82mnGGyMHJk35Tbk+6t5jGwAMKxa9YLrkZX9OkR0WAd/GNBVeVeiypEtVVqP7vIDar3TFUFHt2nnWMtm+qDK1t+7QguuMQAnGQe10nxhCADD/MUDfrU4bk1LWSLDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(54906003)(478600001)(7696005)(316002)(8676002)(6666004)(41300700001)(8936002)(1076003)(26005)(4326008)(70206006)(6916009)(70586007)(2906002)(47076005)(336012)(426003)(40460700003)(86362001)(2616005)(16526019)(83380400001)(186003)(356005)(81166007)(36860700001)(82740400003)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:44:22.3276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18b6711-fbc9-46e5-9402-08db53320c6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Register GFX RAS functions and initialize GFX RAS.

v2: remove xcp operations.
v3: reuse the return value of gfx_ras_sw_init.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 5bd2f40a817e..e5cfb3adb3b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -47,6 +47,8 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
 
+struct amdgpu_gfx_ras gfx_v9_4_3_ras;
+
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
@@ -659,6 +661,7 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
 	u32 gb_addr_config;
 
 	adev->gfx.funcs = &gfx_v9_4_3_gfx_funcs;
+	adev->gfx.ras = &gfx_v9_4_3_ras;
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 3):
@@ -845,7 +848,7 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-	return 0;
+	return amdgpu_gfx_ras_sw_init(adev);
 }
 
 static int gfx_v9_4_3_sw_fini(void *handle)
@@ -4342,3 +4345,16 @@ struct amdgpu_xcp_ip_funcs gfx_v9_4_3_xcp_funcs = {
 	.suspend = &gfx_v9_4_3_xcp_suspend,
 	.resume = &gfx_v9_4_3_xcp_resume
 };
+
+struct amdgpu_ras_block_hw_ops  gfx_v9_4_3_ras_ops = {
+	.query_ras_error_count = &gfx_v9_4_3_query_ras_error_count,
+	.reset_ras_error_count = &gfx_v9_4_3_reset_ras_error_count,
+	.query_ras_error_status = &gfx_v9_4_3_query_ras_error_status,
+	.reset_ras_error_status = &gfx_v9_4_3_reset_ras_error_status,
+};
+
+struct amdgpu_gfx_ras gfx_v9_4_3_ras = {
+	.ras_block = {
+		.hw_ops = &gfx_v9_4_3_ras_ops,
+	},
+};
-- 
2.40.1

