Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E62CCA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 15:25:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1C320873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 15:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1C320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9251E6EEC5;
	Thu, 31 Oct 2019 15:25:04 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790059.outbound.protection.outlook.com [40.107.79.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8106E6EEC5
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 15:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBQXBOmXKe/yRm5WHxFfnpDdTGHLAmT0NatE6+Vds/lxzCYiz0O4ZBgUffpCGIuXXPDHBP4wC4J1nZse8Z+i2E1rzcfvT9t6o7SRJkK9Ooqn3dmnjXLSiUUyyU+tk0m53TuE16YSGGE6EsnqOj5NfEPmCuY0L+4IGTGTtXTwvUgdN5OFyzxX9qMRbCIvjw/n9HUYsbwDr5K+k3bipjVpc6ZkdaNbRNAHwGT9NKNhufJVP8SSGaHk9IvGiBVoczQrzMNy9AAh2927ltFVTm/DrVZ35ivvGOGKIKPVSR97CG4xw8m4i7n9O0xkoMafyM7Jhd/SZN/4eTisrN2UCwl+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHAI7dnOfq+JW/3witRUSG1AXEk4fpPzYgYTo2FrcuI=;
 b=k1itA6IFX/y9TpGnt/iBoZd5IODl/380CoBH4HKU4sOos06M7rV+IYhQSTGH/ghtqm7lSAQfyQQqIRWJoP9zm+2qk/IdnIT+zTnLN7wYwaM0rGTwINDXU7kRmWo4qGZDVXBoOjJFr4ZcLve2XoJC1cRntoUDgwjSCCBz4UyMTEkAIWdu2rDPjvM/gyKl6or2bZiaLQPKO1OUPWk4LvGOh/AB/qIy6SO5XqxzPCirIpbiNESbdLn5bM19YeDY4YVqhbh6Fs9f7aUFluuJP5rKayIvG990wK2ZCZAZsp3d2VjQjZpgyl0rJMMMEB0NTpgP3r0kffdQbzTBP5pZUaPYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1254.namprd12.prod.outlook.com (10.168.169.17) by
 CY4PR12MB1638.namprd12.prod.outlook.com (10.172.72.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 31 Oct 2019 15:25:01 +0000
Received: from CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::88ff:f1df:158e:2add]) by CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::88ff:f1df:158e:2add%11]) with mapi id 15.20.2387.028; Thu, 31 Oct
 2019 15:25:01 +0000
From: James Zhu <jamesz@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: enable VCN DPG on Raven and Raven2
Thread-Topic: [PATCH] drm/amdgpu: enable VCN DPG on Raven and Raven2
Thread-Index: AQHVj/mm6HDz8NyjX0eznb6ykKf5pqd03sOA
Date: Thu, 31 Oct 2019 15:25:01 +0000
Message-ID: <cfcdd75d-155a-efb1-05d0-a05cfc2ade37@amd.com>
References: <20191031144341.752222-1-alexander.deucher@amd.com>
In-Reply-To: <20191031144341.752222-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::47) To CY4PR12MB1254.namprd12.prod.outlook.com
 (2603:10b6:903:41::17)
x-originating-ip: [165.204.55.251]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac6b3058-5382-4fd4-5790-08d75e167f3b
x-ms-traffictypediagnostic: CY4PR12MB1638:
x-microsoft-antispam-prvs: <CY4PR12MB1638B2AEE441B6F41276EAE5E4630@CY4PR12MB1638.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(199004)(189003)(31696002)(4001150100001)(11346002)(446003)(81156014)(6916009)(66066001)(81166006)(2616005)(25786009)(476003)(8936002)(66476007)(66446008)(66556008)(66946007)(64756008)(2906002)(486006)(6116002)(3846002)(478600001)(2351001)(8676002)(36756003)(31686004)(229853002)(52116002)(99286004)(2501003)(6512007)(5640700003)(316002)(76176011)(386003)(71200400001)(6246003)(256004)(71190400001)(186003)(6486002)(6436002)(26005)(305945005)(5660300002)(102836004)(7736002)(6506007)(53546011)(14454004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1638;
 H:CY4PR12MB1254.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZjFiun8xJZyNHWLzaMNm5/A7qtm2f8s6M34CQtpOxomAu4sQEn+0irsEOjmmyQ3TvGC8aRi0UA+mx3Fbp0ZYVVX4B3L/SSQlDhx0020696YuaGxXm+oFLKvBQtgdO2tdCsMcCV6VrHvW953XmdSgpMNn5qcI+JJzqMv+3bLRvB3V7p7NbuYGmtbZo0GgGpPBtnZEeEvfX3e/LJd7WAnicYGwFm+c2MKyXf7J3KZ3u//IcobRUtfHbIyOM5bk7l+JIJFYGMfMHhdwNDkP49Jacg5bGXCewvYGkuks6bS3MHWe6sEUkKyDf66po5malHBOPRdC34g5n3r8vNdASfNp378NKjfjTIYE77F5qhlFe7b+ah4zdeXgLtyFAErHloyepyaehWNr8bMmr6a1oJAzo90VRPFVyhi+F3dX3SYm4ZugeYNZyq6gDbT8OhNhsWCI
x-ms-exchange-transport-forked: True
Content-ID: <ECF5A9E23AEE3F4E9A429E943BDF4AF1@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6b3058-5382-4fd4-5790-08d75e167f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 15:25:01.5040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dihoTniH3pRl9PbbdW6niCVgsskZZJaGMu6Hc6Lku9Z9wkEWZfc2g7Fqe8jIxL3G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1638
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHAI7dnOfq+JW/3witRUSG1AXEk4fpPzYgYTo2FrcuI=;
 b=RAU+cj2ooDcnf7wmDaYgnG3DbDdI7oG/6OWt/Z2fN0ZXAuwk3jHOzwLs3JFzCnAau1w0S7S+kFv6PkU1qYZ+5MLnvWLgYKPCpSJa3ok6zsXEIyvf9l8jCGhs05UhAJ6cNFofHZmnUdOnXSU5sS2A5RYGIjyqziKJPabgXC5KLII=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
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
Message-ID: <20191031152501.1jjieOUmBIWh8x7N2AexgfBACU0fvrjjCu4ZjFrhC1g@z>

UmV2aWV3ZWQtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+DQoNCk9uIDIwMTktMTAt
MzEgMTA6NDMgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPiBJdCdzIHNhZmUgdG8gZW5hYmxl
IGR5bmFtaWMgVkNOIHBvd2VyZ2F0aW5nIG9uIHJhdmVuIGFuZA0KPiByYXZlbjIgZm9yIGluY3Jl
YXNlZCBwb3dlciBzYXZpbmdzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzE1LmMgfCA4ICsrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
DQo+IGluZGV4IDdjN2U5ZjU1MGMwMi4uYmE0NTg4ZTBjMDgyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMNCj4gQEAgLTExMDUsNyArMTEwNSw5IEBAIHN0YXRpYyBpbnQgc29j
MTVfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQ0KPiAgIAkJCQlBTURfQ0dfU1VQUE9S
VF9TRE1BX0xTIHwNCj4gICAJCQkJQU1EX0NHX1NVUFBPUlRfVkNOX01HQ0c7DQo+ICAgDQo+IC0J
CQlhZGV2LT5wZ19mbGFncyA9IEFNRF9QR19TVVBQT1JUX1NETUEgfCBBTURfUEdfU1VQUE9SVF9W
Q047DQo+ICsJCQlhZGV2LT5wZ19mbGFncyA9IEFNRF9QR19TVVBQT1JUX1NETUEgfA0KPiArCQkJ
CUFNRF9QR19TVVBQT1JUX1ZDTiB8DQo+ICsJCQkJQU1EX1BHX1NVUFBPUlRfVkNOX0RQRzsNCj4g
ICAJCX0gZWxzZSBpZiAoYWRldi0+cGRldi0+ZGV2aWNlID09IDB4MTVkOCkgew0KPiAgIAkJCWFk
ZXYtPmNnX2ZsYWdzID0gQU1EX0NHX1NVUFBPUlRfR0ZYX01HQ0cgfA0KPiAgIAkJCQlBTURfQ0df
U1VQUE9SVF9HRlhfTUdMUyB8DQo+IEBAIC0xMTQ4LDcgKzExNTAsOSBAQCBzdGF0aWMgaW50IHNv
YzE1X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gICAJCQkJQU1EX0NHX1NVUFBP
UlRfU0RNQV9MUyB8DQo+ICAgCQkJCUFNRF9DR19TVVBQT1JUX1ZDTl9NR0NHOw0KPiAgIA0KPiAt
CQkJYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdfU1VQUE9SVF9TRE1BIHwgQU1EX1BHX1NVUFBPUlRf
VkNOOw0KPiArCQkJYWRldi0+cGdfZmxhZ3MgPSBBTURfUEdfU1VQUE9SVF9TRE1BIHwNCj4gKwkJ
CQlBTURfUEdfU1VQUE9SVF9WQ04gfA0KPiArCQkJCUFNRF9QR19TVVBQT1JUX1ZDTl9EUEc7DQo+
ICAgCQl9DQo+ICAgCQlicmVhazsNCj4gICAJY2FzZSBDSElQX0FSQ1RVUlVTOg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
