Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED86C4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64D610E290;
	Wed, 30 Nov 2022 06:39:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53EA10E28E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aheT8Z527kVXQfa/5fIODfaJP/uYlt3o/2X9fE5VjbwBJmYV0X2tf2cR9xmaaUEslJc4dkq99rHlrwx5ji+YvmS3LhWQIeplifhbRLgxT3Wah77ftsnrd36FSrYJ7XR1YBT8Iv8ETtn6n66+Mzw33rGkVMsR2BR/uydltVj/kVw+TXAkFiBTMXpamyEuuKTi+0mt33yf0xpMCBdB3Ok16uaaKgdGsO9IodMT1YiGs2KKhf61Sy+rUHz+m+SQSwoiGsHOsJwkXspz/DQZqSNDfBs0G19LDaHgb0hmirxNoSfTIHr61cptrS/WftveM4wC3uSKXkgc3LlvC98ikg3K9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Px2xeCSQsEax98GpWhy6GohiMX48RLSfWkyFTIUcl/Y=;
 b=aQOKQbp30KEe0dx5ojvgtNsNNAm2I7I1qHeXrzS8/JBjajkYLW4zbX/4owNCcmtHse6WerOgJ0UiNGWD/1Prg4BdrpfsDUtD7M33ILI+66rqqqyjRNI46J65WVaneGxkBzKzWCVRxkzN+zVI4SmvyISrBoycR31dzYftf2uCsQwaBy26eA8GVUgzG0sE+72iDICIdTCzUWFF/MBjI8cCDHplYCXJPkmyJDew7kBIRxcCFGRUGYKzEshx/7m5M6oU6yDNSH9PjSCSz5QM4H/8USbGSz9bpq6AcDh1NJYG5WZzIzNbRBRPEsf5/R6uOOw6Isrxe+t4EqbSx1Vio2iDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px2xeCSQsEax98GpWhy6GohiMX48RLSfWkyFTIUcl/Y=;
 b=XNc8EG5u+7k09eYr0cIQbvtzpt42IEqIKiVx1cfj/xQfY3fmpUOxBwYyp9bbMffmpdSPU00roVJwlxFU0yqb6EjfbZYzKDU/yCyQ37Q+aszo91+AjXQSpzmkaR4QOQNBboRIn8aBPx3DyLAEdfN2bgREhU3rymYOoT631QL0IF0=
Received: from MW4PR04CA0101.namprd04.prod.outlook.com (2603:10b6:303:83::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:15 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::86) by MW4PR04CA0101.outlook.office365.com
 (2603:10b6:303:83::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 30 Nov 2022 06:39:14 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:10 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: trigger timing sync only if TG is
 running
Date: Wed, 30 Nov 2022 14:36:15 +0800
Message-ID: <20221130063627.2398341-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: d071e718-5d7a-441a-a4fb-08dad29d9957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrXge2NakSnOpS+P3BPC5k2azfVIn6VDo/DWtdGHbdJGCP94mokqzrzJI9hj/jxqpfj95vxMuAHsUMvjInc7aKIK0/E05K/MkB3fcEeYjSgI6jMNsGLFRcygdSYxj83dq8Ki+FEnddUbFSOAHwq16YrAXqiSYLppeTMmIJRvsO4mflXpyiIgpgsGswfMOC8uEpvujuldQ4gJfa3dqukZG+8S5yAa/JWlX4wAeNfF9uYfv9j+EyBZhfFz7qhMPa9UMXIRaMw0BPhMWDpWiIz2Upp0gGM8Ik4GehfIo5rrEN83CpLiVbNBJN7U9peyOA9K9peVSk1DJXVrwUGHz0quoaQjF0rVd6jYGTkKvefDoSAANy1W+1F997SIHjprbfxndzftZTqPIJgYbh03K8oJW7SVQ86S+a7Lxevt8C124LqzF9wbhO49BIWjOcYDXkKqsfvrZVQPa4hA0w0QDmSNMVs9TnkEs4TDFhIq3z+8O5wjXdLjj87Euavc/2q7bg6oeZM1iF8SiMA1RCQP1eT1rpVCZuljEBfPFm8RmByxNCaynQnU5Ie0gZFakS5k/4wXlgbl/GXt9KUxP5IiEbSltdB7wRsCRr+uofbdgAifMN3QPnM0X5PY1A8BB9T1zdzKgnjJCAUrV/St3SgjQLZMQGe9HXfhitp70nqAnA6ISntH4pOklZvrLtB5QXt8lsoRz6yYZCrrkzBx0gjeB2AyDff2hcbMmPcIrFgXgY1x1Sw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(7696005)(2906002)(478600001)(356005)(40460700003)(86362001)(40480700001)(36756003)(81166007)(82740400003)(36860700001)(16526019)(186003)(2616005)(336012)(426003)(47076005)(1076003)(83380400001)(44832011)(5660300002)(41300700001)(8936002)(4326008)(26005)(70586007)(316002)(82310400005)(70206006)(6916009)(8676002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:14.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d071e718-5d7a-441a-a4fb-08dad29d9957
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
If the timing generator isnt running, it does not make sense to trigger
a sync on the corresponding OTG. Check this condition before starting.
Otherwise, this will cause error like:

*ERROR* GSL: Timeout on reset trigger!

Fixes: 8c7924bdb0fe ("drm/amd/display: Disable phantom OTG after enable for plane disable")
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 355ffed7380b..c8ec11839b4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2216,6 +2216,12 @@ void dcn10_enable_vblanks_synchronization(
 		opp = grouped_pipes[i]->stream_res.opp;
 		tg = grouped_pipes[i]->stream_res.tg;
 		tg->funcs->get_otg_active_size(tg, &width, &height);
+
+		if (!tg->funcs->is_tg_enabled(tg)) {
+			DC_SYNC_INFO("Skipping timing sync on disabled OTG\n");
+			return;
+		}
+
 		if (opp->funcs->opp_program_dpg_dimensions)
 			opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
 	}
-- 
2.25.1

