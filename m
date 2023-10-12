Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259F2CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 05:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BC610E40D;
	Thu, 12 Oct 2023 05:30:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9171A10E40D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 05:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h65NzoYdz9WO5wc5WzCnODjTcSnpBuzO7JyIVD71UUWYjjDfWkebcSF4Trk6A2pIn1SvmqCl5sjCShV7qHb8xERcOEUEBeYLjHp+QBHPk0J/ziOO9hzSMpotCqSY1kupZhtwedoJ/DgV8u7Xtuqoq0xaNu+QCgIKenpIdYZ1MBTne2xeAZDelEtT+x0TALp0DEFaqu3S/bxeBJW3lbSnF8uERADq0U1FjmOfDbNe+T86LCzos2oI6PFKtkDyvXIwUJX+yt2sMx+fE3rrQgyoHYxD0IWGoHPCg6S87+8VPqc9xsAro8BQSQG85/DMS+hxOSCTlOirXR7GT3L2Fjwe/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjVL+IX+UO/Ra8GYDe9eWviAwZ9NBfOKFSCEORSrAmg=;
 b=Mbp+a5guo6X11QLYgNXrzpsdC1stC1G5AEJsJKk52fTmJSvG75Qa2atk+6k8ZnmZlqzppyz6WmRiZj4ZFVckRDee9+q+Js2ekcaigrBU4fVZtgKM5V/eosoEx47VI87cuCPlQofz0yhmxzsWsQIqDmTcwzz0cSuilDXyU9P18JXvohDxVqyKRuDlIkaNimOTTfsHYrUh2u/BMQ+/ooezWPxZ5C5v6HOVMKlOqvEtUrJGqRgwod8iCOO1C242VLvKHqsptzaIn9FKgAJCDsbOiByLgoaI79xq9etCOycT4qI5aTqO8ZRIv1VL8td665LA+vNSDRiLtwo/+KaeWINDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjVL+IX+UO/Ra8GYDe9eWviAwZ9NBfOKFSCEORSrAmg=;
 b=nZnEU/eZyWJ4FNWDjasRTbdJ2DUUuSsn3Y2MZmWzTJ7qn7gce07AS46RwJJwf6b8J3k7yYTbT2O0uAYf+rAWUx0k3BXGeGMuEvjvAv5933iWAUqCRJ/FVNxo7CcppdqEjGyvwe6ze55p+S10Own7soPjCst7dbYIB9/0XQCaJQE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 05:30:04 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 05:30:03 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/3] drm/amdgpu: Update PSP interface header
Thread-Topic: [PATCH v2 1/3] drm/amdgpu: Update PSP interface header
Thread-Index: AQHZ/Mi7grI5LkCwzECaBIggbY9N/LBFoJWA
Date: Thu, 12 Oct 2023 05:30:03 +0000
Message-ID: <PH7PR12MB59973549900EE587F892749882D3A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231012045755.111418-1-lijo.lazar@amd.com>
In-Reply-To: <20231012045755.111418-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e80fce96-9b1e-4b37-9ecc-38469fcc3c4c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T05:29:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB7695:EE_
x-ms-office365-filtering-correlation-id: 982b5016-e893-4023-833f-08dbcae44920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bcsFUO+KBdMd9F6zn3b7FAanCWGrMc7nJcqJO12HPqmYrTL5iLAKSUS1HlApU/VU27hLacHfy0fK63m/yxeXnGmfCUQ2oOUCN3fsP7NiSYvd7QIAbGX+oGplB0AYZCBgHq7N5z5radDvxro6LqrVS6q0XK4dcpBGb0esWJvvGmsyd24LvCsVYK3sjAU0trQTloqTsaRJIMYMt800nFTXAJfHeeTdjS2iqaJYSvOzzdIHgtyOFWdyUvKBUBUPchnyMOXErKOfZ8KTrzn/hr8h8wrSSAZcLUupo97ZR/Th2nSXT/m//TWvY4MRj0/V1Xldv5OKTr3YqAzA4MRU0LR7+TVP/4UZ6Mh89AfBqOq12dEbtlZ7yzy5JKHwBQEOoXDR/EWmKDtOhslrTQKt1LeQhhiMpW9vG3Pc5/Xg3pW2CqN1Kn76V0/hXR2SA/i+gI9ZGE4I3GkiyNq3s0QLgq9azXS8QZ5MWEvMy0niMrg1+/9kwDlDV3cqZVbOmEtKVKdEa61uzne3T+dy36DRN2+9wtbDajgyYki2RGFE8z65Lek0Gn4W3WVAzF4mUxCjzIYbX5FTxCskHICEu6uGGf+Nm2mhar3g+HB8k/JHhQj4lrn52C2oPez9c7vtLjFcX2fN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(26005)(55016003)(9686003)(66446008)(66556008)(64756008)(54906003)(66476007)(316002)(122000001)(4326008)(5660300002)(8936002)(71200400001)(8676002)(52536014)(4744005)(15650500001)(38100700002)(66946007)(110136005)(76116006)(2906002)(38070700005)(41300700001)(478600001)(33656002)(7696005)(6506007)(53546011)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X+/DxDesruHRKgQRBor+iLMXUFIbQAMCqP94PlRBpWWRkA6ITRNebC/ZcmOJ?=
 =?us-ascii?Q?ESJxne6KH+heSvv9Si9ibMqtbh4Ax61V0RuuLPtVak0BaKP/CZuP1EtRsRrD?=
 =?us-ascii?Q?puhD0nPDHVRRI5cBcZw3n5VE93I7FoGtKkzeJ7Jll1Z0KiocZpHrPKwD+zTs?=
 =?us-ascii?Q?yM/DZLhymu+QO7nESWf1ozvmNQkGgah4giRInliJ4wyhZ3G+Q9T7IcF0P80m?=
 =?us-ascii?Q?OeUEaUmnfozuXZUvQwTiN9v3PT7TYVaFHONZDj2v+i5TblbtuTV2TcI11BKL?=
 =?us-ascii?Q?HuuVzZGv5kRw8tJ0daZJ8ZjjQSKVlO/9J1ORz8oL60Qg+LJpG42St9XX3wvt?=
 =?us-ascii?Q?mGadUkE0p4ufoMJ3XUnl/UQWTUbJJK3RqKUwD3RZUCJSZz/VcUnmodn3LxZt?=
 =?us-ascii?Q?TiK/xk+TGAD2tssfJgZT3tRDi/HOoa/uCnVoloXCfsFOc5DgeYq6fNcMjZFy?=
 =?us-ascii?Q?xKrJmmSOdRfNdgJ1YEZF86asQnWCIIM1++gk7abz6UlUpS9iiONwYJxt57YL?=
 =?us-ascii?Q?vb5A2tW4qj5dAZRlFXVIG4mpSWMoRf2g8xhnsMwTlnbfMkdW4mwUG5p1p2TL?=
 =?us-ascii?Q?4E3f+q4Z+ifYIFvVfZUXxex5Mh8ouQ3XUY08ja1drf2wEC60QPiGJyDP4xlm?=
 =?us-ascii?Q?VKSwGBzlwbcEWF4bXFdli0FpoWF0Uu99kuMj18DC/c4YVNlFZi83i1nAh3Z8?=
 =?us-ascii?Q?5OyC/2pHyOvUMsh08P2Tv0CYYDqWuN5gIyjHGs6w9QDGw5nl5zOjqROSe0+O?=
 =?us-ascii?Q?Y0jhTqHUt53U+CjIuxRpYkk7g/7ePXluGDenlTcHMf4lmC9iCjPSEQxMNZT0?=
 =?us-ascii?Q?Y0LATcphIN3snezCyrCnFZD6XBg0dyUWKm+3AhwPgV6qbRI3kmO/XhBBDY5e?=
 =?us-ascii?Q?pddtoB2HSnFReEb2jjrPd7SFrzsbtN4rmH/yNfNFuUbeY9nK7lx2a4VVKzCp?=
 =?us-ascii?Q?WAg91eLo75rjf8f/07T5ePxPAQQa4FmpaSqBgA2mFyJrHxKyLCIu2auCLsTN?=
 =?us-ascii?Q?u3ryPmWbbSHuU6ZKcLGKDMTIvK7L5R6os1rRIoElt9UAZ3YgqGBk6hnlI6CS?=
 =?us-ascii?Q?1qz12vKZfwfrlbCY7QDti+IUAsbff84pHNbaNwVjTKDFPDcMBU6XXoW064De?=
 =?us-ascii?Q?PIH7UsKm4QqR+Zh3sgC73UfnU0vNZnRJr43Xl4cbZQN71mnnlSJyqOjALhI9?=
 =?us-ascii?Q?gv9B0OEJrscrMsIbueGFC+r5iRp24F6OuLmB9VYj+t+9/q5t+mwU0ArpNKkG?=
 =?us-ascii?Q?XfhIwyD5pX7SvmV9TxdeAvRgCwzZi3rfNuOmZAZGjfId7ACEMUHrNROeRu45?=
 =?us-ascii?Q?9IBJh8chOnstznHeAV5upO4iwVyBjKKc33266lj+mAy/VRUkMUkuDMo0JFp1?=
 =?us-ascii?Q?GzRDrjeXZVJRnnNlm7CUWYKYeXM7aAf0d+ikAnRShS/c8kLxoNN6SzN/uPhc?=
 =?us-ascii?Q?vs6NulejrepsJuRj48ERvJiYbnz3+D0ssJqMYsBqu3w9TBuULpInAcXc2or5?=
 =?us-ascii?Q?KYL6jIdq/iJslh3YKmUdGXmyFl5hWQu1WKGBpfq5Gf1lGPHePn/miVYzvp9c?=
 =?us-ascii?Q?ttuY3OnnJ9aDJpzGHs4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982b5016-e893-4023-833f-08dbcae44920
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 05:30:03.1107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmeRIOmEwdb4b1G7KUwcG6UAeAhxoYuP8rydSkaFY7+gaAji+F9/3zmYKHmgC8i0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, October 12, 2023 12:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: Update PSP interface header

Adds FW id for P2S table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/=
amdgpu/psp_gfx_if.h
index dfd60db97012..4bb5e10217bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -296,6 +296,7 @@ enum psp_gfx_fw_type {
        GFX_FW_TYPE_VPEC_FW1                        =3D 100,  /* VPEC FW1 T=
o Save         VPE     */
        GFX_FW_TYPE_VPEC_FW2                        =3D 101,  /* VPEC FW2 T=
o Save         VPE     */
        GFX_FW_TYPE_VPE                             =3D 102,
+       GFX_FW_TYPE_P2S_TABLE                       =3D 129,
        GFX_FW_TYPE_MAX
 };

--
2.25.1

