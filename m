Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8FD206B5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GqZCcLQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8FD206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700B16E991;
	Fri,  7 Aug 2020 09:34:22 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680056.outbound.protection.outlook.com [40.107.68.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677496E991
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 09:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/iv5ZaoPtvCsWBnvCgcWiW6uHLnvbzyzcnOisW+/+bb/3Eczkves/xZh5fb5g23XheAvTtX+H+Gij/RPI2KSaluJ/FlagBSA045scWAa2oypKAN2JY5giUDD0t4pyDhFxr+hW0xq1uLyQdZjXjOSWC9nvLCVdvi2pMLw8d7J599Nzdicdn8kNRZB7j5E7z/TBkybtN2Ii17nveEnrWsK/+UpinHQOkObCUwcHhPaShnIwUdssLgudfV53XnFIBIUGjGRhoyb7YsDYRkJrnXkdlAiBbc7bJGT8IDRC4rqpLP5a80/SsbeS9b5/M1Q4Q4ZUBVL3XjfhXnTeVmJ/bTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fili1Xq4zh1cLzQLq4VdySFiw9HUSxWmrwaZ9Fxtvf0=;
 b=VP9IdW94fgm4Nojn/ucELb2KSffJD7NIAfjpT47cMkJ7U3nL/XcNgya777ZO6ox+fh1QtlO+9SEY8OD5OYwfBBhWJR7NkHfoHDVYVXOTOVTI+DAgEw1Yu9LJ7KJyPoxF319/QjHExsVSN0qwi55glIW+1qKMXSwdXeDj7mJO1DfxCggf/pWF1JZ6Hs3VM97GVG0NFG4OMwJhYqCXIBGSt7Fl6j0Mk7ybuid8MqEVq6vA23cPc438dHKg8MbuWg3askTJm6kNI08dTIzsx8086tCufla7VkCzqEk+AFp6cUIi4sVJCuOZlk5t4uB9yHALb1v+VTQTa0CbzojTO32JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fili1Xq4zh1cLzQLq4VdySFiw9HUSxWmrwaZ9Fxtvf0=;
 b=GqZCcLQy/bjM7MoSPraAezR8dhQLfNTbe/ysHsTMWM6lF3Q+hYX078vfXeA9aGdvYcISH7R8uZKX6fWikjbEWnlnHjwLvxN6xhYnhoIhuiEf8ieuGbZcgJK3D6wOSeZa/jbHlfQPhF5KlaM8RglKr4S1Q+y7623c2K86KMhJEng=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 09:34:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3239.023; Fri, 7 Aug 2020
 09:34:19 +0000
Subject: Re: [PATCH] drm/amdgpu: annotate a false positive recursive locking
To: Daniel Vetter <daniel@ffwll.ch>
References: <20200806070230.21457-1-Dennis.Li@amd.com>
 <DM5PR12MB2533F4B9325903B915AD41F9ED480@DM5PR12MB2533.namprd12.prod.outlook.com>
 <031236ab-0646-bf1c-a93b-aec90bc6dab1@amd.com>
 <SN1PR12MB25447D63750B41887E893668ED480@SN1PR12MB2544.namprd12.prod.outlook.com>
 <cf4bc6ce-fca0-1c45-5665-4085a835196a@amd.com>
 <SN1PR12MB254440D6E152B08D3CA8D4C5ED480@SN1PR12MB2544.namprd12.prod.outlook.com>
 <b5d73714-9064-9baa-e687-406f9f4b1b69@amd.com>
 <DM5PR12MB2533C80EDE996B5E79ED169BED480@DM5PR12MB2533.namprd12.prod.outlook.com>
 <9121c08e-9043-b1fc-414a-03e4d7a280e3@amd.com>
 <DM5PR12MB25335CB16FB3B4CE6584355CED490@DM5PR12MB2533.namprd12.prod.outlook.com>
 <77def862-07d6-1079-b767-0ff4827a6234@amd.com>
 <DM5PR12MB2533453E6A4B046D4C7EE9F3ED490@DM5PR12MB2533.namprd12.prod.outlook.com>
 <b4375e2c-d28e-011f-4c6c-b4b05bf87e79@amd.com>
 <CAKMK7uEi53vmZFCkeQdMUF2SWsT9322aVLnbi85ZuvOo3=KGag@mail.gmail.com>
 <CAKMK7uHT1ei5CiUR=U3UV1sVbr0hTYtqe69YYckzMyjGnn+jHQ@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <20ce8bf1-dd0a-bb94-1c94-18fe12ec6625@amd.com>
Date: Fri, 7 Aug 2020 11:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAKMK7uHT1ei5CiUR=U3UV1sVbr0hTYtqe69YYckzMyjGnn+jHQ@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 09:34:18 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df7e0b8e-c0f2-4612-98df-08d83ab50f66
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43422728CBDEB29B0AF53E2E83490@MN2PR12MB4342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uS91alnn+tTUZ8ioXYnc9KNgx1Xx5YJBlaMRg+ecTcnoiwjsgHYCgzFD3FfiApaQG4/xbmVqglomJOFM4nd+Kl4wyIh8a6f7CtJXNaHmP3MJllpaEa+XV8DGlPX/9j++AKcAfv6IM5hkImGN4E304CTop/PQuHtcsnjK3QAjafU9ozWT7R4LZx03FFE9XpF0e//Ur/8JaZgSAYFt+wMSgzpSU7Di4ARAPQF7qjNASKHhFVGKNOX14DmRWzn6XZtGJdTDhT7VIrwOz8jbzRqfvb82ls9S0yr5En/z2NpTpilHUmNLc22r4obBUeKDx5nf4cgg0SoJmdrjIVNJeCy2nJgW2qnNQmAe8emAVQdOftwyVU27OvMw5qPb6IDv+3YSsGaIhH2FBbUTFCjgIIrGbrVL5FdxtWoLrdfEEQxj3/LmjUiWJv4lehQfF4pB2lIGmAFUuFpy6a/1Qw8qtSKbAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(2906002)(54906003)(31686004)(53546011)(52116002)(316002)(83080400001)(6916009)(6486002)(36756003)(16526019)(478600001)(966005)(66946007)(186003)(86362001)(2616005)(31696002)(66556008)(66476007)(6666004)(4326008)(45080400002)(66574015)(8676002)(8936002)(5660300002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rkxMcscRW6qC6rSh670m780w3LUVrJ83H898RchDCZF7x2eSCByEL6awLwLQ3QK64f3ZDscn6/NRPK3eXJD1E9aObfiGdS9vb3CKQaEZSxYhmoK1V+9SR7Bs8i4NiT1Nllnc09Ng1Xe+YJF8fQAGTU1edFFf3D9qyudNee1MZTseIXvI/98rQsIpKbuRVrbja+MSOXpZ5gU/8gtr3B8u3QcHHAmVrQYilqf3yjk4HKahbIGIcSLXR0L+NulKKVImUcEv5BFPEsv+YiRtwl0YeM0XWXXvb7QBcPVi2FRgmWWl5QmQUB2zUaWP85/dLcyHFYlRvV9TaBWPaXo3x7ByOe54oXjNgz369XtlDKoTR5DRahz0CalmHxHNoa/lWNpjbPyPGHGNhOByS5E2EqDktTgAf2UIk8JjtWi3b6wqxEdOD/yPqduLuuzS8751HuP01/s++RROqsL33RVRXR+pxH62NuRHElBTNQ0EJ6e1d0LnM6ejPx6ze/GZo5XXLFT83BIFFpQGn7V52X3Xzv22+vJL0pwmszHhxwl2B9kE5Ni5uQWEu/b70qYgOxTQ+AMDTrwMpeAS4mPKB6KH01ouaxfdWbVxgjG0lKYorw4GXXzx2ny43x3GVL7yQYzU2sp0yh1eSDO1V/Vubo5x3J9U0XvtOEs+zLr7F278A8Wpc7Nlf0XuOTusIDhPK0a5dmxNLQwB05yBVzwzM0fEVFVgQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7e0b8e-c0f2-4612-98df-08d83ab50f66
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 09:34:19.6537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xNkfcAGmb1klPs6j3Q1WSnEunIpU9zuFcCVlxVpIyiBs84HHWY4w49DqvEGhqLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDcuMDguMjAgdW0gMTE6MjMgc2NocmllYiBEYW5pZWwgVmV0dGVyOgo+IE9uIEZyaSwgQXVn
IDcsIDIwMjAgYXQgMTE6MjAgQU0gRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPiB3cm90
ZToKPj4gT24gRnJpLCBBdWcgNywgMjAyMCBhdCAxMTowOCBBTSBDaHJpc3RpYW4gS8O2bmlnCj4+
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Pj4gW1NOSVBdCj4+Pj4+Pj4gV2hh
dCB3ZSBzaG91bGQgZG8gaW5zdGVhZCBpcyB0byBtYWtlIHN1cmUgd2UgaGF2ZSBvbmx5IGEgc2lu
Z2xlIGxvY2sgZm9yIHRoZSBjb21wbGV0ZSBoaXZlIGluc3RlYWQuCj4+Pj4+Pj4gW0Rlbm5pcyBM
aV0gSWYgd2UgdXNlIGEgc2luZ2xlIGxvY2ssIHVzZXJzIHdpbGwgbXVzdCB3YWl0IGZvciBhbGwg
ZGV2aWNlcyByZXN1bWluZyBzdWNjZXNzZnVsbHksIGJ1dCBpbiBmYWN0IHRoZWlyIHRhc2tzIGFy
ZSBvbmx5IHJ1bm5pbmcgaW4gZGV2aWNlIGEuIEl0IGlzIG5vdCBmcmllbmRseSB0byB1c2Vycy4K
Pj4+Pj4+IFdlbGwgdGhhdCBpcyBpbnRlbnRpb25hbCBJIHdvdWxkIHNheS4gV2UgY2FuIG9ubHkg
cmVzdGFydCBzdWJtaXNzaW9ucyBhZnRlciBhbGwgZGV2aWNlcyBhcmUgcmVzdW1lZCBzdWNjZXNz
ZnVsbHksIGNhdXNlIG90aGVyd2lzZSBpdCBjYW4gaGFwcGVuIHRoYXQgYSBqb2Igb24gZGV2aWNl
IEEgZGVwZW5kcyBvbiBtZW1vcnkgb24gZGV2aWNlIEIgd2hpY2ggaXNuJ3QgYWNjZXNzaWJsZS4K
Pj4+Pj4+IFtEZW5uaXMgTGldIFllcywgeW91IGFyZSByaWdodC4gRHJpdmVyIGhhdmUgbWFrZSBz
dXJlIHRoYXQgdGhlIHNoYXJlZCByZXNvdXJjZXMoc3VjaCBhcyB0aGUgc2hhcmQgbWVtb3J5KSBh
cmUgcmVhZHkgYmVmb3JlIHVubG9jayB0aGUgbG9jayBvZiBhZGV2IG9uZSBieSBvbmUuIEJ1dCBl
YWNoIGRldmljZSBzdGlsbCBoYXMgcHJpdmF0ZSBoYXJkd2FyZSByZXNvdXJjZXMgc3VjaCBhcyB2
aWRlbyAgYW5kIGRpc3BsYXkuCj4+Pj4+IFllYWgsIGJ1dCB0aG9zZSBhcmUgbmVnbGlnaWJsZSBh
bmQgd2UgaGF2ZSBhIHRlYW0gd29ya2luZyBvbiBkaXNwbGF5IHN1cHBvcnQgZm9yIFhHTUkuIFNv
IHRoaXMgd2lsbCBzb29uZXIgb3IgbGF0ZXIgYmVjb21lIGEgcHJvYmxlbSBhcyB3ZWxsLgo+Pj4+
Pgo+Pj4+PiBJIHN0aWxsIHRoaW5rIHRoYXQgYSBzaW5nbGUgcndzZW0gZm9yIHRoZSB3aG9sZSBo
aXZlIGlzIHN0aWxsIHRoZSBiZXN0IG9wdGlvbiBoZXJlLgo+Pj4+Pgo+Pj4+PiBbRGVubmlzIExp
XSBGb3IgeW91ciBhYm92ZSBjb25jZXJuLCB3ZSBjYW4gb3BlbiBhIG5ldyB0aHJlYWQgdG8gZGlz
Y3VzcyBpdC4gSWYgd2UgbWFrZSBhIGRlY2lzaW9uIHRvIHVzZSBhIHNpbmdsZSBhZnRlciBkaXNj
dXNzaW5nLCB3ZSBjYW4gY3JlYXRlIGFub3RoZXIgcGF0Y2ggZm9yIGl0Lgo+Pj4+IFRoYXQncyBh
IHJlYWxseSBnb29kIGFyZ3VtZW50LCBidXQgSSBzdGlsbCBoZXNpdGF0ZSB0byBtZXJnZSB0aGlz
IHBhdGNoLgo+Pj4+IEhvdyBzZXZlcmUgaXMgdGhlIGxvY2tkZXAgc3BsYXQ/Cj4+Pj4KPj4+PiBB
dCBiYXJlIG1pbmltdW0gd2UgbmVlZCBhICIvKiBUT0RPOiAuLi4uIiBjb21tZW50IHdoeSB3ZSBk
byB0aGlzIGFuZCBob3cgdG8gcmVtb3ZlIHRoZSB3b3JrYXJvdW5kIGFnYWluLgo+Pj4+IFtEZW5u
aXMgTGldIEl0IGlzIG5vdCBhIHdvcmthcm91bmQuIEFjY29yZGluZyB0byBkZXNpZ24gb2YgbG9j
a2RlcCwgZWFjaCByd19zZW1hcGhvcmUgc2hvdWxkIGhhcyBhIHNlcGFyYXRlZCBsb2NrX2NsYXNz
X2tleS4gSSBoYXZlIGV4cGxhaW5lZCB0aGF0IGluaXRfcndzZW0gaGFzIHRoZSBhYm92ZSBsaW1p
dGF0aW9uLCBzbyB3ZSBtdXN0IGNvcnJlY3QgaXQuCj4+PiBZZWFoLCBidXQgdGhpcyBleHBsYW5h
dGlvbiBpcyBub3QgcmVhbGx5IHN1ZmZpY2llbnQuIEFnYWluIHRoaXMgaXMgbm90Cj4+PiBhbiBs
aW1pdGF0aW9uIG9mIGluaXRfcndzZW0sIGJ1dCBpbnRlbnRpb25hbCBiZWhhdmlvci4KPj4+Cj4+
PiBJbiBvdGhlciB3b3JkcyBpbiBtb3N0IGNhc2VzIGxvY2tkZXAgc2hvdWxkIHNwbGF0IGlmIHlv
dSB1c2UgcncKPj4+IHNlbWFwaG9yZXMgbGlrZSB0aGlzLgo+Pj4KPj4+IFRoYXQgd2UgYXZvaWQg
dGhpcyBieSBsb2NraW5nIG11bHRpcGxlIGFtZGdwdSBkZXZpY2UgYWx3YXlzIGluIHRoZSBzYW1l
Cj4+PiBvcmRlciBpcyByYXRoZXIgcXVlc3Rpb25hYmxlIGRyaXZlciBkZXNpZ24uCj4+IFllYWgg
ZG9uJ3QgZ2l2ZSBtdWx0aXBsZSBsb2NraW5nIGNsYXNzZXMgbGlrZSB0aGF0LCB0aGF0J3MgZmFp
cmx5Cj4+IHRlcnJpYmxlLgoKT2ssIHRoYXQgaXMgZXhhY3RseSB0aGUgYW5zd2VyIEkgZmVhcmVk
IHdlIHdvdWxkIGdldC4KCj4+IFRoZSByaWdodCBmaXggaXMgbXV0ZXhfbG9ja19uZXN0X2xvY2ss
IHdoaWNoIHdlJ3JlIHVzaW5nIGluCj4+IHd3X211dGV4IG9yIGluIHdoaWNoIGlzIGFsc28gdXNl
ZCBpbiBtbV90YWtlX2FsbF9sb2Nrcy4KCkFoISBFbmxpZ2h0ZW5tZW50ISBTbyBpbiB0aGlzIGNh
c2Ugd2Ugc2hvdWxkIHVzZSBkb3duX3dyaXRlX25lc3RlZCgpIGluIAp0aGlzIHNwZWNpYWwgc3Bh
Y2UgYW5kIGFsbCBpcyB3ZWxsPwoKPj4KPj4gSWYgeW91IHNvbHZlIHRoZSBsb2NraW5nIG9yZGVy
aW5nIGJ5IHNvcnRpbmcgYWxsIHRoZSBsb2NrcyB5b3UgbmVlZAo+PiAodWdoKSwgdGhlbiB5b3Ug
Y2FuIGFsc28ganVzdCB1c2UgYSBmYWtlIGxvY2tkZXBfbWFwIGZvciB5b3VyIHNwZWNpYWwKPj4g
ZnVuY3Rpb24gb25seS4KPj4KPj4gQWxzbyBpbiBnZW5lcmFsIHRoZSBpZGVhIG9mIGFuIHJ3c2Vt
IGluIGNvbmp1bmN0aW9uIHdpdGggeGdtaSBjcm9zcwo+PiBkZXZpY2UgbWVtb3J5IGhhbmRsaW5n
IGp1c3QgcGxhaW4gZnJlYWtzIG1lIG91dCA6LSkgUGxlYXNlIG1ha2Ugc3VyZQo+PiB5b3UgcHJp
bWUgdGhpcyBsb2NrIGFnYWluc3QgZG1hX3Jlc3YgYW5kIGRtYV9mZW5jZSAoYW5kIG1heWJlIGFs
c28KPj4gZHJtX21vZGVzZXRfbG9jayBpZiB0aGlzIGxvY2sgaXMgb3V0c2lkZSBvZiBkbWFfcmVz
diksIGFuZCBpZGVhbGx5Cj4+IHRoaXMgc2hvdWxkIG9ubHkgZXZlciBiZSB1c2VkIGZvciBzZXR1
cCBzdHVmZiB3aGVuIGxvYWRpbmcgZHJpdmVycy4gSQo+PiBndWVzcyB0aGF0J3Mgd2h5IHlvdSB3
ZW50IHdpdGggYSBwZXItZGV2aWNlIHJ3c2VtLiBJZiBpdCdzIHJlYWxseSBvbmx5Cj4+IGZvciBz
ZXR1cCB0aGVuIGp1c3QgZG8gdGhlIHNpbXBsZSB0aGluZyBvZiBoYXZpbmcgYW4KPj4geGdtaV9o
aXZlX3JlY29uZmlndXJlIGxvY2ssIHdoaWNoIGFsbCB0aGUgcndzZW1zIG5lc3Qgd2l0aGluLCBh
bmQgbm8KPj4gZmFuY3kgbG9jayBvcmRlcmluZyBvciBvdGhlciB0cmlja3MuCgpXZWxsIHRoaXMg
aXMgZm9yIHRoZSBncm91cCByZXNldCBvZiBhbGwgZGV2aWNlcyBpbiBhIGhpdmUgYW5kIHlvdSBu
ZWVkIAp0byByZWJvb3QgdG8gY2hhbmdlIHRoZSBvcmRlciB0aGUgZGV2aWNlIGFyZSBpbiB0aGUg
bGlzdC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4+Cj4+Pj4gICAgQ29yZSBuZXR3b3JrIGRyaXZl
ciAobmV0L2NvcmUvZGV2LmMpIGhhcyB0aGUgc2ltaWxhciB1c2UgY2FzZSB3aXRoIHVzLgo+Pj4g
SnVzdCB0b29rIGEgbG9vayBhdCB0aGF0LCBidXQgdGhpcyBpcyBjb21wbGV0ZWx5IGRpZmZlcmVu
dCB1c2UgY2FzZS4gVGhlCj4+PiBsb2NrZGVwIGNsYXNzZXMgYXJlIGdyb3VwZWQgYnkgZHJpdmVy
IHR5cGUgdG8gbm90ZSB0aGUgZGlmZmVyZW5jZSBpbiB0aGUKPj4+IG5ldHdvcmsgc3RhY2suCj4+
Pgo+Pj4gQSBxdWljayBzZWFyY2ggc2hvd2VkIHRoYXQgbm8gb3RoZXIgZGV2aWNlIGRyaXZlciBp
cyBkb2luZyB0aGlzIGluIHRoZQo+Pj4ga2VybmVsLCBzbyBJJ20gbm90IHN1cmUgaWYgc3VjaCBh
IGJlaGF2aW9yIHdvdWxkbid0IGJlIHJlamVjdGVkLiBBZGRpbmcKPj4+IERhbmllbCB0byBjb21t
ZW50IG9uIHRoaXMgYXMgd2VsbC4KPj4+Cj4+PiBGZWxpeCBoYWQgc29tZSByZWFsbHkgZ29vZCBh
cmd1bWVudHMgdG8gbWFrZSB0aGF0IGFuIHVyZ2VudCBmaXgsIHNvCj4+PiBlaXRoZXIgd2UgY29t
ZSB1cCB3aXRoIHNvbWUgcmVhbCByZXdvcmsgb2YgdGhpcyBvciBhdCBsZWFzdCBhZGQgYSBiaWcK
Pj4+ICIvKiBUT0RPLi4uLiovIi4KPj4gQXNpZGUgZnJvbSAiSSBoYXZlIHF1ZXN0aW9ucyIgSSBk
b24ndCB0aGluayB0aGVyZSdzIGFueSByZWFzb24gdG8gbm8KPj4gZml4IHRoaXMgY29ycmVjdGx5
IHdpdGggbXV0ZXhfbG9ja19uZXN0X2xvY2suIFJlYWxseSBzaG91bGRuJ3QgYmUgYQo+PiBzZW1h
bnRpYyBjaGFuZ2UgZnJvbSB3aGF0IEknbSB1bmRlcnN0YW5kIGhlcmUuCj4gQWxzbyBvbmUgbW9y
ZSB3aXRoIG15IGRybSBtYWludGFpbmVyIGhhdCBvbiwgYXMgYSBoZWFkcy11cDogRGF2ZSZtZQo+
IGxvb2tlZCBhdCBpOTE1IGdlbSBjb2RlIGEgYml0IHRvbyBtdWNoLCBhbmQgd2UncmUgYXBwYWxs
ZWQgYXQgdGhlCj4gbWFzc2l2ZSBvdmVyLXVzZSBvZiBsb2NrZGVwIGNsYXNzIGhhY2tzIGFuZCBk
dWJpb3VzIG5lc3RpbmcKPiBhbm5vdGF0aW9ucy4gRXhwZWN0IGNyYWNrIGRvd24gb24gYW55b25l
IHdobyB0cmllcyB0byBwbGF5IGNsZXZlcgo+IHRyaWNrcyBoZXJlLCB3ZSBoYXZlIGEgZmV3IHRv
byBtYW55IGFscmVhZHkgOi0pCj4KPiBTbyBubyBtdXRleF9sb2NrX25lc3RlZCAodG90YWxseSBk
aWZmZXJlbnQgYmVhc3QgZnJvbQo+IG11dGV4X2xvY2tfbmVzdF9sb2NrLCBhbmQgcmVhbGx5IHVu
c2FmZSBzaW5jZSBpdCdzIGEgcnVudGltZSBjaGFuZ2Ugb2YKPiB0aGUgbG9ja2RlcCBjbGFzcykg
YW5kIGFsc28gbm90IGFueSBsb2NrZGVwX3NldF9jbGFzcyB0cmlja2VyeSBvcgo+IGFueXRoaW5n
IGxpa2UgdGhhdC4gV2UgbmVlZCBsb2NraW5nIGhpZXJhcmNoaWVzIHdoaWNoIG1lcmUgaHVtYW5z
IGNhbgo+IGNvbXByZWhlbmQgYW5kIHJldmlldy4KPgo+IENoZWVycywgRGFuaWVsCj4KPj4gQ2hl
ZXJzLCBEYW5pZWwKPj4KPj4+IFJlZ2FyZHMsCj4+PiBDaHJpc3RpYW4uCj4+Pgo+Pj4+IFJlZ2Fy
ZHMsCj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Cj4+Cj4+IC0tCj4+IERhbmllbCBWZXR0ZXIKPj4gU29m
dHdhcmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGYmxvZy5mZndsbC5j
aCUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDY2hyaXN0aWFuLmtvZW5pZyU0MGFtZC5jb20lN0NmYTk2
OWQzMDFlOWY0YTk4YzA1NjA4ZDgzYWIzYTBmOCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5
NGUxODNkJTdDMCU3QzAlN0M2MzczMjM4OTA0NjM3MzQ5NzcmYW1wO3NkYXRhPWRDQjBvT1E5aG5p
SHFCJTJGRVVaMTVyNmxaTk9TUlliUnA5cFhOaEw3U1ZETSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+Cj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
