Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DD9C3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FC610E6A6;
	Wed, 14 May 2025 17:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X8s3DfgW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B261F10E2CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNWxnbw5d2Nj1lG8lsdgdjUnqzwtj7nD1LUVrA5ugWv2o357xjhUvz870qVvC80RYZYiGV5f53FBiudlwYddsl6QLXxF2JVMkZnp0s9q7AQL1xLZ2ljpLjP1Mc1cD/gPXySN6+Apesx1zt2VPfsmUw92qB/DZp55Q9+14T/+n7AugIlHsJ/rxW38+rtouH3uzoY+fq/hlRYgd3flwZMUrvzwhQxagJdd19zvtwOYeebjSJ2G414O+aygRAXh8Gq2lLVEQ3kja/X6V6juHLjWjbax32dbgHoXMFfZN7XBHfdVJ38a6rT2GMwQsa3pkceK7wJvVLoZsoXINXskIjXo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXhTz2WzYE5pDpkUdUGvSSyi+7GKr0JN7wKZqsDOgzI=;
 b=oOKRrifs623U2FZfneXxuh8sBd9dosjlcDvW5acsO/se4iUcbevuj9tMxmrRtJaRhoW6UvbA2aziqb+d0vJnAC3kAY87ORRVkCTWLeJuuuSWSsRC2FR3/S8c8SDq0chqHjMypDRNBKGcDuHZ0JCDuRWlJsY9AuGU9N+Z74n9MBuzawc6IwhXteN9LabYkAoEfOOL3ZoZRfENM6l4qfUNFIpC7yV9XUp0mwP0xvIXjoqK0RvmwCNUVneZkDkVX1LGbmMW6YruixgDMMLLSc/NCR72xA763z2Pl56YI5fgxBJ2LpYi+QUFx7zNXqJVfdH9Q73sZwnUsNEOutESVLDZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXhTz2WzYE5pDpkUdUGvSSyi+7GKr0JN7wKZqsDOgzI=;
 b=X8s3DfgWegTiDN531RiGYE9vWRwvXuAmIxdHJNtc04wfCCzbl7bf13qp4Ay7H0s9l1WGsPakzqyfoK52P6gkNwX0/zsdE81HT9svMFoy4JK/T8v1mZWPDSJcSD0aGZvX5AZHurPPDtArQ+4uz390O49Kbtc+YfqHCpsVsY2TOmE=
Received: from SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 14 May
 2025 17:23:05 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::4e) by SJ0PR03CA0281.outlook.office365.com
 (2603:10b6:a03:39e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.24 via Frontend Transport; Wed,
 14 May 2025 17:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:23:05 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 12:23:03 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v1 1/8] drm/amdgpu: read back register after written
Date: Wed, 14 May 2025 13:22:44 -0400
Message-ID: <20250514172251.726484-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: b145ef1c-b3e3-43a1-2e14-08dd930bfcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yJrK/h1Rr5NsTMvaW6zV42VRI+er5dhXBUbcZ0Lyr+khJvV3zRwqiYiDLUP8?=
 =?us-ascii?Q?RVY/dRBiEBfY1RiSZ3A7SPoC1WXUSolyoG/1QpRj/4rVEyt4ISWW1eUt3TfX?=
 =?us-ascii?Q?bmWDGoA18bzq8watO5o6jiChr3aGTQAd53KAa2jjnnF/YYx8LYjOAaGVgIen?=
 =?us-ascii?Q?eou9+QLK2OTdBGNPsvUnfVLUp2gWNmyD+Cib75ouA7Cl9KHebtqlS64sOW6g?=
 =?us-ascii?Q?7vGuYYDescGxTk31uESMic7ej+inamAIa2Skr4QmQUff72Jo+utdNMrMLKCl?=
 =?us-ascii?Q?23wtqaRaGkcLAxbm7UMvyefxLvHhSoic31pZ6kMpwt53ZXo768laRob/bfM9?=
 =?us-ascii?Q?pLnsb4RVifHcwiUyKCmU8J2ZKx6Do3XY/IkjFSRwCpHiTV+ONvgCUHARudet?=
 =?us-ascii?Q?g0iVBwlppzgAtL7YVhcZ2Xt7OcczmZ0R3fx6Ygc1HhxoZxo37YPFwL1JbgrJ?=
 =?us-ascii?Q?HxuESZ41HQ3szhBOHMGMgmNNAeMKEum71xt/gm1GtTpT7bGEuTHqGORanb51?=
 =?us-ascii?Q?X7YOaxH1+tozpkMnVqwjqLmVQnRC3k7Go+vyt2RS/RVUFdjZq/9drDa95DLb?=
 =?us-ascii?Q?Q8DW3h5yYQ19PxOdi02UvYkk9n4C3lesWgHU1sw0yGDT4yMA4fILjuwWN9pI?=
 =?us-ascii?Q?/Rd18Vrv0T0b2sxljd8fM4V99AH5hVOG/br+MrdKBUAiQV9AA14OIyLWvteg?=
 =?us-ascii?Q?RpfPMxgtBtAt2JWjHWOe8YlentZzONOcyu5R15t3kjnoG0bns6izG6APL44C?=
 =?us-ascii?Q?fEcyRoC2qICyC+1jQn9VbzzBvlga5RA2/59AMIXvPq9Pkom26FqSbO7BX7PZ?=
 =?us-ascii?Q?ur4pJ4FjBy7aVgSLTPqXWK1LDAOMCJvMyzhkppo6rke0l0GgxyrvP15fqju6?=
 =?us-ascii?Q?QqgWtHnB12K8N3sl4bR1kg5jK03n5/EYvcrU7jwkhVgUYUnP1o6hkTZDfgYr?=
 =?us-ascii?Q?D2C1poao8yi70IDP/sPs883VkauwT6MTkyu9XyxBG9z39eLieGsWq5oBhI0w?=
 =?us-ascii?Q?RL4kDynorNTr7C2OUHP1MpijMxvCeDebshgAZgdqwVATVrctou3kU1Gwi9Td?=
 =?us-ascii?Q?bmYAw+LwjOQqEjVok+HLwQSc2GKc2WU7kbtJsbWCfdUSTNJ24Shq9okv7q2u?=
 =?us-ascii?Q?uIQ0+37nDqd849678yAjp6p6H8GHwIIOQrpfjK1IG3/KeP3UCRyaVnZ37+eo?=
 =?us-ascii?Q?GQI3lyxso3SW/Mzt5tgq6TExO+ovQ++B7Iv419yyqYFZk04Pd9lcJE1ErKv9?=
 =?us-ascii?Q?/tT/7X/wow/IiZZyiAX7vNbNYxG77msK3+fi6BZzq5O9GoNi+dnVVxzUdeQl?=
 =?us-ascii?Q?K64GWlhZyzo6q6aFzE0K2G9Ivw/ftjSiYGo/Cplq4UermH9NZjgmgQnrHic+?=
 =?us-ascii?Q?P2oNJIZ+jxpTSptH7j4UqBonrOucEp+kErgmUELUKG9whZpFWbBiLm67Jg5x?=
 =?us-ascii?Q?NUr0UViPxCziOVBxFzKOHqfYlLETaXCDNv6MXkhQaJB2V0w9d/ae75z6gDL8?=
 =?us-ascii?Q?TzbKCCmYgahD7oCFGDKsnktkOS3PdkriLfst?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:23:05.2596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b145ef1c-b3e3-43a1-2e14-08dd930bfcee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
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

The addition of register read-back in VCN v1.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 21b57c29bf7d..f56b623713c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1009,6 +1009,11 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
 
 	jpeg_v1_0_start(adev, 0);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
 	return 0;
 }
 
@@ -1154,6 +1159,11 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst)
 
 	jpeg_v1_0_start(adev, 1);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
 	return 0;
 }
 
-- 
2.49.0

