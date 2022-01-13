Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB964C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 10:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C9010E518;
	Thu, 13 Jan 2022 10:49:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5277810E518
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 10:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUiIYOdSQU8vTxS2k7TJUYx/28LWpR9QXdwB/Yl8XUGg3h2XePtUHUttqYBjNkavrAXXXbBYph8o+w1BZ1sXK+3f6tvHRPptOtpjoHexKlA5bUoQT9+Hs7X5pJQCjINKcVH2tQn7Ioee35r0PadzZZU9E8kSxvhCjPpPeZdQ8LQM+sFPnWVea7j3LM/UjoUQ1up2CIYSO7rFwqTaqd6zQKmh8UtrZkzfYD44iRoIoe2vc3NStcHsV4qJMLEAcvLsmfxUH31xfHi1vMmBOEnrcYg3mnAs67RnoWXpDZ65Joj6VK3eJHtNycFLlg/T/b7zWl3ZK7jKcUiI6TXx6rc1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JabdPjJBhhQlxtHX8YeQbL4Aqud5z+p7uizpnnOlAuU=;
 b=nGBLpCmP9qPfFHR4xf3OYBRXnmjHEFzKex41FLc5WnUdZH8W1jjCOrEeiXeCN0UsWpFP6+UUjEsNswE2ME/qBXaP1+FOeS9S3yY9dytghZIXDVC+94M0+QI9mL9g8uOWu6oQKheWRPtdSb+CILzZB+1rstrw6mtRpKULyuFlJ4tqOw7np91SRhxSUciPyzU1VsjP1bjoSULZihFIwF9jW64GCIzi2Gu2l8RDd3M2VTPsaWFMVjPJua2fo3+2uLKYx40PgBB0/x60hAk3dNkR515H5PXHZiJQqkqizBge4Eru2wXYxOtUfVNIZE5a0bXV4IwY6caV3cjMUHCTJx/iKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JabdPjJBhhQlxtHX8YeQbL4Aqud5z+p7uizpnnOlAuU=;
 b=RD4l4NPRHeO4vMx+JxgsfR8vjCCkIlvnJWHflYgB6Q31qBk1GxjFxaQx/dUvGqBxJgO8qZtknMkzW8JiNWBVB17SSn77gh8r8Vw/Nvpp+TXq2mj+hJocr3N7yF/PTCVsagh2o28aympNT0iI9XUS85ySf3IMU9whM93I9dliU2w=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4826.namprd12.prod.outlook.com (2603:10b6:5:1fd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 10:49:15 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4888.011; Thu, 13 Jan
 2022 10:49:14 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 2/2] drm/amdgpu: To eliminate the warning of no
 previous prototype for 'amdgpu_ras_block_match_default'
Thread-Topic: [PATCH V2 2/2] drm/amdgpu: To eliminate the warning of no
 previous prototype for 'amdgpu_ras_block_match_default'
Thread-Index: AQHYCGjP3TNs+ypi60e9i9FGOQih96xgxNnw
Date: Thu, 13 Jan 2022 10:49:14 +0000
Message-ID: <DM5PR12MB1770A41823BFDD193257B2DAB0539@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220113103132.3910820-1-YiPeng.Chai@amd.com>
 <20220113103132.3910820-2-YiPeng.Chai@amd.com>
In-Reply-To: <20220113103132.3910820-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-13T10:49:12Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=90f49077-4f0f-4ecb-bf2e-52e474757c98;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-13T10:49:12Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 2a830422-135d-4069-9524-283fe1053d98
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33cf2297-7fa9-46b9-4b80-08d9d6825749
x-ms-traffictypediagnostic: DM6PR12MB4826:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4826EDB7AED6C22C6E529D47B0539@DM6PR12MB4826.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:147;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQNzULWOWyRAKO3jOWOSNHgqFggvIdJWv9vEFX2nwZWLETNjEcMSHHO5lM02Ii3tXkwyYXLeem3fzZohvSXf5C3LQyX1KweaCrgv4sHUNzwpDxYOqCzK6cq+yeJ/K65fciIw87u6dX2vy5CGFypPNy3n6fXxLXZqODc+9RsrXY0WoGm4MC2XZIGPkAwPJnspJzpp6lWKBFHo1gdao467PaJeZ2U88roholK/PNhL/B/yCWzCQywTboo/rz9/6iPmH0eWSPogDqzTCNRt5f/pMF6+b3V/DsYhrH0nsSihM6pFCP0x9Hw6jBBwlR7hcZp+SMaL8fBJtCaRtN5mYjlS9oR7+7d3tq7eY+BMGcpL5L3EPPLlZ78Vct4JOUiCNJE8jyUgDNdbVyZcN37WL7uXongHLASuHI+lECyYY7VWz67ZqWvkhiyzCzD0Bzp2eaVYVCYWbPqkAZLIACNZ0kZqBHGfNGAP8EDEZIm7y1r0KpON1bZ0vgrOkcI68k4UrNCKasTdN0PmYCVBkrYTuwprhy4/ObFuXEH4OyPHVzI1ef4DR75N1VlnTfNxkOB/TEDmsWMElIiiSXB67jrCRwBOF1tynRw04FbKPM5vCUFV43K/8vKu1XpjNMWklxWxe6Bog5MaNOOh04W3+Fwny9w8L1Li6QiFBxYbeTgPtEFF9wFc5VBG2MFF/d/W+k+ZBFHrtEVrmqd770Be+DJmtKxBJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(8676002)(6506007)(38070700005)(8936002)(110136005)(53546011)(71200400001)(54906003)(316002)(508600001)(76116006)(186003)(33656002)(9686003)(122000001)(66946007)(26005)(64756008)(66446008)(38100700002)(66556008)(66476007)(2906002)(7696005)(55016003)(4326008)(5660300002)(86362001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cCd0jVsTykZkYhbO0IckhtQnhklFNG4ZAmnAE2ONG+9OfWbypNByany555As?=
 =?us-ascii?Q?COhe7gDoSLNhohPAsSFZIWYWY6fmNSMlzju8dHXf9lG4aqBQLNMH796uh41b?=
 =?us-ascii?Q?CFZpFNMMnFjFP90EW8aujiA0zN4NQhwZ0ePDtQ55sSD5hBDKGbTfPNM0rAYQ?=
 =?us-ascii?Q?3BK6HHKhbathoRlvhZnXGI6Uk31cHj5J6BdAWz2zseAYzkpivm5b0p6G4azy?=
 =?us-ascii?Q?0VR71whEagdofhDJfCG8WveIMsuF1uOSXmgTjutNakPWR7jI3O0lRKdWwOvf?=
 =?us-ascii?Q?npB0eU8dTUWJUUY1ksxU2oABnjaUmRVjn0kjKauvkep+AtTWwwztHsug5nEJ?=
 =?us-ascii?Q?v/k16WSNkDbDzFxp5hYozvCkRJIZrqzywJprKGf6Btxc6XVIrNL4cwYGZnia?=
 =?us-ascii?Q?ElV0/8kN+l898bC+bZgGgxTQqqEUOdQuFEfUakx4U3K3qd7gSG0oy3xoPpS7?=
 =?us-ascii?Q?/2hqWtT4jdYq8A55GjoGFgf1kk8q5f1wpu5lT3J4vU2Avz0ZD862ypKBcpHd?=
 =?us-ascii?Q?aZUE2kIWVjGgLlEdPY6bzKDGGtNMEz/al0BD/08AW5Hi4e/S9giq3clbA8WR?=
 =?us-ascii?Q?WbvXprrvo9BelixmPrGfzRngY0cT4lX5ibUwxW04o/dT03poK2muyXaLukj1?=
 =?us-ascii?Q?q7gMRgHf3EGblYFlASPoK6pLMclFFicdMWYGhWsa3GV4GVs3LHYpKbGAV5Vn?=
 =?us-ascii?Q?hjsnykmWHiqUSGjopueMYGtNUtf2SqfHb8sL0emxwh5oXyqZraHpnyDQLGMr?=
 =?us-ascii?Q?UhVn0G/T59doR2jELF1gMnjZ8vtJ9sL+YnGCzIXah0g19xu16RdUVKF4i5B3?=
 =?us-ascii?Q?bjSA+J22PFyFNNY41QfpRDxiXGyrjNEYYBJYb91OwaH8shEZzwQeDYY+ScN/?=
 =?us-ascii?Q?i6v6DfAMZegqLJ5Y8rWtQXI+N2hm7cUKtUD61k4COZ6xoy44/38me2nmsOA1?=
 =?us-ascii?Q?KSeY89OCLNzewsuyssLHyx6LBki9XShYufzGDc5cm1iF3gjwuJ3P9rR8we45?=
 =?us-ascii?Q?gwZbOipk9q8gWjrrgbGmSOCbL5oLth2k4HDGF09gN1iMR4IJ2MHG5RIYOVKF?=
 =?us-ascii?Q?Eg11jLtUcNfcfF4jIpMpecni4F45OypXJuEnWDJZVvW2AZTVB+rWRdndWJtm?=
 =?us-ascii?Q?Y0JAisr+K3nNxtFnJAGn2CKTUu1AtEXiQwd0d30+/Dd+l9zGXU6viiMPLUAG?=
 =?us-ascii?Q?0YQmXpF2oVrEZ2+bbSoahBReo1BewuZbVoIeSD60IjYEtI7ELtVZ/WjDxdW6?=
 =?us-ascii?Q?berT3G9BSJQ3E6AkMpZSPvlaFXxvJ7SLps01Piu4kjd2TdRnB+G6s3O8VS4U?=
 =?us-ascii?Q?AvSXdF72ngRu0iwyuaPrVIVqvFXTorcdGzPnUR3pLRhh0FR+8ssdvbunxNae?=
 =?us-ascii?Q?UKgT0J1Y7klkp4ViLLXQvWeoWFgd8niWMX7bYi6uKfmwQJ/gzZP63m5b8Gmb?=
 =?us-ascii?Q?6GiVhz0olCxpjrUA0xxZ9PnTALA0hvGPgQt99fbpTSaVc2DzRs93TL16/8J2?=
 =?us-ascii?Q?SWK0Ts6LprFrfUS61/EZ/vi6Vwepe2GkbKeAKXjiq5VL0ROUistfISe5siMI?=
 =?us-ascii?Q?bCIcuv8GFtQpZYk6OWs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cf2297-7fa9-46b9-4b80-08d9d6825749
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 10:49:14.7680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFMEE4SjGSTHtGRdP6lG7ua7QxbRVODZDGTI8h3UvwuuhiZCIqWyR+NUxDXr1QxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4826
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

The subject can be simplified as "fix compile warning for ras_block_match_d=
efault", with that fixed the series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, January 13, 2022 6:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 2/2] drm/amdgpu: To eliminate the warning of no previo=
us
> prototype for 'amdgpu_ras_block_match_default'
>=20
> To eliminate the warning of no previous prototype for
> 'amdgpu_ras_block_match_default'.
>=20
> Fix compile warnings.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 394a18e3c6af..7afeec4255bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -869,7 +869,8 @@ static int amdgpu_ras_enable_all_features(struct
> amdgpu_device *adev,  }
>  /* feature ctl end */
>=20
> -int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object*
> block_obj, enum amdgpu_ras_block block)
> +static int amdgpu_ras_block_match_default(struct amdgpu_ras_block_object
> *block_obj,
> +		enum amdgpu_ras_block block)
>  {
>  	if(!block_obj)
>  		return -EINVAL;
> --
> 2.25.1
