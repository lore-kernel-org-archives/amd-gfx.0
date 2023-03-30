Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A7EC6FD18
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 02:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A7010E04F;
	Thu, 30 Mar 2023 02:09:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F0E10E049
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 02:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ43DBTotToa4EpuFp0/T4rbAeEILCGkkOQeFTRxpJLcDk2uhNM/dja5Q7cOtJUC8hSdgvR/YD/LPr8Mof0BnqEK5RMJUZ9qJu2iFsOUdJCzHec569/2d6Gnr41V5QKVEbt3k/mot1PNAHBKwcqUKqhD7vuMqLwSoKa+BrbSJZkWpKGTf7tMEe8SJzvtU85yCczrses4+HAJNGYBOdQDc4Sq4Ol3rwIJBEZgsjxXp2wGG7fgw3i/ez6bnyYaC3MogLN/xO55BiooxDwOu/YY0sONfVezuQWsx2IC8XvCg0i3FLFKu7zXyS3ez74/NR5FSO94GaiH9k7ZLPXpxANldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC8QpElv2Q3zvV0kLcb6RO6AOF1F5Et9RS1eAUK9wpo=;
 b=CZTvfjYwFzk8Wf3ZKBh51qW3llLZXdM6FGLkWcqpTW4SURNyw+8TEbkDOck4NskPcOAdjiNselX/X3vdIMBgFi2XltfroZjBB2G2U+mod3JqFeeukvpH5u6C9FQY5mRKpuklm8ajuUWfTpk8LwiW5ntC9g4NIqOMNUJTGKW++NPfSGjvZG57k8hc46AcNrEV56oev1nAQyV4nY1YAjxs/khKRlnR4qPmDPx1yv+0HNxfZaLQ/m/2UvM/1JpN7VezZpxSRgV7hQHviBOpYfwNo1MgPu9SIllMhJrgg+DIpb0eTvAYJEWUnq7+To4jg0AmkDCDVvusg2zFQ5499CzShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC8QpElv2Q3zvV0kLcb6RO6AOF1F5Et9RS1eAUK9wpo=;
 b=Va8pZ/Slu2tW8VhoQzqJ+4IXBZxMrZCG+gzHvpUHeu0dS3VGbN+iAf1+Qt64o9cWddps/1axfqAiBDHKp977XvRVIFb+AHPXjLq/Lvt7gkoCS6XJOWvnGMC0rIH2B6QkhEtgfvOkzh9BQE7IG5DCNZeLCR8ArHLLQdzzpssqFHI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Thu, 30 Mar
 2023 02:09:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%7]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 02:09:16 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: add sysfs node vclk1 and dclk1
Thread-Topic: [PATCH 1/3] drm/amdgpu: add sysfs node vclk1 and dclk1
Thread-Index: AQHZYixsj90jBd7uRU2iznilcvqRAK8SlIDg
Date: Thu, 30 Mar 2023 02:09:16 +0000
Message-ID: <DM6PR12MB261969794E2B0D9459AF7FE9E48E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230329105116.214594-1-Tong.Liu01@amd.com>
In-Reply-To: <20230329105116.214594-1-Tong.Liu01@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T02:09:13Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=43362459-6be8-4309-8e50-037ea5dbbdc6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|BL0PR12MB4850:EE_
x-ms-office365-filtering-correlation-id: 091772a9-fd9f-448a-3613-08db30c3c3b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z86R3QzrIDclQC9+ugYEn38OfmbjknBXRlBwN8CqHPyNdb8x62TavAdpnN9VMQf+GxrcgS67HQzvE34teWLDjnmW98BOiPdszX5YIU0LhIwHR/+4GKSJUZ4P4FPZXKlZ7oKWect1LuOTVMQGzV/ukk4gN27T1tGKYZ/nP9CbAr3j48XYaGlS/iwhMsWJHSz5jcG0S/DLn4dzMAeHjShhBGhXjMdeZ340MF7l9oBxQEwJlkptkBb9Ioz5bsJElyWvXyMbSPT5NNYKVF5pa/n+xTQC8oBcr7hQoUkklfhZm1fLGDJ5OIZwDBgckCgwKzZ+LGyknBlq9983nBupX+UoglIPv3VU+hFO365OJ3c1sul72rK5uXodWzDKvWtl9AxNu8UJPT/FN6m4bkAqrJub2NrbQfrKaesXKjV14//q0/QZdu6KVmB5TJzUnGeH6dtqsKtVscc/4EV61fEiY1NIOPlY0JH0PX1nGC1k+kP+T17uYM+hAQeAlMcX6cwVSjwg10ZK/sxeutbpewe4vPzF4mAnpe5pcvkWE94k78NyY6l2XgVc+eGoKZxFVCWSfL0vjGJk11zQk4m27TqrcJ/kCvJjq6hNGULMVlgJhzPPjBbmDzWkH5/YxpJMA9uBfbLM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(2906002)(83380400001)(76116006)(54906003)(64756008)(8676002)(66946007)(4326008)(66476007)(7696005)(66556008)(71200400001)(478600001)(55016003)(38070700005)(26005)(53546011)(110136005)(316002)(9686003)(6506007)(186003)(38100700002)(52536014)(86362001)(66446008)(122000001)(5660300002)(33656002)(41300700001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KrRvYlGN2lXuqmiDau5qvWMBdsjBvdtr/hoC9qRW0HjgcvwjaR1yM7ePn6T9?=
 =?us-ascii?Q?/FFHVRkBTGFBMwvZgj/5J8K7ksn10G2ZM8KwlJBFgSoouyr5yvAj/9/8DHs7?=
 =?us-ascii?Q?/nBslEeniCZTsVn1xr4tsxN3yyFRdsOhMlcrfkB3qv4HJqXzKFc92y7TfmV3?=
 =?us-ascii?Q?sRExyau/vvnke6OxdE+mcdOqrcqmZK1n6yXdPxbQgINzpZBjIN+N589Ws5lf?=
 =?us-ascii?Q?MKcSk5WE5oUrcEFuAbbUGcGa1tCtfTtFDUucS53MuLiir8qlzxy+IA0VD7yZ?=
 =?us-ascii?Q?lCISq/sWbOtZBKQdG/p//nFz+e5c+MvKxvwgYlqzGifjqHvioXZcQLyEJG70?=
 =?us-ascii?Q?7cS/XOC3PGjkydW/cXZ11RdU7dJwvm4mTowS0/BB7j8HB4QOgdfG3tcRq4BK?=
 =?us-ascii?Q?HgL8ODjxxN22r/qPR45sMWIwsr/iwmxLvMwYKWnFlKXxX3mU2ZOb/dvhbZuD?=
 =?us-ascii?Q?WBSiGHxFgt0K6Z0FOJeH+wbh8GEHZWqGaF37JFDJ04ROBKDSW5jL9P7jTZ3g?=
 =?us-ascii?Q?Nzu4rxqfqV8827Siuyl/G68TDGqSMnjQG/aN+I2DpjmkGfWICo6PytAx7kom?=
 =?us-ascii?Q?nByQ4SePwkZEaWBehhucGunVD2/nj3hNyeMqNOiFzql7JOyA9p2yxZGz3fY8?=
 =?us-ascii?Q?mFkuP1ph7TLJ9V57Y4zACdz4/tOeslPym6z4jGao5w70mk+wcM2AXQ4BTNUn?=
 =?us-ascii?Q?XtqsG75NN8FdWDuVFWhrNuS1t1H9cyQqEYn24zZfocyVVxxnWcEz3X1/PceO?=
 =?us-ascii?Q?6QrcZBugzwpxG88VUYwiSlFVEVJdBnajMMDB4BPty4O6AbISNxgSqujs9c4z?=
 =?us-ascii?Q?tEqfhbpsLF3Yq0EzQIKeG+hDxyA+oSfX7pLy19yV2YzeT646tjmw7XNIGLIY?=
 =?us-ascii?Q?adsOjtfMoYYtgU9iHMX8qWFpdCt5VZ/mGVG39vjhx991KzfwpBfHXDSy9AR+?=
 =?us-ascii?Q?6buLo3L8M4xmxd9ijrM0r5nclBVFrFWJ1jS568/npnCz4iq9GEYbhJzbG9Mk?=
 =?us-ascii?Q?Qi7J3uP6OlGn5oGnVU9kPydrVB+P+xlE2blm+rBvY+t45JGdaWMIot6YRvQJ?=
 =?us-ascii?Q?RAVw9S0tSIj/2JChnulPGT72pg6JDImIiO7kh+skO41pGahj3gezrxteQQbT?=
 =?us-ascii?Q?o5vVuv1fSdilKj9V/Cm3J0u+Bb+KcWBc7aLrKp8kC23tNkr8IZM/nOhJeAV6?=
 =?us-ascii?Q?CUcjDVYAu8IAJCLBBotdywc2lJFlO0nU8vlfZlcqziAMzysIVQcDpTTIKp1k?=
 =?us-ascii?Q?Z+7B1F9igr/G7pdxWAh7ZFS+6eTymeHROsjH2fkuP28C+MRvTS8uNXk15Top?=
 =?us-ascii?Q?4MVUODIvlRTI60e0M7aqImPLkS7iwftA60axPIV4WSXJ040+HNalDqB62I9p?=
 =?us-ascii?Q?Ifl7np9SfiwfmErOAnc8aoxlgKK+p2byh1HeT11DzS9i/h8CoJDDeyvLzlJw?=
 =?us-ascii?Q?DLqx3cI0HXq6W2DsSK2gaA1O4pyumHSDm21WbumY2UTuqEdlU5qsHPNpG8Fb?=
 =?us-ascii?Q?uB9Z18HFEejgYTlahFENiAQt2bUyr2A8jUnKENtnOvPVGeKeNYSdyexy/BDI?=
 =?us-ascii?Q?FONz2WKvVeBvACaGd0k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091772a9-fd9f-448a-3613-08db30c3c3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 02:09:16.2600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZ/MIOADPGOCPNnnrHzuaxnKOP9bifOagUz/JbRAa9ID9XjxOyKPeEwuojzwoOsb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4850
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Liu01,
 Tong \(Esther\)" <Tong.Liu01@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: Tong Liu01 <Tong.Liu01@amd.com>
> Sent: Wednesday, March 29, 2023 6:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: add sysfs node vclk1 and dclk1
>=20
> User can check pp_dpm_vclk1 and pp_dpm_dclk1 for DPM frequency of
> vcn and dcn
>=20
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 32
> +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 +++++
>  3 files changed, 42 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 86b6b0c9fb02..9f542f6e19ed 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -104,7 +104,9 @@ enum pp_clock_type {
>  	PP_FCLK,
>  	PP_DCEFCLK,
>  	PP_VCLK,
> +	PP_VCLK1,
>  	PP_DCLK,
> +	PP_DCLK1,
>  	OD_SCLK,
>  	OD_MCLK,
>  	OD_VDDC_CURVE,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d75a67cfe523..9991447b5f14 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1180,6 +1180,21 @@ static ssize_t amdgpu_set_pp_dpm_vclk(struct
> device *dev,
>  	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK, buf, count);
>  }
>=20
> +static ssize_t amdgpu_get_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return amdgpu_get_pp_dpm_clock(dev, PP_VCLK1, buf);
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK1, buf, count);
> +}
> +
>  static ssize_t amdgpu_get_pp_dpm_dclk(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -1195,6 +1210,21 @@ static ssize_t amdgpu_set_pp_dpm_dclk(struct
> device *dev,
>  	return amdgpu_set_pp_dpm_clock(dev, PP_DCLK, buf, count);
>  }
>=20
> +static ssize_t amdgpu_get_pp_dpm_dclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return amdgpu_get_pp_dpm_clock(dev, PP_DCLK, buf);
"PP_DCLK" here should be "PP_DCLK1" I believe. Might a copy-and-paste error=
?
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_dclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	return amdgpu_set_pp_dpm_clock(dev, PP_DCLK, buf, count);
Same here.

Evan
> +}
> +
>  static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -2002,7 +2032,9 @@ static struct amdgpu_device_attr
> amdgpu_device_attrs[] =3D {
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk1,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,
> 		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,
> 	ATTR_FLAG_BASIC),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 94fe8593444a..056ac2b512eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2022,8 +2022,12 @@ static int smu_force_ppclk_levels(void *handle,
>  		clk_type =3D SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type =3D SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type =3D SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type =3D SMU_DCLK; break;
> +	case PP_DCLK1:
> +		clk_type =3D SMU_DCLK1; break;
>  	case OD_SCLK:
>  		clk_type =3D SMU_OD_SCLK; break;
>  	case OD_MCLK:
> @@ -2409,8 +2413,12 @@ static enum smu_clk_type
> smu_convert_to_smuclk(enum pp_clock_type type)
>  		clk_type =3D SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type =3D SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type =3D SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type =3D SMU_DCLK; break;
> +	case PP_DCLK1:
> +		clk_type =3D SMU_DCLK1; break;
>  	case OD_SCLK:
>  		clk_type =3D SMU_OD_SCLK; break;
>  	case OD_MCLK:
> --
> 2.34.1
