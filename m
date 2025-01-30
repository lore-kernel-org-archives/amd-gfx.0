Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA040C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6060310E915;
	Thu, 30 Jan 2025 09:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2nqxc0aQ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A13310E915
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYPvkYodGhKQbRI4QVjzjVU7CxsO3gBS2scw8gq38e4BlnnIbfwywEumsHoKMD27LeI1LSyWUoWfnt2AeQt5QKSCeLFbZ5qdvJMkAud5HeKMyk28SZwcROsrn7FHxfSIBWfLnn7F2g82gW7ZZZNNqJHn4Vh2V6hyaN+FMhjqhg0nm1FgjT1e7Wd+NbyykyUk2v8zGxtP36GSKhiBfcsVFuHEbEh4yh3fDyFoCo3b3zeJVHm7VxIdi3e/1gUyo6ei8vLAtOkH+5rQHww2486sSEgMJTZMn4HStM/JpnzeRf5N4mk38nm7DaiY8cSbzY7NWI01FAvxH6DDEZKQGlPJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YstSru6tUJ2NaQqdnKdYEL9Y+iMXGIqVUFRcPr/KPoA=;
 b=Tehbd4/WgrtPEXQcNWd7ynituMr0LKKrnFewFdO6evqtKEl342ezmK8MAd7udyH8IW+Sqq3GLArutSzprOI0qcN1K/CFk+2r0JwgYwz49ar8b1RN5NmCxsGHFWcmWd1cSGpk608ePVPvb1TgeJgKwgw/ewmAa4wbPBRpaZEW8LE/EAbmPme58vvVVb+eUtjXhVLlwIVaEm1qq+SN2QUBtcSl9p87UwmjcD0Ifs88LIMi5NA5uX6ha6ynmLzItOuMPweuFD2K9+gXnK1GH+UEpI3ZmkgNzpH9vyF1mvCmLl7Et0slOWtoSwjwR6dCRCPmy+dRdcKKRL8qpkrrOyOzDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YstSru6tUJ2NaQqdnKdYEL9Y+iMXGIqVUFRcPr/KPoA=;
 b=2nqxc0aQplkG4g9SWqLkfTRuSzmT26gUXxeimNh5Ji6rM35EV95yMwCeaQE5UtVEj6q2lFDKN7Tavdv0Tq3FlELIj+767nDVg8tOoUfK7h31i7uvzwgO5wVm1vwabbsX5+10dXzKafh4MD1P4/pUJIsROjEsjCQDCReEsKgxVd0=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 09:51:31 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::9e) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 09:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:51:31 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:51:29 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v3 00/10] drm/amdgpu: Add jpeg devcoredump support
Date: Thu, 30 Jan 2025 15:21:03 +0530
Message-ID: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8c6dca-078d-46b2-63ee-08dd4113ac8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVBGZDhPclpRNVQ0MVJ1dFhJZVN4MEFGUTljVXJPUHh3cUVPN0N4cWh5SVFw?=
 =?utf-8?B?MXpYaVpTU1FmcE1zMURpRE9Yc3ozRjNsaDhNaWY5K2tkeFE5YitoM3VTbThZ?=
 =?utf-8?B?empaT2JULzNQblFNSGdDVnlOYU82SDBQSFNjdC8wMWw5ZTdVSVpwZ1lrdndp?=
 =?utf-8?B?cDFxR3FIbWs3bmpJL3FTUEg3bjR4elNyRlFZUk4xZXBLQ1luaVFsNTFYZmxL?=
 =?utf-8?B?a3N0bGMzSlQ0MmMwZU5kZk9hRk0xeG1XaythR2NFS0Q1WGNPclJJMmJ2TFYw?=
 =?utf-8?B?VzV3S0JtZXRUK2w3Tm9zbzJXWjdqVVVFQjRnVVZKUmxTNGFuZ0crbmtIQVlU?=
 =?utf-8?B?blphdHA3MExSN3A1MkRHaW9waytLTXNHTzNPc21mNmFmdWpyOGxSWXNtcnlY?=
 =?utf-8?B?cEV6M2lubFRXSzRzWC9JODVqRXlKc3M1K1FrK3Y0Y0FrcjFIN2RuSUlwekhz?=
 =?utf-8?B?V3hnWDM1WXBQVnloanJYekVYcFFySHFFVUw2TmtGMXczWlFDQ1RDSzZTME55?=
 =?utf-8?B?NXFleS9RWkY4OXVQYVA2YUJSaEpGZktKb1JUNUw2SXN5MWFFcGtkNlRCdDE2?=
 =?utf-8?B?RnhpV2pTNXUrcXN4aFB0dnRzS2ZwbTlCQ1VGR1M3Q2F3QnIyNnN4Ly90ZVlF?=
 =?utf-8?B?MEZWQW8xeE9rZ1dzanFCL0YxS0tRbFFDNWliUzJsYVBxZUN2YU5SUG9zTVNi?=
 =?utf-8?B?NHFWNndVLzRoYTllRXlDdEthTGhIOFFhdVd2RVZ2YTEwbEMxNDIvYkdiTUo3?=
 =?utf-8?B?VjJHVWh1ZDJJcG1KZGI0TzFhaUNSWDVibDFiQm5sNjM1SEd0YXVTWHZhcUlz?=
 =?utf-8?B?azJzWXZiR09XS09XaVIxdThYeGhzcENiYWlNbGt4QjlNMldPd3RvZEl3MklH?=
 =?utf-8?B?d3paaVBRdnlXMUhGekRHOWc3MHB2cVN4ZjlJVk5iQ1lNbU16bURtVFR4a21H?=
 =?utf-8?B?RFBMcHRHUDNLZVhwMDJaaWh5RFBiVVVUUllrVFRQcUx3aUh3dXdFQm1tcy9Z?=
 =?utf-8?B?L2RxZk9OMEYybGJzSGN0WnRkekI3QU5ESGQ0VjBRbkQ4NDhFSEQ2cmRHRGJy?=
 =?utf-8?B?SE9UWXZhRTlsK1djNlkxMVFUUWhGTGs4ZnIveHdHK0lUSnNVL0VtQm5GeWha?=
 =?utf-8?B?R1ZZYi9YR01hc0l2NnNEMWFjd2JWd2Zjak9BS2o4S1hjV0N1Rm5VVnlySmRq?=
 =?utf-8?B?STB5b2FTR0doc1VVUFpYU2JXSVB3bFhRK1Byanh3V1drbk40N1dBNmtLa21B?=
 =?utf-8?B?SVZ4ZGxNTS9ndWE3WG5kVTgvNDBteW1ORFUxcTFiK1FCU1NzR2JDM1VLbTlt?=
 =?utf-8?B?VTEzMjJTV3A0MEQwSEpTOE5kT0JHRGJtUGNuTzN1T0UrU1pSYzBaN2J3L2NN?=
 =?utf-8?B?RE5qL29pS0Y3ZHpqUWJOeFBUOFd5SjhmMERMSksyS0ViRG1PdDNsd2lLRVhH?=
 =?utf-8?B?NnBBNjVTekN0Vk1rdCtvcEF4Vk5Na0tIRVpOVmlUbjhtRzM5RE95eUtYZjJB?=
 =?utf-8?B?T3ZQei9Mb1JHZVRXQWUzMXRTMW1QV0puZTBBNWdNM3FQQ3ladzhPZitzYTdu?=
 =?utf-8?B?NUVPc29tdlZxRmE4Q1JCVkJZODUzNjBzNWFUTEVuYnJRNEZXclRhRUJVV1pM?=
 =?utf-8?B?cFRqdXFqcEF1U1JRcDBDV0FWTzNzMFVnTkl2N0gzTkVmRzZkRk9VK2d4OTZx?=
 =?utf-8?B?dnZIM0M1cFZ0c1FOQzBCeHdDUjBwclFGTDZJbVlBRjRiVTJIQS84U1NDVUtN?=
 =?utf-8?B?a2pFVjgzZzdVeC9wbFBvcVNrZ202Z0QrNmVSdnN2QllwWFp0dFoxdzh5Wkwz?=
 =?utf-8?B?UmwyazJuWDBzZHlDbkw5RW90TnRCZG81YTJ3NDZLaTlOeWliVGZrVVJQSWhB?=
 =?utf-8?B?U1FBbGZrT2ZrSkJXVE1zdmJSN2tLYlAxUVp6elg2TEYvMVNTVzhHWHJ3Tzd6?=
 =?utf-8?B?RFVrOEszbDJxak1jVnpXb0JjRThwdmFYRndwVmJYZy9ucjJwNWRmdWFDbmhE?=
 =?utf-8?Q?/yZLWhXx3JUrHTY+oE/oCtBvnCchH4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:51:31.0541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8c6dca-078d-46b2-63ee-08dd4113ac8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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

This patch-series enables jpeg devcoredump support

V2: (Lijo)
 - add amdgpu_jpeg_reg_dump_init() for memory allocation and reg_list ref
 - use reg_list and reg_count from init() to dump and print registers
 - add amdgpu_jpeg_reg_dump_fini() to free memory and clear reg_list ref

V3: (Lijo)
 - move amdgpu_jpeg_reg_dump_fini() to sw_fini()

Sathishkumar S (10):
  drm/amdgpu: Add a func for core specific reg offset
  drm/amdgpu: Add helper funcs for jpeg devcoredump
  drm/amdgpu: Enable devcoredump for JPEG4_0_3
  drm/amdgpu: Enable devcoredump for JPEG5_0_1
  drm/amdgpu: Enable devcoredump for JPEG4_0_0
  drm/amdgpu: Enable devcoredump for JPEG4_0_5
  drm/amdgpu: Enable devcoredump for JPEG3_0_0
  drm/amdgpu: Enable devcoredump for JPEG2_0_0
  drm/amdgpu: Enable devcoredump for JPEG2_5_0
  drm/amdgpu: Enable devcoredump for JPEG5_0_0

 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 84 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  9 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 22 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 24 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 22 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 24 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 96 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 25 +++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 22 ++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 49 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h | 61 +++++++++++++++
 11 files changed, 404 insertions(+), 34 deletions(-)

-- 
2.25.1

