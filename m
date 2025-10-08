Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EABACCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 05:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8E910E74F;
	Wed,  8 Oct 2025 05:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sCVC7Y23";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C51A10E74F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 05:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFAkKQBj1qiCH+WvLlj8fwHzcsQn0SDy5YimHGT6w8G3JAuZbeVFbV7iMCz1qMKo27pvIc0Ehn+yMgCKHmTgy2+9/Fr6Bo04oJvneEONLE9TLNWzOk4YEdhPqY1MdWOONFwBqD5xidmjqHu79blx5dBG3ByBKoYrM2diEaOArIL8m2zbENIz9AEgzJApY8/BjDo3XoLiLDEpHSFBwvrU9vsZ6Aop4YVUrMGx7kJWLPKgFNxriXe8zVL0GnpFgbC2DRgZQK1JgNt6E0fd/zxXzUWjAlLhNXwB+/RMOSvYcH4Qf9POfEudxcHRZzKXeCtUMhN6AAck/8uP6bqoa2dC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmv7T3prG/cqX/dbhGSN5tcTkEkgAksjsCzNNOdeZ3Y=;
 b=TKp90DNrajBFF0K2wogLcjsPlgJoHi/54BJRNYiK8XkpxnHpSJHqS4f3+uyYL2BudHjiy+Jwm/nbEpg218b4WoYC34+X0iLrkT1ykLLCsQC7F3NyOq+OYz6T0rIB9bP/TJ7omTyuJ+0Px2AwE63OZhWshw/tMuBL/E8qlbq7z9W9nMg6YQvbzGE7Uz2BdUU7f2Bdr6KMnO+S7gXXaWPB15/j/s8k1zZtYOFzb8dTQ4+iWE8yLmRSdaIty77RBMlgVc3B1fTZ3HjoblXRGZHsvUmP+gulFijucxn95JWjO2OXRg25J4abcxaVIn0tdtbjqB1rQE47PuUFCfOaAViX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmv7T3prG/cqX/dbhGSN5tcTkEkgAksjsCzNNOdeZ3Y=;
 b=sCVC7Y23gVDbr+dDQki4kV+4ILT4mWmcW++OpATR/2BF2qsdciAaDJOuq2L10QbSEr9KFphsyppRMod6o9NYDYNCppeWz1XVOiNZsPxKy2mU7PYV2HHzPshe0IPg4n401g8MWVpa7dP06pXEgQmWBZBj8mAHU7RJCA0CimoK54I=
Received: from SJ0PR13CA0209.namprd13.prod.outlook.com (2603:10b6:a03:2c3::34)
 by LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 05:04:44 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::cf) by SJ0PR13CA0209.outlook.office365.com
 (2603:10b6:a03:2c3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 05:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 05:04:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Oct
 2025 22:04:40 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Skip SDMA suspend during mode-2 reset
Date: Wed, 8 Oct 2025 10:34:18 +0530
Message-ID: <20251008050418.3399656-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: dc101170-02b4-4e61-b1df-08de0628316e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XMKyoJ+IEaeNbV85wWxPx4ZgqM6Gbio3b0DKa0ZvQf0LGAX8lGw1uy8KNMDP?=
 =?us-ascii?Q?laByn7gme+fGtuY1SDThfOpvI3hhTLFTWwZ+DfMCQr6AtgLXTFnIyX3Kfs99?=
 =?us-ascii?Q?G5PJp49FKbgXeaLMZfpv9vIwUCB+yDLrv/AQFJdw9+kbg6kRQEm3o8H4LYui?=
 =?us-ascii?Q?fRvK8Hi/cDctUwHcKMb3knkb8bly6k2Ju0FT5Z8qPNtbbThbYARe1IppkKBO?=
 =?us-ascii?Q?Px9JYUE47TC79DlSIPkveUlTBgBXWNLeqACvm9cBXmTcizcUo8pYiTHy+bHP?=
 =?us-ascii?Q?NCcNMHZ5LOY56AqVzeFs0FPpnIKNo0TTBIV/b9eX7GUDYM+WQ+ntN7/Q+ru8?=
 =?us-ascii?Q?JehrKWUA9Cvf4++koERAAShlEDwDhapH01/VWtwkLuvbuVU+9ZdcCkhoe758?=
 =?us-ascii?Q?yysJw6HPvjyY+Eh3xpu/wOS9RnFGv4TYkoeMaFABFZyPdKvzh9JtX/RMZGFK?=
 =?us-ascii?Q?lPe48MT/gyv1usb7suY4/CCh/n3UKn5P0jnXpeZSrwzYnCqetEZ3pDkOFbpG?=
 =?us-ascii?Q?CgfmWmrrcDDBg9QOOkJbSoAx+eAHhHv4bbTT6Z8uPVfG24eYoU7adXfxtsZE?=
 =?us-ascii?Q?IXu2zKiq9t0MvnAEX9K3CPXvlN77dJ6Dj4SBhkN0gzNv34onJzuyJ80rZhjE?=
 =?us-ascii?Q?A1yBXT9AkP5KJV055Jm43Vp9sKGCIOA/wMwwjJ4i0SGjTzhdDlgTVh5vZNcl?=
 =?us-ascii?Q?4dDh1sQ7Gv71QphdBVRar2yyKiN0Kmdy2rV96CcMyAjSX6i+k5YWgxgcHcBf?=
 =?us-ascii?Q?Jxcc2HBgfRtxQ4jjYRKDK1xOapdAkZSgS062eopIjVKQ8EvbVZ+cRo+vGAFP?=
 =?us-ascii?Q?2zGwvqxvbChdDG8DF7ONjJ99F3ijiTBvJXBTD7nmr4FgfwxbdS5gEp4SlSV+?=
 =?us-ascii?Q?2YNdkG51/W90G7/EyltwhxL/ukjuLgXvYxZRmG0t50a2vRCE1ItL298GLLw3?=
 =?us-ascii?Q?f+ktlWOgEKC/0aRNZswkVEpb0OecmqEkM9yUcWa2XG/QHuOm4Wnuntszv93F?=
 =?us-ascii?Q?FXoBcIseyO2ZR5nKUAIbT82wjSTM0H7jNhIA/09riXNJEBlHSsOVetwrfXqd?=
 =?us-ascii?Q?aVOA0qad5aiF0Jv6gtOcs07BuqHMa6qaMWdCiF7G9gLLDn3dnPxa48AQzmN4?=
 =?us-ascii?Q?5pkFL9m1jIm9E1FxF2HyhSNoa4EvPhV3ZlXak9ZNI6Re4JYb6LGyD5LooZbA?=
 =?us-ascii?Q?CHcDnHy3YcLDH1BUhhUaJ/vwOFeTqpS1HHLZETPVrtkthGovBU0avsl6/Vc1?=
 =?us-ascii?Q?UX9LHJl2m3+aN99/n/yS0PdXyTNj4B1/IPy8RnTBV4YLaEcPf1PHF64NRVuH?=
 =?us-ascii?Q?6hgCCRgeUijy3V1WiXC90O/IUVPMWN+EW/JrkTSGU85r1QKv8pOBcjDlMQKf?=
 =?us-ascii?Q?yjue+nPatmwjFWebjWYUVWpiXo3/Dnoyw6qSAreGU4gL9vrk8XqiIgHPU+rl?=
 =?us-ascii?Q?1BQCmKHOh1V56Jfiv+VDNQyYywhChlg5SB7j/iM5n+uBngEkkK35YDvvOkyr?=
 =?us-ascii?Q?UWQDo65QCJcwc8fsSlQ1nHIs2O0hfS7KHzLj1uqryNULVjS/RuX4ajUrV/c3?=
 =?us-ascii?Q?8UbLaf9AHudQBGOAuCg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 05:04:42.9649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc101170-02b4-4e61-b1df-08de0628316e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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

For SDMA IP versions > v4.4.2, firmware will take care of quiescing SDMA
before mode-2 reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 9569dc16dd3d..0007d00b9e8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -88,6 +88,10 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
 	uint32_t ip_block;
 	int r, i;
 
+	/* Skip suspend of SDMA IP versions > 4.4.2. They are multi-aid */
+	if (adev->aid_mask)
+		ip_block_mask &= ~BIT(AMD_IP_BLOCK_TYPE_SDMA);
+
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-- 
2.49.0

