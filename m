Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4248C021A0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 21:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A0D10E9A0;
	Wed, 12 Feb 2025 21:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IRN5O9DP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09E510E9A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 21:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUDrJnNJ5R1MI94/bCH5h3ylh7A9vRtQOnLzUysos88FAsuDWS8JnGEnPu6t8CxnqMljEo4fdwq3vT6TexsIceUqTGackho+r10JaUVxamni+gTlPEPlqMEcHLxai3NasyfYkqRsIfIEILCEwBreqM4zmhhbqSOrUW5Zu8hdI2dpuJD16uK1uQGRNcUc9Fp5jfEvs1LfC7ekIw6ZbXpCov01wICm2KlzZuyRMScYGbWJu1bb5gMa7Y0vBzi7knoxrIKUXmtCB8+VbIWIsH/ko3/BCOe/Af7tVeCgniyycVaDCVjq8nWTGkOIZgpAeSXZW0do9upJAVzW6AwVCuIOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOWIMXhSSrEBEL33n5OQavqU6A8pSU4dPBeRZIN0mPM=;
 b=XV7tmALFST2Yi5mfjHNQn+iDFRm5NiKF49eDcWRgKw1WVN07YHiiS6mQu1SYJpWClWXPHtSdf12OQzN253Nm9aF8bLs6IKzIzFUSmKCkp8h8E/MjTzh0uqXQq8qhjJ5ug7AckuZmPnljLH6JxQpA7rljgjwin0dPxs1tzR0bEtCkNJszd02nOrF5/FCQW7R7xAoRRS89AMG2TkjXMa2/hSAoxSfU/JDuClyTR7stgM3mTVJ1XqDRyFm63txRevMLtU0C3U2AfVddXxv+98D+kQDhsNG+GZwFRQqaBUByk+z318lpQgG54po6lOFZOirifbi0KpF9xTVuyEkJ9mVPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOWIMXhSSrEBEL33n5OQavqU6A8pSU4dPBeRZIN0mPM=;
 b=IRN5O9DPahsRlX6QbLWDs3n6aMb1LjDLUGd6fM7yaD56VZrItUpN4eiCoV4USUe6UQS1H8pHuLLeywAjF4EaLerI9YHCl0Ez5FlzO09nmf0mdpNYU9ELEEOP6SNCrRbsKwmYeKrudNRMn8KJyar/7HBeAymew/m/AejF+tOozu0=
Received: from PH7P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::11)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 21:48:39 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::f0) by PH7P221CA0015.outlook.office365.com
 (2603:10b6:510:32a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Wed,
 12 Feb 2025 21:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 21:48:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 15:48:37 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/umsch: tidy up the ucode name string handling
Date: Wed, 12 Feb 2025 16:48:21 -0500
Message-ID: <20250212214821.2871419-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212214821.2871419-1-alexander.deucher@amd.com>
References: <20250212214821.2871419-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7d13ff-0b24-4e2b-ea93-08dd4baf02c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xyJqkW1s5Y64tvHo36zD06Jv6dAqTuU92sNGAg70o2Gu1o5G2DttU7kh0881?=
 =?us-ascii?Q?pHZjmpGkLKgL960iVPTZls70AVAkSyGwxh2/h/A4qAiQ4xezailI6sGV0d+M?=
 =?us-ascii?Q?7Z0ptQUdhAoAMxyv8Pvcc2P/mb9p4IW5lBxpJreyzS9SFOg31a5GEsVajGrS?=
 =?us-ascii?Q?d4qm+zTYg4eYESv0eS4EH6hRt1ewnA7pd1bJw2Nse/ZCx/uhnX13pWtiWLBu?=
 =?us-ascii?Q?G9mBRZHfTGfZ0Eh7rmoDhHyMVZlVRtpaukcdAOtu+v0M0M76mMV2N4Mdgvhs?=
 =?us-ascii?Q?uwt6+VVV1lYpDb5bEmCNHXsvNg7QyMYkURwx/us2vFM15ZopkHPjjtl3GT2t?=
 =?us-ascii?Q?XaN7Lbxaiq+1KzN9cL49Lz+pE8ltwbMFr97DxgMChXTEKXioLCiFNs/qd7Ju?=
 =?us-ascii?Q?NxzszYQNOsHdrhGYpng8LqH3qJ50DkIof4q0GQV8ECjnfcYK3ptjx6tGPj2d?=
 =?us-ascii?Q?s0o6FeV4XhZzJkzK+in+/jnqWI3riYTZ4rNktyK3YivDt4wb8GMA81Qqlldi?=
 =?us-ascii?Q?Slk/ydb8le4CN7Apw1bWK6ldShrW15MDLxHuKadGnWXDwcOiKAKD7kVbN5Y9?=
 =?us-ascii?Q?tXPHEfFiSqIEUI+mYZqOHhLXCxw8wxvRwOyuUBjFVpOTv95n4FJd62/3zWd0?=
 =?us-ascii?Q?Oh07tM+9S3kkVkfeTca1/DUs43Z1Wwc7nIK5o80cnCCm3bFMwFWx+bLHoRSG?=
 =?us-ascii?Q?lO1vo6UzX5Rlb1BtNSAbNtAhtlrg7frLXIVDYnw1PqaTe7pRMznRvkAQYvAo?=
 =?us-ascii?Q?fYBrpAE98t6TJ+dWWerSy2ES4se34nAMxM5fXiT2EpapfLj5l3DLymI8otGe?=
 =?us-ascii?Q?7ZJuWeRTptwN/K7ftjrsYpEMqU8QzYLXZN+vhc2pWJwp1BER0Iwe/Ggvptqf?=
 =?us-ascii?Q?Cvxt5adZAHpmS+VqVYSKncuvdUlatrVq5IVlFm/xviNRUXn+fN0A4eG6j9US?=
 =?us-ascii?Q?3tffeLqeRGvWNkmF4e02TZLdeEdwIHOkpFThj2fv3EZ06uPuEJpYdBv4FF10?=
 =?us-ascii?Q?4Nf+y7lPs3yfWraXY8NKeWXt/HKY0Ynal3uK8eIRlQZrwkoiI7Wsfj/sa0YY?=
 =?us-ascii?Q?S9spPG5T0dslT2y3OiwsxBM3XBl4l9l2H5/zBO6C5+h273LFsmNlPrEfyGik?=
 =?us-ascii?Q?HJ+u1EcEVaCdzZqJCX7ETtOl0At0FtiHm7XVeD3QmInLNaFPfVfihfRYhvdo?=
 =?us-ascii?Q?c+ACoJw5EUkpZfGsg7asVU5TnuP1DkpT+E6o3QnDvukNszOr8LY7/S72Ek3Z?=
 =?us-ascii?Q?UDMhfwjz4cXKt7tWt78zoipYv2sOV4W3Qk9jRe2UgiOtVeF+kYuFGHtbOheM?=
 =?us-ascii?Q?kjFhYwIVEAplv7MIRVjsr8/mJHRUCf/fXeJ/nGtzse+FLYu7kPgZggYLmf15?=
 =?us-ascii?Q?FORWnzyj4LfDHNVIfWAGuiawwP1Rl2LD5IYxusCHOp8XIY3WRlFarDrqHGlN?=
 =?us-ascii?Q?dGSUuIBNrTYu9rXQg82akEGl/dndL65IcGk8fCYWMKD4XDSygnizIK61n1N7?=
 =?us-ascii?Q?ruzzb879rnrcitQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:48:39.2669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d13ff-0b24-4e2b-ea93-08dd4baf02c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
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

Make the constant parts of the name part of the string
we pass to amdgpu_ucode_request().  Only the version
number varies from IP to IP.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index e0e27f7ada395..27279708a1e21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -583,14 +583,14 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
 	switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
 	case IP_VERSION(4, 0, 5):
 	case IP_VERSION(4, 0, 6):
-		fw_name = "amdgpu/umsch_mm_4_0_0.bin";
+		fw_name = "4_0_0";
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, AMDGPU_UCODE_REQUIRED,
-				 "%s", fw_name);
+				 "amdgpu/umsch_mm_%s.bin", fw_name);
 	if (r) {
 		release_firmware(adev->umsch_mm.fw);
 		adev->umsch_mm.fw = NULL;
-- 
2.48.1

