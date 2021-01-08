Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 22:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F02F207C5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 22:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F02F207C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4BF6E83C;
	Fri,  8 Jan 2021 22:12:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12AD96E83C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 22:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtBvnI5RbKo97Y/OgwOap1mOSa+p3z7VtmjE4zzqqiE7lT2kO1tcaXn5NPwvbnhxCS00PnZxQYqmKz4DR7+nuBpSvE7JRY0NX0plFff263jUaZhkGjChaCPWA6Hom0q7qJnAdI0XHAukaFpKa4QJqY6eqLIkz+4W9zX53xhc+rnwqevu+yI9YplF07x93rppPRaaiqB9nY7LSYDkWSZ0JCTDQ9SnOsYKng8P4nVYNK+HTsbBSofsq6KsAhIpTvElVGIakbUlNvvEQjdEtJjn+Icy/ad+BjqS283tvDJhcv57TRg0afdEhtO2/vwvCG6K5CLBtmiHcUBB+N4fd2URJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7HrKTxSBZfjL/bY618i4qlkvtglSgq/oR0pNor+YdU=;
 b=FMo2h0X5NBBCztAtXcTUONLyFJC+Y/uHrKwesUzw1u7pPraOKYWh06KfFYl46yAuMX+93pGxOVHm7ByOYv+QwALXSVYhc7Sg/+oLHdxnS4jFDiFX2Ka1OTM3iDvhz/RCU7x2bwZBPXh3eKGP7R2DqPHVzKdCaUE0KqThTR9EBCD4pe/3ZP80KyRiJs9KLdUBOQuSwicjD89T+pKPJlu7v13+y+z2hevBU1YVbESlyd/VVngyU3VHe4pJt6eRFD4fGjOL/s7ba2B2w37TOb86DLzIrxn63v10K2FBC8SCIXWhXJzrR7u/RSp4Xhay7k5ivcDI2ieMOOB0c90N219bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7HrKTxSBZfjL/bY618i4qlkvtglSgq/oR0pNor+YdU=;
 b=FBI+BKYUsAlge9GG29aE8JBsTegy5uZA3QM5AL3hyobNa6l1ankotUkBm+gmbeQz2ftDJuLyWioJJKA4wXzLpKJaZ8EIdURFpu4IUS7rbaNx/5WzQGslaovmoCl5OwywEgF44FlzYIQsp8vYSgIJxO/DKagNJVq8bPp8RR7005o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM6PR12MB3113.namprd12.prod.outlook.com (2603:10b6:5:11b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 22:12:11 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 22:12:11 +0000
Date: Fri, 8 Jan 2021 17:12:07 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 00/21] DC Patches January 08, 2021
Message-ID: <20210108221207.i5olrzm2ip4bdbbn@outlook.office365.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR1401CA0019.namprd14.prod.outlook.com
 (2603:10b6:405:4b::29) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR1401CA0019.namprd14.prod.outlook.com (2603:10b6:405:4b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 22:12:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 476eaf80-ed49-4b8e-4288-08d8b422727a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3113:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31134D27281D237144AE35A498AE0@DM6PR12MB3113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pW542dDZa/tEuams2Q2xsEaAf1EHucma96aVV+RJKOcp/72gJAqHECazgo00azpz7hdWzKPbWDVU6TO1kLEpcnBrJwQ4j9Mkvg2qK0mtMx4GGOY3/OjCPVr3KG11XJL2rBnMc0per3yz8V6rTc3vynlkOFmrc2Y63TJKFGU41tOW+jFHcqBhrlkJ83LftOOPltTve6n//MckWdkkKLcS8p7uethWnBmTyl8O/6nmC+mnbs3h00J1ITyt4oUe3GxrZjXU/CFTes+wBWMcfPwAnGQSMI9vuuoOVvcoMw4MfveUcP2PBVpaCbzdrIQ6P/t7qoHnJ/GMsO8ErmXUys0haHdil0y+B8rd5WkbltYKCzt02R+tPul1rD4BUtX0CHHK+bLIXKuxJ03Ce8+R9+S5IXXV72ixYQh8djO6JSd+QCwMDmH55qscHDFws6lmCAWNutoo0oxqwU6YqH2PiCvOxMdPLdJncb7Qr3ShWBJg2ZCvt8aZEjGVOhsCrX8d6bMrmffh8Bha+9BobwA2USog+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(186003)(16526019)(7696005)(52116002)(6506007)(44144004)(1076003)(5660300002)(9686003)(21480400003)(83380400001)(8936002)(55016002)(86362001)(966005)(2906002)(66556008)(66946007)(66476007)(478600001)(316002)(4326008)(6916009)(6666004)(8676002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wWJeHCGpSIkDOeNKMEWP5l4xdZzrS/NVcfBSanZdl4ME/MShnjSNgwULEOBf?=
 =?us-ascii?Q?aQsqRpv/yWA9gvfascuwSqlcCH58LFKKt38X7wIiybUS1sBArFsLQpwfwZyr?=
 =?us-ascii?Q?Gy6hwhiQFvOCsnnX8q6aW4ZyHEKDpsH80PVwj+b+s8CwTBhBFwW/syaTKf7L?=
 =?us-ascii?Q?GQu6DsVvClJzpDfAViE4eCvoUliFAg2jhy9xCDiPkyi/eb5K9bqh+EuM62NV?=
 =?us-ascii?Q?8TSKk0k4Ok3kA9sBt6+yEWMVyVZHd5xXV5bILjUMQKRY1h+bcdZU8sKmfPes?=
 =?us-ascii?Q?hLaw3vZaOjSZXj2MkCx0nqfa7gsZ0JwmujvAsQIBrcA4cO19eYBemUYY5dzc?=
 =?us-ascii?Q?VGSMSANCKV6JMaCJOxaThWKAGLepN5Yx3ZOphBf0YUIZvxE82jKCxyDhTEDO?=
 =?us-ascii?Q?eeUh6IkqYJ3oAArU2s2Y34PCnj1c1CZATiP8tEpKL1cSPmqXaIXcALpbJ9ec?=
 =?us-ascii?Q?/r3AWDaRZ3kJUkIzkbmTk594IMSmy59XGUoMh7dKTnUxNuwHNsy1XHat2VJd?=
 =?us-ascii?Q?iv/VK0x2pzAqa6PLsjt/NnstFrsIGzyZC2Z0n54Mx4/bKe9Jeyo2y1MgMvqj?=
 =?us-ascii?Q?Iz75wj+0cEHwOU138PlrgDhlTdwt5doxpsFcIKeQd185MvRIx1OvNv3s2qFg?=
 =?us-ascii?Q?3M6LAUnnYPssL67Y5WsP+vw0qbC8CEkH3ihXP++PBOdvg+jrtHEWYdCx+5Ne?=
 =?us-ascii?Q?2kXhFfkWvnsy3bhQdsR9tBcyRrOVfXnBZ63oDfLCCG0WdPJLnQi4PG0NTrRI?=
 =?us-ascii?Q?lUezuxV28+2zrreM2r3N2lhqxqB9eIyETLbCEguXcAYZvLHislz8wCciVZXv?=
 =?us-ascii?Q?QDJb0KLb5YyOjo+Tko4AqscQQhTvHJknz6BFox2UrK7lvsFVEoioc130vUmz?=
 =?us-ascii?Q?CZeVpGB4DsllUcp3OCj51tMhXMHQ11tr1DkTV2aeigiChX/NsfbzRWat4AiQ?=
 =?us-ascii?Q?bwpIkDbkHuTQTmASfNmK560t8Ytd8oLmXlI5hlEnPBXfnHDPazfZgM/cX3qs?=
 =?us-ascii?Q?ACJ9Ya8ZQffL30JFYy41XCYAM4X9y73VHC1IoHFCFXoqtxk3xTokdW7YJ7eY?=
 =?us-ascii?Q?W38LNiZr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 22:12:11.4198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 476eaf80-ed49-4b8e-4288-08d8b422727a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0khetlsmxRhusAt2WlYicgjB+hHTpH5LD94Q8UzocseVAfgY+4+JLzr8dDshrwYjvkrjdyor1Cg7b9y89tX/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3113
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, roman.li@amd.com, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: multipart/mixed; boundary="===============0342696980=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0342696980==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="br5h6lgo3z6lvvxz"
Content-Disposition: inline

--br5h6lgo3z6lvvxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+Daniel

On 01/08, Rodrigo Siqueira wrote:
> Happy new year, this is the first code promotion of the year; for this
> reason, most of the changes are related to fixes.
>=20
> This DC patchset brings improvements in multiple areas. In summary, we ha=
ve:
> * Multiple fixes and code refactoring.
> * Updates on HUBP operations
>=20
> Best Regards
>=20
> Aric Cyr (2):
>   drm/amd/display: 3.2.117
>   drm/amd/display: 3.2.118
>=20
> Bhawanpreet Lakha (1):
>   drm/amd/display: enable HUBP blank behaviour
>=20
> Charlene Liu (1):
>   drm/amd/display: change SMU repsonse timeout to 2s
>=20
> Chiawen Huang (1):
>   drm/amd/display: removed unnecessary check when dpp clock increasing
>=20
> Jacky Liao (1):
>   drm/amd/display: Fix assert being hit with GAMCOR memory shut down
>=20
> Jun Lei (1):
>   drm/amd/display: implement T12 compliance
>=20
> Lewis Huang (1):
>   drm/amd/display: Separate fec debug flag and monitor patch
>=20
> Li, Roman (1):
>   drm/amd/display: disable dcn10 pipe split by default
>=20
> Mike Hsieh (1):
>   drm/amd/display: Remove unused P010 debug flag
>=20
> Nikola Cornij (1):
>   drm/amd/display: Add a missing DCN3.01 API mapping
>=20
> Qingqing Zhuo (1):
>   drm/amd/display: NULL pointer hang
>=20
> Raymond Yang (1):
>   drm/amd/display: fix seamless boot stream adding algorithm
>=20
> Stylon Wang (1):
>   drm/amd/display: Revert patch causing black screen
>=20
> Wesley Chalmers (6):
>   drm/amd/display: Initialize stack variable
>   drm/amd/display: HUBP_IN_BLANK for DCN30
>   drm/amd/display: Remove HUBP_DISABLE from default
>   drm/amd/display: Unblank hubp based on plane visibility
>   drm/amd/display: New path for enabling DPG
>   drm/amd/display: New sequence for HUBP blank
>=20
> Yu-ting Shen (1):
>   drm/amd/display: doesn't reprogram AMD OUI
>=20
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 -
>  .../gpu/drm/amd/display/dc/basics/dc_common.c | 20 ++++--
>  .../gpu/drm/amd/display/dc/basics/dc_common.h |  4 +-
>  .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  3 +-
>  .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 12 ++++
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 31 ++++++--
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 49 +++++++++----
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 28 +++++---
>  drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  3 +
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |  8 +++
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    | 11 +++
>  .../display/dc/dce110/dce110_hw_sequencer.c   | 31 ++++++++
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  2 +-
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 ++++++++--
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  5 ++
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |  2 +-
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 11 +++
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  1 +
>  .../drm/amd/display/dc/dcn10/dcn10_resource.c |  4 +-
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h | 22 ++++--
>  .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 12 +++-
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
>  .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
>  .../drm/amd/display/dc/dcn30/dcn30_dpp_cm.c   |  7 --
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |  1 +
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 70 ++++++++++++++++++-
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 ++
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
>  .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 +
>  .../amd/display/dc/dcn301/dcn301_resource.c   |  1 +
>  .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
>  .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
>  .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 ++
>  38 files changed, 332 insertions(+), 68 deletions(-)
>=20
> --=20
> 2.25.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--br5h6lgo3z6lvvxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/42LIACgkQWJzP/com
vP8sMQ/+IZViK4shpfVJuay8gQYFkk247K8k4cmrvDNBD9wP//ubEx5U34gxCSN/
L1sg8k28smIt9NokYmThPKL6IHUmQ8mbtIAL8P23hy44JPTOFAilShh7/n/lQ35y
XPQaOP3Wv+/H1qz71rygVJzbSA6tLhU7np02NplOWC2zSwZoBt/yr56cu3HH9lep
erGi/TPZ+z7UrM0Jjw6zfUcPdjwlO/8BXGQL0s6xQAfQz+Gvt4CfkMsXz5YzFB7V
ox+fYAbOiYIi/9RdLGfKXQN3qBnfKfz/ompxHgbk3x6j5gdIUvzEKKZdB/3/ny7m
r3AzHwr7aAS8z7NWLV/PBDoHMeR4LdsrqkLpWmVqiJLncl7ZUzYY6VFrq8JnN2w3
xIP8YtB0B89CFKMbuSG6YtftWPtKSm6wU23x5adlTl5P8vsVd74P53hfonVpN+rj
fTPAoaNuedbtVt/zqp32k7lSVwnPnkjfmZQ+Pqo38hJgO1BXnSxxSUI6oeqRxLwq
VsYvqde3KIqb0P090b0euWt0gyUsH8/KgCin3YqSLWh/JIhOpNmiE19dscG2CQdi
ml6IuaOEHnJPPaXdI8eY+/ciMcFMX413eIwht5N+Po4ukThD9yAGYWtM6WgIf9H/
e+eZil8lLQaaxCXmsLoIzn0O6Sp+As/08+e+4VTxPM+ku6Xt7So=
=xP9b
-----END PGP SIGNATURE-----

--br5h6lgo3z6lvvxz--

--===============0342696980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0342696980==--
