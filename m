Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AA6C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 03:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EF410F017;
	Mon,  6 Jun 2022 03:12:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6A610F017
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 03:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3EtHLI3gD0pOR5qLYRXWA2guLY/7pZGz1pCqnzmUyjnFdRs676IVxSR1vcVSh3NpepKryFujj8Zuj97Ey0F3v+0YtYJFxFqxiOIQoFYjKzJ39fV7Lu8vCPsSdSLzizBw6vgBcwvwh+au5yJTuPlfR9CGSqxiFhY0ATE8NiZmoF+fl9CkAd9k9WPJm6L0TLM9VaWq4ZeeBOzI4f/qsOUUT3IbzmYEUPNkdGEhy0IhmTjvy3TcaUPN0A0rHA22qxp/5h3D3g9RDoD9FQUsjyQYD8xL0cUtSvooPmroWwLaJIKU9nyIJg4WCCfHYv4hAb/AixM3XZcoRPJhzIisJolGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8Fnv06hhyIO4A/i2Htc0q5oSZpBMC2X3eTA1CFw4l8=;
 b=R1CFoVhvPTKnCABuoWzmSd2IqP8ttKIxV+NywFke5SJkMZ6CPLTy40UW49Lpu5K8M1WISLN//SwyXumVKfB7doDO7VAOT8WEXKZseeRyPEhzatcNBhry79XkKN6FTdxCKhwdKj2TV1fK1JXLw3M6MK6VUy882R+y+bYvLFm4/5h6TwfwvL7T3i1hXHbZcSVjIJyDwhEnSBnDb3XQ1I0HboOsZs+FqOc/gkmpZCvXQndR+UcFYxdDfZdgPJxMy84WcV39+MP+t66MhGIxjN9iQ1KXCXDQRqYpHfugVcAUryOWhnfAokcYeY/iyDYqR4sfyDbTzw7+M2dQXhoFqSogsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8Fnv06hhyIO4A/i2Htc0q5oSZpBMC2X3eTA1CFw4l8=;
 b=oNZRbcaTRW8WwwKsBeMBlD0j5FNlYT7JRPJwKEuW5MjqpKB4AxZRntbItlDJQ5kfLwXBrgnmIjXo40TAnumAHoUY0UvMJ1Cy7xXbtmK+TsxtAznxm7x9Ysk9iQwnreSM6XLZg1pkjLaCciKjg9zVSVuSvLP9D89GTctFmvCt9qc=
Received: from CO2PR18CA0057.namprd18.prod.outlook.com (2603:10b6:104:2::25)
 by BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 03:11:57 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::28) by CO2PR18CA0057.outlook.office365.com
 (2603:10b6:104:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Mon, 6 Jun 2022 03:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 03:11:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 5 Jun
 2022 22:11:53 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 4/6] drm/amd/pm: drop redundant declarations
Date: Mon, 6 Jun 2022 11:11:22 +0800
Message-ID: <20220606031124.1818265-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220606031124.1818265-1-evan.quan@amd.com>
References: <20220606031124.1818265-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da3bbd32-ef66-46f8-cbd1-08da476a50b6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3176DC3DBEF883CCCF3D3630E4A29@BYAPR12MB3176.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXPsTbCOKyEzueAUbQ3Dh0m/6Sv/FPPDMIhSDeQykWtv5uKw8a3QiB6L7D6YeWuqcEnJpPImtb94eO81PNyJcNYzaFiwIcIehvpJPKTD4hjLMKM2Zk6OxOuO10NTU9jdL8bchojK1dK/pJqWJBHRQqb/5eXsO9duXqYc5k22u4XT+SGiAEXF75zdeBRh+tY+6WQRNNhDAcNB70uC6Rv9if8KIvcv4/2WndSp1DRhPyDXygErt41AUdiZyTKS26aYQjmBgJpC/lxqt6pzhm4Wl04de+YOHC0JNNsSjBUjbnVEPP3f1lQFmDfVk11RZQF9+maT8lruiAkoqWci0OIva332pgA/sqTjtoKVyev69Q3p8/JDcnenKVGiJzdEFCxAEUSB5GWQX6ndE131a+wKAlguPmp3qZWbj591DLS8quKup0O+Y4EcVGb1W/hMIkw+0bxIbHMFDAIJFRH4S3gjM200JFkA4yWEkOuAIn1ue4upAc6zJ4nypUhJdqU6GHrLOkAwz9z35H8bfV4c8KiF8u1zgUmlzIEENZmvZA9x2vEFf2nWBgrjtQQyw4NbSzQwrA0y4z3chXrDPLdCHKqubXGUhxM7I5M/zVXNJREvEp3TleMIF7LZjbXR5mB81fjXeGKMpxWG2sPTWhazcjbtE58TTUdoejwis6mEtmed0bKVS+CSZZR6+QiR3cJ26vdHaxiePYFTpt47T9so4LLtng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(6666004)(36756003)(6916009)(82310400005)(54906003)(36860700001)(83380400001)(86362001)(44832011)(5660300002)(40460700003)(2906002)(4326008)(8676002)(356005)(316002)(1076003)(336012)(426003)(66574015)(47076005)(508600001)(16526019)(186003)(70586007)(8936002)(81166007)(70206006)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 03:11:57.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da3bbd32-ef66-46f8-cbd1-08da476a50b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3176
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop those redundant declarations in smu_v13_0.h.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I54e43d072235f006b937878c126bcd8ef81ea6f7
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 37f1752c7eb1..62dc526be146 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -280,20 +280,6 @@ int smu_v13_0_run_btc(struct smu_context *smu);
 int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 				 bool enablement);
 
-int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
-			      bool enablement);
-
-bool smu_v13_0_baco_is_support(struct smu_context *smu);
-
-enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu);
-
-int smu_v13_0_baco_set_state(struct smu_context *smu,
-			     enum smu_baco_state state);
-
-int smu_v13_0_baco_enter(struct smu_context *smu);
-
-int smu_v13_0_baco_exit(struct smu_context *smu);
-
 int smu_v13_0_mode1_reset(struct smu_context *smu);
 #endif
 #endif
-- 
2.29.0

