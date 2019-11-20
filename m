Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C798C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 16:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA37620885
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 16:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA37620885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58A56EA99;
	Wed, 20 Nov 2019 16:49:36 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690078.outbound.protection.outlook.com [40.107.69.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9965C6EA99
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 16:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWi9a9sxIU2cPp4EiJSdY3ZPyy/JPTTtAa/TzaDSKEhQkB9A96GffYRV187ghX9mrgTjMJRPt0mXGUp27lbznc14d+G6L+QrAVW7BGJG8K8DCTFW19qzp3sX4YRxO9eDshlsBy4H9zE76TwAEx4hTipG04X1KpFfSIN0XS1c1Zsp459ju/mrhpQT9kqQmhiulaDK2Ow+wxBnn3lEb8tUaLcLpV8oA91dPRY3LA/dEMzeTm8PXfmUraT5Yw450TYIYxRcUHNMe0gT6rVKIA5kxAAJhyr7IPVCaehiOhf3MKFSDKR5OYNhwokqS/lyQZB7jMqiUSL1ilbWC883SySMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ItLrHKZ5do4xK2fcfrjRLXRv+2zYSOELjWms5g//oc=;
 b=d5r7kXyVWMOydxl9seGmqVQ22BjPedSaz2OiHlH60GZh+KVX4VeJYW0K98eaydskoeIoIYXk2vRXtR4fQydj1Gef9iX5r5v2QqjyAMv8gcvA5YmnjoekdsdjkvaqH0inKhWLabUcxP2jB4MLUTffaHXSyEe7qxNngit7hQjsggsGQH3W478b2abY9E3jv9BugMLopVDGRxKdTndpCK9dFjmenj+KtuOFUwzr8r4u80pXJWEHyoBvhrMIc0C4pksxZ0gqG//jPdghpTfnlZss/rAQS7xd1A7/e9zg5IfzbUIuwG54nHXJQmPceGsvuLC0lKEdQMfhVq02ZiUG9+qAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3351.namprd12.prod.outlook.com (20.178.55.24) by
 BYAPR12MB3126.namprd12.prod.outlook.com (20.178.55.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 16:49:34 +0000
Received: from BYAPR12MB3351.namprd12.prod.outlook.com
 ([fe80::2db7:95fe:a576:f3a]) by BYAPR12MB3351.namprd12.prod.outlook.com
 ([fe80::2db7:95fe:a576:f3a%4]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 16:49:34 +0000
Subject: Re: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
 <6cba1e53-1c0d-d408-4d16-cae93ec9e62e@amd.com>
 <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <60f3793f-c568-798c-a516-870d2d20d8d8@amd.com>
Date: Wed, 20 Nov 2019 11:49:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <CAAxE2A6ZdjfV1vWh1KQmTR+gVFq0n098Gg8bWjprwdqvUQGQoQ@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: BN6PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:404:11::29) To BYAPR12MB3351.namprd12.prod.outlook.com
 (2603:10b6:a03:de::24)
MIME-Version: 1.0
X-Originating-IP: [165.204.11.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47f136e5-9894-4fe7-fdb7-08d76dd99edf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3126FFC12F0144BCE9B0002E994F0@BYAPR12MB3126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(486006)(6506007)(6246003)(53546011)(14454004)(14444005)(4326008)(54906003)(386003)(66066001)(186003)(65806001)(47776003)(26005)(31696002)(52116002)(2486003)(65956001)(66556008)(66476007)(229853002)(6512007)(31686004)(6116002)(4001150100001)(3846002)(7736002)(50466002)(6436002)(2906002)(76176011)(6486002)(6916009)(11346002)(8936002)(1411001)(86362001)(23676004)(2616005)(36756003)(478600001)(81156014)(81166006)(2870700001)(25786009)(476003)(446003)(8676002)(44832011)(316002)(58126008)(99286004)(66946007)(305945005)(6666004)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3126;
 H:BYAPR12MB3351.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVm6v90O8PxzD4RPoF7v1zr7HXgMUA4mtfU6a5bUNrsB4gKL8B7JiEjYx/VJu03qLOW/nQL9cqYdzlilT+JA3tOdCGwSpQsBwB6ymOFIxAAaSF08ypgj91NoulUITwUTpN6qHlQ5jwCf66BJYn69I9Hgih34/TugkrKpP3/1nUKiWDa7Y3H+VZ/MoP6QpZiurK44fAkDjqNxzuBZe9KdzRCfvEi3hygYy3XPfYPz4MkixWM078X8OhXYiEXHt2/CVZxfu0wORf+woVmWhMlNB2pYxP1h6+KylS4/TobzuoICFCJcRCQoaNX2u63S5l05AmLWpxkzLLcL7a/eOGv7oHhIV+K/c14ycxOHs8YlgHwfL9//B6a2Ed4RcoS2T6v14+WL1yXRc3HH7d3JJYFVRtxGCN+ZYNgBzdSru3GzbNAGtwYMZgUMnVYNBzyosiMq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f136e5-9894-4fe7-fdb7-08d76dd99edf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 16:49:34.1392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il7rDLct9eCVJNl3IeC8gcQEVt9jwFGR4ZMlmvMkYqB+6V/KskKmq33ElMtDPtoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ItLrHKZ5do4xK2fcfrjRLXRv+2zYSOELjWms5g//oc=;
 b=sqwVbGJlqn0FdcsIOyvkIJBUdDZfjKndLzKnQIfhJVnrEHP6c2q5PhNggsr9Qs4Zv3BHvhJddezKqUi+QKO1g9xVFT+LrsJvynZ4KifWuzUt+eM76zwqOeL6NmaTEL4E+5SafmeKCjv/CE3Y3Bpv3RDgGBQienzLuGcY31opQwE=
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
 Alexander" <Alexander.Deucher@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120164930.i_xxavraNmnZdpHoT-LRYZWbpm33dX9HQqln6TgpjwY@z>

T24gMjAxOS0xMS0xOSAyMTo0MSwgTWFyZWsgT2zFocOhayB3cm90ZToKPiBPbiBUdWUsIE5vdiAx
OSwgMjAxOSBhdCA4OjUyIFBNIEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20gPG1h
aWx0bzpsdWJlbi50dWlrb3ZAYW1kLmNvbT4+IHdyb3RlOgo+IAo+ICAgICBPbiAyMDE5LTExLTE0
IDEwOjM0IHAubS4sIEFhcm9uIExpdSB3cm90ZToKPiAgICAgPiBGcm9tOiBIdWFuZyBSdWkgPHJh
eS5odWFuZ0BhbWQuY29tIDxtYWlsdG86cmF5Lmh1YW5nQGFtZC5jb20+Pgo+ICAgICA+Cj4gICAg
ID4gVG8gYWxpZ24gdGhlIGtlcm5lbCB1YXBpIGNoYW5nZSBmcm9tIEFsZXg6Cj4gICAgID4KPiAg
ICAgPiAiQWRkIGEgZmxhZyB0byB0aGUgR0VNX0NSRUFURSBpb2N0bCB0byBjcmVhdGUgZW5jcnlw
dGVkIGJ1ZmZlcnMuIEJ1ZmZlcnMgd2l0aAo+ICAgICA+IHRoaXMgZmxhZyBzZXQgd2lsbCBiZSBj
cmVhdGVkIHdpdGggdGhlIFRNWiBiaXQgc2V0IGluIHRoZSBQVEVzIG9yIGVuZ2luZXMKPiAgICAg
PiBhY2Nlc3NpbmcgdGhlbS4gVGhpcyBpcyByZXF1aXJlZCBpbiBvcmRlciB0byBwcm9wZXJseSBh
Y2Nlc3MgdGhlIGRhdGEgZnJvbSB0aGUKPiAgICAgPiBlbmdpbmVzLiIKPiAgICAgPgo+ICAgICA+
IFdlIHdpbGwgdXNlIEdFTV9DUkVBVEVfRU5DUllQVEVEIGZsYWcgZm9yIHNlY3VyZSBidWZmZXIg
YWxsb2NhdGlvbi4KPiAgICAgPgo+ICAgICA+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5
Lmh1YW5nQGFtZC5jb20gPG1haWx0bzpyYXkuaHVhbmdAYW1kLmNvbT4+Cj4gICAgID4gUmV2aWV3
ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbSA8bWFpbHRvOmFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Pgo+ICAgICA+IC0tLQo+ICAgICA+wqAgaW5jbHVkZS9k
cm0vYW1kZ3B1X2RybS5oIHwgNSArKysrKwo+ICAgICA+wqAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQo+ICAgICA+Cj4gICAgID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdw
dV9kcm0uaCBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaAo+ICAgICA+IGluZGV4IDVjMjhhYTcu
LjFhOTVlMzcgMTAwNjQ0Cj4gICAgID4gLS0tIGEvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCj4g
ICAgID4gKysrIGIvaW5jbHVkZS9kcm0vYW1kZ3B1X2RybS5oCj4gICAgID4gQEAgLTE0MSw2ICsx
NDEsMTEgQEAgZXh0ZXJuICJDIiB7Cj4gICAgID7CoCDCoCogcmVsZWFzaW5nIHRoZSBtZW1vcnkK
PiAgICAgPsKgIMKgKi8KPiAgICAgPsKgICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9X
SVBFX09OX1JFTEVBU0XCoCDCoCDCoCDCoCgxIDw8IDkpCj4gICAgID4gKy8qIEZsYWcgdGhhdCBC
TyB3aWxsIGJlIGVuY3J5cHRlZCBhbmQgdGhhdCB0aGUgVE1aIGJpdCBzaG91bGQgYmUKPiAgICAg
PiArICogc2V0IGluIHRoZSBQVEVzIHdoZW4gbWFwcGluZyB0aGlzIGJ1ZmZlciB2aWEgR1BVVk0g
b3IKPiAgICAgPiArICogYWNjZXNzaW5nIGl0IHdpdGggdmFyaW91cyBodyBibG9ja3MKPiAgICAg
PiArICovCj4gICAgID4gKyNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEwqAgwqAg
wqAgwqAgwqAgKDEgPDwgMTApCj4gCj4gICAgIFN0eWxlIQo+ICAgICBUQUIgY2hhcj8hCj4gCj4g
ICAgIFlvdSBoYXZlIGEgVEFCIGNoYXIgYmV0d2VlbiAiLi5fRU5DUllQVEVEIiBhbmQgIigxIDw8
IDEwKSIKPiAgICAgRG8gTk9UIGFkZC9pbnNlcnQgVEFCIGNoYXJzIGluc3RlYWQgb2Ygc3BhY2Ug
dG8gYWxpZ24gY29sdW5tbnMhCj4gICAgIElmIHdoZW4geW91IHByZXNzIFRhYiBrZXkgYSB0YWIg
aXMgaW5zZXJ0ZWQsIGFzIG9wcG9zZWQgdG8gdGhlIGxpbmUKPiAgICAgaW5kZW50ZWQsIHRoZW4g
RE8gTk9UIHVzZSB0aGlzIGVkaXRvci4KPiAgICAgVGhlIFRhYiBrZXkgc2hvdWxkICJpbmRlbnQg
YWNjb3JkaW5nIHRvIG1vZGUiIGJ5IGluc2VydGluZyBUQUIgY2hhcnMuCj4gICAgIElmIHRoZSBs
aW5lIGlzIGFscmVhZHkgaW5kZW50ZWQsIGFzIHRoaXMgb25lIGlzLCB0aGVuIGl0IHNob3VsZCBk
byBub3RoaW5nLgo+IAo+IAo+IEkgZGlzYWdyZWUgd2l0aCB0aGlzIDEwMCUuIFRhYnMgb3Igc3Bh
Y2VzIGRvbid0IG1hdHRlciBoZXJlIGZyb20gbXkgcGVyc3BlY3RpdmUuIEkgYWxzbyBkaXNhZ3Jl
ZSB3aXRoIHlvdXIgbGFuZ3VhZ2UuIEl0J3Mgb3Zlcmx5IGltcG9saXRlLgoKQnV0IGl0J3MgdGhl
IGNvZGluZyBzdHlsZSBvZiBMaW51eDogbGVhZGluZyB0YWJzIG9ubHkuIFRyeSBpdCB3aXRoIEVt
YWNzIGFzIGRlc2NyaWJlZCBhbmQgZ2l2ZW4gaW4KCmxpbnV4L0RvY3VtZW50YXRpb24vcHJvY2Vz
cy9jb2Rpbmctc3R5bGUucnN0CgpzdGFydGluZyBhdCBsaW5lIDU4OS4gQW5kIHByZXNzIHRoZSBU
YWIga2V5IG9uIGFuIGFscmVhZHkgaW5kZW50ZWQgbGluZS0tbm90aGluZyB3aWxsIGhhcHBlbi4g
TGludXggaGFzIHRyYWRpdGlvbmFsbHkKc2h1bm5lZCBmcm9tIGxvb3NlIFRBQiBjaGFycyBpbiBh
bHJlYWR5IGluZGVudGVkIGxpbmVzOiBsZWFkaW5nIHRhYnMgb25seSBtb2RlLiBJbiBhIHByb3Bl
ciBjb2RlIGVkaXRvcgpwcmVzc2luZyB0aGUgVGFiIGtleSBvbmx5IGluZGVudHMgYWNjb3JkaW5n
IHRvIGJ1ZmZlciBtb2RlLCBpdCBzaG91bGRuJ3QgaW5zZXJ0IGEgVGFiIGNoYXIgd2lsbHktbmls
bHkuClBlb3BsZSBtYXkgc2V0IHRoZWlyIHRhYiBzdG9wcyBkaWZmZXJlbnRseSBmb3IgZGlmZmVy
ZW50IHRhYiBwb3NpdGlvbnMgYW5kIGluc2VydGluZyBhIHRhYiBjaGFyIG1heSBkaXNwbGF5Cmlu
Y29ycmVjdGx5LiBUaGUgbW9zdCBwb3J0YWJsZSB3YXkgdG8gYWxpZ24gY29sdW1ucyBpbiBhbiBh
bHJlYWR5IGluZGVudGVkLWFjY29yZGluZy10by1tb2RlIGxpbmUsIGlzCnVzaW5nIHNwYWNlcy4g
KE9mIGNvdXJzZSB0aGlzIGRvZXNuJ3QgbWF0dGVyIHdoZW4gdXNpbmcgc3BhY2VzIHRvIGluZGVu
dCwgYnV0IExpbnV4IHVzZXMgaGFyZCBUQUIgY2hhcnMKdG8gaW5kZW50OiBsaW51eC9Eb2N1bWVu
dGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdC4gKHdoaWNoIGFsc28gc2VlbSB0byBiZSBz
ZXQgdG8gOCBjaGFycykpCgpJdCdzIGEgY29kZSByZXZpZXcsIHRoZXJlIGlzIG5vICJsYW5ndWFn
ZSIuCgpSZWdhcmRzLApMdWJlbgoKPiAKPiBNYXJlawoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
