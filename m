Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8412AC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 13:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A8910E85F;
	Wed, 21 Sep 2022 13:57:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B2210E85F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 13:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSu+qmgKPGIwMrXB8Hj1KQyu9nE5hVibIj9smbya6sTdKVrMBNRKvf3iYPUQRRq9yI73/sMaS5vvIkNEAjTFv/RiW2nMHktjV7Ia6I6C5LI2wc+ZMcA/ZXC5ywTWqK/T+0LVWqD4zjfFHGOcgSJhqwZv0FDe/PfGoU7NVtZBFDml6Csj6jD+fnpNxWQUnXCAgLKCJU6XfFxmsw/dUtkwjJhV5ty+DWj/ilQmNqv8T7FsRuSotxJHw94HndjzbQSZwQLODOe6AA0QAveUzFi+QLCo30H/rslVv2MHigZwPavvYPS4QU5s9mxN0vWhgqXCBCelLge1kQRYfDWjodnPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9FdPeM+6mIScec7u84oE8pQSy0hKati2bU2Wnm00vg=;
 b=Fe6kwww3wpBrLoFw0C4sNn2YP+E6pwq7QeO9XZoCInAR3updhaBLfzhklDJOWfk068f8oqmCVzcVfQuATQDwclOCliWkeBzbbEYXTxM+W/lNb3qFa8dki0PP9fDECFgexHFhT21ytVjlFH+8EJJZkzXF4RaynxojoX3lCW0/2kZmVNL0A+Rh3hycHxMP9DpyqNe3T5yPmpPLoI0g8Z6d75cLmi/bHPhxBdMPwqWlyRipdIrAnHoEL0AHHRixIgpHozNdPbb/FdC6PXUBBxyMoOWFGcL6C3L91slboPr51h/XhyIYSYJlkCjkaGvCdylirHQ/zR07lVSsdB9K4QhuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9FdPeM+6mIScec7u84oE8pQSy0hKati2bU2Wnm00vg=;
 b=Ril2S12qDOLI4sXrI+HPPxEq6q/CYbX1Mrivro+Q4RJd+98XUKyteBH7HBo0VV4Q68/PoLPDJpyK8Ricwfe+3bVtOqC3He36lH397ymkI8w2ydCP8uWXIaMTqnZaoiqtFjI3Nmth8LKg3F8rmiXSZx1iE9/NkKEjNH7Hq1j+Cdg=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.18; Wed, 21 Sep 2022 13:57:14 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::2cd2:a792:2917:8df6]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::2cd2:a792:2917:8df6%7]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 13:57:14 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Disable verbose for p2p dist calc
Thread-Topic: [PATCH 1/2] drm/amdgpu: Disable verbose for p2p dist calc
Thread-Index: AQHYzbYXXNVC71TsQEG6D0hVSodi363p6IUw
Date: Wed, 21 Sep 2022 13:57:14 +0000
Message-ID: <BL0PR12MB2465E5C5181B8906FBB3C714F14F9@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220921123027.2866204-1-lijo.lazar@amd.com>
In-Reply-To: <20220921123027.2866204-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2465:EE_|DS7PR12MB6117:EE_
x-ms-office365-filtering-correlation-id: 2177710b-63c2-4854-c8c1-08da9bd93003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZn369ynJyQO2YqP5dk19Ypi91AhJm+UA5nEhlkcQgcDQlzsAA1/A3jovtaPlMsOVu/Q9R7YrmkBb5AF4M0oSfcetVFj/sbUrkcjEc78vdXwjzDwxc7WHvZX+wqZEPA5MoGljX6q68yFzoc/JLuSUWZPa69/0kOBV3LWZJkwQRVd43LazXdleiqlf0v2Jc6/SWkGOE+Ylxb9kS+Y1KF9lkb2ECwVuamL7xjWneqTaG6RB35YW50LlbntVth8F0TqBlKTkWcREdGpCTR8KqYLOI8BTXrckJlDaqso0rdT6Qosbq7AsEzpRJyNVUWKCdbJmujGg/8ssFEmVwodMnWGsGhFJN9X7fLmIQ4vc6QvzA/6QZPRztRnPMnCefldTSYPHSV+KnM2KcVND02fYdKMJxVqHCNZ88816uPOIY9iKQM82t41XkNl9fhh7zsomfMX0uel301ObvGsZlq9gccrnDWXEEPaQTdq9lG5aU4n+bj5thsKra0ZoO1L3b1uHLzcOZK+k7iOJlExLXggiWp7G6ASVGp1GN2ktQuPEYaoQFuP9iJgdkM+fzc5qk9ROrSjF8UKBsKpPEYCi7UH4KLw4eeh92cM6kbwluNjEe208HBaQrInkwCVJteAUJjUuWVnt7MKWcawrbbtXiVOfbpBXqfsthkgU4cGYxnHT1IoXoC28UY4nWYHitTkC6xJzOLeFYdXyUbhG44biRA6ueK5NrTP3/RUjNcQVyR0osfyW0E86A7g4lm8x4WjXbZfMRqP45fJU5alGvkqnfbPr6f1Lg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(33656002)(110136005)(83380400001)(54906003)(52536014)(5660300002)(316002)(186003)(8936002)(53546011)(55016003)(86362001)(38100700002)(26005)(8676002)(76116006)(4326008)(6506007)(9686003)(66556008)(7696005)(2906002)(38070700005)(71200400001)(41300700001)(66446008)(478600001)(64756008)(66946007)(66476007)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m+nWXtDIpgdkYIeq681xZV2W12AiGwpKFsG44mtDaSsBZsgtIWsZZgcnazAN?=
 =?us-ascii?Q?bACrqwSnmXKBKrpKWMLmGMEL0+yjzCbCSSsrCV6N7tipi0ZtNPQMlaUkLNC5?=
 =?us-ascii?Q?WpqXuxAso4WuVGnBPkguwmh/KxbKIOLjgZlu7RFlIKbko4TmZCLmiMbrBC42?=
 =?us-ascii?Q?vp/cGDfjlRY7/kSS1dZ1ChkxVYVTPCl9kpNruLQ4MigV7Pd1SQN/8IZtGB5b?=
 =?us-ascii?Q?ih2+jPFHatcSdg6UcXCbD5jxN+7flXZ4FEwmHiGp42oBHOee2sRx0H2kEpah?=
 =?us-ascii?Q?BXeDO2hqoiq6v/I2O5FKChe/OLzKDGUVBbdGuFe0uSR80i+sTLMthilE9ZwI?=
 =?us-ascii?Q?Obt3gujx1yYW0JJFIr/3+p9XUX2C2wbeab/l7DygDd0qBQfieBhoGWYWEVfQ?=
 =?us-ascii?Q?9/dKB4PAFb3y8whX++tHfAtFOHF5WAEeGLUZUa6HnxxuWF632GlXEcYkQEOX?=
 =?us-ascii?Q?LjQ4VZ0PYXO2FazcwFsBr2c+pSnAunVGxNVJDZYo3vXu90gQ2JUcU75u6OHD?=
 =?us-ascii?Q?FgcJNMsj8vZWvVJ0KmwCk6Bi2wcvJ2xSQyrOTQgE10KJAscDACrXNO1N3O2y?=
 =?us-ascii?Q?3Xgzm017XXnWgtzfDdKZOy0PKJ45e4k6sPRIsvqvDWRUKtd4Ef0nj7NBbvcv?=
 =?us-ascii?Q?KdRBh7aIYUv34zFVwGam4tVQ3HZUCwDIXhRTTlnoQyz3JgztiFN+aDGEjcTk?=
 =?us-ascii?Q?ytiUdWQee2pa9ShXE7otquSesWfn+E6yBElGJs91qp3RXqXIYOnwHLUIlcS9?=
 =?us-ascii?Q?jVwlBou41uY1OiIOeiK2d3CNX56UI+sj3Y8RGVFrwLWe2gPJcBk7PB1QzkJj?=
 =?us-ascii?Q?FMwpiP9mktJbi9cL+4ihSUhy41ZSguOacY7je3Ly609Ohvrgck1a7+iwMDmL?=
 =?us-ascii?Q?YbsG63eyaZQjIrMPC1EWK7U06DBC4QbaHjCk8dNqjPcTemDWepoZgioZ7068?=
 =?us-ascii?Q?sgNdt4Q4xOgYZSG6z0KHyqz+vR7ATbifwRea2LPgx8ia3Tsv+f1neMuesvth?=
 =?us-ascii?Q?qSAbDOfgLB8kawRWo5NZpigG/PD8TH4dATiHxc/1eGqs08EAeoiWRgg/G+e9?=
 =?us-ascii?Q?h89ir4wkp942TTOYLKx1EqdsZQmFG1y9ktPPGctEngzXJKOmMT5QAlo6wLyX?=
 =?us-ascii?Q?XjuaFQVaLxXlHOFym1He333Hso90+0nsE9pMbNagBdtl0QfR4InvafEt3k3s?=
 =?us-ascii?Q?uSwxnS2FlotY/HToBNNsiqFi5anzy8KsIUz4gPe0Z77M2PkRg/TrTS5IANT8?=
 =?us-ascii?Q?8uEniNIVuQgVg/b8dK53IE50VbAES7fU3o9Z7e4XiIu0zgmzp+8dsBMONoPn?=
 =?us-ascii?Q?DzMPtsl62fZYF/4F2EuMfSjee2pTehyrvWP4DIjGLKYXJq4Fq5fmTAwS8pjC?=
 =?us-ascii?Q?QDD1ch1ho0+Ih+I6JKUpIf0Zx6iUNNr0c0HuRzExfhrX5UoA3XcCi7SLO2SY?=
 =?us-ascii?Q?Fq8J5XG7LEjF6v4HrXAdzkfcf3Zrb281KjOHNHPZLSH3nTqWjt1DfzPWY7Hh?=
 =?us-ascii?Q?Xe9O9bZWfabSBI5BeOw0NpwP6j55QA+ujASF8eN7LDhT/SaTaHVxVltG2gEu?=
 =?us-ascii?Q?SSl44Fsw2UeRl00OM+8NzHMB85YYMVa5SSPwzK6i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2177710b-63c2-4854-c8c1-08da9bd93003
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 13:57:14.1484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VvRh5OPmwYoYEK1EtiQDHerPes4bNmNY5dyczbg8PeVk9la0Jcfh88EFnSZYhioRrQpr/8GZce1g50lLh5l3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Bai,
 Zoy \(zoybai\)" <Zoy.Bai@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, September 21, 2022 8:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Bai, Zoy (zoybai) <Zoy.=
Bai@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Chen, Guchun <G=
uchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Disable verbose for p2p dist calc

Disable verbose while getting p2p distance. With verbose, it shows warning =
if ACS redirect is set between the devices. Adds noise to dmesg logs when a=
 few GPU devices are on the same platform.

Example log:

amdgpu 0000:34:00.0: ACS redirect is set between the client and provider (0=
000:31:00.0) amdgpu 0000:34:00.0: to disable ACS redirect for this path, ad=
d the kernel parameter:
	pci=3Ddisable_acs_redir=3D0000:30:00.0;0000:2e:00.0;0000:33:00.0;0000:2e:1=
0.0

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 2 +-  drivers/gpu/drm/amd/am=
dgpu/amdgpu_dma_buf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index c04ea7f1e819..f600f3a3fe50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5578,7 +5578,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_d=
evice *adev,
 		adev->gmc.aper_base + adev->gmc.aper_size - 1;
 	bool p2p_access =3D !adev->gmc.xgmi.connected_to_cpu &&
 			  !(pci_p2pdma_distance_many(adev->pdev,
-					&peer_adev->dev, 1, true) < 0);
+					&peer_adev->dev, 1, false) < 0);
=20
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size =3D=3D adev->gmc.visible_vram_size && diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgp=
u/amdgpu_dma_buf.c
index 782cbca37538..9e2a4c552a4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -58,7 +58,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
 	int r;
=20
-	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, true) < 0)
+	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, false) < 0)
 		attach->peer2peer =3D false;
=20
 	r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
--
2.25.1

