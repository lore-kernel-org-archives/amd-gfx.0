Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D146C35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 16:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A8A10E54A;
	Wed, 19 Mar 2025 16:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UEKQeNK+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C8710E54A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 16:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSohRDwbszYDSrqchJ6PC+6ORvl5ZEmqOv9P43+QBD9y/kldxRKwJTQTyXcvkNhWMwTScS5ThUV36eKxR8b9W6ocqv/tygN2vJ2zhyJ5bWu1jkej775H2V14dePYjenNfXyf1DlXGwSGsGlFIy7QvKlMuUn1qachd3la5REEPLtqKImiCWQ7N1l2xK9F/x0A2JCtP+Z8wSFFpRXrAiCzdM9qCugWBsyrwMxe49iqYkVqwbu6zo+UB4jjsVzA/gytGHMaR+vkWXEeDUoIAHxO+roJ3nL45zYUdMW0Saw7MMsrBNoOxejVQj1U0Cz7VBZzit4h8YDLqLuj9PCWUeWxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p25O9K3GTLmGeD1nKwzPla0G3IFFy/mvKv8R0E2bdaM=;
 b=Qg+S6ChVjWw8j9vhQ9NspIBlgOZASGUFR9pBtQWU/9wCCdTIkGRgC+Oa3NhYYbeBZhxZwcoEBe8uEyK9X2HdtD7U9Gc2taRu/6Xc2I3E6dW4D7pMv1OKNTfnja3PPPndYoRb9wUe8ADMLuwJ2PYFxxX+9ZVosA8OZhQXkfIt8ZxdsijPvVD5MpVwjOjiy6Q4kEjvik4OXqpiGHJGiuzugwr6ZfCa9jElrnKKxvJi26YvbbvhIPY3BGVpPlLAJtSOWp6sfLw2xUipjuCapD76KjZqLQ8M8lLMYlcV4vdITZaPWn3h0XmnTyQ3Z1L+k6gTEv04UTxHi5C6ntSDk/x7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p25O9K3GTLmGeD1nKwzPla0G3IFFy/mvKv8R0E2bdaM=;
 b=UEKQeNK+Tsk2whdG6oriTHej3kr5q34gu/o45KW/QF1hABeqQjeUlF2Z1xxfmPoZAQKUFXniKakrRy5KXjHjWlAPKk3hfsSUUfyF4zjZHtQMnjHruzjUPiBWXr1u6Owc6zaHX8TpK3RaItpbeaQAtcmainujgPwGeWPYpbKnoB4=
Received: from CH0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:610:119::25)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 16:22:39 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::d8) by CH0PR03CA0375.outlook.office365.com
 (2603:10b6:610:119::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Wed,
 19 Mar 2025 16:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 16:22:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 11:22:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/gfx6: fix CSIB handling
Date: Wed, 19 Mar 2025 12:22:20 -0400
Message-ID: <20250319162225.3775315-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 229372a7-d050-41f9-e1a1-08dd6702448c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eFIyV+dinBwfUkPb4gc38I0sWIeeON3ponvfKHate2WEht6lSGlZM03dSt1W?=
 =?us-ascii?Q?dtl8lx9Mw8yKy4TZlz5alMOhFncSVMxeGWXehaxXRLWZadA0i2mhU96o7r/0?=
 =?us-ascii?Q?cVPA8p4O7Rc+RCqg98iJqVpBZdXcjbAbsUZcuSq34NszVkZHSIOWXVBnLf1d?=
 =?us-ascii?Q?aIEMQi8P/Cg0ivf5phv829M4iWMLorBismsVTv+6c6vtGlGFU17UbcO/tXPG?=
 =?us-ascii?Q?pDddRWuEHooq6QxR8I5dKvGOHNvHXde7TRvEmmW3/Zpwaq9RPwLkAVgZBxeb?=
 =?us-ascii?Q?UfwrXnfg6ctxhnfZlm174tpkJPhvtdsJT0ca7gmoZ7dabffmapCCtiK6/2+4?=
 =?us-ascii?Q?0Ci8/C/JaBdhHGQb54eyTAKP7GCQdL7w+Qa9MEEUbsHZ6I1SFP8S4B7+ctXV?=
 =?us-ascii?Q?JMB2mp8Z+TnNrK2qKQ4He3kKoF2ksN10TP6HiNjCd8W6WHA1qQXpHIJaIAdD?=
 =?us-ascii?Q?tHZMA/3gixQWm48z+wApt/jVDTUJUfg47g9UAold0W9oqd9blWfi8qZDlXpi?=
 =?us-ascii?Q?93sADBzBfyJ+iZZvXtCsTavanN5f/kEBJgUAHtP35ozr5GBRIcul49ZMTK41?=
 =?us-ascii?Q?VHSrGLp6UZHTLeo11hXfxxfsgsxu8M5YdTuKcXkt++iy7ns2S49Ue9OZkum5?=
 =?us-ascii?Q?U5/3qjluAnPSmG1toAu/ryQd4eyuH5GCRAZUJ6cToY/TIzgq5oGZIMJm0kSW?=
 =?us-ascii?Q?tirx1zBxk+2fKVhEcvYP00MQSEsNB3Q0QEDd+iJ4jBdUolsg62xsmV75cCnO?=
 =?us-ascii?Q?z8VfNJ/gzpcsg7edgctnj7UKwS3buInE6+8Cu5U0gvQ//Dig0Ic3PH+OcHiC?=
 =?us-ascii?Q?KhDnzwAYW/yleDdykuBuiEQxrDqiqTYQ93Nr0olh7L5fLOwzX4MGsrVq0+Cb?=
 =?us-ascii?Q?q0dPfKtPKUQ1JIdywSxowGzSiprWCM+WuEvOT9y9tqFcIoe3GDDQ9KQ90MCt?=
 =?us-ascii?Q?kuQLnKDJi0bJCO3P3ez+maS9i+cCH1wSYyVjwnh3JF/AylgzMW8Cmuz+FeUL?=
 =?us-ascii?Q?Ytk9sRrdyALkuDj3an3n/0hKLooS8PXt6vQ6OSy18ZQuSMSvVsvQSLZo5Knl?=
 =?us-ascii?Q?B/17yi6SprAyBiCGR2dCwmWI6SKVXsb+T6Y1sL7qwAsxZRqMt0aqyCNYmjLZ?=
 =?us-ascii?Q?E2irF06UT17S/piA28PJ2MOycM14j5KAMTF5z2axAFGbr5h7G0D964uajLMK?=
 =?us-ascii?Q?3EtCxqqelrzB6Y7RwHnQyJYGmwy3lsDOevBNubs2UvYV0PjCdh6vpf8EHrw1?=
 =?us-ascii?Q?anT/zwyE1/Ux/rjAeNWIf6y734/CMZk5C42fs099OHj2GxIJoErwkDPSnThj?=
 =?us-ascii?Q?u1ISbR+P03YXazpm6ZRbGLpzYghsvr2SjLsDdt4Xhcahfzx4EjECEPmXjAw0?=
 =?us-ascii?Q?p1lSZG6h4BFX/5N28TVE9EuAGWT2TTghPoRNnrzWGtjg4QEVHXXahdPU2QKf?=
 =?us-ascii?Q?9ZVmR7Y4KQxb/GngBVBSv5tr1lSm69mVknp0M1Nu0BcQej7Ran/mEg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:22:39.3532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229372a7-d050-41f9-e1a1-08dd6702448c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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

We shouldn't return after the last section.
We need to update the rest of the CSIB.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 13fbee46417af..cee2cf47112c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2874,8 +2874,6 @@ static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev,
 				buffer[count++] = cpu_to_le32(ext->reg_index - 0xa000);
 				for (i = 0; i < ext->reg_count; i++)
 					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
 			}
 		}
 	}
-- 
2.48.1

