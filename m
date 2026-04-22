Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908DEFA1FFE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305B410EA4A;
	Wed, 22 Apr 2026 21:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CXtPPOBl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D024B10EA4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJuCitjmNjwixACCs3mfHdr2ut2W61qNydd3a3gRcL0CuSyd/LTp5CyMwCYoD3eHVDZoEC8oYzfyW+/A2mMzbBNGsJbdy73V5PDxtQEgyPYVBFmruchzFluvTNRbJStWvqPhAMX97cX3KSwqZAZjqt1fvp5HvZwTsdKjunaE0X+fHSI65Di4oknLBqBwRp9zhgI4gmgq2EQr/jpfFcZ2k2X74/BC3HZiWS9VVxCeBKylap0QWLc8o8mWTusG9csCLm3s/xcK9z66iiq8Ka/s108ULg60/IG2Vr6swdZTZtIA2eJxEHuHNeoZydc1iAy0b342nUR1pxMiHFwT/ijQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhPIMaI80xKRfM/19LjxymGPdWzdQo1hOR6CEvD03m8=;
 b=Q9xQE0zcdE2ZpVA2g2RdiVtzwdvjQyXYgJGTBMDS6+21yghfZG98N7OSk7g3s8UGRia0su9t25Pn4XSvSjajGkfKnR2geVkcTm5ESCWGUL6QZb0Qrtx2SBVf1VdG/rJHPyIORRhWpIU4JBuhFZC7kWD0CzCAXjdYqybwCV6h4fgZlAR3JvX65yobbzB4iF2pBdBuBWFasr+Wa4m3d9dE9R1ENqCXulZriVzHRMnT+62WEo/9DnGbTC4s7Ee/FZms+9DmmWJRS0Cw02N+jSQJ7oON9EgZCgozna3F1KJdtftEeaQe5eaTEGebOq7WPfnilDBw9NYWnsDkwDVFvQKqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhPIMaI80xKRfM/19LjxymGPdWzdQo1hOR6CEvD03m8=;
 b=CXtPPOBlfDa1MMDwTu8LDFJW0A8aWcGq3y6seG0vjgW4GSG+iiFMS8KhPjclxCwMHzebNBW2q0+5N6jzMiHjnxm39M9B89lOPA72x/3T6xYuWdYLFb3C31XzHrrHkJhJ8aXnZ4Qdz9uUIhqb3BP4vCHKt4iLz0mYaWxpOMJjA8I=
Received: from BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 21:42:22 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::bb) by BY3PR10CA0008.outlook.office365.com
 (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:42:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Apr
 2026 16:42:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Apr
 2026 16:42:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:42:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] Add NBIO 6.3.2 support
Date: Wed, 22 Apr 2026 17:42:04 -0400
Message-ID: <20260422214207.2241171-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 17696aa8-e5d0-4afb-2fa8-08dea0b80912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ppYdKbgK31QAaaeuAvhUdMVOcgX8+937iL2ZNHQXVsILy5WpOirb/e+wkmrxW+XwqGskN6lAVsuU7xSUXiIvXo4GkyB0jXikT5vE9s5JWf1Z04KmpnM1hWDJ2QB4oBisfP0qQgn8q8b9Pocc4fFbkXZIfxXmyqzD3VWUJpsmslBbqaUsnlHxuFFxHpukOIi+7Wdxx5Ll4XwBU382ou2karAw3dOYPUaejH5BPJ7zF2tbKzyyNbNgNAWoAosW44mJHUIUPWmyJX3N6QvaHgoABEPhl+FoTFgJOx5ICeCucUi5eVik4aafyI2Dhbg9ZOxGY2KmIyze7kOhD/CstB3owqbYfMJufW2E/LzwdF0lc6kNo47F0aE7N2FKdZFwxiIP9u0+UeC3D9uPGxQ5Dt2l7yI/Hr8WxxuSTejXhIU/eSsUwcRp056+HkQ4EBkDhtKNKvmHwjZG0lTgTT310naR/wcQM9zplrNA9ymQEEPx9giR9SpNpOxyNwz6Ztt9deIKiYOBIrxiclrGqBWhJazntHkMY0EkGNR8eHo0JDi1p1VyubVBr7cg1rNsq/V90quOhKbr5BFuXgzSHA4wR/qa/2Aonf+Mu6UGX8mbiCvgHglhXQBDjIuudQhXlLUq16IKJJNI2i4lS/Z9q4SRVJLtY7ZooxwSue4y9YvmX4PaYoFMI6lzJ3RK+7XFBmyRZ5NoWebMTxnYnLGaDe+IJNAqPp/D7THWVyN13CkC5cnxuP4lUmEYJj6kSZsxOWbxGDPQQb9P3t+uskHGvNGznAA8Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eeJhj9FgkGEThq3TbHzXqrFED/evOWGUN4vuCn9dHGnT/evVN3jR9gBo7nyf/0NgfKufwsrIZQ+Kdi7X7g+4vl90VutOpHgXZEfYQjk+ucpmqRMjig8fh9E1pgq2y+kxLsgu18Sy/11C9APQFT4aZVH6J/K2Im1KouJGX+7SETh7ZpOIgQtzYmngYOC9lxk8coUlfSeUJbkuvvSxqUaNs3WdITtXLvU9WX0YaKsP7xoqEl9MZx5YDxaGJQnZlj/SYA0rxWjZRmUACUBECHn8J13W8TZ9w0qkQ7SS3EwHCccZ/Tn7Bcs/tqjLjs0W395t1T5akCoXkGOB2abIqSxRQtnlNILag88MprMkRCxB0nhcVOx1etBNGBllorCISyGcJU2C1SV6x8emamkZj9vW5OeZb2Zh0Qrg1t6x3Jlgr10etr/TVvDIKoC47k31ZuvK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:42:21.8466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17696aa8-e5d0-4afb-2fa8-08dea0b80912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
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

This series adds support for nbio 6.3.2.  The
first patch just adds new register headers and
is too big for the list.

Hawking Zhang (2):
  drm/amdgpu: Add nbio v6_3_2 ip headers v4
  drm/amdgpu: Add nbio v6_3_2 support

Likun Gao (2):
  drm/amdgpu: add doorbell range function for nbio v6_3_2
  drm/amdgpu: support nbio v6_3_2

 drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     4 +
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c      |   369 +
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h      |    31 +
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |     2 +
 .../include/asic_reg/nbio/nbio_6_3_2_offset.h | 13149 ++++
 .../asic_reg/nbio/nbio_6_3_2_sh_mask.h        | 49475 ++++++++++++++++
 7 files changed, 63031 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_3_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_3_2_sh_mask.h

-- 
2.53.0

