Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EE6C55184
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 09:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56B810E4C6;
	Mon,  3 Aug 2026 09:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DrkKSUpw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5FAF10E4C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 09:25:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs1SeJ/W7Am7s0n6Hc0QsjkSakWOkfcJsRVRDPxh3u0eOplNze07YFtq9ThYrQn5QhAWF/OjQYCy/FtCnap6GTo8Ug3gZw/P0iMAz7zwjd32Xhb1ruOJTOgPtUNhrNojC/HU9BoNJ2GTH+DC8MyCCIHZpG7wZadbL6qcdGvsGjHxKvUgsfx++fdncx5hWJVtY72fKB6Q5hL9gitNVdBjBZroetRhrJdxfmkrTmbElmkYI2EOe4liynYlfOjJA8ZB0uBP9i+xKEhtOmqWKRgxwCUIwKI+MwUmfC4pZ4jmBOPM1Q9g8tvRW+DR/wG4hrZCIdADs1eW2dnR3jNxdf8XHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZgZtmS9biSqWuHDYfl8FPsIKsnUW64dM1acboRo6qU=;
 b=RRVhlNPu1XVA7UG7lGbVs1Iz2oH+O+9PyPAhFD2ig0Wb6KzmX3HbzWKet8VnAGIuzBns0hUteHuBXTUXOApfOiShPDRnaltwr950EOZCo4HCboVjhbfYWGeVI4B/DaMJFjdb7T7RLik1dH+LtYlglXILEpj21lWw+11BKxZbVqORiXv69NGCOmKesAH9TH9beVg0xhb2JVv9zRCzQZMmjYSUMhUhXWc69mQZwypkynAtQFxUE0Nq8tJD/xhLSYb0rr97Za+02r47k0DTFOnSUzTfVMojCFJZL4o3sWq7xcn3JMvC1YyUy5YsQnR2Jr/3qjwCe2P1eMQf64/49OitRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZgZtmS9biSqWuHDYfl8FPsIKsnUW64dM1acboRo6qU=;
 b=DrkKSUpwZF3wi8cmUFqDO0ymQLwaS+NCs3OUdzLtod3hXCmVfvOLz+s2HrB5lNSbGkIvs0+XVusHR/0R4xigWmU7MC/BdbfmPSO2ra69pDFqSzN0DKEfOW1k5u+PC3AMeImefP+maRAoOCz4ItdLFpgQ/79ksdXC7xOts587i4I=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 09:25:09 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 09:25:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq reset
Thread-Topic: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq
 reset
Thread-Index: AQHdFCOgnbCr85VDm0SiIcpJNE08b7Z6sLoggBF2puA=
Date: Mon, 3 Aug 2026 09:25:08 +0000
Message-ID: <PH7PR12MB60005AAE1676A52D0A72A0C4FBD52@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260715063128.581232-1-Prike.Liang@amd.com>
 <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005701083F93C0330D4F4C0FBC02@DS7PR12MB6005.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Shaoyun.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-23T06:28:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|MN2PR12MB4144:EE_
x-ms-office365-filtering-correlation-id: 837fb7cf-7077-4099-ac02-08def1411c6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ozLuCjKslzKfhsEIKwKoRh66bKOumgMwgIvdq+7C6GFVjzWUPGL9ItP+D0QOARKlpuL04zaWwQbUNgXGrnsmGZ8uaMClcgCWX5PNuz3vfT/Z+3/ojXwaW9zb3yOeO8BDT6tdXQuI5lJoPqrtfgiwEdNeNDrnnljcW9TKB7GO4dcLFAGicwRZHZfx519V48Dz87c0edF9csfwFg/Ezvtm5/JepTAYe+3RXJQ3AZyP9bZSrkiLEsOWIhMQKzO+fsXOy9bVF7n/LhrfHNvlakam4ah88bJMoCVmSVlFT5l+dk9sgytI/MHrAZNF0GaTQ4imxnZS66L6nmVD5NttvrSOickAsODPHhVBJb+oyrmxMsJkI7BXch9vbxhwjIWEkJumJTYIkmckG3dfzU/a5Lcett+Xx2sljx+QnANiapGEjDsHkGGwNNURHeKLnPrJ0NmFRfEPuvS3a+SXXNeIAJ9ClA72vk87E41aRc/ASH1SmiUl1XRE+gyDDYdHkhyBvz4WwjgMJzB7tZ7crvdz2A+nTGDHy9YPA7aES+Inj11OpFmlk+4zciBhJ5FkMKhgwxqVgBAOT8H6qrXRa8Ah2DpNb2UdBWi5thFEHxLqP74b5bv6SGrevi+yAYobV0RAx5jldacnQg//sLS9Bbq9IdvzvTlcwahkQhA2GY0/PNEBcZmso+kuJCJgHb9dTRCFJisLAlyF4AbZLHwdr/qYy/tzzbr4i6+FL9Wu2VgtGv7pWQE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JA26cvZXcxiYg2ls6YQ/+/eWgxvdnenCQRqmKmsNQlXVp5pIBZgVPqyRRMoW?=
 =?us-ascii?Q?cUOy+a7U668CMqNW9yBJ3CRiEPo/ZIrEhgTi+GzDAmQv+OjuiG32bKLcab7g?=
 =?us-ascii?Q?w1iuEpWKAmUPgVzvQcJhXoOs1f8z88/b6QbLGEhJeX1z2LFpT8+qC73NvygX?=
 =?us-ascii?Q?JFmLiGVob6ld+VgNxMceiVdHJXu5A6BnW1mqBQdoqsqogj5AZKNS+caG0PoI?=
 =?us-ascii?Q?DLEDkvQetUbAVOgT+D5XOEwzYygaCxM7WhuFu69/ETwNXRGlwiHainqABfoi?=
 =?us-ascii?Q?7waI1mwJrOTzM7NlFhcX4kA/cuDqZ2ENWkbJ4CX7G86T9HyoYrXgGIXORNcj?=
 =?us-ascii?Q?MLvnkJrXYcLCruEGlhprq5/C1TnLtT1Zj9zE+0nNBgMF/Mc1WUoLifkUuRov?=
 =?us-ascii?Q?g0NGpVERMp3SuPnSWMsshHPzwGzmLPnEjucCFRyEWm/5qpy6QU5tLFmWIilp?=
 =?us-ascii?Q?ub7djpYQAXPj1qdDaPd0fUe+lt+YrcTlh69qvlEQuoYlJlUkXQTejyUU0KZD?=
 =?us-ascii?Q?CYiHXoBFFAoUZ+8OhwA+RF7coIpfO0B1NhjjHwH5O1eGefbkvQKp3Cu3abhS?=
 =?us-ascii?Q?q3KO9pZNTwPtcGP0vsGL3Tlc/QOQew+adxeJrVBarOprwMVKuebfP65he3mc?=
 =?us-ascii?Q?WH9H0Dn2JmqceKSF/2lqOlrOjKjLQsP01Vvfxxm71zI5Slgzr4XlDMkaNYLw?=
 =?us-ascii?Q?7aT36UZbVjh8/v7n/uJr6G9+dt9D1kJ6v0kCs8vtY6qJqTqYXmWk2vTL/AfB?=
 =?us-ascii?Q?f6K94FtQomVZs2duIshJ+0ug6sp/LRhMe8FJ746xmnTSxsYztMr9BrV2b+FV?=
 =?us-ascii?Q?y6nRd3qXrI85Q1gFg+/VfOw43vyuc2s6XA6v219adec1PlQoFmnn5BHkYAB6?=
 =?us-ascii?Q?ujQHeoS5hhE3OQGtpHZ/WSnxkahawrP5XcaHw1NErg1LXmYB8qZ30USZq0Oa?=
 =?us-ascii?Q?h9gDTSAvjUxWE33RgzHXRfrMcAy0kARDjedxRHyUa9a4s5DlwTe8P/qkQiUT?=
 =?us-ascii?Q?X20kbEMs99BJGIYq6emXvrESgi6f63TT5ZzhAHaAGd4eunUyLDIV0f97JSNX?=
 =?us-ascii?Q?Pmq6mitTnp+5heCBO2XCi7gBn5ZcXmevLnjUMw8maZVJWJyqfmAfFZlqRENQ?=
 =?us-ascii?Q?K1cW/q3mqSsuVNlRBUmNeMCB97NiSMOfWyYEhF0s5eYkLJwTaDVP/Hub8XOu?=
 =?us-ascii?Q?+eR4cHy97PdNHQ8UMQIgTPRGueE46RZkYDXaDoR2HMR8lFxe8cO7kDe896ur?=
 =?us-ascii?Q?gds1DtLxbLvMFY4jjHPsrsL26/kLcS0q6wEDMZcXtR2v7qlfPIRaN8nHDLCj?=
 =?us-ascii?Q?ru3K6goGDezsJV8fPhMgltjh/9NAW2npwRFPHYTCv/JokbfyvnxHGWG4LVt6?=
 =?us-ascii?Q?GFZNymijxoVwM9BF9v53n2jzRyXDzGIjq+kg8EE191yoi4tIj64kRnrr7vBi?=
 =?us-ascii?Q?b2hmmqMWfNQWgx0LgV9PC89IBValR3asRJ64uth1aaf3mhoRh3Qwt5oY4uV+?=
 =?us-ascii?Q?7O9pw1hzSBOvN++fMl8Z6/gXfupqI1K1MUYw6yT/ajpICS72Qbu/zeWzRfrS?=
 =?us-ascii?Q?yUt++/6FTRSkT9/HRarcPQrjQ8NJeTXCL2+8TaYoK/mgRfyGxY2MYzxm6/r4?=
 =?us-ascii?Q?oyzscJCpCM7xNMjyoKNt5195fQSFF/nsOwPGde3JIE5J2syWZpzc0AB6AVxc?=
 =?us-ascii?Q?mwqdWmCAtU/YMtqPk4P1kH/+syGGtDLQxBXvdTQ/urNWC7IC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837fb7cf-7077-4099-ac02-08def1411c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 09:25:08.5010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCOWpR2oJV8AN6O6r7R6M3dzf5Qmq0wiZ70YNwD1ZQIIQa1/r4G4bAVIgPgrwIZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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

AMD General

As for the hung userq, it should be identified by the MES reset API with th=
e hang_detect_only setting. However, it is unlikely to miss detecting the i=
nvalid opcode hang case, especially given that the userq invalid opcode IGT=
 test has not been implemented yet.

Hi @Liu, Shaoyun, are you aware of any known userq hang scenarios that cann=
ot be identified by MES API hang_detect_only? If not, could you please help=
 review the following patch, which unifies the userq reset path for hung qu=
eues?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike
> Sent: Thursday, July 23, 2026 2:38 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com=
>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq
> reset
>
> I checked each different userq hang cases, and the guilty userq can be id=
entified by
> the MES firmware and report correctly.  @Zhang, Jesse(Jie) could you furt=
her check
> as well at you side?
>
> If there're some hang queues miss identified by MES firmware, then the co=
rrect thing
> is to further debug from MES firmware side rather than have such strange =
reset
> sequence and this reset workaround should be cleaned sooner or later.
>
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Wednesday, July 15, 2026 2:31 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: Remove separate guilty compute userq
> > reset
> >
> > amdgpu_mes_detect_and_reset_hung_queues() already detects the guilty
> > compute user queue and resets it through mes_userq_reset_queue(). The
> > additional reset via
> > mes_userq_reset() is unnecessary, so remove it to unify the compute use=
rq reset.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 5 -----
> >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 --
> >  2 files changed, 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 1e275c2e7dd3..4f2d5ff2f7be 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2315,11 +2315,6 @@ int amdgpu_gfx_reset_mes_compute(struct
> > amdgpu_device *adev,
> >             deferred_end[n_deferred].fence =3D guilty_fence;
> >             n_deferred++;
> >     }
> > -   if (uq) {
> > -           r =3D mes_userq_reset(uq);
> > -           if (r)
> > -                   goto out;
> > -   }
> >     for (i =3D 0; i < num_hung; i++) {
> >             struct amdgpu_ring *hr =3D NULL;
> >             struct amdgpu_fence *hf =3D NULL;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > index b6bfa3974839..fab21d4275f3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > @@ -226,8 +226,6 @@ int mes_userq_reset_queue(struct amdgpu_device
> > *adev,
> >
> >     xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
> >             if (uq->queue_type =3D=3D queue_type) {
> > -                   if (uq =3D=3D guilty_uq)
> > -                           continue;
> >                     if (uq->doorbell_index =3D=3D db) {
> >                             uq->state =3D AMDGPU_USERQ_STATE_HUNG;
> >                             if (use_mmio)
> > --
> > 2.34.1

