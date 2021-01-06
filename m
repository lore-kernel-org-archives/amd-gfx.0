Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319B6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 12:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23EE22CB9
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 12:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23EE22CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6605F6E02A;
	Wed,  6 Jan 2021 12:54:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6696E02A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 12:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I06a5U/GI+e1epIIxGpw/4J9CxGzNppjjh//+nJbwQZsUyMmpzm4DvnVVSStgolBKN++IOQHUzIxJPp/mABF0brjxcwtQvGtEbSRLoP1vaCgPzg1x1Pgxgt10n05Hk27mbE4ZnPAEDx/yR70W5luZw1pbmfOWkQoVkGBtspjzUmlA07mCKyK/x0/Aw7YnyR8VbMJOXzgUb9xSACwTLsWdJ4HIH9qfGggdZXugbp7xrZLSjC6No9y54EF2DNqJvvrS2oHJDnREkX8W/IM1aQAYswsWb5lzBjA9ljUCKdmjWr2JBAtRvqjMknGoVoazTD+UoNwaHGrM3CG/mOrWChSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zjjcbehx+kCZWzs9aBMgW77zNLCYXkNvjIwBQ2ettc=;
 b=ZYB+bHoWVac1PeMBtzTZrxeEzsot3+D665CLl6mgCWj1eFy8L7Y3Rax8IXGXJ2P1C5lbpWii6CwnTYrQTCWIbO+14PUTWgBolXGRX7TJO3mO47lwqx6/eVEiASnMfwVjr4OPydtxebd3FjgmYAUlw3GbGltrZsM8FtkucTGXk1EgN+X5ZeBydq3TqGGZR/Q98gdCeIYXJqHcMxKDun7zbeTC04sdIY7k57qgU7Gkb+cHRCoTLInrtAWQ/uLPjXhExMa/Zwt/Y5DXiB8UNh1S+5RWi0bxJzPGjd2JWdnI3mlprg28Go06fyDoAUT3LuML4k+tV3ENIlRGCRAYqd7nqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zjjcbehx+kCZWzs9aBMgW77zNLCYXkNvjIwBQ2ettc=;
 b=HwbOBQyDFEoAs7r0QWqsWeiSO4c84fMjl5oS8dhjDIIDciBymst4A/btZMPRP+ZQkpd3mJ/c9PL3PazI+m4yOFhWUyTPjVPQ6P3cFlZ4vTBP6ch8TbQdnmzJHCybudu0lQZMHP1iKt9//h3wlGTn6F3A66HkbbtXzpPYD5IgIxU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 12:54:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 12:54:30 +0000
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: Joshua Ashton <joshua@froggi.es>, Alex Deucher <alexdeucher@gmail.com>
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
 <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
 <9902861e-77bd-d6dc-7284-0ad9bcf117b6@amd.com>
 <a8f72dc6-8504-269e-56e8-699b20135a07@froggi.es>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4a3fe8b7-4248-e5c2-d6c0-5075596ca852@amd.com>
Date: Wed, 6 Jan 2021 13:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a8f72dc6-8504-269e-56e8-699b20135a07@froggi.es>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Wed, 6 Jan 2021 12:54:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4f2a9e6-f88f-4371-514b-08d8b2423557
X-MS-TrafficTypeDiagnostic: BL0PR12MB4947:
X-Microsoft-Antispam-PRVS: <BL0PR12MB494758E79A9583FB766A37ED83D00@BL0PR12MB4947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANBL6wCM8eYyupgT1de4jd0HMOl7xFZfTcrDPE9bsupaVMBlgrXmS8nb6pkKvPlUQZkwc9EnnuAjnPsBZ5l+u9voH6I2Ocvszwh9KRxb1doag/0xjLxRgyfkStxT7jnhRk4dBrvhhcxia4B6nvXcqAkVvk2GD1JQ4zOC2WTOi7zc07WtLvkJPLmANaEoXPW6vx6cnMXtETIxC+mS0vPEynhRn8JBe3t9LB1B+RBQtH1DRw+UYZMt0Z09Wac+6iLJNKiHyq8ZHe5rv8nX+AMADoz8rd4QpPvRXciJThwvQ84X+1TvUQVZ4vXn+tn+tojufKbin9b5PUHtf2U0MvyOUHO1XhQjRgW36NHB/ADAV00YQQwrBk1g2Hx+cXa6Efq//D6jvG+cYaVKwLHGqQuoq+qoN6tAP7uil8ooPR2VZQ7IkfPN4prX7QyOElrbYuP6DGGtap0JHZopRNQQSCa2Y6W/IlahI6ryQux0gYtiohFZVj0cLVLUH8qwIC48FeFuW5QwnMHQ7sqJPTGGR5hbrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(86362001)(2906002)(31686004)(31696002)(4326008)(6666004)(478600001)(5660300002)(8676002)(66476007)(45080400002)(66946007)(2616005)(66556008)(66574015)(6486002)(83380400001)(16526019)(186003)(52116002)(8936002)(966005)(53546011)(36756003)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bDdVNm5CTkRhdE5qeGtrQ3dnSk8vRnQrL2ZFYVd6VUFFME5haDVsUzRBRkl3?=
 =?utf-8?B?UHpoRW1TamNTWGJsOUltTmU2eVIrakJsbFViajhla1E1SHFEU05JVjJKRFly?=
 =?utf-8?B?bUZjWDFsbnZjZWpnZXA5elRVUXhLNmFPd0VBcnpDK1dKMndERUYwbmRHMFo2?=
 =?utf-8?B?TkF5d2M4NG5qdFp6emxMUGU5aXo5bEt2RHNvMXkwZGF5TFhyREtQQ2xaWHhu?=
 =?utf-8?B?VzhUWGtTT2FDdnB1RGdNNWo4UzdYUDZZNm1IeGRpWjEwM1hDVmxiSFZoVERs?=
 =?utf-8?B?ZTBjRlZOblFxK2cwdHZlWWsxaHA3S0RvbEdibkV1Q0dZdjhqSGpzRENPUmMv?=
 =?utf-8?B?NlRTeHNJeDRyUUU1NlpNRk12UlhBSG5lTTZuWFA1cDRQbnl3emdBSURwT2hx?=
 =?utf-8?B?d0NHWkNkL21JREc2MmZiR1NDKzl0MTIwQVRxa2dPdmlXRkJTeS91VGgxRytN?=
 =?utf-8?B?aHBvRjQzMUVtemV0V0RKR1FyYU1JYW45VlZmZnN3UmcvUFk5dEV4aHdieFUy?=
 =?utf-8?B?TkI3YVhhN0RPWEFRYjhvV2pBUlF2bFBIMDBiUmFuNGlNMjdzd1VVdkw5MElp?=
 =?utf-8?B?TVhNZzQrbHcrRjRUQmRnOWFvM2NaY3hnMWx2Y1RIUzR4UU9ZTlFDYVlxc1pC?=
 =?utf-8?B?dTVEc1dPWmFtVGk0Tk1UZVZsRytnb2NqM1N3T0NKVmd2NHIvRWpmRUJPdXp3?=
 =?utf-8?B?dVJYNmxVZmhjc2FZTzBxMTVjaytWSVJ0QkN1WXBiSnJLV3lEZFVTZjJFTFoy?=
 =?utf-8?B?dXVpWUQ4THZNMkE5UlJid0NTU3FlMklId3pKOStBL0RCRHJRZjVYSC82RXMx?=
 =?utf-8?B?WGJGUE4zK1NBRElkSUN0UTN6K0pOdnF6QmNkWkJTak01aVhGVElZVFpJdVpp?=
 =?utf-8?B?emhnL0MrblZQSDdTTU1uRlhHL05WODlRSnhLSHZhQjB3OXIrR0FzYWJIMDh1?=
 =?utf-8?B?OHdIZUp0NHpXZnNPaGRkTnZ0NDlwZnVRVm14SDZ4YXdzd2FpQ3NnQkNwZjZW?=
 =?utf-8?B?WE5GRi9Qbm1KT1VmWUEvWnhydFJ1bnlKUWFjVXJtcGxteHp6cmF2cmZGQWRn?=
 =?utf-8?B?aDYwU1FWS3FmdTl3cG9IVHBBNmdNUmtjejUzRWNjSG9iMHppK0prdWZyRktS?=
 =?utf-8?B?Q0dNcUVjaDU0NG9BazJjY280a0F6UnNKdUpsT2J3Si9iNWlYQWxKYmg5NzZ6?=
 =?utf-8?B?L1l4QnRHMXkwRlA1UDRxM0s2NmF2VmpmaFJDSVNTT0M3SDJPMHcvV0JXb2o1?=
 =?utf-8?B?NWsxZ0NmQWdZN3pwaGcySVJSdVFNTTRjS2ZGeUZ0VHhtNGxsajd2eHF2WjFu?=
 =?utf-8?B?cS9OdkJLdmxWOURqUDlXbURuQ05ab2lTakxyQTlIU3YzWDNUalN6T2o1SzVy?=
 =?utf-8?B?TnB1a3VhdDFkaWZpaGo2S2xnZnhDeXpRL2V2dnA0MHJOdnpmS1p4NzlmK1Qv?=
 =?utf-8?Q?EAhan8dD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 12:54:30.3876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f2a9e6-f88f-4371-514b-08d8b2423557
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ep/YPN7JMomQBJ7qavgUxLiG+vZqR7ga0sF0v3nMJFA03dGBxx09TmuaXM/XnfKW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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

QW0gMDYuMDEuMjEgdW0gMTM6NDcgc2NocmllYiBKb3NodWEgQXNodG9uOgo+Cj4KPiBPbiAxLzYv
MjEgNzo1MiBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDUuMDEuMjEgdW0gMjM6
MzEgc2NocmllYiBKb3NodWEgQXNodG9uOgo+Pj4gT24gMS81LzIxIDEwOjEwIFBNLCBBbGV4IERl
dWNoZXIgd3JvdGU6Cj4+Pj4gT24gVHVlLCBKYW4gNSwgMjAyMSBhdCA1OjA1IFBNIEpvc2h1YSBB
c2h0b24gPGpvc2h1YUBmcm9nZ2kuZXM+IHdyb3RlOgo+Pj4+Pgo+Pj4+PiBTaW5jZSBjb21taXQg
MjQ1NjI1MjM2ODhiICgiUmV2ZXJ0ICJkcm0vYW1kL2FtZGdwdTogc2V0IGd0dCBzaXplCj4+Pj4+
IGFjY29yZGluZyB0byBzeXN0ZW0gbWVtb3J5IHNpemUgb25seSIiKSwgdGhlIEdUVCBzaXplIHdh
cyBsaW1pdGVkIGJ5Cj4+Pj4+IDNHaUIgb3IgVlJBTSBzaXplLgo+Pj4+Cj4+Pj4gVGhlIGNvbW1p
dCBpbiBxdWVzdGlvbiB3YXMgdG8gZml4IGEgaGFuZyB3aXRoIGNlcnRhaW4gdGVzdHMgb24gQVBV
cy4KPj4+PiBUaGF0IHNob3VsZCBiZSB0ZXN0ZWQgYWdhaW4gYmVmb3JlIHdlIHJlLWVuYWJsZSB0
aGlzLsKgIElmIGl0IGlzIGZpeGVkLAo+Pj4+IHdlIHNob3VsZCBqdXN0IHJldmVydCB0aGUgcmV2
ZXJ0IHJhdGhlciB0aGFuIHNwZWNpYWwgY2FzZSBkR1BVcy4KPj4+Pgo+Pj4+IEFsZXgKPj4+Pgo+
Pj4KPj4+IEkgdGhpbmsgdGhlIGNvbW1pdCBiZWZvcmUgdGhlIHJldmVydCAoYmE4NTFlZWQ4OTVj
KSBoYXMgc29tZSAKPj4+IGZ1bmRhbWVudGFsIHByb2JsZW1zOgo+Pj4KPj4+IEl0IHdhcyBhbHdh
eXMgc3BlY2lmeWluZyBtYXgoM0dpQiwgMy80dGhzIFJBTSkgb2YgR1RULCBldmVuIGlmIHRoYXQg
Cj4+PiB3b3VsZG4ndCBmaXQgaW50byBzYXksIDFHaUIgb3IgMkdpQiBvZiBhdmFpbGFibGUgUkFN
Lgo+Pj4KPj4+IExpbWl0aW5nIEdUVCB0byBtaW4obWF4KDNHaUIsIFZSQU0pLCAzLzR0aHMgUkFN
KSBzaXplIG9uIGRHUFVzIG1ha2VzIAo+Pj4gc2Vuc2UgYWxzbyBhbmQgaXMgYSBzZW5zaWJsZSBs
aW1pdCB0byBhdm9pZCBzaWxseSBzaXR1YXRpb25zIHdpdGggCj4+PiBvdmVyYWxsb2NhdGlvbiBh
bmQgcG90ZW50aWFsIE9PTS4KPj4+Cj4+PiBUaGlzIHBhdGNoIHNvbHZlcyBib3RoIG9mIHRob3Nl
IGlzc3Vlcy4KPj4KPj4gTm8sIEFsZXggaXMgcmlnaHQgdGhpcyBhcHByb2FjaCB3YXMgYWxyZWFk
eSB0cmllZCBhbmQgaXQgY2F1c2VzIAo+PiBwcm9ibGVtcy4KPj4KPj4gQWRkaXRpb25hbCB0byB0
aGF0IHdoeSBzaG91bGQgdGhpcyBiZSBhbiBpc3N1ZT8gRXZlbiB3aGVuIFZSQU0gaXMgCj4+IHZl
cnkgc21hbGwgb24gQVBVcyB3ZSBzdGlsbCB1c2UgM0dpQiBvZiBHVFQuCj4+Cj4+IFJlZ2FyZHMs
Cj4+IENocmlzdGlhbi4KPgo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgM0dpQiBvZiBHVFQgaXNuJ3Qg
ZW5vdWdoIGZvciBtb3N0IG1vZGVybiBnYW1lcy4KCllvdSBzZWVtIHRvIG1pc3VuZGVyc3RhbmQg
d2hhdCB0aGUgR1RUIHNpemUgbWVhbnMgaGVyZS4gVGhpcyBpcyB0aGUgCmFtb3VudCBvZiBtZW1v
cnkgYW4gYXBwbGljYXRpb24gY2FuIGxvY2sgZG93biBpbiBhIHNpbmdsZSBjb21tYW5kIApzdWJt
aXNzaW9ucy4KCkl0IGlzIHN0aWxsIHBvc3NpYmxlIGZvciB0aGUgZ2FtZSB0byB1c2UgYWxsIG9m
IHN5c3RlbSBtZW1vcnkgZm9yIAp0ZXh0dXJlcyBldGMuLi4gaXQgY2FuIGp1c3QgaGFwcGVuIHRo
YXQgc29tZSBidWZmZXJzIGFyZSB0ZW1wb3JhcnkgCm1hcmtlZCBhcyBpbmFjY2Vzc2libGUgZm9y
IHRoZSBHUFUuCgo+IE15IGxhcHRvcCBoYXMgYSAxMjhNaUIgY2FydmVvdXQgd2hpY2ggaXMgbm90
IHBvc3NpYmxlIHRvIGJlIGNvbmZpZ3VyZWQgCj4gaW4gdGhlIEJJT1Mgc28gSSBhbSBzdHVjayB3
aXRoIHRoYXQgc2l6ZSB3aXRob3V0IGV4dHJhIGtlcm5lbCAKPiBwYXJhbWV0ZXJzIHdoaWNoIHNo
b3VsZG4ndCBiZSBuZWNlc3NhcnkuCgpEaWQgeW91IHJhbiBpbnRvIHByb2JsZW1zIHdpdGhvdXQg
dGhlIHBhcmFtZXRlcj8KCj4KPiBJZiB5b3UgZGlzbGlrZSB0aGUgYXBwcm9hY2ggb2Yga2VlcGlu
ZyB0aGUgZXh0cmEgY2hlY2sgZm9yIGRHUFVzIGFuZCAKPiBsaW1pdGluZyBHVFQgdGhlcmUsIHRo
ZW4gSSB3b3VsZCBzYXkgdGhhdCB3ZSBzaG91bGQgdXNlCj4gwqDCoMKgwqBndHRfc2l6ZSA9IDMv
NHRocyBzeXN0ZW0gbWVtb3J5Cj4gZm9yIGFsbCBkZXZpY2VzIGluc3RlYWQgb2YKPiDCoMKgwqDC
oGd0dF9zaXplID0gbWF4KDMvNHRocyBzeXN0ZW0gbWVtb3J5LCAzR2lCKQo+IGFzIGl0IHdhcyBi
ZWZvcmUgdGhlIHJldmVydCwgYXMgaXQgaXMgcHJvYmxlbWF0aWMgb24gc3lzdGVtcyB3aXRoIDwg
Cj4gM0dpQiBvZiBzeXN0ZW0gbWVtb3J5LgoKWWVhaCwgdGhhdCdzIGluZGVlZCBub3QgYSBnb29k
IGlkZWEuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gLSBKb3NoaWUg8J+QuOKcqAo+Cj4+Cj4+
Pgo+Pj4gLSBKb3NoaWUg8J+QuOKcqAo+Pj4KPj4+Pgo+Pj4+Pgo+Pj4+PiBUaGlzIGlzIHByb2Js
ZW1hdGljIG9uIEFQVXMsIGVzcGVjaWFsbHkgd2l0aCBhIHNtYWxsIGNhcnZlb3V0Cj4+Pj4+IHdo
aWNoIGNhbiBiZSBhcyBsb3cgYXMgYSBmaXhlZCAxMjhNaUIsIGFzIHRoZXJlIHdvdWxkIGJlIHZl
cnkgYSAKPj4+Pj4gbGltaXRlZAo+Pj4+PiAzR2lCIGF2YWlsYWJsZSBmb3IgdmlkZW8gbWVtb3J5
Lgo+Pj4+PiBUaGlzIG9idmlvdXNseSBkb2VzIG5vdCBtZWV0IHRoZSBkZW1hbmRzIG9mIG1vZGVy
biBhcHBsaWNhdGlvbnMuCj4+Pj4+Cj4+Pj4+IFRoaXMgcGF0Y2ggbWFrZXMgaXQgc28gdGhlIEdU
VCBzaXplIGhldXJpc3RpYyBhbHdheXMgdXNlcyAzLzR0aHMgb2YKPj4+Pj4gdGhlIHN5c3RlbSBt
ZW1vcnkgc2l6ZSBvbiBBUFVzIChsaW1pdGluZyB0aGUgc2l6ZSBieSAzR2lCL1ZSQU0gc2l6ZQo+
Pj4+PiBvbmx5IG9uIGRldmljZXMgd2l0aCBkZWRpY2F0ZWQgdmlkZW8gbWVtb3J5KS4KPj4+Pj4K
Pj4+Pj4gRml4ZXM6IDI0NTYyNTIzNjg4YiAoIlJldmVydCBkcm0vYW1kL2FtZGdwdTogc2V0IGd0
dCBzaXplIAo+Pj4+PiBhY2NvcmRpbmcgdG8KPj4+Pj4gc3lzdGVtIG1lbW9yeSBzaXplIG9ubHki
KQo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3NodWEgQXNodG9uIDxqb3NodWFAZnJvZ2dp
LmVzPgo+Pj4+PiAtLS0KPj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rydi5jIHzCoCA1ICsrKy0tCj4+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYyB8IDEyICsrKysrKysrKy0tLQo+Pj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgCj4+Pj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+Pj4+IGluZGV4IDcyZWZkNTc5ZWM1ZS4u
YTVhNDFlOTI3MmQ2IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jCj4+Pj4+IEBAIC0xOTIsOCArMTkyLDkgQEAgbW9kdWxlX3BhcmFtX25hbWVkKGdh
cnRzaXplLCBhbWRncHVfZ2FydF9zaXplLCAKPj4+Pj4gdWludCwgMDYwMCk7Cj4+Pj4+Cj4+Pj4+
IMKgIC8qKgo+Pj4+PiDCoMKgICogRE9DOiBndHRzaXplIChpbnQpCj4+Pj4+IC0gKiBSZXN0cmlj
dCB0aGUgc2l6ZSBvZiBHVFQgZG9tYWluIGluIE1pQiBmb3IgdGVzdGluZy4gVGhlIAo+Pj4+PiBk
ZWZhdWx0IGlzIC0xIChJdCdzIFZSQU0gc2l6ZSBpZiAzR0IgPCBWUkFNIDwgMy80IFJBTSwKPj4+
Pj4gLSAqIG90aGVyd2lzZSAzLzQgUkFNIHNpemUpLgo+Pj4+PiArICogUmVzdHJpY3QgdGhlIHNp
emUgb2YgR1RUIGRvbWFpbiBpbiBNaUIgZm9yIHRlc3RpbmcuIFRoZSAKPj4+Pj4gZGVmYXVsdCBp
cyAtMSAoT24gQVBVcyB0aGlzIGlzIDMvNHRoCj4+Pj4+ICsgKiBvZiB0aGUgc3lzdGVtIG1lbW9y
eTsgb24gZEdQVXMgdGhpcyBpcyAzR2lCIG9yIFZSQU0gc2l6ZWQsIAo+Pj4+PiB3aGljaGV2ZXIg
aXMgYmlnZ2VyLAo+Pj4+PiArICogd2l0aCBhbiB1cHBlciBib3VuZCBvZiAzLzR0aCBvZiBzeXN0
ZW0gbWVtb3J5Lgo+Pj4+PiDCoMKgICovCj4+Pj4+IMKgIE1PRFVMRV9QQVJNX0RFU0MoZ3R0c2l6
ZSwgIlNpemUgb2YgdGhlIEdUVCBkb21haW4gaW4gbWVnYWJ5dGVzIAo+Pj4+PiAoLTEgPSBhdXRv
KSIpOwo+Pj4+PiDCoCBtb2R1bGVfcGFyYW1fbmFtZWQoZ3R0c2l6ZSwgYW1kZ3B1X2d0dF9zaXpl
LCBpbnQsIDA2MDApOwo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jIAo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYwo+Pj4+PiBpbmRleCA0ZDhmMTlhYjEwMTQuLjI5NGYyNmY0ZjMxMCAxMDA2NDQKPj4+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+Pj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+Pj4+PiBAQCAtMTg2
NSw5ICsxODY1LDE1IEBAIGludCBhbWRncHVfdHRtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
Cj4+Pj4+ICphZGV2KQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3Qgc3lzaW5mbyBzaTsKPj4+Pj4KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2lfbWVtaW5mbygmc2kpOwo+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
dHRfc2l6ZSA9IG1pbihtYXgoKEFNREdQVV9ERUZBVUxUX0dUVF9TSVpFX01CIDw8IAo+Pj4+PiAy
MCksCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGFkZXYtPmdtYy5tY192cmFtX3NpemUpLAo+Pj4+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKHVpbnQ2NF90
KXNpLnRvdGFscmFtICogCj4+Pj4+IHNpLm1lbV91bml0ICogMy80KSk7Cj4+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGd0dF9zaXplID0gKHVpbnQ2NF90KXNpLnRvdGFscmFtICog
c2kubWVtX3VuaXQgKiAzLzQ7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IElmIHdlIGhhdmUgZGVkaWNhdGVkIG1lbW9yeSwgbGltaXQgb3VyIEdUVCBzaXplIHRvCj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiAzR2lCIG9yIFZSQU0gc2l6ZSwgd2hp
Y2hldmVyIGlzIGJpZ2dlcgo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICov
Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghKGFkZXYtPmZsYWdzICYg
QU1EX0lTX0FQVSkpIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGd0dF9zaXplID0gCj4+Pj4+IG1pbihtYXgoQU1ER1BVX0RFRkFVTFRfR1RUX1NJ
WkVfTUIgPDwgMjAsCj4+Pj4+ICsgYWRldi0+Z21jLm1jX3ZyYW1fc2l6ZSksCj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Z3R0X3NpemUpOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqAgfQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ3R0X3NpemUgPSAodWludDY0X3QpYW1kZ3B1X2d0
dF9zaXplIDw8IDIwOwo+Pj4+PiAtLSAKPj4+Pj4gMi4zMC4wCj4+Pj4+Cj4+Pj4+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4+Pj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+Pj4+IGh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngm
YW1wO2RhdGE9MDQlN0MwMSU3Q2NocmlzdGlhbi5rb2VuaWclNDBhbWQuY29tJTdDODkwZjNmM2Ji
OTE0NDkyOWQ1MjMwOGQ4YjI0MTNhMzUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3NDU1MzQwNTIxNzkzOTg0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPWl4NXFNRUhYQyUyQmVPbHk0T2xnWjRtYkZQSUd6Mzdn
MEpQYXdIZmg0MTJ3RSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Pj4KPj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
