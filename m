Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4913C5AD4C
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 02:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553ED10E21F;
	Mon, 20 Nov 2023 02:49:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4618E10E21F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 02:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCsUiGLAVbHVMDb/ph6RsZL5bG4aMVYuEPTfETi4XRqOA0yFiSGj12h2ynVEfq/tIGx3oR1LC4ZGYA6Em76AVO59Zz1lUiIff9KA8NrG4gPn1z6ACmtCUMPoTySgM/F16MthyAwJ8K2/2r/20WFI5I10GDYh84LGoXC2sHpVc92BseAyiCfH9mTRhVj91Dt9QTGUtVMF/ml+KhuB03qChKip4jhhntDtUD7hDZ4b6143imCpnRHuDx/8YCZHV6pLDSqSkbppnoHZ125GL0uBrkhhAYSAdADGJDHL6NQSACQUZjTASsaYSyUoiipA2uYcsndMGCURLdOINq2wseFRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7iN9U3Hc/jrEy9RUFxWupKLKlkuhynu62OK0O87deU=;
 b=VrtN9nc8kEUwlzN61pW+hhAPmvdX+xuw0On2mHtLlQmIkESlwtaYwMkGNs2xgfpdKK4TYlrbIUt3dwK8SjjsRQnrqovFIQrycgml4Z7UoSCOfIJwjNAOwp+0HRl5emaL4mH6J/8lm5M44BejgyO0QwBWuPAtD/pM3w39Oz4Lo3OCLKPlax0avnEDz0jdMDl/OWf4FiKyl65FVHteKNkyZZApDfoImKht9j4I9g7qVmLw+nXcqJ0cd0hQ07WTIs4RFQ45EFLouFgOWl0Z/lXC3zWamfGlooVdFZD1rSU2rRUhbXoQBpGwyBHnDOUYQ7JX174c1wXSFPrwodAi4kAu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7iN9U3Hc/jrEy9RUFxWupKLKlkuhynu62OK0O87deU=;
 b=qUJ+/J7TyoM+VCC9djH8/vl4AJ+hQMdHmIWwjgrUwivjVZYC2qtXUMBWoLhhAI/6LpnZZR+ybN+mSVRnTopUY7XCkhdVtiSckfUiaFPytEQv0w9/FJ8LS5Vl/xYkiaCdSxGo3WdacEFv0q0BuYUvb8jrJxYy/PQBlAtj6jkNgbE=
Received: from SA1PR02CA0003.namprd02.prod.outlook.com (2603:10b6:806:2cf::9)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 02:49:40 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::67) by SA1PR02CA0003.outlook.office365.com
 (2603:10b6:806:2cf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 02:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 02:49:40 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 20:49:38 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Stanley Yang <Stanley.Yang@amd.com>,
 Candice Li <Candice.Li@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Update fw version for boot time error query
Date: Mon, 20 Nov 2023 10:48:55 +0800
Message-ID: <20231120024855.27697-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120024855.27697-1-Hawking.Zhang@amd.com>
References: <20231120024855.27697-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2ca72d-a1c4-4bef-a7f0-08dbe9735779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deLWH9yWxoS/3c21H5Y2NwB91w24CXn2q19sAoig/+YZrkaT8bY08kRIdnmiG6FmC4THs5LdsJV80OGU9j1dDOlVfJckxaTKEqhQurszdk7kJ0p0xo9zD+FieIfyuK/AGX007PltEL5AT78W443U5aReILd/kUAgz61uaQYkHiDwcjbcBllXawA62s5U+rvJAMQ64qpEWLQbAzraIO5bcel/six7PuhTfK52eeg1UsghiZ4eyKGUsUvB/1gf1llaI7qQiAFpKfJGiDWzFf7RLag4T5O/JYrsRe27uNtxBK09DNDxTmP3nhotNQx+VQKWhAKEBnYJanai8QdknOJ2ADdKBcEgCHLmTJuKeeJAqXtnappIcsFqm2NZVAQRkAsucXhIP/EkxnwiFsV7tLXZsIP2yt8kS93eVIL+AjLykQoyP48P8BTUMQT0Q2iXn03WHtty5WmHJtIWpIz4q/2ZRdN8eNQ68KQVJWfofGcga7ff0xVsKejhLD3gWfWBzgK7nnPLAzHE2CoyXCfuyOdU8u+tEFDhepsI0dmiw/Y4kbXMCD/YFLuu+U3IoqNqjITlJCt6WOH1e7cVapdfSokYmzWv+YhkmqK8uRgtB2w2CnQHWtoZpNUWO1oYrhvWpk7NL4yxkMVQiNQye+zsxfTKtDExjVrlYVTaOC6IAQ0gRQHuP5G3Y/oOp2suZyQ/HNPaJUeytRRMv2zTlRh5QdJGYBvZqCFKDOzcqGo3TB2mk6o53a0TgENSd/ECGzRlYgjPNNxj2SNLiznU2f8lknynTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(47076005)(1076003)(81166007)(2616005)(356005)(7696005)(36860700001)(40460700003)(336012)(41300700001)(426003)(83380400001)(16526019)(36756003)(26005)(82740400003)(4326008)(8676002)(8936002)(40480700001)(4744005)(5660300002)(478600001)(86362001)(70206006)(6666004)(70586007)(2906002)(6636002)(110136005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 02:49:40.0533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2ca72d-a1c4-4bef-a7f0-08dbe9735779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Boot time error query is not available till a10109

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 3cf4684d0d3f..5f46877f78cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -821,7 +821,7 @@ static int psp_v13_0_query_boot_status(struct psp_context *psp)
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6))
 		return 0;
 
-	if (RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_59) < 0x00a10007)
+	if (RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_59) < 0x00a10109)
 		return 0;
 
 	for_each_inst(i, inst_mask) {
-- 
2.17.1

