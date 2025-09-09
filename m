Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF7CAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 15:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD42410E25C;
	Tue,  9 Sep 2025 15:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SefeJzG6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5A510E25C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 15:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDxq71TS2dxpoIn5wytAqW1GfceoOp40aj9VrCGM/DRwpTfmIqYMNFOwoRN/lLibRNse+cmYIDW2LnSzB+4mmijLYJV9/sMVpr37T08jdpYD89sKCWgmF0JJwrQ/K+jDdLbkeX3D1QOPSnIfhp5M/J+ZyfI4gJMTyhV5jY79YSJxmBsBQpQDQrgu02fxzOf6bra7hotyQqCfgvtYRk7/g6cDxXrXjRDSJErIVmCURnGVZrDrl+o2lSVnZtEqZF1H1klfH1N1TCzFJ/SrHVmbklHVsfsqIyKeV4L9C3zYZXmIn2T/BwXOL+uohCMQGpLAeGwEMZN6u1EeV2j9p9U8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkKtsrs50oEZvPIXGhoFvWBTFf3td4TAnzON2kja1rc=;
 b=KTev5n7c/8clapsOco3KQxe3SkJiMzfcH5NgFjF5g5E+TGwEFOeBUTjIsFU1/3T/MDlN5XCJ3/CLidwI12FcXH8jOgQt0Q1KxSv101NVN2sOHNQCHGcXvY4NPXHho2H8tiKrQe1oZYiDIgT6xiWe+WjyEXmkLZoJYAbae/u8r5qOrttgxkBQTZJK3hCqAqNPlQl9qVCLnp06rMrjjHDf3dHYNXko8hhQWCrW6LqM7j0qlkKNO9m/js6S8CRh5FbsyOal6abZk2dDUdqv4opCLymOK5hqZRqGeNOeht2eYXQa1U4ToVOsYVypSYQZVD+VSHKaudhWyNXZ2WuCgsFiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkKtsrs50oEZvPIXGhoFvWBTFf3td4TAnzON2kja1rc=;
 b=SefeJzG6OccNsLLwMHENpZvyZwijnR/xA3OECe2yhcdEbwx0yuSUPrhfYQk2nDpo4w/WfdByQeTRS91PDYlHSrK5/V/IkKIY6FAg4KvAM9fgY7/EfYi5MnLi5W4Le6f2jGqpqVL54qpdw5e7ZsLNLPfZisWnlt+2y2L0SkN2jhU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:57:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:57:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH v2 0/7] Add field encoding to gpu metrics fields
Thread-Topic: [PATCH v2 0/7] Add field encoding to gpu metrics fields
Thread-Index: AQHcILAhO8jyBDluFkGpdaiO1IWxL7SLA1WA
Date: Tue, 9 Sep 2025 15:57:19 +0000
Message-ID: <BN9PR12MB525744EE144D7B341216A923FC0FA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250908110231.2888628-1-lijo.lazar@amd.com>
In-Reply-To: <20250908110231.2888628-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: KevinYang.Wang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-09T15:56:50.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB8145:EE_
x-ms-office365-filtering-correlation-id: 5cceed1a-1d62-4ad3-cd7d-08ddefb98eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?L3CyCdyIa3kAch2rz8gDK3qb7XI7GhhqPGGGq/XsxgpltCYSkACnEt8+7ydV?=
 =?us-ascii?Q?1dhMKwQYjohyd92p+g4sxbaryInySR2q8FTZQJGOubcSNds29opURqJk+R65?=
 =?us-ascii?Q?VxfSLtgV69bfMC5mQ8a3egIngXxZ65rzhbHwreBymY/0u98NIT9MZJOZJoHw?=
 =?us-ascii?Q?/Blt4q/dGaHMvS0K/UzzYqVuUSKimybfgUeJSboMRwreRDo/UQkN4RyYJn66?=
 =?us-ascii?Q?9EB3O9cXwLypgZpV+iPfd6LNlvpAlkx+vyjEOG9BXUqpWwheVD0NX0f3Mjx1?=
 =?us-ascii?Q?taTrpxnH63YuCROxaibm76xUgpfjp1rdzBKHi2+SXyCFyGeUaUfEvUDHzyjc?=
 =?us-ascii?Q?iJcgREfj2zaMc0U1eTWoMpfYHn3NrZau/dBfoUIqomwWjsBmqFgyfu1IDaFW?=
 =?us-ascii?Q?0iEVGFT/R/pMZA377j7QA7aA5tXiaHD+wEKtRVoPbK7V/mN7vP0aJO2OaCHw?=
 =?us-ascii?Q?jrndj9NfnTscQG9Xctzz1yuTn6Ez9SYjttuCBs4yp+utTdK20n+PqTJ/Fd8j?=
 =?us-ascii?Q?OlPo3rj4j/1E3v4FDlerLxnpRlxcuhpwt6OvGk7/wBli1KPr6p+rz+I9Urzd?=
 =?us-ascii?Q?OcyQV5bD591ikH93gW8Sg3wHU8ognjtw/S373vKKDwwqHG/2AeEP4JbTdW1i?=
 =?us-ascii?Q?qmZhPscmxjABWPYJRC7UPjO/S5qOZbazkJtgjBcSzBotl9gJqEGi5q0k/zJH?=
 =?us-ascii?Q?+HHExNIvUJ0V99PmtPsZcmHhtupApkQUavOxjKL2M7kmjy3kBWPulZTWuyTF?=
 =?us-ascii?Q?95EAXOd/ibD6VWm1lbtKlY1n4+WODWo2OROY9FG9FSMoFhAbT3cTfm+jGxR7?=
 =?us-ascii?Q?KzXT0Lg9we858jPDPzclOfIvXUSkOfvw1qsFyC3WWUg6bF6V3UWNbQlPgXKT?=
 =?us-ascii?Q?S0OP25nCgZY1Qmk45cRUc/EbzX2D7fjyze39s7rNsMgyn4XEI9HUmfx+l2u0?=
 =?us-ascii?Q?BYO0o9ZZpABsHRRSqVqV8KZxkQHEIA4wFKWZZk4DilkEK5lMg4NM6OUoItJ7?=
 =?us-ascii?Q?GbbBJrH4RdJJoixerJ620ML0e+lQ9Bg/VdTTbPCt8haRs2r4KkeSW43DwUJD?=
 =?us-ascii?Q?Zx/hZrThvMJ/rpaC97vC0yYJqt92IUifhqBXc40pTvHxJ7n1wKsutckQhIh6?=
 =?us-ascii?Q?yTSChbfcc1AOu8KJXHmn92cnlVnSQrrTA8GanwKvSMK7d9lVUvuhRfc1BDIo?=
 =?us-ascii?Q?HSOvAmQoCI9/R+SbfOfxfOYnje+5YxUPwNbC0Fpb31RRGOTAbc/pQ+07X1wW?=
 =?us-ascii?Q?mD/qw2n4LbGWJ84KtL3+L7hXRzU2ZJxiZSRlDMCh/YW0VXQc6n19gFd/KPcJ?=
 =?us-ascii?Q?9T5AB1JhfNqlLOAAr43Iq6BfDnHiDE1AxkBJq+M/DYt4lPLrFChAHNTdcZWa?=
 =?us-ascii?Q?7+htdgDVsg98l1JfI4aJ8cdkju+vswgSknwyWvnf+kAnLdu0Var6i65cDuvW?=
 =?us-ascii?Q?1MxdygXFWLaboYUibxxX1/iaym39iig6o1leRxM93G42XJX/4Y8Uqp9HibKb?=
 =?us-ascii?Q?tfwms1AvSCxL/Rg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8tUpKkdYh43MMvcLdWmInv1lir9xCM2ECDpo9qiPFIemSPLwUZYMZFLQwUlI?=
 =?us-ascii?Q?rSmF4SOvhXZwco+Q/2cMlMPBAl8q7exIrFIBR6WzXCV9sTNr6mEJoLzIeXN8?=
 =?us-ascii?Q?jnJcAqSK/gxQ93c6nWuxyevMdLC2Y+7QO2zQ76PL9/PD3yWGdbdFgbNemSp1?=
 =?us-ascii?Q?w009pBBHe+8CGL79a5c1JHzpZUg1/nAF98epSY0A0E75IzbeocyOItnzWtTt?=
 =?us-ascii?Q?4dH1s9pNM217G+Km8hiEO+hiSUaraGxsgDDlYshEOAU1mxWxAqBAwliS4JkH?=
 =?us-ascii?Q?oZwTJY59kee6U8Q012zIcSEDn5DtCMaV3EqxgFBRMVvgGMrUlS2CL3oC6lCi?=
 =?us-ascii?Q?9FzIKI81RHMaRGx0NjAke0gJPkQnx7D3PyKW08L/5eULYFMYZ/NDvq8vs/6t?=
 =?us-ascii?Q?79XuojYcclB3TyWhMhgs9M304MRJV4ns0npY1SWSbrS8Wx9gRNukPEgiRn9Q?=
 =?us-ascii?Q?1+rrsFb5eTnl6H6MRFkX/zNpRxw2N1rt/9yPJhKqV3+2F3aH96J1RywFru9Y?=
 =?us-ascii?Q?4+/Yhdv++PboBfEvwE6bsnZ3feNhBtNnPCOXMRvPxnQ3EArZ7DAWcouZaz2E?=
 =?us-ascii?Q?fuHYs3lYQmMD+RzTxDWojKP10Dz59uX8mDsYkqPr5B4rg5zU4yms4v8TMWP1?=
 =?us-ascii?Q?y6/szf9atEfmtzC0phcoD6Ti25RZHA7OJx9qMS95aRWCw9aYQ2h6OThAEaPJ?=
 =?us-ascii?Q?lz8RWR+dHB1u2KEA9RmtqqD2WYelB6GsX8sorwJFS5JdUvCOrodEsCI1jnC5?=
 =?us-ascii?Q?iJ8lhi5RauV3sThgnVtPmEfR2LLm8Z8rbqFK9GsFbVUc8e7h7H2r5FCNdiov?=
 =?us-ascii?Q?VM95iIdktb3JRJMeJfZ4VYb3oLBVgat0TaKqMGuGEG/T6jJOqTkc9viuNldD?=
 =?us-ascii?Q?8O6MXsr3ux9b4nbSeebc3BwPR6jEjzOLSpiwEHg4QgQjBq1qD7+xAkLxJsIa?=
 =?us-ascii?Q?gS10JT3E228hT5XZNBmJfF7yJdGy3xn0u1Q/ri/OPuqyc/soSTQvpDZnQkq6?=
 =?us-ascii?Q?Z8al9xq71/lYPkVhr7V6rYQbMHkMUpjsWTgixFG/48jWLy/w4AA14QdAlrbE?=
 =?us-ascii?Q?jspM/pdBshPFsNFjOl0EKjR2XujdHl6/t9z8kTEdFjpy14Pp4Yibi5Vdq3RX?=
 =?us-ascii?Q?a2Ef+B/IbBjb7yVtmnY6WJhbcTUNHW5uPiXKCBYNSes0I/D4YMmP5qFz2p/9?=
 =?us-ascii?Q?t7a6SP/F9LPbl6yTXD7XnRzspKI0who7hzIf+MR7Y2dGbpcvn+Rv/uu88sdL?=
 =?us-ascii?Q?dINlHVw71uWZufFyI6CwtWsL6ZaSgs000ENEvVqvLzy1EQcrXAf3wddXnRcV?=
 =?us-ascii?Q?Bw497ItLg5+zgncJezsW0xDUUJ7/KWam5LHCWtPXwn4h889DXpZ8AgNIzYxN?=
 =?us-ascii?Q?6h9+7aMd1wxKBDkqn5X/7fKPs0Ldkc300rPb38051L3iCYdlapqDGCIyfFpj?=
 =?us-ascii?Q?2mg3o4QcjiReUfOggSJQcZypf2YYpmYBvkQEdYzkmNsGu8iZtpcDfYRxRPLk?=
 =?us-ascii?Q?J8NLC+/Bs72r82r81AKdk4vLdCDbHD0sZ1HZt/TI3zSx6skn+KYfqbgapIG7?=
 =?us-ascii?Q?4QaQ9wxk/LxtbEszwjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cceed1a-1d62-4ad3-cd7d-08ddefb98eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 15:57:19.8460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLrhEbQJzxTFcHzQnMgbC/JPLOdAC991EAjyosXPGPwry/b2+sNfjLxZ7OcfWvLyboV5oAWmyHTxP4WZwyHATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
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

+ @Wang, Yang(Kevin) for the code review.

Regards,
Hawing

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, September 8, 2025 07:01
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v2 0/7] Add field encoding to gpu metrics fields

Currently, gpu_metrics is exported a binary blob with the defintion provide=
d by means of a structure and version. Though providing the version works w=
ell for backward compatiblity, it doesn't work the other way for tools like=
 amd-smi. Installing a driver with a newer definition of gpu_metrics someti=
mes could break compatibility with the older version of amd-smi. Even if ne=
wer fields are added towards the end, a change in datatype of existing fiel=
d or an increase of size in an array element will break the compatiblity.

To address this, add field encoding before each metrics field. Each field i=
s designated an attribute id, and along with that the type (only integral o=
nes are used currently) and number of instances are encoded. Thus an older =
amd-smi tool may skip any unknown attribute field, and move to the next att=
ribute. This encoding scheme doesn't take care of elements that are not val=
id always -  say member_field[3] is not valid under certain conditions in a=
n array member member_field[10]. Hence this still keeps the design of havin=
g all invalid elements initialized to 0xFFs.

Lijo Lazar (7):
  drm/amdgpu/pm: Add definition for gpu_metrics v1.9
  drm/amd/pm: Add helper functions for gpu metrics
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.6
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12
  drm/amd/pm: Add schema v1.1 for parition metrics
  drm/amd/pm: Update SMUv13.0.6 partition metrics
  drm/amd/pm: Update SMUv13.0.12 partition metrics

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 123 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  94 +++++------  .../drm/a=
md/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 140 ++++++++--------  .../drm/amd/pm=
/swsmu/smu13/smu_v13_0_6_ppt.h  | 156 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  62 +++++++
 5 files changed, 450 insertions(+), 125 deletions(-)

--
2.49.0

