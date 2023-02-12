Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAF7C636D7
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F1110E3D3;
	Sun, 12 Feb 2023 17:00:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FF610E2ED
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWYQgUHYUu2n3yJpC7+NL08K58gsdNPauIwS6naoe2hPXVk+eH18HrBCwmD8nn6/w5+N6CpMmbj3bR8IznFLfgGrT+WOmtqUrYssZORGqvYw+ovurRh3PYnj9zqbfqKewJ7jAmo80DTzGYSWm1MhrqxpBhzJbrCroh1Rom8p+XVEjHr6VkTRwEoEAI6zvloTZZWKzpAG5JX7mCBEB7ATIg50Dsf3tVSSxyos5DUmkF4MwNb4a6ZoObA0ZDkxVos31bpDKXxb4+TzLG54P9ZMF2SSRQ7B0sNsagcZBdts+BVpWzmRVANv8kvWwNgZuTOmXv2c4zo/x2WRQRICmt1j0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMrZ4PGT4wY8m8DfQDfZwBIpg7dalOqfO5W5nkXsoNQ=;
 b=OAjHSnXfrWQZHkFCUGYzN6VthdIuIUW9pTc09Mft6X2x88LstOCRGJLoICdEbstOS6bhBlAwAbit3PwQstiVyEj6GwEhT/31keFNgWH91t9NYzfPFToqEfQWgEigLMYXjVD4fzwG+Xp3Ziisfn+ZXP3Xu+fHr1DXhh36Ne3gc9y46H7zeWTmA/EtM0EG+Lld7+FW6PUnkAbLuql2D2/YAAJk7pdQnO39UQzsSPGMrD1+xUdDmw/8uGwproXOaUlrZV5BhbU8SGED65X7E22it2gigqhTPRhBsbT0B43RiNPVnyUIjm6nPIoqg4oKB9UBNJ7NuNYRaQhoMJB0SS5HAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMrZ4PGT4wY8m8DfQDfZwBIpg7dalOqfO5W5nkXsoNQ=;
 b=j4mA2EYgEjq2sMPwTjojBuLgZdqOJwTEuN1EEXxPcWgxH58795jdksx/cUejPUv16aFDwuaRTY38HPBKlVKmgHceDZ+wwOhvM4frj+1oQQVOqTPeVt8bX4ZwAFrteEPslNRVEcbsLKRZcP3vH5O+CSDQnSIbK8ydiXybpMyVDok=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:51 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::72) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:49 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:48 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/22] drm/amd/display: Disable HUBP/DPP PG on DCN314 for now
Date: Sun, 12 Feb 2023 11:59:52 -0500
Message-ID: <20230212165955.1993601-20-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: dc75d93b-43f6-4632-1723-08db0d1ab26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OhSrQMTz/mwvFlRLcXI2ctUBF6BaFfhTbUG2kSUQcVgJa4FjrJLpWfaEPZY49fT+IMJCfwpoaLqZWa91QeIAFsfV26DLbMSClsezZXPm5NmmsfCNDUqpatKS6O4HA3KTZL0DjDb7iyywygKLza1VPZRfgoGXFVYHOSTtFYxo7Hdt9h4V5SuvAFTYmABhydLn/8fWuRwxFiF690aER/3CPmClcL798ZdbjX/FBQCPMYfo2AVnPvB39nSXZTAL7BR2Tdx+bX01Pw0hvH5FHmP5gEKdlQs/eYp+ZvD1PvaDMOlMX8/QJ8aAswGlpPTDjQGku1F9C1sNsg4WK+VSL4WihFnXrx+P2XWO4RC77HEGN+uUucfyG778CLcB8ZzA3zAnbmSBJiD9xGaah9rVZgM3GJsYtY84ce2UdoFKGBVq+4FgrwrZGNvao7XOHf68zjlbu5oqV24uP8WQ69Cqi8kGYO/zCmjUBkQ9kZXl44cRtrLHR2r3iirjDfoctE3QbPseQMQf7AnX2vQJy/KHfyLLl3iOEqkGtiJLoQhixr8dzNUB+OeKz6AKuzgwzIh3yTPgLtPb23CTIl3Fh8N+tXMwWS8RftRNcOjRG964TkPD7rYu3TxCCevZl71SFoSSMrAKXBMZAdDqBYDc9nvoWvkE+M6IHHpAcu6XqPjSKqFSHk9LK1/biShIyTfR9ETlkdKh9v9sDQW2ztYpVsTAR+65Jls+toU09djUPFuLpp6iFs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(36756003)(40460700003)(41300700001)(54906003)(316002)(8676002)(6916009)(4326008)(70586007)(70206006)(356005)(36860700001)(40480700001)(86362001)(82740400003)(82310400005)(81166007)(6666004)(1076003)(16526019)(186003)(26005)(2906002)(5660300002)(8936002)(2616005)(44832011)(336012)(47076005)(426003)(478600001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:51.0012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc75d93b-43f6-4632-1723-08db0d1ab26b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
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
Cc: stylon.wang@amd.com, Hansen Dsouza <hansen.dsouza@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The DMCUB implementation required to workaround corruption is
not currently stable and may cause intermittent corruption or hangs.

[How]
Disable PG until the sequence is stable.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index ea1cb90f8b92..54ed3de869d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -892,6 +892,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.force_abm_enable = false,
 	.timing_trace = false,
 	.clock_trace = true,
+	.disable_dpp_power_gate = true,
+	.disable_hubp_power_gate = true,
 	.disable_pplib_clock_request = false,
 	.pipe_split_policy = MPC_SPLIT_DYNAMIC,
 	.force_single_disp_pipe_split = false,
-- 
2.25.1

