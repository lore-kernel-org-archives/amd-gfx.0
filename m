Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E586E63F3F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 09:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C385510E1E1;
	Mon, 16 Feb 2026 09:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jxB1eMct";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB52610E1E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 09:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiQZ8AsSfxWxNah+/Kk2Fznn75Cb8lt69HkFMlOAN9Z+pv5nve5babcyt/E6AuRq5dHeX87TQUrf2Q5zV4tXN+/CsrD8MNjIaNIh4KHjQw/A19xkaGKR/hR3/BlrvxjCLEEcBBj7Q+7QY0LSdffgUkY4s68/b0yYubK2iyWGbdrslCB98vTYgSc3kJXtjWFUhh95nc/k2qK4X/E+x9KUYhF0h/w6d/MHAzfgRaud0Yt5pp8S3LRuJt9xSVCPXMIQr2oORQd1lub12imMwewbyVdhRo6DxvUezAalI8l8a5dXrq0uQtD+7nf2h1vf3bAv5Wp35Hs0TAW9IUZtxPEolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEyfTYgdrhoB6+0YnBnWa2HYJx+wX+o52yYp8sliEI4=;
 b=ZqzSxUe6rCoW47s0XHVEWg/u60l907bNLCMtkeBthK4MRg6X3xbk233favGdeQLd8oQRydTm2XwhbekmLyGyg0h9fwdaZWvuAC+Ms8WUsjsQqtYvEeEEXVua/ISDlOUdl2GWEkur+7kS5HD5LYz2yjld2camS3ngOOJTzOWTh6m3wU8PK2+EWjWEDiVPLDwJhYnokkJcClt7alrBivj/McS5BlICt99H/btHFZvL76Otabwy32cbNjmrMhX3CgYyFiOyoA/kDgcMKiEaGz5avzFP9TXlsMEdfN6LsuTdystcwdweS51AHqkI9kNNTgwNgKd08qkqyXlxDsUfHBcWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEyfTYgdrhoB6+0YnBnWa2HYJx+wX+o52yYp8sliEI4=;
 b=jxB1eMct1yf7qNLEJ2jyWGbjGFWfFYskiuh06An+Wfh7U1v6W67dyHWU5s8nViYxXl3/EmmY/DJv2jFiihxT0+kFdyDPAMcewRSBzdV9IKX8cdVqYW2RqSMFaGerZmAlykCLrhyBy7Kj2nd/Xp8n+ycG3kS2FyaLj73Oq64pa4g=
Received: from MN0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::21)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:45:30 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52b:cafe::4e) by MN0P223CA0008.outlook.office365.com
 (2603:10b6:208:52b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 09:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 09:45:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 03:45:27 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/4] drm/amdgpu: Render-node eventfd subscription
 infrastructure (toward KFD/KGD event unification)
Date: Mon, 16 Feb 2026 15:14:43 +0530
Message-ID: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efdefd6-58b8-4dd0-b765-08de6d401ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UitaVFNmb01pWkZ2L1B6R0hGSzF2ODdOQXdTMlFOMkxkTXNqNlgvbmVYMVZP?=
 =?utf-8?B?SUMyQytuc1RCeWdrUnQxck1hRjhlSlM4YmFEUHlSY0V0TXBreHJQYzZnY2Vt?=
 =?utf-8?B?M3crVVNIM1kxQVNBUjlSR09sT2haOGhGdkhVUU5lSm5ycXNsU1dxQ01EVGJz?=
 =?utf-8?B?a3dPWWx3dmZnL0NCdXlWSGZSV0laNC85SU1RNGtPNkptM2VSdTUrVU9PRUVC?=
 =?utf-8?B?N1ZqWTJpNTVrZzlUSWdabnNSVTg5aTRHOHUrNjNHbkpSYTR6ZEladlNlT3Bx?=
 =?utf-8?B?MWIyVkNxQjV3ZnI0MTdrbFdIYmlobldCOEZIZk1TN01FcHk4Uk12c2ZvdzlS?=
 =?utf-8?B?ZU43OW04RWJsTkJxVi9CMmdkTllaMDIzb0ZDcGVnQ05SR3JkK1lXaVVpa2VE?=
 =?utf-8?B?VmRsdG01VGI1QllHbS9BaElmRERRVTgzdklTRXRyY09zK3JjNkZpVEhOa2NE?=
 =?utf-8?B?Q0hQZFgzVG1Ua0FVYzM5Y3BSei9VR3NoMjBIVTJ3RG0rRzM1ejV5djkzaEFJ?=
 =?utf-8?B?QlZPK2lXOWNzdFRMcEJrWGd0U3VYY1FsSHV6U1ZYNE9iOVlMQmp4WG8yWG9L?=
 =?utf-8?B?S2JHZGxUZXg1RnVWZnFqSTBEUjdFY3FKakQramZWNHBraTBMcURXaGZRdG1u?=
 =?utf-8?B?UjQxNUFVR2Q0MENTNlVTdmphYkVMYW9hVm10UnAzSjJ3NTdWaGc1WFdFRkNG?=
 =?utf-8?B?Vk5DSDRWSXlmZS9EMU1URlhCcUNyQVcxejNrQWJSSHZKQXIreWJNK0lIRG5h?=
 =?utf-8?B?UU1XMkp5YVFUcjk5WmxVcTYxNSt4cldDTlZrOEgzYnltakFIeXdrenJVK0tN?=
 =?utf-8?B?ZEJzWUI1ZGF0TERuKzhYd1RzVE5NZ09tYnNhRGdaUm1MYk5ra0gzYlN2bVVy?=
 =?utf-8?B?Rmt1anFVbnA5NkwrZXpQOTF1SkMrbmdQc2RnOWJTdndKWkwvNmNKd3c5bW8r?=
 =?utf-8?B?YSttdlhQUGYvOVY0NUtLTlhCQjVpWkpPZ3NWQ05WTFZreDFXb0llalhRV3hl?=
 =?utf-8?B?MmxiTUg3UHVmcXlXdjNPRm1FZkt3dm5Jc1YwbXlJNy95SDNEdG5kWkltNFYv?=
 =?utf-8?B?ODhndDVGeFFyMjhNdEIvSm45YTB0YktDRDZTY0t6OGJrbW9NQTdtWlo4d0Na?=
 =?utf-8?B?aFJyRDZ2a1BrMG85SXF6S2pJTDZLQklzNld2UjkzREtkVWJ1NVVlVlMzdVd2?=
 =?utf-8?B?TnpQUlVqellHQlFDL3lqVHQ5NTYzRy91cHdkYXFBUG01b3RjdDVzZVQ2V2dU?=
 =?utf-8?B?VkFobnlPekRCVThuRU9BOHo5UUg4cUpmVk5ialZOeXArWlpNQWNLRlJqU1Vr?=
 =?utf-8?B?MDhWajEwajhXQnZNdnRnVEZ3UlR3dzRtcGNKWUs2c0FLWlZDVUF4R01YM1ZU?=
 =?utf-8?B?eGFNeCtHWHU3dzU1cUZwd1Qyc2NtVEFINldPNEIyMkF4cGdVRFJaK0xoOGIy?=
 =?utf-8?B?bElQVWRKTVEzbldocGllNkozai9PQUlYaUlWcHRuQnIvWUNiWk01RmtUNk03?=
 =?utf-8?B?NUlDaWxqUERPMU84S1NxS2dna0Z4c3FhZVB4UU9uTEdpbkgyVVdIK3YweldJ?=
 =?utf-8?B?QlhvVHYycEFGV2UvUTdaNUFvVHVoOStmRENpdUx2Z3Rxb1ZrWVV5R3lZd0xK?=
 =?utf-8?B?Q1ZEdHMyb0IvSWFOdVZYWDRHdjNlb3EwNnZPalBJWGs0OGxkNFFUQjVsc2Y1?=
 =?utf-8?B?RlFCTHpob0N4K0s0YkNlT2haSStwckVNZEFlZG5NVlZzbzFjdmZoTlFuNFFJ?=
 =?utf-8?B?THdvSndCK3RPM09Ed1Q4T21nZWZIYTVRWjBiVzF5bFp4S3p1UTVqRmxwZWIy?=
 =?utf-8?B?bWZrQk9WTnhDL2JSb1VoSk1ITnhtbkpKeWpxS3ovTU8zUUkxSmNaZEwrc09I?=
 =?utf-8?B?QlJUK1BvMXROK2N0NFkyU2NJZ3l3TTN4d1VwOFJ0djdicWJ2NkNRYjJWdkY1?=
 =?utf-8?B?MlFURCtIUi9SSklvZm9SWUlPMUFQUXIremFqYnRJaWxLUDdGR3N0MHNMZVVH?=
 =?utf-8?B?TDNrVmp6YjRGUzNDcUNOTjIzS0NNN1MwcXQzQWsyeG45WEd2VkZ6dmFscUto?=
 =?utf-8?B?N0wyR2tQWmYrUHp0MEtJVyttSStMSVBGMmFGRlltaWxxK0RUZkF6RnI0YXRY?=
 =?utf-8?B?UEkwUmtEUHI5NGZPNWZ2QkdteHBnM0xkV08xMzJrZ0hud2h5RmExVjZhYi9T?=
 =?utf-8?B?Q3hzV2JLNmRRb0NsaVpNNFhJWGhkMFdlTzl4dGp0OExOMCtueTh2VmVuWWRp?=
 =?utf-8?B?dWRDR00yK2xpQi9ERVhXcnkrNDV3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wdtwvFYVgXlcHTXIW6Dk/PGouyqBs1cgdz1PqYo4COPXwsP6aKIv6TpX8cCfnbpb7XSChWheifGRHU6MI5OM1yXuwSqj71uu0EqvBn4Xq6yyGUbXecDMCSgjVmFiWoaUTTGjN66ps74HKYh7kxAtuLEJFqs6ht56WgioBzEoyHd08JUAt/z+FW1vhbnYj9de4YSVPGKvK9cEyKPYz7CoEPmoq0jTjq+xdGRnqW6/ouEgCuCQk1ujmmKP0Xy4XfiYeeDiLr75sdOPvhjdhwEortuvqYrx1faLztr7l0yjgf6Rmsms1mwydSgEp9qYBGJyWWwU1mFtgXjFOa33jpgjyS8xksPcmqHJL7H6GcnuR9GkQXe8aJG8wzmk3sfdyhfwai+/iPURbGGxfYA3OqiXAfzbLvnJEGsBG8OD3MFKraZleGeWbXlwXNLAC4hIS3zN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:45:29.6533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efdefd6-58b8-4dd0-b765-08de6d401ee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

This series introduces a render-node based eventfd subscription
mechanism in amdgpu. It allows userspace to bind an eventfd to a
userspace-defined event_id on a per-drm_file basis and receive
interrupt-driven notifications via poll/epoll.

The goal is to move KFD-style event signaling semantics into the DRM
render node path as a step toward KFD/KGD event unification. Today,
HSA-style events are managed in /dev/kfd. This series enables similar
functionality directly via /dev/dri/renderD*, reducing duplication
and moving toward a single kernel event model.

The series consists of:

  1) UAPI additions for EVENTFD bind/unbind ioctls.
  2) Per-drm_file eventfd registry stored in amdgpu_fpriv.
  3) IRQ-safe signaling helper using RCU + lockless xa_load().
  4) Minimal producer wiring on GFX11 MES EOP IRQ path.
  
 
High-level design
-----------------

- Binding is per drm_file (per-process / per-PASID).
- Each event_id maps to a struct amdgpu_eventfd_entry containing
  an eventfd_ctx.
- Bind replaces existing mappings.
- Unbind removes mappings.
- IRQ path uses:
      rcu_read_lock()
      xa_load()
      eventfd_signal()
  guaranteeing lockless, IRQ-safe behavior.
- Teardown uses call_rcu() + synchronize_rcu() to ensure safe lifetime.

The MES EOP wiring is intentionally minimal and uses a fixed
event_id as a proof-of-concept producer.

Srinivasan Shanmugam (4):
  drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls for render node
  drm/amdgpu: Add per-drm_file eventfd registry for render node
  drm/amdgpu: Add IRQ-safe eventfd signal helper
  drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node eventfd

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  21 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 137 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   5 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  14 ++
 include/uapi/drm/amdgpu_drm.h                 |  35 ++++-
 8 files changed, 219 insertions(+), 2 deletions(-)

-- 
2.34.1

