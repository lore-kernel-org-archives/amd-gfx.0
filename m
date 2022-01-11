Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE674C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 02:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6268910E59F;
	Tue, 11 Jan 2022 02:51:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58D410E59F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 02:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGiD1Ou6ltou5ORou1YUqFBUgFdb1hNAUI6VWAhQ7wc2TTz4mmksTLapHHdRHylBo283fARjYObz6YhIJBoUnXtiiGWxgqZ6ktMtM+8YBngjbUSTzf49+SaRNW0I1i06oT2iC6iwvyVwW206s6GJ2BuDwaPdGKNGVueHLCPLG6ZMoidWgICU19I+9PgRdgap+dC5+2MDdRla4M/o0layqe2uqhX4ZheOLezo7DAmeyi15mJfR+g10c9LWeiBi6RXACed6MEk0q3gl488cgfKnpKHU24K7Rb5/TiLFi5z6A3eOfcTVYWJ23eWd4La+xS0TJ2W2BpTFHr52VhQuAnRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zPC1m2YawBz4l+yTSdNBSrjny+XGQVOcfn4UL106fg=;
 b=SRUTKu2sX9YG/KFHY4r9s4RdG+yC2CuiBO878VRKE8ak0uSPRwbKgxI++1H6fTIr5HTtEPomUN4mojvLfoTMC4lUed9OCQaeY41jUUhK1SnD2g15W0DOValkQmscUM4z5CH93CwhABf8T7oh5vW60hXsYEiG6VMMvQR5eYkE5WdpQPi4dwGMnmdI/vSmTddJNNQQ4DjXBuZsrQyt9S5AwWeXBzmMIW6J2E4tV1c9Bt8PkjZk/UT8kMBzg5Jsh54aOA/jm/Sn8H8FZv8GYBWU8pZhIO7VD7Zq+ujCZ3Cnc1poZQPDoyjLDW45tb4xTnAKnr7A0/oM+vAQbZvumm13ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zPC1m2YawBz4l+yTSdNBSrjny+XGQVOcfn4UL106fg=;
 b=OI/3sMM4lvp82+0Fq/9S0/BfiGgsQe8t6hLv76MzjbHYmhKfuw6v8HD/7fxHQjKMtwy+xre8yQLG1Vf+c/om8j6udnu8R2qYXz3GDwecikj0SHUDC66Rk/4gubWfUGghNqC/uE8OKluJpwm8NgcLDCvKqKilsJKRR42ORsY6dPk=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 02:51:51 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4867.012; Tue, 11 Jan
 2022 02:51:51 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: fix warning
Thread-Topic: [PATCH 1/3] drm/amdgpu: fix warning
Thread-Index: AQHYBl9vO+HFdyTCj0q1ATWKa0fr/6xdHxyA
Date: Tue, 11 Jan 2022 02:51:50 +0000
Message-ID: <DM5PR12MB177058F5BDA5AF0793AE5928B0519@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220110201929.1949571-1-alexander.deucher@amd.com>
In-Reply-To: <20220110201929.1949571-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-11T02:51:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7975ffb0-88f8-4ab0-b88e-53d263e1cb95;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-11T02:51:47Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 45b08a3b-3b08-46af-9997-f4e20d8f0d03
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcd07bc7-4833-4bf3-180a-08d9d4ad5173
x-ms-traffictypediagnostic: DM6PR12MB3868:EE_
x-microsoft-antispam-prvs: <DM6PR12MB386804A03C814B97FAEB70B9B0519@DM6PR12MB3868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: paQmydB1MrNQK+//Qr/WhF7RLSz5AJF3AemtIVkOSm0UP/QkoqahjdRe4IpstyzEM60oRCwOFerC6DtoaUpeKmOOmXcTlcBN6A9WYwROSLtm3EEbwYr8riRdURu/PmNGWzOWadAKEkYvQJBVJwHijLVzY/xqMNwT8lkSirRpIiib1sX4YUw0nJDAIUbBJz2+cb48AqWtyx0to4NiDnyagFuSKd/zg/HGGCN0bsNagztoTIvDGgfSB8QPCpb+NyLud2u2/cesloXV8RJewPwzn3FuBOB2u3MFsSO0hplux2qpHyHm0uLYAVmZkwVHeVUTA9WGObCMtAHEgf2KBz1OZrD7LokcIOzMvIxf+/BDMPS05EZokH4nl7H3+HsEt+OlhnZ6c5PjcSUkJZy41LK/XF/KkK1jw9aueLzD5AWrIYM+zYGZ5Llzxsp/ryQu3SFzZ6zSsQeJAU4leAhxtNbDWsU5p8QbOoZr9C2/jwJrtPraK9sJhfskwk4EahxjpmChhhARbd4p6Rw0TjcXgC31BratrC+yQkvUtClJKAlmjtq3Q56NPr+ZBUAxuD96vlJdjlY/GGjFF1CUCCWmLdaVRAGqGoPbTfMNYur8TzDH60zokDo8PRVPaSUhwEArgSEUvrtuCkZEVjJztJ9d0q13Gi3ihpEbLYHloBkahwhX0rpnu7m7pnC4yMjuTMLMRqzCzbb3xb7LrfD4+CeNF6dtug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(110136005)(86362001)(54906003)(508600001)(5660300002)(33656002)(9686003)(66476007)(66556008)(66446008)(38070700005)(64756008)(2906002)(4326008)(76116006)(55016003)(6506007)(53546011)(316002)(66946007)(38100700002)(26005)(7696005)(122000001)(186003)(8936002)(52536014)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UFJeiCn8qAOJGpTs1xeD2bM/yK6nsKzX7vm70lMOGUgDc/E8aJ4KFdQvgukN?=
 =?us-ascii?Q?DAsKudRFmmkWvo/rpX4cenLWD/tjNGSbnrWjBUhlWOH0WGQocPp0hLRppT7b?=
 =?us-ascii?Q?JaeEUC8vfPeegd4T2UdN2mmo/d6NUDsdNfNlQHrrFxb8pdM5zaZi0RfjtYUN?=
 =?us-ascii?Q?q68lJ8va9aH1ixrox9OCbyDbeZV1GePnrDHkmH2nLMGOgzrzxMXB2quDB/vR?=
 =?us-ascii?Q?U8yiB1to+Di+Vn4fKdmL8aJo4R4l3x7FN0vvUjeDplswLxkX+5VGMmsGysID?=
 =?us-ascii?Q?Itb20naVgLrHRwSz54iY1BbBE6TuaqaEQFGm2HA/udxUzIRnmMZa0oMseT2K?=
 =?us-ascii?Q?gaMlPvyhXsZTtBr8XYmuxTpmyJWZM+f+ugZYm67r48F0Un3qcN3/CRcPlcUM?=
 =?us-ascii?Q?inSx1k3Nipw0QXEJRjhWdMvbki4ImfH8pO/rnd7mB809CyXP+5LfhLbfvLga?=
 =?us-ascii?Q?y9UFRK6AO2PZEUOxaxRtlmgEeOdljRB6PeDEs/7KPapI3Mf7+M9+UUMbvtkl?=
 =?us-ascii?Q?iITU2mEyCKCPXVEaPU99pfiUZN6UR0lAxjUuS63J0mmoqVTcxu3/Sb7bCQn7?=
 =?us-ascii?Q?yfAOxQ9Awgwte82D5dv191b2515C0lZyWrEJu82cuwoDBEjo9+FF8mw4EEPY?=
 =?us-ascii?Q?sbNEE6b+R9KPFC/8XSVHCFZ47jqj4q+gWl7pSucGkMZvYd/m84BdMH1+f1jG?=
 =?us-ascii?Q?qZ1WMHyBGkBwoUBfpLrOSQJm+qKrjAclWyw+lak29ZfK9KWO4XMgPBWKoOPs?=
 =?us-ascii?Q?rSKFUUvCW1j7+JmtnVDnRKUgowibZH5ceMuMl64iVlj2eIZ+bb8pZNzNSQFD?=
 =?us-ascii?Q?5geyPRAlkxqB/LNjXWFlsq13BKGnUch/qDgtfjvday4RUllfup+YO3QA4PlT?=
 =?us-ascii?Q?Nu98Ou3oSwbZFJc2aEL70VPTCDR6RI9mmOg85baIR//QpSGsHvA2u/8m38Z6?=
 =?us-ascii?Q?6kcalstK4//xWyzsD8+DeI7uWAbsnCsvx9fXvKGaxFIgrehjuaFFaqOKXzz2?=
 =?us-ascii?Q?50IzuDofc3bFPt6T91GBoz8FQ4SjMJFXMpkNsIRYKZ/ddohoU0Oi0RiaGayx?=
 =?us-ascii?Q?yzFeQZNtp/2zORz3vWyFpa1uqXj05ASQ2yLrb4GorW5A+Wg5ef3dI/mMAy44?=
 =?us-ascii?Q?GSMvE9vV5R1F7MlBGIfCzoKlm4c+TmtAi7OpK2Xx6liJXMqtE8Rz6RSwr0m5?=
 =?us-ascii?Q?Z3P9qApliMrTuEq4avvTxciun7lt1bfg7jDSitWeWUQOcteEFEYvIavS519Z?=
 =?us-ascii?Q?7ZzY7J2DCP8QLd+QEzxMVvMi2F2MlcIZae+/G5AI8nZT3pulj/4W8BDcYydQ?=
 =?us-ascii?Q?2H+sJW63QlZ8Ie13GfSX8OvpF6RraNAfZHXzgpEdO/UisaQkGOpw5a8SFZJi?=
 =?us-ascii?Q?tRowssvV0axymjAdR71jnNunggocFfX/Nh8IrjSNj696zn2V3BkWkVhdj5Ah?=
 =?us-ascii?Q?fkuqflCJs0mi2iEmeG+0kH/Jq14eB1RwlR1yv6B8pHzRFqubB8BwxC6OaUqm?=
 =?us-ascii?Q?/h0JaEQ/S3+0/ziaY/tNYgjZFzkYIThHCycrZSaz1Duhey0I/hqAJ/OLNMkp?=
 =?us-ascii?Q?MIZ+muvyzjZoPoHjRbI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd07bc7-4833-4bf3-180a-08d9d4ad5173
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 02:51:50.5564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tWIU+JbuEhQGZMc2Qup4Qrl3yz1f8MVDrz2f6JKTFuvFAtvCclK7gRfPwqdeUaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks! The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, January 11, 2022 4:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: fix warning
>=20
> warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after=
-
> statement]
>=20
> Fixes: 8c50db2f64ee ("drm/amdgpu: Adjust error inject function code style=
 in
> amdgpu_ras.c")
> Cc: yipechai <YiPeng.Chai@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index aa8d614009d4..478457637d29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -949,7 +949,7 @@ static void amdgpu_xgmi_query_ras_error_count(struct
> amdgpu_device *adev,
>  /* Trigger XGMI/WAFL error */
>  static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,  voi=
d
> *inject_if)  {
> -	int ret =3D 0;;
> +	int ret =3D 0;
>  	struct ta_ras_trigger_error_input *block_info =3D  (struct
> ta_ras_trigger_error_input *)inject_if;
>=20
>  	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> --
> 2.33.1
