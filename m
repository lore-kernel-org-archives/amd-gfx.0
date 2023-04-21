Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0397C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 13:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313DD10E31C;
	Fri, 21 Apr 2023 13:39:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7EC10E31C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 13:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlbiPhWGz0e+3Slw7QCVwWN+Oqv1SjeQydSFR1A1MRiV4DdG0shgOJmh+ZchAhKqcwjEh3ZKDHjNvTvfX7Kr/KEsGQueXw0fsROEgSgVnBb/+ShRV9exAjvDjsHO3S2Coxyqg/Db5SBW/ZJl76cE++yJLhEfvoos+RmeixQtCwqELZGD9IBVohEMv8Evg49Wh8jXIt78fPuXNq3BAplWLMeIJmA83ubG7PHZGr+lksyQUTLqrjnwsQmHKTsCOEJedaVweV2iCa+Rj0FKznFUjxeNSG9n9KnPCciYv8jmc2GUyrffXBBuscnA7g5OdrEIZjCS+X6484mm44GSQet8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVOY2Rx5Y5VqYpX76vfkGc/4X9CnV83WQ9fr7Q621ds=;
 b=YXF2A2Ntq7t1PJyPaqwNgYMzMyplUGeN0vcf3/vlKb2vqWQBZ+6luy/mKcLSsc2YPOXsiKwRKqIlwaIfE1FXfSSafjuQi4RzjrqSOrz5115ovyu14CgFPv1zMPnhj743BBz6Y8qRE+c2oEqxIREiEGY++uEWlGOwtXh2IEMQrM9eCPvTdTTUDPNdPQOv7a1KZB4kweFpYcprlk0uBCfG9Gu8E5azzRIv32RKzADhnx4vfp1ELPmLrE9ukQ8qylXcMBzwX6pZ9g29uXAfqbq0X/T2E/VNtA524nu3WKxeWNXy5zKvNs0zmeLhaWhUZ5Li3nnnY0nV1FDmqqls3bR/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVOY2Rx5Y5VqYpX76vfkGc/4X9CnV83WQ9fr7Q621ds=;
 b=QRgiUoj2V5S9VxLn+j8XYk+/CsSNa0pLOhv8oB+ENyZsnz1KOVp1EbCDOKn9TInckOYIQRKBifKaHRyqoWK3egFL77kpEGb+IUjXUPmOYhmgv539Tbgv5dkw0VsnbguoPM4SO4VFPKarEs/Va+ksYHrDK7c3XkEnmBZg9ZRutww=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Fri, 21 Apr
 2023 13:39:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:39:42 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
 some sienna_cichlid SKUs
Thread-Topic: [PATCH] drm/amd/pm: conditionally disable pcie lane switching
 for some sienna_cichlid SKUs
Thread-Index: AQHZdCMr1PfyJL5glEekOekAGuZ17q81xRUw
Date: Fri, 21 Apr 2023 13:39:42 +0000
Message-ID: <MN0PR12MB610149D07DDF67122A2D2518E2609@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230421072835.842112-1-evan.quan@amd.com>
In-Reply-To: <20230421072835.842112-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-21T13:39:40Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fbe95c77-144c-450c-9c16-b2b32c0962ad;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-21T13:39:40Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 5da6cf6f-894c-4398-b943-e2339db0165c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB7202:EE_
x-ms-office365-filtering-correlation-id: e6fb3206-f3e9-4cd7-662b-08db426ddcec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: teg8epr7wFQx9WyDYxKQmCSKHLskc6oqdjjRJWFcNMZu7azJdQvbZ+5mAGOO1Um2s3YurqYRWG/KCUblyARzCZuPewBg9n1GvvJHJmWZnKtWg011MIw9vF1LI1+VU6bVIZXpmeTcasmHE569EpUxn4FLeyUYszA2q2DrnE1C4fr0JpAP+1vnG8fx+LcnG/cJyFPeeF6hjR6IiDcqKrCH2ZRpcdVZfKZLYUOEMiQQcEBIYj/nD4RkBQhg3l2F71N1wW+hAmZginZ30RDGXgG2uxE+MUeV4+h506QsAmZGaq6oqLqTmquFnAYA609QwwjX1qk2w7NQvsKXVPVZkmqTwSj9iWb32CxT9RlDz5eetFoYRU1jQ/yWXfGJqhWHQnVgI6+jDyB3pS6UlKNo1e7or0OY4f529ChJmvrU4k7AcQ6vn3uRpAJcc6AA5DXbjHAuZ+qGmtl/PafFyYq782nutLNPjIIsOfkRs7qkq4n2K1SwwEIOUV0Uq3Iq/OmV25a7OSp5iwW2JcCe0bB774h/i18hWUeGsCOLssvufQpByD/mv+Wain1FrgextOGTVciABZUFAr66KHBshsOluEKkqP/TjrUPF73LCQcnQFwuHCByzojl1EvV3T2SfTR0RlTu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(66556008)(110136005)(316002)(66476007)(66446008)(64756008)(66946007)(76116006)(4326008)(186003)(53546011)(6506007)(38100700002)(55016003)(9686003)(83380400001)(122000001)(8676002)(41300700001)(52536014)(5660300002)(8936002)(478600001)(7696005)(71200400001)(38070700005)(33656002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R0lzuAZ3d3QO2xLMKllRufAKzaRYOas0MIDOmoifTzpyxxSEEq8lq6rh1MKh?=
 =?us-ascii?Q?DZytVKBMb+Qr1rdaqsZ7g0QNpmb2pRHmz4GF7T9l5UZtrpk8nzJFFcNCpKvY?=
 =?us-ascii?Q?H2dYCSVklvo9KqgrvLJgDnF7bP3Tjkdt8kF+DjOoEiivFW2npRkN5oItXnMl?=
 =?us-ascii?Q?Wqti+nyzjttvdX3BMbPGzyKYw00b9WaEhFLYc7YBE+JmRqX55vZWtvkizm/z?=
 =?us-ascii?Q?ztd7bnQ7GP40p8+2ab9Pd46WUlwdQAm56FtoELRvAJeiFGI1v1lgfUwYw/dw?=
 =?us-ascii?Q?YxFirGjSxHVCjK4gqpuZaRq3Ja2scOgmlFTOurVw5MjXvSPlun6kXgDdjbSk?=
 =?us-ascii?Q?J6U/EUZpjYF28DtyRYrAOpg/NCl22ws+Cz+E4KLPeQSVzFUD6vLtSeCSO8NQ?=
 =?us-ascii?Q?wIX5ugKNsfhwCQ21h1OjaLMIQJPUkZignJKsGJF6zG1j5n7MCmBTghXTIguL?=
 =?us-ascii?Q?l3BEVSWTA58daAMs40E1YspjIJxm5St9gRrCIl5XBepJPVlWNypiAhZFOhpn?=
 =?us-ascii?Q?0Q/f+mFOMl8QpruMHuRH6mcf0Q9w20ncvWEok4WDajuK+tIlFuyktQ6vyYmN?=
 =?us-ascii?Q?P4cGuh4ylC4zLonFpbovRaNMaEAAgHex9E/v7YpV9lPsMjxFzDDjFqAOBDGG?=
 =?us-ascii?Q?xeNL6gNXp/h521l4y8voyozOZPeqXqnBX2Reh5VAFtI9GQWz4NvXHbkTJcVm?=
 =?us-ascii?Q?N5wScPdcW9nER4aonnc/8DEmxJvFEs2z3OoOO/5QU3SCpr6iFRrW6TqM7WZM?=
 =?us-ascii?Q?oVFwYVLRQSPeTg99Xc40RffQQ6YTs9wvMV2UbBdozp28+seZl9aSEv4vudCL?=
 =?us-ascii?Q?3wWw4EvdlNtTTTeHokVjL2VNP3JYgD4ItUo6+yjV1pkdqws+n6ywfyk+Ik8z?=
 =?us-ascii?Q?ye+yDOFuNVezr7gLjdm2hPOLn1kLkWlUxrpFryqS06uDqTmoJOn1qeZumUC0?=
 =?us-ascii?Q?9TiGS9/UPN+FnPNKctbHbyac32zQ/E/6TQ+AsTOCHFI/HJNxhpDQ4fclcgZX?=
 =?us-ascii?Q?5tgRDUTCYPe7dOXQ6zxRf6i+mhNZfFWGgKV9oySACqTxd/wkawJMhgVT5r8j?=
 =?us-ascii?Q?cFjVTOc4cOtxOc4RdGVdgbjMGwtRHp1OUGCxFT0RQRq90ER1budKtjuWTHDl?=
 =?us-ascii?Q?87KtGFhmUIjHk+TqnxPDWAhSWkxA/UFuJZVQ7I9kZCvke/vuveHXWyRqcuZv?=
 =?us-ascii?Q?bLIAD92GzE/vI1g1q9aAm/OLx7c+WrKzWAAPtfpKxIXGx25hbeH6SWkU7W32?=
 =?us-ascii?Q?n8I3MM1e1u0BzLYKFzJrm0N1PW7fI3ta1gy4d7bzz/oKIxbUUltjlxo9lPvM?=
 =?us-ascii?Q?jDMB3rJP+HKcojDHPvQnDM0LLP7aNvIIrEL8oFtCW18wVINX3pnZKyAbE2J2?=
 =?us-ascii?Q?V4zaHwUAliY7WDcFSQnTuSYxtfxoqY6hHRcG2cR9tMHNYJMox/2bxyXrEMMB?=
 =?us-ascii?Q?EfyAVZ4R8/bFprFDVfW6AoIW/Zod6jPPHgEVWc0wDwdhd7m/J+KR3f2wfsNA?=
 =?us-ascii?Q?9jJ5zySf3PoYBIz2P0aIv3My3S9nibZtQEOORnVjzsNgsk9tXe4Ll1e+ORIB?=
 =?us-ascii?Q?VstaYtwoz6ISy2JbTMlERVTAf0DlKDYIhNH9bVzs00Vr1hKGAkQEjcGAo+FF?=
 =?us-ascii?Q?3Abul45P0144nz8CAPyzPTE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fb3206-f3e9-4cd7-662b-08db426ddcec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 13:39:42.8219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1tCEEPGWCHa/cpzxVbZfljQWuJomWQ4YwjuDa92DjrRn1x/CZZNoe88OLhSu7ubxv4sfVY8Pz90ofuQOZ5EbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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

[Public]



> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, April 21, 2023 02:29
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

You can drop the Gerrit Change-Id here

> ---
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 92 +++++++++++++++----
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
> +		max_gen_speed =3D MIN(pcie_gen_cap, gen_speed_override);
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
> +		min_lane_width =3D MIN(pcie_width_cap, lane_width_override);
> +		max_lane_width =3D MIN(pcie_width_cap, lane_width_override);
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
