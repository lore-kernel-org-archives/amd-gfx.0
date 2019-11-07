Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91B5C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 13:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DBD2178F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 13:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DBD2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488C26E132;
	Thu,  7 Nov 2019 13:29:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC686E132
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 13:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIBM43GObYMnoJbxSc7qE3KK0xHLYlJ15HstXjoaOQ6mCowhq23yDSIReoLzpX5NV1u6SLAnd3K2FyY7Q8cL4w9rK89ohbDV3O3sr2A4pWnJVQAMJ3CzBSYYPGITfzXzJjKrk8q7L1sFBv2FxP2T0gWKkjFepECsrBCSWOU1MGNlaVnMYJeaQUW2Hu0VPF5OXpTxgllI0CNtDhjtUxHDUb6ZLNCahqGD81TEJcGPqGTuxKBn7urcO1AleoMQgeAGpDjAnenHyos3Q8RpOuQXxwwswz0Qwtj5NfO5ZAkUjvjqdRBeTQ36gusVNJZKvDxRsYPuBCt+B2l35l2/nFCOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV8u1Xm1maufhbB8ebLO1UnAAJCRV8hyx4DM/JewL5Q=;
 b=kp86v0L+fu7YCrfDT7CcQ8o2tj5KBGlewm9inwNIfHchskNUcrOKwL+OwQp2a0t/XYfkGPTZEoWF/yJ0rKKmUc9A0xZyn1gwT4dlSuj58afVTpicNDqmYTrvQO6R/G89m+/2s25+6/iS/BjIM3+dss2G/zGb9Q5I2Wc7gzlAODTz1WI+O582AcNBo1Lri4rER7HGpa/g6iFRdtGHYhl6lecxeb/lj9VPoKqYBvzqmgnQ4RygTocs6A2QRf1fXcqJP2tshl7iJnAskc1Knl144wjLlDkfqiYj5YbWIt/tFNvYlDsr2nMWQlQ6FeujCMsBdV4lE8RlED7uldMHJVTmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2504.namprd12.prod.outlook.com (52.132.141.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Thu, 7 Nov 2019 13:29:09 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f%5]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 13:29:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: disable ds and ulv for compute
Thread-Topic: [PATCH] drm/amd/powerplay: disable ds and ulv for compute
Thread-Index: AQHVlUmzQNEZaKQryk2TPg13GXnNlad/r1Yw
Date: Thu, 7 Nov 2019 13:29:09 +0000
Message-ID:
 <DM5PR12MB1418123E75F4CF79D7F93C2AFC780@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1573117167-25742-1-git-send-email-kenneth.feng@amd.com>
In-Reply-To: <1573117167-25742-1-git-send-email-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d71040a-2ff9-4630-3288-08d763867867
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2504F089BD0D5E67CB96503BFC780@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(13464003)(199004)(189003)(7736002)(7696005)(446003)(25786009)(8936002)(33656002)(8676002)(81156014)(9686003)(6306002)(86362001)(81166006)(55016002)(66946007)(6116002)(66476007)(66446008)(64756008)(66556008)(3846002)(53546011)(26005)(102836004)(110136005)(76176011)(76116006)(186003)(99286004)(316002)(6506007)(486006)(11346002)(476003)(6436002)(2906002)(966005)(4326008)(2501003)(5660300002)(6246003)(71190400001)(71200400001)(14454004)(52536014)(478600001)(229853002)(14444005)(66066001)(74316002)(305945005)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2504;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DECte5CuxsyrYSRTCYlolpPRXU5S2iTZgRtmuuVKFwk1wlNqaJFP0KxKq6Vxf8vIxWGXc6eePjUf+TpajgwwnMsQ293fY+JCzNo+CK2dox9ocLbVJO92v1Y6ulFPVuopM5Lh3qEydlgLxvkg2jTEhu2RXUNP5sezZ5aLmD1rR2JYO2fuY6OJHnB0gwMHebdK0bmEMTRNxaihclB50rQ5fk6G+G/Rn7g/ozdJVPWO1bmyWbbAE/Jc3+Eq+WtFYHlkVueiRlzmPqaqMMwGcaOXzh1H1Zzqui1NrA0ALCedFkdkMc886LIfWyGjMOVvBo1a5/06+Ojy/c/Z0QKCmGNpdnnrMyptWcJmTMw7cURUtOQHPLzvdEnnTJAh/SZKY6Z2bErhbtgTTYTowt48n4OlOzXqOlA9nk09q54Niq/znqG2vZcSOVCUdV1CZ0fkJ0I0YEmSV28Qx7AoU/rV5whK9Iy9/+aFRCdfEvanEa6bURY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d71040a-2ff9-4630-3288-08d763867867
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 13:29:09.1181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrOQ3h0FxUzpqd9rmmGMDNmjZw7IT8OuYbyCK9TVjZ9QLEtQPNXGhReDGJ4olpPWtC0hBOST1qPmHDuZFxd9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UV8u1Xm1maufhbB8ebLO1UnAAJCRV8hyx4DM/JewL5Q=;
 b=DksTLkGnovcA9WKmEv1u1bIwut0z/HIumdklwpAIODt2zNNUZg8zlY2yk6YS6IQ84bocQiVqFpZzuN2GwXcSIPcowS/vh4t/kz02L+N77NDyWz79cd1HEU1/Egcq5ZTU1dZ+dpScygVr2dp63fqDFt2kacNUmjcNCV+aC/5rxeY=
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107132909.rTw2SAIJomlkrK3Nz26YkdqlFHuMMr7Vsfm0jzP8mec@z>

SGkgS2VubmV0aCwNCg0KSSBkb24ndCB0aGluayB0aGVyZSBpcyBzZXF1ZW5jZSBkZXBlbmRlbmN5
IGJldHdlZW4gZGlzYWJsaW5nIHBvd2VyIGZlYXR1cmUgYW5kIHNldHRpbmcgc3BlY2lmaWMgd29y
a2xvYWQsIGNvcnJlY3Q/IElmIHNvLCB3ZSBjYW4gbW92ZSB0aGUgZW5hYmxpbmcvZGlzYWJsaW5n
IHBvd2VyIGZlYXR1cmUgbG9naWMgb3V0IG9mIHRoZSAib3V0IiBnb3RvIHRhZy4NCg0KU2Vjb25k
bHksIEl0IHNlZW1zIHRvIG1lIHRoZSBuZXcgbG9naWNhbCB3aWxsIHJlc3VsdCB0byBkdXBsaWNh
dGUgcG93ZXIgZmVhdHVyZXMgZW5hYmxlbWVudCBpZiBwcm9maWxlIG1vZGUgaXMgbm90IFBST0ZJ
TEVfQ09NUFVURSwgd2lsbCB0aGF0IGFueSBzaWRlIGVmZmVjdD8NCg0KU2luY2UgS0ZEIGhhcyBh
IGZsYWcgdG8gaW5kaWNhdGUgZW50ZXIvZXhpdCBQUk9GSUxFX0NPTVBVVEUgbW9kZSBpbiBhbWRn
cHVfYW1ka2ZkX3NldF9jb21wdXRlX2lkbGUsIHdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gYXBwbHkg
cG93ZXIgZmVhdHVyZSBkaXNhYmxlbWVudCBpbiBwcF9kcG1fc3dpdGNoX3Bvd2VyX3Byb2ZpbGU/
IG9mIGNvdXJzZSwgd2UgbmVlZCB0byBjcmVhdGUgYSBjYWxsIGJhY2sgZnVuY3Rpb24gbGlrZSBw
cF9kcG1fZGlzYWJsZV9wb3dlcl9mZWF0dXJlX2Zvcl9jb21wdXRlX3BlcmZvcm1jZSAoYW5kIGFs
c28gdGhlIGVxdWl2YWxlbnQgb25lIGZvciB0aGUgbmV3IHNtdSBkcml2ZXIpLg0KDQpMZXQgbWUg
a25vdyB5b3VyIGluc2lnaHRzIG9uIHRoZXNlLiBUaGFua3MuDQoNClJlZ2FyZHMsDQpIYXdraW5n
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3Vu
Y2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEtlbm5ldGggRmVuZw0KU2Vu
dDogMjAxOeW5tDEx5pyIN+aXpSAxNjo1OQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQpDYzogRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQpTdWJqZWN0OiBb
UEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5OiBkaXNhYmxlIGRzIGFuZCB1bHYgZm9yIGNvbXB1dGUN
Cg0KVGhpcyBpcyB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBpbiB0aGUgY29tcHV0ZSBtb2Rl
IGZvciB2ZWdhMTAuIEZvciBleGFtcGxlLCB0aGUgb3JpZ2luYWwgcGVyZm9ybWFuY2UgZm9yIGEg
cm9jbSBiYW5kd2lkdGggdGVzdDogMkcgaW50ZXJuYWwgR1BVIGNvcHksIGlzIGFib3V0IDk5R0Iv
cy4NCldpdGggdGhlIGlkbGUgcG93ZXIgZmVhdHVyZXMgZGlzYWJsZWQgZHluYW1pY2FsbHksIHRo
ZSBwb3Jmb3JtYW5jZSBpcyBwcm9tb3RlZCB0byBhYm91dCAyMTVHQi9zLg0KDQpTaWduZWQtb2Zm
LWJ5OiBLZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMgfCA2MiArKysrKysrKysr
KysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdy
L3ZlZ2ExMF9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVn
YTEwX2h3bWdyLmMNCmluZGV4IDRlYTYzYTIuLmMwZGJiMjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYw0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMNCkBAIC00OTQwLDYg
KzQ5NDAsNTkgQEAgc3RhdGljIGludCB2ZWdhMTBfZ2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1
Y3QgcHBfaHdtZ3IgKmh3bWdyLCBjaGFyICpidWYpDQogCXJldHVybiBzaXplOw0KIH0NCiANCitz
dGF0aWMgaW50IHZlZ2ExMF9kaXNhYmxlX3Bvd2VyX2ZlYXR1cmVzX2Zvcl9jb21wdXRlX3BlcmZv
cm1hbmNlKHN0cnVjdCANCitwcF9od21nciAqaHdtZ3IsIGJvb2wgZGlzYWJsZSkgew0KKwlzdHJ1
Y3QgdmVnYTEwX2h3bWdyICpkYXRhID0gaHdtZ3ItPmJhY2tlbmQ7DQorCXVpbnQzMl90IGZlYXR1
cmVfbWFzayA9IDA7DQorDQorCWlmIChkaXNhYmxlKSB7DQorCQlmZWF0dXJlX21hc2sgfD0gZGF0
YS0+c211X2ZlYXR1cmVzW0dOTERfVUxWXS5lbmFibGVkID8NCisJCQlkYXRhLT5zbXVfZmVhdHVy
ZXNbR05MRF9VTFZdLnNtdV9mZWF0dXJlX2JpdG1hcCA6IDA7DQorCQlmZWF0dXJlX21hc2sgfD0g
ZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5lbmFibGVkID8NCisJCQlkYXRhLT5z
bXVfZmVhdHVyZXNbR05MRF9EU19HRlhDTEtdLnNtdV9mZWF0dXJlX2JpdG1hcCA6IDA7DQorCQlm
ZWF0dXJlX21hc2sgfD0gZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfU09DQ0xLXS5lbmFibGVk
ID8NCisJCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19TT0NDTEtdLnNtdV9mZWF0dXJlX2Jp
dG1hcCA6IDA7DQorCQlmZWF0dXJlX21hc2sgfD0gZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNf
TENMS10uZW5hYmxlZCA/DQorCQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfTENMS10uc211
X2ZlYXR1cmVfYml0bWFwIDogMDsNCisJCWZlYXR1cmVfbWFzayB8PSBkYXRhLT5zbXVfZmVhdHVy
ZXNbR05MRF9EU19EQ0VGQ0xLXS5lbmFibGVkID8NCisJCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05M
RF9EU19EQ0VGQ0xLXS5zbXVfZmVhdHVyZV9iaXRtYXAgOiAwOw0KKwl9IGVsc2Ugew0KKwkJZmVh
dHVyZV9tYXNrIHw9ICghZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfVUxWXS5lbmFibGVkKSA/DQor
CQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfVUxWXS5zbXVfZmVhdHVyZV9iaXRtYXAgOiAwOw0K
KwkJZmVhdHVyZV9tYXNrIHw9ICghZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5l
bmFibGVkKSA/DQorCQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5zbXVfZmVh
dHVyZV9iaXRtYXAgOiAwOw0KKwkJZmVhdHVyZV9tYXNrIHw9ICghZGF0YS0+c211X2ZlYXR1cmVz
W0dOTERfRFNfU09DQ0xLXS5lbmFibGVkKSA/DQorCQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERf
RFNfU09DQ0xLXS5zbXVfZmVhdHVyZV9iaXRtYXAgOiAwOw0KKwkJZmVhdHVyZV9tYXNrIHw9ICgh
ZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfTENMS10uZW5hYmxlZCkgPw0KKwkJCWRhdGEtPnNt
dV9mZWF0dXJlc1tHTkxEX0RTX0xDTEtdLnNtdV9mZWF0dXJlX2JpdG1hcCA6IDA7DQorCQlmZWF0
dXJlX21hc2sgfD0gKCFkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19EQ0VGQ0xLXS5lbmFibGVk
KSA/DQorCQkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfRENFRkNMS10uc211X2ZlYXR1cmVf
Yml0bWFwIDogMDsNCisJfQ0KKw0KKwlpZiAoZmVhdHVyZV9tYXNrKQ0KKwkJUFBfQVNTRVJUX1dJ
VEhfQ09ERSghdmVnYTEwX2VuYWJsZV9zbWNfZmVhdHVyZXMoaHdtZ3IsDQorCQkJCSFkaXNhYmxl
LCBmZWF0dXJlX21hc2spLA0KKwkJCQkiZW5hYmxlL2Rpc2FibGUgcG93ZXIgZmVhdHVyZXMgZm9y
IGNvbXB1dGUgcGVyZm9ybWFuY2UgRmFpbGVkISIsDQorCQkJCXJldHVybiAtRUlOVkFMKTsNCisN
CisJaWYgKGRpc2FibGUpIHsNCisJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX1VMVl0uZW5hYmxl
ZCA9IGZhbHNlOw0KKwkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfR0ZYQ0xLXS5lbmFibGVk
ID0gZmFsc2U7DQorCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19TT0NDTEtdLmVuYWJsZWQg
PSBmYWxzZTsNCisJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0xDTEtdLmVuYWJsZWQgPSBm
YWxzZTsNCisJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0RDRUZDTEtdLmVuYWJsZWQgPSBm
YWxzZTsNCisJfSBlbHNlIHsNCisJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX1VMVl0uZW5hYmxl
ZCA9IHRydWU7DQorCQlkYXRhLT5zbXVfZmVhdHVyZXNbR05MRF9EU19HRlhDTEtdLmVuYWJsZWQg
PSB0cnVlOw0KKwkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfU09DQ0xLXS5lbmFibGVkID0g
dHJ1ZTsNCisJCWRhdGEtPnNtdV9mZWF0dXJlc1tHTkxEX0RTX0xDTEtdLmVuYWJsZWQgPSB0cnVl
Ow0KKwkJZGF0YS0+c211X2ZlYXR1cmVzW0dOTERfRFNfRENFRkNMS10uZW5hYmxlZCA9IHRydWU7
DQorCX0NCisNCisJcmV0dXJuIDA7DQorDQorfQ0KKw0KIHN0YXRpYyBpbnQgdmVnYTEwX3NldF9w
b3dlcl9wcm9maWxlX21vZGUoc3RydWN0IHBwX2h3bWdyICpod21nciwgbG9uZyAqaW5wdXQsIHVp
bnQzMl90IHNpemUpICB7DQogCXN0cnVjdCB2ZWdhMTBfaHdtZ3IgKmRhdGEgPSBod21nci0+YmFj
a2VuZDsgQEAgLTQ5NDgsNiArNTAwMSw3IEBAIHN0YXRpYyBpbnQgdmVnYTEwX3NldF9wb3dlcl9w
cm9maWxlX21vZGUoc3RydWN0IHBwX2h3bWdyICpod21nciwgbG9uZyAqaW5wdXQsIHVpDQogCXVp
bnQ4X3QgdXNlX3JsY19idXN5Ow0KIAl1aW50OF90IG1pbl9hY3RpdmVfbGV2ZWw7DQogCXVpbnQz
Ml90IHBvd2VyX3Byb2ZpbGVfbW9kZSA9IGlucHV0W3NpemVdOw0KKwlpbnQgcmV0ID0gMDsNCiAN
CiAJaWYgKHBvd2VyX3Byb2ZpbGVfbW9kZSA9PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9DVVNUT00p
IHsNCiAJCWlmIChzaXplICE9IDAgJiYgc2l6ZSAhPSA0KQ0KQEAgLTQ5NzUsMTEgKzUwMjksMTcg
QEAgc3RhdGljIGludCB2ZWdhMTBfc2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3QgcHBfaHdt
Z3IgKmh3bWdyLCBsb25nICppbnB1dCwgdWkNCiAJfQ0KIA0KIG91dDoNCisJaWYgKHBvd2VyX3By
b2ZpbGVfbW9kZSA9PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRFKQ0KKwkJcmV0ID0gdmVn
YTEwX2Rpc2FibGVfcG93ZXJfZmVhdHVyZXNfZm9yX2NvbXB1dGVfcGVyZm9ybWFuY2UoaHdtZ3Is
IHRydWUpOw0KKwllbHNlDQorCQlyZXQgPSB2ZWdhMTBfZGlzYWJsZV9wb3dlcl9mZWF0dXJlc19m
b3JfY29tcHV0ZV9wZXJmb3JtYW5jZShod21nciwgDQorZmFsc2UpOw0KKw0KIAlzbXVtX3NlbmRf
bXNnX3RvX3NtY193aXRoX3BhcmFtZXRlcihod21nciwgUFBTTUNfTVNHX1NldFdvcmtsb2FkTWFz
aywNCiAJCQkJCQkxIDw8IHBvd2VyX3Byb2ZpbGVfbW9kZSk7DQorDQogCWh3bWdyLT5wb3dlcl9w
cm9maWxlX21vZGUgPSBwb3dlcl9wcm9maWxlX21vZGU7DQogDQotCXJldHVybiAwOw0KKwlyZXR1
cm4gcmV0Ow0KIH0NCiANCiANCi0tDQoyLjcuNA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
