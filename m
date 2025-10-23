Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55125CCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 16:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D594710E933;
	Thu, 23 Oct 2025 16:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XsjDzSHI";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010041.outbound.protection.outlook.com
 [40.93.198.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A0C10E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 16:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBmrNEdF/s+T4DD8ctEX3dZAX6HCaIx0B4+vIJG2waQxFx/u71QCXa6t7wH4Ih+kcOAobWV148n9NrjgoTXCp1BNunF4cDWd0I0Z5ERFtT2P7r6uNv2afAVlbsG7SlTzLMOS6TKUVfaxEjk01mvg99zyRj66M7fi9/93AjLQM11atQxUpJw/njmfahmEyZFGi5PCb4ox5IoIAqEk8v+9upncLLFVma0wQxszpUDiTWA1lD6o+Qma79N914AcTgQGLRs6T8j7745xYjP2eNObmrSN88rHyqWTcoSfvquQ3O8P39X13CSAww4kAW6vXg1GyXESM6zmeAHlcZfJS1b1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXvQNTh09NKYVhl9LtPARdFah9EGzsIP6gB33+DUtMs=;
 b=afmOR1l/d4TkcRpFS+/WTMlz2a9FgE6L/LZ6/lGpLs/5RUKmV5haiig78qSPYW9MJ/ThLF4b/JSbZbTjWcG26RwlawM1NvwNNsJEApOJeT++F1OpHH++6Hai+Ir8RPA3deSOzGfIwSeYm3LPtzHc6MM8U+EgA78eS0YfxXpKeo4y+u1lOS4r9+5kK/x/MZSKyicQsfygnAafRIDr0JkypNXlmEMijr5pYdQun5XVfI6T1R/RAQOfCKeFJPFyL0DI0rydSSZ7e6eUOEYwGCi9LyhfFXJK17NH7jWGMZsp01f2yQzvT+wLfhkhtzDuOgfMxc7wiJAcHLaA5diM7PymuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXvQNTh09NKYVhl9LtPARdFah9EGzsIP6gB33+DUtMs=;
 b=XsjDzSHI9dlegb04D9Yq/5Q0jMlf2eP2vPq547KQdUSGPbG7Dk/3OIJtSvhm39W3iemVxBZ82OFZG1espm9uT2KMcAV95p1SPQiZRUkjkhOddXx/LYqK1+dullLnmEToHTgaPfBh3GhaNUYzvz8NUelzA7j5uB5UMpTv5WahzX4=
Received: from SJ0PR05CA0114.namprd05.prod.outlook.com (2603:10b6:a03:334::29)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:52:56 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::15) by SJ0PR05CA0114.outlook.office365.com
 (2603:10b6:a03:334::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 16:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 16:52:55 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Oct 2025 09:52:53 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 0/2] Unwind failed suspend
Date: Thu, 23 Oct 2025 11:52:38 -0500
Message-ID: <20251023165243.317153-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2f7358-37ea-47fb-f597-08de12549d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RBEtLxZyUcT/BCLdvbP9kRJoPqXfUNoNogF4rXUoRNuNXPUONU3nEJ6bnvSQ?=
 =?us-ascii?Q?CT38lRm/TZq8dJRDiaBMdYE7s+Tay0bE6taHUqxX3qF1QFPXN4FMkjAy4zRG?=
 =?us-ascii?Q?ZUOWdzvIUHPDi0tyJZP4MBrfj2t5KK0VmwwlsuBDN+l98ykD2w8XA2tYJ96O?=
 =?us-ascii?Q?tsM6Uw6BdPVNJ43E9j5awNHunzhduDESV/xRX5D5+bB0VizNQieodVW/RGKr?=
 =?us-ascii?Q?lDQfDdAKVcyV2uMvb2fAwS8yl9NCWm9XSjPpsZrgW2GwZvPuW2EJQTj3kQnl?=
 =?us-ascii?Q?qJSlaqhLfa2R7R4rECVn38JK6qQrtWjF1EeyFqWaXAmIiXOXDAwaUpThXXYd?=
 =?us-ascii?Q?l27mLssbmZ1htixB0ZtLaMXxQPGjIP2sAht/qvFimnYPmL9LkVo+SkB7TErs?=
 =?us-ascii?Q?pNfXluLDalOAgjEBtdD9kq54+kaLx8iG1b6Gmu1PCKV4purmTgyp0y883DOs?=
 =?us-ascii?Q?y7IhCYpdOMcoLyzvCaS+eDM+/vGo/lOE9/ecZbAfoxp+DqQqakx2YLbSzS3n?=
 =?us-ascii?Q?EchF3p0e4X5JbSxbXUke0DggkPy1bAXncdrUsGPebIX3NrIbnasphi4HAway?=
 =?us-ascii?Q?7W4Ojt1ccjp1kIxa3zWAOi1wqECnz11Kxhwa95tM/7iqgqanFkHjwx5YPTFB?=
 =?us-ascii?Q?D1dHUBnNuxs/Pxn733+6+7nbtNM+me0OmYMKptlCjTXp1TTFEialsDpzlK9Z?=
 =?us-ascii?Q?eVLxxRfrAWRThpYqspFzYpWRJkXytrVW3j84WIS7fodah1TIesRDbSHkE1Tj?=
 =?us-ascii?Q?Ld1Ta7NDZc/5lA1yQRp5kI4acr9TEo9vbDQ84voA0uVLyHOSlN9XZioW+/yC?=
 =?us-ascii?Q?9zAqBk+ZzF4qWLSxo8YMbfnUS13VcwtKpK+2JAD+mF//ST6Te4v9HaOlT9vn?=
 =?us-ascii?Q?aEvzqIpcfJyRJMEoYH9vTMmllL4QOg92iSSVJDNfBLfgHtCkqQD9tIuDXXib?=
 =?us-ascii?Q?U/8ZsVXnlEHLxrgVmgWUnQVDO9vfgaSN0BJN+8OeVdB7CQjsG6jxt6m8KiYn?=
 =?us-ascii?Q?JqFc/F0KZaZTGrctTlyM8OA3FhbT3/EE4hrQFHFjZGf7LQRz26e2kZvmNFfA?=
 =?us-ascii?Q?ievZ7oiME7SorjMk9V5HXHOELMV5d+iBPcEcRN5CWO2w0dTxTTA9J5GSP2+Q?=
 =?us-ascii?Q?cj4yu+ZLYwJDSozfNhOKKodLZ1+rki61EspMQaoeC5ywknJO3bxk3rWH4nBf?=
 =?us-ascii?Q?EVTKtRQKTuxbxD4dH3mbG792PddljevtxdvCumUw4QosrZnQb8KBSDv8JcUx?=
 =?us-ascii?Q?sNh96EElRD1no4adl27abS/tF0XdUj/roDDCx98Bg4VmFDJjf6mWwgrZLnZu?=
 =?us-ascii?Q?HCiyM+16qApLu/VhDb2sgLgdffu4TetsbmZWSsaPT2G9HmOT7GxFGrIl4iIQ?=
 =?us-ascii?Q?R4oyc2PUvQWvz3TBdDjmaS5vx+JElSKObVvb34Lh70LjUq+I4bGu4knwETOT?=
 =?us-ascii?Q?/P1BKHeU/8BQ3PO7COYqII+lnuH5WHLF7vQt6sTGJuEov57TQ+iHlD5iOxXz?=
 =?us-ascii?Q?bnOU4SkU4yTDbYWCZF+EvwpFL+1d/SoCLCdPuqt94Ns0mMVYtLHNZXt6E7mr?=
 =?us-ascii?Q?8eupHhSbotcJ/ym/Emo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:52:55.5695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2f7358-37ea-47fb-f597-08de12549d31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

If a suspend fails the PM core doesn't clean it up, the device
is just left in a bad state.  If this happens during memory pressure
it could be a hung system from just trying to suspend.

For all phases of suspend that return an error code, add an unwind
flow that will resume the parts that have failed.

If this fails, then reset the GPU during complete() callback.

v4:
 * fix git am failure from fuzz

Mario Limonciello (2):
  drm/amd: Unwind for failed device suspend
  drm/amd: Reset the GPU if pmops failed

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++
 2 files changed, 83 insertions(+), 8 deletions(-)

-- 
2.51.1

