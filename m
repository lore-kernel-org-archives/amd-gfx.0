Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0C8C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1D52071A
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bnyZcI18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1D52071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654056E2DD;
	Tue, 31 Mar 2020 14:40:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0A06E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 14:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FonZHoH+bmRn6Sc8+W1VUS9mf9Xuw4UM3F9UOzZ3q3DNzG/n5ejCp1HcyhxH70IfF3DjHyBwjqUnWrzROy3iM5QLgn9ZEVeLmz9WVapT5XuCKFb2NXcMVT+L7gKfi8TZGCdVMJ0h44+hoW1DcK2F49WbZpkQyDfzDDSEdMd3SvERmBYja/4GX29TEV4pTlKEKSQy4Noh8KU/WDhzpA+H3oMkXSVRoYZAd1Pn5u9ZSmIIp3bAmN6gzeDswD9iSwgBldpivyT8G/ybAgdGh3nsostymX5/kCkn3PwnZMezsrCQdBwj8lj4AsguVrEiixMiUbds4N+r8Sb1HUujxUnZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTZpQV95w7N+KZ3TLkFBFkv5rl72olFEAxDIyZUdUwU=;
 b=LBDYEC4hvu8rGc0+l2iPfLi/kFJTGPNIv9JjGOGjmxFAIzZ8AFJ+C9RlThhlv2SZQ2Wy8akhUBE0tWj9y8t7uEMlG24HNY3PDVazA9xdw/mhqwsB077Ctsdb7mgmvf5q3MAjwgCthciqvmZRMoiBQXijHyGcsnikz6PzjkBXTM/473BGSyMvML2Mo2k+q3CETXkpzKL0FHU4sUaYemUQfy0v8HitN9xzuCavmWXh05pVFiRFH7CSeNTWaliSnhcNjpfmNCZhl4hPayOazTxRpGtqVhwAsCNxyGX02QId/UAi+tnMeom8kQY9WJ42nTcDKO0KOt1pZShV5rgS6MAFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTZpQV95w7N+KZ3TLkFBFkv5rl72olFEAxDIyZUdUwU=;
 b=bnyZcI18IhG3+gAg1J8tNc/Uabf38qSVCqR3ii0jzrPtrPXZsrZ+cX8JYE64xIG1y8id2wZSHASVLOkX8XiL9gU+C2zbzABr3EFHjwXb2vVr+N/HR8p+nPAO1y0Cx7K/4Yg4vj9VCsLnLVCRd7FqMd4irfQlQ7RoLabl/ymNWR0=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 14:40:51 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::8815:8e06:d0f2:c41e]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::8815:8e06:d0f2:c41e%3]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 14:40:51 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix fence handling in amdgpu_gem_object_close
Thread-Topic: [PATCH] drm/amdgpu: fix fence handling in amdgpu_gem_object_close
Thread-Index: AQHWB2hIgrM6Jr7UJ02hHKkcO2+CDqhixe0A
Date: Tue, 31 Mar 2020 14:40:51 +0000
Message-ID: <54495813-2152-4916-91C3-15FEAA518C38@amd.com>
References: <20200331142537.2948-1-christian.koenig@amd.com>
In-Reply-To: <20200331142537.2948-1-christian.koenig@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 533ade88-489d-4935-4c7d-08d7d581829d
x-ms-traffictypediagnostic: SN1PR12MB2350:|SN1PR12MB2350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB23504EFB14D17A8222DF473087C80@SN1PR12MB2350.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(66446008)(33656002)(966005)(36756003)(45080400002)(6486002)(81156014)(2616005)(6512007)(8676002)(478600001)(2906002)(81166006)(8936002)(86362001)(6916009)(91956017)(4326008)(76116006)(66556008)(5660300002)(66574012)(6506007)(186003)(26005)(66946007)(66476007)(71200400001)(54906003)(64756008)(316002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNX8gG1dYeTu1huq8S36a27rhZSrQGBOgP2lkcYXn61Q4QSnuxXeGYJ9aBrZXPwLQIw8Tp4AIEekQH+EL1mKlYgx4iF8iRQs+QaJlkgVvRpRA8ej9Ilt+GTaBpuzRb8HKgxO4bjnJcNmFMK94M7ahjH7l8DBO9qW0aBi6EgPUk+R2Ojg+sEzWndp6fX/ivR+7MGdeCQaEBr+OQF0H7PW8gkeHXNTv901ZSEew37PYs43mjimYjgr+GVHlC6P/eQO5gX5axoz8moD5J3x/Vp5tSx/BX2Y7RMLx+D5fqgpKCVAjcuRbbwSYZmvzhdINYgLqTQmXVkY763kbWRC3vRDpVhqW3VoRuUeubewID33xmN46sJ0PvMiUbehENLQEX33AuRYD/kKVoNyNLYrfHltd+cmPIo9BI1qCczvYptUcZZ28kTDUUM3cvu/oA5fZUr8x6Lf+1PXIb+EoEQsS8SZhW67gLbnd9KY/phXDEdILq4=
x-ms-exchange-antispam-messagedata: /sOCf5VtEA0SQvrict6v9t63EJjtpVqWvSyD/ltBxBKD7HgQDw+jV9B/aPPD24Gm/RhpjBeOf3XxXhiqaDBhZ2068+MajgYUzzianu5MwTDg2xCxOvU8VWHj82d/ngtIgsGsRNJyx6AljaLJFZPd8A==
Content-ID: <734BD535ED314B4292E6766ADA5D51E5@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533ade88-489d-4935-4c7d-08d7d581829d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 14:40:51.4369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RD5X25fShfihSydS6k+oTcuiYMYz8GsWPrwpTbm75lxPxzDswwYZFLUPCR9Hw5RV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
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

UmV2aWV3ZWQtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4NCg0KPiAyMDIw5bm0
M+aciDMx5pelIDIyOjI177yMQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+IOWGmemBk++8mg0KPiANCj4gVGhlIGV4Y2x1c2l2ZSBmZW5jZSBpcyBvbmx5
IG9wdGlvbmFsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiAtLS0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dlbS5jIHwgNiArKysrLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMNCj4gaW5kZXggYTBiZTgwNTEzZTk2Li43N2Q5ODhhMDAzM2YgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gQEAgLTE5MSw4ICsxOTEsMTAgQEAg
dm9pZCBhbWRncHVfZ2VtX29iamVjdF9jbG9zZShzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwN
Cj4gCQlnb3RvIG91dF91bmxvY2s7DQo+IA0KPiAJZmVuY2UgPSBkbWFfcmVzdl9nZXRfZXhjbChi
by0+dGJvLmJhc2UucmVzdik7DQo+IC0JYW1kZ3B1X2JvX2ZlbmNlKGJvLCBmZW5jZSwgdHJ1ZSk7
DQo+IC0JZmVuY2UgPSBOVUxMOw0KPiArCWlmIChmZW5jZSkgew0KPiArCQlhbWRncHVfYm9fZmVu
Y2UoYm8sIGZlbmNlLCB0cnVlKTsNCj4gKwkJZmVuY2UgPSBOVUxMOw0KPiArCX0NCj4gDQo+IAly
ID0gYW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKGFkZXYsIHZtLCAmZmVuY2UpOw0KPiAJaWYgKHIgfHwg
IWZlbmNlKQ0KPiAtLSANCj4gMi4xNy4xDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmcl
MkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0N4aW5odWku
cGFuJTQwYW1kLmNvbSU3Q2Q1OWRhMDM4OTkzZTQzMTYwZjY2MDhkN2Q1N2Y2NTM1JTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzIxMjYxNTUxOTA4MjMzMiZh
bXA7c2RhdGE9a0xDRVYwMWFvSjYlMkJyV0Q3eVJCTjFOQjNiJTJGSlJ5WUEwVHBWJTJGR29BVEIw
YyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
