Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F41FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E864E10E693;
	Wed, 19 Jan 2022 22:23:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CED310EED2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8lR2VkbWuf2x0tOJP+vpXzKhMBeAXN7u3vDIAypYjj0LW6iLMctkN+77ZJM+JAC6AR7nFfY/BSJpseGR4A0lj8ZNdNlNmTAnruGTI0yXx5Zayod15FVqGaHhhsZDlfUZe4spsHAJm5FuV/TGTwVcDDpLmrO7wtVqpyyLCpOzO/ScbTFu9woWkWc/hYAoSZYmY23R5zC9vCG1FfgzWghlRRrvYnG1WfBK6XGAdRUUIPkr630CUL7K5h9ckKb7azTt4fN8B33lP1IlOzbWfh4S4I07OJMwFtPcColKSgvefTPgGmhqqsAn5P9vNO9UU45L0JgG5b5veohnUGEsghyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLHK/cd6Yj3OQm4awlvAbJIPeSnCrLENLV9xBlPtXO0=;
 b=W0ixk8a5NdR7m9FC3evn1DHDZVimr5MTsAIdP7emTJGMycr9AV9COLFqZ2TqB8SWO3Q0aOWntBCW0h/WopsviJObzpQSsyXkZeBUIYpnfK8+1hCUdVa8YRZ7pOaUnUpYzz8+JP5dC5pOZgHkQCiDxkaS7FHjHLQssq9t2Em+BQnveYsziCgyn8FrNATB5atJN+gvxy/8gx7g60PLLX5xKaibMdx5Uz9LQG+W5lX8C0cQJ2/fl4FEsh9/7glVtdQ1xc1P/6pPSxCM+rsuVmGcVaHne1Q5SfQNc+i7GPGpx4xd4LprnM156S4m9q3YMGb26MF/KzAzg5CBQ/DbCeU+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLHK/cd6Yj3OQm4awlvAbJIPeSnCrLENLV9xBlPtXO0=;
 b=imG/gx3AiI1Zxbvwndc0kd4JUyQD/hlAmm7eVSaBvarDtXxi3ioiCOi3EIDnI93aJjCpueCTYehac/yXedCqic5m/Y8zW8S9VbQGSyi3a67/MUMkucBchdXvKjo5+sEC0M2uZGO6HLyt4PemzJCm/Y2WdqikKcB9PB1/JSps2ME=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by CY4PR12MB1448.namprd12.prod.outlook.com (2603:10b6:910:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 22:23:18 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 22:23:18 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Correct MPC split policy for DCN301
Thread-Topic: [PATCH] drm/amd/display: Correct MPC split policy for DCN301
Thread-Index: AdgNgiSfZQ68VWNLSvOdzBGmHSFrhQAAMoaw
Date: Wed, 19 Jan 2022 22:23:17 +0000
Message-ID: <DM4PR12MB52143588FB672B4D165871269E599@DM4PR12MB5214.namprd12.prod.outlook.com>
References: <DM4PR12MB52141E8C6959D2BE69FAB8479E599@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB52141E8C6959D2BE69FAB8479E599@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2d6fecff-03f2-4daf-9559-df772b55e44b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-19T22:21:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75bb70d7-d444-4beb-c111-08d9db9a4b1b
x-ms-traffictypediagnostic: CY4PR12MB1448:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1448435474D0A4E383463A799E599@CY4PR12MB1448.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sv9rxVqmgq39twWHKRLTameFWWIw0PMrqBdQ/061P277U+9ZDd+5OB54brtovuqdxaTJEYIN6JcQVdIBx1hGhIq2tshqPtjTrnx+fIRrS1n9icjkSqHgZO8k5A80exT6mMI/46rWEYNHeDzYslieY5Y/TluA82W73NYmAZxFn8Hhl+vaR1ASxGdER8GUMm7JhfD3mmTtGhh14YXdAZbzGYgpaIM6crpbhySvjitqi56VRUdi4+VibaXGa+C5NUG7t+xDaSwomFqXXAjwbEznWaoJmATiVMooEeVRdqkqBPTzlaJ5iMIcI/ahjbXQ43hN+sYKjaPoPVPsBVaFk6KczKcFAnZuPMNx8ltUneVxEBehDsJ9SfKkdUQfQf/DZCzC1tlF1NJQPC1CGbmxUO5i2Re7wQFzh+W8ckclQICOr7VChdS8jaYWTvNyE37jFdrRon6BMfvR7GfxmoTpSOe0I2mK8rsPKX6QmdmBAT6/B0uVdrHSCpyuAYT5/lxUNmUdkZJ/hIe07ORFhVuu8ZDYPqMuxbx56ypCQ6dzfrUCl7jkxspcpzIewXLUC3HsRxiB38fbNkE2SZmqL4HaElwCcDyvA1eNAHVNIUGz/RQ4X2hqhzfRzxLEsTFOoL+d9hh6vgFTPgZ3h+N/J7FolhMsP8wwVkoNr+ihOPIU5oHqJCwdIQS9OB2WRKh4DoHL1WsbURQxBfhvzWcg2Mn9rX4LdQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(316002)(38070700005)(8676002)(110136005)(54906003)(66556008)(52536014)(76116006)(66446008)(4326008)(64756008)(66946007)(2906002)(33656002)(53546011)(8936002)(6506007)(186003)(9686003)(5660300002)(71200400001)(86362001)(38100700002)(7696005)(55016003)(2940100002)(83380400001)(122000001)(508600001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d8t40z0/gPrjE+fOdGAByYgb+yKfwjBt4cMUWd0DS6WD68i2w+GZGYIrZbRI?=
 =?us-ascii?Q?U8m07VQpUIe5lAgqyFTxQDswpCTDTrVAXcLFXK5zI42fpnFdQGnD0VxNUqz/?=
 =?us-ascii?Q?KVTG1h8a4tDPpVQjjxntn48DvmqY4iMnHWaf6T3VCjvKvHZ0054PfYE0JJow?=
 =?us-ascii?Q?0JUhp1A8ffRJGNWnT13YQBA9FDp0AFEaKeQN9r6ZgbGgejM9YAyXe1oSQMKB?=
 =?us-ascii?Q?HuhjtZ/5UXcisfltBo4Htf2kDcQXQLW7YNUJT16YKp6HnKwy+NNDctqH+vTD?=
 =?us-ascii?Q?rGrURkGCic3udhX6MZIk13FFJcUAhgO7/hSOjKZe5P+Om1zc17kEDNus/hPy?=
 =?us-ascii?Q?gAG9+stmhxMJz8cL/D0IZYAgwmOuauxNv3ZJXbCdWhGvWj08KIqAvyScsOFw?=
 =?us-ascii?Q?+WTwP40ZENUj/HxPh2D+Y9DLmhAtJ3dONt2FQehOqdY2NHoCWccLStPfCrUr?=
 =?us-ascii?Q?gt2D4Uw+zMc53w/FkEgR0YdY3Y5DWV5/1iaWO5lX7/I2w8rgWGR8nhBOHRd2?=
 =?us-ascii?Q?f9kAQPm347pebGZxewDCIZX+OZDmw75rKlj64CWv90za5aTWoprCdohxy/rc?=
 =?us-ascii?Q?ldLyxB8jsktVt6RlPWpdmIfh9GgiUzQ05+3XaXF3oR1SBJ0jXLi7gluzsUfo?=
 =?us-ascii?Q?Ip9EZKgCNTtvwcEijCqGI3NcQAyPJ28iCDAnAhw5xEQrYspTDzOxkhzm+++x?=
 =?us-ascii?Q?hSt128Q9YD+b4+8yxTraEfJsuaBFlDPY86Oglof4Lt/flOVkvN++awhm+3+L?=
 =?us-ascii?Q?0xGsY4qX8neK+eX5q84et1K5clGyz4XTmQW2FDPbqwwkXd0V1UB14n4/dF4p?=
 =?us-ascii?Q?bAX0ErTOptSrbD6gU7gsYQfa55ctsp2yMTjdUlKccBCfMyD8X/eYLRZQfwOV?=
 =?us-ascii?Q?Q5ZpajjPRnRuIXoujVsQ1JkQdgERZtf1Bx/XoJigRoq1G4ZtrC2n9K8OU/Rv?=
 =?us-ascii?Q?PmxLT0xkQP5uw5hLBbENqA83Cd9HdrtMW3GkHnSc2AQOOcbf2+pd2HSYV71f?=
 =?us-ascii?Q?PZXolfKFUs8NRbxOOo/YDaikifqKIH6ZL7GXzCUPrDjFIzUgXHGqBbGAubCf?=
 =?us-ascii?Q?AIqNQgJUDZDfyaEGUHsTJRwzIAT1shgSjdiMd7TYIi9IO2Gu4d3zknhCqGdv?=
 =?us-ascii?Q?9pRFe0ZvCwCiTkSxM5ZZCDeBYHaUkrOQvKaRJg21pthNS3NdelSBVJbJgPbp?=
 =?us-ascii?Q?4Halqj66J1I7VwNKhwue9CPutBGXLdu0VOsXi/Hm6Rp/WYvvqjWI5oF9DvgD?=
 =?us-ascii?Q?8oGAL5dWaW0/oVR4zJl7A440gXnYuLj7tzuo+EQjRwjt4dO1ore5SKqQ0fSc?=
 =?us-ascii?Q?5r9Be0in85h0LB7STLBJGWDgNcIbu6CIAqwARUYkNkkiijU7q6rhf4hjyEAA?=
 =?us-ascii?Q?bmnsUFD+OxyPhDypdnhDEvDJ5snDwY7ekLLyBEue6nLYU9TkE29xKwMA7w0j?=
 =?us-ascii?Q?p4MVFcY4M+K4ELnpp5srgmKdKdOqGxIld+FjSg00xyGnHac959m8eAgaBZVC?=
 =?us-ascii?Q?yJaKDHU87knEVc2LKsj3hkGM88p0PgHF0h9sNPOLxc4YtB4SDvuamfeI8ekc?=
 =?us-ascii?Q?xWGYiwCV9R0GJfVxqws=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bb70d7-d444-4beb-c111-08d9db9a4b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 22:23:17.8692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ehT02yvzKmQMYpt6YE0AazaPIU3d88Km5yB2xc2D527GS0ytUpXVYHYzmm7TWxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1448
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Apologize for sending out the patch with the wrong email sensitivity policy=
 a few seconds ago. I've updated sensitivity policy to "Public".

Thanks,
Zhan

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Z=
han
> Sent: 2022/January/19, Wednesday 5:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Charlene <Charlene.Liu@amd.com>; Kotarac, Pavle
> <Pavle.Kotarac@amd.com>; Pierre-Loup Griffais <pgriffais@valvesoftware.co=
m>;
> Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Cornij, Nikola
> <Nikola.Cornij@amd.com>
> Subject: [PATCH] drm/amd/display: Correct MPC split policy for DCN301
>
> [Why]
> DCN301 has seamless boot enabled. With MPC split enabled at the same time=
,
> system will hang.
>
> [How]
> Revert MPC split policy back to "MPC_SPLIT_AVOID". Since we have ODM comb=
ine
> enabled on DCN301, pipe split is not necessary here.
>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index c1c6e602b06c..b4001233867c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -686,7 +686,7 @@ static const struct dc_debug_options debug_defaults_d=
rv
> =3D {
>         .disable_clock_gate =3D true,
>         .disable_pplib_clock_request =3D true,
>         .disable_pplib_wm_range =3D true,
> -       .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
> +       .pipe_split_policy =3D MPC_SPLIT_AVOID,
>         .force_single_disp_pipe_split =3D false,
>         .disable_dcc =3D DCC_ENABLE,
>         .vsr_support =3D true,
> --
> 2.25.1
