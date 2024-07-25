Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32A2C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B119210E8AF;
	Thu, 25 Jul 2024 18:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qV5L1Q4n";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE4810E8B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAJSTiEGaOUa827ATmGiqnBmFEZk9YLJ5MiGY+lsLf64kRAGMWkpFXECjXuV8DrKEO+/3Win/qqcRuZflMl+qjdLYg4bM7TYEQIJXNKzJlsrAsUmT7eSLQ+LitrDETKXMYhSnh1zDwej7tfzjI9fphLd/i/WAv9zXGc8xmZvkJR2kS2wF+iwT5lZn59jagDQamXJT8WsOZb/LHZg9wffc/US9D7sh54M/i9DsYKSYGpAf9KBDHep3wK+mh/u8lXT79KE4Fi5Kcpd4rApbyGfDKn1Uv7XWEOT50wksULcGzXTCJ4YSp0R+6JQbnWvvReOLBxyOmlHql+/CaK7q1VSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVylFqTJZIwFiwKBaKTeXxAKwg1VpB5Njgob1H9uirc=;
 b=Th+oLufHIMArTj8T7Uv6Crfrg2nED4/8J+0U1LHZXsIP6IpwncySHCP05f96Cs6+xRBvREwZxOkZ7LZQrgoMUioZnai31Gd0vX4XNxqw1+GQZ6UUypvpN6fRZtbdRnb4FmDHwNAbr4+y4UsSanlIQWcUvgxTUdMkeBp1PWTB1H9r10QYhLH07ksHGkbzZZ3daiDZW5hOBdc2bxNNQRCRDjWN7cCoJUM+fzGPtTBwg5RcHLcwnQenIbj9urE2I6XFq+mWR+NsHMODMoce0M3jKFfTLasy4HoeO65Orc3MvHRSYG2tXLftY+8+8E7aiVy8WfpazQ2V/8Vbi3YiUrzFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVylFqTJZIwFiwKBaKTeXxAKwg1VpB5Njgob1H9uirc=;
 b=qV5L1Q4nP0+QESaWo9lAlGY9bJMsp1doGMOJuXlG5WjJ8k0fjpW3kNMjjfVsCzKJxzqTD9XqUYRxIKz17EgzlwhY3HmKa5uVgUjs2JP8X7Bk+WPye4jMFdmUgMAIfmOBr86cvohzW41p9BBjeUFmgTkIHFapK1oCRrPlLoNBExU=
Received: from CH2PR14CA0036.namprd14.prod.outlook.com (2603:10b6:610:56::16)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 25 Jul
 2024 18:04:29 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::78) by CH2PR14CA0036.outlook.office365.com
 (2603:10b6:610:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:28 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:26 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 30/39] drm/amd/display: Replace dm_execute_dmub_cmd with
 dc_wake_and_execute_dmub_cmd
Date: Thu, 25 Jul 2024 12:01:14 -0600
Message-ID: <20240725180309.105968-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d31067e-cd76-4cba-6fc5-08dcacd43a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ob6/RXTTOdSnbXXBOvWyuimt9FyLtFN3xqQde3vvrptyQSrcqj5Ri3eUQEQm?=
 =?us-ascii?Q?+bO9oCiH0rEZlTRKcEOW+TdSuQ4v7JsTrk+saqGodf+r4dpXPEt7xAcXUxc3?=
 =?us-ascii?Q?hvtWAL/IiGjXCTnw3On5h+HPS1FY1CTGFhBi4V0p6SvEFsQqpsm4WJQ91U5H?=
 =?us-ascii?Q?WVUq3hhvqiun9Y/urMC1z5e9HWCAmC+wyQuQrfBUgSKUZC2P5TaspMENb+S0?=
 =?us-ascii?Q?QxwByd1YGoBfVU+ZfWdlE1XdPaqIRJze6xqsktYIL3pTvHlmJBqlA2DMJj0C?=
 =?us-ascii?Q?lEg7wCq6hphmC19KIRnA8b1OWyiX4heWzF2RXe5sFyjbXpKS8KJ4k6+SXp4v?=
 =?us-ascii?Q?hjqkOE533ucvJbcje1Ii5bor4nyhTyQ9UEzjWcTrF1DBENkExGqc97oPa3/x?=
 =?us-ascii?Q?QhIFF/kh4Yx2ql+ObqVFNp6snpfL7j92CWL/zLLcUBrpeis7uvInuW1mqzPk?=
 =?us-ascii?Q?8XjhWBJAIG9BzLFwcohJQzHMa9/DTMKiZ0NZI4cAOGq/Scs75PwrEc9EFqPH?=
 =?us-ascii?Q?9SYg4WAETYmVHnRkyNmBwyG0ptMErhewh06yXeBJHcKU12rGRvowtG/8/sKR?=
 =?us-ascii?Q?soeu1b3jpJIeo0F8zr0wWGQzvewuY8TUc7PkquaOqZL1tZEyC5U1XUn0TnoL?=
 =?us-ascii?Q?eCvdIOUnGi0pxGywDT8ivpcKPbBpQOlKECxnKJTbYAu5I5eYA0wUcxm5ygz+?=
 =?us-ascii?Q?8R0Tc7jFutTPgwRUoy6blU7dlXr35loiYV9l/eHWb8usUMzKjJL6O1spmWGb?=
 =?us-ascii?Q?T/yfM1GlB3pR/KqOtRRFC55jtQzZCaIXTp3brXYJ8I+7oFciGWf7ibzq+FYm?=
 =?us-ascii?Q?rk4Wzyxnsh7/5QN4SkkJcjT4zU3I2jW1n0VrU1Wikh27hWJFCWJZseDPFD2c?=
 =?us-ascii?Q?MYVBdG9D5g/CSK99P7tGK+oYBVRZHsl+bS1npCqwjpDltgEWe7kHpzNv9DM8?=
 =?us-ascii?Q?43XqNo0n7Pl7mmyxd6AiwFmzfANdf6JY+CQBSUXBg8p9fwG7cnYBY8J5TWH6?=
 =?us-ascii?Q?LU7UfarQLEhdTi5HGAaZ61j6zTJUJhALXXD8GXcQSwIehI62IIzccLZllldT?=
 =?us-ascii?Q?pp5nuBDAO5H9KoZ6vRXwcW4AxhRI1P9YAO2SKCmm6jEtCycvsJRz9qPLCMd7?=
 =?us-ascii?Q?lX5qY02rL4a9+JM5HvwGeDMZlW1JQU6eABEKp1fPSFL2cswgoNelSMM9wv8z?=
 =?us-ascii?Q?V/GZTFRrpiiUJEngG8IhPPOzeNZ5ji+4lNKkQ7jPd9+Tv1e/Az7OcrwfO/aJ?=
 =?us-ascii?Q?Shxt5uap1tqa06mm2B5EdrJbbdLOSURQ520LhqkCM9CszbU1qL+8uLKT+CPW?=
 =?us-ascii?Q?CkBU6wDsN7uQnGLwb7k4nLFnbKcBTwppBwDjf4yQEZfWpqDOk58+OCfGOq1h?=
 =?us-ascii?Q?LJMZwzZnI+Xocp/tb+QLmHqRfat66HmoTslV1mfDmaRQV3VDe/1Z+lvhQ4eS?=
 =?us-ascii?Q?p6xJg9cbZovUofrLmCoK3VvPF65uBSuM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:28.3706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d31067e-cd76-4cba-6fc5-08dcacd43a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
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

In the commit c2cec7a872b6 ("drm/amd/display: Wake DMCUB before sending
a command for replay feature"), replaced dm_execute_dmub_cmd with
dc_wake_and_execute_dmub_cmd in multiple areas, but due to merge issues
the replacement of this function in the dmub_replay_copy_settings was
missed. This commit replaces the old dm_execute_dmub_cmd with
dc_wake_and_execute_dmub_cmd.

Fixes: c2cec7a872b6 ("drm/amd/display: Wake DMCUB before sending a command for replay feature")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 44df9e2351c2..14f935961672 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -187,8 +187,7 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	else
 		copy_settings_data->flags.bitfields.force_wakeup_by_tps3 = 0;
 
-
-	dm_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
 	return true;
 }
-- 
2.43.0

