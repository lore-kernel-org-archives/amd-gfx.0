Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCE3E74AE0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD4F10EB79;
	Tue,  3 Dec 2024 21:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zy455ch6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1682510EB77
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7sh6Qar8cJ4nrcEOwqHrb4zSjyLIYsOys5AFcZvXb1Nc7KtFppLSe1bFzXSFBuscKZwu0/vAGlixzqFJlHuTGpTOcj2oK5F8TPqxxL0Zzhl0QLSOKTrpk2Gb7cnE09c5oREin8/z05DdL4f4rZi2z4eiLCZQSBBik3qYYscK63YpebhzpICGzvgagIzfMkklBFbTsiNy2DjqxWv0e1a00Uz166hMtzrA15MlspotJ6mXs/euszNSnUvQxO+ZAsnoOIau250AmDgomieGbJawMAzJEYlpmK47qp8PFegdErR0T+8hLavLclPLbSpWxsXLGOr5U84BdvCIe22IeaeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBM/pm3lX8EzDRNFYcwzzEGYizFblAWrAX+QN3tTi5s=;
 b=O6TFUxGQGXFOhXRyfbMmv16VLdQw6oz1qKhnAXMV/tpGDc/8R0xzfabU75fU6plobcjnJMwklteVaDZQ3/5ctA8WNt/SekH9inPKluCGF2yBAvA7WuYqMHx2wmPD9uGDRMS3qYxL3jwL01s8zppPZjuC6P2GIvEGkEFQkT/My++vLHr/AKTTMf/ZLUHInO5+zzH2+xErmon2wK3h+zZf8Guqwvc7DW+EJxRWr0mj9zTgXeiC58R/Zb1WCvPJ7kb13jpTwyuQK+8oUwOf/4g2v0CkHCcoLhVhVRdB9RxEQ1v/+yDjPGVyNPVPKc+dsuc30LETJDeZQtMYmfRL1Hv0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBM/pm3lX8EzDRNFYcwzzEGYizFblAWrAX+QN3tTi5s=;
 b=Zy455ch6xl6jKZC8HpWBmSuPHy2LXmZxYsxT3FLhAPTUknPrH0XIEZuVCwiVa+jJWaX4XkC4zMtRWLjOjfWUn4QO0HIuSIrlRQn3LxVmO4vcoTX6xoA1cTTYml3i+4F42yG8xbk0Dv95mm1QzD+wQdHj5QzbgUSzQId+Cpst4mE=
Received: from BN9P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::27)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Tue, 3 Dec
 2024 21:41:49 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::1) by BN9P220CA0022.outlook.office365.com
 (2603:10b6:408:13e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:47 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:47 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Zhongwei
 <Zhongwei.Zhang@amd.com>, Robin Chen <robin.chen@amd.com>
Subject: [PATCH 16/19] drm/amd/display: remove clearance code of
 force_ffu_mode flag in dmub_psr_copy_settings()
Date: Tue, 3 Dec 2024 16:39:54 -0500
Message-ID: <20241203214120.1161810-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: c7429f09-b33a-4c37-a14d-08dd13e34aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MzulMmkHcsQxKhJ/3C/dJufSdq03/HFSKhjHAx+HPLbu4KqUUBHMl6ugDz+l?=
 =?us-ascii?Q?B11NJjzNlV9AZ1g7GVGk08AV+MBVvkKkSVmUPolKFw9BnJNYfDLL6pqm7cow?=
 =?us-ascii?Q?LRDhE/842dUC9kQ6Z5p5irfG7lSqHbIh924rV9wYm4n0nEBGWP71k+akpzsC?=
 =?us-ascii?Q?+KI34f0yLAtoOZNVU+lD3mnSv7eG+/HJX/ldPq1PAc7oQGhssMs21wJSLCJj?=
 =?us-ascii?Q?FWsIIPfA2gvWOl4rR/8F8Bk8/0CtvtvYnhqU++dp6TcNX66AusRacMh3/mpF?=
 =?us-ascii?Q?n5s4P/YhcfoT0qZMhJTOCxAxVkKtQxSv2Vep6jkT7pjCoVV/Kj6XUxDB8FnV?=
 =?us-ascii?Q?osfJwCyjM0AdVLFEWuQd7SZnX4PIS+4268nRMKEn90iMb2u46mVNt3a8qoSn?=
 =?us-ascii?Q?c9+/nN61wmOW5xhdsmh8VafakGGIbfHN4ZPGSllKki9pJC0DHYOB4R0ditqX?=
 =?us-ascii?Q?1/pKSLhwh7LALTqMSTgC2a0Yl0y/cll3YMTThqPTqtZhNiqADxy9zKjrZ+Jx?=
 =?us-ascii?Q?hVAHGYdiZ1KgwnG6pK2pkmsn9MDWx7A+qRdoZn6m83r6uLp3AWPqjLjrejml?=
 =?us-ascii?Q?eludmpo3lJnGo05PaaV6ODwZfoIzHxIzJ1zP21h17Nyz5BTjtEq+eVLesFIM?=
 =?us-ascii?Q?sFFh0ZyKo5yNSnjwq/Qa2WFbdEjH4q5cItem3vTFmg9AOnM+amnfHC23HAF8?=
 =?us-ascii?Q?FRIGkpKWwWNFFqUyA2skQ475yWBaUV6wnhvZlWLcgd3alY8tLHSA3SrCicCK?=
 =?us-ascii?Q?MNaM2+7uIT1SzEYJNDSZIz03UHq/eh+sCGZtT2O5g3nUKHXYDxX3ymY04AY1?=
 =?us-ascii?Q?vgGnEjIgzpF1kIoaPL95wy/OVqy1yFkhHP4JRGt6xm/KvJRdB22P2A1plp3V?=
 =?us-ascii?Q?cxh9zumvhxSMdpKvKdvUbEJVQYpCdia6HwqZ1SmEJrftC0c6kJXyAsOBcKou?=
 =?us-ascii?Q?BxY2CSl8F2UeKJKklrbmGNv0giocCilt8XYZXxmTYvWjP/bZDpOf7pfW3p69?=
 =?us-ascii?Q?jxm9B9F3itrhjyQBOX5jHooTiG3TszLyhYteKMsAWf1MDzOrh/QuiWf31A34?=
 =?us-ascii?Q?OEk/4W/unYQjVjZGz9dHzApZLvx1l4kewMmlgrQFzTb7SdcYygl9ztaIN2WI?=
 =?us-ascii?Q?x/u8scY1OMPdqS94L6XvYYkLonk4TnecBkG+Ye0pHXwYT+Tk+0Lgm7bn3WcE?=
 =?us-ascii?Q?RIDLpXwYrbyBIuYnVEZv6uQjzpXQXbnFYB6zN8UbRPI4Of5ZEdYjB/ey46Js?=
 =?us-ascii?Q?28lYSiNttBF9jrCdxmdC+O0yusEcY7WBarbldEUyGRYAkgzX2fj87rch0Y8+?=
 =?us-ascii?Q?Tlkcry++m/SKNA8VQ3XdUxud8ZcYxA2SUGmyGxi4EcI8ZYA2ligrNQAqvvW4?=
 =?us-ascii?Q?PfTzJ6o7xsc17PdHQUEKaau3MOgTJxn0BCpQmqk2LYnNIIRDiE6hrSrHyqAr?=
 =?us-ascii?Q?sDxn0kYAqHMI06YQSuBM0ONCta1nzjf6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:49.1575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7429f09-b33a-4c37-a14d-08dd13e34aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
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

From: Zhongwei <Zhongwei.Zhang@amd.com>

[Why/How]
The force_ffu_mode flag could be initialized at other place.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Zhongwei <Zhongwei.Zhang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index cae18f8c1c9a..88c75c243bf8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -390,8 +390,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
 			sizeof(DP_SINK_DEVICE_STR_ID_1)))
 		link->psr_settings.force_ffu_mode = 1;
-	else
-		link->psr_settings.force_ffu_mode = 0;
+
 	copy_settings_data->force_ffu_mode = link->psr_settings.force_ffu_mode;
 
 	if (((link->dpcd_caps.fec_cap.bits.FEC_CAPABLE &&
-- 
2.47.1

