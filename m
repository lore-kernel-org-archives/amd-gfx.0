Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00544C010A4
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0658206BA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0658206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995036E9B4;
	Tue,  5 Nov 2019 10:23:19 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720073.outbound.protection.outlook.com [40.107.72.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB686E9B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 10:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJbXj20DJU1sVeOTr9t90Cs+wMlFSRucz14fmK6NZjx7cbZxymdERza9T9By9es8Q86gilfAl+R3U24+P63OHncGEYJt3SdQ4vjOiTMriy30mNsIrEkIlCdEQvPnkWVLqYjLyyxi2A7QUFrKCjI1LXGP7KJ+q08qIHC82g1HbIZeLxbWs0j+rMq3ZffsZ5oGq+YAcYUAWbTJyJzgSt+pQMRb2F4dZS/NahBL32QV6ykO4w8JEE+eFNuKVOOGip6mHCpO84Fyr+4caemnLvMGCyAI3NkfJWyfyJv/RGjYSmK9FqkzODc++Dl65FVlHpIEr5h1xIGAGcgEOTG7v0HmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH1Spk5vb9M/cJ/JTvCW4VozDl3asR+wtRPpBsmy10g=;
 b=dB1c6vYkigw+vhFZJU1buUvmHUHBEOLsfzN5s2oWUOEUOCQ+5N9zdwWt79oXql8NsjfGWZwVryQW0zBSduQTAga2HIxnvDA3+3t8fjyOEcsMSs9Xji0JtpGIcCLP/hLrrOlPVKBYzlupdoiXP0Eiu8af1vg36vNIl1ctBMQIQn1hE+dih0VfOOBeSQAA2xh+EDfCPyIZUtCJz5QbD4aIrYOMKjpmGcoSwDlvEyvK/fwxgWNTe4Slt+0OLIxu1dVvj4QIukLdXYS+gpWH+eQ3dd2aP96GdaPudSXUqBKa68W1LEwm3WJ1pSc0nH4a2oAD6XeZldof+UpoFWsDbEoHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB2960.namprd12.prod.outlook.com (20.179.82.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 10:23:17 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::3db4:a949:8b89:33be]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::3db4:a949:8b89:33be%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 10:23:17 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/swSMU: fix smu workload bit map error
Thread-Topic: [PATCH] drm/amd/swSMU: fix smu workload bit map error
Thread-Index: AQHVk8MJd2VpLOnQMUGIiK8RW7QVPg==
Date: Tue, 5 Nov 2019 10:23:16 +0000
Message-ID: <20191105102302.21037-1-kevin1.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:36::16) To MN2PR12MB3296.namprd12.prod.outlook.com
 (2603:10b6:208:aa::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd779d48-56b3-4cca-89b9-08d761da2c20
x-ms-traffictypediagnostic: MN2PR12MB2960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2960A3688A01920F3CF49A5DA27E0@MN2PR12MB2960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(199004)(189003)(2616005)(2906002)(186003)(54906003)(99286004)(1076003)(81166006)(6916009)(316002)(5640700003)(6506007)(386003)(52116002)(66556008)(7736002)(25786009)(102836004)(2351001)(66476007)(66946007)(8936002)(71200400001)(66446008)(71190400001)(305945005)(64756008)(3846002)(6116002)(81156014)(8676002)(4326008)(86362001)(6436002)(256004)(14454004)(26005)(2501003)(486006)(5660300002)(6486002)(6512007)(36756003)(478600001)(66066001)(50226002)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2960;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghiPjlnagBG245x/7CyiWyHbHrZEx8DLjofdHLDIstSbneZqJtRp+OoMxDbNswQuq9pYkQCD3B4kCqioxCdZgI6pJ4esJ7FFMc5S8jRfXimZOmWIsTjZCXGqhhSxN3BIjEQYDasjaq9GTtPMUWGht/WkDR/SviQz8+lgSpSYK6ykTqdNN+8E7qxWpcUwpVjIKxaM2zbmWyl29J6anNAjEOGPh3NJRSsjdQcD1V6mnwG4OQJE2jRS9y96ctPLIqH9sFkEpD4o0G9G0r9cZG/2wa6o3WPawuwXIP9BsTYEyWaq5MdiIKS9uWtMLRYRlqBk9oTY4ft/TS2cFW0eOVz8bt7qfILCdWnIY2NwzPe/p6OfbRcTMXV3a59oWR2zMweWJqIRbciDOeUE3cVEbWfMyM3Prviaj44ugclATdPjIrnyDJCDMlNnwjAaAD4ojZvi
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd779d48-56b3-4cca-89b9-08d761da2c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 10:23:17.0607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Af1Aoi+CzXNisaYrvFszdZLkKQVDB+7v9F9fiJuRCxY5JRui8fC+7iwTZmB/QsG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH1Spk5vb9M/cJ/JTvCW4VozDl3asR+wtRPpBsmy10g=;
 b=gGkcvCRDcxH5pvpixGPhSquEVETw/5ffXPAbst6bx4AIIEftKxZ+985OhdQAnANxFujUKJGPaB9wm0dJT3s2DUhCraY5IoSdRO+ZsHhy7Q9FafoNoXA2i4u1jZ9qtpMbyTAKCjeoHu3dLSzwrIhKQv8coso8ZGTKNjNiveXobT0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105102316.n4JekBGwPhkFbbfllhQSaQwwIbLNIZRpS4HCVP5rUus@z>

Zml4IHdvcmtsb2FkIGJpdCAoV09SS0xPQURfUFBMSUJfQ09NUFVURV9CSVQpIG1hcCBlcnJvcgpv
biB2ZWdhMjAgYW5kIG5hdmkgYXNpYy4KCmZpeCBjb21taXQ6CmRybS9hbWQvcG93ZXJwbGF5OiBh
ZGQgZnVuY3Rpb24gZ2V0X3dvcmtsb2FkX3R5cGVfbWFwIGZvciBzd3NtdQoKU2lnbmVkLW9mZi1i
eTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMgfCAyICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS92ZWdhMjBfcHB0LmMgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9uYXZpMTBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZp
MTBfcHB0LmMKaW5kZXggNzY5Zjk0NTFkOTA0Li4zNTRmNzA5NzhmODIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKQEAgLTIwNyw3ICsyMDcsNyBAQCBzdGF0
aWMgc3RydWN0IHNtdV8xMV8wX2NtbjJhaXNjX21hcHBpbmcgbmF2aTEwX3dvcmtsb2FkX21hcFtQ
UF9TTUNfUE9XRVJfUFJPRklMRQogCVdPUktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJPRklMRV9Q
T1dFUlNBVklORywJCVdPUktMT0FEX1BQTElCX1BPV0VSX1NBVklOR19CSVQpLAogCVdPUktMT0FE
X01BUChQUF9TTUNfUE9XRVJfUFJPRklMRV9WSURFTywJCVdPUktMT0FEX1BQTElCX1ZJREVPX0JJ
VCksCiAJV09SS0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZSLAkJCVdPUktMT0FEX1BQ
TElCX1ZSX0JJVCksCi0JV09SS0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUs
CQlXT1JLTE9BRF9QUExJQl9DVVNUT01fQklUKSwKKwlXT1JLTE9BRF9NQVAoUFBfU01DX1BPV0VS
X1BST0ZJTEVfQ09NUFVURSwJCVdPUktMT0FEX1BQTElCX0NPTVBVVEVfQklUKSwKIAlXT1JLTE9B
RF9NQVAoUFBfU01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NLAkJV09SS0xPQURfUFBMSUJfQ1VTVE9N
X0JJVCksCiB9OwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92
ZWdhMjBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMK
aW5kZXggN2M4OTMzZjk4N2QxLi41YjIxMzg2ZjU1OGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3ZlZ2EyMF9wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS92ZWdhMjBfcHB0LmMKQEAgLTIyMSw3ICsyMjEsNyBAQCBzdGF0aWMgc3RydWN0
IHNtdV8xMV8wX2NtbjJhaXNjX21hcHBpbmcgdmVnYTIwX3dvcmtsb2FkX21hcFtQUF9TTUNfUE9X
RVJfUFJPRklMRQogCVdPUktMT0FEX01BUChQUF9TTUNfUE9XRVJfUFJPRklMRV9QT1dFUlNBVklO
RywJCVdPUktMT0FEX1BQTElCX1BPV0VSX1NBVklOR19CSVQpLAogCVdPUktMT0FEX01BUChQUF9T
TUNfUE9XRVJfUFJPRklMRV9WSURFTywJCVdPUktMT0FEX1BQTElCX1ZJREVPX0JJVCksCiAJV09S
S0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX1ZSLAkJCVdPUktMT0FEX1BQTElCX1ZSX0JJ
VCksCi0JV09SS0xPQURfTUFQKFBQX1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUsCQlXT1JLTE9B
RF9QUExJQl9DVVNUT01fQklUKSwKKwlXT1JLTE9BRF9NQVAoUFBfU01DX1BPV0VSX1BST0ZJTEVf
Q09NUFVURSwJCVdPUktMT0FEX1BQTElCX0NPTVBVVEVfQklUKSwKIAlXT1JLTE9BRF9NQVAoUFBf
U01DX1BPV0VSX1BST0ZJTEVfQ1VTVE9NLAkJV09SS0xPQURfUFBMSUJfQ1VTVE9NX0JJVCksCiB9
OwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
