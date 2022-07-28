Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC4FC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 02:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E088F66D;
	Thu, 28 Jul 2022 02:33:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA4558F538
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 02:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0vlD87uwO6lSYD/XreUL+w6NQI0Gz1cB/Ryp2xYKy0VBs1CpJmdFZr7cS4Hkz0CrWwtPJfzo90Qv/7YN2XG9f8XSEZh7IYZgt6OEsoyq0cNLUW1qnBFSI2UAEgnrCjm7lUrPdEffTlx0Pe4nY5nPTQe/BJCjNR5DM8aQMPfj8BR4oV9VtiTfHnhc11r+OnkQ6wSiCm9HYSLy9hgQMfktHekUGX3dS0SzjxAW0D9ULn+kTPO5eEs6v0EDF0DG3N7KxP+Z961N9mqg1UvhR0oaOuA1nw0B2OrjI8sbl5AvPVHcoVEH5RKv1pOh0ry6hqN3M0ys1xe4NJp5AL4T0Wdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hEsrWC6iFVr0zTq7Z52Tt6h+eqxwDU3yx4V/YvOqBs=;
 b=Q1pWaHv9UrE0BqvO7epklJCZhfxHs2N/SOAKt1QDkAKUeju3gOAfYPeoEACAMAwtx9ywMsnhVL9JMU0vg/XNgLKfSCmJEs4shhGtPFIfDmHvt0ns6Skeb/qo9suCxdDAgAUz8WychixaPOLHb3r+LPo31DnDcTfOKDqVCNSf5K3PXu3p1RtArgTsv76enlfCwQBcH0o815JhBfW9HCN6wen9a928i5CKhiRfoJ8e46plli9GGHJ3MmmMqUO+wyCSQSRASqGrqgKCZGk/bjlDgEhuppSLFMQx38SrMZ4PyvNE6IqKIKlvbnRDwpkjjDLS6bXl5nb/6VuCwARleN8RTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hEsrWC6iFVr0zTq7Z52Tt6h+eqxwDU3yx4V/YvOqBs=;
 b=5MTGlqnq7jg5W985RwLY9PHE9xAmoOPo0d0s4Hb04s8JnV8Tgvn40propaLZzzfpmhhm7SjWEMWsdTgKv1vpYnV448JvnCYvtvznDqS+dkTM98M9DnyGMl1FJhFjkbyAoKD+FU6EAJTI9b5ESfLceYDOIlO6ULer7s84IymqBrc=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Thu, 28 Jul 2022 02:33:04 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::fd31:9d15:8b1c:3a09%7]) with mapi id 15.20.5458.019; Thu, 28 Jul 2022
 02:33:04 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdkfd: remove an unnecessary amdgpu_bo_ref
Thread-Topic: [PATCH 3/3] drm/amdkfd: remove an unnecessary amdgpu_bo_ref
Thread-Index: AQHYoBHVkVPF7PwSq0aVBWXJvLU0762TFFvw
Date: Thu, 28 Jul 2022 02:33:03 +0000
Message-ID: <DM6PR12MB425094F468649717E7A9E29AFB969@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-3-Lang.Yu@amd.com>
In-Reply-To: <20220725103205.2085630-3-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-28T02:32:21Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7fbb2b05-f5d0-4166-bcce-ec47283e37c4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-28T02:32:58Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b32eb258-d075-4d46-8e58-03cbd61100bb
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e44ff2f-3821-425a-2575-08da70417f7b
x-ms-traffictypediagnostic: SA0PR12MB4432:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VD4Yctu3fECuQyUxvTgu8rSC3V8+EsCRUKE2SJdQynIns7aZLU6clMOntq+rj8QoRXGlFhBQ5eoSwX6m3PsLuBt7rz2TV3skaS1T1nrNI3TatTu4VBquhbPlqcL37u8N2d8paQDpk5Eo2QopCds9o/3i7SxeR2ok8+4nLH4Eg0kdO28OjiQpO4kGow6JR5g9g+7mv7JKp8mCEoRSMe6zgsbxX6mDFzzIJ1UYafPB84PjSx/pWKTaQBOdaUDrM7TeRNFfl3kqA50XlSm88EDgbsP4diSWmsjeIkSjO8xxDCtu1DunW18Ym75TOlxdm674kZU4mX55wZKWGXaAie8UYq8d3nH042IJI9i9njE11BKChq41eExI+ak0WVakGsG+0XR0eIzPfOK6JLy0JV4hT7c49GVPdxo61ti+vgpuWnvkp8aP4DYEycPo6kZFTEDafR8TZKa1s8q4BboM983p5iwK4v+vmdO0pchNhnKG3/F77q/R2xNPTc6u5yNvgIkeWH8ViQ7AdGQAj9HAf//X25guXM0Nu93dfis0SPikKPvdzZe8VDeHja211oRvLMqbW/gkpe2mLE+wyzMpgoCZkntp8XIS090m3spyn6NQh9qAuBjDQQJGduqfKdke2UvPnI9uIKL1Z532yMgutTRTkKLsrN4jBrjmVIYYg93OHKoCw2PV/G6jGTNHKlo3vKEc/JxfFLFrVTug5cSraOcp224hcLgN7TUpvPGvOniaQZtOrIf+mYAak3Ml1qvJpLaCJ8lk4QBuIVH74HjxG95CacceDVmOy6tORX9Wh+M3Vzs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(83380400001)(122000001)(8936002)(2906002)(5660300002)(52536014)(38100700002)(38070700005)(186003)(41300700001)(7696005)(478600001)(6506007)(9686003)(26005)(6916009)(54906003)(316002)(55016003)(66556008)(76116006)(64756008)(86362001)(66946007)(66446008)(33656002)(8676002)(66476007)(4326008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yk6uSRaY6L/LOtDeICCVNQkxLsJFsKt6ZEoZ/HwZF927BYwCZ/y92hPulubC?=
 =?us-ascii?Q?6IkNYF6xPKHz3IU3VIyjAxJKiDUMtp21wuMDYoYXfhgXK7NHey9jObUNbPbX?=
 =?us-ascii?Q?2HpJYzqA6CzycAFL91idgcdYEUejbvnYPAXBkTI+HdyrnkhPs9dU4mKFYpy7?=
 =?us-ascii?Q?wNvvCXvUpBoH3+d3Jcqu4SbXsEXciYVWBAbkllcYpdGgPdAiApvMzrSp9x0z?=
 =?us-ascii?Q?IhWOltR7SOeNHjY/Cuyho4crq3QeLnThKJS/aO2psoZJhQczVqBFGL0Pl6l0?=
 =?us-ascii?Q?82MaMxSfENfmQEEYYYKZyz3v5nNL+TbM6gpaXh5K1LPHbXp/ExG+QJKHw1UE?=
 =?us-ascii?Q?WO7oydCVIXXFhiDn0z+PorSKFj3Nis5t36SNSBLyRekwdD/Kub/nQ2/zZcgi?=
 =?us-ascii?Q?b7/VEpZ909cpHv19RUvXinSV6jlkp8ykkb1m1J9A5s9NfIJTRQCht4HwuBEU?=
 =?us-ascii?Q?XROiKD9GTCLOBuIH9Eh7sCald3Qz6QzdIBs1O84n8gTHI0bDsQeVD1Yv9nbR?=
 =?us-ascii?Q?VtEwJ98sGQy1sJHAqBgt16f8kjrhlwlFpTXI+ut/VgGIWNydlXiDm/xbJAsn?=
 =?us-ascii?Q?orrYyI50J1xPhlk2sCyYqLfPB6kMOG4K/nxNh90Wc4HlyYeKguQp2AJABJCT?=
 =?us-ascii?Q?rdZyQWin60JXgjeWxQRj1d6LS7iIFQw6uzd8D/m3/2bYjYt5YR6zx0amT7gq?=
 =?us-ascii?Q?3S8/xlLhNl/WV3kY6fDDtjP3zXZbvO41nEv1vcI5VpJ05sJvFSHnj7fx0RqJ?=
 =?us-ascii?Q?kAHaasHiONC9LKSKgppnG9xj1D/AEb3P3/L8HeeU2rPheC4yhmlB4t8bDf9K?=
 =?us-ascii?Q?0lfgqmc306nWX9vr9mNcniVhKxoZ/0G5ASeujdgkiMylApSIArWuA3sVLK8B?=
 =?us-ascii?Q?se0IgaSJxi5FRV1v+D5X9fK0iC6GkdpCWFm03iCxipe+Y1YzQQJa+izbl7d+?=
 =?us-ascii?Q?K+OCpEQ4qrq2ZzR8pkcHHIO1q66UFOT9rEnYkrO2ECRRumcYvmZaHd0M79NX?=
 =?us-ascii?Q?FBvM0GakZz7OyWxXlTdYm47Qbv6phCsmcb4vrT0dwdlLSPkyF986h9xU3UGl?=
 =?us-ascii?Q?rEqheepcPJXa0fMBIgUVhki6CDumrtImxkgY9P9vxYSuJlm4PupEo25AIdlc?=
 =?us-ascii?Q?8RRg40mnB4Oj1D/6ciIlTAVpMMYNApMyUWAKbZRqDyrodPoNSsNMTFKbeP1+?=
 =?us-ascii?Q?zI6Qf7hXVmmyOGEbk2oPzgOqWJuQRaNRowTH0taPlySoJC6vO122Kmb6tBea?=
 =?us-ascii?Q?gt7yzVXHXngFXDLiNkCb81APp+oDOphQW1gqP9BmkrLu/qyT2UYZAI8hRqg0?=
 =?us-ascii?Q?zZz1ane92Zkf7kr23LDyzjre11sMCQAb3Xbn64eaWdAOOid5QwfEXBqC6ACx?=
 =?us-ascii?Q?RLYh8OcjBeVJjOfU7XIW83XqBcI+0VfOIHlZj/96SbnWcVctTN8jWn1qmxBS?=
 =?us-ascii?Q?sSqMghlGfbDoTl4/ItwUtrYP9SNpW2RvH61FuKM3xqBZ3cNZZfLW5oduYXoj?=
 =?us-ascii?Q?yAhu2Bt+PZx9Wi6wh7cwBr3m7ki8tAJorNvRJYU6CbZlUfdAs4TC792CG3+c?=
 =?us-ascii?Q?1BsFuAsfv3YBYMn/ACQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e44ff2f-3821-425a-2575-08da70417f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 02:33:04.0152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va2Y9+smt2mam1PmwmoLZETCmXysU4dhhneQolyfM09exCANraNVdkIGAhtVLZEXyG4oqVYig5p7owRKLDbLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Ping for this single patch.=20

>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Monday, July 25, 2022 6:32 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Deucher, Alexander
><Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yu, Lang
><Lang.Yu@amd.com>
>Subject: [PATCH 3/3] drm/amdkfd: remove an unnecessary amdgpu_bo_ref
>
>No need to reference the BO here, dmabuf framework will handle that.
>
>Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>index c1855b72a3f0..802c762108b2 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>@@ -827,7 +827,6 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev,
>struct kgd_mem *mem,
>
> 	*bo =3D gem_to_amdgpu_bo(gobj);
> 	(*bo)->flags |=3D AMDGPU_GEM_CREATE_PREEMPTIBLE;
>-	(*bo)->parent =3D amdgpu_bo_ref(mem->bo);
>
> 	return 0;
> }
>--
>2.25.1
