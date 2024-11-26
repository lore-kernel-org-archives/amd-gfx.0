Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181D4D3B980
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 11:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A228D10E029;
	Tue, 26 Nov 2024 11:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iTrCoZuM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CC310E029
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 11:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIDJoxlQB6XLWg8h4gkiB6HUY1UtNRYhx1ZqsGZ1FYKXa7N3rEF4PcSy4kXG2KAjbztRE7uCc7iBJSJPE+RidBCHfVdKrDEz1GMeyK5St/J1ANuu2iVtTEba9Xq9mvMiIpObKdoEi2Fl+QyDsbdxN52ko/1Zbm8RKxpJkfgI9gp4lwlIzl4QXcRqRWVTsNuFWclM/7t3oCTnU+Fy0dPaHYIhF//iGuwV37nzIYxlj/8WKvfnHpxUX3uv+XI363MoGUli2VlGQB0PDltqk7luzdRLfEDo2Fxhsme+5fMxm50owmN7XC1DiUJb8hOESK9+9avWRtNV6tOdFKJ5rk2Y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeqJ/DA2XQCrpH2ccpWdQZs5MOh4pwOQwjsNwfKMFso=;
 b=SsU9WDuZLQNMr3DiW4SmGIE+g99xH9SmcKH0NfpbGicASuMTPa6jiqjRRkuqsaL2hIXi5jIqGvVv/Dmf4K8aRJ3KJ1Gz9HeGcHGUY7orwb3LxkXY4uw0Q+Xz5bXOky49p+wjxKEGndLQkPf8R8Z8q38mpyoiArAb8GBsha+Xh3v3hZiBOpNVuvSLRfIx0rz0/jnFoLzLKeBAqnWxBzoHQ252Wp9hjZs6JHXbo4FQeCUPW+Uu1YS4Tdha2VHg4cJ0m/96Lag3E/iNGpfeVQO3YGe6bc+JnIGJYGggK5bceBUMKlvolnNr+1yKmpg1uoWxOQ3SJsXmbRMil05VI0c2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeqJ/DA2XQCrpH2ccpWdQZs5MOh4pwOQwjsNwfKMFso=;
 b=iTrCoZuMHKS3aqU1wMdlaDn3wblP1IJunpful0xQ/cHb6wrGilDajtf1+gs0j8G/8TyLCDnkqvGUqtgCLDKCslCSOZjjP6a1STemZxL5N6LO/UbFtnmHWrCbNGai/RmTtSuBUyy07DcRzbBYBo6DWos3Mhu8V4NQ+gl13CETjuA=
Received: from PH8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:2cf::9)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 11:16:42 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::bd) by PH8PR07CA0036.outlook.office365.com
 (2603:10b6:510:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Tue,
 26 Nov 2024 11:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 11:16:41 +0000
Received: from f9br11f2r-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 05:16:39 -0600
From: Yiqing Yao <YiQing.Yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <lijo.lazar@amd.com>, Yiqing Yao
 <YiQing.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: fix sriov reinit late orders
Date: Tue, 26 Nov 2024 19:15:52 +0800
Message-ID: <20241126111552.3995736-1-YiQing.Yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acd294b-946a-4921-250c-08dd0e0bcdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tihPpclbrvpRNQYG32DLjQatcIjx3efNPEbbUfk33xTgPjO8AMH66YPmctZn?=
 =?us-ascii?Q?y985SxwHagJEgHbGepMlUdral95R9fYdGxNo2Ixzb3gRs+DSof5lxpu9bg/v?=
 =?us-ascii?Q?9hEB6m6twPKZg89l64dU/J71OjKEBl7f8/HyMWEqd7hHD0jK4vBd8UcJLIcm?=
 =?us-ascii?Q?+rejoYK9/e4YcD8JYo87mENZ7ZWk6jxcb/GbLVd3QLJLQW0QNYpMSdps1PQA?=
 =?us-ascii?Q?5WSDPzxs23pJHvs3RjYdt52NNJAXFv3VVFg99NCLo/Bm2muwtztGd5j+mP8x?=
 =?us-ascii?Q?vmni34a10mMqel74FR19f0L1yA3VetnClhOyPtOC9eXjhBApUINvvN/Fo2Bl?=
 =?us-ascii?Q?BJ0S7aHcNl3dbdDg4TNwUHgfgtxIbAGeTAqXHCD8XaiWS8Tr2w0GVkYCgHj6?=
 =?us-ascii?Q?bxlsNFBJPLyv2J/O2xELXM6HUibz+lKbFtReaNfo0gjT/2SVR0DIMPr3oscx?=
 =?us-ascii?Q?OVO5SwnKbwSWeQQ9mbx84S/VmPtJxBi1OlfsSZc3zjHmkFaI65KjXsVGvQcf?=
 =?us-ascii?Q?BmTNaHjFect4Zvbvx7WwG83Dhk+FKqhr2Uav2r6woqUVSVEKBSUpafBpz1Mb?=
 =?us-ascii?Q?lEXYjLB/rCNh3czDW02NaP55eweYEHRueqqs/Y4ciuG4m4UXWFZzh6Q21KsT?=
 =?us-ascii?Q?ukcVFHzIiy71cJa5KpGExAHJDZcOgxpqdlqVTtWhW9QlTeoykg8vmMgiN+24?=
 =?us-ascii?Q?sBgxODEi+tg2XjiWYfTwlpQMTQDGNF3HBfLSq0Nf5H0W7asvI/k2aexIy9tX?=
 =?us-ascii?Q?yLItZI2TQi/lA7cQfKySTYEvDw3GA4kZkTvEHYnw2EZpbHNIFUPoVPQ5PM4v?=
 =?us-ascii?Q?EkPo18kEVTh2DzISkgMr5YC4VXG/I3ObAef1CWEyn4qWp6urP6qlTYTOUSyo?=
 =?us-ascii?Q?L/il9/aJQxZCafQzRuyEGRQmpX+bM4bbsm9okHQegtS2KPLcQS0bE248Hiaj?=
 =?us-ascii?Q?cF55tA7a/gAn5cAj+udvOBDmywQQaCtgs4cc1mfNtN2io+18a5rTEpboTtBu?=
 =?us-ascii?Q?UNIO/y8YGZ+MRDQYxx9NhRNbQNf3EiYbYwO+ehQQ3momnqXekYuXbaPgXZ6F?=
 =?us-ascii?Q?b/iSmhtGfssdcOwofGMw6gse7ZFE+JRB77n8eErDwg7fDs/ILRRdAOGAHw39?=
 =?us-ascii?Q?jtge9Zp639T8HsBiVP7Xg+IsUmckFKRvGAkuI4l1q5LsWmmnG+qyu4ubODiB?=
 =?us-ascii?Q?HUtBXNzC2waPJog5/TkWyaT5ffOVd2cCRuALYz3dwn6vNZbfnKFzM6yWIjO7?=
 =?us-ascii?Q?EAzxlNuH6ksvijKF45ZHl7k/dn6cqMrMq/lYI/OtehpJE3P+0+DUGYJJp7fv?=
 =?us-ascii?Q?9As5f50ELRJhH3O9h08Dew2C8VVdjUYe8nvThTCEbmoChsC7T6gOgFfSlEb1?=
 =?us-ascii?Q?0Blfgs+EdgrcImH/3CA2HRJbWsqZXuL1ma6HLGML/LLY6jj6JfiwA+Qr7eOw?=
 =?us-ascii?Q?jmWLD0+5oYB7cjgfFZUjGkKkbKPlaJyP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 11:16:41.7649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acd294b-946a-4921-250c-08dd0e0bcdf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
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

Use found block to call correct init/resume function on the block.
Set status.hw for resume and init.

Print re-init result again. Change to use dev_info.
Use amdgpu_device_ip_get_ip_block to get target block instead of
loop.

Fixes: 17eb6e7137a7 ("drm/amdgpu: validate resume before function call")
Signed-off-by: Yiqing Yao <YiQing.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 +++++++++-------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79c573de1f2d..2e30539b589c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3669,7 +3669,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 				continue;
 
 			r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
-			DRM_INFO("RE-INIT-early: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
+			dev_info(adev->dev, "RE-INIT-early: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
 			if (r)
 				return r;
 			block->status.hw = true;
@@ -3681,7 +3681,8 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 
 static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 {
-	int i, r;
+	struct amdgpu_ip_block *block;
+	int i, r = 0;
 
 	static enum amd_ip_block_type ip_order[] = {
 		AMD_IP_BLOCK_TYPE_SMC,
@@ -3696,34 +3697,26 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 	};
 
 	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
-		int j;
-		struct amdgpu_ip_block *block;
-
-		for (j = 0; j < adev->num_ip_blocks; j++) {
-			block = &adev->ip_blocks[j];
+		block = amdgpu_device_ip_get_ip_block(adev, ip_order[i]);
 
-			if (block->version->type != ip_order[i] ||
-				!block->status.valid ||
-				block->status.hw)
-				continue;
+		if(!block)
+			continue;
 
+		if (block->status.valid && !block->status.hw) {
 			if (block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
-				r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
-				if (r)
-					return r;
+				r = amdgpu_ip_block_resume(block);
 			} else {
-				r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
-				if (r) {
-					DRM_ERROR("hw_init of IP block <%s> failed %d\n",
-						  adev->ip_blocks[i].version->funcs->name, r);
-					return r;
-				}
-				block->status.hw = true;
+				r = block->version->funcs->hw_init(block);
 			}
+			dev_info(adev->dev, "RE-INIT-late: %s %s\n", block->version->funcs->name,
+				 r?"failed":"succeeded")
+			if (r)
+				break;
+			block->status.hw = true;
 		}
 	}
 
-	return 0;
+	return r;
 }
 
 /**
-- 
2.34.1

