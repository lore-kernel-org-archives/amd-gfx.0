Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB25C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A08710E9EE;
	Wed, 28 Sep 2022 19:42:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B14B10E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnVzszTAplFB5N7hhHqKy+Gd6LGZrZ06kT3leZ/UNmkKep5om8FFayuuqlrU/nIZaoLfduaBQZ+eoRr+XfkxY69arrTNZsj3cVqfcWiAZhpAaUdw+2pHg745p0x/480NVHf82baylHYt+e6Rln80WzNRQT8njlibEywU+70IdZ9tJgLHYcAdLzifWutrbaESmBY0YzBe83T+ArDP2fSSS2/kKyrhB/fjp+U+gRUBp1VR8DjpUioMY898PTExVNRDZAk4rQA7dnNBwuSqRQ40+/6O2Sx2Qf1WC+Y5zb1KwBP1jyX12jxB6N7IrvgmR8fPVWjNqc8isryDF5EN2n9myA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndyYcG4BsQXtk3IVIHLaVsniikTvIzNO0KgyCXtZuks=;
 b=XgT0buOyifl6C2qlm3Cja6z56K42q4IqMOgsx902oh/ajLOh0xZjcaHmJ+YZje3a3cAJQL61g31ZIh3ZDb5aHiAZl/AhMo3/wGT0xqOoVaK0+79vHi0vyLdIhvTGc04Dv5jxmtAw1diDO75P/I44d4A7la06jzzmxCKoHlFQcf/nxcWv9CXHaOiIqrlpyX5HC8U1Xanx1FCJCBpMZb4zybarm08aygyTSRGbX6KccL4iYJN8rKmR5eiLhsXEjcqAelz14vAfoppUWXRgECSj5UFY4q+73JjYL+vspqOCHLNQFyb/Wq2iyThh7m7Prjuhzvybaob8P/etmOmZUBmkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndyYcG4BsQXtk3IVIHLaVsniikTvIzNO0KgyCXtZuks=;
 b=YhUh7X4CqZnkAgKkyYoHHFAAnLekH5Wb8lUNPNX+XFXzaS4ILmS5btfdUvbW7U4HWS3oNrnbcsNEhPpMRWjlOJ4CvSQShJtRq9pAoAedJGw/9BNZDMmdVqJBaVHlxK+ytOk8RDn4N1qaqKqh7Rj3mIaI8PJl/AtZiQu/zJoLnjY=
Received: from BN9PR03CA0786.namprd03.prod.outlook.com (2603:10b6:408:13f::11)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:41:38 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::78) by BN9PR03CA0786.outlook.office365.com
 (2603:10b6:408:13f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.29 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:38 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:35 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/36] drm/amd/display: Adding missing HDMI ACP SEND register
Date: Wed, 28 Sep 2022 15:40:21 -0400
Message-ID: <20220928194028.144879-30-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f19c36c-4cd2-491b-9dac-08daa1897589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wB29Cwa1ig+mHbVZMTCsyYzOKKuByNs8W/qn/u/G7TaY8/AojaevJ9n0/tccFTdza/teXbVWRtBR3bpfehgxfvSGhBWpagKkeX/VI3vm7V/9QcFioGKI9QgP8aTd0/7NtoXjnPsoVBqJudhpMra1K9oE43Z0C7GjrEX0zGmq5mDwfn8Ul1fFHwFLf6cMdejNQt43prioxSfvqPR3Fbhqj79cLHAUiTeBEZXtKJCnwdAIvdHR6zsy1oA8qNpxD7qyMgdDSdufcZyZ6zb/71j3lwx0x2MP/tenTByLY6kmI9ZkhX7erQwEOkJ+xURlpJd/8oJ4yMK50GcEYAOS9q/rI8yKiZU++Sl4/MoGyPnJJkymmD7YFWaOOW5HAxrPtOIkf6alJ/8ADM2mz07zrD2ImvXL7rfEV9pm6xUzs211ytZeKMCV/oTwrVvdKMDQ15cyhAUvdiMdUZCOvabkKnGKPKfjLIfU9neU+5o3ZVcauxZFpKh03K9oPYVcVZQx9lFGk0B0R6aWFabxINdIEB9fKyrkKZdoLU/jzGO2rAmrxFOpMtf/O2iyjITtNBJf404RaJZg5ROFwlennp+bDGuqZPHLqgD7R3BaeHBmLpHJcdOQPWbds45lezAUVTOOWujlmK9gvtxVUUKNAJkkLxpaxFtNyq66LbrQkpEUVa16Ao288iPUXOkwLraX9PNEAcB0Ar720o51fqVxz8w5L6gtLso0g+QmXHZMKtIas4Qf2RzL3jgnFkJeqDM79AfHKn2y7sG2Pj2QTfB69dlWUQcLvoPzZkpCd/bujYQt5lXMZWxbdOL/By5cM1xBhumnTjwGOC4MY+AftDEHcDiaKReyCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(2906002)(36860700001)(6666004)(7696005)(478600001)(36756003)(316002)(82740400003)(81166007)(8676002)(4326008)(70206006)(40460700003)(70586007)(356005)(86362001)(82310400005)(44832011)(41300700001)(40480700001)(8936002)(6916009)(54906003)(5660300002)(16526019)(186003)(2616005)(1076003)(426003)(47076005)(336012)(26005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:38.0266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f19c36c-4cd2-491b-9dac-08daa1897589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add HDMI ACP bit field definition for DCN32.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
index df7e36576ac0..20e5f016a45a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
@@ -108,6 +108,7 @@
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, mask_sh),\
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, mask_sh),\
+	SE_SF(DIG0_HDMI_VBI_PACKET_CONTROL, HDMI_ACP_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, mask_sh),\
 	SE_SF(DIG0_HDMI_INFOFRAME_CONTROL1, HDMI_AUDIO_INFO_LINE, mask_sh),\
 	SE_SF(DIG0_HDMI_GC, HDMI_GC_AVMUTE, mask_sh),\
-- 
2.37.2

