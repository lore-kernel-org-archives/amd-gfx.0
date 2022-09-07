Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C76C38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 21:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0CA10E89A;
	Wed,  7 Sep 2022 21:08:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65A810E896
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 21:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrrqGqsSw0hgJDIvRqLXsWuQPcDjZr6VKnHrDgM0o+hq2DwtrvuGcnV+LauKHnBJ/NYYfwSLEkLGK9k3Z/gs2JzJvE0iy35Lyjgl24bmOE0bIQ/gV40kM1mzuzvQdFyfccbHbQxiNIO3gShVOb4YOm4c1a3b4hrpTalNgbofWmeZfPifYJkz+MwJKDuR9UgXX1Fm67q2wet1h5lYCrJXeDHlJzxKbbg/yr39nqKXXgcVwkFrk50439QuUgIhiY5liVjXVKRMpkv6s+zBWZlbsTqm/3dBrjY8IF7pddeSHtEkmKlr30zIJgqHWbOe65THTLLf25fQ57xK4EEx3hwSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tft/vWG4gtJKTxhC5kinHf2Uxz5nqc7v3Z3EDWu3yD0=;
 b=Yrs2DwSHkKBkbOgMamrydxJQFa4VwL7yR4s1GPHBo1rsyf7wldYdmSM3fuci0FV70TsCS62+p8GCb8DFzd849EDWPrOXDWI5f2EopoPA7Mk8XOBlhQK6MsQDz3W7/xjH2tITER8o5AN15f4y2EQDHTyaLHvVqzlq53IP9axwUFC6DY/+7JOc4EXaNSgAuCj9MQX/mNO/si714WtzA4Hlq2lfoXVx8KKArzOdAeMM16ilBxzr9vlzHosobuLDZU7v99rryk35RP/EhxSHRIZbyPy8WE1IKZc8L8t8oqU/49d9HiW3B9Jv4sIfoyZ1wxGapdJh2fMtqAIeRJNgmXAW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tft/vWG4gtJKTxhC5kinHf2Uxz5nqc7v3Z3EDWu3yD0=;
 b=YHH73xJA06drjl2cvTnqollQ6kZzMZb8ktkJNoEqM6KvPUztN5sKVg4AIqrGEN7LVNmva8XTdoX+hg6x9kU9XFzSwZx+wlP6znQRJ9IxlgAh3lEC5Q9OpDao84QiLec1vWme9a4nHs4DgKnabx4t/eoOQ7oqCI62jE5p6GkHzXE=
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 (2603:10b6:405:57::22) by MN0PR12MB6294.namprd12.prod.outlook.com
 (2603:10b6:208:3c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 21:08:17 +0000
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::2ced:4abb:b1bc:248]) by BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::2ced:4abb:b1bc:248%3]) with mapi id 15.20.5588.016; Wed, 7 Sep 2022
 21:08:15 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 07/21] drm/amd/display: Enable dlg and vba compilation for
 dcn314
Thread-Topic: [PATCH 07/21] drm/amd/display: Enable dlg and vba compilation
 for dcn314
Thread-Index: AQHYwuVhy+KMzd6DdE6crJckCUnWwq3Uda8Q
Date: Wed, 7 Sep 2022 21:08:15 +0000
Message-ID: <BN6PR1201MB0084F30FD6A56905BA0FB21C89419@BN6PR1201MB0084.namprd12.prod.outlook.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
 <20220907181200.54726-7-pavle.kotarac@amd.com>
In-Reply-To: <20220907181200.54726-7-pavle.kotarac@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e6cc4cb9-ca26-407a-9a8c-2a1eb6a0b39c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-07T21:06:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5bf569f-33c8-4ba5-6cc7-08da9115149f
x-ms-traffictypediagnostic: MN0PR12MB6294:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wdqWUzGhiMRVI/WXR03g9oahhvvswRdmMP91kYUzObESja1BXZZna66yr4EUg9IhPxK4JxWVC9ylV3hkz0AJZjqRXcsoGS0v0t31A2uMOsUu63Ynat192rJCaQpdXr6znNbe9VLGRoxVXaU86u9KLivVnYg8VzmrpjW7wpI0LSjo3KXqm7T55gDFw/HuLcyWJU0DIw69l5tHDcyiJUoBRO70PR+peD6h25GfID/K+rz+azNOhWTeePAjw0Bk7UiSgLpOH40z83OVgs14dVMauIQjh9xQ2TogmqfBwwN4ygZJRtINAlvQiR+hqzkJtTXtljq9qt1KfgtBKWtkZNeJVL3/KnUjxbWflqguexx28RNS0mgsomLbqJ4ol7v6nMm6BEJuTfObPjABzxA/AL1SGjB2P/Xg/g6d0D9r6WR6lRNB7cAaBe4IvNrlUpiLoHj5Jp7G8ieHTJfVaNt5s6POshvFHkPKhLLzpZUdzMeWSGHQGxSQ5y4fG4zLgn7cucyYf1L59pKe2tclhtlG+kkdfksrjeZSJDEqexGrFTBB05DqQttQauI7xUuyZ4TQxFGbspt5cptBUtCxwgDRUFRgE25AqmcwjyKiV2uUbkoe60wTSsQC8QWeXuk8CFs5JJ2u0UKVpfgzWAcyEj/jmfMMh2m5itjj08BU8RSGj4LBNDsSAwi+a3W3KHmfBrfLZ/G0qbVtlSXr3hazSqQkYpB50efHxjWZ6y/1agyx3GsjC5u64LhvHyL51OqK+EeuYaJFM9zg42mS0AKVb0Zj6xqL0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(8676002)(66476007)(76116006)(66446008)(33656002)(66946007)(66556008)(38070700005)(4326008)(478600001)(7696005)(83380400001)(6506007)(2906002)(9686003)(53546011)(8936002)(5660300002)(52536014)(26005)(186003)(86362001)(64756008)(41300700001)(55016003)(38100700002)(122000001)(316002)(71200400001)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?up/m3/TY9lly97AlvJihPYC+3Rwfh2lb/d2HGjflFZqaOrj5kKJiHMM8xjxR?=
 =?us-ascii?Q?nFl7Ro/iADJ6rnrNN9OfYJ0Z8btfoYG2gPAfmm7InjCm4TGectRukto5tlUd?=
 =?us-ascii?Q?Jvwc+OIg3esdlT9IgtBvqou8h1+KlD3u050LAeeMoB2IKwRDR8ZWpazj1cja?=
 =?us-ascii?Q?k2+BCn4V2hG7oQtUh9h6rrmDI4bVJzC8k2YPm0e2XJnPYQBBTNdshoOOMpPX?=
 =?us-ascii?Q?4XjN3pdzXZ4uYi3dkhLjEl+98HI9i9eOw63KPNNc/byakUFi9ONW6FvcbkyD?=
 =?us-ascii?Q?I692+0tdgFOtSzHF1/0tikQcDSfxVC2+vjFUdTO8HGeWLwGUTTCzZSvRgNhm?=
 =?us-ascii?Q?XjYWtsMhN2f4HBjoksyh+P7X2FZC9BlIPYn5CfZEme+Ln8/J9NJnLW6dWVxr?=
 =?us-ascii?Q?3iZuU/FR32T3+8Zy0nZRdUQxgLS4qyy6hnWYYo32gl2zozWLK3q6faEE0hpq?=
 =?us-ascii?Q?4SgHxLhgsCzoKXo9yUUmSTLqX1zFOwmB6ATnn3lAbSQLJLK+0dWgp0IQQCH1?=
 =?us-ascii?Q?U8Re+QITiatTRWJydYH1bpPtubGRWsakURXPdpzp6zEN8cOkKdZ22K7BFSHM?=
 =?us-ascii?Q?SIySlLb3kON9pLzUP6Jy3FY7lKlZblkTOzqN+KafMPfAkDAAivEIdMfWeBVd?=
 =?us-ascii?Q?lX/l8m0C6yb3lItHSUFicfnpouXjSqFzbL84yT7W1JEtiw9ge1sK3JFjfN5z?=
 =?us-ascii?Q?j4XjaDU0QFctS2GyHXAkSTcN0kYNKp37ss4pLx6Von3JfqGbK27elCQ8YFQF?=
 =?us-ascii?Q?rQL0SXFiFaaUZOsCLc+v0T4WKpGt7EnLB1ArhXRagDBxV2zut8/NTLD/veLg?=
 =?us-ascii?Q?fE+19Vm5ei11ksTfv8naUb5KIp40EFRqDpRPi9KiYAG7z3G1Ik1acbRbQJMx?=
 =?us-ascii?Q?8ufN/06SmplYbru4oCmTQ4Zc9daMigKws89mYPNXdX8mltJJ+pFJUlLudbsu?=
 =?us-ascii?Q?GoEeff8SeVObx/2l5MnVPy4GDHbelgpMpm3rttVH9m+qNofDMQiQqggkkGff?=
 =?us-ascii?Q?YKAtpqpe3O68S2cbzZXtMP/uXX9Cy2IhKliV6NYh4O1wTfDmgDSzmEzwVrNW?=
 =?us-ascii?Q?8DfG21IByMmzrzgnmu9aW4RtNSs+LHM8JMoNhKhvtbmeTFwJKLn5v0n5nm99?=
 =?us-ascii?Q?tIi6vInMPkjg6mhvDj/K6ljo/Tx7waXf658TWkmi/iIKTb7ysTLc/XvA3QAq?=
 =?us-ascii?Q?1iSrzo+KMpkFLBJ5s4GlX3MZIrkB7uxRQpxlhAfJHNjEhamyJmlg0eZJSWLW?=
 =?us-ascii?Q?KVgayIpQLciqBxanzvxPjWFt7A3cIsFGrGd83hiS2x9ycjK50XWM9QWKftRH?=
 =?us-ascii?Q?/pVr65oa+KasuR2anCi/prbto7mdqSKnRxcTD/gt241N6pESDTtrde6NIt5H?=
 =?us-ascii?Q?UfTVWT7orxpDVbR6BhlK2gIxO9gdQOjBRCdYXnulQgVYeYQi8VaX2Gak5lGq?=
 =?us-ascii?Q?RG+8RtiM4IuUFc021GND1S15aIJdUoq66OTvgzLfadoiInq9uLYwQ2n6zlNQ?=
 =?us-ascii?Q?7XtGCJyTqpMS8u0S89+m+T1oNr9Yn/WW7ktjE7ZSk3XP2d+zKG2eaKTnSTl7?=
 =?us-ascii?Q?QieS+UZej8Px+4nKFWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bf569f-33c8-4ba5-6cc7-08da9115149f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 21:08:15.2210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksqPTdtXalA3/DBatQO60fXUHVounmaDszSyLjtSqxWsh/c/u2A3Aqfw7AuyCSZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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
Cc: "Wang, Chao-kai
 \(Stylon\)" <Stylon.Wang@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Roman Li <Roman.Li@amd.com>

> -----Original Message-----
> From: Kotarac, Pavle <Pavle.Kotarac@amd.com>
> Sent: Wednesday, September 7, 2022 2:12 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet
> <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Zhuo, Qingqing (Lillian)
> <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne
> <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon)
> <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>;
> Kotarac, Pavle <Pavle.Kotarac@amd.com>; Gutierrez, Agustin
> <Agustin.Gutierrez@amd.com>
> Subject: [PATCH 07/21] drm/amd/display: Enable dlg and vba compilation fo=
r
> dcn314
>
> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> We were not using the VBA and DLG files for DCN314, but the next sequence
> of changes for DCN314 will require those files. This commit adds the
> necessary files to the Makefile.
>
> Cc: Roman Li <roman.li@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 86a3b5bfd699..cb81ed2fbd53 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -70,6 +70,8 @@
> CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o :=3D
> $(dml_ccflags) $(fram
> CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o :=3D
> $(dml_ccflags)
> CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o :=3D
> $(dml_ccflags) $(frame_warn_flag)
> CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D
> $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o :=3D
> +$(dml_ccflags) $(frame_warn_flag)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o :=3D
> +$(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o :=3D $(dml_ccflags)
> CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o :=3D $(dml_ccflags)
> CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o :=3D $(dml_ccflags) @@
> -123,6 +125,7 @@ DML +=3D dcn20/display_rq_dlg_calc_20v2.o
> dcn20/display_mode_vba_20v2.o  DML +=3D dcn21/display_rq_dlg_calc_21.o
> dcn21/display_mode_vba_21.o  DML +=3D dcn30/dcn30_fpu.o
> dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o  DML +=3D
> dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
> +DML +=3D dcn314/display_mode_vba_314.o
> dcn314/display_rq_dlg_calc_314.o
>  DML +=3D dcn32/display_mode_vba_32.o dcn32/display_rq_dlg_calc_32.o
> dcn32/display_mode_vba_util_32.o  DML +=3D dcn31/dcn31_fpu.o  DML +=3D
> dcn32/dcn32_fpu.o
> --
> 2.34.1

