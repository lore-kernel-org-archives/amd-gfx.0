Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EEDC67871
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 03:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BFA10E0EE;
	Tue, 25 Oct 2022 03:05:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5528410E0EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 03:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux09PDwHcvVqz9RIZ0l5e7+TnHi/OWiDk1oq0t4PXhxR4OE3xyYPSwn/G+TpbxyxcnaZZFhuZkkNQc59XnJFYGpqaM1zoNtWWrhBiwjoXCW3c9/+iSyhZ/JVJpvj8JBFJxbFl35LjSCIQTVpD6BbyrsPtomRBfK9mLlS/UMdDoeTTn67jrju53nFikNvax3CjMozLwLmb+9Y4k2NCR/gJElBGLrOXeJ2dvdQq+BIy168Bgty7YAb/ZbI/ZIGE6XxcBujaIHF5r/9i+5JrKoiuDhqCxLgUjZwPqvYj8nOOa6mfts7x4GzpbjioTKSKEmn/ypHIkTMrUUEFpe65YybfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USXvGvdBrX8KiVsN59+Bw+PfyL/bGLwPThx71PLdD6Y=;
 b=Gw1n3NnmtHORLAlM/wv0zfs+Hg+MLiohe2nge05WiBHbQnzb3shFz6VtD1TFkzwt7fZ02ApZzGObtU3WTm9Be1BlcOV8R9URRGuMvBD+JhjmL7Gia0PZ/TaDX7psJXxYGjywE+HWb8qNWFcgycbVS/bSPB41GXHngPYRchM1aljMVeZUG9H5xF6UvIUkeW574UPU0ByaNy7AOmMhXKlvWwua/0jTWGp+8TYwb9T9DLbS0I+PQnVequa0pUY7crGI2dM2ueyISeEJZRhpD3Plzlo5UdHeMSUqaf/mbJ0iZ7N0ROSHGrhuCSasbx1XvMeC+NEtoIUbhlZjd9w2nc0blQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USXvGvdBrX8KiVsN59+Bw+PfyL/bGLwPThx71PLdD6Y=;
 b=mmgHUOeEWim9XqrCgaulHouMnN5eXQzSG0l5+UDxU0zL6L0fXG4KhLpmS8jlCo9dheOXRwGkQV8TY++WTxeQh+GrfUSm6+ftq/FDEt2HWMQacNltMRf+cg167h1ymcogEx9nmgmfh4qpq7cSWJz3u3DfJ9SFaZmcuVwWWZsWK3s=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 03:05:30 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::ed67:d561:7e47:ed4e]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::ed67:d561:7e47:ed4e%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 03:05:30 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: set fb_modifiers_not_supported in vkms
Thread-Topic: [PATCH v2] drm/amdgpu: set fb_modifiers_not_supported in vkms
Thread-Index: AQHY52RV2ucl7m8pW0SyG8Zy7ea1yq4ebkiA
Date: Tue, 25 Oct 2022 03:05:30 +0000
Message-ID: <BY5PR12MB3873D8D138474B5B9C96AA15F6319@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20221024045113.2532106-1-yifan1.zhang@amd.com>
In-Reply-To: <20221024045113.2532106-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b26de15b-bf28-436e-88ed-d8e606fc26e6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-25T03:05:19Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|SA1PR12MB6703:EE_
x-ms-office365-filtering-correlation-id: 91448ced-1beb-4125-d7ce-08dab635c657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RsaZy1r6p6yy0+Wcw+LHePL1kCvYKhLrNXkG2ft+A0hyXVDupkIEDzcDvASvuEMxkmJb4YTKWFuPVt2ve1IzJghTFKUeK2obOJ4t4JIIsPEKFOSN2nEWitwH38WRujvrxEkX5AK8i1/hO1Lb0hm8PUHqo8KXn2c6SUcsQlJbicbO+f7sfEkyy9ERFivDvjZaFW2afsFtQtB1oI6nQ/tZ37s8NNVLG3sy/MJngMafYTc9ZsIimTfnSrx3P+mf125/vDzueb5ViDSQakO/27Ll++iMxPUIDWzkMIJX0/gsftZOPg1hYj7xWFtkUx9LAioTuocAUWuD8Ijv+PDdKzO0vGejowopmvXMJ7ppSoabV6X+/KccmRhiP1VrTR2wHlWttafkMtas4ylF7C++IMwoi3AHvm9Yh1sld5ZoG1stQKORoYsdtIrWlkyVBVvQvXR9gklzLz5wWs0L0y3OrHStEOwJkxCkquJiKnGXK6fn2tnFlg/l+5F3CxRvxuPSUGm2VAkwapDYbVO5KoJvqOQecELWRnVrXiSNN3wsIHJwtqGYsLT6PSCqoyo3Yc/mQ85f7hr1589fbSJiFDYGXxhv2wYAFWw8znHga5+LILpk+3YOnNaBXTEwdAqd36jY/6N/3EnL7npXtsitAaG1QHjYRrkBsH78vZrL3Du87nmsVfRD+E80cGIvljt7KkyfyyMRtiNPNsHbuIaqhXwKSJEsTsBsVw7IO+QZhnWQTQvDpYx4Bu2eexxJnZgJFN5vt0xW5rBG87/hXCQNeUrf+FY9IQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199015)(33656002)(41300700001)(76116006)(66476007)(4326008)(316002)(64756008)(5660300002)(122000001)(66556008)(66946007)(66446008)(8676002)(2906002)(7696005)(26005)(110136005)(55016003)(478600001)(53546011)(186003)(86362001)(71200400001)(8936002)(52536014)(38100700002)(9686003)(6506007)(54906003)(83380400001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ci9psWnVI5cKp6gyCUPwHZ6+VOv1z6BeWmhQztNSHWbpeAjTgLRQ1jgKjId0?=
 =?us-ascii?Q?oNylCV5pJwr8NpRRujltQH3FXhWzEnJOChwiOtiPiRA3SR2d3+uKX92x2EB5?=
 =?us-ascii?Q?9IKmiIpQ/9Lbcq7xJTSUc8ya3qBFQTiT5j0hAdvai2jrsnBt9jD/XjMy8IDQ?=
 =?us-ascii?Q?EZFeM0zUYXjgNVcU/8Lh/ZKZXg537xeJYHafToY3g1LmQBuzgpyzknbCduG7?=
 =?us-ascii?Q?NA/cT0q6a0L37kQT2zeb3pX9kVjs0H7v4Dcgu09JRgKehVJ0nf4exkyuV35h?=
 =?us-ascii?Q?1ZhX5tTqkpQUx+U4YLH/+P4aicoD+ksbAavpJzxeJnhbLGqe34/D1k94uYgX?=
 =?us-ascii?Q?yB66Z/cu8xVWtvm0ujRuMGJm9/kEUtjoBldsb/+Z5aN7ikEcVECJpxAv+lXG?=
 =?us-ascii?Q?8++LH4thcfZwJInSz1faNf8ioackmXSIbTy27dVJfFXKqLtULJAHw91h68dY?=
 =?us-ascii?Q?02GomnW0NWuIlN6Yc/nQW63n7/uQ327aHLUweo4bcMIsOhK/g3TizBrw8Zpf?=
 =?us-ascii?Q?U0cIoMoqTUH8JEq4GUsh0JgowU6Keuw+XRDiUz+dz5shDw5XKD8znrrjuAuD?=
 =?us-ascii?Q?YixXeMC4X88uhvS349A0TQ0nVEsxKWKbiMp8dBGboYFCbtsktkT8DabE/sjr?=
 =?us-ascii?Q?pP+Cc4ks5rtJ/W1+VyaVVcyuW7c+qsl7RJ2WgQ89OnxMXkteclUmPKDacn5a?=
 =?us-ascii?Q?fhGmYrsnXDNBOT8t7GfY3opsCCOIqW2nAT8y8mjd04zi2OfoTqeE+mJP0nsm?=
 =?us-ascii?Q?g5rJwIxFH0yIGvSDj8F1qyygZ0/aixgLblJObSvXNTNi5AF2upQDf3xt6ypm?=
 =?us-ascii?Q?qFKX72tl3JkPkUU4dPVclv6q6huQ2IYrxYdxHl3XbBwG/JZPjr27k8f8IEIf?=
 =?us-ascii?Q?jGo/BloybYzLZMV8Gaw+9UghKUhs2rjEkiKSo1ue7snMujKyg1xll9EIQsva?=
 =?us-ascii?Q?MI8eWOamtFXdkbRJ4MqDmEPSqzgX5lxMZ+Ua47NibOPYtMj+2LWJ05UJBwUi?=
 =?us-ascii?Q?HiHTb3Kj7l27Ob2FCs48aVGaTOrxqsyMMfRqkyh4vzyEzRiher0vU1LzWy0D?=
 =?us-ascii?Q?6GoBPjyL/UBdXN2DfXjKmJack24EKC/LxdmsyE7yWyh1u96/kBjQGCoqtu65?=
 =?us-ascii?Q?snvqffHEaBSDBQiFjc+nZsfB/WQttKCptV2MwsGPcfiTY4gJYbrXxWdZVx6s?=
 =?us-ascii?Q?mMFsHXFo9kBZeUc9Ynk5rR/jFedleboRhD2fv8eM6Dea5JiU1YlvcNbWpgz3?=
 =?us-ascii?Q?QZbDKEphbxD55M0WHdM5WqqrQYeksJmPx0k3s0EfTE7w7I59GFzdgVrVSs0j?=
 =?us-ascii?Q?xP6dVdjRPGTAqKUwRdJSZ1r3JuAKJTmDc1zpqoOVVypZ3TiPkiVkVGVes5Gl?=
 =?us-ascii?Q?pkUcS+cGrKKyhytzqjhLsaEf35HyjFakf7VSHPh9TdLZej2zn7kzZyfIM+/I?=
 =?us-ascii?Q?Uhkx5RH10O+RCt13/BIqFYgp33UsLcTsgISypweozlYn0ZKRj9irA49mdQhd?=
 =?us-ascii?Q?/zJXqP41c8HBd/UAaKaS173HTA0H8x3ikcdbh9rArOdvMaC0Mg/pEnSmx2RU?=
 =?us-ascii?Q?wDdRliIn+SYss3iWvXb+fbyVTY0ZRzTwPgjoomKl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91448ced-1beb-4125-d7ce-08dab635c657
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 03:05:30.2889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzVJtY7eXPsOH9dV36FDR0GBnosHUdaR6TmYJlDJWm67ki4j2JZKwa5e/5DK35Dxm3pzsUX0e83ZjZtbpb8J0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Monday, October 24, 2022 12:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH v2] drm/amdgpu: set fb_modifiers_not_supported in vkms

This patch to fix the gdm3 start failure with virual display:

/usr/libexec/gdm-x-session[1711]: (II) AMDGPU(0): Setting screen physical s=
ize to 270 x 203
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to make import pri=
me FD as pixmap: 22
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Inval=
id argument
/usr/libexec/gdm-x-session[1711]: (WW) AMDGPU(0): Failed to set mode on CRT=
C 0
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): Failed to enable any CRTC
gnome-shell[1840]: Running GNOME Shell (using mutter 42.2) as a X11 window =
and compositing manager
/usr/libexec/gdm-x-session[1711]: (EE) AMDGPU(0): failed to set mode: Inval=
id argument

vkms doesn't have modifiers support, set fb_modifiers_not_supported to brin=
g the gdm back.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 576849e95296..f69827aefb57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -500,6 +500,8 @@ static int amdgpu_vkms_sw_init(void *handle)

        adev_to_drm(adev)->mode_config.fb_base =3D adev->gmc.aper_base;

+       adev_to_drm(adev)->mode_config.fb_modifiers_not_supported =3D true;
+
        r =3D amdgpu_display_modeset_create_props(adev);
        if (r)
                return r;
--
2.37.3

