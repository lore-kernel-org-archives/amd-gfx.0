Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95283C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12F910E535;
	Wed, 10 May 2023 21:24:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E932710E535
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3D8hcGrqVt2yO8EtZT4d+J5v7YXR3AmiX2sFGz+bzOERYOM/1hTbEq7aGaI0zPhXnA1m68iwkTUsQQNY44mnMerQgcT102efqUKchp6LwKjZDxWKN9MTfpphzUQoqZB4dh7PoZZx0pPLjSMdy7FUOMUFBHmk7dPW6zG8SagNHxfVK64E1G5d7fXy9x46h8kvrhJpT215JxkHSQcYaB9qCBgOsKOO4F/2Y13UD5aztlKffIeVYXNRFUS1z33R54n4VcvbGr0tpmw8pnHcLv8Xrt3K05tAeRl6a7qHlBOIORvsXOaUYqBwt6ATAiWM2QlS81iY6a6X1vRW4gW1wVbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5yXsLz1ujFMkw46gjXGBKhbT77w/MPu+N8g+anlUIc=;
 b=IuERQn4ezjWZ8mmq81Dda37NFH5gDoC3J6MWPrFBLTKU0x8ADO1//7l1FUx59jDP4o1K20ptBu64DPnEKKk/z/iT/qgXi1np+H48lAxxpqVVIA0krbgfObqD13mHw0OqbtfQJsrVE1tHDDE/lNHsMosJ5Nz9nsoRrEF5BsvJKyRed1BcrmJf74pNbhA0+Z+om06gQptJlhWA4kV7B09jn4Q5qAopX2pgcSbMv0NGXObh4I1eXyfxL9jmK0Y8N39cZBBJjeRXQivIVqkukewX0FTtl2FXv7QiGZKkrE9VPlbQek5t+PPguhhLOSB5SPgZekQjM/Tyd6X3DUBk/o0tCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5yXsLz1ujFMkw46gjXGBKhbT77w/MPu+N8g+anlUIc=;
 b=Rvzfj2nhScSQYsJ9nuMoReUpcw/Xe9o2Q62yzslFB8WYMY63L4ASJrfOH0enANNJRPfLofHN0b87r3G5Alkt3JUkdgFPCyW5Uqy1iw0fSIKc/u56cU4k9uWiBE85EUR3ZZoQEYHlmR8UeLgugTWxoKWudyTzI5mOhy87j/KjVxA=
Received: from MW4PR03CA0317.namprd03.prod.outlook.com (2603:10b6:303:dd::22)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Wed, 10 May
 2023 21:24:05 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::6c) by MW4PR03CA0317.outlook.office365.com
 (2603:10b6:303:dd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.20 via Frontend Transport; Wed, 10 May 2023 21:24:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:24:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/29] drm/amdgpu: Correct get_xcp_mem_id calculation
Date: Wed, 10 May 2023 17:23:33 -0400
Message-ID: <20230510212333.2071373-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8cf160-5bfe-4211-c91e-08db519ce1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWIAvIBEMwK1gi/JElpTycATp6sVG29RTgproLJMHUVFSGhMv4qG1otT9RBsJ4RM/3wtyK6TjHGHJJY/NrTXPwfDEZ355H7BqCKX0AuLnr6cWcVdx/0WZ64Z9cSLZmY1jlLlICiUvYxG+L64F1oAzMmvmqAgXXLnYQyW1yBSCuRxP2dnDrpquvuC8clxYgp1mAAs7PTRzPJtS/CegFemrfzlpZUEpM+LRUBdZSxQQUG4KGtceZz7knpNeRg86tCzqsrqKxDkODKXluXJTAdz9YGp+K2l0O+VWQD6+TutTMRpAGRTgd330gyxdfHJJaXD06/Wk2R278U479HuUOlnBwl/4Na2Pm28PpHmihQKOEk5cNR71B27YAAfrSTRFqVz3ci4Eb86Qsmtt7JMVvsGoIrnmrUs15uUphZwt7K9wEwCSV2BdAF1rT0FA2lpcLR/yVjcsh3BeaSTUCVFL4vAzOh8NrPttMVEagIbJ7NIW55V3NdAzHAwtxbIOy9NXLiZqpVsUO4myM/aqJmNyAc0FTg+A8Ti3mj8Eh7tbx0q9LZ0DhPPqGGvqkedd9NlKUw8d4NtWfWoti4k3q0I1qF3P5c1inocTtCz7Ub5d3gHdYfR1yhh1hce8Pnr7IbOhVHepvNoriXZ8XbLFsyv5v5FGX/Oeh9tuew4jFgj6aADbX7VlxfzYU47weC7AYGUun179p7NPrc5qp5WDz1g8mO2vXe1CTeGZ2Iu5HtKKIeyuw8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(356005)(81166007)(336012)(186003)(7696005)(83380400001)(1076003)(426003)(47076005)(26005)(82740400003)(2616005)(8936002)(8676002)(2906002)(478600001)(70206006)(54906003)(6916009)(4326008)(40460700003)(36756003)(5660300002)(86362001)(316002)(70586007)(41300700001)(36860700001)(6666004)(82310400005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:04.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8cf160-5bfe-4211-c91e-08db519ce1f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

Current calculation only works for NPS4/QPX mode, correct it for
NPS4/CPX mode.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 4ca932a62ce6..93e9f947a85d 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -518,10 +518,9 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 static int __aqua_vanjaram_get_xcp_mem_id(struct amdgpu_device *adev,
 					  int xcc_id, uint8_t *mem_id)
 {
-	/* TODO: Check if any validation is required based on current
-	 * memory/spatial modes
-	 */
+	/* memory/spatial modes validation check is already done */
 	*mem_id = xcc_id / adev->gfx.num_xcc_per_xcp;
+	*mem_id /= adev->xcp_mgr->num_xcp_per_mem_partition;
 
 	return 0;
 }
-- 
2.40.1

