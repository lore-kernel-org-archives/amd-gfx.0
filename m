Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF781C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 16:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9398761209
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 16:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9398761209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC506EC34;
	Tue, 18 May 2021 16:33:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DED6EC33;
 Tue, 18 May 2021 16:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnuwb0BllsvZzJxsAeK6QdVRtnJk3FMOLLDHZ+YFEE6wxh9/TH98arv9xGUER+P/NGOIdcs13ugKAWY3uUTTGuRGcqAkfPUSp8x6cHt3NJbUqOfzY0IuNNkNf0qR9SNJrCObVfSTsE8JdrdTbBV0UTGIICzpOjChOE+/Ft7o0hByeVh4OyAh9JyvyqpxIDYoSa+OKovjQiYXO6wcKFLy/1zJE5iD60LCod2/r8hjyJqLsQpRDvMmaxbsGbcDFC3nhXHXGs5mBQGuc5D8UZO57ZprSlLv8+LXw3b27ygTaRsLdD2QM8X2G15s5SwYtkXG72BrE+GjuCUHB6kdJNERTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcxouU7wHgBqvHm1nzxBfqyKnh8fCU8FG5L6WbDVhro=;
 b=R0oKPjExwTbXeHX13b4QMDf/H5uytGM/MYrLd1p9AlEXQdjrZvld4ZbmILMVCs2lue6zbcNbNxCDx/rfdkcIvX5aNmzV4K/AXnHe/6UpMkBAsccKyTUeEo8ePjxBZba5WA6x9+cxyoUQFpDBzTDZ2AXjRl0dGVtL7XgmpcL0JUdeC2L21GOEztci3Ede4gF2nc9bUWxI0IugSYWDEv26RrbAk+akckcTDNikJqllo0v4dCOLzfRnP8iMSRkHVlYgpLb0epQWae2OyYfr8bSIlgviCrxP8oJ62JvyKdlQyb6fcXee+KlIcABxUBuqfaDsCtgfjMWx52JsKmLn36PzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcxouU7wHgBqvHm1nzxBfqyKnh8fCU8FG5L6WbDVhro=;
 b=RGhDwPix5sjNqmJOlYM7Blsdl/CT5ECNUs4EUl1nAmXB/kDtN6ByWii6cD2zXksRR1JO+7z8H1Xa5ZgUI+zH3RGsrjmkJzqW/uWBjQuqdfVKZljHSmPgfmVXpCEKHoU9dH1bjAP0R8Uy8+t+PsspVPJyxAa6HjC6ym0awrlhr+0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4784.namprd12.prod.outlook.com (2603:10b6:208:39::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Tue, 18 May
 2021 16:33:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 16:33:44 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
Date: Tue, 18 May 2021 18:33:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:88c7:d7d9:22ef:f850]
X-ClientProxiedBy: AM0PR02CA0127.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:88c7:d7d9:22ef:f850]
 (2a02:908:1252:fb60:88c7:d7d9:22ef:f850) by
 AM0PR02CA0127.eurprd02.prod.outlook.com (2603:10a6:20b:28c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 16:33:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e27cb356-511e-4684-99ac-08d91a1ab3c9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB47844BBBF67AE55EE509E527832C9@MN2PR12MB4784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yoczC9DRlHjOHSw+T4zRNmAT4aR2dM2dS8wLLnkRqdIOSm6h+PyHLJ1DmPL+6lVjZZ7CBEcXX1X0AkE3j4fCSg4RB45KsVphzaiOhc4qBqVua+698ieY7R7F1POV991rclmft244qu02HosxLb5pVfDlqz64wJ5s5iGxGs/GgCgOBofEVapUQb+dYEf5CWnoS63WeU+Uz9OBJH4jzUk3FU42eZWdleg1Cz1GLy9Rcr7SjlTaONPZkdFyZ3K6E3++gF6COlyV27mE0acNL9wQSwiNeMCkGTzXZAkARxUjjVcaKI4noKVM6jVTjT7wdva0dywjUyHMEcSxztKyM/vcUXCF/02zhbhHYPjkRjGVqpcszvPU09s6F4hwTR6iTi7/Lb73fCWbMQ2Jk++7pSdxRm3vLdzIRxUHoQsXOk+b9fzxhfUgTtUBYrej3C1QM8gN4nSGYQ+rskiyzTmLozq81PGkUJ+CnLclfJarzsB8SjxpDfL29R0ErtpPjd4pKnT5YZQrWH10khxeulSbIeKrBKaDnDvPmeAS7LrDieYkQXpC0O2AnHNQrRbWJUc0++vthDJjZkyPRF5rJ8ZAnhLHivMQjnU8qnNNnx44hpJaIeQ170vO1vb+pWA+P4HMUMTRYZ/QMq7ad6vSELsmwhGxAi/AtCIgFhmzfGMlcmZWhLh6499PKikCIdXmiBr3nzS6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(66574015)(83380400001)(52116002)(6636002)(16526019)(186003)(6666004)(6486002)(31696002)(31686004)(8676002)(66476007)(478600001)(36756003)(66556008)(2906002)(66946007)(316002)(86362001)(38100700002)(5660300002)(4326008)(2616005)(8936002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WElFN0VNUXdEcEJWeFZ0Q2lsT0ZvRWgwYjc1R1IrZlR6aHFwMlhnaFBxZk5F?=
 =?utf-8?B?bVF1eFJrbkxOWUVBdDZtVW9zQis1NU80S01hOFJoOXkwZnBLS3dpdm9vQlRt?=
 =?utf-8?B?RmNqMEZkWXNNS1MrVkFyanBkUUlQRnhXcEl6RFd3bW9HYUZDbGViMlZTTURn?=
 =?utf-8?B?emR1VmtPWWFad3ZUMHVXa2orMWdQelp0Smk4cGJvd0FsMldycVVjZmt4Z3JT?=
 =?utf-8?B?NHdNb2Y3S1RpajdXNmxQQTUyZUh0N0lBenNNNldGNW1yWlZrcjVnRUFxUnI0?=
 =?utf-8?B?c1YwZm04Z3JBN3ZhVDV3OGpNbkhrT2dDVVNJWHZPdytuUDYvWmR2K1Q3T2xu?=
 =?utf-8?B?MVRsTDJJRnJhMk5zQWt6a0pRdE5Ua0phUGtML3dnS3E2NGJNUG0wQjIyQ2tN?=
 =?utf-8?B?SllUWG9hYVpoN0lCNUFaMHAvWFYyNTNOZWwvdy81Ym96c1N4RDN5dWZpMCtR?=
 =?utf-8?B?eUUwU0thRHN1Rm0xL0FZVDZ3VWVwampOTGs3bjJsZDdHMTREemdBSUl3RXg0?=
 =?utf-8?B?czA5Ni84MW1TblI5OVFTSk1EVHRmTzIvOGhFM2NJQStaTHI0TWJYbElxV29J?=
 =?utf-8?B?RkVVK1lEa0NXNFV3NmdNeXZsc29oTENLTEJKMGF5OUROYitXTnBHam9HdXBh?=
 =?utf-8?B?UnRnUlM2MGpiZEJLbWUxdmlEclVEUFNDL2htMllpUStxNDNGRjNudDVFNUR4?=
 =?utf-8?B?TnFkcEhWQXRHZjI4dS82SVpQSjAwMzlFQUR6MEpyN1FuZHBQajQzcXRHRktu?=
 =?utf-8?B?Qmt6VUdJNkd2Y2FDc0dhbStEdGhiVjB0b3d2bWJFRFlRQW8vQkdzRVVaRFdL?=
 =?utf-8?B?QTRINWdHbkN0bVo0cWVFZnZEcDQ4MlAxYlNGUFdmM2kzM3Z6ZEdFbzdiR3Yx?=
 =?utf-8?B?ZzN1SUtsd2NqUTFUcktVdzFXaURqbzJ2UHVHaU96MW9WR3dMdzR6S3BHU3NM?=
 =?utf-8?B?VUJJR1dXdzN5WGx2NVd3MUVKeStrTThxRjZjanBuTUNPQUdheDk3NEgvZEdK?=
 =?utf-8?B?NHYveDQ5K3BITGcxcWgzeEc4WXAxTlVuWUgxbVphOWVKUUZKSHNzN2xiV1RR?=
 =?utf-8?B?NGR0S3lTUjFqSGhrOXo3Z0ZHem1sYXBVd0VHR0ZpVWdCY3NLbm5UMzVURGxp?=
 =?utf-8?B?THFraGx4SWNHSkVUb2VEaUlZMlhNcVhVN3NZTVQ3dDVLS1ltRTdaellESkFq?=
 =?utf-8?B?ZDEwbndEdEZ2bllTbWhkSW05eWtBbENPbTVkYVIvUjVIc2dMT2hYUUgrM0wx?=
 =?utf-8?B?bnZoRnFXVlBvOHRibFRsaXphZDVQS0orUlhYY3dOeWVobkNxZ2tzRTVNZkVP?=
 =?utf-8?B?aGVRS1J5b0FFNVBPK1pTZlp0K3hUZmNIRHlnVUVFTU9qdnZ0S0xVUHR4dzdV?=
 =?utf-8?B?ODRmMWxhNmM2anBkaWNLRHVNUlkzbm9LVHpzSklDamFoeWNaejZORHllYkY1?=
 =?utf-8?B?a2RpRzY1dG10MWxNZFVlVGp5eDZOTWlqc0JvRko3aDNPTzRFKy9XMFdWb2I3?=
 =?utf-8?B?RzBUUHBNN0ZPMW9ZbzFpRmNNejgyREN2anp3Q1VEeFJPcXYzVExPYmNHNUor?=
 =?utf-8?B?QlhseC9SRWFjTVVPTVcvK05tZ3phUlFXV1Axa2ltLzQ0SmJHN2hDRkZINDdL?=
 =?utf-8?B?My9QVm83eWRhd3lBcHhlWWs3TDVVektZdzFaamRyQ1ZubVNBamVTbzd6R2lh?=
 =?utf-8?B?T0VXa0xoT1VKVytnUVpOU3BBZDdpektieURkdGNlenl6cW5tdE5QY3JPeFc5?=
 =?utf-8?B?ampPMTIxWHdpOVRLSTRMVVZmVzBhMXR5UnF2a3NQNFdNaUF3ODJUQWo4M0kx?=
 =?utf-8?B?MFltVFZ2UndSUkVRUlhMdC95RWZBUWNLZXEvQWpVMUhQU211QlVrTCtOdllE?=
 =?utf-8?Q?kcMG98PtGIJdC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27cb356-511e-4684-99ac-08d91a1ab3c9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 16:33:43.9420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc0H5tMwWsf/DXeEh0Ubgo9sTovWSmtRj+g6D747vQPWlO9oLoepCe1RVP2YhwdZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4784
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDUuMjEgdW0gMTg6MTcgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+Cj4gT24g
MjAyMS0wNS0xOCAxMToxNSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxOC4w
NS4yMSB1bSAxNzowMyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4KPj4+IE9uIDIwMjEt
MDUtMTggMTA6MDcgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBJbiBhIHNlcGFy
YXRlIGRpc2N1c3Npb24gd2l0aCBEYW5pZWwgd2Ugb25jZSBtb3JlIGl0ZXJhdGVkIG92ZXIgdGhl
IAo+Pj4+IGRtYV9yZXN2IHJlcXVpcmVtZW50cyBhbmQgSSBjYW1lIHRvIHRoZSBjb25jbHVzaW9u
IHRoYXQgdGhpcyAKPj4+PiBhcHByb2FjaCBoZXJlIHdvbid0IHdvcmsgcmVsaWFibGUuCj4+Pj4K
Pj4+PiBUaGUgcHJvYmxlbSBpcyBhcyBmb2xsb3dpbmc6Cj4+Pj4gMS4gZGV2aWNlIEEgc2NoZWR1
bGVzIHNvbWUgcmVuZGVyaW5nIHdpdGggaW50byBhIGJ1ZmZlciBhbmQgZXhwb3J0cyAKPj4+PiBp
dCBhcyBETUEtYnVmLgo+Pj4+IDIuIGRldmljZSBCIGltcG9ydHMgdGhlIERNQS1idWYgYW5kIHdh
bnRzIHRvIGNvbnN1bWUgdGhlIHJlbmRlcmluZywgCj4+Pj4gZm9yIHRoZSB0aGUgZmVuY2Ugb2Yg
ZGV2aWNlIEEgaXMgcmVwbGFjZWQgd2l0aCBhIG5ldyBvcGVyYXRpb24uCj4+Pj4gMy4gZGV2aWNl
IEIgaXMgaG90IHBsdWdnZWQgYW5kIHRoZSBuZXcgb3BlcmF0aW9uIGNhbmNlbGVkL25ld2VyIAo+
Pj4+IHNjaGVkdWxlZC4KPj4+Pgo+Pj4+IFRoZSBwcm9ibGVtIGlzIG5vdyB0aGF0IHdlIGNhbid0
IGRvIHRoaXMgc2luY2UgdGhlIG9wZXJhdGlvbiBvZiAKPj4+PiBkZXZpY2UgQSBpcyBzdGlsbCBy
dW5uaW5nIGFuZCBieSBzaWduYWxpbmcgb3VyIGZlbmNlcyB3ZSBydW4gaW50byAKPj4+PiB0aGUg
cHJvYmxlbSBvZiBwb3RlbnRpYWwgbWVtb3J5IGNvcnJ1cHRpb24uCj4KPiBCeSBzaWduYWxpbmcg
c19mZW5jZS0+ZmluaXNoZWQgb2YgdGhlIGNhbmNlbGVkIG9wZXJhdGlvbiBmcm9tIHRoZQo+IHJl
bW92ZWQgZGV2aWNlIEIgd2UgaW4gZmFjdCBjYXVzZSBtZW1vcnkgY29ycnVwdGlvbiBmb3IgdGhl
IHVuY29tcGxldGVkCj4gam9iIHN0aWxsIHJ1bm5pbmcgb24gZGV2aWNlIEEgPyBCZWNhdXNlIHRo
ZXJlIGlzIHNvbWVvbmUgd2FpdGluZyB0bwo+IHJlYWQgd3JpdGUgZnJvbSB0aGUgaW1wb3J0ZWQg
YnVmZmVyIG9uIGRldmljZSBCIGFuZCBoZSBvbmx5IHdhaXRzIGZvcgo+IHRoZSBzX2ZlbmNlLT5m
aW5pc2hlZCBvZiBkZXZpY2UgQiB3ZSBzaWduYWxlZAo+IGluIGRybV9zY2hlZF9lbnRpdHlfa2ls
bF9qb2JzID8KCkV4YWN0bHkgdGhhdCwgeWVzLgoKSW4gb3RoZXIgd29yZHMgd2hlbiB5b3UgaGF2
ZSBhIGRlcGVuZGVuY3kgY2hhaW4gbGlrZSBBLT5CLT5DIHRoZW4gbWVtb3J5IAptYW5hZ2VtZW50
IG9ubHkgd2FpdHMgZm9yIEMgYmVmb3JlIGZyZWVpbmcgdXAgdGhlIG1lbW9yeSBmb3IgZXhhbXBs
ZS4KCldoZW4gQyBub3cgc2lnbmFsZWQgYmVjYXVzZSB0aGUgZGV2aWNlIGlzIGhvdC1wbHVnZ2Vk
IGJlZm9yZSBBIG9yIEIgYXJlIApmaW5pc2hlZCB0aGV5IGFyZSBlc3NlbnRpYWxseSBhY2Nlc3Np
bmcgZnJlZWQgdXAgbWVtb3J5LgoKQ2hyaXN0aWFuLgoKPgo+IEFuZHJleQo+Cj4+Pgo+Pj4KPj4+
IEkgYW0gbm90IHN1cmUgdGhpcyBwcm9ibGVtIHlvdSBkZXNjcmliZSBhYm92ZSBpcyByZWxhdGVk
IHRvIHRoaXMgcGF0Y2guCj4+Cj4+IFdlbGwgaXQgaXMga2luZCBvZiByZWxhdGVkLgo+Pgo+Pj4g
SGVyZSB3ZSBwdXJlbHkgZXhwYW5kIHRoZSBjcml0ZXJpYSBmb3Igd2hlbiBzY2hlZF9lbnRpdHkg
aXMKPj4+IGNvbnNpZGVyZWQgaWRsZSBpbiBvcmRlciB0byBwcmV2ZW50IGEgaGFuZyBvbiBkZXZp
Y2UgcmVtb3ZlLgo+Pgo+PiBBbmQgZXhhY3RseSB0aGF0IGlzIHByb2JsZW1hdGljLiBTZWUgdGhl
IGpvYnMgb24gdGhlIGVudGl0eSBuZWVkIHRvIAo+PiBjbGVhbmx5IHdhaXQgZm9yIHRoZWlyIGRl
cGVuZGVuY2llcyBiZWZvcmUgdGhleSBjYW4gYmUgY29tcGxldGVkLgo+Pgo+PiBkcm1fc2NoZWRf
ZW50aXR5X2tpbGxfam9icygpIGlzIGFsc28gbm90IGhhbmRsaW5nIHRoYXQgY29ycmVjdGx5IGF0
IAo+PiB0aGUgbW9tZW50LCB3ZSBvbmx5IHdhaXQgZm9yIHRoZSBsYXN0IHNjaGVkdWxlZCBmZW5j
ZSBidXQgbm90IGZvciB0aGUgCj4+IGRlcGVuZGVuY2llcyBvZiB0aGUgam9iLgo+Pgo+Pj4gV2Vy
ZSB5b3UgYWRkcmVzc2luZyB0aGUgcGF0Y2ggZnJvbSB5ZXN0ZXJkYXkgaW4gd2hpY2ggeW91IGNv
bW1lbnRlZAo+Pj4gdGhhdCB5b3UgZm91bmQgYSBwcm9ibGVtIHdpdGggaG93IHdlIGZpbmlzaCBm
ZW5jZXMgPyBJdCB3YXMKPj4+ICdbUEFUQ0ggdjcgMTIvMTZdIGRybS9hbWRncHU6IEZpeCBoYW5n
IG9uIGRldmljZSByZW1vdmFsLicKPj4+Cj4+PiBBbHNvLCBpbiB0aGUgcGF0Y2ggc2VyaWVzIGFz
IGl0IGlzIG5vdyB3ZSBvbmx5IHNpZ25hbCBIVyBmZW5jZXMgZm9yIHRoZQo+Pj4gZXh0cmFjdGVk
IGRldmljZSBCLCB3ZSBhcmUgbm90IHRvdWNoaW5nIGFueSBvdGhlciBmZW5jZXMuIEluIGZhY3Qg
YXMgCj4+PiB5b3UKPj4+IG1heSByZW1lbWJlciwgSSBkcm9wcGVkIGFsbCBuZXcgbG9naWMgdG8g
Zm9yY2luZyBmZW5jZSBjb21wbGV0aW9uIGluCj4+PiB0aGlzIHBhdGNoIHNlcmllcyBhbmQgb25s
eSBjYWxsIGFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbgo+Pj4gZm9yIHRoZSBI
VyBmZW5jZXMgb2YgdGhlIGV4dHJhY3RlZCBkZXZpY2UgYXMgaXQncyBkb25lIHRvZGF5IGFueXdh
eS4KPj4KPj4gU2lnbmFsaW5nIGhhcmR3YXJlIGZlbmNlcyBpcyB1bnByb2JsZW1hdGljIHNpbmNl
IHRoZXkgYXJlIGVtaXR0ZWQgCj4+IHdoZW4gdGhlIHNvZnR3YXJlIHNjaGVkdWxpbmcgaXMgYWxy
ZWFkeSBjb21wbGV0ZWQuCj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+Cj4+PiBBbmRyZXkKPj4+Cj4+
Pj4KPj4+PiBOb3Qgc3VyZSBob3cgdG8gaGFuZGxlIHRoYXQgY2FzZS4gT25lIHBvc3NpYmlsaXR5
IHdvdWxkIGJlIHRvIHdhaXQgCj4+Pj4gZm9yIGFsbCBkZXBlbmRlbmNpZXMgb2YgdW5zY2hlZHVs
ZWQgam9icyBiZWZvcmUgc2lnbmFsaW5nIHRoZWlyIAo+Pj4+IGZlbmNlcyBhcyBjYW5jZWxlZC4K
Pj4+Pgo+Pj4+IENocmlzdGlhbi4KPj4+Pgo+Pj4+IEFtIDEyLjA1LjIxIHVtIDE2OjI2IHNjaHJp
ZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4+IFByb2JsZW06IElmIHNjaGVkdWxlciBpcyBhbHJl
YWR5IHN0b3BwZWQgYnkgdGhlIHRpbWUgc2NoZWRfZW50aXR5Cj4+Pj4+IGlzIHJlbGVhc2VkIGFu
ZCBlbnRpdHkncyBqb2JfcXVldWUgbm90IGVtcHR5IEkgZW5jb3VudHJlZAo+Pj4+PiBhIGhhbmcg
aW4gZHJtX3NjaGVkX2VudGl0eV9mbHVzaC4gVGhpcyBpcyBiZWNhdXNlIAo+Pj4+PiBkcm1fc2No
ZWRfZW50aXR5X2lzX2lkbGUKPj4+Pj4gbmV2ZXIgYmVjb21lcyBmYWxzZS4KPj4+Pj4KPj4+Pj4g
Rml4OiBJbiBkcm1fc2NoZWRfZmluaSBkZXRhY2ggYWxsIHNjaGVkX2VudGl0aWVzIGZyb20gdGhl
Cj4+Pj4+IHNjaGVkdWxlcidzIHJ1biBxdWV1ZXMuIFRoaXMgd2lsbCBzYXRpc2Z5IGRybV9zY2hl
ZF9lbnRpdHlfaXNfaWRsZS4KPj4+Pj4gQWxzbyB3YWtldXAgYWxsIHRob3NlIHByb2Nlc3NlcyBz
dHVjayBpbiBzY2hlZF9lbnRpdHkgZmx1c2hpbmcKPj4+Pj4gYXMgdGhlIHNjaGVkdWxlciBtYWlu
IHRocmVhZCB3aGljaCB3YWtlcyB0aGVtIHVwIGlzIHN0b3BwZWQgYnkgbm93Lgo+Pj4+Pgo+Pj4+
PiB2MjoKPj4+Pj4gUmV2ZXJzZSBvcmRlciBvZiBkcm1fc2NoZWRfcnFfcmVtb3ZlX2VudGl0eSBh
bmQgbWFya2luZwo+Pj4+PiBzX2VudGl0eSBhcyBzdG9wcGVkIHRvIHByZXZlbnQgcmVpbnNlcmlv
biBiYWNrIHRvIHJxIGR1ZQo+Pj4+PiB0byByYWNlLgo+Pj4+Pgo+Pj4+PiB2MzoKPj4+Pj4gRHJv
cCBkcm1fc2NoZWRfcnFfcmVtb3ZlX2VudGl0eSwgb25seSBtb2RpZnkgZW50aXR5LT5zdG9wcGVk
Cj4+Pj4+IGFuZCBjaGVjayBmb3IgaXQgaW4gZHJtX3NjaGVkX2VudGl0eV9pc19pZGxlCj4+Pj4+
Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNr
eUBhbWQuY29tPgo+Pj4+PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9lbnRpdHkuYyB8wqAgMyArKy0KPj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9tYWluLmPCoMKgIHwgMjQgCj4+Pj4+ICsrKysrKysrKysrKysrKysrKysr
KysrKwo+Pj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKPj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
c2NoZWRfZW50aXR5LmMgCj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9l
bnRpdHkuYwo+Pj4+PiBpbmRleCAwMjQ5Yzc0NTAxODguLjJlOTNlODgxYjY1ZiAxMDA2NDQKPj4+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+Pj4+IEBAIC0x
MTYsNyArMTE2LDggQEAgc3RhdGljIGJvb2wgZHJtX3NjaGVkX2VudGl0eV9pc19pZGxlKHN0cnVj
dCAKPj4+Pj4gZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5KQo+Pj4+PiDCoMKgwqDCoMKgIHJtYigp
OyAvKiBmb3IgbGlzdF9lbXB0eSB0byB3b3JrIHdpdGhvdXQgbG9jayAqLwo+Pj4+PiDCoMKgwqDC
oMKgIGlmIChsaXN0X2VtcHR5KCZlbnRpdHktPmxpc3QpIHx8Cj4+Pj4+IC3CoMKgwqDCoMKgwqDC
oCBzcHNjX3F1ZXVlX2NvdW50KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0gMCkKPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIHNwc2NfcXVldWVfY291bnQoJmVudGl0eS0+am9iX3F1ZXVlKSA9PSAwIHx8Cj4+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBlbnRpdHktPnN0b3BwZWQpCj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gdHJ1ZTsKPj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyAKPj4+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4+PiBpbmRleCA4ZDEy
MTFlODcxMDEuLmEyYTk1MzY5M2I0NSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9tYWluLmMKPj4+Pj4gQEAgLTg5OCw5ICs4OTgsMzMgQEAgRVhQT1JUX1NZTUJP
TChkcm1fc2NoZWRfaW5pdCk7Cj4+Pj4+IMKgwqAgKi8KPj4+Pj4gwqAgdm9pZCBkcm1fc2NoZWRf
ZmluaShzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+Pj4+PiDCoCB7Cj4+Pj4+ICvC
oMKgwqAgc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKnNfZW50aXR5Owo+Pj4+PiArwqDCoMKgIGlu
dCBpOwo+Pj4+PiArCj4+Pj4+IMKgwqDCoMKgwqAgaWYgKHNjaGVkLT50aHJlYWQpCj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBrdGhyZWFkX3N0b3Aoc2NoZWQtPnRocmVhZCk7Cj4+Pj4+ICvCoMKg
wqAgZm9yIChpID0gRFJNX1NDSEVEX1BSSU9SSVRZX0NPVU5UIC0gMTsgaSA+PSAKPj4+Pj4gRFJN
X1NDSEVEX1BSSU9SSVRZX01JTjsgaS0tKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
ZHJtX3NjaGVkX3JxICpycSA9ICZzY2hlZC0+c2NoZWRfcnFbaV07Cj4+Pj4+ICsKPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGlmICghcnEpCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRp
bnVlOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX2xvY2soJnJxLT5sb2NrKTsK
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnkoc19lbnRpdHksICZycS0+
ZW50aXRpZXMsIGxpc3QpCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBQcmV2ZW50cyByZWluc2VydGlvbiBhbmQgbWFya3Mg
am9iX3F1ZXVlIGFzIGlkbGUsCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpdCB3
aWxsIHJlbW92ZWQgZnJvbSBycSBpbiBkcm1fc2NoZWRfZW50aXR5X2ZpbmkKPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIGV2ZW50dWFsbHkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqLwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzX2VudGl0eS0+c3RvcHBl
ZCA9IHRydWU7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmcnEtPmxvY2spOwo+
Pj4+PiArCj4+Pj4+ICvCoMKgwqAgfQo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgLyogV2FrZXVwIGV2
ZXJ5b25lIHN0dWNrIGluIGRybV9zY2hlZF9lbnRpdHlfZmx1c2ggZm9yIHRoaXMgCj4+Pj4+IHNj
aGVkdWxlciAqLwo+Pj4+PiArwqDCoMKgIHdha2VfdXBfYWxsKCZzY2hlZC0+am9iX3NjaGVkdWxl
ZCk7Cj4+Pj4+ICsKPj4+Pj4gwqDCoMKgwqDCoCAvKiBDb25maXJtIG5vIHdvcmsgbGVmdCBiZWhp
bmQgYWNjZXNzaW5nIGRldmljZSBzdHJ1Y3R1cmVzICovCj4+Pj4+IMKgwqDCoMKgwqAgY2FuY2Vs
X2RlbGF5ZWRfd29ya19zeW5jKCZzY2hlZC0+d29ya190ZHIpOwo+Pj4+Cj4+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
