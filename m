Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB8ACD6E57
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 18:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DE410F4F0;
	Tue,  2 Jun 2026 18:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KVEmU0av";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBDD10F4F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 18:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlg/VSPhu29hChnmNYQxui9DQwelNFb5YfLCEYdL8E6v+S6XG+LE1CVUXBLdw/TbNOf+cF0z6DSDbYV0fVuuQ3H4LI+4OJMHh6Tzs2najGV6QZPvJ9sjUeLuCly3GhToBwSYzvfJgDBOautH4sFPVv67ufQqEci4I+K+H1y5cDcfBtGgar8tfSINUxls1Rdj74N4JrP6DA4MVWOUeEQ3DN18AJziYi2dXd665E9VYcltJ/oPoTj9Mi1W4PHdXc5WEv0+1o5ydoGlr0O87eYee8dWH64qxMN+5vs90DLkoF9M2ECTY/3TgmSkLy4W7CBeyEVyxLEFcPt1WlUtsXvFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLbzMVbJ1YUfyUTflrN9kC3z9IPEqVnkEQ2GZZEG698=;
 b=By1w8kdGN2lv1b6kXV0hrBScP3Un2xB8GBOeW5TtEPin40qlZFbsrkv560SGNOrv0u1gi5ynh4+WcL3STyAMIuV9HnbBYLOhUFByaX9J2GbKuqv/VxmF09w1ZZVTqVKP9w0VTUWGzme+pnFrgQvaqZofFSgXiXyRTssmQVxnEIEo7hhz5ALOkgicXfJ+/mpgYlemsHTjIcfqckIVYdISCFk0AqTPMcq/k3hOpTOdZXH83jKF7H2Pin+xUCm0QRCPysUlDjl8g7OCWv40uXe7sw7F08mc2+67fhbhoHJtysHgW8PCJQypVqS89zEr2MeyGCbjGiBi0j/JB5etbmOeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLbzMVbJ1YUfyUTflrN9kC3z9IPEqVnkEQ2GZZEG698=;
 b=KVEmU0avjEnArtyDn3ii0/ZQju9J/QxvMRSR7rzt4+k82gozJP7W1rYwn2Mo2j6w/M/9GVQsbHPmQw/MxBzx781y/8tbW5SjGxFMuMB/+mujXoxzRswSxTBm3VI3t18KxSarh8N97HhHqPGi8gaUOFKiJv4fZLXsnc0XZf7ZTjo=
Received: from SJ0PR05CA0119.namprd05.prod.outlook.com (2603:10b6:a03:334::34)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 18:59:05 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::97) by SJ0PR05CA0119.outlook.office365.com
 (2603:10b6:a03:334::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Tue, 2
 Jun 2026 18:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 18:59:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 13:59:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 13:59:04 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 2 Jun 2026 13:59:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: widen FRL debug knobs to unsigned int
Date: Tue, 2 Jun 2026 14:59:04 -0400
Message-ID: <20260602185904.4165562-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: c77caddb-fde4-422d-e0b6-08dec0d904c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: rEF8sXuVGD5Uqd1V6T+LWf7wH5504vbnh4fzXQXUrUa0BMwIqzftU4MkEf5nACEKBjT4LiRINAgQRV8ZKWLFXrpqMA5e/Ycnl/jzWhcqxoNTOXW7q25QmTIM3fmMClgJuamE3auG/Mpd1J4YUsizhzUp3pQeE04ZVoSDmKrn7F+ATBdUVSKueU8V0QXtKQnUSy24c+aI8dQCGEoF1A3ONrCiRpT4Kon5h+1KieEI5wZzk7oEaY7fhu9cXWCXIBQS+R2drT9PJFMO0F6lOKMU5dnWCWgK8Cv5aInbQhYHo9A+husjPARlbI26oxIBt9tlKZ0jp9FM/yTKCFQ700u7JmZbhoBQ68BpZi4OksiJJXndUunrTjydQa/V5vm5WFX63o2ZHHJybcuWUfu4AAuRH5jInHdPM6fpBG1dnyFa3zrysWipW86xuBBSmSS/sE1+FrPoH0p9QA6HrZXI3zZz8kLFXvcEdosvTEefjUf07OGok5HwP14e81GB5jQsRv2fEgXyGn+DBqq7q63rC4qYePZX0HKKXN4AuTEyTe3UVZaPXktPTRC5J6DVWfPCtGvfhaXl3kqPX+TdGu1Ymown8qkbJTfccEsiS4najYt4N3L/8pUdGQTqYBKaMBFqYtZ9PYKRcNrk0IT88cnRGzm/QNvDdFo/74bcEmU+23YUzVErndK35tiV1w1LcPEMgV8odE3ZXc0Wppn+IfTsW4QdhZJHZBHdnLrifJF4xt31aD4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wEm7E7S4/vkWXCF2dflHmYFfYUL8kDJj2TGVJP+9zR9hUZyU7v442D88sjMQ5vx/wpWJrrexYEcstqdgkuR8S/T8rQ420/QJQZ0Z9QzCc6V1gBNXrQP6WVfbsQnac+yAoC/2dmKjVJ3r99sZrx65L45BBH4toHVI0MID7tk8jl3GNe2RXeFTVH0o2IdiblB6rNtnJY8BzA/ck0N5ungmZw5nr1Jwd+/HOioFYnNfojjGKHXtMN1iW9SLX4GAo3OXMmd/yT2K1ctA33IqaUr+WU8h7HA5W4emFPcWplqI1YaHUrP+XKjR83EsabQbheDwExva9WTVZiRNVlwj+D0DX3ekpFHoE7X9/nGuVgf0Na8sHd/2WQW6cyj0jDzi0St8nb1HSCq/W77JWJ8H9cKdbU5LfIghUrK6utIcAzg0EXYc5bJISayZLThFoTq/WIw3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:59:05.2296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77caddb-fde4-422d-e0b6-08dec0d904c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
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

force_frl_rate, select_ffe and limit_ffe in dc_debug_options carry
non-negative configuration values: an FRL link-rate enum (0..0xF), an
FFE level selector and an FFE level limit. They are only ever compared
against 0/0xF, assigned, or cast to uint8_t before being written to
hardware. No call site relies on signed semantics.

Make the types unsigned int to match how the values are actually used
and to silence MISRA-style signedness warnings on internal builds.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c6db021a61b0..82d02ebbd829 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1155,10 +1155,10 @@ struct dc_debug_options {
 	bool force_vrr;
 	bool force_fva;
 	int max_frl_rate;
-	int  force_frl_rate;
+	unsigned int  force_frl_rate;
 	bool ignore_ffe;
-	int  select_ffe;
-	int  limit_ffe;
+	unsigned int  select_ffe;
+	unsigned int  limit_ffe;
 	bool force_frl_always;
 	bool force_frl_dsc;
 	bool force_frl_max;
-- 
2.54.0

