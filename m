Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8996C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265D110E4EF;
	Wed,  2 Nov 2022 16:04:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09ED910E4ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuWzBNVQGIO8bVxZRQnnVU52ALjMPv3Jbx1iyEmExR8BrEqn1fyZhkuXOZD0g3Y4eeCOZx1Giykexku6172aHQwsUALj8HxuTit2U5W2ZjYPvOG9jN1+B4CHpg/ztqCV2gVqeC2Mk/K+wGgF63fKF/rkU7AQDlaBiT6lFKetT2wD2nmmftphuO/bia1CSXvmhFpAb1ADFW3qxXRtA1pV4XJIFlC6P9kSEzhbhUk1eq07a2h/f60zP7WmRev11MOQ1CmL4pDhlTug3qjrwwdp0DHkIilwyEsQ2bKLcCGeko1HF6wKkKoCTzGIhXI3t5ykZI9DmHoHOPG60cxL1NSIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lCzPRpA/12R0k01zoHmzrlTiUokceX03yHiLtx82dM=;
 b=cNwWlaHTBTsuGXf0FhcuJIZX9k6IDGIMOGwbM6bg+bQdMhCoAhUX15e8XbpVUj5+yi0bpshUWrwFACtxgunSQylZO5xlyNcArDnjnAHpojTiGxGXcMTVwcaAIdkQMkPHVRg1ijz1qyoVMz6DzkkOMZspFvY7r+XR3VcIwIJ6t18RUwg4VtfDPQL76Vf5TD1m7jdVGF4B9by1/c61OtrOqoZJGNjYKFlKEwLRFhvp5pZA4hPM4N+TvEJAhXK5g3BnxyXyrULBt8hoAz60C6q62jq8rdaveUyAuzs2Exdx9ES4S+2MReRqb+y4IfE/vZrMC4sB6Zdbsle2HAAPaoEQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lCzPRpA/12R0k01zoHmzrlTiUokceX03yHiLtx82dM=;
 b=FyXdIvTrsJz2PbOw50xmc2xDNudZauCYClG5jBZTG98al4OheVT7JkCGEOHmn3dAiJO+/t76Q8ZgQ9/uxNiks4PK0HKgogB5kYA9iNgUJrQUkiZj6ADLV0Zcr794fHsgoUKEnuNkSKUKMSVoMyEZBh2nBBRAVjNo4c710njZWZI=
Received: from DM6PR13CA0054.namprd13.prod.outlook.com (2603:10b6:5:134::31)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:04:31 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::90) by DM6PR13CA0054.outlook.office365.com
 (2603:10b6:5:134::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 16:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:04:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:04:30 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:04:26 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/22] drm/amd/display: Populate DP2.0 output type for DML pipe
Date: Thu, 3 Nov 2022 00:01:16 +0800
Message-ID: <20221102160117.506511-22-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: b397ccb6-9050-4fb0-7fe8-08dabcebed48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8334p3LZsrKeeMJz4cuD/E3xA8oL8D0VbsUmzRXQDOzCOr8/sAkfMhB2TblyRVhPJ65EBwapo+4nW37ZsiLnIQAzn3X4zPYaqKnQeIxW83sX7YLEzK18h7AVMYkRrGEt/mDIqcx67oxtZMrtvHFv7Zoam3Ov9Ps1mff+VZhWZUaz+UeV8JxC5yjv8CRuKsfyrSpykLHRMVPfhD8C/zfuktP+3Q4BVBiXsCDtZgTivNRwbo+7G2cEijLzF1e/J5aKCylSEEy6+FjYGSKtBt7VR1JjvVa8H/SP36fXhBqETUKWVDXaEped7WiLUiibrlDkAN/WwjKN8UzOOhbglyTkR8r3JKzrYz7+YnpjTQM10s/b3QAVTklKyRhqP53i/nmpfNqMoEWonFVGzQi/2/3PrIOUy8bIUJKXS6q/4nILHW+xJMXhqLEamIYY5gCbvsZmyHviVxHdVOttZeO5Zpy/1PXmkaYtxTbj5RgeHTmsSNQQL1xphKRXShO8UbMFsNXcFGk24i12ENM6zz59jSbMGJ98SgLTH7sg8r8NKjbZna+m/Hw+l6Uvt41BKcu6o5SDl4akE7Ex6sEpevjKchcZmg7XmF/27Ygk8IDS+akw7b2DdgTtEK8VXUsnwJzBYc8hGxyPHL9+qELJJYRZ3JYEN1qcyvwJfS63n6l6nqOg16ENl2pxgEblPn35+fkBcWSa8/EqcPuAW+e+W6cTeBwdVBiVeWwBSTr7S9PJ6l9VL6zryZbTvhzFbelov/FUvmAeAr52a7N+dyE0mN08TzlJLuuQlijWmoWyJj5UEIg+BBE2gJnT0G/cWNh1U9uhrv7t
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(2616005)(81166007)(47076005)(186003)(1076003)(336012)(26005)(41300700001)(8936002)(426003)(82310400005)(40480700001)(70206006)(82740400003)(2906002)(356005)(40460700003)(86362001)(36756003)(54906003)(6916009)(6666004)(316002)(70586007)(8676002)(4326008)(7696005)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:04:30.9853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b397ccb6-9050-4fb0-7fe8-08dabcebed48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
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
Cc: stylon.wang@amd.com, Jasdeep Dhillon <jasdeep.dhillon@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
DCN3.2 DML logic uses a new output type for DP2.0,
which will enable validation to pass for higher BW
timings that require DP2.0 link rates.

[How]
Populate the DML pipe with DP2.0 output type if
the signal type of the pipe_ctx is 128b/132b.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Jasdeep Dhillon <jasdeep.dhillon@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 602e885ed52c..75dbb7ee193b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1296,6 +1296,8 @@ int dcn20_populate_dml_pipes_from_context(
 		case SIGNAL_TYPE_DISPLAY_PORT_MST:
 		case SIGNAL_TYPE_DISPLAY_PORT:
 			pipes[pipe_cnt].dout.output_type = dm_dp;
+			if (is_dp_128b_132b_signal(&res_ctx->pipe_ctx[i]))
+				pipes[pipe_cnt].dout.output_type = dm_dp2p0;
 			break;
 		case SIGNAL_TYPE_EDP:
 			pipes[pipe_cnt].dout.output_type = dm_edp;
-- 
2.25.1

