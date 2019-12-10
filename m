Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A169C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 18:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2711320663
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 18:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kQZ5O0De"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2711320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AD06E902;
	Tue, 10 Dec 2019 18:38:56 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C366E902
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 18:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbknnxB0hiGZJ5dvwBaHr7zlXlS1TkRB54MhdLkKKMwe5/aWxoxQQYOebsGLaiOUY0UcNmtdO6QDmov+42P/v8qXsBwTJDSzg/1tN0f76APEYbms4CNkapmR7DdRVEBdGX12p1mB6j7HNV2D7e5bTRxeH3KcHj0t4PLN3zZJQsciPy5UN0JfKXB8AvtQ6q4oZQ0cdrMecPhr+9WyijyiMmFOb0QYJOQheXqWkylzheV6Gbx17WkKtDpOatxVOOaY0V5rJ3KIBde4Hk8BuPCVlH0Djj4QOePg4Xtk49HuKC5E2fog4oGg6OsS1Cp2gvDvODHrfXyxPlkbki5Y+o0O0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqNnsIZjSZBOTk3dVf0VdXpRfUTfENdo4O2OV4cnBRQ=;
 b=NO6XXgfGSYjnhVoYFA3zAZ5is9c31f7WeBvwPdvlt7BRT2NbUG8jwG2/ZxGI5b4/6VzzAyFalkyt3QIE025V3H7KkEpyEnm58aP6EjoxbPi+qyxNftttRPiIRJV/ttfrPYzYHshU9ZtqonE5/91HVOQG0VH++vL3hkwsVJK6MGffJT2Fc8PF7q7qity0s1hKZ+h+CrklDluvRlN/Ac+ajKl06s+jhgt6RLzlEW9mCzAOknkH4AAEnRv1y5UQ5ajCRSeqQd6amoDL2d4Hen8fTXoeBKqyxsezeW0bgz1KSrgdTSx8Kl9qW8VHFFtGVsEJfv8UUEh8/Mm2gD3wqC/0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqNnsIZjSZBOTk3dVf0VdXpRfUTfENdo4O2OV4cnBRQ=;
 b=kQZ5O0DeCSMkWOMGOJ9GKk1jD9fRctmZZ1pcME/aM66R1mGvivRFZko0n5UP8cx7EiJsWyje4ksff23laXXT1lrv9c7YawWoeax+k4S7QkvspzrXie3NRs6tXKMWQadglGveUn0bNcbFeq2JtS75gvPeSvW97boMgDAl6DwXfms=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1657.namprd12.prod.outlook.com (10.172.38.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 18:38:53 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 18:38:53 +0000
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191210125300.3800-1-nirmoy.das@amd.com>
 <20191210125300.3800-4-nirmoy.das@amd.com>
 <800c29bf-11dd-0ac9-32ad-ef3476f07643@amd.com>
 <97343695-4b6d-1dfb-2c52-e728a7f1736e@amd.com>
 <e5c038e1-9a5b-c37b-832c-4d6c92f2a528@amd.com>
 <a57decbc-9793-067f-dda0-7351643b6317@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <b476f4b1-2581-9f92-7e03-0e5f5f29e06b@amd.com>
Date: Tue, 10 Dec 2019 19:38:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <a57decbc-9793-067f-dda0-7351643b6317@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f2c:cf00:f7ef:6dd5:8f2d:73fd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a615da3-0e71-4845-e1e4-08d77da034a5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:|DM5PR12MB1657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1657779A2307C5769BC3F9288B5B0@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(8936002)(31686004)(2616005)(2906002)(66476007)(186003)(53546011)(6512007)(4326008)(52116002)(6486002)(6506007)(8676002)(31696002)(5660300002)(66556008)(316002)(6636002)(81166006)(81156014)(66946007)(6666004)(36756003)(66574012)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1657;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NovJfIIECIDeiVY0RgNp4vaJEIB8RvrgwvyyyuoYCvGeOL8xcRd3D58qZhFSxW4EUDEl+Sl0LcFJeIJAES7MQaoRdcooS+YkbCaw4nq7GjNvIHaPuyyS2Eg/+GcOoV6Rz1dzQFNO7EuORpbIevw+iJjBLYPLl+BM4DbO9olo4gYlVhG77XohZbHkBtiby5ZoElgCOhGvPmACDEmZWEvmc4rS6WqylDcDH5MUR1Dsk4Pb+2ANHckTzFm17LDHFSdGzws3JOtxEcTtGrUYPTyE99/SOSQNSgIPPtJCu5TZt+ecCGInCnBd1SG94pKizOxhsinJnsMgl6Jl/T9LgGmh1saNNyRVqmBB+dkvTFcGRDibaO4vKo3MATTpW2ZIdIIgv8RNRbJKCQP+a2n6ya5E5mB4lx0DE1S09tslXpajWgv5EgIrl8K9o6u5jaxCnwCW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a615da3-0e71-4845-e1e4-08d77da034a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 18:38:52.9839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ha+lD8+lZRsXCxjA6CJl4kbdJOW6zAbQro6KdOg633HdBmT79ENqTh+eYCeBC8Xt9ZSrjps71cJK6NQcCMbVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEyLzEwLzE5IDY6MzIgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4KPj4+PiBNYXli
ZSBtYWtlIHRoaXMgIm51bV9zY2hlZF9saXN0ID4gMSA/IHNjaGVkX2xpc3QgOiBOVUxMIiB0byBh
dm9pZCAKPj4+PiBhY2NpZGVudGFsbHkgZGVyZWZlcmVuY2luZyBhIHN0YWxlIHBvaW50ZXIgdG8g
dGhlIHN0YWNrLgo+Pj4gRG8geW91IG1lYW4gIm51bV9zY2hlZF9saXN0ID49IDEgPyBzY2hlZF9s
aXN0IDogTlVMTCIKPgo+IE5vLCB0aGUgZW50aXR5LT5zY2hlZF9saXN0IGZpZWxkIHNob3VsZCBi
ZSBOVUxMIHdoZW4gbnVtX3NjaGVkX2xpc3Q9PTEuCj4KPiBXaGVuIG51bV9zY2hlZF9saXN0PT0x
IHRoZSBlbnRpdHktPnNjaGVkX2xpc3Qgc2hvdWxkbid0IGJlIHVzZWQgYW5kIHdlIAo+IGNhbiB1
c2UgYSBkdW1teSBsaXN0IG9uIHRoZSBzdGFjayBhcyBwYXJhbWV0ZXIuIEJ1dCB3ZSBzaG91bGQg
c2V0IHRoZSAKPiBwb2ludGVyIHRvIE5VTEwgaW4gdGhpcyBjYXNlIGp1c3QgdG8gbWFrZSBzdXJl
IHRoYXQgbm9ib2R5IGlzIAo+IGRlcmVmZXJlbmNpbmcgaXQuCk9rYXkgSSB1bmRlcnN0YW5kIG5v
dy4KPgo+Pj4+Cj4+Pj4+IMKgIC3CoMKgwqAgaWYoIWVudGl0eS0+c2NoZWRfbGlzdCkKPj4+Pj4g
LcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+Pj4+PiDCoCDCoMKgwqDCoMKgIGluaXRf
Y29tcGxldGlvbigmZW50aXR5LT5lbnRpdHlfaWRsZSk7Cj4+Pj4+IC0KPj4+Pj4gLcKgwqDCoCBm
b3IgKGkgPSAwOyBpIDwgbnVtX3NjaGVkX2xpc3Q7IGkrKykKPj4+Pj4gLcKgwqDCoMKgwqDCoMKg
IGVudGl0eS0+c2NoZWRfbGlzdFtpXSA9IHNjaGVkX2xpc3RbaV07Cj4+Pj4+IC0KPj4+Pj4gwqDC
oMKgwqDCoCBpZiAobnVtX3NjaGVkX2xpc3QpCj4+Pj4KPj4+PiBUaGF0IGNoZWNrIGNhbiBhY3R1
YWxseSBiZSBkcm9wcGVkIGFzIHdlbGwuIFdlIHJldHVybiAtRUlOVkFMIHdoZW4gCj4+Pj4gdGhl
IG51bV9zY2hlZF9saXN0IGlzIHplcm8uCj4+Pgo+Pj4gVGhpc8KgIG9uZSB0b29rIG1lIHNvbWUg
dGltZSB0byB1bmRlcnN0YW5kLiBTbyB3ZSBkb24ndCByZWFsbHkgcmV0dXJuIAo+Pj4gLUVJTlZB
TCBpZiBudW1fc2NoZWRfbGlzdCA9PSAwCj4+Pgo+Pj4gaWYgKCEoZW50aXR5ICYmIHNjaGVkX2xp
c3QgJiYgKG51bV9zY2hlZF9saXN0ID09IDAgfHwgc2NoZWRfbGlzdFswXSkpKQo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4KPj4+IFRoaXMgaXMg
Y29taW5nIGZyb20gYmVsb3cgcGF0Y2guIEFyZSB3ZSBzdXBwb3NlIHRvIHRvbGVyYXRlIElQcyB3
aXRoIAo+Pj4gdW5pbml0aWFsaXplZCBzY2hlZCBzbyB0aGF0IGN0eCBjcmVhdGlvbiBkb3NuJ3Qg
cmV0dXJuIGVycm9yID8KPgo+IFllcywgZXhhY3RseS4gVGhhdCdzIGludGVudGlvbmFsbHkgdGhp
cyB3YXkuCj4KPiBHUFUgcmVzZXQgc29tZXRpbWVzIHJlc3VsdGVkIGluIHNjaGVkdWxlcnMgYmVp
bmcgZGlzYWJsZWQgYmVjYXVzZSB3ZSAKPiBjb3VsZG4ndCByZS1pbml0IHRoZW0uIEluIHRoaXMg
Y2FzZSB3ZSBoYWQgZW50aXRpZXMgd2l0aCBhbiBlbXB0eSAKPiBzY2hlZHVsZXIgbGlzdC4KPgo+
IFRoYXQgY2FuJ3QgaGFwcGVuIGFueSBtb3JlIGFmdGVyIHlvdSBtYWtlIHRoZSBzY2hlZHVsZXIg
YXJyYXlzIAo+IGNvbnN0YW50LCBidXQgSSB3b3VsZCBzdGljayB3aXRoIHRoYXQgYmVoYXZpb3Iu
CgpTbyBJIHdpbGwga2VlcCB0aGUgY2hlY2suCgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4K
PgpSZWdhcmRzLAoKTmlybW95CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
