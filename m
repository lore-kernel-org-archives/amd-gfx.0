Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116B0E6918E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 19:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA5EB10EC5E;
	Fri, 22 Nov 2024 19:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xso41M56";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28AC710EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 19:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We022rcwBZoU9urhe37Z5pQpNsXO0xdJvlHFoxsOfW80VyWHpvux2iDtgbmj5UwldL8ZD7y5NMlGR2UBiQUgMG5ejq0eANzus/uQwPoegvpJYjG7jNf2FV479Ps+44ustzmsKG98HWsk5WpPjRs/IbYXxAkoBCLZQS5lIsteBEPEnmoBjeItmXsrVQGpqjRS4vnV4/fR9UPlGrWU288IKV3UxmnLWoV6AVN1E0MhvU83isypo/KTfq523ZtjzEHLEqBih6uNBiCMC6SyO/ouZsLOwuKhb5R8lSSbpc6ogcUN3T5kT2mg96kcHLq1taHgwXA6cSOEQWIgr7Zbx1GfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQFXB5ub0pX6MqMIZRfVCyx0JvjV/FtgTHEVQLGaP68=;
 b=icjc2vm1lE1Qf+F5GzUPcuo1XPxrpb4g/Kr7zdTTmeYw1HSY8AB+8F9rz7T41opbMQQdoyAsqWKFgizVdCT0ae+j8aUPqAYn1M4USDqUHhdOdPjOkeG8XlBYLOS8iLiWvYFWOuWpYJo/igXeamWaVfH0ILSNZzA1HL+CkfF+12wGEi9QjE5cPz0NdEwArLr1OSeaSVN+HxnQo+mGRJStYFANF6yR68K7Dw9cJlWIhlr/PmOK1Eb7vnj/VTO5vPRTcrqUQlhVnSb4+/n0Gz4Hsonose+StQ+EfMaBq+PZFGxQsc8GL25plMliJrWd2lAvmo94H6comJZa+0/ABx/X8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQFXB5ub0pX6MqMIZRfVCyx0JvjV/FtgTHEVQLGaP68=;
 b=Xso41M56lBjRHwZx0eJCvn6QMadqO8YIrHHSjGvxQF4YNKRyxEbwBxu173qfHMVlPO1kOqVN9UYZKebL9BP+ceRWDmjk8kh6+CUGwG2D+quW2jtQ4QXnvp1O0HN7G+AFuJoHnPhFMVAQgux75KyaoViCaBhcXRxobk79Eg+u8so=
Received: from DS7PR06CA0033.namprd06.prod.outlook.com (2603:10b6:8:54::15) by
 DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Fri, 22 Nov 2024 19:06:41 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::c7) by DS7PR06CA0033.outlook.office365.com
 (2603:10b6:8:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 19:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 19:06:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 13:06:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH v3 1/3] drm/amd: Invert APU check for
 amdgpu_device_evict_resources()
Date: Fri, 22 Nov 2024 13:06:24 -0600
Message-ID: <20241122190626.19305-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 3830247f-3b72-4858-f0eb-08dd0b28cb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wuf75I58LSHpLpi2lAgpBnytNM9Q5b+E8UZj5SZYh3lcYBMF/81PBYEF2Kpi?=
 =?us-ascii?Q?NWSuoSn1VP5BnHCurVcO+VaI9EtovvIwuCxypSJM8Ecp9ttcjJBDgxwUxo+o?=
 =?us-ascii?Q?uMvPBl3NPV1Ra8fKGPI+W81JN+vgTxRaZen3oyp40OyaXGFCDni5r8fsCNG2?=
 =?us-ascii?Q?jHWoXjHNMqGrBlulM3U43e0camU70GPQ1ULoqMRV9pLD1dWW1YkiVZ//6KAR?=
 =?us-ascii?Q?EGWNkMOMRCU4kgQX3NpvRP36aHt52BIi69WMoP41Evg+VYyqbvkULZPsOySf?=
 =?us-ascii?Q?1l+QZHNCKhUagMan1giFJ1NHhDKxeXNkpew3eshWBY31oxkB/Sjn1xvmJLnm?=
 =?us-ascii?Q?hNxrCROnSRmam2ebjp/uwVZAAggt/xtL8zPZt8YJMUOD/S53WchPtkeHsUBS?=
 =?us-ascii?Q?3Zt2Mxi37XfmC8jmHIUdFNnL44oIXb3mgWvQpKqFm9u5fV1IbBm4iTDJnmvw?=
 =?us-ascii?Q?L8iVkiVLyOOQ3I6UDZDMhRoU8EKqDWbfMQRwSaR6sfBrS1v2gJzGQuQ1aaPA?=
 =?us-ascii?Q?9KfuoPehcJN/0xTxqfge5Kdx+lVZ5qF8b+5af7ZTC8zPozoh/IVQ1ts1nfTh?=
 =?us-ascii?Q?ggKaSSdTBhWg5gQntdHxZsQd3rv9GvL7G/0o0i/nLNBEyzr4rp0Hc3z1x9H3?=
 =?us-ascii?Q?cTZec6O7SIWKHaoC2lXo4mqBrsxw8ggqPLfvnt5NK9uUOMX8VWFQvC05Bvne?=
 =?us-ascii?Q?wzGZm5pBFfVPBMrv0etpgpy6NGDcPL4649zosVB6cOSJZYhqc58Xteu6IMJE?=
 =?us-ascii?Q?1GfVdLTBZaIfvguCSo2QE+E6Oi2th7QbSBybX3MgnPhYUDWa1k6ZPqwYQyQX?=
 =?us-ascii?Q?f/iHisARnocWVl3DyFNu783f3xD//rZZWY12uUz/Xs3kPbWqLZ76pU2dl5uJ?=
 =?us-ascii?Q?8plNtDi0FaHp7ZBg3LqEtH9Z5kLcjfh0lXBYxzW/umtfsu0RbakI8+25NMZy?=
 =?us-ascii?Q?/WbxzZAeTHfqyf/8tN4U2HRWaZ2kHySw+Uc7J35YhCplSKAlJwrPnJN0S3Tx?=
 =?us-ascii?Q?uWGYotv1AJp7iX8PYWXd8wH1mq48OhF6cRiXn8z6oQQyrCdPS38AtKTcBS5Y?=
 =?us-ascii?Q?cuYHqLb89PxFfoicICxvJ40gUeAIXNLTWT3P9BV1bGztsmNj0ZrcQC3/Ercs?=
 =?us-ascii?Q?37v/beZjAL3N9ZpEW0oAnOhFnC22DRuWO+3RWXwuPJ/aCPCy4BkZTeYpbb7E?=
 =?us-ascii?Q?dstHnCYWbvIar3c1Kqh0HgrXB8wizgUTYBdBZOwd3GtxLAAHIYNZXAuMPISj?=
 =?us-ascii?Q?fQHWS2fV30oA8iKTTyhbccM1SBWWBvk25Yu+yxFZkfpXkdsrB1Jr5dIZmzY9?=
 =?us-ascii?Q?Uf3iN6fCYZ7vg4aQ8Xa5+GuktM15P3EdMVM2/KeCJceTZA+vzbqWOABmW43f?=
 =?us-ascii?Q?Y/dXAl7Olg2AuQfjLjZ5DYlzn2dLO4Atx+x3PioYfdYO2w+srzgvi3t2Aohm?=
 =?us-ascii?Q?U+4NaVT16M4yLJHRplTMQdMAomTbDmIh?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 19:06:39.2733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3830247f-3b72-4858-f0eb-08dd0b28cb4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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

Resource eviction isn't needed for s3 or s2idle on APUs, but should
be run for S4. As amdgpu_device_evict_resources() will be called
by prepare notifier adjust logic so that APUs only cover S4.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
--
v2:
 * New patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 11d344166ba7..d511ba949dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4744,8 +4744,8 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 {
 	int ret;
 
-	/* No need to evict vram on APUs for suspend to ram or s2idle */
-	if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
+	/* No need to evict vram on APUs unless going to S4 */
+	if (!adev->in_s4 && (adev->flags & AMD_IS_APU))
 		return 0;
 
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
-- 
2.34.1

