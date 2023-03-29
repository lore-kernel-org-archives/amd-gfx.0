Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941C0C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4E110EC52;
	Wed, 29 Mar 2023 20:26:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB5610EC5F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQpeZvXKpbDVja2n+yWLXHe6FNmeOZI8p9lTRwbjBwfT7uqMV9M4CljCK1bkh8JN7Wy0oGmBeF+iOmYCVPGhU7KoMoUD9vMl2tkfezz9dftb6SZnSwz6322drqCCYveZJO7dKMs5xdr5CvpczBUEP/vALY74ScmFzeCQlveWIHKUvl6/+6TKLb5c0FEGRXK9gpXVl5MtulnAKtkbM2wB6h8zj2VGikbPZ28juXd0tltaUh1x+YWMgSOcHTXoC4uN9uMI5qc05/y7xBZ4gZuUq/KFHzVZWgIA7rSrM7DEgPSbSwASqRfgPhlnaR3/c9M2oM5qR/G9jtaK1spjomqioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmytgUyhZyTUh9x6z/Au0Ddir/wgeFNMnPnp5UTvyr4=;
 b=R3tseTwtMsmYRzs6W3BwXEz4vV69F2i8Ez131pV21PCnGMWCqsmRpWLisiz9AVijNccAN5Umu25zDaEroMdnN/Ernk7VxTFDCH6rRviXAD3DS4aFPu3JbbzWjGnuklVr8K1DGhjjet7/xJqYKjXWmN5Tjy9uYen8wVeA3ExFPptk3m7LM+OFiW+1AkNYsEWq4GTECWXazgncZnxz1xyeIahwDsVmV/a/wRBXQzbHVqOODoxyNEiRNdR3g0eUepBSsFyDZXjRHu5FaB3nGl1YPtst36cEkPverWUWC2s3P1wjnNKWSVC/D4sy1xuQEKnNTdGHx9otqm6N8Acptwr+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmytgUyhZyTUh9x6z/Au0Ddir/wgeFNMnPnp5UTvyr4=;
 b=wsdwgrBrXRVYH00EGl4lLBcyqwlZTTJXvufrPy/Rs1nixccVaVIwVDnmldE0RwW2mI5sGKSKFNE3HRxMjWbGzWX0uhWvSdwJ+T3gwHIQOuJXj1V88lCzXJw3V2Fau+Mc2GQKN4nJsikdST/JX5Khx6z3zdVFkmUYQ4dPRjJZMKE=
Received: from DS7PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:3bb::22)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Wed, 29 Mar
 2023 20:26:08 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::31) by DS7PR03CA0077.outlook.office365.com
 (2603:10b6:5:3bb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amdgpu: Add SDMA v4.4.2 golden settings
Date: Wed, 29 Mar 2023 16:25:46 -0400
Message-ID: <20230329202548.1983334-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: b43524df-a3a7-427c-aa55-08db3093d43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3QQrQRB84F//01OzGrrh/UeSV5jcuuGl3tOnnYYjTx6VRoKjctgkabFC0y1sysidHYLcD0pmLpDmmVZDIGCLQ+R0tECGGDbioN3tk5pVBQ/AiWftG76rm3VH2TTduWMcWzzjFtCKVaZLgzerthwluNMgnyNRdMAUroL8kJRQoQoF8QmTf7vuMUg0QwfOCpbRKWRdjJsK/NZyxtZ/iCq7eWUXWqUYbyJxdJ73mzdyiP1OLIJ0TRa0K2iN8yiCP9aCCsS//G7Ioqyu4khcScLZ+gM/Pb71YLSuO4JKkHf5ixfRkm6q7FHe/gfWjcLwc42+s94Z8vw8ffkgduWDIAlQO6d0XQdB9aXAszT4mQIrgF7XQm3UJ8wCm5PMdyOXpE2gioXxt1CnSi9KhpUw6jcjPMJK06rrTJKutinxKLLnGuvyPqOTP27OceAIm/OfW1NDVYeAEuxvcR7io7ZjxrW6/8V4bwVERq0aVJM7/GywCpczjgQxg6oMMN505Ud+Y4uvHraTlr84SFOE3Y4gSLzdoHX81uqmJDQMbav7jmBgyBraeTW7I05srzByb+Qr1W46c9NSD0/9XbLget2+AQC4WC1OQd0EqMKZrJObh0kRHzMyTbeCKFiR9iZgErj6fJSXzalyi2bsb3hEZyezBn0lRmrmXvhH5s1+3IcXV1nhDN+AkmbvVa0TdenPmv80xH5x+zJTq1VitE8h4yflzJIReAM7jlaHfliJcZm7RbNyV8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(316002)(186003)(54906003)(36756003)(426003)(16526019)(2616005)(83380400001)(336012)(40480700001)(36860700001)(6666004)(356005)(81166007)(82740400003)(40460700003)(478600001)(26005)(1076003)(7696005)(47076005)(5660300002)(82310400005)(2906002)(70586007)(41300700001)(8676002)(70206006)(6916009)(4326008)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:08.1191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43524df-a3a7-427c-aa55-08db3093d43c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add programming of SDMA golden settings for v4.4.2

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 4350939105c5..016813b295ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -96,11 +96,22 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
 
 static void sdma_v4_4_2_init_golden_registers(struct amdgpu_device *adev)
 {
-	switch (adev->ip_versions[SDMA0_HWIP][0]) {
-	case IP_VERSION(4, 4, 2):
-		break;
-	default:
-		break;
+	u32 val;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		val = RREG32_SDMA(i, regSDMA_GB_ADDR_CONFIG);
+		val = REG_SET_FIELD(val, SDMA_GB_ADDR_CONFIG, NUM_BANKS, 4);
+		val = REG_SET_FIELD(val, SDMA_GB_ADDR_CONFIG,
+				    PIPE_INTERLEAVE_SIZE, 0);
+		WREG32_SDMA(i, regSDMA_GB_ADDR_CONFIG, val);
+
+		val = RREG32_SDMA(i, regSDMA_GB_ADDR_CONFIG_READ);
+		val = REG_SET_FIELD(val, SDMA_GB_ADDR_CONFIG_READ, NUM_BANKS,
+				    4);
+		val = REG_SET_FIELD(val, SDMA_GB_ADDR_CONFIG_READ,
+				    PIPE_INTERLEAVE_SIZE, 0);
+		WREG32_SDMA(i, regSDMA_GB_ADDR_CONFIG_READ, val);
 	}
 }
 
-- 
2.39.2

