Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC0CC9EC88
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 12:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0223310E3C3;
	Mon, 12 Jan 2026 12:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ss6Tl0wr";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013038.outbound.protection.outlook.com
 [40.107.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F5710E03C
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 12:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LITVT8Rfmuxd1LqohXx3+hF5kBSHbm37rZrL60ZO/yHog+2HmLB9JYp4EMro3cZRQfjnJPo0xkCtG8GdTaFOQ7nGieQ/SSNsKLZBJqMpS2B68SJluvirYWAm7047V0XxvEkwP+uJMGI6U7bv34cATM1/cDp/4ThkQ/ee7nwKav4ihayVB4YY12wV9RVKYfDC/i6fAAFW+j9tFq8kQsQzxXzeId9OUA8bq3m7grCmxHvtg4K0FituOSyAzzAFzxCH4keeFtDmAqD4SJXTdA+Ddupb8or+iANJlAHyXpYPIRJNc+kAnnsIPc3cT189k1TI/bFuIm/APqUZ8vY8rlXejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYQ3fSnJsVbV3puLy2n0ZEWmHxhnpAuZ275px9O/m4s=;
 b=Km0vlZYtckfxddQAWKtW13OyhKSJ5aNF+sHvDTpjK9lHRPT2p94dA4k4maZy0ec9PwoSqugBzsRs55Gy31UnjvBbPKdCElHMA4m+9TE+11WUUwmqFo4kTNR+qHSuyNyQCrA+HorbNM4m9K2xrPH2jjLokG/uxW2ExXIeaJ6wmVxRgv4fVH6VjjFOqaCXnVP/e+YqVghWkCirXfWiZC73crwUST4J+g9tDEHh1UJmZi2C8DnGSH53Xa3tK3APyM/IcCng4u6jgLnyOy/neEstkWwYIs5DfXpJzlGawZWu4+1SOS4v8+QzyA4nq4b6ea+Y4w9qAvsFKfk9a8V8/4ZWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYQ3fSnJsVbV3puLy2n0ZEWmHxhnpAuZ275px9O/m4s=;
 b=ss6Tl0wrroU5sStpY59w3CrRUE3boqR+Oy5Iyzq13DgHGubPkLp+AkubO3ROqIvwZB5rOSsORJg73lzMYZGzk8zy82xIB/nH9DSJkQsQq1a2Gir1y+y3sj5sX+T2shgRA2kXvQnH9qENegecGOkSAl/ciyVO+CSUaZkA3wjiMnc=
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 12:55:04 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::90) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 12:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 12:55:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 06:55:01 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Deprecate print_clk_levels callback
Date: Mon, 12 Jan 2026 18:24:42 +0530
Message-ID: <20260112125442.198976-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260112125442.198976-1-lijo.lazar@amd.com>
References: <20260112125442.198976-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: e33488f8-c197-4227-d337-08de51d9ce19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HGLs0gm2HEnTIh0y9FtJBd0Jay9ely2uC/cDGZzqFZCy6WzAfvymwH3eTr75?=
 =?us-ascii?Q?37hdCQIm+4BwMwAM7ZQ5VgtPRBJOL3jPxssiWytpSeDvsh1TzoamwIygKS07?=
 =?us-ascii?Q?JpDx58HcIg9Ypsqj8WR/UvBNUhUzcFZSF6rejifW+4GQobUNMcVJtl7HxooO?=
 =?us-ascii?Q?95mCY/eHxRVE90fDvDH/kdho5FX4VlhSF+D2nUzNcPozNXgEiKv3ADN20yhw?=
 =?us-ascii?Q?OI1aix+JLqKX7oTIhqT1RCz6jIVmaS2Mtu5xgL2FZcEDZl2+K4zVeZ+WLqpb?=
 =?us-ascii?Q?WogHgNhBvvLeGT0G0AfA7GikZPlQiStyG/Xbwf+wA2+O0u5lcvFUhlqmV0bS?=
 =?us-ascii?Q?hCTbLE8eJOLUV8oc7yOyqp2Gmf2IAHs24PpzqAwsaWXuUCs4nVXRcgHMsEn6?=
 =?us-ascii?Q?RlR5tQf2QVZOECJLuPnqA7wuYtmCMEP4zxOxaP+BSipl+EuT6xNqt0QEeESB?=
 =?us-ascii?Q?FeInlzRkWrkAKXkQtLFIkgCxTRVq8PH0Di7BRSLHJ0BQT1c9z967VPQhzlcr?=
 =?us-ascii?Q?uXxTXbcAyZiavPWkqTZ5YdJgQsJ3TU+zHmISgIGBMM3HCr9d+pt8RxCqEPS/?=
 =?us-ascii?Q?9FIFkzqGFIIU8nvCOMD290u/K90OwOotsCqr0LoyWEzSrayNL9q/4EUxTrR+?=
 =?us-ascii?Q?OFJL/7PWbig9a+ZNOLNC603AtuVT0TtDj+xqTFq3z9sVsd6LSCnlM2APrsWN?=
 =?us-ascii?Q?lDuD8TSKa+VOv+F69bmTwJ7vYFj34m3p8gVQOR17Wx2NNwrshNGiQax85+91?=
 =?us-ascii?Q?JS59NrRSYkhVvApUXJpJ2yWIJAu6WMVWvKgd77aGTlzyIpZW7wUVlxWNjSni?=
 =?us-ascii?Q?xkNKZd9UObLp/sXgSOE4Q97YeqWwt94R/ZHipXlS1JnchaduRi/p/QH1Ls3t?=
 =?us-ascii?Q?VYzib6aFPxuChFt4ngtALPOubdlGw/9fF8KZt0ZR9mDXqRuRTWvcUy04wOn1?=
 =?us-ascii?Q?9nBWHXTg7ihr2WHRdt1NqvcqOmespr5AnDLbcJ4dHQLY9404FzEcWPCUOEcL?=
 =?us-ascii?Q?lLhpWKweNbj2IIF2jQ3XuHR9ckJ2k7ho+rjIQMG7uEy2DzfI+J2S1gdPjzVL?=
 =?us-ascii?Q?/uZs0MV+gIeBWsHMt+74yTOneBuRbouwiI/JTvBQzeDwNxZcVLXqRvdAQqXa?=
 =?us-ascii?Q?PMAdShhKbZGbSx4qoR09IW1RGnFe6aIx6pnqheVCDfZswqV+amjzZW32WOFh?=
 =?us-ascii?Q?3TSEDzY59KYyCZpd3kssukfxtwhQCG9YIIV5BVWa0CuPeOfYfE2Wmr/VeDGS?=
 =?us-ascii?Q?C1ApvNKjifyC5o4NgJzkfEG956uyPCmBrFlBYRALY5Ydv6TF3VHo5lBpW313?=
 =?us-ascii?Q?40SpepjW/8bT2ifa8QNx8HAwoM4WIGIiE939xDQZlOY9NoUouh8ss5I+slmL?=
 =?us-ascii?Q?dZ/0QjMb8aZmqTFtBR5d0h8/duhyHnlHj+Cl5hAyahMybAsjTMocNV4QgHv+?=
 =?us-ascii?Q?dECuW9/+ry8mM3hA6tKkL1q8pl6UAr77FJRFqbDJpyRByCOw0eTluQhlpL9d?=
 =?us-ascii?Q?WLqOdctTVl8PoDz/57tJSo9W6MWgRPtTZC+FE9B8SiK0Pn2scuCyO+ciG0c6?=
 =?us-ascii?Q?D4boK8+S5cB2CJqVgTw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 12:55:03.9646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33488f8-c197-4227-d337-08de51d9ce19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
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

Use emit_clk_levels instead. Also, remove the unused helper function for
getting sysfs buffer offset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  9 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        | 13 -------------
 2 files changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3efd5cca3d09..1def04826f10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -829,15 +829,6 @@ struct pptable_funcs {
 	 */
 	int (*populate_umd_state_clk)(struct smu_context *smu);
 
-	/**
-	 * @print_clk_levels: Print DPM clock levels for a clock domain
-	 *                    to buffer. Star current level.
-	 *
-	 * Used for sysfs interfaces.
-	 * Return: Number of characters written to the buffer
-	 */
-	int (*print_clk_levels)(struct smu_context *smu, enum smu_clk_type clk_type, char *buf);
-
 	/**
 	 * @emit_clk_levels: Print DPM clock levels for a clock domain
 	 *                    to buffer using sysfs_emit_at. Star current level.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 4af587b42dda..92ad2ece7a36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -187,19 +187,6 @@ int smu_cmn_get_combo_pptable(struct smu_context *smu);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
-/*
- * Helper function to make sysfs_emit_at() happy. Align buf to
- * the current page boundary and record the offset.
- */
-static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
-{
-	if (!*buf || !offset)
-		return;
-
-	*offset = offset_in_page(*buf);
-	*buf -= *offset;
-}
-
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
 void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 void smu_cmn_generic_plpd_policy_desc(struct smu_dpm_policy *policy);
-- 
2.49.0

