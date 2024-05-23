Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3FDC25B79
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 06:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94F310E1FC;
	Thu, 23 May 2024 06:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y/jHebCN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08DC410E1FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 06:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6ClltzdlfUODcWvW8tUZKOH0T6ln+VF73nhu5au8B5WU/zOmD8BeJiDRfDzfXt7W/vtH4YpNaWBFfFmRHyiAdJWNr7fuRrtNeAEfaUX1WhapvHGbC7q72ApDSt4wV8mttoSUjTaJiax8KtxOthgsdHHo6yZ6lKIJF7BsUCuUJj8qKbYJgnMNxei0mMY1nvoCsi+SntKbX2pmpIuf1EDFIqwZN5q8k6Wh+5Z429P1ioRtI8t052u/i6mTn0wKPljq5ntcHMsjDNxWKbWvkCD+LCsLyHVz6ywISYH0w3TREcKW6MGdhfxS5E6qLMwu4Zytoyuk1c7pzp8zJzcGSN6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ+Km6hsNY5ncC1nWyMCO8DXym3Oniu8ODNQkXPU6Jk=;
 b=gWz1E0WMyZYRKQZS8seTBYyeG8UEkhjN1WGJIzHQ9V2r7cOumZUMe/8wqePapvFOw5ldET3cQy5HrZMvemkPkNw/xcipX696qz7lMXmNre9ROS3O2tWdc+h9lNY1kzz6ppwQWJvI3VeN4+YJ3xcJRFri9u0TpEr4BBQaxulipUrmREbXfT6Dom/+RBA+c6eVbbH2/O/VgvbbzS+PQjVVJCNIO9p4GBi74ElXV+rngCQyKE2tLrktLGm/R1iqAN815sQ/sADcmxH6+dIqxmprrfr2SprKOgSJmyYrhI1rRumUO1j12BQ8oBU/da44D9ljPR557kOf0cXcBsKJfHvQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ+Km6hsNY5ncC1nWyMCO8DXym3Oniu8ODNQkXPU6Jk=;
 b=y/jHebCNaIW0WZ6Nw8b+h1A/RhCTNBph7WdFQoju8Y0pQlidgtEfKeT/k4XUNTbdd5QP+IuQZGQDa9sULTlfGMvZZUwhsAvhda1PsSOZQkjoFq4z38CNTTTQW5ft6Ad36JO1WVVxiFm7+hEa5jmNTpTWeM+JF7TjCtrIwC3WFVI=
Received: from BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::10)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 06:13:34 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::42) by BL1P223CA0005.outlook.office365.com
 (2603:10b6:208:2c4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Thu, 23 May 2024 06:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 06:13:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 01:13:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 01:13:26 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix dereference null return value for the
 function amdgpu_vm_pt_parent
Date: Thu, 23 May 2024 14:13:25 +0800
Message-ID: <20240523061325.1418911-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 71419a31-4984-4c2b-935f-08dc7aef79ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iwFOT7YZ2uXieev5XgSCTQo8cLl6LaCYZogRRdF9cPNp2Q0RHtxK5UK0+lYE?=
 =?us-ascii?Q?c62c29KReFBmYJM9s2IRucmbH9O2RERQ3B+FeiwvZdnZg1XlD9USlCjYBPZS?=
 =?us-ascii?Q?LJA6WXbLpDjR1L1yhzJUyydu/7/0+KcfIuW+o/NWKCAGELZUI2m7YLMXZoSX?=
 =?us-ascii?Q?/t9AXnk3hLA5KL5RFt9DP9dhq4jv6czkbIfg9DjiFrp0FhvsaA0VdkT0/CmL?=
 =?us-ascii?Q?HaOXpZcU7+HZtvP8l/Lg3C1e8Rz6b9qcLCgmNDcI1QSGk12LFYDCwi/3jYFh?=
 =?us-ascii?Q?UNE1SMisVgUHHtkyGSoYShVjRkAr7ml1tpu/NaHgL7tnC65xUQ+YJHJ9RJDn?=
 =?us-ascii?Q?r4j4pT2q92qoOwr7JPCphAR85bMapstwkrmg1HYoIzgBKPv9sQN+lYq0tv1J?=
 =?us-ascii?Q?1EXYH7oTITCCZqsmw1fJnIUlTBi9oKBthjtHq4PFli9lGZfxsUaPxmME5wiL?=
 =?us-ascii?Q?i+m5nmkos3sr+RKMsIaj2lnS4ipYOYudj4jIYqL05v0s/ZD9joXusYxASgwA?=
 =?us-ascii?Q?IpvrjGnljK5FRZUvgZ4PBH6Dz5qL0zT5S6a8sqQOENDXS9vxDkXk2fHYm5qN?=
 =?us-ascii?Q?C7g1XYmWgU9I1UyXYIFDMzFdnyD5ZjxfyE4ZjJZ6poZ6zYyoHgQ9UKPTXm+Y?=
 =?us-ascii?Q?js8HfLDyIw83KNIJm8jNH667c5ucrMYmdFyL1J1m53sG15hOcFejrWUPzpeS?=
 =?us-ascii?Q?AH8XuCWHrGmgxKg3aX8wFG1Sh8mTEU8adDC3tQUxNg+AKZJmQyEYu0bBz7VL?=
 =?us-ascii?Q?lSiNR+k8eNEkDTNAkdUyrLpjjn4pcG3mi+6ciZTAtbhVINbFXSgcAA4j42UO?=
 =?us-ascii?Q?BNMwQkbQMZ65t8MSGWOnTz3InDqQ+mDLJ1PwW1SDbp41ISVDD4x7CVY0QFwt?=
 =?us-ascii?Q?qyrCGGOUZXFUJc1+GWh2mJN6+rMZ+fXf/V2ULDMuwBc1c+VUZUCXmmRCGRJu?=
 =?us-ascii?Q?Z1rrmrwN2mw0Ovm2z7mY19kR3PWdmyYV7AOrbFhZ/2uzBfg967Tr7ZUUWS/+?=
 =?us-ascii?Q?yWK1hT3o7gm8mcebmq2OJUcTSquyXbUE6T7Jrd2GjrtpJpNosr20DzRvy3ZS?=
 =?us-ascii?Q?Jpg5tYkegfCJ4bl9Uue7niBK/haQNXtUl6t5ZDSUPCsnHNf5LT0YjqJFvsBy?=
 =?us-ascii?Q?iQUgbJU9C6IjZgKAUFcXeZr5wBxuHgPv4WTIRdVyVC76ggpEL1oVZOXxBBOJ?=
 =?us-ascii?Q?i3/DK/maK4usnLdqlJd0Z70FwM+4jgnkrE46YtHmvQMyGdS+BMBv6RutgT5f?=
 =?us-ascii?Q?tgxiAj5XxliNvqReCpjoe2nNKgoYx9UyDkKiNcvhStjEc87WypPEDpW40W2n?=
 =?us-ascii?Q?aAycFELb2Y85+jZ8Snc4ij8ta3pDt1pQHEhVVAootNWL756LEZAYmvrLLrq/?=
 =?us-ascii?Q?AJ7FBxQc33XYbzgXBSevaot/DPJ+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 06:13:34.0684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71419a31-4984-4c2b-935f-08dc7aef79ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
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

The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
To make the code more robust, check the pointer parent.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 0763382d305a..bad8d2c31202 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -706,11 +706,15 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry)
 {
 	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
-	struct amdgpu_bo *bo = parent->bo, *pbo;
+	struct amdgpu_bo *bo, *pbo;
 	struct amdgpu_vm *vm = params->vm;
 	uint64_t pde, pt, flags;
 	unsigned int level;
 
+	if (!parent)
+		return -EINVAL;
+	bo = parent->bo;
+
 	for (level = 0, pbo = bo->parent; pbo; ++level)
 		pbo = pbo->parent;
 
-- 
2.25.1

