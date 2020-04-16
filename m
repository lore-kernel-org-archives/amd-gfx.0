Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A5C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 13:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D5D206E9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 13:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iWWhb3Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D5D206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338246E062;
	Thu, 16 Apr 2020 13:25:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839386E049
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 13:25:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gns7eK6evlJOJ6eDQlxxHbmt2P8tzFfh64piHQWCM96HTfvRzDxV+tZxGFs1Evt1Pn7Cpt9lCQ8Bd8cqhI4SX675Dki4jN5Flbjpz4HD8FDI84Q9yb8TwjRxwN7xYDYUv9RGG4tJVelt8B3OEZ3lAEVnlR8VxFx/cktAWykhivjfVMJwmU1KPnIOB6oFvOSbWQnUwXHEubj07OMFVt2A8oLkdsVP4f4lctFyNyy9H4d5kW2j9YVnju/fZ+pdoYlcEcG72yEM6jFLBS8BiHgs2eS2lPSXIM2SbZo/yoW530HajJF1v5e4j+HQgAXK0yvhd3j4sPSKCmdyQCRIujsswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgQJl1zoY0EOObjLC7eJLZYnMOGmN8k6gSSa5dFwZhk=;
 b=ASzCmunFiEUDWZKuDDJ10AT8iWwLD+ORPBRNMJz4HCMdPqinXeweNnCwUUBLLgD8+KtB44ISYy9zZsu2q/cz1Kq20H2tmaluonGp0zkVY5oeIiWm5ksBXKlrX6Z567HSFZ1WfsiBRFh2FBjXD7yvAf3IOujtvuUgWUMYJHZIJX4gPOXee9o0fhDKLaMwbUvjWx7RbRV7pgcDIHS81oNSn5J1ZZHV4LUbHQy9/jfvRO39EDF8GRYt6bm3rJGiexA+e70+j1KaA/SW23q0cepy9vexbV6pfvUD1c3iYE+5ol5eBs/iTaAdjDzycHkEHvY3Hp8rb+FsMv+GeqMih//KMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgQJl1zoY0EOObjLC7eJLZYnMOGmN8k6gSSa5dFwZhk=;
 b=iWWhb3WmHfhLpKu2Xb7pCfgRbwCwz64y1DqvJpC/3BhrEALByaQbUe50vDDJI3HSdprMOSaoMCJJs3btnlDh3224u3KaI6fpu0P6OBhhpnfL0In074n1GMrvY+HqISZn+PhW/BIhzzgaew9GS22PDDodCiwbudUXm0gsa5jdW1I=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 13:25:51 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 13:25:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>, "Gao, Likun"
 <Likun.Gao@amd.com>, =?utf-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pelloux@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: change SH MEM alignment mode for gfx10
Thread-Topic: [PATCH] drm/amdgpu: change SH MEM alignment mode for gfx10
Thread-Index: AQHWCaGSoADBvVh3eUCswFfX+kWgQKh7l2wAgAA6BcA=
Date: Thu, 16 Apr 2020 13:25:50 +0000
Message-ID: <MN2PR12MB44886C87CA46D18FBC5F2F58F7D80@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1585909202-1350-1-git-send-email-likun.gao@amd.com>
 <58b63f21-69e7-abd0-8d49-6699e88d172a@daenzer.net>
In-Reply-To: <58b63f21-69e7-abd0-8d49-6699e88d172a@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-16T13:25:48Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=062be1d6-e111-40f3-b52c-0000a96322ca;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-16T13:25:48Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9890d0c3-4952-4c07-b19b-0000765f1a10
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [172.58.187.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 084eece5-06ec-4083-2884-08d7e209aebd
x-ms-traffictypediagnostic: MN2PR12MB4342:|MN2PR12MB4342:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB434223EC5B3A33FC306CB92DF7D80@MN2PR12MB4342.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(26005)(5660300002)(4326008)(86362001)(186003)(7696005)(52536014)(8676002)(81156014)(8936002)(66574012)(33656002)(71200400001)(54906003)(2906002)(110136005)(66476007)(66946007)(76116006)(64756008)(66556008)(66446008)(478600001)(9686003)(53546011)(6506007)(316002)(55016002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2jNYEG4YK4Szryip13criIFjcCcWQUjlquYN/SWCo3WkmWYHDOADp/TUvQ+IhkQGXZEedhblNncVc0hvTXrL8mNqa4d/JV+nX/Pu9zsB90wXp67DsPiQxRXXuEllMpp+XQCZxIVNHrGx2tuFWkE1wQFfHKLbkPFJeRPPxDsiVQXuI4A3LeI6lYdErxZLQ36fOMRh+xFubYc9L49umtAO4xJKP+HEhaFeBnWvUpaAgR3csofvlEe3GY1MJw+dNMONMLcJrOCm0mkMNFDSKR1343gme9Fqe9s7MuHn+WEjq6U7LHNKC+u4fyde2qbtfQzI+2EsTQDIHTUxSj9bcES5SlRk3ncbSjwxYSUNw2DJPVA/aNl4uW4qHPLW2PLJWLHv5dJY8+4MXuhaqM4ddD8sCsNr5rBVMPflFqCFetplmu4+sQaIPrsME9OCQNOYjsc
x-ms-exchange-antispam-messagedata: B2uBp2b2iPlnORm8S1Rj7OTq6nh38fJdY2qarwswOUrec+x9HFLl+7D6EFOWc5Myqz+I+6Ay56+lmxB1jr2mTw1Tbn0Nmvs5eo0YmQEVb7LXHUr3eu1Wf+ewbSUZqJuEn7IdICnFeyoyyHT8gTf44w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084eece5-06ec-4083-2884-08d7e209aebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 13:25:50.8687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9Jao3eZmkIBOa5nPW7ES5zvg6QKomLXaiL3d5XT/jyY84kwleeu+VsUabe8rHIVdI9MT5Zlwwfj3uWupNVBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBNaWNoZWwgRMOkbnpl
cg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTYsIDIwMjAgNTo1NyBBTQ0KPiBUbzogR2FvLCBM
aWt1biA8TGlrdW4uR2FvQGFtZC5jb20+OyBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21haWwuY29t
PjsNCj4gUGllcnJlLUVyaWMgUGVsbG91eC1QcmF5ZXIgPHBlbGxvdXhAZ21haWwuY29tPg0KPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGNo
YW5nZSBTSCBNRU0gYWxpZ25tZW50IG1vZGUgZm9yDQo+IGdmeDEwDQo+IA0KPiBPbiAyMDIwLTA0
LTAzIDEyOjIwIHAubS4sIExpa3VuIEdhbyB3cm90ZToNCj4gPiBGcm9tOiBMaWt1biBHYW8gPExp
a3VuLkdhb0BhbWQuY29tPg0KPiA+DQo+ID4gQ2hhbmdlIFNIX01FTV9DT05GSUcgQWxpZ25tZW50
IG1vZGUgdG8gQXV0b21hdGljLCBhczoNCj4gPiAxKU9HTCBmbl9hbWRfY29tcHV0ZV9zaGFkZXIg
d2lsbCBmYWlsZWQgd2l0aCB1bmFsaWduZWQgbW9kZS4NCj4gPiAyKVRoZSBkZWZhdWx0IGFsaWdu
bWVudCBtb2RlIHdhcyBkZWZpbmVkIHRvIGF1dG9tYXRpYyBvbiBnZngxMA0KPiA+IHNwZWNpZmlj
YXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMF8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+
ID4gaW5kZXggNWE2NzMwNi4uZDhmMGMwZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92MTBfMC5jDQo+ID4gQEAgLTI3OSw3ICsyNzksNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHNvYzE1X3JlZ19nb2xkZW4NCj4gPiBnb2xkZW5fc2V0dGluZ3NfZ2NfMTBfMV8yX252
MTJbXSA9DQo+ID4NCj4gPiAgI2RlZmluZSBERUZBVUxUX1NIX01FTV9DT05GSUcgXA0KPiA+ICAJ
KChTSF9NRU1fQUREUkVTU19NT0RFXzY0IDw8DQo+IFNIX01FTV9DT05GSUdfX0FERFJFU1NfTU9E
RV9fU0hJRlQpIHwgXA0KPiA+IC0JIChTSF9NRU1fQUxJR05NRU5UX01PREVfVU5BTElHTkVEIDw8
DQo+IFNIX01FTV9DT05GSUdfX0FMSUdOTUVOVF9NT0RFX19TSElGVCkgfCBcDQo+ID4gKwkgKFNI
X01FTV9BTElHTk1FTlRfTU9ERV9EV09SRCA8PA0KPiA+ICtTSF9NRU1fQ09ORklHX19BTElHTk1F
TlRfTU9ERV9fU0hJRlQpIHwgXA0KPiA+ICAJIChTSF9NRU1fUkVUUllfTU9ERV9BTEwgPDwNCj4g
U0hfTUVNX0NPTkZJR19fUkVUUllfTU9ERV9fU0hJRlQpIHwgXA0KPiA+ICAJICgzIDw8IFNIX01F
TV9DT05GSUdfX0lOSVRJQUxfSU5TVF9QUkVGRVRDSF9fU0hJRlQpKQ0KPiA+DQo+ID4NCj4gDQo+
IEkgYmlzZWN0ZWQgYSBidW5jaCBvZiBwaWdsaXQgcmVncmVzc2lvbnMgKG1vc3RseSBoYWxmLWZs
b2F0IHJlbGF0ZWQsIGUuZy4gZHJhdy0NCj4gdmVydGljZXMtaGFsZi1mbG9hdF9nbGVzMikgd2l0
aCByYWRlb25zaSBvbiBOYXZpIDEwIHRvIHRoaXMgY2hhbmdlLg0KPiANCj4gRG9lcyByYWRlb25z
aS9MTFZNIG5lZWQgY29ycmVzcG9uZGluZyBjaGFuZ2VzPw0KDQpUaGlzIGNoYW5nZSB3YXMgcmV2
ZXJ0ZWQuICBUaGUgcHJvYmxlbSB3YXMgaW4gdGhlIE9yY2EgT3BlbkdMIHNoYWRlciBjb21waWxl
ci4NCg0KQWxleA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
