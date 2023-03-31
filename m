Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281EBC77B6C
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC34F10F334;
	Fri, 31 Mar 2023 22:39:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC1810F323
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1YhzdFEpST2QDglaSjT/GEOouB+JKGDgfs4x8Z1clsqKC9nDEQ8wu5v7D552mpc7PvUU3eiC9AJ59uVQmajuwGxPy2lEqI2oZBLdq3vJ/swis8Pd5nGYX1SaM4HYppkJc19T4/+ClJLNMQ15S1a/6mT4YstSVuWCHYTnu+qk5uo/uxCIiHLMOBsekRljpjIQbHXaxpYldwEkqDsR4olQw9wXRgfWCpAOwPa7ov1XTmLtyH+YQL7v/G7kvwP4H4up9OQ7eaZtlDgec07e0njHPQ3RVZMPrYpiMqderRzQhJdZziSuxzEDUTT4RNYijxeWY0iMYvCQaSw5IhIZpLNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9gY0mqTtMJzgjbhstimNdQym0gVT1unnWpdRBf+DuM=;
 b=AlZqL81DOQl9L6xgHx/fUrX2WmwTF5JnL5iGi0VbFgCuELhQvnX8aonPeBH7PVsqRLRZf1qmfJLK87A7Yy/spKQnyS7fimBMK2WlKT3aPb7bA9VUyOGbLqKDWXnL4VjdWU7KJjXvbUJt+OJLddzz705NZaqsnF1g42sKcYRaNWJUZaVVyF/45DrP36514P1tVmuRwo2M4h8h2zj1R5QPF2zqjdhT1i69u7c4PgAIk2EHufm8u6rxTBYsaGT/xA1K2Zb0gE+0qRBW5j9MCKVw21ex1+89L/np1Md6WN7v9Z27BRvBclSNeajsO/csYOPZpUiiuER7K1VOHVwyiICEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9gY0mqTtMJzgjbhstimNdQym0gVT1unnWpdRBf+DuM=;
 b=0XnlnD0Mvn5HFtGVC0paZuefA8BcsgYKpXL+hndrcomSpT2t6eVvIAMKMT9z4r7XgIkMhHQhgPpiixvA7aMaWzeVxBrYY/mdVRSnLskt5Nm4ol1kRlqr+rZUT7ecmHAoBMVmGya9l0vAyO8fmWUERt75gKwI+tfH1SJgjGeg21k=
Received: from CY8PR22CA0024.namprd22.prod.outlook.com (2603:10b6:930:45::29)
 by CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 22:39:43 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:45:cafe::1c) by CY8PR22CA0024.outlook.office365.com
 (2603:10b6:930:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 31 Mar 2023 22:39:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:39:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable context empty interrupt on sdma v4.4.2
Date: Fri, 31 Mar 2023 18:39:26 -0400
Message-ID: <20230331223927.8388-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331223927.8388-1-alexander.deucher@amd.com>
References: <20230331223927.8388-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|CH0PR12MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 993eec6b-b27a-478d-e267-08db3238d271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDBasL7q6IPzfcKAMuRr0X4DO9Mr3p9uJZPrI/1j0dlQkMyPuEor+SYfqPvS8+KTSj/VDPrJFI9NFo4e0aCqP6McTOzFAJNMwaR8gX5aHdDQkYpniZXSQe9RKUVmroo4RMIsZ8I/GEedBvbk5otMbYHkkwVqABRC54GhDlCcUh2xyH58s9ApfSoJ7dxGR2LimD+4Dk93kAjtwP7hnBaXODwhGUsf9vhd1sTfTAf0pN1VTa977zGBX0yO0S38TMOn1zHPwh4lTcvNcZqpsaKKsKtjgGWKdgCi2NGP6YNki4q2STOw4lBi0tdTVq+OoGqxRZMUuMKQUSOaRzH4yy+veE1WpeAAb3icBphDStWnpWmTGkp+Ssw6YWrzSfN4Oh+R7Mk5JyWblN3nyv3As/byPBUuRFWJeKxYbQButVwvk5liZlRSKYDGSYTSnOr0U78eGdeTBobJD62ZUtZXmmRKPLrf1qIFX5DEUTQDDW8dtKvHL4ou/mhlSGR5ONCr73j6NY7ocYBoEKicvWANrnfy8yK23BStm1qkWdJe2sySGNQhYnpvv7AyaZC/6agDaAOrNEqRq/58JQxBmfA/LIQHmAIh6KDS+lh701BCEJsgTBjX4SNvSWpmJj9vaF/lnbMLWnSQgr9rcXAwlDB8eLZYQV4n5Hwj3HS8IbUgoYNp7W7f8sCgVbC84pUMLUcrvEqdvcuKZRexoxnkRaajrOPWgFRAwoafKDvLXTF9mPKZ5H4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(8676002)(4326008)(40460700003)(6916009)(54906003)(316002)(70206006)(70586007)(1076003)(478600001)(36860700001)(7696005)(5660300002)(41300700001)(82310400005)(8936002)(2906002)(82740400003)(86362001)(356005)(336012)(81166007)(2616005)(186003)(16526019)(6666004)(426003)(47076005)(83380400001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:39:43.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993eec6b-b27a-478d-e267-08db3238d271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

With SDMA_CTNL.CTXEMPTY_INT_ENABLE set, the F32 clock can be gated when
SDMA finishes all job and goes to idle.

And no specific interrupt handling is required in driver.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 729e26a4a2e7..7aa26e716a2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -890,6 +890,8 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
 		temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
+		/* enable context empty interrupt during initialization */
+		temp = REG_SET_FIELD(temp, SDMA_CNTL, CTXEMPTY_INT_ENABLE, 1);
 		WREG32_SDMA(i, regSDMA_CNTL, temp);
 
 		if (!amdgpu_sriov_vf(adev)) {
-- 
2.39.2

