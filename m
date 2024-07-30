Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5041C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D60710E4C5;
	Tue, 30 Jul 2024 07:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5AQiOSxr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072F110E4C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeGPLD6Jjj05Qh/XrYVb5vYwKIZ+wlTLZf2j10tnf1eWVhDvePgonlqhvoak5bMBkbU9k7AM/Q4FAXQmB3Sm/V111/rULfqZqwHGLUbCHoi5EGR+NgWNL+5uR0y/8KmD3UzaPLC7kdD3Onq/a4QRP8y8Nen3nY/X0x9uYFsnQATNcP8AT1a9cXZjKokw6dA8sNSQko0ar+icmclvto5S7QGQ4cIpGF8eczgh/ubfKlCLJxd1ngk9I3IHP8PTOkMA5wTBv4CfzZTR2/OdthsyTDUlnGE/4FLr498iWSsuAQveIEmX66tJQi+7wgpyJK6apQpuGvhymjoIdjz5nHeEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuNKUvrBbFInV1skhedUXxJ+skCkEhQx0YTlz+iOtDg=;
 b=aRs0SI5fF72acDo35JNmKlgCC3Dv1orPFNKTxVncZZE5js34bmXpdxbrKI+CRmnZXwTj0Q791xyGDVaUUr/AVJVffyZXpsNVgoDi530t93IV5ARiolX1OP8RjxivzNJGeJpOd2Wh2OHrnhEQS6fjmngnImELfZro04TWrL6i2cS2xb/J5Bt4Cc6YGe6Q9Kzwaubc8fROY5ZN66x83yOnaOiER7iRxC4NcjqqafWkqY7fwdl+k1sdmdCPGmCUSF2rWUYTHYb4iOx9fBFOBen1Q1gEyTN8sb2ucpA9uI7IQZYuwZe7zsy1yX2rQdX0LCXpwYytkzu0STupNUZIzf3U3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuNKUvrBbFInV1skhedUXxJ+skCkEhQx0YTlz+iOtDg=;
 b=5AQiOSxr451SyDpfXIVgKMWc1TLKgmAGYZwi2Nk51gAdnDUMkK8lAn2SyOdiRuwq7tXOuySdfGRcgyR0jnyJ86zaYr18QuI+aJUVtlzfeVA/i5t+e2In1LsdiS0PYiA0HinXAqvv48uCDX1GEcCKM2KnLxxKauJ2RltLkTWnNiA=
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 07:21:25 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::c0) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 07:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:21:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:21:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:21:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Arthur Borsboom
 <arthurborsboom@gmail.com>, Sun peng Li <sunpeng.li@amd.com>
Subject: [PATCH 14/22] drm/amd/display: Re-enable panel replay feature
Date: Tue, 30 Jul 2024 15:18:35 +0800
Message-ID: <20240730071843.880430-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 625d5acd-e136-45be-64fc-08dcb0683887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jcemDYqMYVrJwIhplMinnuNMFql/eNr/DeIlEjUSOvl6eCWkafFu4N+G4wda?=
 =?us-ascii?Q?UsZeCKKoHmg5QaErBLycI2nVveQjdh0emP1tnNCiq6NqD37jDQZEc2m5Pc/N?=
 =?us-ascii?Q?0UY7X6UoVZ02w+Ff4lz26xSU4H2YLHi2JjfThqPKC1O0U6AD/xzVmQQTPdEn?=
 =?us-ascii?Q?MmaskGV5Rp83O3uYN7O8fz8Auk+re6QFuR+QamV3d1quntxd7SEZy0T/3p3z?=
 =?us-ascii?Q?Wb8ah4kYALE30QhZ7JLFc3J9B6pcB2SLJK1k43APJCHIkRMqWdPAzz85vtvw?=
 =?us-ascii?Q?NebxKffKBLAdz2yAIEVNTO3ahQlPn/Lo5r6NjXrm+7zMXTOnz1xEAq653ZHw?=
 =?us-ascii?Q?2NRxHe6tgV8OA1Sqq5t3OoToqNVCz41dKWnBaaMorWdKAn8JPaTdfIw4tNQx?=
 =?us-ascii?Q?w4LLBuWvM+Lzuq40Wb1Yt8tJDNN8HCThmW/llEfzpWiJLojYxyno/953OTVq?=
 =?us-ascii?Q?3mCxs9mEf2HUgI61IO5y9VbXDf9JYeYF/fKlhhGDbzvqwOJvpV6lZtMX+xwo?=
 =?us-ascii?Q?4/2WRUfGS0TZOho5r7GxTgzsim9HhSjSoQU0Oxxc4iwXYhNgMYLzpiiYeRUa?=
 =?us-ascii?Q?Cx3WHz0Tuq5BMGre3rXrKJ/DnWNuz6BR7nEosEG7ORu9Fkgpvw0yioHvWiAK?=
 =?us-ascii?Q?0yO5TBQ+vsiHWI8coHQlDi7TjE4AwbQAvhC8BUqv5B4y3ntjoll0hf6dU9L1?=
 =?us-ascii?Q?Qf/+0d+XQgW6titPGbphFhVVUBW5+mloG/qIzScwdtCR9ojFp12i1O3aL6jt?=
 =?us-ascii?Q?qs6FTwN2Bt/Xmw/J+ozrqd1odDBKLyjNNIsADTHdcBwHw+B817tpY2dx00mN?=
 =?us-ascii?Q?EaYV1REhKwMxvIFMaNr9yXLCsphADxhSVsqVCXWhQwDh84/CUmU3EbbFSfRS?=
 =?us-ascii?Q?nzUih7NexIqOfYdKKiy6ax1AE00xEdwHYz+gFBEzN71UWdMHxZn1Od5UDgsc?=
 =?us-ascii?Q?YKI+Sf+3GdeDp9isKblCASBsGnfZfJDNKT9Og+UZ1OxIdZPB8ZOChY7f+N0T?=
 =?us-ascii?Q?KctZZOm5g+NaqajFSavD9WnKqExBlci6FkMHRyAmU+5923SzNdt+6pUnpU4b?=
 =?us-ascii?Q?aRAhalmYFo2kiMGi7JLSR8aMCldNHFYThMVokG9aQDJ9p0UELhWlJ0G+4yqL?=
 =?us-ascii?Q?PDby7DMdWF4LXy++QhgVKbNkT7YnQeyh/kFxfbqsUCWk/wp9qU+evsEmbNFM?=
 =?us-ascii?Q?RYDWqfQgWDtIPPQMaS+ls8wYcm99cteAOO33ELf7ePbPOL62jsbQk4fMcSBI?=
 =?us-ascii?Q?4Grd1TxwwYDCrJAHIT4zHx3Zo6fJcVp2w5CBQi0hf8TKnlEz4lWSxF6dON0o?=
 =?us-ascii?Q?DOTinbS+anY8RuSMnU8sNYsti4TSVdXUZDcBGBnZiTaY+pqDPe9aDxaO+LKP?=
 =?us-ascii?Q?EBm186NxMshQZkfL1ulgiOc2oTkR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:21:25.0627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625d5acd-e136-45be-64fc-08dcb0683887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why & How]
Fixed the replay issues and now re-enable the panel replay feature.

Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3344

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 293f93d1976c..76be6a09a184 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4850,18 +4850,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	/* Determine whether to enable Replay support by default. */
 	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-/*
- * Disabled by default due to https://gitlab.freedesktop.org/drm/amd/-/issues/3344
- *		case IP_VERSION(3, 1, 4):
- *		case IP_VERSION(3, 1, 5):
- *		case IP_VERSION(3, 1, 6):
- *		case IP_VERSION(3, 2, 0):
- *		case IP_VERSION(3, 2, 1):
- *		case IP_VERSION(3, 5, 0):
- *		case IP_VERSION(3, 5, 1):
- *			replay_feature_enabled = true;
- *			break;
- */
+		case IP_VERSION(3, 1, 4):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
+		case IP_VERSION(3, 5, 1):
+			replay_feature_enabled = true;
+			break;
+
 		default:
 			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
 			break;
-- 
2.37.3

