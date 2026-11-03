Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1483606A33A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3QiM4FlD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662BC10F6EE;
	Tue,  3 Nov 2026 16:29:31 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B224E10F6EE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 16:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHB0DCOmdlg4kaQnrgA0OFDUtVmRLowHivW7wDpLOwDXwYFGVWm0KPmWd4h3f0k+IoLgWcCTKViDTUmGx0b5S5XVbmLGD3xYme2j9YcXGJLSklIPr7XTUmoRvqXG0dDEyLDPJ0kXPmu2PiUShG3FGQvMpNpLxtUm0L+fU31MWUSZt0Wqb4QWq0WON+b/koN1Xkvq1mxouA8L1Tgqj3Jlg6rLsvmveuqUwU8I4PrtGZrIEYUb4ozp8nvcph4xsBFrLj5qOYslBwBaVAF0Ec+sijdc8XAKf5fNcVUDt3G+UVIdh8VR90B3CAptqB9bAGak0UWQKYSWcgOdC4YSNl5Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrbxhHW+qcgbfnieSgW0hepVfNh/bjEdxO7mS9EcfF8=;
 b=HoD+hAIC18AO45hJm4prY1I9rtAjlPzr6cKPoUfJxNm4WfUem+V0GaTUKpR67U9xhpBifmiCWXZk/hkW6d8oaZwKuxUD0INPlzRPSI53ogxHq9xqF8DgKXWhfL4HWRe8qujVgzxD3x7LMZ4Qv0ogZ0CtoDrW97T2zaLeY1oCNfAkklZnvY+TzTsuRCQFTUGaf09Rv4f+2k0kI/3zciQEvibS76poMIxlPgcMxDCyoiwbE1oN1q+EEGYZshyVXLnwC0/3GWB8QZirEM7jYryF1eg76zz87XHtfpIB8ycEzKTzwTrkyp/6j7zmstTj6vQeRR/4XpzX/7JVRd6DG9Nwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrbxhHW+qcgbfnieSgW0hepVfNh/bjEdxO7mS9EcfF8=;
 b=3QiM4FlDcWR6y6sYJPMgXTQIKk54+V/gnu/Lk8YQna41hbRdztQFG00ILlh+se0k8EAfTdHUE0c2aGNlfkd9kWwKrUVbfo2qVdSVR0Tx4UtCCAoR9FC2eizQeUzcYvRhKQ8qBXQM5NWzMW1jeAK6qCjmd6K89Hc7r5L7yUTtYeM=
Received: from MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 16:29:18 +0000
Received: from MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a]) by MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 16:29:18 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle
 work
Thread-Topic: [PATCH] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle
 work
Thread-Index: AQHda11uk1hyAseiU0SRjZHAvTJ8BrccigGg
Date: Tue, 3 Nov 2026 16:29:17 +0000
Message-ID: <MW6PR12MB70726AF4C919C07469E3D2EBE5692@MW6PR12MB7072.namprd12.prod.outlook.com>
References: <20261103063434.3102634-1-Prike.Liang@amd.com>
In-Reply-To: <20261103063434.3102634-1-Prike.Liang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-03T16:28:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7072:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: 76c1a346-e37d-4458-ee48-08df39c79b8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|366016|23010399003|1800799024|376014|6133799003|10067099003|18002099003|22082099003|261102123227099003|3023799007|38070700021|56012099006|261009221227099003|261028144727099003|5023799004|261009223027099003|11063799006|261026140227099003|261022105027099003|261026121527099003|261022075727099003|261009220027099003|261009221727099003|261009223327099003|261021121427099003|261021123027099003|260925021311599003|260925021911599003|260925022911599003;
x-microsoft-antispam-message-info: sJx14qUHJopJ+2LSh29Pi+ESs4g12KNjrjLZR28kjEWh58mJnIfIRAKYXoe3OYCT49+Z6vdU7++cBk4KZtaRbtQ+tkFXSDYMqI/VS70Uzsbmx+zHA7rEU2lbtullZx3cUCdsYRu7snTz9SaJ4ovGvI1EZu+GZdtUliPM+FAc5ad/W6NB9mY/WbKhgWPXPuAXqnMDzqx6+NTHuYJr1z9dYgDG875tbIVufkJkbK6L2USAJlIAxNyZSxPOTFfgPER4KrPw4FHk25OVZZtUJM/VFAeNT8FZlyy0ISeOrOlv9zCKRrjj7WOIHkvrSGCE76EokIVnrpjLkI4G9NQd6fvZ7cA5U+jWWSflhbZanpImVAH2Qkp8vW0MIdr9S1mVccHeXWrVym9y+K9NrJ8eQWeIsOly1qhntZM9L5HzCjryKO3HMkV55eOhRyNJC7D9Wrt7I7ck7IWHfNzh1suJzNPl7OzT6YQTRFYTKZ5JP+n6Qrd1USusjFLyTZPp7K6+US4g4J2vO1ksFdnx247v+j1gNm5u1o3VCAkV2heSsPiHITaUWBTyekrXb2FTsJqLCFFbX2rC9GVgOfYpWj2gA+zegJ0W3SFdRps8xzOpJ1tvKXJsL6A8Y9pMMVnmWRgwJ+SqyyHbycXl4EwUQwwB0dTYjsaBWleVTsBGSAQAIgxdeHM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(3023799007)(38070700021)(56012099006)(261009221227099003)(261028144727099003)(5023799004)(261009223027099003)(11063799006)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261009220027099003)(261009221727099003)(261009223327099003)(261021121427099003)(261021123027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BbGmmajsdzW7l3hXfueAaFqMBi9hoyEGzBdXqatboGSU/1BMOuCE4sZHJ9S/?=
 =?us-ascii?Q?5Jm6OikquP3tD20Fp0vnELRsvP9re2rjzsJ8miv2aA0QLiXE9niAtEfwcr7U?=
 =?us-ascii?Q?do2z+BrKxmft3tATxiEcyyQ7nbUCmChH0oaGxVL7oLgkjKyFQzHUhxkJCtHR?=
 =?us-ascii?Q?ibOhYjW3DyVWuD/3hcN6bZOApQ2RjSiSjdXU3MfUl3f9uCVp3psOz1+HbqqE?=
 =?us-ascii?Q?IJl4b6EIVb51X9u5lkv+mfpmQ1pKv8uSVURtGkmC8PP0gcII3cgdIyq2exnS?=
 =?us-ascii?Q?cwty9paLq3m932kdj9+FXuNQGv16W0Zvnjc442PRT8PtPehFztuboHzOVUZ9?=
 =?us-ascii?Q?GSdnjJi+xlZs8bNnM55FS+Uiv2kYHQ4J+QWyQcdKYfXbKGwLYp6hQo3xCRgk?=
 =?us-ascii?Q?f9QJ8POehcTpOsRP/C/C3rOiCsspEwj2F4ze3bsspKH1cLsFNViXYxdzZ4mU?=
 =?us-ascii?Q?EJlM7HXBTwYcvMul6RdAgv6CEc0F3Yu0pY6WzdQDL8ys2H2FaUEBGpz+kJUE?=
 =?us-ascii?Q?4wiIOS7VsMFrLlFNz17C2pi0Mo7ZVlqKHtD4hbp8/9+Dc91nH3Yp1bU1VWPy?=
 =?us-ascii?Q?6yWtZKdY7yBAculaUEy40SRaH/18O35iNZaquusfED2odqoxLNr/Fb25FT07?=
 =?us-ascii?Q?ZntaxvHGkpT1/YNUKnJMRMXhjK2FQHVwyp9LVZw054CCTZymkf5ZsyHPrKwM?=
 =?us-ascii?Q?I6GZ4XOY5eG6VeZ8HvIXvSmBxyJLD5cckoGvEfMxyNteS6ZblVPybXOtHGfY?=
 =?us-ascii?Q?W4HHnqwtETnYi1RW1C2N3SU7V2ByNjRHq/wUW32Cw/S4LKKU55u/JjFKJGrE?=
 =?us-ascii?Q?mzsjJQ4T4leh54EWOVDU7ZK7C9jjhZIX3GcVW3PXFKcB8U+MZKGP+gG0x2rD?=
 =?us-ascii?Q?AwUatoafp+OX7jSR/IG8WpnjQ2DVTtIhsma63fgLWCI/6sPzOO4I+a08HtDI?=
 =?us-ascii?Q?paIJOTeBbm7udV6kUyX/9qcT/ONKp2cBr4n7mGw47cdnBV0Y0iZkscgtIc48?=
 =?us-ascii?Q?xR0p/2lyfJsJZdUax36Dh2fhthF5iByBXU0hvG7jvnTiimnNjOdEb0920jac?=
 =?us-ascii?Q?ffrSXjOI8gMKfScHMamBvqkm/gTuhRWZlRRuE/DawO3plYjBCx/lGx1qV9Kg?=
 =?us-ascii?Q?8lJcCJR5aVrUoVi2dkNze57lO3LsQfq1W+jZA75HEhoZItSgJG9I/ZPTtJ0e?=
 =?us-ascii?Q?zncCnsBRIwQgrIO3Xvq+I/kMqyUwW7rl+NBwl6Rl1dIf9b7BjDStpjOFsFIO?=
 =?us-ascii?Q?YNLN7aAEM1088fJ0RalzqqWPaHlauQpv2BycdSYWG5T83Gk3GWTsOT3qwT5w?=
 =?us-ascii?Q?YP2SWfNbX3tttlH5TuppS9VH9Yrj3ErM/ZW6x3Ns7RC3gYDPrJyvHclSaNts?=
 =?us-ascii?Q?nqEeihDnO9Ttveb4ydIwZxsNrZ6BuU/mm9JYYhSAD716QE3HhRVvoA2lDRV0?=
 =?us-ascii?Q?ZwRFjFEIbQ1AG3sxWLsItMDAYeWYsx+xcgAlMAmiwQUY7fOjvwFk+G2a4Ml3?=
 =?us-ascii?Q?nIG1CZhq/dQHNncSqWH6ZQ2sGtlVIvzV9Q0bPkS8vKxt2Rv8YlZw//iJjMcb?=
 =?us-ascii?Q?1DtLNH58lMOuolb9FQDjsP81av1YzKvCtY/Oo6PDd5vnbH5nEJgmjApIMgKV?=
 =?us-ascii?Q?5QK7mmk2wIwCIWCNUc7kRT9z9mRsr2wIfPXQ527sD/G1snnRCIWsk8nEiAzm?=
 =?us-ascii?Q?heEwRjohBXX6H4A2fyEVvTRHhzVC84IVtWk9tcQqVxH+XU7C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c1a346-e37d-4458-ee48-08df39c79b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 16:29:18.0465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUY+e0x6Ie8aBWUtYT2b0NGpcnRTPhHt71ed1e5KWHVon7swx7pg4jn4+WHc2TRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, November 3, 2026 1:35 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Liang, Prike <Prike.Liang@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Lazar, Li=
jo
> <Lijo.Lazar@amd.com>
> Subject: [PATCH] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle
> work
>
> The common JPEG and VCN idle workers program power gating and DPG pause,
> so they must not run while a GPU reset is in progress. Recovery must not =
wait for
> them either, since everything the workers depend on then becomes a
> dependency of GPU recovery.
>
> Make the workers take reset_domain->sem for read, so they wait for a runn=
ing
> reset instead of touching the hardware. hw_fini/suspend, the hw_init erro=
r paths
> and begin_use, the latter for the IB tests, run from GPU recovery as well=
, so only
> skip waiting for the idle work when the reset itself calls them. The rese=
t holds the
> semaphore for write and would otherwise deadlock on a worker blocked on i=
t.
> Outside a reset the cancel stays synchronous as before.
>
> A device can also be torn down while a peer in its XGMI reset domain is b=
eing
> reset. hw_fini then doesn't wait for the worker either, and is skipped en=
tirely if
> the peer's reset has already suspended the device.
> Cancel the idle work synchronously in early_fini, which only runs on tear=
down
> and before any hw_fini, so the worker is done before the hardware it touc=
hes is
> torn down.
>
> Teardown has drained the rings before early_fini, so nothing queues the w=
ork
> again and hw_fini only cancels it outside teardown, for suspend and GPU r=
eset.
> The JPEG suspend and sw_fini callbacks no longer cancel it a second time;=
 replace
> amdgpu_jpeg_suspend(), which only did that, with
> amdgpu_jpeg_cancel_idle_work() as on the VCN side.
>
> Update versions:
> v1: https://lists.freedesktop.org/archives/amd-gfx/2026-October/155441.ht=
ml
> v2: https://lists.freedesktop.org/archives/amd-gfx/2026-October/156119.ht=
ml
> v3: https://lists.freedesktop.org/archives/amd-gfx/2026-November/156456.h=
tml
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Cc: Leo Liu <leo.liu@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 25 ++++++++++++++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  3 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 36
> +++++++++++++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |
> 2 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 23 +++++----------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 24 ++++++----------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 23 +++++----------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 24 ++++++----------
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 23 +++++----------
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 23 +++++----------
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 23 +++++----------
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 24 +++++-----------
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 24 +++++-----------
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 23 +++++----------
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  7 +++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  7 +++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  7 +++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  7 +++--
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  7 +++--
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  7 +++--
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  8 ++++--
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  8 ++++--
>  24 files changed, 179 insertions(+), 187 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 2b0e658b63b6..ec3833c79a01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -95,13 +95,27 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>       return 0;
>  }
>
> -int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
> +int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block)
>  {
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Called on teardown even if sw_init never ran */
> +     if (!ip_block->status.sw)
> +             return 0;
> +
> +     /* hw_fini may not wait while a peer in the reset domain resets */
> +     cancel_delayed_work_sync(&ip_block->adev->jpeg.idle_work);
>
>       return 0;
>  }
>
> +void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev) {
> +     /* The reset mustn't wait for the idle work, which waits for the re=
set */
> +     if (amdgpu_in_reset(adev))
> +             cancel_delayed_work(&adev->jpeg.idle_work);
> +     else
> +             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +}
> +
>  int amdgpu_jpeg_resume(struct amdgpu_device *adev)  {
>       return 0;
> @@ -114,6 +128,9 @@ static void amdgpu_jpeg_idle_work_handler(struct
> work_struct *work)
>       unsigned int fences =3D 0;
>       unsigned int i, j;
>
> +     /* Nothing holding the reset semaphore waits for this work */
> +     down_read(&adev->reset_domain->sem);
> +
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1U << i))
>                       continue;
> @@ -129,6 +146,8 @@ static void amdgpu_jpeg_idle_work_handler(struct
> work_struct *work)
>               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>       } else
>               schedule_delayed_work(&adev->jpeg.idle_work,
> JPEG_IDLE_TIMEOUT);
> +
> +     up_read(&adev->reset_domain->sem);
>  }
>
>  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring) @@ -136,7 +155=
,7
> @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>       struct amdgpu_device *adev =3D ring->adev;
>
>       if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       mutex_lock(&adev->jpeg.jpeg_pg_lock);
>       amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_JPEG, diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index 05d58e6bbfab..9c4f251e03f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -156,11 +156,12 @@ struct amdgpu_jpeg {
>
>  int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);  int
> amdgpu_jpeg_sw_fini(struct amdgpu_device *adev); -int
> amdgpu_jpeg_suspend(struct amdgpu_device *adev);
> +int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block);
>  int amdgpu_jpeg_resume(struct amdgpu_device *adev);
>
>  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring);  void
> amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev);
>
>  int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring);  int
> amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout); dif=
f --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 34e1242d66ea..6c12d8aa3c76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -299,6 +299,26 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev,
> int i)
>       mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>  }
>
> +int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block) {
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +     int i;
> +
> +     /* Called on teardown even if sw_init never ran */
> +     if (!ip_block->status.sw)
> +             return 0;
> +
> +     /* hw_fini may not wait while a peer in the reset domain resets */
> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +             if (adev->vcn.harvest_config & (1 << i))
> +                     continue;
> +
> +             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     }
> +
> +     return 0;
> +}
> +
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum
> vcn_ring_type type, uint32_t vcn_instance)  {
>       bool ret =3D false;
> @@ -459,6 +479,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device
> *adev)
>       mutex_unlock(&adev->vcn.workload_profile_mutex);
>  }
>
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst) {
> +     /* The reset mustn't wait for the idle work, which waits for the re=
set */
> +     if (amdgpu_in_reset(vcn_inst->adev))
> +             cancel_delayed_work(&vcn_inst->idle_work);
> +     else
> +             cancel_delayed_work_sync(&vcn_inst->idle_work);
> +}
> +
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)  {
>       struct amdgpu_vcn_inst *vcn_inst =3D
> @@ -470,6 +499,9 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       if (adev->vcn.harvest_config & (1 << i))
>               return;
>
> +     /* Nothing holding the reset semaphore waits for this work */
> +     down_read(&adev->reset_domain->sem);
> +
>       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>               fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst-
> >ring_enc[j]);
>
> @@ -499,6 +531,8 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       } else {
>               schedule_delayed_work(&vcn_inst->idle_work,
> VCN_IDLE_TIMEOUT);
>       }
> +
> +     up_read(&adev->reset_domain->sem);
>  }
>
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring) @@ -507,7 +541,=
7
> @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>       struct amdgpu_vcn_inst *vcn_inst =3D &adev->vcn.inst[ring->me];
>
>       if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> -             cancel_delayed_work_sync(&vcn_inst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vcn_inst);
>
>       mutex_lock(&vcn_inst->vcn_pg_lock);
>       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bea95307fd42..509c83799a8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -522,10 +522,12 @@ enum vcn_ring_type {  int
> amdgpu_vcn_early_init(struct amdgpu_device *adev, int i);  int
> amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i);  void
> amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
> +int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);  int
> amdgpu_vcn_resume(struct amdgpu_device *adev, int i);  void
> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);  void
> amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
>
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
>                               enum vcn_ring_type type, uint32_t
> vcn_instance); diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index f03c1a37c8dd..2f1ce3096020 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -131,17 +131,13 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       int r;
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>
>       r =3D amdgpu_jpeg_sw_fini(adev);
> @@ -166,7 +162,7 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +             amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -181,7 +177,9 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) @@ -199,15
> +197,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   */
>  static int jpeg_v2_0_suspend(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D jpeg_v2_0_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> -
> -     return r;
> +     return jpeg_v2_0_hw_fini(ip_block);
>  }
>
>  /**
> @@ -792,6 +782,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs =
=3D {
>       .early_init =3D jpeg_v2_0_early_init,
>       .sw_init =3D jpeg_v2_0_sw_init,
>       .sw_fini =3D jpeg_v2_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v2_0_hw_init,
>       .hw_fini =3D jpeg_v2_0_hw_fini,
>       .suspend =3D jpeg_v2_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 46293664fd28..966a8a7f28ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -181,17 +181,13 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block
> *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       int r;
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>
>       r =3D amdgpu_jpeg_sw_fini(adev);
> @@ -227,7 +223,7 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -243,7 +239,9 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int i;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1 << i)) @@ -269,15 +267,7=
 @@
> static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   */
>  static int jpeg_v2_5_suspend(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D jpeg_v2_5_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> -
> -     return r;
> +     return jpeg_v2_5_hw_fini(ip_block);
>  }
>
>  /**
> @@ -665,6 +655,7 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs =
=3D {
>       .early_init =3D jpeg_v2_5_early_init,
>       .sw_init =3D jpeg_v2_5_sw_init,
>       .sw_fini =3D jpeg_v2_5_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v2_5_hw_init,
>       .hw_fini =3D jpeg_v2_5_hw_fini,
>       .suspend =3D jpeg_v2_5_suspend,
> @@ -681,6 +672,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs =
=3D {
>       .early_init =3D jpeg_v2_5_early_init,
>       .sw_init =3D jpeg_v2_5_sw_init,
>       .sw_fini =3D jpeg_v2_5_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v2_5_hw_init,
>       .hw_fini =3D jpeg_v2_5_hw_fini,
>       .suspend =3D jpeg_v2_5_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 361d0f4b4bc7..d7b664e25202 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -146,17 +146,13 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int r;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>
>       r =3D amdgpu_jpeg_sw_fini(adev);
> @@ -181,7 +177,7 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +             amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -196,7 +192,9 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) @@ -214,15
> +212,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   */
>  static int jpeg_v3_0_suspend(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D jpeg_v3_0_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> -
> -     return r;
> +     return jpeg_v3_0_hw_fini(ip_block);
>  }
>
>  /**
> @@ -564,6 +554,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs =
=3D {
>       .early_init =3D jpeg_v3_0_early_init,
>       .sw_init =3D jpeg_v3_0_sw_init,
>       .sw_fini =3D jpeg_v3_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v3_0_hw_init,
>       .hw_fini =3D jpeg_v3_0_hw_fini,
>       .suspend =3D jpeg_v3_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 4e8eed2b62db..6dc01f57847b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -157,17 +157,13 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int r;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>       r =3D amdgpu_jpeg_sw_fini(adev);
>
> @@ -210,7 +206,7 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -225,7 +221,10 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
> +
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>                       RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS)) @@ -
> 246,15 +245,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>   */
>  static int jpeg_v4_0_suspend(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D jpeg_v4_0_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> -
> -     return r;
> +     return jpeg_v4_0_hw_fini(ip_block);
>  }
>
>  /**
> @@ -748,6 +739,7 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs =
=3D {
>       .early_init =3D jpeg_v4_0_early_init,
>       .sw_init =3D jpeg_v4_0_sw_init,
>       .sw_fini =3D jpeg_v4_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v4_0_hw_init,
>       .hw_fini =3D jpeg_v4_0_hw_fini,
>       .suspend =3D jpeg_v4_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 9f298c4ea8ff..0997c949c125 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -248,17 +248,13 @@ static int jpeg_v4_0_3_sw_init(struct
> amdgpu_ip_block *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int r;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>
>       r =3D amdgpu_jpeg_sw_fini(adev);
> @@ -443,7 +439,7 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -459,7 +455,9 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) @@ -481,15
> +479,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block=
)
>   */
>  static int jpeg_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D jpeg_v4_0_3_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> -
> -     return r;
> +     return jpeg_v4_0_3_hw_fini(ip_block);
>  }
>
>  /**
> @@ -1227,6 +1217,7 @@ static const struct amd_ip_funcs
> jpeg_v4_0_3_ip_funcs =3D {
>       .early_init =3D jpeg_v4_0_3_early_init,
>       .sw_init =3D jpeg_v4_0_3_sw_init,
>       .sw_fini =3D jpeg_v4_0_3_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v4_0_3_hw_init,
>       .hw_fini =3D jpeg_v4_0_3_hw_fini,
>       .suspend =3D jpeg_v4_0_3_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index a1496412810c..11718e3f19a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -191,17 +191,13 @@ static int jpeg_v4_0_5_sw_init(struct
> amdgpu_ip_block *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int r;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>       r =3D amdgpu_jpeg_sw_fini(adev);
>
> @@ -238,7 +234,7 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -254,7 +250,9 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int i;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1 << i)) @@ -278,15 +276,7=
 @@
> static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   */
>  static int jpeg_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D jpeg_v4_0_5_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> -
> -     return r;
> +     return jpeg_v4_0_5_hw_fini(ip_block);
>  }
>
>  /**
> @@ -807,6 +797,7 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs=
 =3D
> {
>       .early_init =3D jpeg_v4_0_5_early_init,
>       .sw_init =3D jpeg_v4_0_5_sw_init,
>       .sw_fini =3D jpeg_v4_0_5_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v4_0_5_hw_init,
>       .hw_fini =3D jpeg_v4_0_5_hw_fini,
>       .suspend =3D jpeg_v4_0_5_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index 1a4594d5d952..88e78dc498bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -135,17 +135,13 @@ static int jpeg_v5_0_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int r;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>       r =3D amdgpu_jpeg_sw_fini(adev);
>
> @@ -178,7 +174,7 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -193,7 +189,9 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS)) @@ -211,15 +209,7
> @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   */
>  static int jpeg_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D jpeg_v5_0_0_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> -
> -     return r;
> +     return jpeg_v5_0_0_hw_fini(ip_block);
>  }
>
>  /**
> @@ -683,6 +673,7 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs=
 =3D
> {
>       .early_init =3D jpeg_v5_0_0_early_init,
>       .sw_init =3D jpeg_v5_0_0_sw_init,
>       .sw_fini =3D jpeg_v5_0_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v5_0_0_hw_init,
>       .hw_fini =3D jpeg_v5_0_0_hw_fini,
>       .suspend =3D jpeg_v5_0_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index efdc537ec81e..f666b48e34c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -240,17 +240,13 @@ static int jpeg_v5_0_1_sw_init(struct
> amdgpu_ip_block *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int r;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>
>       r =3D amdgpu_jpeg_sw_fini(adev);
> @@ -314,7 +310,7 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -330,7 +326,9 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) @@ -352,16
> +350,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block=
)
>   */
>  static int jpeg_v5_0_1_suspend(struct amdgpu_ip_block *ip_block)  {
> -     struct amdgpu_device *adev =3D ip_block->adev;
> -     int r;
> -
> -     r =3D jpeg_v5_0_1_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(adev);
> -
> -     return r;
> +     return jpeg_v5_0_1_hw_fini(ip_block);
>  }
>
>  /**
> @@ -887,6 +876,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs=
 =3D
> {
>       .late_init =3D NULL,
>       .sw_init =3D jpeg_v5_0_1_sw_init,
>       .sw_fini =3D jpeg_v5_0_1_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v5_0_1_hw_init,
>       .hw_fini =3D jpeg_v5_0_1_hw_fini,
>       .suspend =3D jpeg_v5_0_1_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index eb3dc9558e0d..af1feba68dc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -206,17 +206,13 @@ static int jpeg_v5_0_2_sw_init(struct
> amdgpu_ip_block *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int r;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>
>       r =3D amdgpu_jpeg_sw_fini(adev);
> @@ -287,7 +283,7 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -303,7 +299,9 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) @@ -322,16
> +320,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block=
)
>   */
>  static int jpeg_v5_0_2_suspend(struct amdgpu_ip_block *ip_block)  {
> -     struct amdgpu_device *adev =3D ip_block->adev;
> -     int r;
> -
> -     r =3D jpeg_v5_0_2_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(adev);
> -
> -     return r;
> +     return jpeg_v5_0_2_hw_fini(ip_block);
>  }
>
>  /**
> @@ -871,6 +860,7 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs=
 =3D
> {
>       .late_init =3D NULL,
>       .sw_init =3D jpeg_v5_0_2_sw_init,
>       .sw_fini =3D jpeg_v5_0_2_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v5_0_2_hw_init,
>       .hw_fini =3D jpeg_v5_0_2_hw_fini,
>       .suspend =3D jpeg_v5_0_2_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 0cbb2b8a7e78..71011c5e2adb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -118,17 +118,13 @@ static int jpeg_v5_3_0_sw_init(struct
> amdgpu_ip_block *ip_block)
>   *
>   * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
>   *
> - * JPEG suspend and free up sw allocation
> + * Free up JPEG sw allocation
>   */
>  static int jpeg_v5_3_0_sw_fini(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int r;
>
> -     r =3D amdgpu_jpeg_suspend(adev);
> -     if (r)
> -             return r;
> -
>       amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>       r =3D amdgpu_jpeg_sw_fini(adev);
>
> @@ -161,7 +157,7 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>       return r;
>  }
>
> @@ -176,7 +172,9 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS)) @@ -
> 194,15 +192,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>   */
>  static int jpeg_v5_3_0_suspend(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D jpeg_v5_3_0_hw_fini(ip_block);
> -     if (r)
> -             return r;
> -
> -     r =3D amdgpu_jpeg_suspend(ip_block->adev);
> -
> -     return r;
> +     return jpeg_v5_3_0_hw_fini(ip_block);
>  }
>
>  /**
> @@ -671,6 +661,7 @@ static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs=
 =3D
> {
>       .early_init =3D jpeg_v5_3_0_early_init,
>       .sw_init =3D jpeg_v5_3_0_sw_init,
>       .sw_fini =3D jpeg_v5_3_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v5_3_0_hw_init,
>       .hw_fini =3D jpeg_v5_3_0_hw_fini,
>       .suspend =3D jpeg_v5_3_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index b3e63d6e79a8..897310d04f83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       if (r)
>               return r;
>
> -     /* Override the work func */
> -     adev->vcn.inst[0].idle_work.work.func =3D vcn_v1_0_idle_work_handle=
r;
> +     /* Own lockdep class, this work is still cancelled synchronously */
> +     INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work,
> +vcn_v1_0_idle_work_handler);
>
>       amdgpu_vcn_setup_ucode(adev, 0);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 12ac20484396..290cd715ca32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -310,7 +310,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> +     amdgpu_vcn_cancel_idle_work(adev->vcn.inst);
>       return r;
>  }
>
> @@ -326,7 +326,9 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       struct amdgpu_vcn_inst *vinst =3D adev->vcn.inst;
>
> -     cancel_delayed_work_sync(&vinst->idle_work);
> +     /* Teardown cancelled it synchronously in early_fini */
> +     if (!adev->shutdown)
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>           (vinst->cur_state !=3D AMD_PG_STATE_GATE && @@ -2103,6 +2105,7
> @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs =3D {
>       .early_init =3D vcn_v2_0_early_init,
>       .sw_init =3D vcn_v2_0_sw_init,
>       .sw_fini =3D vcn_v2_0_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v2_0_hw_init,
>       .hw_fini =3D vcn_v2_0_hw_fini,
>       .suspend =3D vcn_v2_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 2b2abe689508..c3f2265f50fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block
> *ip_block)
>               if (r)
>                       return r;
>
> -             /* Override the work func */
> -             adev->vcn.inst[j].idle_work.work.func =3D
> vcn_v2_5_idle_work_handler;
> +             /* Own lockdep class, this work is still cancelled synchron=
ously
> */
> +             INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work,
> +vcn_v2_5_idle_work_handler);
>
>               amdgpu_vcn_setup_ucode(adev, j);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 6543f21daa1e..2f7d5d562cb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -433,7 +433,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev-
> >vcn.inst[i].idle_work);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -457,7 +457,9 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             /* Teardown cancelled it synchronously in early_fini */
> +             if (!adev->shutdown)
> +                     amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -2366,6 +2368,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs =
=3D
> {
>       .early_init =3D vcn_v3_0_early_init,
>       .sw_init =3D vcn_v3_0_sw_init,
>       .sw_fini =3D vcn_v3_0_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v3_0_hw_init,
>       .hw_fini =3D vcn_v3_0_hw_fini,
>       .suspend =3D vcn_v3_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 8b5646297c2e..12be9a2b2efc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -358,7 +358,7 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev-
> >vcn.inst[i].idle_work);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -382,7 +382,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             /* Teardown cancelled it synchronously in early_fini */
> +             if (!adev->shutdown)
> +                     amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -2287,6 +2289,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs =
=3D
> {
>       .early_init =3D vcn_v4_0_early_init,
>       .sw_init =3D vcn_v4_0_sw_init,
>       .sw_fini =3D vcn_v4_0_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v4_0_hw_init,
>       .hw_fini =3D vcn_v4_0_hw_fini,
>       .suspend =3D vcn_v4_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 0c58ca25d7b5..a82607a4f847 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -404,7 +404,7 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev-
> >vcn.inst[i].idle_work);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -425,7 +425,9 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             /* Teardown cancelled it synchronously in early_fini */
> +             if (!adev->shutdown)
> +                     amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE); @@ -
> 2035,6 +2037,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs =
=3D {
>       .late_init =3D vcn_v4_0_3_late_init,
>       .sw_init =3D vcn_v4_0_3_sw_init,
>       .sw_fini =3D vcn_v4_0_3_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v4_0_3_hw_init,
>       .hw_fini =3D vcn_v4_0_3_hw_fini,
>       .suspend =3D vcn_v4_0_3_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index a6eaa57ec2ee..f5195b3ad0a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -311,7 +311,7 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev-
> >vcn.inst[i].idle_work);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -335,7 +335,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             /* Teardown cancelled it synchronously in early_fini */
> +             if (!adev->shutdown)
> +                     amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -1690,6 +1692,7 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_func=
s
> =3D {
>       .early_init =3D vcn_v4_0_5_early_init,
>       .sw_init =3D vcn_v4_0_5_sw_init,
>       .sw_fini =3D vcn_v4_0_5_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v4_0_5_hw_init,
>       .hw_fini =3D vcn_v4_0_5_hw_fini,
>       .suspend =3D vcn_v4_0_5_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 055729a42094..5ceb96228cf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -275,7 +275,7 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev-
> >vcn.inst[i].idle_work);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -299,7 +299,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             /* Teardown cancelled it synchronously in early_fini */
> +             if (!adev->shutdown)
> +                     amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -1476,6 +1478,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_func=
s
> =3D {
>       .early_init =3D vcn_v5_0_0_early_init,
>       .sw_init =3D vcn_v5_0_0_sw_init,
>       .sw_fini =3D vcn_v5_0_0_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v5_0_0_hw_init,
>       .hw_fini =3D vcn_v5_0_0_hw_fini,
>       .suspend =3D vcn_v5_0_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 55a4b2f9463f..e7453d98cd0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -351,7 +351,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev-
> >vcn.inst[i].idle_work);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -372,7 +372,10 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +             /* Teardown cancelled it synchronously in early_fini */
> +             if (!adev->shutdown)
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> +
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>       }
> @@ -1660,6 +1663,7 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_func=
s
> =3D {
>       .late_init =3D vcn_v5_0_1_late_init,
>       .sw_init =3D vcn_v5_0_1_sw_init,
>       .sw_fini =3D vcn_v5_0_1_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v5_0_1_hw_init,
>       .hw_fini =3D vcn_v5_0_1_hw_fini,
>       .suspend =3D vcn_v5_0_1_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ea6cdbcb6352..2f4aed8cd1ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -266,7 +266,7 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev-
> >vcn.inst[i].idle_work);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -287,7 +287,10 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +             /* Teardown cancelled it synchronously in early_fini */
> +             if (!adev->shutdown)
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
> +
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>       }
> @@ -1451,6 +1454,7 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_func=
s
> =3D {
>       .late_init =3D NULL,
>       .sw_init =3D vcn_v5_0_2_sw_init,
>       .sw_fini =3D vcn_v5_0_2_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v5_0_2_hw_init,
>       .hw_fini =3D vcn_v5_0_2_hw_fini,
>       .suspend =3D vcn_v5_0_2_suspend,
> --
> 2.34.1

