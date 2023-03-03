Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DA6C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132AB10E6D5;
	Fri,  3 Mar 2023 15:47:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6E210E6D5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWZrp4qrJvI+7kcqmXP/iuyeCMJAEphqAOvdTcei1Mixo8hkf56fBj3/HECWFZHpWIKqd9fwkI39elLvq4gZFQ5VWlBBCdsbseLxfByHCB8BOZ/wvKVi3Z/ksO46kd14YUREvNrNazjBC4274b2lCeULhIblCG6XagaMhpxguX+pfn88rTavZEW2TZC36jeJROplZYEBFvfut8CWCVPz4eH/WD3OclyQpvQHrMY0QB0N0SidZem7JV1Siv7QziwWZvGEBSUUjMVFX9exMq1NGyVvXckGOSeMWz4An68A36KqlsK9N+GDuZpLgQaxZ+v+FkUq6jaxNQWCUV93GO0dTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfGYOiZaoLgJRyMxu7VHkkqHFXlyWXQCQfO961YJVqI=;
 b=T7TEwbYY9HcgDoT27f5c+iF1A9necktaXf8LUZ/6oJc9JoLI1zMN0rvSkSdjVfz8pDym5ued11xGR/cP/co5cjTAOwuStNvrtc/WS5fHyCDcpqnWry8EWTANfcqfUfh1bJHGt2oDgrOw3Mg5MshQ2kNb+tJUhz65ujyDLOM5YK4aawG2HI0s4i5B0PiELGiOn5g/z6/5Na+Ryqg+rMqvEx2alR90pDEZaOmlJTvG1YAOL9ss2MBStQd0s965hMK68uIB9lXnANREjHWF/hpqoL4O9jjxh030y7bhAlNKoXIz/y/1MJPWwe5+TqQizsMBpW6lSlOYRUAJcUaDt/g2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfGYOiZaoLgJRyMxu7VHkkqHFXlyWXQCQfO961YJVqI=;
 b=x7/hXBZbPl3/FcvgH7phMU02p5+fox3g9XfDDGH0m0MGkmDnEi8lVfeRR5nIQLFzXV2kdbJBkVSvF4kYQw4NhpQp7tOIv8DX3Bzhtya8nkXBETfjZCFStJJ2Vx5LuPCEo6xIftqn0IDNy/1uLoThzTQbRCqi2yme/7q3WBkqupg=
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18; Fri, 3 Mar 2023 15:47:39 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f7) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:47:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:47:17 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/33] drm/amd/display: Build DSC without DCN config
Date: Fri, 3 Mar 2023 10:40:01 -0500
Message-ID: <20230303154022.2667-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfef227-99d8-4fda-489e-08db1bfe9e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Rf/6sCT1fyPgxUoooOfr1/RDt2l8xPG3iB1EbX6XgPzHtpBkOvuPuFJfUdMHVqh4HOWa0WAVtVCPG2fNtkKUfjGu7CEqu7Onvc/mjDcFDEjFNgmOT08DPgbGoU+IcBr8ne5dwLP/fxHtd3onpIsRalxmHI1OhI3aKRf7fzp4iy+WdzS7el1DQ0Qe5RLHBhG9Nl3HDIDQp1NmxqiQu1oyvzvBj8uiVDxqvU5AOcIq80ytDsz4yW/UUuWnRkj69RJLT8lpM5GUQpJMwUwTibO9JQ8Fg0Y/xNEhz9Hkx1dnnZIdZfV/cGCIqn0cVwCW1cW/B+8Ve5DNT309BIP39/xxCeXjJ8CP87Rv9YppKHyZgCY9uqwmRR42w8jOTxJguyLAlaNuscAOvshhVoSFwtqRL/s9kBiv1nmT9vavIGovaj/zohRbPlxdTNxL+yfDZ4iuWXdVkGJTdw15LAKJW+LLNDll9uMVYi13roh1Dwrr0oCIrPoKMuVigawY76BAVrScvO5tGaHTJFNUO6f5145q2CD28kqf0TSlGVsf58yCLpOPRSZ9YhYwzm1mgdPqPjPFuJpQReJzgZGQYio4WcL3BQh1gCLs3J5v9AdJJ0lnScf2CQ1cybAcXQ7frZAZ/WBC8//+glJc5+d9URdO3DYQpyDaXYkBMGRM/RutSSrGFfy5iD5f1lSMAFgtaTPtczP/AotQSb7j5lQiph8FgJdtJpzgfNbsBIuVL3Cxc7QpNk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(44832011)(5660300002)(40480700001)(40460700003)(8936002)(36756003)(86362001)(478600001)(83380400001)(336012)(47076005)(2616005)(82310400005)(6666004)(426003)(4326008)(16526019)(186003)(8676002)(26005)(70206006)(70586007)(41300700001)(356005)(6916009)(54906003)(36860700001)(82740400003)(316002)(1076003)(81166007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:47:38.8309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfef227-99d8-4fda-489e-08db1bfe9e03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <Hamza.Mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why & How]
DSC needs DCN but we are trying reduce the usage of the
DCN flag. It's easier to build the DSC code sprinkled
around DC core and the DMs and just guard the place where
DSC uses floating point code.

Since DSC is never enabled on non-DCN ASICs this won't
have any effect.

Reviewed-by: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile      | 3 +--
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index ba75e91ef62b..d2b1e824eeaa 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,14 +22,13 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
+DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual dsc
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 
 KCOV_INSTRUMENT := n
 
 DC_LIBS += dcn20
-DC_LIBS += dsc
 DC_LIBS += dcn10
 DC_LIBS += dcn21
 DC_LIBS += dcn201
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
index e97cf09be9d5..3215ca4d5799 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
@@ -39,6 +39,7 @@
  */
 void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps)
 {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	enum colour_mode mode;
 	enum bits_per_comp bpc;
 	bool is_navite_422_or_420;
@@ -59,4 +60,5 @@ void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *pps)
 			   slice_width, slice_height,
 			   pps->dsc_version_minor);
 	DC_FP_END();
+#endif
 }
-- 
2.34.1

