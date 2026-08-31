Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB36FC624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 14:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4246610E90A;
	Mon, 31 Aug 2026 14:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEShh0+Z";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B6110E08A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 14:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N39vyMA5wGt/qslrt19SGjj29LSSCFKXFRWaDjIxQJALvp9llAA0ko47wudb94D2TMsV5t3maFpZqfJVTFc2+wei5Y6Ht1Pdalz5zIk9jymY9n0fxYYa6aUxnF+L2sNbxGM8C1eg7Dng842pQ3hJ7yvpAo1nN8mpdvJbbikqz1OQ1SSd2QCuk9wM9kVgcGrgOn/6uagam5wUn7LqB7PYCs5/zGc4KBxrG0hZabdNOE4Ot4Z1en4MtmXKnw6bpv6kqxctiMJYnJSmFL2bzrf4xDEmD5deVSpppf/M8mANrrTUZ3fXBEZjQcs2+7sF0uT9luMdfcqBhRwcFZdR1iyPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx5ePEQl/k7jjLdAVtRz0c8aJKfLPNCKd8htZiXheho=;
 b=Lb9zghQcOw5JBAASZS3td6CcTRK5KIHaHPsORfhbmCQEKQmL8+ONb+AkSS5WAOxg04uBJucejgdYaeDNpxAKi40Wp7x8iZdrwA1zT8Kruhcwr60RsiyBDz8THYGzJIYwb+fI6HEWoWzchlYilTYO7rElP0JSu6OkCUrJMqox9P+aEQBpLAC7OKkJ0KGEfGi9kNiV3k/4Zrf/hv/rtXcvpnHuP8BFPq/T+loAYkeYpZirkYlagWl87BSbfx/d0y8Ua8ZxIVjpSWcdSmN/tYx5Zoilc8VY5e2HhfpfmZfaglYRD2D2oP/yS/tnizvIJYPrJaCF++zNm08lU0YlHOJSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx5ePEQl/k7jjLdAVtRz0c8aJKfLPNCKd8htZiXheho=;
 b=ZEShh0+Z5/1+08C+OhZyovezs5DsR73wuVmH7ITR34hyUF0gfLrrE2mdqSy1xDWg9v6FT+gzyDIPxoFOu/Nh3GhxwGi+K1ellS6FxfSxXVs52m3zYSyR5z1ePhUYFjUJPgzh5UxcxW+X5KYBIqfo/Wq11DETqdqB8vETMi4JO90=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by DS3PR12MB999217.namprd12.prod.outlook.com (2603:10b6:8:390::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 14:26:31 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::16) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 14:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 14:26:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 09:26:29 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Mon, 31 Aug 2026 09:26:29 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 0/4] drm/amdkfd: Enable device private memory THP support in
 kfd svm driver 
Date: Mon, 31 Aug 2026 09:24:14 -0500
Message-ID: <20260831142418.56423-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|DS3PR12MB999217:EE_
X-MS-Office365-Filtering-Correlation-Id: 51032f54-2797-4c69-88c5-08df076bd992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|13003099007|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Hz35zqpl0dnJhqxVVjHHtlZjxryLWpnN9Rbz/4YhJ2jOa2wGuA4QkdnaZlh1geYpWCuvHkhBHkV9Aop0GXJ066R31+cNzpPyGZmnb+e1qNaxijaUdwYA1xe6QVhjNaxNdcbv8byoFeU1BWAvfm8XO+AVRrZmHwoz9Oo5fJ+KC88XWgeCbY/1nMcGiecpkXS+4RISbqfLGvQO7yv0Yd6DSy2dOoZTSUdYnBLyqysS2xKUczU51OqcMT1ipRpSsJH4v+s1F/SAp0gwtBcKHlj0lc8NpzzdHWc2boWCMlL9WiRpx7mPhmp3iYy4nkG+vUdHgIsGFX7strQsj9SMTUiFn1ipoL1Q9ScKkLguc1t3SULLeKj8K3xCsE1PRX91VYv1KrOO7nhxMaaKDfKdxcraymaD7N0kcaMN1R1yd8uuY7p105BZ5Bz4jHBiXp/aCueI3igpjtk3ypgPDqE5xLueVGStwjnhy5sYv2aWvihxVGWCCu+yoo0V8fLaETW6kASY7TO256cHKOrBRBz3q6lk0S0H9zd7gCXL66edd0Hv6rpPzLiPZKse/u8OjF+8NaKFuXqnDIsMlNzllUoBZS/FTqucKSZvFI5NtaYMMEnGSD0GJujCKLDATq6uF2vkkwII8bXerFv9FqTj/Aj9/kMFvH2UE5GqBYHvilX9xj4Iyz0VoFmGQWAKvXXoFaNNSx+DZjUoGDHryS4lVH20HX7smg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SMd9QIbLsdZj8XIvboAG7HuqKCGqEUFoL0tN3gF2UxVg6RyqFHUBjKqXMUDu7OuoB7f02Czeu2bXoCSMbY9/+E3xMENl+IJq+zz6yFON6WGdmh+HAz0hjvoc27+TV6QzW3ea1IMO0dI6J+z+ZqsqBxhKm5pBCR3jKVg3yijVAH4J+ItiOz5T+j/SLV5KNggYc+h/DC9qknVTm/MATSloMs/rzYxRmUwsdXHWSeqgJK/02e971d4siptFIk+JebdGv+QVbRoj1HbCzkGTe4caW+rPwbd8+Cfs2a5nhs//Wq0g7HUSSuJXYlHNNFBfi4O9rQqTXlw9eqTZC0IfZQGcWXGiwCBB2pv6hExkefazRqvFW5C1SlkZ0k+vUj3y5/0K81W8WTI26+NpyDVpMEKT4Qp6vV0uOKcsgIYB0ZCg4qZ5c6hHpDXiSe8wVczVzJoH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:26:30.1773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51032f54-2797-4c69-88c5-08df076bd992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999217
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Use following work for device-private THP support in kfd driver to add
2MB/THP support in migration. The implementation enables efficient migration
of large folios between system memory and device-private memory.
    
https://lore.kernel.org/linux-mm/20251001065707.920170-1-balbirs@nvidia.com/
 
Xiaogang Chen (4):
  drm/amdkfd: Add awareness of THP of device and system RAM in kfd svm
    driver
  drm/amdkfd: Change migration size in CPU/GPU page fault handler to THP
    size
  drm/amdkfd: Apply HMM THP zone device-private memory migration in kfd
    driver
  drm/amdkfd: Apply AMDGPU_PTE_FRAG to pte of gart page table for THP
    mapping

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 290 ++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  12 +
 3 files changed, 256 insertions(+), 63 deletions(-)

-- 
2.34.1

