Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E301BC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 13:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C67810E898;
	Wed,  9 Apr 2025 13:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nMiJpaeF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8542310E898
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkNt7sHFMdln/I7IcCYQ4r70iGGibjGM3xOcQqAiFt4s6wDuSjPtdrmj/snFk1J6ZXJfEu6a1/Cr5+HDDClBmUn9Evcg0fN8Ti+a0xFZXGKsw20fEdlYqQ9L2/oGRN3mKMRCNiO8AMSGN5a1a4f3DWQr+WvgGQIlRzxLhm7p3lvKggM9eFGY6GR3TmYCr5iNdPg+aKbq+CyFHWHeSrrZujACGYhe5s9aHnNSmiyzXu+VP3JP/XuOrX2utedAvjngF0CQ4Mdl7JSWC04fF2RXG9HAC05+HLagf6gLkQt2v7qY0NmdaiyhzgXLK1vgMiXF5x1r62r2V6bxKrTn8KfhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htboIVmo6zELqwTAjEElqa/Elyn896E+EcAY4NCdrBs=;
 b=e1o5xUcHuOt9YFORmvT351Ugmt0BQtlFc56WZ3YRcjo214pkaa2ECobdwOINKkAMcOxqURKNrlaUUZwGHzmIB/QxcFHWXF0egmpMMxFAigtCx/BE5uN8EMohI7TrtP80pT7E7dsmCG6PC906/a8NgSczbfW3XNLoB6vpacwJosl9QTx3em6kwL76lM4zMvRnwvDHA9hgJClHF23O5uFTCWvH4gbvmjI3YftcVisoyuPBo9N3hLr+KBYRcmWRKdRE5lBB7ij+0XpIF3G6oZGBIpAgbfgn+RCrBDj9uGEEuIS2rX5aNnDrjvrGBxItrABKHKqvJPSdNej2gw0f993ZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htboIVmo6zELqwTAjEElqa/Elyn896E+EcAY4NCdrBs=;
 b=nMiJpaeFyA7Iuyo3E9EQKtB9otYFMbGr5PsTKsiH8c+tDjASNhrEqM1mvJ1M/STWuL+cF65uE5g+tlsog9GtIhAFX1kJhaxnD5VgV76HoSYpbjgoZYVJxf9Q4pIGlZNXHSGZx/r8mVSZq6sdKW+6zNB679bq2Fri6BloDevGUxI=
Received: from PH8P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::30)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.37; Wed, 9 Apr
 2025 13:19:36 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:2d8:cafe::a8) by PH8P221CA0024.outlook.office365.com
 (2603:10b6:510:2d8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Wed,
 9 Apr 2025 13:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Wed, 9 Apr 2025 13:19:36 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 08:19:34 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <dan.carpenter@linaro.org>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Replace tmp_adev with hive in
 amdgpu_pci_slot_reset
Date: Wed, 9 Apr 2025 21:18:17 +0800
Message-ID: <20250409131817.25990-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: c6db0ad4-cd4f-4c5c-a8d9-08dd77692cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aMuC/v44UIjfolfq8xFbJNs/M1KM7FHJvEUXqdNLrhyXkNISI4TlBL8Tm0c6?=
 =?us-ascii?Q?hv5NYwPzYs/sPRd0lsiPaD9GpAiD6Yjc8Phki9sq4c+nb+/E8lEtD8HMYQ8S?=
 =?us-ascii?Q?DZoFF9BzOOjg5Y5A5YBw78JjBX3AFvuP+k0k9iK6V0sCJ9UpH1JoSxzF8FuK?=
 =?us-ascii?Q?3Yj89a64agPvjLzkH+mvOY1DE7lCqRZ/+5IfDgzEhD5ziQiraAxkiF/bM5WD?=
 =?us-ascii?Q?jfWzGRNEoOLqK3WYIJdn8AatlNOgZ4eQ1zj2BwfBKuwontqqtD3NiAs5jvQY?=
 =?us-ascii?Q?yyrPH3BQlqQl9vE9XyAsAFoTkj1SpPEsDHpW7Wq2AavGRI7IUU7+DLgbsdgA?=
 =?us-ascii?Q?9dg3bLr6Jmz1HHJFBo6+y273unMhvGp4LKtbW5AZsE+ZhNHXrGT2aGQb2wMc?=
 =?us-ascii?Q?8qyECXYspL8v9mDDcGqNZYuvgh9makWt1kXf5tx6/4MsyUkWdwouNm9kqAAR?=
 =?us-ascii?Q?IIVNf3c7EIhWJIrSRDoM+ySuik0gb5LZkm5tB2kMqPvavqtSMAKrjFbyD1lV?=
 =?us-ascii?Q?xAIgwm8mkDZDKiEAJc5TdNgng56YDj6vx4BB/RMtnI1uX9BAKoZNXR6YDFgw?=
 =?us-ascii?Q?7Ui+3dum0HTJooPYCjh6d0ej+p3wYVl1V8pZtB04oknz9u46KlCHFRs696/7?=
 =?us-ascii?Q?zvlOsOacQhFiRz4HXgOi7V4UnDOteM3Jjf3PI7JUbbmaXU9dQTgZmzPcMbHl?=
 =?us-ascii?Q?D1esPvxoFACuRObLJGp3eXPv50ReH7O+4ZUoE5gkXHBHjeFyOPsH/SQDK9Sj?=
 =?us-ascii?Q?rtS0NnhB6k+I9hHH89L4aO534FN6MukOGj6gG3cHiUNND9vRMnFc1pUFdyFl?=
 =?us-ascii?Q?dpQHxPjbbrXa6x1qxDBBFO9BYoPiur++3XOF+M2Jx54wzAPaIRv5Sa/tzCG1?=
 =?us-ascii?Q?Wumzr7LZmWbnr4CUx5b4PVROf6q14Qtca85fj8R4RRYc4OQyxKRINmLXEae+?=
 =?us-ascii?Q?Na9DRMQ00yQHwSEvKic55WmP8nVr1PWKT0CyWHKvtO+O58/bA5YZ4sU4Hqwv?=
 =?us-ascii?Q?Up14oKyUDwSe1/PBEjVke4XoVVqwXkgQ0Z6nv6o1QFyxYg0EDBRX6v7+5WF/?=
 =?us-ascii?Q?1ygKmF4NN9qeC09m63vn6fMXmPBv95mSt0+DBFmNV1jIRe9/hlyUDYQ8NZOH?=
 =?us-ascii?Q?muLpn64OnwkNFpJA4r7Swvy5k8dx8bp8TWMXf4mblnOQzjPwMMIjpYGL9xjw?=
 =?us-ascii?Q?ZoEym4/N6PCyGg5BxVSDIxDLjBXV8Up6nvNrxjb43MCbzGLY4YvMAxxD4wIx?=
 =?us-ascii?Q?HWYmacQAuOlSNq4mYdGLvfWoOOMCUDxd1G3KbTJlg4RV7QYASPj7TRjS1HDN?=
 =?us-ascii?Q?MOpiukLS5aLO5smoXQbYhSFBF+6tFJyyKInz92ywd4OEq9fuIe+S7vwSQWq8?=
 =?us-ascii?Q?iMo8w9kSytrfH/YczpxuGVQlMn8OhR11xjNxC2fJMZsgqHRoLyzmuhdDNX8l?=
 =?us-ascii?Q?39oGSKv+81jAd0OI4q4nyaByCSXot+7GS6Lw1msIHoSGfsARN+I7nnddIMec?=
 =?us-ascii?Q?FHrXlrgPgAMbsu9xIXicODMzaYcQXkD5E7qc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:19:36.1001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6db0ad4-cd4f-4c5c-a8d9-08dd77692cbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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

Checking hive is more readable.

The following smatch warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
warn: iterator used outside loop: 'tmp_adev'

Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 60269fba5745..eb0589a09a27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		dev_info(adev->dev, "PCIe error recovery succeeded\n");
 	} else {
 		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
-		if (tmp_adev) {
+		if (hive) {
 			list_for_each_entry(tmp_adev, &device_list, reset_list)
 				amdgpu_device_unset_mp1_state(tmp_adev);
 			amdgpu_device_unlock_reset_domain(adev->reset_domain);
-- 
2.34.1

