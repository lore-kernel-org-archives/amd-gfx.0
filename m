Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D571C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 22:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6C710E295;
	Fri, 24 Mar 2023 22:00:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80FA10EC90
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 22:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLCIErHkdidbGonH6JYmtGw8s9JZHBMDYiMKUucdlIto+xMbd0ptSngVP377bsS457J/IByteaw1I2yZrHrGOYcdxueV0rO9cTtQJ4VcjAs/gYaJ2Ml8NBDELzNqTAIyXUepBsGKxNqxikpkkpMMZJrwrvG3msE5nXBV0QL5wYSKVth7i6DiKgigy24FjQdG/DqweAKU4Al48tJB5adsXdic74VVzOO9i0gLFoZf9+7EOU7xL1i44fJfVwfXZwv0SEqXSea8lABfEsWkXV/TVtONOvtHG0f9A2Soj3FGZjyRs/eO3LkdF5taS0JMOSbjixFSkCTs0MFo7V7euT7a4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6sCOxhPGvyzYqlyp+f+0CI2vBgmvHkeXK3aSB+M16o=;
 b=a82Y9U1woj+vvmGb/jOLFmUMeZsrsg4ki/Yc4hDf20YMbR9mVDYJGY+LeCNF3Y70KpmLW/JFCAgkyJP6/XYs2UnBWc48KhyV1G1L/ICk+THHd6muIsYm5w49A1Mr261DJRGxQD1DQ7MAN0aNKGYmm8D4SpxDAxFRSTDxe+lGg2RLRYHHi0nngwP/+TW8MKxSHxX8nkzlq3+10LT8Zyw158JXn5lmzgu7/TFvfcWwOzO6mj8KXk+b2i9ZudQpXEqROSNoXbR+rnR6IBMn0nMSL9oVoGYQ+MZqqSoFAR6zy4x8AcyA/1tv5NXJ2GpRJV5YpxyL8RXsmx2mupT07FTJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6sCOxhPGvyzYqlyp+f+0CI2vBgmvHkeXK3aSB+M16o=;
 b=KPaKIg4J12z1fuFTsftYcYTG+rZSj5i6krVfV6kuvGSSHQdKMR+sF7HAxRHsklsGwoek5P3mJ7Dh42dudBt6lPQ1HQmGWMig29+jihNuFzzOpJ5Q6Y0pF+BhzuEYzmcML7MSZYufMZLgkt3rAOh0ZeJKbv8qLwPl7QFviTmdsWc=
Received: from MW4PR04CA0329.namprd04.prod.outlook.com (2603:10b6:303:82::34)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 22:00:07 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::51) by MW4PR04CA0329.outlook.office365.com
 (2603:10b6:303:82::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39 via Frontend
 Transport; Fri, 24 Mar 2023 22:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 22:00:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 17:00:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amdgpu: add gmc ip block support for GC 9.4.3
Date: Fri, 24 Mar 2023 17:59:45 -0400
Message-ID: <20230324215949.2560463-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324215949.2560463-1-alexander.deucher@amd.com>
References: <20230324215949.2560463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ab25c6-229f-4593-c0d9-08db2cb32163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHcWMYFqkEVmzDFF7ZocpKV8F0faadhDtsk9Mdszi+hmkYl8MxGfckUdQtrprfxC67CW3SVEubaWrHKpbLIlwMO94VHyTR3qeD9P6f2s9byEaxMZ1L69Y36TStOqC28IUu9zQkNJnjz1lgDqbPLck+vAb8/piK7QkNaOfOzSZ11TyHmxr5TXOLuSKdw630y0b5fwNTCpsFccsE5zjPdY3v3YyzOdGvEn1JwnjDWca1iUIryoXSzT9AO6ssdm7VmlVkGqybgS5OyNd/0RFXIr7XlawkDwOgmh4+SPAJ7ix354ZfSj7mL7NMilGIlSWZRItEM/K1J11wQzsPsXl6vy7K+Ardh1hkaAPdwjKMaUab2Ie45inNMEye1OwqHjE8fUo72sT+U3h2Qm3XvjBr4SL+wMJGo5y011AjF/zWUVuiEaTtsEQ7vMktNj85UyGqWNV5lzsBCZwri+aP3emefGuSAInqe7g6M4MP2/PsJ9k5lMVK3EmfO6VL3p2MBAn4xilz6MhXIuOA9IWjLDRMBss/0mnmL6AGG9QGSZkQ0kDnXlVBI5eEYpE0dKaTSh1aUd/rHUHMUsquvsbpPW6kPIMbLb7+6t+mnJffqNiFpk2P6ZAUP3hlefFhryj9ssRG6Bz/zW/+wAprZFZhviKnSzvJf1yqAGNZpRJyIIJ/EZZuD91oTjc5yGHsget9VrXOGQC+m1+JBgxeB+lGtKH571qK8w0eNRgSheGa7iXSattJ8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(16526019)(36756003)(8676002)(83380400001)(2616005)(4326008)(426003)(6666004)(1076003)(26005)(336012)(81166007)(7696005)(186003)(478600001)(40460700003)(82310400005)(86362001)(70206006)(54906003)(2906002)(356005)(40480700001)(316002)(70586007)(6916009)(41300700001)(5660300002)(8936002)(82740400003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:00:07.2448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ab25c6-229f-4593-c0d9-08db2cb32163
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize various gmc sw/hw settings/configurations
for GC 9.4.3.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2a8dc9b52c2d..681233ed2843 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -657,6 +657,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 		case IP_VERSION(2, 4, 0):
 			mmhub_cid = mmhub_client_ids_renoir[cid][rw];
 			break;
+		case IP_VERSION(1, 8, 0):
 		case IP_VERSION(9, 4, 2):
 			mmhub_cid = mmhub_client_ids_aldebaran[cid][rw];
 			break;
@@ -735,7 +736,8 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
 static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 				       uint32_t vmhub)
 {
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ||
+	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
 		return false;
 
 	return ((vmhub == AMDGPU_MMHUB_0 ||
@@ -1144,6 +1146,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(9, 4, 3):
 		if (is_vram) {
 			if (bo_adev == adev) {
 				if (uncached)
@@ -1155,8 +1158,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 				/* FIXME: is this still needed? Or does
 				 * amdgpu_ttm_tt_pde_flags already handle this?
 				 */
-				if (adev->ip_versions[GC_HWIP][0] ==
-					IP_VERSION(9, 4, 2) &&
+				if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ||
+				     adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) &&
 				    adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
@@ -1544,6 +1547,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		case IP_VERSION(9, 4, 0):
 		case IP_VERSION(9, 4, 1):
 		case IP_VERSION(9, 4, 2):
+		case IP_VERSION(9, 4, 3):
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -1673,6 +1677,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(9, 4, 2):
+	case IP_VERSION(9, 4, 3):
 		adev->num_vmhubs = 2;
 
 
@@ -1769,7 +1774,8 @@ static int gmc_v9_0_sw_init(void *handle)
 	 */
 	adev->vm_manager.first_kfd_vmid =
 		(adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
-		 adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2)) ? 3 : 8;
+		 adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ||
+		 adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) ? 3 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.39.2

