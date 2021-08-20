Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A9EC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 05:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DE161042
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 05:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3DE161042
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A7D6E9FA;
	Fri, 20 Aug 2021 05:33:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBA36E9FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 05:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FleluCIgqnCbw+yOzZR3Z21q73KrF1cH7A+PTk0A1G+sW/3Q/5ZGTFFZGjeqpuiiMhAnJU6kGBt0VO/Ujvexwd5PkiFlWd/vTyVINHFLspwyzgYqv5xqQqe6n0FrKT7/if3M2x8eGkdSj495QmuWhG+4vpMXsDtxhKLKxppz9E0xgY3KMfolVxmxbo9SY1dEw2PglcLJkQ8d0glluxQPdlUWkJiz72yPwg1xx3oDidopQf/vhGvotyj1l3sOdjwYFr7fnde5ci1FLjq/4TRpcZkDpGmeJcYb1yK2B4rlmoI/3talJwB+KV2Y53A6rLu/BSoVAssKEHyManDzCtgCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hvx6ATG/JeNC/CNFv+rZDFQHlNL3oTdXaBLU5WLM0U=;
 b=DD0gwehV7b5yYyXZBI0zHW5IUrSXuBUTDuYlcoX+Torjmp1Cbe/t5lg+JdErMNk2SU2Z7j0Gt6djJnqSIXfbJ6fIlsAvkLI9y5HFbNfI0RXPPyuDkHwslLJtrwAReXzL9UbDI2Hlv/g4pgxWSXyjbmEmmQ2WszxRvlJcKzlLO9jN/Y7gnUV9vHejolkoshDWhjOykQYtKP0m01Wnff35nZjBOHxAk2oxu0VqClqwe35DjpZcrcnteuTNrOixHGVH28CRmipj/ahohKjWp+KmJmjayNkISrZrw8/dAaTAjwc8RQd4lwmTrGsri8xvE+Nq16ZQ8pfr/AJ3WAEk5ZnVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hvx6ATG/JeNC/CNFv+rZDFQHlNL3oTdXaBLU5WLM0U=;
 b=bhKxVBl03ppIhp5IPfCD3ld5tK7moQtsY/zixelkUii7vR29gOF/x9NyDOLP1szOi0bQ1U9bSuLpNQ5R670+PPIMHHLGVCcl4bQPhzDJy6yNNVymgO0ZhQCJgugapq88j5NhN52CbXINaBfsdTjh+FN2oRAZ1C5gpWQ6Q4d2tcA=
Received: from MWHPR22CA0067.namprd22.prod.outlook.com (2603:10b6:300:12a::29)
 by BN8PR12MB2996.namprd12.prod.outlook.com (2603:10b6:408:48::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 05:33:06 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::e6) by MWHPR22CA0067.outlook.office365.com
 (2603:10b6:300:12a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 05:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 05:33:05 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 00:33:04 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Joseph Greathouse <Joseph.Greathouse@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Use SDMA1 for buffer movement on Aldebaran
Date: Fri, 20 Aug 2021 00:32:44 -0500
Message-ID: <20210820053245.340945-2-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e51f3ca-ae49-4afb-9562-08d9639bfc6a
X-MS-TrafficTypeDiagnostic: BN8PR12MB2996:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2996FAB97F1A8DCABC067006F9C19@BN8PR12MB2996.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXVfQvNABM7YyvfcAGJdqtHI3py2uOy918Dcrk7+RAzv+h14GlQkgdrfYC/XDDRwK0Otm48eVBK8ppGAKMBjoSaLV1frFZ2xQ1x1qGNbWB5SXx8Ourm6DqRFOhQR4Z6mge7FI25CUA15jO0SSFBhTTNQLRuLmufo2j9SfMWfyKlCy+r5sol4W9D4Rbgy87vAzbHJHZvJTNyUIH2Sn6V14Mt7awEnaoxGlR7dF7KiM+pFKKKTwYJ5Jg6wXWo0y0pQF3NRaO5lT1CF9pnD7JRUBUY1aHjGUe48ZAMUlSziV6Lk2FxC+4Nytbvcn8yH19pLHje9HYcdB9WFTq7m9rkMMyb5zzB3OJ+mFE7PMKY7G/QYqiUR61UcYPXg4IhrQ3d+7zMj1lH6Dbigdq56v1uKD3vfHmgtv0+PRdgH2SqOO1ZQ6YigYek4tmb8XgD7ZYFi48mRZARkOQkIGCFbyoDCqXbnLW1uULYKtrGiEGHiLNUtwvhEEW1F+bDOhbgd6zS+mZEyjkPv4t7dmLMToU+WjbCZNRyj89ns1jMYHZyfy5o9mwSohlRscMn+ywKisv6MBgTbXm5sBfSPqvNIqXjU8BaUaIRRF2Dq74cypAv1dvpuP2arFV3PcWWjTO0Bd1dkWaHkykK2hpD+QvKxNssHOcafSSgac9XixsIusGs5yzKWZAL2GuasG+lX09oBPUFsOGvXwHtiDDYIjzRVmEjP9LccjbZmT7EQliNcuocd4pAtf6D+Szr3yaGDy4/a0GrMUCVj+1vvThEgzdud4GlSaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(70586007)(82310400003)(34020700004)(336012)(36860700001)(1076003)(70206006)(86362001)(83380400001)(2906002)(47076005)(7696005)(36756003)(426003)(8676002)(4326008)(26005)(2616005)(81166007)(6666004)(6916009)(356005)(16526019)(186003)(5660300002)(8936002)(478600001)(316002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 05:33:05.3901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e51f3ca-ae49-4afb-9562-08d9639bfc6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2996
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

Aldebaran should not use SDMA0 for buffer funcs such as page migration.
Instead, we move over to SDMA1 for these features. Leave SDMA0 in
charge for all other existing chips to avoid any possibility of
regressions.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8931000dcd41..771630d7bb3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2689,11 +2689,15 @@ static const struct amdgpu_buffer_funcs sdma_v4_0_buffer_funcs = {
 
 static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
+	int engine = 0;
+
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		engine = 1;
 	adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
 	if (adev->sdma.has_page_queue)
-		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
+		adev->mman.buffer_funcs_ring = &adev->sdma.instance[engine].page;
 	else
-		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].ring;
+		adev->mman.buffer_funcs_ring = &adev->sdma.instance[engine].ring;
 }
 
 static const struct amdgpu_vm_pte_funcs sdma_v4_0_vm_pte_funcs = {
-- 
2.20.1

