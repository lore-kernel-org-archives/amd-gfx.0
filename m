Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBBC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 10:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3AE20724
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 10:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0cFBUrIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3AE20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC4E6EBBE;
	Fri, 13 Mar 2020 10:45:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A4A46EBBE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 10:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTJ0TdW/ru/+usuyBvIMiTtOxFc77PzmMzSY6O8+QMo6BP8OZuOzCem0g0XqOMWKC8UuDe7aK3J5UdvKPNRSR0ka+wG2Q0rUlom1YaBk2S0qgEtflHemoGkh0/5cCfZmf3dE3OeTIgIqm9c3GFZasIxgzK6k2kwHLKUH+HWvOqtZD7enCqjd0FERjCBP1UQeFEZLzBsN76j9EL+HIGvcYUr6Q0cmbK532wQP0weEQXgcy5mHQRHu6ZFo+xE3uvwDr1CR7Sc0F9sL40xNLB6pC306QPkm9WRfiIbfV2We8Hxlql9UREmPhjf83v5IB1iWVce5bBd4nxLAL38Pa5hrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRe7h0Od5U1ypFemnVrfD7S9r60CSe/qZgYJrjrVTWI=;
 b=heJ2kapJ135GJPkYInukg9yE2a6kQ9LGRVWSZxE4l33coCZiV78c2ERYPOpnlEqyMvhhkwjZq2RVLhrKGhYZJF6bJ37J4Sm8WLIgnk0QC74WqMyh0Ukvd96XSJUijoedJBxD0nKOrJG58fpcKzYr5hxehSnxOrFheKoFDDVD+UWSOnOZG7vp/GanbwJUtV6THwcOiFs8uvddN5oSif8l5FrNpHANNuzg3hy7IY46Pjq++8pe/s53J74ioy8spKDIA0pVEIC/n5qwaUhsYkb7sIJzSSBWxCo3HsHs6uUnR48Ya3g1J/q7gmg3dUQOQKTr++4WmAknVI9INfO42IuMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRe7h0Od5U1ypFemnVrfD7S9r60CSe/qZgYJrjrVTWI=;
 b=0cFBUrIC/aA8Mmq5ThaqsU2WcCh8ROCA0JCg0u5ddfHdAmnE89Uu+mILOldqgePKip+fYZ0wlFctOF38TklBlgOiHFZxMStCzzC6JdjL0PQyBaMU6sww3NNSFFHrXm7iKGyaS6dHD6dbjZjCSizQolnelGGg77MFYkjzzTaU2J4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 10:45:02 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:45:02 +0000
Subject: Re: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock
 eviction_lock
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20200313074336.19545-1-xinhui.pan@amd.com>
 <20200313074336.19545-2-xinhui.pan@amd.com>
 <91022e2e-67fb-ef65-09d6-2814b10493d8@amd.com>
 <0D32D879-69FB-4D0F-8742-1BB9BF0AB766@amd.com>
 <227b3535-83c2-87af-56c0-be3ed28a0413@amd.com>
 <4524679A-5CA8-4A7E-A9BD-F0E343931A25@amd.com>
 <ef06f480-c5d7-987f-4e84-24636f1d5770@amd.com>
 <FC898EB4-8E9D-460B-8D0A-D138582E315E@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <10cffc79-922a-8141-1168-6c4dddc2db82@amd.com>
Date: Fri, 13 Mar 2020 11:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <FC898EB4-8E9D-460B-8D0A-D138582E315E@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::25) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Fri, 13 Mar 2020 10:45:00 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb5819de-6d86-4783-576f-08d7c73b9512
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:|DM5PR12MB2504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2504A9F283D1B410AD3716D283FA0@DM5PR12MB2504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(37006003)(4326008)(81166006)(478600001)(81156014)(31686004)(36756003)(316002)(66946007)(6666004)(8676002)(66556008)(86362001)(66476007)(2616005)(6636002)(54906003)(2906002)(52116002)(186003)(16526019)(66574012)(6862004)(31696002)(8936002)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2504;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAzzEf1q3p7OWnScuOBvDs5j/v5EAGXCXOxsxFyc21NukFaQDCKSm98aQ//NoopTPaiMWs0SEOhFniDyAzM+MSOsyiJvSCU7XJmrjKx2o8/64DEzHbzCitjmXlEoxSjpt+rC+Syzh7GiMGOzk/UUZQDwp0GoHX8ROT1wLEF9ZQ/Kn+aOVIKUTHo4qOwawG8Q1aZ4HMbhe6q5DoFFRt7tOFENkQpQCKgNACNcQsAhs9K+7ACEXrL86N3OkBmXLXvU9jIhypWNSTs4kgfZ5Vk0DGCH3gWSAlWPMRAiHTsU0vgbt63DWLWMeCFGDMg9S22NFVXkEp/NxoMJmoqyUCLSJWse63ej0fzS/JNXCWcCPdp46IyPv9AhQIoaTTQ+I51mgxE7+hR7YPgCY+N3wHaE+yaJmOsZ+TLdNA5pSnBLVW2ovA8bqVHIajPRoXuh2BPh
X-MS-Exchange-AntiSpam-MessageData: 99hKetig0EYnech428jC/2Ve5hphrfUOmF3ZlU36LE1QYfyy/Dko1YKo24ioAj85czvrssU7BZXsQjswKruNN4m+G6vTxQVvAYR6KNPBArma3axAwfJaEOwtvQlaHOWMwFyB1f53VS300agt5IzI83cLyh6v44Skjuz91h6xhckEsErb8UK8wPPFL6YkoHkQXdYxG6Sdpm/knwiyQQvq0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5819de-6d86-4783-576f-08d7c73b9512
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:45:01.7877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceau5WBedsU6+3YlNZrZ1Vy28bi67s11gwS59kQPY5NYCMidlia/axIWIWqgmfa7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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

QW0gMTMuMDMuMjAgdW0gMTE6NDAgc2NocmllYiBQYW4sIFhpbmh1aToKPgo+PiAyMDIw5bm0M+ac
iDEz5pelIDE4OjIz77yMS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4g5YaZ6YGT77yaCj4+Cj4+IEFtIDEzLjAzLjIwIHVtIDExOjIxIHNjaHJpZWIgUGFuLCBYaW5o
dWk6Cj4+Pj4gMjAyMOW5tDPmnIgxM+aXpSAxNzo1Ne+8jEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+IOWGmemBk++8mgo+Pj4+Cj4+Pj4gQW0gMTMuMDMuMjAgdW0g
MTA6Mjkgc2NocmllYiBQYW4sIFhpbmh1aToKPj4+Pj4+IDIwMjDlubQz5pyIMTPml6UgMTY6NTLv
vIxLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiDlhpnpgZPvvJoK
Pj4+Pj4+Cj4+Pj4+PiBBbSAxMy4wMy4yMCB1bSAwODo0MyBzY2hyaWViIHhpbmh1aSBwYW46Cj4+
Pj4+Pj4gVGhlIGZlbmNlIGdlbmVyYXRlZCBpbiAtPmNvbW1pdCBpcyBhIHNoYXJlZCBvbmUsIHNv
IGFkZCBpdCB0byByZXN2Lgo+Pj4+Pj4+IEFuZCB3ZSBuZWVkIGRvIHRoYXQgd2l0aCBldmljdGlv
biBsb2NrIGhvbGQuCj4+Pj4+Pj4KPj4+Pj4+PiBDdXJyZW50bHkgd2Ugb25seSBzeW5jIGxhc3Rf
ZGlyZWN0L2xhc3RfZGVsYXllZCBiZWZvcmUgLT5wcmVwYXJlLiBCdXQgd2UKPj4+Pj4+PiBmYWls
IHRvIHN5bmMgdGhlIGxhc3QgZmVuY2UgZ2VuZXJhdGVkIGJ5IC0+Y29tbWl0LiBUaGF0IGN1YXNl
cyBwcm9ibGVtcwo+Pj4+Pj4+IGlmIGV2aWN0aW9uIGhhcHBlbmVzIGxhdGVyLCBidXQgaXQgZG9l
cyBub3Qgc3luYyB0aGUgbGFzdCBmZW5jZS4KPj4+Pj4+IE5BSywgdGhhdCB3b24ndCB3b3JrLgo+
Pj4+Pj4KPj4+Pj4+IFdlIGNhbiBvbmx5IGFkZCBmZW5jZXMgd2hlbiB0aGUgZG1hX3Jlc3Ygb2Jq
ZWN0IGlzIGxvY2tlZCBhbmQgdGhhdCBpcyBvbmx5IHRoZSBjYXNlIHdoZW4gdmFsaWRhdGluZy4K
Pj4+Pj4+Cj4+Pj4+IHdlbGwsIHRoYSB0aXMgdHJ1ZS4KPj4+Pj4gYnV0IGNvbnNpZGVyaW5nIHRo
aXMgaXMgYSBQVCBCTywgYW5kIG9ubHkgZXZpY3Rpb24gaGFzIHJhY2Ugb24gaXQgQUZBSUsuCj4+
Pj4+IGFzIGZvciB0aGUgaW5kaXZpZHVhbGl6ZWQgcmVzdiBpbiBibyByZWxlYXNlLCB3ZSB1bnJl
ZiBQVCBCTyBqdXN0IGFmdGVyIHRoYXQuCj4+Pj4+IEkgYW0gc3RpbGwgdGhpbmtpbmcgb2Ygb3Ro
ZXIgcmFjZXMgaW4gdGhlIHJlYWwgd29ybGQuCj4+Pj4gV2Ugc2hvdWxkIHByb2JhYmx5IGp1c3Qg
YWRkIGFsbCBwaXBlbGluZWQvZGVsYXllZCBzdWJtaXNzaW9ucyBkaXJlY3RseSB0byB0aGUgcmVz
ZXJ2YXRpb24gb2JqZWN0IGluIGFtZGdwdV92bV9zZG1hX2NvbW1pdCgpLgo+Pj4+Cj4+Pj4gT25s
eSB0aGUgZGlyZWN0IGFuZCBpbnZhbGlkYXRpbmcgc3VibWlzc2lvbnMgY2FuJ3QgYmUgYWRkZWQg
YmVjYXVzZSB3ZSBjYW4ndCBncmFiIHRoZSByZXNlcnZhdGlvbiBvYmplY3QgaW4gdGhlIE1NVSBu
b3RpZmllci4KPiB3YWl0LCBJIHNlZSBhbWRncHVfdm1faGFuZGxlX2ZhdWx0IHdpbGwgZ3JhYiB0
aGUgcmVzdiBsb2NrIG9mIHJvb3QgQk8uCj4gc28gbm8gcmFjZSB0aGVuPwoKTm8sIG5vdCBpbiB0
aGlzIGNhc2UuCgpCdXQgUGhpbGlwLCBBbGVqYW5kcm8gYW5kIEZlbGl4IGFyZSB3b3JraW5nIG9u
IGludmFsaWRhdGlvbiBmcm9tIGFuIE1NVSAKY2FsbGJhY2suIEFuZCBpbiB0aGlzIGNhc2UgZ3Jh
YmJpbmcgdGhlIGxvY2sgZG9lc24ndCB3b3JrLgoKQnV0IHRoaXMgaXMgYSB0b3RhbCBzcGVjaWFs
IHVzZSBjYXNlIHdoaWNoIGNhbiBiZSBoYW5kbGVkIGRpZmZlcmVudGx5LgoKQ2hyaXN0aWFuLgoK
Pgo+Pj4+IENhbiB5b3UgcHJlcGFyZSBhIHBhdGNoIGZvciB0aGlzPwo+Pj4+Cj4+PiB5ZXAsIEkg
Y2FuLgo+Pj4gQWRkaW5nIGZlbmNlIHRvIGJvIHJlc3YgaW4gZXZlcnkgY29tbWl0IGludHJvZHVj
ZSBhIGxpdHRsZSBvdmVybG9hZD8KPj4gWWVzIGl0IGRvZXMsIGJ1dCB3ZSB1c2VkIHRvIGhhdmUg
dGhpcyBiZWZvcmUgYW5kIGl0IHdhc24ndCByZWFsbHkgbWVhc3VyYWJsZS4KPj4KPj4gV2l0aCB0
aGUgdW51c3VhbCBleGNlcHRpb24gb2YgbWFwcGluZyByZWFsbHkgbGFyZ2UgY2h1bmtzIG9mIGZy
YWdtZW50ZWQgc3lzdGVtIG1lbW9yeSB3ZSBvbmx5IHVzZSBvbmUgY29tbWl0IGZvciBhbnl0aGlu
ZyA8MUdCIGFueXdheS4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gQXMgd2Ugb25seSBuZWVkIGFk
ZCB0aGUgbGFzdCBmZW5jZSB0byByZXN2IGdpdmVuIHRoZSBmYWN0IHRoZSBqb2Igc2NoZWR1ZXIg
cmluZyBpcyBGSUZPLgo+Pj4geWVzLCAgY29kZSBzaG91bGQgYmUgc2ltcGxlIGFueXdheSBhcyBs
b25nIGFzIGl0IHdvcmtzLgo+Pj4KPj4+IHRoYW5rcwo+Pj4geGluaHVpCj4+Pgo+Pj4+IFJlZ2Fy
ZHMsCj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Cj4+Pj4+IHRoYW5rcwo+Pj4+PiB4aW5odWkKPj4+Pj4K
Pj4+Pj4+IEknbSBjb25zaWRlcmluZyB0byBqdXN0IHBhcnRpYWxseSByZXZlcnQgdGhlIHBhdGNo
IG9yaWdpbmFsbHkgc3RvcHBpbmcgdG8gYWRkIGZlbmNlcyBhbmQgaW5zdGVhZCBvbmx5IG5vdCBh
ZGQgdGhlbSB3aGVuIGludmFsaWRhdGluZyBpbiBhIGRpcmVjdCBzdWJtaXQuCj4+Pj4+Pgo+Pj4+
Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4KPj4+Pj4+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+Pj4+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+Cj4+Pj4+Pj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5A
YW1kLmNvbT4KPj4+Pj4+PiAtLS0KPj4+Pj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIHwgOSArKysrKysrLS0KPj4+Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pj4+Pj4KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4+Pj4+IGluZGV4IDczMzk4ODMxMTk2Zi4uZjQyNGI1
OTY5OTMwIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKPj4+Pj4+PiBAQCAtMTU4Miw2ICsxNTgyLDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1f
Ym9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+Pj4+Pj4gICAJ
c3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zIHBhcmFtczsKPj4+Pj4+PiAgIAllbnVtIGFt
ZGdwdV9zeW5jX21vZGUgc3luY19tb2RlOwo+Pj4+Pj4+ICAgCWludCByOwo+Pj4+Pj4+ICsJc3Ry
dWN0IGFtZGdwdV9ibyAqcm9vdCA9IHZtLT5yb290LmJhc2UuYm87Cj4+Pj4+Pj4gICAgIAltZW1z
ZXQoJnBhcmFtcywgMCwgc2l6ZW9mKHBhcmFtcykpOwo+Pj4+Pj4+ICAgCXBhcmFtcy5hZGV2ID0g
YWRldjsKPj4+Pj4+PiBAQCAtMTYwNCw4ICsxNjA1LDYgQEAgc3RhdGljIGludCBhbWRncHVfdm1f
Ym9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+Pj4+Pj4gICAJ
fQo+Pj4+Pj4+ICAgICAJaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkgewo+Pj4+Pj4+IC0J
CXN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+cm9vdC5iYXNlLmJvOwo+Pj4+Pj4+IC0KPj4+
Pj4+PiAgIAkJaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0KSkKPj4+
Pj4+PiAgIAkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kaXJlY3QsIHRydWUpOwo+
Pj4+Pj4+ICAgQEAgLTE2MjMsNiArMTYyMiwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191
cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+Pj4+PiAgICAgCXIg
PSB2bS0+dXBkYXRlX2Z1bmNzLT5jb21taXQoJnBhcmFtcywgZmVuY2UpOwo+Pj4+Pj4+ICAgKwlp
ZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+bGFzdF9kaXJlY3QpKQo+Pj4+Pj4+ICsJCWFt
ZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kaXJlY3QsIHRydWUpOwo+Pj4+Pj4+ICsKPj4+
Pj4+PiArCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RlbGF5ZWQpKQo+Pj4+
Pj4+ICsJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kZWxheWVkLCB0cnVlKTsKPj4+
Pj4+PiArCj4+Pj4+Pj4gICBlcnJvcl91bmxvY2s6Cj4+Pj4+Pj4gICAJYW1kZ3B1X3ZtX2V2aWN0
aW9uX3VubG9jayh2bSk7Cj4+Pj4+Pj4gICAJcmV0dXJuIHI7CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
