Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ED7D6409B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FAA10E8E5;
	Wed, 17 Dec 2025 15:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rt8BzVja";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D7B10E8E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq7az/gNQpEq98O/llFrwWAIpbUpSbQCWAVXTLW3GiUpyZczyvFEcSwUQuVEapEABQpG56Co3aZSzx4yluc1b89jvRl2x1QIJ3i4EyEnW49vwdcqVjB8GEDu80evxxnW1aDSaDkVmBPi5FMR0Q5Cwa4ka/4ZyaVPErFPTI14eBHCklCR+UxysNZGqo07Si6Ou8LBBJ4WXLnyh8X0+TP6fQREpNT0y7JUR9ErybKpTL6hamrPrjX2AnKA1QMcde6kpatesjbMTA7cZoVHT90MT2D+CDOnXj3xQ+8AOWnWF+scUJz0Ew6NjH4Ulk+mjbSKdFw+k0rjU3oolnHGY0vuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNWVtqDCo+36DT9OvSDDTDFNwp58PjhcR5EzbG1YVnY=;
 b=IzTqVjuHhITgfACXtorlBmQH5ahRy5Awtm4uuLp7JGwhCEVHrGZpdihAhvUb77inHJhLDD4B8qHk7tjEi1mRjKZSLln7qr7J7E0G+5qSA3ULrIGSNDH+pHtKtoZZm6uBHjfgLxIB0VFh1fwlsS/W4E98EYKWK6kUnxxnMtcpF+vudZ5dtuh/dfm/s9Qqj8h/ZR8gaddRQ2hkoIqMwultJp1JyOMvgHl0ih1pYPMk0dhCyEbKxT8AtcSmToWwqDAu2YgMf7AAzBT1gAl18gBSxjJsxDxXkivv3+dIwiRGrSNUHhxXtMpVYoCFua7Ph14LHjSo1NMPWqWiDlECC4ijyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNWVtqDCo+36DT9OvSDDTDFNwp58PjhcR5EzbG1YVnY=;
 b=Rt8BzVjatEFUBRKfuR4k+oZDo8xlZR3mk/dkJxv77XkkHH7lWV8Y8Ab+j7M1Puun5+goCiUSwXnuSf1SRqigZ4Un2RPPOkrgwtzBsoZosfli88/9iKwSOuiSUaGk26sOuaV6dPoJuLalyHLiisbzNRYa051l9OjhDv6wId0U99U=
Received: from BN9PR03CA0410.namprd03.prod.outlook.com (2603:10b6:408:111::25)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:35:39 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::d5) by BN9PR03CA0410.outlook.office365.com
 (2603:10b6:408:111::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:35:37 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:35:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] VCN and JPEG 5.3 support
Date: Wed, 17 Dec 2025 10:35:17 -0500
Message-ID: <20251217153521.2018841-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5d5ef1-b028-487b-2cc4-08de3d81ed6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?smMf0MFFFuPiD60dnmrD59fr8ySDruaGw9voJZdPzZPtDPddNGw50doGRAXP?=
 =?us-ascii?Q?TZuDYUS+CTOIhMHfAgXh9ii72KAd3SNHAyjdwm3InALz7W1eo1ERNM1wxF9F?=
 =?us-ascii?Q?RYwbxzHzdw3ytQ9YpgGFPEfIS0AyZTNRf66R4Th5o99WUzUXgQUH1et/fbfJ?=
 =?us-ascii?Q?iA2BJgTa7pggpgEYWs8pNhlzzrXhteGox7qIQbzd7EvcoI8dBexVAAph3TMV?=
 =?us-ascii?Q?7JV86nkwkeeDLrPEFbkuOkuRpBCQei8qDi4yPKH4q8Ud33Lh4SAmWSnQ1zC0?=
 =?us-ascii?Q?j57CRnSzFMyhhU5PZKeAoYYb6ypuEWCcExZ8Pj9FeUSiC6yWntgfdX9shfs3?=
 =?us-ascii?Q?nzMF86UZZO0cLFsePNxl4GHMVlncUuEv6MKfgWc6Hwv4KqV8NJdxbeqj+6YP?=
 =?us-ascii?Q?TLgIr4g9W1XnVPvsEE0XrO3TDemk3YVJi5I2FeCmn5lrpsEg875a0bbuZoWD?=
 =?us-ascii?Q?l/N4VwTvEJHhx2jjcw1QpxvhVzTtvBINA4uS4wwS+Frg9O3XZTv+HtHc6YEb?=
 =?us-ascii?Q?JPqSwasYuHfT/VVWgrO5Z1fSKVA7QVdK+P4PK5eeo8hW82tCbHyGRMrBEEaB?=
 =?us-ascii?Q?xxhMCKgIrTeOEGtNUKQhx4gwSefsKXGS8OX06YLTkuSgUQFBqFlt0z1Z4CzN?=
 =?us-ascii?Q?+OE1xV30Qp+A7XK4TYFk9iHpMBcRPhRqQ/AKhJ3lZTxZOhYz8um3NQB5hMNc?=
 =?us-ascii?Q?xetk6pVNtdZ4tWx9Lf9vEEmxLeZ38j4+hukIK0oOy/n0ka05XHmC8YrBtRl1?=
 =?us-ascii?Q?0cFV6FolnUK2bThfpkWwMpZp6pxBH8h/CKHdeO/3nkQVdXk/GyLtEDJhdkeT?=
 =?us-ascii?Q?PtnJHKrfU1wQ0AalsmYOYGkUiHBE4xhz5EtvMXQ1vQRs5mhkHHqYnGViT1hF?=
 =?us-ascii?Q?E6AH4oHQ+/NK+YG6KhBbMZXU4NoDTgUcXFc/RFn2kuaSenvTy34rEK6+8FdR?=
 =?us-ascii?Q?i42YVxC86D/DIe6ObsPGIpP32PsQWDmKS3krsgBE/jjypFWS3tw09S8+eTK/?=
 =?us-ascii?Q?jaJi/t9l+M4m9YycavEGD5qRcpKnx/i3lyutFhgwnQtgXHZMTbeiQYJt1GbX?=
 =?us-ascii?Q?ITsD9cuy+sMXuzE3eRukSgRWeissKdsjns6BHGVqK8AXbnBPtHeg6zhwtMno?=
 =?us-ascii?Q?tVUJLqou93E/9t+26wehB7sJASosYG0AKSckPapGQ3yOJ8Daia1NdPPRfmuY?=
 =?us-ascii?Q?OJApdPm5yCEZsU3FODPad1RkiC1qR+/Z3XWOKRRt1M3yLjSA6ydHMdw2SvTd?=
 =?us-ascii?Q?j8mf17CDAfUspe3ge2yPkCvouOzivzjJNE2T9BkSVwUz+9h7rG8eaRDvt0Nr?=
 =?us-ascii?Q?poHFgk7KoWdYL3Xrp9qcwb0pjqeqnP0WbrHijzXmSQ7yhDYpOCRZk3w1AjC8?=
 =?us-ascii?Q?Lvm2/PbjnylgI66dJ9yV42gt1enkZOzgYHmaFiSHdUtDu2fCKhmeER62edut?=
 =?us-ascii?Q?JGm5CIqatLSbCwwPNew6UsXdR8q/A4U/ajZjQbcIY7wdPn35TqIZr6twNlgR?=
 =?us-ascii?Q?v7/e6Eb9YMwBrzOX9Cf8SRgjv182e+pPSyjPF+F4f0Hqt5HscnM5rPTH9g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:35:37.6056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5d5ef1-b028-487b-2cc4-08de3d81ed6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
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

This adds support for VCN and JPEG 5.3.  The first patch adds the
register headers which are too large for the mailing list.

Alex Deucher (2):
  drm/amdgpu: add VCN 5.3.0 headers
  drm/amdgpu: add queue reset support for jpeg 5.3

Saleemkhan Jamadar (2):
  drm/amdgpu/jpeg: Add jpeg 5.3.0 support
  drm/amdgpu/discovery: add vcn and jpeg ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |    2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c      |  714 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h      |   35 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   39 +-
 .../include/asic_reg/vcn/vcn_5_3_0_offset.h   | 1783 ++++
 .../include/asic_reg/vcn/vcn_5_3_0_sh_mask.h  | 8262 +++++++++++++++++
 8 files changed, 10840 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_3_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_3_0_sh_mask.h

-- 
2.52.0

