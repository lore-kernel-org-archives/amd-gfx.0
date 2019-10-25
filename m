Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4EFCA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 21:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9522084C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 21:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9522084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E0A6EBA4;
	Fri, 25 Oct 2019 21:21:16 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740057.outbound.protection.outlook.com [40.107.74.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADBA06EBA4
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2019 21:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtQHSEMPUAyDSuZhUNeL0yv1WZfgQ2NdfmOig7a2binCQkuoWX6QuaeeWkf/zzjlU9XCQOxLPcNzPJ/t+SgXHdYNHnvBc5j6tbqXGX/dBiLdHCs5t5AaebJy2S6h9jvSkY55DqKOuF4ZtIaYzcqeAbu7HnubKmnDaT8uMCG4zuok+1+UhntG86u6SlRN90LVVWO7hNbNz8tNAunhGqbZtnWpGb3gEMtkdfSW5dwR8+c7WDj3hvvPzJW9YnevgJe86cUGSjO3GhxVSf6+m1neWuoJu0bdFxXrJSCpr6YnjB9gY9myUpU9AofhFcaxQuGbboaYNrHR4b234oegyFW9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPJfHU1YOQbtjC1qy36hfXFGDqOf68X/+aqHcJ9ylHk=;
 b=igMpGly2AUXcl0HexO2L9/6KqaQAxLcvrTuKpzXMFGV+86Zt0UKBBB8rOIARlco6QxAAurw5eT5MnviavPXiebp2yrEMjGaWtkj6df04iCaJ2ChcwRhx0M3SFW8ujVjEqdlKS+THsBKWhsRqNJBSoW1r28viZpdUqWrpTXc6h6VBwR9hezTSaRpOrAEkrFORRbQhSP3DBF4ENGDrJOKbY6bGJc+x7ZKGqJCjWUIdvelVPp04MtYC8LvBz/HFEdznN+f5FtJonXxkiZ8u0OLT0l4bCj264tMIuezzDjmYJyaodrc2e6E8IsAQlrx2daH0R8lYKxyNvrBcOXPUubu0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3451.namprd12.prod.outlook.com (20.178.198.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 25 Oct 2019 21:21:12 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2367.022; Fri, 25 Oct 2019
 21:21:12 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch
Thread-Topic: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch
Thread-Index: AQHVi3ogYN+NqR6qnka/6FWRBfNMxQ==
Date: Fri, 25 Oct 2019 21:21:12 +0000
Message-ID: <20191025212059.10355-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::39) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 455576ae-93e8-489e-69d2-08d7599142d9
x-ms-traffictypediagnostic: DM6PR12MB3451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3451185FB9CAE65D64F745A7F0650@DM6PR12MB3451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(256004)(186003)(36756003)(52116002)(476003)(4326008)(2351001)(6116002)(3846002)(6512007)(6916009)(5640700003)(2616005)(86362001)(6486002)(8676002)(14454004)(6436002)(7736002)(305945005)(486006)(81166006)(102836004)(8936002)(81156014)(66066001)(2501003)(316002)(25786009)(26005)(66946007)(50226002)(66476007)(66446008)(64756008)(66556008)(5660300002)(6506007)(1076003)(71190400001)(71200400001)(386003)(478600001)(99286004)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3451;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Sj3eh+EnjA4Y1m1/39HYDsUkoJ6+vGp7zeDeNwKLe7i/lPPO8Y+//y0xrOmX+RTsVn0wjuw7Q+nwt5HWlqTx9QkDBSt0abvS0E6mcbs/F7niAN6qrP2LLEmL8QeTQ8cre0ij5fNwT8LByMjd4zIlem6E+kYeLUbmBQldIDHuiIzGn2jGG46Ck60WVK2AlHpZl2W7/hgxk2nPiYHGLfnSa1Mf6GNNDSexviY4rlOcJEV9W58HMMT+g+5LJZzC4V2cjB5iDLdvP7bq6M3bUAkLgPyWJEwfQow9RG8wxxQTtqbIBjnpm6GVz30uQ/GCbDW1PAY6wEO4My4ugJ0kg16g8jCObI1o3WVfCo+jApeok5omm8BeXnS2um+YDy0b4BfFT6TCLR1uuvY3AzpYjmwcRD7pbz0TyCONjj7UKnLMFYY8wqpPztgnrJsoN1oyo6I
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455576ae-93e8-489e-69d2-08d7599142d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 21:21:12.5367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wD0hsq8671CamsKBDwNbrnialOs6Oj/+4AXR9spKKK0o1JbSPZr9Scubulxe5IiI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3451
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPJfHU1YOQbtjC1qy36hfXFGDqOf68X/+aqHcJ9ylHk=;
 b=MGlup2uIrpJX4WpSKHQpOXFHBLDHyGy7NShlscYFjK956ISDdKMEYTK0xvEiZ7Ky+8f+q341RT+emapL+S7ikegRekNpojR5pTWTZUZvfzWj6WAfDs0xZ+qNmO6FCntryEdF9CUCChOY1NJC12suwW4yXPWvuuYQVd9skfE4I14=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025212112.y4y-fmgmIly56pqQre1QJ3oD9TRtollbs87NfiAOoOs@z>

R2l2ZW4gYW1ka2ZkLmtvIGhhcyBiZWVuIG1lcmdlZCBpbnRvIGFtZGdwdS5rbywgdGhpcyBzd2l0
Y2ggaXMgbm8KbG9uZ2VyIHVzZWZ1bC4KCkNoYW5nZS1JZDogSWY1NmI4MGUwODZmNGVhMjZmMzQ3
YzcwYjYyMGIzODkyYWZjMjRkZGYKU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9A
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMg
ICAgICAgICAgfCAxIC0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
YXJjdHVydXMuYyB8IDQgLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9nZnhfdjEwLmMgIHwgMyAtLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ2Z4X3Y3LmMgICB8IDEgLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9nZnhfdjguYyAgIHwgMSAtCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2dmeF92OS5jICAgfCAzIC0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jICAgIHwgMyAtLS0KIDcgZmlsZXMgY2hhbmdlZCwgMTYg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5j
CmluZGV4IGQzZGE5ZGRlNGVlMS4uZmE1NDcxYzEyYzM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCkBAIC0xOSw3ICsxOSw2IEBACiAgKiBBUklTSU5HIEZS
T00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRIRSBVU0Ug
T1IKICAqIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KICAqLwotCiAjaW5jbHVkZSAi
YW1kZ3B1X2FtZGtmZC5oIgogI2luY2x1ZGUgImFtZF9zaGFyZWQuaCIKIApkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jCmluZGV4IGUx
ZmJiZWJjZTRmZC4uYjY3MTNlMGVkMWIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkX2FyY3R1cnVzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hcmN0dXJ1cy5jCkBAIC0xOSwxMCArMTksNiBAQAogICog
QVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBP
UiBUSEUgVVNFIE9SCiAgKiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuCiAgKi8KLQot
I3VuZGVmIHByX2ZtdAotI2RlZmluZSBwcl9mbXQoZm10KSAia2ZkMmtnZDogIiBmbXQKLQogI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2ZkdGFibGUuaD4KICNpbmNs
dWRlIDxsaW51eC91YWNjZXNzLmg+CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92MTAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ2Z4X3YxMC5jCmluZGV4IDA4NzhmNTllYzM0MC4uNjFjZDcwNzE1OGU0
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dm
eF92MTAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dm
eF92MTAuYwpAQCAtMTksOSArMTksNiBAQAogICogQVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4g
Q09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SCiAgKiBPVEhFUiBERUFM
SU5HUyBJTiBUSEUgU09GVFdBUkUuCiAgKi8KLSN1bmRlZiBwcl9mbXQKLSNkZWZpbmUgcHJfZm10
KGZtdCkgImtmZDJrZ2Q6ICIgZm10Ci0KICNpbmNsdWRlIDxsaW51eC9tbXVfY29udGV4dC5oPgog
I2luY2x1ZGUgImFtZGdwdS5oIgogI2luY2x1ZGUgImFtZGdwdV9hbWRrZmQuaCIKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y3LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92Ny5jCmluZGV4IDZl
NmYwYTk5ZWMwNi4uMzA4OTdiMmQ5MTc1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92Ny5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y3LmMKQEAgLTE5LDcgKzE5LDYgQEAKICAqIEFSSVNJ
TkcgRlJPTSwgT1VUIE9GIE9SIElOIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhF
IFVTRSBPUgogICogT1RIRVIgREVBTElOR1MgSU4gVEhFIFNPRlRXQVJFLgogICovCi0KICNpbmNs
dWRlIDxsaW51eC9tbXVfY29udGV4dC5oPgogCiAjaW5jbHVkZSAiYW1kZ3B1LmgiCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjguYwppbmRleCBi
ZmJkZGVkYjIzODAuLmVkZTZhYjBjYmU0YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OC5jCkBAIC0xOSw3ICsxOSw2IEBACiAgKiBBUklT
SU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRI
RSBVU0UgT1IKICAqIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KICAqLwotCiAjaW5j
bHVkZSA8bGludXgvbW11X2NvbnRleHQuaD4KIAogI2luY2x1ZGUgImFtZGdwdS5oIgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMKaW5kZXgg
YzcyMjQ2ZjJjMDhhLi40N2M4NTNlZjEwNTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYwpAQCAtMTksOSArMTksNiBAQAogICogQVJJ
U0lORyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBU
SEUgVVNFIE9SCiAgKiBPVEhFUiBERUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuCiAgKi8KLQotI2Rl
ZmluZSBwcl9mbXQoZm10KSAia2ZkMmtnZDogIiBmbXQKLQogI2luY2x1ZGUgPGxpbnV4L21tdV9j
b250ZXh0Lmg+CiAKICNpbmNsdWRlICJhbWRncHUuaCIKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwppbmRleCAxZmJlODEwOTRiNWYuLjk3MTE0
ZTE4YzAyMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZF9ncHV2bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYwpAQCAtMTksOSArMTksNiBAQAogICogQVJJU0lORyBGUk9NLCBPVVQgT0YgT1Ig
SU4gQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBUSEUgVVNFIE9SCiAgKiBPVEhFUiBE
RUFMSU5HUyBJTiBUSEUgU09GVFdBUkUuCiAgKi8KLQotI2RlZmluZSBwcl9mbXQoZm10KSAia2Zk
MmtnZDogIiBmbXQKLQogI2luY2x1ZGUgPGxpbnV4L2RtYS1idWYuaD4KICNpbmNsdWRlIDxsaW51
eC9saXN0Lmg+CiAjaW5jbHVkZSA8bGludXgvcGFnZW1hcC5oPgotLSAKMi4xNy4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
