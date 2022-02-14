Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFACC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 06:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A8E10E359;
	Mon, 14 Feb 2022 06:03:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792C510E34E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 06:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTp6SVkRh17Y0+4lKfm72vlhJIbJjzO4ydxPsLBRAYa5xKXX7/x4VGjrRy2Y3Tjz5B6Z75qzar/ECaCV2LW7n8cjbN4b/LHTWQYiey4sIvrMC9qRKC8wv1UVs9FZ5Ev3XrGu7bPg2BPD1+RF8AHThnGKPIxMPIiSV+WrBj7dgk7W5DTjAzQtT+5WfKNCMSx0LygVv6Nw1N5/i+yBhUYnwrnG2xNhCmEEKmEI+r03ArKGTd4RE4SaSFZiFrsrJkX4YIrj4wqkNDE/1V+T6VZPJVXzUDHTE+5GRaE24EYK7w/QxKuQRAU+JeAEvHs6WTCmU2+cecUsPjzl9eQzSp79WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CkYWicJCfBXioo1ZnBDSsbnZKVC6mci2LCHmWxbuds=;
 b=Xwg+LV2UWInpC9aYdQL2xRy+jSabi/UmGj2cFShIdFwRSCGYbumRKYk4TJMiFTyHKTZ0BqDBB+UXTatYD37yDNfqfFW6MvaUSqdEtaQ0RHKDBXz3PzP/TV0ZqHohEAwIfZ6yjGwPDHOzNzOXmsZ1bsJ9rBhjRBJluxlG5KLGCbO78y4Jpuz15VFj+I1YfLPdCMrhVDmOpGkcVrTfBmUlgL/MDJz2GmUyp42L2i6Uy/ZXCu0NcPn5gx5gKtreiu1p+39H/ofAXPyS2PVZRJuAloTx5376aUkS55Y8Xa52HuVbwG0RZNThvjAmIXC8CRJSj642tHbNp0lUZfwj9zmNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CkYWicJCfBXioo1ZnBDSsbnZKVC6mci2LCHmWxbuds=;
 b=oo60zV+rudS4HDa6TSl3lxGJBN7b3bwXM1JD3gkDiRNeC5AkI9sLqU6Xinkwiv472VxnMaHet4+WLR/FP5a1XA4F1/ZwRoM4Eivtrsv07O2rgyW0OSspBsZ6ig7STsjHYFNMenjchp380j9fK9NdssypERppOdnBh7ZldbenkP8=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN6PR1201MB0036.namprd12.prod.outlook.com (2603:10b6:405:4e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 06:03:04 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 06:03:04 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset msg
Thread-Topic: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset msg
Thread-Index: AQHYIVkPS5iWlAgkkUychUU+10jo5aySdrkAgAAXjoA=
Date: Mon, 14 Feb 2022 06:03:04 +0000
Message-ID: <DM5PR12MB25041A387CF97925D651E1A2EC339@DM5PR12MB2504.namprd12.prod.outlook.com>
References: <20220214041142.2556519-1-yifan1.zhang@amd.com>
 <BL1PR12MB5237138B195FAF8E0DEB35AFF0339@BL1PR12MB5237.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5237138B195FAF8E0DEB35AFF0339@BL1PR12MB5237.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-14T04:38:23Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0aac96d3-5e7f-44f0-ba73-3f1dbf70e38f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-14T06:03:01Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 95ba185e-0a28-4205-bbdc-2b441a7a9a7c
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31b19393-50f5-48d6-f534-08d9ef7faa0a
x-ms-traffictypediagnostic: BN6PR1201MB0036:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0036261ECA19A8A46F02A83DEC339@BN6PR1201MB0036.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KHmCVv8Qm8WCDcNRlOoKucv/a/BiIDCCEltUKip3u5D1RyxoyLfBtp4j4/bgIO7ta/tDGlx2AmJjtFPoSO77IKPJJ9aOvkyNbkY1mAVR9fslzd27gBEr6rpcMcUt1JWL6h5VuS3YYrQuC/OdExGDLMn+6fzo+TMfxUVzhW4pfJ1vJOUjKRYVIFrBebAZzliWeNxsSQXQ9Y5GLMFoo0b2eKXLrMQ13bRWBqgWRd+OVRUlKAaQub3t+vUmzqWkEJdofyO/6IMMX/fFJyPQi+PQuuCxmDlrPzu0Szq9S9O4/x0C85yNYX8vWxBFQPjGCjsDp3QuY04BLfXRO3XfgGvpeXVvJAQvL6B3j6vdXe54/CynbrTW5x+fs5+RD/kAKqHvDQmKiHSnjsQSwEs85fIRYZont0znOe4ZWFHO6pf+O6sR0/qswM1mALQej1yaaSV4GTw5RycPRObxKoUz9vI0RM4TfJ9xvAaTri3Avq0bgsOIdm7gAASxqwho/As5elIyEs30q4xRIIbqYvelFzksxmAJjkfGTHAeIsZDmJPVGiwstNOCt0wvoq7kgu4M4cF5p1v/kC308L2lhKZTw4rEHlfR/9pzV1xrOIXZr/fX/H/p02RvWMIbnrCwW+oIdM3T9m7iH2BSMYUhaLzW43taA8sKxWJOLjD1KS8+yu8VMSFT/o/w8dNYKBTk3514jK9RMMntjokgvMJ0VXsE3dXMxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(54906003)(86362001)(66946007)(64756008)(66476007)(316002)(7696005)(4326008)(66556008)(76116006)(110136005)(66446008)(5660300002)(38070700005)(122000001)(8936002)(52536014)(8676002)(53546011)(2906002)(38100700002)(9686003)(71200400001)(6506007)(508600001)(186003)(83380400001)(26005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QaX0ozoRgWzyljOiE3wELtluGraq+lRem7K7CBudk703DS0mDkuICUn9GCix?=
 =?us-ascii?Q?yDuS0do98stuffvV5E3+0QUJsigck8RPZ8SSU9kRHal/ZxpEnD/k6OnWx0io?=
 =?us-ascii?Q?BXlvbZN23IwYURe8U/XBptb+BXa/bXG+W/9pQa7LV7VIQAH2dp8+R6jz3QDx?=
 =?us-ascii?Q?VzkHyWGtkLUtLbGiiL/oo7RDsjhtuENKObfE5A6mvM+Qpr0ZMsGvYpCXrjpL?=
 =?us-ascii?Q?bF0jfGMnqauCXq8RRW03tSRbbBk1mfFwVCAKNbph7No9Dwnw+Hr4zHuqa3Sq?=
 =?us-ascii?Q?8Abmwib49wthQalgbIvC45sgey9KijNOfCS5UVpAOD5kgrGnAp/8cXfEiGhl?=
 =?us-ascii?Q?hoCspj5Ep5zw/+svMwhqqLDLWLHDljSrYP6u7CdZ6HK7dRgIQihdTF/xk4hY?=
 =?us-ascii?Q?Hjl5Sfy/PXhAhEVPJPz33ysknfRu2di6gR02EXaSQY8dvL8lJL5U4t1snXd5?=
 =?us-ascii?Q?V40WR3HB/snDayg8gAu1XTA2L4skcHEbt5Fcg9fpcldCZOZWLViScwT0Igvd?=
 =?us-ascii?Q?yWSnrMxtMCTzfrc7e1VMyC+l+D45eAJ3qbJFcmS/HkShgJlu4tY2XjoXsVV0?=
 =?us-ascii?Q?fCrIDPmV0MNLxbFG+utWn//adRKC9Ix8VfetY+NNoEpg1+OGgv7eht1GZHbc?=
 =?us-ascii?Q?6J5k4MH5fvlYnqTT5M9NambTu7NNN5RBDTSTTiR60w7UQa4jzdgO68okYPET?=
 =?us-ascii?Q?Mlt8a5YaHcicT/kI91LIRsjWpiIBW0AjpBMFFfYmOtRp1OsO8+MkR4sqbSif?=
 =?us-ascii?Q?ECa/UC9c/RtjIGLYjEjODoQ4cxYC6m96mX80tsZdThOEvrCZ0twt4tjPZ6wv?=
 =?us-ascii?Q?V2zjI7TQmdpXzAkPtAhxpbh+nul/cp8VKvF0/SLmyjfKVcuidaGTqMorDVqL?=
 =?us-ascii?Q?FCgUGjJqdj6a/o7O6j3FVZbg2CcBG3KFk0E/GE+v7kZuoZqKZxhZ/ZmOEAMb?=
 =?us-ascii?Q?rNOlFawjpOgVSYd7iSGySzN4b+8Q1HDWR+JSReiZK/DdeVbb9ESC9UR46Cjn?=
 =?us-ascii?Q?etRUf+K1nBxRb01SmcihRITyqTiQMoQS7sdY+JbHyR/k8QQNQRnUIXQ4Kns8?=
 =?us-ascii?Q?9yxpFeW86dVK5gaclHv2FNLBeW+vuELCIl3d6EIPcUrAOD8o7DrN1shjooTc?=
 =?us-ascii?Q?KuzKrNITsSvg7F3JEgIw6+6tuukAarjslPNfj7NxlWh0LzkBjePnA5bh4x06?=
 =?us-ascii?Q?SYSdns3O2VGMopvFCAbdoM1RM0Mnco3UBBfYANHBPzgRUivModtzJOweyA/0?=
 =?us-ascii?Q?7lTZJS0U654jul1kvCiZhuMlrTOdy0AXkWzHhKLJ3Ht7nGCyX1DX+7JgyBFY?=
 =?us-ascii?Q?cUbVR3tU+AY09B6J19A/o6IVLgTH4wPv/8Eeo+7ZG/pyveN9HyZsKjaE3Y0L?=
 =?us-ascii?Q?/gNo2rYbFxP8D9sRDipQzezfyMOq92ZGjWT5oCYffJvpcp9V/lWYb+8jisc0?=
 =?us-ascii?Q?CsliaGQGbNZfiG4rTO1OxX3mnBHkM8Bupn4VKtOoKIGe+ketyDK9+fC0bnpq?=
 =?us-ascii?Q?aJKC+FIcivgBTRTe57zS191fwq8B7Bk8V4GS77QDh31MCBCmcoAEaH8J65gg?=
 =?us-ascii?Q?5XurD1DErOW8oXGUu+BelIwnuZKDOseC0Wc7Sy0EXSkKHFHbqyszMRR1k/Jw?=
 =?us-ascii?Q?JreLolAmE8z3sM58sJ24gCM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b19393-50f5-48d6-f534-08d9ef7faa0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 06:03:04.0959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LogKgJFz31ZdyrhmDQOIE2GRlyY/f4OSM0u/YlGFWd9jzrWWREFvP0pc2mGtOiOuAHJO/Rlq17LOmpr4qM/20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0036
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
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Aar=
on
Sent: Monday, February 14, 2022 12:38 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset =
msg

[AMD Official Use Only]

Yifan,
Please remove Change-Id.
With this fixed, Acked-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Yifan Zhang
> Sent: Monday, February 14, 2022 12:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan=20
> <Yifan1.Zhang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset=20
> msg
>=20
> the 2nd parameter should be smu msg type rather than asic msg index.
>=20
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Change-Id: I0a65fac53b06c053ce193580d68cf586e77d2c2d
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index e90387a84cbb..e2d099409123 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -262,14 +262,9 @@ static int yellow_carp_post_smu_init(struct=20
> smu_context *smu)
>=20
>  static int yellow_carp_mode_reset(struct smu_context *smu, int type)  {
> -	int ret =3D 0, index =3D 0;
> -
> -	index =3D smu_cmn_to_asic_specific_index(smu,
> CMN2ASIC_MAPPING_MSG,
> -				SMU_MSG_GfxDeviceDriverReset);
> -	if (index < 0)
> -		return index =3D=3D -EACCES ? 0 : index;
> +	int ret =3D 0;
>=20
> -	ret =3D smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index,
> type, NULL);
> +	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +SMU_MSG_GfxDeviceDriverReset, type, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "Failed to mode reset!\n");
>=20
> --
> 2.25.1
