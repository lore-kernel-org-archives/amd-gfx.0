Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CC9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 10:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD2810F2D6;
	Thu,  6 Jan 2022 10:22:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A99510F2D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 10:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwgBr4phnnwYa4flZzrevCe9H3Fk9omChr8CWyFyDviuwZ+SfweUwRx02Dn2E5Cp3pqq/6qRjagpPIlCWW3/sA2tIGZ8Apjf1doNf72y4uMgkHJwLVEWlLngHjBL6rzMNj+CN2r68Qt3P2yQEzSPi9Fp3dNdh8GY8BlqHQmUJ781F/epAlIjX+rPnzKzHq+cJcXzfbG+rvCdlpiGaspNZIGa/U9UkaZXtgtpUwHqpsrvLMv7r6fKy22p8GjlNFnYZFQ8j3AhBwBBkJvmEyOsmVecxTLF3uulu3Wtie2xkAhZp28/hTKgNX8ckykLDarVlWj84iSqBzxKgJnWRIvmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj66FHQoqyOViWLgvrigz79YSGXXNbXGUpsELCh8nJo=;
 b=lL83sEvJRzfivNH/vMkOhZuea/0+DExVQqwIbKNpeMBD4CDeoQvVbx/CAoh95Im61ZEWMbVl1xsalovwdxxznd5sq6jZQi6LVHGGFnodZRTUNrCOz66EB0fE8rzGrxXUC/4uzQbvYHPA8I6vruARxeZ0BIEHKbsmbYpWPJ1CeuXcEAfHK/RxHYRqAQc4NWg9h4N3KlV0MpK5kckxwmFqYrLCRfhNB4opEYX0JKAF2rYwb3WTJyeuPGKOFX15BblXEvYGJOaM1FbiF/WRybuEBCgUDilzmBui4c2XT84kQ806ELkJZdtVmGXZIqdyBSZPrYXfhU+YUSFZX5LVAhQYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj66FHQoqyOViWLgvrigz79YSGXXNbXGUpsELCh8nJo=;
 b=I/eu5r8OLHV3WfcXsmrDHjResV6iCSybNlNqikGahMn6G777nfr8xyeSgyBw+sCscg1CrRH0R7A5hN/gLkTH+gRgEllXRcL7j15RuTt01Yff0hrqAi96E5kaO4TL5Iw0dcr95KdpswdAQ93N4gvxjv1RUnQJoeeUHnpWa2LShMY=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 10:22:15 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::490a:136:5b2a:b75d]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::490a:136:5b2a:b75d%8]) with mapi id 15.20.4823.023; Thu, 6 Jan 2022
 10:22:15 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Clear garbage data in err_data before usage
Thread-Topic: [PATCH] drm/amdgpu: Clear garbage data in err_data before usage
Thread-Index: AQHYAt4vpZ6AF9U6PEKmolyypTm+pKxVxBQAgAAA2kA=
Date: Thu, 6 Jan 2022 10:22:15 +0000
Message-ID: <CH0PR12MB5156EBF7431DE87069A900B9F84C9@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20220106091640.18705-1-Jiawei.Gu@amd.com>
 <DM6PR12MB4650ED32BC92BA7B1B2E468DB04C9@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4650ED32BC92BA7B1B2E468DB04C9@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-06T10:05:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=055bee7f-cd50-4ce8-a257-f0f5deaf2179;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-06T10:22:11Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9579c774-9e80-42da-8395-4984a6ccf606
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 971b6f71-9831-4590-bb72-08d9d0fe692d
x-ms-traffictypediagnostic: CH0PR12MB5385:EE_
x-microsoft-antispam-prvs: <CH0PR12MB53850DDB9B647F51EC43DC6CF84C9@CH0PR12MB5385.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7wstP2irmeDZl5vnUWvMbkiqr/vbIZ6wWdoMf8RMkdCCmwNxaSHdKvzbk8SUCTpGkCgsMxXv7Xb2W1ZWvGbBKvo8WPwpqxf6sYVAgS6qLjiUo+AAQ+reAa9dfepkb73+sY+KuSRTfVOfbOrw2XRxylzx6xie6SWbTZOqdEBNeVb5xCFgYIdTC4lqJMN9wkEsCG5IklYJO08WtKBRrWgc1JJ6d6Brixp5s7rvVAkphkxSro/QCrkOQvvYiPqU15w0aPMX+AilD8s7FggFVtyeWR/LXXBPMG30iCe8Uk+zQj2W+W7Cx9FsjQ3Cakw7E7njUjX3ZPWr+mb7E6yEeXSvBiNPOfT742y21oNIXtDOGihsmU6EfUlgrwfHK3ZBd2R5zFXLiHe8aTZhKXS2m+H01ftVkwVo7MQ3nOvtc+fqnlnSUjG//+PvFKSqNy9Zb5qwLA6RfUICDVItaE6EwUbuam7hfnjV95L7lWF5KlJJ9NiJxc7jnlwWrCkwWBkKSxgY3qyPoyvY9gzB41pX9XC7wTJN1Fu/gV5crJcEStQsIG9CMi+wU6jLPooBd10ke86MGdLyw7CXVzXRjFsFOvqBafxgD+MFJnsspGY036vo10QeyTe6LT6/w5AyPTM4GoPOtpHCEhPI9MWCU2AerZdg0MdaSkbCuWXjmZeGhFP+daO7UzXUhVtC3dm4lvDYc03kbtfOnasSgiGVHzXef3LzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(316002)(86362001)(83380400001)(7696005)(508600001)(53546011)(64756008)(66556008)(66946007)(6506007)(66476007)(8676002)(66446008)(55016003)(38100700002)(9686003)(52536014)(71200400001)(122000001)(5660300002)(38070700005)(6636002)(110136005)(8936002)(2906002)(76116006)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KMMrJrguIKpDrME3rJNbE66NXDee69jU9Ong0MKIqpfPvFgHe8ZScATSigMo?=
 =?us-ascii?Q?g3m9YA+b7e4iI/g+3CrKfZM6z+NkZuUJ9d5lgjsJuUTwNa/ME2rNm5ipNZtI?=
 =?us-ascii?Q?ZOeY9u+T+1q0UzabSJY5URNoleTEIT9/zWQAfel0xoIhYUa5dSs4ZYdK6DZG?=
 =?us-ascii?Q?ixnw4pGZwpNbwzGpCdkTCjx/+OLwiyJzsKke2Cm0hhvdK0ha771HIJ/Q+ZXy?=
 =?us-ascii?Q?GMTa8+4nFhkHWgfjH6HfFF9CWvxAoBKac8NoFPggPuv4Dfya87IdZtggeytz?=
 =?us-ascii?Q?uquYzpCNbDnrCIF2tRzLQH0WIuNOG1IoGyVMwfOk8tG4oWwLFxnpLsX0x6By?=
 =?us-ascii?Q?VMNHgOTTYW0jF9SdFk40i6n4wtxtICdKGZjnTFbBYdo+ntlBwJz8c5tamsWk?=
 =?us-ascii?Q?XkiFwK2m8VVPRzPnqy2vG/74vISkxM+mvsjM1v1myTDii+Dz6Pe2v14ABpaC?=
 =?us-ascii?Q?L8nBbLNj3pv0tvXZVNhPDoUjPqzQcqlSXdMAMiminSyw1lRiiLqsKYj2o2yh?=
 =?us-ascii?Q?vv9qcu2JsdI7bJNJihYV+822xXLb39WgMxkPK5PcCkDez+akPNFfFY+lpY4/?=
 =?us-ascii?Q?Bwxnp5l1dXEfseOUaAF5b6+1UbEAo7TZ8sH/xRQUkCph6F+a6MUMr59cBDk3?=
 =?us-ascii?Q?b9IrrxQ6zU/IPELetsFZ10cDW9NqBelZEHWxwtZxOTiNCYSVOJc05+/t+HsJ?=
 =?us-ascii?Q?DotBJyKbM9Emc1xogf7YFLZLqNprQAK6pHkuta3+6PKcZLsltmLXivfj4Gn4?=
 =?us-ascii?Q?4IdLB0N4VOqsF6/GcSZq4Iv49O9ZdhQs4bpDqyJ8lHaccNSsRpJg1yUAJAlv?=
 =?us-ascii?Q?7XQf/b8YtQmsqJo2HJ2CrMEfNP/YCclnaila10ijVsKwxmIop3tnR+KptCe7?=
 =?us-ascii?Q?4XVyJLFh3rCUMiQ/ydwQD1mfnqJknC5jJgcEEOgCSUe109Uy08MaGRXrp2dh?=
 =?us-ascii?Q?zEWeCs4Wn/o3Zwjpx+GJ32Nax+4aKNpTHDNjT3L7j1Rq/bE+6No51W9x8C2+?=
 =?us-ascii?Q?G8s2yBOo3foqUzYwlzyajs9qwxxYODlR4lleDza7PqZa+V9f1fWHo6HUbzhi?=
 =?us-ascii?Q?AOsdj6CHkBzfIlqC+ECFzMeiLxWA0+VtKpV4wGbfilUS+F3bCNLqN2bXOE9W?=
 =?us-ascii?Q?fC02uRpPJ36y9N2Ts/TDT8jzSQydE3HVnjXJtBl9fyhQb32IIuZWCMzT9A9M?=
 =?us-ascii?Q?RbsPxQjoTzttAjeA75cnZbP3OYathsuGAMOwlr1cxBFtlf/ZiYIEEJJHThmf?=
 =?us-ascii?Q?WyHecjvrrblot+9zPy0EigHmqECzLwz6sxWTh85Wj4ZCW/ycCqEZI+PB28Bv?=
 =?us-ascii?Q?jAsX8ayC+3mE7IYsShVgubzQxaspsuAg07LW1SIV7g+SMiYA/5Qz4ihxh/Iq?=
 =?us-ascii?Q?OtkcF4NI9Shu2U7bGk1CxFOrqTALwR5QkLcCHJwXTvjvDUl5RW8DN36b8hVa?=
 =?us-ascii?Q?cjllw/86VgZ+HJyDvk9zyACH5qGgs3ndQ5Sz7fgYp150+WLxjgVf6j5oDljM?=
 =?us-ascii?Q?d7bo6mpa6P5ruAm98GVyHHNB5KGLBtP9do/MTBRkQTyM3K7hYfYk5GDPSr9i?=
 =?us-ascii?Q?1WLjCl/Zr/oW+QDjJzr2tfJLpQbpmvdEgI4BAijxLPI49soZJCLVZYAkw75w?=
 =?us-ascii?Q?UIhYMSsknmMgrDCqknoW8oo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971b6f71-9831-4590-bb72-08d9d0fe692d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 10:22:15.3261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDapHqruGc0iTdj/F4t44SplOL5U0eI0JDhLYtp7QvVIsX3vrPlvmAuvLWrLt+9NUiduyYekj1kfl1u48SXsIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
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

[AMD Official Use Only]

Via ras_ctrl sys node one uncorrectable error injection on Sienna Cichlid, =
two interrupts will be triggered.
I was informed the two interrupts are as expected since when error address =
is not 64byte aligned, one 64Byte SDP request will be split to two 32Byte r=
equest in UMC and sent to dram

Then the second interrupt handling will read the garbage data in err_data.
And the consequence is that ue counter increased by 2, and page at 0x0 addr=
ess will be saved unexpectedly.

Best regards,
Jiawei =20

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Thursday, January 6, 2022 6:05 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; C=
lements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>=
; Deng, Emily <Emily.Deng@amd.com>
Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Clear garbage data in err_data before usag=
e

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

May I know how do you reproduce the issue?

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Jiawei Gu
> Sent: Thursday, January 6, 2022 5:17 PM
> To: amd-gfx@lists.freedesktop.org; Clements, John=20
> <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Deng,=20
> Emily <Emily.Deng@amd.com>
> Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: Clear garbage data in err_data before=20
> usage
>=20
> Memory of err_data should be cleaned before usage when there're=20
> multiple entry in ras ih.
> Otherwise garbage data from last loop will be used.
>=20
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 31bad1a20ed0..3f5bf5780ebf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1592,6 +1592,7 @@ static void amdgpu_ras_interrupt_handler(struct
> ras_manager *obj)
>  				/* Let IP handle its data, maybe we need get the output
>  				 * from the callback to udpate the error type/count, etc
>  				 */
> +				memset(&err_data, 0, sizeof(err_data));
>  				ret =3D data->cb(obj->adev, &err_data, &entry);
>  				/* ue will trigger an interrupt, and in that case
>  				 * we need do a reset to recovery the whole system.
> --
> 2.17.1=
