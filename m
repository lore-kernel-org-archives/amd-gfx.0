Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA6CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 11:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE7510E3D6;
	Wed, 18 Oct 2023 11:40:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BB310E3D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 11:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsEtO7Xzeis0XmuuaHUHGWlBa3u+qXJYhrllw7ICa5fIOOYKdk1yTsdApm2ZDqb/7rNAr5Hdq3985sxsvIVwhdRxuz1N/sabwmsE6D+Xt7uvsV4EWvex//kMTDyb3jra03lgCi7b2ri/Ko1beXtfBidu1nvdC5QIT8NkWXcss9t94G6gZaWkfjbcT3eB/LTk9Ot2pLoNSWc8HqefisD3+kgwaNqJ5llkA1OpXzrgqqbiEIPF3RNXu9xsP0EFafwHneamLgWrLFFg0rP/TXITeTXUP188hTKZ318BERa4SWkmYOD9/Qeclm2yCY6QLpVyEtSR6fsk594JvkG8Tp6o9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J3hFV9voIRNSuAHre7WAu1QKo0K1/JAVt3AuSHojH8=;
 b=f8VnrORfHfBYdxGjQDyl9jSzMz9EwQ3oJaG7UWYVDKV1OQyJHn/a6EYtKwvFvuyBkOIOqYegoUh8MLM3tjfQRIAX/cs1UOHJu9Y1UYw4lR4sazSPUmaXnDmTRDZyM65OfklCzMBuc6fmVMmpfO0TjoCx/TofuJwc/ylKKV7pGCcU74Cl+kV7aI6QFhzU2qCUdCklMFKtaOAs3TTaCJyBfJGZcpm4uAc/dOt4d7ANUzoTVXBV+kgJeWmYuxFo2A1hPIBSGiTPgCIxlkZ+JQdGoMSOhtyQUXtgCGzkaFaUmk0m4CLnfbUaS7+xekYnPXNTTxQekt+WJqUiiscU6yXWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J3hFV9voIRNSuAHre7WAu1QKo0K1/JAVt3AuSHojH8=;
 b=UTr7xS9Mw73AnF207CkMgHEB49ADahDvkUwb98uxY+Wz8NFxN7JsRqy5MHzlOYQ0GRjnO5o4jAMVqHwCSV809n/85UtiWddzLY6OnzbnBZZKsvhhkxcXs0yRC4iZuWbEcTCTqBxINmCnDYhotS99jtwltzNR1KRZ6M1cH7rvb7I=
Received: from BYAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:a02:a8::27)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 18 Oct
 2023 11:40:32 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::49) by BYAPR03CA0014.outlook.office365.com
 (2603:10b6:a02:a8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 11:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 11:40:31 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 06:40:29 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 4/6] drm/amd/pm: record mca debug mode in RAS
Date: Wed, 18 Oct 2023 19:39:55 +0800
Message-ID: <20231018113957.20079-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231018113957.20079-1-tao.zhou1@amd.com>
References: <20231018113957.20079-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: e82aa0e1-350a-484f-ec0b-08dbcfcf08ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7HvJBUIMjtKf9F3BJ6hiGbGIdfF4WfYBAiMAOqYlyjPW0yA7uFCdq63VqssreaVugF5gzUd8aZzme1AcnUu22DAJvZQhU/NN6ucgkiFr92O9e+nE6pbLaoHOAk5l6qeXY4NIjHCAP8xqFq9OLi80UT6qwcXJQ61QJwkX1a25q/FgE4DzE4Ij7vaycHW5LC3FM/57K/0Di55x/KXssm7rUFLTa0NHKSLKl18o0LHNbVh0Wm5QTwlRdE6KVrbWHXZpN//B+dyCjhPKtOr/gKFtrwOJWr2MK2+JnM79tj86aYYNBNnEoTycIV1zGgA/HNIu2hREmkRC9TQ457xwmZx9j045TyC1o+TlPMs8NeQRLRmaUfIO5hIPIb/KzQCMDz9bB2TeTXpbNU59ebIN3km6Z4MoCgNLYVk5movQqLOTscKjAKDy6NqA+295CJrvz1fSDkq6mg+QkrI5a3KQX8gGTffcVJ6uvLDNs6/MQZSIp5GECNMS3ZLAGgT9rnE8lcrzIvvCmwH7C1mTELgewccrTPhwwLNZOJ9oMM1X/leCU2tsP6ra/qhJZqznyMJi2A88VzlQgtDunlLJLJw0leSuR+vitj3lA66ZQlN+9kn1ag9Z6oWRIgIe5gBy2irKGPvjBaG9EUeIrhOBXfQCelsqogJmGcTSYFT0OemoXcOL30h9Jfc0cn15F5oIC8fGMK0EJFpjHnO9Xcc/rexc3I/yqjEdH1RviYhC3fJSXqvOIVmhHO1uBsuSx1rywkDNW+c7p8qzX25CcWs7Os6DkyuCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(8936002)(2616005)(336012)(16526019)(26005)(70586007)(70206006)(4744005)(2906002)(6636002)(36756003)(1076003)(426003)(40460700003)(86362001)(110136005)(47076005)(36860700001)(6666004)(7696005)(8676002)(5660300002)(316002)(4326008)(41300700001)(40480700001)(356005)(82740400003)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 11:40:31.7397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82aa0e1-350a-484f-ec0b-08dbcfcf08ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Call amdgpu_ras_set_mca_debug_mode when we set mca debug mode in smu
v13_0_6.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 74fc945a8f9b..c5c1f479b925 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1475,6 +1475,7 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool enable)
 	if (smu->smc_fw_version < 0x554800)
 		return 0;
 
+	amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
 					       NULL);
-- 
2.35.1

