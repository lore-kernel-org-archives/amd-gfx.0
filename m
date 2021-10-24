Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7850BC4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4480860724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4480860724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9FA6E11C;
	Sun, 24 Oct 2021 13:32:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C957D6E114
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkEQfgdJsc1ASqy9gujiwDBcTNna1JXhNiSsX/zrgsyuRU7jgEmOAme2BnjU6FqmsYAQdE8LpVCdtgZ8TGJG3zBWkVisu6jBeGK/SJYTpkbM+09VM3xAmb7lbVOCskldNFK9O0oh1fo+nvtORpZY2Dv7zXjmsewWcGAJS5/T/BsE2cgsimn5/QE8r3YnWZHoT5qxsuquV/tQTpLV5bzT0WmVhX5ROzsFwQF4vS1L8VbFRP2mQVbKMnelm2Vf/BxZj6UbdDoTQilpZh5Y/9Sd/EsZO4oRc+DufeKedFG9SWF7+PPNlngUNvgKaQ3NgqTyj4J1TjU/mxsi9Yga6lljSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdnjSRBgDvw9dPk5Nwqx7sEwLz1tBk6KbkNq5CWYoW0=;
 b=PPk8Mc699mZosTw0os0pNlEITcZ8IgAgERj/SMB0lKfQJjT/L6C5Pwx0HeHUcXXj4AXREv+zIAGhF/sF/S9ra5kWvsvnJYyMh7MeDNbQaNtxLKR1gmXub4oqdGYrmVr3Ia0Hy52n56Hdablm0yyD6YLkA/KsmmaD7HwTJ8hl6LLvDFNQfD0KA8Cp+ZgLhpRI9mfWGh+6bD9p5Jb38bKAMXHfnZznRG+/igPK8KuRmS3xZBiEEGy/yBTx0HO/5rqRCveVnQzfrrjot9YDa9iH3U+8qajgAlOZnYcYEo2hXmXjpDAC8leQ+0c/vwOaBxjai9ALM6fnb70tPcSWHFMhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdnjSRBgDvw9dPk5Nwqx7sEwLz1tBk6KbkNq5CWYoW0=;
 b=goHgMU0mMe7B4oZAUqdn9z1nOgRG+i2gB69LvTtkwv1VjWU25tLurv574pDSG60v1/BqeK5T50ap3SCec3JxnZLISDNMfXBEiOVpSev32GQ6l3DUnL7nO/C0EBKlmFp5GWd0SYGnIXhEPGPJpSfKbwCrTvSlElT9dcoQEXWx10c=
Received: from MWHPR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:301:4b::31) by BN8PR12MB4593.namprd12.prod.outlook.com
 (2603:10b6:408:aa::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:32 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::af) by MWHPR1401CA0021.outlook.office365.com
 (2603:10b6:301:4b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:31 +0000
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
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:31 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 17/33] drm/amd/display: Fix 3DLUT skipped programming
Date: Sun, 24 Oct 2021 09:31:25 -0400
Message-ID: <20211024133141.239861-18-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 531a53d8-145b-40d4-b217-08d996f2bb2f
X-MS-TrafficTypeDiagnostic: BN8PR12MB4593:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4593DF0DF94B379AE39CFE9C98829@BN8PR12MB4593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrmuTj1q3rpUZaQSqe7EQVZfMtJwIYtqmliaLfwiAPK2+OUaEX+MgB8HOuQhNyz7MoaQi5W00W1yJTPHIbOlT4857op0H36KD1Dx06Fh9p56NdZFjKfDUxyY5Ttl3TcGs+MODpfFIHZurTNdLAUgzrtzn6FfEWwU+LkqzmXVgocjYvnJoyX7vVWjpCiX+xUzfNnlNh30qlyXjTTinpy/8KFg0/wDC4x7mFog/mntBwJmHKjUazeEW4wmY8MbYvLBZRG7lm56Zx0UMRpVkfQyPFmV/QVpTUQAybiY3HsXCKY25KQcFH25nTf7jBXBYSAJZ7AGz31tImiOYfNu5Kr+NNwnddQzCYBABasNyQKchf6zxbpZnyeoPyK84luCY3Fw+zlixGHy5jz+yQzBuahoURKe3NrccNrlx5i/287Gi+5M+LPhpTE8N/k0AtGRUPlgZOlSmJtXjOgZjL9aUPDU7bc0K3vpp6qsbTGCqQFWgrk9LQ2NkMZtQ+UjzijfNOOGbCb7uyohMeAQy/wrtvY2zjYtQ2f/zContGk86IcIxGGr/jULI/UExKFv7oHG6ueDjoOJtHQDxZqkcGi/IDZByzIXqYNUu5JRWCj7tw3jxj23QjO+Yl9kKHsKXhq/U2YxjM0lDShvuEZNJAHnuQWTwyLpDqIn7v9Rz/1xvfGnDaGqfFS5T7qpWodXNsRsfKeFUcCDnhDYCLwL+jxoT1/0pbFL+QBjy4Daoo+svQTGwcU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(36756003)(26005)(36860700001)(356005)(16526019)(316002)(186003)(83380400001)(4326008)(70586007)(70206006)(5660300002)(1076003)(47076005)(86362001)(508600001)(426003)(82310400003)(2616005)(336012)(6916009)(8936002)(8676002)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:31.4164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531a53d8-145b-40d4-b217-08d996f2bb2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4593
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

From: Aric Cyr <aric.cyr@amd.com>

This reverts commit 3ae5ca4b92a5c230c3fe25956996ae4bf1875422.

We found a compilation error that we thought was caused by the 3DLUT
patch; later on, we figured out the root cause of the problem, but we
already applied the revert in the wrong patch. This commit brings it
back  the 3DLUT fix.

Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6dbcb1b1eb5c..6d33ff2bbebe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2285,6 +2285,9 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 			update_flags->bits.gamma_change = 1;
 	}
 
+	if (u->lut3d_func || u->func_shaper)
+		update_flags->bits.lut_3d = 1;
+
 	if (u->hdr_mult.value)
 		if (u->hdr_mult.value != u->surface->hdr_mult.value) {
 			update_flags->bits.hdr_mult = 1;
@@ -2298,6 +2301,7 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 
 	if (update_flags->bits.input_csc_change
 			|| update_flags->bits.coeff_reduction_change
+			|| update_flags->bits.lut_3d
 			|| update_flags->bits.gamma_change
 			|| update_flags->bits.gamut_remap_change) {
 		type = UPDATE_TYPE_FULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4cd04a78f926..1225406d3381 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -940,6 +940,7 @@ union surface_update_flags {
 		uint32_t bandwidth_change:1;
 		uint32_t clock_change:1;
 		uint32_t stereo_format_change:1;
+		uint32_t lut_3d:1;
 		uint32_t full_update:1;
 	} bits;
 
-- 
2.25.1

