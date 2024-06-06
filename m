Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3C8C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8CF10EB13;
	Thu,  6 Jun 2024 21:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u2+zk/X1";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D59F10EB0A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilZtyZfeDFoMJOLyEfKGNqvlLOa/HcQvXFSHFfDamkuf97XvwAhN+K+j3bqTs6YVQrZAqwZz0/d75PEf/Th1N3SnQUKXM/aL2yAwILPEWU0J8BrbTCP1BbJHnhwlZrEuTmCjiAjM8Jo7OGVKkQE/lNRsWIYj+hKtogy2Nzc6XrCRBDi02/q44Ffnjc64WaUprGb+WwwikrWa6TRH16chYTZXRIpi8C5j2Sh3qrG7+XrrvSgVZKD+0iET2D5Er0x+YZKcAMcL0BcBYa7LEN6cHaNNYeKkQsWumNZkP/4IxZZksqixkHaXVtkXiTugSRLs/zaY4hSzsmIyM1rcRqqL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plNf09Ii7F5U6zwqegMYEuGi9Qs0jBXQNXLUyl63a9U=;
 b=jt1Ou3AfuefOEjqAZtUwhB4FSGwPdzBgG6D4v3sAeNobFohLOttZ+Wr6caiGuOW7g34fIhXFcujiNWj2+NI2yGwYbpOkFKbC8rOun7J/NtPU3B4U5McCagMY4PA48Zy+DQxfsK25GbF00ZwPttkC2f8pkAhDM61BpyvGdtjlH08jFV7GNxCt7i5N07rXJmzm4UA4KgWTIulM3MKC5Gm9NS5U8TsruObBhPHlfvwQrx7D9T1I05ee1DynCmDJ2HR2tEO0g/gJYawC5/W6lYULFUeyR1PIhA3pXYEO1ahoKLFRxjpBEbxbpBUN1OePICiD9WGc84R9LjojoC/gGxcypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plNf09Ii7F5U6zwqegMYEuGi9Qs0jBXQNXLUyl63a9U=;
 b=u2+zk/X11sEOXvkIjGyw+q3bGN0enGB+TE6GUjOwZ4e+jQzW5SajN73z/QiDLJYinGNlI4MxqIr3UFCGyeKdvWJuEH5xlVfxcMtOkBllxz0vFcHNIt9g/UU8fXvbX3zeI5Htj48+EPYYvaiClNeamS0PHvtDkPstoGZwp9ME6X0=
Received: from MN2PR15CA0037.namprd15.prod.outlook.com (2603:10b6:208:237::6)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:59:09 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::40) by MN2PR15CA0037.outlook.office365.com
 (2603:10b6:208:237::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:09 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:07 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 61/67] drm/amd/display: Fix missed targets in FAMS2+HWFQ
Date: Thu, 6 Jun 2024 17:56:26 -0400
Message-ID: <20240606215632.4061204-62-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: d9faba70-5e99-4407-c493-08dc8673e465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ncr7q3xM6CAubTPTIDGsVvRvMPtKGrY4GQWP97Pr07IOC3WuxLBrEcZqQ/i6?=
 =?us-ascii?Q?fbD3Srz+MXkHJoDN3xWrEsheqPK4foDbb6wlBKmGkNFQYDuvOJEsEsnspcoY?=
 =?us-ascii?Q?8C0uGTXsYhvE7AnFb4/YdFR9Jq+T3zuplPH5pfQvU0rwBOWcW3mYB0FPSrqk?=
 =?us-ascii?Q?JlrAfcfGgqrf42czsmtNm7cUnWX7Uwpr7Kooz9I9Y/NoeV8csOehhvu4dG9n?=
 =?us-ascii?Q?KZuNP9kYJ2AUCtvHYP+t4fTulqdyd796e9i5cfXnwgnwO7qxJXKybHjC8dqF?=
 =?us-ascii?Q?TVFntp/pTty4yLrUuwkhIjF3smC78ly6HuYLONZeMboksZySAW9+vWmEzB7U?=
 =?us-ascii?Q?oopbeao+jM44WuUbuG/TlcnHCOdQxAP3ukdnhtsAt8KE72X+q5eAbwy4H1SE?=
 =?us-ascii?Q?R6TnGPDCOSmDTgyPLEgVQ+qjl8siQJou/GQjCUFK94LvkxLguU67FzV6sA07?=
 =?us-ascii?Q?UZq44Tp+IAAV8jTy3ZxltNNgut0oInW6P4SDuC1DIrJd+efWNBWXb4BqJryV?=
 =?us-ascii?Q?AyhchZ0CS8qzCcsXtvkx1DJQBPHRJGBv4OFBdRZjdTv8lLeZNWeFf5jWrHdi?=
 =?us-ascii?Q?o2Irecm714RnoLpsr+Qw+g91Nv9vZBfyJXGjoQ3SiW5qo6kZR2iNjhbsFvUw?=
 =?us-ascii?Q?VzCoHE3WM/5bp5DVxnth7t9OixmOR0DnJlXQBBItdB+9RyFWjrcHwi0by2iP?=
 =?us-ascii?Q?gOlOov8LL94LBurVpf0u3yfbFt5f/cUdGh4udYCuIgc05elRe+fzJhVN2+IU?=
 =?us-ascii?Q?4zXdHdAVIGmF8DKiFaTX4O4p8dQw8DS5b6JH5tfJPig+N8MX8u4xpK0KaaDQ?=
 =?us-ascii?Q?u2C4of8UhBODbYAhVf6ogEw1NUPbgFVR6Ve/HcrVqfLOuiM55OsFWsWbJhGk?=
 =?us-ascii?Q?d37p3CRIosTCJ7mcmK+GBP4pSQPQgpYO/wHgXg6ZcHe61odhKoSy4Ew7ki3O?=
 =?us-ascii?Q?tOpTbaahQwMtWtdLq9sakwO/pNhEk5JQ5xnhvAT/+R+PVF6IXoaqfGC9/O2C?=
 =?us-ascii?Q?K/GJTElGJEmh9snVIYSWj2aMTo3wBrMGpvwxcXUksNr0d8VzdX4rSj5IESn9?=
 =?us-ascii?Q?vgD7Urjoh//ozE977y2z9NlrScDw43LOB7BHKkwqylfIiTHTxWB4PeI/gLK0?=
 =?us-ascii?Q?+OeLV4rKNDeolaGtGsuT1UMXGBp1KrPBW8aB9ocrtahjOJih3pjLDx4k+kfg?=
 =?us-ascii?Q?p5RW1ky/dYKQ/i2WeZwc2J2JNzcTKUAOI4jPcKtAE/FELk40KsI+bomTtPqc?=
 =?us-ascii?Q?/GWK7WT/g7KFw4RCvSPGeR7egkaoV/g0dDREiu7gCp1cZvRiOYKYU+Yite77?=
 =?us-ascii?Q?1KhAyUeOGcQw5lODZx4Z/gI8vxtXuQKSJbsiccwlRZCY5+OOM239Tjdw8LDV?=
 =?us-ascii?Q?7zFD+OOg+aAXq0bD6ozh9WYzDLNmSmnVMUGsJRZzscSKe97cZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:09.0378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9faba70-5e99-4407-c493-08dc8673e465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Add additional delay factor when considering a safe time to flip for HWFQ
to be passed in by the driver.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 3e4abfa6d517..6ff87b023081 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1657,6 +1657,7 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 	global_cmd->config.global.max_allow_delay_us = 100 * 1000; //100ms
 	global_cmd->config.global.lock_wait_time_us = 5000; //5ms
 	global_cmd->config.global.recovery_timeout_us = 5000; //5ms
+	global_cmd->config.global.hwfq_flip_programming_delay_us = 100; //100us
 
 	/* copy static feature configuration */
 	global_cmd->config.global.features.all = dc->debug.fams2_config.all;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 87f2e4e38f9a..3e8d5f2d7429 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1836,7 +1836,7 @@ struct dmub_cmd_fams2_global_config {
 	uint32_t num_streams;
 	union dmub_fams2_global_feature_config features;
 	uint32_t recovery_timeout_us;
-	uint8_t pad[3];
+	uint32_t hwfq_flip_programming_delay_us;
 };
 
 union dmub_cmd_fams2_config {
-- 
2.34.1

