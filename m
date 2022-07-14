Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8DFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 09:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B332FA2CC3;
	Thu, 14 Jul 2022 09:44:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E3CA2CC3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 09:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldI2gVqGIgoIrapvww4euarpVHDn9TXTs9B4k/mjrkFNY4O8S2gtkKW82HHQg5ujkIz3IJz+U/hF803CfrZphQS+iBmw9CPzIx7+IMUHWdhqquC+oGqg/CeayM50NqdEiuijtm3+nKD+jR4ZX7wJ2z94sqoOPmXCWP2nptU1LQOtZHjAgBSzqywB6Cc9byexwWZSmWt8OYaBaXBCE3znjEdLXjkjnJawewb5K6pQnPHDXZdyWBpzks84vTX9OEhkITj1zdREN+0Tpf7Cfxp/EFJ7M+Q6ViNTvEpl1EiQsyvR9oLmK6uQWIcIRVKSHmW5cS1EZWm/MZrFN3n9+tjmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkVQaBDkZ/4TRgPYwLVvZPnFLulp9EbebmTKU+1UKWM=;
 b=VgkTQ8dX6XDIIX5NPnSfpNgEB9UJ1byR0R8A5O7TCiidqcZOvem2DMw8zwFpmMpU6zcRDN1H8cQQ3vvP+YWLmXofHlsHmXSX3uFvyrzVCTzPNJTwjlSnh5yQYxq4Tx6Z6xyXi6gevVn7kerR5dAAUlX4Ucx6vLAWVAm14fEHnNk/zKcVb7LJ1jC/ERGJGIKh8pcCPUipvRDc2jhI/zQBQF/U4Ytn0Ljj/nwM8PPMgui3pF+McCGjQ4pqC4/wvA+lTFjLQsbkiuuqxPp0yS5K7xpInvowtYyHng5hZ0nMYcYLt+dN0uKrohASkF/6+C23gpM7LrqS72S0MYvh5Y8gPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkVQaBDkZ/4TRgPYwLVvZPnFLulp9EbebmTKU+1UKWM=;
 b=r+HMdJ8/+tGYyQLQhmqbnLX0970kh029iBr8l2T7l7gxwDnelnkiV3Gih/bM+Wy/DdMUuEE7u/9XmrFDqZkIeRO9LWNgN1KzE4e8hnTglXqgKNjXyIfVATC6IC6acKfmuAcxRlioqcGpKBNYE34vkkH/OhtMP7Gz5WwuCjPcpMo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN6PR12MB1139.namprd12.prod.outlook.com (2603:10b6:404:1d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Thu, 14 Jul 2022 09:44:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 09:44:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: make retrieve_dmi_info() static
Thread-Topic: [PATCH] drm/amd/display: make retrieve_dmi_info() static
Thread-Index: AQHYlsxYpxGYCsoB8E+/K6d/6kUP0619nvRw
Date: Thu, 14 Jul 2022 09:44:24 +0000
Message-ID: <DM6PR12MB26197070637B45C055BFC832E4889@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220713152124.623903-1-alexander.deucher@amd.com>
In-Reply-To: <20220713152124.623903-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-14T09:44:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=91f0165b-7e3a-4a35-9c45-3b69fd97a346;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0103058-64ce-4fe7-83f0-08da657d6fc2
x-ms-traffictypediagnostic: BN6PR12MB1139:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21n5r2YO3ZZWe0TXpAql++0dRekq8L2e9RRFQZoGkNMYXMsWPYAtSDBCwegttt7XPOrLi4ueB9rClJkX818+OnCOUNnNdH2/SFFflMlZ1AbH7Z/WWay6T2gvMtJZK9WxmVcC+le071EqvafAYJdEbrontydBpVnNPfNlLYyQDFJGXy2iqY3Drcosa9EYFHwFbq1OOoB1nY1JGnnQsBqwFkVyjw8jfbazlo1AiUWzwqWfkOBZksV/HSCxMJvHjMMdh4Lw5wic/t6Iud3V7GfhnN2El43H7YKVgYcVxI/xwDEZloeoGsCgKrc72l8Q83cToLGAaFzeAIpPHrKYAn5hYIPjlMLiRLZqXDfO9Aa6+j3YqWKwNsaYWCwO4WBtJbncaMFlQ4cYo2LnvcpuPymyoWkIuKmQAMUKVT+Qshg03uFeq6PkwU3845FMdT9qy8h1suZG6oOD+kxgQ13Mm8pRee4DLcUQm93kj6b4mC0OqYxkkmMAvIc+qyhstxjuZ/W4jllqKv+WcxvBi+8GR+yHmFhwSbb15PJ3WGghIH/na5QOFU8IhtNCLRQhATPaUfdHh9iA/0nBFuXtbiw33WfElBumZH7TA3ia0sLuBP0ewvt4YYVswsMrilsFlyDKafD+ZkvLcDnAsY/y4I/boeFXnh7wcXjRUCQMyKgbiYcb60wVk7uWJHG7qMiMMXfVq0233MF3m6RjbSlsNoQ2oba45nfALrNCLjR0rwZxqBuWKDyaEj2ObKvBGL4ZxDwIVjamVXu03XqxQVv8KgDF3e3h2xW/gP84XXRim1qtponQomOHapuaX3ORg9S7QhDt+S55
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(316002)(6506007)(66556008)(41300700001)(110136005)(54906003)(71200400001)(53546011)(26005)(2906002)(8676002)(64756008)(4326008)(76116006)(9686003)(66946007)(186003)(66476007)(66446008)(122000001)(38070700005)(7696005)(83380400001)(55016003)(8936002)(478600001)(38100700002)(5660300002)(33656002)(52536014)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wqnBVUZa/AgGpneSVXP9oNDDO8eb3jUglEa9UnV/u18duh3Xmik2BCEFPLwR?=
 =?us-ascii?Q?gwaF3rK4fJqgKvT8JxfCRb3n3RPGj7l/rvRM6j30tjypvaVmj9Q9et3NJe3F?=
 =?us-ascii?Q?Rvq6OMEwEDRNKw+gnFg7O/83dnFqQTpW7+iw99Uj0Hfgdu8JU6yodeJeqInv?=
 =?us-ascii?Q?hbMDAtbo8tuFVTGkGz5iu3ng1xoQ0hu0VqMHsM20wuLmxDoh12SoKqdVMJg5?=
 =?us-ascii?Q?HkR4/3lRadS6vwogiGQkiUQLj6bbncs67z44rf5tMGVu/zG67hO3/wXue1u9?=
 =?us-ascii?Q?lDTLO8bR/H3xomQ5tThOVyo4nEzhKpOJdU3lUQ+6cr6yIIeHuCv3gHRCHc+l?=
 =?us-ascii?Q?UW3Ff0utf0dD6ZvXNNIGbS/9W7HLi82Me965KgLux7xr9ZLeAMJBnJvf2glA?=
 =?us-ascii?Q?me0qSgixbkA8ff+IX2cRn0Z/fAHszAWgQ5eJ2Nu80TsorQuC71j4p0TI5mm7?=
 =?us-ascii?Q?IDYLFvZhN1gbkMnj4TcOw0I6WPn+SZLFVAJ+iMR6KlF8nwouHorG0dPnrQM3?=
 =?us-ascii?Q?/uJVCqGhv8j6aFe4iVcMt8ZqKE4esioFbGIjxLL6rf0iKF5/G+7FfX3TG6w8?=
 =?us-ascii?Q?3c9FJNRA5DUYxk0Dp+qFUKlES1TE2piYWi6GrJKnL5LQ/OWstXh/qmY9DqY9?=
 =?us-ascii?Q?BWKJZzae3KnwPkCI0R+FB/WL2ZhtzK601ZIbXGD+t4iVsy+Qfk4gaS/dZWkx?=
 =?us-ascii?Q?YOUk1/VyfrsLs0WhCaGhA4sut8IZgHYW0GeQIiK4bas6D3xE+Q5ue8W3enyU?=
 =?us-ascii?Q?e4rFXbk0gPjH0Qa5rfe1iC5PMedKAi5/rbo1xG4URYdq8TE98DqYwiSa/9T3?=
 =?us-ascii?Q?zdQ0XIkiY+1b7CWhdKY4n0/n40WfkU9owL9Bqmea86g0qn260VCN4O0HOyzu?=
 =?us-ascii?Q?iRxv0myOgEy32zYCozKV44xKOmqLdG3zedOtMF6rtjHBk0sBaEnIEyPpuT4j?=
 =?us-ascii?Q?Cu+y0v5HEuzDaH2cLbQRUETaDi0XzrBikWTKeMERuBloWLlATJwGI11blAQK?=
 =?us-ascii?Q?argPAb2hwaoqPiMQ/lcx/lvUgLNtPIu8rNjnLoN/NPScCxh7VvW5ujBr5DT6?=
 =?us-ascii?Q?a5xtBJK3WU3KWaNKuxVEugc2gd31oZqIrMO/4sR/jbzDBHHb57PX5/qp5zon?=
 =?us-ascii?Q?KYH/YGF1t3rbGplm2UH+MA2CTzQLDpvQHGxeXysei0vmUM/eV5ABwBQ1vCAW?=
 =?us-ascii?Q?sbC4F+j+stJW0t7gK7YDoKLEg2+EmQk9Qgy8K1Z5a1FPG26zSeBGWD8BRu9w?=
 =?us-ascii?Q?Lxnx/b2L7cERSnt4Yem1i2RNsCEKzKiDOfAozmQbctThV7cWh4zr3gzFX4+H?=
 =?us-ascii?Q?TgKGqj9ko5xWwddCs9XpEhfQwzEnWScrND5FvdPXDIKJGA3huyLKiZA0SE8t?=
 =?us-ascii?Q?/k2Rgmm0P0fq082k+jp1DoA1UgBZPUM3fzZrTFM221KqMk/YIUoSr3NOjgTF?=
 =?us-ascii?Q?dI3CWuWZ/33ZloDa/SARQWe+LTBRH912qTkeM9mDpHZF9u8BE93Ou378ULZq?=
 =?us-ascii?Q?rnROovNWIix6XoaekBhwTyBKEBab8AI8K1Iiy8N+1yV7hvnuOCO6w9+txKDc?=
 =?us-ascii?Q?dWUARdF0wifyMTcZQOM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0103058-64ce-4fe7-83f0-08da657d6fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 09:44:24.6057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOUcZ0scVbFBk9j046pKIaqhGD41dddmXeuXO25v0LFfLjrpSwDgv9OrUVTJKFi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1139
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, July 13, 2022 11:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot
> <lkp@intel.com>
> Subject: [PATCH] drm/amd/display: make retrieve_dmi_info() static
>=20
> It's not used outside of amdgpu_dm.c.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 21aec55abd1a..c03f300851fa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1446,7 +1446,7 @@ static const struct dmi_system_id
> hpd_disconnect_quirk_table[] =3D {
>  	{}
>  };
>=20
> -void retrieve_dmi_info(struct amdgpu_display_manager *dm)
> +static void retrieve_dmi_info(struct amdgpu_display_manager *dm)
>  {
>  	const struct dmi_system_id *dmi_id;
>=20
> --
> 2.35.3
