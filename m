Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD2C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803D824685
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803D824685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4854A6F979;
	Fri,  6 Dec 2019 09:03:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FB46F979
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 09:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzkYb9WcoiMTgjSQYHnsHIq3VHvvtjyKTl0CbaaqrWG62zy4EsmvsaWoMHSKwpQtvJLUBTcZxTMcaVt+f9OVBOiKPqNxfDclTK1a+bXQY/qMVkaxQKVdSiQ2S4zdpkBwSWCLGwc8VrOHM9P35rQIa2jYVGrfhDHUBN/e3D3WXkvdxAxwsNLf+ieNDqyE8wanqashSFu5Ftp9ti3MNm/D0Bc9D7w2m+TjqdPJyjEqnOZe6uD63fiBBrWeNP3+lkKXSqWo1qMVagkYDZHlfzBWo7r2Ds4rgcrnDa5JgY5hx5tdK/lhlz6aohGor+7dGxjy8IyOdqpJTglqB78V4TIWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WgvaxD/IfLlM0+Y146yADi/3HFxIyqe/tthi96y2cs=;
 b=fbUaGDG0S5nrevyAXZc7lwDUDq7waqwBSMFQiFZwvBDsrbiR6n5dgjPyh4dhA9VmkV6eACcwS8yQeZqORAzj7HyCVMtky8fMp8CvaYk/AV7oWcxNB9jy5Lgr/+G8XWyjPkX9jfO+PLKErjoTcba8a5kSqWTVtVCoguldlwlOgrja0GqBNiNMLt84ZZJvvN1wtYR2uVu2hRXxJQww4hVPLvrNFx9GUXnWAyQz2bbDLWNhCI8/TfKdp+sbo1lMKkC6q2sSj34qV9b0X8qg7SlZojDUot8gQvMbfFIq52V3umTycIMCH82P7m35RDMHoorXa0ps2eZ6DRywXldB1QLloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3222.namprd12.prod.outlook.com (20.179.90.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 6 Dec 2019 09:03:47 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 09:03:47 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Ma, Le" <Le.Ma@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix resume failures casued by psp fw loading
 sequence change
Thread-Topic: [PATCH] drm/amdgpu: fix resume failures casued by psp fw loading
 sequence change
Thread-Index: AQHVrBOZuOjNeJxkxU6kdFnlEfXVUKesz5Yg
Date: Fri, 6 Dec 2019 09:03:47 +0000
Message-ID: <BYAPR12MB2806AB591B0CE422AC335694F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20191206085956.4681-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191206085956.4681-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-12-06T09:02:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=88f0c071-02b8-467d-94ab-00008b378025;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2019-12-06T09:03:44Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 47c051d3-ffcd-48b5-920f-00000942f63f
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da6e0658-ac8f-4133-6b6e-08d77a2b344f
x-ms-traffictypediagnostic: BYAPR12MB3222:|BYAPR12MB3222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB32228D7E5EC18E620BAA6D64F15F0@BYAPR12MB3222.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(13464003)(189003)(199004)(6636002)(102836004)(4326008)(33656002)(6506007)(25786009)(86362001)(76176011)(53546011)(7696005)(2906002)(55016002)(9686003)(45080400002)(478600001)(110136005)(316002)(966005)(14454004)(99286004)(11346002)(52536014)(5660300002)(71190400001)(71200400001)(14444005)(305945005)(66556008)(26005)(186003)(81166006)(81156014)(229853002)(8936002)(74316002)(76116006)(8676002)(66946007)(66476007)(64756008)(66446008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3222;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgwx9b8u0CgVZ5yPjmIpXIzzhRliCzDiaJWbqmDIzKdVQFE/mwC49lS/5/SBa2UavNvgQc+aLvWBUs47I63MHpFr1FfIq61EGDf7lx+I+O8Ii8k5Ys7IhUMO//0lN50lJ2iE+nRigUlXzGNBU/KDct7aShjrzPPzgglH8i9IROjn79nUvsKQpL5knQMjXhu+4cF7/n0TDoHoOqHdT85n+m00pnvDfE7LEfhm2Uc5FgfyWUAxZRFyBsHLhu12UZEweqyxtsQEuyRHh341cqpIN/HR8470JfZ+xlIIQ1i9/QBaO2ojglON09bnneJ+DBc/XBv/KIqV8Q9E10ktmwCG+CeOwiT5yXtYBxtg9mbjOWHzMn/ZjKkv+vZwq69RgANlIaT/mHBYeY9FJcceWzLyIWapl4jH0KzNRR/OzcBiGOmiXiVxdnQDTSNeDAk8Ds3IuszpkNdhnwUSec9rSyfygI6bo522cHO9VHg187XSlc0t3uviofTv4BVD9ln/DmGuIvKZJIjB63XFizkEw9KlEPZxNJj7BBgE1PBe6uJ4ksc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6e0658-ac8f-4133-6b6e-08d77a2b344f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 09:03:47.4208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHK7wl6IG4BzP3tJM9nY93TiQLuEUJLRUF9Z0oeS8L1HkQJ2Js69WwHJlJqTw2WTnkCFfw8cdMIHu6AD5cOwKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3222
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WgvaxD/IfLlM0+Y146yADi/3HFxIyqe/tthi96y2cs=;
 b=bytniB4/CXrBCSYVGw6s0trWEBgZjFsUN4mSOL1DDFLvzeXhX4PSSgNmLK5TsS2xIm5R0qmp1rTm4iWx0GnD4k70FD3lrOQ19oVZOFVsSYVyRwsIcF0bdMshEU4QmTVi6xs5QUUjflNCNzq8IOogrSAfeATwuKwWYdLh5RlM02M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQoNCg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgSGF3a2luZyBaaGFuZw0KU2VudDogRnJpZGF5LCBE
ZWNlbWJlciA2LCAyMDE5IDU6MDAgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgTWEsIExlIDxMZS5NYUBhbWQuY29tPjsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
CkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogW1BB
VENIXSBkcm0vYW1kZ3B1OiBmaXggcmVzdW1lIGZhaWx1cmVzIGNhc3VlZCBieSBwc3AgZncgbG9h
ZGluZyBzZXF1ZW5jZSBjaGFuZ2UNCg0KdGhpcyBmaXggdGhlIHJlZ3Jlc3Npb24gY2F1c2VkIGJ5
IGFzZC90YSBsb2FkaW5nIHNlcXVlbmNlIGFkanVzdG1lbnQgcmVjZW50bHkuIGFzZC90YSBsb2Fk
aW5nIHdhcyBtb3ZlIG91dCBmcm9tIGh3X3N0YXJ0IGFuZCBzaG91bGQgYWxzbyBiZSBhcHBsaWVk
IHRvIHBzcF9yZXN1bWUuIG90aGVyd2lzZSB0aG9zZSBmdyBsb2FkaW5nIHdpbGwgYmUgaWdub3Jl
ZCBpbiByZXN1bWUgcGhhc2UuDQoNCkNoYW5nZS1JZDogSTU3MDEwYmM3ZGRmNzFhYzQ2ZDNmYjU0
NGQyNzkzMjY2NDE5MGNmMDQNClNpZ25lZC1vZmYtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcu
WmhhbmdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzMg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQpp
bmRleCBjZWVhODMxNGQ4OGQuLjJlZjE2ZDRjNzUyZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5jDQpAQCAtMTcwMiw2ICsxNzAyLDM5IEBAIHN0YXRpYyBpbnQgcHNw
X3Jlc3VtZSh2b2lkICpoYW5kbGUpDQogCWlmIChyZXQpDQogCQlnb3RvIGZhaWxlZDsNCiANCisJ
cmV0ID0gcHNwX2FzZF9sb2FkKHBzcCk7DQorCWlmIChyZXQpIHsNCisJCURSTV9FUlJPUigiUFNQ
IGxvYWQgYXNkIGZhaWxlZCFcbiIpOw0KKwkJcmV0dXJuIHJldDsNCltHdWNodW5dIFdlIGNhbid0
IGRpcmVjdGx5IHJldHVybiBoZXJlLCBhcyBhdCB0aGUgZWFybHkgc3RhZ2Ugb2YgdGhpcyBmdW5j
dGlvbiBwc3BfcmVzdW1lLCB3ZSBoYXZlIGVuYWJsZWQgbG9jay4gV2UgbmVlZCB0byB1c2UgZ290
byBmYWlsZWQgdG8gdW5sb2NrLCBsaWtlIG90aGVyIGZhaWx1cmUgY2FzZS4NCisJfQ0KKw0KKwlp
ZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgew0KKwkJcmV0ID0gcHNw
X3hnbWlfaW5pdGlhbGl6ZShwc3ApOw0KKwkJLyogV2FybmluZyB0aGUgWEdNSSBzZWVzaW9uIGlu
aXRpYWxpemUgZmFpbHVyZQ0KKwkJICogSW5zdGVhZCBvZiBzdG9wIGRyaXZlciBpbml0aWFsaXph
dGlvbg0KKwkJICovDQorCQlpZiAocmV0KQ0KKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsDQor
CQkJCSJYR01JOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBYR01JIHNlc3Npb25cbiIpOw0KKwl9DQor
DQorCWlmIChwc3AtPmFkZXYtPnBzcC50YV9mdykgew0KKwkJcmV0ID0gcHNwX3Jhc19pbml0aWFs
aXplKHBzcCk7DQorCQlpZiAocmV0KQ0KKwkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsDQorCQkJ
CQkiUkFTOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBSQVNcbiIpOw0KKw0KKwkJcmV0ID0gcHNwX2hk
Y3BfaW5pdGlhbGl6ZShwc3ApOw0KKwkJaWYgKHJldCkNCisJCQlkZXZfZXJyKHBzcC0+YWRldi0+
ZGV2LA0KKwkJCQkiSERDUDogRmFpbGVkIHRvIGluaXRpYWxpemUgSERDUFxuIik7DQorDQorCQly
ZXQgPSBwc3BfZHRtX2luaXRpYWxpemUocHNwKTsNCisJCWlmIChyZXQpDQorCQkJZGV2X2Vycihw
c3AtPmFkZXYtPmRldiwNCisJCQkJIkRUTTogRmFpbGVkIHRvIGluaXRpYWxpemUgRFRNXG4iKTsN
CisJfQ0KKw0KIAltdXRleF91bmxvY2soJmFkZXYtPmZpcm13YXJlLm11dGV4KTsNCiANCiAJcmV0
dXJuIDA7DQotLQ0KMi4xNy4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0
aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2d1Y2h1bi5jaGVuJTQwYW1kLmNvbSU3
Q2I2Y2E2MzgyZGFkMDQyNTlkYjBiMDhkNzdhMmFiODM1JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzExMjE5NjI1Nzg4NTgzOSZhbXA7c2RhdGE9SWJ1ZkFW
QVM0djc3NEEzN3Zsbm4ySkt2cGpubG1COXJIekclMkZaeWRkeUxzJTNEJmFtcDtyZXNlcnZlZD0w
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
