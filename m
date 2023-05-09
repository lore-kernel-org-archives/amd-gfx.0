Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59045C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF9010E3D8;
	Tue,  9 May 2023 22:04:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E7010E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRpQcVsjBVTCO1ugSgqU3cN2/GiYxAyE8Sbvw3kYHpTf0Gy8dITNWKEsXVEhr29vVYaaZPaqSNLkAjJub15b7092hgbZz5kNPsJgJtd9ROuijCNcdia6LgrheuKa4b++H5p9KZ2KTq5o6UMmKHhraNhnLFzt871gnFoBCZZdqpHfXF9zTAy11e6esLMpRF3btMnMYm4VG74gE1+BGMW10nrIymAFecx2BfhJ8VYfnilyjz+sVZVJvd4GOrUowidRALBJk3pdt9mRHWm0DHG3JwBSmhuZLHtOTsNLuc+BBmaRvW/RdUNJefWArPBDcFkxgC9Qvu3lA4nKIogjp80mMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2+0Kx/Y7aT6uI2Q73X1JDzAjBRMMenxbbIwth3uJJs=;
 b=Jn5pC/Mx99/bMVl4PBXi1i3xwku9GrX8yallTh4faiuqR/phTt4hti5SfW16xocDB19V7RYwgnnmEfRSip7xsnz1zvFS0MpFy+Al83lit+LmW55Gs7uRRrvntLqbJfStOG3ZPY2d+Czq8JKE1yeGI4igAXNhgMaXwYViNLjU3+f9NJY0UMcBVQl5wPlEVYpV6YmVz4JpMPlTSDhR9IwoyuNjmyi1SEt1Fb+SMt8L4ucazDh1HWLZSd8yjmy2Yg7lGdFfAhJDLpeoRNuLkLZIhf3FiIMdnvN0mSo+7sUIq9JnCz6qTMOzhOKDZ4UGtMzQ/lhUy71F6i7iHklQJYUxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2+0Kx/Y7aT6uI2Q73X1JDzAjBRMMenxbbIwth3uJJs=;
 b=EiGbAIcXDZCaVLC8pqIWJyxUEAMzlOXOJDBiGuYm3pm2eqeufTKalISyL5vim/rC6eIdFdi2JLMcUWUyyFGW3haSm4VFGYKYRv4PMKnzYXvbRqm2Z5TqEtGVQC1HWcyWDGfYzWRp2ydgHRCACp9ReTeb8TymElDczNrq6RCyL7A=
Received: from BN9PR03CA0135.namprd03.prod.outlook.com (2603:10b6:408:fe::20)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:04:40 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::d6) by BN9PR03CA0135.outlook.office365.com
 (2603:10b6:408:fe::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:04:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:04:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Create VRAM BOs on GTT for GFXIP9.4.3
Date: Tue, 9 May 2023 18:01:44 -0400
Message-ID: <20230509220144.474723-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220144.474723-1-alexander.deucher@amd.com>
References: <20230509220144.474723-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 964eba05-d0ca-456f-8e7a-08db50d962df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AHLn0tP0c1cZOEwUMT7ntQCoIxztjmu3xaClhtSZmKee2FevnYSDV46aagKfL6G9542AfvDwZ8Cd3C8biM9vIpuls3dL8mXBqsitrZER3vCGYCFRAzkM/0yW9qMRdB0bCpZf2pUF+75CUzcEfMX4RXpnxosTxKT4eTp5w5KF5Jspb2GtD9Rd9VpCXBtNMcKz9Ww1vGozC+hOHMyWm2wmxwWFVZ18C48wCs+G27rpWgr9cnMBNvc1FQYnugJH1J45El1pb4Xyn4bqj2Cund+fjfNbPh6pNQ+fEMnPqEAFkiI9UvvN4N1SbxWSEFQGyGQZo0KvA4N0SenThYxadDR+bCElpibMTtH4gqZ6pD9NxlFG94O+99P6MqdSTsNhzpK95rq59PsbD4WEnpAyFBqVxB0OA2mHAzRkNGzYlfG0PYANS3njZ0Fgvlo/T5vyBotpqlrAQDBGSRk+TIac2BDs8c3OqQKq++3H2mTn1eNZRyLysa/MRdiwiz4a1cgbsC3ypDbUUu68hdnJuizGAmxlqeaReJz2BKkZ3N495C++PDO9NdkUZY4kyQVX3jtnnilNErFnUhNON+QjFrsWFts3HKaELKPTAUj5vvHz4K1QdpTHAdYoWqhsOMoFE9zbGHueAF2iodA8jn5nB+DlZLfdrZZ2pfLZdMXMRntmk1IuVHeU+zbZ99EiEywrbnlu78kUrYVrff2c53WqZ19mRwCtNRoJatrF4rtugZEuhQKFeE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(6916009)(2906002)(4326008)(8936002)(86362001)(82310400005)(336012)(426003)(8676002)(5660300002)(40460700003)(316002)(2616005)(70206006)(70586007)(40480700001)(41300700001)(54906003)(6666004)(478600001)(7696005)(186003)(16526019)(81166007)(356005)(82740400003)(26005)(1076003)(47076005)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:04:39.9531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964eba05-d0ca-456f-8e7a-08db50d962df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On GFXIP9.4.3 APP APU where there is no dedicated VRAM domain handle
VRAM BO allocation requests on CPU domain and validate them on GTT.

Support for handling multi-socket and multi-numa partitions within a
socket will be added by future patches, this enables 1P NPS1 asic
bringup configuration.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index bb7e9ab27a4c..0ebd39a41e74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1648,9 +1648,16 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	 */
 	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_VRAM;
-		alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
-		alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
+
+		if (adev->gmc.is_app_apu) {
+			domain = AMDGPU_GEM_DOMAIN_GTT;
+			alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
+			alloc_flags = 0;
+		} else {
+			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
+			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
+		}
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
@@ -1737,6 +1744,13 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	(*mem)->domain = domain;
 	(*mem)->mapped_to_gpu_memory = 0;
 	(*mem)->process_info = avm->process_info;
+
+	if (adev->gmc.is_app_apu &&
+	    ((*mem)->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)) {
+		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
+		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
+	}
+
 	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, user_addr);
 
 	if (user_addr) {
-- 
2.40.1

