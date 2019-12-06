Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F51AC43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6095520659
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6095520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146336F99A;
	Fri,  6 Dec 2019 09:51:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF8F6F99A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 09:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JONEU3VgjgA+qeks1K+vidaXrpL2lqfvZe/4eiQk63D3fiZMKU972E1CH3CFzDeaCKmdO2wsNmsPJWXndHfCCOezbyF+9PeR/pNSjJkr+VCrKvPEYTQwMRYkBWefxQtyhdApQcFCTZKtUpekhK/gdJc1NCXkGLtDt2ea4bIX/JKPFy+Pr0EwgvWDVlvopP56VBowsaaZe8FkQf2Utwu3K16WuHh6iu1wcR+CqULj+fRKnYO5+zRKoEo1LcMAoVqJas2pZoNP2rQKgYTCjMfVMhNgzmu9jZ3Wn+dOKc4C4cHBPUdCwdX11Eqil2ekCu8Gaf/fePuBObrEjIleN3D06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRtNdojnTGt6D8nS1MvrLBr6M5AdkNOO1ytuAY7ReHY=;
 b=NzKFFMymqHkn0ag3B5kmHGZS04Wvp3woTGsomLb70UGJsrQBWxDSj74he4+6O/h9Ji0wnE07oBGnad30/Gl6Ew3qHBFYYFd4hAacJwCctX00dYLQASrwaSt5QSsXnbq2207tGlIa1Sb9wjxqaIYNZMOaxOIPo3F6/9FPQaVUdoF7Kg19LMhhxgZojIXzVK/cEu0lPCLLmg+y5NWSfObmUO7CSp8EC2QMHtTY5cLhW9Y/EM5UsIAnjTn/M4m3zIL80vK52Nfj5NuLT3LY4JSJuVCuxmX8oZrZljmum/HCFNvicJk+NMsOqDAxggCj5UBpGl3JKL6W2yXPJq9tq8JvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3143.namprd12.prod.outlook.com (20.178.55.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.16; Fri, 6 Dec 2019 09:51:50 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 09:51:50 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Ma, Le" <Le.Ma@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v2)
Thread-Topic: [PATCH] drm/amdgpu: fix resume failures due to psp fw loading
 sequence change (v2)
Thread-Index: AQHVrBnmBXiDgqfB8Ue3SEsRAtX6cKes3D8w
Date: Fri, 6 Dec 2019 09:51:50 +0000
Message-ID: <BYAPR12MB2806C707634DDD7F30DFB891F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20191206094523.5069-1-Hawking.Zhang@amd.com>
In-Reply-To: <20191206094523.5069-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-12-06T09:47:53Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6e9103a3-4ada-4427-bbbb-000035d1711b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2019-12-06T09:51:48Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e15507ce-1b3f-407c-b348-0000e8c5cb56
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0979060-d371-47e5-129d-08d77a31ead0
x-ms-traffictypediagnostic: BYAPR12MB3143:|BYAPR12MB3143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3143A344751A9D4704D21E1EF15F0@BYAPR12MB3143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(199004)(189003)(13464003)(71200400001)(71190400001)(99286004)(9686003)(11346002)(186003)(86362001)(229853002)(25786009)(76176011)(6636002)(26005)(7696005)(53546011)(6506007)(102836004)(33656002)(76116006)(5660300002)(14454004)(305945005)(8676002)(81156014)(81166006)(66476007)(66946007)(14444005)(74316002)(66556008)(64756008)(66446008)(110136005)(316002)(55016002)(4326008)(8936002)(478600001)(2906002)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3143;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQ8AcEEO/l0fCT+jTJaK5wBoCIeaJ8C7xEOKeLrf1sxMxS1Vnz3Pr6YpRveVN1J0IUV6GJgpMK74ryHDlIDllB5AzJTdOBZ6Du/7521sNS6OlNRCRsBLnnsgnio0yQR1iusv95Rr04gTuFCPqqTjZi+1LBb4vbYhzlDc71r2rl+sBxdKwJhrwhOsZl87GNAnaGUTirpOL9LtNnGEPaFMccSntjyQuz9dWceQ+FdC9kTCzH499ZTvackqOXpcdaqcEicMC30ST7xnp++3FJJ2/iiDdl9XB/JANRHgSTCIaCNVSnR6EEbEnMOQKecIGWyekmtVZoYVu9pnL31p1UKU0ytL6az1X/RpsDrfy3Msn3VqmQ+sxnwQXkGl6zNcmU8DRa0xm5LflToNMKQ8XAPf46Vbkk19eldh5LmEU6q6M+WqokBJFbik06wDZIBLh7A6ro3JW9J+DHhYibdyZYJBYfmA08snkZ/bCZRaGaAONw8oz1viN3DmqP6GVNGySwPS
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0979060-d371-47e5-129d-08d77a31ead0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 09:51:50.5426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC2Oq6JwNBlMzlM6tdf4pXK1rmhcsk5tdOAHVHrACpPghyO8vukDPmZ3x/Cu7iLRfwYlipRH/rYQnPKEhQsp8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3143
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRtNdojnTGt6D8nS1MvrLBr6M5AdkNOO1ytuAY7ReHY=;
 b=iIrJuNLbvK2iHP/kRgASATTr33g280o71ZRx+sA/fraA/bXPeLIHIIWLXSU9PpaXhyEj4HVjJ4FoerLblRj71HzoAwWrufRf1dOJLaJSOE4+E/jNmN8Jc00Bl0R0auN3jo8ajXDTQOzj9g6w/kb7dL4SYkyY4KNjQMdyE8lcHo0=
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

W0FNRCBQdWJsaWMgVXNlXQoKSSByZWNvbW1lbmQgd2UgdXNlIHRoZSBleGlzdGluZyAiZ290byBm
YWlsZWQiIGZvciBwc3AgbG9hZCBmYWlsdXJlIGNhc2UsIGluc3RlYWQgb2YgYWRkaW5nIG9uZSBu
ZXcgbXV0ZXggdW5sb2NrIGJlZm9yZSByZXR1cm5pbmcuClRoaXMgd2lsbCBoZWxwIHJlZHVjZSBy
ZWR1bmRhbnQgY29kZSwgYW5kIG1vcmVvdmVyLCB0aGVyZSBpcyBvbmUgZXJyb3IgcHJpbnQgIiBQ
U1AgcmVzdW1lIGZhaWxlZCAiIGluICJmYWlsZWQiIHJvdXRlLCB3aGljaCBtYXkgYmUgY2FwdHVy
ZWQgZm9yIHRyYWNlL2RlYnVnIHB1cnBvc2UuCkhvdyBkbyB5b3UgdGhpbms/CgpSZWdhcmRzLApH
dWNodW4KCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZyb206IEhhd2tpbmcgWmhhbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4gClNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgNiwgMjAxOSA1OjQ1
IFBNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTWEsIExlIDxMZS5NYUBhbWQu
Y29tPjsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVu
LkNoZW5AYW1kLmNvbT4KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
ClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IHJlc3VtZSBmYWlsdXJlcyBkdWUgdG8g
cHNwIGZ3IGxvYWRpbmcgc2VxdWVuY2UgY2hhbmdlICh2MikKCnRoaXMgZml4IHRoZSByZWdyZXNz
aW9uIGNhdXNlZCBieSBhc2QvdGEgbG9hZGluZyBzZXF1ZW5jZSBhZGp1c3RtZW50IHJlY2VudGx5
LiBhc2QvdGEgbG9hZGluZyB3YXMgbW92ZSBvdXQgZnJvbSBod19zdGFydCBhbmQgc2hvdWxkIGFs
c28gYmUgYXBwbGllZCB0byBwc3BfcmVzdW1lLiBvdGhlcndpc2UgdGhvc2UgZncgbG9hZGluZyB3
aWxsIGJlIGlnbm9yZWQgaW4gcmVzdW1lIHBoYXNlLgoKQ2hhbmdlLUlkOiBJNjc4ZjgyYjVkZDU1
MmQ3MDQzNWJmZGJkMDEwYzRlZDg1MzYzMTRjOQpTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5n
IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3BzcC5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDM0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMKaW5kZXggY2VlYTgzMTRkODhkLi4wM2M0YTIyM2MwNWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTE3MDIsNiArMTcwMiw0MCBAQCBzdGF0aWMgaW50IHBz
cF9yZXN1bWUodm9pZCAqaGFuZGxlKQogCWlmIChyZXQpCiAJCWdvdG8gZmFpbGVkOwogCisJcmV0
ID0gcHNwX2FzZF9sb2FkKHBzcCk7CisJaWYgKHJldCkgeworCQlEUk1fRVJST1IoIlBTUCBsb2Fk
IGFzZCBmYWlsZWQhXG4iKTsKKwkJbXV0ZXhfdW5sb2NrKCZhZGV2LT5maXJtd2FyZS5tdXRleCk7
CisJCXJldHVybiByZXQ7CisJfQorCisJaWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9u
b2RlcyA+IDEpIHsKKwkJcmV0ID0gcHNwX3hnbWlfaW5pdGlhbGl6ZShwc3ApOworCQkvKiBXYXJu
aW5nIHRoZSBYR01JIHNlZXNpb24gaW5pdGlhbGl6ZSBmYWlsdXJlCisJCSAqIEluc3RlYWQgb2Yg
c3RvcCBkcml2ZXIgaW5pdGlhbGl6YXRpb24KKwkJICovCisJCWlmIChyZXQpCisJCQlkZXZfZXJy
KHBzcC0+YWRldi0+ZGV2LAorCQkJCSJYR01JOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBYR01JIHNl
c3Npb25cbiIpOworCX0KKworCWlmIChwc3AtPmFkZXYtPnBzcC50YV9mdykgeworCQlyZXQgPSBw
c3BfcmFzX2luaXRpYWxpemUocHNwKTsKKwkJaWYgKHJldCkKKwkJCWRldl9lcnIocHNwLT5hZGV2
LT5kZXYsCisJCQkJCSJSQVM6IEZhaWxlZCB0byBpbml0aWFsaXplIFJBU1xuIik7CisKKwkJcmV0
ID0gcHNwX2hkY3BfaW5pdGlhbGl6ZShwc3ApOworCQlpZiAocmV0KQorCQkJZGV2X2Vycihwc3At
PmFkZXYtPmRldiwKKwkJCQkiSERDUDogRmFpbGVkIHRvIGluaXRpYWxpemUgSERDUFxuIik7CisK
KwkJcmV0ID0gcHNwX2R0bV9pbml0aWFsaXplKHBzcCk7CisJCWlmIChyZXQpCisJCQlkZXZfZXJy
KHBzcC0+YWRldi0+ZGV2LAorCQkJCSJEVE06IEZhaWxlZCB0byBpbml0aWFsaXplIERUTVxuIik7
CisJfQorCiAJbXV0ZXhfdW5sb2NrKCZhZGV2LT5maXJtd2FyZS5tdXRleCk7CiAKIAlyZXR1cm4g
MDsKLS0KMi4xNy4xCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
