Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5D0C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 17:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EAE61183
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 17:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EAE61183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F656E110;
	Mon,  3 May 2021 17:46:37 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88706E110
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 17:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq5CDeiNBe7UqZxYtJnTxYCx3SFj6VCF/h7clHsOJqU7gA1pPHBzMqyV8HC4PBvArvOdsJWo1IFQfFXBmgEyvpzsHOglcQ+KGHLnXwq4JqrskSRhq2sa3uGOt2Pzd2Nt9pDmx9AlbnkSSPABwH3KPyFLJ5Fh/kWSOgA73TLlOr0MovRRvjl6SVlLlvKf8xK+VrUtcR/HHCTljKOWJ6mlUn2U0wsgr5DgMcL2BaDbVlwglJRlCnud+TW4De6v0EBDXVSlBEe0YU207TQKhD4XOa49sFWn8UDGTjDEQx1rvRz2neb7Nh1cQDbXbwfe2qdNzEGQiKgVqvqy/C4mbD3G9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wp06O0kaFDxUmRNpy4QPyaaT2arprU+SthnMerWEwc=;
 b=gWYkFhB8NOlIJGFp/pqTKTCbbFxdCB8+sTSzjPFnK2Kh+58RmCPEpwj25Rd5DV+gRYZhhrpz9ujtcaGzMhTRuZIyTlRJtvMqe6DGnyEbY7Glp/LTYArHwO8RanDm89otGuwp/RMil5rgVmfMes0MWcxvKCgVua/Weyqr8ESi7nYi1pI2W5mqVT0aBhWxaIw0s4gtUfWBYOK/MY6XiVjERb3/P8LzZVsfDZ3hRdR/bj/bTZzEmRQYlmp7IvT7fO46mNLcXFtxjUmGpc66hgt3mIbDqm2tlAb7O7y19kb+6XoOLfGF2OXPv7zD0WKQPlMX0/rT6ttIfTEKk//KMwEZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wp06O0kaFDxUmRNpy4QPyaaT2arprU+SthnMerWEwc=;
 b=rJXFbRg1uTR5QnsIk0X77h9Hv9Z1oRDi3DplCjRfJjU8XZY8sggOznDsg2WiGiurwh8TnplF9mAZAcMf+Ehlnod2dLJXpIMRpAN+AjD3qYityi0XLFdrIol42wRU2ldkZjjHxOxoqNdQBLtIVCPxj+IGZJdDpsKIlG0P9ugzeKo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 17:46:32 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Mon, 3 May 2021
 17:46:31 +0000
Subject: Re: [PATCH] Update NV SIMD-per-CU to 2
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210503172557.1130985-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <734dca50-0d14-6822-87e9-5d8defc6038f@amd.com>
Date: Mon, 3 May 2021 13:46:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210503172557.1130985-1-Joseph.Greathouse@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.39 via Frontend Transport; Mon, 3 May 2021 17:46:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee094f38-bfdf-4176-f308-08d90e5b62a9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5225B7F3C45BCC8B68EE9A45925B9@BN9PR12MB5225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: go9MMlpmdmRZvVdgROACm3bWFtp8QJArJ5qaFWta7YkX3Bi1zwDt1AeOjPV0MwuwhUiXszlvoxg7kcklsmMbsHmV3RiaVUvDxXH7AfeEtTb/z/U65aCxV3KUiRu8+o+1Pqs1XpLG5QADlEq2UN87Pw0r8c2+cLoyeBTYuOBIpntMVWDe/J5yBTrw/JuiBAftMy4S4aZkqfJZv54n/ep/0nvkwbF4fqAxoDq+oHKmNiSCpteSB4wX5IqSXzcjBt4xgvKTgNRzs9Lhx7j6OOJn2oIu3pNwxILCW/qYX4EfILoaUYHZ91FgdxQVxjoTGkI0bEp1s0mKAmJP0l7EMGZMmiHMnfNGcULfAMJkk9KX4z8xt/lCJ7KoSBHlE68G2rkDrry0i/vK4rRbxF6cuy4ip6cxrsnzOCFRff02zAZRsc7kU5Ml89uWJ2kyBzuMIwp4yNBqJBZd/AwN3nso2o27KaOfLAZz/01arKtRVDIdY5eDIyLYwPjPOo5A92H7dicIwtR/HkSx+c+LWcTT3NBPQmPj5E+WczWk6q+fBA0+fqXsp4GL0fUARPmQePR8IgshArAJS0m2grwEBP9086GYSQUbdkn6tMXWvkM/kADei7r0zDhN0ib/4FkjajGvG18XWEXr+mFni5qBp3XvC/am+oiCotOPIn0vhV2kpLG9BiH8yr0jDMg97Osej3A4Zvb2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39850400004)(136003)(366004)(376002)(66556008)(31686004)(2906002)(36756003)(66476007)(4326008)(83380400001)(5660300002)(478600001)(66946007)(16526019)(186003)(6486002)(26005)(8676002)(86362001)(38100700002)(44832011)(2616005)(316002)(31696002)(956004)(16576012)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MWdNekZONUI1T2xTaytHSGVRVWlFZ0s4WGRJVVc5WnBtMHN5YjUvZlJjWjEr?=
 =?utf-8?B?dnNzSjZHV2pxWlR1Q0FPaFUydWhXbjFiUzY0YmM4MUQvWXdlMnBUOFpsN0pH?=
 =?utf-8?B?QXBFc0d6ekZXSWFyTHU2d010dHd4RHFVSHZYbGNleUVzWlNPdVQwNVk5WDdj?=
 =?utf-8?B?SnBWNm5USnZmZ0tHK0l3VExNVEYvUzhJWkp4KzdCQVZlRG1QQkVHL3pxQS8y?=
 =?utf-8?B?SVA5KzZnNERIeGdiMGsyTlpOd0lLUXh1bytQMUEyYXFTeDZDTVVMUUVIcGVB?=
 =?utf-8?B?WG1JMm1PVEh4ZnltQXpMbzk3UTdvMUc2dHhwaFVuYzk5Q3c4cU95UmlSbkJw?=
 =?utf-8?B?Sk5Za21IZWJyNU0rQldxUWtyTE5LYjhuYWQvMTEyck94R2ZnU0tjZGtZRW0x?=
 =?utf-8?B?cXNTTTN3MW9PbGN5QysyMjJUbEtBbUh2VUpLTlhET2ZrRzhqWTZsMkJpYVNK?=
 =?utf-8?B?SURiMGdlV0pIS3E2S3pZQVR6SXNGLzZkK0lmZ0RpWDJEbm9lZnd1UTZxRlJW?=
 =?utf-8?B?cS9rWFZNOE1lcWI2ZXNvTHc5WXZka1hGUDd5eDNBcVJBbC9qM0hkMFkwSnRu?=
 =?utf-8?B?eU5mRWhMbTl6SWhudmNrYSt2TmxMQjMvbVRVaVM2SGxYdmhteTRVeXBxdGtU?=
 =?utf-8?B?Vm8rUmE3ZFNiQU14dllFMlV4M01vTWpEbDJKMmY3ZmoxT1ZNNkp6WEFDQWJT?=
 =?utf-8?B?SFRsb0UzT0F5UWJRZ3JnQ3BrY0ZObUk0QmhtYWloL1dQU3pqTDg1b0RQVllT?=
 =?utf-8?B?UlFEMkUzSTd2M3gyUEcrTEFONys2UCtVNjdDcktmcTRFMUFHL3BnSnk5L3JR?=
 =?utf-8?B?TXp6dVpzbmk2bnZlWERDZnhMV29QTDJoVElCNmdnL3NkRmpKdlpxeklqMXlo?=
 =?utf-8?B?ajhpU0lDQWQwcEhUdzJjdDJFOGRlRmlrVm9pZ3ZLMFNCYU5uZDZ2MEFPMWpx?=
 =?utf-8?B?MG5DQVdqL1Z0WXdtL2llZ0MzTjZJQU43YzBiQm1RUFd2cE0yKzVZNUF0T2RD?=
 =?utf-8?B?RENkSFNIek5TazA1T3R1b0FKd2tCZXV2YmMzbERJSjZ6WWpRMlZ5bWdJUGly?=
 =?utf-8?B?SWtvd0VRSkRwTjVGdVJrKzVNTGJROGlsaEE1Q3RhUFdwb2JwT0FBUVRGRE5t?=
 =?utf-8?B?UlVndTQvQXJuenZNcmMrQXErMnROak5HZC8wcEtIOE1GYUNRSldySUFUSm9m?=
 =?utf-8?B?NjhuV2FJSm83clp2UkVmeTRiTUhmaFpuVE9OME5mTzRUUStqQTR4RmF6VnI4?=
 =?utf-8?B?VU0yNGY2SGJzZFZjci9FRytBWFV4SkZMRXpxckV2YTAwY2dWVnhoRmg2MXZt?=
 =?utf-8?B?b1B6aCtRQjJkTHYzWlM2bHVMWllBWmtoRXVueGNHd3g5dVhhY0xGd05LbU9s?=
 =?utf-8?B?S3cySEt2aGtjeUNWUkdZbGRidjVKRnZ2cUZiWUpaWVExaUpFV3ViZkxsd2Vv?=
 =?utf-8?B?VER2L1U5SklLTG52OHZSM1Exc0NXd3l3bVFWVWNXWHZjeUF6V1U4eG9qRzRE?=
 =?utf-8?B?UXZGR25vdDdEM2lWdVRhL3hVQmwvVE00eVZPanNkZkFYSUxia3pSTUFzc2wz?=
 =?utf-8?B?d0g3YmxtRlVuSlBjWEFGQlprR2FxNGgzR0RQbUNaa2tKeEovWU5YbWlsOVcz?=
 =?utf-8?B?UVpyRG9mVllSVEYvOGxSZmJ5UGlRZ0lKdWtQc2NNdStmRllVcmQwUFVXeDM1?=
 =?utf-8?B?cmpWNTJPeW1oQTRBU0JqUW5ZVjM0Y3lud1hyaDcxZ0xnWGtFSjY0TUpwYXBL?=
 =?utf-8?Q?yjjqFK/w0AQCVYDyKIqNq6EChzaJJ6fbeFiOKcn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee094f38-bfdf-4176-f308-08d90e5b62a9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 17:46:31.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAG7BsrsUvS5WX6dAgdmK1qAcOxz47eHq7Bxor602UP6YgzfiuDG55wdHtDn0Ny1ZADjTmEs1UaotFB3su39Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Cc: Hawking.Zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNS0wMyB1bSAxOjI1IHAubS4gc2NocmllYiBKb3NlcGggR3JlYXRob3VzZToKPiBO
YXZpIHNlcmllcyBHUFVzIGhhdmUgMiBTSU1EcyBwZXIgQ1UgKGFuZCB0aGVuIDIgQ1VzIHBlciBX
R1ApLgo+IFRoZSBOViBlbnVtIGhlYWRlcnMgaW5jb3JyZWN0bHkgbGlzdGVkIHRoaXMgYXMgNCwg
d2hpY2ggbGF0ZXIgbWVhbnQKPiB3ZSB3ZXJlIGluY29ycmVjdGx5IHJlcG9ydGluZyB0aGUgbnVt
YmVyIG9mIFNJTURzIGluIHRoZSBIU0EKPiB0b3BvbG9neS4gVGhpcyBjb3VsZCBjYXVzZSBwcm9i
bGVtcyBkb3duIHRoZSBsaW5lIGZvciB1c2VyLXNwYWNlCj4gYXBwbGljYXRpb25zIHRoYXQgd2Fu
dCB0byBsYXVuY2ggYSBmaXhlZCBhbW91bnQgb2Ygd29yayB0byBlYWNoCj4gU0lNRC4KPgo+IFNp
Z25lZC1vZmYtYnk6IEpvc2VwaCBHcmVhdGhvdXNlIDxKb3NlcGguR3JlYXRob3VzZUBhbWQuY29t
Pgo+IENoYW5nZS1JZDogSTk0MDIxY2E3MTM2M2EzZDI3MzMwYjJmZGE4ZTZhY2FhYzI1ODAxN2UK
ClBsZWFzZSByZW1vdmUgdGhlIENoYW5nZS1JZC4gWW91IGNhbiBkaXNhYmxlIGdlbmVyYXRpb24g
b2YgQ2hhbmdlLUlkcyBpbgp5b3VyIGtlcm5lbCByZXBvc2l0b3J5IHdpdGggdGhpcyBjb21tYW5k
OgoKwqDCoMKgIGdpdCBjb25maWcgLS1ib29sIGdlcnJpdC5jcmVhdGVDaGFuZ2VJZCBmYWxzZQoK
VGhlIGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLiBBcyBmYXIgYXMgSSBjYW4gc2VlIGluIHRoZSBj
b2RlIHRoaXMgd291bGQKZml4IGJvdGggdGhlIHNpbWRfY291bnQgYW5kIHNpbWRfcGVyX2N1IHBy
b3BlcnRpZXMgaW4gdGhlIEtGRCB0b3BvbG9neS4KSSBkb24ndCBzZWUgdGhpcyB2YWx1ZSB1c2Vk
IGFueXdoZXJlIGVsc2UgaW4gYW1kZ3B1LCBzbyB0aGVyZSBzaG91bGRuJ3QKYmUgYW55IG90aGVy
IHVuZXhwZWN0ZWQgc2lkZSBlZmZlY3RzLgoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5j
bHVkZS9uYXZpMTBfZW51bS5oIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2lu
Y2x1ZGUvbmF2aTEwX2VudW0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9uYXZpMTBf
ZW51bS5oCj4gaW5kZXggZDVlYWQ5NjgwYzZlLi44NGJjYjk2Zjc2ZWEgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL25hdmkxMF9lbnVtLmgKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvbmF2aTEwX2VudW0uaAo+IEBAIC00MzAsNyArNDMwLDcgQEAg
QVJSQVlfMkRfREVQVEggICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MDAwMDAwMDEsCj4g
ICAqLwo+ICAKPiAgdHlwZWRlZiBlbnVtIEVOVU1fTlVNX1NJTURfUEVSX0NVIHsKPiAtTlVNX1NJ
TURfUEVSX0NVICAgICAgICAgICAgICAgICAgICAgICAgICA9IDB4MDAwMDAwMDQsCj4gK05VTV9T
SU1EX1BFUl9DVSAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDAwMDAwMDAyLAo+ICB9IEVO
VU1fTlVNX1NJTURfUEVSX0NVOwo+ICAKPiAgLyoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
