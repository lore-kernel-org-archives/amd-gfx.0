Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E03C12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 22:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71584613DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 22:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71584613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128966E9EB;
	Fri, 16 Jul 2021 22:14:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644E36E9E1;
 Fri, 16 Jul 2021 22:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTKdPjUgHhGYa+SsNBWfbCmgSAzukv+7obl8sKjiBf8j9kaOcnst/tk/7G0gV01EekOXtzGrEfVTyfPJU7yEGtCgI3OLHL/05DDdyQ6sM0V68ZbAMQFGdERkkJOwLkTJ/8ZcospVbm5cPspDiTfnLZt/bCgAgKFyFB6bZ8fcjdwBEEYqoawnFbib5LTXUoi+ZGK/LTx/1io1++Q2gwAG4J7ZEeBEIWlrHATj/plqEDS2BUPjen10gLcGeQ4hEqddZdZXzz5+fAidQ7yZyItEQ7tC9Trenh6G4P3xfP/HpIg1mgaiL5FYTO6T+GAkHAakYSM31g/00xQvjDizK7ddKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYwMnvBCCZkyWKZKoK22jlZaog6WNX4MDqTHopYpzuw=;
 b=O31pX2fsVysShag7/g9OzVx4sn79ctfdGmAfF6PlroNiyKzOoXfIWYRlJFvBGYDcJXcj4VD5puk7FPFWddJ+L9sTMDnypgIwV9ypKLPjnGKPRUtre5+996n8oQLSf35KNIuDJJ3DJ4J5M5IZ4iAV/R5ue3tQkxkjnckvQcyOmEEf3tt6eFftNyT6OKY2QVqX9+/2Wl6wukLvbqWYpcbCX5bv078Zt2F0VH96vMBwH9rLLXdQa9QPce8ZSH0HYuODB3/GEefV8Bb0JjE6jDrZHwCNaQnYyuKhvc+sFKzVxsTanm+9MAO1m4J95CQw6XePO+qSzntahEi70h2vZlvZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYwMnvBCCZkyWKZKoK22jlZaog6WNX4MDqTHopYpzuw=;
 b=LmYhsG9TEoctKy5nRMT5/YjaXi1aqczPBAvS2Gn0Vak7f8vCUZSIFwo6AUM2NjfCosJqxD9bJhN92gN+FyxC2wz2rLusYppQMSmNOE9SfO5fgevarIdCZWgJgtttpzHgO6LkoinpWHJcUVh1yekNgyrqYESnw1nU3OwqEq/4i28=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 16 Jul
 2021 22:14:07 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4331.027; Fri, 16 Jul 2021
 22:14:07 +0000
Subject: Re: [PATCH v3 0/8] Support DEVICE_GENERIC memory in migrate_vma_*
To: "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20210617151705.15367-1-alex.sierra@amd.com>
 <YM9NXrGlhdp0qb7S@mit.edu> <905418d1-9099-0ea8-a6e6-84cc8ef3d0b0@amd.com>
 <YPGgvNxfOCx/Sp0g@mit.edu>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e9cc27d6-b0f2-8379-c276-0bbdae3ce4d7@amd.com>
Date: Fri, 16 Jul 2021 18:14:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPGgvNxfOCx/Sp0g@mit.edu>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 22:14:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a64b23e-a7e4-4f3e-180a-08d948a7078a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5292111CBB7DF654322B4BAE92119@BN9PR12MB5292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTX+PGoNC7agqAp7YhVwHLo+MvK1Zc8PDvJ86dbpuyjCu1G0JdCK681HUX7YWyZpTVF86n/+y/GabqyGh5SFv5VmTw2X5/ElAG1KueOW8vP+L4T/6HZKJzjB/FzK9nvUEzW82jdkd36a9NByK7Xn/u5LnbLgjdfqLfZ2fQP+0mK4LubCFjdKW6zlVJEEzrhAHm5+gdW7hqlfNMTB472HwkeMr0c1o/tWWWvYaF0tAqDnwH+Qscc1LIZcl/I23dWz/k+v/UqeTIGPQQxUpADbfMie5BjtdV6pcZLf3iZVqCZt3OSQ3dt8O2a1hnxtf26A5iZEMkMROOFWmTabjVRxaX2rXf7EdDi+8bTfaIhv1NAQio1eAdUd6yH/BcrKLrnuJT6vakffgUmrehxALiAMRddyBLq5ZfgfqWqFaRdAEiMG1p+QEwhRzKBS6udoohVLtwL0y798ErQGLT55FCviObwv5MI606aB4irkd7O0KyQCpDdid0ZMyhDR4fOQNymRMZQuk/0JDF7RcnxnVGc6nCzTAUVOUOrD3nXjm2XG2wl469NWFxBBd/PkCHbm+rtXpGTsSCjCoo+eKqgel1epHN8khXXwqolkRcrrmO4tsaT341o9zBnZfA2rrrkWHpswptCQsLov2f8EYMS2CcXRdErOYISUahXMnaLogLQUIKL4LKaq3+/xRdLrK/SRk2xMdjzYHC80D21WXWTfV5qQqiEhgoyAJ77dP6+y0vcVfI8osqfOw8QnBDiJhWvTR/+7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(186003)(26005)(38100700002)(316002)(5660300002)(4326008)(478600001)(31686004)(8936002)(31696002)(16576012)(6486002)(66946007)(8676002)(66476007)(36756003)(83380400001)(2906002)(7416002)(44832011)(956004)(66556008)(86362001)(2616005)(6916009)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3p0ODg0TlhMTlh6V0FzZVVsMW5rc0wyNFdUNDM5RE9rdnFYNGcxTjE3S0ZV?=
 =?utf-8?B?Q2EwRlNCeER4UzVFbzR3NnNCUWJXRzBRUkhPMU81QTV1dU1VZHRqK2VQaFJH?=
 =?utf-8?B?VTNheFRMWGJOMGVjRHdHKzRKV1FqM2pLeE5Fc1pLLzIvdm1wNnlMTUtqL2Zj?=
 =?utf-8?B?V2gzSTdLNk1HempiYStuaFJkdllyN0pWYXp0cWEwdUY1eEM3OGhrN0lNZmJI?=
 =?utf-8?B?QTRVQ0Z0YU8xN2lKSFZDNnlJZnlRMUpubWtmSnNyb29xdFBJT3FaNEEwZTM3?=
 =?utf-8?B?K2RzRk5qS25zbjJ2UCt5SGs4cWVnbW5UU3BoVnhXMVgwd3dVY2tpZ09NUzIv?=
 =?utf-8?B?Z1F5N2JUVEFCWEtzQUxyZ0pGdW5maVlGUS9rRFhDT1VQbm1wVlhiUitKdzR3?=
 =?utf-8?B?SkcraEFMd0RoNzJJRlNGemtGWkNPSVdVc0NIQ3BiRjRhdzFTaVord2dkM3R6?=
 =?utf-8?B?ZzBXMjU3RUxtTUJjanBtZkRyVlRUdVpvSkxPSkh1UnJ0ZzlHSmZtcEFWN2JH?=
 =?utf-8?B?ZFh3WnF5ajNrZmFac05kOU1mSjhhWC9CVDJVVGFpSGVGdHVCdmlPQnU1eHRK?=
 =?utf-8?B?VS9IZWtaUVBOQldaVEFFbTRsUHd2UlVQMWc0dVBUL1EvWVFMOVJxbnBqSitB?=
 =?utf-8?B?NnNGUWhFOERDRWhpTVJpZzRUNXVrMk5RU1NFbXdibjRLb1JNcjlLR0wvZTg2?=
 =?utf-8?B?REZlSC9QUHU2dkZUSm5KZm9McWFka2Q5ajk0eERFMmllZDNOLy9aUmI2YXVn?=
 =?utf-8?B?UjRYbGM0UTdoSGZvZ09Bc2czQjdqVUdXMlpJV3RHdVlGWGkyTUxaVVNOd29v?=
 =?utf-8?B?SVhZc0lzTlE1YTc5Y1dTY0x6UUcxSTR2cFRPam9DVEc2T3Fsam1WY3RQMTRV?=
 =?utf-8?B?SU1qUE0xdWVTdTNFTHhoWjZCcEZTaWc4cmNBYzREelVjNnh5OHpTU2JDU2lP?=
 =?utf-8?B?NGNqZDlVQjdWMWI1TmxVNEpqLzNQK3NGSHBpamdSQjE0MlgxYjQ0QU01R290?=
 =?utf-8?B?RVBOQkdKSDZFM1RuKzdjNmt0dCtGd082akF0Rkp1a2tyaWZDUDZ4N1p1YUY1?=
 =?utf-8?B?MzZlNkpyTFRuR3N3YzRveGZpWXNNOGN4NzJ3cnJ3ckoxVWZ2SVpQQ0FPeFFD?=
 =?utf-8?B?dEtlT281SjRqMVlPY2Vmdkk2eXIvY2JucGM2WDZTUzBhZDdycEp0UGcrTXVk?=
 =?utf-8?B?ZU91ZDJCelEvQ1ZxVFVvVE1rdWJlOUNkRnVzb1hPM2xOcFBZOXRoNGxPT0xM?=
 =?utf-8?B?cTdsakYyQ3dMWEJ1azVhSEh0dDJxcy9ZcW0vL2h0TmlTQ3BXOWgraEhuTUxQ?=
 =?utf-8?B?VTR4WkswTjllVDU2QUU4M0FZNmRKK1hhSHVkb1lIU1drUW1zQm9LcnJXK0Mx?=
 =?utf-8?B?cXo2KzQrRlJMcWFSdjU3NFpDcUlnUERqNm96M25qQ3RYYU1Hd0g3SGFkSG9U?=
 =?utf-8?B?R2phRjlUY2Z1eG9ZRUFnelhpNkxSc3hqWDg3ZEpNc2Y0RVlRa2RpZThkOEY1?=
 =?utf-8?B?ZDZackxyRHdFc0dYcmtGRmc0amV2TFNYYTY5RlNUMWlUTWxvcU9tcTMxQWhM?=
 =?utf-8?B?MWFOVU41R2kxWVh2YkhVcWdLa2N6a2RLUXI2TVBjK3pkcHYyaStjZlRhM1Vk?=
 =?utf-8?B?K1M4di8wNnBXR3lrOE13SUErR3pxNnliWVRpd2Y5ODJaV1FLT3ZuL3JLb0k4?=
 =?utf-8?B?L2lWTnNaL1g4VGxRWFNhSGJ2MGxEd21LZ0RsYnRscUFwSms0WStja3JXMjlo?=
 =?utf-8?Q?JvejKuem3ZEi5T7KR78YH0a27y4xKJ8KkQP3cft?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a64b23e-a7e4-4f3e-180a-08d948a7078a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 22:14:07.4955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JmDmDY2VvhfFXLu38rSRxx4huRKkoVG9gTRr3Il06n3cPiT2cx2AFuCTmJ8c/HILEl08UdU9y8u9bHsu+tTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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
Cc: Alex Sierra <alex.sierra@amd.com>, rcampbell@nvidia.com,
 amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, dri-devel@lists.freedesktop.org, jgg@nvidia.com,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNy0xNiB1bSAxMTowNyBhLm0uIHNjaHJpZWIgVGhlb2RvcmUgWS4gVHMnbzoKPiBP
biBXZWQsIEp1biAyMywgMjAyMSBhdCAwNTo0OTo1NVBNIC0wNDAwLCBGZWxpeCBLdWVobGluZyB3
cm90ZToKPj4gSSBjYW4gdGhpbmsgb2YgdHdvIHdheXMgdG8gdGVzdCB0aGUgY2hhbmdlcyBmb3Ig
TUVNT1JZX0RFVklDRV9HRU5FUklDIGluCj4+IHRoaXMgcGF0Y2ggc2VyaWVzIGluIGEgd2F5IHRo
YXQgaXMgcmVwcm9kdWNpYmxlIHdpdGhvdXQgc3BlY2lhbCBoYXJkd2FyZSBhbmQKPj4gZmlybXdh
cmU6Cj4+Cj4+IEZvciB0aGUgcmVmZXJlbmNlIGNvdW50aW5nIGNoYW5nZXMgd2UgY291bGQgdXNl
IHRoZSBkYXggZHJpdmVyIHdpdGggaG1lbSBhbmQKPj4gdXNlIGVmaV9mYWtlX21lbSBvbiB0aGUg
a2VybmVsIGNvbW1hbmQgbGluZSB0byBjcmVhdGUgc29tZSBERVZJQ0VfR0VORVJJQwo+PiBwYWdl
cy4gSSdtIG9wZW4gdG8gc3VnZ2VzdGlvbnMgZm9yIGdvb2QgdXNlciBtb2RlIHRlc3RzIHRvIGV4
ZXJjaXNlIGRheAo+PiBmdW5jdGlvbmFsaXR5IG9uIHRoaXMgdHlwZSBvZiBtZW1vcnkuCj4gU29y
cnkgZm9yIHRoZSB0aHJlYWQgbmVjcm9tYW5jeSwgYnV0IG5vdyB0aGF0IHRoZSBtZXJnZSB3aW5k
b3cgaXMKPiBwYXN0Li4uLgoKTm8gd29ycmllcy4gQWxlamFuZHJvIHNob3VsZCBoYXZlIGEgbmV3
IHZlcnNpb24gb2YgdGhpcyBzZXJpZXMgaW4gYSBmZXcKZGF5cywgd2l0aCB1cGRhdGVzIHRvIGht
bV90ZXN0IGFuZCBzb21lIGZpeGVzLgoKCj4KPiBUb2RheSBJIHRlc3QgZXh0NCdzIGRheCBzdXBw
b3J0LCB3aXRob3V0IGhhdmluZyBhbnkgJCQkIERBWCBoYXJkd2FyZSwKPiBieSB1c2luZyB0aGUg
a2VybmVsIGNvbW1hbmQgbGluZSAibWVtbWFwPTRHITlHOm1lbW1hcD05RyExNEciIHdoaWNoCj4g
cmVzZXJ2ZXMgbWVtb3J5IHNvIHRoYXQgY3JlYXRlcyB0d28gcG1lbSBkZXZpY2UgYW5kIHRoZW4g
SSBydW4KPiB4ZnN0ZXN0cyB3aXRoIERBWCBlbmFibGVkIHVzaW5nIHFlbXUgb3IgdXNpbmcgYSBH
b29nbGUgQ29tcHV0ZSBFbmdpbmUKPiBWTSwgdXNpbmcgVEVTVF9ERVY9L2Rldi9wbWVtMCBhbmQg
U0NSQVRDSF9ERVY9L2Rldi9wbWVtMS4KPgo+IElmIHlvdSBjYW4gZ2l2ZSBtZSBhIHJlY2lwZSBm
b3Igd2hhdCBrZXJuZWwgY29uZmlncyBJIHNob3VsZCBlbmFibGUsCj4gYW5kIHdoYXQgbWFnaWMg
a2VybmVsIGNvbW1hbmQgbGluZSBhcmd1bWVudHMgdG8gdXNlLCB0aGVuIEknZCBiZSBhYmxlCj4g
dG8gdGVzdCB5b3VyIHBhdGNoIHNldCB3aXRoIGV4dDQuClRoYXQgd291bGQgYmUgZ3JlYXQhCgpS
ZWdhcmRpbmcga2VybmVsIGNvbmZpZyBvcHRpb25zLCBpdCBzaG91bGQgYmUgdGhlIHNhbWUgYXMg
d2hhdCB5b3UncmUKdXNpbmcgZm9yIERBWCB0ZXN0aW5nIHRvZGF5LiBXZSdyZSBub3QgY2hhbmdp
bmcgb3IgYWRkaW5nIGFueSBLY29uZmlnCm9wdGlvbnMuIEJ1dCBsZXQgbWUgdGFrZSBhIHN0YWI6
CgpaT05FX0RFVklDRQpITU1fTUlSUk9SCk1NVV9OT1RJRklFUgpERVZJQ0VfUFJJVkFURSAobWF5
YmUgbm90IG5lZWRlZCBmb3IgeW91ciB0ZXN0KQpGU19EQVgKCkknbSBub3Qgc3VyZSB3aGF0IHlv
dSdyZSBsb29raW5nIGZvciBpbiB0ZXJtcyBvZiBrZXJuZWwgY29tbWFuZCBsaW5lLApvdGhlciB0
aGFuIHRoZSBtZW1tYXAgb3B0aW9ucyB5b3UgYWxyZWFkeSBmb3VuZC4gVGhlcmUgYXJlIHNvbWUg
bW9yZQpvcHRpb25zIHRvIHJ1biBobW1fdGVzdCB3aXRoIGZha2UgU1BNIChERVZJQ0VfR0VORVJJ
QykgbWVtb3J5LCBidXQgd2UncmUKYWxyZWFkeSBydW5uaW5nIHRoYXQgb3Vyc2VsdmVzLiBUaGF0
IHdpbGwgYWxzbyBiZSBpbiB0aGUgbmV4dCByZXZpc2lvbgpvZiB0aGlzIHBhdGNoIHNlcmllcy4K
CklmIHlvdSBjYW4gcnVuIHlvdXIgeGZzdGVzdHMgd2l0aCBEQVggb24gdG9wIG9mIHRoaXMgcGF0
Y2ggc2VyaWVzLCB0aGF0CndvdWxkIGJlIHZlcnkgaGVscGZ1bC4gVGhhdCdzIHRvIG1ha2Ugc3Vy
ZSB0aGUgWk9ORV9ERVZJQ0UgcGFnZSByZWZjb3VudApjaGFuZ2VzIGRvbid0IGJyZWFrIERBWC4K
ClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+IENoZWVycywKPgo+IAkJCQkJCS0gVGVkCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
