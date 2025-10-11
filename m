Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB14CCD184
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 07:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC64610E2E3;
	Sat, 11 Oct 2025 07:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xTXZnDmd";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCFA10E2E3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 07:50:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgOmOC2ItD0YEwMgQQ1UVJmA6J5LoRDQu2mghOfmPas41Sbgr6qjRPscouXM/sQ4kAtnWqoAmUhcsDoqqEUAZRzB/95JChGDhbC254UdPYuhT6O8xbcjbv2IuLkLYgkMYn2T6aydcYsGfuo0S6ll8PAHoH85qRTrgzupXEtqihFd2OOHI35Z4F4FdhV7hsiLazg9bOBtlR85zA/hprIAQKd/83VPPZihcMcVU17LGH7ZQpolqLnPoqWJ76WiAL/SXBLtqRfcUHPjWFVfp4QtyR7ofAMSou0BwUUsgcLzMoztrLHGItJq2VEWoAZq4yDWDyojxiu1IjEx5mxuABeL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meIXEmbCBvZt4nYk173NUPDbMdDzLDpf0Cld9KeBhfQ=;
 b=jAyRKua4zU6RTPKMhhW8IF80se28BzL30cZ3zUoBFUzmogtzK1KNoMLTKrhrloRKH28BR0Y0lk8mHxrb0GL71sHyIjob4L55qxpR6IFevmpBqroMwK8QxC1TZM5H1QtlKR8uJpIVOoFLWdr3aQaLuosUTSy9S53mSzu8mh/+gECqtvIfyIhv3PI9esCbw2BDfu3ObLhq2VAi4yPllVYB8d8SOhuUW6TSj9a//rzO8manTdCO1Ttdg0eyLDhhEXzwRYlwD1DAHbhgBmyaS1/4Kxvql+Ro0/oM7BO+KxlHeBDTD5FIi4GQijTUR0BGa8c+CT/DRHPzBeXZYvhOVf/+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meIXEmbCBvZt4nYk173NUPDbMdDzLDpf0Cld9KeBhfQ=;
 b=xTXZnDmdogzMQhJC11LEBVUr6Ipw1zf3A0h5XqEYf1JnMTKeYlLAbRq0OpKv4gRb/eNF5uh0ZOZjKJ1YWLoT7m4jx1OsBbdnIFw+zKsdR3pf3xAr8BDFvJH3I7RMMXlk46YlPxNUYA4/zos+Cy3I7cDtbXWc1YQ8+j7rGT+pVMQ=
Received: from CH2PR07CA0039.namprd07.prod.outlook.com (2603:10b6:610:5b::13)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 07:50:13 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::94) by CH2PR07CA0039.outlook.office365.com
 (2603:10b6:610:5b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Sat,
 11 Oct 2025 07:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 07:50:13 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Oct
 2025 00:50:04 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: Avoid loading bad pages into legacy ras
Date: Sat, 11 Oct 2025 15:48:08 +0800
Message-ID: <20251011074811.533871-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011074811.533871-1-YiPeng.Chai@amd.com>
References: <20251011074811.533871-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: e0640b09-0aff-4e16-abdf-08de089acf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kpReIg6f5VMwtMuRxJQuot47x3MTptaiITAsZab/eggK2OauTpYkuJAJilfv?=
 =?us-ascii?Q?h6NE5k6ITG9LW6+odqZq73Y4qsMD11M6r7Pk/ZGo4XUwLYMDJLt8w62tn7ks?=
 =?us-ascii?Q?YfZGD1dDzEl7aidZPcA31l3aP9hgz7do3m5mj0nFwU1WDIX67P6AagKgieOW?=
 =?us-ascii?Q?Ea5lG2ICcIkcIHVW9Lh0RvOc+HEiDSzTO9ZTD6ufs8ag0mxCRVBzygolgcLk?=
 =?us-ascii?Q?9VCQSOa36zMi9B0OE5KrXH9CTlNBy69/gCsz+rGRCf6prfD7c9R/Uv2QxW1p?=
 =?us-ascii?Q?uwjkLzz5YpvcA2t7VR5aQfQRBxoR3vCS7rub95J5LL73kY30W2ixNcmx/auK?=
 =?us-ascii?Q?buVAnYlujkZfYNPep/sIXOnhBpj7V2J1Z7jQ8rvYsbxDIdM1lcXZbcoNvCEV?=
 =?us-ascii?Q?6q3H87ZgSctKMZO3zEFGI/3MdrxcYOIS2TJZsla0FFb8qnHDvsch4SnQJ116?=
 =?us-ascii?Q?Bgo4ORss/nJ6gYeu3h2q5he+R6wHtQuZJr4Y92cGwWR2dqnRQxKGFCqoX9Dv?=
 =?us-ascii?Q?wK4FYEqt9G0WvwgriS529MwLhiLWwfczMSpNC0aRiu9/ZZ5rtQfzLoWbUlXH?=
 =?us-ascii?Q?/LHtukGmyxmpeTW7PEr1sO0RrDKK7J0/m6WiK1LNiBokllbGudC/sSWHe7Gl?=
 =?us-ascii?Q?jCt+ylvu+hC3DJK9MDH1Wv/aPJHHp833mBUUZJC02irWAQAhLkIhoAdouq+A?=
 =?us-ascii?Q?G4AvvZ1HozrvetWi8tUl7TFBpnW6S4yyJ1btj93aSP/to98v85+zyFFSsqHg?=
 =?us-ascii?Q?Bt0LY7wFC3qDOJwTiNNSkZe/1OHoBfkYFFqdYlXcBHXJw0CH/qMO+mVTvFk5?=
 =?us-ascii?Q?COS5w7qZ4rY4oXjJdXTPFI5RRVx2f3xXyRmFaZVwIodvwKinJUK596GeB+V5?=
 =?us-ascii?Q?YqYP3qFZtQRde+ofmDx4HmfpDLRx/z9P7S5g5MRzO840Q9BG2Lp7OOVryZui?=
 =?us-ascii?Q?El/GKgyVynmUplrqlVrK0YUHLSWNnz8gT7Qq9PRkNAZBKJQEIBKTHpCU9V+q?=
 =?us-ascii?Q?H2Gz3nc5D6xJCwmdvWzo7voYmHALcJawHVe2OO0Uzhc7EaRwdL++Bb9vSwqv?=
 =?us-ascii?Q?MkebrXwWCKZfJNAK8s6ZB8UfjFaQrjorbrUzxphJyLjsYvwYFm9fy5UcTyEq?=
 =?us-ascii?Q?4xDxsOvkJjmc9o6oKlggQmqY0ip4Kd/XY8IuhWXAuVhApk0YPJo+50jVa3GD?=
 =?us-ascii?Q?qfcYEQqbRirFdA6YZDetSduwhWXqKydQPZo6lWk2CA4fC5HW4+YT4oxHOqe8?=
 =?us-ascii?Q?6HTRljJPlZtqfOS3NowMEb/8AiQ8NIcT6Fo1qkN1EtU4XDe8KxzcLG6Yzj9N?=
 =?us-ascii?Q?0nn9PTHG6A69E7NXAtc45it7gp5epYbpX+YTyDaN36j8nk+rXNBzkxEZqR7G?=
 =?us-ascii?Q?I0VL4uEBopGG4qorJerUA3sXC3ET0WQyBui9qCaO7OqtY76i57OX5zaXDKB3?=
 =?us-ascii?Q?GevFxdMxRw5FxM/9XNWY5nBKg0iu9dJ6Z4Lc6HVfQESpMy+TO0mrWKwAZFrv?=
 =?us-ascii?Q?cW2dHG4iw83JIrLvykeZBXFrj2EEJJ+iPovP6WApVGTjf1PtYCIVFHu6x2k0?=
 =?us-ascii?Q?zYXEvbZEDS9Wvb6qcMM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 07:50:13.3986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0640b09-0aff-4e16-abdf-08de089acf9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
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

When ras module is enabled, the bad pages will
be loaded by ras module.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 29e1f98e3994..c0e6caa75319 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3606,6 +3606,9 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	if (!con || amdgpu_sriov_vf(adev))
 		return 0;
 
+	if (amdgpu_uniras_enabled(adev))
+		return 0;
+
 	control = &con->eeprom_control;
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
-- 
2.34.1

