Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C86EE14C3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 01:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B657E10E749;
	Thu,  7 Sep 2023 01:40:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C781C10E749
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 01:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhJc9KX0BObMtD+PBh16w7MWkQtralOg9g1QGmJmRNZ2QC5TOlONmDyuIKkIiS+VgEJR/Rf23lnPigI3Ohw5SVViOiXLfU+I7Qo7z8Ou2+vR7SbnUCgrI7m59vyUVCYlpe0v1lXjWa9oFhRK3XewBFH+WMbRFWB1kE6LNTn4sCXqZliBFwithi3o+PY6lfxZwLlVu29yiug6xI81iXYcMH+Afwxta9hlndGTkbPxuc2kptiWmL418aMyW7kPrzSK+Wt9+8PaBcJbhJ9V6Jq7ZRZMZc+6q2rcptDnFvevO387PSbQA+6xJIy8WAtaBWD8inCCMjlOHI6aNMdjGGD3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPrjMT0O1Lj1hkDQ4ELRTxR5jie95DsJlqaT/ngEnoI=;
 b=FfMV7awyi9an1CE3tponIjMBJJ6dmOSlTf7mSP2F4l/8dnslj9Yu5nWq1ngREmz936vQzHVoLnulWKj+zZMur2t44WQBwdCj4/fU001kyeJAwjcZaWZLnkzhb/tpJVyk6HX6OHT84LCFK2ezq7tDpDJc/yC700SnJJQ96fOa/eEfUIOQhNlIhnLWctqIBAZc0Xo790qY6rjLHUoWEEjpN3qxNKsLunc9nKuH6FK0xEGMZOwdOdZASe3Y64dZxrKxLOfON+f5Q/DpcI2P20Ki0ySLLwRN4GADQJjx9d6o/XePwBS5Mjwxn6kv2D5hRsO82qNtpWO5G1VPV3iJjQRw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPrjMT0O1Lj1hkDQ4ELRTxR5jie95DsJlqaT/ngEnoI=;
 b=2nNQW9U3BxDftyb0o4NQMBBLKsnRgTkBSA7IUfUE+7B1EF72wGveg+DEswtXk6LRMN2wiJYfik9cBF6gDO11wkUnQrMuid3KFstu4Lqclaa+CFZZGuZslVSdVi+qb9oTRoP6H1PQ+//D/2fAV31PR7d/FngayuUsiNxnsvWqejQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY8PR12MB7314.namprd12.prod.outlook.com (2603:10b6:930:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.35; Thu, 7 Sep 2023 01:40:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::56a5:d451:bf62:2b06%7]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 01:40:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix retry loop test
Thread-Topic: [PATCH] drm/amdgpu: fix retry loop test
Thread-Index: AQHZ4LCLJvKFAHXnEUqO/FgoxjO1P7AOlqbA
Date: Thu, 7 Sep 2023 01:40:42 +0000
Message-ID: <DM6PR12MB26197B9B9A827160B1932F60E4EEA@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <ea9bfa9b-2689-45cf-95b7-57577f0d76c2@moroto.mountain>
In-Reply-To: <ea9bfa9b-2689-45cf-95b7-57577f0d76c2@moroto.mountain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8b7abf18-7a46-42e2-8a2c-66d622de54a2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-07T01:38:34Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CY8PR12MB7314:EE_
x-ms-office365-filtering-correlation-id: 54438123-9fa6-4f42-6c35-08dbaf437307
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/m/M5M0YqD8fNydads8vT2WFJr7mJqWe01wMTtWN9Uj6AFjPUCgQxkdcbM91ws9Jv4lnaQtF8ZjXxqbJfEnngiSnJzrUaObgZN5X2rho3NbZCyZLTakzBldqJN8waXuq0upUcG2O5cWum7CBnp67xdaEZj9+ER9lw1ImlVT9jZkdkLn6Tpxb3BAD0TWteFDWvxq3apzydG51Jfi0NwpG54NBBqaJBSdBuw1pHMtInhMoWQOh+NiQkRRQ3M5kXiwN7mWxdGhWDpGp2d+gA+bIjWK0yDGnB0hq4T+NbArtaGJ8pO+9w9jf+1kP4GBQw9mCy5srAhTgoVdR2bHpBSAUvsjZ1oLRlC8s/dS7mrNY1DRyX717OlbKRnftV1p2waTILNz1l1ffLZWQyXTlze+fWAoxqoqUaCWjKehBPBeRJMjibmLm1w61f/I8kk59DZrMwLs9btY3AmLQ7rDgRp5ADSKaVBZsGuU0m+WPAP2E+QrRrOCBgXo/cbtFeM1uQ7hsYTCI0/4hKXoI9u39wXpJGDxI0TLtuTQDVLLk1KY4ZW+47GJEVijv/el3R5z4phS8z3ljtDcYaOQO3GCCiSsbOSWjv1VaY0w0zOfmcUCKZrIKwmXnsEejzN8o3yvxC2Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199024)(186009)(1800799009)(38070700005)(122000001)(9686003)(7696005)(6506007)(71200400001)(53546011)(38100700002)(86362001)(33656002)(55016003)(316002)(2906002)(83380400001)(478600001)(76116006)(52536014)(8676002)(5660300002)(66556008)(110136005)(4326008)(8936002)(41300700001)(66946007)(54906003)(66476007)(64756008)(6636002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dPwdCmvZDqAizh2mAaVnQ3ixfEXzwWUw7Xaz5VjP8xTAA8tZ05hS8aIiymaQ?=
 =?us-ascii?Q?5MHy1YmlAQ8z4xBPieGhLTE/hs8udqPJbq4N5rL9+RdVHD/EiAFxcEFU4nig?=
 =?us-ascii?Q?zlI7dkdru5XuQKYt4W2MFpY2mRqQaH91PkEwCAH6Fgvh7qHoVWp7t41ifQrV?=
 =?us-ascii?Q?5y+32iA9j5vtopcTYnezplNcOJZHhDR6q7q2UG//1YFw4wm5GU1Pt6Yugd/L?=
 =?us-ascii?Q?1RMMehmBuFKkMh6zcDlVAHyf0N3S0UiewkjeD/PN1m01JzVkUHaUCuQM1p4r?=
 =?us-ascii?Q?QSsryomAzkhauZSrcN4tgvy+mehQTrlUr5M3lbmSaeI9xFo+C4qwmDK+K4Jf?=
 =?us-ascii?Q?CwtcNZxpsBPG4xFParuOLY29tyMK3/6h7uqAcK55sS7nEuRFAWnUx1kx+Qmi?=
 =?us-ascii?Q?pP0DcwOcvLVmkt5gCNleDies4Cxnn+WF/0Hl+yTRkJINgc41ZGjNtnE7IaBf?=
 =?us-ascii?Q?ly5JDMQPP4l321zKSZBqvHFAD2dIDP+qJBAhhXDFpIl6QCYki7I1fKJC/flQ?=
 =?us-ascii?Q?cVZa4hKAMKQqZk2vLq308WOAAV5m7trBfrmLfM3WpvVZsUY8vUezMTZEQgjA?=
 =?us-ascii?Q?n29k4QfIkp4A0Hj5pXtrCzB3YNmPu4q6FOevMubEjcP9KhC1l2YaVqkRYix4?=
 =?us-ascii?Q?ftz2+fASPOr3ygIblNt6iWCi5ZLvRgTSuUjWB8ij1EHCngrlk85ps/R7p3/r?=
 =?us-ascii?Q?q8gVMKKCTatgt6aoXGsdHAWoxAPodbPTuc97MQ4gGpB0eQOpPAUcoV5maTfj?=
 =?us-ascii?Q?WeXVLTTi8qeyVEsy0hLI0/SmVsF1lc11NNwu3x9gAQbglci+DGorX7LOFYAr?=
 =?us-ascii?Q?TNqEODVresZLET4t6yTm+nFhwvuPWmTIqoaqfuUbIPSDTqCCT+QcdRyvF/vM?=
 =?us-ascii?Q?tEa2Pretce/YUxSyijeEtU5bhkcv7mnpf/o3sIlenv5hI0al/0F/BEAye3Kf?=
 =?us-ascii?Q?DTR3xnVfGTjpXouRCYTr5CKy09r7mw6N4C2OquyGVCVAGwyQKb2Tg4Peo1OG?=
 =?us-ascii?Q?6AZzBG5mzcj0Fv+7wPsVOp1fJeUWjAo0weGb2C2zcxQFQVT+bzQLj9Ii5Xcq?=
 =?us-ascii?Q?Ulehyr1u1FENEVWyXkvPyohGz7ogMYlV0TRbIiwTuX6P54KYAdLXKWOtJehC?=
 =?us-ascii?Q?gksqPjZRN6jSQ/foQd8xEPgkLHuojaKOwy8u9NK8v+TXmuYVKr2saxuMowhk?=
 =?us-ascii?Q?HatCpj72Z/ibPI7MugK0NXnXqnINRu/yqph27mouee6Hl1M5iMI3QHikUl3C?=
 =?us-ascii?Q?Slwk8S/8L0SzVbLZ690XPsMOE1kf/9CIuoOvANu13VK2i34d7JS9IUC5c5zu?=
 =?us-ascii?Q?SVTqy189IzQywpcNBqEEf9xmqWpoQP73WUzNCO+udD3tXDZvUXjzr55MOrX+?=
 =?us-ascii?Q?UowUfCI/RLhqehggZa25OxZzNE2nG/f7FSlfH1yU3TeAplgEe7WEJQEWAlFw?=
 =?us-ascii?Q?oVeyoCgxPYBlty8ETCDMRxKa2KHO10gtTft2IK3s+dZV6dW5vPLNj1v1SAyx?=
 =?us-ascii?Q?EqITCI2/CGlVxxKnDOdlvsvP9TbKCYdJpL/I7YsKj2iVbkoP503x2PlTGg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54438123-9fa6-4f42-6c35-08dbaf437307
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 01:40:43.0034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6uRH8LXtftxaLGd8kqqPThmq9YnhtscRvVXOijM1qsMBeFbl8MO4jwvDxVs1Lzt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7314
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, David Airlie <airlied@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Yeah, nice catch. But personally I would prefer to change the check as "if =
(retry <=3D 0)".
Either way, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Wednesday, September 6, 2023 6:55 PM
> To: Quan, Evan <Evan.Quan@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; amd-gfx@lists.freedesktop.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: fix retry loop test
>
> This loop will exit with "retry" set to -1 if it fails but the code
> checks for if "retry" is zero.  Fix this by changing post-op to a
> pre-op.  --retry vs retry--.
>
> Fixes: e01eeffc3f86 ("drm/amd/pm: avoid driver getting empty metrics tabl=
e
> for the first time")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Obviously this only loop 99 times now instead of a hundred but that's
> fine, this is an approximation.
>
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ff58ee14a68f..20163a9b2a66 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -336,7 +336,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct
> smu_context *smu)
>
>       /* Store one-time values in driver PPTable */
>       if (!pptable->Init) {
> -             while (retry--) {
> +             while (--retry) {
>                       ret =3D smu_v13_0_6_get_metrics_table(smu, NULL,
> true);
>                       if (ret)
>                               return ret;
> --
> 2.39.2

