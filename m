Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C25DC83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B034510E733;
	Tue, 22 Jul 2025 22:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fImspi3T";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5746810E737
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia2L0POg6LTCBh6uCTTiZygvJuDssM4AYr41R+7Ju7cnBc69JzKYESfM8voV72HC35ajQn67Rjny9xZP45PS2OBfMHeYuFwqTizlnYGRqsYLDqUoPcnvqdr8Tnq91dAHqcNhqT7U71uhQezs35T98lwL4ljXqzqpRwbKIbKnEhntycmJnXs1Gezt3WnVe2qlo86j+WHN2yFVo0X5f5NlmmOsyeTwfHlj67dn/Tm5NHZTXuele/6m75v+Hgz1brFHY+UjZlKwZH1yeJkqEOUc6z+Evn7djNCW4X2UNBkq7VU3BhIgfaArUxowVyidSQHEpTaDsSCYeq+fH8X7lVNDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyTlphMlUhkwAfz2MXR4CM1u4fxqBrV+oe6CH9UuNG8=;
 b=sVvkZVBy43ysZU2d7Go0oCyFsPqvQSJ/CUchULg5ZiJ9V1WZS4PPvlELYbokjofzv2CcjNqD7UIoyzyLBYywUYdzi940qXmdNBl/SfjUMROaIqVA/laaxuLOv0gi5X94Tnm3mPz9ghyDzF7Tjfu9yNdPPkB1+SNCnC+Qm0SpB2IQ/tPJ5su3zilyxHBDq47eBhyLIZd5eDEbGv/BrWqopYxGcwJ+rKPfPSTP17jucUuZ+EcyiG+pVtw8dyvdvNxFmJI6FfyL+UDnZDzXpQtJneV0Bzn1F4NEgYMucblfNf1OXZVEFs18efPw2CQ1aYarJq4vxSLuZYPNa7JuhjEJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyTlphMlUhkwAfz2MXR4CM1u4fxqBrV+oe6CH9UuNG8=;
 b=fImspi3T3Mv/2RUjzw4VSFNlLVa/AxVqdssfbq+lbb2UESe0zC7ZnMVYHUyGeUfImTjk1/TWRO6GkJz7G/rQSoucjIGkA9qLH+CbFcyJBt+yrZWWEa3AVns1tJrasM031kGIWs1VqCX8v0/9juv3Hf8r7HQ95EXAQVWnGQKHFH8=
Received: from SJ0PR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:334::9)
 by CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:46:13 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::e9) by SJ0PR05CA0094.outlook.office365.com
 (2603:10b6:a03:334::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:46:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:46:11 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:46:11 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 23/25] drm/amd/display: Allow DCN301 to clear update flags
Date: Tue, 22 Jul 2025 18:44:32 -0400
Message-ID: <20250722224514.2655899-23-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CH1PR12MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: e737bc7f-b396-44b5-f67e-08ddc9718f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J995MGFz685RE/m0vK0jW8891tPxJ0ihQ/NY79c0eKsX2n3Zue+btU8NtrIO?=
 =?us-ascii?Q?FYp8NIu5D8OVRdQKxD57mSxPyImhKP7nR+IqFbTkE5KTgyqFRtjdT2+lSt4D?=
 =?us-ascii?Q?ZT34njuqyGxAUja5vNJuFxvRZsvLcoHxh0+t5h3Cx4uBjLTCEKKMouNxrrYy?=
 =?us-ascii?Q?LN5pd8ySW2FevvpfMHF0G3TYeNpLg+ZiQj5xnkD9wJVQYpbpMGfDKewm8Q3B?=
 =?us-ascii?Q?7W/ahIjevOeItPInPRi2TFEXfcyvbNWhkKGTFWtvN4mzW7M5nZXrk1M1TRhK?=
 =?us-ascii?Q?elW/YE2cFljqk4im4fUk5QGB42PfLmA30jbbIVLb1YrudcfN2HsFsTLyQY3L?=
 =?us-ascii?Q?oIbuHYvPuQijSsOUQsopzx7k+foPWuPRywG4zQhZVikliyGaoKvg/wIYqnJQ?=
 =?us-ascii?Q?I7L7kohxygf+unamA3qdQFFv2s70vZMgILAdc1/UhWN9dAB18XjVnG3p2sQy?=
 =?us-ascii?Q?L8VtXVtizh0c7E05++ddOlKSxpTEguKcOxSF043iPY7jONh6FZp6ALCbsqie?=
 =?us-ascii?Q?nw0oPIJDiOfMzgkv6/7hQEmdFECFPFMYnxnt5M9OudJBO03tF1llcd14fJGc?=
 =?us-ascii?Q?iZcnSuyDNVPCeHCyFPI+TdPCUNQCfRFrzyGcNAmyPNEZAgafzeOGUJabXwQX?=
 =?us-ascii?Q?UyJQa1KNfJJIoaGJxjHa+dbj2x3xl2wcv4LT+6SUkm3/j3VYZ0HPuAbNg6Z4?=
 =?us-ascii?Q?v7vrb+TMEzALnDfA8a15rcPU68vBNqYJnpio8/EClsO7fOEMtQXFz6C+dElg?=
 =?us-ascii?Q?kjvHCOOJASEA2ccqyYSmCYlcBRAZc7AKFHmtFrQ80ux0IO0OSgtEZ0GL2+IX?=
 =?us-ascii?Q?3FdZU9UQvK+j/Esxpatszxwe/3tD0hNXHtW0iE7wm6AAK2ZAAeOXJ0nlhgh9?=
 =?us-ascii?Q?1d+BgOBUdwZvFjfkMbjFhwk51YcviA+jq5Yb6k12iOnMtB6O9X3osuslNIgP?=
 =?us-ascii?Q?SxMQNTLtyZarC5MdwdWaSbCGUFUoKfwIwEHsENP9VZ+aHxFUzuWLTlqir47d?=
 =?us-ascii?Q?CAMiYgQjcE3ugyGppBhg7WmOgtc8HazEUn9hFEvUyCBaK7q3JJiGlgM+/mn8?=
 =?us-ascii?Q?naTpc3GjpgYCYh4TQDdnW4oC4wbZGzlsJR7+30P3SDfYgaL4923Vb6Lg91CX?=
 =?us-ascii?Q?tYR6rE0aci29my3qQCstAsDpABBFDOWwxT/lMwfefh08m+hbzq8vJxY8ktNh?=
 =?us-ascii?Q?A8LThO3752ZTXsmvKLJeRZ3vwzw1/VdnMcxIRUod1Fv+Zwt/FKjRzun/CGaG?=
 =?us-ascii?Q?fyDfvx1P1qh6ulQGuV06ZQFCZ/gkumV1cjlrwaagppAAo/m0YUO6BQK0ytgO?=
 =?us-ascii?Q?HG/DzuH+RqESyNmk5vZu8MOEufojN/s7f1oYn55tMN+x5M5FQgJ+sJSrxpv+?=
 =?us-ascii?Q?QghndwWj6gMkGWBmDuOeoJqGRXf513vLj98p3WG/H0KwN7bNKYKhEQIkFYp1?=
 =?us-ascii?Q?GijxFl0KIhBIuPWkDugRmpMrVW0gyxNBvyirBw1mDvjWZHVVDVeWRQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:46:12.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e737bc7f-b396-44b5-f67e-08ddc9718f2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why & How]
Not letting DCN301 to clear after surface/stream update results
in artifacts when switching between active overlay planes. The issue
is known and has been solved initially. See below:
(https://gitlab.freedesktop.org/drm/amd/-/issues/3441)

Fixes: e1bd5e0bb4ca ("drm/amd/display: limit clear_update_flags t dcn32
and above")

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d8e4bdef76a3..cf3893a2f8ce 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5334,7 +5334,8 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	else
 		ret = update_planes_and_stream_v2(dc, srf_updates,
 			surface_count, stream, stream_update);
-	if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
+	if (ret && (dc->ctx->dce_version >= DCN_VERSION_3_2 ||
+		dc->ctx->dce_version == DCN_VERSION_3_01))
 		clear_update_flags(srf_updates, surface_count, stream);
 
 	return ret;
-- 
2.43.0

