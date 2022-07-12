Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600DCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 03:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E112E112DA9;
	Tue, 12 Jul 2022 03:51:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C713112DA9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 03:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVtgwDBywzTsbOvVI517SoSO6oFsQhsHyNkiZFV66HfzmnPl0piYCzyYoRwjKidLGDfNjNXkXNsrIyt86ttVhyOsGbbyU/sDiBqI/bE9HGTJ/2hoDW42bCM9OMAdOjpeGUYAxcb6RXtaQxxzTQqW7YsC3fsRJ1/2aNYOCUBru4qlixwwq38pB3saH26ozIz/Y5pnczyCqvA5Re+e/xro48WtGT3y2pDaTrmtVoTQebml7LFjfZIc8EZpSlBRQIvLwfigdmIFbG3SHdk+7ncot/fJG1IPnwwQpjxOUSRQb66Nt1BMVYWMaLdCzf/DMfREzorm7+J+2sKDB0aEXkhnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGJzT9OaKwgSrwe8muMwKB3GfPiLQUFg3scpO+E8P+Q=;
 b=WwRImtg2hdOQpQbA3uJJlyQoRYYL5X1XRBxBgcGObEiLEGxUFZrIZnPFRnlSK4kYJu7ePNo/hNIw6ixsrvuV49MYBFzb317h8dSY78epRZQXhwyqMYmGYxgZupG35+mAWSiZExV3bdP/uRDzAJ/IjrYf42SD0yJin1Wj6pLDjP8miK1AJWEBi8712KN+Hy+6XacNLM23D37LQIiNdiE4SOXHYmly9cibdldnfgantlHb5Xm0pEWPkrMm11R4JXYleJR3+gh5MjfOTdc5BWqOeBQClEfm7fpJlMhax+//41ZfDbirSmAGr7oh1m2AihJ6HC9rRFUWGWlKFPYrwzDs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGJzT9OaKwgSrwe8muMwKB3GfPiLQUFg3scpO+E8P+Q=;
 b=eW8grSDYtW60LM60rhAAYWjWjbtHCzZ6/BsAY8eUz4ZR0FfQriQLw75SFNmWbyMH+At4FgaV+8aaEEPxO41mBext92fIY3mr4aUPNzfKfu9r4YtW55w5k8RunBMirTy7e0LIk0rbclDPYLs14EDtcak8t28hLoeWBUOMqIM8e+E=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY4PR12MB1221.namprd12.prod.outlook.com (2603:10b6:903:3d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Tue, 12 Jul 2022 03:51:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 03:51:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Yefim Barashkin <mr.b34r@kolabnow.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Prevent divide by zero
Thread-Topic: [PATCH] drm/amd/pm: Prevent divide by zero
Thread-Index: AQHYlZVmtZVR9SzfukikkJjoI/Moua16GfmQ
Date: Tue, 12 Jul 2022 03:51:38 +0000
Message-ID: <DM6PR12MB26197A49A9B8215AA5A1132DE4869@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220712020106.46730-1-mr.b34r@kolabnow.com>
In-Reply-To: <20220712020106.46730-1-mr.b34r@kolabnow.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-12T03:51:34Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4d1e3bc3-ce7c-4de2-8a4e-18224209961c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f2e8e96-6aa0-4868-b173-08da63b9d2df
x-ms-traffictypediagnostic: CY4PR12MB1221:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHDe2rKROcPkBJXu+b+AU79cNmu1muw08GHh+FQoNQqcY23p8dO19WkEZU1uuxxfmcZauMOSElJMhWZcNU1+e+MZToaI5cSHWerezWiq4c+BIIRx/pJySXoRGb2r3ijkVyW5KKXOo4Aj2tIfIIp4kRi/vf9Y07WRFaYeoiTks+legjeOQJZqJX6NgUBe5k7E399r4VftlnBvFPenz08DU2UlqfT9rysaBbovIPcMvu6zhGWkKv+q0ooPTXzdbX7RUw3N6bPO8nA/XALVqWJhHT5tS5B0lnlU7Ex2vgTgMzkgWIwrieF/2PsELHB0VCJxomLlhnxgrwT+njWJgpxOk+j6MkGVJ2rzH2X/7+KVHWAbpSJam9dfLAIg56rqmujrKzZoB/dXSLg0nMqgVQkiAB+q+IGhpakvDNVGiHlePPul5Z7ulNVnLoU1xpsm3Vy4+MU6QWNf7/6eML4esM2tUVN37EJk+/6aqMwIrJ3GknWRmmG9znfOEJPYgj9c0+71s0klw2iYCxYEEshXo8M7gS0oYsfZTOOlAoBUcc4RH4Kd9BueqvhjfiVmp12+aW7zma4TQ4lemLxmUTopmDvIa67oT0n/HJxumDh0wA2EBhSImbtXLYYpjVhRFF5jUHr6PnJetdg8IkH+MWwSOpP3HMQsM64RhjD/MNOs15ZywNecGvIh7QyNnrNRadxZRIGlYH8IBMf9oz5UXEKod2H8+4T7D1sd2O8Q3BQNe8gDxSxRHi08/5WFTGBMy5yBfRCC0Pt9y24BtOZcfNu+0aGMi7Gwqrz7bMOuhRoE6d7TZx7zGoIOC5o3beKlvWq41k09
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(38070700005)(83380400001)(38100700002)(52536014)(5660300002)(8936002)(122000001)(64756008)(2906002)(66476007)(110136005)(55016003)(478600001)(66446008)(66556008)(41300700001)(7696005)(26005)(53546011)(6506007)(71200400001)(9686003)(86362001)(76116006)(66946007)(186003)(33656002)(316002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+akgAiUKYXksp+Qa0atnUX6PGIlY6nQb2PX3zLASx2fZTjHE61eBWnjqEuSm?=
 =?us-ascii?Q?p0SbJNoPq7rr+eOcK1r7cLPcKPwhxhAJt/c4mAsJIXgyI6y7+cmo4XOzxv6b?=
 =?us-ascii?Q?gjRGTaxYFYYJYxnbdkveqsuxp+agxPPnR1dj+rIxJte8pQaIxA3TKfDbj6Lf?=
 =?us-ascii?Q?KVXdoXELsdu3zuWiAQ27H0rQG7L6lLcwODzBsAIFnUkU906LNKvjtA9ldjNA?=
 =?us-ascii?Q?cV+Rtx6xuNVzz3JptLvXKsoqbz5b2YoJKqtkg++VZbE6zXcMaUafjiQnAAqS?=
 =?us-ascii?Q?wcLop4RFM1+gEBOq7Ve80R4KzT6zgdCMNkowg3zrsFUJnpnAf/u7926aXtSO?=
 =?us-ascii?Q?xTOohZwqfsZybCjOJ+c0ezm9shLYzT4ltGcX/lseFz3BRK6BY/WsF47660p/?=
 =?us-ascii?Q?ysI2di5tWyDW6eh6YLhuf0jxSj9MWN2CNk7+NhB5zY5jwMbIa4YdMaiGzvuF?=
 =?us-ascii?Q?JlH5EJz0zQKkfSy887t5H+G/gRSGFJais/urthDdEHISgTcn1QRJOM86h+zp?=
 =?us-ascii?Q?b6OONhsrdc2p2mEzbjZbB0hrTDvyiFeYrs34IDgHU3Hkj9o7bgL68Ao4F1m9?=
 =?us-ascii?Q?LVU9jawkXXiEgSqw3MVxSXq2Rrm3Z2d6dKsBdIF69va/e4L2Ae8LO30q0QST?=
 =?us-ascii?Q?tk9SJEDFSHRgyIiapfqiUk5BzV0/5XArPlsPMtgpDQEDJuYdHkHS3YsjVxKW?=
 =?us-ascii?Q?1Ls/KCj117xnTuB2G2sq0zmGSSCDXdYkOQolYLy+eCzx/bxFsEW2d24XE1ak?=
 =?us-ascii?Q?nq7U/WzmohVFsw3qyE7QsJcYfbDvo7cosMp+d95spJhVV2mE3jsU69CB82LM?=
 =?us-ascii?Q?D5smIUDJRlZWpbR9W3BAwt/gHlYHy1q38tE4CaKpsF4gadD4rOUxubZsMFYJ?=
 =?us-ascii?Q?3CG/k1W4BkNsibUiZPsldToj76H7Vy6cSiyY9f3DU/6EqL41ga0DltMQldpX?=
 =?us-ascii?Q?XyRGy4QHBRPCXhs/w4JxM6fXMZYaeibDTF30EXgfoPibI8OgBps9nphQJXaL?=
 =?us-ascii?Q?9hp1g+fvzgjnGbMOjgVlVHySe6xDUINHwx5Ea/P9CukIMY1LYrh2Kih4XZNG?=
 =?us-ascii?Q?PsF3VofaUtZFUmBJC7sKpq9wycl6dfruP/lXlj3l0fzeTuA4Ej+Oci/LifHk?=
 =?us-ascii?Q?Mktr4h0MgNfDkz/S3f3XXt9t/eoOyUd/9lnP/JQLPp2GRKx5UsIoElGQP2+H?=
 =?us-ascii?Q?w7BuWb9VtAgWoZRcks96qkNKvTYqdDj8Dq68BlaTnVc9oivg0iHCAwq2VeyA?=
 =?us-ascii?Q?i4Ocwnqsl8YXuu245t0HAjddFq/0GuhXAMXyqHLhpvaX6flMxDZNQmRce7LS?=
 =?us-ascii?Q?nuis/1Rsw/FI18nUv17WS4qL8bORwTrioeMzFQB6xB4TRmhUABO+uDnZ8Vs3?=
 =?us-ascii?Q?ep5uydpOXvsSXoFbfdqooaWHh/bIkYMDXYMAVOoLnPYPLXd9sGERoh7MmrJ+?=
 =?us-ascii?Q?NdduriAu4SVptkW3Rtfh3yp+rjBltjBpOh4H3CWGMIxqYLyGHb0IXse2yEkA?=
 =?us-ascii?Q?0JNES/aImNd7kzGVxeXlz3ADFrAcUxFTyofIgIvqt+W1ysUtk0nrWvx0GuIQ?=
 =?us-ascii?Q?zAyB2bPTtxiLBg2sQbg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2e8e96-6aa0-4868-b173-08da63b9d2df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 03:51:38.3696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: US70sJalpszZV5q6MKHpUB2YktlwyhOaXBk53WmZ/jHpOpkEzfwIz98iWlV4J0Ew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1221
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

Thanks for the fix! Patch is reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Yefim Barashkin
> Sent: Tuesday, July 12, 2022 10:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yefim Barashkin <mr.b34r@kolabnow.com>
> Subject: [PATCH] drm/amd/pm: Prevent divide by zero
>=20
> divide error: 0000 [#1] SMP PTI
> CPU: 3 PID: 78925 Comm: tee Not tainted 5.15.50-1-lts #1 Hardware name:
> MSI MS-7A59/Z270 SLI PLUS (MS-7A59), BIOS 1.90 01/30/2018
> RIP: 0010:smu_v11_0_set_fan_speed_rpm+0x11/0x110 [amdgpu]
>=20
> Speed is user-configurable through a file.
> I accidentally set it to zero, and the driver crashed.
>=20
> Signed-off-by: Yefim Barashkin <mr.b34r@kolabnow.com>
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
>=20
> Sorry about the mess with my name and formatting. It should be fixed now,
> hopefully.
