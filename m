Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E94CC67861
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 06:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04726112111;
	Mon,  8 Apr 2024 06:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jYiqC9uX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2115.outbound.protection.outlook.com [40.107.237.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8C5112111
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 06:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9vAfrugQrMWnDqkFkQ+DrOxUVXQOrjq8yOqE1LjRjW6cn61W1kbORYKjnTPJRWe3i4+nKLUD4yFdXkhmCAzFtUBmxaxb6C+t+Fim/zyu3S1O6fEg9/wAQNIfCavpQFE7sRKYUTndAoySGNjwvl+4Ooo78cb5N0nRb8D1VlikBxekGId3v2LRTXAfgkP7OEdobDJbiruUcXfIlb2Br1W70qZtrXbuOpk0bmYVKzsg+lB0JkKMzoE72bi2xeYgBTo9H+0ObVFcJ9VZe/5vgJrBKfd4H3e2yG0UWbG7x3w/hQ65Ex/u1+eYP1gkg4FCvqbMTG4X3Sj6VVHdS7a92YxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI/QWTejM1b6soXgMU1ZRj6ll926G34OPm505ci/qO4=;
 b=ddc8D3EemrF+YlK8YOoSwCLgURzXSS154pzHDVQN+OiwrAKneo/yBE4vQeC8OMLz1ktgjvg8eHbaD9CAS5ztGb5KzhNuhYWgEeHPlajLDj5qjvew3HmD7kcfTVcY/5pMY2n+bqk/Um+bd6KMW3f7zMQ/IkaZfQAvdfxPDBHfmuTjqhwUCgQCanU5V/CQD576zoNMdvWklokz0Yedc+zizR9vZCJKBFYvQbg7GY5Ko9RuEPNxqTvNAMXknBvsPC/6lyY9PToPKMWQPry82/eqfLT2tNZe3wVoy+ZlUQhCwv/4HpDVDBgkT0qBs62zBBNRGHDjDceoqNdsaaik39h19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI/QWTejM1b6soXgMU1ZRj6ll926G34OPm505ci/qO4=;
 b=jYiqC9uXE8JhULVGI/guPd837A6LZ3B4c1jVX89h6r1sP5uKScXdXVAa1tYSJ8UjugnxtCjn+MTCld41ef+F5zD1/wMv8MjQN/shHn0gN4KKIbmqjBfHBtGas+5uNLwW/Y7s+7EnHdrjwyuco8HYmvfbuvzq6d8tULnd/xyBx7U=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 06:17:50 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::b088:86ad:44e7:a075%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 06:17:47 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Process bif doorbell event
Thread-Topic: [PATCH] drm/amdgpu: Process bif doorbell event
Thread-Index: AQHahCXoN7HjiptXOU+fo2MqE11FObFd8IUA
Date: Mon, 8 Apr 2024 06:17:47 +0000
Message-ID: <DM4PR12MB51653E0DB94186B87774EE308E002@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240401111510.14573-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240401111510.14573-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6f269c14-7da3-4fc3-99dd-bae7b9047fac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-08T06:17:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|PH8PR12MB6842:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HH3Cg6QdYofU1Syz2LbTgP7p4GdugiBqtwzioTWyGZ7iQ2yvcQvG4cu9J3VIuWqF+TfZ5memjlAjLBVU3jN9Y38bzPnPjHRqkVIslkBOS3m+vucaiVMjpxeRY8u8vTp9wjxD5wBY6KUwkiB/Vx3VoQdOaC363YFPeBRzsaLwdkFariKZj7fHwvY4Gyh3sRjBf1t+rLBYQXGhOWwxDhbiavp1088w1B+crdN0qqHLgqDFNHPA2dxNeD/lrWoPEZr1CzRCWuNF4zLdwJgdRRnJia83Q5HPKp4UuWcNmRoSleOY7hl+Ob70pvoRaA/4976uUeY2ilCisTmxc91gJegK1FxlGDfmJtYgQmHLmVyz2CXpm7KbP2zGhoyNro7QhbHHG36ahU7UQoJdH3X1PtrXxDAc2YeAR72ocF8E6eCdXAk5aRK6mQQRz7CDlKIWK8ZZ2qa5b3XmWMgcWaSr4UcUDkjWaaGog01sMefpmcgXIKE2/zXafOdgCFM+lQ85eeP3+6oZmexEm8gCiNerfFARr5KsHxc/qoyqY7MSTxQBSq2NsZ3vzq+BycJfk6t2d3KM5O88Mu0rH7e3QZ3xdHqUCWV+EKTOak90biylN/FUns3G4jqBtBv4ZljYwOrgl9NfQMQMWbggwr9T+LnHC49mKPzI/vBGrGzyLSnBUYMOhSY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TysEA7YDVBsvuY7x4PR9g1RmsksQrIJWylGfwQ0knxNfL4rlq4Mg2vPJQBlh?=
 =?us-ascii?Q?8tXMoASb3GKZltelQSAKYYAx7kwpefixwNHcCx5oJ/Aobt4Wfk3NoR38Jh+Q?=
 =?us-ascii?Q?zv41CebrLQz2kACofyLARuOx2q4jp+qMVWOMk7WYHl8MOt5jcgICZkr2W/99?=
 =?us-ascii?Q?Xp3aEBoZaX0w7wfVS+bRfD/DN8CXlBSaooYHaRRT1nYdS0jBVh0uihptb8Bp?=
 =?us-ascii?Q?JwRKMywWcXUaIz0MDfFbO4nwfvxP5+kZ00Bul68Vc5ZJ6wsodECqUGP+h/Ry?=
 =?us-ascii?Q?uvgdE8FacNhvDRT+U0ZFVPohDF2xk9LaPrvcxBO9vviugcLJb0ElQX8wvht9?=
 =?us-ascii?Q?oMJ4MAiABcU5OmLqXsT+NXEJs4K0tLrPlrzQNm7wR14rZmIovaBxa+TQt/N+?=
 =?us-ascii?Q?7O6cXhZyMWKzwCmnqnCNRn8INOtCpGK17H1M55QD3lICsqJEH4LPd6w6R5L4?=
 =?us-ascii?Q?UGiJkPF5UnHcM8QG7lrtXgTpwCTLksgtelVJgrJbS4l1CG2hm2KQqGuRIqMt?=
 =?us-ascii?Q?9kmwFJz6lzi9byexvd23fXbg9E8pQ5nTqCdEPmcJ/95hT1qNN5LuaQ9ZtVvO?=
 =?us-ascii?Q?f6R/8rWtbo6FslV+NAhIRgICUPfivb9uF0Wa5823DG2dzjgtKFHMVfLqPwtS?=
 =?us-ascii?Q?bPB07FiTAqHsRHzomISO2HeD5Gb6BDbrxIL4IChnMPMpMbu79zNdvPvuHMKl?=
 =?us-ascii?Q?voiSDd7LCUGBX66kdNTvH9yUBWlQ8aS4ytxDSZqb3Gr26kIpjlvMjwuQ16PJ?=
 =?us-ascii?Q?SWYMcA2izOpKYz0MbC5UNcK1D3/xk9mdkzAxZRN0bxq1BA1JY0bv/2K+CSpN?=
 =?us-ascii?Q?+z8u5/fkjZT1toOl0ryhgi0eCBV5uXZgalOwr2f3xK3UTGcmmPZBqRelWS21?=
 =?us-ascii?Q?7rYGGEKpfT9T1puuL0PR++TdHlwLKyF+AaaxL1MAm433uEsJR9nK5AwYmQAn?=
 =?us-ascii?Q?yjna7d8mUfkTroe7E0BngQUywfTyTQ+wqsBeqwjgvEx3LZgzgmOiogbSBnxm?=
 =?us-ascii?Q?HjOLloqDKvIztNr4OpwURtlDVfwdLuj6V88H/5i+CnewIhMe2ghrDgvrzzdo?=
 =?us-ascii?Q?jG9iFQD+kcbSc+bwkfGRzDNo9g5ojJCnQh2oRM2OZlhGItrtvz4fTcB1uzZN?=
 =?us-ascii?Q?8AouEhQs3gd9/+Afg+/GpNzEOBconQS+KQbWEOGs0AU2SMLl81xSKB1XPwIY?=
 =?us-ascii?Q?agGrVeasgXcKZy++4LK9jgnPTTXae8Grb/ammo37nL2A7fvQ0LxgPv8N9j16?=
 =?us-ascii?Q?ZkrXkrypb/OLgYS6q/nZrSOYQkqXDjrR7BNmsxdlHMOAX8fh8II9Whhg12dX?=
 =?us-ascii?Q?SuGPAB3EezY9TsgvVl8kX8A0kGiG5phaY4bpi8I7k80GkwSLYOIbOfL3gVmF?=
 =?us-ascii?Q?+tm0bNkpEiHoPFd13Tc4WSBqdqWtUbg8EYjoLaH8AwF1+LLRHQQ3xAnhaXo+?=
 =?us-ascii?Q?sAxGfS6YBynwJWZU6Bt/LKTMWfUxY9kdi6t+ma5p0MHS8q/H7AAlAV10av3/?=
 =?us-ascii?Q?Oyz6XAzh45zQ7Eauoi4xaAWEN0yuHA4hkmYc5MUTAmPi5aBefXS+Cqk30ttQ?=
 =?us-ascii?Q?8pMxQfccYPc7+J7SqpE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5332dc-ca8d-44b0-0696-08dc57939c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 06:17:47.7479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GvMQJnUs91ReYeYTFeVn12QJCv3GunK641KB0iKVYy8jaEiMAPimsFxbpBTYFD9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
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

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, April 1, 2024 7:15 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Xiao, Jack <Jack.Xiao@amd.com=
>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Process bif doorbell event

When BACO exit is triggered by doorbell transaction, firmware will config b=
if to issue msi interrupt to indicate doorbell transaction. If bif ring is =
not enabled in such case, driver needs to ack the interrupt by clearing the=
 interrupt status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 +
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c   | 56 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c       | 14 +++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.h
index 7b8c03be1d9e..db341921cfc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -102,6 +102,7 @@ struct amdgpu_nbio_funcs {
        u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
                                         u32 *supp_modes);
        u64 (*get_pcie_replay_count)(struct amdgpu_device *adev);
+       u32 (*init_bif_doorbell_event)(struct amdgpu_device *adev);
 };

 struct amdgpu_nbio {
@@ -111,6 +112,7 @@ struct amdgpu_nbio {
        struct ras_common_if *ras_if;
        const struct amdgpu_nbio_funcs *funcs;
        struct amdgpu_nbio_ras  *ras;
+       struct amdgpu_irq_src bif_doorbell_irq;
 };

 int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev); diff --git a/driv=
ers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 7f88a298ac5f..e5a331b6eee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -477,6 +477,61 @@ static void nbio_v4_3_program_aspm(struct amdgpu_devic=
e *adev)  #endif  }

+static int nbio_v4_3_set_bif_doorbell_irq_state(struct amdgpu_device *adev=
,
+                                               struct amdgpu_irq_src *src,
+                                               unsigned type,
+                                               enum amdgpu_interrupt_state=
 state) {
+        /*let firmware to config bif doorbell irq state */
+        return 0;
+}
+
+static int nbio_v4_3_process_bif_doorbell_irq(struct amdgpu_device *adev,
+                                             struct amdgpu_irq_src *source=
,
+                                             struct amdgpu_iv_entry *entry=
) {
+       /* pmfw will config bif doorbell irq to host if baco exit
+        * is triggered by doorbell transaction. In such case, driver
+        * needs to clear the interrupt status */
+
+       uint32_t reg_data;
+
+       reg_data =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_RB_CNTL);
+
+       /* if bif ring is enabled, do nothing */
+       if (REG_GET_FIELD(reg_data, BIF_BX0_BIF_RB_CNTL, RB_ENABLE))
+               return 0;
+
+       /* write 1 to clear doorbell interrupt */
+       reg_data =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL=
);
+       if (REG_GET_FIELD(reg_data, BIF_BX0_BIF_DOORBELL_INT_CNTL, DOORBELL=
_INTERRUPT_STATUS)) {
+               reg_data =3D REG_SET_FIELD(reg_data,
+                                        BIF_BX0_BIF_DOORBELL_INT_CNTL,
+                                        DOORBELL_INTERRUPT_CLEAR, 1);
+               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, reg=
_data);
+       }
+
+       return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbio_v4_3_bif_doorbell_irq_funcs =
=3D {
+       .set =3D nbio_v4_3_set_bif_doorbell_irq_state,
+       .process =3D nbio_v4_3_process_bif_doorbell_irq,
+};
+
+static u32 nbio_v4_3_init_bif_doorbell_event(struct amdgpu_device
+*adev) {
+       u32 r;
+
+       adev->nbio.bif_doorbell_irq.funcs =3D &nbio_v4_3_bif_doorbell_irq_f=
uncs;
+       adev->nbio.bif_doorbell_irq.num_types =3D 1;
+
+       r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_BIF,
+                             NBIF_7_4__SRCID__DOORBELL_INTERRUPT,
+                             &adev->nbio.bif_doorbell_irq);
+       return r;
+}
+
 const struct amdgpu_nbio_funcs nbio_v4_3_funcs =3D {
        .get_hdp_flush_req_offset =3D nbio_v4_3_get_hdp_flush_req_offset,
        .get_hdp_flush_done_offset =3D nbio_v4_3_get_hdp_flush_done_offset,
@@ -499,6 +554,7 @@ const struct amdgpu_nbio_funcs nbio_v4_3_funcs =3D {
        .remap_hdp_registers =3D nbio_v4_3_remap_hdp_registers,
        .get_rom_offset =3D nbio_v4_3_get_rom_offset,
        .program_aspm =3D nbio_v4_3_program_aspm,
+       .init_bif_doorbell_event =3D nbio_v4_3_init_bif_doorbell_event,
 };


diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index abe319b0f063..ee6d810589c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -792,6 +792,9 @@ static int soc21_common_late_init(void *handle)
                         * nbio v4_3 only support fatal error hanlding
                         * just enable the interrupt directly */
                        amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athu=
b_irq, 0);
+               if (adev->nbio.bif_doorbell_irq.funcs &&
+                   adev->nbio.funcs && adev->nbio.funcs->init_bif_doorbell=
_event)
+                       amdgpu_irq_get(adev, &adev->nbio.bif_doorbell_irq, =
0);
        }

        /* Enable selfring doorbell aperture late because doorbell BAR @@ -=
806,8 +809,12 @@ static int soc21_common_sw_init(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev)) {
                xgpu_nv_mailbox_add_irq_id(adev);
+       } else if (adev->nbio.funcs &&
+                  adev->nbio.funcs->init_bif_doorbell_event) {
+               adev->nbio.funcs->init_bif_doorbell_event(adev);
+       }

        return 0;
 }
@@ -855,6 +862,11 @@ static int soc21_common_hw_fini(void *handle)
                if (adev->nbio.ras &&
                    adev->nbio.ras_err_event_athub_irq.funcs)
                        amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athu=
b_irq, 0);
+
+               if (adev->nbio.funcs &&
+                   adev->nbio.funcs->init_bif_doorbell_event &&
+                   adev->nbio.bif_doorbell_irq.funcs)
+                       amdgpu_irq_put(adev, &adev->nbio.bif_doorbell_irq, =
0);
        }

        return 0;
--
2.17.1

