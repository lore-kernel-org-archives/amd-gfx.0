Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3715C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 10:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2386F10E98E;
	Wed, 24 Apr 2024 10:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAabxUkV";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCB21139CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 10:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVsLRslb9wAxTbhlVgGz3JPIPlfej4H+SRvF417QMRyfQrsipjS7eU9ycLyzxdJ7bp6kH0BTHfawpYQdMinQZNvVynOh6OiACepki/GFONhTjts1SiqcC6Pu2lutL8Cs18uNNgSW74MUOtJc/MEJFtR6M+2APA6sGfuxU/bQMX1/RWANpHKUXiXrge8HvmPMrTbvex5MDFMxcgO6jBMh3mhsBnRs2NIO/d1sD8sxVbrdROvFaK/NpDMTtYj2lBAJfgrCcagT3mM3LDY8WiLNF0cAdxsnGS7Af8KiIrxRG27Udp7vtmztYY8//HPv15/GbB/FiEDLMgkNhOSHIxQUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2hpV40KWrreUND3+1TFPe9Y9SN8LBxwix4IsnujdRQ=;
 b=LuvDB4ds3Vp17DiEZG3q+nov9L4CRGWW8yMjh+KMSqO79NF2ooLID7ss3IGRI93yrwhBZMowXu54kFEdV0knfa7psL7mwWP9VhPjiZBWysxWErRiObEq6o1g2xX0begWOH/HzT++BQJDhdLzHvCGvZxiy+O1ATch4v8AESv1HWulQ5gdOASX52XV/4G1Jej9jglbsHGQmauflMaTnombvzAu6/GSZ1gejyWKmxUBwWDf6/SPRXSAhH3vVrMaDpbUdfuTTg0v8Z4aWJKH4Huy/Hp0V5ClW+5PB2hjJEm3zisqOEsHPelSqgiu0LMd+7B2aAqay5ns0jQcv+4+yG733g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2hpV40KWrreUND3+1TFPe9Y9SN8LBxwix4IsnujdRQ=;
 b=fAabxUkVLV403LHuXTD/7Dl56VhjYLtIlpZkjMq9xyMsqLm+VCDhqDWo6XC5Xn+TGhd4hXY74slY9lQsHpGbT08wIbzhmUqIGUUjxaBFTJ8EABE7W3qCOBH+ZfOsa0QX1S9UdjhQQosbXMz+SFPs3NcS6IC0l6pTB/XQ/5+FByY=
Received: from MN2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:208:1b4::26)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 10:03:59 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::a6) by MN2PR15CA0013.outlook.office365.com
 (2603:10b6:208:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 10:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 10:03:59 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 05:03:57 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Fix uninitialized variable warning in
 amdgpu_afmt_acr
Date: Wed, 24 Apr 2024 18:03:41 +0800
Message-ID: <20240424100343.608218-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: fb154ef0-a81e-4ade-eed6-08dc6445dc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AnnQZoZiov4AIx6IlacOH/I9OkTIUNdC9g9on/V3yNa9LawkidX44kpEAbFm?=
 =?us-ascii?Q?pOA7bmN+1LPRhN7JXaC7PYb7yZpA/wbJ4AdPQoJkTEisB0J7MUwpZFJqY22v?=
 =?us-ascii?Q?cbxekAVYnFFFBMn4/I4OLszk8AYN07bk+nDCpYWPoFeAK7WhR848remt2w7o?=
 =?us-ascii?Q?8P5e+l2Vlq2VvWGMVsIWawgpIvCgtzTCrNtBq2cO/TXevNM1Mc3en3OuCQVw?=
 =?us-ascii?Q?pcq5sbF6CbVzhwdA5xs1ImphW2jic9uFOu7t7vnMce/BYoUPttcIxQo1GDu1?=
 =?us-ascii?Q?rhpAAjUhrEcedEearHluxaicjW+eqwR9SksAwsEeeF3rOoWc4Cb92bL+Kntq?=
 =?us-ascii?Q?O+ZI9o2Wbe6zrC2T/4MTiZ3iFhbguoh6VyDJEgGc9g12NQwJKdBjhvYbG5b+?=
 =?us-ascii?Q?fftf67ytddRBnrgLM3O/j934RUTRR+EF0CjXekionMINytZk52ibq6oPpUKf?=
 =?us-ascii?Q?99MBL0VAu9N8kSuKAtiVOyuENGeJYeFJV/EmUe3j7J7LGBAUjGzqEfCFuols?=
 =?us-ascii?Q?cyMfdgNLTd1/RuUfP50bVeM+SpK+O2UudOmlMLFnfQfVYzOQJUq77mB1CfsP?=
 =?us-ascii?Q?A3uVy/ni3RYSwXfIbL4kQkeyllCulP58uoXNrcul0ACvDfRRl6PvGXJ6J95v?=
 =?us-ascii?Q?BRjm0JxLmA9IOsdcCMd6TXBOyOTti8IQ/x0Jd+8zqKRbbxHfPbvmQOJnrGXD?=
 =?us-ascii?Q?PfUhLiEdlBXTsKItr1+vflJf7xrLzKaO5VIOSjVPy0neFDQZ7tsMusFcbRso?=
 =?us-ascii?Q?u9r0wCc3JOymvbn91Ey9E+S9j+xmiSwT2A0Bg1g0nZn8iWdWt0wspdciYDAB?=
 =?us-ascii?Q?R5MfBclQeke4JbjP5I/0jNsoQan+fUCsu7gCLHKf026xWhLPsrLntw01GLAw?=
 =?us-ascii?Q?MR0CuSkgvuRC6qKFGOPcPtYN3fQ9riPIeFEeEYdy3xhIR5lbUqvFCIESAs4U?=
 =?us-ascii?Q?scEJV2tckJgF1qA/PJcMjaYl/9SPr4GOCttjIFNL6+ysYQ6Fxdn0FQ2OKi+v?=
 =?us-ascii?Q?OuaMlTdKeEVbBC8EnK4PazlfFDEXqH5bmkjU2gptKNDKX7ZiwAEquEIjJgfT?=
 =?us-ascii?Q?v1BYERK2/kYTj1Q/Rjc7yP1CMjUR+t/70KylrIgWqrfW04E6o2keyg4FR/gW?=
 =?us-ascii?Q?cHAC6zHhmlgVP1lZX9L5j1gsZfRdVt/38/c1UZrD5MG0M304g1tJGwLB8b3x?=
 =?us-ascii?Q?MThn8Q9CRtzBso+n5eaE71iVFD3iJ9QgPOSeEhvG7oVZ2nSKN38WU5aJNX5m?=
 =?us-ascii?Q?dHGDDyTP2+pbTwjjsYhIHwPE7PGe8XwElS8tSIyzAKM4P7qY6Ddcz+PDFz4I?=
 =?us-ascii?Q?Rffd8CpPO8Alk+01Q6IuW8dCeDbeNrBqKjKsXFkSKg9bothVPwi+e0n4e+hF?=
 =?us-ascii?Q?30jS8Ysr95aRBwMGaw3k7bPI+HYT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 10:03:59.5920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb154ef0-a81e-4ade-eed6-08dc6445dc97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
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

Assign value to clock to fix the warning below:
"Using uninitialized value res. Field res.clock is uninitialized"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
index a4d65973bf7c..9e3442b2d2ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_afmt.c
@@ -87,7 +87,7 @@ static void amdgpu_afmt_calc_cts(uint32_t clock, int *CTS, int *N, int freq)
 
 struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock)
 {
-	struct amdgpu_afmt_acr res;
+	struct amdgpu_afmt_acr res = {0};
 	u8 i;
 
 	/* Precalculated values for common clocks */
@@ -100,6 +100,7 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clock)
 	amdgpu_afmt_calc_cts(clock, &res.cts_32khz, &res.n_32khz, 32000);
 	amdgpu_afmt_calc_cts(clock, &res.cts_44_1khz, &res.n_44_1khz, 44100);
 	amdgpu_afmt_calc_cts(clock, &res.cts_48khz, &res.n_48khz, 48000);
+	res.clock = clock;
 
 	return res;
 }
-- 
2.34.1

