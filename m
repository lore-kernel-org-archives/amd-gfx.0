Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53461C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 08:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA2D410FEDB;
	Tue, 30 Jan 2024 08:50:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF72610FEDB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 08:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbmCl6btzSqOmGVWUPbfFRZYFxzJqBqlpK6Ha+s1blDIfm0zgjM6AyjDJ9EUmTI2oIfTV1p8B4DRLDWxO0iZDfVg6LX0cPb8s4Zjkp60XpeP4npwE7NgIt1gt+a1hHVhfPu8DwC8YSavCSPIzng8gzdHY+pLyRUUaWn19xIST5bIMDoIjPvB/ODnywRNlQhogix+nxm632To3FxIZKp6co5eub+FY2hIX0M82PvXpecQJ3M81P1k/9sPhSrrGLkB++h2/645Nr6y8vzp5ZXMQ8dr53uQWqUWbIIoyKe9Hfbecov3N33NVJcX5jE4YHXewxYvg6I1ERxCRPLjR4AsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9wAIoYQ1Ns1v4aaMGJfgRc/bgd+l6V5jIdEqFzYcpI=;
 b=fj5i+zUEmbpDbDPD0DdyCzEgX/HvEPS5cXtN2qhj3R1eou7Y4rin5ThTrEIULyJy94cEjzMf4eyERS7JO1aGAMUUstatZ/fqcLLE/3JNZA+60/bbgZrRn1Z5Uxd1dgXA439tI/pVw6gHjm7ebCK9zZnDwzMb0/1nK+sNNMXZiewnY5FmbOeYh5TrdbmPh3EPvb85SXKvnbNMqQrDhsFszd0pfW0Htq4rl6J+10vZ7TRiBqEw3Hy+NrUuXsFmJx+Rn3QxqmQdjTE6x2mDsMrC9xmhG2gnH5cyGFOm67Bn3vyLvV5dMC74UJxO62gsZqEPYZZNj0tSVXKZ89eql/we4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9wAIoYQ1Ns1v4aaMGJfgRc/bgd+l6V5jIdEqFzYcpI=;
 b=wdbZRh/NVwi5SeRhaUAGTSWpEkaq4Inl6n1kKDELDsyCbKItPi4AC/NWlOJjaAHQv/8TN2yuCANNpuaJVnFMgUoJPESWkb6vbZdO3pGKXH58RANcmupONzK+IkksQM2x46Q+yzmmovXbGpLym5NJOo25iA9VqXMPdxMxoB2nThk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 08:50:26 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:50:26 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Thread-Topic: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Thread-Index: AQHaTz3TrRHBNnxGnEmGW4ad3K6E4rDqgXsAgAFCxhCABJuJAIABgigA
Date: Tue, 30 Jan 2024 08:50:26 +0000
Message-ID: <DS7PR12MB600505843E4B9D964A1C8CD7FB7D2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240125032255.898308-1-Prike.Liang@amd.com>
 <20240125032255.898308-2-Prike.Liang@amd.com>
 <6faf2c64-fe90-484a-902a-66a59e9c3849@amd.com>
 <DS7PR12MB600523A9E24397369DFDFDE7FB792@DS7PR12MB6005.namprd12.prod.outlook.com>
 <670a789a-c5d0-4064-96de-22c94e6910bd@amd.com>
In-Reply-To: <670a789a-c5d0-4064-96de-22c94e6910bd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=039d55e1-7ada-41ec-9e0d-5ad6bc617722;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-30T05:50:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB6894:EE_
x-ms-office365-filtering-correlation-id: b6b116fd-8c48-47af-d37e-08dc217080f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RsEQGTIqGc5P2Wvzv3ThPGmDi4uohAkuorqK14CLDwZP4udBj8aYhRak0WzRB2b3aZKzBYI3WRdQzixPfucpZUGlcs8fEd9/ezIYeIs9AWTbpPEcUK5XxIW1/Bysztcj5DqLLJxy5NTXuYEQIybcbkmNmxs5x+oBWFuLzG+3jN/YmbORONnuE3+3aht4AffLbn7jaYofWqKJi397Jj3p/QvdcP1XpeMlCAyZ0MM99ebyf3NIiEfDnOvFnXq4Ce9DGKjlQ1mjbHj+1vikL2MhrrsfAY1+BqrnARcRNy3tQZq0ZHCq/OnOYdsuoHoHezynDK0j66ZWI2DHuEqganLXcXtYg4TsWadJXdcIUFQRqOF97ONXllHyCkqwuxCC+k1/nWDaxt8DsOeUNZbZsmgzx8pT7cxDhckCnTCH6r1eHChTr9Sic7RHrksoJnvZfjemUiJy7Qk+xPp/0bHDPJIhj1suD6d1JiizYSEp9/GWIJ/mPIFvasDe0C6HTvsEiFTGjbZpUKl3SmGxQVfrWjGjfcIvZB1Dc8ch41gQXbSjuJWF4a71fPUgAZZxIxXdunQ+tmpd3/5SziJdtcuuZOivfg1BW7OOYRr2aIRVgmy8dKZ7NuWito7KLTx+gVpOUmYO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(53546011)(7696005)(6506007)(478600001)(38100700002)(76116006)(9686003)(41300700001)(4326008)(5660300002)(8676002)(66946007)(2906002)(66556008)(71200400001)(316002)(52536014)(110136005)(66446008)(66476007)(64756008)(54906003)(122000001)(33656002)(86362001)(8936002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1QzVCs2WXVQWGZpUjhzaDBiRHpzTkFSWmFMVXJucExJODZ2OEVVMUdXSkdp?=
 =?utf-8?B?U2oyL1pvZDFicFhpNDNSZWVwc3AvTTRXVEhlaGh6WG5FbjIxSlJRMjRyRmpl?=
 =?utf-8?B?TUtDcmtCcVNYQ1QxanVXQkZhc0VqVTI1NmU0WXR1c0Qwdi9lbklRMlZtNlRl?=
 =?utf-8?B?S1NmOElmNGkxcml1bDZLK01aN1pVUTNZWVVBcFpNQjRzT1FqZlIxZXpTTTdt?=
 =?utf-8?B?T1pySDRvSUVzTUJWVnNCQWtrcE1sOEtvU2dyVUp3czFSMTZ4RU0wZjZnM1Vv?=
 =?utf-8?B?L0lPcG9xTzI2R0YwZXA5V1NlcjJLUXcvcjZ6WGUvUU13cENiUjZlK0pqTjdp?=
 =?utf-8?B?NEdtSlYxZ0xtTlFxL3FTYkdjNmc0YVpOSjNLVmdzVDd3bGRSaGxQTkpDWXpk?=
 =?utf-8?B?WnMvUnBXWWpnUTgxT3lBZzVtYlB5WGloQWo3RjJwNUxmYk82L2swK1M1Vm5K?=
 =?utf-8?B?WC9yK3hhYnVvbXR3OVd0SUxERVhLb01HWE9zbnJ6ZjczaUlQOWdaaCtsWXhk?=
 =?utf-8?B?eXFmMTN3a0hWSWl5TDBYajk2NmlKbFl4WGp0bkw0ZVZlRUtzeEJTeHZldkUv?=
 =?utf-8?B?R2VsTkpUVnV5eUREV05sSkExTTEwNTMvbGtjc2lRL0FsZ2pqV3p3aGtnSUhJ?=
 =?utf-8?B?Szk0cDRlS2JTQnliZWtQL2U3d2Y3cXp1WTdPWUc3Y3phaGZkMUFvLzBhUmd5?=
 =?utf-8?B?N1RXZlorSWRCUmpOa2NLdDN1T3plS09oQ0x1NmdvcGhaSUNwV0w3NkF1eGJ6?=
 =?utf-8?B?bW1Ca1NnZGhIOTRCMmZWNHZtSTdKZkNXa0k0WjN4LzhRTnVFVHNCakplUk4z?=
 =?utf-8?B?SDZBOUxnNzNWRkJxVE9wMFA2RFZZU2RsSTZUMjJsWmMwRk83T2xTdXAvVE1F?=
 =?utf-8?B?RTJMTUNqZjRxK0RwL2tQZElMNEtMazgzcHdTcjc1ZDNXcnlXUTVLSDZCN3F2?=
 =?utf-8?B?TDF0VDRKMWpiSGltN1licy9IanBmY3ZVT3N6alRIdWVVandxOEo1NDR6U0pl?=
 =?utf-8?B?clpvaTdqYjdoVGdEbmNTMFRNT29BNTVsZTJmTHVRTzVlRWMycWIzOXdoNFVp?=
 =?utf-8?B?eTN1a2pRRHBJZUJIcFV4a2FBVThxMGl2SVVCRFM2OWRaMisvQlh4blFER2hx?=
 =?utf-8?B?cmI5NGZhTkRHSG5FWVVUUGMwUTBqSHg2Y2o5WmJ4Q1l2dGJZT05Lc2cwTDZX?=
 =?utf-8?B?ZkFVV25JczhJOTRydm02OXMwTGFnT2xKSCt5WGQ2dHl1OHJWcjIxM1FMZUp2?=
 =?utf-8?B?K1JSUkJneTBkcVZaTllSanpHa2Z6ZUxVZFg4aVVGWnVrdUk3anRWSTFrNDdw?=
 =?utf-8?B?aXdUaVlvd1hiV21LaWkrenE1ZC9pMjAxY2wzaWVMTno5V0F1M1lLZCtabVc2?=
 =?utf-8?B?R1oxamkwc2ZocW8xaHE2N0hOakxrWEJKMkN1VWNBYS9pbFd6OVZ3RDRZSWNz?=
 =?utf-8?B?V1B3WXU4UklVRXhvMzN0N1VCNGRFbDk2Qy9LUnRrYzByYlBSVnVPYS8vd3JY?=
 =?utf-8?B?dW03UkZOeHR0OVFEYXlGZU44SzlwZmlGa2RObk4xKzYzdkFsZ1JFNDZGN3R5?=
 =?utf-8?B?WWJXdm9namE4QUl2YTUzUzJBeFI4VlRPMzNmQVRadWs5dDJ5NnhKNFZUQWMx?=
 =?utf-8?B?YTlseXBXRC9ML2JDQ0ZCaUVuQWVFaTlkcmErWVpmT0FmaDEvc096ZHhEZU5m?=
 =?utf-8?B?bUJ2RVU5TlJNMzl5Y082UEVnY0lIemg1djlsU3dTck9hVW1lNXJkWHRjZDRX?=
 =?utf-8?B?TXNEald3SUJmZE5xbmtKdk8xa2ZDTFU5d0ZLOTlwRXM4azZ2YkUyL3VVZENz?=
 =?utf-8?B?eGg0SjcyUmo3NEZtK1JwTDM4dnFnUlhJdTVMTlFSaDcxNVhoZHRJQ2xmV0Fo?=
 =?utf-8?B?bzJpL3FzSDhpUDZTZHMrbytycnh3dFU2MnQ1UDBwL1ZrZTY2SjdBejhxdll6?=
 =?utf-8?B?V3M4cnRzZUFKME1pMFdhOFRBT25NM3JIeVNGaHg3RE5wa3JmYlFvNjZJOWth?=
 =?utf-8?B?MDVMbkkrY0R4cmp0Vi91MjIzeDk2U01CWU80UzZ0RjcvSDR2c1hyeHpPeDlQ?=
 =?utf-8?B?N3pTV0hXZGRlMUZ3eTlzSkpRcE1hN1IyMjRZV0cwN3VsYTR3K1hoQmtJTFhN?=
 =?utf-8?Q?NV20=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b116fd-8c48-47af-d37e-08dc217080f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:50:26.3638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qWzrPR/80/fQVLdIuZfJmhtu9kDP3KKv/Kl0I1Pr9ZcsXez8WGl6NSxdkLv7+Hb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Deepak" <Deepak.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gRnJvbTogTGF6YXIsIExpam8g
PExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDI5LCAyMDI0IDI6
NDggUE0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBTaGFybWEsIERlZXBhaw0KPiA8RGVlcGFrLlNoYXJtYUBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogcmVzZXQgZ3B1IGZv
ciBwbSBhYm9ydCBjYXNlDQo+DQo+DQo+DQo+IE9uIDEvMjYvMjAyNCAyOjMwIFBNLCBMaWFuZywg
UHJpa2Ugd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+ID4N
Cj4gPj4NCj4gPj4gT24gMS8yNS8yMDI0IDg6NTIgQU0sIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+
Pj4gSW4gdGhlIHBtIGFib3J0IGNhc2UgdGhlIGdmeCBwb3dlciByYWlsIG5vdCB0dXJuIG9mZiBm
cm9tIEZDSCBzaWRlDQo+ID4+PiBhbmQgdGhpcyB3aWxsIGxlYWQgdG8gdGhlIGdmeCByZWluaXRp
YWxpemVkIGZhaWxlZCBiYXNlIG9uIHRoZQ0KPiA+Pj4gdW5rbm93biBnZnggSFcgc3RhdHVzLCBz
byBsZXQncyByZXNldCB0aGUgZ3B1IHRvIGEga25vd24gZ29vZCBwb3dlcg0KPiBzdGF0ZS4NCj4g
Pj4+DQo+ID4+DQo+ID4+IEZyb20gdGhlIGRlc2NyaXB0aW9uLCB0aGlzIGFuIEFQVSBvbmx5IHBy
b2JsZW0gKG9yIHRoaXMgcGF0Y2ggY291bGQNCj4gPj4gb25seSByZXNvbHZlIEFQVSBhYm9ydCBz
ZXF1ZW5jZSkuIEhvd2V2ZXIsIHRoZXJlIGlzIG5vIGNoZWNrIGZvciBBUFUNCj4gPj4gaW4gdGhl
IHBhdGNoIGJlbG93Lg0KPiA+Pg0KPiA+IFtQcmlrZV0gIElJUkMsIHRoZXJlIGFsc28gaGFzIGEg
c2ltaWxhciBwcm9ibGVtIG9uIHRoZSBkR1BVIHNpZGUgd2hlbg0KPiA+IHN1c3BlbmQgYWJvcnQg
YW5kIG5vdyB0aGlzIHBhdGNoIGlzIG9ubHkgZHJhZnRlZCBmb3IgYSBob3QgaXNzdWUgb24NCj4g
PiB0aGUgUlYgc2VyaWVzLiBJZiBuZWVkIHdlIGNhbiBhZGQgYSBUT0RPIGl0ZW0gZm9yIGRyYWZ0
aW5nIGEgbW9yZSBnZW5lcmljDQo+IHNvbHV0aW9uLg0KPiA+DQo+DQo+IElmIHRoaXMgYWRkcmVz
c2VzIGEgc3BlY2lmaWMgaXNzdWUsIHRoZW4gYmV0dGVyIHRvIGNoZWNrIHRoZSBzcGVjaWZpYyBJ
UCByZXZpc2lvbg0KPiBiZWZvcmUgcHJlc2VudGluZyB0aGlzIGFzIGEgZ2VuZXJpYyBvbmUuIFBy
ZXNlbnRseSB0aGUgcGF0Y2ggbG9naWMgY29uc2lkZXJzDQo+IHRoaXMgYXMgYSBnZW5lcmljIGZv
ciBhbGwgc29jMTUgYXNpY3MuDQo+DQpCZWZvcmUgc29tZW9uZSBjYW4gZnVydGhlciBjb25maXJt
IHdoZXRoZXIgdGhlcmUncyBhIHNpbWlsYXIgcHJvYmxlbSBvbiB0aGUgZEdQVSBkZXZpY2Ugc2lk
ZSB0aGVuIEkgcHJlZmVyIHRvIGxpbWl0IHRoaXMgcXVpcmsgb25seSBvbiBzb21lIHNwZWNpZmlj
IEFTSUMuDQoNCj4gPj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5M
aWFuZ0BhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIHwgNSArKysrKw0KPiA+Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzE1LmMgICAgICAgICB8IDggKysrKysrKy0NCj4gPj4+ICAyIGZpbGVzIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+Pj4gaW5kZXgg
NTZkOWRmYTYxMjkwLi40YzQwZmZhYWE1YzIgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+Pj4gQEAgLTQ2MjcsNiArNDYyNywx
MSBAQCBpbnQgYW1kZ3B1X2RldmljZV9yZXN1bWUoc3RydWN0DQo+IGRybV9kZXZpY2UNCj4gPj4g
KmRldiwgYm9vbCBmYmNvbikNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+
ID4+PiAgICAgfQ0KPiA+Pj4NCj4gPj4+ICsgICBpZihhbWRncHVfYXNpY19uZWVkX3Jlc2V0X29u
X2luaXQoYWRldikpIHsNCj4gPj4+ICsgICAgICAgICAgIERSTV9JTkZPKCJQTSBhYm9ydCBjYXNl
IGFuZCBsZXQncyByZXNldCBhc2ljIFxuIik7DQo+ID4+PiArICAgICAgICAgICBhbWRncHVfYXNp
Y19yZXNldChhZGV2KTsNCj4gPj4+ICsgICB9DQo+ID4+PiArDQo+ID4+DQo+ID4+IHN1c3BlbmRf
bm9pcnEgaXMgc3BlY2lmaWMgZm9yIHN1c3BlbmQgc2NlbmFyaW9zIGFuZCBub3QgdmFsaWQgZm9y
DQo+IGZyZWV6ZS90aGF3Lg0KPiA+PiBJIGd1ZXNzIHRoaXMgY291bGQgdHJpZ2dlciByZXNldCBm
b3Igc3VjY2Vzc2Z1bCByZXN0b3JlIG9uIEFQVXMuDQo+ID4+DQo+ID4gW1ByaWtlXSBJZiBkb2Vz
bid0IHJ1biBpbnRvIG5vaXJxX3N1c3BlbmQgdGhlbiBzdGlsbCBuZWVkIGZ1cnRoZXIgY2hlY2sN
Cj4gd2hldGhlciB0aGUgUFNQIFRPUyBpcyBzdGlsbCBhbGl2ZSBiZWZvcmUgZ3B1IHJlc2V0Lg0K
PiA+DQo+DQo+IEFGQUlVLCBmb3IgYSBzdWNjZXNzZnVsIHJlc3VtZSBmcm9tIGhpYmVybmF0ZSBv
biBBUFVzLCBUT1Mgd2lsbCBzdGlsbCBiZQ0KPiBydW5uaW5nLiBUaGUgcGF0Y2ggd2lsbCB0cmln
Z2VyIGEgcmVzZXQgaW4gc3VjaCBjYXNlcyBhbHNvLg0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4N
ClllcywgZHVyaW5nIHRoZSBzeXN0ZW0gdHJ5IHRvIHJlc3RvcmUgdGhlIHNhdmVkIGltYWdlIHRo
ZSBUT1Mgc2hvdWxkIGJlIHJ1bm5pbmcgYXQgdGhhdCBtb21lbnQgc28gd2lsbCBmaWx0ZXIgb3V0
IHRoZSBoaWJlcm5hdGUgcmVzdW1lIGNhc2UgaW4gdGhlIGxhdGVyIHBhdGNoLg0KDQpUaGFua3Ms
DQpQcmlrZQ0KPiA+Pj4gICAgIGlmIChkZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9PSBEUk1fU1dJ
VENIX1BPV0VSX09GRikNCj4gPj4+ICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+Pj4NCj4gPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPj4+IGluZGV4IDE1MDMzZWZl
YzJiYS4uOTMyOWEwMGI2YWJjIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMTUuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c29jMTUuYw0KPiA+Pj4gQEAgLTgwNCw5ICs4MDQsMTYgQEAgc3RhdGljIGJvb2wgc29jMTVfbmVl
ZF9yZXNldF9vbl9pbml0KHN0cnVjdA0KPiA+PiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+Pj4g
ICAgIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SRU5PSVIpDQo+ID4+PiAgICAgICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4gPj4+DQo+ID4+PiArICAgc29sX3JlZyA9IFJSRUczMl9TT0MxNShN
UDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfODEpOw0KPiA+Pj4gKw0KPiA+Pj4gICAgIC8qIEp1c3Qg
cmV0dXJuIGZhbHNlIGZvciBzb2MxNSBHUFVzLiAgUmVzZXQgZG9lcyBub3Qgc2VlbSB0bw0KPiA+
Pj4gICAgICAqIGJlIG5lY2Vzc2FyeS4NCj4gPj4+ICAgICAgKi8NCj4gPj4NCj4gPj4gVGhlIGNv
bW1lbnQgbm93IGRvZXNuJ3QgbWFrZSBzZW5zZS4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBM
aWpvDQo+ID4+DQo+ID4+PiArICAgaWYgKGFkZXYtPmluX3N1c3BlbmQgJiYgIWFkZXYtPmluX3Mw
aXggJiYNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgIWFkZXYtPnBtX2NvbXBsZXRlICYmDQo+
ID4+PiArICAgICAgICAgICAgICAgICAgIHNvbF9yZWcpDQo+ID4+PiArICAgICAgICAgICByZXR1
cm4gdHJ1ZTsNCj4gPj4+ICsNCj4gPj4+ICAgICBpZiAoIWFtZGdwdV9wYXNzdGhyb3VnaChhZGV2
KSkNCj4gPj4+ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPj4+DQo+ID4+PiBAQCAtODE2
LDcgKzgyMyw2IEBAIHN0YXRpYyBib29sIHNvYzE1X25lZWRfcmVzZXRfb25faW5pdChzdHJ1Y3QN
Cj4gPj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPj4+ICAgICAvKiBDaGVjayBzT1Mgc2lnbiBv
ZiBsaWZlIHJlZ2lzdGVyIHRvIGNvbmZpcm0gc3lzIGRyaXZlciBhbmQgc09TDQo+ID4+PiAgICAg
ICogYXJlIGFscmVhZHkgYmVlbiBsb2FkZWQuDQo+ID4+PiAgICAgICovDQo+ID4+PiAtICAgc29s
X3JlZyA9IFJSRUczMl9TT0MxNShNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfODEpOw0KPiA+Pj4g
ICAgIGlmIChzb2xfcmVnKQ0KPiA+Pj4gICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4+Pg0K
