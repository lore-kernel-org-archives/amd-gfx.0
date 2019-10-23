Return-Path: <SRS0=+G2B=YQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8636CA9EB6
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 12:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FDC2064A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2019 12:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FDC2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637D06EA57;
	Wed, 23 Oct 2019 12:02:48 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680086.outbound.protection.outlook.com [40.107.68.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7170B6EA57
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2019 12:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnIPsYyshoqohWSNZFtGCAaDLxKyjKxe9bSwj4ZoaCYmPgopmqVAfIzGrC+wHptLeiwsZsxu1A0ywd238lfmScY9OLtIdH5pIzbFGP7I+xXh87q6sXV4Q5I73vcLFF+Pg00G9CX3oKhxnyXlit4VcHgrBAA+/aoMu9ml04Y9tAD743HGE43IiMJfOmpXqoaNGd5mjc2+/7YH+okCZSe2wdK5sd39MJBQoAqmNRImuSK+ZE25n7+qWlAzoUopzHkIOWmW8VcdbrqlPUkp0tTjAYq+BCePtNPtGymPmVE4Jk659dflTs3dBp6yoNmiMrTs7MXXcIfZKsUjXL/AnrGGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4VtCDOHMuAMQy5dShOdGgk3uNimqKeIomwBlgzDg6Q=;
 b=MIYyPuylVlCxPd8ryn25SqqYBxjAMZX34I3obvlh+VHrPpwfvESWwzGF2E43RgmsqTb8cGJEoiZE3aOvrdKyGFSq2/tqyM16xw2TKICIgt0sd60r5Q4fyAUVp+izZgRyj5sWZ1JWYlkNeDiJfoS47bg6pztYzo+tNmaRcZKwmBuG6zJBcDmIxuDuEQkJ5Qh8/LI0nskiYzI7Jgs+ZF+NtJQXaAx/YCDx2RMOAbY+y2NQ577BM2GNNBBeTNOIjyz0dbOjARuFrsBJORCE8SekeTfGto7LQHRIYFT8ZpaIAN4Te98Ex9ZwGgNeFOqNNzlUKQ6CHqo+099Tdn0qsZ0tzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (10.174.109.137) by
 DM5PR1201MB2489.namprd12.prod.outlook.com (10.172.87.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 23 Oct 2019 12:02:45 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::3dc3:4b65:db8a:47a2]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::3dc3:4b65:db8a:47a2%9]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 12:02:45 +0000
From: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: call amdgpu_vm_prt_fini before deleting the root
 PD
Thread-Topic: [PATCH] drm/amdgpu: call amdgpu_vm_prt_fini before deleting the
 root PD
Thread-Index: AQHViZnHtm6i7sAG9EGArZzHFpdjwQ==
Date: Wed, 23 Oct 2019 12:02:45 +0000
Message-ID: <20191023120221.13537-1-pierre-eric.pelloux-prayer@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2P264CA0023.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::35)
 To DM5PR1201MB0187.namprd12.prod.outlook.com
 (2603:10b6:4:5b::9)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0.rc1
x-originating-ip: [109.190.135.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2927ac46-9326-48c3-cb81-08d757b0ea49
x-ms-traffictypediagnostic: DM5PR1201MB2489:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2489E24B5E03A3145FC933028D6B0@DM5PR1201MB2489.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(486006)(386003)(99286004)(6506007)(55236004)(52116002)(2351001)(2616005)(71190400001)(71200400001)(6486002)(476003)(66476007)(2501003)(2906002)(66556008)(66446008)(66946007)(4326008)(186003)(25786009)(26005)(14454004)(102836004)(64756008)(5660300002)(50226002)(81156014)(36756003)(316002)(86362001)(8676002)(6436002)(8936002)(305945005)(6512007)(7736002)(14444005)(5640700003)(256004)(66066001)(6116002)(478600001)(6916009)(3846002)(1076003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2489;
 H:DM5PR1201MB0187.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trb0tmUivb+iJ4VqYaEOV+1FxUiCfjUZdLctXT2uQkoR6ZG77M4nb3X5nIgczFGtVxo9vBd6yHnQmxAxfRCRLdZt2nD89sgdtfjkCorVNfOF2vwGo3oHVx2Uv0xKZdAxVlbujAHmP/gbEsqoOsQ3dH0yyD8OhjQ4Aye8K+nz/HDMv3So7BynZuB7w5xEo8LXqDvz3cI1tNV1Im8qG3XazOw6Wv9dHiTorf5Az+Aivqq2/B1FzGuULYJI6Xx4HGWvgCgueMQCGxoDXZeg5Ka9pAIAdD6tCEZtRVrUFZwkCI+XFtXnfkLP1o4TBKumTNfn701GuxRaJd6J5podNGfs636h6OapNWZzOg5cxIhAgXhcYXkJWEVdibBsZnDxnwKl63HRu38X3XjJ7MDhsrBUaQHCUr37UTY8T2DWYaRH19ioX1VqEntOv/Gyt0yHve0N
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2927ac46-9326-48c3-cb81-08d757b0ea49
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 12:02:45.5928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Kak8IYtbtk2uOtQRarJG/wC3ZQ9NZc31tTyiB1neEQEG+FyeMSqJOwr6nodCB4QHOdVreHVxDcLqqKf4P32mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4VtCDOHMuAMQy5dShOdGgk3uNimqKeIomwBlgzDg6Q=;
 b=CR2lgotn6eGPWjE7Gsx0848Q3fNYblm5aSHEV6NXu5iG6va9s0+tpOH61KVJZCWYuH0FaGnvQOwNwgbGkIX53V64gOJS+20BDkLlPKNAXWs+NcfzpodUtjEceguuJx1I2IviEYqf7usugMO/kTaF7toPAy00ErkNf1e7qtpEfzA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
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
Cc: "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023120245.hJKVRRiFf_Qz-fCyGF1dHEwBiuy-0kDXkYwAxfLQj8M@z>

YW1kZ3B1X3ZtX3BydF9maW5pIHVzZXMgInZtLT5yb290LmJhc2UuYm8iIHNvIGl0IG11c3Qgc3Rp
bGwgYmUgdmFsaWQgd2hlbgp3ZSBjYWxsIGl0LgoKRml4ZXM6IGI2NTcwOWE5MjE1NiAoImRybS9h
bWRncHU6IHJlc2VydmUgdGhlIHJvb3QgUEQgd2hpbGUgZnJlZWluZyBQQVNJRHMiKQpTaWduZWQt
b2ZmLWJ5OiBQaWVycmUtRXJpYyBQZWxsb3V4LVByYXllciA8cGllcnJlLWVyaWMucGVsbG91eC1w
cmF5ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyB8IDE5ICsrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
aW5kZXggZDliZWNlOTg3ZTYwLi5jOGNlNDIyMDAwNTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCkBAIC0yOTc1LDYgKzI5NzUsMTYgQEAgdm9pZCBhbWRncHVfdm1fZmlu
aShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pCiAJCXZt
LT5wYXNpZCA9IDA7CiAJfQogCisJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKG1hcHBpbmcsIHRt
cCwgJnZtLT5mcmVlZCwgbGlzdCkgeworCQlpZiAobWFwcGluZy0+ZmxhZ3MgJiBBTURHUFVfUFRF
X1BSVCAmJiBwcnRfZmluaV9uZWVkZWQpIHsKKwkJCWFtZGdwdV92bV9wcnRfZmluaShhZGV2LCB2
bSk7CisJCQlwcnRfZmluaV9uZWVkZWQgPSBmYWxzZTsKKwkJfQorCisJCWxpc3RfZGVsKCZtYXBw
aW5nLT5saXN0KTsKKwkJYW1kZ3B1X3ZtX2ZyZWVfbWFwcGluZyhhZGV2LCB2bSwgbWFwcGluZywg
TlVMTCk7CisJfQorCiAJYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHZtLCBOVUxMKTsKIAlhbWRn
cHVfYm9fdW5yZXNlcnZlKHJvb3QpOwogCWFtZGdwdV9ib191bnJlZigmcm9vdCk7CkBAIC0yOTk0
LDE1ICszMDA0LDYgQEAgdm9pZCBhbWRncHVfdm1fZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pCiAJCWxpc3RfZGVsKCZtYXBwaW5nLT5saXN0KTsK
IAkJa2ZyZWUobWFwcGluZyk7CiAJfQotCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShtYXBwaW5n
LCB0bXAsICZ2bS0+ZnJlZWQsIGxpc3QpIHsKLQkJaWYgKG1hcHBpbmctPmZsYWdzICYgQU1ER1BV
X1BURV9QUlQgJiYgcHJ0X2ZpbmlfbmVlZGVkKSB7Ci0JCQlhbWRncHVfdm1fcHJ0X2ZpbmkoYWRl
diwgdm0pOwotCQkJcHJ0X2ZpbmlfbmVlZGVkID0gZmFsc2U7Ci0JCX0KLQotCQlsaXN0X2RlbCgm
bWFwcGluZy0+bGlzdCk7Ci0JCWFtZGdwdV92bV9mcmVlX21hcHBpbmcoYWRldiwgdm0sIG1hcHBp
bmcsIE5VTEwpOwotCX0KIAogCWRtYV9mZW5jZV9wdXQodm0tPmxhc3RfdXBkYXRlKTsKIAlmb3Ig
KGkgPSAwOyBpIDwgQU1ER1BVX01BWF9WTUhVQlM7IGkrKykKLS0gCjIuMjMuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
