Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF919C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFD3206CC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 17:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFD3206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F276E9CE;
	Wed, 20 Nov 2019 17:51:06 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820050.outbound.protection.outlook.com [40.107.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C4A6E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 17:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRv6MLfMWaNSa9p1vdO9u3WkuPGP9RhoB+5ShR6Cw87Obpj8oe2x7tSaKaQgCZO3/nD4CMdL9T/XPMXw2+LZgI6misCo84Gvn8bgZaI075ubrrEcR6RmvtJO0BI3nNKoirwD/IpqGPVqWjEs+K3sZyjZqQhzNSfNW+hE4mSVHJ9/cF1ii9L1qfji2Ls9Am79ZjX/RE+2BIuMxsJCakFBUWXjM3QMBAr6ZfPglbPDTdpI11k9lkjVUvE85zCWkwaiAGqtdmlO7C7Z+VZoKgNJkWs3K5oHuDt7woJ31QNnIz4y0dqLEYuv9CHzjj1NlH3Sl8GdKCKBvJ39YaUlux35HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKsGlDhpzOBL5v2otQI7aZh3vq9a2a18EhAORJoj4Jg=;
 b=RBs46NROnBTM/uU8vSDnVMvXbxD29LC8kX/7G7In5Kzb6CO0Rtd/cEoxa9jLfmYaJvudFyLTUv543oIsJqTxXSeFMolnVNtRMpHdj3oM+9pzW2K0AoE+oZi7/kdFT9rnRAf6Uj6P1OSDR2fWQxbOGqIzLNQnrOfMSmcKhFcLF2JBbKDRXSAnPYVbv5AeKQ1+sRzMh1TXE3lqbccQMguRLGSf6JP0BQZI1KG6e95DV9+tLI0rXX0bvJrkFgiDUSZlOmdHi1eDQUGX9V7RR9wKlAjbJWUqzFO9BGztqXAho/Go86h6DtrvaPjUH0itlRFfyq/3Zg82xhHT7hikGszjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3351.namprd12.prod.outlook.com (20.178.55.24) by
 BYAPR12MB2677.namprd12.prod.outlook.com (20.176.255.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 20 Nov 2019 17:51:03 +0000
Received: from BYAPR12MB3351.namprd12.prod.outlook.com
 ([fe80::2db7:95fe:a576:f3a]) by BYAPR12MB3351.namprd12.prod.outlook.com
 ([fe80::2db7:95fe:a576:f3a%4]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 17:51:03 +0000
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
 <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
 <cac7e351-dba8-125b-dc5d-b2fdec77731b@gmail.com>
 <0622cbcb-9b04-eed3-ad1e-7a40cc03c73a@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <31a1cde2-18ab-96f5-47a4-6f113cbc9e4a@amd.com>
Date: Wed, 20 Nov 2019 12:50:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <0622cbcb-9b04-eed3-ad1e-7a40cc03c73a@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: MN2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:208:a8::39) To BYAPR12MB3351.namprd12.prod.outlook.com
 (2603:10b6:a03:de::24)
MIME-Version: 1.0
X-Originating-IP: [165.204.11.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7d33d2c-afdc-46e4-5ccc-08d76de235ac
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB267757798FFB613A7DEF14AD994F0@BYAPR12MB2677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(189003)(65956001)(23676004)(8676002)(65806001)(66066001)(4001150100001)(31696002)(86362001)(14454004)(44832011)(14444005)(110136005)(6666004)(58126008)(6116002)(316002)(476003)(305945005)(7736002)(31686004)(99286004)(2616005)(5660300002)(6246003)(11346002)(446003)(6436002)(486006)(6486002)(229853002)(3846002)(76176011)(2486003)(54906003)(52116002)(66556008)(66476007)(66574012)(66946007)(6512007)(6306002)(47776003)(4326008)(966005)(186003)(25786009)(2870700001)(386003)(2906002)(6506007)(36756003)(26005)(53546011)(81166006)(8936002)(81156014)(478600001)(50466002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2677;
 H:BYAPR12MB3351.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/v/sD9wftjPs4SL6BkKHQhev5kf7TpI4NapHkdI0g7Pom5AovSmuPNUQN+opJRRl5i/omFAQX75z5YLxjCPBiSkwiRrqC39knNniP2JEzeNTUmAL9dwjkmq7FPuh+f2OizJ6f1T5rLWFUkoq0fb69l7UCsMLCvT7M5SM46A4i8DrDK5pa8B5UPzu6HdGNzwt7qC/OAP8KsyxQq0gai8YWr5jX4yr2uJQW+UGU3WYlpXR/oSe5FtMDdYZ2bgPZxbHAlS3WutOD/18jahD6l6qv4Wing0OuKO6ONbCg4HJWt60uJOHrf2dhEIv5T6wXq0FeYQZyBk7FExXS/yNyQMdtpc4t+XndGS5m34ZwK106iVJcVhIPFRGGpkjA3XyOugaKV8SN3RzX7uf3g6Zpvd4nPYpG7j3ijulOMEAzBwkyEhQUXZ0Pb9cjT5C4DDrW9/Cnk2mU7II1OLTjU9BbdZVJAzPm8tvUSb+/8jpkDaWQ4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d33d2c-afdc-46e4-5ccc-08d76de235ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 17:51:02.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDs2bjAQMDvSjs2GI2Ea12z2J6/ip2itf65QldY/Osh0x4n4PZdDwn4ozdeZxmye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKsGlDhpzOBL5v2otQI7aZh3vq9a2a18EhAORJoj4Jg=;
 b=wh356eE+q9DoOs+rjjcDYF8oZvx0kq1FAum77yaZyYbRpW5c7lDKRVoe+shZf9Ku4ERLmEnnfyNyILxIn+SZbkPXEGt50tYGXz5jJZlC5qHC7HWobpD8V6lwPFZV83DOdLHHqhXA2Cmnfv3jfDXFUYYmzlUplG3rPIWxSgHC7h8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 Aaron Liu <aaron.liu@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Huang Rui <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120175059.UVuLT-D6ouEql_WiiSlTOAlWzBdKEcyIHlcDrW_Wtw4@z>

T24gMjAxOS0xMS0yMCAxMjoyNCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMC4xMS4x
OSB1bSAxODoxNiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+IEFtIDIwLjExLjE5IHVtIDE3
OjQ5IHNjaHJpZWIgTHViZW4gVHVpa292Ogo+Pj4gT24gMjAxOS0xMS0xOSAyMTo0MSwgTWFyZWsg
T2zFocOhayB3cm90ZToKPj4+PiBPbiBUdWUsIE5vdiAxOSwgMjAxOSBhdCA4OjUyIFBNIEx1YmVu
IFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20gCj4+Pj4gPG1haWx0bzpsdWJlbi50dWlrb3ZA
YW1kLmNvbT4+IHdyb3RlOgo+Pj4+Cj4+Pj4gwqDCoMKgwqAgT24gMjAxOS0xMS0xNCAxMDozNCBw
Lm0uLCBBYXJvbiBMaXUgd3JvdGU6Cj4+Pj4gwqDCoMKgwqAgPiBGcm9tOiBIdWFuZyBSdWkgPHJh
eS5odWFuZ0BhbWQuY29tIDxtYWlsdG86cmF5Lmh1YW5nQGFtZC5jb20+Pgo+Pj4+IMKgwqDCoMKg
ID4KPj4+PiDCoMKgwqDCoCA+IFRvIGFsaWduIHRoZSBrZXJuZWwgdWFwaSBjaGFuZ2UgZnJvbSBB
bGV4Ogo+Pj4+IMKgwqDCoMKgID4KPj4+PiDCoMKgwqDCoCA+ICJBZGQgYSBmbGFnIHRvIHRoZSBH
RU1fQ1JFQVRFIGlvY3RsIHRvIGNyZWF0ZSBlbmNyeXB0ZWQgCj4+Pj4gYnVmZmVycy4gQnVmZmVy
cyB3aXRoCj4+Pj4gwqDCoMKgwqAgPiB0aGlzIGZsYWcgc2V0IHdpbGwgYmUgY3JlYXRlZCB3aXRo
IHRoZSBUTVogYml0IHNldCBpbiB0aGUgCj4+Pj4gUFRFcyBvciBlbmdpbmVzCj4+Pj4gwqDCoMKg
wqAgPiBhY2Nlc3NpbmcgdGhlbS4gVGhpcyBpcyByZXF1aXJlZCBpbiBvcmRlciB0byBwcm9wZXJs
eSBhY2Nlc3MgCj4+Pj4gdGhlIGRhdGEgZnJvbSB0aGUKPj4+PiDCoMKgwqDCoCA+IGVuZ2luZXMu
Igo+Pj4+IMKgwqDCoMKgID4KPj4+PiDCoMKgwqDCoCA+IFdlIHdpbGwgdXNlIEdFTV9DUkVBVEVf
RU5DUllQVEVEIGZsYWcgZm9yIHNlY3VyZSBidWZmZXIgCj4+Pj4gYWxsb2NhdGlvbi4KPj4+PiDC
oMKgwqDCoCA+Cj4+Pj4gwqDCoMKgwqAgPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5o
dWFuZ0BhbWQuY29tIAo+Pj4+IDxtYWlsdG86cmF5Lmh1YW5nQGFtZC5jb20+Pgo+Pj4+IMKgwqDC
oMKgID4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bSAKPj4+PiA8bWFpbHRvOmFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Pgo+Pj4+IMKgwqDCoMKg
ID4gLS0tCj4+Pj4gwqDCoMKgwqAgPsKgIGluY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCB8IDUgKysr
KysKPj4+PiDCoMKgwqDCoCA+wqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Pj4+
IMKgwqDCoMKgID4KPj4+PiDCoMKgwqDCoCA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9hbWRn
cHVfZHJtLmggYi9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKPj4+PiDCoMKgwqDCoCA+IGluZGV4
IDVjMjhhYTcuLjFhOTVlMzcgMTAwNjQ0Cj4+Pj4gwqDCoMKgwqAgPiAtLS0gYS9pbmNsdWRlL2Ry
bS9hbWRncHVfZHJtLmgKPj4+PiDCoMKgwqDCoCA+ICsrKyBiL2luY2x1ZGUvZHJtL2FtZGdwdV9k
cm0uaAo+Pj4+IMKgwqDCoMKgID4gQEAgLTE0MSw2ICsxNDEsMTEgQEAgZXh0ZXJuICJDIiB7Cj4+
Pj4gwqDCoMKgwqAgPsKgIMKgKiByZWxlYXNpbmcgdGhlIG1lbW9yeQo+Pj4+IMKgwqDCoMKgID7C
oCDCoCovCj4+Pj4gwqDCoMKgwqAgPsKgICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9X
SVBFX09OX1JFTEVBU0UgwqAoMSA8PCA5KQo+Pj4+IMKgwqDCoMKgID4gKy8qIEZsYWcgdGhhdCBC
TyB3aWxsIGJlIGVuY3J5cHRlZCBhbmQgdGhhdCB0aGUgVE1aIGJpdCAKPj4+PiBzaG91bGQgYmUK
Pj4+PiDCoMKgwqDCoCA+ICsgKiBzZXQgaW4gdGhlIFBURXMgd2hlbiBtYXBwaW5nIHRoaXMgYnVm
ZmVyIHZpYSBHUFVWTSBvcgo+Pj4+IMKgwqDCoMKgID4gKyAqIGFjY2Vzc2luZyBpdCB3aXRoIHZh
cmlvdXMgaHcgYmxvY2tzCj4+Pj4gwqDCoMKgwqAgPiArICovCj4+Pj4gwqDCoMKgwqAgPiArI2Rl
ZmluZSBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUTCoCDCoCDCoCDCoCDCoCAoMSA8PCAxMCkK
Pj4+Pgo+Pj4+IMKgwqDCoMKgIFN0eWxlIQo+Pj4+IMKgwqDCoMKgIFRBQiBjaGFyPyEKPj4+Pgo+
Pj4+IMKgwqDCoMKgIFlvdSBoYXZlIGEgVEFCIGNoYXIgYmV0d2VlbiAiLi5fRU5DUllQVEVEIiBh
bmQgIigxIDw8IDEwKSIKPj4+PiDCoMKgwqDCoCBEbyBOT1QgYWRkL2luc2VydCBUQUIgY2hhcnMg
aW5zdGVhZCBvZiBzcGFjZSB0byBhbGlnbiBjb2x1bm1ucyEKPj4+PiDCoMKgwqDCoCBJZiB3aGVu
IHlvdSBwcmVzcyBUYWIga2V5IGEgdGFiIGlzIGluc2VydGVkLCBhcyBvcHBvc2VkIHRvIHRoZSAK
Pj4+PiBsaW5lCj4+Pj4gwqDCoMKgwqAgaW5kZW50ZWQsIHRoZW4gRE8gTk9UIHVzZSB0aGlzIGVk
aXRvci4KPj4+PiDCoMKgwqDCoCBUaGUgVGFiIGtleSBzaG91bGQgImluZGVudCBhY2NvcmRpbmcg
dG8gbW9kZSIgYnkgaW5zZXJ0aW5nIFRBQiAKPj4+PiBjaGFycy4KPj4+PiDCoMKgwqDCoCBJZiB0
aGUgbGluZSBpcyBhbHJlYWR5IGluZGVudGVkLCBhcyB0aGlzIG9uZSBpcywgdGhlbiBpdCBzaG91
bGQgCj4+Pj4gZG8gbm90aGluZy4KPj4+Pgo+Pj4+Cj4+Pj4gSSBkaXNhZ3JlZSB3aXRoIHRoaXMg
MTAwJS4gVGFicyBvciBzcGFjZXMgZG9uJ3QgbWF0dGVyIGhlcmUgZnJvbSBteSAKPj4+PiBwZXJz
cGVjdGl2ZS4gSSBhbHNvIGRpc2FncmVlIHdpdGggeW91ciBsYW5ndWFnZS4gSXQncyBvdmVybHkg
aW1wb2xpdGUuCj4+PiBCdXQgaXQncyB0aGUgY29kaW5nIHN0eWxlIG9mIExpbnV4OiBsZWFkaW5n
IHRhYnMgb25seS4gVHJ5IGl0IHdpdGggCj4+PiBFbWFjcyBhcyBkZXNjcmliZWQgYW5kIGdpdmVu
IGluCj4+Pgo+Pj4gbGludXgvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3QK
Pj4+Cj4+PiBzdGFydGluZyBhdCBsaW5lIDU4OS4gQW5kIHByZXNzIHRoZSBUYWIga2V5IG9uIGFu
IGFscmVhZHkgaW5kZW50ZWQgCj4+PiBsaW5lLS1ub3RoaW5nIHdpbGwgaGFwcGVuLiBMaW51eCBo
YXMgdHJhZGl0aW9uYWxseQo+Pj4gc2h1bm5lZCBmcm9tIGxvb3NlIFRBQiBjaGFycyBpbiBhbHJl
YWR5IGluZGVudGVkIGxpbmVzOiBsZWFkaW5nIHRhYnMgCj4+PiBvbmx5IG1vZGUuIEluIGEgcHJv
cGVyIGNvZGUgZWRpdG9yCj4+PiBwcmVzc2luZyB0aGUgVGFiIGtleSBvbmx5IGluZGVudHMgYWNj
b3JkaW5nIHRvIGJ1ZmZlciBtb2RlLCBpdCAKPj4+IHNob3VsZG4ndCBpbnNlcnQgYSBUYWIgY2hh
ciB3aWxseS1uaWxseS4KPj4+IFBlb3BsZSBtYXkgc2V0IHRoZWlyIHRhYiBzdG9wcyBkaWZmZXJl
bnRseSBmb3IgZGlmZmVyZW50IHRhYiAKPj4+IHBvc2l0aW9ucyBhbmQgaW5zZXJ0aW5nIGEgdGFi
IGNoYXIgbWF5IGRpc3BsYXkKPj4+IGluY29ycmVjdGx5LiBUaGUgbW9zdCBwb3J0YWJsZSB3YXkg
dG8gYWxpZ24gY29sdW1ucyBpbiBhbiBhbHJlYWR5IAo+Pj4gaW5kZW50ZWQtYWNjb3JkaW5nLXRv
LW1vZGUgbGluZSwgaXMKPj4+IHVzaW5nIHNwYWNlcy4gKE9mIGNvdXJzZSB0aGlzIGRvZXNuJ3Qg
bWF0dGVyIHdoZW4gdXNpbmcgc3BhY2VzIHRvIAo+Pj4gaW5kZW50LCBidXQgTGludXggdXNlcyBo
YXJkIFRBQiBjaGFycwo+Pj4gdG8gaW5kZW50OiBsaW51eC9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mv
Y29kaW5nLXN0eWxlLnJzdC4gKHdoaWNoIGFsc28gCj4+PiBzZWVtIHRvIGJlIHNldCB0byA4IGNo
YXJzKSkKPj4+Cj4+PiBJdCdzIGEgY29kZSByZXZpZXcsIHRoZXJlIGlzIG5vICJsYW5ndWFnZSIu
Cj4+Cj4+IFdlbGwgdGhlIHNlY3Rpb24geW91IG5vdGVkIGFsc28gc3VnZ2VzdCB0byBlaXRoZXIg
Z2V0IHJpZCBvZiBlbWFjcyBvciAKPj4gY2hhbmdlIGl0IHRvIHVzZSBzb21lIHNhbmVyIGRlZmF1
bHQgdmFsdWVzLiBXZSBqdXN0IGdvdCByaWQgb2YgZW1hY3MuCgpZZXMsIGl0IHNheXMgdGhpcywg
cXVvdGUgKGZvciB0aG9zZSB3aG8gZGlkbid0IG9wZW4gdGhlIGZpbGUpOgoKLS04PC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQoKVGhhdCdzIE9LLCB3ZSBhbGwgZG8uICBZb3UndmUgcHJvYmFibHkgYmVlbiB0b2xkIGJ5
IHlvdXIgbG9uZy10aW1lIFVuaXgKdXNlciBoZWxwZXIgdGhhdCBgYEdOVSBlbWFjc2BgIGF1dG9t
YXRpY2FsbHkgZm9ybWF0cyB0aGUgQyBzb3VyY2VzIGZvcgp5b3UsIGFuZCB5b3UndmUgbm90aWNl
ZCB0aGF0IHllcywgaXQgZG9lcyBkbyB0aGF0LCBidXQgdGhlIGRlZmF1bHRzIGl0CnVzZXMgYXJl
IGxlc3MgdGhhbiBkZXNpcmFibGUgKGluIGZhY3QsIHRoZXkgYXJlIHdvcnNlIHRoYW4gcmFuZG9t
CnR5cGluZyAtIGFuIGluZmluaXRlIG51bWJlciBvZiBtb25rZXlzIHR5cGluZyBpbnRvIEdOVSBl
bWFjcyB3b3VsZCBuZXZlcgptYWtlIGEgZ29vZCBwcm9ncmFtKS4KClNvLCB5b3UgY2FuIGVpdGhl
ciBnZXQgcmlkIG9mIEdOVSBlbWFjcywgb3IgY2hhbmdlIGl0IHRvIHVzZSBzYW5lcgp2YWx1ZXMu
ICBUbyBkbyB0aGUgbGF0dGVyLCB5b3UgY2FuIHN0aWNrIHRoZSBmb2xsb3dpbmcgaW4geW91ciAu
ZW1hY3MgZmlsZToKCi0tODwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKPj4KPj4gUmVnYXJkaW5nIHRhYnMgYWZ0ZXIg
dGhlIGluaXRpYWwgaW5kZW50YXRpb24sIEkndmUganVzdCBkb25lIGEgcXVpY2sgCj4+IGdyZXAg
YW5kIGFyb3VuZCAxNCUgb2YgYWxsIGRlZmluZXMgdW5kZXIgaW5jbHVkZS8gdXNlcyB0aGF0IHNv
IEkgd291bGQgCj4+IHNheSB0aGF0IHRoaXMgaXMgcGVyZmVjdGx5IGZpbmUuCj4gCj4gRmFzdCB0
eXBpbmcgd2l0aCBsYXp5IGV5ZXMsIHRoYXQgc2hvdWxkIHJlYWQgImFyb3VuZCA3MSUgb2YgYWxs
IGRlZmluZXMiLgoKSG1tLCB0aGF0J3MgaW50ZXJlc3RpbmcuIElzIHRoYXQgaW4gbGludXgvaW5j
bHVkZSBvciBhbWRncHUvaW5jbHVkZT8KCkkndmUgYmVlbiBtZWFuaW5nIHRvIGRvIG15IG93biBl
eHRlbmRlZCByZWdleCB0byBjYXRjaCB0aG9zZSwgYWx0aG91Z2gKSSdtIHVzaW5nIEVtYWNzIGFu
ZCBwcmVzc2luZyBUYWIga2V5IG9ubHkgaW5kZW50cyBhbmQgd291bGQgbm90IGluc2VydAphIFRh
YiBjaGFyIGlmIGFscmVhZHkgaW5kZW50ZWQuIChTbyBhcHBseWluZyB0aGlzIHJlZ2V4IGludG8g
dGhlIHByZS1jb21taXQKaG9vayBvZiBhbGwgb2YgbXkgR2l0IHJlcG9zIHdvdWxkIG5ldmVyIHRy
aWdnZXIuKQoKSSByZW1lbWJlciBvZiBvbGRlbiBkYXlzLCBjaXJjYSAyMDAwIHdoZW4gSSBmaXJz
dCBnb3QgaW52b2x2ZWQgd2l0aCBMaW51eCwKTEtNTCBkaWRuJ3QgbGlrZSBsb29zZSB0YWJzLiBB
bHNvIGxlYWQga2VybmVsIGRldmVsb3BlcnMgYXJlIHVzaW5nIEVtYWNzLApzbyBpdCdzIGJlZW4g
bXkgY2hvaWNlIG9mIGVkaXRvciBzaW5jZSBjaXJjYSAxOTk0IChzd2l0Y2hlZCBmcm9tIHZpIHRv
IEVtYWNzCmxhcmdlbHkgZHVlIHRvIHRoZSBpbmZsdWVuY2Ugb2YgYSBncmFwaGljcyBwcm9mIEkg
aGFkIGluIG15IHNlbmlvdXIgeWVhciBvZiB1bmksCmFuZCBwYXJ0IGR1ZSB0byBMS01MLikKClRo
YW5rcyBmb3IgY2hpbWluZyBpbiBDaHJpc3RpYW4hCgpSZWdhcmRzLApMdWJlbgoKPiAKPiBTb3Jy
eSwKPiBDaHJpc3RpYW4uCj4gCj4+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+Cj4+
PiBSZWdhcmRzLAo+Pj4gTHViZW4KPj4+Cj4+Pj4gTWFyZWsKPj4+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+Pgo+IAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
