Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA4C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 07:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873FC215F1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 07:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873FC215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F42892FB;
	Fri, 29 Nov 2019 07:47:34 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam05on061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe51::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63FC3890BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 07:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVfwvjjAKugSHeI1Du3VQR15NnI9auMZolrKw/DHZHtfUZa/vMbbP438A/srQAdq5UwgeNncMIj0zlIN5x8yF/fI4clqaAtesQezHGmbi8sFigno30/KI2swubR3KLUi896CtAQuxdh1rIfO3qFIdudQfTQ46Jm91+mq4nmxlSVkpX6ukbdAuwYUzphQHHqGQGWEk50nF23X137MMNlEdzrLyxFz1a2xJsyUSCwSdTMwKYSj4eQ+DtBy1EMiUOeb0PPj6BuFB2StAlXQEsNAO7wg+9cIfYDFPMwPZOW3V0KDBaLVDj8jXMKZ7E8jUFGA1iz7ISK0XEcpnswKhfVcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ1LMdRIMcJs8vmw1SSKx1ysqeXCj4g6+IhGqSon4Lc=;
 b=HNk9nVk8O1klsz01WAhtEge0gMtrkLa+pgO9vrWNZH5hzkDEnaFYAEWRwavD5ABAKt9sof9X7dqcyOetz+y+pQdLuediWrYN8Wc+UTf2ehfLr35cZd0J8kiNOwQJu2Qwe0gQdBjzejWmCZGXmmBr1l/Otu1LUrs9YTWHOUXq3sCQSn1n5mQ5tTRzmMZ7RC+7aGF1XI62gLmMzLWWFV8he9vxs249VOxw4YyM4zXYo6RBetgf63kp5R3Gt6a0xS5V03Ztfl0bRXPKlz5bJlnvZbddw/otP7pcVQVvApi1al6q+S7FnZ6aV1RJyts84V5myDVNqNcMxoUXHwjzvxkaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB4333.namprd12.prod.outlook.com (52.135.48.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 29 Nov 2019 07:47:32 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 07:47:32 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for
 SRIOV VF
Thread-Topic: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for
 SRIOV VF
Thread-Index: AQHVpE+6OFp3RqEVEU2buxGtwbSBnaef3G9wgAHtX0A=
Date: Fri, 29 Nov 2019 07:47:32 +0000
Message-ID: <MN2PR12MB39331072231F411D4150DD1984460@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
 <1574769024-30611-3-git-send-email-Monk.Liu@amd.com>
 <MN2PR12MB393364068B1A041D93BC826D84470@MN2PR12MB3933.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB393364068B1A041D93BC826D84470@MN2PR12MB3933.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Hawking.Zhang@amd.com,Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e1c09e0-b84c-4233-e49f-08d774a0644a
x-ms-traffictypediagnostic: MN2PR12MB4333:|MN2PR12MB4333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4333CC47BF71F77FCA0ED85384460@MN2PR12MB4333.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(13464003)(199004)(189003)(7736002)(66066001)(8936002)(6306002)(9686003)(99286004)(25786009)(6636002)(81156014)(53546011)(81166006)(86362001)(6506007)(229853002)(14444005)(6246003)(256004)(55016002)(6436002)(5660300002)(71200400001)(2501003)(3846002)(11346002)(74316002)(66476007)(64756008)(6116002)(66946007)(2906002)(66446008)(33656002)(8676002)(446003)(76116006)(66556008)(305945005)(26005)(14454004)(45080400002)(478600001)(186003)(316002)(76176011)(52536014)(7696005)(110136005)(71190400001)(102836004)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4333;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJs5Ot4bb56di5GCy/ZS4qTA14VMAs52jh+5gx/ZY7dNJyYhH6HWj+ro7R0TYgaxPqiSiAXZJA2lKTAfWBkaUp1X0cbkTClEiA9Hu1nzYlnztR4mnoygLipxk/LWR40GqX/wmO8fJvoww4ZfQt8uGcZaySm5IiHh0O0xwmQ1KKvusG/eg15YMQd1p6FPieEQ/JlTSG0ZYJeuwQwgjq0IvajWsbXPJQvdhVt4jRbjE76l/Juo6/JepRTo9iZzjuvw2FqfbTnKIgZVsKag5SO70+gM2Nx2FO6wC9il6n59d60316WxST2hXEJpX7cq9h3+x9wICNZI/2QURsw/jrHiHe+Zq83kAv7AtPpBxRvrmufVZkyy+kdQhw0r+ZspixhGKLLw+6PpzLHBZW5+/WfEUHBdJcwRWPxKlfjca1lUjMU02svFs6EIeFgLslR61SC3HBnXC2x/pT5uFQ6Hnp9EcWKkGiRRqFIcle9x/y4PFmc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1c09e0-b84c-4233-e49f-08d774a0644a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 07:47:32.1574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lCu3l8vUPXxw/U13Y891bumCpVyjcp24ZvFiGo1+Pwme17zwlfs6JZ533h2YXlu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ1LMdRIMcJs8vmw1SSKx1ysqeXCj4g6+IhGqSon4Lc=;
 b=WQfbBqC+r6Tq7M2xwaIZGfPbTYS2cjiJ1+6wIBZo9mZtLS5dN+vBmjC1lu4OHxM1fe6bC9YX4FWilxez4GUQzbC1JkOwfelOsrEFGw7R2fOik/6L+wQVEkneq+LwrAbUzM0HY7wCH8urgEwU1yJUfLf5ZBRw9hQGFuk6XzUE+Js=
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

QFpoYW5nLCBIYXdraW5nQERldWNoZXIsIEFsZXhhbmRlcg0KDQpDYW4geW91IGhlbHAgdG8gcmV2
aWV3IGl0IGZvciBtZSA/IA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQpNb25rIExpdXxHUFUgVmlydHVhbGl6YXRpb24gVGVhbSB8QU1EDQoNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBMaXUsIE1vbmsNClNlbnQ6IFRodXJzZGF5LCBOb3Zl
bWJlciAyOCwgMjAxOSAxMDoyMiBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQpTdWJqZWN0OiBSRTogW1BBVENIIDMvNV0gZHJtL2FtZGdwdTogZG8gYXV0b2xvYWQgcmlnaHQg
YWZ0ZXIgTUVDIGxvYWRlZCBmb3IgU1JJT1YgVkYNCg0KcGluZw0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KTW9uayBMaXV8R1BVIFZpcnR1YWxpemF0aW9uIFRlYW0gfEFN
RA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBNb25rIExpdSA8TW9uay5M
aXVAYW1kLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyNiwgMjAxOSA3OjUwIFBNDQpU
bzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBMaXUsIE1vbmsgPE1vbmsuTGl1
QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMy81XSBkcm0vYW1kZ3B1OiBkbyBhdXRvbG9hZCBy
aWdodCBhZnRlciBNRUMgbG9hZGVkIGZvciBTUklPViBWRg0KDQpzaW5jZSB3ZSBkb24ndCBoYXZl
IFJMQ0cgdWNvZGUgbG9hZGluZyBhbmQgbm8gU1JsaXN0IGFzIHdlbGwNCg0KU2lnbmVkLW9mZi1i
eTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMgfCAzICstLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYw0KaW5kZXggOTZhNmIwMC4uYjY1ZmRhOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BzcC5jDQpAQCAtMTQ5MCw4ICsxNDkwLDcgQEAgc3RhdGljIGludCBwc3BfbnBf
ZndfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkNCiAJCQlyZXR1cm4gcmV0Ow0KIA0KIAkJ
LyogU3RhcnQgcmxjIGF1dG9sb2FkIGFmdGVyIHBzcCByZWNpZXZlZCBhbGwgdGhlIGdmeCBmaXJt
d2FyZSAqLw0KLQkJaWYgKHBzcC0+YXV0b2xvYWRfc3VwcG9ydGVkICYmIHVjb2RlLT51Y29kZV9p
ZCA9PQ0KLQkJCUFNREdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX1NSTV9NRU0pIHsNCisJ
CWlmIChwc3AtPmF1dG9sb2FkX3N1cHBvcnRlZCAmJiB1Y29kZS0+dWNvZGVfaWQgPT0gKGFtZGdw
dV9zcmlvdl92ZihhZGV2KSA/IEFNREdQVV9VQ09ERV9JRF9DUF9NRUMyIDogQU1ER1BVX1VDT0RF
X0lEX1JMQ19SRVNUT1JFX0xJU1RfU1JNX01FTSkpIHsNCiAJCQlyZXQgPSBwc3BfcmxjX2F1dG9s
b2FkKHBzcCk7DQogCQkJaWYgKHJldCkgew0KIAkJCQlEUk1fRVJST1IoIkZhaWxlZCB0byBzdGFy
dCBybGMgYXV0b2xvYWRcbiIpOw0KLS0gDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9u
Lm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZt
YWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0Ntb25rLmxpdSU0
MGFtZC5jb20lN0MwYmM2NzRkZGYxYzk0YmE4MzFmYTA4ZDc3M2E5YjBlZCU3QzNkZDg5NjFmZTQ4
ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMDUwNDQ5OTAyNTUwMDAmYW1wO3Nk
YXRhPWt2c1pka28lMkZRQVhJaVpDUDE5d28lMkJ4RUlTTHFFdzd0TWFGTzBkdnhVNUV3JTNEJmFt
cDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
