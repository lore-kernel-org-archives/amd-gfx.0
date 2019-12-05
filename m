Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AE3C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 01:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB1120675
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 01:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB1120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F00D6E0AA;
	Thu,  5 Dec 2019 01:31:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0916E0AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 01:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJYP+QJVoBd6mTLrhFmOvGb5E3/hAmBDnbGx77gdNIb+rAqhUgmjQa5f86E+miGFbY8bSdf4VJpbVZwmeJ7yQIBsIZBSd5p6L58S3W5uYPQM52ZI0fqG0YmO1KWCN0Gtagn7BKfJfau7d8ZklZyeb2hxA/jcQwNk/JaMNLGxzPg4Q5SsDS0v/HTI7ikJtb8y+X3pY7uuMix1pIYNC80QTe/1axrAKGi7qX56h14d2h27oynD95CoiMb0Uf4R+qB4sio198K25inp+vOL2wCCDRDk+uOjIX7ACTgnfvl+09n1/fxhBAq243B9oAYzfYP+fB1yOIfn5SR8ANYihi+/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJzrE8d9tlfayhu1fQKn5l/P4yNoHSexYvOopRWDViU=;
 b=hhXFRxHdXtytbu+YR97JD7a/FM0C8tLSON6oRhMuEvXGIl53+JA+WdmGR0Xs3GrPuBnldY6nQVQlFh9Boj6WOiQQnqKWjD9G38bLjWcyaI1RDz4SrGfIQpLl86PaKGMSTAPBz3xp9zlX0InF1zCXSmOjrV4WiDb3/Av2mDQvc6T4NMbrjgkZtFBjmobD4F1Lg2LCKVjGYripkTYqPNoGjPiQaY8yCKkVjgHuB+PI8CPtuzaChyiSK8WvXJPhU6LLobFhX2vbv7I/qWmpDscUzSeb5PDU2gT/K8C8ZQyOZshD2n5JbmLmWP2ARXo62cQnyjnx6QWeVL1O59hqR1g9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3707.namprd12.prod.outlook.com (10.255.172.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 01:31:45 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 01:31:45 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: move VM eviction decision into amdgpu_vm.c
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com
References: <20191204153822.2199-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <6a223764-cb81-539a-5a72-54fdc1d94074@amd.com>
Date: Wed, 4 Dec 2019 20:31:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191204153822.2199-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::35) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1758fd03-7b0b-408b-8a10-08d77922e3bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:|DM6PR12MB3707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3707F22FDEA307340B37750F925C0@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(66476007)(8676002)(66946007)(65956001)(66556008)(6246003)(6486002)(229853002)(6436002)(50466002)(23676004)(6636002)(6512007)(81156014)(8936002)(66574012)(5660300002)(81166006)(25786009)(58126008)(52116002)(31686004)(3846002)(6116002)(498600001)(6506007)(14454004)(53546011)(36756003)(2906002)(2616005)(186003)(99286004)(26005)(44832011)(2870700001)(7736002)(31696002)(76176011)(11346002)(36916002)(86362001)(305945005)(14444005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3707;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Apzk/JPUycyR1I7lXvD9kppH9JG2+hjPOhogQ+Hkd9T3jow23n2IZMY1ZHSDqinq8xqZt1H+qpTd+HfZ64/Xb+h0IA73xfnjp9S/27VfW33xDdk+QDLkmtkX3cuwRUW70lSaf/vKSgIxQXIKcig+23v6HTutuMochtEqvKF9DVWfIJrIKsXJlVZP5Sg/wRuzwwiLqmaK28cgQuBV6dv3Kk0syn2QVAjDqa1yA1I+McFfRTBvLfX38LLtGtTC7dyR2Kh048j/lc+YCD0ChFVFR1E6LqpgqLkjTQ4b1fmw8sa9Yn2a+LU3+7DgQYVBpxZwsyx4EaOxKm30yo7texuk8fbkKXOtzUBZVMZ/y/zjZkO49eoQ4z3lE1inDN7c4k4QJn3EMypAW5zJUcz5VRnJmcPN7p4lYn09/yBU10l8/CU/eB171+cOugVOuhphWt+G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1758fd03-7b0b-408b-8a10-08d77922e3bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 01:31:45.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwnHFuxs2vVd207GSe7fSCyN47TV9Q1aq0F69WaHheJ6khWwpneyf3cWac1DC3AXx49v8F8thZOSN7B9cOkKsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJzrE8d9tlfayhu1fQKn5l/P4yNoHSexYvOopRWDViU=;
 b=pm1ahALeLKR4YMAbI0Rhnibim3LwX4HwSrZK/adILk8wHWIZOQ1o6nNfgvJyc6N3mioShP7O4ptb9lSJH7VCgz6nUIuiWt0TnMeXB+v5qG5HJ+/tIoHA1Gd0Re+I16zpnlR5ah4NWuVrlrSx8Ba0rgBASsZAeMaJGsiuo4v/iGY=
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMi0wNCAxMDozOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFdoZW4g
YSBwYWdlIHRhYmxlcyBuZWVkcyB0byBiZSBldmljdGVkIHRoZSBWTSBjb2RlIHNob3VsZAo+IGRl
Y2lkZSBpZiB0aGF0IGlzIHBvc3NpYmxlIG9yIG5vdC4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlbGl4
IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgIDUgKy0tLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jICB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oICB8ICAxICsKPiAgIDMgZmls
ZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBpbmRleCAxOWZmZTAwZDkwNzIuLjgxZjY3
NjRmMWJhNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBA
QCAtMTQ4OSwxMSArMTQ4OSw4IEBAIHN0YXRpYyBib29sIGFtZGdwdV90dG1fYm9fZXZpY3Rpb25f
dmFsdWFibGUoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKPiAgIAlzdHJ1Y3QgZG1hX2Zl
bmNlICpmOwo+ICAgCWludCBpOwo+ICAgCj4gLQkvKiBEb24ndCBldmljdCBWTSBwYWdlIHRhYmxl
cyB3aGlsZSB0aGV5IGFyZSBidXN5LCBvdGhlcndpc2Ugd2UgY2FuJ3QKPiAtCSAqIGNsZWFubHkg
aGFuZGxlIHBhZ2UgZmF1bHRzLgo+IC0JICovCj4gICAJaWYgKGJvLT50eXBlID09IHR0bV9ib190
eXBlX2tlcm5lbCAmJgo+IC0JICAgICFkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3JjdShiby0+YmFz
ZS5yZXN2LCB0cnVlKSkKPiArCSAgICAhYW1kZ3B1X3ZtX2V2aWN0YWJsZSh0dG1fdG9fYW1kZ3B1
X2JvKGJvKSkpCj4gICAJCXJldHVybiBmYWxzZTsKPiAgIAo+ICAgCS8qIElmIGJvIGlzIGEgS0ZE
IEJPLCBjaGVjayBpZiB0aGUgYm8gYmVsb25ncyB0byB0aGUgY3VycmVudCBwcm9jZXNzLgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggYTk0YzRmYWE1YWYxLi5h
MjJiZDU3MTI5ZDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+
IEBAIC0yNTAzLDYgKzI1MDMsMjggQEAgdm9pZCBhbWRncHVfdm1fYm9fcm12KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+ICAgCWtmcmVlKGJvX3ZhKTsKPiAgIH0KPiAgIAo+ICsvKioKPiAr
ICogYW1kZ3B1X3ZtX2V2aWN0YWJsZSAtIGNoZWNrIGlmIHdlIGNhbiBldmljdCBhIFZNCj4gKyAq
Cj4gKyAqIEBibzogQSBwYWdlIHRhYmxlIG9mIHRoZSBWTS4KPiArICoKPiArICogQ2hlY2sgaWYg
aXQgaXMgcG9zc2libGUgdG8gZXZpY3QgYSBWTS4KPiArICovCj4gK2Jvb2wgYW1kZ3B1X3ZtX2V2
aWN0YWJsZShzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPiArewo+ICsJc3RydWN0IGFtZGdwdV92bV9i
b19iYXNlICpib19iYXNlID0gYm8tPnZtX2JvOwo+ICsKPiArCS8qIFBhZ2UgdGFibGVzIG9mIGEg
ZGVzdHJveWVkIFZNIGNhbiBnbyBhd2F5IGltbWVkaWF0ZWx5ICovCj4gKwlpZiAoIWJvX2Jhc2Ug
fHwgIWJvX2Jhc2UtPnZtKQo+ICsJCXJldHVybiB0cnVlOwo+ICsKPiArCS8qIERvbid0IGV2aWN0
IFZNIHBhZ2UgdGFibGVzIHdoaWxlIHRoZXkgYXJlIGJ1c3kgKi8KPiArCWlmICghZG1hX3Jlc3Zf
dGVzdF9zaWduYWxlZF9yY3UoYm8tPnRiby5iYXNlLnJlc3YsIHRydWUpKQo+ICsJCXJldHVybiBm
YWxzZTsKPiArCj4gKwlyZXR1cm4gdHJ1ZTsKPiArfQo+ICsKPiAgIC8qKgo+ICAgICogYW1kZ3B1
X3ZtX2JvX2ludmFsaWRhdGUgLSBtYXJrIHRoZSBibyBhcyBpbnZhbGlkCj4gICAgKgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gaW5kZXggNzZmY2Y4NTMwMzVjLi5kYjU2
MTc2NTQ1M2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+IEBA
IC0zODEsNiArMzgxLDcgQEAgaW50IGFtZGdwdV92bV9oYW5kbGVfbW92ZWQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4gICBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPiAgIAkJCXN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3ZhLAo+ICAgCQkJ
Ym9vbCBjbGVhcik7Cj4gK2Jvb2wgYW1kZ3B1X3ZtX2V2aWN0YWJsZShzdHJ1Y3QgYW1kZ3B1X2Jv
ICpibyk7Cj4gICB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAo+ICAgCQkJICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpibywgYm9vbCBldmljdGVk
KTsKPiAgIHVpbnQ2NF90IGFtZGdwdV92bV9tYXBfZ2FydChjb25zdCBkbWFfYWRkcl90ICpwYWdl
c19hZGRyLCB1aW50NjRfdCBhZGRyKTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
