Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16537C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 14:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01A910E530;
	Wed, 19 Jan 2022 14:50:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C5310E530
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 14:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGOoDUnHHsMz+QRCufcMLTROPgcRpXOlZyPKhJgmAgc3OgbLK7KPK8LFGpEbyY+FWMVKOOc//2Q9fGIxRAn8CF1BdLgCXULg1hYHWjcF5DNURapP4skULcO/SKC8Q0F8Ue6duV8nu2T4oioluUMau/zceMG0aPmEHIDz8/v31Y2X8k7QnwLNl+Ogal8LUpuel9GkF+pNnFPxJrg2X5L/1PdBk/4qPGTxWhDZn2vd5u38dsyWlOMhLj9EVWJg32nKU5roYFuGT2FQroNJsRjfzo/C68+6ZHqj15dIs2vk+t4AR5N8/TgncIOBMi5bgUTemlG0qH8W+Pgcp5BqF6pjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woOM1z/24TzXzYRZRUYlFaqE063iSwjorY5Y8q1SzyI=;
 b=a/lVSat37hE/N630MOXEy0Ne+71iW7/BpxxxCya3NFpbLPWqAtdxJatjCy1o9VjBPUtvLU6ij4+tlc+tMThr/pEMICv95Uktay0Y/cTAI6LQdUd2XzAJvYM1BqGUfCYwVBnX3uxSF0mW5ZAFZfREhKGbAncjUgmyaK0P7C0syb6sdwCe8NqJsvKW8482DhId/YE+YSUlfQuhBU/tgCdCn5oBP1pycd73WIbo6u5ExpyWLerxvYtFPXpE4y8unR4ON4HYjibD2HtLyB2vbVhY1EBtFoqJnCACIiKYZ2EyjV/4J2rSdVOC03FLvq7FnH6L8IaMAqw06V7xfAbwPXuqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woOM1z/24TzXzYRZRUYlFaqE063iSwjorY5Y8q1SzyI=;
 b=SeesB+6rVr28r4Oirq6XCkp1fm+UdJsgtvUuvP+WdCPMFO22uALQxYPLnvZBr+5ildDPNoOCx6llqi12HChXfcEgip/t2DyvDtT5NAWVspWc0cWekmpSmD/YQlyrd8SGRcLVTqiHfCAkFqIGCnutlanpzqP9THJ9DTalbohPTrs=
Received: from CY4PR12MB1303.namprd12.prod.outlook.com (2603:10b6:903:40::12)
 by BL0PR12MB2819.namprd12.prod.outlook.com (2603:10b6:208:8a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 14:50:35 +0000
Received: from CY4PR12MB1303.namprd12.prod.outlook.com
 ([fe80::b07b:5bef:d605:6007]) by CY4PR12MB1303.namprd12.prod.outlook.com
 ([fe80::b07b:5bef:d605:6007%9]) with mapi id 15.20.4909.009; Wed, 19 Jan 2022
 14:50:34 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Thread-Topic: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Thread-Index: AQHYDL0fyZH/Oz956ku+GOPqPt3eQqxpbwKAgAAIm0uAAAJpAIAA9A9Q
Date: Wed, 19 Jan 2022 14:50:34 +0000
Message-ID: <CY4PR12MB130369EB0000727C6269A84F85599@CY4PR12MB1303.namprd12.prod.outlook.com>
References: <20220118224513.26563-1-jinhuieric.huang@amd.com>
 <b4572e2d-7898-9740-c1f6-15c22aca12bd@amd.com>
 <DM5PR12MB1308928E28F9CAAB947F9E3585599@DM5PR12MB1308.namprd12.prod.outlook.com>
 <40522d1a-d759-c6c2-96e2-59923573d0ca@amd.com>
In-Reply-To: <40522d1a-d759-c6c2-96e2-59923573d0ca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2844c747-8430-41d0-b646-ddf3c4c9ca41;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T14:49:37Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abbe1b88-6f6e-406d-e1a6-08d9db5b0c80
x-ms-traffictypediagnostic: BL0PR12MB2819:EE_
x-microsoft-antispam-prvs: <BL0PR12MB28198F3FBC7C37B5DC9CB20985599@BL0PR12MB2819.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtrHcnLZtzGCjqJ9SwmJq1FB7VHnLJ9MfLrOb2e+v9STukMiNJ3fjCoCmKMP1Kza2X/C+cWi6T6KYOszgKdGsoJCdg+tR/DbPst3nSIVenTTfiqh127WSSH+svox+ScujexDqMKKpySNgEZlrysHBKIRjcQNta9bwzvMM8uZLVad5HDxF6dJHrhiEAaGqiDqYIXHNGSrBPQFF604oxwT4ylHaYZOYyHBq/K297Ps7qEL0fmpPSZuWS5ZzhIIx+GZu9lvwMnQJoAWnt5NXMD4XahO271+MhA5jdckRZupOuE5g8CjBFUVxgN547IicmyE2GpPZyTLLdgGOhcnka7srzJ+39tf9DFJ2W+iOx90fr1B9vpttmmevpsiVOfQbaXnyKYKofdx5YNvYAGI44T/FzyAdrG+9JvjBvvTPlEsAkZpXbxwMAAgrGBE3z7SivOieMcgXhlEFWrEZcIGOxz78SnOIAL0QSU3xOQvv4qlyvQYuUNldnReOrG0k7CrvVq7YeqFJ69LS+3LyOt+rmaB9ZaUp4eLIBcV4iiYjJKqFsjMVIv39HDT5PXceixghbxWl3mIVLnmho2o77ktCZlf1wYqXH/jBle5wop16ILpYMsyjCiPfmXGo5szoLQrPH0xy0f9JQjs0eS2k3PwXkoY+N4qbggv/Rjr47HZt0eVNbzPbJQTHkTrEnkc+4vXAD+ptmPo225fqxJ9YJFtKMPWrKwBhm1ySEDeZhc5+sYro2E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1303.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(9686003)(86362001)(38070700005)(33656002)(66476007)(8936002)(66446008)(66556008)(64756008)(7696005)(38100700002)(122000001)(2906002)(8676002)(186003)(508600001)(26005)(71200400001)(76116006)(55016003)(110136005)(83380400001)(316002)(40140700001)(5660300002)(6506007)(53546011)(52536014)(16393002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckdmNWhJN0oyTTFEUCtubmxPMlp4Y1I0QXhLTkJkTE1TRDRnVFMrWXV3M0Fr?=
 =?utf-8?B?NFdLdmpjTFdFTGt1ZjdtbTRGZTBWQXptUUZ1TlhDUnBUSUVsWjJla3g0SHBU?=
 =?utf-8?B?SGJ2WTA1bG5PYTFSMHAxRjFVdlBHN0VtT2Q5bXBhV2pTMUcvMUVoTWtMazVZ?=
 =?utf-8?B?VUJlTUxDMXIrZ1N1ZTl3d08vOGt5TS9PcHI3SVpucXh6L3VBWGZBRWwzRG8x?=
 =?utf-8?B?KzNqTGE0dUNuQXdZTjNlOGJCQWlxS3ZDMCtmVUd3TWFaL3VFTFFTdnlWWDhR?=
 =?utf-8?B?VUk0Ym9pVlMzeDVPZEVnNDJqakZUcSttUjQrZ0taWjdjMnFwUTYySVR3bHA4?=
 =?utf-8?B?N2FsdW4vbnhTTDU4OWdYakgydHNIOHNTTmdsSXFjYUd2MC9yZ0RibG1IM3JF?=
 =?utf-8?B?MUxKU3dkY0VIRjJLSU9LYjJYSGw4dWVySGlrRUpmWFJMTWU1Q09TQjBIT01O?=
 =?utf-8?B?eTF5eldJcXRoa2xtOHBreTd0dzFkSVV3ZTJGSkNzT3ZwaUlhdEtrK29LNHgz?=
 =?utf-8?B?aVVHazh5NHpKeDNnUFNvY1FKekFkRVBoNWZtdjFVY2hoTWU5bHFkSlE1d0xI?=
 =?utf-8?B?K1NtZ0NOdktKUXBaek0zQ3JYY0M0dUt5Qm1vc3AzekErdlRsNWxNTHkwUzFp?=
 =?utf-8?B?S01vYkQvN3FRRjh5bjJmZHczcmpLZDhCRGI2N1J3SUIxMjUvdUxNKzk0S1Vh?=
 =?utf-8?B?MjNqTkNCN3h5NXlLZmExUGJzNXhnUlJqTkh3SFREODA0T3VBTENHOFlCOUNB?=
 =?utf-8?B?aXRjOEQzU3N0Yjk5ZzNNaGF4NEQwUjJPcHhOLzJzOWg3WFVhcC9lOVBkOHRr?=
 =?utf-8?B?TUp2TTFNVDJheUxZOVFLYlA4YlFPMURWTUZUWWxQYzhpWDhxY1ZQc2w4ZzI0?=
 =?utf-8?B?WVhlZ0JIRFVndUtKSFNFZ3U5Q05BWnk5UTljR25tMUFjbWlnckd0TWZyQkFi?=
 =?utf-8?B?R2k3UHpSZC9MM0VNdGxXQmlTQ1N0dDhkOE1MQTdQTlFXRCsxRDlSNGxxZVE5?=
 =?utf-8?B?cEJFZUNXa0NuSkZneVVLcVFqT2FsdGFYUGVPN2puYVFNbTJVbFpLd0pxU21i?=
 =?utf-8?B?WmNWNllJaUFvL2lnVkZPMm1GQk93L3pKbW5naUJMYkQ1VlNIUWFwUG8rV2k3?=
 =?utf-8?B?MlcxNHdzVEo2NE1FMFBDTDFHTVlKWlNNRVBTNTkwTUVrQzZoZzNwWExSMDcz?=
 =?utf-8?B?Nm1yb0IxYWlaWW9QM1UrTGU2SWJhZkhQTVo0U0hrOTBGSjQ0dVduYVVac3Jo?=
 =?utf-8?B?OUcwbmtNNGJUTEx6REloUlRLU0xrWVZPKzcrTW1sY2tKdytGRVYwS25LQXZQ?=
 =?utf-8?B?S2JEUFladE1aQ3Z0eWRrYnNEMVpKZzhsTVFOcUU4NVgxTmVkQ2p3STlsczFu?=
 =?utf-8?B?Yi9uTUwxQkpVQ0pHZkpTWE1Oa1BPditaODNsSGlQdCtBUkROZFZWUXRkTmNL?=
 =?utf-8?B?eDEycjRnQ1ZpbDBQRTBKSEk3by9iR0pCTS9ybk1YQ1ZZenV5UTZtVSttOHhQ?=
 =?utf-8?B?amZqdGsreDE3MWpGcHI1UUl3bk9qc1dnWFN3ejdBVXhSZ0xFV1RFallSdGpE?=
 =?utf-8?B?aThKYXlUdmFvWHdmNkFuY0ZhSHRLY2tYcFJHeC9zam5JQTdzY3Y3Z3o3UEEz?=
 =?utf-8?B?RnlicHJNRlpjQ2ErRDd5K3QxeElJOWs4WWhSbStMREFsTUI3NnNIRHkxd0ZD?=
 =?utf-8?B?UlRDZEdJQVJCajRvd0ZlUi9VVlpYS09aVUhZL3Q0ZXIwTnNrU3VqcFgyaXFn?=
 =?utf-8?B?UlZ0YTFZbnVVaXc3eE1pRkJRUnBnUTBsUWgwcW50WDFMZWtnTzNnTFF6ZSti?=
 =?utf-8?B?Smh2K1FoUWNzTWdrWGt0eUtZN0k1MGVJdXlnYjV6K2M2QnlQQ3E2Z2NxSzE3?=
 =?utf-8?B?Z3pYS3llWVBlYmJReGkwcTY4Y0VnTkd2NFh1ZjJ2NFZDRkpLOXo5SGJIMk1R?=
 =?utf-8?B?NmJqTkNudDFZWDBEU09mZG1nVEN0STFmVTBVR2N0cmxQZFpINmJxYWZPQksw?=
 =?utf-8?B?Tkp0V1Z5aVlqY2NITTVyTzFHTzRMZDByTGlmenhzb0g3NUVQUDgzb05JZUYx?=
 =?utf-8?B?dnN0NE5HQUtZSzF2NWJxQWZaSk5OU3hvK25XQnZXdk0rTStFb1hTWkN6Q1ZY?=
 =?utf-8?B?d1UyODIxeGs0d01RTExsanpLSjZtY1dMNDVOL1p4UUYyenVYUG9PcE5VNndX?=
 =?utf-8?Q?bayie+NqgZayFnRtVtfXFok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1303.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbe1b88-6f6e-406d-e1a6-08d9db5b0c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 14:50:34.5728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHk7Hsokqw1bMUpSTN55h/VQnAFt/cxK7bCvAj3G+mYLCZebrHJVUOKo2a3lKnncugdhUBEd4QQxmFoqfIlSkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2819
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIEphbnVhcnkgMTgsIDIwMjIgNzoxNiBQTQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8
S2VudC5SdXNzZWxsQGFtZC5jb20+OyBIdWFuZywgSmluSHVpRXJpYw0KPiA8SmluSHVpRXJpYy5I
dWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZW5hYmxlIGhlYXZ5LXdlaWdodCBUTEIgZmx1c2ggb24g
QXJjdHVydXMNCj4NCj4gQW0gMjAyMi0wMS0xOCB1bSA3OjA4IHAubS4gc2NocmllYiBSdXNzZWxs
LCBLZW50Og0KPiA+IE9uZSBxdWVzdGlvbiBpbmxpbmUNCj4gPg0KPiA+DQo+ID4gKktFTlQgUlVT
U0VMTCoqKg0KPiA+DQo+ID4gU3IuIFNvZnR3YXJlIEVuZ2luZWVyIHwgTGludXggQ29tcHV0ZSBL
ZXJuZWwNCj4gPg0KPiA+IDEgQ29tbWVyY2UgVmFsbGV5IERyaXZlIEVhc3QNCj4gPg0KPiA+IE1h
cmtoYW0sIE9OIEwzVCA3WDYNCj4gPg0KPiA+ICpPKisoMSkgMjg5LTY5NS0yMTIyKip8IEV4dCA3
MjEyMg0KPiA+DQo+ID4NCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAqRnJvbToqIGFtZC1nZngg
PGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IG9uIGJlaGFsZiBvZg0KPiA+
IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPg0KPiA+ICpTZW50OiogVHVl
c2RheSwgSmFudWFyeSAxOCwgMjAyMiA2OjM2IFBNDQo+ID4gKlRvOiogSHVhbmcsIEppbkh1aUVy
aWMgPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNvbT47DQo+ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KPiA+ICpTdWJqZWN0Oiog
UmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZW5hYmxlIGhlYXZ5LXdlaWdodCBUTEIgZmx1c2ggb24N
Cj4gPiBBcmN0dXJ1cw0KPiA+DQo+ID4gQW0gMjAyMi0wMS0xOCB1bSA1OjQ1IHAubS4gc2Nocmll
YiBFcmljIEh1YW5nOg0KPiA+ID4gU0RNQSBGVyBmaXhlcyB0aGUgaGFuZyBpc3N1ZSBmb3IgYWRk
aW5nIGhlYXZ5LXdlaWdodCBUTEINCj4gPiA+IGZsdXNoIG9uIEFyY3R1cnVzLCBzbyB3ZSBjYW4g
ZW5hYmxlIGl0Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1
aWVyaWMuaHVhbmdAYW1kLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGlu
ZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gPg0KPiA+DQo+ID4gPiAtLS0NCj4gPiA+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCAgNiAtLS0t
LS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jICAgICAg
ICAgfCAxMCArKysrKysrKy0tDQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gPiBpbmRleCBhNjRjYmJk
OTQzYmEuLmFjYjRmZDk3M2U2MCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4gPiBAQCAtMTg5MiwxMiAr
MTg5Miw2IEBAIGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX21hcF9tZW1vcnlfdG9fZ3B1KA0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRydWUpOw0KPiA+ID4gICAgICAgIHJl
dCA9IHVucmVzZXJ2ZV9ib19hbmRfdm1zKCZjdHgsIGZhbHNlLCBmYWxzZSk7DQo+ID4gPg0KPiA+
ID4gLSAgICAgLyogT25seSBhcHBseSBubyBUTEIgZmx1c2ggb24gQWxkZWJhcmFuIHRvDQo+ID4g
PiAtICAgICAgKiB3b3JrYXJvdW5kIHJlZ3Jlc3Npb25zIG9uIG90aGVyIEFzaWNzLg0KPiA+ID4g
LSAgICAgICovDQo+ID4gPiAtICAgICBpZiAodGFibGVfZnJlZWQgJiYgKGFkZXYtPmFzaWNfdHlw
ZSAhPSBDSElQX0FMREVCQVJBTikpDQo+ID4gPiAtICAgICAgICAgICAgICp0YWJsZV9mcmVlZCA9
IHRydWU7DQo+ID4gPiAtDQo+ID4gPiAgICAgICAgZ290byBvdXQ7DQo+ID4gPg0KPiA+ID4gIG91
dF91bnJlc2VydmU6DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2NoYXJkZXYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2No
YXJkZXYuYw0KPiA+ID4gaW5kZXggYjU3MGMwNDU0Y2U5Li40ODVkNGM1MmM3ZGUgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4gPiBA
QCAtMTU5Niw2ICsxNTk2LDEyIEBAIHN0YXRpYyBpbnQNCj4gPiBrZmRfaW9jdGxfZnJlZV9tZW1v
cnlfb2ZfZ3B1KHN0cnVjdCBmaWxlICpmaWxlcCwNCj4gPiA+ICAgICAgICByZXR1cm4gcmV0Ow0K
PiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArc3RhdGljIGJvb2wga2ZkX2ZsdXNoX3RsYl9hZnRlcl91
bm1hcChzdHJ1Y3Qga2ZkX2RldiAqZGV2KSB7DQo+ID4gPiArICAgICByZXR1cm4gS0ZEX0dDX1ZF
UlNJT04oZGV2KSA9PSBJUF9WRVJTSU9OKDksIDQsIDIpDQo+ID4NCj4gPiBEbyB3ZSBuZWVkIHRv
IGFkZCBhIGNoZWNrIGZvciBzZG1hIHZlciA+PTggaGVyZT8NCj4NCj4gV2hhdCdzIHRoZSBzaWdu
aWZpY2FuY2Ugb2YgdmVyc2lvbiA4IGZvciBBbGRlYmFyYW4/IFRoaXMgY29kZSB3YXMNCj4gd29y
a2luZyBvbiBBbGRlYmFyYW4gd2l0aG91dCBhIHZlcnNpb24gY2hlY2sgYmVmb3JlLiBEaWQgd2Ug
ZXZlcg0KPiBwdWJsaWNseSByZWxlYXNlIGFuIFNETUEgZmlybXdhcmUgb2xkZXIgdGhhbiB2ZXJz
aW9uIDggdGhhdCBmb3IgQWxkZWJhcmFuPw0KDQpXZSByZWxlYXNlZCB2NSBmb3IgQWxkZWJhcmFu
IFNETUEgaW4gUk9DbSA0LjUgLiBJZiBJIHJlbWVtYmVyIHRoZSB0aWNrZXQgY29ycmVjdGx5LCB0
aGUgc2FtZSBmaXggZm9yIEFyY3R1cnVzIHdhcyByZXF1aXJlZCBmb3IgQWxkZWJhcmFuIGFuZCB3
YXMgcGFydCBvZiBTRE1BIHY4LiBCdXQgRXJpYyBpcyBvYnZpb3VzbHkgd2F0Y2hpbmcgdGhlIHRp
Y2tldCBtb3JlIGNsb3NlbHkgdGhhbiBJLCBzbyBJJ2xsIGRlZmVyIHRvIGhpbSB0aGVyZS4NCg0K
IEtlbnQNCg0KPg0KPiBSZWdhcmRzLA0KPiAgIEZlbGl4DQo+DQo+DQo+ID4NCj4gPiB8fA0KPiA+
ID4gKyAgICAgICAgICAgIChLRkRfR0NfVkVSU0lPTihkZXYpID09IElQX1ZFUlNJT04oOSwgNCwg
MSkgJiYNCj4gPiA+ICsgICAgICAgICAgICAgZGV2LT5hZGV2LT5zZG1hLmluc3RhbmNlWzBdLmZ3
X3ZlcnNpb24gPj0gMTgpOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMgaW50IGtm
ZF9pb2N0bF9tYXBfbWVtb3J5X3RvX2dwdShzdHJ1Y3QgZmlsZSAqZmlsZXAsDQo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAs
IHZvaWQNCj4gPiAqZGF0YSkNCj4gPiA+ICB7DQo+ID4gPiBAQCAtMTY5Miw3ICsxNjk4LDcgQEAg
c3RhdGljIGludCBrZmRfaW9jdGxfbWFwX21lbW9yeV90b19ncHUoc3RydWN0DQo+ID4gZmlsZSAq
ZmlsZXAsDQo+ID4gPiAgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICAgICAgICAvKiBGbHVzaCBUTEJz
IGFmdGVyIHdhaXRpbmcgZm9yIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZXMgdG8NCj4gPiBjb21wbGV0
ZSAqLw0KPiA+ID4gLSAgICAgaWYgKHRhYmxlX2ZyZWVkKSB7DQo+ID4gPiArICAgICBpZiAodGFi
bGVfZnJlZWQgfHwgIWtmZF9mbHVzaF90bGJfYWZ0ZXJfdW5tYXAoZGV2KSkgew0KPiA+ID4gICAg
ICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGFyZ3MtPm5fZGV2aWNlczsgaSsrKSB7DQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgIHBlZXIgPSBrZmRfZGV2aWNlX2J5X2lkKGRldmljZXNf
YXJyW2ldKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKFdBUk5fT05fT05DRSgh
cGVlcikpDQo+ID4gPiBAQCAtMTgwNiw3ICsxODEyLDcgQEAgc3RhdGljIGludA0KPiA+IGtmZF9p
b2N0bF91bm1hcF9tZW1vcnlfZnJvbV9ncHUoc3RydWN0IGZpbGUgKmZpbGVwLA0KPiA+ID4gICAg
ICAgIH0NCj4gPiA+ICAgICAgICBtdXRleF91bmxvY2soJnAtPm11dGV4KTsNCj4gPiA+DQo+ID4g
PiAtICAgICBpZiAoS0ZEX0dDX1ZFUlNJT04oZGV2KSA9PSBJUF9WRVJTSU9OKDksIDQsIDIpKSB7
DQo+ID4gPiArICAgICBpZiAoa2ZkX2ZsdXNoX3RsYl9hZnRlcl91bm1hcChkZXYpKSB7DQo+ID4g
PiAgICAgICAgICAgICAgICBlcnIgPSBhbWRncHVfYW1ka2ZkX2dwdXZtX3N5bmNfbWVtb3J5KGRl
di0+YWRldiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3RydWN0IGtn
ZF9tZW0gKikgbWVtLCB0cnVlKTsNCj4gPiA+ICAgICAgICAgICAgICAgIGlmIChlcnIpIHsNCg==
