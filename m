Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D0C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6819D64D92
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6819D64D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A27D6EC19;
	Fri, 19 Feb 2021 22:16:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347686EC19
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1Q5e20cGCyhtzZ5BjQfuva3gb2xm5vVEjF3KzrJWLxm3VsOsHelI41OJxwugUVVwWBHtwYYlN8l+auY/TqOVEr964rGWxJDxaQvgshC62VN0PVbkHRqtb1XqAFlsIHh3r3vv8J7rO28u8Y/PKTpqAyna+JI+rf8OFzHlIjsnZprEXS3RaSAvgMmKBhcelOThB8uHQKS7oB/3vAH7jLyGF61I81Ep/QAo/FeIjAt7va7m3teSUd766iGmp90zUnVfQfq0WHU1/8NOLWMPXTyY2r9HQ4NzAhRyBEdVvpznojEhkcXQFC5SFQBv5nr43wXVeA4wMMQhwIMGxJIFsIBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW4jURDEyy7QHxEXlGk4fmDspz8s8WD/YApPY26PmGs=;
 b=LuArrBUlT4votMJukKROqVm/yZsYRjw068IRrbwxNFUksWrzM9UJom+YUEeuBTc/+6rQi3okGFFQ79yHXNjMW834qvDBu0gDIaga51BwnQu5s2dnrbVd6JVbheTxubTGg2ROM79c8YdCkwHc9VoE1Jfpjdwf3KFScHwcSPPHfz297QnE274/DEGac8E6xpaTlC8EwD2Us1+18bAuHvOgVUujXrrX+ctv+SWgiRSkt59MvTEVGJB+p9+OW9XuUee5sm6JnZ47JbnXZB6XBtoxcHZl45KbeaVrBWkPmR/bndrhN5m3adxYO/4RQRxB0cbyOZtuA1PavxJggvjxOTxymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW4jURDEyy7QHxEXlGk4fmDspz8s8WD/YApPY26PmGs=;
 b=MsdbY5YWh5YC5cok4t/Wb/gmAItb7xrEdLGHYcQM21NTsQRXuAgdoMgxAg9157aONCTuuLb3DH38nGH47IUHRK9DpoOh4Zm4rQYt37fDvQJA6OP6Hq45jQKNz322ZTwvEJl47VTGLKIMU8s3yMplj0GueT+UIDQWGh8qlf2T1no=
Received: from BN9PR03CA0563.namprd03.prod.outlook.com (2603:10b6:408:138::28)
 by DM5PR1201MB0074.namprd12.prod.outlook.com (2603:10b6:4:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Fri, 19 Feb
 2021 22:16:41 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::33) by BN9PR03CA0563.outlook.office365.com
 (2603:10b6:408:138::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 22:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 22:16:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:38 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 19 Feb
 2021 16:16:38 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 19 Feb 2021 16:16:37 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amd/display: Refactor debugfs entries for all
 connectors
Date: Fri, 19 Feb 2021 17:16:01 -0500
Message-ID: <20210219221612.1713328-3-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98f07f15-6367-4e9e-1148-08d8d5240763
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0074:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0074F0B399091DBB8BE8FCF4F5849@DM5PR1201MB0074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6Y0gHOGayKCs6Yg+Kc9LTiouLDwdY+fmYAxUwH9/LWtP2LP+YlM0ia/E7TgGxD1PC+RgEf/3NtA+UmDaVMdDxtmNP+gDeJtroVGKwb5WBy0jufOnqiduTixW30+xOy3EySSaCU15kUsdEyouc2mtEptRPO3cSlp7YuC01xiUEp9H13iXcI7LVotSY+ZOyWHx//wLJEWZA5urf3uVlvK7LDdzHdWIoP1lVc0wwU8ATTvh61F/ekmX0xRgSVw3r4xOzK2hPOnv0AxERKSABMU6cVGPqsOmNao1JNdzyf8+vDn4UfOYPiWs6GP11meg2uV7tfkqP4JsneXJwSG3hDrskTFT7DfdcpRbwwhLHo0hO82Y/fOl5UnkhfCQnRsKDxAnrWiwWzTTTEIln3KCLVeTTNhz72kY1E8OKXhE3lvtCyaIHOvgioKLYNA33NqLasM4OE9O/dN3RaCmwxD7oGhq/xw1hapiQViP1d4Sc7TFElwR9Bko1ybUc6Pxdbwn0eReJ2M4lDAi/8/+2KnQ5RyeOUZoyfWscXoRKdKp698BNHXEJQFvqHl06mkjjz8fjD6qKsm7l8/N4+NxHDZLUrHPL52fxr2KCNVI7XGXCErheUuLSQ//5OvkMFXnVDhxrEuN6mxH62XRtcvRMJZY92C4zbk9X9VK84CA/bAg3Rpv6pNqrYAWbalADL7DeLB2T3B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(478600001)(70206006)(356005)(81166007)(82740400003)(8676002)(186003)(83380400001)(36756003)(26005)(2616005)(70586007)(86362001)(7696005)(6666004)(426003)(1076003)(47076005)(2906002)(36860700001)(336012)(54906003)(316002)(4326008)(82310400003)(5660300002)(6916009)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 22:16:39.1967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f07f15-6367-4e9e-1148-08d8d5240763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0074
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Debugfs entries being moved from DP/eDP only to be available
on all connectors are cluttering the code.

[How]
Refactor the registration of these debugfs entries.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 704aa8cb668e..f7408d09ded9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2342,6 +2342,15 @@ static int psr_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
 
+static const struct {
+	char *name;
+	const struct file_operations *fops;
+} connector_debugfs_entries[] = {
+		{"force_yuv420_output", &force_yuv420_output_fops},
+		{"output_bpc", &output_bpc_fops},
+		{"trigger_hotplug", &trigger_hotplug_debugfs_fops}
+};
+
 void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 {
 	int i;
@@ -2358,14 +2367,11 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
 		debugfs_create_file_unsafe("psr_state", 0444, dir, connector, &psr_fops);
 
-	debugfs_create_file_unsafe("force_yuv420_output", 0644, dir, connector,
-				   &force_yuv420_output_fops);
-
-	debugfs_create_file("output_bpc", 0644, dir, connector,
-			    &output_bpc_fops);
-
-	debugfs_create_file("trigger_hotplug", 0644, dir, connector,
-			    &trigger_hotplug_debugfs_fops);
+	for (i = 0; i < ARRAY_SIZE(connector_debugfs_entries); i++) {
+		debugfs_create_file(connector_debugfs_entries[i].name,
+				    0644, dir, connector,
+				    connector_debugfs_entries[i].fops);
+	}
 
 	connector->debugfs_dpcd_address = 0;
 	connector->debugfs_dpcd_size = 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
