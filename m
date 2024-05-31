Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B2AC27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 10:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29C610E0C6;
	Fri, 31 May 2024 10:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OgjSdNmI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A48F10E0C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 10:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKB7rBhBNDOb7WYds1SnERczY4FS0C1iU5bAI7EucD8CGF89FQJtuqbd8gBL7C5VT8VNWG+K41qfTuUMFrZzNE4ZctOT9azTS0uyt8A/rN6WP4IfB3BdK3W4EkSoBflO8UJutY/L3iN5yrt2il5Jovjgm93rODzhb0bJhuenqecvXnkXrOCV8QGZSZV0ASoVTfQb/VpkfzT2CkxiCqBxqlEfxPNRIQC4xs+dJ4JPHcvNg/GI6kbbTvjme4Xxv1N0iF+GbvOPpmPyWOhImd7gQ229l4+PXpfnyA2NCudpVTWrShP9M2LZ4yB5ZLXTNYaaQYpUAMkBvO1wfvqsWTvzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47OfB/SBAe0q6NhlUq+RFawDksEpMo1FqTnDZGAvBvo=;
 b=oVVQjZ+ZxaGiac0lLHXCHaFheWR371s3z04JttoBg3vrZUWaT1x8tUKLUW1sBuUBYIBVnAY6og5hY5A54s5b0vgEXPDnbKoNwW2dUWqaJJSDifui2n8auye/O46/l5f+4NI/gDG0bvg8mqVoPR9Sni058Yby9ab+ApGwr7YofS2IsKMAnbMnP5r1Zc+rKtxW3Zkd+imQS8GLGXWw7xsHSgjIe4FNaNoWkVJIRxIDQy3WhjMuhZ49qDyTaJmtmDJDgKfbguJDvLT3Gazb4YkpyHq/ryH/7Ym61RQSPPvDv1TkBCswnWntIKxgN/GVlMGf7MEiPbc1k8dOUFZ8cX/Khg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47OfB/SBAe0q6NhlUq+RFawDksEpMo1FqTnDZGAvBvo=;
 b=OgjSdNmIfvfAr29e2mLd74WecC/Fe34m902Yn5HmvJcv9iikwKgpNmhm0h3kDn0Yf1NtBS9/4IY7IyO+D+Dl2A2K3mIqGoDpaVIg4f/d7aiAn6h9Gy0JAaVnymYh84RoQtvMHtEEbw2rgIKPkldGeVx/T5PGdRi4MDlbvE/bMZQ=
Received: from BN1PR14CA0025.namprd14.prod.outlook.com (2603:10b6:408:e3::30)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 10:24:56 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::a1) by BN1PR14CA0025.outlook.office365.com
 (2603:10b6:408:e3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 10:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 10:24:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 05:24:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 05:24:54 -0500
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 31 May 2024 05:24:52 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jingwen.chen2@amd.com>, <horace.chen@amd.com>, <jack.xiao@amd.com>,
 Lin.Cao <lincao12@amd.com>
Subject: [PATCH] drm/amdgpu: fix failure mapping legacy queue when FLR
Date: Fri, 31 May 2024 18:24:47 +0800
Message-ID: <20240531102447.168073-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c25218-8211-4659-1e74-08dc815beaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XDWD0gjPiz/XToYP4PhX4ybUsw3VfIcl97UPUhsa6OzEnzkagOUcF3LM8AGt?=
 =?us-ascii?Q?9ngR9kn1zmoBtA+FjxSBKoCqPD7XEKqLCsrZtpBD0GZMOeCSTUsRqRBKS0DB?=
 =?us-ascii?Q?l04VwxmOmC0ooyOI1jkkmwl9CFAWkWP91tsYhdyV+e/tTPhLAag+FN8m1NDl?=
 =?us-ascii?Q?xChdPFoLLhLCdGgrYWE2Li5xyzpOWz+LocRHaSwKpXz7ProUXpvx2YJehyB0?=
 =?us-ascii?Q?KklQ763oULgN2vIq5lM1ewons0h+JzXUnRu25g1+IHMtoY9/fAfMCcGhlVX/?=
 =?us-ascii?Q?zdgi7f/UpuvRWAzJY8shCQkGjLSC9l2uqGCxmT+SyCjMT2/KCvwT3zDJSO+I?=
 =?us-ascii?Q?Jjw2SA634iyNMHPbB2CRTAgYjMZesCtRMSf35N0EpkVipdHIjn0ItNCfeY9R?=
 =?us-ascii?Q?tbPkkjV8Z74BVt/t1cQhLOgkTE1Zod9+sD43UusHuI9UR5wFVXMsYrThri6k?=
 =?us-ascii?Q?J9GA2OqyYouNP3vlG2OqZVuJIUbxxfeTmubWpzponGhNTOkvnhgExKNqArMS?=
 =?us-ascii?Q?7BjcVbcubGR1LBBgRcz/5AkTL9eEKWNptCXDRVnWGvDPqSicdx81IUFyMInb?=
 =?us-ascii?Q?lyVjC71RMBDnSDVI4uqLb1yeZc9NlT7sTe9Evzn0owXGosvueSBNGaQDJWY0?=
 =?us-ascii?Q?NXW9OB59J8bugmroD5AwjBYO7xw5V8I0YTBNsWjvXezzzXQ9xrCB9Wfkt22B?=
 =?us-ascii?Q?636XqpeL5voG4X8FhBQ6hFpSIh9pqnzeG/c9HYYAa3Hdt3dcOmSbbKA/xvZW?=
 =?us-ascii?Q?1i5VL9nuV8U+a8DzZYt+9+Zj1NpOaGN6T/qOsVgXD6+CqxQSKe3+0SHvNb2S?=
 =?us-ascii?Q?14Vn1xx7gCO13d88PvzkIrVVyXozwCzpUCY8KWqREyb0RTCFyVWTTwqkZ9jx?=
 =?us-ascii?Q?UAMV7YKRFHSZdO+dDw3TAnZqUjhLovYjI+2P83nVrVvOgA46jRiRF5FlFpBA?=
 =?us-ascii?Q?eurMQUC6Rrov6l7XApkkogQ9v3BH1VadBryVwJ4668PhxJKlLsRJxvoj/v9C?=
 =?us-ascii?Q?0g2/eF0jWxB3uhOcrnmHnAH6syAn3C6rxrxhOumP4/I1ClHMcn3Th5X6VJWc?=
 =?us-ascii?Q?HP4nWnFyGUtz/SyIgcNL1plLdkCYOKqoq2/JDeqIbHAUEUur9kT6l6wCKUXu?=
 =?us-ascii?Q?CT4QPDtfq7qF11aDlKoZlBxUH6HWgTujdg+kZwW0IWAvACJt9oSKY2SBg3Kx?=
 =?us-ascii?Q?7A+vMUyQy1vATbprTRWBuZ811JVr+tiSAOA9fEFTrjimU6WJtddIxo4WJR6d?=
 =?us-ascii?Q?dtSN8lbvDaCBj2Gws0aQp5Eyq5+QBC2LqqlSooHR/1N3WTboZX3axLGsvuuv?=
 =?us-ascii?Q?3FGAdvfs8MlhWu5HEvS+IEgyb7YdpwKTqfqyJ7XqnB4VHmbUahDYac2JONSD?=
 =?us-ascii?Q?APQdIm+gSS5MYv/blaCh1KFdY66k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:24:55.8585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c25218-8211-4659-1e74-08dc815beaae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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

Flag "mes.ring.shced.ready" will be set as true after mes hw init and set
as false when mes hw fini to avoid duplicate initialization. But hw fini
will not be called when function level reset, which will cause mes hw
init be skipped during FLR, which will leads to mapping legacy queue
fail. Set this flag as false when post reset will fix this issue.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index a72683f83390..b56d243c53ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -822,6 +822,8 @@ void amdgpu_virt_post_reset(struct amdgpu_device *adev)
 		 */
 		adev->gfx.is_poweron = false;
 	}
+
+	adev->mes.ring.sched.ready = false;
 }
 
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_id)
-- 
2.25.1

