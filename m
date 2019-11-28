Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA82C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C922158A
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C922158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 726176E5F0;
	Thu, 28 Nov 2019 02:21:53 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800050.outbound.protection.outlook.com [40.107.80.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E0C56E5F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 02:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmdPOWD0blLAmz2d1TaG3jYVnncZtc2j4APKmKIqUiuqEjpDvdKNstZ27rcsF0L4wmemeTv76imnxv73Zvz9oOn85mhEfTSNVEIk81TtOeFj3LneOIysZf6FVW/6Ud4v8kR3HmW+RzkA4/jWzk+6HV8XoEpIIqNXRcrZHVsRWtsnmwVSRH7C+JqsNH4w8m5zyQzTrKT2t/+f4guTfO6ZhyRn5y0csX4JvtlL1FQNBVfdB/1Jbn5jPvoLgsQ/Cr2yWzHv3PpcAFHaXBKh6mAawsID3jGD544iT4kvBG8XagATsNdPEgVWjq8cyKIf85bnNAov0fsltBV6tvbHzZm8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo8St3Glsh7sHTdDmvX7BLXGDQmCFsxRjRq4KNHwtps=;
 b=Msxup69lVYMIzfhjbYTm7L2TjpO54cmSGa2zmJQWeXk6vQ5QPznaYocYKtNeocb0InKk05YHUejXImkFqfy9o59QLN3izh1bK0B9SoVXGj/XqhrQRLPyv8vY+l45LrlwOd8Ppmx/k3w7tkGoOQo11/B7saD6Xp++4yq5iD/0Db9blIn6d75a7JmJ81cGF3sF4FCdrrdpYlpKGLM2/MIXjGEJPtpS7vHEmXDd7wxLAbpOXqNmS4Qrhz82YQ1EeXW22ONFLTs4cYdv7WnKNvwicYPhjC4cEOtkXFfhA/feg64sOEZ1A+rcIGLLUWPHWn7HHKd++UfDeikNvKw4IopxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB4256.namprd12.prod.outlook.com (52.135.48.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 02:21:50 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 02:21:50 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: fix calltrace during kmd unload
Thread-Topic: [PATCH 5/5] drm/amdgpu: fix calltrace during kmd unload
Thread-Index: AQHVpE+8oQDhyU+K4E6kdOOEPKAZ26ef3Iag
Date: Thu, 28 Nov 2019 02:21:50 +0000
Message-ID:
 <MN2PR12MB39335854163DAC0B6451A75384470@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-5-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1574769024-30611-5-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc9980db-cbfd-408c-24fc-08d773a9ba05
x-ms-traffictypediagnostic: MN2PR12MB4256:
x-microsoft-antispam-prvs: <MN2PR12MB4256D09F5CC3BFAC038978BB84470@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(189003)(199004)(13464003)(5640700003)(6506007)(11346002)(229853002)(6436002)(66066001)(53546011)(9686003)(5660300002)(55016002)(6246003)(99286004)(446003)(316002)(86362001)(26005)(52536014)(2501003)(186003)(14454004)(33656002)(2351001)(2906002)(256004)(76116006)(3846002)(6116002)(478600001)(71200400001)(71190400001)(25786009)(66946007)(6916009)(64756008)(66476007)(66556008)(66446008)(81166006)(8936002)(81156014)(8676002)(14444005)(102836004)(74316002)(7696005)(76176011)(305945005)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4256;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8JFvAW6FOI196hVurTevINnMTXRCtvOBxwbhzUhLsNniv9ObyiBFI9NaLW7VPlCnsZwy8/x2BUWcU5UledqAGHHGhKx7g10ybrPrM6L9nlucPMiX6z51IPpVKKE+rUx+I+Xt62IlEwgxAdXrsNSPEsbASJrP5wvWx1Z6UfZOUZy8c8/ujkfQwN59LGYIYdRfe7U2RqZF9Nqn9QHrlWBgCk/9d//AP6u9O2AeqWlM+e9+VicrUfSsEcGf8ENMTxt1qSfmELpvC09LBK6pwTdO/+nMJO4sszQwHQDMA+ZdzWN7QoC+seuUOlB3r6Ji9dcjbBVWL40CCivvijhS+FM2dku0J0ISKvx2Xh5w/2DglxbByZMR1DwqNv3+/NPjvOqCmfvhQOWiiC66kEDBKmdngH2ODodgJsoC39AKsvvAFs6TtB8pkm4ReP8hNQyCV1Q7
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9980db-cbfd-408c-24fc-08d773a9ba05
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 02:21:50.1682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfDAPdo4akcjzOcPBor+8tyd2dEIod6lvld6RkPe4TMyx7LrJmmBBtwADEIzFnMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo8St3Glsh7sHTdDmvX7BLXGDQmCFsxRjRq4KNHwtps=;
 b=jvkj4/7ZjKPb052ny2FtuL+6djX0jWkD4/v/KqHQ/mUZGrukJuj4+T0YZCCyhJ5BnTfvL75RSQjJEA463soKRIVn9xXST5fviy68C7whntZhFzkfZAdeiCqLTfquCEMD91TZtYVFh7pC5MFt4d5npWaFZ3fxbjylD4tfkwnyjIA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191128022150.wgUMbdWRNk_ckP_D8AqjDuUTpll8rhajt1fNX0LUYNA@z>

cGluZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpNb25rIExpdXxHUFUg
VmlydHVhbGl6YXRpb24gVGVhbSB8QU1ECgoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJv
bTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+IApTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAy
NiwgMjAxOSA3OjUwIFBNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogTGl1
LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPgpTdWJqZWN0OiBbUEFUQ0ggNS81XSBkcm0vYW1kZ3B1
OiBmaXggY2FsbHRyYWNlIGR1cmluZyBrbWQgdW5sb2FkCgprZXJuZWwgd291bGQgcmVwb3J0IGEg
d2FybmluZyBvbiBkb3VibGUgdW5waW4gb24gdGhlIGNzYiBCTyBiZWNhdXNlIHdlIHVucGluIGl0
IGR1cmluZyBod19maW5pIGJ1dCBhY3R1YWxseSB3ZSBkb24ndCBuZWVkIHRvIHBpbi91bnBpbiBp
dCBkdXJpbmcgaHdfaW5pdC9maW5pIHNpbmNlIGl0IGlzIGNyZWF0ZWQgd2l0aCBrZXJuZWwgcGlu
bmVkCgpyZW1vdmUgYWxsIHRob3NlIHVzZWxlc3MgY29kZSBmb3IgZ2Z4OS8xMAoKU2lnbmVkLW9m
Zi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3JsYy5jIHwgIDEgLSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMgIHwgMzggLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICB8IDM5IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA3OCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmxjLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmxjLmMKaW5kZXggYzg3OTNlNi4uMjg5ZmFkYSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JsYy5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ybGMuYwpAQCAtMTQ1LDcgKzE0NSw2
IEBAIGludCBhbWRncHVfZ2Z4X3JsY19pbml0X2NzYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAlkc3RfcHRyID0gYWRldi0+Z2Z4LnJsYy5jc19wdHI7CiAJYWRldi0+Z2Z4LnJsYy5mdW5j
cy0+Z2V0X2NzYl9idWZmZXIoYWRldiwgZHN0X3B0cik7CiAJYW1kZ3B1X2JvX2t1bm1hcChhZGV2
LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7Ci0JYW1kZ3B1X2JvX3VucGluKGFkZXYtPmdmeC5y
bGMuY2xlYXJfc3RhdGVfb2JqKTsKIAlhbWRncHVfYm9fdW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMu
Y2xlYXJfc3RhdGVfb2JqKTsKIAogCXJldHVybiAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjEwXzAuYwppbmRleCBhNTZjYmE5Li41ZWU3NDY3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYwpAQCAtOTk2LDM5ICs5OTYsNiBAQCBzdGF0aWMgaW50IGdmeF92MTBf
MF9ybGNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAlyZXR1cm4gMDsKIH0KIAot
c3RhdGljIGludCBnZnhfdjEwXzBfY3NiX3ZyYW1fcGluKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KSAtewotCWludCByOwotCi0JciA9IGFtZGdwdV9ib19yZXNlcnZlKGFkZXYtPmdmeC5ybGMu
Y2xlYXJfc3RhdGVfb2JqLCBmYWxzZSk7Ci0JaWYgKHVubGlrZWx5KHIgIT0gMCkpCi0JCXJldHVy
biByOwotCi0JciA9IGFtZGdwdV9ib19waW4oYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmos
Ci0JCQlBTURHUFVfR0VNX0RPTUFJTl9WUkFNKTsKLQlpZiAoIXIpCi0JCWFkZXYtPmdmeC5ybGMu
Y2xlYXJfc3RhdGVfZ3B1X2FkZHIgPQotCQkJYW1kZ3B1X2JvX2dwdV9vZmZzZXQoYWRldi0+Z2Z4
LnJsYy5jbGVhcl9zdGF0ZV9vYmopOwotCi0JYW1kZ3B1X2JvX3VucmVzZXJ2ZShhZGV2LT5nZngu
cmxjLmNsZWFyX3N0YXRlX29iaik7Ci0KLQlyZXR1cm4gcjsKLX0KLQotc3RhdGljIHZvaWQgZ2Z4
X3YxMF8wX2NzYl92cmFtX3VucGluKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAtewotCWlu
dCByOwotCi0JaWYgKCFhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaikKLQkJcmV0dXJuOwot
Ci0JciA9IGFtZGdwdV9ib19yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqLCB0
cnVlKTsKLQlpZiAobGlrZWx5KHIgPT0gMCkpIHsKLQkJYW1kZ3B1X2JvX3VucGluKGFkZXYtPmdm
eC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKLQkJYW1kZ3B1X2JvX3VucmVzZXJ2ZShhZGV2LT5nZngu
cmxjLmNsZWFyX3N0YXRlX29iaik7Ci0JfQotfQotCiBzdGF0aWMgdm9pZCBnZnhfdjEwXzBfbWVj
X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpICB7CiAJYW1kZ3B1X2JvX2ZyZWVfa2Vy
bmVsKCZhZGV2LT5nZngubWVjLmhwZF9lb3Bfb2JqLCBOVUxMLCBOVUxMKTsgQEAgLTM3ODAsMTAg
KzM3NDcsNiBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9od19pbml0KHZvaWQgKmhhbmRsZSkKIAlp
bnQgcjsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqKWhhbmRsZTsKIAotCXIgPSBnZnhfdjEwXzBfY3NiX3ZyYW1fcGluKGFkZXYpOwotCWlmIChy
KQotCQlyZXR1cm4gcjsKLQogCWlmICghYW1kZ3B1X2VtdV9tb2RlKQogCQlnZnhfdjEwXzBfaW5p
dF9nb2xkZW5fcmVnaXN0ZXJzKGFkZXYpOwogCkBAIC0zODcxLDcgKzM4MzQsNiBAQCBzdGF0aWMg
aW50IGdmeF92MTBfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKIAl9CiAJZ2Z4X3YxMF8wX2NwX2Vu
YWJsZShhZGV2LCBmYWxzZSk7CiAJZ2Z4X3YxMF8wX2VuYWJsZV9ndWlfaWRsZV9pbnRlcnJ1cHQo
YWRldiwgZmFsc2UpOwotCWdmeF92MTBfMF9jc2JfdnJhbV91bnBpbihhZGV2KTsKIAogCXJldHVy
biAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKaW5kZXggNGNjMmU1MC4u
NTI0YTdiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC0xNjgzLDM5
ICsxNjgzLDYgQEAgc3RhdGljIGludCBnZnhfdjlfMF9ybGNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGludCBnZnhfdjlfMF9jc2JfdnJh
bV9waW4oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIC17Ci0JaW50IHI7Ci0KLQlyID0gYW1k
Z3B1X2JvX3Jlc2VydmUoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmosIGZhbHNlKTsKLQlp
ZiAodW5saWtlbHkociAhPSAwKSkKLQkJcmV0dXJuIHI7Ci0KLQlyID0gYW1kZ3B1X2JvX3Bpbihh
ZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaiwKLQkJCUFNREdQVV9HRU1fRE9NQUlOX1ZSQU0p
OwotCWlmICghcikKLQkJYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9ncHVfYWRkciA9Ci0JCQlh
bWRncHVfYm9fZ3B1X29mZnNldChhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7Ci0KLQlh
bWRncHVfYm9fdW5yZXNlcnZlKGFkZXYtPmdmeC5ybGMuY2xlYXJfc3RhdGVfb2JqKTsKLQotCXJl
dHVybiByOwotfQotCi1zdGF0aWMgdm9pZCBnZnhfdjlfMF9jc2JfdnJhbV91bnBpbihzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikgLXsKLQlpbnQgcjsKLQotCWlmICghYWRldi0+Z2Z4LnJsYy5j
bGVhcl9zdGF0ZV9vYmopCi0JCXJldHVybjsKLQotCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhZGV2
LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaiwgdHJ1ZSk7Ci0JaWYgKGxpa2VseShyID09IDApKSB7
Ci0JCWFtZGdwdV9ib191bnBpbihhZGV2LT5nZngucmxjLmNsZWFyX3N0YXRlX29iaik7Ci0JCWFt
ZGdwdV9ib191bnJlc2VydmUoYWRldi0+Z2Z4LnJsYy5jbGVhcl9zdGF0ZV9vYmopOwotCX0KLX0K
LQogc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfbWVjX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpICB7CiAJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nZngubWVjLmhwZF9lb3Bfb2Jq
LCBOVUxMLCBOVUxMKTsgQEAgLTM2OTQsMTAgKzM2NjEsNiBAQCBzdGF0aWMgaW50IGdmeF92OV8w
X2h3X2luaXQodm9pZCAqaGFuZGxlKQogCiAJZ2Z4X3Y5XzBfY29uc3RhbnRzX2luaXQoYWRldik7
CiAKLQlyID0gZ2Z4X3Y5XzBfY3NiX3ZyYW1fcGluKGFkZXYpOwotCWlmIChyKQotCQlyZXR1cm4g
cjsKLQogCXIgPSBhZGV2LT5nZngucmxjLmZ1bmNzLT5yZXN1bWUoYWRldik7CiAJaWYgKHIpCiAJ
CXJldHVybiByOwpAQCAtMzc3OSw4ICszNzQyLDYgQEAgc3RhdGljIGludCBnZnhfdjlfMF9od19m
aW5pKHZvaWQgKmhhbmRsZSkKIAlnZnhfdjlfMF9jcF9lbmFibGUoYWRldiwgZmFsc2UpOwogCWFk
ZXYtPmdmeC5ybGMuZnVuY3MtPnN0b3AoYWRldik7CiAKLQlnZnhfdjlfMF9jc2JfdnJhbV91bnBp
bihhZGV2KTsKLQogCXJldHVybiAwOwogfQogCi0tCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
