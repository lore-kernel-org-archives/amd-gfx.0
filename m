Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58391FF8864
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93C410EA1B;
	Tue, 28 Apr 2026 03:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NfClsW5X";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184C910EA1C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mr2cO5AZT/xihHyUdNvCmoYpymb3KGmb/3+PdSOi3jRJIGwHyEG95mq+6J7hlb3aZXug8fFYb2eVNFOwkaJFMU+2AbCCmLlmlsPtCFj4CFn4zZNzQr0ThZrp1zMVEzjVBTxs23/uw5sJYrtePlD5R7ZUm3H5nGzZCDTphTvsIudrZmd5z1OQYGTUa0H5t373iUQpSJDKS/1m2HfDOurGLfY0vPkyKPn0AiFSy5HDpXSVnmzYc1zh8QylyFxI0/XZqJgoqBb+BXalIHelNCf1lh2SaiG9PG8Ay97FZhd8043b6n8edVmdBzXU40Cpdt+D+FIKMM/xsxiiZh+KyfliNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPrAuJZfF2bYZSyCOF8NP1IdEbTXvkVn+uBifxbUnC8=;
 b=K+FvVA5huFCVUxc1vN7suvecMJ8owlzi1BdwyKkMQN6XWR+19sbeFBITHNs1npFTOdvw5WLCSKgU3cqZUOyhGwCrYNtM/Ddhw98rfYA71XLeQibc25m+BUedmcRnge/xTaevcL0hgKGc68R8PGMt7WcTb6WGHZmencp/3i13x+WVbLYVb3EqvC00cZqoN3JYwj2uT66LydXl5tOWwSChG7G11slcDJ53j+pj7AwOCLlbChMDBHmF/PO1VZTZJRrFt4JgJscsJuhlvEQakLvVhYv8qWyLSBnZN3SghrwJXHVn1KfnpKrbA6CdOGq9tbgnhSfUpllQAWXjdJHqGI+zHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPrAuJZfF2bYZSyCOF8NP1IdEbTXvkVn+uBifxbUnC8=;
 b=NfClsW5XfWvAXOTL7krCgwd0cMH1A6fwB5bLGhhH/ov28Scciz/XBzwtCUkBIa5Zq7DylNV0dvmFsrhUlnPyQMgSHDNV9Z0TBamWEQVdB0F5clI932gaOjt4bfpUEl18K2HExrm7XnFQwLL+7aztIu8sR+dgKP0DMKOszYCLiBk=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 03:18:01 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:18:01 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3
Thread-Topic: [PATCH v2 17/17] drm/amdgpu: add profiler/spm support for
 gfx9_4_3
Thread-Index: AQHcu9QbhaWYRNoubE6ScOpWw9EcvbX0A5Ag
Date: Tue, 28 Apr 2026 03:18:01 +0000
Message-ID: <BY5PR12MB4179C2E93B99B07CFF3193D1FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-18-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-18-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:17:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|DS4PR12MB9682:EE_
x-ms-office365-filtering-correlation-id: 5d25cc22-1515-4a8a-21e6-08dea4d4c15e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: CDJzn0o2V4RFYjFLkJKCdGg7/hUARth9DN9183LlwMTVzY1jSV5YVthXJaTvjh/4YDFxbUIR42bP3bFYfe0RzTWW6BFy1SVuX1cVjf5qdPmP5GK91eWmeaAHqHtngwMcWDaXMuM7FUIouvTzFVaI7VqUsuuPgFBLdNMh+sNPnLstK2KgLIqYeWuxhcBMp/bkKXXNTdMR9Eq9o1XI9FZ19gpZYiMAkIJ094EtWY4+LPJbSSALCnPIUX29A3aGW8SqRJ6+r9LHW31NYQO5RO2IODU2jtRKGFcPDUlfrTGps3+ax96KZ9/j5Uh6Ht/+uBZKRiPWR8Xhr7uWsKydhSQS3JBN3SHqCxBB1WkGw1F68V4t4y1g3w/uu2Um+dgRRnGucyV+EPFvqe4D4Kq3cA45NZItmMgYIwK+vuMgp5w4jNkRbcu6KdZI4Bg1yOO2q7wFZfXYXeYMqe94BQ7mUo8x8jzWCI+XHnFZqOtAX068W9NMiygshB2oXdA6DJ5nfv0DDygYi22lBndu+mRO/Bio7vlfKtygDd6F4cJtKwX3NplA14Z17HyC0WAm+xSxJ+RpTpTmrn2mlyS+WBS+oYzap7Ai1LuJIfFDRUznS+mB6ZbhPjXClpYtr7Y/RVe833OsTHBcL4I01V1fLi0zP5N2z4xVZChElXQcWUajfx4Js66ChYGXWSuqoJ08SASzp3nbb8oj1KdCu9N+R0RtoRnLRVKgnldNY1JV/PsjlpYjCBxr9PheGHAMYp83NjTjt9/9RyLlVywHIdEniuh4vPFB9x9PiAo7P44tPuha6WyLpOU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ziICb8EHjejDKZ1JF/UoAaOiWBJlezxVd46ozz8Dyy0hhtZoPCiIOkXFcxqQ?=
 =?us-ascii?Q?lG4IiEhtCH8EcCq8YrKy3Y1VQ6Xxds8NsB9PfMYoKT2sKk2iTxKOYIDPskA4?=
 =?us-ascii?Q?teRgbLTby40OmtyOoAeoz3FTgFM9IqEsUBCxSmMqx3xnJFJios2UewgcuQP3?=
 =?us-ascii?Q?HDWAz50I+pFoJxXK3uXlYSZQ6HqpY+TzCF7OUpYbUvZgXKu5kFgrMwr0LDjf?=
 =?us-ascii?Q?3yhsVCdwLFlovs0xIyJQSiarrylrwbDGxve47tZXCLXvYvXp0kKjdwag+AHh?=
 =?us-ascii?Q?h0uLjnFQfSgppp/oly+lEChRZxEevBYnyWwmS3wAmO5N++aKYOLeJTRc3XtO?=
 =?us-ascii?Q?xs9CXK31ED6qrBRQxMbG0lSQfT06nfT21koPCPUKsZAD/k3JHioy8OVY+dZ2?=
 =?us-ascii?Q?xf9OyTf8sH5olp4FdTgB0f8bXe7YP7+dNgylkTkaR53uFkpdFL/ufNqtRoOu?=
 =?us-ascii?Q?Ef+YkYnlm/jOS5ZoqTA4hzo75AHzmqf6igdYG22jXfeW6JXz2aAMvtbdLsPT?=
 =?us-ascii?Q?qvHLGgn1fPp7vN8jec/tmuqPiC73ZUQiLUcJrO7zpqSgeAm5cDjGrtgiYJxy?=
 =?us-ascii?Q?tjFG27Nu90zzVGguXBUZVognOpWfQHtKI8yPm9N7nrUXxdjSBLwY/Vhc11lj?=
 =?us-ascii?Q?EFGbbpujAkxOwjg6N1DxIPDI+ydtygH28NBWSs1H5brBQ0NxkTOx/EdOZlwm?=
 =?us-ascii?Q?rBcW8zT1Et1OLw0Fd0Q9OjEYvJHWnyW6JkoMXP3GGXbFOMBU5FyzJ0KgJKKR?=
 =?us-ascii?Q?34Gp6NcS0lRk1C3Gq0R9vurNQAPJtDG/0dd6KKU6CUDDe4tioYMXXHxZhzQW?=
 =?us-ascii?Q?S7CtKXd2Q3bsJ2ROvqOeyf/ZkPnng3ulAt45oUHMEOpOG1B2zPAOSuWeGOSf?=
 =?us-ascii?Q?t0b009uH35SKEBmjZGtOTjB78sj5kdrixWeakc8t1f7beZopeixh6AYCixld?=
 =?us-ascii?Q?Q8uFXS6CrT5YqgMHmHFbXCjGl+MW1/u9YrvwekOZ5kk5PmZCJJN685k3WH6S?=
 =?us-ascii?Q?o6UDaMYw+B5fH75hiPvAZMYTUpq8QGxyR0Vgm1aNmcl9cRV5Qt8UnQAgKTFs?=
 =?us-ascii?Q?fui9COi1wscFEXdbBWl7WkzL06zkkPrwGLkRvewvis7MrYaBcl5Pc3KSGl+h?=
 =?us-ascii?Q?M/8wXwGfmAvbWO9l0VynLeOAljFExWRYGCm2dRIvQp2xi+ekHvD7I35IH2GE?=
 =?us-ascii?Q?PPsf+RIkpVPLheu63d5CN17tgRsWGf4B9V6WjClE8u4iiCWcbrERRUrH+xJ9?=
 =?us-ascii?Q?iTLXsjhPv7/nFs2WIrNJGs4Bjf/ckAr5aXU8Er8D2hIQgCFKrTA2ZElPAN+s?=
 =?us-ascii?Q?z7dRbsT4WEbj88V1UqaVun/SSGVZFwZ+YVHVui3hH9gpUjx7SL+Crwk14aBT?=
 =?us-ascii?Q?8qycVtrU0ZDUE3N5fUShMmay7U6VitK6X5k4J1SIIllv6q0cN1eafVN5XiNQ?=
 =?us-ascii?Q?yciolNBqbxyvC8FY1QKHNHuIYiadgH949BlT9YSvJNm649lvUxiKKrJDdlvC?=
 =?us-ascii?Q?QNccaOUoAk+Cmy3gecDi3ehhOOtOntbbHYr5uhADSsG5/Ona3AO/4q84oi3b?=
 =?us-ascii?Q?ZqiF2AtPJHcOOCX1gOL8lT48RR9igVRI2OxKka6KweKufVlgTiD4sOiwvOTP?=
 =?us-ascii?Q?2qGca0l6CLx5y7rl0q4yHgyFu+zHtHtfD0wdjW8Gqn50HJ70OROIGRuPhezr?=
 =?us-ascii?Q?lJveZO1P0tVb/2yfbZw/65iihJlgwXRGl9Mx7MDt0I3Elfff?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d25cc22-1515-4a8a-21e6-08dea4d4c15e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:18:01.6809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oB9jtwPEoTTut5hMTDayw3Dot1bxZaEsoWH3unHCkZ/73FrmQg+8GKMywrf5+3HsZFP51EkKlkExaVfakatEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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
Sent: Tuesday, March 24, 2026 2:21 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3

with implementation of amdgpu_spm_funcs callbacks for the GFX 9.4.3 IP bloc=
k and wire up the per-XCC RLC Stream Performance Monitor interrupt.

SPM function table (gfx_v9_4_3_spm_funcs):
  gfx_v9_4_3_spm_start(adev, xcc_id):
    Uses kiq[xcc_id].ring for the per-XCC KIQ ring. Programs:
    - Read-modify-write RLC_SPM_PERFMON_CNTL to set PERFMON_RING_MODE
      via MMIO read + KIQ write.
    - CP_PERFMON_CNTL.SPM_PERFMON_STATE =3D DISABLE_AND_RESET via KIQ.
    - RLC_SPM_RING_RDPTR =3D 0 via KIQ to match the hardware wptr reset.
    - RLC_SPM_INT_CNTL =3D 1 via KIQ to enable the SPM interrupt.
    - Read-modify-write RLC_CLK_CNTL to set RLC_SPM_CLK_CNTL_MASK via
      direct MMIO, gating the SPM clock domain on.

  gfx_v9_4_3_spm_stop(adev, xcc_id):
    Uses kiq[xcc_id].ring. Programs:
    - Clear RLC_CLK_CNTL.RLC_SPM_CLK_CNTL_MASK via direct MMIO.
    - CP_PERFMON_CNTL.SPM_PERFMON_STATE =3D STOP_COUNTING via KIQ.
    - CP_PERFMON_CNTL.PERFMON_STATE =3D DISABLE_AND_RESET via KIQ.
    - RLC_SPM_RING_RDPTR =3D 0 via KIQ.

  gfx_v9_4_3_spm_set_rdptr(adev, xcc_id, rptr):
    Writes rptr to RLC_SPM_RING_RDPTR via kiq[xcc_id].ring.

  gfx_v9_4_3_set_spm_perfmon_ring_buf(adev, xcc_id, gpu_addr, size):
    Programs via kiq[xcc_id].ring:
    - RLC_SPM_PERFMON_RING_BASE_LO/HI with the GPU address
      (currently uses GC instance 0 for base address registers).
    - RLC_SPM_PERFMON_RING_SIZE and RLC_SPM_SEGMENT_THRESHOLD =3D 1
      using GET_INST(GC, xcc_id) addressing.
    - CP_PERFMON_CNTL =3D 0.
    set_spm_config_size =3D 30 DWORDs per KIQ ring operation.

  gfx_v9_4_3_set_spm_funcs() registers gfx_v9_4_3_spm_funcs into
  adev->gfx.spmfuncs from gfx_v9_4_3_early_init().

SPM IRQ handling:
  The SPM interrupt source is registered in gfx_v9_4_3_sw_init() for
  client SOC15_IH_CLIENTID_RLC with source ID
  GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT.

  gfx_v9_4_3_spm_set_interrupt_state(): iterates over all XCC instances
  and writes regRLC_SPM_INT_CNTL =3D 0/1 for each via WREG32_SOC15 with
  GET_INST(GC, i) to enable or disable the per-XCC interrupt.

  gfx_v9_4_3_spm_irq(): resolves xcc_id from the interrupt entry's
  node_id via gfx_v9_4_3_ih_to_xcc_inst(), then calls
  amdgpu_rlc_spm_interrupt(adev, xcc_id) to dispatch to the correct
  XCP's SPM manager.

update_spm_vmid refactoring:
  gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, vmid) is
  extracted from the existing gfx_v9_4_3_update_spm_vmid() as a
  lockless helper that performs the read-modify-write on
  RLC_SPM_MC_CNTL.RLC_SPM_VMID using GET_INST(GC, xcc_id) addressing.
  The original RREG32() path is replaced with RREG32_SOC15() for
  correctness on multi-instance GC.

  gfx_v9_4_3_update_spm_vmid() now wraps the internal helper with
  amdgpu_gfx_off_ctrl(false/true) to prevent GFX power gating during
  the VMID register update, and is used for runtime vmid changes.

  gfx_v9_4_3_rlc_init() is updated to initialize the SPM VMID to 0xf
  for all XCC instances (instead of only XCC 0), and now skips the
  operation for SR-IOV VF or when update_spm_vmid is NULL.

  gfx_v9_4_3_xcc_rlc_resume() is restructured to unconditionally call
  rlc_stop() before firmware loading and rlc_start() after, regardless
  of firmware load type. gfx_v9_4_3_update_spm_vmid_internal() is
  called between stop and start to ensure the SPM VMID is correctly
  initialized to 0xf before the RLC is started for both legacy and PSP
  firmware loading paths.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 194 ++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index ad4d442e7345..a8371cf7ee53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -169,6 +169,8 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_devic=
e *adev);  static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev)=
;  static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
                                struct amdgpu_cu_info *cu_info);
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev=
,
+                                             int xcc_id, unsigned int vmid=
);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int x=
cc_id);  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *a=
dev, int xcc_id);

@@ -1066,6 +1068,13 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block=
 *ip_block)

        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);

+       /* SPM */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+                             GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRU=
PT,
+                             &adev->gfx.spm_irq);
+       if (r)
+               return r;
+
        /* EOP Event */
        r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__S=
RCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
        if (r)
@@ -1454,10 +1463,14 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(st=
ruct amdgpu_device *adev)

 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)  {
-       /* init spm vmid with 0xf */
-       if (adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+       int i, num_xcc;
+
+       if (amdgpu_sriov_vf(adev) || !adev->gfx.rlc.funcs->update_spm_vmid)
+               return 0;

+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       for (i =3D 0; i < num_xcc; i++)
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, i, NULL, 0xf);
        return 0;
 }

@@ -1632,14 +1645,15 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_=
device *adev, int xcc_id)  {
        int r;

+       gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
-               gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
                /* legacy rlc firmware loading */
                r =3D gfx_v9_4_3_xcc_rlc_load_microcode(adev, xcc_id);
                if (r)
                        return r;
-               gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
        }
+       gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, 0xf);
+       gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);

        amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
        /* disable CG */
@@ -1667,28 +1681,38 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_devi=
ce *adev)
        return 0;
 }

-static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
-                                             int inst, struct amdgpu_ring =
*ring, unsigned int vmid)
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev=
,
+                                             int xcc_id, unsigned int vmid=
)
 {
        u32 reg, pre_data, data;

-       reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL=
);
+       reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CN=
TL);
        if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
                pre_data =3D RREG32_NO_KIQ(reg);
        else
-               pre_data =3D RREG32(reg);
+               pre_data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id),
+regRLC_SPM_MC_CNTL);

        data =3D  pre_data & (~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK);
        data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC=
_CNTL__RLC_SPM_VMID__SHIFT;

        if (pre_data !=3D data) {
                if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtim=
e(adev)) {
-                       WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, inst), regRLC_=
SPM_MC_CNTL, data);
+                       WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRL=
C_SPM_MC_CNTL,
+data);
                } else
-                       WREG32_SOC15(GC, GET_INST(GC, inst), regRLC_SPM_MC_=
CNTL, data);
+                       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_M=
C_CNTL, data);
        }
 }

+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
+               struct amdgpu_ring *ring, unsigned int vmid) {
+       amdgpu_gfx_off_ctrl(adev, false);
+
+       gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, vmid);
+
+       amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static const struct soc15_reg_rlcg rlcg_access_gc_9_4_3[] =3D {
        {SOC15_REG_ENTRY(GC, 0, regGRBM_GFX_INDEX)},
        {SOC15_REG_ENTRY(GC, 0, regSQ_IND_INDEX)}, @@ -2376,6 +2400,7 @@ st=
atic int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
        int i, num_xcc;

        amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

@@ -2510,12 +2535,112 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct=
 amdgpu_ring *ring,
                                   (1 << (oa_size + oa_base)) - (1 << oa_ba=
se));  }

+static void gfx_v9_4_3_spm_start(struct amdgpu_device *adev, int
+xcc_id) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+       uint32_t data =3D 0;
+
+       data =3D RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SPM_PERFMON_CNTL)=
;
+       data |=3D RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_PE=
RFMON_CNTL),
+data);
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+                       CP_PERFMON_STATE_DISABLE_AND_RESET);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_PERFMON=
_CNTL), data);
+
+       /* When SPM is reset, RLC automatically resets wptr to 0.
+        * Manually reset rptr to match this.
+        */
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_RI=
NG_RDPTR), 0);
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_IN=
T_CNTL), 1);
+
+       data =3D RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CLK_CNTL);
+       data |=3D RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK;
+       WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CLK_CNTL, data); }
+
+static void gfx_v9_4_3_spm_stop(struct amdgpu_device *adev, int xcc_id)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+       uint32_t data =3D 0;
+
+       data =3D RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CLK_CNTL);
+       data &=3D (~RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK);
+       WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CLK_CNTL, data);
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+                       CP_PERFMON_STATE_STOP_COUNTING);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_PERFMON=
_CNTL), data);
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
+                       CP_PERFMON_STATE_DISABLE_AND_RESET);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_PERFMON=
_CNTL), data);
+
+       /* When SPM is reset, RLC automatically resets wptr to 0.
+        * Manually reset rptr to match this.
+        */
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_RI=
NG_RDPTR), 0); }
+
+static void gfx_v9_4_3_spm_set_rdptr(struct amdgpu_device *adev, int
+xcc_id,  u32 rptr) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regRLC_SPM_RI=
NG_RDPTR), rptr);
+}
+
+static void gfx_v9_4_3_set_spm_perfmon_ring_buf(struct amdgpu_device *adev=
,
+                                           int xcc_id, u64 gpu_addr, u32 s=
ize) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(G=
C, 0,
+                       regRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu=
_addr));
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0,
+                               regRLC_SPM_PERFMON_RING_BASE_HI), upper_32_=
bits(gpu_addr));
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
+                               regRLC_SPM_PERFMON_RING_SIZE), size);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0),
+                               regRLC_SPM_SEGMENT_THRESHOLD), 0x1);
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, 0), regCP_PERFMON=
_CNTL), 0); }
+
+static const struct amdgpu_spm_funcs gfx_v9_4_3_spm_funcs =3D {
+       .start =3D &gfx_v9_4_3_spm_start,
+       .stop =3D &gfx_v9_4_3_spm_stop,
+       .set_rdptr =3D &gfx_v9_4_3_spm_set_rdptr,
+       .set_spm_perfmon_ring_buf =3D &gfx_v9_4_3_set_spm_perfmon_ring_buf,
+       .set_spm_config_size =3D 30,
+};
+
+static void gfx_v9_4_3_set_spm_funcs(struct amdgpu_device *adev) {
+       adev->gfx.spmfuncs =3D &gfx_v9_4_3_spm_funcs; }
+
 static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)  {
        struct amdgpu_device *adev =3D ip_block->adev;

        adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
                                          AMDGPU_MAX_COMPUTE_RINGS);
+       gfx_v9_4_3_set_spm_funcs(adev);
        gfx_v9_4_3_set_kiq_pm4_funcs(adev);
        gfx_v9_4_3_set_ring_funcs(adev);
        gfx_v9_4_3_set_irq_funcs(adev);
@@ -2537,6 +2662,10 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_blo=
ck *ip_block)
        if (r)
                return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+       if (r)
+               return r;
+
        r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
        if (r)
                return r;
@@ -3395,6 +3524,41 @@ static void gfx_v9_4_3_emit_mem_sync(struct amdgpu_r=
ing *ring)
        amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */  }

+static int gfx_v9_4_3_spm_set_interrupt_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *src,
+                                            unsigned int type,
+                                            enum amdgpu_interrupt_state st=
ate) {
+       int i, num_xcc;
+
+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       for (i =3D 0; i < num_xcc; i++) {
+               switch (state) {
+               case AMDGPU_IRQ_STATE_DISABLE:
+                       WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CN=
TL, 0);
+                       break;
+               case AMDGPU_IRQ_STATE_ENABLE:
+                       WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CN=
TL, 1);
+                       break;
+               default:
+                       break;
+               }
+       }
+       return 0;
+}
+
+static int gfx_v9_4_3_spm_irq(struct amdgpu_device *adev,
+                            struct amdgpu_irq_src *source,
+                            struct amdgpu_iv_entry *entry)
+{
+       int xcc_id;
+
+       xcc_id =3D gfx_v9_4_3_ih_to_xcc_inst(adev, entry->node_id);
+
+       amdgpu_rlc_spm_interrupt(adev, xcc_id);
+       return 0;
+}
+
 static void gfx_v9_4_3_emit_wave_limit_cs(struct amdgpu_ring *ring,
                                        uint32_t pipe, bool enable)
 {
@@ -4822,11 +4986,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3=
_priv_inst_irq_funcs =3D {
        .process =3D gfx_v9_4_3_priv_inst_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_spm_irq_funcs =3D {
+       .set =3D gfx_v9_4_3_spm_set_interrupt_state,
+       .process =3D gfx_v9_4_3_spm_irq,
+};
+
 static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev)  {
        adev->gfx.eop_irq.num_types =3D AMDGPU_CP_IRQ_LAST;
        adev->gfx.eop_irq.funcs =3D &gfx_v9_4_3_eop_irq_funcs;

+       adev->gfx.spm_irq.num_types =3D 1;
+       adev->gfx.spm_irq.funcs =3D &gfx_v9_4_3_spm_irq_funcs;
+
        adev->gfx.priv_reg_irq.num_types =3D 1;
        adev->gfx.priv_reg_irq.funcs =3D &gfx_v9_4_3_priv_reg_irq_funcs;

--
2.34.1

