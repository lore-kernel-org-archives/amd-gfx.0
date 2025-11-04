Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2B6CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0BC10E575;
	Tue,  4 Nov 2025 08:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKpLmgGr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD7410E575
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQpr3EKY5Elyb8K2qOCUBKu94Jq4W55uDeU6Tf46dLdmSzrjL2ydcc5fXKHHarS6qASf5LG/x7fJZtA2RkRjarowMEUUSHeDyc8/6V6/7XEWVG2PzF0I9D2hNebdiKljnLv0OmOv2dxZh1Qz5wbQOy+eI8E+x+Rg+yylkcAnvPTWbsVUtkdISXoZLqg0ng3yVzDLg1c6N4I08L4j+/q+DjEb9ZIVdgCuhScMLWCsGA+pgAdNYXKgKaAFEeElxzdDMQg9gqTjjGcVnqi+PeYHsQnIPw6vsVK0U63PHa5nsnQEGKgxegPKWYFThePGSlWsLgVK5+9ksQPG0+kJqoUJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v8sI4QA0LaICmVnXh1iyKWWBSpCKlSUM2/3DU95qa0=;
 b=bGYTkSUdIE9d7kbepQfkPLuRKQCmrBSkixwK6Xllmf9pXBVaNcoe2vk9htM1bMfeQUCDNkV8cxJLc3UmSIXPw8GuVH0Jjv5l+D8Kc1UWjhkWnIU595SYXTPht/GtFKWKCYaw2DrTkeXjrF7yUkmp1tSk4Kdmq4YooD+de3lMOsGnEJdH6/0gH/QBNzhNA2ux/pFUWlXHnLKDiBNGpAltILVse7ql4A/WuJ8zMsHxkAP2gZskQiABKaZ017rpPr+jECx27dcj8Efjk8HA/0dokpa+uVvmLDSJrd5ivao9OTg9VYPF1ZVo5hwjVeOQuLYaT4Ih5pBvYbpIXUj4wM2+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v8sI4QA0LaICmVnXh1iyKWWBSpCKlSUM2/3DU95qa0=;
 b=WKpLmgGrtbv4/XnvoiYZWYzs8hcNjgPqMYDvlNJa5QcaLrnBuadfnWlbRUL4BSlGEVE1b39CvpUankmCez8b2rWelJRctaoE3BHWTZSSbkf9P8iExJ6dwVCd4xJ+CN2ZZXL6akl/GC4NmI//37joBqVBzqEEhxlLe/384yqAyU0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 08:51:32 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 08:51:32 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 10/10] drm/amdgpu: initialize max record count after table
 reset
Thread-Topic: [PATCH 10/10] drm/amdgpu: initialize max record count after
 table reset
Thread-Index: AQHcTVhvzKVKFfxri06utjNsCmFZprTiNbHw
Date: Tue, 4 Nov 2025 08:51:32 +0000
Message-ID: <PH7PR12MB879618B68D3B5B5620763A21B0C4A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
 <20251104065745.1737050-10-ganglxie@amd.com>
In-Reply-To: <20251104065745.1737050-10-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-04T08:51:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ1PR12MB6098:EE_
x-ms-office365-filtering-correlation-id: 5fbcd26f-456a-4255-2d82-08de1b7f5a64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1sY6lqWyPAXw1lAWqbUEWQ2cULEHdB++dZlmptLg6UtYBSZ3Wjwq2YipEgr/?=
 =?us-ascii?Q?f/i4yNCq9mpeErLGoYQ2+z+pegMVKkcGgkPBGh2IUN1Bin5j3myVvxzw73LR?=
 =?us-ascii?Q?rwdUC7/5LpVtUva/di06k+nzELKiUHIwXs6ulDTErD3yqgdIve74Yc6lRoxB?=
 =?us-ascii?Q?vpI0x2+V4im5FHXcuG7HExfVdogXdH1pdy7Ko0JGfXZmJY3G1BEibDVamUMM?=
 =?us-ascii?Q?NYiKP9HGMpAluzugWsyeBh032jzg3/RYDClTiCMpu9kBs5aa4XJCEhryH7TY?=
 =?us-ascii?Q?/FNBXWvA1bwoPpYeKzb/2HNYpw4DRUGjeu1YHvZ9bQel9Gwed6oAaDxCw42k?=
 =?us-ascii?Q?kXJP2zoNVLAIRm87kz4SX6fha6WD2yLn4+E3i7gRszEHnRw8YQXhl0UcnmIl?=
 =?us-ascii?Q?iVJ6iLqHeop6aiLzZTDhGW4saUADhaf+k34y8tEovMofSco4gyVah4qY1LOd?=
 =?us-ascii?Q?v0PzUc30RsOISk7aD+Qgs+hlSB8eHdbtWbKXgVlJtSbWPhLXVhSeOHP0BSkj?=
 =?us-ascii?Q?e0W3oAu4UPlqjje4/2VyQtYH9Imh9861ieNkgnVcc2GxFkuX12Px0rxoTAsU?=
 =?us-ascii?Q?V+4flJxZpEQQMTFvSXngSiu39YCWs3M2kX4QLzbJ8Fmpnt48T0q8zvRuY+yH?=
 =?us-ascii?Q?OBnypYHfDln9T2LisUNeiAnHBYsrUlYZTq+au9S4jUaGl00ALxZ9sYFy+uIw?=
 =?us-ascii?Q?xbnWChLGtX+hCps18duZW4vjouiH/P4du1xvR/0gZiiPXENQzgrU8oOeoNWj?=
 =?us-ascii?Q?GnblecY0DCyONSmPspkiKZwiZiuz90G5IEMEjc/TTTno1AsjinG+MWEJxVDi?=
 =?us-ascii?Q?Yv/IMx7zk2p/CFnYnlIdbXgDJA2CAz7pbp7oslDXD4zkQ+BcJcTe33Ydy9hi?=
 =?us-ascii?Q?VfZfdgt4+nJ7dxMmAEnvPRtim+0hjlvjDx/53xRRTWaDXRRTlOlsEQDYjTDz?=
 =?us-ascii?Q?77kwqdSF7WR4e4vcvfI50DkGCbEkVhAyEyTcmC/yUoohDtlXLVbXb6xSlOrK?=
 =?us-ascii?Q?JFDs69MoLX+IFmOsY/KlgMBiyJo73YdyTYONJXbX3Wl29HiECFnI+n+ZJ7TN?=
 =?us-ascii?Q?5q/nShm281dJrQcqk4fq4Ncnf47DAoRp8cTZxs7Pd+87j5/4ASdcED3mzrpA?=
 =?us-ascii?Q?diJRiPTc9E1WkHt0moI9zu9iSFJ4esyh9jpldT8tWRcAp9C3jP4kH/+agw3z?=
 =?us-ascii?Q?RBy5rIVFj8yBSlCdKhyQlR67m+dDy7o1v2ANhyc4+Bc2MCXVqsG6PYAr5wwo?=
 =?us-ascii?Q?+1ZSQ+BbiR4j/s+FsD3BS7YRUB9EDUUhexTUhuLgoqX4L0SuqMoEAPFfL84T?=
 =?us-ascii?Q?+JhaM4GrEJzk+UleK+a+GV5jMZuuTMY+sxUJ7uSD6Oc2GWhnapponpFwgIsv?=
 =?us-ascii?Q?jbdSND/RT2aUV8Hbig0be5KqsNfDyYx+luVGo0uSId/kO+HZ87u22wtdSd74?=
 =?us-ascii?Q?a3BopLDCUJ1dCPMH4qrEjMZHQBoK10PjbkiMcwxY6V6VSSkVuCRjV5qvN7RW?=
 =?us-ascii?Q?wfy8VJ2B54Cuu5Db2gQ7XKt4JcTBaCyqqPkz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HnsSRlar9rTb8HtFZt18brtrJXGeYzNp8YrkBRNXX0bK8wLLm0YWEbQMRXb+?=
 =?us-ascii?Q?tnQ1XT3dDv0zw2oma56c3c+SKGaWz22o8uZe3S5CCdYoFPHSkjWY/I5Er6Rn?=
 =?us-ascii?Q?BlbNH1mJ9ZqzH7xanm1ldTNuRcQ3NE4nAq6rQYlgsKnDZyoBV8otWcEHiPW4?=
 =?us-ascii?Q?45xcv9XbfDGhyDcSKBoBS1j2UiTTdy4/c1kVUgOhpyom0AKY9S2TU+O6PAtE?=
 =?us-ascii?Q?qACoTISBcu7s+xFdXPNe4Vi5m7YW3dBlOSb42ivCVyxPH6v6c/gxPesgAnNi?=
 =?us-ascii?Q?LeSDHXFrX25rh+21OJHgke+dDljSKOa5YdXvGENv8pxSwpy2T/646OCY7Gvm?=
 =?us-ascii?Q?Dm9oCdBDea4tAa0GYwjH+HeiAZtFf5nLhEynVtjs8BDkZH8U/HMsw3cTM3ec?=
 =?us-ascii?Q?ZHhpx7OUNvoUdmdmUdrGrlHrad+bgn+7IZ6ISCkU2FnDobTJo5u31QjTtTjp?=
 =?us-ascii?Q?n0TJWeUevPFtJ4chvseP0uMKYTV9S7qrT3/cwC6zF4GZUTw+KpLUyjrv+aDG?=
 =?us-ascii?Q?BJZy/Ils9oV9pgeE8tkijnDIi74JWHs85vCXat2pOghIEcxo7RS7nnBXgKHp?=
 =?us-ascii?Q?zpEhOqj8Q029iPryIdtqGuARgcAOhVupr9KY+U3rxII/t4Gn/G64PIfREEq4?=
 =?us-ascii?Q?DV6NvX2flShKWtIy5gHJMkHuDOxFfaJDxoD8U3pr/bN3q6S+4ElprOO7h7Zw?=
 =?us-ascii?Q?zFpnuVp4SUSUfXTb/R7NO5Qnk26GFoP9FohDARKIV2k5ku0qIu6Yn41ssJyK?=
 =?us-ascii?Q?MLwTp1JONgIfK643ZJdGre4quqUhQ8Bhvs7fEI0gxfClQLBRI4Q/aLkxbp4P?=
 =?us-ascii?Q?dpot9wiHKrkuXU0d/3l1FR8rFhWo9xLX/3iGF9LZqqZmsXYRJ0+0z4EXoKrc?=
 =?us-ascii?Q?dG17OJenrDqO5bD0T3j0dXQnQYZvZUrfqTvCKhJppcMOx68C7RMwIRCSSeqb?=
 =?us-ascii?Q?x2EF6hBmkLdAgLiPaiWBwspbaMuyZc6KVQAcSmWm726TVt9ADodSRCq8GgQN?=
 =?us-ascii?Q?Brmv8mfxP9L+SOiMuNDdllMP5BTrEhx3pOiCPiIZOF0GNwb7PoEbk115BIDp?=
 =?us-ascii?Q?mT1QyCMZvrJxOk1T0/KDMKERkKmEkkVtRapIgKv3Fgs8oc9J+PdZJoNhnEV9?=
 =?us-ascii?Q?JtNQa6qPBpNYN5m2m6IZcqYCMKPO9gIdgjlHTxT8OlRyZGGRBSmD6Ry7N4Tm?=
 =?us-ascii?Q?mQn0UxGCspYwKLcl6T3EBPkY3DzE/m/X7VaieSnssF3hV005K/Vak8IOevYd?=
 =?us-ascii?Q?AdNnHxZeuALDqYv4wGhi7wqRGcfNhsoMgRsK/AeBwCxl6aCwCXHOpgVOFIqD?=
 =?us-ascii?Q?kLAXTUUlEpMVmRAAPk/KItDE9jBmi8YQyVVBxbkeeDjg1JLcRjRbs91dCWID?=
 =?us-ascii?Q?pDWplIRK5rE8YBylUDjx4ZJZR48H9OBuH4KlQaCgTd3LubTskqoMMbvEj/wp?=
 =?us-ascii?Q?3Jr1EYrsd7GOneVx/QExgYRGxKgWckCXiWkW6gBl/14jDDh8Cnt9iA2D7GbO?=
 =?us-ascii?Q?bW05aeCnHEM4BLUFoY61NC0p1iVs90mR0NsuPgk7APS9y6Y3UdL8mEv1kLVF?=
 =?us-ascii?Q?/ffTsczI4jn/bh7MnNI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbcd26f-456a-4255-2d82-08de1b7f5a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 08:51:32.3804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0C90Fie9mX5VHCMzT6+v56SaunqSwJy9eXRBfSPyd7htkUlcPedsqaxYF0cGaBQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Tuesday, November 4, 2025 2:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 10/10] drm/amdgpu: initialize max record count after tabl=
e reset
>
> initialize max record count and record offset after table reset
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 3c646d9dad77..d7e2a81bc274 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -459,6 +459,9 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>                       hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE +
>                                       RAS_TABLE_V2_1_INFO_SIZE;
>                       rai->rma_status =3D GPU_HEALTH_USABLE;
> +
> +                     control->ras_record_offset =3D RAS_RECORD_START_V2_=
1;
> +                     control->ras_max_record_count =3D
> RAS_MAX_RECORD_COUNT_V2_1;
>                       /**
>                        * GPU health represented as a percentage.
>                        * 0 means worst health, 100 means fully health.
> @@ -469,6 +472,9 @@ int amdgpu_ras_eeprom_reset_table(struct
> amdgpu_ras_eeprom_control *control)
>               } else {
>                       hdr->first_rec_offset =3D RAS_RECORD_START;
>                       hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE;
> +
> +                     control->ras_record_offset =3D RAS_RECORD_START;
> +                     control->ras_max_record_count =3D
> RAS_MAX_RECORD_COUNT;
>               }
>
>               csum =3D __calc_hdr_byte_sum(control);
> --
> 2.34.1

