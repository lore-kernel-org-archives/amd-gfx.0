Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB8DC05027
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 02:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BE210E03E;
	Wed, 15 Feb 2023 02:51:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F19910E03E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 02:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fhr49ddtLTel2MYOgwrwp3mnVJm6dOsPA+yeUoX4eREODe6MOhV1LlCMexNVYZJz0yApLwIfR0VB0MG9uaeHPJVgUqSBYQ7WPbtZK8sFzVlImh/VnXYgCxT7xqvggpyVMdKNHCAQ2Ign7Z0ZxQDZzvTqkTA1C6p+GwVNEwtrh//V6Rjwneb56l3Wu5zWLLaC1/Z350vW+d3NqlhgLCpTbrd8kV4rSHhWLDFSM0p40uSNHY60WvtJ5AtKnGP2j09J/nKB0oVcK38Oh3Pb+NC0EiHSnkSiw8YDfS0xh3pxH9ahaUEK+RXYC2TxtG8dlL9lkUcFrX0uWfkqmGiv7ayuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1txDqZxSFVbhZgwE0qUKCikdeoRCSMIufciCLN7Gz0=;
 b=UvkhCaKfUg9Gy6gGVjtPh2Ns7gcfiGv6IxNw//d8q9vVgnxu311j59E2DV3fQYtdLZWq57UFLHpg+tpjHGOD/ysDNTRQfd/8QtYU/qJ1oSK5PT3mT11HdozqCReRxIOjRp23bbQlkjRsX/c6vyKRFwi4cVtFSo1emql2Jb0Ol0h+Fg2c86QHCvtKlvxQaeSyRQaFCzfsr3DmMmVWXoRnTjdIbrKU6QmOpfatoulDWTpGIlBpk6po0dabPSyISnstdVCxmHnYWsQFYhO8PnhGCG24AfB4BBQD+anUL7MWFtekdo3E0nobCms5c49F8YPEKkoWwMpG+o17SjFV0QqkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1txDqZxSFVbhZgwE0qUKCikdeoRCSMIufciCLN7Gz0=;
 b=PsBvC0t8FGLFMRj6JehmFHpad2zTIunKXctN98LBNEjbM87TUGwkHvOuMF/hMqLbIHAvQf9kFFyFeufq7SnY3AAnE6RdKQ/S+MKcTOxzziQn1nqC6/XWeiCvV22iBN+NK+Ore2XecO6lWWbgT6nqohGPt0Q49SdsiLNXKThk4RQ=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 02:51:02 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::66d:8790:631b:f03]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::66d:8790:631b:f03%5]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 02:51:02 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Thread-Topic: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Thread-Index: AQHZQGYt6UtYU+TqfkGPLAP/umhypK7OYmkAgAAYTNCAAFJDgIAAeHgA
Date: Wed, 15 Feb 2023 02:51:02 +0000
Message-ID: <DM4PR12MB52616659C39CB1242A4AD8B89DA39@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230214111851.2525197-1-shane.xiao@amd.com>
 <ca40db72-6c04-e3cd-38f9-3254f37c850a@amd.com>
 <DM4PR12MB526136D00F81419EEFCE47579DA29@DM4PR12MB5261.namprd12.prod.outlook.com>
 <0a5fd1ae-45b0-96bb-5160-a34b57fc6a2a@amd.com>
In-Reply-To: <0a5fd1ae-45b0-96bb-5160-a34b57fc6a2a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|PH7PR12MB7354:EE_
x-ms-office365-filtering-correlation-id: 97d3dd72-803e-4b6c-9a12-08db0eff79de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 68WAHbq1FHOE7281ywaF65OCOXEOGY2qHcEv1Tgt4/ghT3r7TTeonzhMQHIOKiNpKUzr7NG1yiaJKGbQZ6V5x5VsPAnfrSWDYH9HbJTykK6nChcqr/qBOzEGDmuOJiy94sn0eOCGDfE4fmJPW+Hqw0KqHhdkYx/iYQlgcxv5J7KpE/6KHwDzsix2jyB7NMimbZ+2MxynOxZdFNZrIL2aRmRvarq1SHhn4yLX6G3Cr9/TPXWXTGmx3XWcTyAjtMHYgtgvQOh7a8KH2wPqQW2+TasnnvrPsmiGLlvVj9bjr7wfNf7vqGWZEHHD1JlVk1AklQAYMQaSHrV/HsBFz3dOgn4PiTXaDfBdMMvLiBj7+GXsENzInLXL2U/ZNusEbSJSR2o7AmqNQ/S2NBS2QftqmiFiH4YUysog21+XBZKyJ9u4npcb4T69Sf7X8u9ooQDcYbB71Hny2USZAXEFz6gt1ZNYbULilKdX0anDbKIZXwKGiUxBCrIXisf75z1cg+MJuXA1QffqhN5mHeNh6Uk80laN2IGk00ENGFkph6AOST1Ebs3LHZ8w2ACC0zEOoGGVhBkJW41DCms2odj8/3zyZi958z2PdZyALjrkJqBqqp+R3FkjZp4aO0JOqkHUBY46rNd8nC29g4eMGcIxsGsuSsMRZQ1bTysF3419pyJJxOMnZk5gEGsCaiIV+lo1MvWCMZWWCsyOQR1fzcjMDIIk+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199018)(71200400001)(478600001)(55016003)(122000001)(83380400001)(53546011)(9686003)(6506007)(26005)(186003)(2906002)(6636002)(33656002)(316002)(110136005)(41300700001)(5660300002)(66946007)(52536014)(8936002)(4326008)(64756008)(66476007)(66446008)(7696005)(76116006)(66556008)(8676002)(38100700002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEJ3Q0M0aEpiTDlGSkZ2TUpHMW1FTzNUMVU4S1htYXlZVE8zd2kxTlY3czhH?=
 =?utf-8?B?SzdmclpOcEVkWnRLQjkvNzh3NEhoYTdGcG5XTXY2RlBOb2tVOW42MHJoMFpF?=
 =?utf-8?B?cXk2SXhiL05iYmltS0diR2pkcFJCbXF1b1JDMTZKRFQwMHluNTBBazZHZlp2?=
 =?utf-8?B?MlNFZzR0ZXpYWnBoVWFCSSt2eXVmbTJMZE0yUHN3ZDZ5RlkrZjNZMWFNZ29l?=
 =?utf-8?B?a1JjR3Yxb1JGdkxONlppWWNGVy9yU2NvemF5SUd3UURha1lRbE5mZXNQVTFO?=
 =?utf-8?B?SjJIMlR3SzE5ZGNpaEk4YkIzTDVNZG5vekF5MGhma01Gd0Eva1RmSDFZbHRY?=
 =?utf-8?B?dHBsSWVPc0toeWxkTzNBb1ZaMG1PUGlVVGx2bVYwV0dNRWhxSmJPenErajhz?=
 =?utf-8?B?Syt5bWcyZGRIZUs5RUN5US9TUFNVOC9kNUQ5ejBBZERjNDR4Q2syejNZUTZV?=
 =?utf-8?B?L29MK1VuVWczMzkrenJXa01pT1hOU1l1WmlBb0ppSUl0Z3ZrS2lwVTlwSEVq?=
 =?utf-8?B?MUowWGdZdVpQZDUxR0VPL29raXkxbW90eDdyOWk3VGxKUFI0Skg0b3dnRllI?=
 =?utf-8?B?RGhFdHRLSUpmdzJUMzdxeWtzRGphUG1zc1N4OHM0UmxGQjV1dmNxQldZc1RO?=
 =?utf-8?B?MmNJRVpiUEljZUh1aDJmNFd1dnpZQmRiOG9SS08rNmpyZzNsVW01Z2RReTJo?=
 =?utf-8?B?cW9PaE9LM2lrU1h4TXFFUEpVdDAwTDFXdk5KaEhVcko5c2UwMVZ1NnB5T3c2?=
 =?utf-8?B?cHgwdU1sTHVubmJ4eVZ2U3Z0bHJEYkVUNkJIWGdHVnpKK0l1WEVHS1lSZUc2?=
 =?utf-8?B?MWk1em9UYXRJMkRGWlF2SkY4S0loZHZoQ2J1RER0S2phbXVWRkRHYlJjU3Y5?=
 =?utf-8?B?VW9JeSthVmY0REFraHRWQ1I2ZWJBcUVkS1gxVFE2TWZ6S3o2RCtvK0RheGgx?=
 =?utf-8?B?MG1LMkhpOUc4TnRRaXJ1N2pQUTFsYWpCaUpsWnJpR3F1dUpuMko4czhxTGRR?=
 =?utf-8?B?QlBiSDBMT2UyOHE2TEZ2NlBwZCtST0diZWR0VEdnS3E5MnZIdUM3WFlUdHJD?=
 =?utf-8?B?aFEyWTQyaDJxNGVQaUowMjBMTXlLK3E5QzZVWGJ5NmNEVklpWVlVQXpSZXBr?=
 =?utf-8?B?NWxmamNXbm1nNmY5RTdoZlFPeUxsUHBpK3dSNVVEUHAyOHVPaHJHR3VsZndi?=
 =?utf-8?B?a0tCdDlDVkNEY0RMbkp1dnY4Y3FxRExqLzBZb1Irck92cU5OZmxTSVlqL1FB?=
 =?utf-8?B?aU5Jd0VZR1VFSFpDTllDdnZDNU1OQ0E1U1IrVHBsVXVkNUtpR2JHQUFHd0RK?=
 =?utf-8?B?a09STFJEcE91UDdOd0RoTmhZK2JRSGpnSlBoeXg3MEJ4NGxRMnFseE9IckFy?=
 =?utf-8?B?eHMwQ0wxSXRyY3dUSzI4eTFpNTQ5MG5DL2xkU0JpTmk4b2hLbm1vY0ZBYU1K?=
 =?utf-8?B?SDMvUDNVNG9laEhXTmRGaDVlaFYxQnUrck9wWFNkTDJuaXpUYzNwTDFESHk0?=
 =?utf-8?B?ZTg4T1J3em5RdCtRdExpZzJlNDNkaVRQVlRERVZwOUVFMVNZa0ZVMm1LaHJk?=
 =?utf-8?B?Mlc4a2FvTU5ZZjVCQnByYy9YQWtPeXdOaFlkY09UQ01nYkNVUkhLdXpURzNz?=
 =?utf-8?B?MXRyOHU5Rk1RTmwxREorUmVsVnVGdUd5V3dqU1hZcjlSQXYzR05qbzEvMnVB?=
 =?utf-8?B?S0VweUlBTE5zaHludEQ3OWd2eEhCN2VXbkZJWXd4VGlEbFJJWDBWOFV6TFZs?=
 =?utf-8?B?MTMzSHY1MHN4cFRQblNZcS9VWitxOVQ0WTU3cDNoUUp1Q0lqbkZKSFVlNUJl?=
 =?utf-8?B?TU1wT1doc3Z5SVIyQlZwQUgxR05hK2Y3aUNzUlhkZ2tVVTYyZGdSSVgyQlFG?=
 =?utf-8?B?S1BqMUtrNWxOMnloUWRZWHBEWk9oeVZ3MThkVnBRanZmck1oaU5WVFB3bjR4?=
 =?utf-8?B?WTJ0NmNBMzhuV0FLQlZEMnVSVG1LOUhLc2txNm1xcXk3UnlWSjJ5RTBUQURU?=
 =?utf-8?B?UVZvdkE3djBTUHd2elZYbWlmb29YSHhEYkxKS0FQa2IvVDVWVVZUQjhmOXJq?=
 =?utf-8?B?UFlmQWMzTnh1VHEyeEk1VTNlTUtWcTRPSFdRMkNHWGFRMytKa0tXaVN1cllp?=
 =?utf-8?Q?wqFGOhPPMaeNpuqfy/KbymVEV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d3dd72-803e-4b6c-9a12-08db0eff79de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 02:51:02.6669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDDq6ErrftOb8EefLWuq5jWV3cZoE4n81fo5fip973DtyHy2sjpJAKP9HlFkDv0eXMeaqCv5c8MnDGi2XpcIEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQpGb3IgcHVibGljIHJldmlldw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgRmVicnVhcnkgMTUsIDIwMjMgMzowMiBBTQ0KPiBUbzogWGlhbywgU2hhbmUg
PHNoYW5lLnhpYW9AYW1kLmNvbT47IFBhbmVlciBTZWx2YW0sIEFydW5wcmF2aW4NCj4gPEFydW5w
cmF2aW4uUGFuZWVyU2VsdmFtQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBk
cm0vYW1kZ3B1OiBvcHRpbWl6ZSBWUkFNIGFsbG9jYXRpb24gd2hlbiB1c2luZw0KPiBkcm0gYnVk
ZHkNCj4gDQo+IEFtIDE0LjAyLjIzIHVtIDE1OjUzIHNjaHJpZWIgWGlhbywgU2hhbmU6DQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5
IDE0LCAyMDIzIDg6NDEgUE0NCj4gPj4gVG86IFhpYW8sIFNoYW5lIDxzaGFuZS54aWFvQGFtZC5j
b20+OyBicmFobWFfc3dfZGV2DQo+ID4+IDxicmFobWFfc3dfZGV2QGFtZC5jb20+DQo+ID4+IENj
OiBQYW5lZXIgU2VsdmFtLCBBcnVucHJhdmluIDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQu
Y29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogb3B0aW1pemUg
VlJBTSBhbGxvY2F0aW9uIHdoZW4NCj4gPj4gdXNpbmcgZHJtIGJ1ZGR5DQo+ID4+DQo+ID4+IEFt
IDE0LjAyLjIzIHVtIDEyOjE4IHNjaHJpZWIgU2hhbmUgWGlhbzoNCj4gPj4+IFNpbmNlIHRoZSBW
UkFNIG1hbmFnZXIgY2hhbmdlZCBmcm9tIGRybSBtbSB0byBkcm0gYnVkZHkuIEl0J3Mgbm90DQo+
ID4+PiBuZWNlc3NhcnkgdG8gYWxsb2NhdGUgMk1CIGFsaWduZWQgVlJBTSBmb3IgbW9yZSB0aGFu
IDJNQiB1bmFsaWduZWQNCj4gPj4+IHNpemUsIGFuZCB0aGVuIGRvIHRyaW0uIFRoaXMgbWV0aG9k
IGltcHJvdmVzIHRoZSBhbGxvY2F0aW9uDQo+ID4+PiBlZmZpY2llbmN5IGFuZCByZWR1Y2VzIG1l
bW9yeSBmcmFnbWVudGF0aW9uLg0KPiA+PiBXZWxsIHRoYXQgaXMgYSB0cmFkZSBvZmYuDQo+ID4+
DQo+ID4+IEFsbG9jYXRpbmcgdGhlIEJPIGFzIG9uZSBjb250aWd1b3VzIGNodW5rIGFuZCB0aGVu
IHRyaW1taW5nIGlzDQo+ID4+IGJlbmVmaWNpYWwgYmVjYXVzZSBpZiB3ZSB0aGVuIGxhdGVyIG5l
ZWQgaXQgY29udGlndW91cyB3ZSBkb24ndCBuZWVkDQo+ID4+IHRvIHJlLWFsbG9jYXRlIGFuZCBj
b3B5LiBUaGlzIGNhbiBiZSBuZWVkZWQgdG8gZGlzcGxheSBzb21ldGhpbmcgZm9yDQo+IGV4YW1w
bGUuDQoNCkhpIENocmlzdGlhbiwNCg0KVGhpcyBjYXNlIG1lYW5zIHRoYXQgeW91IGFsbG9jYXRl
IEJPIHRoYXQgaXMgdW5uZWNlc3NhcnkgdG8gYmUgY29udGludW91cyBhdCBmaXJzdCB0aW1lLA0K
YW5kIGxhdHRlciB0aGUgQk8gc2hvdWxkIGJlIGNvbnRpbnVvdXMuIEknbSBub3QgZmFtaWxpYXIg
d2l0aCBkaXNwbGF5LiBDb3VsZCB5b3UgZ2l2ZSBtZSANCmEgZmV3IG1vcmUgc3BlY2lmaWMgZXhh
bXBsZXMgPw0KICAgDQoNCj4gPiBZZXMsIEkgYWdyZWUgdGhhdCBvbmUgY29udGlndW91cyBjaHVu
ayBtYXkgZ2V0IGJlbmVmaWNpYWwgc29tZXRpbWVzLg0KPiA+IEJ1dCBhcyBmYXIgYXMgSSBrbm93
LCB5b3UgY2Fubm90IGd1YXJhbnRlZSB0aGF0IGFtZGdwdV92cmFtX21ncl9uZXcNCj4gY2FuIGdl
dCBvbmUgY29udGlndW91cyBjaHVuayAgaWYgeW91IGRvbid0IHNldCBUVE1fUExfRkxBR19DT05U
SUdVT1VTDQo+IGZsYWdzLg0KPiA+IEZvciBleGFtcGxlLCBpZiB5b3Ugd2FudCB0byBhbGxvY2F0
ZSA0TSs0SyBCTywgaXQgd2lsbCBhbGxvY2F0ZSBvbmUgNE0gYmxvY2sNCj4gKyBvbmUgMk0gYmxv
Y2sgd2hpY2ggaXMgdW5uZWNlc3NhcnkgdG8gYmUgY29udGludW91cywgdGhlbiAyTSBibG9jayB3
aWxsIGJlDQo+IHRyaW1tZWQuDQo+IA0KPiBPaCwgdGhhdCdzIGluZGVlZCBub3Qgc29tZXRoaW5n
IHdoaWNoIHNob3VsZCBoYXBwZW4uIFNvdW5kcyBtb3JlIGxpa2UgYQ0KPiBidWcgZml4IHRoZW4u
DQoNClllcywgSSB0aGluayB0aGlzIGNhc2Ugc2hvdWxkIG5vdCBiZSBoYXBwZW5lZC4gDQpBY3R1
YWxseSwgSSdtIG5vdCBzdXJlIHRoYXQgd2h5IHRoZSBhbGxvY2F0ZWQgQk8gc2hvdWxkIGJlIGFs
aWduZWQgd2l0aCBwYWdlc19wZXJfYmxvY2ssIHdoaWNoIGlzIHNldCB0byAyTUIgYnkgZGVmYXVs
dC4NCkRvZXMgdGhpcyBoZWxwIGltcHJvdmUgcGVyZm9ybWFuY2Ugd2hlbiBhbGxvY2F0aW5nIDJN
IG9yIGFib3ZlIEJPPw0KRnJvbSBteSBwb2ludCBvZiB2aWV3LCB0aGUgVExCIG1heSBiZSBvbmUg
b2YgcmVhc29uIG9mIHRoaXMuIEJ1dCBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcy4NCg0KQmVzdCBS
ZWdhcmRzLA0KU2hhbmUgDQoNCj4gDQo+ID4NCj4gPj4gT24gdGhlIG90aGVyIGhhbmQgSSBjb21w
bGV0ZWx5IGFncmVlIGFsbG9jYXRpbmcgYmlnIGFuZCB0aGVuIHRyaW1taW5nDQo+ID4+IGNyZWF0
ZXMgbW9yZSBmcmFnbWVudGF0aW9uIHRoYW4gbmVjZXNzYXJ5Lg0KPiA+Pg0KPiA+PiBEbyB5b3Ug
aGF2ZSBzb21lIHRlc3QgY2FzZSB3aGljaCBjYW4gc2hvdyB0aGUgZGlmZmVyZW5jZT8NCj4gPiBJ
IGhhdmUgdXNlIHJvY3J0c3QgdG8gc2hvdyB0aGUgZGlmZmVyZW5jZS4NCj4gPiBUaGUgYXR0YWNo
bWVudCBpcyBzaG93biB0aGF0IGFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2gsIHRoZSBvcmRlciA8
IDkgdG90YWwNCj4gdnJhbSBzaXplIGRlY3JlYXNlIGZyb20gOTlNQiB0byA0M01CLg0KPiA+IEFu
ZCB0aGUgbGF0dGVyIGhhcyBtb3JlIGhpZ2hlciBvcmRlciBibG9jayBtZW1vcnkuDQo+IA0KPiBB
cnVuIGNhbiB5b3UgdGFrZSBhIGxvb2s/IFRoYXQgcHJvYmxlbSBoZXJlIHNvdW5kcyBpbXBvcnRh
bnQuDQo+IA0KPiBUaGFua3MsDQo+IENocmlzdGlhbi4NCj4gDQo+ID4NCj4gPj4gQlRXOiBObyBu
ZWVkIHRvIGRpc2N1c3MgdGhhdCBvbiB0aGUgaW50ZXJuYWwgbWFpbGluZyBsaXN0LCBwbGVhc2Ug
dXNlDQo+ID4+IHRoZSBwdWJsaWMgb25lIGluc3RlYWQuDQo+ID4+DQo+ID4gSSB3aWxsIHNlbmQg
aXQgdG8gcHVibGljLiBUaGFuayB5b3UgZm9yIHlvdXIgcmVtaW5kLg0KPiA+DQo+ID4gQmVzdCBS
ZWdhcmRzLA0KPiA+IFNoYW5lDQo+ID4NCj4gPj4gUmVnYXJkcywNCj4gPj4gQ2hyaXN0aWFuLg0K
PiA+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU2hhbmUgWGlhbyA8c2hhbmUueGlhb0BhbWQuY29t
Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dnJhbV9tZ3IuYyB8IDIgKy0NCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYw0KPiA+Pj4gaW5kZXggNzVjODBjNTU3YjZlLi4z
ZmVhNThmOTQyN2MgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdnJhbV9tZ3IuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZyYW1fbWdyLmMNCj4gPj4+IEBAIC00NTMsNyArNDUzLDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdA0KPiA+PiB0dG1fcmVzb3VyY2VfbWFuYWdlciAq
bWFuLA0KPiA+Pj4gICAgCQkvKiBMaW1pdCBtYXhpbXVtIHNpemUgdG8gMkdpQiBkdWUgdG8gU0cg
dGFibGUgbGltaXRhdGlvbnMgKi8NCj4gPj4+ICAgIAkJc2l6ZSA9IG1pbihyZW1haW5pbmdfc2l6
ZSwgMlVMTCA8PCAzMCk7DQo+ID4+Pg0KPiA+Pj4gLQkJaWYgKHNpemUgPj0gKHU2NClwYWdlc19w
ZXJfYmxvY2sgPDwgUEFHRV9TSElGVCkNCj4gPj4+ICsJCWlmICghKHNpemUgJSAoKHU2NClwYWdl
c19wZXJfYmxvY2sgPDwgUEFHRV9TSElGVCkpKQ0KPiA+Pj4gICAgCQkJbWluX2Jsb2NrX3NpemUg
PSAodTY0KXBhZ2VzX3Blcl9ibG9jayA8PA0KPiA+PiBQQUdFX1NISUZUOw0KPiA+Pj4gICAgCQlj
dXJfc2l6ZSA9IHNpemU7DQoNCg==
