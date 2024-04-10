Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B281CD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC81210EA44;
	Wed, 10 Apr 2024 21:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nrzbBgp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4257A10EA62
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhCzhmjCK91IEGx5MvSMXpNYFYmsE5u6vjB8uvjTzZz94LfTYKJvPj8w5QEvqlQ37YoErhMYFowRhBHAS1t5ZFnwTl3/yQy92PwwXJlT3HSKYTyQRsTm6qJMWf0HXecmw+RGVA+tp6zZS6u94aEqUsTeVdMln4ThsaPR6VYH6cfdITqyZwJs5LzH75Eg999ZqGuHGl2dqcsd0dOJljqhsU3gYnG4hS1s3XeM64ZXSLVKZMzpNgL7H9EC4RoHwJrsZpRpY/ZRFQ58yiAMru/dUgy7+K8c4zmNWIrH4X6Vm91vAxgc7Pt53de/GU6LaXIIJYAzBfEkywgzSFwTe8flvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqrTz3WCkfz6PcP31g8Bv+hK4o56eFFEpDcgLiik5BQ=;
 b=np+XIbNSNXtqsDtIo1h5nWXbmSuwaiC2fLd0eM6BH8d8VHWJmOHhcWnNxAlb2L0aIY4PvSTiMxQWOl2htFU8LIUWcTIPeyOyUClGo/4FeZjaElVyf8JciVBdMq8/SqYpHTBlD3ThW87SMEg9WXyE7VjL3KaqVWCFsJtijg5iRb0PR2p5XsneKs1Cmz6JHLldNRLrEvxcgAgwjomHqWpH/fpjqaE+tqI0CWWjgHY/14677g6kLB1O/qMkxKRIjnEuRyucZDrKt6DDgqFOJiSZPo1mPHOTY7ZYWpwhgvfuT3bA06ZX1Bpkuddtmgu2kFv0SrbPAFlsgtbeMrf5vXtuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqrTz3WCkfz6PcP31g8Bv+hK4o56eFFEpDcgLiik5BQ=;
 b=5nrzbBgpUmrFTfoWOdDW9J5I/cYd9F3ClhXuPFhq1Ev/CUdw7l/rs7d7W5o2C893rZBM2rdDxYXVpuqIpJ2MAL90aO2ZNY98ezjB+aAoaPBjHZxXXTTUOLbupdv1FAqWZiTB9HHGoxlFLPNw/i8VPosBcgiDJA2AEm7wduFYYKk=
Received: from BN9PR03CA0262.namprd03.prod.outlook.com (2603:10b6:408:ff::27)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:27:59 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::db) by BN9PR03CA0262.outlook.office365.com
 (2603:10b6:408:ff::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:27:58 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:27:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Chris Park <chris.park@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 04/25] drm/amd/display: limit the code change to ips enabled
 asic
Date: Wed, 10 Apr 2024 15:25:53 -0600
Message-ID: <20240410212726.1312989-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e54afcf-a01a-4cbb-bcb2-08dc59a517eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IITfCNiydzWGhfyFWba9sTZGsgagNRxPfBdxK9Qzx6VG0TGFfvGqaE5zRZf/LIA2OQs6dZkSaUOs/W5PDPazXNE8ECTtLuY9ebrRJQITiFuTs80I8mPXpoobsEns7VlzcII1vZLHdtKKVdWphN4vamxlgE/JZeZ1R3DOGFnCGUh4tgWBSeG8vBwPuTfVPeQz8vEekA7sqJUiNEu8B3DVIJoS/693frqGXlVvBdkTMmNDZ2rGe2/PfDss00Kgi9tRiyn2lHiU7LybSifuHWyAMIHVrS8yhSrdUQXwcxASxSoba/cHgbnyOD7hIRWdPlZqwGAyVJjKMI0IO64htr7YzxVPG3voSI32taz4Z3ZdJhROGFTL3uNPwl7bQmM3ZX3XyW1tCZRL6HU/DZbZ6VY/2XNerCUU27xyF4FOt6ryRWEiSCkeLTc/+rL16l5y+nvCr38tqTpR9gWJO1ayCzH/u/l4Ey02IMOT17eKTNAgBCD647zn+JYihh1qA8j5NvKTd70KstHTfh6r6dVDr6R8GWu5aGRHV/1laGaPu6/U1ru+hAYh2+hmAo32mQB//t7zGMU6+ebsTC9wUsHsEmdatAsOsT+sJGrLrY9+O80qwNwnfM+O1EBCQ6iVNVeGrR6VR0W8NidBPEy7Y17DTF2PdXp06WohTJ7XJr+5Hg+DlyO46DxJZ9ztm/QqTKjZ6KlJ1kRLN33FAspvAu+R9HYG9a/FfoU0M8BXY4ocmxF0be676KjGBbdqO5HapeT57r/r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:27:58.4475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e54afcf-a01a-4cbb-bcb2-08dc59a517eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660
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

From: Charlene Liu <charlene.liu@amd.com>

Limit the code change for ips enable to reduce the impact for now. Also
exit_ips first before dc_power_down to avoid 0x9f.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 145cdab92ca0..01c75b66e8f1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5042,8 +5042,13 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 void dc_power_down_on_boot(struct dc *dc)
 {
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
-			dc->hwss.power_down_on_boot)
+			dc->hwss.power_down_on_boot) {
+
+			if (dc->caps.ips_support)
+				dc_exit_ips_for_hw_access(dc);
+
 		dc->hwss.power_down_on_boot(dc);
+	}
 }
 
 void dc_set_power_state(
-- 
2.43.0

