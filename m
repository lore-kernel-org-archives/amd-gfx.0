Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155D9C67871
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 08:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B8810E0F7;
	Mon, 16 Jan 2023 08:21:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D199410E075
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 08:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXOxpIP4Ql62TzcMo4zoXSuDKvtKL4QiqEhgLGBpwGaO644d46e/rd2JFuSbYNQIiZpuY7WlYPvxjyIZxBNtMbmP78HnanFF8I8vxjGkalHfBfvKvW5CkXY3YYW0hpdoyfherIq8S1OpwbOdPIgwf1VrC4biADFyOw+gSDDHaiPSXkoCPzC256lKB9l5uM0d3j0m7vDud/CxFf7ILxHdTSxPtF+r1woDA4eSyYbMR7R2IOX1LM6RVIGBTFfFZydiv4RbmG3oym2+kFmNu6ET+pjid91oe3lybs354w0iBjxuNvRTjEEy7pERgHL1Eu7JLV9FxVtkid3p+f+RSqr7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WygYsPoRu0gKkMAZWa4W8g3jtRpVvO6AIb+jyAxiiI0=;
 b=UuW01EfRZzbc7DEloDo2voMK8QJfMebUhjlKTgBLPZaFFWaKP1QrX+7LD5wC6wGHDqN2Nsnn8Tuq0pPf7JDjJP1+opARpah/Hr8yAn3TeyUPoi+FaJx/ZUptlmwhv22lG1gNBbRFfG9zHFHo4lPkq0EfTClYCX30qh427DMNSRiGbUNskqQsqYXd7W13R+jbkCfvfbDcrc82vbPV/2jiVoWkGViQJl/pLiS+D1KrXZBg7zlhNVK5v+9icFYvtq8iexvTcSTuZOe7/rvZXTa3iMG/iTqJeYLTa6wE7O5i0UC5JCf7XGb83Kw6K+HgehH9CGBUrXzZFe1qjBZJSWf39A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WygYsPoRu0gKkMAZWa4W8g3jtRpVvO6AIb+jyAxiiI0=;
 b=WNEUyeitNtkGVLVwW2LTWWsh6VeyZrzB8Xfgn0OHI+XIwZ1L79pz1D1Bl9ZZkVmFujND2TrWvjj/ySPFF0jeS8VHKhD27m5FaQzR2MB4HEseGv8F/bExazQKXF1BG7xqP7zBZ5A2G3rf5sR95+v0OTk6FyAst6yKDkT0Y2R8r98=
Received: from DM6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:5:134::24)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Mon, 16 Jan
 2023 08:21:05 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:5:134:cafe::36) by DM6PR13CA0047.outlook.office365.com
 (2603:10b6:5:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Mon, 16 Jan 2023 08:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Mon, 16 Jan 2023 08:21:05 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 02:21:03 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: correct MEC number for gfx11 APUs
Date: Mon, 16 Jan 2023 16:20:25 +0800
Message-ID: <20230116082025.2188409-2-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116082025.2188409-1-Lang.Yu@amd.com>
References: <20230116082025.2188409-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bda71bc-69a5-47e1-aea7-08daf79a9ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oibRyYDp3f+J+aiWBXRwzABH3PtyP42v1mBML7WihCCm3mGXh+/zmiCBVa/0uk/64UFdyJjbT1girr9hlcLt2ryG9J7zwKy2Okf4vIc5klWU765xmbH8opIhr/LUb12huK0EVya1fW4q7pBvo6VE87ngQQcJYjVX85by3w5z6OFzAu3sWo0Dc9EltsXs15uCGlXcSEHqdQUlAgXX3wBEvID0vcirdp+zTRmuvVQ9bhEuwz6QKIAxWOqAhPZR/rFnLUBL4S6aqncikeC59SWzFDqbr+ckGWy6+xFhCTRffugTRDUqPvuKvbozy85a78ae5zWv74Kkg+P3CmDPOsr6FdXnnHL1EvE0HZ33iMvgwgf20RgwIrzWNfxFr0Wggb503ErZomyeYiQ1EITrlk6Vx2GovPItOCLYK1QIl1VLcCi5Z6MOZVhoTqsyJ7QAtdZQQTSl4YxES084Le7luRDtLS8rMX58BctEBZTqRcoAJRVhodJefRt8qd0fQSWqDbPEdb3wt1/pg4uL3QJMQHxiNKStcnXtAc9JOLFAKd/SwfW0j/rvnlMbfXFCn2GEQqD4SPtDUvb6rAOLntdBK2tiAuOg+1salE3vITypybzvNyKTj3I3KgoZ7FQhQEAhHvHbvz4uT2fVBvEQz6zElnNfrDx6ANIer/siLcG3qwfpnx7a3JQffYoIRD2Xsra9tEh4xONMomo/HrL4WflNa9nQXQ0AJqkhYhq3dbF+/uqx8Bw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(1076003)(2906002)(2616005)(83380400001)(47076005)(26005)(186003)(336012)(16526019)(82310400005)(36860700001)(426003)(70586007)(8936002)(6916009)(8676002)(70206006)(82740400003)(7696005)(6666004)(36756003)(5660300002)(54906003)(40480700001)(316002)(478600001)(4326008)(41300700001)(86362001)(40460700003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 08:21:05.5411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bda71bc-69a5-47e1-aea7-08daf79a9ced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is only one MEC on these APUs.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 985fe704203e..dd4e0f337f46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1251,10 +1251,8 @@ static int gfx_v11_0_sw_init(void *handle)
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
-	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
-	case IP_VERSION(11, 0, 4):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -1262,6 +1260,15 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		break;
+	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 4):
+		adev->gfx.me.num_me = 1;
+		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.mec.num_mec = 1;
+		adev->gfx.mec.num_pipe_per_mec = 4;
+		adev->gfx.mec.num_queue_per_pipe = 4;
+		break;
 	default:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
-- 
2.25.1

