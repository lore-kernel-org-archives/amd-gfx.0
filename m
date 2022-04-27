Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283D8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 10:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DD1A10EFB4;
	Wed, 27 Apr 2022 10:22:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65DA10EFB4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 10:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJEI5yPxzm+gg/xHObLL250tDlMQvpcs34Sr7mCzEla4ULlO8uYxzHiWPBOr04IyrzZmFxsiGNiL9foPkjJjJlfMfGu5HwdmJpDfDHZdU4xYGDQppFU+f7OpUBL6PNSLWdMst4qwmx+YUJgxqvRuk9BlJqgaDECs/azsG4O+HFpQYSh4K6mrzWr3Cta+S8qa7gZtbulOgUCaJ3ENn/TKCEL5sOn67BfUmEoTGjKO8r0zbFUFBKSPRhnLB3z0blj8dqyQZYk5gSP2vzthUf1A9oC9wZvGPgqrOX0/3TPMcbAIYX7jhV29YQ2pBIxDAaaBW9w+vLPuyU29u4hnIxuioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS6Z2NVLAKPSLJXbjIAcYqQrYv9maKaaoRsZ85uV0KI=;
 b=GTvjgIAVeE3uVbkABSA6ovdc1xg3s8Gf/UrQokyFJcuII42kom9Z6EaaLnQwH3IUk8+JcFUdJ5iykE1PQKKW792aFjPJg7FQkyB9VcuC/93l33U5Qj0NHfRv4N/t0dqr2Z1RSX5TrpEZmcwmc10Tf5LZRBBYwS4o13P/KdR/ySpC0l6+qEDLf8PEJdqtSeao/dJ6jwB8R37c3ptj700y2eJ4y7F4wrRjyeRIt74DGDxJIF597YUE6wpDHxeu/35mi8aYT4Otkc4rBx7uBAXiQrpW/zTQS5h4by/sacpyzI9qox70aTwbwC0OADY+S9lnQo373IUq1h9eMgb5J37H7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS6Z2NVLAKPSLJXbjIAcYqQrYv9maKaaoRsZ85uV0KI=;
 b=RGjxxbavnZtznO31XkfsYKBhm4P3WTQAYQXcBmXbcapCBXdN059+b3tDzsLTvyVfLeU+9ZVGiawbfnFyS8Ei2octRy/aJSDo/CiRwf1+zrz3Wo+C0TCwO5aO832roGTlT9Rq5vzfyPpsQIdd3rirKo+onmUMKBKhZVrUVX9QJmw=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by DM5PR12MB2552.namprd12.prod.outlook.com (2603:10b6:4:b5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 10:22:24 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::c36:d920:511b:de6b]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::c36:d920:511b:de6b%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 10:22:23 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards
Thread-Topic: [PATCH] drm/amdgpu: disable runtime pm on several sienna cichlid
 cards
Thread-Index: AQHYWh85htx7NKEay0Gu4Ruq/f6LMK0Di1WAgAABrFA=
Date: Wed, 27 Apr 2022 10:22:23 +0000
Message-ID: <BL0PR12MB246525A9937D53502C0EC516F1FA9@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220427101134.17917-1-guchun.chen@amd.com>
 <71203a07-9f5c-1193-4014-879e6f4766b7@amd.com>
In-Reply-To: <71203a07-9f5c-1193-4014-879e6f4766b7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82d070c3-0fef-4065-95a7-08da2837d20f
x-ms-traffictypediagnostic: DM5PR12MB2552:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2552BFB5473B06FD78979A8FF1FA9@DM5PR12MB2552.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjKAJwLurXKKd5OuqSNocQrkVjB5lJU0vcEoU+fnuf7efdFNeys07Fx+fMZ+xktYP4Czvq+XYt0gDyp/effCS4XEPKsUm8EHyELO1mteG+AtIomhTMTf8LoEFXvA6d6eiHIliKINCp6PR6vQ2kUrUUY3S0aCIC24Q1uEkZBESMUMpKvDVLKi9HytLybMojj/xBOp7IvXeqTTU6cNimfHSbtzXF2ngUals042A8iS4H28/ODnsZkjfalRyiQ2ty06P6iez1DhOO+SatKdfZYK4xdqZRq8UMB28BRj5dewXmaNq6W1opUn8nKf8nTfp3/0d1Ox870CzJyCgQl6LcUg3zJ3NMpfcIK5O1SvHKoZEkiN0uJYYzIEurI5qzLd4cS3ggGCEY7Iip7yOzyhZD5NlmYW/YzeEgx4/ckF+9V8pt4fabRY205srTK41d536ei57KSjWevf/gACOJBggidUrj+0SF6e9bXPHx+UFIuSb00yFQkv2AnXkzuNtwk3HQxWU6Yq2LTmxycQWIKE/dv8wRQ1mM5uaMwaET+rU39CrCvrYd71tkHTa52PFJE+fEdXq9smOUrl1dr3fhlBXsmQCI14xrm8VAo8CdXby1TlUf0aUXiz+zzqSGbqT/q5EcpGadOAgoJ845HSuu76krxYVkpMRRjDNzPoagcd/t9u6Jo2rkTj6lgfBxIQWLMh+qH4hYU/BqCKC+2ObCeeQDCBs8NdzftxWpfMCDcm2cUrbiI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(66476007)(66556008)(71200400001)(8676002)(6636002)(55016003)(9686003)(26005)(2906002)(66446008)(66946007)(64756008)(76116006)(83380400001)(86362001)(7696005)(5660300002)(122000001)(316002)(921005)(8936002)(186003)(110136005)(508600001)(38100700002)(38070700005)(33656002)(53546011)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEU5b3JSRkpSdmVMRHI2Um5GaVpMZWdMNTlPS3dzN1dINkh4cThER1RjK2l3?=
 =?utf-8?B?cVVha3hNcDF1L2pBeFlxc3REMVZtcEVaUU91VWlvREF1Zlp3SURjUEVOam9Y?=
 =?utf-8?B?d2hMQzZmb0w3ZU4weXpzTG1xcFdiYjBtc2txbGtkdkpqVGluQjROZWJ5MmhX?=
 =?utf-8?B?N2kwWS9mK0gzUEJuQ3RrQmwyL0UxeXRoR1VYR2k1VTlCS2ZaZUl2OTFrWXZw?=
 =?utf-8?B?aC9pMTVnWnh1a3l5REx1Q0FwWHFyL05zOTQySGRFUE80YTVXeWovOTZhNk1K?=
 =?utf-8?B?eG5oMTJFTER2NEV5Mk8rQXUyRVdvblZnd2VoTHBvODh0YnZ5MWlTaWN1SFZv?=
 =?utf-8?B?MCtnL2dQSEJvVCtOdWh0NU1CVDFHNUpKZWhVUTNnbW5lQXl6bFBzakx4RWxK?=
 =?utf-8?B?cXZ5S3p3UUFnV013M0VjV1JRZkJEaWFpYUgxUFUyTnpyeThacTNseGN3dEI3?=
 =?utf-8?B?MFllYUhwZ2hJdFRzTHRpNlFqM1NGem14a24rS1duZ2lBWkwvaDlGT1JqYVU4?=
 =?utf-8?B?aituRFY1WUp1bmJBUWMzZGJVNFBVRHZtY2ZSckQ2MXA4TzBkT0I1UHAwLzc1?=
 =?utf-8?B?L1M1aWZzKy9lNDlwbXZHcFFuMmlkL3pNblhUTEpjT0huUEpJTzRmRStuL3lq?=
 =?utf-8?B?YXU5U0hTa2VJWnFscVlkSTRETGlYQkdaMTFnQnZZV2wrSmdiTzZNcEJna3V1?=
 =?utf-8?B?UkxLd2RKaUc4TUdJUDBCT3p6LzVNek9sK0UxSlVVbTJpZUc5ajM5Z2lJM2N3?=
 =?utf-8?B?ZzI0MTBxV2VuQzg0SlhjMWNYUzJsYjk3R0VsbGRQb3hZa2daTDBSbGhWY0dq?=
 =?utf-8?B?ckVKUHhzb0c0MUFVQ2R3UVJPeldKbkM1RDJMb2lzR1ZmbHBPT2lTM1BaNXBF?=
 =?utf-8?B?QlJTZTNiZnl1K2d2N0RpQXF6SXcvUkhqQkFOQkF4S3AxTjQyZE0ySnpocEJC?=
 =?utf-8?B?YWdSVmFrd3hGTDE4MVlDckNnSVV6V2toa3dGUHhzUEk3b01DUlNUZDJuNEc0?=
 =?utf-8?B?L0d6dm9NK0V6aVhtdkhKdk81QkJsbzNmMGl2MDZ2dzVGTytHZG1mVllFTHc5?=
 =?utf-8?B?MHBXVXQ3dFZBKzZ5bVRlaElFK2JJcVRxc1A0QTVUaSs2UnIzTER3MHY1ZGNw?=
 =?utf-8?B?UWZYMVdIa3RGVGIrdGdDWDVhVktlSTVoM2ZpTmNyR1c0MEx1RHcwMUxnckhC?=
 =?utf-8?B?dVNlZkJSK0Y2eWZrb2k1TmlBNzVEdzRBRUM2MHdSOHFtVTNCbHhHbWdYZlJY?=
 =?utf-8?B?eVlSR0pvNytQSlUyMEdHSDhtbWtMQWNIZkVEUEJaSXF0bDJkbEwrME5LUU1V?=
 =?utf-8?B?THR1MWNrbGV4RjErNy9sUHl4c3pGSndId1pnc3E1cnlETWdQMGFtK3F5R1Y4?=
 =?utf-8?B?L0NlM2tNRzdFNkdSUHBTcThlMjQ4RU5EQkNqdlNCd0Y2Nnd0eXduaUZXbjBl?=
 =?utf-8?B?b1hNYWZERE5VNHN4RHZWaXVDSEkveXRjU2tvMXVKQlpaK1Y4T2xaTG9EakVL?=
 =?utf-8?B?aEdSVWc0WmIzUU9Fd2ZQVFYwV25Vc3dreTcyRnlOTTRDMFNWV1VtQy9WSjNE?=
 =?utf-8?B?ZXZwb1JzNlBlZDNkVndMVWx3UG5lSXREb1E0RkFrZ05VemJJcUZTN2R1dUhX?=
 =?utf-8?B?QlpIbU1ESDMvaXE2RHZQZitsbGdKN1pQS3Bva2RacXZIYzFBa2pqYU5MSjRl?=
 =?utf-8?B?TUUxbTdkeEhySWhmZE8wVSt4OEhnWnJCYnZVazYyVjN5NFRGb2gyYmpFTVJD?=
 =?utf-8?B?VWNoSEhmREtEVldWLzlRbzZoaG5zOVA0eHpSM2NQczZBTkxqZEdRTXl1Ymxn?=
 =?utf-8?B?aGpGblFxdTBnYllnN0lHOUFGN3B1eHRiNTBqVE1jcWdpOUFhYU1INUdtWGJT?=
 =?utf-8?B?Z1NzQlZWZDUyTzRNcU9CVG45WWdnZXpobFBhdmhVcjFVcGtQQWJFUmZrWlFp?=
 =?utf-8?B?WUNBNlNjU2puQm5pQVo1ejNsWFZoOUJUNUozUjlpMWpOeWpaZXJHRzdLT0Y4?=
 =?utf-8?B?MWZTNWlBdFZ3YThhTHI3M3hDODVpWXVCYkRvenBGV1ZCZHRBT1p1VlFqZTNI?=
 =?utf-8?B?QnAwdDFlcXhQZzQwT3hzSUdpUlE4b3Q3TnZJeXBERjExNCs5WDJMb3VBRHhr?=
 =?utf-8?B?UkR1K1NoWFVzNHhwRk5UOHZlZG1VYStvdVRoVlVFSUcxNFpqU0xnOFNNWldr?=
 =?utf-8?B?bDdINDlpT213VDJHY1Rta3Q4UCttTW1JV0xNeDRZSWV5V1FzZmVxWjV3K3Zq?=
 =?utf-8?B?QW9EeDNtOG1vbkpqUTF4bUY1SXQxNEVnVmUzWlFCM1hMVVhvU2Y2bVFOYkdk?=
 =?utf-8?B?ZkFseVE4MmVRcnhNaFRsbFc0eW43azJwTFBPK0lnSnN5SzR3T2ZSUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d070c3-0fef-4065-95a7-08da2837d20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 10:22:23.8583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /j7r/8u4mMNHuRh+5akF3EjQVmX9mpbKJGyx7EZipsHx4wzM7PJh0WyxQauGW17gDpdDd7VNaMqtmBacXXhO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
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

U3VyZSwgd2lsbCB1cGRhdGUgaXQgaW4gdjIuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5j
b20+IA0KU2VudDogV2VkbmVzZGF5LCBBcHJpbCAyNywgMjAyMiA2OjE2IFBNDQpUbzogQ2hlbiwg
R3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaGFuZywg
SGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBkaXNhYmxlIHJ1bnRpbWUgcG0gb24gc2V2
ZXJhbCBzaWVubmEgY2ljaGxpZCBjYXJkcw0KDQoNCg0KT24gNC8yNy8yMDIyIDM6NDEgUE0sIEd1
Y2h1biBDaGVuIHdyb3RlOg0KPiBEaXNhYmxlIHJ1bnRpbWUgcG93ZXIgbWFuYWdlbWVudCBvbiBz
ZXZlcmFsIHNpZW5uYSBjaWNobGlkIGNhcmRzLCANCj4gb3RoZXJ3aXNlIFNNVSB3aWxsIHBvc3Np
Ymx5IGZhaWwgdG8gYmUgcmVzdW1lZCBmcm9tIHJ1bnRpbWUgc3VzcGVuZC4gDQo+IFdpbGwgZHJv
cCB0aGlzIGFmdGVyIGEgY2xlYW4gc29sdXRpb24gYmV0d2VlbiBrZXJuZWwgZHJpdmVyIGFuZCBT
TVUgRlcgDQo+IGlzIGF2YWlsYWJsZS4NCj4gDQo+IGFtZGdwdSAwMDAwOjYzOjAwLjA6IGFtZGdw
dTogR0VDQyBpcyBlbmFibGVkIGFtZGdwdSAwMDAwOjYzOjAwLjA6IA0KPiBhbWRncHU6IFNFQ1VS
RURJU1BMQVk6IHNlY3VyZWRpc3BsYXkgdGEgdWNvZGUgaXMgbm90IGF2YWlsYWJsZSBhbWRncHUg
DQo+IDAwMDA6NjM6MDAuMDogYW1kZ3B1OiBTTVUgaXMgcmVzdW1pbmcuLi4NCj4gYW1kZ3B1IDAw
MDA6NjM6MDAuMDogYW1kZ3B1OiBTTVU6IEknbSBub3QgZG9uZSB3aXRoIHlvdXIgY29tbWFuZDog
DQo+IFNNTl9DMlBNU0dfNjY6MHgwMDAwMDAwRSBTTU5fQzJQTVNHXzgyOjB4MDAwMDAwODAgYW1k
Z3B1IDAwMDA6NjM6MDAuMDogYW1kZ3B1OiBGYWlsZWQgdG8gU2V0RHJpdmVyRHJhbUFkZHIhDQo+
IGFtZGdwdSAwMDAwOjYzOjAwLjA6IGFtZGdwdTogRmFpbGVkIHRvIHNldHVwIHNtYyBodyENCj4g
W2RybTphbWRncHVfZGV2aWNlX2lwX3Jlc3VtZV9waGFzZTIgW2FtZGdwdV1dICpFUlJPUiogcmVz
dW1lIG9mIElQIA0KPiBibG9jayA8c211PiBmYWlsZWQgLTYyIGFtZGdwdSAwMDAwOjYzOjAwLjA6
IGFtZGdwdTogDQo+IGFtZGdwdV9kZXZpY2VfaXBfcmVzdW1lIGZhaWxlZCAoLTYyKQ0KPiANCj4g
U2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyB8IDkgKysrKysrKysr
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyANCj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gaW5kZXggMjYyOTM4ZjBkZmRiLi45YzQ4
Mzc4N2MwY2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMN
Cj4gQEAgLTE4MCw2ICsxODAsMTUgQEAgaW50IGFtZGdwdV9kcml2ZXJfbG9hZF9rbXMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+ICAgCQkgKi8NCj4g
ICAJCWlmIChhZGV2LT5pc19md19mYikNCj4gICAJCQlhZGV2LT5ydW5wbSA9IGZhbHNlOw0KPiAr
DQo+ICsJCS8qDQo+ICsJCSAqIEFkZCBiZWxvdyBxdWlyayBvbiBzZXZlcmFsIHNpZW5uYV9jaWNo
bGlkIGNhcmRzIHRvIGRpc2FibGUNCj4gKwkJICogcnVudGltZSBwbSB0byBmaXggRU1JIGZhaWx1
cmVzLg0KPiArCQkgKi8NCj4gKwkJaWYgKCgoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NzNBMSkg
JiYgKGFkZXYtPnBkZXYtPnJldmlzaW9uID09IDB4MDApKSB8fA0KPiArCQkgICAgKChhZGV2LT5w
ZGV2LT5kZXZpY2UgPT0gMHg3M0JGKSAmJiAoYWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHhDRikp
KQ0KPiArCQkJYWRldi0+cnVucG0gPSBmYWxzZTsNCj4gKw0KDQpTZXBhcmF0ZSB0byBhbWRncHVf
cnVudGltZV9wbV9xdWlyaygpPw0KDQpUaGFua3MsDQpMaWpvDQoNCj4gICAJCWlmIChhZGV2LT5y
dW5wbSkNCj4gICAJCQlkZXZfaW5mbyhhZGV2LT5kZXYsICJVc2luZyBCQUNPIGZvciBydW50aW1l
IHBtXG4iKTsNCj4gICAJfQ0KPiANCg==
