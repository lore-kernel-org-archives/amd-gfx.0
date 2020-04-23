Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF9EC54FD0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0397C208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pRSsuHjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0397C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BDA89FED;
	Thu, 23 Apr 2020 07:06:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522D889FED
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLSZ61FqdjAA/HMHVrj6ky81e7vOnpT26i2cH63DIgQm5bksMpgWv2gEG/z5BUpVzso433lubmU23oTMnC7p4XFeja+GCqkFOYOZKtQS83yEEzv8N3ZQ4f+M1roy/JebuXRzhx/gOLr/yr8s8GrZ2TniraOaWv3IcYFRcAXYXtwWIkqC4QAiqd2qkrvG+lgRBUvLXEgeHEc/93D9uxSeWkJtKC5RROPq4xbxdGPEyn+sNpGv4HXWWsLOIcicvSK2ssi+eW3CDHIw8YKCnrkYaRR9s3ePP0B5AMIvOAT1PBbsrp72/AQGiEqYr32aGNntMnM1DQQilUefpQcGMuKxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib8tngsZoWe6GBGRw80K0inzbPBdiaAgl8QvVtVdwro=;
 b=EPOQxqCmyXgYMQ3Bu/W2WHc3M7tYNYT2c1sFUomIWgUeUxS9ngD1VJdpJLHh9kk2rwfUPuTgyQcMoQciiRGkplw8QBOVmLvUfANc62ZPfbSOTMqcuTmTEhOVUjhovDclLXil98DAVGfOzAeiISR4KbmclRPIyaOULoc7Jgw6FhxX7Mupj3GhyWOc4LXdA7uqGcXbhNTBVvCP1ClAHuN4lm6YkbDfq9McZxQP8fs8t2zofj0thXjA7d/eQfGOyiQXn7l6DMGBvTtVmVXvIKVqavyZIfVgAVRnYjyGAqf7uNkoOhA5o1M3SijXO4aJXAIhreDaqFf9FjD8HC5rD0qNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib8tngsZoWe6GBGRw80K0inzbPBdiaAgl8QvVtVdwro=;
 b=pRSsuHjFQvOtXJRA00Zzp5XWWIqRMKk6WelMxae3XNFRZ/uY8di+G6S6kphztHxfbxJfwpJ3kpZ/8T7W9ApYpWyzIQ5LpdCHWXgS3qVOUzrl69CYy6lPNDTN55W3/6eD2eSydOiY02RsAj6/07ejkJ7RVCDf5vw45N/nlY/BDfY=
Received: from MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 07:06:31 +0000
Received: from MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425]) by MN2PR12MB3039.namprd12.prod.outlook.com
 ([fe80::58b5:b730:f260:a425%7]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:06:31 +0000
From: "Tao, Yintian" <Yintian.Tao@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/8] drm/amdgpu: ignore TA ucode for SRIOV
Thread-Topic: [PATCH 1/8] drm/amdgpu: ignore TA ucode for SRIOV
Thread-Index: AQHWGT1A0yVcQT5yKkiB0mGZYFf+eqiGSJZA
Date: Thu, 23 Apr 2020 07:06:31 +0000
Message-ID: <MN2PR12MB3039797CA09B08F23A27767CE5D30@MN2PR12MB3039.namprd12.prod.outlook.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yintian.Tao@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47a2a95a-1268-45ca-b659-08d7e754d9f5
x-ms-traffictypediagnostic: MN2PR12MB4221:|MN2PR12MB4221:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB422154C9D21C28A18A10A11CE5D30@MN2PR12MB4221.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(71200400001)(52536014)(5660300002)(2906002)(55016002)(186003)(4326008)(9686003)(110136005)(86362001)(33656002)(7696005)(6506007)(966005)(26005)(316002)(8936002)(8676002)(81156014)(64756008)(66446008)(478600001)(66556008)(76116006)(66946007)(53546011)(45080400002)(66476007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idL7EFI3X7fq02t6vHczhq0oiY47/wASQBEoIh/nwQ01gbnOsvo74+U6Jo6Ozex9MDw1+XOby5D/Q3lCui/v15YNqeXbiVWxBuvvT2m1Ni2hoMuuKKQ16zIIkZFPm7xu/lbbhqlIHJZYOfQqHV1yt3NY0g4hFG4xiidGYrcqvcAxJ2FIsufSwxtaar9VpLwiJtfV3z2qbKYn2pXlqq0D4w468wVdrKwSnrUiuH47SQgNqcfA1dsJF/4WIDjOy8IBnebWsEE/QdLwdHADMLIms5LOM7+/kewG6ntBj1i30kESx7lyPTwCtBNOSvmsGDHjbnhVX2/HAzZk0N6P0oyKcqLrT4SK4M063Mbc+nWe4PgHKbkHpj4XvNOuzPPnF8tIeD7ivEtMv5h652HBBqwJC8h3T1jdYVi2qE1q9ZASzgDdv1wkQAR3NL17vqZxUG/ksuS4ktEDfAFuthclWZ2H5cK0i48PfoFwbJytnSA60ho=
x-ms-exchange-antispam-messagedata: V0I3Jtgr3UN+6Q34CnI7XyvPwxODwmX2Fth98aqKeDUZcef0E/WuNIOhHRtQLsKAXX2CD4VnGgP6I3OCnQVJEfS6koKqCmHXQ3guhctjk13toMl13OejQ8LZe70K2wokdBi/7G7IyijvhU4FVBeivQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a2a95a-1268-45ca-b659-08d7e754d9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:06:31.4943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sv3DKAAw5q6sZPkviePs2xcmIf/upoqwHD79rDtwobPoAqEHzs0YA2AeLn1dEUDr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VyaWVzIGlzIEFja2VkLWJ5OiBZaW50aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBNb25rIExpdQ0KU2VudDogMjAyMMTqNNTC
MjPI1SAxNTowMg0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTGl1LCBN
b25rIDxNb25rLkxpdUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIIDEvOF0gZHJtL2FtZGdwdTog
aWdub3JlIFRBIHVjb2RlIGZvciBTUklPVg0KDQpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9u
ay5MaXVAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFf
MC5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTFfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmMNCmluZGV4IDBhZmQ2MTAuLmI0YjAyNDIgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYw0KKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxMV8wLmMNCkBAIC0xOTQsNiArMTk0LDggQEAg
c3RhdGljIGludCBwc3BfdjExXzBfaW5pdF9taWNyb2NvZGUoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3ApDQogCWNhc2UgQ0hJUF9OQVZJMTA6DQogCWNhc2UgQ0hJUF9OQVZJMTQ6DQogCWNhc2UgQ0hJ
UF9OQVZJMTI6DQorCQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KKwkJCWJyZWFrOw0KIAkJ
c25wcmludGYoZndfbmFtZSwgc2l6ZW9mKGZ3X25hbWUpLCAiYW1kZ3B1LyVzX3RhLmJpbiIsIGNo
aXBfbmFtZSk7DQogCQllcnIgPSByZXF1ZXN0X2Zpcm13YXJlKCZhZGV2LT5wc3AudGFfZncsIGZ3
X25hbWUsIGFkZXYtPmRldik7DQogCQlpZiAoZXJyKSB7DQotLSANCjIuNy40DQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcg
bGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVk
ZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0Mw
MSU3Q3lpbnRpYW4udGFvJTQwYW1kLmNvbSU3QzU5MWY2MTU0MjE2ZDQ1ZjgxYTBjMDhkN2U3NTQz
NjcxJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzIzMjIy
MTkxMzM0NzQ0NyZhbXA7c2RhdGE9akZ2JTJGTXFTJTJCMGxIbnVhTjAlMkIxR0c2aVNmeXlBRlBa
YkZCeGElMkJpRUwydHNnJTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
