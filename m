Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B38D37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C120C10E81B;
	Thu, 17 Oct 2024 13:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEHTey2J";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC02010E81B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAOy5F5d2U/x0a8hpVcnLNum1WSJ/7ka19by8x1vATSKYcrak4iomsLtqnYCxgnpSeZAMVDu2wiM/1FMcJq3MkfF/BU9qLTrg8+TGdPoZS+Ifk8aclbufz3rJEARpUeKrsyu7lrmKZZGk/t28Ka+SWEdaNZfluIOJPToSN2Vkrug2832LikqSW4pOoWud3QEXmVeDH8iEr2t9fZkesjAaW26JXjSt0ZoqBbpdO8k7jbqg3/3PJZEgs70yAkxGA2qzzMezoaEqH5U6VbglJnoY9Cojl33Yp+bfwMg981AC2YL8pU1UKvhd49W1JE+sRMYWKs26APwlIqXtJ38zMEzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfkeNL7GbYJ5aEwCmc9E1/I9nHCFftxU9QThTxOjXDA=;
 b=psz/ZJmeKCr89W5XTo2zH3yhrjiBuUi3hcTupyKQ67g5uI7DK0VRuNjG+d2KtIgsI6HORGxut+doG43EyEK4qoWgyel7WkOCqFcG1sX8dKv+YDTm957KScKTKmVDiYEpIxWLPRJaX0nIr2uVqHyocAR5n6J6hhzeZZH5JpcwHtvdEWhBuJ/csNnP8s22Ui8j22/RaHcqV+EHEiIEzGjztDNVcc1c3pA/fQ0GgGvRaJipA+pX8F6pGe7gRaOHJpCutzyCkrvqRTFXtPOjBrXrTnC2xWmNFcEIu7oKiSFMsMSwAqKM88l6vLxFqA5GvEtt2ZYC1pJ8BDB6uDnUB1D7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfkeNL7GbYJ5aEwCmc9E1/I9nHCFftxU9QThTxOjXDA=;
 b=ZEHTey2JIQlg6K8eCv8LZNs18wpAgAs71cIb47Kg3KGE47wI5g+jFnH7OBgOiwmLsPqN/0xFL5SEUeVTS5A6nfI5pjQURLgxn4zwH92DpmDf6IG7g3l9ETRnnU/9sHFZdntVbDe4LE3WsCZkSZ+i71K6EZgHxmCzQZ5u8ZPZ20o=
Received: from BN9PR03CA0177.namprd03.prod.outlook.com (2603:10b6:408:f4::32)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 13:21:17 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::3b) by BN9PR03CA0177.outlook.office365.com
 (2603:10b6:408:f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:16 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:15 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 00/32] Separating vcn power management by instance
Date: Thu, 17 Oct 2024 09:20:21 -0400
Message-ID: <20241017132053.53214-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3547ce46-564c-40ea-bf3f-08dceeae949f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzZxZFViQzcybm1oNGFGeWp3TjljVmRXR3hlanhYZDNyWTlPNkorQU41VDM3?=
 =?utf-8?B?K3IwVzRHa1dpMTJ0MTd1WFFnc0dpUTMyT2U1NXR2Z2Q4OGRzb1R3RHp6Rksx?=
 =?utf-8?B?azRPc0NTMldlY2xwYzVvSm9lRlF6c09LMFo3YmJmTURTUktteXdRd28weHlm?=
 =?utf-8?B?WVdobEpRSzQ4dWVvRklPdTUwVFhZZVQ0MEM4QkN0UFJ2R2tJYUpOMU9td3Bi?=
 =?utf-8?B?ZEdHSEVYSTZ3VDF2Qld6emVWcHlQUFd1MFh0MDNvL1dhY1BCd1g4SWVOaTU4?=
 =?utf-8?B?V3JES21UREhJbEYwaklaa3N5N0hKREZEaVE5ay9LZGxFaVRXOVF0a0poMUVx?=
 =?utf-8?B?TGtoU0JDczFRS0kvaTl1ZEVvSnVrUnhxS3pLTk1obEFpeitFZU5NTkJKMU40?=
 =?utf-8?B?anBrbCtjSFBUNnNFejRlUUpIM0lUck14WFBRRWVTQVhYdWtlL2FSVjkxRU9p?=
 =?utf-8?B?QVNGS2RxdFNTL1B1ZjdSMUorQXhtZE1pWTJycFNZZ0ZiN3UvQ2pET2dpT3hD?=
 =?utf-8?B?T2toVWRqMFl3cmdTK1V2LzBCcVNEZSsrSTljOGxrNEI1R0w5NHVXaTlVTHJE?=
 =?utf-8?B?VVMyanp2Rkc2N0JrVzJnODV0NTZPaTIzMTNxRVNES2dSYlpOVVBpWkdxMHN6?=
 =?utf-8?B?MHJQOWxaNjZSZDU3WERjcnVVbGpXb280YUNSdllWblhuZ3NGZUsyS3V6VzFl?=
 =?utf-8?B?UVVXVGdRL2RRcUdkdWdaL1E1aHB6bkJTYlcrZFM4OTUxdUlSb2xNMERoK0p4?=
 =?utf-8?B?dFlQSW5ocDBZQ0lXcVZBT3J2VCsxdGpveUgyR2RDMy9FcnFqZ2lIRHNkMFpp?=
 =?utf-8?B?ZVVvbEJmaG94SUN6RTJVWjkyd1JQeXhOeWkwc2YvMzRUeXkvd05NaS9PUWNK?=
 =?utf-8?B?eUNEeE41M3ZBdG93SDg2ZTNXRHE5NUlDOGN6SjQxZHRuVTRDUjdzUFI5WTYx?=
 =?utf-8?B?bUZ4N28zSGV4M3JPRWVKTmRDVHQ5T1RQUnBLZFo0MWpuRUFuMytkUDdVa2U5?=
 =?utf-8?B?S3hSakJ3cTM0SVFxbDNBa3M3ZlZZbnFmcnlrRkN0NFU4Q1ltQzBrUUVtOHoz?=
 =?utf-8?B?ZE03eHFSY0VwVnhhQm1mMmJYZHRYMTREVDFCYTFoaHNRdm1BdWVKQ3RDaGk1?=
 =?utf-8?B?L1lsN1dKMXJZTVNGL1lSRUlKN0lrSkJQQ2svREYrYng5UUFwL0Jic3JxY2x1?=
 =?utf-8?B?UHNGTlVQQWFKTS85UUlFQ083WjN1d0dHK1JGcFFqQ1FnVEYwWGpXSGNnSGQx?=
 =?utf-8?B?R09Ba3hZcStMMTVzQXFEdnEzRE1uTDV5Yi9xcU5BS0p2dXR5RE9QYnFUdDVh?=
 =?utf-8?B?K1l6TnBBYTB4eWxJQjlmR21QamJaV2o5Sk8yV3E5SVU5SlltK0hVZEk0cHda?=
 =?utf-8?B?TWRSWEpiWUpHNmVUNnpmY29tNVExT2FWcXcrWmNWV3VJVUNCaE8vYlpBNUFp?=
 =?utf-8?B?R1l0MW9xRTRLV3I4bGppalR3aXh2STh0ei93NXoyemlzREJaWWhGaUF3aXNu?=
 =?utf-8?B?UmRqVkFyeUE3cnZGQUNKczhpblRyZTQxQVJrRWJheTlCR0tDYSt3NHQ5dVgy?=
 =?utf-8?B?ZWVNcWJyZE9MK3J5REVFRm96YnhpT1NTTWZ5d1VWWVQ3c0pjcDRZTisrWUw2?=
 =?utf-8?B?emE4NGY2bFZMTzNCUzA1UVV3MGlTdmZ3WjZWQVYxTUZybGd6THJ1Wk5NRkg4?=
 =?utf-8?B?T3d5WURObVkycUtMYWY5QXB6YnF1Q255d2RzNkxLQVRSbHpqTVU0eFNaVWZM?=
 =?utf-8?B?YkRiYnVURHpyMUtrTjkzaHkvMjVjZkJYTm5SMkVvQmNGWmU5cW9sSmUrOFhG?=
 =?utf-8?B?MkRVVVdsNlJOVzlkWUQxbENCTjFVOXdmRjU0YUhQeU14L3Z0YnNJRElrMEpM?=
 =?utf-8?B?b0tBOEdNMmVuT0lhR3ZFQXRkZGtmSmhTUGdlQWRoVnk0Ync9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:16.4203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3547ce46-564c-40ea-bf3f-08dceeae949f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Previously, all vcn instance will be powered on/off at the same time
even only one of the instance requests power status change. This patch set
enables vcn to ONLY power on/off the instance that requires power status
change. Other vcn instances will remain the original power status.

v4:
code polishing and minor fixes.

v3:
move all of the per instance variables from struct amdgpu_vcn to
struct amdgpu_vcn_inst. (patch 10 - 11)

update amdgpu_device_ip_set_powergating_state() to take the instance as a
new parameter, remove the duplicated function in v2. (patch 19)

update all amdgpu_vcn_* helpers to handle vcn instance. All functions
are now only handle the given vcn instance. (patch 20 - 26)

update all vcn ip callback functions to handle vcn instance. All functions
are now only handle the given vcn instance. (patch 27 - 32)


v2:
complete re-work for all PM changes as suggested-by Christian König and
Alex Deucher. Adding instance to all existing functions, instead of create
new functions. Remove all duplicated PM functions in previous patch set.
Use a new logic to track instance for ip_block with same type as
suggested by Alex. Also, fix wrong ip block index and remove redundant logic
suggested by Christian. Finally rebase all patches based on Sunil's ip block
changes.

Patch 1-6 are SMU changes to only power ON/OFF given VCN instance.

Patch 7-8 pass ip_block instead of adev pointer for set_powergating_state,
set_clockgating_state, and is_idle

Patch 9 is to track VCN instance in VCN ip_block.

Patch 10 move all of the per instance variables from struct amdgpu_vcn to
struct amdgpu_vcn_inst.

Patch 11  VCN change to separate gating status for each VCN instance.

Patch 12-17 are to handle ip callback functions separately for each
VCN instance, so that only the given instance will be powered on/off.

Patch 18 is VCN change to handle idle work separately for each VCN instance.

Patch 19 is to set powergating state by VCN instance in amdgpu_vcn.

Patch 20-26 update all amdgpu_vcn_* helpers to handle vcn instance. All functions
are now only handle the given vcn instance.

Patch 27-32 update all vcn ip callback functions to handle vcn instance. All functions
are now only handle the given vcn instance.

Boyuan Zhang (32):
  drm/amd/pm: add inst to dpm_set_vcn_enable
  drm/amd/pm: power up or down vcn by instance
  drm/amd/pm: add inst to smu_dpm_set_vcn_enable
  drm/amd/pm: add inst to set_powergating_by_smu
  drm/amd/pm: add inst to dpm_set_powergating_by_smu
  add inst to amdgpu_dpm_enable_vcn
  drm/amdgpu: pass ip_block in set_powergating_state
  drm/amdgpu: pass ip_block in set_clockgating_state
  drm/amdgpu: track instances of the same IP block
  drm/amdgpu: move per inst variables to amdgpu_vcn_inst
  drm/amdgpu/vcn: separate gating state by instance
  drm/amdgpu: power vcn 2_5 by instance
  drm/amdgpu: power vcn 3_0 by instance
  drm/amdgpu: power vcn 4_0 by instance
  drm/amdgpu: power vcn 4_0_3 by instance
  drm/amdgpu: power vcn 4_0_5 by instance
  drm/amdgpu: power vcn 5_0_0 by instance
  drm/amdgpu/vcn: separate idle work by instance
  drm/amdgpu: set powergating state by vcn instance
  drm/amdgpu: early_init for each vcn instance
  drm/amdgpu: sw_init for each vcn instance
  drm/amdgpu: sw_fini for each vcn instance
  drm/amdgpu: hw_init for each vcn instance
  drm/amdgpu: suspend for each vcn instance
  drm/amdgpu: resume for each vcn instance
  drm/amdgpu: setup_ucode for each vcn instance
  drm/amdgpu: set funcs for each vcn instance
  drm/amdgpu: print_ip_state for each vcn instance
  drm/amdgpu: dump_ip_state for each vcn instance
  drm/amdgpu: wait_for_idle for each vcn instance
  drm/amdgpu: is_idle for each vcn instance
  drm/amdgpu: set_powergating for each vcn instance

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  338 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   14 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |    6 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |    8 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   12 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |    8 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   10 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   10 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   18 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   20 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   14 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |    6 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   14 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   23 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   25 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   16 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   20 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  140 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  124 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1154 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  909 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  801 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  727 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  782 ++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  690 +++++-----
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |    8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    6 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |    4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   55 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    3 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   18 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |    6 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   10 +-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |    6 +-
 .../powerplay/hwmgr/smu7_clockpowergating.c   |   12 +-
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   12 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |    6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   65 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |    3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    4 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   24 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   19 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |    4 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   38 +-
 112 files changed, 3442 insertions(+), 3433 deletions(-)

-- 
2.34.1

