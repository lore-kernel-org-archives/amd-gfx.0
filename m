Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96574C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 15:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D7010E15B;
	Thu, 20 Aug 2026 15:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bf27vUWt";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E8210E15B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 15:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6owgk/lKsB5a20goi7Ci6gYSOctn4WUpABIys32MhlgUlHfHNAA6r2WFUjaFnJoduoy0WZg6ai5XaIgegiQ59olLD6EGicghYY2Ux7rhpf0kCHTdQH1gwensKpWtxbCl3HI6IUtjnD7g1ryrmRHzBbvuVtYDk6nGkOtdQC09rIR3KH2gCXJTcP4Mdqp0+f6Xri6A8dPt+B5m0m3jkaUFTOhBGNU1gWxdp7ldvTRkdaFsjoH7d3Og9So4wuAfMlfzfBYAJXOJ6U1FdM2hsfDmvSeZHM8jw2XaSQGYZdVx9sdVlOZKW2PUjqN4n5PYn5Yja3qh91oT3f7Pi3WoQsF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agEIzaJkcOaMnnL5H+ybTzHwoN486JqNbFour9PN+9A=;
 b=kqoYIdwqByR3a32aU/Vz3D4XBTm4148RJAbMPynIE/5mzyA4HmGmiN7da2JAUAAAzJJCxFqA4pT3Sa97TpuIg5DrMXRO4H9H0XYWT26MQEef70sMV9ge9jyYG1F/bJ8zH1/JSsf4xhS3OSriRm301jG5Y4aGVfoIMtrrY5+bSf63shCQDLfZ0umP6cj4OwevhlTamCoYakA+2yf6YdJUpWlB0Z7cN6HCzXY7ihkbBVLp/1razyopNCmBTCn04AnNibHl/+Y4TbmFae/xb5d2QO5j/kmQ/6f+V4ur8k1WsfFozWHdvKEYnQ5Si/xkxqpImQ6aCYGGvHV4DFzHh3VIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agEIzaJkcOaMnnL5H+ybTzHwoN486JqNbFour9PN+9A=;
 b=Bf27vUWtCCKcytp/LZJakanPiK2+kcdi1W5lUp6F+pRntVadiL2jY20wSSpmIyExGS34GTfap4xiyFPzmBJbBIqGyaikzfR9j147yS/HgFfU3SEvH4TBpFJqoO7eSiBDybrnS0HS4B3aAQy2IzgxaBXAq+ymKjw+eULOPXOc6UQ=
Received: from BY3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:254::34)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 15:25:50 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::40) by BY3PR05CA0029.outlook.office365.com
 (2603:10b6:a03:254::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Thu, 20
 Aug 2026 15:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 15:25:49 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:25:49 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <shaoyun.liu@amd.com>,
 <alexander.deucher@amd.com>, <Jesse.Zhang@amd.com>
CC: Amber Lin <amber.lin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Set queue reset method for GC 12.1
Date: Thu, 20 Aug 2026 11:25:04 -0400
Message-ID: <20260820152504.1160822-2-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820152504.1160822-1-amber.lin@amd.com>
References: <20260820152504.1160822-1-amber.lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 272f1c03-b613-4a17-d50e-08defecf50aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9dOl4bA9uoRzNBwRTCE04scHDXsESOlcgSJPkuYN4d3VaOYDK3oBrRsoiGM43AuNBgs15IwR/wu6nylS7ZxeOXncR9ukcw0jQPd8GmaIuU9GYSNgyd1/N2LSTOW4X3bptE/9HUEbEdwmg/3s41xETedvfvWbytSII1JnIp3bTEha9cT91VHlAjvLnA8TzOJytzJq94cmg5rL1AYlvKqxCJI5v2/Q9Dv41WOtMgxEfXAhMuxbI2L7IEaQfBj4Z7Of+pwHusyw8B356w6CBzO4987iT0AJG+M3dtGOIs/UGEpaf0ofE0LuvBGWGLeTAdZb4XeG6QuuHlcYen3oD4Qovdc8ZEDULo869NgoN4hfFneCoyualVe2QL1N9uS/gcjtRMYln+DsdxXasyugpTg9MinikKKyODhvbxOfH76C/2fnaWdJ/kdA7/Nusmii0jfdVP/icbTsyzVnOU3lRA1s048zL3KLInCPliZgQdGiGTW/x1ux36ZK2o0X4jBxGceZleYFOARay7LcGBIYJ9fcmc5B+GvjtGHDMLpObQIZR7TyIo1tQzr8a/TMAmCz4LgtlkkfbyPuZbGMDGev9+8AMOZ4DckAwMJa1boOCgWa1Jb/gC/g7UdK1dn7/TQC6sVwxg7uvJmtsg/XzRHkZOYgS2i3I6utEO+uFDuSBvPEEiUfNHoftuTWoGQGYsaQUYnTRR1wIgkdz3uy1cJN1BkoQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LBae22HhiDHqOm3BibFg/q924/kVWhXhBnmwdHNEtksEpGODLWVQMxHIAKbZBP0bhFaTcUAX+XS+xNEoTWKQ2sp1F6jUR9uVl32DmgJDWDi9gvXo0Mm/pwnd0cvFCPoh2GAEbBukLwzmGXwfiqT2CPEfzYq3mX0A2uXUY4oEmOsA7wGtaq1rFkFmcwFP3fcV+IgOzR/p6IdECq/rYzgTxhjjDeLPlezqmKXUI3AE5HZBsI723oxO6q6Na6+5rvj0juI6WZXCq94Z6DzzkJBEThDkmbEywOABd/zq4derD72wr3yYGG0UtkOE0OpPy8oCDCTaro1VaXN1wRcLHcGkyI3iWW6PLYpjzzGWQ/p7DiPy9n4eVJ7oEzgDmXq5q2Uew+zh2qyFUGfW5rh9gedEZ4GyfvI7sImhMpH+4YwqgB2l5Sd+iWbksGH43oCeTz2N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:25:49.7462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272f1c03-b613-4a17-d50e-08defecf50aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Explicitely set use_mmio_for_reset=false in gfx_v12_1_sw_init for using
MES to perform queue/pipe reset

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 9dd7a3335719..97f4da7b7607 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1560,6 +1560,9 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_1_alloc_ip_dump(adev);
 
+	adev->gfx.me.use_mmio_for_reset = false;
+	adev->gfx.mec.use_mmio_for_reset = false;
+
 	mutex_init(&adev->gfx.mec.reset_mutex);
 
 	return 0;
-- 
2.43.0

