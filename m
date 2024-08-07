Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2C9C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43EA10E443;
	Wed,  7 Aug 2024 07:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EIXbU0D4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7679D10E446
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY+vhaPSjcwyh0UbKZY8QEYSG0daJm/uOeAF2mlOTtDa0MWhszAn7XGcxQXUFKDq4t/fm8p+rVeo0YiNB7AdtYkTY3AiLYZ+S7u9NrulhvX5Le9spnf7MI2rPGTU9rxHhJwKvEnvSIccVwHUm9tBMwfPiUY6Mw5QJuXUJ7hn6J4rsn8K3ugcPQBFEt64URvgt5F8oxpR2ueOgXTc00kRuVLtnONZPAlyYmAnahh7RFUX/PBUXwbOBUlOJP//z1s6JxiWwo+g64nZRQxgnq7d9r50pwnepoAKMNKsI0yqTNdGv6lnraqRBwSULZrjJ+ww0RQTsOoreyopHC/4oYfh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rks6ft+X282ZyBfcIxGuQhhkxWQHQVBCKd5BTvt1/o=;
 b=pw3t8IMlas2Qsoa2jz4WcuKMlDS/6ZOOT+n1UQbdxr26gPgM8lOdvTN3US7Vo3JIpLMeP28a2cml/1V4BIz6kAtjIWo2j09h+XP9sQiwkiccQOccV7rGeNmRhs4gMu7x82QHPeDBKtE8Qu7FQXznsr3kkhhRj78iAyJ3WWgV1TNDL1BpdeVfWndBjBHE+nFl++L8Y+f2LGxEi1+D+Ao84J3t7UOdMQ9Yj7nzhjXbYdvFHPhUtqeXyc+yHK1YxluR9EmDzxOgmS9goRbV24JtS2xKNKUCWXpnfYE9X1ewL92mpMBVjgQE4PRxravr5A5FD7c9fOAzCh1MqVfv06Q1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rks6ft+X282ZyBfcIxGuQhhkxWQHQVBCKd5BTvt1/o=;
 b=EIXbU0D4SOqxLn5X/AB+OIBe1CRLIa92v5OatZ7TqRJe7+6wNxSBQwjuUizSnDqYI9XntQhhGi7o/D9V5yC7+S80P1Jg3rtOjZ2JqR4s94NcZT/NbCaj7pAPpBmhuBoMTaCW38L/nIfnUCZs8XKzAbbzX1kvo14vzRLoXKcOzVY=
Received: from BN9PR03CA0686.namprd03.prod.outlook.com (2603:10b6:408:10e::31)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 07:57:05 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::f3) by BN9PR03CA0686.outlook.office365.com
 (2603:10b6:408:10e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:03 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:00 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 14/24] drm/amd/display: Disable DCN401 UCLK P-State support on
 full updates
Date: Wed, 7 Aug 2024 15:55:36 +0800
Message-ID: <20240807075546.831208-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 1880f074-d529-4682-6c16-08dcb6b68786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4V/IpcWwLU61JfF0saEqHTNfUOwS97a493an24Gs2dgp3SsL9iCn2rPP3wEL?=
 =?us-ascii?Q?uZgZrSr5so6JOR4ObxeiG7DAD5EvUUapwI1jisu/edp1x4xzuINzxVgZ3RlV?=
 =?us-ascii?Q?lzxMmWSGtzIyWxOYyOOGj/gF75NKt2wlGZJQuw8DwJ4ESa+Bu8MqhUspnsb3?=
 =?us-ascii?Q?x7+PmvxuyvnqnrkIyOcsUbvNcniDooOfdEoEWmi/b6ixVsvrmdvnHuSv7NRi?=
 =?us-ascii?Q?2w93kpcZNsNdu9rQ/4gIvTduqh7olmgD/qai3q70Rm9KIHfEflczkx7By7W6?=
 =?us-ascii?Q?PqFfM0kDS4kw+/a13E4NOjEFxWHefqCEZqwA3GMR3Wx4Md9lCGF3hR5gA9nC?=
 =?us-ascii?Q?eBIvy98wZaIRM3z90Dm/fCwLhkNsMy5bSEUd5tGtyAHDSO6RRLyzdxpfRcRR?=
 =?us-ascii?Q?i9qzeikq6RxVLWp7Kx5BoZ4YCoO4xILnQtvnC3YOIbJHuLhd7unQFgFIJG58?=
 =?us-ascii?Q?+dKcyB2+8NlkDPMGXAKk65hqcQF2k2j9EkPCiBikoYpWlXgbpo1C2t/i5Cmi?=
 =?us-ascii?Q?Rxtu15nH2nkmFpYj8r8I3qzDBhbUwVF0N0GL72++U/tyc0aIk/AX1R26qy0J?=
 =?us-ascii?Q?Ed1zpL1J87jGcNJV93MWx+mFBuznG54iu/C2faiu/qvB1H5O/rmsYv8BOyPV?=
 =?us-ascii?Q?PiHZONLuiLlkkxChWdzXai21zzPh6wvpl8J9JT4N5yQD+P09/JQNH7/+0pEA?=
 =?us-ascii?Q?AJ7GQ0IR0jBZCfdnu+K+uoWAaZdjT6y4J5NI/kPuI0nUjSCNsFjxR46PJV6i?=
 =?us-ascii?Q?LIn98kPmsw2eLGomd187jUT+m2jZr/TsayS71P2+yl+RvDqTx/AvXl5eZaR3?=
 =?us-ascii?Q?RKOpaAGRp8eURTqJGH9lbbDdgf56a/6HHEjMTmaY88oJaFkSUjnzJYQeUcdk?=
 =?us-ascii?Q?avbmZBG4K2a7UnsNXlN+pOctoa++nJR9bzCbzWfW5tLGgeIVXLc+NnLv7FO8?=
 =?us-ascii?Q?+zKWMXziJ3GlZ1H3evDQWG6vpM2MRifyzArLojXCdJfp4qV23KWghg5VE4Wi?=
 =?us-ascii?Q?PQqB+UxY4f8QM5268dqEuSDtkSXiBndQdDhDVkLV2Jlc/vCHp3H7pmOGf/h4?=
 =?us-ascii?Q?KSe4oWS53KEA4EQ8nX0uW/NujFuuys9tlENWEZHuKEn3KtUejxuPj6D+0CZC?=
 =?us-ascii?Q?aqZMZhcSy8sN4FGNTGaZZNBvzcSkd1yMtYR2ACmiKhWMBkKtVd0B/yCWtucY?=
 =?us-ascii?Q?7fK+p9/9hfMVW6jVbJJ38uvW+02IdwHDerFYTu9BZ9zr+rpiCnlJl6cU8gc4?=
 =?us-ascii?Q?xAj2MBbElcjL3sM9eeV9LyHoIGbjPFOKJU60QLvhN/FSdD990TgsUl84L9+P?=
 =?us-ascii?Q?dxU9rHg4OblHXfhRq2+0GU+wtT5g7oFGvmWoN3FjRyvcq/rDY+uSxjz+cl0K?=
 =?us-ascii?Q?qdJHoRrlYmew+l69yoTvb/nwSRce2NqMPj8FlcRG6RhpSTivRzS4y5Z3yn3Q?=
 =?us-ascii?Q?NiZj8ygVwmy2f1b0+7uqERynOD8IVE1k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:05.3179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1880f074-d529-4682-6c16-08dcb6b68786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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
It is not guaranteed even for HW exclusive P-State methods (like
VActive) that P-state will be supported properly until optimize
bandwidth is called, so unconditionally disable it on full updates.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b604c8886ef4..ac0a21ac318f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1401,8 +1401,8 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 	unsigned int compbuf_size_kb = 0;
 
-	/* Any transition into or out of a FAMS config should disable MCLK switching first to avoid hangs */
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+	/* Any transition into P-State support should disable MCLK switching first to avoid hangs */
+	if (p_state_change_support) {
 		dc->optimized_required = true;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
@@ -1441,7 +1441,7 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 		dcn401_fams2_global_control_lock(dc, context, false);
 	}
 
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+	if (p_state_change_support != context->bw_ctx.bw.dcn.clk.p_state_change_support) {
 		/* After disabling P-State, restore the original value to ensure we get the correct P-State
 		 * on the next optimize. */
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
-- 
2.34.1

