Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8905C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 11:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9579310E179;
	Thu, 15 Aug 2024 11:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iEAJ8czj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDB310E179
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 11:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frzMgSLN0grPBq2YWJ/QYo6TqpipvaZbK3leCooeSS3sxhiJOR7rQf/fUKTkabic8WqKoglGFEg5iG1i6Gg1vl1fMMmWsdFEovES20E0xHrsnCkfE0bSGr0eP0M0tilJM8whOX274sa0hP4S37v+3fNjZqJDpQzhdZK1pXS0eukfcFGyIFW3hNVC8GvNeZOJP0BmzurlXUSpwjAD++KATdsWoNJAwpLj+MOov43QbFi89rD+o2mU6elQeXcP8CMVsT2tg8Y6F8eiC5lhcQdWDytzkPeRscxJMny1QL8MAVEJ76dnkJrPVojl1bS4i8twS2OTqloNyOVAjFdbtvbusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt9iijtc14/w90mOEAXf1fv67/A6msEO9F7XVpkIrzc=;
 b=LT+7zoOAOnZbrh707p8sgdBgyQp+oLzGxpvc7nXpA4reZO2Z1GfDnN93eplCdyb3hGFH/I9FD8M6crcpxej84XN+Ld9kgO1r/CP4KiERB+DiBxHeBLWthMvbcgOhItCELi3rmZIM1OIjT4DzadwO4EKXtjD8d+fHfWQxxkzN7CkOZXYaf+4VnWCwntsp2VxcpE0l+ldfNkVLmtGT9FkdSCpEDCZ33ILzWiqINxCM5DwLKIq2I9KPue8V+MiCF98gc19xvKLpBH8c1pRlS6rYymu7Y4rJtaHFNpoRminb5fzZhEuOJeVmX5wdwL9n3qunsC/iqaM3vdFNbXxHp89aHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt9iijtc14/w90mOEAXf1fv67/A6msEO9F7XVpkIrzc=;
 b=iEAJ8czjvZMsmy6MPRMw8W7EScyr8aiZrj+scVRD/PcKMuHbqdJcyCN1/GlMvasDZYpdAEvx/pYDAVJZSBJwijBmG4HqgUjvkez8TLTrGxaFhFiWo//GP3FMpU2taw7fw5ZgIOACxSNzq49X0T7N1CQl0BozRb3LFrG4fZh0WBg=
Received: from BN8PR03CA0027.namprd03.prod.outlook.com (2603:10b6:408:94::40)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.25; Thu, 15 Aug
 2024 11:38:52 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::a4) by BN8PR03CA0027.outlook.office365.com
 (2603:10b6:408:94::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 11:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 11:38:52 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 06:38:50 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 0/3] Improve the dev coredump
Date: Thu, 15 Aug 2024 19:38:33 +0800
Message-ID: <20240815113836.399377-1-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 914e1cc1-e893-48d8-9127-08dcbd1ed67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tNgQnf/NtUDEhG2q08flqxqK0tDKHwDZqv+9M6QltNkqLGORX1JdUl5qtrpU?=
 =?us-ascii?Q?Q9G+/r+LETCO0Mvvxho1mtoR5lkYt0+SUPYNRFmHfF7F1ogpbU2fiu4zUwkh?=
 =?us-ascii?Q?A2bMoq+5XWiQx+dahE1cz1ltBz0Uk6PRvn5n0UTgaADqC4GWLUt0Zr8jznNO?=
 =?us-ascii?Q?9J0/caYAGCRPdwwCvKHwIh5ob+sf40SGbyxZ2QbSrYsjMZ5bOmJkfpozGQih?=
 =?us-ascii?Q?aEX2cvG5joQnC0Sg0bWgs0S1oFMFmb0SaYorhnOEw6ktC2g85zV8G2tRcjKN?=
 =?us-ascii?Q?OoEM82vHOH7tsKXr5TcrBsOFp0QD23/uvk2EMW5IDAdjISiwS1tK+mCuj3JN?=
 =?us-ascii?Q?2WG9Qoh2ELq59U5hDWAtEFn6k+c3Sjm1iMXwLd8temDJxkhUMdFv1+davahI?=
 =?us-ascii?Q?AbX4qfDryrcAgN+Y5jXQrO9myydC0CmDZqYkL9C7psVhRHkTT1E+e2j8iN44?=
 =?us-ascii?Q?7tKwmnaLLyMnZfxV3uZlWEkefRU6tqNvANp6zDjvSnk2Nod5MIOMrjRnBe2W?=
 =?us-ascii?Q?TTZBTSFfLVBYXL9iwgryPV9Xb6hS9nwCY0PC8DUqvmj/kfq9cJQM2IvXHguj?=
 =?us-ascii?Q?CtIBXlLda9cmcykU/PDq+CoyKGur32+kLhs93VAcdgM1UqY3dQndFf18HguP?=
 =?us-ascii?Q?yzOvSD82FRKxpC+43eyDpU491RBW6kBpjIhf7JzSf3KJjD7EY+TLY3hzj2s1?=
 =?us-ascii?Q?MSDUr6+djHkHVC2yuGpdGIU+DK9DDGrd+AFkMaeeLYD0lTSHRhXj2YVnpnKr?=
 =?us-ascii?Q?aiqwhtBTtTF61/Rspc+Tzx4/ewl+VtySczDqNx89BmVA6RdM0qGf5WPDfxEV?=
 =?us-ascii?Q?IUDcFgoRd6dB+8yk/4Ce9RXHRzYzCHW8cPi67Pa8SUscxBYjs7tnNULFHehv?=
 =?us-ascii?Q?YSax2wiLviwBT/wKsO5Ov8U2AZ3FpRE3+pNc1pF5A7MBXeK93gtCO1MKzTly?=
 =?us-ascii?Q?YJ1sCTR4QrgZouan0V5pLywgxyvsbx3lK3Tu22LA+hsSBqSAvhuOqk3q2khJ?=
 =?us-ascii?Q?JGjaJt4356t6RgSFHSlJ8cZvdX09am9t5rRkz8BcK6Ww2xoinSyXUP37CVaP?=
 =?us-ascii?Q?KJ1g3ivBsKo/Z2n8iddRgQc1XMOeQv/6S40DBXHUsVs2YSj4GBQNY+OSRd4m?=
 =?us-ascii?Q?7q5k1Eu6cknDQoOgv55MpZpct3heMaOVURR/aepDCXUm+TriIkKyFNRv0JM+?=
 =?us-ascii?Q?7B8AWqPCdYJbcYgPKJbNz/U5iS5acq56WllOmKIhCKqvvMgJdyHdSwg4lX6T?=
 =?us-ascii?Q?Veb03XkbF1eO/e9oi6zD9TWf082icHLTYk/3eQevcrEEE5aGXRFaxYwe0zSt?=
 =?us-ascii?Q?BzwMFh7cH7E4A56iSOTH+0e1ABrKI0xiWyfroToXkZxVi5S/6ESBsEeQT8gU?=
 =?us-ascii?Q?qxmPDWrbqSyKTA+EfMMAd2YYW3yGVYwJzS8HHVZ7fAEXWNbkEb9MIWJ3re7a?=
 =?us-ascii?Q?1BR03Nl1ISha7AJd/gKqSebuPjjIKD3i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 11:38:52.4274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914e1cc1-e893-48d8-9127-08dcbd1ed67e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
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

From: Trigger Huang <Trigger.Huang@amd.com>

The current dev coredump implementation sometimes cannot fully satisfy customer's requirements due to:
1, The enablement of dev coredump is under the control of gpu_recovery. Customer can not do dev coredump with gpu_recovery disabled
2, When job timeout happened, the dump GPU status will be happened after a lot of operations, like soft_reset. The concern here is that the status is not so close to the real GPU's error status.

So we introduced a new solution
1, A new parameter, gpu_coredump, is added to decouple the coredump and gpu reset
2, Do the coredump immediately after a job timeout

Trigger Huang (3):
  drm/amdgpu: Add gpu_coredump parameter
  drm/amdgpu: introduce new API for GPU core dump
  drm/amdgpu: Change the timing of doing coredump

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 89 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 10 +++
 4 files changed, 97 insertions(+), 13 deletions(-)

-- 
2.34.1

