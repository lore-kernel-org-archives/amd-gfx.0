Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03730C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 17:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB78E20828
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 17:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L32yW/VQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB78E20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A2F6E900;
	Tue, 10 Dec 2019 17:32:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D866E900
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 17:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihNcNBtXXH8FOrCcFaVXqS7OAgpwo8WFpIa6l06GlT8C8Cb/9YdV14enMb3+grnptKZDEUAqbeP8HZxv9uSMurnqR2ZnUMrVMfponywPkBHLkFWw7OoyaSDeA4q2Zv/k916VDVPA/X2FxqYHwPixXQ5aFWQssieBSeeclgL1iVRebC8wf3dEOhOOq/JeTOhUQsHfAEWk6HgbaOvcAUnfB08ldap899wM3ivzgE79VRtMRzF3MvQWTw+fOYrl171n9gSdZFrmgzQvoBBaKu3jT3CrzmDHqv4Cf0M/b/UFQxd4bhvATNY2SGSwsxT9XOCqZhYbuj37Gm3wlgSTiEw+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMxo9DIPGBxylg3ymlmob34mCKc66t9tHJzEtxSrqBE=;
 b=LEW27T+Jh7/JLMuj3dqYSmJ1+G/uz6aQCEhFjaMQKzL+BG8gsbiIXYCryNYWARygyacQk2JvfB3wZTVlG0bxSBJ6G2KxRsR5IdFfAX2q3aN1UbAqFH4gHoRd45cV4WqhYe7Y0fAYFJ67yNnwWwN2BcJJ2rOoFCW071qDozsOnQCmM4EdRqtN7JiGJQLd5KIhj3eLOT5yUFRNLi1NUWJXTKCWom5ilqH71FnD0n/h3urq/c95wV8wi3OymI3wp/lDSh5of21c1Bv9x7b8KntbD0CJmmeuetPLLsJDC1Y94pUk/pEje1SD3e+i3Px5kO3qJgp9cLXfRXSS/56pXiQUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMxo9DIPGBxylg3ymlmob34mCKc66t9tHJzEtxSrqBE=;
 b=L32yW/VQXnQBGYc4z8qQqKSg0CkZyUqDfD7nRHaRYZUZuiu3KKUCGSi+zcBfVBFRidMTADMQ6sUncmPIGdoN2Q/Q5gs+IpVavjuLpW19V1dpXcHOTTVxPg0ALIiyQisO0G5PmC0VM9pFx968a1bU2FA+tr71K8RNZ2V6zpyp6PM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1804.namprd12.prod.outlook.com (10.175.91.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 17:32:31 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 17:32:31 +0000
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: Nirmoy <nirmodas@amd.com>, alexander.deucher@amd.com, kenny.ho@amd.com
References: <20191210125300.3800-1-nirmoy.das@amd.com>
 <20191210125300.3800-4-nirmoy.das@amd.com>
 <800c29bf-11dd-0ac9-32ad-ef3476f07643@amd.com>
 <97343695-4b6d-1dfb-2c52-e728a7f1736e@amd.com>
 <e5c038e1-9a5b-c37b-832c-4d6c92f2a528@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a57decbc-9793-067f-dda0-7351643b6317@amd.com>
Date: Tue, 10 Dec 2019 18:32:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <e5c038e1-9a5b-c37b-832c-4d6c92f2a528@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0128.eurprd05.prod.outlook.com
 (2603:10a6:207:2::30) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c397af5-9e68-46db-2eb6-08d77d96ef47
X-MS-TrafficTypeDiagnostic: DM5PR12MB1804:|DM5PR12MB1804:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1804E676DBACFAC62CD3EEFB835B0@DM5PR12MB1804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(8676002)(81156014)(81166006)(86362001)(8936002)(31696002)(66574012)(6486002)(5660300002)(6636002)(2616005)(6666004)(4326008)(2906002)(66946007)(53546011)(6506007)(66556008)(6512007)(36756003)(478600001)(66476007)(52116002)(186003)(316002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1804;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ps5fi0Z8hppogsTn1x7lwhJVZz6jcD8p1d8zs2gAMgXO5MQSjZHn8kiSEZ7+V4BLb0zX9Ve1GDY7Lk9dZ5WEofdWQpV04OnS0sjvMPqwNn4NJ7MUxGNEs6iNV8hSXJrw6q2g7zY7p32cGPqwsYVqFwCI2LgBXqJKaPVXCH5g04bI/IlzjZl9gg2hLJRctnJhRECbHY8AV+odGAuuDLL5Xb3LstkR58pk6RJJw0CFGnKuLNF2j7KBjLIKZRY4HYvUKpQGZ4JtRX8HDffKE/fdy/2bMZJFwvJiF0ESnGO6MkSfmkLxSsUxERJBdc4GZCxD8nuM2lgOogKpPR/s2LpMSzfUv1wHS+5aHbIn+2l/lFq42UE9p0dJkBz+azBM2+NRZUtAgweWqu+fHT2m2xY4SNSCHn92e7Rle97Ddf7MRoj6C62rbwNURRn6feF7hEsH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c397af5-9e68-46db-2eb6-08d77d96ef47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 17:32:31.2878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcYkaFTsQAwDMunBzgepw+0r4wq0NUQdtv6/Gp9sniy3igu8G2eT1aiHU8OOBsjg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1804
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

QW0gMTAuMTIuMTkgdW0gMTY6MDggc2NocmllYiBOaXJtb3k6Cj4gSSB0aGluayBhbWRncHVfY3R4
X2luaXQoKSBzaG91bGQgY2hlY2sgZm9yIG51bV9zY2hlZHMgYW5kIG5vdCBjYWxsIAo+IGRybV9z
Y2hlZF9lbnRpdHlfaW5pdCgpCj4KPiBpZiBpdHMgemVyby4KCkFoLCB0aGF0J3Mgd2hlcmUgdGhh
dCBjYW1lIGZyb20uIE5vIHRoYXQgaXMgaW50ZW50aW9uYWxseSB0aGlzIHdheSwgYnV0IApzZWUg
YmVsb3cuCgo+Cj4gT24gMTIvMTAvMTkgMzo0NyBQTSwgTmlybW95IHdyb3RlOgo+Pgo+PiBPbiAx
Mi8xMC8xOSAyOjAwIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQW0gMTAuMTIuMTkg
dW0gMTM6NTMgc2NocmllYiBOaXJtb3kgRGFzOgo+Pj4+IGVudGl0eSBzaG91bGQgbm90IGtlZXAg
Y29weSBhbmQgbWFpbnRhaW4gc2NoZWQgbGlzdCBmb3IKPj4+PiBpdHNlbGYuCj4+Pj4KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+Pj4gLS0tCj4+
Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDEwICstLS0t
LS0tLS0KPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDkgZGVsZXRpb25z
KC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hl
ZF9lbnRpdHkuYyAKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMKPj4+PiBpbmRleCBmOWI2Y2UyOWM1OGYuLmE1ZjcyOWY0MjFmOCAxMDA2NDQKPj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4+IEBAIC02NywxNyArNjcs
MTAgQEAgaW50IGRybV9zY2hlZF9lbnRpdHlfaW5pdChzdHJ1Y3QgCj4+Pj4gZHJtX3NjaGVkX2Vu
dGl0eSAqZW50aXR5LAo+Pj4+IMKgwqDCoMKgwqAgZW50aXR5LT5ndWlsdHkgPSBndWlsdHk7Cj4+
Pj4gwqDCoMKgwqDCoCBlbnRpdHktPm51bV9zY2hlZF9saXN0ID0gbnVtX3NjaGVkX2xpc3Q7Cj4+
Pj4gwqDCoMKgwqDCoCBlbnRpdHktPnByaW9yaXR5ID0gcHJpb3JpdHk7Cj4+Pj4gLcKgwqDCoCBl
bnRpdHktPnNjaGVkX2xpc3QgPcKgIGtjYWxsb2MobnVtX3NjaGVkX2xpc3QsCj4+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaXplb2Yoc3RydWN0IGRybV9n
cHVfc2NoZWR1bGVyICopLCAKPj4+PiBHRlBfS0VSTkVMKTsKPj4+PiArwqDCoMKgIGVudGl0eS0+
c2NoZWRfbGlzdCA9wqAgc2NoZWRfbGlzdDsKPj4+Cj4+PiBNYXliZSBtYWtlIHRoaXMgIm51bV9z
Y2hlZF9saXN0ID4gMSA/IHNjaGVkX2xpc3QgOiBOVUxMIiB0byBhdm9pZCAKPj4+IGFjY2lkZW50
YWxseSBkZXJlZmVyZW5jaW5nIGEgc3RhbGUgcG9pbnRlciB0byB0aGUgc3RhY2suCj4+IERvIHlv
dSBtZWFuICJudW1fc2NoZWRfbGlzdCA+PSAxID8gc2NoZWRfbGlzdCA6IE5VTEwiCgpObywgdGhl
IGVudGl0eS0+c2NoZWRfbGlzdCBmaWVsZCBzaG91bGQgYmUgTlVMTCB3aGVuIG51bV9zY2hlZF9s
aXN0PT0xLgoKV2hlbiBudW1fc2NoZWRfbGlzdD09MSB0aGUgZW50aXR5LT5zY2hlZF9saXN0IHNo
b3VsZG4ndCBiZSB1c2VkIGFuZCB3ZSAKY2FuIHVzZSBhIGR1bW15IGxpc3Qgb24gdGhlIHN0YWNr
IGFzIHBhcmFtZXRlci4gQnV0IHdlIHNob3VsZCBzZXQgdGhlIApwb2ludGVyIHRvIE5VTEwgaW4g
dGhpcyBjYXNlIGp1c3QgdG8gbWFrZSBzdXJlIHRoYXQgbm9ib2R5IGlzIApkZXJlZmVyZW5jaW5n
IGl0LgoKPj4+Cj4+Pj4gwqAgLcKgwqDCoCBpZighZW50aXR5LT5zY2hlZF9saXN0KQo+Pj4+IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT01FTTsKPj4+PiDCoCDCoMKgwqDCoMKgIGluaXRfY29t
cGxldGlvbigmZW50aXR5LT5lbnRpdHlfaWRsZSk7Cj4+Pj4gLQo+Pj4+IC3CoMKgwqAgZm9yIChp
ID0gMDsgaSA8IG51bV9zY2hlZF9saXN0OyBpKyspCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGVudGl0
eS0+c2NoZWRfbGlzdFtpXSA9IHNjaGVkX2xpc3RbaV07Cj4+Pj4gLQo+Pj4+IMKgwqDCoMKgwqAg
aWYgKG51bV9zY2hlZF9saXN0KQo+Pj4KPj4+IFRoYXQgY2hlY2sgY2FuIGFjdHVhbGx5IGJlIGRy
b3BwZWQgYXMgd2VsbC4gV2UgcmV0dXJuIC1FSU5WQUwgd2hlbiAKPj4+IHRoZSBudW1fc2NoZWRf
bGlzdCBpcyB6ZXJvLgo+Pgo+PiBUaGlzwqAgb25lIHRvb2sgbWUgc29tZSB0aW1lIHRvIHVuZGVy
c3RhbmQuIFNvIHdlIGRvbid0IHJlYWxseSByZXR1cm4gCj4+IC1FSU5WQUwgaWYgbnVtX3NjaGVk
X2xpc3QgPT0gMAo+Pgo+PiBpZiAoIShlbnRpdHkgJiYgc2NoZWRfbGlzdCAmJiAobnVtX3NjaGVk
X2xpc3QgPT0gMCB8fCBzY2hlZF9saXN0WzBdKSkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4KPj4gVGhpcyBpcyBjb21pbmcgZnJvbSBiZWxvdyBw
YXRjaC4gQXJlIHdlIHN1cHBvc2UgdG8gdG9sZXJhdGUgSVBzIHdpdGggCj4+IHVuaW5pdGlhbGl6
ZWQgc2NoZWQgc28gdGhhdCBjdHggY3JlYXRpb24gZG9zbid0IHJldHVybiBlcnJvciA/CgpZZXMs
IGV4YWN0bHkuIFRoYXQncyBpbnRlbnRpb25hbGx5IHRoaXMgd2F5LgoKR1BVIHJlc2V0IHNvbWV0
aW1lcyByZXN1bHRlZCBpbiBzY2hlZHVsZXJzIGJlaW5nIGRpc2FibGVkIGJlY2F1c2Ugd2UgCmNv
dWxkbid0IHJlLWluaXQgdGhlbS4gSW4gdGhpcyBjYXNlIHdlIGhhZCBlbnRpdGllcyB3aXRoIGFu
IGVtcHR5IApzY2hlZHVsZXIgbGlzdC4KClRoYXQgY2FuJ3QgaGFwcGVuIGFueSBtb3JlIGFmdGVy
IHlvdSBtYWtlIHRoZSBzY2hlZHVsZXIgYXJyYXlzIGNvbnN0YW50LCAKYnV0IEkgd291bGQgc3Rp
Y2sgd2l0aCB0aGF0IGJlaGF2aW9yLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPj4KPj4gY29tbWl0
IDFkZWNiZjZiYjBiNGRjNTZjOWRhNmM1ZTU3Yjk5NGViZmMyYmUzYWEKPj4gQXV0aG9yOiBCYXMg
TmlldXdlbmh1aXplbiA8YmFzQGJhc25pZXV3ZW5odWl6ZW4ubmw+Cj4+IERhdGU6wqDCoCBXZWQg
SmFuIDMwIDAyOjUzOjE5IDIwMTkgKzAxMDAKPj4KPj4gwqDCoMKgIGRybS9zY2hlZDogRml4IGVu
dGl0aWVzIHdpdGggMCBycXMuCj4+Cj4+IMKgwqDCoCBTb21lIGJsb2NrcyBpbiBhbWRncHUgY2Fu
IGhhdmUgMCBycXMuCj4+Cj4+IMKgwqDCoCBKb2IgY3JlYXRpb24gYWxyZWFkeSBmYWlscyB3aXRo
IC1FTk9FTlQgd2hlbiBlbnRpdHktPnJxIGlzIE5VTEwsCj4+IMKgwqDCoCBzbyBqb2JzIGNhbm5v
dCBiZSBwdXNoZWQuIFdpdGhvdXQgYSBycSB0aGVyZSBpcyBubyBzY2hlZHVsZXIgdG8KPj4gwqDC
oMKgIHBvcCBqb2JzLCBhbmQgcnEgc2VsZWN0aW9uIGFscmVhZHkgZG9lcyB0aGUgcmlnaHQgdGhp
bmcgd2l0aCBhCj4+IMKgwqDCoCBsaXN0IG9mIGxlbmd0aCAwLgo+Pgo+PiDCoMKgwqAgU28gdGhl
IG9wZXJhdGlvbnMgd2UgbmVlZCB0byBmaXggYXJlOgo+PiDCoMKgwqDCoMKgIC0gQ3JlYXRpb24s
IGRvIG5vdCBzZXQgcnEgdG8gcnFfbGlzdFswXSBpZiB0aGUgbGlzdCBjYW4gaGF2ZSAKPj4gbGVu
Z3RoIDAuCj4+IMKgwqDCoMKgwqAgLSBEbyBub3QgZmx1c2ggYW55IGpvYnMgd2hlbiB0aGVyZSBp
cyBubyBycS4KPj4gwqDCoMKgwqDCoCAtIE9uIGVudGl0eSBkZXN0cnVjdGlvbiBoYW5kbGUgdGhl
IHJxID0gTlVMTCBjYXNlLgo+PiDCoMKgwqDCoMKgIC0gb24gc2V0X3ByaW9yaXR5LCBkbyBub3Qg
dHJ5IHRvIGNoYW5nZSB0aGUgcnEgaWYgaXQgaXMgTlVMTC4KPj4KPj4+Cj4+PiBSZWdhcmRzLAo+
Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW50aXR5LT5ycSA9IAo+
Pj4+ICZlbnRpdHktPnNjaGVkX2xpc3RbMF0tPnNjaGVkX3JxW2VudGl0eS0+cHJpb3JpdHldOwo+
Pj4+IMKgIEBAIC0zMTIsNyArMzA1LDYgQEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X2Zpbmkoc3Ry
dWN0IAo+Pj4+IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4+PiDCoCDCoMKgwqDCoMKgIGRt
YV9mZW5jZV9wdXQoZW50aXR5LT5sYXN0X3NjaGVkdWxlZCk7Cj4+Pj4gwqDCoMKgwqDCoCBlbnRp
dHktPmxhc3Rfc2NoZWR1bGVkID0gTlVMTDsKPj4+PiAtwqDCoMKgIGtmcmVlKGVudGl0eS0+c2No
ZWRfbGlzdCk7Cj4+Pj4gwqAgfQo+Pj4+IMKgIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2VudGl0
eV9maW5pKTsKPj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
