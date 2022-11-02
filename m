Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BD9C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C8D10E4E2;
	Wed,  2 Nov 2022 16:03:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64DA10E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz/wt0SFzZeO6ajHwdPZNrgxER+N0AIL70LMgUoHrne88JLeMSfGmMD9C/lbIY4gpjj/av3iv3boLRHLGHIk4qYhAbB3BSrIgOC1v+fgoqFkqUxmLx3iOTBS13ijMoQudFRe857prsGYfevv2m3keKv/ybNGZpI3WwoKy/WzF71lB8Uvs/VkZPz+sS5wzNvkKzeDMOA/hFPN4bmWxPxPtC9iNVRE+S/2ajja9XHyWCtd/uTInuJ+YCNVzI8aPMs2T5ivr3DpMDI2mCy+knDgzo9jWOQleCjxhSiQdfmXyzYBfFe8x06mDBWJftz4htbWqmXCfneYcrNwC269xDelgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQcQpr2/Qv9C2Ua/JHIoOpaQ17UsVAsFUUgGnJO7qU4=;
 b=FkjzPZ8f/TBD5r4hyMzVJraRGbrInAgQD7d5/DTBdzsc6OMKTWLO+mJjNFBWzsP6qAwSvTtws/mZrPYQ/HjlL0yUvVQkWMa6MNw0Vm3lC8u1kpgZcBkTUFhMmJJ+I0s7K330FRPOKlyg0UJ9v2HRFjk/vwAKSVsgUSg2cogcmvgE6DhzOGkiFmScSsoAskwZ9OMdjn7wdK8llTmQBtpXnBFhSrGDWX7IllCpe6aU6Y+CNwLlZl6zzJ9XrDAM9bLzqrPg5mCyU/hZyrASQRG3GfBBuDZ/b9NWI1Avyb3WtVO69jbsA6o3n0aclCNjpVp2cCYj441AXibyVM343QSGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQcQpr2/Qv9C2Ua/JHIoOpaQ17UsVAsFUUgGnJO7qU4=;
 b=wZ8y1vpExj7mQy5tNK9P7D+lIUz+hvtWF0w6Mk8QHzulWE3okA9ZrdfXFZcHXDedWdtr/DKi3x36Q85ZBBo+HRedWks87qCg886zjhf7pfsKzKYCGsbvUx3B+Te7iB/SUkt5VFawGxFb5N2WPZvEfSatJ9bPKjN0ov+Fkw9Oj7w=
Received: from DS7PR03CA0340.namprd03.prod.outlook.com (2603:10b6:8:55::21) by
 CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20; Wed, 2 Nov 2022 16:03:25 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::f1) by DS7PR03CA0340.outlook.office365.com
 (2603:10b6:8:55::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:25 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:03:25 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:21 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/22] drm/amd/display: Allow tuning DCN314 bounding box
Date: Thu, 3 Nov 2022 00:01:03 +0800
Message-ID: <20221102160117.506511-9-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|CO6PR12MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: 47f84651-73a7-48e4-76a0-08dabcebc665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpXRcq3obK4sfdWN2sDTWTSwTCj4OLHCtRUsSWhFUJBn0XXBK/AW/330HOUeIWAiek8GG3ZXeflzwkyal0aenAx/zJU+EfNx9Iq+MFxf/IFuYsEaS5wwR9XBMq3Wu5lWPdbV0LVvqnNrDzWEdPQ7lvj/c3z/xfGhMXiGrNUFhVM5WE56kcfQQeiGkf9Dn44cngkUCK/Wcq7dP20IBbeOcZABGeWS8/WuX4ezn4FfBQjOwCIxf5z2wn0Ao8SCOwRrQNT82FPNQCRqNeMD0sHT6noQLzeUl2izCfv7C9Z8Qqp3XeXXo6hIPpR7VXTMgX3n7QNi4Ikg+O/2o5s2eh6zlztdt4oPEs0AlJQsj+mQbXA1DbSiGFUTOua3LxToCoSkV0SgLD+aU0KCLjb2jV7pAHWSO68JarA6RTh3UsPpCUEauXAVpJhg8mcWGTi7ieiYgsEHUcjIE+mUPvhCYoWNJYhDRLquK9RcTObbvVcgdwBv0vqwCM3y04/wS1k/Q6+4rWZJTF1x07TBc9tU39o778yYalYNLwTMEdsaJYubZYlXIlQs5JFTMa3f/U1TpBNJ/hBdRR3UjW2g7wIpDDVFTvwheSeIqPdZo3Uc8phsUY0T3PUdhY04GZxv46SzqGEAY/d7ZqqW/4cUb/hEuvX0d89efq9vXwdzv2pPleKrywSed7LMFPHdqo1MuDREvQo/7RpETRaltOE5j+3dpVbC1kB47y/DOFrU9OcphdC5W2rHT/DdIuUcOz9+s39iqPj1zTO/835S7o3kk5FaPCSEubLOmmaaEM8hK9Qr16PkH34qFy5eZ8n6W4pehg/Qo4nb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(356005)(47076005)(81166007)(82310400005)(36756003)(86362001)(36860700001)(40480700001)(82740400003)(426003)(54906003)(6916009)(8676002)(316002)(6666004)(478600001)(40460700003)(5660300002)(41300700001)(8936002)(26005)(2906002)(186003)(83380400001)(2616005)(336012)(1076003)(70586007)(4326008)(70206006)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:25.7440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f84651-73a7-48e4-76a0-08dabcebc665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We're missing the helpers from dcn20 that would allow
overriding these with DC debug options.

[How]
Use dcn20_patch_bounding_box to support overriding all the
relevant values.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 34b6c763a455..796c9d19e671 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -264,11 +264,8 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
 	}
 
-	if ((int)(dcn3_14_soc.dram_clock_change_latency_us * 1000)
-				!= dc->debug.dram_clock_change_latency_ns
-			&& dc->debug.dram_clock_change_latency_ns) {
-		dcn3_14_soc.dram_clock_change_latency_us = dc->debug.dram_clock_change_latency_ns / 1000;
-	}
+	dcn20_patch_bounding_box(dc, &dcn3_14_soc);
+
 	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
 		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN314);
 	else
-- 
2.25.1

