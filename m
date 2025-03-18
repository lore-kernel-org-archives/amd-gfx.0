Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0086C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 14:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424C710E4A3;
	Tue, 18 Mar 2025 14:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7lSaRRi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5904F10E4A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 14:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpOyrSgfiOOngmQx/PX+sDuTZZljWe0KwI4HHrkSV5OGHZtDZtVYKdWPDEHEjUqVdgAbIJUHj6uyizpJ3VU/tnqzB7JqPDf+2xzNZ3aFmWROw0SoXYHTI/ucdze1ArfU0lQzlWWR78zL6mYxxzKIawxU3cy5HzIH5M1bP5+EPlIDFMS+fNRGBOPhcQCMIWY/jEQqaeW0IRGAol9UJwR3opIharrkwyrv8R6MioGI8mzoeSFkdAkBMPSqHkjukcYoebWCsxcXl6DF5mdy8oyt86IioIDyIQf7E9OyOncQNg5iTEXg97V1lVMvusXAZWgQ7AhOEhepVFnSa13Ay4pltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cATymUlXjTf2qZOVXGzCS/qR0tSGhDhR1EWRpTx+2Is=;
 b=HzknzZsEI3/Hli59mliMGCd65eUAQrdkEtujifjgy8nq0Ypiaqk9S7FpZK+zRYeH6qZ8Ts3zjpQkkEuzCjJjBXnJal5klwJS1muyV86nrohLSs19TQkoi/7+b80rdKD2XIKYLiLZmOjb5E82FP2XNHs8oO/Gqh6MltSHJ0PLpi/yHAFFsii2hb0jf5id6V2nLvJhdRCVdFEv1yqtqK/yxfUvDg+J+8pt7aHxn4Tor09KQdcQfp6NQ/601tazt2DhPng6mqlPcEcG6PR86lGF8U6770TCLPP1h5/Ntd8dGMbFDIBLToHvrNlXTr3A7i59qEqh/a/rJgkyrXugzimu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cATymUlXjTf2qZOVXGzCS/qR0tSGhDhR1EWRpTx+2Is=;
 b=V7lSaRRiYnUjTKIi12cRXqGMmU6k+cB0zYtR60FydmlMVfKIvlOJFCwMj2HLO/qIHkVF85yXI4GzK6JdCyq8bQnIp3yz2d++OpLa3Ee0W95qCUvSaUNxcnmJRkSftqBhHIJZ/nX1gaWQi2wdhyDkEDSGCSenzT9k/F3oHdFga3w=
Received: from CH2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:59::23)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:47:28 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::5e) by CH2PR03CA0013.outlook.office365.com
 (2603:10b6:610:59::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 14:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 14:47:28 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Mar 2025 09:47:27 -0500
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, Ahmad Rehman <Ahmad.Rehman@amd.com>
Subject: [PATCH v2] drm/amdgpu/sdam: Skip SDMA queue reset for SRIOV
Date: Tue, 18 Mar 2025 10:47:15 -0400
Message-ID: <20250318144715.7881-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae8dad6-aefc-40b5-dee8-08dd662bce0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?id100F8wFOQ3ZD/XgbfYn0Nehki/UupdePWcetvp0jwzLwTWFE8VQvkpIMCC?=
 =?us-ascii?Q?b/cuQ2aROMtw50imVXhQyb+xaBhK5vzirBeQFuAgOnbHw+e5IDLdLf5ATwQ+?=
 =?us-ascii?Q?p4FbISibLIcDBEgOt0TgEpTkKKVpW0CntJQlcOdBgfUTuyOuOt/ommQfRHg8?=
 =?us-ascii?Q?TBB/YtnKKmvGLWyCzD5a3Uzf1KkI15AE4MWtwmSsEv1nSfcogZVUO7RMi5A2?=
 =?us-ascii?Q?bnA+cUB96Od/B7IQbItqcsqtgWNhjhyg5kAJUzduTc3C0ZpuUlly1BGhNyxZ?=
 =?us-ascii?Q?lHkZGNOAWQCKEEVaZQg01+Gvdq9M8tB6LWsyx1PfbOX7RFg7+Wb7/AZT2I29?=
 =?us-ascii?Q?PtDGmJCTBuxgw/5owFRzCE2MbcrmLsgg2yXM9/wUzCQkRuUkZOddRmWIfKVA?=
 =?us-ascii?Q?XxWIYqRvMb7N44C9/eA2jf6vSRNEg+iLBpm5SnAH7LwE88IdFhOCkD31/D3j?=
 =?us-ascii?Q?nhHdGEaMSBMcGLqJR6BKZg92PM3icrtEVIaqik5Uabo8hRH3X6sfehr7trPj?=
 =?us-ascii?Q?IO/9LSYCZiaik7MuBWTO2Mk9yXSWMxvIJoW+SnEQuZOXRI0Eq65EC3HsqptF?=
 =?us-ascii?Q?x40COCsw8r3WzQsS47M2ihVm66ioFMCGjVOHZ/1MgmeVYOBN8Nn5FrBJ6fdg?=
 =?us-ascii?Q?hkaE1l+xAw94xsveSQs9AdyAd67S5Dxt/OCECVf5KCsxCBxNsDM7fY23oefR?=
 =?us-ascii?Q?gm+c75ZX6QrlcREJkTjHUYdcdPw0EgGVfcFr6fUAsqUB/tcDy8rV8EMN5fwk?=
 =?us-ascii?Q?5wlN2jD4ndjIUkhtzys0UeYzag2RTYVkoMPA50WpHtzUmsgs2X79lYaFvYHP?=
 =?us-ascii?Q?bs8UIW/+G8Y3P4jrIps9xhnaHJw1LPp3CzZyAkKIpmvjVVu+CJay0dR+kbK8?=
 =?us-ascii?Q?/DT1xCYGQoO+zas3Z1Vv8gefn4f4h20GIW2IdjONxhGBH/gdWyTX63nrc39H?=
 =?us-ascii?Q?BOtWQFvoE1HCUUJQ9xbeVhQI7g4/eCTB/oIQvrDquMSzHpSbrpiW0QIsyPBC?=
 =?us-ascii?Q?dLJmyy/IK1+6A2NcN7uql8e9tM4tyJu9ssnE4/u/EEDW3VE6dWpx60HccU6b?=
 =?us-ascii?Q?d4ohfsFXsalnTsf2Q4e3/QYpZRWNcmio78TpH3jTk2Tldxn6n/fAcAFoQG59?=
 =?us-ascii?Q?g0dOoQAhd5l/Ku4usYo7RIWxe4Snyw6vEK2K2p00YbkflU8/vrktBo8NQ1y2?=
 =?us-ascii?Q?rktnHtYW34pCtvGzIescJM9ITGo9f8pAcauq6sXilun/1wMLQALaAGBPS+Pt?=
 =?us-ascii?Q?fzHZnzfgJ/h0IM2gNb6SRtyf87xAhUdOvgHzLSRzqLe7Lk53DQ4yS7tEMiHF?=
 =?us-ascii?Q?PmMuN9SA4B8ovzN+8nWqvnB565ode9d0X5GFOsSZ+VSh4AF4FkzFJRCJgOaA?=
 =?us-ascii?Q?4KlNimLJeL+RCLci/FX4UxV4hLLrqa/rWAwS0zXe166deXPudeaTYBrdvtab?=
 =?us-ascii?Q?QJUHTfsbHWmzn1lq00BVc9BKDcI6ycuzt5Uk5m6jWaquX3IF+KSk7yg4ZjBL?=
 =?us-ascii?Q?rtY0DB0soBti4v0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:47:28.2299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae8dad6-aefc-40b5-dee8-08dd662bce0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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

For SRIOV, skip the SDMA queue reset and return
error. The engine/queue reset failure will trigger
FLR in the sequence.

v2: do not add queue reset support mask for sriov

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc138081..e77c99180fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1666,6 +1666,10 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = GET_INST(SDMA0, ring->me);
+
+	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
+		return -EOPNOTSUPP;
+
 	return amdgpu_sdma_reset_engine(adev, id, true);
 }
 
@@ -2347,6 +2351,9 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev)
  */
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
 {
+	/* per queue reset not supported for SRIOV */
+	if (amdgpu_sriov_vf(adev))
+		return;
 
 	/*
 	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.
-- 
2.34.1

