Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E3DC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 16:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA1810E087;
	Tue, 21 May 2024 16:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="18U5BC9T";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7709C10E087
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 16:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUsv5J9QeNgoiPrwkkRiBJ9Ye4mYWXBiMf8yrPD3OPCSPeYHdXTw35vHt35hbtkk6YAZXTt03bpi4Rt1lZghoQxxWN8A5CDimrnkGyWDvxA9sPNdvjX9aQFlC03JU/MIXA+6tus9rLTsWJrKmudLb8mxzfSntVi/xy6qFiT7ziEoO46k4nY3sDPgzW8Tyw/tHKPZZ9oNy4Zo9CGNJ80K45G3vyFbxMw6gSgOcuJpixO4dnoAACs+1hHCrgqI0xk8cXNxcJdqmMr7IUFEUpp6s+erKffl+uNXzShMtZ/Ze5tI4tXjw9fIV4umEnYfMM8RJymODS20iNyGymAwAtHKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ4Yi04ks9YtMWHBy5z3Fh1CVI/cfXAL+7WETrRb01o=;
 b=m42Fq4Cd+hs02+tAJJZsYvoCagKLk1pWke8iFEQ01/gVkGeOfdLW8qsBCRPhE8dlbx3XR7gYfm3gTvymMjjCncuu1+yQqLu+TQw/9S8F4uN5IYvGqx5/tGezzI/1+fpGGimYN9M2lUgj68HWYGjK1VqEvWmA5p3EsjGL/Vcn1XPseYPGa1y/I2bJBO1Rs46IC7Eb5I5ubdJjWkMfAH75xB6B0v+te8rPtqG6febcahs3EXv0u7hF+L63OJi6MvFoqBmSIlkSyvbfi5mkA/NN9Y7gu4cZJOcN2WWJR8/Y0iCQyOfH5UtOi/Inl3lSAPdIKD4Qjyx6LBgEPnIDcNzuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ4Yi04ks9YtMWHBy5z3Fh1CVI/cfXAL+7WETrRb01o=;
 b=18U5BC9TsjlhReW7AUgHDX1j+Gqn0J1i0VTsHObWOB/cWPPNs7d9F5P5zu8UhQZ1MyH7hBiJk13nqZypNuHM/EQuBw3BxJsxIRoZfQF3SzQsN5bzjUE7Hs/FSERb9Dzc8UrBRHa/6K8OgARrAK9zr9MBsjfgb1JRxqQ9CMnIiCE=
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 16:48:57 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f2) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Tue, 21 May 2024 16:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 16:48:56 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 21 May
 2024 11:48:55 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <benjamin.chan@amd.com>, <king.li@amd.com>,
 <bin.du@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v1 0/3] Add support for ISP interrupts and disable prefetch
Date: Tue, 21 May 2024 12:48:38 -0400
Message-ID: <20240521164841.36101-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: b1186f51-80f8-42d7-d635-08dc79b5e7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6K4f9RF/v4CqCcL2u6wgG8JJxBQuAyRMAP/5lhPmSvTZ0zP+vmOLGwAWia6y?=
 =?us-ascii?Q?EonHlt9TQQmj9DXe7XIfh3yFRgxjglQ3Fc4cUMMcLopiL/FjWtMJH/mnrXmT?=
 =?us-ascii?Q?MsNLta+SrLia5mzPAJN6E1oUr1eeYTPMcAtXQRLuZ2DCXmu9sebT4uZgIfdJ?=
 =?us-ascii?Q?6IGTiqMFzBHdQAh6KGgzHXDNhlcLj+Pfn9AbvRrohZOrXAgkCmd9Ns1wwBfQ?=
 =?us-ascii?Q?S5oqJwOpSDfXPND3E81ymeojhGHQCCpw1ZddcaCjPb1jdkWsrD+f2L2fFPkN?=
 =?us-ascii?Q?4/B6RgRnMfX9z/JEIpLffkDPTFK8i/6OAuCrsghGtdqPnMVFL1BOU9jLhKRH?=
 =?us-ascii?Q?L/mixuCe+nSaVyELUcfhWFEJwcaVxN3McH433gfD9MVg/22WFVT6GDhxJzff?=
 =?us-ascii?Q?iKykZuXnNnNmsbANv9p6IwpjhhYUpqBDENQRayQ3u/IM2UhV0Ed2badRdWrp?=
 =?us-ascii?Q?A5pUmBbnX0Cn77q/EmQd+NhF7sIxpqvYndAHt0btHpX5duf+i9HiVLO5fgq2?=
 =?us-ascii?Q?in3nY2bOC1oMRLjY7NDbzQFMRxVMihRA3fp4y3Egkpl8upaAnLW3wYVu1mom?=
 =?us-ascii?Q?sdz/0FQ9VDFMOjhL6Wz+c0ET+eoNXIrYbgBFCV/HQK8L65K9J3cY+c4HfPWz?=
 =?us-ascii?Q?nMiqVDZ8AjdFUH+eNMlNp2eLo71MBImKlr3NP+bp8gmnZWM4HWda595Wdskz?=
 =?us-ascii?Q?t3gyLSyQPPkxJ19y5ztMhYQaD3Qv7kVNLK0S3P7kfWQekLo/ut497Iz0nk3J?=
 =?us-ascii?Q?rik+XsGhUMkaQ2odNgaJFEiD/zNApg6QvnChuKtph3PRCtQlQ/px1VRz153q?=
 =?us-ascii?Q?Y4/OdkVcwqRVz3x+zXfbjlqoV+X2wBN1uIhJGpDPXy/P0bBy7hNt/CmgtPsq?=
 =?us-ascii?Q?OWUYx1e1S1iQ4zBcSG6SfHuJwEhuLvEXXQLpCHw6i1V3VtgrS2CcwyKavOn8?=
 =?us-ascii?Q?fXQXe3kkbZ81CqGLP3H0kfMulbt+iGtVtbhguftHKVmb5HZdSke+Wj4zkOTg?=
 =?us-ascii?Q?QWa7/puy3J+yePH9v2/SQPHu25EgcZk47Dssk7KrS/acf15me2MZLcXnxF5Q?=
 =?us-ascii?Q?MK/cz0js+eaxO7BlkFjwURmmacehVfiL/0RxmrM00Z1UrvVT3vPUHQxzGBMJ?=
 =?us-ascii?Q?R5PYDHkDGWCBXD+Y+uAMcr1kojHhW68cAyyZTBJBIvebzEwQBd/plcuubP/p?=
 =?us-ascii?Q?o17uls8mDy553DMuIWzGexT1KQuwhT7e5+aaBOxf46pnnz2yji6MBuy7dOAt?=
 =?us-ascii?Q?Xhhwt+abgae+kEgFBL0aZv3iwkBvjNZ+l46djY78jmS8XkxxGGwusdcRHeR0?=
 =?us-ascii?Q?yDOOjziSYJWfH2dY8wsU7BcxAYrGrZCS3PftRGzY/sz2Ie+zvc0WG7zsFBY3?=
 =?us-ascii?Q?Z9Wrb7v/CfHuAh2vmzO/gNNuqw4E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:48:56.6706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1186f51-80f8-42d7-d635-08dc79b5e7ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
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

Add support for ISP interrupts and disable MMHUB prefetch for ISP v4.1.1

Pratap Nirujogi (3):
  drm/amd/amdgpu: Map ISP interrupts as generic IRQs
  drm/amd/amdgpu: Add ISP4.1.0 and ISP4.1.1 modules
  drm/amd/amdgpu: Disable MMHUB prefetch for ISP v4.1.1

 drivers/gpu/drm/amd/amdgpu/Makefile           |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       | 144 +++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h       |  13 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   6 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c       | 149 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h       |  46 ++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c       | 149 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h       |  46 ++++++
 .../amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h |  62 ++++++++
 11 files changed, 517 insertions(+), 110 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/isp/irqsrcs_isp_4_1.h

-- 
2.34.1

