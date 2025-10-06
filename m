Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940E9CCA471
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 13:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D5010E3DF;
	Mon,  6 Oct 2025 13:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jn3LyKm3";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5414D10E34A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 13:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foXEY/AZnN2he7G7+aJNIIqpXa37aSFFbm4x64Wb15c9OQ7psV4sG6JWQlH4aq62zH47qav9vvQAu86c9RL5gerrJmXuRHccI8aTTE4wt5X/B9GdCZCZyYgt4+dCIcaHPXZPieS+2OPoBu2bQLW4xZIx0/Tj5O+Yyy9LBjntMLgVPOcyPO/OhA1rh2SUVwh5I2kEWxBihzj5p3tdUVt1SIQahr3ejlNdIc6hlLTcH3I1/2Ww2TeVT5IetzTTu7UE+eTaOddBjoJvXTYXhnO1kdW7MOwKK/d3IayepebGzXVw8vohjRF6BtvZ9TSxsNDOH5b7i1hyPY+niXg/UwFz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quHb5K7/ZIGs9zJdWhjk8z+qaeBK1FWuhSJ3cNrAfpk=;
 b=xuTcSSxApphBPShXcefN5SUYu+K0aBKg6ROXWy0HI/ExtH0HOhdev9USRAekDu4mth7ozg+a8awMulF5vvqHnC0YaFbuIjKsXHU6fYP8y9pDiIUyvmfIUEzWMqkcQl7NGz/Xf8E3n01vCwlHtI3NXvLZ5YESuRGgi5JLScOxwyqnua0RKFAfE2nTrIGlkGbrDAoMjZKsIPQHvkmiaPhMB4xo3PRKCubl73U3dxZY/8+7G5yFkhZkuMeZwh6sFkm6cfInYy1yFSGePTdRzrPpa4p2nWhKrpsTn9/hutqMdf3xnenyiCsryYErWGtCEAYOUsDIO9vV0Spu5ajolIuVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quHb5K7/ZIGs9zJdWhjk8z+qaeBK1FWuhSJ3cNrAfpk=;
 b=jn3LyKm3JzQcilFlJbJoOSq2sylSS+7T5eb8SVNuxUggJ5H3Ggvg/x7+nm7s7RUPEBfoAqc2o2hk++pg4+12eamcRQOlx2Z0HyJkIyf+y3IJJN6lAVqPebV3Up1dAin0dzgYV12EkVx6QwxLfwloXn/NqhqHs/hQnVdgIvN5ikM=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB8259.namprd12.prod.outlook.com (2603:10b6:610:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 13:25:47 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 13:25:47 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: RE: [PATCH 0/7] DC Patches Oct 1, 2025
Thread-Topic: [PATCH 0/7] DC Patches Oct 1, 2025
Thread-Index: AQHcMxouOg22B4MUp0qFHe7mw/Af+LS1IvLA
Date: Mon, 6 Oct 2025 13:25:47 +0000
Message-ID: <DS0PR12MB65344B72719AF98E0B765BCC9CE3A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251001212700.1458245-1-alex.hung@amd.com>
In-Reply-To: <20251001212700.1458245-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-06T13:25:41.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB8259:EE_
x-ms-office365-filtering-correlation-id: 474ac03f-588f-405e-f81f-08de04dbdc96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?S9SYB9UvT/MH35Zp8Bp/eb7OwJuj/3GCNaS5qS75iWEdlUxBBzbV1zQxzz?=
 =?iso-8859-1?Q?a297fz7P3NrzlY0oCzxmTrJCZutQJ0H3lkgtq+8nncAQatXE4cgHB78uxh?=
 =?iso-8859-1?Q?GsHn5VyZFBuR1GZONjdfWp51DcX2EwS6wZFZXRyX/LkHhgHbX19Op5rVoT?=
 =?iso-8859-1?Q?C+r4sfVjHmfT3VhRjVlNZhHlA8NZWMXhCirlQTQFJ+ZwU9EmS9eA5EXvyZ?=
 =?iso-8859-1?Q?wwkJJUybnwHle7KzmNOFpku8amD1ITi4okchsyOmMqmSmbUWIsY36PH7OC?=
 =?iso-8859-1?Q?NFukrY9eZDTfyIgWa53a8irNGMUXMU0Kv+PLSHnjUBdlMxXOIP+IsPcVe9?=
 =?iso-8859-1?Q?WwGazr3OFoGjQkGdSpJlZKpSV1MIL+GpkouF7jeCt48EOKBqesooHXhhzR?=
 =?iso-8859-1?Q?evMfhxRgw7X+U279UKtL/7O8/UpPkBx3f8HXEgujZWL7b58ClMudiMWTX+?=
 =?iso-8859-1?Q?2f9fK3b7lvf9nxrhk5o6+RUMkBdUi2sB4n4BLbumNO4JWbKS8d7vV11nW4?=
 =?iso-8859-1?Q?npJaZZxk74v06IdXJzLRgSSt3PRc1Ry1clljGJzDbBAqc89PSyeFmKnv9n?=
 =?iso-8859-1?Q?IZ+r2zenaCr62SoSfo/sUN+IfRN0LjkxjucmITO1+bLgZSJvCQHFEKApLC?=
 =?iso-8859-1?Q?hOOVm4UQVw0UYkfztQEiMPckOTfDxHBnMwFEbA3o4LJ3B4TAjuGLYEomg0?=
 =?iso-8859-1?Q?1hq5WPdbb1qjySGwV/Rm+KxG8I750L+wNRqtY9Z2nZeqRmHF/eFlqeHEdf?=
 =?iso-8859-1?Q?TbzaiwxZK24Sw5tLxUJGmWwlmh7aS0YD0tujqyZGRnmfcg4JzFfVmbi4Xz?=
 =?iso-8859-1?Q?1VVo8yQG3W/dEBRXFMBlaBJ9OvxyrOfaR2f0Syvn8HQgQX3hm4gqL1e6hE?=
 =?iso-8859-1?Q?2SOq98dwXCsJ+9+zAV/gmSLEVvRzeT6lEhPQaruAGaoKFqBO8/SacDif4h?=
 =?iso-8859-1?Q?ElIBLGlSMcLdjlNvpSgwpj//hurZcY2QxsHGHck200/PswXxgKazJx3xMe?=
 =?iso-8859-1?Q?h0aZQRl8B+UpdaYLVd3Q5E49gYQhwnYoMrZuHI/D3z/BFnHWPVWha2erAo?=
 =?iso-8859-1?Q?rh4F2U/AybG8vS5Kg4cHzD35xueds6q1FY1b2r7w4J1x8rLEcOXWl6Tr/V?=
 =?iso-8859-1?Q?2/bP5rW6bIHhN8MRyLxiviwpEMxP6CrQe1V/G1Q6HMIBUvwiJ2sUE1Qv6O?=
 =?iso-8859-1?Q?Bu6wW+BtzQY+CWIoRLQxQfBdED9kHwig1poAj2Q8gEZoMTzLnFsBCt9mcI?=
 =?iso-8859-1?Q?SMNEnyKpb58Dp1fXTEOIRY3qS1S/klx377Gh0lRubTfH/eoZD8H2CtncJM?=
 =?iso-8859-1?Q?7e1CxCtuYoGf1R1HFojCAgtBpkkfX0d232I0D3/Dh3IyJoVIalTcfx5ieR?=
 =?iso-8859-1?Q?Y380N7nCUB4nbi4ijQTWbtSUraOuGRDa2IBKbsKMOUqGCfnC3u64YGmY/J?=
 =?iso-8859-1?Q?0Qcm4htCT7CFPJ9AD16eWsSMdP8fQxEfDXf68unVJPI60ByIglLNxs0qwJ?=
 =?iso-8859-1?Q?k/XfT89TbzvoPkc3SDS54IOlRxWjPjkqGFrtsp/AR2t1nEqEBTpHsfavel?=
 =?iso-8859-1?Q?ETUd18E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cp8bfJHdevrBT0ehW6CSfbR9SKIg8I1uljZ/adBFrByt/2kUK5xJRDM3Pg?=
 =?iso-8859-1?Q?ZP3jI3uIGbxyir2OwBidZdZYxvBqBgjY3ZXa0ombP13mKBWt2lTlFhIWS/?=
 =?iso-8859-1?Q?tyVchT3V11zCeGYxGInYnXLxqI6gl0/VxwFxW5w+rsXdwGPQE+lBcRrDSE?=
 =?iso-8859-1?Q?5QHKlK6MzV0qF899zwgSF2TcxeG16mZ4TdQagoTdHEnOgN9DqikuqVqEII?=
 =?iso-8859-1?Q?pVcxIN+xq1qLk3kVIhPHF829Q8KZ4wjVc6Eq6YqybwFOQdHzuybXXFSyHa?=
 =?iso-8859-1?Q?r7RhEJGhPt2eLAhxUlkSg0uTFQ5K/Q2BY/+GtwCJEhNNSR0FCp2GyYv1Vq?=
 =?iso-8859-1?Q?kU8YcORbv4QOEBV3uLkUHZZd/ezUYH+PPIDBVyKij+AG5am4qSMLdJTFbe?=
 =?iso-8859-1?Q?tWA4cRUe6VsVHGrPoOcktLjHSHtPcSRrolZ3QCsss5WpDG5PetxkFB227r?=
 =?iso-8859-1?Q?S7c5ZP5Uhxsns2HyN0/sLHNhE0K4TjCTcCI58vQvGPh7V3owEb/gYMreqn?=
 =?iso-8859-1?Q?lm6IDl1Ko9vYTRcAJi1Z5hEbxtOErJOFEFIX9LceQrRDbZZX0L9i7s0PbW?=
 =?iso-8859-1?Q?daoJbdFvGlX/DNUrIkpuENMrxgMcBYv4DCyC3wj/awt7NLC17ZrfJufnwc?=
 =?iso-8859-1?Q?YLTWJ/NsST48kpSarOadadqaGtPwULEP4UnFfcVypbB+ChImX45PgI8PP9?=
 =?iso-8859-1?Q?xGTPsMSivEYQwhm5jYji7rErPzf88R8ZqdvfXa8yFraUpyqgSBDP/CwMS7?=
 =?iso-8859-1?Q?8qAd5IiuPZLDHYxClp6s56XbPyu4UAVfWwuOYsDWq9En1jkJQlZhGMkDw+?=
 =?iso-8859-1?Q?zsAsyxCs6yJxQoBPD9scgjkskrxWZHK5Oqqv29dXUAlL6VDMmp0wTi5v4z?=
 =?iso-8859-1?Q?eYcfEGXTm/onruRX2lnMIsS1cPPo/3aqWc6YHRMqIEB1IHTC+93ZnTHdMt?=
 =?iso-8859-1?Q?2JTv5b6PXxFApY8vUlNxcaqS8dsbg4cdC5sQCcj+Dwzagf1zH7lPFVW/er?=
 =?iso-8859-1?Q?w2yZHrT2JUCD5EcvtwhoY0Z4o5AheOInUhk/lYYaF7xx3QD+PyPIaQ/CXk?=
 =?iso-8859-1?Q?HifAfN52M3g3YT9puEgSqtFrhlFeXNPJgsGdyWX+XbXpYSbkg0p6jscgFV?=
 =?iso-8859-1?Q?WHawWUEchh1UuezvXyjwzA8iNl0FgACIMHJ728bnKg/aRP7w0j++aUbHHY?=
 =?iso-8859-1?Q?oqUcfWjCL+62eoh2ikBFmBpeU3FD1ancu+K/ugLVOQH0e5Etyd7QLMB+D2?=
 =?iso-8859-1?Q?6Ew/pZsUa3bChN9XjdjD717Fm1TE7+5ALWsLBPN9+UOTVO64+iLcwvOyF8?=
 =?iso-8859-1?Q?zXNVtUGlGwWWx5iOrEkJP+PLGvmdPP+GBxhxPe1xIzDZJEYr8xKM+AQkWM?=
 =?iso-8859-1?Q?Xc5OwKjcWzXBVKGD/XI082izcuqCevuPOeaTVDFGIdcoybpGy08Lfmigki?=
 =?iso-8859-1?Q?oLZAOO/y+e/kQLu16V6Gx6++r9lvheCvELI0qKSVseW29GkXceX/kVCbgI?=
 =?iso-8859-1?Q?cfSelPMGYeEuSutHxfo3EUQIwOs2d1rXQmT2lZZQKC3D9eJZEX3TURM9JQ?=
 =?iso-8859-1?Q?KSOIBzn10/qVGIQZiz98Ef3kNy9d6r7MuYIGDjZ1aiZ+Xs75qyVHgCqEIW?=
 =?iso-8859-1?Q?mFf0AvJlF1QWI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474ac03f-588f-405e-f81f-08de04dbdc96
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 13:25:47.8244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcmoyXoDHR3drkIOPpqPcoMbenZTP/1oMrkUagFvf7s6OaU7ev1KQTqQdvnSCQ8vjz9JwoGYPR86REjG+8Vsdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
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

[Public]

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 854=
f25cbb89276e5f3f576f49f1a94d307b1662e -> drm/amdgpu: Merge amdgpu_vm_set_pa=
sid into amdgpu_vm_init) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Wednesday, October 1, 2025 5:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 0/7] DC Patches Oct 1, 2025

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Driver implementation for cursor offloading to DMU
* Incorrect Mirror Cositing
* Enable Dynamic DTBCLK Switch
* Remove comparing uint32_t to zero
* Remove inaccessible URL

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Remove comparing uint32_t to zero

Clay King (1):
  drm/amd/display: Remove inaccessible URL

Fangzhi Zuo (1):
  drm/amd/display: Enable Dynamic DTBCLK Switch

Jesse Agate (1):
  drm/amd/display: Incorrect Mirror Cositing

Nicholas Kazlauskas (1):
  drm/amd/display: Driver implementation for cursor offloading to DMU

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.30.0
  drm/amd/display: Promote DC to 3.2.353

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   8 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 ++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  12 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  42 ++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  99 +++++++++++++  drivers=
/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  36 +++++  .../drm/amd/display/dc/=
dpp/dcn10/dcn10_dpp.c  |  19 ++-  .../drm/amd/display/dc/dpp/dcn30/dcn30_dp=
p.c  |  20 ++-  .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  42 ++++--
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  69 +++++----
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   2 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   3 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 138 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   8 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   6 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  60 +++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   7 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  14 ++
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |  22 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  10 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 104 +++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  22 +--
 31 files changed, 689 insertions(+), 95 deletions(-)

--
2.43.0

