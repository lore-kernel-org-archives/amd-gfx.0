Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC31C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 06:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BC010E32D;
	Tue, 28 Jul 2026 06:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zi6oZOLW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F34910E32D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 06:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITMFrU4VYUaLDxSgEMa31INcWdERiKN+37Rv9HTfWLaC7BSZrijECvT/66oOe9XyjwXAv7fBIQUhvXg9U4NF9sLoeFSB7b6qRhPDY7vt1MItzQ1b8y3PmDENu09Cr7sEd7SVNYIPQfE9En9JfDeFg6qiFI+fiDMph6HLlThN42xJWX0ndwRrgqBUDrm6n/ovguOnDBXj3sjKhtdyP9X7ROTIdjOS0J0sHZkkVrIdoaFuL33sA1SLrd4gYoYeLGfWRYnMyxls7/PxAJCcKFwpD/k5ZIvluh+n/OeJbuulnPOt6Cc7P49KmDDVVRQL+eV+l9bdbTJfS1d3XmenyyUF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLCJR9zwMJWalzfH8RZ2AthJcTvKQ2Uavz5sWZCyI4I=;
 b=dogMYWnGN4YL3er2WScHQ5f02u7YYHpHAE6gd0/UoXWTj7EUbk4wkOxC3RUAUvsKlo7wk3EIOhe/lZj8NxUnIb2ksJ52rWBcc4KnyT5yj9f8ZkUnFV/ftScQC6mQufIk5PEq9CbbRAyhsefVI6tbuNPGn5APxr7B0Ffy1YN5huvnX65mHii4E4klOGCx/vuLkd8i3C6UMftUZmzAiNUY3c7xUutM+yGU9wrbsnq4gl3qG8VundDXNnSqmvpstul9vjDqg6+FgEHoQH7+94PQIlrXlTBndE0p0hlK9hvI8MCKgdd5HSU/GPe31V+yBiayjpop0in0svxP0AZUqJlgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLCJR9zwMJWalzfH8RZ2AthJcTvKQ2Uavz5sWZCyI4I=;
 b=zi6oZOLWS1uIK82lMyeSbHkIIquAsY6SwZS4edodVhPlrTHZrYFPOaYIYoFNlsc4VO8vLQkVuAGjwweyZ1PfZYSwlH46qIdKDoxqkJZMXLLY6H/B/He0r8jRzb4m2WT14O5JXpvLPzRiT4W1Iz4Prjoyl7Z1OZi0RGg3J9DKMLk=
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645) by LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 06:33:08 +0000
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::b4ee:f931:50c1:323d]) by DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::b4ee:f931:50c1:323d%7]) with mapi id 15.21.0245.010; Tue, 28 Jul 2026
 06:33:08 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer deref in
 amdgpu_vm_handle_moved for BO-less mappings
Thread-Index: AQHdHjL06R/jQeVdpkCwAU+jYqZ8w7aCeKyQ
Date: Tue, 28 Jul 2026 06:33:08 +0000
Message-ID: <DS5PPF18A985A1013940619C970BC39BED194CB2@DS5PPF18A985A10.namprd12.prod.outlook.com>
References: <20260728014631.4001668-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260728014631.4001668-1-Jesse.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T06:30:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF18A985A10:EE_|LV8PR12MB9620:EE_
x-ms-office365-filtering-correlation-id: 76242b4d-f80c-4d21-07ee-08deec7216ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|3023799007|38070700021|11063799006|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: TqsGQ/VQITX5isHp8LNW/1D3c4ztpI3J6nDF19s19G6PZC581Ji8Gij4+sgx7EIxFRyqkLoEUzaDhF+BKAY257XtbHo7WQ5cAXZiGhStb1fW+RXF/7hL+ce2MGFnJhrkJ5EW2NVKWVSA0xIjYytT0+OfTrrNMH+IIU+Qjlurt5Stt4a6Au/SKLhPuXNU3oBpY0ue8/YvUNPhzGzAcxfvGI4G37fjys1QJakisJnPqvEKHbiyXCV0hJkZUzKTDPWXw48XIJkvzyQtw5EOwIuqHtN0Ovc5NVX5YHWKW+MaWj+lAgk+8I+04afS9buWcJyXiqrLyK6vvGoeApx9x8YsYqKETTg2yW2oR3qDf1KuLFAw/Egwae9RZEZ76qJM/nR+gdLCfnVWcbnC9vLDPBobqGeSLfoaNiumWHReUrHGD2sseYz3dVEGtOhq75sqBKSBf5LiOCyhEnI9gYeIeNhhxjRpbxPgIsjEhGc2aBBBgq7mM4kNat0LMQ4tvJCVbo+6xzHKufKF3NPW8vhWB7FSHbFKIMNqGnj29rTNuR9fWs7JoKxdrUrseVrOGIxvEoYcnat0cV/1KcPlK1D28y6xlbQ0skGUvvwUck3AtHYQM3sCdSzqiQGAaejskuCvXU24Tcs2ulEBH8ZkziUQjVuZ5HhCCAe2qo6zmKJGJ03MCXVGNYNE3ThzqtwJOWU5michJpTuAFFd099Jcgxin2+qaTXToXG8HmpHiHqt+a5hSZ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF18A985A10.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(3023799007)(38070700021)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?02oGzuAoQ5eVlmS4VNrwNO0jFFpQ3YgYB9tlOObwwsJr9iA2/8mdQPIe5y8y?=
 =?us-ascii?Q?VEo+HYklgCYRbY7dMa4zKN/3FLZYzq4qHm6De/WiFkmpkuB+eX6cQugIFeug?=
 =?us-ascii?Q?C2QV2Kj1YkMy4znIU700q5+GP/fzMnOvdVqu5AOyB1qKtg25KY0oHlDrzyqT?=
 =?us-ascii?Q?rBLbn+rnitxqsi7wdJ4XuvqLUFc7Yk3y/bfhhIRf/XyhwLa+RIXRbAXOTRwP?=
 =?us-ascii?Q?KFyPuMsxnrHrkM7FsJvIyvFDS9kQO5hp4YZMxeeVIjKsCw6/Pxh2L1SmYJ/g?=
 =?us-ascii?Q?6+CeS6MnP05fBC5OhvcVjiJ1h46RXkVXo2WaD0Pxkn7M6Vdv5qCO1Lv0dcVE?=
 =?us-ascii?Q?DqS+5Gv78WLHV63eiPm+g6tuESbwnKX0TzbMC+EVzBH8KYg7VWDtZ/EAm5bq?=
 =?us-ascii?Q?uVa7VCZQuAerYQkiaibV1ZweEaNAqODsRnZGvI/DbgzxM3NaS4ZFSxkOPEia?=
 =?us-ascii?Q?JcSetqO7Ou3zRu5NuFeoEQep9zuyqMTxiz6B9SEfjkIizyzGTNZHoiK8XavV?=
 =?us-ascii?Q?t/vfziPv+bQ3JJFvoQZXTg2NXBZrm/O7I1NPDhoLvTwtk9lGQ9d7RyWxVIda?=
 =?us-ascii?Q?XwHg8tILDDKMwv+g7clN2SScWScJaEk6u/Epm/QfA2VkGaS/IHY2aWD+AGwl?=
 =?us-ascii?Q?MetOXMmzmj7pz1CnHQbtx5mRtiOG71grBEBQtDWaIeGwYaJ6MP+jDr7YDzt7?=
 =?us-ascii?Q?xNXdyN5Nq+ULuYD/qU3BUczkFF10vpqkDLhuRkfmilMlLCxPkMa7vIzl79j6?=
 =?us-ascii?Q?FN97jc+0xGBfgGdPxw3gsL74tkaIRZqocYI9iMcpX8nh03hn+G1tTWgLCtL3?=
 =?us-ascii?Q?9kBFUBIkEz0MTu7ciqF+lhWumHAjk5UkNVkVx7sVdBZukGPzoKz/xdu6d9LJ?=
 =?us-ascii?Q?GQrhIXhv6oPL157DMSrHsyTRRxPJPazLhUgiQNTYMrVjtPbK1S6iM2OZQOJi?=
 =?us-ascii?Q?YREVoM6xH6YlopJ5JTkSaVtkI0mfeUYymhNuc6NUFbPVjYpNGEk5wt0OqwMW?=
 =?us-ascii?Q?SghryusC3T/wqgwERENnjE1V+BXlyMjwvuFI2JTMnnwqoH+vYUGxPF0lXLSr?=
 =?us-ascii?Q?sgFgTmRuJ8zXm+GUxKme+jnqks/2sNhd6Y1qBSyjeRbyOnARRlYCSvcaAV7u?=
 =?us-ascii?Q?IUOy6IwIaVHDs9rzyyhLNYHXngRIwwck+HC5/0KgN7VwCG/UFw+MiM8d5N6O?=
 =?us-ascii?Q?sWN1uciBEAjunmh4/UpsFxlbl5fdjkXP1wzZ0blEvLjoerpA0BNhUlEsD8yv?=
 =?us-ascii?Q?p4XfvxKGI3abeSMUrhQRmYXZTK2g4ED1NkFkpZAdcN4u10ZDNpXzo03X2TLa?=
 =?us-ascii?Q?E32DBW3xu8/T1bPTYIhyFIgNT31lrBQNkcH0/tb3mokk2VCwNf1yL32Ysk/r?=
 =?us-ascii?Q?zTAiFR5wdFYr73i19sgkJt9Oeq2TTkGoJLNn8ORaSLWyAzlV1Bvr6kPwfacH?=
 =?us-ascii?Q?x5WKniiVc7kksy+LoB8WYPCrUCytWlnJky57NM20OzZMVI4QTrqCriM77G0b?=
 =?us-ascii?Q?O6IlfCXMB6/ohOCd1UR2up1NyGufSurQOl1DrZSg/rWhH65s3OAOG0djDOtu?=
 =?us-ascii?Q?VP7AAgfFrVrXEWOnBhV8bUG/xa8FTdZiHJlKa37la8G8SSQtHrYig7iBZhkG?=
 =?us-ascii?Q?Du7lrysVqPFyliR+yGGs7VaVPbMfzIgoLPkGzPHkdBfkB0y746N0YTkpOWwN?=
 =?us-ascii?Q?iYxD9UBlNFS14qxIDbcJ3pccMCHrJXAYDtiU3LNgM5ngyoHx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF18A985A10.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76242b4d-f80c-4d21-07ee-08deec7216ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 06:33:08.5679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xp6Bfi5OItCrr3MiBsaqFqeeo0sOzVQfMq8wrZgqcgy9z/MeZ3Qh3+uFmJwZcbVBZv8Gyve0ilasN8V/+SrjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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

since the new bo && guard already ensures bo is non-NULL (and equals bo_va-=
>base.bo),
use bo directly instead of bo_va->base.bo - e.g. drm_gem_is_imported(&bo->t=
bo.base).


Regards,
Bob

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Tuesday, July 28, 2026 9:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix NULL pointer deref in amdgpu_vm_handle_mov=
ed for BO-less mappings

The individual.needs_update loop in amdgpu_vm_handle_moved() unconditionall=
y dereferenced bo_va->base.bo (to read its reservation object, ttm_tt and t=
o test for a DMABuf import). However bo_va->base.bo can legitimately be NUL=
L for PRT/sparse mappings - amdgpu_vm_bo_update() already handles a NULL bo=
 via its "else if (!bo)" PRT path. When such a bo_va reaches the moved list=
 (e.g. the userq eviction restore worker running amdgpu_vm_handle_moved() w=
hile a user queue is being torn down during a GPU reset), the NULL deref cr=
ashes the kernel:

  BUG: kernel NULL pointer dereference, address: 0000000000000158
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP NOPTI
  Workqueue: events amdgpu_userq_restore_worker [amdgpu]
  RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
  Call Trace:
   <TASK>
   amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
   amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]
   process_scheduled_works+0xa6/0x460
   worker_thread+0x13c/0x290
   kthread+0xfb/0x140
   ret_from_fork+0x1b6/0x2b0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

The faulting instruction is "mov rax,[rdx+0x158]" with rdx (bo) =3D=3D 0 an=
d
CR2 =3D=3D 0x158, i.e. reading bo->tbo.base.resv off a NULL bo.

Guard the BO-less case: skip the reservation dance and the DMABuf-import ch=
eck when bo is NULL, and let amdgpu_vm_bo_update() take its existing PRT pa=
th.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index aac8ace9d7a6..fbb76c32bff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1631,11 +1631,17 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ad=
ev,
                bo_va =3D list_first_entry(&vm->individual.needs_update,
                                         typeof(*bo_va), base.vm_status);
                bo =3D bo_va->base.bo;
-               resv =3D bo->tbo.base.resv;
+               resv =3D bo ? bo->tbo.base.resv : NULL;
                spin_unlock(&vm->individual_lock);

+               /* PRT/sparse mappings have no BO to reserve; just update t=
he
+                * page tables (amdgpu_vm_bo_update() handles a NULL bo).
+                */
+               if (!bo) {
+                       clear =3D false;
+                       unlock =3D false;
                /* Try to reserve the BO to avoid clearing its ptes */
-               if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.tt=
m) &&
+               } else if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo-=
>tbo.ttm)
+&&
                    dma_resv_trylock(resv)) {
                        clear =3D false;
                        unlock =3D true;
@@ -1659,7 +1665,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev=
,
                /* Remember evicted DMABuf imports in compute VMs for later
                 * validation
                 */
-               if (vm->is_compute_context &&
+               if (bo && vm->is_compute_context &&
                    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
                    (!bo_va->base.bo->tbo.resource ||
                     bo_va->base.bo->tbo.resource->mem_type =3D=3D TTM_PL_S=
YSTEM))
--
2.49.0

