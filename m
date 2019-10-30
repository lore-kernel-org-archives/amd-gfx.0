Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136E4CA9EAF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 09:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AA7205ED
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 09:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AA7205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 754276E8D8;
	Wed, 30 Oct 2019 09:13:57 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800054.outbound.protection.outlook.com [40.107.80.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6373A6E8D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 09:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV2cSocMP7uQIjt2CQYg8bHiyBMsLIkFmWlb/QJFnuJCT6M/qiFE39JoMRLyak420c2SLX0LX7JcH6jAIjXfQnqSXfc2VmfnJ0wJLnX09GlHxAjh1WXCq5UvfxSDfzxNw0mzJKWtuAYyKO/AXrT+hT1X8eOaP2w9WEbhDmK5Zs1YfzrzB80lHfg187kAhrblB6CBZf9yE+o0eEYcjPFfkiVh3SCGFr7zDhpwLfchsEvPOfeKm6yDErsNjMXkWi8KlHW4uHGV4JlUByaNgICulgnKEkYov1CjuDsefJtFHeMqqv43jxlIHcHNDwS5ONqzhlfD9aJCGNwaYPAw5XoFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5YcEO9xz6/5vy563r4C7dpGZeco7ojVAfiVvLn6M4Y=;
 b=AsXQO4vpQyJINKahV7bXqH6cnt9YDDci0JiTjt8beSlbNhog+BJwe18zO+5glbCMXh4Z8GD8DQYNVk0yhwUnAdMbJD/jCmej9ewGu5bxDfIB56tSgCSfKv6rF+uXLFkSIiAemaPtgbb2MxC8Awt5nHYOjhTF2tEOkdnxhzSMVVp+TrfP+il20hj4UMjo3ECMhIz73Rogr3Wxs8KxV7b9CwzSG/V/MvDIg9Sgj2kLW3rJaXY6DvpSEOLv7/FIMzOBVfYJx9JgzUpWc+uI0rbEk2N/gHqAnqmqXIFzI/DQUAPDrU8O+e7WSqpT3ZzOVtLIO0WqCFsIRZwnLDMFp1RSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.80.74) by
 MN2PR12MB2893.namprd12.prod.outlook.com (20.179.83.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Wed, 30 Oct 2019 09:13:54 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::dd77:dfe4:1913:9d7e]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::dd77:dfe4:1913:9d7e%4]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 09:13:54 +0000
From: "S, Shirish" <Shirish.S@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Topic: [PATCH] drm/amdgpu: dont schedule jobs while in reset
Thread-Index: AQHVjwJaqXgdXzZy206qemuwuHylYQ==
Date: Wed, 30 Oct 2019 09:13:54 +0000
Message-ID: <1572426811-30618-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::32) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:a9::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a4d6166-b28b-411c-d0a0-08d75d197ca3
x-ms-traffictypediagnostic: MN2PR12MB2893:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2893E9AD3811D574F93473B4F2600@MN2PR12MB2893.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(486006)(66574012)(66066001)(4326008)(7736002)(305945005)(5660300002)(6636002)(99286004)(25786009)(2616005)(476003)(110136005)(54906003)(36756003)(81156014)(14444005)(8676002)(81166006)(6436002)(6506007)(102836004)(3846002)(6116002)(316002)(2906002)(52116002)(8936002)(6486002)(66556008)(256004)(186003)(6512007)(64756008)(66446008)(66946007)(14454004)(66476007)(86362001)(26005)(50226002)(478600001)(71200400001)(386003)(71190400001)(192303002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2893;
 H:MN2PR12MB3248.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KaXnSTJOTcjshIS/psGj/t+SjUj+FY/alenp9M1jpIikLg5JeFDzCT7oChAgZ9pNHfjgcONys1Mb5wJ9Kt4gu4GPbRfeU+6jP63J4CLJKVQukLiuaEE+eoiNl3FvGZlldmaZAxX7yERC50xxJ6tMcvk+nnRbGgD/CZf21PiPJaXX4bdIqjPaMrH9vfjVFUH+jJ84YJ0b7Ml7lRFvA7cGcZfUPJC/iSYB5C6oFSOhiEI6ruJiJy0ZNB/sasbHdcfU+d0DKcCKtc4oAiVw5NFT+DgxL85Vef4U8vsV22i2rzDFyKyErxG8+dknpDCMbKoycKXedkPFkwtYsAexSEfqUuEupc0XXP5Z3A4kdzv70+P00phCKn81Z7zD8uVSJMuEnMFccrNW1vS8RG1S3P4FWRT1o6JqlEozKVBjFbugFyquEJpGkJlkG2cN1hdySlVw
Content-ID: <32B77DF0438138448800DF3DF8FC34EE@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4d6166-b28b-411c-d0a0-08d75d197ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 09:13:54.7288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kdHDfMSf9eRih0fbb+o6v+MkNkSS0jK/dtJIoJqtPA6s2hVqt5pboQnx78hJvhmvLmY3L+SGQrlq+cN5B7AAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2893
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5YcEO9xz6/5vy563r4C7dpGZeco7ojVAfiVvLn6M4Y=;
 b=OT973fXs+n71OCjuORBiPHzZVOb3jxSCWXBcpWKl9MzOPw4/KeQNku0O6J79ULtJYB8OPaogxXblvfpFEblwSOyFBnp9Ozso+Qq/4w6emZUhHzpEtxBR21x/wJ5VJ5wJltpKNEHlaWQnuNqMhZ158DfBLz7j6BliU7NqfH9xiZE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030091354.7OVDKUHIobNadUrKwKfTRjcJfMoLJDHBAQMrB55O21c@z>

W1doeV0NCg0KZG9pbmcga3RocmVhZF9wYXJrKCkvdW5wYXJrKCkgZnJvbSBkcm1fc2NoZWRfZW50
aXR5X2ZpbmkNCndoaWxlIEdQVSByZXNldCBpcyBpbiBwcm9ncmVzcyBkZWZlYXRzIGFsbCB0aGUg
cHVycG9zZSBvZg0KZHJtX3NjaGVkX3N0b3AtPmt0aHJlYWRfcGFyay4NCklmIGRybV9zY2hlZF9l
bnRpdHlfZmluaS0+a3RocmVhZF91bnBhcmsoKSBoYXBwZW5zIEFGVEVSDQpkcm1fc2NoZWRfc3Rv
cC0+a3RocmVhZF9wYXJrIG5vdGhpbmcgcHJldmVudHMgZnJvbSBhbm90aGVyDQoodGhpcmQpIHRo
cmVhZCB0byBrZWVwIHN1Ym1pdHRpbmcgam9iIHRvIEhXIHdoaWNoIHdpbGwgYmUNCnBpY2tlZCB1
cCBieSB0aGUgdW5wYXJrZWQgc2NoZWR1bGVyIHRocmVhZCBhbmQgdHJ5IHRvIHN1Ym1pdA0KdG8g
SFcgYnV0IGZhaWwgYmVjYXVzZSB0aGUgSFcgcmluZyBpcyBkZWFjdGl2YXRlZC4NCg0KW0hvd10N
CmdyYWIgdGhlIHJlc2V0IGxvY2sgYmVmb3JlIGNhbGxpbmcgZHJtX3NjaGVkX2VudGl0eV9maW5p
KCkNCg0KU2lnbmVkLW9mZi1ieTogU2hpcmlzaCBTIDxzaGlyaXNoLnNAYW1kLmNvbT4NClN1Z2dl
c3RlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KLS0t
DQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgNSArKysrLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYw0KaW5kZXggNjYxNGQ4YS4uMmNkYWYzYiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jDQpAQCAtNjA0LDggKzYwNCwx
MSBAQCB2b2lkIGFtZGdwdV9jdHhfbWdyX2VudGl0eV9maW5pKHN0cnVjdCBhbWRncHVfY3R4X21n
ciAqbWdyKQ0KIAkJCWNvbnRpbnVlOw0KIAkJfQ0KIA0KLQkJZm9yIChpID0gMDsgaSA8IG51bV9l
bnRpdGllczsgaSsrKQ0KKwkJZm9yIChpID0gMDsgaSA8IG51bV9lbnRpdGllczsgaSsrKSB7DQor
CQkJbXV0ZXhfbG9jaygmY3R4LT5hZGV2LT5sb2NrX3Jlc2V0KTsNCiAJCQlkcm1fc2NoZWRfZW50
aXR5X2ZpbmkoJmN0eC0+ZW50aXRpZXNbMF1baV0uZW50aXR5KTsNCisJCQltdXRleF91bmxvY2so
JmN0eC0+YWRldi0+bG9ja19yZXNldCk7DQorCQl9DQogCX0NCiB9DQogDQotLSANCjIuNy40DQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
