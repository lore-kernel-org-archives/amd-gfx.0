Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59B6CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FDC217D9
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FDC217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222F06F85F;
	Fri,  1 Nov 2019 20:10:35 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe49::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913AD6F85D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 20:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuheeJ3iXR+8sBCxSJpk3Dr8QyMSvbBM+0UANw4W7QyKO4t0xAPmfYXtBaEJrqlljKHmooE347A2q8EYgxy/tA1pUn4su01S4dEPTUopMIlNRy4UXnn0N2+8QTwoFrm6lPX3O3+VcigERnc75Vg2jFPoC9VKNn4IyJ8faQD1Oaig/a1uh43T/N9saUo+npxrfHkCWfK6RD94O6Sfc/TV95LT2eEnBvQSmKscMV8RcRbnf8esBerP/TMkSSKOyqg0Ijj8zVZeoRVW68Fvi76ms7/HGl1SFVbNcKnFK0F0MlVJV5NDc++n7l5ujm42yfQo/YRHbB0tHNaGTbUGRtd2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xkpflmrlf13S8+U7FgjGZy+v9vg/qetwrF3TKFPnii8=;
 b=CJgfk0ZgFPyzyxoaENGiUzt5LjN3clREEweYn+X8++TI9EMfOrv6vi4GjNmwYu7aoc6gR6zz//375o/B0GWT4rZAT9kmX2yE7bGBQ8iSNaiXTuVaDjqJxeeveRlZbyBPqxe3G1P9rI6qKzVdasSfaNsW9trdSyscyFXjUwZS6GYDIV/AhQ7RxOYK+INVH1CHyRxDOe5wZgqjZvEMwcKcLPLfeI1nIvIRECWrKVajvJtBc00WR3mg7USTljM+goIrbIit8/H3MwEMoEP6RX9UM/6nxXGJLrNCu5BDV7CZ6N7mA4fCaLpF4mfW0Zgf3k8JORFI6H9KoXFpsM569KsBGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3578.namprd12.prod.outlook.com (20.178.199.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 20:10:29 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 20:10:29 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: Use better name to indicate the offset is in
 dwords
Thread-Topic: [PATCH 1/2] drm/amdkfd: Use better name to indicate the offset
 is in dwords
Thread-Index: AQHVkPBoEeDjOva9dkmULH7KG05KPQ==
Date: Fri, 1 Nov 2019 20:10:29 +0000
Message-ID: <20191101201016.5973-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b561d9b-a2dc-42dc-917a-08d75f078a96
x-ms-traffictypediagnostic: DM6PR12MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3578C46E48E3F55EE0C4B3EEF0620@DM6PR12MB3578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(66476007)(66446008)(26005)(6506007)(102836004)(386003)(86362001)(5660300002)(6916009)(305945005)(7736002)(256004)(14444005)(2351001)(8936002)(8676002)(52116002)(186003)(50226002)(71190400001)(71200400001)(6486002)(478600001)(81166006)(6436002)(2906002)(476003)(5640700003)(6116002)(3846002)(1076003)(6512007)(99286004)(4326008)(2616005)(316002)(486006)(81156014)(25786009)(14454004)(66946007)(36756003)(64756008)(66556008)(66066001)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3578;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q1OtmNtRTQguAYyF9F0SDt9D2vNfaRxE0tnUFj0cf9S/NzYIBIBCsEiaI7EfeWlNsgxWyDGrCAR7CM74Occy6iZGp24qOofr7El7Icyl6Vdfi8hvS4Z2F5bWzfULi3RqkyHdKkATKaAtTL8qiOHYX9wbBS8wr02nYxPdfKtisxk3RIQf+IqGBNHOq8UFgKsESfQJVIBCSNK7kOEehSJ5AUdM+vTjzyMqjKV7tMdTZF3ujxyecbM1OjNif5iN+vyGRKlZ/Q/CWBsxtt4ussOR6rKnkSp+zj/KwsVyF3TtVNFHNv8+1tmEALrXmoePnqAE0gG7x69svipCmiOZX6L0NNtM045kjlDUuLqoX7OcBfKr2jaw2aBojTejBhyys1fKhiTNBe8pYi642jeEgN1mDd+4wUdKezmhwBe7E/hGl165HM6uE9mIM4478ITCWM8a
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b561d9b-a2dc-42dc-917a-08d75f078a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 20:10:29.2386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxPtPl6aSJAe9cj2mI5gm4SApl1ol1cz9/jgKNSX50FpqOfAmeE8QGl2dW5Ns7u4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xkpflmrlf13S8+U7FgjGZy+v9vg/qetwrF3TKFPnii8=;
 b=dwk0Rz0MxtSVRvmhSy6i4cJnAnXaqTV1e9QkMNXfvAUPFperruNnMvcjQlI4w9SSdbPokldXavX5Q/VHt1M7HCy8RxhUHx/rSNS/WvX3pU5z7NHTIRw/GSsCPK/WRgUPx/OxK4uqfFkcdAOyN6QQiU51pZkfPYfGawQQiAQEcQU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101201029.1KF94462sXkS765QBHBR5f3y24tZm7FXDk146i8ReLY@z>

Q2hhbmdlLUlkOiBJNzVkYTIzYmJhOTAyMzE3NjJjZjU4ZGEzMTcwZjViYjc3ZWNlNDVlZApTaWdu
ZWQtb2ZmLWJ5OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgotLS0KIC4uLi9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgIHwgIDIgKy0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kb29yYmVsbC5jICAgICAgICAgIHwgMTQgKysrKysrKy0t
LS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggICAgICAgICAgICAg
IHwgIDggKysrKy0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rl
dmljZV9xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2
aWNlX3F1ZXVlX21hbmFnZXIuYwppbmRleCA5ODRjMmYyYjI0YjYuLjQ1MDNmYjI2ZmU1YiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5h
Z2VyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9t
YW5hZ2VyLmMKQEAgLTE3MCw3ICsxNzAsNyBAQCBzdGF0aWMgaW50IGFsbG9jYXRlX2Rvb3JiZWxs
KHN0cnVjdCBxY21fcHJvY2Vzc19kZXZpY2UgKnFwZCwgc3RydWN0IHF1ZXVlICpxKQogCX0KIAog
CXEtPnByb3BlcnRpZXMuZG9vcmJlbGxfb2ZmID0KLQkJa2ZkX2Rvb3JiZWxsX2lkX3RvX29mZnNl
dChkZXYsIHEtPnByb2Nlc3MsCisJCWtmZF9nZXRfZG9vcmJlbGxfZHdfb2Zmc2V0X2Zyb21fYmFy
KGRldiwgcS0+cHJvY2VzcywKIAkJCQkJICBxLT5kb29yYmVsbF9pZCk7CiAKIAlyZXR1cm4gMDsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kb29yYmVsbC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rvb3JiZWxsLmMKaW5kZXggZWJlNzliZjAw
MTQ1Li5mOTA0MzU1YzQ0YTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kb29yYmVsbC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kb29y
YmVsbC5jCkBAIC05MSw3ICs5MSw3IEBAIGludCBrZmRfZG9vcmJlbGxfaW5pdChzdHJ1Y3Qga2Zk
X2RldiAqa2ZkKQogCWtmZC0+ZG9vcmJlbGxfYmFzZSA9IGtmZC0+c2hhcmVkX3Jlc291cmNlcy5k
b29yYmVsbF9waHlzaWNhbF9hZGRyZXNzICsKIAkJCQlkb29yYmVsbF9zdGFydF9vZmZzZXQ7CiAK
LQlrZmQtPmRvb3JiZWxsX2lkX29mZnNldCA9IGRvb3JiZWxsX3N0YXJ0X29mZnNldCAvIHNpemVv
Zih1MzIpOworCWtmZC0+ZG9vcmJlbGxfYmFzZV9kd19vZmZzZXQgPSBkb29yYmVsbF9zdGFydF9v
ZmZzZXQgLyBzaXplb2YodTMyKTsKIAogCWtmZC0+ZG9vcmJlbGxfa2VybmVsX3B0ciA9IGlvcmVt
YXAoa2ZkLT5kb29yYmVsbF9iYXNlLAogCQkJCQkgICBrZmRfZG9vcmJlbGxfcHJvY2Vzc19zbGlj
ZShrZmQpKTsKQEAgLTEwMyw4ICsxMDMsOCBAQCBpbnQga2ZkX2Rvb3JiZWxsX2luaXQoc3RydWN0
IGtmZF9kZXYgKmtmZCkKIAlwcl9kZWJ1ZygiZG9vcmJlbGwgYmFzZSAgICAgICAgICAgPT0gMHgl
MDhsWFxuIiwKIAkJCSh1aW50cHRyX3Qpa2ZkLT5kb29yYmVsbF9iYXNlKTsKIAotCXByX2RlYnVn
KCJkb29yYmVsbF9pZF9vZmZzZXQgICAgICA9PSAweCUwOGxYXG4iLAotCQkJa2ZkLT5kb29yYmVs
bF9pZF9vZmZzZXQpOworCXByX2RlYnVnKCJkb29yYmVsbF9iYXNlX2R3X29mZnNldCAgICAgID09
IDB4JTA4bFhcbiIsCisJCQlrZmQtPmRvb3JiZWxsX2Jhc2VfZHdfb2Zmc2V0KTsKIAogCXByX2Rl
YnVnKCJkb29yYmVsbF9wcm9jZXNzX2xpbWl0ICA9PSAweCUwOGxYXG4iLAogCQkJZG9vcmJlbGxf
cHJvY2Vzc19saW1pdCk7CkBAIC0xODUsNyArMTg1LDcgQEAgdm9pZCBfX2lvbWVtICprZmRfZ2V0
X2tlcm5lbF9kb29yYmVsbChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAogCSAqIENhbGN1bGF0aW5nIHRo
ZSBrZXJuZWwgZG9vcmJlbGwgb2Zmc2V0IHVzaW5nIHRoZSBmaXJzdAogCSAqIGRvb3JiZWxsIHBh
Z2UuCiAJICovCi0JKmRvb3JiZWxsX29mZiA9IGtmZC0+ZG9vcmJlbGxfaWRfb2Zmc2V0ICsgaW54
OworCSpkb29yYmVsbF9vZmYgPSBrZmQtPmRvb3JiZWxsX2Jhc2VfZHdfb2Zmc2V0ICsgaW54Owog
CiAJcHJfZGVidWcoIkdldCBrZXJuZWwgcXVldWUgZG9vcmJlbGxcbiIKIAkJCSIgICAgIGRvb3Ji
ZWxsIG9mZnNldCAgID09IDB4JTA4WFxuIgpAQCAtMjI1LDE3ICsyMjUsMTcgQEAgdm9pZCB3cml0
ZV9rZXJuZWxfZG9vcmJlbGw2NCh2b2lkIF9faW9tZW0gKmRiLCB1NjQgdmFsdWUpCiAJfQogfQog
Ci11bnNpZ25lZCBpbnQga2ZkX2Rvb3JiZWxsX2lkX3RvX29mZnNldChzdHJ1Y3Qga2ZkX2RldiAq
a2ZkLAordW5zaWduZWQgaW50IGtmZF9nZXRfZG9vcmJlbGxfZHdfb2Zmc2V0X2Zyb21fYmFyKHN0
cnVjdCBrZmRfZGV2ICprZmQsCiAJCQkJCXN0cnVjdCBrZmRfcHJvY2VzcyAqcHJvY2VzcywKIAkJ
CQkJdW5zaWduZWQgaW50IGRvb3JiZWxsX2lkKQogewogCS8qCi0JICogZG9vcmJlbGxfaWRfb2Zm
c2V0IGFjY291bnRzIGZvciBkb29yYmVsbHMgdGFrZW4gYnkgS0dELgorCSAqIGRvb3JiZWxsX2Jh
c2VfZHdfb2Zmc2V0IGFjY291bnRzIGZvciBkb29yYmVsbHMgdGFrZW4gYnkgS0dELgogCSAqIGlu
ZGV4ICoga2ZkX2Rvb3JiZWxsX3Byb2Nlc3Nfc2xpY2Uvc2l6ZW9mKHUzMikgYWRqdXN0cyB0bwog
CSAqIHRoZSBwcm9jZXNzJ3MgZG9vcmJlbGxzLiBUaGUgb2Zmc2V0IHJldHVybmVkIGlzIGluIGR3
b3JkCiAJICogdW5pdHMgcmVnYXJkbGVzcyBvZiB0aGUgQVNJQy1kZXBlbmRlbnQgZG9vcmJlbGwg
c2l6ZS4KIAkgKi8KLQlyZXR1cm4ga2ZkLT5kb29yYmVsbF9pZF9vZmZzZXQgKworCXJldHVybiBr
ZmQtPmRvb3JiZWxsX2Jhc2VfZHdfb2Zmc2V0ICsKIAkJcHJvY2Vzcy0+ZG9vcmJlbGxfaW5kZXgK
IAkJKiBrZmRfZG9vcmJlbGxfcHJvY2Vzc19zbGljZShrZmQpIC8gc2l6ZW9mKHUzMikgKwogCQlk
b29yYmVsbF9pZCAqIGtmZC0+ZGV2aWNlX2luZm8tPmRvb3JiZWxsX3NpemUgLyBzaXplb2YodTMy
KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCmluZGV4IDYyZGI0ZDIwZWQzMi4u
N2M1NjFjOThmMmUyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJpdi5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKQEAgLTIz
OCw5ICsyMzgsOSBAQCBzdHJ1Y3Qga2ZkX2RldiB7CiAJCQkJCSAqIEtGRC4gSXQgaXMgYWxpZ25l
ZCBmb3IgbWFwcGluZwogCQkJCQkgKiBpbnRvIHVzZXIgbW9kZQogCQkJCQkgKi8KLQlzaXplX3Qg
ZG9vcmJlbGxfaWRfb2Zmc2V0OwkvKiBEb29yYmVsbCBvZmZzZXQgKGZyb20gS0ZEIGRvb3JiZWxs
Ci0JCQkJCSAqIHRvIEhXIGRvb3JiZWxsLCBHRlggcmVzZXJ2ZWQgc29tZQotCQkJCQkgKiBhdCB0
aGUgc3RhcnQpCisJc2l6ZV90IGRvb3JiZWxsX2Jhc2VfZHdfb2Zmc2V0OwkvKiBEb29yYmVsbCBk
d29yZCBvZmZzZXQgKGZyb20gS0ZECisJCQkJCSAqIGRvb3JiZWxsIHRvIFBDSSBkb29yYmVsbCBi
YXIsCisJCQkJCSAqIEdGWCByZXNlcnZlZCBzb21lIGF0IHRoZSBzdGFydCkKIAkJCQkJICovCiAJ
dTMyIF9faW9tZW0gKmRvb3JiZWxsX2tlcm5lbF9wdHI7IC8qIFRoaXMgaXMgYSBwb2ludGVyIGZv
ciBhIGRvb3JiZWxscwogCQkJCQkgICAqIHBhZ2UgdXNlZCBieSBrZXJuZWwgcXVldWUKQEAgLTgy
MSw3ICs4MjEsNyBAQCB2b2lkIGtmZF9yZWxlYXNlX2tlcm5lbF9kb29yYmVsbChzdHJ1Y3Qga2Zk
X2RldiAqa2ZkLCB1MzIgX19pb21lbSAqZGJfYWRkcik7CiB1MzIgcmVhZF9rZXJuZWxfZG9vcmJl
bGwodTMyIF9faW9tZW0gKmRiKTsKIHZvaWQgd3JpdGVfa2VybmVsX2Rvb3JiZWxsKHZvaWQgX19p
b21lbSAqZGIsIHUzMiB2YWx1ZSk7CiB2b2lkIHdyaXRlX2tlcm5lbF9kb29yYmVsbDY0KHZvaWQg
X19pb21lbSAqZGIsIHU2NCB2YWx1ZSk7Ci11bnNpZ25lZCBpbnQga2ZkX2Rvb3JiZWxsX2lkX3Rv
X29mZnNldChzdHJ1Y3Qga2ZkX2RldiAqa2ZkLAordW5zaWduZWQgaW50IGtmZF9nZXRfZG9vcmJl
bGxfZHdfb2Zmc2V0X2Zyb21fYmFyKHN0cnVjdCBrZmRfZGV2ICprZmQsCiAJCQkJCXN0cnVjdCBr
ZmRfcHJvY2VzcyAqcHJvY2VzcywKIAkJCQkJdW5zaWduZWQgaW50IGRvb3JiZWxsX2lkKTsKIHBo
eXNfYWRkcl90IGtmZF9nZXRfcHJvY2Vzc19kb29yYmVsbHMoc3RydWN0IGtmZF9kZXYgKmRldiwK
LS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
