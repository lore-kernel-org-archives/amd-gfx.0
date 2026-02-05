Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E35EC1EB2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B5010E8D2;
	Thu,  5 Feb 2026 14:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rI+PYARC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D593910E8D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjDzADRhAE5rl5OSjrVFe8fpeDSjsBERfWqV/uk6NyfJAx079lSUbD/XDmUoErSNIa9AjeSh+bzhS6y9UaEwRHCS3Wxd7HVqessM2P7G9y08QslN63afXMSDybBKgMhqQ9+kSHv2bYrEqFJBi2dVPvAyhHRrop0OYFMUWlqEfHvOFgB4mwLkWE1ZGjGv1WdBuYzVgcrYplU2T9StPDsRRtkIZcaRzZS7yFF1qQkzyzbZ/KF2Usp5s+XAbo6i69xDczQgrnpiiY97X7enRA4m0nNw5B2la/cdyQaPTbmSNeV5NZFKJqzPJpBe/nRiL8rcvI+SIxnhJ83W2VJwQ0Nz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOUELB1Me2uyKkTmFIWliqzcT2KturKLfklx+azx2h0=;
 b=pBXI+eNhNQFxIndd4d4HLb1879aen9Ho73trMd8JfWyvol2sgsW3WMLBa1pup1zgq/F8r+8Y6rV82yhW9uhmgAwGPgSandBYHQ31mne05MrKPcOrp2ogWhiRfKrEAACunqrHP5ZgzNiPG6UF5RhsKaw4AuXaFTc0+kEV8I4zSR3rpKSx6iArvED14wK5kGC098sfV4Z5wci8awSswctRtLBJrkzuA8jKqpns+9gXhr1I10H7YCTmS3LXKCbZiVm18IspPmgJ6MK8zHTuOMfZ6O66Fwj9LSlF3UQ5/Hb0nKjyJCH/QSEaROh11zMWhGnTU8IPL+Kk7kwfYHzEkqYbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOUELB1Me2uyKkTmFIWliqzcT2KturKLfklx+azx2h0=;
 b=rI+PYARC2fVNjb92AwmaE2ciWyrkZwFOQCEILj+oKAw4Apqy1iZgVox1JZ6pVWtJ2G1PIN6qLc9fYHhZQsjRDrFb0+kFsyrRYWRhcak7ZjV3u/797WvhjeE7RGi0Ja9cbcRvfBTP4xmqWs72ZeMCBdZavk/rkbQj5JIXMD4Sx8o=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 14:05:00 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:05:00 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send applicable RMA CPERs at end of RAS init
Thread-Topic: [PATCH] drm/amdgpu: Send applicable RMA CPERs at end of RAS init
Thread-Index: AQHclf74HHggEGMYIU6a0VFvbOV5H7VzdKkAgACv7TA=
Date: Thu, 5 Feb 2026 14:05:00 +0000
Message-ID: <BL1PR12MB5898974AF321957512E303458599A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260204175151.536589-1-kent.russell@amd.com>
 <PH7PR12MB8796EB4380000027BC6226E4B099A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796EB4380000027BC6226E4B099A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-05T03:32:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|IA1PR12MB8264:EE_
x-ms-office365-filtering-correlation-id: 2778468d-7b00-4786-03a6-08de64bf8d6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZKJeO8IgAYOt/W0GIqsPJLnuB5vg6fcnkdSsGY5p4UviTJoffGFbIZJ552RU?=
 =?us-ascii?Q?6s5t27RjSquOt/w1D+qc9/XslxHe7pszc00a1Fz7QWGyPku6TbwhUyVtnHzu?=
 =?us-ascii?Q?lUZP824vFor4e9oWONQNDOKAMUjTm+jkWJici8RmsDsc9GLSai9/5kzRWRZG?=
 =?us-ascii?Q?787A7iKSTxX5n+eBFc8irR8ZZlNX+wBN744Z0WGS3pXkl2AEJu7+++mLVzF0?=
 =?us-ascii?Q?T7XCxRUmttJ2xpO9gDZMk4j1TYIbWTSAdfpBFBztU5scO2adbJF8jFCZu3Qd?=
 =?us-ascii?Q?xHYo+Da143wzJqxLRYpNbx/KVnV8rXGyeA1hwq1vfBrdySr1fXN1ic6sMUF4?=
 =?us-ascii?Q?7Be56Beo4vLIKskGAWzpHPJ5VAp9nRX6kYlZO6rF6x1M5TF1+/pdrgb2/SmH?=
 =?us-ascii?Q?wiuuE2X24Hs4Wpn4qJT0VZXiGOTSA5bv+KDC8i+dLJqx6WNAGaqivmSlfAZW?=
 =?us-ascii?Q?zbUyi0djsPR9hdKSLcoLfc81jA8jgCBDrS8KT5Vb4wUJHaAgnqOx7jayE5Mg?=
 =?us-ascii?Q?AazacbZxgtKfzV4is/mKbWoPZby8XE58mA0q/6kQEzqXgeK9Y2piO7PJbPKU?=
 =?us-ascii?Q?iXJpAzh3olULCkE+QEfIr1mkdp49ov0vQF0kCL1gQkEp0aEnFfLZbtXosunj?=
 =?us-ascii?Q?OjOCvvCafu+uZQNne+gxpTS0UbClAFxycr5/qaOv/b46uKzNo7a2xZGNlm1o?=
 =?us-ascii?Q?uoLGoo8MPiHQuQvDafiJ3Xb8nutNka+jSN0BVKNLlWP8YNzbMowVLiAHVNXT?=
 =?us-ascii?Q?3GCOs9sDGWo17KfaMKypXFoshklWqbo5FKxfeLcX9a8Zf0/Y2UIuQRGRcLD/?=
 =?us-ascii?Q?blFu+sCtra6T/qGb3n5BzTNaaGlm/lda/22SXDVvuABBUDw0yE4fbZ9pQfl4?=
 =?us-ascii?Q?9+vKvItPT3FUq+0s1MRZ2NP5Rfe/OkuQ/Ts3ud4nN+FE7wtqBI42EtRtiIEq?=
 =?us-ascii?Q?AfqSMIYSzcMKZGrUicckuM++cn0j0Ww0TLdTZVICFR3UZ1iWJON7xRHvITcG?=
 =?us-ascii?Q?bVS13/DYUjAv9pWzzRQEEga8p2znlgeV+rP5CeFjguPLbrhTu0fYwgX9cZ9r?=
 =?us-ascii?Q?DQG2GeH/KwPOI2M3jV+rPfUNZ5bgO88vvF9QT1YFxtVkPFDten6TlZK+9IPP?=
 =?us-ascii?Q?l5yCzLTdPWRnuqiJfcXwOo9AOQOU7bTzsciGLAs99+RHoDaQYkBZcbBR2py6?=
 =?us-ascii?Q?HIXvE7exmznUMGJaIfCXr335h7d0i9GEOWLbkdOzy2Fi+tEoz+3l1kV7vvlE?=
 =?us-ascii?Q?yWJkN5V4rBpfjNqZXiyY8slvIPIZEM3PBoeiv9IlY0BUiEL3UD99zmmnYe/p?=
 =?us-ascii?Q?231GVZ6oLB3si8VrX1JkrrvBOYoLrdlYINTwNvFyF69gPIbSOSR/S7AEg82J?=
 =?us-ascii?Q?jrGcDsOlm3L2OOgJCK1Z1aZvATxpL7ty5kJ7tYLbDgOjpTNoLUBtRgpVlduT?=
 =?us-ascii?Q?+MnHTP1nWKuk/ablyWmOO0cLvwP4n2gucWVH3vk55c8itoB2axN/0HeVA2Aj?=
 =?us-ascii?Q?LzR4yYV2WjqCtt3hOLcNXvMDR2fVNr7AS+V5QKIyswHPbqQN90RyvA3PUJN3?=
 =?us-ascii?Q?UMZ1wwlDdeu+/ExX15Jp5flFupHFg5At4cbzlbCF0hoccuRTjIRANaBaZvjy?=
 =?us-ascii?Q?neaJ6wAp/BhFli2B2nqhJ1k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wadUfnAacNT30gvR5OeqjujTiyICT+xNAAFsKf8JXilwvf9WjjiR+eeMbvB9?=
 =?us-ascii?Q?lQSqf1RRWjav3d0yqbD48CElu62FjClQsY8NSjL5nTx8nNBZ9VEG8lTS6jqp?=
 =?us-ascii?Q?9BKNP1QVZGX5/8GPhNa1fhtZX4HAdWn3em6hAr7mCdhrafPpkze0SDYtzdR/?=
 =?us-ascii?Q?JtN3tQpYpZ9budwrTx8mruwLxge8HkPNgFPmrKcRqBxDYTKVMbec299Ivz/I?=
 =?us-ascii?Q?sYb2OZAlfjQ1rrClSC2gfciuqnkUKpo9uRTn1kAzSP8yylXSyCTT8+Xh8Q4q?=
 =?us-ascii?Q?jTX8kx4UHEeopBFaw1QgD2TDRwO8AYR5tc6B6GVoeUbwshUvHQ1okt9p5oO6?=
 =?us-ascii?Q?vwifZMX2rBgLZCnnetdkui75qT+d+hY1M/n2RD6QK1verfYvdtVigSofzJJe?=
 =?us-ascii?Q?THIcTe1EGx8Y1jYkWwg6CZq7PEbBX6x1WjoW439W1CuMSpQ/6L5uqsi1Oy4c?=
 =?us-ascii?Q?hX5/JVxN1PWCY8Mlb3PCLMK/L2ErXKg2Mhe7MKzo/ypBKAlpcK6oUExP7c6x?=
 =?us-ascii?Q?5fL75JQkjv7TfiLeCqOSTMuMVVAp7IyJJCeafmyiTNEq8MPSxOC+0l/7og4J?=
 =?us-ascii?Q?x3q80PVSyRjklGpG3ejksr1N2fN4OO76bdK/twSoHAhbLxatsd3cbcXGRdIA?=
 =?us-ascii?Q?OT/zIy2eDASn3trqSE5JIwJ1ZNyFSv0afccVOXVe6mOQCCuGsfVyltRwCL9e?=
 =?us-ascii?Q?IDQac2Qx01MEHSrjVhFwZlNpwjL3lOfqUJa+9UwMRukhDAnOYeVxgmf8wErx?=
 =?us-ascii?Q?lE188+EsNV2/aMwr/mvuymHB5orH1BewwjE2wXmLWLRRMvzdt3S5fxJBHqsX?=
 =?us-ascii?Q?ouVoEkKTPAVv7Yxf7luSnXSFLYS3BW3W/4XdeCrBOWL+paCqCX/DgqpWN4Fx?=
 =?us-ascii?Q?udMA0gSc4kD8NTOCEFCRjFn/WiJCVUpNNwPGJkNpQvPcAxgATxZ3wJ1mDY2S?=
 =?us-ascii?Q?OlID08QFuWoLyoddZdGWggNi2i28X73aqG0Am2hOCrcrDWdC4nOI1N9mIgoi?=
 =?us-ascii?Q?MiExJSEl406rBdLsaO+aVIq21ZhUKmVRcnqeagNfzVgt9ixudHmhVQ71d2/S?=
 =?us-ascii?Q?/WpbCvAlc4YDKaZl41MlUfguzu2wKKfDTgDz1ktdnQEe7ueIpkgMO4dOREb2?=
 =?us-ascii?Q?uxK/7fcQOlmggSAmq7b48wATAYauNY7SOk7S03ebukF8VLY1li4cRlWdn4lg?=
 =?us-ascii?Q?RkjAQ4VG3nXIZKiRoqUDZGX4wq0X7KI6bzpqKJ7Lx1zRG6fhFSx3cGCaT6NP?=
 =?us-ascii?Q?/FvD/PJugLgIkwhU/Eus/M/34HfhyczIJ9J8t8R+VhnZH63d9maB3sQ2B6NK?=
 =?us-ascii?Q?2RSWudOj2rFCEk970Ks4Zd3od81yY98oMJwhAmrEP4Jd5XMBsDKHUM5CJYRG?=
 =?us-ascii?Q?hWsfmWHvn756sKjQw0KBUk2l//6FP5WvKUSrWqd/NzY/P9ei8QMjUKcvCkpX?=
 =?us-ascii?Q?jeQkOFLZpqoA7c0wXvYFdh/PPYTqt28nofRFbrxtFMkC4Ook5KmakcQbghus?=
 =?us-ascii?Q?qqoHbjiIvcVFdMPIjY6VjLGouvOHzRVS1N550unDvWUsUFcnU2ud4IOAvb3i?=
 =?us-ascii?Q?aGFWn/GvS2lt0H21nmz7G6o+PyILmO5atOJF5/YFuXMv9ywZyB6RQPM6IxZS?=
 =?us-ascii?Q?V/CX3JMzQKH/sph1EsJjBAQg4Ak4ghUXsGmCpYgJ99f7wPeYUuDeC2i/b9NL?=
 =?us-ascii?Q?j2EL5nm4ym1ZkN/mM3rZ5nVpHixCo82tBAevY73CgodRCwab?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2778468d-7b00-4786-03a6-08de64bf8d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 14:05:00.7273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYLp+Z/bAeCv1YAf+h9D/Wby9x+LneBQwrsHUshzuo1/3eR9fRQP4elyxpjRs67ySfqgLKcWkJVWEsQY4jbcVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
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

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks for the clarification. I have seen both terms used differently by di=
fferent people, so I changed my original patch to reflect that. I'll fix th=
ose 3 mistakes and push it out.

 Kent

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, February 4, 2026 10:34 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Send applicable RMA CPERs at end of RAS =
init
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Russell, Kent <Kent.Russell@amd.com>
> > Sent: Thursday, February 5, 2026 1:52 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>;
> > Russell, Kent <Kent.Russell@amd.com>
> > Subject: [PATCH] drm/amdgpu: Send applicable RMA CPERs at end of RAS in=
it
> >
> > Firmware and monitoring tools may not be ready to receive a CPER when w=
e read
> > the bad pages, so send the CPERs at the end of RAs initialization to en=
sure that
> the
>
> [Tao] RAs -> RAS
>
> > FW is ready to receive and process the CPER. This removes the previous =
CPER
> > submission that was added during bad page load, and sends both in-band =
and out-
> > of-band at the same time.
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 ++
> >  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 27 ++++++++++++++++---
> >  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
> >  3 files changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index b28fcf932f7e..856b1bf83533 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -4650,6 +4650,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *ad=
ev)
> >                       amdgpu_ras_block_late_init_default(adev, &obj->ra=
s_comm);
> >       }
> >
> > +     amdgpu_ras_check_bad_page_status(adev);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > index 469d04a39d7d..91de4085a66d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > @@ -1712,10 +1712,6 @@ int amdgpu_ras_eeprom_check(struct
> > amdgpu_ras_eeprom_control *control)
> >                       dev_warn(adev->dev, "RAS records:%u exceeds 90%% =
of
> > threshold:%d",
> >                                       control->ras_num_bad_pages,
> >                                       ras->bad_page_cnt_threshold);
> > -             if (amdgpu_bad_page_threshold !=3D 0 &&
> > -                     control->ras_num_bad_pages >=3D ras-
> > >bad_page_cnt_threshold)
> > -                     amdgpu_dpm_send_rma_reason(adev);
> > -
> >       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
> >                  amdgpu_bad_page_threshold !=3D 0) {
> >               if (hdr->version >=3D RAS_TABLE_VER_V2_1) { @@ -1932,3
> > +1928,26 @@ int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device
> *adev,
> >                                                                        =
  result);
> >       return -EOPNOTSUPP;
> >  }
> > +
> > +void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev) {
> > +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> > +     struct amdgpu_ras_eeprom_control *control =3D ras ? &ras->eeprom_=
control
> > +: NULL;
> > +
> > +     if (!control || amdgpu_bad_page_threshold =3D=3D 0)
> > +             return;
> > +
> > +     if (control->ras_num_bad_pages >=3D ras->bad_page_cnt_threshold) =
{
> > +             if (amdgpu_dpm_send_rma_reason(adev))
> > +                     dev_warn(adev->dev, "Unable to send in-band RMA C=
PER");
>
> [Tao] this is oob cper and the following one is ib cper.
>
> With my concerns fixed, the patch is:  Reviewed-by: Tao Zhou
> <tao.zhou1@amd.com>
>
> > +             else
> > +                     dev_dbg(adev->dev, "Sent in-band RMA CPER");
> > +
> > +             if (adev->cper.enabled && !amdgpu_uniras_enabled(adev)) {
> > +                     if (amdgpu_cper_generate_bp_threshold_record(adev=
))
> > +                             dev_warn(adev->dev, "Unable to send out-o=
f-band
> > RMA CPER");
> > +                     else
> > +                             dev_dbg(adev->dev, "Sent out-of-band RMA =
CPER");
> > +             }
> > +     }
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > index 2e5d63957e71..a62114800a92 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > @@ -193,6 +193,8 @@ int amdgpu_ras_eeprom_read_idx(struct
> > amdgpu_ras_eeprom_control *control,
> >
> >  int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_contr=
ol
> > *control);
> >
> > +void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev);
> > +
> >  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops=
;
> >  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_op=
s;
> >
> > --
> > 2.43.0
>

