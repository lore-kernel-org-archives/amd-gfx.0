Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAA5C54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 18:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8721B1122E6;
	Fri, 22 Mar 2024 18:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VzU2XF+f";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4BD1122E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 18:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7ZNtu95q2wPsnLdruBnHO67gCx8Zwy4FmgLABQ27EsxSx2AW+eO7Wpl6zwZTnzw5iBnQspQ7+H4xjzW3HYEHpPT8jEs688F9oSWD85EiiVGeYiTEdDmt30g96f1IUtdiMt1Tk2KTsicWbhC3gaNh2f9fdHLOMaR0P0s3w95hd9GfPMfgv+viJHIt2rIOnylLatxmjb9rcrOULjfJeBaAx+ohbVhuO4xyI1hxI60DO4awv/0fK21trm+u4KNAcq3oVq+GbeLWV4313iQbpKiVtskQJi80IEUPyIbj/YAe3+KQW8ZikKhz9K/7xDHhdtiqXr+UtqjAAcO7XMev2yxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skeyMYHyxtf2UFwvdIKpQvO+QT/1C393sC1gvZ/Q+KY=;
 b=KET0oOZSKvA3opAjANFCqgdJVFFaoxAVsdt9/sucR+Cb09UItnUnzs+CnMLcTDb8VgXdgeMLPNvrI/O1GKOKf5zeUWvMpmMsaYAQmuGxVQgQw8Dy0ofEDkmMiyjONOr1tUcxpWw2zZwZvEU+pLxYXegJPTXKm4cOZH+hbPDjhgOe2p6jTpcbcUa7U9JIkuICsh9W3VBkSk7Y6cbOEOIie520hI97UJD4ZcOzid8XN2IkbavgJm0aCN6QRZoSxCpilsQjsDpMWkWr3BYfCjbRGptb3erPFLJhQruxLB/v8X8d/3nxZYJntHbydVhVzk+sdJUQZXMxsKXxsw90rPt6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skeyMYHyxtf2UFwvdIKpQvO+QT/1C393sC1gvZ/Q+KY=;
 b=VzU2XF+fw7+0mQsPrPwFdSN8EbobT3VSzaGAeKANRDNT13s1vTo+ELqV72XC7wepyWLinuIXsF95a/ktrIS9e1mGxFOCNpuGbLm7gOwu/TrZD/X/Y4cwqYVqfKJOR917iMb+BBXvliMf+zf+OPUfZDhhRUnccIkIsLxulUvJmLI=
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 18:56:36 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::a6) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 18:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 18:56:35 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 13:56:34 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Roman Li
 <roman.li@amd.com>, Leo Li <sunpeng.li@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, "Mark
 Broadworth" <mark.broadworth@amd.com>
Subject: [PATCH] drm/amd/display: fix IPX enablement
Date: Fri, 22 Mar 2024 14:56:20 -0400
Message-ID: <20240322185620.17217-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab86dd3-975f-4782-4966-08dc4aa1cc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SbTfCdXBFgKQprXUoUqdhLv+9U7M9KWz0zbZpEND1U4wo5nSmMjWX3XUsx0Y73a91z/5X3VLAM6V6IwKdh5hQeK2BEwUoDc2Aql4oJYHRdPkcJXmSW6Zt4oheCkWnlrSTVRAZunp1aqdnXckn9GYLWtzReCncudUlYZhqwWyW5sDzDuz4hKkjA7ZI228OQb2OAMOuQlC7rx8t1uQJN5ksQLkVYXu16WxyZpFdzQYs8i90YAlEa552JPBQzob49RqtfZ4zaYtIf9sI++uI0obZf+Ie/p11BAQRXoQeRegBzxjLGFIvvAyOt6r5KEpj287ZMnD76MZK7SxXLgzr+S4iTB0XzKNNL4UjNp51/iYR4irDgcOnN6vWV8keaVTZiyt0JQuBgWadFsR1PDiLB9LXi1nc4DuqzJZTSjYqaCq1F6sqsMpPeI1Q30YNQjC5XToTgiY6Bfqyseo/1iYPShx5b9PsyavyEl0Q9HTHi7v2UDxZa6EZFMff+dyZWN8f4HN5k53ONF74yJONJMee0bTgi0Bwhwp0tnWPAo8/nXcN7itfHXtOjY6v4MhcX8ERVkfBdHjaE0lZMnOeHENXS07/RthA9tqP4ENKDV8oQEgsm94dcHrhjdX6vj2KsQtRyCKNif/Lh3x1NR/1JtD9FhT2z3aVdM1fC5tUTHmcDNHjQKJHDQj/+D6gFo59Oy6R4F1OHYk5VJ/R8T2jAw25TW1ZAlM3vxKdnFV5eCBEuMyFPbsXfFNfC/hRFON5Z42g+v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 18:56:35.9627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab86dd3-975f-4782-4966-08dc4aa1cc9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273
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

We need to re-enable idle power optimizations after entering PSR. Since,
we get kicked out of idle power optimizations before entering PSR
(entering PSR requires us to write to DCN registers, which isn't allowed
while we are in IPS).

Fixes: bfe4f0b0e717 ("drm/amd/display: Add more checks for exiting idle in DC")
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 +++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index a48a79e84e82..bfa090432ce2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -141,9 +141,8 @@ bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
  * amdgpu_dm_psr_enable() - enable psr f/w
  * @stream: stream state
  *
- * Return: true if success
  */
-bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
+void amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 {
 	struct dc_link *link = stream->link;
 	unsigned int vsync_rate_hz = 0;
@@ -190,7 +189,10 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
 		power_opt |= psr_power_opt_z10_static_screen;
 
-	return dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
+	dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
+
+	if (link->ctx->dc->caps.ips_support)
+		dc_allow_idle_optimizations(link->ctx->dc, true);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 6806b3c9c84b..1fdfd183c0d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -32,7 +32,7 @@
 #define AMDGPU_DM_PSR_ENTRY_DELAY 5
 
 void amdgpu_dm_set_psr_caps(struct dc_link *link);
-bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
+void amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
 bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
 bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
-- 
2.44.0

