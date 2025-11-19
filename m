Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E77ACF34C3
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 14:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35C710E159;
	Wed, 19 Nov 2025 14:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R8Z+AcnE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC9910E159
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 14:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz/vWeUIN6akcMEjrMWB/o2miIOBVriiYRmhrN6+EoahBybfznMhHhuw+fsjWsS82/US0hWiDTNC6fAzp3jWMKOeKEkOf/nK09RKbKfCEVN9T57FZnE7a3IHhQY5UY9tcKDvam2uvY97H5GOnmhvWAQbJyJCyfimu5Fgz6gaosuFGp/1x70iZ+9DzXZxW8taPkc0MDKXgC/vZvQYGulxqWwGMxUS5PvVEp3z8mgO4sXyTMdfSyy2P2KVMyMCEuw11RVCrj04iMfgAGlAEtDXAV3HDKL5jWHgytelfIS+NXE7aAFN7tYjSI7Ze7HKmxlpQs2rEm80P5h0DpUwOXU7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV6KgnXehTsMMk2UJNUqp8GeNblnhdiG/0HCKYV4lIE=;
 b=y8Uxz6Q0mnwx+Yc0GuKM+8O39nGZbi94TK60pTd+s0qx/TFZrweM5yEVMRBzMbFuirQH9O09vLSZEeQgpcg6VVybS5PQyUzkEH2BU58zFQpZexhowyXi1rui0qV83UdiPZkxdSdsJxGoGDlD0C3IdRVm2dMxz1huXqObJVhHOLn0AS6Ut1JMGxhqVNTQOlTTPEGvnalQkctu2FbY6BE5ihmeKrQee3yK0UvCY6mpdjT/UhrCyrjFnOVJoEBGZVzKx+qU9mhzWvsPo+rfR3DZ3bpEpNfPoBjBssWKY6oVou6RE3bGoRudxz9ERSTdwbaiNBBdJ/dQcW/SethTQPBJeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV6KgnXehTsMMk2UJNUqp8GeNblnhdiG/0HCKYV4lIE=;
 b=R8Z+AcnEk065ZmYW22YsKJzoVFo1Ilg+JSbb1fNcc/pud6mYVsOM2jPwD5I6S4NDKogQ+/oOqepvOTLAsWDKKZL4R3bL6b0uZ3zo296WbwHrRJY7P5n/T8iFsnXfAbFa0y6kExMGBvhjKLkG7CXTRuAVW7Ug4pwGl7X4rKuIWoA=
Received: from MN2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:208:23c::26)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:58:08 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::ce) by MN2PR18CA0021.outlook.office365.com
 (2603:10b6:208:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 14:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Wed, 19 Nov 2025 14:58:07 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 06:58:06 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/3] gfxhub 12.1 support
Date: Wed, 19 Nov 2025 09:57:52 -0500
Message-ID: <20251119145753.3663240-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: e04ec2b1-94df-4caa-8be9-08de277c0c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1mHRTzSX7AKZj3mX9GV/LXZtkHpIaIwcGT5PaMEtJ9LMxML2uowz29Zdc+Kt?=
 =?us-ascii?Q?J6xAGEYmRK3K9ZtcbckHWMIVn1z/Fo9OCatLGn8Ewq9MVx8q6zIDofObzguZ?=
 =?us-ascii?Q?pEtMpqQE02LVT1IPVeBSi9rtPgfd9UkUNHIG/ViVC01LFn6lqrFzpmI58NvQ?=
 =?us-ascii?Q?I9mhqxhTGP1o+n4c692eoOeZ92R0SDF/44F7l35wOYYWFo7bfBy48dROmfMM?=
 =?us-ascii?Q?vFiRrCDL7915fRKIdPxofRB1iTPmzKJcIG15K8BzbLLaElMus0pOY72FzvQk?=
 =?us-ascii?Q?qNobX7ijwdJfkjAIA/6ysql6IRZk1bqw2kbH+r4I4merXS4rHDg01HWWALiw?=
 =?us-ascii?Q?xUcYHKVkgoJcYPa4RxctOehQl8kMqmM08VjgZVGDn2nr7Wm0nseC3QqfskZL?=
 =?us-ascii?Q?CqRETEDASXycE2v0XCbT1Tp4y5pYEYTgR/EAb/4fC6IWWPhB4i32g/D154MC?=
 =?us-ascii?Q?fpuqzwmRsVHtByA+0VU81mfHowLdbGxBoPNpe0iEd6xB35M/yeNQUK5kuwRd?=
 =?us-ascii?Q?J7Osh4CgJh2K39PY76tDR6ysDsjwnB37SwZ/WKDT1DOA29mUy9xQpfrhN8/s?=
 =?us-ascii?Q?gdg8Mqd5H4xC+lwUvGv3ukgU2X5uBPFLbXwMQu6ea/801EFESXeYeU0b4DBg?=
 =?us-ascii?Q?lSZwrG34dlsJbaFQKIy4kAODSK09A0IumeDw/AG/sn7A9yauxjMd5cz5eWqV?=
 =?us-ascii?Q?iMOx8RY2Ezfv/AVq4CClEJhy/XCvzXYZKiUWPHTaA6gl3OHDUVNo13xVBEAh?=
 =?us-ascii?Q?vZnVVR8Qw+PK0kDTUSRaR6pSkzaiHDGwpcUXIBg+txja3+DHTzhCiKT8re4c?=
 =?us-ascii?Q?hIczWQi1JKbCOJ/oCbXszaZ7PqI5rP4zMBV8clDzxONB4zlDIUcFLBwiJf1l?=
 =?us-ascii?Q?XWcNyvMJ6sPicpVvHBD32sGbtonXapQxjTqnTZdlbLSiZ99bnPut+yWBoHT1?=
 =?us-ascii?Q?06H/pVTzgZbACZ9cBRjfTqtfuUSc5bupJhpDVlkqWmNE5lPyv1FKQ4NtuPKt?=
 =?us-ascii?Q?uRJeqkBOEVDcSMb2UDRWnlpRN7aaOoYgmHmLs3BRKf2MhDhR7mBCDWa2Sk2k?=
 =?us-ascii?Q?lsttKhMzOVNzmnGmEZCX4hlxpIzChrPbaMD9TuVRysgNmPjb/t+Qkxbouz09?=
 =?us-ascii?Q?Qs7j5shiBLvteVDKaN3634RsM4VdYvwG2mCg/gVTeB4dQeh/Z3GnoGJbkikS?=
 =?us-ascii?Q?9+UM30aw2vGDdpxS32gvfcjsCworUBAE+884I/iHZX2TECdleJwUKRwQHxID?=
 =?us-ascii?Q?2on/rYEJ+lfvE1naGxlUmZGWsO/oFSWG2vMv7DS/EzInpCHXuBttKUt/jJ5m?=
 =?us-ascii?Q?YOlnBQHYqvYXaGtdpyK9bpnr2uC2ZAD6S4/DKRGRhrk3N8ZyYlyRLG9jIZ67?=
 =?us-ascii?Q?m+ijDZQ0/No9QGeYrmvHHm8FZv3R24lRAzKYBfLVXJcc37aCIOYqQ1DJONCW?=
 =?us-ascii?Q?BIOufFizDzLCD5Z73NahV8CbVEPK6iXQKUp6fTsNWV9lC2wdyMHOnFegLrLt?=
 =?us-ascii?Q?bFzuUNc3VZBmgSg76ADybR+h/5iZ7gGoiO3T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:58:07.2823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e04ec2b1-94df-4caa-8be9-08de277c0c8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

Add gfxhub 12.1 support.  The first two patches
just add register headers and are too large
for the mailing list.

Hawking Zhang (3):
  drm/amdgpu: Add osssys v7_1_0 ip headers v3
  drm/amdgpu: Add gc v12_1_0 ip headers v4
  drm/amdgpu: Add gfxhub v12_1 support

 drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c     |   896 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.h     |    31 +
 .../include/asic_reg/gc/gc_12_1_0_offset.h    | 12407 +++++
 .../include/asic_reg/gc/gc_12_1_0_sh_mask.h   | 44620 ++++++++++++++++
 .../asic_reg/oss/osssys_7_1_0_offset.h        |   280 +
 .../asic_reg/oss/osssys_7_1_0_sh_mask.h       |  1024 +
 7 files changed, 59259 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_7_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_7_1_0_sh_mask.h

-- 
2.51.1

