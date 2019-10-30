Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4964ACA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 10:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F340B20874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 10:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F340B20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64BF6E923;
	Wed, 30 Oct 2019 10:20:17 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790044.outbound.protection.outlook.com [40.107.79.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F5376E91E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 10:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYxMiqIQ0ry0rCKvct9hkf4s66g5iN7nT39aD2dWDYCqZHLZIXlA9X6ERww3pzSwwsefDMb6djBPzjs+e+q48cNLbOWsihZmGa+LG+FvaAqMqn+DScYPdzGy8NGxt3hbgOizfpNcqGHqwopY1zIR0LkTwvCqci9dKauPqQ7W7AAbyyLpgLdYP0es5We9kqN1eXFWY9++VfZgu7gDj09tJ152GrLG8pdykt0dEFx0FfblL5Smn+jm7r6lopzeVYEumY1vAzjAq2Gc1auW9poaWBT5HO/8A0796KkZAI/sen3Upsx0FTHNTDoVFRY44T+iUZhIZqKqWdvb1RiAhzxYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybCHmhvypYWrQ48tz6FB7K9JD6rCtLQacDA3zAJPJCE=;
 b=fC38iR6spaKYD2tK3YZShiDBdJrKNNuveEC8o92VVhmzAieWa8vWWgYwwNwde48Tb5UKwaImFqo+Pfxk9sSc7l4BZr1dfGnjPzFarB1EEveaySwR7hr+dC0mfPDUe/7mrkReUwEvCtR812LXs4llkEIHMPZzBfa1Ag7BtV3gXhfe4BSGNVfRSzbcJB2sAdlU4CjkkztsGSAwEzboLejATVw5/bPohdHHEUWNjZbDA0QNioyQ54c0Cl5Ng3qfYYqPFyQLgq/IzbRC9RiNEcLsuQ/K0CLjKRkXeuImxwFTWcKlmZIbtbQkEo8w1aFBRzwiyOo+NO02a/BY/StIdsrhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1323.namprd12.prod.outlook.com (10.168.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Wed, 30 Oct 2019 10:20:13 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.018; Wed, 30 Oct 2019
 10:20:13 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "S, Shirish" <Shirish.S@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Topic: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Index: AQHVjwJaqXgdXzZy206qemuwuHylYady+S4A
Date: Wed, 30 Oct 2019 10:20:13 +0000
Message-ID: <bfefc5cb-c560-868a-7b03-90f4e5118451@amd.com>
References: <1572426811-30618-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1572426811-30618-1-git-send-email-shirish.s@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::44) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c81f0ba-b814-4980-94fd-08d75d22bfff
x-ms-traffictypediagnostic: DM5PR12MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB132306FC7C3A8F4B8193101E83600@DM5PR12MB1323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(66476007)(64756008)(6116002)(66556008)(66446008)(66946007)(52116002)(99286004)(316002)(6246003)(31686004)(4326008)(14444005)(256004)(6512007)(36756003)(25786009)(86362001)(14454004)(8676002)(81166006)(81156014)(65956001)(65806001)(66574012)(8936002)(31696002)(6436002)(71190400001)(71200400001)(2906002)(486006)(7736002)(305945005)(478600001)(446003)(2616005)(11346002)(476003)(6636002)(58126008)(186003)(5660300002)(46003)(229853002)(6486002)(110136005)(102836004)(76176011)(386003)(6506007)(192303002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rk43PhZraR/af63H3q9NPZi905p/YiHx6PYio9xQbDSe+2i/4tK2D3VP50ituPeg4So+N4JwN5+DsNNQkn3msTxS3ptElstwUvfXgvXueLju6prSZscxf4YF455M0+s2MBuhF0djm+DBJp95PbS22SpD9Dnw5+PDIgbNGB33dXqWyvHTwQsW/OSYmkAON7VXJewkpMrvwNdkMHmoH+AMix/Uy598fxBXAkiWSVHjRdJGfG3lc5YkqQpgi5W3yZ75BHmCkkPDisM9hIqBffMDFJ4FTYHAeCBdFhw3x5P0jm7a6nYA9zH+rQ39opoX3JdNciG+r6DU54mOGLyevBeVxxmNlAqTDPPHczyboHXJ5BRv144Z+X7du5+E/B04+7FvyJkcR1lsaXTN53zXpv1Tk5x6m9e0IsxPWUTZQjRtUf4eDqG2o+xTc6k1JtXDV8A8
Content-ID: <384016DD15F9304D90A8DE4EF0473FB2@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c81f0ba-b814-4980-94fd-08d75d22bfff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 10:20:13.0732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxxb2ou/eaS2tOJrAxM0bwy0lcbZE6WuGIvz9R7Psba5/vbpNhjWAj8NKX79/0iK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybCHmhvypYWrQ48tz6FB7K9JD6rCtLQacDA3zAJPJCE=;
 b=1/Cw9R5+TdpxBIxFF/La/+8ES5oIxL5VLDzbBOka5Lfgaepw8liDtTPDN7tmoE00Pq6cdiPfYiaRMJTPTVOxYI1QZktp21g7V43IfqSGEOQlnX0qkoNOk8Q2WBlqtzo+pnA/ac/aIzPLnRDQESHi+9MEav+wfqhSv50aHzh5++w=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030102013.iZtisu8fopDMfPFBhR0-LpoIZ8XVQavOxRo3N_YLcvk@z>

QW0gMzAuMTAuMTkgdW0gMTA6MTMgc2NocmllYiBTLCBTaGlyaXNoOg0KPiBbV2h5XQ0KPg0KPiBk
b2luZyBrdGhyZWFkX3BhcmsoKS91bnBhcmsoKSBmcm9tIGRybV9zY2hlZF9lbnRpdHlfZmluaQ0K
PiB3aGlsZSBHUFUgcmVzZXQgaXMgaW4gcHJvZ3Jlc3MgZGVmZWF0cyBhbGwgdGhlIHB1cnBvc2Ug
b2YNCj4gZHJtX3NjaGVkX3N0b3AtPmt0aHJlYWRfcGFyay4NCj4gSWYgZHJtX3NjaGVkX2VudGl0
eV9maW5pLT5rdGhyZWFkX3VucGFyaygpIGhhcHBlbnMgQUZURVINCj4gZHJtX3NjaGVkX3N0b3At
Pmt0aHJlYWRfcGFyayBub3RoaW5nIHByZXZlbnRzIGZyb20gYW5vdGhlcg0KPiAodGhpcmQpIHRo
cmVhZCB0byBrZWVwIHN1Ym1pdHRpbmcgam9iIHRvIEhXIHdoaWNoIHdpbGwgYmUNCj4gcGlja2Vk
IHVwIGJ5IHRoZSB1bnBhcmtlZCBzY2hlZHVsZXIgdGhyZWFkIGFuZCB0cnkgdG8gc3VibWl0DQo+
IHRvIEhXIGJ1dCBmYWlsIGJlY2F1c2UgdGhlIEhXIHJpbmcgaXMgZGVhY3RpdmF0ZWQuDQo+DQo+
IFtIb3ddDQo+IGdyYWIgdGhlIHJlc2V0IGxvY2sgYmVmb3JlIGNhbGxpbmcgZHJtX3NjaGVkX2Vu
dGl0eV9maW5pKCkNCj4NCj4gU2lnbmVkLW9mZi1ieTogU2hpcmlzaCBTIDxzaGlyaXNoLnNAYW1k
LmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQoNClBhdGNoIGl0c2VsZiBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQpEb2VzIHRoYXQgYWxzbyBmaXggdGhlIHBy
b2JsZW1zIHlvdSBoYXZlIGJlZW4gc2VlaW5nPw0KDQpUaGFua3MsDQpDaHJpc3RpYW4uDQoNCj4g
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgNSArKysr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYw0KPiBpbmRleCA2NjE0ZDhh
Li4yY2RhZjNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3R4LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5j
DQo+IEBAIC02MDQsOCArNjA0LDExIEBAIHZvaWQgYW1kZ3B1X2N0eF9tZ3JfZW50aXR5X2Zpbmko
c3RydWN0IGFtZGdwdV9jdHhfbWdyICptZ3IpDQo+ICAgCQkJY29udGludWU7DQo+ICAgCQl9DQo+
ICAgDQo+IC0JCWZvciAoaSA9IDA7IGkgPCBudW1fZW50aXRpZXM7IGkrKykNCj4gKwkJZm9yIChp
ID0gMDsgaSA8IG51bV9lbnRpdGllczsgaSsrKSB7DQo+ICsJCQltdXRleF9sb2NrKCZjdHgtPmFk
ZXYtPmxvY2tfcmVzZXQpOw0KPiAgIAkJCWRybV9zY2hlZF9lbnRpdHlfZmluaSgmY3R4LT5lbnRp
dGllc1swXVtpXS5lbnRpdHkpOw0KPiArCQkJbXV0ZXhfdW5sb2NrKCZjdHgtPmFkZXYtPmxvY2tf
cmVzZXQpOw0KPiArCQl9DQo+ICAgCX0NCj4gICB9DQo+ICAgDQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
