Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE2BC47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6258B10E10D;
	Tue,  2 Jan 2024 03:44:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A86D10E10C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9s12gLIeMpkvwVe5sqOZOJV5JwDPK97IwNn2NF/2m7AbQsCjeAn65jMx2wcj/l1qvBmC+9rc6qEdXyqeXnCeY4TmxpLyljkbANnhm8evFbCi5p1qg4Mq3086KcJQ4TrVd91Fv/K0AOqCSdtDm2LM87Mx/kzaeyi0aJfw0E0KI2ctFgk11gMm6qmiI2VHsP7a4rswA9wCCDQ2K7sVjtAT1wZuC4cw5IvnVAWBy72CSZ2uYduix9OjXy1wQ75TGhp15V18hz8UuhrMGLNTAQeaGP2h9KzEXBdeNGwGQZ44k1qdKu9F419vLFMg7qW5nw/ik3C5lfK5U03eesvovE4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB3hPOzi3Saw1PN7vDGteJwvsLr1yX7w/ypo8LwZhDU=;
 b=KSB7bxGKb2/nk4wSNY/lNymbulEriWF6nADiuomaOHaENkxo129TtALQ9FgAxkgx0DpqfWDetNZnRAC0urI1avRNBIFOP9jF7ZCNSkvBM5WPjL0zwT4nhcV5VAsY3HIFWp6X1Tyrt3NcSyocC7o/M6vNWrSIO3WaKYF5KlrHfHFYAJtMs1RnOWbapR/4hECTvYQcwllPmJXuckbBylb5sM7ojzPVpsr0zdCqPVvSMDsffzglZD9eXC3xVXljt2OHszNW8GAfi02daTvZ32P25l1VaMCtIAGC5GRyOYRfkeQ641z4zaRrTKnIk3MpAlpo5y/xVX8bv9I6JziwNXgVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB3hPOzi3Saw1PN7vDGteJwvsLr1yX7w/ypo8LwZhDU=;
 b=eMeKJoWfxD1R2Cb+xbtzvXXyJmIZ4a/jfLlOYa5CEUIynF/MHmA7GVSPxLxvkkh6dFdKFLKdgIpXU5M1FBRIRFHRQFn00X+/vbk+9ENGnaiQXmN3/G20ftwDXLXUk8Ub0oN01T5DAjwHwWfsM20c+8woIJP39B9HtQOhCgVKiHo=
Received: from SA0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:806:130::35)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:44:23 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::e1) by SA0PR13CA0030.outlook.office365.com
 (2603:10b6:806:130::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.11 via Frontend
 Transport; Tue, 2 Jan 2024 03:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:44:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:44:22 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:44:19 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Date: Tue, 2 Jan 2024 11:43:40 +0800
Message-ID: <20240102034341.16321-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034341.16321-1-Hawking.Zhang@amd.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d699a6f-7689-4d23-d47d-08dc0b451be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yza6WhO6DSq5ryAHRwOe0OlwlHCbbVXqNnlV7cvGa7z9D9q6LPv4Gd8Y2cRWTN450FViUr3Kiupa/gXFM66JAWGvIC/iU3jkmSZuDB6OnueRr5BhMBGud7xpBn1q3j2fqhvvzisb3EcfZ68ak5R9axSUfKkP5VgWB2Efg2vKuVUc3IFm5I2+ZokQUTO7/4tCNEMMkZ0p4fo8QFdHz2jAfIJ/J1XU2eqxzVjO/HOeo7zKV23JpTel4gxltKlmuqcWh6UleIcGsfzbpHtQcPZhr+FyPz2AZCuaIqSuHzzg3inayy1d18e8QgkrMn0wMVu8+Eb9COKeXH46k/+KND4/0GmaSUs5IbFms18D3z26AInOsnXYrmsE8U1xWKwj95aBX1bZDJHSddL1Qev0krDh+e0O4CSu9QC6gV/cbTHPAoRrGkoBVzNi+ur/9vThWetH+IdbVfQzt7UukM2ia4D0zVI5iAJSc4PK0c6PwJES6p2CwrEkZpMkph8gmj1hkM08FvtvlXPzk0tjjEYelC6rbqH4y8S2DpdDJZMhX7ngShutBgB0r4gdOeh0fwu2CuqtKKl4We881dpZCr+/fnY4bk9HE8LVpa8Y82iKQhpk7Kvtj5676PIULfEfCjecmlcPBSVmbm6WiDs+yrZFDJZKUyoVaYr70BTFRS9Ap4GVKBbLoOuzfimNvtBX2TL9p6XcXxx0+X0lODGsIKeUuKjGSP5cN9jWg0OghVdrse17di76+6ZNDJ6B7zTMDB+ijnWLFl4DDpoHBOP4kqMDX3xybA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(26005)(426003)(336012)(1076003)(83380400001)(2616005)(6666004)(7696005)(36860700001)(5660300002)(4326008)(70586007)(47076005)(41300700001)(478600001)(2906002)(316002)(54906003)(70206006)(8676002)(8936002)(6636002)(110136005)(86362001)(36756003)(81166007)(82740400003)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:44:22.7551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d699a6f-7689-4d23-d47d-08dc0b451be3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074
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
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check and report boot status if discovery failed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b8fde08aec8e..302b71e9f1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -27,6 +27,7 @@
 #include "amdgpu_discovery.h"
 #include "soc15_hw_ip.h"
 #include "discovery.h"
+#include "amdgpu_ras.h"
 
 #include "soc15.h"
 #include "gfx_v9_0.h"
@@ -98,6 +99,7 @@
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
 
+#define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmMP0_SMN_C2PMSG_33	0x16061
 #define mmMM_INDEX		0x0
@@ -518,7 +520,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 out:
 	kfree(adev->mman.discovery_bin);
 	adev->mman.discovery_bin = NULL;
-
+	if ((amdgpu_discovery != 2) &&
+	    (RREG32(mmIP_DISCOVERY_VERSION) == 4))
+		amdgpu_ras_query_boot_status(adev, 4);
 	return r;
 }
 
-- 
2.17.1

