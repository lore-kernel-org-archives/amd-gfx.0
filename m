Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8FECD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300ED11253D;
	Thu, 28 Mar 2024 19:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6VAnc5R";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA81112339
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUTxjErFM0/cwsGmJ3rXTDO8I/icTv2Dv99V3cMeoTDYQtpBRywAo+RKXyUQoAdaa7EH/O/kAerHvqJdSQKEPC6urpApOXx4vAcQxOmaMGdaq6o27LXROt2PfK38qY13M6Kk2AA4rx+qZA0hw6zik+u6TZYt6gNRYFznHbTxfeSabw8aCZ+I2z1WSARfrosokgwv/JQewGoNx4OqANayejReSWY8Zty5EU909upcHLfGu35lni54xjfUTqvswxJimlrlCiGTvYpg/yGaG6/eESMsivzZnt0Rt6U2Aec6aBcgUL2BCY8sL4sO4l/nQZcuLX3ncRR5TZx57bqK+WG4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuNBDh8KPNCE5JFFmpdsub0Xorf87XPmAH/Yx+sNnk4=;
 b=hgEsx1THnwKxKlUwNawqOLtQ1T+7ijM+cf5CB2IR95fs+jDCYXc+0zunco+UG8UyCQK4lADWQxYrOcV8/Q9Wr5HkfoZqWOGacY7JkJIrtTPWhNp8tnCtW6sepQ9orUMTqgjtTCy4nv8e1A2UmbdWEsAFaFgrT1BeqkNWBRDp838tnoEpoMZROig4ol61RkFm6t2Tb1WACHslX0BLz+Kiq4a5a4L4oerAWPmBiT5gLB2fyfjmv28axoWiFKe7MsSY9RbjrvaP6yxpdx62G2nbBEAAILw3iS7b58bo60j7emaLMsJJ7hJvspxmOMc+ERWjqZVHYTRNNNzzsGlFYvhvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuNBDh8KPNCE5JFFmpdsub0Xorf87XPmAH/Yx+sNnk4=;
 b=b6VAnc5RzgNTzH+YvO3spNRMQdeNC7qIM4/3qR0jOS9txqgmO2O/SlGON7ek2pmre4v2JvYKRJ3CIOpeORv8lGcCwmg/4JxUbR+bdW5GzfHTqTRIbCmUUlgn+i9BUY0QGot1FrGzrkx6VPKqpMXqNWfe8frDNlqKQh/febYRi9A=
Received: from SJ0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:a03:39c::7)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:51:54 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::db) by SJ0PR03CA0332.outlook.office365.com
 (2603:10b6:a03:39c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 12:51:52 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:51 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Gabe Teeger <gabe.teeger@amd.com>
Subject: [PATCH 19/43] drm/amd/display: Disable Z8 minimum stutter period
 check for DCN35
Date: Thu, 28 Mar 2024 15:50:23 -0400
Message-ID: <20240328195047.2843715-20-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d732c6b-6544-4b57-0ef2-08dc4f6084a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijhNAYlb+OLtlNXgvpWzX/vOW1PvL6A6lyYuxAMj+VLE4PuqVYgu2j5/a1bVrLjHhpDim3b5Pt15y9JITnxfXFKmmbmaMkJalpPNeQCvtpCfpIsLe3RICYlH2WT0TVZcOHOUWAO/lAvU89waSQ0SrfytyzGK77iQjFUeZPxb4w7UToTU6rUyfRKoPqesMwBbxioeTqHKToeas0QyWDG9Aa9phXn0zWBfU41cRWYyTn3y3PEjYfyB2aND8wNvKiXk91HJMjEymbd/CxS1DMBCzAGugejEHthZavY0HMsbZD5KCO6MTuIhxy+z18mzl3kEFPHSAICrwv7peto1nyCCw23LzXdFQGpD2l1zZr846rAypgEibcI5ltAJKMbKhMduhcvtJBHuFqc+vqtAmA3Cbde/F4boeDaHs+MrrMMg/egQlq9Ngz2o69AFnf8WW3giHlCEunr1vGM5XUccvkkKIBk05W0QzTZLmnYq9TaseHza6qwb1Qx649+eqScWT/w8RV5bH9LkjZXMqKE6d28TzpFZsFJ1QiV1eHIonKXbJiK+i5dmYbqR0Ob9/0E2a9QTKzfsxHX42D8tDT9mWsiikJaclFiXk3abYEiRBrPix9CHFwhnHgS60UGz0T+8BjAnAAm73uOT40pgo5p32h9fJadnjjVltflw+qKplvOxulTIF1DIgAqD4vXTyz2j9FTd4j/Gyv/UrwPT8uUdii7g7+Da1t5jzsaugSPCHDc4nh4QQyTlTgYSZUWwSIW0KQZa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:53.8117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d732c6b-6544-4b57-0ef2-08dc4f6084a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The threshold is no longer useful for blocking suboptimal power states
for DCN35 based on real measurement.

[How]
Reduce to the minimum threshold duration, 1us.

Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index f1efce1bfbec..479641fedcd4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -764,7 +764,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.seamless_boot_odm_combine = DML_FAIL_SOURCE_PIXEL_FORMAT,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.minimum_z8_residency_time = 2100,
+	.minimum_z8_residency_time = 1, /* Always allow when other conditions are met */
 	.using_dml2 = true,
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
-- 
2.34.1

