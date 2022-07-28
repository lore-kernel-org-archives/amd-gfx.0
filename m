Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875A3C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 08:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE3F11A7E6;
	Thu, 28 Jul 2022 08:14:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B24710E40F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 08:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlloCnVY+wuRZ3yMo1RiLKaKBJGkZwiNZzG93/LiflMdJ3bvCxNrCxrr9cLWMoYrVDYA/P6zxzkVpNnSB6DCvyxJeHrTt9kmg7txN8IqDD91pQHnOPoiM8vE3AJDE/PQT1X72GnDPX2AHipI9XMSp3tUyGW3q7dhx1T/K7L0YObrHLmmaU4kp1+I4j2lBnT/ClIYbOXEKSwQvDmwr43sA6qYmVOxnew+IYgxImrbYrQn5avqGA8jeWdki+W/IwIL+MEgvRLQ//7RVDhmITJ5djYQITe3dXRmS+IJhtn7Q9o0ukiA/6BOypZ0fkZnyz8W9t5veoOql0yUwzLQ2YBAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUISH9fJO93yxVr3WIFfJCGtBAepYpk06LNcjg3ATc8=;
 b=Ufe5lV296I6oby57bpA4Y5SvVjVPPKoAu3dI87FPI3WIwP8V6oaMNp36AaA2mv4k4AsZG68Z6I785qXox7dhhbK/PCIYt/hD3uBPQG6pFpXwNpJ/QZ6Btaj98IjRhqT+BgQ/zSgwh0fFtV3Q6c5bcPaTZZw+s2jDKdELP034hQFlI8JXfXfSBt6jlWrRCU8tm+i/ttf3FCZYlCh04EP8dfDxRJwG/neqOQripNlhk0XhAOaCzRGILWTe6uz3fwzhhCRnwz3jM/VSumdtJ+J25v2l3CUWOz8Mz5y7v3P6tIvlvUxDWEdzhPKguNNXzkbi670ig+bCDbFU2HDWC9lWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUISH9fJO93yxVr3WIFfJCGtBAepYpk06LNcjg3ATc8=;
 b=yiNwJcKsVvkHSmJOaCBkY0mezwCVUlzdJCcXsJJr3iE1miN/d+y4eiRXQBvTW1EJWd4IGfOsc1//bE//1q0grPGe/X4Y1lhkYDrrrJIoSjqOLmWD2v7ycM1Kr/ntEvOjBwoAWLlYOjgiN2XC8v6VkPOpexhkV+10RUSq47yZaWo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Thu, 28 Jul 2022 08:14:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::4c95:9b06:87e6:4382%7]) with mapi id 15.20.5458.026; Thu, 28 Jul 2022
 08:14:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door loading
Thread-Topic: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door
 loading
Thread-Index: AQHYolBqC0Zk9N6Yq0ub33I7GrAX7q2Tbq4g
Date: Thu, 28 Jul 2022 08:14:14 +0000
Message-ID: <DM6PR12MB26197587B46A7F479795BC3BE4969@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
In-Reply-To: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
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
x-ms-office365-filtering-correlation-id: bda1c43b-ac09-4962-0770-08da707128ec
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P96NDu6zJr7EeKeNQcssG0lScMR+JQ6ZX7mSMvhmpm1yQ0VgsD1tOlz/hnWS9tjmVAXNLl9cOw7ErhA/4iy9Xlwsj9ORq0AkyRDfWmdw8YgGIld2RefTCdzz5Z805zUIU4AQMHw2QMH0LBK5g1o69t7JsdEGgrxE+6aajh2NMm+yWD7jXIR9ILPlOpE0E5Wj7Uzpf68AkrnDEE5s5sdIcfKj6pXR1cxbAkRNdAdj5xxq9wuw76ScM3Y7SLVErXE8kCz4TIWpuEQWIFCw3A1HN4QSPc3q5DJCxsHsJduBZDFSki5z7ELYzM5sWqt1elbTGW9XmTeLIxc3T26204crOGB/qprmEXT1pS4GVI9Jk688KfP/pzryhgVbO0UFj0AkYCLceiy5GazE0S9XqdTdQ7jc323Mjkxj1fovA192N/x5t3DEnjmJMlr2FgZaJC6qIU6nNlj4ZsJIMqTPwOBQcFjYeDYUomjLKruY6f/EDSnOZd0w2wN+0ppPcA1z0eQWo5xlMftMimo2e5Mntd3CHf2Gv9v7xTsVruMfIoY0JzkmC7QBCRpeF/CI4C2hlbVbBak2ZRa9dPWxoxZIC0dEneesVT9OZPpov37/Ov6eEwTnjTUJjW65dabu+SrHfmFHAui7T3QHTp8IiDhiZUDzQPNZdqzUPoQ4yrT8KIFzs5Eu06WHXt46xFsZYKbfivxnosTLSEVW5Pkzc3Ye2VWeuyz7OzFGX+CAwaxXyWo7jo1LhXswuZJ2acGp8BbdMWPG6W3ReeKjwfnz+iTVWU3HJLNYt8iOSBaJre71oLDT4m8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(6506007)(86362001)(53546011)(26005)(9686003)(122000001)(38070700005)(7696005)(38100700002)(41300700001)(186003)(83380400001)(52536014)(55016003)(33656002)(66556008)(64756008)(66446008)(4326008)(66476007)(76116006)(66946007)(8936002)(5660300002)(8676002)(2906002)(478600001)(71200400001)(110136005)(54906003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0KLzb7Kt8NGylXOo1j9RgjQUVOHe8yv83eCtCbua1CPSzCmW3diCNFcrv6Ob?=
 =?us-ascii?Q?hxmxs5ueeZQ+AYherweYOx44fWeFi7sZ3yYONgBAo7VpGTn5UXlacKAJEgAl?=
 =?us-ascii?Q?ELCxTo4AYIQwG1ifYCj3EmBxlS6Wxi5HWWP8SL6R3cogP/Ae8vUyEz/MGxIn?=
 =?us-ascii?Q?9rs/tctbZt5I3OJmMqDkyMEGWfSXGbyjf17yPvp1zDxA67XOraxabtLJXyGX?=
 =?us-ascii?Q?5Y2Llo2t54zrJIJsFoC9X1eGMA+Fkp+2klOCCvTd+3jAK0V80P/fY1BJ/qXe?=
 =?us-ascii?Q?pw6hf21Nqqd+ea65NowW7QQhUNnCkGtfX4FwsB8VA1cXXi+y8nNWAI532W2z?=
 =?us-ascii?Q?1kgAgIEbFDlp2fGCRivtTH8FBnYPMGvKdnHUQGKpYB7ODOQr5w8WsFRnIDrv?=
 =?us-ascii?Q?EMWdjqyGtgtT9gjJqj44r61QgZ62EZx1TNp7AML8MsmxUc3SMI/cvZCs3Ozp?=
 =?us-ascii?Q?O+iCg0c3cxLZ0sN1Td8kqHJUvCnU0AwMwWQF02FMI9YTyststcSs5Cjpaj5I?=
 =?us-ascii?Q?zKc4Z9RU9fSmmv8zOlbjcn6pAfGbJpbSLE120LlXdAEqYjlcINhT+MUfd5rx?=
 =?us-ascii?Q?rUqjWmNWZPwrlKLA9dzwZ4KudcAorcfTYGB2zmJoBOiIaPQME5N7s+qJuhuz?=
 =?us-ascii?Q?WccgPfcqety0f+OOr3lvUX0O8BanyDKkSzkkbKndPWHtKGvAmp0hTmqAtGl4?=
 =?us-ascii?Q?X1dmbdcYw3FHs6whTuXgo6NL96juNzoE0V7dAPeniFNW83vvmFiT4f29gs1Q?=
 =?us-ascii?Q?pZIrWhi9Af+6oRZP5rpeM4oNSLGDvAdgZKqLHCO2yrjYOw7o0wAp6LNUB1YO?=
 =?us-ascii?Q?70EFpP+neoWDLWylq98kzdURljnCMeYaJQMCqAXZ97gc0M0kCvZjDwwpnHUP?=
 =?us-ascii?Q?RXdW07zrVYc8cCGlaq7PVe7mGieE5oj+V7xmQlyWLCuJegWmgphqkVspyJJx?=
 =?us-ascii?Q?l0yiNenF6rcxd+2HkMyR+0SSDEk7KKN5jdXLrlkEmfCeX5o1l8DtN9IaJPWe?=
 =?us-ascii?Q?qr0jOKv+NEvPbPu06zAurZNrljgpY6ZlwUDkM8d1yL/y6t3bNXLlUfjFNh02?=
 =?us-ascii?Q?7VyugjqIMh+MTMLse0U9P446a9slrR4k4CIRP1SOpFbDhdxztvMHtuyZMRrf?=
 =?us-ascii?Q?N6v3NruUvNdeK5/JMaJ+/xrrsoZTEOcftZA+F3OyFCmSl3qliTbcAssrq7ZW?=
 =?us-ascii?Q?cusz3iYGvxUn/8h7pLbnYfN/fPUigLyLJDbJU2DQFFEHuP/yOb6X2UbG+hWP?=
 =?us-ascii?Q?jv/1S4yDMc5lPJeGCLaE7/B9PNBTIG7bV2lkJVI/r/PXvegZJA/yhtYCVLQa?=
 =?us-ascii?Q?2xXOYKwuAYU+em0NNaKLJ66bpmtKDzBHeP0SqlZOW0lKMyNuAjChXYE45XMO?=
 =?us-ascii?Q?CzypMtnqL1DFlshb624qbb2CRHx1ytZMrcvuRWdm+HabswzBAsyqCi/EzLmV?=
 =?us-ascii?Q?GAsMhHr1/z2TW/pvw+5vCynT2Yc6AzwJ33XHNRnl9OaeLcPCEWrRTfOoCcU3?=
 =?us-ascii?Q?I6rBgr7W0bugwUcdtSswb8QSnw2SDdXbrafkOixekdfwJXarkEn8jUYg3SZy?=
 =?us-ascii?Q?8xo1ITFF5iW7rwEttNI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda1c43b-ac09-4962-0770-08da707128ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 08:14:14.6206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbRRTKGinJp1r588HZcjyH6E908fzepWoJrfNIA0m1D2q8S2i9loJgPaq6OjvJ9C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Xiaojian Du
> Sent: Thursday, July 28, 2022 3:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door
> loading
>=20
> This patch will make SMU send msg to IMU for the front-door loading, it i=
s
> required by some ASICs.
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
