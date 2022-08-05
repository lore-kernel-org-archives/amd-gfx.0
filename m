Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ACBC25B08
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A1E95189;
	Fri,  5 Aug 2022 18:01:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C0B12B6CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAGGIq+02+Z4ox2vvWQCsYV7DlDt/CEgz1waxHGci1rSojFD25PBvKilEMsrb9k1oaV9dpoJL3Wl/t8hGHsonGmAEsiaF1FELUGY1+B5CAvO3b6X8Lu67xiJ4R2g9j8074tAVLudEFpg3EJDtcRFUUl93xbmY8P2djMZ3ev8mQ6BmGeZPDL4MMw+vGAzdDrsbpIPsSX0zI73ZGJnTGadwIsQFtSkBhzyWdLozz/k2VgsmRQeEeQigvHlJzq1foThPjaLFQYZIfBcqLmCG5PX3H0So+OUT97PehiNupQJYBiWgwiB1c86JAb76ksrHtshnAUq3vepGFCkgZHCBsOVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89xwTKKegMYTuOxJsqzn1cu773aLZHSF6ewOJ/zeJoU=;
 b=jpeiWtwkEE/Ml+s7qosT8e8kAUg3fTl84iN328at1V1AFr0QOKsMKKg1w26by4GAj2ovmtm8PcsdkbLDNLx4YODfF1CbF9Wn0mOplKQuVmWDFiUud2jbZZF0qn69ae1NkEQ1kuAXuvW712D3oURudQx5Y2NgQTTyLujJ0ycFFKVt14zUX29r+ipL9+yJE4rxQ8hT0wpuUIqWB90secnu8/Tq2PQdYuliHfPKKzTwSrJC5UqCKh3WCIX8G8o2R01ViSwY5bwSMGDdVbSYP+3zP5bscYWkb485sx2XLEnlNdpJG/JnFNo/BG6e0MqjtT7bHpS2P5CFwNENRf1zgeer4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89xwTKKegMYTuOxJsqzn1cu773aLZHSF6ewOJ/zeJoU=;
 b=G7nzqAzM8Ba0833ZyEJhO2re7hEhoaxLCdhZaL0coU45Yh1wBtNOdbXWmEZFU1iwDG6FWB9J4Y+Pfi+/iFv6CaFtDWW+fpJrlw96FEibUbjgS2t447JTQFsVKjbygVVVX8Ff7pMDa96p77z6okHsm1CBNtWDliqLUCI7E1PMfaM=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by BN7PR12MB2596.namprd12.prod.outlook.com (2603:10b6:408:29::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 18:00:52 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::11) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:50 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:44 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/32] drm/amd/display: Fix Compile-time Warning
Date: Sat, 6 Aug 2022 01:58:16 +0800
Message-ID: <20220805175826.2992171-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8acd8924-aded-4c81-c288-08da770c6f73
X-MS-TrafficTypeDiagnostic: BN7PR12MB2596:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tm1M/kv/Jt5TEiKLCTogSWGesZIHrinV7AiEHVI+K+19HCCirE0YGW+X5+vdgaknFl0R+4ApAsMCy5pdrR0MlFeP4Rlw7cuLDbIyqOJQydQ74gPxhdLGRMpmj3r5ZWMa4ur+9emGUKC6X6SfnVBJ4dg6u2jWjGr00PDKFoUJ5Sazv+k97hOHKwIMZdzavC9S7N0hJrluNHRDDU9e6E6Er8k083n7GRm6b69WHDstQOmuqH2XYESBaaUHFabIOK/OIyfGIW8mJBRpVgipzrxm5T2pJzTPLh/HRrVEhlULhc/P66aHSEb9k0qQcZMLvUX1xd6w7LUv6rs6H32TQQchyFxspkTkxMeU5d1Q4pkSEea/1qhPOb/JSeFljaNQrojSAYdauHeCgySnoSBt2Beqsl8fa7Rt27sUmWWMNs/KCgzUj4Reo1x3ALQblfqe4eaEe4H8zeCeHVB1pFSUDcTNayNsltW5NHUdi/XI1Li4caEXnHQyMLsStu79HHDse1QlOB9gquSWujm1YJdNNK7ZKKJ36sJOvTITJQKuJe+h4gc/l2vI27IyfNIkp9zy1+huTkXj3vMvbn0+xJOJSwUvrK16C+wBHtfJ0Ao7F0FX+BDyn12AvcjM14uda8pYP2Kvy+jgQYc0hZDF8PB5eqXCCEqrL0UiGSKkarn/vQrvzy+6VIWDZaxF6kVr8oHY5yjezfe2opqHVYWKrV45C02Wz57/yEHtCK6efsV4L9SfhwSMNEt4PipFHHKr1vHUYskMVrr3KhTwyc1nZYFAZKKqDqfMeg7ne0yqUFvDmxbZesi7hOHokOdjT2tUeRGPBH9rMfv8WKefyaf0jw123rWGYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(8936002)(70206006)(70586007)(4326008)(8676002)(5660300002)(40480700001)(82310400005)(40460700003)(2906002)(82740400003)(36860700001)(86362001)(356005)(81166007)(41300700001)(478600001)(54906003)(6916009)(316002)(186003)(336012)(47076005)(1076003)(426003)(83380400001)(26005)(6666004)(2616005)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:51.7641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acd8924-aded-4c81-c288-08da770c6f73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2596
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
Cc: stylon.wang@amd.com, David Galiffi <David.Galiffi@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

Fixed bracketing around condition statement.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 85ecd94e2a4a..3316c4a64901 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1386,9 +1386,9 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 	}
 
 	if (fast_validate ||
-			dc->debug.dml_disallow_alternate_prefetch_modes &&
+			(dc->debug.dml_disallow_alternate_prefetch_modes &&
 			(vlevel == context->bw_ctx.dml.soc.num_states ||
-				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported)) {
+				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported))) {
 		/*
 		 * If dml_disallow_alternate_prefetch_modes is false, then we have already
 		 * tried alternate prefetch modes during full validation.
-- 
2.25.1

