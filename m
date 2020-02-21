Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D223C35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F06206E2
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 15:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uApm09YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F06206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A776F493;
	Fri, 21 Feb 2020 15:50:07 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64F06F493
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 15:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISzRoGZ8JIeir1/yTXO+dSupZVaP6n+4i4rPfIMAhxy5je0eLe4f1zDU7fLtgOC+VxqvHBPGdxDATdzMkOTdKCRnhzvDujRS24GH/95lrjKYwT06Cv/FIotknXzQwmmVm0ymK7+kl4d2pQChdqy3aQ8pdqvtHkr9Y4D3MaB8E+bVL9Clokc+IqSNk4ja3BMLd1NpfsNLSLSxVZBIJXUE6KSXvLKcM5j1WqI72bdZAuAv7y4JxHu0s+2jIlroFiNR8FmPUqTPYnWDLQ1spJG9a3nMdKN0cLkxLHGseY/SeiQcstkD3Nam/dgGQrifio88v5oyXdud0DEzsztoU3tqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLG8WDCAm/ffl9WgseBJNfJL8KzwcxJGGb/VX5LO+eA=;
 b=nQx2B7bmPDKAw6BGeqzymIJ9z73ZYVk8dyY5YVBlgOw36UEYlOBWEgw6NNnemnQLNn2Fd41yP6z7yrKc8fdGetiWfHV7JDkwaIuLDRSCKWX0rOmX/cFbQWN3loCRy1z4SHvj9wtkOUqth6RMF+vrgXibMqqXe30gxg9a5NnqENwvEqgaoaRPaxGylJc64g+qwosWr+OwOxSyv5Es3cbrCvEwhgz1JTe2mv6k4Z2s2Wzrgv0B1bb+KHlanyW3xTPjfXdr8w9VGBcFfOf6SBrYR2A19Ki2RPMUscLtzp0zvu8trMuG0jqHvfGL6lfz3DFODu4D+0cbHc0KtOOjAiIsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLG8WDCAm/ffl9WgseBJNfJL8KzwcxJGGb/VX5LO+eA=;
 b=uApm09YYOKFM0wW1Bp97YmnTpA963td7vp7nJGDZKmB4lNFB7CMHiL+mwbkVsCdyzrhvwd70QdFswS7H2I8rE3iF/G/QELNalc5hXQFKhaTiZQ0wN+/khZ9/M9Z7dU38PRbHkfdr6xXGAhb8Et6Xmqtqi/o9378yLIx78cRrD6w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB2976.namprd12.prod.outlook.com (20.178.240.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Fri, 21 Feb 2020 15:50:01 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 15:50:01 +0000
Date: Fri, 21 Feb 2020 23:49:51 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0v?=
 =?gb2312?Q?amd=2Famdgpu=3A?= disable GFXOFF around debugfs access to MMIO
Message-ID: <20200221154950.GI28698@jenkins-Celadon-RN>
References: <20200219150417.510884-1-tom.stdenis@amd.com>
 <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
 <6f93ee3f-4fba-575a-f8eb-0441b0efd4c8@amd.com>
 <20200221143359.GF28698@jenkins-Celadon-RN>
 <DM6PR12MB393101FB6C3250020720509A84120@DM6PR12MB3931.namprd12.prod.outlook.com>
 <20200221152321.GH28698@jenkins-Celadon-RN>
 <2e56e194-dceb-8315-987e-5825ad02a143@gmail.com>
Content-Disposition: inline
In-Reply-To: <2e56e194-dceb-8315-987e-5825ad02a143@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0190.apcprd02.prod.outlook.com (2603:1096:201:21::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 15:49:59 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d300cac3-3d49-4824-281e-08d7b6e5b5d9
X-MS-TrafficTypeDiagnostic: MN2PR12MB2976:|MN2PR12MB2976:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB29760472D2B3B1351F428B72EC120@MN2PR12MB2976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(6636002)(53546011)(66574012)(1076003)(2906002)(86362001)(956004)(33716001)(316002)(8936002)(54906003)(224303003)(478600001)(16526019)(45080400002)(26005)(9686003)(186003)(55016002)(33656002)(81156014)(966005)(5660300002)(66946007)(66556008)(66476007)(6496006)(52116002)(6666004)(81166006)(4326008)(6862004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2976;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhQiWkjspr0f0zTvn7oGIYCslGbb/xcZ9jwWOzFLU+tDXYfBojOHSKiTiEONeKTj6Yh4Ydr2nerk/WGpm0scrWNaqtRtLW3U/GG1D71vaekZkjN90AA6IeqQnqGIMI1wz7lNI+RqNCprOvsPjb1738lXKnhgSX2wIfFyaOIeJp4Y3LTTbcG+XssW74AIwXy4q8rmGPzTTNXXIDLZnoN8OVY/MgN5E1FUvhDQsyjLEE4kDr+kJfXcXEOL50wha3C8+DHoBbSYdFlxsVilmNDPM7p0QGVwoMunNZHHXAXYMYRJ0ZC0+upmBQTns+sBUmAGux5CzFdN6y7pMk1rFklVIQqsoG8mhz0/jetPaCIkhUp2tLqSWESPnFriZuUlL2N3kBLtpZFpDJGLu8mC7PUfG4+wvq7qjnBYoYdOOYKGgccsGPlXVJsHUBdNxGZEBZRrgKWMd//x9fAbHCaU1XnnQeJPQo9zLtJvYbhGLNKUVvwtnWampqkaIWDn937YOb9IilPYdJO+I9+geoGft4KwzuFLauMylJgvNNtITMx38JcbSRX4nS8YOmFmStFWsG1P6RJFowOkDfCiaiwEB21aaj5zcrOk8+lCvvSkoR5bmPLa8o5Fu/HGFRbGq1JcJZIE
X-MS-Exchange-AntiSpam-MessageData: 9rwn5We7z0Id+iG5FAb/FpFuGFV3fWpyFISYM7QoCwI6TQPUWS4GB+JHIbeeEQ7FmBe84FBDM13ib+XcryV1bUUPEUfL0IgqUwDfbYAY8ayphZbzhZxsLI+9Eoi0fFzVEetINbEhH9/FbvMZDTWkCg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d300cac3-3d49-4824-281e-08d7b6e5b5d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 15:50:01.3296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmD590XzJ73R6/SKHuqi8i1C+nt8HL4JppApR2Wkkyqd4+h53mGb8KM17wjOT+xHtzCnqKQyYhUUc8U8uq8Zwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2976
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBGZWIgMjEsIDIwMjAgYXQgMTE6Mjc6MTBQTSArMDgwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAyMS4wMi4yMCB1bSAxNjoyMyBzY2hyaWViIEh1YW5nIFJ1aToKPiA+IE9u
IEZyaSwgRmViIDIxLCAyMDIwIGF0IDExOjE4OjA3UE0gKzA4MDAsIExpdSwgTW9uayB3cm90ZToK
PiA+PiBCZXR0ZXIgbm90IHVzZSBLSVEsIGJlY2F1c2Ugd2hlbiB5b3UgdXNlIGRlYnVnZnMgdG8g
cmVhZCByZWdpc3RlciB5b3UgdXN1YWxseSBoaXQgYSBoYW5nLCBhbmQgYnkgdGhhdCBjYXNlIEtJ
USBwcm9iYWJseSBhbHJlYWR5IGRpZQo+ID4gSWYgQ1AgaXMgYnVzeSwgdGhlIGdmeCBzaG91bGQg
YmUgaW4gIm9uIiBzdGF0ZSBhdCB0aGF0IHRpbWUsIHdlIG5lZWRuJ3QgdXNlIEtJUS4KPiAKPiBZ
ZWFoLCBidXQgaG93IGRvIHlvdSBkZXRlY3QgdGhhdD8KCkkgcmVtZW1iZXIgdGhlcmUgaXMgYSBi
aXQgaW4gU01VIG9yIFBXUiByZWdpc3RlciB3aGljaCBpcyBub3QgZXhwb3NlZCB5ZXQuCkFuZCBu
ZWVkIGRvdWJsZSBjb25maXJtIHdpdGggU01VIG9yIFJMQyBndXlzLgoKPiBEbyB3ZSBoYXZlIGEg
d2F5IHRvIHdha2UgdXAgdGhlIENQIHdpdGhvdXQgYXNraW5nIHBvd2VyIG1hbmFnZW1lbnQgdG8g
ZG8KPiBzbz8KClVzZSBkb29yYmVsbCBpbnRlcnJ1cHQuIFJMQyB3aWxsIGRldGVjdCB0aGUgZG9v
cmJlbGwgaW50ZXJydXB0IHRvIHRlbGwgU01VCnRvIHdha2UgdXAgZ2Z4IGF0IHJ1bnRpbWUuIFNv
IEkgc3VnZ2VzdCBLSVEgaGVyZS4KCj4gCj4gQ2F1c2UgdGhlIHJlZ2lzdGVyIGRlYnVnIGludGVy
ZmFjZSBpcyBtZWFudCB0byBiZSB1c2VkIHdoZW4gdGhlIEFTSUMgaXMgCj4gY29tcGxldGVkIGxv
Y2tlZCB1cC4gU2VuZGluZyBtZXNzYWdlcyB0byB0aGUgU01VIGlzIG5vdCByZWFsbHkgZ29pbmcg
dG8gCj4gd29yayBpbiB0aGF0IHNpdHVhdGlvbi4KPiAKCkFncmVlLCBhY3R1YWxseSwgd2UgdHJp
ZWQgdGhpcyBraW5kIG9mIG1lc3NhZ2VzIGEgbG9uZyB0aW1lIGJlZm9yZSwgYW5kCndpbGwgZ2V0
IGZhaWx1cmUgc29tZXRpbWVzIHRoYXQgdGhlIHNhbWUgbGlrZSBUb20gaGVyZS4KClRoYW5rcywK
UmF5Cgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+IAo+ID4KPiA+IFRoYW5rcywKPiA+IFJheQo+
ID4KPiA+PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tCj4gPj4g5Y+R5Lu25Lq6OiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiDku6PooaggSHVhbmcgUnVpCj4g
Pj4g5Y+R6YCB5pe26Ze0OiAyMDIw5bm0MuaciDIx5pelIDIyOjM0Cj4gPj4g5pS25Lu25Lq6OiBT
dERlbmlzLCBUb20gPFRvbS5TdERlbmlzQGFtZC5jb20+Cj4gPj4g5oqE6YCBOiBBbGV4IERldWNo
ZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc+Cj4gPj4g5Li76aKYOiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTog
ZGlzYWJsZSBHRlhPRkYgYXJvdW5kIGRlYnVnZnMgYWNjZXNzIHRvIE1NSU8KPiA+Pgo+ID4+IE9u
IFdlZCwgRmViIDE5LCAyMDIwIGF0IDEwOjA5OjQ2QU0gLTA1MDAsIFRvbSBTdCBEZW5pcyB3cm90
ZToKPiA+Pj4gSSBnb3Qgc29tZSBtZXNzYWdlcyBhZnRlciBhIHdoaWxlOgo+ID4+Pgo+ID4+PiBb
wqAgNzQxLjc4ODU2NF0gRmFpbGVkIHRvIHNlbmQgTWVzc2FnZSA4Lgo+ID4+PiBbwqAgNzQ2LjY3
MTUwOV0gRmFpbGVkIHRvIHNlbmQgTWVzc2FnZSA4Lgo+ID4+PiBbwqAgNzQ4Ljc0OTY3M10gRmFp
bGVkIHRvIHNlbmQgTWVzc2FnZSAyYi4KPiA+Pj4gW8KgIDc1OS4yNDU0MTRdIEZhaWxlZCB0byBz
ZW5kIE1lc3NhZ2UgNy4KPiA+Pj4gW8KgIDc2My4yMTY5MDJdIEZhaWxlZCB0byBzZW5kIE1lc3Nh
Z2UgMmEuCj4gPj4+Cj4gPj4+IEFyZSB0aGVyZSBhbnkgYWRkaXRpb25hbCBsb2NrcyB0aGF0IHNo
b3VsZCBiZSBoZWxkP8KgIEJlY2F1c2Ugc29tZQo+ID4+PiBjb21tYW5kcyBsaWtlIC0tdG9wIG9y
IC0td2F2ZXMgY2FuIGRvIGEgbG90IG9mIGRpc3RpbmN0IHJlYWQKPiA+Pj4gb3BlcmF0aW9ucyAo
Y2F1c2luZyBhIGxvdCBvZiBlbmFibGUvZGlzYWJsZSBjYWxscykuCj4gPj4+Cj4gPj4+IEknbSBn
b2luZyB0byBzaXQgb24gdGhpcyBhIGJpdCBzaW5jZSBJIGRvbid0IHRoaW5rIHRoZSBwYXRjaCBp
cyByZWFkeQo+ID4+PiBmb3IgcHVzaGluZyBvdXQuCj4gPj4+Cj4gPj4gSG93IGFib3V0IHVzZSBS
UkVHMzJfS0lRIGFuZCBXUkVHMzJfS0lRPwo+ID4+Cj4gPj4gVGhhbmtzLAo+ID4+IFJheQo+ID4+
Cj4gPj4+IFRvbQo+ID4+Pgo+ID4+PiBPbiAyMDIwLTAyLTE5IDEwOjA3IGEubS4sIEFsZXggRGV1
Y2hlciB3cm90ZToKPiA+Pj4+IE9uIFdlZCwgRmViIDE5LCAyMDIwIGF0IDEwOjA0IEFNIFRvbSBT
dCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4gd3JvdGU6Cj4gPj4+Pj4gU2lnbmVkLW9mZi1i
eTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgo+ID4+Pj4gUGxlYXNlIGFkZCBh
IHBhdGNoIGRlc2NyaXB0aW9uLiAgV2l0aCB0aGF0IGZpeGVkOgo+ID4+Pj4gUmV2aWV3ZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+Pj4+Cj4gPj4+Pj4g
LS0tCj4gPj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMu
YyB8IDMgKysrCj4gPj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+ID4+
Pj4+Cj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZWJ1Z2ZzLmMKPiA+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZWJ1Z2ZzLmMKPiA+Pj4+PiBpbmRleCA3Mzc5OTEwNzkwYzkuLjY2Zjc2MzMwMGM5NiAxMDA2NDQK
PiA+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5j
Cj4gPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMu
Ywo+ID4+Pj4+IEBAIC0xNjksNiArMTY5LDcgQEAgc3RhdGljIGludCAgYW1kZ3B1X2RlYnVnZnNf
cHJvY2Vzc19yZWdfb3AoYm9vbCByZWFkLCBzdHJ1Y3QgZmlsZSAqZiwKPiA+Pj4+PiAgICAgICAg
ICAgaWYgKHBtX3BnX2xvY2spCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygm
YWRldi0+cG0ubXV0ZXgpOwo+ID4+Pj4+Cj4gPj4+Pj4gKyAgICAgICBhbWRncHVfZ2Z4X29mZl9j
dHJsKGFkZXYsIGZhbHNlKTsKPiA+Pj4+PiAgICAgICAgICAgd2hpbGUgKHNpemUpIHsKPiA+Pj4+
PiAgICAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWx1ZTsKPiA+Pj4+Pgo+ID4+Pj4+IEBAIC0x
OTIsNiArMTkzLDggQEAgc3RhdGljIGludCAgYW1kZ3B1X2RlYnVnZnNfcHJvY2Vzc19yZWdfb3Ao
Ym9vbCByZWFkLCBzdHJ1Y3QgZmlsZSAqZiwKPiA+Pj4+PiAgICAgICAgICAgfQo+ID4+Pj4+Cj4g
Pj4+Pj4gICAgZW5kOgo+ID4+Pj4+ICsgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCB0
cnVlKTsKPiA+Pj4+PiArCj4gPj4+Pj4gICAgICAgICAgIGlmICh1c2VfYmFuaykgewo+ID4+Pj4+
ICAgICAgICAgICAgICAgICAgIGFtZGdwdV9nZnhfc2VsZWN0X3NlX3NoKGFkZXYsIDB4ZmZmZmZm
ZmYsIDB4ZmZmZmZmZmYsIDB4ZmZmZmZmZmYpOwo+ID4+Pj4+ICAgICAgICAgICAgICAgICAgIG11
dGV4X3VubG9jaygmYWRldi0+Z3JibV9pZHhfbXV0ZXgpOwo+ID4+Pj4+IC0tCj4gPj4+Pj4gMi4y
NC4xCj4gPj4+Pj4KPiA+Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+ID4+Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gPj4+Pj4gYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+Pj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkYKPiA+Pj4+PiBsaXN0cy5mcmVl
ZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTcK
PiA+Pj4+PiBDMDElN0Ntb25rLmxpdSU0MGFtZC5jb20lN0NiYTQ1ZWZiMjZjMDI0MGVkMDM2ZjA4
ZDdiNmRiMjBhYSU3QzNkZDgKPiA+Pj4+PiA5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2MzcxNzg5MjQ2MDU1MjQzNzgmYW1wO3NkYXQKPiA+Pj4+PiBhPSUyRnlIa3ZZVTVU
JTJGNGlGeFJleHNnJTJCSWRtN3NEenlYYmp6TnBIVUdDTzdoNGslM0QmYW1wO3Jlc2VydmUKPiA+
Pj4+PiBkPTAKPiA+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiA+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiA+Pj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiA+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdAo+ID4+PiBzLmZyZWVkZXNrdG9wLm9yZyUy
Rm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21vCj4gPj4+
IG5rLmxpdSU0MGFtZC5jb20lN0NiYTQ1ZWZiMjZjMDI0MGVkMDM2ZjA4ZDdiNmRiMjBhYSU3QzNk
ZDg5NjFmZTQ4ODRlNjAKPiA+Pj4gOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTc4OTI0
NjA1NTI0Mzc4JmFtcDtzZGF0YT0lMkZ5SGt2WVU1VCUyRgo+ID4+PiA0aUZ4UmV4c2clMkJJZG03
c0R6eVhianpOcEhVR0NPN2g0ayUzRCZhbXA7cmVzZXJ2ZWQ9MAo+ID4+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPj4gYW1kLWdmeCBtYWlsaW5nIGxp
c3QKPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+ID4+IGh0dHBzOi8vbmFtMTEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3Rz
LmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9
MDIlN0MwMSU3Q3JheS5odWFuZyU0MGFtZC5jb20lN0NlZmU0MjM1NzdiZGU0NmZjOWUyNTA4ZDdi
NmUyODcwMiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzcx
Nzg5NTYzNTkyMjg3ODkmYW1wO3NkYXRhPXJTaFU1c2w3NDlCdU54VlI4dUZMdElmOGtSJTJCVVdC
cnQlMkZPOUglMkYwU1JWVG8lM0QmYW1wO3Jlc2VydmVkPTAKPiA+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
ID4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IGh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVk
ZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0Mw
MSU3Q3JheS5odWFuZyU0MGFtZC5jb20lN0NlZmU0MjM1NzdiZGU0NmZjOWUyNTA4ZDdiNmUyODcw
MiU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNzg5NTYz
NTkyMzg3ODUmYW1wO3NkYXRhPVhrSjV1VDFnNDFsa3UlMkZZeE1zTVRHYUh6YWpHc0NBVnZjTVVZ
SHZUeCUyRlYwJTNEJmFtcDtyZXNlcnZlZD0wCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
