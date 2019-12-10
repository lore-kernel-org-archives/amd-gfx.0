Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66891C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 17:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C5320828
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 17:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CClRuwH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C5320828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54866E902;
	Tue, 10 Dec 2019 17:56:24 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7924F6E902
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 17:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbNt7+wDAtwcRJPP6JDLYrFFcWwY80QIBXIdUnMgn15/Lym9F3YNGz5Pw/h30w6i7jkcCglLRthp7o/z85EKx06Nx1eQjaeSEhASB4whKZtVNJUVohLkIdf2Kq5p4xlmOQ28DTVoXrbu340MHYrlETwu/87/jbLDkOoyQFx1RDp8WwAUJfznJihnPMrYNF4naZVZQZYoWt25xKq5Y5EvcjZTemIyJsnL2mkbk29TFhxyMP0zc3F7igIsyDcpefI8OyvSpfh/gWRQW5ZJOuNsdDLSqhTBneBI9wjMMARitWjJSa6sB1uY9fce6BTbpA6U01rjdeJtld6/eMpp8HP6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3clVs0Y2TlzueE0oZ7TIWiI/hyNmfaamQz+xZRvaLck=;
 b=nW+7an/jGlpxcpVNniix6WOeEUX6fnre7gXPOpV+nHWcuzjvxni10aXiXPpZgZrMY2NAiFiKHRaoY22VYY4ELfTPGx9sTe15gV5wV9YYezSXuWjI6eaiS6WF8+Wl0GAs6UCHIUg7rSlEWFr7/kkMpf0STiWmj0OS7X6IlTAnTaAUF0gRn33rWElijqzg578ssR6KDku1WAzam//XMWQA2Lj+CtmqxdNtrHWAiMa/AiD2fTTPgMkjdsiWhTtNwrb1fpKkqsTW3F0Hi4apQhbmyn9k8/edkK9L3zXhM645qnuLai7M/3Ecl/ey52G1vXLoGdfb2o0RVSqFmQ2iMdxCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3clVs0Y2TlzueE0oZ7TIWiI/hyNmfaamQz+xZRvaLck=;
 b=CClRuwH17EJZquZiZTgNB0VC/LyPh2n5hnF9KxcBbO+7DnIxsdk1XHlZoHg+MAnponMIOjITsAEF2OqZe9tnfTP3/ZYY6YZPX8ffDckKw1gvYpl6W2PhwYUX/ZrH6dqL6O3PrxOt9sExGDqD9ytLggzLPEnq+bwtGksaqwPx0Q0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1402.namprd12.prod.outlook.com (10.168.236.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 17:56:21 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 17:56:21 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: modify invalidate semaphore limit in gmc9
To: "Changfeng.Zhu" <changfeng.zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Ray.Huang@amd.com, Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
References: <20191210162008.23482-1-changfeng.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <481d4851-8184-ccc1-708c-2b7ddde9a912@amd.com>
Date: Tue, 10 Dec 2019 18:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191210162008.23482-1-changfeng.zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::22) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3b82e28-6649-4ba5-8016-08d77d9a4347
X-MS-TrafficTypeDiagnostic: DM5PR12MB1402:|DM5PR12MB1402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1402D525A166565FC8E5CD66835B0@DM5PR12MB1402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(316002)(5660300002)(6506007)(2616005)(36756003)(66946007)(2906002)(81156014)(31686004)(6666004)(66556008)(81166006)(6636002)(86362001)(66476007)(8936002)(6512007)(8676002)(478600001)(6486002)(31696002)(52116002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1402;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9u3rmJAR2FzM0PpbwFSbSk+HulEnx8M0O/HYAO/3xxcPf7M5DfDSuVgS4HSgFAOZxZ0eUryxKQiXkRTZPBa0P0NXZvjWhpvGa4p0NpGI33KZL3LS33UaXveeFNgCxdBEZGTd+2lvN6S8b4aMruBbwV8Qmz62xeIeKGjdnnZiyL8WdQV/0gW8A3bPW4GQXvhoeB2WJAT3t0s3XwL10aXxXMc3tyqXunPpq9ozLuD1zHXqNQgh1jIkkqo2dSBx4zsnhAvddWFtqcT20AqUEFZu293xu1T8/7NfaIwxW904mNBFt5rWnK7je6pJdSrjOcAWR/D3q0NiHDC0RHGvyxdRvKSzidj80e0PonvPvlPH84jM3aCZsKCAiHCHaOKwDZBPs0TxUeWiW6vWyKWUFTRFl9FG5nZqMoro08j7FmEOqWinm6B0L2tVjpWJGD7C093
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b82e28-6649-4ba5-8016-08d77d9a4347
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 17:56:20.9466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0AA82P/pNF0aMrkabk7Ls+bXuKouSZ62rpkGu+oJ+qdSbf59zbCmG9eDVUAWQ3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1402
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMTIuMTkgdW0gMTc6MjAgc2NocmllYiBDaGFuZ2ZlbmcuWmh1Ogo+IEZyb206IGNoYW5n
emh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4KPiBJdCBtYXkgZmFpbCB0byBsb2FkIGd1ZXN0
IGRyaXZlciBpbiByb3VuZCAyIG9yIGNhdXNlIFhzdGFydCBwcm9ibGVtCj4gd2hlbiB1c2luZyBp
bnZhbGlkYXRlIHNlbWFwaG9yZSBmb3IgU1JJT1Ygb3IgcGljYXNzby4gU28gaXQgbmVlZHMgYXZv
aWQKPiB1c2luZyBpbnZhbGlkYXRlIHNlbWFwaG9yZSBmb3IgU1JJT1YgYW5kIHBpY2Fzc28uCj4K
PiBDaGFuZ2UtSWQ6IEk4MDZmOGU5OWVjOTdiZTg0ZTZhZWQwZjVjNDk5YTUzYjE5MzFiNDkwCj4g
U2lnbmVkLW9mZi1ieTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCA0NyArKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAyMCBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IGluZGV4
IDYwMTY2NzI0NmExYy4uNTUyZmQ3ZjNmZWM0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jCj4gQEAgLTQxMiw2ICs0MTIsMjcgQEAgc3RhdGljIHVpbnQzMl90IGdtY192
OV8wX2dldF9pbnZhbGlkYXRlX3JlcSh1bnNpZ25lZCBpbnQgdm1pZCwKPiAgIAlyZXR1cm4gcmVx
Owo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBnbWNfdjlfMF91c2VfaW52YWxpZGF0ZV9zZW1hcGhv
cmUgLSBqdWRnZSB3aGV0aGVyIHRvIHVzZSBzZW1hcGhvcmUKPiArICoKPiArICogQGFkZXY6IGFt
ZGdwdV9kZXZpY2UgcG9pbnRlcgo+ICsgKiBAdm1odWI6IHZtaHViIHR5cGUKPiArICoKPiArICov
Cj4gK3N0YXRpYyBib29sIGdtY192OV8wX3VzZV9pbnZhbGlkYXRlX3NlbWFwaG9yZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKPiArCQkJCSAgICAgICB1aW50MzJfdCB2bWh1YikKPiArewo+
ICsJaWYgKCh2bWh1YiA9PSBBTURHUFVfTU1IVUJfMCB8fAo+ICsJICAgICB2bWh1YiA9PSBBTURH
UFVfTU1IVUJfMSkgJiYKPiArCSAgICAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSkgJiYKPiArCSAg
ICAoIShhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SQVZFTiAmJgo+ICsJICAgICAgIGFkZXYtPnJl
dl9pZCA8IDB4OCAmJgo+ICsJICAgICAgIGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDE1ZDgpKSkK
PiArCQlyZXR1cm4gdHJ1ZTsKPiArCWVsc2UKPiArCQlyZXR1cm4gZmFsc2U7CgpQcm9iYWJseSBi
ZXR0ZXIgdG8gbm90IHVzZSBhbiBpZiBoZXJlIGJ1dCBpbnN0ZWFkIGp1c3QgcmV0dXJuIHRoZSB2
YWx1ZS4gCkUuZy4gc29tZXRoaW5nIGxpa2UgdGhpczoKCnJldHVybiAodm1odWIgPT0gQU1ELi4u
Li4gfHwgLi4uLikgJiYKIMKgwqDCoCAuLi4uCgo+ICt9Cj4gKwo+ICAgLyoKPiAgICAqIEdBUlQK
PiAgICAqIFZNSUQgMCBpcyB0aGUgcGh5c2ljYWwgR1BVIGFkZHJlc3NlcyBhcyB1c2VkIGJ5IHRo
ZSBrZXJuZWwuCj4gQEAgLTQzNCw2ICs0NTUsNyBAQCBzdGF0aWMgdm9pZCBnbWNfdjlfMF9mbHVz
aF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCB2bWlkLAo+ICAg
CWNvbnN0IHVuc2lnbmVkIGVuZyA9IDE3Owo+ICAgCXUzMiBqLCB0bXA7Cj4gICAJc3RydWN0IGFt
ZGdwdV92bWh1YiAqaHViOwo+ICsJYm9vbCB2YWx1ZSA9IGdtY192OV8wX3VzZV9pbnZhbGlkYXRl
X3NlbWFwaG9yZShhZGV2LCB2bWh1Yik7CgpQbGVhc2UgdXNlIGEgbW9yZSBtZWFuaW5nZnVsIG5h
bWUgZm9yIHRoZSB2YXJpYWJsZSwgc29tZXRoaW5nIGxpa2UgCnVzZV9zZW1hcGhvcmUuCgpBbmQg
bW92ZSB0aGF0IHRvIHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uLgoKQ2hyaXN0aWFu
LgoKPiAgIAo+ICAgCUJVR19PTih2bWh1YiA+PSBhZGV2LT5udW1fdm1odWJzKTsKPiAgIAo+IEBA
IC00NjQsMTEgKzQ4Niw3IEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX2ZsdXNoX2dwdV90bGIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCj4gICAJICovCj4gICAKPiAg
IAkvKiBUT0RPOiBJdCBuZWVkcyB0byBjb250aW51ZSB3b3JraW5nIG9uIGRlYnVnZ2luZyB3aXRo
IHNlbWFwaG9yZSBmb3IgR0ZYSFVCIGFzIHdlbGwuICovCj4gLQlpZiAoKHZtaHViID09IEFNREdQ
VV9NTUhVQl8wIHx8Cj4gLQkgICAgIHZtaHViID09IEFNREdQVV9NTUhVQl8xKSAmJgo+IC0JICAg
ICghKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1JBVkVOICYmCj4gLQkgICAgICAgYWRldi0+cmV2
X2lkIDwgMHg4ICYmCj4gLQkgICAgICAgYWRldi0+cGRldi0+ZGV2aWNlID09IDB4MTVkOCkpKSB7
Cj4gKwlpZiAodmFsdWUpIHsKPiAgIAkJZm9yIChqID0gMDsgaiA8IGFkZXYtPnVzZWNfdGltZW91
dDsgaisrKSB7Cj4gICAJCQkvKiBhIHJlYWQgcmV0dXJuIHZhbHVlIG9mIDEgbWVhbnMgc2VtYXBo
b3JlIGFjdXFpcmUgKi8KPiAgIAkJCXRtcCA9IFJSRUczMl9OT19LSVEoaHViLT52bV9pbnZfZW5n
MF9zZW0gKyBlbmcpOwo+IEBAIC00OTgsMTEgKzUxNiw3IEBAIHN0YXRpYyB2b2lkIGdtY192OV8w
X2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQs
Cj4gICAJfQo+ICAgCj4gICAJLyogVE9ETzogSXQgbmVlZHMgdG8gY29udGludWUgd29ya2luZyBv
biBkZWJ1Z2dpbmcgd2l0aCBzZW1hcGhvcmUgZm9yIEdGWEhVQiBhcyB3ZWxsLiAqLwo+IC0JaWYg
KCh2bWh1YiA9PSBBTURHUFVfTU1IVUJfMCB8fAo+IC0JICAgICB2bWh1YiA9PSBBTURHUFVfTU1I
VUJfMSkgJiYKPiAtCSAgICAoIShhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SQVZFTiAmJgo+IC0J
ICAgICAgIGFkZXYtPnJldl9pZCA8IDB4OCAmJgo+IC0JICAgICAgIGFkZXYtPnBkZXYtPmRldmlj
ZSA9PSAweDE1ZDgpKSkKPiArCWlmICh2YWx1ZSkKPiAgIAkJLyoKPiAgIAkJICogYWRkIHNlbWFw
aG9yZSByZWxlYXNlIGFmdGVyIGludmFsaWRhdGlvbiwKPiAgIAkJICogd3JpdGUgd2l0aCAwIG1l
YW5zIHNlbWFwaG9yZSByZWxlYXNlCj4gQEAgLTUyNCw2ICs1MzgsNyBAQCBzdGF0aWMgdWludDY0
X3QgZ21jX3Y5XzBfZW1pdF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywK
PiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtaHViICpodWIgPSAmYWRldi0+dm1odWJbcmluZy0+ZnVuY3Mt
PnZtaHViXTsKPiAgIAl1aW50MzJfdCByZXEgPSBnbWNfdjlfMF9nZXRfaW52YWxpZGF0ZV9yZXEo
dm1pZCwgMCk7Cj4gICAJdW5zaWduZWQgZW5nID0gcmluZy0+dm1faW52X2VuZzsKPiArCWJvb2wg
dmFsdWUgPSBnbWNfdjlfMF91c2VfaW52YWxpZGF0ZV9zZW1hcGhvcmUocmluZy0+YWRldiwgcmlu
Zy0+ZnVuY3MtPnZtaHViKTsKPiAgIAo+ICAgCS8qCj4gICAJICogSXQgbWF5IGxvc2UgZ3B1dm0g
aW52YWxpZGF0ZSBhY2tub3dsZGVnZSBzdGF0ZSBhY3Jvc3MgcG93ZXItZ2F0aW5nCj4gQEAgLTUz
MywxMSArNTQ4LDcgQEAgc3RhdGljIHVpbnQ2NF90IGdtY192OV8wX2VtaXRfZmx1c2hfZ3B1X3Rs
YihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4gICAJICovCj4gICAKPiAgIAkvKiBUT0RPOiBJ
dCBuZWVkcyB0byBjb250aW51ZSB3b3JraW5nIG9uIGRlYnVnZ2luZyB3aXRoIHNlbWFwaG9yZSBm
b3IgR0ZYSFVCIGFzIHdlbGwuICovCj4gLQlpZiAoKHJpbmctPmZ1bmNzLT52bWh1YiA9PSBBTURH
UFVfTU1IVUJfMCB8fAo+IC0JICAgICByaW5nLT5mdW5jcy0+dm1odWIgPT0gQU1ER1BVX01NSFVC
XzEpICYmCj4gLQkgICAgKCEoYWRldi0+YXNpY190eXBlID09IENISVBfUkFWRU4gJiYKPiAtCSAg
ICAgICBhZGV2LT5yZXZfaWQgPCAweDggJiYKPiAtCSAgICAgICBhZGV2LT5wZGV2LT5kZXZpY2Ug
PT0gMHgxNWQ4KSkpCj4gKwlpZiAodmFsdWUpCj4gICAJCS8qIGEgcmVhZCByZXR1cm4gdmFsdWUg
b2YgMSBtZWFucyBzZW1hcGhvcmUgYWN1cWlyZSAqLwo+ICAgCQlhbWRncHVfcmluZ19lbWl0X3Jl
Z193YWl0KHJpbmcsCj4gICAJCQkJCSAgaHViLT52bV9pbnZfZW5nMF9zZW0gKyBlbmcsIDB4MSwg
MHgxKTsKPiBAQCAtNTUzLDExICs1NjQsNyBAQCBzdGF0aWMgdWludDY0X3QgZ21jX3Y5XzBfZW1p
dF9mbHVzaF9ncHVfdGxiKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiAgIAkJCQkJICAgIHJl
cSwgMSA8PCB2bWlkKTsKPiAgIAo+ICAgCS8qIFRPRE86IEl0IG5lZWRzIHRvIGNvbnRpbnVlIHdv
cmtpbmcgb24gZGVidWdnaW5nIHdpdGggc2VtYXBob3JlIGZvciBHRlhIVUIgYXMgd2VsbC4gKi8K
PiAtCWlmICgocmluZy0+ZnVuY3MtPnZtaHViID09IEFNREdQVV9NTUhVQl8wIHx8Cj4gLQkgICAg
IHJpbmctPmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMSkgJiYKPiAtCSAgICAoIShhZGV2
LT5hc2ljX3R5cGUgPT0gQ0hJUF9SQVZFTiAmJgo+IC0JICAgICAgIGFkZXYtPnJldl9pZCA8IDB4
OCAmJgo+IC0JICAgICAgIGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDE1ZDgpKSkKPiArCWlmICh2
YWx1ZSkKPiAgIAkJLyoKPiAgIAkJICogYWRkIHNlbWFwaG9yZSByZWxlYXNlIGFmdGVyIGludmFs
aWRhdGlvbiwKPiAgIAkJICogd3JpdGUgd2l0aCAwIG1lYW5zIHNlbWFwaG9yZSByZWxlYXNlCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
