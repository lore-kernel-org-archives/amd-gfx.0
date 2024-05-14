Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287BCC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF94410E127;
	Tue, 14 May 2024 06:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mD3qXao9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A748B10E127
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k31S3ngSJg0YxWvyyLVI97X9rdeJDgwSXP1epUti5S0WiLW5gty7vIhqEYLrpl2WUP/KRjePfG/Sw9+0d7iasP6gyQ782aCro1dgOhBErwCfIYOaigG6E9ZWp08B5/xtqoAfL8L1Hiqi7syiGN96bDdVxYhG6pCC1iGpi984ItoPr437h/J8uXjV01b8VGj3fE/3Yv6YXuyHNdNw01Pyl+dbAYIJkUaSGU1NMAxaVRjKU8cLWIJ/dqAxcFs+zZNNH34Ul2u3JeWAoceXuzvyu95AhnzZmUM1bOJOmRFWXOZprLF2cemw1rxOGe2EqwUAVkNNF3IZLtUeBYcwmJ8+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9NSUAyIHsF/hDlzm281QYu1gtmfopCbsOLWiuEuObw=;
 b=A79HQz8wNtiqqNFR4iM7yANWwmnJ988Eqrcz3VvWt7g/SQpWIRHiqNzTgbrHsolMV9ehj6RVOvx6d0DUA+ZUtO88frCnBNk53LHOcpSP/7ubSv31U1RFD0tRDfiMrt6E+D5b4HyNEJH0RuB4uUshbR7hg83k+tACjDylDhO0FOjfptoJA2On83oAMXOJHMYGel/v8AIWvFFpsFqKGrq5228ExGxLgr9S+pjy+0Dw0IlFzPba6J0f+L+rEe1YoR5/DilKSTMZpjIWlogZPsZ4t5RnfKtFd9989ukePlA8xE9dcCnmWyDScTDBmZW51vQeQMmNBs9CKpua3MJULeqSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9NSUAyIHsF/hDlzm281QYu1gtmfopCbsOLWiuEuObw=;
 b=mD3qXao9LqXeAS99Ca0i41AzWvKrKQh3Xx4GhJ51NaE5RIhsQl9UlcRnOmJKM4XSmkJqModIJCxWLiz0DRoRzMxUagIKKr1dyxETs2kx8+ucKGUC9nFAdB4X59KhNyfncuodCPjk2UHJ7i4+4Nd/TwGJCa1UAwJyTqUuzL5xYPs=
Received: from DM6PR18CA0034.namprd18.prod.outlook.com (2603:10b6:5:15b::47)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:53:59 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::2) by DM6PR18CA0034.outlook.office365.com
 (2603:10b6:5:15b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 06:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 06:53:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:53:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 01:53:56 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH 1/2 v2] drm/amd/pm: check specific index for smu13
Date: Tue, 14 May 2024 14:53:50 +0800
Message-ID: <20240514065350.3651551-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: bee01d35-8928-48e3-1d1b-08dc73e2a1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CcKM+C0NxzGpcvQ5gweo91smBahrMBIQ/46txBVxPMdzOnxNFxB/bZnZdlRL?=
 =?us-ascii?Q?7z3zUEoG+rYvu1hubvXKobasvJScIZprOouzLmPiSfjACE5h/73GofDyePaM?=
 =?us-ascii?Q?uL9ph/bC5xot3XH9gIs6VYfd6puC5kh8iqcNo+Qiq5epbLGgKcUvofZPBl5N?=
 =?us-ascii?Q?F/0CRYUEPLkiz2Sxrk62/mmlbebzFyn2T+T1k9U1U7eg4MnxYBlTX94HZnJc?=
 =?us-ascii?Q?2pFKm2jM9eQ8NEykgj6XatLEup+7Sj5mSI39/w7CYWHsyMLt+gi72GhI9EDt?=
 =?us-ascii?Q?39KdV6oNQpFel/Dxq0wspLqpTmgzrftPl4pzrDPRASDqs+fSHaIORr4SdBR2?=
 =?us-ascii?Q?Pi0Y80kLEDZfMZ4ORdQkBa1y/v7hw+GjfWDxoD58W+mUgPa8D1SotuPT9Ic+?=
 =?us-ascii?Q?mGjIHqkcTHcFfzPNVwALO9sTNIOAMWXbgsnqW72+7bvxPalF+dJMdKoX1qsX?=
 =?us-ascii?Q?MM3y13Icn3OPI4jBYCXS7BjUVnABF/q1qZKkD41QRYpf7fxRo6Pr2krRg/8x?=
 =?us-ascii?Q?ZexM7FINS5a/txKtS0JnsoVHEos0vfS2qx9vbIk9XNvORJ93t2SKVdFHwA7J?=
 =?us-ascii?Q?VIm0ATHFn7e+5Kf+ZNut2hIlBDFyox2Rjm5diWT8vxu/9B8BB2nSc4CukgTS?=
 =?us-ascii?Q?+pz9Ik2UuCf7ztYjFW5scXV68yKbNPbTkD4kvKnhMQ+OZH79Ikjv3gRilf3p?=
 =?us-ascii?Q?3S0zoiQ4sKo7zjMfR3x23ogylmRwuHVRMILNKwU8Ca3FTFcl0m4HAvxaACri?=
 =?us-ascii?Q?Msrvn4nVmbRo6v5js4PiYUNzfMy/wYTFCHkidTFXeKVN87/zVKbh0vOIcSXY?=
 =?us-ascii?Q?wSUpsnYROfUsTenKwKclv18H8ozIOytaPtf4GZr8Aq+Nood+FNvaHf2w2zxq?=
 =?us-ascii?Q?cjCILMlUGVfJwL2AVAvj3oC/7q48auC3O+FWBM/MnFpD1ZbzrkeGLmD/Nxj6?=
 =?us-ascii?Q?uIafxuOt1hi5jNSJkLfNY0YBIYjhtfEnrQMHkAf+itkBGLiw5Yn2eY1OQS+p?=
 =?us-ascii?Q?aBkYQN/nmMqXobx3AQcHn32AL2x+zSCKC3rdVJ0Fx1L/RrZoP+S4X30o9bX0?=
 =?us-ascii?Q?8/bBexZZ22Uya0p+3JoLcMQrCBD0eU2uhH5FSYkQHoYdGKy3Xq8SGDqrqvQz?=
 =?us-ascii?Q?x466p7LNmL8HJNmefpRjldMLtsq/c4iI1pagulAFbS4yL7HodWVkCXpOI7S+?=
 =?us-ascii?Q?ewwT2mfBffQi/ovcCS1iRBGUh1BkcXJNh8nOt6nIORtlGYIl7RDZEIg0nQTP?=
 =?us-ascii?Q?U9lodZk2xse1L7TTLe8yuAY4ROkzTdubGGca6d8gxmzUUkZbhXvBnX9x0I0U?=
 =?us-ascii?Q?MbRxb3C3PnLShAyU39HbUxaKP6wNFNGp+9HmsTjIl7n1goMtV9zrFxPpx7LM?=
 =?us-ascii?Q?RhgOWaIW2EhJCm/pri8Szy1XSswK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:53:59.4180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee01d35-8928-48e3-1d1b-08dc73e2a1e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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

To avoid warning problems, drop index and 
use PPSMC_MSG_GfxDriverReset instead of index for smu13.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 46ab70a244af..27ec95a4e81d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2330,20 +2330,15 @@ static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
 
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index;
-
 	mutex_lock(&smu->message_lock);
-
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
-
+	ret = smu_cmn_send_smc_msg_with_param(smu, PPSMC_MSG_GfxDriverReset,
+						SMU_RESET_MODE_2, NULL);
+	if (ret)
+		goto out;
 	/* Reset takes a bit longer, wait for 200ms. */
 	msleep(200);
 
-- 
2.25.1

