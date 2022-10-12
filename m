Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F015C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 02:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 602F010E18F;
	Wed, 12 Oct 2022 02:15:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1130510E18F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 02:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCXprVrfUKKwjogbnXSh3Y6+/eOmcBS8duQmMIqfsL6gCDbo9i+oumGSjFdjH3END3eODt0b19KwKBVpOUX22op5jyKvveiVR1bxcclEs7ze9F9S9i6eOEv4M63/s6CO9usqH5c0qxXlGQCWRS4T985w+HWZ4umxc2Unmh5BopfMMtItaHbaQ4nC5TNO5wkbDMS57O70Co7T+MBKEqZ2t1R+QDZcwrwOLe9sABZLqLO+XuKbYjBNl1JxlvyafQvUAzZppXhJ9/5mwf/rUTn2TF/ocp7UUxj9RRVruPcXrQ6ZAxfHogwv8AderzANDiAvwQEPf9vOILI3L1eXgv0c8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf61zxm4VpmK8WwgbPrHbsMPhZDF7hLxEAH4h5YuCzY=;
 b=dms8xyNlMl9SscJ+g8bfyH9kaaKk0DlSwEVHSzXDbZ5V1XLqJjygQtxgOjYIIEk8MwnuwuLn8GHyCzaK3PWveLY5Fv0Fi4PsgoEDHeB5Q+djOfGVcLNfuZlLOi8Xx4NzNlS5tLizdyu9KyLX1fEerMjtv+gcieU8RhAZKGuRf5K7tcuP0ltho1D8gtnPTlhyRG3DIgqst4H3A98jAQd6KhiHwzgg3fdizUXV4wlZ2H4YtsZfDs3qNIM/dbsdrjj3kosnDNO9TjfMrWKSAq30wn+WMIYRbjZibU1rdsRQ4DlblQVaCOKMVC6UXiclYXnX9T8ZoQWK9WkIkRZ2NujGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf61zxm4VpmK8WwgbPrHbsMPhZDF7hLxEAH4h5YuCzY=;
 b=e3Ozll5qyO8R1nid44VKGxv8eGcGA+S+k8enjjR4pWDzp0gHoVdf8vey+sF0Duf47uogSh+YVjAUsXOecVDJk23eopYZek1O8od1VwCS7FKn8+KNWWQElCS3yMMECn60GKzq1ly1gnJKdJ31ggSyBG2oEK6gA1EtPO64KxHubwU=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Wed, 12 Oct
 2022 02:15:24 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::6f68:c993:86e2:d50d]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::6f68:c993:86e2:d50d%4]) with mapi id 15.20.5709.019; Wed, 12 Oct 2022
 02:15:24 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: add tmz support for GC 11.0.1
Thread-Topic: [PATCH 1/2] drm/amdgpu: add tmz support for GC 11.0.1
Thread-Index: AQHY26oE/i9XBjU2i0yI1kALEl13Hq4KCYYA
Date: Wed, 12 Oct 2022 02:15:24 +0000
Message-ID: <BY5PR12MB3873A9F645DABEBD10D3C4B7F6229@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20221009063952.3156418-1-yifan1.zhang@amd.com>
In-Reply-To: <20221009063952.3156418-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=62c8df25-9585-4cd1-a935-152a66b8e1e6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-12T02:14:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|DM6PR12MB4516:EE_
x-ms-office365-filtering-correlation-id: ea9f5f33-cc41-4338-bde4-08daabf79f7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4R1vzuSQa++7mJVcjUuL58Pf/v1TESxjIN4tyoSuvRg4BGVQcAJKi7IbiSNbmxFgnEl51qafsSPp2K0LDjHQqynbaLsUKUHIasd8jw3EFiN8S3EqtYZTZRyyUSt4c1N0WPPpCxhaLK6SErRvFli3W+pmntJl+P/tX9euWJnRGD1lEgOlbheM71ot4nbN0J+Pdq1SH+ffAitm82T1qNXuDhd8KAGAia8c2y/28h7/oKdSuXdCDgcIl4b4fPuZtbr9T8YS/aKA0u6d9gceevtN9NZwE2SNmcLCQWRTWHFLjubs+vafA7MS5vN+n6mR3/RPG6ZdjXiBiTXG/PNbwhC1vkSLcKgOM83WLMiMDCMuXxTdTf97UrXmYW7vIouW8eTfPPT7N0/fTmXlNzzTKlgrRpl8Jj8PD8hByp5ffkWK7wZDvNVj2I8vgXNucADRbiTXOT03eaovrNPqHm4EAmhWf9RQWNjLwtN5htD0ZsK9GyVpt/8FWWxiG7K4PySsm38yXx6s3sCHGGrYcj7HdqmP4wINHLmT8PFMkDfk4CJwEYsk9QGV8yL3jKnzPAH2+dsi4zKQqAL8s8yvZCtTj7I01MdDPZzQqHJaASxwO9m7y/wTWheJ04rG80mCdfMIjryiVTIww6TEcWER2NVJiATUzbEju8Lzf0hkaRpgaKHKGBhamLtdZtRNlPCWniKcE0QahNohgPBzE/GMY2toQuHE8G6qxCxImZQDMXHbEjLpLwYwqFhxXn+Xy9JFWjtzHiOxQb6t8ZCRRNVVUBJvCh/vzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(186003)(478600001)(26005)(9686003)(6506007)(7696005)(53546011)(38070700005)(33656002)(122000001)(38100700002)(55016003)(83380400001)(66556008)(2906002)(41300700001)(66476007)(66446008)(64756008)(86362001)(8676002)(66946007)(4326008)(76116006)(4744005)(5660300002)(8936002)(52536014)(110136005)(54906003)(316002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W0qiNtUi9XfotaNLbV+uaYfzQJ1Alb8e6JT7vjQk6lKLM+PBLxnjeeAk3yE/?=
 =?us-ascii?Q?ZnNFNmbv/R6EiCpT6uh995q0hcT7taWbfnEH0+GKUaAXGL4xeN7dzqFmstEb?=
 =?us-ascii?Q?QuV0ghGGjCYgaOZ1UA/Wy7eN4f/ydZQBII+aBIMCWGhXq2nCTiUcga8yNvDH?=
 =?us-ascii?Q?RXkgd9M76HUAV2n1lbVlsa6DWLKKqfkZBEvSSYYqHR+kDzB+7IV/0PteKnY6?=
 =?us-ascii?Q?2ttpI//3hNfuKVFzfeNL5E39096V7c64VNjvTmCq8myFDEJMWhXAqURW14Ty?=
 =?us-ascii?Q?81FegED4VqR5nngJhjAEzPbmG8ZfHY1diLdiHiry46OIUl0fItgM4WwiJ7J9?=
 =?us-ascii?Q?rYidJy3vvKcFlOctLSNaYjEtO8TDoSfNrM8kn/QWJqYnyYdnHxAFTzPw2O2Q?=
 =?us-ascii?Q?yn6G9dnFQ4+y7OX40ebekLbCJFYe7mpordpM3lKZSAP8mQ1ZcfSlXTJFUpEp?=
 =?us-ascii?Q?Nb831x9P7HcAiNKhIxrTQR03rRYkliJhKoJES3FBv3Jt9uqxosNJP/5TUbf/?=
 =?us-ascii?Q?dk9HpEX2hJ+beJmLUvlQjEfix7weVFgRrwEWPEjSEHFA55vvDNm2CO6ZiNhV?=
 =?us-ascii?Q?KGkmiEAqmDe+psVl2xfwrzkF4ZT7OJwMZSF4QOFr284zHo9qpNztF2HyLJHk?=
 =?us-ascii?Q?49CoCUPYW+/VwUURa3JM0Sp0DU9vG1D63FSa7EhoFHTBBUOBpNB5cXAQ1j3z?=
 =?us-ascii?Q?xkrZQJRpEPFeHcYULEguc8ujf+wGcpjHpLDJu8KEDK6/Bue4fQRdl82y6qPk?=
 =?us-ascii?Q?hbMLOO7H2a/4GSI88IHYYcwzVBlzdVOvQpTIbc1q0LDf4mT8rq5u3mzZynrc?=
 =?us-ascii?Q?UEZt4hDnCIns7/Fbm6ToYxyikY38ki5rKX0Emn1srLZHHJQunKHuOMwFhcwZ?=
 =?us-ascii?Q?JLAsly4HXdyC7z1RQsnZU4+xAY4H2pSD45jXDVEg1bFnEbRINt1GM1E248hN?=
 =?us-ascii?Q?LFCC81sHgtqd+jZy1TW+BG2KgJ1HltTeInzzbXZ8GHOP7+r4/pb+e6N30DsQ?=
 =?us-ascii?Q?yssF7UIOsv9UvITopz0+qRDDzJvbVFFb7iQPWDZaohHnTNGPP1ZCTzzZLbFx?=
 =?us-ascii?Q?wPom/oFCiNFbbaet9YkcZiHacaYd8Tf3oypWR/wukZ2AlwgFAF0GCnRtFdUx?=
 =?us-ascii?Q?lFInwKeE8TkGlOd2uceWXc1XABlw0LA41WYXMDxNa+JsuDUoDMm0RN5pAMWz?=
 =?us-ascii?Q?IdsOz5llR5M5JWhZxHW8LaqvlGgbmZtgKBPPVCJawdt9uL1toB3l4UB+cbKh?=
 =?us-ascii?Q?CmLNjp07B3k8wB2CIyn8rViWXS4dhlelLHze8Qy/e17xVgJbosruP7YDKSOc?=
 =?us-ascii?Q?4FTVeIjUKQs+0WHH6zhdc13IxlcCs4GJBq+KrT+TXge8OEzK4off+lm3oqU/?=
 =?us-ascii?Q?bzXZ9LotPJme7GeXW/HtjrPCLYcTgB8RWFziJZ9Tu5rMrh1sjbkgAB0pzB+I?=
 =?us-ascii?Q?rxJkepeAzzm26bV1pOzyVIFitSgO74nIpGIaps/Ce9Zt8tv0aPd7L5q0ImB9?=
 =?us-ascii?Q?u1KmNz5h/avPx0QIp+1mxg6xOT1TKjYGVT6bc7LBowr+2xAG9JYU07SDd6D5?=
 =?us-ascii?Q?sRcwS3OQysUyJ7vQo2EMvzjO6/kvoDEGVSwTkDHb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9f5f33-cc41-4338-bde4-08daabf79f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 02:15:24.6836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiMdBm422J0prWUBK5q6b5cQq4VVTK/ZUxYBwr6o3+RjyqbF7EUt0PkMnQpe5DANULvTBiFohoZU2cJmiBxsvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
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
 Yifan" <Yifan1.Zhang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Sunday, October 9, 2022 2:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd=
.com>
Subject: [PATCH 1/2] drm/amdgpu: add tmz support for GC 11.0.1

this patch to add tmz support for GC 11.0.1.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 34233a74248c..9c0d9baab4e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -542,6 +542,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
        case IP_VERSION(10, 3, 1):
        /* YELLOW_CARP*/
        case IP_VERSION(10, 3, 3):
+       case IP_VERSION(11, 0, 1):
                /* Don't enable it by default yet.
                 */
                if (amdgpu_tmz < 1) {
--
2.37.3

