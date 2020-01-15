Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9FDC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 18:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581A4214AF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 18:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wRNAX9ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581A4214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005296EA64;
	Wed, 15 Jan 2020 18:01:59 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690040.outbound.protection.outlook.com [40.107.69.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22A16EA64
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 18:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMHq1g9WxknSd4XDBwG8I221K+WCi/5hlB/WWCCm65gc0iLZfgyFl/U+/8IBW212DAIqUBrKt+Z2Uc74coSWKYhb5RSI2myit1f3gNjaZKS2iTui7llcHyhnHWwTyc+H3isq/a2zGLMFIfhTkvu+Z4OAo8YdEGBOKxeXof2JivvOHc1fktMIWX0CeNTs11aYO1hoV0c5i1uVJ5qDocSkWxPzH0spZzH6ThEK4Snq14x5RPjVVbH0Nq2qmpqte35lTl/pY69j/xPGoZluWho9YvdIHnyruX1BrbO3NC0EG/mSXufM3XXA+2zClPOzJdWrjbOK8hcsNvCHa/N7Gu6MNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSjQ7PIEwFqQ46vQ537hcqnciEBs5bXeTV+CGgMbKnk=;
 b=FSeP4Ifz7/OzevGXW5uNhL/yI1zjgVrBjbOpeUobXlPh91tUndz40GGKytydKU1SjqT7lF3IvtgGf1YHF31k5jrtzxm1pWq9sAY94pk46DT/s1D/1b6PTT4mTBuVxDjhIp38g5DaoIaTXne9h8GaYi6WvGXWFgs9zGejZpO77+sNr5yEKfTPyQz8uj8O4WQmHMqXGyFrsgbMk3V1SigSzIDeoGl7KglpvG4uC+dxU9j82g0IFzIY/eWd9vzQ7nebFk/+gGBil2106YJ+GY9RDY8EF3z2VGxiebKdzjcSIOPkquKPsZXWjzylnvnxz/g+WuUnMHrHJpmS0bzTnDz3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSjQ7PIEwFqQ46vQ537hcqnciEBs5bXeTV+CGgMbKnk=;
 b=wRNAX9lywh08Nsa/i7kFTqdiuGYUX4CYdvaGuyWh0WWr1A9NNLBzbYzcojrb4HEA996TeZv//zmKlgpfpfxlIaUTGl9HhnHFcGUxvL1XSGu5QfTpzTYRVJ50HPYyVB9Xsh0tUb7uuP+td9sXLRf+7D1Vcv+Bf8Mgs3bCmGf5uKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1196.namprd12.prod.outlook.com (10.168.237.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.14; Wed, 15 Jan 2020 18:01:57 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 18:01:57 +0000
Subject: Re: [PATCH] drm/scheduler: improve job distribution with multiple
 queues
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200115172153.33694-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <91a3cd62-8264-ae23-d2f5-9148e1eabab0@amd.com>
Date: Wed, 15 Jan 2020 19:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200115172153.33694-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:404:23::32) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 BN6PR03CA0022.namprd03.prod.outlook.com (2603:10b6:404:23::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 18:01:55 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2d1c771-ae23-460e-593a-08d799e502c7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1196:|DM5PR12MB1196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1196F1596C110208F8D1203D83370@DM5PR12MB1196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(66476007)(186003)(66574012)(5660300002)(478600001)(16526019)(52116002)(316002)(6486002)(31696002)(86362001)(66556008)(4326008)(81156014)(8936002)(31686004)(66946007)(2906002)(36756003)(81166006)(2616005)(6666004)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1196;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KhOLctOKg2/IPVZbQY1pvok5H1cYu8veAYPcWjFhVdmORtaNRVlOSRJfyWNZ+igQ00byCVOlczG/U+x1iDz/S0t3qHn9HIcbSOelKDivsAikJXObrkDu//K8pn8Qq6m8jz/8qfEIlwAnSeQ+ND/zz0f8jCiSWyYrirwT8yUg381iYoRlQn790kLm8dYje+N77X3FA6NhMYzqHfiNaC7VRuXW4QN+1/Z5zRVLJ70RSfUvUkpQQUwcyVGkWYy889qMDtExHuc+CCQDt4D/QaTi1jVAavp3RXkUIaktDBbfp8q6i08QUVJbnOkXFbrSfW3nnKKWVYKZBv3DTZr+QBI+piMSVdG3TZFyeMCXV792HVQ1puZWFNTnqAK4Ni7zZl4kATodZzROLVXoV9XuLI9BnpQZealUhqUIepWoSaXp7C0kA63S27S2ZWuF91MRiAQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d1c771-ae23-460e-593a-08d799e502c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 18:01:57.1922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WXUaY3smOznnSjVgln7oUkGh2u13/MPclSJ1DIZEWZqqQrHZw0kRL7K/F+HeP9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1196
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 pierre-eric.pelloux-prayer@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTUuMDEuMjAgdW0gMTg6MjEgc2NocmllYiBOaXJtb3kgRGFzOgo+IFRoaXMgcGF0Y2ggdXNl
cyBzY29yZSBiYXNlZCBsb2dpYyB0byBzZWxlY3QgYSBuZXcgcnEgZm9yIGJldHRlcgo+IGxvYWRi
YWxhbmNlIGJldHdlZW4gbXVsdGlwbGUgcnEvc2NoZWRzIGluc3RlYWQgb2YgbnVtX2pvYnMuCj4K
PiBCZWxvdyBhcmUgdGVzdCByZXN1bHRzIGFmdGVyIHJ1bm5pbmcgYW1kZ3B1X3Rlc3QgZnJvbSBt
ZXNhIGRybQo+Cj4gQmVmb3JlIHRoaXMgcGF0Y2g6Cj4KPiBzY2hlZF9uYW1lICAgICBudW0gb2Yg
bWFueSB0aW1lcyBpdCBnb3Qgc2NoZWR1bGVkCj4gPT09PT09PT09ICAgICAgPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQo+IHNkbWEwICAgICAgICAgIDMxNAo+IHNkbWExICAgICAg
ICAgIDMyCj4gY29tcF8xLjAuMCAgICAgNTYKPiBjb21wXzEuMC4xICAgICAwCj4gY29tcF8xLjEu
MCAgICAgMAo+IGNvbXBfMS4xLjEgICAgIDAKPiBjb21wXzEuMi4wICAgICAwCj4gY29tcF8xLjIu
MSAgICAgMAo+IGNvbXBfMS4zLjAgICAgIDAKPiBjb21wXzEuMy4xICAgICAwCj4gQWZ0ZXIgdGhp
cyBwYXRjaDoKPgo+IHNjaGVkX25hbWUgICAgIG51bSBvZiBtYW55IHRpbWVzIGl0IGdvdCBzY2hl
ZHVsZWQKPiA9PT09PT09PT0gICAgICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
Cj4gc2RtYTAgICAgICAgICAgMjE2Cj4gc2RtYTEgICAgICAgICAgMTg1Cj4gY29tcF8xLjAuMCAg
ICAgMzkKPiBjb21wXzEuMC4xICAgICA5Cj4gY29tcF8xLjEuMCAgICAgMTIKPiBjb21wXzEuMS4x
ICAgICAwCj4gY29tcF8xLjIuMCAgICAgMTIKPiBjb21wXzEuMi4xICAgICAwCj4gY29tcF8xLjMu
MCAgICAgMTIKPiBjb21wXzEuMy4xICAgICAwCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFz
IDxuaXJtb3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfZW50aXR5LmMgfCAxMCArKysrKy0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX21haW4uYyAgIHwgIDYgKysrKy0tCj4gICBpbmNsdWRlL2RybS9ncHVfc2No
ZWR1bGVyLmggICAgICAgICAgICAgIHwgIDYgKysrLS0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1
bGVyL3NjaGVkX2VudGl0eS5jCj4gaW5kZXggMmUzYTA1OGZjMjM5Li4zM2UyY2QxMDg5YTIgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiBAQCAtMTMwLDcg
KzEzMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgZHJtX3NjaGVkX3JxICoKPiAgIGRybV9zY2hlZF9lbnRp
dHlfZ2V0X2ZyZWVfc2NoZWQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPiAgIHsK
PiAgIAlzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycSA9IE5VTEw7Cj4gLQl1bnNpZ25lZCBpbnQgbWlu
X2pvYnMgPSBVSU5UX01BWCwgbnVtX2pvYnM7Cj4gKwl1bnNpZ25lZCBpbnQgbWluX3Njb3JlID0g
VUlOVF9NQVgsIG51bV9zY29yZTsKPiAgIAlpbnQgaTsKPiAgIAo+ICAgCWZvciAoaSA9IDA7IGkg
PCBlbnRpdHktPm51bV9zY2hlZF9saXN0OyArK2kpIHsKPiBAQCAtMTQxLDkgKzE0MSw5IEBAIGRy
bV9zY2hlZF9lbnRpdHlfZ2V0X2ZyZWVfc2NoZWQoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVu
dGl0eSkKPiAgIAkJCWNvbnRpbnVlOwo+ICAgCQl9Cj4gICAKPiAtCQludW1fam9icyA9IGF0b21p
Y19yZWFkKCZzY2hlZC0+bnVtX2pvYnMpOwo+IC0JCWlmIChudW1fam9icyA8IG1pbl9qb2JzKSB7
Cj4gLQkJCW1pbl9qb2JzID0gbnVtX2pvYnM7Cj4gKwkJbnVtX3Njb3JlID0gYXRvbWljX3JlYWQo
JnNjaGVkLT5zY29yZSk7Cj4gKwkJaWYgKG51bV9zY29yZSA8IG1pbl9zY29yZSkgewo+ICsJCQlt
aW5fc2NvcmUgPSBudW1fc2NvcmU7Cj4gICAJCQlycSA9ICZlbnRpdHktPnNjaGVkX2xpc3RbaV0t
PnNjaGVkX3JxW2VudGl0eS0+cHJpb3JpdHldOwo+ICAgCQl9Cj4gICAJfQo+IEBAIC00OTgsNyAr
NDk4LDcgQEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X3B1c2hfam9iKHN0cnVjdCBkcm1fc2NoZWRf
am9iICpzY2hlZF9qb2IsCj4gICAJYm9vbCBmaXJzdDsKPiAgIAo+ICAgCXRyYWNlX2RybV9zY2hl
ZF9qb2Ioc2NoZWRfam9iLCBlbnRpdHkpOwo+IC0JYXRvbWljX2luYygmZW50aXR5LT5ycS0+c2No
ZWQtPm51bV9qb2JzKTsKPiArCWF0b21pY19pbmMoJmVudGl0eS0+cnEtPnNjaGVkLT5zY29yZSk7
Cj4gICAJV1JJVEVfT05DRShlbnRpdHktPmxhc3RfdXNlciwgY3VycmVudC0+Z3JvdXBfbGVhZGVy
KTsKPiAgIAlmaXJzdCA9IHNwc2NfcXVldWVfcHVzaCgmZW50aXR5LT5qb2JfcXVldWUsICZzY2hl
ZF9qb2ItPnF1ZXVlX25vZGUpOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9z
Y2hlZHVsZXIvc2NoZWRfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9t
YWluLmMKPiBpbmRleCAzZmFkNTg3NmExM2YuLjcxY2U2MjE1OTU2ZiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gQEAgLTkyLDYgKzkyLDcgQEAgdm9pZCBkcm1f
c2NoZWRfcnFfYWRkX2VudGl0eShzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycSwKPiAgIAlpZiAoIWxp
c3RfZW1wdHkoJmVudGl0eS0+bGlzdCkpCj4gICAJCXJldHVybjsKPiAgIAlzcGluX2xvY2soJnJx
LT5sb2NrKTsKPiArCWF0b21pY19pbmMoJnJxLT5zY2hlZC0+c2NvcmUpOwo+ICAgCWxpc3RfYWRk
X3RhaWwoJmVudGl0eS0+bGlzdCwgJnJxLT5lbnRpdGllcyk7Cj4gICAJc3Bpbl91bmxvY2soJnJx
LT5sb2NrKTsKPiAgIH0KPiBAQCAtMTEwLDYgKzExMSw3IEBAIHZvaWQgZHJtX3NjaGVkX3JxX3Jl
bW92ZV9lbnRpdHkoc3RydWN0IGRybV9zY2hlZF9ycSAqcnEsCj4gICAJaWYgKGxpc3RfZW1wdHko
JmVudGl0eS0+bGlzdCkpCj4gICAJCXJldHVybjsKPiAgIAlzcGluX2xvY2soJnJxLT5sb2NrKTsK
PiArCWF0b21pY19kZWMoJnJxLT5zY2hlZC0+c2NvcmUpOwo+ICAgCWxpc3RfZGVsX2luaXQoJmVu
dGl0eS0+bGlzdCk7Cj4gICAJaWYgKHJxLT5jdXJyZW50X2VudGl0eSA9PSBlbnRpdHkpCj4gICAJ
CXJxLT5jdXJyZW50X2VudGl0eSA9IE5VTEw7Cj4gQEAgLTY1NSw3ICs2NTcsNyBAQCBzdGF0aWMg
dm9pZCBkcm1fc2NoZWRfcHJvY2Vzc19qb2Ioc3RydWN0IGRtYV9mZW5jZSAqZiwgc3RydWN0IGRt
YV9mZW5jZV9jYiAqY2IpCj4gICAJc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCA9IHNf
ZmVuY2UtPnNjaGVkOwo+ICAgCj4gICAJYXRvbWljX2RlYygmc2NoZWQtPmh3X3JxX2NvdW50KTsK
PiAtCWF0b21pY19kZWMoJnNjaGVkLT5udW1fam9icyk7Cj4gKwlhdG9taWNfZGVjKCZzY2hlZC0+
c2NvcmUpOwo+ICAgCj4gICAJdHJhY2VfZHJtX3NjaGVkX3Byb2Nlc3Nfam9iKHNfZmVuY2UpOwo+
ICAgCj4gQEAgLTgzMCw3ICs4MzIsNyBAQCBpbnQgZHJtX3NjaGVkX2luaXQoc3RydWN0IGRybV9n
cHVfc2NoZWR1bGVyICpzY2hlZCwKPiAgIAlzcGluX2xvY2tfaW5pdCgmc2NoZWQtPmpvYl9saXN0
X2xvY2spOwo+ICAgCWF0b21pY19zZXQoJnNjaGVkLT5od19ycV9jb3VudCwgMCk7Cj4gICAJSU5J
VF9ERUxBWUVEX1dPUksoJnNjaGVkLT53b3JrX3RkciwgZHJtX3NjaGVkX2pvYl90aW1lZG91dCk7
Cj4gLQlhdG9taWNfc2V0KCZzY2hlZC0+bnVtX2pvYnMsIDApOwo+ICsJYXRvbWljX3NldCgmc2No
ZWQtPnNjb3JlLCAwKTsKPiAgIAlhdG9taWM2NF9zZXQoJnNjaGVkLT5qb2JfaWRfY291bnQsIDAp
Owo+ICAgCj4gICAJLyogRWFjaCBzY2hlZHVsZXIgd2lsbCBydW4gb24gYSBzZXBlcmF0ZSBrZXJu
ZWwgdGhyZWFkICovCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaCBi
L2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+IGluZGV4IDk2YTFhMWI3NTI2ZS4uNTM3Zjdh
NDY1NWE1IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+ICsrKyBi
L2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+IEBAIC0yNjEsNyArMjYxLDcgQEAgc3RydWN0
IGRybV9zY2hlZF9iYWNrZW5kX29wcyB7Cj4gICAgKiBAam9iX2xpc3RfbG9jazogbG9jayB0byBw
cm90ZWN0IHRoZSByaW5nX21pcnJvcl9saXN0Lgo+ICAgICogQGhhbmdfbGltaXQ6IG9uY2UgdGhl
IGhhbmdzIGJ5IGEgam9iIGNyb3NzZXMgdGhpcyBsaW1pdCB0aGVuIGl0IGlzIG1hcmtlZAo+ICAg
ICogICAgICAgICAgICAgIGd1aWx0eSBhbmQgaXQgd2lsbCBiZSBjb25zaWRlcmVkIGZvciBzY2hl
ZHVsaW5nIGZ1cnRoZXIuCj4gLSAqIEBudW1fam9iczogdGhlIG51bWJlciBvZiBqb2JzIGluIHF1
ZXVlIGluIHRoZSBzY2hlZHVsZXIKPiArICogQHNjb3JlOiBzY29yZSB0byBoZWxwIGxvYWRiYWxh
bmNlciBwaWNrIGEgaWRsZSBzY2hlZAo+ICAgICogQHJlYWR5OiBtYXJrcyBpZiB0aGUgdW5kZXJs
eWluZyBIVyBpcyByZWFkeSB0byB3b3JrCj4gICAgKiBAZnJlZV9ndWlsdHk6IEEgaGl0IHRvIHRp
bWUgb3V0IGhhbmRsZXIgdG8gZnJlZSB0aGUgZ3VpbHR5IGpvYi4KPiAgICAqCj4gQEAgLTI4Miw4
ICsyODIsOCBAQCBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgewo+ICAgCXN0cnVjdCBsaXN0X2hl
YWQJCXJpbmdfbWlycm9yX2xpc3Q7Cj4gICAJc3BpbmxvY2tfdAkJCWpvYl9saXN0X2xvY2s7Cj4g
ICAJaW50CQkJCWhhbmdfbGltaXQ7Cj4gLQlhdG9taWNfdCAgICAgICAgICAgICAgICAgICAgICAg
IG51bV9qb2JzOwo+IC0JYm9vbAkJCXJlYWR5Owo+ICsJYXRvbWljX3QgICAgICAgICAgICAgICAg
ICAgICAgICBzY29yZTsKPiArCWJvb2wJCQkJcmVhZHk7Cj4gICAJYm9vbAkJCQlmcmVlX2d1aWx0
eTsKPiAgIH07Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
