Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA4CC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F80410E917;
	Tue, 28 Mar 2023 15:15:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6F210E90E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MudmTIAQANLt7WrmtXuE9AZB5Vk97ej9tIkDmlShj7ayxRmTEZW5EieoOVQagL07N/oQLlFSjSw7JWTpfxqfhGpXpo+WOhPiReRWiQ2qJrXXuLSlg70GhFF15HQB9f2cUZ4hIv2I6UK2t4Z5j9i6XsUX29SqJ45011InskhOTbV+ndLazKY/WmRUb2wXob6ivC1JF5yf/CQVzMe5daY04AS0eqKWQeskwzEpSXMCs+yvrK8tjQfmwjwHSrw/g6IwVHBzwr5vqm/qxL8QCfAMGERtvKTgr2hA6SFZg2XGUa7hSI8ispxTtI35kshJCMGh0GWYUUG8isAUlJgLx5kr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/mdAfkdMCe4bkt1aFkZrYkh2epBAhjXP05oFjKfe4U=;
 b=DIleGCf/LYmIx7ecCj5oSMbMvFkO7yw4WjukEBjc3s33rIhQshQcoQfW9SzWiVMFEiFemWVvn/GDEmwTVlvCBDyQuhIGtBGJi/nF8sMewFdp1GuPYrRGmWrojYkSY++t4pDfJQ3H+/j0fBcOrl50ixhmKG/XXGxP9EHO7S6mqUQ5h5VsgZf/doJkKE8J5Qoghp4/jCtKfbnRiVuzpB3KSjSs/XCKs9MVUMRmMZK+CJjicLRfonKV7QF+9Wl+4feNeCuzR800WcN2z6UPkq5LSYMoeFwlrlu66CyTcRal8Uo6i1Hvy5thdI5snOJK+UUcAtp0uQ/q/7DLyTvJp0IC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/mdAfkdMCe4bkt1aFkZrYkh2epBAhjXP05oFjKfe4U=;
 b=YUQMQJCjAg4c9Ns4/KUUCzP65iYfYv6tXPiURlohWUJhZVXuM2zX4RC/2X47dbaO3awpBl73P7Rd9+ar7eZdmYvmIpEa9MWz/gvisS1UFX64MLrOyr10tJpMuyglx1FnVeReqSWIAR1hIpFUJ2os5f75pq6iMe3MRWkac3fxf04=
Received: from BLAP220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::35)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:50 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::84) by BLAP220CA0030.outlook.office365.com
 (2603:10b6:208:32c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/32] drm/amdgpu: complement the IH node_id table for
 multiple AIDs
Date: Tue, 28 Mar 2023 11:13:39 -0400
Message-ID: <20230328151344.1934291-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: a65d38ab-debd-417d-f40f-08db2f9f2d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6+0ovatx4N476kQ0huNJulx+VKZbbeiiqmMa9H0OUqnGeJ1AZpTPHZg0R0kgnmN6XUk06KWn9fuJk2yMXyg6MlYYoKS6Kj0Fvnq6uX9OFhJyzx5n25OG5g9BDsN7caDwPHAbLdW4BB9fuFDvGqtt6D4K+7RkcnAgrGc8ug4O7pYeW4LjoM4gBimdWd7Y+JmtUAjG93I6LoZlpqk/qN+mPuDgCyMUBj8v7lSorO5dGlB8vR/dvSz6hsMVdShLorWYOWEdm8yS1AK3pP2MWNOMQxjeKT+ULuLC2PMrutWCs+WkSTIFD30W3ux01p+/iKDKjB1teiXDTYcwzw7oWcolNNp2oMaoUz0iI9dA6Kp9BzKP9/ysElyomhQaoCDptPD9MTo57bBZWaSHDs6itbNuJL9hDTOTyHa7+RxZL5q2N9zRo8L+CIOQsEI/suLyj1xWKBdsaBC93B5B/KRvw4WeWxw8V8wbPAKcRnhqtDnhLXrTq8Rn8RFIltJEMt47iATQcHQXy7ZD02eAUs4XnaPaIsbJ5JefZnYXMHCGOL1KRY63+eBmTA4+6nnSA4dwd9X/eb3m3z+P+oY4Ho9hu+ncdcSG4OIviKF4VM5L8I9wsZigeeWk9g0PQRFq2dtvkWEJc6y4uXsQUxIZroKFhFAnjcqRM66nRpEjzfmUoNM47BH2e9ydSep67Z8gmAkJj9/bHkCfrDCDhJvwa91C+/Cztw8xLoG1JyRltw+vN2h9NM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(5660300002)(6916009)(70206006)(70586007)(8936002)(316002)(4326008)(81166007)(7696005)(426003)(26005)(186003)(1076003)(41300700001)(16526019)(8676002)(478600001)(2616005)(47076005)(336012)(83380400001)(36860700001)(82740400003)(356005)(86362001)(40460700003)(36756003)(82310400005)(40480700001)(6666004)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:50.4062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65d38ab-debd-417d-f40f-08db2f9f2d02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

With different node_id, the SDMA interrupt from multiple AIDs can be
distinguished by sw driver.

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h  | 6 +++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 31c6332190e5..d8471d119618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -101,12 +101,16 @@ const char *soc15_ih_clientid_name[] = {
 };
 
 const int node_id_to_phys_map[NODEID_MAX] = {
+	[AID0_NODEID] = 0,
 	[XCD0_NODEID] = 0,
 	[XCD1_NODEID] = 1,
+	[AID1_NODEID] = 1,
 	[XCD2_NODEID] = 2,
 	[XCD3_NODEID] = 3,
+	[AID2_NODEID] = 2,
 	[XCD4_NODEID] = 4,
 	[XCD5_NODEID] = 5,
+	[AID3_NODEID] = 3,
 	[XCD6_NODEID] = 6,
 	[XCD7_NODEID] = 7,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index a3543f121747..05a649285e9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -101,13 +101,17 @@ struct amdgpu_irq {
 	uint32_t                        srbm_soft_reset;
 };
 
-enum interrupt_node_id_per_xcp {
+enum interrupt_node_id_per_aid {
+	AID0_NODEID = 0,
 	XCD0_NODEID = 1,
 	XCD1_NODEID = 2,
+	AID1_NODEID = 4,
 	XCD2_NODEID = 5,
 	XCD3_NODEID = 6,
+	AID2_NODEID = 8,
 	XCD4_NODEID = 9,
 	XCD5_NODEID = 10,
+	AID3_NODEID = 12,
 	XCD6_NODEID = 13,
 	XCD7_NODEID = 14,
 	NODEID_MAX,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 6935a24d1e89..d3c7f9a43ef1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1492,6 +1492,9 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance += node_id_to_phys_map[entry->node_id] *
+			adev->sdma.num_inst_per_aid;
+
 	switch (entry->ring_id) {
 	case 0:
 		amdgpu_fence_process(&adev->sdma.instance[instance].ring);
-- 
2.39.2

