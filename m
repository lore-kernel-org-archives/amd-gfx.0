Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06829CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 21:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44DF2054F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 21:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44DF2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990716E828;
	Thu, 24 Oct 2019 21:16:59 +0000 (UTC)
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr710053.outbound.protection.outlook.com [40.107.71.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68606E828
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 21:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeW6O/k9Cz0g/V2Hf7Tk/KGosxG1/A0dkOw9VkQrvY+q0shy6JNASxdw9eLwF/6nrsh5OmerbKCtpp6VGh+sb2c0k5wKxtbfaAPUcO5kilg8yP5DzgBshzrDE9GHlfF74KStw3tVOPBIdxFIeTATiUD3l/caRbYOni49LPUkueiGB02Dj3QPFKcNZVoM1HnvCC+xohXvrZ/Gi+RrFhRsr97JMfM8fofMfQI3dYTUaMJOndfsfjHaa8jO81yi2VWNObAjw0sXl6/PoWcbVKoSLQoQ2hbG2dVesMR1p9sENhlsO1xeUz2GVyxSrooF0/ZEUSfzginCgH236CJMOFw+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIRQPcrZPEzmJOTdgx48GN8YMx1mAtdyppt0Y91Lvq0=;
 b=G+i04HpEsv7fHhxe6dbvpvd8FE8Mk0sNwqPOwqHolmkS58tlj9UWvFzOSVEhU2WGQWJA/4r6qwlq/SWJby7quw2/SCWR6wD3pz7CJfDdsnZLm43YD1EgzzO+WuS3xE/cyLG4ZUB1Je+Rth4KiTkL/1mosO7aJKbv26P29ktGYjfJkY9s+dvOWqViR5zOSTdDRSBXhMhKQOyrD5ip/OrCbQMG7oCKEAe/FW89V3JIjIa44QkojNLs6ruTiV0P4J8SrV3oTpE5nJ8oHV2z/1X80gYz+sV/D9cfs8nv7KZ3vO9wUZT4zYm8YfuISpNd00my87xjU8IIjvvNM+dpi95YXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.198.10) by
 DM6PR12MB3402.namprd12.prod.outlook.com (20.178.198.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 24 Oct 2019 21:16:56 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::6006:422c:ecdf:e550]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::6006:422c:ecdf:e550%6]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 21:16:56 +0000
From: "Tuikov, Luben" <Luben.Tuikov@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: GFX9, GFX10: GRBM requires 1-cycle delay
Thread-Topic: [PATCH] drm/amdgpu: GFX9, GFX10: GRBM requires 1-cycle delay
Thread-Index: AQHVirBdkQ0XOg6j30Ko4PUIPpXYhg==
Date: Thu, 24 Oct 2019 21:16:55 +0000
Message-ID: <20191024211430.25399-1-luben.tuikov@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::33) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:38::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0.385.gbc12974a89
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7345642d-ce4c-49ea-030c-08d758c77f6f
x-ms-traffictypediagnostic: DM6PR12MB3402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3402310B21E3E96B10D22B69996A0@DM6PR12MB3402.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(6436002)(2501003)(50226002)(66946007)(64756008)(305945005)(66446008)(81156014)(8676002)(36756003)(14444005)(99286004)(71200400001)(86362001)(66476007)(54906003)(7736002)(3846002)(66556008)(316002)(52116002)(256004)(6506007)(386003)(2906002)(4326008)(486006)(66066001)(81166006)(71190400001)(478600001)(14454004)(476003)(1076003)(6486002)(6916009)(2351001)(25786009)(26005)(186003)(5660300002)(5640700003)(6512007)(8936002)(2616005)(102836004)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3402;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVGkdmXGfFikbsAO1uXdKP6WNMOg/0quoB2hEH6sS+iCsHWgZhWOBnjm8HpaOQg6StxmK6y5M01zZ2kem9TJAeZjwZpXiWh4kk1CknVkkjpJigOgIZpmZlPvRPx3tBzylVi7VwDOFwxwTTmzbqUa7K3hJLQ/zUr6kJyS2D3t11DsFZW2xONX5z97FV7RghBBZdOFXpJXxGrSRsNlUuLOWyqxA4GFbU9NILf9j9pB3PdUzrvV28vh5iUVOosAIVsDCgE2bqJ4jPNiTZTi61KXMtlEHCiP+k8sa2W3KoBI0+BMQxo9Ux92DVp7eq+RHBMFv1dTJlo3qSkvIT2Kk65PgPo4pN6KQY089kPrRZzQym9QhEd0VKhWaoOaMN2z5tT+FqXVDuzGovb3zjFZQO8Bber5KMDT3EFulHvxlCGW/juWaDVZZTuJIN82LeExllmc
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7345642d-ce4c-49ea-030c-08d758c77f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 21:16:55.8550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1GZD8ypkj1RvrCnzSuA5iNfQBfbPwBrL2xIQ3ydGosgm1ImkaEpg0QtYhpMIqDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIRQPcrZPEzmJOTdgx48GN8YMx1mAtdyppt0Y91Lvq0=;
 b=BwCZdUDT7y7sACO2fNzPoh7NL3fTTVqce4071Lap7ua6L5HWMMNp0fho/BobgrXPasnQ2RVk7MGGz6ulgJ38trtYW2QwmAGu94PTUSirEwkmWEcJLmuA1G5Vnmgjjyy74dZl0Yd6iwMrXcpCvEF3mpfLFC8PJ6DUq8R3HB5/ODM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024211655.GAgjLCp5HA_n5PUnf48YFzaor8-Ge5NRn2cT-52EGEo@z>

VGhlIEdSQk0gaW50ZXJmYWNlIGlzIG5vdyBjYXBhYmxlIG9mIGJ1cnN0aW5nCjEtY3ljbGUgb3Ag
cGVyIHJlZ2lzdGVyLCBhIFdSSVRFIGZvbGxvd2VkIGJ5CmFub3RoZXIgV1JJVEUsIG9yIGEgV1JJ
VEUgZm9sbG93ZWQgYnkgYSBSRUFELS1tdWNoCmZhc3RlciB0aGFuIHByZXZpb3VzIG11dGktY3lj
bGUgcGVyCmNvbXBsZXRlZC10cmFuc2FjdGlvbiBpbnRlcmZhY2UuIFRoaXMgY2F1c2VzIGEKcHJv
YmxlbSwgd2hlcmVieSBzdGF0dXMgcmVnaXN0ZXJzIHJlcXVpcmluZyBhCnJlYWQvd3JpdGUgYnkg
aGFyZHdhcmUsIGhhdmUgYSAxLWN5Y2xlIGRlbGF5LCBkdWUKdG8gdGhlIHJlZ2lzdGVyIHVwZGF0
ZSBoYXZpbmcgdG8gZ28gdGhyb3VnaCBHUkJNCmludGVyZmFjZS4KClRoaXMgcGF0Y2ggYWRkcyB0
aGlzIGRlbGF5LgoKQSBvbmUgY3ljbGUgcmVhZCBvcCBpcyBhZGRlZCBhZnRlciB1cGRhdGluZyB0
aGUKaW52YWxpZGF0ZSByZXF1ZXN0IGFuZCBiZWZvcmUgcmVhZGluZyB0aGUKaW52YWxpZGF0ZS1B
Q0sgc3RhdHVzLgoKU2VlIGFsc28gY29tbWl0CjUzNDk5MTczMWNiNWZhOTRiNTUxOTk1NzY0NmNm
ODQ5Y2ExMGQxN2QuCgpTaWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgNCAr
Ky0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jICB8IDQgKystLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCA5ICsrKysrKysrKwogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyAgfCA4ICsrKysrKysrCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyB8IDIgKy0KIDUgZmlsZXMgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jCmluZGV4IGFjNDNiMWFmNjllMy4uMDA0Mjg2OGRiZDUzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtNTEyOSw3ICs1MTI5LDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjEwXzBfcmluZ19mdW5jc19nZnggPSB7
CiAJCTUgKyAvKiBDT05EX0VYRUMgKi8KIAkJNyArIC8qIFBJUEVMSU5FX1NZTkMgKi8KIAkJU09D
MTVfRkxVU0hfR1BVX1RMQl9OVU1fV1JFRyAqIDUgKwotCQlTT0MxNV9GTFVTSF9HUFVfVExCX05V
TV9SRUdfV0FJVCAqIDcgKworCQlTT0MxNV9GTFVTSF9HUFVfVExCX05VTV9SRUdfV0FJVCAqIDcg
KiAyICsKIAkJMiArIC8qIFZNX0ZMVVNIICovCiAJCTggKyAvKiBGRU5DRSBmb3IgVk1fRkxVU0gg
Ki8KIAkJMjAgKyAvKiBHRFMgc3dpdGNoICovCkBAIC01MTgyLDcgKzUxODIsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92MTBfMF9yaW5nX2Z1bmNzX2NvbXB1
dGUgPSB7CiAJCTUgKyAvKiBoZHAgaW52YWxpZGF0ZSAqLwogCQk3ICsgLyogZ2Z4X3YxMF8wX3Jp
bmdfZW1pdF9waXBlbGluZV9zeW5jICovCiAJCVNPQzE1X0ZMVVNIX0dQVV9UTEJfTlVNX1dSRUcg
KiA1ICsKLQkJU09DMTVfRkxVU0hfR1BVX1RMQl9OVU1fUkVHX1dBSVQgKiA3ICsKKwkJU09DMTVf
RkxVU0hfR1BVX1RMQl9OVU1fUkVHX1dBSVQgKiA3ICogMiArCiAJCTIgKyAvKiBnZnhfdjEwXzBf
cmluZ19lbWl0X3ZtX2ZsdXNoICovCiAJCTggKyA4ICsgOCwgLyogZ2Z4X3YxMF8wX3JpbmdfZW1p
dF9mZW5jZSB4MyBmb3IgdXNlciBmZW5jZSwgdm0gZmVuY2UgKi8KIAkuZW1pdF9pYl9zaXplID0J
NywgLyogZ2Z4X3YxMF8wX3JpbmdfZW1pdF9pYl9jb21wdXRlICovCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3Y5XzAuYwppbmRleCA5ZmU5NWU3NjkzZDUuLjlhN2E3MTcyMDhkZSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC02MjE4LDcgKzYyMTgsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIGdmeF92OV8wX3JpbmdfZnVuY3NfZ2Z4
ID0gewogCQk1ICsgIC8qIENPTkRfRVhFQyAqLwogCQk3ICsgIC8qIFBJUEVMSU5FX1NZTkMgKi8K
IAkJU09DMTVfRkxVU0hfR1BVX1RMQl9OVU1fV1JFRyAqIDUgKwotCQlTT0MxNV9GTFVTSF9HUFVf
VExCX05VTV9SRUdfV0FJVCAqIDcgKworCQlTT0MxNV9GTFVTSF9HUFVfVExCX05VTV9SRUdfV0FJ
VCAqIDcgKiAyICsKIAkJMiArIC8qIFZNX0ZMVVNIICovCiAJCTggKyAgLyogRkVOQ0UgZm9yIFZN
X0ZMVVNIICovCiAJCTIwICsgLyogR0RTIHN3aXRjaCAqLwpAQCAtNjI3MSw3ICs2MjcxLDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBnZnhfdjlfMF9yaW5nX2Z1bmNz
X2NvbXB1dGUgPSB7CiAJCTUgKyAvKiBoZHAgaW52YWxpZGF0ZSAqLwogCQk3ICsgLyogZ2Z4X3Y5
XzBfcmluZ19lbWl0X3BpcGVsaW5lX3N5bmMgKi8KIAkJU09DMTVfRkxVU0hfR1BVX1RMQl9OVU1f
V1JFRyAqIDUgKwotCQlTT0MxNV9GTFVTSF9HUFVfVExCX05VTV9SRUdfV0FJVCAqIDcgKworCQlT
T0MxNV9GTFVTSF9HUFVfVExCX05VTV9SRUdfV0FJVCAqIDcgKiAyICsKIAkJMiArIC8qIGdmeF92
OV8wX3JpbmdfZW1pdF92bV9mbHVzaCAqLwogCQk4ICsgOCArIDgsIC8qIGdmeF92OV8wX3Jpbmdf
ZW1pdF9mZW5jZSB4MyBmb3IgdXNlciBmZW5jZSwgdm0gZmVuY2UgKi8KIAkuZW1pdF9pYl9zaXpl
ID0JNywgLyogZ2Z4X3Y5XzBfcmluZ19lbWl0X2liX2NvbXB1dGUgKi8KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMF8wLmMKaW5kZXggNmUxYjI1YmQxZmU3Li4xMDBkNTI2ZTlhNDIgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCkBAIC0zNDYsNiArMzQ2LDE1IEBA
IHN0YXRpYyB1aW50NjRfdCBnbWNfdjEwXzBfZW1pdF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZywKIAogCWFtZGdwdV9yaW5nX2VtaXRfd3JlZyhyaW5nLCBodWItPnZtX2lu
dl9lbmcwX3JlcSArIGVuZywgcmVxKTsKIAorCS8qIEluc2VydCBhIGR1bW15IHJlYWQgdG8gZGVs
YXkgb25lIGN5Y2xlIGJlZm9yZSB0aGUgQUNLCisJICogaW5xdWlyeS4KKwkgKi8KKwlpZiAocmlu
Zy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9TRE1BIHx8CisJICAgIHJpbmctPmZ1
bmNzLT50eXBlID09IEFNREdQVV9SSU5HX1RZUEVfR0ZYICB8fAorCSAgICByaW5nLT5mdW5jcy0+
dHlwZSA9PSBBTURHUFVfUklOR19UWVBFX0NPTVBVVEUpCisJCWFtZGdwdV9yaW5nX2VtaXRfcmVn
X3dhaXQocmluZywKKwkJCQkJICBodWItPnZtX2ludl9lbmcwX3JlcSArIGVuZywgMCwgMCk7CisK
IAkvKiB3YWl0IGZvciB0aGUgaW52YWxpZGF0ZSB0byBjb21wbGV0ZSAqLwogCWFtZGdwdV9yaW5n
X2VtaXRfcmVnX3dhaXQocmluZywgaHViLT52bV9pbnZfZW5nMF9hY2sgKyBlbmcsCiAJCQkJICAx
IDw8IHZtaWQsIDEgPDwgdm1pZCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwpp
bmRleCA5ZjJhODkzODcxZWMuLjhmMzA5N2U0NTI5OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jCkBAIC00OTUsNiArNDk1LDE0IEBAIHN0YXRpYyB1aW50NjRfdCBnbWNfdjlf
MF9lbWl0X2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogCWFtZGdwdV9y
aW5nX2VtaXRfd3JlZyhyaW5nLCBodWItPmN0eDBfcHRiX2FkZHJfaGkzMiArICgyICogdm1pZCks
CiAJCQkgICAgICB1cHBlcl8zMl9iaXRzKHBkX2FkZHIpKTsKIAorCS8qIEluc2VydCBhIGR1bW15
IHJlYWQgdG8gZGVsYXkgb25lIGN5Y2xlIGJlZm9yZSB0aGUgQUNLCisJICogaW5xdWlyeS4KKwkg
Ki8KKwlpZiAocmluZy0+ZnVuY3MtPnR5cGUgPT0gQU1ER1BVX1JJTkdfVFlQRV9HRlggIHx8CisJ
ICAgIHJpbmctPmZ1bmNzLT50eXBlID09IEFNREdQVV9SSU5HX1RZUEVfQ09NUFVURSkKKwkJYW1k
Z3B1X3JpbmdfZW1pdF9yZWdfd2FpdChyaW5nLAorCQkJCQkgIGh1Yi0+dm1faW52X2VuZzBfcmVx
ICsgZW5nLCAwLCAwKTsKKwogCWFtZGdwdV9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0KHJp
bmcsIGh1Yi0+dm1faW52X2VuZzBfcmVxICsgZW5nLAogCQkJCQkgICAgaHViLT52bV9pbnZfZW5n
MF9hY2sgKyBlbmcsCiAJCQkJCSAgICByZXEsIDEgPDwgdm1pZCk7CmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjVfMC5jCmluZGV4IGI4ZmRiMTkyZjZkNi4uMGM0MWI0ZmRjNThiIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwpAQCAtMTU4OCw3ICsxNTg4LDcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyBzZG1hX3Y1XzBfcmluZ19mdW5j
cyA9IHsKIAkJNiArIC8qIHNkbWFfdjVfMF9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYyAqLwogCQkv
KiBzZG1hX3Y1XzBfcmluZ19lbWl0X3ZtX2ZsdXNoICovCiAJCVNPQzE1X0ZMVVNIX0dQVV9UTEJf
TlVNX1dSRUcgKiAzICsKLQkJU09DMTVfRkxVU0hfR1BVX1RMQl9OVU1fUkVHX1dBSVQgKiA2ICsK
KwkJU09DMTVfRkxVU0hfR1BVX1RMQl9OVU1fUkVHX1dBSVQgKiA2ICogMiArCiAJCTEwICsgMTAg
KyAxMCwgLyogc2RtYV92NV8wX3JpbmdfZW1pdF9mZW5jZSB4MyBmb3IgdXNlciBmZW5jZSwgdm0g
ZmVuY2UgKi8KIAkuZW1pdF9pYl9zaXplID0gNyArIDYsIC8qIHNkbWFfdjVfMF9yaW5nX2VtaXRf
aWIgKi8KIAkuZW1pdF9pYiA9IHNkbWFfdjVfMF9yaW5nX2VtaXRfaWIsCi0tIAoyLjIzLjAuMzg1
LmdiYzEyOTc0YTg5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
