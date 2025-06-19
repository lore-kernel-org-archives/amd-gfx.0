Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094D2C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 07:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07C110E9C5;
	Thu, 19 Jun 2025 07:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I8Cr9olr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D59210E9C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 07:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW/rxvWbG5Y1QmCVxZS74nBhoKNAEaZj4pjG8JVlJY5sHL0o3dasg9LnvnWyZZNABxXx0zF7bwpD4IIk/FPG+dCWI0UQJxnvJ23fDqwFTtXztAbApxl3MR9tr6WJTRXDzpcU5HDCcGcnvnd7XSQx4VR9Fx2Qy9ROi3u6Dude1Rrq6TPfpZFQYu5rGk+Lqm/BOBRJXvj/z9OuKuzA0tnX2QcHhNgzRDMXagBgcIyhL8CA5UN+q4fbjbrBxhBXxmeioYr3e1cUx8QrTa9mEZGFec3+xeBQj4oNaoUX5mElQyOPzE4Qk3KJ+5Yq4OOoIMcYkt74hadS+sdRu5H4lmKJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFFosHXveznm6DcjBsAdLEzEaeloLGokE0xvJdgIAPs=;
 b=pMRanlMHfSzhpo7b/2K7oRa7FSI4iN06t3U7IJfG/2PnxhBF0onRgUbTcBQYoq8AYnesyqUw84Aju0C1E4NtFZXG811YQEFL9LjVm89Oxxd6xHPO7J01fogULyJeJb0ClVxtqHJY4b6W1bBgKsVF+qg4l8BWMA6BcTyk0wG+M5U2cpvrel2CoHRSWopS8e3du04j69ByDh+KPyEFSAM9Qq1329QBxUJfpHmNs9BHPHogmXz3tSBbhD4vCVcZLhtqUswOrit7qOKBKctLkSHcF+RY+KhX9NeGr/ALhkBaymFW/bkZ6dwOqzf2vS1gu+wV3IxBNsB4v/M/8JLBXLowMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFFosHXveznm6DcjBsAdLEzEaeloLGokE0xvJdgIAPs=;
 b=I8Cr9olr9RJDngQSjBW+OONsSImtbi6Rp2Q12D6CrZgrlCAcCmE+HC5tcMsH2JPYB2aGK+NTNncBom+Mo5KoMjXawZ5JPxXW0MCPQNmzsADQuK+yonf/Aem/PUYvNYvTYcpfW44vZ7xKHzlBUFRnOnk/F74Fd1bZTP2AZFr8gu4=
Received: from CH0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:610:e5::16)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 07:29:47 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::c3) by CH0PR03CA0251.outlook.office365.com
 (2603:10b6:610:e5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Thu,
 19 Jun 2025 07:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 07:29:46 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Jun
 2025 02:29:44 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, limeng12 <li.meng@amd.com>
Subject: [PATCH V2 0/1] Release xcp drm memory after unplug xcp device
Date: Thu, 19 Jun 2025 15:29:28 +0800
Message-ID: <20250619072929.1132699-1-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cabb015-c42f-4557-ec4b-08ddaf03116f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UltJmQhSgnnwBisCepI9Z++Q8tq/u2RrVNOJHPaMyJm4YvbNm44MV0m0P17i?=
 =?us-ascii?Q?2YqCUbQBGtCK09vjeOnjiJovb20ra8Il76Bn/WSlAqwIQDgT+dH9xkMfcGk5?=
 =?us-ascii?Q?AawsmpyGe2DhRlkZX+N6OXEuG6OSkrvGJoMt+sFt2ogwdAnPF6gnWcrl2QJP?=
 =?us-ascii?Q?wnrQZqduoHzk/+ZKjqYOZmFWIY76YDb3O/tMVuWtZ6G2adG0CFkUdX7brnGg?=
 =?us-ascii?Q?vo9T6luNfUdnYUpRP8C0F2hqQNgOqr2d5OhtPlAHaZL/x20RNXwI0IBdoqXJ?=
 =?us-ascii?Q?gn/i1nZSxbLVWUJy1RiaqhS4Tiq/fAWxkNyJcPnd70ggxG3Es4qMM3WgYWZg?=
 =?us-ascii?Q?0wJxQkZ1c9//2Vg8qB4bxilaIx6KB0ODd7rk/pmGBZMkvOecwAwPIsaSf8BA?=
 =?us-ascii?Q?CGfPprIL2kEoS/UKkGNMlLOMahKM0BB5biezri54qmG8kDs1YU3fmWZ2zBPJ?=
 =?us-ascii?Q?ZEn5xHErGMUO/lfzVHdsosYTKUKLCvzVuPm1Ex1Tw/E50njq1sPFLtfpB+kY?=
 =?us-ascii?Q?VIChHacqs4KQZunZgz2M9FEUmLsuHS59hQqePTUOXjtjXLwOJyvSbhOXWnRo?=
 =?us-ascii?Q?71ACoAQJKCoIT0Q04Tq3xrUkji1HCwlNB4OXCpQm3e5JZzR7rqQ0/r7tIdc6?=
 =?us-ascii?Q?wa0KcdWukTY8woWn0+G5kSfpRmTVznMbDoOeG2nPFjAPcOeLoMNuZEXjMijY?=
 =?us-ascii?Q?/tk0Wb83YEu9q6QwAtzzoI79JhPVxwVu9Z/HbNT9bl8DNsJUXE13lHbxVEgI?=
 =?us-ascii?Q?D2/hCWYqUrf64ltPPNhEXOji2DoJQ/7srmHI0ijvAKt5DHVSjoUyB9CNsd2A?=
 =?us-ascii?Q?Aq0z2LN50qq59sMnA6LU1Fo6rVpM4IYS9fMFU49y2SywQB51F2T/buxFTy5D?=
 =?us-ascii?Q?3LObLyoXApPU+hA59pnLUXdC9xryG09qv72PWOj2DEofyAiZ5AtSMyN5l3Bf?=
 =?us-ascii?Q?ivUBy1JEgZDjo13Mp3/JXJwfwV2M+WEkyTFgV7gd9G4mNdOqMjTLwUTb0Dbc?=
 =?us-ascii?Q?bQAbgucoRDq9W702aUklj/Bh3OnbFdnofBbRJTbZkNuKXlHXUBy2YF6w5oD3?=
 =?us-ascii?Q?85rb2S7J3h7zY9dedVGXYL3N6dCJ4W6YQW3H3Unx49t8RXeN7Nr3hrVAJksY?=
 =?us-ascii?Q?iOke7LgkoTkuDvZR1tCxj3c57R1TWW9gxuooBqyqNRpHTJVRbXrfbFY6WpBi?=
 =?us-ascii?Q?o02b2CDJqjnjW4TSjKwAaE5b6LWvrQ4FESq36KBws4lniB9KvwqB9KcmpIcc?=
 =?us-ascii?Q?jz2dYjVV6y4HWlYz6LRvs+S2GOKoYwe8y1mCJSfpu5Biqw9LV1/yq/HNOLWK?=
 =?us-ascii?Q?4/ObvB7UjzL9zSw1/7G0CmnN7dOZf+pzx3M/Zzleidy43ZJJ4sde0JS4e49E?=
 =?us-ascii?Q?6NcovAoKMgcDy6fPK24EIOwaxPHPGd3e1iUiU9JPFBIvOtLcrAEAJGP3/T+Q?=
 =?us-ascii?Q?FeZFWwBPzmj8fo+g8HL8LnORLS/5nK4eLxod/mbLG37xkrbNyuGr9jMurt0b?=
 =?us-ascii?Q?BANXrVxNWl1fN8NHwFdIoqq5UROC7l2GwKuE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:29:46.8240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cabb015-c42f-4557-ec4b-08ddaf03116f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

From: limeng12 <li.meng@amd.com>

Fix xcp drm memory release after executing PCIe remove.
Fix xcp drm memory alloc after executing PCIe insert.

Changes from V1->V2:
- cover-letter:
- - Revise title version number.
- amdgpu:
- - Remove // comments.
- - Add Gerry as a co-developr.

limeng12 (1):
  drm/amd/amdgpu: Release xcp drm memory after unplug

 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 60 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 53 insertions(+), 9 deletions(-)

-- 
2.43.0

