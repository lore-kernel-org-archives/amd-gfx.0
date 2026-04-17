Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0B9F99C63
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 21:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E429E10EABE;
	Fri, 17 Apr 2026 21:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cESI5VZM";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B3410EABE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 21:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baQFxEGSKlkfCw8las4iBY9YDfuUxDse68vcANQoFdn66lcP+bvbYDPkImySeNf7z8g0BijzNFosAgDtOlRAEKc8z0Sn+g36lyGf5gFPCd5jMc2b5iqqH58m2yi9B0Oaq3PNx7lI0EqMcpK9HmGvm2HbCnFbvuQx/svzQM0/ddj//kVkbwdxvCyqNcIVyEppX0gCHhnRAfJUZ7bgkKSfuVMeL8YLF4BhMmZiodaGAyjBVqCGMJgzSWEfP/97jeT2V8/pqrWwcRtoxbMBJ0rixkox0/Ba6fOKyLu62sbpFrtZgod+Lg0IByfqEDwjLtgspn/Euu7B8V9TElWP93rmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYnfhZq1mOj6qVeA2A1c5PC4ZDcjqj8lAXdnwTGOx2I=;
 b=bBPTDu/tP01ji5cuFPgW01ZVn5QNd82Ijswz0s3wzwhM2liMl1Qm5XnYzBoarINMhUCUUKX7O1UuZRQK2KsTJ9PoQqHpLor5ASDsh+KJ7tSVc1rd/jwHJTrEWxg8Zhaji8hMl5Tlz7Yogjs8W3+43IhsUNslvjg4oEjVy9ux6/dpkj3HaryNBrwxqHJe+vUnf874NEcYsPKoNLhTYNANj5rYmkpZI4bF+wVUqV/hV1cXHAOHNC98v2ReMYXjU4VWJidfk5ZMCakhelGbEhwuxyiMxo7Iuhir2qXm9fKToIhY/6QGTC1bTG2sp6uJXuqURqg3VSzbvbuNf8Z3JUHoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYnfhZq1mOj6qVeA2A1c5PC4ZDcjqj8lAXdnwTGOx2I=;
 b=cESI5VZM5n53o0XqhRGS4fuQreaq+0vPZyCnsXapLQl9KMLKIq/K1Ziy/0SB/3XXofcnxws5cfivAq+1JMQgPEBmSkittFQrCNO8EgqfquWe4uSKnJJypeR6wF1O81mYdje8vizrTuWnYg3Gut6snjUEhzZrbs/sB+No/gQthdM=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:59:30 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:59:30 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 08/16] drm/amdgpu/gfx12.1: align mqd settings with KFD
Thread-Topic: [PATCH 08/16] drm/amdgpu/gfx12.1: align mqd settings with KFD
Thread-Index: AQHctuDOZhnwlkXTX0eAMO6rv8WKN7XNd5OAgBZBLwCAAELJYA==
Date: Fri, 17 Apr 2026 21:59:29 +0000
Message-ID: <BL3PR12MB64250281E4CDCF1A3DD36FF9EE202@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
 <20260318140837.582776-8-alexander.deucher@amd.com>
 <CADnq5_N-b61C4=n_L87J6Pyf_Tv7UCGse317qYzECPtK_OgnZw@mail.gmail.com>
 <CADnq5_N-r_Y=p-n4BM3C_-KouuLkapiNbjYvcEcg2J3j512cXw@mail.gmail.com>
In-Reply-To: <CADnq5_N-r_Y=p-n4BM3C_-KouuLkapiNbjYvcEcg2J3j512cXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-17T21:53:39.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DS0PR12MB6608:EE_
x-ms-office365-filtering-correlation-id: 64981147-f78a-4a67-05b3-08de9ccc99c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: qp4tyb8HHMD81Uck9+lnkBl3/IvWS3t8HeYJOQebNo5uwyEkUktj0V1RWBTf633FASmYmhWqptwP7bscdLZGQtuxOX70Djy6vqOumLADRXMoGqBja3wuBlR0eQ60emFCgxVY4CrGQ+nxA92hKx3wRy49mYKZsCNRFX8rtz4qrOo5vuUpWc1ZujnxtfXU8LqVchzixvbXUjbsNRVEy+LHh4Mub/tCcy4/j6crQyPWLlrLRRrqTd8caP2fBJf+vQ790peS4gcCrfNAaJzyYv4LCaxiCn5xn120ddqMn0gq2lPEtllNghaVKmDLJHYxsRGF8vJeWb/6XVKYEOQHwCCeBBdVyHG+d6joRGsiMu2/KEwB+Zi4Cy14IAvx5O6VsCTOL4o2hEdqS9fxkIhrm5Tw7582q5zIYVoOew2PMRj3tJr73g1Si2U/Xa1JjTbR7T/ph6bvRD4OtbeqHhd1EAKxIYZSxSfZiTYkGtt0LPMUJq9eRlgdbsF0w4azav+MXs2oKgwm2SOqLeFztxORQVa19O0YRoTWVjecr2JnMaRtgwcRPiarT3KVRul+F4rzIf7wQatfJ1BuPFPG2p4T7NRDOr+CWtQquAtHVJpHrJL/THErxBBiHoT0GYDRRFa0IIigJ/c4efRyms9ij+k4z9h4YbKtbQ0yugiFaR20/WHxwXwD0nw60ycJ8d6IuAW63+403t1EqtJBOT9NOw4jy58iAJyQnbf5oQLDvzLyk6QCbhHHSL0IhsnGXgZwSZPcrljFkJeGIsK6IAxW3KapTHGmDfIybRxRNq3mGFx4PIq9xQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MSt4S3kxaXR0MjJmWlcvb0NzZWE5bjNKdnFmK0V6NnU4dU1kdUpuL0FDS0RK?=
 =?utf-8?B?c3RwYmFRRjJKZWNKVEFJSDdrR0ZMQUlmdHdVY1BEcDhuOVd4OVdmaENmWk9S?=
 =?utf-8?B?TmZMQzZNRkhraTFBdVV2RktaRURJTGZpTGk1UFdTYi84MzNSMFI2S1BiZ2o2?=
 =?utf-8?B?Qjh2Y2R3dEY1UkdkL2k1UC9NSmhuNk9zcytjZDVJYml2YmNUWElpYURUWDZo?=
 =?utf-8?B?OVlDVkZ2MXFWZVhmclN6QWpXTDYzMEFFRzQvWGJoNHZWWW81S0RXVWV6VFZu?=
 =?utf-8?B?RW5BdUFiYU9BdlJ3UGljdWJZOVY4dzRlbjZKQXoxamhEazRqaWdra0VTTEg5?=
 =?utf-8?B?NHFIZTM4aHFUN3AvMUF2TnJ4bE5iMVVXOG52R3Y5dmNFbjdlZGFNL2hydzMy?=
 =?utf-8?B?UWY4QWdOUGZmaHhEMFZDV0xEVUd0NFplWjlJNldrYS9QSmYzcVVxSFIvMjdM?=
 =?utf-8?B?cmx3VWM1dTZRQ2FSNVRNWXBIS0Jzam9pOGk0MkRqTks1WGxNRWg2aURUWGp4?=
 =?utf-8?B?ekNGTEkyMmo3QXRuL2d2SkJ5cTkxUGhPbEU2NklnL0psTkNmTnh3aEh2UENF?=
 =?utf-8?B?NFhuWXhQN1k2YkRmQmRaVWdmQXpzY2MvMCt3dWM3QXpQbHBCRGxpakl3Z1Jm?=
 =?utf-8?B?WmsybEpwakwzS3h0QVZzMjRSQWdWRDlBYTdBSUk2SWFPblNDZm5GWlN5SXJl?=
 =?utf-8?B?cWdFNWVoZEJsb3F3Ny9nTHJyRDhwVS9jNjNTQ2FnK05hS3lSNWpTU1JxbnR5?=
 =?utf-8?B?U0JGOEVxYk1POWZVSTdTZVhKZUF6aFdRbXpneHNjMVk0dTVHOWVmTnNlS0lk?=
 =?utf-8?B?MWpYcXNrTjA0RVkzZzRiT3VFNlh1UDRwOXVka0NjbUM2Wkt3SGxkaXBCRFBL?=
 =?utf-8?B?NFlFV2hjREU5WnZyaFJvbktra3ZyQTFxRHNiaFk4WmZJZnFrVUw5NjdMZnFU?=
 =?utf-8?B?bWpsbno4bzZIZVlzS09RSkdWdlJadzVUVWtkYkgzaWsxLzBwZSt4VmphVUZS?=
 =?utf-8?B?UDRmQ2dldmZrTkZXV0hEa1VLaTdnREswRlpLdmRMWkhIRkl0ZDlEL3kxZnpx?=
 =?utf-8?B?N3gwLy9Qbmwzck1ib2Y0UmFiM0w4WU1sVmkrK3Z1Q0VOQ2Y3T3JGUEt1cGVt?=
 =?utf-8?B?M0RJcXpCOVZHU1BEN2x3T1NLdlFEUXVSRnZjZzRsVFR3aDkvU216YnhCb0xm?=
 =?utf-8?B?cHU1NXY3K1huWGdzR3dDbm9mWUd6UE94dFRieDZwZkVyV0hucVdWL3NzS2Jr?=
 =?utf-8?B?UW9TeDkrdSt3WEZsWS8wUVQrb0ZrZGwvV25PZ0plTHoxRFJjeDlpblFaSjNo?=
 =?utf-8?B?Z01uT29DMzJ1SHlVRUJrU0tpVGhwYytyd1NidzhLN2RZWlIwa2dtVVE3OEt6?=
 =?utf-8?B?RzAzU2VYMGNtU2x6WTMvUmk5NG95TzdhWlNLUkl5N3pxQmtmYUFGQ1Q0MkNT?=
 =?utf-8?B?MDlCTGJjR0hpWVpOd0pEM2RPV0dBNGQwcHVPVmVWYW5DTkQzRGxucWFhMUZu?=
 =?utf-8?B?OG9sbWE1dktqWkpqK1pzeWtLbk42VVVPMXZ5dVQ2N00xQ3QrOW8xQzJ1bWE1?=
 =?utf-8?B?VTV1YXdTU0NHUzJqRUwxNGJ5QWh6K3ZyVGhIVFRmdEpraEFXMVpCUjZncUdN?=
 =?utf-8?B?aWtZdVdxbEpPazdqb3RzR1VWTkFVSzBQQkptSnplMSsrWjhUSDc1ZWowcGRP?=
 =?utf-8?B?K1JBTmpvdWRhdlp6YTUwVC9LUDQ0K1VVU2oyQXpkcXROWU1SY0hvb0NSRUZ0?=
 =?utf-8?B?NG9RZjUxYzQ0RlRBdEd2eUoyL1UxYm1lbm1pV2RkeEtaNTV5NnhXNysva1pp?=
 =?utf-8?B?c2xZeDRHZk1RaUptVjhvc0R4RXZZMTlYVnVjRzVNUklpRWsva1BZTms5Qis3?=
 =?utf-8?B?ajFsNHVoaXhYWjcrSE4waUFaQmRhZm9FdnNhTEtOclpqVEJjZ25FRDRSNVlY?=
 =?utf-8?B?dURwc1dncmdNSk4xaUFrcUdqbkxGZnNmcU43elMvNVY5WDV0dDdTK2orTVpG?=
 =?utf-8?B?eWtObFV5Zm1kcURrVEN2OGdNZ1U5WG4wUVlvNDZkd0tXTW16UWREalJTaFB3?=
 =?utf-8?B?UXRCM285czhGVTBaa0ZJakIybXZFTS9OS0ptMFY0NG9taTJraWg4SWxqWHVO?=
 =?utf-8?B?MTh0OXJNTmdHd1ZLNUI4cHpVZHZEYTFXMnd3aFlqbVU2emJIRXNLSUY3c2lj?=
 =?utf-8?B?V0szQld6QWsyOEJzYWtOSWh1WTU4VDgvanJ3U3RhV01TWHVFZlh1dVljZHB2?=
 =?utf-8?B?VEs2aUFhWEpjdlFuL1luREcwN2l3cHdFSjYrUDRCU2xsYk1kaTlaSmIyMDI3?=
 =?utf-8?Q?tD4NKiCZN2wGs5Q2OV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64981147-f78a-4a67-05b3-08de9ccc99c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 21:59:30.0036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwifUFQSPNwKs6rZr7ZJX0BHSqoh6CqG7fbmJxmJSGuIFyW5Pi+S9mSERUt1iDzfMWBjPHMGxlCtS2Ei1/QiWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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
Cg0KUmV2aWV3ZWQtYnk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPg0KDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXgNCj4gRGV1Y2hlcg0K
PiBTZW50OiBGcmlkYXksIEFwcmlsIDE3LCAyMDI2IDE6NTUgUE0NCj4gVG86IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDgvMTZdIGRybS9hbWRncHUv
Z2Z4MTIuMTogYWxpZ24gbXFkIHNldHRpbmdzIHdpdGgNCj4gS0ZEDQo+DQo+IHBpbmc/DQo+DQo+
IE9uIEZyaSwgQXByIDMsIDIwMjYgYXQgMTA6MDPigK9BTSBBbGV4IERldWNoZXIgPGFsZXhkZXVj
aGVyQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBQaW5nPw0KPiA+DQo+ID4gT24gV2Vk
LCBNYXIgMTgsIDIwMjYgYXQgMTA6MTnigK9BTSBBbGV4IERldWNoZXINCj4gPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE1ha2Ugc3VyZSB0byBzZXQgdGhl
IHF1YW50dW0gYml0cyBpbiB0aGUgY29tcHV0ZSBNUUQgZm9yIGJldHRlcg0KPiA+ID4gZmFpcm5l
c3MgYWNyb3NzIHF1ZXVlcyBvZiB0aGUgc2FtZSBwcmlvcml0eS4NCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzEuYyB8IDUg
KysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMS5jDQo+
ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMS5jDQo+ID4gPiBpbmRl
eCBkYjQ5NTgyYTIxMWY3Li45OGRjNjU4MmI3YWE2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8xLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMS5jDQo+ID4gPiBAQCAtMjI0Niw2ICsyMjQ2LDExIEBA
IHN0YXRpYyBpbnQNCj4gZ2Z4X3YxMl8xX2NvbXB1dGVfbXFkX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIHZvaWQgKm0sDQo+ID4gPiAgICAgICAgIG1xZC0+Y3BfbXFkX3N0cmlkZV9z
aXplID0gcHJvcC0+bXFkX3N0cmlkZV9zaXplID8gcHJvcC0NCj4gPm1xZF9zdHJpZGVfc2l6ZSA6
DQo+ID4gPg0KPiA+ID4gQU1ER1BVX01RRF9TSVpFX0FMSUdOKGFkZXYtDQo+ID5tcWRzW0FNREdQ
VV9IV19JUF9DT01QVVRFXS5tcWRfc2l6ZSk7DQo+ID4gPg0KPiA+ID4gKyAgICAgICB0bXAgPSBS
RUdfU0VUX0ZJRUxEKDAsIENQX0hRRF9RVUFOVFVNLCBRVUFOVFVNX0VOLCAxKTsNCj4gPiA+ICsg
ICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9RVUFOVFVNLCBRVUFOVFVNX1ND
QUxFLA0KPiAxKTsNCj4gPiA+ICsgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hR
RF9RVUFOVFVNLA0KPiBRVUFOVFVNX0RVUkFUSU9OLCAxKTsNCj4gPiA+ICsgICAgICAgbXFkLT5j
cF9ocWRfcXVhbnR1bSA9IHRtcDsNCj4gPiA+ICsNCj4gPiA+ICAgICAgICAgbXFkLT5jcF9ocWRf
YWN0aXZlID0gcHJvcC0+aHFkX2FjdGl2ZTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIHJldHVybiAw
Ow0KPiA+ID4gLS0NCj4gPiA+IDIuNTMuMA0KPiA+ID4NCg==
