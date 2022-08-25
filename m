Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F8EC04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB9DD8911;
	Thu, 25 Aug 2022 07:00:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852F1D8B71
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgGlE5l144WQ2CWxi+n3rKXzBYyE3dv9mt+Jj9SJqF3JHdKBNhM7oSuszBLq79oBMlzS4vyUjbZfMzZK1as2DZXxip0ec2kSCJtApeF7dfw8MimxGkxh44IW+URgRf9fyYUYsw4fI+m+t0F1UahJKpjz1xwc1yTxX971xhSjluXLHso0GPHrK6r6T6cAJ383f6S/mQay56BG2p+2X9YnLVBfLVT7KXjNHQvFjxClkCnyujbKXY6n1zAaBOGnDWBkdyFjx8MYHeiHlS6fIHXiV6wYbF3aYIbfQMoaLvvUNHlaaYzstoPgvrywvAykWfzDKwiMuhwkJ2w1dMLmkC4d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDyCEl9Ibe7/g/wvkdaJ+v30wTzrz9GzL7SoYohXqUs=;
 b=cU2RZ70XJG0Q0f6ZkKe5wwD0FWEDe++mpVbXElRBNFejUl7thujOGYOWWhlk6nAFMzlv0IFRRYHMVmbsT/U+58gfNvYw9NZ0/mk8UUaftAKGMU4DPP6k6Yrs6JJ6pUXz4R0F2AeyadkQnJKyosIpaGeuPC36EJlElZUU5G76lUURYKbFJx5eI8zIJbOdWGJB0UDRVmlRsOxGg5pRHW8vKi7k8WfpjeF0TOX7iN+aORYtq+nf9SdR3mejPOjO4UKOETryaD3a9xBKf7r0G0Xr1z19UWzo0J1p4wFt0oBtbjmb4R7IseT0PSzDX67xsnP7RPUL0nlOEHuT3+ZWO2DSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDyCEl9Ibe7/g/wvkdaJ+v30wTzrz9GzL7SoYohXqUs=;
 b=tYrVH0v/Rui6eQ06bvSnlfyRR8Ir0Ew2Lj+MPqnN5xQTE86Gobpgh0nsHIMJAEuIuRCuI7OHGoZAYbXKjbjuCsgkwkXI+x9PkGa9fSKij8Ovf2J7sjanm3kGzZfnHXqA8XesRjdhDWRqtoRO6aLMdi7PDocPEsyYAGZGSg+Lobs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CY4PR12MB1670.namprd12.prod.outlook.com (2603:10b6:910:4::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Thu, 25 Aug 2022 01:25:49 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::c851:4d6:e0a8:3587]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::c851:4d6:e0a8:3587%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 01:25:49 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Thread-Topic: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Thread-Index: AQHYt4R3R9k2uhrdWUSP4V669RyZ2q29/WCwgADDGYCAAANzAIAADmww
Date: Thu, 25 Aug 2022 01:25:49 +0000
Message-ID: <DS7PR12MB60057561EB83F6A2A7B27030FB729@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20220824064048.2581639-1-Prike.Liang@amd.com>
 <DS7PR12MB6005164AE7FD86070B2E545DFB739@DS7PR12MB6005.namprd12.prod.outlook.com>
 <BL1PR12MB52378253F334F7CFC0BA71A1F0729@BL1PR12MB5237.namprd12.prod.outlook.com>
 <BL1PR12MB52371CEB555CFEA6F53CB20BF0729@BL1PR12MB5237.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB52371CEB555CFEA6F53CB20BF0729@BL1PR12MB5237.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-25T00:15:15Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=99420bb2-b49e-4600-8d74-1d73e2a752b9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 451ea9d5-1aff-492f-a6e5-08da8638be2a
x-ms-traffictypediagnostic: CY4PR12MB1670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9abf8zdeprA4kMhag8sD+Wa7mgBuXKY64g38Oip7w8EQdoguKA/P1F7sCV3mtnsPAw5bsWf5x70k495CzH6TbOHQ3u9MXpl16we1EmycUWXWH49I/Zj/cTFWk7MUdO2MT243Ht6Lo6YBiDV0KDM7oK4qclTTaizKAm+wjyvj/E+GlIm5939BWWPVLDb+8bpF5ErUZtSn7Xd/qTfb0XuQvBLID/QUM+LSaBzz1KPyA9HsE8BfPndSpRdh28yinUyCJqht3M8DMqPwH03Czum9FZ48EjT2VGgeJRkNmnHRhVjYcikmhbjqvTn3ybNLgqVp7oRgfXo3Kg8rA5unlRQf3qp2/Ypdfh2HKXXNrneMuNYYNjRMXChJvSgPsxzCvMDR2uyRWAcn9Afr4Kb4tR9bsKer6xFIPmnLt9d3j5oKW54Y1QhIeFEsNJtOhMMMacoeYvViTUS9ULCKo1x3vjvKqoy3xo12slGeDfPI5fcIMjXM/GhlqV1dMUVMnFXBKoApk9fQwERhd2QIoL19oCMw3jfS1fJI+zf88QzVHZmmye00gXyxW+ROSzHD5OjkXNgW3pzQoet9D7ahu6kfYfDKJHMBPdbqUM4MqHIeqSxfV5RuOvASObG7+YU2/XGLkgnVCyrhLkxC0xtqIINpSouEXDC773ehzhybPgBSeuWQCvIhjRJV/RXebNZ17ZwkIiGOv0BtAG+kH+TCBRiXQz5bvUjjH8bxg35vDKJ0m3S/MWBFJVy+K8uBuccVOy9VJL/yGIRHBO4if8uLjvd3pHD0Lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(54906003)(52536014)(76116006)(66476007)(8936002)(316002)(64756008)(66556008)(66446008)(66946007)(2906002)(8676002)(9686003)(5660300002)(38100700002)(33656002)(6506007)(26005)(7696005)(4326008)(86362001)(55016003)(38070700005)(110136005)(83380400001)(41300700001)(71200400001)(53546011)(478600001)(186003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pte2b8z4B9gk3+RZTTu879wpA9HyVqHM9pwvgE1dbrFXBlt6ryH3M33k5wEZ?=
 =?us-ascii?Q?RWGyxTK0ng7M0R5zDb+N2mM4lbTWo7FlnNcIXluRYjqCHxr2a/HF2XA7ZwHm?=
 =?us-ascii?Q?1qkOxjHqEkhYGZjsn4zDDqh1rQtOgFNUpLM1RypCG2iI+dqoq2QSQrNfdIWw?=
 =?us-ascii?Q?SxQ37d10M20sUiaHr9Dzy/2lJ+G9YvFinrHDmuOeDSWqJKxRvfjWwOnPT6c+?=
 =?us-ascii?Q?pDrUf88iu6+DPnMsC7jrqPtFpyBNWQ3XfX9avkpquDK6he+g/6n93s/sd4C6?=
 =?us-ascii?Q?K69gVnaNdwUfq7QAhk1dU6qoGgqkN/qKHTEEaQHQhzxXc0Pr1rrltzTQIete?=
 =?us-ascii?Q?PPHtKSEayLP1yIAiSb4EXwtqWx8NQcPpEF9CJ3A0b+t3LXa6Q4VqzsPwvbET?=
 =?us-ascii?Q?cm6ocnGKfurmNKzTJJp6oYUHY4mX9ISuPTxdpi1vwA02ZGUyG89KyxuUmhwT?=
 =?us-ascii?Q?MKayyRHgNRK4+GmWLqWAyHg9jcXtYLz0ffXKYbkbf19/uf5PtyK/mkgv/cPg?=
 =?us-ascii?Q?8ZhKiq4NEzIgfZo8C9V044/F5D+l0hROZ8RLCKnufvWPk2Z0i44kdklYlBKs?=
 =?us-ascii?Q?471mtY+XTTkdZgnz8WJa2VXSUmzOg9ffwt25CkLli/IE18Cqvyk0qlFJfcSs?=
 =?us-ascii?Q?Q9F7+pAouo+Y2d0/bNsoUbsXQhLoy1giZNLcoAvjfdRa9cPqwpZxM8OMySgd?=
 =?us-ascii?Q?64xqRKBouP3104pNTIzNRtmhV8orY8lnCMIEMp05Az9W+oaAnK5sxp885ksA?=
 =?us-ascii?Q?ND8FETwym4D1ds+43fxp/xZVglMdI1z4OhZTUywMiTCWn5HPgrakmE1gRRvc?=
 =?us-ascii?Q?SDvdZxIl0CpaLufGAw0/pu168v2drinjBXXMgQ+JnSR4nqvtybg4Y5RAkFkf?=
 =?us-ascii?Q?yu2QGKcqtjgP7ntZFJCfdHKNDOMrdhsbeTc1qktWFr89ukam/dDKEC7iYnam?=
 =?us-ascii?Q?T8tMtEZzMDiejDjUGwK9f4TbEshTD2SvDfxbmPCOohUY7T8h7RcUsbk1/LVP?=
 =?us-ascii?Q?1lKiHmXGExOaTCfhm3SQmV/fkYyL4CVgCW8kcYPMU+M26rUWFGHgRmNn7zVd?=
 =?us-ascii?Q?gJ6mxDJJ8pWeog+9qEJ2dn4bJt8WI6Jvnaho4vbABiFcOMTUXCVvGKHtaYiy?=
 =?us-ascii?Q?231I0X1x+SEYGg83JMn419eOKN8k0aYmv0JwCglvhp6FRrr1p/UBlIaSEV/g?=
 =?us-ascii?Q?9czkotBhkeTAhdvnFEObBO59XaWWE2ByQOviZWYYRafuN3BX9eJs87nAKgIP?=
 =?us-ascii?Q?N4y+YJX5NuY+UAxdctdobfpFsBfonsVg84tZ1tT6mhTU9mhI2PChp/b7eYdS?=
 =?us-ascii?Q?Ggt3oCnDa6RCXHhjwJmnluI4zhRKbXmTY21xeFuWV2+0AZ3zXJJWPbiIVBXr?=
 =?us-ascii?Q?FauGznggyELufLnz6cYHWvWCfquBIMiO8lyMa2cIdlRhF59bBzNwWFRgXebh?=
 =?us-ascii?Q?yWMwDHAWGcGXTArYDxwbPn3u3LKUMEqTZOJe+Vp+3HwBeYSLUOwq1x/2b4ZM?=
 =?us-ascii?Q?WwdG5x79tsst/vLOeHwh95z0GLC0T1AoJB2xYR4gKFf9roaHeJzqxfExOWdp?=
 =?us-ascii?Q?kE50fFBMMqx2C6XaLOM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451ea9d5-1aff-492f-a6e5-08da8638be2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 01:25:49.2947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eLw9nLvuJuN/qoqzFgHAeLLnVNeU/e/KK2vj2t+LBXhUdT2rfo39DaMb2/E5/Au
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1670
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
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Thanks, it makes sense and will refine the code before push.=20


Regards,
--Prike

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com>=20
Sent: Thursday, August 25, 2022 8:28 AM
To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Limonciello, Mario <Mario.Lim=
onciello@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7

[Public]

Because GC_IP_VERSION 10.3.6&10.3.7 all use 1036 ISA version, one nit-pick =
as below. It looks better.
		case IP_VERSION(10, 3, 6):
		case IP_VERSION(10, 3, 7):
			gfx_target_version =3D 100306;
			if (!vf)
				f2g =3D &gfx_v10_3_kfd2kgd;
			break;


> -----Original Message-----
> From: Liu, Aaron
> Sent: Thursday, August 25, 2022 8:15 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray=20
> <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Limonciello,=20
> Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
>=20
> [Public]
>=20
> Reviewed-by: Aaron Liu <aaron.liu@amd.com>
>=20
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Wednesday, August 24, 2022 8:40 PM
> > To: Liang, Prike <Prike.Liang@amd.com>;=20
> > amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray=20
> > <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Liu,
> Aaron
> > <Aaron.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> > Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
> >
> > [Public]
> >
> > Add more for the review and awareness.
> >
> > Regards,
> > --Prike
> >
> > -----Original Message-----
> > From: Prike Liang <Prike.Liang@amd.com>
> > Sent: Wednesday, August 24, 2022 2:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray=20
> > <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Liang,
> Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
> >
> > Correct the isa version for handling KFD test.
> >
> > Fixes: 7c4f4f197e0c ("drm/amdkfd: Add GC 10.3.6 and 10.3.7 KFD
> > definitions")
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index fdad1415f8bd..5ebbeac61379 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -388,7 +388,7 @@ struct kfd_dev *kgd2kfd_probe(struct
> amdgpu_device
> > *adev, bool vf)
> >                                 f2g =3D &gfx_v10_3_kfd2kgd;
> >                         break;
> >                 case IP_VERSION(10, 3, 7):
> > -                       gfx_target_version =3D 100307;
> > +                       gfx_target_version =3D 100306;
> >                         if (!vf)
> >                                 f2g =3D &gfx_v10_3_kfd2kgd;
> >                         break;
> > --
> > 2.25.1
> >
