Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24241C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 15:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AEF10E4BB;
	Wed,  2 Nov 2022 15:23:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466DF10E4A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 15:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpOn0VQfBSzs9UimmYsULjrQ2pWNnV9u92uLHNWgIhhgMvuk9qLwWrX5qp7Ca8aH9hmXF49F4yNxFZposUkKZpskP+1DYI9G0c4mvQA3RJN6l7dpT4GQ94iva5K2/Ks08dqR59B9owRoyj1RMCPlEyAGnbl+Blul4+8og3kqFFhwoL8nGFMQ+erQcWyjOp78jlO7FyECLxaXjZtCQ4SXP88kv4X00zjOOgTHYQq91QMhL8uoB2qjSkNEQMl4ACKXqN0l4SN+Ld7BxPXOb4/+nUzSBczZpmGMUg+lnTeVshcpYGt/zOhqFMXdzbnVwzib3g701taDZkK7rl3GIDMkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qns/ECwMwYEuWnuH3192ueu8Fcftmsvl0SBLeu8R5fg=;
 b=YSMhC+h8FDAdOZ2z9+H5zGasWHkBhD9nflizRzfQ6icksNddVYCqkwpL+9ONrgLemUlLFV2//Dz94CQ2GbSerloTXMZ4BJPg8mPoo4BBCzlfxuIJQp8NqJzJJHUnFnZ3MUB9TadqPNiZgHrLOcjp346Ui7dNQVItxO2Cm3x35pckIdhBbeuf4iKaOpAx83eW1RcGheZn49iMqs2eVkOn+P9X7FRxDWsdXNyrDjMCGXyb7T2o2PitfOtSntsQcUxbCYunXZ4naAJlRG8eXQxD3y2OMkPei+AZkNKCzB7R9Q3JxcKxgiXmZ0UTvLRLDZH4BnG80j+RnVbf92w2y1Pftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qns/ECwMwYEuWnuH3192ueu8Fcftmsvl0SBLeu8R5fg=;
 b=QGfXX0GzfM2f6hLfZh2nm6SPWmMsFXMPCeLy3b2CsNDd8qCUzQEG0UxtQMT0HahCn/d4dfkx3n79jeGj4qBY7immbV8tTCRGQXhZjJE1+Ehw0fc7RmAtpFpEvikPYfJhwpGu2RIVUwMTiXy4LoZObdjrgLdZmB6+6MDwL0+CepM=
Received: from MW4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:303:16d::6)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 15:23:50 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::28) by MW4PR02CA0015.outlook.office365.com
 (2603:10b6:303:16d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 15:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 15:23:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 10:23:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/gfx10: set gfx.funcs in early init
Date: Wed, 2 Nov 2022 11:23:32 -0400
Message-ID: <20221102152333.553521-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221102152333.553521-1-alexander.deucher@amd.com>
References: <20221102152333.553521-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|CO6PR12MB5441:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8d7e98-ee8b-435e-9aec-08dabce63ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeEKnSLV9kcoFSMYV3a6U71U0b57DYNH8SFCKP6GkrUCOdSgIlxfsIKNhU1ICdNCoUZu7FcfdPUepzY77ijNllKMrutNiEnvAV4YbZWB9jduNFbZnA3JaGRbxKtng6/KqmoT/y/rOmFVOfEcKTqded1XNIS+Aav/r179qPjSVm9y8MVck1QJnLb+AhZk0/VVhgLVOWB+Adm9sLUDMJiNhNucDX1GqObyUCsbL/QHuHl635n1U0IjL2oNEQAXGqlTJJviO56z6t65WlnTC9uGOhgy9Oue+pRvvOW0QNyrfRcHLYHCDfwel2ulz7CuHCMtenJLsz9tK8GhWsX0EWR3NcGDrO6uXODCL0HMHb+ExqoxMr9zJ57Gu8M3EBgnSN9jZngUMcos+dZyxHOIZmAX+73jj9BGSOR+pmw6IJVNQ0k0S+xfdD6umnXh8rvP2LImsiPSNE6p3qMX9xXDScLIqkzy2+wazsaynv9jNzsg/3OFvIRVndgqO9dmeSAZyUO4gnPWIX4Wca8w1OT4OrlvX57X2l8YfxxbanHR9HopKO6zxMN0qPTskyPFoRfFOBibsdA9lUbHe3iWJILJnakZdxZ2SXGRrEmkLWY8/E8dWNM5WWaseSnp28JEwuGuauGPa9szyVxD8+xZ/dfUU4zq0m9JPKvn0raupoLGBTd58dwiAwGQ8GwihK4EkmP3DNcSo+6oywQ3XIaQwI5hFdf5A6hy2dqFZXdN0TF40W+2erbcVmNfYVZ7b+CllL/0+Z0SIqKhewRJ43i3Bq0KgUDq8ZQ70RzZfcg1MyN9vMZhcCs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(81166007)(82740400003)(36756003)(40460700003)(356005)(4326008)(86362001)(2906002)(40480700001)(7696005)(6666004)(4744005)(70586007)(70206006)(316002)(8676002)(5660300002)(8936002)(41300700001)(6916009)(1076003)(82310400005)(16526019)(36860700001)(2616005)(478600001)(26005)(186003)(336012)(426003)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 15:23:50.6658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8d7e98-ee8b-435e-9aec-08dabce63ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So the callbacks are set early in case we need them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index af94ac580d3e..f69d6289347d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4453,8 +4453,6 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 {
 	u32 gb_addr_config;
 
-	adev->gfx.funcs = &gfx_v10_0_gfx_funcs;
-
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
@@ -7593,6 +7591,8 @@ static int gfx_v10_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->gfx.funcs = &gfx_v10_0_gfx_funcs;
+
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
-- 
2.37.3

