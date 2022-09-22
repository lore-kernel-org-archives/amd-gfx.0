Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B055FECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C325A10E9E8;
	Thu, 22 Sep 2022 00:19:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1F010E9EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyg1pbdQImuduznj4eLubkdT2JmgTd/llTqhYbIaF9CUgoAiITsDvMI66Mf8tyjGq0MwcATFz3pEmuA7Ak7ef8cZIU0Rj0P/kirjEYgc+jxb7nwQnLPkaQxVUTS/ePOS4/l2vQrsgBErXbSqTMCkE7IYJ9I5P+MJNEbBymWDxcGA89OKbeaIpp5ccs642YO4v7twn4aetnqMOeeps6p0/j5udLmyl/X0KIezgG57ZbRxlL9R8+wS85kbV/P+OPdItTmaRBMATOhdkWH/imnap+XyJMRQSPZ3A1ZagJICHRBj9o5eQoLQSOu1U+b+5br0+FIDlftY8sZ2SJvfB/THNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1jmpcAx9RbzdbFi9sB1j59vCzxVnzHw7ed7Ar2HUmc=;
 b=Rp/U9WeG76DFTUABM2KXL6DQX7dlfeMfM9hnGcTHDqYbtGvr4w/VJmV7gjZnN3QniIw1JykbF0kQff64uVATfG+aG2H76g623fWLLR/gfDoYmjlrMjhY4X+78znSByUn0jwzhn/MH3D71ovhHfQX7APbmX7RMctNQg/G/fJyEcgsr00M3sBjQpCnLBmWAUSYldLUeFpIa0G6+MIc9M1PgjgQNB3TAR1l6W0A9/ZWWUQG9npr6FYSEWSW9NyViP1wlqCXsVKfprwkng/FwRX4aw6gd4WGLUZPg7m23JfmrE04xU4qhHDKWAtPrhxAuHp4+9fGZfMAKb4Na/KN10Ud1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1jmpcAx9RbzdbFi9sB1j59vCzxVnzHw7ed7Ar2HUmc=;
 b=3DLI3KMByHckuBaA+uoQbx0yGudkZoLU3Ou+tehvPdu2HPN4FvsLUPfkDIwkAKk2fwyatDzcpKtBX3getesYJ3saGI9ryMuKZmnre5hfrurZRupgfMnM/fPjgMI2EetP4ucg1joA2bdVU/G3VTGWqP+IXJ2sPfnwvsqc6FRaWq8=
Received: from BN0PR04CA0068.namprd04.prod.outlook.com (2603:10b6:408:ea::13)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 00:19:03 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::bd) by BN0PR04CA0068.outlook.office365.com
 (2603:10b6:408:ea::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:01 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:58 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/31] drm/amd/display: fix a divide by zero error
Date: Wed, 21 Sep 2022 20:18:01 -0400
Message-ID: <20220922001821.320255-12-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8553de-a378-4ac7-e66d-08da9c300d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Qige9o+Kh5nThxfb4Mk40GNEfsWCh6MpAULJoW7OTi7SV74BLpgmb5CgPwkavYgR3KcugPZGIXmhGadnvg4wqPCQWZ7P5h0PbHVUhuV5TyAFmxbbApxgbdRkFKUIEDsYjpsYIUbUyf8bI91qhfrJOBStC7eoD5ilwfnFPUXSHrjGBs5lvHYDeJAVZ+vS1Me0yag2PMNCTSLK8byPsekPMfCJah4MZOSwVIvHhaT+jrZ/HVCRKKfR1bAwkrY1VLV+xk91B6E6AHeqlKVf0IEM+3WdI9RAr/4Jol/9kGGI1XTeX0AuZiBjDqWW9KcnjfYqwIEG/LxBUjGdaHvzrRVsZjIqmX05jq3lWad7fX+niCsUF9VWkV9buwrKnqargmBEn/l6wKTv5R0hkDQr1dPvSyletU/AFOFwUYNaMMyRaRdAyggRM8zGd5aPAdHhpDYXVXOS1IcBh++T4++T/umltxwpp2i0LoPYmNYEp6sBJNo04AzeJwCpe9C1laTx04mSWRcMCtf+7ZbUu9PLrlZhHlsLn12rZn4olYPkzbqA+9am2pOtr2iBUWwUmkOk1C8KBPAlx0HEJLveJcdK/YdE1ettogvuXCEJ8fAwaAg27ll38t84sn2WB4ww+o/+iYLWPXWTjg25yL2RO8SwVovG58MDTY47kZjpJkbYRgYGqe3DQY0iKHrCwtNsndPCzXyqaU0M7kgQlpM3bN4hDXcq2fMWb+IDojP7Ms0bIk6B9E1hqRVA7LYGVS1m+IiZw4wMORZZQjNSruXA2EK0yU3ckXizMlxPMvWRCgMYmMx+OFKGz+OS1p9aZBfbygXjhEv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(6666004)(70206006)(70586007)(26005)(82310400005)(40480700001)(8676002)(4326008)(4744005)(6916009)(8936002)(54906003)(36860700001)(1076003)(16526019)(81166007)(336012)(186003)(478600001)(36756003)(2616005)(2906002)(40460700003)(316002)(82740400003)(41300700001)(356005)(5660300002)(83380400001)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:01.9892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8553de-a378-4ac7-e66d-08da9c300d3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]

Incorrect variable was being checked for zero condition.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 46ba6eee69ea..a2a70a1572b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -278,7 +278,7 @@ void dcn32_determine_det_override(struct dc *dc,
 		}
 	}
 
-	if (context->stream_count > 0) {
+	if (stream_count > 0) {
 		stream_segments = 18 / stream_count;
 		for (i = 0; i < context->stream_count; i++) {
 			if (context->streams[i]->mall_stream_config.type == SUBVP_PHANTOM)
-- 
2.25.1

