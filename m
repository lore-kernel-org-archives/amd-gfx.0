Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F069ACA9EAF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 09:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6122087F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 09:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6122087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC426E8FE;
	Wed, 30 Oct 2019 09:03:54 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7156E903
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 09:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyyofnPxVxwLusIIt8PWAh8bqCYkuHqTLhR3hpE/KMN347L+6rH3qHNhApzNePfjzAgiWtCMMAeMfmIqOFgtpQ/KWKBmU3zi+SmvyVc7SycTQMVT5yPXhh3JLZwf4scuV+TTlCW8mWIyuSjrYfX5P+387FZsMgZjYHwbOnFeLlSAJhTxiwLx0gTsd+5rIFuqHcRAnenCSvRZX9Gc4/574F6J1gMdFooNaCTQZsVMLb6rC72tZZxPpFNU5aND55QpQj1DkuONVCcboIvGYvXA7hmQOEDLspYabuMTbRyfKiDepmCRjB9ESwqi1Io8qbrKZ6HEvi0LeF/FRuwisSCqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVh95RheJ+95pnrqi7KVzRo4M3W3t08LsT+7Y3cet8Y=;
 b=eexX0MiQ1jHTfKs/7x6EYW+xOt9dxlANh3oJVKmL8uh0DsIiZyE4kWWfPv22o+cALs9AMRhPIOT5Qch+8oT9cl3l0vTLXgU6pt2aPcaAbaoDFAWm8PvKwRvX1TNMtzQyEVJ0HPD2EGMgu83Qj94TYH0O0KJGq7Mor+FiYqLuBBz9JWe9UbdqZMRtmbCKwoxKxYGGGaNk9QQ42dbcdmCllBGGZ5VsJmPhhmmS91YVHeAHHVJcG4ae66nyVQ5Mw5Ba9r8gRCJf8puh4qZMYRgvX6f6+apPjMExkkS+Wa25TtNveowZzVX4wk0fzlV9Up0fmPzicrYXGBPJJ1Su6CVOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2485.namprd12.prod.outlook.com (52.132.208.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 09:03:50 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f%5]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 09:03:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: fix no ACK from LDS read during stress
 test for Arcturus
Thread-Topic: [PATCH 1/1] drm/amdgpu: fix no ACK from LDS read during stress
 test for Arcturus
Thread-Index: AQHVjwDATHz9Gi7a7Ey9eYTlyQV6Qqdy48pQ
Date: Wed, 30 Oct 2019 09:03:49 +0000
Message-ID:
 <DM5PR12MB1418AF0984FE75A809EC957FFC600@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1572426131-16337-1-git-send-email-le.ma@amd.com>
In-Reply-To: <1572426131-16337-1-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bc8c7fe-ae81-4aa7-7545-08d75d181483
x-ms-traffictypediagnostic: DM5PR12MB2485:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB248545B5B202402D77A91747FC600@DM5PR12MB2485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(189003)(199004)(13464003)(8676002)(5660300002)(2906002)(2501003)(76116006)(305945005)(66446008)(66476007)(64756008)(66556008)(66946007)(8936002)(3846002)(6116002)(52536014)(81166006)(81156014)(4326008)(33656002)(6436002)(446003)(99286004)(229853002)(66066001)(478600001)(102836004)(7736002)(26005)(76176011)(14454004)(71190400001)(53546011)(6506007)(25786009)(74316002)(54906003)(6246003)(486006)(9686003)(476003)(316002)(86362001)(110136005)(7696005)(55016002)(11346002)(256004)(186003)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2485;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qkhlCRwpmSXnYdEup1iF736rXFxTZDd0/GiM3upzQLnUhnkLtIrNAfTBef+L6H6vWsREKAAWJ+NHSC6+vBkaXVNlfDRQczo3A6iP6MAKasBV/vXEAoOq8Pz+kyhv1Zd/4CK9AOluE42QrBBfYZFoWFP3+lRHRLhr93uBo26siA3O3UdM424Nvs5OenaIxX6i04/O95Trm60Lf4AvwHoGnJlXnaxuXAGPTQNTdEzZWhXTsU7YV/e84bXqk7H96kufKf46n9QH2WihJCqrJe4jhn/8pXQe/JscaYdqU08rdnTCAfejgmK5a5yizwFgiOxjyoqVnBMz+D6AS9Z3C1TwXO0jSrs/E9HYUqJ/VHNQH8gfowtY236UPLMHE/oYz52fcAc3ImKnRLBtw7pEaES3QWkIxF2u1dCRjQtcnx0CvJW+dd8xRd8j5E1IkVcW4rg
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc8c7fe-ae81-4aa7-7545-08d75d181483
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 09:03:49.9143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOIsuYrAnieLYtC76TLTKzPxHsVz1j21dPXmgFAFKvB77fsvX00TLcVFaUEotWE3J46F0vSCNUmLbHRPQED13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVh95RheJ+95pnrqi7KVzRo4M3W3t08LsT+7Y3cet8Y=;
 b=iyLipkhl6uudeppnVjYuP6OsqFZRZPdAuCj1Eq0IcEu4sMAgFyIAGX4ITpdwf0fA5h0M7I65zfzm2ov+stF0ErktH8rxm/TwKykrrzhWOlLBrLIaX+T47VXPLKdhnOMArwUFRHm4VYm7I5WdkGOYw0v+j+/n8tsD6VlfM3PcYEk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Cornwall, Jay" <Jay.Cornwall@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030090349.xu8W-Mq8n1TI8Sza3aM3F1xfKJfgXUV449Y7m6igmDc@z>

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVn
YXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMZSBNYSA8
bGUubWFAYW1kLmNvbT4gDQpTZW50OiAyMDE55bm0MTDmnIgzMOaXpSAxNzowMg0KVG86IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IENvcm53YWxsLCBKYXkgPEpheS5Db3Jud2FsbEBhbWQuY29tPjsgTWEsIExlIDxMZS5NYUBh
bWQuY29tPg0KU3ViamVjdDogW1BBVENIIDEvMV0gZHJtL2FtZGdwdTogZml4IG5vIEFDSyBmcm9t
IExEUyByZWFkIGR1cmluZyBzdHJlc3MgdGVzdCBmb3IgQXJjdHVydXMNCg0KU2V0IG1tU1FfQ09O
RklHLkRJU0FCTEVfU01FTV9TT0ZUX0NMQVVTRSBhcyBXL1IuDQoNCkNoYW5nZS1JZDogSTYyMjU5
MDlmZDYyNzAyNDI3ZmJiODA3ZTBjNmJhNmJhZmNmYTQxZDUNClNpZ25lZC1vZmYtYnk6IExlIE1h
IDxsZS5tYUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCmluZGV4IDVlN2EwMWMuLjA3OTYyY2EgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQpAQCAtNjk5LDYgKzY5OSw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2NfOV80XzFf
YXJjdFtdID0NCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1UQ1BfQ0hBTl9TVEVF
Ul8zX0FSQ1QsIDB4M2ZmZmZmZmYsIDB4MmViZDlmZTMpLA0KIAlTT0MxNV9SRUdfR09MREVOX1ZB
TFVFKEdDLCAwLCBtbVRDUF9DSEFOX1NURUVSXzRfQVJDVCwgMHgzZmZmZmZmZiwgMHhiOTBmNWIx
KSwNCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1UQ1BfQ0hBTl9TVEVFUl81X0FS
Q1QsIDB4M2ZmLCAweDEzNSksDQorCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tU1Ff
Q09ORklHLCAweGZmZmZmZmZmLCAweDAxMUEwMDAwKSwNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCB1
MzIgR0ZYX1JMQ19TUk1fSU5ERVhfQ05UTF9BRERSX09GRlNFVFNbXSA9DQotLSANCjIuNy40DQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
