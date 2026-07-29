Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EC2C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 08:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D70C10E004;
	Wed, 29 Jul 2026 08:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDavdUwC";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE7F10E004
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 08:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUONp6ZWh08ERpDx+dowOl5rv79oZJFLCC0sIA8H13p/videjBb7ECJMNZqRvUYUQa9nLkLn9eud0lNNJz8IUl2zTPnQvZRHDZJnrTR9BTXqqJtAj6SUpIwS3WH4DnPaLGrxnbGv2Qz492oHcd+yPL29r6zbm9m0aHca4PHrUkqCNSHtg/mPQnyx8t9RgLY7SsEbt+U81SNTgEC/2kZR2dKOfJGjonUHzO5v9nLHquSZnSUr+ntEcEe2+ZgnH0pEvmzXRW2YxJPLHcGwLAVpA3FyzebA5SEoWcMKD+oV4wcGhbzVzHSy6m09acKwwOMM+67foNxVk/08Ih0XNTJrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J8+w51cycBFCDfzfXcCgs/BzRnPnUTAsUJrrTAeq5A=;
 b=FSGOf95YDlBAy0Flz/ZVu5zbJYJhn45Oidb98UyIdjBmXarqygzPSkNQsVXSlsAWxdqAel2HsjSDm3N03CpjT8u22701YXPNFA6smUFjB5sCjOYuOAxyCegZgzJa6EIhq1GfdwLRPG94Eai3D7GcO8WZiNsZGGEsSIwa46Bgcx2hH+sLAwNC66q8k8NJv000SauEiJ6P0+1rbLTQML2/CZWhzAa+sYryzliunXfZ/evMkoS+x9WdIFl1wfKkOx8gJVfF2Eztwu1sFFjJKuFfq9oDEu8ymTD4DYQ4t+lDBqcb9r1C6DpLZex317sHhVRVwCreqAJgRpb0DB1Q2vmtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0J8+w51cycBFCDfzfXcCgs/BzRnPnUTAsUJrrTAeq5A=;
 b=yDavdUwClg1ddXMA4jvr6m0/P0XEuePHyS0f2RVPdT9WilXub0XEz3bb9N/ex3/tjHw4ZxbTIRL3+AvlYek0HZxt7DMIwoRq7gC06OPqOOHGVWJ7U1G19UhBb6VMx4F+uEfxT03ivCBM0DX/al/JVCSaYiS5kW993ZdRTxBPeEI=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by BN7PPF62A0C9A68.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:43:48 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 08:43:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use virtual alloc during coredump
Thread-Topic: [PATCH] drm/amdgpu: Use virtual alloc during coredump
Thread-Index: AQHdHy78+gx6YiJuq02LED/Gk8409LaELkNg
Date: Wed, 29 Jul 2026 08:43:47 +0000
Message-ID: <EAYPR12MB999158BDF66F47ACC1ED16F947FCCA2@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260729075018.1547054-1-lijo.lazar@amd.com>
In-Reply-To: <20260729075018.1547054-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-29T08:43:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|BN7PPF62A0C9A68:EE_
x-ms-office365-filtering-correlation-id: 4760a86d-4ff7-4ffc-65d5-08deed4d81b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: AQn4eYmbCoOWKDhOO2cytDzOa+MTydx4s405cOwzsIjIt53hRQOFy72OJvlRJX0tq9YMSbjd11fdLZbgO0pINR11RLPISJMytKe1KLup0HIT894FSJ4po/6kMGTJh1kQtcXSTlPnyXlhvgSDFoDzou9Nowz/hDhXZ5podvz4Id8KhjtBCX8/wjItiUgskESModiGdBkFi0UzISE4deglwTaNuYsfClyqILWwgy1F7Y+pHbkoSQgrWXMnGqCtZPEtx/IsE3e+BwT4weWY4gV02LF3hkbEK1yXTPyl49d9ZUrSYYz8o79Icd+D+4/f+p2sf/HdYuQNPnnKHdkzzfvuC/T7MZ27wBs/c0wlqRAE/26AMripxEfVGFzFv+odT6MEyMpm6MMbLYiPXXZJieTViHJ5zLnWuKcIVgANCycEkeLJ1YCQONti8ipwP8dsI1tL2TpMiaywz75F6fo0AM7PqQwZUAzyL0ZCcFKrz6aAMMuEFGbjkJU/H+Zc1N6dsoeL/tB4J6eYX36JKBJjkslurrUThncCjG2EmiAQNkMtDa9chcSBxXrFm/sBsChX15rRbbEJTx35cl9upka0i/3LMiPVsFo7LvsAIAB+ClkTS+MQhYMm9tTDRnglvm6eRoDk58AQE4oQSxvQkp+KOM6CTeiGysbeEEeI+tVnHb+SAPQaG6K36pbbybu2tQm24SFEdjK3rcraen4RgSq4OKTIQhXCBWVDv6lXfjmDnvLjP14=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+uVPLSKNjIcZzf6fbsu9ZsGdItSJKqHKIpURobQDjfdWB6BwHKZZyEUN+1lL?=
 =?us-ascii?Q?LXAfnKP4bqPCE2tLNiB/MScMEtuPtDyqP+7GJqdNNF0cyECuxSt7/PvtByuQ?=
 =?us-ascii?Q?9sbHN/FpSwtdPYbAqHsJE56ufyYm8XrX6vwMIwn2b4DYLR3kpkfup1Bf/hdp?=
 =?us-ascii?Q?9+S7GkkYHZuwM2xgTySbA2FUgl6pnsDrRbyWxd0Y3qFgtByq5HcOm+UbyVGb?=
 =?us-ascii?Q?WgLPHQPJh6YfP2gG7EwMGLllZGeSSltXXmR6fXX1oOHaBcsphwRQbjeZhYSC?=
 =?us-ascii?Q?aEpq3W2gevhr8gnaAovAD/bEsljolqigYsztLOTNyjleY9M8WqHCYqMq86t8?=
 =?us-ascii?Q?7cOqhMmLraOe/kt+1iAYGoxrWXg2MTBHJAFTwItWjYN2FvHHR0kpzR8Kpr+M?=
 =?us-ascii?Q?r/fyRQQJOXGeBjyPjHVHF90oPNW6+8H0x4TmvPTUdQuSj2VouAC5hCkyoWk9?=
 =?us-ascii?Q?pENLK3v2NvtuwIE9QYweJG46ov9dMQPC33mRQO3UZrzXUyTioVVHZQu85uRS?=
 =?us-ascii?Q?UCduECFbVEY/xiKZe5/OnXmc9vHKiNEDhv/cBIKl+S4kISEFwOXIDKpXKL0U?=
 =?us-ascii?Q?ykh8mRd0gAg2Hzi/92S5CpZF6pf8i626TFSApb9ruLPdUnLmMQx0iJN+QRj8?=
 =?us-ascii?Q?rnEKrPyFdFXto+/2zlExlErm2IoavL3nhiMu+7ScX+QXxxb7RW5E34W6zMmb?=
 =?us-ascii?Q?skMkrWCZxVZrGrib1Zalz1OyKlGUECdiplbe6o2rva8mqXbh5H33W4HSk0LS?=
 =?us-ascii?Q?UWgfFfci8umxU4IrzYbwiWQn9KVhpcVtOFyBvxbR1fIgVft3WYa4dxBaTCcE?=
 =?us-ascii?Q?Pf/P47wifJpVe0RR3zXhv0L8c2dwZomNtXJqZRujotDe4Vz9iQCTwfQzf3Tc?=
 =?us-ascii?Q?tAaX0JlSs1P6EHPEr1UtvExZIq++HDfBf5JKui+UVQF5EuIHj34E1tEJht/B?=
 =?us-ascii?Q?b1znj3dBVmDHTrAn0Vhm5hLX3iXFdcqIAg+EgZZqwUURbw13z2/uNNuAwbQF?=
 =?us-ascii?Q?tnnFCuRX4p2om09L1iJWKk/vgUNqe4yEK+I5Ijbg4PQBmllDg3YYvqcfzZQM?=
 =?us-ascii?Q?0AZ4T8cLZXJD0RUVGQLRji6DFVKEJS2rD9DcCaDUiTpG82iKPiwsO/OH+g1t?=
 =?us-ascii?Q?H+k9B4LiYw9FSs+s2AT9PmBVIEhETUNIlfJIFv/sjQ00472CBVAsm3fRxBXE?=
 =?us-ascii?Q?O4jE6Fqc8u/F/LoaTrDAwrMM337wkWpM7bEr9mh8Zd2qsfc3PyC5HUIH1vmD?=
 =?us-ascii?Q?KLVFw9sfaTL6NvV4IMUJ1TzbWHbPBsTtxAidjR8+tPYmmUH+LI+28hQ/tJnm?=
 =?us-ascii?Q?Zoq916vFxy+eLSAJjs3rwjOo3iQifReaTKPxljoApWYFidt3RYGPGSyHxh6q?=
 =?us-ascii?Q?QuZANw91u1FwkZS7KxI3VxKsBvF3D2avhXWelI+YqlWSr3d6G5+gyMvBJlbu?=
 =?us-ascii?Q?EHncJ+2embLhjmUUrdmJ7Zd1MVgSuk1NDBWFRzj+CPrbCgLZxiH6iTW9VDb1?=
 =?us-ascii?Q?2YWDQ58W/DasNc371ar6R/IVlzfC4T5srfmetUKNCf5+D97p4XKQ+nOaWz6N?=
 =?us-ascii?Q?R3srxaPTFtoJ7Cya3z71eeiDJ9L6xazmbwjaYl+e5n2msO7XUHpDiPPx4H9b?=
 =?us-ascii?Q?i1CDfo1Dw63lzc5hLtW69iDptxQ3r5PPV/gsfROg7xV44PlLyT4SLkFEPFFG?=
 =?us-ascii?Q?+8TZUIqBSn3BjU2S3SWISntkv48E0bFtP8n4WgYRUwEszshk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4760a86d-4ff7-4ffc-65d5-08deed4d81b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 08:43:47.7243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQrRKkU/J9HDu9eF4bN65mo/eaRhUba3Wm2QjCi+b/OozmW06OR3Vl12JLerL1mNApXLCzRG8+RLnK0iAGfVXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, July 29, 2026 3:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@am=
d.com>
Subject: [PATCH] drm/amdgpu: Use virtual alloc during coredump

The number of rings with outstanding fences can be large, requiring a bigge=
r allocation. Such allocations don't need to be physically contiguous, so u=
se kvzalloc/kvcalloc which fall back to vmalloc when contiguous memory isn'=
t available. This also matches the existing kvfree used to free these alloc=
ations.

Also guard the allocation with ring_count to avoid passing 0 size to alloca=
tion routines.

Fixes: eea85914d15b ("drm/amdgpu: save ring content before resetting the de=
vice")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 39b2a4c0e011..4dfea36997d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -554,7 +554,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool s=
kip_vram_check,
        if (job && job->pasid)
                size +=3D sizeof(struct amdgpu_coredump_ib_info) * job->num=
_ibs;

-       coredump =3D kzalloc(size, GFP_NOWAIT);
+       coredump =3D kvzalloc(size, GFP_NOWAIT);
        if (!coredump)
                return;

@@ -597,8 +597,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool =
skip_vram_check,
                total_ring_size +=3D ring->ring_size;
                ring_count++;
        }
-       coredump->rings_dw =3D kzalloc(total_ring_size, GFP_NOWAIT);
-       coredump->rings =3D kcalloc(ring_count, sizeof(struct amdgpu_coredu=
mp_ring), GFP_NOWAIT);
+       if (ring_count) {
+               coredump->rings_dw =3D kvzalloc(total_ring_size, GFP_NOWAIT=
);
+               coredump->rings =3D kvcalloc(ring_count,
+                                          sizeof(struct amdgpu_coredump_ri=
ng),
+                                          GFP_NOWAIT);
+       }
        if (coredump->rings && coredump->rings_dw) {
                for (i =3D 0, off =3D 0, idx =3D 0; i < adev->num_rings && =
idx < ring_count; i++) {
                        ring =3D adev->rings[i];
--
2.49.0

