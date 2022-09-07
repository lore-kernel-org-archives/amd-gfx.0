Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9777C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 17:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AFD210E800;
	Wed,  7 Sep 2022 17:33:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEED110E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 17:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGkMY+IPh2tRs3XYmJQW9A63IpOedx+XiOIxqQjDQCcaLTEkgmF2sY7rh84ALZom6Drbe9i1TFehlgUx4xYEegBgFqqYxUWkYTYInzV3ZZqHiLWaWJybexwkW2tg4VyO6srqZDghg5//CGv1j4Ua+3lxKFM3RY3hLXehB4lMenIIgXwHfuQMXpz7WBlT4L8OH++BOK/MMg42XSCecUSDZE2S7dvM4xklg9Ifugch/6aGPuAy6xY3IV4CZow9ii4c+oY0SOhlie4e/BJpkAV6LA2RgO49pQE7PNJuaDHuVR778kjNI3Q0Nx5kFHhpHXgi5pPHsaCCo13/pBp8yydM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlsqAPEEv09ToU82xeJWKj15GnA0Wy3yVqnG21nVHsg=;
 b=aJHMA9ClNWwGIpyhIKHlwKZgvCQ4tpWkuzWzARGXg2+IK+QN3nViiXNmF/Jl8/Dc4G+8jL0/uVJ0SwyqyUlxqbzQvuELvpe8HolKCV8Beqp5WWaMXoedI2/UlF0ZT1oeQ2nyLWXgP56EbJX2ibmDNJeiqSkO2oCYFUprwwY0l0RfMsOy4XG6GBUHpR+owNGMcBub5KCXew6hR55RGOiNRJ3blhsoy+/aO68BChB8UE0fZva0/fxz4gRJunjKkBRAnZJ9p2ToQSbinLRW00eqpAG4Wd28Zhc9kcB+MHax4O2geLFswPvJDgP54G9Sub0NEirt/+QrgGWEpiv5Cmtldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlsqAPEEv09ToU82xeJWKj15GnA0Wy3yVqnG21nVHsg=;
 b=bOJH6DrN8eHyzC4kz8MW6RjqitYflhBHFyQhxFESHujbrhgEeqnQ5qcFKf1p2qY1rcDjWkbzPzEAjXzggIbxzbT6rmgoNaEu19K8kAlc91komPe0mHgCVaK7J5e+CrwJukCs0ZBSBPBrXrAHymqRU0wQIvWMOs97yLyhnDvcZjU=
Received: from BN0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:408:ee::10)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 17:33:22 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee::4) by BN0PR04CA0005.outlook.office365.com
 (2603:10b6:408:ee::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 17:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:33:22 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:33:20 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/27] drm/amd/display: Revert "Fallback to SW cursor if SubVP
 + cursor too big"
Date: Wed, 7 Sep 2022 13:32:09 -0400
Message-ID: <20220907173232.11755-5-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907173232.11755-1-pavle.kotarac@amd.com>
References: <20220907173232.11755-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SA0PR12MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: c1909b22-bf6c-49a9-abdc-08da90f70fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2MzQSRNgEiaeY5L0Xcj//3F7H0/ZGL6l3fvdMXXzEvY+glsERSHt1eI/luKVNIsLZs3kCfSk/AasGU+DC4z/C3rWSTOzl1BaTOs7LN7fHxrcvlqYT8DTbSMEMFzJ3UTnbCvkROlrkouHpm5vItLiLQLJYM+YN11BWyN4/IgQlf3M4Vp+rYv0TNt+mOmQhcW3k/xzJD54m7dmTpFqqJgr9DBAJITBz6xfv+LYf28vsKbUOiWd5rWB/OiTHeIAUkvsqto0o5ZtJ/1Yg5dJERTmUg0pHQ6pNfYCaWD0w67M3QNPIrVsFGRFVlm4IOep1n1NcsJYlV/C64NTFGodGG89SFMSM8W27KaLxx42JVGlmAPe8ErIsLG2zTOMRctYJbcu+VVQuzeSVL99ki0+uGQXuZaHQaB/48z1daXT+MQHBqHUSp7dshgeqjSZlYxpgDwgCeqLjjbLS3Tk7oziGO3irIOPBKwLWnOPgJfNt7hWT29AuxqCetdII24ezTug5LQQd6+6aBcYDOt7OMxBsuq6xbMcYycbmG8eQDQPcFErrEFGaoAiiVxIlSx6DQKAg8JGMjc56mIB9IOUERqsHEDHcML/qu6J9jMnnVp0aHq5UDTxoqMN0Dvd34PtQTg3dFXnTliMcBqG7sv52aw7bOfzEFusCO9zladt8R1zj1wvxYKQ9RpszWIKN4Ghz09Dp0wF2TYlxnRQYgFo3j16nQPrXOiLmWk/Nq0UsCqae6bxslueXRRRg2eha3qtoyV+8b7vOCp8qd43lV2DHx7nP1NbSlK+Zd2AWmZfU3aXMgZXadR3AlUq7tZUWl4ByoKyWwG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(40470700004)(478600001)(54906003)(316002)(36756003)(6666004)(82310400005)(26005)(41300700001)(1076003)(86362001)(6916009)(186003)(16526019)(83380400001)(2616005)(426003)(47076005)(336012)(70586007)(2906002)(4326008)(44832011)(8936002)(40480700001)(70206006)(356005)(5660300002)(8676002)(36860700001)(81166007)(40460700003)(7696005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:33:22.0738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1909b22-bf6c-49a9-abdc-08da90f70fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
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
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

This reverts commit 8dbf225893cb07f98f8edc2d775b6a68fc1eab3b since
returning false in case of SubVP results in no cursor being visible on
desktop as there is no sw cursor fallback path on all platforms.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index f62d50901d92..6752ca44e6e0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -328,11 +328,6 @@ bool dc_stream_set_cursor_attributes(
 	}
 
 	dc = stream->ctx->dc;
-
-	if (attributes->height * attributes->width * 4 > 16384)
-		if (stream->mall_stream_config.type == SUBVP_MAIN)
-			return false;
-
 	stream->cursor_attributes = *attributes;
 
 	dc_z10_restore(dc);
-- 
2.34.1

