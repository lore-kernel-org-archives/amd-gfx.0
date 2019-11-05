Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76364CA9ED0
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 08:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E42E20818
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 08:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E42E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C7F6E920;
	Tue,  5 Nov 2019 08:22:43 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720041.outbound.protection.outlook.com [40.107.72.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105776E920
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 08:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVqjZ/VOizB6ZbEQSdJEoVu3aPsIjwms4hLTaW6dyILOvZGYtym4AvpncQ1W947xwFRvS+83tdWe6d6Qh/VH1ronnXR9V7vfuWU6kNC68D0LPKKO79KPGqXRwCs6HQ8nUG5lJsqmTMCspo6k8/x9r5oz4t1dwPg43XVGC6oJECd9nKYvz2uuCqJHDOwSKFboH4FJo3uM8XOUrzXTHK65cnC0paqvonUskINO6ANMcIW0tN8AEVZcmxwr60/0Gpi4Ydwwg4NBg5wkKOFtW/sPgVaT0Qv82g9WYABc9vFefUZlWYymye8Mv0JpwmJ1NaQ5IjR5cY8QMvcG1/EhY2PTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fePUejgsTCpadoU1bnZjtL5FBhfEyT3YWJ8RMZfo0Tc=;
 b=EXSWTVbYQUeJD+xfAAjczwuZzkuGOqPGYfUP1bzBL9rnM+WbMDD2ut8ZeZNRQ5E/Z0+xy9W9Wf8wwghnKxWiZwAiJMe4gOHDXZh/p8obdQTciD3vfqgkVKKacnkkZp/mHw4MJqPf38I4bU3hPTec2J2oIkmEs6yFj+XIZRrzeP27xMHjMwl9L1SqYnwMnbpYFZWAeDU1QpqNdpErPcX/Sif4e2HGlrXQ19gmFkcBBd3l5Z6Nr8jgsnuAohDr2fwUF+0pimc0S5WRrqfhkvhWDZL7XI7SORIFgS0xkLYgAnJSkD86hTCXujL3mVrviJjdDAgld5+QmWuDHtUNRa9qqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 5 Nov 2019 08:22:39 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 08:22:39 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: update Arcturus driver-smu interface header
Thread-Topic: [PATCH] drm/amd/powerplay: update Arcturus driver-smu interface
 header
Thread-Index: AQHVk7Ivu79ePOc7RkGMR+VD1ySeGA==
Date: Tue, 5 Nov 2019 08:22:38 +0000
Message-ID: <20191105082218.19972-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:36::22) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4e9450b-2f6f-4a23-990f-08d761c951d8
x-ms-traffictypediagnostic: MN2PR12MB3935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39351F55D58E333D13164D77E47E0@MN2PR12MB3935.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(66946007)(14454004)(305945005)(7736002)(256004)(6512007)(2351001)(5660300002)(478600001)(2501003)(25786009)(99286004)(4326008)(6916009)(86362001)(2616005)(186003)(71190400001)(71200400001)(36756003)(81166006)(6486002)(316002)(486006)(476003)(6506007)(81156014)(8936002)(2906002)(50226002)(386003)(6436002)(8676002)(66446008)(1076003)(64756008)(5640700003)(66556008)(52116002)(66476007)(102836004)(3846002)(6116002)(66066001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3935;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqaNbjNlImfcl1Dys+6RgdEwpDeRas0epbP4s8dr2qbU7iSvfhZO6yYp3JR1gSgmONVcid6Zw+v5bTu9WDQts8bzeGT12uhw3LsrV8XAue6I1yLoReWFUjtZjf0wXx5ajG9yF8fFBOkUUMwOVkTAxRQ6f63l1VY691MxxpVastdACHoCowrkiLcuLoAcW6qxYDGouVl99D0qOX+QY5QexinehZyIux/tAurBRIiBVtiQVwEU8Kpnvunou1vo+SHpOvMXuiJI++cx8kU06veTDSeVoebII0LkBVAv5Lf2LjKgLZj7U4wKhP9FNkSBAYYNg/rim8NgRzfLGx/zV8RJOPpfZs5tNab9ZqkkX5jJuSWvwpM7h4M95NJVmyvYsch61SngXnXOJz4WBhZe/F2kw0bAnyL8hVV+SvY63Q658VCKL9FZJaVRVIJ5YRAYS4i8
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e9450b-2f6f-4a23-990f-08d761c951d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 08:22:38.7953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Af8jAYeeTF1OSp+Q+28Q6UCyOzN73E5BH2pHkboqG03lfKdyrAtm4kIT1Ur8ylH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fePUejgsTCpadoU1bnZjtL5FBhfEyT3YWJ8RMZfo0Tc=;
 b=qmOHclybt8QmUDp/n0ae1WjtiiprW8UchsamJ16XcEDAY8KBEgMI+JWCcJJaQwhI4bK+rtLLZlqoP/0xq2lOxjpZ/btpE/bK48zdCE0ld1M00gOnKjBmg2E3DLWvx9WcrBCExdNnBlI5joII/hxuFDEe6OgplqfJyfgh9pCIQ78=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105082238.jrg8P47KGzN5by7v1aXbvq3Jdxw-79Weqz578jgd-u0@z>

VG8gZml0IHRoZSBsYXRlc3QgU01VIGZpcm13YXJlLgoKQ2hhbmdlLUlkOiBJYjE5N2U2MTg2MTI3
MTIxYjRhZTI3NjYzOWZhNjY2NzcwOTRhN2QwMQpTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2
YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9z
bXUxMV9kcml2ZXJfaWZfYXJjdHVydXMuaCB8IDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9zbXVfdjExXzAuaCAgICAgICAgICAgICAgICB8IDIgKy0KIDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXUxMV9kcml2ZXJfaWZfYXJjdHVydXMuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXUxMV9kcml2ZXJfaWZfYXJjdHVy
dXMuaAppbmRleCA4ODZiOWEyMWViZDguLmE4ODZmMDY0NGQyNCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdTExX2RyaXZlcl9pZl9hcmN0dXJ1cy5oCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXUxMV9kcml2ZXJfaWZfYXJj
dHVydXMuaApAQCAtMTU5LDcgKzE1OSw3IEBACiAvL0ZJWE1FIG5lZWQgdXBkYXRpbmcKIC8vIERl
YnVnIE92ZXJyaWRlcyBCaXRtYXNrCiAjZGVmaW5lIERQTV9PVkVSUklERV9ESVNBQkxFX1VDTEtf
UElEICAgICAgICAgICAgICAgMHgwMDAwMDAwMQotI2RlZmluZSBEUE1fT1ZFUlJJREVfRU5BQkxF
X1ZPTFRfTElOS19WQ05fRkNMSyAgICAgIDB4MDAwMDAwMDIKKyNkZWZpbmUgRFBNX09WRVJSSURF
X0RJU0FCTEVfVk9MVF9MSU5LX1ZDTl9GQ0xLICAgICAweDAwMDAwMDAyCiAKIC8vIEkyQyBDb25m
aWcgQml0IERlZmluZXMKICNkZWZpbmUgSTJDX0NPTlRST0xMRVJfRU5BQkxFRCAgICAgICAgICAg
MQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdV92MTFf
MC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL3NtdV92MTFfMC5oCmluZGV4
IDg4ZWU2NjY4MzI3MS4uMzYwMjhlOWQxMDExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9pbmMvc211X3YxMV8wLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaW5jL3NtdV92MTFfMC5oCkBAIC0yNyw3ICsyNyw3IEBACiAKICNkZWZpbmUgU01V
MTFfRFJJVkVSX0lGX1ZFUlNJT05fSU5WIDB4RkZGRkZGRkYKICNkZWZpbmUgU01VMTFfRFJJVkVS
X0lGX1ZFUlNJT05fVkcyMCAweDEzCi0jZGVmaW5lIFNNVTExX0RSSVZFUl9JRl9WRVJTSU9OX0FS
Q1QgMHgwRgorI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9BUkNUIDB4MTAKICNkZWZp
bmUgU01VMTFfRFJJVkVSX0lGX1ZFUlNJT05fTlYxMCAweDMzCiAjZGVmaW5lIFNNVTExX0RSSVZF
Ul9JRl9WRVJTSU9OX05WMTIgMHgzMwogI2RlZmluZSBTTVUxMV9EUklWRVJfSUZfVkVSU0lPTl9O
VjE0IDB4MzQKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
