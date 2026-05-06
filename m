Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73896FF8855
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 13:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E90210E53B;
	Wed,  6 May 2026 13:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QTBD/aDk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E79A10E53B
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 13:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCJhy5DYv/fIdgm0lykbF4eVRp5pcV72xRmbc0LxkyMFsbxe30MhlP3ZqV6phUnBBlzWM8WTlDlup17uSDoypb1aOn/WwXVgX7PM0+DRaSgumfftWvRSAw6VnJ6spfZeqHsLFOs6EWd4tzrht5e4DbQDZy7dPsut3/VTYdq5UEenyXpYQixD2Vrm1gMBA23/vS7vYNIbAKlcYe5pFeOIsa8ymC+9VqmtsCxl9Yl9rE25Z1IgBgXXQILs1A3N5rSg2hLRWDaRcoevbRnq4KzjdHxhRgINx3QOf8pJMG5M8FMeTxqa6qWUQiC3oi/E3AGxNra074yspLB1ahXm5DWGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=el7OxrwlAEbGic1lmEEKEy/l4b9Slx8QJeNqDrPAyo8=;
 b=ysinNJsJ4PVHWN/IZxJAwSue9Z2F5dp2BoM6qrt1tCfRGHQyo7lUtZ422MZZD1fHCaFsFnWRI24yjR/Fu04zONoq2k7uOkTixWSZH4UkFv8Ch1/OcWIigXu3DZnRSP4jFo6oRsWpEf943ilNSUkG2iGGiDMZ22ftKBzCUxO6PGcS9d6xRyDT53usFAfxLlywN2GBq7Er+BfUFtaLmuXvlbiuDQV4ZJ8xFnP//BFqXMs19GBnMa2QUAlZNqzRNehdY9ymKyRX+faMu4pjsL254A2LREFQAa6DyCoKB4C7dUWrl0FqnGlCINUwv2bxeyr20zy5lB1ZgCkoFzg6LTzRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el7OxrwlAEbGic1lmEEKEy/l4b9Slx8QJeNqDrPAyo8=;
 b=QTBD/aDkYAy2znKQpFVzV7O7OoKbTC+rEWrZbzE1MJjz8uDI7UJ2Xc6JTfX3k4VCi+CALJwis3BAwNmoVm5gR4O3MrpikdQ791h/0W368qNKO0WpheiboZJHe6MPC/bOfa+NBI4n3Utao8HAOyJYxhl8pOLGtw3ausfSysTq3Mo=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 13:15:11 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:15:09 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Fix IRQ-unsafe spinlock
Thread-Topic: [PATCH] drm/amdkfd: Fix IRQ-unsafe spinlock
Thread-Index: AQHc3BLMY2nPvlTjVEe6XxLT9MK/jLYA+zFP
Date: Wed, 6 May 2026 13:15:08 +0000
Message-ID: <SA1PR12MB8144986B4DB5F0D2C8874CC9EF3F2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260504220954.1496706-1-andrew.martin@amd.com>
In-Reply-To: <20260504220954.1496706-1-andrew.martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-06T13:15:07.708Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|CH3PR12MB7620:EE_
x-ms-office365-filtering-correlation-id: 980c077e-2c0d-4321-c7da-08deab717f01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: zt6rvSLK51h6OcnXlyBccZ1wNf/eU8d/RKyoy/JezTG5Mksw6Lff26Mvg4JfLaCTHCmQK/qhxlpWsZjJN4dQ62FWBvuK6p/iSt1EHOXeZy1myJcYvruRzKrPem8Sw+ehDN/7gDN7ZKF4viqNcjo0rMKkdO53iE1oNVrfR+YSzyJ6riGcLUAicEUqU0XP6ODCPFJnXsTx6JlvpqBd5hH4t4StdpMMCc6jgF4SkVBzxuUkoTRjo5jaKgU6HWunRlgnsk+RmhLvML7VqZCZIxvyUICLAEjcKlfWRUAdTKjcmmYKG0Nh0vpUSRGgCZ1UNfARm3RAkXnz0AyUke6OLv5cvb5vC46CVZP7j5wFdN5HmyRwTdqE4AMoamJq5wJCrk0tQW5JgFTYdns4bVTGQQ+elu2dBitklD9SBiZMRqSI+UseWmCRrPVAd/miKpYP4acsIy0bK5WMwxTthJf0Tdug2MAmBmnj42ynPaVFR6Yy8QmAilowG6YUJSr5CpVckq6Lpuskjz8JYjvE1g1Qx/Wiqy3Pggw9hcMcRkzyAdMVBCnrdW1k5gij9d9aLQZL15jcUANsBm5ZclBYXYZDIZ0jhHL5+iQKEkIjhpwF5k9SoNJnmp0T5Bf5e2OU1OI8PlWpWGCZ/toYQaRH9gjledrI5APb2R5O4YZIF5yatymA4xpo23L0AE+NPIRBk1LK5b/8BpTfOoL1PujQy60V/PgcBFK+f//9PllNrCnTZwGlBtbeI7qhrg9Kgwa8yybRg/w7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qw6gwF8OIZbLguL6Z6G2YPHVdwBJQHQ0wuQhzbeWNUr+knCGxG3V8yNDSD03?=
 =?us-ascii?Q?vtHK4O1Ynr+tBzosb4wJL0cPECW4O/1fPFy++i6kSu+WBkxz7WzdaaApSgpL?=
 =?us-ascii?Q?3ghG9mnJPPMjGJ5Ly1LhoCDM2WgfrdflRpqjVlWAkDtnH1EZVgtOHCqZsu9O?=
 =?us-ascii?Q?Ip1bM3pNTuyqvGq2DKmseUNKtPNun/LG3FWOTRHa8b/JyvGOURwRwmtRkfRq?=
 =?us-ascii?Q?YgmNQQBEFr7u14EHkypIo9TVMx0UYI8liNt8M3ic47inAfXfvRhSV5m7Qq7e?=
 =?us-ascii?Q?uBr8NNGpmPm0mKH66p3PPajceeuxy0cescfZtbpeTCoJE/Jlea+20JqTdZFM?=
 =?us-ascii?Q?KIlytxBnsJ2FK074fb8xMc+w5dQjrgmTXkdhhgaGfraOAMyTghgMPtApRvMa?=
 =?us-ascii?Q?ZtjjvIphTGr/25khTLySS7sfiByMFTudgla3KaRlsY4OIoom20aAYrPDlDh6?=
 =?us-ascii?Q?+NpHyUlES2tPMeEk0J3Ld7NIR5DdV8ut53k387jBLbfIXPWnB7Y1/0ta0idh?=
 =?us-ascii?Q?VTrVYY3Z7OdnV2r34I001j4XiJ6gF6lFdBsDx+MT0nlGUQE9gp6cU0/bU5DG?=
 =?us-ascii?Q?+f9jLEEoJoukVBF49DxLpT5uQjvdj9dRECi3J1MA+CyGgr7vyHsj+D98p5Og?=
 =?us-ascii?Q?ICCK5FDZrGUTMDXb4PvE9AGx3OI/JPtwEpuimq2EICYusywfitrmVltBvl2i?=
 =?us-ascii?Q?m4HrQtmqBbOoPRN2rUeKDML+7qJZki3+sZ9lI0fF+T+4KNPCyHu8Beua4Bbe?=
 =?us-ascii?Q?yqT/EJ7OgEd3fgu4ELiTjshLX1a5L3EVlx2d1vOvftopU1UCk2RlDFuzZx4L?=
 =?us-ascii?Q?uIzr9ioefGJxuXM4uzFFks/EfEgBxILlVuACBF5VFX8gCiOARh2JDRoFkrhb?=
 =?us-ascii?Q?m5KfCBjsJfvU8DoTqgrdMLej8KATqHm2KyAynX3ShY0ln4teLu7XEQHr/Yhl?=
 =?us-ascii?Q?HKY9g7jsnJ3Q1J99FO56lJuuSry8XQiv4E37BG0PBFccOAdRzBPuIdAfCNZa?=
 =?us-ascii?Q?Wt7S0xIjgrKuknXMyrFpY9s2v7goOUZoYZigpinRRMzJs3aQZ5zdqqDJFDcG?=
 =?us-ascii?Q?12SR90bnaSlCY4aY7Twwh3c6+Q+q8B9/OMnQmFyYx4ifX/w8wgHx8ea6ZchO?=
 =?us-ascii?Q?h3KKCZqIcedG4dQiMcgc1a9D7zM3S7DN5zHe+nUSn+syfiN2GGijCmxXzG+p?=
 =?us-ascii?Q?784mFC+Je29uCQyOqEBkay6cIiQD2JIwfCgvkM9UT4ciU8EK9L+4yRnhJdQr?=
 =?us-ascii?Q?2aRBdIU4qww1TXQ20jwyzrUDjgh+C1XnAjvkz/tw55yPsGn5hMhNpchYEl1O?=
 =?us-ascii?Q?J0BMiLg4cVChuOev8FBSjI8JokQSbMAsdUcNZBvRr6PkOYuZT3HSU88Cnt7s?=
 =?us-ascii?Q?mrVDnQTolU2WpxEWpnEOOUsmhlRDOqDQVt6TZLdF31b3uH8S0FXMMaXJGVYB?=
 =?us-ascii?Q?COUcOP3cn0tNsVv21Y+5sqjb5wX6cv21n7uirAkehRktHNi6okgs3sV63tQQ?=
 =?us-ascii?Q?4ePS8Hi9GS6GJlVtkZ5eBTB339RGagXr2JpAhGWEHIRhZyl1r4ucpw+PuH3Y?=
 =?us-ascii?Q?KFgq230Gml/0FYUiQIzs3Nih9zNoQ9+gGeTuBra6UKj+PjJZug73mLj86rhN?=
 =?us-ascii?Q?47gVoi5ODJhsEi3XpmEzj59d3FJCgT7uo03YCKVtxyvIE7dT9u9Op8eN2Rmh?=
 =?us-ascii?Q?05S18N0s7EWwO4WDuZi4MIgObzqPIAazOEUdrkK00vnhecdp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980c077e-2c0d-4321-c7da-08deab717f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 13:15:08.3201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/dcwTNxO2PZBsRSYd2YpOmbOw1NQ+iV3M58l463AL5vv7MKaaklGGNPeJS6qNwt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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

> + * amdgpu_vm_increment_process_counter - increment a process profiling c=
ounter
> + *
> + * @vm: the VM to update
> + * @stat_type: which counter to increment
> + *
> + * NOTE: This function is called from IRQ context in amdgpu_irq_dispatch=
(),
> + * so we MUST use spin_lock_irqsave/spin_unlock_irqrestore to prevent
> + * deadlock when an interrupt arrives while another context holds status=
_lock.
> + *
> + * The deadlock scenario without IRQ-safe locking:
> + * 1. Process context: amdgpu_vm_bo_del() acquires spin_lock(&vm->status=
_lock)
> + * 2. IRQ arrives on same CPU
> + * 3. IRQ handler: amdgpu_vm_increment_process_counter() tries to acquir=
e
> + *    spin_lock(&vm->status_lock) -> DEADLOCK
> + */

I don't think there's any need for a comment this long on something as
common as spin_lock_irqsave() - especially if we're going to be using it
all over the place. If you must, a
/* This function can be called from IRQ context */
after spin_lock_irqsave() would be more than sufficient.

Similarly, I don't know if we need spin_lock_irqsave() all over the place.
Many of these functions can definitely not be called from an IRQ context.

Third, this is for dkms branch only; the function it modifies is not upstre=
am.
Not sure if that means this discussion should be taken off this public mail=
ing list.

Thanks,
David

________________________________________
From: Martin, Andrew <Andrew.Martin@amd.com>
Sent: Monday, May 4, 2026 6:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Francis, David; Martin, Andrew
Subject: [PATCH] drm/amdkfd: Fix IRQ-unsafe spinlock

This patch fixes a multiple CPU hangs caused by the improper use of
spin_lock that are not IRQ safe.  This allow the software driver to
get into some sort of deadlock/race condition.  It happen of kernels
that have CONFIG_PROVE_LOCKING=3Dy and or CONFIG_PREEMPT (full
preemption).

Fixes: 4c131aa02bc4 ("drm/amdgpu: Add profiling counters in fdinfo")
Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 158 ++++++++++++++++---------
 1 file changed, 105 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 8de9b7b3cc88..dc0fbf134fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -165,14 +165,16 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_=
base *vm_bo)
        struct amdgpu_vm *vm =3D vm_bo->vm;
        struct amdgpu_bo *bo =3D vm_bo->bo;

+       unsigned long flags;
+
        vm_bo->moved =3D true;
        amdgpu_vm_assert_locked(vm);
-       spin_lock(&vm_bo->vm->status_lock);
+       spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
        if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
                list_move(&vm_bo->vm_status, &vm->evicted);
        else
                list_move_tail(&vm_bo->vm_status, &vm->evicted);
-       spin_unlock(&vm_bo->vm->status_lock);
+       spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
@@ -184,10 +186,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_=
base *vm_bo)
  */
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
+       unsigned long flags;
+
        amdgpu_vm_assert_locked(vm_bo->vm);
-       spin_lock(&vm_bo->vm->status_lock);
+       spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
        list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
-       spin_unlock(&vm_bo->vm->status_lock);
+       spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }

 /**
@@ -200,10 +204,12 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_ba=
se *vm_bo)
  */
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
+       unsigned long flags;
+
        amdgpu_vm_assert_locked(vm_bo->vm);
-       spin_lock(&vm_bo->vm->status_lock);
+       spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
        list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
-       spin_unlock(&vm_bo->vm->status_lock);
+       spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
        vm_bo->moved =3D false;
 }

@@ -217,9 +223,11 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base=
 *vm_bo)
  */
 static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
 {
-       spin_lock(&vm_bo->vm->status_lock);
+       unsigned long flags;
+
+       spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
        list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
-       spin_unlock(&vm_bo->vm->status_lock);
+       spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }

 /**
@@ -232,10 +240,12 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm=
_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
 {
+       unsigned long flags;
+
        vm_bo->moved =3D true;
-       spin_lock(&vm_bo->vm->status_lock);
+       spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
        list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
-       spin_unlock(&vm_bo->vm->status_lock);
+       spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }

 /**
@@ -248,11 +258,13 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_v=
m_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 {
+       unsigned long flags;
+
        amdgpu_vm_assert_locked(vm_bo->vm);
        if (vm_bo->bo->parent) {
-               spin_lock(&vm_bo->vm->status_lock);
+               spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
                list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-               spin_unlock(&vm_bo->vm->status_lock);
+               spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
        } else {
                amdgpu_vm_bo_idle(vm_bo);
        }
@@ -268,10 +280,12 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_b=
o_base *vm_bo)
  */
 static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 {
+       unsigned long flags;
+
        amdgpu_vm_assert_locked(vm_bo->vm);
-       spin_lock(&vm_bo->vm->status_lock);
+       spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
        list_move(&vm_bo->vm_status, &vm_bo->vm->done);
-       spin_unlock(&vm_bo->vm->status_lock);
+       spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }

 /**
@@ -284,10 +298,11 @@ static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_bas=
e *vm_bo)
 static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
        struct amdgpu_vm_bo_base *vm_bo, *tmp;
+       unsigned long flags;

        amdgpu_vm_assert_locked(vm);

-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        list_splice_init(&vm->done, &vm->invalidated);
        list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
                vm_bo->moved =3D true;
@@ -301,7 +316,7 @@ static void amdgpu_vm_bo_reset_state_machine(struct amd=
gpu_vm *vm)
                else if (bo->parent)
                        list_move(&vm_bo->vm_status, &vm_bo->vm->relocated)=
;
        }
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);
 }

 /**
@@ -320,8 +335,10 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_b=
o_base *base)
        uint32_t bo_memtype =3D amdgpu_bo_mem_stats_placement(bo);
        bool shared;

+       unsigned long flags;
+
        dma_resv_assert_held(bo->tbo.base.resv);
-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base)=
;
        if (base->shared !=3D shared) {
                base->shared =3D shared;
@@ -333,7 +350,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo=
_base *base)
                        vm->stats[bo_memtype].drm.private +=3D size;
                }
        }
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);
 }

 /**
@@ -404,10 +421,11 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base =
*base,
                            struct ttm_resource *res, int sign)
 {
        struct amdgpu_vm *vm =3D base->vm;
+       unsigned long flags;

-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        amdgpu_vm_update_stats_locked(base, res, sign);
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);
 }

 /**
@@ -428,15 +446,17 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base =
*base,
        base->next =3D NULL;
        INIT_LIST_HEAD(&base->vm_status);

+       unsigned long flags;
+
        if (!bo)
                return;
        base->next =3D bo->vm_bo;
        bo->vm_bo =3D base;

-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        base->shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo=
.base);
        amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);

        if (!amdgpu_vm_is_bo_always_valid(vm, bo))
                return;
@@ -492,28 +512,29 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, st=
ruct drm_exec *exec,
        struct list_head *prev =3D &vm->done;
        struct amdgpu_bo_va *bo_va;
        struct amdgpu_bo *bo;
+       unsigned long flags;
        int ret;

        /* We can only trust prev->next while holding the lock */
-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        while (!list_is_head(prev->next, &vm->done)) {
                bo_va =3D list_entry(prev->next, typeof(*bo_va), base.vm_st=
atus);

                bo =3D bo_va->base.bo;
                if (bo) {
                        amdgpu_bo_ref(bo);
-                       spin_unlock(&vm->status_lock);
+                       spin_unlock_irqrestore(&vm->status_lock, flags);

                        ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, 1=
);
                        amdgpu_bo_unref(&bo);
                        if (unlikely(ret))
                                return ret;

-                       spin_lock(&vm->status_lock);
+                       spin_lock_irqsave(&vm->status_lock, flags);
                }
                prev =3D prev->next;
        }
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);

        return 0;
 }
@@ -611,6 +632,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
        uint64_t new_vm_generation =3D amdgpu_vm_generation(adev, vm);
        struct amdgpu_vm_bo_base *bo_base;
        struct amdgpu_bo *bo;
+       unsigned long flags;
        int r;

        if (vm->generation !=3D new_vm_generation) {
@@ -622,12 +644,12 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
                        return r;
        }

-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        while (!list_empty(&vm->evicted)) {
                bo_base =3D list_first_entry(&vm->evicted,
                                           struct amdgpu_vm_bo_base,
                                           vm_status);
-               spin_unlock(&vm->status_lock);
+               spin_unlock_irqrestore(&vm->status_lock, flags);

                bo =3D bo_base->bo;

@@ -641,13 +663,13 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
                        vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
                        amdgpu_vm_bo_relocated(bo_base);
                }
-               spin_lock(&vm->status_lock);
+               spin_lock_irqsave(&vm->status_lock, flags);
        }
        while (ticket && !list_empty(&vm->evicted_user)) {
                bo_base =3D list_first_entry(&vm->evicted_user,
                                           struct amdgpu_vm_bo_base,
                                           vm_status);
-               spin_unlock(&vm->status_lock);
+               spin_unlock_irqrestore(&vm->status_lock, flags);

                bo =3D bo_base->bo;
                dma_resv_assert_held(bo->tbo.base.resv);
@@ -658,9 +680,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,

                amdgpu_vm_bo_invalidated(bo_base);

-               spin_lock(&vm->status_lock);
+               spin_lock_irqsave(&vm->status_lock, flags);
        }
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);

        amdgpu_vm_eviction_lock(vm);
        vm->evicting =3D false;
@@ -681,6 +703,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm,
  */
 bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
+       unsigned long flags;
        bool ret;

        amdgpu_vm_assert_locked(vm);
@@ -689,9 +712,9 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
        ret =3D !vm->evicting;
        amdgpu_vm_eviction_unlock(vm);

-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        ret &=3D list_empty(&vm->evicted);
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);

        spin_lock(&vm->immediate.lock);
        ret &=3D !vm->immediate.stopped;
@@ -990,11 +1013,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev=
,
        LIST_HEAD(relocated);
        int r, idx;

+       unsigned long flags;
+
        amdgpu_vm_assert_locked(vm);

-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        list_splice_init(&vm->relocated, &relocated);
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);

        if (list_empty(&relocated))
                return 0;
@@ -1261,10 +1286,12 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
                          struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM],
                          struct amdgpu_process_stats *process_stats)
 {
-       spin_lock(&vm->status_lock);
+       unsigned long flags;
+
+       spin_lock_irqsave(&vm->status_lock, flags);
        memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
        memcpy(process_stats, &vm->process_stats, sizeof(*process_stats));
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);
 }

 /**
@@ -1634,26 +1661,27 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ad=
ev,
        struct amdgpu_bo_va *bo_va;
        struct dma_resv *resv;
        bool clear, unlock;
+       unsigned long flags;
        int r;

-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        while (!list_empty(&vm->moved)) {
                bo_va =3D list_first_entry(&vm->moved, struct amdgpu_bo_va,
                                         base.vm_status);
-               spin_unlock(&vm->status_lock);
+               spin_unlock_irqrestore(&vm->status_lock, flags);

                /* Per VM BOs never need to bo cleared in the page tables *=
/
                r =3D amdgpu_vm_bo_update(adev, bo_va, false);
                if (r)
                        return r;
-               spin_lock(&vm->status_lock);
+               spin_lock_irqsave(&vm->status_lock, flags);
        }

        while (!list_empty(&vm->invalidated)) {
                bo_va =3D list_first_entry(&vm->invalidated, struct amdgpu_=
bo_va,
                                         base.vm_status);
                resv =3D bo_va->base.bo->tbo.base.resv;
-               spin_unlock(&vm->status_lock);
+               spin_unlock_irqrestore(&vm->status_lock, flags);

                /* Try to reserve the BO to avoid clearing its ptes */
                if (!adev->debug_vm && dma_resv_trylock(resv)) {
@@ -1685,9 +1713,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev=
,
                     bo_va->base.bo->tbo.resource->mem_type =3D=3D TTM_PL_S=
YSTEM))
                        amdgpu_vm_bo_evicted_user(&bo_va->base);

-               spin_lock(&vm->status_lock);
+               spin_lock_irqsave(&vm->status_lock, flags);
        }
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);

        return 0;
 }
@@ -2225,9 +2253,13 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
                }
        }

-       spin_lock(&vm->status_lock);
-       list_del(&bo_va->base.vm_status);
-       spin_unlock(&vm->status_lock);
+       {
+               unsigned long flags;
+
+               spin_lock_irqsave(&vm->status_lock, flags);
+               list_del(&bo_va->base.vm_status);
+               spin_unlock_irqrestore(&vm->status_lock, flags);
+       }

        list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
                list_del(&mapping->list);
@@ -2334,11 +2366,12 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct=
 ttm_resource *new_mem,

        for (bo_base =3D bo->vm_bo; bo_base; bo_base =3D bo_base->next) {
                struct amdgpu_vm *vm =3D bo_base->vm;
+               unsigned long flags;

-               spin_lock(&vm->status_lock);
+               spin_lock_irqsave(&vm->status_lock, flags);
                amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1=
);
                amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
-               spin_unlock(&vm->status_lock);
+               spin_unlock_irqrestore(&vm->status_lock, flags);
        }

        amdgpu_vm_bo_invalidate(bo, evicted);
@@ -3104,10 +3137,11 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm=
, struct seq_file *m)
        unsigned int total_invalidated_objs =3D 0;
        unsigned int total_done_objs =3D 0;
        unsigned int id =3D 0;
+       unsigned long flags;

        amdgpu_vm_assert_locked(vm);

-       spin_lock(&vm->status_lock);
+       spin_lock_irqsave(&vm->status_lock, flags);
        seq_puts(m, "\tIdle BOs:\n");
        list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
                if (!bo_va->base.bo)
@@ -3159,7 +3193,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, =
struct seq_file *m)
                        continue;
                total_done +=3D amdgpu_bo_print_info(id++, bo_va->base.bo, =
m);
        }
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);
        total_done_objs =3D id;

        seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", tota=
l_idle,
@@ -3260,9 +3294,27 @@ void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_dev=
ice *adev,
        adev->vm_manager.vm_pte_funcs =3D vm_pte_funcs;
 }

+/**
+ * amdgpu_vm_increment_process_counter - increment a process profiling cou=
nter
+ *
+ * @vm: the VM to update
+ * @stat_type: which counter to increment
+ *
+ * NOTE: This function is called from IRQ context in amdgpu_irq_dispatch()=
,
+ * so we MUST use spin_lock_irqsave/spin_unlock_irqrestore to prevent
+ * deadlock when an interrupt arrives while another context holds status_l=
ock.
+ *
+ * The deadlock scenario without IRQ-safe locking:
+ * 1. Process context: amdgpu_vm_bo_del() acquires spin_lock(&vm->status_l=
ock)
+ * 2. IRQ arrives on same CPU
+ * 3. IRQ handler: amdgpu_vm_increment_process_counter() tries to acquire
+ *    spin_lock(&vm->status_lock) -> DEADLOCK
+ */
 void amdgpu_vm_increment_process_counter(struct amdgpu_vm *vm, enum amdgpu=
_process_stat_type stat_type)
 {
-       spin_lock(&vm->status_lock);
+       unsigned long flags;
+
+       spin_lock_irqsave(&vm->status_lock, flags);
        switch (stat_type) {
        case AMDGPU_VM_VMFAULT_COUNTER:
                vm->process_stats.vmfault_counter++;
@@ -3282,5 +3334,5 @@ void amdgpu_vm_increment_process_counter(struct amdgp=
u_vm *vm, enum amdgpu_proce
        default:
                pr_debug("unknown process stat type 0x%x\n", stat_type);
        }
-       spin_unlock(&vm->status_lock);
+       spin_unlock_irqrestore(&vm->status_lock, flags);
 }
--
2.43.0

