Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5EEC02192
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6970D10E756;
	Wed, 29 Jan 2025 08:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ewe8EadN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D6310E756
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUoumkyzkp6bT3PYz+/7CDG9YnFB7VIHRF4+tBQaWITuDp+kL4oxOZcuhWgWwP/3pUt4BdDEBSgZYlCEFT9g93iQT9IN6FJRIdTg+SkVee905gbgRvTYky17HV1xjb9BWgt42HcDZ+0gB4xfCQHf2e6bFNl/MgMIYOMq/36gyRn0Ebk7BvO7IS6L+7Hfm3t8qAZRgq/SYkeVbULYPSBV2vo+uskpwz3Q6Mp2lCS06hm71Zw5qzgOEH4O/BYGxz2hxxP0W34XDfGyM8lexJIXvNewJBeYJ0IgWdje/Kn+GIQtef2n2g0F0gn337AUKAoHvhPpQSFi1lKbcm0nlCm47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVP47ZYen4tkLfP/LhovRWp9iEem/r5639FSjcNFNDQ=;
 b=Gj1N4v0LfqJ+g74RhXxVRGmksr5CB7BoigPiVI6O3l5sG5heg/qL3UmUZ4u5F7i/MJ5RSX6s6iqGIkp1QGD/lNHhS0zQxvS4SGrkCmo/32FoS5xKFxVzZ5wDDc6LD0zERM3ja8jWCVG6MOKmW3wQd04BBOjW0x7GaqpzduHm+Z2wOckMdtTRH4v/c9kZnFKnKHN7q2xXzIiX5gb1yEzUErnWKUHeGTGbXBL0c5XRr5SxATWPm5TrNBMtkGy8/QzekEQZzrMR8QOPk3+5pCDd2f/9zl7N+wj7oU2wHrwrAz+4KHcSStOlmiNNa8xnf/SxgnsUhe8kg1AF1Em2bDDzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVP47ZYen4tkLfP/LhovRWp9iEem/r5639FSjcNFNDQ=;
 b=Ewe8EadNrZfRKHdhTX/vwCROC1Ofr8+GI0Xom9vTQqu/9zc/saNtwfEn8oJJFhwDH3ofIGnbu837N1cdbuMRjEhdp1PUSWc6AJXD5vhf4lNBluaywI1GkFgnLdnyrCxswmopufFf5fuWYOA3Bx1J7fsnNM38U9wb/S6SzIC2BJU=
Received: from CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 08:46:58 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::e3) by CH2PR10CA0014.outlook.office365.com
 (2603:10b6:610:4c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 29 Jan 2025 08:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:46:57 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:46:55 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 0/9] drm/amdgpu: Add jpeg devcoredump support
Date: Wed, 29 Jan 2025 14:16:34 +0530
Message-ID: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce57cc8-2885-47e9-4ec9-08dd40417d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVZRL3k5aDZ5Zmhwak5tWXVMSkQwcXcvM1hzR3RzMEttRFpxL3JYT3MydXYr?=
 =?utf-8?B?blV6dHJQQXg2WVA5ZXpSdVlJNGVNY09zbGQ0VURTVUdRNUdYMGlacVZnZDlI?=
 =?utf-8?B?aldKUEwreEFjTldlRXREeVhIbnJQc3JBcjNnbFY2bW4xMlFkdGY0NTVpS0hX?=
 =?utf-8?B?TSs5SzBmMGdHKzQxaXZrNTBuaGlldnlOcDFocFRNZzFxQUVhOFNOZm9oYU5B?=
 =?utf-8?B?QXQzZUJnQUlLOWpuNXNoWUhRS05KekwzRkpnaHhoZnZ3RmNST3RJUm9YYVVO?=
 =?utf-8?B?TUw1TWxNTnI5YVJUZHdHaGZsRjZTOEQvZmVnUnNIU2Y2aWJ0bTJHOUlMdG1Z?=
 =?utf-8?B?RjREcXpwOGFLS3RpRGlHdDVsbEtzMmpCQWx6OVd2TjRWU1FCRmlzODdKbEhP?=
 =?utf-8?B?MnZrcHlJaFFERFZzL2Y2eGVKbGQ5bGczaGZMQmY5R1I1WHNlZkRHbTJCeUto?=
 =?utf-8?B?ZkwrTkN6YkVlR0dsZnZacEpBWEVXdVM2dkJYaS8rNDNTWlAzZjMvQ3BIWm1a?=
 =?utf-8?B?UmtJUS9IaUxyN0ZMQ0NnMWxBZjVsNHl1SFV0ZUlzNGZEZ0t3S0tpRUtMWmgz?=
 =?utf-8?B?Qndlakdka2s3NEg1Z0NBNnBXQWM4ZUZVa2M1eStxa3NGaDVTUHl0Ykg3MGRo?=
 =?utf-8?B?NUhIa05xOUMwS0tHcFBUQnpTd3JUSWszR2gyMGJjMG9PdGlwTDJBZExXZm5l?=
 =?utf-8?B?N2MxMmRjNlJ3bmp4UlA5bEdXcE82UlRTT0EyelRzQVN3TmlyL2ZjaUcvVjY2?=
 =?utf-8?B?QlV4Rlp4TXVmUTF3K0JoZHdBT2EzdTJzekY2QXgyNHdMYXFmenFTVE4ySkd5?=
 =?utf-8?B?dDdwMDBqKzNqcUR6d2RaWmFWR0lQOU80eDRETlVTN2FRRmIyVWtWWjNPZzNp?=
 =?utf-8?B?Nk56emFCeGNxa3VZNjZVcnp2U2JPbWFVbTdyWFZlMEtHRFBuOHR6ZStHTmFT?=
 =?utf-8?B?RzdQOUtHZ2FmVEJ0TEZCdUxCZlIrV1hKWXBqbGpKV1NJYlFHWGR5ZkxQb2sv?=
 =?utf-8?B?UmpIclJ0WWgvbWhjZkZSYTVMUkhwUW1UaUxGejk5VnY1SGsrdzZDRXk4MDc5?=
 =?utf-8?B?L3pZNXArNTEvY29wWDZyY2lKTFhPZ2g4QmlYUVErMVBPWVZmeUVHQ2JIQUsv?=
 =?utf-8?B?NVNObC9NdFFMaUZPU2xJcDlJaXZ0OWdWSnlTOGRHUFNmamZLUnc3N2NxaUE1?=
 =?utf-8?B?d3ZmQTJxNTl1SWNQYTJuTGRNbFp3eCsyWDFxcFZLaTdYRFVKb1h1TFFaQWEv?=
 =?utf-8?B?UjdvZUNHYUhuT2RZamovMVFVdFdYNW8zdk03WWFVWnptMHg1Q2FCMjQ1MnNp?=
 =?utf-8?B?UFU3eGxjNWFFcGM3ZXJVVjVSR2JwWkVFT1FJY3c0NzY2YUV6WnZ4cFlhSnR3?=
 =?utf-8?B?ZDBKWnFtVG1HVXlwbkJlbEVyamJnM1Z2V29QMmpsOXJxYVhvZmx1SkpKL2tZ?=
 =?utf-8?B?a1YxNSsvSkVUdnVReWZFM0tOZzVzRzNKWjhBQysveG9jZWpsL2FEamh4OFlU?=
 =?utf-8?B?cTBzRTA3OXEvVHpacDZxVHlSekpRWUcrYVg1T05lbmFrUDd5aEFJOWQzbkY5?=
 =?utf-8?B?aHpQQlNlWHZwcUxLWFVRMFNZR05WcWQ2R3lheVhqZklTVGFlaVQrSnhaa2dz?=
 =?utf-8?B?aXlFQnpDcVkvNGsxeDdYeVNTK0h3N1RzNFRrTzBZTXYxTlRnZHJjMVR1T3dV?=
 =?utf-8?B?ZitTL0F5Sk5oVXE2WEpUUklwOHFXdmt6bW54SDJ6OHk1UENzemtwODV3a1Vq?=
 =?utf-8?B?Z2pJV2FHcGtRMzFtaldmOUN0YTVmVTR4UjBMbytkTzJqUGhUay9uSTZSM040?=
 =?utf-8?B?ZEJCSW5XTC91R29zRU1wMy9GQUdtWUFLQU9UZElLZ3hRVmR6blJMSUV3RS9y?=
 =?utf-8?B?aTJEbTJWNXptUFRaMHYxVVpaZDBWSFVLTndQN0hhbS8vSm9KS1pyUDRFZkJE?=
 =?utf-8?B?d3doYmxyQjcycmJmM2xjakM0TFZwVnhqY3lmem95QU82MnRPcmhZVEMzVFJB?=
 =?utf-8?Q?RRNfeEqOHKelOMVZQfB1TRjwqNGJbk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:46:57.7604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce57cc8-2885-47e9-4ec9-08dd40417d7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

This patch-series enables jpeg devcoredump support

V2: (Lijo)
 - add amdgpu_jpeg_reg_dump_init() for memory allocation and reg_list ref
 - use reg_list and reg_count from init() to dump and print registers
 - add amdgpu_jpeg_reg_dump_fini() to free memory and clear reg_list ref

Sathishkumar S (9):
  drm/amdgpu: Add a func for core specific reg offset
  drm/amdgpu: Add helper funcs for jpeg devcoredump
  drm/amdgpu: Enable devcoredump for JPEG4_0_3
  drm/amdgpu: Enable devcoredump for JPEG5_0_1
  drm/amdgpu: Enable devcoredump for JPEG4_0_0
  drm/amdgpu: Enable devcoredump for JPEG4_0_5
  drm/amdgpu: Enable devcoredump for JPEG3_0_0
  drm/amdgpu: Enable devcoredump for JPEG2_0_0
  drm/amdgpu: Enable devcoredump for JPEG2_5_0

 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 80 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h | 10 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 24 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 26 +++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 24 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 26 ++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 98 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 27 ++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 51 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h | 61 +++++++++++++++
 10 files changed, 393 insertions(+), 34 deletions(-)

-- 
2.25.1

