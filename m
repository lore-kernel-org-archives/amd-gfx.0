Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87351C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 16:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55009206DF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 16:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55009206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035F96F744;
	Thu,  7 Nov 2019 16:24:33 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790055.outbound.protection.outlook.com [40.107.79.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0786F744
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 16:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chp1b0UMjEVTBcRuuY4Cd+L3fbBsYEkTbdpk70jwSDkz9Go7Cs9tiI+wqpsV+mPizymoclW/TH8sMKLRdnEM6hPGMItIZlZLCfIha4zkzOygh1aUIqTNjUfJ54Nj6oRWGNxOu/PP8FW3ye9X7+lcbZBw+8/U7ETSkC3WAnK0rAq1RnUFk/aIyjFJdBxImYL6RTuMJc8qIRZ6x6C2dXD33wVrLuKaTuhPD+juivK9szySkwNSIGcevr3ZlcHbr4lBbtEjj1bRUKcivGqbMtu4NtL+5LcL5Appv3sfco1Kv+zUmJ2QVW4BDUDw2BIVy0c6xM/WIpclS8ymQIGwDgd3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFxKcCguc5yZGC1Ia0MMSLfkDfeTDx8YHZIeA32I0I0=;
 b=g3DkKX7i3W3dMDctqLJRLPRAsZH1RrIbKEU04gAk5VTWSZ/nYI9LAzZjrxVnslO3zcW8vGRTRFsa+XCPFRNL7IakldQ4UHOHMRdIcB07STJhJGRsS2ypG3i+Qsdy4JUI+X1lXzvBcWlWqSSffJlpej3S+VFoLG7VI5r31Q8Lo+QB3lDDyQ7mUfV0GmlumqVb5RUjwPdJTKhBGNwHPEUjrid9ec+YXRhdQol9/G12X+kx7HN5nMyq2En8MvjtG0h/Tx63IebEh4t6/vKKcbMOKH2NoZXPp1aot5nloIOX1J47qmwBYvpf5rh9QYv5JMTVIrrwJuQH76/du2rBJ1syqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB2549.namprd12.prod.outlook.com (10.172.121.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 7 Nov 2019 16:24:30 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::449d:52a8:2761:9195%5]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 16:24:30 +0000
From: Harry Wentland <hwentlan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/display: fix the build when
 CONFIG_DRM_AMD_DC_DCN is not set
Thread-Topic: [PATCH] drm/amdgpu/display: fix the build when
 CONFIG_DRM_AMD_DC_DCN is not set
Thread-Index: AQHVlQ4gjveQQF7GI0Kwyt7iyBE8H6d/5YmA
Date: Thu, 7 Nov 2019 16:24:30 +0000
Message-ID: <53bfdfcf-1387-881b-298b-f826d57f2263@amd.com>
References: <20191107015258.807545-1-alexander.deucher@amd.com>
In-Reply-To: <20191107015258.807545-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
x-clientproxiedby: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4138ff8-a4d3-4296-880c-08d7639ef71f
x-ms-traffictypediagnostic: CY4PR1201MB2549:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB25496C2A927F4A6FA9CBD81D8C780@CY4PR1201MB2549.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:480;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(26005)(6246003)(36756003)(186003)(65806001)(52116002)(2501003)(14454004)(6506007)(386003)(65956001)(76176011)(478600001)(6486002)(486006)(66066001)(11346002)(446003)(2616005)(8676002)(81156014)(8936002)(81166006)(102836004)(53546011)(2906002)(476003)(99286004)(66946007)(25786009)(229853002)(3846002)(6116002)(6436002)(66476007)(31686004)(66556008)(64756008)(66446008)(7736002)(71190400001)(71200400001)(256004)(14444005)(5660300002)(6512007)(31696002)(4326008)(58126008)(110136005)(316002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2549;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CyzXs5ynFGktdSPNkL/e+Doz389XZeAnAe6cVarpaaV/iBPXFpZKv98G/6mu5jPB+SxzXUCPB1suzLeOYtAMeJxdJau4npUIez7NpSRSrpgfoyiHpygaQZI48Lu1EMwVPTEOp3uEpg3+Wv5vZiRiOnnuTPvyiv9h/kTMjoRUkdfhDF2lJIftBY6eZE0lmPAQhEAcsO0JY1hHBzNkbI3JFL5SZXeKM/6T5JLa7H+2wxhUEIrVvYuzfeYVDLrzWt8n2nU0wlbaIvFz3b3zfuHVZrXwygbKEFJwu9iqD4bZj+vAlju9TrRB8YDlP+9ZQbx/rz01QVTjFKgB1OA0bG65OiCloLmtUGyCd5w6EUREIvWniZRscOt0G8uODuEUNihE/lKC46pAGXhEG1Lcf7qDxtpBNB2ey5IvXInHd2TBcIQAZ2DPq8KuvdtefnXFe5AK
Content-ID: <71A488A47803124EB125789035FBF1DB@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4138ff8-a4d3-4296-880c-08d7639ef71f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 16:24:30.0834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1a+gddtzmieDfOORTSmla1qP4geSoeSCNnjnhuOpN8E56pp9MusQoInr7+ia4Sh6D+k7GaJHVubN778HdVbBpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2549
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFxKcCguc5yZGC1Ia0MMSLfkDfeTDx8YHZIeA32I0I0=;
 b=Y8YPvHi5ZzyRdMwhBdeHIxv3JuzhBcBRVcIlTKIe5W9wBnfaWqXhB29s61ZrjxowEBxCya9jq4SSDjuYOWlwiFRJSL9jW/sG/JbJaMuWSzNIWiCHldCf4OgkR70zTDsCYnN2/GG7nGZDgyXSGZb09n6E/GoRjAal8BlS94lEEKk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107162430.Q0YlvVsmGiY4d5g7d23Oh15C_rgExawjC97Iu3CMDvg@z>

T24gMjAxOS0xMS0wNiA4OjUyIHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gTmVlZCB0byBw
cm90ZWN0IHNvbWUgRFNDIGZ1bmN0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDYgKysrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gaW5kZXggYTFi
ZGQ1MWM1MGY3Li5mY2JjZjUyYTc3ZTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiBAQCAtMzg5MSw3ICszODkxLDkg
QEAgY3JlYXRlX3N0cmVhbV9mb3Jfc2luayhzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNv
bm5lY3RvciwNCj4gIAlib29sIHNjYWxlID0gZG1fc3RhdGUgPyAoZG1fc3RhdGUtPnNjYWxpbmcg
IT0gUk1YX09GRikgOiBmYWxzZTsNCj4gIAlpbnQgbW9kZV9yZWZyZXNoOw0KPiAgCWludCBwcmVm
ZXJyZWRfcmVmcmVzaCA9IDA7DQo+ICsjaWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04p
DQo+ICAJc3RydWN0IGRzY19kZWNfZHBjZF9jYXBzIGRzY19jYXBzOw0KPiArI2VuZGlmDQo+ICAJ
dWludDMyX3QgbGlua19iYW5kd2lkdGhfa2JwczsNCj4gIA0KPiAgCXN0cnVjdCBkY19zaW5rICpz
aW5rID0gTlVMTDsNCj4gQEAgLTM5NzAsMTIgKzM5NzIsMTUgQEAgY3JlYXRlX3N0cmVhbV9mb3Jf
c2luayhzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5lY3RvciwNCj4gIAlzdHJlYW0t
PnRpbWluZy5mbGFncy5EU0MgPSAwOw0KPiAgDQo+ICAJaWYgKGFjb25uZWN0b3ItPmRjX2xpbmsg
JiYgc2luay0+c2lua19zaWduYWwgPT0gU0lHTkFMX1RZUEVfRElTUExBWV9QT1JUKSB7DQo+ICsj
aWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pDQo+ICAJCWRjX2RzY19wYXJzZV9kc2Nf
ZHBjZChhY29ubmVjdG9yLT5kY19saW5rLT5kcGNkX2NhcHMuZHNjX2NhcHMuZHNjX2Jhc2ljX2Nh
cHMucmF3LA0KPiAgCQkJCSAgICAgIGFjb25uZWN0b3ItPmRjX2xpbmstPmRwY2RfY2Fwcy5kc2Nf
Y2Fwcy5kc2NfZXh0X2NhcHMucmF3LA0KPiAgCQkJCSAgICAgICZkc2NfY2Fwcyk7DQo+ICsjZW5k
aWYNCj4gIAkJbGlua19iYW5kd2lkdGhfa2JwcyA9IGRjX2xpbmtfYmFuZHdpZHRoX2ticHMoYWNv
bm5lY3Rvci0+ZGNfbGluaywNCj4gIAkJCQkJCQkgICAgIGRjX2xpbmtfZ2V0X2xpbmtfY2FwKGFj
b25uZWN0b3ItPmRjX2xpbmspKTsNCj4gIA0KPiArI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURf
RENfRENOKQ0KPiAgCQlpZiAoZHNjX2NhcHMuaXNfZHNjX3N1cHBvcnRlZCkNCj4gIAkJCWlmIChk
Y19kc2NfY29tcHV0ZV9jb25maWcoYWNvbm5lY3Rvci0+ZGNfbGluay0+Y3R4LT5kYy0+cmVzX3Bv
b2wtPmRzY3NbMF0sDQo+ICAJCQkJCQkgICZkc2NfY2FwcywNCj4gQEAgLTM5ODQsNiArMzk4OSw3
IEBAIGNyZWF0ZV9zdHJlYW1fZm9yX3Npbmsoc3RydWN0IGFtZGdwdV9kbV9jb25uZWN0b3IgKmFj
b25uZWN0b3IsDQo+ICAJCQkJCQkgICZzdHJlYW0tPnRpbWluZywNCj4gIAkJCQkJCSAgJnN0cmVh
bS0+dGltaW5nLmRzY19jZmcpKQ0KPiAgCQkJCXN0cmVhbS0+dGltaW5nLmZsYWdzLkRTQyA9IDE7
DQo+ICsjZW5kaWYNCj4gIAl9DQo+ICANCj4gIAl1cGRhdGVfc3RyZWFtX3NjYWxpbmdfc2V0dGlu
Z3MoJm1vZGUsIGRtX3N0YXRlLCBzdHJlYW0pOw0KPiANCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
