Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DEACA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 10:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F462184C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 10:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F462184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 751CE6E1A7;
	Mon,  4 Nov 2019 10:17:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770048.outbound.protection.outlook.com [40.107.77.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E95B6E1A7
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 10:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4IUlbV3wZ9oeF/8Fd645i/PzYjlIBDkQh7HgPNaPuZ+dq8lDs6GbRSOnSLfn4tarAhmYV4rxvAFkB/+Jas0SCeX7xI3Ca2A9yc3ciWvyK3HAeeaTSPStFYDpcjB4SVpghqcvKH2MN278XoQi64S+WBdEm5UpqjTqaV5jDy3WIdcI9imcQyou/qKKHno44cQ/Ff2DAz1siuK3U+Eqkk5cYtZDWjlSs7uwOuiNlG9jtQkdwCl4UXGkUb6ZynLSRkmZIwFunJ2IclVCiWjUXyW/v8E8t2bnRKFyryPW8vhRDPXsFQ0QJKpOHTF2WVRtiDU7y8jLDp6pxg50ztcU9gyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55A1GYE7QrbXgnzX0eTvZb745Kd0dE4gRqN9kvKZoOM=;
 b=jcXKBn6F7FoWtVixWwc2dbKJxkkkAHttPHN38oujfMs3OSrqMIZZiIJPAhyjzIb/4zOnovnP/b+olmVysQm59/ILiHVGdjOmDP5NuXE5OYmwZ5tYf4iTiEJsYfUQqCjlku7PL5nw9HNQiTqlHhl6n6RHI15Oevq1aVxuft0dEpPNDk6iiLeKC3zPdoBKccL47MxPIVZxvd+LTokbtWX3A52DzpxzTwuvMuLhuB6UkCyErK/ibSVNdswm57ZmJAarWLrmBzG+WAfPrqpmwfkjP6j5mqTjSfkyB5Rvg/bKtz+7Pclu3X9fkvIrZR8YaRg7DMnMAv9k7yuKhGd8EcUuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1513.namprd12.prod.outlook.com (10.172.38.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:17:55 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f%5]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:17:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Clements
 John <Clements.John@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: disallow direct upload save restore list from gfx
 driver
Thread-Topic: [PATCH] drm/amdgpu: disallow direct upload save restore list
 from gfx driver
Thread-Index: AQHVkvkftadqxiIw4U+4xNZyuolLGw==
Date: Mon, 4 Nov 2019 10:17:55 +0000
Message-ID: <1572862661-3254-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To DM5PR12MB1418.namprd12.prod.outlook.com
 (2603:10b6:3:7a::15)
x-originating-ip: [180.167.199.189]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91ad987d-fdfe-48fc-0c0b-08d76110420c
x-ms-traffictypediagnostic: DM5PR12MB1513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1513F5D99C0B661124F9EDC8FC7F0@DM5PR12MB1513.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(15404003)(199004)(7736002)(2501003)(4326008)(6512007)(66946007)(86362001)(478600001)(66476007)(36756003)(99286004)(71190400001)(71200400001)(110136005)(316002)(476003)(486006)(256004)(14444005)(2616005)(305945005)(2906002)(6116002)(6636002)(66066001)(50226002)(186003)(25786009)(3846002)(14454004)(6486002)(66446008)(64756008)(6436002)(66556008)(8676002)(81156014)(81166006)(52116002)(8936002)(6506007)(386003)(26005)(5660300002)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1513;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qglnqFYzuuE+6VaGRYDsNWB5u2GoL0ODSF1xiwmhEwihepbk9PXz7C981zLOM0JtKy8sHO80ZqbKBXQhdjdmPqxQBSYOyIZuBTkY+9Zkg3mzeqxN73KzUzRMeCRnInf2j4e25/vE7awxS/B3FvqHd8a+ygZTIpSuGzb7OlSTMFXdKnmuw826GuGTTg+4fj7bKx7ser/oyIO//4PoHcnPz0TiHl+wD1UYV5ZT5kmBJ7q++d9N5FHhlDUEkNNv0pe8RcgNq3sjclAaap69PACeKN9PBU02UX4RDfgwIob47ozQbj45Z/jBhlVw2lU2RuBxiyCEx7P7J9PhnYHlCgCCX76VJEpX8fAPu/e+/lI4ylOFVgYhvn3AsCMn7i3+c089nqlvtlZk63BH+CxufN9mHEw88BuGXX6txZoXmXZS99EBr1pExJ5urwoig4lnCEXb
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ad987d-fdfe-48fc-0c0b-08d76110420c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 10:17:55.6889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztKxvOGCe65HoG25uqTkRndW+ZLnNKDrouxzaEJk4OSEystuSP9Ykx0jxedBj+ydrgJ7DvpFLVHvSdP3ISIUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55A1GYE7QrbXgnzX0eTvZb745Kd0dE4gRqN9kvKZoOM=;
 b=kbiE6nosbVh/ygYitI6m6uRc8gQNzGegyFDZhsGJwolkELi+JA2yxecYIXuyz0xU2SKjfdCwbSxhmeIVZIf7xMXe7EX8sLCGOelOVp57Xrt4fCrJfrRZP/yATvMmS2aWuJZ2zrGCvA2Y337az1xvtBV0LxYl5zGNSpFKj/nADNg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104101755.M1oJEr8nw5HR8SuQCjqfHnPYMuli1rL8kKAgAaf_FA8@z>

RGlyZWN0IHVwbG9hZGluZyBzYXZlL3Jlc3RvcmUgbGlzdCB2aWEgbW1pbyByZWdpc3RlciB3cml0
ZXMgYnJlYWtzIHRoZSBzZWN1cml0eQpwb2xpY3kuIEluc3RlYWQsIHRoZSBkcml2ZXIgc2hvdWxk
IHBhc3MgcyZyIGxpc3QgdG8gcHNwLgoKRm9yIGFsbCB0aGUgQVNJQ3MgdGhhdCB1c2UgcmxjIHYy
XzEgaGVhZGVycywgdGhlIGRyaXZlciBhY3R1YWxseSB1cGxvYWQgcyZyIGxpc3QKdHdpY2UsIGlu
IG5vbi1wc3AgdWNvZGUgZnJvbnQgZG9vciBsb2FkaW5nIHBoYXNlIGFuZCBnZnggcGcgaW5pdGlh
bGl6YXRpb24gcGhhc2UuClRoZSBsYXR0ZXIgaXMgbm90IGFsbG93ZWQuCgpWRzEyIGlzIHRoZSBv
bmx5IGV4Y2VwdGlvbiB3aGVyZSB0aGUgZHJpdmVyIHN0aWxsIGtlZXBzIGxlZ2FjeSBhcHByb2Fj
aCBmb3IgUyZSCmxpc3QgdXBsb2FkaW5nLiBJbiB0aGVvcnksIHRoaXMgY2FuIGJlIGVsaW1uYXRl
ZCBpZiB3ZSBoYXZlIHZhbGlkIHNyY250bCB1Y29kZQpmb3IgVkcxMi4KCkNoYW5nZS1JZDogSThj
YzhlMDEyNmY3NDZhYWU0M2I5MTE0ZTA1YmMxMTFlZTdiMjM1MzEKU2lnbmVkLW9mZi1ieTogSGF3
a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmlu
ZGV4IDA1MjVmYzYuLmQxNGM0ZDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
YwpAQCAtMjcyNSw3ICsyNzI1LDggQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfaW5pdF9wZyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkgKiBBbmQgaXQncyBuZWVkZWQgYnkgZ2Z4b2ZmIGZl
YXR1cmUuCiAJICovCiAJaWYgKGFkZXYtPmdmeC5ybGMuaXNfcmxjX3YyXzEpIHsKLQkJZ2Z4X3Y5
XzFfaW5pdF9ybGNfc2F2ZV9yZXN0b3JlX2xpc3QoYWRldik7CisJCWlmIChhZGV2LT5hc2ljX3R5
cGUgPT0gQ0hJUF9WRUdBMTIpCisJCQlnZnhfdjlfMV9pbml0X3JsY19zYXZlX3Jlc3RvcmVfbGlz
dChhZGV2KTsKIAkJZ2Z4X3Y5XzBfZW5hYmxlX3NhdmVfcmVzdG9yZV9tYWNoaW5lKGFkZXYpOwog
CX0KIAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
