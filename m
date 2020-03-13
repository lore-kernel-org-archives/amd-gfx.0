Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE3C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 10:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CCF2073E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 10:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DTrkqFqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CCF2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485A06EBAD;
	Fri, 13 Mar 2020 10:24:01 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938D76EBAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 10:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFaxHYpkHpSr3VoisVkiCDHRnMvcCrkd1G1Biq2uhEQdGarWfj69izYyDIxv7Sto0fTgRRpW34EcPRogaonJZth5rsgYWUrEzmmIX6jGxjVSoXJhWVu26LSqMEjrCONh9uK4sThxUrKNF/9mAr7eqR2XBBC1GiFvzMryjjGee+HZQg52AcGKXPVT0sUt6gNqTYpR449s6AJ6MKQ60XAf2jlQRJ0KxkUJ2v3TFC1kGPtv6sfpflieT10IYX0o9uJqUEFh8RDHcrMkawM6tPYqHCLLyxqIAQNwSADOwHB4tDG/u1C784ZPVx6IQrd5s1f3ZMd5Kad4BzBDBl8JkL/6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLgQbAMopRmol3Q2/cnqjZrjLU/rqjoNS76Y2VD6mUo=;
 b=iUj6JoQS8Y7ZFdd+EvVmxiypDxalzkoCcNV7kgpvaoB9QUjUlkmaRNqxZ6qnriV/XaAvreTOBwZazn3fHHS79HTH1nzFPeDGG2S7hK54JHB8++wpZt8c7fJm46mod31P5t/9U5tl7xjqqFDJ5jQxhJsV4cmlmbxDpllPuyAVOXDtw8Zi0diCBA81g0JTjYEK7TRa1wNC2tAHiy8yeH61VU1XUcIXGr7id/80g/QSLerZnBQf8HpQ7g9q6+g5QtfXpnL8Lq3cOCIgWU0JapGX2CFpFzHgZc7lZ+AQLQKPBTPpDmSMeXAhlrNoQCDAV+spyu2/GNo7hYxzWolCXl8kyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLgQbAMopRmol3Q2/cnqjZrjLU/rqjoNS76Y2VD6mUo=;
 b=DTrkqFqvgqG4RdG68fWiXLOeANL+p1C4qG6VA+jWiALP7UXXDKZu0LQ1jFfO4fjZoKI2IeURFWNkefev3vZwSI2i14mI5tEnU/CNKkH6oj7rlsEsYCwMoxdfs5h2G5P+LaNSFCUmy69Ysqpbvrn0mDwHaGEa4RgdX5mw4m7UM/c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 10:23:58 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:23:58 +0000
Subject: Re: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock
 eviction_lock
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200313074336.19545-1-xinhui.pan@amd.com>
 <20200313074336.19545-2-xinhui.pan@amd.com>
 <91022e2e-67fb-ef65-09d6-2814b10493d8@amd.com>
 <0D32D879-69FB-4D0F-8742-1BB9BF0AB766@amd.com>
 <227b3535-83c2-87af-56c0-be3ed28a0413@amd.com>
 <4524679A-5CA8-4A7E-A9BD-F0E343931A25@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ef06f480-c5d7-987f-4e84-24636f1d5770@amd.com>
Date: Fri, 13 Mar 2020 11:23:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <4524679A-5CA8-4A7E-A9BD-F0E343931A25@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR08CA0067.eurprd08.prod.outlook.com
 (2603:10a6:205:2::38) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR08CA0067.eurprd08.prod.outlook.com (2603:10a6:205:2::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Fri, 13 Mar 2020 10:23:56 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93e374b1-6040-4376-05f0-08d7c738a42c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1226:|DM5PR12MB1226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12261741A18798F56A08144583FA0@DM5PR12MB1226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(37006003)(2906002)(478600001)(81166006)(81156014)(6862004)(316002)(8936002)(52116002)(5660300002)(54906003)(6666004)(8676002)(31696002)(66574012)(86362001)(36756003)(6486002)(66946007)(4326008)(31686004)(16526019)(186003)(66476007)(66556008)(6636002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1226;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7guXJ+RTyP+siEAFBVOxjPA3fyyHpospFZ6vST1mVlAf0ZZC0QjAKAGmRBnTijpXDKwF9Tr5HOh3YyL4VvbbQa8q4u4tscwHJo3cBa50tmmh4DxJqetf0cIulDBpmj2ucL9JOCBRvKheIfRdqhUvMU7DTAIvmUrwbJET99ApkIMkjSBjXEG9DXIuAvmwlmET8NnbzXxV05i1bGohfPcASsm6EVHaD/LfFaMsGp8HhOfZXKEg2/Jjy7/bKHGNYTdftIQxNUTycuq3knn7fo8KsGPsO+4PaZ3Mx9G/IDsg3xlX/DsG2idTjiFlxi83rVwAUu+HO//hvI7kyXIZls1XZEPoyqxQytjVxYQ/1L8vZCFQoV9BOLASiBi+N2z0I5qFiaVPBTrcnEnoi9F8RqGLBVyaknCgSkN/Bptm9iQoddINmTZSF1RBgehv7/pOWKob
X-MS-Exchange-AntiSpam-MessageData: KYKd7IkZB0tJdkQScwscO2VTmmz6FRValkR6VeDFUtyas5mb1HcSZhCCfbFdYopKgqXMBZT4jzoy2rgZcTz2K6Kri0RO/LGICnK9hhGIhk7zjc1rOAx44BXaP/0KoMiH4eplcESjOiHGHKm/K0VBmNOFHLQ0z9l5/+2U4+CFxVfqxcGXN15d+0PUfg8L3jf7THKg0k2jV7i0rg+Qtt6Qkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e374b1-6040-4376-05f0-08d7c738a42c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:23:58.5887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TA9fuLMlpkAk6ybEadYu6moK6qZTGTtdd7fyxcVzHvkQmxqYY49sgnFzQdKn+x+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1226
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDMuMjAgdW0gMTE6MjEgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0M+ac
iDEz5pelIDE3OjU177yMS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4g5YaZ6YGT77yaCj4+Cj4+IEFtIDEzLjAzLjIwIHVtIDEwOjI5IHNjaHJpZWIgUGFuLCBYaW5o
dWk6Cj4+Pj4gMjAyMOW5tDPmnIgxM+aXpSAxNjo1Mu+8jEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+IOWGmemBk++8mgo+Pj4+Cj4+Pj4gQW0gMTMuMDMuMjAgdW0g
MDg6NDMgc2NocmllYiB4aW5odWkgcGFuOgo+Pj4+PiBUaGUgZmVuY2UgZ2VuZXJhdGVkIGluIC0+
Y29tbWl0IGlzIGEgc2hhcmVkIG9uZSwgc28gYWRkIGl0IHRvIHJlc3YuCj4+Pj4+IEFuZCB3ZSBu
ZWVkIGRvIHRoYXQgd2l0aCBldmljdGlvbiBsb2NrIGhvbGQuCj4+Pj4+Cj4+Pj4+IEN1cnJlbnRs
eSB3ZSBvbmx5IHN5bmMgbGFzdF9kaXJlY3QvbGFzdF9kZWxheWVkIGJlZm9yZSAtPnByZXBhcmUu
IEJ1dCB3ZQo+Pj4+PiBmYWlsIHRvIHN5bmMgdGhlIGxhc3QgZmVuY2UgZ2VuZXJhdGVkIGJ5IC0+
Y29tbWl0LiBUaGF0IGN1YXNlcyBwcm9ibGVtcwo+Pj4+PiBpZiBldmljdGlvbiBoYXBwZW5lcyBs
YXRlciwgYnV0IGl0IGRvZXMgbm90IHN5bmMgdGhlIGxhc3QgZmVuY2UuCj4+Pj4gTkFLLCB0aGF0
IHdvbid0IHdvcmsuCj4+Pj4KPj4+PiBXZSBjYW4gb25seSBhZGQgZmVuY2VzIHdoZW4gdGhlIGRt
YV9yZXN2IG9iamVjdCBpcyBsb2NrZWQgYW5kIHRoYXQgaXMgb25seSB0aGUgY2FzZSB3aGVuIHZh
bGlkYXRpbmcuCj4+Pj4KPj4+IHdlbGwsIHRoYSB0aXMgdHJ1ZS4KPj4+IGJ1dCBjb25zaWRlcmlu
ZyB0aGlzIGlzIGEgUFQgQk8sIGFuZCBvbmx5IGV2aWN0aW9uIGhhcyByYWNlIG9uIGl0IEFGQUlL
Lgo+Pj4gYXMgZm9yIHRoZSBpbmRpdmlkdWFsaXplZCByZXN2IGluIGJvIHJlbGVhc2UsIHdlIHVu
cmVmIFBUIEJPIGp1c3QgYWZ0ZXIgdGhhdC4KPj4+IEkgYW0gc3RpbGwgdGhpbmtpbmcgb2Ygb3Ro
ZXIgcmFjZXMgaW4gdGhlIHJlYWwgd29ybGQuCj4+IFdlIHNob3VsZCBwcm9iYWJseSBqdXN0IGFk
ZCBhbGwgcGlwZWxpbmVkL2RlbGF5ZWQgc3VibWlzc2lvbnMgZGlyZWN0bHkgdG8gdGhlIHJlc2Vy
dmF0aW9uIG9iamVjdCBpbiBhbWRncHVfdm1fc2RtYV9jb21taXQoKS4KPj4KPj4gT25seSB0aGUg
ZGlyZWN0IGFuZCBpbnZhbGlkYXRpbmcgc3VibWlzc2lvbnMgY2FuJ3QgYmUgYWRkZWQgYmVjYXVz
ZSB3ZSBjYW4ndCBncmFiIHRoZSByZXNlcnZhdGlvbiBvYmplY3QgaW4gdGhlIE1NVSBub3RpZmll
ci4KPj4KPj4gQ2FuIHlvdSBwcmVwYXJlIGEgcGF0Y2ggZm9yIHRoaXM/Cj4+Cj4geWVwLCBJIGNh
bi4KPiBBZGRpbmcgZmVuY2UgdG8gYm8gcmVzdiBpbiBldmVyeSBjb21taXQgaW50cm9kdWNlIGEg
bGl0dGxlIG92ZXJsb2FkPwoKWWVzIGl0IGRvZXMsIGJ1dCB3ZSB1c2VkIHRvIGhhdmUgdGhpcyBi
ZWZvcmUgYW5kIGl0IHdhc24ndCByZWFsbHkgCm1lYXN1cmFibGUuCgpXaXRoIHRoZSB1bnVzdWFs
IGV4Y2VwdGlvbiBvZiBtYXBwaW5nIHJlYWxseSBsYXJnZSBjaHVua3Mgb2YgZnJhZ21lbnRlZCAK
c3lzdGVtIG1lbW9yeSB3ZSBvbmx5IHVzZSBvbmUgY29tbWl0IGZvciBhbnl0aGluZyA8MUdCIGFu
eXdheS4KCkNocmlzdGlhbi4KCj4gQXMgd2Ugb25seSBuZWVkIGFkZCB0aGUgbGFzdCBmZW5jZSB0
byByZXN2IGdpdmVuIHRoZSBmYWN0IHRoZSBqb2Igc2NoZWR1ZXIgcmluZyBpcyBGSUZPLgo+IHll
cywgIGNvZGUgc2hvdWxkIGJlIHNpbXBsZSBhbnl3YXkgYXMgbG9uZyBhcyBpdCB3b3Jrcy4KPgo+
IHRoYW5rcwo+IHhpbmh1aQo+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+IHRoYW5r
cwo+Pj4geGluaHVpCj4+Pgo+Pj4+IEknbSBjb25zaWRlcmluZyB0byBqdXN0IHBhcnRpYWxseSBy
ZXZlcnQgdGhlIHBhdGNoIG9yaWdpbmFsbHkgc3RvcHBpbmcgdG8gYWRkIGZlbmNlcyBhbmQgaW5z
dGVhZCBvbmx5IG5vdCBhZGQgdGhlbSB3aGVuIGludmFsaWRhdGluZyBpbiBhIGRpcmVjdCBzdWJt
aXQuCj4+Pj4KPj4+PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+Pj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4+Pj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFu
QGFtZC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIHwgOSArKysrKysrLS0KPj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwo+Pj4+PiBpbmRleCA3MzM5ODgzMTE5NmYuLmY0MjRiNTk2OTkzMCAxMDA2
NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+Pj4gQEAg
LTE1ODIsNiArMTU4Miw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5n
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4+PiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX3Vw
ZGF0ZV9wYXJhbXMgcGFyYW1zOwo+Pj4+PiAgIAllbnVtIGFtZGdwdV9zeW5jX21vZGUgc3luY19t
b2RlOwo+Pj4+PiAgIAlpbnQgcjsKPj4+Pj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0t
PnJvb3QuYmFzZS5ibzsKPj4+Pj4gICAgIAltZW1zZXQoJnBhcmFtcywgMCwgc2l6ZW9mKHBhcmFt
cykpOwo+Pj4+PiAgIAlwYXJhbXMuYWRldiA9IGFkZXY7Cj4+Pj4+IEBAIC0xNjA0LDggKzE2MDUs
NiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKPj4+Pj4gICAJfQo+Pj4+PiAgICAgCWlmIChmbGFncyAmIEFNREdQVV9Q
VEVfVkFMSUQpIHsKPj4+Pj4gLQkJc3RydWN0IGFtZGdwdV9ibyAqcm9vdCA9IHZtLT5yb290LmJh
c2UuYm87Cj4+Pj4+IC0KPj4+Pj4gICAJCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5s
YXN0X2RpcmVjdCkpCj4+Pj4+ICAgCQkJYW1kZ3B1X2JvX2ZlbmNlKHJvb3QsIHZtLT5sYXN0X2Rp
cmVjdCwgdHJ1ZSk7Cj4+Pj4+ICAgQEAgLTE2MjMsNiArMTYyMiwxMiBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+
Pj4gICAgIAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKPj4+
Pj4gICArCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RpcmVjdCkpCj4+Pj4+
ICsJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kaXJlY3QsIHRydWUpOwo+Pj4+PiAr
Cj4+Pj4+ICsJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVsYXllZCkpCj4+
Pj4+ICsJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kZWxheWVkLCB0cnVlKTsKPj4+
Pj4gKwo+Pj4+PiAgIGVycm9yX3VubG9jazoKPj4+Pj4gICAJYW1kZ3B1X3ZtX2V2aWN0aW9uX3Vu
bG9jayh2bSk7Cj4+Pj4+ICAgCXJldHVybiByOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
