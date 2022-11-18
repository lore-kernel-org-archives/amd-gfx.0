Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622FFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBDA10E790;
	Fri, 18 Nov 2022 17:01:25 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B8010E793
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFrdBc2T0OCtT754z2MZqw78ca+YPDjWCCcknXH7MxfQ42Gxrq6LHt47oKYvZ1VKdM/v8H5AWMYBpBoFdsf1Ma5bgMQ8qnI84gIwvt2wcJafuQ+72T1FZ7UaWYI+umdnLBsu14XUcMqJQVGYctDyU2mKXvhT6lh15CA1EGTMQxgst7zts3vCRxBx+eymNFjxjlyDogBzN4sOTE5X6HXMoM0Vh4rRaYIa9W+ft7H9/DIXdX5RsyjJOULYu3j7Bra/3aepkOI8ceSxKdd9M0R3Xeqw7z7SFESggKZ1VOjdBWfqpdLL8bsqDYMmXD8YR0sg/PvcXLZBcdSZgeUmzfor7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCm1hMnLxY55FQgh4n6roYslwrTMnjDQ46F9S30rquM=;
 b=M6RDve03tfKqI6oW8Y9xhH6RdDK7h8/Su9uqsgGssdNm9UpLaVKfoxeN5jVsK2fIqKMAUFZmf8O0lDbBRVf7tPyaOzyh0GH9bDeH4C03hiLqZdTKfO/6TwYH19oE3mQKx/h5M80e81t+4uTFkmunumDBBtb4Tr8Nij+lgQsEs0rD9/IRBMU3UDMEUV7wKKRhkFf0hrFNw/o7+Splz9gDVI52HTtdrxkXXh4B81JsMGzNT+Y2fK5qB+l53u0ijjp9VhCLIOU00Qm8E/h3NKYn/q2Z4aGaT4fChNmkmnPcw0p8J34w2H6mi3kmDsIPvpWqodM42RnSWZM/xcC79S1LGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCm1hMnLxY55FQgh4n6roYslwrTMnjDQ46F9S30rquM=;
 b=g50unosPwt2Pbladg9Q3dUbTuTv66JTa5FBUkkcDX5S0DPwhZzP56bchFcLpsMAqdrInJ+gzBWYAp8q2KLRCItMioaV13MeD6q7iYk4NEkSJtI13gx0dQ5XvMLT5xTYYEwNeVKFN/avsb70+RbJDtll1NyfX2UxflNdYP1Bi+vs=
Received: from MW4PR04CA0315.namprd04.prod.outlook.com (2603:10b6:303:82::20)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 17:01:17 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::d3) by MW4PR04CA0315.outlook.office365.com
 (2603:10b6:303:82::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 17:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:01:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:13 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:01:10
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/22] drm/amd/display: Fix display corruption w/ VSR enable
Date: Fri, 18 Nov 2022 20:59:30 +0800
Message-ID: <20221118125935.4013669-18-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e26767c-a550-4252-e762-08dac9868249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJHG7Doox585/6PsDwvoIk8FymrmeTjtM7E82eQT1jggFVBDDybcFT8O757atgJrWlqiorA2Az9KpvV28G+glLC2IHiG2/T2/Q1a3glsAfQoukcVP8niQXOu6g45gbk/VGrVx89z7/3vdnrLsOt9wXpjx5mpz74LcqaVsZOzq7hQz2zoDZdkwdAXR9LWmHPdQSEPi+w1HAvIyB9qzRN13J1e0ZOkdutrS2ICGqdsrqnTO/y5giqD1G+S/xiTAkA5158AaerczfLnZ87nkbo4sx/wHrGFxuaNChAuiFYyYRPdlUO/MIUixu3jQvErKuuZq/VyvmHqb5PtDJM5O+EyvCwWx2AQ0LbNMVzE2e17IZFBSsTblpcLUSf2M+esQn1EM4PgvzN3ge22yDkCuJKZzvyZRLx9OyYtm1OcIkn0KO95pvwDpKk1NevWJnlSDu9UE5iqSxzhgDXkTjNkJ+9SB0q1378wV7TdeRNaugKyLG0oPePymlP70GixbUgv1CWF/hnPGH9LwJpyAWT9bxiJM5fuggx4QA1mBnGmaLiD+2EzA47ZuyRkbKCI0PeqQh/O1ZSuESpwQdb5+TRqyGtaIqX0KIoWA+u5KAOdj24G0g8GUwWgAexAyyjEh9b3dc/64az2hLIsIixh4fwGwerN0SwYOiXF1CAWb+1lwW6fEiRCuRjpns4Gtn01W9kXKahSYiPMTp6o5gE2HWBpqar0AjBR2t8uqLzSfNhuvooMtLnd3ISfYfFnUUnZYnTwnFnnCIC9qpaqjZNgfDswnE/R9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(316002)(6666004)(4326008)(7696005)(6916009)(54906003)(70586007)(70206006)(8676002)(478600001)(26005)(426003)(47076005)(186003)(1076003)(41300700001)(336012)(2906002)(83380400001)(2616005)(36756003)(40460700003)(5660300002)(8936002)(36860700001)(82310400005)(82740400003)(81166007)(356005)(40480700001)(86362001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:01:17.3309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e26767c-a550-4252-e762-08dac9868249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Brief corruption is observed on hotplug/unplug with certain display
configurations when VSR is enabled.

[How]
Work around the issue by avoiding 2to1 ODM when stream plane_count is 0.

Reviewed-by: Dillon Varone <Dillon.Varone@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 827eef7e1787..99ddd2232322 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1924,7 +1924,7 @@ int dcn32_populate_dml_pipes_from_context(
 
 		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
 		if (context->stream_count == 1 &&
-				context->stream_status[0].plane_count <= 1 &&
+				context->stream_status[0].plane_count == 1 &&
 				!dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
 				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream) &&
 				pipe->stream->timing.pix_clk_100hz * 100 > DCN3_2_VMIN_DISPCLK_HZ &&
-- 
2.25.1

