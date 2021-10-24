Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03BBC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832A8600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 832A8600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3FF26E147;
	Sun, 24 Oct 2021 13:32:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A40B6E134
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGMC4y5ddRxwrbdW8I2o24w+sVIPxGXdn809cOypuoAh9yn7v5MQCcaeNx7liRuTLH9yJLzhI3QwzQNl8vqMTBHokS5lkWIwN7D6YXIbT4SE8agiAkJjGEhcRu4RjZC1Tc1w8JwviTYQn9qNnYY9tUV0/oFqYwtyKRo88QQ06PAF/Da+F4SrXAgSd9AXqV4H4PW45onMQs3nmfvgxTrNDqYurnK4ppf4KZwVPq+trQiQ91WCqG8bMOXfeeE8ZwMaviMdI2IkXIzsObHcroI6axJhr8gioaKBacPyFDfV8vvm0puygV/Q/AdUfzo+1U6npDAsJZ/Gs6CZ8j+Saa/pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7Q4KmP63BtaCywOo2LPwuqbA0h5DwGx15IljZsGCdg=;
 b=RH08U1MES7M2plXv9nEEdnlb2s3t3zRzL4IyJAU1rZok1DqK5WMklx8pCu7dVy5paCX92xJ3C1YNMA80Un5ElRj5Nj6vdFPfAShdhuqoUxLj/IFUy9gnH6Y9herJSiaZlNr+PvSWSFw1CJK+a6+ZMtJgS+tP893TeL/tpKSixI5b/VF4GhuSuepzdJdGtAvkcZwRHAaNVTD5XHtVRLKa+a/r/7txQUhkfHANwMJjEa2TSh0E4eKluB8bIllUseCeFqn2YoA+KmkGT5SdWO+Hw6FjbNMgat2dmMr5uQ6WX/6kdieIHIcRycDX4ANEsEQ2OXwPJ8F/8NAA0nnHAJZDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7Q4KmP63BtaCywOo2LPwuqbA0h5DwGx15IljZsGCdg=;
 b=AsWKuc9wTAm8wbZoG7Cl2NYMQXciPlUygXBso3YFI/WLpAbqDsudwhIRkK7vQ9EzfeV2ka3Dz1trRxcC8AB759FCiM651nZqu0aXLp16jIpeMX02W385QCsRymfzYjWlVPJEQ0e00GDtOeuhHnFZ08S+QOF8sblu9VDsv9OmDR8=
Received: from MWHPR1401CA0002.namprd14.prod.outlook.com
 (2603:10b6:301:4b::12) by MWHPR12MB1774.namprd12.prod.outlook.com
 (2603:10b6:300:112::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:33 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::67) by MWHPR1401CA0002.outlook.office365.com
 (2603:10b6:301:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:32 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:30 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>
Subject: [PATCH 20/33] drm/amd/display: Remove unused macros
Date: Sun, 24 Oct 2021 09:31:28 -0400
Message-ID: <20211024133141.239861-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b8ea084-6809-4ce5-f715-08d996f2bbf3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1774:
X-Microsoft-Antispam-PRVS: <MWHPR12MB17748251E0CD8A470CC646B398829@MWHPR12MB1774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHlIkgheUJX6LNwKn/wjJhKv89xXEzNK2dsb1O0+GkwZ0sAcHFUQRCFHmfU/SUx4Q2Jk5zuY9hhqbxNxUB/fHM/5YJiohLJnEQZqvysFQeDcPaNvWj718xEYfahZzXnebufnScYyTVKJFzwCQl7QkAAXdK1uPqYjt0XF/UdJSowhfDiv6AlZaSNQeZkImGcb+WEJ0EshP1+hSHbtYasvv7hcS8NDFoFmawT/McsHW25+jYN7oJ8ysr5fZ+fLPU6pazaIPr1mNLD0PPNNAOuyDiuuQc3qwbxoAg5RAAm9VMmyOM57RfGG9riPokmLbNlzqLCSHDofUcFoFU857Uw7G0DO40G6qHG7NLilsIs8TaOGBaODHQmfV4U8XR5AoCbHWDGD4U3bUhEOPZQc0kTuvyUcvwWZCt1dT6QsTbQBknxlUDoITerm1PbjIvBogtr0+APvyTGWbX3Bi7k8oPYejA0cnQM4yy49ouJo/0danngEUC8XGl0VdbErSVvdw96ucn1zQQou1g++FSBiokMFN+1YodTwDVbLxIEwqi4PJINHIkRaBzU8B1bQcgI1LRfRXHBlPopoxe7bWD9gRXY8DxVnOMTGhkBViZ475wGcjc3BGGkhPf/QbH+oVzBM+6kWJlgAXaGcsuxMldKKU6TTFcQI7QJmMVDLKpMrXdN2lcar8dlcOumL469kWFUJZLyni06EXVXO2jsVo2RyaWdzgIooGngz+VG2Scuz3F+diDY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(70586007)(16526019)(83380400001)(6916009)(36860700001)(186003)(8936002)(81166007)(4326008)(26005)(336012)(5660300002)(426003)(356005)(2906002)(70206006)(2616005)(316002)(86362001)(8676002)(508600001)(36756003)(82310400003)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:32.5917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ea084-6809-4ce5-f715-08d996f2bbf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1774
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anson Jacob <Anson.Jacob@amd.com>

fixed16_to_double & fixed16_to_double_to_cpu are not used.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 ---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 3 ---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 001737487800..3883f918b3bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3660,9 +3660,6 @@ static enum dml_project get_dml_project_version(uint32_t hw_internal_rev)
 	return DML_PROJECT_NAVI10v2;
 }
 
-#define fixed16_to_double(x) (((double) x) / ((double) (1 << 16)))
-#define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
-
 static bool init_soc_bounding_box(struct dc *dc,
 				  struct dcn20_resource_pool *pool)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 6d70ccb108af..6dda20f3741c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1707,9 +1707,6 @@ bool dcn30_release_post_bldn_3dlut(
 	return ret;
 }
 
-#define fixed16_to_double(x) (((double) x) / ((double) (1 << 16)))
-#define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
-
 static bool is_soc_bounding_box_valid(struct dc *dc)
 {
 	uint32_t hw_internal_rev = dc->ctx->asic_id.hw_internal_rev;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 2de731e3e639..6d8a5ffce1d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -101,8 +101,6 @@
 #include "link_enc_cfg.h"
 
 #define DC_LOGGER_INIT(logger)
-#define fixed16_to_double(x) (((double) x) / ((double) (1 << 16)))
-#define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
 
 #define DCN3_1_DEFAULT_DET_SIZE 384
 
-- 
2.25.1

