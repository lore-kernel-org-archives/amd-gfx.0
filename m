Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBB1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89E510F6D3;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA8C910F24D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccLRIPA9f91Ja4AI9a9ki3MQB1+PR6uKDpIYvFxh7L6P5UH8Hj3uiiW8i5trfWvIIsm3jX1KqmA96Q84oR+aF0QFSrnxo+p43/wvQYIfDspUPcDtqriUp9wDBmlhjtNLZG5bayMQ/ZHzEfiIhiZ408jMr6qne3D6clNgIoFzyStizwcu4vq/6P8eJ11By2E4oMjNRVbS7CDTOZwVKUaSihofMxI9tyz/4+TddZaqQWUoB+97erTQg18Y+I9JTsNsGpSYLPIPy99X3UgJfQuJcxj/Nha3Ln1qP7PLbPjaoRRMcjLvQsgZ+hTxUrTSEocDjcxuaqqFzn5IOJMWYAcfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ5XA0/nBsFom/xgTMjTVxggNjf1e+KFlDQJ35IfL2Q=;
 b=K6eg8YCAysZQE9JurGvvSw7zkpDgGeEkgT8ZApgvfseAjMgfUZETb6k/iLRCzHJfMFVUo6pbZlxV647jAmgE+aeGnhLNBpNxKF+j6OV6ebOwupGuR5+Vxy4vd/CRGge2UlmcSS+dZEzg8N623rRECHSsLvcyfeivg9Lx/1cNv8swcpO6+cbgUi0OH2SWDpDrW77N0gGbQMpmxQGtpzja4TgnlqElVVW1JJd/0koAc8i0EOvFoLb6BlTt5s5yqMxiJWV8r7SYhUd9XXF7PpOrEj/hpSDNdO0H2vDSq5Se+C9q5x58Iho2/f67SHQYcES1R4G+xe5dbQT4Bg6MLu4C7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ5XA0/nBsFom/xgTMjTVxggNjf1e+KFlDQJ35IfL2Q=;
 b=XV4Dydog9xp14wZoPXeyQqXZNOIr4wJ8BVz/H89QkBGRrsy5H6XfT0rqABF1PjehFzcUGatlxDtftMmFVhWFiH8gFpGrDm5gTDq44Ao3Id31m8EzGuUHxQ+dKLR0kfTP+WEcA9G5PqCb6K7qA/1N6QxopyCNENBtUujfvWWnmO4=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by CY4PR12MB1863.namprd12.prod.outlook.com (2603:10b6:903:120::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:47:05 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::d7) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 45/73] drm/amdgpu/mes10.1: implement the suspend/resume routine
Date: Fri, 29 Apr 2022 13:45:56 -0400
Message-ID: <20220429174624.459475-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e9e400e-2f68-4493-601a-08da2a084657
X-MS-TrafficTypeDiagnostic: CY4PR12MB1863:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB186340C63F6040A2D355BDE6F7FC9@CY4PR12MB1863.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ooLhFjCS3CRMcnU+vGv4DN5H4dHlkhq/2eIl9Dgg7RvA0foCfX29FVW95wGSkdK6Fd+QZOeWK1G+6MMcSErDSa2o+AqyN56Jvm6s3TGTjghL4wMkzFn3/DbSyhaZQid4IfwYDK3NIwOEga2ADrhNBbD2tgG8ppYNXy1MtzvFRDgAWuvOhYe+1b6BTqw8V//pc9lxMvmmAgXFVOIqGpzHX9F660A66Y4czadQvk/CMRd4wgo02MklFoBDn/RotI6LsEBQhMw+s0yvh0YF4eijyK5KlRTNnjaQb2cgdag5JeUgW4XIJI/aB4eVH6qW/YR4UaR4Y8POjXR5h0yfxd0uFY3Q/Iv5b5a/GvrRf3bB5w10dp3tll5VLPCJZH83wThqxdmlFEe+uGK4Cvu/KXb8KMhecxUMjVyxp7U8CYaAWEmf2EYKWd/tVvwJV6wd45xYmAJYOE664nDGzvHfxYTHJhPcgZU4YhHBWA1PckS5AQzO0YZ+9G+mMAcCe5sa+gwBKZ9j27hN5C8/DRU5qkgVAEt/7OzLEoQMM9bwpOAI6hqw604qJDVqXIpYgOyjLcHMb0+GBUfthxpHRVgXRKKos7AYPiRSHRnvzqn4CLO+ixaf+kOL5Q40oMmcKPceg9eSqV01jZWhRt5SX1vtp40HUKlcfY3Xlhp05ggKpWsYThkz0Ef9A7E79gR7K6w5ph9eFrCa1okUhfVup4gr9JxBFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(5660300002)(8936002)(2906002)(508600001)(40460700003)(82310400005)(54906003)(36756003)(66574015)(47076005)(316002)(15650500001)(83380400001)(336012)(6916009)(426003)(4326008)(8676002)(2616005)(6666004)(1076003)(186003)(70586007)(70206006)(16526019)(86362001)(7696005)(26005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:05.3645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9e400e-2f68-4493-601a-08da2a084657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1863
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Implement the suspend/resume routine of mes.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index d4e64c5a3215..d468cb5a8854 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -1120,12 +1120,26 @@ static int mes_v10_1_hw_fini(void *handle)
 
 static int mes_v10_1_suspend(void *handle)
 {
-	return 0;
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = amdgpu_mes_suspend(adev);
+	if (r)
+		return r;
+
+	return mes_v10_1_hw_fini(adev);
 }
 
 static int mes_v10_1_resume(void *handle)
 {
-	return 0;
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	r = mes_v10_1_hw_init(adev);
+	if (r)
+		return r;
+
+	return amdgpu_mes_resume(adev);
 }
 
 static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
-- 
2.35.1

