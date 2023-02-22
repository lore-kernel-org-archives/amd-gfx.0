Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FCBC61DA4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 03:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598B310E1AA;
	Wed, 22 Feb 2023 03:16:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 873A410E1AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 03:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af7Se3/Z/sirj16F7UbKH2/gK8L4Sth4DQZ6azEvdq1gjfCDABs7zRR5xcOIVrS8q+tIkvVKp3zjJsasC6YFE/fAa8s4v94jv5hJH6EcYWH9V0HJidDmebgP+el7A2G5Nr/z5mK08IVgxmg9fG3VFU+9WmXggnFDTkymCaSfPhMe3Zw3sQ1fbKEA//zG5hSOBJolpa4w+yZVaTszdCUHoC6udA3Afxsng03WUuXK1yDD2ymeiVq237iug0gxt03VrUaoyBAXNoBAUn9JfSZs8ohDAf6wFhSfOictS3cDd7CA1bASX3bA0cgN1qezptMMUpH+xJuAp3McFcSCrHsh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soEVrGU7jyX9oEpRpcLCW2q4NzMMItb0Qwg3HoGZQrk=;
 b=DcqCIgsh9NcqY+BHItadtQ21XUM8pDhdjyMlWdOszkrrWY2+8Yk6osy8nBvvVQopKPHxUOwaCn3qO7+j4geCoJOuyHWaiEPFzyO3w5wIFsfMSyyii9n4fZ2cGsD7XKGuBrVb2Pd1lpbgy19xALU48Knace2CwGewRuWdZ5HEyZgt7Y5usLmm4bnUFD1I2UxEs5CQ3hy239wECjgQUcMd7vWeROgP+5B2EBWzjizn7FeKPBROY7y5rL19QQmnLtN8ujPpnPzzx1OogNM5d9IYO6lFQYp0d6eFma2KCzy6UzX+5a9ap5Jz9mSeVt5QMFzeLHVA7kh8gViI/zQLmfPhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soEVrGU7jyX9oEpRpcLCW2q4NzMMItb0Qwg3HoGZQrk=;
 b=RAyJ8APiYmYZMRBp6vrZ2rg/Jiqa+8TCliROnRlnDxhKm2m7Z0Wlb/w5UlLdANQW6VXior+wAJLP4ApuZyKPvJVzOpNSDExqxNLFTeyEoe7/ueD2F33Hi/iVx9Djd5oIiu0wzS/o85Q51DmTc7w/huMKn56eB45VFgrIiHorzuY=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 03:16:14 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 03:16:14 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
 ras_eeprom_check_err
Thread-Topic: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
 ras_eeprom_check_err
Thread-Index: AQHZRmilq7AXmTYfEUSxRL71sJV+4a7aSuNQ
Date: Wed, 22 Feb 2023 03:16:13 +0000
Message-ID: <BL1PR12MB533445C88F86314C266687A39AAA9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230222025148.29652-1-tao.zhou1@amd.com>
 <20230222025148.29652-2-tao.zhou1@amd.com>
In-Reply-To: <20230222025148.29652-2-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-22T03:16:11Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a33a1677-d769-4485-b1d1-7e4de2acdbeb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-22T03:16:11Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 55660c94-d23a-4716-b255-da9f7eca3bc0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|DM8PR12MB5461:EE_
x-ms-office365-filtering-correlation-id: a5dcf110-1221-48b8-fc16-08db1483279c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vI1razKJsedbG5q17WY6zMmeTH+VoF+1U35DGgO6rA5pqKeUSPDXds/s5MUMVcLrSx5bmoMleOUNMMaDvyPEuxANTjpuXJGTFLq6/apYmtnxZbCAbICRJXnzsyta3aM4lnQsK2MTp7e2yqIVgyqu4/qDf/0frvk/BVffDEA43kmje6nefbP7WUu1yV/rnCI5oaBJD54dVK3vzJEbe5ndyB5D0hRIEeKwCJEJLjCguUmXFxJRgnA3GjCk7+JK+m5K8dLhu4rDnWC2ZulPuyn5d4pbosq8e4iVxXaoMY0QLSliuBlpyKNOddTjLhh5HCnGMKu5a3Z2CwH+B/6prJvhIx1qbyQXxRi0dP80YwZFFmU3yyL/0qJF2S8qzailNnD9Jlbd5ZjOEbA9pEZ7+QqEDEtrDl2faoyb0Jvqg1uzBfo8NpDjwHIrye87xhE3ZW7gxEgRKCg/rMrOJUHub6Nvn63Uss3xzYmUA8fGVpP1IR5xuNqBp2MTDWMn87tCZjZu3ndQ2FZawl1XkREvDIqjdTOczYpo1NO9GchzXj157bGTz2Ccdfg24Bav8ranyGh/nyYAnySEYxQBFnrIAXM9ZXG+jfPof4vI8BiZegn1epovfyfJACDmLciHYsEgxbx14B0f3tO++xVhaKrNcvvxiwPvPJb/k5vlt5Ibh737gVYIIdciEpEHUl2U0vK7K6TYe2maoRPobah8UrkFkQMiXdzvuv256WKmAEkjgUfjuY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(478600001)(6636002)(71200400001)(921005)(110136005)(86362001)(6506007)(9686003)(316002)(53546011)(38070700005)(26005)(7696005)(55016003)(186003)(38100700002)(76116006)(5660300002)(41300700001)(66476007)(66946007)(66446008)(64756008)(66556008)(8676002)(83380400001)(2906002)(52536014)(8936002)(33656002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2m+FzhwWHYZysHFHfAs35kXNRT5hXSlUqzhKxHtGH6nK7vfjZOlg3ypmqBAC?=
 =?us-ascii?Q?OX/0ggsFD2+4FnjJCXeT+NedaoI3cTgZy1Psl4R25FHaGLyK5MuAS6D9H/75?=
 =?us-ascii?Q?uA/DquG85FaP/WJx/XhMok1xOFD0Es2iz6a4nlS+eYVn0YDVmh2t94DfPnBF?=
 =?us-ascii?Q?wO8w/YxjEEeWwWOx1EYPKkiF3HxscOlCWCX7LzeTdLUsXOvPWA744m6cpOd+?=
 =?us-ascii?Q?tvhrycb1NKexl7Jq9RohfhdKqpHeOWndOgvwym1Zl+jaGTS13l7HIIcrB1QI?=
 =?us-ascii?Q?hgdjw1fTSZczIu91SCUri20ac0HxMzH1gywczZPwm4Xy89Cbmya30MhWMS2b?=
 =?us-ascii?Q?desyVJ+LMneRUdzfpbM3s+DrbL1Z7iHBPAeF/JKo7M5/WlX7rHspX8MfawRs?=
 =?us-ascii?Q?AuFTPwgGV8VRPu27Lm4xKALQAOgUzxJhxKaXeuoXY9jb82BAffObjdYGpSPd?=
 =?us-ascii?Q?JiG5XdDz2HXAN4TKdUIfm2UpsInLQEB8g/4xoBSPoVIWtZTRCohz3ke1+ZCv?=
 =?us-ascii?Q?2j75RBMEQD+l/bnpii6ZzbHchGC58IIH06JXNbuzr45u86qEPimkHvcIwm80?=
 =?us-ascii?Q?yp99J2SNPrXYymDxBesHzm0+g91zv1VENOHq3DyIwnThEyAaT1W8a5B08TVr?=
 =?us-ascii?Q?Ri7ITyicNySkcrOwcXl8rYxRNADBAkN86NVDbk5+0Wb9VQpX7/tW3YOK3M6Q?=
 =?us-ascii?Q?hHHkFI79NUeefHRGgWAXEXzD+9S+SvhUXyoIXSwuS63hLTg4UtFpKEXVH+ii?=
 =?us-ascii?Q?Q1hZIzVl55JxocXa4WfDV+A45daGm46I7QKV+XjgL4Me3Xl4Zqlil+RaXJC0?=
 =?us-ascii?Q?kqK7bByw1WZhBM6jkvgKPgfabSfd9JlqnFttqFE2EJTSxdGc5j8YO6JE9qwP?=
 =?us-ascii?Q?n0QVCRlcUhnN7MdTuj0SqC+874Dgou79wO19CiZVstdMafXCOt+KX0B5XLpe?=
 =?us-ascii?Q?fC0FFJ5fSmStsGBXgsMfnJP2a4LPy6nysyFy9AZP4Es4dagK+dU82uQqF+zn?=
 =?us-ascii?Q?/LG9jBWmiJ6cQH+R3TdHGpZtZE1+QV8Z4pUlEHXqoenCcrygnoidEG+w93Ct?=
 =?us-ascii?Q?QWj4RnRj6CgqP92QtBs/03H3ng9wWaW+RMYfiG9fga3y1/wvwkbzXicHd7LE?=
 =?us-ascii?Q?QzbiBA7YIFYS8Rrh0RDtesxgDDjmzgUJ/TXY28E0JK4cxhNgxj595ZPXELqj?=
 =?us-ascii?Q?lFsJohy7U0IUGQgNdtmCgfE3iVM2DKbHLEHiZP8o2NOf6h1J9XJR0mLh19cc?=
 =?us-ascii?Q?G17nzAkJSHGh731L7owXlJjUHVOGHrFx/Ump270nLq3AJFDoI7CuVi9xS7aM?=
 =?us-ascii?Q?RmbQLxMQyZPbilL3ocMrHEz8x+HYC4Wb0DxtaEzLlCf3gdNPc9DpAWZ7VX2g?=
 =?us-ascii?Q?OG+q3N7nH96a+UkyFtlIXmK3xl/DGXrhuAfMaBzouoehKl5zC5011O2GiId4?=
 =?us-ascii?Q?prz1mir1TaocLR6mp7KSsrFKul1lB3PYfpc2NnQvwo+1TdZqGfq4B5BjXtxn?=
 =?us-ascii?Q?10F5ldfwE7dOIYQ4i1TvLoptIUdcZQ8CitvsFZsWgZg0t66yaiK9zz1xY3km?=
 =?us-ascii?Q?ihYZoGQUtGQfEa40o67WY6zT+mtcy+ae1c/kkpvP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dcf110-1221-48b8-fc16-08db1483279c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 03:16:14.0303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCipAoSMdyNqvORJEotJ8IdJB4H4Db0nN9G5y2gUFLE+ZfgT0D+12d92/3Hp5s/uZ+JXgVmR0gisyDUENF/x3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

The series is Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, February 22, 2023 10:52 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
> ras_eeprom_check_err
>=20
> bad_page_threshold controls page retirement behavior and it should be als=
o
> checked.
>=20
> v2: simplify the condition of bad page handling path.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 19 ++++++++++++++-
> ----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 9d370465b08d..2e08fce87521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -417,7 +417,8 @@ bool
> amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)  {
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>=20
> -	if (!__is_ras_eeprom_supported(adev))
> +	if (!__is_ras_eeprom_supported(adev) ||
> +	    !amdgpu_bad_page_threshold)
>  		return false;
>=20
>  	/* skip check eeprom table for VEGA20 Gaming */ @@ -428,10
> +429,18 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct
> amdgpu_device *adev)
>  			return false;
>=20
>  	if (con->eeprom_control.tbl_hdr.header =3D=3D RAS_TABLE_HDR_BAD) {
> -		dev_warn(adev->dev, "This GPU is in BAD status.");
> -		dev_warn(adev->dev, "Please retire it or set a larger "
> -			 "threshold value when reloading driver.\n");
> -		return true;
> +		if (amdgpu_bad_page_threshold =3D=3D -1) {
> +			dev_warn(adev->dev, "RAS records:%d exceed
> threshold:%d",
> +				con->eeprom_control.ras_num_recs, con-
> >bad_page_cnt_threshold);
> +			dev_warn(adev->dev,
> +				"But GPU can be operated due to
> bad_page_threshold =3D -1.\n");
> +			return false;
> +		} else {
> +			dev_warn(adev->dev, "This GPU is in BAD status.");
> +			dev_warn(adev->dev, "Please retire it or set a larger
> "
> +				 "threshold value when reloading driver.\n");
> +			return true;
> +		}
>  	}
>=20
>  	return false;
> --
> 2.35.1
