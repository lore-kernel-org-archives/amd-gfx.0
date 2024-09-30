Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA2FCF6491
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 06:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DC610E030;
	Mon, 30 Sep 2024 06:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fFVpm5Cu";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C267510E030
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 06:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8hGJZpC99c3s+p05O9vt6PgZDBovvBFkzbK7fSAsmo3ESD6kjNQqgx0p1b23aDMv/5qd0qc8QnPeXvMKNWoWsyZxJIyrzyF5jpU7Vufq4/lmpeW3dVemUI5yIM4OOUdtiNncc1k9cegpFlVM7F4AfdayThXt8943gFs32Shy3ImkhwsuNle40n3FryGcUJr/pl7Q53JWor/z207hFHSrG7viSyrQJSggjuifjMJH2CrZX71ynnc8sKdvfLJjba/09CB2kaVMwaGrkGt3RHQ1o3CHGCw9cG55D5K8i+qvAHy57xpGlzqeYx6k5ziQ7atdoY4hj4zQPCQ7nc7aUh2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH67b4YMQvZE8tdmavpB7azEOkSttNa5CCAahYC9y8Y=;
 b=YoF1sLEMUmO/jzuDgkAlDhpDVWj0fEErupxWlDW932S2nEmc+ZVe7fZdC+4Vb2Z8c0Sxo0FcZ6v6XpadxpZk34UgPDtPuZjCcPlY0UgkUkgUNDYM8mNZPqEYIBJWq8mPPLuBqTB2EIj2DWY3NgptzvvDPehx2zGH8nOTPIlDeSKMiJa0rPSN7n185xDBEEWpBupGktOhfP72wIxGWRiRhcvhA4XxeAnLve1twDzg2kLzSg0qaeKHtVvriHK+fx1QL5g/Pn5LKm7D+BcC+i0Ud6TYLkyMlJuoE46tvZJp8kl2SLWOtV3oY5aEghx2fBbxHuiRU0pq3Sbnez7lTSgpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH67b4YMQvZE8tdmavpB7azEOkSttNa5CCAahYC9y8Y=;
 b=fFVpm5CuYhtKlKheYrDrJze86r5pDUJOdd/ubCkhnGnSvY0Kp3h9PfpqUZpgSJboJUnpqxqDX0/jwN0MHhYMY9+jLFOnw4aHUxKzC9agdH/JzWL4EBTOEVScyzxhWqt+IN8MuTu3NcKWbyWbllzM4n4PeEIq/vOpR/XVqs+2Epc=
Received: from SJ0PR05CA0150.namprd05.prod.outlook.com (2603:10b6:a03:33d::35)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 06:42:18 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7) by SJ0PR05CA0150.outlook.office365.com
 (2603:10b6:a03:33d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13 via Frontend
 Transport; Mon, 30 Sep 2024 06:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 06:42:18 +0000
Received: from lang-maple.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 01:35:41 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Lang Yu <lang.yu@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix an eviction fence leak
Date: Mon, 30 Sep 2024 02:35:12 -0400
Message-ID: <20240930063512.22516-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 83431944-9b43-4aad-ed7d-08dce11b0757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eim+niE9Fx8khWL4Z3mEfp13OAnYrW2be2Fk6DwRWg5wi0/bZsS6bBiUAnAr?=
 =?us-ascii?Q?nwJpX8ffmj9IQ3geDPXoGCN9RiPQk/ZZ3R2R7nrg1N41aUXybY7rY+96iMUT?=
 =?us-ascii?Q?ksi/N7CZA/sV70uXPTUI6Mc9sMaO84Q4P/xv+AcSgPoKoBPpro0S2Lk8bJqt?=
 =?us-ascii?Q?1+p3YKe61hJ69qRNii4SNjj5PGPc+o/69pcnG4mR8zW1dydgqLAkTiTUtZ5Q?=
 =?us-ascii?Q?qLMoTstoNBCFf+m8lRzVEhW7iBNwQKExbkgAz7/8biRbAs1D0l0q73ywxR+U?=
 =?us-ascii?Q?RdzbcjWAAI9i/UVSc40KpCf1NP3j9HHYuEn2CDwBUDswfgZnaLE6H76MUUqg?=
 =?us-ascii?Q?PDhyR9iECmFBWhEsJcufRvZJ5kC4V6OnZVGpyvFROOxkn63oA8g1u+XFUFKt?=
 =?us-ascii?Q?nfHL4eD4h2DdLCMKCWJbaFwuEROjPP0lMex+Uxdr7TbLWE3ZTFJg35TZUlsS?=
 =?us-ascii?Q?2ZZZ3BOHG6BxGcS+CmglVCN1vOu4O8gSq+eoFrrGKBpPcpeXeZnPrLKkhb2F?=
 =?us-ascii?Q?dK84SLmIjNE7zB6buGLrrK3odhIvhFtmjjnviNF6noWvtQv9k3l+dSErQ1wR?=
 =?us-ascii?Q?4ej/CSbaVkWx8ha0POeoaXRXmQsGaGowQEWQ1CZOju/r5dX5TcSjd1/S2EYU?=
 =?us-ascii?Q?lzqRVy57ZaVaBP9B5C5t7nPMEweIOk78xSxikv11HZ88+YLwZTJC7WZVGZc2?=
 =?us-ascii?Q?/Ek2cxeY+gqPZmtzvkXHQtKbiyIImTJ0qcvDgZt7zHVM0bIlxPZlLapUF08N?=
 =?us-ascii?Q?mCOqtJ1poVOyXTLxxfzJqXYidE9yzXAoAoPMKuXnf9DFN0yPCZXd+0kxvPqy?=
 =?us-ascii?Q?5Az8yzs8IzO/g7cprrLRk4L+zWo1krSW5/P7r2Kp9OjUQSHboxAG+R11ylsr?=
 =?us-ascii?Q?PhE822r/bqDZ0LJniioD+LzdsmVxt58XwTuRevvn7evbWN9KwX7LePbDBsT2?=
 =?us-ascii?Q?WW/XiEPKDHIyOlSE5FXriqV2GDmFTkl6ugyM8g3yPS2LUMTZv8KCGc1G3dHz?=
 =?us-ascii?Q?oBf/TlShx6tgQ9fEcSPukmX4sne7fCiNtFxF1w/5reRvewViBc8DQ3rk9q3n?=
 =?us-ascii?Q?9PB5UlZsaHe+wRZotWksB9ZlW2eoD7PM/sYPBMQ2gGvhEk+mEN7rgF7RXNnr?=
 =?us-ascii?Q?jdx39t0+2lY0o/98gimVh8bmVTStuytWJEkKMyMxShtOeVb5VwLcXr6mhR4X?=
 =?us-ascii?Q?uPsVCNgcQgKAh7qzuJwhehoxZs911giTVeVsFVvRIeceWxu15hZhEXcFo6NN?=
 =?us-ascii?Q?1vq2E54kEWpBnLOLP4ufIXVPVasq6a9BFSsBTGgHzTS9sDh9BnoXXPVNQ5u9?=
 =?us-ascii?Q?EZcnL5ul2Tuv7VqF851OyOHlJb+QrsMFk+KBwjEvlZF13B+K41W1XpZ3lVaZ?=
 =?us-ascii?Q?AvzeRps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:42:18.1931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83431944-9b43-4aad-ed7d-08dce11b0757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
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

Only creating a new reference for each process instead of each VM.

Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ce5ca304dba9..fa572ba7f9fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1439,8 +1439,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	list_add_tail(&vm->vm_list_node,
 			&(vm->process_info->vm_list_head));
 	vm->process_info->n_vms++;
-
-	*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
+	if (ef)
+		*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
 	mutex_unlock(&vm->process_info->lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d07acf1b2f93..d665ecdcd12f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1702,12 +1702,15 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 
 	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
 						     &p->kgd_process_info,
-						     &ef);
+						     p->ef ? NULL : &ef);
 	if (ret) {
 		dev_err(dev->adev->dev, "Failed to create process VM object\n");
 		return ret;
 	}
-	RCU_INIT_POINTER(p->ef, ef);
+
+	if (!p->ef)
+		RCU_INIT_POINTER(p->ef, ef);
+
 	pdd->drm_priv = drm_file->private_data;
 
 	ret = kfd_process_device_reserve_ib_mem(pdd);
-- 
2.25.1

