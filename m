Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9D8C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F47C10EAD6;
	Fri, 21 Feb 2025 15:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2vXtq9C9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646EB10EAD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9GwiwX/X1w5rHyeFwtwRLbOgb8sLY36xLZCeWp/bR7j/uo9m7Dj1SCMjxdBNyrtl8HuMzD+nIy0niRAFX3xnf1p6I0ns9CZN/aTSYN4lWF7y3MIbXJ3EhkcSseJelna+gfNuZM1UQ9uVjwZJOMKAWvu+iffwY8oNmmepEMXk7TXtChvRPw+rgEMOJWRjb2xh9zPvgYv3g+4jVSbbsxsewu05+IkwzRtN9tvkLSj8nnvemCC7cw3Hjus2WkzjLs3CZ0WccUpdwoW30TH3qgM5QDirqEQX+1G95POzUiDVCQ0AsjoW9qIxQ9zTPp5XRWi4Kb1gkc08Hp74P2Jhn5p0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaFzVadW9edi5acaWsMFfIVs4IkIQOq5gtpeqyj/ty0=;
 b=BuutsEbzn609Fh1sjO4b0x82sQCfyX8UebQDt40zvk5LnMokvd36Pss3X/xySkk3xlRkxNn4DBCJBpIPhk1pkD9+RZ0yY6aOBkoI/2OIRAc51VROEm/AfD7yyiZchrWPFANz4m/bhjtNO2F0D9T5MBS2KUMm4KeIZQq0Y02UXspiC+5EKbSpfuf775EakamDSLrQWRi4SvRpSboxh3qTevYIwE89p4AMazzU+sxt1qjCCOoph8QevzY6X4NV0Ggm2GfhFes3LmG4Lc2V5LlSNP9P0PdrUVLXAfRjMpaExkb04kebdqCmsY7aVxVuVnDTOjuIMk0oTun1ZhB8kxBukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaFzVadW9edi5acaWsMFfIVs4IkIQOq5gtpeqyj/ty0=;
 b=2vXtq9C9AcUqCLYKunotKNsPC28JKKGt4Z+XI3Pe+nU7TL64aMr3sxsIc/boLGY8HnmznkUj7NJlL09OzemydRjZFTuphdOlLP6xckzM7WGJm7MvJHCs17G37eUKRlYVMxZ6RH39GwuXkNyRUsC9g4T56jjsv9VquXQzNSxpYFo=
Received: from BL1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:208:256::33)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:57:52 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::7c) by BL1PR13CA0028.outlook.office365.com
 (2603:10b6:208:256::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 15:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:52 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:49 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 05/24] drm/amd/display: Fix mismatch type comparison in
 custom_float
Date: Fri, 21 Feb 2025 10:57:02 -0500
Message-ID: <20250221155721.1727682-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: f91a3986-6bff-4d47-d109-08dd52907f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dwedmOOTcF2UrggkKvIHl6PzdCVKS89d9Vnwr5bM3RddDYYjY9nNj+uRZShV?=
 =?us-ascii?Q?FjFnjihQxysVA2K3RCki6c4JLaIOB0Tz/463zOm+NlzBmJZH+SBO+1jDsUsk?=
 =?us-ascii?Q?kwlBDrPuuNjOohyeTLcajBwqk+1O/E6dSBBmCrcLcIsVyoJ+z8Z+sNAoldz3?=
 =?us-ascii?Q?eP1PEUHRr0yk/uzhf/o35QfuwHaU6BtM8E2O8ueCrVRL+F/692P1/9q0WnaN?=
 =?us-ascii?Q?Q8wV8Z7gczrUWWwXl6uo1EgEs4qlVtL5O6sZy+Xx2pNCQdOzBx8rceQwsXFT?=
 =?us-ascii?Q?5KXrm1JXaw4daUxqwyc847XsXzopL7vfZ+6n0uCKEOGDoCjD8TesptxMSw4Z?=
 =?us-ascii?Q?WfVuSGX5mJMn/v2JBmdwU1L1WPdYBYRvnkv1lIk89yXKIi5PZ19O4AXF2UA9?=
 =?us-ascii?Q?0oKpWhFhLA+m1FM7dvxw8jm15vR0lKreJ2rr4RBAdIr/338iPwD0Ev8gOUhz?=
 =?us-ascii?Q?WnPdFzxqZrsGhDXAtHDPZCihkqz3K9RmOuFSjEAEyjq0IvUQGV04dlLe3Hdp?=
 =?us-ascii?Q?JMNfmL1AEf5qeagUjd+hb0G8/qFAghYlplz2BSW0YdbToxaXm6mGIOD2yLoJ?=
 =?us-ascii?Q?7JzYRkxoTKVKSY7UAAYQzPrx1E5SahLb8Bg1S4cSSeNpbrHNGQUASPxmeJvC?=
 =?us-ascii?Q?1bpJUP+xo5HGlN/d9b8dgDO5baR1zSY8tqo8cbUZ0BNg5QzK0MsFUs0+5HaS?=
 =?us-ascii?Q?dLVCoWkk550Fl64d0IVjwK3OfJhoNkNL+FXID5aHGivuktDol5sdR7niK+tt?=
 =?us-ascii?Q?Aaor/zkPWzaWbESykx02UiltbCdYM26X8R9iO9XCFMsInH0iSjveuCU2xcjb?=
 =?us-ascii?Q?Gn+1b32GOV9Qvs9mTATKIyVXyupfaXOGUgy9795UHlNCz7SC0TXifuhMcY0d?=
 =?us-ascii?Q?+Y8GayXvHa1vKca9DUCbfL2C98qmYe8gylvwq585ln5nOXPS7IuxxC2lPw3H?=
 =?us-ascii?Q?TW7sXjYaunF3pTXfgACj8zRxnzXgnDGQ5V+c9dDykk98BSxiMbUlxxPM4/XZ?=
 =?us-ascii?Q?HXULMter6NCgA3ajp7nJss55PiHLv9Nwus9NkrNDbyekRpcUkTH7rZ5j3l+Y?=
 =?us-ascii?Q?6P5Bqn3nwEe1ifhGqFHa4cb8Mm29XunNDaQqcw9rO0nL3fK7fb+Ch5r7NfkG?=
 =?us-ascii?Q?qNr7voTdZSrUe23MBeX3W5UvvZUUG/RXRYL1iXuqXU7iP9PZJR+pPmve2WUu?=
 =?us-ascii?Q?6Ook+LXVhUnDG1ZLYXNZpPswvIab6xjsnJ3SOcMqQnZqwlTQENC8VBgn3v1b?=
 =?us-ascii?Q?L2dX4jC6AJFdl/9uyV9uCoA07epAUTwKeEmtFOyqZdxaCFakHKzQFFiMnxqa?=
 =?us-ascii?Q?jj3DaTfMeM0Gp++Bb7aqx5Im+UqYHtFk/MWt4k54rC3EmJCXTQUNkJ1xXb2H?=
 =?us-ascii?Q?Z8q+98FLfPW5TnwOANtI6n8/VlGsdrlZ4e1ib6o5CX+YHBiKpZC3P2ujrFwM?=
 =?us-ascii?Q?yuDbCzmQBBd77yi4BnGjn4Wd+vjZaDkEyFiHenD3qtbNqk+NVnLNpWVIqzCk?=
 =?us-ascii?Q?EP+ecVhzDiJpyb8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:52.2499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91a3986-6bff-4d47-d109-08dd52907f6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Passing uint into uchar function param.  Pass uint instead

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c | 2 +-
 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
index 131f1e3949d3..52d97918a3bd 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
@@ -346,7 +346,7 @@ struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg)
 		if (m > 0)
 			return spl_fixpt_shl(
 				spl_fixed31_32_exp_from_taylor_series(r),
-				(unsigned char)m);
+				(unsigned int)m);
 		else
 			return spl_fixpt_div_int(
 				spl_fixed31_32_exp_from_taylor_series(r),
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
index ed2647f9a099..9f349ffe9148 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
@@ -189,7 +189,7 @@ static inline struct spl_fixed31_32 spl_fixpt_clamp(
  * @brief
  * result = arg << shift
  */
-static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned char shift)
+static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, unsigned int shift)
 {
 	SPL_ASSERT(((arg.value >= 0) && (arg.value <= LLONG_MAX >> shift)) ||
 		((arg.value < 0) && (arg.value >= ~(LLONG_MAX >> shift))));
@@ -203,7 +203,7 @@ static inline struct spl_fixed31_32 spl_fixpt_shl(struct spl_fixed31_32 arg, uns
  * @brief
  * result = arg >> shift
  */
-static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned char shift)
+static inline struct spl_fixed31_32 spl_fixpt_shr(struct spl_fixed31_32 arg, unsigned int shift)
 {
 	bool negative = arg.value < 0;
 
-- 
2.34.1

