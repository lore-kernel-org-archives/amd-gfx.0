Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3B2CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C9F10E052;
	Fri, 29 Aug 2025 05:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5OFJqLeM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B103F10E052
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7ahjSA9khfyfa0TeWEcKUxhu5KHRSazuV6olQY3KwC8X9pruis0i/yYVgCF5/588PNDWpCD0XCX/l6N+4PWoWK/vJf9DHMiZ+EF40pqd0p0yPlxnBU/gDb8gEQw3RllWOa9X17fBfz2L8/v7wkstVPdpdTeslaAoUIsqVOtbZhGilaUxDogZJwD+uAqFNl8sd+JU5WgaTZRjYuFWMlByhj6mwfFtfoKBYGg4M/wpzYO5Hg94oAScTBM20uLRc5fiHHCXdT33bmZN9nZa8GECR++esaXHwmUtCQ7lqsGAaF1A2mmIX8eR/5qur2UJ5wbBVFU/8vlga9DvCwgMC8DbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdCmE3ziYVZ0f/7FpBBP/OYFyqwjVvFlcnux0oSn24U=;
 b=uDOUM7n6Xg9myoHaq/NGg3XtdAPB4GyaxbakIAiHyXDF2SsaubcYJKqvW9tWwa2hlhHTbw2znP9EFwc21H0jXylB1Pm7gTO4Nm03HVeW6VhFfHf9Z32k/vgdjm9XL0HOtEuVRB7aKmbQe0HlqaHy0zoud6pYBKYOo9DEhN0gmBPRdNX13RVknPT0L5pF6XFYkDBFS9UFuLonkxV7j9XsvVROebcQpyQLl8pux8SgEJE94Z2FGiCZKBb114gfDDO7jUUtjU7EKxJ4Mrgwm3AxXMJgoZ7zZjshzpJ7nWxW1eYJDhFGmTpu4G0xPdjq0o7QfwmEVqKJ72aJKIv64yFBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdCmE3ziYVZ0f/7FpBBP/OYFyqwjVvFlcnux0oSn24U=;
 b=5OFJqLeM4dJj8JPX6RWY4Pq86Aihbjq27reHLOzcily4pYzEZswGhK3q64xX7ODuSDdVlsOqBVTpNCZDmtqrzukjOtNKyZVKbX8gYOYyOWCs0Eks67ZzUN8S8Y9HvobFfTFXgYpG28Q5IKS42ZCGxUi+pOo9XDtJdnhgijowuD0=
Received: from CH2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:59::32)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 05:46:16 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::2e) by CH2PR03CA0022.outlook.office365.com
 (2603:10b6:610:59::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.15 via Frontend Transport; Fri,
 29 Aug 2025 05:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 05:46:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:46:14 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:46:12 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 0/9] drm/amdgpu: Add MMIO-remap Singleton BO for HDP flush
 v4
Date: Fri, 29 Aug 2025 11:15:51 +0530
Message-ID: <20250829054600.3983267-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba5b2a7-30f2-4582-9060-08dde6bf5e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N09DaGUrZGVGTkNRYlJzUlNEdnNNazMvaHQxZHJKNU9YcVpaNCtGUWl2eEJU?=
 =?utf-8?B?THNUYXp3eXo4ZjdnNTVCZTdtUXptcU5IY1cwdjRoYlZkNXBxNFUwZ2ZoRitM?=
 =?utf-8?B?U0lLRFMwczY2WXpIak5wTlFXSklqS3ExZUtPSHlncGRoQTV3RDE5Z1NzSFdZ?=
 =?utf-8?B?aTNNajZ1Q3BkMDRoYjNoa1cvQlJ0aXZESjFQeld1ZHFrV1R3d2Z6TWUxdUNH?=
 =?utf-8?B?OEx4TW9WRVVPYzhDLzhwMWZHVWEvVDlXZ0w3TWZGcmkwWkYrb05pMllXcmQ3?=
 =?utf-8?B?M3hQY05lZ2JDZ2l1d0k4VnBjbXcwK2w3ajAxTVlWT0xwR0ZnTDVPdm44dXNs?=
 =?utf-8?B?Z2ZVZVJXSXFEbDI4R1hHRXRrSU9OTVpBUkxRVlZHMVI5eEk1MGRHWW9odnFE?=
 =?utf-8?B?cmF3S09PU0gzWE1rV3h1S29ac1p0aHRXK1ppTmtySzY0VGtBRXo1L05PUDVU?=
 =?utf-8?B?VWdHVDA0NVZwTVdDOC9jbnZ6cEVDL2pMNEJDWXJlbVJ3VXdYcmplQVVGa0hR?=
 =?utf-8?B?T0VoQ1JZNVBRcE84K2hSTHhoV2Jzb25CR1lIa1NCc1BpZDRXamdqdlVRbDVv?=
 =?utf-8?B?VlAwaDVNK01jd0Rqb1dRd2w3V0xZS3YzOEpPd2hubGhveTFmald4Vks0Wm1o?=
 =?utf-8?B?QVEwNERJNjdvNUpOVERpM0ppLzZ4RzFtbnRFR2trMnozclp1WGtuaFFaQUlJ?=
 =?utf-8?B?a2xUd3BsamVSbnRJMnJkRS90d3dpdzJaWkMvV3pIQm44VkhTcWdtWm1VVGFI?=
 =?utf-8?B?UytaaVR4RmJSUkVHK1RHNDhRenJqVWNBU3gvb0dnNHowTjRpRHU0clo3MitN?=
 =?utf-8?B?a2FOYXp2L0VLNEwvaEtqaWZWUW9LcFcyVDc1cU00eEZSeHFrdmFNLzBzeTNL?=
 =?utf-8?B?akxCRlIwcW9RSzVBS3FVRU1WUG1OQnVSbkgyU09KREVCcDdHeFRLdE5qM2Mx?=
 =?utf-8?B?QzBjbG1ia3VvRXhCcG1XZWdCS3RSWkIzMzZUZHlDVkwvOUhqV25jbTBKdC80?=
 =?utf-8?B?VURLdnVmMWtCSUd2WDgwM2hEVmxEMFZFQ010SHM0NThvYitYYVJ4Nm4rWm94?=
 =?utf-8?B?VDJTZytWMVBPdEdYeHRyOUxqMlpBenZLdW9kYTk2NVRZc254R2pyRjlsellx?=
 =?utf-8?B?eHhKRnRhQ3cwMXpvSjVZdU12YnJQOHVLbVlEVzlrUXBzVnN1QU9PTUNCMjho?=
 =?utf-8?B?b1U5aFhrRzB3cWIybUZtdjNwdTIydmtJbDE1ZlFhSDBKYW85Qm1ISHFkWVpj?=
 =?utf-8?B?MlRManRkMHE0TG5SZDZoVU5ZMFFsYmllRHdKbGJLOHBLZGtueXdrS1IrbGVY?=
 =?utf-8?B?U3FOM2ZxTlpXVmQ5aDJMTThxZnZoTjVDM05DWmdpdDF3NkFkNUFLWkNBUFNF?=
 =?utf-8?B?MEpLbmxWeXA1TXR2L2p0N3R1YkJSNkNlQzNyRHpEL0tMQldyRHoremVNSnJy?=
 =?utf-8?B?RUpLL0VLNmV3QVF4VDFyMTJRWEpEK2pWMmYwSkY2eXRUS0h1OFhOakxUNUtP?=
 =?utf-8?B?WmRXdWlHelJhUS90ZGF4ZEQvaTJCM0J1NkJMbWNSYkhsSzNVanFpK0VENUtv?=
 =?utf-8?B?WmV1cmFuQ1JpaDBxcHF6and0OENsS1NQay9YUnpIaXRMdnVXWllrMFBEam5a?=
 =?utf-8?B?VkFKUFp1U0w0UlBCR0NZVm1iZityNFViNDBkaENsQzlkUUZaOEFKWDdGRkJ1?=
 =?utf-8?B?LzdKSlhHNGdWa1c5M0tRTWQ2SG5RYUpuY08xWG4rRGFPcHpvRXhFT0NWWUNE?=
 =?utf-8?B?Z0kxUmNaa0JPdTdLSFBjSzdxOFVvUzFjeWhCVG5vVmxicDNDSlFkOVQ4RXNr?=
 =?utf-8?B?YngzOWdVYVBtL0RJSC9yRVpqNmszbC93Ri92bDVyaGtwdnVzVGwxbmpreEhS?=
 =?utf-8?B?aHZaTURVY3ZmRUo0MnMvaWVCdnZrTndrUHhoM1o0d2Uyc3duYUthK0I2S1U4?=
 =?utf-8?B?RUJpWld2cFk5WXBuZmVhU0Jtd0ZERDYybFJCY29IVnUwdCtBa2RkNkk4azhZ?=
 =?utf-8?B?UUc5Ti9vT3R3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:46:15.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba5b2a7-30f2-4582-9060-08dde6bf5e9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
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

This series introduces a kernel-managed singleton BO representing the MMIO-remap (HDP flush) page and exposes it to userspace through a new GEM domain.

Design
------
- A tiny (1-page) TTM bucket is introduced for AMDGPU_PL_MMIO_REMAP
  (mirroring doorbells).
- A singleton BO is created during amdgpu_ttm_init() and freed at
  fini().
- The BO is kernel-owned and never evicted.
- amdgpu_gem_create_ioctl() recognizes the new GEM domain bit
  (AMDGPU_GEM_DOMAIN_MMIO_REMAP) and returns a handle to the pre-created singleton BO, enforcing size/alignment checks.
- Userspace thus gets a stable GEM handle and can mmap it to issue HDP
  flushes.

v2: Updated review comments from v1. (Alex/Christian)

v3: Updated review comments from v2. (Alex/Christian)
[RFC,v2,1/8] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP | https://patchwork.freedesktop.org/patch/670410/
[RFC,v2,2/8] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement | https://patchwork.freedesktop.org/patch/670411/
[RFC,v2,3/8] drm/amdgpu: Wire up MMIO_REMAP placement and User-visible strings | https://patchwork.freedesktop.org/patch/670412/
[RFC,v2,4/8] drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device | https://patchwork.freedesktop.org/patch/670415/
[RFC,v2,5/8] drm/amdgpu: Implement TTM handling for MMIO_REMAP placement | https://patchwork.freedesktop.org/patch/670413/
[RFC,v2,6/8] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap | https://patchwork.freedesktop.org/patch/670414/
[RFC,v2,7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton BO | https://patchwork.freedesktop.org/patch/670417/
[RFC,v2,8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton in GEM_CREATE | https://patchwork.freedesktop.org/patch/670416/ 

v4: Updated review comments from v3. (Alex/Christian)
https://patchwork.freedesktop.org/series/153610/

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (9):
  drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for AMDGPU_PL_MMIO_REMAP)
  drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
  drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
  drm/amdgpu: Wire up MMIO_REMAP placement and User-visible strings
  drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device
  drm/amdgpu: Implement TTM handling for MMIO_REMAP placement
  drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
  drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
  drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton in GEM_CREATE

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 62 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 84 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +-
 include/drm/ttm/ttm_resource.h                |  2 +-
 include/uapi/drm/amdgpu_drm.h                 |  8 +-
 10 files changed, 171 insertions(+), 7 deletions(-)


base-commit: 6b70b6008d812a9a210455dd55459a21279bad1e
-- 
2.34.1

