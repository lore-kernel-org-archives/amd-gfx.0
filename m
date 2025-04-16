Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CD3C369C1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 08:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B58010E89E;
	Wed, 16 Apr 2025 08:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F7H/mq8L";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118EE10E899
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 08:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFqmMhIM0pnMYi84phIvTY4GNUJdG8aa5lS4Xg0A/KKJ0Myn4UHKl+UyT8Zx1ibdEihG0eSqkKQDDxSNVYC7xKbvyPBtB3lWMClvCinhQ+KM8heYDt5NZNfO59xX/n6xXIBr/QwzRIlpayM4Yt7yEOUK6ZLSndUPYrgyLKRBe2kp9vw7dyhYSWmaGhQLi575JYXDm/urWSp5T+yC+5avOZlTsnsmSVf9egU9NlNtMm9bDq6IRZdrr8QEtpcJ7o+IbLUj+LTwkr8chZdTE7HJOzCMXCH5nJsQrA40gfSe5H7JiWuXG1lITrt7CAKmf2lpfhKyJLSMfApEZtR2OzjKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUKbi+Oj5yt/U5fuX69+0iGTe5RVjgYUHIE6VTK+/0Q=;
 b=BWpT2/ZMLbWQJpXUwMEWCu5rQpciectJnfImVVfwQGBYqSwdbava9tAPyXLy79o0yDQsYmaiwEAMLthu8bnIoSF0QScC6MJvRq9p6WHd3mhzGysG2aBTguxozCReTz2IpqT/iELI3vm0NLyqurYHsYcwVp44fRi/kJeAIHBN3CU3VWBXULlTA9v3jGs55vBsVlt5XTzOCotwNwD3/DYA/CgD7ZVabC61oahaTdXrf5VkJGB/aZElTeFogy/ClH/h1rNBvjbk6nTcsxQOgmgDV3Cn+55LC62jD86tyyGUpdWLH2PkyX5ZsSr/62e8/WQZT4ENZo9xVqW8MrIpn7kHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUKbi+Oj5yt/U5fuX69+0iGTe5RVjgYUHIE6VTK+/0Q=;
 b=F7H/mq8LEqAZXwk9tKqpO0isMTnEy3L+RPTctZUqwuZylGk2S/2b0coAlL3r+zbrL1T2LvCI8vq6holswvOZTDH2mRppdLWtXqROfxB5bfLiUwywP+9zPBs8wvP+deapqYNe0ERcPsGry4rfZfo0zFDz0kYrQd4tR/sngVrgPHs=
Received: from BN9PR03CA0546.namprd03.prod.outlook.com (2603:10b6:408:138::11)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Wed, 16 Apr
 2025 08:50:43 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::4f) by BN9PR03CA0546.outlook.office365.com
 (2603:10b6:408:138::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Wed,
 16 Apr 2025 08:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 08:50:42 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 03:50:41 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: set the evf name to identify the userq case
Date: Wed, 16 Apr 2025 16:50:27 +0800
Message-ID: <20250416085029.2278563-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416085029.2278563-1-Prike.Liang@amd.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: 4961b070-b77c-48ac-f170-08dd7cc3c57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qyN/VFnqmEe2SrSE5Galkdh55MYLU/JKR0iD0GN0i+/VHPwIcav2uYHDcb9E?=
 =?us-ascii?Q?L19LdiExpiRLQP5sNnqR3qdGVi6ycbI6Rl8Gzju0oBTpDcDued0Tj2qF5kWl?=
 =?us-ascii?Q?iS5FisGuZUDwzNUMifmRNUZWpUlygV6kc8b8Zuq98B45mh76eZzCqykRHdAg?=
 =?us-ascii?Q?r381KUJHJ/RY9niBVv+vQd/cJztsrfSeXErjIXGYftMBYCNCER0xsDO3+cG3?=
 =?us-ascii?Q?54tEJcLEpjrwJ1l16w/nPyovipPSPR15X8a1H15uhR0ESBfPEDGK5ZDErCC+?=
 =?us-ascii?Q?CG6DtjaglDx4X5/IOdFjehm3Ru44YmeuPI0IXkQamfuYLYb0mNopHtrowKTi?=
 =?us-ascii?Q?tfE/w0Y78jsFNJrIxCTK4E+RsUTM/OAVLuIKkSfGsqGOXb/4qnETzVI8nGkL?=
 =?us-ascii?Q?cUUf+ZTzJ5F1YjicbMHwasTSaFKp075uYCkipo1b1Fqhil8IY1b/HIkRD5EH?=
 =?us-ascii?Q?560uWRQj8IZofh7Zw8w3wjRCIsESkEzQ3bQQ/Mw5oexEFxhDiGBiMvqpOEHM?=
 =?us-ascii?Q?y1J9Eagj51UYCsMqIgHy8Q4o3kr7EiX8r91tdGZTBepI6NYVMfhcWK3ErKG2?=
 =?us-ascii?Q?pwkZLSm7YmH7mVBoPMrgOndIrz5RxKAmWU76bmbR7/alUQpqXyNckqFTPS7i?=
 =?us-ascii?Q?8rAdK7RsUf9poA+ymZ2982fjh//F3fR9LqNbmxA7cOfaZx56qrbE6RnHagtq?=
 =?us-ascii?Q?i6hirgOxXmzZfknP51qcX26O6WDYS1fR4iW60u+jM9+VxT7AnOdr0qC/QsVF?=
 =?us-ascii?Q?L6BiAdoClTvEeXIou72eczDFf3+O9LqBNW4315MaDRsSh7lB3Ypvy620KLvB?=
 =?us-ascii?Q?q2DBwDwGWtz9NBkFwnTjpwDOiwOh9xHZ7C5Qtw1q25ERt40Azp083beV8NNs?=
 =?us-ascii?Q?Yv8KaQO1NIbPir3ATi34IcD2+tQslxWE7gRdFUI1uwtTQGYTQrCKo6j7gRme?=
 =?us-ascii?Q?+gan+ZSAnqWkBUWdx5MgpUT/ATZSjsdFnwwnElOZFWi+1h63WhkhEl5u+D83?=
 =?us-ascii?Q?jMn+5yyak3hZp3lFuxU+02palzCTnBpC2f3OSCBA4/3mRUkxX8WHvGPVzsQ1?=
 =?us-ascii?Q?c1hk0AtdVZqiQoLyy+OSZSzWbznkv/MlSs75LY5n/H4BR1xPouifHLeZTq+q?=
 =?us-ascii?Q?1TkTSruhRW5qYvqqPfRJ11Ir6wtQZUaejKaJUmPv3kNkegBbjMWAjNhKXPxX?=
 =?us-ascii?Q?tOpnM/EgU3cqQ6TDvV1VmgVjg7wL6xsENLLNCGodHEQput+Ocs1QqB1eegRL?=
 =?us-ascii?Q?Z9MHrcAI94h8iikuPUf1/XmTjnRbKlkkttCeYJQRviaPyHxks+mLhNCTW1p5?=
 =?us-ascii?Q?IqlnqitcM5d2VEG09h7kMChJstYIspswFRyaAb8AKu22sbQqn+WwhZ430Xg2?=
 =?us-ascii?Q?8N505mPZfUjN4FCrrwzLgxV6TNrtfbyLJmZ1fkFQdeZ+BqEca7nayhRpz63C?=
 =?us-ascii?Q?u4rYV1A1RR0Lft9syTPvB2e8lFW9QVFg/oPxpOsoKBWCBsPqZQLcAR0GX+lO?=
 =?us-ascii?Q?oT5AQ+ezpbeBGecDYsGcxn+MQRqtVstxSbRK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:50:42.9776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4961b070-b77c-48ac-f170-08dd7cc3c57c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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

The evf fence name can clearly identify the userq usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 7030d721196b..b34225bbd85d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -31,7 +31,7 @@
 static const char *
 amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
 {
-	return "amdgpu";
+	return "amdgpu_userq_evf";
 }
 
 static const char *
-- 
2.34.1

