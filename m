Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53788C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABCA10E824;
	Thu, 26 Oct 2023 14:21:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3584A10E817
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOv+PkAdaCJCGQWE919NCohtMb2VxMBY7rBg/ADVPDhiozZ8o18+YHpcJDeFKwK8xHVwOHHNoVpYgC1p9/qg3bWADkwqH7NCBSJAqMgCFGORguswbUu3rpit6m3Q+uqR1+UMUS3Fd4a6Yh0in0NnIsWmY3UDA3xIay1nlsl5nL/BhTmOpEGvvp3uSQKIWNRi0VWOLtvLAY88/MCmRUEV6siz9pv/A3UCQaOvwJXhNZcyEbRx/OxXgq8QKT+6nnFjoT2KYseYTIvXLAuId2sONMH9BnfyA13Z3uDWGwYaBpI7JENXV0+6kaFKhdElc/j69HrcHfuL4l4Ikj6iav1reA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64pg72pE/QAgoQvMy5+ot/bqf9IswG6+S4AKjNPfWX0=;
 b=QuxnVHuo5U1asJogLu7SA/p7Vkbz+HiqfIXNiJiLkCBtTe0EnigoWHS9lw94ghi3d+SlM2uE6NjN8jqM4sgBBO0o/fIHMH1vEgfr85pW+yJ2XdGvuv75M9GEGytG4KJGqswfnnQXZ/afdoaHH2hYozR1jItIXsBLx4qHjs8UvDzCx9W/DyOUtl9xUUNd7dA8fpYNpBw6FFq6hj2mNu8zhmxoY95N8Ri9RBqKzaNSUf1kgLX8TPQRJxQstKMaJo1p0w3OXUyiptpDNi01PiT3WkHTFUiRmW6i9eTJJ+xb8dHEBtohsEDl+VSw0KxWgengpmC9HEcOUjPMg2nNk825OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64pg72pE/QAgoQvMy5+ot/bqf9IswG6+S4AKjNPfWX0=;
 b=naRkg3FWEPu4I7QW8IpZ8DTes+9vparrd3z95BcB530EppxB6kTLpvAb9ewomb3Q7StSI3QF2xQeIB5TbUQYt3XQd0K/hZzsQLYggJ2Z8TuQEM3McXmouLe3MJjrpuKv+ONZoB65hxf3ET+QSh3QyEgn0Tf60RE8KIgRJVTrqBY=
Received: from MW4PR04CA0092.namprd04.prod.outlook.com (2603:10b6:303:83::7)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 14:21:01 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::d3) by MW4PR04CA0092.outlook.office365.com
 (2603:10b6:303:83::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Thu, 26 Oct 2023 14:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:21:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:59 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:58 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/25] drm/amd/display: Introduce flag for disabling Replay
 desync recovery
Date: Thu, 26 Oct 2023 10:20:17 -0400
Message-ID: <20231026142020.67861-23-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6642af-9882-453e-f717-08dbd62ec77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgLyOYLZMg6UXGVDf44W5RR3aIIcD+YBLgnOIWIpHGW58CgaFRp6KEfDd04RZ5Wc5WD20cMUjJkykJUlMJbKUPHWDTYVvYLin0Besg6lUfGpsFDLeD9+sV4D0oQAONaUYbwzGVmadOgivz+gNowdOA6at1PKbYBmMzb6YJcW7swUe1kvmScZE2WiAMLc+afHIU8pRdYvvVIQjhL3/kA7ZmNYY3CdKpHRiFNHbZ8R4me1OVrmobroy8E7jo17FJudDq6P2fGHTLngbdMG/YEaLVZ8AH6S1uNM6YJGP/UAeHkM8kFdoI3mJQfrpkdBhpoZHw2cn28G+mDPG1eUV4SoduUoBrdlCx6MbWGWDeSHOXDkBS3DAsj+lVQcbTu57DvLLVQWhqw8wU6k6SYS6fHdiUXWrjSZCD0r2ZC0Mg3Y76GzG/0YgenFaoccT1ubuarzcAM1aAFesELeGdax8hr8UaEm4CRpodwFATIh4w+CwVySRBhQD2IofcEjwOmlNMrlhSfizYiP17drGCG5JL0Ia2/A4i+tJ8R4uokmmJG+24pxQ21hepY44hVSvfovx7rRdN6/Ce310faj2MA0IEPtWxsZ9MK12wsqvhqq/FP3j0tg1xS6enIPTru6jeM8tXECqRcH6OUvmjXLql1zFmruf7Aso4nDy4Bcy6GDujM4ZSOfHm7HjU7lQDEeoIo/l1u4mr0GN5yDAb62//wXvHHZk9/xWVpmgc6kaNAV6kfKVzoJUJXaDHrzkBZ8km4WhSfZJ8WvcQQzlIYNGjq+PxzgQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(2616005)(426003)(47076005)(26005)(336012)(1076003)(36756003)(2906002)(356005)(36860700001)(6666004)(83380400001)(81166007)(4326008)(86362001)(54906003)(70206006)(40460700003)(8676002)(82740400003)(41300700001)(8936002)(40480700001)(5660300002)(70586007)(316002)(6916009)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:21:00.5346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6642af-9882-453e-f717-08dbd62ec77c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Dennis Chan <Dennis.Chan@amd.com>, wayne.lin@amd.com,
 Robin Chen <robin.chen@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Chan <Dennis.Chan@amd.com>

[why]
It's useful to disable the recovery mechanism when debugging replay
desync errors.

Signed-off-by: Dennis Chan <Dennis.Chan@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                      | 3 ++-
 .../drm/amd/display/dc/link/protocols/link_dp_irq_handler.c    | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 40dc51853d62..bb159b6b1b76 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1037,7 +1037,8 @@ struct replay_config {
 	bool replay_smu_opt_supported;                  // SMU optimization is supported
 	unsigned int replay_enable_option;              // Replay enablement option
 	uint32_t debug_flags;                           // Replay debug flags
-	bool replay_timing_sync_supported;             // Replay desync is supported
+	bool replay_timing_sync_supported; // Replay desync is supported
+	bool force_disable_desync_error_check;             // Replay desync is supported
 	union replay_error_status replay_error_status; // Replay error status
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 34bf8a9ef738..fc14c3644144 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -190,6 +190,9 @@ static bool handle_hpd_irq_replay_sink(struct dc_link *link)
 	/*AMD Replay version reuse DP_PSR_ERROR_STATUS for REPLAY_ERROR status.*/
 	union psr_error_status replay_error_status;
 
+	if (link->replay_settings.config.force_disable_desync_error_check)
+		return true;
+
 	if (!link->replay_settings.replay_feature_enabled)
 		return false;
 
-- 
2.25.1

