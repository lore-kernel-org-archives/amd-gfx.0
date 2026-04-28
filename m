Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD029FF8864
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA5510EA11;
	Tue, 28 Apr 2026 03:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ccatWBlg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010063.outbound.protection.outlook.com
 [52.101.193.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F387210EA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk9IFZiwFUTftDttRuAqJYdnQ13hdyqdNvic7VRNDRC4s1oxnimiFxV6OpsWqijbxVcYSRN5b9xvJQIJANTJpz/JrcuY/Jgf7XHrcKU1/z+Je7rA0ZwEdRsaaC/ofyAnmYZaQ/3vuJhhGXsnyQX03uK+O1+awqDqG6hri1X1tDRg8M1EkVJ81zg6DFMGLQWWlP8FgX62jCQz0JBOKT/TH0iffpcqa00SDOLpK/DMr0ax+QOag/ACOzVxr1rvKwFFDoexNAOdjtGo1TOZjYDMw2vNFh+9+LO6o0KKZw9lyMOrXquNxucR35dbSFbp8IwRWzkXxLHr7dsBbzF7tvPBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZOKqdVsRZVp2lW7kvLvzlviV1ceOOEWF9Ny8IC1uU8=;
 b=m9eyOhiQ+UpHqybENDmv+YQO27hM0OuQnO2CUwLMxRVDRNEmd/dcXq48OhwUfJeHWrtSZCQfQYI7w11htWfr6PEg3EsjTiZLNwxfBelbpU4I2eD6ms/au/cEuuLyNY3eJtzLs+TnbWFmdLBpDqOHl0C9mDLzfn/JPEU+Ory369gJDGj9BzyVJE+TUGXl3rzFjJMmvPnaL9oq/W/QhkacLC1WYnqfWcxgXF6xyKFiKIgBkbOr11C2S0V/BasQqjXC4BSUyaFF3kCLNV+4j+AGEv05fThRzcH8toDYSE5v07eOUEzYcPxyFzaIbJPnK55nRCDYyM6jaHf0Q57Z7hPo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZOKqdVsRZVp2lW7kvLvzlviV1ceOOEWF9Ny8IC1uU8=;
 b=ccatWBlggT5j3WvaxP1ky+g2hlNofT/tgV4qRysVf0hqTpMPffRUKZBUrRshh9cXPPsb7Orh97NkvsuWO6GhWkOlHtTCKpeZNowKSperHCi9GQoznPDWCA9CleuxO14F1f4NVI8yx23zbOX5vlRybI4jq8EQockVXdZ2EOzZsNc=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:16:56 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:16:56 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 10/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_ACQUIRE
Thread-Topic: [PATCH v2 10/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_ACQUIRE
Thread-Index: AQHcu9QX3UNuihQjukGmVIHFINNV/rX0Az/Q
Date: Tue, 28 Apr 2026 03:16:55 +0000
Message-ID: <BY5PR12MB4179C3AEC70B3370501A370EFD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-11-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-11-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:16:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: 80a73f6c-b0a6-4665-a9fb-08dea4d49a28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 6ey5V3lBVNCGcGxWwo1YbrIqlpDJNM9RGZkIwUx2hO1xz4gWd6d45RVzTY0TYAjy8nwFNGVSNykmW3PnWbyamusK513cV6hRR+WyswuInaaW4IHMPOoVub27wXSOPDd+9JaZukN+s64zTSEtg8zyp1Wtwc+e3kYWNwslN3DoM0pPJfnkP8cE0JUlJ0E9dw+dbcX3QC4CcKQXrb5FwPtrB158GLkr6KW4cUAbzJMZFUq1lTfGh8+XMlWKTdOv4T98IWqX7Uq0Yoyc2Ldfx/KMg2ojAVZGKljxlxj5c7IKU5vl2aEHLG8Q9gX4m2yNMkczHXsC3xbTmuUmVVXjux+ruWAvbH0XErtlF7r2/0hQ2Rg/NlYCsx0k9PmewXXmhIhST82HzzDBQFMSLKXCxDkUiiKkrD8yWAK1N38YTlQ32Zgm9G70jDKEBJ2lXCr0Ic89YAcDxOayAfFh6q4VstXKBjF8ReazCO+GWj//TSHjcnnSloSeDhb33bOiCGHHavT78D/3Bg51f+/UBF1lDgeyLkDyPMejBoJw9uoNfQUAlmUuwmYqqw2aq5qJhn5Qd/8bkT4wbMREUkIh9wAl+bcudvrkqzHW5DZlWG5MDE+E1Ziv4EOrD23LgB/zAMZ2ufQCrG0yDDVOY5ce9IJ6p7Hr1MTU5bCx6SZdBKV8KsuJ87/j/HJjwHirIJRb0YEdIz9an7hr7HSSyHPQs4dNvzXIX+pX506BGwV7x/iF/3t70TbIJpJ5HR6YWCnSmRCXb1PIZzbD5/dgW0mp3F9UyRnNL7vRV4w5Ny/xMZoYPYoDalU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3GpoKAhfAzzXnuSjcX5/zu2q3zngXsz0iqZ8+O4HOYv2vSpmgLOiMH2QJGyQ?=
 =?us-ascii?Q?laL0IuBA/IktKNm50SC0uPIj0//ZRRpG2Aih1Ieora4mmczBa13G3VvT9rYN?=
 =?us-ascii?Q?m3vpUjUhhh+4T3Pc1UjUJkVoX6SsuNDRgidjiy5A1L8S+4EZ9XAotrp0Iw33?=
 =?us-ascii?Q?InPs7B30QGY9ZjDB7TYIMWKRKMafUIWr8BHZNyBZ14D1YBoEFIUzs2dhEoFu?=
 =?us-ascii?Q?O6TJx2pR2HU9jeEcrzEZnOEaJt1s/fiS7mSblANMhBfT9ZNzt2dP80hfp68H?=
 =?us-ascii?Q?snMh2OgsMsnZkm8bnMUI7mY03RIiN0ARJPqTTWMLYlaiYOb1hh/SopYUQuxF?=
 =?us-ascii?Q?Hx2j1vzBYoT4hL2MTbfRYbRQ6F3cZkkHm9Y2ifB04Zg0wWD/b3XqcrA2TuYc?=
 =?us-ascii?Q?BYfCYJs5ODiDfbvNyGRgLsymO6b5Vkc8jX+vjrdYHNlfHwG1QM4kaeArNh6V?=
 =?us-ascii?Q?Ve6NiyQpLQ0jvBnt4wVuOJMaZhQGRWPZ7gFy2ZVUcmSRSuTaELl1Kgf+iVGZ?=
 =?us-ascii?Q?GIh89FA990PzpZ9qAky3cLi/FN9tHPBMDSvg1rG2uttZiTrFiKxP6+3PxJLl?=
 =?us-ascii?Q?WLtyh/aU2GchcRBM+Ihtj5RwrQ3LSntKb0Rk/cKFSKBVv7mEGxusskO4+n7k?=
 =?us-ascii?Q?2Oq4mb/KeBA1q3Od80MD7vP9k6B+/i2rv1i4jIJJ+Wr+IPv487a8lUjn0QB0?=
 =?us-ascii?Q?ELH/pD4tSaqkoXLXGYFSrflqFlGxjhPKaYsXNtocAG2RmIgA2QPKk93sYC38?=
 =?us-ascii?Q?oIVjfJMPLy9vzvbpECag8iA6YVEr91sEfCop/vuo00Av2+FXfgkwv8ezX+eM?=
 =?us-ascii?Q?0GT350FlqtpkggxBelsVH0Iw22CoOExgh5SA0jZ6idCGxoFzroFpFvQAv+Qm?=
 =?us-ascii?Q?Xt7rC/whcrJzc3Kz3tAO09bCfRFsFcsouy7z/RkLAPLecpqM9RBuEygMHV9f?=
 =?us-ascii?Q?gdKpRqAinqc40o2C/ZQMpMhFLuQJupsMnEmcmxxMfHnSg/A/ErmAgd8kqw9R?=
 =?us-ascii?Q?pNgVVyjxoe0VzHo5/dNDBA7ruMCt/weiSG5rUvhAmRiHhI1+fj1ac/D6XxD2?=
 =?us-ascii?Q?wr1REFPGmpJmtmPyeIeuaPflVi6kqn4telslmTaFeFQ0HA8bthROJr5vfxF4?=
 =?us-ascii?Q?B7am9NAl+NFZRCquBtXDpIxL82scrFgY1ApAYEKhQ5AfBGcAeeJF6pipH6oc?=
 =?us-ascii?Q?NuuPOjT/YJc+kDp9Ei+MlbWYaCvUyCWGxrh29lR61K0eYe4Fw/MB7nbfT1MF?=
 =?us-ascii?Q?lIWKqccf6ZaTb07B4NZvZASAih0Ft0sVR4caw2DaEw42ilM+cKwhauRc+ren?=
 =?us-ascii?Q?y32vv2UDungqJvlX3eIQ8idjpfz7RybkwpT46WaUPa1KApSrdYL3Q5bNxXNy?=
 =?us-ascii?Q?C10OJ2bfTlV//YC6+99Jq1sNBQlW7ANh8d0fIXsFHrtee66As7N4kV1HLg/2?=
 =?us-ascii?Q?JCSw33Hnue4z02NDqYe8SXJRDmixB9405wYGa+aK64koLQmgg63Jtt36B/M2?=
 =?us-ascii?Q?kYbevqLPWql5VrPbNycc8CWlk4NBEMDseXWm45UUiPj/te2tUMoH4+tgp4gv?=
 =?us-ascii?Q?e3RxiK55xTKZyOgBvciDYck27yEH839k0dVSub9vFaOepbl1LJkn9pcgLaFy?=
 =?us-ascii?Q?YPoVC/28GdL6yiCUrioI32LT0Hgbeb8VhgIaJvGNdVYHa7j7ql8dzPshrBX6?=
 =?us-ascii?Q?54eNkZnhiD7UXNC52gSfrQmlgKbv804XeCEHsN5fFJowrPNJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a73f6c-b0a6-4665-a9fb-08dea4d49a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:16:55.8942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/wDck9rhLnYj9yK4+63GYh4DSH6FPeBCF+zhTtbt84aKnmRHUKBr9y3VNzEci/qFwVs7uyb0FIMHLHKTa3bdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

AMD General

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 10/17] drm/amdgpu: add profiler/spm operation AMDGPU_SPM=
_OP_ACQUIRE

to implement AMDGPU_SPM_OP_ACQUIRE, which grants a process exclusive access=
 to the SPM hardware on its XCP partition and allocates the per-XCC ring bu=
ffers used for streaming performance counter data.

Data structures:
  struct amdgpu_spm_base (amdgpu_spm.h):
    Holds the per-XCC ring buffer state: GTT BO handle (spm_obj),
    GPU virtual address (gpu_addr), kernel virtual address (cpu_addr),
    and effective ring size (ring_size).

  struct amdgpu_spm_cntr (amdgpu_spm.h):
    Contains an array of amdgpu_spm_base[MAX_XCP] (one per XCC) and a
    spm_worker_mutex to serialize worker operations. Allocated on first
    ACQUIRE and freed on RELEASE.

  struct amdgpu_spm_mgr (amdgpu_spm.h):
    Extended with lead_thread (the acquiring process's thread group
    leader), spm_cntr pointer, and spm_work work_struct for the deferred
    ring buffer drain worker.

ACQUIRE flow (amdgpu_spm_acquire):
  1. Takes the per-XCP prof_xcp_mgr->mutex to serialize concurrent
     ACQUIRE attempts.
  2. Returns -EBUSY if spm_cntr is already allocated (another process
     holds SPM).
  3. Allocates spm_cntr via kzalloc and records current->group_leader
     as lead_thread.
  4. For each XCC in AMDGPU_XCC_MASK(adev), calls _amdgpu_spm_acquire():
     - Allocates a 4 MiB GTT ring buffer via amdgpu_bo_alloc_gtt_mem().
     - Programs the ring buffer into the RLC hardware via
       amdgpu_rlc_spm_acquire(), which also reserves a VMID for the
       caller's VM.
     - Subtracts 0x20 bytes (8 DWORDs) from ring_size to exclude the
       hardware-defined metadata area at the end of the buffer.
     - On failure, frees the GTT BO and clears the spm_base entry.
  5. Initializes spm_worker_mutex and INIT_WORK for amdgpu_spm_work.
  6. Records the drm_file pointer in spm_mgr->file.
  7. On any per-XCC failure, rolls back all already-acquired XCCs via
     _amdgpu_spm_release() (stub, TODO) and frees spm_cntr.

amdgpu_spm_work (work_struct handler):
  Attaches the lead_thread's mm_struct via kthread_use_mm() to enable
  user-space copy operations, then detaches and releases the mm. The
  actual ring buffer drain to user space is a TODO for a later patch.

Three new navigation macros are added in amdgpu_profiler.h:
  - to_prof_xcp_mgr(x, y): container_of from a member y to
    amdgpu_profiler_xcp_mgr.
  - xcp_to_prof_mgr(x, y): container_of from prof_xcp_mgr[] element to
    amdgpu_profiler_mgr.
  - mgr_to_adev(x, y): compound statement combining the two above to
    reach amdgpu_device from any embedded manager pointer.

AMDGPU_XCC_MASK(adev) is added using GENMASK() to safely produce a bitmask =
of active XCC instances from NUM_XCC(adev->gfx.xcc_mask).

In amdgpu_spm_ioctl(), the per-XCP spm_mgr is now resolved from fpriv using=
 AMDGPU_XCP_ID() before dispatching to sub-operation handlers.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 114 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      |  17 +++
 3 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_profiler.h
index ea62a4dee364..587adadaedb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -27,6 +27,7 @@

 #include "amdgpu_spm.h"

+#define AMDGPU_XCC_MASK(adev) GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1,
+0)
 #define AMDGPU_XCP_ID(x) (x =3D=3D AMDGPU_XCP_NO_PARTITION ? 0 : x)  #defi=
ne fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev) @@ -34,6 +35,18 @@ =
 #define prof_mgr_to_adev(x) \
        container_of(x, struct amdgpu_device, prof_mgr)

+#define to_prof_xcp_mgr(x, y) \
+       container_of(x, struct amdgpu_profiler_xcp_mgr, y)
+
+#define xcp_to_prof_mgr(x, y) \
+       container_of(x, struct amdgpu_profiler_mgr, y)
+
+#define mgr_to_adev(x, y) \
+({     struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =3D to_prof_xcp_mgr(x,=
 y); \
+       struct amdgpu_profiler_mgr *prof_mgr =3D \
+               xcp_to_prof_mgr(prof_xcp_mgr, prof_xcp_mgr[prof_xcp_mgr->xc=
p_id]);\
+       prof_mgr_to_adev(prof_mgr); })
+
 struct amdgpu_profiler_xcp_mgr {
        struct mutex                   mutex;
        uint32_t                       xcp_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.c
index 6ff88dfabf1c..e58b89ccd83f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -30,10 +30,28 @@
  */

 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_f=
ile *filp);
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int
+inst, struct drm_file *filp);
+
+static void amdgpu_spm_work(struct work_struct *work) {
+       struct amdgpu_spm_mgr *spm_mgr =3D container_of(work, struct amdgpu=
_spm_mgr, spm_work);
+       struct mm_struct *mm =3D NULL;
+
+       mm =3D get_task_mm(spm_mgr->lead_thread);
+       if (mm) {
+               kthread_use_mm(mm);
+               { /* attach mm */
+                       /* TODO: dump spm ring buffer to user buffer */
+               } /* detach mm */
+               kthread_unuse_mm(mm);
+               /* release the mm structure */
+               mmput(mm);
+       }
+}

 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)  {
-       /* TODO */
+       spm_mgr->spm_cntr =3D NULL;
 }

 static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr, stru=
ct drm_file *filp) @@ -41,6 +59,94 @@ static void amdgpu_spm_release_device=
(struct amdgpu_spm_mgr *spm_mgr, struct drm
        amdgpu_spm_release(spm_mgr, filp);
 }

+static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int
+inst, struct drm_file *filp) {
+       struct amdgpu_device *adev =3D mgr_to_adev(spm_mgr, spm_mgr);
+       struct amdgpu_spm_base *spm =3D &(spm_mgr->spm_cntr->spm[inst]);
+       int ret =3D 0;
+
+       /* allocate 4M spm ring buffer */
+       spm->ring_size =3D 4 * 1024 * 1024;
+
+       ret =3D amdgpu_bo_alloc_gtt_mem(adev,
+                       spm->ring_size, &spm->spm_obj,
+                       &spm->gpu_addr, (void *)&spm->cpu_addr,
+                       false, false);
+
+       if (ret)
+               goto out;
+
+       ret =3D amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
+                       spm->gpu_addr, spm->ring_size);
+       if (ret)
+               goto rlc_spm_acquire_failure;
+
+       /*
+        * By definition, the last 8 DWs of the buffer are not part of the =
rings
+        *  and are instead part of the Meta data area.
+        */
+       spm->ring_size -=3D 0x20;
+
+       goto out;
+
+rlc_spm_acquire_failure:
+       amdgpu_bo_free_gtt_mem(adev, &spm->spm_obj);
+       memset(spm, 0, sizeof(*spm));
+out:
+       return ret;
+}
+
+static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct
+drm_file *filp) {
+       struct amdgpu_device *adev =3D mgr_to_adev(spm_mgr, spm_mgr);
+       int ret =3D 0;
+       int inst;
+
+       mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+
+       if (spm_mgr->spm_cntr) {
+               ret =3D -EBUSY;
+               goto out;
+       }
+
+       spm_mgr->spm_cntr =3D kzalloc(sizeof(struct amdgpu_spm_cntr), GFP_K=
ERNEL);
+       if (!spm_mgr->spm_cntr) {
+               ret =3D -ENOMEM;
+               goto out;
+       }
+       spm_mgr->lead_thread =3D current->group_leader;
+
+       for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+               ret =3D _amdgpu_spm_acquire(spm_mgr, inst, filp);
+               if (ret)
+                       goto acquire_spm_failure;
+       }
+
+       mutex_init(&spm_mgr->spm_cntr->spm_worker_mutex);
+
+       INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
+
+       spm_mgr->file =3D filp;
+
+       goto out;
+
+acquire_spm_failure:
+       for_each_inst(inst, AMDGPU_XCC_MASK(adev))
+               _amdgpu_spm_release(spm_mgr, inst, filp);
+       kfree(spm_mgr->spm_cntr);
+       spm_mgr->spm_cntr =3D NULL;
+
+out:
+       mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+       return ret;
+}
+
+static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int
+inst, struct drm_file *filp) {
+       /* TODO: */
+
+}
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_f=
ile *filp)  {
        /* TODO */
@@ -52,9 +158,15 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *data=
,  {
        struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
        struct amdgpu_device *adev =3D fpriv_to_adev(fpriv);
+       struct amdgpu_profiler_mgr *prof_mgr =3D fpriv_to_prof_mgr(fpriv);
        struct drm_amdgpu_spm_args *args =3D data;
+       struct amdgpu_spm_mgr *spm_mgr =3D
+               &(prof_mgr->prof_xcp_mgr[AMDGPU_XCP_ID(fpriv->xcp_id)].spm_=
mgr);

        switch (args->op) {
+       case AMDGPU_SPM_OP_ACQUIRE:
+               return amdgpu_spm_acquire(spm_mgr, filp);
+
        default:
                dev_dbg(adev->dev, "Invalid option: %i\n", args->op);
                return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.h
index dc55d2a8f016..9db89fd6154d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -24,8 +24,25 @@
 #ifndef AMDGPU_SPM_H_
 #define AMDGPU_SPM_H_

+struct amdgpu_spm_base {
+       u64    gpu_addr;
+       u32    ring_size;
+       u32    *cpu_addr;
+       void   *spm_obj;
+};
+struct amdgpu_spm_cntr {
+       struct amdgpu_spm_base spm[MAX_XCP];
+       struct mutex spm_worker_mutex;
+};
+
 struct amdgpu_spm_mgr {
        struct drm_file *file;
+
+       struct task_struct *lead_thread;
+
+       /* spm data */
+       struct amdgpu_spm_cntr *spm_cntr;
+       struct work_struct spm_work;
 };

 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
--
2.34.1

