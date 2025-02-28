Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0629C282C6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 19:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9774A10ED3A;
	Fri, 28 Feb 2025 19:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ugPDmRXV";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3C310ED3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 19:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlR1gmP8MJZZKuHmgOqXQM7WgSQqbKYdTMOqruC7HtzhZ864WANbtvl+5OOm8VPY/ikx3vryYqYC7dowFBwfSaUo2TtBl0X2a+wVcRS5V3VbqFdFQJC/1BiG0vJE0Y/lXNct90X0Dms2Hgz9dTEwih54+iIQGlxmPBJULuVOIELmL8RzwYzXpB1aEwxtVpmm7jPOjGb2kA25a9Em1xM5Lqse0eXcDJSIs1dJRTW1FQeNy1fSfFmpAJqHOLfURsZxA7uG9jbtFxgBHi+aZBhr2oDCWqafJs9eD6aIylDrpinSB5APIZo0lhTxuKuDY2ngqBn9KCT+GnPHiHs/K18rPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHwqyCfSSLZPXNlk4Hy6Wj/QSYJ1Y5UYC+axuM6Ni54=;
 b=bo2/bHcTXsjkZ6obU0vC05oJibLiwZK+vpCd/Z39zZF5XVf6//wye0ZD5Q8AFkAeQMSs5u+4bZaJ7Gc2POuOTALtFJvLRJLBU5eT8GeUKPpSMEb+IJfVF2mbpwbWuaFkla+Fl9P0htXqV9FZo4l1koCZgl552SnEqjlX+UPV8cPe3VAKZKrZtBXxAxR6ixRKQijVyj5+Hu7MZR1jpzU2fy+k8wzue883LwXNyO1jLWj/eHOE0swtuCGktTNMMXbu0gzd4w93CDjiHzOA/R8MVknUr5ND+dow8ufHVPYICKl7nyJZeQ1D4qAsQSHOlDypaKNygZnMfzXEK8Xw/BQxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHwqyCfSSLZPXNlk4Hy6Wj/QSYJ1Y5UYC+axuM6Ni54=;
 b=ugPDmRXVrY9jfoiYbUurQubfCqlayjNjpQiARrWfQ808sm8/320jXG8fainGX2jV0ynCOo6+HUPsiMR3VC/ZQMPiyCnW0dq1K4SD0MzWp8nxoI98Cd+XMGQujzkwg+i06eSqciBNeyMwF1Zf1aMizlCn8sOusu5wmUTqAytcr4Y=
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 19:57:33 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ef) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Fri,
 28 Feb 2025 19:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 19:57:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 13:57:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/userq: move the header to amdgpu directory
Date: Fri, 28 Feb 2025 14:57:11 -0500
Message-ID: <20250228195711.2537243-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 15820f85-763c-4ffb-bec8-08dd583223a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HvdQlIW5FE7P6ZHdIlsZbUXG4HiHE4r4O1PQYCRozBm5Hmc/K3Ory0ARL0I+?=
 =?us-ascii?Q?x1rvfVTEXJYeOHREt6+3oGHgDUzqajef8Wxwsr4xAepqVKIF5Oa2EBXZ+1i7?=
 =?us-ascii?Q?qan9qI2YplHJZoBI1xzJcXfxqlm/XD2FatBKPDJ5oUIaWt1qi6vk0yv6l10b?=
 =?us-ascii?Q?tr7VcIrrhfLHm6C+UGEAxhTI6XQ1AoNiLKBQQwnb2TYiCcteBmqvy2NcpNCE?=
 =?us-ascii?Q?8e9S+mtLWlphlMc4QcecX9IX8ZZ6Jlrl4L1EeUNwF5u1rj3wMLbIdgXvBZdJ?=
 =?us-ascii?Q?35xbhClgr8qS1uzYinC5XBVEuouMkJ4/ZbER3j7M9xXxtUpVJxWtCdryefBQ?=
 =?us-ascii?Q?KFpt6qA0NJnkBdT+BuYdOk0btTYKtV1W+k5VuBjw3Gjxtj/7P8p0bg7Nylpa?=
 =?us-ascii?Q?N1XrT7R0Baj2vdtAP8XrdQLsuDLGNOzk/0p9+72OmHkPq3bigoyt6EbUsC/A?=
 =?us-ascii?Q?ZgWX1D/Jdc8NqFlus/5/txC12QAuMaYyRKW2h3zpt8ENZTkw4b55Vir8eKzb?=
 =?us-ascii?Q?W7EUDur00W0vWOwN+r8jDKR7V9Vx/ZY+VNY0U+h8NW8tVy1FDTl1DJLYuX97?=
 =?us-ascii?Q?WvpMmIn7gJ5jFKoDp3nmLp787lJpRVLDb36m1rU0k+Lv5VnKVienFWEauqRi?=
 =?us-ascii?Q?1ydcqY/719EiuLQxtLOHWrjOEhfRcC1V9JoOEfE2fAXIE30KJWlzofV8aM2l?=
 =?us-ascii?Q?tuRfwdLZc5aUnYJ4441Ruvxblnc/FAU6fLRjrB+8QJ+cMP1dC3Z7065gv/E6?=
 =?us-ascii?Q?tH9Izwhc+VKDj2Ma9pXA357HWiAF2DtAg3LpbOLucypJP55kfFijLu/ozLjE?=
 =?us-ascii?Q?QISzKoD2YZi1h23OmznulIQP/U6TuvsALlVlqQeeuR4BNOs5VpSkYiQkZfv+?=
 =?us-ascii?Q?DZbbN8OJA7s/dimkLxAvqGfDCopn+XKnw875NvyoQKKdGtfXWYID7o71H52a?=
 =?us-ascii?Q?TS++UIpSjP2DGY6fLILFI3Aq8t8IlBU4RF805ZKTUZiLn8Ek3M4NCUS0wjXA?=
 =?us-ascii?Q?/DpRPExBYyyutvYnYg2ZnYgAjqWPm084BA9+4izKSiqXMZVhkFaxT0gZXK7v?=
 =?us-ascii?Q?bFBJ4xgnmc2lcG15kibqQG/9uyCIQqgcskHVpLe+LWk2h1CvIAQIGRLoCD/l?=
 =?us-ascii?Q?1OCsLRVYbvlKjukJ9w3qN7lm106FR0EFwVZX9tFwd8XTyu6F2hlk5rggNxbk?=
 =?us-ascii?Q?Ud0LNaCCFdzOUg5pohAG94ayd5KwAkI3wEkmpPA326PRepsp3tsniPxzIjlP?=
 =?us-ascii?Q?Dfk/uI89UBdNftXjW+6FhN3v9QKCr21odLngognIhyfROTOVwi5MvQYnJjUr?=
 =?us-ascii?Q?1LEWWAubOM8OWm1c9bq2+YFisg4clGUqmoSQuuxcukFTL/FOyLnLEgqilAv9?=
 =?us-ascii?Q?dOMkvNXZ7brBWcQ3Cbt58eEiT1rVu+EJR+iarUTsffeD+iGZfxd9XkQd1zMA?=
 =?us-ascii?Q?ocWlzTXQfsFjocsW9VhDtRC165f91tlUKKiPF9/WpaL/99BlG6mEBg5zVH02?=
 =?us-ascii?Q?0zrGxsl+KGmvUYY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:57:32.3077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15820f85-763c-4ffb-bec8-08dd583223a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
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

To align with other headers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/{include => amdgpu}/amdgpu_userqueue.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename drivers/gpu/drm/amd/{include => amdgpu}/amdgpu_userqueue.h (100%)

diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/amdgpu_userqueue.h
rename to drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
-- 
2.48.1

