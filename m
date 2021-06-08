Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E942C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB5F61263
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB5F61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E8F6EC25;
	Tue,  8 Jun 2021 15:37:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824946EC22
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Olt+zL4EirMSueI4G7k1qhmAmZ5um4FWp/yzEVS4lC0h5P3+tOupyEsb7GYd58DjR/I5J7sFTegI/co7zp2rdo4LSva352apdVJ134SgUhm/71N8OeGuYf/7uSWR4H77Z5XGspEZ0imiaTFppV751QooAszUb0tBIX6afgneMtEiQIEFlVOx+KFSef3XsEIMzhMk3hvCMuCYu0U6q8wWDgFR/qJi3clj78nXhQi+4lnViXkdRukPXTlhyuVzLvXL9+AQ6rYlcXAftIURvKHuGYK6YhrF695UqO5cHdk3/07XoR+hwn6nLqM2FgmzfA0H5V+LLUGjrAF+0ZX6BXS/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ1t3u0P2gYVFetaMbSIhYzDOEDxc0BH6yM+6nfcwww=;
 b=eZ+fuv1QY1uP/C2whUE38eWGD7Bcbs73XPpWv0XdGQAf2hAoQFDCXn5+qrvzO0cypXubzN4+az+OrmfNIJbVori39BEY3i6HBiE14vaugVWlvp68GVev+G/PHlDTSFnJHDSH8agLw6fUJD+sLVWGtrkuMdJG7vYdaj4mA0QdDmKn6bFpmiY1OxbtkixpeBb+VX3gjU0tNk7KIqDpxQQ3sUoMlJFq5aUTX7gNQfel5qQ30CDYHpDpFBn9sJPDkjNlgkFiU7CoejjNYpFbomZohh7TjfeSzY+uT+E8YzjMIjqw0B8kSh8cr2n/TP1HOFW3VfhIkk0B/dyDZiQ+On7Umw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ1t3u0P2gYVFetaMbSIhYzDOEDxc0BH6yM+6nfcwww=;
 b=RDEk/86x4kjdgoR2vseNUxSok3WHR+rbDlMdcoZHlD2Hu5SOJwVyGT2JP3GA4mpvyL5d3csKQApcvQth87FQvHbWRf0ftCRH66mlkD/VnGsFzNUsPnjRM5o6BAcg8MkUznbm6R2iACQW3IhWoTsZGeLjyUw4Mnsmb2B9usxA/do=
Received: from CO2PR04CA0092.namprd04.prod.outlook.com (2603:10b6:104:6::18)
 by BN8PR12MB3219.namprd12.prod.outlook.com (2603:10b6:408:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Tue, 8 Jun
 2021 15:37:02 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::eb) by CO2PR04CA0092.outlook.office365.com
 (2603:10b6:104:6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 15:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 15:37:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 10:37:00 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 8 Jun 2021 10:36:59 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix build break
Date: Tue, 8 Jun 2021 11:36:45 -0400
Message-ID: <20210608153645.796143-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ad764b2-699b-4dd6-ac25-08d92a93428f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3219:
X-Microsoft-Antispam-PRVS: <BN8PR12MB32193668607BCBCA6B771D0EEB379@BN8PR12MB3219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcV5n59pRijm4o0xiWzukWEFBK55qOGnXt7RPPdIyAL3iwmTSSFu5ihENNmAABL+tA7oWR6X4BF3dkUClm7uFuW4m32Les5KcQfWh2hZjQQ5GTAbOba7UcyqkurPYrVyiv7xXvX0mTxMLdM76FRB3pNZ5rZ5lxEM0sTPAfXn5YTPoJ3IWcdvnbN1JXEUcBqazyF+DLSLzgrLpTtt4RMH5JI3Ji1IvvvP/fNZswuBVxqpelhUqSh2pmfbdMNhZwPxF+LUQt+0C1Fki1fahy1NeGTqwXYDvjo7BfiOirfJLlJoKyqtejNYBftaeOj6CNmeUyb0dwXOnYieo3n3tyOFzwewDoBI2pco0yl3k/FbksQzaMmcCEWJHZcNb3HqVzrOJ/8xY1Na4uQUXLAUtqCJphtq24SYzX8EItstRNSuqO/JPLMmYr6QOL9JOHnzqEZs2Sd8t0hNC99NDTC5VckX0YAorzy/594npy25itkZVTDEXHELi+GIn7escW3RKuc0tmkd/yL0oE5RTjKsc3XXQpvIr8Kjfx+BW/qkXvpSGKOWyKl53mBQzmtXff8yMDG3/yje7eYVu0Dig5Jz0NZaqyXcLShdo+JkenrtghFbHrjUmEN61vRX+t1+wqxX5NqCk+yL5mzhNuIXK/Go1fpsmTqZAH5qo9zxq0oVvIkLQsG0/0KdoGVz2EIIl/qiR4/b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(82310400003)(83380400001)(1076003)(82740400003)(81166007)(356005)(36756003)(54906003)(36860700001)(6666004)(8936002)(6916009)(86362001)(186003)(4326008)(8676002)(316002)(70586007)(70206006)(336012)(7696005)(2906002)(5660300002)(426003)(2616005)(47076005)(26005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:37:01.3334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad764b2-699b-4dd6-ac25-08d92a93428f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3219
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Remove duplicate OTG_PIXEL_RATE_CNTL from dccg_registers
2. Fixes: 18827ee0cc28 ("drm/amd/display: Refactor visual confirm")

Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h | 1 -
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 6bdab06667c9..62904d7ca100 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -202,7 +202,6 @@ struct dccg_registers {
 #if defined(CONFIG_DRM_AMD_DC_DCN3_1)
 	uint32_t PHYDSYMCLK_CLOCK_CNTL;
 	uint32_t PHYESYMCLK_CLOCK_CNTL;
-	uint32_t OTG_PIXEL_RATE_CNTL[MAX_PIPES];
 	uint32_t DTBCLK_DTO_MODULO[MAX_PIPES];
 	uint32_t DTBCLK_DTO_PHASE[MAX_PIPES];
 	uint32_t DCCG_AUDIO_DTBCLK_DTO_MODULO;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 69da1493b277..e3048f8827d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -100,6 +100,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.z10_restore = dcn31_z10_restore,
 	.is_abm_supported = dcn31_is_abm_supported,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
@@ -129,8 +130,6 @@ static const struct hwseq_private_funcs dcn31_private_funcs = {
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
 	.update_odm = dcn20_update_odm,
 	.dsc_pg_control = dcn31_dsc_pg_control,
-	.get_surface_visual_confirm_color = dcn10_get_surface_visual_confirm_color,
-	.get_hdr_visual_confirm_color = dcn10_get_hdr_visual_confirm_color,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
