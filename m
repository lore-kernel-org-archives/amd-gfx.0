Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A4CCD1292
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31DC7112546;
	Thu, 28 Mar 2024 19:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i7lR4ykh";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7AC112339
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaoQljMX+WYKvo0gwg0a7AQ0yhm+SNjThes5ZrasCVYmnx7JuFpyQ3Ujh0enE2lJJV2pWqLZa+h4ovcq0ox5DF6gWZ/bk4mObfOFAbMY8HjNTtHPhQgr1dT5zCMfDp8RE+dU7EHDvHhAb5Hsem22UxvNptiA5CgEkWm/qKne/i8pQxRT5dKNfJM8i+IBJuFzkpuYSAb9RRdnMAPtF8YlgHH+4eEFQZNTlU5KN7EUhXPfwbSms3SYps5wg30QHgLfvxRM7p0K4YpvLmHprCVuedkxQ2lBOQ5HSarh+833qmttpV/7Mhjnu39ukdforo8jAjGljEJW9c11Uh44XNqthQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2qryrjr9V+fAQYPXc3ERWBfAos0OuFNBPhG2/6Owps=;
 b=AIDyhgojUckfjhAcHK4oYmv4Pgq19VlpW9Gj4uvIGxhy5TQrO8UK5a3ptd/ncQTuGv9nN6EgLCr+bUIsQCGAQlpoRJR8hsf28DCmg48EsA7xku0aEkBRimmkM6NgU2rdAyB6glyN551d/fzetEAOteZ8yqUOmU2nYg4AspU/b+fSU8hf1016bFfdZ/Zmy0jMUneSs1qlZZ/k9p9TtYT+I9B/l7Yarq8fcwpgJGC3Xqm8tp61dBtbZQMNCViPHprQoSQ0JaYHWFyBMblpq0Nd8Jl4OZ0IhA7UQQa1EVAMZb5L2UoQbePTIHlPkbteYGzV/kKeZt8T5IBD4UKlYUzLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2qryrjr9V+fAQYPXc3ERWBfAos0OuFNBPhG2/6Owps=;
 b=i7lR4ykhBSDiYsNmeqxZQrbCQN+iqZfUfj5c94pJ4RnqPFY+k01HurWticdvK6bae4bZJL7JLDRwcVVrb9uwP81i3c3Fos4uyQ5Z89X0rF5LwfkRL4wy+pdZ1xhtjej+q3KykZZsNxWGoSlCKtzuEAfTBMx018VB6nCxBHgP+fI=
Received: from SJ0PR13CA0238.namprd13.prod.outlook.com (2603:10b6:a03:2c1::33)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:52:10 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::6b) by SJ0PR13CA0238.outlook.office365.com
 (2603:10b6:a03:2c1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:08 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 37/43] drm/amd/display: Initialize debug variable data
Date: Thu, 28 Mar 2024 15:50:41 -0400
Message-ID: <20240328195047.2843715-38-Roman.Li@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 60be8914-686d-4508-6938-08dc4f608e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /90ur6CHeAXrQkP84qJjKwQZeeiiA5MWV2qjn+nQtnkqRBYxKN2QT3K5wOVQ+b5LV2LBnE9SfzT7z/kPvab3DGiHlFRqGfjSkH+2lLSp8TQrCfFrcYRVbuKvQBQY9PXrcg1Hu4vw87jUkkAk03CImqBbabzSBQoAuRZT+4n/N5/QbzqO9cSlHlhkb7QN8b6bJ69XZZxrE0GtL+T+OVGw9lCFpOaOKBUQdegVlJGbbp3oM5UWZf4n65wFVW5y4M+1irgkaa5PQJFmJiFwtwgTx5EyeCkc4eUFvckOq4jMNOeJmlJ6OZg0hNzc6xRRsy6etL5EpxPQYy3SgxnVBFx7isBqCLKkTXBq9uCRVQ5/ORsSUHkbM7reXC3hTsbd8AjXwLiVVPIF35ntTRFdIuhJk8M0bHEOL2W77A37UiAgrOBTQi3eNvma5SyY/MuudwBEhUfsb5rfn9SGbJfXHlkQOFf6dZzlXgQReW2f93FQlvidUAEnuukA2NiVIjkRHQ/Zugg5iOO+3hphYISGYS+Leyt3fpRYAGzucO7fCbyaC4k+j2X642FgvS5wU4UmvaLibpmck4Yn/Fr7ssS75b2S7LxYsXAIvkoB07or/z9QOtQXHf75/2YP/7obNZSTn4lAuNxaSUiT2LgtFHC9/073sDk0Jd782qQjhPxcmIojH7vtzYwV/qSqA130nbntyL3aKaMzmABnZ+rpt1csk+qlny9BFdJkFfXdcoWv/C6/izSAFl++WDiA8J1kUBU9Q4I2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:09.8073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60be8914-686d-4508-6938-08dc4f608e26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index d9ade9ee0aeb..6dd355a03033 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -130,7 +130,7 @@ bool hubbub1_verify_allow_pstate_change_high(
 	static unsigned int max_sampled_pstate_wait_us; /* data collection */
 	static bool forced_pstate_allow; /* help with revert wa */
 
-	unsigned int debug_data;
+	unsigned int debug_data = 0;
 	unsigned int i;
 
 	if (forced_pstate_allow) {
-- 
2.34.1

