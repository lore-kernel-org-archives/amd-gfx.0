Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87725C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 10:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F5A20836
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 10:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F5A20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A7B89CB2;
	Tue, 26 Nov 2019 10:08:59 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720086.outbound.protection.outlook.com [40.107.72.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBC189CB2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 10:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f26ltrjmt+PeofhANVYSqdjx2usFNvOmeyBmdYxBN9MpC5e3muGvHUh4jUNbwRPjV7uXw+Ov/eqFQrcF6oX26cnvKajRjEDbrvxbMFs9ygEKHhGRL1zw2wEa3hZ7mbdeOrxOKWSe5S6qDbS0bDrl/+6L9dy2n/SOv62Y10eNUYOF5vUqx2rrRU6Nn8G0FoKkp+xoto5CLPoJmj84DARAEtj0E+s8VpRuYi46wnOnQbCycTrL41vuCLkmAHrqwk5P3tFiNIxDt2pWcLuwfU1QfniMaqqQ2cqBB8tnoSaQg/gDsxmTwVzNoVBYD9w0MH7tI2aP45zSJPzvs1mBVasErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtICukBh/f4Tt/qhj23ffrAwQK7Hg18Nu9KisxPciZg=;
 b=i52nzLNxVDt2jll3pePJLlDgFyY8/RaA1UPjsg27kPBkV5qHIej9JHVHg7LDamA3Wk/yITJhkefQhrXIHmibBrQnmb/MHhgKC+RW+bRixPYhf5ibT3oS2yaP5oiacPXq8AIJifiFXQSPjOv72oSsGLEKx005tJPUzdItk4nxT7lTlrx5ATGBZ+BDZpR/0u0HaahlpyLZ4t5gu9CFYno4KuUr8Kiq6wW0DndM3EVVehC2W+1McOAPDZoRb214KFOQJskM+Wv+feP8osRdJ3YAZvaGy0NmeiblvPe4+Drw9EMV7Lf+2801OrNIjgQRZ/t6PK2xNG8ooHJRZCGZ3E+Jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Tue, 26 Nov 2019 10:08:56 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 10:08:56 +0000
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: Luben Tuikov <luben.tuikov@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
 <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
 <cac7e351-dba8-125b-dc5d-b2fdec77731b@gmail.com>
 <0622cbcb-9b04-eed3-ad1e-7a40cc03c73a@amd.com>
 <31a1cde2-18ab-96f5-47a4-6f113cbc9e4a@amd.com>
 <069abbd5-564d-aca7-ddfb-2336d56982eb@gmail.com>
 <6ddda4a0-ed0e-eb29-e2f2-ba1e5cdbde1b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1d641192-3c65-cffb-7650-0dce2e3238e4@amd.com>
Date: Tue, 26 Nov 2019 11:08:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <6ddda4a0-ed0e-eb29-e2f2-ba1e5cdbde1b@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR19CA0093.namprd19.prod.outlook.com
 (2603:10b6:404:133::31) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa758277-1287-4b61-61e3-08d77258a5a4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:|DM5PR12MB1163:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1163A2CDAFAF14222A0388A583450@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(189003)(199004)(6512007)(6306002)(54906003)(31686004)(305945005)(65806001)(110136005)(11346002)(65956001)(58126008)(8676002)(8936002)(81166006)(81156014)(6436002)(36756003)(2616005)(14454004)(6666004)(66476007)(66556008)(66946007)(186003)(86362001)(31696002)(4326008)(229853002)(2870700001)(966005)(2906002)(47776003)(66574012)(6246003)(76176011)(2486003)(23676004)(52116002)(7736002)(53546011)(6506007)(386003)(316002)(5660300002)(4001150100001)(25786009)(14444005)(99286004)(446003)(50466002)(46003)(478600001)(6116002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1163;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jz9lxV9Uf+Y2Ct/hIIHfTyORzu5Hj9ukv2rcGR8iAZzd0oDguTiJOODoSzf5lSfPrMxC0lsUj1HFOyi8DHf/YJ02oOaP06lGN+C649FTj9g7s8oiEyJ2LXGz0LqfPv1ujZ+qyEN+GiHng65XLLKmnwkOD6h2xMFxAq7NMvY1gvrw9KTbMRVckliBXpGRGX/fmE+GVLVCvvgD+EYQRfPbDX8gheVmlpM1G4EZaEnd4IBKfXnzMr1WkfZulI8vYNdDSlQCSWl5O9bUFqgWRgGl/HTgSQaFGVMW4N0IgX+3De3Ko1yX3i1uYrHYFP/L4vFIQBMNdWDCHRVEOaRDlpEFU9R/1X0TTtuv75W2/sTDOlm4AtLEnURUbAc/896H0z5EyDswu9E6Bo3QDpdVybmXv/c8dlVlmmOGscUh6wEX1YvXuX0KvL41WyBP2GqsSDCi7lFXj87vl2/UIfZY6y0oWysUfq1uhyQ9q5s07QYkFpk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa758277-1287-4b61-61e3-08d77258a5a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 10:08:56.0525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlfWo3BKZGgx+rBJWFcct+1Kq59QXu42brR9jQVS+mCCAWSr1PkNbajNjmIgcnI5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtICukBh/f4Tt/qhj23ffrAwQK7Hg18Nu9KisxPciZg=;
 b=eJ+LDXp8F8j2kvb5c5J45CKMaJbf08x54D9rl9dl8wWVfv//TjyDE32YK9OVb7bsUUANr7zqNHnD0mRAnPEOD0wUZ7/Ppz8TwgsS4GUtbVvOQ2A114f/5XrOfe5X36WZ7MYSQ493lzf5D1qCdZuLWU0ytuzycI1BhMAzmfc3BNY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126100851.fw_cIMyompfCDB5Pd9RtAwYE8mmyFYjxQGokKF8aQwc@z>

QW0gMjAuMTEuMTkgdW0gMjA6MDggc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gT24gMjAxOS0xMS0y
MCAxMzo0MCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMjAuMTEuMTkgdW0gMTg6NTAg
c2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4+PiBPbiAyMDE5LTExLTIwIDEyOjI0LCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDIwLjExLjE5IHVtIDE4OjE2IHNjaHJpZWIgQ2hyaXN0aWFu
IEvDtm5pZzoKPj4+Pj4gQW0gMjAuMTEuMTkgdW0gMTc6NDkgc2NocmllYiBMdWJlbiBUdWlrb3Y6
Cj4+Pj4+PiBPbiAyMDE5LTExLTE5IDIxOjQxLCBNYXJlayBPbMWhw6FrIHdyb3RlOgo+Pj4+Pj4+
IE9uIFR1ZSwgTm92IDE5LCAyMDE5IGF0IDg6NTIgUE0gTHViZW4gVHVpa292IDxsdWJlbi50dWlr
b3ZAYW1kLmNvbQo+Pj4+Pj4+IDxtYWlsdG86bHViZW4udHVpa292QGFtZC5jb20+PiB3cm90ZToK
Pj4+Pj4+Pgo+Pj4+Pj4+ICAgwqDCoMKgwqAgT24gMjAxOS0xMS0xNCAxMDozNCBwLm0uLCBBYXJv
biBMaXUgd3JvdGU6Cj4+Pj4+Pj4gICDCoMKgwqDCoCA+IEZyb206IEh1YW5nIFJ1aSA8cmF5Lmh1
YW5nQGFtZC5jb20gPG1haWx0bzpyYXkuaHVhbmdAYW1kLmNvbT4+Cj4+Pj4+Pj4gICDCoMKgwqDC
oCA+Cj4+Pj4+Pj4gICDCoMKgwqDCoCA+IFRvIGFsaWduIHRoZSBrZXJuZWwgdWFwaSBjaGFuZ2Ug
ZnJvbSBBbGV4Ogo+Pj4+Pj4+ICAgwqDCoMKgwqAgPgo+Pj4+Pj4+ICAgwqDCoMKgwqAgPiAiQWRk
IGEgZmxhZyB0byB0aGUgR0VNX0NSRUFURSBpb2N0bCB0byBjcmVhdGUgZW5jcnlwdGVkCj4+Pj4+
Pj4gYnVmZmVycy4gQnVmZmVycyB3aXRoCj4+Pj4+Pj4gICDCoMKgwqDCoCA+IHRoaXMgZmxhZyBz
ZXQgd2lsbCBiZSBjcmVhdGVkIHdpdGggdGhlIFRNWiBiaXQgc2V0IGluIHRoZQo+Pj4+Pj4+IFBU
RXMgb3IgZW5naW5lcwo+Pj4+Pj4+ICAgwqDCoMKgwqAgPiBhY2Nlc3NpbmcgdGhlbS4gVGhpcyBp
cyByZXF1aXJlZCBpbiBvcmRlciB0byBwcm9wZXJseSBhY2Nlc3MKPj4+Pj4+PiB0aGUgZGF0YSBm
cm9tIHRoZQo+Pj4+Pj4+ICAgwqDCoMKgwqAgPiBlbmdpbmVzLiIKPj4+Pj4+PiAgIMKgwqDCoMKg
ID4KPj4+Pj4+PiAgIMKgwqDCoMKgID4gV2Ugd2lsbCB1c2UgR0VNX0NSRUFURV9FTkNSWVBURUQg
ZmxhZyBmb3Igc2VjdXJlIGJ1ZmZlcgo+Pj4+Pj4+IGFsbG9jYXRpb24uCj4+Pj4+Pj4gICDCoMKg
wqDCoCA+Cj4+Pj4+Pj4gICDCoMKgwqDCoCA+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5
Lmh1YW5nQGFtZC5jb20KPj4+Pj4+PiA8bWFpbHRvOnJheS5odWFuZ0BhbWQuY29tPj4KPj4+Pj4+
PiAgIMKgwqDCoMKgID4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbQo+Pj4+Pj4+IDxtYWlsdG86YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4+Cj4+
Pj4+Pj4gICDCoMKgwqDCoCA+IC0tLQo+Pj4+Pj4+ICAgwqDCoMKgwqAgPsKgIGluY2x1ZGUvZHJt
L2FtZGdwdV9kcm0uaCB8IDUgKysrKysKPj4+Pj4+PiAgIMKgwqDCoMKgID7CoCAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspCj4+Pj4+Pj4gICDCoMKgwqDCoCA+Cj4+Pj4+Pj4gICDCoMKg
wqDCoCA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL2Ry
bS9hbWRncHVfZHJtLmgKPj4+Pj4+PiAgIMKgwqDCoMKgID4gaW5kZXggNWMyOGFhNy4uMWE5NWUz
NyAxMDA2NDQKPj4+Pj4+PiAgIMKgwqDCoMKgID4gLS0tIGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2Ry
bS5oCj4+Pj4+Pj4gICDCoMKgwqDCoCA+ICsrKyBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAo+
Pj4+Pj4+ICAgwqDCoMKgwqAgPiBAQCAtMTQxLDYgKzE0MSwxMSBAQCBleHRlcm4gIkMiIHsKPj4+
Pj4+PiAgIMKgwqDCoMKgID7CoCDCoCogcmVsZWFzaW5nIHRoZSBtZW1vcnkKPj4+Pj4+PiAgIMKg
wqDCoMKgID7CoCDCoCovCj4+Pj4+Pj4gICDCoMKgwqDCoCA+wqAgI2RlZmluZSBBTURHUFVfR0VN
X0NSRUFURV9WUkFNX1dJUEVfT05fUkVMRUFTRSDCoCgxIDw8IDkpCj4+Pj4+Pj4gICDCoMKgwqDC
oCA+ICsvKiBGbGFnIHRoYXQgQk8gd2lsbCBiZSBlbmNyeXB0ZWQgYW5kIHRoYXQgdGhlIFRNWiBi
aXQKPj4+Pj4+PiBzaG91bGQgYmUKPj4+Pj4+PiAgIMKgwqDCoMKgID4gKyAqIHNldCBpbiB0aGUg
UFRFcyB3aGVuIG1hcHBpbmcgdGhpcyBidWZmZXIgdmlhIEdQVVZNIG9yCj4+Pj4+Pj4gICDCoMKg
wqDCoCA+ICsgKiBhY2Nlc3NpbmcgaXQgd2l0aCB2YXJpb3VzIGh3IGJsb2Nrcwo+Pj4+Pj4+ICAg
wqDCoMKgwqAgPiArICovCj4+Pj4+Pj4gICDCoMKgwqDCoCA+ICsjZGVmaW5lIEFNREdQVV9HRU1f
Q1JFQVRFX0VOQ1JZUFRFRMKgIMKgIMKgIMKgIMKgICgxIDw8IDEwKQo+Pj4+Pj4+Cj4+Pj4+Pj4g
ICDCoMKgwqDCoCBTdHlsZSEKPj4+Pj4+PiAgIMKgwqDCoMKgIFRBQiBjaGFyPyEKPj4+Pj4+Pgo+
Pj4+Pj4+ICAgwqDCoMKgwqAgWW91IGhhdmUgYSBUQUIgY2hhciBiZXR3ZWVuICIuLl9FTkNSWVBU
RUQiIGFuZCAiKDEgPDwgMTApIgo+Pj4+Pj4+ICAgwqDCoMKgwqAgRG8gTk9UIGFkZC9pbnNlcnQg
VEFCIGNoYXJzIGluc3RlYWQgb2Ygc3BhY2UgdG8gYWxpZ24gY29sdW5tbnMhCj4+Pj4+Pj4gICDC
oMKgwqDCoCBJZiB3aGVuIHlvdSBwcmVzcyBUYWIga2V5IGEgdGFiIGlzIGluc2VydGVkLCBhcyBv
cHBvc2VkIHRvIHRoZQo+Pj4+Pj4+IGxpbmUKPj4+Pj4+PiAgIMKgwqDCoMKgIGluZGVudGVkLCB0
aGVuIERPIE5PVCB1c2UgdGhpcyBlZGl0b3IuCj4+Pj4+Pj4gICDCoMKgwqDCoCBUaGUgVGFiIGtl
eSBzaG91bGQgImluZGVudCBhY2NvcmRpbmcgdG8gbW9kZSIgYnkgaW5zZXJ0aW5nIFRBQgo+Pj4+
Pj4+IGNoYXJzLgo+Pj4+Pj4+ICAgwqDCoMKgwqAgSWYgdGhlIGxpbmUgaXMgYWxyZWFkeSBpbmRl
bnRlZCwgYXMgdGhpcyBvbmUgaXMsIHRoZW4gaXQgc2hvdWxkCj4+Pj4+Pj4gZG8gbm90aGluZy4K
Pj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gSSBkaXNhZ3JlZSB3aXRoIHRoaXMgMTAwJS4gVGFicyBv
ciBzcGFjZXMgZG9uJ3QgbWF0dGVyIGhlcmUgZnJvbSBteQo+Pj4+Pj4+IHBlcnNwZWN0aXZlLiBJ
IGFsc28gZGlzYWdyZWUgd2l0aCB5b3VyIGxhbmd1YWdlLiBJdCdzIG92ZXJseSBpbXBvbGl0ZS4K
Pj4+Pj4+IEJ1dCBpdCdzIHRoZSBjb2Rpbmcgc3R5bGUgb2YgTGludXg6IGxlYWRpbmcgdGFicyBv
bmx5LiBUcnkgaXQgd2l0aAo+Pj4+Pj4gRW1hY3MgYXMgZGVzY3JpYmVkIGFuZCBnaXZlbiBpbgo+
Pj4+Pj4KPj4+Pj4+IGxpbnV4L0RvY3VtZW50YXRpb24vcHJvY2Vzcy9jb2Rpbmctc3R5bGUucnN0
Cj4+Pj4+Pgo+Pj4+Pj4gc3RhcnRpbmcgYXQgbGluZSA1ODkuIEFuZCBwcmVzcyB0aGUgVGFiIGtl
eSBvbiBhbiBhbHJlYWR5IGluZGVudGVkCj4+Pj4+PiBsaW5lLS1ub3RoaW5nIHdpbGwgaGFwcGVu
LiBMaW51eCBoYXMgdHJhZGl0aW9uYWxseQo+Pj4+Pj4gc2h1bm5lZCBmcm9tIGxvb3NlIFRBQiBj
aGFycyBpbiBhbHJlYWR5IGluZGVudGVkIGxpbmVzOiBsZWFkaW5nIHRhYnMKPj4+Pj4+IG9ubHkg
bW9kZS4gSW4gYSBwcm9wZXIgY29kZSBlZGl0b3IKPj4+Pj4+IHByZXNzaW5nIHRoZSBUYWIga2V5
IG9ubHkgaW5kZW50cyBhY2NvcmRpbmcgdG8gYnVmZmVyIG1vZGUsIGl0Cj4+Pj4+PiBzaG91bGRu
J3QgaW5zZXJ0IGEgVGFiIGNoYXIgd2lsbHktbmlsbHkuCj4+Pj4+PiBQZW9wbGUgbWF5IHNldCB0
aGVpciB0YWIgc3RvcHMgZGlmZmVyZW50bHkgZm9yIGRpZmZlcmVudCB0YWIKPj4+Pj4+IHBvc2l0
aW9ucyBhbmQgaW5zZXJ0aW5nIGEgdGFiIGNoYXIgbWF5IGRpc3BsYXkKPj4+Pj4+IGluY29ycmVj
dGx5LiBUaGUgbW9zdCBwb3J0YWJsZSB3YXkgdG8gYWxpZ24gY29sdW1ucyBpbiBhbiBhbHJlYWR5
Cj4+Pj4+PiBpbmRlbnRlZC1hY2NvcmRpbmctdG8tbW9kZSBsaW5lLCBpcwo+Pj4+Pj4gdXNpbmcg
c3BhY2VzLiAoT2YgY291cnNlIHRoaXMgZG9lc24ndCBtYXR0ZXIgd2hlbiB1c2luZyBzcGFjZXMg
dG8KPj4+Pj4+IGluZGVudCwgYnV0IExpbnV4IHVzZXMgaGFyZCBUQUIgY2hhcnMKPj4+Pj4+IHRv
IGluZGVudDogbGludXgvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3QuICh3
aGljaCBhbHNvCj4+Pj4+PiBzZWVtIHRvIGJlIHNldCB0byA4IGNoYXJzKSkKPj4+Pj4+Cj4+Pj4+
PiBJdCdzIGEgY29kZSByZXZpZXcsIHRoZXJlIGlzIG5vICJsYW5ndWFnZSIuCj4+Pj4+IFdlbGwg
dGhlIHNlY3Rpb24geW91IG5vdGVkIGFsc28gc3VnZ2VzdCB0byBlaXRoZXIgZ2V0IHJpZCBvZiBl
bWFjcyBvcgo+Pj4+PiBjaGFuZ2UgaXQgdG8gdXNlIHNvbWUgc2FuZXIgZGVmYXVsdCB2YWx1ZXMu
IFdlIGp1c3QgZ290IHJpZCBvZiBlbWFjcy4KPj4+IFllcywgaXQgc2F5cyB0aGlzLCBxdW90ZSAo
Zm9yIHRob3NlIHdobyBkaWRuJ3Qgb3BlbiB0aGUgZmlsZSk6Cj4+Pgo+Pj4gLS04PC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+Pj4KPj4+IFRoYXQncyBPSywgd2UgYWxsIGRvLiAgWW91J3ZlIHByb2JhYmx5IGJlZW4g
dG9sZCBieSB5b3VyIGxvbmctdGltZSBVbml4Cj4+PiB1c2VyIGhlbHBlciB0aGF0IGBgR05VIGVt
YWNzYGAgYXV0b21hdGljYWxseSBmb3JtYXRzIHRoZSBDIHNvdXJjZXMgZm9yCj4+PiB5b3UsIGFu
ZCB5b3UndmUgbm90aWNlZCB0aGF0IHllcywgaXQgZG9lcyBkbyB0aGF0LCBidXQgdGhlIGRlZmF1
bHRzIGl0Cj4+PiB1c2VzIGFyZSBsZXNzIHRoYW4gZGVzaXJhYmxlIChpbiBmYWN0LCB0aGV5IGFy
ZSB3b3JzZSB0aGFuIHJhbmRvbQo+Pj4gdHlwaW5nIC0gYW4gaW5maW5pdGUgbnVtYmVyIG9mIG1v
bmtleXMgdHlwaW5nIGludG8gR05VIGVtYWNzIHdvdWxkIG5ldmVyCj4+PiBtYWtlIGEgZ29vZCBw
cm9ncmFtKS4KPj4+Cj4+PiBTbywgeW91IGNhbiBlaXRoZXIgZ2V0IHJpZCBvZiBHTlUgZW1hY3Ms
IG9yIGNoYW5nZSBpdCB0byB1c2Ugc2FuZXIKPj4+IHZhbHVlcy4gIFRvIGRvIHRoZSBsYXR0ZXIs
IHlvdSBjYW4gc3RpY2sgdGhlIGZvbGxvd2luZyBpbiB5b3VyIC5lbWFjcyBmaWxlOgo+Pj4KPj4+
IC0tODwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+Pj4KPj4+Pj4gUmVnYXJkaW5nIHRhYnMgYWZ0ZXIgdGhlIGluaXRp
YWwgaW5kZW50YXRpb24sIEkndmUganVzdCBkb25lIGEgcXVpY2sKPj4+Pj4gZ3JlcCBhbmQgYXJv
dW5kIDE0JSBvZiBhbGwgZGVmaW5lcyB1bmRlciBpbmNsdWRlLyB1c2VzIHRoYXQgc28gSSB3b3Vs
ZAo+Pj4+PiBzYXkgdGhhdCB0aGlzIGlzIHBlcmZlY3RseSBmaW5lLgo+Pj4+IEZhc3QgdHlwaW5n
IHdpdGggbGF6eSBleWVzLCB0aGF0IHNob3VsZCByZWFkICJhcm91bmQgNzElIG9mIGFsbCBkZWZp
bmVzIi4KPj4+IEhtbSwgdGhhdCdzIGludGVyZXN0aW5nLiBJcyB0aGF0IGluIGxpbnV4L2luY2x1
ZGUgb3IgYW1kZ3B1L2luY2x1ZGU/Cj4+IGxpbnV4L2luY2x1ZGUKPj4KPj4+IEkndmUgYmVlbiBt
ZWFuaW5nIHRvIGRvIG15IG93biBleHRlbmRlZCByZWdleCB0byBjYXRjaCB0aG9zZSwgYWx0aG91
Z2gKPj4+IEknbSB1c2luZyBFbWFjcyBhbmQgcHJlc3NpbmcgVGFiIGtleSBvbmx5IGluZGVudHMg
YW5kIHdvdWxkIG5vdCBpbnNlcnQKPj4+IGEgVGFiIGNoYXIgaWYgYWxyZWFkeSBpbmRlbnRlZC4g
KFNvIGFwcGx5aW5nIHRoaXMgcmVnZXggaW50byB0aGUgcHJlLWNvbW1pdAo+Pj4gaG9vayBvZiBh
bGwgb2YgbXkgR2l0IHJlcG9zIHdvdWxkIG5ldmVyIHRyaWdnZXIuKQo+Pj4KPj4+IEkgcmVtZW1i
ZXIgb2Ygb2xkZW4gZGF5cywgY2lyY2EgMjAwMCB3aGVuIEkgZmlyc3QgZ290IGludm9sdmVkIHdp
dGggTGludXgsCj4+PiBMS01MIGRpZG4ndCBsaWtlIGxvb3NlIHRhYnMuIEFsc28gbGVhZCBrZXJu
ZWwgZGV2ZWxvcGVycyBhcmUgdXNpbmcgRW1hY3MsCj4+PiBzbyBpdCdzIGJlZW4gbXkgY2hvaWNl
IG9mIGVkaXRvciBzaW5jZSBjaXJjYSAxOTk0IChzd2l0Y2hlZCBmcm9tIHZpIHRvIEVtYWNzCj4+
PiBsYXJnZWx5IGR1ZSB0byB0aGUgaW5mbHVlbmNlIG9mIGEgZ3JhcGhpY3MgcHJvZiBJIGhhZCBp
biBteSBzZW5pb3VyIHllYXIgb2YgdW5pLAo+Pj4gYW5kIHBhcnQgZHVlIHRvIExLTUwuKQo+PiBX
ZWxsIEkndmUgYmVlbiB3b3JraW5nIHdpdGggdGhlIExpbnV4IGtlcm5lbCBzaW5jZSB0aGUgbWlk
IDkwdGhzIGFuZAo+PiBuZXZlciBldmVyIGhlYXJkIG9mIHRoYXQuCj4gSSBzZWUuIEhtbSwgaW50
ZXJlc3RpbmcuIE15IGV4cGVyaWVuY2UgZGlmZmVycy4KPgo+IFJlZ2FyZGxlc3MsIGhlcmUgaXMg
dGhlIHF1ZXN0aW9uOgo+Cj4gSXMgaXQgdGhlbiBva2F5IHRvIGVtYmVkIGhhcmQgVEFCIGNoYXIg
YW55d2hlcmUgaW4gYW4gYWxyZWFkeSBpbmRlbnRlZAo+IGxpbmUgb2YgY29kZT8KPgo+IEZvciBp
bnN0YW5jZToKPgo+IAlmb3IgKGkgPSAwOyBpIDxcdDEwOyBpKyspIHsKPgo+IGludCB0YWJsZVtd
WzNdID0gewo+IAl7IDIsXHQzLCAgICAgIDUgfSwKPiAJeyAyLCAgICA0LFx0NiB9LAo+IAl7IDEs
XHQxLFx0MiB9LAo+IH07Cj4KPiBCZWNhdXNlIGl0IHdvdWxkIHJlbmRlciBjb3JyZWN0IG9uIGFu
IDgtdGFiIHN0b3AgY29uZmlndXJlZCBlZGl0b3IuCgpBdCBsZWFzdCB0byB0aG9zZSBleGFtcGxl
cyBJIHdvdWxkIHNheSBubyBjYXVzZSB0aGV5IHVzZSB0YWIgYW5kIHNwYWNlcyAKaW5jb25zaXN0
ZW50bHkuCgo+IElzIHRoaXMgb2theSwgYW5kIGFjY2VwdGFibGUsIGFjY29yZGluZyB0byB0aGUg
TEtDUyAobGludXgvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3QpPwoKQXMg
bG9uZyBhcyB5b3UgaW5kZW50IGNvbnNpc3RlbnRseSBJIHRoaW5rIGl0IGlzIG9rLiBGb3IgZXhh
bXBsZSBtb3N0IApkZWZpbmVzIHNlZW0gdG8gbG9vayBsaWtlIHRoZSBwYXR0ZXJuICIjZGVmaW5l
IE5BTUVcdCtWQUxVRSIuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiBMdWJl
bgo+Cj4+IENocmlzdGlhbi4KPj4KPj4+IFRoYW5rcyBmb3IgY2hpbWluZyBpbiBDaHJpc3RpYW4h
Cj4+Pgo+Pj4gUmVnYXJkcywKPj4+IEx1YmVuCj4+Pgo+Pj4+IFNvcnJ5LAo+Pj4+IENocmlzdGlh
bi4KPj4+Pgo+Pj4+PiBSZWdhcmRzLAo+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Cj4+Pj4+PiBSZWdh
cmRzLAo+Pj4+Pj4gTHViZW4KPj4+Pj4+Cj4+Pj4+Pj4gTWFyZWsKPj4+Pj4+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+Pj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+Pj4+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+Pj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
