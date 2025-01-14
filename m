Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD4BE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 05:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8940310E2BE;
	Tue, 14 Jan 2025 05:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqW8ihKV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C203910E2BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 05:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMvUjap7dMTUSkznfEU5e1liVHV817zUGKo9atIOK1eU3oLkIzS32n7Z5NRdwAxP1t1N0ibhxg66y8e7F99cJSxjnjhOxL3+Zq4oOgHrn2COGKjSfBF9PlRT+W9sTXpZUVNuUyeW5gopzZZVrGwAXv8CJ3+H04qwtzUDhTUieO7jMBu1tvSx/Lt1n/AvCQ+zsdyOGAtgWxQf2U702TFrPHwKoy3AEvCeku/WAlHMD6bjODF7HFcYXdZkLoKiVE/ZblffYKs5YSiLVmaBCiiYRcGrPnL7tSrbtlHqMTbWf+ZVoecsP+2bXEbGjy+1JmX9qyMtvuHQN5Sq+/L+moi3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9gngDp25Vk1PV9Hw8ks/UxcnFK7N9+vIyIVaB3EP+4=;
 b=OnDyWR+1DqD5moRqZ3DhkMjDU3Qn5TJipB7IXAhrX5FC8ljl64PuWnR6jFu4YBupfxLkN/6t8KUbvr68u0ddk3An2U7oDOwLoU79comNhPKEP5OlEDL4FbgusRzT4WrZXPo2ar8LjmGB3bQ6HZqIfDSTZRa4esfqMQKqsT3LBtQgfx9c2ttMqrP7U0tuDSPhqz0t7EJdnLr3FuX3/UPfjGAToOnF8mNL4Dal9a1uXbfBOP5PGtjNM3QKiNxSvFlZAr/Ix2RJfb91EuhnT20QjpfbbUKkBW3j5wKxnmDB6+kZxsKry/EsrFSrnzQe70wMDr7Qvcu3gScBFxaUndgR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9gngDp25Vk1PV9Hw8ks/UxcnFK7N9+vIyIVaB3EP+4=;
 b=VqW8ihKV0TLT+PtzIKfJdDriDaKa92dG26h9Sa/m2BS2Gc586vt76AybYczRrAI6LO1TloIjJjVBqA+8g47hdLxZN3Ip5MobJxfvAN8vyJqesmUwrxZvpcsM56iLUjuTN0GsYighV/Jtj2T3J04+d/pUlmeD21ij4qVmUnCTN84=
Received: from SJ0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:a03:3a1::33)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 05:15:34 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a1) by SJ0PR03CA0388.outlook.office365.com
 (2603:10b6:a03:3a1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 05:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 05:15:33 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 23:15:31 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <jonathan.kim@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: validate process_context_addr for the MES shader
 debugger
Date: Tue, 14 Jan 2025 13:15:20 +0800
Message-ID: <20250114051520.2917015-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: a21b8c88-b706-486f-4633-08dd345a78ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YAxSOiMbQHvRMOlJpopurawWG7B1LttSFOxHnqzjZ7MzjBI15iYpH4XAvFUI?=
 =?us-ascii?Q?vx6r/8CJuuGxcutAAJQgfYLfb5vwrQ5vh0CsXjfDlOPVAOQnWYDbdJmvBSOu?=
 =?us-ascii?Q?rM2OVLTWlE260tiag7F5DoULJt2y7D3IPzVn2WnOINq/KH7PPY9HSq0LZvvK?=
 =?us-ascii?Q?czHpS9+E5uGxMSGzv/sLEpmX2tGp0JsVhNIAVvII0doqFVrZ3QWmuxZwIGzf?=
 =?us-ascii?Q?cWPQZXqKyS2zElT5pf7OT8UGYuFi4HTLfuJkDWXtlOqQjMtxyzn3PMazh6MB?=
 =?us-ascii?Q?l2BO5gs80WL6MLbFCkZ7TCB+Mk1NSyS+py837NR1+iZZzK++Sbr6eTIqyv26?=
 =?us-ascii?Q?Xpq/XMwvvMlISPY6o84UI1lq9XWbpY0z9Nj2/JnoNC4vkvBKn9Wk6bKX42tW?=
 =?us-ascii?Q?4GDSZPzuOjes0yb2SfEs9eNTSXlDCVL6j0gRSnst/FOTTfx1D1FvXsW+Y5wS?=
 =?us-ascii?Q?kq3S8nhoZxi8O5u634n1w9Kb2QxlJyVlAT4tISJJfWyTucSJ85reN2gQ/1Tp?=
 =?us-ascii?Q?a1HNUpETy4+hiXMyAtzCC8XBa6aJiK/G/LZpM4iggBYuh2pIU/Q/H19i39Je?=
 =?us-ascii?Q?LdsNsoR+sPYROGeKMx3hagmbyFRYNpr8oNBA0wM7ow9pUV/V51B7sz3yT2nG?=
 =?us-ascii?Q?mKvmvu4EoyOwTbHzzLkmkuOzC1W9dS+BRtM0PKKm3tsOXLf51sBBJiWrfRvl?=
 =?us-ascii?Q?Y5NDfxa8bt1nOHxbfWIwofTnN3Ts5DEiB69pqsfLfUX/DuO6/VERbFhB+/Zw?=
 =?us-ascii?Q?VOZpX0wfLEnHBr+Bfi3DfSgAkRYf7Cd4Qv+tfJOR+uG6ozNMxiK0PKC8KYWe?=
 =?us-ascii?Q?ZOERnkDS3gvNxTN/Jp1gbWyFKMMuuz3nRDHCV9/92hLsL6q+ibPHzDlDTGgz?=
 =?us-ascii?Q?W0j6WzVbYU6HXr44qs4bc7PSkIh3Dx0RfMFutLPC9axDYKbgKdMgdyD8tIRU?=
 =?us-ascii?Q?y2iUGpmOjYnYsIcTHdOXlxEtx+WPq43vjsrEahjBj6VozabWugej254lyWMn?=
 =?us-ascii?Q?h2zD67kXQqKSs70OLOIXT0ZE78LE6lntxP0zZTE29o6GNTaQAGCIzwbSFSX/?=
 =?us-ascii?Q?xDikkmgazuLtnlaimcQioK8RJbpGL48HU57pJuW2rdkgAfjIqTXgSaoxETPm?=
 =?us-ascii?Q?aFw822zd5/0kb8SjoejY6BHG/YtNwyfWs3ddauZ5pHGmxWq7Kqvb4wvbwKp8?=
 =?us-ascii?Q?rCUnuy3L+JyPFfn4bWMfUkJs7GoRXwPcBdWvHAWkRcAqu7s0AK5CediNZ9Hr?=
 =?us-ascii?Q?4RYi6IGFYDzEf9+JHEl3uuThn3EdRusortRIsw8QDf5KMtQSGPgRiVM+pT4v?=
 =?us-ascii?Q?PFOuQjIg3Sqk4WitFCFgnmUR8v/BCwjxd3T/ja5M25qieZrPU8JdOdN5lMh8?=
 =?us-ascii?Q?qizLdDwPun1/7KMx77iDHCeNNkLVlUy5t4IlQKH1w4dnhHVr0zZ80Zn1M+ny?=
 =?us-ascii?Q?bhtlNPugTcgQGNJCSzvBW/wiue7F0yVDWcjQMuCtLIstEKzbOKEKeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 05:15:33.5589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21b8c88-b706-486f-4633-08dd345a78ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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

The following page fault was observed during the exit moment of the
HIP test process. In this particular error case, the HIP test
(./MemcpyPerformance -h) does not require the AQL queue. As a result,
the process_context_addr was not assigned when the KFD process was
released, ultimately leading to this page fault during the execution of
kfd_process_dequeue_from_all_devices().

[345962.294891] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
[345962.295333] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[345962.295775] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
[345962.296097] amdgpu 0000:03:00.0: amdgpu:     Faulty UTCL2 client ID: CPC (0x5)
[345962.296394] amdgpu 0000:03:00.0: amdgpu:     MORE_FAULTS: 0x1
[345962.296633] amdgpu 0000:03:00.0: amdgpu:     WALKER_ERROR: 0x1
[345962.296876] amdgpu 0000:03:00.0: amdgpu:     PERMISSION_FAULTS: 0x3
[345962.297135] amdgpu 0000:03:00.0: amdgpu:     MAPPING_ERROR: 0x1
[345962.297377] amdgpu 0000:03:00.0: amdgpu:     RW: 0x0
[345962.297682] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0)

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index cee38bb6cfaf..4d313144cc4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1062,6 +1062,11 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
+	if (!process_context_addr) {
+		dev_warn(adev->dev, "invalidated process context addr\n");
+		return -EINVAL;
+	}
+
 	op_input.op = MES_MISC_OP_SET_SHADER_DEBUGGER;
 	op_input.set_shader_debugger.process_context_addr = process_context_addr;
 	op_input.set_shader_debugger.flags.process_ctx_flush = true;
-- 
2.34.1

