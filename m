Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FEEC77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 13:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C359410E179;
	Thu, 27 Apr 2023 13:19:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33CEB10E179
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 13:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNbKjzNGQqTIK4IR4/rn0Y43L9Notpt2rZ9xPn6q3snkgPZwv6cTOJ5NlHZdrAIG8rSAPHd4uP2JTjvMsgbjmqpLDMIcY2UWKJ1LedzOahSmdg1kfuBP5pKzit/8H3r5FLdV143ghHk0EqLC5NhuS4L9GHYJQBtDbRmIhph1p7rBC4oVnIaTaCmEWd9yyWpNrvZ/21V3n7NiU2pxa6xC41WyOffeSq/81DtppFFunfAiK4tDOX/00Ln2K6eG76OowR6nxqylXgqvCnfRKzACaYONnO/h8wOq4rWIBip1/u4Q9PDnGtEtuZ01bsFlSRR+R11B1Bj3JDl2BIwE2CWU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7JPWj89jtzqmocnXUDkyC3azF/NDre/o54BFdmfFkw=;
 b=SH6dX5pBCGYJc3eBjwi7wYzXjz5ofbDxauQ+I8PflYSkBJlbgqVIHkhnc0EfaOE/FxQor1ZK+XN9zZ4XiruRdudrVKaR5xHe6Fsdy9NhFm1FfCr0rLH8ZfJGOTa7G2wJ6InLjMYmSbZiUUk3dy5B0HbaVvU1vVGm2iS4Q6YlnG72/07oder9MHeGYQ9fZCM2mWOXXdyO7TtENpynjFn9NVqjIXjML+D4FbyaFEquJzMvCiEa1BO90EqhTpBy6MQo82+bEHp5ltvyOzQ29sIw4q11ng9IR8H+FgdGSrbnMCR33xjr3ElzuwVsUdILVJ68lDW1l7MryZN8WVyRBXedVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7JPWj89jtzqmocnXUDkyC3azF/NDre/o54BFdmfFkw=;
 b=Cwj9Ln0ZBjeQLo6tdNGlqKgzGmFK6PkRR1kMwiVYuodBqTB7ukWHG+5I8eEp213VulPeJvce88mBuPiDsieL+KFXP0A6HHIn0HE/qSyF+gkrStpHbH9TIMJdBXNDLPXPi1Tgj7+TjbRKEUlpMrD/76YMSn0vTvC0aL+EtRXM9h4=
Received: from MW3PR05CA0005.namprd05.prod.outlook.com (2603:10b6:303:2b::10)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 13:18:59 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::75) by MW3PR05CA0005.outlook.office365.com
 (2603:10b6:303:2b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.9 via Frontend
 Transport; Thu, 27 Apr 2023 13:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 13:18:58 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 08:18:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 06:18:57 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 27 Apr 2023 08:18:56 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Add SDMA_UTCL1_WR_FIFO_SED field for
 sdma_v4_4_ras_field
Date: Thu, 27 Apr 2023 21:18:55 +0800
Message-ID: <20230427131855.18902-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 434c19f3-120f-4651-ade9-08db4721f604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nsKFvt8g8Y+UqxQT1M+xsmGtTk5Bn7pK0YQ4Xc1KRL63UtfKeJ6P9XB/tDDNHFo6kPYUgyx1IMb1dFXhnOFKGY4mzclKdpUdiwljrJmT2myxlDmlfDXG4VjseHNWmOIhGJuH+WDvHCEW9B4JO4JouLwLqw+7ZMwg9bTxcdrfq3QgckZbatrDcn1erLy+uFekxlk6vXp62d5Ek3Mox9s77WHl/F11Q9pQ18pfyk/yMhow6TJkvQaLJot29vSkNEZgufChFF6LRQY49mPc0FN9eM85hCTTbv8weSy+BOHj1e9qCYi5hBWihdI5m30Ra8ebDQKN+GeazRs44GJ4SOa9jNx7jjZ0lagPfE2SWQ8r0VGKawhgCqLRPOq/qZFlARwM3GvQBN+bNMCvTixbnxTGgWfy4ak1xnMBa4hg7AlPWjJNTOCCLZmMukUjXIFkObaru+hg4Fh9MP2tgygRKS8FkbvJggFpaj3ThCak7kdPdcstcjxOdQwp6/MJ+Ziv9jiNP4RYkrTWfpsKCJNmvyzDh31HG/gLpMMo8Kaytn/IRwyi8jOTK37EJJrqutk4/8mrjL8NWbXgBIKmDkFPxnPNMcMyeraS7EOezlc8rgR+BhPbIMqRknhpGRcLpH5xMw1Hg/FfeuMhfj3JeC7K3sW1DoE1GN8MtWK023kUiIf/13pMKOiLVjWhI8JWVK2JaX8iwNYQZozMUpzWjafiSn/1muVgV9JlFcuC6qWDiGTNyc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(4326008)(2616005)(316002)(6636002)(70206006)(336012)(70586007)(36860700001)(47076005)(186003)(426003)(110136005)(7696005)(478600001)(81166007)(8676002)(41300700001)(356005)(8936002)(5660300002)(26005)(1076003)(2906002)(4744005)(36756003)(82310400005)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 13:18:58.8645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434c19f3-120f-4651-ade9-08db4721f604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index 6f9895cdddb1..0ddb6955a6d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -141,6 +141,10 @@ static const struct soc15_ras_field_entry sdma_v4_4_ras_fields[] = {
 	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_UTCL1_RDBST_FIFO_SED),
 	0, 0,
 	},
+	{ "SDMA_UTCL1_WR_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_UTCL1_WR_FIFO_SED),
+	0, 0,
+	},
 	{ "SDMA_DATA_LUT_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, regSDMA0_EDC_COUNTER2),
 	SOC15_REG_FIELD(SDMA0_EDC_COUNTER2, SDMA_DATA_LUT_FIFO_SED),
 	0, 0,
-- 
2.17.1

