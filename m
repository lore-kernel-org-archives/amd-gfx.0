Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502A9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 10:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBAE10E410;
	Tue, 14 Dec 2021 10:53:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D494410E410
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 10:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0NwTuQUfSTVUIGM8d6AgBDe2NnXC4DKUHBoUfAOiit5Ihega/AkpSIJCtNgKO5GcUgnWcp40Q4/Y+0wBwX9oAZJYEI6FU77Uw7RG0lZP9JYLVtKaNh56moxGVpslUhpYfBtJqUMIt/X8zEpMQ3vhzXPu7Mn9WfBYS+l4BwA//MDDZClf6XvEingHv1OXBE2dYgLIN2rzQdxmh95Yll1penzvKIA2Qn7BGGuubmH5ttI7tztqoO40cu96+EblNydfPPtVvcbR65lG+Ijw2THGC2fVw+QvbPjyzlMJfklEOgAR0ggjRxj5opuf4s9Mko4ZmlSDCjBtQ37uDofXjMz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIbSR9Vfna80GtgXdJfl81Doer1SdNeNS+CgORBvo5U=;
 b=kNE1J0lkA/ImcOnrMrPysc/UmwVkAZEwOxkEbFAIs/jEcjULnwV6370jkEQ/Gw2FwngV6jVl+H7pUQ8mSnnyHhRuvsulaJLqGXvoHk40kdKZzfeuwvMum140oQrLOcHPzpc/xOzSHZAYnuOwvldIb49stgRhOIpDP6oKx7cGjFCcJ0AHOLzf1vRL4fiP0yVV06urA+Xn7978RkRptYkz9p5dC23cHlxGOjO4PH3yJO5hKbK9++KH1R+y36y+cIsLSaokhN0vJ5d70kXy14SqAmSwKAsDy3gWsKTCyQnSqSorPHnP/+xZAAhmZNvaahPRm2tAatEOe39IcMQNfAZKeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIbSR9Vfna80GtgXdJfl81Doer1SdNeNS+CgORBvo5U=;
 b=G1xgq5fNHWaV1T/2BjSj2CgpMwGVdSYeDkRviRObxSgOcnCAt1PVF+drQr8yjbx3JkMY7Dyz6M902WQCmHVbGOTTfn1H1pWr3KRhd83XlXvZh24LAZOlIZU6zB6oGeI8v4/AEJzUxMaV3UOC5jOMooAXaBetYWcMyoj8CKIMBho=
Received: from BN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:e6::30)
 by CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 10:53:14 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::f4) by BN0PR03CA0025.outlook.office365.com
 (2603:10b6:408:e6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Tue, 14 Dec 2021 10:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 10:53:13 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 04:53:07 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add smu fw version check for ECC table support
Date: Tue, 14 Dec 2021 18:52:54 +0800
Message-ID: <20211214105254.594167-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e32de34c-0feb-466a-94fb-08d9beefed79
X-MS-TrafficTypeDiagnostic: CY4PR12MB1463:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB146337DC50B4EEA39CE23C9682759@CY4PR12MB1463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5e8DoHq/HL1RTc1lU4U5YhzPLt/Y/dAeGob3m+H+lrRoznjrn2+U3OhAk8CAj8rUo0JWtu8ZnMHcs0cRoJJQWDj1BH6mgOGFMVaueLMPOvnZxAWj9XR6TjOPjulT7AJMGqA6oseQvuN+ISmpyP6sY8v2O+Edkdm5eEXLkQL4pAFQBGkKw5QhYzagH4Lgha8cc4Skzy8dSCRmm+cahmCc0QAYLRKFLUnAw5g2SNZUj96bZKqiJ0IU2NeuuWiFMHgm3JVIErvmqGt8RzUjMkfewS2Sk5O51iq+6IUK/u/FG2fwY7B8M2T9oL7Ul8ECwRhevI0cYgcGt3MYfHixynv8IV3ryXhQUFIbBWMQeFiZjI2/ASND1Ca29m2j+r66woXODwjgrcRQ0eo/+uQO/77wA15ub83bHDutCTr9XOv0JRCezB7pg0qybbZQFWfvZOeuncUCQPFzMD/Ee43WbuYFpX3nOTPbcWxrAnSAw/EHOyJkbE6PlCpGXESJDTSa6ynR2rkRSX4McqO6FIH2HoFqDD582nfwMQmHxgywSd5WyjKmF920i6tfGIdMzxopFo3sbU6jQFibNTdKDtAL80csaSGvO4hGGfshkwIk0HwlcF+6Nlm1+j15XEvBCHwWUTB+7CgTCL7tFYQFe7dA6N0JVbHmc/JPCuWKVoDSfpE8nRcZ6rwfJp+lDQ7iqL/bk7Za5VvN1SyCoUbP94N4NW1Mu3uVLhbHglxIfvPEHsRLVw/xXxjhT1KGaZDV5Tcy40oyyPOQIOXH1O6P4Pl0tnBVtMje3BuCBuyIJfPAK34OV0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(426003)(83380400001)(5660300002)(508600001)(316002)(82310400004)(70206006)(70586007)(7696005)(36860700001)(2906002)(2616005)(8676002)(1076003)(81166007)(8936002)(6916009)(54906003)(26005)(40460700001)(4326008)(36756003)(186003)(336012)(6666004)(47076005)(86362001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 10:53:13.6202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32de34c-0feb-466a-94fb-08d9beefed79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1463
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
Cc: hao.zhou@amd.com, lijo.lazar@amd.com, Yang
 Wang <KevinYang.Wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the smu firmware has been remove ECC TABLE support from 68.46.0.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 8 +-------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 2b9b9a7ba97a..78ce451d0b37 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -79,6 +79,8 @@
 #define SMU_THROTTLER_PPM_BIT			56
 #define SMU_THROTTLER_FIT_BIT			57
 
+#define SMU_FW_VERSION(maj, min, rev)	((maj & 0xffff) << 16 | (min & 0xff) << 8 | (rev & 0xff))
+
 struct smu_hw_power_state {
 	unsigned int magic;
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 0907da022197..7f8f00a19836 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -78,12 +78,6 @@
 
 #define smnPCIE_ESM_CTRL			0x111003D0
 
-/*
- * SMU support ECCTABLE since version 68.42.0,
- * use this to check ECCTALE feature whether support
- */
-#define SUPPORT_ECCTABLE_SMU_VERSION 0x00442a00
-
 static const struct smu_temperature_range smu13_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
@@ -1780,7 +1774,7 @@ static int aldebaran_check_ecc_table_support(struct smu_context *smu)
 		ret = -EOPNOTSUPP;
 	}
 
-	if (smu_version < SUPPORT_ECCTABLE_SMU_VERSION)
+	if (smu_version < SMU_FW_VERSION(68, 42, 0) || smu_version >= SMU_FW_VERSION(68, 46, 0))
 		ret = -EOPNOTSUPP;
 
 	return ret;
-- 
2.25.1

