Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C20C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4B620773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 14:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QwVccyjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4B620773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3216E916;
	Wed,  2 Sep 2020 14:27:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06CE6E916
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 14:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtuAg/pP6HFu9B58dVPRnrBM3u/D/06wZp+vnTcI3w2yGCXHQflDBWZJ7lphXR4tgFoNr9Akb42aeVl0m2WaX+/Gqzww3x/YrjWIcW1mewrqB3/Qa7lp+D1RE7tQSIXhN+KUyXi9aFE+5cXBpQ6vuADN7lH6AbDo37RPhOoRhnZBFqgcTEcuWQf9CcnHFY594B1V7UOhvEwS5oVALzS240g9h7hIHeWQJABpaExXWPyi7pi78eIGKW4AWObq1rv5ULwAaRKMIA8zHZ9ySXJ+oOhDlNArqmSfD0pBcUb3SJGE6lMgLlnfRwBT/ruHiJ2nHinC7QQMiFJBJrPGX1r0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjRF7hD13lW3JY7wQVnyUW12KOT1/xWv0thE5tSZABo=;
 b=Hc3nYPc32ykIsKOV3tM70GyzX5dJdFAawMA8LKEr6miH0+1Qytz8uwY5qXaEzvqfxBWnItDJjfTAAsepxW3+PlLHJayQfZjyDyz8TlXkssBHyiuo9BGOssmXzhRJp6nRE5Os8F7rcsdod672hCzna9wYQcT/U7bi76MtCLQmkzXM6tXYZfDVoOjWKFkX3MZgnloyQAZqKu0wMkRlcZXozw9a0Og8GVBGJ1rdpHA99dbVoez/9TI2UpOAaow5V1n1ZjFKo2iV5mZbPj45qg9SnAnircIiQAKthMvrKyJTyyEdLNl5H18+f/vzTFF19jficPAeIc8ePREvMuZhRSORJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjRF7hD13lW3JY7wQVnyUW12KOT1/xWv0thE5tSZABo=;
 b=QwVccyjldutCZJ7YDc9V07oY+KXlkMcIF47Q/Z2Hu9QeJQ9Rwh8ueuMZdQ/145jDtKMzxDo/O8LPvI6XPgJh00+3P1RcxR1dFtVpHjt/sEjZ54ykeu13shWM0SXMvw+Gu1p34uX+wuImzpjUTDzEburctxob+PFGojYukf0Xj98=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2463.namprd12.prod.outlook.com (2603:10b6:802:22::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 14:27:04 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:27:04 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix max_entries calculation v2
Thread-Topic: [PATCH] drm/amdgpu: fix max_entries calculation v2
Thread-Index: AQHWgTIXDYvSlzx81kCL6VB9kFKcI6lVZ9sA
Date: Wed, 2 Sep 2020 14:27:04 +0000
Message-ID: <32A985F3-1C3B-45E4-B90F-7C023CCE7B71@amd.com>
References: <20200902140512.2343-1-christian.koenig@amd.com>
In-Reply-To: <20200902140512.2343-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ceae310-d10f-42d8-088d-08d84f4c43b6
x-ms-traffictypediagnostic: SN1PR12MB2463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2463C781D1D0D38F348752CE872F0@SN1PR12MB2463.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKxf2RtzY6sJCLK7cCfGRiCKEp80LGJX8xJtgmF3VnG9nMlIaWyJMukmmmW4ImKPvJdoEQB2Oi7VKKMrgF41TmLOFIpq5MbJChy2YrbBp06A9C6W1a2uNUvdkncrKw6MvHGBXLPSdDzOhTBtmcxpny8pGT7p9heYqv78B/8zYHZ1rk6Q3jUBfXtWXB8YHqtCbr8vD+evj8Fue8lXddF/Md5uW/yNn/P1B7k/6ZhBVrpweAM+cAULEeE4n3lBM/js42pgiUma1qudoTEy9VSlcJsmjn753JMXq4A8DaNQEiTB/JRJKkgq9jyhsOVAKXsAy3+sXDnGA0ZZyv+10lf4yg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(66574015)(66476007)(478600001)(8676002)(36756003)(66946007)(76116006)(8936002)(186003)(5660300002)(316002)(26005)(83380400001)(66446008)(66556008)(64756008)(6506007)(86362001)(91956017)(4326008)(54906003)(33656002)(6512007)(6486002)(2616005)(2906002)(71200400001)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vi20zIV8/CyBgOFCrL2tuUQsnCylB/WhoGJXm8sU0dD+f2sJcRKehmgBatYFAtV+KZhnCZQ1RQ41uJusWKMPDSnkURFDCNYsUgzwpwdeOl8p4cDW4DnwPHNhcFp/C5Lkznxnvy0BPH1WyEyp13hd7aRaWPAlnktAR5fb1tQTru4S2tMvOJ9r4QILXbF0V1+2TXeOy9Ow0VfOIz2kjraKe7rwewJRUf3FUurthXUzWagZtYoCwzMpI6t9wLacx1xnJB/PVRWOiYafTMESdI+eJ1ZA2iBMGpxbSMUyPCWRX1wHGeml3gitTpSnaUakGdzyd2G07TwFFrYLY/ofonFVzkGaHZxGIyE/PvTQ/QqCqODKTofM2pzGhp/Y9ElN0UmMssmzkmf83xm5S4UYIhNQccHdHSbj9ZpInYfQLs4s7WKiGOL6xipMrKTk38r1JlpFmzaj8D5r9gemLbt7unMKhB8jg/aOj38kinXaz9PGZbOW0OO7BVcBNJIozzWq4SWVX1cfVBtdD2I8EHztI/5SwKB3CnOfRud9qRapXEcXj/n7y7lcniXDzKYrGltb0kBTb3AlsDb+Z2mEEjt0BHIz1QZW1J99x4BkmxVql9LGm+vfIupv4HoFVYDYxE9LX/dSZ6cZ9w0WKxN6S8zy19lEvA==
Content-ID: <42AFAD7731066B42944BEBD75E9FF810@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceae310-d10f-42d8-088d-08d84f4c43b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 14:27:04.4067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLVMB4QRhqg4p6Co0/BlJHBfbZ1gCGQt5PKG01q9SrMrvCqpPQyyJ/W9QPR6Oyqy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2463
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gMjAyMOW5tDnmnIgy5pelIDIyOjA177yMQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IOWGmemBk++8mg0KPiANCj4gQ2FsY3VsYXRlIHRoZSBj
b3JyZWN0IHZhbHVlIGZvciBtYXhfZW50cmllcyBvciB3ZSBtaWdodCBydW4gYWZ0ZXIgdGhlDQo+
IHBhZ2VfYWRkcmVzcyBhcnJheS4NCj4gDQo+IHYyOiBYaW5odWkgcG9pbnRlZCBvdXQgd2UgZG9u
J3QgbmVlZCB0aGUgc2hpZnQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gRml4ZXM6IDFlNjkxZTI0NDQ4NyBkcm0vYW1k
Z3B1OiBzdG9wIGFsbG9jYXRpbmcgZHVtbXkgR1RUIG5vZGVzDQo+IC0tLQ0KPiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYw0KPiBpbmRleCA4YmMyMjUzOTM5YmUuLmJlODg2YmRjYTVjNiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gQEAgLTE2OTcsNyArMTY5
Nyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3NwbGl0X21hcHBpbmcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsDQo+IAkJCQlBTURHUFVfR1BVX1BBR0VTX0lOX0NQVV9QQUdFOw0KPiAJ
CX0gZWxzZSB7DQo+IAkJCWFkZHIgPSAwOw0KPiAtCQkJbWF4X2VudHJpZXMgPSBTNjRfTUFYOw0K
PiArCQkJbWF4X2VudHJpZXMgPSBtYXBwaW5nLT5sYXN0IC0gbWFwcGluZy0+c3RhcnQgKyAxOw0K
DQpZb3UgbmVlZCBtaW51cyBwZm4gaGVyZS4NCg0KVGhlIHJhbmdlIHdlIGFyZSBnb2luZyB0byB0
b3VjaCBpcyBbc3RhcnQgKyBvZmZzZXQsIGxhc3RdLg0Kc28gdGhlIG1heF9lbnRyaWVzIGlzIGxh
c3QgLSAoc3RhcnQgKyBvZmZzZXQpICsgMS4gYW5kIG9mZnNldCBpcyBwZm4gaW4gdGhpcyBjYXNl
Lg0KDQpJIHN0aWxsIGhpdCBwYW5pYyB3aXRoIHRoaXMgcGF0Y2ggaW4gcHJhY3RpY2UuDQoNCj4g
CQl9DQo+IA0KPiAJCWlmIChwYWdlc19hZGRyKSB7DQo+IC0tIA0KPiAyLjE3LjENCj4gDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
