Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2EC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 19:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCD564EBA
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 19:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCD564EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0D06E07B;
	Wed, 24 Feb 2021 19:24:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75EA16E07B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 19:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIdu2aFnCtXiVEM8pYOpgBuFRQkiY7oiS2rp9Yh11RgJSeUV+hH0K/N3uE5t4dYBDMdzHBEN2jDpJttQh27lJHp8XkapU69Ng1F5XHnjCY7pPuTh1RmT1D7i6B56PeJkf1I4qI7j+sh7mjbuKHy3wiR4LMV1EK3JeEQVx5pd+L9fG4blX8Jl6+oMhxnGxdGTjo7VpzlTVbn+kn9nyo9qssWQTKM5NYyIyA9kMtpk91HYlHrzbrnpnkng8kCBCMwmuF4blqfrx0pX0LVVAU1w/zJQZGRxMkX0e3z1Sx6SXn0yBOWpFGm9VqlXHrQHRXZrxGMBf8sQHUoHFQ1l54IQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q5a3UWzZjSoFnC3x3d4A+Vh0rN0BbPM1SvQklhRAHA=;
 b=iniEF1FrJjtTdtXuoSSE5bQ1qRk01h02+bpjiefLz3G/+Imn/XvIcHcNHxRvUTHA2sihgEaV8vH9ifz3yhhU57BQAeVgydUGbCzHMGx816R4I8CoKc9Sw3wlbzBJSTfdfelc/z/JAo2nEB3WgWSo1cNbzaLQofWHqNc7K8i0sj8w/DlvYyuFU1HGa6PKhVGOdwAaJ3K/U3SDC3dwGmTgSVvdDoDh/ySev6zE3UIcKrEsT1FuP++f+x0EeWY2t9eKwPfgkfY07VsXd03v52qNUsTQuNE8MUImM6XhKMiCh+T/RmKSpCIWIfMjhVVuXVOPsYCUIF0UhUlHRvcwoqQ0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q5a3UWzZjSoFnC3x3d4A+Vh0rN0BbPM1SvQklhRAHA=;
 b=gckxZFEYmRMiqrhPc0KqC1192cKVa3BOOajP3hBtPI6eISgB9MLwJ6djw1WxKkC7ywZ/EF46Q7wcJSEIXATj3WAIoWJAoAPEVUhLR5fhVhSu7OTvwvv42PRLgU+lN5uoyptw/rTbnORC8TDYVPPAFVWQhLLDHpK+qFvJ+fjXv1E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.29; Wed, 24 Feb 2021 19:24:27 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 19:24:27 +0000
Date: Wed, 24 Feb 2021 14:24:24 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: changfeng.zhu@amd.com
Subject: Re: [PATCH] drm/amdgpu: decline max_me for mec2_fw remove in
 renoir/arcturus
Message-ID: <20210224192424.352yt5jglftpayf7@outlook.office365.com>
References: <20210224091055.3410-1-changfeng.zhu@amd.com>
In-Reply-To: <20210224091055.3410-1-changfeng.zhu@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:2b4c:4ac9:5f95:cabe]
X-ClientProxiedBy: BN8PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:408:4c::32) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:2b4c:4ac9:5f95:cabe)
 by BN8PR16CA0019.namprd16.prod.outlook.com (2603:10b6:408:4c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Wed, 24 Feb 2021 19:24:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 166c7ab8-c5eb-4bc4-4cae-08d8d8f9cd29
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4137210BA4BAA3BE30A0B85F989F9@DM6PR12MB4137.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fA91s5P1kmfv9jTDISpkNQBTxMZcnDz8M8ZFNP9MTHUfWsA4XYVOD1D/Q3hWEBnM/Pd15xHgxlJ37/nWQ00jCuUq1r9a3HDmu0BIs9ptVa4DEGs1FBROWB/W4laryRe7kDKC/NFFMVgYLh7cFZqrFwf87fLwCeQgXivm0IY6bQQXwZ0ca3PAhsKMJkW4+6dbMn/E552VCa2jUmPTIw8BO8yCRAORtWO/4KJBLEL0BPwyTR3fUtjiwypyuG0VWqzsTK5TUdrxqorD4JuaqfIZXxVs1INNCULr3unJ6ex0jdcaQ87hSyc7KXu4wzQZ/5AULG/KsUoT0Q/PHn14/BQXKKnj/7MAqRpRFZ584oQHH0jgaHvUg7tDXj0mt3hVQawDQczBcB98mSM87l4NydSj9lJfIyN4oS7aueSugX/T9khorjy6D0mZXtL05J/vAB2Myw/9dpRm6XkF7L3cSJ1R2Y2LaZ7i2QunlxgQgx3y7Noq3MVH+fleFisUz1TZMq2hInnG4q0ikWZ4TWpMp3omH9i1zIeH/AmuDfxpN3B72z1TXljKvppfkzL9wtlK5jRlY4YE6xGtiEy++LMmy4BbFG5UUBsTswwVm80ZnUFshTO6Myg8TyyK2yZtSqB1Lv73SbAfrBKFX7th20K/GUL78w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(9686003)(66946007)(2906002)(6636002)(66476007)(186003)(55016002)(66556008)(478600001)(16526019)(86362001)(83380400001)(45080400002)(8936002)(966005)(5660300002)(4326008)(8676002)(316002)(1076003)(6506007)(44144004)(52116002)(34206002)(7696005)(21480400003)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eMNw0X5RiqxIi0xK3yW3S+hgSpPP2tZOUDAN/5W8MEqzcbdiNABiGxj752P4?=
 =?us-ascii?Q?5WqtIyyEqcMGqhV8y5v49bcypUzBsNJOXeOO6C60ldXo8An2c/46IcPmwiN+?=
 =?us-ascii?Q?7hmMCyoYyF9CUxUYNqyyyonOw2QvAa5PyB7rxa/xH+Pmf7Q6fkoQbxmU7EVU?=
 =?us-ascii?Q?Q65wGFTmH0/ItwH9YIVk3FnnTvRX8OWAAd15TbJsDIyZYbqdHxic0JYjw13D?=
 =?us-ascii?Q?TLaHfAIcqjbElUIuKZUWmyOY0tUoKDKSu8i6V6CHkZ+mLd+9AS2Bot5zUKk5?=
 =?us-ascii?Q?7a+jZomoKEeuDWZFMokDjL9iS473Co62cvH/8cAV0W26tG+cR9RasL9wxfPT?=
 =?us-ascii?Q?zZ7AOeuVw7s7hfrKXRpTLhqDNtuR0EGaBexOPvEMnx7Wwxn9+YGGdnZqjBgK?=
 =?us-ascii?Q?dAE9p0SfccFL9i++gDfTiIwCrHUTavpOWUd0aPu4sAwOhwCsG73lVtVV7AvH?=
 =?us-ascii?Q?3BLfNOIAv1WWDmKoM9R59MJbds3EDQ/GVOzolL3BFYJ/dlFGLazmrV0Sg4Vl?=
 =?us-ascii?Q?hPzJ8Ct7Jv7nBqqNy+Sg+X5s41Hto3vwkF/4t7ybSAB9j5hXVPdyDEsVX+I3?=
 =?us-ascii?Q?qnrsaS1GMxOL0y63CGnZSvC+IHdfzZuuTFsUAIDzQYj+uowzbCamT9x8AknC?=
 =?us-ascii?Q?2IMGQhq0hRQgAwpzUCJc29Lcw91H+CqmllI9zIq7KrQbq2Z5ecW/e6DkS9F1?=
 =?us-ascii?Q?mibYloPVo6CpE+SgKuHJwYri/o6/ctEbAhn6s4PYnpMk1keicumxXOtSfa51?=
 =?us-ascii?Q?m+HwSzROdyIOzKkLHC2K5TZNYDPjh4xL6G3k1a5OM0m1N6wRd8fBNEBHR2Ar?=
 =?us-ascii?Q?8Qml0comYn6fM3en1MNy4S8z6244c439nJeeodDKZAB1sQZgNJLFvcEQBbtd?=
 =?us-ascii?Q?kw1BtMoHwJ6XZ3PU/P3Pba+HIlNQtd55mSN94OD05h1ruXIE1fmXhr5hLLSW?=
 =?us-ascii?Q?sjfQWi4qhPoIhYMG1FrMmPUg511jNsFdFKZYdFRUzLNNl/2cxQhlqhM5Pgxk?=
 =?us-ascii?Q?a2UN9W0JheyetBlO1WOpjcNGGwL9q9kGzm4gCM3rfoSvJKOwaT4Ikv+mjZ5i?=
 =?us-ascii?Q?QRZYvuyudwrAEWF0JJYNNk5/q2aHzY64lIcuxjYyMhfheJEiCQ9qrC/7CaQ6?=
 =?us-ascii?Q?5Rq/UV/xQ2Ts6MJZfLpBP78BnQAk4Vtj9Rml0F0VjLpv6/V1OPm0wcIObSne?=
 =?us-ascii?Q?jsLzRTXIu9bf3P0CRKeAPrnFAG5MuHAodniZeWlVmRtf4yl+ddjY16Qpwu0w?=
 =?us-ascii?Q?2cnSVq8TKQhCLZ8WyAdDykLHKJqiHhhmOP0V/+D+xQT284vHmRIaz+O3n7fY?=
 =?us-ascii?Q?xB6piWAmKdU+1jgj7jeSmKZjCFmcu+1cDmf2NIN1AoWovhhF/3YaQPJBWxQA?=
 =?us-ascii?Q?1KfQ32fgQTjmF5pdavm0hAl7JmGv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166c7ab8-c5eb-4bc4-4cae-08d8d8f9cd29
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 19:24:27.5965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd9UOhXly37rU82X6fFV1aHjo/cCyq/HhlYGvoXYzutzvdOCZLGGi46Bj5dnY1H6cETqgDRke6f6tQ49sHUfRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
Cc: Ray.Huang@amd.com, John.Clements@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1889122147=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1889122147==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ecjaua4hbvw6goh3"
Content-Disposition: inline

--ecjaua4hbvw6goh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02/24, changfeng.zhu@amd.com wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
>=20
> From: Changfeng <Changfeng.Zhu@amd.com>
>=20
> The value of max_me in amdgpu_gfx_rlc_setup_cp_table should reduce to 4
> when mec2_fw is removed on asic renoir/arcturus. Or it will cause kernel
> NULL pointer when modprobe driver.

Hi,

The commit

 6972f8d17f3603a6b002e42f7890a42d77e3e50b
 drm/amdgpu: disable mec2 fw bin loading

introduced a regression to Renoir systems, basically the system hangs
and your patch fixed the issue. I recommend you to add the Fixes label,
i.e.:

Fixes: 6972f8d17f36 ("drm/amdgpu: disable mec2 fw bin loading")

With that change,

Tested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
=20
> Change-Id: I268610e85f6acd9200478d0ab1518349ff81469b

Also, do we need this Change-Id?

Best Regards
Siqueira

> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 2f56adebbb31..300a07227597 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1890,7 +1890,10 @@ static void gfx_v9_0_enable_lbpw(struct amdgpu_dev=
ice *adev, bool enable)
> =20
>  static int gfx_v9_0_cp_jump_table_num(struct amdgpu_device *adev)
>  {
> -	return 5;
> +	if (gfx_v9_0_load_mec2_fw_bin_support(adev))
> +		return 5;
> +	else
> +		return 4;
>  }
> =20
>  static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
> --=20
> 2.17.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cccb7b58ed1df4111bc6b08d8d8a42b59%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637497546910967958%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3Dz0S60q8SZYqI3sHYZRucI2FjuXqll9ZdLfreHl8AQyo%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--ecjaua4hbvw6goh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmA2p+IACgkQWJzP/com
vP/FRQ//e05wK07JqGhXRWV702Z88UUvgMTYKJf7Tu7lLTPWYXm8/9ct3b7/38MK
MRdKfL8qmE25XywFmguQp718H9Y7Rb1BDatjMhrPIerr63VNNsS8Rg1XSNWkPnn1
xMAbQL9dtDljbYwsvUM+hx8+XTc4hVxqr59TbBUateMFvPH+/YkHzYBtEN25HXM8
rS3B0wFP3OaoNCaNQPxJt9rfkujcwuWoN+hcHq4CS/zc22H0jLv1EjNyNV60KLyp
iuqccD70+qGYTBMvlfYvpx3v92yNeVsxDAlk6egXadGQCsHLRCIPQkf/xyHR7xC1
GvYBlqHEzkwGNUGmP5sseEwHCeDCqqtd0ri0V0O7YaTQRrdDErLo5qV/MCYNyzrx
0LzQfwUun6qW5TeKnYadSZ74BAhGXZ0ruoXB1d79NeGGXI3r2w4mWtVpxpE24RuS
dPyMBu526Zdtz126sj63Sw0jEOQ2qn62EJKaY6Cb4dIp60Pt+hnD4/+H/McgUMct
XFXtTpDLK6bD+D8f/eifBrw0zEx+WaVSA9dQ7GSf70bZBC69kyXwZht4b0N+bZct
SGFxJXDNt1E+7hAVRohxebgEAYfVFyZJ/46gpFQFTeAbUuJkfmJd90hA2I3Pu1IJ
386ryKjw5RJFz6QMxrqPDYMAsgMHQ6B8GWN++FGC5o/s6ckbjGk=
=GKJJ
-----END PGP SIGNATURE-----

--ecjaua4hbvw6goh3--

--===============1889122147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1889122147==--
