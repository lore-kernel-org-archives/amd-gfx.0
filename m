Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878CACA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 15:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C9D2086D
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 15:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C9D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039726EEDB;
	Thu, 31 Oct 2019 15:40:17 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750058.outbound.protection.outlook.com [40.107.75.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4F76EEDB
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 15:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLBMJR+APPxRBYk5StvK8Id46asn6wkjmL8jBKtLlMukH6858JITdiHGLD7R0vytQDoO93BGUkkeEOpxCQqlw1tNLmWo2+Kcq3QMpvekvBUmLaIeLVFAVwDJs0QxGk/OZKFwhbDDpIospLB+lHI7F7lz9M2/GH7RYSgHSBW6AFf2yi2zbOsKoxReLJf5xy6cWurch/uvqPOKLSQVbt1paDWDptV3bhrG+GG9vmp4R+tS42/mR+Z2j47r2WtwEmtskwirP9t5fQMmpDf/ErJSv+StINXU2kXqutaTGadAFonxB4WubrOXHzoa+szRaswh8PkXYVfXY3gvzQSFCXRnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuM6AckWqAo2coK0nfIj8QFtP8oxlFSOD2imj5a/1hE=;
 b=PGxNZAbJnH7jRdlSDk3iRa4GNPNezLd4S+BIrMyi1QTQL7JY748UNgiqnSC3Y1conN4DTShl/w7nIe/RLVDS6I7fFVhHQzgb3EHCIvkq2CoSM8pJoFPfZUDCl9XdN0g607MF++o79SuY4neYaBL8FJGjrBtB3eNgSc0vuwf7YvAYfOa8822xDJYm0otf9gwZL28h9nJG0BXboSOa8DZcXLzREF+BdcHbeDC/8ZjANQqFwn3XbBDzJmgUaLoMiFNsCa2NZjUXYyKypuNZHOk0EQ/Kel4E4Y1aRw8fJe26bcLGah/YIRIdvk9hmowoLhbR/Ai3cs8QJC6p4ctmeNmUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2820.namprd12.prod.outlook.com (20.177.240.11) by
 BL0PR12MB2403.namprd12.prod.outlook.com (52.132.28.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Thu, 31 Oct 2019 15:40:13 +0000
Received: from BL0PR12MB2820.namprd12.prod.outlook.com
 ([fe80::8fc:ab39:3d9d:afc]) by BL0PR12MB2820.namprd12.prod.outlook.com
 ([fe80::8fc:ab39:3d9d:afc%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 15:40:13 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu, Hersen"
 <hersenxs.wu@amd.com>
Subject: RE: [PATCH 01/11] drm/amdgpu: Add ucode support for DMCUB
Thread-Topic: [PATCH 01/11] drm/amdgpu: Add ucode support for DMCUB
Thread-Index: AQHVjZk8jwH04m+Vvky3Sbqw/NXaX6d05gRw
Date: Thu, 31 Oct 2019 15:40:13 +0000
Message-ID:
 <BL0PR12MB28206F7609F85CC61124168689630@BL0PR12MB2820.namprd12.prod.outlook.com>
References: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
 <20191028140837.7908-2-nicholas.kazlauskas@amd.com>
In-Reply-To: <20191028140837.7908-2-nicholas.kazlauskas@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8806f9ae-a963-4d61-31a3-08d75e189ee0
x-ms-traffictypediagnostic: BL0PR12MB2403:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2403484095FDE682D0B754BA89630@BL0PR12MB2403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(13464003)(52536014)(966005)(446003)(11346002)(99286004)(66066001)(102836004)(86362001)(186003)(26005)(53546011)(486006)(6436002)(55016002)(6306002)(2501003)(6506007)(14454004)(5660300002)(66476007)(66556008)(66446008)(66946007)(76116006)(7696005)(76176011)(64756008)(9686003)(33656002)(478600001)(229853002)(7736002)(316002)(71200400001)(3846002)(6116002)(14444005)(256004)(4326008)(110136005)(305945005)(71190400001)(476003)(6636002)(54906003)(2906002)(6246003)(8676002)(74316002)(81166006)(81156014)(8936002)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2403;
 H:BL0PR12MB2820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zwBQT2lQrBzM/7IusaaOsTHnxQqrgd5ett6igjvxXRcQVZEmLqHyTqZDTwswHT7JZJhzIFHJBTEh/EMP3kZgl+JbnK6uEWbofPEZKMo9aFs8E2fCyjUwNsYyZqpbpMNqlDl2Jj9kUxlAw7CjL7vctGvww3pR1C4XZgurqecpgNtN+RSzfJ6zZ8mUxz2K8+5am14WOaROxgGvpAuwyPMPDcUd+eTmvV42AcuJAE6RLgElAknWUNgq0HyfDnquDgsQ03VP6sLy/6ItBSBUijpgz5sV/wj26MrRxfCyKSj871TYNRazaxtAWFgQk6Ms/fybd0z8duDYHHYHZ51MxbMHVRATKxifxOy2W9gUAMmU8c7nTftjh8NBj6DjxQDW2Vjy/yjB5ZmKWq4iHR1WnfzrYP9/RIX9rDO40GP9N6XUur+84kg0iyEgwl+R1lkq3LWJWNcQFRIMJYO5KHi8a7QkMtYaU3uLYeM7o39HvVyLIGU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8806f9ae-a963-4d61-31a3-08d75e189ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 15:40:13.1734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6w9LQEY3lSz+8kNM+DK1kQnvU2vBCpapWlX6z3LTH53O5DkFR9S2Zon1knFQKki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2403
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuM6AckWqAo2coK0nfIj8QFtP8oxlFSOD2imj5a/1hE=;
 b=3OGW4iate8Cfi7YSaJc3wxPqFzUW9kwJgqOEHB5deyUX2JVjq6OfNFESYPEJVHnOEBa9N/iWYBpnTcHBUoxbB0kOtEhybPYlfxYN6YHbiBgfHGk3gWxNCqP3Po0SsLNDXsKPFtihBKgGsBJkmsKLzkNd9mZyBTOvmZpIc4H0IEo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Roman.Li@amd.com; 
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031154013.K-kfMvFj8LLVpTKYAYrlljoaUW947ssWMckl4K8mGk4@z>

T24gQmVoYWxmICBPZjogSGVyc2VuIFd1DQpTZXJpZXMgaXM6DQpSZXZpZXdlZC1ieTogSGVyc2Vu
IFd1IDxoZXJzZW54cy53dUBhbWQuY29tPg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24g
QmVoYWxmIE9mIE5pY2hvbGFzIEthemxhdXNrYXMNClNlbnQ6IE1vbmRheSwgT2N0b2JlciAyOCwg
MjAxOSAxMDowOCBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogS2F6
bGF1c2thcywgTmljaG9sYXMgPE5pY2hvbGFzLkthemxhdXNrYXNAYW1kLmNvbT4NClN1YmplY3Q6
IFtQQVRDSCAwMS8xMV0gZHJtL2FtZGdwdTogQWRkIHVjb2RlIHN1cHBvcnQgZm9yIERNQ1VCDQoN
ClRoZSBETUNVQiBpcyBhIHNlY29uZGFyeSBETUNVIChEaXNwbGF5IE1pY3JvQ29udHJvbGxlciBV
bml0KSB0aGF0IGhhcyBpdHMgb3duIHNlcGFyYXRlIGZpcm13YXJlLiBJdCdzIHJlcXVpcmVkIGZv
ciBETUNVIHN1cHBvcnQgb24gUmVub2lyLg0KDQpTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBLYXps
YXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYyB8IDExICsrKysrKysrKystICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuaCB8ICA5ICsrKysrKysrKw0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdWNvZGUuYw0KaW5kZXggODMzZmM0YjY4OTQwLi45ZWYzMTI0
MjgyMzEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNv
ZGUuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMNCkBA
IC00NDcsNiArNDQ3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdWNvZGVfaW5pdF9zaW5nbGVfZnco
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogCWNvbnN0IHN0cnVjdCBjb21tb25fZmlybXdh
cmVfaGVhZGVyICpoZWFkZXIgPSBOVUxMOw0KIAljb25zdCBzdHJ1Y3QgZ2Z4X2Zpcm13YXJlX2hl
YWRlcl92MV8wICpjcF9oZHIgPSBOVUxMOw0KIAljb25zdCBzdHJ1Y3QgZG1jdV9maXJtd2FyZV9o
ZWFkZXJfdjFfMCAqZG1jdV9oZHIgPSBOVUxMOw0KKwljb25zdCBzdHJ1Y3QgZG1jdWJfZmlybXdh
cmVfaGVhZGVyX3YxXzAgKmRtY3ViX2hkciA9IE5VTEw7DQogDQogCWlmIChOVUxMID09IHVjb2Rl
LT5mdykNCiAJCXJldHVybiAwOw0KQEAgLTQ2MCw2ICs0NjEsNyBAQCBzdGF0aWMgaW50IGFtZGdw
dV91Y29kZV9pbml0X3NpbmdsZV9mdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJaGVh
ZGVyID0gKGNvbnN0IHN0cnVjdCBjb21tb25fZmlybXdhcmVfaGVhZGVyICopdWNvZGUtPmZ3LT5k
YXRhOw0KIAljcF9oZHIgPSAoY29uc3Qgc3RydWN0IGdmeF9maXJtd2FyZV9oZWFkZXJfdjFfMCAq
KXVjb2RlLT5mdy0+ZGF0YTsNCiAJZG1jdV9oZHIgPSAoY29uc3Qgc3RydWN0IGRtY3VfZmlybXdh
cmVfaGVhZGVyX3YxXzAgKil1Y29kZS0+ZnctPmRhdGE7DQorCWRtY3ViX2hkciA9IChjb25zdCBz
dHJ1Y3QgZG1jdWJfZmlybXdhcmVfaGVhZGVyX3YxXzAgDQorKil1Y29kZS0+ZnctPmRhdGE7DQog
DQogCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgIT0gQU1ER1BVX0ZXX0xPQURfUFNQIHx8
DQogCSAgICAodWNvZGUtPnVjb2RlX2lkICE9IEFNREdQVV9VQ09ERV9JRF9DUF9NRUMxICYmIEBA
IC00NzAsNyArNDcyLDggQEAgc3RhdGljIGludCBhbWRncHVfdWNvZGVfaW5pdF9zaW5nbGVfZnco
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQogCSAgICAgdWNvZGUtPnVjb2RlX2lkICE9IEFN
REdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX0dQTV9NRU0gJiYNCiAJICAgICB1Y29kZS0+
dWNvZGVfaWQgIT0gQU1ER1BVX1VDT0RFX0lEX1JMQ19SRVNUT1JFX0xJU1RfU1JNX01FTSAmJg0K
IAkJIHVjb2RlLT51Y29kZV9pZCAhPSBBTURHUFVfVUNPREVfSURfRE1DVV9FUkFNICYmDQotCQkg
dWNvZGUtPnVjb2RlX2lkICE9IEFNREdQVV9VQ09ERV9JRF9ETUNVX0lOVFYpKSB7DQorCQkgdWNv
ZGUtPnVjb2RlX2lkICE9IEFNREdQVV9VQ09ERV9JRF9ETUNVX0lOVFYgJiYNCisJCSB1Y29kZS0+
dWNvZGVfaWQgIT0gQU1ER1BVX1VDT0RFX0lEX0RNQ1VCKSkgew0KIAkJdWNvZGUtPnVjb2RlX3Np
emUgPSBsZTMyX3RvX2NwdShoZWFkZXItPnVjb2RlX3NpemVfYnl0ZXMpOw0KIA0KIAkJbWVtY3B5
KHVjb2RlLT5rYWRkciwgKHZvaWQgKikoKHVpbnQ4X3QgKil1Y29kZS0+ZnctPmRhdGEgKyBAQCAt
NTA2LDYgKzUwOSwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV91Y29kZV9pbml0X3NpbmdsZV9mdyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJCQkJCSAgICAgIGxlMzJfdG9fY3B1KGhlYWRl
ci0+dWNvZGVfYXJyYXlfb2Zmc2V0X2J5dGVzKSArDQogCQkJCQkgICAgICBsZTMyX3RvX2NwdShk
bWN1X2hkci0+aW50dl9vZmZzZXRfYnl0ZXMpKSwNCiAJCSAgICAgICB1Y29kZS0+dWNvZGVfc2l6
ZSk7DQorCX0gZWxzZSBpZiAodWNvZGUtPnVjb2RlX2lkID09IEFNREdQVV9VQ09ERV9JRF9ETUNV
Qikgew0KKwkJdWNvZGUtPnVjb2RlX3NpemUgPSBsZTMyX3RvX2NwdShkbWN1Yl9oZHItPmluc3Rf
Y29uc3RfYnl0ZXMpOw0KKwkJbWVtY3B5KHVjb2RlLT5rYWRkciwNCisJCSAgICAgICAodm9pZCAq
KSgodWludDhfdCAqKXVjb2RlLT5mdy0+ZGF0YSArDQorCQkJCWxlMzJfdG9fY3B1KGhlYWRlci0+
dWNvZGVfYXJyYXlfb2Zmc2V0X2J5dGVzKSksDQorCQkgICAgICAgdWNvZGUtPnVjb2RlX3NpemUp
Ow0KIAl9IGVsc2UgaWYgKHVjb2RlLT51Y29kZV9pZCA9PSBBTURHUFVfVUNPREVfSURfUkxDX1JF
U1RPUkVfTElTVF9DTlRMKSB7DQogCQl1Y29kZS0+dWNvZGVfc2l6ZSA9IGFkZXYtPmdmeC5ybGMu
c2F2ZV9yZXN0b3JlX2xpc3RfY250bF9zaXplX2J5dGVzOw0KIAkJbWVtY3B5KHVjb2RlLT5rYWRk
ciwgYWRldi0+Z2Z4LnJsYy5zYXZlX3Jlc3RvcmVfbGlzdF9jbnRsLA0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmgNCmluZGV4IDQxMDU4N2I5NTBmMy4uZWFmMmQ1Yjlj
OTJmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2Rl
LmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5oDQpAQCAt
MjUxLDYgKzI1MSwxMyBAQCBzdHJ1Y3QgZG1jdV9maXJtd2FyZV9oZWFkZXJfdjFfMCB7DQogCXVp
bnQzMl90IGludHZfc2l6ZV9ieXRlczsgIC8qIHNpemUgb2YgaW50ZXJydXB0IHZlY3RvcnMsIGlu
IGJ5dGVzICovICB9Ow0KIA0KKy8qIHZlcnNpb25fbWFqb3I9MSwgdmVyc2lvbl9taW5vcj0wICov
DQorc3RydWN0IGRtY3ViX2Zpcm13YXJlX2hlYWRlcl92MV8wIHsNCisJc3RydWN0IGNvbW1vbl9m
aXJtd2FyZV9oZWFkZXIgaGVhZGVyOw0KKwl1aW50MzJfdCBpbnN0X2NvbnN0X2J5dGVzOyAvKiBz
aXplIG9mIGluc3RydWN0aW9uIHJlZ2lvbiwgaW4gYnl0ZXMgKi8NCisJdWludDMyX3QgYnNzX2Rh
dGFfYnl0ZXM7IC8qIHNpemUgb2YgYnNzL2RhdGEgcmVnaW9uLCBpbiBieXRlcyAqLyB9Ow0KKw0K
IC8qIGhlYWRlciBpcyBmaXhlZCBzaXplICovDQogdW5pb24gYW1kZ3B1X2Zpcm13YXJlX2hlYWRl
ciB7DQogCXN0cnVjdCBjb21tb25fZmlybXdhcmVfaGVhZGVyIGNvbW1vbjsNCkBAIC0yNjgsNiAr
Mjc1LDcgQEAgdW5pb24gYW1kZ3B1X2Zpcm13YXJlX2hlYWRlciB7DQogCXN0cnVjdCBzZG1hX2Zp
cm13YXJlX2hlYWRlcl92MV8xIHNkbWFfdjFfMTsNCiAJc3RydWN0IGdwdV9pbmZvX2Zpcm13YXJl
X2hlYWRlcl92MV8wIGdwdV9pbmZvOw0KIAlzdHJ1Y3QgZG1jdV9maXJtd2FyZV9oZWFkZXJfdjFf
MCBkbWN1Ow0KKwlzdHJ1Y3QgZG1jdWJfZmlybXdhcmVfaGVhZGVyX3YxXzAgZG1jdWI7DQogCXVp
bnQ4X3QgcmF3WzB4MTAwXTsNCiB9Ow0KIA0KQEAgLTMwNyw2ICszMTUsNyBAQCBlbnVtIEFNREdQ
VV9VQ09ERV9JRCB7DQogCUFNREdQVV9VQ09ERV9JRF9ETUNVX0lOVFYsDQogCUFNREdQVV9VQ09E
RV9JRF9WQ04wX1JBTSwNCiAJQU1ER1BVX1VDT0RFX0lEX1ZDTjFfUkFNLA0KKwlBTURHUFVfVUNP
REVfSURfRE1DVUIsDQogCUFNREdQVV9VQ09ERV9JRF9NQVhJTVVNLA0KIH07DQogDQotLQ0KMi4y
MC4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQph
bWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
