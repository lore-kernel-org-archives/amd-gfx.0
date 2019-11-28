Return-Path: <SRS0=UwKb=ZU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE3C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221522158A
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2019 02:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221522158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13DC6E5ED;
	Thu, 28 Nov 2019 02:21:42 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800070.outbound.protection.outlook.com [40.107.80.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539646E5ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2019 02:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmmwcEDBL7ca2906fHdlZpWZec0rmtZmsTRzySgqK1GNirpswqOkR9c81jZoTUXQygs/aNQkaY48Cc//Rz6JR9uXYBUbDOHV39gnDs6f2PUuv6Stle7Fk6gh5E2rtUtGzp05T1n8vRGasdpfDtXPJeHp3dc8FWCy623EboudLDnV4VmGyI0JNmaArXqf3gT887H/MSfhXye5zbvfIELA0s6yZixYzExVLxQxpjv14Nkw1sLXaVoIJ2MW3OKbzeMnZ5miTUv2Y8YuLJWQmqcIqZhw9eBnsGumNxzhQNJ7KtaDbt8/JuwonYvot3D2wezWDN/7PWu3OEZk24/nWrfFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d4jCrgQBy2zNe/4M4gC5RBtUASHafW7uOOhxLArkfM=;
 b=jJebfnlxuiewri4FHTOVXV5Vc/abzyH5x5x7ryJLiUWBVGQOboTK77dV3XCQ4p+0OmjtN9ibpfg3fOgWPUqYcZGcufsAQTy+76A9dmSSVvC+reoBD7c/+fjLlkynViLJ3HmWYTV2OcgKGgnkLq9YTvbSQVJ7Mms6J/IRzpSic4Fw1VnfL5SYvsTbY3GXYgKAEgjDhmAYapAghGK45ov6sL3FTrd9nIgN4pjpelZhpHtfezhsWvQUTCilnZUG50lNq0P3VUuOiUgprdnCfxMGH5a6lC1a2i910v0O7sHS7Hl8gg9rjSxDhQxtxNOWJgnHcqOeG1FrJLefuznQbLOkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB4256.namprd12.prod.outlook.com (52.135.48.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 02:21:40 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 02:21:40 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: use CPU to flush vmhub if sched stopped
Thread-Topic: [PATCH 4/5] drm/amdgpu: use CPU to flush vmhub if sched stopped
Thread-Index: AQHVpE+7WWAKa/OFpEW63kBQw2nn6qef3HtA
Date: Thu, 28 Nov 2019 02:21:39 +0000
Message-ID:
 <MN2PR12MB393350C1BB2FA9D8B12C517584470@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-4-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1574769024-30611-4-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92edd389-6a80-44df-4b61-08d773a9b3f5
x-ms-traffictypediagnostic: MN2PR12MB4256:
x-microsoft-antispam-prvs: <MN2PR12MB42562F939666C72795C2C77D84470@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
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
x-microsoft-antispam-message-info: x/kSRh92fuGNZE2/grjkwcbS01a6d6odcSdBs0bECXcR29trn3Ra8KGedN8a2f+hPsfkIXiu0hzb3t6JKcaVbr1EZOSK00VhGOncwI3H9NcK5tU2GLaFgXZw0/JOIhE5Oe5Q98Os1yuz5Ai6NN2Ah6TCC8TXWJmD43xdOPx5F892PE+Jdayvd1vWheuMvxDspsbyDhkUdMK1t/2cFyGdzxfSXWmfINaQRUFi8h0FOu5EoqUWoRUDTO0cGMPaFluvmECHRcZ2wQkvhlBhImPV/r6WrZ+idzSu9wn3njVuI0rQppsA5m3GLN0TpXMP88WeX7PayU0XRutYeRzfV/2xOJ6NDsw5kxVdvXzfjEAFQ0+otZBiZVn9VpDZ559jHYwurJMsSrPMBaF8zVyCJjTy0uARvwAY9csb+iGWbtDzwmi1P2BvHdKrGD94QwME+aJ7
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92edd389-6a80-44df-4b61-08d773a9b3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 02:21:39.9890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmIZeIXoEAO9ayToD1IniHaR7VEBMZ8FzsyuSyifE6noTOCL7gnWXy32ApRlAB8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d4jCrgQBy2zNe/4M4gC5RBtUASHafW7uOOhxLArkfM=;
 b=ueAXGgdir/9GdwZHwRSwr+oIVcbq+tONA9wGk/pAm4p2gBMwdFePp/gUM0FuAIOSCF3LJ6570RVOotTLY6jgZMcZjDVdg74JT8KtzhT12RyKaWZykCxjTSXafbgsYmFFLPJulDlcHaV9zDYlXk4bzZNMLHrYVacth76suJLMVL0=
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
Message-ID: <20191128022139.N4ConzWhzLaVA9dEhDkIl_E3FFNYm3hgHLn2tz4YXLc@z>

cGluZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpNb25rIExpdXxHUFUg
VmlydHVhbGl6YXRpb24gVGVhbSB8QU1ECgoKLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KRnJv
bTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+IApTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAy
NiwgMjAxOSA3OjUwIFBNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogTGl1
LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPgpTdWJqZWN0OiBbUEFUQ0ggNC81XSBkcm0vYW1kZ3B1
OiB1c2UgQ1BVIHRvIGZsdXNoIHZtaHViIGlmIHNjaGVkIHN0b3BwZWQKCm90aGVyd3NlIHRoZSBm
bHVzaF9ncHVfdGxiIHdpbGwgaGFuZyBpZiB3ZSB1bmxvYWQgdGhlIEtNRCBiZWN1YXNlIHRoZSBz
Y2hlZHVsZXJzIGFscmVhZHkgc3RvcHBlZAoKU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsu
TGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMg
fCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKaW5kZXggMzIxZjhhOS4uNGJiNGQy
NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKQEAgLTMyNiw3ICszMjYs
OCBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKIAogCWlmICghYWRldi0+bW1hbi5idWZmZXJfZnVu
Y3NfZW5hYmxlZCB8fAogCSAgICAhYWRldi0+aWJfcG9vbF9yZWFkeSB8fAotCSAgICBhZGV2LT5p
bl9ncHVfcmVzZXQpIHsKKwkgICAgYWRldi0+aW5fZ3B1X3Jlc2V0IHx8CisJCXJpbmctPnNjaGVk
LnJlYWR5ID09IGZhbHNlKSB7CiAJCWdtY192MTBfMF9mbHVzaF92bV9odWIoYWRldiwgdm1pZCwg
QU1ER1BVX0dGWEhVQl8wLCAwKTsKIAkJbXV0ZXhfdW5sb2NrKCZhZGV2LT5tbWFuLmd0dF93aW5k
b3dfbG9jayk7CiAJCXJldHVybjsKLS0KMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
