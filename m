Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360C0C61DA4
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0A510E43D;
	Sat, 18 Mar 2023 07:57:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE2710E356
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MinZe8whIu5NMRNet+O1xE6kCsdk5nrIQRIoZhJJaHrSMBNbmSSdK98mxWg018KNJx40eB0Q8jlBhLRT3bH5Hc+4d33fSeLptHcKoQeWudCx9ijqKWsp7qw1G2Tmz8pSDuuK9Xf7+aGA91v4ujtSMIQKr05T4ApUhPMvyKaPY1mGzMSgZTEY/i0A6w+LXShN3AFJaMpBpZ+25SWN/quPDv3PJdFLcT2ltV8KNUKU6WgDbjt/ltqYLpIwxmSu/2CrC5IEcrXzAarWpDWd1aHlh4cZkRnptu0Ggy7ARyul6T/zcSWodgf8z83sYh7gTXgagdyZbVpkr+xPRc3wiwoGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP7Pj1F7+/HBChfz4LqtNn83CPZpTMGZVbqkj9sDgIo=;
 b=DYMCWW4NzrwKSDS4FlcUsjVVU+10xaK8L4dsZwBw0QC4tCD9qcJ/K8Hxs18n7FxfLMreJbxNqT0OXefzMJXxDT4Ws7hkPBb2YcsJHOz8Z5KrBnDyxGMnW+oa/sUsFWo1lt/ygeyzsNvdPsIa7qNnTgpUcjwlR8i4n/QI0UQfcOPZbKGb781Yk6hNZ8y6zB6h0OLZlutuJ54f8En2AYMjSj0tsQs82Iom35jsXEqo/H5EzDai4DeGR+so2Gi7qyokUD8HLRwQfawcnavNu+Lqq7mOcLScEi9OSpGXsf56+H9pL5hAbnAp0biZANJ/aamux08Fta2YrN8WoHl6eFbgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP7Pj1F7+/HBChfz4LqtNn83CPZpTMGZVbqkj9sDgIo=;
 b=PfEVA/YYhKvFKX77GejZwsyDiHaBwZup1SXonjhnhG6Dxv4KXD50WUCkcR0/VQFlZLI2OxsHkWW4J+QpoxbCCWhZnXoqjhGHKBgH2/9nEZCZns/AMAjd4igdDq/tAqQk2rjLjzPY4bEn5VyhPX/rp+rZA57vANgyOjjZSPtbW68=
Received: from BN9PR03CA0859.namprd03.prod.outlook.com (2603:10b6:408:13d::24)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Sat, 18 Mar
 2023 07:57:40 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::b4) by BN9PR03CA0859.outlook.office365.com
 (2603:10b6:408:13d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Sat, 18 Mar 2023 07:57:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:57:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:57:34 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amd/display: Set MPC_SPLIT_DYNAMIC for DCN301
Date: Sat, 18 Mar 2023 03:56:09 -0400
Message-ID: <20230318075615.2630-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|CO6PR12MB5492:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4f3daf-eb0f-425b-1c26-08db27867226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OK1iL0Au05SzKYytI/Wci3QDfxByyql5ISvrawUrVuOwUDD7PPG1LvSmcwy/mZhyMRnKqSydilkHttAJ4jtrS1RLm2WVkBB611iZpc4ugG4hU8/TmeBgQy6jKAW03aG+XhGykRRAJHhOE5ZSrb/u58MLIAoG6eqRq8xVnfaXN3mpTZWwE365uMqYiYGRTTP40klWsEEViSQXpGRib9pLYHaodeGyzf1NWeRxmZKgIAwiip+SAotsX0LxjrYONo+9TI6FjYHSBqVqkKmvsHVTFT59GUkpg6jQvlTP/vpl5TyCT9S3ZQ4hz81Of5A8PmBGe4uTzE58T3yW1feA7sfjHJn2WoTlcRKHzIkYIjcGj1wcz9h5yGEsc9kl2IiVlMP5ik0uyMLZL5h/wJdgMRyTiOdL7wOMGoIWNpYTgp7fSPoRsLwT65vor1kq6r5CKbXuCR+skqqyAM/R2UVCmQW8Do/ffZpsrv8hIAWnLP5HoY+5Rfqr0v1DM+mXAu7HbK2qkBy5uF4N1iyJablOlRDq2t354A+KKsxAz9ojgmd2/QF6VQeCEIwxK/dekxqJchhNFzQPuYfm4vwQOm24aU0PH+qJlu2/WFpqUmNDjvTY0l82ujTvjixf+rY4McQXyyGp0kSQg4Ak2TegQ+Myoam2qhemiqDCv0hN5M0eSA4eNf8vXHGYj4MZj5lm5zKbliOJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(36756003)(86362001)(82310400005)(2616005)(44832011)(8936002)(5660300002)(40460700003)(70206006)(16526019)(336012)(26005)(186003)(1076003)(2906002)(81166007)(316002)(966005)(6666004)(40480700001)(41300700001)(54906003)(356005)(82740400003)(478600001)(70586007)(426003)(47076005)(6916009)(4326008)(8676002)(83380400001)(36860700001)(66899018)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:57:39.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4f3daf-eb0f-425b-1c26-08db27867226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
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
 Xaver Hugl <xaver.hugl@gmail.com>, Melissa Wen <mwen@igalia.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Since DC version 3.2.226, DC started to use a new internal commit
sequence that better deals with hardware limitations. Usually, DC adopts
split pipe dynamics to improve the display bandwidth and, in some cases,
to save power. This commit sets MPC_SPLIT_DYNAMIC for DCN301, improving
the bandwidth and fixing the cursor bug on KDE when it tries hardware
rotation.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2247
Cc: Melissa Wen <mwen@igalia.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
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
2.34.1

