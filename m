Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D1CC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 12:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 140E2611CA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 12:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140E2611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606726E125;
	Mon, 10 May 2021 12:56:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFE46E125
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 12:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXFs4LQtTyvWJqBzpqS3YdffHcU1RxuoJU2K7L+dpDVFC67S1GNS93ejZZAL4E5Av3tBiMvPnbfqwaVTcLQ6GT9k9wdVNUKkHzqug5RVkypmfyTNbMmKQ5JpDCYJbWXb8NzsJSSauTSaH/ZVa6Us5HmC1n7Cy6zjTA3UY1zcTSwxQ7+kDEuX5Evrt7xZS0FJJR8R4PMpi/IbAUq/4PshBnvxWte0AjgYPKTVf7UFPIWn81Y90IhNNT3bDuyFGnSa4kDR94NDzfEd3F7lny29dWTbw8v9bys3Vu/7E/fSAM96j38OWs58HSGmEVal0rg/Sin5KSJOby8kUBQI/+prdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJXkm33xV6BJqdPOx/XIKvAX3ClxozfSBL/IwrPqfZI=;
 b=XNFJRare4gDRQ4hBbp6GkhXaLYzHsiX+gB9fcJe2xPTol+zMM4ljD+MuPZWRW/bcnZsWVePyClzQJP5Q0aDock7G/635uwrcBCOt+Fadgywalw8X2jfc4LKAzcGgFnvfYeLGsDfXKeBWkVMnSSRWeXLsxNAU7r1KbohzLE0WwuwbgyNzRNqc+Im/PIwQ2XlVZDd9QCowCaEBSrhHT9iVvkvV6MTKJW4jp81qIpf/IFk6F97yxXR6d2BaJmeNHwL+wT/ITrhICJsGHMySr6rIbtPiRP+9t5AU0S4I7Nn8kC0iddP18nx1XzpFAe7sWm6toSq0nFTwY/Npd0/Tjcw49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJXkm33xV6BJqdPOx/XIKvAX3ClxozfSBL/IwrPqfZI=;
 b=iEc5/PEAplio4YjjsrFIp7VHpkcr+h0sjbNR4NeXpqzV0VoZT8iMWdAqr7hXVFnyrIzbqASboN4FC8Wsb7dwsys+jrAXzsicvKEh0f88qzx7sPpwEoTyYLgv+9IXHpMaQhchzu1t4cmDX3KLIwGgD0lvdJGgearleQBJlAVJ3lI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 12:56:47 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 12:56:47 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: unregistered range accessible by all GPUs
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210505175617.30404-2-Philip.Yang@amd.com>
 <20210507190704.7682-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <21e77c32-4299-2923-e43c-821fe996defe@amd.com>
Date: Mon, 10 May 2021 08:56:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210507190704.7682-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::16) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT1PR01CA0107.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Mon, 10 May 2021 12:56:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a092f6f8-84c5-4b3c-826b-08d913b31203
X-MS-TrafficTypeDiagnostic: BN9PR12MB5260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5260A89DA47A8B307015330792549@BN9PR12MB5260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQwOD9/efv3VguzrXhy8Xhw70MBAsqFjFmGLMhlD4wx3trjNN3ZHwygjxTXcy2hFGolPwHaqM6bCoZmeAOBcnDbiWv7IfHfwNTLx0pc/S6TIJWc0AfmCGFKwRbR9e1jEyMCA44SsHKGdiMeNFuPQmqVKqPssqjl1ZyCyj0ApfXAcKFY5i4ebVfcVM9ntiKZTUy6DZprmrwT3GHxNk7Ci4OYgsFc1h9FrKhSmohJ7qeidbPWmMJw/Sjwbpqajb7wqLydHiKlgICPEdYwdNAXMnnKVgVJtaqNan0mVVIbf4cfAeL6JFlw4kSYU0Y3IS77s1CEpLbPsv0pHzXFK5he9Rl3NckxGz90Ldj7rqRdGTPY5BMWgQd0hawjNtTb3smpTzLPqFt2aIMfMEXQlnuoI8YH6U49bT7MiJXRngQKj01llLvzoXXmnr1cv01mV5A2J7iDALN5md6qWHcJyWvskqBj/vc5rvLbTIhN0bIEuRYhZicPVuCFDQH5r0SzZr4lRB2YODiUzrZKNfc+nM42j9kmR08p5y/0k7CDcrXBTwQf1AD6KJWLpPg7aRHMdXvWFcbTDKdMSKepNgTxj6uqRCFI38WfX6DOt50wFlkKrWtF4AkOBOiSwJGPIrPyEWXni5kbqwoecXK4bT+e1y1Ey6e0WMASgQSdSIUzxdO28cZ7K2y6AtTj5z7yG5aRwm/Gp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(136003)(376002)(8936002)(2616005)(956004)(186003)(26005)(38100700002)(86362001)(8676002)(16526019)(478600001)(5660300002)(6486002)(44832011)(66946007)(66476007)(36756003)(66556008)(2906002)(83380400001)(16576012)(31696002)(31686004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WkNQR0hjVEJkaTN4STI3M0RLYllDZVRZdVVRRnB4UVlWTE54bHBBblNsWjlH?=
 =?utf-8?B?b2V2QkFiQytuL3RtU1p6dDhiL3laaU9zYXBuM2VUQ3pydVEzTmFtYXhWUXVY?=
 =?utf-8?B?eFVNbTJFRnB1UjhrZFFGT0dTelM3dXliVHhycXlLY2g5aGUrNFpLeGhJZVJC?=
 =?utf-8?B?ZjZQRktoNGxSUm0zSytmRGZma3dPUmZEUDJQcXQ5dTFPNlVsbDJ6VDZXZ0JM?=
 =?utf-8?B?VUd3L1oyK0pjOVdWUFVyNjliWGc5U1dkbjFBSmljV0R3VXhMSHN4YkxRWFpP?=
 =?utf-8?B?MlFXR3l2U2laOTY4NHJtS21sNTdWa2NrUG5vZnN6UHZqRkJCa1JuK3FDK3dn?=
 =?utf-8?B?NU1qWGw3UEl1RmYxbFMxSWdtcDhVeWR3SG5YRytZWlZHTWFSZkNGOXNrU3RP?=
 =?utf-8?B?K3ZneC9XcHk0eDlXMkRvM2w3OUtRMldCS29TQ1VaUDFxMnNTNkJNclMzQ0dG?=
 =?utf-8?B?U2FaV3I3TlBieXcwOTJXWk9yTXVUQlJoc2QzeGJTeUczc2s5NEwrdHlvWkcw?=
 =?utf-8?B?MWp4NzJkWnpSUy91aUdwT1R0clJqYlhXZjF3VDFnL08yaGRHL0RpMUdrUThP?=
 =?utf-8?B?TXRUYXlac05FdjVhZDFpUis1ZnNyNkRwTGJPQVBLUWFwbTBhRHpBN2V3dExh?=
 =?utf-8?B?TkpFVExRWWkyUm9JcVRXdzhhREZ6ZGhHdVFkSmx3Q0l1b2JtMm1HSXh4RjJ0?=
 =?utf-8?B?djhTa2dmeXdSZDUyMjJCMng2Mk9NRUtYTml2N2VXWmF0SUcyc3hjam5MM292?=
 =?utf-8?B?d2lSc1RvU0Rva3k1WjZlc3d4bWdpNy9mRFdmbnQ4dEhPd1VBTjZCYkwrMlVG?=
 =?utf-8?B?R2JuNTRSRDl0a1RrTzlBTnZ6YUsvSWlCWms4OE8wQXBkbDJHLy8rYWcyRkdq?=
 =?utf-8?B?SmZxRDcrNXRMS3FBbjJnUVBMNGpFcHdLemdpNWZqZzU5SWpkcHBnVERHRm1u?=
 =?utf-8?B?UytneHVhQjhEdVozMlkxTU81STJPd0ZDK3ZJNTFLejYxRnNVOTFpcjhGRWIy?=
 =?utf-8?B?QUJTMkE0blQ0K2I0U0ZkZEhTMkh3Nk0zMStGN2pqMlhQNHhWMmRCK0R2V0tt?=
 =?utf-8?B?SklFNVRXTXU4OGE0RE1UUUJXM0Erb2dKSmtSNkpCS2xiUS9nWXZTakFnUVVY?=
 =?utf-8?B?NlR5bFozYXNxekduTkl0NmJQSkdrUlZ5azk2K1RHeGFhb2d6SC90d3BwVmxC?=
 =?utf-8?B?eU4wZnpKOW9SekdtZ2orUnNvSmpWaEZkS0hyN0QraUUwdWZ3UTk3dlRTU2VR?=
 =?utf-8?B?dzFHbVd2S2h4UHJoR1p5ZStXdUtvYjNKaFArSnFWM0JtbW8zWDFVcXJhdmUr?=
 =?utf-8?B?MGNHNXdHRUVWdXhqRHdISGcwYjBJcDQ1bnZJNDZ1dWFBK29oS3RmaE9XOWN3?=
 =?utf-8?B?aXNsTTJJR2pkUXFXTjJSdDdycWp2NlRidTFocE1PTjZtUVNEb1BHUnhqT05G?=
 =?utf-8?B?eEZJM2NNajN6S2gyQkYxNGM2RS94am5vNkVvSWEvSXphdDQ0WHFsZklxN290?=
 =?utf-8?B?NDZTMUtKM1VlempYQ3Y4cWdPQndzK2FydHZ0SlppSUM5ZWsxWkowRyt2K3B2?=
 =?utf-8?B?K2VoTysydGlVVmxBUmkvR2VuWGVtWWZOaDlPZENOVGQ0b0V1K3hyUnpGVVRv?=
 =?utf-8?B?YUk0U2dGQkJFejJyeitiRUJhaXU4eUhsU25pVFU4a2xPMThkY3cxSHhzcVox?=
 =?utf-8?B?SGhUb1RZdFMxeGd4Tm41THZHMTVpZDJONGwzZW1FaFRjenpOazlieWY5Uk5I?=
 =?utf-8?Q?iP44/Bi/B9l9euRwPZ+/pKYsrzuhXUoKAfAJKTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a092f6f8-84c5-4b3c-826b-08d913b31203
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 12:56:47.3831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaU08joPxPOeWJOgXtN8oMJJiSK84T6LwEdN8OruucpvDLpa/2CIvdXMn7L9Qdd0C2K8l8RTrPUmD4gKjde3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNS0wNyB1bSAzOjA3IHAubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKPiBOZXcgcmFu
Z2UgaXMgY3JlYXRlZCB0byByZWNvdmVyIHJldHJ5IHZtIGZhdWx0LCBzZXQgYWxsIEdQVXMgaGF2
ZSBhY2Nlc3MKPiB0byB0aGUgcmFuZ2UuIFRoZSBuZXcgcmFuZ2UgcHJlZmVycmVkX2xvYyBpcyBk
ZWZhdWx0IHZhbHVlCj4gS0ZEX0lPQ1RMX1NWTV9MT0NBVElPTl9VTkRFRklORUQuCj4KPiBDb3Jy
ZWN0IG9uZSB0eXBvLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwIFlhbmcgPFBoaWxpcC5ZYW5n
QGFtZC5jb20+CgpXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gbW92ZSB0aGlzIGludG8gc3ZtX3Jhbmdl
X25ldywgY29uZGl0aW9uYWwgb24KcC0+eG5hY2tfZW5hYmxlZD8gVGhhdCB3YXkgaXQgd291bGQg
Y29ycmVjdGx5IGFwcGx5IHRvIHJhbmdlcyBjcmVhdGVkCnRocm91Z2ggU1ZNIEFQSSBjYWxscyAo
ZS5nLiBpbiBzdm1fcmFuZ2VfaGFuZGxlX292ZXJsYXAgb3IKc3ZtX3JhbmdlX2FkZCkgYXMgd2Vs
bD8KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3N2bS5jIHwgNyArKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3N2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4g
aW5kZXggZDkxMTFmZWE3MjRiLi41MzdiMTJlNzVmNTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3N2bS5jCj4gQEAgLTIyNDMsNyArMjI0Myw3IEBAIHN2bV9yYW5nZSAqc3ZtX3Jh
bmdlX2NyZWF0ZV91bnJlZ2lzdGVyZWRfcmFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4gIAo+ICAJcHJhbmdlID0gc3ZtX3JhbmdlX25ldygmcC0+c3Ztcywgc3RhcnQsIGxhc3QpOwo+
ICAJaWYgKCFwcmFuZ2UpIHsKPiAtCQlwcl9kZWJ1ZygiRmFpbGVkIHRvIGNyZWF0ZSBwcmFuZ2Ug
aW4gYWRkcmVzcyBbMHglbGx4XVxcbiIsIGFkZHIpOwo+ICsJCXByX2RlYnVnKCJGYWlsZWQgdG8g
Y3JlYXRlIHByYW5nZSBpbiBhZGRyZXNzIFsweCVsbHhdXG4iLCBhZGRyKTsKPiAgCQlyZXR1cm4g
TlVMTDsKPiAgCX0KPiAgCWlmIChrZmRfcHJvY2Vzc19ncHVpZF9mcm9tX2tnZChwLCBhZGV2LCAm
Z3B1aWQsICZncHVpZHgpKSB7Cj4gQEAgLTIyNTEsOSArMjI1MSw4IEBAIHN2bV9yYW5nZSAqc3Zt
X3JhbmdlX2NyZWF0ZV91bnJlZ2lzdGVyZWRfcmFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCj4gIAkJc3ZtX3JhbmdlX2ZyZWUocHJhbmdlKTsKPiAgCQlyZXR1cm4gTlVMTDsKPiAgCX0K
PiAtCXByYW5nZS0+cHJlZmVycmVkX2xvYyA9IGdwdWlkOwo+IC0JcHJhbmdlLT5hY3R1YWxfbG9j
ID0gMDsKPiAtCS8qIEd1cmFudGVlIHByYW5nZSBpcyBtaWdyYXRlIGl0ICovCj4gKwo+ICsJYml0
bWFwX2ZpbGwocHJhbmdlLT5iaXRtYXBfYWNjZXNzLCBNQVhfR1BVX0lOU1RBTkNFKTsKPiAgCXN2
bV9yYW5nZV9hZGRfdG9fc3ZtcyhwcmFuZ2UpOwo+ICAJc3ZtX3JhbmdlX2FkZF9ub3RpZmllcl9s
b2NrZWQobW0sIHByYW5nZSk7Cj4gIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
