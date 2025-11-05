Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54EBCCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A77A10E698;
	Wed,  5 Nov 2025 02:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vCo0Ly3G";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83B310E695
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4ENqReX7fcildU/cwwhv4FzETobdFxydOHQMn3PrakK0e8CpQiYriMjX1Hd2Z2bFxkbNJmjWq1Je0+CaPthWJhjAl8OLn4mB67/SYkj8A6Sc5s3j3jUrZt8Ri+Qyg1Epzc81YXyFFhBRWGw8YFpzHgpYh/uFfeHzxkeCWkRDOKK+xFhhQ228xuVmB/+qWzWHk/llLRP84pEWuxE96lAluCiYo+Y7tq4pkRLEU7x+/xGFvfKwt/Nsk3b9LGWdSlo+SbWqIQx4F6ny8CEfSOhPQbFuWaX80irVvbVQHBwAI6pW4EDgdCgXagFhTA2teCytD99ssC02o2o7ah7OZFI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4VEw3BViBKOjk+0f0XAMPIja+6Sg55lIdictckc07M=;
 b=EJdwq6gF/QmJD25R24kxLishZERa7Jh2PR+BhBZixj0iFBZLMYN407ZlqWPVcLxbvYCPSn/IkJbmWCG/YvhzKFIR6CgfHX6ZMJddHL7P7CX35qstZAMA4ZsaSO3aYIhTIkWEoa5mvmB0hEj5qm3kk7p3cL43FiH/+qtLm0l5eOOtNUODX7JrCu/HJrHi4FVMjyoF75w7Iq/S+P7+gLW6rl03H1KyejcLENNvA2qhM7ZCiACj6UP+rHjsplfjIPypfN8ElM3d0sDKSMoUylFvvDhOyuiGyNzMTmCanfmEiCSNDvMWh60AsjTnkPlJWTCtksoyA1e4EzF0mmWRh7a9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4VEw3BViBKOjk+0f0XAMPIja+6Sg55lIdictckc07M=;
 b=vCo0Ly3G+8KJsDgwhWzGjM/LFyUrdcKe27FU0r4vHMXpfJ+ILyX0J2qy1YfuT8FFvemTRwg/f6ZnTP08ycUi+Gptlo5LegppxxMMYQ/zKpNRc35sCEjdHYnGTK6ehOvqGUrMXQJmY3lx6qfXFy2OVavgn96PBa6CEF5slvfTvNM=
Received: from BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 02:04:56 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::d4) by BY3PR05CA0013.outlook.office365.com
 (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 02:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:04:56 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 18:04:53 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: make MCA IPID parse global
Date: Wed, 5 Nov 2025 10:04:38 +0800
Message-ID: <20251105020445.1423034-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: e3747843-03c5-461d-df3d-08de1c0fb792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nt14p4ASz3BGAkhbn+YRxyJL6iKNPKaRf7tQblRcVrYfC6kv3wTMIt94lD7V?=
 =?us-ascii?Q?W9OFaSjNWAEyZv25Tpiu3s9uzj+XBvja5je3HKOlKbCM9X5AJkE9bctZgjAT?=
 =?us-ascii?Q?X1U0v16plliscx0ECIrUiKt+HwP75j3U0mUGIybRy92rJnjYreixpEiBFqCY?=
 =?us-ascii?Q?9GJr131cJlBRMkAZPmWR+hMq9iLjw7AF0wZoLlM8y5R3W5FP0Hsp7bj6WfNl?=
 =?us-ascii?Q?YR3DJXmdMsx76S+X9oG8CENfuj2+XL4RGs+kL2+VrMvkTXEWWlDXGzY48Vyo?=
 =?us-ascii?Q?qx5AbSgVEv1tMRTdW3xhxvcpFIx601WEW+iasTQfsoe6Oqz6uLCyqFGjnlFx?=
 =?us-ascii?Q?i4N0HMt8BVg7u03cJ5SXzC4WmhYC+Ap3lNTJBWm4KYmAj+8eswr/Xckj65ID?=
 =?us-ascii?Q?4SqCKfY3CCzhhdw8QQsm081IZj4mhiI79IiK8o+T5Xc3mOKaCY/eLAk89fiI?=
 =?us-ascii?Q?I6oknFiQpvV8gUhNz/v5TMbgSnWOvlo0Ro60yC+JRFEmo51q7OR3k2jN/vH1?=
 =?us-ascii?Q?fbtmGjOcdp4NolmnsUHY5hrizx8DMExgft6np6X5RtCXqAUEgzYQ2flw4lDB?=
 =?us-ascii?Q?zNsKl7LKXG5tzKincABmw1nMSCgI9HoMCJNV4NV4p+hGkWOVluEExViSEyO/?=
 =?us-ascii?Q?qZqjQmiwHK0zi6HFzBz1s3RcCvGCh+w4JYn5po/YDrttI1RmH0XxsZlA/pI3?=
 =?us-ascii?Q?pgem2xiyyEuxIbdpj6IUcdg4PUhVDDIUMdPFqRSwmltQ8XZwXsUQRae4r+qW?=
 =?us-ascii?Q?MlS4ppOSb9nPFDN7AlD8j3GI4Vfaaq3y0FTzeo5o0U3Et1YGD1uO+SZf/CqO?=
 =?us-ascii?Q?pVVp4g7lNzDXuwCs11VhiTUF3CXKDGYk8gxiYm7hLl9sMZxlrBjNdE0h1gU7?=
 =?us-ascii?Q?QnvFmBv8aLfgOQilAFtt2RuNOmN/DGJwyBLEulq9BIA8Wp8DLhYduEHST/Bv?=
 =?us-ascii?Q?XqVqeEfa7xV1SYycA8C6z41GtnATVdgxrWjx/RhDopjFsrowzevE/YkoBsIn?=
 =?us-ascii?Q?RmCj9bkTyjHSnvxFqVNBUnXOqC9wmIjr63/McfcyWqNVNj4S2cg7kzyiGEIn?=
 =?us-ascii?Q?ejfz99Z9RpTXHMZng1zNK3Vcqb6UUJtGWYhdZN0qO70/oEmeed0GVy0Bud9i?=
 =?us-ascii?Q?hUwKcPnm/CWai1vCvTJpmTvHVEQk0xs0oVuBi/xJg7T9bc9cNaCBJp5XN8oN?=
 =?us-ascii?Q?fXwaAY01KU8SAqi5HbJbrhGBlvl5jX042GwePSe5Oda3rqGoSMGmFfhJDURm?=
 =?us-ascii?Q?Ro7eeBH+ZJ3ASR+SRmOjRpl14sPTkdIjWpGY/RGdWJMW8bXgJIxomSnxh0cL?=
 =?us-ascii?Q?UjaPm2U2qLxjhDJIA6Zrod4rYeRm4x6gUvfrbXOUkxkhnfAsLYb1+8n50+dJ?=
 =?us-ascii?Q?YFx9NXk1fraxCY1971MDQ/xdOf39SfU44HSI1UctyYVeK5Hb8NwLSom8fX1r?=
 =?us-ascii?Q?+/+3LGKNBb9M/1EUSvDLmNRWG2rP3w3Vi14gGQKCtIYDFOjDv0FOSC1iQq0w?=
 =?us-ascii?Q?ohhUedmGRCYy4DVNGliN2x38xvF42j1oxoX0PmYK/S3tQKS4dh/A3F0HBjZP?=
 =?us-ascii?Q?WMTAwUNOD+MhD+Drn5k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:04:56.1797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3747843-03c5-461d-df3d-08de1c0fb792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

So we can call it in other blocks.

v2: add a new IPID parse interface for umc and we can
    implement it for each ASIC.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ec203f9e5ffa..28dff750c47e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -113,6 +113,8 @@ struct amdgpu_umc_ras {
 	uint32_t (*get_die_id_from_pa)(struct amdgpu_device *adev,
 			uint64_t mca_addr, uint64_t retired_page);
 	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
+	void (*mca_ipid_parse)(struct amdgpu_device *adev, uint64_t ipid,
+			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 8dc32787d625..0f5b1719fda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -711,6 +711,19 @@ static uint32_t umc_v12_0_get_die_id(struct amdgpu_device *adev,
 	return die;
 }
 
+static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
+		uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid)
+{
+	if (did)
+		*did = MCA_IPID_2_DIE_ID(ipid);
+	if (ch)
+		*ch = MCA_IPID_2_UMC_CH(ipid);
+	if (umc_inst)
+		*umc_inst = MCA_IPID_2_UMC_INST(ipid);
+	if (sid)
+		*sid = MCA_IPID_2_SOCKET_ID(ipid);
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
@@ -724,5 +737,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 	.get_die_id_from_pa = umc_v12_0_get_die_id,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
+	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 };
 
-- 
2.34.1

