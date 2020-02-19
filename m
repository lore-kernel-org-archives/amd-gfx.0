Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557ACC34022
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 08:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEDA2176D
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 08:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ubYzSFzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEDA2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5D26EB32;
	Wed, 19 Feb 2020 08:20:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F0A6EB21
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 08:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duT02jQcWliCHolXkWQWYKjd4x8EQpxE2Ctil+Ux3YtOTkzyoJS16pIJ5VWkXGFy5y/moJ2knvCWTFtQG91nQ/H6ufW1UftNbTKEPb1ATiyNkBOHEAez1FXwMs0EiV7hJI7jywI4iz7SanddklTQL9g2xtNxTLQRWIpS0MRBDS1hJCqorZoxV5KWGZ1hf+tt+rNQXF9QXHnZIX9SsYD6af9kRafHajnunezoU3gNtS0lCIlbj45y+nTFOwQoSVYrjkN0XOsoq761gfKCG8mMqbL91vauc6zYSiiQZZsLpOYtrBUW7b2ZW9OyS82iwj1zuLMKzuvwLxEfa3vNhx4BCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkl7gsbU/RbQ7CEWMQLPt26VX7XVib7BZVuga4OR0Bc=;
 b=UTqwjwBkFM9WG2acFmzFuQu1ZIaC7VWQCF++LWJGzcx6XlWXiQbUHHf7WEW8c3VbqTvHsZj5WbOWJBDKGd2Jtt14vo0P1hN5tzJ46IQ/v0atgvyMIlQUH+2C0wblfwRxdyVla7XpJJPNcn8UE+CRVdNbJQtZlmAc3lRXo68IwAeYx+Njbzg/YBP/nF4ZPHBOHtS4pdHot2agyAUezaxoRZinsa1beweKJ39fiNo1fcamUtuyYvayu3VUp9vNtdGFr1JP8Xxwh5zo712PSEhVY+OtUqbY8+itqPh3dulgu9CQGzVvI69VdA4+I41h11C8ZahPXChhD5IT4aNgaOuGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkl7gsbU/RbQ7CEWMQLPt26VX7XVib7BZVuga4OR0Bc=;
 b=ubYzSFzclxGui6V/4cQp98k5KGwsXk/ZnGYUpNQ3TwtiXgxuuTZuelWNXWulvBQEAtp3xVVZlSVPuW3URG/lp5LkLtReJJNrycyU1Kdkt6Ys5fuFfJFo9UIO2GVkXiadCsrtkwA2/XNiIwSrqcg2JJ83Hm2tY2SS5mf5IXNOxmQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1708.namprd12.prod.outlook.com (10.175.89.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 08:20:50 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2729.032; Wed, 19 Feb
 2020 08:20:50 +0000
Subject: Re: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
To: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20200215001714.605727-1-luben.tuikov@amd.com>
 <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
 <91d5bf04-6d71-4902-9ac9-f40f724abdc9@gmail.com>
 <46047362-745c-5a7f-0ba5-b36bb08f8d28@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c1581681-e5b4-4b3b-5e05-f66e3ecd7075@amd.com>
Date: Wed, 19 Feb 2020 09:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <46047362-745c-5a7f-0ba5-b36bb08f8d28@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::31) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend
 Transport; Wed, 19 Feb 2020 08:20:48 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 251c402d-ccd7-4464-d43f-08d7b514a0bd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1708:|DM5PR12MB1708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1708B656D5DEF11502284D6083100@DM5PR12MB1708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(189003)(199004)(31696002)(66574012)(36756003)(110136005)(6666004)(6486002)(2906002)(81166006)(966005)(66476007)(478600001)(52116002)(45080400002)(186003)(66946007)(4326008)(53546011)(8936002)(8676002)(5660300002)(86362001)(316002)(66556008)(31686004)(16526019)(2616005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1708;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6A10AN1AHG7Kr9T3TeC6rJ2WoSL5wtfGZcIL8dLw+H9t+3fvGCvK1BG8g0sED7G2rbWMFb9RxhCjHOtydETY4AjkB8zg+Qi83usQl61wnKdj1hponZoOitypFBvHn07zDimzC77UJ6YhnvUQ1BZp/fKgN1EuQbtrvstzb77RLztaVyfLknO28/TbbDfR1kzatdWNV6fhbPWL1RUPJylmbJmTWjNUljpXGIv614Qrgiflz6KtSyClDI6JDMt+iPkqTGzX2VdJxFE38bHZOuVBwMMlPio78Uj3h0wPbJrgUKc9Q1pL3WKdgc8dj4dMGWZRnorGNXTJXgfZ2jPoBlKaEbTEewO7VHUU3nPE5G8SJbKQ+OecjWXNH3icVvu7BLo0srENhOSZrdIOOBICZB0I0F9DJN/0PJUnfSRrS/3GdaXLldDt2VmsdjsFN13vQYrgt8YGet9SpZrWuUy/OYjVxtMVAvJZVOo6rPkCfTC+TvK1U2jBzcsQNFTOZf8CcrdA1GYHpi7Vc0W7UGaM1h4zEQ==
X-MS-Exchange-AntiSpam-MessageData: 3OUkI29iupiyX8yODmSeYA/cg43Z9DBrXAdoJV4ybugCDA0PBei5by5sGAJ4rvpNBNy4Qey9WFGeLu9tMxnoN/NXU7gUBbwFn9pr/6i78ArYY9Ncj+pcozitkgv2L/7BR77RxZwdYe3qEu9KLyY1mPD/3VbEmy346wx3SxNE3J6kMhej0IzHc5IVSrYZJOX0yluI+uRtluisUyMFGzZJNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251c402d-ccd7-4464-d43f-08d7b514a0bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 08:20:49.9392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JEqU3CIaua3O5dHtBbrWS4NORCD5wBdEWnadQ3oGDrdHEZ0O0SyXqZdBBCBnRNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDIuMjAgdW0gMjI6NDYgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gT24gMjAyMC0wMi0x
NyAxMDowOCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxNy4wMi4yMCB1bSAx
NTo0NCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPj4+IE9uIEZyaSwgRmViIDE0LCAyMDIwIGF0IDc6
MTcgUE0gTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4gd3JvdGU6Cj4+Pj4gQWRk
IGEgQU1ER1BVX0dFTV9DUkVBVEVfTUFTSyBhbmQgdXNlIGl0IHRvIGNoZWNrCj4+Pj4gZm9yIHZh
bGlkL2ludmFsaWQgR0VNIGNyZWF0ZSBmbGFncyBjb21pbmcgaW4gZnJvbQo+Pj4+IHVzZXJzcGFj
ZS4KPj4+Pgo+Pj4+IEZpeCBhIGJ1ZyBpbiBjaGVja2luZyB3aGV0aGVyIFRNWiBpcyBzdXBwb3J0
ZWQgYXQKPj4+PiBHRU0gY3JlYXRlIHRpbWUuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMdWJl
biBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDExICsrLS0tLS0tLS0tCj4+Pj4gICAg
aW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggICAgICAgICAgIHwgIDIgKysKPj4+PiAgICAy
IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4+PiBpbmRleCBiNTFhMDYw
YzYzN2QuLjc0YmI3OWU2NGZhMyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMKPj4+PiBAQCAtMjIxLDIxICsyMjEsMTQgQEAgaW50IGFtZGdwdV9nZW1f
Y3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCj4+Pj4gICAg
ICAgICAgIGludCByOwo+Pj4+Cj4+Pj4gICAgICAgICAgIC8qIHJlamVjdCBpbnZhbGlkIGdlbSBm
bGFncyAqLwo+Pj4+IC0gICAgICAgaWYgKGZsYWdzICYgfihBTURHUFVfR0VNX0NSRUFURV9DUFVf
QUNDRVNTX1JFUVVJUkVEIHwKPj4+PiAtICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9D
UkVBVEVfTk9fQ1BVX0FDQ0VTUyB8Cj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9H
RU1fQ1JFQVRFX0NQVV9HVFRfVVNXQyB8Cj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgIEFNREdQ
VV9HRU1fQ1JFQVRFX1ZSQU1fQ0xFQVJFRCB8Cj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgIEFN
REdQVV9HRU1fQ1JFQVRFX1ZNX0FMV0FZU19WQUxJRCB8Cj4+Pj4gLSAgICAgICAgICAgICAgICAg
ICAgIEFNREdQVV9HRU1fQ1JFQVRFX0VYUExJQ0lUX1NZTkMgfAo+Pj4+IC0gICAgICAgICAgICAg
ICAgICAgICBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUQpKQo+Pj4+IC0KPj4+IEknZCByYXRo
ZXIga2VlcCB0aGUgbGlzdCBleHBsaWNpdCBzbyBubyBvbmUgZW5kcyB1cCBmb3JnZXR0aW5nIHRv
Cj4+PiB1cGRhdGUgdGhlIG1hc2sgdGhlIG5leHQgdGltZSBuZXcgZmxhZ3MgYXJlIGFkZGVkLgo+
PiBBZGRpdGlvbmFsIHRvIHRoYXQgdGhpcyBwYXRjaCBpcyBib2d1cy4KPiBTbyB0aGUgb25seSAi
YWRkaXRpb25hbCIgdGhpbmcgeW91J3JlIGNvbnRyaWJ1dGluZyB0byB0aGUgcmV2aWV3IG9mCj4g
dGhpcyBwYXRjaCBpcyBjYWxsaW5nIGl0ICJib2d1cyIuIENoYXJhY3Rlcml6aW5nIHRoZSBwYXRj
aCB3aXRoIGFuIGFkamVjdGl2ZQo+IGFzICJib2d1cyIgaXMgdmVyeSBkaXN0dXJiaW5nLiBXaGF0
J3MgbmV4dD8KCldlbGwgdGhlIHBhdGNoIGlzIHRlY2huaWNhbCBpbmNvcnJlY3QgYW5kIGJyZWFr
cyB0aGUgY29kZSBpbiBhIHZlcnkgCnN1YnRsZSBhbmQgaGFyZCB0byBkZXRlY3QgbWFubmVyLiBB
bGV4IGRpZG4ndCBub3RpY2VkIHRoYXQgZWl0aGVyLgoKSSdtIG5vdCBhIG5hdGl2ZSBzcGVha2Vy
IG9mIEVuZ2xpc2gsIGJ1dCBhcyBmYXIgYXMgSSBoYXZlIGxlYXJuZWQgCiJib2d1cyIgaXMgdGhl
IHJpZ2h0IGFkamVjdGl2ZSBmb3IgdGhhdC4KCj4+IFdlIGludGVudGlvbmFsbHkgZmlsdGVyIG91
dCB0aGUgZmxhZ3MgaGVyZSB3aGljaCB1c2Vyc3BhY2UgaXMgYWxsb3dlZCB0bwo+PiBzcGVjaWZ5
IGluIHRoZSBHRU0gaW50ZXJmYWNlLCBidXQgYWZ0ZXIgdGhpcyBwYXRjaCB3ZSB3b3VsZCBhbGxv
dyBhbGwKPj4gZmxhZ3MgdG8gYmUgc3BlY2lmaWVkLgo+IEkgdGhvdWdodCB0aGF0IHRoYXQgY291
bGQgYmUgdGhlIGNhc2UuCgpUaGVuIHdoeSBkaWQgeW91IHNlbmQgb3V0IGEgcGF0Y2ggd2hpY2gg
aXMgc2VyaW91c2x5IGJyb2tlbiBsaWtlIHRoYXQ/CgpJIG1lYW4gaWYgSSBoYWRuJ3Qgbm90aWNl
ZCBpdCBieSBjaGFuY2Ugd2Ugd291bGQgaGF2ZSBjb21taXR0ZWQgdGhpcyBhbmQgCmFkZGVkIGEg
cG90ZW50aWFsbHkgc2VjdXJpdHkgcHJvYmxlbWF0aWMgYnVnIHRvIHRoZSBJT0NUTCBpbnRlcmZh
Y2UuCgo+IEJ1dCBpbiB5b3VyIHJldmlldyB3aHkgbm90Cj4gcmVjb21tZW5kIHdlIGhhdmUgYSBt
YXNrIHRvIGNoZWNrIHVzZXItc2V0dGFibGUgZmxhZ3M/IFNvIHRoZQo+IGFjdHVhbCBmbGFncyBh
cmUgY29sbGVjdGVkIGFuZCB2aXNpYmxlIGluIG9uZSBwbGFjZSBhbmQgd2VsbAo+IHVuZGVyc3Rv
b2QgdGhhdCB0aGF0IGlzIHdoYXQgaXMgYmVpbmcgY2hlY2tlZCBhbmQgd2VsbC1kZWZpbmVkCj4g
YnkgYSBtYWNybyB3aXRoIGFuIGFwcHJvcHJpYXRlIG5hbWU/CgpTZWUgdGhlIGZsYWdzIHRlc3Rl
ZCBoZXJlIGFyZSB0aGUgZmxhZ3MgY3VycmVudGx5IGFjY2VwdGVkIGJ5IHRoZSAKYW1kZ3B1X2dl
bV9jcmVhdGVfaW9jdGwoKSBmdW5jdGlvbi4gSXQgZG9lc24ndCBzYXkgYW55dGhpbmcgYWJvdXQg
d2hhdCAKdGhlIGtlcm5lbCB3b3VsZCBhY2NlcHQgaW4gdGhlIGZ1dHVyZS4KClNvIHdoZW4gd2Ug
bW92ZSB0aGF0IGludG8gdGhlIFVBUEkgaGVhZGVyIHdlIGdpdmUgdXNlcnNwYWNlIGEgCnRlY2hu
aWNhbGx5IGluY29ycmVjdCB2YWx1ZS4KCj4gV2h5IGRpZCBOTyBPTkUgY29tbWVudCBvbiB0aGUg
YnVnIGZpeCBiZWxvdz8gTm8gb25lLgoKQmVjYXVzZSB5b3UgbWl4ZWQgdXAgYSBzdHlsZSBjaGFu
Z2UgaW50byBzb21lIGJ1ZyBmaXguIFRoYXQgcGVvcGxlIGdvIApmb3IgdGhlIHByb2JsZW1hdGlj
IHBhcnRzIGR1cmluZyBjb2RlIHJldmlldyBpcyBub3QgcmVhbGx5IHN1cnByaXNpbmcgYXQgCmFs
bC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+IEx1YmVuCj4KPj4gQ2hyaXN0
aWFuLgo+Pgo+Pgo+Pgo+Pj4gQWxleAo+Pj4KPj4+PiArICAgICAgIGlmIChmbGFncyAmIH5BTURH
UFVfR0VNX0NSRUFURV9NQVNLKQo+Pj4+ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Owo+Pj4+Cj4+Pj4gICAgICAgICAgIC8qIHJlamVjdCBpbnZhbGlkIGdlbSBkb21haW5zICovCj4+
Pj4gICAgICAgICAgIGlmIChhcmdzLT5pbi5kb21haW5zICYgfkFNREdQVV9HRU1fRE9NQUlOX01B
U0spCj4+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4+Pj4KPj4+PiAtICAg
ICAgIGlmIChhbWRncHVfaXNfdG16KGFkZXYpICYmIChmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRF
X0VOQ1JZUFRFRCkpIHsKPj4+PiArICAgICAgIGlmICghYW1kZ3B1X2lzX3RteihhZGV2KSAmJiBm
bGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRCkgewo+Pj4+ICAgICAgICAgICAgICAg
ICAgIERSTV9FUlJPUigiQ2Fubm90IGFsbG9jYXRlIHNlY3VyZSBidWZmZXIgc2luY2UgVE1aIGlz
IGRpc2FibGVkXG4iKTsKPj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4+
PiAgICAgICAgICAgfQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9k
cm0uaCBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4+Pj4gaW5kZXggZWFmOTRhNDIx
OTAxLi5jODQ2M2NkZjQ0NDggMTAwNjQ0Cj4+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRn
cHVfZHJtLmgKPj4+PiArKysgYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaAo+Pj4+IEBA
IC0xNDEsNiArMTQxLDggQEAgZXh0ZXJuICJDIiB7Cj4+Pj4gICAgICovCj4+Pj4gICAgI2RlZmlu
ZSBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUQgICAgICAgICAgICAoMSA8PCAxMCkKPj4+Pgo+
Pj4+ICsjZGVmaW5lIEFNREdQVV9HRU1fQ1JFQVRFX01BU0sgICAgICAgICAgICAgICAgICAoKDEg
PDwgMTEpLTEpCj4+Pj4gKwo+Pj4+ICAgIHN0cnVjdCBkcm1fYW1kZ3B1X2dlbV9jcmVhdGVfaW4g
IHsKPj4+PiAgICAgICAgICAgLyoqIHRoZSByZXF1ZXN0ZWQgbWVtb3J5IHNpemUgKi8KPj4+PiAg
ICAgICAgICAgX191NjQgYm9fc2l6ZTsKPj4+PiAtLQo+Pj4+IDIuMjUuMC4yMzIuZ2Q4NDM3YzU3
ZmEKPj4+Pgo+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZs
aXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2x1YmVuLnR1aWtvdiU0MGFtZC5j
b20lN0NiMWZkYzM5NzBhMjI0ZmM2MWZkYzA4ZDdiM2JiNDYxMyU3QzNkZDg5NjFmZTQ4ODRlNjA4
ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNzU0ODkyNDAwNzcyNTAmYW1wO3NkYXRhPXJF
OEE2aktBSVgwODFaaHh4Y01jJTJCcEdkWHZzTFVkckFXNEFrTHNUcE54ZyUzRCZhbXA7cmVzZXJ2
ZWQ9MAo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Pj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbHViZW4udHVpa292JTQwYW1kLmNvbSU3Q2Ix
ZmRjMzk3MGEyMjRmYzYxZmRjMDhkN2IzYmI0NjEzJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE3NTQ4OTI0MDA3NzI1MCZhbXA7c2RhdGE9ckU4QTZqS0FJ
WDA4MVpoeHhjTWMlMkJwR2RYdnNMVWRyQVc0QWtMc1RwTnhnJTNEJmFtcDtyZXNlcnZlZD0wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
