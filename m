Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9806C46CD2
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 02:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2162110EB91;
	Thu, 25 Jan 2024 02:39:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC90910EB91
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 02:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+02C9WKjzkiMZ0LUGrUv/GJ9q4tcILiHOxyg5X/4C5eRr4TILixX9J5GzPdZPGm4O6OTDM7z/xJE4jVplhPXNPv3LFnTsmX94WfH+rqWctAcpJIV2EG4dd3qrHKnTAEVSG1bxl2YUrhZt1YK1IHss8Ar07UW5llJTqLnHj9w7Erb+LcFgj1OhbdHetW6Z0tp8JVal3CKtcPFOn9y5cwECZSyHup1w3BoR0mYzesNdrSGfzEv5txddeU0O5BufPMZQ/FxOfzYwUk1mLL6rWbzsEHUi3Jd4G4kaXKhJ3yvU7uU0eyICaJvaK1gsTP3K0lXpYksdG/7BaDPCThUC0oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+ANnOKOPSNYdVWdaQb+pV1s9/egAfHungpKzDnM1CM=;
 b=G8ZftxTDrddr3IakDcLM+o0ubTI6zNhEhLTTGcSUKVQtwwpQ4plxxt6yEipdGvgIo5j5QsrNLx+ACbi8oNcAYTLnoRwNu1kXatifa003wRIiH/5oWNhM4SqEwMUMgtmJ9Yo+qDI3G/jKg+DSYuZ3oC8qiUzDKPV6QaLYyPZ+k5W5NhVPj6WAS5jxGW+3WJEhO+nOzrX1XKCJcln9ph7MUzG5oyLoy/GN7Dk2+MhNZowNn+e1pERfMWtvgdmbehu4PZmTspNy8BXjxARRfKf1VWUWJGl9Zgt1pd1YJfEr8Nv2MH71ntEXMNflVOJ/oyVhunyOMGD1Gfsv1mj2PLtcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+ANnOKOPSNYdVWdaQb+pV1s9/egAfHungpKzDnM1CM=;
 b=p/H6K/ytTNB3gmOhqKZCPWqHFDuibGhbycd0Pefd3D34XSlU5YWup8DzYoBEu8W9ZHhEH9sWn2zdD03uRPuOoQX9hkonyS6iSxRxds8x0M4UIFkS2RemzQ1jbPkO1/F1atY5lGVDMQ9o9HZlrHPgPPif4TI6wDFm8QYS2Rs9yTM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 02:39:49 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 02:39:49 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM
 abort case
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM
 abort case
Thread-Index: AQHaTpLvhtO6qUfupU2bLdsybleF97DpH1qAgACs9UA=
Date: Thu, 25 Jan 2024 02:39:49 +0000
Message-ID: <DS7PR12MB6005078B67C8122627CAA45DFB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240124065932.892944-1-Prike.Liang@amd.com>
 <CADnq5_PJyh50wpHQuU_UFYvpnnp8PsteAJ7ymazFHMWD92cyDw@mail.gmail.com>
In-Reply-To: <CADnq5_PJyh50wpHQuU_UFYvpnnp8PsteAJ7ymazFHMWD92cyDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2d5d084b-49b3-4272-a188-ba2a610fa8f6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-25T02:18:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BL0PR12MB4963:EE_
x-ms-office365-filtering-correlation-id: 40331dc1-8086-467a-5b45-08dc1d4ee6cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJwZAS4Tg8wCe/rWAV5wsbgjited488w7qFr+cVOfdCmJ/zPtqqUAVkcTywpD3XOhS0GbopCCjKxmXzofu3WNi+CNEeOS/LEskFZuxWcbHSWkqthE+QzMBS2MayBw77uW8iZ2E33xCM6bxhtH2RMr1rAZnjo6hPyozgwRNwW+GhMlMTKxH1I4dicZ3olwe0b/95qQGAwZZ0fKU/adTBOKLHC/3c1CM2JykXnDDEiHYMoDnImp5eYjtFpd+7a7hp/1dO9n9uyK+dbLbkNfJbCkYmXRa4PWIC9PcjJh/ibG71epch8cSLi44nDZIvP2NjVTjO1EboBHOhnlw3NRgsfhBW8tMLsDXKEDGGrIG5B50Dx/YWNBYLo7osh9Yp7I3qJvxaPyjI8FRuCxXPdR6dv/DvYiG8+Z5POiZJ0jnUHLrob/KfBf2EOVfQKRNFYyIdVKKqVRCwqTMNq5i7y/b1nyaPtyZ8d7o+8NTlHMXiIEhsLdwbRdi1g1D2pT+fIHrv3TLDL/QofkgkWiSx5AtTB8zDZ4jV0A6sX0XDsKafkvna2mSjVD8eDopWvbs612X+iEjvd+OsZAFbg7G4vF/6Iqv1Du7TT1R0UpoGz3hWRY019lLEWM/Yg0mdCG/DeiRK1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38070700009)(55016003)(71200400001)(83380400001)(8676002)(5660300002)(9686003)(66946007)(76116006)(6506007)(316002)(6916009)(7696005)(54906003)(64756008)(66446008)(66556008)(53546011)(66476007)(478600001)(4326008)(26005)(8936002)(52536014)(38100700002)(122000001)(33656002)(2906002)(86362001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0p2OGpKZlRaaTVRODdra09mMnh3WFBxL3lCczBhVnY3cDdDY0V6TzFaaW1N?=
 =?utf-8?B?RzcxcmFiTGJKTWtxOUs0ZEVlR0JQSWcyTkxUNllxaW4vUDYxRFljaU4wcEgy?=
 =?utf-8?B?QlZaNHBlSlpVZHRDb3I0c3l1d3NqbVM3MVgvRWg3WUFMRnYxWmhMNGRNRjh4?=
 =?utf-8?B?elNaaTVJTnI4bUc4ZEtMY1RiRk1KaGZnbXoycHUvSUpPUGRtNmMvbWZ0R0NX?=
 =?utf-8?B?QTdRcVZia0N3TGJ3WWZRSXBERUsrNkoyZitvanNTUFFQbWFCdGhwRW1xOUdj?=
 =?utf-8?B?YWNkeUVDOHVmYU5BT2s1d1V6YklXN1NSdW9zbjd1VTN3K0RKZ0lPaXo4SHY0?=
 =?utf-8?B?U1RkZEw3bHhpdFkrQTgyMUxsc3pzYVBDN3JJaFhQcldhTmVCeUIxcHRldkxn?=
 =?utf-8?B?dTUyaFBjTkI3Ty9ZRkFCZ1JHUFBxK2JYZ3dnU0hsR2FpV2R6Nk5DU2VOLzlp?=
 =?utf-8?B?OGdLdVJVZTY4R2NkRG50eU0xbVN0VE5XbENrVENGcjJ6c0pjUGR3ZjhVZk11?=
 =?utf-8?B?VGZPYWVHM0dNTlJpS0FxMWdGVmREQ3B1emRBbDRjOHBjMG9yMEtvVXZsSXJ4?=
 =?utf-8?B?TUlPL0NOOHhRWXZWZzNFT2F5VkF4S1pWeit5M0k0VVMwdEd5YkwvNlhMUjFC?=
 =?utf-8?B?Ym4vYnBqRUU1L3psY1NUNTNSaGRPdG5QSGxHVWNucTcybDNEdmZrN3o2V2hN?=
 =?utf-8?B?RVFnVjd6b0hEbDQySnJqTzAwQjUwWnNXaTlYSmhXM3JOZzg1YVVHS1VaQnQx?=
 =?utf-8?B?YmpBTHdZd3hWZ0NnZDVhOUxJcVlMQm0rSFFuaGRZTlkvS2MyNGpVNnFHS0xF?=
 =?utf-8?B?Q0cyVWNHaTdXbHpaRVM4VFdjdmR6aDFkVE14RFVVVnpLZmdtZmg0YkZCVzNr?=
 =?utf-8?B?RmpOKytQS2sxdURJcGNwNHlWZU1ZNDZFdjczRk9UcFIwMlBkTVowckZDL3dM?=
 =?utf-8?B?WnJXZXk2cElzMGlCMThmMGVUK3FuK1dVdXllWFlSbGs1blZDYjBYWllDZ3g1?=
 =?utf-8?B?QmlCMW1IU1pyNUJsdTVGaVRiSXVHYjdJdWIzNmU5UFVMMEhTOXlLOUFlOWlz?=
 =?utf-8?B?djdTUXFNNVJDNEJYZmdzaEhzbGJhb3J1Vm5iQi9SeXF0dm85SEJkUHA3Ui80?=
 =?utf-8?B?MFFQODBTeFV2Y0hSKy9YWEx3Ym1XRmRZWW1ud2wzcVdMRCsvSXpxZG1YOUhS?=
 =?utf-8?B?MkZNT3JWUXRuOG82dDFSWlVPckZVc25nNTNabmwySGVEdlQ3TW5tMjhVVzNN?=
 =?utf-8?B?K1VVK3J2QkdQb2J3bjU0THhubFhxN00vN29hNzVTZm90MVEra2NJN2JEcUNF?=
 =?utf-8?B?VHNUZTlMSnR6MFRZTkxYTXRNTnFoYXVOcXZMNjRGQUVJM1JmOGV6ZmZmU0xq?=
 =?utf-8?B?TGRMUlAzSjRiMXFyd0E0UTZsMlhJeXBCQ2o4Si94eThmZFp6ZDEyVE1uQTN5?=
 =?utf-8?B?aTIvcVBwSjl6ZmxQdG4ybUlGcVk4ZzVTNVNxUjNrS1EwUWlvTnlUK2JVaGly?=
 =?utf-8?B?dTVYemQ1SDdXU3k0RDVaOHV2ZXpFa3AvclgxT2ZHOTBmc3E1OTFWelFGbXRy?=
 =?utf-8?B?OWNmN1NaWkVzc2RxbEY3YmFMU2h5S0JzOWFsZCthMk1MRXJoUFBHZS9lWnpL?=
 =?utf-8?B?QS9wUXg3bVBFYnd5Z1NhL2d1a25QUVhGRmdkdVdtTzB2eFQ4NXBicTdpaHRQ?=
 =?utf-8?B?bitkb3VrcGs3QUVja21BaWdneklUNk1aR0p2SVFOZzcybWJ2UW5ucysxa29T?=
 =?utf-8?B?ZStocVpLWGQvVFFNRk85bEFjZzVlWDA1aGZoTXptRW04a0VqMXo0bmZrc04z?=
 =?utf-8?B?Z0hVdU9VajZiN2RPNjM5L25MUHZkNGhGTVFMQ3JuOFJsQ2srUlBWVjJIT1Y4?=
 =?utf-8?B?blI2TW9kSzBreUl0ZTZabjZaNG0rNDBtVml0aDlSY3BMeVpaSUJnazdMREla?=
 =?utf-8?B?czY4NWIzN2plVlBscjZqbXlpUlBDckdvSUJNMkk0SXZsWm9PTGtaRnpGVnpG?=
 =?utf-8?B?a29vN1B1Z2lWM0E2RDJmdmZha0FRNEFMY2NRNkpiTDFlTVMvVERFUUJxT2pK?=
 =?utf-8?B?WEF1MGJ0ZXl5OXNIR3ZNOXlOdmM2My9WYUpaVzVJditPNkVrbXZadUo0NU13?=
 =?utf-8?Q?MdEk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40331dc1-8086-467a-5b45-08dc1d4ee6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 02:39:49.6547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5flTLTxwx63HAokk/uSZ7pAfz/+Zu0yhaCc5Hg2IJC4QPdwGIkPV800ioAeCu714
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
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
 Deepak" <Deepak.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpLCBBbGV4DQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21h
aWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjQsIDIwMjQgMTE6NTkgUE0NCj4g
VG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBTaGFybWEsIERlZXBhaw0KPiA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogc2tpcCB0byBwcm9ncmFtIEdG
WERFQyByZWdpc3RlcnMgZm9yDQo+IFBNIGFib3J0IGNhc2UNCj4NCj4gT24gV2VkLCBKYW4gMjQs
IDIwMjQgYXQgMjoxMuKAr0FNIFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEluIHRoZSBQTSBhYm9ydCBjYXNlcywgdGhlIGdmeCBwb3dlciByYWlsIGRv
ZXNuJ3QgdHVybiBvZmYgc28gc29tZQ0KPiA+IEdGWERFQyByZWdpc3RlcnMvQ1NCIGNhbid0IHJl
c2V0IHRvIGRlZmF1bHQgdmF1bGUuIEluIG9yZGVyIHRvIGF2b2lkDQo+ID4gdW5leHBlY3RlZCBw
cm9ibGVtIG5vdyBuZWVkIHNraXAgdG8gcHJvZ3JhbSBHRlhERUMgcmVnaXN0ZXJzIGFuZA0KPiA+
IGJ5cGFzcyBpc3N1ZSBDU0IgcGFja2V0IGZvciBQTSBhYm9ydCBjYXNlLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICB8IDEgKw0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAxICsNCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgIHwgNCArKysrDQo+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdS5oDQo+ID4gaW5kZXggYzVmMzg1OWZkNjgyLi4yNmQ5ODNlYjgzMWIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+IEBAIC0xMDc5LDYgKzEw
NzksNyBAQCBzdHJ1Y3QgYW1kZ3B1X2RldmljZSB7DQo+ID4gICAgICAgICBib29sICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGluX3MzOw0KPiA+ICAgICAgICAgYm9vbCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbl9zNDsNCj4gPiAgICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW5fczBpeDsNCj4gPiArICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcG1fY29tcGxldGU7DQo+ID4NCj4gPiAgICAgICAgIGVudW0gcHBfbXAxX3N0YXRlICAg
ICAgICAgICAgICAgbXAxX3N0YXRlOw0KPiA+ICAgICAgICAgc3RydWN0IGFtZGdwdV9kb29yYmVs
bF9pbmRleCBkb29yYmVsbF9pbmRleDsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMNCj4gPiBpbmRleCA0NzViZDU5YzlhYzIuLmEwMWY5YjBjMmYzMCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBAQCAt
MjQ4Niw2ICsyNDg2LDcgQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfc3VzcGVuZF9ub2lycShz
dHJ1Y3QNCj4gZGV2aWNlICpkZXYpDQo+ID4gICAgICAgICBzdHJ1Y3QgZHJtX2RldmljZSAqZHJt
X2RldiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICAgICAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihkcm1fZGV2KTsNCj4gPg0KPiA+ICsgICAgICAgYWRl
di0+cG1fY29tcGxldGUgPSB0cnVlOw0KPg0KPiBUaGlzIG5lZWRzIHRvIGJlIGNsZWFyZWQgc29t
ZXdoZXJlIG9uIHJlc3VtZS4NCltMaWFuZywgUHJpa2VdICBUaGlzIGZsYWcgaXMgZGVzaWduZWQg
dG8gaW5kaWNhdGUgdGhlIGFtZGdwdSBkZXZpY2Ugc3VzcGVuc2lvbiBwcm9jZXNzIHN0YXR1cyBh
bmQgd2lsbCB1cGRhdGUgdGhlIHBhdGNoIGFuZCBjbGVhciBpdCBhdCB0aGUgYW1kZ3B1IHN1c3Bl
bnNpb24gYmVnaW5uaW5nIHBvaW50Lg0KPg0KPiA+ICAgICAgICAgaWYgKGFtZGdwdV9hY3BpX3No
b3VsZF9ncHVfcmVzZXQoYWRldikpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBhbWRncHVf
YXNpY19yZXNldChhZGV2KTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjlfMC5jDQo+ID4gaW5kZXggNTc4MDhiZTZlM2VjLi4zYmY1MWYxOGUxM2MgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gPiBAQCAtMzAzNCw2ICsz
MDM0LDEwIEBAIHN0YXRpYyBpbnQgZ2Z4X3Y5XzBfY3BfZ2Z4X3N0YXJ0KHN0cnVjdA0KPiA+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4NCj4gPiAgICAgICAgIGdmeF92OV8wX2NwX2dmeF9lbmFi
bGUoYWRldiwgdHJ1ZSk7DQo+ID4NCj4gPiArICAgICAgIGlmIChhZGV2LT5pbl9zdXNwZW5kICYm
ICFhZGV2LT5wbV9jb21wbGV0ZSkgew0KPiA+ICsgICAgICAgICAgICAgICBEUk1fSU5GTygiIHdp
bGwgc2tpcCB0aGUgY3NiIHJpbmcgd3JpdGVcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gPiArICAgICAgIH0NCj4NCj4gV2UgcHJvYmFibHkgd2FudCBhIHNpbWlsYXIgZml4
IGZvciBvdGhlciBnZnggZ2VuZXJhdGlvbnMgYXMgd2VsbC4NCj4NCj4gQWxleA0KPg0KW0xpYW5n
LCBQcmlrZV0gSUlSQywgdGhlcmUncyBubyBpc3N1ZSBvbiB0aGUgTWVuZG9jaW5vIHNpZGUgZXZl
biB3aXRob3V0IHRoZSBmaXguIEhvdyBhYm91dCBrZWVwIHRoZSBvdGhlciBnZnggZ2VuZXJhdGlv
bnMgdW5jaGFuZ2VkIGZpcnN0bHkgYW5kIGFmdGVyIHNvcnQgb3V0IHRoZSBmYWlsZWQgY2FzZSB3
aWxsIGFkZCB0aGUgcXVpcmsgZm9yIGVhY2ggc3BlY2lmaWMgZ2Z4IHJlc3BlY3RpdmVseT8NCg0K
PiA+ICAgICAgICAgciA9IGFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIGdmeF92OV8wX2dldF9jc2Jf
c2l6ZShhZGV2KSArIDQgKyAzKTsNCj4gPiAgICAgICAgIGlmIChyKSB7DQo+ID4gICAgICAgICAg
ICAgICAgIERSTV9FUlJPUigiYW1kZ3B1OiBjcCBmYWlsZWQgdG8gbG9jayByaW5nICglZCkuXG4i
LA0KPiA+IHIpOw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
