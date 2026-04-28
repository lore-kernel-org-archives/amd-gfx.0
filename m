Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C2AFF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEACD10EA19;
	Tue, 28 Apr 2026 03:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ppef7M0w";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A9510EA19
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbK7Gj8aMe/nIYIdEPbyW0jahvbL8fci7SQM3CEBnvboT5UifwfnE4PUetbqX/sOIlmtILs1DGX3N/Ki8JWV+ddRUnoWdhc0mZ9MB6PuHau/Q3bVo4+Jj5CfEE3S6weQD6b1pdammKry3f4n7P1oLS5lg0u5cRX/McVnMTyMN0nbycgwKbA7t5eIq1N88E87Hs43XhGifpPsNpjtw/uRA+Ppo88LZiKdinBCYxWlWm6QjNhqAInC7uJosdc9Hew3K6zXC5SQIEmk4qvzORWhOwKeVDIomqizmU/juCjK8wFWWPRE4Ea+lVtxut4x2MBz1An09u7goy79kFLUXuY1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lei5Z42uqqGPGFO7Y5t0oH+tVA+xL8YQ9AC4k1CsFw=;
 b=W4kbSATjXg2G64BtgvirVGKYHsuHZhNLGlTi6yco2zCr2bi7jZ+M9yFU5OOb7UEGiTCqqqUGhIrZta70Up10jdvDNogjwJ7Hk6bgiKZSNp5is9QCvYjNctsB1lsHOuMWOt1x6dLaNE+wz7b8PkoE48rNDPF3/flrUfNgJFdMI5Q8WFEHFzKrKGq/mqFPGB3TVMLQvGCNb0DEon0Ykaci4s9UpFKeIAaE8HGf4QtOqiiH97sqBAtIVxEdt70Sj3HXGUc6pRqzzMMGSedR44jKYWF82h249VpfaiWRFBhYI1zlIqzxtFDZqxPvs/EsxawdN/C53gbtYCl0gUT+QmvFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lei5Z42uqqGPGFO7Y5t0oH+tVA+xL8YQ9AC4k1CsFw=;
 b=ppef7M0wNeZ/j0dEArRNXBh6jWvwIOtrOELER0IuNB1fdwA8G5PYh9K68o9ObAvcQsqbjFvPzE0tBQuU/KMsA/0YuBt/f3UQiZxyO+hhXwh+996rXgkmCz902Au5O0Gk5dzNSRHakiy9poVH2vC0ALVN2qRXlNaR+qxbukd2pio=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 03:17:55 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:17:55 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 16/17] drm/amdgpu: add profiler/spm support for gfx9
Thread-Topic: [PATCH v2 16/17] drm/amdgpu: add profiler/spm support for gfx9
Thread-Index: AQHcu9QY1BwrJ7M8zECK2+IyxAGklLX0A4nA
Date: Tue, 28 Apr 2026 03:17:55 +0000
Message-ID: <BY5PR12MB4179203797C72AE3E5B7AAFDFD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-17-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-17-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:17:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|DS4PR12MB9682:EE_
x-ms-office365-filtering-correlation-id: ae2de138-44ce-4d90-488c-08dea4d4bdcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: i5/DEvTaOPxew9jseyYjl3/GERv5klJU4Jh1QvcCcQ+2Plu6pfSdECoAIQbahfUE+lho+PdmKHL/ioQJ+aEJmnsy6/2tWizjodRN/+9rdys4ZPeGdfeSkhgVvtPkSOGi4Pg9iQsNtmjnzgD6544vAaQCyJf1fgABWfdwOWv4xsxCRzTYJl6PtDNsWolHjcWPZNlyu4i9zT16XCg3LH+XWdbRUfwnyeNARwt8IkwHvBPR7bfccFJjmeUwJ0P9VXmHVAcFaMu8hIXWNaxgjvn9Mvl6ty/pMxxyhRRaMDQzUGUtMHN6V87t2Dk034gkCgWBhSJYqyJ9WFq5xeg5hjMopmGdFFJGVBo4mZDVBUiAJQ3gybEcyd3pEWRxOjm2bNyYbm0wHUqLZLBoHqSnZy6aph3LU7PrRr1A+bnYEItIPYCcUGyKCpO/0Td+YemwyBnjFxLigBlZIe9Yv6TWCNOb7A4pUxQ9Tf7qO9tMTPOKtt63FCIsPE+b1g/Senzu5h11Vyer0sjRsryuerZsrPC5avFJrZRW6QmBmTWbv8lpkkmfkLz0yWfkoA4ByUW9vKa6SV+jPcaYMGOkYZhqRlFbwXwmQEbSoXC8vQXu0pOZYlvWoiFnD8jQBEzkh8qOKhCiqF6EtcoZHpNAh/ft3lOO06fk9dDgVZUtAw5ENBuK6n45Z3KLl0t6CF9GHoECymomy3VGIJ1PvzKOAc8lXv8bznDBWIaXNELTy0iMB9Vo0R/+cfiSQAhYISwXzy5VXEqDMXPAgEte0ubRnWbBqNm6WDjOTtJOuWJnZVM1w0gWBbs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X8aH5aXo80dK63DNNh9EUGO+oiU2VdokNxfTeGmY8tCY5ulQu3jbUH1iHfzc?=
 =?us-ascii?Q?YKqTuEbx/44AAc0sDWt4f1us1SmRO12XByfHFscIfoGChGdv5sN3GnClDtBQ?=
 =?us-ascii?Q?8vAM/UZCRrEs8xlEzmH00JpnXfcDpHE9KISL8WMwIxR5IWiVcdKaST1LbbZR?=
 =?us-ascii?Q?LPUbGeaxU0xPzfJeey7N8BnagwBewEJpURbX8UaLsHAqjkikEEOpVG5qVR1K?=
 =?us-ascii?Q?cVSghEp8/kAaRN1bhoSP1Qp6/637LWrPEcc2wr7Ryrtfqf6aPWlb7vKWfdef?=
 =?us-ascii?Q?xz+ln0fL8itQhRUA34ygeUDKlUy0Qcp4kn2ydRVMxfjyMWY8yNHcAg3lvauF?=
 =?us-ascii?Q?3dRfRvyXVWewbuAp4nNJnmCalSTpnLWKTEQgkTJViIHM6fvnIXxPJiRHjZmh?=
 =?us-ascii?Q?ZuAOXffc0y3pvMTnQgsTeacA6L54Se823imUcHR9wTrKZnqI5WFhya1zoUU6?=
 =?us-ascii?Q?1mjv3VoxK1a18bNRPxZ/EjQ4trESKHwqi5lgnufeDgbqf1g1LGUL/jpJ7lQp?=
 =?us-ascii?Q?K5a6BHyMg8PINu1FCDhnR9+oyFZmEOhSoPfi2CE44oq6ar+8usye5eFxFJTw?=
 =?us-ascii?Q?42SiOtKD+de1AN0p+ntsFEY69XfCNjabcUNOk/59Clg/zL2ZWtrEhtjbvgVe?=
 =?us-ascii?Q?nNrYYBsyDPaxs6sKfdJTVaqG6vVsYCOtg9A5dPmaR/u5UYLuuHXQuKC2ZDCY?=
 =?us-ascii?Q?okpCiOBpMNqcxl+21jVHg/KfMOad8c0ps961MmGT47buFFKAVn3w3cxluEcd?=
 =?us-ascii?Q?nbOpT5wUmpUR3kENY0C/3L0eahl6gmLy2B5rUjftYVPTMyqQv5yyeNXZ2HvN?=
 =?us-ascii?Q?wO5n8E/cGqbe2iGaCCTnn1iaZa4/ArkPDAxIFfVVR/L/WoNYv70r+q9o1CHT?=
 =?us-ascii?Q?5BYIkt0DNg8su/PapctjKjUcoUbg7RBvz2dJjVzzl5/1brDaNxgKVutFYwMO?=
 =?us-ascii?Q?vnLkvole63himnqwEMTbYjzb9MxQG0idu1/4/+hHUk1lZ2+yNzZWYndsbDhd?=
 =?us-ascii?Q?hrSjjITqZkjjMk0YcnqoZ9gspl6GG0e26W7pho+42vZOJ2rIHqgyVbxemVQk?=
 =?us-ascii?Q?B4x8irpU6CIXp1Zd4QAj5EDektbgEsn/6ZzOeHfulIdD4X7TQjko15JY9HZv?=
 =?us-ascii?Q?0tu+XHhqSOBunbXWa1pOMgeadj87sDb8ME2pI3v7xibNvSdmnZetQH7FJl5a?=
 =?us-ascii?Q?thrGUB21mosDqzDtIVrsvQihAgkb/BPUgHVOM6YC9Tni9C/Wq8iygkiwMZQB?=
 =?us-ascii?Q?P21ZHEqyzPNq6558owARwUMSqzL2hQITRxtfvdHxlHlJIEOTBz4KIM8jNuPA?=
 =?us-ascii?Q?1fQD3BvSnBk/exxBVkz8DsZYMRsXwN6xDSOT7IPqfBgT7pL+67aaqdXw7i0Q?=
 =?us-ascii?Q?mCtjxYYvtqAWY0PIOKwFbS9EawWpLzgZ8mhHHYC2KFSyx/z6DVbOF6UNNDS3?=
 =?us-ascii?Q?k5xpGX4ZUSfYi+Hs8u1VAgOGp2qW/B/pBwUIu41Ziyb7TN7jo8aNjaaaN1BG?=
 =?us-ascii?Q?/oqjzYnir7od2LbroOMiY21KbysiwtIr5kiKnWWD7Tpnrf1paMgMJhNu6/y8?=
 =?us-ascii?Q?/Jjh6+tPBEaRNH4QWSF/LlNSL/GqBh5+WjX/kRI8OWT8RnToK7n3bbS00+gc?=
 =?us-ascii?Q?+K8DacAMZpysIjsKNVX3Njw+DiV52yu7sIlfIeSfGi+CxZccovGgFz3eTwMQ?=
 =?us-ascii?Q?AvsQlofdy0VMsu9TGkd7mDCtEWiSzfh2Ajf6okLYvj/TP4c1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2de138-44ce-4d90-488c-08dea4d4bdcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:17:55.7315 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HmB4sf4R5ioWBjzzHI7kAivMFhlAsikOdMwM1H7+E0LpWg28dDrRaqD1DXz3jJH/J1AVY139cVtaRIXqt+BDgA==
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
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 16/17] drm/amdgpu: add profiler/spm support for gfx9

with implementation of amdgpu_spm_funcs callbacks for the GFX 9.0 IP block =
and wire up the RLC Stream Performance Monitor interrupt GFX_9_0__SRCID__RL=
C_STRM_PERF_MONITOR_INTERRUPT into the IRQ framework.

SPM function table (gfx_v9_0_spm_funcs):
  gfx_v9_0_spm_start(adev, 0):
    Programs the KIQ ring to:
    - Read-modify-write RLC_SPM_PERFMON_CNTL to set PERFMON_RING_MODE
      (0x1 =3D stall-on-full with interrupt at segment threshold).
    - Write CP_PERFMON_CNTL.SPM_PERFMON_STATE =3D
      CP_PERFMON_STATE_DISABLE_AND_RESET to reset the SPM counters and
      clear wptr to 0; manually resets RLC_SPM_RING_RDPTR to 0 to match.
    - Writes RLC_SPM_INT_CNTL =3D 1 to enable the SPM interrupt.

  gfx_v9_0_spm_stop(adev, 0):
    Programs the KIQ ring to:
    - Set CP_PERFMON_CNTL.SPM_PERFMON_STATE =3D STOP_COUNTING.
    - Set CP_PERFMON_CNTL.PERFMON_STATE =3D DISABLE_AND_RESET.
    - Reset RLC_SPM_RING_RDPTR to 0 (wptr is also reset by hardware).

  gfx_v9_0_spm_set_rdptr(adev, 0, rptr):
    Writes rptr to RLC_SPM_RING_RDPTR via KIQ ring.

  gfx_v9_0_set_spm_perfmon_ring_buf(adev, 0, gpu_addr, size):
    Programs the ring buffer via KIQ ring:
    - RLC_SPM_PERFMON_RING_BASE_LO/HI with the GPU address.
    - RLC_SPM_PERFMON_RING_SIZE with the buffer size.
    - RLC_SPM_SEGMENT_THRESHOLD =3D 1.
    - CP_PERFMON_CNTL =3D 0 (clear any leftover perfmon state).
    set_spm_config_size =3D 30 DWORDs per KIQ ring operation.

  gfx_v9_0_spm_funcs is registered in gfx_v9_0_set_spm_funcs(), called
  from gfx_v9_0_early_init() before KIQ and ring function setup.

SPM IRQ handling:
  The SPM interrupt source is registered in gfx_v9_0_sw_init() via
  amdgpu_irq_add_id() with client SOC15_IH_CLIENTID_RLC and source ID
  GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT, connected to
  adev->gfx.spm_irq.

  gfx_v9_0_spm_set_interrupt_state(): enables or disables the SPM
  interrupt by writing RLC_SPM_INT_CNTL =3D 1/0 via direct MMIO.

  gfx_v9_0_spm_irq(): called from the interrupt handler, invokes
  amdgpu_rlc_spm_interrupt(adev, 0) for XCC 0 (gfx9 is single-XCC).

  amdgpu_irq_get(spm_irq) is called in gfx_v9_0_late_init() to enable
  the interrupt at the IRQ framework level. amdgpu_irq_put(spm_irq) is
  called in gfx_v9_0_hw_fini() to disable it.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 135 ++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index 016eed89d6f3..30df02d322b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -472,6 +472,7 @@ struct amdgpu_gfx {
        struct amdgpu_irq_src           priv_inst_irq;
        struct amdgpu_irq_src           bad_op_irq;
        struct amdgpu_irq_src           cp_ecc_error_irq;
+       struct amdgpu_irq_src           spm_irq;
        struct amdgpu_irq_src           sq_irq;
        struct amdgpu_irq_src           rlc_gc_fed_irq;
        struct sq_work                  sq_work;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 7e9d753f4a80..7435032c358a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2275,6 +2275,13 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *=
ip_block)
        adev->gfx.mec.num_pipe_per_mec =3D 4;
        adev->gfx.mec.num_queue_per_pipe =3D 8;

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
@@ -4056,6 +4063,7 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *i=
p_block)
        if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
                amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

@@ -4793,6 +4801,95 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct am=
dgpu_device *adev)
        return r;
 }

+static void gfx_v9_0_spm_start(struct amdgpu_device *adev, int xcc_id)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[0].ring;
+       uint32_t data =3D 0;
+
+       data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_PERFMON_CNTL);
+       data |=3D RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_CNTL), da=
ta);
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+                       CP_PERFMON_STATE_DISABLE_AND_RESET);
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+       /* When SPM is reset, RLC automatically resets wptr to 0.
+        * Manually reset rptr to match this.
+        */
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), 0);
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 1); }
+
+static void gfx_v9_0_spm_stop(struct amdgpu_device *adev, int xcc_id) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[0].ring;
+       uint32_t data =3D 0;
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+                       CP_PERFMON_STATE_STOP_COUNTING);
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
+                       CP_PERFMON_STATE_DISABLE_AND_RESET);
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);
+
+       /* When SPM is reset, RLC automatically resets wptr to 0.
+        * Manually reset rptr to match this.
+        */
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), 0); =
}
+
+static void gfx_v9_0_spm_set_rdptr(struct amdgpu_device *adev, int
+xcc_id,  u32 rptr) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[0].ring;
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr=
); }
+
+static void gfx_v9_0_set_spm_perfmon_ring_buf(struct amdgpu_device *adev,
+                                           int xcc_id, u64 gpu_addr, u32 s=
ize) {
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[0].ring;
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0,
+                       mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_=
addr));
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0,
+                               mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_b=
its(gpu_addr));
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE=
), size);
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SEGMENT_THRESHOLD=
), 0x1);
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), 0); }
+
+static const struct amdgpu_spm_funcs gfx_v9_0_spm_funcs =3D {
+       .start =3D &gfx_v9_0_spm_start,
+       .stop =3D &gfx_v9_0_spm_stop,
+       .set_rdptr =3D &gfx_v9_0_spm_set_rdptr,
+       .set_spm_perfmon_ring_buf =3D &gfx_v9_0_set_spm_perfmon_ring_buf,
+       .set_spm_config_size =3D 30,
+};
+
+static void gfx_v9_0_set_spm_funcs(struct amdgpu_device *adev) {
+       adev->gfx.spmfuncs =3D &gfx_v9_0_spm_funcs; }
+
 static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)  {
        struct amdgpu_device *adev =3D ip_block->adev; @@ -4807,6 +4904,7 @=
@ static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
        adev->gfx.xcc_mask =3D 1;
        adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
                                          AMDGPU_MAX_COMPUTE_RINGS);
+       gfx_v9_0_set_spm_funcs(adev);
        gfx_v9_0_set_kiq_pm4_funcs(adev);
        gfx_v9_0_set_ring_funcs(adev);
        gfx_v9_0_set_irq_funcs(adev);
@@ -4862,6 +4960,10 @@ static int gfx_v9_0_late_init(struct amdgpu_ip_block=
 *ip_block)
        if (r)
                return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+       if (r)
+               return r;
+
        r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
        if (r)
                return r;
@@ -7100,6 +7202,32 @@ static void gfx_v9_0_query_ras_error_count(struct am=
dgpu_device *adev,
        gfx_v9_0_query_utc_edc_status(adev, err_data);  }

+static int gfx_v9_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *src,
+                                            unsigned int type,
+                                            enum amdgpu_interrupt_state st=
ate) {
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+               WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 0);
+               break;
+       case AMDGPU_IRQ_STATE_ENABLE:
+               WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 1);
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
+static int gfx_v9_0_spm_irq(struct amdgpu_device *adev,
+                            struct amdgpu_irq_src *source,
+                            struct amdgpu_iv_entry *entry)
+{
+       amdgpu_rlc_spm_interrupt(adev, 0);
+       return 0;
+}
+
 static void gfx_v9_0_emit_wave_limit_cs(struct amdgpu_ring *ring,
                                        uint32_t pipe, bool enable)
 {
@@ -7716,12 +7844,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_c=
p_ecc_error_irq_funcs =3D {
        .process =3D amdgpu_gfx_cp_ecc_error_irq,  };

+static const struct amdgpu_irq_src_funcs gfx_v9_0_spm_irq_funcs =3D {
+       .set =3D gfx_v9_0_spm_set_interrupt_state,
+       .process =3D gfx_v9_0_spm_irq,
+};

 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)  {
        adev->gfx.eop_irq.num_types =3D AMDGPU_CP_IRQ_LAST;
        adev->gfx.eop_irq.funcs =3D &gfx_v9_0_eop_irq_funcs;

+       adev->gfx.spm_irq.num_types =3D 1;
+       adev->gfx.spm_irq.funcs =3D &gfx_v9_0_spm_irq_funcs;
+
        adev->gfx.priv_reg_irq.num_types =3D 1;
        adev->gfx.priv_reg_irq.funcs =3D &gfx_v9_0_priv_reg_irq_funcs;

--
2.34.1

