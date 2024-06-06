Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18A3C25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 15:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE1B10E9C4;
	Thu,  6 Jun 2024 15:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bfSs0ECA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9825E10E9C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 15:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcuanybNuaTIxQ9sRIwqjYg1P8Pop5WGyubm8TO02mSGtSMNhhwFIBSRkhNUdfbpFsnaNsAZDHC5WxK3qAwvQDXWp6V1Ed1H8kKoDbF4O0njXVZTnkyuNk1lK2hRynTQ5qsNsPzd6cLn4G1naJuQcGPxSs64hRkcUOAmnY/jOt7U+IRMQyaMN4D9j91SMqgQeRY1/EYhg2ecSiPQ2SMPyQhX01yeEopjRjaJzBxMvRL58KLOITn6Rv7PqOsGm696Aja7Aq5mqEAzQHQmrC6wPPiYn8LbFykMf6gAxoa7SmLb7o402468BJOz+ST5HOjRDxL6HEk9Up4r+iHvkRsWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ3h+mUwyaJaKQzVdCHixsV23gXiHTRd6XS+i5Y2F2Y=;
 b=bGU00ZrcmSaXFir7Crnb3o3Au+JWYX69cy9EwvCCqlzYvGqFQBUpRD0iVA6HV5igDTmNVZpqGt6Qdo6dbw/xDILPbTgUj+iawIfL22F3PCpmtl1B5iNJRa+Zw5HpK6JgjIkjEV7o7tB6JN0X0bCPci0ViVp34UgnB8Poz4vMLer3UfmOVC5T03JgN12tLLgpnTBJfAzccecNRL1E9GE1XnMBNSzBcsyhKSQuIutU6kcyf1Tgi4FlvaH+WzYoY8Aw8f8tPUMfQWMrV3ei+L4ZTRKE5ERRn36WPMkp/3XMsYXNvjFkfQ+v/8mFNY9/ZULGhDoqdnBYocIL8a9GzY4F2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ3h+mUwyaJaKQzVdCHixsV23gXiHTRd6XS+i5Y2F2Y=;
 b=bfSs0ECACdWZANVbft8r6LeWvO7WFEyA+PIsKeGvopWsgANXpjGVBClwD1sfdz1IFxqPDaKCVgQRluhyBTJxvgdRLlX4g2bn2mK54BdwSFpskVNBoK5jQFdr2ggOHCZW1smHf1v9fBgMzD/+OHLBDrazkGi8z1OSXJy1YAk4gvM=
Received: from SJ0PR03CA0188.namprd03.prod.outlook.com (2603:10b6:a03:2ef::13)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 15:43:20 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::96) by SJ0PR03CA0188.outlook.office365.com
 (2603:10b6:a03:2ef::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 15:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 15:43:20 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Jun 2024 10:43:18 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix NULL pointer in amdgpu_reset_get_desc
Date: Thu, 6 Jun 2024 11:43:00 -0400
Message-ID: <20240606154300.100140-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 4128adf3-a96b-42de-1d68-08dc863f6454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LR2rgqUYOUOWkYeXRi0Ho6WgWFMWEgdeY9W10cNQt4Bwcsjqgd7fYJ/bzkZC?=
 =?us-ascii?Q?//2pkcZhmLIRyV+Rrd750DYLnI72n+KEAW4TEh/8IaQc+QvJGGOncwSgZcm1?=
 =?us-ascii?Q?cyORfR2FyOfNbLm0t9y3gBuhueQgnQGY/mqaRmCjTvHcT/NIMLIWcJ8eK7Ao?=
 =?us-ascii?Q?ppN67LCXmWGvLcImGpemP/OkzIksI3l70BI9V0lCFjZVIOzopsjmHK35+xnl?=
 =?us-ascii?Q?zZ5JdXKZmeWWwU7Z0jjgApDL5rPao76QxVtN7HED/IhJyeISBwBjBJ35C5hG?=
 =?us-ascii?Q?pDD/aZPt0ySyC/NigXZVBHL+Z0Fjw4lx7AkLEwra5P2Jf5aL9Cfpyz8vUHZK?=
 =?us-ascii?Q?XBOX2oAt1sgA2kf3TOIsR3paHOZrstUKbbFAKz1MYuoZVqr4LRhpaYXOxrjI?=
 =?us-ascii?Q?/hXoe/w7LQ3RCE87R6Xjhbz68l3eqoXS3/Xt8QcDgYGYZa/3NjV0z8fAaDOA?=
 =?us-ascii?Q?/czWbZYLSUATumLdekyCreT4QbohVjdGzAVl306YxcaGmCElPgtLMENuRJUI?=
 =?us-ascii?Q?/AHvxgYuhhJ6FM4cXzBRMGgPj1AL/n5u4COXgQaE4bJ7fxgWl+8RgSUH9BZx?=
 =?us-ascii?Q?lhPwZ7TmiihT81f9W8BoxYkCSf0ZU/0jj25z1OWr9cbLBBP9N/D/EBvU4ggg?=
 =?us-ascii?Q?2Yl/THWpYtvMsA07J8/Czc13KSaTFMzEbBHNlsUztp4aNXIHnkYvtYO+NPDV?=
 =?us-ascii?Q?AbIs13ZxIexxhbZ79S5+IKPN70xNTmoLJo0by7rfHcwfVrNTX/Ssg4smrLrL?=
 =?us-ascii?Q?CFxCjS9QUJf3eWrZ3GCoa0Upu7XnYkCKoHYCnBX3QsUzuPi4YTO3VDAp3xbw?=
 =?us-ascii?Q?HoaDeFz5xOu/CakL0TqgluPwgVSdoB2e44/7K9CUeOxSmOHGLI3qX2FNfCxH?=
 =?us-ascii?Q?cAVYiOYIfQs8y6pxU4wy4+7h8JCVfPfLr9ampcixw5YfG/Sp50iSMg2KUOxa?=
 =?us-ascii?Q?9C6XUTRUeROxMgpLnSReZ+w7F2LLJTYVqhvTE2qT0aZM9KDbUh640WE5xBvG?=
 =?us-ascii?Q?a+xr2K6hKDe7gwFMk+jp7OeOMTJExN6Nz3WW+OqNoEvcAeUosi4LYqa8aTKC?=
 =?us-ascii?Q?lOvkI3hlxVjkJ05KzBY7ed4gNVgmv9UyJUDMlwQjRvEd/MHgN88ZEZ9QbVCC?=
 =?us-ascii?Q?0CatZmSHJqMlpAXpnsDJoy+dNdB7to9Tlzj0SlJNPUVyws3PywDA5Dy5TWVt?=
 =?us-ascii?Q?iix1LCS9gDTkUfzodK60qRZaUZmfVAnSEjk37CS/U4rZMpK/nBq2IjGRuVeb?=
 =?us-ascii?Q?eCeLP8wb4ojevnbSffFjY0F0cx6gIFhPxdQbkz3mqquhfHwNgOE8i5HdvmXr?=
 =?us-ascii?Q?Urw6XHvVjh2sRw68mqZ6EhaEm/E4VJqrHfyw+M5kYA/f/V5w61jovnG9Hu3p?=
 =?us-ascii?Q?YLWIkbV1FT1eOIlTq6fGkNi+HWhLRj08W1lfqqN0qTzQs3bE0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:43:20.2032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4128adf3-a96b-42de-1d68-08dc863f6454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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

amdgpu_job_ring may return NULL, which causes kernel NULL
pointer error, using another way to print ring name instead
of ring->name.

Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 9deb41d61e8d..66c1a868c0e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -164,16 +164,14 @@ void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 			   size_t len)
 {
-	struct amdgpu_ring *ring;
-
 	if (!buf || !len)
 		return;
 
 	switch (rst_ctxt->src) {
 	case AMDGPU_RESET_SRC_JOB:
 		if (rst_ctxt->job) {
-			ring = amdgpu_job_ring(rst_ctxt->job);
-			snprintf(buf, len, "job hang on ring:%s", ring->name);
+			snprintf(buf, len, "job hang on ring:%s",
+				 rst_ctxt->job->base.sched->name);
 		} else {
 			strscpy(buf, "job hang", len);
 		}
-- 
2.34.1

