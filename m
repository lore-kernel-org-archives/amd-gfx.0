Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD152C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 15:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5559810E3DB;
	Mon, 16 Jun 2025 15:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MvZqKUkX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C828210E3DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 15:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh/dWmjyYO9oLVcXfFbRN6M4eRLABV1h+11sQ6xOq4SfBcs8+pKfhK+iE31k45u+0Nmi/PolDE/b2+ccwRQgW4E5mHmmG469+m6h/ZazT5xXoKWjXHweIMkPrHVWsadwRy2r4ejZRCuruRKe43msIpsDQyG32eUhQJDVKXI+d4AOOUQtU7i/LCJvGUXBTVkydUcaqQyjEmLo7NKxm0NyKWdE92SzSTAVyfNcnEtwxyqHS+co8muDCSRjPxipPKT1PYVvInufM1MSXvMbtTc4W6AtmaKQUuz8606CWQVHyFCQ7X0ETlim64/C2tW+CRqjt4V+/79wW8OsKka3YJsyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hQdK/SBKeKJsOf81Omc5zYVeukGsj1Yg7kHW+WJDTU=;
 b=O6GwMDeH319jSmgnJQptH5FZPJagMCFfWBJRS7+6rbcGglDnpPQlwsLZvD9Or4BjTINTrwTUWHXOTD7Ox19J4VCoZj5TLyJ0zYrSpoRCk3miQ5RieaWxiyiemv6T3ptOF6LxVap4n5Lh7Cll1zqSNyRGByGyqcA8xC5P8Uf1v3JfxghjoIDvWAoawUi2YMLdp0CcUVfr5WiIeNV+1h5qUqKwd4akh8q8T1PygoO5c9SUmEVJjd4e1iU6bCfUYGGECCI341Jx2uYkvuDn5v8SjDYO104ddw5L3RzGxbLe/5+/ub2X4FKurH5XFgv53Q//hRkKEMa8fYLRIhDEpsNZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hQdK/SBKeKJsOf81Omc5zYVeukGsj1Yg7kHW+WJDTU=;
 b=MvZqKUkXPgw8TW6FWy+iGePvpxpaaQkRJd0qfWD2Zcho6XjJp+Ni3ssfqfMKOvBqthGppr2+nnIjScC4R3BVCKYw/gWedASGC7JH3NXmYdFrdOtQ7CrQ3aDxB74i1S5Fl/O2MEOZocPbMou/xdvysuFDT9cHlKvEgz1zFsjbCHU=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 15:24:08 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 15:24:08 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop
 sequences
Thread-Topic: [PATCH V2] drm/amdgpu: Fix SDMA UTC_L1 handling during
 start/stop sequences
Thread-Index: AQHb3syhGRKm5z+qz0yDXSV6KjLkObQF4KaAgAABxYCAAARQYA==
Date: Mon, 16 Jun 2025 15:24:08 +0000
Message-ID: <DM4PR12MB5152EA0811C75DCC4B584995E370A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250616144030.3497914-1-jesse.zhang@amd.com>
 <CADnq5_OpAaiBZaxU6RxNRvY3wcpz5WhDzX1iscuUnsu7gebrhg@mail.gmail.com>
 <ca06a3e8-cc16-4b98-99ce-7271c3efeb47@amd.com>
In-Reply-To: <ca06a3e8-cc16-4b98-99ce-7271c3efeb47@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-16T15:20:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB6631:EE_
x-ms-office365-filtering-correlation-id: 8dcddb81-e21e-4756-1107-08ddace9d68e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WnhFZUcyak5rdHVyVUpxeDVlYlJKZmRrRkJzWHdLUkRYWFcxZVYwVFpZRlZR?=
 =?utf-8?B?NHdtMm5tTys5dzE3KzVnVzlJVFl2U2tSeGlkbTh6TWVPQkdZbG5FNWE2YjU4?=
 =?utf-8?B?d20vMG42d3FzcTd0emhRc293Tm14U2trQUtzb2h1aDJqR3lDZjc0YUh0K0h6?=
 =?utf-8?B?aG9KUzVacVFSdnpRU0YyYWRoUktUby8xc210ZU5UVzBuaTBGNUk4MVFJeGpy?=
 =?utf-8?B?MXhOTWdKZ2VGN2JMemFhbWNCWEErNHFWZmtIYll3QlBhZmI5VXkrMlNSS3dS?=
 =?utf-8?B?WGl1alVIdU02OEwvbis0elBQRWt3Y0tPbjFDWjJKemd2VFRqQzB1Tm1tVDIr?=
 =?utf-8?B?SjVwTG9QdzVsRU9lNm50VWVaNmZCUkp5S2FlRWtDSTd1bUEyaGgyRkN4cWhz?=
 =?utf-8?B?dXhMTmxmbVUrQS83aUJRazcvTTZzL2RzbG1MUkowaHNwNWNJa1o3TmZ4U1Bs?=
 =?utf-8?B?TFNvZS9sTWFNZ3kraEUwM2cxSGxPWjEreDlmSFBDVHRPcDhOazh3WVF4Rjkr?=
 =?utf-8?B?M0RKYTB6NWRSTmtBUXZoYllBQlNtcWZRR3VYV1RjdEZ3NFhXL282UzNJbkJs?=
 =?utf-8?B?VUQ1SEd5NGhreURDODZ2YVFRbGs2MnFuYXhRVjhOazdlTXI3ZTBKeHZISWZG?=
 =?utf-8?B?bXRWV0hjOU16VHVlcTZxSDBqYTJUbGpoNWE2bVVlbDVXZExWRm1yRW5JMnlx?=
 =?utf-8?B?Nk1VdmxwN0FqTFRiZ29TN1Y4dmZmRUp2dFhxeHpJYXpUVWRSNXYwUTc0TVh4?=
 =?utf-8?B?SHREK0JzRzZxM0l6WkkrRHo2aEYxYWJJTUY2YzlRSlNYeTRUU0c4TFRNUXM0?=
 =?utf-8?B?cjE4eEVKU3E0b1ZmTkJPRTdvUkd0STMrTUlPOEROOHAvM3ZyNjFGTk5QWFVs?=
 =?utf-8?B?dFNFRUZwU2NSRVBaYWJNU3hObjREWVo3RGpZV044NU9OQmp6akdxTktaNWNy?=
 =?utf-8?B?T1p4QklJVDZLclRkTUc0MnhIeXBJODEwOTB1VDdWRW0yWklLdXR0Z0V3dzQ3?=
 =?utf-8?B?akxGWk1OMDA1Tys4cHRYcXdDUlh1S01oSjFEZDlFNGRFWE9FRnNRRGtPK2lH?=
 =?utf-8?B?SitxTjVqNzhUK3V6cHlqL0toTVdnSlRvYXVIdXBFQTFlZzBvZlJ5L0dHNkJI?=
 =?utf-8?B?czZjQ3lJOXhHTERHcjJQSm4wRTVXWGdmMTY4MUJNcUd6c0pRL3NrdGtQNmx0?=
 =?utf-8?B?ZUp5NUFUNmJlSUdJUG4xSzFNOXhFcUJJTUlFc1NldFZUdmg0NUdRaGpISHZv?=
 =?utf-8?B?cEFrb0RYWVlRZ1NHcVl1QVVJQ2RsdlMrd1Q0dnNrbm0yYk9BNWhaaS9uRkJa?=
 =?utf-8?B?RmJJSWhuTXR2cTdoQUdGL3Y4VUExQTZ2Ukw2LzZtZUsxUFFQQ1EwR3ZiM1Zi?=
 =?utf-8?B?SllmSENFUG0zczA4L05TK3ZOaEhmQ0Q2K3RTMEJNRWR5djh0ck9MYStnYzA4?=
 =?utf-8?B?T3hhRklVMWpNbjhxZTI5WnV3U3lUNWs5RklSUVdHQXN0UTkwYi9HZHVORWc3?=
 =?utf-8?B?OHVXUzcvZkRKM2syN0FqNm9IeUJoejd1QXNIenUwbnBiUEVjaDdqRERYUHh2?=
 =?utf-8?B?dmgvNUkzMk5INTlwMWFGeUQ2Y1JXNldCS2tXZlJ2bzBxcnhYbUpKMkZScDVC?=
 =?utf-8?B?bVZEZURXOWFTSHV1T0dRN2RJaVcwUjkxSHlnUGdFWnVSb0xDWnUvSkUzM0Fr?=
 =?utf-8?B?eFJjdGxadmlheXBhcXZZTksvazVZeTdNWER2NFFkLysvanNGSEY2U1BUcWdP?=
 =?utf-8?B?ZzB3cnd0OVo3YjcrZ0h5c3paVXBVWVJGQkJLY3ZacWNIbzluTE1JeXMweUZa?=
 =?utf-8?B?a0VoQUV4ZVgzZ3VEeEdUZDFSdHpzS3lpNG9PYmhuZUhiZVdDdGd1RXZVSWVo?=
 =?utf-8?B?QTBzRlJvYjlBeGpYSURESVNjZDdEZ3J0elpMaUdYajVMc212SXh1NDNvSEdh?=
 =?utf-8?B?eGlkSVMvWXRrcXdIQ3FSVXdLQS85TUFaSmlvblpNMVRTNndhamQ0YW4zV2tz?=
 =?utf-8?Q?2UiWiDiPYMz/vraSwho/37N4pLSK9A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkh0Q0Q0ZldKaFR3d04zdU8vaFlwbEgyZi9uTkcveno2U1ZoVlNsQTlQZkxK?=
 =?utf-8?B?TTFJVnQ5SzB4WDVKd1lWZjZWbGlQeVhGZDNxTmU4cGV6aE1jNVh6dHYvMGlP?=
 =?utf-8?B?dmtYTmZ3c2dhNG0vaW9HYitDSkptUUZvM2pWaW1qS2pBMUpGbk00NGpJbGM0?=
 =?utf-8?B?Mlo0TWE2SnpXZlMyNkUrQktaL1N6S1ZvU3h2VzV4bnh5RDIzdFpadUE5L1VE?=
 =?utf-8?B?aDdPQjJGWVg2akFVUWs3ZXhtNjZMc0lmMW9wN0l6SnoySFVIUm52RmRVQncz?=
 =?utf-8?B?Zk5BNVBPQ0dYcjFQV2F2RWNLWUxBVlNrdk9Ia3BZdGJFc3owcEFQbkN1eVpE?=
 =?utf-8?B?YkFvNGJmOEdEbXhRRHZ5SHhDSW5wODNJT0lXZEpSVy9pa211L3llZzRENk5X?=
 =?utf-8?B?c21WOEp3RjBUTVdlZHhqeXExMmkycXlsUkc0MDJRb2E0bTFhQ0RxQXp4R1BE?=
 =?utf-8?B?TmFYRmJYRnFuNFNHQzkxaDZoQ1o2dW93Zi82OTZoWEV6KzFkQmtTcjlJSWZY?=
 =?utf-8?B?VUpqNFJtekdTd2hMQ2ZYQkltSWVHNUNqaHhxQktKcHhWMEJBS0JqaFJGM2pM?=
 =?utf-8?B?LzJNQlhIcjVMdHhuSTYxY01JbTdjWnhoUHhhUmt5azA5bFpuTU9yc1VlTDlL?=
 =?utf-8?B?RkRUZVFHUVhFdkxFa1MreUNtMjdkbWMvRkcwd2dQT295cnRadThFNkYxUm1O?=
 =?utf-8?B?NlJwMVZua2lOUU1POFRJaHhpYnZLRkcrWnB5M3VYTDdKWHI5ZjRwVjhzNzZ2?=
 =?utf-8?B?LzRzUDlTdEN1cTY3UndKc2hVSnNzY3lrVlR3TGJqMWZ1c0dNL3NTMnJQcmlx?=
 =?utf-8?B?OVdVNVpTVUREOEdzTE5xQkowazB5aVMyeGlSMFdDYkErc1FmeW5JRTNDamRp?=
 =?utf-8?B?dGVleTk5SUxTeGtNNHdnQzB6bUVBNW1wMnJWYm42aEt0NzZtdlVqSHJpZ3Y4?=
 =?utf-8?B?QjFKUFdoOHNiMytUVjRKOVBjdFhUdVNXTWlVZWZiMUl2Y0JPOVpNSFgwTXFZ?=
 =?utf-8?B?TFZvWm9aN0VoSWQ5TEZXR2JFNVhzMjdveDZLOGdqT0ZIc0V6MnJxcHRKYlRW?=
 =?utf-8?B?VWUwM0NPSzFnV2Q5WkNWOWtPOC9MbWdxbjhLWnZZVDlDeEoyTzIyZHJpTVJ1?=
 =?utf-8?B?NWU0SEwzZFZmUUN1a0RWZk1EOXBzU2pXMnNPRlJxUTR0V1ZQUUxzZmp0Wjl2?=
 =?utf-8?B?UWN3TmpBbTRjS3B5anRGMHNuMmJSd29vOGJnNFlnQTZoOThjQTRwZXhGanU1?=
 =?utf-8?B?cGhBKy80cDVOcDJQcEhFRFd3WG5lWWZ5dEdtK2V5djhsZlpXQXVzZzZLdzVS?=
 =?utf-8?B?azh5d05IcjhKK3I3QjBvMWh5TlFyN3MrT1lEeHZ2WmVZdjNaZXlMU2VQdFFq?=
 =?utf-8?B?c1lYaXZKNXRaMG0wTDJyTndiUHhZRDFNcWoxc2huOWhPMW5pekN0UDNDVE12?=
 =?utf-8?B?c045Z3ZEOStGcEhaU0JHTkhBL1k4N3pXdSsyZFp2V3EyRnQzM3E1aVdPL21I?=
 =?utf-8?B?T1k2VUZWT2QrOGFSemRWazQ5ckRrWFc0K0hOdEFiVFNoMTZRdUo1YnZRMW1v?=
 =?utf-8?B?Y3dxVkVoMHhadmFNd3hFeXpxWHF4STNUejdsUUc5RnNDdTlYcVJDMzhvQXVJ?=
 =?utf-8?B?LzRPSTVyaWUyVWg0N21lWGN3RVh2K05PTzhteFh1OVNLUk0wQTlGMzRld0tO?=
 =?utf-8?B?ZUZueWxBY203U2VGMTZLN1VHMS9QdzltUjZpTU41MWhGMmxCQjNocEM5UE03?=
 =?utf-8?B?NFk2cStoWEFvc2s4NEdiYTJSRlpWa2gyMS9RZldHQXU1QndVSHFkT0RZZk03?=
 =?utf-8?B?dWVOOUo3Zy81T2ZWMGozZTU3Z05aM09VcmpDL0VQbVN3MGNaUnM0bi82OGVp?=
 =?utf-8?B?RW4zdVdtM2E2aXhzWGNkYVZyejdCeStmNHZueGdBNXAyRlJFZDM2ZGRrVGxW?=
 =?utf-8?B?bHhjazR6WUptRDJmZ3dWSkU4RHhac2l5Sk9kN1NHL3AzYkV4cFQ0Z0NCVTdw?=
 =?utf-8?B?L1NjUmxPdzgxVzNRZHNFTFp5cVd6QzBKeUNkRVNsenlnK2ZpYXZoTjlqSzNk?=
 =?utf-8?B?ajM3clpUeFF0N3Y2VTJaV3E1c0RIanhwVVluZmNZZUwzTy9ySGExY2tmQ1Ix?=
 =?utf-8?Q?onfc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcddb81-e21e-4756-1107-08ddace9d68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 15:24:08.2953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2R3p6TxmcfUQVVVNuT8A6P0lcJkpeJsZ5NX1/mYamektNOYKR+oaf6/sUnoPQS08URFzw8zKyJlcS+8qO/lDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQpTZW50OiBNb25kYXksIEp1bmUgMTYsIDIwMjUgMTE6MDUgUE0NClRvOiBB
bGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IFpoYW5nLCBKZXNzZShKaWUpIDxK
ZXNzZS5aaGFuZ0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgS2ltLCBKb25hdGhhbiA8Sm9uYXRo
YW4uS2ltQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBkcm0vYW1kZ3B1OiBGaXgg
U0RNQSBVVENfTDEgaGFuZGxpbmcgZHVyaW5nIHN0YXJ0L3N0b3Agc2VxdWVuY2VzDQoNCg0KDQpP
biA2LzE2LzIwMjUgODoyOCBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBPbiBNb24sIEp1biAx
NiwgMjAyNSBhdCAxMDo0N+KAr0FNIEplc3NlIFpoYW5nIDxqZXNzZS56aGFuZ0BhbWQuY29tPiB3
cm90ZToNCj4+DQo+PiBUaGlzIGNvbW1pdCBtYWtlcyB0d28ga2V5IGZpeGVzIHRvIFNETUEgdjQu
NC4yIGhhbmRsaW5nOg0KPj4NCj4+IDEuIGRpc2FibGUgVVRDX0wxIGluIHNkbWFfY250bCByZWdp
c3RlciB3aGVuIHN0b3BwaW5nIFNETUEgZW5naW5lcw0KPj4gICAgYnkgcmVhZGluZyB0aGUgY3Vy
cmVudCB2YWx1ZSBiZWZvcmUgbW9kaWZ5aW5nIFVUQ19MMV9FTkFCTEUgYml0Lg0KPj4NCj4+IDIu
IEVuc3VyZSBVVENfTDFfRU5BQkxFIGlzIGNvbnNpc3RlbnRseSBtYW5hZ2VkIGJ5Og0KPj4gICAg
LSBBZGRpbmcgdGhlIG1pc3NpbmcgcmVnaXN0ZXIgd3JpdGUgd2hlbiBlbmFibGluZyBVVENfTDEg
ZHVyaW5nIHN0YXJ0DQo+PiAgICAtIEtlZXBpbmcgVVRDX0wxIGVuYWJsZWQgYnkgZGVmYXVsdCBh
cyBwZXIgaGFyZHdhcmUgcmVxdWlyZW1lbnRzDQo+Pg0KPj4gRml4ZXMgdGhlIGNvbW1pdCA3ZjAz
YjFkMTRkNTEgKCJkcm0vYW1kZ3B1Og0KPj4gUmVtb3ZlIHNkbWEgaGFsdC91bmhhbHQgZHVyaW5n
IGZyb250ZG9vciBsb2FkIikgYnkgbWFpbnRhaW5pbmcgcHJvcGVyDQo+PiBTRE1BIGNvbnRyb2xs
ZXIgc3RhdGUgZHVyaW5nIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlcy4NCj4NCj4gUHJvcGVyIGZp
eGVzIHRhZyBmb3JtYXR0aW5nOg0KPg0KPiBGaXhlczogN2YwM2IxZDE0ZDUxICgiZHJtL2FtZGdw
dTogUmVtb3ZlIHNkbWEgaGFsdC91bmhhbHQgZHVyaW5nDQo+IGZyb250ZG9vciBsb2FkIikNCj4N
Cg0KVGhlIGRlZmF1bHQgcmVzZXQgdmFsdWUgb2YgdGhhdCBmaWVsZCBpcyAxLiBLZWVwaW5nIFNE
TUEgdW5oYWx0ZWQgYnV0IHJpbmdzIGRpc2FibGVkIHNob3VsZG4ndCBpZGVhbGx5IGJlIGEgcHJv
YmxlbSAtIHNob3VsZCBiZSBzaW1pbGFyIHRvIHRoZSBjYXNlIHdoZW4gaXQncyBsb2FkZWQgYWxz
by4NCg0KWWVzLCBMaWpvLCBJIHdpbGwgcmVtb3ZlIHRoZSByZWxhdGVkIGRlc2NyaXB0aW9uIHdo
ZW4gc3VibWl0dGluZy4gVGhpcyBpcyBvdXIgcHJvYmxlbS4gV2UgbmVlZCBhIHdvcmthcm91bmQg
dG8gZW5hYmxlIFNETUFfQ05UTDo6VVRDX0wxLiBCZWNhdXNlIHdoZW4gd2UgY2FsbCBzbXUgcXVl
dWUgcmVzZXQgaW50ZXJmYWNlLA0KaXQgZGlzYWJsZXMgVVRDX0wxLg0KDQpSZWdhcmRzDQpKZXNz
ZQ0KVGhhbmtzLA0KTGlqbw0KDQo+Pg0KPj4gdjI6IENvcnJlY3QgU0RNQV9DTlRMIHNldHRpbmcg
KFBoaWxpcCkNCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2lt
QGFtZC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1k
LmNvbT4NCj4NCj4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRf
NF8yLmMgfCA2ICsrKysrLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92NF80XzIuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0
XzRfMi5jDQo+PiBpbmRleCBlNmFmNTBjOTQ3YTEuLjUyMTU3YWNhYjU1YSAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4+IEBAIC00OTIsNyArNDky
LDcgQEAgc3RhdGljIHZvaWQgc2RtYV92NF80XzJfaW5zdF9nZnhfc3RvcChzdHJ1Y3QNCj4+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsICB7DQo+PiAgICAgICAgIHN0cnVjdCBhbWRncHVfcmluZyAqc2Rt
YVtBTURHUFVfTUFYX1NETUFfSU5TVEFOQ0VTXTsNCj4+ICAgICAgICAgdTMyIGRvb3JiZWxsX29m
ZnNldCwgZG9vcmJlbGw7DQo+PiAtICAgICAgIHUzMiByYl9jbnRsLCBpYl9jbnRsOw0KPj4gKyAg
ICAgICB1MzIgcmJfY250bCwgaWJfY250bCwgc2RtYV9jbnRsOw0KPj4gICAgICAgICBpbnQgaTsN
Cj4+DQo+PiAgICAgICAgIGZvcl9lYWNoX2luc3QoaSwgaW5zdF9tYXNrKSB7IEBAIC01MDQsNiAr
NTA0LDkgQEAgc3RhdGljIHZvaWQNCj4+IHNkbWFfdjRfNF8yX2luc3RfZ2Z4X3N0b3Aoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiAgICAgICAgICAgICAgICAgaWJfY250bCA9IFJSRUcz
Ml9TRE1BKGksIHJlZ1NETUFfR0ZYX0lCX0NOVEwpOw0KPj4gICAgICAgICAgICAgICAgIGliX2Nu
dGwgPSBSRUdfU0VUX0ZJRUxEKGliX2NudGwsIFNETUFfR0ZYX0lCX0NOVEwsIElCX0VOQUJMRSwg
MCk7DQo+PiAgICAgICAgICAgICAgICAgV1JFRzMyX1NETUEoaSwgcmVnU0RNQV9HRlhfSUJfQ05U
TCwgaWJfY250bCk7DQo+PiArICAgICAgICAgICAgICAgc2RtYV9jbnRsID0gUlJFRzMyX1NETUEo
aSwgU0RNQV9DTlRMKTsNCj4+ICsgICAgICAgICAgICAgICBzZG1hX2NudGwgPSBSRUdfU0VUX0ZJ
RUxEKHNkbWFfY250bCwgU0RNQV9DTlRMLCBVVENfTDFfRU5BQkxFLCAwKTsNCj4+ICsgICAgICAg
ICAgICAgICBXUkVHMzJfU0RNQShpLCByZWdTRE1BX0NOVEwsIHNkbWFfY250bCk7DQo+Pg0KPj4g
ICAgICAgICAgICAgICAgIGlmIChzZG1hW2ldLT51c2VfZG9vcmJlbGwpIHsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGRvb3JiZWxsID0gUlJFRzMyX1NETUEoaSwNCj4+IHJlZ1NETUFfR0ZY
X0RPT1JCRUxMKTsgQEAgLTk5Nyw2ICsxMDAwLDcgQEAgc3RhdGljIGludCBzZG1hX3Y0XzRfMl9p
bnN0X3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4gICAgICAgICAgICAgICAg
IC8qIHNldCB1dGMgbDEgZW5hYmxlIGZsYWcgYWx3YXlzIHRvIDEgKi8NCj4+ICAgICAgICAgICAg
ICAgICB0ZW1wID0gUlJFRzMyX1NETUEoaSwgcmVnU0RNQV9DTlRMKTsNCj4+ICAgICAgICAgICAg
ICAgICB0ZW1wID0gUkVHX1NFVF9GSUVMRCh0ZW1wLCBTRE1BX0NOVEwsIFVUQ19MMV9FTkFCTEUs
DQo+PiAxKTsNCj4+ICsgICAgICAgICAgICAgICBXUkVHMzJfU0RNQShpLCByZWdTRE1BX0NOVEws
IHRlbXApOw0KPj4NCj4+ICAgICAgICAgICAgICAgICBpZiAoYW1kZ3B1X2lwX3ZlcnNpb24oYWRl
diwgU0RNQTBfSFdJUCwgMCkgPCBJUF9WRVJTSU9OKDQsIDQsIDUpKSB7DQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiBlbmFibGUgY29udGV4dCBlbXB0eSBpbnRlcnJ1cHQgZHVyaW5nDQo+
PiBpbml0aWFsaXphdGlvbiAqLw0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCg0K
