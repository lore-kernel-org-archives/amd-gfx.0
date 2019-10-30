Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3221CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA97C20856
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 15:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA97C20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A486EA63;
	Wed, 30 Oct 2019 15:00:47 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790080.outbound.protection.outlook.com [40.107.79.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518FB6EA63
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 15:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFlxE56sbN4JaOtBRBcGvacAUdAieUiOBUEr2dVgFWpKuJQaQZVEhxssym5fq1eXPTsAo+he8ROXhkuyrAfOenSOG8lJPMqHslCLuBjAn40qFCkVOJYrxzS6IHn3o+y3UcLcDR5pisoWRNVcc88p9bbTo91vgVz1A9XPMcwrrYkDGUSR5kkUffgsw8vlOonlTp0PRiocWOtZVEm2+oOF21WUP0VhPLz+6K3/6UBKCfxv7y1L6xsPMWcvfnYZYnhsPz4rmU/dlQ6RmRgBNaT2LERta88Kt3lWVZc5GPLr08AFwXIqdFrU9uUB+VDuOdkt9siGHPizV9u3goWLq74SsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yIGuVyaFy3m9w4QwwSNMw9D0wZbUH4h+TXZgvHT/bc=;
 b=RzEgydeLZki0oGjujMk1gtRLvZ9hwfza9JaZUKcqnck7SCs7hTjRBl0o7GZORsCx6y8CmTHu1Ikdn7tXb3eS4hOs602c3NsBqr010hOQu/tWX3htbBxPFdQZNXtZoY0TaMuBWrfWVsIbfIFqNRE/8P8UB3dwVIg01QoEmF1vX4PPrFu8gh0L9LMiK36/o4HjcBUvmYLZt5l1J8XEit3SvxxSZZ0e/6WFlMSNwECZq1muvX0GkJKZfHgcjRBsJMfEZNnd+P1+UKHSZPgFXtGBtlCp+aUsB/fW0+0oWcohGstM3zf+GyBZ0yK7bsGGzrO0nxB6LFJaN4+3V8fgMCMz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1707.namprd12.prod.outlook.com (10.175.86.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 15:00:43 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.018; Wed, 30 Oct 2019
 15:00:43 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "S, Shirish"
 <Shirish.S@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Topic: [PATCH] drm/amdgpu: guard ib scheduling while in reset
Thread-Index: AQHVilnzZQjKfUg1H0yk/qIOzcWqzadpoAIAgABEjYCAABdSgIABExiA////kQCAAAlvAP///8IAgABnW4CAAAYYAIAAAWYAgAdieoCAAGMsAIAAAeGAgAABsACAAAEUgA==
Date: Wed, 30 Oct 2019 15:00:42 +0000
Message-ID: <90eb8377-82c4-968a-82f0-1409f69c17e5@amd.com>
References: <1571914692-9430-1-git-send-email-shirish.s@amd.com>
 <23ea615d-5ef4-d0b3-a0ec-6fae67b102f2@gmail.com>
 <f3be329d-d350-c821-00b7-d94858335796@amd.com>
 <d573688c-0997-1928-0c56-b60a29ff7fde@gmail.com>
 <b5e99dc3-5658-7e48-63f7-bf9533f582f8@amd.com>
 <2505c476-9e10-f70e-355c-33765a37d607@amd.com>
 <a1c31f37-128f-51b1-f747-fe75d78d4214@amd.com>
 <a9789f76-3ba5-ad71-1507-5eac6f589b82@amd.com>
 <971115b1-6208-1dd5-d99f-c9377663a80b@amd.com>
 <2e2ebf73-9a25-5ad2-78e7-07c8b1db1b37@amd.com>
 <08e3c44f-5d08-d5f5-bc76-ea9b77032e5a@amd.com>
 <1e1d0b06-75ab-160c-a6c7-baede02f1e7d@amd.com>
 <f5b7aeff-c4ce-fa2f-1390-e8892fa7a964@amd.com>
 <d73c46e2-ed85-f56e-3a2a-cbf2919d0a3f@gmail.com>
 <d881fbbe-5fb1-ea68-6490-d08d81c865dd@amd.com>
In-Reply-To: <d881fbbe-5fb1-ea68-6490-d08d81c865dd@amd.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM4PR0902CA0017.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::27) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 769c855b-03ff-4fda-f61d-08d75d49ef57
x-ms-traffictypediagnostic: DM5PR12MB1707:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1707A9E4C9BA7FE1891E420E83600@DM5PR12MB1707.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(65956001)(6246003)(81166006)(99286004)(25786009)(53546011)(6506007)(386003)(31696002)(186003)(14454004)(65806001)(81156014)(66574012)(71200400001)(71190400001)(5660300002)(102836004)(8936002)(58126008)(316002)(36756003)(4326008)(6636002)(305945005)(31686004)(14444005)(229853002)(8676002)(476003)(86362001)(6306002)(6486002)(256004)(7736002)(966005)(478600001)(6116002)(2906002)(11346002)(446003)(2616005)(52116002)(76176011)(66556008)(66476007)(66446008)(46003)(64756008)(66946007)(6436002)(486006)(6512007)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1707;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oVGhyOu7v33gRy35qToXlK0It397R5ZGADuhdenjm0fZrn2DZwewBvhrEppjRRwkw451XNDuK6NykIevrmNayMX7pR+x5vsECnTFWZhKM/U3x3xHuXfi/ZMh7KjLLU0DRj3nnSX0gIwY92YT89x9PO7NgwouJf9cwpB/p5wwv/MvQBTlDd5okebLKcHUUyQYAs2LOTYPbhZn/ERR9kpovhuN5xCWbjf3s2+UkdRhZKvFZGuDmax3oZ93Be6PW9d1Wdapp/5wBKGB67t7k5sR7+nAZdywB4AaupKUIa/3nis4ulA/w2UqYe0A9lSrJ3y0WPo1GybBw829wE+Ng+4oH0e4fBppL+TC1IgFufrb3wKZPnWlJ41R89t/y0aD2edlZFXFR4mAGi8O1zpnksNIK3485F4RXhQ48fpGnb4POWNlSptIESm8kf7BvsdyMn70x+v3bzJ1urbHGsisIK8eTCUMnpVAn1VVgJSgifW9CLc=
Content-ID: <2831D6F3F737A5479A5F8CEFC96C05B8@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769c855b-03ff-4fda-f61d-08d75d49ef57
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 15:00:42.8778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4bYaGd4YC5F47vm/LdgBB66SXZNZ2IcUIV03rIolo/AY30xjv+MmCL2JQOku74F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yIGuVyaFy3m9w4QwwSNMw9D0wZbUH4h+TXZgvHT/bc=;
 b=mGomdVXEFZ7bQuhOs+zUX9qBDjWNLCXRYxJOrVLsq7VNBzNrziHUGjCiGJ3O3G07/l+5K5iEb1C9Co/3QUwMlrSW1DRsyMhU7U8v0z0y1OTDUQpvf3OQsn8tVC0/ESaeZc0F6M4mb9+kA7qNSpZfno9smJwiK+sQ94pNlfd//bg=
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
Message-ID: <20191030150042.Z8O4zE33KCkb6F8hWFQZ0ZvRK9MeW8euaw1SZOl6LT0@z>

WWVhaCwgYW5kIGV4YWN0bHkgdGhhdCdzIHRoZSBwcm9ibGVtIDopIFlvdSBuZWVkIGEgZ2xvYmFs
IGxvY2sgY292ZXJpbmcgDQphbGwgc2NoZWR1bGVycy4NCg0KT3RoZXJ3aXNlIHlvdSBlbmQgdXAg
aW4gaGVsbCdzIGtpdGNoZW4gYWdhaW4gd2l0aCB0YWtpbmcgYWxsIHRob3NlIGxvY2tzIA0KaW4g
dGhlIHJpZ2h0IG9yZGVyLg0KDQpDaHJpc3RpYW4uDQoNCkFtIDMwLjEwLjE5IHVtIDE1OjU2IHNj
aHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Og0KPiBDYW4geW91IGVsYWJvcmF0ZSBvbiB3aGF0IGlz
IHRoZSB0cmlja3kgcGFydCB3aXRoIHRoZSBsb2NrID8gSSBhc3N1bWVkDQo+IHdlIGp1c3QgdXNl
IHBlciBzY2hlZHVsZXIgbG9jay4NCj4NCj4gQW5kcmV5DQo+DQo+IE9uIDEwLzMwLzE5IDEwOjUw
IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPj4gQSBsb2NrIGluc2lkZSB0aGUgc2NoZWR1
bGVyIGlzIHJhdGhlciB0cmlja3kgdG8gaW1wbGVtZW50Lg0KPj4NCj4+IFdoYXQgeW91IG5lZWQg
dG8gZG8gaXMgdG8gZ2V0IHJpZCBvZiB0aGUgcGFyaygpL3VucGFyaygpIGhhY2sgaW4NCj4+IGRy
bV9zY2hlZF9lbnRpdHlfZmluaSgpLg0KPj4NCj4+IFdlIGNvdWxkIGRvIHRoaXMgd2l0aCBhIHN0
cnVjdCBjb21wbGV0aW9uIG9yIGNvbnZlcnQgdGhlIHNjaGVkdWxlcg0KPj4gZnJvbSBhIHRocmVh
ZCB0byBhIHdvcmsgaXRlbS4NCj4+DQo+PiBSZWdhcmRzLA0KPj4gQ2hyaXN0aWFuLg0KPj4NCj4+
IEFtIDMwLjEwLjE5IHVtIDE1OjQ0IHNjaHJpZWIgR3JvZHpvdnNreSwgQW5kcmV5Og0KPj4+IFRo
YXQgZ29vZMKgIGFzIHByb29mIG9mIFJDQSBidXQgSSBzdGlsbCB0aGluayB3ZSBzaG91bGQgZ3Jh
YiBhIGRlZGljYXRlZA0KPj4+IGxvY2sgaW5zaWRlIHNjaGVkdWxlciBzaW5jZSB0aGUgcmFjZSBp
cyBpbnRlcm5hbCB0byBzY2hlZHVsZXIgY29kZSBzbw0KPj4+IHRoaXMgYmV0dGVyIHRvIGhhbmRs
ZSBpdCBpbnNpZGUgdGhlIHNjaGVkdWxlciBjb2RlIHRvIG1ha2UgdGhlIGZpeCBhcHBseQ0KPj4+
IGZvciBhbGwgZHJpdmVycyB1c2luZyBpdC4NCj4+Pg0KPj4+IEFuZHJleQ0KPj4+DQo+Pj4gT24g
MTAvMzAvMTkgNDo0NCBBTSwgUywgU2hpcmlzaCB3cm90ZToNCj4+Pj4+Pj4gV2Ugc3RpbGwgaGF2
ZSBpdCBhbmQgaXNuJ3QgZG9pbmcga3RocmVhZF9wYXJrKCkvdW5wYXJrKCkgZnJvbQ0KPj4+Pj4+
PiBkcm1fc2NoZWRfZW50aXR5X2Zpbmkgd2hpbGUgR1BVIHJlc2V0IGluIHByb2dyZXNzIGRlZmVh
dHMgYWxsIHRoZQ0KPj4+Pj4+PiBwdXJwb3NlIG9mIGRybV9zY2hlZF9zdG9wLT5rdGhyZWFkX3Bh
cmsgPyBJZg0KPj4+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2ZpbmktPiBrdGhyZWFkX3VucGFyayBo
YXBwZW5zIEFGVEVSDQo+Pj4+Pj4+IGRybV9zY2hlZF9zdG9wLT5rdGhyZWFkX3Bhcmsgbm90aGlu
ZyBwcmV2ZW50cyBmcm9tIGFub3RoZXIgKHRoaXJkKQ0KPj4+Pj4+PiB0aHJlYWQga2VlcCBzdWJt
aXR0aW5nIGpvYiB0byBIVyB3aGljaCB3aWxsIGJlIHBpY2tlZCB1cCBieSB0aGUNCj4+Pj4+Pj4g
dW5wYXJrZWQgc2NoZWR1bGVyIHRocmVhZCB0cnkgdG8gc3VibWl0IHRvIEhXIGJ1dCBmYWlsIGJl
Y2F1c2UgdGhlDQo+Pj4+Pj4+IEhXIHJpbmcgaXMgZGVhY3RpdmF0ZWQuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IElmIHNvIG1heWJlIHdlIHNob3VsZCBzZXJpYWxpemUgY2FsbHMgdG8NCj4+Pj4+Pj4ga3Ro
cmVhZF9wYXJrL3VucGFyayhzY2hlZC0+dGhyZWFkKSA/DQo+Pj4+Pj4+DQo+Pj4+Pj4gWWVhaCwg
dGhhdCB3YXMgbXkgdGhpbmtpbmcgYXMgd2VsbC4gUHJvYmFibHkgYmVzdCB0byBqdXN0IGdyYWIg
dGhlDQo+Pj4+Pj4gcmVzZXQgbG9jayBiZWZvcmUgY2FsbGluZyBkcm1fc2NoZWRfZW50aXR5X2Zp
bmkoKS4NCj4+Pj4+IFNoaXJpc2ggLSBwbGVhc2UgdHJ5IGxvY2tpbmcgJmFkZXYtPmxvY2tfcmVz
ZXQgYXJvdW5kIGNhbGxzIHRvDQo+Pj4+PiBkcm1fc2NoZWRfZW50aXR5X2ZpbmkgYXMgQ2hyaXN0
aWFuIHN1Z2dlc3RzIGFuZCBzZWUgaWYgdGhpcyBhY3R1YWxseQ0KPj4+Pj4gaGVscHMgdGhlIGlz
c3VlLg0KPj4+Pj4NCj4+Pj4gWWVzIHRoYXQgYWxzbyB3b3Jrcy4NCj4+Pj4NCj4+Pj4gUmVnYXJk
cywNCj4+Pj4NCj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPj4+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
