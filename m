Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA017C433E3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 13:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A821A20717
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LKiebQ3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A821A20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B366E05D;
	Wed, 22 Jul 2020 13:42:09 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690084.outbound.protection.outlook.com [40.107.69.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC5B6E05D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 13:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSwuRygj21YnQ4t7MI9t/LSra4kzrJ7mAuBxWPYGj2NOcQpkvz24fQFs0dKlZeRzkXzktmdKREtQ907GDp+RpIlbgwTHzeF6Jitb5yeLEt4DT8O9LCqdc3lHe6ur1XCKRJLq00idYWZCOqgAw1qb3NL0dy/mqF58HNOv4/4M0C++S6cMgC+R5PqJPk9oM8Tpoo4+pgrjTCaa9Ksw0iiLV2ctySAG69JgUZYQ8VXkiBZTpj38hZTF/+R2slPeH/1lgh5p5Zdwmtif5O90zLICxU+TXaRXzjOA7ERRJg82ilCMTOZuMr52YP4Zmcq+l4DIqbmx/K9mNRCpDUiLpIHH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yj0OFN2Aqayo1q4nD1ws8I3OZ49H//OWgYjLfXRa/E=;
 b=Nfn8N58gOG3m2TNiQvAic8fjsvdDxtoapQEFjMo+bq/8BIEYoyGTwR0O1RCD9eXV8jmbFyiZ2JjTBdy9/4q36NWdLkTEZi1nusuj5cGZLnM68rTvM+ya7zlWjydU1ly3DOP0WjGfye7+p3mXJM9XhgLo69k8pADfW9rRiZx4U9Fl9vMQWfEXjeKhWHsIJT8+kzXxy0vLpwAswEMvtMyeXHYCM5G4xwz3TUI54MhEmptUJwhnojsufMt5UXg5h0ncdXWa3b8q+r9C9Ba3raaqXR+GiJYJVY5NXqnAhk+H8piG03eTs53bqfc6FmGW3ZLT4IXUuk3IZvrxlIRNVE2/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yj0OFN2Aqayo1q4nD1ws8I3OZ49H//OWgYjLfXRa/E=;
 b=LKiebQ3iFdLj7RmwJpxUN25y9O9f/SzgzqaW6EdZyvJMdGj1H6SExskvg5L7zVDEdcmm/LALR8iN3/EUZxucO0doz31rHV00/zdn8CVU/A5hiw1fnaVwZaikmStELMZZWaWE1F0t33Sr8X8LtfwzrUneR8q4Zp9Ekmz5rmo1opA=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2942.namprd12.prod.outlook.com (2603:10b6:208:108::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 22 Jul
 2020 13:42:06 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::493c:9d42:501b:59d6%3]) with mapi id 15.20.3195.028; Wed, 22 Jul 2020
 13:42:06 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: remove the dpm checking in the boot
 sequence
Thread-Topic: [PATCH] drm/amd/powerplay: remove the dpm checking in the boot
 sequence
Thread-Index: AQHWYC02FRJ0KmV4B0ut5rynY0wEhakTm2z7
Date: Wed, 22 Jul 2020 13:42:06 +0000
Message-ID: <8B78CD9A-E162-4634-B43C-BEA45A784B76@amd.com>
References: <20200722133705.6633-1-kenneth.feng@amd.com>
In-Reply-To: <20200722133705.6633-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.142.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3d307d9-14d5-4fda-49db-08d82e450638
x-ms-traffictypediagnostic: MN2PR12MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2942CF1AD432B6C56194D487A2790@MN2PR12MB2942.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ego2IE7FaKPFccjiB0RcT0hVgRy9ZsV3Gfs7qA54htEMZ7YLWE+Sec+bV+sw7wYA5yzj13uJUTDn3KyHVlmJKa6ak8Zu5tnP0evK+bINSJJAyXjb1RvOP6jUDE+QVL5g7YVI/484uKm/JLK2SAyt0966aAO/+MDa01ssmL7xLoYIEG1bIa5X7wBdb/On7oPoFsrP1f3lMPtJF9gS9V5kVb/VE5INiwIUl+YMS/Qz7NLMlWrhOSiag9NdfC/xOSItLP2f43RPEJJRKEHHD5iaOdSRHfAotNNkxGXk2DeWmILC0F5fE5VOMdk6oaEFpK9xVbhUrFyDAygSMA3w5t4P9Ab+LV6ftDJu1qEeSYQua/o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(6636002)(71200400001)(86362001)(6506007)(45080400002)(66946007)(186003)(8936002)(83380400001)(26005)(4326008)(91956017)(6862004)(6512007)(36756003)(76116006)(6486002)(8676002)(2906002)(33656002)(316002)(2616005)(478600001)(966005)(5660300002)(66476007)(66556008)(64756008)(66446008)(37006003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HCZcRMHADOR6IYweOFoRDEVf2+xTesdI87E50hC/eRjfelrQ2NlBYGFqKSWx2BRF8V2LVSbDO+Wx8UbMnGacd7bVcBkQXx3Ys51pp0EAmqY3iEddwmCI5gxYkmXXCE9F+vt1XirdWZ7pXdTSFasyYWE72/7yzU//eEKxGGiTk03HVsm4PDOZjjtHOjcbtwxPT2vJGoLX/0mrBKFEgxlttL882COwF3dXIXS18DsoZNQgfdm2NAf3awmNZ2V0Q6HKLbhcaiL6HWoVEyseRCBVRExW5tcg0fej9BdjJf1/W2cqal8UJ6tRsl4mLJnNBTzqRELtHbh7lpmBuTBhEj5g7GiVGMWv7n5XMwS25n/C5k9H5WmdWTAEMLnvtTdINMUbaw6KIkdO1fy8+Qle2m5NPL69QCfTV5UlbKgtMpIj234IptVZUd+dvuzvRYJKpWi0xnNe+zcWkU8k2X7wLmb3cOBmBp6paDCU7qiMPaCDoB0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d307d9-14d5-4fda-49db-08d82e450638
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 13:42:06.3679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXfFUE7wKiFn+dWhGhm9Yj40FTq7AEtKEN3EVf34n3X39kKY1Xldi+0oWGzDT4Xz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2942
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6DQpLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0BhbWQuY29tPg0KDQoNCj4g5Zyo
IDIwMjDlubQ35pyIMjLml6XvvIzkuIvljYg5OjM377yMS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZl
bmdAYW1kLmNvbT4g5YaZ6YGT77yaDQo+IA0KPiDvu79JdCdzIG5vdCBuZWNlc3NhcnkgdG8gcmV0
cmlldmUgdGhlIHBvd2VyIGZlYXR1cmVzIHN0YXR1cyB3aGVuIHRoZQ0KPiBhc2ljIGlzIGJvb3Rl
ZCB1cCB0aGUgZmlyc3QgdGltZS4gVGhpcyBwYXRjaCBjYW4gaGF2ZSB0aGUgZmVhdHVyZXMNCj4g
ZW5hYmxlbWVudCBzdGF0dXMgc3RpbGwgY2hlY2tlZCBpbiBzdXNwZW5kL3Jlc3VtZSBjYXNlIGFu
ZCByZW1vdmVkDQo+IGZyb20gdGhlIGZpcnN0IGJvb3QgdXAgc2VxdWVuY2UuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPg0KPiAtLS0NCj4g
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIHwgMiArLQ0KPiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMNCj4gaW5kZXggZjc3OGIwMGU0OWVi
Li42YjAzZjc1MGU2M2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FtZGdwdV9zbXUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9h
bWRncHVfc211LmMNCj4gQEAgLTczNSw3ICs3MzUsNyBAQCBzdGF0aWMgaW50IHNtdV9zbWNfaHdf
c2V0dXAoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+ICAgIHVpbnQzMl90IHBjaWVfZ2VuID0g
MCwgcGNpZV93aWR0aCA9IDA7DQo+ICAgIGludCByZXQ7DQo+IA0KPiAtICAgIGlmIChzbXVfaXNf
ZHBtX3J1bm5pbmcoc211KSAmJiBhZGV2LT5pbl9zdXNwZW5kKSB7DQo+ICsgICAgaWYgKGFkZXYt
PmluX3N1c3BlbmQgJiYgc211X2lzX2RwbV9ydW5uaW5nKHNtdSkpIHsNCj4gICAgICAgIGRldl9p
bmZvKGFkZXYtPmRldiwgImRwbSBoYXMgYmVlbiBlbmFibGVkXG4iKTsNCj4gICAgICAgIHJldHVy
biAwOw0KPiAgICB9DQo+IC0tIA0KPiAyLjE3LjENCj4gDQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9w
Lm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0tl
dmluMS5XYW5nJTQwYW1kLmNvbSU3QzAzYTNlODFiNjY1MDRkYTYxNjM0MDhkODJlNDQ1N2E5JTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzMxMDIxODM1NTgz
NDUxNyZhbXA7c2RhdGE9N2lzcXl5QjAyNjd6Y25lSmc1cFJNZEZiT0lkOThYekFGRmtSdjFUOWQw
WSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
