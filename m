Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87970C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 11:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29F6F10E21C;
	Wed, 19 Mar 2025 11:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kYeC1C6L";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB8310E21C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 11:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl+/h0Q3bzE0CP/XeKqS3iOgaeE/ibIDgHyE/nz84tf/VelC/cNau4P2ttQJ19Haya9LscgfQ54od7w3q1vKbdL8fPL8iSif+HcW8/abKam/RXP0xQoXpKKHlNSFSKKMGIfM7rfitJXrzfC7PEy1jxIfR7/gJKq+VilJ1YGtIwRAcBSGdgw8BPboGwzauhAFM60JO/476yJsnWkSiJ/hXAQ28IU6sDpqy3ygiqDApJcF7GAh2wxfdLNEM76wuna8Qg4hmaTMxADZQsIBFrUZsuyqLYkZksADMwgL6jN9LfJ7UkQy6YpfPuF3tJt/oCO/oyl2MyZIS7QbNNsGHgSzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djJTdTRb1fv8zAJsBVb30x6bHmEt73bdboSoWlOwHKQ=;
 b=ojAPX/DLPiZGyi8vq6zLu2JFgBWbEajyXeWUlJS2bugZy+KBxc2Pvr6xrz+xIAC16F8fvBXCt7vRqnygnx3F8+/3xYAVQPiv2YpllIYCwyjtK+XqomB7oITKzOae7YCos3LiuJiSybsXde7VdQPxvkjr9yUm4IQqBRz9kBkiRWGcAKnqeSIpFv6n7fC6ZTuy4Oa4wYZNcSVu0pRtYpMMf1cuXUp8bGuIz1du/5qNzHyInjtd7sXUFtUudk1UYiDLM7K/T4zBshHvXACw1JYGBjWwuMeqZYhUXEQqe8a920ZXS97t/XHGPrDxsFol+ac1Fvoj8TL3W8/B7Mn76wvDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djJTdTRb1fv8zAJsBVb30x6bHmEt73bdboSoWlOwHKQ=;
 b=kYeC1C6LzPrCgb+XWLgw8jOrjaOZKai/oLbW558AXiaBwKRAZPbWagVmIRK33PWTwCoctlAlD6ikk9nPWlSjAzShXvmDPxSz24erbAhwpVzVWvFtyiO3jDh0yGtdEaF6CtdpzQ3C0coGpEhXydv1EzlAbIr5V6jVvu5FtG93c34=
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 11:12:45 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::bf) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 11:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 11:12:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 06:12:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 06:12:44 -0500
Received: from POL-D1-DKASZEWS-WSL.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 06:12:43 -0500
From: Dominik Kaszewski <dominik.kaszewski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amdgpu: Fix typo in DC_DEBUG_MASK kernel-doc
Date: Wed, 19 Mar 2025 12:12:43 +0100
Message-ID: <20250319111243.14206-1-dominik.kaszewski@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: dominik.kaszewski@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 877734ba-0293-49b0-3ba1-08dd66d6f992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EfpkCUj5f4sK+J4+6qAEc9geJh8c5uyB8PNRv+uyIi93XALqov7X8lTa8vtv?=
 =?us-ascii?Q?bGqe0DfBtClZrtViTHyzdlEP9e54HxHuKUO/0i2SGgBmkx7yNaDKikPdni4A?=
 =?us-ascii?Q?BQXjAIITSkaVSawfd2UQ2GuatN8mrbtvfxJWkHDe0Ow3sYoyLDC/b4lD+gku?=
 =?us-ascii?Q?ZJ+68iRbqvlTfJiXG8SGykalQB0kaSU7QRaFR7bVk/GIABc4z628HzuQMeNV?=
 =?us-ascii?Q?nQ3SjWkMmg8w87zLbo4foXTGVf9OS6C4ig7p+9896dgqtVLPt5uwGb/Q6p92?=
 =?us-ascii?Q?JCxs6UPy1NxfQ6tC82h61kEScrxmh7Q4xDxvhEWODN8DaLWDG/va54Yp6ybV?=
 =?us-ascii?Q?gPA6ocAMcWeIodugR+mJQZao5APCIZuMDCCv8rJnWiJSavFfIFmscd7HSSHf?=
 =?us-ascii?Q?E/4bQIfr08e4rQWVgEO32ZUqYhc8UcwdkGI9x2RGrnR+JjPnmuXbaF/9AsYq?=
 =?us-ascii?Q?DRbeA5m2FzGNQDkf9lpubMtyAhXyYpbFlsdxzcuCL/XtjXRfLgraJTaR+bUi?=
 =?us-ascii?Q?+b+db6/SPReks1FNzVFN7E3ITJ2Rii4a59M+nMkARU04SqbbpKGkMlD4bZuT?=
 =?us-ascii?Q?nx5kYvLQgwozcgtEDRVeEC4jqP26iEGaoZ6tSsGNXv2iSA6beq7cIyJUP4n+?=
 =?us-ascii?Q?fuGiCqnRUJ1SIhyc9LeI/rM+p6XbHddyI3Ux/7oqH9zIrzfIwLoyXECy54mc?=
 =?us-ascii?Q?bXm9MrfrlRL10o4aMpgkAnX2+3tUC14+jJy9o+vooktl4SxqLxUSDZjc04Dw?=
 =?us-ascii?Q?NixvrXhTtT1LLV1SMvQ5i9TPIj6PMiKEbdXfPA7NDyEy/7l26dm9J2KNJVvL?=
 =?us-ascii?Q?WH01wiRrAppoMwl+LmI6bgRiXlkNkcEBJbnHC4dfoEaL9PKpUoh4G6V8CdOi?=
 =?us-ascii?Q?eMWQ7qEqa9G4bUwW+XZOsFAZHrt3+X1fuOgn/+lHRjzINFORayawGYKz9JHg?=
 =?us-ascii?Q?MSilFTvOMxLKLU0mQv0W/XtYpxCCHaSABOl1GRiO3M9XtYcTBmG1512p6cFR?=
 =?us-ascii?Q?Fe4iEIvV3lFJMlO/TPsa24tGVtAfZARSes1lJIAMlINVjrO7Br8CqJ8+Mba7?=
 =?us-ascii?Q?UyIwIMg14Q+paxHT/5PcjzSNgt7qLINteRvzcWUfq9K3JAkXlYNO4C0bUs/0?=
 =?us-ascii?Q?MICdrIL1WuKC4Xlzn7kxuhLpArkH0V14zRzR68jF4r3eHbK/P+pRxUMhF3E4?=
 =?us-ascii?Q?te9d4+MObKsCtTueYANL86qhRZ7syGuzoK6ld99iJ3t0FVy9RLu0un3JJlaP?=
 =?us-ascii?Q?Bl26BMuo4ygoLHCD0ZJ/3xQmz6wYEhJ2e2HyQb4ik1PbAhfpDL7K52v+w5y6?=
 =?us-ascii?Q?sZ1mtWZZipMaaxvhiRaNIvVBwC1VptZTJIRirLWkvsFtOqmDCvUpJWxNSuIG?=
 =?us-ascii?Q?0dZy9x9L+KL6+xG5gbAuF2GDVooBa2BG5WaM8yY5BnHPmbJIxupPwXQ9NkMT?=
 =?us-ascii?Q?jXnegVM+xDtIvmFffBLutR+d5lrLUFpt2DODsFjzBMyCswCZdVPs85gBEcd3?=
 =?us-ascii?Q?DD2pmki6Qod640c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 11:12:45.1373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877734ba-0293-49b0-3ba1-08dd66d6f992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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

Add missing colon in kernel-doc for DC_DEBUG_MASK enum.

Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 4c95b885d1d0..c8eccee9b023 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -366,7 +366,7 @@ enum DC_DEBUG_MASK {
 	DC_HDCP_LC_FORCE_FW_ENABLE = 0x80000,
 
 	/**
-	 * @DC_HDCP_LC_ENABLE_SW_FALLBACK If set, upon HDCP Locality Check FW
+	 * @DC_HDCP_LC_ENABLE_SW_FALLBACK: If set, upon HDCP Locality Check FW
 	 * path failure, retry using legacy SW path.
 	 */
 	DC_HDCP_LC_ENABLE_SW_FALLBACK = 0x100000,
-- 
2.43.0

