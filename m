Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C60DC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 17:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D727F10E1C5;
	Mon, 24 Apr 2023 17:22:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41C410E1C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 17:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0Q38ZN+ikdYiTVWuF51g1t34dh0AWC5Cudn/7xVKi21xqT5UWOnmSaw4vmU2jtKi91z36iMte0EeZR+MXe0Z9w2n5fLKcHR3Aws4HxKAuJXJLTvAoheQK0B2J1mqEBliJ0iByAk3toHNtUZXO3FxLajpt31EAfIu5XtXNqse9ZYs6ooKOhUbwxlfcaWu1pQdS85MalXXFyhdT+grulXehgGjYkb/X2e8bl9cOZzmjsvfFYEPRLzp6R1VOMXCu5ZxwcS6pNXvU2iLapFZQbs8ua4E/0AtK8hXFq+/brKzj8XHtapmoD0bdIiWfuMCwl0w+5ceKO3bikZTBZg9Q3oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypagoEDlnIW2c8EhsXtJhtHmxWoUMfCLi1cJHym132s=;
 b=WVeJwLc2FumhoUY+QROid1d6i7I4Bg9UgAO5Q55CsXXR3SPb91aADKaxJltdhaqblYmgzq4TCGEqBZb5BZIAgRZD/r88BxYN/aP4Gpe/QlbE9xOVIWaWlbW7/NknL7jw8x+i4N92hpNGa+/zwpbfJosHR4YBTOSTrYs19cyx1aRoLGaIJAWy6HcTXZXKcFr8KWoEnNackQ+QuxnYSdMRuHbfuZ6ve2DpNHjjWPF5ak7feplvMDvyuvmcK03RYuKASoEM9pcIa9CSf0sCZYIqWskxcmNqSQ7rRWgHAWEzH7qnZ/tIwvNDqla2ox/omJHpoUoW0v5JdSCDnFkAsczmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypagoEDlnIW2c8EhsXtJhtHmxWoUMfCLi1cJHym132s=;
 b=I1rOdKFk3SVnnLsTbXt/1f5rVMqy7lm7f0VsiBuJLCFlUIy4nKeImWm3N3N6AHirX+3dQdPj1gO6ErcNQvkF8E4X1owVKMBxOZbScFC0DQV+e9Ynuosl9WvsfGkjiNYTyo5z/LfnSiYwh7HrF8/J2RmcdMKXLrcaNbuB5yRjSkQ=
Received: from BN8PR12MB3348.namprd12.prod.outlook.com (2603:10b6:408:47::29)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 17:22:02 +0000
Received: from BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::b87c:1211:5529:f643]) by BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::b87c:1211:5529:f643%7]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 17:22:01 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH] drm/amd/display: DSC passthrough is for DP-HDMI pcon (SST
 pcon).
Thread-Topic: [PATCH] drm/amd/display: DSC passthrough is for DP-HDMI pcon
 (SST pcon).
Thread-Index: AQHZdLraI9mgkNLDbk28WFNBFFBzgK86uMbQ
Date: Mon, 24 Apr 2023 17:22:01 +0000
Message-ID: <BN8PR12MB334883191EE89FC13D4921ACE5679@BN8PR12MB3348.namprd12.prod.outlook.com>
References: <20230422013600.553498-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230422013600.553498-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T17:21:59Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8c433b01-e764-4526-b9a6-926b52b2e775;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-24T17:21:59Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 2cef036d-0791-45ae-8130-d8391c4496ab
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB3348:EE_|MW4PR12MB7264:EE_
x-ms-office365-filtering-correlation-id: ad6969b6-e71f-4a51-7790-08db44e86ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ayUey35bfkzSsZ9uNwl7S7m9YVTQie6EVRLMDZSeeg7gNNUSoR/RbOQiY6avJ1seXHYmcQw39kicqPoFFdxsYgqtroxq2wc7ZF4AdJ2EiGo/oaht19FAPdEyQcowmzbijzqPzGfjlczsgAI66k18fQ4MCqytmxNVltNSNcubI4FXhDpcG2Filee8eiZLnN4bU2xsB55GcMCx7YleCY42x/EHA/JtAKK8sM2C+c664Vf6Ya7RIDv18VEAFjJADmcnuM0zRiZw9ZoSxQLBvJf9oP6zPHq0jIi84nYm1kPijAaVvfbkEaBlo5ImzglKLRf9dppR6oC094AkxYsbKhATvC+b0ojux0cQGsp3kO8auOQDlx8MVwxJ3ntwjPF9MwUJXftlkm8JDL0jZkVLTmFouy8g8davbuzHlzrKuVxKRRZFmz4jHoZrmKjvNVJjYNpazSRvEc4WLx1ujAYADQwvkxm7f1PC6imV9x/sL0PUemM7JMmoxZkSISS6dkF/pG8qVBVU/IAfbsEzQ8s0CkvAtBGU+98ENMKkviU3RLURApbCd24P7I5V2z2vX8ASBS1fIBrqSXWYHhPqED/ig0XL8hmchKc/xIzGG2vaQsQGjZENz3tFxkK0Dk0IwFXUf9zx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(2906002)(55016003)(7696005)(71200400001)(83380400001)(86362001)(33656002)(8676002)(8936002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(316002)(41300700001)(4326008)(9686003)(6506007)(26005)(53546011)(186003)(38070700005)(122000001)(38100700002)(110136005)(6636002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pY+UAgINlGhDkb+S4rmhoTyjNi2tWljZx/IM8nkdU4C6MQ8vBUNW5CG0sNqP?=
 =?us-ascii?Q?IjZ+U1Eh+aYrGCL1BIXLzlPm9Jbk18XCZDWqItHZCrCDdg/aT/Ql7BAh9E/A?=
 =?us-ascii?Q?hhi/EnD6Xnzs8ViW3PWbWfsx57795X3bujoEX27JOVRnIpwNZBbj3DQ52H0l?=
 =?us-ascii?Q?5r86HKiZsc3SQXu0xrpzDoWWYJwUXCMCP0wWAMO0YuNIZdBjKhekkEwkwFM4?=
 =?us-ascii?Q?bd2MVU3YMlHFjxK7T8JLO3A+L1vv+6Laabk+7WBu/gQtTiLpq2rE7HrFEOBh?=
 =?us-ascii?Q?EU7X8n6nuTkWe9f7sYLmG70ol4//BZFn5LwmAaL9RIiqCkB5Ly+Tle278YGz?=
 =?us-ascii?Q?cIcKYPiQSIkE7zS8FQyXioBXsvcWdfuVWpBzJ2Eac1dKKzm44gOJBZydiTgP?=
 =?us-ascii?Q?Kyw7jcS39kpZxbnl4VH4pk/24i4JxWUYo+2bmk/VePCS0TZog/aEJRAFwtdg?=
 =?us-ascii?Q?zqBx+K4stCv1ySn36fj9yW9/mSlj0pQya3CkNgUsvPol3oBX3qPwqvJwovRX?=
 =?us-ascii?Q?Ll7gM18v8aWgUZ3sxq4JU/GtabxpzDIRDuRPiI4agEMCo7X5avxb+zHzp+/h?=
 =?us-ascii?Q?4kdrNB6KQdWNiS/MwbVXmLBjmYH18xeGm2DkSP3v9OVgXijKyBBvjLomIuNr?=
 =?us-ascii?Q?4Gmyp4TkxG7aapadf3nysO0PQslSWlO4nNHccNqOa79N7b0JnJ8H+WPPk1XG?=
 =?us-ascii?Q?7fazReEp6w1xO0zEI0tBY9GVRwcVwHbBlG+/tbbh885jJPFr5bZSiRhNPNl+?=
 =?us-ascii?Q?qkuGi3aBIBFyGz3sTGc23EI9sQYSTBgWteJBcs58y/Dqq8rUoZdWeAXnfciU?=
 =?us-ascii?Q?mOGGDvNzzQd8t3OeIs5uiSgQ0Y4GNh0ozZXMzjHc/HRpcSLLH0nseFMXbgYD?=
 =?us-ascii?Q?tElLygR60E31daeel6IqyOKIfNT7Gp/2w125bu/XJwZx3XzTp+Ym47uLs8If?=
 =?us-ascii?Q?xeUF3j/iMK7f0jpJyFSFdbHzB+BU5ZXMXZ+YH8OfCuKW9A/rmIt5eXbV0PK5?=
 =?us-ascii?Q?ADdQgQ+rIRIZTlbK1WH5XkqualQsLsTzfY2DDBuNDFLk0rreUILKVGwtm06H?=
 =?us-ascii?Q?HxOYfwOQbAph5IfUhVoWpjeNNexGwDn13r/zsKjmdbuAJ7QMCe/37ufvf6VN?=
 =?us-ascii?Q?Ahc/tiQ3PHywDKD7xOuNBfm5XW8yP2KUn3AP6nsHsKu9ncL4rCIjwW/3DK/I?=
 =?us-ascii?Q?vyIbqyKN4/2Z2ALW5rD30JZq12HGEb6OVucOWiOA2CO4/NtgK4tE+PTTPAMS?=
 =?us-ascii?Q?9xi+O8nYUDIhG+MqL2u2qKvEh0KHT4giyJ9HEBoZbPkrUPph36EIf9dq9TLW?=
 =?us-ascii?Q?RkAFWzqtFTsAmAGMyunIwAjQRVNDzohkUanmMExXAcMK5CtSFfWerJs9m9OI?=
 =?us-ascii?Q?3tc5kU3BoUIty2VVqDaA0mPZ07SOuTBTOW4eTxICWhbNVDRI0bMRIfKtR96M?=
 =?us-ascii?Q?O/++u31MFTMxg2AhHygdre4l0eNJ6U/AqbB4p2mxP+omdWkLay7TivzYTVaV?=
 =?us-ascii?Q?svTjSkN20Kius2HaYyd9e5YFwV3PQkwFF92T3LUj0Px6yXS/ilmcnp1/PvVM?=
 =?us-ascii?Q?BXy5/Jz8tdmKbxzIUwU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6969b6-e71f-4a51-7790-08db44e86ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 17:22:01.7243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbXM8D25d7ID08jHl3PYaEbD8i8zieRCXCxPG3zlAes2pubu0oKov7dAgVYmrztq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Friday, April 21, 2023 9:36 PM
> To: Zuo, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>
> Subject: [PATCH] drm/amd/display: DSC passthrough is for DP-HDMI pcon
> (SST pcon).
>=20
> if check over DSC passthrough is removed, as this is not for MST use case=
. It
> is for DP-HDMI pcon use case. sst pcon is detected as sst not mst. In sst=
 pcon
> dsc passthrough message will not get below log printed
>=20
> 'Fixes: 8dc5bfdab0ecf ("drm/amd/display: Check & log if receiver supports
> MST, DSC & FEC.")'
> Suggested-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/link/protocols/link_dp_capability.c   | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git
> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index 84265dc66bba..577f74cc50fb 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1820,9 +1820,8 @@ static bool retrieve_link_cap(struct dc_link *link)
>  				  str_yes_no(is_fec_supported));
>  			DC_LOG_DC("%s: DSC_Basic_Sink_Support: %s\n",
> __func__,
>  				  str_yes_no(is_dsc_basic_supported));
> -			if (link->dpcd_caps.is_mst_capable)
> -				DC_LOG_DC("%s:
> DSC_Passthrough_Sink_Support: %s\n", __func__,
> -
> str_yes_no(is_dsc_passthrough_supported));
> +			DC_LOG_DC("%s:
> DSC_Passthrough_Sink_Support: %s\n", __func__,
> +				  str_yes_no(is_dsc_passthrough_supported));
>  		}
>  		if (link->dpcd_caps.dongle_type !=3D DISPLAY_DONGLE_NONE)
> {
>  			status =3D core_link_read_dpcd(
> --
> 2.25.1
