Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C2BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 03:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A458BB0D;
	Mon, 11 Jul 2022 03:30:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B358BB0D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 03:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyuxanIeBYC0wlwt6XHd1b2dWMmC/7UPnLkMVd3hvd8daLQG9+7C4zydTdM1OZ0GmAMdGUKHvtvjFzNnm/CV8zdXqEmSOl7deypTh+dDnwJBVxow/xR5iiJRorWyUY3Hds/3ue0P5jXZWw6UEXM05bmy0Mceh7LO0dYyfqz8lyNXFQN9SbTPvReYsMBRVgmosfUUtlX91obBq2Dnge3mnymDXWy8ewHk/LbkU81J/LPkD6EfyX9lGqsJO/EDmhN80HumQOBav61pX83DAV+3hrZW2CywYQ5gy424WFdDOldqu4gUzFFLmESJK6WaThLQ58zT4LLyU482gq0taWtbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUMlUgkSihcrcD4OG+7UHYr+7dwmnwzRSXpKxIEd2qo=;
 b=AkCYouAdQumbHOQM5f0FAQHHfFkPzRP72UAxVDJEvngcHcp6tbs0R8yN7VAEh1F+186thiks2V1aR/MeH+N9evSrtRFRVokHEZscXP2znrVyo0AelEkTMozusXlYzTD6BpSyAtWkEt+ftc3pbJtOygoMVgj3dVaZXdKzMQ+xHp/6cqYzd8ymLrjp0MRiXTCMxhw7tyaH4+OaH5zRchhgDFgSn0z6am5wVlaGO8dHbHqqnBPdwOe9XgVW1qnrAAsIzMll29W8eobLmMXQJ8Fza0P6rJ/R/jlgai0oOTbNZeqMFaSfL2wKa/e7Zr8V8IVCskWLxzjRX9SV173b6X0EeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUMlUgkSihcrcD4OG+7UHYr+7dwmnwzRSXpKxIEd2qo=;
 b=ieM+vKthtpqdDM4YRTZ0uuJWcYemy82aopwXSDkDps5Dn3SY9HzaFLtRdLrjlumqydY9GiQAXYpxrs0J9AOmW7iBgiRJYjbbOW8R9KDriNIxzJOMfCj/6Atdoq2GquqRhnBUQBgDlw+eviLE3nmvI2U0szRDDWj8UoMQoSwhNIQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1627.namprd12.prod.outlook.com (2603:10b6:4:10::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Mon, 11 Jul 2022 03:30:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 03:30:41 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Mr. B34r" <mr.b34r@kolabnow.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Prevent divide by zero
Thread-Topic: [PATCH] drm/amd/pm: Prevent divide by zero
Thread-Index: AQHYk2pqJXFZGLn06U6Y/0HnnH116q14hkzA
Date: Mon, 11 Jul 2022 03:30:41 +0000
Message-ID: <DM6PR12MB2619C92CED9F2D3AAA80FFCCE4879@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220709023125.75039-1-mr.b34r@kolabnow.com>
In-Reply-To: <20220709023125.75039-1-mr.b34r@kolabnow.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-11T03:30:38Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8fb550e-e99c-42ab-8502-3a8b107f5570;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a83e8dcb-3bf5-469f-8609-08da62edbb1f
x-ms-traffictypediagnostic: DM5PR12MB1627:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1a/4lw5YcXrR6+NZCYw0gbG9I9KAl26HTXIO/IMEBGSJfrNNsAOSTKwuLWdRUCMG7vTQK8friwa0WmHsEItXXnXG0TQDvF86ZDRQKMZ7mJ4V/zZF5JWGnJJTgHj145PZesfPMTxK0+XDWsDWvuns3kbqrJ/ww7XWWCQBepjngUtgRL2OnXqF8DAjvJ7IZKg/ARYo8nWaa8RGiYcTbY7wWM3TPIKVkk1PiCYu0TIm7pZsv03T4wGkzkV92o2pUqIF/Y4Fr6WWf0aGz7zoRNjJU+t+rU+yPUYCgoffvwVqCWmdUDSKh+yKsCoGfFqRxRwk+SosAi9VQF+jm7aRozsOdZ4W80cwxFu5LxGXaMnpVKu/Lu+SSTO7PaCQK48GRN9ECt//2o5Hjos1nR54E+Sh1x3IpmgxbYPUwDDVFET8a181bmp4I/nzPwvyRzWJBy5Va8KlxwTGk5UcAFZBkTwISJEN3KCqf297ROGNxZ+NE6yxFOSdMGWRWJX5C7xrbA3liFQRv4NecS8HP2LTobm8CW9KvyaG8AcYeD+3tit+K8h4YOThccloT9Z90yvS6UtH6IK5nQyo50mHXNzp3sJ9Gre+gecYtGCg0PP3wyW/6uSNLetvx5+88CYi2LUND4Cyeowx1y9+pAKGBd6K3LbABvUnkDWZwNE7mwimz+DX8ZTjBXaqGeoHvZvTYgZs/HD3wLssGxf1u36YKYnEEYqxjt2brCp4otrq3RPQsvHRNRwGK5QawF3Du79SoYKs4uaStNrGGVuOWIiLNRj9m+FybIlwgFbDefJbw4TrXvZZuktDpNFWDDUZa5ya8xJAKGs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(66556008)(8676002)(66446008)(66476007)(66946007)(64756008)(76116006)(53546011)(26005)(52536014)(478600001)(8936002)(5660300002)(86362001)(9686003)(71200400001)(122000001)(41300700001)(110136005)(316002)(38070700005)(38100700002)(7696005)(6506007)(33656002)(2906002)(55016003)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zClQG9ilO/DpNGugK5if7ugcnAgQfh82552H6K3YKMQLm9KaKVyVUxBer6lg?=
 =?us-ascii?Q?vcnoUkEK+eF3A7ovwBs0ozX+8U2Lplm6QpRiBgg/pMY2OdjpyCIDiBUHfb5Y?=
 =?us-ascii?Q?hMXBdKIYUofYT+Q8p5TlyRJw0UU+cRRaZ1yJ9tHe1qeHZswb3hmWIAtCJMcx?=
 =?us-ascii?Q?Ab1Mm1A9q5B33MBynsr2XQKuyqiySYpdZFRn9XsqpaO1JzrHNSZIa2G8zKuD?=
 =?us-ascii?Q?IsIg4yaY6qS7criVlNIYXDfYoU8rZFnXPqAdDUR6M4zSOfpVRVqNCnhLzz29?=
 =?us-ascii?Q?+4Hj57i9kghQiGyQtlHndsHYOIROLxlyKfUNOEDBJTlW8mTbv7gSHVRIJTyi?=
 =?us-ascii?Q?7Tfbxpfue7NXA/SAtQ7/exTQGlYt3akYhjVdEBHBldibu6XLjvo0lmkCnPZg?=
 =?us-ascii?Q?tdby2eAqw/tXRmo4ESHjnqSfWV0j5Ic6+DkYJftlo8xZXK2cUCdES+BEMewh?=
 =?us-ascii?Q?GM4Z99kL7wpKPrlLxak53jgXz85FNqsdevbH3fjqnKhJ42gEYhnjv0HM7Ajk?=
 =?us-ascii?Q?IwhQaDrEpM/sP5Nk2Ainl2jQSyZjyvhy/v3rhS3TSfkDo9n6LUJKrwd3vK1H?=
 =?us-ascii?Q?m6UpaZbMEMy6l8w7EdSukfESE/dEDe+9W9ReJg1tP4beKT5Tgk25wHMzv5PT?=
 =?us-ascii?Q?rmliN3G/VbKoOkNL7vqoG9lolOJrCG3i0NtRHZAWEwd3GgjxuHOVDlDCrF9W?=
 =?us-ascii?Q?xy8DwBlgfRnpzsM5ZljBEA0U4YJ+C51+U6/OlmzQUW4GVzSnqlg03qEjXID+?=
 =?us-ascii?Q?V9zG2Dnux85Gk4S8j6qB1kyv5bXUOGp8QBsqKvOiD60C38/qDs5ty3BAIL+7?=
 =?us-ascii?Q?8DFgZP0X0rtjkTYidS6yMT2TBbbNmGgUcR0Yt/LNilby5RVDOPQo+tC5scBV?=
 =?us-ascii?Q?gfwKFqGACjRpKFPgInoD6XF70APcKegtdno3f7QZEwuJbj0S4dFJnWTbBi+N?=
 =?us-ascii?Q?69ZeEMatAVD3SvgsJSy1iQ4/4NX2NNVa7NY33UdlvvFzmYkhPTDgIrtpU6jl?=
 =?us-ascii?Q?v+luB17aFif6iPJdHshwk2dU9I+nF9OQnc5CpL3UfEb/EyKNx2EQfDz0wHTn?=
 =?us-ascii?Q?7GxFYt4MWegsn55WDe1s0qUlFl4wdYq+xqAChvPc/3sdyVobpjg97BllSssf?=
 =?us-ascii?Q?eG35N6prdrvBITQqwp8hJlKr892FgSVW0+3FwEnygTXJB8Q66xu2Jaz5C5TZ?=
 =?us-ascii?Q?PqysiTHWmO6SnPqEbRbM5Fe7JsaAgNcL08FdPE9j4HsRxRjvxprMD0Wewx1N?=
 =?us-ascii?Q?LdwaKQw2uIYJ5oj8OHhQTekGnYrUeZHZoWRKFw9GwZVH3L0qN2BPS4gVe3v6?=
 =?us-ascii?Q?n3diMYxc0jMUKrlYMUsD85//uG/8w4pL2w7HPTqPUo64XL+9zHfIes+W0aSU?=
 =?us-ascii?Q?6bCLcj6+I81plMKjZYaxM1riZFNkML8X0x3wL+4lSUXrQ2sBZkhYp9+kEBrg?=
 =?us-ascii?Q?kBTMDuo/OVKcjaTmbvpU5lTvg6adXqhc+lkAFpr1v8SBauxp8TUnQMjhKZeu?=
 =?us-ascii?Q?Axj6bU5VtUH6otr6l8Jd2okDFdyUbpckZe9QpEaN8H5fPbqZmiV4qhBsRFOx?=
 =?us-ascii?Q?j4/ig5veWwXZs/FrLwo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83e8dcb-3bf5-469f-8609-08da62edbb1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 03:30:41.2210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCYjSwkWd/yAr0TxeIq+xaR05MpyrtPkUeHvffH+JCPGLqT3Twv2SMt1zuU0COCk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1627
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

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mr.
> B34r
> Sent: Saturday, July 9, 2022 10:31 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Vannoonnoo <mr.b34r@kolabnow.com>
> Subject: [PATCH] drm/amd/pm: Prevent divide by zero
>=20
> From: Vannoonnoo <mr.b34r@kolabnow.com>
>=20
> divide error: 0000 [#1] SMP PTI
> CPU: 3 PID: 78925 Comm: tee Not tainted 5.15.50-1-lts #1
> 5c320a339f0e397222fdfc9449eff04c0b12ea83
> Hardware name: MSI MS-7A59/Z270 SLI PLUS (MS-7A59), BIOS 1.90
> 01/30/2018
> RIP: 0010:smu_v11_0_set_fan_speed_rpm+0x11/0x110 [amdgpu]
>=20
> Speed is user-configurable through a file. I accidentally set it to zero,=
 and the
> driver crashed.
>=20
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 5f8809f6990d..69cebdb58c04 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1236,6 +1236,10 @@ int smu_v11_0_set_fan_speed_rpm(struct
> smu_context *smu,
>  	 * - For some Sienna Cichlid SKU, the fan speed cannot be set
>  	 *   lower than 500 RPM.
>  	 */
> +
> +	if (speed =3D=3D 0)
> +		return -EINVAL;
> +
>  	tach_period =3D 60 * crystal_clock_freq * 10000 / (8 * speed);
>  	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
>  		     REG_SET_FIELD(RREG32_SOC15(THM, 0,
> mmCG_TACH_CTRL),
> --
> 2.36.1
