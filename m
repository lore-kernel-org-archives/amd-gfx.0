Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4890C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 17:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F08710FECF;
	Tue, 21 Dec 2021 17:01:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15B110FECF
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 17:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG/o80rSoscU9NlX6AmS2X3hPKSILFKgm4Y2BtZld1+BbDVmgUeC29LQt+Fki4TdEbLiCN96DA/DPCgcLf1d90KY2Yh9RW+p8nTy3KZ5vXNWKz997QBDJrVdiw6sWzlw0Q4pthSXSzzH1zFC4IJOsFlAJEwvBZYG7161oOoxlsf+kWT3oMu88ZoKxgLEGMvU4PthRvx7D2DSCkCy1SikEm7is92PlpfykoxEREMKUKQ+WVSA0+7V2cghgK7cNg4wZIJLt9rgbRyRRUc38t1Rxn14Agl8v8BVmn7etoMh3IQLArc9qtqgWxWB/SLgV7yHuGKvJtpcN6gLVF08ixeXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpljRbA0IfRouYLbUXeePdy6QjmmmNdpSvq6nN584LA=;
 b=QkG/RK97oxiDzrQEAb73bc0tj8uL8AiOh9dxax2tuCBiXO4kL3sCDBcLF1qNQAdBOOMGcQo6jCtbFC81bJLt3q3rQsK+ygIk5cb19S6RXZAUt2vdv0Tu+XsNGZuBKtI41CYzdMMEIkwJ2J1K2T4wxnM78RoNYHpMidNdzWYTayC6Xzm0Un/DAoj/n+/0buK27Gl7NprwBdpkCCDvzAgCdzRSsPsC2coyLrrp2+EQxzCF/QdWa3iB39a1KUSzua0iJnjuwDRu2jsoC32Z2K9ql/3C9ATq3BnUQU+cG9YLhGH2cfOPenU/FDvah2z8pXtpWaSHkiomomBPPrqdcdutFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpljRbA0IfRouYLbUXeePdy6QjmmmNdpSvq6nN584LA=;
 b=QubJ+E2yPrvm5l1fEfXzDYyN356xEA7mZWrK2UGrgws2bx7fUvDvPPBy6OHjU6r3qjW39yyeTWwS5uv5Q/me+0ANx3lhp8/ArcRA4UiNyLFbkcgHBUvGROm5+cGJauH9oGm9mfpZoz1xPnecOM23O6Bo7B4bsbqDl8kdVgJhP9M=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 17:01:11 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%7]) with mapi id 15.20.4823.017; Tue, 21 Dec 2021
 17:01:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Imre Deak
 <imre.deak@intel.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release PCI
 device ..."
Thread-Topic: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release
 PCI device ..."
Thread-Index: AQHX9chgu3Z8LhpJr0q5gQSTVOUPJaw75roAgAAI7ACAATPqcA==
Date: Tue, 21 Dec 2021 17:01:10 +0000
Message-ID: <BL1PR12MB514437F7B1726A2173650FBFF77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
 <20211220213254.GA7250@ideak-desk.fi.intel.com>
 <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
In-Reply-To: <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-21T16:28:19Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7d9c7ac9-17dc-459c-afa0-68943568ec01;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-21T17:01:12Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 88c39f22-dce7-46a9-8cbc-2d83254178df
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ce73021-f7a1-45b4-6443-08d9c4a37d22
x-ms-traffictypediagnostic: BL0PR12MB5508:EE_
x-microsoft-antispam-prvs: <BL0PR12MB5508AF9ED11A9135727D71F3F77C9@BL0PR12MB5508.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VmO1/1BrK8YsY0bBG8/unei0RVI/yxhM52/6/BU3gV86HlQtc89HV0R+EkA/C1WD1OmKXtW8HPrSuxxKvKydktKfkcrEXy4cWSrPfhq1CKC0pvl5IneWqKd/MTAfNG2kLuDEHOHVCvGDPZJKbzZLzfqki1y5iVV2nJzrMNbgGTxr8w5a41x16WJZWTna4l8d5BeMY/bZ7YY3hjL2zk9mplPPKCYWRfsTMmZyk0D/MWXjufexJrcqvtFwWgGi651Ubu9JMF1V1jAxepWSzaStZD+OyNNR+vzXeADerDFq4B4wZE7CqoUggXcD8b3XZ+TWGsrdl4GSDGJP3YZuZurCXY92PkPQEHIdBEKmN1fqsVwbPfXToZ6LJFbPnYBWZ/+4bP39RsqZXzD36QICTJMftWDNAjfluzR4w8iCLtqPcQDP2gaTOk6HPOsah+2hNR5X8nbGIGszQBeBk7FoFvqhrMFBDlKksEM5plXZoWGn9VBHd2skiwqZacHAveSKmfPdEO11DBQmCcjahr3OG+ESxQ7ixZ29IZ47I8b9YvcfJ0ytomRyL8AhL0mXaraYHqKgscppPpHFZM/OzN30myMI1y6xkMEkLCyXlf17qMQ3BU+RrQuDUa3+pJ//4E94FPhshuAW60qVKh5bAcwHdh7z8MtumwEnuApSTE+DRx6JQODKROaB8xEybwzUhk0ONzXGdLT4oMRv979DwSvI4osoMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(6506007)(122000001)(2906002)(8676002)(86362001)(7696005)(38100700002)(508600001)(52536014)(55016003)(38070700005)(9686003)(83380400001)(110136005)(186003)(71200400001)(54906003)(316002)(4326008)(66446008)(66946007)(66556008)(66476007)(33656002)(76116006)(8936002)(26005)(5660300002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWQ4cWtKQ2hPQmFQR2xFNE1DNWFrbFBjN2xNN0dhdEM3K0R3UkltMCtzeGdv?=
 =?utf-8?B?SC9SSENkdWNhWkFxQ3E3M3QrVU01ZHFUazRiL2ZqWGZpYmE4ZjhuTGpQRDlD?=
 =?utf-8?B?bmsvVlkxejAyVSs5UzdibVJkRkpXTmNyZWN2NUM2WkNyMG9hNGN3Q3ZYdGI0?=
 =?utf-8?B?WW9haU1TQnFUZ0g3RkswNkJOZWhGMFcyT3FtbUQ5R2RWU091TkRiMFdXcW5j?=
 =?utf-8?B?OXJ5Ky80cDdiQnRLOHJtVTdzQTdSKzI5d2JNNFliZG9PWU9CeUtFczhGZVFQ?=
 =?utf-8?B?NDRzVEZhMVcrbFpONDh2ci9OUHBKem9PRGdLWVRJMlFtRWRPVmJxbGFKMVZy?=
 =?utf-8?B?UVBHbDVNbEJIOE9vYzByOGUzQXF3VzVZZHJRcFpRdU1OVFY2RGo5N29FZkVw?=
 =?utf-8?B?eTNjRHlodjFXOWdrRmd3MkRxMnVUMUJTY2VhSDVVT3NqKzJnS1ZFRzNwZTRN?=
 =?utf-8?B?QTNSS2RjY3IzWFM5aWJTYnFyWWgyV2lWdjBzSFVqVjJKUkdwajN0aXNCVTJn?=
 =?utf-8?B?cFM1cG1ka0labVZMdkc3aHFpOE9DNVJSd000TWRNcEFkYzRSTWhNS1psV1lu?=
 =?utf-8?B?c0x4Y01lWGMvbXV1amhRa0JQOFk4RjhxMW1vTTU0aWxzQnpGa2xPMk5uZ2lp?=
 =?utf-8?B?U0xHS2w0VzBOU3N6cmxvTTdmM0FZUmZadDkyT0MrMUxlenZ2SS91MGdiS3M0?=
 =?utf-8?B?NHYreVlMT0U4Q3l3UExMd1l0aHIyeDdoeEhjSWFYOGEya2xkeGRYSVhRTVpk?=
 =?utf-8?B?ODNpdnp0RWlBK21Qb3IzTlNPeHlrcTFuTURPZGlFbUttbFhBTW05VW9sTTFY?=
 =?utf-8?B?aWF6SmIxbWw4Q3QzL1NPamg5Y1FpQms2YjJUWlFLeElWbk1ZSmZkcFJIc0gz?=
 =?utf-8?B?RysyTXpDSk9OZzYvWDRQcm5zUlljZ2czU0E1WUdxWFBXcEt3bVdha0JSdnhW?=
 =?utf-8?B?Z3J6WEtmaG85OGdrSTlPZGJaRlAvcWV1T0UzNEw5UnR3c3I5dlJ4bnRwdlc3?=
 =?utf-8?B?L3FCVVc2S3oxaE5DZVpGTDFiRnJDeHVMcFpOcWZwTDU1VWxaTlh5d2ZnL3ZP?=
 =?utf-8?B?V2tFMW1GS0lQNU13SnpxQlh2Z29EanpHY3NVNkVHVFJtZHUxVEFCdURLc1BN?=
 =?utf-8?B?ZzF3ZTZTNWNpMVFhdWltMXJvRlBqd2FVRDdSU3dtcXNKclh3L21oMDRlU29N?=
 =?utf-8?B?UGwxUW5vdWJQdWNGdndGOGZBMFU0K2VpYWFTODQ0cVpZeWd5TWtVZFdoM0p4?=
 =?utf-8?B?SmcwSHRncUVBcmRYNzdxSnhJRkI5cXpQOC9mWnU2eVZMTzdTT0xUMDZYNmw4?=
 =?utf-8?B?b0luL1JCVytQdFlTZGJqUFd4U3l4U1pYMmNTR2NodmQ1TU50TTFoQXFhZTRK?=
 =?utf-8?B?TlFtU1daQTFDQWkxQXluQjFHWmxJRHNjVjgzajFkNjNMcUlBUGNGcjg3Sk5F?=
 =?utf-8?B?OE9TWlJ2Nm96UENYK3pmY2dpSjBYUmNLS244dU5OMFhLM2c0bU1uRkJDWGV0?=
 =?utf-8?B?NW8rTjlleTlHaWFiWkEwYUN2NUlYRUVBNTU1QkVJbWczWkRuMjZZNmtEVFpR?=
 =?utf-8?B?TE9CRHBHWmFva0RNUXRvQndWUy9GUG41SmRRM3RKVVR6RGZzM3BLZ0RCRldx?=
 =?utf-8?B?NGVjR2Y0V3hVMkJHdGN1bmh4amlqNnExelB3eXJTRXlSWERPemFhWWZtS21G?=
 =?utf-8?B?M2NLYjJWMStFRUNEeWFrZEltZmcvWG1rbXVhcEdQcE9UMHVQU2ZMTUVhcHFO?=
 =?utf-8?B?dTQ4enNYQlV0M3U2WTEydTYzNkswdVZ0WGprYjRqcE9mTHY5QThHUTUzeVFj?=
 =?utf-8?B?eTVrZnM2c2VpL3VqY1A0YmM2N0tjWUpPbk9XUWV1SWMwQy9JbFY5U1RaWE9s?=
 =?utf-8?B?Nkw2OEgwT3I4SVdTbE1ZTU14VGhndDRjdEFuU3JhdjFjTHpSd1U0My8zR1ZW?=
 =?utf-8?B?eVhUdDNuSm1tdDhCK1BFd3REMk43TGZlOElWOU9vcWgwQWFXUzZHcjFmUHNF?=
 =?utf-8?B?NlZqbjRhdWp2N3VVUWRmOGUxNng3cUVGNVlxMjVZbmN5QTg2N2xhdFFvUTgx?=
 =?utf-8?B?aXF2b0tQc3ZQaE1neHRML0pCRVpLSVRyY1k2Wk5YWkZ4S1RSQ2dZQU5JTGti?=
 =?utf-8?B?azU3Z2x0VXdxeFhOcWhIUnJuTVAxZlh6eGN5RVVEMzdYY1FvdkZVTUR6S3ND?=
 =?utf-8?Q?6wQfrjEimcrpgQDCaZC3Mlc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce73021-f7a1-45b4-6443-08d9c4a37d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 17:01:10.6192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qh72AZkhjXDPOyiiLT6btExeXqmCf8yAMycZ1xtzHXRElqDN9nTueH/1kkhx5BwXLodPd+yeqDzqLSsHPfVLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBU
b3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IE1vbmRheSwg
RGVjZW1iZXIgMjAsIDIwMjEgNTowNSBQTQ0KPiBUbzogSW1yZSBEZWFrIDxpbXJlLmRlYWtAaW50
ZWwuY29tPg0KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD47IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEthaS1IZW5n
IEZlbmcNCj4gPGthaS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4NCj4gU3ViamVjdDogUmU6IEV4
cGVjdGluZyB0byByZXZlcnQgY29tbWl0IDU1Mjg1ZTIxZjA0NSAiZmJkZXYvZWZpZmI6IFJlbGVh
c2UNCj4gUENJIGRldmljZSAuLi4iDQo+IA0KPiBPbiBNb24sIERlYyAyMCwgMjAyMSBhdCAxOjMz
IFBNIEltcmUgRGVhayA8aW1yZS5kZWFrQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBhbWRn
cHUucnVucG09MA0KPiANCj4gSG1tbS4NCj4gDQo+IFRoaXMgZG9lcyBzZWVtIHRvICJ3b3JrIiwg
YnV0IG5vdCB2ZXJ5IHdlbGwuDQo+IA0KPiBXaXRoIHRoaXMsIHdoYXQgc2VlbXMgdG8gaGFwcGVu
IGlzIG9kZDogSSBsb2NrIHRoZSBzY3JlZW4sIHdhaXQsIGl0IGdvZXMgIk5vDQo+IHNpZ25hbCwg
c2h1dHRpbmcgZG93biIsIGJ1dCB0aGVuIGRvZXNuJ3QgYWN0dWFsbHkgc2h1dCBkb3duIGJ1dCBz
dGF5cyBibGFjaw0KPiAod2l0aCB0aGUgYmFja2xpZ2h0IG9uKS4gQWZ0ZXIgX2Fub3RoZXJfIGZp
dmUgc2Vjb25kcyBvciBzbywgdGhlIG1vbml0b3IgZ29lcw0KPiAiTm8gc2lnbmFsLCBzaHV0dGlu
ZyBkb3duIiBfYWdhaW5fLCBhbmQgYXQgdGhhdCBwb2ludCBpdCBhY3R1YWxseSBkb2VzIGl0Lg0K
PiANCj4gU28gaXQgc29sdmVzIG15IGltbWVkaWF0ZSBwcm9ibGVtIC0gaW4gdGhhdCB5ZXMsIHRo
ZSBiYWNrbGlnaHQgZmluYWxseSBkb2VzDQo+IHR1cm4gb2ZmIGluIHRoZSBlbmQgLSBidXQgaXQg
ZG9lcyBzZWVtIHRvIGJlIHN0aWxsIGJyb2tlbi4NCj4gDQo+IEknbSB2ZXJ5IHN1cnByaXNlZCBp
ZiBubyBBTUQgZHJtIGRldmVsb3BlcnMgY2FuIHNlZSB0aGlzIGV4YWN0IHNhbWUgdGhpbmcuDQo+
IFRoaXMgaXMgYSB2ZXJ5IHNpbXBsZSBzZXR1cC4gVGhlIG9ubHkgcG9zc2libHkgc2xpZ2h0bHkg
bGVzcyBjb21tb24gdGhpbmcgaXMgdGhhdA0KPiBJIGhhdmUgdHdvIG1vbml0b3JzLCBidXQgd2hp
bGUgdGhhdCBpcyBub3QgbmVjZXNzYXJpbHkgdGhlIF9tb3N0XyBjb21tb24NCj4gc2V0dXAgaW4g
YW4gYWJzb2x1dGUgc2Vuc2UsIEknZCBleHBlY3QgaXQgdG8gYmUgdmVyeSBjb21tb24gYW1vbmcg
RFJNDQo+IGRldmVsb3BlcnMuLg0KPiANCj4gSSBndWVzcyBJIGNhbiBqdXN0IGNoYW5nZSB0aGUg
cmV2ZXJ0IHRvIGp1c3QgYQ0KPiANCj4gICAgIC1pbnQgYW1kZ3B1X3J1bnRpbWVfcG0gPSAtMTsN
Cj4gICAgICtpbnQgYW1kZ3B1X3J1bnRpbWVfcG0gPSAwOw0KPiANCj4gaW5zdGVhZC4gVGhlIGF1
dG8tZGV0ZWN0IGlzIGFwcGFyZW50bHkgYnJva2VuLiBNYXliZSBpdCBzaG91bGQgb25seSBraWNr
IGluDQo+IGZvciBMVkRTIHNjcmVlbnMgb24gYWN0dWFsIGxhcHRvcHM/DQo+IA0KPiBOb3RlOiBv
biBteSBtYWNoaW5lLCBJIGdldCB0aGF0DQo+IA0KPiAgICBhbWRncHUgMDAwMDo0OTowMC4wOiBh
bWRncHU6IFVzaW5nIEJBQ08gZm9yIHJ1bnRpbWUgcG0NCj4gDQo+IHNvIG1heWJlIHRoZSBvdGhl
ciBwb3NzaWJsZSBydW50aW1lIHBtIG1vZGVscyAoQVJQWCBhbmQgQk9DTykgYXJlIG9rLA0KPiBh
bmQgaXQncyBvbmx5IHRoYXQgQkFDTyBjYXNlIHRoYXQgaXMgYnJva2VuLg0KPiANCj4gSSBoYXZl
IG5vIGlkZWEgd2hhdCBhbnkgb2YgdGhvc2UgdGhyZWUgdGhpbmdzIGFyZSAtIEknbSBqdXN0IGxv
b2tpbmcgYXQgdGhlDQo+IHVzZXMgb2YgdGhhdCBhbWRncHVfcnVudGltZV9wbSB2YXJpYWJsZS4N
Cj4gDQo+IGFtZGdwdSBwZW9wbGU6IGlmIHlvdSBkb24ndCB3YW50IHRoYXQgYW1kZ3B1X3J1bnRp
bWVfcG0gdHVybmVkIG9mZiBieQ0KPiBkZWZhdWx0LCB0ZWxsIG1lIHNvbWV0aGluZyBlbHNlIHRv
IHRyeS4NCg0KRm9yIGEgbGl0dGxlIGJhY2tncm91bmQsIHJ1bnRpbWUgUE0gc3VwcG9ydCB3YXMg
YWRkZWQgYWJvdXQgMTAgeWVhciBhZ28gb3JpZ2luYWxseSB0byBzdXBwb3J0IGxhcHRvcHMgd2l0
aCBtdWx0aXBsZSBHUFVzIChpbnRlZ3JhdGVkIGFuZCBkaXNjcmV0ZSkuICBJdCdzIG5vdCBzcGVj
aWZpYyB0byB0aGUgZGlzcGxheSBoYXJkd2FyZS4gIFdoZW4gdGhlIEdQVSBpcyBpZGxlLCBpdCBj
YW4gYmUgcG93ZXJlZCBkb3duIGNvbXBsZXRlbHkuICBJbiB0aGUgY2FzZSBvZiB0aGVzZSBsYXB0
b3BzLCBpdCdzIEQzIGNvbGQgKG1hbmFnZWQgYnkgQUNQSSwgd2UgY2FsbCB0aGlzIEJPQ08gaW4g
QU1EIHBhcmxhbmNlIC0gQnVzIE9mZiwgQ2hpcCBPZmYpIHdoaWNoIHBvd2VycyBvZmYgdGhlIGRH
UFUgY29tcGxldGVseSAoaS5lLiwgaXQgZGlzYXBwZWFycyBmcm9tIHRoZSBidXMpLiAgQSBmZXcg
eWVhcnMgYWdvIHdlIGV4dGVuZGVkIHRoaXMgdG8gc3VwcG9ydCBkZXNrdG9wIGRHUFVzIGFzIHdl
bGwgd2hpY2ggc3VwcG9ydCB0aGVpciBvd24gdmVyc2lvbiBvZiBydW50aW1lIEQzIChjYWxsZWQg
QkFDTyBpbiBBTUQgcGFybGFuY2UgLSBCdXMgQWN0aXZlLCBDaGlwIE9mZikuICBUaGUgZHJpdmVy
IGNhbiBwdXQgdGhlIGNoaXAgaW50byBhIGxvdyBwb3dlciBzdGF0ZSB3aGVyZSBldmVyeXRoaW5n
IGV4Y2VwdCB0aGUgYnVzIGludGVyZmFjZSBpcyBwb3dlcmVkIGRvd24gKHRvIGF2b2lkIHRoZSBk
ZXZpY2UgZGlzYXBwZWFyaW5nIGZyb20gdGhlIGJ1cykuICBTbyB0aGlzIGhhcyB3b3JrZWQgZm9y
IGFsbW9zdCAyIHllYXJzIG5vdyBvbiBCQUNPIGNhcGFibGUgcGFydHMgYW5kIGZvciBhIGRlY2Fk
ZSBvciBtb3JlIG9uIEJPQ08gc3lzdGVtcy4gIFVuZm9ydHVuYXRlbHksIGNoYW5naW5nIHRoZSBk
ZWZhdWx0IHJ1bnBtIHBhcmFtZXRlciBzZXR0aW5nIHdvdWxkIGNhdXNlIGEgZmxvb2Qgb2YgYnVn
IHJlcG9ydHMgYWJvdXQgcnVudGltZSBwb3dlciBtYW5hZ2VtZW50IGJyZWFraW5nIGFuZCBzdWRk
ZW5seSBzeXN0ZW1zIGFyZSB1c2luZyBtb3JlIHBvd2VyLg0KDQpJbXJlJ3MgY29tbWl0ICg1NTI4
NWUyMWYwNDUpIGZpeGVzIGFub3RoZXIgY29tbWl0IChhNmMwZmQzZDVhOGIpLiAgUnVudGltZSBw
bSB3YXMgd29ya2luZyBvbiBhbWRncHUgcHJpb3IgdG8gdGhhdCBjb21taXQuICBJcyBpdCBwb3Nz
aWJsZSB0aGVyZSBpcyBzdGlsbCBzb21lIHJhY2UgYmV0d2VlbiB3aGVuIGFtZGdwdSB0YWtlcyBv
dmVyIGZyb20gZWZpZmI/ICBEb2VzIGl0IHdvcmsgcHJvcGVybHkgd2hlbiBhbGwgcG1fcnVudGlt
ZSBjYWxscyBpbiBlZmlmYiBhcmUgcmVtb3ZlZCBvciBpZiBlZmlmYiBpcyBub3QgZW5hYmxlZD8g
IFJ1bnRpbWUgcG0gZm9yIFBvbGFyaXMgYm9hcmRzIGhhcyBiZWVuIGVuYWJsZWQgYnkgZGVmYXVs
dCBzaW5jZSA0ZmRkYTJlNjZkZTBiIHdoaWNoIHByZWRhdGVzIGJvdGggb2YgdGhvc2UgcGF0Y2hl
cy4NCg0KQWxleA0K
