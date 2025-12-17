Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB44BD65C6C
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6055D10EBD7;
	Wed, 17 Dec 2025 15:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a1+VLV3I";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B729910E8AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieGN2hSVt+lvHvn5SznLvmmHLIZiM4c51fef+QBkzAptSPEKehv5x9Ceij4d94KWcjZWRiP2adNX59Eqwv2twm88kC1yuO9GSlEhThcsoMoJjny/FTq+8ix1FFFzg47jGtxyiVyefF+tqfuUPzyKQw27DTBGis5koafuUOzr72iKnuTAU6feCaIf6TmDGsaWupOKSK3NmuoefdfuWzYoZpDpWGEzs0mLAtIVZinPnV5iMjs/OHNkH3S8+ELgT3a9cOSDXYzkp1Lgcz1OmqjmXPX6hoNAT4dmkS8McpLkcH5Q/qO2xu67j+kebCyYkOCtnuUb5BEL2256fVXKj3RO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY66NRucSZKWnttoyU4h99YJKpTBmAFbxbtSjA9RFjI=;
 b=oJNFy8L7P8xN0DFTG4oGtdyqBIWPKTWhMqI5wcJgpG7ap/RabaQZeyj+sC9n9QZTYQaVOEN8dwgzrQR+SzPZdvVJMunVDkf8BASB+J9JtFPdgM4PVWbjZTrU0pDIyyQeoHE/GuzfaOBjhFzc7GBJ0KdbiDRXXJmeTzfjr6V12WTFbuIq6uDoMIvbf3WzoPEC8Kwsgzf69AghuuMEF2OqprDoCUAQtPnEzKhCNmMXRLdLrjrQuhMQgaxhxdxwY97z/ZdnxtJLC20FQ+NaTZBoem8gDPEgszDszurty72jSdBzNAbc1bG2xkbZoXJ54SLa+EBHpHZHNnHFeJBC0/KxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY66NRucSZKWnttoyU4h99YJKpTBmAFbxbtSjA9RFjI=;
 b=a1+VLV3Ie6z182PUfxFEdIFOOG8i3SHFa5CXSiRxaOgClq/9AyacRLrinasC649UQql/ommAPGI1jnddTu28Ucm1yM9g8F28KpwU1fAx0Him7wLo9m1j37ffUxuFXe4pObp+Bec9zfYM4SjjjW/U5+Dw+NdreCokr8iixiRkHw8=
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:42:12 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::7b) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Wed, 17 Dec 2025 15:42:11 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:42:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/3] PSP 15.0.0 support
Date: Wed, 17 Dec 2025 10:41:49 -0500
Message-ID: <20251217154151.2018978-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f93c01-9e73-4513-a920-08de3d82d846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J7SljpEfcZhXM0E7vctFXETgw6uwa1KdykrQD/W8/zM/ZZk0x4Mqcq7esKJV?=
 =?us-ascii?Q?c7GQk5u6Dt1kVZCeWslSsPW8kIcbjzAuzuUynG255Voemw6/Mr5UTbrW1I8q?=
 =?us-ascii?Q?oT3rgeI4UdqHMzkL9W8qtMp7XsOpgySF1pAhdi9mMTkE9yO5dfzx1hGxOBRL?=
 =?us-ascii?Q?zLkHEfvJat+aaoDfS/Oa00OookjJSpinWlT8BO63uiL7hwpUmjiNprE97pHj?=
 =?us-ascii?Q?lI4/02I9Ymbjt0qvmQXSXgGQI2c/qLNL5keRTqQUj1M2lV3bqkHjmeuAbj2O?=
 =?us-ascii?Q?VqpMFuRdybM5tlgs/+Eo5Jdy2/iAxrsdzcpFyEzlHM5q7Wm8Ha3ukSpxCkCA?=
 =?us-ascii?Q?oOzyjXUajnFM8/KOapwz/ffzSSmWFlmh9Pt38h+lPMrVHaze4ZkzsNNkF5/j?=
 =?us-ascii?Q?1pLb9cUpjbZqGjQleWSgiBXZ53v6nLAp38kN/hbw5DwQGgPD0fdQ8jpJl9nz?=
 =?us-ascii?Q?78oU4KE0ZQvP071439O7xGX1hxKFcbxzI/iixcZW8VlHFfsUYusnqDxnkNTR?=
 =?us-ascii?Q?Gqv9jjFy+37OjoNJqHheZgohAtZZ4S4ccPl8OrYaW0mzkbJ/P8D/qjKW8SBH?=
 =?us-ascii?Q?JoBLI/URS1QocMrU8n0Kl0pGjoZKe0+6plyTePWfCgfv8kzWRR+uC9vbH+EJ?=
 =?us-ascii?Q?ah9dF+7ljDBdP4F70D6fjnQq6xw+OOGzKkAd7HN2GdpEikx1z+fYtjilC7ch?=
 =?us-ascii?Q?v9G5dgvWLkiLnwQP8VHrK9DFUyEpsc7aGxB/LUHQBr6A4OXCk6+yIYl+W7sI?=
 =?us-ascii?Q?1ePPlSAZVV7mqwQjVGQW53r6Awv44ik7Y9nPBeCwaVu40hUj2GhltlXWoLBr?=
 =?us-ascii?Q?6kEE6G74gy6jXBLEZn87kYMS0+TkNC7in6bga7upuNkybXxZM5RsTP1Ak9Pl?=
 =?us-ascii?Q?d7C7gn3m85vfriCBBni/oz6lv8FGePrxjh4AYqkgIk1dCJV90Jt+nQmB8LHX?=
 =?us-ascii?Q?P7S89yiv/OcLf3AcRQm5fPs8zzf59+xcyEbGVtANNvn8voa284OkxJ9bVlqq?=
 =?us-ascii?Q?goBtU9LzJO4DBg49EmTtiRkGmgdIkhCE01pJaCOXlu3dAOay2FvDDSJfpCBE?=
 =?us-ascii?Q?/LvZmoBV7e8Pbe/mCZinBsKG7Dbc4MlrT0ZiAV+thVaZQLVyw/zz9NTJBwqb?=
 =?us-ascii?Q?4PHau2Vve3dNnseLdF9AZMmAVDPVFF1EmFy3GLq9fupXQOUf/mgqcLaft5Tu?=
 =?us-ascii?Q?bE6Hv7NMZ57A5JAJ4QcPJBEijdkKw7IVswQOzNkqd+dGALAkl3jMFNr8p4wO?=
 =?us-ascii?Q?HYhtnCbR0NEDThfVXo2YwzpClHNTK5QZLz9QXUHmg1hRjn7HIu8QfRYCKbvu?=
 =?us-ascii?Q?CwA8ig1I8j5ts5X9vQnYQvrQiBdqqNVgYjcN84eg/9tosLacLwd8ANrOCHE3?=
 =?us-ascii?Q?r6w1ZDnvb2UhwTX9AedtYu1pXzw1HbHxb9QnWVUPoD4bXLlzyWIvrav8mgZN?=
 =?us-ascii?Q?l5ZiSAwlUJstqgLZL2RWiLhTpQmD5ko42nZ98lPadtL0CV6TCbGW7WEPTFgk?=
 =?us-ascii?Q?Qc3hY2r1phoZvuPc4CBaI05skWzMsYc4mzYpmGVqYCkaRE+kEKdYE8Q/0/x9?=
 =?us-ascii?Q?Ep7zanW3x+8A3B49DaY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:42:11.5986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f93c01-9e73-4513-a920-08de3d82d846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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

This series adds support for PSP 15.0.0. The first
patch adds register headers which are large for the
mailing list.

Alex Deucher (1):
  drm/amdgpu: add MP 15.0.0 headers

Pratik Vishwakarma (2):
  drm/amdgpu: Enable support for PSP 15_0_0
  drm/amdgpu: Skip SMU init for backdoor loading

 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 202 ++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  30 +
 .../include/asic_reg/mp/mp_15_0_0_offset.h    | 423 ++++++++++++
 .../include/asic_reg/mp/mp_15_0_0_sh_mask.h   | 626 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   5 +-
 9 files changed, 1307 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_15_0_0_sh_mask.h

-- 
2.52.0

