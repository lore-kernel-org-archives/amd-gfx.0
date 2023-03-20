Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5B5C7618D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 08:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02AA710E280;
	Mon, 20 Mar 2023 08:26:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EB610E280
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 08:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqIp6d9GSZnH5QL/zKSiuA8I1APUoYQtWxqQ8p2PcWycdie0J7DGGDlcJJvoZltYZC3Ix7VPLzxmnJH5PfdLEvuyJUI5nQny/zZF/NihI3rVvC/G+VkU/UiRgTagP2tn+xzUgsD7/oUTzw1+Pp6KJN1Pv1fKQ6tGp17pE7EFtwufgmJJn7RPH+AOg6E7ItIjf0vZqeasqI516Ibfd/ebRTwtqWf1Cs7jRe2CRDtLkeL/UrsICGN1EogNeAjGzmyWx3/6sFGaDbT3eFrN7wbUZ5LPvwQsDKVai+m9NJYEduKdIV7sZXuTGIh26uTMFUpb2yUQtQNUv7a4NRXdS9meJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA36JfAdiYaDvnUFKODIfVmawbye6NaPJeYpNMJmrKk=;
 b=HUzgHlIXW7grs+cWwRK2E5le3CxAbwUC4H1KD22ylJK6iBfz/hCE7anrLJusT67mR7vgFt9DyVA42VgajgiWNV+38Va64KqiGzag9WgThNeG3Bv8hRG4G/ux+tSYg+eKBEONHQapfz7Hu8OfJ5jIzRNe6tt3V8x1YnyKxurRMBZvqXjiTD7VwQZtolFdqJA0GxR1WbyDc+XYfnv4qZLoeNeCslc/I9otzHqJc8ai8S/bot6BFH+cQhBQI/JeCVRh3JaMA0PrFMQCSsKZtOEoSJLc6nHCkdjaxwXRLXZt4aw2bDGHfIHob7nPGGP7I68Fq/B9sgPBCcHdnYZNWNIWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA36JfAdiYaDvnUFKODIfVmawbye6NaPJeYpNMJmrKk=;
 b=Q9lb2eBpFgVcgTpRl394WXsoe89gP/V/IlJWRZnzc8O7k8jhGQsK17CdlYH91emMx3Gp/RVgVn2KrWQfNjIt/L2UYLI2UhljB0Dq4CEi10kUZaf3o6EBmuJdDxqHGFMd6GcE/3XXQm7skE4My7CA94sEPq78b1JTjZGgp9PR1Eo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 08:26:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 08:26:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 19/19] drm/amdgpu/smu11: enable TEMP_DEPENDENT_VMIN for
 navi1x
Thread-Topic: [PATCH 19/19] drm/amdgpu/smu11: enable TEMP_DEPENDENT_VMIN for
 navi1x
Thread-Index: AQHZWW9mvp+E97eAG0G6ANA3HfTFZq8DV6Qw
Date: Mon, 20 Mar 2023 08:26:20 +0000
Message-ID: <DM6PR12MB2619EFBDFC4F2F9A7DCD2FD2E4809@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
 <20230318075615.2630-20-qingqing.zhuo@amd.com>
In-Reply-To: <20230318075615.2630-20-qingqing.zhuo@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-20T08:26:17Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=89719c98-2581-47e5-b606-cbc0d259174d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH2PR12MB4311:EE_
x-ms-office365-filtering-correlation-id: 9e51fc76-2c32-48c9-8921-08db291cc861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GLmTC41qoqcw1Xhnez4SJaX6pvWyRlrSHlvDywr3Lo+td9DToIi4mI1EkiH+AqORWqMb8FrmFkELhQUtvqoArSlUIlp25EuWLfrZhjhrUVbc20V/La7eMUct4ubcpXcUUoS9mKgnDtGHM5QrdtavHqShQfdBd3G5Lv9p0c46/tQbfuTcYgtsmU7RI/6WsS76AS9mJ++YeQzrUxCbE4tYjb96lLyYoWxeX1oIGNYcRJy22agRKSQvw3Hw0DqWhizmp8eiqdkGJKuOT9gqhO/7kF/1e5biXCtV+4PTQb60cnnCj7SxkdQm52YmM7DrLN7XP3WMTg8T0U7qrnCb+FrdzvQYgC0nDAL4RvQ2JOABgILbTk+4pwOlQCmK+OZcAsPdvxKvcClsEaOcJjoNemmm+m5aiPZnh15kq4wln5Q1X2ZUqiFGWAXMxifLTzVsvzlNEbXwaayk3xdaO2W8dR4uUvcfdVMUJP+dbqkQSogXvv9N4J1HnO10HnOuZnlIQKZ/+ili8hyEfruCAlfp2D0m+TV3aRHjZEXO1jRgeEBgGLAEqOBVt9yxlopJUfopI3IjeYVLgJ4JNUx8mbPYMIrvhwtueBqBZUN9f9clPYPHBnwL7ne3KEkjrEbBS82eQlbJUxO6gPPsPJkoL1kir74T8eSHcKdImPbqZKg92c919fMOGsRVdXNljEAwGmQV6I34
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199018)(38100700002)(8676002)(86362001)(33656002)(122000001)(38070700005)(4326008)(5660300002)(52536014)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(8936002)(76116006)(41300700001)(186003)(83380400001)(54906003)(55016003)(478600001)(316002)(110136005)(71200400001)(53546011)(26005)(9686003)(6506007)(966005)(7696005)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QosunBFd//0SmB8PKesuGw+FXGxZwMAfAER8GURL5VPQ538ZpvUnSiVpkVoq?=
 =?us-ascii?Q?IbD9EhhRwDsOzv3IiCM1OCGM6Ic0bkqm5XlJVGlt09/Uduztyoz8VCwTNxRt?=
 =?us-ascii?Q?KE2jODkuBcowW/fnLJyq+dYYAFx1PttufalNyHsdffEYNQv6kpsWFSn7R8il?=
 =?us-ascii?Q?UCTkY/mS4lgcPV1/gMpud+ygoGNbjYYBFJ1DYvwzXYioWWplDi3XjRCrfqXG?=
 =?us-ascii?Q?cwOTGqaOfbUpsq9LYNBX1FuagwBsHus7GTumnQnN87CBIJ25kJpoMcp54DNh?=
 =?us-ascii?Q?KH3Vi8ED9UVnrJZkvWgG9I9D7J5C/OjWTHVcTDNCAUnIJUcOl1PJ8wEEzPhh?=
 =?us-ascii?Q?83pLndehiJfJUnavJ4KoR7kZ69e60P9VkJmUhAk9E3Q5TYnGBCCs0Jlqgttd?=
 =?us-ascii?Q?9sduhXx4+NRWrkykd0h7RHsTMbz8y5YZMgoekIYLeeqTT6c5SBVAK/POI86H?=
 =?us-ascii?Q?NWQ2e1A7ELa5kByLrMoQHE3Nb9HE42fOEoo3lsT3BvoPyioa3i4tOUBb9NUJ?=
 =?us-ascii?Q?AtboA0GkwFEbxke+tlS6kRcYKPZ4gNcLFgupW7/36e5PyKOzGS0xTvKKF+FT?=
 =?us-ascii?Q?59H7+ofNxHSwDve+ZHUoVWntoZyES9a+gsS0qLpiF4xdbXUjcR/YVykdXQjJ?=
 =?us-ascii?Q?88mduUsej96+/qez5p9YS97ST+dCgSp7PszoZ1lyxhfNLX/8dOnV4JbkTkf7?=
 =?us-ascii?Q?/hOz0Bl7ltQ6/jTq8KpBKGA4AN4aOUIrjedYrlBMb9PT0boQCU78qGKp+22j?=
 =?us-ascii?Q?9s57cZ/POyuAyEGLy1Hq4QBNs57pXByvLGPUFHfpNgNhGfSmcLjjdXqxJylG?=
 =?us-ascii?Q?JVN47U5shU1oRFgMKptLpUuc37fGPCPoyJd3VD7SesvY73+jrmLuWfdqFB9Q?=
 =?us-ascii?Q?JpuSELQTPlD2UCsKEMJMWVnvbFgmj5toNAC1uXWoxhrgxzqmzJnOA6H9vBQV?=
 =?us-ascii?Q?b5SveTzKwOW3oIKgtuthk3us2+he0S2Cusx1+4JN0t/AoWxAB/XEGZ1xyUSJ?=
 =?us-ascii?Q?NLbbcRDYkxtFR1YC4VxEdbC7yhUOhQKRdmUIYgPkcD/e6cTmBUsB+W+Cy4t5?=
 =?us-ascii?Q?HexYbI0/lrY8JCS49NbffSbRkwzO0mNDpo9C1dVh9jGsTG5itjezdZS7C91w?=
 =?us-ascii?Q?8zl9NenYhQsxLK/Nd9fpPBOEtDQyVsLMA+wJxSLTxl8vtlk7tTQ4HroFBGjp?=
 =?us-ascii?Q?Kjjs6gLO0ukyFYlCLDnhmB7+ILShz3V5LWdLdI/00S9Tpa2udUfHf2Tvoyf/?=
 =?us-ascii?Q?wlU2AwBMQbb/ISRw6R+v/BQCTYP30FiBQSO1H6gkdd6mPLFxUS0g39DDVEeb?=
 =?us-ascii?Q?URj3ax/Z1BzJEVNhvyirpdKOQqTbOu4idVbX/pDCQQVEwr6vfRgm1BQAOZks?=
 =?us-ascii?Q?X0wgGjfIuc5A/D1F8AByLsinyAE6waDJFmRkyFqoFtRXUKHnjlg+y2wIOzwT?=
 =?us-ascii?Q?pB9UDQS/yHj5Ic5yauhTxyjl7UocbWKuv8/yvxwTESPGX/gV7TXJ2+usfumj?=
 =?us-ascii?Q?ERlNzkepIZhvN1tSum2YzA/iuhYKMy0GulcTEJ41HrP1f1CoXTLKUdlVCP00?=
 =?us-ascii?Q?R28yxGcVRxliYcIt4zQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e51fc76-2c32-48c9-8921-08db291cc861
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 08:26:20.0246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xCcIUhce9vhJ1umVHcHvRGg9xrbTrZm4JnsHh958j+4QqZKMsBCrycl6fG2YcHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Better to update the subject with prefix as "drm/amd/pm" to align with othe=
r power changes.
Either way the patch is
Reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Qingqing Zhuo
> Sent: Saturday, March 18, 2023 3:56 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>;
> Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu,
> Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet
> <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin
> <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
> Subject: [PATCH 19/19] drm/amdgpu/smu11: enable
> TEMP_DEPENDENT_VMIN for navi1x
>=20
> From: Alex Deucher <alexander.deucher@amd.com>
>=20
> May help stability with some navi1x boards.
>=20
> Hopefully this helps with stability with multiple monitors and would allo=
w us
> to re-enable MPC_SPLIT_DYNAMIC in the DC code for better power savings.
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2196
>=20
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 95da6dd1cc65..c4000518dc56 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -304,7 +304,8 @@ navi10_get_allowed_feature_mask(struct
> smu_context *smu,
>  				| FEATURE_MASK(FEATURE_GFX_SS_BIT)
>  				| FEATURE_MASK(FEATURE_APCC_DFLL_BIT)
>  				| FEATURE_MASK(FEATURE_FW_CTF_BIT)
> -				|
> FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT);
> +				|
> FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT)
> +				|
> FEATURE_MASK(FEATURE_TEMP_DEPENDENT_VMIN_BIT);
>=20
>  	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK)
>  		*(uint64_t *)feature_mask |=3D
> FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
> --
> 2.34.1
