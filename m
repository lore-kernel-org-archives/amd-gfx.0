Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C080DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 02:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D8010E563;
	Fri, 21 Oct 2022 02:53:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C10310E563
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 02:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrWRpJgtaS3Q6vk50YKjotXbWZJK/Arui8n7KRrj8WuHR5ZBYN//AUjLXGN41GnAOgsJD/AxtEnSAiaNGldl5SLSSiXCiS5GefM6N3wg3LF5Ri8BnoKCgFcWIxGxlHsfSZcfZ+o4Tt2x/bCKF7nh3gdIZOWQkPuOgrRtE04QXbhqC38mTe3Fo/1EOC9dgn2sMIt5lnncwU3OnCpn3Bcryo7YsYC3FpdYHLGpGRKykvxWpiqZCnpnAIFLkmmiKkTEVr/GlOqgq1/fqgBHWGd/acNmsLwlovsdvwQ6RNEClCWvhFlQPDY41l9YqC/o3Q+unySX2btntYHVk/8tdn3k4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG073QsMFmgtTqlIwRPDJmlMRoWpCbOahF3YVGhl3y8=;
 b=h1LV0LX07Ye0YAIVkfz7yyLPBtSCXS34zbJEfSY75YhEscmu36XyVHIxoU0kzzBtlXTq8W6sMBAf2vthlqsNAzvFJ0+AJZV/UcVbj2YI0ddKYBiHxwYndWC5BIbuskUopR/rqVavTzzNtRsirjaSP/HpL8s5dRn9zWsrAdGakZ9/MliSH50du37Wm9XPLOHrcbCJHjHUvW+Kws0B3ZajK9YTxWDNzkJoiAg5myBeoYXmLqeJbCOcJe1AKeoRBEbbUY7qtF9qoLhPh6BBKfphDf8Yvihbgl5GPEypnlgR8UFMG9FyAV/tcjXjF1V9ynfz9PfbN827bqfaUn/9HH0yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG073QsMFmgtTqlIwRPDJmlMRoWpCbOahF3YVGhl3y8=;
 b=ZZEWROKTLrVd6eIMfRu4jsAG3VnItmuN3LsYI/45ZHlLjAc173kum2kk/4uIEjOcwK77RW0e7ydyV4nGTPP/WlFOgovJkUeO27roeaZSILB68eLr1qbdcU4sme+1xJko0VF5QeQ1z58PzAMhv2hetFMyQrwFUeBLvPsI4G40QEc=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 02:53:43 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c573:5276:735:34f1]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::c573:5276:735:34f1%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 02:53:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Topic: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MCA
Thread-Index: AQHY45KKbKvtBuwd/k+dsDcis7XSHq4XARWAgAAIQPA=
Date: Fri, 21 Oct 2022 02:53:43 +0000
Message-ID: <DM5PR12MB17701A7904F390C4A3E02760B02D9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
 <BN9PR12MB5257D39D5568891CABB09B62FC2A9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257D39D5568891CABB09B62FC2A9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-20T09:12:42Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7f91dd3d-e8a5-41ea-b651-e89e88c8c2c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-21T02:53:39Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8caf5cec-ca50-4a24-8dce-48d82a81c9b9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|PH7PR12MB6396:EE_
x-ms-office365-filtering-correlation-id: 6ea0a85b-3d01-46d7-a917-08dab30f7735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybj3VL/bZZMwiS4ZJP/lldQtXY2pO234+wXJq/IdOH+JLhLbFhMw7XW6p7dVXzeq7luAyytmRCSVjZq33t9v6p36LpA860t0NRlIc4uEBGne3bKj/j0UBG8xa+bexL1wH9lwSHu21IWSLESBpFnVYMfQS8p5Jb22/OacYKBMTnnQakngb298cvq0/yanbHoYBRA5YM6YSUlHc7+aP6xJAYW8i/IONGkTVc6SEDtE7A/PkN6cHxV1dWX0kdf3GH9qBF+swG4SgYC80gbBil3XJMdhZzswX2fZfB2KQbSlBlvLDVkPwbkqjVtbQGdi0MRVXpsSOwB6wI/jNOhTQjl4izfmAZ5BLbAUBsLKLPKOolX+O1E0n5MglcxuyTjUTy5jeWP+wd8/Dxl0WTm5gD+OCq/eDJAM623JAEq+zhs85/M8PaxULopb4Yjd9a8CdfQGmIgme0Qg5una0ncCincufWRsRtFY62TWRcyUgR0zF4FyDqJcolp/LyLZm7Pd3bHmFZnHet0a9z3A+g0/w7QCLijucgOhln+l1z4KSB5Soovo70ww75s4ShpLw7b9wgODXB4keMvQHheKIXXKY3/sVW+DJbiPdWkZ3mwYyh1gXd9cWzcAHslJuJz5xJ5lZ2lgl0Krky29vOUBHwSuNBTilN87Jf49FbPzI2BCa/W9Ce54vUBCgHzxcQl1Q4NlT+g9Ncw6qMLmn4mJcBP18NRJZCaOW1GOBSEj4iuUYL0Sy9p64lwsCOefowa41Jukj7y+SFpxZFdllgZBiN9H4WSMAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(122000001)(8676002)(478600001)(38070700005)(38100700002)(71200400001)(86362001)(110136005)(2906002)(6636002)(26005)(186003)(7696005)(6506007)(41300700001)(53546011)(66556008)(66446008)(316002)(66476007)(52536014)(83380400001)(66946007)(76116006)(33656002)(5660300002)(9686003)(8936002)(64756008)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KwyDM45i8b4XdBjRuEvy/6XI7orO13CbFvqbBHvF/8C2BV6CyUwI+U2e8xUi?=
 =?us-ascii?Q?h8FRuDjrLeKWSmZ/NiW9aelMq5kpxO++VRLoNl9FY88LiYrsrfAebdMnLdAW?=
 =?us-ascii?Q?0yhnxrviW9b87f8StyuS2XeyEUV6jAn33vZ4fvHMY7w/Eixu6MZQzPaHKJXP?=
 =?us-ascii?Q?5FCo8eoTv501e8dYre5lYLVC2Bu95CfA23GTYDdbY+w6c/hx8UyBHMuPVDpg?=
 =?us-ascii?Q?HFtWXKpFIIuKOB9k15v7fxW6JtWlOOvQ42aVSZR8hOmbRH2KygK2mBLsKUdA?=
 =?us-ascii?Q?fSpFmQsWQawmTSSmDMNRmfoQh6uW0j0ZRqpg38WxY0f/LmO7MyZymDMbFOW5?=
 =?us-ascii?Q?L/pLW7LE5JUHKAkpdzeeT6Kr4HIjp+zdhONWN591uRV0dpmXuDq0rQ/Xfkki?=
 =?us-ascii?Q?0k1a4GZ87tV6oemak6tjCDFKO9P2yf9zKAC2iOpSCKobUNxj1S3m0daXyoQ/?=
 =?us-ascii?Q?2QFPRkGm7IAfNlO0NngPa7HjKTKbHHEwAWrdo59yCV94ZiC+wJWgBWby67WS?=
 =?us-ascii?Q?sRUXKGx5N2lfndQbeqDH6HDiBk9o2P7UIb916ori1D0xQZuL/eydOHDNsDeC?=
 =?us-ascii?Q?eZXTLtZVn+HCIvoGCAb35gKlZEhOaWPG9miKf+ogT9QP4VKf3gQOSpZoqzHq?=
 =?us-ascii?Q?lx8r4n3/pWOAi7fNKYwDLgQRneqQO8S4ZXkBMILIR8QeXEHl+PRxzhEXIXXi?=
 =?us-ascii?Q?KQtAVbyeffYT+d4xsCY3MLKMcAO0Pe9FOA4eiIb78jYDwp/x5GlxumdfLNQj?=
 =?us-ascii?Q?AX53kcKFbZ9eu8lyuzKKqNleSODRy25PutBBT7y8JPqhsszEv9ZQPYjhUtZq?=
 =?us-ascii?Q?AJoZdu6EswhyqZcWCSehzbo1sn1/6r+zHVBf9AWAWeS/O+HxG/zmYSe+lWUo?=
 =?us-ascii?Q?8HSN8U9mspSgY7uAtsN2DtB0OHTF5DG7abs28r6YP85ZahgI2XzeBZzGl2Yx?=
 =?us-ascii?Q?SS3CFw0TZvflEuR4e07WTyvnpc2BuYZ2u3f5coDmUro3B/PyQ6T7C7Gfcgdo?=
 =?us-ascii?Q?EAp8GoVhlq1lwDBk1+rd7VKmtfH4BpJwOscrGdzV1EM5+Ituo57lXms62wa7?=
 =?us-ascii?Q?s0kSfEIqAe6xGI5IVs702R2MUij51EUL3ROeQgU5rwHrFy5KCJ2wM471nayq?=
 =?us-ascii?Q?5RXxcLi4PffH3TYKpn8eECOwyfSHzESQGNBTO2rilJRmqC3vFmMgN6kmcEo6?=
 =?us-ascii?Q?kXBiLN/yFtT7clEmx1nGmKA8lEZmmjHz/ONhCte+3OpjWROs3n/7uz8pGOtr?=
 =?us-ascii?Q?PQWmd8MUP7yAiz6a9f4qydQvoBeT0jvnJ0pGjAWNmfi2rcSXbO0RZo1XD1EY?=
 =?us-ascii?Q?20EDuqg9pzpaVwIicVQcSpENWxoWT0qanpWhHwadUnGFUImRKwTqGShVmz74?=
 =?us-ascii?Q?hd1aUlEIWhNQzOTxd9lcwfK/m+1NaFtbOYEmlqQeRTqOmABZdtOWsj+EQB4I?=
 =?us-ascii?Q?uq8Un2oLoq3M2v4GU0hZqiS9+PiB71EMWLBS9x8wxvALpXLxkrCmCrdunNBD?=
 =?us-ascii?Q?fvm7BfwGyc3cFCCNH1rjGcIBNZ6grdK9on3F1MC7nmCWFZPNMDTBuRvfr95O?=
 =?us-ascii?Q?hT3ena0MH0A8XVGoZss=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea0a85b-3d01-46d7-a917-08dab30f7735
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 02:53:43.1764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPboor4NrwnCBk85xKpGwasW+86Sa2cScd87UUGDhnGVeYwDBE9eecTrf0kaHsDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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


> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, October 20, 2022 5:13 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions fo=
r
> MCA
>=20
> [AMD Official Use Only - General]
>=20
> +static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
> +		struct ras_err_data *err_data, bool reset)
>=20
>=20
> +	if (adev->gmc.xgmi.connected_to_cpu) {
> +		ret =3D amdgpu_umc_poison_handler_mca(adev,
> ras_error_status, reset);
>=20
> The input parameters "reset" and "err_data" can be dropped since
> amdgpu_umc_poison_handler_mca is dedicated to MCA platform

[Tao] whether need to do gpu reset is determined by unmap queue status, so =
reset parameter can't be dropped.
For "err_data", it can be removed currently, but I'm afraid we may need it =
on other ASICs in the future.

>=20
> Regards,
> Hawking
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, October 19, 2022 16:12
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: add RAS page retirement functions for MC=
A
>=20
> Define page retirement functions for MCA platform.
>=20
> v2: remove page retirement handling from MCA poison handler,
>     let MCA notifier do page retirement.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 67
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> |  2 +
>  2 files changed, 69 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index aad3c8b4c810..9494fa14db9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -22,6 +22,73 @@
>   */
>=20
>  #include "amdgpu.h"
> +#include "umc_v6_7.h"
> +
> +static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
> +				    struct ras_err_data *err_data, uint64_t
> err_addr,
> +				    uint32_t ch_inst, uint32_t umc_inst) {
> +	switch (adev->ip_versions[UMC_HWIP][0]) {
> +	case IP_VERSION(6, 7, 0):
> +		umc_v6_7_convert_error_address(adev,
> +				err_data, err_addr, ch_inst, umc_inst);
> +		break;
> +	default:
> +		dev_warn(adev->dev,
> +			 "UMC address to Physical address translation is not
> supported\n");
> +		return AMDGPU_RAS_FAIL;
> +	}
> +
> +	return AMDGPU_RAS_SUCCESS;
> +}
> +
> +int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
> +			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst)
> {
> +	struct ras_err_data err_data =3D {0, 0, 0, NULL};
> +	int ret =3D AMDGPU_RAS_FAIL;
> +
> +	err_data.err_addr =3D
> +		kcalloc(adev->umc.max_ras_err_cnt_per_query,
> +			sizeof(struct eeprom_table_record), GFP_KERNEL);
> +	if (!err_data.err_addr) {
> +		dev_warn(adev->dev,
> +			"Failed to alloc memory for umc error record in MCA
> notifier!\n");
> +		return AMDGPU_RAS_FAIL;
> +	}
> +
> +	/*
> +	 * Translate UMC channel address to Physical address
> +	 */
> +	ret =3D amdgpu_umc_convert_error_address(adev, &err_data, err_addr,
> +					ch_inst, umc_inst);
> +	if (ret)
> +		goto out;
> +
> +	if (amdgpu_bad_page_threshold !=3D 0) {
> +		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
> +						err_data.err_addr_cnt);
> +		amdgpu_ras_save_bad_pages(adev);
> +	}
> +
> +out:
> +	kfree(err_data.err_addr);
> +	return ret;
> +}
> +
> +static int amdgpu_umc_poison_handler_mca(struct amdgpu_device *adev,
> +		struct ras_err_data *err_data, bool reset) {
> +	/* MCA poison handler is only responsible for GPU reset,
> +	 * let MCA notifier do page retirement.
> +	 */
> +	if (reset) {
> +		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> +		amdgpu_ras_reset_gpu(adev);
> +	}
> +
> +	return AMDGPU_RAS_SUCCESS;
> +}
>=20
>  static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
>  		void *ras_error_status,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 3629d8f292ef..659a10de29c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -98,4 +98,6 @@ void amdgpu_umc_fill_error_record(struct ras_err_data
> *err_data,  int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev=
,
>  		void *ras_error_status,
>  		struct amdgpu_iv_entry *entry);
> +int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
> +			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst);
>  #endif
> --
> 2.35.1=
