Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14750C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 19:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FF710E102;
	Fri, 17 Mar 2023 19:48:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04AF10E102
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 19:48:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WULm2686kAH0Yy+1XSfLC92Ee/pq6Pteutu1suE66zELpra6IG1sC1KzRwtubfEkYbhJl6v9lWLEumb5WMbApvRf6yNZdVxsG3+uvlFSTRCda3OdnB1FI+cZWhyvIcmcfcxw4qpBuqVEwvE4WX9zKT4YMjQ+T6tk1J4z4BJAaQqefFaKrPGHLhjOR1OzMgGP/4Di3plT8AURnTlpMyy9To/JOzCnJIEqFrhsn+SuE+vAi7awsYvcoIVNV0VjC54dnRCIwpPQyn8Gz5UE/BXSk3c3LpyW4lvlHBJPWBTVKzaSaZIpKgFhydZweMR+Yi1nCuEHOVfanKMt74mp5Js58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwIsVyAaDP6JSY+i4RwragYM35NajWMjqC+hDH3Hv4A=;
 b=F6JuKXl7aSo0v5WFtaGzu8n3ygeHK6YUc4kovYIZwGoOJ05FQ8G5yPW47TTCBc8Pp2dRKk61RmmAqxg8VUFyBXT4ij6mPbXxda4sNqHlhZar94GKr3ZRT+Ppzjt34oyAzQqsXJj27Jyao/9WGmejGqR9Vh2UkpbSTG9mKYJraNgPR0F93AFBSsd3IVXq8rX5xl8M9kTRj1Qf3NqNgGwJ55AO7lDLMSstwCfHz/aFPKTrvktKyu93WVKVlzArPQZzU5J8FTvfdg3FrEA4sOYGj09kz0L1dvypEuNh0gTvlzw+zUDYT+VvNbJMDtXbuYqPLg+0UzUhrI5/cmx65q+iAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwIsVyAaDP6JSY+i4RwragYM35NajWMjqC+hDH3Hv4A=;
 b=3/ASvr7nnKZSuQC2FWM3LVHbdcZZRD9PTlxRrZjJieUZ4AxLWv/51hP88D6q4zlpjZdwQM63iE8g94dGMsKuFiP483Uyh5X3EcdlmgTkkAD9Sk6k7AraT2sev70TaPDe3wvdPJvK7PYzDM5oA09vIsO2wGfRpOi7A1Ink/wx71Y=
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 19:48:34 +0000
Received: from DS1PEPF0000E64A.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::62) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 19:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64A.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 17 Mar 2023 19:48:34 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Mar
 2023 14:48:33 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add print for iommu translation mode
Date: Fri, 17 Mar 2023 15:47:57 -0400
Message-ID: <20230317194757.1336098-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64A:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe41ee7-0238-4e18-6eb9-08db272097e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuvTAdBeGWzVGhay3Fxhjs3pib3CFAMiE07bCMtyPTcKUJd7uVssGnIMufozFxX2cVgAoMb9pi6FSqN0hZBmVxeH3JyQem1tcRVtg8rFQu4cB5QHesOiutO86fT+2xtvyIrsf0Sax1XMJilHX9Omst1WAzJFEj8qXlZKTUqtbhD3CnhdVcQXdkM+JMQ4PBZxHGuVqqoO1n34X0c6rYmRklB0ziPhf7o/MNHfRQvsNpmjAqRHeZWpxYP4VxzOBO87SmYMlIcAV3S6l4P6AQKflmNr3oHY7C0M/Xy4bdcB6HqeDKJVXEuG9C2xcj8em+O5CZatTjGqEO88v+HAFbtRZNZpjUxIn1q1aCmUlRCDHwuX/vEWfkD7ek8RXWbIHppMGV8zZQqIoslRihrzYhPdIybYpQ+JMHsVz3zSQFnEkekraYDGeOjaVHVTepuG+h/Dkv/FrwiFFelQBbc4eztDSGZlhSDcbJs1R9byv5Eyz6q0a/bqhImAR1eXAhE7V4mAVcqMunIgE3CEZRk8jLUzbEth8ipIz8Gj1kOqwC3g7z5aTNoLXWccfos1Nvv1OgqAMMmAcOMoudKsDvn5dV77uu91jwAEsCQRPbaKoigleRRkizpj6gT2jW14W52faZWc50EL9/SgbHywR7fvkYme3tYAbd0ExPHXcXbPXSD1p9YgGUHJcVQcPwSKDB7QddpDDJ+bjOr0kwGjqEj1BQzqrVsriQBevxymiYVNsQblT24=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(47076005)(86362001)(426003)(7696005)(82310400005)(186003)(2616005)(16526019)(4326008)(8936002)(5660300002)(2906002)(6916009)(41300700001)(8676002)(4744005)(70206006)(70586007)(336012)(36756003)(40480700001)(26005)(1076003)(6666004)(81166007)(316002)(40460700003)(82740400003)(36860700001)(356005)(54906003)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 19:48:34.3370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe41ee7-0238-4e18-6eb9-08db272097e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add log to display whether RAM is direct vs DMA mapped.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8bba5e6872a1..8797a9523244 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3528,8 +3528,12 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
 	struct iommu_domain *domain;
 
 	domain = iommu_get_domain_for_dev(adev->dev);
-	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
+	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY) {
+		pr_info("RAM is direct mapped to GPU (not traslated by IOMMU)\n");
 		adev->ram_is_direct_mapped = true;
+	} else {
+		pr_info("RAM is DMA mapped to GPU (translated by IOMMU)\n");
+	}
 }
 
 static const struct attribute *amdgpu_dev_attributes[] = {
-- 
2.25.1

