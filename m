Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68B3ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 555B510E7F9;
	Wed, 14 Sep 2022 03:34:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B44B10E7F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPubCcCdhhwTHVNo2QIivohQ9QuLAjPoVHtTq/EZYMmLm+0nwkuI5MhQXo3p4Rm52B6V6At5rCSCjPsRXU55TlXNZ0U/xd0CTt7ooCuacsaOnCahHbbKUPnOcCO5Y5GLVlI+AvRNqlDO9gz1tONyYXJOC2+8flGoKCvwTfp6oJDWRN5aRzjLQw7JmB9Fgw9c/gkHdiw9MkDzt2GBW/owJ9jGKe4oJnavOIbTB9zuGIwdTmcInH6wPoFM2H+eUKxBA+UjfjWCQDZRc9jlaHOzMvYuVpKrp7toRt/kozMOXaHdlZfMkhQkW4HbVv3x+uwTZgpCiffxSMj3zELyhi6Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imNo3zM/gwrUIf9cLgfhPV2Dr1ioekFYOCt5TEUgt5c=;
 b=VQvNMph2QH+kac0mrs7g1sh1QZdUEE3Kf1gW8ZyvktHCKd9TgXCSCQPMzyFX+q5n8IrhTNZdZDjJ6eQkIH38/KVADmFTI9FY4UKmxAeiA1ur9nTxclcNup/PW+Qj3dyJoMmGGxw+VEZ59UcgP/oL9mzWylyj23j78UjvksSMif1GM3v94eDvQGlNH5R2uJ/nFLVW7xpCgn5WCNPgniQ3rbm3U4V9sKXa2uNpWhIwBHzNWw90Mit1B8CDap3CAKQtNrBK4Osqt2FTGODl/kBeABH/Sh/sJ529/N/7U9bFM4MbuVSW8ET3q2cDxZblWAcpRkTkFe+/RgQUmKpi1KUZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imNo3zM/gwrUIf9cLgfhPV2Dr1ioekFYOCt5TEUgt5c=;
 b=OqLeOQibNhfVSo3Q1IiX6FDuKMNeg+Y1oa9ItXFQXVxHUYx9N2Wz+QuR1xy/WCT7Z1pNbsJPsjhVQ9GSQLFCU/ljJbQnG2k4OdZX6a9pLaMJggvWCGp31xQPm36baDnfcoOXJoKckoFufEELiGFMkOs4qQ6OmhTwCiDnmwgFySk=
Received: from BN8PR15CA0043.namprd15.prod.outlook.com (2603:10b6:408:80::20)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:33:59 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::2e) by BN8PR15CA0043.outlook.office365.com
 (2603:10b6:408:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:33:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:33:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:33:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:33:58 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:33:48 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/47] drm/amd/display: Removing 2 phys
Date: Wed, 14 Sep 2022 11:24:20 +0800
Message-ID: <20220914032441.1075031-27-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e32583-b872-47c4-84d7-08da9601f605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpJR1LBDqeEctYi1lLRVLLCxGrRsJAvk+er2vqpWWcMr/cvt2NEpL/PeYyuFnHRIW71k6h90PopEv/Kc53nTrbqFSnv9DYcdBoSIwP4BcN4yML8WQwYthn72poIOW62Ol9BbBwBOKzKbmKFapUKbpbSsGbnPt9kE2z0VGG/HgJxPtIVQVWAYxDHboNvM4Ayp0BcHMsIsYrFQtZiPa7I2Gmpt6t6nzOTkNn6BRoVrhKlPElLDll3Vp0x5EwNsCYzBWhNete2bv7LFBSu8AmXNt5+inuLnahU676TEC6gmTGkYHYLYfz1HO/PU+m/PLMRfyEoswrRXpf7PIRU6RRrCiYJfrCh6oOhJpe4bo6kN+xiTzamVu6j3ie5dV1eT9CevU/L15ftEUF05boBO/6aevaT16tbaRtpE3MAovGlMIfaLto3SagmclmBZWT6XpsgTidAvtVBeMIN4Y53EztL7xwR+v5pSmRINqIp1AqPkGo14GWMHHIJH7M7hIY/Cgenf8ENgwNyelx6sVN9lalnp+iDylrO5MmEFSvnCWNTI4rNQsYeRUiU/kngI2wfq7hyW0xLwlsXuk9ayEewry0mK5fDl4ALf9c4MdQmNv0Bapun/andpeSTRDgPixamvYiTZnfVYcVI+RijyUaQ3BH73YJCsaOhYJQXjNRB+pNN7E7gck2ZVk0MQNJ7jWTrudiGc0TxKKUGnnBdQRfhX3MzSYYQ/44w3w95gnk2GPNBqypB+21PmAL1pNqwU8FQJpZsKercpGAx12rRwJ+95ZiwvmJxsruWBdOgAyFewBmMrpLs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(41300700001)(7696005)(478600001)(54906003)(6916009)(316002)(82310400005)(86362001)(83380400001)(36860700001)(356005)(81166007)(26005)(2616005)(82740400003)(426003)(47076005)(1076003)(186003)(336012)(36756003)(2906002)(40480700001)(4326008)(8676002)(70586007)(70206006)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:33:59.2255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e32583-b872-47c4-84d7-08da9601f605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pavle Kotarac <Pavle.Kotarac@amd.com>

[WHY]
New dcn301 has 2 less phys

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index db172677d613..0c2b15a0f3a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -634,7 +634,7 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
-static const struct resource_caps res_cap_dcn301 = {
+static struct resource_caps res_cap_dcn301 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
 	.num_video_plane = 4,
@@ -1429,6 +1429,8 @@ static bool dcn301_resource_construct(
 
 	ctx->dc_bios->regs = &bios_regs;
 
+	if (dc->ctx->asic_id.chip_id == DEVICE_ID_VGH_1435)
+		res_cap_dcn301.num_pll = 2;
 	pool->base.res_cap = &res_cap_dcn301;
 
 	pool->base.funcs = &dcn301_res_pool_funcs;
-- 
2.37.3

