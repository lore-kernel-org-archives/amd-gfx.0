Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5EDC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 18:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC8610E074;
	Thu,  9 Mar 2023 18:19:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810FF10E074
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 18:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaiIgSNcvFlwGmTvk743WXMcagkx50blZfPMAo3kMtyablyoRglCOoWnFDbpNfTdkWLxYUywC3gX7WjxbiIBYmFoY2+4P2wj4NaSv2mp/gIUXF/ROXEU41OQ+jk4be3eVru92C3vyvGdpimCgl7tBNQCBEh0+CY09V92vb0Hr21GC9zgembQq0ZkNxro7D1HbW/TulVIRYJmkqt1WtbZbHmFUKTETRj6CYckLZPLkPaRSxbfgzDgQudKXsFTpxd0+dbRoLpAZLmuM/5wjvfZauCzD/vJNiwJLtrDJGDBBsFm3WGrxplB4n+oHxJzn8vPxa9JJUB4QfUB6Eu8zWw4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvCRbEd3v2AiydsQMXSQxMmHFXZSwjTGZIT9IJanzyU=;
 b=QqjhYzwxm+Oii645ZsIzobgzbBLxfSOQxvc9f726TrdEShZifKgt9A7M8Jt5GliJKOqBq1LU+EK0crZ9zaKzBwJZ/SAFlFJKxQLkbv/1hBfPODWVtklL5NGMtvfeNXxEPPcVYCrGo98pFEBwquv3HDHRTfyvyHG0zxmHIlfnjod7FfpJHyFPDHzgh4kfGaqMxaNh32oDbVT6t2oSwIZcg0g1qCdNzYpoHL/dXj1g424Vd31xljvZiZCRSFGKRr/APHpzPgdeKMCk8tpR5UGusIr2ncWJey+B5MpIdCiBJitwWKzYOlqScP8LG7SghVrkguTPmUAXDlcwdburQIQwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvCRbEd3v2AiydsQMXSQxMmHFXZSwjTGZIT9IJanzyU=;
 b=AzU9CYmgECVoLqVDEQrVvCLDHCM2wWk1PNfxPl2aEKVb17NmHXzbYFbYk3PD/ot+d6y0gsum08YIcS/KgA4aJJFqTq+g43yTjpqq2TMuwjyQKabyZKds6kGE9X36+CyGWY9wf+gAIJIx+Tj4i3veAMnZt2qiDLUfC+m6bn/FDHg=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Thu, 9 Mar 2023 18:19:29 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::e1) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 18:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 18:19:29 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Mar
 2023 12:19:27 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Set MPC_SPLIT_DYNAMIC for DCN301
Date: Thu, 9 Mar 2023 11:18:38 -0700
Message-ID: <20230309181838.463319-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: e170946d-bb16-4e7e-5b4b-08db20cad2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovHnFFOASssm7Y0vFxhSH4EDCbUErkiVTwDgHCYlikRbTb5+FrEEhL83J3mcegtOazYh4QgTX8kpMLRYtZSc6nFOcMgGkO8F1BPsNJAZEM2GF20i7Oe/so04IYAmpBlr15wAsOhmXPnwFxfuIwufZl95gVGG80+cbsS0yHJH0CBCKtttHao2FTIldsD/4yYWpFdejrjcQcYTo6rFEjESUaWRKZDoJ3KAjCfj/j/0O7xVBBeJ3SjfpbM4WdpfRju4DLeWPyL8x4SDWjtsXBQyps28/6o5N/ymcQxd/1iOB3bA0YR9YnNDd4tHh3oRCp+Boby7HeZipEkF5gQGyh4db4e8urGzVcvj8cAo+KW+TpHVdzKkLfy9fnJUlTTS9IYvfz7W/16h9/FKD9Htnfk7BgeqFYSbuD6uBBj1BNZOKXJqOyM20QY55ghcDIIla1THyzSUkeIFOwqR85iUD4QK9A9jhPbTyHTMYbjZgYr4QfaJVVvjZnMmyyxk6DXFHTQR2BZwGnb2+0SWFTx1P2iIpIJxyQrp5gchXc8W9fnmPcbi1PBeF/WcJo3ZhhrG7f3zoScUl0hkZLiWfS6JUBpw8R0tpVYCKnohBFObT1E23LZGcSU1PY2Q+rsrGaVCCKKyqIs+RcIIcFgI6+yfljcSWunNccJrRMXrkkI63suXR583pUWuz3yoQOsRq7r5+vB7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(2906002)(8936002)(5660300002)(66899018)(41300700001)(86362001)(6916009)(70206006)(8676002)(4326008)(83380400001)(70586007)(966005)(316002)(6666004)(47076005)(54906003)(478600001)(1076003)(426003)(40460700003)(2616005)(336012)(82310400005)(40480700001)(16526019)(36756003)(36860700001)(82740400003)(26005)(81166007)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 18:19:29.1548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e170946d-bb16-4e7e-5b4b-08db20cad2a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Melissa Wen <mwen@igalia.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since DC version 3.2.226, DC started to use a new internal commit
sequence that better deals with hardware limitations. Usually, DC adopts
split pipe dynamics to improve the display bandwidth and, in some cases,
to save power. This commit sets MPC_SPLIT_DYNAMIC for DCN301, improving
the bandwidth and fixing the cursor bug on KDE when it tries hardware
rotation.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2247
Cc: Melissa Wen <mwen@igalia.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index b93b4498dba4..5ac2a272c380 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -687,7 +687,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_clock_gate = true,
 	.disable_pplib_clock_request = true,
 	.disable_pplib_wm_range = true,
-	.pipe_split_policy = MPC_SPLIT_AVOID,
+	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
-- 
2.39.2

