Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E88C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C155E10E92B;
	Thu, 18 Jul 2024 14:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YuHHwbAz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB86D10E92B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3FqEQVvTXzs81whZ2BYsl+r6Fj8swDsTmS/GV917+N7rlQGnCOn2jx3J/z3KCaG0lob95bY6ose1qM9yucY5WVufAzmBWWtsmmqYsX2f6FUS3KG863NCK1/uJ15wq3coNFD9Ipw3ogNso5xbxT5P1RRB0VVPur82Q4LrFk6rttI3WA9yS9jaml6kJmZbDwD3qR9DKaW6uo+FupwxZJ26eQg20edCE1yjiyVZphYkZTSYzUiEKOFW6PJOA5+cNE0QF5ErI7J1SWHFG7sVsI7z5UkM6p96wkiQgeY5LqgAJQ3XHDnUa/YL284I4fPjXGdd/oOgb6kq4usNl5r9xXxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1AFJTQNKNGPNxtLUwVkrS70sYoDqSKZ9IgnSNnspKI=;
 b=HLRIU7nBq5zRe5Xtxf5Edzo3BcMd4sHU0UhDQxwDB+0XDkkKo2yI3k/hxffV2cjgnLyq5etCsdPcUdrP8FBewbu17+1SuM+j8Ns0r9pFP6kod8Rd7vZ23QezVwZIi80JVPf5rTmynZV4dqEVjPviRXLgnO6DYzp6RAugLktCH01fBVFb6JLxOcra6OFsp+iaoAd+K1tlzCiKtchPMLEDT4ytn6/v3Z0IFbiT90eycOW5q+V3SlfzK16Y6yZVq/jv8jEXw8J1Ev2J5SUdkDI+gJ88/ye+qUgWcsW84kROmMGleBytvze6BzXA6mwG78YGeQPss/s1sQA61rcJEeNhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1AFJTQNKNGPNxtLUwVkrS70sYoDqSKZ9IgnSNnspKI=;
 b=YuHHwbAzCH99Jmm7IF/YGTrWS90JHPRjByBAwBrtOavwNU+1Fy6u//ifv16PUDjjPZQifJwOGzZjREJ6wGCQ7zyKRrP5NyOAmzn6ed3lTyC79eJg2IEdEwEBlaBXFddjz/tczhekG3sTLnQPHUd9cIgOPB5p2cWVM60KDerCa9E=
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 14:24:04 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::7e) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Thu, 18 Jul 2024 14:24:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:23:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/gfx10: per queue reset only on bare metal
Date: Thu, 18 Jul 2024 10:23:42 -0400
Message-ID: <20240718142344.1738604-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718142344.1738604-1-alexander.deucher@amd.com>
References: <20240718142344.1738604-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c806951-c0b2-4c2a-316c-08dca7354695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FVp/Bk2VRltoFYFGre1GxiU8RiD2DHJuX25nJb7r8Pd2Hve7BwmGprGs+h1Y?=
 =?us-ascii?Q?VbK5uUcjM/IcOJmJ/im4XbZb6kwOl6D7amHQtUgtx9+376OCXKk+85i1ao1s?=
 =?us-ascii?Q?R1CBbqtCgss1Q4N2/wdzYVRHRFZIxDMh/guhw2igCrCKkvqtjB3ijCkTeRmq?=
 =?us-ascii?Q?hVI7VEXe1MuesxHTb3EpIP1ZvHGVptkrmrXrizW/gEuvXnxIU6XcLdAgQMS3?=
 =?us-ascii?Q?gXhMbPRDTBdrSnSWTa2twAq3nWhBnR20ZrYvNprsxfpirDhflbcUTA9+TJiI?=
 =?us-ascii?Q?dnr2aqVCbyJOBnSlo1pk8Mr3MWX4tZrrwIZMuNdisjxk2iFVkzcJRVSjjC9s?=
 =?us-ascii?Q?XojsfAmYGSVWQgYaypoKQERow4vbnEbuRRkuG+of4H0GooUG7wq7+b+KTJPJ?=
 =?us-ascii?Q?tfsjiZWj5f12WCui66cHYVv6ZnORZQI8m7yxvFEHs8UzvY1zQtQAwT3C/EsE?=
 =?us-ascii?Q?ZwWaZ+rcl995X34eWpn8hkm1dt7XxfnRzPStPTXGgcjKkQnpeNXoNJEcrNKi?=
 =?us-ascii?Q?2tDsrk++3GWzRuq6GtwjDzMlf5WvScuKLN+H77VrL8iwgJjXxYzoV3nSdUXT?=
 =?us-ascii?Q?quDQ873F0valISi3yz7jEpJ2lcBH+RGf6V6o52Zjn9ffxxCYZPl7Y2uyaLT0?=
 =?us-ascii?Q?6NXMVDYkL1aNmUKZ0t1vos3FhThNcIdTZoCt8Oxv2UR7zfHgcBLdj19RgAgY?=
 =?us-ascii?Q?2cm6IFStWGkYz/iq+NqfRi5lTZaQFaJw8DduM4YzSFxK84/d8fbrt/Xf0mb/?=
 =?us-ascii?Q?/LDKuWC525nF2zAw9nMRO3Xza6U4TCZQAM6seEENnznUniJuoiKJQK/BGnQn?=
 =?us-ascii?Q?Cctnshja1dXRGT+XUd3EZxGPd6hNcmr+scQdoEKLWB1z/7nlKRh3NBGyanNg?=
 =?us-ascii?Q?WsRH4v4NOlPqCiuoQLc8k8xgpk5zMUdUTe/oncYksgKDyZiuvcCz9y9ctCAd?=
 =?us-ascii?Q?uh6xn1TRZ1khAKUzWP+gdWRpUSWa1X3EEuoK8onvfpNfC4hPBM5xdCQ3B76+?=
 =?us-ascii?Q?xa0BeSHv8iAIVCkhQYD+CoPk1fE6/2WjZ6aYFAdtzEnAXoEPZTSVnCRcWxwd?=
 =?us-ascii?Q?sbtZ7lWR8YDv9C7vas9kQInSdUnpmxnKSSTvdcVtMZqIwTf0H/euhU8/wO1N?=
 =?us-ascii?Q?1pXqJfyAA97fB2Q6MlQfeClTGJ6lEf7z/3tZ5VBqJiZkQE/cfYLlGBdhfGit?=
 =?us-ascii?Q?xxSN81de6hGSJ5erqDAix0SKPghkd9piKU6F20/vzo2PB71hHxuisdpoaaOx?=
 =?us-ascii?Q?030V5i8hzfp3OUW3/mx/7XH+R+TtmRG96lo1rlmS28TSPk6efdUu1/heHhia?=
 =?us-ascii?Q?zME7E8XPW172iOB3VHXxhfJiPghF575r9UYAwmJzG29gwwwnyQ60qDjnBjHm?=
 =?us-ascii?Q?tFOL9AF3T2UJOg/cKCBQvhKvS2/ZyEmLTSdtYml2N8X1RGxO6JIlCcFOcaGm?=
 =?us-ascii?Q?og+M1XTXv5pWAv7LfFxXP0ShGrcWVn5k?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:24:03.7493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c806951-c0b2-4c2a-316c-08dca7354695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286
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

It's not supported under SR-IOV at the moment.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b833943faa53..a8f26a311faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9464,6 +9464,9 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	u64 addr;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
@@ -9527,6 +9530,9 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-- 
2.45.2

