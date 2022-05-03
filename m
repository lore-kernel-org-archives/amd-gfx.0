Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4CBC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B68B910F409;
	Tue,  3 May 2022 20:37:35 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E4810EB2F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je+VnkXfDLR3ARLJziyTbsEBB6+X3A3ZJwTCYO5vVLymfgufEhR5UhaExsBHgxozvyMmuXx1HzwExCmKHvHriojIH+/0AwUYs+NDPSTDip97rej8pMByMy3EM+LLDGRfTx6Dq5GBbL4rBVJBM9S3GOByAl1Z4e8g5FT1p23k/bASn/YreWGMHcP2EcOC51Lo8rIiJn3R5bbVgGyPWCYPFH4YbmTc1q+bmn2DHTG6NyMxqNI8/x6thmdJRTKYuYu1igjwGvuw1Kn9egEG+sY4FJoCtt/PeJt5CwSqBPl7SkempU7zXzffrh0K4WRysekwp9h1fS84YckRd3jiD15ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnIGPbz53mn2fUO3cpD/hFw55K3yZdN9xPp8f/TfGQM=;
 b=YbAHGMWUufpXGuKf2UWIyfCHGzVPi741onRHi2m1R8Bm0QWLEwSjOVIK+fhEndubi0D7zT0Vt46ODK8v66j8zQIE2cGBQC1GmzAWmKTZg0qSoXxXyzWk/0RjjC6DFyyrWVoHvcnBfxq8PeFdrSbv4dfI2iccdpFchpD5ZM2IlnOkECukQ5ZXsBHsdY+OxjUTGuXBrUolqW9ufsiwjF5jMjXX6ruKwH7fhCtqklCmiyKleZMHfIJyhF0pZ2VnYRlNkbvlEOQdFIHfhL9xsfPJnJZOvfhy8cwDF7V4p/BiOtBuCn8CHxvrq7WQCzrEOlk2ZxecE+yen3r5Okdz8m4xpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnIGPbz53mn2fUO3cpD/hFw55K3yZdN9xPp8f/TfGQM=;
 b=hRvsvGNiWPf1TQ9fOrPrQAl7Vw86iNkAGu5NS3rIh3gjsYGdMDUx1jVtR/EX5NCiCj3NREZnBxsQ2i6coVfAN9EVZBHifRFgIGF6n7vLkH1BqKh/VVEXUX8atC0MxYA3tcPzrZ9DbTueLBIXkbCzrBpW6BMo4HN8X3CKpQEtYRs=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 3 May
 2022 20:37:32 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::ba) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/26] drm/amd/pm: add get enable mask function for smu v13_0_7
Date: Tue, 3 May 2022 16:36:54 -0400
Message-ID: <20220503203716.1230313-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4ab19c0-6e6c-4567-0afc-08da2d44bff2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB141862884CA187F3B6D8EE63F7C09@DM5PR12MB1418.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgUtftkTRbgmPihqQ7bs9LlDP+2YcbFUxYgWdrvbyw/AA9jWKbwr/VPN6qyJFT2KOsPYknb/iYXXtOopFUbOaHMI4NTnhmQ6kVtCeD/DqhBumH/nOQlSTxKElJReBGsvg4waOuwSPvSYpyj5ZGoQqyUjHK1z7wk7pGhIkA9S9HJPf8TEMaSYtLAiflWiBIuTTmvQoRWXSa+5iQQvZ/QY6aW3Jz3rdj5n9ZO7wMxcEzHL2K0Ack61ek2UuRM4/XCSFH8btWRqI1B1oWbSECeZ3kEoBn6XPj9v0lVJuXj5fK5oYgTXvY86JMOijpyUKDqVPQYflQK3Uv3h9wX6mKPp+KAayoSJYv202jNz9iEJ9J3HR5jhGjHNweaiN1nbVu5lEGgEZZ3JvsJ8n4y0JFFoQ5AwfzRCfATrgj1+8zqY8KWlqVFSq/Sku/itvVYk+76tE+g57ttDx4XVLEpfnkoOmqwWj1RmUD+dnVhesgUWBir6zUP1ZH0Byaba4dKRXwOWdefVDxEyGwdJSN1YYGbAAXpgu3O7/i0bbZWHe2UXiKEGaKeNsL6jbwE5xZBplu5gLCx4HUn8fQuYb1Lv+z+o2xocEHE1xe3HE7jGmNc6dXkKAtlQJ82O7o1WDEJDMKTIm5I41nlveM48DuPcHLM68iqHmdj0a6YfIZNo6SDQMhC69EGeCLKietbXIpfxr540NL63RqYtmMPIVTT8GYbiXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(356005)(4326008)(8676002)(81166007)(36860700001)(7696005)(40460700003)(316002)(47076005)(36756003)(70206006)(54906003)(70586007)(6916009)(8936002)(86362001)(5660300002)(508600001)(82310400005)(4744005)(336012)(426003)(26005)(2906002)(186003)(16526019)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:32.5808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ab19c0-6e6c-4567-0afc-08da2d44bff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add get_enabled_mask interface for smu v13_0_7.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f62402f698ed..bb183f4e1623 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -457,6 +457,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.system_features_control = smu_v13_0_system_features_control,
 	.set_allowed_mask = smu_v13_0_set_allowed_mask,
+	.get_enabled_mask = smu_cmn_get_enabled_mask,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

