Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0C8C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586C810F23E;
	Mon,  6 May 2024 18:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EeokMSv2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8842C10F23B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE1w+E4XHCVqM6v0Ptp41i6IvqFICOs/nbLzL4BhDmmEwE6FJuI5sLkkEBxbzNsY964LAemXHJtM4dk158vmdQkFM/Lii2q3TpGn0zrXjE5eX044G4dvBPMXiKjVfjZi+xAUNSoKqxxhg3fO/pEXBqF3HcwDexmJIMJ9A8+oSnf6MmBN4hWQ4yNDvgn/vKAUgdUDT8THVsRgoBEXwLGDovHo7gPRC1yZ/4FOgQIG58c3M96wa94J67cjrAL9XvsFlIQyjbuGuvwe6yPz4FXLi96OVYJ9p4D5XBBkMNcT/iJkDd+IBgJvzszrQf5yYAT+hZKBkunFcymgRl/IGo7S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgeHCgC0TMec8neBizfBLWChqgUO2IWxC8gGJHK6/yY=;
 b=ZGolps4SPKCQl41kXLcPIOLwvFULTCHDzH7tYk0it2AC9GFK99PSwG6+0qJvgVjXa64ZCby4TcsaHvotQeq3enfVoqKW0jb1z3c1FT7blZTFVQMMUZUZt7DsVcjaFc2tCt8UHXPlTuDcMstpzttqRipfQPMrrW2YYlN2seVQCih/ccpiJQSr3dYEFiGAYaDjj7ifki6ku3I63vPaYFn7AhHzlm1CHq5A7Zyan7nxtYz2ZbkDq3A/ue3JDTwZl8l+t0QFReuG5YwPEDaBhref0wsr7aA5A6StuSsMQLOGwOMY5wW785QgxnRoCgfylvCigsYuy9JQKhFl3UsGVQgzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgeHCgC0TMec8neBizfBLWChqgUO2IWxC8gGJHK6/yY=;
 b=EeokMSv2rtnQKZDa2mELR7gMc3jV/mIWUCmFqRaI/TjakcV8RWn9u1im1ITVoSogVUi3vNyPqBRvsBAv1A6GXrEmL49uKMH0bGRUEN6t5MiAo5QGNY01e7T7N3oL7SI4RGzBZhBUVT6HT00Mby9eJsqPqoo7os6ZRhpzqvpF0j4=
Received: from PH0PR07CA0073.namprd07.prod.outlook.com (2603:10b6:510:f::18)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:45:55 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::39) by PH0PR07CA0073.outlook.office365.com
 (2603:10b6:510:f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:45:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 01/14] drm/amdgpu: add nbio set_reg_remap helper
Date: Mon, 6 May 2024 14:45:26 -0400
Message-ID: <20240506184539.1669157-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 5454bb68-52a7-4563-3584-08dc6dfcc2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P/qfSdnXMeqsMm3s9bv9Fx4Rtks8xtIZxBuBKFFQCgx2qV8tRTF1u1au/sEL?=
 =?us-ascii?Q?oGNjNetY2JQWbKt80jRE7fnxo/B2FuBcKCVOLOZqk7BuiQUXBVURxTI7NNg3?=
 =?us-ascii?Q?CzHpvh3gRVTPSqM4LYnsBHvuIpnfHGDnC7ZRtrryb4vy6wluslidbrmHL9BP?=
 =?us-ascii?Q?6K2yw8ubxNYC27zKjU2ZgU5Dh6uKfyuj06tP8/5oJvu0D4ZnWZH3MGgviY7Y?=
 =?us-ascii?Q?uPbs90GCHud3DnkZbRT0xBvXncHLZ6+DNkAg/WvmqX+rRhR/JzFUXBWbu0jo?=
 =?us-ascii?Q?mVzB+OHQ7WmbyIkgMhHrZ9e3+kGbaezyeQmrwj7BqQKN+B7M9CvOXEacjl7N?=
 =?us-ascii?Q?7Zo9QqNsjkb8HSULBgW5XBZmG3xH2iLJkFgCxSmYsM0QRbTGGL9NyVY5uhWW?=
 =?us-ascii?Q?WbF1OzljMViRSOj7jPBLjp2abLQYSAyj1bsA6//D/uKQZGFUYSJ7eEhgfQ1k?=
 =?us-ascii?Q?SC5k0aHjP/KKqlZ1cMPEUHgGKDhwiQsuYGX08744krFXRDV/O1ke0Ket68Sx?=
 =?us-ascii?Q?KcVwzOCqSUA2rgkq19BsMscLcPnxbzqNXjDWfHdirJ22H6Vlfgt5PW6ttPbL?=
 =?us-ascii?Q?VKvWWdsxWTSPdLZ5qeEdSkjGgYcqIeACk41IsbJ9lii56mSuLkO3sfyaJym6?=
 =?us-ascii?Q?4AiqO6MTzR6lFLA9cdqVO/fqSnpqZ6MPX7VXHBTyLodSPHlPHkhcltnptnR3?=
 =?us-ascii?Q?XHwUJP//I6ouw/nQTkTMtJJmaEJtRmDUF5sQj/zOfb1xkB5FOG416Y6sd/Bz?=
 =?us-ascii?Q?ZRTkM4wQU/rb1StKcqpStY/QvZrokyCyXXtxjXyOAyo4bA/2AxbM2eZjWu8l?=
 =?us-ascii?Q?INOH3fNVJqXpIDIZ8xLisB0DLKw/ZR/foP76Md1REPHYrdF5JaHJTjna1ZrA?=
 =?us-ascii?Q?h+hozuIiiizaMhfPS4HENbGmWQNWKpvvk1VmTqzlrlF9g+IZuZyirvdCNT3u?=
 =?us-ascii?Q?1L2yG+SsMmV26b+dA+A3KzIgCPGT5ocKQEaw+vsX8ElIscCPjEH4s4EJm8i8?=
 =?us-ascii?Q?8XvztT1ETVhljxNlL6Ip481BX9LZBAJSqz8HXeD590Mad8K80EAknhMp5yVy?=
 =?us-ascii?Q?0QJWd+9HM4TYrNAbWsb1QWVRE0b7bS5qx845oCEfDgCO9dKqOayIDAs4eLKK?=
 =?us-ascii?Q?YDxwhvhsUwe2wJ9QBhFVYBSjybeTDYP3u01d1K3+/OIP+DUP86Nbq/DNq/Vm?=
 =?us-ascii?Q?jfNS2w9RzhMNxcL5exSM3YJgwcGqZC8hvyQkuKoX1rZvbX/bH7SsMtbVBViY?=
 =?us-ascii?Q?EcctYZKCpUGVO71ADLG7yZZYGq20qO1DTKe7if1gITowj4UaIlB7m5lfel6h?=
 =?us-ascii?Q?uT0WTvy8ysZyaILWha5JVwUO2B6y9MUxyUU2N2X04atqNRawJ8euv34qv4Sf?=
 =?us-ascii?Q?QyM7RzNYZR1X7BTtm06WWvtykjIY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:45:54.5498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5454bb68-52a7-4563-3584-08dc6dfcc2c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559
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

Will be used to consolidate reg remap settings and fix HDP
flushes on systems with non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 7b8c03be1d9e7..f61d117b0cafe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -102,6 +102,7 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
 					 u32 *supp_modes);
 	u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
+	void (*set_reg_remap)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_nbio {
-- 
2.44.0

