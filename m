Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCFCC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 871BC247E5
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PtF2VNEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871BC247E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D352E6E4AD;
	Wed, 28 Oct 2020 16:21:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9B86E4AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyOeqT39fdqWkcCBljh/OC5VRGxpR5Km5tFYYbxwEhk5IQ7Odg56mJkAOvCmpYqIn4a0CK8fan/afrBOIVCSoam4ztQ0J6AR93cspQ5UZPfS9LDGkiPnV5dz9EAgaKzhBfrm1u62Q7iJ9G6oiuuXHVYpDis024ib4yKBatQEYH5gbWyKbo4iGHZtCUUXbgkGTLGscT8yGWpqwpoOArUcfxDmKCcJQ545u3t5IiWgBAcoTtyqVyOd83LnmHeFipoC9b+O0PWJi7xI6MBFQcazITN6qba/B4abMDbD8TF7XsLWzilAmMdIbzkznGh8QfBmGTXWklFnXaly4kqcmaXMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpb3Q55LUiUiRt9o9OwEd6RDEpQx1Zdfj5ot/2fXszA=;
 b=GBwvaEfzreX+QPtHAY94Uwg9SYPVOiqHGIYsASDbEPPvrrPS0EoK7KydF9OGdpRWvDu3f4lCnnirUAboKAUHqzxkZWnnkqjXVM4/OreBcHxarUa/weCGn9yJTjvzHi9a0hJ1V4gBFw9yog7LBK+YkR9DTc5Co1dWQ+6o0WNO8c2rrF03YiKTkHGBvkMQmRascHTHCNHag7gIcwwdWPhahEGftiqNSeqe7y1u2pavOInXePRJsL7yQr1l6p1QLR629KO5BIzkhhywHjQL9j67PjdQGGuVKtGOP7lczBbaqAEYo+GgyZUiPTbfgUOpMKlNHdziEz/LKhMWHF3aaPiYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpb3Q55LUiUiRt9o9OwEd6RDEpQx1Zdfj5ot/2fXszA=;
 b=PtF2VNEyg+2FZVwAOWhtyJNjQ0mntUdipfhrRpQGhNGOxTUyumKzZvrZ6mHmMXr3ycMnFYoYJGi/wjadCJzyrGtJyP/yxeN2NM1+j4fFQlH0CEpdF3B1mSl9EmBp+X+0lr6xBCTa2ffrYGveB3cOQIo4y0lx7SA3Jov54RKbqRI=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR1201MB0156.namprd12.prod.outlook.com (2603:10b6:4:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 28 Oct
 2020 16:21:18 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:21:17 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: Change unique_id to print hex format
Thread-Topic: [PATCH 2/2] drm/amdkfd: Change unique_id to print hex format
Thread-Index: AQHWrT4sCDuV8Hl6/ECkZlyZ2ksCOKmtKsKAgAABdYCAAAMfAIAAAiNw
Date: Wed, 28 Oct 2020 16:21:17 +0000
Message-ID: <DM6PR12MB3721123FCD35B7641B1ED9D685170@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20201028152218.18485-1-kent.russell@amd.com>
 <20201028152218.18485-2-kent.russell@amd.com>
 <077bdbef-51f2-ac28-6392-84727a640525@amd.com>
 <DM6PR12MB3721E1DB3577D7B76A0ED52385170@DM6PR12MB3721.namprd12.prod.outlook.com>
 <c2d9fee1-5f4f-5cd5-79cf-a82e9f523b5a@amd.com>
In-Reply-To: <c2d9fee1-5f4f-5cd5-79cf-a82e9f523b5a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-28T16:21:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=575fb870-02b0-4047-90d9-000076aaf373;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-28T16:21:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 63079fdc-4b53-4412-a365-0000309765b3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-28T16:21:16Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c576b7fe-1945-4685-b14b-0000e136d0b7
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33ca4dbf-9ba5-4d50-8b4b-08d87b5d7fd7
x-ms-traffictypediagnostic: DM5PR1201MB0156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB015609B1D5E23073B0CD0AE085170@DM5PR1201MB0156.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T32tfMTcQWgUOR3CU3V+HzQrIW3RnbcJqOfC0klo48x0R2hmJGpNpIh6rI4C7bSJOtaoZnPL4xiqJOsdsoLysTx+YREosLf8XVRo1Wx4gjWkfbN0aBhHYmf4yqvGJ2eQPpg9TvOVyX7Zg4jR3TnA+TD2CHlqESopVdhgnXr87GQO4UKWhpMiOwNnJ04arRLl/eyO4i5cNofThNZcm87P6zNRuWhD5E0kqfG5ebKbls2Y/1AY/ZsdynD/89Qt8x+Hgmmnxsnm+fEWEjhnFdNK/k0TgZffNqucO+VUVOHrZqDI3EYr3jVMns/jGQp7BXqPelsmfr9tbrBM57lvGB4Ujg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(186003)(66476007)(33656002)(26005)(66556008)(71200400001)(53546011)(86362001)(9686003)(316002)(110136005)(52536014)(4001150100001)(8676002)(66946007)(76116006)(478600001)(6506007)(66446008)(8936002)(55016002)(64756008)(83380400001)(5660300002)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3nFvyhJI/HzB4BnFAdIxSjtPvBkFhEE8hpLRAYLRd4OLuVx6OJy3GrCt8JTRR4PtxIuli9eLlxMwvFfpZsPCWpvCp5idB5hgxHGpcEKcSpBA4Z5wdE+C3jHefV61uZcmRAw2a4H5kdha35Q034nkJmD5rtKJsTojU9uxEMVNgYM4rWnwy86rqthYw3bK5+5N7kKaYUZpzSIM7U7nkvalKKxmdvFnh27Pd76CJY/vbYSs84+SeLWvu9OqZCGjTS/8kVLNnX7uunEMw9e5XnDr4EZg4OWYi5bS0FYr/abTUCdybnHNKAhkKxVwVExBAqQWBK5JjQVF8CJnbEoDeT6X1J0O3Ep2n0RcKxQZzvWirOM9c0l0pmCPaSllrW4AdGZ7s+U42SA1S7nKQJLLNmPkepraIfNwEt5223mpWXKEbfgCiYBkQa0022biEtWDX97Wm34YRVN+dwW4GJlfJYj1LOek/pR6fA/Ffi66OgeaCTs0Md6eL50y6kfLxeEnOZ1+OUr88YYfUUD0m7iU2nTUQ0Sz04ihTALRbgudLyoh9PQsGndvvo0JNtUQLCD15A6sj50rmxP+5B3Dg8NfJ/dYW24rtD5Mcd5AiTcpGvhedvbLdFNPAPmQ4ZMeMPkix2VQ2hT87RRBkBA7ZSrYUUanYA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ca4dbf-9ba5-4d50-8b4b-08d87b5d7fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 16:21:17.9162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mF5qOwwrXpkqwO9K1JrCVS+lLuyxx3UR3GYnk6hwF817EoIM7VpylRjAm7WN2iIdpdFhfKVKV+rcv1v8Dm4glA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0156
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQphbWRncHUgYWN0dWFsbHkgcHJpbnRzIGl0IGFzIGhleDoNCnJl
dHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiUwMTZsbHhcbiIsIGFkZXYtPnVuaXF1ZV9p
ZCk7DQoNCkJ1dCBlaXRoZXIgd2F5LCB3ZSBjYW4gYWRkcmVzcyBpdCBpbiByb2NtaW5mbyBpZiBh
bnlvbmUgY29tcGxhaW5zLiBUaGFua3MgZm9yIHRoZSByZXZpZXchDQoNCiBLZW50DQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjgsIDIwMjAgMTI6
MTEgUE0NCj4gVG86IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9h
bWRrZmQ6IENoYW5nZSB1bmlxdWVfaWQgdG8gcHJpbnQgaGV4IGZvcm1hdA0KPiANCj4gU28gcm9j
bS1zbWkgcmVhZHMgdGhlIGRlY2ltYWwgYW5kIGNvbnZlcnRzIGl0IHRvIGhleD8gVGhlbiBjaGFu
Z2luZyBLRkQNCj4gd2lsbCBicmVhayByb2NtLXNtaS4gSWYgeW91IHdhbnQgdG8gZml4IHJvY21p
bmZvLCB5b3UnbGwgbmVlZCB0byBmaXggaXQNCj4gaW4gdGhlIHJvY21pbmZvIGNvZGUgdG8gZG8g
dGhlIGNvbnZlcnNpb24gdG8gaGV4Lg0KPiANCj4gUmVnYXJkcywNCj4gwqAgRmVsaXgNCj4gDQo+
IEFtIDIwMjAtMTAtMjggdW0gMTI6MDIgcC5tLiBzY2hyaWViIFJ1c3NlbGwsIEtlbnQ6DQo+ID4g
W0FNRCBQdWJsaWMgVXNlXQ0KPiA+DQo+ID4gcm9jbWluZm8gdXNlcyBpdCwgYnV0IHRoYXQncyBh
bGwgdGhhdCBJIGFtIGF3YXJlIG9mLiBJIGNhbiBkcm9wIHRoaXMgdGhvdWdoIGFuZCBzdGljayB3
aXRoDQo+IHBhdGNoMSwgSSBqdXN0IGRpZG4ndCBrbm93IGlmIHdlJ2QgZW5kIHVwIGdldHRpbmcg
Y29tcGxhaW50cyBvZjoNCj4gPiAiV2VsbCwgcm9jbS1zbWkgKGFtZGdwdSkgc2F5cyB0aGF0IHRo
ZSB1bmlxdWVfaWQgaXMgRiwgd2hpbGUgcm9jbWluZm8gKGFtZGtmZCkgc2F5cyB0aGF0DQo+IHRo
ZSB1bmlxdWVfaWQgaXMgMTYiIC4gUHJvYmFibHkgdG9vIGxhdGUgdG8gdHJ5IHRvIGNoYW5nZSBp
dCBub3cgdGhvdWdoLCBhcyB5b3UgcG9pbnRlZCBvdXQuDQo+ID4NCj4gPiAgS2VudA0KPiA+DQo+
ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEt1ZWhsaW5nLCBGZWxp
eCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDI4LCAyMDIwIDExOjU1IEFNDQo+ID4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMi8yXSBkcm0vYW1ka2ZkOiBDaGFuZ2UgdW5pcXVlX2lkIHRvIHByaW50IGhleCBm
b3JtYXQNCj4gPj4NCj4gPj4gVGhpcyBpcyBhbiBBQkktYnJlYWtpbmcgY2hhbmdlLiBJcyBhbnkg
dXNlciBtb2RlIGNvZGUgdXNpbmcgdGhpcyBhbHJlYWR5Pw0KPiA+Pg0KPiA+PiBSZWdhcmRzLA0K
PiA+PiDCoCBGZWxpeA0KPiA+Pg0KPiA+PiBBbSAyMDIwLTEwLTI4IHVtIDExOjIyIGEubS4gc2No
cmllYiBLZW50IFJ1c3NlbGw6DQo+ID4+PiBhbWRncHUncyB1bmlxdWVfaWQgcHJpbnRzIGluIGhl
eCBmb3JtYXQsIHNvIGNoYW5nZSB0b3BvbG9neSdzIHByaW50b3V0DQo+ID4+PiB0byBoZXggYnkg
YWRkaW5nIGEgbmV3IHN5c2ZzX3ByaW50IG1hY3JvIHNwZWNpZmljYWxseSBmb3IgaGV4IG91dHB1
dCwNCj4gPj4+IGFuZCB1c2UgaXQgZm9yIHVuaXF1ZV9pZA0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1v
ZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4g
Pj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDQgKysrLQ0K
PiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Rv
cG9sb2d5LmMNCj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3ku
Yw0KPiA+Pj4gaW5kZXggYTNmYzIzODczODE5Li5kMTNjNjhjNTJiYmMgMTAwNjQ0DQo+ID4+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPiA+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCj4gPj4+IEBAIC0y
MTcsNiArMjE3LDggQEAgc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmtmZF9jcmVhdGVfdG9w
b2xvZ3lfZGV2aWNlKA0KPiA+Pj4gIAkJc3lzZnNfc2hvd19nZW5fcHJvcChidWZmZXIsIG9mZnMs
ICIlcyAldVxuIiwgbmFtZSwgdmFsdWUpDQo+ID4+PiAgI2RlZmluZSBzeXNmc19zaG93XzY0Yml0
X3Byb3AoYnVmZmVyLCBvZmZzLCBuYW1lLCB2YWx1ZSkgXA0KPiA+Pj4gIAkJc3lzZnNfc2hvd19n
ZW5fcHJvcChidWZmZXIsIG9mZnMsICIlcyAlbGx1XG4iLCBuYW1lLCB2YWx1ZSkNCj4gPj4+ICsj
ZGVmaW5lIHN5c2ZzX3Nob3dfNjRiaXRfcHJvcF9oZXgoYnVmZmVyLCBvZmZzLCBuYW1lLCB2YWx1
ZSkgXA0KPiA+Pj4gKwkJc3lzZnNfc2hvd19nZW5fcHJvcChidWZmZXIsIG9mZnMsICIlcyAlbGx4
XG4iLCBuYW1lLCB2YWx1ZSkNCj4gPj4+ICAjZGVmaW5lIHN5c2ZzX3Nob3dfMzJiaXRfdmFsKGJ1
ZmZlciwgb2ZmcywgdmFsdWUpIFwNCj4gPj4+ICAJCXN5c2ZzX3Nob3dfZ2VuX3Byb3AoYnVmZmVy
LCBvZmZzLCAiJXVcbiIsIHZhbHVlKQ0KPiA+Pj4gICNkZWZpbmUgc3lzZnNfc2hvd19zdHJfdmFs
KGJ1ZmZlciwgb2ZmcywgdmFsdWUpIFwNCj4gPj4+IEBAIC00OTcsNyArNDk5LDcgQEAgc3RhdGlj
IHNzaXplX3Qgbm9kZV9zaG93KHN0cnVjdCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3QgYXR0cmlidXRl
DQo+ID4+ICphdHRyLA0KPiA+Pj4gIAkJCSAgICAgIGRldi0+bm9kZV9wcm9wcy5udW1fc2RtYV9x
dWV1ZXNfcGVyX2VuZ2luZSk7DQo+ID4+PiAgCXN5c2ZzX3Nob3dfMzJiaXRfcHJvcChidWZmZXIs
IG9mZnMsICJudW1fY3BfcXVldWVzIiwNCj4gPj4+ICAJCQkgICAgICBkZXYtPm5vZGVfcHJvcHMu
bnVtX2NwX3F1ZXVlcyk7DQo+ID4+PiAtCXN5c2ZzX3Nob3dfNjRiaXRfcHJvcChidWZmZXIsIG9m
ZnMsICJ1bmlxdWVfaWQiLA0KPiA+Pj4gKwlzeXNmc19zaG93XzY0Yml0X3Byb3BfaGV4KGJ1ZmZl
ciwgb2ZmcywgInVuaXF1ZV9pZCIsDQo+ID4+PiAgCQkJICAgICAgZGV2LT5ub2RlX3Byb3BzLnVu
aXF1ZV9pZCk7DQo+ID4+Pg0KPiA+Pj4gIAlpZiAoZGV2LT5ncHUpIHsNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
