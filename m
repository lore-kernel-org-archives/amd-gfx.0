Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69085C1975A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 15:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CE320674
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 15:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OvbVr2TD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CE320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08F86EAE5;
	Thu, 12 Mar 2020 15:22:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770078.outbound.protection.outlook.com [40.107.77.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA76A6EAE5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 15:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWPiB3kBvcDeLmkaYPYKI8a+safIaovwJmEePVM8yWKF3LLVo7b9mFPm4q+MBZBH0dajpJAoMsM3gTtQ8iV0nVYhQ5lS5KIu8lkqFJ3KCnnjaA8Y3coiK9qVF6Xk3iihVemKa/vpMOHsF+ZhOHFgh7kMI38R8Q9Wmx4Gy3YSthpH2WUFsO5QWdJq1TKmZh5rjBsxWtxqBJP2lhcFabBrkAFRCs0NguoUlJpzTYy0eZnB8DGxKDJvMsk9QVT7Dewwzq7oGkgE+naV1KFvWLBf2zLiUpAqtRDWQ2RwtjY260AGk4Nh1UklcXaCL9a4XjZSpFu6PGNQxocZrEA0NVgbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d46qY5bJKN//ri7Pi0xd7tnXtEzfg1MNHgIqws6AZvE=;
 b=bCocOZESRJPiqSoysIi17GYyUfLFwb+e7KJ7fa+B1yUJ9U9azj2Rs/DXKwpyCQxUprxfc2ZQvWYGrMVv1xpRZedhMWgpQYCa3zsYJuTx8ON0xHil2PPcKz7okZSpi8wV7lfNhBO5NocMO8ktPMAyCe9C5vjBQ6kO5vw4PRsSqLHsKYimB9jW0tocTBLiq2zn3r0t7GEENvp6ibugXFiRbM/Q9nIxkudEGZTa/PITOjyEdty3CcCcsUD4apFDZjqj66eZlIvRyXiuVcQP/39R3E486E29ME3dh0Gg9J4FkYP/sduX4OZb8E2Y0bDBAMbDgTgRZwBCj7w4xVSxfwZfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d46qY5bJKN//ri7Pi0xd7tnXtEzfg1MNHgIqws6AZvE=;
 b=OvbVr2TDnV0esp7n0yfvkjBHFxtMAUfuHyFo6V2eHxEuVc2n+tXrl2hHCNKxv2q+YHSl+VrJX1ZFa9tFnl1o8lOOlc1BFbbcVlNdecVmFV1GFWMvngJJ0zb8l0XXtTkpXq8KLj1Lo13xfF0N4xj7O559dhC0Ypj3g3jF3gKzZ4I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB2408.namprd12.prod.outlook.com (2603:10b6:4:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 15:22:43 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 15:22:43 +0000
Subject: Re: [PATCH] drm/amdgpu: fix and cleanup amdgpu_gem_object_close
To: "Liu, Monk" <Monk.Liu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200312111203.81500-1-christian.koenig@amd.com>
 <MN2PR12MB39335E821319112A6D42CD1784FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
 <eb87e9c1-7e76-11a1-2aa9-fc719e28901c@gmail.com>
 <MN2PR12MB39337C7AFE4D925A877FC94184FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
 <58b21805-3cae-a189-6b8a-234151b73dee@amd.com>
 <MN2PR12MB3933EB5A814371E09B9E928A84FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5cfa65cb-b785-96de-c044-7e3bcb8f6993@amd.com>
Date: Thu, 12 Mar 2020 16:22:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MN2PR12MB3933EB5A814371E09B9E928A84FD0@MN2PR12MB3933.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:208:154::28) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0087.eurprd02.prod.outlook.com (2603:10a6:208:154::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Thu, 12 Mar 2020 15:22:41 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57aaf44e-e27a-459a-32a6-08d7c6993578
X-MS-TrafficTypeDiagnostic: DM5PR12MB2408:|DM5PR12MB2408:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24081D0CC33ACF410EBF812B83FD0@DM5PR12MB2408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(5660300002)(81166006)(81156014)(8936002)(6666004)(2616005)(478600001)(186003)(52116002)(16526019)(53546011)(86362001)(31696002)(316002)(45080400002)(6486002)(966005)(66556008)(36756003)(31686004)(8676002)(66574012)(110136005)(66946007)(2906002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2408;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWcjDxgJopWNMTtgkDuzOkWP3eer6ivSofY10tU4/0znEDngO91tsDUCR+Wn//7UTJYqy65h5j5hGxo9V5Q5NB0nh7Q9V0hY2EQE8/Z+ROnMyfCs+Q7DDf6foj5IgP5i1GNPOHP72BQ4VJfgff6A/a54F6BnoJISePx+26bEInInhtXjuXHcLi7M1aBVhd46mXf4fuG3VFc/WHuujN0s/MxBxc1bdgJXzwg7r7DfLvAs6yZVtHvDw68gMtMYz5qAeRRGM/3b3+JR+wRevmvyLCcoO4yHMpidoGkcbVYJMF9AgZtu1s0RIP+oxNuC65WGegRwB09oQDryTdrTnFiHJqEVywRaWN1bMYunJqwyJYek47yEHURHa871frxqXTHqfACyk2I9FVv5Ef3UFG0bwmfzFHeL7aOdda3HN7qqlITkEXROKbhNSuS4B0n0EAnCkKnRvMOUT2oT2vOWM6RpjyqGfW8jkHPVIEa2VRaQ4ZUgY5ZXv6axb0gdyEYOlKkgW+NVXRo/g3RFIbmwYMldkbluHYKuSJ8Fz2lTHQ49ohOV7JUESwOD5vQiEQiviUbsVAhvbM06zh4XKNTdPp+SLpAy6bmoR+kB44EsHVCuQl/XRY2eAmfAB7ciBJ5IQ7pa
X-MS-Exchange-AntiSpam-MessageData: VC7ZGr3VWiPVpr/APbNalgHFQopn/Uf0znq3oIYK9kPt3hA0TdME8tBC5iwR9+EmDSnvXjN4rRuRIKnZCx/BHBK4ZpYn2cz4Mt613rON/XsHuihH54C1hwP6X2aemwZD1JXJF5Ri6NkVt0Xh3UIamqUgf9pa33UC3BV3XrxIrm6WoVAC0GGOYXsGCL2eXAYP3kfI7atc1WahwoE1zW5iWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57aaf44e-e27a-459a-32a6-08d7c6993578
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 15:22:42.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO/h22Sl2N0a8v0qlLrMwwjjJrPcRXGDsiaZYPsaos62QZu6Qufr2xiLvyHy2Qsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2408
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

QW0gMTIuMDMuMjAgdW0gMTY6MDMgc2NocmllYiBMaXUsIE1vbms6Cj4+Pj4gVGhlIHByb2JsZW0g
aXMgdGhhdCBkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3JjdSgpIHRlc3RzIG9ubHkgdGhlIHNoYXJl
ZCBmZW5jZSBpZiBvbmUgaXMgcHJlc2VudC4KPiBPa2F5IEkgZ290IHRoZSBwb2ludCBub3csIGJ1
dCB3aHkgd2UgY2Fubm90IG1vZGlmeSBkbWFfcmVzdl90ZXN0X3NpZ25hbGVkX3JjdSgpIHRvIGxl
dCBpdCB3YWl0IGZvciBib3RoIGV4Y2x1c2l2ZSBhbmQgc2hhcmVkIGxpc3RzID8KClRoYXQgaXMg
ZXhhY3RseSB3aGF0IEkgYW5kIFhpbmh1aSBzYWlkIGFzIHdlbGwgYW5kIHdoYXQgd2UgYWxzbyBi
b3RoIApwcm9wb3NlZCBpbiBwYXRjaGVzLCBidXQgdGhlIEludGVsIGd1eXMgYXJlIGFnYWluc3Qg
dGhhdC4KCkkgYWxzbyBhbHJlYWR5IHByb3Bvc2VkIGFuIGV4dGVuc2lvbiB0byB0aGUgZG1hX3Jl
c3YgaW5mcmFzdHJ1Y3R1cmUgCndoZXJlIHlvdSBnZXQgYSBsaXN0IG9mICJvdGhlciIgZmVuY2Vz
IGZvciBzdHVmZiBsaWtlIHRoaXMsIGJ1dCBpdCAKd2Fzbid0IHRvIHdlbGwgcmVjZWl2ZWQgZWl0
aGVyIGFuZCBJIGNhbid0IGRlZGljYXRlIG1vcmUgdGltZSB0byB0aGlzLgoKUmVnYXJkcywKQ2hy
aXN0aWFuLgoKPgo+Cj4gQWNrLWJ5OiBNb25rIExpdSA8bW9uay5saXVAYW1kLmNvbT4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTW9uayBMaXV8R1BVIFZpcnR1YWxp
emF0aW9uIFRlYW0gfEFNRAo+Cj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206
IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+Cj4gU2VudDogVGh1
cnNkYXksIE1hcmNoIDEyLCAyMDIwIDk6NDIgUE0KPiBUbzogTGl1LCBNb25rIDxNb25rLkxpdUBh
bWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGFu
ZCBjbGVhbnVwIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlCj4KPiBUaGUgcHJvYmxlbSBpcyB0aGF0
IGRtYV9yZXN2X3Rlc3Rfc2lnbmFsZWRfcmN1KCkgdGVzdHMgb25seSB0aGUgc2hhcmVkIGZlbmNl
IGlmIG9uZSBpcyBwcmVzZW50Lgo+Cj4gTm93IHdoYXQgaGFwcGVuZWQgaXMgdGhhdCB0aGUgY2xl
YXIgZmVuY2UgY29tcGxldGVkIGJlZm9yZSB0aGUgZXhjbHVzaXZlIG9uZSwgYW5kIHRoYXQgaW4g
dHVybiBjYXVzZWQgVFRNIHRvIHRoaW5rIHRoYXQgdGhlIEJPIGlzIHVudXNlZCBhbmQgZnJlZWQg
aXQuCj4KPiBDaHJpc3RpYW4uCj4KPiBBbSAxMi4wMy4yMCB1bSAxNDoyNSBzY2hyaWViIExpdSwg
TW9uazoKPj4gd2l0aG91dCB5b3VyIHBhdGNoLCB0aGUgY2xlYXIgZmVuY2UgaXMgYWxzbyBob29r
ZWQgaW4gdGhlIHNoYXJlZCBsaXN0Cj4+IG9mIGJvJ3MgcmVzZXJ2YXRpb24gb2JqLCAgbm8gbWF0
dGVyIHRoZSBleGNsdXNpdmUgZmVuY2Ugb2YgdGhhdCBCTwo+PiBzaWduYWxlZCBiZWZvcmUgY2xl
YXIgZmVuY2Ugb3Igbm90Cj4+Cj4+IHNpbmNlIHRoZSBjbGVhciBmZW5jZSBpcyBhbHdheXMga2Vw
dCBpbiB0aGUgYm8ncyByZXN2IG9iamVjdCwgY2FuIHlvdSB0ZWxsIG1lIHdoYXQncyB0aGUgcHJv
YmxlbSB0aGFuID8gYXJlIHdlIGdvaW5nIHRvIGxvb3NlIHRoaXMgY2xlYXIgZmVuY2UgYW5kIHN0
aWxsIHVzZSBpdCBkdXJpbmcgdGhlICBWTSBwdC9wZCBjbGVhcmluZyA/Cj4+Cj4+IHRoYW5rcwo+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IE1vbmsgTGl1fEdQVSBW
aXJ0dWFsaXphdGlvbiBUZWFtIHxBTUQKPj4KPj4KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0KPj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb20+Cj4+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMiwgMjAyMCA4OjUwIFBNCj4+IFRvOiBM
aXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQu
Y29tPjsKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGdwdTogZml4IGFuZCBjbGVhbnVwCj4+IGFtZGdwdV9nZW1fb2JqZWN0X2Ns
b3NlCj4+Cj4+ICAgIEZyb20gdGhlIHNlbWFudGljIHRoZSBkbWFfcmVzdiBvYmplY3QgY29udGFp
bnMgYSBzaW5nbGUgZXhjbHVzaXZlIGFuZCBtdWx0aXBsZSBzaGFyZWQgZmVuY2VzIGFuZCBpdCBp
cyBtYW5kYXRvcnkgdGhhdCB0aGUgc2hhcmVkIGZlbmNlcyBjb21wbGV0ZSBhZnRlciB0aGUgZXhj
bHVzaXZlIG9uZS4KPj4KPj4gTm93IHdoYXQgaGFwcGVucyBpcyB0aGF0IGNsZWFyaW5nIHRoZSBW
TSBwYWdlIHRhYmxlcyBydW5zIGFzeW5jaHJvbm91c2x5IHRvIHRoZSBleGNsdXNpdmUgZmVuY2Ug
d2hpY2ggbW92ZXMgdGhlIGJ1ZmZlciBhcm91bmQuCj4+Cj4+IEFuZCBiZWNhdXNlIG9mIHRoaXMg
WGluaHVpIHJhbiBpbnRvIGEgcmFyZSBwcm9ibGVtIHRoYXQgVFRNIHRob3VnaHQgaXQgY291bGQg
cmV1c2UgdGhlIG1lbW9yeSB3aGlsZSBpbiByZWFsaXR5IGl0IHdhcyBzdGlsbCBpbiB1c2UuCj4+
Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4gQW0gMTIuMDMuMjAgdW0gMTI6MzAgc2No
cmllYiBMaXUsIE1vbms6Cj4+PiBDYW4geW91IGdpdmUgbW9yZSBkZXRhaWxzIGFib3V0ICIgd2Ug
Y2FuJ3QgZ3VhcmFudGVlIHRoZSB0aGUgY2xlYXIgZmVuY2Ugd2lsbCBjb21wbGV0ZSBhZnRlciB0
aGUgZXhjbHVzaXZlIG9uZS4iID8KPj4+Cj4+PiBUaGFua3MKPj4+Cj4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBNb25rIExpdXxHUFUgVmlydHVhbGl6YXRpb24g
VGVhbSB8QU1ECj4+Pgo+Pj4KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+PiBGcm9t
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhh
bGYgT2YKPj4+IENocmlzdGlhbiBLP25pZwo+Pj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDEyLCAy
MDIwIDc6MTIgUE0KPj4+IFRvOiBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dTogZml4IGFuZCBjbGVhbnVwIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlCj4+Pgo+Pj4gVGhlIHBy
b2JsZW0gaXMgdGhhdCB3ZSBjYW4ndCBhZGQgdGhlIGNsZWFyIGZlbmNlIHRvIHRoZSBCTyB3aGVu
IHRoZXJlIGlzIGFuIGV4Y2x1c2l2ZSBmZW5jZSBvbiBpdCBzaW5jZSB3ZSBjYW4ndCBndWFyYW50
ZWUgdGhlIHRoZSBjbGVhciBmZW5jZSB3aWxsIGNvbXBsZXRlIGFmdGVyIHRoZSBleGNsdXNpdmUg
b25lLgo+Pj4KPj4+IFRvIGZpeCB0aGlzIHJlZmFjdG9yIHRoZSBmdW5jdGlvbiBhbmQgd2FpdCBm
b3IgYW55IHBvdGVudGlhbCBleGNsdXNpdmUgZmVuY2Ugd2l0aCBhIHNtYWxsIHRpbWVvdXQgYmVm
b3JlIGFkZGluZyB0aGUgc2hhcmVkIGNsZWFyIGZlbmNlLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4g
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDQxICsrKysrKysr
KysrKysrKy0tLS0tLS0tLS0KPj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KSwgMTYgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2VtLmMKPj4+IGluZGV4IDQyNzcxMjVhNzllZS4uMDc4MjE2MmZiNWYzIDEwMDY0NAo+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4+IEBAIC0xNjEsMTAg
KzE2MSwxMSBAQCB2b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdAo+Pj4gZHJtX2dl
bV9vYmplY3QgKm9iaiwKPj4+ICAgICAKPj4+ICAgICAJc3RydWN0IGFtZGdwdV9ib19saXN0X2Vu
dHJ5IHZtX3BkOwo+Pj4gICAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3QsIGR1cGxpY2F0ZXM7Cj4+
PiArCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gTlVMTDsKPj4+ICAgICAJc3RydWN0IHR0bV92
YWxpZGF0ZV9idWZmZXIgdHY7Cj4+PiAgICAgCXN0cnVjdCB3d19hY3F1aXJlX2N0eCB0aWNrZXQ7
Cj4+PiAgICAgCXN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3ZhOwo+Pj4gLQlpbnQgcjsKPj4+ICsJ
bG9uZyByOwo+Pj4gICAgIAo+Pj4gICAgIAlJTklUX0xJU1RfSEVBRCgmbGlzdCk7Cj4+PiAgICAg
CUlOSVRfTElTVF9IRUFEKCZkdXBsaWNhdGVzKTsKPj4+IEBAIC0xODIsMjQgKzE4MywzMiBAQCB2
b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLAo+
Pj4gICAgIAkJcmV0dXJuOwo+Pj4gICAgIAl9Cj4+PiAgICAgCWJvX3ZhID0gYW1kZ3B1X3ZtX2Jv
X2ZpbmQodm0sIGJvKTsKPj4+IC0JaWYgKGJvX3ZhICYmIC0tYm9fdmEtPnJlZl9jb3VudCA9PSAw
KSB7Cj4+PiAtCQlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsKPj4+ICsJaWYgKCFib192
YSB8fCAtLWJvX3ZhLT5yZWZfY291bnQpCj4+PiArCQlnb3RvIG91dF91bmxvY2s7Cj4+PiAgICAg
Cj4+PiAtCQlpZiAoYW1kZ3B1X3ZtX3JlYWR5KHZtKSkgewo+Pj4gLQkJCXN0cnVjdCBkbWFfZmVu
Y2UgKmZlbmNlID0gTlVMTDsKPj4+ICsJYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBib192YSk7Cj4+
PiArCWlmICghYW1kZ3B1X3ZtX3JlYWR5KHZtKSkKPj4+ICsJCWdvdG8gb3V0X3VubG9jazsKPj4+
ICAgICAKPj4+IC0JCQlyID0gYW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKGFkZXYsIHZtLCAmZmVuY2Up
Owo+Pj4gLQkJCWlmICh1bmxpa2VseShyKSkgewo+Pj4gLQkJCQlkZXZfZXJyKGFkZXYtPmRldiwg
ImZhaWxlZCB0byBjbGVhciBwYWdlICIKPj4+IC0JCQkJCSJ0YWJsZXMgb24gR0VNIG9iamVjdCBj
bG9zZSAoJWQpXG4iLCByKTsKPj4+IC0JCQl9Cj4+PiAgICAgCj4+PiAtCQkJaWYgKGZlbmNlKSB7
Cj4+PiAtCQkJCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOwo+Pj4gLQkJCQlkbWFf
ZmVuY2VfcHV0KGZlbmNlKTsKPj4+IC0JCQl9Cj4+PiAtCQl9Cj4+PiAtCX0KPj4+ICsJciA9IGFt
ZGdwdV92bV9jbGVhcl9mcmVlZChhZGV2LCB2bSwgJmZlbmNlKTsKPj4+ICsJaWYgKHIgfHwgIWZl
bmNlKQo+Pj4gKwkJZ290byBvdXRfdW5sb2NrOwo+Pj4gKwo+Pj4gKwlyID0gZG1hX3Jlc3Zfd2Fp
dF90aW1lb3V0X3JjdShiby0+dGJvLmJhc2UucmVzdiwgZmFsc2UsIGZhbHNlLAo+Pj4gKwkJCQkg
ICAgICBtc2Vjc190b19qaWZmaWVzKDEwKSk7Cj4+PiArCWlmIChyID09IDApCj4+PiArCQlyID0g
LUVUSU1FRE9VVDsKPj4+ICsJaWYgKHIpCj4+PiArCQlnb3RvIG91dF91bmxvY2s7Cj4+PiArCj4+
PiArCWFtZGdwdV9ib19mZW5jZShibywgZmVuY2UsIHRydWUpOwo+Pj4gKwlkbWFfZmVuY2VfcHV0
KGZlbmNlKTsKPj4+ICsKPj4+ICtvdXRfdW5sb2NrOgo+Pj4gKwlpZiAodW5saWtlbHkocikpCj4+
PiArCQlkZXZfZXJyKGFkZXYtPmRldiwgImZhaWxlZCB0byBjbGVhciBwYWdlICIKPj4+ICsJCQki
dGFibGVzIG9uIEdFTSBvYmplY3QgY2xvc2UgKCVkKVxuIiwgcik7Cj4+PiAgICAgCXR0bV9ldV9i
YWNrb2ZmX3Jlc2VydmF0aW9uKCZ0aWNrZXQsICZsaXN0KTsgIH0KPj4+ICAgICAKPj4+IC0tCj4+
PiAyLjE3LjEKPj4+Cj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXMKPj4+IHQKPj4+IHMuZnJlZWRlc2t0b3Aub3JnJTJG
bWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDTQo+Pj4gbwo+
Pj4gbmsuTGl1JTQwYW1kLmNvbSU3QzI2NzMwZTU2YzViOTQ0ZjhjYmI0MDhkN2M2ODNkNGExJTdD
M2RkODk2MWZlNDg4NGU2Cj4+PiAwCj4+PiA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzcx
OTYxNDE4MTU5Mjk5MTUmYW1wO3NkYXRhPXlQNVljMUJXWVdTOTMKPj4+IGYKPj4+IDBoSEVSVWZF
Q21TaHd5UTVmYk1raENlRzgybjZNJTNEJmFtcDtyZXNlcnZlZD0wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
