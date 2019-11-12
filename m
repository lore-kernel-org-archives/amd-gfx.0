Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FE4C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 19:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D30E20818
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 19:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D30E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F956E157;
	Tue, 12 Nov 2019 19:57:28 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720047.outbound.protection.outlook.com [40.107.72.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F026E157
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 19:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b636hazXtArtdE1uxmlG7vC4gZe6vBhCuIgX/BS6krA2jmPKhznXuFr76D7rppHqFov6Ycv2Pwr3h7QrqA9A312g4BrmduNAcErzwOkUXnJHdCkvzoiMcPuzYYUVbXRe88KnofxlEQMdPZ4wXZ85vERLFFG1oskCX4tJsqt40upvWlJroBmCwlddveCs7Ur7seKlIQQw+/B8XZfNqR2xr6gcnFugDLyPTGu+ZGC47NMR4Uiw0NgJxs9GpaR4USsAu4bqNhAVMxj0jp2pF3fu2IBWe2GT/RecG3GjSJT/sISkgdOH5Saw7cwlMBKzTs527EGGixgkjEy3lGCqeykdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up6fexw9TcUODbvTUYJWjpvKpwD5Gviu8NWsZuHH2Rc=;
 b=Fo46hQ4d29iPPkBEEperFhxNYVWKKiG4TuF/V0ubScQpWOvhx/H9ab/2IwOUunTpiKNUyJUgc0qxPw2wrLOvOmGBoIWVHpyO3QM8XAsYCKzbYTcAdO401VT4xkJRk/hoNYQ9iRgBtTxh9fxE+sWh++q5Pv6AtAd+LXVZHwRwgha9xopf8s4BQZo1zV86Rmk1icz/z/qJ/qyd5n+OVEPm8+2rGn1jaSGVt163qcXOTz9OAufmmXAVKloScsNUj7s8kBIWcLVb5xpM8J3LSMLzIDkmZm1g3mwVNaRbL9OHXqSKEn9+yff6wvOEwzTThrextSdQREGMrE2hXbFZ7a3qTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1372.namprd12.prod.outlook.com (10.168.238.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Tue, 12 Nov 2019 19:57:25 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 19:57:25 +0000
Subject: Re: [PATCH 00/21] Separate JPEG from VCN
To: Alex Deucher <alexdeucher@gmail.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
 <CADnq5_NVBemrfE5OB=NBeb5XM5HPWdnhjaWM0KjdDyb6+pm9zA@mail.gmail.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <171a5818-a2b5-6e91-ac35-050b43963988@amd.com>
Date: Tue, 12 Nov 2019 14:57:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
In-Reply-To: <CADnq5_NVBemrfE5OB=NBeb5XM5HPWdnhjaWM0KjdDyb6+pm9zA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::48) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1065da27-f11b-44d7-4cb4-08d767aa8a0a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1372:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR12MB1372983F21DECB9249AFC16EE5770@DM5PR12MB1372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(6916009)(7736002)(305945005)(81166006)(81156014)(8676002)(66066001)(4001150100001)(47776003)(65956001)(65806001)(8936002)(36756003)(1411001)(50466002)(2906002)(66946007)(31686004)(230700001)(316002)(3846002)(6116002)(58126008)(186003)(86362001)(478600001)(386003)(6246003)(53546011)(26005)(31696002)(44832011)(6506007)(446003)(2616005)(11346002)(76176011)(5660300002)(476003)(4326008)(25786009)(486006)(23676004)(2486003)(52116002)(6512007)(229853002)(6306002)(6486002)(36916002)(99286004)(966005)(14454004)(6436002)(66556008)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1372;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLoLVzy5JifvOf3ZpJqshZSQmuUv5lNYL8zWgzKmTFkmMCStJe5zkwdprTqQTZx5SNhnCcAgVuMpI/Eky2T518eZ6EExbgoUNSaRjvW+b9bpOlM/FuGbDTLPyKg7WEDHzUrzPSu65jj1NFHhyJhL+fxRNvsdPT20mHejz91wRe0cIbVfnvKiQBAWdao7aBeq7jCNQR/y8NytBAf+JWmPjsUMzZUkubY/LgqH++Sd2+ZSm/MkTr9TiZU2TZQFUrl3XnJWQ7948cbWUgmUMZHJu0n6tnq2afS30Jl7TjHUCulngKBAIg4E6jRepNtlynoo22LEQjx6pyAYdprib7R+scO//kZfUKP2LI8QNzpTtJNy7dBAJKJPgWJ45zSZIl6tdcNmcGWW/wcfUYVNMSjugQo9MqKZ9tPkTJK9MtTsRGcVoeWhyvCSEbEOIaQbyIbGN8HLZqW/fyZzVg3DQVUK0iK3GOV7KJtTAFYfllq7/NA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1065da27-f11b-44d7-4cb4-08d767aa8a0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 19:57:25.6135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY/BJeSQx5y9PQKUpHEZuc5MZtJBAHzW4aJzlYgK6eWIsUxWj/gbFp6GkqxJAs0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1372
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up6fexw9TcUODbvTUYJWjpvKpwD5Gviu8NWsZuHH2Rc=;
 b=gqGGN5PhgiL2MuGP2HXy33B0wxBhA9VVrB6484H1dkgu1Ml2/VyLxlrIwoWvWSXfLFbgwLXRSCgP1w0lQIt6xheeQ6Xgi0QgGqlXMfsyZG1+0hZo1t8Br6UYIXvErzIFaZq7+zaCN9XpZM92b8gmG4U1XgNo8USWK92n5VwyOuI=
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
Message-ID: <20191112195724.IrzTVG-ww5iv0mk9W20xbCU5_aJuyddV9ieFEz1furU@z>

Ck9uIDIwMTktMTEtMTIgMjo0OSBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT24gVHVlLCBO
b3YgMTIsIDIwMTkgYXQgMTowMyBQTSBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+IHdyb3RlOgo+
PiAgRnJvbSBKUEVHMi4wLCBKUEVHIGlzIGEgc2VwYXJhdGVkIElQIGJsb2NrLCBhbmQgaGFzIGl0
IG93biBQRy9DRywKPj4gYW5kIHBvd2VyIG1hbmFnZW1lbnQuIEl0IGRvZXNuJ3QgcmVxdWlyZSBG
Vywgc28gaW5kZXBlZGVudCBmcm9tIEZXCj4+IGxvYWRpbmcgYXMgd2VsbC4KPj4KPj4gUGF0Y2gg
MS00OiBTZXBhcmF0ZSBKUEVHMS4wIGZyb20gU1cgd2lzZSwgc2luY2UgSlBFRzEuMCBpcyBzdGls
bAo+PiBjb21iaW5lZCB3aXRoIFZDTjEuMCBlc3AuIGluIHBvd2VyIG1hbmFnZW1lbnQ7Cj4+IFBh
dGNoIDUtMTA6IFNlcGFyYXRlIEpQRUcyLjAgYXMgYW4gaW5kZXBlbmRlbnQgSVAgd2l0aCBQRy9D
RzsKPj4gUGF0Y2ggMTEtMTU6IEFkZCBwb3dlciBtYW5hZ2VtZW50IGZvciBKUEVHIG9mIE5hdmkx
eCBhbmQgUmVub2lyOwo+PiBQYXRjaCAxNjogRW5hYmxlIEpQRUcyLjA7Cj4+IFBhdGNoIDE3LTIw
OiBTZXBhcmF0ZSBKUEVHMi41IGZyb20gVkNOMi41Owo+PiBQYXRjaCAyMTogRW5hYmxlIEpQRUcy
LjUKPj4KPiBJcyB0aGUganBlZyBwb3dlcmdhdGluZyBkeW5hbWljIG9yIGRvIHdlIG5lZWQgYSBp
ZGxlIHdvcmsgdGhyZWFkIHRvCj4gdHVybiBpdCBvZmYgbGlrZSB3ZSBkbyBmb3IgdmNuPwoKSXQg
aGFzIHN0YXRpYyBQRy9DRyBmb3IgSlBFRzIuMCBhbmQgc3RhdGljIENHIGZvciBKUEVHMi41LgoK
SXQgYWxzbyBoYXMgRFBNIGZvciBKUEVHMi4wLiBTbyB3ZSBuZWVkIGlkbGUgd29yayB0aHJlYWQg
YW5kIGJlZ2luX3VzZSAKbGlrZSBWQ04gdG8gaW5pdC9kZWluaXQgSlBFRyBhbmQgdHVybiBvbi9v
ZmYgSlBFRyBwb3dlciB0aHJvdWdoIFNNVSAKbWVzc2FnZXMgc3VjaCBhcyBQb3dlclVQSnBlZyBh
bmQgUG93ZXJEb3duSnBlZy4KCgpUaGFua3MsCkxlbwoKCj4KPiBBbGV4Cj4KPj4gTGVvIExpdSAo
MjEpOgo+PiAgICBkcm0vYW1kZ3B1OiBhZGQgSlBFRyBIVyBJUCBhbmQgU1cgc3RydWN0dXJlcwo+
PiAgICBkcm0vYW1kZ3B1OiBhZGQgYW1kZ3B1X2pwZWcgYW5kIEpQRUcgdGVzdHMKPj4gICAgZHJt
L2FtZGdwdTogc2VwYXJhdGUgSlBFRzEuMCBjb2RlIG91dCBmcm9tIFZDTjEuMAo+PiAgICBkcm0v
YW1kZ3B1OiB1c2UgdGhlIEpQRUcgc3RydWN0dXJlIGZvciBnZW5lcmFsIGRyaXZlciBzdXBwb3J0
Cj4+ICAgIGRybS9hbWRncHU6IGFkZCBKUEVHIElQIGJsb2NrIHR5cGUKPj4gICAgZHJtL2FtZGdw
dTogYWRkIEpQRUcgY29tbW9uIGZ1bmN0aW9ucyB0byBhbWRncHVfanBlZwo+PiAgICBkcm0vYW1k
Z3B1OiBhZGQgSlBFRyB2Mi4wIGZ1bmN0aW9uIHN1cHBvcnRzCj4+ICAgIGRybS9hbWRncHU6IHJl
bW92ZSB1bm5lY2Vzc2FyeSBKUEVHMi4wIGNvZGUgZnJvbSBWQ04yLjAKPj4gICAgZHJtL2FtZGdw
dTogYWRkIEpQRUcgUEcgYW5kIENHIGludGVyZmFjZQo+PiAgICBkcm0vYW1kZ3B1OiBhZGQgUEcg
YW5kIENHIGZvciBKUEVHMi4wCj4+ICAgIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgSlBFRyBQb3dl
cnBsYXkgaW50ZXJmYWNlCj4+ICAgIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgSlBFRyBwb3dlciBj
b250cm9sIGZvciBOYXZpMXgKPj4gICAgZHJtL2FtZC9wb3dlcnBsYXk6IGFkZCBQb3dlcmdhdGUg
SlBFRyBmb3IgUmVub2lyCj4+ICAgIGRybS9hbWQvcG93ZXJwbGF5OiBhZGQgSlBFRyBwb3dlciBj
b250cm9sIGZvciBSZW5vaXIKPj4gICAgZHJtL2FtZC9wb3dlcnBsYXk6IHNldCBKUEVHIHRvIFNN
VSBkcG0KPj4gICAgZHJtL2FtZGdwdTogZW5hYmxlIEpQRUcyLjAgZHBtCj4+ICAgIGRybS9hbWRn
cHU6IGFkZCBkcml2ZXIgc3VwcG9ydCBmb3IgSlBFRzIuMCBhbmQgYWJvdmUKPj4gICAgZHJtL2Ft
ZGdwdTogZW5hYmxlIEpQRUcyLjAgZm9yIE5hdmkxeCBhbmQgUmVub2lyCj4+ICAgIGRybS9hbWRn
cHU6IG1vdmUgSlBFRzIuNSBvdXQgZnJvbSBWQ04yLjUKPj4gICAgZHJtL2FtZGdwdTogZW5hYmxl
IEFyY3R1cnVzIENHIGZvciBWQ04gYW5kIEpQRUcgYmxvY2tzCj4+ICAgIGRybS9hbWRncHU6IGVu
YWJsZSBBcmN0dXJ1cyBKUEVHMi41IGJsb2NrCj4+Cj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvTWFrZWZpbGUgICAgICAgICAgIHwgICA4ICstCj4+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmggICAgICAgICAgIHwgICA1ICsKPj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgICAgICAgfCAgIDQgKy0KPj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgICAgfCAgIDIgKwo+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmMgICAgICB8IDIxNSArKysrKwo+PiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmggICAgICB8ICA2MiArKwo+PiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyAgICAgICB8ICAxNSArLQo+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbS5jICAgICAgICB8ICAgOCArCj4+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmggICAgICAgIHwgICAxICsK
Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgICAgICAgfCAxMTMg
Ky0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oICAgICAgIHwg
ICA1IC0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YxXzAuYyAgICAgICAg
fCA1ODQgKysrKysrKysrKysrKwo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdf
djFfMC5oICAgICAgICB8ICAzMiArCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBl
Z192Ml8wLmMgICAgICAgIHwgODI3ICsrKysrKysrKysrKysrKysrKwo+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5oICAgICAgICB8ICA0MiArCj4+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml81LmMgICAgICAgIHwgNjQxICsrKysrKysrKysrKysr
Cj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml81LmggICAgICAgIHwgIDI5
ICsKPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jICAgICAgICAgICAgICAgfCAg
MTEgKy0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jICAgICAgICAgICAg
fCAgMTAgKy0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5jICAgICAg
ICAgfCA0ODEgKy0tLS0tLS0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92
Ml8wLmMgICAgICAgICB8IDQ5NiArLS0tLS0tLS0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3Zjbl92Ml8wLmggICAgICAgICB8ICAxMyAtCj4+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3YyXzUuYyAgICAgICAgIHwgMjQ2ICstLS0tLQo+PiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmggICAgICB8ICAgNSArLQo+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyAgICB8ICAgNSArCj4+ICAgLi4uL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oICAgIHwgICAzICsKPj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvc211X3YxMl8wLmggfCAgIDIgKwo+PiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyAgICB8ICAzMiArLQo+PiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYyAgICB8ICAyNyArCj4+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X2ludGVybmFsLmggIHwgICA0ICsK
Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjEyXzAuYyAgICAgfCAgMTEg
Kwo+PiAgIDMxIGZpbGVzIGNoYW5nZWQsIDI1OTMgaW5zZXJ0aW9ucygrKSwgMTM0NiBkZWxldGlv
bnMoLSkKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2pwZWcuYwo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfanBlZy5oCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjFfMC5jCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjFfMC5oCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5oCj4+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5jCj4+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5o
Cj4+Cj4+IC0tCj4+IDIuMTcuMQo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
