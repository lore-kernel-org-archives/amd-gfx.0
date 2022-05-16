Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F73CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 22:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A402510E38D;
	Mon, 16 May 2022 22:08:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9B710E46C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 22:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTHTJ86Xz6Scm7pkjRNERCndr37F/NC+Sg9RvDQAUgmrafcjRrqjYFBX1/nqQWmM5c/IcPIjjt57sKyogewtbJr68xsyiAK6tVh8FVfo38WMIJ09bYmw35AfMpbfsNsPN+StV3W3FY1rLO2H+RavT30Qmsq92vpIHWfpHXSqHTF+bx2WlTwoSmQPRGqR3DOHnTS3iOoQvIAe0ZeEiWUR02ZBzGztMYSljFGB9frqlEQY/OkIlu+LYZc2ng3MMlYaRViCxId+we+vkZL9//9SGiAgn7NvtJzgyJ545vWZUE26GEBpURh2KQfHHZytp+M8xe0WJVDoT67bPsoCj5Kv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ64XcNWiRdi7Rt7p7TisgUXswOcgStYXgDBS/xkiDc=;
 b=KvLA9LDTHR0pBjHnPjXQeVvkHYvS1f+Yfd+GTC13TFxSFWmNvR3MFuMaLLJ/Q05DqkODGeTfaxOl5IrEgPz8OSw23K6KzasHiwaF3EnSRnKLW7iqgTabb/WFwP9nnb8x1n/AEo2sZxecOwF7Pb0pzBTDrCYczX9KBaa+DY0mQlHYGyYOkvSjCLPrbl+7+awnbGMKp9VbkuaQTLrWL9JhFeub5A+q1nFq/NKvMgaDwMJKvtt1IaPbzVtcOTJF8TvrPn4ZhHWxs93HNfd0yCP1bAfuJYd9zhUUnBWTxP3yIsSdVreIdgtBr17rnA1BqRlZYuLMeZN52/kn0Box73HgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ64XcNWiRdi7Rt7p7TisgUXswOcgStYXgDBS/xkiDc=;
 b=vn6Mc2xyw1rUR4GMyly3vXEJMgKcPmunHJrknEwazP/QDEI0/fSuxp0gZl13RsIMKqqmlXsSuninYQQfJra7vT/U1Vf8sYLGNPzRQDk2DOso5InMepkdwUYFBRvowh68GqRfJLxRRlLlqkIOreub/yE/peH3M01TsSnynYt5gAg=
Received: from DM6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:5:190::24)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 22:08:30 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::45) by DM6PR11CA0011.outlook.office365.com
 (2603:10b6:5:190::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Mon, 16 May 2022 22:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 22:08:30 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 17:08:28 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Unmap legacy queue when MES is enabled
Date: Mon, 16 May 2022 18:08:05 -0400
Message-ID: <20220516220805.904291-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a87119b-4e4c-4b1b-6a27-08da37889c66
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43609DEEAD88ED80A5149C2A99CF9@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kZNQ4YC+ZsjkCt0/9TOcDeJ1Bq6/uFCrf5DCmUGxEJZLMhcdpP7gtZBwjJ7IWUUhS/h2acpLMI+XuQdlJJKBBnmKB9IIb1K43qakeYrsF8s7or6qAkDigD3VTlUOorL3bZJDcrKGRG1Og7yXzkG/+XzYw+c14luyWrN8V34pLgzHxTq9l0kAdt6lqH+Zqng5Vgj34iZ4baiHPUv1j7QKCH7FkvEdkvHQ/Z4BtWAmf014mLxCgq6VZ8uDd9X/bApOiZ5QQwp0pzYGB/RFUrGyS5adXp8zA5fGncaW0f2/k3ReLhEWLQkV50MxTpzTnYkR7XuMduesOsDpWL2B4Ia0lTszKe5/QLYBlOwT6vPc7AK46usVrfTNsEW0PB5CiN3qaGxb0wTBhrXE6+Vos4G8sAMwlBrmExfefjJjQpC4MkoO9Yad5VFWQ9XPJTstu5WsZoOSKQgZU3Sg7FWOth/98qyF7AHcIv8amp1AmNIzsOVC45uTrIjGjuvlouZ6N0yhTqihuFcLRpO4kX78t6+6MkCslziSQV3zjxfL3rWbZjyVT4xwteBqne32OOV50H5wSjoEsBoSjrT2fmLdpSoIUYEKzosQsuXtbzVIx04XCoevcqdsJ4ImtFpcUC9zXa9Bg8PceKfNfLgIEseX7QDs1BMKUxDl3opGsSp2mvH4HfiQEllkZ5XlKcUuGTDztRE5LZXg8BGOzwJXP/ofwj5PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(44832011)(16526019)(1076003)(83380400001)(6916009)(2616005)(186003)(426003)(5660300002)(336012)(6666004)(7696005)(70206006)(316002)(40460700003)(508600001)(8936002)(70586007)(4326008)(54906003)(36860700001)(82310400005)(36756003)(47076005)(8676002)(86362001)(26005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 22:08:30.4290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a87119b-4e4c-4b1b-6a27-08da37889c66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Kenny Ho <Kenny.Ho@amd.com>, Jack
 Xiao <Jack.Xiao@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes a kernel oops when MES is not enabled.

Reported-by: Kenny Ho <Kenny.Ho@amd.com>
Suggested-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Fixes: d69e773ca75b8f ("drm/amdgpu: add mes unmap legacy queue routine")
Fixes: 36d7a7094750fc ("drm/amdgpu: add init support for GFX11 (v2)")
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4b66b9c93754ba..65a4126135b0e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3568,7 +3568,7 @@ static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 	struct amdgpu_device *adev = kiq_ring->adev;
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
-	if (!adev->gfx.kiq.ring.sched.ready) {
+	if (adev->enable_mes && !adev->gfx.kiq.ring.sched.ready) {
 		amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_addr, seq);
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8a1bec70c71932..8773cbd1f03b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -191,7 +191,7 @@ static void gfx11_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 	struct amdgpu_device *adev = kiq_ring->adev;
 	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
 
-	if (!adev->gfx.kiq.ring.sched.ready) {
+	if (adev->enable_mes && !adev->gfx.kiq.ring.sched.ready) {
 		amdgpu_mes_unmap_legacy_queue(adev, ring, action, gpu_addr, seq);
 		return;
 	}

base-commit: 2092fd3ff7e91c9f408c98799f4cdcaa93a06c3d
-- 
2.36.1.74.g277cf0bc36

