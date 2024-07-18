Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FBC3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8570310E921;
	Thu, 18 Jul 2024 14:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pPteJ81i";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D533B10E921
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2QtUwhomfK9AbUisWNiBdK/ztIrMmAsV01MU2xn9iNsmTmTXi98MNT6ZvNQHvhfjRprUmT78J6J3+00OuVYEu5EGo20+/+Fd0uGBtokcFTM/j2m4itygQ/sgTdNDODDH7TFH5X98+DABuWGUarcmDZy8J7HC4MgEknNrRfXpvk3aNwAyaY/bZ3q5VIgzXvEABrTAsLWr70HsOKr4FK9cetUri3bbrAvrlFClv34xSFgoh9i0vulFRQ68BviJSqa6aOMSFgeVUkF7u4vZbkMuDTPUb1xjAreEng+OF7U9z2bWiW4qj36vp6jtSX8TVKXV0ElKDshGVt/vhJeRhukig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NShPio+60huOKyhy2Qk17emxBmbt+20REfdVYYltJmM=;
 b=GJ8czD51fCM5yWvnIgihoE79m3tKzbFRTf4ihiy3SIpF3OUoLoxPjo9ziYdJBqAMYmBU5HpVUDlvuqBz7ZBTpPAF4Gv1Ch41f8VB3Kq7e54/DG+NwsSr7rWKKJ5uEDfMhI8P0oXpJfclpKUUkM48g7I+Yg4cBnRcPi6NYZ+wRkFM0cmlqaghS8R0+pFbEQCcIJvuO7mCmlK92cIIK9aC5kmn6UaVBfRwYZR0uOFj2JN6JHddh0VtXnUgnec6cjzikmlvZ01ldezDE7eNcbRjBoqFz9ODB2+hR2xXVv59R0mXkg0Aq2SIRc8GYVcfc8rf3slsbpc+HgVB9McCAAkHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NShPio+60huOKyhy2Qk17emxBmbt+20REfdVYYltJmM=;
 b=pPteJ81indCEHi4i7hj+7UyoRffaCvr+noyR6rA8J6iY76W0veMphWfkOljQdZE2+AT0ozwsJcUkDnUUbQM3jA2f1YyYa/5P6uVYb5JjlIxpmpadTL96P89/ywxASk7z/tubG8ia8UfiUL0360Ex7RzyyJx43K1U68LJP9Yxtto=
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 14:24:03 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::52) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Thu, 18 Jul 2024 14:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Thu, 18 Jul 2024 14:23:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:23:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/gfx9: per queue reset only on bare metal
Date: Thu, 18 Jul 2024 10:23:41 -0400
Message-ID: <20240718142344.1738604-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 1994657b-af41-4eb5-4aa8-08dca7354448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EpFw4Dy8XtFcGKHUXcLtSk/HG6QocNKQhYKT6e0JHqbcmAf2UKLELvBoQIbh?=
 =?us-ascii?Q?KXWQziu1JPAo/BwIWpEqUYWnPiNBeGge0wDjoa9dWax58kUmAyAhzAiAB/O0?=
 =?us-ascii?Q?UYxL3XFbpHj3kz+nz/Mf13J+si8vFL2M23W1RUlL2kXd5OHij9Fkh+LRcioB?=
 =?us-ascii?Q?SGjSbhskwRnjrAlN0Vw4a3tIBkHT31nOjTXgmlyZNm3N1yWZ2Y0ltJX1HXIg?=
 =?us-ascii?Q?szPsr3KDS/jX9uuGBddVgw0IOTZFTMpvnYSp5l3nafynC7ShEnjH61fUgiGL?=
 =?us-ascii?Q?2OnvruJqTF9YNTNccu7ilCUUjnznSexoIL85bthYXlH1R+l9lCO1iS3t0zxb?=
 =?us-ascii?Q?EDI1ChYQEiYNWHLJw4PkCaBuHWJ1EfCYPG1enFSFgdSta99c21U07aTSk6cx?=
 =?us-ascii?Q?g0vsCWkX7dRG8sz0LWgxmvjPypC6VtMPf6LDxv7nF9+0FdEuNos43M1IYmUy?=
 =?us-ascii?Q?Y185JkEJxezYaKlJMUyt3lW7J2w1q/LOg02+eykv1Wi8czVv/t7rWI46dLJi?=
 =?us-ascii?Q?zfgJ0g02LqJlWzHf0CnIOYWzKO6ClwtH7dowoCNP8Ec6Abdillwnp/yZPV09?=
 =?us-ascii?Q?mjKfu2EEOLXHp/wKyQ0LOc1dqhQBvlW/rSpHB+gfKdzn5j7FCt9Y7RlXNQvK?=
 =?us-ascii?Q?4BOwvmUK7PYX/GuRDTV0o8GufC9VWUDFEWAP87EqVZRhAXw324Q63gImiaMd?=
 =?us-ascii?Q?iU1ZtVzVwQ0vNLq+DILhcHw38zM61A37TAdVNcAp0BIvnOQ5fLxcWXHXVJxe?=
 =?us-ascii?Q?oNgesuSBLdzfB/vZTdQJUoIkM0xEBFkC44NTR0J+e2tK+1hCOqsaJ7OruxgD?=
 =?us-ascii?Q?j0KlcsJiggUsbMXBdXOCojMt4Ygo0xiCVxmc63mvXExBosgGZWOPU7PcoxM0?=
 =?us-ascii?Q?a+dmzF/28QG2HW+vPrtmvH3SjB/V9el/wpzjgqmyE1brKvHoa47mETFssM65?=
 =?us-ascii?Q?0EBlCLGXSWF0+apAuKjrj0FLnTP0f1UYlLuuZfg6jeNcXVkwmaobJu9qeF4k?=
 =?us-ascii?Q?L2VnVs6yNnwB58ePHrWKD6BjNiaixW5rIrlmaC/Zfgd0nEdYXvuEyZH6Yu9R?=
 =?us-ascii?Q?sE0D0sKbtHlFfBkmVMn4tPLfNB2rwiIZuH1BbKb0yLG1a6THr6rrk1lrQZ0t?=
 =?us-ascii?Q?AQCmfLYBjJyBHdrdNsBjx8HqjTciH5aP+2qYW+RogZpyL8T4JyFYu5JrQhZC?=
 =?us-ascii?Q?z3vKl6DaUnxWNqUr4XacHHbOooRTUs+xPB2W0jsHe97AZGYCqdn9gYqoYBiU?=
 =?us-ascii?Q?nT6pV23Z8giTnTUwXIKjsx6ss5OT3hHJC3l/wPv/UHDeUc8KdFnKyckYfKfN?=
 =?us-ascii?Q?AigmmJAdbugYnussvbOpc0ds+bUbpMxlN51oF04Q6TBtRBZEOaUqVWT+DCFS?=
 =?us-ascii?Q?PBnfoexwDMzwLRu1650FYP6XK6rNsXtXX7LksOrXgFxNFT5lKsxlTAPN5B9b?=
 =?us-ascii?Q?RX0qj0uEeSpHjg+NcJRB5veaakvBF9aX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:23:59.8898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1994657b-af41-4eb5-4aa8-08dca7354448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1a04f52ce0a3..ae23a7848237 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7146,6 +7146,9 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 267d5998bb80..eef4173b771c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3308,6 +3308,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int r, i;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-- 
2.45.2

