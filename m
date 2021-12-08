Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DA3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 06:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCCB16E851;
	Wed,  8 Dec 2021 06:09:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432556E851
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 06:09:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH5LEURaLnXW7VwZ3ydyA7NMkHlxn5wYxUz/xm8cWFmhaLsjlYzC///SLsfxjYVIaf7UHsJz8wDRvupZTlzG60Is4xBwLzwKblMDQhY70tlrzmxJwhKzSGt18G4wnuB0hjHHU4OcRdc99qsZ6LBOxqntaVr8YcC6uKU3yAib2v1P8XfAeFZj/fNIlACjsThIchTJaVYZ2P78TRWBczNAtJac0HFSwKTH5QxxpNSLKpd9tlhZtvagvp5ATr5Nprdrzug1o6f9Sfv7PV8Nb6mmXI8iL8CtFF2tIEp+tco6+VWoFLE7VK0qNPMMYnKR/ECTI7/HZFdNbUsNabbEwshAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DStVtPkYKXRanGP+6v8ya6S+hAUsrpVT6lgqo+zOlkY=;
 b=S5pkc+pw2l/jEILZPiHF7PjTJE24G4kzm/tlY4tE4YCT9Z3CdMf1D/b7bXt/Xyh5ndMkDrBZ0E2bGh8czff6/C91ZwV/hkwKJmApOrT+mGJZ8QcJFim3RItx5Rwbxldh2qPqPrFtXUehQJqVDWlUQok6qtUxIDhWTRjGwygMSfXaAAZG+DH/wlAHpKfJSp0qJ0MZmUeubMgca9+xrd+V9zA7QF0TDPQUu3+ptBXLCyeRy8ndzUaUtCbgmHNooF2yebXoR4k8y4nk94/jB55hPOZ8gU01MpFiA8vgOboSyX013FihRwcazhJqBjUvrdFzYjnxrgZU6jRL+zxzzajS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DStVtPkYKXRanGP+6v8ya6S+hAUsrpVT6lgqo+zOlkY=;
 b=KmYV5tOxxzVbje61xiGTPvSU5VvHWMIgzwC215Gt2+a7leAYIryZwslJST9r20cuCh1P6OIrsFPnPZrAIXKqTIlhURE+IegJqXQ3is6Ruz7qY0E4Lg5ZDY+nNnupIbj+OctKfLIe4d4HAcoE8V/9pcJPUUgyPS/XGkfdpA+nugU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Wed, 8 Dec 2021 05:55:02 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b1f6:5cac:acb5:69d7]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b1f6:5cac:acb5:69d7%4]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 05:55:02 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>,
 "Shi, Leslie" <Yuliang.Shi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix drm_plane alloc in amdgpu_vkms
Thread-Topic: [PATCH] drm/amdgpu: fix drm_plane alloc in amdgpu_vkms
Thread-Index: AQHX6znTdqkcdx9OskKKQkXqx4fRZqwoGaQg
Date: Wed, 8 Dec 2021 05:55:01 +0000
Message-ID: <DM5PR12MB24695B93A1FBEA273A084390F16F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211207071134.157327-1-flora.cui@amd.com>
In-Reply-To: <20211207071134.157327-1-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-08T05:54:55Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a9b3b082-ebb9-40fb-9c3d-75b5204cb365;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-08T05:54:59Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b813e00d-49c6-4f8c-9c72-564c35737f45
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ce71726-88c2-42d3-71fc-08d9ba0f4694
x-ms-traffictypediagnostic: DM5PR12MB1354:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1354A701F8233BA3D45B26D4F16F9@DM5PR12MB1354.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u86B/xN5TDL1mgi2e4ukpYnlHVf/kiOUTIq/PaC5BEEwKtLPb2t+w+G0t4P6zVFojr5kTHBd4Hpxahg272UuyCeSu8Fdj9a78drVFD9v5gHNes0qfbYMgviU2EV1VFZ7Cp3Xcno6VGBN0FRYRJTbyEgtmjRBKDiCV6Go4loWeM25dmFB3pJ8SBeDXbySPPJC7M5xPOKYO9FKiZnzKMw6iaGKPClzRIT3G1Jko17ad0U0EiQHx+569szTXvb/jz/4oR7xczmnNXeWLXNYLuQBSdlZHR+kQ70/gpjynOYbab31KE1xrzZ43kiBvSGnenk7478nZxr4rHKvae67ik6o+2ojtk/tvF+Kxp/wUSWZJRf76Ay7yDimcsrdosvHdczbDpzzYQVHV/TZKEk3tzH6aPmh+OK//gUAHqhK7CjcCl7qeIlrU7yN4wmIzbZEDRzj97Kb+ATtjHGpkj4E1HW1qfbbYVpmWiWcNRCK+hY5ScfYDJJdbIKCrQ0hC6bjMnd5oEHVDlRioANN31gv7CT7VYkVkzIBICNhJyQGPwrjTk49MZ+H9EKTY28hRZNG6jmSiT7Wka/hShht0JFRa6XnE3JRpPe3l5/V3x1awIfeQM0aGTVGtZKCIVxolnUGklokQPCFwwS4+z0D4PdG5xALirc5u1d0ozjMvTTCirKV1QAZwzZSeippvzBzsv5V0jvTQ8i8Q0qeZ43YUII9wSWnLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(7696005)(86362001)(8936002)(33656002)(66946007)(38100700002)(66556008)(64756008)(2906002)(38070700005)(52536014)(9686003)(71200400001)(508600001)(66476007)(66446008)(186003)(53546011)(5660300002)(76116006)(26005)(6506007)(110136005)(83380400001)(8676002)(316002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1dEyh23vCdOqJnmBswoy8wA0xMgxl1NrsW4aDdg4hjRSAJSJ2aUG81IESNFE?=
 =?us-ascii?Q?FUaIS5yIukoUA7KcGXk953V4VJhUvYfM1nvPh3x7LetbB8uTXD4jU7Lyn2xz?=
 =?us-ascii?Q?krR5zc2s5paj/F+AfYi3QccwFg+85pI8kDLpJ5eIMi8d/sQ4413MKbjzNmU4?=
 =?us-ascii?Q?9IZQfdqv0bxGYCx0WAnhaYwwl53rWiHTqHvIx5ZhgItrVFk8TyS2iNwV9zkY?=
 =?us-ascii?Q?M0PBCvM+cmhfB7gbdLuQXNgAFeAleuufgHi8X6DPgGcb19zGtqrnzaiUCMfN?=
 =?us-ascii?Q?5NvkdO2OiZe7/df4i1/0UOI9mYlnDhJcNAofQsn5coNG5PVQuONjVuaW/3oJ?=
 =?us-ascii?Q?ttCDLRlyEzy4ctcY6dIAA7c2Xj0MlHuO4srjJ+GrUv39tWirL4l0kUvZZQ1s?=
 =?us-ascii?Q?iFySYIAOjFGfZB0V1r0vpWWaNDIlmzJflU3sEugqR5iDwG4wt7wlL44DTq/G?=
 =?us-ascii?Q?u0kt7K1NG35neMh/pfLPayIdjvPHVuotW7a4elYTRq2hzAdbnpdGcZ5pdWUL?=
 =?us-ascii?Q?Ji0+UzNbQC4cf9lWxU9I0OGcPUlAVA33xucK9jtCFhfYSke5Qu41krHdk/pb?=
 =?us-ascii?Q?AGiLMWgdgX0U1RfkXvODqe9rG4TBqW61R4wDPH2uO3FMlA7BKGazyifuoc6c?=
 =?us-ascii?Q?Qcz7e3/4bRATDtFv1lT2mQM7rDnOa4/jhm4WCzbrXw8e29rFVqkJ209gAftY?=
 =?us-ascii?Q?RQUqdAIzajtEmGkGD/t32VMIVRyK+9kW3RNqsTjfKsNz7JW9SdJYymYeMmn1?=
 =?us-ascii?Q?eZ6fyqJxhXMz8PF5O9WH/FVZp7rfO0NjwleHDiz/DfAxj3vpTJpbFDNv6T/D?=
 =?us-ascii?Q?Cu69dj7Oj+wNP6eROshHSQ1nr/IOayOOvLzh9zA5J5Pibwn4Vl5Vs7EPvFOC?=
 =?us-ascii?Q?8qsTArushOmKiRzAdrP+AQ87WG4Ui3dKedprD7GQMIsTeSHQTKee8fW/MG8T?=
 =?us-ascii?Q?V+hwDzITuMLkA8lmTmqtkOmoyO7oXIN8tKt81kEyhq4aowbVJRnCG5Q19LZQ?=
 =?us-ascii?Q?awT6ulE7LIdyM3N45njlhK3NSvOVnzKA80BcGaqXNVFxopQtdyUVDrv/vZHQ?=
 =?us-ascii?Q?HGKpZhdzUS0ik3nla8zm7hZXXQAZcyApXrK2JFDtS24U5Pvma22zMDx/Uno6?=
 =?us-ascii?Q?fxm7KyMptXNc8VJ4B9qTxaRUTRqQD90mQDdXny1G95YwJVZ4ogEN6U4Fp21H?=
 =?us-ascii?Q?Q5S8kdYgKfEr23QwhjaKYZv8mohOm5FT3YjaN6uuwb14JDwdTJLGlF5O28QV?=
 =?us-ascii?Q?krvazWiIFkyCatbHGL7rynHK8G+mFQ6jVoXKGe1Yye7mw4E/NCjskAbfbYUe?=
 =?us-ascii?Q?A5DwjZgADwujMW8PlpqcBNjHQUOWwoUAU2x8ptunikUWKoFOsQEoO+3Qiixz?=
 =?us-ascii?Q?pycV4FQdh6X6HRnPQLRRJ9TVSOwqwfczPYTP9+jgEA0ra0Fz3ETGGNM/+CE1?=
 =?us-ascii?Q?zQn3GdGsecsIqkWshdCAYhYGk/Ih7k0r8NX6cSL85LW5dnwCDQa/rSDoik6Y?=
 =?us-ascii?Q?oleJPLd/CViLcPBOfYwiMJdsjv86DsCHBm+SDr4O+A1/hDERo0uBZEzTMIWD?=
 =?us-ascii?Q?ne5q9mqpuov1MF4eEIbqw7SQxevVha5glI/H28Bca7vZG/qstXMhZlQpzOUC?=
 =?us-ascii?Q?Qgca2Rd2V8Nq0M0i2sjRQSI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce71726-88c2-42d3-71fc-08d9ba0f4694
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 05:55:01.9951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itr/RrVFSxTtMcZIInybc3gkCSviYycOWG2Wv076mXJ29lLA5iTStUjQBsF7zjI+UdA1gSKIoDHctDDunDRpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Cui, Flora <Flora.Cui@amd.com>=20
Sent: Tuesday, December 7, 2021 3:12 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; S=
hi, Leslie <Yuliang.Shi@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH] drm/amdgpu: fix drm_plane alloc in amdgpu_vkms

otherwise the drm_plane is not released

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index af3a2f8c12b4..0bf697b72ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -392,19 +392,14 @@ static struct drm_plane *amdgpu_vkms_plane_init(struc=
t drm_device *dev,
 	struct drm_plane *plane;
 	int ret;
=20
-	plane =3D kzalloc(sizeof(*plane), GFP_KERNEL);
-	if (!plane)
-		return ERR_PTR(-ENOMEM);
-
-	ret =3D drm_universal_plane_init(dev, plane, 1 << index,
-				       &amdgpu_vkms_plane_funcs,
-				       amdgpu_vkms_formats,
-				       ARRAY_SIZE(amdgpu_vkms_formats),
-				       NULL, type, NULL);
-	if (ret) {
-		kfree(plane);
-		return ERR_PTR(ret);
-	}
+	plane =3D __drmm_universal_plane_alloc(dev, sizeof(*plane), 0, 1 << index=
,
+					   &amdgpu_vkms_plane_funcs,
+					   amdgpu_vkms_formats,
+					   ARRAY_SIZE(amdgpu_vkms_formats),
+					   NULL, type, NULL);
+
+	if (IS_ERR(plane))
+		return plane;
=20
 	drm_plane_helper_add(plane, &amdgpu_vkms_primary_helper_funcs);
=20
--=20
2.25.1
