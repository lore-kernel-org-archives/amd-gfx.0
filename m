Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298DC5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 07:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF1921882
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 07:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF1921882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A276EE96;
	Thu,  7 Nov 2019 07:38:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750075.outbound.protection.outlook.com [40.107.75.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A936EE96
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 07:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzONVasKh6Xocpt88rJB9dZ0zbxrS/xAd85PpW3Nw0cR16kv8bbXOi/+ldWhT3fmF5Mg4mT/3m4TL1O2FktI/4mmkkheINTSHDLpbCfDyg0fbLzRzAj8yxDBMDvkJC14LppolGRvVSRMSRKs2Su1IDiyCnoTI4JQRVQVMCoUmEtHFDfA2hp7A8itJ8dbajdEQjtU+gJunK6a34KVoGibDOHtamZGqaeFrfBGHNAvFAIXMRGO6+nm1FuAzVZXJGE61XpLAJy2iCDVPCsICyexoMIstn9AVLOIHPu5+JDFHLWpB+aO+GlVkuYtgjcj+59kOUr8JUrvPPNlJIjjbTqQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myi4bvAM3s31KwGs5E9uHNlwVTnl0uLcqvQBFNWgYxg=;
 b=NfdWcwp3NRjNuI/Ja/ND8qcgE0eiY3/cBoyUpiMgI1sn/kkiJ5oXXXLju+WZCzZSFgPoOpt6LOBzhD/3NhztX8qxeXfvjuz0cDWqjQbqRpPmOd2WZjh0OcMHmwKN8l/Ph+kwxsg9u3HNFdZn7EotEBAj7F21I7umdYUwanbYq3wO1lw6w/qGHn2m8KY3vZ2vN3nu1F7CTc7oU/wAxqij506FbfZKSYT55bx6ki3WekfFs4/3azBRYoOSWKt1Lcuz1LgJBjKXA/7pViRuYj1X6H2iBqdi8KYtdqVS2XhPAQUwlvjK1Zo4vdegzz/2kHxZadkwhFXWv75IzxZymrT45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3533.namprd12.prod.outlook.com (20.179.83.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 07:38:43 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 07:38:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: correct Arcturus OD support
Thread-Topic: [PATCH] drm/amd/powerplay: correct Arcturus OD support
Thread-Index: AQHVlT5hNY9IZRK/5EmJYYXhGvPRMA==
Date: Thu, 7 Nov 2019 07:38:43 +0000
Message-ID: <20191107073817.27624-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f2af4d9-b3d5-4ec3-5023-08d763558403
x-ms-traffictypediagnostic: MN2PR12MB3533:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3533F18861481EBF2D1D3146E4780@MN2PR12MB3533.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39850400004)(189003)(199004)(486006)(102836004)(50226002)(14454004)(2351001)(6486002)(25786009)(4326008)(186003)(476003)(2906002)(54906003)(64756008)(6436002)(66446008)(5640700003)(71200400001)(71190400001)(316002)(36756003)(66556008)(66946007)(478600001)(6116002)(3846002)(66476007)(6512007)(256004)(52116002)(1076003)(99286004)(26005)(8936002)(66066001)(6506007)(8676002)(6916009)(7736002)(305945005)(2616005)(5660300002)(81156014)(386003)(81166006)(2501003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3533;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5kloZWEYaqrxxbySh75gkmKjYE67YRlgTGXlmfVI58DRbRRN1JEsvN9ULfkAL1dk50vvp4QMk11UaRBwKD2I5wEGWU5HWg0iEZaIzcars1oj1HoTLWlXnWajHJGjY2+lOqG8IHfyUs3em0f0CBG2v+AAzf2zB84B+lyZirSkyoBEtsVmbesq5VrtGkzvLWlKXbcRx1jZFOB1DzFfqVGzmeiHFDw1LqjkT/zOTe0UP07wYQPljVcT9bH3jKwuwmyaPUz6FQQPsDUOle1N8UaC1iK279RorUhzaMByypOW9k7LFwWSjSP/Yg+G60/s4oB/VG7UqZDR/JAsOT3rjR6G8nPLjmoiipFA9lpTW0uUQBz3sCGa59jPfKtRosLBNlp3izAFupt3cRBxOGAZChXFGWJbZOzOAkxtu0RtVeOjCm6Lo3jyPuqc3/dxB+igR3G
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2af4d9-b3d5-4ec3-5023-08d763558403
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 07:38:43.8681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKQiG2lmnJbMutoQYxuxMQl7pzt3sd1Jzg0IWbgkeJyGMfnt+E9TdTYYSJheCANp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3533
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myi4bvAM3s31KwGs5E9uHNlwVTnl0uLcqvQBFNWgYxg=;
 b=3kxyI8HNbVNNvbgUWZjvuvA0GrxBzvSamrzbhMVNoPkKorvy2bTERHdlNGXw8GU3K/eSjalZN6HQ88Sr5EEpGBZKkDi6MUZao5YkZLhr6NfUXwhGSvWfxBvoHQU/4h+HtrX7QdmqbdaKRZ/+cjE7qyBPv3FMojgBs9BjIkbHyD8=
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Freehill, Chris" <Chris.Freehill@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107073843.YV7BGT6-go7_yyZUcd8DOvbwRDWpbWfuWO1zaxsvEJw@z>

T0QgaXMgbm90IHN1cHBvcnRlZCBvbiBBcmN0dXJ1cy4gVGh1cyB0aGUKcHBfb2RfY2xrX3ZvbHRh
Z2Ugc3lzZnMgaW50ZXJmYWNlIGlzIGFsc28gbm90IHN1cHBvcnRlZC4KCkNoYW5nZS1JZDogSWI3
MDYzMmE1NWEwOTgwY2YwNGMzNDMyZDQzZGJjZjg2OWNkMWI0YmYKU2lnbmVkLW9mZi1ieTogRXZh
biBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9hbWRncHVfc211LmMgfCA4ICsrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2Ft
ZGdwdV9zbXUuYwppbmRleCBjMjFmZTdhYzVkZjguLjc2YTQxNTRiM2JlMiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwpAQCAtNzE0LDYgKzcxNCw5IEBAIHN0
YXRpYyBpbnQgc211X3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9ICZhZGV2LT5zbXU7CiAKKwlpZiAoYWRldi0+cG0ucHBf
ZmVhdHVyZSAmIFBQX09WRVJEUklWRV9NQVNLKQorCQlzbXUtPm9kX2VuYWJsZWQgPSB0cnVlOwor
CiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKIAljYXNlIENISVBfVkVHQTIwOgogCQl2ZWdh
MjBfc2V0X3BwdF9mdW5jcyhzbXUpOwpAQCAtNzI1LDYgKzcyOCw4IEBAIHN0YXRpYyBpbnQgc211
X3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJYnJlYWs7CiAJY2FzZSBD
SElQX0FSQ1RVUlVTOgogCQlhcmN0dXJ1c19zZXRfcHB0X2Z1bmNzKHNtdSk7CisJCS8qIE9EIGlz
IG5vdCBzdXBwb3J0ZWQgb24gQXJjdHVydXMgKi8KKwkJc211LT5vZF9lbmFibGVkID1mYWxzZTsK
IAkJYnJlYWs7CiAJY2FzZSBDSElQX1JFTk9JUjoKIAkJcmVub2lyX3NldF9wcHRfZnVuY3Moc211
KTsKQEAgLTczMyw5ICs3MzgsNiBAQCBzdGF0aWMgaW50IHNtdV9zZXRfZnVuY3Moc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiAJCXJldHVybiAtRUlOVkFMOwogCX0KIAotCWlmIChhZGV2LT5w
bS5wcF9mZWF0dXJlICYgUFBfT1ZFUkRSSVZFX01BU0spCi0JCXNtdS0+b2RfZW5hYmxlZCA9IHRy
dWU7Ci0KIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
