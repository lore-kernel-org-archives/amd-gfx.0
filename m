Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6136EFCE4C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF7010EACF;
	Wed,  4 Mar 2026 22:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGbmHl/d";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7E610EACF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOH+f9FyK38QG/tXHglmQd/e8nGo+vaaQt2zhiupHZQlZem0/DBn5HE+L727i2CJTgYjHsYh7/kK4XMiE2xyUdCvKV1f7xPpjPt6uALOmF01n7+oQ2C+DrAR3Jk7sbE1iMrNOQ0cGjbjNTyQxH4AGcfLjgD7lNsMMv9gdjgGD3zu5gR0PfIFyLYB1vyrucp3ssSPFgZB7lLVOglMxgMqRdBfJOXzvCs4Jhelecj4IifbZHvBhh01D6KiE/jGl0Vnm3OaJMEUdC5i1DDdlE9jDgF813nekMF3H/AiZj9OtqgBwO3fqzc6DpkjkIPg//dzeKNQzf+EZETZ9kzqyEXeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/8tFaAupkofc7Ks1KaGAOSUOcHBECoAUKnCA2M6TvA=;
 b=R7yYJWsNHpTIziUq4wRVYvVbEaS52G8XvKZ/q+JlGJ3fiZf7MqTrohaH3BUfjg7oHtAttGq59Cmmnf/TOrJS/c0+Q32q0gJeG92dy0GP3nGc3+YSLuRWJNFOVAKc2B8FNukYtNtWQTxv0YF8XDpgeuGG9mxwsVlSfkOkBdxYBuLqx8QBZmuDYwQfUq8yYicXH4I3BalReF/UGvKwv6ua9NiAey5b6C0tfCge7vRO6szaZAe8FqyH5kb3cB6lhQWS/gLy38v0yt+Dao6WAsK0zcTFlVKeEVVF1rzn8KVt8MW68R4xm98kOtfAlJIkC3EJZlc6yBUMojpIDbJhrtRgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/8tFaAupkofc7Ks1KaGAOSUOcHBECoAUKnCA2M6TvA=;
 b=GGbmHl/dDGWzUB6S2H750wpMZGiyhKc9svpdtyycPP6s831YG7kB0uGAjRJFZZNTPlYLmRQ3NgKy4Ld7pAB7GtHrVum/PtvA0ftvHy0cooITI7TbM6tuR8wYa3UKztZHIIPGbXAW2Jp/xciZap5iWqSXOWmcLj6jBqCCKT3Rfck=
Received: from MW4PR04CA0141.namprd04.prod.outlook.com (2603:10b6:303:84::26)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 22:28:42 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::84) by MW4PR04CA0141.outlook.office365.com
 (2603:10b6:303:84::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Wed,
 4 Mar 2026 22:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:28:42 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:28:41 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <benjamin.welton@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [RFC PATCH 0/5] add compute performance count control
Date: Wed, 4 Mar 2026 17:28:24 -0500
Message-ID: <20260304222829.3688601-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 008f4a13-dda9-4bb4-1fca-08de7a3d6416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: 5qzHcdYH5pFEWigFEoD6IjamI0qKv8JmX9YcJKV59Rqyq4agUEACy22bh9JCFkNrvRY88SW1zGkd+yXV18ORpD6NG9jHIGs+isVqhM945f687lfSNVzNtsx5XYwBvBqPyuPnHDybrATr3Rfad3SueaVjVg/fNCicIm5u+kKmZ8hAS530ZuaprdmC6hYNTkMKtfhDUgWO0cguRCy6MPPwnczKKDHQ2G5pSL4oPZGAdh0HANJ+dBK7mXiDA4OtK+6yRVbVo+WdDl6bpSqGW1nMuI8+h1OTo2faNg7933alEgnIRAnyOGLsP7vd32iOHkUMeQUWVkApkvPZaKjNmDKOblueY0QjxsEeUhJksvqLa/QXaTQ8cmJhovG6bkioXg0PAvryZRP0i8R6rCVdEl5+OaSjEm0UCvytN230XJnVlf2L34GKE60R20h62Jn0n3s8cEeLf3Gs+QKNMw/5rLYuhWgT7QdCyTKPHH217Q8CSp6cqR65W1+j1SmTS3J1XXjxI2jLCHXAPWGDFwyV5JKkfJR/WPuUzyVhfT1mTkO5sQc1jE3OtrhoPLLpWjpoGZCzL4HxbTMUyE1sABDLNPC2mRW25eJVXHMe+OGZKroHejJYWFXgsK0+9pG6/+QZHf8ewJsSZ2+DWDhNdwXyBZxeiN6ajSGdCZdbnEiwmCEqtpChyaF3phZ0gCdPxKUfnGGKiQ8a8XahvLmohAZEJLs0WoRJYnUYMYmDUwT08DhBTtPQVQmFUQkuxr2oHKQSD/BQJ63Ycf97n7w+kGAkdh+hmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TltQ6U+7/dzYqaR/kVQLY0Ze0qlp9V5tE9lM19Oi95Ivw4QAn22WqntBVkei3FwKOxlbxJ9iWeBVOKby7NlC98BhunKvHVBh9NcWERyxzTifCU9gWghJcAcA1xoMWEjBcs8ij8rbwDlK5yicXrztwBdJRVQ9vMVi6KzwVRK6bHTRvtfXkg/A5nnZHTjAo+m9ETO63JdaZGaiJvIw1oaJ1lkpwH6PZMq1SgvvmSnUKenk0DxqTj5nzqjaEiQJHpUuRMqsfVT9Uugia7XaZFdHEelQz8MLc007TLcE07OKqn3AUGexsgDI3FE1MDh1Ki+YXhVytS+SALfK/2ThTCZbLe0vArz4fwyUocqyU5hGSP8YPGAj3DbxKyycV58MgQ3bnlqh0qhmDU6GJlHVTzgqtbVy997PUxNuVSCqB7e60eNOgCvnuVQNJ6e9UnjVPIoa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:28:42.3153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008f4a13-dda9-4bb4-1fca-08de7a3d6416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225
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

in user mode queue properties. New user moded queue command
AMDGPU_USERQ_OP_MODIFY supports update queue properties at runtime.

James Zhu (5):
  drm/amdgpu: add MQD update on cu_flags
  drm/amdgpu/gfx10: add compute performance count control
  drm/amdgpu/gfx11: add compute performance count control
  drm/amdgpu/gfx12: add compute performance count control
  drm/amdgpu/gfx12.1: add compute performance count control

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 3 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 ++
 6 files changed, 16 insertions(+)

-- 
2.34.1

