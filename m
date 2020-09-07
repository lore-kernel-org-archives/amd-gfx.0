Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C137C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2EB208C7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rj7O4Mo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2EB208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4C76E3C6;
	Mon,  7 Sep 2020 08:24:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42AC16E3C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 08:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJVcyyfwt5uWLheJQ8FMc7GuNNeOw6tj7fjSIH9+z1BrZGFBlAIHeH4fXeCi+GqIkNIqGfFIOiIg/hljNGBKHsHMcHJAv/K1+1mGnIhsLFUNElu2zvsBQHfLnZ80HWSaozMiw9XNbs7QYq5WXxHdykUeA1E+AhshZYIcBLnBvdu3Iethi/UC9fuuB1oz8YPa617r6hG8Ho3J8aSlR1WwmS4rmAs7vKW8sC9f/KX3O3AMjc4y5FDnYTYDXuO61znxU1hpptqMxiT4oRyDEjI9Xjds6nkX+mDRrVZCNR4q7/Q4esPl0Yvpmf7lh1902lctkFCEBbI5T+zZlVaTo+6pUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqsT9fjWlmhqj6P9kFVY7Xb/OGIx1XA24acGand4rAA=;
 b=oOWiVWJmYw03hbGwF12Pmuqy42fK70252Oa4E/SHgjj85eYhqf7CuEAP5MU1A4t67i8f4ydxyPgqBxZjcdPVIeHZqewPEYzHH20d0ByHHKImRZN6jxbL1EVR6lakjpS6WGEbtl6Afv1Aw0W8OxstP8gE3zua1Z/mPCzd11udHNgAmjYH82OL5gyJYtTXVJUgbCeajUdQrjU+5Prg4HBhkc5bhyfRJhYWqFqdA/1wjx3cESaAvylg8OEzN10Cv88GWBKYV7GoCClFa2rMh8hGOWuVlKVNX1U+HRkfkHE4gWgQKuOxSrUO2zRJw/ivIec9aaUkeq0r4+BX7hak4qkADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqsT9fjWlmhqj6P9kFVY7Xb/OGIx1XA24acGand4rAA=;
 b=Rj7O4Mo71YWpAlGqdVDbJuVfCDCyfTh6fkOd/e/KsiAIBLr0pDu+28fN/oOWqdg+SAGOTdVbR1+IxdQE+kbIMytG3dsWxjO1wYgOHfzA9fxL9duy3qp7VwVvg02CzLLtwCFmHHelcoZV/UpQ8viz26L40xg3DAhWBKRxt1vfp18=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 08:24:35 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 08:24:35 +0000
Subject: Re: [PATCH] radeon: Use only a single work queue thread for crt
To: Dave Airlie <airlied@gmail.com>
References: <20190803000908.5310-1-andi@firstfloor.org>
 <47558836-612d-75e3-c4a8-7b8baf53036d@gmail.com>
 <CAPM=9tw4Md4j95+Zk6LbCZkyj6AFPZSuXacpY3MEabgu20S6Lw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3cfac48c-700e-24ce-7677-ca93f7589509@amd.com>
Date: Mon, 7 Sep 2020 10:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAPM=9tw4Md4j95+Zk6LbCZkyj6AFPZSuXacpY3MEabgu20S6Lw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 08:24:34 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10ca0234-8b34-46e2-fe50-08d85307741a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4224647E998FEF3A4715294783280@MN2PR12MB4224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3BgOz6ez9sQIgNAbWr7jgDi/xdfKbd9k9JTUv7PmYMtltpv6uyEa1OoYsZT43efxSfpEctkcJJli/rnD8zKKGIcKIvgU/wSVYfGPFdd4sQ3za6zN0eKIQNTFuwgH3QpyR3Nk4caltQbzJFNMKtxAnSXRw9jEVrXbOpbzXldoAws9R6E7AEJG4S4jjuIpwBItWdWR9OLuQ7ZPqT7krk8a0iflvkDSazhGB9RzKav1iZZpT73gCx8O1uh4JFhg9yMPwK2GD/3IQ2zADROVGenevkMJpBRs7ajHWDm79OPmmEl/MTyjExmqTbnP3DKSRqW8S3QNABGHPvwHvDTJBHJBp9hyCA/xt5ySnQFFYz+fWJ0yfMubvF2roMVoGoPCb0H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(31696002)(2616005)(6486002)(4744005)(66556008)(66476007)(66946007)(5660300002)(36756003)(83380400001)(16526019)(31686004)(186003)(6916009)(86362001)(2906002)(54906003)(6666004)(478600001)(4326008)(52116002)(316002)(8936002)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: o5YxOhR2SKA+av2fURIm7jBHAidaqKIGq0/YNxmqVIzp5y9Jf1P3qCFUjEJ1WHW1zWDMEU/CeE2Hjf+pgFb7msrzNaO25dSod+7UoK0wgalmyFSz/Rqre8cvtqnv6t0YG5pa2QAVQqaBMCSCgIB80xxp6D1OCGgcVVYmZ23/pEeU2BKoHC0IhnCBm+SDi2AGihV7653mpnUO5bz6JAeHeuR+1nxyOwm+/OBNfDfxxIg2xbG5BKVXykOUV5ZU+wAKuDxSJ36ydXYpukmUTq3Bdbr5VayI6PNtH3OuKBh4VfMZISzS/kti8XK2z5inARt5MnoubkZEqNlEURo3SjRhJcBd1UM2kTphCybQos3HEcPN9TtyvontsB5ym9mGwuVJAnRir2bOm2dwb+MhDNEMyUTWleRc16Z/Ylr6+REdKVNCmsPGR/j4DopJ4L1urrk2M2ABdox/IClsXgfxC90uBtF0UNgRbGWzU4+tpO1MIu8yHW+UF14cMcN9ycZeAMhpkr1Ery5P3UpdT8F5Kxd1j4Vo4UlPlOxnnfxuulIHkaLdZU/z9uwM1vOM7mwCmhI06ELYG45lppAJws3Qp471ScP9dTsNfjLCYurbgPGCcCPSQzB216/UfzTD6YxaQmZLLQKFGNxRLfVhSiNzDB4q4tUKCf5ARFmWKTsP0fTRjqDN0WNmarJC58ay+cpZv0lhWTLi4txDyLutoNKpMgiUvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca0234-8b34-46e2-fe50-08d85307741a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 08:24:35.2766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nAH/usPp4fV5DdRHpeHGp5mXcuGpaH881s0HCJPBLRpkrlnntf486cSPlAkVdxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDcuMDkuMjAgdW0gMDE6NDcgc2NocmllYiBEYXZlIEFpcmxpZToKPiBPbiBTdW4sIDYgU2Vw
IDIwMjAgYXQgMTg6NTQsIENocmlzdGlhbiBLw7ZuaWcKPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+IHdyb3RlOgo+PiBBbSAwMy4wOC4xOSB1bSAwMjowOSBzY2hyaWViIEFuZGkg
S2xlZW46Cj4+PiBGcm9tOiBBbmRpIEtsZWVuIDxha0BsaW51eC5pbnRlbC5jb20+Cj4+Pgo+Pj4g
SSBnb3QgdGlyZWQgb2Ygc2VlaW5nIGEgbG90IG9mIHJhZGVvbi1jcnQga2VybmVsIHRocmVhZHMg
aW4gcHMgb24gbXkKPj4+IHdvcmtzdGF0aW9uLCBvbmUgZm9yIGVhY2ggQ1BVIGFuZCBvbmUgZm9y
IGVhY2ggZGlzcGxheSwgd2hpY2ggbmV2ZXIgdXNlIGFueSBDUFUgdGltZS4KPj4+IFN1cmVseSBh
IHNpbmdsZSBrZXJuZWwgdGhyZWFkIGlzIGVub3VnaCB0byBoYW5kbGUgdGhlIGRpc3BsYXkuCj4+
IE5BSywgcmFkZW9uIGJsb2NrcyBpbnNpZGUgdGhlIGtlcm5lbCB0aHJlYWQgYW5kIHRob3NlIG5l
ZWQgdG8gcnVuIGluCj4+IHBhcmFsbGVsIG9yIG90aGVyd2lzZSB0aGUgaGFyZHdhcmUgY2FuIGhh
bmcuCj4gRG8gd2UgbmVlZCBvbmUgcGVyIGNwdT8gb3IgaXMgb25lIHBlciBjcnRjIGVub3VnaD8K
Ck9uZSBwZXIgQ1JUQyBpcyBlbm91Z2gsIGJ1dCB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gc291bmRz
IGxpa2UgaXQgY3JlYXRlcyAKb25seSBhIGdsb2JhbCBvbmUuCgpDaHJpc3RpYW4uCgo+Cj4gRGF2
ZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
