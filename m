Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AE3C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E91910E9BD;
	Wed, 28 Sep 2022 19:41:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B72110E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0uUvWBV5PELh1uvVwhVAjbJPusxoRDYFSP6Kdbm9vnOaHAjS1eQ41beJuceAFHGRH4XW9ixq019MHW1mojJJ7e6NKbhzPpuBfFwvxwZjbnr2IL5EarEawTxSS2frf8AYqr+51d1ZEA4Ru6rhLiGfgOeUFUhMBjoZYnKOtZZ32uNXBgd+F/3WsBIDrsZA9l0VeDIj9gt715Zg/aXLAKy/K4pbpgVFFWNoA1vZWsdRKPANMGz+dQYMhwaLBB2QUsoQilvp9KMUKlccabaMc71PwahKDPf8dB8NQ/fPTm5DtLXl3AOkiebx5v4HGPeY5+nPWfY/7ClDEgCxar/pRxiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdIv//yqC4YXrrm7PXAADfya20soBrqgUdw/DoEZCMw=;
 b=PRik1o7Xz2pFHrxSPS9LjPSrFPDJb12k2ZesLyv1AsxpFGi/SrgO1bj0VPfzMcLDUc3LB5KXxnfTd4uXd/vABQX1R1z1hOAhL4Y3n2NiCSGyThmTkVFvr4+nHHKFEwzhBywr7RK9YoqEN4jZ5mIYU6rEmjCCiYbLGwQY0LaxJgfQDaePSFDFIQTYpCvdQZPocRDPnQlLKaSFm7Yc0aCEfPoGp8N76r0g5AOtd81dF/HimDjZv0WjTkDCHkER0Gq8o9eF1jYsDdvI9XfSt8bw7xFUlVNiX20AMjGdr3OJ8JVnEzXicfhwxZsljYYQlKTi8YDQHhP5tD6fMdO86CypFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdIv//yqC4YXrrm7PXAADfya20soBrqgUdw/DoEZCMw=;
 b=n03GOPouknDk+HS0/2l1gqIiEJOo13DNA4XGI+amAknFLr2oo+9cRqc92y7OPKo1t7K3T06OQd8zSd1k09V5mMytAXyuG078KfWRLlnWvZOqCExYyT/zJpAha2Dn3zzFCce4ZCO1xYWf0ubDxjP70CMsN51Ft0XWl4YarMn0r7Y=
Received: from BN9PR03CA0313.namprd03.prod.outlook.com (2603:10b6:408:112::18)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:41:41 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::c5) by BN9PR03CA0313.outlook.office365.com
 (2603:10b6:408:112::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:41 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:39 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/36] drm/amd/display: Add PState change high hook for DCN32
Date: Wed, 28 Sep 2022 15:40:23 -0400
Message-ID: <20220928194028.144879-32-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b05890f-eb5c-4890-b286-08daa18977c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQ3mB5+XAP7qhNgh+WOTVLCZjAd+4rKpQqNwTH/LV/zwi+ZM0FHk5/BHgp5uLpvOaoltCe+b3j4mjRJ0PUqeFYlfMgk6rNCeoGz9cr2vUc7sf04EL4T6OXmC/cxP05XCTn/SvQxBb/wm12ryasCgKVFjBC1wDdB6wEo/UhhN28RXrvHIRRf5DecBGml3M39wjEVUS8jfvsrPE8eVSfPyFFRcskrVL3UBe0VmRFATySkwiXegv/jwFzd9g8aertZlS1h2wNAvVmIulw4KLcliFFFqJSwtOPj9p1C0a1e1N2fyZl4ipG6I9RQ+A0EOqWlDF5+KYcc/mZr/hllwxUTtzkPHorFHQOqpoFBz55KFFRfdXZPy+im5M31TUmm3COtYvalXlT+nMeacGN4L5gKIsQVsTGiX4G1Fmq2gyUhfJyj9hqMT3mvB9zCR9sYmk63g/NFTkQWg4erWtnMWN2vU2m5jJq6tIpCZV7D9L2vzKQ5v8gN23w3TcrkeFCkUbkj10vy7P6mwqUYiQa0tQyVJUPgXm/xY/CYlacxWEFr1HyyEbV3JPX5tamWob+DlBBYzi6AS4z5D9T3HPELoN2n39J+Q3uK3CJtRFEgPovzc1z/gPxJ17dKxAMmJqg61LjuzQaGTGDe0zdjhd7Kmh3ckiIoel06qsNRWuyf1s4Oe3cFLv5mZFWGSFG5N+cWD1LwEjn3be8uybLwEYdV2TWYn012qZhZjPaj0FjaEPDHcLF1rS/tLzevOF5vNeJ7HhXaCB2sNqtUvDAq1vnLXRtRmxzB/66qQcbkLvbb6+se+Wocz4csBQtKvqHvh1+fYs7Mk74huumfphUvCVq9oPvF96A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(54906003)(2616005)(186003)(1076003)(2906002)(36756003)(44832011)(8936002)(16526019)(336012)(5660300002)(426003)(47076005)(86362001)(4326008)(70206006)(356005)(8676002)(41300700001)(70586007)(26005)(82740400003)(40460700003)(316002)(7696005)(6916009)(478600001)(83380400001)(82310400005)(6666004)(36860700001)(40480700001)(81166007)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:41.7495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b05890f-eb5c-4890-b286-08daa18977c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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

For some reason, we missed the PState check for DCN32 which may cause
issues for clock transition. This commit add that required hook.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index f6d3da475835..9fbb72369c10 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -936,6 +936,7 @@ static const struct hubbub_funcs hubbub32_funcs = {
 	.program_watermarks = hubbub32_program_watermarks,
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
+	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
 	.force_wm_propagate_to_pipes = hubbub32_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub32_init_watermarks,
-- 
2.37.2

