Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A8CCD128D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA8B9112536;
	Thu, 28 Mar 2024 19:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OeKs/que";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C75711252C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqgEJyBzoGTdK8EP8M9o9fjvWYdQlFyqGs0pcprZCUkWISy+OUamqPsnve66pTy6WCfQtvP324SLxD8o3KmOpzNTKMWfTjkSQutwZmeI6VJ7GAHOSRMYWdF3Tka1Z9d+8Z7czgwqaFfTYCnjoPcrp2g86xXUTk0ThzIeXXbVmWxhQ4rAtPJwL4FF9V1gkJrF9Lsr1V+L9ua5dnpRcNVJtwYL9vhMJsLexydG0U67Ag3PRF8LR0GDYwYCIEhncd5ybCFpQBs/mJVpyaKsaD7PEz39v4xRx5RYmcLRjwo0DPNYYqPOQhm+7U8ZEkq2v4u3OjVouYvwB+WokJj+mzuysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQI2R4GWP9sA+WV7hB3oIU/fL3/OBW+VCOoylktpV0Q=;
 b=krHwtuZ3GWKPnaR4m2hWku4ssSgxg7i+nj3xuRq9d5dYcrMujXPS9xbxyh/NXKjAJnsl+I7PQiT78usjBDyr1k4LXUR6wvz1n/G4clHYyMNrEJOLVJiKBqSIuurPLGj8gYlkfQkdws1cRHUvlG9smijvUjgyAAzl5YYu4baXUIqFzoBLcKNL1MSIRzmkVqZx7dlIVzyRz7lLL2f8TH7qTzAbqu0CmGblCrRUvaSci0N5X4KqifbK7An7Ok8fWQfsgvYvahOoVmDYiguoRclmhVrUNGR/LQKEAyyG8oo3c3PCwOF7hBicGzuZPN1owvqRcLuiaYm/O+jeJYCm0WGsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQI2R4GWP9sA+WV7hB3oIU/fL3/OBW+VCOoylktpV0Q=;
 b=OeKs/queFhYErjsSW5iCYoyPbQKsDKSaT6MhBWzaBRE6BFP56oCIpxO4vuBWCXw1xZerFekmfjYhBh+vBMc51qA0zxoNBbFODn1YDKlMaVAaYSZSHhEdp39oW69Rx58iwlN5EDhW2OkZaK2YYSCOtpFs1DcakA8VkxGPm1t7rZM=
Received: from SJ0PR13CA0239.namprd13.prod.outlook.com (2603:10b6:a03:2c1::34)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:52:15 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::3c) by SJ0PR13CA0239.outlook.office365.com
 (2603:10b6:a03:2c1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:09 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:08 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Eric Bernstein
 <eric.bernstein@amd.com>
Subject: [PATCH 38/43] drm/amd/display: Fix MPCC DTN logging
Date: Thu, 28 Mar 2024 15:50:42 -0400
Message-ID: <20240328195047.2843715-39-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: b03fd647-c6a0-4cdf-8461-08dc4f609109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNLAg0RSSZi8uWUtMaGgnW7ZQrQ2jQ8efEVFIoAXlSf1V0BZeh/MIe689sZndIWYEP8Fhd+GwVlpDm1tOvlMfI1jazctCJ00SeLmpKtvzpCMg4r3RSy/8YYIYtsP724yaD9DwrFF5cCpTRP8qmBTfmHk7ogRvLjPlEEU6/oK/TIZwZJGIqQzp3i9exvItMBphN9Xk4x1oZqvUAE2BCG+c6/QVNmFcZ+o+aVX81WKzIElaAZ5scJpfpaIoIZ3K2hzauAJ+TdVgQAe8QDNLQn1jIg6ZJAPfpVnWQ9ysXpVlSm8KAltkWf2wLfbwhUfvN5IOUzrKz1sZdnohQ6yDp24EiLbG3U7sWAGjOwvwIgZJJ9TDAaBrpOAICjw1Mi9O3ifK0glBzMy8j9dakmvdY2vmRC0FJyr+hij8OaTQUEXvHjqXA0klvdomgfCg3YYYsD82pb+YlNOwmUafJU/KQ7f1N1Fy5bLFtHbYC2UHRcP75sd5m7BphfNFn8ciZoMKpZuOjngCqjOGqdm/EXcWiY2s3oPLuz0TKjC46WSW0kxuxWR5uRubtvNcpmLcl4rb70CAqJJH5QFb29q8GwZYLqHTwZaqA+GLVA88aZaIGhIdWQc2FkBXo8mhwXnQ6ctV70BEy4l1p1nl0svw1Yf0+1pQf8tdjXXQmZIcAsBEPIW4HsF7yU9kXWA9Mhn7c4jw4o19BDQlRHU1Lvl488bBEyShMC+Rwx7+FVDjQsRfHYkipjYT9IKYPM3f7XmvzbLI6/f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:14.6355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03fd647-c6a0-4cdf-8461-08dc4f609109
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
DTN only logs 'pipe_count' instances of MPCC.
However in some cases there are different number of
MPCC than DPP (pipe_count).

[How]
Add mpcc_count parameter to resource_pool and set it
during pool construction and use it for DTN logging of
MPCC state.

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 9033b39e0e0c..c51b717e5622 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -392,7 +392,7 @@ static unsigned int dcn10_get_mpcc_states(struct dc *dc, char *pBuf, unsigned in
 	remaining_buffer -= chars_printed;
 	pBuf += chars_printed;
 
-	for (i = 0; i < pool->pipe_count; i++) {
+	for (i = 0; i < pool->mpcc_count; i++) {
 		struct mpcc_state s = {0};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
-- 
2.34.1

