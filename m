Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03636C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5F510EE21;
	Fri,  8 Apr 2022 17:26:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA1A10EE21
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY1BsPSwG4mNjvlTcK+ws0zneSqCoYwd+jaktgTKBwFkgBBGpfKmWDKj7gcTcgGcHjUwMGQBg/VBYBXTPM56PFjdYbbZkgiITmEha0EroiYmuwOiqUpd7W6KKIifKJwpB/duq1Xha0BncE2qyz/5pA5EwZbsi3lhf/rCKTiCrBZh2+N74NVe+L2AJf0H6+egQDhqCk04QEqjNN99JlB9tLUyu+Q2XpuKx6v7jr7yyluKWlhyLNxjpmbfbv0sIDqMU2nRDrBeCkQAAoZnozmJXAjozM2sfjpeVzYszne8OlT7Nq2YZOwy/9c1cMR2rlhu4H8E3MzPZPYrtNZCDAkPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcqHTMifiZcyWK20L4C6bX0MrZ0KCBsadKVOktfzVm8=;
 b=a2Dfa+XnHr+RB2X58h0SqbK2hVvG/p6VmxGr43/VWKEp1wYTzWYi4eAD1ZGWIMuJ/PYHULTMcg0vTOblANy1Kn29ON8jLrp5mpA7CFt/S5xg+SmA52yi5gaeLQSUcEbaiErCJjEC9PYvsTzGl+VB7EjZtDop64z6djizgQ311B1vfiYARMUEScsUeDbNzsYHdtI4Nydb6p1dqyrzCVkcq54AASwGyuLps279caTN7Xslu1dEYUzyKoM/ADi3bdZjhbxlNA5qyWAFHXzMqHNBe0oCMdQ3zAmFlCMp1laYNJLByeQdyoV6aXmqSyYoLFqADwKbTLb/HoTyxyr//YzzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcqHTMifiZcyWK20L4C6bX0MrZ0KCBsadKVOktfzVm8=;
 b=hlOMHRFm8LZRmLPbqF5fPJvPihLuTEds8M8T9qtJe4d149e04PR7Jk+cs97RivN72QvCYxMy78I4mUGMQk0b8w4mllmVwUzV7sqozVxIMm1iaFGxVm0uyOV+hN8NFeG12FTCMOXVGa6siCc5QXKpMTsRvFe6TVH0FzSVJ2D65DY=
Received: from DM6PR07CA0056.namprd07.prod.outlook.com (2603:10b6:5:74::33) by
 BN6PR12MB1683.namprd12.prod.outlook.com (2603:10b6:405:3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.26; Fri, 8 Apr 2022 17:26:18 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::7f) by DM6PR07CA0056.outlook.office365.com
 (2603:10b6:5:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21 via Frontend
 Transport; Fri, 8 Apr 2022 17:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:26:17 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:26:16 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/20] drm/amd/display: undo clearing of z10 related function
 pointers
Date: Fri, 8 Apr 2022 13:18:52 -0400
Message-ID: <20220408171911.601615-2-Pavle.Kotarac@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4eda561-4ad8-4413-e707-08da1984e405
X-MS-TrafficTypeDiagnostic: BN6PR12MB1683:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1683427EDA65FE321EA35092FCE99@BN6PR12MB1683.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+2IpMlLig4vxxAZAsZhQ0dvjWxLoOoCk7ojEY2Xn3w8WpBuCjMHQCe9CABC6V+OwtKTIWjGOfSIu3a+/5cyht5Wy9/ns1kbQYe/bUlEWEyvfB7FktR2eTJFARCbV86pAdZzdKN9MlXSGNotJfe4jvcqc3fdzt1ylz3g2DX0cOXYuU8seiNU9/FnkVEkKImIvGga1TlFJq4ebMhtKaLCGXfF9xxSj/AWPRRyDsJrLGqRPfj9X7505yElVJn0kT9en4vj5JI3Upfbr3Aq/dV1JioFL89gr/P0cHTIfB0Gnxb9Zn/hmNRLYlW6rNRDt2R3no+eEqeuDveHAMVrmq9nCShtuG+Xh6oPWO1bZI1BBihDRFDLPW6KcgEf186lzVxxXLHQC6hps+Vqu14XToNgFBaRyEQSfDE/yU6WByPQmJMG5GvQPm8CTxz/klOGFGL9IDFNjmpNjSN2FM23bk1I5ugsi+dDODvzPQbDQFbcvO979HwOKlUiBgseUCBt7IViHqbK7Zk6UffCLql8kjJ00VTVlF4ZZC3RRXqiQPsEu9warCyvNEdrCCwaRDb4pzA6KTT+BMTajcOKcucIj5KouDQy8tyvL9kewUtJkP4AZaXDMHUArfPKQf+Mq2nSB3ENLCfep1l0bSTavyxKsrFOJhSsmNURZBuDTU+2/PXU5Sd2hzUsZ37vtfYGCkbi7C5S43mm0Z6JUULGmdRwuzyq8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(86362001)(356005)(81166007)(4326008)(8676002)(70206006)(70586007)(316002)(6916009)(54906003)(8936002)(426003)(186003)(5660300002)(1076003)(508600001)(16526019)(336012)(7696005)(6666004)(82310400005)(36756003)(26005)(2906002)(40460700003)(83380400001)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:26:17.7222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eda561-4ad8-4413-e707-08da1984e405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1683
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Z10 and S0i3 have some shared path. Previous code clean up ,
incorrectly removed these pointers, which breaks s0i3 restore

[How]
Do not clear the function pointers based on Z10 disable.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index d7559e5a99ce..e708f07fe75a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -153,9 +153,4 @@ void dcn31_hw_sequencer_construct(struct dc *dc)
 		dc->hwss.init_hw = dcn20_fpga_init_hw;
 		dc->hwseq->funcs.init_pipes = NULL;
 	}
-	if (dc->debug.disable_z10) {
-		/*hw not support z10 or sw disable it*/
-		dc->hwss.z10_restore = NULL;
-		dc->hwss.z10_save_init = NULL;
-	}
 }
-- 
2.32.0

