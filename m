Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37ACAD29F9D
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 06:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8C510E088;
	Wed,  6 Nov 2024 06:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eRVG57Zu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4B410E088
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 06:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buD4elmA9thZZUvoMuZuopgXYiyifqlrZlY9ZHnldaas4Q65Ifrgs43JUsqLyOC7BIuko3uVtVvfMj7Y8vOJ29bCGtUisnb8pXoigmhNyy7wVyTGKt2C4rvV7c4fhHfuBfOK+l4cPlVVMUpBxXRu3DcsiSk7FhgtjRLygE933q4+qchvFcjfXNVp+R8n0zeKC46GZfkY6+fg6M/lGFv24OTDDMn5/n8ojk/de7+/14Fe2rCs8xICPfvnokJ4Sh2chJ+vrsEAsSc/+z3rervTOJyBih7wT3Tmgl4ff5HeaOhCsqFpobFaEbXFyhF4egFDgiw4M2OlVCnsSacMs6haJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NucfXNTabhAFzIzjWAjdbY7kW/ACzjyMjbRKZ9KJYJk=;
 b=r9GMY1nGORgrYnn0M3gWariYMXht6IWduFK788mgtpF2h6YKO3qFtQ+kfm7S3FmNZDRUu3O/FhYtKhGcgCLnKyc5ShV/XL07OOaTKAqGDOygZqr7mJN6BtU+EnrwYIKgGltQR8rGCXtA0smZEd1rIEqWgqXskYVN1gxhTbU1v1NmSrrRIfqo//pxZIgOKCgVnJbsI8mmvH6vrmONI+zpIFgjUgk420wPJeYcgcpoOaijzTQFyxOL2S5/VrFn4HFDy5Nzw6K/jIABCSCMZsplL2GkEqy2xJNazlteRPircGYSa61koh+QLXxMANkrSsRrDwGmUFPwCU8OtBkIbQ/gUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NucfXNTabhAFzIzjWAjdbY7kW/ACzjyMjbRKZ9KJYJk=;
 b=eRVG57ZuqVuWBtN0CsomIKz3I95u6ogAqCOzBXSxH+YbA5Dow3f2GMlci7it5D81f0EBqNgXXsBVPbtWl18RRh12D4DCMIDFCDtv9vnsJ/rzdSXQ8TiD9wQYkZt622J6i7PO3/NJiW5R33NbBFv8FxSOeqgdTSXk/FxeS6kTE28=
Received: from DS7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::14) by
 CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 06:38:00 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::e8) by DS7P222CA0004.outlook.office365.com
 (2603:10b6:8:2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Wed, 6 Nov 2024 06:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 06:38:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 00:36:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 00:36:10 -0600
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 6 Nov 2024 00:36:03 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>, <philip.yang@amd.com>,
 <felix.kuehling@amd.com>, Monk Liu <Monk.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
Date: Wed, 6 Nov 2024 14:33:22 +0800
Message-ID: <20241106063322.2443403-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106063322.2443403-1-Victor.Zhao@amd.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 452e7572-a9c9-4766-ad36-08dcfe2d8f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a1FBfmDR1ZwUmyIaz+3aQ+z+c/IqOQ5n/nTMSlCMMxR5mPnRKwWxVaGYsNvC?=
 =?us-ascii?Q?9UW40BiEUH8ntLJcudQz4E+q2k7I4gysWKnnUO9Cce6w2RQANYRg5LwtSTa+?=
 =?us-ascii?Q?t/8h4iozgoxJIV/rljmOKr1IJbSJL0S0U3317sgRoY1wwc4HW1Ppa00wHK6R?=
 =?us-ascii?Q?eNohFOf3jDxNNT0GiN+GAGfN4h+8cxTiJFGTI1uamdj6MshBg44Ut5J1B3ZG?=
 =?us-ascii?Q?jpm8Ueg2E2rtBcl1G+0+2yCU1PU45kS1V9JF8Db1dd4Apq+nn2pAQqAhyhn+?=
 =?us-ascii?Q?GXLBhnpHflx6uxTu9xA6B299mOFySUcf0uLH+3OkCL9GkTqtzlskiN8aDEFh?=
 =?us-ascii?Q?3KwrBqxoLihIz5dOD62xe790UJFrAroi7q4Bx1gCMmPAC2oPH11bGA6c9ocE?=
 =?us-ascii?Q?+Cf2DEtmEA5ONEzyOv7x/UzV9f6JARs/6fSwkfJhO/5KOI7ZGa/lJr4YZRJ9?=
 =?us-ascii?Q?uPg93y8z0DgrBxEudD3x2PjauMeJ09mTOdmYkgpNW4LYzw/k6fDnK/n6Z1mi?=
 =?us-ascii?Q?AFwdHK3szDquJwf7y73QIkwsW1WLfAF5TCs45GYejbvQYfJP/SK3P7mq8swY?=
 =?us-ascii?Q?JtUyf6GLpH4rtgnzARVInCeUqX6g9UkyRGMn3w8/ytjpMjMklcsuWyvzuYHu?=
 =?us-ascii?Q?gvUYHoSwnbh+2QWF7D58ADpFaQio/ZDWqJYONMXZbUtUiom/zY52s+njs15m?=
 =?us-ascii?Q?Gw8ulYXoARyUwKpWZABh8LBsUYZNNTNVnSp1bTOmymZg1jgbiggDvy+xt6mZ?=
 =?us-ascii?Q?0o12J2CNVdgLjAE53EDlXi3pYPZWDYrk5lrYifJ+Ih+u+MoRXv4d/+IieOde?=
 =?us-ascii?Q?wz3Qqm9gsLlqcEGIs8cILooOQNkoR4BPPOz5mUfbqhNZGW1vUBjYWviPMc9D?=
 =?us-ascii?Q?HvNn7vHMinbupVKGI2DByIihGXvhmZCZC0ErMsZXC2gBQ9zj0KywmSAQJy+1?=
 =?us-ascii?Q?iZ2K8swU6XcKXAxXon9b+J664TaFULrkbu8qAN36cr/7dhI2rDkq9rnTmbqr?=
 =?us-ascii?Q?kdBG0pta2Pz0FGubCdRPYkE/8eF5uM01h0gTLmGiTtMSwVhztZNIGHToUnZd?=
 =?us-ascii?Q?CSjI6bsBHP/lca8QRJO3gvUai0NedTdu1UqFLhvKH/jW8+tzHqUVweXmfY+6?=
 =?us-ascii?Q?PiltBh/0NBKVgfrj7uXkG40RgbNXHUVx+qVKddHHGHZu2LlyInr6yUFykPMx?=
 =?us-ascii?Q?1vpqRYLiRTggchL9p4bsAsT9KK9taQpDhQrNIo01/cIEjz2zp6YnYhvKS+Qa?=
 =?us-ascii?Q?mHEmLuFe1RW+wWzJYk7nF3WtfCB6JAGAq3XBM1pqDBm++Sy/BpkuuF+2NmVx?=
 =?us-ascii?Q?Dj4z1M52zAZ/iIF3oqMfkXQ2TTKSCabjbjaH5Q427UQFTZps4BPl2usVfmlb?=
 =?us-ascii?Q?69t0jlf7MsCASL1tz0s6AHkExnReAzprLBum7yi0utVz11SG1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 06:38:00.5761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452e7572-a9c9-4766-ad36-08dcfe2d8f0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457
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

From: Monk Liu <Monk.Liu@amd.com>

As cache GTT buffer is snooped, this way the coherence between CPU write
and GPU fetch is guaranteed, but original code uses WC + unsnooped for
HIQ PQ(ring buffer) which introduces coherency issues:
MEC fetches a stall data from PQ and leads to MEC hang.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 1f1d79ac5e6c..fb087a0ff5bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	if (amdgpu_amdkfd_alloc_gtt_mem(
 			kfd->adev, size, &kfd->gtt_mem,
 			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
-			false, true)) {
+			false, false)) {
 		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
 		goto alloc_gtt_mem_failure;
 	}
-- 
2.34.1

