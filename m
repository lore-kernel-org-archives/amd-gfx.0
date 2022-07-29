Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F171DC00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 04:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC73810EA7B;
	Fri, 29 Jul 2022 04:13:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B13D10EA7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 04:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrbegZ8ydVFkFtz9y01ksOW7q6nFlQUlTmik3zt31FtTkIL33wbOKlI+YDzTnSB/2pPinSaF8ffMXPI9f8dcqIe5v2wx0KLMWteGd8Tqpunvdy8p2KJWdAvjqEwS3aPZlhT0cZh3/BO9GBjKw+uTYmAipI1CcTyZq+hOjO75KoTyDsj3jOuzmIzYPxpoVyukpJOHMUkUHvrQ+ytmru2/VqvghTI9VHfDT334+u6kzPWiRv37Qapf+WaOfJM34dUEaByikgt4G03Vob0aUMPDa8qxG2kTJqt7i9VeXSK4UJYJ6Wbs43iHfcaVnfXAG1aTIxadeMpgsHdaxZF/z77ThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0LaCvRElBUQmrbKbl9H0m2umaKop0MjVW67L2TK1K8=;
 b=gzdqqXYNXqaa5jXVNNhXJe16JhWbWFW3HhHQH6Opc0Nx/VwokkrjoYpqTBD0JQVhhWAnHR+t65tUIxRNz2tt4M/AV70FvUGKIKEYzYfF9VB9V5Z0JhZxaKBCsQIc/fmVqYeNrR5IPfOlNSuxofURrzeZ1JKDKusEGorpQyYW5ZCU9YNq2hOKOf5sEt4Skkk2gWUGtagkir+2W/bmrQcfrKWMIP2eWCVzVAX/bBngMwRCmKEQGXeLArxx3C0l2L4c1Kyxk+0XS2io2sY7TgpRLY9hTa9HM2cKC8jDzJm3lMzysdOPxvHwlGbulI5ILOHzASEzxiGWhFmVeCroaUVNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0LaCvRElBUQmrbKbl9H0m2umaKop0MjVW67L2TK1K8=;
 b=eq9Dt4CDQMy2krYB12WtBvv1l66OKA11d5v26h1BXgNAMrI7MXnMcMLYyqyXfxiLs1Oaa4m71ZOV0kLr7aBpcW8oaFcVMJyilBqClGTOkunFSaR024dop8JnQePOBB+FraW0DaMYYA94MAmjS6s4Ib65I7bvnT3g/wpM3KhsrKM=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by BYAPR12MB4790.namprd12.prod.outlook.com (2603:10b6:a03:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Fri, 29 Jul
 2022 04:13:32 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a%5]) with mapi id 15.20.5458.027; Fri, 29 Jul 2022
 04:13:30 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door loading
Thread-Topic: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door
 loading
Thread-Index: AQHYolBhBJu1zf0SNkqU3eDOgRJOSq2Tb2sAgAFMn4A=
Date: Fri, 29 Jul 2022 04:13:30 +0000
Message-ID: <BY5PR12MB38739A18AFA10814C04CD39FF6999@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
 <DM6PR12MB26197587B46A7F479795BC3BE4969@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197587B46A7F479795BC3BE4969@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-28T08:14:10Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=745eb2d8-695b-40bf-b7af-f21220ee6db2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0dd0f4b-52cd-4918-cc18-08da7118b1cc
x-ms-traffictypediagnostic: BYAPR12MB4790:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuuE+EdAz0iaxoOdUOQX2D+EHTkchRnymcJVWTDVCXrvfzumi+GjF8XcpZWL6FrAINfB/NxJ3/hw7t6HvP9jB59e9oZ40UR3iGNeCilyPrvxt/LKc68YGot9mizKrxzvMgTBEp3jrkgFjp/LJNYSzYmJlBjiFSSg61MtSIqAK4NUvvHx5pDD0wC5ERmysY8XTx6/6AFhJMKsw9xfdegC7G3lnNJhsLkirHige2aZsNFMAGbRAQF62upTo1mMop4FUuL7m2ASsH+YO0t4t7qVIDQuoF08vvzCwBICQdeXs+EuXFJLBRS6lrTsCiLbzcB+rMSkkLh1r9tqPuVD2CiOhvgtMd5EpKgZwUMsAAEtTpvwB4lW8sr7YHlrUHGqDWmvKCnPvm7bcwvadYBgbrhT3mP7c6aVNzPCJaRRCVfo72+3BkCwnKh+s8jU9eEHR1R3P0qJnSHbEHGNs/2QsECFi3zKdV8P7OIZLX1JzbpBhfI+RPnwEsXeWwnMN5BjcA2h+eQpJZeXFIFbeUGmcxdr9/b2AIw9xCLOeGxKp6l8xY/Hh24QZUd+H6W+17lIFRmJYbcrfvgOWYk0sUMG0s7yHaWZDmKxaaiAx00hQQAu3oR+cKeJompqZCpPlVeaB4qlM9zu0zQvf5X4WMTOOL0S3M0gwSphlz4VN5+mKP2dmys2ZGMDDlFg9v00J2xBRadtfxDo3mUaBx9IDfEqIMRDgfbGHReeY5CUQo6PV6GtkpJYZZBOSAA/B7feMqYW/6uv0t4fSmdXigfcx6K38HZ2H81KalvmH6bmvNSf5FxP1Ro=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(83380400001)(71200400001)(52536014)(38100700002)(8936002)(76116006)(86362001)(33656002)(41300700001)(5660300002)(478600001)(66446008)(64756008)(66556008)(53546011)(66476007)(66946007)(4326008)(122000001)(186003)(54906003)(8676002)(110136005)(7696005)(55016003)(6506007)(38070700005)(9686003)(2906002)(26005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2cJ+aXo7ekNU0dVBN45Oz+/ngAQcJAGXfi7kvftAPA/Pjic3Unr2+a7sH/6N?=
 =?us-ascii?Q?N2kMEexTf1Ss9JG4GUl43FPwK1RJlAOvvUyRdZVUsX2XuzUIXRw83MF8EyUx?=
 =?us-ascii?Q?cxeK4N63Q5jh9Lgr/EYfb0dHZRvpAaUBqbGBVXg3Qs5e5eQDRzl/07wmH4Q6?=
 =?us-ascii?Q?M5QfgM5H3ujN9lFDtJZy59Lsz7Cvt8XY5YuBIv6fxD84yCYmbwQtDiVmhYj+?=
 =?us-ascii?Q?cWSw5myHHPJR21xQG9rr6cGXiEdhkn2+rctw0tVE9SmRe3JsC3KrCH2toF+f?=
 =?us-ascii?Q?at3dv6rbUKTtRx8Kut7Xk34coZdAOkNdS5BMjp5oSQw858POHpKnFGsozIyH?=
 =?us-ascii?Q?BVK+UewSamuj+h7xbZJ6WaELlX5ZbSKhdvKfTkHGmf1Nbn6Y0h0rIriZVXag?=
 =?us-ascii?Q?4beNYKfyV2rM12n9dsGErcezAjM2QAOGqzGTULThAhqa+qN4g30zUMMQp9a1?=
 =?us-ascii?Q?vL55g+WPZzNQh0vaAXz8nFEmdubTKoUUmln2w8HpuqcwzR51S4mmqNRZqDag?=
 =?us-ascii?Q?JoxjZKydA1IlMk+FaHFhqdffeTueXWyjNL8tG8dZ3Yq+Oh4v6OfktCKcXfq5?=
 =?us-ascii?Q?7NZ349LgA0R+GSz06UpKDKsrYo1ASCGGW7aT1mWjI7Unrqgb1Lgrceswk7xu?=
 =?us-ascii?Q?A0w6alFwP8APH2CaH/2GwNQq8DkIjNiwRiZYxdnnFcVpJ1kM0NYbJS6pDxvz?=
 =?us-ascii?Q?qj9sqe9oADL5ZY03MkKaaLPGtdnpHvCOuuOf0JwYIv5yW505UmV3yQ7t4kVT?=
 =?us-ascii?Q?vlOJ8NQ5pcujwMj/de1Du6yAFJHLkv2SpilfsD9ibXkCUH2AYoMoVmULx6rm?=
 =?us-ascii?Q?df1DwSfebWD9Z8pYDsbbMsiKUF/opLHn0lG9CgyPSfrQ4OezkN5od69A3XGS?=
 =?us-ascii?Q?l5TTRvbS4hzIfBWP81ZOMgvGNF3hdeCm6CaBgCjWdoUALLTjz4dP7vvff6+Q?=
 =?us-ascii?Q?jcBLUVzmTKasFi2F2O6YeWgS30A0m3+oqlfQn+wNoO5Fll8OwrP3sis8E+05?=
 =?us-ascii?Q?JhR049WwEhI7QvnrhqTkqbeawYqsFMQy5kK85Ma6OaO1wNhGvBr8blGIcdUi?=
 =?us-ascii?Q?aqlERA/sDnk1wOB8zQ0840TF94lfFs25MynXHIph+A1X+pM1zAx5kDb3ia76?=
 =?us-ascii?Q?+pQMyJcObCcUj7VIUpBxmF1Y2auYF3WcJvtbgYq7rWA6EgbcyDJKUaLaBeqw?=
 =?us-ascii?Q?hsUroWuFrRqF2u7ctdQgrgCAwaZLS0FWlYRoW3MLqYIznJtNOo6WPeNEdzd8?=
 =?us-ascii?Q?1Cz/xHxUE/2GNbEbKyw3x/SzJCiNTH8Rxr5KFPDDtfn2/w+bfqd144rQST/L?=
 =?us-ascii?Q?sn8AyNLONPq/WRBMGXd2cNrErg2UAQUf7MEJXoRX6biXwoIZGh33OgSS+Ofk?=
 =?us-ascii?Q?0kWL6oqSFq+KzZ/hdLaE/EsDc85HKEinB14OoS41udCsW80SxLL06m64QXW5?=
 =?us-ascii?Q?XMElXGZj/VSrky4Zm7S0soVkFtjg2RU40+wO/qnfFIrqUPp0XToZDrNP/Hwa?=
 =?us-ascii?Q?LWZfR4Msvz4fmRoBDQ8CzelQQK9e80eIdLcWM+Ah0BnwVEohLTvbQWJ3fVod?=
 =?us-ascii?Q?2Rab/ptGX1Qo4kXh4sNfTPQnpvT+pXAxXPEJVxHs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dd0f4b-52cd-4918-cc18-08da7118b1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 04:13:30.2332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/HixNnCiX2cifSK75oNbpVxLI82gdrTFw8omaSkZbhIgNUBDSRdDl6eAO4tSAUJImob5FO21zPdT+0lr7qnFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4790
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

Hi Xiaojian,

Please move the power up IPU to "smu->is_apu" as Evan' comment and make sur=
e this is only called for PSP FW load type as=20
backdoor loading already included this in the IMU start process.  After thi=
s,=20

Series is
Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Thursday, July 28, 2022 4:14 PM
To: Du, Xiaojian <Xiaojian.Du@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd=
.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door loa=
ding

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Xiaojian Du
> Sent: Thursday, July 28, 2022 3:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim=20
> <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan=20
> <Yifan1.Zhang@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door=20
> loading
>=20
> This patch will make SMU send msg to IMU for the front-door loading,=20
> it is required by some ASICs.
>=20
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 6d9b3c6af164..79c01fa4b875 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1360,6 +1360,14 @@ static int smu_hw_init(void *handle)
>  		return ret;
>  	}
>=20
> +	if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
> +		ret =3D smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
> +		if (ret) {
> +			dev_err(adev->dev, "Failed to Enable gfx imu!\n");
> +			return ret;
> +		}
> +	}
[Quan, Evan] Per my understandings, this should be needed by APU only. Can =
you move this under "smu->is_apu" control as other features below?

Evan
> +
>  	if (smu->is_apu) {
>  		smu_dpm_set_vcn_enable(smu, true);
>  		smu_dpm_set_jpeg_enable(smu, true);
> --
> 2.25.1
