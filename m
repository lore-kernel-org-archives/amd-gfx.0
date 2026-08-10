Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5761BC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCC810E5E7;
	Mon, 10 Aug 2026 03:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3BlPIDqk";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA0710E5D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxY8DPNUF8Y+xQWFB0eyXSRZYFgTkXhyfIAmBna/NEZumE5og5/IcE3SoLSbe5YEVgTQsO37sh8yARshJ6KrF+MAPZE209ZqElqLhu5RRq0U38Ukwdj7+qLlMaBto+TO1u2I+Jcg09UpzLxF/NpVfxa0zwjtd4OESoMPkrIZhKsLAlDYZlA11UO6HWISQfpeQq8D20wkpyDqNOlhvkKLwm52lu17thj+ZmErpQ7dVioI8q3KSWo4A743bZUFNmRG566FW9dFcOSZhLfxUNZeQflxFBnhb3Z96y107fI8iLpWHSAKU/itYIy63Zri+WChnmAqVkcxmAHxpGTeM3pNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ivp9vxzeQBbicAqARv70Ar5fOffZYaUboW5R1f4coQ=;
 b=QouCHLeQZ0F1AqZB9wINZjD8uFgLra5IYzUJMHqLzo7QwNRsfEntETJPLCzDvqLkF9P3aswd02u/WtgJ8pF5mhrk/r3jBCnfIwBnwTH5pdczDvboX29BpXSJ3rC4OtJ8R+2djbFc8Wfoy3N/BdimJB/ksYJhqHQcpKVSMPQUlrWd/vtC2MBrdTnrDbzio8g0gT/s0BL6/7Ej46sLvnGawJBYbsQ81xnHPU7lx2gQDDLGwnlx+2hJp0TmlM+B7jWapHdZ4eAwdZKMraIhFdpNp1ogwDLZz+T0g1hNShR5Z1TBwJEOUEnP4iHTsESb4CGIbLgVJhybPOv1JU36LtE5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ivp9vxzeQBbicAqARv70Ar5fOffZYaUboW5R1f4coQ=;
 b=3BlPIDqk28Bal8c4fpR7CjD7RE7P9hrvvY1ftLjXacRGD7VnudhzWBYVHWFu3jBpQOO3V8IkGxCEeYL4l1PznonTykl3zB9ogqWi5Ga4mObNCGAgMgE8hxnlYXM4fQINi3FWW6LEaaVXzYpVUQ6gLNHU8SLjnk9GQgb44ndiTEk=
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:06 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::55) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:05 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:02 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>, Boyuan Zhang <Boyuan.Zhang@amd.com>
Subject: [PATCH 03/13] drm/amdgpu: correct VCN V5_0_2 doorbell range_size
Date: Sun, 9 Aug 2026 23:36:34 -0400
Message-ID: <20260810033644.118194-3-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2a29c2-8b1a-4261-dc04-08def6913569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AIy1HI/Aogfa35K6j1CfBaeWmGFjMl1UsNj3LLAoOg1uiRSHWIztMvvp2IxHTwH6Rcvr5mz6ibwj4pRWvf449aATqdfD9heBcgzFuQdJbeJvJxh4U5sCKgPg3Hniw5LK+85ELDSTj4VIveBw/MGzwSIsHdwxviHJtmTTuHE22mglJECLErPANj2K+gduuOXx3NoEH3jzS//OvmOO+ADYwf9OK7Zi4dXzP5Lktq4RzHNEC5NGyvcVCI4CpJDzBX9XDKH+pyK8kVtor+/g81A+z1n5oornMw0owPOOKZKRNxek3zII3tj2HpnQl9SLhFcdnUlTdYYkKlXJJ6uFIPt9z2o7hl6t+vWGyrK7A+qdSfu2NtCMLKgCkYOYB6lVfYh1Tq8hSqnL1yLC83WRuPapy+48hxip7wgwVjVCNNPMx/AshB2JoN8t8HXBxJmJDX8ruR8/Em+VuD4EGXfvHWBXAAKOcAbuHeb+viDz0N0cAlT3aCQTbG2KI68YHLFZUxwRLDeQ2awgpG7o0kR1ZKBIiGdZVLt/BWVQwWQIta7BXVHLmmxfzB0530U3rW0Pv5RMEbx2VN6u5tniyMrWwYGZcBw20FCr6+Zdi71sUPyH1jYUKyu2+3Zr0OjGajunS6B1MFeBrHeStim+IN3I2p0+DM39ruxKBwuewHwCkNZNEDbTa+jpOzd0+I2SLGTTlavy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tYC1rZuS4hxztD6suMNB1CiuJoyoeXi+t0cpdWJNo78k9glG2NYQCgqhvnFPUiQqs2BI2sMcWuaS3XDk0Fje+uEIgv6RnGXjyQ/Oe/o29q3hrv8+uXu8OMU35UaB/UclPnX7YEd/YHBjTWbE2WYFQzgi6/Aq+kGE2mxWgQiNuiLhjSDiCEPXzpU5UkJKbsCxY0qwGWOaWXf6yurKKPJbksVgZwrFSBL48FrcZlmQ3b8N0zu7kDDn9ecahAKSnKQwYYbZSVe8DfEWHWq3PyHGn2yogG5wvLNq8AbDxca7Nymm2eIV4c2GWQSonZxkRXuFLRlhHIoXYJF5NdahduOpWv0ddq5BX0sMFtKO4AKE7h6MebofLYDY/h+TWg1ymztdiMJBUyKT7KgrlruPm3gTnPT4bIqz1CcXaLWObNY4duVcBSBp1lhWC2nh/Sscm9ji
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:05.9136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2a29c2-8b1a-4261-dc04-08def6913569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
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

From: Sonny Jiang <sonny.jiang@amd.com>

Each VCN 5.0.2 instance has 1 VCN ring and 10 JPEG rings, requiring 11
consecutive doorbells. Increase the NBIO doorbell range size from 8
to 11 to cover the full ring set.


Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
index 5e8f466f23ad..d249011b2cf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
@@ -266,7 +266,7 @@ static void nbio_v6_3_2_vcn_doorbell_range(struct amdgpu_device *adev,
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
 					       S2A_DOORBELL_PORT2_RANGE_SIZE,
-					       8);
+					       11);
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
 					       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
-- 
2.43.0

