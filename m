Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3045FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C619D10E2E3;
	Thu,  5 May 2022 20:04:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C2D10E2E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1VEIperGUne81TN0yhYmASZqKuTQlswcguZfydKgy0Hihzrp0fCIFvjPTfvYdRQwFT51YPCkctBqXwGtI4ZBkC9N5cUQRPFMhV3a6ew1/GaHiBhhToemdLAQMplbhODBcrzmUNJgxJWoOzqQsKQG5kv+4S7hDldIcn39T81lYtYlaTivZcfc8Cu+8e1ZY0BK9mTQyg0+X4vL9aHI6hIY2Z5PWamtih4iQyijCf1AbLi/rDN3gKDwznkAsw8oHNN4ioOETUEjH03wk+ds4IiM/gNj+KjGyYmTUBUWYfMrELYCbWHO2rVX0z2/7+SrlzsBf87vTeR0Nq08ELuEsHNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAwtB0kp5yed/IX6mf6ScOiMy5n9na9kxt8SBwgGBhI=;
 b=gR5Iqb1cibIwxlH7OrlzsG444U75XQ09ZJizQutXaWBRZ+L9PnCfOS6ODUKUaOnyQBhbFBDq7q+hPG/JEZG887aYXZ3b0Tg5+4rmeRazPtJjLSs3x/vEwAhyeS2R/9e9Gfd7fY8ZO4MUTQZOMzvYphJWDVKBGnuVgu4nOemBI8KFB3eJfhaYCs2JAMCppgpLzVGUaYlNuFHmZXcC/W0YF56npXSTel90v0OP8EWpzHtlXtO5WOOFBBmLHk5UdOauH/DrCJrKt7ULFQf/1GBWcPHuDctvE+6e1kV1GXjrpELx3XYiyGHVnd2ZrsDQ+RC6O5aI5sLzxJIx/Sn6Eh49pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAwtB0kp5yed/IX6mf6ScOiMy5n9na9kxt8SBwgGBhI=;
 b=TrMg+btGCAHn7Oklh692Sy6kf97NH5SFWCjZUR2epxLYli4eyFAluhsvh0Etkx3GZAOQcA8VW8/z6EID/6buoEEm/LMajSEldgv5mUB2/dEVgCJy44sGU55COM6aX6NsjvnNCmBQe5USWBDes0XpuEFdna/0UFE5fcuz42ykvlc=
Received: from DM5PR08CA0032.namprd08.prod.outlook.com (2603:10b6:4:60::21) by
 BYAPR12MB3080.namprd12.prod.outlook.com (2603:10b6:a03:de::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 5 May 2022 20:04:23 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::6b) by DM5PR08CA0032.outlook.office365.com
 (2603:10b6:4:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 5 May 2022 20:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:04:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:04:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amdgpu: add LSDMA block for LSDMA v6.0.2
Date: Thu, 5 May 2022 16:04:04 -0400
Message-ID: <20220505200406.1293467-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200406.1293467-1-alexander.deucher@amd.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12c4c6b3-cc8c-4bff-232c-08da2ed272d4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3080:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30809832B070F47988398F63F7C29@BYAPR12MB3080.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daEi02SxLpYTgJbCjWOOYqrq+qhkFMyrNMrHJDATTqaNXuQqjXyjI/hJ0a77C/awNABbjESBNNy0xMHss16e/UB6HvAlIn6GGu5GgwBbX67jTHtmZk4SK5RUY2Ukx+5ppiXrnU0de3nNCTI0HxHeewm6IhaiZByd45WbmhFomC0W3vCh1MXsPpZ+zgaj+o6ZKzXqnC5vAb2TUll0xG8sStLtaUbVVP9+6evPM6E9u/Y7Mb9N+V9mY9CM9lMiF7KpUXqRfeOZKp2yump5HY1XSymTGiu1M3HoEZ3JA+LTydjfMHI3f+BCpqevXbyPCck8AMcZDe1HmF7qJ/SndkE85q+H2NnGAgQ1DsIohpUiFsS+LED+e4Ad92rr4RE02+nucgGN6teSnFrix4uBRVWmU2fPt69cvm4v8TWXyAI0swlxA3CUG6U0U8xkBVT3941YBlo0V0ZfFzBPvJvYnSqy+MWlBmA3QPk7C52Jxglk7gBGvL1VKI5CuIZCdMsOJW8VXYnf55qipBBQ+o2jQO/Y+0Q/iqhtoPMnhBv6yJd/Ee3A7Dv05sPW8Ry3lwKF6SpSGyQZxW7WSlw7d9E3ATREx8alW7LEFku0IBm4AGQQRu5CGsJ2dij3NXVjpgnj2VGb2+QSKihJLvIe1kY5z6XsoOIHB2UUQg39KnuFR/VzqvGgfhWZupvKSLko52bkd+0UigjbtfiO8kqgHuKBYeS/jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(36756003)(508600001)(70586007)(70206006)(6916009)(4326008)(8676002)(6666004)(7696005)(54906003)(8936002)(5660300002)(4744005)(316002)(47076005)(426003)(2616005)(336012)(186003)(26005)(16526019)(1076003)(2906002)(40460700003)(86362001)(356005)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:04:22.9924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c4c6b3-cc8c-4bff-232c-08da2ed272d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add LSDMA ip block for LSDMA v6.0.2.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a3494131a946..d7b0fd1cad62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2309,6 +2309,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	switch (adev->ip_versions[LSDMA_HWIP][0]) {
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
 		adev->lsdma.funcs = &lsdma_v6_0_funcs;
 		break;
 	default:
-- 
2.35.1

