Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046E3C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D288E2173E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 09:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D288E2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926716F998;
	Fri,  6 Dec 2019 09:45:55 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680075.outbound.protection.outlook.com [40.107.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A640B6F996
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 09:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZbR3gwqDkKzhY7tOCobn7DCEvyJaD4tEAmDcEmQF0cFNsq5ACcQD7Aj2a9xEQb9dGCd0vdJBt7W9avijL/04kWm2fzKAy5aPGKWus8O+UWLUbEdQunk71EBJAMD95eyeWe8yzpfrXDBJjvWp9jK6sofGzg+wC+GwNWGwm8dZ0med0Ofj4s8WZpndiG9eESpV3xoq73+6Tx7krv2131oDQwqlGtNqiwROjrHKFD9nSay2A7dK9ylsRxiNIXIjq5Du8IFjNj7Y4iBTdylL7wIhCM/Qa4qK6tI1Uqd/AocUi4sBEKgasQDgDzjKBVCVEYB1K6Lz3WKgbY7oNhK7uuG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e1QRyGxzXyM+J3A1AYPiI6C6r0XgteMl8A4m7W0ycQ=;
 b=P42H8H9xakV3+dmQDGwI0ohB12DdKhB26P0FUZv57fjHSgpoOTRyfeyBKKtIABLPqF8K+a+mpx2dtUB4V9tWgkt4iwBpuHYTlsDAAPCFRpTLbhAtr1RhFiXtnbyx7r8DFYzaRDhRHMy9/zLYihjwnOTS/Eu6sv4ii7wepI4WuD8J5dIrwSW2A3dgI88SL8KFXJ+ANJvtLLELp7E6x9a8hG93CrdrzcwA+iFXX9l4hBxC5qmzn4lYXFj5fviJV1OecfPieEdar4uES7QBNbFp7tdquFlRY/PGVwsli2NOWLGFTi7p0qGNcCEemy5AiLBBOxHKdXxke2lbUoqzFWotfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1913.namprd12.prod.outlook.com (10.175.88.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Fri, 6 Dec 2019 09:45:51 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2516.017; Fri, 6 Dec 2019
 09:45:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Ma, Le" <Le.Ma@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix resume failures casued by psp fw loading
 sequence change
Thread-Topic: [PATCH] drm/amdgpu: fix resume failures casued by psp fw loading
 sequence change
Thread-Index: AQHVrBOOWYkSYi9XA0+VWO/iZ3X/yqesz/uAgAALqAA=
Date: Fri, 6 Dec 2019 09:45:50 +0000
Message-ID: <DM5PR12MB1418D985E59BEA9FF0ABE90EFC5F0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191206085956.4681-1-Hawking.Zhang@amd.com>
 <BYAPR12MB2806AB591B0CE422AC335694F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2806AB591B0CE422AC335694F15F0@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2019-12-06T09:02:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=88f0c071-02b8-467d-94ab-00008b378025;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9781cfbe-d698-4653-95e3-08d77a31148c
x-ms-traffictypediagnostic: DM5PR12MB1913:|DM5PR12MB1913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB191342637FA63752DBC1ABF5FC5F0@DM5PR12MB1913.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(13464003)(189003)(199004)(11346002)(71190400001)(76176011)(52536014)(14454004)(64756008)(7696005)(66476007)(33656002)(186003)(110136005)(2906002)(26005)(102836004)(53546011)(6506007)(71200400001)(229853002)(9686003)(66946007)(76116006)(81166006)(55016002)(45080400002)(966005)(8936002)(6636002)(66446008)(316002)(86362001)(25786009)(8676002)(99286004)(81156014)(5660300002)(14444005)(478600001)(66556008)(305945005)(74316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1913;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UfKbUsQygCYU0n12fm7UQSVPu49e4qLAzOabyQfmKlR9sJank7yYLOTa6wMZ+yh/v4aHX8GyqGPfQt90uJGUYAJz4NOWlcCA+gefmy3rSJtYkrEgdRg7n8jDh5cfCrNxAE0RFuBm0FsSENaMwbRJUtb8uL1MS2yoPcMwPzTvd5eBmsDPT6hyd2X0bleo+BeeZi8R2t7VCAB+UcV7Det6ttdZDbWny3W8vNFiPF1jOZ1ticb38kfFwae9zjLAZHgJKN1grOupJ8YPeTgxj/zQDu3gN5YU4tNHm93TlW7G0da4hj9J1g3FRs91PBBtTBTRJ7FiX605bIASPuCOvj9A8zDqKMkMBqglSZs0dQwewZGVgdiTpTKE5Bj5wmJ+esUMTz4TAdEKmS0G3WACo/Tgd6nWQ9IHJd5Hj6/2VcvEkr7339Jd0yJK4YFl/cVddrSRlWLNt69JCpewnuzPy6KcoFAq6KH03wkJUWDc6CR1iWaDacrdcyx6W31Zf+j5WKoOVBsrpA7WFZdiIfvKnVoU2mvpBANfBr4DfSMBBHV3uFE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9781cfbe-d698-4653-95e3-08d77a31148c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 09:45:50.7201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7nf0zr6L4kkMJUDd3UcUgeWQS7TPY76SXS4VaYR5I6TaNISLitRCEjj5eVR6xJ/ZUJqs5UieV2/yqG2Y4pioA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1913
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e1QRyGxzXyM+J3A1AYPiI6C6r0XgteMl8A4m7W0ycQ=;
 b=g523ri7MnVAu9jsMwABszJONsRX9nEb2xllZ+SIkBv+orv+WP0PKJJISNgeNNmEFzbvCt+Mt5J8neblb61USZ02KcqMk2gU4/YAdarJigEz0Zmc3cHD9AFX5ZSFxleRMvV2j/pjWYG6Zhs7hFN8TKiu2rclXaZJhFCbM+/GIWX8=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

R29vZCBwb2ludC4gUGxlYXNlIGNoZWNrIHYyLg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1k
LmNvbT4gDQpTZW50OiAyMDE55bm0MTLmnIg25pelIDE3OjA0DQpUbzogWmhhbmcsIEhhd2tpbmcg
PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBN
YSwgTGUgPExlLk1hQGFtZC5jb20+OyBDbGVtZW50cywgSm9obiA8Sm9obi5DbGVtZW50c0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSRTogW1BB
VENIXSBkcm0vYW1kZ3B1OiBmaXggcmVzdW1lIGZhaWx1cmVzIGNhc3VlZCBieSBwc3AgZncgbG9h
ZGluZyBzZXF1ZW5jZSBjaGFuZ2UNCg0KW0FNRCBQdWJsaWMgVXNlXQ0KDQoNCg0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgSGF3a2lu
ZyBaaGFuZw0KU2VudDogRnJpZGF5LCBEZWNlbWJlciA2LCAyMDE5IDU6MDAgUE0NClRvOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTWEsIExlIDxMZS5NYUBhbWQuY29tPjsgQ2xlbWVu
dHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggcmVzdW1lIGZhaWx1
cmVzIGNhc3VlZCBieSBwc3AgZncgbG9hZGluZyBzZXF1ZW5jZSBjaGFuZ2UNCg0KdGhpcyBmaXgg
dGhlIHJlZ3Jlc3Npb24gY2F1c2VkIGJ5IGFzZC90YSBsb2FkaW5nIHNlcXVlbmNlIGFkanVzdG1l
bnQgcmVjZW50bHkuIGFzZC90YSBsb2FkaW5nIHdhcyBtb3ZlIG91dCBmcm9tIGh3X3N0YXJ0IGFu
ZCBzaG91bGQgYWxzbyBiZSBhcHBsaWVkIHRvIHBzcF9yZXN1bWUuIG90aGVyd2lzZSB0aG9zZSBm
dyBsb2FkaW5nIHdpbGwgYmUgaWdub3JlZCBpbiByZXN1bWUgcGhhc2UuDQoNCkNoYW5nZS1JZDog
STU3MDEwYmM3ZGRmNzFhYzQ2ZDNmYjU0NGQyNzkzMjY2NDE5MGNmMDQNClNpZ25lZC1vZmYtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQppbmRleCBjZWVhODMxNGQ4OGQuLjJlZjE2ZDRjNzUyZCAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQpAQCAtMTcwMiw2ICsx
NzAyLDM5IEBAIHN0YXRpYyBpbnQgcHNwX3Jlc3VtZSh2b2lkICpoYW5kbGUpDQogCWlmIChyZXQp
DQogCQlnb3RvIGZhaWxlZDsNCiANCisJcmV0ID0gcHNwX2FzZF9sb2FkKHBzcCk7DQorCWlmIChy
ZXQpIHsNCisJCURSTV9FUlJPUigiUFNQIGxvYWQgYXNkIGZhaWxlZCFcbiIpOw0KKwkJcmV0dXJu
IHJldDsNCltHdWNodW5dIFdlIGNhbid0IGRpcmVjdGx5IHJldHVybiBoZXJlLCBhcyBhdCB0aGUg
ZWFybHkgc3RhZ2Ugb2YgdGhpcyBmdW5jdGlvbiBwc3BfcmVzdW1lLCB3ZSBoYXZlIGVuYWJsZWQg
bG9jay4gV2UgbmVlZCB0byB1c2UgZ290byBmYWlsZWQgdG8gdW5sb2NrLCBsaWtlIG90aGVyIGZh
aWx1cmUgY2FzZS4NCisJfQ0KKw0KKwlpZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25v
ZGVzID4gMSkgew0KKwkJcmV0ID0gcHNwX3hnbWlfaW5pdGlhbGl6ZShwc3ApOw0KKwkJLyogV2Fy
bmluZyB0aGUgWEdNSSBzZWVzaW9uIGluaXRpYWxpemUgZmFpbHVyZQ0KKwkJICogSW5zdGVhZCBv
ZiBzdG9wIGRyaXZlciBpbml0aWFsaXphdGlvbg0KKwkJICovDQorCQlpZiAocmV0KQ0KKwkJCWRl
dl9lcnIocHNwLT5hZGV2LT5kZXYsDQorCQkJCSJYR01JOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBY
R01JIHNlc3Npb25cbiIpOw0KKwl9DQorDQorCWlmIChwc3AtPmFkZXYtPnBzcC50YV9mdykgew0K
KwkJcmV0ID0gcHNwX3Jhc19pbml0aWFsaXplKHBzcCk7DQorCQlpZiAocmV0KQ0KKwkJCWRldl9l
cnIocHNwLT5hZGV2LT5kZXYsDQorCQkJCQkiUkFTOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBSQVNc
biIpOw0KKw0KKwkJcmV0ID0gcHNwX2hkY3BfaW5pdGlhbGl6ZShwc3ApOw0KKwkJaWYgKHJldCkN
CisJCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LA0KKwkJCQkiSERDUDogRmFpbGVkIHRvIGluaXRp
YWxpemUgSERDUFxuIik7DQorDQorCQlyZXQgPSBwc3BfZHRtX2luaXRpYWxpemUocHNwKTsNCisJ
CWlmIChyZXQpDQorCQkJZGV2X2Vycihwc3AtPmFkZXYtPmRldiwNCisJCQkJIkRUTTogRmFpbGVk
IHRvIGluaXRpYWxpemUgRFRNXG4iKTsNCisJfQ0KKw0KIAltdXRleF91bmxvY2soJmFkZXYtPmZp
cm13YXJlLm11dGV4KTsNCiANCiAJcmV0dXJuIDA7DQotLQ0KMi4xNy4xDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlz
dA0KYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNr
dG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3
Q2d1Y2h1bi5jaGVuJTQwYW1kLmNvbSU3Q2I2Y2E2MzgyZGFkMDQyNTlkYjBiMDhkNzdhMmFiODM1
JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzExMjE5NjI1
Nzg4NTgzOSZhbXA7c2RhdGE9SWJ1ZkFWQVM0djc3NEEzN3Zsbm4ySkt2cGpubG1COXJIekclMkZa
eWRkeUxzJTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
