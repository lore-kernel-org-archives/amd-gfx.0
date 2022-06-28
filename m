Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42010C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 20:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB121121F0;
	Tue, 28 Jun 2022 20:30:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9B11121EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 20:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEGuabp2q++eys8k2NnNDiY9eJh4aeG6yyqPw3vR4ho5oixRFix8T1mbbz5/iz8vQE0x55Vcy52HLrioQClTj1qYBxmbZxCuZZqPKqE6//NIsTf3LU/JWtZ6zo/TmzjyrNxzLTNzMlcmn/1yMq0oISApcr8rkEYdNi9nCjxsFd2qdb1xg47RK4qdSR6bTJHmpDS9ZAyAc/UqQMPLXQgAlVuupbs4muY69iHYTj4815pupEAb73XYFWYyZda+pefQTqmLBMoNVjKiO8NWGxrrffG82cbud2Dc6fy/5FpanbVw4KNtCBHRl0xBobYxf+U7c0jqCOwVlUsxZxjE6zkZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKK0jhWGw2uIa7Jeh+uDCwQLQFHl9MDYSRy+7MZW0CY=;
 b=AsLgKVYjaIAy1cbD5qT7rObP8F/TGG7CYw6h8Ky7edQXKUSybe+4HpxSfvgnHSAHdI7KABgODsiODG3Q+HKnfmboMRA0xW7qdcUA0MSG+82j0ONUJf7G0fKnMM6Pky6CTM2s+GWMlUAl9EHkYzHj3aFhK0JrDdR6Moe/gP4oZ4/CrrPOGAR/qkt7IZMmkGgvKxb8aksXUQj6u86LBdk90AeXhcZXkKadStvSXeXULUPPqszSTfo8l0N8/ohQFeyaprw9PWe6AMwud5jfJ1g/13DR8obYqXc6DLxqUSBLpf97mTnK6sqDBTTMZzZDfruDgkXWgucnB2Vc+y3lIJCpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKK0jhWGw2uIa7Jeh+uDCwQLQFHl9MDYSRy+7MZW0CY=;
 b=WX1TSJHZ9o2rfurVin5BFaVlYKN8rQbF7RhqRfteQLDccheRh15kigqtXHTS+vPUefT32pKsxcUhOHEEJfUPIMt00kDTh4RcaY85diyPmrYYf1gLqQOF23tAtdWJsiwnYhbPaX+O9vCcMz6/qEwpjluJA9W7gG7tEOAbF1rifrw=
Received: from DM6PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:100::16)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 20:30:51 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::dc) by DM6PR03CA0039.outlook.office365.com
 (2603:10b6:5:100::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Tue, 28 Jun 2022 20:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 20:30:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 15:30:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 13:30:50 -0700
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 28 Jun 2022 15:30:49 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <alexdeucher@gmail.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Load TA firmware for DCN32/321
Date: Tue, 28 Jun 2022 16:30:49 -0400
Message-ID: <20220628203049.2233891-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bec6cc30-085f-44a1-2821-08da594517b6
X-MS-TrafficTypeDiagnostic: PH7PR12MB6587:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIty471xtUAr7qR7eL905mzPoLKEAS8tjIR9i88UjMvsbvUUIJnGXFZ8kwJtTckjfex9Op1Ejdnd2DUMsTywLUaUerMoT6hU0eg3rCKuaeXy+KaU6Z4vinpnXuq9ZBDXddOvFFRxJ9vnOEuA0AMExbK5wkLQiXc2XuVqdNkUusRcyA4iNdUaE/OEqx/5pBQuqImPZrrwVxluopNPplAiDZBiPRWG4oMeehj1yBDPqhw4BCMOfEYNUnGxmpZiZnmPUp2nJAqC384LS2PehLtrv/hGUUTEYBoGno8nPdUMZ+J4ufIsazalGK36jUOZO4wEN5SGS8KIqwf1645ebJpnrlkhpiYod3Up0eCxekvAXlQmtc77ZSNeK/S+ngVOnQaHRzrKMfZ2PMv+SaNULQSYQc6JMFkQwOAx7pCGsVaUtvJ7rbCeUZZJwQt9pqfNLnVXzHE9Ny3j+o/DKKP/7FrAndCSEHgCgeuyhOdYtIm7RBckPyhbyLGH0VWzxxA7rEpUqja57jeue84dfZwpCRILdS9aqRcIsEmGsSYmY7sVs7F0bzs+rs1Rzv3Lxvod8TCb68bB+gtEZwD7WMRI8d316V2SrwjluGEclQ1CWNCWqcY55d8AAsbSufDQUon7YJb8JbWT0pySO//QnHa53c5qAR6z0jBX/F/1OtojAIvbx3WY9l7yE1w7EVwdR2cRl9ikVdyIXKfIUyo10+Kr9AgW2WSquEPgPe0SXJ2uTCFkHllMNUPbBKUmkPZaoziZvcfGJ8B7HdWC7DEWCdrY5XwXmwQGkLr7kIAlzfanZbd63D7pTj5LE6SJxgoggEt19/sJ0LWIgmxmXJvuDk8QTHBOsLIDPwqWSSp7XDhAvBF4TjY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(46966006)(36840700001)(83380400001)(86362001)(47076005)(5660300002)(426003)(336012)(1076003)(44832011)(4326008)(36756003)(2906002)(70206006)(110136005)(26005)(81166007)(70586007)(186003)(7696005)(82740400003)(356005)(36860700001)(40480700001)(478600001)(8676002)(2616005)(82310400005)(316002)(41300700001)(8936002)(54906003)(40460700003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 20:30:51.0682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec6cc30-085f-44a1-2821-08da594517b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
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
Cc: aurabindo.pillai@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
TA firmware is needed to enable HDCP

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 9e1ef81933ff..4df45c2a7d0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -40,6 +40,7 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -103,6 +104,10 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
 		err = psp_init_sos_microcode(psp, chip_name);
+		if (err)
+			return err;
+		/* It's not necessary to load ras ta on Guest side */
+		err = psp_init_ta_microcode(psp, chip_name);
 		if (err)
 			return err;
 		break;
-- 
2.36.1

