Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235F1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB18960F38
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB18960F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA1C6E8A4;
	Wed, 27 Oct 2021 14:26:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0036E8A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 14:26:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS8jwaoAepFDhLOE+SPqgqVWOy4xdG/5KuxVKAkiPQuNoZKyC4VmA8I0Ex33HhX+0c7mZvj15jlOJG6n1/i8v1KlSpd5FBFkllDyAHmkmKGVWTZsYrASqSX4hqpatamMesMrQN6y7kB1/q4pJiuwJftn6mqKNDkNPK/yXJshwlrmncqdAVCzDYXx81fedyWfw9Y9Q1jAjyY0djp8ZXKepQDc3g/aSaB75iRvCaxgmzXM0xiQzugMwAuJRq0XMEV2UBV/3qQ/fTFtJHxBuIhI9DbWiuw7TMS6KiR11mrw2n5QO/YsNSAKulsI9ja7FAWZaBJ7h83jLagSmksmgfnSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrFwTP4U61CsmVulGKlzJuCZOYYkA+sr2h8ByNAMcAs=;
 b=gFB3U3gMH8SkUNoSRdbaZDh2g+FgKqcomGuOc85hYQMDCLlxPCo0/0A7MIBYcyppWnAjPwQUmEwQ+yqRmOwPQwgkPdE6G0lwxgzESrcs8+kESsdpZ81+2gj3bOt4Nse9ls/QOrHgNDYVQ/4zMUsCLZW6U8E2yrU5PYjtXoQLZYrifvR7pFHzLKm3imSviXwc+bM2hvaDjiJGFE6ZNB5AXrYT9Kxmuejm7dMfv2LD1cgnBqczjcr2pA2SAvpdwyHqKg0ezXYGF6hLP9PGWx1eQ/J7JuVABqYPfwqD4YG3OgSLjGCaHA4HEXDiRcu2LwiUH1BIcGO7oqbIu1fkVIEMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrFwTP4U61CsmVulGKlzJuCZOYYkA+sr2h8ByNAMcAs=;
 b=3GTrpMdF+FrZIqwDjQH3reERXEh2DVwLfaQOw7iisMcOnzT01xKCy+AQSFxLkxqNA0BnvYKNemwAAgpin/IIpZ0gMDx8cBIGPSquxx/jAc/7UzXLU2PpeVitLIsXJFG4g5whTIlWrSLfsQjUD3XO1GjRtGSfmEjx9ZXLLFnpeuw=
Received: from BN7PR06CA0071.namprd06.prod.outlook.com (2603:10b6:408:34::48)
 by MWHPR1201MB0077.namprd12.prod.outlook.com (2603:10b6:301:55::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Wed, 27 Oct
 2021 14:26:44 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::b8) by BN7PR06CA0071.outlook.office365.com
 (2603:10b6:408:34::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Wed, 27 Oct 2021 14:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 14:26:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 09:26:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 09:26:42 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Wed, 27 Oct 2021 09:26:42 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <rodrigo.siqueira@amd.com>, <patrik.r.jakobsson@gmail.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 3/3] drm/amd/display: Fix dp_max_bpc out of bounds write
Date: Wed, 27 Oct 2021 10:26:35 -0400
Message-ID: <20211027142635.9459-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211027142635.9459-1-harry.wentland@amd.com>
References: <20211027142635.9459-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 828a79ce-adef-4f31-160f-08d99955cd0a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0077:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0077A732B86B007BF8E5A3458C859@MWHPR1201MB0077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhtKoHawE85fIS1f+6IRwKoefH6adALcD+jv44cyApS9nMnuyG593tDhlBUHtEA5A2nmwC82vfTWdwbhaLwjpGtC/jsGAiBkM1kKqU3RGWWazV9ACx6n7cUdAzTkUjYS+UkMdth+qOV90HeoZhBSKxyVjXMkZX7zDgwVBRPRascGDoy1xI7oYimpHLR8yyLWVNZ51L5jP8oAwwkUQIdvdFMv7imQg6l0Goj2p7H79hhEL+ezvoUnLiTVvAsXiku1QOvYcvADAnuJMcy24lxmdjJCWPtY3RnPIOXhly4pd7dsytgXQxf5JcSjUZcKGTD13f83q8HQklvPxxP/LjsvRaAqBjKln7Gvw7GV9hhI3LlUaM0DlQP6kl4lINVV2HKr+BSTsE37CjVHOWNp8Zfx5oSkSp02E+0ZvzRM8pgxYrnZvlqW1LfOcveYDeQNe9jLYWnKIyJY1b1g4ecCRF072XnCN4sDI2mTmvcQcOE42kf/SbH1ehFSteu1Tfdqc2dnipoIyBkCkhXAMk3RqZkSZcQHFuW775rkuw7HIMOyDBngG4XuYSJd7P0tpcCvSUotpat/jZppfglPZz3jiATBOwaI3W9Z4U3gckyvk0I40X8tu3A3ppgz0o00BfxOlM292Hj4mW0kOyCffMMGNwL3lCbKxGweexrxejp2vkll5KLdHCl+ICoBVe0brJ444VV6/olg0NRcHDspaDCz0xt53qMMtevjEHEDW9woF+M8tFw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(4744005)(82310400003)(6666004)(70206006)(356005)(2906002)(110136005)(36860700001)(426003)(86362001)(83380400001)(81166007)(508600001)(26005)(47076005)(8676002)(36756003)(1076003)(8936002)(5660300002)(44832011)(336012)(4326008)(70586007)(316002)(7696005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 14:26:44.0476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828a79ce-adef-4f31-160f-08d99955cd0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0077
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

Fixes one more possible out of bounds write in
amdgpu_dm_debugfs.c.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index be8ff7a05030..9d43ecb1f692 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2384,7 +2384,7 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
 		return -ENOSPC;
 	}
 
-	if (parse_write_buffer_into_params(wr_buf, size,
+	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
 					   (long *)param, buf,
 					   max_param_num,
 					   &param_nums)) {
-- 
2.33.0

