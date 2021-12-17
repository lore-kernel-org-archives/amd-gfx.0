Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D913C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6810D10E5B9;
	Fri, 17 Dec 2021 21:36:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2969710E5B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoohOnndJhQ5IBv3HUve1sJ0iRwSocymdRt6jUAsDYdtAHD261dX9h3dV7yRwx+XPsWsIQWO3xCt5svKix6WYQByEYow5Edq+JCT5KYY9teFjX5Gy+Pm3ta3exZcbY2TbIZKYIV8101vKAgxcf+hHEb8DWQe7rl0Wx1qbsIXm2ruO52dlXLW+7wtsCZuYwZW3dyC0D098M3Gix3oGZLXyS5H/cemeqV1oVlal9jnsPej2lQo3Y7EsOaeY5graEItWuuoe9xT2v2p6QuS+6FTuugli8zo9Nt8UPgxAHOQrLRp33GV6TAqunfTTN2m32LKJA1+2ChKGWuPcuPbpKIWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3CRYdXF6LnBsQav9Hl0kXfHknd7wD+5cMuexhEp29E=;
 b=TV8AVi+HzWjtDPh5Ms/BQSjNfl5H10NiLudOcm5l4AsbU62jU0S1UaJoFAGWZDZS8tDFI4BBYSiCa6QKibvspgsVL/6XZUNsutrhWz2JfjURfP6npTCjW53LxGJt+zbQHDPSuyRs3H58z86Q1WOoSPnugjx77uBjhTxLjjInbRkbdzyY6nGbs1Wz3QPuwt5pGgSz/TPgOendZbUYr1JaV6xDQLnbfE6ZDMalQDESSHIciMOFR7NznK/RBrYMOxoyiSaRUg00TaCflYcIDjbO3pfi2KS45tuYYErpCsyCl6o1wjAg1Iz0Hzg3/+wTK8lnPCOQQf4YUoZB0qS/VW4Qng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3CRYdXF6LnBsQav9Hl0kXfHknd7wD+5cMuexhEp29E=;
 b=JIcb82SBDzKEnIxXo9aOYjMr0nBAHk/uqqiz3wolpIpgYwanyCLsigeJCkjIdAuyzs95wMsKri8n2hMz8Y3+WQAKY0jmgNcQ5qodmN4EaqE0ppAQIInmvCCpRNvn9Y9wTkhFGk4dvqz2Hapiahdn0ID2uVuu2AAFss/eLCfGMoA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 21:36:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%9]) with mapi id 15.20.4801.014; Fri, 17 Dec 2021
 21:36:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 10/19] drm/amd/display: Changed pipe split policy to allow
 for multi-display pipe split
Thread-Topic: [PATCH 10/19] drm/amd/display: Changed pipe split policy to
 allow for multi-display pipe split
Thread-Index: AQHX84yHqOL2Qa95/USeUmrDtvkPlqw3M+tE
Date: Fri, 17 Dec 2021 21:36:15 +0000
Message-ID: <BL1PR12MB5144269CBE04ED1053012CEBF7789@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
 <20211217212407.3583190-11-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20211217212407.3583190-11-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T21:36:15.098Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 4d96c1e6-d72b-8f93-ace1-897695d9fbb2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf94347d-e754-406b-bad8-08d9c1a54149
x-ms-traffictypediagnostic: BL1PR12MB5318:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5318AD15690A5F24B837E43FF7789@BL1PR12MB5318.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqlKTC/ESTD/hTbcExTjiw/4gRKG4lO88uFIMm3JMwlkxrTDMWUD5pe37TcWrYs1hmf5r4BuaMcX7ws5OyXprzNUDhwuDEcgvRC8f0/YBLPeGdhpU2ep5tcQ67GIbRX4CV60Z9B0gH51xsxoBpT1Vjvjkcr/0+JEF1HB6u1rjnNnlblTYchTmtBkMAdVoGYfOXjikiUTBGmNFPWWICfqVkXOucdVkMdNPS6TGuopdCTEYDHfQq7qCscNoqMpiwAmEz7pal+atf+lBv/TBj4xFRFBbyqBaQ7BixRW8XYTYJ5oSgHzCpCngv6fIUC4Y2EaGk+L/km6vZZhnpYtuT7gScfHeBJ3/rhS5+jUIL4Ol4WIeI5npYIKWN44vVoF+cjZNyl9bwr+Si00e1lYKWIEfpM7mJaUSJSzp1xmxx7yElrESqhXs41+9+5aWCWJSDcSrmQa/oQWvGlPJD0eYDgRGSgf9fV6DhXwhskJQ/2gWBbleQ74GtaqaGMGx6CyrHrdjYgR9eTSpRknC2nIrACZQ+Q/4xhBdlpux9+lYeZrir/gq/9Y3if+OhUNFJ/5cBstiWyqPgvAfxGQ9UoWpsfadUsR+7iF8d9Nyoxtr0U6nzTZNzVZS+he37pAwRQ87kLpf6PFQdRRoJWgX6BHwsxPdKXEu2YXj+LufSTNDQGtTGtF+8y4Kb/44XyUo4PdfwKj6OlIkpOSQU9TqyBBa4ShcmgnJ6waRem+gdf0YyKoj7k2+7R+tY5ZCVBHvWfo1OvC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(71200400001)(54906003)(110136005)(5660300002)(186003)(966005)(316002)(64756008)(76116006)(122000001)(4326008)(52536014)(66556008)(38100700002)(66446008)(66476007)(66946007)(38070700005)(9686003)(7696005)(8676002)(19627235002)(19627405001)(6506007)(83380400001)(55016003)(33656002)(86362001)(8936002)(26005)(53546011)(2906002)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i6jcwrV9xEIXaHIrFajZMIO32Dc/tmNEKmN+yH210WBkJz773SEYAgXJbD0g?=
 =?us-ascii?Q?+nSNemXcPhRtSSLT7gACdYxWzgNK7UVdkG8AUFd6zXedooJE6yxhqbGSyl2s?=
 =?us-ascii?Q?50JX3VSfae3e5FdbP+snTGj+fuvppgPQTlw8asuNQI3LLuSbhMbu0KmmiNp1?=
 =?us-ascii?Q?DZ5VYFFAELTpruVyAfE2QnMUjrwigYPJtBVBXcaMnzRwh8atjYYv/JIbm4br?=
 =?us-ascii?Q?z7MTVHrZC1n9VC+oRVqS5GBWDACjpY4F5GAXHX/iW3HNvwk0liMXq4ePg106?=
 =?us-ascii?Q?rH62FBfOaspk+8UF0sPIxaRhYbJbAzrKigy1jaoJ48KvFNlVH7wm5ICCCMd+?=
 =?us-ascii?Q?3eeyNJXbSc7jYVNkuxQsuMDTuq00HVFb5QKJVhTDNhlSXexnXt7XiYjlF3xe?=
 =?us-ascii?Q?Ii+5mah/7xfJIyyi1cbVuLTp1NNMYUk7aVLNns+xw/brjNd3UQ3q4tWShsvd?=
 =?us-ascii?Q?pTvw05aonUeYSyY67L2PqVIKRIecpTdTR/8Ihr3ouD2E9+Aw2vVgpQyXUTN7?=
 =?us-ascii?Q?ZdSzAA/A094UgwTTJr5C5V627dDXPL8e1cOUU1RDOuX84P5P8IOOfBbO3Pbw?=
 =?us-ascii?Q?aNFQ3kxGTbskV7Ath3QukeqW4pRFvsWINmhqC0wrVfONZ/UhiG9usJaa7+Zc?=
 =?us-ascii?Q?mWhSk891vtqNFCPbWatDMJ/3UnJH0Kg5CyAOj1XTMCHAX5+ikQ/7w5V8m2qm?=
 =?us-ascii?Q?zeQlrnvIopU4ahEZvlxf17drbHIemFWwzEXsPHuMXCili++PV/iKULWa36FL?=
 =?us-ascii?Q?mmQT2xEohrXrdpuaIGxpUXF0Mlf/g3M5aaPp4RQz/VHXHSjoSp+zr8NDI3PH?=
 =?us-ascii?Q?4gGUMK9vMwEfIUOwExYTFMKq4rbNwimKCVI7KoXDmkngHh4HbRJGySSTk29L?=
 =?us-ascii?Q?KEd3TmB8nhgXi3R8kB+sFuzRwlQ9H3I40ogLQPb9JRXv8jyu4wUU9FICzMal?=
 =?us-ascii?Q?mboUTRr5uaDkdB+ydURPiiEdqi7IuiU2VDKj29TUewdpCdqUUWhkrloNEgho?=
 =?us-ascii?Q?/ar7PDBH+zSJ7yfCUEHhlfSs9Exw7gNpRRNZ2EM7YNSsMz4GmfTm4Vyh5mm5?=
 =?us-ascii?Q?UUAsY+IkjxRxk1lMCUB7jdDT4BS3+UO5jn44Fqg9Uz1yCSpuZtXYclZQo6s5?=
 =?us-ascii?Q?3XHQIsDj4OMo1d7eo0GDbKmRsKdUUT4DcFpLT3PDlO8kXF1iS00pY3Ek0hdo?=
 =?us-ascii?Q?iLGEtwWfOeyENy9EzSxnx/IshqEnDc85ZaJEZLoe4VFoeu1z/9+HdpqCP6EX?=
 =?us-ascii?Q?t7/1s3+E2EW03ypho/BMm3FFIPkZL2UlRVrIrBTxn4ioJpnrBXEvmtX+25Ae?=
 =?us-ascii?Q?HIbryw7GiGsG8w2NjVyqf62Dc3sWiJ6omn7IjGriyxM8lwZHMmqf0RL+r5CH?=
 =?us-ascii?Q?H3slq0mQKhrtb6x6qNC7oIeVt2rkTssW3GwHCxEJom+60yt0UpqOgyNYxxRM?=
 =?us-ascii?Q?C/+iT4ny74t9QT6oxf6Mm6Wv7FL5DcLCxqO7ImlpIRlkJczNsofTMePABhT8?=
 =?us-ascii?Q?l6ubtlPUkdLDzQ43LzDkZhRJW8Sl64l+AU7JMQLXf/tJO+9ofs4MeAcbDVqg?=
 =?us-ascii?Q?bUYXgrtauM/YHM7SuMBYQ8SRYphwJH40F5aUz4512Xmjwr7A+Kw1oSyua1aa?=
 =?us-ascii?Q?/QocJpgeugobn3UX0FER+xk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144269CBE04ED1053012CEBF7789BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf94347d-e754-406b-bad8-08d9c1a54149
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 21:36:15.7501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +F3b76t6qepHGtd8tgCe3zadsUO1h8w0vx2ic0Ly+uJ8RI3W0lgw6ri1Zzu//jHl1niyTPJT9R2vYRC6n4BXkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Cyr,
 Aric" <Aric.Cyr@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wang, Angus" <Angus.Wang@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lipski, Mikita" <Mikita.Lipski@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144269CBE04ED1053012CEBF7789BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Maybe add Bug links for:
https://gitlab.freedesktop.org/drm/amd/-/issues/1522
https://gitlab.freedesktop.org/drm/amd/-/issues/1709
https://gitlab.freedesktop.org/drm/amd/-/issues/1655
https://gitlab.freedesktop.org/drm/amd/-/issues/1403




________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Rodrigo =
Siqueira <Rodrigo.Siqueira@amd.com>
Sent: Friday, December 17, 2021 4:23 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Cyr, Aric <Aric.Cyr@amd.=
com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentl=
and@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, R=
odrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solo=
mon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; W=
ang, Angus <Angus.Wang@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, Mi=
kita <Mikita.Lipski@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com=
>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Ko=
tarac@amd.com>
Subject: [PATCH 10/19] drm/amd/display: Changed pipe split policy to allow =
for multi-display pipe split

From: Angus Wang <angus.wang@amd.com>

[WHY]
Current implementation of pipe split policy prevents pipe split with
multiple displays connected, which caused the MCLK speed to be stuck at
max

[HOW]
Changed the pipe split policies so that pipe split is allowed for
multi-display configurations

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Angus Wang <angus.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2a72517e2b28..2bc93df023ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1069,7 +1069,7 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
                 .timing_trace =3D false,
                 .clock_trace =3D true,
                 .disable_pplib_clock_request =3D true,
-               .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,
+               .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
                 .force_single_disp_pipe_split =3D false,
                 .disable_dcc =3D DCC_ENABLE,
                 .vsr_support =3D true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index d6acf9a8590a..0bb7d3dd53fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -603,7 +603,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
                 .timing_trace =3D false,
                 .clock_trace =3D true,
                 .disable_pplib_clock_request =3D true,
-               .pipe_split_policy =3D MPC_SPLIT_AVOID,
+               .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
                 .force_single_disp_pipe_split =3D false,
                 .disable_dcc =3D DCC_ENABLE,
                 .vsr_support =3D true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index ca1bbc942fd4..e5cc6bf45743 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -873,7 +873,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
                 .clock_trace =3D true,
                 .disable_pplib_clock_request =3D true,
                 .min_disp_clk_khz =3D 100000,
-               .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,
+               .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
                 .force_single_disp_pipe_split =3D false,
                 .disable_dcc =3D DCC_ENABLE,
                 .vsr_support =3D true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 369ceeeddc7e..e12660c609ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -840,7 +840,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
         .timing_trace =3D false,
         .clock_trace =3D true,
         .disable_pplib_clock_request =3D true,
-       .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,
+       .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
         .force_single_disp_pipe_split =3D false,
         .disable_dcc =3D DCC_ENABLE,
         .vsr_support =3D true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index b4001233867c..c1c6e602b06c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -686,7 +686,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
         .disable_clock_gate =3D true,
         .disable_pplib_clock_request =3D true,
         .disable_pplib_wm_range =3D true,
-       .pipe_split_policy =3D MPC_SPLIT_AVOID,
+       .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
         .force_single_disp_pipe_split =3D false,
         .disable_dcc =3D DCC_ENABLE,
         .vsr_support =3D true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 003e95368672..2e9cbfa7663b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -211,7 +211,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
                 .timing_trace =3D false,
                 .clock_trace =3D true,
                 .disable_pplib_clock_request =3D true,
-               .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,
+               .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
                 .force_single_disp_pipe_split =3D false,
                 .disable_dcc =3D DCC_ENABLE,
                 .vsr_support =3D true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 01ba9d656c72..2de687f64cf6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -193,7 +193,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
                 .timing_trace =3D false,
                 .clock_trace =3D true,
                 .disable_pplib_clock_request =3D true,
-               .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,
+               .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
                 .force_single_disp_pipe_split =3D false,
                 .disable_dcc =3D DCC_ENABLE,
                 .vsr_support =3D true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6d07dcecc953..7c64317a56f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1003,7 +1003,7 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
         .timing_trace =3D false,
         .clock_trace =3D true,
         .disable_pplib_clock_request =3D false,
-       .pipe_split_policy =3D MPC_SPLIT_AVOID,
+       .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
         .force_single_disp_pipe_split =3D false,
         .disable_dcc =3D DCC_ENABLE,
         .vsr_support =3D true,
--
2.25.1


--_000_BL1PR12MB5144269CBE04ED1053012CEBF7789BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Maybe add Bug links for:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1522" id=3D"LPNo=
LPOWALinkPreview">https://gitlab.freedesktop.org/drm/amd/-/issues/1522</a><=
/div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<div><a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1709" id=3D=
"LPNoLPOWALinkPreview_1">https://gitlab.freedesktop.org/drm/amd/-/issues/17=
09</a></div>
<div><a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1655" id=3D=
"LPNoLPOWALinkPreview_2">https://gitlab.freedesktop.org/drm/amd/-/issues/16=
55</a><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview_2 _EReadonl=
y_1"><a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1403" id=3D=
"LPNoLPOWALinkPreview_3">https://gitlab.freedesktop.org/drm/amd/-/issues/14=
03</a></div>
<br>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview_3 _EReadonl=
y_1"></div>
<br>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview_1 _EReadonl=
y_1"></div>
<br>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Rodrigo Siqueira &lt;Rodrigo.=
Siqueira@amd.com&gt;<br>
<b>Sent:</b> Friday, December 17, 2021 4:23 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Cyr, Aric &=
lt;Aric.Cyr@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wen=
tland, Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, Qingqing (Lillian) &lt;Q=
ingqing.Zhuo@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt=
;;
 Li, Roman &lt;Roman.Li@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com=
&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Wang, Angus &lt;A=
ngus.Wang@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Lipski, Mikita=
 &lt;Mikita.Lipski@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@am=
d.com&gt;;
 Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;P=
avle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> [PATCH 10/19] drm/amd/display: Changed pipe split policy to=
 allow for multi-display pipe split</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Angus Wang &lt;angus.wang@amd.com&gt;<br>
<br>
[WHY]<br>
Current implementation of pipe split policy prevents pipe split with<br>
multiple displays connected, which caused the MCLK speed to be stuck at<br>
max<br>
<br>
[HOW]<br>
Changed the pipe split policies so that pipe split is allowed for<br>
multi-display configurations<br>
<br>
Reviewed-by: Aric Cyr &lt;Aric.Cyr@amd.com&gt;<br>
Acked-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
Signed-off-by: Angus Wang &lt;angus.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c&nbsp;&nbsp; | 2=
 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c&nbsp;&nbsp; | 2=
 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c&nbsp;&nbsp; | 2=
 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c&nbsp;&nbsp; | 2=
 +-<br>
&nbsp;8 files changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
index 2a72517e2b28..2bc93df023ad 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c<br>
@@ -1069,7 +1069,7 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .timing_trace =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .clock_trace =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_pplib_clock_request =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .force_single_disp_pipe_split =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .vsr_support =3D true,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c<br>
index d6acf9a8590a..0bb7d3dd53fa 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c<br>
@@ -603,7 +603,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .timing_trace =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .clock_trace =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_pplib_clock_request =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOID,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .force_single_disp_pipe_split =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .vsr_support =3D true,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c<br>
index ca1bbc942fd4..e5cc6bf45743 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c<br>
@@ -873,7 +873,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .clock_trace =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_pplib_clock_request =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .min_disp_clk_khz =3D 100000,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .force_single_disp_pipe_split =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .vsr_support =3D true,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
index 369ceeeddc7e..e12660c609ee 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
@@ -840,7 +840,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .timing_trace =3D false,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .clock_trace =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_pplib_clock_reque=
st =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOI=
D_MULT_DISP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_DYNA=
MIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_single_disp_pipe_sp=
lit =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABL=
E,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vsr_support =3D true,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
index b4001233867c..c1c6e602b06c 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
@@ -686,7 +686,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_clock_gate =3D tr=
ue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_pplib_clock_reque=
st =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_pplib_wm_range =
=3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOI=
D,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_DYNA=
MIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_single_disp_pipe_sp=
lit =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABL=
E,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vsr_support =3D true,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
index 003e95368672..2e9cbfa7663b 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
@@ -211,7 +211,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .timing_trace =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .clock_trace =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_pplib_clock_request =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .force_single_disp_pipe_split =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .vsr_support =3D true,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
index 01ba9d656c72..2de687f64cf6 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
@@ -193,7 +193,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .timing_trace =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .clock_trace =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_pplib_clock_request =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOID_MULT_DISP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .force_single_disp_pipe_split =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABLE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .vsr_support =3D true,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c<br>
index 6d07dcecc953..7c64317a56f7 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c<br>
@@ -1003,7 +1003,7 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .timing_trace =3D false,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .clock_trace =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_pplib_clock_reque=
st =3D false,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_AVOI=
D,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pipe_split_policy =3D MPC_SPLIT_DYNA=
MIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_single_disp_pipe_sp=
lit =3D false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_dcc =3D DCC_ENABL=
E,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vsr_support =3D true,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144269CBE04ED1053012CEBF7789BL1PR12MB5144namp_--
