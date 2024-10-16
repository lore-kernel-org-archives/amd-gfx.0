Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30ADD2A531
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 16:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B6010E050;
	Wed, 16 Oct 2024 16:07:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sAnehQMf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC9910E050
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 16:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/Zffd4ZAylx3izFoCG900r/npIlY/NrvVzLDXZGTXNdcabidWjM6liD3xER7IBUisd4FLjbj6gpDJkjZXBko6w8VZMyGtLoVydQZMmsGIY3R66j3pXnJ5emYt0ZCHrjSpxtZ8pTh65u8VYofaf+NGCKUlp2zbkTM86j6bZEESwg25g2bcxWzeauZkw2jyp0WQr8T0bKT8TJcdqFvEok7WBlMWaihXQ6EIFmOXpQO2dG8coKvVWnpnIAnKgk3F0WUot83a8HzLTjIUSXhlgTmjy0dM3Ena1fS5RxESCGIIlFL2xEFm6oGGSd2Onn9azFMbmVH4MKXD2gsqwR0XsAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg4SvqjAulk6tFvw1uR1NPXobunNyM74JduF0fDOKbQ=;
 b=BKVCKFMHUhA5VbRnp9WqmvokohaFjv5JNIs7QFp+pQUQp/r4fBQBGDtvGJgbTl55XLDGAs+MBdvzHRELVfV1vNwVez3DjFEL4zHCCVRWB3swiA+DYgjv8JssYGHtYmIOaS2eOHtLjQ3ZqvKI+Gg6kPlAZsRNXiGjZvRICIDqrJe37XvdEY3t6SGboJFhAc6Ro457G6oAs8PyfnwG09Sot6sm7vicw4M+wXJ1A63ybnamoUX9bEpBe8YqUBkeHQxfADwkqinzfrieE+5K5H8t64/QYqRR+FtgQVh8CtCAOCTr4aQHZcQgKVBy0xUGHSIUAEWkvpcMlnL3ICtFYXip0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg4SvqjAulk6tFvw1uR1NPXobunNyM74JduF0fDOKbQ=;
 b=sAnehQMfyzATKqDKntiP6psXxJaSitpQfzCGjwqfynWixxtagg9u4xomNsEitkc50+CwlbPt+xVn3RnmrPPdnrltdPDHR5ewmq2BJsL/RSHZmh0YlsG1zuypJ1CkCWIF4Is8BgE6wN0R4F/PPB6Rw/eMyyV4eSqSAltpJAvkgUI=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 16 Oct
 2024 16:07:10 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:07:09 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>,
 "Zhou, Hao (Claire)" <Hao.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
Thread-Topic: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
Thread-Index: AQHbHsrLxm7tqLwrx0GjESM6xLaItbKJXZSAgAAt32A=
Date: Wed, 16 Oct 2024 16:07:09 +0000
Message-ID: <DM8PR12MB53993F24544631CE138C41EFE5462@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20241015062316.3050046-1-lijo.lazar@amd.com>
 <7cd47976-10c9-41d1-9e48-8b47617b3d48@amd.com>
In-Reply-To: <7cd47976-10c9-41d1-9e48-8b47617b3d48@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=faf92a7d-715e-4d74-9ff1-68fb586a0068;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-16T16:00:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SA1PR12MB8888:EE_
x-ms-office365-filtering-correlation-id: 140463d3-93d6-4ec7-fcbe-08dcedfc96ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N3NySmVDcUtvNmZzVFpqT3dlQWNQYmwrZG5iWGp1NVFDMjlFVURhWFRnQjVt?=
 =?utf-8?B?MGM0emxYc3c5SmNLRmx3OUZXbVFGY0xRWDNxdXJ4TW4zTmpsL0ZoZWlLcHpE?=
 =?utf-8?B?VXZ3ZXJJWVRzclZ1RVU0YTVxRjhUSHF5Tkp4OE42NXRtK3JuRzN5bm5COWVQ?=
 =?utf-8?B?MHpJaHNvTEIyVThTd0xwS3V0dkdaSFZZUW5iOU1EMTNtbXZOeFhqTCtxb3p4?=
 =?utf-8?B?QjFaMm0vblNTZmZQb1JqM0NTbkxBSUQyUGlDbFJwRnRkRVlQa2Q5LzZQelh0?=
 =?utf-8?B?ZUxYZVRZWTdtKzBJb1VYNlhRaXJXaGZMQ3NlVTlOTkhrSU9Ra0RNaUkxc1k1?=
 =?utf-8?B?UHRJSlRLMU5KTnArRXBpT01ZMXU0MGxNd2VTNk8ydTA5dHBQVjNuSGdZZGZN?=
 =?utf-8?B?THpybFNoaWR5dGM2MEFmK2xvZDdFMUg0Qkxvbk5BUjVTa1haNElZcE1vNEFC?=
 =?utf-8?B?WDk2NXNhVmp5Yzl2Y2pwekxwZVh0ZWtqZHI2dWh2WU9tN2d2QWhmQ1NPUmUr?=
 =?utf-8?B?TFRKeXRpU3ZkQzRwWEFyZ3IxM211RklZMk56Mzh0cnpGcitaUFhwdktNQXZC?=
 =?utf-8?B?SE5TUDRXMW5vL1FXTmpaZVpia3Z3RmVjYU1vMjJuZVVVMmNQeCtxZFNGWlFS?=
 =?utf-8?B?NnQrOWp6T3M5cGtKeDRIQzY5Q1I2NzcraE5QWmZUTEtpMm12TXlSMFNWMEw5?=
 =?utf-8?B?VmFOVHovanZWYWhJZFNBR1pNbXdyUG9jeFkvWThrc3hsRGZpYmR5QUg3RTJC?=
 =?utf-8?B?NW4wTUVKcWlXNklGM1NuK0h5M1BWSXBZZTZjY1BNWlRHOTY3MnkraHI2VW52?=
 =?utf-8?B?Y0Q3REl6VW15aElTOWdPeTRGL2NuRkxTVi81c0Z4ZlY0N0N5NWJwTFcrb2w5?=
 =?utf-8?B?UlVJVXRzRTUvcnlRczhxWHJycEMyREhPQksyem9ndm0xOXBFSjJRaVRtWTFQ?=
 =?utf-8?B?Z1RXSEtaWW9SMEJaR2ZCa01TRU45YlFCSHloMENoQ0wvMTFLd2QwSEl0L1hX?=
 =?utf-8?B?aGx0MlJlSjhkeGQxQ0JxaGVUWEwzdjhKalB3L1F6eEo2ZFFxMkNRTVFnazUz?=
 =?utf-8?B?MDVjQ2dsZ0YwWHl5eFBsUXo1TjNhamdRRGpKQU1PRVpQQWJ2eGJhQ2F2Y1Br?=
 =?utf-8?B?M0FjU0tZRExiZTJqVVVIVjZMMExSY2ZQMEpFeit2d2FIMXZFREdxQzFBOEJ6?=
 =?utf-8?B?RkNLRzg2Uk5zNXlCdHNMZSswRmZpRlk3aFhwMjNSaVV1d2ErNHdub3UwdDRo?=
 =?utf-8?B?clJ6cFZ2cHliOTZReTFlZ2U1VVR2Q0FtdTd4NXh6ZklxcHBNaUtaYm55RndZ?=
 =?utf-8?B?QkdobzEvSm4rcU5QOWVZd1VCV2psR2k1T0pEUXJtZnNKUnF4WnF3QTUwNnIy?=
 =?utf-8?B?amcyNDF5ODZyLzUrdmZJN1dxb3pnaEx5Y0l6RXZRbThGS2pYR3o2VkIzalMy?=
 =?utf-8?B?YzRtT0JHZlUybkNRMEtQeTkybjRaYk5mK0hNdWJmVDFQMEUyS0FBZVBjeldJ?=
 =?utf-8?B?MDZOYUdwYmZpMzJ1c1p0cjVGczVKeWQ4ZUF2S05oemtXa0toREtzRmtEMUdz?=
 =?utf-8?B?MFd3L3krekZpTFZJT1d2L21UQ0x5Mk9heU51SURrS1NHeklUTVl2V3pvZjFy?=
 =?utf-8?B?T0o4NXMvNTFTUzhRbWd0VDdodU80NlZ5akh6VEtJdk05bG03TlJFWFQ0dzFw?=
 =?utf-8?B?blo4SkhuMytlandScHNZYXlSTUdWS1dRa2dxZDlVbEdvWmprN3Z1SzhyS3lC?=
 =?utf-8?B?eEhQV0FidlNYTFBqVm85YVZaVUZJa3NuWUhaaGNNdFZxSWlEWElzNnJrMUJM?=
 =?utf-8?B?OHF6NEFzTE51dXdZSVBNUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzFpQURhM1BYelRKUGNOakcwVzh2RUljNm1qS0lCbDZpbmVtcVZWRHB1enl1?=
 =?utf-8?B?MnBOSDc1Zmh0ZXplTTdBOHlNaG1sSis3dEZZMkdkSmcyME9PRjlOdkF4TFdS?=
 =?utf-8?B?cjE4cnZHZkIxWWczUStFZzZuci9zaXJpOUJCNHZZZ2p4SWY3ZnZjMTBkK1BN?=
 =?utf-8?B?clZNZG9odHNvSW9kdkllK1N4Y291Wkc4MUd2Y3VTb1pCajQyZEd4K1RIdjF2?=
 =?utf-8?B?c254S0k3MEt3UC9vbEs5TGpsTVhpV2w3bEQ0MUdwaDUzZDlXSmRCd2V2bHY3?=
 =?utf-8?B?bTVNa2tVdllIMjlIbUJidlpQRUpFelZ4eXhSZ1ljdE5rQlJlRVVpYXRqSG1x?=
 =?utf-8?B?dlFZWCtub0E2MzNPQ29nNXRSZmVwbS8xUm9JS2IzQ3hvdVUvZTc5RU10WU4x?=
 =?utf-8?B?Tk1wZ3FLdVdjeU9oNGpUM0JSS1BQeHo5aU45TWVUeFhVd1JrNHU4UlNMa3Zt?=
 =?utf-8?B?VG8vQXdIZlNyMGk5Rlk5U2o0c1pab0ZoNmZBTklBcHh6MFl5Znh3Mm1MaVhp?=
 =?utf-8?B?dGU1Mndlci9LZHBvdTVzcDhSZ05iODliL0IxTVMzZTJiNThsWFprbU9NUzd3?=
 =?utf-8?B?UUEzSTBTTllkTnR0Q3lxSmRqT2dyb1dUZFZNK3NkaUVNYjdtVG5zeHhmWktr?=
 =?utf-8?B?N09zSCtrVHhOYS9MRmhiTHByRkIyR0Racjdqc2IxckZHT3lFSWN0TmE2MHRS?=
 =?utf-8?B?ZURDYUJaSkM1MVpBVGdPcUpLV1FHWFQ4Sk41cEJiWHpjcFlHSi9zOTZuZWtn?=
 =?utf-8?B?NHJuUXdjL3ZvRjc0Nm90d0paWmpLdFlVT3kzeklWKzFXT09YU1VZdUxWeXM2?=
 =?utf-8?B?Rzd0azZmSnR4YTU5WHcxTGI3STBrWUtNclV0dnd0Ti9kbzRER1h0b0NQNXlt?=
 =?utf-8?B?cWFhcG5FOUJwbGtRSXpjY3c2d09PdXU3bzdDUVZWWTdqaHhPUUVUQi8wYXBh?=
 =?utf-8?B?SEwvMXJzbExOU0VIdnN3eUh5ZU9SdWd1MEdPdzNrWlFOU3dzdnZaZjd1Mmcy?=
 =?utf-8?B?ek1ZVW16MTFpcG9YeVFmVlhyZGZzeXNLR3BNdkNzTzFTZTJ6WVM2THV5STBu?=
 =?utf-8?B?Vks5bDREVUN2RE5CMVFUdDZIb2h0ald5VkthOHYvY0dieEtxTXg3TkZaZ3dL?=
 =?utf-8?B?MGJ1cDgrRFhlZ04yVm5Qbm5STEVOcEFhb3QrczRXRHVFaWpIVGZiaG1oZmxl?=
 =?utf-8?B?c255bk5zZTJLTTJldzZwQ1dJSmh0U3YyV0xIVTI2NWVsM24vWVRSR1o4Mzln?=
 =?utf-8?B?ejI5Y1Bmd0oxVVJaaWVqSXBQMjBuSVNtMTZHRmJMK0p1UXplbDcrTFNJd3R4?=
 =?utf-8?B?VWxBM01qeFIyMmliWXRBZmVwZ2dTNFRsUi9ad1pHanY2WkVXOFlzeVhiU1hv?=
 =?utf-8?B?eXlUY2YwN1gycHFwdk5JQkVBeGNQK0N6djBHZWkwU1h2Ylg4V2t2NXJxdEQw?=
 =?utf-8?B?cVp0Q2dpaG5idVdtYzVndGYra2prZjIvbnd0bmg2bE4wRWVyK3pvWTh6RlFE?=
 =?utf-8?B?OVJoYWRzcUVrSUdMSXY0Q041WmlHSXh0V3J3WXp6VGRPMVR5RXlMRm85MVhz?=
 =?utf-8?B?dnNvNUJkREZ1VC9kSG90Qk1GQ1ZjVkRtb1NDMkZsMUlMNWhxWEVVQzI1d0ZH?=
 =?utf-8?B?Z3E4a1FqdkxEQXBaSzNCT3d3MUo1WjdsWDNJdWNoQ2FQMTNrQm1WVVBhb0g4?=
 =?utf-8?B?SkdMVHFYZ0FSRU1ST3h3Z0doTTdpQ2pPVXRma096TFdxTXc4ZnJqaGJySWJi?=
 =?utf-8?B?UmlrU1NINzg4bDExV2NtejkxMDBRblYzMG4zWXpvZXRrTWQ5bHdsTHUvYnNj?=
 =?utf-8?B?NGFLYjVMOHNIMFJkYzg5blkxSXB4QjJzNWYzSGR0OTlIZ2NhS1BaZm5mVjN0?=
 =?utf-8?B?OXdzN3FmNGlrQ3ExQUhnZEhQRU5xNzkrMVo5dENhaEVOYmx0eXl4MDc4L2cw?=
 =?utf-8?B?cGRCNTZJbHN6ZENoN1V4VGJXY3hqZXVlczNFZ1AyUG1YQ2M0LzNnWndFTExw?=
 =?utf-8?B?WGRnOEtzalRPM1loeG9yNXI2MS9xNjlCZkRTUlp6ZFN2RW9MbTBpeVVsVlFz?=
 =?utf-8?B?cHdPYU5JRHg3Tm1pVU1ycDg5aVE1NEd2Tzh0MmFvSHBVZHJ2ZlF2TzZHcDg4?=
 =?utf-8?Q?VUyg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140463d3-93d6-4ec7-fcbe-08dcedfc96ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 16:07:09.7076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZO8PWx2oUZQhaFVthhcDJN5/iwwHKB2/XbbqF572glGhJawxP0M6oeWCsreoePc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBPY3RvYmVyIDE2LCAyMDI0IDk6
MTYgQU0NCj4gVG86IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl1LCBMZW8NCj4gPExlby5MaXVAYW1kLmNvbT4NCj4gQ2M6
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1
bWFyDQo+IDxTYXRoaXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT47IEppYW5nLCBTb25ueQ0K
PiA8U29ubnkuSmlhbmdAYW1kLmNvbT47IFpob3UsIEhhbyAoQ2xhaXJlKSA8SGFvLlpob3VAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogU2F2ZSBWQ04gc2hhcmVk
IG1lbW9yeSB3aXRoIGluaXQgcmVzZXQNCj4NCj4gQW0gMTUuMTAuMjQgdW0gMDg6MjMgc2Nocmll
YiBMaWpvIExhemFyOg0KPiA+IFZDTiBzaGFyZWQgbWVtb3J5IGlzIGluIGZyYW1lYnVmZmVyIGFu
ZCB0aGVyZSBhcmUgc29tZSBmbGFncw0KPiA+IGluaXRpYWxpemVkIGR1cmluZyBzd19pbml0LiBJ
ZGVhbGx5LCBzdWNoIHByb2dyYW1taW5nIHNob3VsZCBiZSBkdXJpbmcNCj4gaHdfaW5pdC4NCj4N
Cj4gSUlSQyB0aGF0IHdhcyBpbnRlbnRpb25hbGx5IG5vdCBkb25lIGR1cmluZyBod19pbml0IGZv
ciBzb21lIHJlYXNvbi4NCj4gQExlbyBkbyB5b3UgcmVtZW1iZXIgd2h5Pw0KPg0KDQpXZSBuZWVk
IHRvIGtlZXAgc29tZSBvZiB0aGUgc3RhdHVzIGZyb20gc2hhcmUgbWVtb3J5KGRyaXZlciBhbmQg
RlcpLCBzaW5jZSBzb21lIG9mIHRoZW0gYXJlIGNoYW5nZWQgYnkgRlcsIHRoYXQgaXMgd2h5IHRo
ZSBpbml0IGNhbm5vdCBiZSBpbiB0aGUgaHdfaW5pdCBzdGFnZSB3aXRoIHN1c3BlbmQvcmVzdW1l
IGNhc2UuDQoNCiAraW50IGFtZGdwdV92Y25fc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikgew0KID4gKyAgICBib29sIGluX3Jhc19pbnRyID0gYW1kZ3B1X3Jhc19pbnRyX3RyaWdn
ZXJlZCgpOw0KID4gKw0KID4gKyAgICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnZj
bi5pZGxlX3dvcmspOw0KID4gKw0KID4gKyAgICAvKiBlcnJfZXZlbnRfYXRodWIgd2lsbCBjb3Jy
dXB0IFZDUFUgYnVmZmVyLCBzbyB3ZSBuZWVkIHRvDQogPiArICAgICAqIHJlc3RvcmUgZncgZGF0
YSBhbmQgY2xlYXIgYnVmZmVyIGluIGFtZGdwdV92Y25fcmVzdW1lKCkgKi8NCiA+ICsgICAgaWYg
KGluX3Jhc19pbnRyKQ0KID4gKyAgICAgICAgICAgIHJldHVybiAwOw0KID4gKw0KID4gKyAgICBy
ZXR1cm4gYW1kZ3B1X3Zjbl9zYXZlX2Z3X3NoYXJlZF9yZWdpb24oYWRldik7DQpUaGUgc2F2ZWQg
Ym8gaGVyZSBpcyBub3Qgb25seSBmb3IgZncgc2hhcmVkIG1lbW9yeSwgYWxzbyBmb3IgRlcgcnVu
dGltZSBzdGFjay9oZWFwIGFzIHdlbGwuDQoNClJlZ2FyZHMsDQpMZW8NCg0KID4gK30NCiA+ICsN
Cg==
