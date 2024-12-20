Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6709EE7718C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F252D10F07C;
	Fri, 20 Dec 2024 21:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ncQ03KKl";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E8A10F078
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7h/YP1FW7T6UA1n1gS4k1cL+nxhiuMeZTXX6L0fQcrzwfutR3QcraepocvaxV7e2Z2SglYnUNiV3dTVH3TqGOhUyNpRJ5xzw+pm/rOQdTkURznejPd7YwJPoQauSbgfTtABGsS9U+H8QalGw9KxJgZrdAsgG1zsPsBBtFKkPpWSpWWF7pEzBS8oVz8LLnfmp6YwuMiyzjPUx8zHIlD8TR3M2cuKwWQ/1QUVHK5Z+grtkemXAJk8y7cqhfMoBdDO1I9D6UBMHpzHUgTg17Fk1NS2cXdLZDomVgTJBG8pGYnk1T9O2tTX/OFBHCnRPUJZeiBzBmwn58ajqvkKL/6RiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q925AZKpER3xZ83LhhSsm5rED9TRnau94x26jC4NwvA=;
 b=sC0py4IxFmZ6AjlrxYIHjQDpESCiLt1emIufYDIXgIExCbXw4P4gnGmI97cIFAn9Z/TuB2UhgVWHpT5/ZAOwyeRxR7luovslyqpAXhtVWn1ks6Je/IZUTNPZX2DAldxW3yStNdWMeFcSaR2aFs582SqtHG0DaRWATMmy2aYyBhz8pKa/9UOQdLeedcIWudP4Gnc0sBKaiXykDSSQPfoxYp62RJcLtaLJkIwXqkUyPODJk/9pPLs1vtB1Rwx6QhllfCkLcZ4J493NdiSo4hMY5v3c7d3uaDtKkm72n4mvoY2L0UXU3OxUq+bgpTBny0Q87DxzqPOKJWNGKoUxKz7J5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q925AZKpER3xZ83LhhSsm5rED9TRnau94x26jC4NwvA=;
 b=ncQ03KKlKzOXHqGN13UgnnYGK/lytl+TfydyrGspNLnbi/widd5okS+ObXCbMP4HZFr7NehyMbFlLtl0WnH1R/QSrnKB+/A61ETu2VI9VhAFu2rUJwlOttwk+xFWjrqRMnh92Nc6PonYn4fDWcKF+Z/BQNQiG6T2Xd2Wi5+Qn18=
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:18 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::44) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Fri,
 20 Dec 2024 21:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:16 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:15 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Brandon Syu
 <Brandon.Syu@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 15/28] drm/amd/display: modify init dc_power_state
Date: Fri, 20 Dec 2024 16:48:42 -0500
Message-ID: <20241220214855.2608618-16-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: b509db89-542b-4598-ea46-08dd21406eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2EYPUZJm0YDahV8K9rBsbrStNYtqttZB95BfVlaQJB1k5Hd0eOgeo4jg8RbH?=
 =?us-ascii?Q?GgpJ8JVEjZs+arW5InZCZdDHmDu+0+uZ1gNYWHp4rVtg1eO+xAqakDQrXGpJ?=
 =?us-ascii?Q?1VD+Bi62k5FsyLtlyNiD7/dyDxGG6nkGzven9ZoQkTmBt27wv1UN2zkXX6WC?=
 =?us-ascii?Q?iyGobixpS00drbQhHLBRVpokUKTgrCp7KqB21S76nXeA5oKtxq3qOYvlXc8C?=
 =?us-ascii?Q?498dK2Cou5rMXiIuHvhfVPyAc5Ja4wkePa5jYkSa6N6emGLRynTNDW9J9tPu?=
 =?us-ascii?Q?+KUNpnEck8E3nLBA34Rn2edkrkSq5xA7LTpFIHH1lHogIbDhOHRZiXOaUqhl?=
 =?us-ascii?Q?1NOiEBjYEARoCzHGTMlqdORbqZgDop0P1PXUd6VGbwzD/uEoYW1oOhQj4rlz?=
 =?us-ascii?Q?BOBK5Z6KaHAWNUh51kaMYjBVWW0bPK0Ofdw6Ns1MKetYuH+ldT9zhKHcT424?=
 =?us-ascii?Q?ALr65j1TzyVmB9iNV71Jt/km6USFE6jb1MV97GIszb5CyqhYYsP+398nALRB?=
 =?us-ascii?Q?OlyjChDpUMiKOdYqL3Cm/OB6ZNTqxPJAyJSYG0+uLtUmr8dInzGUVOkhvCca?=
 =?us-ascii?Q?hCHKgtQsFGn2AHa6oQKSlTgT3ciqoNEH/RHKhPmQZpGFILDynLuhjX3SbbvQ?=
 =?us-ascii?Q?PraHTvU0ONJTbhdgLCfnXRAY3FMJAixt4bwf9/Oo8RtZJbFPUTroQPi+jfVV?=
 =?us-ascii?Q?g2iAL51wAN1KCJPqBHCjimRCLrH0UQKXLBcjrwfbABw7nL+3FC3awn+T7Zn8?=
 =?us-ascii?Q?4+nzze0KAvMdAD2kCUqF+piv+zMOwyL+4w4cpJtjfqL2b+8Q39WkiuqSav/t?=
 =?us-ascii?Q?btch/U5aMYaCBtdBN6N7bSRByuqm2TJzoOTsSg4z/WIZBO4K3+LzVNVHsSiZ?=
 =?us-ascii?Q?0EChewMab+/xFsj2VyENrVb16iQuAoK957JtH6in1q37tQTMztPFWue8IsMy?=
 =?us-ascii?Q?XdvxQG0+r5VKumy1SqzeYFw0V6MUMqOQssGzNQ+I4bMse4WvDHRQ0tc0g3RA?=
 =?us-ascii?Q?cifyd9MlM+EtSw6fO1FMDX2Z2rNSMR1X7CoPHOCtAcowD28ohoLNCOmtrI7R?=
 =?us-ascii?Q?2jiJpwE3n607LVIC1+D5uqMv1CX61G0+iXz+j08hAHkup7lA/e2VrHix8u8b?=
 =?us-ascii?Q?YGHQDprwWqR7/ssG6ncGE7muqcMcEgRxZ6IRKvam6Ph9SrMEXfyJAJYgGZg7?=
 =?us-ascii?Q?TddsCzFLfzJyDqZSKqFz266SWy07byoBXwamNjl0+9qOvkDJ4qtZ9x0753z7?=
 =?us-ascii?Q?N+uuKmmcgNPSSv+HOT+E8skja3S6Keie9eQYJRenKwdvr4X/CvHZ+WLrjRF6?=
 =?us-ascii?Q?rWH7t5XIa6EjF7QeJib9isVFAZUm8+liWpAr08AMT5WZ3/ibqtyI4pIPUViX?=
 =?us-ascii?Q?+MVFufU/je5SVlgzYDyolqTyY7L6Plu8z42v/BcvvqJWbjpE8lxMYI62XEDc?=
 =?us-ascii?Q?+odxaztQRE8qr0RZ4Oq8ZVxi2Er7aXfPcbOE52HmmIkc880Yr4dqNjZOVP6j?=
 =?us-ascii?Q?iMkHhg2tQgYC/zI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:17.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b509db89-542b-4598-ea46-08dd21406eae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
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

From: Brandon Syu <Brandon.Syu@amd.com>

[why]
initialize the power state for dc use,
but dc_set_power_state it not called at D3.
It would cause can't recognize last power state

[how]
remove initialize the power state for dc use, it is not necessary.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 28a66df6abe6..9c7c3f4a94f1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5379,13 +5379,9 @@ void dc_set_power_state(struct dc *dc, enum dc_acpi_cm_power_state power_state)
 			dc->vm_pa_config.valid) {
 			dc->hwss.init_sys_ctx(dc->hwseq, dc, &dc->vm_pa_config);
 		}
-		/*mark d0 last*/
-		dc->power_state = power_state;
 		break;
 	default:
 		ASSERT(dc->current_state->stream_count == 0);
-		/*mark d3 first*/
-		dc->power_state = power_state;
 		dc_dmub_srv_notify_fw_dc_power_state(dc->ctx->dmub_srv, power_state);
 
 		dc_state_destruct(dc->current_state);
-- 
2.34.1

