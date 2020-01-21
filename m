Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CE9C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 13:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1385921569
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 13:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NJiPdoyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1385921569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD8D56ECE8;
	Tue, 21 Jan 2020 13:18:52 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690065.outbound.protection.outlook.com [40.107.69.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3136ECE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 13:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5QGhVI6OaYWxqhEsumbYvKjJ1asOSpdNcHuJ2+1wg5tTMjlYz7st86Hxx9gfdDyYaGV9UR5GNlKPZDZh184A5yfoWuBzw2PyN+I3GqQ0wWUUlvTZ7sYT1p3YpP0nLcdnrlaj5E2fDOaMHIGF8yALEDnM/YXD1GNd3uujFg7H2qowAiquIg4GHeNfR6uj7hVG2Ew4Sg7XoLN0wS6nEt+pD2shS0596/00qlU/y3zk2UVLKbIbTMmzfHsztEJ+Z5tS6/WoKRutjzJKWyX6Y0L3ni0BO+RK9dvVdDkILE1gCXDrYpdWyeJT17k7o98sdz1BwyJ7RK1f03rpdx6eGN8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4+1CaIyLUTLeItQV+cHR1X7BjZ6xhhRGPXy0bQ77yc=;
 b=lEtMl5xDlCm4hDhGnTcGOHiUai2dSKgHDspqsjQDHBrgJT8oj6aQD1I1M9SMZjCl3NgNSsLYypu/v3xE+IH4pigAz0NP4OhZqapxL5B/yrMT8ipLu3wBXIHoETI0tkkJ2tCKMorPwe9k/1eszlPU2qPcFreC0IdCss8EJPinTPC73CcmeayrW9UECv5l7utCKsYOr8LeYBHOu0MAZ1SXOmuttsKd4DEep2e1wejkozhT5AkpG1SxBwW5qTZsVB+VsypCRQ8w98lH8l0mUcjAXn9AhTZXPoVbLcR8TvV+QWGzxdW7XbUnOHI+1W/PZhZa6EOPTcavuk+XEb9Ju56uSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4+1CaIyLUTLeItQV+cHR1X7BjZ6xhhRGPXy0bQ77yc=;
 b=NJiPdoyo4SvxsRpBI3ODGN4ij1tKFeRdRnEmdPwscAhnUS+vdKqh6OJf5SsXmXLcd+oJqbhEez83qN7BIPqGxBy1x8SrIEPEBlFSi9ZzPtiRLineMYycW6gvrzWTiBf37IP8ZnT1wyQqf77hE/9d1oq4WTR5M6kpt1DLighnU5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1867.namprd12.prod.outlook.com (10.175.88.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 13:18:49 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 13:18:48 +0000
Subject: Re: [PATCH] drm/amdgpu: individualize fence allocation per entity
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200121130537.25156-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0b20b232-e74a-376e-27a7-ee38c3404cc3@amd.com>
Date: Tue, 21 Jan 2020 14:18:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200121130537.25156-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Tue, 21 Jan 2020 13:18:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 471d9db5-eeb3-4527-b0f6-08d79e747311
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:|DM5PR12MB1867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1867403DC2FAB18E1D198951830D0@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(6486002)(4326008)(31686004)(66946007)(8676002)(36756003)(81156014)(5660300002)(8936002)(66574012)(316002)(66556008)(66476007)(478600001)(31696002)(81166006)(6666004)(86362001)(2616005)(52116002)(186003)(2906002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1867;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErWPKYHOhABgU5va1oEnIKvnQqhpza+ZGiYj12oISYbuptxP5X0OEwfg/e5SsZ0t+GhO6zhRiXnz5ho/f9esURzi4zvzkljzIekeDnen1R6BhL7uy1ELkqBM4vsNslFOZUkRD6ujcZea1YgIxXGBQaH38sneBJm/LR+KtE3/W2bmrKq+oFAHd5hn5rhiTE971FfMzlkS4t3HC+8IAg4ZlpIAPLD9P0jpIOGA0A0iA6VPGpcVxFZtapRiW3d15enH1kR6NVAaGLsgvpwSiPyDCLyNxyE80wv6PdzkX1KwRoSmdo524NSAXCDgfuT9HwYN6SatmH/pB57oZcXvIwqTkLG7QA9qnJzdioNRUDDoNrhhB8L7cHGtokEtVO3Odlap79sQwDmp9/vF5FwL02ARMsx2CV8HJIv9ZYjnrokME/TxBWSRLXL3/5ezCHzqwK1e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471d9db5-eeb3-4527-b0f6-08d79e747311
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 13:18:48.3457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rbijOCVbjuFR3Z4q4KAONgZVHh+EQA8glVQs36tRLp6l0xjj8gR99yEsghYXV0x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDEuMjAgdW0gMTQ6MDUgc2NocmllYiBOaXJtb3kgRGFzOgo+IEFsbG9jYXRlIGZlbmNl
cyBmb3IgZWFjaCBlbnRpdHkgYW5kIHJlbW92ZSBjdHgtPmZlbmNlcyByZWZlcmVuY2UgYXMKPiBm
ZW5jZXMgc2hvdWxkIGJlIGJvdW5kIHRvIGFtZGdwdV9jdHhfZW50aXR5IGluc3RlYWQgYW1kZ3B1
X2N0eC4KPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4K
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDQzICsr
KysrKysrKysrKysrKy0tLS0tLS0tLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguaCB8ICAxIC0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwg
MTggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5j
Cj4gaW5kZXggNjRlMmJhYmJjMzZlLi5hOWI2MTFmZDYyNDIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gQEAgLTg3LDI0ICs4NywyNCBAQCBzdGF0aWMgaW50
IGFtZGdwdV9jdHhfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAltZW1zZXQo
Y3R4LCAwLCBzaXplb2YoKmN0eCkpOwo+ICAgCWN0eC0+YWRldiA9IGFkZXY7Cj4gICAKPiAtCWN0
eC0+ZmVuY2VzID0ga2NhbGxvYyhhbWRncHVfc2NoZWRfam9icyAqIG51bV9lbnRpdGllcywKPiAt
CQkJICAgICAgc2l6ZW9mKHN0cnVjdCBkbWFfZmVuY2UqKSwgR0ZQX0tFUk5FTCk7Cj4gLQlpZiAo
IWN0eC0+ZmVuY2VzKQo+IC0JCXJldHVybiAtRU5PTUVNOwo+ICAgCj4gICAJY3R4LT5lbnRpdGll
c1swXSA9IGtjYWxsb2MobnVtX2VudGl0aWVzLAo+ICAgCQkJCSAgIHNpemVvZihzdHJ1Y3QgYW1k
Z3B1X2N0eF9lbnRpdHkpLAo+ICAgCQkJCSAgIEdGUF9LRVJORUwpOwo+IC0JaWYgKCFjdHgtPmVu
dGl0aWVzWzBdKSB7Cj4gLQkJciA9IC1FTk9NRU07Cj4gLQkJZ290byBlcnJvcl9mcmVlX2ZlbmNl
czsKPiAtCX0KPiArCWlmICghY3R4LT5lbnRpdGllc1swXSkKPiArCQlyZXR1cm4gLUVOT01FTTsK
PiArCj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwgbnVtX2VudGl0aWVzOyArK2kpIHsKPiAgIAkJ
c3RydWN0IGFtZGdwdV9jdHhfZW50aXR5ICplbnRpdHkgPSAmY3R4LT5lbnRpdGllc1swXVtpXTsK
PiAgIAo+ICAgCQllbnRpdHktPnNlcXVlbmNlID0gMTsKPiAtCQllbnRpdHktPmZlbmNlcyA9ICZj
dHgtPmZlbmNlc1thbWRncHVfc2NoZWRfam9icyAqIGldOwo+ICsJCWVudGl0eS0+ZmVuY2VzID0g
a2NhbGxvYyhhbWRncHVfc2NoZWRfam9icywKPiArCQkJCQkgc2l6ZW9mKHN0cnVjdCBkbWFfZmVu
Y2UqKSwgR0ZQX0tFUk5FTCk7Cj4gKwkJaWYgKCFlbnRpdHktPmZlbmNlcykgewo+ICsJCQlyID0g
LUVOT01FTTsKPiArCQkJZ290byBlcnJvcl9jbGVhbnVwX21lbW9yeTsKPiArCQl9Cj4gICAJfQo+
ICAgCWZvciAoaSA9IDE7IGkgPCBBTURHUFVfSFdfSVBfTlVNOyArK2kpCj4gICAJCWN0eC0+ZW50
aXRpZXNbaV0gPSBjdHgtPmVudGl0aWVzW2kgLSAxXSArCj4gQEAgLTE4MSwxMSArMTgxLDE2IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+
ICAgZXJyb3JfY2xlYW51cF9lbnRpdGllczoKPiAgIAlmb3IgKGkgPSAwOyBpIDwgbnVtX2VudGl0
aWVzOyArK2kpCj4gICAJCWRybV9zY2hlZF9lbnRpdHlfZGVzdHJveSgmY3R4LT5lbnRpdGllc1sw
XVtpXS5lbnRpdHkpOwo+IC0Ja2ZyZWUoY3R4LT5lbnRpdGllc1swXSk7Cj4gICAKPiAtZXJyb3Jf
ZnJlZV9mZW5jZXM6Cj4gLQlrZnJlZShjdHgtPmZlbmNlcyk7Cj4gLQljdHgtPmZlbmNlcyA9IE5V
TEw7Cj4gK2Vycm9yX2NsZWFudXBfbWVtb3J5Ogo+ICsJZm9yIChpID0gMDsgaSA8IG51bV9lbnRp
dGllczsgKytpKSB7Cj4gKwkJc3RydWN0IGFtZGdwdV9jdHhfZW50aXR5ICplbnRpdHkgPSAmY3R4
LT5lbnRpdGllc1swXVtpXTsKPiArCQlrZnJlZShlbnRpdHktPmZlbmNlcyk7Cj4gKwkJZW50aXR5
LT5mZW5jZXMgPSBOVUxMOwoKRW1wdHkgbGluZSBiZXR3ZWVuIGRlY2xhcmF0aW9uIGFuZCBjb2Rl
IHBsZWFzZS4KCkFwYXJ0IGZyb20gdGhhdCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+ICsJfQo+ICsKPiArCWtm
cmVlKGN0eC0+ZW50aXRpZXNbMF0pOwo+ICsJY3R4LT5lbnRpdGllc1swXSA9IE5VTEw7Cj4gICAJ
cmV0dXJuIHI7Cj4gICB9Cj4gICAKPiBAQCAtMTk5LDEyICsyMDQsMTYgQEAgc3RhdGljIHZvaWQg
YW1kZ3B1X2N0eF9maW5pKHN0cnVjdCBrcmVmICpyZWYpCj4gICAJaWYgKCFhZGV2KQo+ICAgCQly
ZXR1cm47Cj4gICAKPiAtCWZvciAoaSA9IDA7IGkgPCBudW1fZW50aXRpZXM7ICsraSkKPiArCWZv
ciAoaSA9IDA7IGkgPCBudW1fZW50aXRpZXM7ICsraSkgewo+ICsJCXN0cnVjdCBhbWRncHVfY3R4
X2VudGl0eSAqZW50aXR5ID0gJmN0eC0+ZW50aXRpZXNbMF1baV07Cj4gKwo+ICAgCQlmb3IgKGog
PSAwOyBqIDwgYW1kZ3B1X3NjaGVkX2pvYnM7ICsraikKPiAtCQkJZG1hX2ZlbmNlX3B1dChjdHgt
PmVudGl0aWVzWzBdW2ldLmZlbmNlc1tqXSk7Cj4gLQlrZnJlZShjdHgtPmZlbmNlcyk7Cj4gLQlr
ZnJlZShjdHgtPmVudGl0aWVzWzBdKTsKPiArCQkJZG1hX2ZlbmNlX3B1dChlbnRpdHktPmZlbmNl
c1tqXSk7Cj4gKwo+ICsJCWtmcmVlKGVudGl0eS0+ZmVuY2VzKTsKPiArCX0KPiAgIAo+ICsJa2Zy
ZWUoY3R4LT5lbnRpdGllc1swXSk7Cj4gICAJbXV0ZXhfZGVzdHJveSgmY3R4LT5sb2NrKTsKPiAg
IAo+ICAgCWtmcmVlKGN0eCk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jdHguaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHgu
aAo+IGluZGV4IDRhZDkwYTQ0ZGMzYy4uYTZjZDlkNGIwNzhjIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguaAo+IEBAIC00Miw3ICs0Miw2IEBAIHN0cnVjdCBhbWRn
cHVfY3R4IHsKPiAgIAl1bnNpZ25lZAkJCXJlc2V0X2NvdW50ZXJfcXVlcnk7Cj4gICAJdWludDMy
X3QJCQl2cmFtX2xvc3RfY291bnRlcjsKPiAgIAlzcGlubG9ja190CQkJcmluZ19sb2NrOwo+IC0J
c3RydWN0IGRtYV9mZW5jZQkJKipmZW5jZXM7Cj4gICAJc3RydWN0IGFtZGdwdV9jdHhfZW50aXR5
CSplbnRpdGllc1tBTURHUFVfSFdfSVBfTlVNXTsKPiAgIAlib29sCQkJCXByZWFtYmxlX3ByZXNl
bnRlZDsKPiAgIAllbnVtIGRybV9zY2hlZF9wcmlvcml0eQkJaW5pdF9wcmlvcml0eTsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
