Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD7C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5444B2173E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5444B2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10106EBFD;
	Wed,  6 Nov 2019 06:57:24 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680046.outbound.protection.outlook.com [40.107.68.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74296EBFD
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 06:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONLdiL1XhlEgw1KWEdzBqCLswvo13ORnf2gt8Q5Z7boN0JVb2bAJdyy/fyh/4O1di2Jx9/CaJ1UzFWSpN1jtxGTcqzXPzvNKkNEpZjkgSJT6Mg30M1KtUgk6sRCqeQQB2vdqc9eMkzEdQpxqP0JHaZ5eWPvUNpTaMCMVpcNG8BlGdrLHkLddNs4eDZyZX9bGvxrZ68ozejUVADOnYf2KdTuT4jhjftZu/qqS8AJ9TmGBXiCLY6QZBzn8VoBf4OyksOQqd2mnbju2NWUymRommHapVrYwYeC8HxtQ9gzm4LLQU/7+OWo2rqPUejK74UsDdbDcyN2ONRjaQYTulKPi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb7goIi9gx560Ve1r/FV7a3kdSrT2TOSpf/4XNt3xQU=;
 b=Om3Rlxtlj4YGOEdDD6qFOHXQV1Q0dZOWqHYL2G/lxvCyBnygknygP/7Qubs8OMizix7tV769Cpsqhed0wdg4BFpg0b+NTTy4PGSUzyc29bk2LPMGWoj3qZA3DB5XPWs3WcEmE/VjyMdhW8UIcTRpSCN11EryJN2wnRQUgzDL+Sdsn3rrmbUfGy9era06MBYgVseLZD3a0iGauckDXUOgvvdjv9uce3MtNp4fRzy5NpqGmef16J7ATZHgP4T4L7smIZYJRICyzJTi81luLw8eBN6PagNyQBLJIeJN9LLvJReUBIqdrJdcMkel1r7U/Io0eyGMgDmwWOcsExI0pHvj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 06:57:21 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 06:57:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: fix deadlock on setting
 power_dpm_force_performance_level
Thread-Topic: [PATCH] drm/amd/powerplay: fix deadlock on setting
 power_dpm_force_performance_level
Thread-Index: AQHVlG9vOwTE4toRzkyDWNP6u9w9wg==
Date: Wed, 6 Nov 2019 06:57:21 +0000
Message-ID: <20191106065700.6525-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38611aa7-d27b-40ec-68f7-08d7628691f6
x-ms-traffictypediagnostic: MN2PR12MB3949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3949493045581ACBE0CA594AE4790@MN2PR12MB3949.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(52116002)(6506007)(25786009)(3846002)(1076003)(86362001)(256004)(6512007)(305945005)(81156014)(7736002)(99286004)(486006)(66476007)(50226002)(476003)(8936002)(66446008)(66556008)(64756008)(6116002)(66946007)(186003)(4326008)(14444005)(36756003)(2616005)(6916009)(386003)(478600001)(5640700003)(2351001)(6486002)(2906002)(5660300002)(8676002)(66066001)(81166006)(26005)(14454004)(71190400001)(71200400001)(6436002)(102836004)(316002)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3949;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ixz1P3Y+EPS+Fh0mYidjUBtsMRVP3HVgE13Yc3vhCELxh/H6irDl51S4vAW54TRxH+zfKTovqUPk8T6rOaabNbucYBLvdHzeP1fTtk7BHw8GppSWehH3U5MXdPJFYadELpup2SdMVAxp3N4/DzkNGZIWHuirrAqotQWC+CXV9EyHngxfRstzjzhm0zUwy54FlrNjjaXmN1hrUxuhGuZnPnpn8mR56WTgPoJL18gOL0ohHQkevYfCt94JxwKDOVd26VUIwHaWJN7M31f+TUC49aTYce5o2YOer9A6mqfetnSPzGXKk3I6YXMHRm4TvPiKI3p5BvrNuPsjNYaFEJBEccy/UJ0PVTq1h0Ebc5nt+4I21Q4iasVO+NoFpUFaV0uHSIvesw/XDX37BzpDLd+CUCI9gh+1bXObOz4RazTUu1M/nLhKdXJdpz0N4MdMlXX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38611aa7-d27b-40ec-68f7-08d7628691f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 06:57:21.2967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzdaj993Ec0OEuo449inux07vwr+NEfpWGpH/SHvv9Wy9l8wIos+bEUCxxoddrm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb7goIi9gx560Ve1r/FV7a3kdSrT2TOSpf/4XNt3xQU=;
 b=EshxX/C2dg0bPRoZoakMXy69vY/fYZai8Ep6/esJD9UxVO2hMznQG5FpvqAC0p5414G5vk5xzi9jNU+4xb5LQ3DfmozXmHnUXbZWTdTnMrTlF7fIqG+NLbdvpMja8imEfXDVly5yuItrOsSsIEIV0Bhi1z+3iVEBILrwqc3MM1w=
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
Message-ID: <20191106065721.67oMRYnjLKjSVkIQUpHYqpE-StpJWUh6O7nohiHdFTw@z>

c211X2VuYWJsZV91bWRfcHN0YXRlKCkgd2lsbCB0cnkgdG8gZ2V0IHRoZSBzbXUtPm11dGV4IHdo
aWNoIHdhcyBhbHJlYWR5CmhvbGQgYnkgaXRzIHBhcmVudCBBUEkgc211X2ZvcmNlX3BlcmZvcm1h
bmNlX2xldmVsKCkgb24gdGhlIGNhbGwgcGF0aC4KVGh1cyBkZWFkbG9jayBoYXBwZW5zLgoKQ2hh
bmdlLUlkOiBJYzRkM2M3ZDA2ZWI0N2VhYjJlYTQyYjk4ZjM5OWNkOTVhYjMyMGYwYwpTaWduZWQt
b2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyB8IDE5ICsrKysrKysrKysrKysrLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwppbmRleCBmYWNjMTljYWU3ZTUuLmMy
MWZlN2FjNWRmOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1k
Z3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUu
YwpAQCAtMzgzLDE0ICszODMsMjUgQEAgYm9vbCBzbXVfY2xrX2RwbV9pc19lbmFibGVkKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LCBlbnVtIHNtdV9jbGtfdHlwZSBjbGtfdHlwZSkKIAlyZXR1cm4g
dHJ1ZTsKIH0KIAotCisvKioKKyAqIHNtdV9kcG1fc2V0X3Bvd2VyX2dhdGUgLSBwb3dlciBnYXRl
L3VuZ2F0ZSB0aGUgc3BlY2lmaWMgSVAgYmxvY2sKKyAqCisgKiBAc211OiAgICAgICAgc211X2Nv
bnRleHQgcG9pbnRlcgorICogQGJsb2NrX3R5cGU6IHRoZSBJUCBibG9jayB0byBwb3dlciBnYXRl
L3VuZ2F0ZQorICogQGdhdGU6ICAgICAgIHRvIHBvd2VyIGdhdGUgaWYgdHJ1ZSwgdW5nYXRlIG90
aGVyd2lzZQorICoKKyAqIFRoaXMgQVBJIHVzZXMgbm8gc211LT5tdXRleCBsb2NrIHByb3RlY3Rp
b24gZHVlIHRvOgorICogMS4gSXQgaXMgZWl0aGVyIGNhbGxlZCBieSBvdGhlciBJUCBibG9jayhn
Zngvc2RtYS92Y24vdXZkL3ZjZSkuCisgKiAgICBUaGlzIGlzIGd1YXJkZWQgdG8gYmUgcmFjZSBj
b25kaXRpb24gZnJlZSBieSB0aGUgY2FsbGVyLgorICogMi4gT3IgZ2V0IGNhbGxlZCBvbiB1c2Vy
IHNldHRpbmcgcmVxdWVzdCBvZiBwb3dlcl9kcG1fZm9yY2VfcGVyZm9ybWFuY2VfbGV2ZWwuCisg
KiAgICBVbmRlciB0aGlzIGNhc2UsIHRoZSBzbXUtPm11dGV4IGxvY2sgcHJvdGVjdGlvbiBpcyBh
bHJlYWR5IGVuZm9yY2VkIG9uCisgKiAgICB0aGUgcGFyZW50IEFQSSBzbXVfZm9yY2VfcGVyZm9y
bWFuY2VfbGV2ZWwgb2YgdGhlIGNhbGwgcGF0aC4KKyAqLwogaW50IHNtdV9kcG1fc2V0X3Bvd2Vy
X2dhdGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIHVpbnQzMl90IGJsb2NrX3R5cGUsCiAJCQkg
ICBib29sIGdhdGUpCiB7CiAJaW50IHJldCA9IDA7CiAKLQltdXRleF9sb2NrKCZzbXUtPm11dGV4
KTsKLQogCXN3aXRjaCAoYmxvY2tfdHlwZSkgewogCWNhc2UgQU1EX0lQX0JMT0NLX1RZUEVfVVZE
OgogCQlyZXQgPSBzbXVfZHBtX3NldF91dmRfZW5hYmxlKHNtdSwgZ2F0ZSk7CkBAIC00MDgsOCAr
NDE5LDYgQEAgaW50IHNtdV9kcG1fc2V0X3Bvd2VyX2dhdGUoc3RydWN0IHNtdV9jb250ZXh0ICpz
bXUsIHVpbnQzMl90IGJsb2NrX3R5cGUsCiAJCWJyZWFrOwogCX0KIAotCW11dGV4X3VubG9jaygm
c211LT5tdXRleCk7Ci0KIAlyZXR1cm4gcmV0OwogfQogCi0tIAoyLjIzLjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
