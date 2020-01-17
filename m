Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2418C33C9E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 20:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AFE2072B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 20:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GyxDULY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AFE2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329BF6E045;
	Fri, 17 Jan 2020 20:52:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BF66E045
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 20:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3KyHJAEjCgm2XcAOQph/puaCSSwDRDkJqVRXZ5VC/4W6khJeSHwuQoAHJ+6XGjA3pwvU8z/vV2c/9Ymx5BrCms4iicF/K5bLU9eaaLX71UOXprnIDMwXaJbUkvQ/gwk6b7BF2s2ecC7m9uKNRPRdISuUJgYwuIC8vBgSFXSydI/PtYQTvA56oNhCleCoNoERbq3YJu68Ik/cByi2LX94EmhfuPjLjuvyVwBKc9qrt1srgeBvc6qSIrVVZEUlkuIALRGYjdlBqpn9mNaoRkgLQ8rKeOIg1oOp9+DbafD311p/OhltOfQwla3Hb4n4uxA90uKXYKPvmJOHXYulokuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrME3gxOz0fKwbs0qN/6IWYOK+L2jt8VrqOPbRC1tlw=;
 b=aHuzex7BSa8RURisj29Ksp6vIsdSVoUCscvg9qNbd+XWLtUSpnx2RWLAwdUhcpCuwAKj4s18Ykm1uWVAxs8sI6om5s97VCriaJOtQ5yCQgm+hLATg2gvvkEi8791xadUJtzvptJrANUy86ZY2wJGqlB+U0XrPidBk0eF1meZDbJRvvvoRVSFUJYOrHn9xzWGw226nyANOGhME7MSrrJPdMCHSuLdzCLz31imEnQ1IYZdnmsTquvtFGF35QyDUTv2P7zcPCQGGnQrHCgDgyS2+qWZW5y0p6A0CEhu3xS9FTwmL2QZOiAAQH6aMcRSQ9ba4fBjbUW47Rfz7SXKnIlAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrME3gxOz0fKwbs0qN/6IWYOK+L2jt8VrqOPbRC1tlw=;
 b=GyxDULY3rkL8PRHh3coQOc+png8v/EoK7ejPTLF+u2cT/zKiC+m7kGYux3YnoYHmQranMzDMPRZJXec3zWMEo/ggPU0Fq1oQ5hmazMFjuIEjqEijbYlEiEMbI1A4ppy8iI09audaNKBM2/FoeY2Nuhv/DUOoBEpo5ufso2kp4U8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2488.namprd12.prod.outlook.com (10.172.86.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Fri, 17 Jan 2020 20:52:54 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 20:52:54 +0000
Subject: Re: [PATCH] drm/amdgpu: add coreboot workaround for KV/KB
To: christian.koenig@amd.com, fredrik.bruhn@unibap.com,
 amd-gfx@lists.freedesktop.org
References: <20200116130907.22410-1-christian.koenig@amd.com>
 <c5aa1227-adc0-f7d0-1786-deec7ca681c1@amd.com>
 <3c1b6bea-d5bc-0532-9805-2eb2c1003653@gmail.com>
 <2f992eda-75c8-570b-fc77-584ad4959168@amd.com>
 <b2b1b2b2-e99d-5941-4670-786034fbcc56@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <e06db6cb-6345-19d7-37d4-52fa091326f3@amd.com>
Date: Fri, 17 Jan 2020 15:52:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <b2b1b2b2-e99d-5941-4670-786034fbcc56@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::40) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 20:52:53 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47f341ad-51e0-4124-0bb1-08d79b8f3953
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:|DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24886A366FC9F69BDC74E99B92310@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(189003)(199004)(26005)(53546011)(966005)(31696002)(316002)(16576012)(2906002)(36916002)(16526019)(186003)(52116002)(956004)(478600001)(2616005)(45080400002)(66476007)(8936002)(81166006)(44832011)(66556008)(66946007)(81156014)(8676002)(86362001)(31686004)(6486002)(66574012)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2488;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lr4UHx7ns8hMxe/Ay6WEy8PBiLJeL6YgFGvbyfOsKtYuoQixwNpu4h+YL4SUDvEhMsW5UHrGEGzpg69gJlg3sPVlvKWam5YOGCtNBR+5qgDqCxrYrdpN9bIE/t2HGsw6HjdcZVyqFHWK+CnW3N0dPOspzSxZP09o8fIHtGxTpg8HIAAkid3sw/KhH10BLYOu2LREXHmkrug7aUP2sGd76tvbf0BSRcpRfMl8EZxBdk3ucf+F/SwP55YabMf4WCkIO4VVaHLA7dwVX75IYZuRz7teHln0So4hCONOZxJdUJPWaWiHuVLkFRl7fQPbNeAH+l8zbv5tLsc3NOwUX3MwK1yzq6myx3XBdTOVYz9kSKEGiYEszp7SgI8MMBjkvtYp3V5SjKhbMk1kggJBxp0jutpoNWxR+WBiyDcnf7UxUja/RqqJ3gv/fof+Azh7ZrU9QbvaE+RJ93bkpOBC2RKapk1q916h0zMN1Vo4qhYXXz0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f341ad-51e0-4124-0bb1-08d79b8f3953
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 20:52:54.3995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gV1PhurnFVet+OnEWuHOBd8mrslbthvyCIj4W3DrHefiIBWjdIBjs44DPbFsgffx9R5dW57Jdtx185QYFdQXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMS0xNyAxOjQ2IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTcu
MDEuMjAgdW0gMTg6MDcgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4gT24gMjAyMC0wMS0xNyAz
OjE3IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxNy4wMS4yMCB1bSAwMzow
MSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4+IE9uIDIwMjAtMDEtMTYgODowOSwgQ2hyaXN0
aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4gQ29yZWJvb3Qgc2VlbXMgdG8gaGF2ZSBhIHByb2JsZW0g
Y29ycmVjdGx5IHNldHRpbmcgdXAgYWNjZXNzIHRvIAo+Pj4+PiB0aGUgc3RvbGVuIFZSQU0KPj4+
Pj4gb24gS1YvS0IuIFVzZSB0aGUgZGlyZWN0IGFjY2VzcyBvbmx5IHdoZW4gbmVjZXNzYXJ5Lgo+
Pj4+Cj4+Pj4gSSdtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4gYnkgIm5lY2Vzc2FyeSIuCj4+Pgo+
Pj4gTmVjZXNzYXJ5IGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UuCj4+Cj4+IFJpZ2h0LiBTbyB5b3Vy
IHBhdGNoIGRlc2NyaXB0aW9uIHNheXMgdGhhdCBzb21ldGltZXMgYmV0dGVyIAo+PiBwZXJmb3Jt
YW5jZSBpcyBub3QgbmVjZXNzYXJ5Lgo+Cj4gV2VsbCB3aGF0IEkgd2FudCB0byBzYXkgaXMgdGhh
dCBpdCBpcyBub3QgbmVjZXNzYXJ5IGZvciBiZXR0ZXIgCj4gcGVyZm9ybWFuY2UuIElmIEZCIGlz
IHNtYWxsIGVub3VnaCB3ZSBjYW4gdXNlIHRoZSBCQVIgYXMgd2VsbC4KPgo+PiBUaGUgY3JpdGVy
aWEgaXMgYmFzZWQgb24gdGhlIHNpemUgb2YgdGhlIEJBUiwgd2hpY2ggZG9lc24ndCByZWFsbHkg
Cj4+IGhhdmUgYW55dGhpbmcgdG8gZG8gd2l0aCBwZXJmb3JtYW5jZS4KPgo+IFdoeT8gTW9zdCBv
ZiB0aGUgcGVyZm9ybWFuY2UgZ2FpbiBjb21lcyBmcm9tIG5vdCBzaHVmZmxpbmcgYXJvdW5kIFZS
QU0gCj4gYnVmZmVycyBmb3IgQ1BVIGFjY2VzcyBhbnkgbW9yZS4KPgo+IEFkZGl0aW9uYWwgdG8g
dGhhdCB0aGVyZSBpcyBhIHJlZHVjdGlvbiBpbiBsYXRlbmN5IHdoZW4gYWNjZXNzaW5nIHRoZSAK
PiBWUkFNLCBidXQgdGhhdCB1c3VhbGx5IGRvZXNuJ3QgbWF0dGVyIGZvciBwZXJmb3JtYW5jZS4K
Ckl0J3MgcG9zc2libGUgdGhhdCBteSByZWNvbGxlY3Rpb24gb2YgdGhpcyBpcyBhIGJpdCBvdXRk
YXRlZC4gV2hlbiB3ZSAKZmlyc3QgaW50cm9kdWNlZCB0aGlzIG1ldGhvZCBvZiBGQiBhY2Nlc3Mg
aW4gZmdscnggb3ZlciAxMCB5ZWFycyBhZ28sIGl0IApoYWQgYSBiaWcgaW1wYWN0IG9uIDJEIHBl
cmZvcm1hbmNlIGluIHRoZSBYc2VydmVyLiBUaGF0IHdhcyBiZWZvcmUgdGhlIApkYXlzIG9mIEdM
IGJhc2VkIGNvbXBvc2l0b3JzIGFuZCBHTCBiYXNlZCAyRCBhY2NlbGVyYXRpb24uIE1heWJlIHdp
dGggCmN1cnJlbnQgZGVza3RvcCBlbnZpcm9ubWVudHMgYW5kIDJEIGFjY2VsZXJhdGlvbiBjb2Rl
IGl0IGRvZXNuJ3QgbWF0dGVyIAptdWNoIGFueSBtb3JlLgoKSW4gdGhhdCBjYXNlIGZlZWwgZnJl
ZSB0byBhZGQgbXkKClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKCj4KPj4KPj4KPj4+Cj4+Pj4KPj4+Pj4KPj4+
Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+Pj4+PiAtLS0KPj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3
XzAuYyB8IDMgKystCj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dtY192N18wLmMgCj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21j
X3Y3XzAuYwo+Pj4+PiBpbmRleCAxOWQ1YjEzM2UxZDcuLjlkYTk1OTZhMzYzOCAxMDA2NDQKPj4+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwo+Pj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jCj4+Pj4+IEBAIC0zODEsNyAr
MzgxLDggQEAgc3RhdGljIGludCBnbWNfdjdfMF9tY19pbml0KHN0cnVjdCAKPj4+Pj4gYW1kZ3B1
X2RldmljZSAqYWRldikKPj4+Pj4gwqDCoMKgwqDCoCBhZGV2LT5nbWMuYXBlcl9zaXplID0gcGNp
X3Jlc291cmNlX2xlbihhZGV2LT5wZGV2LCAwKTsKPj4+Pj4gwqAgwqAgI2lmZGVmIENPTkZJR19Y
ODZfNjQKPj4+Pj4gLcKgwqDCoCBpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSB7Cj4+Pj4+
ICvCoMKgwqAgaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSAmJgo+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgYWRldi0+Z21jLnJlYWxfdnJhbV9zaXplID4gYWRldi0+Z21jLmFwZXJfc2l6ZSkgewo+
Pj4+Cj4+Pj4gQ1BVIGFjY2VzcyB0byB0aGUgd2hvbGUgVlJBTSBpc24ndCByZWFsbHkgbmVjZXNz
YXJ5LiBJIHRob3VnaHQgdGhlIAo+Pj4+IG1haW4gbW90aXZhdGlvbiBmb3IgYWNjZXNzaW5nIEZC
IGRpcmVjdGx5IG9uIEFQVXMgd2FzIGJldHRlciAKPj4+PiBwZXJmb3JtYW5jZS4gWW91J3JlIGRp
c2FibGluZyB0aGF0IG9wdGltaXphdGlvbiBvbiBhbGwgQVBVcyB3aGVyZSAKPj4+PiB0aGUgRkIg
aXMgc21hbGxlciB0aGFuIHRoZSBhcGVydHVyZSBzaXplLgo+Pj4KPj4+IENvcnJlY3QsIHllcy4g
Rm9yIHNvbWUgcmVhc29uIGNvcmVib290IHNlZW1zIHRvIGV4cGxpY2l0bHkgc2V0dXAgdGhlIAo+
Pj4gbWVtb3J5IHVzZWQgZm9yIHRoZSBGQiBhcyB3cml0ZS1wcm90ZWN0ZWQuCj4+Pgo+Pj4gVGhl
IEdQVSBjYW4gc3RpbGwgcmVhZC93cml0ZSBpdCBub3JtYWxseSBjYXVzZSBpdCBpZ25vcmVzIHRo
YXQgCj4+PiBwcm90ZWN0aW9uLCBidXQgdGhlIENQVSBjYW4ndCBjaGFuZ2UgdGhlIEZCIG1lbW9y
eSBhbnkgbW9yZSB3aXRoIAo+Pj4gdGhhdCBzZXR1cC4KPj4KPj4gQ2FuIHdlIHRlc3Qgd2hldGhl
ciB3cml0aW5nIHRvIEZCIHdvcmtzIGFuZCBtYWtlIHRoZSBkZWNpc2lvbiBiYXNlZCAKPj4gb24g
dGhhdD8KPgo+IFRob3VnaHQgYWJvdXQgdGhhdCBhcyB3ZWxsLiBCdXQgaXQgaXMgY29tcGxpY2F0
ZWQgdG8gaW1wbGVtZW50IGFuZCB3ZSAKPiB3b3VsZCBuZWVkIHRvIHRlc3QgdGhlIHdob2xlIEZC
IHRvIGJlIHN1cmUgYW5kIHRoYXQgY291bGQgdGFrZSBhIHdoaWxlLgo+Cj4gQ2hyaXN0aWFuLgo+
Cj4+Cj4+IFRoYW5rcywKPj4gwqAgRmVsaXgKPj4KPj4+Cj4+PiBObyBpZGVhIHdoeSB0aGV5IGRv
IHRoaXMsIG1vc3QgbGlrZWx5IGp1c3QgYW4gb3ZlciBjb25zZXJ2YXRpdmUgCj4+PiBwcm90ZWN0
aW9uIG9mIGEgcmVzZXJ2ZWQgYXJlYSBvZiBtZW1vcnkuCj4+Pgo+Pj4gUmVnYXJkcywKPj4+IENo
cmlzdGlhbi4KPj4+Cj4+Pj4KPj4+PiBSZWdhcmRzLAo+Pj4+IMKgIEZlbGl4Cj4+Pj4KPj4+Pgo+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+Z21jLmFwZXJfYmFzZSA9ICgodTY0KVJSRUcz
MihtbU1DX1ZNX0ZCX09GRlNFVCkpIAo+Pj4+PiA8PCAyMjsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGFkZXYtPmdtYy5hcGVyX3NpemUgPSBhZGV2LT5nbWMucmVhbF92cmFtX3NpemU7Cj4+Pj4+
IMKgwqDCoMKgwqAgfQo+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+PiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxt
YW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2ZlbGl4Lmt1ZWhsaW5n
JTQwYW1kLmNvbSU3Q2NiN2ZkZTkzYzA4YzQwNjBmNWJjMDhkNzliN2RhNWI5JTdDM2RkODk2MWZl
NDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE0ODgzNjI3NDQ0OTEyOSZhbXA7
c2RhdGE9cyUyQjZhNzlSdDRDc2p5UTc0Q1pIJTJCQVRMb0gzTGNzb29rSGlHazA0WFg4aDQlM0Qm
YW1wO3Jlc2VydmVkPTAgCj4+Pj4KPj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1h
aWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2ZlbGl4Lmt1ZWhs
aW5nJTQwYW1kLmNvbSU3Q2NiN2ZkZTkzYzA4YzQwNjBmNWJjMDhkNzliN2RhNWI5JTdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE0ODgzNjI3NDQ0OTEyOSZh
bXA7c2RhdGE9cyUyQjZhNzlSdDRDc2p5UTc0Q1pIJTJCQVRMb0gzTGNzb29rSGlHazA0WFg4aDQl
M0QmYW1wO3Jlc2VydmVkPTAgCj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
