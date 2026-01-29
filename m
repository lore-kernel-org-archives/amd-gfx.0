Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D97CD73E84
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 19:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0B010E04A;
	Thu, 29 Jan 2026 19:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="atkmUIKO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7B910E04A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 19:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMNPu3PHPsx8x+r0Vyif+F7XaeBYQ767ctisJEbIWfOaFJSHvQalRPaa9Ne1++Ahoc///BzC4JicriLQX8iCuzut6d3/HHAx2UDCZlQ/L36/QvXVMv27D4Olxtbt8oaMgk4XnQrRq8PZp8BViDgcpu97tl1y5/HcP33QnFxC0Z3lfqsIwnwbRpKU14p4y6PtUUCUUyPbjI46jo88jHly5Hrylzl+uxqV95VlC9hiorhpJaTal+sMCzhZpdbnCPAD6OK4yUYOQvlegfZLPlCxx1CXDTJlsvPUhgj6c9l/CCTGfuiPwjXpm4JlrjH+fPFqV2uNHlxVIGrGZZU74rk1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm507Ntf2w1s6phKmakb+wlVLzcpExO88tJKLoDuuJU=;
 b=d2b9BpjwLZ1+Dg1tMJMZ6dyE4fgcYZ+NGf75JY91t1t0Mw9pIJD8U1TxP2Yufn1yx3HlbC4cc9oJwCqKv5RIeG501Omxme9GK7LNYkwGIMEMBJdq35/iJk1mhwue7V+c7+vhaDed+6Qgb+y7JUTStNK8yiAVUPshXEMYWG6hg7+E8XzMECC7QVdsJptoB0gNtKHK69UGalcxM8qrwDTb5/hW300XWIHYDHDbFXf6HHO6xIyb6fC5uWoFrCJl7rTYgSRVQxN3K8eqz4WN8O0YIslyOynw5s+1db5Ny1S8LRqMs9A6JTZIeRrZfhJtME17CmKPpmWLjBOSSA1K4LdC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm507Ntf2w1s6phKmakb+wlVLzcpExO88tJKLoDuuJU=;
 b=atkmUIKOE7aJK79dwDHGnyRH6frSQjGDu1rHidrCJvcSKQ9MbpJiO4Sc8mxdv6/Xh67m6wq/048BhCc1gylLyYRSGeas4H0xc7vvcNFHX1zKpXHZv95CsNB85dxKRWNCFw0X1v2Hg6lfmlYewnYIABwQEiJZfyUe4MuGRRws2FU=
Received: from SN7PR04CA0085.namprd04.prod.outlook.com (2603:10b6:806:121::30)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 29 Jan
 2026 19:47:39 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::78) by SN7PR04CA0085.outlook.office365.com
 (2603:10b6:806:121::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 19:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 19:47:38 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 13:47:38 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <danijel@nausys.com>
Subject: [PATCH] drm/amd: Set minimum version for set_hw_resource_1 on gfx11
 to 0x52
Date: Thu, 29 Jan 2026 13:47:22 -0600
Message-ID: <20260129194722.2331593-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e60ca2-3f03-4c7d-b29b-08de5f6f4209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tJg6XYdMWxqoQcd18GN9XCPNQmgIJuJcwMHQBWNQNSsn1mQ864bjnW3ufw0B?=
 =?us-ascii?Q?jrTWVhM7gbd+p4hCChnRq/U0PyOAVdM9Wz0fagQDjH9HXJb3bKJkp7jUjIOn?=
 =?us-ascii?Q?0LTm6LGfY6jAKkhEk2kJnQAb6SBvHF7WBTmnuezzKmuWCZCKxzCamEqc7UZF?=
 =?us-ascii?Q?q5MRlNeqpmZt6oe4NYJ3SQqQg4Gr4TaAeUiFsxDPvKFD243yjBNqaFodBAD8?=
 =?us-ascii?Q?5vjjeJiR1ti8SCyjf+EsWYIAhrR0jU7WyKaaTG6TxVh50n0/6abGn9NP6hOK?=
 =?us-ascii?Q?Gs5dIz3JKTJv3jDocPW1wuWy20UXpc0/85mz/fzTXYFjKGQkjA7x9SAeKvyA?=
 =?us-ascii?Q?oNE3C1zmmXFoY7YZ18v/Co/dZfP+6iYqO1KgPCMnUxtPOSZIm4pD/4H2bZcZ?=
 =?us-ascii?Q?VidevwHh7MeVpHqwQuF6M5c9yUkpnG6YOoDUS+F2lWbiWuWppQqz9eLlDPIv?=
 =?us-ascii?Q?9L/92nKYMnZW7xl+w5g8O7FWjT0cKIru5YCYpYsXtKV1I1DQ8Bx8+Q9vJMis?=
 =?us-ascii?Q?ZXaatigr9PnxYd9sU1ZIoXuNILWI4oYGL3qd03U9R4Vm6IWLnezXGIjsxq8c?=
 =?us-ascii?Q?Qb3ZjneSMWweeCq/AQwtRwlxFiwM9lCNOueGIKH/DXxPQ5lMvdASnPtmmwNk?=
 =?us-ascii?Q?JVwMDT2QxI8pv4BBuTDZKnmwW8Y58oAAITxOJgrI+t7bQvnmZfW018F/Zo0Z?=
 =?us-ascii?Q?qQ89sGoq4BWrut7Ret/X3GLgVuetE3Cvu8AYqAIjPDN+Vhd2tYeJJGp7nOMC?=
 =?us-ascii?Q?yisReWbwJZrEDJHG86vB5DMgGKSnHnfLZbuiamw97ZQP4EuIRsQbWWyE7Gox?=
 =?us-ascii?Q?D9UctrljbufR8zzcSygPKYmT3yz6BvmxL/rQCtT29rZsoai5CJNaU8TgmSND?=
 =?us-ascii?Q?qD832pRtPVmcA0Hyl9le97GC9mODSXqtR0ss928cRI1upzIC6NtR0NCiEKiS?=
 =?us-ascii?Q?G7AIV6terfdrurnijn5oXvmPVYGhvb4e3t2UgmSHJqgr/UlyWVqfoijZqa8+?=
 =?us-ascii?Q?hTsK1mCquIgwdna2+2MnqClzN+91R3JMrSVwrLSn4OqstlRo9R4iwQKFOut/?=
 =?us-ascii?Q?T+ej7N1EWPFZvEeRr5Cvn5T6h7zosAZ/PX6pfHV0GJHA9OgbHkga3z/wh0m0?=
 =?us-ascii?Q?4lUWY5pnlil6juEOKXgYVfzes4e0fw0dQzcOUDgPzNd8UQuvbu/r+zJILZxl?=
 =?us-ascii?Q?QyPPN6s/QsccstV5t1di48oJiAmWQ0AB3YJ9gnsnrLBou3vLtk5X7ecpg/Ss?=
 =?us-ascii?Q?3WV84kmrF3ckxFUxx6z+4f5DJ3rVaRq2O1c6CpYSavyaaYEYAbtuqE1kDkD/?=
 =?us-ascii?Q?ffMx/qhgrRNvhesinVDBf3J/rkOlqwE2HzcKH2nb0fCxdh+hPL3q6jFuR10z?=
 =?us-ascii?Q?BxHxrcidDjQ+SWpEv2X5UfAokyXHKyBAGQDuFjbkAEOQBr3mtITaGWW1rZgx?=
 =?us-ascii?Q?nrsrk4oS3mRlOZHwctiXTcfRUi/Z+iiH1T6zs6SXhqtdQVHNkcTl3n+t83DV?=
 =?us-ascii?Q?vW4A1usfkSIdEySaPvo1ATSw+c+V1GD/D452OtTX3xcawJAuQLggilqbyu/L?=
 =?us-ascii?Q?jJ3nePhHQlV/mr2cthWJf2A671CU/quxSekPJ1QRaWVLKxHTR/jYqAe31cdL?=
 =?us-ascii?Q?cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0/jcwOJt3GHcGfi5TJzqxFDArHZXTUzumz4osavbMeg2lO9Om4219fGeg7vCP0J+JxJtR9gqVmd5wEP05FqPciRGeYCGHeD6RI7VHge/zN11MldImINWsIfN5g5ien7+XvRLXoKEbEnIKIcRXHl96Tfh7UcI2jKD9NdCP2eTtcuWz00b7InfitXoxwDns9ry11x3fF+pTfeImRYNzrDpd62ND7pNgVP4PLYq3IOUyJ1aX0JqrDPEUqJKnh3HnzdzKzR3CzgjlagpAsp4iT0Nyum1qpFncNRY1BfDauVwtEQAb5A/6jd09s9XtHWX5275ObFI4sYwejFev/0CnNYucLFPbUB4cs8Ex9cIsYqvNa5XEpMv+XdcA+/NhNtv6vEF5oZsD0eaZ1e8xYrCH5I7HXUYoF2Gy4RKu5rdlu2RNaS/Q4ic0geSnbVVq9s3HV2i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 19:47:38.6483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e60ca2-3f03-4c7d-b29b-08de5f6f4209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

commit f81cd793119e7 ("drm/amd/amdgpu: Fix MES init sequence") caused
a dependency on new enough MES firmware to use amdgpu.  This was fixed
on most gfx11 and gfx12 hardware with commit 0180e0a5dd5c6
("drm/amdgpu/mes: add compatibility checks for set_hw_resource_1"), but
this left out that GC 11.0.4 had breakage at MES 0x51.

Bump the requirement to 0x52 instead.

Reported-by: danijel@nausys.com
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4576
Fixes: f81cd793119e7 ("drm/amd/amdgpu: Fix MES init sequence")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 81bf9385d55a0..09ebb13ca5e81 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1673,7 +1673,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x50) {
+	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x52) {
 		r = mes_v11_0_set_hw_resources_1(&adev->mes);
 		if (r) {
 			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
-- 
2.52.0

