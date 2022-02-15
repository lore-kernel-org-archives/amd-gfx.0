Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378D2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C464310E297;
	Tue, 15 Feb 2022 21:23:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36FCF10E1D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VueF+WKIyj3W2s7DVf9ignpfc+IQtUkp7YG9IskVO/5tIg7xDWOsrEulS/PT2jZb9AXYJLjn3X0qnJphid8HxLFhYp7TglCWyImEe2kuf4RqBMAZiehAGuY1+ceZE7eske1Z5luQbJLFvDutx1kFowKE/+BOILp2C9f0V9E4T7NZQkbd1gp+03FqP22ywVe9VM3FIHqBXwQL/xX3Mtj74yKCudXg3RqU5rAGlzax99Ej2txrriJKMSZ1blsRWxu5xI01WvDVeUkR5/N+heExnoPt+eUeNF3DDaw3qiHOrC9ttc2Vd+N+j+ERM9A0uAsDEM+JH+if/jbmOsuZ+sGABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ygkBK9c8EPwVaPUXXV6x1Surd99+OY2NE9tbzQI5jg=;
 b=F1byqZ0SAJTMFTGAIvx685pRNVnDNFX7M3aZ3d2cjNJKFk1+Ze9LqF9JVrqnVYTWpVGm5RiFrP3xr7iLr/aCkTZ7VBlqJMHNWMw5SaycpfjUDQUHAimXquzlG//oYng7wWx4eLytQH0AZphwZLQYi3Wvjgsr6cZwaZUeU1UYymGOygy9oBLo+BX7r//xsngLAoBN+hVqyj20em2Ho1ViQLA4TeAvc0PDmDYqH/wdpKpIcqKxOTDle50KC9U1kVPnlM667Hu7P3jvDAuceH0KqQ6z2nrRfL6CRim3ogO05jOrYCtiyam4H7EMwgDZK6sn1wNUC39c9Lqc7cvpZ27QJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ygkBK9c8EPwVaPUXXV6x1Surd99+OY2NE9tbzQI5jg=;
 b=Z5d10xyjHNbuAmMu8RsVvyAbt0UGNWiDWRB8r1LJdX97g/rQGC27nyIkw8F8pb0SLbcaCNWTdf7UmRW+YUFDRdGIf5S3jNIGtouWA6AwKThhaED1edfqQ5WdDK3BR41sRDjD0Rd7PMGaX4U7UsXrIlf11bbQ+keb2R6/RN901vo=
Received: from CO2PR18CA0055.namprd18.prod.outlook.com (2603:10b6:104:2::23)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 21:23:04 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::87) by CO2PR18CA0055.outlook.office365.com
 (2603:10b6:104:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:03 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:02 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/8] HMM profiler interface
Date: Tue, 15 Feb 2022 16:22:39 -0500
Message-ID: <20220215212247.16228-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e5703d-d681-4552-b21a-08d9f0c959f5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4919:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49192CD3AE8E8C54690BD61EE6349@BY5PR12MB4919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aVYgVPvWt7W2zXdrlt52mIQ33tpf0Nlb/2dKPGRNfCCisPWmp/moN3VaT0MwM5MHxrX2pxc+1EOqLGGkoCuyj7L9iws59RPbAVxQLrqWaxf7+IDJVysBvNLONpxGM2vg7Dm+6+KguzYKS6qGOHRFVxwffHxj+XyPMqTEQLAkpa5OR0OIYVbbuzz9QLdsnMd8huZJNfJnZS6wCZyEUQOCj6ryKgjOmTipPhai9vxWpLMfNuLjCgspxsqb0JTjsUr/bzeNboRywViY4rMG4Cj9GrTS9TxwKxWDySqpyivHwvG7P50mZUGCc5wbYS5Jp2CHQ5wWhlyRkRopV9nSvOMwDFoy+FaNaci0vFMlLlHztwFa3BV+On3aPY/VvhZzXGDj265jJsWPdkxDyPA4IZ0rPPrI/eKmtVtxl6xPztb1RIzFnZCPh4EawcXGSbUbB0OGmgYiFyecdNadLnTA0v35tNAURtMdh+ioxds5ocaJfwVa8xw2x4ztjSRwXZu9XGo8ESub+2KuZtbr+EsOybjcS/pcMPGyNUsSpwpI3rfZC7sfuZc51RW8YVVGKMEz1+1PPNdGYfgqRdZY+jFBGxlxVFXUs+vFL7DjfqlnfeftY7pDRI8x9iSEr37SvVySY/bg5eDCVKnPD8WDUjTVoNzNMqDdNIm/aWjChfC4RSiywQoPNH40GFS8bOSCvmAT88XBGXSh3pPNeSpU+EgRlr3izzZwuyf9wD/qy9tlGN+gRjNs+i6T/DTj5sufsZaoihYKHz1ueNoUsCxZ/xFVVeSIiEfnyqQNY0g5HCLDYPlT8I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(316002)(966005)(16526019)(47076005)(1076003)(186003)(26005)(82310400004)(54906003)(6916009)(36860700001)(2616005)(356005)(81166007)(83380400001)(7696005)(5660300002)(6666004)(40460700003)(70206006)(426003)(336012)(2906002)(4326008)(8676002)(70586007)(8936002)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:03.6440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e5703d-d681-4552-b21a-08d9f0c959f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This implements KFD profiling APIs to expose HMM migration and 
recoverable page fault profiling data. The ROCm profiler will shared 
link with application, to collect and expose the profiling data to 
application developers to tune the applications based on how the address 
range attributes affect the behavior and performance. Kernel perf and 
ftrace requires superuser permission to collect data, it is not suitable 
for ROCm profiler.

The profiling data is per process per device event uses the existing SMI 
(system management interface) event API. Each event log is one line of 
text with the event specific information.

User space usage example for rocm-smi lib and tools under review:
https://github.com/RadeonOpenCompute/rocm_smi_lib/pull/96

v3:
 * Changes from Felix's review

v2:
 * Keep existing events behaviour
 * Use ktime_get_boottime_ns() as timestamp to correlate with other APIs
 * Use compact message layout, stick with existing message convention
 * Add unmap from GPU event

Philip Yang (8):
  drm/amdkfd: Add KFD SMI event IDs and triggers
  drm/amdkfd: Correct SMI event read size
  drm/amdkfd: Enable per process SMI event
  drm/amdkfd: Add GPU recoverable fault SMI event
  drm/amdkfd: Add migration SMI event
  drm/amdkfd: Add user queue eviction restore SMI event
  drm/amdkfd: Add unmap from GPU SMI event
  drm/amdkfd: Bump KFD API version for SMI profiling event

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  53 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  15 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   | 188 ++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  21 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  68 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |   2 +-
 include/uapi/linux/kfd_ioctl.h                |  41 +++-
 13 files changed, 353 insertions(+), 64 deletions(-)

-- 
2.17.1

