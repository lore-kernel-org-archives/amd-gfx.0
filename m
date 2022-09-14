Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B23ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B051810E849;
	Wed, 14 Sep 2022 05:18:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E8010E849
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTxIIBGkRW8HuDkZX+CwwdJSLwu20zWx0vz4XmgX7x7F8oYodVuxuzxXX1VhGBNZoQNN0wCILZIYeP80ABGQQunymnhq2pg6j1KnIL6AmNWsfnDMPwe57u7Uf6e1+ixovlgjljMCoezoQcLrSODIT/qKoX4ampfc1ivYJW9qtPA9B8y28THsVUczuIApNxsAUmiaW+WB4RpV+vg6luxGIqVwJnzOGbutEBCEegDaZHDknvkJLoYL2OxYxqXlyl4MVZtJ3InLI2tx0RjTpNloZLDBNPtbg9ZW5IHta/BQXcu9Rgf/MqXddvrTEBAZaHTGQHcVamw+/vmgAt8nL3dL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/ly2pzz+3oSXxWt1/m38qlwfYOFO8BzwEef17WveDk=;
 b=PeFYp3wPJe4CALc19Vf91sKBTjkuDNZsaHtoKq6/yYGNtAKPc4XJiuomIEpTW/gld+NqtEQvfCZmPb0slFUL7OhAZ0r3Sd2Zba8cXkjt3UNqRBgLaeJeDvzKsADFeVKh5V2ZinufTZrgWNw0Xa+O8l5rQzMROeslkrhkhPWfBwtestk+Bza4ncGO5IFQVXsLGgZqWxAUgdMKXQwcs1sefmwiRjfSd1X+Uq12JVxokezxdETchodzMLkSA9TMmXo7Zr94WdcZDIs+HljXFdwITB8ofpGiEDyVQZsRpzKKtfGhWOp7NCHZTrWYgi0IxxRydpKsu+bR/38nwq0TwnL3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/ly2pzz+3oSXxWt1/m38qlwfYOFO8BzwEef17WveDk=;
 b=T7QrSu3Ue2HEYUa4m641UlxBhgQSRFD7IH3Dz/S2ujbDlAPNloiNOu6ltj/lcYIRB53GmSTMzfHo5WZGmbTFw4RI18D6VvAOE4nJVfG9X4/iVfER89QuHA8oB4Y8WvW0uOofEWb2e3ghbRVVemz0ufn/8iZsAJqACT+hPCKPz+k=
Received: from BN1PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:e0::18)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 05:18:09 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::e1) by BN1PR10CA0013.outlook.office365.com
 (2603:10b6:408:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:09 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:18:08 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:17:57 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 36/47] drm/amd/display: Enable committing subvp config
Date: Wed, 14 Sep 2022 13:10:35 +0800
Message-ID: <20220914051046.1131186-37-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|DM4PR12MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 90007eff-8f10-42d6-7b6f-08da96108345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eNZzYgkFxZI+oZ4KZX6lSjJsYEN3X1mz0wIjZa9tcRw5Vkbx6iD45CcbCqExSSGbTZBiPhrO4FUW2Mgcctkti6rSa+Ycdsz/8P2PKLp/YYHE/zVagjf5mkEH9bC8/H3IXrGRHxgv0gutHlv0Oo9lvY5X9iY6nLKaWV5nmE9nl8U7scbGh93ifQRWtvNUYr1EqdKsdxDd9d3SfLIBBeu+YRh+Vc8PEBcGeCj23ibrAa0TMkokZgpkOgky5DB94o+R4EzG2bPLdpwX/e2CaRztdAG1HwE7tUAnk6I/ii8jWBmBO8+KIJnwS5Z/SPWpML/4I4KkLqGBzKCCW89I0zW04H2Bv7mbouSDSbbNOefUGOSNRdIR6xmCTjg5VAf2Qk6xv8+zQ1jPhdDI9KGqPr0x99Q9QVg3k8I418V+/unNGWt2emmvHezxT/r6L4qUN1xu2R+IfO61d5r/xwBvny6ravvSTpbmNJyNv5bSjoaVfBFk18rwb98FpCNZ5I3qY8ToGS9hhMg0mG4o7wa+8mmYMNeHb1uijj/QWSeqQGbfSYK2W3YhetmIbLJBuSJJ49Dc3zGH98kE1jOoPacHMVCIf0S4L/ToyWRYBQyddJ3B7zUhYopqMMHoH8QVlNKY730egxdXeozOIOTKXQSllcb9walYqwZpVHOOPLs0dV6u6DYTATpMesMSxZvZgG8OUXM/IaQ5+7wWI5ySTFI5TTB7qDPVTWfcI6Zpo4Nxi1dEYBCEJuFlj0fVZxKY7gT3VMb7/5Nhqb3nBEAx9nPa9RMyRNRsCrVhP5kTl515JVa7CK8wdCB3GRu0v+J0q9It5jf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(70206006)(26005)(4326008)(86362001)(2906002)(36756003)(82310400005)(47076005)(40480700001)(186003)(54906003)(82740400003)(2616005)(8676002)(356005)(40460700003)(6916009)(6666004)(36860700001)(316002)(70586007)(81166007)(1076003)(8936002)(83380400001)(336012)(426003)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:09.0952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90007eff-8f10-42d6-7b6f-08da96108345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
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
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why and How]
Enable committing subvp config through DMCUB for DCN32

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index b8326d41810e..7544ac8e33ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -453,7 +453,6 @@ bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
  */
 void dcn32_commit_subvp_config(struct dc *dc, struct dc_state *context)
 {
-/*
 	int i;
 	bool enable_subvp = false;
 
@@ -471,7 +470,6 @@ void dcn32_commit_subvp_config(struct dc *dc, struct dc_state *context)
 		}
 	}
 	dc_dmub_setup_subvp_dmub_command(dc, context, enable_subvp);
-*/
 }
 
 /* Sub-Viewport DMUB lock needs to be acquired by driver whenever SubVP is active and:
-- 
2.37.3

