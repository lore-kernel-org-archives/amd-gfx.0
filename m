Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898C9C33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4863A2072B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 15:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N14Dz1hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4863A2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2BD6EAF5;
	Thu, 16 Jan 2020 15:22:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE9E66EAF5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 15:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7gnYqqiKgU6U0eEk1T8DpLLjuENJQ9AI00mzQktsm64Mw3oGq2KIsez+75cOvx3rtTTJtsC9XBpfgdV29fqzOYdo6ViQXaozYhZELq/3MjHHs8QY+Rr/FT47a/oStuFrWBhZ+tPVjv5gwD1wnwjDNW2ywQVcpbsylUKJiIlaV7tqjcELK3MkC+vwzif8y/QLgEtW+U8JPcW9rhHCZv7OCpySg7DWB5zuUvBLTc3myXgSr1uEDg7ZDQwfNROk/8qz3r/Wpkz9DeohKxa7Qc2hf7xe1q0kGGu18tAWl0UVR0ZCxqIhfQJflJ4fp73rReQc4F1p0Hsi4x28B+gevFiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkbZ1lQzeJIO3ARs2scLqrYPyuyvS/iL6CVUgMnmGHk=;
 b=WihXlxJWZ+gt5siEkJ5fo5RTzDJBDeAphnUPnjF3AS3SNsvsKAt+6qHkmjm2vRWSWMAEULQ+2IZz5x11j2DxPmfyU5siuHQ84SxJXfHOJFeDsu1zsskh3CN6y/W1v0/3EzBplTq0h+KFYDclI+vJqmwgVvXIinWo7dV0N2DgHLSzLALDs9fi+7clKpxm8RZ8rXShyJ4qgoup8D0Q1EJbc5n3nuj7HhefcBl8AFfdiai8oZLw7tDsSOGFyLskDuluCKofulxRgh7aHKiqOe2Zwp6dxolNEMTl0bfKWDfCwg6uvg3whG7oOdpQpI/xhfhcKKcTnBPXUP8lKeLOuaiAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkbZ1lQzeJIO3ARs2scLqrYPyuyvS/iL6CVUgMnmGHk=;
 b=N14Dz1hfJWJkCB4K/10Az5AfuScSgQ36080sBSUmatUbsQCXvV55H8SLfzKauCtddmaOPy94XwsL3Ge6S4J6jbxMsyOptotRKO4MdguwD1CrGLBk5ZTH2zyVRymLL8lAZjuwaVgxzcQHcYR8O5KermFK9TmA4z5WNaDtvcbb30M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from BN6PR12MB1699.namprd12.prod.outlook.com (10.175.97.148) by
 BN6PR12MB1283.namprd12.prod.outlook.com (10.168.225.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 15:22:32 +0000
Received: from BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::2cac:fcd3:c947:5813]) by BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::2cac:fcd3:c947:5813%8]) with mapi id 15.20.2623.017; Thu, 16 Jan 2020
 15:22:32 +0000
Subject: Re: [PATCH] drm/scheduler: fix documentation by replacing rq_list
 with sched_list
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200116144320.109044-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d77b5c95-78b0-b62d-f6ca-8b25fe8de45c@amd.com>
Date: Thu, 16 Jan 2020 16:22:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200116144320.109044-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0097.eurprd07.prod.outlook.com
 (2603:10a6:207:6::31) To BN6PR12MB1699.namprd12.prod.outlook.com
 (2603:10b6:404:ff::20)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR07CA0097.eurprd07.prod.outlook.com (2603:10a6:207:6::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.10 via Frontend Transport; Thu, 16 Jan 2020 15:22:31 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2b166a1-28d6-458e-7cae-08d79a97e7f5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1283:|BN6PR12MB1283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB12834D1159BED0A9579153CA83360@BN6PR12MB1283.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(66574012)(16526019)(31696002)(66476007)(6486002)(6666004)(2616005)(2906002)(66556008)(186003)(86362001)(66946007)(52116002)(478600001)(4326008)(31686004)(81166006)(8936002)(81156014)(8676002)(5660300002)(36756003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1283;
 H:BN6PR12MB1699.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDg474DIzx50uKxBAuk7ils/tYxjs1BkiTRGzklJ4DkP84teAdgmKE7V1P5eaxITSjoDkY4fmbkXoO4yy/uIWqaoT2VhPVM18bYP5oN185vkWIe1d4ZrNDy4THkUSWT7CSkHHFXN8MQxvYNJLN6ABI6VSulNz3m2a1SsQ+vwzn8nbbUyWjHGcWVIrKgtC9sTBrHEqL/HK7ZKZXmJ4w/dWQOkuDKAs7tAREGgIpldTTIcAOAptZilMgn1yNuVzQt32gEYjVxRVJCneVDzIaBVKw+ixfiF93ztnzVbOUtKN9oTaORtjWa3YelVZHuL26LILBqE9iXfDKggCRQBUt8r0FcwO8oC6Cq4Mm7nHfCEaKA3CXIsEtSl4rPOZv54vjw2gssdcJCN4Ml7Vq93lTD33heodA9JmCN2PBJ8XgLftIFKKhDJ9gAgoQlWX8V2lx/A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b166a1-28d6-458e-7cae-08d79a97e7f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 15:22:32.1967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/6VY4B2Ln0orktmlEdx+777tx/5p0ThQXdeCGf7EsQeiqFEmFeReOg0TYfMAcK6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1283
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDEuMjAgdW0gMTU6NDMgc2NocmllYiBOaXJtb3kgRGFzOgo+IFRoaXMgYWxzbyByZXBs
YWNlcyBvbGQgYXJ0aWZhY3RzIHdpdGggYSBjb3JyZWN0IG9uZSBpbiBkcm1fc2NoZWRfZW50aXR5
X2luaXQoKQo+IGRlY2xhcmF0aW9uCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJt
b3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfZW50aXR5LmMgfCAgMiArLQo+ICAgaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oICAgICAg
ICAgICAgICB8IDEwICsrKysrLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvc2NoZWRfZW50aXR5LmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2Vu
dGl0eS5jCj4gaW5kZXggMzNlMmNkMTA4OWEyLi5lYzc5ZThlNWFkM2MgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiBAQCAtNDUsNyArNDUsNyBAQAo+ICAg
ICogQGd1aWx0eTogYXRvbWljX3Qgc2V0IHRvIDEgd2hlbiBhIGpvYiBvbiB0aGlzIHF1ZXVlCj4g
ICAgKiAgICAgICAgICBpcyBmb3VuZCB0byBiZSBndWlsdHkgY2F1c2luZyBhIHRpbWVvdXQKPiAg
ICAqCj4gLSAqIE5vdGU6IHRoZSBycV9saXN0IHNob3VsZCBoYXZlIGF0bGVhc3Qgb25lIGVsZW1l
bnQgdG8gc2NoZWR1bGUKPiArICogTm90ZTogdGhlIHNjaGVkX2xpc3Qgc2hvdWxkIGhhdmUgYXRs
ZWFzdCBvbmUgZWxlbWVudCB0byBzY2hlZHVsZQo+ICAgICogICAgICAgdGhlIGVudGl0eQo+ICAg
ICoKPiAgICAqIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBv
biBmYWlsdXJlLgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmggYi9p
bmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPiBpbmRleCA1MzdmN2E0NjU1YTUuLjllNzFiZTEy
OWMzMCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPiArKysgYi9p
bmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgKPiBAQCAtNTIsOSArNTIsOSBAQCBlbnVtIGRybV9z
Y2hlZF9wcmlvcml0eSB7Cj4gICAgKiBAbGlzdDogdXNlZCB0byBhcHBlbmQgdGhpcyBzdHJ1Y3Qg
dG8gdGhlIGxpc3Qgb2YgZW50aXRpZXMgaW4gdGhlCj4gICAgKiAgICAgICAgcnVucXVldWUuCj4g
ICAgKiBAcnE6IHJ1bnF1ZXVlIG9uIHdoaWNoIHRoaXMgZW50aXR5IGlzIGN1cnJlbnRseSBzY2hl
ZHVsZWQuCj4gLSAqIEBycV9saXN0OiBhIGxpc3Qgb2YgcnVuIHF1ZXVlcyBvbiB3aGljaCBqb2Jz
IGZyb20gdGhpcyBlbnRpdHkgY2FuCj4gLSAqICAgICAgICAgICBiZSBzY2hlZHVsZWQKPiAtICog
QG51bV9ycV9saXN0OiBudW1iZXIgb2YgcnVuIHF1ZXVlcyBpbiB0aGUgcnFfbGlzdAo+ICsgKiBA
c2NoZWRfbGlzdDogYSBsaXN0IG9mIGRybV9ncHVfc2NoZWR1bGVycyBvbiB3aGljaCBqb2JzIGZy
b20gdGhpcyBlbnRpdHkgY2FuCj4gKyAqICAgICAgICAgICAgICBiZSBzY2hlZHVsZWQKPiArICog
QG51bV9zY2hlZF9saXN0OiBudW1iZXIgb2YgZHJtX2dwdV9zY2hlZHVsZXJzIGluIHRoZSBzY2hl
ZF9saXN0Lgo+ICAgICogQHJxX2xvY2s6IGxvY2sgdG8gbW9kaWZ5IHRoZSBydW5xdWV1ZSB0byB3
aGljaCB0aGlzIGVudGl0eSBiZWxvbmdzLgo+ICAgICogQGpvYl9xdWV1ZTogdGhlIGxpc3Qgb2Yg
am9icyBvZiB0aGlzIGVudGl0eS4KPiAgICAqIEBmZW5jZV9zZXE6IGEgbGluZWFybHkgaW5jcmVh
c2luZyBzZXFubyBpbmNyZW1lbnRlZCB3aXRoIGVhY2gKPiBAQCAtODEsOCArODEsOCBAQCBlbnVt
IGRybV9zY2hlZF9wcmlvcml0eSB7Cj4gICBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSB7Cj4gICAJ
c3RydWN0IGxpc3RfaGVhZAkJbGlzdDsKPiAgIAlzdHJ1Y3QgZHJtX3NjaGVkX3JxCQkqcnE7Cj4g
LQl1bnNpZ25lZCBpbnQgICAgICAgICAgICAgICAgICAgIG51bV9zY2hlZF9saXN0Owo+ICAgCXN0
cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAgICAgICAgKipzY2hlZF9saXN0Owo+ICsJdW5zaWduZWQg
aW50ICAgICAgICAgICAgICAgICAgICBudW1fc2NoZWRfbGlzdDsKPiAgIAllbnVtIGRybV9zY2hl
ZF9wcmlvcml0eSAgICAgICAgIHByaW9yaXR5Owo+ICAgCXNwaW5sb2NrX3QJCQlycV9sb2NrOwo+
ICAgCj4gQEAgLTMxNSw3ICszMTUsNyBAQCB2b2lkIGRybV9zY2hlZF9ycV9yZW1vdmVfZW50aXR5
KHN0cnVjdCBkcm1fc2NoZWRfcnEgKnJxLAo+ICAgaW50IGRybV9zY2hlZF9lbnRpdHlfaW5pdChz
dHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5LAo+ICAgCQkJICBlbnVtIGRybV9zY2hlZF9w
cmlvcml0eSBwcmlvcml0eSwKPiAgIAkJCSAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICoqc2No
ZWRfbGlzdCwKPiAtCQkJICB1bnNpZ25lZCBpbnQgbnVtX3JxX2xpc3QsCj4gKwkJCSAgdW5zaWdu
ZWQgaW50IG51bV9zY2hlZF9saXN0LAo+ICAgCQkJICBhdG9taWNfdCAqZ3VpbHR5KTsKPiAgIGxv
bmcgZHJtX3NjaGVkX2VudGl0eV9mbHVzaChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5
LCBsb25nIHRpbWVvdXQpOwo+ICAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X2Zpbmkoc3RydWN0IGRy
bV9zY2hlZF9lbnRpdHkgKmVudGl0eSk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
