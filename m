Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69084C2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 14:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38842206C1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 14:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w7LYBzQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38842206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F203E6ECC3;
	Fri, 10 Apr 2020 14:31:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EC76ECC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 14:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBjv8cbcYEIRUHT+Yoa432fmj4rTfUghyHHLoWrVugCyYfdLpTbjDoNdpDDskJp6gK40CLFSz0BjvqBSxQCgq4pWJhowAjqzoA56HVOIx7Jx3m9fUV4+Ndihbwk1QU/3ZK/Pcr67Iz0Q7H1tA0vMIyYlGYIOWAtIrxECEg3TF/V7o6xYbGLRjQRUMfdAZro2f8nGpyeo8D9LSCpW79xeH/Y6JW3WVd9Sq82r6LRF4ATOXy4csEACdMEONPMaQDwHLsowXdNprFoL6ZDiawLvga0ZJNQXcCj53ShFL17W/C2IQYrzQ6rsXN/5QvEJ8N5+2Qs01Br+hlZtzWFfNJbPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbaUiDGnutiCJGffQGAF21AN+a8LhZFvuNR22aHRACY=;
 b=jYOds0aS+OT+FFc2SyLwJV7ad5rK+gu9/quycEWJyOcynoFyYgtGMCAjpfjxrO+VRyZyYLPJ5Zbd7Ez3MiTG9hYFiJWSomlGoNn1rJ7tHlRy0R/sLp/oiEGsTL8LGfmE8z1Uvobq1Xar3lDel2+LoTAGpqoTwUnXEg38Vb3/FnaFbS1FB32o0+r96M/r2yWkYB8L8mv45NuNL8aHyJlvIQDonBKvkFz5mw2GNxWEnp7rxEjVSuQKB9rSzAcPp/1FUqpKZkZPyCvvAX/ZVRINZndwQOgL23E/xLi3SokSZlNWrV7Egg6FxLqjui4VZhjsIQ2BzeGIgrby2gNIFFns7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbaUiDGnutiCJGffQGAF21AN+a8LhZFvuNR22aHRACY=;
 b=w7LYBzQqxifZXx5/OtctN32YtrpFPriWPuWnpFwraTYUXeEhwVRVxAm563CqioehrWpJi0OM9NY/3DjrhPCiNYxdl/bqeiDtAjarZ+IG5W7In8Bokc7K4K7/GhyRY6fQ28rkLc3NWC6fimEy2RJxHtU6wYE8j7R1s8R/ypoxah0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 14:31:47 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2878.025; Fri, 10 Apr 2020
 14:31:47 +0000
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To: Peter Zijlstra <peterz@infradead.org>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200409155956.GQ20760@hirez.programming.kicks-ass.net>
 <20200409170916.GR20760@hirez.programming.kicks-ass.net>
 <87a2f2fc-972d-ab9b-a29d-72f02d94e60e@amd.com>
 <20200409200125.GB2483@worktop.programming.kicks-ass.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <56fd0509-ebef-f7b5-3ca1-fc51ca493a4c@amd.com>
Date: Fri, 10 Apr 2020 16:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200409200125.GB2483@worktop.programming.kicks-ass.net>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17 via Frontend Transport; Fri, 10 Apr 2020 14:31:44 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0967d14d-5972-4b71-022a-08d7dd5be644
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:|DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39631A0757CE0B1C2004A28183DE0@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(81156014)(8676002)(6916009)(54906003)(8936002)(478600001)(6666004)(31686004)(86362001)(31696002)(6486002)(7416002)(36756003)(5660300002)(2616005)(2906002)(66574012)(52116002)(186003)(316002)(4326008)(66476007)(66946007)(16526019)(66556008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHGKcgySaieGmExdfNAguIG2OByd83Q78VyOei2FnUasDV3Gs3zreBmDq3dfuJM0upSaANniHDKphsXZLOzdkGuIb48OJYLkR3l6iCRHVtZiNzTbohNNdveBkh2u7EmYh3Noc0Uy4XPKN6weUCPLePX4NS+Z3xKTqegvZQ6ZJQyIgWJKlKy4hb6kOoK4HtEdd/Ri5dev7AR1DrmEfMOVyJq/Wke5puqLoAJhfuSqGiec1eRL5fb49OICtKxboiNzr1QaTvQ30JYI7x0eICTRXlk0kpBk0niHLpZUBqDrE8IxoyQSFD5Zfga2Zj3HiVQT8gEfP25QaKUqQWXmum9KH1cP3+uXwZ/k/xw+9ci5ZW6GSE/UpdCMDh9rjSX/6EWp1DsQvQTIvW6DfZ4ltGE9F1O/DMAwTm5e6YUPXjsb3CZ/MVOrVNHJErjZB3mLDmuM
X-MS-Exchange-AntiSpam-MessageData: /O1V2FwJGIxwSGpTVDCMyUUEdiLdEU76R9Z9Y7OVVwI7/cCHqbGKhi8T/DVCLt+3Vby5DJ8Y4KcXrcgc/HNRsGtXN9a8EXLYeSe9mg0yU80s0rU/fy37U1VAqgAeqfaoqaBa6TcslkSP+gBRd3qm7hAk7jH5TtK6WWkWZbhKYhKRRb4uF3CJ87sInJYng5iAH7a9gT2DOIYdM5fF7crMvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0967d14d-5972-4b71-022a-08d7dd5be644
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 14:31:47.5544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWn0rKbn0ifYP13u6XcykXlSypdW9Ffz3h2cG0Yq7cj/xLrbek3hqh4WsMHw3alr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
 Leo Li <sunpeng.li@amd.com>, the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Harry Wentland <harry.wentland@amd.com>,
 mhiramat@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDQuMjAgdW0gMjI6MDEgc2NocmllYiBQZXRlciBaaWpsc3RyYToKPiBPbiBUaHUsIEFw
ciAwOSwgMjAyMCBhdCAwODoxNTo1N1BNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+
PiBBbSAwOS4wNC4yMCB1bSAxOTowOSBzY2hyaWViIFBldGVyIFppamxzdHJhOgo+Pj4gT24gVGh1
LCBBcHIgMDksIDIwMjAgYXQgMDU6NTk6NTZQTSArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6
Cj4+PiBbU05JUF0KPj4+PiBJJ2xsIG5lZWQgYW5vdGhlciBhcHByb2FjaCwgbGV0IG1lIGNvbnNp
ZGVyLgo+Pj4gQ2hyaXN0aWFuOyBpdCBzYXlzIHRoZXNlIGZpbGVzIGFyZSBnZW5lcmF0ZWQsIGRv
ZXMgdGhhdCBnZW5lcmF0b3Iga25vdwo+Pj4gd2hpY2ggZnVuY3Rpb25zIGFyZSB3aG9sbHkgaW4g
RlBVIGNvbnRleHQgYW5kIHdoaWNoIGFyZSBub3Q/Cj4+IFdlbGwgdGhhdCAiZ2VuZXJhdG9yIiBp
cyBzdGlsbCBhIGh1bWFuIGJlaW5nIDopCj4+Cj4+IEl0J3MganVzdCB0aGF0IHRoZSBmb3JtdWxh
ZSBmb3IgdGhlIGNhbGN1bGF0aW9uIGNvbWUgZnJvbSB0aGUgaGFyZHdhcmUgdGVhbQo+PiBhbmQg
d2UgYXJlIG5vdCBhYmxlIHRvIGVhc2lseSB0cmFuc2NyaXB0IHRoZW0gdG8gZml4ZWQgcG9pbnQg
Y2FsY3VsYXRpb25zLgo+IFdlbGwsIGlmIGl0J3MgYSBodW1hbiwgY2FuIHRoaXMgaHVtYW4gcmVz
cGVjdCB0aGUga2VybmVsIGNvZGluZyBzdHlsZSBhCj4gYml0IG1vcmUgOi0pIFNvbWUgb2YgdGhh
dCBzdHVmZiBpcyBhdHJvY2lvdXMuCgpZZXMsIEkga25vdy4gVGhhdCdzIHVuZm9ydHVuYXRlbHkg
c29tZXRoaW5nIHdlIHN0aWxsIG5lZWQgdG8gd29yayBvbiBhcyAKd2VsbC4KCj4+IFdlIGFyZSBj
dXJyZW50bHkgaW4gdGhlIHByb2Nlc3Mgb2YgbW92aW5nIGFsbCB0aGUgc3R1ZmYgd2hpY2ggcmVx
dWlyZXMKPj4gZmxvYXRpbmcgcG9pbnQgaW50byBhIHNpbmdsZSBDIGZpbGUocykgYW5kIHRoZW4g
bWFrZSBzdXJlIHRoYXQgd2Ugb25seSBjYWxsCj4+IHRob3NlIHdpdGhpbiBrZXJuZWxfZnB1X2Jl
Z2luKCkvZW5kKCkgYmxvY2tzLgo+IENhbiB5b3UgbWFrZSB0aGUgYnVpbGQgc3lzdGVtIHN0aWNr
IGFsbCB0aG9zZSAubyBmaWxlcyBpbiBhIHNpbmdsZQo+IGFyY2hpdmU/IFRoYXQncyB0aGUgb25s
eSB3YXkgSSBjYW4gZG8gY2FsbCB2YWxpZGF0aW9uOyBleHRlcm5hbAo+IHJlbG9jYXRvaW4gcmVj
b3JkcyBkbyBub3QgY29udGFpbiB0aGUgc2VjdGlvbi4KCk5lZWQgdG8gZG91YmxlIGNoZWNrIHRo
YXQgd2l0aCB0aGUgZGlzcGxheSB0ZWFtIHJlc3BvbnNpYmxlIGZvciB0aGUgCmNvZGUsIGJ1dCBJ
IHRoaW5rIHRoYXQgc2hvdWxkbid0IGJlIG11Y2ggb2YgYSBwcm9ibGVtLgoKPj4gQW5ub3RhdGlu
ZyB0aG9zZSBmdW5jdGlvbiB3aXRoIF9fZnB1IG9yIGV2ZW4gc2F5aW5nIHRvIGdjYyB0aGF0IGFs
bCBjb2RlIG9mCj4+IHRob3NlIGZpbGVzIHNob3VsZCBnbyBpbnRvIGEgc3BlY2lhbCB0ZXh0LmZw
dSBzZWdtZW50IHNob3VsZG4ndCBiZSBtdWNoIG9mIGEKPj4gcHJvYmxlbS4KPiBHdWVzcyB3aGF0
IHRoZSBfX2ZwdSBhdHRyaWJ1dGUgZG9lcyA7LSkKCkdvb2QgdG8ga25vdyB0aGF0IG15IHN1c3Bp
Y2lvbiBob3cgdGhpcyBpcyBpbXBsZW1lbnRlZCB3YXMgY29ycmVjdCA6KQoKPiBXaXRoIHRoZSBi
ZWxvdyBwYXRjaCAod2hpY2ggaXMgb24gdG8gb2YgbmV3ZXIgdmVyc2lvbnMgb2YgdGhlIG9ianRv
b2wKPiBwYXRjaGVzIHNlbmQgZWFybGllciwgbGV0IG1lIGtub3cgaWYgeW91IHdhbnQgYSBmdWxs
IHNldAoKR2V0dGluZyBhIGJyYW5jaCBzb21ld2hlcmUgd291bGQgYmUgcGVyZmVjdC4KCj4gKSB0
aGF0IG9ubHkKPiBjb252ZXJ0cyBhIGZldyBmaWxlcywgYnV0IGZ1bGx5IGNvbnZlcnRzOgo+Cj4g
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25fY2Fs
Y3MuYwo+Cj4gQnV0IGJ1aWxkaW5nIGl0IChhbmQgdGhpcyBpcyBhbiBhYnNvbHV0ZSBwYWluOyB3
aGVuIHlvdSdyZSByZXdvcmtpbmcKPiB0aGlzLCBjYW4geW91IHByZXR0eSBwbGVhc2UgYWxzbyBm
aXggdGhlIE1ha2VmaWxlcz8pLCB3ZSBnZXQ6Cj4KPiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxjcy5vOiB3YXJuaW5nOiBvYmp0b29sOiBk
Y25fdmFsaWRhdGVfYmFuZHdpZHRoKCkrMHgzNGZhOiBGUFUgaW5zdHJ1Y3Rpb24gb3V0c2lkZSBv
ZiBrZXJuZWxfZnB1X3tiZWdpbixlbmR9KCkKPgo+ICQgLi9zY3JpcHRzL2ZhZGRyMmxpbmUgZGVm
Y29uZmlnLWJ1aWxkL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2Fs
Y3MvZGNuX2NhbGNzLm8gZGNuX3ZhbGlkYXRlX2JhbmR3aWR0aCsweDM0ZmEKPiBkY25fdmFsaWRh
dGVfYmFuZHdpZHRoKzB4MzRmYS8weDU3Y2U6Cj4gZGNuX3ZhbGlkYXRlX2JhbmR3aWR0aCBhdCAv
dXNyL3NyYy9saW51eC0yLjYvZGVmY29uZmlnLWJ1aWxkLy4uL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNzLmM6MTI5MyAoZGlzY3JpbWluYXRv
ciA1KQo+Cj4gIyAuL29iamR1bXAtZnVuYy5zaCBkZWZjb25maWctYnVpbGQvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY25fY2FsY3MubyBkY25fdmFsaWRh
dGVfYmFuZHdpZHRoIHwgZ3JlcCAzNGZhCj4gMzRmYSAgICAgNTBmYTogIGYyIDBmIDEwIGI1IDYw
IGZmIGZmICAgIG1vdnNkICAtMHhhMCglcmJwKSwleG1tNgo+Cj4gV2hpY2ggc2VlbXMgdG8gaW5k
aWNhdGUgdGhlcmUncyBzdGlsbCBwcm9ibG1zIHdpdGggdGhlIGN1cnJlbnQgY29kZS4KCk1ha2lu
ZyBhbiBlZHVjYXRlZCBndWVzcyBJIHdvdWxkIHNheSB0aGUgY29tcGlsZXIgaGFzIG5vIGlkZWEg
dGhhdCBpdCAKc2hvdWxkbid0IHVzZSBpbnN0cnVjdGlvbnMgd2hpY2ggdG91Y2ggZnAgcmVnaXN0
ZXJzIG91dHNpZGUgb2YgCmtlcm5lbF9mcHVfe2JlZ2luLGVuZH0oKS4KCkdvaW5nIHRvIHRhbGsg
d2l0aCB0aGUgZGlzcGxheSB0ZWFtIGFib3V0IHRoaXMgd2hvbGUgdG9waWMgaW50ZXJuYWxseSAK
b25jZSBtb3JlLiBTaW5jZSB0aGlzIGRpc2N1c3Npb24gYWxyZWFkeSByYWlzZWQgYXR0ZW50aW9u
IGluIG91ciAKdGVjaG5pY2FsIG1hbmFnZW1lbnQgaXQgc2hvdWxkbid0IGJlIHRvIG11Y2ggb2Yg
YSBwcm9ibGVtIHRvIGdldCAKbWFucG93ZXIgdG8gZ2V0IHRoaXMgZml4ZWQgcHJvcGVybHkuCgpD
YW4gd2UgcHV0IHRoaXMgbmV3IGF1dG9tYXRlZCBjaGVjayB3aWxsIGJlIGJlaGluZCBhIGNvbmZp
Z3VyYXRpb24gZmxhZyAKaW5pdGlhbGx5PyBPciBhdCBsZWFzdCBtYWtlIGl0IGEgd2FybmluZyBh
bmQgbm90IGEgaGFyZCBlcnJvci4KClRoYW5rcywKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
