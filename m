Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A5AC28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B529310E02F;
	Thu, 25 Aug 2022 07:50:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD73710E02F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4qdD46KNPEuWed5jqQdgeRBnsgqBf1pZhuN3pRAAo8qnP2zhnwm5JzhLMkvkDk1/mBN4R2MzPdzlDhXd6H7OidvXjbszoAvnuTFYh6HK0PVoQgoFEACB6PEe5EobL/QRo3w24/yHEvu/pPqy7csKr2OSwZezaAEzs3uu9Y2ikHytkRtJfk1SngX6tDykvohV+g436ncT3WoDA59TVQ5J8Avnf7Gp8oRzYiBb1mMqrdyabe91HutEjOo+NTPIQSMp04JR/C6bMeFZcgafYtpV3INilfBfTGPvO3DOUpnYh+K7mOsmc1DD0eCXPFef7Cp/+8yzmzUCw89Ot0YB+BS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKyeux5Z5/srB0AqVVEjDD4XEVP8lOAEjHx3QfksJt8=;
 b=iiJ7CKwJgyouVCHNFJWCxGwnBcJ3mH60Hy9ijYjYNvWRk8he0ns7/KbODbLDn6tnb7CT9relTyPWKRjZ7G5mqTKApjj0OXBttRgX5kebXYWb6TPYLRFyoibhUAkMua3rGO4lZDfIs/ONhrGGniQuDesdp/uLDQkMbC2ijRXRWlJ8j9pGxSLm5cC1KqSJ4Q6FcBGrmGmfQkG1yVcdBYREl4tcbZw7d2Ep6+Ba7G2dV/kBhevwnOfMkxNUU00MY1JlV3F9m5OVJvq+ZANzueOChxsl5zv6mKnjOCTCDH79Raf3IDxGgSaGvVmwU1KfQZRKHuIK18bhuDt+tQET8Y86bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKyeux5Z5/srB0AqVVEjDD4XEVP8lOAEjHx3QfksJt8=;
 b=JwA9gMm5q2z3gtVVlUzLc9f7Ss/datjVbxYZH3kxP1GLcwX26BQD2GhDKT0LJHS+Ky3V4EZwdaSxwGIdPRTRXZDjWwkb1hzXcNavJkx58wZra+U1ETEcWjB6XIatTlETGDW3KfSe1mNxp89q+Em2Y0Dx4rwU95KaJsR9FenWuYo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.24; Thu, 25 Aug 2022 07:49:49 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46%7]) with mapi id 15.20.5566.014; Thu, 25 Aug 2022
 07:49:49 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use dev_info to benifit mGPU case
Thread-Topic: [PATCH] drm/amdgpu: use dev_info to benifit mGPU case
Thread-Index: AQHYuEuRJpa8gXPD3kyOqyC6KAixua2/NLiAgAAI2jA=
Date: Thu, 25 Aug 2022 07:49:49 +0000
Message-ID: <DM5PR12MB2469A85562E8AA929677A695F1729@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220825062550.331393-1-guchun.chen@amd.com>
 <DM6PR12MB2619FF2341D8EEE09D90F177E4729@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619FF2341D8EEE09D90F177E4729@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T07:16:52Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=386409f0-a1fc-4b96-a5dc-3d2accb4f6ad;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bbe033f-e422-44a1-1f76-08da866e6319
x-ms-traffictypediagnostic: BL1PR12MB5779:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0BCLHYIH7qJUBKRW1ROvCvj1eBb8OCcrpz/FX9H185C3LjZX0UnyGqAsnaPiU+mkylb9Jtrcsxo///supCuFvjwkTPomZ9YEhAUPL3G8LU1/VlUhPU4EdUy68InQb4jV2Kl+S47o0Q5L6qmEA8CTRD/8x6xmtL5nf/V0C8kt+cJnRz6DIwVWSlttdVm4RM8GGzjG8WAYAWndyfYxhxAVD0I/CFn+GF8nXt25bm5TAM2FOYzXA7hJ0CJSp6upFewBnzi6dR0jZk9n6ul9abIlKpZEUCqRbaPvhHcGPunTrLonHNDbhxG5zc2DnZbzBkmw/5D2hGOIQnFV7HER429WgaZ0sfnAsWdmr2DgB2WniW3xzn0tDQo1+l9jaznRilif8h/NgJ5EvoVJXOyWOORrJmy038AK/IBXLP1QQl4ASpsPkWj7lzB509c1r9UvgldNPdNjbN79QDJs7xg4/KyKf3W+D9I5tw6XNlwfNmNq/iu5J8bvRPM/hgG+emugEGrVKCAl2POe9lvA/cmyIxFcLBHnkay69Pa0sCjEDK8GGaFGx5QsmxGDNSH7Jaep26B21qDmpqqDtS/VgbECYrJ1ju8/MzGl9VP3gEMYh92czTkcf+MELaX6mmWwZWrWJUQ8zNFspnKUxAcorzVTOauBeU9mosKXP4u6C5JsnRTqTGSnNyZkr2VJKoPejyabhA6b7f5HXMnIuAT/vW/zpPLd9DLScR7eWET9hHh69djoVzW7pPnSEcuM9HBhGqWXTwtK89v5mIndVJqUGFoh5TRhGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66556008)(8676002)(66946007)(186003)(76116006)(64756008)(316002)(110136005)(66446008)(66476007)(86362001)(38070700005)(83380400001)(122000001)(6636002)(5660300002)(9686003)(71200400001)(7696005)(38100700002)(55016003)(41300700001)(6506007)(26005)(53546011)(52536014)(2906002)(33656002)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UqZ+4cBhH1VCHuQKgxrurgBNzAHWf3hoKC9HBqyh1a9n3HXcnDc1ffN2zqOQ?=
 =?us-ascii?Q?xk/Bhswif6O/TWp3FtoMEy71SSfYIR4IgRAtgKDA8Ihhvkxx3XhyYaeBj4kk?=
 =?us-ascii?Q?3MfHZG6d7zeR2vMBnVLy8hwkk7eSmRE1gRAO6WTbh1RFWVgP20fXO4UKZ7pe?=
 =?us-ascii?Q?e5NkhG2oNH+G/05ljCa/X2hron+1EMgY1s2y8EnBPj5hQVWC9FkWcqZ/PDok?=
 =?us-ascii?Q?FOS0+W0eTDwJBuJahNmIv5n82KvVvN1AcPj5cKbvPiSH400905BAy4ULUQXe?=
 =?us-ascii?Q?NQoTzIA4Z6Xxcynx6LB44PCQ90haqN/ZSobazQi8gqn4OFadRCOOvCh0Z+xu?=
 =?us-ascii?Q?rZMOHCNo25Rb7KgOw0NaacPlwFRFnnBmLSKHWWAC09gTAorQYKWc5cb314mC?=
 =?us-ascii?Q?beElxwrIRUHM28VD9veh6gJPgc4bSdNz8EtknUVArfoTr8Mj2vrvqggpdaqg?=
 =?us-ascii?Q?rmdX91LveKkW2gIJdH0lmM8c5FiGi0wYTacdjh8+UHCkzpHWXGJK2wWhGdNY?=
 =?us-ascii?Q?AcAdbMvpwyuyudgWYylEsBjIpLOy4NdqSDmQCrUOJQqvHxrhSMi/VnehBge9?=
 =?us-ascii?Q?utUP4xwNjXdnmJcni24XHYWwHg/i+YWXRp+C2ACkP1XxI9Mk4g9WEIcwkuFF?=
 =?us-ascii?Q?ZoLXB37jHuSvUgfIeulv1A1gswSNMYgJCiROgLSA+fUTSayq0T0AMjzdW8uC?=
 =?us-ascii?Q?YfqmVVA7UBjPRViUKsXNVB0INIrLh6+37YYjDaKomYtwnWrY2TbOFF5jWeWd?=
 =?us-ascii?Q?ht/x/XGvOex097jx/P4s4lsEODsbAC39/94H5r1i+VkcoKO8YrCSN/4o6hmk?=
 =?us-ascii?Q?m6DPXdvCUUN4lgzXyVBy+xb74y8JtMtdkPCzvX5RGuwjhKTVETGvXRYrZWx3?=
 =?us-ascii?Q?zfPuxhq/E5WiQH7f5cxdvHAD9RFQycd8JMDeXx2+q2tt/ogF84Kt//VjMz7c?=
 =?us-ascii?Q?sORPNJ8pmMoITX6CtFih2QQh9jtH2GaUej5lEWQijgx4muBb/3u1MZMwi3Pg?=
 =?us-ascii?Q?2EHt5a5hgCC7u2VorvjS6kNtIUui/D5rcMocJgEwchKASPHWXjc7XDVq5qaL?=
 =?us-ascii?Q?+1FoHqb4uYZb7G5z9PDSy537vgdaX2mrBKvDBw+0UhJQuVQ3w6a6GYuVIaXK?=
 =?us-ascii?Q?18m7DBDMXyGpw5CijnlpV0vZD16oQZlr8m1FyLsUjI/ClIqxdYgo79SIZGO1?=
 =?us-ascii?Q?NBz8Lxt+z9q2ni01XRZGLH000NMndZHyqJ1+hdDJ/7Z+YH1Okvwx93N4OAPA?=
 =?us-ascii?Q?XA2oUK3dcfgVN+PFqF9UzL1PbBNmgu76N8Y2dM4JeeuGiK3Ft1+pXG9pkwap?=
 =?us-ascii?Q?Uu+jqP6vbSLefuomn64TkA69vvxXwVcLRJuRz38V1RCjYALE0danFRTssLT5?=
 =?us-ascii?Q?QbvZ45l7l8WDy7qhIvpY8Ic+xkjiBEL3vNGxTX8bndQLdlDJJ3+clabB4PEe?=
 =?us-ascii?Q?ZBBctNUUqzxkTQflWXlIQI6/xddynlVGe76OnSwWnwyDp23gqSlB1A1YnWZC?=
 =?us-ascii?Q?o69IUUwWYQaeTLs0328zzHuruPwV/dke3gQQ7QhWVa1LDBxwxpt+oeNSfAIZ?=
 =?us-ascii?Q?NYuHH86SUnshsqHIn2eo24ucGptlgYWJgV2LNO2j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbe033f-e422-44a1-1f76-08da866e6319
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 07:49:49.3305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNYGDfjkgTopHiyc6PlLu3JpUxdytmFSlmVnIFh7AGmX+Keb2zpJvPG/woOPCLcCuB3NWZbHE6jF7nsYNMgC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
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

I think so, we indeed need a new message indicating suspend, e.g. runtime s=
uspend has completed. I will provide a new patch for this.

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Thursday, August 25, 2022 3:17 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use dev_info to benifit mGPU case

[AMD Official Use Only - General]

Here "free PSP TMR buffer" seems having some special meanings (a marker tha=
t indicates suspending is on-going).
Better to redesign the prompts for suspending.
Anyway, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, August 25, 2022 2:26 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=20
> Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian=20
> <Christian.Koenig@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: use dev_info to benifit mGPU case
>=20
> 'free PSP TMR buffer' happens in suspend, but sometimes in mGPU=20
> config, it mixes with PSP resume log printing from another GPU, which=20
> is confusing. So use dev_info instead of DRM_INFO for printing.
>=20
> [drm] PSP is resuming...
> [drm] reserve 0xa00000 from 0x877e000000 for PSP TMR amdgpu=20
> 0000:e3:00.0: amdgpu: GECC is enabled amdgpu 0000:e3:00.0: amdgpu:=20
> SECUREDISPLAY: securedisplay ta ucode is not available amdgpu=20
> 0000:e3:00.0: amdgpu: SMU is resuming...
> amdgpu 0000:e3:00.0: amdgpu: smu driver if version =3D 0x00000040, smu=20
> fw if version =3D 0x00000041, smu fw program =3D 0, version =3D 0x003a540=
0=20
> (58.84.0) amdgpu 0000:e3:00.0: amdgpu: SMU driver if version not=20
> matched amdgpu 0000:e3:00.0: amdgpu: dpm has been enabled amdgpu=20
> 0000:e3:00.0: amdgpu: SMU is resumed successfully!
> [drm] DMUB hardware initialized: version=3D0x02020014 [drm] free PSP TMR=
=20
> buffer [drm] kiq ring mec 2 pipe 1 q 0
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 1036446abc30..c932bc148554 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -812,7 +812,7 @@ static int psp_tmr_unload(struct psp_context *psp)
>  	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
>=20
>  	psp_prep_tmr_unload_cmd_buf(psp, cmd);
> -	DRM_INFO("free PSP TMR buffer\n");
> +	dev_info(psp->adev->dev, "free PSP TMR buffer\n");
>=20
>  	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
>  				 psp->fence_buf_mc_addr);
> --
> 2.25.1
