Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BBC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 20:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225C814A86F;
	Thu,  7 Jul 2022 20:33:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D24A14A881
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 20:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoEeLhp4467IcDNWZvaj5KmJOfZwVWskuz+yY68NaiDYep+hYxklVDeJiDRZR2setIZjNopstEErjrdpWjSZc6828aMTCOfn73QABd/4X6aJlqxH3j3d4p6y2uXEs7fL1i4lME1OeSZWUwRkahC9QJnfqi+HC1gUG8jy+EgtQoEi7jVYLDVNUGj3P5k8A8LRLRzAbN+m5Gb2FVRefIAlZN8BnEIfCIGM4SayHMC1YlOIRW/Lj7J6p8pqBcKxjbKgHpVLlUWMYeshY7NR3zG3zVUvqtiqA0UF2CghmUq2uanQUxJ0Gj/06TU7o7JnFZJWbPFMrVouvXDyp0ZF4L9O1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUa88b5EYKdGjQhBGtxHXaZRSX+Lz8ZWPDyA0Kna4vU=;
 b=WJpRDpq8mN32zSuOKIvvX0yNt4KLJtQlHu0DUPzzzSNppHQnags7M5kvF2gaPQaAjYiB8WfuivjokE6HsWiJrHiq+IzHgPp9kzQPNag0ai+h9Br0+jdtcUfydOKwpeM24Q3w2uH4BaIpyTG45jwTMyoB9Z+bBKSMeC4bfFmkeZ9bnzGyQE2hM3ydrHqVoetB2uhIMlpTMUD6ReTfKfV/JVfkmWdWX+uyLQt5V3Qz+/4JzX5R/nd9o/YPrFLIkUq51ZCAHf93Ylnr0hBb7h7TDHC0qYaAGZvvBte+ppIC1O1li+wGP3d5KkNY1DIXzDF4GdXIgzDLm2KBl5eniFwvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUa88b5EYKdGjQhBGtxHXaZRSX+Lz8ZWPDyA0Kna4vU=;
 b=zdbN5VZr6tB73ocgIoGWTyWORy/K6+QQ1dKdLVuslGtqHC5DJD4ccTOnrEZwG9QsoypyAClidoe9JnEwZsS8qml8/YFO1xeLD/0mNBX66y3O45UkjZesh0KCLMaJ4iT0lE0xi0kcPzVI4BJE1mwngBkL6FSfghPiMajcr+R38CA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 20:33:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 20:33:31 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY
 instead of depending
Thread-Topic: [PATCH] drm/amdkfd: Select PCI_P2PDMA and DMABUF_MOVE_NOTIFY
 instead of depending
Thread-Index: AQHYkj3Jyzf2OKfloUCKIi5ktyJrVK1zXEkAgAAARWA=
Date: Thu, 7 Jul 2022 20:33:31 +0000
Message-ID: <MN0PR12MB61019F4FB71D60DB46065C9FE2839@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220707201135.5070-1-mario.limonciello@amd.com>
 <SN1PR12MB2575AC720C83FE2193811981E3839@SN1PR12MB2575.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB2575AC720C83FE2193811981E3839@SN1PR12MB2575.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-07T20:33:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=dfde5a13-b2c3-4f83-8596-13ebbf2faa9a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-07T20:33:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1128e2cb-af78-45b3-8040-d5db91f19ad8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bb2af3b-7597-4d61-d258-08da6057f50d
x-ms-traffictypediagnostic: BYAPR12MB2949:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FWrrEq+9abvWNfsWvaFi4s3DGWFVJrbM3u3QyTOZZsfemd9AL2Oe71THBPJHmQvGzbQJlmQyYKzskLef6E1086PxpmFY3GDAYN5kIMsuchudzNztVP+MAavu/php8w37GUugintWUgjMsdBp6XUQvvfCyZVBoGd2yEWzTYqdOlI27HOEXxdUZUQqwV20GMsCqIF2Pxjwbj7o+9fohUx9PeFVNmD46GAduVWEialTAWv9fwbHPyUjwpUWFmcKAEVK46dANQnlt0ObcUMsT35ENSv1VmmiVwt5+y6byrV6CU2Rv+MOPIiZX7jYMqpqKO/e/pGDRW0Bgx7rp5O1YxwcFQfAwcW4X8G9vCNIaR7uWGvgumpp8xAlHhppwfiuFaujy03rcbDIDJ40LG0KwXfCWxGsrp26yL5htfWf9GuVXTagMNFoDT2aOtzSDkjRgzWjav/+nWJcdBU62pP3EOGC3gFHont2UHl+AaCbUgTbRmCBW5Ihx/bbn/nPf12u1oeba09JGzgWhfA6wNyul7PwlSHX/SwbhWk18MqEvspOwQ9XZnaSOnCLRrdBV1nwnXRfeTJ1D+C+Jit2wF+mStl6iCk0XWysTvffYVIVWQA4YLTNJsnSgg/xMm3dpXHnMikXcaY2YVjIdVLNzfy4R3JRevHvY5MeDQmD20E8v7KYYe9GI45kXEV6+1oTIsTHwnxbhkcx2c51s0R0qzgyWIYtqvQoJGErfw8ihGlw1OolfFQgy+Pk/7AuOvofvOhLooTUfiJ+gIMAK6KlrBNPkz2cMhWrjydKgWMq2DXLL9rOCkTA3bu9zmDP9UGCGXvXe3YN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(86362001)(122000001)(53546011)(38100700002)(33656002)(8936002)(316002)(5660300002)(52536014)(478600001)(38070700005)(41300700001)(8676002)(64756008)(66556008)(66446008)(26005)(66946007)(76116006)(2906002)(186003)(55016003)(6506007)(83380400001)(7696005)(71200400001)(66476007)(9686003)(110136005)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9KkVnSrXFPnHN+YO9qCnFHUz0x7nwcoF5uCU6Va4tSPj1VTItW2GTH2ZYdFE?=
 =?us-ascii?Q?B+9tK8tRTj3bxvwZPAFF7Ld3RYt3/sPGaSbBEvS3Z+7Ty+8jZCbmWeJvBVQn?=
 =?us-ascii?Q?/ludVwVPQmqkS7xOP0EjcAeiyiEQ2RAQCKHiqP1kOcLkMkgda5nwjsdUrh1a?=
 =?us-ascii?Q?rWjjFSQQXNHqQkJYTwhSO5dOQNUkN6nJFx2ZAN7bxZQbJgcD9fPIEyiyxBCc?=
 =?us-ascii?Q?4RCkXspHIBNiYNZKIXmPLga1xNdTQNEKd21kho9lmjr6ISjIJwdSZStvq6X/?=
 =?us-ascii?Q?HGdxdKYl+/73vbC7oWVAmf/SHLfbPX7j3BDjFQl73FHpzhPDkjpxXFqlaS3w?=
 =?us-ascii?Q?9mKilpXl6AOPzM4Rbm6EFlJ3tSz78IhrcHAL4GkByTjVMbsPv8jtZmU2lhlc?=
 =?us-ascii?Q?mEluaCd56REc/fWzwtvsOPw6BboW4na5T43a0VVFZYwFHC3rjBwyBCy/6uUn?=
 =?us-ascii?Q?xhTqDgeAOLdp+cL86ZPfN48KzG6IOXsTL4q/N6/OWnHorenrDuHkrAztHxur?=
 =?us-ascii?Q?Qs913RuwJrtc23bfNwBTaHvYW68vrXCPFv4QIIXhQ8pxssg6w1S/iPiv2xSO?=
 =?us-ascii?Q?UrD4jj8dlB/FR5SFcARCVHUa2DIRhx1c4+P8GiPbWfu517x0lo9LqsLN61zb?=
 =?us-ascii?Q?XXpOH33zyHgSC1UlKm9J2/6+Y/XO1RyMqrh7raZ8uurx2dVxTG0s7aBbsE7t?=
 =?us-ascii?Q?10xp/X2iwqjY69N51E9HgtkQaxP1grM3yn36ETrcMil4fpflwRnCOpTU6XSX?=
 =?us-ascii?Q?XJDwYkT25taUJHlOqNixRdaJUMx16mja/M2vb7oknTxzNlIly57o/qZTnWT/?=
 =?us-ascii?Q?2dZp6eakd3vMmEseJ6CeCvRRXUjpZ2+kWmrDOLvPdDVTTj/1KVK/M2rGwbcv?=
 =?us-ascii?Q?I+16HgDh6405N6x+rI+hYeDcC2yJ3F3jkkvNaxn6KjqYLW/6AS6BQlL3RV2u?=
 =?us-ascii?Q?mF+PsBOzXm/NIo0mV+0lAsGy0pX8NiDT0r4LN6g0f2D8jE7zdZCWw70zktjl?=
 =?us-ascii?Q?3G+iUdQw1B+0WOpdUh3nAwO29WMeGGao84lxyMCm8eycjt9ZiGWmkNshoBRc?=
 =?us-ascii?Q?5Ev1+INiRkotD0xBdUx76P7GLTh1GwWuPuZjm0vKThyzwv/0MfhVWBGIBPCV?=
 =?us-ascii?Q?jc8yvBVM6b+206eea1PL1IW9EESOnWUEyf6s7ajFbwv5Flsw+T5mqxYLmEP6?=
 =?us-ascii?Q?lS9/gXBM8lG50zcSp0QtMQr6ZE2Ny6IoL7QWXqy50UE5zyq9/Q6hz1BeaQXj?=
 =?us-ascii?Q?ufwMBqNJR8GrLOGu4UBgVaSgJOFNIsREaagakJrTumwcHBDEhkdbuy8qOoPi?=
 =?us-ascii?Q?9i3Jk7EYR2Ek99PJNp4MKW1lxeV8D9ee04YyvKUVMeVNRHEqc9SiVJ38Hz9g?=
 =?us-ascii?Q?TatSTGmiOz9BEQHX7QF6ib22N1OKtEltxa91XRdSSCTKtvx7P6tLhNE/wBos?=
 =?us-ascii?Q?lT0PNqdB+BIenmPu05jghD00T5Ym0niShY0ImhHc9Teag00ZWpVG8LTEkDzw?=
 =?us-ascii?Q?xaS2Bm+WW8ycf90xzQO2i5rKJgUbpjNZ48xD2NAlNZ1omC6fGc0vKtwGOEXz?=
 =?us-ascii?Q?t7zcIOGVJ4wvaw4K5s8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb2af3b-7597-4d61-d258-08da6057f50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 20:33:31.5935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5F0H68tisxwQkNt4IRD+/LggPrSu8WNffJ/XLEYME++O+ETRpkzrykaneOgshjdtjny8xwGoom4e82INcnHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
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

> -----Original Message-----
> From: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Sent: Thursday, July 7, 2022 15:30
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Select PCI_P2PDMA and
> DMABUF_MOVE_NOTIFY instead of depending
>=20
> [AMD Official Use Only - General]
>=20
> Using "depends" prevents shallow binding. Applying "select" can cause tro=
uble.

Can you give some more information?  What kind of trouble can be caused?

>=20
> Regards,
> Ramesh
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Thursday, July 7, 2022 3:12 PM
> To: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.co=
m>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] drm/amdkfd: Select PCI_P2PDMA and
> DMABUF_MOVE_NOTIFY instead of depending
>=20
> [CAUTION: External Email]
>=20
> By having dependencies on PCI_P2PDMA and DMABUF_MOVE_NOTIFY the
> option HSA_AMD_P2P is not discoverable.  The kernel menu configuration hi=
des
> it if the dependencies aren't satisfied, making it harder to find.
>=20
> Instead select these options when enabling HSA_AMD_P2P.  This way
> distributions and users can just enable HSA_AMD_P2P.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig
> b/drivers/gpu/drm/amd/amdkfd/Kconfig
> index 93bd4eda0d94..b153c26903ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
> @@ -28,7 +28,9 @@ config HSA_AMD_SVM
>=20
>  config HSA_AMD_P2P
>         bool "HSA kernel driver support for peer-to-peer for AMD GPU devi=
ces"
> -       depends on HSA_AMD && PCI_P2PDMA && DMABUF_MOVE_NOTIFY
> +       depends on HSA_AMD
> +       select PCI_P2PDMA
> +       select DMABUF_MOVE_NOTIFY
>         help
>           Enable peer-to-peer (P2P) communication between AMD GPUs over
>           the PCIe bus. This can improve performance of multi-GPU compute
> --
> 2.34.1
