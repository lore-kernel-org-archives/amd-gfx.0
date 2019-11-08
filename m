Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF2FA372C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 09:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BCD218AE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 09:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BCD218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE7C6F8EA;
	Fri,  8 Nov 2019 09:39:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA94F6F8EA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 09:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHn2K0suqFvlCq2sHLBiQQDk8LlPQzN1X0USHDd1/yJVE4b2hNB05v6WP7noj4cFBvU5ltQ16WksFWm2c4Hf1QcMU0tdCBskMLYhicEsrlFIae82/EGzMMIk5oSAgHO5w1zybJ1/00hSmTr27zFAK5NXASprP+JO3MvkH1J5Ib6kxk1sk462eYuvs8TJkmn8BYlZuMCePYrWjjxGu2x69ICgE5gKOCYsCvxhPBPMk3eKCxWG2HQvdsJx75L2Gvzosh0/p4VZ1h01XrwKrrvSlCutT9KYP5gxOHW8MozpLFRpjhjqR1juGfmscVnBtgS+7CQZ54Hf/FG5QiToSl336w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlO5mhoGf3KnKVPFTVqVkDOpLDm7yL9Y58GIB4xQRvI=;
 b=QSpn1jr9EkVycQ1ctryT0Tzu4sws77ga1DC5TK1S/3j0UD91NUtaau22FSJ+eBi/o0PlNZr+oLz/dERBHXxuQLxsTkLu/bjDzn63GgZdhPPOZ9lw6MBiAtJ7PeeBNK1qcFpxqClQUmobdwUWqHQi0eoLzZ3Rwo/Z3jhGgWxqJ7fTZu/OLdvPsyWLthRlPQm2CPy5Tl/mMeekyBs8QXQ7LNQY/jUz9jpmomuYhE4sUYSnY1xSwSQGzOvPxrHp3kGR72BPCDWn5/3B95rCymB90ViVrbCRvJh/OmXcd4KTlb1kDoojzye/LbPbTa2fKOCAaBFvan1dQli3gEsUMlMRjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3246.namprd12.prod.outlook.com (20.179.81.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Fri, 8 Nov 2019 09:39:54 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7%7]) with mapi id 15.20.2408.028; Fri, 8 Nov 2019
 09:39:54 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Topic: [PATCH] drm/amdgpu: Fix the null pointer issue for tdr
Thread-Index: AQHVlVW9lxWirD8xeEyV09j5nQhNc6d/kjUAgAD+17CAAGgEQIAABCMAgAAI80A=
Date: Fri, 8 Nov 2019 09:39:53 +0000
Message-ID:
 <MN2PR12MB29755CFCE09CEC0D9EB999D18F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1573122349-22080-1-git-send-email-Emily.Deng@amd.com>
 <9de32e5b-69a2-f43f-629f-fef3c30bf5a1@gmail.com>
 <MN2PR12MB2975D4E26CED960B82305F308F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <MN2PR12MB2975E26D8A8352863BA01FCA8F7B0@MN2PR12MB2975.namprd12.prod.outlook.com>
 <c01acb29-72ce-a109-3ca5-166706327d61@amd.com>
In-Reply-To: <c01acb29-72ce-a109-3ca5-166706327d61@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec4a7c3b-d93a-4ccd-9b00-08d7642f9c09
x-ms-traffictypediagnostic: MN2PR12MB3246:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3246882C508675D485F509928F7B0@MN2PR12MB3246.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(13464003)(199004)(189003)(14454004)(478600001)(25786009)(305945005)(966005)(74316002)(7736002)(6306002)(81166006)(81156014)(8676002)(86362001)(2906002)(229853002)(9686003)(2501003)(8936002)(6436002)(6246003)(110136005)(316002)(71190400001)(66946007)(76116006)(53546011)(102836004)(52536014)(99286004)(33656002)(5660300002)(55016002)(66574012)(256004)(14444005)(76176011)(66066001)(446003)(11346002)(476003)(3846002)(71200400001)(64756008)(66476007)(486006)(6506007)(6116002)(66446008)(66556008)(26005)(186003)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3246;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ki0vGmehzAMlB+m8TcRFcyTiUXju90dMgR8Kc8y1Be5xDcOv4S9WxEnxMpCsA3bunnF/8C/o0z0wKnI4Bw2CeNar9sL0QJCYU+HAB0IT8fds/A0Ja31WMuU0onGgqUXP9wnexYNuOe93Mm9bwreKFMCS2OUpodMEVSGBijlikdlKB4m4Up3KfeGmt14eG5WTi3ZWy+OVLwrd2emQXIkVX46IAn+S0lnlV2yESs91mPsN1J2TWnFKzX9hpZ2Muq4aPimqS19rfWIv5ZJSWvLwM8ltVuWRR2sJ5YHKUxcHNBvyHpXehBAAKzJcx+IUPfZ3Y/rM9AdJKb9/BNz5I5/V3F+Et1MFSo2UXED+SMDWM0IbqSp1aYpN6khDWnNlr0pjWlvICHmQEsqBnel24hPFhWCvRDLwZ+CFf6l0G/c/vPXH/1KUHbN7eowJRnRivq8xawPT+OmcXs4weDxMEocBUC2FqCVsGKlwZFRir4LwoWo=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4a7c3b-d93a-4ccd-9b00-08d7642f9c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 09:39:53.9570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92vLU02/p05+NRom45BfihbUabajsydRToWju5VO9f6Iq+8iiKgL7olRIsGon0RW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3246
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlO5mhoGf3KnKVPFTVqVkDOpLDm7yL9Y58GIB4xQRvI=;
 b=pPwR+beCxw6XB+i/lmduGfYveNZ38HUbzRYoXS7v6z2uqs1O1PXPJHoqifbcs3reTNampnAzrYXDcQWoGbdVOGTrLldwASjFLd8VBM/FG1w65Nnm/aPxZ+ECmlFbpbP1AbTTmTP2+SBssALRDo++Aju3DJUJ5n3217eC7Wj1mts=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108093953.4ivI1v8kuY242TxuxWQKQM-3pbELsWQuILYB5L5moKs@z>

U29ycnksIHBsZWFzZSB0YWtlIHlvdXIgdGltZS4NCg0KQmVzdCB3aXNoZXMNCkVtaWx5IERlbmcN
Cg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+U2VudDogRnJpZGF5LCBOb3ZlbWJlciA4
LCAyMDE5IDU6MDggUE0NCj5UbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2Ft
ZGdwdTogRml4IHRoZSBudWxsIHBvaW50ZXIgaXNzdWUgZm9yIHRkcg0KPg0KPkFtIDA4LjExLjE5
IHVtIDA5OjUyIHNjaHJpZWIgRGVuZywgRW1pbHk6DQo+PiBQaW5nLi4uLi4NCj4NCj5Zb3UgbmVl
ZCB0byBnaXZlIG1lIGF0IGxlYXN0IGVub3VnaCB0aW1lIHRvIHdha2UgdXAgOikNCj4NCj4+DQo+
Pg0KPj4gQmVzdCB3aXNoZXMNCj4+IEVtaWx5IERlbmcNCj4+DQo+Pg0KPj4NCj4+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPj4+IERlbmcsIEVtaWx5DQo+Pj4g
U2VudDogRnJpZGF5LCBOb3ZlbWJlciA4LCAyMDE5IDEwOjU2IEFNDQo+Pj4gVG86IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQtDQo+Pj4gZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPj4+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZp
eCB0aGUgbnVsbCBwb2ludGVyIGlzc3VlIGZvciB0ZHINCj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPj4+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNo
dHp1bWVya2VuQGdtYWlsLmNvbT4NCj4+Pj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDcsIDIw
MTkgNzoyOCBQTQ0KPj4+PiBUbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9hbWRncHU6IEZpeCB0aGUgbnVsbCBwb2ludGVyIGlzc3VlIGZvciB0ZHINCj4+Pj4NCj4+Pj4g
QW0gMDcuMTEuMTkgdW0gMTE6MjUgc2NocmllYiBFbWlseSBEZW5nOg0KPj4+Pj4gV2hlbiB0aGUg
am9iIGlzIGFscmVhZHkgc2lnbmFsZWQsIHRoZSBzX2ZlbmNlIGlzIGZyZWVkLiBUaGVuIGl0DQo+
Pj4+PiB3aWxsIGhhcyBudWxsIHBvaW50ZXIgaW4gYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlci4N
Cj4+Pj4gTkFLLCB0aGUgc19mZW5jZSBpcyBvbmx5IHNldCB0byBOVUxMIHdoZW4gdGhlIGpvYiBp
cyBkZXN0cm95ZWQuIFNlZQ0KPj4+PiBkcm1fc2NoZWRfam9iX2NsZWFudXAoKS4NCj4+PiBJIGtu
b3cgaXQgaXMgc2V0IHRvIE5VTEwgaW4gZHJtX3NjaGVkX2pvYl9jbGVhbnVwLiBCdXQgaW4gb25l
IGNhc2UsDQo+Pj4gd2hlbiBpdCBlbnRlciBpbnRvIHRoZSBhbWRncHVfZGV2aWNlX2dwdV9yZWNv
dmVyLCBpdCBhbHJlYWR5IGluDQo+Pj4gZHJtX3NjaGVkX2pvYl9jbGVhbnVwLCBhbmQgYXQgdGhp
cyB0aW1lLCBpdCB3aWxsIGdvIHRvIGZyZWUgam9iLiBCdXQNCj4+PiB0aGUgYW1kZ3B1X2Rldmlj
ZV9ncHVfcmVjb3ZlciBzb21ldGltZXMgaXMgZmFzdGVyLiBBdCB0aGF0IHRpbWUsIGpvYg0KPj4+
IGlzIG5vdCBmcmVlZCwgYnV0IHNfZmVuY2UgaXMgYWxyZWFkeSBOVUxMLg0KPg0KPk5vLCB0aGF0
IGNhc2UgY2FuJ3QgaGFwcGVuLiBTZWUgaGVyZToNCj4NCj4+IMKgwqDCoMKgwqDCoMKgIGRybV9z
Y2hlZF9qb2JfY2xlYW51cChzX2pvYik7DQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3Jp
bmdfcHJpb3JpdHlfcHV0KHJpbmcsIHNfam9iLT5zX3ByaW9yaXR5KTsNCj4+IMKgwqDCoMKgwqDC
oMKgIGRtYV9mZW5jZV9wdXQoam9iLT5mZW5jZSk7DQo+PiDCoMKgwqDCoMKgwqDCoCBhbWRncHVf
c3luY19mcmVlKCZqb2ItPnN5bmMpOw0KPj4gwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3N5bmNfZnJl
ZSgmam9iLT5zY2hlZF9zeW5jKTsNCj4+IMKgwqDCoMKgwqDCoMKgIGtmcmVlKGpvYik7DQo+DQo+
VGhlIGpvYiBpdHNlbGYgaXMgZnJlZWQgdXAgZGlyZWN0bHkgYWZ0ZXIgZnJlZWluZyB0aGUgcmVm
ZXJlbmNlIHRvIHRoZSBzX2ZlbmNlLg0KPg0KPlNvIHlvdSBhcmUganVzdCBwYXBlcmluZyBvdmVy
IGEgbXVjaCBiaWdnZXIgcHJvYmxlbSBoZXJlLiBUaGlzIHBhdGNoIGlzIGENCj5jbGVhciBOQUsu
DQo+DQo+UmVnYXJkcywNCj5DaHJpc3RpYW4uDQo+DQo+Pj4+IFdoZW4geW91IHNlZSBhIGpvYiB3
aXRob3V0IGFuIHNfZmVuY2UgdGhlbiB0aGF0IG1lYW5zIHRoZSBwcm9ibGVtIGlzDQo+Pj4+IHNv
bWV3aGVyZSBlbHNlLg0KPj4+Pg0KPj4+PiBSZWdhcmRzLA0KPj4+PiBDaHJpc3RpYW4uDQo+Pj4+
DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbWlseSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+DQo+
Pj4+PiAtLS0NCj4+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyB8ICAyICstDQo+Pj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21h
aW4uYyAgICAgfCAxMSArKysrKystLS0tLQ0KPj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPj4+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4+Pj4+IGluZGV4IGU2Y2U5NDku
LjVhOGYwOGUgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYw0KPj4+Pj4gQEAgLTQwNzUsNyArNDA3NSw3IEBAIGludCBhbWRncHVfZGV2
aWNlX2dwdV9yZWNvdmVyKHN0cnVjdA0KPj4+PiBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4+Pj4g
ICAgCSAqDQo+Pj4+PiAgICAJICogam9iLT5iYXNlIGhvbGRzIGEgcmVmZXJlbmNlIHRvIHBhcmVu
dCBmZW5jZQ0KPj4+Pj4gICAgCSAqLw0KPj4+Pj4gLQlpZiAoam9iICYmIGpvYi0+YmFzZS5zX2Zl
bmNlLT5wYXJlbnQgJiYNCj4+Pj4+ICsJaWYgKGpvYiAmJiBqb2ItPmJhc2Uuc19mZW5jZSAmJiBq
b2ItPmJhc2Uuc19mZW5jZS0+cGFyZW50ICYmDQo+Pj4+PiAgICAJICAgIGRtYV9mZW5jZV9pc19z
aWduYWxlZChqb2ItPmJhc2Uuc19mZW5jZS0+cGFyZW50KSkNCj4+Pj4+ICAgIAkJam9iX3NpZ25h
bGVkID0gdHJ1ZTsNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9tYWluLmMNCj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9tYWluLmMNCj4+Pj4+IGluZGV4IDMxODA5Y2EuLjU2Y2MxMGUgMTAwNjQ0DQo+Pj4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYw0KPj4+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4+Pj4+IEBAIC0zMzQsOCAr
MzM0LDggQEAgdm9pZCBkcm1fc2NoZWRfaW5jcmVhc2Vfa2FybWEoc3RydWN0DQo+Pj4+IGRybV9z
Y2hlZF9qb2INCj4+Pj4+ICpiYWQpDQo+Pj4+Pg0KPj4+Pj4gICAgCQkJc3Bpbl9sb2NrKCZycS0+
bG9jayk7DQo+Pj4+PiAgICAJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZW50aXR5LCB0bXAs
ICZycS0+ZW50aXRpZXMsDQo+Pj4+IGxpc3QpIHsNCj4+Pj4+IC0JCQkJaWYgKGJhZC0+c19mZW5j
ZS0+c2NoZWR1bGVkLmNvbnRleHQgPT0NCj4+Pj4+IC0JCQkJICAgIGVudGl0eS0+ZmVuY2VfY29u
dGV4dCkgew0KPj4+Pj4gKwkJCQlpZiAoYmFkLT5zX2ZlbmNlICYmIChiYWQtPnNfZmVuY2UtDQo+
Pj4+PiBzY2hlZHVsZWQuY29udGV4dCA9PQ0KPj4+Pj4gKwkJCQkgICAgZW50aXR5LT5mZW5jZV9j
b250ZXh0KSkgew0KPj4+Pj4gICAgCQkJCQlpZiAoYXRvbWljX3JlYWQoJmJhZC0+a2FybWEpID4N
Cj4+Pj4+ICAgIAkJCQkJICAgIGJhZC0+c2NoZWQtPmhhbmdfbGltaXQpDQo+Pj4+PiAgICAJCQkJ
CQlpZiAoZW50aXR5LT5ndWlsdHkpDQo+Pj4+PiBAQCAtMzc2LDcgKzM3Niw3IEBAIHZvaWQgZHJt
X3NjaGVkX3N0b3Aoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyDQo+Pj4+ICpzY2hlZCwgc3RydWN0
IGRybV9zY2hlZF9qb2IgKmJhZCkNCj4+Pj4+ICAgIAkgKiBUaGlzIGl0ZXJhdGlvbiBpcyB0aHJl
YWQgc2FmZSBhcyBzY2hlZCB0aHJlYWQgaXMgc3RvcHBlZC4NCj4+Pj4+ICAgIAkgKi8NCj4+Pj4+
ICAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmVfcmV2ZXJzZShzX2pvYiwgdG1wLCAmc2NoZWQt
DQo+Pj4+PiByaW5nX21pcnJvcl9saXN0LCBub2RlKSB7DQo+Pj4+PiAtCQlpZiAoc19qb2ItPnNf
ZmVuY2UtPnBhcmVudCAmJg0KPj4+Pj4gKwkJaWYgKHNfam9iLT5zX2ZlbmNlICYmIHNfam9iLT5z
X2ZlbmNlLT5wYXJlbnQgJiYNCj4+Pj4+ICAgIAkJICAgIGRtYV9mZW5jZV9yZW1vdmVfY2FsbGJh
Y2soc19qb2ItPnNfZmVuY2UtPnBhcmVudCwNCj4+Pj4+ICAgIAkJCQkJICAgICAgJnNfam9iLT5j
YikpIHsNCj4+Pj4+ICAgIAkJCWF0b21pY19kZWMoJnNjaGVkLT5od19ycV9jb3VudCk7IEBAIC0z
OTUsNw0KPj4+ICszOTUsOCBAQCB2b2lkDQo+Pj4+PiBkcm1fc2NoZWRfc3RvcChzdHJ1Y3QgZHJt
X2dwdV9zY2hlZHVsZXINCj4+Pj4gKnNjaGVkLCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqYmFkKQ0K
Pj4+Pj4gICAgCQkJICoNCj4+Pj4+ICAgIAkJCSAqIEpvYiBpcyBzdGlsbCBhbGl2ZSBzbyBmZW5j
ZSByZWZjb3VudCBhdCBsZWFzdCAxDQo+Pj4+PiAgICAJCQkgKi8NCj4+Pj4+IC0JCQlkbWFfZmVu
Y2Vfd2FpdCgmc19qb2ItPnNfZmVuY2UtPmZpbmlzaGVkLCBmYWxzZSk7DQo+Pj4+PiArCQkJaWYg
KHNfam9iLT5zX2ZlbmNlKQ0KPj4+Pj4gKwkJCQlkbWFfZmVuY2Vfd2FpdCgmc19qb2ItPnNfZmVu
Y2UtPmZpbmlzaGVkLA0KPj4+PiBmYWxzZSk7DQo+Pj4+PiAgICAJCQkvKg0KPj4+Pj4gICAgCQkJ
ICogV2UgbXVzdCBrZWVwIGJhZCBqb2IgYWxpdmUgZm9yIGxhdGVyIHVzZSBkdXJpbmcgQEANCj4+
Pj4gLTQzOCw3DQo+Pj4+PiArNDM5LDcgQEAgdm9pZCBkcm1fc2NoZWRfc3RhcnQoc3RydWN0IGRy
bV9ncHVfc2NoZWR1bGVyICpzY2hlZCwNCj4+Pj4+ICtib29sDQo+Pj4+IGZ1bGxfcmVjb3Zlcnkp
DQo+Pj4+PiAgICAJICogR1BVIHJlY292ZXJzIGNhbid0IHJ1biBpbiBwYXJhbGxlbC4NCj4+Pj4+
ICAgIAkgKi8NCj4+Pj4+ICAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoc19qb2IsIHRtcCwg
JnNjaGVkLT5yaW5nX21pcnJvcl9saXN0LA0KPj4+Pj4gbm9kZSkNCj4+Pj4gew0KPj4+Pj4gLQkJ
c3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBzX2pvYi0+c19mZW5jZS0+cGFyZW50Ow0KPj4+Pj4g
KwkJc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UgPSBzX2pvYi0+c19mZW5jZSA/IHNfam9iLT5zX2Zl
bmNlLQ0KPj4+Pj4gcGFyZW50IDoNCj4+Pj4+ICtOVUxMOw0KPj4+Pj4NCj4+Pj4+ICAgIAkJYXRv
bWljX2luYygmc2NoZWQtPmh3X3JxX2NvdW50KTsNCj4+Pj4+DQo+Pj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dA0KPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Pj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4DQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
