Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA22FC7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 07:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3286F10EDAC;
	Fri, 21 Apr 2023 07:32:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C4910EDAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 07:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKQkChRLdg6r4kUbIJSUhm3rWjmoYuXG0LGYo0CZOygZUAxJCIimtEuHxrOHcPP120+cGpbUcCnufSoHGmXk2I4BWYzq4uNYbZCPOJcWt/KyAhXOnSX2D4g09IgAELsTB/eaPRzlpKuuPawsktsBgg+LCOcgwKspxsSN42A+wta6/mWFQbohIj96ZKG2NsROB1HoBKEZHFSWeVnKWUsp+uDk6CFKqGStHmQ6ejiuJFIpjCqTaFKoeJ1q0d9D09UeL+3CgZ+rnudIhMAbRIs3xUM8vgMX+2zU9Lx7a0EhP/pguYDculEFAta92pUdriQvv8iY2mLlY/qzXuIQVG+3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciSY4F+SBnd2ahQFguOdysVDpaOSgspyDi8U/OjC/Yk=;
 b=lNu7x+Yk9UZIWRhjfJdkGG9Ev2bIFXco1Dm+5F3q+G1WwmofNMfY8/eb+3KJ8mkpvYqCqGAUOppQIrFnqMmHCnXM7ZbaQwCvhfFuk2kUnb6q09oCBbDpylq/2kXs/ddASFtM+zibTzgmVNQxs/fZ6VtzR9GccO+1UDOA5kw7L/rlXnezt3ARiYFY3vV7Wp5+jYb8e39VI9gvfLKv+xoCm5h1csxbmBM318driyV7nrrosTrnAA8zDMe++0GDt9oeGFHeDPSfoxbyOQzaIS8hgk/e0bQc30EzVA97BA8lk2ssaskGvK7JDXQsjxRP5TNVrxQ/ExoMysGWMkmNpaac2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciSY4F+SBnd2ahQFguOdysVDpaOSgspyDi8U/OjC/Yk=;
 b=3gxlCE4VEEZurSrROwRZmOHZYj20eItP9vC7DUKY6/XfVY7gIdzPs4g8djdR+VdXgKbD1O9sS1Mp6rrBI4amkjr3DS/36E7CFrLsHGC6o7auc7GJ7NpXOFaubh+KIa3s5/0xF2ZSVBCpye8xovgFej1EhzoSRLYv5Lezj0dhJJk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 07:32:22 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6fe7:b96c:789e:3eac]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6fe7:b96c:789e:3eac%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 07:32:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
 some sienna_cichlid SKUs
Thread-Topic: [PATCH] drm/amd/pm: conditionally disable pcie lane switching
 for some sienna_cichlid SKUs
Thread-Index: AQHZdCMrO8z5sJilnU2X0klm9jkjYK81XidA
Date: Fri, 21 Apr 2023 07:32:21 +0000
Message-ID: <DM6PR12MB26192A46ED09CDB6BC1A3BF2E4609@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230421072835.842112-1-evan.quan@amd.com>
In-Reply-To: <20230421072835.842112-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T07:32:18Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8322a7dc-1eb7-4d28-af95-d689cefd7548;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH3PR12MB7692:EE_
x-ms-office365-filtering-correlation-id: 516d56b3-585b-475d-6f7a-08db423a8b72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/gc5h3spjSRPPe2XxgJczyuRDefCgqyrtiFhPG9skXZed79wkMdyjUk6MI0hF+ZpBOSNDYLz25EGb+6znYDyw/n+41yIq3VezCXJFNjO9QL7EOqxeFg8UmaaCnNx9pdWBCUUamHJHW8QGnJfGKfeG+1oRKkocYtvcQXIXUeVQxFYZxDBrVF6UkwnYI+6axbijXd963oSUmZG3KKYSauDMb7lBbG9KcGsf8SWaOiYM7L1efwiE7hhXmNQ9PcBtGLeB3YalYQF0R8qxxJ9DJELhBxvEHIUD1WDRbM1RNJJ/xrulFiIQRjCR8LZdTmu00R6QSi5b1QUnOKQF6rG187zWBiuCGlgdCS2KGuPLXPK8MyggNUuiQ93qhLEp+Oa6hInQFw2imffnjAhW+H2+nfl9IsdKKyB2NC4GYUQP26CNzo6BHKqxHIBHSitJw+wI2/sDdH2ANe4BZYiC4wUsAnqMDNY/GmenpduqJc1CkbW4cwavL0zj15BRAnviuvFyU9tL4mkIIUwIxhwOOwS3tLS2uSZm+8e2IeafSHBmw2S1IGQM0yUDnfQSh1E/at8guUnNOiQucydabZ2p0cGqPklaodNW26Cw5/5sq1avQOyGgXtzXYDqht/OrvRyFAPwxU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(66556008)(66476007)(66446008)(64756008)(66946007)(6916009)(4326008)(316002)(76116006)(55016003)(7696005)(86362001)(54906003)(71200400001)(478600001)(52536014)(5660300002)(8676002)(8936002)(122000001)(2906002)(83380400001)(38100700002)(33656002)(41300700001)(38070700005)(26005)(186003)(9686003)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/K95S8OSt5XCoLNYPf03HrdCHXKrti8s7mEJjSWi0KIlQGS/cMCgxbSCr74?=
 =?us-ascii?Q?Sm+uAJdLfnHumDVpN4kxelvSI7iQH+sCmXN1A8dZgNCnzHX2tjN6+pn6gXmG?=
 =?us-ascii?Q?NF8htcTT5kpfaeN8KIcZ7lGAXqRhZCynJcFcHsKlDs8r3QpCVuzHTJE2KTwB?=
 =?us-ascii?Q?wk/R/2B00WaeDybDHQQ0V+Jm60wC/lT+ji/A9fBX8Rg9oRuWE7XF9pnu4PMw?=
 =?us-ascii?Q?/9Jq/gz4J/3d8YKjSrdQEo/lHl24U1Xgp3K2nNKxJ0+jaaLwrbOOoNJO38IL?=
 =?us-ascii?Q?Ylw9oatYnEZqTxac4h261Z8hlR6NhsHzH0f791dhxA8TIKIK3Kyt0bBFrNKb?=
 =?us-ascii?Q?coV9ZNMOfpOTGTH3p5+p4aAZOI27VmMxSyisAEOD6SeEXctYtDVVWNMLf8nc?=
 =?us-ascii?Q?vY9YPJcNpfBCcdNi3W8AfcAx5Kzr6uS+gIKPHgnjXT3SBxypQY/F2XPpawhi?=
 =?us-ascii?Q?XigDVXdKuboudREPzt6yIhu1Nxe2I4iuOBfhbPueFU7zUYlWH/5QGyKNWslZ?=
 =?us-ascii?Q?Arxsh1n0hIoXVYLeaa5BiwuTn3dZND+NjWQFGOQ/HlqzgSudt7icFFqk7/NZ?=
 =?us-ascii?Q?9rJMQ9uOPbEK0uROLaGU+deNgLfVvUhd4kCDqBkeylfXK1wv8CEKVVznA0t7?=
 =?us-ascii?Q?xCXUUY+pJpQQv+iFkovXHiiuDEwk35viaXsLKhLOyAM/es4qwQJXbGbxUbew?=
 =?us-ascii?Q?eraGRl56JrVUaf1Ylxz/bokgngzKKEH3LpcX+JpKeuvlJ00SzQp6tXR68TmC?=
 =?us-ascii?Q?dcmaM4myaERXDLhMDBuzKcKvQTIJxFRKmEH5V0+kf17iI+GjpzLTEo3Fkim/?=
 =?us-ascii?Q?JUy+6gYLfLUnn+xh5zgIc4qqwBYT7xyze4n3Y8dcY0BsM3T+l42eYWUViBsZ?=
 =?us-ascii?Q?w1RZAaK0tQoTKDmdF579JsxXOrvBPi/9msZZdQUoEQJ8sICPjxBAUOeGfZSy?=
 =?us-ascii?Q?icayplCwmmF6/mb7Szy3C10EvvI0cMwNDZpQTf+cDzUiaV8xZ10KBOfksgQt?=
 =?us-ascii?Q?fgHZsxkT5s9GlJ72yfoyfm6I6AQw8NkbVJ4RcCraQ66/zuIr55HVj/uzEuyP?=
 =?us-ascii?Q?S2X2yGVSG81m0xa3Yn6vkawnRSzCi5j/kKbGxfot+e0WwpnVq3QZL5q2CelD?=
 =?us-ascii?Q?Ui1Geopejx30TpuzwMV/ElIgai97U/DU8sWbzJXOV/qf/Cn/7nsAJhev8dSC?=
 =?us-ascii?Q?RPpl1ZBYyudgxkUDyk6tnszevHR4Kx39Sxy8ei8rT654y4+8f3YpbsgN2Viz?=
 =?us-ascii?Q?FSKbo3XK/FW9R3lub/h9CFpz44APlCD/utzWyL9UUtURDvJPnqcBupiL4naG?=
 =?us-ascii?Q?WzDEw6G4qpSNk973SKZKX98AwFN24BfADtsfglGXKAS8Is1/ZM4yCVJtLmx0?=
 =?us-ascii?Q?XFW/QjWiOqKC2yEnrNxiPHrqZpz6zT3HRzwk3rQnjflOj3cCvf/Jxja4fqim?=
 =?us-ascii?Q?OUiymqpfRnuimeAQXIgtMPVfx1FT8veAMG8DM0XuIZnk++5aKQ3TeYirDgwC?=
 =?us-ascii?Q?SbMFrYbnybOBRfhGrewW3YrvWFUgg7QT9J+k8JO4f+vKwDaUQEhbLxyCpJLG?=
 =?us-ascii?Q?5RWjUZdgDWqWxtEYMqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516d56b3-585b-475d-6f7a-08db423a8b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 07:32:21.7696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtkCb9pvcHr7BZSnRCM3GMlrdj8bFRD28RAN+4UVf38MXWFCHYmYji8XFHRZIBe8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This seems able to address some audio noise issue observed per customer's f=
eedback.

Evan
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, April 21, 2023 3:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: conditionally disable pcie lane switching fo=
r
> some sienna_cichlid SKUs
>=20
> Disable the pcie lane switching for some sienna_cichlid SKUs since it
> might not work well on some platforms.
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Iea9ceaa146c8706768ee077c10e5d33bce9bc1c2
> ---
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 92 +++++++++++++++---
> -
>  1 file changed, 74 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 4b91cdc3eaa0..e7223513e384 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2067,33 +2067,94 @@ static int
> sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
>  	return ret;
>  }
>=20
> +static void sienna_cichlid_get_override_pcie_settings(struct smu_context
> *smu,
> +						      uint32_t
> *gen_speed_override,
> +						      uint32_t
> *lane_width_override)
> +{
> +	struct amdgpu_device *adev =3D smu->adev;
> +
> +	*gen_speed_override =3D 0xff;
> +	*lane_width_override =3D 0xff;
> +
> +	switch (adev->pdev->device) {
> +	case 0x73A0:
> +	case 0x73A1:
> +	case 0x73A2:
> +	case 0x73A3:
> +	case 0x73AB:
> +	case 0x73AE:
> +		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
> +		*lane_width_override =3D 6;
> +		break;
> +	case 0x73E0:
> +	case 0x73E1:
> +	case 0x73E3:
> +		*lane_width_override =3D 4;
> +		break;
> +	case 0x7420:
> +	case 0x7421:
> +	case 0x7422:
> +	case 0x7423:
> +	case 0x7424:
> +		*lane_width_override =3D 3;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +#define MAX(a, b)	((a) > (b) ? (a) : (b))
> +
>  static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu=
,
>  					 uint32_t pcie_gen_cap,
>  					 uint32_t pcie_width_cap)
>  {
>  	struct smu_11_0_dpm_context *dpm_context =3D smu-
> >smu_dpm.dpm_context;
> -
> -	uint32_t smu_pcie_arg;
> +	struct smu_11_0_pcie_table *pcie_table =3D &dpm_context-
> >dpm_tables.pcie_table;
> +	uint32_t gen_speed_override, lane_width_override;
>  	uint8_t *table_member1, *table_member2;
> +	uint32_t min_gen_speed, max_gen_speed;
> +	uint32_t min_lane_width, max_lane_width;
> +	uint32_t smu_pcie_arg;
>  	int ret, i;
>=20
>  	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
>  	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
>=20
> -	/* lclk dpm table setup */
> -	for (i =3D 0; i < MAX_PCIE_CONF; i++) {
> -		dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D
> table_member1[i];
> -		dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D
> table_member2[i];
> +	sienna_cichlid_get_override_pcie_settings(smu,
> +						  &gen_speed_override,
> +						  &lane_width_override);
> +
> +	/* PCIE gen speed override */
> +	if (gen_speed_override !=3D 0xff) {
> +		min_gen_speed =3D MIN(pcie_gen_cap, gen_speed_override);
> +		max_gen_speed =3D MIN(pcie_gen_cap,
> gen_speed_override);
> +	} else {
> +		min_gen_speed =3D MAX(0, table_member1[0]);
> +		max_gen_speed =3D MIN(pcie_gen_cap, table_member1[1]);
> +		min_gen_speed =3D min_gen_speed > max_gen_speed ?
> +				max_gen_speed : min_gen_speed;
>  	}
> +	pcie_table->pcie_gen[0] =3D min_gen_speed;
> +	pcie_table->pcie_gen[1] =3D max_gen_speed;
> +
> +	/* PCIE lane width override */
> +	if (lane_width_override !=3D 0xff) {
> +		min_lane_width =3D MIN(pcie_width_cap,
> lane_width_override);
> +		max_lane_width =3D MIN(pcie_width_cap,
> lane_width_override);
> +	} else {
> +		min_lane_width =3D MAX(1, table_member2[0]);
> +		max_lane_width =3D MIN(pcie_width_cap, table_member2[1]);
> +		min_lane_width =3D min_lane_width > max_lane_width ?
> +				 max_lane_width : min_lane_width;
> +	}
> +	pcie_table->pcie_lane[0] =3D min_lane_width;
> +	pcie_table->pcie_lane[1] =3D max_lane_width;
>=20
>  	for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> -		smu_pcie_arg =3D (i << 16) |
> -			((table_member1[i] <=3D pcie_gen_cap) ?
> -			 (table_member1[i] << 8) :
> -			 (pcie_gen_cap << 8)) |
> -			((table_member2[i] <=3D pcie_width_cap) ?
> -			 table_member2[i] :
> -			 pcie_width_cap);
> +		smu_pcie_arg =3D (i << 16 |
> +				pcie_table->pcie_gen[i] << 8 |
> +				pcie_table->pcie_lane[i]);
>=20
>  		ret =3D smu_cmn_send_smc_msg_with_param(smu,
>  				SMU_MSG_OverridePcieParameters,
> @@ -2101,11 +2162,6 @@ static int
> sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
>  				NULL);
>  		if (ret)
>  			return ret;
> -
> -		if (table_member1[i] > pcie_gen_cap)
> -			dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D
> pcie_gen_cap;
> -		if (table_member2[i] > pcie_width_cap)
> -			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D
> pcie_width_cap;
>  	}
>=20
>  	return 0;
> --
> 2.34.1
