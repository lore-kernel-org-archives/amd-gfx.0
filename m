Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5452C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1DE113950;
	Wed, 24 Apr 2024 08:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iKLxblZc";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62D611394F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxz/3P56seX8bpCzhy3uEXSrjXQPfev77ClWGr5FnyL2dZbbpxtTMG8qT+0j+zY/9ZOKfAKV/wXFE5F6tHparWoYDMq51gzFSff/FCdVDUBLB1zUNaVZNQZHxgqPWi3Ur1/DUkekkNxKq/wVZrGRbFBiaw9Q6Ga7rTuNpAHSPpbCSZWBgl35nsefBwXchCwBLQboz4ub4BtBpSImTfuifdP9+2hUmwLSIHF7YYnJ9vVHta76vjUp2EqP6hrShQ2jxQGnpndLYEEexPrRG6Gsi5meANa7n/2v+pInzW8oeaMrRKgZahfOpn5gVHMdw/OKAwyeYQt+omcACgCH5B6tWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r6tH5vxFpN5/xkvEumu0vA5fm06b6EE+SZo/f2oXZU=;
 b=cxjR+MI/A25Npixyvb5yN1xYIMHllBM2HwXLQHr5TVOHCaJHWcvdRxstZZXPmealJPsTRfQA7WAs81Phh0i4vwvo3IubyzzpINyVrUycMXX+hppf74Rv6TrJVMoKuzAAsy1AgyeX/9DaJwtqdNd1n0Fya01qiojp058VuSslBKbxyquYNha8XP1SCj6aBQ/oNvuyrB2KqV1FJXeHnxuFJZv0aEAuoOE0O1KQfUQD4a9Rv3bbwIjKv3umLAVGGFoKWmukXh8npGUU64yvYQq0Vk7axX55iNqqvzS4MOGUK+FzCXSxx/t28tIrVgClUiOtCnKBMn6GMt52IEXhLXf4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r6tH5vxFpN5/xkvEumu0vA5fm06b6EE+SZo/f2oXZU=;
 b=iKLxblZcJsjTEEgA95ASYCmebj15X5ivqM3Pt0cVq5zAzxFhYhcCEALn6qGQ+X36UEOfd9humRkcDbxHnwijQ4cnTVh+gDNQ2GzKH5+8Z7WBtstfRx9FqzIqCITFNBh7nO1o6V6dVRCPpRg8xENpid4qmB1GKDiy4LzwBo0NxWs=
Received: from BN0PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:e5::8)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:50:27 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::79) by BN0PR02CA0033.outlook.office365.com
 (2603:10b6:408:e5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.37 via Frontend
 Transport; Wed, 24 Apr 2024 08:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:50:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:50:26 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:50:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 04/46] drm/amd/display: Check index msg_id before read or write
Date: Wed, 24 Apr 2024 16:48:49 +0800
Message-ID: <20240424084931.2656128-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 181e1850-b5c2-4689-c2dd-08dc643b9655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EACGSrzRTBNyl5zWeJ26ArHZF9YR1AKYrTVoy59fXBaC0le2rQL7+xmV1s0B?=
 =?us-ascii?Q?pLVKZhpxNRH7CwMJOdWnByWnH4lWpECDxGuRGFV6X14ywFlK9lBKy5ok2SkV?=
 =?us-ascii?Q?hQJhaG61sfg32reJh/+r3z9aV6U3nk22xetoxfwPsn//ERx8KvGRhAOC8t0l?=
 =?us-ascii?Q?1rNdgr3i4Pdrpivhr2p99IANv3SXFsEa++07y46DGJQdE/ciSOQgeshbWwWd?=
 =?us-ascii?Q?LE19LQ2Q9y/gSeD/oUbChP9KWvowhGtzy0cDN4jitH6UnB/aVWPwrp/Y5bhT?=
 =?us-ascii?Q?grcD+DYDTC1JujY23RnxZuOMjHHAxzTpOI8PzYfOKNqzZZpLKmp5A6B3HTEP?=
 =?us-ascii?Q?28B0Sd3ZvStHjDMInHEcCOinXm6qiuD4GZq8DkrhYoBA5Svm/OqYs67YL+Z9?=
 =?us-ascii?Q?ZUG5qL4NTtSiln1AipiZJvAKi9nTAgkpxXvdEmfkBMv74gMQV1Urj6kyeR3a?=
 =?us-ascii?Q?3xWRY1rwKVceXxK6iKpq9cUrVmRK1auMcpt2OIXdh1sTzao5TXxZqPnkAxCd?=
 =?us-ascii?Q?Ecbm83ys3LuCjuTgC0rpNwcEDFuVQzTNvDDiez4LVp7XioWieYjP+cxD28ve?=
 =?us-ascii?Q?5p1kjepOPjIStHAYRZZ1Ewx5anwbB7BuD05uHluagYs/8rQjEh8leR8OUx+y?=
 =?us-ascii?Q?/OwJTkdAd+Y4q24hsC1+d56D3iyjshfyNvbYIDmPhwNTeeU+y0rTAjI5lAD7?=
 =?us-ascii?Q?i1ADFW7hA3Ph2l6utXRVPJWGD2mKfx7ATrxgR/pCFWimBOf2wBfmF+FUA7vt?=
 =?us-ascii?Q?auSoorpjInBD1ia9MSjoz71tdhCS+5DjNKJar+iAqhbOsCzLGoGZI1QCw2FR?=
 =?us-ascii?Q?M9vqiUOSSg7C6uuui930FzjgvexaAsKodEUXT3hQTNPgyAFeYljcXESllqKh?=
 =?us-ascii?Q?SJmrBDowM/wx05Vt3tpz/7f5psipz7n9vUs4deYgNtGedZH2WHIrKeVMoc8O?=
 =?us-ascii?Q?iG7PlrIdz7U2K75AQKGYVxY6kIyEuxadRW+ImZxSXYbssd+lKq1SHsjiQ9PB?=
 =?us-ascii?Q?BpqlVYV4T/aC0oIjpfUgRSi2JzbcZBltv62FGI/8gT7GMZSo3qThK6VNG8A2?=
 =?us-ascii?Q?+k7fikjLu/qfAPVCyEw33C7KlXxZXLpHgP+3l9xrPyV2S7lw03eIKf+wVhgg?=
 =?us-ascii?Q?lCFPdO77MqbRbTFD7DfoNa+T2pnyl7ZnVVVnaTqQ6KCp03N8ZsG06Q+R6YHp?=
 =?us-ascii?Q?HfVUx9fA6IdMpnLz9vrkQuu8qA3viyBageV4zw69vu7IYam9g0yAL4iG4nyI?=
 =?us-ascii?Q?BsePkgWd/gUvubMLIsHUuC4Slnyrie6WDazpBEPlsRTE9AOGAPko0kPscQoY?=
 =?us-ascii?Q?zwiIMUYF+oapPHtEexiZ2snkApVqbgGEXECAtUPEUn4+aZXHTH/LvxH4gIvX?=
 =?us-ascii?Q?6V9Fs1LwwMRJsDUVDm7dA/UMA5oS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:50:26.7350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181e1850-b5c2-4689-c2dd-08dc643b9655
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
msg_id is used as an array index and it cannot be a negative value, and
therefore cannot be equal to MOD_HDCP_MESSAGE_ID_INVALID (-1).

[HOW]
Check whether msg_id is valid before reading and setting.

This fixes 4 OVERRUN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index f7b5583ee609..8e9caae7c955 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -156,6 +156,10 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+		return MOD_HDCP_STATUS_DDC_FAILURE;
+	}
+
 	if (is_dp_hdcp(hdcp)) {
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
@@ -215,6 +219,10 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+		return MOD_HDCP_STATUS_DDC_FAILURE;
+	}
+
 	if (is_dp_hdcp(hdcp)) {
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
-- 
2.37.3

