Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AABCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689C610E820;
	Wed, 29 Oct 2025 17:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cKrutmH4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6D110E822
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmPWaM1bQCuw+8dBBLvjJRq44b0HUaxv+b1aWPMc0jLr6bFCFhOjzP2xVelAKY+d2T1zTtq4FTfU7stY1KNyZ1oZiGRUcZAWtRg9/nooLDnNkNHt0UvjDN8kgIIsmw7AqxeK9gNdqIqnk8zkpwoGASRjRFgGElLJ5FCeXMuJH8QZuEWBL2m8dNjgsBoinxTeI3CshLXPdOOuY+Fs09t8XT9xUxQpZ7gRB9gsYsZgDT7GOnXPi/F6YWdd/i6kdpLnaaKHJ92I5wJuBKW6R3AYD4xNHMrquNsPXAiPnG/8pPgkDO4Ud0jTtwDnbycAFC+Xrp66WAw8HjlLCiGb3OIcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5pymUoyrkumwRt5ttrSJRdilZoQJf+t9s62WirlPsE=;
 b=ZPxlsAumA/fToCpFH0dI+DSoNxVTMafWfr+GV+EfqbaxdW/BSwVhYGzT1+hgqt06CBsqjfBb2H5NjkbWiDKiRtmGLOeO5AavNwKwdluVFvdgPZhFXVHEK1q7eErXyMXuGSB8INQrlUyWid3sG/TsmMgu7Egn/MRofhVmnICD6+zlUgPWtvM3LATyu7eOidDmP5k0hk1ydVKfWzxYR9tiwBhb/Jamo0ntmbyMWf/x7tS515WWxzuyWFJ0PLSXOZWx5J1juiUkRY/tf3QpcGVWePgZd4eK7ak17N7uv0M6p6j5/huPvKK6HgifOWEXYMb9oQcgTwDJ2Zg2567zEpT+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5pymUoyrkumwRt5ttrSJRdilZoQJf+t9s62WirlPsE=;
 b=cKrutmH4fRVCnM/5roQ1nd7lM5OL7Mi0mQp4WT0QvbwLSjuIqNefklmCaj2RLX2mUN0JfWRvAT5yjS0RqZLg4HKtTGvJ4SQhpYn1PptIwTcw0Y1eimi6ifT2PQy7exB+LJRybVPgfsqId3lTETTRpI6KBpmxHTqUB9zqxRoyNhA=
Received: from BL1PR13CA0065.namprd13.prod.outlook.com (2603:10b6:208:2b8::10)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:57:15 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e9) by BL1PR13CA0065.outlook.office365.com
 (2603:10b6:208:2b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:57:14 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:57:14 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use ih v7_0 ip block for ih v7_1
Date: Wed, 29 Oct 2025 13:56:57 -0400
Message-ID: <20251029175658.2862310-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 55729582-2603-44ef-cea5-08de171497f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vQxKmZH9V3sWI9jx5lCS7BgfR+4Z8h0Jro4wDc33CbAZNVSg7SKG9idGF6Qn?=
 =?us-ascii?Q?prx4KoTG90BPYRCr4EzFEJ+yZqGqoPCR1Sd/ozdR1QsjkLmeTZHEcCjBDYLp?=
 =?us-ascii?Q?4GQ4Hf94BtqAQZa0MGJK1cyCsD5Z975VEHLSmJwvAiTEHhVPGNOWWbegDfuZ?=
 =?us-ascii?Q?ZoRZ3FdRaBHIY4ObHYf4c5qr3vPmC5RsiQd1fUA5O07i/LKBjk5i0H4jxkrV?=
 =?us-ascii?Q?/yjDXcVz27COoD4+lhBbwBbQ1n7xGweo9yNGcsK3kFkRyjdkeTEU+htMXH+n?=
 =?us-ascii?Q?qPTVFkNozlKcICCDCJagRZggYBglt5PhVqLPkh3qJ+REXog4JxB5IcU+AbwL?=
 =?us-ascii?Q?cNMa/TQfAIaEvi0T5/j7I35VomRuB4A500RYk7D5ncmPVLRfkHeQc7MnEPly?=
 =?us-ascii?Q?AC8O3qpyOMQxhV45vOm2KuP681XliY/zNuD7W5k8K1tzBqjAzememcCCmMQE?=
 =?us-ascii?Q?jDI1hRTt6mKoL/QPKLUrRtunW4ASdMGuBV5DOxfqelTqr0fGvan28SPOpsfG?=
 =?us-ascii?Q?wLbkfDEmFI6HZ2v2dnXos5H6nM5WRJyEh/3oSBgTpRPCgM6eMDjSYou38KNL?=
 =?us-ascii?Q?XAp+/n2SOk6qq3JmkbHIchJmw3pdau/DbmnrP7b2h9UKmEq2EBzdBSk6uaQ4?=
 =?us-ascii?Q?jENuZoXHHedhG+5PwWJr3GcWwz6rGVXxKBOWc8FnJ8B39d3fQDkE9YxdBOfw?=
 =?us-ascii?Q?O8/SARFUM2qAVIiS24CIwx1ah0LGg52mjvpbpq18v0tHpRmf4qe7pwZ7X9RR?=
 =?us-ascii?Q?lMmw1Te3/4d4Gxa8T3cJA6iaMTOv11QSZLZDD/6jslWQtlnN5972fnNvtlaH?=
 =?us-ascii?Q?+eiLrsp1H2hOmzJ/sR0IxFlCOAWK994Fue1CS1mXoneQoKBIsrWvl7/EyiRN?=
 =?us-ascii?Q?z900yRWfiyxzxuaAdbmPWJimfG4D7QOccM8imrRj1jARLrhW5i6KnaG1irRf?=
 =?us-ascii?Q?fpMtzfW0kN0jqDAoeAfy9jXcL0UhQHOnd7UCrPJyaEryg+OgnlhiQ89Oy15G?=
 =?us-ascii?Q?SpnODLfV2f6+tWDQ35OwA4YL4Lel0ilSa34nqiu6zPcQqEIgCACdpIF8pyQW?=
 =?us-ascii?Q?I57/nF1rdzs/GDQiSBYK9PSPvdbmAAisD6gXBv+OTDSxJeeIUnzPyd5QpbsI?=
 =?us-ascii?Q?8UNyuQ7tytTWOsLfXgMrNMdBr+ciMDs58xePvEeqT8LObsH6NqqGW0gkIAG0?=
 =?us-ascii?Q?YQFx7DFoS+AeLug3dDyKHFyEIRsxPk5PNzYv9sn5SwJCDcEw49EoO/BBTRIn?=
 =?us-ascii?Q?ZleE5Wst/YCuuYo9/ooRlLAIpl9W+CW8e75NSHvN4AD1QHuN2bCs60y0KPu3?=
 =?us-ascii?Q?THpdHrFMr+DNguPR2n47Tx3z2tSAiCl54fb3Sp3O7RFUUuOqkwpWueXLc56G?=
 =?us-ascii?Q?dWsZjQZZWtNrfeUJwTG7ohDV8GKaMcbKfs+bJnBM9466f9K3yUR0PrBXjnyd?=
 =?us-ascii?Q?XmSzMKtFT1JPk6Xztbn68wcQI6uW+Jj2Xf5/rCtu9sfN8a11ZyMnQygJelVS?=
 =?us-ascii?Q?qxBlUzwipItm7qgad2dUJHXRf/EuGs0EoBWuHm3Hk1MgaWAsjIRJ20mb85Vh?=
 =?us-ascii?Q?GpDnfwcTXi+rmRYKMR8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:57:14.8995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55729582-2603-44ef-cea5-08de171497f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

ih v7_1 and ih v7_0 share the same ip block implementation

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 439815d6dfe14..cc0658d8d900d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2088,6 +2088,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &ih_v6_1_ip_block);
 		break;
 	case IP_VERSION(7, 0, 0):
+	case IP_VERSION(7, 1, 0):
 		amdgpu_device_ip_block_add(adev, &ih_v7_0_ip_block);
 		break;
 	default:
-- 
2.51.0

