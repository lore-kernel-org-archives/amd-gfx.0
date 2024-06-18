Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BECCC27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15F610E702;
	Tue, 18 Jun 2024 15:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BnH5XUvL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90EDA10E6E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDo22JNw7xkZAxHR1omt4MlE+t2k0iRiJf2aNHInNpvf8xeLzWq6qL3K6KyqtP1WVfyytn+Vq1dFBVFZuoyPTDsCsMx7LembIV70qsuJYrSCo8KvTJDfr+vPdOcJYea2BERtqSKgsHA3QCOKobfDlZqPJYgxDTMVo06WGoF4bPL+KaApH+zwMHQjxwovaAIRpDePsUuJKS9fKwhjqf4P8Xwh+/9sMqTk0SieOsMVpAwN7zgUG4EU+T8wbqZvObaZqZ7O4ivMjlSJBt+CUpdgG1YXRLTWwJ2E0t6ZPCoMxbQRRQCed+4IsDwmmXLfILjkj95zMgb93cgcojnCrKeMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxah37fya80A0wPT0pPALAxolfR8j5TtOJhpwAMN2/c=;
 b=fa6T+yvRVgPVNURzk5cg8Li5H2T7vy5+0vg1++gMpWRmcUDrPMykrIq5JZWBqFgHHSg4ZtK2zB7TLkFWwaGmsTakd3VmOIr/0/7LunXTTHO+AMQf84OIG6HElN21nxJyq/nSJIJOtcTS8TW+qDFx9YXS/0wWbzZoEIRtXfNcbqHkmhjuk6bcZPJoA+Z1nQOQajIzeUdc1w1h0XuAHw3zz9hEhPFp7n5b7Sx/ZDQggC1iDZ5u83kbGjCgMgKGN6+I92LuLD8sOQLnPbhTOPWfJRtm2Jinvy92AM1h+kbnyp5FcXe/D8IAydX6rD/QUukxUwpFZADWZE1m8YtlZeqoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxah37fya80A0wPT0pPALAxolfR8j5TtOJhpwAMN2/c=;
 b=BnH5XUvLg6IvdNB/7ke36jiNcA+q0AEECZVCGQ+IoT18P6MIbUM292aXLFldgIbtBRqsIt3mWV6jEaZrzgzDbmUaIY7l0L9w7PgjCNT0Mike+F6zoRvRmrm/lw12NmjLg3n+vuCWDm22lG5d2K5qihIeCgtA84i7nn4ns9nWTKE=
Received: from SJ0PR05CA0182.namprd05.prod.outlook.com (2603:10b6:a03:330::7)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:30:25 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::c7) by SJ0PR05CA0182.outlook.office365.com
 (2603:10b6:a03:330::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29 via Frontend
 Transport; Tue, 18 Jun 2024 15:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:30:24 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 10:30:20 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 0/6] Reduce the number of GPU resumes
Date: Tue, 18 Jun 2024 17:23:21 +0200
Message-ID: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c02dd4-20f0-49e6-ddc0-08dc8fab9304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?id32bh2gyc10ice6x068DxpGKxG45LoZ5eugsLUhuq2VuKd66QiyYVh2JRfW?=
 =?us-ascii?Q?4Uc7LfEq4eB+Cv6zxIcPN3DZRTz4yi35hSB79XLcx/7Rt1IEQkX6d1BVw4Iu?=
 =?us-ascii?Q?dyzfbmAHjykBR59y9ZFQkknDUnAbG/twSRQwm/kvIhjUK4wfz7frlkeqo4XK?=
 =?us-ascii?Q?eqNq12JacuHfOcDnmIc3YoyndUzkMOnr/iImRrtw0pCbL9vwta7GFPX8TSwD?=
 =?us-ascii?Q?hXrq4pA/QfNk+15iUsrPuPrCvF8PielHgwSe6gidNXYSZEKR4mlVYOLM5RSK?=
 =?us-ascii?Q?w3oPN4teYE9/oVcNQxV8N3ZvTCDWO3wQVAZ9xmy1YFqHBj7/J36FUISDrYqC?=
 =?us-ascii?Q?REPS5jsVFdnn3997v2ikJq4MBDck8cfNzNQBYUUvy5h4H/nXya0MJcd4MNLx?=
 =?us-ascii?Q?iIaHxDsqejsyABCvVMff6rMf9uEGu04ELMDXibTJx29nNhoqRHslpH+LsHGG?=
 =?us-ascii?Q?MKJuRmq0jmXehd9imj6ygjnvOslWzjS2L5bFrOP1hYKQeqOVVbxiqiaMHCWc?=
 =?us-ascii?Q?A5uxno9aqcglaaTiJGKr65oewKFQQ9n3c2Fb21pT2hlLVkW/dZ6m1hZkec5D?=
 =?us-ascii?Q?K9ErWyWri+45KFbZFq0ey8TkmOfEpyZ3BL4fXpvdeJ1vrStXW1JrP2PlZb6B?=
 =?us-ascii?Q?6jkGDWxMOiiVWziRDv6bmXFG9Shfu9swVEHhxzcZlfoQ39it1EBXQdAoKQcx?=
 =?us-ascii?Q?MyweuOKZ1qgO/hHIEX+1TozQxHHWxb47CnhNMVElYVkK5rdLf8kkCi5RCvNl?=
 =?us-ascii?Q?mGMA6Fxcdd2CgJUMtweDom145XGyhRCudLUAPnjQ+5kGveVMhBW1MG8TH9wM?=
 =?us-ascii?Q?Dtj9mXsYNztXUNX2WKVslEirQlRm7E5/8RnM7b+g9+DogzX2DZvys6M9r8/W?=
 =?us-ascii?Q?5tpWPCaviQJnwTh7wbvJhp2WkHMTqyR/5jkDDbyJhtLjaHT7mdKJxK9DHVgh?=
 =?us-ascii?Q?NmwXksPGJi9mv4jhibjgPWI/2OAVhYSArc+DUrXMa/kKX+yaThyRyzIKGcwZ?=
 =?us-ascii?Q?Qt1+OOPSsKVkaX1p0GhWCr72Bga5m+aoOYSq9utSxB/qHMr+MzYkhy1ngQbQ?=
 =?us-ascii?Q?9lybljJDK8BxSw7KpMiZueNPg8/qqVCEDE/o4AiEz4D3RA61Lf1SJwDo9D7S?=
 =?us-ascii?Q?aLwW3io7XfzdR8uVWPAPeTGwW/u1Gr8ITDa4L9RSPZOm9etE5XblQ+yftioK?=
 =?us-ascii?Q?CQ9OKd7cS2PLyYZ107VpO5cyrvT/zDSoyVsWWjjD30BgP/gxri/+JHxa2Oxi?=
 =?us-ascii?Q?zMoho+c6cwGxHlCx82AYYs5LZ5Z3Cf8hcjlC91gwezVDYVhiqLSMzvs1+Sz4?=
 =?us-ascii?Q?NIgQ2tBYsoAcgg2Vjq94+T8Ucc617OFxZ5hbH9YjYv64GhGQBrvWw9HO1ml4?=
 =?us-ascii?Q?MlkEmh0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:30:24.6954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c02dd4-20f0-49e6-ddc0-08dc8fab9304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
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

The goal I'm aiming for is to be able to open a dri node and use
amdgpu_device_initialize without waking up the GPU. One visible outcome
is that it would become possible to call vkEnumeratePhysicalDevices
without having to resume all the GPUs in the system.

This series implements some of the changes required to achieve this
goal with a focus on not waking up the GPU for ioctls that don't need
the GPU to be active.
The output of AMD_DEBUG=info doesn't change with these patches applied.

The other changes required are found in following patchset:
https://lists.freedesktop.org/archives/amd-gfx/2024-June/109796.html

Pierre-Eric Pelloux-Prayer (6):
  drm/amdgpu: allow ioctls to opt-out of runtime pm
  drm/amdgpu: skip runtime pm for selected ioctls
  drm/amdgpu: refactor amdgpu_info_ioctl to allow finer pm
  drm/amdgpu: add AMDGPU_INFO_GB_ADDR_CONFIG query
  drm/amdgpu: cache mclk/sclk min/max values
  drm/amdgpu: resume the device from amdgpu_gem_fault

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  69 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 116 +++++++++++++-----
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   8 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  12 +-
 include/uapi/drm/amdgpu_drm.h                 |   2 +
 10 files changed, 198 insertions(+), 57 deletions(-)

-- 
2.40.1

