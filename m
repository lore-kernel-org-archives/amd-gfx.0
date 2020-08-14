Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DF8C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 16:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BBA20774
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 16:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NCwTzsD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BBA20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FE86E21F;
	Fri, 14 Aug 2020 16:21:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79CA46E21F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 16:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoGpibVppw67udXgUqOIPqfFiDtecmHZ17VShetQRFteqew1lUFtSmDvPwS0/U8qXnf20A/IfVYbV8iWdrZhLzXheJChMIU8AT+3ZWtR+bAoc+f4//cJDha80b01e5AAQAlzPFttHUg3hXezKqvdaqnB1MiLSnyfPOT4UtYdODK2iXqpO2FnF97bhyuUpfpyq0UF3/BBpGeKxCWsUDQwxdXRSzfxLvs7+by6KR/C/VU4+1oOv3Eo3tlIeqSV3bf7Ot24fAtpcXh/5mNlBhsvvqgeDjvu3CIpW7pZQbH3O3fwlwBaSv5AE1hZ3iXsFE3b3yPwky9Y3u0ElGIQBNVKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBCieYZjP0kxBsYsZ3WHZPzDHI+FACgpImZ74NX3uZ0=;
 b=HAabmuZ9H0rWdFrLBkdunxEW+miEZ0EZ2/hfmyYJ4938sLtYcOkHC9Ai6wu66aqrY6mQrFbYfnPnI3/ESnplotdyHvedfAeIsmYJnTNwzhznIDP3kGIM8kYbK9ji0aWHzh7khmKGuiQ2BV5qSrLVBOjBbbVEsq5oNQB09QwCCoYLS3tX06lytzzhwCmUMXr60Wlrnj0v1ia24mM3FsnDAOsCyqyC8bUSUL5PSp12AMvefKooo4W0Fg/mP2WMSO4veeV3jluYopiNX1dEpndV2nvYnoB9c9ZzpFtIMme9cH3r5NAaVj5/EdeDs4uMcm4auQOVCi1xg0XkZA2KHaY5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBCieYZjP0kxBsYsZ3WHZPzDHI+FACgpImZ74NX3uZ0=;
 b=NCwTzsD3i7Lqm0hJsWqS++Kp5VU+Rd0ycSMFK00h0Y8LW1QCfIN8BPa/VUeZZGzC4fFLcmo7AinRPaitAIv5DctOb72lDe/zuHb+o163E1VeLBdWRn2eEBSD0gW0aB5b6bY+99ohi9ZK8ZcE147VV3mSoMzkJ+ENE7WtyL/Di00=
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB3810.namprd12.prod.outlook.com (2603:10b6:a03:1a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 16:21:15 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::8c12:dd2f:eae4:7c24]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::8c12:dd2f:eae4:7c24%6]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 16:21:15 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: TTM/nouveau conflict in drm-misc-next
Thread-Topic: TTM/nouveau conflict in drm-misc-next
Thread-Index: AQHWclbuaB2CfqasgkGZnhHDuRfTQg==
Date: Fri, 14 Aug 2020 16:21:15 +0000
Message-ID: <2f7ae285-b51e-409f-9110-534bb68ec0ad@email.android.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2a02:908:1252:fb60:b44e:7ab2:8b7e:bce4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f058adbe-76fe-4f0d-d919-08d8406e116b
x-ms-traffictypediagnostic: BY5PR12MB3810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3810484339275AA05DA7BD0B83400@BY5PR12MB3810.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chp6tiDQlPYjHDgA1VCwaflgzp1OXA+WHqh0pdzB2WG6o3iX75HFM2qC30vcu7NuOaz53K95UqJOwoiLsdFyghD7uPxh9jNGn8zyUQYYhfA5WzXaq0kW0Eu1KAPIKUelO6MUZmm+W82WLA/4CcYBcR64ZJzLeqPffLzy9Mb+oQ/zvX83DtB6NJf2b5hypnqjBZ6tiLClMbE5OiUWcPvKS+ZAoKkTmHFm88O1rHJRdSfWb67R0JxmHKiUoO0wrFehVzShvqwICCpNGFOwWLrfLuZTCg2WU+awYjIz6Y7wFiFTnFDIg9BhXe5gP3eGQMNJvy899gPu3jg6Jx8ZG8Nyly+GgyIofuUL4G5tKqM6BRU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(186003)(478600001)(6506007)(66476007)(66946007)(64756008)(76116006)(316002)(31686004)(8676002)(91956017)(2906002)(54906003)(86362001)(6512007)(6486002)(66556008)(8936002)(9686003)(53546011)(71200400001)(66446008)(83380400001)(4326008)(966005)(166002)(6916009)(5660300002)(45080400002)(31696002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: J8gv9yVV3wpVVsD5O5RD3Y6VMm0xky3qjcDT7VW0UV11Hk1WBaBTVJJtcXC8lB0cmLIGr26J6CyLMjuuW5vvYkt77UTN0vS8cLDe7du+esiRVxEg4h+Coo9mN/i9uPF74h2BKS7d/IweLQ2YLT8WuTwE7WjlNQeoc+omuT3qNIDfP+wJI9zRczwf/GRGxR8zr1bXsKWlKr5Ux2zYbtaWYRN6fFOb4M6b8dfciez8hKERWJV4vj/TuZcShXJQic5tHOe/srLTxydgmy528lA6dgqV04Lp9rr/t5hhnf+NYAtIXXg3N7Win8V20eXjIaiEGgpIBRIlbhmSNMXa0KuON42ttOyRat5dwaoCKLPhnyFoUbDfiW7WCKT7q93HsUAvEKJB7ugIVhK2gpKXm/I7dwDObUFQo9D8LeLVNH1yrR8ahebuCyPValdXyboY1ahYnjH8tlBBSSkXqAwn7nML0qrLtpQOIi9f7G+IJfW1S6NOluHdHwAZ1e9quzzQGaIC9gap/Hn2w/YQmMTKTsBDbnRTFJ3wS0r6+rnYrmwCnmK1CMld1QQKHwQpQveuJ5hkQ7pvIZYXIzFYFiqcyrgEyjWpci2OwrTvezug50oF6SKmZBJM7NUrwkX9DFCV1d8+dgRQ8BBbWFz7yLFyLBa/JW33riTrHp5I6aowA3TNWTkzsAWy0JKQ+aG0/u5YL+O0X/cvnZmh6M9W9Q76xa+hxQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f058adbe-76fe-4f0d-d919-08d8406e116b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 16:21:15.3967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQKX+Cez8GqOcx4gtJeJnjOeamnODpcQHxWdZWJApFzhI4xhCpoM3CCMz6wJwY/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3810
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: multipart/mixed; boundary="===============1069303198=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1069303198==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_2f7ae285b51e409f9110534bb68ec0ademailandroidcom_"

--_000_2f7ae285b51e409f9110534bb68ec0ademailandroidcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCkFtIDE0LjA4LjIwMjAgMTc6NTMgc2NocmllYiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVy
QGdtYWlsLmNvbT46DQpPbiBGcmksIEF1ZyAxNCwgMjAyMCBhdCAxMToyMiBBTSBDaHJpc3RpYW4g
S8O2bmlnDQo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4gSGV5IFRob21h
cyAmIEFsZXgsDQo+DQo+IHdlbGwgdGhlIFRUTSBhbmQgTm91dmVhdSBjaGFuZ2VzIGxvb2sgZ29v
ZCB0byBtZSwgYnV0IHRoaXMgY29tcGxldGVseQ0KPiBicm9rZSBhbWRncHUuDQo+DQo+IEFsZXgg
YW55IGlkZWEgd2hhdCBpcyBnb2luZyBvbiBoZXJlPw0KDQpXaGF0J3MgYnJva2VuIGluIGFtZGdw
dT8gIFRoZXJlIHNob3VsZG4ndCBiZSBhbnkgdHRtIGNoYW5nZXMgaW4gYW1kZ3B1DQpmb3IgZHJt
LW5leHQuICBUaG9zZSBhbGwgZ28gdGhyb3VnaCBkcm0tbWlzYy4NCg0KSXQncyBub3QgYSBUVE0g
Y2hhbmdlLg0KDQpUaGUgYmFja21lcmdlIG9mIGRybS1uZXh0IGludG8gZHJtLW1pc2MtbmV4dCBi
cm9rZSBhbWRncHUgc28gdGhhdCBldmVuIGdseGdlYXJzIGRvZXNuJ3Qgd29yayBhbnltb3JlLg0K
DQpCdXQgZWFjaCBpbmRpdmlkdWFsIG1lcmdlIGhlYWQgc3RpbGwgd29ya3MgZmluZSBhcyBmYXIg
YXMgSSBjYW4gc2F5Lg0KDQpBbnkgaWRlYSBob3cgdG8gdHJhY2sgdGhhdCBkb3duPw0KDQpDaHJp
c3RpYW4uDQoNCg0KQWxleA0KDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gQW0g
MTIuMDguMjAgdW0gMjE6MTAgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoNCj4gPiBIaSBDaHJp
c3RpYW4gYW5kIEJlbiwNCj4gPg0KPiA+IEkgYmFja21lcmdlZCBkcm0tbmV4dCBpbnRvIGRybS1t
aXNjLW5leHQgYW5kIGhhZCBhIGNvbmZsaWN0IGJldHdlZW4gdHRtDQo+ID4gYW5kIG5vdXZlYXUu
IHN0cnVjdCB0dG1fbWVtX3JlcyBnb3QgcmVuYW1lZCB0byBzdHJ1Y3QgdHRtX3Jlc291cmNlLiBJ
DQo+ID4gdXBkYXRlZCBub3V2ZWF1IHRvIHRoZSBuZXcgbmFtZSwgdGVzdC1idWlsdCwgYW5kIHB1
c2hlZCB0aGUgcmVzdWx0IHRvDQo+ID4gZHJtLW1pc2MtbmV4dC4gSWYgZWl0aGVyIG9mIHlvdSBo
YXMgYSBtaW51dGUsIHlvdSBtYXkgd2FudCB0byBkb3VibGUNCj4gPiBjaGVjayB0aGUgbWVyZ2Uu
DQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMNCj4gPiBUaG9tYXMNCj4gPg0KPg0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL25hbTExLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5m
cmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAy
JTdDMDElN0NjaHJpc3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3Q2ExYWVmYzFlZTIyYTRlNzMzZGY5
MDhkODQwNmEzOTVjJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3
QzYzNzMzMDE3MjI3NTA4ODY0OSZhbXA7c2RhdGE9WDJaSlVFVHdvcTg4NFh0ZzY2c0R1ZGpYQiUy
RjNzJTJCZ1JnbG5oMzNncFU0SGMlM0QmYW1wO3Jlc2VydmVkPTANCg0K

--_000_2f7ae285b51e409f9110534bb68ec0ademailandroidcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <1CECCC4AE4BA7B47AB3AB9514E209B07@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5Pg0KPGRpdiBkaXI9ImF1
dG8iPg0KPGRpdj48YnI+DQo8ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPg0KPGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPkFtIDE0LjA4LjIwMjAgMTc6NTMgc2NocmllYiBBbGV4IERldWNoZXIg
Jmx0O2FsZXhkZXVjaGVyQGdtYWlsLmNvbSZndDs6PGJyIHR5cGU9ImF0dHJpYnV0aW9uIj4NCjxi
bG9ja3F1b3RlIGNsYXNzPSJxdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1s
ZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KPGRpdj48Zm9udCBzaXplPSIy
Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExcHQiPg0KPGRpdj5PbiBGcmksIEF1ZyAxNCwgMjAy
MCBhdCAxMToyMiBBTSBDaHJpc3RpYW4gS8O2bmlnPGJyPg0KJmx0O2NocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbSZndDsgd3JvdGU6PGJyPg0KJmd0Ozxicj4NCiZndDsgSGV5IFRob21hcyAmYW1wOyBB
bGV4LDxicj4NCiZndDs8YnI+DQomZ3Q7IHdlbGwgdGhlIFRUTSBhbmQgTm91dmVhdSBjaGFuZ2Vz
IGxvb2sgZ29vZCB0byBtZSwgYnV0IHRoaXMgY29tcGxldGVseTxicj4NCiZndDsgYnJva2UgYW1k
Z3B1Ljxicj4NCiZndDs8YnI+DQomZ3Q7IEFsZXggYW55IGlkZWEgd2hhdCBpcyBnb2luZyBvbiBo
ZXJlPzxicj4NCjxicj4NCldoYXQncyBicm9rZW4gaW4gYW1kZ3B1PyZuYnNwOyBUaGVyZSBzaG91
bGRuJ3QgYmUgYW55IHR0bSBjaGFuZ2VzIGluIGFtZGdwdTxicj4NCmZvciBkcm0tbmV4dC4mbmJz
cDsgVGhvc2UgYWxsIGdvIHRocm91Z2ggZHJtLW1pc2MuPGJyPg0KPC9kaXY+DQo8L3NwYW4+PC9m
b250PjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPGRpdiBk
aXI9ImF1dG8iPjxicj4NCjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPkl0J3Mgbm90IGEgVFRNIGNo
YW5nZS48L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj48YnI+DQo8L2Rpdj4NCjxkaXYgZGlyPSJhdXRv
Ij5UaGUgYmFja21lcmdlIG9mIGRybS1uZXh0IGludG8gZHJtLW1pc2MtbmV4dCBicm9rZSBhbWRn
cHUgc28gdGhhdCBldmVuIGdseGdlYXJzIGRvZXNuJ3Qgd29yayBhbnltb3JlLjwvZGl2Pg0KPGRp
diBkaXI9ImF1dG8iPjxicj4NCjwvZGl2Pg0KPGRpdiBkaXI9ImF1dG8iPkJ1dCBlYWNoIGluZGl2
aWR1YWwgbWVyZ2UgaGVhZCBzdGlsbCB3b3JrcyBmaW5lIGFzIGZhciBhcyBJIGNhbiBzYXkuPC9k
aXY+DQo8ZGl2IGRpcj0iYXV0byI+PGJyPg0KPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+QW55IGlk
ZWEgaG93IHRvIHRyYWNrIHRoYXQgZG93bj88L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj48YnI+DQo8
L2Rpdj4NCjxkaXYgZGlyPSJhdXRvIj5DaHJpc3RpYW4uPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+
PGJyPg0KPC9kaXY+DQo8ZGl2IGRpcj0iYXV0byI+DQo8ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+
DQo8ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+DQo8YmxvY2txdW90ZSBjbGFzcz0icXVvdGUiIHN0
eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij4NCjxkaXY+PGZvbnQgc2l6ZT0iMiI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTox
MXB0Ij4NCjxkaXY+PGJyPg0KQWxleDxicj4NCjxicj4NCiZndDs8YnI+DQomZ3Q7IFJlZ2FyZHMs
PGJyPg0KJmd0OyBDaHJpc3RpYW4uPGJyPg0KJmd0Ozxicj4NCiZndDsgQW0gMTIuMDguMjAgdW0g
MjE6MTAgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjo8YnI+DQomZ3Q7ICZndDsgSGkgQ2hyaXN0
aWFuIGFuZCBCZW4sPGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0OyAmZ3Q7IEkgYmFja21lcmdlZCBk
cm0tbmV4dCBpbnRvIGRybS1taXNjLW5leHQgYW5kIGhhZCBhIGNvbmZsaWN0IGJldHdlZW4gdHRt
PGJyPg0KJmd0OyAmZ3Q7IGFuZCBub3V2ZWF1LiBzdHJ1Y3QgdHRtX21lbV9yZXMgZ290IHJlbmFt
ZWQgdG8gc3RydWN0IHR0bV9yZXNvdXJjZS4gSTxicj4NCiZndDsgJmd0OyB1cGRhdGVkIG5vdXZl
YXUgdG8gdGhlIG5ldyBuYW1lLCB0ZXN0LWJ1aWx0LCBhbmQgcHVzaGVkIHRoZSByZXN1bHQgdG88
YnI+DQomZ3Q7ICZndDsgZHJtLW1pc2MtbmV4dC4gSWYgZWl0aGVyIG9mIHlvdSBoYXMgYSBtaW51
dGUsIHlvdSBtYXkgd2FudCB0byBkb3VibGU8YnI+DQomZ3Q7ICZndDsgY2hlY2sgdGhlIG1lcmdl
Ljxicj4NCiZndDsgJmd0Ozxicj4NCiZndDsgJmd0OyBCZXN0IHJlZ2FyZHM8YnI+DQomZ3Q7ICZn
dDsgVGhvbWFzPGJyPg0KJmd0OyAmZ3Q7PGJyPg0KJmd0Ozxicj4NCiZndDsgX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+DQomZ3Q7IGFtZC1nZnggbWFp
bGluZyBsaXN0PGJyPg0KJmd0OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxicj4NCiZn
dDsgPGEgaHJlZj0iaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxp
c3RpbmZvJTJGYW1kLWdmeCZhbXA7YW1wO2RhdGE9MDIlN0MwMSU3Q2NocmlzdGlhbi5rb2VuaWcl
NDBhbWQuY29tJTdDYTFhZWZjMWVlMjJhNGU3MzNkZjkwOGQ4NDA2YTM5NWMlN0MzZGQ4OTYxZmU0
ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MzMwMTcyMjc1MDg4NjQ5JmFtcDth
bXA7c2RhdGE9WDJaSlVFVHdvcTg4NFh0ZzY2c0R1ZGpYQiUyRjNzJTJCZ1JnbG5oMzNncFU0SGMl
M0QmYW1wO2FtcDtyZXNlcnZlZD0wIj4NCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUy
Rm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2FtcDtkYXRhPTAyJTdDMDElN0NjaHJp
c3RpYW4ua29lbmlnJTQwYW1kLmNvbSU3Q2ExYWVmYzFlZTIyYTRlNzMzZGY5MDhkODQwNmEzOTVj
JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzMzMDE3MjI3
NTA4ODY0OSZhbXA7YW1wO3NkYXRhPVgyWkpVRVR3b3E4ODRYdGc2NnNEdWRqWEIlMkYzcyUyQmdS
Z2xuaDMzZ3BVNEhjJTNEJmFtcDthbXA7cmVzZXJ2ZWQ9MDwvYT48YnI+DQo8L2Rpdj4NCjwvc3Bh
bj48L2ZvbnQ+PC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8L2Rpdj4NCjxicj4NCjwvZGl2Pg0KPC9k
aXY+DQo8L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_2f7ae285b51e409f9110534bb68ec0ademailandroidcom_--

--===============1069303198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1069303198==--
