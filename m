Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AFFCD129B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDDDD112E8E;
	Wed,  3 Apr 2024 19:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QN53yobX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6A4112E83
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfXcJ+d+AbtTh5+Jj9pTAgL95F1x0IdT8TjinnBnLmt3vKcnKHIT2sjjyFh/h/yYBPE3RnzmYSQ5vfdqtrGsvpb1UHmpbKrhH9CpuHzvcgNarKTutfsiA+OiXH57R2XTJLeFfm/AaNRx0XE8BZXG2um1X2cHXA6Bs/W4DpdvCZ5MmMqnwRa0+ZT2jmXmuT88ouVQBphtRNmDznUWTmh3PF9ikjimnippDVr+BH6keFG3eQohilIHRzbdysX8pHIgmeXj7vfFf8lnIdevbgVFmdevpT8xWf0xXZpu1w1/M0KhQJ69JnoW38W512FShIuvzu9Pfta6mq+WU9K0fEWf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJC1kAAMdIdbjtZ+hYo8PTCDGtdDaQT02nPoSEX4sRM=;
 b=E5QVztpVFjN/5hABZ6I4t9ujMhtEwvFlzuZw+JtrcQklWXgFTCAMMZENM+wnyUjLQktfxpotkLxiqbof7cjuYNsgeZcCHlR/Bkvw4MKaSdD2zO/wxyxuDGIsijJF3epwjLVsl0CAGCLPLxlxbgimfADDmvIWp8kQtx07vrMKHHKZvxvrzwf2463qIKze/P4J05drkCMSiQ819ydpkLD2tevjfmviVMvSWUAOVlZywRkzuP8ONWl39J/OmTELsrf59sVk49EuZUd8rjsc3T6j0M9h+ufVdPFcAyh/Lz2e45RPOhbaGjfmSeqcgl2XBnNSOkA1d0IKslyhQYHBXcRwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJC1kAAMdIdbjtZ+hYo8PTCDGtdDaQT02nPoSEX4sRM=;
 b=QN53yobX4Y9IVLrKI3MiONa2ZJcIT5pVYM7TyxyRHnliKtQERoX6mHlh2rj1S7TviNTE+SdKsUA1jarldLrAcOiDnb1CAWlhxLrIVpkOeDX133gtKORo6gxRPcWb4wNu3dNTvY69UPgUMaVuFhve7nK/2oUM7ugosFtZBzHCSCw=
Received: from CH0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:610:74::8)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:54 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::fd) by CH0PR04CA0063.outlook.office365.com
 (2603:10b6:610:74::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:54 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:53 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 26/28] drm/amd/display: Change DPCD address range
Date: Wed, 3 Apr 2024 15:49:16 -0400
Message-ID: <20240403195116.25221-27-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5264f668-adcf-4c2b-b227-08dc5417832b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SOkiZqWYNtSJxUx0yG9fS9j2dweqOV7+xb2JH3hERnJzhf81a85PMJCQAe3ZfzcoGAHN8PT5e/kPsP2QzgAgs8mdLIAW1bWP8PcojvKcdNbvYX9pqpUJV/09Ez+5bZYFnX5UaXY8fl/NMQ/UUJMdKeYatFjjPrA23vRxkf+JUgOHOzJ7YJsK+i4cyaXmrX2oTi7F1ivzYEydQF6ug6eDLxTMOXMmXM8QAq5LcHUNwwj+0GENICrHpRts8cA7IkebyFQY1u5KoauGaIu9IjRRABzOeduCSE4tfz6d5JtN0FtHBtdQkB2DP/khdoVLrpzEWrcDSzd3sptBd+Z3oFDWltThe4/Xf1EAm2LfM12/5KAVHidKfTlcH/CL3iuiIdboZfGRSKyFIbvzNrsM1sULDMPKWPWOPgQZbi1aJlqeHUpsLsohbGUjlkDUu9GditWwKXmmkxvY9UkCEbRv/JfY1/tID+Xa3R2O0rdmx3bUj90mbnCx3PsASgn9TmqoyG1kssOdZtSAa5qzW16EeKBwgqj0zQgfAT0EbRcHv35VWkqezosW3Lvk+mn6mmmoX46PSR+r06qlLww4Vi0KLmzD36xiHxpVtYfn1kOGdcuMsrRusgMFZ7YrQw/QiPmJUk1bsLNK0UFZ4fzkO4BzL/Rs6AAo03l8NMpsoM/e5VgvvpFxMcBm1nsQb8DRHBsed+sy6+I5Gi8jRXlDxUUEawX+FfZSW/fk+aW9XGeiB2+JqBUKbuyWwQKmDNm7OqMb765
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:54.0802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5264f668-adcf-4c2b-b227-08dc5417832b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Change DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT with
DP_PHY_REPEATER_128B132B_RATES.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
index c5de6ed5bf58..a72c898b64fa 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
@@ -130,7 +130,7 @@ static uint32_t dpcd_get_next_partition_size(const uint32_t address, const uint3
  * XXX: Do not allow any two address ranges in this array to overlap
  */
 static const struct dpcd_address_range mandatory_dpcd_blocks[] = {
-	{ DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT }};
+	{ DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV, DP_PHY_REPEATER_128B132B_RATES }};
 
 /*
  * extend addresses to read all mandatory blocks together
-- 
2.44.0

