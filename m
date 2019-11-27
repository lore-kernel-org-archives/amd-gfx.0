Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BFEC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 14:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E0120678
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 14:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E0120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94FD089346;
	Wed, 27 Nov 2019 14:00:36 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5226E550
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 14:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVIvnvnRpK9mdJxXWF8QeA7lJ2Hi8Jw2sW1rwf5gHdBfpEPSWdUMGm9ZxBXPSlr4ApgZpo3eQs2DphPMDDuh7M93lUFkdWwlWjD3wwvKQInzXcVtQxQxuki0XxZHe/oj5Kq1qGM6G9sBldiCJj4/Uj3ssgguA9ptUVuvzqV39LMVaqQ4/8SVXRw9nCtJ68T/IC0fLXaZIO7RW6KgCmhqxcUuu3k9+CP+6i3nTBS3sGgWBMzcuNWylQvxyW+WxNjjlVp5goDsTuT1Aorykru+BCsNM6ZshNoO3btR6QhpvV9a6VABUc4HsVvDst26RG2t4NvVV9Fgiytmo2nkRNlioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpQ1/xW1kC+YFun2DT8mYfOJcBNoQhbz2TeQlEN8Fz0=;
 b=er7JdLrYql9/ZdpP4hTL608ceC928EWd34r5+hGUSTwSgSkq4n4x3CYd4N4/xgEhCfGxgeAA33OtQHOvpnsDy3MELwgzG6z1QL9sViHjojwael3Hzs9PS6CRTi514yhym2R+GE5FfCKD4GPaJTC7YhP62+lLIdxkdwSS4viE+VD3WtpANHxbuvnafYODXiT1dCZJ8Rsj/9JH2gZ/BgKD5pxLm8hc1nZCXMbJQyx/45qyhH9C91yxSAHSKzeeBdZmz5vsdJkT5pxV4L9aco0kVRiPB0KHfAJlScIvAHW2c3hBdcypLV8TklfRh/0yRpqsH8IKXxhGBNt0tqCbDHjbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB4269.namprd12.prod.outlook.com (52.135.48.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 27 Nov 2019 14:00:33 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::b4d9:8cb3:3876:ed5%6]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 14:00:33 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Thread-Topic: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Thread-Index: AQHVpQNF8p3JP+rj2kWZAyQf5kXx/6ee5GcAgAAQLmA=
Date: Wed, 27 Nov 2019 14:00:33 +0000
Message-ID:
 <MN2PR12MB4285C5E86B0E77D94DEE2525F6440@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-5-git-send-email-le.ma@amd.com>
 <DM5PR12MB1418D76FD9E6E7748C2F9997FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418D76FD9E6E7748C2F9997FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-11-27T11:35:06Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5a3f667d-0c74-4872-8fe3-0000444d8756;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46a2b391-bfac-45f2-68dd-08d773422bf4
x-ms-traffictypediagnostic: MN2PR12MB4269:|MN2PR12MB4269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB426977D89D5EE926CF3A56A6F6440@MN2PR12MB4269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(13464003)(199004)(189003)(33656002)(99286004)(229853002)(2501003)(6246003)(8936002)(52536014)(25786009)(186003)(5660300002)(76176011)(86362001)(54906003)(7696005)(110136005)(7736002)(11346002)(478600001)(14444005)(316002)(26005)(9686003)(8676002)(102836004)(66066001)(81166006)(81156014)(14454004)(446003)(305945005)(71200400001)(53546011)(6506007)(6116002)(74316002)(55016002)(64756008)(2906002)(66946007)(66556008)(256004)(71190400001)(66476007)(76116006)(6436002)(4326008)(3846002)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4269;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhxUz0cb3djVcxyK8cKJDl+jsEld/+H3e7GyTIBJV5CF3UQzHok8DcMYqF+254Vj1JQ8Ke2Z++bLNQc5eDJ+aeN0Wh5eZDdcER3dsoHr6Kgq8vzKm7BgiHvAwVbkzfIIa4VkvLe1B3qI4E3ENSwqZGHPxuLsDZ16DGlYzWP4khSjTAZLBLZroYCV7ef9KB3P+Oo5nNThv5wg3iJO/Xmc/LwclS5zPLiinDdqHQmpxOu0zGBKGdu3y8GfefyEUZWI2iNZFK29P62RK+C4VpjhilZyyI37J0DpPG8W1THS3uM5uAiSY8rYqiN5yMQ5fi7ZXJrFoUI5KXh0YLCM+YwbWwrujJAoQE1pQyvlRyb6UurQL7udm2o5rLlHzUF/8vryWk3fFGzM1nKlmkMcyIC++FORFiOtC2/fFATW8S3aVAOMvWUQcUD/JwD3AEWHoqo5
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a2b391-bfac-45f2-68dd-08d773422bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 14:00:33.8160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PV2oQIYHC4A0TxqXpkgMy5HgPtci2R0GbyGU0IHbAHe5/r6us/jP1JcJf8kJ/xbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpQ1/xW1kC+YFun2DT8mYfOJcBNoQhbz2TeQlEN8Fz0=;
 b=NhCfq60XslNKXDLg2PqnzBqSC8qEGKDHTuixJq/iMZCWyqVhRZII2j7MIOf61xQu9BQpD5SkiPwfAUx0F/Ks9em6xOMirNDF8Vk5LASWOne9QjM6hNHNNU3Upl31kvl3oVggUcB4LIAYQWD7rtIil92enNyIvS/QZb5DQJBw81k=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Le.Ma@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127140033.NNfEbbL0L-e9Kra9PIqYyh6hBCV_vEAmQSOPgvBhTbg@z>

SGkgSGF3a2luZywKClBsZWFzZSBjaGVjayB0aGlzIHYyIHBhdGNoIHdoaWNoIGlzIGp1c3Qgc2Vu
dCBvdXQuIEFuZCBhcyBkaXNjdXNzZWQsIHdlIGRlY2lkZSB0byBzdGlsbCBsZXZlcmFnZSB0aGUg
Y3VycmVudCByZXNldF9tZXRob2QoKSBmdW5jdGlvbiB3aXRoIGZ1bmN0aW9uYWxpdHkvY2hhbmdl
IHNjYWxlL2NvZGUgbWFpbnRhaW5hYmlsaXR5IGJhbGFuY2VkIC4gVGhhbmtzLgoKUmVnYXJkcywK
TWEgTGUKCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZyb206IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+IApTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI3LCAyMDE5
IDc6MzkgUE0KVG86IE1hLCBMZSA8TGUuTWFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBaaG91MSwg
VGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQuY29tPjsg
RGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTWEsIExlIDxM
ZS5NYUBhbWQuY29tPgpTdWJqZWN0OiBSRTogW1BBVENIIDA2LzEwXSBkcm0vYW1kZ3B1OiBhZGQg
Y29uZGl0aW9uIHRvIGVuYWJsZSBiYWNvIGZvciB4Z21pL3JhcyBjYXNlCgpbQU1EIFB1YmxpYyBV
c2VdCgpBbmQgSXQgaXMgc3RpbGwgbmVjZXNzYXJ5IHRvIHB1dCBhbGwgdGhlIGNvbmRpdGlvbiBj
aGVjayBpbiBhIGZ1bmN0aW9uLiBJIG1lYW4gYSBmdW5jdGlvbiB0aGF0IGRlY2lkZSB0byBnbyBy
YXMgcmVjb3Zlcnkgb3IgbGVnYWN5IGZhdGFsX2Vycm9yIGhhbmRsaW5nLiBUaGUgUE1GVyB2ZXJz
aW9uIHRoYXQgc3VwcG9ydCBSQVMgcmVjb3Zlcnkgd2lsbCBiZSBkaWZmZXJlbnQgYW1vbmcgQVNJ
Q3MuIEN1cnJlbnQgdmVyc2lvbiBjaGVjayBvbmx5IHdvcmtzIGZvciBWRzIwLiBJbiBmYWN0LCBv
bmNlIHJhcy0+c3VwcG9ydGVkIGlzIHNldCBhbmQgcHJvcGVyIFBNRlcgaXMgZGV0ZWN0ZWQsIFJB
UyByZWNvdmVyeSB3aWxsIGJlIHRoZSBiZXN0IGNob2ljZSBubyBtYXR0ZXIgaXQgaXMgc0dQVSBv
ciBtR1BVLgoKUmVnYXJkcywKSGF3a2luZwoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJv
bTogTGUgTWEgPGxlLm1hQGFtZC5jb20+IApTZW50OiAyMDE55bm0MTHmnIgyN+aXpSAxNzoxNQpU
bzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+OyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBa
aG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTWEs
IExlIDxMZS5NYUBhbWQuY29tPgpTdWJqZWN0OiBbUEFUQ0ggMDYvMTBdIGRybS9hbWRncHU6IGFk
ZCBjb25kaXRpb24gdG8gZW5hYmxlIGJhY28gZm9yIHhnbWkvcmFzIGNhc2UKCkF2b2lkIHRvIGNo
YW5nZSBkZWZhdWx0IHJlc2V0IGJlaGF2aW9yIGZvciBwcm9kdWN0aW9uIGNhcmQgYnkgY2hlY2tp
bmcgYW1kZ3B1X3Jhc19lbmFibGUgZXF1YWwgdG8gMi4gQW5kIG9ubHkgbmV3IGVub3VnaCBzbXUg
dWNvZGUgY2FuIHN1cHBvcnQgYmFjbyBmb3IgeGdtaS9yYXMgY2FzZS4KCkNoYW5nZS1JZDogSTA3
YzNlNjg2MmJlMDNlMDY4NzQ1YzczZGI4ZWE3MWY0MjhlY2JhNmIKU2lnbmVkLW9mZi1ieTogTGUg
TWEgPGxlLm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUu
YyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IDk1MTMyN2YuLjYyMDIzMzMgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwpAQCAtNTc3LDcgKzU3Nyw5IEBAIHNvYzE1X2Fz
aWNfcmVzZXRfbWV0aG9kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQkJc3RydWN0IGFt
ZGdwdV9oaXZlX2luZm8gKmhpdmUgPSBhbWRncHVfZ2V0X3hnbWlfaGl2ZShhZGV2LCAwKTsKIAkJ
CXN0cnVjdCBhbWRncHVfcmFzICpyYXMgPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOwog
Ci0JCQlpZiAoaGl2ZSB8fCAocmFzICYmIHJhcy0+c3VwcG9ydGVkKSkKKwkJCWlmICgoaGl2ZSB8
fCAocmFzICYmIHJhcy0+c3VwcG9ydGVkKSkgJiYKKwkJCSAgICAoYW1kZ3B1X3Jhc19lbmFibGUg
IT0gMiB8fAorCQkJICAgIGFkZXYtPnBtLmZ3X3ZlcnNpb24gPD0gMHgyODM0MDApKQogCQkJCWJh
Y29fcmVzZXQgPSBmYWxzZTsKIAkJfQogCQlicmVhazsKLS0KMi43LjQKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
