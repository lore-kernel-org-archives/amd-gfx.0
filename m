Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E7C2BA2B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 14:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE8220747
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 14:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nckVyk+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE8220747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411F189C19;
	Tue,  7 Apr 2020 14:52:52 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3061C89C19
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 14:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqCSmPnaD/kacie8IbAGmK+6TNWQ8tAVShxZvUvIPOzPvngQfL8lRRo1Y0nMjcaW4OFwd5qzjyIqivWAU+Cu6AIs/Rpj6QdVECY/r7RDUUc+1VOYEGfTKaohHacLc8kEg32uSKTt3vQyRO17234U/gKqzm65GzEu8NwNkZ3bQxDi23fg2G76UFxh3UI8BqecOAGRjdTSsCFATpaVxNxV/WrExHCT+YDKkZdRrQ7UFix5na6IZuvmu+o9YcGFsZgyquL2g/sUw8ZsQrQxG7l5zVq3HzVENWN8UI4yqakcwvDO5OMc6l5PhcSoeZ0oevSszy8UC4i511s5raacTrH51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+w9lnsknLB6mKlUjvs75GvOlUBp+36RzGNz3hlJyx4=;
 b=LHQDv0mOdGrTUJrVSX9OWGOQSji4+Bj/Q2Jr/w1vpjMOGiOMFJO+PKRgyur94Z2cnhHVa72vGxANh1Azwmt89aBdoippP5wZaR/vFnu3gHa+iOq/iDOR70ap8RSrtDMhmk/mvJ6a2xtdJRlvZYFR3Y1pwp/DCkLzquZ5HMJN79iDBy6VxXjtR0Yr9Q6BdnY0vLFXPIGORHoLsUXXFCYNRCwwoj+fu+l/aUps4P0g9KJj0n8BQ4ugIYvjEElqhNpxt+MWi0amCd3XdKrHoj75DyY76f/ccImAvs0pMjpTOQpdpknYFRwlLKs/kE2RVTYcZqA2aDibn42nObJYQuODeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+w9lnsknLB6mKlUjvs75GvOlUBp+36RzGNz3hlJyx4=;
 b=nckVyk+j7jgVfBOCrHAB+fbnAvPQIXZ2YXJb7fw+BP5QCWsXSs8kwxT/FBXBOxBqP8BaZD6sV3aeNuFryyR/P7pKxGgQ19e3nHLsNd0nBVbYkXwIOpp4/h1uUnQFlmUesNmLpWMLDSve6l5OIPnzLT8gQDBEIW6JdMZ6DP5GWIU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2442.namprd12.prod.outlook.com (2603:10b6:907:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 7 Apr
 2020 14:52:49 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 14:52:49 +0000
Date: Tue, 7 Apr 2020 10:52:45 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
Message-ID: <20200407145245.beu2fnyyoyrhcm3v@outlook.office365.com>
References: <20200406155249.16576-1-kent.russell@amd.com>
 <MN2PR12MB448851189B033D3B472C3287F7C30@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB448851189B033D3B472C3287F7C30@MN2PR12MB4488.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN6PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:405:14::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::4) by
 BN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:405:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 7 Apr 2020 14:52:48 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25b6ce21-4582-4950-4e05-08d7db035740
X-MS-TrafficTypeDiagnostic: MW2PR12MB2442:|MW2PR12MB2442:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24428A84351DEE3B15294FF898C30@MW2PR12MB2442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(66946007)(45080400002)(66556008)(8936002)(86362001)(66476007)(55016002)(16526019)(81166006)(478600001)(21480400003)(5660300002)(4326008)(6862004)(6666004)(33964004)(186003)(2906002)(9686003)(966005)(8676002)(316002)(44144004)(81156014)(7696005)(6506007)(6636002)(54906003)(53546011)(1076003)(52116002)(2700100001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31iFxMbMDHz5O5kTapGFQg0uRTTJNhGHAf7k1q2gctSL1Gj/4I70E/QZZI0XCRVif7dhVTN5E8VqayF0U9j8OcszN0z3x2aLJ5uCXn2cRbtzr3p3MN2MuhKCxUjICobKDB+0GBdRyYsDZDw20BZ1s4qMayUj4WAsFnY5J2TFaWPN8awKmavnAQZdtXESaulfoZhhujo1asCqhYJes9NhZTPunVaYnr/cp1XyzTY4+oMB/B1aiHql/xP0YsizBQio1fbzcXBLJKoShr6/X7vdTJz5cxN6+rD9Mn8h80cQZqI4QuuXrKoHL77DtjATnZrTHWlickuNSbw6FXSvzOLILPM02yl8q4sIkwHu9fyag36++qSltWzdqEWHadlE+N+WqixPo9sB6WbOTewgXxcm0rkH+T1KqVyY/ao0vOWXKv7jPJcNlIS5a+wens+wOu/tupsGLxwZptJB/W8M0CdJGlVa2daCBUH110VMkF3sK9ns+3wtSbG0PaE7GXdQ2h0Vmxi2R3fldN+xhaJpAO/eL1gUwZOVNSZOcu3MJrdcR3+foHdVj74jKxwpiYIph8dq
X-MS-Exchange-AntiSpam-MessageData: PVk8oNq96u8b6H4ZyjdyS9Hy3/og9dBESF24KC/u/ltB/IiPqO57+GFdW/ph7Z+2Iq/3AnTMtOCtrZiALzJgu4RqSzcgnhT9S09fAN6Fo5O9tpzzwwryDVcCkqk4Vj5xBBf+AkuS8PPgdBkgOi41Oc1CyiQya494W4zAab2feOU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b6ce21-4582-4950-4e05-08d7db035740
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 14:52:49.4299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/6FLuIk/2hSQyZOAxImZrvoiDzHvF3DKYQnBIPkw3hNXaZ6bTg8Wt82q/iWCpcZWUzV6GxborwY2ZhCejyLHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2442
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0837196387=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0837196387==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgik7lsyoyeypian"
Content-Disposition: inline

--dgik7lsyoyeypian
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

After applying this patch I have seen the following error:

 In file included from ./include/linux/uuid.h:12,
                  from ./include/linux/mod_devicetable.h:13,
                  from ./include/linux/pci.h:27,
                  from drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c:23:
 In function =E2=80=98memcpy=E2=80=99,
     inlined from =E2=80=98amdgpu_fru_get_product_info=E2=80=99 at drivers/=
gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c:137:2:
 ./include/linux/string.h:376:4: error: call to =E2=80=98__read_overflow2=
=E2=80=99 declared with attribute error: detected read beyond size of objec=
t passed as 2nd parameter
   376 |    __read_overflow2();
       |    ^~~~~~~~~~~~~~~~~~
 make[4]: *** [scripts/Makefile.build:266: drivers/gpu/drm/amd/amdgpu/amdgp=
u_fru_eeprom.o] Error 1
 make[4]: *** Waiting for unfinished jobs....

Did I miss something?

P.s: I'm using gcc 9.3.0 (Arch Linux 9.3.0-1)=20

Best Regards

On 04/07, Deucher, Alexander wrote:
> [AMD Official Use Only - Internal Distribution Only]
>=20
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent R=
ussell <kent.russell@amd.com>
> Sent: Monday, April 6, 2020 11:52 AM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models v4
>=20
> There is at least 1 VG20 DID that does not have an FRU, and trying to read
> that will cause a hang. For now, explicitly support reading the FRU for
> Arcturus and for the WKS VG20 DIDs, and skip for everything else.
> This re-enables serial number reporting for server cards
>=20
> v2: Add ASIC check
> v3: Don't default to true for pre-VG20
> v4: Use DID instead of parsing the VBIOS
>=20
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index bfe4259f9508..9d17761721de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -20,6 +20,8 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   *
>   */
> +#include <linux/pci.h>
> +
>  #include "amdgpu.h"
>  #include "amdgpu_i2c.h"
>  #include "smu_v11_0_i2c.h"
> @@ -31,8 +33,16 @@
>=20
>  bool is_fru_eeprom_supported(struct amdgpu_device *adev)
>  {
> -       /* TODO: Resolve supported ASIC type */
> -
> +       /* TODO: Gaming SKUs don't have the FRU EEPROM.
> +        * Use this hack to address hangs on modprobe on gaming SKUs
> +        * until a proper solution can be implemented by only supporting
> +        * it on Arcturus, and the explicit chip IDs for VG20 Server cards
> +        */
> +       if ((adev->asic_type =3D=3D CHIP_ARCTURUS) ||
> +           (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a0) ||
> +           (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a1) ||
> +           (adev->asic_type =3D=3D CHIP_VEGA20 && adev->pdev->device =3D=
=3D 0x66a4))
> +               return true;
>          return false;
>  }
>=20
> --
> 2.17.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7C94ab725894bf4069999508d7daf6a1a7%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637218625208800660&amp;sdata=3DEMsjck3eT5RA19qG=
VLjoFVaX25zgPq8axwUxSR4HyOY%3D&amp;reserved=3D0

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7C94ab725894bf4069999508d7daf6a1a7%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637218625208840485&amp;sdata=3D9ZL1XLDOi2qBIMV8=
obDmCIB1G6PKi%2FXegRfFDZtfMfA%3D&amp;reserved=3D0


--=20
Rodrigo Siqueira
https://siqueira.tech

--dgik7lsyoyeypian
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl6Mk7gACgkQWJzP/com
vP8bQhAAnHNXvXW9U95s8UKhZOrBd+wy3zq/Xq4+Xn0DWgDxCOqkXO+AdlzdDWO1
sq9sxja+iRsmYRreowcR0Iioj2lcEX7JEcR5mrZ2iyn/+ZVLtcs0J3vk21XK+dD2
uxiksbJhNLx7Hy2ZJ86/11GKKzZlkZPyF4/K1DzaASmEux+DpBrHDc2Rn8rq/JUS
UMJNP/WmYBzGrembDSJPvEx8dBRq6zOZ6kYVjIzNDnLwZWKbiOKKpulC0ggrwWXW
pAANP6uQcSub8asmBoTKxFfy98FI/iiDKx8iklr07tsrU+6kDWHL9/W73K3GVOoe
SftBQWRi/cwfM791QS5BesaHdKCgZdNEb4q1B0WrAKw4QfPpenrPB0BxcKdDpa4M
0oZBkqJX86LS/cEOBm0hiWmSjUy3CyWw2TE67KpYlzfj09g9vFDg20xBB8R5PYHU
FP7gXwV6pbPq0XucIUIGefY/2v+cdIqxXEUQGLz9x1ppnCN1WMB+pu4yuodrehuE
ZlnEe3+epA1JQElmFyZVFwJ2FQIpi9fWlXktJ/ro9fwBJiD38T2VpHVVxavKVEC+
0vFCzq1+OPpStKhF/fyYFJ5RTgfx0jefbCfxSdKqlHheIqPq+axvmtSgIu5ZZlMS
03NfB3xeFQJ+l4uZJkqSSH0onpJZ6Us3u2dV1cD9TwnWqYdHhME=
=HLjO
-----END PGP SIGNATURE-----

--dgik7lsyoyeypian--

--===============0837196387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0837196387==--
