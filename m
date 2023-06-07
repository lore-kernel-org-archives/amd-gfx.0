Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF78C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C34710E4CB;
	Wed,  7 Jun 2023 12:16:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19A510E4CB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcRpEqUABXxWtWVk6OWjPtVa1ZdD0/lDtSfHbaewBtY=;
 b=io1bRltwwNCBmuLWSElJLxJDmYwas3XhyEmqvK+6m0BUHJozNOZEa/WvqBEMQxmxwKbdQ4j2dlrf0BI0Zs8qiLzvnhjwz0S/4P3lhLcrdPKZ2MZ1Fzn1LipC8YaKSch5fBema8qKZSfzFy/qw0BOemJNn/bHDVZ2fRVwVmiFOa0=
Received: from CY8PR02CA0003.namprd02.prod.outlook.com (2603:10b6:930:4d::10)
 by DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 7 Jun
 2023 12:16:16 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:4d:cafe::75) by CY8PR02CA0003.outlook.office365.com
 (2603:10b6:930:4d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 12:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:16:15 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:16:11 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/20] drm/amd/display: edp do not add non-edid timings
Date: Wed, 7 Jun 2023 20:15:29 +0800
Message-ID: <20230607121548.1479290-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DM6PR12MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7646ae8f-f907-4fb9-3c75-08db6750fe06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltNWDa07qUZB2LMmQIiuWlD7jxTEValuxKSZCkwaf1jtdcfZNwubt1NKI379LP57HykOtGhNdyrkNoTlYLQ0vWvF2DwgTAm21GCUA9oIjEeHdSNjm9DWQOl2DmV8kctbfLklx0mnzO999R61ofKrLoAS8WucZYUvoTwCN0fkj1ElSLXERunj3RqREJlO3c/LA1Fpq4JDNAd+N6MiUV3ryrivjRG/ZuVVNY/2EIZftSkYQkMdjHDmiHhPL5Vj7Ac0/kAI5YcFuJTy7CNBJdAkkEzJl11h0crvEBQi3M9p8R6R2BFaHRhojYj54xKwtLheAaUXSgAShZvZtOdRcIxFqoD4fTFCmCfNQSq7Tv4HwkDdxzqsiIJZkWOEnd7V25o2cZ18vDXkVG1KTrpIYPIDr6FQFpyqYPp6bciilNhd83pFo/WpqcvzApaiAIfHIjHwaS1+6Z4x752CV4xNe1u2/5/QHZjN9M7euLlBJ0rwuWvqWipIthwoa7iZp8Cw60/WvpWd4fgyl2AKmtncS9lh7oh+y4Ev9xYxXsetS0cBQEvwMn92FGR4crC0yDdDbqR9i91myVdJdr0ScDtDBvhzZgxm3c/2cqdVMItw2fSJlZGaTKM2+415vAE2CrYKWYghqrcEmETXwXtvZxQ850CXlEcj7OPg2gadY0UNM/TEqi2hI1N/yFYu0Hd7t0K6G62vLRBPiNHV+xjjeCOPE54mFEIlsl9NBIdbxiYm5+wfkrROe8eygKrMnc6V0X2R1JRXZf+HRg4auZ8erkPi+vVA9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(44832011)(5660300002)(8936002)(2906002)(316002)(41300700001)(6916009)(8676002)(70206006)(70586007)(4326008)(54906003)(7696005)(6666004)(426003)(1076003)(336012)(26005)(186003)(36756003)(16526019)(2616005)(47076005)(83380400001)(36860700001)(82740400003)(81166007)(356005)(478600001)(40460700003)(82310400005)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:16:15.8985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7646ae8f-f907-4fb9-3c75-08db6750fe06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 stable@vger.kernel.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 wayne.lin@amd.com, Alex
 Deucher <alexander.deucher@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] most edp support only timings from edid. applying
non-edid timings, especially those timings out of edp
bandwidth, may damage edp.

[How] do not add non-edid timings for edp.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 59badb125736..9279c1d474f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7236,7 +7236,13 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 1920, 1080);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		/* most eDP supports only timings from its edid,
+		 * usually only detailed timings are available
+		 * from eDP edid. timings which are not from edid
+		 * may damage eDP
+		 */
+		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
+			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
-- 
2.40.1

