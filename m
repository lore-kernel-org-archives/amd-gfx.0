Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31701CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0991820679
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCDE6E9F4;
	Wed, 30 Oct 2019 14:45:38 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740041.outbound.protection.outlook.com [40.107.74.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3F16E9F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 14:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaUph205UQVrQ+d4goMsMSOjIWBWYM4jI0yemmqnG3Hc5hxMS9m/ogS0L84lZhxSYynxGwn2RwolntSE08nHfrL2yYstcXx4OAazpKJwns7wQ1tP2riGJAcuxKA8rhWTVjjafpNplvP3SL2HMNty6I19qXllyyZLhRtlZB0xEGdfeNN6sMw0HZfhZsGVRBlv0L9WEScSPjokjBlBVn7dUonw5Cf8a5n1KCwhBAEShb5OWErrs6uymffwuf0vo1oZpT5uoBcAMcqosmcN/qV0ccQYDBecPT0Z6TcBTKIDyCCq9XV7EQRtl6leactqBY7ghqRa9ZbuG1pvn0Ab/NN00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl/sZK+bwD+gfAe3zz/o+OjZYtlUGbZHWGFo43Vpavs=;
 b=TIZ2wDK3P5kW2OsgYgmqw5pGIjzL8gHntF6peZmkrMT9GXfpk69gyIWWEO4tjoQDlanT51EiVv80owLw8Q2fbIaIRZV0azGcdX9lpU+zSjffAEluWjvL+j1V3+FeEZC9drWQ8Fzf+jXE4Le30m5pwytRhupdKKZQqVPUuMkSiYc4ozL5ZtFd0AQBfXmZDM6R8Q220pbFThrORQ3V0K23rukuER0ZBiYhbQmWRWxcjJiBvMSPP9ssPr/b3KDRf3sXEqeh0Jv9wLmTPQO719Emm1d8kgtftB85RJtJJ5VOp8as3MFSpivopEw3Kau3daDOktgMrkDGmETd9GAZqICr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1709.namprd12.prod.outlook.com (10.175.54.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Wed, 30 Oct 2019 14:45:35 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::3963:88a3:88f1:4a1d%4]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 14:45:35 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "S, Shirish" <Shirish.S@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Topic: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Index: AQHVjwJaqXgdXzZy206qemuwuHylYady+S4AgAAB3wCAAEhLgA==
Date: Wed, 30 Oct 2019 14:45:35 +0000
Message-ID: <45a5d192-6b47-381d-1e6c-1571a6ec1889@amd.com>
References: <1572426811-30618-1-git-send-email-shirish.s@amd.com>
 <bfefc5cb-c560-868a-7b03-90f4e5118451@amd.com>
 <58085e1d-39f4-1907-4495-71a13c52b825@amd.com>
In-Reply-To: <58085e1d-39f4-1907-4495-71a13c52b825@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::22) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa4b8f08-5cb7-43c7-a638-08d75d47d284
x-ms-traffictypediagnostic: MWHPR12MB1709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1709583D4AEF1C7CB957842AEA600@MWHPR12MB1709.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(25786009)(66574012)(26005)(305945005)(53546011)(66556008)(66446008)(6436002)(66476007)(64756008)(6506007)(5660300002)(386003)(229853002)(76176011)(81166006)(81156014)(52116002)(8936002)(8676002)(2906002)(31686004)(186003)(7736002)(66946007)(6512007)(102836004)(6486002)(256004)(316002)(478600001)(476003)(36756003)(2616005)(86362001)(14444005)(6636002)(4326008)(446003)(14454004)(31696002)(11346002)(99286004)(71200400001)(71190400001)(6246003)(66066001)(486006)(110136005)(3846002)(6116002)(192303002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1709;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cDDdPHOhtmuYdWTPZpMad5FdlqT/DMygFNIRhz5DTQZJlNUtQa3sfs4mTMby5vFQg8gAN7K8koF2o5SFr4H79nyn5RNuwzOjM3g30SgMGJEzKSpjh0xm4g4fA4XXhyfpXNP1wyK5+9EXYFKDu0wJLQPVFSilxMUlyMjJsB72Js51hs7Va/LQQGN12i28UXjLgPANpKVDYSmkFBwv01EC9YWUeca1COM6wtDtqtfZ/w19/dgmscd5ZwsVwxL6+gkxPYPO2mbfajCLoyg1h1lgoPTV/t8TjhoT7+nAH/GD2ldUri0AnlCW2PPisEhRAsg3haGWWvJ4/qqMnhMTN3TLw+nPJYF19XfDCvgQp5jNR0AcAalFvUaPp3nmumEB9LVMOUkOhp6GwexHEsUbxMgNYSAho1aHbcNvP99wPRyjxHByrI44PkZtrg32lS7dZhhE
Content-ID: <544918B45EFEF34296F080AAC73ABB89@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4b8f08-5cb7-43c7-a638-08d75d47d284
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:45:35.4763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5f5Tq1iHfuph0lg6hoVyhV9qNVPaf9LxPdgiSqNkV7X1+f90trccuPN0Y2sQmyL7koMPJwqIN0Bbz9pDKviLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1709
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl/sZK+bwD+gfAe3zz/o+OjZYtlUGbZHWGFo43Vpavs=;
 b=kd9PapT358TS2aiO9/3PPUqtIKCN6ZpT+dp74487EevCjJNWdx1n/8MlKBky1QSqSSsucZUCF7cZYfDN39hRYA6PgzEAewQ3jV5NmJ+/+iyTKLWKtC+7FcDlBEo6KM8fT/Noijpgx+7ZzV9npTcmjKK+YW/Q+udFIbjh/eI3kEk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
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
Message-ID: <20191030144535.E1nGiq-A911g2LTOxD_-vm-WthF_GeCZ8ozykqkqP4M@z>

DQpPbiAxMC8zMC8xOSA2OjIyIEFNLCBTLCBTaGlyaXNoIHdyb3RlOg0KPiBPbiAxMC8zMC8yMDE5
IDM6NTAgUE0sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOg0KPj4gQW0gMzAuMTAuMTkgdW0gMTA6
MTMgc2NocmllYiBTLCBTaGlyaXNoOg0KPj4+IFtXaHldDQo+Pj4NCj4+PiBkb2luZyBrdGhyZWFk
X3BhcmsoKS91bnBhcmsoKSBmcm9tIGRybV9zY2hlZF9lbnRpdHlfZmluaQ0KPj4+IHdoaWxlIEdQ
VSByZXNldCBpcyBpbiBwcm9ncmVzcyBkZWZlYXRzIGFsbCB0aGUgcHVycG9zZSBvZg0KPj4+IGRy
bV9zY2hlZF9zdG9wLT5rdGhyZWFkX3BhcmsuDQo+Pj4gSWYgZHJtX3NjaGVkX2VudGl0eV9maW5p
LT5rdGhyZWFkX3VucGFyaygpIGhhcHBlbnMgQUZURVINCj4+PiBkcm1fc2NoZWRfc3RvcC0+a3Ro
cmVhZF9wYXJrIG5vdGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVyDQo+Pj4gKHRoaXJkKSB0aHJl
YWQgdG8ga2VlcCBzdWJtaXR0aW5nIGpvYiB0byBIVyB3aGljaCB3aWxsIGJlDQo+Pj4gcGlja2Vk
IHVwIGJ5IHRoZSB1bnBhcmtlZCBzY2hlZHVsZXIgdGhyZWFkIGFuZCB0cnkgdG8gc3VibWl0DQo+
Pj4gdG8gSFcgYnV0IGZhaWwgYmVjYXVzZSB0aGUgSFcgcmluZyBpcyBkZWFjdGl2YXRlZC4NCj4+
Pg0KPj4+IFtIb3ddDQo+Pj4gZ3JhYiB0aGUgcmVzZXQgbG9jayBiZWZvcmUgY2FsbGluZyBkcm1f
c2NoZWRfZW50aXR5X2ZpbmkoKQ0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU2hpcmlzaCBTIDxz
aGlyaXNoLnNAYW1kLmNvbT4NCj4+PiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4+IFBhdGNoIGl0c2VsZiBpcyBSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPj4NCj4+IERvZXMg
dGhhdCBhbHNvIGZpeCB0aGUgcHJvYmxlbXMgeW91IGhhdmUgYmVlbiBzZWVpbmc/DQo+IFllcyBD
aHJpc3RpYW4uDQo+DQo+IFJlZ2FyZHMsDQo+DQo+IFNoaXJpc2ggUw0KDQoNCk1pc3NlZCB0aGF0
IG9uZSwgd2h5IGRvbid0IHdlIGZpeCBpdCB3aXRoaW4gc2NoZWR1bGVyIGNvZGUgLSB0aGUgcmFj
ZSBpcyANCndpdGhpbiBzY2hlZHVsZXIgPw0KDQpBbmRyZXkNCg0KDQo+DQo+PiBUaGFua3MsDQo+
PiBDaHJpc3RpYW4uDQo+Pg0KPj4+IC0tLQ0KPj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3R4LmMgfCA1ICsrKystDQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3R4LmMNCj4+PiBpbmRleCA2NjE0ZDhhLi4yY2RhZjNiIDEwMDY0NA0KPj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYw0KPj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYw0KPj4+IEBAIC02MDQsOCAr
NjA0LDExIEBAIHZvaWQgYW1kZ3B1X2N0eF9tZ3JfZW50aXR5X2Zpbmkoc3RydWN0IGFtZGdwdV9j
dHhfbWdyICptZ3IpDQo+Pj4gICAgIAkJCWNvbnRpbnVlOw0KPj4+ICAgICAJCX0NCj4+PiAgICAg
DQo+Pj4gLQkJZm9yIChpID0gMDsgaSA8IG51bV9lbnRpdGllczsgaSsrKQ0KPj4+ICsJCWZvciAo
aSA9IDA7IGkgPCBudW1fZW50aXRpZXM7IGkrKykgew0KPj4+ICsJCQltdXRleF9sb2NrKCZjdHgt
PmFkZXYtPmxvY2tfcmVzZXQpOw0KPj4+ICAgICAJCQlkcm1fc2NoZWRfZW50aXR5X2ZpbmkoJmN0
eC0+ZW50aXRpZXNbMF1baV0uZW50aXR5KTsNCj4+PiArCQkJbXV0ZXhfdW5sb2NrKCZjdHgtPmFk
ZXYtPmxvY2tfcmVzZXQpOw0KPj4+ICsJCX0NCj4+PiAgICAgCX0NCj4+PiAgICAgfQ0KPj4+ICAg
ICANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
