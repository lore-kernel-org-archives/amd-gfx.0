Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D0BC46CA2
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFAC10E295;
	Mon, 18 Dec 2023 18:20:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B31610E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:20:54 +0000 (UTC)
Received: from DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) by
 SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 18:10:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6NgvFleNJxhcsmgTqfeTe6eHPd+DK9l8uZTwU+9fZA65RmHACdGXk45nuHZ69HABw0touexcehFO9cPIgv3IzI/g5IlxDVY4Cps5oS5ouxHhzbh0o4EPEIuuD47oZwPkyzHyEcwd3jOvnucV3YUbACZZj1WuQC5X/k65ua4AG187G7ZiaOb4NN6ZQIsOTZRN1I+CsAGzqNrdAWgdE0Ba3gIHBqy9rVT7tqiTA9kiA9fUYyA88KCKwJJPAT3IiLDiJzao7IKfnmnuKnZl+bTzNJK6bbdSP3xIBhAFbhZNCZBXcefcwVATQJIjWYNlVnz/66Gjcj1sCZbnqnqi41L1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFmd/i4qOfBmr2KITkpEcbcpqsZ3StBrt+LEVOY2IxY=;
 b=jMVuDqVgOUTX0BceSo3NhXr6fAJHHwa1lQOaJlD/qDKWHD4Tounr4FP8UXrBFh6KAH72sc9iIQEYcSwdB+ASY+2NqUWVs+qC/MIDNsLmEcRepuyDuoXMvno6a//k8FUfdcWyi7c88W6wdrnbc7TAHPBHpdaRKH2HIcTk612VHxiLgtgTPfhOgYcusp1ChtcvfYCAvIhrfXW4oiNKiJmWOVcKBroqO5/tzL1OllNSkIm9ROR/er+eTkrYQwU42R6hLtUdLRtdvimxz87LK5JLJGx0KLisukpNYjRXjTbVJLp302UwZUuo4bWq2GJjJUrxCK3AYt1naZfF6ZB1Z5LpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFmd/i4qOfBmr2KITkpEcbcpqsZ3StBrt+LEVOY2IxY=;
 b=Yln7oCcIiZuZufsNwyuLKrdQ0HxcPHNMShRFypd3a5FwIUTjjUQKdhpAvxC6koad1OCJuCD0HiVkQh8YI9VH5RUiqq5yuYkpWekq+igCZjh8uY5lSGHbFCAnsWGWezpOonR7F+DmLLU0rASvg3lxqLfhy3bmfNQcsXi8Q0DviBU=
Received: from SA0PR11CA0061.namprd11.prod.outlook.com (2603:10b6:806:d2::6)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 07:10:34 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::ce) by SA0PR11CA0061.outlook.office365.com
 (2603:10b6:806:d2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 07:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 07:10:34 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 01:10:32 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/pm: smu v13_0_6 supports ecc info by default
Date: Mon, 18 Dec 2023 15:09:32 +0800
Message-ID: <20231218070932.2307244-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218070932.2307244-1-YiPeng.Chai@amd.com>
References: <20231218070932.2307244-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DM6PR12MB4579:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: c747e338-412b-4c32-80de-08dbff986de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMYl3jBm87xiCPFz9twj9PF+0VNxSLgUUer8qe7KxYff0ND8gTaXmnwCA3l1dgTRhXQKBUztoDt+p1LjeW3o281uOc2YjmExIsKqH7a/5FFiQOBwyIYy/T++yYdO8iRnI0Qh175HybSW/YIn9B/kvLvE/TeqRFSWzdYLqFHWAyZC87+Umn3ErHvW3UCmdMuv2mmT3Vy56Ma5JEbVBkJ/5feOjtvkfJ/p9h+C/IYmKgvnH+YjGSXoGvtDd+BRcp8ADdPAcf/AzOV6/Uen/0NAEjL8e8JtCxq8NB5Q3P96LUrEo33z1WQH1Kcr31O2rxs6qzAHLbME+GVlv69/3xoITvljh6IQ7RuSv9LvVVCfu39JSmpeGUs24bBdcOMWCoJBCSkYjwfCz2k6hContbHyNXZJfHjRj3tm7L7RX14h7RUyyzts5shkrfgVm0Nx6g3BVA1/jNtWXdaHZ1otz3ZgMUOMEPSsDqfxH9w5ve7cwDq+BSSvin9YVywOHxcNhZ4YJ5pMwULeaZnvK5RVp4Hcrv4+IQYal1eCgnF4wF7Zju1AWIBpJzPH0ck7v4W4A+jLgU+odPUGIoxDfDjfUt5DebwfYCNlkiF9m+xMEknTHvY+iXn5oFkgp6sGGdjuTfIs4eqIL+PxCzRTw3x1rFHy7O5DsIB3PU+lbSKRzt4aT3HzSHJiayKq0ilZmeAA9jdXKkD0sDpxWYWFJ+5bdHqu9hBQC1VJB1ZxWFW3XxFyTInowtUAzJw+ThMy7zG3C40FHbtuMO2HMgWlqM8NO4D2Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(1076003)(426003)(16526019)(336012)(26005)(2616005)(40460700003)(356005)(81166007)(82740400003)(36756003)(86362001)(47076005)(5660300002)(7696005)(36860700001)(8936002)(8676002)(4326008)(70586007)(70206006)(316002)(54906003)(6916009)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:10:34.6392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c747e338-412b-4c32-80de-08dbff986de4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
X-OriginatorOrg: amd.com
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu v13_0_6 supports ecc info by default.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bb3e953bfed5..7d0cbe840182 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2862,6 +2862,13 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struct smu_context *smu,
 	return ret;
 }
 
+static ssize_t smu_v13_0_6_get_ecc_info(struct smu_context *smu,
+			void *table)
+{
+	/* Support ecc info by default */
+	return 0;
+}
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* init dpm */
 	.get_allowed_feature_mask = smu_v13_0_6_get_allowed_feature_mask,
@@ -2916,6 +2923,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.i2c_init = smu_v13_0_6_i2c_control_init,
 	.i2c_fini = smu_v13_0_6_i2c_control_fini,
 	.send_hbm_bad_pages_num = smu_v13_0_6_smu_send_hbm_bad_page_num,
+	.get_ecc_info = smu_v13_0_6_get_ecc_info,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

