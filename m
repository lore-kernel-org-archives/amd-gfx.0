Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2EDC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 14:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314F010E7EB;
	Wed, 10 Jul 2024 14:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jwZLTI/F";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1156510E7E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 14:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFmA8xJs22CtnYlM9qumjQN3BGnx0q2k/xHKVMt4L324PSC6IK14oH4rdDwcGXvH1HaRAB3Uh6SuQ5xmIe0/Dex/eN9f/2xzXgLUP5gZv+WZe1h2i5HcGksV/mj8Z55IxJjaLoBPs748BOPNW7B0JMjdulLshetvVwdo95SJrGpaeyFC+NRz9BF/kvZxuwyjNTbVDJbj3/9YoOPi44dn9DAp2StEnqwqtzifL2Sl0lmQxiqlG8hKQNbtjTTaqv39XU6Dnu3BP/x1sFqp8toXr9hOLA4Ptu3SS5Q2tNdELMxMq/tfJPX+xSYKDvYt8oB8UA/BzBNad2qpCSVZ/KF5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5+v0mabOGss8UF2vhF0axqAiruKfXHpXruBKH3SdOE=;
 b=Fj0cmDC2PFfxuszh9t6rHF2rtwp1LcCoSlUVMZVuOjTZRDfSYb2T3EYS+rQJnVkLC+a0Frvn2poT5a4mBVI8JcBBN+pFAeuCQQ3tyJ2Pb9GgmA59p6NwxumSuaGs1hKQcOSbNSOxyT2nCU/NST1eAJVyLl9GFrykZfyIPedwU/tj2ae3Kp6KgGVct6TXIUfTxizDeu2H0jnSDK4WsZPP/66heJ/rg6OPyqZPFQ3PdFiF+/FMv0T8hxPqNrmK+5t8z1povrVlQMUR9X5pQbpJKpiit5QdD4wHwA49pT2ICIYNEOIFf/np/ZfqKCJw17i0RuwaYAiQvQjQDhXJTZz4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5+v0mabOGss8UF2vhF0axqAiruKfXHpXruBKH3SdOE=;
 b=jwZLTI/F/xNa85RAWvmTVQhlv2YQlEV8M8no+fm7+/Y7Y2iCK54tuJ54gsvtVsvMLbNXRa/X3Sz1vHi9MR3ZXP6O+s/7qimYowWmF6AlzKTBSnOf93rTyBW/AnyzWTReqRW9yATmJJIsk9hadmk7++FzWsweiYf4yoSJOqV+wt8=
Received: from CH0PR03CA0422.namprd03.prod.outlook.com (2603:10b6:610:10e::19)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 14:15:44 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::55) by CH0PR03CA0422.outlook.office365.com
 (2603:10b6:610:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 14:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 14:15:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 09:15:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove exp hw support check for gfx12
Date: Wed, 10 Jul 2024 10:15:27 -0400
Message-ID: <20240710141527.2224390-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: d2157f9a-49ca-4afc-d4be-08dca0eac961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KSO1wQhSWP2WonS+EJp7NQiXl3BshkBWk6WtSZD9dHOwKXJLZPpdY3kyKlnV?=
 =?us-ascii?Q?aJi7N8AO3wWq0APRIvNGT8EjGNhZxJAYgFS1ojbdhiDT+LFWtyE2lzU1n/tQ?=
 =?us-ascii?Q?7oe3/yFuAA2kkXZho0KGHpZdmjeVWSbfTIRgkgjUmJZRtro9PpEZ/RUlOCF9?=
 =?us-ascii?Q?JqJuBcuzZtwP5LSY7p/HIO3WMGQKZ8qkO5tKsQ+UmPWj3eMWGFDJi7L127D3?=
 =?us-ascii?Q?l0ym+VnRaX3A/zJrzLc+Gc5bsQ5xtc3gjLf+Jb4nyl3Id7/7kVMt+mhxC/Ow?=
 =?us-ascii?Q?JlYukDwuYWQk0xHMTDAS/rEzaGh/rlorOAvbo7OWTVKqmBX6MYr/PGMl/eNM?=
 =?us-ascii?Q?xIHmVSr2nreirWV5lr7KLKn/6gapAG9moz9BhjEQb30VglQvieHKQhA4DnKJ?=
 =?us-ascii?Q?iZEkZ9XHIM5RqWleVItVEky/uDEn2BR59hBoNB/V9NgUd9bo8a0ZWoYhz3QF?=
 =?us-ascii?Q?2Dy4UiD4QKQ7QG6FMA29D/sW7jMGxwV5F8SsPulezIAjA5VggkONoIvt8UFs?=
 =?us-ascii?Q?A52CDDsBXmeSi/5rjALu9JY0aKBHrXtytNA1EZBEA2ckZPY6EUkyYZy/CdIW?=
 =?us-ascii?Q?GDmORfhNzTHO3uwSVnDK/ptVvve2oPRZxr8TmX0jL7LXz2t0stlTwXDAPd2K?=
 =?us-ascii?Q?vq+3oDj9iYNfvF0u2OQ1DupAziRsYw9Fk/bVt3eDXONBDKHO2tQSfI5Fd0gH?=
 =?us-ascii?Q?tUsB5FZWHK6VfVFoIuJAThqE/T0Tf6ALuJ9OhOEWO5VJq0++gLlL+G11ZkbL?=
 =?us-ascii?Q?xLRi9MImsKNZww7/0Y1AGKmv9ay9HCwZOqdkdgnPV/gHYmm3H1054kW28+tK?=
 =?us-ascii?Q?BtahKIHgFz3fk+gORF6vYqrKIDZPfuwWn6eL1aDw/ESuVrgcbXHOq9/KMrkk?=
 =?us-ascii?Q?ldF7BGkoQDHgzgtYF5cFIjLyib/oKFHpD9uCBgM8LAmQQUJ9QhqWsMr7Lm/P?=
 =?us-ascii?Q?k/ob1v2oBO8b5x2KjfuTHl1aieKzgFTJ2g+zCVH8o7y6V3PaUs3ptFXP4pD1?=
 =?us-ascii?Q?HUm9GF3Y9WtSyqPWsc4/UpvJSyWcFmC3Nz+1mMnCE3JgY1Iu29SmJa8ybwik?=
 =?us-ascii?Q?wXJ1DmR9q5rBNFdY3j55NbkmqxActJNkcqp9dFCZu1jjcZ28sK8pIl/0a3J7?=
 =?us-ascii?Q?IbyPKVc3qFMadxGu25ZGJR1+s3KqxhxuBu8a0XVzjbh1awuvOR2Ycv9DAh6i?=
 =?us-ascii?Q?z36pYR5qLX4aeSDlWVxFYPr+Lru6NLW0SnAi3p701zRoO0+WOCm1ON26ttS0?=
 =?us-ascii?Q?XcXfHF9nz+5L1HyDRCUScEGlQm72ms90P5u++q+8RA8504NNNpnQyQ2RDSdq?=
 =?us-ascii?Q?uDz5IVd2SJN+lUuDQnC8QSBdL4IW4t0MYCdEDslCXnMKzZyfms7FyOjV2j2K?=
 =?us-ascii?Q?t2Hs5lxFXnF+NaYAIhma4FkK6ZncBn2ygnRKAhVVtTOo0ANqhqzeMwcn4di0?=
 =?us-ascii?Q?0/E0Az9/P53EYA71ee1v6IF/5ZT3oN+/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:15:43.8534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2157f9a-49ca-4afc-d4be-08dca0eac961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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

Enable it by default.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f927ccd7ec45..b241f61fe9c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2161,8 +2161,6 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
-		if (!amdgpu_exp_hw_support)
-			return -EINVAL;
 		amdgpu_device_ip_block_add(adev, &gfx_v12_0_ip_block);
 		break;
 	default:
-- 
2.45.2

