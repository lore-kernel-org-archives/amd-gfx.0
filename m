Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1545CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D058910E943;
	Thu, 28 Apr 2022 21:30:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3A110E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID7F4IPusTWiwpNW0NBk9wIN8awbBJtj0OAjYHzugcCfqcstzZH/qRdaIFa19XESTdpVt9vt7qrwVcywBMIi+FyobSotji1o/9RfBKDwAhFiRrffDJg1l3TDmc1IAfZqQ/A38ScVscQZPzd5LkxvmP4Wk2NL1UA1Y57tQoFdj4TysBiQSkrA6544j+Q5yATZKBEAHPRTscUFF2869wxld1EkQdzz2JpfYSdwYdwmetjan2J06h8KaQfGYDihIMEGllC0LlDIRLZo2A4Q/IKKCX8QxILNHlWwRYtAv7XVrEnaqpsHXg395XLq/i2Wl3AS/dDQfYEvl+vAl6dTlunHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUExqAzXyDPu8RxjZrY76VQ5LhbePSMTCPn8fS878hA=;
 b=nKrZi0YhKVxqrZmTfYzfEOOj1FgxM0idKtG8Stoc2m8IvEPD9m6uo1Xt41IL1stkgBmi+Wfmxttda4IA6E7skwVq5a5Fy5E8yhO3OwEDC+QQ+YB1uGwFruY+BGNrX1u4kkAwUYRH7d51hwodd5qHNzwdhyQ0kWO160b5w4QMnkx3nt4h0xz7LyP1snWwsFWHqXresvJJ/hnnBgTNdh29Hu3BgrFioKBVFUR97+TE4/dM0k2mTIKcFgZUH9v0ZVdBt08qqrkaZYQ7JJDA2iCP30ZMadNeCU2/Tt3a1Ezbpj/AmqWkaHhdYjynBSzV05T9KbIyvvoP+jn/5D7L4OuFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUExqAzXyDPu8RxjZrY76VQ5LhbePSMTCPn8fS878hA=;
 b=rNU6pHlhgJDEYCU4gqeTxsmVaj/8NkMWffT4CkLJ7oolVJc2+XB7Y2Kxp5Fot4gRlBdmpzy/U27iwTgqOaJDfD0Q2cci0bNyyo6IunWpdHei0mOIMhMnY2kp1ea/O0lxZqUHiHyeEbmabEU7zXYfroz7sCbrWWAMHOIUEfmB5IE=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 21:30:06 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::1) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 28 Apr 2022 21:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:30:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:30:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update the hw initialization sequence around
 pptable setup
Date: Thu, 28 Apr 2022 17:29:42 -0400
Message-ID: <20220428212946.700296-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428212946.700296-1-alexander.deucher@amd.com>
References: <20220428212946.700296-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbf27f98-a9b1-4734-2721-08da295e4370
X-MS-TrafficTypeDiagnostic: BYAPR12MB3479:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3479747571464EDB513A17FBF7FD9@BYAPR12MB3479.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHKLSi/ciEN+/WGvFSfm2BcFRzQf4EgYwQBYtAuySK80noChLbcHXgLuoXg3Ymp9sFeUywA+Z8S4EU3PadQjpq71N2/5O0klSGNGAXKfQRqGCFZVAQMmCSPxUx7jH8gNE5q8P/JmKjK1PyBj9EdR8vju8m13ebokfiPtyF0RTg36nN4WgoYU7ZWWvX3WSacgyhUwfHKcNtciFQE/HBYbAY1K2fp2V00OO9JBLVdwKDCLjY9eTWBsS2blMHBYqSKqzEZJIdrL+mZ+rib/XKlcg8HcKpQFJpjWGlFZstVfH2WWjGH6DuuzdyPERrhJZjwCg6jsIxwS/uyhx6TLcGhwzEO3wbAmod5eZe4QL2vFiTUqCs1IQD90rds3I9DzbVMhrQ6XB9vlcyrZgD2Ew4nQcfkOdoPsI3HoCIYGuhMxQLMskqvImft5G8FeGkRroFqmvX7j7DEJ9LWWQRL1ttFTG8hAh/t1909+yXibMURTFZAcYczXFVUGVAR7oSwHKxX4Pga6hWktsClRzhX9yXbgXdkHfcKejU3fqjet+U7v3JWC9fpqy8t/HqPCv9KHaa7MfNXKzjSOb5CCY+vkc3rWNE+M29A3zuIa1+X19wPF1W0TNq6NSRjR/h3IZSwLMQ/CWc/3X089Lh0psjgFk2DkHgdz2K3MAIXyiusLVasz2YvorlPqbzjmji7dN1r2Jp0ejRAw0nMUCajchXtY23N/1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(7696005)(36756003)(70206006)(36860700001)(316002)(16526019)(186003)(19627235002)(8676002)(4326008)(6916009)(83380400001)(8936002)(70586007)(54906003)(2616005)(336012)(426003)(47076005)(86362001)(40460700003)(508600001)(82310400005)(81166007)(356005)(6666004)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:30:05.9559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf27f98-a9b1-4734-2721-08da295e4370
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3479
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Place pptable setup after smu_set_driver_table_location. As under SCPM
enabled scenario, the latter one is a prerequisite for the former one.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 07f44970bf63..5dd97eac0e99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1141,7 +1141,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	ret = smu_setup_pptable(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to setup pptable!\n");
+		return ret;
+	}
+
 	/* smu_dump_pptable(smu); */
+
 	/*
 	 * Copy pptable bo in the vram to smc with SMU MSGs such as
 	 * SetDriverDramAddr and TransferTableDram2Smu.
@@ -1311,12 +1318,6 @@ static int smu_hw_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
-	ret = smu_setup_pptable(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup pptable!\n");
-		return ret;
-	}
-
 	ret = smu_get_driver_allowed_feature_mask(smu);
 	if (ret)
 		return ret;
-- 
2.35.1

