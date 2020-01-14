Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ADC33CB6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD7D24672
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AQpD8WgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD7D24672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1201389F07;
	Tue, 14 Jan 2020 16:12:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3AB89F07
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 16:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+HNeDqyi3h1LtgQONnjwnz1EHnBfAndpf1mV4TMmDdJBGXcKh7y2xtdNBzEb0oa534S/rs0A42o7wVpQp3IiPL+xWZLzMepHoWfSQWqNP2Les2JXm5/bSF4x3HdYxtzAjy1sbHd9z++w+s3P5fGpsmVJn42H/HwVZqWrmjcBceTDb5thYfroMJUchODZOTAbTnmCm8aOD+ANtAKVFF01bDhV6LKr7ep03B3uHoc94Pjjy0XR29QhW8sw3zG4JEyh6r8Y0aS0SJi1opiPzYZyOuS2u+hDsKjA/JRZDMBMic89+FvgvUhkkHsy6nGKlBB2UQQPiEtdKb222Ov/ho0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K92BZwF4meCP7Z3cGEUXFndmBhwv8AUOjfBWxpa/hqg=;
 b=RgAtv4uGHDE/e+W3BwySL9HBb2b52SgpuA0/Y3QZBc2ALxHRUAAjqANAsbZBFjvIUyGuFjyqBYfrtz5FTT4HpIxS+LDciBchrvP9ACEGFAxGVJ4YWZJgOax0zNn1ZW8v1wDvstF+fLKg+R5LCovUF/s8reSdAuxWxdohb2OW95ISqe7pUQZvDvu6tynXoJ34bmn5LxSf9jbeyv7ZhoRdaiLpWMOpGojyqW7uLqWbiqtB5Hv66JbjAOCJyWIf/LJu7TtTOyx3sVUUAmMQ6KWbZGnBEB09dqoXsW5nvZTGqyRhUdD222so7gqScZHN//5NjB4zvb8Ql6yl5YkDVZAh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K92BZwF4meCP7Z3cGEUXFndmBhwv8AUOjfBWxpa/hqg=;
 b=AQpD8WgLUfhfg3Qsa6T9QQHxa9MpAofMLAV/QNw1+TqXGpCJtJObJSFGTxUEtqjJv2G92aV2kxltJyyPi0GKIoQ0hIdzXpPfagP3GmbhtQ4gxtWQs2ik6JG1WhK0lyCaAvytqneRC4uNdS4+Lsj9kd952Teq8xqU3RUFOi6+AfM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB2502.namprd12.prod.outlook.com (52.132.138.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 14 Jan 2020 16:12:39 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 16:12:39 +0000
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
 <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <529f8218-09f4-cb67-7bc0-18a1a808bff6@amd.com>
Date: Tue, 14 Jan 2020 17:13:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0142.eurprd07.prod.outlook.com
 (2603:10a6:207:8::28) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f34:3700:cddf:573f:1071:ae40]
 (2003:c5:8f34:3700:cddf:573f:1071:ae40) by
 AM3PR07CA0142.eurprd07.prod.outlook.com (2603:10a6:207:8::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.11 via Frontend Transport; Tue, 14 Jan 2020 16:12:32 +0000
X-Originating-IP: [2003:c5:8f34:3700:cddf:573f:1071:ae40]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a5fc06e-9cab-48d4-28b1-08d7990c9332
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:|DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB250243BFECCC409D298A2E2C8B340@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(66476007)(31686004)(66556008)(2616005)(81166006)(8936002)(66946007)(5660300002)(36756003)(81156014)(8676002)(6666004)(4326008)(2906002)(52116002)(6486002)(498600001)(31696002)(66574012)(53546011)(16526019)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2502;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aR7KDVqvTGJgFjCdZG9y94TY0hCRaPux/udt2wtKHUmydALqQRLFGMlsUF4OepygzwVpONjm8Bi4Gfb9fA3dwhnZlhXD3ZdMSRzaU0vnPKN1V+zp9+6WSpKcy3jgXYfbpxYIKy649lH3euR9keR0TLGXc0IMyAvgdFs50HxHsbACTq5Al7d4bZnX8zx6s0TBcQMlKPwkbAVqCQ9UdcNHKvrOQuuY8PQPwbRI22BRWvLurKliBkkxPf54nwWi5g+6o2c2oQtxVESJpsb/n1JH4F8L242ld3ug7CiS75hA02kAGNV09bDEMy+bbcyTxVBt9nXFGJ1XyyUWQ/PmTdF+/MMVlvDwLOipgpLUPRuueydReLQOBRJkQsfUbrUza1jGWqBm7EmSgg/zZShkjYKgnIA5sMoM5FfYRGhK5RCX7hf8bthK5ZriVhzG1eV24Ke
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5fc06e-9cab-48d4-28b1-08d7990c9332
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 16:12:38.6538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9PVyI53kRJvjnqORhmkKmYIL7CzSgppxXMBg47jaafShX9cRKw2kzAGAavU9SYqu/4EwAvXMXKqVeZPd4drXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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

Ck9uIDEvMTQvMjAgNTowMSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxNC4wMS4y
MCB1bSAxNjo0MyBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEpvYnMgc3VibWl0dGVkIGluIGFuIGVu
dGl0eSBzaG91bGQgZXhlY3V0ZSBpbiB0aGUgb3JkZXIgdGhvc2Ugam9icwo+PiBhcmUgc3VibWl0
dGVkLiBXZSBtYWtlIHN1cmUgdGhhdCBieSBjaGVja2luZyBlbnRpdHktPmpvYl9xdWV1ZSBpbgo+
PiBkcm1fc2NoZWRfZW50aXR5X3NlbGVjdF9ycSgpIHNvIHRoYXQgd2UgZG9uJ3QgbG9hZGJhbGFu
Y2Ugam9icyB3aXRoaW4KPj4gYW4gZW50aXR5Lgo+Pgo+PiBCdXQgYmVjYXVzZSB3ZSB1cGRhdGUg
ZW50aXR5LT5qb2JfcXVldWUgbGF0ZXIgaW4gCj4+IGRybV9zY2hlZF9lbnRpdHlfcHVzaF9qb2Io
KSwKPj4gdGhlcmUgcmVtYWlucyBhIG9wZW4gd2luZG93IHdoZW4gaXQgaXMgcG9zc2liZSB0aGF0
IGVudGl0eS0+cnEgbWlnaHQgZ2V0Cj4+IHVwZGF0ZWQgYnkgZHJtX3NjaGVkX2VudGl0eV9zZWxl
Y3RfcnEoKSB3aGljaCBzaG91bGQgbm90IGJlIGFsbG93ZWQuCj4KPiBOQUssIGNvbmN1cnJlbnQg
Y2FsbHMgdG8gCj4gZHJtX3NjaGVkX2pvYl9pbml0KCkvZHJtX3NjaGVkX2VudGl0eV9wdXNoX2pv
YigpIGFyZSBub3QgYWxsb3dlZCBpbiAKPiB0aGUgZmlyc3QgcGxhY2Ugb3Igb3RoZXJ3aXNlIHdl
IG1lc3MgdXAgdGhlIGZlbmNlIHNlcXVlbmNlIG9yZGVyIGFuZCAKPiByaXNrIG1lbW9yeSBjb3Jy
dXB0aW9uLgoKPgo+Pgo+PiBDaGFuZ2VzIGluIHRoaXMgcGFydCBhbHNvIGltcHJvdmVzIGpvYiBk
aXN0cmlidXRpb24uCj4+IEJlbG93IGFyZSB0ZXN0IHJlc3VsdHMgYWZ0ZXIgcnVubmluZyBhbWRn
cHVfdGVzdCBmcm9tIG1lc2EgZHJtCj4+Cj4+IEJlZm9yZSB0aGlzIHBhdGNoOgo+Pgo+PiBzY2hl
ZF9uYW1lwqDCoMKgwqAgbnVtIG9mIG1hbnkgdGltZXMgaXQgZ290IHNjaGVkdWxlZAo+PiA9PT09
PT09PT3CoMKgwqDCoMKgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4gc2Rt
YTDCoMKgwqDCoMKgwqDCoMKgwqAgMzE0Cj4+IHNkbWExwqDCoMKgwqDCoMKgwqDCoMKgIDMyCj4+
IGNvbXBfMS4wLjDCoMKgwqDCoCA1Ngo+PiBjb21wXzEuMS4wwqDCoMKgwqAgMAo+PiBjb21wXzEu
MS4xwqDCoMKgwqAgMAo+PiBjb21wXzEuMi4wwqDCoMKgwqAgMAo+PiBjb21wXzEuMi4xwqDCoMKg
wqAgMAo+PiBjb21wXzEuMy4wwqDCoMKgwqAgMAo+PiBjb21wXzEuMy4xwqDCoMKgwqAgMAo+Pgo+
PiBBZnRlciB0aGlzIHBhdGNoOgo+Pgo+PiBzY2hlZF9uYW1lwqDCoMKgwqAgbnVtIG9mIG1hbnkg
dGltZXMgaXQgZ290IHNjaGVkdWxlZAo+PiA9PT09PT09PT3CoMKgwqDCoMKgID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KPj4gwqAgc2RtYTHCoMKgwqDCoMKgwqDCoMKgwqAgMjQz
Cj4+IMKgIHNkbWEwwqDCoMKgwqDCoMKgwqDCoMKgIDE2NAo+PiDCoCBjb21wXzEuMC4xwqDCoMKg
wqAgMTQKPj4gwqAgY29tcF8xLjEuMMKgwqDCoMKgIDExCj4+IMKgIGNvbXBfMS4xLjHCoMKgwqDC
oCAxMAo+PiDCoCBjb21wXzEuMi4wwqDCoMKgwqAgMTUKPj4gwqAgY29tcF8xLjIuMcKgwqDCoMKg
IDE0Cj4+IMKgIGNvbXBfMS4zLjDCoMKgwqDCoCAxMAo+PiDCoCBjb21wXzEuMy4xwqDCoMKgwqAg
MTAKPgo+IFdlbGwgdGhhdCBpcyBzdGlsbCByYXRoZXIgbmljZSB0byBoYXZlLCB3aHkgZG9lcyB0
aGF0IGhhcHBlbj8KCkkgdGhpbmsgaXQgaXMgYmVjYXVzZSB3ZSBhcmUgdXBkYXRpbmcgbnVtX2pv
YnMgaW1tZWRpYXRlbHkgYWZ0ZXIgCnNlbGVjdGluZyBhIG5ldyBycS4gUHJldmlvdXNsecKgIHdl
IGRvIHRoYXQgd2F5IGFmdGVyCgpkcm1fc2NoZWRfam9iX2luaXQoKSBpbiBkcm1fc2NoZWRfZW50
aXR5X3B1c2hfam9iKCkuIFRoZSBwcm9ibGVtIGlzIGlmIEkgCmp1c3QgZG8KCkBAIC01NjIsNiAr
NTYyLDcgQEAgaW50IGRybV9zY2hlZF9qb2JfaW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqam9i
LAogwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PRU5UOwogwqAgwqDCoMKgwqDCoCBzY2hl
ZCA9IGVudGl0eS0+cnEtPnNjaGVkOworwqDCoMKgIGF0b21pY19pbmMoJmVudGl0eS0+cnEtPnNj
aGVkLT5udW1fam9icyk7CgogwqBAQCAtNDk4LDcgKzUwNCw2IEBAIHZvaWQgZHJtX3NjaGVkX2Vu
dGl0eV9wdXNoX2pvYihzdHJ1Y3QgCmRybV9zY2hlZF9qb2IgKnNjaGVkX2pvYiwKIMKgwqDCoMKg
wqAgYm9vbCBmaXJzdDsKIMKgIMKgwqDCoMKgwqAgdHJhY2VfZHJtX3NjaGVkX2pvYihzY2hlZF9q
b2IsIGVudGl0eSk7Ci3CoMKgwqAgYXRvbWljX2luYygmZW50aXR5LT5ycS0+c2NoZWQtPm51bV9q
b2JzKTsKCgpudW1fam9icyBnZXRzIG5lZ2F0aXZlIHNvbWV3aGVyZSBkb3duIHRoZSBsaW5lIHNv
bWV3aGVyZS4gSSBhbSBndWVzc2luZ8KgIAppdCdzIGhpdHRpbmcgdGhlIHJhY2UgY29uZGl0aW9u
IGFzIEkgZXhwbGFpbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZQoKClJlZ2FyZHMsCgpOaXJtb3kK
Cj4KPiBDaHJpc3RpYW4uCj4KPj4KPj4gRml4ZXM6IDM1ZTE2MGU3ODFhMDQ4IChkcm0vc2NoZWR1
bGVyOiBjaGFuZ2UgZW50aXRpZXMgcnEgZXZlbiBlYXJsaWVyKQo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+IFJlcG9ydGVkLWJ5OiBQaWVycmUt
RXJpYyBQZWxsb3V4LVByYXllciAKPj4gPHBpZXJyZS1lcmljLnBlbGxvdXgtcHJheWVyQGFtZC5j
b20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5j
IHwgOSArKysrKysrLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWlu
LmPCoMKgIHwgMSArCj4+IMKgIGluY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMSArCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9lbnRpdHkuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX2VudGl0eS5jCj4+IGluZGV4IDJlM2EwNThmYzIzOS4uODQxNGUwODRiNmFjIDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4gQEAgLTY3LDYgKzY3
LDcgQEAgaW50IGRybV9zY2hlZF9lbnRpdHlfaW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAK
Pj4gKmVudGl0eSwKPj4gwqDCoMKgwqDCoCBlbnRpdHktPnByaW9yaXR5ID0gcHJpb3JpdHk7Cj4+
IMKgwqDCoMKgwqAgZW50aXR5LT5zY2hlZF9saXN0ID0gbnVtX3NjaGVkX2xpc3QgPiAxID8gc2No
ZWRfbGlzdCA6IE5VTEw7Cj4+IMKgwqDCoMKgwqAgZW50aXR5LT5sYXN0X3NjaGVkdWxlZCA9IE5V
TEw7Cj4+ICvCoMKgwqAgZW50aXR5LT5sb2FkYmFsYW5jZV9vbiA9IHRydWU7Cj4+IMKgIMKgwqDC
oMKgwqAgaWYobnVtX3NjaGVkX2xpc3QpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRpdHktPnJx
ID0gJnNjaGVkX2xpc3RbMF0tPnNjaGVkX3JxW2VudGl0eS0+cHJpb3JpdHldOwo+PiBAQCAtNDQ3
LDYgKzQ0OCw5IEBAIHN0cnVjdCBkcm1fc2NoZWRfam9iIAo+PiAqZHJtX3NjaGVkX2VudGl0eV9w
b3Bfam9iKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpCj4+IMKgwqDCoMKgwqAgZW50
aXR5LT5sYXN0X3NjaGVkdWxlZCA9IAo+PiBkbWFfZmVuY2VfZ2V0KCZzY2hlZF9qb2ItPnNfZmVu
Y2UtPmZpbmlzaGVkKTsKPj4gwqAgwqDCoMKgwqDCoCBzcHNjX3F1ZXVlX3BvcCgmZW50aXR5LT5q
b2JfcXVldWUpOwo+PiArwqDCoMKgIGlmICghc3BzY19xdWV1ZV9jb3VudCgmZW50aXR5LT5qb2Jf
cXVldWUpKQo+PiArwqDCoMKgwqDCoMKgwqAgZW50aXR5LT5sb2FkYmFsYW5jZV9vbiA9IHRydWU7
Cj4+ICsKPj4gwqDCoMKgwqDCoCByZXR1cm4gc2NoZWRfam9iOwo+PiDCoCB9Cj4+IMKgIEBAIC00
NjMsNyArNDY3LDggQEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X3NlbGVjdF9ycShzdHJ1Y3QgCj4+
IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZG1hX2ZlbmNl
ICpmZW5jZTsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycTsKPj4gwqAgLcKg
wqDCoCBpZiAoc3BzY19xdWV1ZV9jb3VudCgmZW50aXR5LT5qb2JfcXVldWUpIHx8IAo+PiBlbnRp
dHktPm51bV9zY2hlZF9saXN0IDw9IDEpCj4+ICvCoMKgwqAgYXRvbWljX2luYygmZW50aXR5LT5y
cS0+c2NoZWQtPm51bV9qb2JzKTsKPj4gK8KgwqDCoCBpZiAoKGVudGl0eS0+bnVtX3NjaGVkX2xp
c3QgPD0gMSkgfHwgIWVudGl0eS0+bG9hZGJhbGFuY2Vfb24pCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm47Cj4+IMKgIMKgwqDCoMKgwqAgZmVuY2UgPSBSRUFEX09OQ0UoZW50aXR5LT5sYXN0
X3NjaGVkdWxlZCk7Cj4+IEBAIC00NzcsNiArNDgyLDcgQEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5
X3NlbGVjdF9ycShzdHJ1Y3QgCj4+IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGVudGl0eS0+cnEgPSBycTsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgICvCoMKg
wqAgZW50aXR5LT5sb2FkYmFsYW5jZV9vbiA9IGZhbHNlOwo+PiDCoMKgwqDCoMKgIHNwaW5fdW5s
b2NrKCZlbnRpdHktPnJxX2xvY2spOwo+PiDCoCB9Cj4+IMKgIEBAIC00OTgsNyArNTA0LDYgQEAg
dm9pZCBkcm1fc2NoZWRfZW50aXR5X3B1c2hfam9iKHN0cnVjdCAKPj4gZHJtX3NjaGVkX2pvYiAq
c2NoZWRfam9iLAo+PiDCoMKgwqDCoMKgIGJvb2wgZmlyc3Q7Cj4+IMKgIMKgwqDCoMKgwqAgdHJh
Y2VfZHJtX3NjaGVkX2pvYihzY2hlZF9qb2IsIGVudGl0eSk7Cj4+IC3CoMKgwqAgYXRvbWljX2lu
YygmZW50aXR5LT5ycS0+c2NoZWQtPm51bV9qb2JzKTsKPj4gwqDCoMKgwqDCoCBXUklURV9PTkNF
KGVudGl0eS0+bGFzdF91c2VyLCBjdXJyZW50LT5ncm91cF9sZWFkZXIpOwo+PiDCoMKgwqDCoMKg
IGZpcnN0ID0gc3BzY19xdWV1ZV9wdXNoKCZlbnRpdHktPmpvYl9xdWV1ZSwgCj4+ICZzY2hlZF9q
b2ItPnF1ZXVlX25vZGUpOwo+PiDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9tYWluLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9t
YWluLmMKPj4gaW5kZXggM2ZhZDU4NzZhMTNmLi4wMGZkYzM1MDEzNGUgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+IEBAIC01NjIsNiArNTYyLDcgQEAgaW50
IGRybV9zY2hlZF9qb2JfaW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqam9iLAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9FTlQ7Cj4+IMKgIMKgwqDCoMKgwqAgc2NoZWQgPSBlbnRp
dHktPnJxLT5zY2hlZDsKPj4gK8KgwqDCoCBhdG9taWNfaW5jKCZlbnRpdHktPnJxLT5zY2hlZC0+
bnVtX2pvYnMpOwo+PiDCoCDCoMKgwqDCoMKgIGpvYi0+c2NoZWQgPSBzY2hlZDsKPj4gwqDCoMKg
wqDCoCBqb2ItPmVudGl0eSA9IGVudGl0eTsKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2dw
dV9zY2hlZHVsZXIuaCBiL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+PiBpbmRleCA5NmEx
YTFiNzUyNmUuLmE1MTkwODY5ZDMyMyAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9kcm0vZ3B1X3Nj
aGVkdWxlci5oCj4+ICsrKyBiL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+PiBAQCAtOTcs
NiArOTcsNyBAQCBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0
IGRtYV9mZW5jZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqbGFzdF9zY2hlZHVsZWQ7
Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHRhc2tfc3RydWN0wqDCoMKgwqDCoMKgwqAgKmxhc3RfdXNl
cjsKPj4gwqDCoMKgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Rv
cHBlZDsKPj4gK8KgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvYWRi
YWxhbmNlX29uOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBjb21wbGV0aW9uwqDCoMKgwqDCoMKgwqAg
ZW50aXR5X2lkbGU7Cj4+IMKgIH07Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
