Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD1C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 06:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4AE10E464;
	Wed, 19 Feb 2025 06:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YWOhCv5U";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79B010E464
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 06:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqFYJ1hiG7djOGgUxz0TG6F3Dwm4EfXQ89T//byv6AgtfTzEC9JhGl5/kcDTUoqiKRVPo0ziWidosJN3D3C2ByPccnkOG7zGFotEOP7/Lpa7TuQzn6mfAP9rlxHKAeFBHArQUlGIu6bBQ6Ds8/KQJxzMZrtHdJuPvFwb776mSzyeQNAa/OJYGeoE45RFT3IYz92ox3BDd7Pkc3HTmY6Ukm6ucatTLYf/coKthbpqA/To0L44jzrt1fnLDC2SjwXeMwV2s+BujyEcZZKd4FmTrHhUtEGUykTs0spQ6m72X/N10DPZKi8Gl4n3PQcRAGPpagZRRObzSI+IxJACucDTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42QWLPq70Rp2vUwXfUiXmTSfUtQt8hXowm7a+9OC/68=;
 b=gGKtOmnovurEpY9QQvag0Ph1kXj5cxv+31sIp+QIqMcq3vw5UllAkZhS3IvysuAZeQG3ZqXH2/4gbwSpIh9iN1Q+AxBXyddI4KMVxVqbL6K27YLEdsv7S1WbaFnFgVkGII1zL1mtP+hjQ2gv5LOhQLXZgzCw3qPciGWFF+LDFpMXzNPwYmKy2XnKBNBcF20+enoYULuujsrG12cA445LjKBAo3OP6EmEJZTxSbNv/oIwUpkE47lTAv/0YeR9fe9AYlchCQYSrFZVMs9h7I5y+VFmPuMjrd+2CBiqFOodSIXabRfPuYBF8A5r3K/pUO41/Hhpp05jyVdkrVAupmaMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42QWLPq70Rp2vUwXfUiXmTSfUtQt8hXowm7a+9OC/68=;
 b=YWOhCv5UT5Z4RPcz4O63tIZTeV1Puyus87Gy04VgE3XyQHUGSy9WMl/9GP9/H9lesJUgkI7ulbBuyXtvFVzywGdZnq979+gXomjA0wPhXe9MPxerYcijxzAiQyxYzMbhYqzvT6IzrrGigGUUiWaxX5nxGRvvsD/7mi4SWM/YOkM=
Received: from SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::17)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 06:20:49 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::92) by SA9P223CA0012.outlook.office365.com
 (2603:10b6:806:26::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Wed,
 19 Feb 2025 06:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 06:20:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Feb
 2025 00:20:47 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Feb 2025 00:20:46 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/amdgpu: Increase max rings to enable SDMA page
 ring
Date: Wed, 19 Feb 2025 14:20:45 +0800
Message-ID: <20250219062046.3530422-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c411b7-b6d8-4575-f51d-08dd50ad8d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4/JkMWVEL+UcpTQL8Dcs15+fvRQA+TUPSC9z2f7lQHJ8xDcx5oEPjYkUOgmz?=
 =?us-ascii?Q?n5hvMZ9RHDFTGdyk6SGdQLNNp6lxUgeUGpp+Y7E5cv+Wng+/69upW8oVNxlN?=
 =?us-ascii?Q?YTnIejIqPGLz97KlgE709eIGdJjRHIFIyS/+mBxMdPoA5Iw5EOl1mPlNJ+N0?=
 =?us-ascii?Q?ABFimsW8XdCvHtZrDALqxnPxsOCVDwwePEycx/cyqoe5fHXkIQ11yeuUjIUh?=
 =?us-ascii?Q?XTUbVoMb0GFMi9jQ5dVN15qT2Wy8eig9vn74WRccmDQxgKuLcIwvsQXmxZQ2?=
 =?us-ascii?Q?+wX7/sMzJgMYNwNfb6ftHYCpAyTKRU/eqxXwhuC6/dhVJMcfWz6HuobL6ohM?=
 =?us-ascii?Q?Y3ZDnepgQS1rTM9pLUt5xWtD38s9NoWZwK+yNAhuaKvtH55dpKOyAhczMB5V?=
 =?us-ascii?Q?//3XHa8r6UeqcNlEYH9JHf7k/liQBbiHe21yaMwCnZ3zggQLnaR8SeJ3LnUU?=
 =?us-ascii?Q?mEwyC/CXE6bEXD1ZlDHxaR71b0O9BoVZH9Rcwg9NJA0Y/XWHxLl262Z1I38B?=
 =?us-ascii?Q?B55QcD6zArUTDz8U1ecwH4B16C1aFeq95CcyKIChDRDYPIawpoNjJVeGu8sC?=
 =?us-ascii?Q?pNucBYvGisj7se8dhfbBomuPuEb+wXYIa/JJKhfcw14nFATh4fcgvzWsRBpC?=
 =?us-ascii?Q?xCjvXirZ4jp+Ok4uxd6gwzu5ucxJKPb3WaCk6kyuG7RSskLQb71J9RD6o0jg?=
 =?us-ascii?Q?ztqCksy/G+NT4bvFZd3MH3NsZCF+FL9Fz/Oh3agbr7Ps7DAy1VgueVkfHQJa?=
 =?us-ascii?Q?PSBjxUWGSESyKtSy3Uc9oJXtIKp+qd74MwZ0z9NrKQBKr04kLJDgYwq/nusx?=
 =?us-ascii?Q?H4iezqES+JwtXpgJC4SsCs+20hVvkxkxC/vwl0txXrRmRl1UhXQl2lejMztq?=
 =?us-ascii?Q?5pOxg9OQd4YHJBhBOGVDPayH3BbVuI5PhK999qKYSV9FiKhMe04/YnNJKi9M?=
 =?us-ascii?Q?DhsIovVHq+4+kxH2p+D9cttuEjoWOutYi9w8c1KaosOI+3+bX8rfx9DTPzO7?=
 =?us-ascii?Q?uYTMIjeDCmhM6R05uAUR0fSI2Sg1Mx+9Ofs8RIy+RfOmO39NnCfEDlJL4lmp?=
 =?us-ascii?Q?fDmjt6WObX0UmL2CXhEqo+iz4mhQbDAQDBpB1ysKF647wfscHuYsPWYJ6FAU?=
 =?us-ascii?Q?YMGVYxMumjn2Lrno5LnJm4GoOaM+tNxIHHo7H1mjeED0ynjwaMRh97GCYr6U?=
 =?us-ascii?Q?u9pDOoNnh856mo2dtX/03FDtnQ+DdZ4PpOggG2FDoIpS19dZD1jZCCl6mr+7?=
 =?us-ascii?Q?y0oUnnDBR2hB3znPlKAyWDujfpLWWj3sfPeCfWkLUHtZZB92gHcmQZC+8LUd?=
 =?us-ascii?Q?2xylVXwF42nO66oLS7sYN0byC5bS6/iddodmpaVmxK8s6cEYfSalzdWyr6NH?=
 =?us-ascii?Q?H1Bo0kGs6BdPuwabiuWeOc6hJj8oCEnB28mRu7uIg2FeZLpUvJRAaSE79IwG?=
 =?us-ascii?Q?T1cseq0cQunJricUz7HKYQAjArH+ZAHnNHmT0vrQkQrDG98+SLmahDNatLlT?=
 =?us-ascii?Q?f+SGgrcdE8Rq+U0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:20:48.7203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c411b7-b6d8-4575-f51d-08dd50ad8d60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

Increase the maximum number of rings supported by the AMDGPU driver from 132 to 148.
This change is necessary to enable support for the SDMA page ring.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 182aa535d395..ae1dd7d16048 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		132
+#define AMDGPU_MAX_RINGS		148
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.25.1

