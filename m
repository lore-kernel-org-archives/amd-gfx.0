Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21931C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83AF410E81A;
	Thu,  5 May 2022 20:08:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF1F10E44E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzi3MlO/07+OmgGjJF+I6KON+snqFv6ThBz610iKY1Yb/Qe8yx18vHtHHEqSLQuWdWQcBeKx0zosPPH6HAwc/m0MUPN7M2Y5rO+wszQZ/mBpEChi/ZTJRjkv8RRlB6mo30Wa9ytvb7qhe1G+cM0cfAOSbKCD5bA7VWIiNh4fJi2yb2Lkhwzt6jAglP2sLTix81s+ott4Hi2m3GgzmWrMR6vkpSmzDA6lS8wQHpTCgEikXcsO5JOhc+8hI6sTdh0mGG7dNz1a9cBBHWeNNL5ZoH19Bvnvg9XCAlsvY3px1CquVj29tqL0i7cRbGxhK7JockkMGHt9UOPprlIN1XC6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD4HS/jWHO1idGbHxwzBT7v+LV09N3gIImcQ0EoLBng=;
 b=HtPYq1hEn8o0ZfwDolJfm0U2f5w77k73dMLG623XyKZIzUyOFRScfgq7KgkmLhs28zcSDMby2JK57fhSAGmRDs4uASQIr0H1M7QHfvL83FJmGzrki/LPXIAgxB1drgcCULz0pmuEyoKW4ZpYWuLKQs/MDUv9GbC80Obc3PQ/TlTnPdk7+4F/sd5GhTl6J4uHTl8BVi/nd7rrDWZEHlRWvr2VPhAxcrBEXK7cicF4+KFEl0z8lWJa/YJRVUwvYDTX33BZHsS7cVlvdAEvV0KdROkp9bvmdLjTvP/Stozfb3P3TE947+cGTSQuAfbT/wLXG0jOtdCmXbjoh7CiOu2tPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD4HS/jWHO1idGbHxwzBT7v+LV09N3gIImcQ0EoLBng=;
 b=IWp1OMMI8xT1aZvSS8iY7yyHnN7bscYA3a/FS2uTxhV8If/NNlNk26C4rT1xoZl02DmdP0ypfRsMSC4Z+Fl7NApVwp33yHaSyLPXYY4OeYptWvv0Ysicdx0aXfgdmDukAdiJxpWVq23joZ/fiXqMEMrpmamxxbe28SnWQenN4EQ=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.25; Thu, 5 May 2022 20:08:38 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::33) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 5 May 2022 20:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Implement get_vmid_pasid_mapping for gfx11
Date: Thu, 5 May 2022 16:07:49 -0400
Message-ID: <20220505200750.1293725-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a0cdbf-be2c-409f-c605-08da2ed30ae0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5915:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB591548C080B4E309256D6311F7C29@DM4PR12MB5915.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajugDcnm4gdcyWcqVtyeggOCq0C/8t5CffCkUjOcfCPZ+bAsQDopb2Ykpi/z1eYpioUkryLR7LLZAKd8dP7B9IQAU13zhZI+mnN2vQsu2sBFC8yWmyCefBsG1YYlerQQg/ZZPSK8Ax6hR73Yng5krcSxdDdV+QdSAY6l9hE1smA5qWnzOyIfEAgcqSnbpZbijSMUS2+g3xlg62m4+GXQoHzemMbyWRSQvpkdL7p2njWhG9nD2FMqGhgnpm16w4NMa5qoXda2KJH+zm5lIWN4tZCIUhCWTcWvWU7glE6kh/h5KYoiDxZyRkzWMiQnSRha7t2GfehGVITG0z9JEhLbAzRB/ZX2qG034zAR9mrX+ulFCvAi2AlYdaaqdBqp4akNYorfZ020FvGgJXEj0lPOMQdjyMqEEb1+ey0lk++pIKOaEWSI+qQ46QBnAbr7nMCwlZLsS5BdRA6FqtrtDVkEiRFYX1zFar26zfDIzFlAB8+kEsKImwtwrRtP9Eu/g9ZPbJpCZM/LV+t1VWlqlouTTXrKd5J7us21p+1rWBWGkAVRH+jxrHPqdgBATvLxshJSe9SvpvS3R9S41kVwymtGoGeGQLldx7cCvW6VzwrpFSCXGgGi9Giwj51RcLk7zie9jpdGhOSnGw2LdLqfTqTNF9czsIKYYYpVU/nqtq02iigE3N29719iEzqtRXglPjyIjKbNvK+S8AJ9H5jD3iPQew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(83380400001)(8676002)(70206006)(82310400005)(70586007)(36860700001)(86362001)(2616005)(2906002)(8936002)(5660300002)(36756003)(508600001)(356005)(81166007)(426003)(1076003)(16526019)(40460700003)(47076005)(186003)(6666004)(26005)(336012)(7696005)(316002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:38.0732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a0cdbf-be2c-409f-c605-08da2ed30ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Graham Sider <Graham.Sider@amd.com>

Implement gmc_v11_0_get_vmid_pasid_mapping_info to fix
gmc_v11_0_flush_gpu_tlb_pasid logic. Change from gfx10 to use
IH_VMID_*_LUT registers for VMID -> PASID mapping.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 8d733eeac556..477f67d9b07c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -155,21 +155,13 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 		(!amdgpu_sriov_vf(adev)));
 }
 
-static bool gmc_v11_0_get_atc_vmid_pasid_mapping_info(
+static bool gmc_v11_0_get_vmid_pasid_mapping_info(
 					struct amdgpu_device *adev,
 					uint8_t vmid, uint16_t *p_pasid)
 {
-#if 0 // TODO:
-	uint32_t value;
+	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
 
-	value = RREG32(SOC15_REG_OFFSET(ATHUB, 0, mmATC_VMID0_PASID_MAPPING)
-		     + vmid);
-	*p_pasid = value & ATC_VMID0_PASID_MAPPING__PASID_MASK;
-
-	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
-#else
-	return 0;
-#endif
+	return !!(*p_pasid);
 }
 
 /*
@@ -340,7 +332,7 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 	for (vmid = 1; vmid < 16; vmid++) {
 
-		ret = gmc_v11_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
+		ret = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
 				&queried_pasid);
 		if (ret	&& queried_pasid == pasid) {
 			if (all_hub) {
-- 
2.35.1

