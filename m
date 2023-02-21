Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF98C61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 09:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C7110E0D8;
	Tue, 21 Feb 2023 09:33:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E7B10E030
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 09:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX4/XBNxYLF/Z1RfrP6l5B8NUWV1p4iPRqUB2Lo2aWBm1FC4Pf+SUUlPqxKUL2jwqGvfaI2GCwRlFVEWt/yQ22TiRPSxa9Ow44WX+90IflMn6ga48lhm0HeCrRZyiICoG58o9FVtjLtlScq3VdH0/YbFoNQOXm/CwhA3AdVILM8yfhoK7aomqg0ZZydcyZWk764YrYMd6QIyHM+0xiDEqfgtg8JT5y9Jgt3Q3O8ttnKj9gWzWv6LU0Kj+st1gC1s4ZgqM2eV/GTPSZ794PZN2/17zqnaSLojcbLEwls3ces+xcu/YWSblJyJRNvsOMv/SP5tQxnYU5A+kW6MbaujLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+erdW0xKv2h7LRYjvaynQ2/QWUx5lJy3qWAPLtwN/tA=;
 b=kwb4+Th7bFEPt3VNEPi3n8AOU4FJfBnRzreHdAvEIFYH78IYN8G5Apqn82zu9tmvjf4b8LuPapcjfJ3MZmE2lk3ZhrUXXkDK6Odl7S9u6jQNIhsuTcOI2MMWRbECYYM6xYqF5lzqh75vr7UZbXldFUgLbA9f4Xrn6XOSVNvyjOm4ZYGWVuHGWVdDE8SFqWHR2KqKr0uoPnDDyEeJvE61c7pPIQXrh0YTBa7ia97OImoKYWMmMXNoIM1Od3EJs9uWxqwu0wFk2j8IgKXSiWG1pNqSy/xpogesg9JrKJuA15UugY4xhwJoNuMmgZdXc5YdoJh51RyupE209jXVUQlwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+erdW0xKv2h7LRYjvaynQ2/QWUx5lJy3qWAPLtwN/tA=;
 b=KeG9jCcsbcm3MoF2NwWJbSdPeYwViaGlED5SGAcu6z/VckVnJDqcJRXGLLNE+HTur1cPMOvd71Re/9fTrdLAXo67oRcnR8aidou4MYRZWEpmVkkDqRTgHulK3XNceW50fEZHrQ47GIpIvLAagEXVbQCC/GIaDk+z6JMP2+tzMAw=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 09:33:44 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 09:33:43 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
 ras_eeprom_check_err
Thread-Topic: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
 ras_eeprom_check_err
Thread-Index: AQHZRc6jk2NmC8IeEkOb7bB0Kvg4a67ZIXBg
Date: Tue, 21 Feb 2023 09:33:42 +0000
Message-ID: <BL1PR12MB53340BBA8F15388A518EE59E9AA59@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230221082923.19190-1-tao.zhou1@amd.com>
 <20230221082923.19190-2-tao.zhou1@amd.com>
In-Reply-To: <20230221082923.19190-2-tao.zhou1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-21T09:33:39Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c96f9d5d-088b-424d-8080-08b61214d598;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-21T09:33:39Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: dd16be35-5f6e-46e5-9f4c-cb4a906cc0c8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|LV2PR12MB5750:EE_
x-ms-office365-filtering-correlation-id: e01e41b8-bf82-43a1-b787-08db13eeb900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1NE0foIeJGI8Es1U8x1xBDX9i3KMFEc3E+fcDoSGmNA5ewapWs/vgJfOUKsRTcAQ1jDfhsaTw+ICxgirf07FV7xdI4su+foNVBYgkGMCD9vIE9n5iMNoAcju687d44KwN8rXpdP7yjglK++CGoJpv+tw9VfYDDHy+bPMCCZMbclH8+13/7JDSiB/krA6nAiQo71CK7LbN0fh7ymqyvRWX5yrLrBZqwW1CyNaFCRa2jjVbv5l4CTlYK3jPDRSnED13sWAcLADN0WjQfFKPHa6oloIXkCDlgDVU1/M9gfjTqNWFIvjxBtTwjHvS0+SE6Fw06Nvplj2RSj5J+KgmfJyJOD6OnNNy35IyHWljeKF9NeBxzSaiyceQDVTqd857/Cc34QCbofZd5unLNxQqnQE9EWpDZRMO7SDhmr6kZDCBZ6i8xK5LBr/PHNXYn80g1378a0AASv+aMqjsnDgLQ0W8pMXZI6FT69I0n82hpRBPVndCUiKINzDkRrfbVT2uJ390vlyhtcda93YjFU80basJt6wr546iDsSgG3cCU0u00CPg6+h2NpxpbKjrF0m9uXCHPigJZpuy3viE9IMglxrp2F1DA5GYXl2A1cb+rw3tP4Vwc47duwN7eunPJJpbTunUcmzK4MSw0mtMyC3LGQCIiiLSIjTGsGlF7QIR7Y/JxdE1f7LdNIat1rhHMBSs1C0b16AoB7AB2HvktJnwn8zYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(8676002)(64756008)(76116006)(41300700001)(66476007)(66946007)(66556008)(66446008)(38100700002)(110136005)(52536014)(5660300002)(8936002)(86362001)(38070700005)(122000001)(9686003)(6506007)(186003)(53546011)(55016003)(33656002)(71200400001)(83380400001)(7696005)(316002)(6636002)(26005)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4NmrpH54gmeNgl9SCIUCfcB/djJpWELcUvnH6+jjhRGhGhXWr2sQC7SP0lKv?=
 =?us-ascii?Q?wqHkzsDQviHNPRPfrtO6fR+FqxFa0j6AFTxUsxW5PtGM+3hIUPfeFyP+Exkq?=
 =?us-ascii?Q?NlaW3/kkveh1hH8g04WSyGxHLZ/C8C6C78PkN+XvikbG6rqCcih5JxwanrmR?=
 =?us-ascii?Q?DqtE+K1/cGaGXrVx3yHClRpcUe1+3xFYLFlOD3aiz98M5VKHp0tEh6jxg2hX?=
 =?us-ascii?Q?Ci69GD21jK3EcknEqEFtIGFok+ikpQra7mVoz9zMucsxp7UkU3w4DdDZWBo4?=
 =?us-ascii?Q?z3iu4elFE1Pn4U1X1kb1aHZ71fwtyb1rtdu5BGTXgySSq3Fi9RQXm46iv5v+?=
 =?us-ascii?Q?P7gJ5+kcO4Z5Iokh9aIAWxEPJnyBb8L/N3duu7iZwhFGFjC2/yB33inVYKiG?=
 =?us-ascii?Q?Xknse+x42e4K+m7C8oP/ow3Lb8K00qNk1GEI8Nlc+egu6VzZzKaX6mAKrHwx?=
 =?us-ascii?Q?diIKANCvG6eUxGQV7wW4fL59dUh8iSmPrlGLdDIC9Vl6CBZ9LuKiwKlU/Yic?=
 =?us-ascii?Q?z+6yxBBw/mS+m5uufBUI6YD32mHj0R2K/XtqFi4fT3OQ0SbB6AUFzjxEP4jO?=
 =?us-ascii?Q?MH80gujm9jcIUCfVH6AWraBKhEMFO7DJ5m7mRNWPnXH8ln+Px5om8qPT/MtI?=
 =?us-ascii?Q?+uz3G2LbBrMm7htxehtvVhtorTDR4GYYwS7md0RLi0N4RLxnOvaWSDnPZgbc?=
 =?us-ascii?Q?KDvnpx8M8LXjxow3Zlo0/Gm0xa13CpD8CW5+ij6126hBuAX1+8n0aQ2bD4bj?=
 =?us-ascii?Q?X1lTcPCqZuWzhbUlgUtj4nEY3q/u0eHJs7E8/VA6G/MLF3Z3MqFTM2zU8OJb?=
 =?us-ascii?Q?r849crdJfMy0MOhqAmU9FiWS1aW6PYMi4HgmFWQ+GB7xkiudrlx8h9tP9hzU?=
 =?us-ascii?Q?4mReWfqO4PtLT2MS0P9tvg5K1nEhN7OqXJIOJMgpop4RfxiDx7r4vCUw+709?=
 =?us-ascii?Q?HqjeXBd6P1WfxJXsLkjEpthYtAnLp3CuTFdzSAQ93jaXpoLXLIwgJ9Dca96A?=
 =?us-ascii?Q?DPFIYj/95GLV1jT9kwZAJTdkr0GOo+m1bpilrzEbkB93Q2MMTNNoLtiiTvif?=
 =?us-ascii?Q?+L0RVA6c20znzKDFahCyaZAeCej2P3qjPD/FBQ3FCOehdQkQSIVMhkH/Kymz?=
 =?us-ascii?Q?LVwiReSSRpmpMODMmdrv+Yqu9p3NtQoZAuexedRYeZQVbS8UngUcVzSyKE9A?=
 =?us-ascii?Q?jId+SOak3ZIPT6OtimnznAWUJ8X+s+R/85vbM92VpPPqBlrSruq1LvDbBUES?=
 =?us-ascii?Q?iGfC0MP+xOoR0AV6sd9HrfY73Hmfvpp8PwvfvwSSsIZnYmDafuy47AphMr7n?=
 =?us-ascii?Q?9xMFqa/ULogNJZKfjO4vN/B0cCHLUAES8WGaJp/FqcVCOWnBEx5J/73Kza5w?=
 =?us-ascii?Q?Ty6UBi5KmgFXLRz7qCQevdRW8FLG4V4Opw5v7w9am3nZWDTMFIsKNnPyYb4I?=
 =?us-ascii?Q?pWvINCRguDk5LFXTYXt8DYB5GBNlmD0Z/JLagCvELNSp1f9Usbj8KO17lmNP?=
 =?us-ascii?Q?X/BS2FnQf5lX2ESby0qXvTKWl0R1PgkLSELzQW9oHJpUYPEQSDrSWXizKyfi?=
 =?us-ascii?Q?i62sSTO4xnTSr+Nrd3Vn0GmrMsVchRKfn7aZAuW1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01e41b8-bf82-43a1-b787-08db13eeb900
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 09:33:42.9407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sk/Beev/V+nqkPFsx9ZHmeUMgNIgrjCX81+s+hQ3xAn8BWtt6C9RRykj75tJNu57kvdGwGe/wTV4j19XoHgr+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Tuesday, February 21, 2023 4:29 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: add bad_page_threshold check in
> ras_eeprom_check_err
>=20
> bad_page_threshold controls page retirement behavior and it should be als=
o
> checked.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 20 ++++++++++++++-
> ----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 9d370465b08d..c88123896fe8 100644
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
> +429,19 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct
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
> +		} else if (amdgpu_bad_page_threshold > 0 ||
> +		    amdgpu_bad_page_threshold =3D=3D -2) {

Stanley: it can't guarantee use to set amdgpu_bad_page_threshold value as e=
xpected for example -3, how about set this if condition as below
	else if (amdgpu_bad_page_threshold) {
		...
	}
	And in patch#1 the value -2 isn't need anymore.

Regards,
Stanley
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
