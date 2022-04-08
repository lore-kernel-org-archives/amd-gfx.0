Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BF9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB6610F131;
	Fri,  8 Apr 2022 17:27:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A1010F131
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nj0sJVFfVDsfYKygGe4pAZ8TE8XCtL7Gj2okT4OAocQ4mI3rr4VblycLXDiFEp/BJw1pGQfsq2ZvfVwez0W4kwcr2ssmE+zbUgGBGbvC6sXrPyUBMFIJ0xmjpSuzgBEWXgx2Ht3Q4Cl+jNC7ZOhT4QUeud/fi0o5Gl+n6t9RUGXnXH6uljOsRmNSMuh16DcU4SurJ1qmBcAJ7N0ihBaFhorVOvjckcKJvNX70wRICSv3C3ljbSGs+Kn5c95xOyPIjJrtSDsi5vtF0ZhxQb5u01A3UM/NXPwSL09PayvSdhHc1fsUCihRimanF+NUl1vLMVVI5oA96uixyDHPg38liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGe+ZqxfUAgGcEFxgrkQLdd1Z9ulmkktW3jaGr23vJQ=;
 b=eUQtpLungT7kJIXm1Vg8mkg12p2Gsk8uctdlYA5T6naSfxGzTzoJJURCyuatLFlMjdQ8bNEbI8VHJGrok2kuCj3mcN8O6ptmW6UbYy4CNd6gwrUDfZyUYcig+LcdbIb1hEMj6DPefU6KI0iEuTtj4RehtfAITK8owvhy32qgdqD4WCAQ9S1Unr3t+lQDpYMhBG5mtGIjgo5tkpOQBGHnFx36yS9zbELrkGvpbFXVQkLfay07NvKYXibrM2tAStvWgB7p1RGvtwrxSm0Ko6djYYjUIg03rTqiaGS8nBcvmijLPiaj9a1AgOrwQr1g6Pe/ePSuQ0Ah4BC2Yb5rU4Ec8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGe+ZqxfUAgGcEFxgrkQLdd1Z9ulmkktW3jaGr23vJQ=;
 b=xHmYh0sM6IxfEo5oQl1L+otdRjnxHw/O5KlsDWFFFuaMVXRKun4E++mLXypHMk6VQup5zXW15sI2wxFChQy7pVK52/xr41vzR8sP01FMwv+LRZbQIAYzvdJVTneCQ4fmyXmKAEhAWOYebCy7YbmHx9NdDJZvMlLs6kYYsi+NlRY=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 BYAPR12MB2933.namprd12.prod.outlook.com (2603:10b6:a03:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Fri, 8 Apr
 2022 17:27:54 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::6b) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:54 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:48 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/20] drm/amd/display: 3.2.181
Date: Fri, 8 Apr 2022 13:19:10 -0400
Message-ID: <20220408171911.601615-20-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25ddbe82-1e65-43e9-f27d-08da19851d8b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2933:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB293336A9D780B4B05D4B0523FCE99@BYAPR12MB2933.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si8p5QlKm53PMXsw6cfpfiEmRNhx3Rlmgv/AwGG5FCGyqMBwhNO+n81mua38B8sHO8zDK7gcSU1veyyHI6ajKB/9mXFyng0atrZ0BGXNKAmm0GQQmnIhdd4UR5S8o2cV5Ka6S4/EJB/TieF2UCBziDFq7VAWxmv6+yjQfrl34QtfJREuVSKaKiGoJ5esB0+MQd47W2RoRRCYRVWNcSLBXc2fcWUisDdVEjF6GtfCpPbKd/jU1chtyOBoA+RjzkIwcVn6DswH0+10Sztmb5ZGkAy8wMT2lW+D8OlGQV2YS/Tyzt9sSFeLlpZ34bSqxzwiZqxwEQuz6mHXGpZyVX6E/CwzhOw0WnWhDP6+95kt05txB3LXtPM0EPiy/rUbFUBefZA5F+wf0YsnRm3uJFI924rFFyoHaesAZTIwM+jae03KEfj/klQjgPo7joemRu12AO7cAxVlIZHgbTUzeKOM1d3M0TdVf3Kg52uKQ6bK9VRMSk2VTov11nSfU8mxPmYH3Jg23yZQ/gb5ikPc9YdRCTkoikoPm4Q2HVZcelYlaW7BEilYZz+GDmq2q5x1gViI5NozS0Ufw2Yz38T2j1GVcW0la9ijzM6Vqx5bCOuQ396xyPfCgHz6ozmkDHg6yPee9BcxJzm+xn+55LSs5GClf+5I/x7ceLPmtRHocTa8xW4B4z33UGShclkl/gt7oy57UO162IobBBTG7/PjxQk9NQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(6666004)(508600001)(70206006)(36756003)(426003)(82310400005)(70586007)(16526019)(83380400001)(26005)(186003)(1076003)(40460700003)(336012)(5660300002)(86362001)(2616005)(4326008)(8936002)(8676002)(81166007)(6916009)(316002)(356005)(2906002)(36860700001)(47076005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:54.2308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ddbe82-1e65-43e9-f27d-08da19851d8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2933
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Title: DC Patches Apri 6, 2022

This DC patchset brings improvements in multiple areas. In summary, we highlight:

*Disabling Z10 on DCN31
*Fix issue breaking 32bit Linux build
*Fix inconsistent timestamp type
*Add DCN30 support FEC init
*Fix crash on setting VRR with no display connected
*Disable FEC if DSC not supported for EDP
*Add odm seamless boot support
*Select correct DTO source
*Power down hardware if timer not trigger

Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 544d58260269..2f0c436dae4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.180"
+#define DC_VER "3.2.181"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.32.0

