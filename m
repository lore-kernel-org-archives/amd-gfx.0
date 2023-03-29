Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD96C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 09:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF1D10EA60;
	Wed, 29 Mar 2023 09:50:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D1510EA60
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 09:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af6ko/OebCcZsCZ6I8xoCghQQJSYsLpbZr3BYeUvSs9GebHRiYdCEGAtid4ccOiKecDIu173i+6fnMbgB5l125Nbk5pBGEIkRL/eZX9TjgRWrIO5xV9zIvmfvbmvsDpDct9ix3Z/CfulWzV+mHk698ItmWeEeUZlg9u3AHdOcTLOCa0nOCNSZxLQXWE6wAJyJasC9sl5WnIdCQrcQ4v8MyLKabLLyWmttuPAM8DXHoEeYklxmpLdtFWGQByGvDd6TUPZ85A7lOeBC95kRv8K/wIJV9axKwDhHnlFHMM/DJIDICJu8oWRPQUM0HMLTUVLUPYKfTMvT5CU+LgH8eRhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c0zoLcE44A2fDnTEqDzMd0AwIgJVQn+1sqB3u0rVZ0=;
 b=Q9enqYq4ui0NhqvQ3ESv2VhSIh7Rs7IHboELv0DW9AMFmcO6LEuDpUpbi29W2vBpa0NMaY3xjVw2erVqrp017Zfw4gtxtLh05wnAVdOG5lKedJsd0CDTFsJjnluSdiGFpbndmInopfZVAdCCxS02SIupyNPKXFnkL322lpTJH4dHdfh+WSj0odTjUsmXNNVkhkjUaxxZ/UNCxGOqQ5LIHVFyiLbRGHPtsT6DbYWPcweO3MVusPaMainpiAVTHfalUfjHZuUKo3wtcQWQz1ZL8bq1Stb085P9FSQhQW42o8Uz4slya+E3tF3L5FaawQxgokJEC4Fxl8cd0LRZlaVy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c0zoLcE44A2fDnTEqDzMd0AwIgJVQn+1sqB3u0rVZ0=;
 b=TScx5rp0HWK0P7SgJs9bN675ZqSNCD2I4Z0jlyrXD5Mqp5cMcyXT0uQw/Sicr7bH++7zX9sjQVKArr3OEpr2T/0SLyLsgjsPBhAXcc7fqbdZUup2GmOtNNlwaj4aFVc6zI2B5sktaXw9QFoM12d0q8c8niQkBxgVExVTjfqHBsY=
Received: from CY5P221CA0082.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::9) by
 SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 09:50:42 +0000
Received: from CY4PEPF0000C97F.namprd02.prod.outlook.com
 (2603:10b6:930:9:cafe::5d) by CY5P221CA0082.outlook.office365.com
 (2603:10b6:930:9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 09:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97F.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 09:50:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 04:50:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 02:50:40 -0700
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 29 Mar 2023 04:50:39 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add MES KIQ clear to tell RLC that KIQ is
 dequeued
Date: Wed, 29 Mar 2023 17:50:21 +0800
Message-ID: <20230329095020.3417336-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97F:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: c303e935-2269-4948-3192-08db303b0f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAe+GAjYuy4IOk3u9Krt0djK2B9AkhJqNUBTfjiAftqZZXIZtnzgu/TEQ+TdoHJ40aXSEkkruPH96QugF53TWV3ZldtJ0rPU19St1ZMugbskCSqljUOFuQl/HHsnFL5zLi5Yt39EgtWsIPfRWwiyHw+Rd14AidBYGAWqjo0ezlffGm8JJqfxXRSbswFb8Jm0LbTBFhJWz5J+W1NBs3la8kWqRzJx08EEgSxOyWKzCEnWggp1ggOCSgLoKeXMtxx9Xxs+sSQ1ZMLCCsP4PrUuewszJHnEOBqFh7B129pJKbN1bftvNZ7J2jnA/ZD62VjzsPoCJP06GahF2ZtpfnUzW3FM2ZFPp1jpBCClp6o2xlKS2UphjmW1JrpjgtXzoZDaPYF2Dah+S5ZjPZWf+98aTjPiiHusqmLheTvmo8ymTtaYMmIwR0pG/sbtw0KpgPjUwGbAIeesnab+L1BviBEcxTqmM8a/o1ABBqyOsMeT4R035fV/XXmDqZjn0BabeG5iItchFSpCJl1lzcLK4PFUp2N/n5ndisOUzqpnS3ZOCzuhXHGYXkvmi214Cjkjb934DnhKQIUypiiRxl3GKfWa7FGAID6S4tFBke1SVu/VSS2qCpfhQ/aLQUCtWs4SYlEJCJgfHi+RQCI+o4aYDm7ZToDbPx0P4+RWFdlIjStgQ2y5gr53BAXnlmEbmjcK1xagR9TzxW27ZYqsUp8YZzjflBYG89lvW6naI6CYCat2mwali7/Iu2YKbE6+lEoKpB5e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(26005)(82310400005)(2906002)(426003)(86362001)(83380400001)(36860700001)(40460700003)(336012)(2616005)(186003)(40480700001)(8676002)(5660300002)(356005)(81166007)(41300700001)(70206006)(36756003)(8936002)(82740400003)(70586007)(4326008)(6666004)(1076003)(316002)(54906003)(7696005)(6636002)(110136005)(478600001)(47076005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 09:50:41.7328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c303e935-2269-4948-3192-08db303b0f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
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
Cc: Horace.Chen@amd.com, Yifan Zha <Yifan.Zha@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
As MES KIQ is dequeued, tell RLC that KIQ is inactive

[How]
Clear the RLC_CP_SCHEDULERS Active bit which RLC checks KIQ status
In addition, driver can halt MES under SRIOV when unloading driver

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 6e97c28e3162..2e95b71fdbdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1138,6 +1138,18 @@ static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
 	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
 }
 
+static void mes_v11_0_kiq_clear(struct amdgpu_ring *ring)
+{
+	uint32_t tmp;
+	struct amdgpu_device *adev = ring->adev;
+
+	/* tell RLC which is KIQ dequeue */
+	tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
+	tmp &= 0xffffff00;
+	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
+	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+}
+
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 {
 	int r = 0;
@@ -1182,10 +1194,10 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
 
 	if (amdgpu_sriov_vf(adev)) {
 		mes_v11_0_kiq_dequeue(&adev->gfx.kiq.ring);
+		mes_v11_0_kiq_clear(&adev->gfx.kiq.ring);
 	}
 
-	if (!amdgpu_sriov_vf(adev))
-		mes_v11_0_enable(adev, false);
+	mes_v11_0_enable(adev, false);
 
 	return 0;
 }
-- 
2.25.1

