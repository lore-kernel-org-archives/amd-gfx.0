Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB2C02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 06:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229B510E2AF;
	Fri, 24 Jan 2025 06:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hFkEar8x";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E689D10E2AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 06:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnfDrJ+RYdpTRQznMw8cY7VPin8+aK6QWfbTBbXgba6GkEIITK7L0erVKHm5Lc7fTQl88Eke3H+9vUZ6JA+rBzweDGhYBbFSvzz/E9VnIt64pQIV/b5j5Ne+XoGHrTRi1dDQUaKOY6qNB2ZyQgubs0Gf0nOkAweshzppgAX6cawBWGMLXYAQzUTmwtpR7HAgCiyJOkykZvqUeROt333Is08oX8yUlZ8nEXQDHMSdWvssQX/s4GNDkVXgQjPqL47kcBAbvpefmr+N2jNsyJDWy04TpjRxxtHN9K/CpDLVq3HaaacBx8YA+Iw9Npw6un32xA+k01ZKUlOoDZMbDDQJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wjW66Vu4TcygxBIZQI705rpluTxJvo/hu4hjVlArYQ=;
 b=j6nNVtCVV99rFMvj+rJsOrI8bWlX0B8aj2Nbx0dq/X8DbmTxsLRssI02p8OCzGNJGCQ6Cb19Rtkz1yO9VbRiyuvtfJOxwM9holIVknJ0oGUrwLqVY1sMx1IR/9hlpps+tS0PON3Ruh0vuW29tGR/s9smAag0on7D9CUQvW/jMYb64T3JgncnWBCKIYJGf+14wVcB4/x8ghv26+Sd5TPU3nXLxaN5/FlYXJCw3XQVpue3UidE8Pkex967DvRA4tIRCqN5TXDFlXK1PYy7+61NDhLLAyMu3Mz/6War2Q4T4z/6Xkd5rAD5Z978laX5hR29e/o99HcHMvVJuRA4d6yQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wjW66Vu4TcygxBIZQI705rpluTxJvo/hu4hjVlArYQ=;
 b=hFkEar8x7/o2Vy2US11WLS+oYQAJFxMOA+9TpFZTVEzgSGptDgrvtWE1p2oefCRbzdUOCAHgHFIvzUCdaHBgoTRIZT6oBuWcHXulAJnu3EZjJRo/toglRfVfSgw3GZNtbU7CfKIItGXnJPGnJdS1pcIdIjHIVgCFGPsr8vQKOpc=
Received: from CY5PR17CA0006.namprd17.prod.outlook.com (2603:10b6:930:17::30)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 06:34:49 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::30) by CY5PR17CA0006.outlook.office365.com
 (2603:10b6:930:17::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.18 via Frontend Transport; Fri,
 24 Jan 2025 06:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 06:34:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 Jan 2025 00:34:46 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: Enable cleaner shader for GFX10.1.1/10.1.2
 GPUs
Date: Fri, 24 Jan 2025 12:04:25 +0530
Message-ID: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 17478898-0bd9-484a-f566-08dd3c41337b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTFtdXdZNkpvRmMzZGhTZFRmbS9rYTl0YVp4QzREakdtRXpybEpSaDg3Z0lS?=
 =?utf-8?B?ZEJTcnVRMFJjbWZ5NkpNaWR4REJDQUFCNkNtUnk0NHlkNVluZzJCQmJnOFVE?=
 =?utf-8?B?RitvTnVmeWZMUnZIMEtZQUIwV1dBWitwSGZKVnVCMlRiRzJIVk5KTjlNdWtD?=
 =?utf-8?B?S0xrNG1RTnJoK01acnAzREZKb2l3S2IyVmF5WGRXRlRYMUY2QnBkQXM0Wmhh?=
 =?utf-8?B?R3ZKMTJmd2lTak15LzNPK0JBSVM4VFk5RVpheDZ4aHdXSzRJMzlQUG45Q2tE?=
 =?utf-8?B?U1FsZHlxNUdHaktsdTlPcS9IMFJKOXpHZzM5TlZwaXNUcDlqdXBGY0toVXNl?=
 =?utf-8?B?R2I4UU1xbzNHazVwNE1KMDlwSDRlWXJ3UHpHVGFPRk05T1NHd0dIUjFabmVl?=
 =?utf-8?B?cmNvZHEvUzNKUjhWUjIyNUNrWmJ6SWF4NWh5cHNXNUZiSGU3TUc1bWpZM0x3?=
 =?utf-8?B?ZWNOQ00zZTQ3NkJrQTd4R1I1dnZnSFRSaEdJQ2JOejkrUjE1YlNwRndOY2ty?=
 =?utf-8?B?L0xDRi9MT3g1SXhGTHh3UUdZZGZ1STZMSm5Kdk9BeWJ5cU0vQktrZXpsd2li?=
 =?utf-8?B?anJ6N2pwVCs0aUljdThmTGZRQ2tIRk8vVGpmVlpOWmhZdzhjcXBJR05oYnBh?=
 =?utf-8?B?elZ6TXVnSDBRZXo3aEtsUWN4WjlLY0d3cTFmQllHNXNTZnVoQ1VSVnFVUXgy?=
 =?utf-8?B?SUVVS0kwaDkzd3d1cTNYSk10ZWVvVzFNT1IvdjJmN3FYUEFqSWhEVFV2UjBW?=
 =?utf-8?B?TUxvRGZJUHo0dkptZGlsSE5WQzQxMTBDcHlpdkUxY2RwZWt2SVpycXZLQXRv?=
 =?utf-8?B?MGtJcUVpVm96eGFMeHFldkRiQjluUWFoR3lrUXd3RmFua1JvRStnWFY2TVBt?=
 =?utf-8?B?UVlNQU0yYWl5bzhFd0tQeE80M2VvVjdhTFJJd2o4bExvK0VSeWR2QUxjWkRj?=
 =?utf-8?B?TVVNajFZejMrSWVDYkxnTlFUK2lCSnFBSVRISEkrWHVaYzFrU0N5eUpQTWVG?=
 =?utf-8?B?YUZnUE1pOWdxM2tQVVFEbGJ5bmJGaXZSaEZLN3hlYWJEUzFneUhISzFJOVFE?=
 =?utf-8?B?VU4vNTBDcEpISmdCYVlkM2dZb2Raam9rODN0RldIZ29wU3FHbE1MSTdtdVNJ?=
 =?utf-8?B?blVtV2ZNeXJsdkhIdzdGRjVpbWQ4RTAxcGd6MkJ0M2dBN2hMS283QmhZUndq?=
 =?utf-8?B?cmg0YVhjOTExREtoeDZpS0s5Q1B4ajVjZnNUcUVZRkFkeTJuOWY0STh0Mmpv?=
 =?utf-8?B?UFQyeHV6K2hOdFpqejNLNURHaExueGJqWHkvek1aZWlRTUMwdGxSc2c5MVF5?=
 =?utf-8?B?VnhqK2Q0M0dXVEtqUUYrMFM5aEkwdGRjbW81azBvdGJvdG94cTFpVDJHNC9r?=
 =?utf-8?B?dHVkbU9SMnp3RjR4c1lLQmNwUEZOT2hOYkhWRGwvS2g2bHdXTVhOc3I2OW0r?=
 =?utf-8?B?eGlSRGhVQ3Z6b2JpdTJMM2F3SWJWb21FaDVmNEJjRndHM0h3Nk9YZUt1NkJZ?=
 =?utf-8?B?ZHBoMFlsY2ZERUtSeW9zUW5LRFZBekFuRnVIV1VmYUlxRnZoKzhHQmdKOGNZ?=
 =?utf-8?B?cWJNMVltVTJycnBUT3duNFByUWh0WTRrM2RaRlRZWUUyTXhITUZCTE1nMzFD?=
 =?utf-8?B?SnpxWlM3NG9sTEFXd1RIT1dhakIwT0R5R21lMDhadGt6QXlIa0M3WDVXUjNS?=
 =?utf-8?B?YWd4WjlRUkdIS3pNS0ZNdnMxL2pMbFNKa2RUZ2VXaGl4bzI4RG9LTW1xUmp5?=
 =?utf-8?B?Zi9ETWVheXdZcm42dzA2L2xpdXU5U3RSblY0NWwrZk44T201U1pIeDdZaEpo?=
 =?utf-8?B?UDlCOHVEcmUrNDlwTS9KdkNJUXNUdlcrWW1MV3VyNXc2OFVMY3FhdEdFSlRZ?=
 =?utf-8?B?Z28zTWJ3Vjk0RnhqQ1lQL0h2YzhSc2JFK2VyNWg4RzRCVm95SnpPV1Jyb0gx?=
 =?utf-8?B?bVVmamw2dGhjNTZWd2RBbkcxOVlkUTFJVVBMbzdmMlgxekFxejFPVWx6V1NC?=
 =?utf-8?Q?od7joAxj3S1FP1HUIhBRaLRRIPfakc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 06:34:48.9218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17478898-0bd9-484a-f566-08dd3c41337b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
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

Enable the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data
isolation between GPU workloads. The cleaner shader is responsible for
clearing the Local Data Store (LDS), Vector General Purpose Registers
(VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
prevent data leakage and ensures accurate computation results.

This update extends cleaner shader support to GFX10.1.1/10.1.2 GPUs,
previously available for GFX10.1.10. It enhances security by clearing
GPU memory between processes and maintains a consistent GPU state across
KGD and KFD workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1878c83ff7e3..938f7d60a0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
 		adev->gfx.cleaner_shader_ptr = gfx_10_1_10_cleaner_shader_hex;
 		adev->gfx.cleaner_shader_size = sizeof(gfx_10_1_10_cleaner_shader_hex);
 		if (adev->gfx.me_fw_version >= 101 &&
-- 
2.34.1

