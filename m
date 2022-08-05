Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211F6C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414BBB9348;
	Fri,  5 Aug 2022 18:00:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1AEB92AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxJ9SERTSxA0H7APVZ0vaYSCybeLB7ZUi2ZGkncxynSt7aEcKNAYoBn+rApU8n9jT0NLngXX0Mhg+VyI90njRwRq5zVKNq+aM3zvUchp5vrX3D7lRWxQUhMcmfHTyCEy0MGFfUni8Rej4LWOBxvOTAnKQI6pmuKPMu/sL4BGlvvyJlTf47Ym6Hsm5UGZa2xr57f8SVu9UyJlWxvJCK06UPUKVFWXBt+oJkkDri0Afnst51sVz3PDxLTeLzF09vSmkYvq4p9E00vcbtzPIrNZG1HY89tVBWUWlXrhBqJS0wksCbxVeoVrWPKiGQ50EjUbcbFjj7xtV3I8lXcHruNM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYygAsQwFBq9ojjYm8TYsNoKnmS8HIhtzjYe3PBcml8=;
 b=gWht7U0v+73VexxPQJZXWJq8Fmt8RdljPwUWTA1xrXj/xAVZbX9xBcC+YBSNZ63DQ3309fGJuirMRo/lKl8O/z6DvVN5+Neh209q4PYX3hWVPQeSbjOLAral0pHsRmEvrQq3pVsMODVrrXshpt6XFg57y080SWRen3uKvpdYDx0VIixlztgNxTa/T3tpv/VHdjDbgTGCIWVEkhKxQPQd5gDIKdPiFvS6RlGPVWyMHw4S/HLi8SnV5VMevpS+evfenN0WZeq0+4IgUBxWofObjb7tqJAGMH4H8fIr6FWLSZe2PezRyoelI/yFiCKo2G0eoYPpR5TvggAAQVXhkvF2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYygAsQwFBq9ojjYm8TYsNoKnmS8HIhtzjYe3PBcml8=;
 b=FLZZVgi7sQTfAd0sStTwVdICcM6pMMKTAJBoW1rXtHmOT7T+LRwqoxIPsJcLZLAjs/9GSnN8FNbLR7dHCTfec5+7xCM1cqt9HIRaI/hx4d0rnrey7h+PfSLhsKLzA+bt1JsWPW5cRFaDncynmtqIIE/MmNm1YTFWXyusMVtVRJs=
Received: from MW4PR03CA0329.namprd03.prod.outlook.com (2603:10b6:303:dd::34)
 by DM6PR12MB2731.namprd12.prod.outlook.com (2603:10b6:5:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:59:55 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::ea) by MW4PR03CA0329.outlook.office365.com
 (2603:10b6:303:dd::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:53 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:48 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/32] drm/amd/display: Avoid MPC infinite loop
Date: Sat, 6 Aug 2022 01:58:06 +0800
Message-ID: <20220805175826.2992171-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb13e6cd-c521-48dc-25ff-08da770c4da5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2731:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IGJ/wvr+p1oP+xURLxAyLZukc7RekMNEmwXuebFV4n+t/ErPR15xkXFwurXa/r0W6npKoGNIjtlluLd+Fc2nMPcFpgpHLvWDfi/NYH2IQFOJryY+8UG6OsjQBB3yT8c/7xuvFrrcNjaGA1gn/AVOBqEsKW1HbcBQjLpAsQvUX0+v4emZPY7HoVrsyMQAY8roUeEEMXzFUABrwSG9mCeQI2hhBAE9GcTKI9aDyDdehYO8BEzQO/DdAWXhabNKaH3MT+N8mMFH2KwLH9ilgar7fJpK/9shAffTC+opfJFz7Uiac9EbrgHQtge/9URcufAOxmBQf6Ozyv5XsZGCSS7BI0eEc+jcFPHWZwCwutLltUekc3C6Aptf1c+6olLOu2NU3MNVTio2fgrkfrMdo25DJMEcn/Gyjt2HXZJJB6Guj1hmZQnWBBF+Q9vlndGdvVZKm4Ns46dnJIkAXayKZEEXJr20OY0g+ZQ4rf7f3hJZDaFZyrsSMzMu9wsyKLDdNxoI450SM3qa1noYi2k54lnY7i7pw/GR9yA7L40D7AEQPCGswbvLDP/6v7x6sp8ChTZoAQFZCXAI8jdYdc0o08/XfVOhE4qZcDrybxP7H67Hpr9yIuMg3LyRlpee4RJR8Jhkus9gTkHi05zTOfoHhuIm+3A8ZWJ/XeEGmhx7P11HAQWDUw2xIX8MOeT3NK0SGDg12h8B32wfSqpvU/0QYj5Bq5TyDGqO3OLLLngT5HEqdeWlfBc92myUMw6+UrDeNoTUnF9C5QaTwPPtlRcgFMlAlENBhCHYFEcvXvN94pV9ZPeAt/7mTAxPYGTUwF9Mf6/CGfXIX6UuzepegrEmv4NHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(356005)(36860700001)(40460700003)(336012)(2616005)(426003)(47076005)(70206006)(8936002)(8676002)(4326008)(70586007)(1076003)(5660300002)(82310400005)(40480700001)(2906002)(7696005)(41300700001)(478600001)(6666004)(26005)(54906003)(6916009)(186003)(316002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:55.0453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb13e6cd-c521-48dc-25ff-08da770c4da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2731
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why]
In some cases MPC tree bottom pipe ends up point to itself.  This causes
iterating from top to bottom to hang the system in an infinite loop.

[How]
When looping to next MPC bottom pipe, check that the pointer is not same
as current to avoid infinite loop.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 769974375b4b..8e9384094f6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -131,6 +131,12 @@ struct mpcc *mpc1_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
 	while (tmp_mpcc != NULL) {
 		if (tmp_mpcc->dpp_id == dpp_id)
 			return tmp_mpcc;
+
+		/* avoid circular linked list */
+		ASSERT(tmp_mpcc != tmp_mpcc->mpcc_bot);
+		if (tmp_mpcc == tmp_mpcc->mpcc_bot)
+			break;
+
 		tmp_mpcc = tmp_mpcc->mpcc_bot;
 	}
 	return NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 3d307dd58e9a..116f67a0b989 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -531,6 +531,12 @@ static struct mpcc *mpc2_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
 	while (tmp_mpcc != NULL) {
 		if (tmp_mpcc->dpp_id == 0xf || tmp_mpcc->dpp_id == dpp_id)
 			return tmp_mpcc;
+
+		/* avoid circular linked list */
+		ASSERT(tmp_mpcc != tmp_mpcc->mpcc_bot);
+		if (tmp_mpcc == tmp_mpcc->mpcc_bot)
+			break;
+
 		tmp_mpcc = tmp_mpcc->mpcc_bot;
 	}
 	return NULL;
-- 
2.25.1

