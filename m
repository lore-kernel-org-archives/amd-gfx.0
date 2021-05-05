Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E288C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F7061078
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 13:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F7061078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DF46E48D;
	Wed,  5 May 2021 13:06:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273F56E48D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 13:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLcswcCHwbLQuE499XzYL/1OtkFQruFbBrWyEvM4+Mx2T8JY64gXk621KIzarqljg1Bazs5lBenS/rg+SKCEaVpS/7FeLHzyMPpWzMG4aL//xk+QSm/g1KoF6k4eLx8FUN5uEzgAEumJNkQ6SX5Wci8YE4yB0z1vDG8D12U/fPfcW7hJsdKBDs41T9cnPT2PHhJ9BqyGqmAOgoDvtdBTdNujHuDe1eDuUOHYRp2jqEp4X89psNQumEoksVh1Z8g77+sipBWXgORK4Xsv5n4oEvTzbVq7xsDwtemUgjIn9iAcKOuYc+m20R1yMYaURh5+fxv88P0P1P3Q8VY5hLTjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe7H1blYLKzQoncFq52AIzQ3014wUFHqxhXGa3N5Qj0=;
 b=Hph6tHrZ5r5UrfafDAe6Aln1fLq6ov7uP+UVsGDgl1ZUPoSdHzucorr2+vn8s1jy9LM7nsZdiXCQ43TpulqZjcd+lrziZBIBi6xWlubz6RKoYsLnx7Q3XuJibz2SNfK7rNMmGl0zdWTaviUcjB+bCd5hq4/B+uVapzWOJWOtllgNxb5SeO57DS9PJmW+CfEjSwU9QQde3JoQxiiD4mmSCBlnKCRi6FKsEcFmTdtvyIIaoiqQFqDu2R2NcFrhU884+AUeHNQwOrKA7nGwPMsqqNoNuxR6m9lBwPm+2cprpCg8L9ysr8XqqonWvc+B1r1+kww45QQSX7z6HgBjXMC3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe7H1blYLKzQoncFq52AIzQ3014wUFHqxhXGa3N5Qj0=;
 b=05qH22wDeVQh5DzmLC5E6Etn2ctMwPnsknCr8Sfe51PSqhsuzYlVlNAzfdPNp/19+AF+L9ftP/9T1dACtthY/qZxszW8U3gOlOtWHyl/R0vUgxLBtW7pWNQfljRXS83tN8CQK4qQpb3W+kMDR5tgeQzmB7Dde8LoWk1wa1fBGJ8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3824.namprd12.prod.outlook.com (2603:10b6:208:16a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 13:06:50 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 13:06:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE"
Thread-Topic: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element array
 with flexible-array in struct SISLANDS_SMC_SWSTATE"
Thread-Index: AQHXQRVMyJIBApc7kky86f91KKcNlarT634AgADxHsA=
Date: Wed, 5 May 2021 13:06:50 +0000
Message-ID: <MN2PR12MB44886A5959AA52DF5D3EDF7BF7599@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210504184233.2350976-1-alexander.deucher@amd.com>
 <15cc0988-0446-5423-62d7-051ccaf2936e@embeddedor.com>
In-Reply-To: <15cc0988-0446-5423-62d7-051ccaf2936e@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-05T13:06:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=db88210b-f3db-4563-ad2d-0e48dc6c79db;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: embeddedor.com; dkim=none (message not signed)
 header.d=none;embeddedor.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28d3aa0a-3309-468c-dba8-08d90fc6a5bf
x-ms-traffictypediagnostic: MN2PR12MB3824:
x-microsoft-antispam-prvs: <MN2PR12MB3824FBA60AF2D62FDF81B98EF7599@MN2PR12MB3824.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bgVqQcT0O3tF2wl5lakL1TPJUPrE7yBRYQq7fdhP+tCEdNMk4/0vfMoE2Xbs6SOaP6UqEZRaowKSN0BfHlrawdV4WosfFnbWKQmCZsWKPD5ukxfZQbESGtfqNY6Tj1MWDLC3eMZ+y+R7cF69vyHFK1lCm8SemIMOk4U9MsfUbLpkW1R7zZF1jMw9ciB0XpO6iGkBZ2H8Ih0qvkH5uFKYy+Zqxrry7bqeW9SMXPT4NuxI5/FhAjbAwONcgWZ6jAJTLBZAl7ZEIJDv50+fnTGs65Ij8J+Jnu8xc3gYXeU1N3kFBCniyWQn8xIenUs6IKmi0n2jVdm32qOOteUbKG9wpuPxI7UrvNfzzCPOQgHTglm5k5dxJmkWB/4Fo139lwbaNkPKahOA/48eJ2H9K9FsbbHpTMojV64SMkFqG9LDyd/TydTI3xDhtTBaQgs2w63yuSsF6bJYIpPN7tx2JEzUL+VU//vpfaArlcqErg6wxqohvrvXgbGc8WSMlqlodSQvlp6Y7HAFnwzo94gzQI7Bymtuh7ocx+cZrdBgN4+KUmqMrkGWV0bJriWyIDokUdbJGJ5r/g3CMvDu1lVkMm3QQb5fVz0BbG6VZE4mfNzfiMROYPtlCFmY/FYd7Hd366k2HYZT9yOzTGWQquMR7JuIV+f2bJOi7tZ08WS9IfAQgONNvpXWoeFJHRu27X/lh80
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(8936002)(38100700002)(33656002)(71200400001)(110136005)(2906002)(86362001)(122000001)(7696005)(52536014)(9686003)(26005)(966005)(478600001)(55016002)(4326008)(316002)(53546011)(66556008)(66446008)(64756008)(8676002)(6506007)(83380400001)(45080400002)(76116006)(186003)(66946007)(5660300002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G79pjBKpjDpxMvmXAZtlomK0GfTWxbUd4MCR07JL3PJQ5cegZORy6qLcqf1D?=
 =?us-ascii?Q?RvLJBsgIqXn68Qs/dOCymls/NeUNqqkxa+XDhK90qZsxjkejJLEhl6FwSkM7?=
 =?us-ascii?Q?SVPqwt2w+OsbuPOiHbRPe8oCaNEB2hwZqp6yY4rEJWb+VUl78cqB4Rmw7ItO?=
 =?us-ascii?Q?DXIFLrsLh56yKhPbRymD0Ab16OetLU71iYLSaHGlRRqHzqPrhPh4V+yDyhLx?=
 =?us-ascii?Q?sKf7Jfv+lIh0RM9DvbO3ay7z/uWKBUCtZgVbmiU7vpG4QRKZp9Ozq3vr2T5D?=
 =?us-ascii?Q?Uitbw0/oxdj/9lj92TCXYJAIFi+ohjY/UcDTw5yIYWGqaxGrrnQvlpXER/j+?=
 =?us-ascii?Q?9LwYedCU2+pDjp/JUbNU/Sv+SQKtJxuaGYDzGl20Z0JhtIcnkufjoa776Vc0?=
 =?us-ascii?Q?mJ3/1kKuv8PNusipbAwsmCp0pnA/e8oFxnso5mS5KnJPGJTR3ftioTUY7BKI?=
 =?us-ascii?Q?MENd6PhOOIaENdVoHgGVjf9wTwp9TsmanOv0qeDwdKiY9mYQwitfM3ml0Mhu?=
 =?us-ascii?Q?yd89n9DVouFwVfhGUFC83R+u4PRB3/3fiVCwkR1lqH+y/0DeR+mHtZgavxmG?=
 =?us-ascii?Q?EuxyOEMp6KKBIFgvcwpAuuBrEHnO9fBFxd/OsvGAX3k5Vi6KaW7bVw0skj4A?=
 =?us-ascii?Q?+NwByziRwEwcKcQODzBJiyYILs5FnmbqXgzfY5AdthW7uUdwvVORjYUeMei2?=
 =?us-ascii?Q?WkUFc77BLSlqtwDe0E7HI8syVfNFRydfJkHEku/MJRbmSFI0vUsDeqkavAeC?=
 =?us-ascii?Q?zeiF4E+b5VZc0mMByOrDuhcnAUossgZepJiDCpGY45ZUxCZB9HRKQJmGZxNi?=
 =?us-ascii?Q?xQALp3nZw8fF5C2QcIw6ifaZgYFu2mWCXwhnDkmHFignTmsNi4ZGnxcNYa96?=
 =?us-ascii?Q?zDkGdBHiXBJKAXWBXkNXS33QT7/FcJhliB3UXnkwHKzQQ0pAca9hhL2++UbD?=
 =?us-ascii?Q?ZcCI8YOBaLOMwvRaGYeIYQ2o41qpCWjEnS5VssH0vV6arHpmC9FOlghu6lYQ?=
 =?us-ascii?Q?sDRMP69mixCmgAxdPhDx/7C0RSQ0TkxXkttnZC9377FvFbaQHuP5DRNrYm0q?=
 =?us-ascii?Q?OowxjBvlxrvecGt5TaqO+Xq7KZWtEPqDS17aOnWbHq1ZHeODicQVkqz+//xh?=
 =?us-ascii?Q?s4VN3xGN1Igx8f2t21tqPW+PcOxlVbfyyQWHbPRGk90xKhSl6NKpxiaDJrK6?=
 =?us-ascii?Q?oDRQbB0kzlNFViYUciNl0Z9f/KD/M/xmQMicTU5dCGs9aR/EbQcx9VylnpFN?=
 =?us-ascii?Q?0oqOF80/g06C+aiutQjrr5+xMd2/lLMA1lzoFrhOBGLBb/zNIOqkofnY9V+f?=
 =?us-ascii?Q?ZO1QMgSEMbeKE7SxnZWuXo4u?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d3aa0a-3309-468c-dba8-08d90fc6a5bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 13:06:50.6499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUd750eTh17iHrmDYeJwCwf92Tzdl0/FJT20OsM6Xm1UWTI/m3lRTBsmyPfp3KrHPjQq1yVHzbqKh5jkK/fI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3824
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
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Sent: Tuesday, May 4, 2021 6:43 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Gustavo A . R . Silva <gustavoars@kernel.org>
> Subject: Re: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element
> array with flexible-array in struct SISLANDS_SMC_SWSTATE"
> 
> Hi,
> 
> I thought it was this[1] the one causing problems[2].

They are both causing problems.

Alex

> 
> --
> Gustavo
> 
> [1]
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.k
> ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%
> 2Fcommit%2F%3Fid%3D434fb1e7444a2efc3a4ebd950c7f771ebfcffa31&amp;d
> ata=04%7C01%7Calexander.deucher%40amd.com%7C2e5ec39776404b9f1ad
> a08d90f4def14%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375
> 57649665013301%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ItE
> aD0%2FcD8SZYTdHFEzLqhAkz4u40VJ3b8jXmnKubYc%3D&amp;reserved=0
> [2]
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> kernel.org%2Fdri-devel%2F3eedbe78-1fbd-4763-a7f3-
> ac5665e76a4a%40xenosoft.de%2F&amp;data=04%7C01%7Calexander.deuch
> er%40amd.com%7C2e5ec39776404b9f1ada08d90f4def14%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637557649665013301%7CUnknown%7C
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVCI6Mn0%3D%7C1000&amp;sdata=oNDZm9xHuOWbelrUrXYXPoyXLlk2dI
> kRH75O43AFNcI%3D&amp;reserved=0
> 
> On 5/4/21 13:42, Alex Deucher wrote:
> > This reverts commit 96e27e8d919e52f30ea6b717e3cb70faa0b102cd.
> >
> > This causes the SMU to fail to load the power state.
> >
> > Bug:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> > ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1583&amp;data=04%7C01%7C
> >
> alexander.deucher%40amd.com%7C2e5ec39776404b9f1ada08d90f4def14%7
> C3dd89
> >
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637557649665013301%7CUnkn
> own%7CT
> >
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI
> >
> 6Mn0%3D%7C1000&amp;sdata=zo7mfnO2t%2BtQgPxIquuDYIsROlkqECjdX0r
> JOPyklyc
> > %3D&amp;reserved=0
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/gpu/drm/radeon/si_dpm.c       |  5 +++--
> >  drivers/gpu/drm/radeon/sislands_smc.h | 10 +++++-----
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/si_dpm.c
> > b/drivers/gpu/drm/radeon/si_dpm.c index 918609551804..91bfc4762767
> > 100644
> > --- a/drivers/gpu/drm/radeon/si_dpm.c
> > +++ b/drivers/gpu/drm/radeon/si_dpm.c
> > @@ -5250,9 +5250,10 @@ static int si_upload_sw_state(struct
> radeon_device *rdev,
> >  	int ret;
> >  	u32 address = si_pi->state_table_start +
> >  		offsetof(SISLANDS_SMC_STATETABLE, driverState);
> > +	u32 state_size = sizeof(SISLANDS_SMC_SWSTATE) +
> > +		((new_state->performance_level_count - 1) *
> > +		 sizeof(SISLANDS_SMC_HW_PERFORMANCE_LEVEL));
> >  	SISLANDS_SMC_SWSTATE *smc_state = &si_pi-
> >smc_statetable.driverState;
> > -	size_t state_size = struct_size(smc_state, levels,
> > -					new_state-
> >performance_level_count);
> >
> >  	memset(smc_state, 0, state_size);
> >
> > diff --git a/drivers/gpu/drm/radeon/sislands_smc.h
> > b/drivers/gpu/drm/radeon/sislands_smc.h
> > index fbd6589bdab9..966e3a556011 100644
> > --- a/drivers/gpu/drm/radeon/sislands_smc.h
> > +++ b/drivers/gpu/drm/radeon/sislands_smc.h
> > @@ -182,11 +182,11 @@ typedef struct
> SISLANDS_SMC_HW_PERFORMANCE_LEVEL
> > SISLANDS_SMC_HW_PERFORMANCE_LEV
> >
> >  struct SISLANDS_SMC_SWSTATE
> >  {
> > -	uint8_t                             flags;
> > -	uint8_t                             levelCount;
> > -	uint8_t                             padding2;
> > -	uint8_t                             padding3;
> > -	SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[];
> > +    uint8_t                             flags;
> > +    uint8_t                             levelCount;
> > +    uint8_t                             padding2;
> > +    uint8_t                             padding3;
> > +    SISLANDS_SMC_HW_PERFORMANCE_LEVEL   levels[1];
> >  };
> >
> >  typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
