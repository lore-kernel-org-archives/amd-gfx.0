Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB7AC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 15:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E0589A88;
	Mon, 24 Feb 2025 15:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1fuUTJA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D7C89A88
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 15:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeH3G+gB6URhwibuPIDN5p8ghPLmiZWLGLHUZE/imRC5cOuNAIk5iJHPMSP5gLKgsgaNboPgUzSd7D5xkkZNnXIiUSRzfCkVf/jNQsfy5RFouzHOGO7qEqNyO/ZPePc9QYnX2qBKWKgspBHqq9jfHNcBqNU8uOj5TuQnqyH2mwY1rObzn7k0gSf24WWrizfPonFsIlk9vLSmzaod+EXC7o3C4zpCGRoIpc1zu5btk33IY2KUYTHC1f5hqhE262fWdSaX8FzKBQ8D/CKDD9hh9V/sedFz6ldTXY+AVAjxCZnNELe6zQcs2PEHG5fyUhzImVouoQeySayE7kPAyVqwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww4kWcCkMFcqnxtcTXYAGA/KZZO2s047fCYh0RONkXM=;
 b=Ao+X6c+h+MCAwX6aK4w/i9JORTXy/LCTe2PQ+4U2TDtcoPkfnEVrkiLxR4kUhx64FTtc4IFBaWAeq1QyKKcCLr5C5tcZCvJ88FVOif87cVxp2CsKJ3yeJQWtyrpUDMtmvyAjBvszDY1r+tYg+AiAlVnZnURXDowQpoa1fU576njNeZnTmurZ3btPU7qD7GgJH2N/FsIxfqga1rdmw+h9KjWCnpnlS1dJZiOZ6VyB0I1igMaX7aJ87zBT7vG/esTTBT56lLphwmHwLamL61CZyamGCJYGqdWta8D8DYDzGs2ia7a+XdmIYD59dSsES2aOKknMiNnNvWYVuT79th0uZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww4kWcCkMFcqnxtcTXYAGA/KZZO2s047fCYh0RONkXM=;
 b=v1fuUTJAflPZB0ra59IiPLff3UUTMEgEbk/UQk7IvK0rLYPa+hPB7ER2yd7IxElriZHv+5Pn6G3AaCmmBEuCO0zwDHs7ucwQhpgMbaMbCHOtrptcRen26W49NigvkG1Jfdunms+/2pjXqIhwZJfJ+pr1kFe5ZrZgg6f9jnNvXmk=
Received: from MW4PR04CA0262.namprd04.prod.outlook.com (2603:10b6:303:88::27)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:02:18 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::ef) by MW4PR04CA0262.outlook.office365.com
 (2603:10b6:303:88::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 15:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 15:02:16 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 09:02:13 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, <andy.dong@amd.com>, "Xiang
 Liu" <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Set CPER enabled flag after ring initiailized
Date: Mon, 24 Feb 2025 23:01:59 +0800
Message-ID: <20250224150159.28149-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffad7dc-f290-4f38-91e2-08dd54e43a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gfhRXmhs4RnE6BCs2Z9smJuWF9/5LIpLud7Fhq9Ru2g8EYdBXu+7JzO9Wj3b?=
 =?us-ascii?Q?pJz1vtMKUoGLCngBzzeE8qnzdjiX4KHKGYAk3QDViWQ92diftX8h96p41dj4?=
 =?us-ascii?Q?z/zYCbr9bscSjd9hGaDw7By8RuooI5iwJtmrmhKdXpzTovja9a7IttGxJCG1?=
 =?us-ascii?Q?uHPyZZk8VE9j99EzmQu98dmIct29Cr0BPSG0qRrAwODkTZC6cswL16Ug+2VE?=
 =?us-ascii?Q?mEPnT1s4zWEYRAo4+eEK71mulQ5pTKtnmK+uDHNGYa4wGVh6H02P6T/P/iuH?=
 =?us-ascii?Q?cfv9lSvmSm/YNAxlFi46OndVcy7qDyoZO/3cNJVH8pJUa4d2MZvnrG/HGcwj?=
 =?us-ascii?Q?IQwKp49Z5K8S/PZvHMukQTQPWxmfevuaeR56EHOSaaxvtB9U7wczOCbQW1EC?=
 =?us-ascii?Q?PtBKNkKbVMfARruJYtGMzSgz8kz11X3u7GsGXleCSWYsc4Z3LJ0+d/do55N1?=
 =?us-ascii?Q?tLHcbIXA+EE9CYtrJCnRak0T87R+cw9Mdwrr7tU0uup+hS+H6W+Fpc+NF1OD?=
 =?us-ascii?Q?E5PnVPreuuKklwPSfsI47jopuzBWY5k4pQaYMu10Emr1K5d4hNebJx85rtO7?=
 =?us-ascii?Q?T/rjj8gHnXcRfGQs/t8Yr+JHDtDgGeZ6cnU1PbLpDvssZml4rpxsR+zunEcD?=
 =?us-ascii?Q?I4wgJbwg29LqqSMluUs2vy43KcJnCcymCp+g9neowTcGOQgqlz716G//fWIR?=
 =?us-ascii?Q?6d3nuFIsbjQdmjfXwgUkAQNPNtMj31dEv9oD+S7Q5FKhi9U3XtLxfywyNb6S?=
 =?us-ascii?Q?Tznbttqixb10QjBTmYfCInISIc/7TTlV/GcT1ffnXqiJeE/JUz7HptmQqQG7?=
 =?us-ascii?Q?MKYFGPfiIqqNVr81K7G9mInK5jhXGVZ/dt9YLjztoAhLiu7A2KpUaJuUKWmL?=
 =?us-ascii?Q?YyM/O7WtP7j48E+N6KgJUOa5xIXanAih6Ib5uDSpUbFEQgXwJG0YVHWQ77hc?=
 =?us-ascii?Q?WAvWyPipX2TIW47WwabJH1palVpZuzV6SawzNvKNBYqleM53dd5QpkmVD+AI?=
 =?us-ascii?Q?EYNqNfKVFmkjFrN62/CniD0q/pB8EFOSaUts6W0ABKXKXQf1qfFAhx/h4SXQ?=
 =?us-ascii?Q?covjIgR6MNuWDaXwkMSc2Y1Z3bSqpQJMseNsSUiCviGSPgIXq6EJjtdgqF1a?=
 =?us-ascii?Q?T7juU5qew6+0mO3gPt3BndHZe+dCQpaWHmPcjG/C2c5mHIUpqDwKJGuta6TW?=
 =?us-ascii?Q?sJcX7ITeaaK20137nFM1/mzlKCRd+FtyNQ+ffDIcWbbcZbpEkyQgTMiG7xe4?=
 =?us-ascii?Q?T9unrIMHy34EbElyCPVrtPTBqc+0V9RV/a7YVnPhZD0/BFOLnDaMkk6usDwP?=
 =?us-ascii?Q?zuym1D0+FpQgLJvXyNGKppYggDBZPBUJ2506x5KVIS/84xhkNYHEwqA54JU0?=
 =?us-ascii?Q?dTC7LDn0Ajbw+phZ96WJVfqlQ00bqEzujR+84q1XeUudAlgRbea90jrUIOz7?=
 =?us-ascii?Q?oM3B+iwIiOc0l/Mll7GUBS7aHL8C8pYHso0K/xvoUzj5FUYK75t40STCD74/?=
 =?us-ascii?Q?ZCGRCvcx1U4ivfI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:02:16.7572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffad7dc-f290-4f38-91e2-08dd54e43a9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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

Setting cper.enabled to be true only after cper ring is successfully
created.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index d57e6ba66c44..a39e7efe50b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -535,15 +535,23 @@ static int amdgpu_cper_ring_init(struct amdgpu_device *adev)
 
 int amdgpu_cper_init(struct amdgpu_device *adev)
 {
+	int r;
+
 	if (!amdgpu_aca_is_enabled(adev))
 		return 0;
 
+	r = amdgpu_cper_ring_init(adev);
+	if (r) {
+		dev_err(adev->dev, "fail to initiailize cper ring, r = %d\n", r);
+		return r;
+	}
+
 	mutex_init(&adev->cper.cper_lock);
 
 	adev->cper.enabled = true;
 	adev->cper.max_count = CPER_MAX_ALLOWED_COUNT;
 
-	return amdgpu_cper_ring_init(adev);
+	return 0;
 }
 
 int amdgpu_cper_fini(struct amdgpu_device *adev)
-- 
2.34.1

