Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 03:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFAA10E651;
	Mon, 24 Jan 2022 03:29:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E2D10E60A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 03:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2pARefdTHOktOoH6SEixnsEE9G/1PKPVdEy2oRZD58qKWZ+ptJEVWfJUwuxmriQRWbLexk3miMygo1l/WplfhPPXVXkW28VkA9hi1asrJLL7TlbqclafOQEUZFFpRluYMd32sgwaUCnmzAIWzEwCda4sw67g+zao7rdiqAkLDO6iyihDQXPR8yboVR3szlmqU0MjsarDytgAR36leqRiZF0Xew5MI/lD6vYmgAbtCZFqO1cQ0Xqy+Ud5y2Lttv31pPI90ViGWoiN4sWD0WKpW8xM/duZ9KeqFg07jfrW0P29z2s+g8dXd+TIHj6R/U0OxMbC+NSvKxAqSp8zGB42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzPlGK7XzirN2sNEoAwpIlYTB/ZrcHx+aXGHy7G2eAQ=;
 b=l4H+WTrlrc0s4Z5t4DYas1j+kFeBEkgC5//0lYOgXUJowhPfiWPq1qyVg61rdAOENpFIjxirm+LT3qYq6f28dRQYHyZdeTqNnnYkWJRrgLRcz4ZL8hxTGNokJ00Zo1OUHQivetbOswA3Fq6OXrlz4rK3g3k/jkf9Swx+Yu7A6vaPg38Oq4wg3q3jXhcHKAz7nOmsCzY7K3jLttAciwVtPzOdTyr9jZDROsNHIrfHd+GBeT9eiRgqwACbWKRevTHY2zTUME15EtAyBwTyJ+XmBZ0kTvxIksV+gd2onYcoD1xlLpifX5iNzrnJFOcLqYuS5Hq+LvbGtIEsJmegtDy17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzPlGK7XzirN2sNEoAwpIlYTB/ZrcHx+aXGHy7G2eAQ=;
 b=l4+PnGaTVJNKEdmwq5th2gljPH8456SSfeFetYwuSQ9BymzyYAol9SjcPkDNWoI+mw7WbxWu9/SDvjWzKCi7gCaRG6PuUI3YD3reK7YYPE1N6WR243B2ZRsRiCd1DgAUE+LtJlzvFHHNfKQBp6XIbp29mkJ693Li3MdC3WxDEik=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN6PR1201MB0209.namprd12.prod.outlook.com (2603:10b6:405:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 03:29:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 03:29:09 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm/smu7: drop message about VI performance
 levels
Thread-Topic: [PATCH] drm/amdgpu/pm/smu7: drop message about VI performance
 levels
Thread-Index: AQHYDwSTWmsECsCADE+X11hsXEMKhKxxhvkA
Date: Mon, 24 Jan 2022 03:29:09 +0000
Message-ID: <DM6PR12MB26194D75537DAFE43FA3B703E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220121202136.5541-1-alexander.deucher@amd.com>
In-Reply-To: <20220121202136.5541-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-24T03:29:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=37d29521-ee5d-4656-b4e6-88d3035e0811;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b2edb22-6836-46be-f406-08d9dee9af47
x-ms-traffictypediagnostic: BN6PR1201MB0209:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB020945A8883650F75930FD42E45E9@BN6PR1201MB0209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBaJYl7EdaMjod8GsdLcBkTjP9CF5W3JBiGjlmiLTBRiTwndqDeqXabUditecTJTiLCYAYqaudHW8BgPpsbpUCX/BAWwWebh0kXfW171NRckNex0lN4L61BHGg5q7wQs/0Ji6lAWe8L2w21EYqWB8nauWTGjiYHwS5DPr/9Z0+IvLW3n3r6YaAQUCZcEUhgRs7oaeKLuU7YoY+LZWsXC9RvFxP3d40arc6Z3F0QPKYGB3gtDgpvfyiIOrlzqvq+8ZkG09YjXc2hdiwQ+C0fIOwON2DPWcrR1NNjNZlLZDcxKyn87Bt5XHBXmtI4/IIOucK+bFLxNK8uUvPwAE8/5pOtqwsO4OM7QnPNgw/qdeFyvPtM/BZnw7R2wzgkBNETEQelpQDEK/PZqi5WxzEmNKlGmGrmHrTluazNiwANFsMkrpAFEX5U8ipxC3PAE5zY6PBgBuf7Kp7J4lFn24ZJzlvUk0B1yTwY37rU9+gPK+pLCq0fOVgE4ApXWEKJNLkBD+p61EoXONzZb1G6L1HJBSyiWBDDi5UX6KugRyxagHMXjd3JyWic7WiYD8kFi3OsjqjLAdImu06JVOfEiHzIC+fOIoTe3aqsMstV6B/ck+x0EtJy5OpqgDL04gI4B3JZ9Yi+QXX6lrBRujvVHM5IvIT1UFLjGUlfCcTXYuDlEck3t9eeEMVxTL0XjlEu8Z+OoBDoWi4TRYiIlXiJlwW6RNBViVWYob63bqOT6UAREtK7m8hToe5TqpkjyhJc5HnXhqFDvGa0Mt4wT+yxoUhe+3V22C/tpXP3G7YT4+wgpzK8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(66446008)(110136005)(7696005)(2906002)(64756008)(66946007)(316002)(45080400002)(966005)(5660300002)(55016003)(52536014)(8936002)(33656002)(71200400001)(53546011)(6506007)(9686003)(38100700002)(122000001)(15650500001)(186003)(508600001)(26005)(86362001)(4326008)(38070700005)(83380400001)(8676002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hp7Jqz2Ly4DuvxI5U2PePExDQj3le9dltwmhBcGWzBVqQ2vqovwToc2lCHLD?=
 =?us-ascii?Q?cXgzeAdH/OO6pRznOWA6UZywxPayEvaj9m2jQ0NAeITqsr2hnVTEkJvwXttw?=
 =?us-ascii?Q?IhSWP23jiyEkMDZKWmsfpcQ8o3hDh4WmKRrYdMNaMOU13M8yvA03dIk2fFtf?=
 =?us-ascii?Q?U+YWEOKeIUkSFUwpAcjo/EaPeLlutaDD4VsJgyX5UynCinDhSAplDb1H1XZa?=
 =?us-ascii?Q?Xc6F633W1gRAHFgwOE/+Q9WIEslloHKd0ma/SiUY54b6folEIHjg36jmhzkJ?=
 =?us-ascii?Q?KSk7mTZX3nih4eTabRS1USYT6zFGz3Z9bNgIOezTC6qN/m4Hnh10GV5TIUQe?=
 =?us-ascii?Q?3nwqJ535sPIXRBY8wStxR/FeGV2UutGdb1GQAGQswD1xZdOrT1qwXQkbloG3?=
 =?us-ascii?Q?NTOG+KUuQTb7Mi4f1lqvVfZYmT4sliKJFSE7LqMhWoBsrw4sroj8P/Hzf4OP?=
 =?us-ascii?Q?Z4uLclnCkJVH43aoToEnNhe5Q9+IA2BHAhuZf1yaO1W8dN68VJNJQcU7LEKL?=
 =?us-ascii?Q?JVAmO5Y0EtpC+k9ACm1tD+saDDovBN9yzTFZa/8K3JklNrfjH46PQH3yg4Au?=
 =?us-ascii?Q?jqvC+SDAzyqv6D12aEBtD1YKhzMoO8xMDPZvVaHZAcroEIR3hqjvo3n/hECj?=
 =?us-ascii?Q?85sesugZL9WbQ9nO0FrzEriaqUAix4tY7nJbQq9VNIOyWdcnU/N+sKvU3ZqA?=
 =?us-ascii?Q?sY4sZI9jgIQm1e3+n17nKyvJnKAdNyL8nR1AGva0qMbr93PsCvyns2hRgtmM?=
 =?us-ascii?Q?/Bwm7H9FujoKzgduUJVlxAjVayee5+ObRGhcGS0bNzNZDSjP1tp7RDPbwZqR?=
 =?us-ascii?Q?9blGGah0MBo2Hm/Jh4+zShZAzVatWlPEOofEvAMT9OA1XaFOJb8y1ll5Mdkp?=
 =?us-ascii?Q?ARgq5Ncc9sFbPTLixG0R3bksznze0Uoneu8qNlM0Tt6Or2t6ORPvMyiOgxg7?=
 =?us-ascii?Q?+CGxsDy/z+5YABRxbnIQuorjNTcGedZQIqQK+xMFDhaCvCyQEZfd4ZVQWYrZ?=
 =?us-ascii?Q?sq+iOv134TK7B0yiBa5zeISKIEbzhZDLuBNPUFSCwPzL5v6/U6F9zw9eqKgi?=
 =?us-ascii?Q?02wP/AhwSHwBqvCDJDLG1yvQSZ3v5LgmteTq/q2IwiryREJr4qXl7NCBm6KH?=
 =?us-ascii?Q?fByVJyEOGxPqrA/W4ak4WhPEzU96ndrrax8YlznuUEyAJ0s0wXZlUFJ1dpqR?=
 =?us-ascii?Q?6hC+mWGjZ4M+LGDhLSpKh/+OtmO2TVy+D+zW4ChC9uDKGvXVx+33pYP7fOh3?=
 =?us-ascii?Q?gw2upmerNqPf/OdMECZ02S1ftABYGHQdBiANJFd18BS+lFiCrdxJg3y9aXfn?=
 =?us-ascii?Q?ipTcb3fdmqoP9jD2vwLvtOMDT3WT4OynkArKCsp2wNXhw2X0Q3NbUGXQGlVj?=
 =?us-ascii?Q?CT1kI0Nuqjdr+aGdduxhUpgAdrPF6ig+nLULh6Wj+gq/GcuRVX90F03Nwg8c?=
 =?us-ascii?Q?xWH3huRtpI1L5pclP/XSKCTAk0+u6Nf6V5M1DqUdEMN4+FMBP33q80qPB2L3?=
 =?us-ascii?Q?fwzDTuQh9KTzx2Tj5qjay4014I8YEEGtihIHVipTTOl6Ht2YE8hgcW9KJyS6?=
 =?us-ascii?Q?J4k4JPiS9OPRoWrefkw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2edb22-6836-46be-f406-08d9dee9af47
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 03:29:09.8172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YKVD2CemNHVW3ggVk5Py5VF3l4Tr5DLhbRtetFNFJxA9jx8oKkd3NCWivJUOKiv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0209
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, January 22, 2022 4:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/pm/smu7: drop message about VI
> performance levels
>=20
> Earlier chips only had two performance levels, but newer
> ones potentially had more.  The message is harmless.  Drop the
> message to avoid spamming the log.
>=20
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1874&amp;data=3D04%7C01%7Cevan.quan%40amd.com%7C008
> 496779cf84e3eb9bc08d9dd1bb44e%7C3dd8961fe4884e608e11a82d994e183d
> %7C0%7C0%7C637783933331038923%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000&amp;sdata=3De53W24tcHU8hRut26458QE5v%2BrTk0xRd4eTMxaFn72E%3
> D&amp;reserved=3D0
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index cd99db0dc2be..a1e11037831a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3295,10 +3295,6 @@ static int smu7_apply_state_adjust_rules(struct
> pp_hwmgr *hwmgr,
>  			request_ps->classification.ui_label);
>  	data->mclk_ignore_signal =3D false;
>=20
> -	PP_ASSERT_WITH_CODE(smu7_ps->performance_level_count =3D=3D 2,
> -				 "VI should always have 2 performance
> levels",
> -				);
> -
>  	max_limits =3D adev->pm.ac_power ?
>  			&(hwmgr->dyn_state.max_clock_voltage_on_ac) :
>  			&(hwmgr->dyn_state.max_clock_voltage_on_dc);
> --
> 2.34.1
