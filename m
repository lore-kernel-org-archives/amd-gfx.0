Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B1CECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3036110E808;
	Wed, 14 Sep 2022 03:51:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B13C10E808
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlHPCQtyKnxkSSXFkACg0tZBoJQfF6out/zUEp74BHoL6FgUIL24H6Fmeh2R/mpoRzJlaqXgt83Oc0DO2IF1312dAL/F1zQFUfI/PgDxb7c2+qapJLwUU4i8vXRhu9vIdUenILVfYhINY8DY81ODiJJCaeel4qL3T3fCFM/wbomv3y3VBt1nbFiG5kWkUIqxmVTzYuiPIJUU0O3iVRxTkN7deBA1J3PmSOosuDuzo3rMpOHHet0avS8YLOI/iwvrlRMy3u1GroAkC1hKzPM/3CVV8jQzaGPhz2d3r5dQXnO2xMHQpyaHOTEwxUr7EV7m6lg4XBCjRx+WvAZmea6gMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM29T1x1rH/IJq1msxFUGvJ8GGpg3TV31j7SyKEDSIE=;
 b=ni8dXP3gNB/qRL60kg4uC8U9h84xAng3Elbpx4EK3g8HH9QxHKsEKfSOOGBCBhmKFYHow7vlMSY/spQNAWYy70lJit5oxbRFaQGZNiX+RC5FPVSdxaMrYXaA9MW2zcHJZccHoEgT1nGmNjf6jPzjrUp6faJOyiljBNAu6I1PEUwy9yXOl9u1ztvVN4bQDckgKk09IYBhOGWMOuv8DboCIk1pxEH/BUqTSwc6leP6D9ndLabTRJRHslyRPNLr/0t4GqAJQvFPwkakC4zNlwl302nSZntLgDB77lybc2e6pY832kXjkkhdt6RzYkIeOShXhGvdGSf+O3IcIrxSQhZ0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM29T1x1rH/IJq1msxFUGvJ8GGpg3TV31j7SyKEDSIE=;
 b=cdSDZB3uUMix41QFN2EzlOnQIpqxXGJh37hNlpdlb9u8EMiYj3IFi1SuDhRV+JgdD3loFHuXdRqGU1T8C7GQ5FkMJ2H3jBb5j018G4hmgSfyzGwVmjgPhPrGhwmt9srnLeJk4r9YrdLzvN6/cSy1360Y7YAbsK+2JrlypS0cIOU=
Received: from MW4PR04CA0203.namprd04.prod.outlook.com (2603:10b6:303:86::28)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 03:51:49 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::f8) by MW4PR04CA0203.outlook.office365.com
 (2603:10b6:303:86::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:51:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:51:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:51:27 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:51:23 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 17/47] drm/amd/display: [FW Promotion] Release 0.0.134.0
Date: Wed, 14 Sep 2022 11:47:38 +0800
Message-ID: <20220914034808.1093521-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 850b6fab-bb3f-41a2-a3f9-08da96047412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYQwzKXFxhJpLEBd9zf2T2dwyzenbXPIMeDjvGj2gQ3wnjZjHSQ5Xg9hMRNFV9gULx3FY2y5lwS3iIcrO7Am9RHsLuXhcnxVunYNQuPyJohStfQMBLe+T6dkVasABQUlUI/i3z6jGRy1Bk7SP+hU5kYxpcadh0FoEYiWUlIAiie7/aHIgo2VXqqbv8XM5IoUakgZQe4ygaAuf5DOAbIO19OlrFOj6+i0YrqqNX5ZEZ7zwuuV99JWLTjlLEa6/RaLVA38llPYCZHMpbvM7wh/jzCZqHJG0dk9QgnJay0IhPyHapa2/ssRlrgbh7WoE9i7RxVUJw3pgnoo5B6Y64oVbdCQu8LJJxeF3PP7E5QsP+wBBM4qp8xVNjvT1SDFtH5AT9e6zcwkSHajXB5HkIbPmyYau5lrIGsYQgneFsI1zxr5GhYQQfkU85scG2skvKOnTV6dai7ZDK/gsuMnSHHnWH1UZWfywmLfIw4W8rXxJpaSsI6DgRWwGXIend95eZvCGN2xX0HLW0VGcIIUAZNjvvKM7oAMdTxcvB8Ad9hodvasHay9VHIwMYTeFy4qM3qto1Qp6UGrrTNwrflIJQXDe5Sigxfy5BxcSqH1hernSEziWgtgfvCVov6unzt3LuR52qSgolOATlZt0ddXGs1ACIRsjSUdvXQzbX/I7A+fjphCsAeEM4B/ltvcdlHd8VTMsnc/kI4EhoGosTroW74XpszDkRUmrbgdqJ7PRJytnigJylx3eKbNd+uUpQQEdzNWkSK4uSB1hR5pt1oWXkP6OsLac0dBlDS3zcjprLQBUMW4cKiUIHxnGYeNIwVmxwQo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(4326008)(2616005)(478600001)(83380400001)(47076005)(1076003)(81166007)(41300700001)(40460700003)(6666004)(70586007)(86362001)(8676002)(356005)(36756003)(2906002)(26005)(4744005)(316002)(336012)(82740400003)(36860700001)(7696005)(40480700001)(54906003)(186003)(70206006)(6916009)(82310400005)(5660300002)(8936002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:51:49.6042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850b6fab-bb3f-41a2-a3f9-08da96047412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Handle pipe split case for SubVP:
  Pass in pipe split index for main and phantom pipes

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7cddbc431b57..6b9a529e9f12 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -998,7 +998,8 @@ struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 {
 			uint8_t scale_factor_numerator;
 			uint8_t scale_factor_denominator;
 			uint8_t is_drr;
-			uint8_t pad[2];
+			uint8_t main_split_pipe_index;
+			uint8_t phantom_split_pipe_index;
 		} subvp_data;
 
 		struct {
-- 
2.37.3

