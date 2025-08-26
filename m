Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7573CCA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 19:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077E610E398;
	Tue, 26 Aug 2025 19:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ubhKlazL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7333710E398
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 19:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSEh/fWMHETrjsUANtCd3De5afhbyGCPAF/DfLgVLVL2DTT2wfFD3IbcZBMBZ8qH7KxoV/kWdMzfk8jjpXrBL42IXNxmrsZL8DZnr3uBz3JrmKORZROpqO2wNVadePD5K+u/kBiFJ4fehCkpBiOEFa8m20B+w+RJfwGxPxjVLcgEJRjrWZbNg+U0HEyZa8YPtM5HeEdHW27HIc001jDBQuU5dnEUt/96ynR5Hv6dxpj6anpWYDKstiTffv20MhJDe8r/0DAbg2Y1QPAJ29gcZJsYoY3/TphQcQ+DGeBFq0uR4IAWAj1qUJcCifn/7u5y4Qcd3VhW6mIs96/JMHNQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlahDUjjhjVYWKPmZP9ec2dOsFC9sqYfZNdDc4a4fSU=;
 b=KoK/Uonbn6uzpCIaICpysCC08SMUFYYy9zllnvRXOlBnMJOmgNSFmSznegjhMuq3o+P497qHnhIfE9gybeIlYNOO+21BJhy0zOZwlOQpAZ+vDeWmaRExOI+plZcBqMxDJ9WW6JNqWuZQKlY69gxNpoivLJOj+86XjvN9MQDt/nPfc+KfcCXRePlhN0IL8+r7ka43aX5eUUSDyrwV/xO0c5vIXlpw3zzYN5WhOf0BNCP0n1cyhqeQIBoim6mXq+bO5W3PsaQ58d8PoU/fGCnmPsX5VCxagM/DZWmrrK5wSm6gwmie2ftDO+qNtZowl9REgMTz6gNIxdrYSldxERjO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlahDUjjhjVYWKPmZP9ec2dOsFC9sqYfZNdDc4a4fSU=;
 b=ubhKlazL3/21U1k0qcasVbTbyAwbL6qpR6fmgsdcWIJaOvQkOPMvhKNCrc8bHa26dspRZn8O4iaTv6+VUOqgAS7Se/F1IJZdYh365is6vD0YZHHh9A0RMRoEXlxOPB+dQXsd3AwJj6malbRG5kYZVAF9WEf8QATAWQPSWYNXzMM=
Received: from BN9PR03CA0504.namprd03.prod.outlook.com (2603:10b6:408:130::29)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 19:38:36 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::b8) by BN9PR03CA0504.outlook.office365.com
 (2603:10b6:408:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 19:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 19:38:35 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Aug 2025 14:38:35 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] protect potential NULL pointer dereferencing
Date: Tue, 26 Aug 2025 15:38:19 -0400
Message-ID: <20250826193821.869445-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 395db09f-dbb2-4223-f5a4-08dde4d825e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?07N3VvDscyeCKVfsetmeCdNqSQzK9WQDai0bJ/iI3BG4QAmbPAQHxUAXIJc3?=
 =?us-ascii?Q?Ge3+Wx90tJl49hYN1l6tdVAUkHH9rJSv9TRVjJxhNUkPHvP9D+T79kqbTO6E?=
 =?us-ascii?Q?OIminGjPw4Yo5kpFX7EaHr53Bex2RVTeImdkVRYSYweunXOMcF4odg4JEl8N?=
 =?us-ascii?Q?T6cXOJi1zVvfQac6fuaEQo3EelwxQlljzk6Iib6/gErASRTenjDKmN1cTkQ6?=
 =?us-ascii?Q?z/E0x1dw2iM/1o4XKzFtdeOPUuW05UClhXQqrNLt32EpIxqqlcluDV9itqmG?=
 =?us-ascii?Q?gNdTUmma49jlURKy37gdAdS443cuqzyP7q89V/s0mWKlkZOoMM8Sr+AYJ4AT?=
 =?us-ascii?Q?Hoeb0d9LoxOxcCaCj/f7tCREGDSIxIiQzhXI3v7FKHIdQwQboE14s2H1fmgT?=
 =?us-ascii?Q?stADZWvrGWwhcAGL8IxoB7fjNS2m0GWLCzAqbBMPjwETHeknBDSki6b2PFY1?=
 =?us-ascii?Q?JoNsiixHJzFFPaCcqL6cHMrsCuQb9vQCm6zszWnf6ByAisnNVSEcocsNR+ZH?=
 =?us-ascii?Q?PugVP/6Vx1zGlMNVyKxxIUoiDhfsyEAGfFM9ZptlnYcQwLU3VvLp0WQ1M2ts?=
 =?us-ascii?Q?B9BicpaPMq8OUpkIBnXhXxukjYbHZL+h2Kt9OqxPlKVgB/I//Thti9S5IaVl?=
 =?us-ascii?Q?h2QKWy0pZeNMguwBxXMxE5SCHlDSdCxT2/r7BvPXhDRBLSRrZjA3ceoDEDCh?=
 =?us-ascii?Q?b+4Ec06Fv/HLn6TUPD6icGkuLhiacnah4HRP89uM4b1aVNoS5+T0BuCOKqIh?=
 =?us-ascii?Q?h1zLYogFALGwtkMzljd5Yvbp8M+zwRtfjwkxMBpw3qxOhnRsgTPYMIlQCjXl?=
 =?us-ascii?Q?H6DmEaODeFP2jNlZBlONZDxiHQKMPwNQizRxSDt08ukMfakEqH0Lof2W82Pu?=
 =?us-ascii?Q?hV0hWaNmLF6UVJZDjUf+Fa/UVlZRQbomJK4c5X6X+Msxl/i3EZGrcNt8nps4?=
 =?us-ascii?Q?v8i2wm7p/xorR9rm8BejfKZU7eH41cSZnNQ+wrEOb/K2kQlmmFCadayVugfL?=
 =?us-ascii?Q?B02fWqHa+jzmtbiZu+268ie3OENEYdVUh0VvousVOGDHFwJ5Lxo0cFhGp1f4?=
 =?us-ascii?Q?h6L+QD1rnoyLwvBHYltiCHCjThCea8iD97og8ZQ94eo2elgxmjIapQbZLEG4?=
 =?us-ascii?Q?n71PgMNHiWPQ4TRvJmcfMUd96XB/9jLTg4hDidJ9kN8aqSC4l8dS85ZEodhh?=
 =?us-ascii?Q?ugxtDUxnZQB08zdg+FZWHzYbSaMbQTWPPItlncqam6BGiupjB96NFkyv9lSC?=
 =?us-ascii?Q?3EM+pIMtbuVxAvRwNLeSbEhICke+ziVd8CUwNGvLUObpeqZ/ri2khcdgrHQA?=
 =?us-ascii?Q?xyxClwmuiJPOiUN1+h1MxnwPKwqpIoVk+R6Ki4uNB58wdy3Xcya04tFU8KrD?=
 =?us-ascii?Q?ci1e1KsqA3SE8CdASL6FmY9XBrdYmWG6P2wxQTCaun1lkKWU+SXS5Eu7XXqH?=
 =?us-ascii?Q?mXhruZ0abzCAbBtpyoIRjYN5SPbN4LXsJyaMUCPL4ctVYe7GFM8RMJXM58Oz?=
 =?us-ascii?Q?qCvMkosLZjPkQtJTV7YooiarQEGsQVdZiZAv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:38:35.5541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395db09f-dbb2-4223-f5a4-08dde4d825e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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

adding NULL pointer dereferencing protection in these 2 files to address
"NULL_RETURNS" found by Coverity scan

David (Ming Qiang) Wu (2):
  drm/amdgpu: protect potential NULL pointer dereferencing
  drm/amdgpu: protect potential NULL pointer dereferencing

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     | 22 +++++++++++++------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 12 +++++++---
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.43.0

