Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD913C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87015206DA
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 19:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87015206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543996E9EF;
	Wed, 20 Nov 2019 19:08:48 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0159C6E9EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 19:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcdmqJg5C0bwqmFIpTPkmHHbbL0dlmC8Fr42FjurWlu5PUXxd9mjzfLT7EMSxbtqi18oFc132KvWSpWI8RP+GdDyNuxrspVPVbj284BC4zSdsVYDdk0tJlEy0X45HY/thARlkdW9+sC8g3+LG4wIUO4d9tuMHq8a7Esp+YBQbOMJ0VYJr26Mx3XaLTjvzCdsoZwjkFYdrLTlZluyBc9m3V/S6HiTaCNboB+buVns5Tjnn1lnAlwfjjKVf2NQ1+DE998yaSmXVHwgI/5yigp910+jFv6EgsFYVSlH9hCZuCI/pWmcpy1xDrGhbpsAy1wCpb+y8doZ1syU+3U7SBu2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AjI3MAYA1whMnFxaeF8R088m4CrL6TlkjJbOvtdvvk=;
 b=cc+LIZ2iEcrHzf9x5nrIkPICb6EvqGzFmsfi27+nPpa2uFp//gL08eKiK/LgFkLsSP5iBh4EY44r4esm+7h/rWJGe4jvIt1g9TrljcdLbh8TnQU5G9GL8ne9TInuSNP2iUH+JnSVjSqxSXwJcTT6Kdqkvwl9tVG48ZPJRsFPjxP+VZFS0OpBStC2CcXceDtMdEW2Fhe0qPGGwmpgM64U5CYXSFUDcj9VVxOUOcIOFaVCZTwAmAwniKzcZo8kvVnxuMVGHOJXAtmVCZvJ45XOEFM0vtPv+hg7/PJGkqhzSOL1VTuOKoxogJBYM+nfmH29xHRi81KVdASffInZV4Flpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3351.namprd12.prod.outlook.com (20.178.55.24) by
 BYAPR12MB2981.namprd12.prod.outlook.com (20.178.55.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 19:08:45 +0000
Received: from BYAPR12MB3351.namprd12.prod.outlook.com
 ([fe80::2db7:95fe:a576:f3a]) by BYAPR12MB3351.namprd12.prod.outlook.com
 ([fe80::2db7:95fe:a576:f3a%4]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 19:08:44 +0000
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: christian.koenig@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
 <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
 <cac7e351-dba8-125b-dc5d-b2fdec77731b@gmail.com>
 <0622cbcb-9b04-eed3-ad1e-7a40cc03c73a@amd.com>
 <31a1cde2-18ab-96f5-47a4-6f113cbc9e4a@amd.com>
 <069abbd5-564d-aca7-ddfb-2336d56982eb@gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <6ddda4a0-ed0e-eb29-e2f2-ba1e5cdbde1b@amd.com>
Date: Wed, 20 Nov 2019 14:08:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <069abbd5-564d-aca7-ddfb-2336d56982eb@gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: BN6PR1101CA0024.namprd11.prod.outlook.com
 (2603:10b6:405:4a::34) To BYAPR12MB3351.namprd12.prod.outlook.com
 (2603:10b6:a03:de::24)
MIME-Version: 1.0
X-Originating-IP: [165.204.11.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ba4afcf-207d-4a62-e104-08d76ded102a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29819BA30D8C953BF45213A5994F0@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(50466002)(305945005)(6486002)(86362001)(1411001)(4001150100001)(7736002)(4326008)(229853002)(58126008)(52116002)(2486003)(23676004)(186003)(6916009)(316002)(53546011)(386003)(6506007)(76176011)(6306002)(6512007)(6436002)(6246003)(14444005)(54906003)(5660300002)(99286004)(44832011)(2870700001)(3846002)(36756003)(2906002)(6116002)(47776003)(446003)(11346002)(486006)(476003)(65956001)(66066001)(2616005)(65806001)(478600001)(6666004)(26005)(966005)(81166006)(8936002)(81156014)(31686004)(31696002)(66556008)(66476007)(66946007)(14454004)(25786009)(8676002)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2981;
 H:BYAPR12MB3351.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nts9kdSZPmo4KZ16kGJvx0KBDSNIxoYtuj7ejzQE5d4yeC1+97+fW3yXfq7cU4OW6DgyHZv/BdPHCZHYMr/im/p88rlvHmFUlEiuzZt4lGuIUf8kdxcJI6PGkWyw0tgpJuYwz2wlN95wfPB3p9MKy8d98BQNoTH/BSBBEhF9IiIoYxnyopjFHna3onTXQmw5Te60GJM0Lnauz0+lmItjSJA9gUCpNa5nNSdOYFYVaagwBBiTKUxO8TfBTMxHeKB1/bTJ/H3NMaRu9yKiuPN7slw2TqQWWxStXvqv3RY/Jap+5qtdKufLvMfFwW9qkRt26HHjEhfLIvpR9vezG/GJLsUcsrvrdDAi/KJV+zMUfvejHRJjmBhwkUFiT28n//sMb8hwfEiZ6+zLghWntozJhDG+oUwVYnMS/X2IFXyfY6+D6pMAD5IiQuiEF2aMj7GDuJZhZxJo32FcKb2vz08CgKomoRijeqGBaZWALk5C9WE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba4afcf-207d-4a62-e104-08d76ded102a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 19:08:44.5644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2uV/ZqZqlOAqIApHjhKDkaOEDLfYHHxRf3D2esw6toL4byKXUH0sQ2Z9WyVxmrY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AjI3MAYA1whMnFxaeF8R088m4CrL6TlkjJbOvtdvvk=;
 b=NZJaEDtE+Gvv3JM/iMhERsG/s5j4MktWXeb0kVtAgrh1mmiHGRO3uCGQ3idrESPaYnrZG4R91ww4dhJTRYqtyqK7N3tLV8t+NtcUucxecXgGkcT6S/UPrdzfDe/PJBjzihZnhfeMUc8WqSwSQkd7rLrwcdfs6ssp0lR9zhzbWaQ=
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
Message-ID: <20191120190840.xhKXojEjVGGCMKYSgSnt-sZ732D-KkutzKN2dW26GRU@z>

T24gMjAxOS0xMS0yMCAxMzo0MCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMC4xMS4x
OSB1bSAxODo1MCBzY2hyaWViIEx1YmVuIFR1aWtvdjoKPj4gT24gMjAxOS0xMS0yMCAxMjoyNCwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDIwLjExLjE5IHVtIDE4OjE2IHNjaHJpZWIg
Q2hyaXN0aWFuIEvDtm5pZzoKPj4+PiBBbSAyMC4xMS4xOSB1bSAxNzo0OSBzY2hyaWViIEx1YmVu
IFR1aWtvdjoKPj4+Pj4gT24gMjAxOS0xMS0xOSAyMTo0MSwgTWFyZWsgT2zFocOhayB3cm90ZToK
Pj4+Pj4+IE9uIFR1ZSwgTm92IDE5LCAyMDE5IGF0IDg6NTIgUE0gTHViZW4gVHVpa292IDxsdWJl
bi50dWlrb3ZAYW1kLmNvbQo+Pj4+Pj4gPG1haWx0bzpsdWJlbi50dWlrb3ZAYW1kLmNvbT4+IHdy
b3RlOgo+Pj4+Pj4KPj4+Pj4+ICDCoMKgwqDCoCBPbiAyMDE5LTExLTE0IDEwOjM0IHAubS4sIEFh
cm9uIExpdSB3cm90ZToKPj4+Pj4+ICDCoMKgwqDCoCA+IEZyb206IEh1YW5nIFJ1aSA8cmF5Lmh1
YW5nQGFtZC5jb20gPG1haWx0bzpyYXkuaHVhbmdAYW1kLmNvbT4+Cj4+Pj4+PiAgwqDCoMKgwqAg
Pgo+Pj4+Pj4gIMKgwqDCoMKgID4gVG8gYWxpZ24gdGhlIGtlcm5lbCB1YXBpIGNoYW5nZSBmcm9t
IEFsZXg6Cj4+Pj4+PiAgwqDCoMKgwqAgPgo+Pj4+Pj4gIMKgwqDCoMKgID4gIkFkZCBhIGZsYWcg
dG8gdGhlIEdFTV9DUkVBVEUgaW9jdGwgdG8gY3JlYXRlIGVuY3J5cHRlZAo+Pj4+Pj4gYnVmZmVy
cy4gQnVmZmVycyB3aXRoCj4+Pj4+PiAgwqDCoMKgwqAgPiB0aGlzIGZsYWcgc2V0IHdpbGwgYmUg
Y3JlYXRlZCB3aXRoIHRoZSBUTVogYml0IHNldCBpbiB0aGUKPj4+Pj4+IFBURXMgb3IgZW5naW5l
cwo+Pj4+Pj4gIMKgwqDCoMKgID4gYWNjZXNzaW5nIHRoZW0uIFRoaXMgaXMgcmVxdWlyZWQgaW4g
b3JkZXIgdG8gcHJvcGVybHkgYWNjZXNzCj4+Pj4+PiB0aGUgZGF0YSBmcm9tIHRoZQo+Pj4+Pj4g
IMKgwqDCoMKgID4gZW5naW5lcy4iCj4+Pj4+PiAgwqDCoMKgwqAgPgo+Pj4+Pj4gIMKgwqDCoMKg
ID4gV2Ugd2lsbCB1c2UgR0VNX0NSRUFURV9FTkNSWVBURUQgZmxhZyBmb3Igc2VjdXJlIGJ1ZmZl
cgo+Pj4+Pj4gYWxsb2NhdGlvbi4KPj4+Pj4+ICDCoMKgwqDCoCA+Cj4+Pj4+PiAgwqDCoMKgwqAg
PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tCj4+Pj4+PiA8bWFp
bHRvOnJheS5odWFuZ0BhbWQuY29tPj4KPj4+Pj4+ICDCoMKgwqDCoCA+IFJldmlld2VkLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20KPj4+Pj4+IDxtYWlsdG86YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4+Cj4+Pj4+PiAgwqDCoMKgwqAgPiAtLS0KPj4+Pj4+ICDC
oMKgwqDCoCA+wqAgaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oIHwgNSArKysrKwo+Pj4+Pj4gIMKg
wqDCoMKgID7CoCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4+Pj4+PiAgwqDCoMKg
wqAgPgo+Pj4+Pj4gIMKgwqDCoMKgID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9k
cm0uaCBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAo+Pj4+Pj4gIMKgwqDCoMKgID4gaW5kZXgg
NWMyOGFhNy4uMWE5NWUzNyAxMDA2NDQKPj4+Pj4+ICDCoMKgwqDCoCA+IC0tLSBhL2luY2x1ZGUv
ZHJtL2FtZGdwdV9kcm0uaAo+Pj4+Pj4gIMKgwqDCoMKgID4gKysrIGIvaW5jbHVkZS9kcm0vYW1k
Z3B1X2RybS5oCj4+Pj4+PiAgwqDCoMKgwqAgPiBAQCAtMTQxLDYgKzE0MSwxMSBAQCBleHRlcm4g
IkMiIHsKPj4+Pj4+ICDCoMKgwqDCoCA+wqAgwqAqIHJlbGVhc2luZyB0aGUgbWVtb3J5Cj4+Pj4+
PiAgwqDCoMKgwqAgPsKgIMKgKi8KPj4+Pj4+ICDCoMKgwqDCoCA+wqAgI2RlZmluZSBBTURHUFVf
R0VNX0NSRUFURV9WUkFNX1dJUEVfT05fUkVMRUFTRSDCoCgxIDw8IDkpCj4+Pj4+PiAgwqDCoMKg
wqAgPiArLyogRmxhZyB0aGF0IEJPIHdpbGwgYmUgZW5jcnlwdGVkIGFuZCB0aGF0IHRoZSBUTVog
Yml0Cj4+Pj4+PiBzaG91bGQgYmUKPj4+Pj4+ICDCoMKgwqDCoCA+ICsgKiBzZXQgaW4gdGhlIFBU
RXMgd2hlbiBtYXBwaW5nIHRoaXMgYnVmZmVyIHZpYSBHUFVWTSBvcgo+Pj4+Pj4gIMKgwqDCoMKg
ID4gKyAqIGFjY2Vzc2luZyBpdCB3aXRoIHZhcmlvdXMgaHcgYmxvY2tzCj4+Pj4+PiAgwqDCoMKg
wqAgPiArICovCj4+Pj4+PiAgwqDCoMKgwqAgPiArI2RlZmluZSBBTURHUFVfR0VNX0NSRUFURV9F
TkNSWVBURUTCoCDCoCDCoCDCoCDCoCAoMSA8PCAxMCkKPj4+Pj4+Cj4+Pj4+PiAgwqDCoMKgwqAg
U3R5bGUhCj4+Pj4+PiAgwqDCoMKgwqAgVEFCIGNoYXI/IQo+Pj4+Pj4KPj4+Pj4+ICDCoMKgwqDC
oCBZb3UgaGF2ZSBhIFRBQiBjaGFyIGJldHdlZW4gIi4uX0VOQ1JZUFRFRCIgYW5kICIoMSA8PCAx
MCkiCj4+Pj4+PiAgwqDCoMKgwqAgRG8gTk9UIGFkZC9pbnNlcnQgVEFCIGNoYXJzIGluc3RlYWQg
b2Ygc3BhY2UgdG8gYWxpZ24gY29sdW5tbnMhCj4+Pj4+PiAgwqDCoMKgwqAgSWYgd2hlbiB5b3Ug
cHJlc3MgVGFiIGtleSBhIHRhYiBpcyBpbnNlcnRlZCwgYXMgb3Bwb3NlZCB0byB0aGUKPj4+Pj4+
IGxpbmUKPj4+Pj4+ICDCoMKgwqDCoCBpbmRlbnRlZCwgdGhlbiBETyBOT1QgdXNlIHRoaXMgZWRp
dG9yLgo+Pj4+Pj4gIMKgwqDCoMKgIFRoZSBUYWIga2V5IHNob3VsZCAiaW5kZW50IGFjY29yZGlu
ZyB0byBtb2RlIiBieSBpbnNlcnRpbmcgVEFCCj4+Pj4+PiBjaGFycy4KPj4+Pj4+ICDCoMKgwqDC
oCBJZiB0aGUgbGluZSBpcyBhbHJlYWR5IGluZGVudGVkLCBhcyB0aGlzIG9uZSBpcywgdGhlbiBp
dCBzaG91bGQKPj4+Pj4+IGRvIG5vdGhpbmcuCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IEkgZGlzYWdy
ZWUgd2l0aCB0aGlzIDEwMCUuIFRhYnMgb3Igc3BhY2VzIGRvbid0IG1hdHRlciBoZXJlIGZyb20g
bXkKPj4+Pj4+IHBlcnNwZWN0aXZlLiBJIGFsc28gZGlzYWdyZWUgd2l0aCB5b3VyIGxhbmd1YWdl
LiBJdCdzIG92ZXJseSBpbXBvbGl0ZS4KPj4+Pj4gQnV0IGl0J3MgdGhlIGNvZGluZyBzdHlsZSBv
ZiBMaW51eDogbGVhZGluZyB0YWJzIG9ubHkuIFRyeSBpdCB3aXRoCj4+Pj4+IEVtYWNzIGFzIGRl
c2NyaWJlZCBhbmQgZ2l2ZW4gaW4KPj4+Pj4KPj4+Pj4gbGludXgvRG9jdW1lbnRhdGlvbi9wcm9j
ZXNzL2NvZGluZy1zdHlsZS5yc3QKPj4+Pj4KPj4+Pj4gc3RhcnRpbmcgYXQgbGluZSA1ODkuIEFu
ZCBwcmVzcyB0aGUgVGFiIGtleSBvbiBhbiBhbHJlYWR5IGluZGVudGVkCj4+Pj4+IGxpbmUtLW5v
dGhpbmcgd2lsbCBoYXBwZW4uIExpbnV4IGhhcyB0cmFkaXRpb25hbGx5Cj4+Pj4+IHNodW5uZWQg
ZnJvbSBsb29zZSBUQUIgY2hhcnMgaW4gYWxyZWFkeSBpbmRlbnRlZCBsaW5lczogbGVhZGluZyB0
YWJzCj4+Pj4+IG9ubHkgbW9kZS4gSW4gYSBwcm9wZXIgY29kZSBlZGl0b3IKPj4+Pj4gcHJlc3Np
bmcgdGhlIFRhYiBrZXkgb25seSBpbmRlbnRzIGFjY29yZGluZyB0byBidWZmZXIgbW9kZSwgaXQK
Pj4+Pj4gc2hvdWxkbid0IGluc2VydCBhIFRhYiBjaGFyIHdpbGx5LW5pbGx5Lgo+Pj4+PiBQZW9w
bGUgbWF5IHNldCB0aGVpciB0YWIgc3RvcHMgZGlmZmVyZW50bHkgZm9yIGRpZmZlcmVudCB0YWIK
Pj4+Pj4gcG9zaXRpb25zIGFuZCBpbnNlcnRpbmcgYSB0YWIgY2hhciBtYXkgZGlzcGxheQo+Pj4+
PiBpbmNvcnJlY3RseS4gVGhlIG1vc3QgcG9ydGFibGUgd2F5IHRvIGFsaWduIGNvbHVtbnMgaW4g
YW4gYWxyZWFkeQo+Pj4+PiBpbmRlbnRlZC1hY2NvcmRpbmctdG8tbW9kZSBsaW5lLCBpcwo+Pj4+
PiB1c2luZyBzcGFjZXMuIChPZiBjb3Vyc2UgdGhpcyBkb2Vzbid0IG1hdHRlciB3aGVuIHVzaW5n
IHNwYWNlcyB0bwo+Pj4+PiBpbmRlbnQsIGJ1dCBMaW51eCB1c2VzIGhhcmQgVEFCIGNoYXJzCj4+
Pj4+IHRvIGluZGVudDogbGludXgvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5y
c3QuICh3aGljaCBhbHNvCj4+Pj4+IHNlZW0gdG8gYmUgc2V0IHRvIDggY2hhcnMpKQo+Pj4+Pgo+
Pj4+PiBJdCdzIGEgY29kZSByZXZpZXcsIHRoZXJlIGlzIG5vICJsYW5ndWFnZSIuCj4+Pj4gV2Vs
bCB0aGUgc2VjdGlvbiB5b3Ugbm90ZWQgYWxzbyBzdWdnZXN0IHRvIGVpdGhlciBnZXQgcmlkIG9m
IGVtYWNzIG9yCj4+Pj4gY2hhbmdlIGl0IHRvIHVzZSBzb21lIHNhbmVyIGRlZmF1bHQgdmFsdWVz
LiBXZSBqdXN0IGdvdCByaWQgb2YgZW1hY3MuCj4+IFllcywgaXQgc2F5cyB0aGlzLCBxdW90ZSAo
Zm9yIHRob3NlIHdobyBkaWRuJ3Qgb3BlbiB0aGUgZmlsZSk6Cj4+Cj4+IC0tODwtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPj4KPj4gVGhhdCdzIE9LLCB3ZSBhbGwgZG8uICBZb3UndmUgcHJvYmFibHkgYmVlbiB0b2xk
IGJ5IHlvdXIgbG9uZy10aW1lIFVuaXgKPj4gdXNlciBoZWxwZXIgdGhhdCBgYEdOVSBlbWFjc2Bg
IGF1dG9tYXRpY2FsbHkgZm9ybWF0cyB0aGUgQyBzb3VyY2VzIGZvcgo+PiB5b3UsIGFuZCB5b3Un
dmUgbm90aWNlZCB0aGF0IHllcywgaXQgZG9lcyBkbyB0aGF0LCBidXQgdGhlIGRlZmF1bHRzIGl0
Cj4+IHVzZXMgYXJlIGxlc3MgdGhhbiBkZXNpcmFibGUgKGluIGZhY3QsIHRoZXkgYXJlIHdvcnNl
IHRoYW4gcmFuZG9tCj4+IHR5cGluZyAtIGFuIGluZmluaXRlIG51bWJlciBvZiBtb25rZXlzIHR5
cGluZyBpbnRvIEdOVSBlbWFjcyB3b3VsZCBuZXZlcgo+PiBtYWtlIGEgZ29vZCBwcm9ncmFtKS4K
Pj4KPj4gU28sIHlvdSBjYW4gZWl0aGVyIGdldCByaWQgb2YgR05VIGVtYWNzLCBvciBjaGFuZ2Ug
aXQgdG8gdXNlIHNhbmVyCj4+IHZhbHVlcy4gIFRvIGRvIHRoZSBsYXR0ZXIsIHlvdSBjYW4gc3Rp
Y2sgdGhlIGZvbGxvd2luZyBpbiB5b3VyIC5lbWFjcyBmaWxlOgo+Pgo+PiAtLTg8LS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPj4KPj4+PiBSZWdhcmRpbmcgdGFicyBhZnRlciB0aGUgaW5pdGlhbCBpbmRlbnRhdGlvbiwg
SSd2ZSBqdXN0IGRvbmUgYSBxdWljawo+Pj4+IGdyZXAgYW5kIGFyb3VuZCAxNCUgb2YgYWxsIGRl
ZmluZXMgdW5kZXIgaW5jbHVkZS8gdXNlcyB0aGF0IHNvIEkgd291bGQKPj4+PiBzYXkgdGhhdCB0
aGlzIGlzIHBlcmZlY3RseSBmaW5lLgo+Pj4gRmFzdCB0eXBpbmcgd2l0aCBsYXp5IGV5ZXMsIHRo
YXQgc2hvdWxkIHJlYWQgImFyb3VuZCA3MSUgb2YgYWxsIGRlZmluZXMiLgo+PiBIbW0sIHRoYXQn
cyBpbnRlcmVzdGluZy4gSXMgdGhhdCBpbiBsaW51eC9pbmNsdWRlIG9yIGFtZGdwdS9pbmNsdWRl
Pwo+IAo+IGxpbnV4L2luY2x1ZGUKPiAKPj4KPj4gSSd2ZSBiZWVuIG1lYW5pbmcgdG8gZG8gbXkg
b3duIGV4dGVuZGVkIHJlZ2V4IHRvIGNhdGNoIHRob3NlLCBhbHRob3VnaAo+PiBJJ20gdXNpbmcg
RW1hY3MgYW5kIHByZXNzaW5nIFRhYiBrZXkgb25seSBpbmRlbnRzIGFuZCB3b3VsZCBub3QgaW5z
ZXJ0Cj4+IGEgVGFiIGNoYXIgaWYgYWxyZWFkeSBpbmRlbnRlZC4gKFNvIGFwcGx5aW5nIHRoaXMg
cmVnZXggaW50byB0aGUgcHJlLWNvbW1pdAo+PiBob29rIG9mIGFsbCBvZiBteSBHaXQgcmVwb3Mg
d291bGQgbmV2ZXIgdHJpZ2dlci4pCj4+Cj4+IEkgcmVtZW1iZXIgb2Ygb2xkZW4gZGF5cywgY2ly
Y2EgMjAwMCB3aGVuIEkgZmlyc3QgZ290IGludm9sdmVkIHdpdGggTGludXgsCj4+IExLTUwgZGlk
bid0IGxpa2UgbG9vc2UgdGFicy4gQWxzbyBsZWFkIGtlcm5lbCBkZXZlbG9wZXJzIGFyZSB1c2lu
ZyBFbWFjcywKPj4gc28gaXQncyBiZWVuIG15IGNob2ljZSBvZiBlZGl0b3Igc2luY2UgY2lyY2Eg
MTk5NCAoc3dpdGNoZWQgZnJvbSB2aSB0byBFbWFjcwo+PiBsYXJnZWx5IGR1ZSB0byB0aGUgaW5m
bHVlbmNlIG9mIGEgZ3JhcGhpY3MgcHJvZiBJIGhhZCBpbiBteSBzZW5pb3VyIHllYXIgb2YgdW5p
LAo+PiBhbmQgcGFydCBkdWUgdG8gTEtNTC4pCj4gCj4gV2VsbCBJJ3ZlIGJlZW4gd29ya2luZyB3
aXRoIHRoZSBMaW51eCBrZXJuZWwgc2luY2UgdGhlIG1pZCA5MHRocyBhbmQgCj4gbmV2ZXIgZXZl
ciBoZWFyZCBvZiB0aGF0LgoKSSBzZWUuIEhtbSwgaW50ZXJlc3RpbmcuIE15IGV4cGVyaWVuY2Ug
ZGlmZmVycy4KClJlZ2FyZGxlc3MsIGhlcmUgaXMgdGhlIHF1ZXN0aW9uOgoKSXMgaXQgdGhlbiBv
a2F5IHRvIGVtYmVkIGhhcmQgVEFCIGNoYXIgYW55d2hlcmUgaW4gYW4gYWxyZWFkeSBpbmRlbnRl
ZApsaW5lIG9mIGNvZGU/CgpGb3IgaW5zdGFuY2U6CgoJZm9yIChpID0gMDsgaSA8XHQxMDsgaSsr
KSB7CgppbnQgdGFibGVbXVszXSA9IHsKCXsgMixcdDMsICAgICAgNSB9LAoJeyAyLCAgICA0LFx0
NiB9LAoJeyAxLFx0MSxcdDIgfSwKfTsKCkJlY2F1c2UgaXQgd291bGQgcmVuZGVyIGNvcnJlY3Qg
b24gYW4gOC10YWIgc3RvcCBjb25maWd1cmVkIGVkaXRvci4KCklzIHRoaXMgb2theSwgYW5kIGFj
Y2VwdGFibGUsIGFjY29yZGluZyB0byB0aGUgTEtDUyAobGludXgvRG9jdW1lbnRhdGlvbi9wcm9j
ZXNzL2NvZGluZy1zdHlsZS5yc3QpPwoKUmVnYXJkcywKTHViZW4KCj4gCj4gQ2hyaXN0aWFuLgo+
IAo+Pgo+PiBUaGFua3MgZm9yIGNoaW1pbmcgaW4gQ2hyaXN0aWFuIQo+Pgo+PiBSZWdhcmRzLAo+
PiBMdWJlbgo+Pgo+Pj4gU29ycnksCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+IFJlZ2FyZHMsCj4+
Pj4gQ2hyaXN0aWFuLgo+Pj4+Cj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+IEx1YmVuCj4+Pj4+Cj4+Pj4+
PiBNYXJlawo+Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+Pj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+Pj4+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
