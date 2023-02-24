Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198C1C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 04:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3BE10E564;
	Fri, 24 Feb 2023 04:25:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBC910E564
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 04:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJnfA5eBn0CtlO8BP8GYJcNyQMxtfL+HWmebJbAJ+H+5tHQAqhsPydZR/b6BZNQbyv/w2ZxKQKf/z6kz+cT8AhpnwaJMKaRV/ePZJu17ArA86YRDZGgJFCGg9iTB0xDm+8amFN+sM9I9Bce5C1RIv8VaDPqet8dT4QUP27ptKAb3fkXNc8a1cw+bqOTJKG6BGP/iXORbVPKAsy5UA1dZHwDyRwZpVjqC86CWZVNT0UNATckV+eUuv6f4+H5P8fScBu1TJlERkqzla9pDrRcTQBJRXM9muey21RBV+lgoypj5+VDvEHE1PqzlUmilevtq+ph7qB5eNAmMn40f37K/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQMTZW7gxsR/FDKA06j+i9XOj/VwQzCXZZSs7Bc+Wto=;
 b=XvMEtmpIvoA+i3kwBrNgWK66zntCxikuzjQBEf4/ixKNBOWryfm5RyYWwy7jTmrceO8fjBOOfxRS5GJ/FoY6BwbmGfUpQseCfgr6iYmLM6L9JsHmMIR0pKNbugRphJMtGWNLUYMsBMzj8ovdM5n18zGB2miHGPW6FZdD/Ng77X9JDJfARyeRcSf5hp/hjGHBYV/7Xov3q6FgKS8oobPsAVYjiPph40X7KwQJTh4OZkV4QtMPcL1OocKG3UxijO/NmR3gKGGCgpvoN0WOAU+SD/zlkxJa2P6ox2UczEMaEZNttTahKjLWMBOfABydmxFBMLtXuWWuEBaaM4P2G01Mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQMTZW7gxsR/FDKA06j+i9XOj/VwQzCXZZSs7Bc+Wto=;
 b=h/ASGlBazfaRZtmPDngsQX7bplezwQhzDclHHu85QhxGt0Sq5bcLGOpA6PfvMa3OGB43UhOlPKUuJePvTgzQp7pGeLkES6ZMQiACWLGTlJqh0kn4IE728+CSKTXe3B7m5S0sDZTCt1wbj3JlQombCJxMj2GRZhq2MZt+Hemw6L4=
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 04:25:28 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::73) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Fri, 24 Feb 2023 04:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 04:25:28 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Feb
 2023 22:25:21 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Make umc_v8_10_convert_error_address static and
 remove unused variable
Date: Fri, 24 Feb 2023 12:25:07 +0800
Message-ID: <20230224042507.30533-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff0ff63-07f8-43ec-795b-08db161f2872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELJQnMYjcRZKXn4r4akXjlpPNoJejKnRYY5fROfl5lAjo33PP826Bdcpfk9gH/ZRxO00JYMLSJWRVbDwO93Hl2XMmpGOZskrLBLClN0DiOn2C9n9yfPBxIib/SL6ujlYbiS0oA19VUBn9xAsxA3YNGcGEAznqtHNi9TjDT2oW6uLOaDc2JXLaumuJW4VzarObeZgvkxEvOgdXjPvxa7RoeI75ArWJp+36uY1RdmwvwR1coIo5uHeh2cRdm6XbMZ6gA1tuSAkstJvhbnk1JahHOyIefcuo/K8WlPGgbn3dDqRVHhPBwyEdxb4TsuXf1zJvmTZmPd5Rgl2YGiVsP72FFjt45q3R8k1VJDCz5wLAvSiBRGS8597OaSfn/6/smOfq2Fy8VTI3gh6AjvOpcc+A7ckvKGzKNdL+RILCoe+KS6B9wJAh972X+guQ0MT/R5ASBVXeYwTmY0nBKi0kj4PFivMY8ExCMbGUOtaZdh0JlQxuP56BjmvCsnMYvdh6zIFOBnN0g4AwbEJHlHSOm8qq99G6qMa7lszySynfqgojUVzhvCSs7sSkun1hL9I5H38QTiU7yXT4Wi78m4lI6NRpMWDFDrfuE0HBd6aHSJ/6DwBLol/bVlqg9Lqimj9pgfM9YTyqTgVQKHM+m0XfgJuinTy822Qxc73SCRzMcB+zyZDuCAEZavcWwPjzQcRIVfFtG3sHSeU9AtRluM6l/2SxkD8WtJscs9+aHkvQChtSmM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(478600001)(40460700003)(47076005)(426003)(7696005)(336012)(316002)(82310400005)(82740400003)(81166007)(86362001)(36860700001)(2906002)(356005)(44832011)(41300700001)(8936002)(4326008)(70586007)(1076003)(8676002)(6916009)(40480700001)(70206006)(83380400001)(5660300002)(16526019)(26005)(6666004)(186003)(36756003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 04:25:28.0039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff0ff63-07f8-43ec-795b-08db161f2872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes following warnings:
warning: no previous prototype for 'umc_v8_10_convert_error_address'
warning: variable 'channel_index' set but not used

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index 66158219f791cb..fb55e8cb9967ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -209,10 +209,10 @@ static int umc_v8_10_swizzle_mode_na_to_pa(struct amdgpu_device *adev,
 	return 0;
 }
 
-void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
-				    struct ras_err_data *err_data, uint64_t err_addr,
-				    uint32_t ch_inst, uint32_t umc_inst,
-				    uint32_t node_inst, uint64_t mc_umc_status)
+static void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
+					    struct ras_err_data *err_data, uint64_t err_addr,
+					    uint32_t ch_inst, uint32_t umc_inst,
+					    uint32_t node_inst, uint64_t mc_umc_status)
 {
 	uint64_t na_err_addr_base;
 	uint64_t na_err_addr, retired_page_addr;
@@ -434,7 +434,7 @@ static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
 					uint32_t umc_inst,
 					uint32_t node_inst)
 {
-	uint32_t eccinfo_table_idx, channel_index;
+	uint32_t eccinfo_table_idx;
 	uint64_t mc_umc_status, err_addr;
 
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
@@ -443,11 +443,6 @@ static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
 				  adev->umc.channel_inst_num +
 				  umc_inst * adev->umc.channel_inst_num +
 				  ch_inst;
-	channel_index =
-		adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_num *
-						  adev->umc.channel_inst_num +
-						  umc_inst * adev->umc.channel_inst_num +
-						  ch_inst];
 
 	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 
-- 
2.17.1

