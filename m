Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5340C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED8C2053B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 17:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED8C2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659AB6EE0D;
	Wed,  6 Nov 2019 17:21:46 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F056EE0B
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 17:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2Wkld5Bh+XBLKvWS7vrl4C8ev7+FmFchDOvFs61KoXWUCAI4o8FvZzdhTFh9k7Z/rKnqaKm/cJFcLHV7DHGAmkXqKOjZgJn25QVsokCGbPptC7OKTMjAaVKulNJen970LxqJnkNJtVVANj1ORmoYPNTX/XxF+eUh8MayQxyLKmO7PFWyWGVLIF4po/+Hjde4rmbY55XPQXkX2308/VmrCwWCLLiTXQ5/a6bAQUb54le2GVT7JMWceK+7t3kVca4Vb7sjbtxJcFPb9DaIk/LhUxhyH54Vm54nV2KMPfvy4K3xtZaMSFO0ydQHMZhg45mb439u+ApsP9x5PQXst4Oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUHje3ZrhBlzNNQZaszHtQLzgV8LOeWf7UpcCN3/Vh4=;
 b=OE5C60FcpSAFRP9rrSPgRQann88xYPhcXR93zB6DsrxxenmeCR4dvBFObZnNPxeJDSc5UmfIAAu7gyer6z5dAZoTFyUtmsMu8d8Wsl9/acHAehzjzBKEeB+md5kCrxuqF3+VmyWiFt1quAKlFIpELkYtMosaocMbwMAlmKFArSiM3m5xUrGhwnVh+fz14GGkzG83huNozoHLwmJi0ONURWC/pV94XxvXdg3iijl6to7GheTSYTGM+15oev5Wcex0Jr/22qV9akoKbcYiI76tzLt/j2q8TxclSGSP2PDYz583Jb1CWx6ft5byDoG9bek7pOjF7M0kf9tq7MbmsiOGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2465.namprd12.prod.outlook.com (52.132.31.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 17:21:44 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::55f1:f8d5:e7d0:f595%2]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 17:21:43 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Topic: [PATCH] drm/amdgpu: Add comments to gmc structure
Thread-Index: AQHVlMaoZiNzkpPO+kWeyC0qA10mcw==
Date: Wed, 6 Nov 2019 17:21:43 +0000
Message-ID: <1573060895-13033-1-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::48) To BL0PR12MB2580.namprd12.prod.outlook.com
 (2603:10b6:207:3e::19)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: caa16083-55e1-4e8e-e30e-08d762ddcb4f
x-ms-traffictypediagnostic: BL0PR12MB2465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24651F03694CA5DC633071A280790@BL0PR12MB2465.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(6916009)(305945005)(2616005)(2351001)(25786009)(66066001)(81156014)(5640700003)(6512007)(2501003)(66946007)(8936002)(14454004)(2906002)(14444005)(86362001)(4326008)(6116002)(3846002)(50226002)(71190400001)(6486002)(36756003)(486006)(478600001)(99286004)(81166006)(6436002)(316002)(256004)(54906003)(8676002)(5660300002)(386003)(64756008)(52116002)(26005)(66476007)(66556008)(66446008)(6506007)(102836004)(186003)(476003)(71200400001)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2465;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hq8CO0E348moE+E7R7YR9htV3TuEOBkhjV6xA0pMA+E/jb5Vne0X4xlDrgnJIK0FJUlV7CkwXnZlXhI3Xip4FIxyhtfDGNXsP7BUR//XukTA9NDlcF/mLOgxm8hUV6L6azggG37CwnKjTx1G55p7I4aOCnZeH49eFq9B4f/YH7VR3cy9WdQoUIcfW1s0RkkOY5lA6/QG3f9Tpu1QjpvgQ12zPTC6kElE6Ewd/w01BHeOsFC3IcDSJg4xcWzwI0m9PH/Ivrx3TNqTpaeZol/QdkwZZ2x2OiE4IyX++8zsZPe8fVtXquEOIToGlKA7JYYCwvV6sf2UqfBX4J/5EPnjz+sQK+QRphwmYxS6NDEtTfowrMzePqtYhqMvQbTcHR/fCoX7HmbZa/wXGLyFS7i5wbfRZx9ugMyusWKP4YuWnz2RdvxfM4CLH6/XLFAKs6zY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa16083-55e1-4e8e-e30e-08d762ddcb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 17:21:43.8776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuwcN11oDAcCxvtf+Ej8PkiCcxAgRKtF/WtNt+XRkhOLP8xWf5PXqA+/W6zjt3DM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2465
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUHje3ZrhBlzNNQZaszHtQLzgV8LOeWf7UpcCN3/Vh4=;
 b=Q7XmGYNBPYrUPsmZmkcUmpTgUQlwKIwLSLJ6I+g/2z8axNIQtX8dgwaPzo1MNjPVWRrv3zQ/r15lVj6oY7ejn4mqkO9s/TwJg7UUeYTIoWRpGj7fBeV4LzQs+Tr0jrqjjQE+MuO9za/qtBjGBCWMat32nW485bNYiVrgK14iGlQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zeng, Oak" <Oak.Zeng@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106172143.1EIYPF0JdimzI6Hs6ojCg0cMu0MTmROfybtqlkZKIdQ@z>

RXhwbGFpbiBmaWVsZHMgbGlrZSBhcGVyX2Jhc2UsIGFncF9zdGFydCBldGMuIFRoZSBkZWZpbml0
aW9uCm9mIHRob3NlIGZpZWxkcyBhcmUgY29uZnVzaW5nIGFzIHRoZXkgYXJlIGZyb20gZGlmZmVy
ZW50IHZpZXcKKENQVSBvciBHUFUpLiBBZGQgY29tbWVudHMgZm9yIGVhc2llciB1bmRlcnN0YW5k
LgoKQ2hhbmdlLUlkOiBJMDJjMmEyN2NkMGRiYzIwNTQ5OGViODZhYWZhNzIyZjJlMGMyNWZlNgpT
aWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCAyNSArKysrKysrKysrKysrKysrKysrKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuaAppbmRleCA1NTVkOGU1Li44MDAzMjAxIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCkBAIC0xMjcsMTggKzEyNyw0MyBAQCBzdHJ1Y3Qg
YW1kZ3B1X3hnbWkgewogfTsKIAogc3RydWN0IGFtZGdwdV9nbWMgeworCS8qIEZCJ3MgcGh5c2lj
YWwgYWRkcmVzcyBpbiBNTUlPIHNwYWNlIChmb3IgQ1BVIHRvCisJICogbWFwIEZCKS4gVGhpcyBp
cyBkaWZmZXJlbnQgY29tcGFyZWQgdG8gdGhlIGFwZy8KKwkgKiBnYXJ0L3ZyYW1fc3RhcnQvZW5k
IGZpZWxkIGFzIHRoZSBsYXRlciBpcyBmcm9tCisJICogR1BVJ3MgdmlldyBhbmQgYXBlcl9iYXNl
IGlzIGZyb20gQ1BVJ3Mgdmlldy4KKwkgKi8KIAlyZXNvdXJjZV9zaXplX3QJCWFwZXJfc2l6ZTsK
IAlyZXNvdXJjZV9zaXplX3QJCWFwZXJfYmFzZTsKIAkvKiBmb3Igc29tZSBjaGlwcyB3aXRoIDw9
IDMyTUIgd2UgbmVlZCB0byBsaWUKIAkgKiBhYm91dCB2cmFtIHNpemUgbmVhciBtYyBmYiBsb2Nh
dGlvbiAqLwogCXU2NAkJCW1jX3ZyYW1fc2l6ZTsKIAl1NjQJCQl2aXNpYmxlX3ZyYW1fc2l6ZTsK
KwkvKiBBUEcgYXBlcnR1cmUgc3RhcnQgYW5kIGVuZCBpbiBNQyBhZGRyZXNzIHNwYWNlCisJICog
RHJpdmVyIGZpbmQgYSBob2xlIGluIHRoZSBNQyBhZGRyZXNzIHNwYWNlCisJICogdG8gcGxhY2Ug
QUdQIGJ5IHNldHRpbmcgTUNfVk1fQUdQX0JPVC9UT1AgcmVnaXN0ZXJzCisJICogVW5kZXIgVk1J
RDAsIGxvZ2ljYWwgYWRkcmVzcyA9PSBNQyBhZGRyZXNzCisJICogQUdQIGFwZXJ0dXJlIGlzIHVz
ZWQgdG8gc2ltdWxhdGUgRkIgaW4gWkZCIGNhc2UKKwkgKi8KIAl1NjQJCQlhZ3Bfc2l6ZTsKIAl1
NjQJCQlhZ3Bfc3RhcnQ7CiAJdTY0CQkJYWdwX2VuZDsKKwkvKiBHQVJUIGFwZXJ0dXJlIHN0YXJ0
IGFuZCBlbmQgaW4gTUMgYWRkcmVzcyBzcGFjZQorCSAqIERyaXZlciBmaW5kIGEgaG9sZSBpbiB0
aGUgTUMgYWRkcmVzcyBzcGFjZQorCSAqIHRvIHBsYWNlIEdBUlQgYnkgc2V0dGluZyBWTV9DT05U
RVhUMF9QQUdFX1RBQkxFX1NUQVJUL0VORF9BRERSCisJICogcmVnaXN0ZXJzCisJICogVW5kZXIg
Vk1JRDAsIGxvZ2ljYWwgYWRkcmVzcyBpbnNpZGUgR0FSVCBhcGVydHVyZSB3aWxsCisJICogYmUg
dHJhbnNsYXRlZCB0aHJvdWdoIGdwdXZtIGdhcnQgcGFnZSB0YWJsZSB0byBhY2Nlc3MKKwkgKiBw
YWdlZCBzeXN0ZW0gbWVtb3J5CisJICovCiAJdTY0CQkJZ2FydF9zaXplOwogCXU2NAkJCWdhcnRf
c3RhcnQ7CiAJdTY0CQkJZ2FydF9lbmQ7CisJLyogRnJhbWUgYnVmZmVyIGFwZXJ0dXJlIG9mIHRo
aXMgR1BVIGRldmljZS4gRGlmZmVyZW50IGZyb20KKwkgKiBmYl9zdGFydCAoc2VlIGJlbG93KSwg
dGhpcyBvbmx5IGNvdmVycyB0aGUgbG9jYWwgR1BVIGRldmljZS4KKwkgKiBEcml2ZXIgZ2V0IGZi
X3N0YXJ0IGZyb20gTUNfVk1fRkJfTE9DQVRJT05fQkFTRSAoc2V0IGJ5IHZiaW9zKQorCSAqIGFu
ZCBjYWxjdWxhdGUgdnJhbV9zdGFydCBvZiB0aGlzIGxvY2FsIGRldmljZSBieSBhZGRpbmcgYW4K
KwkgKiBvZmZzZXQgaW5zaWRlIHRoZSBYR01JIGhpdmUuCisJICovCiAJdTY0CQkJdnJhbV9zdGFy
dDsKIAl1NjQJCQl2cmFtX2VuZDsKIAkvKiBGQiByZWdpb24gLCBpdCdzIHNhbWUgYXMgbG9jYWwg
dnJhbSByZWdpb24gaW4gc2luZ2xlIEdQVSwgaW4gWEdNSQotLSAKMi43LjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
