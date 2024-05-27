Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE15EC25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 07:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3722C10E215;
	Mon, 27 May 2024 07:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MFiavGv1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495CB10E215
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 07:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckJap9sEUUFRvm5YvfKdrE3GolWE4FYJAQDAehvrqqPie0V9fZqn965Ea6kTzIXWMdeVKk/fdHh+zbwShe5lipfo/fXH+jLMnhvjWykB7naszHTtxujtme5YowADaZcQMp38x2weXzn/gISCFOnfXdiQpGdSRYOrD6xbkyriarvDSLoWtbbii6TVj2IPVEgFSL6qv9bfZigeSIt4ndLNHCV8KsCvlnUmgu4sQpRzAQ2zqh9d9fdCSp21pXuW/f2ieoGnx1Wqe+FixBDJgKwvxWOhBeIYycP4Nv2d1bB9bzVz5PhAQPeOTy7wwszxD+v/wzErUA8fnXeJXvYbOMKfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQed9ThXP0rpJ+JHmMrBsUNpVlIo6kKmXW5xf34o3yQ=;
 b=T9FrG7lCgyxSXJgsA6GQQVFypOefrS7u0g75QOx+LbZJ1dk+RemeELsEPbOzIZPXN+dGbHSQDxlIRf0bOJTBssyUdUp3CGtMZz9qQWKoX+OMEqfZsK2rFZ9kscbRNGy/ex+kPFSxBixpgmK2xGFFT+u+bATHT+ckNyXkWcbWpzs61djydo46MShXj8/oOgDc0HvEuzbTWekKpAUQOevYuG6zA3Fn+O1a+M3tDKQua81LgDSZwzCvxjW8h7W8D48syBQtpGyfvyD0xxJepQpE+X4syE76+X4VZQ3xlpSa9xzPU6OPUMezvLiAzqrZ54RhYJLje1xTJkOZ97lqbTwAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQed9ThXP0rpJ+JHmMrBsUNpVlIo6kKmXW5xf34o3yQ=;
 b=MFiavGv1tAu93SQSXklv6KdjSmyugv7cRIAhmCiRA0wfKz4n5N3/q1W86+KbgaR3tM9imBvYgu+uz0c5O2wyHrP8JKGbiu1x5Gxf8Iu600slGM2CzWIt6ls/5qedAeWGUNAFiCfU3aXym9X/M4YjbXj60dBSKBXYC0TdmZq6qmA=
Received: from MW2PR2101CA0033.namprd21.prod.outlook.com (2603:10b6:302:1::46)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Mon, 27 May 2024 07:46:46 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::4) by MW2PR2101CA0033.outlook.office365.com
 (2603:10b6:302:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.15 via Frontend
 Transport; Mon, 27 May 2024 07:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Mon, 27 May 2024 07:46:46 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 02:46:43 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdgpu: fix typo in amdgpu_ras_aca_sysfs_read() function
Date: Mon, 27 May 2024 15:46:30 +0800
Message-ID: <20240527074630.284169-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: b543bc52-6ccd-4598-e0f3-08dc7e2128c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bVx1+sy9htsvdoK1FqQ/5Dzz3+d2k3OtwC0e+4Fw+YvnfnsoTNlmtgGW+bC0?=
 =?us-ascii?Q?wFLZUNY36K7Z7iKTQc75Wr+8f3bkVJfoUUK2maJ/ZdUpjHhxnIfAS709iRbc?=
 =?us-ascii?Q?2okB1zkQg3PhqHAwI4ysdSMTCSavxRagZPgLcg6HUvKTgek5/NZM1H6DAPAB?=
 =?us-ascii?Q?t5KVF1Eh2FvG/c7R+Goqg02kE3BNavsU/JI/sCHnQoY5oqvocVPRV4rwqYpY?=
 =?us-ascii?Q?0Rg62ndskCfePbl0NKvIlqsIU4n6YMJwSM9LXfWBQFETi7rAG3PgaMI2m5az?=
 =?us-ascii?Q?C8+aky4Fg22F53oviJ8GpMLuUwzvqbMh6f/WaoBtF1dCE9xVFRqmfa8QPqgM?=
 =?us-ascii?Q?ZHNp27OnGuld21fAwOU/p7URQ09rzC339C0tx0dNx6irofnGq3sRDRt7mBxn?=
 =?us-ascii?Q?n4o5/msL2mN+t2FzfeViDEjoBAWoyYygc7x0OMu/u001BaXWOJeRUeCiBpn7?=
 =?us-ascii?Q?o9h7rgtrSUsFTVlmbb0KP5f5otypvB60uD4K+f2y/eNeoYf3BkU5By4eXMIv?=
 =?us-ascii?Q?XchgiBje1QWJZ6X1ni8ALjxN5Ci7DW5iTOsKshMNQV7o3mmyDy8arobODhxj?=
 =?us-ascii?Q?guR7N7jpY00MWsd/INTq6SsN4yAKZPX4A6Lpu2QNILevrUeXVPCIofSUb+k0?=
 =?us-ascii?Q?k/hl3wkxMxe5V1J07CJYC0riieHJpbdknqd4/SjTv0lKiGU0L7wnRYUa3GH9?=
 =?us-ascii?Q?KvMrlyD1gvUxcAYSfcJi6nS2U4A1lvlxNmjZ/gs3Z/XV1Sp+qXTNPylOeYI2?=
 =?us-ascii?Q?/WXI/iB2H21s8b/3hYRqQWQgjTUB27N3sPEiG+xmLfRkIWiYjnrlwYdqq4BA?=
 =?us-ascii?Q?8EhcykNnKttZfXDNE9X4Zuw9errjoBFx3NGPaRgH3tFtL6lIDQdeE9jWO7k9?=
 =?us-ascii?Q?m0jpHCCkOjhJQZunhUKhbi78xatbKXwB9MDezJVb5V1heXPadFFqcIdf6RLH?=
 =?us-ascii?Q?Rt3W1aoTkBifhgi2yNUVlfepat0Lb64zfCbq3Av+g1PgfiAgaLHEkgvhrUPw?=
 =?us-ascii?Q?O0BD3hIBVQpfkNc3+TV0cGykk0R3QahTdSrrjALRYJ1fzVNjSy3M6w2SgvWJ?=
 =?us-ascii?Q?otdD9rsj/joTl8VFhBp04Hg91I3Ieq6ZUkyK6wvgoSevq65ZYrD6pkqgakay?=
 =?us-ascii?Q?tHrJJntBi6igmYeeuWcp0gCT+iaA47JZIQmtgS3lqqhkXFZzt4w39/8baY+H?=
 =?us-ascii?Q?Hjr+mMkf0qRDqk3C37QyHbl3AP9qDaoMi9Z9LLMop4AY+ylcbyLMfjxdWzL5?=
 =?us-ascii?Q?mx7r32A6Fsf5mQYCF7IaxuIiMpjzrxcKinI9VHZjKuhaKSLXessTGrjUwmzu?=
 =?us-ascii?Q?R/2on4IT8emQqDCvuMmfk8AJucFhIdFp9Vmh5bE0A8HMG0hsPt2atDR9vthv?=
 =?us-ascii?Q?AbE0RWc4yP2/exNDyZpd4xlewsy8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:46:46.1323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b543bc52-6ccd-4598-e0f3-08dc7e2128c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285
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

fix typo "info.ue_count" in amdgpu_ras_aca_sysfs_read() function.

Fixes: edd67b5417f5 ("drm/amdgpu: add aca deferred error type support")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8073716bc5ac..db4a811cc0f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1299,7 +1299,7 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *a
 		return -EINVAL;
 
 	return sysfs_emit(buf, "%s: %lu\n%s: %lu\n%s: %lu\n", "ue", info.ue_count,
-			  "ce", info.ce_count, "de", info.ue_count);
+			  "ce", info.ce_count, "de", info.de_count);
 }
 
 static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
-- 
2.34.1

