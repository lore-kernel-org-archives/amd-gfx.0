Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720F2C5ACC4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 22:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D45524670
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 22:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I0rl8QUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D45524670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41826ECBD;
	Wed, 19 Feb 2020 22:03:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920D46ECBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 22:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWbY/iNYSrOIS0nUyToVoUgUfYLEN7JbaDFps4DPHFQilla9G5pm2JR7PIbKQVcftL8teWaFANaXeckONKDk8qgpguZ5DGLN+moPoc34zKObP4dtiPVxn/2FyNdU9VwrBZXp8hSwnnkt3ix1Y+MoUfXtGgLnkQoBu4ltie6G+xAtmMakQbA6o/buFD+pWwbeuHkgP4PIYdiA1M17fvjeirAyIs/aprzWeY8mnZpPLzsNzgakVIPD0h6XA/whQ21ERkMgjGTGCfAa94VGzV51IyAHGLvCpMJkUuvX+WDj29nkxlxHA6B3dF12fwH50q1EYGYZ5apoT8U0494PHugFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNRA/jhrFzqRortwTbwZQGKBA2Znxn9AOvY0RbJL4VE=;
 b=Qk2ZSxoiQ7RbQDW/CV8PKJNFXxbLHDDOIE2glsT1hW2H7eLDySqB53Mh03yb6DN6lct0kiAh6y1cK0tLcnBFg/GUGNfePX9AG8IybcQIpUS7zpHvkUcSL593g+qPZ2eyu33IgYfbivrIPnyza9oj5X1scudyBQBKCJD+GZW9F2O3Kp6N0y2Zx44/0pVcCk/aiC2ZzRFI4d5ydeuihhtIUXO2F+EfkLZGqeRHnPXzePHhDe0c0sBEygaRYYl+U1VSEgzL4snKpV9bYcal/qbqZQoDtGPHRnMbrumtybhT5jvdQTvCny/mgSvGwiauas0wvyCaEZKEcKQTXW/d8EanrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNRA/jhrFzqRortwTbwZQGKBA2Znxn9AOvY0RbJL4VE=;
 b=I0rl8QUSWhIxSXpJCD2SO3MTaBn7KPBmiHoYrtdUSCB/edtfbo35wgLGvbTJ1EhE/mxDYUOSy9rWY7mW5ESGM2qNDdc+nVZR9p0LOQkvr/FcnLhV2GWLIfIXuRuIrYjiT5PiSxDdzSs3VD4wYYijQYIfrmJRh5nBbbNc1cVEMTY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB2636.namprd12.prod.outlook.com (20.176.116.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 22:03:24 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 22:03:23 +0000
Subject: Re: [PATCH] drm/amdgpu: Add a GEM_CREATE mask and bugfix
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20200215001714.605727-1-luben.tuikov@amd.com>
 <CADnq5_NQnRx-=zRru0zLcp61cLFhdL6xr7+PDcfh1oQCBTPpHQ@mail.gmail.com>
 <91d5bf04-6d71-4902-9ac9-f40f724abdc9@gmail.com>
 <46047362-745c-5a7f-0ba5-b36bb08f8d28@amd.com>
 <c1581681-e5b4-4b3b-5e05-f66e3ecd7075@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <c184f55b-d919-a055-fbbf-2435f2a89ad9@amd.com>
Date: Wed, 19 Feb 2020 17:03:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <c1581681-e5b4-4b3b-5e05-f66e3ecd7075@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 19 Feb 2020 22:03:23 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1491b62e-15b9-4c38-55a6-08d7b5878a09
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:|DM6PR12MB2636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB263673A312E2F2E574BA47FB99100@DM6PR12MB2636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(966005)(478600001)(52116002)(16526019)(26005)(45080400002)(66574012)(66946007)(6486002)(5660300002)(6506007)(31696002)(53546011)(186003)(110136005)(31686004)(316002)(86362001)(6512007)(4326008)(66556008)(8936002)(66476007)(8676002)(81156014)(81166006)(44832011)(2906002)(2616005)(956004)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2636;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qz0xOVq6ZNSbWpBUYflLQz65m1YjvohvrxERlu2bygLd2hcuVzbIZGBTDyAEG0Ql0ndo4d4/mydpAJeT915aCv6T+WaGCeSm4Z9bune3ZBQ3ceaIDhOguqd896eKx6AHjMa68jc5OUGVKfushG41zjMAFBryKP9RftqVV/7eQQ3B+g5nKTOuixzjtlTVnqTM1Z1pnUALdS4lWibsqe0fiub4yJ5Yt7AMixx7bYR0QRYlQlepBLg46L4q+L90HZAg+ZySl2HgRVW1wwJ9OZORYLGCLUkNkj7YbXpuOlVRiUyQO3kWrVNW6dhLrfLfbTrAyZ5Fg1K+FkAsTWm4/An8MrzFKYBTemw8SrGYcKPDFVbgGP/qt9MeY/7pr5FJL3xGnCzrctCzG8Bv7xzomd/io+uAmZ8uf0yrL03ZiC2pyV+kF3wDDq9aLfNYHrG/+tT+LQBSGFhFiiddvXgmOFlaDYoICxSgj/cxbBhVT19frfsQoou6Jf5YnnYynzw48iHhYHG+/4jNCke5tkS1gIMHw==
X-MS-Exchange-AntiSpam-MessageData: BlCaAkkPvEsvPLtQzL28mEFNH/MVWwmOuWisBrhBJAwQyT8X0gPRoaWPQjaS4CLPxDCNpCqtZAGlrkHHQwnkFhtIVWajnodcwFIrZ4WwKZyxdnB2wavEQbx7x9ljqY+QsXiQ/e0LV20hYLmYKHFCRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1491b62e-15b9-4c38-55a6-08d7b5878a09
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 22:03:23.9293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOyAPtb4pYZBYmKlJ2Rv4y+9J4ENJHBHNbNkZXIQgljhJJpB8CxVF7QolByr5SXH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMi0xOSAzOjIwIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTgu
MDIuMjAgdW0gMjI6NDYgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4+IE9uIDIwMjAtMDItMTcgMTA6
MDggYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDE3LjAyLjIwIHVtIDE1OjQ0
IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+Pj4+IE9uIEZyaSwgRmViIDE0LCAyMDIwIGF0IDc6MTcg
UE0gTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4gd3JvdGU6Cj4+Pj4+IEFkZCBh
IEFNREdQVV9HRU1fQ1JFQVRFX01BU0sgYW5kIHVzZSBpdCB0byBjaGVjawo+Pj4+PiBmb3IgdmFs
aWQvaW52YWxpZCBHRU0gY3JlYXRlIGZsYWdzIGNvbWluZyBpbiBmcm9tCj4+Pj4+IHVzZXJzcGFj
ZS4KPj4+Pj4KPj4+Pj4gRml4IGEgYnVnIGluIGNoZWNraW5nIHdoZXRoZXIgVE1aIGlzIHN1cHBv
cnRlZCBhdAo+Pj4+PiBHRU0gY3JlYXRlIHRpbWUuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCAxMSArKy0tLS0tLS0tLQo+
Pj4+PiAgICBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCAgICAgICAgICAgfCAgMiArKwo+
Pj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkK
Pj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4+PiBp
bmRleCBiNTFhMDYwYzYzN2QuLjc0YmI3OWU2NGZhMyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4+PiBAQCAtMjIxLDIxICsyMjEsMTQgQEAg
aW50IGFtZGdwdV9nZW1fY3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQg
KmRhdGEsCj4+Pj4+ICAgICAgICAgICBpbnQgcjsKPj4+Pj4KPj4+Pj4gICAgICAgICAgIC8qIHJl
amVjdCBpbnZhbGlkIGdlbSBmbGFncyAqLwo+Pj4+PiAtICAgICAgIGlmIChmbGFncyAmIH4oQU1E
R1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRCB8Cj4+Pj4+IC0gICAgICAgICAgICAg
ICAgICAgICBBTURHUFVfR0VNX0NSRUFURV9OT19DUFVfQUNDRVNTIHwKPj4+Pj4gLSAgICAgICAg
ICAgICAgICAgICAgIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQyB8Cj4+Pj4+IC0gICAg
ICAgICAgICAgICAgICAgICBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NMRUFSRUQgfAo+Pj4+PiAt
ICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9DUkVBVEVfVk1fQUxXQVlTX1ZBTElEIHwK
Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9HRU1fQ1JFQVRFX0VYUExJQ0lUX1NZ
TkMgfAo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQ
VEVEKSkKPj4+Pj4gLQo+Pj4+IEknZCByYXRoZXIga2VlcCB0aGUgbGlzdCBleHBsaWNpdCBzbyBu
byBvbmUgZW5kcyB1cCBmb3JnZXR0aW5nIHRvCj4+Pj4gdXBkYXRlIHRoZSBtYXNrIHRoZSBuZXh0
IHRpbWUgbmV3IGZsYWdzIGFyZSBhZGRlZC4KPj4+IEFkZGl0aW9uYWwgdG8gdGhhdCB0aGlzIHBh
dGNoIGlzIGJvZ3VzLgo+PiBTbyB0aGUgb25seSAiYWRkaXRpb25hbCIgdGhpbmcgeW91J3JlIGNv
bnRyaWJ1dGluZyB0byB0aGUgcmV2aWV3IG9mCj4+IHRoaXMgcGF0Y2ggaXMgY2FsbGluZyBpdCAi
Ym9ndXMiLiBDaGFyYWN0ZXJpemluZyB0aGUgcGF0Y2ggd2l0aCBhbiBhZGplY3RpdmUKPj4gYXMg
ImJvZ3VzIiBpcyB2ZXJ5IGRpc3R1cmJpbmcuIFdoYXQncyBuZXh0Pwo+IAo+IFdlbGwgdGhlIHBh
dGNoIGlzIHRlY2huaWNhbCBpbmNvcnJlY3QgYW5kIGJyZWFrcyB0aGUgY29kZSBpbiBhIHZlcnkg
Cj4gc3VidGxlIGFuZCBoYXJkIHRvIGRldGVjdCBtYW5uZXIuIEFsZXggZGlkbid0IG5vdGljZWQg
dGhhdCBlaXRoZXIuCj4gCj4gSSdtIG5vdCBhIG5hdGl2ZSBzcGVha2VyIG9mIEVuZ2xpc2gsIGJ1
dCBhcyBmYXIgYXMgSSBoYXZlIGxlYXJuZWQgCj4gImJvZ3VzIiBpcyB0aGUgcmlnaHQgYWRqZWN0
aXZlIGZvciB0aGF0Lgo+IAo+Pj4gV2UgaW50ZW50aW9uYWxseSBmaWx0ZXIgb3V0IHRoZSBmbGFn
cyBoZXJlIHdoaWNoIHVzZXJzcGFjZSBpcyBhbGxvd2VkIHRvCj4+PiBzcGVjaWZ5IGluIHRoZSBH
RU0gaW50ZXJmYWNlLCBidXQgYWZ0ZXIgdGhpcyBwYXRjaCB3ZSB3b3VsZCBhbGxvdyBhbGwKPj4+
IGZsYWdzIHRvIGJlIHNwZWNpZmllZC4KPj4gSSB0aG91Z2h0IHRoYXQgdGhhdCBjb3VsZCBiZSB0
aGUgY2FzZS4KPiAKPiBUaGVuIHdoeSBkaWQgeW91IHNlbmQgb3V0IGEgcGF0Y2ggd2hpY2ggaXMg
c2VyaW91c2x5IGJyb2tlbiBsaWtlIHRoYXQ/Cj4gCj4gSSBtZWFuIGlmIEkgaGFkbid0IG5vdGlj
ZWQgaXQgYnkgY2hhbmNlIHdlIHdvdWxkIGhhdmUgY29tbWl0dGVkIHRoaXMgYW5kIAo+IGFkZGVk
IGEgcG90ZW50aWFsbHkgc2VjdXJpdHkgcHJvYmxlbWF0aWMgYnVnIHRvIHRoZSBJT0NUTCBpbnRl
cmZhY2UuCj4gCj4+IEJ1dCBpbiB5b3VyIHJldmlldyB3aHkgbm90Cj4+IHJlY29tbWVuZCB3ZSBo
YXZlIGEgbWFzayB0byBjaGVjayB1c2VyLXNldHRhYmxlIGZsYWdzPyBTbyB0aGUKPj4gYWN0dWFs
IGZsYWdzIGFyZSBjb2xsZWN0ZWQgYW5kIHZpc2libGUgaW4gb25lIHBsYWNlIGFuZCB3ZWxsCj4+
IHVuZGVyc3Rvb2QgdGhhdCB0aGF0IGlzIHdoYXQgaXMgYmVpbmcgY2hlY2tlZCBhbmQgd2VsbC1k
ZWZpbmVkCj4+IGJ5IGEgbWFjcm8gd2l0aCBhbiBhcHByb3ByaWF0ZSBuYW1lPwo+IAo+IFNlZSB0
aGUgZmxhZ3MgdGVzdGVkIGhlcmUgYXJlIHRoZSBmbGFncyBjdXJyZW50bHkgYWNjZXB0ZWQgYnkg
dGhlIAo+IGFtZGdwdV9nZW1fY3JlYXRlX2lvY3RsKCkgZnVuY3Rpb24uIEl0IGRvZXNuJ3Qgc2F5
IGFueXRoaW5nIGFib3V0IHdoYXQgCj4gdGhlIGtlcm5lbCB3b3VsZCBhY2NlcHQgaW4gdGhlIGZ1
dHVyZS4KPiAKPiBTbyB3aGVuIHdlIG1vdmUgdGhhdCBpbnRvIHRoZSBVQVBJIGhlYWRlciB3ZSBn
aXZlIHVzZXJzcGFjZSBhIAo+IHRlY2huaWNhbGx5IGluY29ycmVjdCB2YWx1ZS4KPiAKPj4gV2h5
IGRpZCBOTyBPTkUgY29tbWVudCBvbiB0aGUgYnVnIGZpeCBiZWxvdz8gTm8gb25lLgo+IAo+IEJl
Y2F1c2UgeW91IG1peGVkIHVwIGEgc3R5bGUgY2hhbmdlIGludG8gc29tZSBidWcgZml4LiBUaGF0
IHBlb3BsZSBnbyAKPiBmb3IgdGhlIHByb2JsZW1hdGljIHBhcnRzIGR1cmluZyBjb2RlIHJldmll
dyBpcyBub3QgcmVhbGx5IHN1cnByaXNpbmcgYXQgCj4gYWxsLgoKSSB3b3VsZG4ndCBoYXZlIGV4
cGVjdGVkIGEgcGV0dWxhbnQtY2hpbGRsaWtlIHJlc3BvbnNlLgpJIHdvdWxkJ3ZlIGV4cGVjdGVk
IGEgbGVhZGVyc2hpcC1saWtlIHBvc2l0aW9uLCBzb21ldGhpbmcgbGlrZToKU3BsaXQgeW91ciBw
YXRjaCBpbnRvIHR3by4gVGhlIHNlY29uZCBwYXJ0IGlzIG9rYXkgd2l0aCB0aGUgYWRkaXRpb24K
b2YgRFJNX1BSSU5UX09OQ0UsIGFuZCB0aGUgZmlyc3QgcGFydCBhZG1pdHMgYml0cyB3aGljaCB3
ZSBkb24ndAp3YW50IHVzZXIgc3BhY2UgdG8gY29udHJvbC4KClJlZ2FyZHMsCkx1YmVuCgoKPiAK
PiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPiAKPj4KPj4gUmVnYXJkcywKPj4gTHViZW4KPj4KPj4+
IENocmlzdGlhbi4KPj4+Cj4+Pgo+Pj4KPj4+PiBBbGV4Cj4+Pj4KPj4+Pj4gKyAgICAgICBpZiAo
ZmxhZ3MgJiB+QU1ER1BVX0dFTV9DUkVBVEVfTUFTSykKPj4+Pj4gICAgICAgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7Cj4+Pj4+Cj4+Pj4+ICAgICAgICAgICAvKiByZWplY3QgaW52YWxpZCBn
ZW0gZG9tYWlucyAqLwo+Pj4+PiAgICAgICAgICAgaWYgKGFyZ3MtPmluLmRvbWFpbnMgJiB+QU1E
R1BVX0dFTV9ET01BSU5fTUFTSykKPj4+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7Cj4+Pj4+Cj4+Pj4+IC0gICAgICAgaWYgKGFtZGdwdV9pc190bXooYWRldikgJiYgKGZsYWdz
ICYgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEKSkgewo+Pj4+PiArICAgICAgIGlmICghYW1k
Z3B1X2lzX3RteihhZGV2KSAmJiBmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRCkg
ewo+Pj4+PiAgICAgICAgICAgICAgICAgICBEUk1fRVJST1IoIkNhbm5vdCBhbGxvY2F0ZSBzZWN1
cmUgYnVmZmVyIHNpbmNlIFRNWiBpcyBkaXNhYmxlZFxuIik7Cj4+Pj4+ICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOwo+Pj4+PiAgICAgICAgICAgfQo+Pj4+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9k
cm0uaAo+Pj4+PiBpbmRleCBlYWY5NGE0MjE5MDEuLmM4NDYzY2RmNDQ0OCAxMDA2NDQKPj4+Pj4g
LS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPj4+Pj4gKysrIGIvaW5jbHVkZS91
YXBpL2RybS9hbWRncHVfZHJtLmgKPj4+Pj4gQEAgLTE0MSw2ICsxNDEsOCBAQCBleHRlcm4gIkMi
IHsKPj4+Pj4gICAgICovCj4+Pj4+ICAgICNkZWZpbmUgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQ
VEVEICAgICAgICAgICAgKDEgPDwgMTApCj4+Pj4+Cj4+Pj4+ICsjZGVmaW5lIEFNREdQVV9HRU1f
Q1JFQVRFX01BU0sgICAgICAgICAgICAgICAgICAoKDEgPDwgMTEpLTEpCj4+Pj4+ICsKPj4+Pj4g
ICAgc3RydWN0IGRybV9hbWRncHVfZ2VtX2NyZWF0ZV9pbiAgewo+Pj4+PiAgICAgICAgICAgLyoq
IHRoZSByZXF1ZXN0ZWQgbWVtb3J5IHNpemUgKi8KPj4+Pj4gICAgICAgICAgIF9fdTY0IGJvX3Np
emU7Cj4+Pj4+IC0tCj4+Pj4+IDIuMjUuMC4yMzIuZ2Q4NDM3YzU3ZmEKPj4+Pj4KPj4+Pj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+Pj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+Pj4g
aHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1k
LWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbHViZW4udHVpa292JTQwYW1kLmNvbSU3Q2IxZmRjMzk3
MGEyMjRmYzYxZmRjMDhkN2IzYmI0NjEzJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4
M2QlN0MwJTdDMCU3QzYzNzE3NTQ4OTI0MDA3NzI1MCZhbXA7c2RhdGE9ckU4QTZqS0FJWDA4MVpo
eHhjTWMlMkJwR2RYdnNMVWRyQVc0QWtMc1RwTnhnJTNEJmFtcDtyZXNlcnZlZD0wCj4+Pj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+PiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4gaHR0
cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdm
eCZhbXA7ZGF0YT0wMiU3QzAxJTdDbHViZW4udHVpa292JTQwYW1kLmNvbSU3Q2IxZmRjMzk3MGEy
MjRmYzYxZmRjMDhkN2IzYmI0NjEzJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzE3NTQ4OTI0MDA3NzI1MCZhbXA7c2RhdGE9ckU4QTZqS0FJWDA4MVpoeHhj
TWMlMkJwR2RYdnNMVWRyQVc0QWtMc1RwTnhnJTNEJmFtcDtyZXNlcnZlZD0wCj4gCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
