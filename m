Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2686C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 04:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2DE20869
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 04:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2DE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977F46EE82;
	Thu,  7 Nov 2019 04:46:11 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740044.outbound.protection.outlook.com [40.107.74.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0EA6EE82
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 04:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGC8r39lw/dDjY/vNKrChGhPUjkhA0kpZQd5gjj/Ln7/UGp8GExUdbgyEsl5Iyla34oK08H0NZ5K5M9SLyx2cmVA59j9it0kD7wGgidxrz/kXSSCR+Bp1zdspWqZpdlA0sSMZ058vsv+KI/E3fy813weZNTLmle6mB03gGznod8uRxfM926TEuOm2DeEFIM7Co4hP4PUFqVKbhgiw9gPUNIrbBSVMQ7bOEMM2dGW13spaU8r/eZJmEh/Y7n9AvsfFyJcYGOCYg+/ESmBgqFth08qdQ4eyO3yrGZ9z099raW6+juErp9ai2rKPYxPPLUBXXF7ZraZu0BP5aigtUUAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCU1/5pYqwQiDLHXsSYx1oSGVm7mQuMZuXJTw5+okn4=;
 b=LElYLDdfWe2HogAHKjsjD1pwS9GGoUP00o/bPQQ4Jm14/zN+z0ac6OjYFoMaQqaBnwnElG1R1BIKR1NEpAmk6RZ6JFMMWJH/+1YLdgtGc88imwUuSblFpsEiqFKnvZZOrdhH9AAa+sSXx29XkePWf+CMjSQw3ECDGooT1QWuDcvcUZ+YpMJLeIj5Ao7QUX8iX8JapfXoZ46sydcK53j1wGa6zp9En8d/ztJbl2L6AjvcE63FfcJH2uhitmdxph0kp50jEgpywUERZe7vPrP/X/E2sdngd66uGAE3Mnu6+Kt0rw7W3p7ylXZEkR+9qihGEJN51MiqLbpgWZ9RXB7WLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.174.156) by
 DM6PR12MB2745.namprd12.prod.outlook.com (20.176.117.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 04:45:54 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::288c:66ec:203d:aede%4]) with mapi id 15.20.2408.024; Thu, 7 Nov 2019
 04:45:54 +0000
From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/amdkfd: Adjust function sequences to avoid
 unnecessary declarations
Thread-Topic: [PATCH 1/3] drm/amdkfd: Adjust function sequences to avoid
 unnecessary declarations
Thread-Index: AQHVj4CheoGk4fpIk0CN5w2HS0ar8qd/LXMA
Date: Thu, 7 Nov 2019 04:45:53 +0000
Message-ID: <30448b89-c6c2-9cc5-68b2-9ef1fa123f00@amd.com>
References: <20191031001739.10764-1-Yong.Zhao@amd.com>
In-Reply-To: <20191031001739.10764-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-clientproxiedby: YT1PR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::49)
 To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:1cb::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccfc6497-7af7-4d82-c83e-08d7633d5f3d
x-ms-traffictypediagnostic: DM6PR12MB2745:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2745737682DC8A498BB8888E92780@DM6PR12MB2745.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(6246003)(2501003)(86362001)(6486002)(31696002)(2906002)(6436002)(7736002)(305945005)(3846002)(4001150100001)(6116002)(229853002)(36756003)(186003)(26005)(102836004)(25786009)(71200400001)(71190400001)(6512007)(446003)(5660300002)(66556008)(66446008)(64756008)(66946007)(66476007)(99286004)(52116002)(478600001)(53546011)(6506007)(386003)(14454004)(11346002)(76176011)(316002)(58126008)(110136005)(31686004)(14444005)(256004)(2616005)(486006)(81156014)(476003)(8676002)(81166006)(8936002)(65806001)(65956001)(66066001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2745;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1KXJ2VgiUXy/Vt8LCweRvWFGe081LsI/P2SS6oiPADa4BiaiSKaoB+cKY506oiVBmczqNFzvKS7+ClmhtL0NJqgDnugZnFZqk2c+hHqX4CHCr6W6kjjMMb8OLkx0DZCfVlGCewGBrbvpP4wxUKEiGlLCfqYD63zHsZDokkDwWtR+/UJE6cL5w6aFQxIJ3cDH7kA4n5pSPoDvp2QT8Jiz+HLdBqjG/5GMM5fx9Fae8inVGWFWpsgmfAi5tcxvAm2iJhYLQNiG/oAwZT/qYov/2GNDoG7iGJm/XNx3oZEy2zLoJ9ZbdQkqEzQqdteqrr8iCQhMCBLqk39FG7jJ55+pN2eF7LfCgRtR9GaYhR90hF5/Zz6AzTD6Z8zB5iVFPyS8Alf0TGAJLR7zUhcx8ioWVnVS5MYcj5ReTLnx+K7Isj1pPLKmHfccRQxmTPYDswKw
Content-ID: <1EF09C3CB548824B87958F9AE311058C@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfc6497-7af7-4d82-c83e-08d7633d5f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 04:45:53.9783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKDcM9d1TrGi9KFQZovfT637RYtW2wI6pIxlyDCOBKU9jpTpErU2LJkQdkAiV1ggKV8q2rMbKFeVve8pmg/M5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2745
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCU1/5pYqwQiDLHXsSYx1oSGVm7mQuMZuXJTw5+okn4=;
 b=zD21WVx5nPVJ8BPqV57Dcrj3KDQUhqege1M4II6OnZ9wwkewwCVX6YAoDm7KADXWRwrLnxXHtuj+gD/guYZHJimgtEUWb/g9A2mZ7OpXzAmsSmBsA7jKqO/uQymiZb+hg3af5hhYLc1wj2PinoP46nTfcSeL4e54CuyMcD4XS2k=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Message-ID: <20191107044553.lCTgqZq2XOp7KvKWldIcMkoMq-uP0oLsvQ1f2jhpNl4@z>

T24gMjAxOS0xMC0zMCAyMDoxNywgWmhhbywgWW9uZyB3cm90ZToNCj4gVGhpcyBpcyBjbGVhbmVy
Lg0KPg0KPiBDaGFuZ2UtSWQ6IEk4Y2RlY2FkMzg3ZDhjNTQ3YTA4OGM2MDUwZjc3Mzg1ZWUxMTM1
YmUxDQo+IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+DQpSZXZp
ZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IC0tLQ0K
PiAgIC4uLi9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92OS5jICB8IDE5ICsr
KysrKystLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9rZXJuZWxfcXVldWVfdjkuYw0KPiBpbmRleCA5YTRiYWZiMmUxNzUuLjNiNWNhMmIxZDdhNiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1
ZV92OS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVl
dWVfdjkuYw0KPiBAQCAtMjYsMTggKzI2LDYgQEANCj4gICAjaW5jbHVkZSAia2ZkX3BtNF9oZWFk
ZXJzX2FpLmgiDQo+ICAgI2luY2x1ZGUgImtmZF9wbTRfb3Bjb2Rlcy5oIg0KPiAgIA0KPiAtc3Rh
dGljIGJvb2wgaW5pdGlhbGl6ZV92OShzdHJ1Y3Qga2VybmVsX3F1ZXVlICprcSwgc3RydWN0IGtm
ZF9kZXYgKmRldiwNCj4gLQkJCWVudW0ga2ZkX3F1ZXVlX3R5cGUgdHlwZSwgdW5zaWduZWQgaW50
IHF1ZXVlX3NpemUpOw0KPiAtc3RhdGljIHZvaWQgdW5pbml0aWFsaXplX3Y5KHN0cnVjdCBrZXJu
ZWxfcXVldWUgKmtxKTsNCj4gLXN0YXRpYyB2b2lkIHN1Ym1pdF9wYWNrZXRfdjkoc3RydWN0IGtl
cm5lbF9xdWV1ZSAqa3EpOw0KPiAtDQo+IC12b2lkIGtlcm5lbF9xdWV1ZV9pbml0X3Y5KHN0cnVj
dCBrZXJuZWxfcXVldWVfb3BzICpvcHMpDQo+IC17DQo+IC0Jb3BzLT5pbml0aWFsaXplID0gaW5p
dGlhbGl6ZV92OTsNCj4gLQlvcHMtPnVuaW5pdGlhbGl6ZSA9IHVuaW5pdGlhbGl6ZV92OTsNCj4g
LQlvcHMtPnN1Ym1pdF9wYWNrZXQgPSBzdWJtaXRfcGFja2V0X3Y5Ow0KPiAtfQ0KPiAtDQo+ICAg
c3RhdGljIGJvb2wgaW5pdGlhbGl6ZV92OShzdHJ1Y3Qga2VybmVsX3F1ZXVlICprcSwgc3RydWN0
IGtmZF9kZXYgKmRldiwNCj4gICAJCQllbnVtIGtmZF9xdWV1ZV90eXBlIHR5cGUsIHVuc2lnbmVk
IGludCBxdWV1ZV9zaXplKQ0KPiAgIHsNCj4gQEAgLTY3LDYgKzU1LDEzIEBAIHN0YXRpYyB2b2lk
IHN1Ym1pdF9wYWNrZXRfdjkoc3RydWN0IGtlcm5lbF9xdWV1ZSAqa3EpDQo+ICAgCQkJCWtxLT5w
ZW5kaW5nX3dwdHI2NCk7DQo+ICAgfQ0KPiAgIA0KPiArdm9pZCBrZXJuZWxfcXVldWVfaW5pdF92
OShzdHJ1Y3Qga2VybmVsX3F1ZXVlX29wcyAqb3BzKQ0KPiArew0KPiArCW9wcy0+aW5pdGlhbGl6
ZSA9IGluaXRpYWxpemVfdjk7DQo+ICsJb3BzLT51bmluaXRpYWxpemUgPSB1bmluaXRpYWxpemVf
djk7DQo+ICsJb3BzLT5zdWJtaXRfcGFja2V0ID0gc3VibWl0X3BhY2tldF92OTsNCj4gK30NCj4g
Kw0KPiAgIHN0YXRpYyBpbnQgcG1fbWFwX3Byb2Nlc3Nfdjkoc3RydWN0IHBhY2tldF9tYW5hZ2Vy
ICpwbSwNCj4gICAJCXVpbnQzMl90ICpidWZmZXIsIHN0cnVjdCBxY21fcHJvY2Vzc19kZXZpY2Ug
KnFwZCkNCj4gICB7DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
