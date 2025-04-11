Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44CDC3601E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 02:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6B910EA92;
	Fri, 11 Apr 2025 02:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hna4MMuX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0560210EA92
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 02:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7JnK7eRJ1sNVb/w4Jlu0JF8mGMaEvo5M28AAbOW6BlfX+uRD5tyA7JTJq9tVJCodgFA4XG5vI4F1lj11QOq8pPOr41KyJep8QKbKqDZfvkveK4YTRXB+fSd7HKfVGF+OjGs41ys9kiT+5tKJtWx+hJ/TWd9oUPqda/oze81Ye1Qt1oOwI6ZwXWTVgz0EoGYhoi5D/Itd9Cpv1oeUv/s9k4Eg5uYzA5cQ/K6ppytR9fvbPXKcn3nYCnKjACqZKR24HBQCohRpAzy168cw9GCuTMeP05oe5bpwYCIa3xnY15mWjWt3bV7F+EGOo6hW+N7MURmTFmOAV0c1u34A0B5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljoIDCDwm7x34zCb80/SP7vnHO7oklPh0FlZy71e2h4=;
 b=WxiwTMHPgP7imtqyFLFrzE4+sKiwWBGSB79SsM4G1B1CIW+gApxA28Kv1gwO5m8gw6D7r2xNp1RXWCMi5caLenkK7anVXVy2FabzFfVo9yJQ6mMs/9sLT7QVWz0eqdkTzoTGMwBtRLT35X88ZjPth6qb7Msd1MSyw3TSw9ktKoQWIa+MVajqC6jnAvc1cRb5lT2yoo3wtDBZFyDYBHtJbR+Q5Oo9R9K2E6t0eWB6JPyQi0FVjewHAFfpo+CXMHp0kkdbSIuiGnrMBF1PcLwmKNx0eRcTilD5JNYymTM6StFGpyv/MsjFEYSu7WeYyqWEfuz2cS3oK104j9ChX4X3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljoIDCDwm7x34zCb80/SP7vnHO7oklPh0FlZy71e2h4=;
 b=Hna4MMuXXzOaBbZACR5nq5vRxfQMypY8kgY/sy5c0Rv3/JnD5OAQcSZDFHtUZizvF2Iqx8dtctcjhGRro+pQUiEv6R8BMJBTkb8kECadx70utw9RyB4ukQcAxn3CQJzlBsE0VdPzawo7laotWjIknO7lDW8pd28KUo5T9vg6za4=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 02:35:53 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 02:35:52 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [v2 1/2] drm/amdgpu: Enable per-queue reset for SDMA v4.4.2 on IP
 v9.5.0
Thread-Topic: [v2 1/2] drm/amdgpu: Enable per-queue reset for SDMA v4.4.2 on
 IP v9.5.0
Thread-Index: AQHbqFAQ5sw9SxaeoUu4eTtlF+ptXLOdwiNw
Date: Fri, 11 Apr 2025 02:35:52 +0000
Message-ID: <CH3PR12MB80747BFE12F685E1CA5A1F9EF6B62@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20250408063245.2270202-1-jesse.zhang@amd.com>
In-Reply-To: <20250408063245.2270202-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1aa5d893-89ea-4631-ba70-51aae3e83ece;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T02:28:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|MN0PR12MB6365:EE_
x-ms-office365-filtering-correlation-id: 76efea4a-dd93-4645-189b-08dd78a1942c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HoGo17y/j5DwbD1QnmIiyisssq3hgMBRLSTu/yKmeHeNW8uhJ1Pf5Loxs5?=
 =?iso-8859-1?Q?7AfDnJlaDW+WtkywR3Um5tc0i3uVJRDR4TpkNBJTzMIh2wyf6S6E9LDYNj?=
 =?iso-8859-1?Q?d+2aW7tKY94yk4aKIr4lyF+0QmFZ4ELsA1tC+DXI2/L3d67dlwZ3wxCGxg?=
 =?iso-8859-1?Q?PMOiLf9RCEBPFHxNM0DsUI2VxthzPBkbK1qtQlGS5R1iecjbQB+I7FI7Ot?=
 =?iso-8859-1?Q?baX0ice+h9wAg5DRPAA6UNBsa7M6F5VgXCw8wTKZdPEZq3H2YSvv/ozAan?=
 =?iso-8859-1?Q?sJt+5MA7z8Zmu6VftN0E8C6Qqav+q+qa6WomoinzWVl3QROFoBjtcSkmP1?=
 =?iso-8859-1?Q?50sRifcuHxHFfr45JPvuUzf9TQdgAu/bBNF0pqAHoOlOo+tZaSFXFCiTVa?=
 =?iso-8859-1?Q?K1V78nPokMRLUfdP0c2F9CwW20zRl9hN9OVTuWSByucileC72MdPClX1yw?=
 =?iso-8859-1?Q?Ne4U0OXidR8p5krhANqUTSdbeVdmf7jivwZ//3JIJxDlhQXAsOUgMX6fmG?=
 =?iso-8859-1?Q?pLNV5SqVeHFd5zWogFz5kbd64Wbx0FtePH4+9vL1Digez1MI4O5JVbPP7r?=
 =?iso-8859-1?Q?kCfFv51rzPf8axcjWl9aSI0LbgfbRqNlIwXN1VVcvqT/oirFb4zPcH92h5?=
 =?iso-8859-1?Q?nO+WUZAwu9o3HFlel1QpY1jq8t7PeRpxZiTmufC7H7ZuzrcBkuBsM/fBuA?=
 =?iso-8859-1?Q?2ts6qVk3xmAOKXa1Oi+2aJTIz+1aM7Sfs5fHr4LE9dqtktKqlVWJhgphp8?=
 =?iso-8859-1?Q?iKGNqHPfJmWYTqtzjtkFxzdweLH5KVTb3CN7ksoNj3+jnrClWz7DGz9AYL?=
 =?iso-8859-1?Q?QKHkchPpz4YWBx9FnakDqT+/+JUaJ4vsHmw5KBAQYKryBw9e4DRiXErjyL?=
 =?iso-8859-1?Q?XOc00FGSoj0OtSzEyd1MAwonPaaNd8F+cfum74KKbrcMeEmaizGNPhFtkA?=
 =?iso-8859-1?Q?4DdoJh2fbsOV+QenchV2/7SOEGufCuUN0tlen1iECEYUJ2uQtkuk8iCOtR?=
 =?iso-8859-1?Q?FXkUh83sjOlC9EAEdyGY4iotPcolFEaKi3409uREKfv2jJASfQG9iZpv77?=
 =?iso-8859-1?Q?MlKU0fiuF1+MHQemsZ4VfXZZ6I+XLSgCmbMId7TvOzKKH1u3M6JEK8REjQ?=
 =?iso-8859-1?Q?/iCD4ZjjaPFt2IgvB92BJ6XS5Mhxa3AIsME4juGeEawy+9rjQGSc1Ko6oI?=
 =?iso-8859-1?Q?Fe7fA8MJ/E2azdcXmP7FLigN6TiZvE5Ml88kXIWUOcU97TkKb6M3Ylf4xl?=
 =?iso-8859-1?Q?vtKPWNFQrpkXQgkepc4bM8ZQAMeZoMjRNclsIFq9kbQmI83eD1gPpjCvdY?=
 =?iso-8859-1?Q?Qa9V2DJf4TRmWCEho9MI5Uk0x2C3RRs2aB9lUyoXF2TZEB1kreiwJa/mB/?=
 =?iso-8859-1?Q?vwFSH8vjHFBYyZrfZAu6TVzwArBwsDUQJXdIX1I9H+5712XcOJ13MjYPlA?=
 =?iso-8859-1?Q?XjIERDG17Q8AyEXXn5ki5ppmyjSrrgqOFFt4UO0WeWVwemz7uZ9vmt0T4e?=
 =?iso-8859-1?Q?bi1l6X/4F5eSXBOlx7KjtY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t+FnFinaNSJxm5XqNXhcQK8lq4EW3EWMgphDTBZoQkTTJnyR/1fOCqBpBA?=
 =?iso-8859-1?Q?LPq7kg40x+7m4j79wg00IO0993AScxAJw1HEswVB0laDLZAgnncVQ8wK5+?=
 =?iso-8859-1?Q?GNuWwU0YX3NmeazYBGS37/ZW9T8c2mVLBYLsdWZpLuDun+HInJu3W5JXaf?=
 =?iso-8859-1?Q?/C864pjyK/4CnobvN1IV9pKx3DahCfUdVDFkgrTJMe0j8giOjIDiOQRWFi?=
 =?iso-8859-1?Q?gcxl9hnuIVT4aomF5u3SSfPVhNLfigXYiOSAUy3AQvGgnO0oLjuDorhYnO?=
 =?iso-8859-1?Q?Zh8SVCTeDOmtlMm4P9UXn1x2We/8YN4tyzGLHR0TBgnjejNICyVni+D8PU?=
 =?iso-8859-1?Q?texo2mFX6eyvYylpAE034kLwT7Uj6rc4XCb8xiujW9DjnwY2X42R/fTXUS?=
 =?iso-8859-1?Q?OmCuvDZeIqIMrMpPbKOJ2F31q9u+0AEUAtB36G4AYvniJN6Mgx6khPSBOe?=
 =?iso-8859-1?Q?JJaGAe4wnN5q1K7WkhJaqdYCHe4AiXjoV0VSc7KpJcLk9Drs6LF7BVgk1G?=
 =?iso-8859-1?Q?hR3Gzyv9W01xT0A3FkFygFe+WPdRDsj4kQek7xSSJOGzRYzaBC2dnsm6Iu?=
 =?iso-8859-1?Q?PKFFB/oheQSYFgvdGznCS7jlUuPKyhjXJbQd8Bjxme3Lx47tfbpY7c48qR?=
 =?iso-8859-1?Q?cRnY/bj2f9M2xJeON74zP7c+VK48UwMY6mqX6AcZJU56n9MWG9eMTvcR+Y?=
 =?iso-8859-1?Q?ULIwveLQIeAH/4KZFVDJuUnSzEPEd5d1mi7NqcQ9mMFtUy+pcf3iSs7QFw?=
 =?iso-8859-1?Q?SgPoATRKM0NPYDIuShRpSJgivDVtHNnW6otmKBY1+dqCqj24mILsvcD0j/?=
 =?iso-8859-1?Q?rQRJ1nT3UtaLPFDZ6G5xZ/tjD+szwlaFSrZfTdB8xet3wwKYaAI2PkWjWj?=
 =?iso-8859-1?Q?jctVEUWQIOLBA6CQKCbFQS3qbkK2PzTm2optUjTcb3hHUuGOp6Wx52jXGT?=
 =?iso-8859-1?Q?1u+lout1haNpCVvqz3sMfdqQBqTA0A+Gm1u0t/4wWNiIiV5bGjIvQ7aiAy?=
 =?iso-8859-1?Q?rxgmgQv3qjSGrYP9ChcOkpnEzrsdE/EyUNkYmgt7ATokWePbKRWNcAeg2O?=
 =?iso-8859-1?Q?ptRlUmKiPDq28YTZiu5hI9PQngetfBqw/a/6oiAFVeeD79rvfUBnobNLFn?=
 =?iso-8859-1?Q?3UtcEH46+tddkD7czUBIArmkT+3+1ZBvDesXK1MijtCfcJA333yEGl+qVZ?=
 =?iso-8859-1?Q?AUKfs+Jp9g6uTikl7vdm6jaL7ct15J39/+D25rVv6i1j7SsQrepeHqZAwt?=
 =?iso-8859-1?Q?eYttJc/HoBlOHUAhDVyKKSNl1ccjDO0cTVKSoL5fGF6BVil7s3m5tPlW9X?=
 =?iso-8859-1?Q?orygd2enHP+udFS/QUEVTuAJGTHPQrh8BVGSZekX2dLYPSo+70J93Rdo+j?=
 =?iso-8859-1?Q?rwd1n3kNQr/xMYz0MxyfrdN4n5i/5RMoO1wB5+LBv1Tqb0S/ynYWc0Sklp?=
 =?iso-8859-1?Q?9hwj1b5skzQz4ZCmqHOKmvciP4Gs8MydWKJ1tBbwUE6/a73DhHF464KNb1?=
 =?iso-8859-1?Q?XO/yCx3iW7BU0zUMJfMMRdVOd4bgmJUTkV2fr9nqWkPNgqQajPiSBhO7qN?=
 =?iso-8859-1?Q?F7XxQZ+bk7tTMLHgJ8DLOQ2mxBKerLgCqGCD5rlLPuWfp8/ypZyqa/bGtb?=
 =?iso-8859-1?Q?duVQl6ZYJb4SY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76efea4a-dd93-4645-189b-08dd78a1942c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 02:35:52.6890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJa1OaJ6Yvrmp8LN+K32DVajhMkQNVbIVQK2F5DUEW0eaadiURmrksqihS/+16fYMPQwSRuW9rM56wY0h8Wfjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Tuesday, April 8, 2025 2:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang=
,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [v2 1/2] drm/amdgpu: Enable per-queue reset for SDMA v4.4.2 on I=
P
> v9.5.0
>
> Add support for per-queue reset on SDMA v4.4.2 when running with:
> 1. MEC firmware version 17 or later

Please ensure this firmware version is aligned with code 0xf. With this add=
ressed,

This patch is,

Reviewed-by: Tim Huang <tim.huang@amd.com>



> 2. DPM indicates SDMA reset is supported
>
> v2: Fixed supported firmware versions  (Lijo)
>
> Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 688a720bbbbd..673ecd208c6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2373,7 +2373,9 @@ static void
> sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
>                       adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
>               break;
>       case IP_VERSION(9, 5, 0):
> -             /*TODO: enable the queue reset flag until fw supported */
> +             if ((adev->gfx.mec_fw_version >=3D 0xf) &&
> amdgpu_dpm_reset_sdma_is_supported(adev))
> +                     adev->sdma.supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> +             break;
>       default:
>               break;
>       }
> --
> 2.25.1

