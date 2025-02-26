Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C22C19776
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 07:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18C010E869;
	Wed, 26 Feb 2025 07:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6BEpIlu";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D112310E869
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 07:32:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHHfajeQ0j3XxPgBFW6aOdzt55QBB++xwq0dng3Awd6Xc743Ybt7Kx0Ii2521SJ9H1q2qgs9OGAfM4UPKuH1/twUac09g7AgEhoMQDIvu5+iqQ62be2kbneHg8fi6qRzwtZuzGAZGtlMpumrmvjFmV9m9080liI/YMIkeXYAtR3iCaYS9+fKLf+7EePVz5r+Y+gX0sTd6/ZnDi+xzCbd8f+34uOh4ADyL4orqW2CxNsc3XyZdjPNNzj3842haEJP9dkCVJnPeNZS4aJ/m4cRQS8OowFlnUh+Vthwld19bc1qR+5EGs5PrPJ9ylPQ2bskYanP2vNouQkiazy83HAi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVJr3hxsAU5E8a3NBWDVO4QAWpTe4LkNVKDLCtdBnRE=;
 b=nSE9z3AGDh/ZzbyM7PLAkMEaFgUbpOmL3MgmlouZn9oQNkTu8S7UFFKQaQWwue7O5+XTaoSE5rXX6R5vZ+1rtPvknaB6kq7RJCWfJWTQZsq647C+bkSoYcyPkp3cMuS/6JfUCrJMetso2mLrAtilMz0GzlT+R7A1V6pyrXbPIM7AECQnuXT6CT+k8mKSwBASdYPyR+7bpXd2A7m7yxtwVikdTrU7JO3/YBwz6tvdflYlZoQ2fF51wg/SiBK53W3iighIZ5ukIV3BHN2ZKIueH4RUe/lyTcCle4CvZMvFhQHzgbQoocFVEigTqDy5vtBI0qVXDCrvLErFkhP0FuZwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVJr3hxsAU5E8a3NBWDVO4QAWpTe4LkNVKDLCtdBnRE=;
 b=C6BEpIluaf3DhkbKjhZYgCW9fCpT/8u2fd3Rhw1rq+FsAcNU0lsGMYotF3eT+o6UlMDC9hC2rtsYWc9Bf03qS7IW5u5E3i46EKXZ/laSixlCkix4wppRrBAddoF1ysHgO5zW6EnqfXbyKLeHkL5ON8PUBnh1mrUhR9aKbTT6Vb8=
Received: from PH7PR17CA0058.namprd17.prod.outlook.com (2603:10b6:510:325::7)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 07:32:42 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:325:cafe::e9) by PH7PR17CA0058.outlook.office365.com
 (2603:10b6:510:325::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 07:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 07:32:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 01:32:40 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <leo.liu@amd.com>,
 <sonny.jiang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Reinit FW shared flags on VCN v5.0.1
Date: Wed, 26 Feb 2025 13:01:32 +0530
Message-ID: <20250226073132.142539-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226073132.142539-1-lijo.lazar@amd.com>
References: <20250226073132.142539-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac4dce8-8260-45ef-4834-08dd5637c142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YfjvQrNVoZ9n4yEvNqytrH/HvjNP4Ec4ALhzxe+6sTH2qE758Bp20xsZbku/?=
 =?us-ascii?Q?JCNqbtXPDexI4b9AXONO/FzvXJCIbpBiUCge1N3Ox/zOeQhAnabJZNVVmtar?=
 =?us-ascii?Q?WHaWB82FNHo/xkyqQxI62bRGAJPRDvbjETMg/v01/jIEE7M4DiV3pRcFc8fc?=
 =?us-ascii?Q?A819Kv9G0eudSsIYfwR8ABkJ+ADyj1EAnzxZHQC7kqns6Cdst511RJRMWNu5?=
 =?us-ascii?Q?cy9e2630mNYzBTRG4JJFgPgaLmFjYa1qa9Tn1nhBuzz5/4su2y2mGj0kJdu6?=
 =?us-ascii?Q?v0BilgffWeYw7JGO1ay2ujxehvH1MaCdxV47vqU8dsz8EC/MnQmPrDrU+HPF?=
 =?us-ascii?Q?E7CyQ5wJ2Ulq0GunxdR31VLyatLpaSHqcykCBO4cHv0jYdhrgm5twWUyVmt8?=
 =?us-ascii?Q?4Te9EoOcq7qdTBS5GtjH4L34S5lsZBa3smHgzG0rgPiLciZ0b4fF2vVZkEIo?=
 =?us-ascii?Q?5KOxpCXlMvMrXNnHqBUjtX5tfxXs62N9wU3tpHTtxMxKmEQtwzBycSyaEYSw?=
 =?us-ascii?Q?qGjjuUyEa1JrrLYOMAfevw8VEkMsKvtjFgoJ5zMrwSKMFYqNNSXUcF+YD8iQ?=
 =?us-ascii?Q?V77OitohwgozyDFHcv4qXwZXREty6o9uOqh0ra0zzNC3LF07V5phhmoVu7ai?=
 =?us-ascii?Q?zKahzAECWSqvjEGZyzd+dhjHp4gVlmIub0ZUteo2RjEtKFtLfgLr01Ekqtmc?=
 =?us-ascii?Q?jdm+EI5VzYTNlhuJeq5jiRivEtswyEMyD8LJPfHjKv8qNqniXU0A8O/1zcy1?=
 =?us-ascii?Q?+oycMVSs7Sj9xuY3cKdB2601pRGINAgEAaqbyBS1ajlo3p4IVjiEwxdd7S6C?=
 =?us-ascii?Q?OdeAau1gBOCk7oyI7LwuwDyAboEYX7RK6ji4+/8Qvre3Oe9o5RkCp6q2uWv6?=
 =?us-ascii?Q?BxTI1EMDiZ/sxI70vn7kM9dbgx+/FgN0lENKTt++xgrM304IFNPAx8oMk4Gy?=
 =?us-ascii?Q?WJyBpnQa1zjijqnW1ehlxqpbj3CsfQQJSdDSPg0J0FM26tg8eNH464Fle+/n?=
 =?us-ascii?Q?4hMZxgsPW3+qNu7Jp8AXJlRz93GX+RNEN0UKnj8YotANHuwr0c5nTMl8SW1P?=
 =?us-ascii?Q?sZjZp2T8yOB9n0SGtM+F9lcP3N2/8Ld9DITq39/pa8Znghi7AEuWFArLEp2M?=
 =?us-ascii?Q?GqVZYaPnMi7kjT1CNHhPJgFna9i/1q/H8vkGAqxOOlncTuck7ubjzX/IHN/4?=
 =?us-ascii?Q?EFPWhyBOEfu36wqnRVv5j0lztUdqhCbN4HSPkheyPKDOsVqUE+oFvKodQgBL?=
 =?us-ascii?Q?I/MYxQr/yrytuRpChz3Xisbo59Z63L5N6MjVcuB6zQTxbWoZFLR2Yvoqzubq?=
 =?us-ascii?Q?2ACeof+DGjXBVWyoubpJ6DneLRWMMz/s+hQAOBaeVnYVteGq62mwE997H0Yy?=
 =?us-ascii?Q?4YMkLSF++XaxCTzAEwQizummZDUaOHpvLs26HfPL+XHHr6WrIKZMKQOWZk3Y?=
 =?us-ascii?Q?BcZFfeNd7qQ04iCNcZerBhePz1D8KKMjK61kShehnw18fa55RaEjVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 07:32:42.0921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac4dce8-8260-45ef-4834-08dd5637c142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

After a full device reset, shared memory region will clear out and it's
not possible to reliably save the region in case of RAS errors.
Reinitialize the flags if required.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 28 ++++++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 7ef83c9346e5..f364f6095e06 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -76,6 +76,22 @@ static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static void vcn_v5_0_1_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
+{
+	struct amdgpu_vcn5_fw_shared *fw_shared;
+
+	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+
+	if (fw_shared->sq.is_enabled)
+		return;
+	fw_shared->present_flag_0 =
+		cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = 1;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
+}
+
 /**
  * vcn_v5_0_1_sw_init - sw init for VCN block
  *
@@ -96,8 +112,6 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
-
 		vcn_inst = GET_INST(VCN, i);
 
 		r = amdgpu_vcn_sw_init(adev, i);
@@ -122,12 +136,7 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = true;
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
+		vcn_v5_0_1_fw_shared_init(adev, i);
 	}
 
 	/* TODO: Add queue reset mask when FW fully supports it */
@@ -207,6 +216,9 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 				 9 * vcn_inst),
 				adev->vcn.inst[i].aid_id);
 
+		/* Re-init fw_shared when RAS fatal error occurred */
+		vcn_v5_0_1_fw_shared_init(adev, i);
+
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
 			return r;
-- 
2.25.1

