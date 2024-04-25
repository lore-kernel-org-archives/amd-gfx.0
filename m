Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D2DC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 19:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD7E11A83E;
	Thu, 25 Apr 2024 19:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lCRCrhyG";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D2511A83E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 19:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HruLQIePG/W/c7TCiuPdeAvM0Q2+DbvSF9CVNKqOYZm98FhbkYQseb9sV8b4oMXkVspLmDAZ7/V4XqYdRvX8uu0D4mZk3n2UwtseRk3LfNIEwoYro1RR+PbGTz4d1rPbbRmFZDkxQiU3GCdkbrK+O6qE3JACXoyFiOSNPtx4h2ZYo32helMMrqDrhDOnwm+Twlcw2LFGiGN5tB3Nu8ZddB1m4/xk1vMneBXZSjloW2bDT4oLXSGp2BiqPCDOd2SyID4zXS/vTHCb6Gm+5NknMXVrYY9u7wejn2eh9mV0OSBOI4CTnho4w+MwnlF5qQfc9Bmc4LJQCX4HB/nlICamoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9Lbr1oQrhOcVbR4HVLGd4hLNUL6YJq3KMEqP0eiENY=;
 b=XXPbjXW1/ra/lBS2c8b6f8nWzfRdxXd1pFVCkX3p5TbnBVsFxV20KqrYbVi46MvhFCpdSMrUPSIx7gJW0L5UBKKqC2uGBtsk659XAeXPAd4YICuPmPdPm1U8HPXtVCmKdWLKpYLFxKtm7NeLpupMaq8v1IMWbcnCINK7zkwpo85V3zTu6+mJZuDo18D3vpWiKqEJ0MeLlgdpVIsp1ZnbcY4jxNLfVtKyevff6qCevHLUWz1VeiH6pu8pDaopQ14d4P3nO2xb9js79enXYgvkm7QDCob8eBOg/Xk1pbup7rmDpP0SIgSoq15akp6UljZaWyS7YmudnkNC9qwZ92IlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9Lbr1oQrhOcVbR4HVLGd4hLNUL6YJq3KMEqP0eiENY=;
 b=lCRCrhyGFttrv9do6scBuh9N9p0BzblSCbcr84keVq04Fg2L2luYDG4hkXOkLQL/la+C1JI0XYh0PoxfytSJvolGRhP9CqQuoRrpNc1ka/HhcfcnaOE2sV77wcIyF7QHTGmGZogwu1OnqKziFTVU9luuFUvax8dTCCihGUvOsds=
Received: from PR0P264CA0205.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::25)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 19:49:33 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10a6:100:1f:cafe::5c) by PR0P264CA0205.outlook.office365.com
 (2603:10a6:100:1f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 19:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 19:49:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 14:49:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] add soc24 support
Date: Thu, 25 Apr 2024 15:49:08 -0400
Message-ID: <20240425194910.2783289-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b20d2bd-9faa-4d27-b69e-08dc6560cf88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?laDTmsFq7yJHgkZuJJERjkB2e++d6gMyaQ5yoMl1hriRMry9xyamNm3fMaYw?=
 =?us-ascii?Q?04U6MKUtbpb5YKeqj98gRa2JDX8MPnQfVDAltKWNasDQKUVc5vvmjQju1xgU?=
 =?us-ascii?Q?lxiN4aIzEfQsbwOLNBY2PlVbBj+1PAGclnsN0S5XxjmPXafzSjEAA0/bZB9d?=
 =?us-ascii?Q?4CkIUZeokTi3Ibs43qAEIrNiTkPn/vu7bfu7z6DlYXsaBCoIN3UdyknjFMQg?=
 =?us-ascii?Q?SgXxNEBO4HuCi8nufePxCmBUTzVnoTzxafhObhaN/MzwbtAH6n0u2pftDOfV?=
 =?us-ascii?Q?FVDAtFsI1yb8uxnvCq/ejO+oH96ZPlEJQ+u6cw/E1kKclTLPDKVgyEUi/Wju?=
 =?us-ascii?Q?e6GewT800cZfv3yBpj5UNOQpdHy6Jb5rWAChcn6MAnTr0M6qjb2VBRoqED1J?=
 =?us-ascii?Q?n+nOX9TKfgwSRI+FRmyOsvfInBHGN2a4tnV3ibmd87BMHrHBQFmNw3p8ueVm?=
 =?us-ascii?Q?sBG2OT/mY64O9/V03rxSynTtPtuqSvW6rnhypPKInhNZWqU9rin8t6dbdGEh?=
 =?us-ascii?Q?z5V9cPtFyv8o+lN8YjDdJJwRLbEu5/o+DF20XGdliH8SOv4aAkjjrpMU+0qo?=
 =?us-ascii?Q?SdQkcZS1hFwM121DQuku0VnPRtDgNzQFp+IT1FB98wAXNMSmGXid1TIY/a06?=
 =?us-ascii?Q?YJCQLHq0jJcZprU+7RVYcOeDvcUeePfxVnECRjK8Mny79KpyGFYcMXIb1w1b?=
 =?us-ascii?Q?eXwzUHlrdwW+aRb+UHJtGg7rv+FTnf8AjN/5TK5usIEdd08gtaEp5N+O/qRa?=
 =?us-ascii?Q?WLmjtbNV/Hszd39OsYC30SjOOVkxdD6xOhYEVqmo/ohZVu8TcA6Fhy1v/+l9?=
 =?us-ascii?Q?9mISr4B3otqWKEO0LsVqOHl+GibFpyz+qK8cihxH64qW8g993ew+3m3OCWfB?=
 =?us-ascii?Q?RaMaFnn04v/+95b+LdpMEB0na8L0oMjH6hMVrUTcUuR9hkI0cNGvK2lT8jYI?=
 =?us-ascii?Q?H0UFp6undFlMY/kBH3xT5jiboULUfmAF6bUCQTszUabOpHe1uteFqta53hnc?=
 =?us-ascii?Q?fhm1hZ4/F/mytlt1hTshkp+9I1iQU9whvblAJoMJt6P7LJrYQbWE6/nE9Iwd?=
 =?us-ascii?Q?60a6ovn8INAjBMv7iaJshvcshqm65ls/nVbplVneXRPBn65AQlxVD/cl59R4?=
 =?us-ascii?Q?pvNbBNCEDyy1kBjWKU/gQG3ESTwpWcBZNMz9P0SoJ6qilBjHgZHsX3S180F9?=
 =?us-ascii?Q?Wc0jdrFodZfvhSD+8I/qaF2x5/zgHFNH6d0M6bjuyP+/bdW6B7intRbSKBaY?=
 =?us-ascii?Q?irsvwehJkhTCyE1ntKhky0M/kviTF64RpHTEOs/sPm5EF6hpWkav7pYoiSvI?=
 =?us-ascii?Q?AunzmYZpGOdRydEvYkzib+28r8Gf5UCXbgKNd5sCGUTy9uhJ1YFIjiSsBdgH?=
 =?us-ascii?Q?NU8Xe9A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:49:25.2251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b20d2bd-9faa-4d27-b69e-08dc6560cf88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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

Add SoC handler for SoC24 platforms.

First two patches add new headers which are omitted due
to size.

Hawking Zhang (3):
  drm/amdgpu: Add gc v12_0_0 ip headers (v4)
  drm/amdgpu: Add soc24 chip enum definitions (v4)
  drm/amdgpu: Add soc24 common ip block (v2)

Likun Gao (1):
  drm/amdgpu/discovery: Add common soc24 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     5 +
 drivers/gpu/drm/amd/amdgpu/soc24.c            |   532 +
 drivers/gpu/drm/amd/amdgpu/soc24.h            |    30 +
 .../include/asic_reg/gc/gc_12_0_0_offset.h    | 11053 +++++
 .../include/asic_reg/gc/gc_12_0_0_sh_mask.h   | 40452 ++++++++++++++++
 drivers/gpu/drm/amd/include/soc24_enum.h      | 21073 ++++++++
 7 files changed, 73146 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc24.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc24.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/soc24_enum.h

-- 
2.44.0

