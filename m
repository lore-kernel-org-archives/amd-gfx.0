Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12D5C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 15:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6004A64E20
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 15:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6004A64E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004C189320;
	Tue, 23 Feb 2021 15:48:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A29F589320
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 15:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPAqKOPEi9CgxbfsCTm+bHjEJREWb9TTrZyfK/pAc0hhj8fnV7idRS1zeMbi3tF6CqlF2S7H2on3zzvT7tYnWklWQLJUBJ5G31CuPjDFremT1xNtgKPbpVOVCaTkrG/rpJUUVh8nV+eF7efNBU/xnjFTO9Jn8dEqb9vaac+xnKKnhYU6Wm+xr11DxUF6A5DZRqqZxqI8Ykkfd/0Q8BBEY1GCHmX7k9HnQxi5IYpFsI8AEGjZkAj06BWWqEli5kvNhsVtRjY/2MdbbaC0A0Vjg3rvv6rldlCfeSicj5Ax1NFZglCfeOEbENEjWKg3p8yPWg3INbjnolFxVTdRJ+kOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cCjFs/cnXguxLI62/UQoMbSUbARI4kMczvbqK7kZ+M=;
 b=VvJR5y24xl4RM94Yp2QkQXvT9Hs3xOMq+UShoVwIUihYGfkrbZTUh1RakphJGFvNShUv72IxF08Kj3nYEwScQZwfj3rYLIkkWAsMdL1MDbyvQNKTrjNe5LUB1thlHSm2z63R7dJKK+SUhz1P7li3KpSWQplL2F9c/dtGRya57SURo/EqixdWkm2J9hFjcDgOG4da2vcfr5PAl90WegASobAwLPsH9XIg77Q1UxbpmETiHq5mXR9PZO3hITlcSjmDhl5TsVa5fMToR+0+miWwoYxZbzB5f3cqk89605Tp4y1kCU6WB+ZyYlLxulakOxXC3+tWwR/dyn3q2WabmXgrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cCjFs/cnXguxLI62/UQoMbSUbARI4kMczvbqK7kZ+M=;
 b=cvPhi1oky0oLn9mr1POhF/QZF/edDG6dwZ/U+QDlVSDCRbBO2SNmKm1UmS4cz1IQgqZb9U1XaXXQX9OhiZSnpUH9XCV5OD+GtH2pUvIJUrZoLfUcISq5vNOyJi46/9w6azv57HtWrbU9TLj59tjpSS1PcgUSEmlkCQpwimfb2kU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.33; Tue, 23 Feb 2021 15:48:02 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 15:48:02 +0000
Date: Tue, 23 Feb 2021 10:47:59 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Stylon Wang <stylon.wang@amd.com>
Subject: Re: [PATCH] drm/amd/display: Enable ASSR in Linux DM
Message-ID: <20210223154759.duhevdipg3pzejtr@outlook.office365.com>
References: <20210223103210.5148-1-stylon.wang@amd.com>
 <20210223141349.xnbsc7mcrq2st3q3@outlook.office365.com>
In-Reply-To: <20210223141349.xnbsc7mcrq2st3q3@outlook.office365.com>
X-Originating-IP: [2607:fea8:56e0:6d60:d0f9:67b4:95b8:c568]
X-ClientProxiedBy: BN9PR03CA0460.namprd03.prod.outlook.com
 (2603:10b6:408:139::15) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:d0f9:67b4:95b8:c568)
 by BN9PR03CA0460.namprd03.prod.outlook.com (2603:10b6:408:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Tue, 23 Feb 2021 15:48:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f965101-c62a-4f17-a037-08d8d81266d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3833C3B938960B722DE418A098809@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+xddexOr+fMp3zhkXRv43Jj9t3FbXdshlxzTCF7yZJmmUbUmEKdwqME6Bp+MDTdHuiNI10xtAC2jU4ekrr+MFLkbyFJYOi/j9n38cEfxNweqDIZS2ZlZctV/30DeCQRZUZrl/QAmoN46btQK/p0WoI6XsFdleJFpTODLUBz4v3XKio9EC0MUsjTtXQSiBqtum4Ti9RW4Ya6sD4QTo2YmHsW8j6+jyiR1J9CEmGRL8gLmjX5iQyrFVGOQRPeGtoO+yzfUTztac8xoDmEDETIT9/giAgS175u6D8fAtXBz7TbnCEqcJ7ukDN5G+OmxW6kTG+/9veOotXqQUF5XOJgtbedd+lE1rLXale6gAclA41IFf0L5o48RbZwtM5LQnFwZI1D36iPRX3Zx+JuVqfmD1S6p6CEANTdWVyvQ4CMYHtyy7X4rFhtPokZjDjAcP3Z3+LNdaJX666R+JEISvmygNex0zwhfG+/kg8EEl1JCcMGnpo31rlI//dfAguhiZuV06VX3gZ84SeDP4MYRVxK8X83f0vaWo/wXI4JHumgySAOrR7oVW0l+2toLR/0E0vBVJMD1bD2dY17aAelGpgv9QEhZT9h2x9wiEfuBCW5m6MP7xuDrdXjXTIjnrp/HaQZKgZcjoB+hOPmGjPMH5cIpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(55016002)(186003)(66556008)(16526019)(52116002)(66946007)(66476007)(5660300002)(6636002)(7696005)(8676002)(316002)(6506007)(83380400001)(1076003)(2906002)(8936002)(44144004)(9686003)(21480400003)(4326008)(86362001)(6862004)(478600001)(966005)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zfqcZiYUgMV/Vbm46yzaRvj6GitR1cND0qTTW00FWIhy/o4PKQZI5TXOzUzI?=
 =?us-ascii?Q?7GI/rE94s4S5MMdayZQebumY0M0EzXavG+0nKt/UQjmZZhPLLk11HpgqIYcr?=
 =?us-ascii?Q?nTltMP5dyq/43u1tStGiaPGydB1r7xKr1wnP6+0laKl/gPPCDFKFeT19TaHg?=
 =?us-ascii?Q?xLp5+eL8BxUEkG08fqKuOKdcRDVx34AuTxtSQG5MPundJMHSacIcI8Y3eK5m?=
 =?us-ascii?Q?HA0NwkYgnIw5Tlfa0c0HgrlEaHLDnL8ybJSqdkMDtzXBdBvi+LS/ibkpJPfY?=
 =?us-ascii?Q?549NYOQaLIsGy9DmSYMKjnKXUOBbndTnE99CYwr/AecHTE5E8FLJtVM22otC?=
 =?us-ascii?Q?0k1tQR1o2zrJLnxHBDM4CwvGsVv4jp3ENXCd0F526wTkW6e9fvQijligisDl?=
 =?us-ascii?Q?KyjE8u3PlURcXRh38S5uB9JmFqEIGZZt66EMqvUCyElqeD+SBb+1sb4n2W5z?=
 =?us-ascii?Q?wBXvUqwh1zQa5nVsfToPUQ51KkUpyQQqnmYLUREAU60ujQjCC+LwGrAbkdRb?=
 =?us-ascii?Q?1lT/jIbbUkGaL3vFVomVhWzrtePc7+kUQObzLEtzd5OJ6cgF9THZD2RDyqUm?=
 =?us-ascii?Q?Evc6cAWqeUS0lGdoRy/A//b/9NhBjF9cCqRqa35YuOcyTgr+BAjV7abZHwM2?=
 =?us-ascii?Q?jstiJTpHQrLwE+etco4Xiy/jEhmQebOsmF4ORjGP1ukQHSjzAzXr7DiHLLg+?=
 =?us-ascii?Q?3mx+WG5+sV8/o2ZpYTaiIvPair7noA861NODae26zDDUmdqAFXpThQ3T0oc2?=
 =?us-ascii?Q?JDBlvc9D2LhlRugft1wAdVdEqz5Txkfsh019cpoorlgrO2IQ7tTKuwn0+8OJ?=
 =?us-ascii?Q?7y5RyQ8joIg7iM7Lsn3PBCCBWVsG0bG8YU4AsD4TI3WfKFrRRBREog5+kLxq?=
 =?us-ascii?Q?poLreWd+hHazJnoCCp5Hl+eseiNsx/+snrbecb8OMVsMTh2CMOgZuWOS+rul?=
 =?us-ascii?Q?DlFUg9XlHxCMAp9kr1H2B7vdIXqxDg5yTQ8he/FYxkRCh56OR9rTufprFyG2?=
 =?us-ascii?Q?dkPO1MtZsIx2W9hs4QS0qmdlZlM367lWrlk8KfTgEnY3OSAZPD3YqU/8pvOv?=
 =?us-ascii?Q?PztxuHeic+gPzi+FO11fiHjqiTUgf3aEkM+9icWjQS4iJWms/wrCHISi51gp?=
 =?us-ascii?Q?LqBLyFSqTiKdcDGzxR+3eyYwODhLcpfrlP/cfbIEaNr4DoY2YSXsjs0l+p1V?=
 =?us-ascii?Q?O+SmuYkqJDiYmnQDKandhv8Ukw937/YxazYIRXMI6FUmM9ZqXbv9YAZsbw2t?=
 =?us-ascii?Q?hl+vn/0ab5qf2sJo03MYGIlafqFA8+5nyM5cBjUyk0enJpz66ftAwX214I5Q?=
 =?us-ascii?Q?gosaaO3obyPpP8ua3socpLxxIIh+W74Xt8MZggvV0qplBeHwguj9zr+/NypH?=
 =?us-ascii?Q?/5GjHiChF5tiU7ssY+mlfZsAW6T7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f965101-c62a-4f17-a037-08d8d81266d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 15:48:02.1717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nY9TVNQzasi788RmYsW4f3kWDe2gpIbFF1ohIl6GVAR5TfTv1j370DvohW8hfw+kTIQo2AqlRRjtR33vUcXdjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0679081296=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0679081296==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6grlc6yiaejgg5v3"
Content-Disposition: inline

--6grlc6yiaejgg5v3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied to amd-staging-drm-next.

Thanks

On 02/23, Rodrigo Siqueira wrote:
> On 02/23, Stylon Wang wrote:
> > ASSR implementation was already in DC and DM guarded by
> > CONFIG_DRM_AMD_DC_HDCP. This patch enables ASSR if display
> > declares such support in DPCD.
> >=20
> > Signed-off-by: Stylon Wang <stylon.wang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers=
/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index c1391bfb7a9b..099f43709060 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -1669,6 +1669,22 @@ bool perform_link_training_with_retries(
> >  			msleep(delay_dp_power_up_in_ms);
> >  		}
> > =20
> > +#ifdef CONFIG_DRM_AMD_DC_HDCP
> > +		if (panel_mode =3D=3D DP_PANEL_MODE_EDP) {
> > +			struct cp_psp *cp_psp =3D &stream->ctx->cp_psp;
> > +
> > +			if (cp_psp && cp_psp->funcs.enable_assr) {
> > +				if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
> > +					/* since eDP implies ASSR on, change panel
> > +					 * mode to disable ASSR
> > +					 */
> > +					panel_mode =3D DP_PANEL_MODE_DEFAULT;
> > +				}
> > +			} else
> > +				panel_mode =3D DP_PANEL_MODE_DEFAULT;
> > +		}
> > +#endif
> > +
> >  		dp_set_panel_mode(link, panel_mode);
> > =20
> >  		if (link->aux_access_disabled) {
> > --=20
> > 2.25.1
> >=20
>=20
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>=20
> --=20
> Rodrigo Siqueira
> https://siqueira.tech



--=20
Rodrigo Siqueira
https://siqueira.tech

--6grlc6yiaejgg5v3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmA1I6sACgkQWJzP/com
vP+6pw/9E36Q2WoIKWUDfbr4RFmXxMugyxoMLXtSnO/Tav71BYwrQU+5WkeNzfnT
Rsp0IGE5yyCaUrUZmMmpgnzJqarN6PiVutQR5g4DXjl1pjOixvJ7MTBRMopTce7h
f+gauHYtZ9gZQ2wySl4wRZg6wyyfy1BHP5wecM94E4dHb8NsuGvmha+vUf2gXWWk
74DWDpMX1v8xGrQwBAxhW4fNA+bIZdzBW014SkYEZklq+wM+pfBES4ZYrVrARTB8
rlkA/y2dBiXQgd74/CPw1gPjcGlzoVa8m33yF61LuPyeHG1hHK1Ash94XXXJHFqK
m4axHzM7pNSCQ+3C0PIhxyJliVE87fbky9TSw0rJPyGGqJHmXNLzyMatj/JAvlfk
V9E/hPtKwSDzYC32z4nR9x/x4M1ZWpcE6KlSycW1qKoeZK8t+NThQFJNF9JmsEf4
hnd/W/HEhSesJ1Pc5wfpeC/v8w7hJJTXbd/T0W9zgRaoVn0f2mePwZRjvK2hHva9
m0IxYB68aLh7NvS13K4oee5oFFJuJjtvGXep5GrnIfPWnJtDBxq5W+wU2s5xiKn7
0ClF5Nqfnvj+7uThdKO7jOQ7CvZ0li2brpwaEreXYoFxfCSeagvlhAXmCtW9Przi
76p5WxE7pNCejWS4KXLGoIs6UG1+DeiVg+SEFz+uJhWrEklN6cM=
=n6rP
-----END PGP SIGNATURE-----

--6grlc6yiaejgg5v3--

--===============0679081296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0679081296==--
