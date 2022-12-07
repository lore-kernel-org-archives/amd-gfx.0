Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD10CC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C951310E3C5;
	Wed,  7 Dec 2022 15:04:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4E310E3C5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 15:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOC47xrxssbLFpR8Sxlgb25oIuwTE/TFowXo2WOOM5TO18BH2+g0BRTUdc5TgWKCpBnwH4m/fPJSqXJvw2+srGAdXv0WOB/qs2H9yAwcpcN5eNN1eB/2ht4oYCFNtrUcmlx4RQY006v8clUc7h2kMdIsTMGs6LIKroLqByT9f+oNFtjHQrrn0/HrjUl8H0ytzbsEEoqh4bPl1nyVEDR3jLgcSJA9n+GVxYjzibuQ0RE8i8nKc0CqMBcYlliHItJXl/VlUWqnoAeXvvKYkw0ooMGlgKGMiVYPjCn5JCWw8v+iTw8zwzoDUTp8SXgo4Tq3GPQppyosx2FdJeZZF6Id4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx9KRbk8D+SDMXvZ8O4HaqNtQHgAgk7Ia2VXEGWNRLU=;
 b=EFHld1Y9Mf5271rRcsFZSceebwvi1GzNl/72qMXkDGato7swWAIxie17XwmuTQnGdR1CjzmXtG5dUbs5cIOxzhQbMtk+SSftZhxNa4JyUspFjYuyJEJPhajo6/bxfRedPQ+px7hKjMhASbDsVMYQYC/HXckIo/E2mAOXdQ5WJnJExwvyH89pRte/7HHBrXJ5TfhrQmnUKrXaQxCukgXvXY7YUzavMnhOwQkH0mh1F7ew7RMjb+Sgs9ormYKgaaygfKSByMuNGp+VfF6+EJi/kAYo1yH9GbiRr4WR7hr0Cp1pAk/BrvgftY1j2qZFWG6z01t8EjkHgIS+jtCAS6Filw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx9KRbk8D+SDMXvZ8O4HaqNtQHgAgk7Ia2VXEGWNRLU=;
 b=AB3Gnlz0LSK241vRmRBybFYm3zcWVyuEciLihRutAgw7G5av/bI4CFjYyq4Lfhxlib1O6b5pfWx9qjPRWrYb2OkQJ6+AJjWNsK0G6YRAKMzfzkTgd92Vh0OAzW9X015aTYHs0d/7JoPhddk0BfJd1+Qr4CsofQE30R4QnVdjm+Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:04:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:04:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wan, Gavin" <Gavin.Wan@amd.com>, "Chander, Vignesh"
 <Vignesh.Chander@amd.com>, "Yu, David" <David.Yu@amd.com>
Subject: RE: [PATCH 4/6] drm/amdgpu: skip RAS error injection in SRIOV
Thread-Topic: [PATCH 4/6] drm/amdgpu: skip RAS error injection in SRIOV
Thread-Index: AQHZCiM82KzisheRJUyJV+0UPa4feK5iha3g
Date: Wed, 7 Dec 2022 15:04:45 +0000
Message-ID: <BN9PR12MB525724A6129F0CE47C937F60FC1A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
 <20221207100341.15356-4-tao.zhou1@amd.com>
In-Reply-To: <20221207100341.15356-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1ab9e3cb-4c5f-4463-9fae-da0ea36bc054;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-07T15:02:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB6786:EE_
x-ms-office365-filtering-correlation-id: 6d5ac90d-a733-4ff3-4413-08dad864606d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HspBrwu3beVWWy/AUYOpGgWMXl5gBKTHxy3fDBN6t6T9nrQOD1/3RH8etBuJxL0pIGVZRJa0/M59fmhU8V86fCYipRJqHCKUZswfnCi5/1rxYZBlRTf52JzIZN1BH4ZCwuC06aStiyR/V6ozbZ3rgKBaFIOs5CD384udFduJ2FI08NT6Ud/AzAo9bH1ckWEfO+xJghUCykv+NIa4yOpuyi/gKEtuNnfq1C598iKaBQz1mN79fpBPVVGNo5gsf53xFlJstKfpkJEWnH/R/V/Ti+8kD8lReag/lBEgjQLHEBjlNwcM3bscq5n+7LOlJ1oFK9hJpOhsuu3j0KyVBH91M9HC/2s13OiQCMsTwcb2YDlJ4RQwp9KHdLuV9diBNQ2D5SzAZ7kN585kis4PdIOrW1QWmHnRM4zSdP2nta7D5OzkZ091/ePRGzIvN9sCAp1tIrr6Q5d2mqcinOK4e7OVY2BDZ+dARKTj19Zr0y600wh4jwjoCLrSMq8Cw45pCRmwkbCQmpN72GXQgM+iEi9OcPGgGegfMFMIhKHbib5NhyXFU5VJVKB21nf1TjRAw7PRYJl/l/unprqQSD493Egmk9fqMmL1DVrBvgMch6+qcZfGxPhJNF8oIj1ZG5QB/CWV1GDD6QURb8Qmp1z56++jQzWMgwhFjTcnzydGoRP9uefjgdZDZN7KP07oWEPJLDQ+6AsRqU/DpxahFJKzCy4ROnrH0n1hRN9o92wDpnKxYO8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(8936002)(86362001)(41300700001)(33656002)(38070700005)(2906002)(5660300002)(921005)(83380400001)(122000001)(66476007)(76116006)(66446008)(110136005)(316002)(8676002)(6636002)(66946007)(66556008)(71200400001)(38100700002)(55016003)(52536014)(186003)(6506007)(26005)(53546011)(9686003)(478600001)(7696005)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jWywkbLRA8bSD4RB8jS1JGi3iS7OZhbN11gR2dAGfdLE7YZomteih+Puk3Tf?=
 =?us-ascii?Q?n6BYew0HHRyEt3zDB6IsM1c1oK2frkaHxSkIB+7TjiM3AopgTWuSiVNa6rC+?=
 =?us-ascii?Q?83uGDkR4UfY6azbrKuKXoYljk3wJGXiF2eoB8MIo87fLEMcOXEpzdxOO+jGj?=
 =?us-ascii?Q?0ic+basbDAPMSFc//nhdL99ACnCMhRrGCigwPqDFjjWZ7i11RjuMKoMESljE?=
 =?us-ascii?Q?XbW4AftHJUt3C2Ywyt/UWWmnCMWcdl4F135KDdchBj4xcx1zvWmOmUEortD/?=
 =?us-ascii?Q?7R8yUlg0YvUHxpY6hjlavpJyB09HOpFo7JTkmxMGzPA6h0WUT+msJj2ekOpD?=
 =?us-ascii?Q?v7uQSBNIJ1plTdo5gslPqZiIQRus3qgtENdF8q0Rv96mIhvKw8RY5s75MrTe?=
 =?us-ascii?Q?1e5xl8u2mwrEHnvjyvZZeHIYxruMpazs1NuCCxDsK++dXEhcnX+fBzp+ogV+?=
 =?us-ascii?Q?L4gWIxFL/KhDZZcv8Xifo9b2VppocV9KXDUisDskt/hEzhK7aTGauevXrsfd?=
 =?us-ascii?Q?OmhxEp3hojrkM+SDCose+10DsAWaI5u4d1tY+flAjSnf4FVzx5yGZaeZpl5Q?=
 =?us-ascii?Q?NivKufZ80DNG5gMRuXcXjWKaVBDd72UdoOdcjwX3Nu3Qh15viiioh/er+Vk+?=
 =?us-ascii?Q?ze+bE108+HakJ0yabEuDSdcY0UW3AGztLcReAySVfv+J1QhfBxOqlqh/rWYe?=
 =?us-ascii?Q?CV99/2RbQQqEDmwPKnHWQpur6XI6189/yiZbyLcQijhBbcspD9IFmlmJL9ME?=
 =?us-ascii?Q?4C2whRf3Gpbr016WaKdPCA710POT+3WW64PtpzzJSdiWfsqzdFoRBaKpo1Op?=
 =?us-ascii?Q?e50WOOria1oeaF847rO/XIkXLKbTAtQ7Y+bM106j3OBFeTaMW2NVkgy19o6A?=
 =?us-ascii?Q?nhRqTLSOqtkDbF2X0NMUKqtjZ4j9QAclwhMuLDrmpwiyXq9wgJT9h3/+WWZB?=
 =?us-ascii?Q?9rpvcH8yC+A5puifH1AxIpy1H556WR+ZZz0KYwpMVnN6wv5pNnX70Fb6qCdm?=
 =?us-ascii?Q?ftYJUKv1OnD9RCO2ZX78XVrIaJe8mSHFOkgAZOKYoXR6AD5maUx2H/hsV1lY?=
 =?us-ascii?Q?egLA7UAEdFlGcLQmdeYwId0ZnLEcFFPxJfB6asWVVXuAt4eDoc2/Z+qjBbCY?=
 =?us-ascii?Q?QKhgXxS+3rjcjUF7xnsMdCeVOvj7cXpLEGqOcKo2aP0SL9NhJ+xBIO6YOhIp?=
 =?us-ascii?Q?EdGG80cUvfEVeTVXY3VGSGuLIs46uZbG+O7JT9opB7eVbZPk5cKXx8ZisVVU?=
 =?us-ascii?Q?JTqgJ9dB92154nYySmU3kA1TliWzuqutopLsCr0oexCk9k/PpYF///ai5+IW?=
 =?us-ascii?Q?Itr+yVILV7v5/mq7uY2Pn0z4oT553gGwOZUYd1VRQXUiboUfe/7icF+I/W1N?=
 =?us-ascii?Q?i5gEznqgCXn9huDX5hOzbymKE/Lkjcxr/Ig8V7L/I5QKp36YWFT7neR7xk/x?=
 =?us-ascii?Q?jwOfCAJ7gRhBlajSQaPG3598Edbhd9/ShnatoBn4m8nz4qKjmoqqvSxFyzr2?=
 =?us-ascii?Q?TfsjYOFNxvU+w51I2YIyguzgAWbV4h3vd+YkEx8WwwZq/c2mGNWicezv1CcF?=
 =?us-ascii?Q?oXocZJL/7LULZWPifdR01pNI1YzTl0Z3iGPZlKWz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5ac90d-a733-4ff3-4413-08dad864606d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 15:04:45.2136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7TEzqkjYs2P2SvNQxBft+mAZZeaA25GKXUlc0CCAkRMNpIORaBAObwe0InN6p8b1XvQLCdwXQ0P/nw+iQfmlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786
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

It might be better check amdgpu_sriov_vf from the beginning of the function=
. Return 0 directly if it is invoked from guest side. Don't need to print o=
ut something, error injection from guest is invalid.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, December 7, 2022 18:04
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Chand=
er, Vignesh <Vignesh.Chander@amd.com>; Yu, David <David.Yu@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: skip RAS error injection in SRIOV

And return successful status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index ad490c1e2f57..854cff9e7ebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1103,15 +1103,24 @@ int amdgpu_ras_error_inject(struct amdgpu_device *a=
dev,
                                                          block_info.addres=
s);
        }

-       if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) {
-               if (block_obj->hw_ops->ras_error_inject)
-                       ret =3D block_obj->hw_ops->ras_error_inject(adev, i=
nfo);
+       if (amdgpu_sriov_vf(adev)) {
+               dev_info(adev->dev, "RAS injection is skipped in SRIOV\n");
+               ret =3D 0;
        } else {
-               /* If defined special ras_error_inject(e.g: xgmi), implemen=
t special ras_error_inject */
-               if (block_obj->hw_ops->ras_error_inject)
-                       ret =3D block_obj->hw_ops->ras_error_inject(adev, &=
block_info);
-               else  /*If not defined .ras_error_inject, use default ras_e=
rror_inject*/
-                       ret =3D psp_ras_trigger_error(&adev->psp, &block_in=
fo);
+               if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) {
+                       if (block_obj->hw_ops->ras_error_inject)
+                               ret =3D block_obj->hw_ops->ras_error_inject=
(adev, info);
+               } else {
+                       /* If defined special ras_error_inject(e.g: xgmi),
+                        * implement special ras_error_inject
+                        */
+                       if (block_obj->hw_ops->ras_error_inject)
+                               ret =3D block_obj->hw_ops->ras_error_inject=
(adev, &block_info);
+                       else   /* If not defined .ras_error_inject, use def=
ault
+                               * ras_error_inject
+                               */
+                               ret =3D psp_ras_trigger_error(&adev->psp, &=
block_info);
+               }
        }

        if (ret)
--
2.35.1

