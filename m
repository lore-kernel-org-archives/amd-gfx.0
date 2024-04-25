Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FF9C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 19:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB95C11A859;
	Thu, 25 Apr 2024 19:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5N9TAqp/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6E411A859
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 19:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJvqWRYorr9H7rR/vhJ6bTEehevjzikDaEv6/atFlQX+SoeyZ718f4sTTqPLsPSfMa8OUD8YY5+AuEiehB47OhW0LfWQshV/lcHSeeFJc18JpmxDH7P62Vto1aUdF3YqBfnwLMz8dXR43Zb0RM9fy4hHG5FWR2VByKOE+L4n4bkC1oSUH4Y/ud/nzF2kYmR0zE5VN0MO3xlnANCkXmCWcv0rq5cufrpaYF/gWlaLggdXNmRO+X5t9FF/Un3hNpRTigwD1seJxF7jrkUHnWNptEfY+Oq+zGDjcvmAfxbmesj+iPMostxXZQ7tIrJ549NMlzG6jZ0mvLv8Xo94s+RunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La0UTq1CAhqmgJ5S36oIdt53sEAd85Pi9aFv34sF9P4=;
 b=J1ge75QcjXmA2QXKr87vffpahbxuS7MioahwprKjjwYaev08b6qQG4vLxCq7EHDcR+3ZGheBXDC/YxNdsxtOcBezX8MECBwuU9UhW5OnnwvYSvN0JVo/vguEgri139niYbSilhBSEX3RS5EPwDuw9aVBDSIdSvWeDgghOcVfoxaBqhEPNfKxrK19RksNXRgI1avhRYXfMCJlpUJV5d4ASKeHqLw7UWavUyF/TkhQQTbWqGboALiS9MUD2rgSWXlzqiGBjn4U4lguwknm8OW7zlq7k4YcywuUl5Tc6LPmQGqLsv2D0rDHDZV7DPkhA2LXi8n1lSSRH7GeTjbWLbShWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La0UTq1CAhqmgJ5S36oIdt53sEAd85Pi9aFv34sF9P4=;
 b=5N9TAqp/0vV+vbFKJ4zky+7b1LYa0tUeWohMrjRJciv9XaL8fBcVArd4TQbsWCqIqJMLpg5JGwcLlq3tK65Hd15ER6f/Ir6D8BF5/y7plYTE5CznRzgbOb3HJTeorFBkwJPJjuD90mODvhv7QudFNZkcOGYnicXHt4F1M1crsNQ=
Received: from DM6PR07CA0102.namprd07.prod.outlook.com (2603:10b6:5:337::35)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 19:57:13 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::24) by DM6PR07CA0102.outlook.office365.com
 (2603:10b6:5:337::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 19:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 19:57:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 14:57:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] Add mmhub 4.1.x support
Date: Thu, 25 Apr 2024 15:56:47 -0400
Message-ID: <20240425195648.2786502-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 54730d45-bcf8-4fc8-5b9e-08dc6561e652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UEB1O17jOysATu37fpLHAbWDBs9Wpwvk4OOhEf1014YVKYwdgb4KkLbvgsNL?=
 =?us-ascii?Q?o1nxEzFA1WpLJ95LrW7jyTh+ShSStXTk65+OHfXc2swBJO5nJ7lCoCqq5ogU?=
 =?us-ascii?Q?Ua1fwokF2PZXLTGYUBvrEGJPSKxMQ1b9N46klZhkncq0zOymIyR5gXZ/+4cC?=
 =?us-ascii?Q?UQs1M1OKRTpkVBGpfj3McMqiUrUUodifKGdJx7FJh/OAHRLRhGhsGY6Fq/6f?=
 =?us-ascii?Q?muRdYPX3Fe7rvb4MDxBmWZPJhIjyoRdbou3SMCt3SlxzNtp1XVo+oxDFF4J6?=
 =?us-ascii?Q?nOxhIZleA4DBk575tAgAQs6q/ztJdRc8fa2YtqIGv9lxJ9YlsVOFzHtkhnWE?=
 =?us-ascii?Q?rulh0TYIqeKMFCtlq4ihd0OmxCIXJis/p7hPEH2FAiHmdfgxVlFzNkR6rGWy?=
 =?us-ascii?Q?WJLpzgh4NGdbZqmX50dvrohebP+Vv58TFVJ9eMMYbvjDC8HGByISpidBztB8?=
 =?us-ascii?Q?VC4K9m6zZRYkQ98wbmT+oQW9/dYE9nFs3VcKSwh0B9TLVGatnDXbiozQuGLp?=
 =?us-ascii?Q?u7ru1LkxQ+4CUT6mhop+MLGIjLid31Ca2iwcEIqhMRwU/x5Z5a86ac7tT2TV?=
 =?us-ascii?Q?m4/E1R5btlvJTH9siIhBYzZKx2Z3M4GtCpXqslNYBZTrgIdL2C6UFJi+MkhG?=
 =?us-ascii?Q?hbduEhNSRK2JIO9m31bI+IgEBGIg3md8rJQ5EBQO9ic4Qd9E3jTaZbkqo6zJ?=
 =?us-ascii?Q?pLgsrBx5GKAwOHATiAEq45qVpxLUJkw4j5kFmrOHNNIwPn0k7YXCP5KA5i4J?=
 =?us-ascii?Q?U6JcnmvC9Q5BSNgXqciF/L6JlvBCn0v80QbN3SVsz98uIB1FVJp+L2wTyMcZ?=
 =?us-ascii?Q?6kLzHkgqzzsK5crpNKmp9yQXPjzzyJYyIa5wDkMzvt2mfh/O9gsI4kTUxs0B?=
 =?us-ascii?Q?aQR0LqHQgPaL0f1SHo5gT9njrQI5p2Akcwr3jDiYYRVg2K58P8W1I3r+2HSD?=
 =?us-ascii?Q?zGVq7btaeOHUTJXz6jdj141kDZwj7QCkoc8BlxGAASkh5Hc3GF45ItVv3oyK?=
 =?us-ascii?Q?cDy4+bygoIiN0P1STVn0CcI8jY0gjFeN74sKosVpMBmHc3H5El4j1p4KVTxJ?=
 =?us-ascii?Q?cj2NwMDKV7yVxfpqHilHLBuKkSQFTSUOrbQACKRiEKEghwCyEDwKZOsAm+QE?=
 =?us-ascii?Q?vBY8MrPsS29W0fdiVQhHNvp086WMrLXQw6q6xdEsi3B17ZLY1hzB/EpV3JJ9?=
 =?us-ascii?Q?HIQHau99DLKlIbfLEYe0UKXnnS0oeg0yVta/FvQI+T69OUwdcmEuNbB31UUr?=
 =?us-ascii?Q?k1t3NmX9+hNhtIqVZnl2lrzJFM46bZMPQjCY6zyaHWC5ghLlRq4KkNkH9dC1?=
 =?us-ascii?Q?/12DkFfl6kQT2a9JJjJqHv6jDpjkz91W7jApB8Rbq0p7hF3djnz1pguUsuzw?=
 =?us-ascii?Q?FI01BggEv3bwy+fJqGTruDphb57o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:57:12.9376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54730d45-bcf8-4fc8-5b9e-08dc6561e652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

Add support for mmhub 4.1.x.

The first patch adds new register headers which
have been omitted due to size.

Hawking Zhang (2):
  drm/amdgpu: Add mmhub v4_1_0 ip headers (v4)
  drm/amdgpu: Add mmhub v4_1_0 ip block support (v4)

 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c     |  654 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.h     |   28 +
 .../asic_reg/mmhub/mmhub_4_1_0_offset.h       | 1341 ++++
 .../asic_reg/mmhub/mmhub_4_1_0_sh_mask.h      | 6943 +++++++++++++++++
 5 files changed, 8967 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_4_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_4_1_0_sh_mask.h

-- 
2.44.0

