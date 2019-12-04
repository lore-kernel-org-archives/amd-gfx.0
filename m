Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4233CC2D0BE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 07:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488C021770
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 07:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488C021770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E2A6E88B;
	Wed,  4 Dec 2019 07:30:11 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790075.outbound.protection.outlook.com [40.107.79.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EC16F43D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 07:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMPi0OXawA2bXjH23jE7TGltrd0EzrgHRk2y+4ZX5a4/lkE7cnBYXrlo5yamUseMBoqdEqtKln+W75Vyy0FFt6YrsnbLbL8k4mYyIEwwgmZoDYn9N9NdOpDxccg3NGqApA6Fs7H23F+eQbLD9rqbWU+Bi9it/I+yOUOH8ryIf9KNr05mD3E/+V5BqUw6JuRdD1mw4Ow1zVVLGEGiTp385wS20SwdES4XS9oBKpcN6jqBNe2ZArTWcxwyF5SeIb9KwMEBwPZ5CqIMokdmMKkmNWKjo0vwDgLGWx+a9LsD6sLClHiDsncjoU6QRsTyT/g2fbMmeHsJ/Hm7Z/eOEAi+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJkIjUc6Ex4nU5aC7IebBOok2D8n7sHvnKZeIil7ONg=;
 b=h5I5oaGKsLcvkvalyq8m6udMBseLr2CpPcojSVA4figBce6R3+tmQR5zl1IZiOtmZoN5yL/CQ3bTrEj+MX7oSxz7iNSvyKUrgLn9+TwLrMXwZvuuPd9fnFT7pHSLM+mCRSegazQSEEwbCmxNon9VSPdCLZ2NDjh4OmZloifjlw+r19eU1KtEEW7UT/Xngklr9P3DLWG445CsYIJMI75Pxs9iG+1oFZNyaZcV7CaA6ExGEfHgz3XiDNa070NY+8b8jdVL6aElv+U4h4Weqnc6l1b0raMWYJXMq4fk0N2g+mdcbZS1GZap9P+UUYYDzjFoExT9tGCNlsZ1Nz+hoXdBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3408.namprd12.prod.outlook.com (20.178.243.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 07:30:09 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 07:30:09 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhao, Yong" <Yong.Zhao@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix a minor typo on user queue init
Thread-Topic: [PATCH] drm/amdkfd: fix a minor typo on user queue init
Thread-Index: AQHVqnOABFCo+x9a5USG9FtChymCcqeplA0g
Date: Wed, 4 Dec 2019 07:30:09 +0000
Message-ID: <MN2PR12MB330996C3212A1F29D4496A48EC5D0@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1575444114-24209-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1575444114-24209-1-git-send-email-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a85bea6c-32ae-4ba9-4406-08d7788bcb0a
x-ms-traffictypediagnostic: MN2PR12MB3408:|MN2PR12MB3408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3408183613583ECA5D73F975EC5D0@MN2PR12MB3408.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(13464003)(199004)(189003)(3846002)(229853002)(316002)(33656002)(55016002)(9686003)(305945005)(6436002)(74316002)(7696005)(2906002)(76176011)(7736002)(14444005)(71200400001)(71190400001)(256004)(25786009)(110136005)(6116002)(478600001)(14454004)(99286004)(6506007)(26005)(102836004)(186003)(6636002)(2501003)(52536014)(53546011)(81156014)(81166006)(446003)(11346002)(8936002)(8676002)(5660300002)(4326008)(64756008)(66446008)(4744005)(66556008)(66476007)(66946007)(76116006)(86362001)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3408;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7v6v6W4jRBrA2Lsh9Ctbb5R0qTF8KB0iJY+uJbTcfYhoMW+uyRym+0ClL4CfFMO9kmgN/7YFsNXKWIOl+bG7WzGac2pTGJGjWwhyFPR0YrlI9RzQGgzDOumTLT+9e1xz7wZRqes4LbdEO0Yr6+bixTw7iTuDKaWn17t0GPp+4EKPgCUAieSgbPfJPNl6mBFVREit7mRVymHaPzFr5XeR5uGoR2ibc3+QJaSXlJdipaHaBhrI/0fyVhCA55jhdZWLcKJW9ydi0jmE57AUv3ylSATknMmBEW/oEePiV5DiKI178+s18sfKm7MQur9KLnwMgQZ3AkTwFiZXqRaBQpjKZYq7sSNd14Z0dYgncHeyx/BEnCDUmf/5dTILlItOXokJShHXuMYhCqmJ6N9tFwUdwap8bUm0DWRPv580hkzOVSEUBEMFjThE1DGeQGP09nxaeAl1cYPM2g3ysgsHbTueKl0qA291t6JF+E4cS1PTK1o=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85bea6c-32ae-4ba9-4406-08d7788bcb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 07:30:09.6530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQ2MHhGsCsPtKzWleyhzDgmYPSzbAMNioRcgZMBGJE8QPnFWWyk05LuL5ocG4hdZelWe0am9Mqydcwk9jTMOmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3408
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJkIjUc6Ex4nU5aC7IebBOok2D8n7sHvnKZeIil7ONg=;
 b=JohmcUbz8k1h5vWTzn5KJ8em3ux+wHlPG7N5bpWsTg39qfABh6+Iae1vGHQNLyUUxkP1ecaL+jfyO84aI4SsrTM+JHo4cSiYOZDS29YnEL/SXT8q/cQ9xiv59piDD5KVg/knbBTCyZeRp4Q5GFDdyV3y0UZeZ4Xd88XogOSEWK8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaC4gSnVzdCBtaXN1bmRlcnN0b29kIGJlZm9y
ZS4KClRoYW5rcywKUmF5CgotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQpGcm9tOiBIdWFuZywg
UmF5IDxyYXkuaHVhbmdAYW1kLmNvbT4gClNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgNCwgMjAx
OSAzOjIyIFBNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VlaGxpbmcsIEZl
bGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgWmhhbywgWW9uZyA8WW9uZy5aaGFvQGFtZC5j
b20+CkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBI
dWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4KU3ViamVjdDogW1BBVENIXSBkcm0vYW1ka2Zk
OiBmaXggYSBtaW5vciB0eXBvIG9uIHVzZXIgcXVldWUgaW5pdAoKRml4IFBRTSAtPiBEUU0uCgpT
aWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYyB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIuYwpp
bmRleCBkM2VhY2Y3Li5iN2RiNjIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jCkBAIC0xODMsNyArMTgzLDcgQEAg
c3RhdGljIGludCBpbml0X3VzZXJfcXVldWUoc3RydWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAq
cHFtLAogCSgqcSktPmRldmljZSA9IGRldjsKIAkoKnEpLT5wcm9jZXNzID0gcHFtLT5wcm9jZXNz
OwogCi0JcHJfZGVidWcoIlBRTSBBZnRlciBpbml0IHF1ZXVlIik7CisJcHJfZGVidWcoIkRRTSBB
ZnRlciBpbml0IHF1ZXVlIik7CiAKIAlyZXR1cm4gcmV0dmFsOwogfQotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
