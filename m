Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9239CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA54010E4DB;
	Thu, 20 Oct 2022 15:48:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8715E10E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCHjFWc62HNKi95RZRSqeUon9dzGQdE6gaWhrR9A6y5ZRuZxzeCeORNfC1Fw1TRXe72D+9sELrZcQJnzTzlsEc4mUEocdWxIi6RHaVDhVUhvVHkYAqVoMPEFkHF0y+Ahdl81i1WHexAhjNOFnqWRWeAHtZhpDTHTAOg95l6mVX4ydH1sd3o6HhDV+6UT4IrXKqND3cyYQMcosHfhAbYX4XYRp2yCvvAl5cUKcXQFkal8G4smWbC9Uq73WFzILxgq+f5k3CICdj2nDTQribf7NrTyaa2Mm600tRGVBjTSGFLDxtb/4hw6xYgFH0oqUcv/23QN187mMrcPysFZ0JuE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H0XGAmvzpZIewj8GgYQEdLprcCkd35Ju2GZ0GnDXDE=;
 b=S0stkabEow7hT7vjXJLAun002HqlAu4J5NJH/RLln019JyIV2L9xMMK1DDzCGdlw6A009ZeXNwNHpYWJOrfDndb93w2j0lTBb/7Au3D+l6hj4QIZ/mr0LJ5VZJyEeCM7mid4Y/rcKZ2vmFYCN9y0Q430CsYg4Hrv2v6NzjnRQOcpgh2qqHxq57Nyeym6h1Y2ju8OIggQnfo7ARd5ayPz24i00glGZUSs7PJJClPD5sN8oFIy0V0hrArOxf+Ab/jxQ4RgtYMQZHRdR7SbU55ybGIV+D0RiARviQhRTFbF7a6JmoQ+3lsyV4H9MVHuhGB4WDN1kwd4QrxFP6Ya4yHECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H0XGAmvzpZIewj8GgYQEdLprcCkd35Ju2GZ0GnDXDE=;
 b=wHkt9GGA+PyJQTsnocwByGSzMrKkzzpar1yMFw5T5MvVaPFP8a4LgQ9zIx5rXuo+/POJTAMayGhcgUc3ytO6mrmLaAMCkyNBDmkDsTDSTAgRmv+rjGeMKb5wF4xnnbrhLnWAtKfsQPMHlQhqSrWsknKfu+vkhQJv0ZSw3bnL1o8=
Received: from DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20) by
 SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Thu, 20 Oct 2022 15:47:57 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::91) by DS7P222CA0021.outlook.office365.com
 (2603:10b6:8:2e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:57 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:55 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/33] drm/amd/display: Document part of the DMUB cmd
Date: Thu, 20 Oct 2022 11:46:45 -0400
Message-ID: <20221020154702.503934-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 34807028-3dd9-4b30-3dd5-08dab2b27597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2Sy7fpQkfxhzp2B6O53fp1PUAoe7LNLqkAgGuvYxXOt8FG1u/Yfw1pbOADpko7p31SlqQouq68qVnfEKDX/9m0gufmf07NozZRDvT1Z+igAufO2ouaPZLsk/bT1D49J6uRO+1LkVcxWGlU7uMeVtdhUyueC3hLUMqeABa56EBYOJWOrH0+x1cYc+AIM1TTw/KjGcKQK3EkFR2Qb4W/hG+KigRSzsx/yoSThFYa40gm4fozKANqRFe1om4VIbNxv3E5QgS/y34AkGzDmivuLXkxJMb0qxsgQ0LEpQE8rvxd6V8UNEYTvOEVxOb0qFgHpIH03B65rr4qTi5MHOkrdUAdSZC4hf+b3Zrj+YCyxtRYxA0FlHn9ROaYd+CyzakprS69R6dO3n2b7csr/7J3geNDxLXeXox/67JnMLryQ+PUFzBAo3pQlhqg1xgDIgi7O6o/fPic3wEAr6tav4F2/Sov5TPb3dHQ0JDEWjRXrOgFdZ/mA2xrXwQktBDG87xo8US7cVdyTKW8AH3XL+ClTWJNOG5d3fk1dLmRb6aU/NzVMj4WEqh4OQhHTCXVKseP/ZMjRADKFgLkytEADlySQMRIxKpXFAlOWN31FguBKrZR7SRu+uSfrE15nuHRAeJRltdPGh/HQuXtHfnc9by0/7z8Yvssnmw/OcUOGXbt0dwP+fS1XHz2+iLhIEmOZ+YROsu9kALz5Oaw23DRvlzm7W1labV5a9RZn7gSHqP/RF+bR4QPxbCA4+S0qgCDzf1TvsLzY6WKIP72HmGHuVdonbhH6Zhm4W8KzWsTupSrn32J0R3N5ks+hoRVq2LOa7XvI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(6666004)(54906003)(8676002)(4326008)(70206006)(83380400001)(70586007)(86362001)(7696005)(47076005)(36756003)(26005)(6916009)(40480700001)(336012)(5660300002)(8936002)(426003)(36860700001)(316002)(356005)(40460700003)(81166007)(2616005)(82740400003)(2906002)(16526019)(186003)(1076003)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:57.2490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34807028-3dd9-4b30-3dd5-08dab2b27597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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

Add a simple documentation in the dmub_cmd.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index dc7c4d74cb5d..bc9344af1995 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -729,6 +729,7 @@ enum dmub_cmd_type {
 	/**
 	 * Command type used for all VBIOS interface commands.
 	 */
+
 	/**
 	 * Command type used for all SECURE_DISPLAY commands.
 	 */
@@ -3147,14 +3148,23 @@ struct dmub_rb_cmd_get_usbc_cable_id {
 	} data;
 };
 
+/**
+ * Command type of a DMUB_CMD__SECURE_DISPLAY command
+ */
 enum dmub_cmd_secure_display_type {
-	DMUB_CMD__SECURE_DISPLAY_TEST_CMD = 0,
+	DMUB_CMD__SECURE_DISPLAY_TEST_CMD = 0,		/* test command to only check if inbox message works */
 	DMUB_CMD__SECURE_DISPLAY_CRC_STOP_UPDATE,
 	DMUB_CMD__SECURE_DISPLAY_CRC_WIN_NOTIFY
 };
 
+/**
+ * Definition of a DMUB_CMD__SECURE_DISPLAY command
+ */
 struct dmub_rb_cmd_secure_display {
 	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to dmub firmware.
+	 */
 	struct dmub_cmd_roi_info {
 		uint16_t x_start;
 		uint16_t x_end;
@@ -3373,6 +3383,7 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__SECURE_DISPLAY command.
 	 */
 	struct dmub_rb_cmd_secure_display secure_display;
+
 	/**
 	 * Definition of a DMUB_CMD__DPIA_HPD_INT_ENABLE command.
 	 */
-- 
2.35.1

