Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57369C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDA861554
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 21:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDA861554
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2A089A9A;
	Mon, 10 May 2021 21:48:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E91689A9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 21:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVtn2Gu8eD5VOuqabEaepRZWjmagNqN1LJztKs6/pLn3h+9dd0wWTsTg7H1D9L3f/FyP+FNbUpbMNmfMEcZk1mVilOO19oarcXYUKa8czi8zeYqPBH3GcRdH6MbnJn/mLa6PkWOfcdQDszU0h9lXcXisYC32j5SbY2K4lWerzvY4yaMBHOIyRddlDVVaXuQm8DJtXj8vJOzJOIwTMY/843+ONs2NlWumWv+KoPYAEtxVsBj4mRbK5CEau7wVmQzaMqPmST2sa8bhg2TQrogKAbjlbz6lL3grrYK/C2ysshQ7pHdAlKAEIasmeJ56Zp8yqc9KoACxXIIpBe3vSbfwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnIQG+iqCNgP0FmWc5AuXFNM9g5Ug4gs3AXL6mw4bGI=;
 b=TzSRAy5kWqHu2BVy/pELDyJV0Z1hctKxREnJ8uCUhA6opxPQfSwkI9ZyGfHv8kyZ4a9eyLkdfZGPleGYEzLEDokwokhSJPQ2ARyPNBWu9Hcs4e5jQOxxGG0g9qx5VH1F4JT9E8sRpICzOW8PZxM2l0N7EYJdmR0/eomY9TTOVeQzLc7FtrrdN2uvbYgZgTbr6ce1EHhzqicYATx+E1XTD9jGgs7huXLtRITRsuw6W1z9Fmqbl/94HIiWGQKEYXvu/o/ijnPcl+AKjI0iJXVE/upqHEzd85P9zONpTQcydIb9MMImQxnyJbnnX65eKxjrzAkKL55Y1cUIFo/gg1360w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnIQG+iqCNgP0FmWc5AuXFNM9g5Ug4gs3AXL6mw4bGI=;
 b=Ebn/7094Cvdk3W87HbGLqwg3M61DSDc5JYIYuFHYjAWz4S79N+wYvhxyHNbjc7f7J0I4hwbQTyGZPNQzRSJZ7J5lje5y9y0s99IcsEHTvBds53PVIgadAeRyhYpgd750ION+/b+N6IkjBWlMrdX5j1nPQGCls0LxRhwiJDVnCW0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Mon, 10 May 2021 21:48:33 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 21:48:33 +0000
Date: Mon, 10 May 2021 17:48:30 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix dal_allocation documentation
Message-ID: <20210510214830.rfgaoky7sj65okkn@outlook.office365.com>
References: <20210423204931.428241-1-alexander.deucher@amd.com>
 <CADnq5_M3UOFy1juETM1DFOyvYWqBtPBGREEmA_BSk=UcNdhZCA@mail.gmail.com>
In-Reply-To: <CADnq5_M3UOFy1juETM1DFOyvYWqBtPBGREEmA_BSk=UcNdhZCA@mail.gmail.com>
X-Originating-IP: [2607:fea8:56e0:6d60:e50c:fb14:3ae:933b]
X-ClientProxiedBy: BN0PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:408:ec::9) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:e50c:fb14:3ae:933b)
 by BN0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:408:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Mon, 10 May 2021 21:48:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f171dced-64d6-4f1b-2a6f-08d913fd5ba8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB451387AAA710E25BB98D3C4F98549@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWacXHoDtXAyLh36ScBzMr2Vr5pzBXgDl64HMs5XGRxCi2GGBdYIyNkDxzTFuRNiYHmopxqWC2yPoxJzWwhhAQ5nOBTxh4I6+967k5MbxzSRgzB6nGl8kKZou5TWg1W/haHHcaVo8yhr5/cEhz4TmRyDqqyEJnD/acg1p9we5rDo+kI6EkOeWmsAtjl7nofcXUeKUhIBb3EFJMANC0Xiq+8jzGu9UKvkA3qOYYq87grChHq4cmaVuEXsUzAnHCwlbRmrTTfEJuTx1XeZevkyPfBoYQT+v/WyTdCWgYFauNfzTTZBEbQiBO4+Bm7TMxE+yg9w0yKFgpJWisltgvIR+TEqLI6CtiJJ6aPaHc6thBTO5Ubce0G89MQ2UUR0n47+qlq7h1KkK4XZOwbFPd+6GLyMInoT7su0CzlRooyftEAynv9t8Y1ye0DpFf/DQUYxCYt0MH5O+ygL+B7q0Z4T8cDrBbcK+Y2RA+pbRg9kNf/pVqqYPrMFLHLyfjW57aSiUBBjYZPgDwuksethxHGK5CcLmd5SjireOyV09EDdvP8y/KGD4Z0tcLJ9TQBQ00noFQgo6d+EY9XJwAWn9VEanexFFSF+haDHnZ3YYtR6U2LqksRYGkqptFrUtZ0RhMTGub2SaaF1n1xnGCUKgiuwWTwmoX7toqDVi3ImdfPnRcQWdBEiaAEx69c908HvoyzSsYM3Zm8232gZNBw5Ux+Sq0orDyEZGtnvfKhBCSjFg5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(186003)(16526019)(7696005)(86362001)(4326008)(316002)(52116002)(45080400002)(966005)(44144004)(6506007)(478600001)(6916009)(21480400003)(2906002)(55016002)(9686003)(38100700002)(53546011)(8936002)(5660300002)(66556008)(54906003)(1076003)(8676002)(66946007)(66476007)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?acRxL3Iqcybz+jyg1BZQ0r1LXeBFRVn8x91hTbl7OhRTdD5znQsan7zTG6dS?=
 =?us-ascii?Q?cQFjRzc4twIQs8UQOYa6Btk78UkF5gpbIq3HqVxYv6VoYfZe7uszWKYGz2yS?=
 =?us-ascii?Q?Qs+Aht8z+a9pHIdAfxnW2t4XYGgIurtb347CIGOTdBFIhU1LPbeo+YsUl+uq?=
 =?us-ascii?Q?TUSOMIUAszD28chMQ/0wvgyR0uwqbY6sjK3KRuGj2L/80tgVhE7DAGhDiq4F?=
 =?us-ascii?Q?rItdRsPzEbp7EbPa9m254MEmneGou02U1ME0woA9pi//qM728JDQCennRHL5?=
 =?us-ascii?Q?/8CiLUSfEHsrjxzEOgyDw44NS18uzA5UJS3Q2M0UimAK4BOoMdQfo6Z8nTR+?=
 =?us-ascii?Q?XdvQCbZATfbPjUFsjFXa4uYydB/ZGmfIC/6JobLjyO6Y3gu3DSTZFo+wZT4Y?=
 =?us-ascii?Q?YT5PZJmNNwgH+5ptAMVO4Mpp8NJOZm5UPfotU+0Azk6t/SgGKD3AI19oh3Ro?=
 =?us-ascii?Q?zVB0eTtRdVon/+qtOGcF6v3wFlDCwI+VZoH7HlmES/8xDjf5D0OHw9wlmolk?=
 =?us-ascii?Q?kxLOyeUWcutfFUfk+Fskf+QruP8u4nm+y8Ir8ulpRQ0baLsnbwbHs1Xe8N26?=
 =?us-ascii?Q?FHr9/lNNwBBDh6Flb9czkvfpZssEDhBnJ7Cg1c82rrRYnFGrZAI9fEyusODS?=
 =?us-ascii?Q?qZFHn5Ar1FvKpqvloG1D54eg74peF+JmEQgxqGVrVkU1oW3WhzkxUzXddafx?=
 =?us-ascii?Q?dFwdId+B+gZwTSsbnnzlPbiR+VWU3mDSViSYr4yePrv4/dAe9SISGwRfAIE5?=
 =?us-ascii?Q?04Jeq7bPHfx1WDAXNtABIUYNGH5Lhw7CFTTIf7fKljQuyYhPBldc8yzEMq0O?=
 =?us-ascii?Q?nunn+XrvKsaMd5FthlzdjKrWY+tiSuKdudnIELPOqGog3Ebez8Z6AD/oRipd?=
 =?us-ascii?Q?H5SMdHFY8Sxx3sAw4jw3EbfvD+qszVZWvhak+oFkMmUL2fusXwFrkMNiIZQu?=
 =?us-ascii?Q?qwULxkksupR8hRJYJZi3ROlaMMOWrRiM4/QrLoGv4QgWdqDelounW2HKwzTF?=
 =?us-ascii?Q?y77O7UB5zVZMjOaSxC/CrlDpS+ZdZnIw9hFtgW1ymehpdkxGAHLll61EIu8A?=
 =?us-ascii?Q?e4/zs1DYl+Vi4n9qhT87YCrtmOhGvC48pHWJ5NIK2UudMRNla+tRYlQmfGyW?=
 =?us-ascii?Q?AOX91zJI+IcY0MAjkqj2DTn4x+bF0ZwF5h5vb+oFsFfVdwlEPUFzJpv7+1Iw?=
 =?us-ascii?Q?yw+4zCvzX7OLByd7oVa9/6Q7IXhP+/ciNLoASV4mD1HlsApwAqs87FAShbcK?=
 =?us-ascii?Q?d8YOSLh3EOi9k9ZGxEoLE4gg8Gsbu5YdKH1O/rDR3mLOFTCY6OM7CNcUkzX7?=
 =?us-ascii?Q?9h8irDlrRB4+vkm9363hUrxuOjVJu3Ul5rofYOkOoxz4dwL86vczfSBQXnXI?=
 =?us-ascii?Q?MGssMuQOzIo2VC5OSn2O279eRsmm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f171dced-64d6-4f1b-2a6f-08d913fd5ba8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 21:48:33.7225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xplUbx8oF72ibUCso+SHsywSUpebQdRlintJCqASOp3Q4ZxUO9UjwrhXdP4ktFP0eCGvLehP1gUnqRlaUBU0dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1131867383=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1131867383==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hjwtrpgim3lwvynu"
Content-Disposition: inline

--hjwtrpgim3lwvynu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/07, Alex Deucher wrote:
> Ping?
>=20
> Alex
>=20
> On Fri, Apr 23, 2021 at 4:49 PM Alex Deucher <alexander.deucher@amd.com> =
wrote:
> >
> > Add missing structure elements.
> >
> > Fixes: 1ace37b873c2 ("drm/amdgpu/display: Implement functions to let DC=
 allocate GPU memory")

Do we need to add the Fixes tag for this patch?

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > index 77e338b3ab6b..d6a44b4fc472 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > @@ -135,6 +135,10 @@ struct amdgpu_dm_backlight_caps {
> >
> >  /**
> >   * struct dal_allocation - Tracks mapped FB memory for SMU communicati=
on
> > + * @list: list of dal allocations
> > + * @bo: GPU buffer object
> > + * @cpu_ptr: CPU virtual address of the GPU buffer object
> > + * @gpu_addr: GPU virtual address of the GPU buffer object
> >   */
> >  struct dal_allocation {
> >         struct list_head list;
> > --
> > 2.30.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7C85c3a4b96175482b593808d911981dde%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637560167304944436%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DUKiFJJEzAf%2BSwolov6%2Bjf51BXzqgUAV20JGdJdr%2FlDo%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7C85c3a4b96175482b593808d911981dde%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637560167304944436%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DUKiFJJEzAf%2BSwolov6%2Bjf51BXzqgUAV20JGdJdr%2FlDo%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--hjwtrpgim3lwvynu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmCZqi4ACgkQWJzP/com
vP/how/+NJ2l+uTjQTAIl1Pc9/dVkFn6KEWRT31mjdpsiKrHg4NE3C0PFIvZrht7
ByKivGNSgdb0hsiRnudeGVk6mW5+2o93u7R8+vkXTEmyd6A3Eg+4GGKjdQR0xPtq
9nb0MUzo9Nhd5d3BVlWz34T1sayJFaAbs/soJmY75JGt/TMST8d2hA1BamaKsnU2
xIJwrxAl9vfiHxOqsS4qMpUbha+8cEWOAzyw7d2pOXVpnWOA3vPHp2iuqcpLsQaV
lgFtNKsPtV7u2toy1eqMxnmTwPCV7SiKaacH3P7wdjkvfWk2MsAqUMho96+Cna0o
TV7ozw1pl0jpiRyS8lPp0GNpRNuhtD3+HxrZL5n4ZkgB76jQTbf/WIZP6/yN5rSr
jNuRCylkWibHEOMImJk4SKNIpjoj+D5iGDFqr+JaHsdsBMqqB/MSFfiI+VHY/ksY
eTT3aAkG8J1JKTDrTUOWup3f3uvdXPTqXdI6aDocd6J+6Tf4VxP67/G9SYWWPR7/
Ua+DCEJebcFrS+j8vWuiOnmZpXbIcX7XwHvc9ysQ8dtYcC80HwheK31QkEZxRACR
mIdSIcv0PEF90RkzdJG93GBwrGL40V57WJvAYW+jMW2omrc7W4DcoACjJL81Zbtr
saSPJLhcqcBL7v99+Vxqf5Os4aEsJFBofDnI5ue98uOpMRkDksY=
=zXWp
-----END PGP SIGNATURE-----

--hjwtrpgim3lwvynu--

--===============1131867383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1131867383==--
