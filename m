Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A20BC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E8210E9C3;
	Fri, 10 Mar 2023 09:33:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B9310E998
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz040oGjw2KCOhqCBL9i6X/UupZY3E3ivA6PbUrQQMR4CS6GJYInrRxc1KeR3qyKyR8/MibZ/dBLtJV5P0czsdKgPM1CA7rccK7FHKdBVI1aqQkJ4yzUrcA95+2AtmyQHPHrbtuwPefDgYKrS39UpXL4FxFzg1Q29P9Uhjc+7+MTwRJ/WIf/N8S8zspvvQBhT/wFjJljMkK38AEKpc1z4VqtA8maZfwz5Mw6t7ugtanEIIvOENI/QVHX1jKGK63/YJnqc6URhc6mQsRd7VkdZV6XlKLshx98eh/YrUFYm7A9IVvaDEYXf4g2+HREoHij7noM5VcxRRY7H/4hBGptGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UF7tCPVIfqcGlpKm9Ek4o0RWQqwimunlLHRIaXkXLo=;
 b=LVRVewPwCxmWQbl6y3gPUdnuWTvmTYW1tk6tSg6PYslVgftzb39cOlh3LJ9wSfqGwIS/VnCn7DAz7900TojRQ91+uIEqsbZeDE/nexocg5zrK0qd8FcPaP5pCCMv+om+LBuAp4Gwjg9kJwQW+y3KMBbnXmbhre35Mzl4c8uK2B9p1NJ/ODoVACU5x5GpiH6BHZdTVbDlMVZa4qgKuI4/rvOWhqC5Y/XpMF/EP2jQj8QldouWtJbMi9hIQsITzvoThPRCVRZxlPku+F6KDIpnfU0AhvwZ7OUwDkAZ1mwIgKlJo1A8JyJ3Ctt7BMS5R8SRYQeGV5dVqlFgZTDEyvK7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UF7tCPVIfqcGlpKm9Ek4o0RWQqwimunlLHRIaXkXLo=;
 b=aA2nVBanWUNOIIlaGRenrwp4uxVFAROuYYkW0GoLDyOJR58INoBjNPWkUdfIJaFp7R8JhQ17IDh4Zd475m0EXrVq+7OPEDfhq8G/M7ICgAHc3r1FJ48QZWVbu7yQR0EIk961dVwcRZmAVufT900fEIjra0+52a21+4qEhWNyXRo=
Received: from CYZPR12CA0002.namprd12.prod.outlook.com (2603:10b6:930:8b::13)
 by CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:33:13 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:8b:cafe::1e) by CYZPR12CA0002.outlook.office365.com
 (2603:10b6:930:8b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:33:11 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:33:06 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amd/display: Make DCN32 functions available to
 future DCNs
Date: Fri, 10 Mar 2023 04:31:13 -0500
Message-ID: <20230310093117.3030-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e2c0f1-5b56-4517-9fe9-08db214a7765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzfqndd0ipPVVCI6SIOmEV8SGsrZq4fr+kIjQvn2Wk3ecL1QMMRO9Rqs90w9qnAK15vWq/t4L3geB/0XTy5agGLc3tk/derloYD1/hoRAn5rFTOqxKbA2bZLi5O2IUfxEx3it36hi4JV5CQwQ+w1CQdLrs6b7IWIK376F0Aj5Tf68Ti364tu4UCMexxfiqlVyYHFoprot0IT0Wne0afEtlCT79szhMfcDUGJAK7SBO+Zoz0OyZAb8bIfFosfBrFUK5owzZj2Eo/AeWj3DDRWioV3r6MuGTzEFu8cWZKrzn7g2zkJv38mft547GtCX4tpBTnguHmsJI+N1n/oau8vBleX4AsVGw7IaHJNREuyMleXObRI0zafLFrLVQzlWppjuPuq0vd3iUFUTFhiw3Y2AG3s8aOcr64E4zEfjuyhFiOK7hqVNp3Zc/iJPj6j0rQ5Ia/C8QMII8Gl9UJlTnPLRbM8olo4ZMOquwjcDV6t1xt/+VagBKCBYEj4H6p26KXGHgQkfvaFzoaZVmCLfHKPb++4xPLcusXyoQeP/gOat3Jj3Ty+dJ+7zwvRjxZ60oC/kRjItXtt+FNyUfZPV0giVQ5npd/qPuC8nuEtbMSkj5iDW/s0u3pbxhITqxdhfGtM8fFSMxt9HAdhDK01US+kHs4qVNzLh2nZNclZdrqbxi6fjCkNfk9VXWpt9JX2EvHNcbG//GzOGY8KQoRDBrRk9BDY08bOT2Hfqmp+Q1mr7hE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(46966006)(36840700001)(40470700004)(336012)(47076005)(426003)(316002)(54906003)(40460700003)(36756003)(40480700001)(356005)(86362001)(82740400003)(81166007)(36860700001)(1076003)(26005)(6666004)(82310400005)(83380400001)(16526019)(186003)(2616005)(5660300002)(478600001)(8936002)(41300700001)(44832011)(2906002)(8676002)(6916009)(70206006)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:33:11.6408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e2c0f1-5b56-4517-9fe9-08db214a7765
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[Why & How]
Make DCN32 functions available for more DCNs.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c |  8 ++++----
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h | 13 +++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index 206a5ddbaf6d..c8041cfd594d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -42,7 +42,7 @@
 	mpc30->mpc_shift->field_name, mpc30->mpc_mask->field_name
 
 
-static void mpc32_mpc_init(struct mpc *mpc)
+void mpc32_mpc_init(struct mpc *mpc)
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 	int mpcc_id;
@@ -254,7 +254,7 @@ static void mpc32_program_post1dlut_pwl(
 	}
 }
 
-static bool mpc32_program_post1dlut(
+bool mpc32_program_post1dlut(
 		struct mpc *mpc,
 		const struct pwl_params *params,
 		uint32_t mpcc_id)
@@ -701,7 +701,7 @@ static void mpc32_power_on_shaper_3dlut(
 }
 
 
-static bool mpc32_program_shaper(
+bool mpc32_program_shaper(
 		struct mpc *mpc,
 		const struct pwl_params *params,
 		uint32_t mpcc_id)
@@ -897,7 +897,7 @@ static void mpc32_set_3dlut_mode(
 }
 
 
-static bool mpc32_program_3dlut(
+bool mpc32_program_3dlut(
 		struct mpc *mpc,
 		const struct tetrahedral_params *params,
 		int mpcc_id)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
index 61f33c0d8e59..2c2ecd053806 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
@@ -310,6 +310,19 @@ struct dcn32_mpc_registers {
 	MPC_REG_VARIABLE_LIST_DCN3_0;
 	MPC_REG_VARIABLE_LIST_DCN32;
 };
+void mpc32_mpc_init(struct mpc *mpc);
+bool mpc32_program_3dlut(
+		struct mpc *mpc,
+		const struct tetrahedral_params *params,
+		int mpcc_id);
+bool mpc32_program_post1dlut(
+		struct mpc *mpc,
+		const struct pwl_params *params,
+		uint32_t mpcc_id);
+bool mpc32_program_shaper(
+		struct mpc *mpc,
+		const struct pwl_params *params,
+		uint32_t mpcc_id);
 
 void dcn32_mpc_construct(struct dcn30_mpc *mpc30,
 	struct dc_context *ctx,
-- 
2.34.1

