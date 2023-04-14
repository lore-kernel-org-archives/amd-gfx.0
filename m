Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93077C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B7C10EDBD;
	Fri, 14 Apr 2023 15:54:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F29510EDC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2P158/TEs5id3rWkWBDr1H8QcF1W/Zhb4Fnw2JO5758n+Tj9B7bBOMAe9JfosgZIb87g6Ykr9Y20NJnGQlGlkgxedmMjwHbwmyuEGvlcTVtTiNpHjLjAbq5WuRiJQPVW234kGSEt5gu9V5UZxJcBkVg8DrcqQrK6CwOybLwNPo/UZbkpiKu6SdgZhISY+nef5AgBfeoXjNxLRSyAR8SgXUo9d36Q67Zm34TIbg1SbwVkd6Ka+AKiVnQfNgLvOAc3T/PeHD3/zAWmf4rfL3j1YjXohoKCITVWqCQ8JZ3ECWRZSh3f3JPxfRHC5r7ag4Hms6bzKskQVwVBRS+D5KRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Bx3IpyjnfO4gbhE47uaTFwP7Xk42ZHyZLNW0eZte5k=;
 b=Q9LWp+PpElo9wTuF2cpqDRBcb5yKQmTQwpIl2JumQ5olH53O7T4msMt/fEyCMxfcJkzeBoqrhr0mzV33r033j3nr6ukZiRFCBXdzAfTtcULvrYe6LbwNy2gHC8M0fdGarnbutyIRQc6x+fRu+B9Bet2ZkbfaaKRuzy+reXHVN8Gvi60MSkYeH47cIIBk8Fbix1cWelt5/e7tI7PbRCu0Yqo6wfD+3FbH7BEVPLOcoyXSjHdn+f6FwAOk6dqhqG7RYPFbwPL2mDQqAuertV49PSj1lfhjeS7mYMeIV+YzCodb06RLYx6WXCjFEcDiQgRWdvS362M52yW1GLqH+9uXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bx3IpyjnfO4gbhE47uaTFwP7Xk42ZHyZLNW0eZte5k=;
 b=uyx9AqtkVsB33oUyYqjqOr077FElgztWhXjjWqJrmYjfFJclHNtL9pof5X/mC6NkW95AkNUTdbKAEnaKj7Q74NVBrYwbsau0TbBtlaVYkNkUswsIueoVgTfh15iV6GsgA4PT2MnbLo/RGuChcuSAtJPkajDExKHrJa8s/rqzgqU=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:07 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::81) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.6 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:04 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/66] drm/amd/display: copy dmub caps to dc on dcn31
Date: Fri, 14 Apr 2023 11:52:37 -0400
Message-ID: <20230414155330.5215-14-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: aa287dce-5b7e-4180-34b5-08db3d007ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHkGWhgJxn1iHlNJUPO2qUXgqLDTQUCgxNRjLnhP51SBAU8QGxlIr/giDBsR3Jr5JMMp8JBBhU0TtKt0Vfk9AxvIMBGkMzJ+76NZC4sHzNuGfop4DB/zM3jRIOnMPJA31//zjz6vkY19XYjnyaCN5sHPpNH2agMiY+/8ZAiEwJnT58xNJeK0W8dUVddQ8buxZ88xgT23df7QMa0aNvByuQbElN6dzfPxg1AXrvH1vvYmu1bpUkopkfLRXRHLggOAsJGtmfJph0hT1z8DQ7AKjxLnK7bAljs4WCOM7VS+zb/6LghgCo6b7SMs/dWr4RFD+t3b1Xe9UPHobk87pyM7BwdTy8Sn0itMB2Qvz4dTgFfi+prVtPbQgA46tdSptPihsmDh9rc46YckPA38A5pZshd/hlxGwQPYghZBOKNk6hWF8HzhGz8TGQYJDsCL1NkB5yZ2IA4onBXAYs21GpFNrVCwzyB0Z/n9gIAZO+Sw2he+PlqqFRBTdeGMAF2XhBbQVlwoTLmloYkcNXCylXzvk0u80Ufv8Ex6Chx8Wwxm6UTSH2eF+joc8UfU9rjj1PqsaZk8kUHL83SHVs75ATugAsaAF+s1cSjuAYLCioCEWtv/ZllMd+k5/xuoI6u7g75yv5fe+3Mpy+sj8at1gZVEzgQHgHjcd1gTIT1T+/NvC9NvpCj7cepMo/Xdd/0lzGBiXAqJzgnv/m17KB6mNDjnJKcXgbe5x25Ee0/rwtlmSqw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(4744005)(70586007)(8676002)(8936002)(70206006)(5660300002)(478600001)(41300700001)(40460700003)(316002)(426003)(82740400003)(36756003)(54906003)(336012)(6916009)(40480700001)(4326008)(26005)(86362001)(6666004)(186003)(1076003)(81166007)(16526019)(356005)(2616005)(36860700001)(82310400005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:07.2232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa287dce-5b7e-4180-34b5-08db3d007ad3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Add code path to copy dmub caps to dc, which is missing on dcn31

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 7ac6e69cff37..62ce36c75c4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -295,6 +295,10 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->init_crb)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
 #endif
+
+	// Get DMCUB capabilities
+	dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
+	dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 }
 
 void dcn31_dsc_pg_control(
-- 
2.34.1

