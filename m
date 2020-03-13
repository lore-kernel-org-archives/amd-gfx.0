Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF4AC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 18:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB3620674
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 18:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GtYdY4mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB3620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A786EC44;
	Fri, 13 Mar 2020 18:08:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12EF6EC44
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 18:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcjChP7baoAsoAv8HlIZ61S/38Ga9MGsv21nqIDx77IM9bDgMxrfC4xn0z9nQ5Cfr3HgYzUBMYmJHbUybxu8p9YR5AeJaRrUkYNtWKp/SqG5JFLuRLBsuG1nQsFaxsxHu4/7voW4TiguG8U06EiUmV4ZpU6YEf74JMmgGdo1hFisAAHwWcYOQCKZdAJoqEvWP6OXXQggfLace0xF6eitS6vpIcCIsLpKoTO6SZ/ANwO2fuDpVi2LmYdeL/0HPMwQVhbzMtRKHNR/0zmf15YJuvFJ2zYP0uZ15WlWiz9Dj9w0Fbza8JmLQ9P+Ur5T3vPz2mRPeEvBomOqWzw+mO4+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cJDBM2ZGheDVuq3AJgtgh3YV9jBvjsXEKRxC1BrDxY=;
 b=kHntVYO1o088NK2ERHFDXPtiat0y0jiK9NgP47b5r592ZkeRWDnr9e6V9V0vC0LHaEaYpjVDkgEFYiMviBLvovaUa5g+hUtIAfBzSnK7olo3oIDUfwZDRCghURE8cLd4Cw+PBi9ZksiICRBSzRf/olKsVc7/KVvhxGaRERNBqRzbPL1zDCCeZw2U3YB6LHv2WNI1/O3VPwWQ351IhMe8K64rWjmudatPXPQg0oFrKNHozZkUn5bfOfjxTRw3tsethwnIPhIG3W0XW4EtAjLnPOunAqNks0SeIJt74TZ/OMSJM0UUelU875WAnUK/96lrN1GGgPSgHT8DDhake428DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cJDBM2ZGheDVuq3AJgtgh3YV9jBvjsXEKRxC1BrDxY=;
 b=GtYdY4mKpO95OGfR/UjDurE46wBCpauJwCNRJPbnqmCPytoykVotCvgFSL2l2KPxM8yh7v0CquB9u5PTEahmt/LGUiEHtsB7XWUuCwJJj8RfVZq48gBuHGc6aQn7ozm6Y/Bm2F+gKXEEebcUp8zVeKfoi+JDt4D9NIh8Cb0d8Z4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 18:08:16 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 18:08:16 +0000
Subject: Re: [PATCH v3 2/2] drm/amdgpu: unref the bo after job submit
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200313140758.6607-1-xinhui.pan@amd.com>
 <20200313140758.6607-3-xinhui.pan@amd.com>
 <cb5459d4-2e17-0259-2dd8-1f787a762d6b@amd.com>
 <B4B76788-F1ED-4B88-8622-C55A2A64A252@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <af51dc09-a5c5-a9df-84a8-c449e1851e66@amd.com>
Date: Fri, 13 Mar 2020 19:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <B4B76788-F1ED-4B88-8622-C55A2A64A252@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::34) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Fri, 13 Mar 2020 18:08:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcf56e26-4395-4879-b0fe-08d7c779809b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:|DM5PR12MB1516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB151676E69225283B682B62A083FA0@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(31686004)(36756003)(316002)(6666004)(186003)(81156014)(6636002)(37006003)(86362001)(54906003)(16526019)(66574012)(2616005)(81166006)(478600001)(8936002)(66946007)(5660300002)(6862004)(31696002)(2906002)(66556008)(4326008)(6486002)(52116002)(66476007)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1516;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGMwQI3y5nGJ5S+oivb5NKcrNN8IJHgn1wWjJ95RNo23ROmakm7oltXTM5L/sbjaeE6wI6lsgJOx6ud4CNl5aFthaxS5rsfujwTZrkWTlky34eYc/2isfFsu5l4iKOCaHyZCruVQNt6bYs1vK2mqHprIROHIdovjT2rzlqv+D+cB1cZpGMkFC5yYysdJS7VNWGxiSb1Hed+sp1r3x5XNhyz5h66BwYllr9vB3OKwUHKSBgXWgN2WBH00X7Jl4OrF8uCBM9tJ60JWKeP7G8s3WdEra/hpC1aicI6SEBYyOitlhQJDVGd8/oS0eaiVY92fBh34TDyBnD6aw4GVPFRRviUvrKOlwnTmsG2zLJDWdmx5iuESc0qBeBWn/0MyeDmM6zcljbLMQCQeEV23mGdRsD0vwYPmEBK+MDwkxrd37eDeefyh+BHSq+8sJfj5oNbX
X-MS-Exchange-AntiSpam-MessageData: Y8MD/elKoNeoE16xAlqTTV41t8Z6G44L2do9vCdLZnCj6W+yk4ihxoUTZappfvmx5ndELnLwVrZ2vnOrmV0pJAnnVlAwmPd0Wt6vNHfgS0BtCOWPyutr50fS7cw3H+4cdMscJ0WYtfzRuUz+fpQ/VXzJZ/KA+S0PXsyLzN3EOyC6/gTbXKBu8EYo4S1ZBt5uLchWqarcFRte3FpJIUrW2Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf56e26-4395-4879-b0fe-08d7c779809b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 18:08:16.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkg19jHbb1GYoQy4BBQ9sikmtXaBDfGD0Sx2tS2U5aT1QpusEOHwJS627iPpQiLx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDMuMjAgdW0gMTU6NTQgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0M+ac
iDEz5pelIDIyOjIw77yMS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4g5YaZ6YGT77yaCj4+Cj4+IEFtIDEzLjAzLjIwIHVtIDE1OjA3IHNjaHJpZWIgeGluaHVpIHBh
bjoKPj4+IE90aGVyd2lzZSB3ZSBtaWdodCBmcmVlIEJPcyBiZWZvcmUgam9iIGhhcyBjb21wbGV0
ZWQuCj4+PiBXZSBhZGQgdGhlIGZlbmNlIHRvIEJPIGFmdGVyIGNvbW1pdCwgc28gZnJlZSBCT3Mg
YWZ0ZXIgdGhhdC4KPj4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgbmVjZXNzYXJ5LCBidXQgcHJv
YmFibHkgYmV0dGVyIHNhdmUgdGhhbiBzb3JyeS4KPiB3aXRob3V0IHRoaXMgcGF0Y2gsIHdlIGhp
dCBnbWMgcGFnZSBmYXVsdC4KClRoZW4gdGhpcyBpcyBub3QgdGhlIHJvb3QgY2F1c2UuCgpTZWUg
ZnJlZWluZyBwYWdlIHRhYmxlcyBoZXJlIGlzIHNhdmUgc2luY2UgdGhleSBjYW4gb25seSBiZSBy
ZXVzZWQgYWZ0ZXIgCmFsbCBqb2JzIGNvbXBsZXRlZC4KClRoaXMgb25seSBmaXhlZCBhIHZlcnkg
c21hbGwgd2luZG93IHdoZXJlIHRoZSBQREUgd291bGQgc3RpbGwgcG9pbnQgdG8gCnRoZSBmcmVl
ZCBQVCB3aGljaCBtaWdodCBhbHJlYWR5IGJlIHJldXNlZC4KCkJ1dCB0aGlzIGNhbid0IGNhdXNl
IGEgR01DIHBhZ2UgZmF1bHQsIGl0IHdvdWxkIHJhdGhlciBiZSBhIHNlY3VyaXR5IApwcm9ibGVt
LgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+IHdlIGhhdmUgaW5kaXZpZHVhbGl6ZWQgYm8gcmVz
diBkdXJpbmcgYm8gcmVsZWFzaW5nLgo+IHNvIGFueSBmZW5jZXMgYWRkZWQgdG8gcm9vdCBQVCBi
byByZXN2IGFmdGVyIHRoYXQgaXMgYWN0dWFsbHkgdW50ZXN0ZWQuCj4KPj4gU29tZSBjb21tZW50
cyBiZWxvdy4KPj4KPj4+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
Pj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Pj4gU2lnbmVk
LW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgo+Pj4gLS0tCj4+PiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMzggKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+
PiBpbmRleCA4MDljYTZlOGY0MGYuLjYwNWExYmI0MDI4MCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gQEAgLTk0MiwxMyArOTQyLDE3IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3ZtX2FsbG9jX3B0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+
ICAgICoKPj4+ICAgICogQGVudHJ5OiBQREUgdG8gZnJlZQo+Pj4gICAgKi8KPj4+IC1zdGF0aWMg
dm9pZCBhbWRncHVfdm1fZnJlZV90YWJsZShzdHJ1Y3QgYW1kZ3B1X3ZtX3B0ICplbnRyeSkKPj4+
ICtzdGF0aWMgdm9pZCBhbWRncHVfdm1fZnJlZV90YWJsZShzdHJ1Y3QgYW1kZ3B1X3ZtX3B0ICpl
bnRyeSwKPj4+ICsJCQkJCXN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCj4+PiAgIHsKPj4+ICAgCWlm
IChlbnRyeS0+YmFzZS5ibykgewo+Pj4gICAJCWVudHJ5LT5iYXNlLmJvLT52bV9ibyA9IE5VTEw7
Cj4+PiAgIAkJbGlzdF9kZWwoJmVudHJ5LT5iYXNlLnZtX3N0YXR1cyk7Cj4+PiAtCQlhbWRncHVf
Ym9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvLT5zaGFkb3cpOwo+Pj4gLQkJYW1kZ3B1X2JvX3VucmVm
KCZlbnRyeS0+YmFzZS5ibyk7Cj4+PiArCQlpZiAoIWhlYWQpIHsKPj4+ICsJCQlhbWRncHVfYm9f
dW5yZWYoJmVudHJ5LT5iYXNlLmJvLT5zaGFkb3cpOwo+Pj4gKwkJCWFtZGdwdV9ib191bnJlZigm
ZW50cnktPmJhc2UuYm8pOwo+Pj4gKwkJfSBlbHNlCj4+PiArCQkJbGlzdF9hZGQoJmVudHJ5LT5i
YXNlLnZtX3N0YXR1cywgaGVhZCk7Cj4+IEluc3RlYWQgb2YgYWRkaW5nIGEgcGFyYW1ldGVyIG1h
a2UgdGhpcyBhIG5ldyBzdGF0ZSBpbiB0aGUgVk0uIFNvbWV0aGluZyBsaWtlIHZtLT56b21iaWVz
IG9yIHNvbWV0aGluZyBzaW1pbGFyLgo+Pgo+Pj4gICAJfQo+Pj4gICAJa3ZmcmVlKGVudHJ5LT5l
bnRyaWVzKTsKPj4+ICAgCWVudHJ5LT5lbnRyaWVzID0gTlVMTDsKPj4+IEBAIC05NjUsNyArOTY5
LDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyZWVfdGFibGUoc3RydWN0IGFtZGdwdV92bV9w
dCAqZW50cnkpCj4+PiAgICAqLwo+Pj4gICBzdGF0aWMgdm9pZCBhbWRncHVfdm1fZnJlZV9wdHMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+PiAgIAkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1
X3ZtICp2bSwKPj4+IC0JCQkgICAgICAgc3RydWN0IGFtZGdwdV92bV9wdF9jdXJzb3IgKnN0YXJ0
KQo+Pj4gKwkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNvciAqc3RhcnQsCj4+PiAr
CQkJCSAgIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCj4+PiAgIHsKPj4+ICAgCXN0cnVjdCBhbWRn
cHVfdm1fcHRfY3Vyc29yIGN1cnNvcjsKPj4+ICAgCXN0cnVjdCBhbWRncHVfdm1fcHQgKmVudHJ5
Owo+Pj4gQEAgLTk3MywxMCArOTc4LDEwIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3B0
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAgCXZtLT5idWxrX21vdmVhYmxlID0g
ZmFsc2U7Cj4+PiAgICAgCWZvcl9lYWNoX2FtZGdwdV92bV9wdF9kZnNfc2FmZShhZGV2LCB2bSwg
c3RhcnQsIGN1cnNvciwgZW50cnkpCj4+PiAtCQlhbWRncHVfdm1fZnJlZV90YWJsZShlbnRyeSk7
Cj4+PiArCQlhbWRncHVfdm1fZnJlZV90YWJsZShlbnRyeSwgaGVhZCk7Cj4+PiAgICAgCWlmIChz
dGFydCkKPj4+IC0JCWFtZGdwdV92bV9mcmVlX3RhYmxlKHN0YXJ0LT5lbnRyeSk7Cj4+PiArCQlh
bWRncHVfdm1fZnJlZV90YWJsZShzdGFydC0+ZW50cnksIGhlYWQpOwo+Pj4gICB9Cj4+PiAgICAg
LyoqCj4+PiBAQCAtMTQyOCw3ICsxNDMzLDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyYWdt
ZW50KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+Pj4gICAgKi8KPj4+
ICAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRh
dGVfcGFyYW1zICpwYXJhbXMsCj4+PiAgIAkJCQkgdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGVu
ZCwKPj4+IC0JCQkJIHVpbnQ2NF90IGRzdCwgdWludDY0X3QgZmxhZ3MpCj4+PiArCQkJCSB1aW50
NjRfdCBkc3QsIHVpbnQ2NF90IGZsYWdzLAo+Pj4gKwkJCQkgc3RydWN0IGxpc3RfaGVhZCAqaGVh
ZCkKPj4+ICAgewo+Pj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwYXJhbXMtPmFk
ZXY7Cj4+PiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNvciBjdXJzb3I7Cj4+PiBAQCAtMTUz
OSw3ICsxNTQ1LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFt
ZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4+PiAgIAkJCSAqIGNvbXBsZXRlbHkgY292
ZXJlZCBieSB0aGUgcmFuZ2UgYW5kIHNvIHBvdGVudGlhbGx5IHN0aWxsIGluIHVzZS4KPj4+ICAg
CQkJICovCj4+PiAgIAkJCXdoaWxlIChjdXJzb3IucGZuIDwgZnJhZ19zdGFydCkgewo+Pj4gLQkJ
CQlhbWRncHVfdm1fZnJlZV9wdHMoYWRldiwgcGFyYW1zLT52bSwgJmN1cnNvcik7Cj4+PiArCQkJ
CWFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCBwYXJhbXMtPnZtLCAmY3Vyc29yLCBoZWFkKTsKPj4+
ICAgCQkJCWFtZGdwdV92bV9wdF9uZXh0KGFkZXYsICZjdXJzb3IpOwo+Pj4gICAJCQl9Cj4+PiAg
IEBAIC0xNTgzLDYgKzE1ODksNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFw
cGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAgCXN0cnVjdCBhbWRncHVfdm1f
dXBkYXRlX3BhcmFtcyBwYXJhbXM7Cj4+PiAgIAllbnVtIGFtZGdwdV9zeW5jX21vZGUgc3luY19t
b2RlOwo+Pj4gICAJaW50IHI7Cj4+PiArCXN0cnVjdCBsaXN0X2hlYWQgaGVhZDsKPj4+ICAgICAJ
bWVtc2V0KCZwYXJhbXMsIDAsIHNpemVvZihwYXJhbXMpKTsKPj4+ICAgCXBhcmFtcy5hZGV2ID0g
YWRldjsKPj4+IEBAIC0xNTkwLDYgKzE1OTcsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191
cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAgCXBhcmFtcy5k
aXJlY3QgPSBkaXJlY3Q7Cj4+PiAgIAlwYXJhbXMucGFnZXNfYWRkciA9IHBhZ2VzX2FkZHI7Cj4+
PiAgICsJSU5JVF9MSVNUX0hFQUQoJmhlYWQpOwo+Pj4gKwo+Pj4gICAJLyogSW1wbGljaXRseSBz
eW5jIHRvIGNvbW1hbmQgc3VibWlzc2lvbnMgaW4gdGhlIHNhbWUgVk0gYmVmb3JlCj4+PiAgIAkg
KiB1bm1hcHBpbmcuIFN5bmMgdG8gbW92aW5nIGZlbmNlcyBiZWZvcmUgbWFwcGluZy4KPj4+ICAg
CSAqLwo+Pj4gQEAgLTE2MTcsMTMgKzE2MjYsMjIgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9f
dXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+PiAgIAlpZiAocikK
Pj4+ICAgCQlnb3RvIGVycm9yX3VubG9jazsKPj4+ICAgLQlyID0gYW1kZ3B1X3ZtX3VwZGF0ZV9w
dGVzKCZwYXJhbXMsIHN0YXJ0LCBsYXN0ICsgMSwgYWRkciwgZmxhZ3MpOwo+Pj4gKwlyID0gYW1k
Z3B1X3ZtX3VwZGF0ZV9wdGVzKCZwYXJhbXMsIHN0YXJ0LCBsYXN0ICsgMSwgYWRkciwgZmxhZ3Ms
ICZoZWFkKTsKPj4+ICAgCWlmIChyKQo+Pj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwo+Pj4gICAg
IAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKPj4+ICAgICBl
cnJvcl91bmxvY2s6Cj4+PiArCXdoaWxlICghbGlzdF9lbXB0eSgmaGVhZCkpIHsKPj4+ICsJCXN0
cnVjdCBhbWRncHVfdm1fcHQgKmVudHJ5ID0gbGlzdF9maXJzdF9lbnRyeSgmaGVhZCwKPj4+ICsJ
CQkJc3RydWN0IGFtZGdwdV92bV9wdCwgYmFzZS52bV9zdGF0dXMpOwo+Pj4gKwkJbGlzdF9kZWwo
JmVudHJ5LT5iYXNlLnZtX3N0YXR1cyk7Cj4+PiArCj4+PiArCQlhbWRncHVfYm9fdW5yZWYoJmVu
dHJ5LT5iYXNlLmJvLT5zaGFkb3cpOwo+Pj4gKwkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFz
ZS5ibyk7Cj4+PiArCX0KPj4gTWF5YmUgcHV0IHRoYXQgaW50byBhIHNlcGFyYXRlIGZ1bmN0aW9u
Lgo+Pgo+Pj4gKwo+Pj4gICAJYW1kZ3B1X3ZtX2V2aWN0aW9uX3VubG9jayh2bSk7Cj4+PiAgIAly
ZXR1cm4gcjsKPj4+ICAgfQo+Pj4gQEAgLTMxMTgsNyArMzEzNiw3IEBAIHZvaWQgYW1kZ3B1X3Zt
X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtKQo+
Pj4gICAJCWFtZGdwdV92bV9mcmVlX21hcHBpbmcoYWRldiwgdm0sIG1hcHBpbmcsIE5VTEwpOwo+
Pj4gICAJfQo+Pj4gICAtCWFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCB2bSwgTlVMTCk7Cj4+PiAr
CWFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCB2bSwgTlVMTCwgTlVMTCk7Cj4+IEFuZCB0aGVuIGFs
c28gY2FsbCBpdCBoZXJlLgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+PiAgIAlh
bWRncHVfYm9fdW5yZXNlcnZlKHJvb3QpOwo+Pj4gICAJYW1kZ3B1X2JvX3VucmVmKCZyb290KTsK
Pj4+ICAgCVdBUk5fT04odm0tPnJvb3QuYmFzZS5ibyk7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
