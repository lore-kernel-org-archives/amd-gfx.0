Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D61AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58314611C1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58314611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B40C6E9A5;
	Fri, 10 Sep 2021 09:10:07 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991406E9A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 09:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erqw6zA5GiYuq42JGXLB+u6Njof2LrKI5y3DLqTXkk2d3bGbETv2ezmyNK88mcjuPAEUFnuR7QFoxN3ORBXCc4lnjXoNzsAmCxBmVpnvKiO0RL+YapvnAWVKINbhM1jPfiBcTFxCCwDrrejkANfoIMTsF6F4SJozsexHF0QTkLK+nazOMyZuurRR4UDrO7Xm9BMEoxJJ8FhCOKBko97OSNhWoHMpc/eq0ikMOWXfu3+BqeYGefvjoP05KmvkvKZ5dnsUP1eJNZrJPnN5E6mw55BRFAcvQLSijrvvVLywZmuXCKWI/XCB78sozrbIyxSjonhvmGkRrYxovwNgHMAPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=LNaB71xTIWtITiYxT7URgHoBq+D9yYrNXbbqcXel0WQ=;
 b=NTDIxHOERGPjvwY0UxXAJ/1wEZ42U1sGSUPU0IdyUyY3AcMlnUYHQ3YOOX/WhDPRsHhvu1VzuJvZjySlLMC5cPi/u7zgwegE4Oas0N9CRdKjkcIwX9cpqQ6YIlw6qx5u+qpBf3Bxa47sQ8VMzfK1qu2Ca6JgSb5ZbM6P8onPL6GuEVDf7PpTz+AL6s29c0q9mmyT6kpFUkb7d82G8k1VHew0hP2wsC90qDBwPa/J82hKJfNnrP6bjKg9OUVxcbqdsOdQBqsLsdPyfHRQxbUpgDhQ/BxmiTvKdmYKGuKmXl8onvPD9LGkTa6YBfXyuVANQ56aX75WOJLaksduo3matA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNaB71xTIWtITiYxT7URgHoBq+D9yYrNXbbqcXel0WQ=;
 b=farQIatDAPMK7DWHrr3lVdHY4d4GaKv2SwMIVNliwcY0OwPAVTdNGWlmz4cPAHDkX/M4QobgNJKsgv+UAPsgfxPH5hlBROMgfiBb/SKUz5UKKy05Tsbb6FHD5B0DGXk0hoYF1dDzJ5HS4OWC8VimZ5FR9PuZJhsoCnIyW9b1dFY=
Received: from MW4PR04CA0209.namprd04.prod.outlook.com (2603:10b6:303:86::34)
 by CY4PR12MB1479.namprd12.prod.outlook.com (2603:10b6:910:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 09:10:04 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::35) by MW4PR04CA0209.outlook.office365.com
 (2603:10b6:303:86::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 09:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 09:10:04 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 04:10:01 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: update SMU PPSMC for cyan skilfish
Date: Fri, 10 Sep 2021 17:09:44 +0800
Message-ID: <20210910090946.969839-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a09207a-a44b-4aa5-c738-08d9743ac6ea
X-MS-TrafficTypeDiagnostic: CY4PR12MB1479:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1479D442619E4C8242830D2EFBD69@CY4PR12MB1479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEMMDue7XP5iiHmOUCvdns5+no8iR8uwRBemqx62V8uBfBvRT3yGIHft7OhDKT6HMk4T70FSx27chlUoHfmo9gtG02I87CLwWzI8Uy3NVSg+YhVDnzGnBZFFZ1VmWisGGFKNz6pua7SqS+RJ24qW6RscXv8NLeakyEuazjmqF1wcvEv2y2PGowHvXgHM9YXwJtGBdKOXNv5GxdDJMRvdhO11mDGoO2XLu6SZU+N5h9RsCXfhvvTALFyQ+R1QBjJV7z6Y+aurEwJ3oJwSqA5JpbY7h+cjemibwJ0ayqbgiANocKll59aRNB78rtdhxKSIzhbSES2sGoaT34CM+vJ1l8JpMgN0aUzRNJOo5oWCSBoFLwiO9XTNSuAx8z4Z4a6/vYrKEpWnW3HT0EzU2rdVYnzRPgwQ/VAt100RdIEFZ2GZcrj8GbWDSWYu6N0/bxKLExJn90Vvqj0UeCeJQKVOEXsACeaaL2L3GFcOs+ahrN0JA2dtB71SEAHk9DUsvuilg84V0mH4JVOA8PE6bVng6J7aQLCtuj5Y7NLkYVdmGDmbHlcTG2Pqd7GExiQ085CpzGH4J9Eav/rehCN3xvYir6+lblsBSXRBnH6FNxOwN34+yyUGaatmU6dLDlUSeZlRP8GSoBAT7e3e7Fggo9frAEHy1QwFoCc/l/xRey2X84LPRfUAkB+bbrAQ3w+poSImJ09/NxBfyoG2gKUb3uSAkeWkNN+naA42aBaOjYl94YQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966006)(36840700001)(7696005)(83380400001)(44832011)(478600001)(82310400003)(356005)(36860700001)(5660300002)(86362001)(70206006)(2906002)(16526019)(36756003)(70586007)(336012)(6666004)(81166007)(82740400003)(2616005)(426003)(186003)(1076003)(26005)(4744005)(6916009)(54906003)(8676002)(47076005)(4326008)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 09:10:04.2024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a09207a-a44b-4aa5-c738-08d9743ac6ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1479
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add some PPSMC MSGs for cyan skilfish.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
index 6e6088760b18..909a86aa60f3 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
@@ -65,6 +65,13 @@
 #define PPSMC_MSG_SetDriverTableVMID                    0x34
 #define PPSMC_MSG_SetSoftMinCclk                        0x35
 #define PPSMC_MSG_SetSoftMaxCclk                        0x36
-#define PPSMC_Message_Count                             0x37
+#define PPSMC_MSG_GetGfxFrequency                       0x37
+#define PPSMC_MSG_GetGfxVid                             0x38
+#define PPSMC_MSG_ForceGfxFreq                          0x39
+#define PPSMC_MSG_UnForceGfxFreq                        0x3A
+#define PPSMC_MSG_ForceGfxVid                           0x3B
+#define PPSMC_MSG_UnforceGfxVid                         0x3C
+#define PPSMC_MSG_GetEnabledSmuFeatures                 0x3D
+#define PPSMC_Message_Count                             0x3E
 
 #endif
-- 
2.25.1

