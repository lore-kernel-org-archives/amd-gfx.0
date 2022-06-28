Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C19C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 02:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC9410EE89;
	Tue, 28 Jun 2022 02:17:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C618310EE89
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 02:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBX+fhU0TNdc4mJxH4ocKpH3H1VRifQdqZPfgSnvG8YyeZa5zwnsZT13ByfeWZaYEgytB5Zszvhdy6GwcsRzXiLscqBJsqcyCIZprwPvLWa/+vgF/o6ZGJ1xjoQhpMJw4YpHUkcXf+hE7D7FSts3UlH1U8A8yZ4wHKXIgPsIWzoJCJOgf0BMwDAtZSyUj9n4K6MyemFak05mnESOZbqhqsp2qx6jiPzb97t4fz/4QU8vxOGvOWfbUDIFjwZm93OTIOV1maxG7LSZPCXrLNheOnlknsSFalyvvuh5eLVvZ1YQkekPo9xA7bDKlLUIWv+byEcn1U3z7EdxcGH548np+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAtfJj9dMjewLw4EF6+tHGV+chaaqLVqTm2j4xYjiLo=;
 b=AiiMgAFIdxOD2s8DYgadjzWVLIzECSaHlAsIa4D/Fc1KbfC/xUAd+CdIlDXvkkiinGz+XjgcfXBfIrTDUHF3pKW6fo5EokWNXq7SI8POtBWLY/g2cOJ50zagRBn5aHgNLtcCnZVILdZxG81pxi2+tocjc1H/pBsKdMflYqDdrXG+Wz7OITW+eeHj/z3Rn4g48PfnBbV7H2LxFvmqFH1vP3fag58xvS2OvNBqO/lgxRW3/J73FryEYjs6AWhqulxhPvSsHPe1+QHteE0QuzxW6phWz3xyrY8zHq+2EreBySndHh9XJJxISZwzTUsO+RcgnXCJIBhgxQBVb9HwlGpeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAtfJj9dMjewLw4EF6+tHGV+chaaqLVqTm2j4xYjiLo=;
 b=x13c6CScQujfCAm0nj1yf7sh3pfR8IfynCCQU3cqnYh4lSiC2Cfr8O8NB/4W+/ifeSBjMSWyWEqycqujy7WviC9WzHBIFY37zlDYMcKM9KaHvMEcpRWeGzWqnKDVpXmWv0+pxbuJslPDDEg0I5G94zjwsrilqUMqE1T9DU7zddo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Tue, 28 Jun 2022 02:17:13 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b554:38a0:aa8b:819d%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 02:17:13 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove useless
 amdgpu_display_freesync_ioctl() declaration
Thread-Topic: [PATCH] drm/amdgpu: Remove useless
 amdgpu_display_freesync_ioctl() declaration
Thread-Index: AQHYieN0fdJ/0XfDZku/WreKLN+DZa1kFjDw
Date: Tue, 28 Jun 2022 02:17:13 +0000
Message-ID: <DM5PR12MB24697B636E5F318AF7E18F4CF1B89@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220627050206.1415724-1-Yuliang.Shi@amd.com>
In-Reply-To: <20220627050206.1415724-1-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66574126-f24c-46e6-4315-08da58ac508b
x-ms-traffictypediagnostic: CY5PR12MB6624:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kuJDHWCxILVVTxGq/2vdnS+ZpMQHuLHBlMt5EexPlM6XPI0OY5wqHGF08r0eTm2zYYZUQiGMFrbanUf3vsnU+qBSH7BTsbwkvsi/A0pwCS3rQF3KoZ8IX9KktR58Zz8tW0w4D2qXhWfTyVkT2uKFTCcTx5WM22o+NWQKp0xQvr+Jztze22m2FFe4v6X1JigbKZdtobstAOXaybTJaJju/sT2HWI5bIFigZZZIbUsivEeZQmbu3WzBQW3RMPwgir61VcfhDKRyTUNmKRsqhqHlImo38stuAxA78DN/j6OJKdfHlAfXsp+9LOAPSFvOngBQ9KTJlLzoUFUeJwrGglYW6ocuoEggD89lj0SzULeawSFRUeaXXR3TY52UOqofwHv0m3rcoAhjJFyW8zoWuzrhfKDkk0c4VxLYutk8jlEi4lrJrI/7fDlx8TIgRisXzQ7WH4Y9zE5Ikr6lEFJ5/IHW2gHJp2fH/6KSDyI3fis6KERDQWrAj91ZwtV3YDIbvw0jUyPHI/KTNhqV+I4guU+tIOMJAuREvKYtakvgCscCqxmRAo2wzNd7LYInUV3+mLmaxDsvgiJyDANQUjWzQxNrRk7oehqi+F+i9ocy0EViKBRkSHyhoV0QkVl0nVnnCg/FlQQIft6rRLVKWyroOkYs7LvLGbxqxk7Cn9rfS3+QwvfVu/rmNlXFkucDi0KJ6Mp9gpVxSzU68tX50Kcs4oWw+Wgxy1bLfBKEc7JozWhE0i98lSaIR/rHxX1haukCk8x5+uclvSRVP+Ri2+0taxMS973yCj7dQuy3KBx5Ps8aCg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(41300700001)(8936002)(83380400001)(55016003)(6506007)(38100700002)(478600001)(5660300002)(2906002)(186003)(52536014)(26005)(86362001)(8676002)(66556008)(4326008)(76116006)(66446008)(66946007)(64756008)(66476007)(38070700005)(71200400001)(7696005)(9686003)(53546011)(110136005)(122000001)(316002)(33656002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mUF+YFVkbPnNE4tw3/xQFq63s/2kBTwafFzWeeZ14j+p3D1Oh5Eb5aW4msf7?=
 =?us-ascii?Q?vmY4U065V8akMoxabNRu9792EOFJTK6jtyd/Gd5s9t5Jw8vUckF/DKqa40UP?=
 =?us-ascii?Q?HeynyhGSoRTJG7GYXQuKagtqsC/pvXHaopOn6IkYou1PIdgoCRhWXArSEv6P?=
 =?us-ascii?Q?rZZM9N6VWJAR0TeEWKRvaOUanaEq9zZNSqQCHCXRS4ipUBVZ1ebj6+oI0B2h?=
 =?us-ascii?Q?yrUbzGmIOp/EboQIijYLSBforQT6EPjzcVcmPxQGyUbFNQ7eMCcEWUHtTZSy?=
 =?us-ascii?Q?fJ61VWaqyE04RiNOOj2GweycCDU9RRakG4PTaO2naeNz8Y9TCt5FUJq1i9u2?=
 =?us-ascii?Q?pnbySmjsmP11jTmkBerIAMYpWL5I8Nd38UqXSWeoG6y4RVcD6sR3/XKhDw1A?=
 =?us-ascii?Q?WEST56xKXCCdV3OjylOhttrbV6XU5W7hDwr8uVsk0RcB0SmhD8o5ujBMoFxv?=
 =?us-ascii?Q?vNyjsrOGpO4oRqY4mfaR2h6JAva0Bk4lXwkTx2ZJrFcfnFy1xdKAhgMrzLPE?=
 =?us-ascii?Q?JPf4nDi/9aH/GsP3wgA6g6ZBTHNKrD1J9gggf72cRK+7U7wfJ1A91vdF0/jb?=
 =?us-ascii?Q?rIgKLMIuFpGPu15p5cbqdEFzP7gze+OHnU+i4AzS00I2MKV0D/a0UQY8VWcY?=
 =?us-ascii?Q?YNNEa2bH6yMtAu5l/+hF5OnunhqgZt25moP5J5TGR+6JI7dZP5JJICjSjO2U?=
 =?us-ascii?Q?CJi6CJEguNevK+vRnuKrFxlBduXjAcMUon7/9wGE0NC4KAUC+PsM3FA+GZRD?=
 =?us-ascii?Q?iaZIlRZWcwrwmmz1AcubdtyeU1TaZTAMq0ccJkMssFgaV1uNk8tfGg3J5cId?=
 =?us-ascii?Q?lzoHcVQyAQAtGB7dg0AU4fSmILMtYs4juO4AvnMK6BrwBW5zg/u9F5UbBhi9?=
 =?us-ascii?Q?0s9E7t6/D6CU1Xgjo/Ag83P9279dcLJ1h8XEp2umawFwDuYwPRgqOUI/EkV8?=
 =?us-ascii?Q?Y7Om70LI2r7WzjcckWMZ+1Odi8+aLf+agFBsC0khCNyp2PxSc7GnjKJa9z4n?=
 =?us-ascii?Q?VwFXVP+FI9MrF1+Q+a6PVfPYLqn4sJhK2Sflh19xAMPEHhltvMkMxdDhNlqx?=
 =?us-ascii?Q?rul/OpUJ4cU9BAvFMHmcFJsfCHjO/PcZyrwTKr1PnouxCHl+HwWyWM2eqcvx?=
 =?us-ascii?Q?1J46kKkxS5TiMtLZ2YRKa6tu9iiaJx6QoiUK3ZM551FyyJpuZi35Dgr+DJDb?=
 =?us-ascii?Q?XfGfKm9lcBsBKJfSw3Irl2Vm4chO2onOmo6hsmCu980qpeXsr+XZ1pGRuD1V?=
 =?us-ascii?Q?0ra/GNhwqZUA/Qg+jCjqQegl0K8agJ4p7bB1GkW+NAv6yjI+4fGzX3E0IUQB?=
 =?us-ascii?Q?zj8acksZhYLgpAZ6AkPVIemhQcuE/D6kCWTcxr77CrJiCxm7w0o9OLscW2lb?=
 =?us-ascii?Q?nLSwopWHNwlTcHJ3ohTmum+e+BAsoHgkSUuQ5KqeJAatFHIj/Tvnd33zC8iT?=
 =?us-ascii?Q?XxoUFW0YtnafyGTFJHMF6kyRkRsSTD/4I5xlgjdnJ4y4FFCSBOguMGcByeTq?=
 =?us-ascii?Q?DVYwLEWySabvgaAgPiZ1f9h0wOOjbbynYFGJdnmHSrjMJg+7KSGzvPQUx8Qc?=
 =?us-ascii?Q?BO/INZj2kSQoKl6STSE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66574126-f24c-46e6-4315-08da58ac508b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 02:17:13.5113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAHiyBOhk/x0cIp7A4SLH79WH/vtLgD13kupa1K3iBcA5kgFmaxey2WNiymnWLEICn514e3H9Uj3wYZKWMaf0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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
Cc: "Shi, Leslie" <Yuliang.Shi@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Leslie S=
hi
Sent: Monday, June 27, 2022 1:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Shi, Leslie <Yuliang.Shi@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; =
Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Remove useless amdgpu_display_freesync_ioctl()=
 declaration

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.h
index 7b6d83e2b13c..560352f7c317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -35,8 +35,6 @@
 #define amdgpu_display_add_encoder(adev, e, s, c) (adev)->mode_info.funcs-=
>add_encoder((adev), (e), (s), (c))  #define amdgpu_display_add_connector(a=
dev, ci, sd, ct, ib, coi, h, r) (adev)->mode_info.funcs->add_connector((ade=
v), (ci), (sd), (ct), (ib), (coi), (h), (r))
=20
-int amdgpu_display_freesync_ioctl(struct drm_device *dev, void *data,
-				  struct drm_file *filp);
 void amdgpu_display_update_priority(struct amdgpu_device *adev);  uint32_t=
 amdgpu_display_supported_domains(struct amdgpu_device *adev,
 					  uint64_t bo_flags);
--
2.25.1

