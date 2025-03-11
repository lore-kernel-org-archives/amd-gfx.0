Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B9BC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 09:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C5E10E53A;
	Tue, 11 Mar 2025 09:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="20WQMQmM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9FF10E53A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 09:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNC9fgK5kjCIpoJe/Ak71xfHphmPoMUHfCA5SPEX9QXIqAvvwrnAdu1i6dgYZtr/Sf0gbiGCK9mVuHFje9r0zF6q5AlHrppVrkmXL+Qb1YOCqy8jRryEJgQVkAAaIBDqTyWpni45z83TIeOGBXbbak4GZ9f+g2aTAxf094cMZInajTJQbzFgiCp49Uu9dDrQyOVMQONs7DYyizCIEfO6hfqsloeTXYJIwfik2nli7mN3gmBI84qWSzrbneV3MmLvaGSbraABmd882qsERZ1GrXJO8D1F4zooQats34L1hF05gcz81GUi43hcQVd8hRHJ9mNFysoKs110ZvCZ5lmpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fqnPOWxAZQ+VdSHw+7kCajcWAD9bDrcsJWDgQXS9Vk=;
 b=VQWjWOGw19yY4pE/ZKG/2pjfll+Bel8467uOI6gfJZgThybnWPr1Rkc7p05eBqZTKOGx/hOgpfUzt/AFnIrJr3Q4bLhShtWhdw5Qe0WNEzpS3Jn7cSthbkUZ7Li2yEo6x3yB31T2yENHXTs6s30W+xsXn6iE7Vl4mEXmP16Oad3CWIDvy6es0G+XBCBtHcCVzMX8qH3vZBzSNGssaklN2oQZxLeohhihrD6Xs4SxytGf7eYEq5PiKl+s03FtAjgUxWh6aKAb5wvUHXs0QnuTaKweoM1dwbfEaHjnk1S0CvALQ/hD4yeJBJRCE02HwylajwnT5iKISFWr1k3FYUG9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fqnPOWxAZQ+VdSHw+7kCajcWAD9bDrcsJWDgQXS9Vk=;
 b=20WQMQmMqYCq1fGaFC+vUaG0JCKX+Q5oWJX5DJUUNs1M4mh9tT/+uMIcLFsKbBYvt4l5cdZZMqRIWgTdmD8pS7nAJZLPAgBBxDVA5xRT+BvxQkLydGGRHkuvOxX9VzniWFG6gJYNgDtC1Zt6EGs5xWsslcn4rAjozVvc/LUtx64=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:24:32 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:24:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: prevent skipping the workload setting
 back to bootup default
Thread-Topic: [PATCH 2/2] drm/amd/pm: prevent skipping the workload setting
 back to bootup default
Thread-Index: AQHbkmNC0esJbgZ/DEyLIaRibYU8/bNtqYpA
Date: Tue, 11 Mar 2025 09:24:32 +0000
Message-ID: <PH7PR12MB5997ACDDB289D2F03D0D832282D12@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250311085436.628620-1-kenneth.feng@amd.com>
 <20250311085436.628620-2-kenneth.feng@amd.com>
In-Reply-To: <20250311085436.628620-2-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=278efaf6-c1c8-4c66-bda0-c8de14198e42;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-11T09:22:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB8767:EE_
x-ms-office365-filtering-correlation-id: 46c097c2-6f22-4b9b-70b5-08dd607e8811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?WlNRbG5aRnlDWTVQcWpLaGc2YkhUdU5uWms5Q0tneWZzMXRJdzYyNzg4?=
 =?iso-2022-jp?B?T0Q3bWViNUxrTFQvMXcvYTZxdlVkN1hJY3VTS1Z5NU1BSWxtdm9vdGc0?=
 =?iso-2022-jp?B?dWpZU1JZcW5vK1N6SXlrRytiVWVkbmZIVTY0RzYzVyt3OUo5NFRjU3h2?=
 =?iso-2022-jp?B?MzlPSGg0cFhrTFM0UmhjT3FENk5PRHdVN0xtcnpDVlV3cUgyN2NySFhV?=
 =?iso-2022-jp?B?SElPaURESnNObzVoVlJidnh6ZWhDd055cGpTSGVsN3RFWTdIQWJPNS9n?=
 =?iso-2022-jp?B?UUt4Z1pkZ0poeEVOSGtWdXI2N2cxd0xieTh6OGVPTm52WVFVYXlNbGlv?=
 =?iso-2022-jp?B?d2srblkxNisyZWVxbEM0cVM5c2FNK2MweVRnMjNSTGFqNm1NbHZiazRo?=
 =?iso-2022-jp?B?ZDY4ZU5nSWF3ak9ucmJGa1NFY0x3ZCtlUjVzTDIyTGY2NDZuVE1DVG45?=
 =?iso-2022-jp?B?MysyNk0wdXhGMFc4RkxyOWZFLy9oczBWUys3elV0NmxMbXFwbFRHZGdU?=
 =?iso-2022-jp?B?czE1dzF6VzZzNTAyeWdwY2ZuaXJhc1U5bkV1WlBHejNlaktSbE9OU0ZB?=
 =?iso-2022-jp?B?eW53dWdSVnJHYkNZWlcza2p2LzlacG9td1VPaHF2aTlBYzRQajRjbE5a?=
 =?iso-2022-jp?B?SWtFMkt0Vnl1S2h6K2tOM2NwTEJhLzRwUzBUR0ZHUFZqZ0lpTFR6NDgx?=
 =?iso-2022-jp?B?VjNzc2d2M2xsc0JQSncvekt0YzlFY0tlQ0oxZ01kaDdXU3g4VGxCNzlS?=
 =?iso-2022-jp?B?VmhsRVM2bEdzZ0IxcHB1eXRsdlA0bHVOV0VKVElML3ZOdHIwVHNZNmZa?=
 =?iso-2022-jp?B?dVhOSEg3RGVDUnVzWnFNWXVRM3lQeEo2MHFxeXFyVXNUbk1jWW5nNUhG?=
 =?iso-2022-jp?B?aE15TnBLYXFuZGZReXBTR3NDMUFjRHRvTCtkdWtDeWtLTDRROUp2d2NX?=
 =?iso-2022-jp?B?cFg1VVNRQ3N1bFNXOEN5SEZsMDVwNWo5TXBIQmFmNlpEWGptNGwwZmJR?=
 =?iso-2022-jp?B?SWtRUUVWdUZLL0diVk1SYUJSdnZYNXFITVFmZ2tDOXd0VFgwbGJwbzAv?=
 =?iso-2022-jp?B?ZUlNNnFJdTRVUU1oNW1zYjRrc0VsY2RCdGZNQW9wYUdJU3cvMTJuQlRa?=
 =?iso-2022-jp?B?MHZCeEdSTFNSK1ZGK2xsd1dpL3BiTmgvS3ljVUhBeVdPY205dTgxWGJL?=
 =?iso-2022-jp?B?cHVsTFBQRlJhbm5sN0pBN0RlUU4zMTNzbXZBT0FqUGJXRlhYa0gvTk1q?=
 =?iso-2022-jp?B?Z1RDRzBGeGV1K0tYZVJHYTV6TFVQalFRUTMyZVRPSDJYeDJnOWZuV3Ft?=
 =?iso-2022-jp?B?Q3dJYzcvcWdjRzB0Znc2MU55dnE4MHMxcFc4RUhRM0paOWtWc1B0N3hY?=
 =?iso-2022-jp?B?c1JxRDVaOHp0QmEzczNtNWNiQXZ1bjBITm03aXkwK0pFRmxORjFWMnFX?=
 =?iso-2022-jp?B?dDBZMXorbnN3WXpyTE9FbVh3R3VGWjFSR3k1a2lWOElLOU5PKzRJSkx0?=
 =?iso-2022-jp?B?eDRkMnJBdVVabHhJemlFOFJLZ1NEcWVjYTdRYVBWVVYwR1NScE9ZOVNz?=
 =?iso-2022-jp?B?K3lNZEZFR2hSSDVKUzhKZUd5MldvdkxmYkpUKzV3YTJIU1dHekJSNERO?=
 =?iso-2022-jp?B?Zmc3RDNuN1lIT2NxM25zSmpqSGl4TWpQUFFYR0hwZzd1ODBCV1ZpcFEv?=
 =?iso-2022-jp?B?cCtQY3NkaVNvY3g3cGFhRkhIQ3Yxb25GRmdwMUszMCtNYWRQZHE1NXZh?=
 =?iso-2022-jp?B?N21RM3VWcTMyZDlMZElKd1N0TkQ5WGMrZHEyekVrdG0zbERwcUpxQzVp?=
 =?iso-2022-jp?B?OHJKbEFzeC9MbHpialE1b2ZQQmRmTDU4UWY0QS9iWEJXSVNvWlFFOGNB?=
 =?iso-2022-jp?B?VWRjMzEyQTJueWR1MDFDbnZwakx5aXVlZ3JtdkpuRjl2d0hvMDVldmpY?=
 =?iso-2022-jp?B?YTQ3Q3A5Wk42dW96Y21qNXhNNHhEU1VSSklCbFpSMC8rdXd2cE5Eclk3?=
 =?iso-2022-jp?B?SDkzTkgwNThORm9zcW14NVpqdlV1bVgzam5Demw0NnlnYkhRc3UrMkdx?=
 =?iso-2022-jp?B?MkdFTTN2YUlxeG9SUVBJR2s4RXFZcGp0Ri8wWWdQSzNKRCtXSlNNMFVB?=
 =?iso-2022-jp?B?NHM=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Q3BwclNMTXhvR0VjdUc3a3VWM3RxTHo4a2dOeEJhWnpFN0hOQWFoUnc2?=
 =?iso-2022-jp?B?Y3U4Vi8vYnVLTFpZN0U2Q1dVNHVOd3hTRFhjcnkxV2hyOWwxVmhkQVA2?=
 =?iso-2022-jp?B?ZWZaSW9LK0lqUzVPaVczWkQ3YWJjVFZIM0xSUCtKbloyLytnNDNYSFZn?=
 =?iso-2022-jp?B?ZVBPRnNCZHpVV0NoZ1hUZTFkQWZLWXAxVkgwYXMyajBiMFduWG9GSlgz?=
 =?iso-2022-jp?B?Z3ZlZ3VBZ0dzWVM3U1dSb0psM0EzZ096ZkFQYlpObFBiSXNOa2E0TEZt?=
 =?iso-2022-jp?B?RzRBVG1FNXRlbGtHam1CSUkxWG5xQjRFMnZpdXFRdjk2Q3dXd2lOUXZo?=
 =?iso-2022-jp?B?WTJEdEZ1QzBtTlYwQVRVOWJoaEpiaU5xekxaQTZrcmNtalVlY3BnTDJj?=
 =?iso-2022-jp?B?citrQkM5cU1WTkhFMm14VzFEQm9lZ3pTOUhxR24wWWtaNVkySTZWMWJ6?=
 =?iso-2022-jp?B?WTVob0VreStMT2J5N0U4N0FmZ0Q1RlZLYnpRS0w4QnRFZE1qU1loYnRy?=
 =?iso-2022-jp?B?c3NncWpuNGxTNENieWtGeVB5R1I4akIwcy9VdExHR1I1SlJaQUNoc25t?=
 =?iso-2022-jp?B?Mll4V2dyTWprZVdqK2xpQkZGMDJKYWRYU1JXWXVJOTFiZWZGc0Z2T2FE?=
 =?iso-2022-jp?B?SEhIUkRwTitrN0NGYUpzVW9uMVdjSnByL3cvc05OaGZxUTBnd3hHNjJF?=
 =?iso-2022-jp?B?ZnBhdHlDZUJwMExvbUdiKzMxVmFmR1JkOUtESDZQRXRVeG5Mb1VJem1V?=
 =?iso-2022-jp?B?Z1VpUHNvRzJaVE1lUHlBQ3UzcjkxaHI1aDN0N1FXY3VHSFlZVEVIbkdt?=
 =?iso-2022-jp?B?NGhaZEVLcHo0NTBKbkg3TC9ROFBsWEduTmlvYXpoV210eW5pQVVra2h3?=
 =?iso-2022-jp?B?S3NXbHdOZTFMWHNPR3UvajM0Q0FYellVV0Z0R1V6SUZtOS8xTnhrY2Jo?=
 =?iso-2022-jp?B?NzdFV0hSQTBYdTZHSnExc285SnQzVE11OFdJTFprQmJWNnJkb282Y1Y0?=
 =?iso-2022-jp?B?WG1qRUpReUhPMkw2YXJodjBJUTFnRUd4aFZlQTEvaUd6a0pPdTNKai96?=
 =?iso-2022-jp?B?VS9tTVJPaURUUFZ6aTYwejBUNkEzRXZWSzlsby9OdXhoNHdRWC9mL0hW?=
 =?iso-2022-jp?B?SlNYQ01IbXFRY2JWRndlOTFCdU9ER1VHT2dYcmsyTjJQL0hvNk85azdP?=
 =?iso-2022-jp?B?R3hJdGdqN0N0dlgzSWR3RW1MQlo3UlIrVGdZZXVyS1ZDaWdPS01sWWFS?=
 =?iso-2022-jp?B?L3kwaGFYcjdnMTVmVk9xRmhaTkZpajlnalVxOWJjRmxuVVJrRExjaVgr?=
 =?iso-2022-jp?B?TDNQUnZqVkZVM2xxdVk0M2VmUFFZSUkzcDhmeWJTWFhGYXFaMkMwR25L?=
 =?iso-2022-jp?B?UDNmbTgxbGFTK1VCdGhxMitiN1hMaG5RWm5ubXRsT2hWaFZuY25QKytq?=
 =?iso-2022-jp?B?aEU3ZWhvZGkzdjdEbTFFeTR4T0dHcTFrU1VKRkhrYkorNWpLV3pHUDlU?=
 =?iso-2022-jp?B?QStlMzRZNGpxMkpBeVhLRjBXT3J1eFNZVU5ZdDU2Q0JueE5TekRuZHVn?=
 =?iso-2022-jp?B?OTBOdnRwUGNwMXhwQmZ2ci9DbWJ5YndtRVA3MzhyYmZ4VG1WUThwTlVY?=
 =?iso-2022-jp?B?dGJhRXBxRmRsOU5haWVITW5mbytmSHUzS0h0WXdueWZ4dGdnOVdnTnMz?=
 =?iso-2022-jp?B?Y1VkNytvY3JxSXpjYnZlUmREMGJSNXViSXJmdWhIczRlWlU4OTRnNUo3?=
 =?iso-2022-jp?B?UUVWSXdBTko5bTVPUHR3eGNjUVp1di9LcGJRaHBZeStaeUQzMSs1dHY2?=
 =?iso-2022-jp?B?SWpiOWlyeUNlUmpqYXFpditHSFRmMUxqSmtwdndLZnIxME5NbTlWUHBU?=
 =?iso-2022-jp?B?YWhmVVVHdGMvdzlYcXh6TFBUU1pEUXMrOXM1V1hKejdEZm1RamcyRVVM?=
 =?iso-2022-jp?B?Q0RwR2tqS0h5UWpNWVNPZS9aem9hRXZDWlZTZllTaE9jek1BYlN2NXNW?=
 =?iso-2022-jp?B?VHlpR3Y5bngrdm9ORXNXNXdaQ3VGQ2o3NWZ0SzlzMTZwcmhKaUVjU2Vi?=
 =?iso-2022-jp?B?cUtGTWpEUStWVWxTRjBOZmhUcjNhazJNa2dFSUdTRU5YZGtkSlNXN2JU?=
 =?iso-2022-jp?B?ai83U29CdWFOeXVVeG5Dc09zeVdBMjY4S21VdEJJNHpyZGJuZm9PdFBz?=
 =?iso-2022-jp?B?dmxwVWdLY3dZd29BT2pSNmwrQyswdVFKN1h1V2NtMWwxWWtPeWpyczVE?=
 =?iso-2022-jp?B?bVBkOFo4QVpQemFmL2RlRzN6a2xSWmk1az0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c097c2-6f22-4b9b-70b5-08dd607e8811
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 09:24:32.1003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xH9LnJWzI3ZZjlCcOmJBLXLxzQhD+ZMIQp29Z9EnCvV/fBnjzjBFRPyhJ6VOSvH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
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

Please add following information into commit message.

Fixes: bd3c9d1cde0c  ("drm/amd/pm: fix and simplify workload handling=1B$B!=
I!K=1B(B

Series is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Tuesday, March 11, 2025 16:55
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Alexander <Alexand=
er.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: prevent skipping the workload setting back=
 to bootup default

This is a bug fix. The scenario is that the same client can add the certain=
 workload type refcount multiple times. Then the same client can not remove=
 this setting when it wants to get back to the default bootup workload.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 8cfb07549f54..592bf54015c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2273,7 +2273,8 @@ static int smu_bump_power_profile_mode(struct smu_con=
text *smu,  static void smu_power_profile_mode_get(struct smu_context *smu,
                                       enum PP_SMC_POWER_PROFILE profile_mo=
de)  {
-       smu->workload_refcount[profile_mode]++;
+       if (!smu->workload_refcount[profile_mode])
+               smu->workload_refcount[profile_mode]++;
 }

 static void smu_power_profile_mode_put(struct smu_context *smu,
--
2.34.1

