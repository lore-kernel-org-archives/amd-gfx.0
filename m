Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DACBC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 09:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA17410E4B5;
	Thu,  2 Feb 2023 09:54:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899FA10E4B5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 09:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLdKwQ17FOTMz5CQOZrzRwWSeurB+XcTNRxYnd7/lDCFHfvsvfgKdB/lA/PrXoTj9KbdiaVNFPbMtWxmNPM0MzvBWEkm1YzVdC7HY9ny4i8jObhQn3tOqNYlq+cj8LPt5k1s0T3bhziF8e0sjNmL7xAMBqHm4H4i7mBOghieO9xEdownPxA3AUizl7IWv4Ty2HjbjgX/H3pAGg5K0fsDSfOQK3Xs3PCbSOFTlWjqXz2HVFfMyihPfUbvhVDbU/YN0MrI94y/y/L0b4wCcsvInCm87AmBsCt0QZR91AF7G6EgshWkSgRKrShg3WvtBtlGUEBIjP4h3KeyJWfJdoSeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp7h8jabjdmjxRagoV1eWzrwV870N12TufAA1Us5rB0=;
 b=VUWAT0PmJU2FFBHjw6LBQFGiMMElc50pVbF9BEZzMsV7baJVKzIMC76LwmQ9sct2cpsP7yIOrap8HigzAOSWdk7ApWSzU3Wmr/df5W66+Fyyxgff1cK64xN75l9zAS1oov9GcIXZGksWb4yvyHkBxkuv42TdmQgE9EJZzlA3GFaoZ4HioGbs87YmtXTOzXgagvRYBE5Xc1w156tDMiOSRAYFn0XYZq3QY6Uq70IqT+53wr+K3bN48EGYEhoIJclfFVS6Qdn7PnnFuOaaBA92s5PPqvPq29M07j8YVVONztIt+XjgNFK70auhnJ+QxjmY064TTDGgxYcZgEcu1cDA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp7h8jabjdmjxRagoV1eWzrwV870N12TufAA1Us5rB0=;
 b=v6tNMeEP2VWv9JNkW7blCboXH0p4MOUvfjtQ3bjZxP+Y0+z1r1axmEmTxfJ61/CLv9XsykrAIPbOnfp07rTmV4XoiJlccySXDq3uYtgfr8AFEYeIhhDWkG5Eg1vPNvnrOebz7ltyZYfjEHve7Hw2sIoBE0Gnlu3eL90lwwv+CB0=
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 09:54:40 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::82) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28 via Frontend
 Transport; Thu, 2 Feb 2023 09:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.25 via Frontend Transport; Thu, 2 Feb 2023 09:54:40 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 03:54:37 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is unavailable
Date: Thu, 2 Feb 2023 17:54:16 +0800
Message-ID: <20230202095416.4039818-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f43a02-4624-4474-bd2b-08db0503807d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ep6x/gxa2TSEiw8djN5DZ6jCKY6zQwy/UB66MgCfDyFQrzbJBwEF3/IRhprxTgx449g/lJPT0Qlpm8f6G0lmcaGO35zlzu31CSQxIXQ6AAJnxC/WGlfwc5JYspBpQNFtMBoXryC/eYA/cv+ruA7Djg8s3ZjCUUPrw3IKhtMLURzlgJVN3Cf1/0GPd7RBucnoDRWkW3k0uU+zRy0ff/vLURGlfYW5fDLqkUcQTpKiJ7igFRl6NxkDIF8Ybe3coLTXf+ULzudb3Smowlq2RXH95036dkMOr2uUkVHNxXc59hAR3lZDO5Tq81OzoJJtbtQY2PG4K7rztyvBXzzEPhOl1Ja9vl9PSBVSnRxhfoelDkRTYw4meUKLVkxFCKiSJ8wWC/rWFDKc2SLOwLQjPtsGoMLPGvL5zSDSEXCFPS91rJXXGfPwLy3TWUKiSE4JC4vsNjURjoG63VkpmjdJazbmepsM53aHXCTnsi7YOxkWPQlnW4d3GN+sGBeCFo6c0JkazZZJdZEg97OVvHE1NhhOb9ayV3RnnIbNQ2EYy2hT7EF8qBWGBYty25ACrbaVEEdt2QhwNCxNstEdwMFHoe5W+o8tVEJsZeAlvEea8MOK6KBBJfEgsFHBgylzpZKPfXwUrczqFyH0JV2aToMinfvcnfS8pyOfsMtlI9LZ6nvxCoN6brvNXpq6tq00aa8ZueiyX0aOembNAaqP+PPKWQzGZ0N12+rHw/oTtanwGmJKVece+NjuO3p2ednEs2g8cZyX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(26005)(7696005)(40460700003)(4744005)(36756003)(82740400003)(81166007)(86362001)(40480700001)(2616005)(36860700001)(186003)(356005)(82310400005)(336012)(426003)(16526019)(47076005)(478600001)(1076003)(316002)(6666004)(6636002)(110136005)(70586007)(41300700001)(5660300002)(4326008)(70206006)(8936002)(2906002)(8676002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 09:54:40.0259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f43a02-4624-4474-bd2b-08db0503807d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reduce waringings, only warn when DMA is unavailable.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2d237f3d3a2e..e3e3764ea697 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 	if (*bo == NULL)
 		return;
 
-	WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
+	WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
+		!amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);
 
 	if (likely(amdgpu_bo_reserve(*bo, true) == 0)) {
 		if (cpu_addr)
-- 
2.37.3

