Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB6BC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 03:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D5C60EFF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 03:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5D5C60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FF16E11C;
	Tue,  3 Aug 2021 03:17:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB58D6E11C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 03:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A50NafYkQjkPZQ55wuLZkEFWN/Mxvc4vCOXjJpS+4gnF1s1w9+niZQ4wHv3mcHnSsV8N4FkJhPiDwbAHjg4qQrWwX+xF3Knt+7y3oBvoj2lwCXeG8KS9JSZjCBPAX9UnWIVmF2hq1+iNDEHwEKVr/QjoUEg6/PUWcaLi65dWsaRRpsN7Nc9dpEhQB9DUVgZrRox1FkzpBBTbf+BN3OQ9n/iWtoW8MwWZxnVDlWq9qwPDarOxX6yhpwAW5+djvG0TzDz+s8j76IUK7gj0P8wpipO3yS1jxg5qjQ5s5M8d6TfpD4LoK7IothlGuHvqQRLz+roRs11ROHfu5Uzb0AhPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+htU6x0rhUwqkR4xDwrr4wTXryrWqDvAKkHoHxMd10=;
 b=ApgXdEh3RG+hw3DiAh+ksg/fMkx8rMhv9jIiuDzb3zkf/yko3W2Wx8tVrn1AZ1EruRditUlyb/zky0YNR4M2W0cPqAPm1EoVYbn/2eX5mSxpTBVtVLC2NvuTay2vOqQVQEj7e+zYqRybJnp+0b6NehvwnKpjdekPqecbpqqGM5BYyCl1Lu1uBIJiX2etwrcldatkByM9o2HUTO41EZ3pmh2KvJAneTEIRl9kXVqsAq3spXI5vlyrjTf7ZqICOqacxpWyXMDFwA6Ln9rkK0aEqrTQKvJOqSBjP56ElTKFne/gIahTpfq72WZ/M/RYoS5NtEs3+fa6+mNyAxAjJMF85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+htU6x0rhUwqkR4xDwrr4wTXryrWqDvAKkHoHxMd10=;
 b=3N9X/yuo4oKIp2clU7n+K4h6h0+sPA9U6210ekbR2NVKR4bUSxnQIJZE55Xx1OLnTt0ZhiySdd0KUFIcHQhzBrdOCs+lVgl68aUFiPAB3rD3hbUNKUlaRccCZLvpD+hBvNgMthNx4kF5kgmHAwLO/fC/BSoAN/G1XzOyrpe2jWE=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 03:17:55 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::3495:174c:48e3:4012]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::3495:174c:48e3:4012%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 03:17:55 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update smu v13.0.1 firmware header
Thread-Topic: [PATCH] drm/amd/pm: update smu v13.0.1 firmware header
Thread-Index: AQHXiBX6BAT9u0VFR0S4q43gsjYZw6thHAhQ
Date: Tue, 3 Aug 2021 03:17:54 +0000
Message-ID: <BL1PR12MB5237B0C050EC42E0F7C5CBFCF0F09@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20210803031559.18025-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210803031559.18025-1-Xiaomeng.Hou@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-03T03:17:52Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8ab08975-d5e5-4bfa-8fbb-e2146cb6c6b2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f07b08f-cb04-444b-6b8f-08d9562d4932
x-ms-traffictypediagnostic: BL1PR12MB5157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5157B2DF864A9F930AC584EFF0F09@BL1PR12MB5157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUvZfYQtRIRsMXxb+s1n3GGc+fmeUFFEdPQFSfgCAk0qBaWtp2Qc7AROTLHncWNeR30ryh6CLO+upHKfk9JsfUCDKndhm0sDS9HJGzF/zQNcye+SfSixAvecD2CYBBv7VSxoVjMIrjajg2TNP1R5Z0Q4dDHcIw4TiEl9TQSgn3MN2p80lPwT4cKNWTicjkHBdKDYJgYWlCgiRQeb4gi4ivcWyTsznNOGoowPUgn5cCKbgDSkOlpCQuKR4fQCqRdrFLQCf6xu0EQdpPaReDhoi+DkKmhEyZ0DSuSLaNrljrifTBrpq3GHFKkDywLFBO+5v+demAyJJN5h3aK9X65/aOFbiDCF3m5DrZvUGTy/i1GPJbe52EerEKhUM7qCRgaFhc9Oz5LRoNRWmeUAK+l2jQ8xsEhEGLbUK5X+MFelLL6+L90X9FupGIwZu24FjQNrRti6ocGBnkJ7bWm12uD1dzV1VdAIk3M79zraOw56S2cup11KEbq29YFe/I0zUfSJ8IiU6NDvGO/6u125IrEat0NTpnjydAQr1ubBebB1y54O11ERnBadzd07XJPGg8cNcB3JVswzsokkVt/ib1y4aYi1z+uStCpegRNCIXdUpZiH6hFMFAZEZVoYTCjMRwrALMckkOIHRmzl1WVsXv3IIE1IThRfWNFVYgWlR0KdqMYKaRcdgXqF7fgEkRxXsXi6e60sWM9eVdXcX0BWAPlr+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(7696005)(2906002)(38100700002)(5660300002)(186003)(122000001)(26005)(76116006)(6506007)(83380400001)(53546011)(66946007)(64756008)(66476007)(66446008)(66556008)(38070700005)(8676002)(71200400001)(19627235002)(52536014)(478600001)(55016002)(9686003)(86362001)(316002)(110136005)(33656002)(4326008)(15650500001)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eVo0MaOuju3SnHbKjzYOZIt5s3oFCOJ+4Ac/dXl/fFogKUZwZq92SFnuJ5Gw?=
 =?us-ascii?Q?fCZEJnfd+mGniwDF8DOlcP/up58i9BjLJzwhoAlO8HeiCvIj3GABuWaBil1t?=
 =?us-ascii?Q?67e0HDg083dXZAcwlycd2HUa8JRRoB+IgX8JCG+lhPY+2Fa6iDh/Grw8t0e1?=
 =?us-ascii?Q?xy4DjMEzz8UsCASU1wOCP7P657YHgs868BNMmysiNZu2g/p/Q3dNB/iSKF4c?=
 =?us-ascii?Q?7+EEXZ9cOexrVsDHVhxps92w4I1qrfw5OgsRNWLMMQAtx3W/W6etgaxBY/yu?=
 =?us-ascii?Q?z8KMhAndxVXhnWT4Hh9xKcqjkyoRgq1jaL+wDjLAm42nVYDCVj1E0gZsZkgf?=
 =?us-ascii?Q?UmqlWTNqYDkNJPNjWdeK4XAMJOKo2ai2dce9tuFdd8IOl/rb0v3hsz0OtWGc?=
 =?us-ascii?Q?S05tLsBEhINhUPF5vvXdpjNLMgrU8qfLKXMLNOpMgpQlF6zOpXgTgVPZE7jb?=
 =?us-ascii?Q?FrXOJ/fHTvULS15XMHTHGUHdye62ajycmzqosYjgKJ8Fnhi2irR8OwTzjwKN?=
 =?us-ascii?Q?eMMySYWsS3KGHUzj4/08AnaiWhL4PXDD7QxG/QDf2vT9HZNabbTBnGwZ21Ej?=
 =?us-ascii?Q?FDQO5/9BrYKtuZZoPQX1GYIJGkb4NEH3kmsHzk3vs9CHXC/V9ROqb1plgB9f?=
 =?us-ascii?Q?kMOdHQWKSNq3cWUHJXQk4OdwXZivyRMFsHTFkJKjujtirsp8MnYDGJKcwKOi?=
 =?us-ascii?Q?1IEHtSUPg2xpUYBvURtJIqg3BSscZA69taoG6X0XWNctuPXc3FylvfA7Zk/y?=
 =?us-ascii?Q?M851rkPSwylU0ce9gZAVHLvv2UxYNhadB1UhqvKHX8R7N9nybr13bFaD+juG?=
 =?us-ascii?Q?sjMJpWEadQDP4zdV4p0iyqnl2sK66NQdi8Utg74AQ8pxr9ZPCw9CMy4uyrMz?=
 =?us-ascii?Q?QKuFDKpbUqeTcTWSeUXzdzN75FD8pWDEMGQwkzyQYrtBJqId8iBX3XZz6PVL?=
 =?us-ascii?Q?Ap7RcGPPXRn6gkSwbv5jKomVat2BklE0636Id9wVFauS8SJfCdmU0ZIzVICg?=
 =?us-ascii?Q?8KRD9RLPF8Ulj2TBTBy6CxXNjWPGhjOavxZRjweCmUFbSOCPFogXM2loUgOq?=
 =?us-ascii?Q?5dKg5FtQCeC+bPqEvdqVOtDPAkdoslHIPosXVviPNaKqx+6skhWvqO+6tWEr?=
 =?us-ascii?Q?QD/5C6JuKFrFOst/6D9wuaBqSS7ZA1xFqGa1I0eZm5Z6cOiXAY8gvnD8dRfF?=
 =?us-ascii?Q?Umh45lKqZ85t+cczIKxrXpfwzFblVipkEUCfh+oEEFJIT3KZDFZNU8ueGIp+?=
 =?us-ascii?Q?AcOZTTqEJqOcot2Mvz74eR/Dfgyht0TFaMn3TjdbljcyON7I4RqupwjZyMGb?=
 =?us-ascii?Q?5mJ8vBf0SEn28VD7qSIG4Xh4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f07b08f-cb04-444b-6b8f-08d9562d4932
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 03:17:55.0088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qn7FyANAoUReQbEUlmXzXR0IyxnojY1QX1/d+6LOLhtgY09u19NCi78MwPz1jX9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
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

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
> Sent: Tuesday, August 3, 2021 11:16 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Hou,
> Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
> Subject: [PATCH] drm/amd/pm: update smu v13.0.1 firmware header
>=20
> Update smu v13.0.1 firmware header for yellow carp.
>=20
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
> index 5627de734246..c5e26d619bf0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
> @@ -111,7 +111,9 @@ typedef struct {
>    uint32_t InWhisperMode        : 1;
>    uint32_t spare0               : 1;
>    uint32_t ZstateStatus         : 4;
> -  uint32_t spare1               :12;
> +  uint32_t spare1               : 4;
> +  uint32_t DstateFun            : 4;
> +  uint32_t DstateDev            : 4;
>    // MP1_EXT_SCRATCH2
>    uint32_t P2JobHandler         :24;
>    uint32_t RsmuPmiP2FinishedCnt : 8;
> --
> 2.17.1
