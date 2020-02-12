Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E7C2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 17:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5E72168B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 17:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b7Im5EHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5E72168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB236EAD6;
	Wed, 12 Feb 2020 17:09:20 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700082.outbound.protection.outlook.com [40.107.70.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC7B6EAD6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 17:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsQpGDE5OSuVd9QdSrjlyiOX+uKM4/6SEv6CDqDLZ0qOfsuHAGYE1pl6//4cq5W7WyFEwub0wLBZ1VPRvqVl31sULXOmHHrFqd5huYad2iO0QhMMIifj5im0Hw6LVhJZ/fkhBpm5cYzhiOGv3w97phFnUMb5U3qjrWyGQDtHfqvQF7ATcrJFIKeN/1NyoqyCBNo/vbf1zkUtma5ObRdxMciTVBSfX4RX9sgUgfKSLPdvtlZChhPTQihA+FQ7wlzIR1D4Wq64CsBwvFpUIuTgP0CCq2t1FYC0vseN1XOIsV7oN/llco7tbbF/ft1yoIyhA95xCCh9XO2Hj2uIGmTrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFZblxUu1wf8Xd2ZZPfcDPnS9nssVnR9vuN+6dnJRos=;
 b=Cv3ro5EGGJWbgJWDHouvdfh6JMuNyjVypEwn0zFA4v8ZsIL1kK8DeU9TUKa+da4x/B6UFI/2T6GR3x3OCLAvWXMFD8p4iwZXPlb1qvK0j1o0Mwb8dPCHW6BUoUzzClGRyUGp/cwJItpTeJatDg7YtBRw+fHx7JsRrSULh3q9vLlpAHWuQK7jJCfhNCEnEYHfnERBGPU/7IR8ZhNPGExukPvMwsjjigD/Yz0T2kAXYrQTASw1sbpBLZjOVG27Y7Te8MeKvg246O9ASWs1tCaUDJkvO5FmWN+sh/PFDXvg+DmltPHOqRE3pd2RieTUGOsCX29zOvoTrrB53OnXbAuBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFZblxUu1wf8Xd2ZZPfcDPnS9nssVnR9vuN+6dnJRos=;
 b=b7Im5EHeSa6aGh6ZUjvLAdvQUpc77duJDjjqLyTlGCTs2V8gixltxwm+3KvWGEMQImJBbFI8hZydddLafbEIWg4WdQS4Uri/bjL7K0jRouQ9xInSurvIG8mkfxjb0VSbh77Fc1XLrKTwJIx/m+vofdXnRTLGM6vfnGiH7DL0B/A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2380.namprd12.prod.outlook.com (52.132.178.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 17:09:14 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::c15:4b9f:526:4736]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::c15:4b9f:526:4736%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 17:09:14 +0000
Date: Wed, 12 Feb 2020 12:09:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/display: extend DCN guard in
 dal_bios_parser_init_cmd_tbl_helper2
Message-ID: <20200212170908.khv3jugxv3c5pqcv@outlook.office365.com>
References: <20200212043258.1123758-1-alexander.deucher@amd.com>
In-Reply-To: <20200212043258.1123758-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from outlook.office365.com (165.204.55.250) by
 YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23 via Frontend Transport; Wed, 12 Feb 2020 17:09:14 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f4057a4-06ac-4a56-d5ed-08d7afde496f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:|MW2PR12MB2380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB238030E5876121EE544DA2DD981B0@MW2PR12MB2380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(7696005)(81156014)(86362001)(81166006)(8676002)(66476007)(8936002)(66556008)(21480400003)(316002)(2906002)(186003)(6506007)(6666004)(66946007)(6916009)(4326008)(1076003)(956004)(16526019)(26005)(55016002)(478600001)(9686003)(44144004)(52116002)(966005)(45080400002)(5660300002)(2700100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2380;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7jMkgs74tSRXM5PIQEthpvsmYS7E7qyjKE7CvSEJfadN3e1fm9h4aYp2MkL7r4RKvZD5zPRmMz6Dcj6EseM092y7XFkMciYrkoV/IEPCZPSpL//5DLgwMIoUAI4W+rrvtSEOxPwy+2uuCMnUGCTQEYmsR9hDDLSdpwl4VU/A4phHS8qiQDbyZTEbbPQPxdF0y60cupdkBCpRFkT8clWk80JtK9GyN1Qq7kSgESsgum1kTfkfehHwJZ4bJ/IePoHQaCkCW882ML6AI4iwJ8KfVaS0oacjjLVnYwJcaJ8dVpdMnONQtwNWoCu3lfg1KHhSgf5VW2uletDAyVNLRctetNU/lRyixRdWDVZIptuJlSsfph6D1XE9PtXDmwh7dKXcg/CEaRxCiMn2LidU2nT1bUM/xbE/khhRwz8c3QlLDt9FkFqEiC0/ptpSK0MUWCMA0lPjP30dGtYb8jTfiIiJkI8Wke4tyUqeTYkJB4HKG1jM1bIwqmI659SKJ/JoecyWqeqG/cRdhTXLEJlqH3gvuraHp69xH+BRk1H856rBAC7JtbArvkZeCER3m+w+ZhdbmOX5lGFzrQDVgKG4DgRQDU5JL57y9eRsXVihUREBvaxigtcctwm/KXYMSM2qkd9oxtCAz4ENUdccsmU2r6WoA==
X-MS-Exchange-AntiSpam-MessageData: cG0V8RolB2iZtpVn7MrQLj9lt3eyFQ6gHijDp3AyEh7qMLp3KGHvOMwfH5jREAAf8mFTfMMuL63/Mq4XzTtjXWwYxCEimq52du1G9uLl/y60Q9ZZnQRliWEEpIY+zynTqOiXY3FnGT7p+MkZ8rSwTQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4057a4-06ac-4a56-d5ed-08d7afde496f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 17:09:14.7510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqEXANCN278i3dnjfJZFW3WvWX1UwA9ZW0MZ8rxDSBrSeakgSgQBP+7Xd1QmpScCv/Hw+ANPlauYbWgVCB7lkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2380
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0799238996=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0799238996==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="au3c5iselpnr4pti"
Content-Disposition: inline

--au3c5iselpnr4pti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 02/11, Alex Deucher wrote:
> To cover DCN 2.x.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../drm/amd/display/dc/bios/command_table_helper2.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c =
b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> index 7388c987c595..204d7942a6e5 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> @@ -53,25 +53,18 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
> =20
>  	case DCE_VERSION_11_2:
>  	case DCE_VERSION_11_22:
> +	case DCE_VERSION_12_0:
> +	case DCE_VERSION_12_1:
>  		*h =3D dal_cmd_tbl_helper_dce112_get_table2();
>  		return true;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	case DCN_VERSION_1_0:
>  	case DCN_VERSION_1_01:
> -		*h =3D dal_cmd_tbl_helper_dce112_get_table2();
> -		return true;
> -#endif
> -
>  	case DCN_VERSION_2_0:
> -		*h =3D dal_cmd_tbl_helper_dce112_get_table2();
> -		return true;
>  	case DCN_VERSION_2_1:
>  		*h =3D dal_cmd_tbl_helper_dce112_get_table2();
>  		return true;
> -	case DCE_VERSION_12_0:
> -	case DCE_VERSION_12_1:
> -		*h =3D dal_cmd_tbl_helper_dce112_get_table2();
> -		return true;
> +#endif
> =20
>  	default:
>  		/* Unsupported DCE */
> --=20
> 2.24.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cab3f299a5c754444f05c08d7af74afbd%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637170788041384449&amp;sdata=3DjsO5pK4dLty0gy%2=
BNBQxRzJrR%2B9htMcinVWz7oR0fjS8%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
Software Engineer, Advanced Micro Devices (AMD)
https://siqueira.tech

--au3c5iselpnr4pti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl5EMS4ACgkQWJzP/com
vP9Kmw//QSAVsXGAPNLjcj8ncQu7GjrDpuw/tGpXG9FSMlvJII/yh7t01tF8PQ51
n0OEZU16QmH9ZFK/Rg0uj+9+Q+iz2FbSuThg1NuEYuQT0nkfLwurVgH0W18/FZn6
U+0I8gQz0qI0xSnGRKpJyWg8H7q8HvdvgN5mtmEcDZ1SW6FhFTJs2Uy6L94sSECV
krQePoWO7pdgbOfrgWa9YzcXaOF5EI1atVOHbegucOPKybov0xODQEParz9FDtIF
aK+fUL810MM0TeeFj66eVNBsD5NxeDFhpveQAPwbW40MfUTUILEm2Ou48r1YexUx
Koa265eL111KTJk2h8dFy7nZmEjj0n0IeLrsNRFJPSziLLJbPXwU6VOiBMVe/qJq
s94O9seLkIiYbL64isHZPBnbdEqN0ME73zfz/+PExs4BOMe4d2jCJLpe79qBm3U0
vUkK9htWI1J7cPcweXszOBQpwqLN9p/XW13sRKETosYJDC6ABkrVBifBKJIuFnMi
f5O7ikaNekNSz5azLNL1Rsp9yrwdjT+RvdIj6CRK+IYEUE6SfbGIqzsOmaIdQ9hs
BsO7K9p2u/hZhFeMYefAfHmuewep+nGSAGrjz6iprFe/+5ZxM6ibxNxCLr9lJaFY
Knj5dYg7jf1lV25Af2hplktVyZ/Hhl1aN771tbAL1BcSMGDRIe0=
=yZFs
-----END PGP SIGNATURE-----

--au3c5iselpnr4pti--

--===============0799238996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0799238996==--
