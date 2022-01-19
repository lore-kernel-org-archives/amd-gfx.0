Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F38CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598AE10EEBA;
	Wed, 19 Jan 2022 22:19:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3989310EEBA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu0hBXy/+saDVL3PsfsWFVjpRzXGJgj8C5MWSlvjCXaTkpPToI1fM1hBf9+J7MUwrfkqqUctN8FXqaouJHp6QMEd+gp/sdzjtmT0NHwqw3tosERtZUedNt2egwbTCIi5K1C8oLX5trH3tnzGqghI/bFNZQcWtaQOgXW1CyowTh1H2nBNYneKCFHXH4izDPqy3bPEthXHzbHT1xtGBzqlfYQ4NV7U+whl9osAXEcEuptXa18NR5qYQdIC5buARn5xoabxsHa2V5CNC6m7Lk+KCGo+Knsd61+Q1YYIIv4U5Tz8Qr1QMgtDbOuAPhDvIQiwS4hBIEwZMvHriUlCw5fLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=But7uhtNzibV6BNHY3ZeuEFv97lAfJr0RVuX2JHBe/M=;
 b=W44KkXe/iU75l3jKfujMlf1LitJK809R3o6o8ibT0BWisv8aPWFgIt0U3Zlq3ALPwOztggslWn0YzsCG5Q+4/XPfPpckTwh11ZoQWggMJd9k4F8iGvy64QryUrkJfebRarX0wW+PA8ThXrM3pggwFwr5bFgxwgrl8tpvq+r/cHGlEg9kinHxa108cjpy2mG2vfElouQs1+q8pVVK9KGlmTWvP9IdO8/dFuYedM0lAqviqvFOY/6KsWPbgR2XV6EvDOZtmveerw12snswkuIxirNdnR/xK2186FKyHUi7OVsd2/5TTLMRiu2EpDZwsqWycKyXtZBUkvgx1LcTi58sgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=But7uhtNzibV6BNHY3ZeuEFv97lAfJr0RVuX2JHBe/M=;
 b=w4dFo9IKHUaV9O8VAlZVBdM4ox0O1Bq72lWjfrQZhyC8E+kJiDvxb7c6sXAdJ4s7jwaDHWd6APPU+mVN9Jsv6pPgJtFU+OR4+LG2qKdQwO8XwPvrfi4dlU2YsiYTsn8PNoywmhZR4Jt99NwcuWC75hIoiWrlmTMvFHd41BHLsUk=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by MWHPR1201MB0047.namprd12.prod.outlook.com (2603:10b6:301:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 19 Jan
 2022 22:18:56 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 22:18:56 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Shorten delay time to 1us while resetting
 FIFO
Thread-Topic: [PATCH] drm/amd/display: Shorten delay time to 1us while
 resetting FIFO
Thread-Index: AdgNgnXaHjkBOvHIRT23qnPD9UzUcQ==
Date: Wed, 19 Jan 2022 22:18:56 +0000
Message-ID: <DM4PR12MB521400998515602D0F8AA6EA9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=08075666-221f-4d9c-bcea-b4c4a2860b9b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T22:17:58Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15ce0665-c240-4018-4fff-08d9db99af68
x-ms-traffictypediagnostic: MWHPR1201MB0047:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0047F725FCACB08566FEE3D79E599@MWHPR1201MB0047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EedtZLFdi2C20myly/h2VaKatyQDmb/j6EOcz8c5suNzDI0QA00a2NzcZap6xzoldq8NfqjvEC2+1wT82XxJ2y2QOlHJ+u1j6i1OL+OZikIoUIColAEIEaYz4ndXO0ZKT+TQcvFkUVH2+gXvYSLTOcBaoUQGrnOsTZAIzwopj1C6TpGKeckCbFRTMPM9wa8AU8LuHaTWXbnavyBScKMq5RJ/gNz9+j405ZPfY/ZXe/Vtt5lHFTzeset17KA/9b4UT77k9JjqKJ6lotTHb7G4k6Da5qZe/NegnavyzW5HW2EbrK5InJ6mbbnZtlN3rYY9zq8IZCZbx1Ck7KLJy5OhUS/ZIDLns0DOaK9trODWjVPEGVVt8fA+IX44GYSo39Ex1QGv6eeQAKYftIrySnjaxLj7EpF/SHsfA0lxFVNXiTxWcuDEkh041VBS53iPSdKGKKDRkc99isNCb2XikqcV0/H24Oidz1ezLyAXnDt/Aih948eDroynST94l0rRrJk8DWjZdxJ8dk7eSapWiLOtvXI3Sir9hyEqt8kDCppZhLHB9BbyKxz2QpG7G4UtijB8btkgY7X7OVNEAI05rTfnEzcIaQUuOOQVgav3PoBFTY/bB7sDw5mD+pVzw588pXgwUjXsdCh9Ibc1mAdKsa1pjOWJ+/NZl9kpVE0T/dCOPLwuz5K5GeCXN3fFvqZcQ8bl5Dxr90rQcAwG4eIHR4bsTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(122000001)(55016003)(6506007)(9686003)(66946007)(186003)(38100700002)(508600001)(52536014)(4326008)(8936002)(316002)(26005)(4744005)(83380400001)(38070700005)(76116006)(86362001)(8676002)(66556008)(7696005)(2906002)(66446008)(66476007)(71200400001)(33656002)(54906003)(5660300002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2VZzy9R9EiohgP5GaQmKvK9m4+A8gP1efezaS8Tvtzim1TdZkBsXuTZwXqYL?=
 =?us-ascii?Q?SbxfRbzEcZaZ9IGwb31VJJZCSisVSNfinHYTywa9vYi7eIiCYKqTUYf5FZkb?=
 =?us-ascii?Q?Z+ReS14HRz/p8hiPVFF05pbfisZOC4qMxlmbh3OyJYNR9GNeadfWlAOPM/Rb?=
 =?us-ascii?Q?1Qd+axPfvDT4hFOud4gP8qATSCnR2q3NNjokscW3Y285FuZRmKH1GLcBXVk1?=
 =?us-ascii?Q?09zZy4Gs9/OLHghmTn/BWBv6XUsfnagUMrtWlvsoTHz2dgoNEcuzjXlk7ynm?=
 =?us-ascii?Q?WSD3fJmudvqrB74yaX+6VHxYuT37lFNO2lm7Kd9wJdcJM9Hd5vTZqHq0u73W?=
 =?us-ascii?Q?qeQgCRNUpkU5VJL8PylsunJMweeReMTfv0PTJaQjzpsVS+7zMUZamNXI1+B6?=
 =?us-ascii?Q?XvwEeZpk8nGUpg/HFYvAOcDGXlUZ51xTMqb3mC42V+UrCfnxh+gcQ53FH4av?=
 =?us-ascii?Q?0waSi3z3Z5iQ9G5BEFnupnBCo6LSrpHvY9EKZjkW6fBUuvUD9mmIxNyaQtJ8?=
 =?us-ascii?Q?hVMouV8T6o9inWnkLftBcZGx4uddKpY3ryUb2cVxghQb1sT2gIOVYfvtXsOE?=
 =?us-ascii?Q?6+EpJzZ+Ol4jCCZ9OrmiolM2I/W90uv0EBdC/fCzqIO+H7hDEny37THhj44O?=
 =?us-ascii?Q?KcWIsFNPaLpByJd8Ctqsg1n0bgupt7+Gwd1WlpNOw/eKDIxvB6+caRz1xg32?=
 =?us-ascii?Q?r9jks5nP5YOMMG+cRP4YWvwH/spV6FHG8qD2ptx/Pu8c0jnF4nEIj3aTiT/w?=
 =?us-ascii?Q?QZ7GeDBuoH6Vqotf8gNjkqZ9OSKdgIyzKZjfifFrrmqOugeIvwJMI85/6yHS?=
 =?us-ascii?Q?10Zxa3/U6UegCL6oN1c3ndXYZWel2wDaAhkI+LluSU+UpFpSbE0hfMKSAzT9?=
 =?us-ascii?Q?1l8Mozn7OV37xtSjoCzWwwHL3Wdamb4E1cvozt8LO6Bdtz4X45Y+8XDDMbjW?=
 =?us-ascii?Q?wOIudVGHv1LA8TuJOySZhNm28DMEOe/yJy7dT98AbrDenm1YjhHZ82DWxKmq?=
 =?us-ascii?Q?VqFSSfvxU39+mLRpLv+4mXt57nl9RAIInpoODnTBlGJ6gPsThHkHKnXCPr99?=
 =?us-ascii?Q?KppQCAt5DCEWRu4cNyn9b7zlJY4ggaxIfof4T9m9BXjiua9Dg8fRkxkAPnO4?=
 =?us-ascii?Q?UP4Y0f5OkLCNbXifwwRVEiHU2ufltA7R2ud3HnLRcGTA5VqkzxIIF4gQFPh+?=
 =?us-ascii?Q?jdowb8TCGRgmrqxz4Ek970E3DGicxUFhbNN2XpGdW+RXFfme8u8s0dZZldDo?=
 =?us-ascii?Q?8Qn3M9qKtf0mwyza+vdGIvtmQ/Upv4ZUe9hkMXGhMj1YMIBAPCBd5PJyDYFm?=
 =?us-ascii?Q?oDtOTMyzhmAYDmie+y23USidpa5C98DQa8o7J3HzbKMpbeUcHaalEJ4KrBwb?=
 =?us-ascii?Q?NYIAepT3HgrGHIs0hsJB7L7unsk71VqZjTyzAX+IYn6YEUzzngbIEKmo1pEJ?=
 =?us-ascii?Q?gddZdsrbQsZF+q2HpAZMzzIjnzAyLWo6YOlWaRwZ5aM0O9U3NBjkZWoNO55S?=
 =?us-ascii?Q?CJL+eErGjFOhIRzXekCSwDvyhEJ0zfE/8fd8k5BWiNa7ylC3yka3IWCsOQnA?=
 =?us-ascii?Q?3Nn/Ja5l67RdXkhG0Xc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ce0665-c240-4018-4fff-08d9db99af68
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 22:18:56.6777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9llK8hMxQ3vLJItfZsyyCnOllHkr1tBH0XCHJHNQ48OqmOlvckzovEhbbHqES/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0047
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Cornij, Nikola" <Nikola.Cornij@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

[Why]
Current FIFO reset delay for dcn10 is 100us, which is too long
and will fail atomic flip. As a result, there will be no display
on boot.

[How]
Shorten delay time to 1us. This also aligns with FIFO reset delay
on other ASICs.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index bf4436d7aaab..2077c22befa5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -909,7 +909,7 @@ void enc1_stream_encoder_reset_fifo(

        /* set DIG_START to 0x1 to reset FIFO */
        REG_UPDATE(DIG_FE_CNTL, DIG_START, 1);
-       udelay(100);
+       udelay(1);

        /* write 0 to take the FIFO out of reset */
        REG_UPDATE(DIG_FE_CNTL, DIG_START, 0);
--
2.25.1
