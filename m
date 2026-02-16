Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A519CE81A3A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2762C10E091;
	Mon, 16 Feb 2026 15:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PWZln9Df";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BC310E091
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGfLgB5MtwLxJuQPovrLYwaiV4DqX8Jrg5GaX8RrukJPi62GOMqw+QfdiRzV5J/mk72bbEYpFe6yAhRifVM/B6HeM5KmxLjY4GjekcaEc9OCFErhHuVG1jvowa5aR3LaOop7pqDRax6JcW752ksgFhWh5XSXq9bGBvdT0ix1KsfMFFDocxZ2fCcllzTd80N9XSbtpVb6OrsXHVa3Y0gQTtIZKGS677HntVTYoNNBByeB1S7D8TeaSTSUppctLeZB0aodl+hoxtjrxKCerXpEOFHQWXf0ji/AQs1Sodg/DYIcrqxJF4iLIcF5l5X2fKnjzHbBoLghMOlVthj6Kgy5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/GapyyNQBSpBZ1B0mlistJZjUoYwPKUKIBfFqs7QSE=;
 b=h75TCiV/1AOg5LgYs2TlPXSDcP3bLNYm8OeoI0eKTPpUTkVWAfvCqjuioI73V73NUWvDE2/ygsBNQ/eFOYRye8ztrKpj+67YsZLBM9jrBTuo/N2xfmxTtCtHTq5q64wxl2w/JD4LGTMNMK7zSTBeGLgakoNhl/IoJt4Fb9a/Jpdtvuq/ggquss1d8TzoYEFp1gNE3/JYyKM07SQdvPkTmSvvlczsu/pFhgc4l2T1ycIOfSaEtdezlHkRT2+oGjL3CQVmK6wSpBER/v+YuP8ucQkGOJ6sR2Kb+moHDghFaSHZ94yXEZV3DfZVZMpz77pcBTIqVzA9nFucwUUcN1siAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/GapyyNQBSpBZ1B0mlistJZjUoYwPKUKIBfFqs7QSE=;
 b=PWZln9DftY6vUKTiczk+vfHtMFVWsy1TRuMCzHleeUUgnLhXcFbdW8SVIV77Er4KlEFp5kKgVfJuqCn2rvhcPudDTtG2B5SxMMfxTmkA8BQFUwaVTG2XZ+ky6wVso79LUS3Rstljm7zNy39vEwB6CIg5tE9GRzOzHKcuVSd9TiM=
Received: from BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40)
 by SA5PPF6407DD448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Mon, 16 Feb
 2026 15:50:01 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::27) by BYAPR07CA0099.outlook.office365.com
 (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 15:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 15:50:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 09:49:59 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/8] drm/amdgpu: Render-node eventfd subscription
 infrastructure (toward KFD/KGD event unification)
Date: Mon, 16 Feb 2026 21:19:35 +0530
Message-ID: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: 077ac105-49f8-4326-8423-08de6d730b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUwwQ0xmbDBOVmhIWWRTckxmMzhjZVZNSmtlSVZEcFAzMkREckVoSUZsZE5B?=
 =?utf-8?B?UlBxdWp5MTFCSWk5cExhbWk2Z0tkSW5xdEZ3R3dnSkpCNVc2WmsrM0Y5N1Iw?=
 =?utf-8?B?Zzh6VjFmNnpwYlg3emFnTjAwT01sOUtTaEpEMG9OeStmUDdCL3NKLzBoUWs0?=
 =?utf-8?B?SjFkajhtZG1YL25WZ0JBQXVlOStteXFyNGZwZ01vNFViVkFxOFZLaEhJWVhG?=
 =?utf-8?B?d3k0UmRpYm1udC92d29URWNrQVpFL2wyUXJZMWQyK3RjUmpHR3ZrUVBCVDJk?=
 =?utf-8?B?VHRuSXFlMHdzZkVSYU5hVS9aN21uQkJaSmJEeW9laEMrRDl4RWhMZ0tCTWZh?=
 =?utf-8?B?Yk8yK05vSXlQU1FUc2FXblFIcUdENnRhZC9heWMzWHhMWFNiY3dMS2pwWEhx?=
 =?utf-8?B?MDBYbmJ6SE9malJkeUZISzJ1S1BJWnZTbnp2ZkRmUmVZNDFnTFY3QXB2bG8z?=
 =?utf-8?B?ZlhiRnhWdzlmdkkrdEd6d291VUczWTA1dU9PaFFVRnJkVnh0cWZIdWFyUHZM?=
 =?utf-8?B?TUZ6YzlVS3JzM2x4aHlKRlU1UExmU3kxeFBXeDlFRjBpUG9OVXB5UDhDYjZ1?=
 =?utf-8?B?Yld0MVJhUXFvd2xiRnBCZ0xaZVVPY0ZZcUpVMHdsS0pSQ2VHeFplaEJ0a1Nv?=
 =?utf-8?B?dytWcUwyaGJpZ0trZDlGdDZzLzlHS3hnNGVQR2tjQU1FZTBQZUhJU1lYOE93?=
 =?utf-8?B?Q1pvaDVNYmhHNGxsOUxlb2RvSHd5NU9PVEYzZ3pYdFBmand2bERTUm1nODZB?=
 =?utf-8?B?RGNMOWlIcmJaQ01yVmJ1VXFhL29QMUpZOUl1Q1pDVWhROW9kQ2EvYXljQlN2?=
 =?utf-8?B?VDNpUW41YldPOFFrbWY2ellqeG1UOUxHSEZEaFdGTldDa2ZRVU9OYkY0MFRF?=
 =?utf-8?B?dEw0TWVJelRMdURoNHpOVDc4c2xzcUpsd3dvRmZMRU9WeGRsTEwyWlpNK1d6?=
 =?utf-8?B?TXNWcXpkbVdDQ3kyU3ZteTdVWVJXNHp4ZkxrVWdKZ1E2TExjMVEyUDV4b21E?=
 =?utf-8?B?aHZJdUhydVJ6dTZaSFQzNzdBZVBZYTk4V3BMelFaTytiL3g2UUVQRk9lYjgy?=
 =?utf-8?B?MGJHUTFqekhhWSsweW40MzE2OURPWmxXVHA2VlkxZjBOcGV2K3B2RmtvNjRm?=
 =?utf-8?B?RGU4Nm1Jd0lwbUlQUXZUeWw4SzNUMVlNb0pFRmlLTHBVYWo4UUcvaGlNOWxo?=
 =?utf-8?B?dEI3dUdWcWNVU1pDdGc0bmRIdVQreTNHamFMbVhRZHU0bFRvUWoxOEEvLzZP?=
 =?utf-8?B?enB5SUxIWGF1dENhcTFDblhkSG5TZ1U3RzlKWHJ5RnVPWnFzdUZodVNUYWtY?=
 =?utf-8?B?ZTM4SkJYUzFoZDZTdmIzaHVuZzNXaU5WS3FOV2FsVHhNOTJUaGNwYm5uanhM?=
 =?utf-8?B?WWd3OFVBeERRdzZiK3gvRm9xQ1E1TEg0WUd0Q0RIeDJYbHhWc082eVkvQ20y?=
 =?utf-8?B?cS9KV0RZa2JKdFpFdE5lcWhsZ0ROVUNOR3k0MmQ5elRYR3hacDloTFlBNFdB?=
 =?utf-8?B?SVRoakdVM29VbmNsUnFIcmg1b3VEN1hPZHdWSzZjSjZhbzRpUXI3Y3VQblpP?=
 =?utf-8?B?RCtBazNsOWgzMHpDOXVoWHl5UWkxRnc0OVN5UWlieXk0WWR3M2picTE1NjRC?=
 =?utf-8?B?aDZoVXpvYnQvNlh5RE8rU3hnbmU3UmRKcUFITHZxRU9vb0phK2o1NVcrNTNx?=
 =?utf-8?B?YVFKanpCSGFQZzU0UEtrNFRkOWIyclE2aEtzSUp6cEpoRm15Ulh4R3Y1c01Q?=
 =?utf-8?B?T2dJUVl6NXIyZTExOVorMFRnNFluZzhYSmYrRjNzUVVEZWNNaUdqdGxkcVRC?=
 =?utf-8?B?VS9RWkc3cUN5ZEZMTUNyMGJqVy96bHpQWGVLLzJlMzF4bzYvalRtZm03VHFi?=
 =?utf-8?B?NXc1Wm9KMlFRRkptVWpzTk9rMzFEU2I2UmRvN2V4cHBwYkZEVUsvQnM5R3lH?=
 =?utf-8?B?bStSQUh0L25UdFZvb0k4djFEMHgzSkw2ZHVaRkxibi9GNWFzN2dXWWZ2UUtB?=
 =?utf-8?B?TkdudUkvU3YxbGF4d3RWcm40L0FTbjI5anF4a1FJMWpuOGZseWZEVGZMc1JJ?=
 =?utf-8?B?VW9XOE5zR0ZFT3lmRllsZUFZbjRaeVNMbElXUnl0S0h1QUxveFFtYUpZa3pm?=
 =?utf-8?B?TGZxWHpVbEJVR0JHTU1WNDJmOEVjU3hPanNsU1IzOXJhNzlTUzNFUVJqcGl0?=
 =?utf-8?B?eUdwN2hUb0VtTUR2aWlVQUdCU0VwUmpaVnVOSFUyMWE0R003RXVKT2FIcTBM?=
 =?utf-8?B?RHNJTmtvV1VqS1VuT0xZTTB5ZlJBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A31w3lViVb8d9mGGFaQViPa2/k1RWDwtuAatVwaktQY7pcPL/clASFTJ/CKrKw/YzlyS25r6pfWM7kijqvXbgAypXq7fauCV1r/2ydmY35Ft/GLxUlFy+Gb7K+G+u43fsWEyTAHHZjC4e6brZxqsx1HgSgkgpDKcezNJl9OC1y4NoE6gGZohkVBbG6RIp1XdP0zIfQRN8yPVrG32FgDtydVYB8boKHwitPPhidWOBEREfI+LQZ6ZMIelYgtg/Fq/wSTvhArxWM5LRLFWTmz06VbWv07HIMekbZqjfR4i6PhnIkOAYBzdeMyZCaX6QUumY9NRde2eKwCi9hvuXOJSlV+lb9gecybUpRTTKIdxRNcWu35uB7G+q/i9CsL+WAyvioJ4fJpBaOYIau2lkLe2IAeiTwo//O3hylQzrxV7edI/tWsqXzFDHU9ZH7SPctbo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 15:50:01.3811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077ac105-49f8-4326-8423-08de6d730b85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
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


v2:
Added PASID→fpriv registry and KFD→render-node eventfd bridge patches.
Series builds cleanly and is compilation-tested.

v1:
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

Srinivasan Shanmugam (8):
  drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls for render node
  drm/amdgpu: Add per-drm_file eventfd registry for render node
  drm/amdgpu: Add IRQ-safe eventfd signal helper
  drm/amdgpu/gfx11: Wire MES EOP IRQ to render-node eventfd
  drm/amdgpu: Add PASID->fpriv registry for KFD->render eventfd bridge
  drm/amdgpu: Register/unregister fpriv in PASID registry on
    open/postclose
  drm/amdgpu: Add amdgpu_eventfd_notify(pasid,event_id,count)
  drm/amdkfd: Notify render-node eventfd subscribers for KFD events

 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  25 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   3 +
 .../gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c | 141 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 150 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |   5 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  14 ++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  76 ++++++++-
 include/uapi/drm/amdgpu_drm.h                 |  35 +++-
 11 files changed, 447 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd_pasid.c

-- 
2.34.1

