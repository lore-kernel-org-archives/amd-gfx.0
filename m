Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D50CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B96217D9
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 20:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B96217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB00E6F85D;
	Fri,  1 Nov 2019 20:10:34 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe49::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E016F85F
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 20:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRHDbG3yBKZvYWpoYoySqxFru9qyXca97oF3yECkIgIQpiF75O8NlQ89FpKJPlwgi8aBjmRCx6deHqlASAUNaVFeeyhNGV8rDRSkFy6aAHG/gNgMOd+S/3VWFmH6YO1ERgxziPZttVsvcbx4vHKwghUK5DWvPZe8WOGBDFtGI1nZpzmk3rThVHGU3r/nWWFXkYlx7X5RC0iE3rQ+/x3CoXltFLnTkomPkR1kOpTA9AyEtzFTVc0Fk+Wqg3bIJbGSBbaw7RJplyRs/HAfgJ+tHUf4vOXwZVz3ggu5wbZOISpo/aZ/C81LdLRRTrSvE/VucWbkS4rPBDIcKPO2VzFgEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqerv2DDd9oUYhX8OGUuOUxSJSOmL/kc6hdxCy/C6m0=;
 b=D2jJ0IG704Kx6Iewo5OGdxt1TO4QWr8QYIRgXyY1nai7ETtkX/GOcIAF/hdu7Rv3tRPELYSzVTecVH5IPE6n8SNylq2raHNCTe2o6ha4FyXmi1h9nQBwhChqEzyl+ErSyDzBNC1ybmMnTUHtdjm/zVJtZOb/lg/0hqVm5oa85bNZ/vr4LhSfWG1jRKFUvFsrrjFK0+CDzumlQvQflELOPAKAGfOgkCE23MOFT0BOJ5PqfI5OHmiDyWjjGUPbpXuJ+ZtE8wdnL6HBeyw2ebX9EkejzcNsQhdG4sf8jp4kEsRlG6dVcTn491iH0nJ7UbyFERSw4pWo2UJQDAYS+6tQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3578.namprd12.prod.outlook.com (20.178.199.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 20:10:29 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 20:10:29 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Avoid using doorbell_off as offset in process
 doorbell pages
Thread-Topic: [PATCH 2/2] drm/amdkfd: Avoid using doorbell_off as offset in
 process doorbell pages
Thread-Index: AQHVkPBo0yCcVIuv5kSuAIFtKTLpCg==
Date: Fri, 1 Nov 2019 20:10:29 +0000
Message-ID: <20191101201016.5973-2-Yong.Zhao@amd.com>
References: <20191101201016.5973-1-Yong.Zhao@amd.com>
In-Reply-To: <20191101201016.5973-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2acba28b-7449-4db2-9a7a-08d75f078acf
x-ms-traffictypediagnostic: DM6PR12MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB357845C95ABC889C26C6A7F4F0620@DM6PR12MB3578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(66476007)(66446008)(26005)(6506007)(102836004)(386003)(86362001)(5660300002)(6916009)(305945005)(7736002)(76176011)(256004)(14444005)(2351001)(8936002)(8676002)(52116002)(186003)(50226002)(71190400001)(71200400001)(6486002)(478600001)(81166006)(6436002)(2906002)(476003)(5640700003)(6116002)(3846002)(1076003)(6512007)(99286004)(4326008)(2616005)(316002)(11346002)(446003)(486006)(81156014)(25786009)(14454004)(66946007)(36756003)(64756008)(66556008)(66066001)(2501003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3578;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FFCQlIjpsLR0oMpApEPld0peOIIggPE9B/R3ClfwD+uqFTbTi+eaV9ysE7RoqeYVQH5C5mgPJhqmVBgb6eW87albEKvlOg2AG1s/cdcFJUoiiohXO0vMJMWXBey/jRoJRPpkWdncltttigGceiAktg2vuEZ+wufa3CBniRAPjHWt5ftLVMYOijHiDDV/CgadQRG/A42N/Z3rHtx73skZJ3phxLsi1WHFts39bR2cPLrqgEt43vievTLiaR7yJxkTB9Q2jzQczeHHBE07aLUY8mcfVUWYhwCOp923DC0Uud97HQDCv5oRCiY8LBpqiG5y2WlASkazpyoZYpB3A91EoGUteuxpLUqgrGL7vSKsGk9YlPV7ShHoBSoH0FQanr5mSVf/NO65YEerfHeG3i6E962rfxSapiC5MTdW+eAs+pZuSzg72lj3PONwjBv+jICf
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acba28b-7449-4db2-9a7a-08d75f078acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 20:10:29.6184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5q9I1GYNOC/Z/GY4/gKUTJK4SycEdsGUtLuuPiCCvDsJIEPPujw7pDBoGPEKXrG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqerv2DDd9oUYhX8OGUuOUxSJSOmL/kc6hdxCy/C6m0=;
 b=M8TszrkXbYM1LVIAIteX8w74Uyn79hSu72pWtu5oBVKghgPp8lelAfOxlB44fehCeIJ70ATJEGu5AO5zhHuxAtAAIXCL2GrcsIcFx6bAzkv3ihCvCpuOdmo1bUYV7ODXsZpcDvN1DdPHvTR8/uiXRbIyVeqNaY4PM32V5i77sks=
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
Message-ID: <20191101201029.bR2AXaTJzqvt0f8-Vy_cgZeXQ5wadoAFceWc436zmek@z>

ZG9yYmVsbF9vZmYgaW4gdGhlIHF1ZXVlIHByb3BlcnRpZXMgaXMgbWFpbmx5IHVzZWQgZm9yIHRo
ZSBkb29yYmVsbCBkdwpvZmZzZXQgaW4gcGNpIGJhci4gV2Ugc2hvdWxkIG5vdCBzZXQgaXQgdG8g
dGhlIGRvb3JiZWxsIGJ5dGUgb2Zmc2V0IGluCnByb2Nlc3MgZG9vcmJlbGwgcGFnZXMuIFRoaXMg
bWFrZXMgdGhlIGNvZGUgbXVjaCBlYXNpZXIgdG8gcmVhZC4KCkNoYW5nZS1JZDogSTU1MzA0NWZm
OWZjYjM2NzY5MDBjOTJkMTA0MjZmMmNlYjM2NjAwMDUKU2lnbmVkLW9mZi1ieTogWW9uZyBaaGFv
IDxZb25nLlpoYW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
Y2hhcmRldi5jICAgICAgICAgICAgIHwgMTIgKysrKysrLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGJnZGV2LmMgICAgICAgICAgICAgIHwgIDIgKy0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggICAgICAgICAgICAgICAgfCAgMyArKy0KIC4uLi9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jICAgfCAgOCArKysr
KystLQogNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwppbmRleCBkOWUzNmRiZjEz
ZDUuLmI5MTk5Mzc1M2I4MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX2NoYXJkZXYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRl
di5jCkBAIC0yNTgsNiArMjU4LDcgQEAgc3RhdGljIGludCBrZmRfaW9jdGxfY3JlYXRlX3F1ZXVl
KHN0cnVjdCBmaWxlICpmaWxlcCwgc3RydWN0IGtmZF9wcm9jZXNzICpwLAogCXVuc2lnbmVkIGlu
dCBxdWV1ZV9pZDsKIAlzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQ7CiAJc3RydWN0IHF1
ZXVlX3Byb3BlcnRpZXMgcV9wcm9wZXJ0aWVzOworCXVpbnQzMl90IGRvb3JiZWxsX29mZnNldF9p
bl9wcm9jZXNzID0gMDsKIAogCW1lbXNldCgmcV9wcm9wZXJ0aWVzLCAwLCBzaXplb2Yoc3RydWN0
IHF1ZXVlX3Byb3BlcnRpZXMpKTsKIApAQCAtMjg2LDcgKzI4Nyw4IEBAIHN0YXRpYyBpbnQga2Zk
X2lvY3RsX2NyZWF0ZV9xdWV1ZShzdHJ1Y3QgZmlsZSAqZmlsZXAsIHN0cnVjdCBrZmRfcHJvY2Vz
cyAqcCwKIAkJCXAtPnBhc2lkLAogCQkJZGV2LT5pZCk7CiAKLQllcnIgPSBwcW1fY3JlYXRlX3F1
ZXVlKCZwLT5wcW0sIGRldiwgZmlsZXAsICZxX3Byb3BlcnRpZXMsICZxdWV1ZV9pZCk7CisJZXJy
ID0gcHFtX2NyZWF0ZV9xdWV1ZSgmcC0+cHFtLCBkZXYsIGZpbGVwLCAmcV9wcm9wZXJ0aWVzLCAm
cXVldWVfaWQsCisJCQkmZG9vcmJlbGxfb2Zmc2V0X2luX3Byb2Nlc3MpOwogCWlmIChlcnIgIT0g
MCkKIAkJZ290byBlcnJfY3JlYXRlX3F1ZXVlOwogCkBAIC0yOTgsMTIgKzMwMCwxMCBAQCBzdGF0
aWMgaW50IGtmZF9pb2N0bF9jcmVhdGVfcXVldWUoc3RydWN0IGZpbGUgKmZpbGVwLCBzdHJ1Y3Qg
a2ZkX3Byb2Nlc3MgKnAsCiAJYXJncy0+ZG9vcmJlbGxfb2Zmc2V0IHw9IEtGRF9NTUFQX0dQVV9J
RChhcmdzLT5ncHVfaWQpOwogCWFyZ3MtPmRvb3JiZWxsX29mZnNldCA8PD0gUEFHRV9TSElGVDsK
IAlpZiAoS0ZEX0lTX1NPQzE1KGRldi0+ZGV2aWNlX2luZm8tPmFzaWNfZmFtaWx5KSkKLQkJLyog
T24gU09DMTUgQVNJQ3MsIGRvb3JiZWxsIGFsbG9jYXRpb24gbXVzdCBiZQotCQkgKiBwZXItZGV2
aWNlLCBhbmQgaW5kZXBlbmRlbnQgZnJvbSB0aGUgcGVyLXByb2Nlc3MKLQkJICogcXVldWVfaWQu
IFJldHVybiB0aGUgZG9vcmJlbGwgb2Zmc2V0IHdpdGhpbiB0aGUKLQkJICogZG9vcmJlbGwgYXBl
cnR1cmUgdG8gdXNlciBtb2RlLgorCQkvKiBPbiBTT0MxNSBBU0lDcywgaW5jbHVkZSB0aGUgZG9v
cmJlbGwgb2Zmc2V0IHdpdGhpbiB0aGUKKwkJICogcHJvY2VzcyBkb29yYmVsbCBmcmFtZSwgd2hp
Y2ggY291bGQgYmUgMSBwYWdlIG9yIDIgcGFnZXMuCiAJCSAqLwotCQlhcmdzLT5kb29yYmVsbF9v
ZmZzZXQgfD0gcV9wcm9wZXJ0aWVzLmRvb3JiZWxsX29mZjsKKwkJYXJncy0+ZG9vcmJlbGxfb2Zm
c2V0IHw9IGRvb3JiZWxsX29mZnNldF9pbl9wcm9jZXNzOwogCiAJbXV0ZXhfdW5sb2NrKCZwLT5t
dXRleCk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kYmdk
ZXYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kYmdkZXYuYwppbmRleCBkNTlm
MmNkMDU2YzYuLjFkMzNjNGYyNTI2MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RiZ2Rldi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9k
YmdkZXYuYwpAQCAtMTg1LDcgKzE4NSw3IEBAIHN0YXRpYyBpbnQgZGJnZGV2X3JlZ2lzdGVyX2Rp
cShzdHJ1Y3Qga2ZkX2RiZ2RldiAqZGJnZGV2KQogCXByb3BlcnRpZXMudHlwZSA9IEtGRF9RVUVV
RV9UWVBFX0RJUTsKIAogCXN0YXR1cyA9IHBxbV9jcmVhdGVfcXVldWUoZGJnZGV2LT5wcW0sIGRi
Z2Rldi0+ZGV2LCBOVUxMLAotCQkJCSZwcm9wZXJ0aWVzLCAmcWlkKTsKKwkJCQkmcHJvcGVydGll
cywgJnFpZCwgTlVMTCk7CiAKIAlpZiAoc3RhdHVzKSB7CiAJCXByX2VycigiRmFpbGVkIHRvIGNy
ZWF0ZSBESVFcbiIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3ByaXYuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKaW5kZXggN2M1
NjFjOThmMmUyLi42NmJhZThmMmRhZDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcml2LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3By
aXYuaApAQCAtOTA3LDcgKzkwNyw4IEBAIGludCBwcW1fY3JlYXRlX3F1ZXVlKHN0cnVjdCBwcm9j
ZXNzX3F1ZXVlX21hbmFnZXIgKnBxbSwKIAkJCSAgICBzdHJ1Y3Qga2ZkX2RldiAqZGV2LAogCQkJ
ICAgIHN0cnVjdCBmaWxlICpmLAogCQkJICAgIHN0cnVjdCBxdWV1ZV9wcm9wZXJ0aWVzICpwcm9w
ZXJ0aWVzLAotCQkJICAgIHVuc2lnbmVkIGludCAqcWlkKTsKKwkJCSAgICB1bnNpZ25lZCBpbnQg
KnFpZCwKKwkJCSAgICB1aW50MzJfdCAqcF9kb29yYmVsbF9vZmZzZXRfaW5fcHJvY2Vzcyk7CiBp
bnQgcHFtX2Rlc3Ryb3lfcXVldWUoc3RydWN0IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLCB1
bnNpZ25lZCBpbnQgcWlkKTsKIGludCBwcW1fdXBkYXRlX3F1ZXVlKHN0cnVjdCBwcm9jZXNzX3F1
ZXVlX21hbmFnZXIgKnBxbSwgdW5zaWduZWQgaW50IHFpZCwKIAkJCXN0cnVjdCBxdWV1ZV9wcm9w
ZXJ0aWVzICpwKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
cm9jZXNzX3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9w
cm9jZXNzX3F1ZXVlX21hbmFnZXIuYwppbmRleCA4NTA5ODE0YTZmZjAuLjQ4MTg1ZDI5NTdlOSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVf
bWFuYWdlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1
ZXVlX21hbmFnZXIuYwpAQCAtMTkyLDcgKzE5Miw4IEBAIGludCBwcW1fY3JlYXRlX3F1ZXVlKHN0
cnVjdCBwcm9jZXNzX3F1ZXVlX21hbmFnZXIgKnBxbSwKIAkJCSAgICBzdHJ1Y3Qga2ZkX2RldiAq
ZGV2LAogCQkJICAgIHN0cnVjdCBmaWxlICpmLAogCQkJICAgIHN0cnVjdCBxdWV1ZV9wcm9wZXJ0
aWVzICpwcm9wZXJ0aWVzLAotCQkJICAgIHVuc2lnbmVkIGludCAqcWlkKQorCQkJICAgIHVuc2ln
bmVkIGludCAqcWlkLAorCQkJICAgIHVpbnQzMl90ICpwX2Rvb3JiZWxsX29mZnNldF9pbl9wcm9j
ZXNzKQogewogCWludCByZXR2YWw7CiAJc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkOwpA
QCAtMzA3LDggKzMwOCwxMSBAQCBpbnQgcHFtX2NyZWF0ZV9xdWV1ZShzdHJ1Y3QgcHJvY2Vzc19x
dWV1ZV9tYW5hZ2VyICpwcW0sCiAJCS8qIFJldHVybiB0aGUgZG9vcmJlbGwgb2Zmc2V0IHdpdGhp
biB0aGUgZG9vcmJlbGwgcGFnZQogCQkgKiB0byB0aGUgY2FsbGVyIHNvIGl0IGNhbiBiZSBwYXNz
ZWQgdXAgdG8gdXNlciBtb2RlCiAJCSAqIChpbiBieXRlcykuCisJCSAqIFRoZXJlIGFyZSBhbHdh
eXMgMTAyNCBkb29yYmVsbHMgcGVyIHByb2Nlc3MsIHNvIGluIGNhc2UKKwkJICogb2YgOC1ieXRl
IGRvb3JiZWxscywgdGhlcmUgYXJlIHR3byBkb29yYmVsbCBwYWdlcyBwZXIKKwkJICogcHJvY2Vz
cy4KIAkJICovCi0JCXByb3BlcnRpZXMtPmRvb3JiZWxsX29mZiA9CisJCSpwX2Rvb3JiZWxsX29m
ZnNldF9pbl9wcm9jZXNzID0KIAkJCShxLT5wcm9wZXJ0aWVzLmRvb3JiZWxsX29mZiAqIHNpemVv
Zih1aW50MzJfdCkpICYKIAkJCShrZmRfZG9vcmJlbGxfcHJvY2Vzc19zbGljZShkZXYpIC0gMSk7
CiAKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
