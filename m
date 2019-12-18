Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCF0C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 20:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD90227BF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 20:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mYJBZ9RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD90227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963776EA69;
	Wed, 18 Dec 2019 20:14:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FAF6EA69
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 20:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEuk66sQuZ8I5hFUzhf+M9FvWonFMhFVQMcuFRfwLbr8/BXAspih26D1I0nBnlYs3ww04aK4RBq2KQ9ylHf+0SKibzjLrAW4CdZBySWAfplwF9akjA6NF7ug1eyqnJ+/59VgBJdm/tFqiGYIsByjNnBY2UwsP+GLTBdnT1YmwxhjL9FYdQQkXIlq9g359E/rXQB0JHmIFIz5x0tAn2YUh/JqqTjg2uoaKi9fobnzoFKb96sE1Nb+Svw5JTyipt5kgM+E7oAOPjgyXMyWEmJK4GYtQgrvzEBB27zZ7PbfUnpPZIyH0jSmdc6gwIfwp0aRYRcwVwuIiBl2YnAHXFFqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpLxHF/t7XF1d7m9juqTOowQAQq8poy/hdeD5CVl1iU=;
 b=m6eZLNq4BUXtcZQYg70i/SFYUDdW+3IFUa2tr4zHAw5RmYVZ66Km6vmmBoZ77ntj/dbVlaGDqXV9R/g3kFHd8m27ljU59t4HaIxaruQ0eIaOWs1+3jobFnbDyQKT7yq69Qj/yjjprTL9+a12UYXaVn/uvaSgH34O3+nhCLI0pR4iRTMUhMI0FR5eaVSdA5LhpAVnQXIu0sf+/dSE///MJLPdxUdBrF/bP+y609sp4xsrsuzKdAS6aiyFK13LHd4PISiNvSp8a73WJwEb2hz/suHivcV1jaOEohxsSlmfOcBQ6eZURJWjoMycN56LQkjXpkBU3KLbivi7n97N6B57dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpLxHF/t7XF1d7m9juqTOowQAQq8poy/hdeD5CVl1iU=;
 b=mYJBZ9RMLapwyv7MhixMDqDJuPgzIU+8nGw8uwbJHVkbmh5ZRSOo6X5isoIHhh2XYeWdwRI9V//yjj1fJ0+2K/4nrbCClAUEdcDKf0UT54qmPFk5l1vmdkTZ4rpX4nHa6UZzLlCWk19r14UIRu4nKAajoubtmPPMtOuobBLEgtg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3195.namprd12.prod.outlook.com (20.179.104.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 20:14:31 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 20:14:30 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: update the method to get fb_loc of memory
 training(V2)
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>,
 "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191218085050.28635-1-tianci.yin@amd.com>
 <MN2PR12MB329636BD472939B12B08EFA6A2530@MN2PR12MB3296.namprd12.prod.outlook.com>
 <MN2PR12MB2957F19B488696AF8A61D46A95530@MN2PR12MB2957.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <8a2e22db-989d-2169-eed6-dbe174a4d44d@amd.com>
Date: Wed, 18 Dec 2019 15:14:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <MN2PR12MB2957F19B488696AF8A61D46A95530@MN2PR12MB2957.namprd12.prod.outlook.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::45)
 To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f39d79bf-dd82-43d5-3eee-08d783f6e3cc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3195:|DM6PR12MB3195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31951A7240BF2B3DE65A7CF999530@DM6PR12MB3195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(136003)(39850400004)(189003)(129404003)(199004)(52314003)(54906003)(66946007)(110136005)(31686004)(4326008)(66476007)(66556008)(81156014)(31696002)(81166006)(4001150100001)(36756003)(8676002)(53546011)(2616005)(8936002)(44832011)(2906002)(6506007)(26005)(6486002)(5660300002)(316002)(186003)(478600001)(52116002)(6666004)(6512007)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3195;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MWWZDgUqVgPTkWrgToPk4I1ZH4tiF14Mcr8RRCp6Rt9lcfK0vqscyEBO20eGaNqvTfIotlQ0Wo/cWFR9sHgGX6riMMvgTTrPsb5pQN7rFYwrkEjrvXWMYnfEJ1whwv71VczYYJ4X2oSLRBlLomQyU5gS+TwVJTcBrs+dIntAhWeqzD7AJ9CKU8xbJ2OiJZMAYS4/JTFv1E2m1aprOtAacsORajs0Gi0FpO1rk/OvqAuepdaHzRP5CYY+UMpsQZgAWVQ9yskbXiDouiambdnH6OQbQPviuOl1DbHqX3Y0ySMifCa3weytwhJzEyCgaUKNVHnYxMjwfk7nW8rbBbHVYyg4/H8sbtN/4L38YzBdbgq51//VBCNBjrgOlBcpeO1KBkXV+/7I0UNcycOb/6G4McQXVIn76aZ1N72viT6qiUjWf7kBAw6yV1tw6XrKG5la7+Uls+n/kE/bULAKoPOD3LPF+yj4NzZrzGx5dX9v0H3cobYeoquNjF27KRI69BvPzTgl70bf7hN27p553YImA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39d79bf-dd82-43d5-3eee-08d783f6e3cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 20:14:30.6879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUbuL8CljvGvqXA3SOnpOpFXkVt3NTeegCHTTpBVJnjCCK3uPZXug2JDrf3KN99c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3195
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMi0xOCA0OjE0IGEubS4sIFlpbiwgVGlhbmNpIChSaWNvKSB3cm90ZToKPiBIaSBL
ZXZpbiwKPiAKPiBZb3UgbWVhbiBsaWtlIHRoaXM/IEl0J3MgYSBiaXQgbGVuZ3RoeS4KPiAtIGN0
eC0+YzJwX3RyYWluX2RhdGFfb2Zmc2V0ICY9IH4oT05FX01pQiAtIDEpOwo+ICsgY3R4LT5jMnBf
dHJhaW5fZGF0YV9vZmZzZXQgPSBBTElHTihjdHgtPmMycF90cmFpbl9kYXRhX29mZnNldCwgT05F
X01pQik7Cj4gCj4gLcKgwqDCoMKgwqDCoCBjdHgtPmMycF90cmFpbl9kYXRhX29mZnNldCA9IGFk
ZXYtPmZ3X3ZyYW1fdXNhZ2UubWVtX3RyYWluX2ZiX2xvYzsKPiArwqDCoMKgwqDCoMKgIGN0eC0+
YzJwX3RyYWluX2RhdGFfb2Zmc2V0ID0gYWRldi0+Z21jLm1jX3ZyYW1fc2l6ZTsKPiArwqDCoMKg
wqDCoMKgIGlmICgoY3R4LT5jMnBfdHJhaW5fZGF0YV9vZmZzZXQgJiAoT05FX01pQiAtIDEpKSA8
ICg0ICogT05FX0tpQiArIDEpICkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0
eC0+YzJwX3RyYWluX2RhdGFfb2Zmc2V0IC09IE9ORV9NaUI7Cj4gK8KgwqDCoMKgwqDCoCB9Cj4g
K8KgwqDCoMKgwqDCoCBjdHgtPmMycF90cmFpbl9kYXRhX29mZnNldCAmPSB+KE9ORV9NaUIgLSAx
KTsKClVzaW5nIHRoZSBtYWNybyBBTElHTigpIGlzIGEgZ29vZCBwcmFjdGljZS4KVXN1YWxseSB3
aGVuIGNhbGN1bGF0aW5nIGEgcXVhbnRpdHksIHN1Y2ggYXMgdGhlIG9uZSBhYm92ZSwgeW91J2QK
dXNlIGEgd29ya2luZyB2YXJpYWJsZSwgc2F5ICdhJywgYW5kIGFmdGVyIHlvdSdyZSBkb25lIHdp
dGgKdGhlIGNhbGN1bGF0aW9uLCB5b3UnZCB0aGVuIGFzc2lnbiBpdCB0byB0aGUgdmFyaWFibGUg
d2hpY2gKbmVlZHMgaXQuIFNvbWV0aGluZyBsaWtlIHRoaXM6CgphID0gYWRldi0+Z21jLm1jX3Zy
YW1fc2l6ZTsKaWYgKChhICYgKE9ORV9NaUIgLSAxKSkgPCAoNCAqIE9ORV9LaUIgKyAxKSkKCWEg
LT0gT05FX01pQjsKY3R4LT5jMnBfdHJhaW5fZGF0YV9vZmZzZXQgPSBBTElHTihhLCBPTkVfTWlC
KTsKClRoZSBlYXNpZXN0IHdheSB0byBzZWUgdGhpcyBpcywgaW1hZ2luZSwgaWYgYWxsIHRoaXMg
Y2FsY3VsYXRpb24Kd2FzIG9mZmxvYWRlZCB0byBhIGRlZGljYXRlZCBmdW5jdGlvbiwgZigpLCB0
byBkbzoKCmN0eC0+YzJwX3RyYWluX2RhdGFfb2Zmc2V0ID0gZihhZGV2LT5nbWMubWNfdnJhbV9z
aXplKTsKCk5vdywgYnkgdXNpbmcgdGhlIHdvcmtpbmcgdmFyaWFibGUgJ2EnLCB5b3UndmUgc2hv
d24gdGhpcwphYnN0cmFjdGlvbiBqdXN0IHRoZSBzYW1lLiAoQnkgdXNpbmcgdGhlIHdvcmtpbmcg
dmFyaWFibGUgJ2EnLAp5b3UndmUgc2hvd24gdG8gdGhlIHJlYWRlcix0aGF0IHRoaXMgY2FsY3Vs
YXRpb24gaXMgYWJzdHJhY3RlZCwKYW5kIGNvdWxkIGJlIHJlbG9jYXRlZCB0byBhIGZ1bmN0aW9u
LikKClJlZ2FyZHMsCkx1YmVuClAuUy4gVGhlIGNvbXBpbGVyIGlzIHByb2JhYmx5IGFscmVhZHkg
ZG9pbmcgdGhpcywgYW5kIG5vdCB3b3JraW5nCmRpcmVjdGx5IG9uIHRoZSBjdHgtPmMycF90cmFp
bl9kYXRhX29mZnMsIGJ1dCBhc3NpZ25zIGEgZmluYWwKcmVzdWx0LCBhcyBleHBsaWNpdGx5IHNo
b3duIGFib3ZlLiBUaGUgYWJvdmUgaXMgdG8gbWFrZSBpdCBlYXN5CmZvciBodW1hbnMgdG8gcmVh
ZCBhbmQgdW5kZXJzdGFuZCB0aGUgY29kZS4gSG9wZSB0aGlzIGhlbHBzLgoKPiAKPiAqW2tldmlu
XToqCj4gKmknZCBsaWtlIHRvIHVzZSB0aGUgbWFyY28gQUxJR04oKSB0byBzaW1wbGUgYWJvdmUg
Y29kZS4qCj4gKmFueXdheSwgdGhlIHBhdGNoIFJldmlld2VkLWJ5OiBLZXZpbiBXYW5nIDxrZXZp
bjEud2FuZ0BhbWQuY29tPioKPiAKPiDCoMKgwqDCoMKgwqDCoMKgIGN0eC0+cDJjX3RyYWluX2Rh
dGFfb2Zmc2V0ID0gKGFkZXYtPmdtYy5tY192cmFtX3NpemUgLSBHRERSNl9NRU1fVFJBSU5JTkdf
T0ZGU0VUKTsKPiDCoMKgwqDCoMKgwqDCoMKgIGN0eC0+dHJhaW5fZGF0YV9zaXplID0gR0REUjZf
TUVNX1RSQUlOSU5HX0RBVEFfU0laRV9JTl9CWVRFUzsKPiDCoAo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHRtLmgKPiBpbmRleCBmMWViZDQyNDUxMGMuLjE5ZWIzZTg0NTZjNyAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmgKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmgKPiBAQCAtNjYsNiAr
NjYsMTMgQEAgc3RydWN0IGFtZGdwdV9jb3B5X21lbSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCB1bnNp
Z25lZCBsb25nwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldDsKPiDC
oH07Cj4gwqAKPiArLyogRGVmaW5pdGlvbnMgZm9yIGNvbnN0YW5jZSAqLwo+ICtlbnVtIGFtZGdw
dV9pbnRlcm5hbF9jb25zdGFudHMKPiArewo+ICvCoMKgwqDCoMKgwqAgT05FX0tpQiA9IDB4NDAw
LAo+ICvCoMKgwqDCoMKgwqAgT05FX01pQiA9IDB4MTAwMDAwLAo+ICt9Owo+ICsKPiDCoGV4dGVy
biBjb25zdCBzdHJ1Y3QgdHRtX21lbV90eXBlX21hbmFnZXJfZnVuYyBhbWRncHVfZ3R0X21ncl9m
dW5jOwo+IMKgZXh0ZXJuIGNvbnN0IHN0cnVjdCB0dG1fbWVtX3R5cGVfbWFuYWdlcl9mdW5jIGFt
ZGdwdV92cmFtX21ncl9mdW5jOwo+IMKgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9hdG9tZmlybXdhcmUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9h
dG9tZmlybXdhcmUuaAo+IGluZGV4IGRkN2NiYzAwYTBhYS4uNzAxNDY1MTgxNzRjIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hdG9tZmlybXdhcmUuaAo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hdG9tZmlybXdhcmUuaAo+IEBAIC02NzIsMjAg
KzY3Miw2IEBAIHN0cnVjdCB2cmFtX3VzYWdlYnlmaXJtd2FyZV92Ml8xCj4gwqDCoCB1aW50MTZf
dMKgIHVzZWRfYnlfZHJpdmVyX2luX2tiOwo+IMKgfTsKPiDCoAo+IC0vKiBUaGlzIGlzIHBhcnQg
b2YgdnJhbV91c2FnZWJ5ZmlybXdhcmVfdjJfMSAqLwo+IC1zdHJ1Y3QgdnJhbV9yZXNlcnZlX2Js
b2NrCj4gLXsKPiAtwqDCoMKgwqDCoMKgIHVpbnQzMl90IHN0YXJ0X2FkZHJlc3NfaW5fa2I7Cj4g
LcKgwqDCoMKgwqDCoCB1aW50MTZfdCB1c2VkX2J5X2Zpcm13YXJlX2luX2tiOwo+IC3CoMKgwqDC
oMKgwqAgdWludDE2X3QgdXNlZF9ieV9kcml2ZXJfaW5fa2I7Cj4gLX07Cj4gLQo+IC0vKiBEZWZp
bml0aW9ucyBmb3IgY29uc3RhbmNlICovCj4gLWVudW0gYXRvbWZpcm13YXJlX2ludGVybmFsX2Nv
bnN0YW50cwo+IC17Cj4gLcKgwqDCoMKgwqDCoCBPTkVfS2lCID0gMHg0MDAsCj4gLcKgwqDCoMKg
wqDCoCBPTkVfTWlCID0gMHgxMDAwMDAsCj4gLX07Cj4gwqAKPiDCoC8qCj4gwqDCoCAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioKPiAtLSAKPiAyLjE3LjEKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
