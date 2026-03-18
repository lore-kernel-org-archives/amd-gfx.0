Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E76FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F1E10E5EE;
	Wed, 18 Mar 2026 01:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZQlje3Li";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E00910E5EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhR6xA8nW5j8hPzGG2sitH6Xn5H9P3z+wD7TCv0DhomN8qnXl4FAKebSnYrCOi6Hu+3dkYxzCAh+EbQTrkOlYMkrNbbacgWbsY6XfzBYNRSYdLXs68cd+gPYjSlN6rbANVzGrw3JW7fI1APYTGvnqpK7VydzD5D5cs8JGrijwSVw8GvkONMWWlsz0rmI9cdt4hSOhuYQZZIgJ9z5I0CpyTW4S5rDgtuw6AGJKGiwnwANBLqbRt0CujaJ8b+fEdRZL61pr4Bxq5/BHev9pLgEpfmRUw6ca4QbuDX0DKNBBCbddyJO/P/xoaZCP1HrmcXYsLCoYvRu89K6uVQc64iMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp0JY7ECQWhg+bxIplYh+spg2iMHk/cSuH9ErDZlT0E=;
 b=TrmCeLE0+kibhMddLLpZlhir5f/rtCwFH9EEin2UyAWXR2KmmmsrEmE28kTzwbaDQnCZj95iekvhZGSX67FfKa8UgIqK+OWtjEMg/w2Tfry3ioWq9e9IRkobpBcE+OLWT8tr8161CcGsuHMxISQbC4JZaZcccffZNwNeKKaa/SRILHoTsKirs4aviziAdy4f1uHXiVYVvMQ6UU1R3NgBgqkPEOmq7qUMqGnYm621X3RKzkYPBtFzqpj7cDs0jEIPE7msWGWJNjzHhGXro3tLJtw29+2mgL0hMFdXJ584kh1KijaFIn/NWrtF0HxOJCpMAw1jBySNb+ngZqbY5vPhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp0JY7ECQWhg+bxIplYh+spg2iMHk/cSuH9ErDZlT0E=;
 b=ZQlje3LiOwWFrtHZNFa2PfwlDTypw7a96aBdnLazLKaQrq7cI9gpHByHmM7KGGi2pIDj1oJJQD+65Bqegr5BTBhNsrUw7Y6s5ZeQ8eSvJNxZGg2mrmXRdXo/yR9gAATgJunwuGr6AagW3f4zDHF+EbiR8xn13q60DdmPhBPENsI=
Received: from SN7PR04CA0191.namprd04.prod.outlook.com (2603:10b6:806:126::16)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 01:01:26 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::a5) by SN7PR04CA0191.outlook.office365.com
 (2603:10b6:806:126::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 01:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:26 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:22 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Chuanyu Tseng
 <Chuanyu.Tseng@amd.com>
Subject: [PATCH 07/31] drm/amd/display: Add get_default_tiling_info for dcn42
Date: Wed, 18 Mar 2026 08:59:16 +0800
Message-ID: <20260318010224.513094-8-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 816e58d0-f8f7-4d13-469c-08de8489e1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ame1R983gM0z8Nv3qVbihd44ooF1rlg6dJlNEygcsWUVz7bl3sDiqqWBF44VHx0JIZtU/479mUfEgkbjv8e3NbJIrjD8P8JrEU9sjVm8YVGg/UJeSevDiSjDi2Zd52sqLDOoEdWXXPI/QwlLiTdgI/Nt33HgzwxRiVHLaKuY3agtDQ8ubyjrY981hEr+EQzIEnBzPSyCJDM+9jVZ/ZrMxXTNQ0EQExfwZy5asRJCwpPeQEkZjDNu6xJRr2lnnQ5JMT2EYYaTBAJARrFE6eInxroGZ54PQW6eA9Y1IOmuHNDHNrKoksBNM2FYY6E8tuqPD1+86ig3r+0XmuwHAWfB00o/tzDwdhb8QqlNNZM45xOMEv2luCt15ejairVNpDarJ6ERy0WsKkNIIZ5gCR5ze3b+8+edaJqZNQcB0LSzo9Snj3lbITzVa6W1G6d9NBn4GJqRtmwYOVmTMbDRKAqVhM8m94133ezK1zW0YTrhSpQ3Xzr+vQwMUeR2zBneddzaH44nmRw+EDAJAP2RwpBjnWkAmVcawiyp/eB+1IZ4Vq4OCbyVY5Az51uLcMYQQ6ejJJoUgepli/zoZN/w4s3hi3DH+SczaXEwh6zbQHWnVqkgkgNq/iYA/mQzE+LT6mNsavmITO3qrlH4EUnfkhfUsW05gw21o0sJgDwpAyaV+cWcbzc1/VRzyBwCpFJ80H6RLkO9Kiic+YNFLoVzHz2JFoBIhQhSA2HH6FPx/kl4ToKnA+l7j3Ju7Gsm0EK44vdsNklZmavdfkicJOpxRq0ugw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1ojwMMjRob3zAL/H0dYec/4rALQyyLzjQvyKiKoWhOsn8wdrreQPSLeumZPBVqZETLQOKfPUKGgHs3yL3TPXFIsvftn+R3qkczOxmNcXKzb/9JeSNDcQATr+RwCo/Z8TdkJEdxwaw9imnssz6Zha7upXuq6iitVsIcqGkyeT4++W0An4OfeLvDncLoVEhbqFIM9mWMuIjHu3O/GwWarYfSTi8YHDyPuZfjU989abKRdn2OfOYBOZx4dkguJ5mTzLxWBQ0MZ/YK5i47HB4Hn0Z7mX/BoiQ6MI302zGfJwLep68NYsTANlD/rQQ7ep8g9pKSOdnY3dOMwYh99Xpd3KgFb1EXYLYktJ+rJ1vIFiJdsBO+aZ05u3816c7MDUGLfQEvQcrG4M6V1eCNlriXnAF20QRxYIBcqXmwsiIJQjVqUYkQBc1B1/LIqrrKQemaQj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:26.3639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816e58d0-f8f7-4d13-469c-08de8489e1a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
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

From: Roman Li <Roman.Li@amd.com>

Add DCN42 portion that was stripped during previously.

Fixes: 28fb6e900b3b ("drm/amd/display: Query DC for gfx handling when setting linear tiling")

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index aef187bcf5c3..7b451c7db02c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1792,6 +1792,7 @@ static struct resource_funcs dcn42_res_pool_funcs = {
 	.build_pipe_pix_clk_params = dcn42_build_pipe_pix_clk_params,
 	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe,
 	.get_max_hw_cursor_size = dcn42_get_max_hw_cursor_size,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
-- 
2.43.0

