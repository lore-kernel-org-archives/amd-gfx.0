Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB82BCDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 05:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E4010E05B;
	Fri, 13 Oct 2023 05:59:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A106910E05B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 05:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEo24CgR2tufU/+o9e6c3V9k+6PdG/9xrgXiQr0aviSkp+TTqpa4yf6bg7VWVsI1T2w+dsdfgrCXVxFJ/UJ/Co+Wpva+TDaW7l3ObvrjSiQPX5XA2DlzP26JAZddVApkoz/f2h4SYD+LHEziExLtV1SMrsuHWMzg+NvQIeL7arUcFW59ZQpvodsxdKRMA+aRYzCEEse91hCSBBXb8IPVlNTT3Zpv3/rRzzXjBHIpl28MWbU1JCVyTHGBfFp0weiWEWcd6mkooHzPj4VXTTqZv9PHibIM2MtXTAd6COsu6s/+umXtSrxctK6Sr2fqXlCJ/qltD5VF2LyBn+/o95werg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXpJfR/zu0rQnj1kz0K9fV2vQ0rhTSIycVSTj7+lnPM=;
 b=MflpZR9jatQd/KJIT7XyKCWKzcqLqeuIgHIXZaUbZaOeStiIZWWSkgZBJkvKjE8SuzI0FgeMozLt+4y4thmNYOQNE9q0sdYoS/8OQz9+c7pSf3EUoP5tLvAXsKPSuci0ZIqUBYvrjGj11CPkPX45KYB0sRnQpc7Je2IgwTB5O+k977cBqnplZNl+dhjXxByFtn0k4BUYCOvnIjVAaUBr7LTq65qi3JI9tweSmtJ5SLSnBWj9uHbbounie1lZrDPaXO24OdBO/09rdMmZ3/LjJWDD4had3uz0j9y18LnNWqKcFgOLLKBwUm0QZFAbtO8/CgpQwAh2arfR9If9x4qSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXpJfR/zu0rQnj1kz0K9fV2vQ0rhTSIycVSTj7+lnPM=;
 b=EhU+lHbMHAFMsgWjPrGhAhjhx3uuSdW/oamSeDCCCFfLmsE1RhRtEKPbZEQzBFgZFhasL3paGsnk+IKzKdo26Z5y4qkNt3+Vc4vjP8JdNPc/gDlIppIPHNL2dSK2cIdqyG0Iz4oGO+yxoveOlQt6YP4NI3mquZfh4BFAodhuJMw=
Received: from PR2PR09CA0001.eurprd09.prod.outlook.com (2603:10a6:101:16::13)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 05:59:27 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:101:16:cafe::77) by PR2PR09CA0001.outlook.office365.com
 (2603:10a6:101:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 05:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 05:59:26 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 00:59:12 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/umsch: add suspend and resume callback
Date: Fri, 13 Oct 2023 13:58:59 +0800
Message-ID: <20231013055859.37543-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 956ade88-ee23-47e7-058b-08dbcbb18e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /936ONe8dUL2oI6QC1VF2CbGvpq9yFA2kyMQn7rrZ9WZjKCf7W4sMqDnyi14lU7EAOEJabLEnyG7atIgS0GW4LKNkSj/m5im94sm03suvwVreqkk14TsGVsg/UkXVcgqXsmFOcwk8MmI7CCpJusl7a4ciz2MUFPCtIrM1YKzfRkprIr6deTSlUYxeXvqmerd0TRKM+u0yP1NNQWj5i418tQcCQ/2byJbMc77XnzBVfx4H3yuhOwGnb739TkvF6cdFwFa8Y97dotXNQy8/QuoyImRHbibHPgSSnSHGEmhj3JIGR9O5tfFCVrsorYV1wlMkVmpmuU09G2DPv1GVw9ed6Ow828ydyWOXROr76lFThXeJnXheVzyY2M7SqF93KD0LCNVyRUgFuqB+nEhjIO6JqhBqHLN9bnX79qSp7spuZ6ijU1GSHdzfEUlqOjvopKpAmzskdYWSMlvNcZwZNpchz/oTfWafWQzyIRHH0R7JjRVBju56kAXRcmN83Rv5H63xehEXBRRODs3B4IDPHK9+J9bLJP+Meon/J8BFeE20niIWwf7j4/ZILPCvPc2ZXrsitPUOCwsj51KlfYHP1q9FBk7tZxSyxGkxzZE+n1NYSrvDWNKCSLaHGbBRsUGaoZSzFZxA1B8vKEO6mIeg60fm6tzk12Akbq23kaeZuxAFgMP/FVjNo/jMDk6WuyJe3PDrgjQ4BEb8KT3sSPKOFv5bsmlJd0I74MYSdkzoJM1J3BSUP+SCdH9hhxO/xsCxAsIa1f3xB/crieT+giACd2puw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(356005)(36756003)(81166007)(86362001)(2906002)(82740400003)(40480700001)(6666004)(5660300002)(478600001)(4326008)(15650500001)(41300700001)(7696005)(47076005)(8676002)(2616005)(336012)(426003)(40460700003)(1076003)(54906003)(6916009)(70206006)(70586007)(316002)(8936002)(16526019)(83380400001)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:59:26.0609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956ade88-ee23-47e7-058b-08dbcbb18e5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772
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
Cc: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing IP callbacks.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 4bd076e9e367..f5fdde5181f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -844,6 +844,20 @@ static int umsch_mm_hw_fini(void *handle)
 	return 0;
 }
 
+static int umsch_mm_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return umsch_mm_hw_fini(adev);
+}
+
+static int umsch_mm_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return umsch_mm_hw_init(adev);
+}
+
 static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs = {
 	.name = "umsch_mm_v4_0",
 	.early_init = umsch_mm_early_init,
@@ -852,6 +866,8 @@ static const struct amd_ip_funcs umsch_mm_v4_0_ip_funcs = {
 	.sw_fini = umsch_mm_sw_fini,
 	.hw_init = umsch_mm_hw_init,
 	.hw_fini = umsch_mm_hw_fini,
+	.suspend = umsch_mm_suspend,
+	.resume = umsch_mm_resume,
 };
 
 const struct amdgpu_ip_block_version umsch_mm_v4_0_ip_block = {
-- 
2.25.1

