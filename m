Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C888C00454
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 14:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D6C20836
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EgVczkgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D6C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392746E8F2;
	Tue, 10 Dec 2019 14:47:45 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700054.outbound.protection.outlook.com [40.107.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982236E8F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 14:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATfSzryQrL2kg4lx82sOe/40TT75n3s56fkMh2mqdWyc4Ucc7/BH9LHZ3YJBsgFkFNNqlgupLezIdbcgFYlgSQiWzLHuz0c3dhYzHnai5m4W3UpoisdDRJgq0DfvfyrXLhqmYqD5HfNxfi1T/Hey6Eerfxz3kuzLGGH7qdCsADI63/Ybu/2xL2gMMGaPBm5uyqOdioULe2UgGLHuyF6DsXDp3VNe8xEZC/kNw9YH0e2YJBwro0anSRdUs4ZwqXNMhXQGshJkvovQsZv3ladDGpaXfFooD+b+9bLmVkiKHHbWed8+kLkG5tAeDTbSnfZyFPVnPBQqJCemOFfID0y2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98e022rY5A2Qu0WBCO8JSzpvgeWB4j7lTFpkMPNG9wo=;
 b=BDM7kFF6TChvQBpGAafsvjCxaMOVdeiLTBJ5h4T2PCDWwNvb1opHvPNR6vZ91AFWF157WETb28vsYEfLvq6XyVCxEDjAmlsHKavjNBOQ/VROcGjre13Nh8FxKlia2DzeB9plbWcV5FYA9YrRoL7RF+eirUsmW47CjgvYqFRY/AZdniURfvrnMRUNBm9Ok0DUFY1gsgk4Y7iroRquftfRiahKMTyUg8BpW37lBAqoKsbb+vOG3zkaAB0/dLBhG0FowbtMjL7HSg7eq4NYzU528+b9GluStohjjTds42P54aQsHfhMC8RRsRsArdX1ywJj8kO6l1o6Q0sadFP/SKf8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98e022rY5A2Qu0WBCO8JSzpvgeWB4j7lTFpkMPNG9wo=;
 b=EgVczkgLZzgGGDpAbofCeBIQcf23S3fNGNLfOolMIwtXJttW/gKsi6izb+EsTE5gqGsXLLfTt5qlr4JShvlo+qKfswsIUB6wgpgJS3I7iVb7KVxPVCVj+lml0E0WdBQ6rrol3nERoPLT55VWzgr78VwtT3c7KvhXVFdzzxiXGD0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB2438.namprd12.prod.outlook.com (52.132.141.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 14:47:42 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 14:47:41 +0000
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, alexander.deucher@amd.com,
 kenny.ho@amd.com
References: <20191210125300.3800-1-nirmoy.das@amd.com>
 <20191210125300.3800-4-nirmoy.das@amd.com>
 <800c29bf-11dd-0ac9-32ad-ef3476f07643@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <97343695-4b6d-1dfb-2c52-e728a7f1736e@amd.com>
Date: Tue, 10 Dec 2019 15:47:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <800c29bf-11dd-0ac9-32ad-ef3476f07643@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0100.eurprd02.prod.outlook.com
 (2603:10a6:208:154::41) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f2c:cf00:f7ef:6dd5:8f2d:73fd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2ebd1b0-9dcd-46b3-f99f-08d77d7fe8cc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:|DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438B833B37BE1B931ECFE868B5B0@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(110136005)(5660300002)(316002)(6506007)(2616005)(6512007)(2906002)(6486002)(31696002)(52116002)(4326008)(31686004)(186003)(66946007)(8936002)(66556008)(6636002)(8676002)(81156014)(81166006)(66574012)(478600001)(66476007)(36756003)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2438;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYAfgiQ2AAn012o+7lHySTiMLJph7sU8EhOYoVKF62Sys/4Ods/EDZHPXHeeQQQN4VIgqpd8g1CpPup+j947DvNJhl+nyHXwZdOkPyzi/QG5NHugipfMjRvXF54b56UXWpTUspTNAgtVZzSPBfDUaqEzqKn9C3T32+Weh2HC/LZk8oxb7pSWE3D1NOeGiLNjswYGk5WhjstNowptWAlxxOEjckIwt/E0lKniYmVxd/WfhJPNaVZaL7ZnVvnKdlpwgU4ADVoY+X5BRRPRPdRrpfsr6Ku/F570PzMCdBzRUSJhRouuZ8NrCNBaej3+QiC00JW8zRvCxJjyKDbtyWTYzT7DYw3ajUlLfmh0xIseiNV7w8jW4s2YNp9ZZlyweJg0oVtpa7NHTOEh3A3iyLS5/hdabl2WGf/Q4MpRtMmgRKqMuKB8h5toQqe1CGRkJFHN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ebd1b0-9dcd-46b3-f99f-08d77d7fe8cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 14:47:41.7929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbQSKwaZpv4a97rjeTWfnwpdNcHBvKIg0gxKCYkaFoV04QCNV0zYPmgR97Ocs8AbHR2MU36I9mpaIPkYvXP1Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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

Ck9uIDEyLzEwLzE5IDI6MDAgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTAuMTIu
MTkgdW0gMTM6NTMgc2NocmllYiBOaXJtb3kgRGFzOgo+PiBlbnRpdHkgc2hvdWxkIG5vdCBrZWVw
IGNvcHkgYW5kIG1haW50YWluIHNjaGVkIGxpc3QgZm9yCj4+IGl0c2VsZi4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8IDEwICstLS0tLS0tLS0KPj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA5IGRlbGV0aW9ucygtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyAKPj4g
Yi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+IGluZGV4IGY5YjZj
ZTI5YzU4Zi4uYTVmNzI5ZjQyMWY4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
c2NoZWRfZW50aXR5LmMKPj4gQEAgLTY3LDE3ICs2NywxMCBAQCBpbnQgZHJtX3NjaGVkX2VudGl0
eV9pbml0KHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5IAo+PiAqZW50aXR5LAo+PiDCoMKgwqDCoMKg
IGVudGl0eS0+Z3VpbHR5ID0gZ3VpbHR5Owo+PiDCoMKgwqDCoMKgIGVudGl0eS0+bnVtX3NjaGVk
X2xpc3QgPSBudW1fc2NoZWRfbGlzdDsKPj4gwqDCoMKgwqDCoCBlbnRpdHktPnByaW9yaXR5ID0g
cHJpb3JpdHk7Cj4+IC3CoMKgwqAgZW50aXR5LT5zY2hlZF9saXN0ID3CoCBrY2FsbG9jKG51bV9z
Y2hlZF9saXN0LAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHNpemVvZihzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKiksIEdGUF9LRVJORUwpOwo+PiArwqDC
oMKgIGVudGl0eS0+c2NoZWRfbGlzdCA9wqAgc2NoZWRfbGlzdDsKPgo+IE1heWJlIG1ha2UgdGhp
cyAibnVtX3NjaGVkX2xpc3QgPiAxID8gc2NoZWRfbGlzdCA6IE5VTEwiIHRvIGF2b2lkIAo+IGFj
Y2lkZW50YWxseSBkZXJlZmVyZW5jaW5nIGEgc3RhbGUgcG9pbnRlciB0byB0aGUgc3RhY2suCkRv
IHlvdSBtZWFuICJudW1fc2NoZWRfbGlzdCA+PSAxID8gc2NoZWRfbGlzdCA6IE5VTEwiCj4KPj4g
wqAgLcKgwqDCoCBpZighZW50aXR5LT5zY2hlZF9saXN0KQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTk9NRU07Cj4+IMKgIMKgwqDCoMKgwqAgaW5pdF9jb21wbGV0aW9uKCZlbnRpdHktPmVu
dGl0eV9pZGxlKTsKPj4gLQo+PiAtwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBudW1fc2NoZWRfbGlz
dDsgaSsrKQo+PiAtwqDCoMKgwqDCoMKgwqAgZW50aXR5LT5zY2hlZF9saXN0W2ldID0gc2NoZWRf
bGlzdFtpXTsKPj4gLQo+PiDCoMKgwqDCoMKgIGlmIChudW1fc2NoZWRfbGlzdCkKPgo+IFRoYXQg
Y2hlY2sgY2FuIGFjdHVhbGx5IGJlIGRyb3BwZWQgYXMgd2VsbC4gV2UgcmV0dXJuIC1FSU5WQUwg
d2hlbiB0aGUgCj4gbnVtX3NjaGVkX2xpc3QgaXMgemVyby4KClRoaXPCoCBvbmUgdG9vayBtZSBz
b21lIHRpbWUgdG8gdW5kZXJzdGFuZC4gU28gd2UgZG9uJ3QgcmVhbGx5IHJldHVybiAKLUVJTlZB
TCBpZiBudW1fc2NoZWRfbGlzdCA9PSAwCgppZiAoIShlbnRpdHkgJiYgc2NoZWRfbGlzdCAmJiAo
bnVtX3NjaGVkX2xpc3QgPT0gMCB8fCBzY2hlZF9saXN0WzBdKSkpCiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7CgpUaGlzIGlzIGNvbWluZyBmcm9tIGJlbG93
IHBhdGNoLiBBcmUgd2Ugc3VwcG9zZSB0byB0b2xlcmF0ZSBJUHMgd2l0aCAKdW5pbml0aWFsaXpl
ZCBzY2hlZCBzbyB0aGF0IGN0eCBjcmVhdGlvbiBkb3NuJ3QgcmV0dXJuIGVycm9yID8KCmNvbW1p
dCAxZGVjYmY2YmIwYjRkYzU2YzlkYTZjNWU1N2I5OTRlYmZjMmJlM2FhCkF1dGhvcjogQmFzIE5p
ZXV3ZW5odWl6ZW4gPGJhc0BiYXNuaWV1d2VuaHVpemVuLm5sPgpEYXRlOsKgwqAgV2VkIEphbiAz
MCAwMjo1MzoxOSAyMDE5ICswMTAwCgogwqDCoMKgIGRybS9zY2hlZDogRml4IGVudGl0aWVzIHdp
dGggMCBycXMuCgogwqDCoMKgIFNvbWUgYmxvY2tzIGluIGFtZGdwdSBjYW4gaGF2ZSAwIHJxcy4K
CiDCoMKgwqAgSm9iIGNyZWF0aW9uIGFscmVhZHkgZmFpbHMgd2l0aCAtRU5PRU5UIHdoZW4gZW50
aXR5LT5ycSBpcyBOVUxMLAogwqDCoMKgIHNvIGpvYnMgY2Fubm90IGJlIHB1c2hlZC4gV2l0aG91
dCBhIHJxIHRoZXJlIGlzIG5vIHNjaGVkdWxlciB0bwogwqDCoMKgIHBvcCBqb2JzLCBhbmQgcnEg
c2VsZWN0aW9uIGFscmVhZHkgZG9lcyB0aGUgcmlnaHQgdGhpbmcgd2l0aCBhCiDCoMKgwqAgbGlz
dCBvZiBsZW5ndGggMC4KCiDCoMKgwqAgU28gdGhlIG9wZXJhdGlvbnMgd2UgbmVlZCB0byBmaXgg
YXJlOgogwqDCoMKgwqDCoCAtIENyZWF0aW9uLCBkbyBub3Qgc2V0IHJxIHRvIHJxX2xpc3RbMF0g
aWYgdGhlIGxpc3QgY2FuIGhhdmUgCmxlbmd0aCAwLgogwqDCoMKgwqDCoCAtIERvIG5vdCBmbHVz
aCBhbnkgam9icyB3aGVuIHRoZXJlIGlzIG5vIHJxLgogwqDCoMKgwqDCoCAtIE9uIGVudGl0eSBk
ZXN0cnVjdGlvbiBoYW5kbGUgdGhlIHJxID0gTlVMTCBjYXNlLgogwqDCoMKgwqDCoCAtIG9uIHNl
dF9wcmlvcml0eSwgZG8gbm90IHRyeSB0byBjaGFuZ2UgdGhlIHJxIGlmIGl0IGlzIE5VTEwuCgo+
Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCj4KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVudGl0eS0+
cnEgPSAKPj4gJmVudGl0eS0+c2NoZWRfbGlzdFswXS0+c2NoZWRfcnFbZW50aXR5LT5wcmlvcml0
eV07Cj4+IMKgIEBAIC0zMTIsNyArMzA1LDYgQEAgdm9pZCBkcm1fc2NoZWRfZW50aXR5X2Zpbmko
c3RydWN0IAo+PiBkcm1fc2NoZWRfZW50aXR5ICplbnRpdHkpCj4+IMKgIMKgwqDCoMKgwqAgZG1h
X2ZlbmNlX3B1dChlbnRpdHktPmxhc3Rfc2NoZWR1bGVkKTsKPj4gwqDCoMKgwqDCoCBlbnRpdHkt
Pmxhc3Rfc2NoZWR1bGVkID0gTlVMTDsKPj4gLcKgwqDCoCBrZnJlZShlbnRpdHktPnNjaGVkX2xp
c3QpOwo+PiDCoCB9Cj4+IMKgIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2VudGl0eV9maW5pKTsK
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
