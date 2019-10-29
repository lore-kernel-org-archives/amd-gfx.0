Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B180FCA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 13:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D9D20578
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 13:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D9D20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9EA6E32C;
	Tue, 29 Oct 2019 13:24:01 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720055.outbound.protection.outlook.com [40.107.72.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A54BA6E32C
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 13:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDJtD+/RLmlKArocNv4IZEQ17ywpg4gt4gakCHWRT1zrMs3qHbFUNZtGJvaTSeWS3+TColbNKNx0LgWevcvv66f6ZgP/gt1gEl/fD2bDwWtwcNfM+XC1fp2dJBzl5gKzpw2Z7MBKIMifkEW3L/wIOSpFsCGm99qesdjWK/cYMhOHirRvTm7PXxNA97KkUeW1wrDTYDFqkvIq0ulyXzWMgs8nxOu3Mq63W7CTvhYm0rMtmq5WpTe3NX190v1SLS6t/8UeMmAesSJK2Pvj9TZvgXuA+tPQ9qQ5uymZ0rfWF9ocFe+AVDYfnXqtd8Ps0vQv6wZs5K7dE9Aj+ROJ52G89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD02mmh1x7VcV74gBK9B1nMqGLCfgyCQtn2gsKl0zhU=;
 b=jvIvVPkmLmsdrJthe4v75yuuxMoKdWulsWBitGSdvSaiJEK6ptQ+4/WGGmcSRaJfT7hriOyuSclXbENQqAvM9EhaLvYFSEkJxf35tvB/FfjOIOwqmsXh4CD+jfoKj7hvXvpy3rCRiPAOyc4k/o88JpHwYngbuIzIyx62VoBg3QXbZlWjRskB1x8uPoysGW+j58FWudhrRciLB6eByCrVLlmymNUqQ8n4PCTnsSJRDlCJtx5Hu3FuUVVCUVyIqdNvlfr45y/F/bq6KSpW9gB7uWzBGReeHoQiiFrR/m0QrJ9UrB5NMkXGAAsOTdm6BQWBpQoznA+AkrxMxBnevNbGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1818.namprd12.prod.outlook.com (10.175.92.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 13:23:54 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::8d94:e2f0:4b0e:737f%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 13:23:54 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include
Thread-Topic: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include
Thread-Index: AQHVjlZr/2tYTxHfYE6Zalz6R+G5Xadxm3bQ
Date: Tue, 29 Oct 2019 13:23:54 +0000
Message-ID:
 <DM5PR12MB1418F3A77FC3C0B54C294578FC610@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1572352976-22963-1-git-send-email-le.ma@amd.com>
In-Reply-To: <1572352976-22963-1-git-send-email-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5111ec9e-8a27-4f61-c5a2-08d75c733f22
x-ms-traffictypediagnostic: DM5PR12MB1818:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1818878A16B0A2102B6D1396FC610@DM5PR12MB1818.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(13464003)(186003)(71190400001)(2501003)(256004)(102836004)(966005)(99286004)(74316002)(66066001)(71200400001)(4326008)(446003)(11346002)(2906002)(6246003)(6506007)(53546011)(110136005)(54906003)(3846002)(6116002)(478600001)(316002)(476003)(25786009)(33656002)(86362001)(6436002)(66446008)(66556008)(66476007)(64756008)(486006)(76176011)(7696005)(52536014)(7736002)(229853002)(81156014)(14454004)(5660300002)(66946007)(9686003)(6306002)(8936002)(76116006)(305945005)(8676002)(55016002)(26005)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1818;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0o1lgu6Sc659csUyI2sfG6ih39VLf+a9/4rLEKqydDBcbs4AHRpjfDl+Px/LokJ6azLrpZKIxdSDz2SbFe+ONwm+6XdaWnuVTt9CHfbHU7kVdquX7qK9haUwhAWhd5jqtUY43+ocfsi+f/AN8m6vqspkhFh5sPxaLz7D7Qy8+XRzFZRbuQAMhRY/xwJ1vhhCDunk3/v2K+h6wXQSqbTF5O8dyHySBHXWmUwEzs+2HA7N3w5jDBjn1AdMktjE6zn4sfCDY04qQRJB3bGlSM7WzGN0NjGPhlhLaj/3RcoIyUJVQyhFxVg+go6KopCk7Xj1ADkaxAWEzy3xiWaXuqdefnL1+At4iWgbHVJHi++ZbJN5okyTLWNH/5l+i7umAfDga3nE2uWtzkt9VNjBuHKoFWR0qqLr2Gu+5urX8Es7SI6JXaZ2bU/2x62kVQ8+ztIFtNfgdB/CAKbvPYqOR85xLDslaI0sVksjLVGdjWPWno=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5111ec9e-8a27-4f61-c5a2-08d75c733f22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:23:54.4733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BS6pHeBR11OqxDtnFPsTslVEcwq5IxZ+hzywsLfvtvezFCRaevYJBA30tB+SxcBPsTBN9qaF7ykyRr8Po2Kjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD02mmh1x7VcV74gBK9B1nMqGLCfgyCQtn2gsKl0zhU=;
 b=Mf8cM4aD2rkRfMjnyWCu/2jI3t0JblD7ocMcu6JPBOt42cSxkoiNvylWF4Df9wrTGvBgPGFog6E9MHFGA62rE835VXzBvkdctqYdUpKmPuD4z3B4nmcnuC9bm5RCISog6JJ+g9TP/oTyIYRCl2oLpAZJnkdNmiDBHxMCsazTaZY=
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029132354.thH0EvgqAdRTgWYvSqwn5mnCLiLs3uVucC_ILYSkNk0@z>

UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KUmVn
YXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGUg
TWENClNlbnQ6IDIwMTnlubQxMOaciDI55pelIDIwOjQzDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCkNjOiBTdERlbmlzLCBUb20gPFRvbS5TdERlbmlzQGFtZC5jb20+OyBNYSwg
TGUgPExlLk1hQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMS8xXSBkcm0vYW1kZ3B1OiBhZGQg
bWlzc2luZyBhbWRncHVfcmFzLmggaGVhZGVyIGluY2x1ZGUNCg0KRml4IGNvbXBpbGF0aW9uIGVy
cm9yLg0KDQpDaGFuZ2UtSWQ6IEk0NjFjNTU4Nzc4ZjlhNTIzNzgyNjkzMjRkYzQxYjhkNjM5ZjNj
Y2JlDQpTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMN
CmluZGV4IGZjZTIwNmYuLmJiZTlhYzcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYw0KQEAgLTM0LDYgKzM0LDggQEANCiAjaW5jbHVkZSAicHNwX3YxMV8wLmgiDQog
I2luY2x1ZGUgInBzcF92MTJfMC5oIg0KIA0KKyNpbmNsdWRlICJhbWRncHVfcmFzLmgiDQorDQog
c3RhdGljIHZvaWQgcHNwX3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQog
DQogc3RhdGljIGludCBwc3BfZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpDQotLSANCjIuNy40DQoN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4
IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
