Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3D6C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069AD2078E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J6rXykMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069AD2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F856E922;
	Wed,  2 Sep 2020 14:53:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B14C6E922
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 14:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtlP5V8q0kMuMAmFihGt6P+HtIyKJhQ9nzneMyUvdYqO5bOHO40E1oIr4GJN1SRrdSTmPW9g6phSrLfq1brfQshlByCL3fz+2L/MN4MWJMI0k4+U3x2L6QlqKNhGH2OZtCs95DDOehmF8SQgGs7jqCimXmhe87FyyfrJIecIBKAHmJH+Vm66cnCrbhxnD3in72t6qfpSJ+yA0sqfZ8yBiBvQ8hmtv6nqVKcI3qqojc52TCJcRYbTNbmhxMt9cz8dXZNkcF2OdbGh2f/4TMdrkzg9u8MX9idbchsaOaiyy8H0ndWqgw+XTm3R7VHvnzBvHB4pv6mkrUS/HgJqN0R7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fzxos8vrsmFikKSq8+Yv2ki2UKikdfe5FRRk6zgHdM=;
 b=JzS7PDctJGmGV/DrRT007TSlf+N+c4Ubz+I6iLzP2wYr0bmHTyfUObULcj1OAnOweZo3T/QLumVSdho2Dlu9suusmbNmkKfmlIyPhcAXOfiMuazt6NWRyjrtwAPbQqDu2903eya9D+Azd1ajBrKJpUPVRf9qaiWGE/UJYnV4gnVuRrHGvi3omljqVGToyQ6hS+i/vXSTWaIs7u1J15TfbUAkTAjc8VEBSJhmzNUxrY87MptKNkdVLHEm06qDcVbAG523INiiE4aZI95hSAUgPYjAIdplA9cLx0kSv1mqCwY+djh8DkZRXkmNIoIN88QMZo3qSRNbIk9nRlBhRFNLzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fzxos8vrsmFikKSq8+Yv2ki2UKikdfe5FRRk6zgHdM=;
 b=J6rXykMiCCDB/Mrv2eI9ryD7Ufn7D/LL5TSg4DaquLzMub9smfYIsmFsD/nTfTCoWJq09k72FNTq1EPYivyDF7TJ1f/NOym0AYKvTdDfMySxH8MVj/RUviFI6Sayx3cHjo7Qi7zAZED74+p1SDx+tu/stqfhjt3L/T+lqv1Kuyw=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:53:44 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:53:44 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation v2
Thread-Topic: [PATCH] drm/amdgpu: fix max_entries calculation v2
Thread-Index: AQHWgTIXDYvSlzx81kCL6VB9kFKcI6lVZ9sAgAABSQCAAAYqAA==
Date: Wed, 2 Sep 2020 14:53:44 +0000
Message-ID: <D6AE689D-F89B-484C-9591-B8C4EEF56393@amd.com>
References: <20200902140512.2343-1-christian.koenig@amd.com>
 <32A985F3-1C3B-45E4-B90F-7C023CCE7B71@amd.com>
 <98a58d52-81a3-c7de-f848-e612c1f52e59@gmail.com>
In-Reply-To: <98a58d52-81a3-c7de-f848-e612c1f52e59@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52c24e7c-16b4-40b5-309c-08d84f4ffd89
x-ms-traffictypediagnostic: SA0PR12MB4528:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4528708AE80C72DD350791E7872F0@SA0PR12MB4528.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FxK5LZ9nD7CeFQASdQiTIV16xn/vgPXtf0Dhw8WZfLHbop10pbbHbLpALFHO7Q30OPkpeDjxIgbbJFi5m923HDuqdJKtl9324vc3UoDG3Wh0uW1peHuwN3RrjdgP4VdcdK46/CP13tr2pQnZ7pcniaI7l2387cCYb8GinChirtK4bmV65EcGkq6YxyHsPV05TJsJyBdb7TYRu8/Kg4JDH5Bi4cSsqe4cZWF1EFZYkP7Tywx6MVWiB3s+eB5h85aEaHm3/kKVLLud8nasMKzjFFvl78SDrojXBnNjhT4oCpvOW+vSa7jG91d6ruOk1jmxMBISwQnMO5W0BfkGYcN5cQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(26005)(37006003)(66446008)(76116006)(54906003)(66946007)(8936002)(66556008)(64756008)(33656002)(66574015)(91956017)(4326008)(66476007)(83380400001)(2616005)(6636002)(6506007)(186003)(316002)(86362001)(36756003)(478600001)(5660300002)(2906002)(6486002)(6862004)(6512007)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HJooywqXQe5PlgP/md81F40tfL6m7fvu37di8UVu0gkXpnZqx2lkTasW0aUHZV/EO7n8Gw700E+KUbgAjpGYLalY+fgIf3vBrYr0UfDF2b8E2H8jMR7AHOJkV6KSzk98cirwhW47vFkJF8WYm6W5ZeVVf/7CghziagbGtfOhcSJgT61ps8HJvJtMm+zUI1NZCtSFFBHMkXmyS9xBbD1VcZIvN0kyU3aZCv4rJPad3fuhymMHH7135mzvmAgLnSvgk8l3p3d5qpENN64DaHX6FXlN8o64KPaoCk9lCGdy2Ws971qdiXxqZB75OyBqiTZerCbT0lueh8fpxCbz2BQ/bLIVHEYZ8USpBn1kaBQfUCbvgAj+7O+V6ajXogSNLpbwYgRHEXUxom/Hq/pQLgAx7KLmvePj1FUvg2a+h58CYZD14cm/yIjsQioF1PB+J9hiT7fiZwHGgtvrXKyxtBFeIRR+9x7NwdIYRFAxR+67og9yTSHYPNJCWGMo6ZqJIMMbXujACjaJLBkp6sLBm/BXZFv4Scbzl80rxKtH1u6X7bvDBon0QiuL7Ivo6wojuxvKnDBKxU39Noze5csGmsm8d5w8R+vEhFH8QiK4XNWYtLYY2rFSSLdk5vMh6MQjng20uJBRjOjtsbUzYdlMORAhzA==
Content-ID: <AB16508BDD00554DB12112717E4C287F@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c24e7c-16b4-40b5-309c-08d84f4ffd89
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 14:53:44.6493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maGKIpMS2LQw1tRO3fQyvALv37esU/GczKz7eszkrSDiuLRpNAogF1FeXACXr7LA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMOW5tDnmnIgy5pelIDIyOjMx77yMQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IOWGmemBk++8mg0KPiANCj4gQW0gMDIuMDkuMjAgdW0g
MTY6Mjcgc2NocmllYiBQYW4sIFhpbmh1aToNCj4+IA0KPj4+IDIwMjDlubQ55pyIMuaXpSAyMjow
Ne+8jENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiDl
hpnpgZPvvJoNCj4+PiANCj4+PiBDYWxjdWxhdGUgdGhlIGNvcnJlY3QgdmFsdWUgZm9yIG1heF9l
bnRyaWVzIG9yIHdlIG1pZ2h0IHJ1biBhZnRlciB0aGUNCj4+PiBwYWdlX2FkZHJlc3MgYXJyYXku
DQo+Pj4gDQo+Pj4gdjI6IFhpbmh1aSBwb2ludGVkIG91dCB3ZSBkb24ndCBuZWVkIHRoZSBzaGlm
dA0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4+PiBGaXhlczogMWU2OTFlMjQ0NDg3IGRybS9hbWRncHU6IHN0b3Ag
YWxsb2NhdGluZyBkdW1teSBHVFQgbm9kZXMNCj4+PiAtLS0NCj4+PiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYw0KPj4+IGluZGV4IDhiYzIyNTM5MzliZS4uYmU4ODZiZGNhNWM2IDEwMDY0
NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+PiBAQCAtMTY5
Nyw3ICsxNjk3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fc3BsaXRfbWFwcGluZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+PiAJCQkJQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVf
UEFHRTsNCj4+PiAJCX0gZWxzZSB7DQo+Pj4gCQkJYWRkciA9IDA7DQo+Pj4gLQkJCW1heF9lbnRy
aWVzID0gUzY0X01BWDsNCj4+PiArCQkJbWF4X2VudHJpZXMgPSBtYXBwaW5nLT5sYXN0IC0gbWFw
cGluZy0+c3RhcnQgKyAxOw0KPj4gWW91IG5lZWQgbWludXMgcGZuIGhlcmUuDQo+IA0KPiBUaGF0
IGRvZXNuJ3Qgc291bmQgY29ycmVjdCBlaXRoZXIuIFRoZSBwZm4gaXMgdGhlIGRlc3RpbmF0aW9u
IG9mIHRoZSBtYXBwaW5nLCBlLmcuIHRoZSBvZmZzZXQgaW5zaWRlIHRoZSBCTyBhbmQgbm90IHJl
bGF0ZWQgdG8gdGhlIHZpcnR1YWwgYWRkcmVzcyByYW5nZSB3ZSBtYXAuDQoNCkkgbWVhbiB3ZSBu
ZWVkIG1pbnVzIHBmbiB0b28uIHBmbiBpcyBtYXBwaW5nLT5vZmZzZXQgPj4gUEFHRV9TSElGVC4N
Cg0KSW4gYW1kZ3B1X3ZtX2JvX21hcCgpLCB0aGVyZSBpcyBhIGNoZWNrICBiZWxvdw0KaWYgKGJv
ICYmIG9mZnNldCArIHNpemUgPiBhbWRncHVfYm9fc2l6ZShibykpDQpyZXR1cm4gLUVJTlZBTDsN
CnNvIG1hcHBpbmctPm9mZnNldCBpcyBqdXN0IGFuIG9mZnNldF9pbl9ieXRlcyBpbnNpZGUgdGhl
IEJPIGFzIHlvdSBzYWlkLiANCg0KbWFwcGluZy0+c3RhcnQgYW5kIG1hcHBpbmctPmxhc3QgYXJl
IHZpcnR1YWwgYWRkcmVzc2VzIGluIHBmbnMsIHRoZSByYW5nZSB3ZSBhcmUgZ29pbmcgdG8gdG91
Y2ggdGhlbiBpcyBbc3RhcnQrIG9mZnNldF9pbl9wZm5zLCBsYXN0XS4NCg0KPiANCj4+IFRoZSBy
YW5nZSB3ZSBhcmUgZ29pbmcgdG8gdG91Y2ggaXMgW3N0YXJ0ICsgb2Zmc2V0LCBsYXN0XS4NCj4+
IHNvIHRoZSBtYXhfZW50cmllcyBpcyBsYXN0IC0gKHN0YXJ0ICsgb2Zmc2V0KSArIDEuIGFuZCBv
ZmZzZXQgaXMgcGZuIGluIHRoaXMgY2FzZS4NCj4+IA0KPj4gSSBzdGlsbCBoaXQgcGFuaWMgd2l0
aCB0aGlzIHBhdGNoIGluIHByYWN0aWNlLg0KPiANCj4gVGhhbmtzIGZvciB0ZXN0aW5nLCBJIHRo
aW5rIEkga25vdyB3aGF0IHRoZSBwcm9ibGVtIGlzLg0KPiANCj4gV2UgbmVlZCB0byBzdGFydCBp
bnN0ZWFkIG9mIG1hcHBpbmctPnN0YXJ0IG9yIG90aGVyd2lzZSB0aGUgdmFsdWVzIGlzIHRvIGxh
cmdlIGFmdGVyIHRoZSBmaXJzdCBpdGVyYXRpb24uDQo+IA0KPiBHaXZlIG1lIGEgc2Vjb25kIGZv
ciBhIHYzLg0KPiANCj4gQ2hyaXN0aWFuLg0KPiANCj4+IA0KPj4+IAkJfQ0KPj4+IA0KPj4+IAkJ
aWYgKHBhZ2VzX2FkZHIpIHsNCj4+PiAtLSANCj4+PiAyLjE3LjENCj4+PiANCj4gDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
