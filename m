Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E209CD3C536
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 21:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1DA10E22F;
	Thu, 17 Oct 2024 21:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OWY7rryb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A708A10E226
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 21:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vndvSKl1U7/9MLcly+zxar/NF3L8TnLrIw2f1jMBCsGgRLyY67E6U79/a6swg01NmwoLKsdPCX8yq7TByOu+q8GpMEooXknvCa74ircohiqoy+TtskPwf9JvjMELkG/SDsMijpJDwreV06QC7+0P1K5EpoAgNpmY7ugzgKRHdS3bRGwy2OOVeErcOnAbPZBPeogr65BDcw2rJXszdNhX7smmUxkfNV3UcsDvvPquMSgG3jzmnbpZEmKHXdfRfjyPzDbSzUsRvkq1tDeONS4/6KzgMZs3PwRq/N8gUaamT/2sC6Dlbrch/d8KJU83VNoM88jthKw24UGVJ2SphbknLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbmo2B9mUQgeV5kL44v/WRCqSF9dTXf1lhMFcDQCyRM=;
 b=HQYykn7mOVYbK9xER/6267aW3Hwa/ygPDs7YRqWV0d2wlmMli3EMGQJhpQ1VnLQ1tVy4z17xVi3wiQAUzqzOwUl4mmY5/UAUNqbT/bpE6iWI1MrGstPHVEZLQLalHXh5jsAHuImc5ZO7nHBrKSwwV1PYSCe2MkC/NnxZF46D4SEWT6bRFfqCEC5hfJycgUi2ZZrzv17qTl8m9/R5M5uPjJ70A+96mB9fNNJHn1CyxiMxzZPiFssmOMv26YgBRMYsG/RZ/46Hm8mNWFxf7EW6j6MaEXXdLZDOTOvGjWLRmhDoqoxEhLCHK+2Ax3TyPSH8XqGJRsWfqKeDDcmckcoO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbmo2B9mUQgeV5kL44v/WRCqSF9dTXf1lhMFcDQCyRM=;
 b=OWY7rrybWD4tWhrF2FZV1GbyjHV/lll7Iaf6jaH7Z1S6eKipcC9sgXqMgtuHAW1FNLwYl4jYdUYHYLJP1MbNoDs5j7j9q0+gT3inzyIWoIBOPx7fUzqZi2ou+w1jxedC4s/b9tDSSnUuqQcDLZ/qrNMcLHvzrcX9YJDhHtzkwl0=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 21:52:48 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 21:52:48 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/display: Add hpd_source index check for
 dcn401 link encoder setup
Thread-Topic: [PATCH 3/3] drm/amd/display: Add hpd_source index check for
 dcn401 link encoder setup
Thread-Index: AQHbIGG0kfVDd9XXG0KQuXoU9O+3wLKLfL5Q
Date: Thu, 17 Oct 2024 21:52:48 +0000
Message-ID: <CY8PR12MB8193F338E0FFA07E4B2B3D5D89472@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20241017065614.3502792-1-srinivasan.shanmugam@amd.com>
 <20241017065614.3502792-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241017065614.3502792-3-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=2a05dcc5-9a1a-4643-91c4-841ffb658d7a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-17T21:51:57Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|PH7PR12MB8796:EE_
x-ms-office365-filtering-correlation-id: 645c5aa1-bf75-4e47-5f31-08dceef60a8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rkV5MMYYO9PHA6UvQk96fGxFBOgeUIAeonGXowUfPNBU8RJ9REl7xY9aBWvL?=
 =?us-ascii?Q?Og/iTNUmSqVaqmdd+PoHcs6ijYZBp3wVTFME+K7C+GoLcy1cjsZLrdTYrH6F?=
 =?us-ascii?Q?WSni7kLxXPf0kq0sBMxJmqKGz+AVs96xzhVLS5Lo4rS+Koo2FlB86myBdcyU?=
 =?us-ascii?Q?SxIXOZC8PWrOm0Qw7CXfSYwPh1FQ0WyvpoXLH6o2R7zKaF15j2wXzc6e+mhK?=
 =?us-ascii?Q?jHNuE49sj8Kt+hthJ6Jld4c8X5vJ8F1+FIc+s4x0InS5yMhwEtqL3hnPj32C?=
 =?us-ascii?Q?IE5TxkTRJVnknjaqvfxkjFYHGeMMSVsuO3BtLvEjJ+eB+00JI5gFylBJGVY6?=
 =?us-ascii?Q?Vt5iYrNp7/Yodh6SV5XPNtRRGotgwZj80LMV7l/7K0s3tFltSjywihRRQk+d?=
 =?us-ascii?Q?jj7KCLR9dTH3VxIIpRGMP72zj6eEl7CBrnqBifmPuG0a17xednfy5AwnMCZ0?=
 =?us-ascii?Q?sEIHfb4E1R1s8gXpWCHxoRUhg+TbKC7oh96IDVGvwNLmgQrXR2e7YViUtnpK?=
 =?us-ascii?Q?ynPji9iQvRZlQbOlXCzfarrqpXpMo70Or/KarCUOk6u5t9KVO5T0L/ekm+TR?=
 =?us-ascii?Q?CGITwsOG7jwlBzqp3JwU+6m0gbQzSNgwqy/kDCkT8U8XbRW/l1QvB/aMHfAN?=
 =?us-ascii?Q?RzzYNVVWXtJ//tcU9WB50skk4CSXPx/qNUIObxWQim56DqfKeuc4fL0ZkGMA?=
 =?us-ascii?Q?sxA7MN94r7jxXI5X28t+trRjVGu8jk58ZdI8ZOHFWLDlJnEjXoAL+FC0AhfV?=
 =?us-ascii?Q?+Z0ycUMXjWtnzbu0yxLdxEDaG6li3uK3o1pg50j9qiF9QsUcHAibjfQDu9Si?=
 =?us-ascii?Q?BFTYbdudJJuZtC6C56ZZUbSDZI4YFMREKdZGTVI+bIVezuzS22SVndSvUakh?=
 =?us-ascii?Q?990wWS2ABCDs8luR9gc+TyBhJbbWPW0D1JQOLKQxT2qTKwbBNTT/f16dDSme?=
 =?us-ascii?Q?uUF3yLIvEUX9p/49KdW0WPJ5CmttxNRMsQJYqIb1UkWU8vC9Os6Li3XGZeuN?=
 =?us-ascii?Q?jXmot68tvgDxUVLqlUUXyJNbRXIMwojc+V1NrYcQMwBFflbBluBYMcUvq1KY?=
 =?us-ascii?Q?sIm2mLrimwVxFutxV5koMKBBN2HUUn0Y3jO6IMagNa4v6+to3kcma8YkKOLt?=
 =?us-ascii?Q?wNNXW4KCUcPTK3oSQB/lGPrPCK0FhydTKTscDr8qjFFvVzHKygdOUwBoeb2E?=
 =?us-ascii?Q?eir+3r0+cBMdIWGjePnyRnJ7VDJqtqOcjdSfbwocmbbuJZet+/t5Jv62Eaf8?=
 =?us-ascii?Q?0TOnKJKMb3LGpX93YKZYhJsvZD9oFMfsLnkBy6zhqeykV84cQNO2bbqB3yD7?=
 =?us-ascii?Q?M29VUhrKxsC2mnMbS+2cfGOQlKU/KFIzzWAaUDb1HqgVAvPCdOTUBgNrV+Da?=
 =?us-ascii?Q?3iDYXhs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e6sO09unziQmOYMvwUHY1OXcy1r01e2/qs8WH0m6aifCyecMBDsactqXi56f?=
 =?us-ascii?Q?4dCdglAmiwjIvG429GPxbh0bj4O9oCaHyChXgV0QXD45GFvWsES2JVytQZg6?=
 =?us-ascii?Q?B1awzO5udqP3DogBrIKvXHnxDZjYskVXgaogI6+yODryLvoes0kW64Z5fXrP?=
 =?us-ascii?Q?9k061Q0OyLULYukq04V2Y1lSQiIL0K5kcF4cIMkVTZQScGUVFxk0SEVJYTqe?=
 =?us-ascii?Q?LaLvTriNZ8aJgtrgTke5lAQdgy6Qz1OcKVRyjBY+FuD3wctz+tUBliw0YBB6?=
 =?us-ascii?Q?2uV85/2z/MLvt6erzcSO3QtJnWi7D6uC11lXex65WQtsHx5Acj8+7khCq+ud?=
 =?us-ascii?Q?JfEliZdnMAJMHWHf5Piotz4x6+LYXFjhBbuOK1VLLkRMsliAYLs5z+KnGobG?=
 =?us-ascii?Q?m/F9fIGvEvJ0FNh87qt0Pmn+rCHVv8wdXkSol8mE5AdU+LWT8BDAADEhQiv0?=
 =?us-ascii?Q?nkc6WpAec7cvmmWTOQeWwI01KkOTGG3ypJZtC3kE1jvswJ2wMW5ysoq6FzKY?=
 =?us-ascii?Q?Cy7Tg1zynC95RgZ7hhAE1/uigrYBF06zIu/EZ0+pSkVjFqTym7+FkBqBRgSF?=
 =?us-ascii?Q?pGLU4YcEpiY5UgT2+TkynpOdCNM5lpVmMjur1fMtQdP/dXbvbFDlir8W8kMw?=
 =?us-ascii?Q?0KaQ1rmfH9RjgQ2eLPg983bQy/gnlF6/rIeTtiO4OTy/c0uePZVayvtPSgs6?=
 =?us-ascii?Q?tbb6xdATCEWdqGPMAYTSsOzb/+E6AUJ5bEysBaAYTYhLzFq3aRCM69zxBOAy?=
 =?us-ascii?Q?akCBQtyLRHu845MERdRxJSX4eS8QJpPwXNKkP8ibIFkPHN7IhsCPO6UXH/h3?=
 =?us-ascii?Q?u35RgChc4bcRe1qwEi4/U0babNYY0VgAbXP7zckOetU+rcygjUeE1c4eDXI5?=
 =?us-ascii?Q?gJeCbAFEalhMa3fUUsGvxlK4yPq9PrFKT5Jj2B2euL73+GvExukEJ7KiIQfb?=
 =?us-ascii?Q?0/g7DWD2H9xyCKM6cE0ooLVNVMSrgKcs0YQ7dVYLsjQnDbZhs4HJ1IRvsqAb?=
 =?us-ascii?Q?SUqrh25N75LRVOSufwB3gFA0Aa7GlqPSjxyka9RM2xoptCUXDCD/HUtPD3zi?=
 =?us-ascii?Q?M4CDVqdgNMSLJFAcvZQRkQ1U5ec2RNeHDkJw3uX4nDjAVMn//hKRdwgzCS5H?=
 =?us-ascii?Q?65IYAjCNYFNKdRzZPpFBv2zpzo4zteaaJzw8AmYZxqJqGiyveE1tCPyuNpI7?=
 =?us-ascii?Q?OhO+yaQjVCk1z3gWPRFDInKmcWN0Weh4bDyBpOAAepVdMb1ryrbBHNKpm6Bq?=
 =?us-ascii?Q?sc5HiRw53akuqYLS5id8+T/jbeUoAI5nFX3zXikYv3UO3DJ7uhxjZhg+4Hh1?=
 =?us-ascii?Q?H7hzGBGae8P6ecPyh8nb+SwsKJbSdleOEZWggE2RAaOm92Jqh3Ay7O5hGot7?=
 =?us-ascii?Q?EYmZnZUMwwHYb6RPb0vMSevEgG62fyISNdRDIa9Msn72g2BnyvoJ8p4C4Biq?=
 =?us-ascii?Q?BTPc2RmW5pvXVR9k+mDBN49Xuv/JfsxRQkv5hXk7lKVlXQnlHawMvLgxzGKZ?=
 =?us-ascii?Q?hZfxtuW6REHFqfvSIDsB41yny2BKXAnbYwEojfCcBxANohjalvklDu3Rqa9n?=
 =?us-ascii?Q?98OPfdlamTFo10UQPRg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645c5aa1-bf75-4e47-5f31-08dceef60a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 21:52:48.5985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfXNoP5vYFk+shjlE1rxZuoeTk2mmDAdOkhx6zHKWmI6EfyA1wBHAQrTpJlA7tk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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

[Public]

The series
Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Thursday, October 17, 2024 2:56 AM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Mahfooz,
> Hamza <Hamza.Mahfooz@amd.com>
> Subject: [PATCH 3/3] drm/amd/display: Add hpd_source index check for dcn4=
01
> link encoder setup
>
> This patch adds a boundary check for the hpd_source index during the link=
 encoder
> creation process for all dcn401 ip. The check ensures that the index is w=
ithin the
> valid range of the link_enc_hpd_regs array to prevent out-of-bounds acces=
s.
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> index 46feff9348d9..b425b34dc7f5 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> @@ -1032,7 +1032,7 @@ static struct link_encoder
> *dcn401_link_encoder_create(
>       struct dcn20_link_encoder *enc20 =3D
>               kzalloc(sizeof(struct dcn20_link_encoder), GFP_KERNEL);
>
> -     if (!enc20)
> +     if (!enc20 || enc_init_data->hpd_source >=3D
> +ARRAY_SIZE(link_enc_hpd_regs))
>               return NULL;
>
>  #undef REG_STRUCT
> --
> 2.34.1

