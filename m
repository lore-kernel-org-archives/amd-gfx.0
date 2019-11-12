Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAD9C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 20:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE633214E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 20:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE633214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6309E6E517;
	Tue, 12 Nov 2019 20:16:46 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680054.outbound.protection.outlook.com [40.107.68.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 284B36E517
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 20:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFLHeHSw1wulllOGZr8TyJsoh+FYsKhREmPPquq0EugUtu/+7bteJkFea+JlnHcIEi7K+XbNRCIGONBb8DF7QURzN3Rt68SRvcO1Bt8Zs0u9bD803pmK9NtJ11PzEiXApBkRXbuDHa4+3+UXLCzUz6spnPwuIOFv2olg5HsYmbVPx2zh23tWWFs8CEDLQA61EI06fxfBI6UMIzgvp80ZOTAIZ3TknKLrBXNlCTeh0Dhg7TYzcoa4e+itbn1hrZYKXsk6bq4chqzxE/+S9KPrnjl/n4gY+KOMGfu1dYLmqrYZq1+m17We2ClPccikZirZSjlP1kGNZlxNepCxvqvT9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fygbinOBcTrD7D3ms2J4XRNHCe0E1P8LrzaQDy0DG4M=;
 b=dnPuKEVW0kqD6djjbPHTxr7UjK3c1iTvBZUTkpnOvbPAnBJgHALOiHB3ICTKCTstKjMRKM0/OTx4VhGuYxhMk2782m4xEnYdbK11GZT7iOlFC2VW+zfTx1seww3uajrZZEpWs6J3Q1k6DE1ulhWP3OhA3t+KnSG/g89GKq2ICIR17Tx/LL3Uy4w+V/VrDKmVowA0NS+qYxWpTpKKKJeHTLecl7ZhxEJufvkqwBPjcEpJshv7gpV/rvg2rWXy5GAIcBT+/PMW2Pu2ibQcU3JHnGzzwRqjyUQ/w13+RAFOC6RxK4NgJvcs+nhjnD0rtEEuqHb8AAooO+GPFn5UUM4lWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1306.namprd12.prod.outlook.com (10.168.233.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 20:16:43 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 20:16:43 +0000
Subject: Re: [PATCH 00/21] Separate JPEG from VCN
To: Alex Deucher <alexdeucher@gmail.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
 <CADnq5_NVBemrfE5OB=NBeb5XM5HPWdnhjaWM0KjdDyb6+pm9zA@mail.gmail.com>
 <171a5818-a2b5-6e91-ac35-050b43963988@amd.com>
 <CADnq5_MRfvfE1D5SPOWTyWZFnLZezZ3N61QXvrwnLFssM++LrA@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <bf523547-408a-536d-5f61-226691058a7b@amd.com>
Date: Tue, 12 Nov 2019 15:16:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
In-Reply-To: <CADnq5_MRfvfE1D5SPOWTyWZFnLZezZ3N61QXvrwnLFssM++LrA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7965a1a-f95f-4a3d-f32e-08d767ad3c2c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1306:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR12MB13064CBD097A80282141892EE5770@DM5PR12MB1306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(446003)(36916002)(6486002)(229853002)(6916009)(8936002)(2616005)(81166006)(66946007)(66476007)(230700001)(66556008)(476003)(81156014)(44832011)(8676002)(25786009)(486006)(4326008)(52116002)(76176011)(11346002)(5660300002)(1411001)(23676004)(2486003)(14454004)(31696002)(99286004)(50466002)(36756003)(86362001)(58126008)(966005)(31686004)(316002)(186003)(6246003)(4001150100001)(26005)(478600001)(66066001)(53546011)(386003)(6506007)(6436002)(305945005)(7736002)(6306002)(6512007)(65956001)(6116002)(65806001)(3846002)(2906002)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1306;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DA3oPEd8FR2TKHcDa7RGrlNVM6qLLMU0OG+M9zpXXtCxThsx7ut9hP9dcLwmzEZn9/2UZj3JANqYjqm/Tx7n16vsfrQDUSe7y54dbKpAcEpchfpXut25iz6sOiyUD8NelyMFUXtFvna3wGrH/QuyJ1dkoLgOovOmy6BycKvFl5i828Xkjj/xzbC9iMrT+y/EkbLnFtxOsEBCJd8rCaHS2FWFIzAZ4xhz9z0JIc1OeKJfj3VGsue+zTFkoZ/isVYwjQiP6R+BD6mhmUy7/V+BCH4PgszacL+IPBiEQmh9pMWkXKm9IydQWe5iagkGg+9htFPq+g/f5zU9InxKFDHepwcqRKMJWrw8hxKg7jG0aOdwjFdpudx6KWN8/Zn377I2n+8gBIA7V5MMRpgT/cHyP1j293mgIrSLHOUNYw3xrakLP6yrliXVimzHYJH83MFMrmMWrJLnZ9JvfsnHmrOYfXbdN417mNYeKC/ElHWSZg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7965a1a-f95f-4a3d-f32e-08d767ad3c2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 20:16:43.4495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgqZW4Ia6Tc4SOUn53X52NFcJbfLT5O3bd75nHcENbWumynImVBj8+G05DViGUTx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1306
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fygbinOBcTrD7D3ms2J4XRNHCe0E1P8LrzaQDy0DG4M=;
 b=tzWL8oCrgSd0zclBJh5EBdVGnoF+BeNcwp6zFIEry8zfs6BFso5da4OtmZB9VSH+Qnep6CWCiENy7jxdMJFtB1o6+liQRkVONuZfqSWo6AEutq89P+t/u1FVX1jqEYTdYrhDKqqiM7kQ+FeN0G6fVtcqgPM2DSyO/iJioLSGRCs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112201642.FelsuGofmO1Dui3zJiwZBzZWHrbVPg_bXfYOKXHDxU0@z>

Ck9uIDIwMTktMTEtMTIgMzoxMiBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT24gVHVlLCBO
b3YgMTIsIDIwMTkgYXQgMjo1NyBQTSBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+IHdyb3RlOgo+
Pgo+PiBPbiAyMDE5LTExLTEyIDI6NDkgcC5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+Pj4gT24g
VHVlLCBOb3YgMTIsIDIwMTkgYXQgMTowMyBQTSBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+IHdy
b3RlOgo+Pj4+ICAgRnJvbSBKUEVHMi4wLCBKUEVHIGlzIGEgc2VwYXJhdGVkIElQIGJsb2NrLCBh
bmQgaGFzIGl0IG93biBQRy9DRywKPj4+PiBhbmQgcG93ZXIgbWFuYWdlbWVudC4gSXQgZG9lc24n
dCByZXF1aXJlIEZXLCBzbyBpbmRlcGVkZW50IGZyb20gRlcKPj4+PiBsb2FkaW5nIGFzIHdlbGwu
Cj4+Pj4KPj4+PiBQYXRjaCAxLTQ6IFNlcGFyYXRlIEpQRUcxLjAgZnJvbSBTVyB3aXNlLCBzaW5j
ZSBKUEVHMS4wIGlzIHN0aWxsCj4+Pj4gY29tYmluZWQgd2l0aCBWQ04xLjAgZXNwLiBpbiBwb3dl
ciBtYW5hZ2VtZW50Owo+Pj4+IFBhdGNoIDUtMTA6IFNlcGFyYXRlIEpQRUcyLjAgYXMgYW4gaW5k
ZXBlbmRlbnQgSVAgd2l0aCBQRy9DRzsKPj4+PiBQYXRjaCAxMS0xNTogQWRkIHBvd2VyIG1hbmFn
ZW1lbnQgZm9yIEpQRUcgb2YgTmF2aTF4IGFuZCBSZW5vaXI7Cj4+Pj4gUGF0Y2ggMTY6IEVuYWJs
ZSBKUEVHMi4wOwo+Pj4+IFBhdGNoIDE3LTIwOiBTZXBhcmF0ZSBKUEVHMi41IGZyb20gVkNOMi41
Owo+Pj4+IFBhdGNoIDIxOiBFbmFibGUgSlBFRzIuNQo+Pj4+Cj4+PiBJcyB0aGUganBlZyBwb3dl
cmdhdGluZyBkeW5hbWljIG9yIGRvIHdlIG5lZWQgYSBpZGxlIHdvcmsgdGhyZWFkIHRvCj4+PiB0
dXJuIGl0IG9mZiBsaWtlIHdlIGRvIGZvciB2Y24/Cj4+IEl0IGhhcyBzdGF0aWMgUEcvQ0cgZm9y
IEpQRUcyLjAgYW5kIHN0YXRpYyBDRyBmb3IgSlBFRzIuNS4KPj4KPj4gSXQgYWxzbyBoYXMgRFBN
IGZvciBKUEVHMi4wLiBTbyB3ZSBuZWVkIGlkbGUgd29yayB0aHJlYWQgYW5kIGJlZ2luX3VzZQo+
PiBsaWtlIFZDTiB0byBpbml0L2RlaW5pdCBKUEVHIGFuZCB0dXJuIG9uL29mZiBKUEVHIHBvd2Vy
IHRocm91Z2ggU01VCj4+IG1lc3NhZ2VzIHN1Y2ggYXMgUG93ZXJVUEpwZWcgYW5kIFBvd2VyRG93
bkpwZWcuCj4gT2ssIHNvIHRoYXQgc3RpbGwgaGFzIHRvIGJlIGltcGxlbWVudGVkIHRoZW4uICBJ
IGRpZG4ndCBzZWUgdGhhdCBpbgo+IHRoZSBwYXRjaCBzZXQuCgoiYW1kZ3B1X2pwZWdfaWRsZV93
b3JrX2hhbmRsZXIiIGlzIGluIHBhdGNoIDYsIGFuZCBjYWxsaW5nIHRob3NlIFNNVSBtZXNzYWdl
cyBhcmUgaW4gdGhvc2UgcG93ZXJwbGF5IHBhdGNoZXMuCgpUaGUgc2V0IGlzIGNvbXBsZXRlIGZv
ciBhbGwgSlBFR3MKClRoYW5rcywKTGVvCgoKPiBUaGFua3MsCj4KPiBBbGV4Cj4KPj4KPj4gVGhh
bmtzLAo+PiBMZW8KPj4KPj4KPj4+IEFsZXgKPj4+Cj4+Pj4gTGVvIExpdSAoMjEpOgo+Pj4+ICAg
ICBkcm0vYW1kZ3B1OiBhZGQgSlBFRyBIVyBJUCBhbmQgU1cgc3RydWN0dXJlcwo+Pj4+ICAgICBk
cm0vYW1kZ3B1OiBhZGQgYW1kZ3B1X2pwZWcgYW5kIEpQRUcgdGVzdHMKPj4+PiAgICAgZHJtL2Ft
ZGdwdTogc2VwYXJhdGUgSlBFRzEuMCBjb2RlIG91dCBmcm9tIFZDTjEuMAo+Pj4+ICAgICBkcm0v
YW1kZ3B1OiB1c2UgdGhlIEpQRUcgc3RydWN0dXJlIGZvciBnZW5lcmFsIGRyaXZlciBzdXBwb3J0
Cj4+Pj4gICAgIGRybS9hbWRncHU6IGFkZCBKUEVHIElQIGJsb2NrIHR5cGUKPj4+PiAgICAgZHJt
L2FtZGdwdTogYWRkIEpQRUcgY29tbW9uIGZ1bmN0aW9ucyB0byBhbWRncHVfanBlZwo+Pj4+ICAg
ICBkcm0vYW1kZ3B1OiBhZGQgSlBFRyB2Mi4wIGZ1bmN0aW9uIHN1cHBvcnRzCj4+Pj4gICAgIGRy
bS9hbWRncHU6IHJlbW92ZSB1bm5lY2Vzc2FyeSBKUEVHMi4wIGNvZGUgZnJvbSBWQ04yLjAKPj4+
PiAgICAgZHJtL2FtZGdwdTogYWRkIEpQRUcgUEcgYW5kIENHIGludGVyZmFjZQo+Pj4+ICAgICBk
cm0vYW1kZ3B1OiBhZGQgUEcgYW5kIENHIGZvciBKUEVHMi4wCj4+Pj4gICAgIGRybS9hbWQvcG93
ZXJwbGF5OiBhZGQgSlBFRyBQb3dlcnBsYXkgaW50ZXJmYWNlCj4+Pj4gICAgIGRybS9hbWQvcG93
ZXJwbGF5OiBhZGQgSlBFRyBwb3dlciBjb250cm9sIGZvciBOYXZpMXgKPj4+PiAgICAgZHJtL2Ft
ZC9wb3dlcnBsYXk6IGFkZCBQb3dlcmdhdGUgSlBFRyBmb3IgUmVub2lyCj4+Pj4gICAgIGRybS9h
bWQvcG93ZXJwbGF5OiBhZGQgSlBFRyBwb3dlciBjb250cm9sIGZvciBSZW5vaXIKPj4+PiAgICAg
ZHJtL2FtZC9wb3dlcnBsYXk6IHNldCBKUEVHIHRvIFNNVSBkcG0KPj4+PiAgICAgZHJtL2FtZGdw
dTogZW5hYmxlIEpQRUcyLjAgZHBtCj4+Pj4gICAgIGRybS9hbWRncHU6IGFkZCBkcml2ZXIgc3Vw
cG9ydCBmb3IgSlBFRzIuMCBhbmQgYWJvdmUKPj4+PiAgICAgZHJtL2FtZGdwdTogZW5hYmxlIEpQ
RUcyLjAgZm9yIE5hdmkxeCBhbmQgUmVub2lyCj4+Pj4gICAgIGRybS9hbWRncHU6IG1vdmUgSlBF
RzIuNSBvdXQgZnJvbSBWQ04yLjUKPj4+PiAgICAgZHJtL2FtZGdwdTogZW5hYmxlIEFyY3R1cnVz
IENHIGZvciBWQ04gYW5kIEpQRUcgYmxvY2tzCj4+Pj4gICAgIGRybS9hbWRncHU6IGVuYWJsZSBB
cmN0dXJ1cyBKUEVHMi41IGJsb2NrCj4+Pj4KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9NYWtlZmlsZSAgICAgICAgICAgfCAgIDggKy0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgICAgfCAgIDUgKwo+Pj4+ICAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyAgICAgICB8ICAgNCArLQo+Pj4+ICAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAgICB8ICAgMiArCj4+Pj4gICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYyAgICAgIHwgMjE1ICsrKysr
Cj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuaCAgICAgIHwg
IDYyICsrCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jICAg
ICAgIHwgIDE1ICstCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Bt
LmMgICAgICAgIHwgICA4ICsKPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcG0uaCAgICAgICAgfCAgIDEgKwo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uYyAgICAgICB8IDExMyArLS0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmNuLmggICAgICAgfCAgIDUgLQo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2pwZWdfdjFfMC5jICAgICAgICB8IDU4NCArKysrKysrKysrKysrCj4+Pj4g
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192MV8wLmggICAgICAgIHwgIDMyICsK
Pj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuYyAgICAgICAgfCA4
MjcgKysrKysrKysrKysrKysrKysrCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
anBlZ192Ml8wLmggICAgICAgIHwgIDQyICsKPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9qcGVnX3YyXzUuYyAgICAgICAgfCA2NDEgKysrKysrKysrKysrKysKPj4+PiAgICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzUuaCAgICAgICAgfCAgMjkgKwo+Pj4+ICAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgICAgICAgICAgICAgICB8ICAxMSArLQo+
Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgICAgICAgICAgICB8ICAx
MCArLQo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgICAgICAg
ICB8IDQ4MSArLS0tLS0tLS0tCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNu
X3YyXzAuYyAgICAgICAgIHwgNDk2ICstLS0tLS0tLS0tCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNuX3YyXzAuaCAgICAgICAgIHwgIDEzIC0KPj4+PiAgICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jICAgICAgICAgfCAyNDYgKy0tLS0tCj4+Pj4gICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCAgICAgIHwgICA1ICstCj4+
Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jICAgIHwgICA1
ICsKPj4+PiAgICAuLi4vZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmggICAg
fCAgIDMgKwo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9zbXVfdjEy
XzAuaCB8ICAgMiArCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEw
X3BwdC5jICAgIHwgIDMyICstCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
cmVub2lyX3BwdC5jICAgIHwgIDI3ICsKPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9zbXVfaW50ZXJuYWwuaCAgfCAgIDQgKwo+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L3NtdV92MTJfMC5jICAgICB8ICAxMSArCj4+Pj4gICAgMzEgZmlsZXMgY2hhbmdl
ZCwgMjU5MyBpbnNlcnRpb25zKCspLCAxMzQ2IGRlbGV0aW9ucygtKQo+Pj4+ICAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jCj4+Pj4g
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9q
cGVnLmgKPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvanBlZ192MV8wLmMKPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvanBlZ192MV8wLmgKPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmMKPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmgKPj4+PiAgICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml81LmMKPj4+PiAg
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml81
LmgKPj4+Pgo+Pj4+IC0tCj4+Pj4gMi4xNy4xCj4+Pj4KPj4+PiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+
Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+PiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
